/*
 * cpu.v
 *
 * This module defines a 6502-compatible CPU with 65832 enhancements for
 * larger registers and wider buses (address and data). It is compatible
 * in terms of instruction opcodes and register access, but not in
 * terms of bus or pin access, because the platform is entirely different.
 *
 * Copyright (C) 2024 Curtis Whitley
 * License: APACHE
 */

`default_nettype none

`include "cpu_inc/reg_sizes.v"

module cpu (
    input   logic i_rst,
    input   logic i_clk,
    output  reg   o_bus_clk,
    output  reg   o_bus_we,
    output  reg `VW o_bus_addr,
    output  reg `VW o_bus_data,
    input   logic `VW i_bus_data,
    input   logic i_bus_data_ready,
    output  logic [3:0] o_cycle,
    output  logic [15:0] o_pc,
    output  logic [15:0] o_ad,
    output  logic [7:0] o_cb,
    output  logic [7:0] o_rb,
    output  logic [7:0] o_a,
    output  logic [7:0] o_x,
    output  logic [7:0] o_y
);

`include "cpu_inc/constants.v"
`include "cpu_inc/reg_6502.v"
`include "cpu_inc/reg_65832.v"
`include "cpu_inc/reg_work.v"

`include "cpu_inc/adc.v"
`include "cpu_inc/add.v"
`include "cpu_inc/and.v"
`include "cpu_inc/asl.v"
`include "cpu_inc/dec.v"
`include "cpu_inc/eor.v"
`include "cpu_inc/inc.v"
`include "cpu_inc/lsr.v"
`include "cpu_inc/neg.v"
`include "cpu_inc/not.v"
`include "cpu_inc/or.v"
`include "cpu_inc/rol.v"
`include "cpu_inc/ror.v"
`include "cpu_inc/sbc.v"
`include "cpu_inc/sext.v"
`include "cpu_inc/sub.v"
`include "cpu_inc/uext.v"

//-------------------------------------------------------------------------------

`LOGIC_32 offset_address; assign offset_address = reg_address + reg_offset;

//-------------------------------------------------------------------------------

`define END_INSTR           reg_cycle <= 0
`define END_OPER(op)        op <= 0
`define END_OPER_INSTR(op)  `END_OPER(op); `END_INSTR
`define STORE_AFTER_OP(op)  `END_OPER(op); store_to_address <= 1
`define STORE_DST           store_to_address <= 1

reg [7:0] bram [0:65535];

initial $readmemh("../ram/ram.bits", bram);

logic initiate_read_mem;
assign initiate_read_mem =
    ~transfer_in_progress &
    load_from_address &
    ~o_bus_clk &
    ~i_bus_data_ready;

logic reading_mem;
assign reading_mem =
    transfer_in_progress &
    load_from_address &
    o_bus_clk &
    ~i_bus_data_ready;

logic initiate_write_mem;
assign initiate_write_mem =
    ~transfer_in_progress &
    store_to_address &
    ~o_bus_clk;

logic writing_mem;
assign writing_mem =
    transfer_in_progress &
    store_to_address &
    o_bus_clk;

assign o_cycle = reg_cycle;
assign o_pc = reg_pc;
assign o_ad = reg_address;
assign o_cb = reg_code_byte;
assign o_rb = reg_data_byte;
assign o_a = `A;
assign o_x = `X;
assign o_y = `Y;

logic push_edst0;
logic push_edst1;

always @(posedge i_clk) begin
    if (i_rst) begin
        o_bus_clk <= 0;
        o_bus_we <= 0;
        o_bus_addr <= 0;
        o_bus_data <= 0;
    end else begin
        if (load_from_address) begin
            if (initiate_read_mem) begin
                o_bus_clk <= 1;
                o_bus_we <= 0;
                o_bus_addr <= offset_address;
            end else if (o_bus_clk && i_bus_data_ready) begin
                o_bus_clk <= 0;
            end
        end else if (store_to_address) begin
            if (initiate_write_mem) begin
                o_bus_clk <= 1;
                o_bus_we <= 1;
                if (push_edst1) begin
                    o_bus_addr <= `SP;
                    o_bus_data <= `eDST1;
                end else if (push_edst0) begin
                    o_bus_addr <= `SP;
                    o_bus_data <= `eDST0;
                end else begin
                    o_bus_addr <= offset_address;
                    o_bus_data <= {`ZERO_24, `DST};
                end
            end begin
                o_bus_clk <= 0;
            end
        end
    end
end

`LOGIC_32 delay;


always @(posedge i_rst or posedge i_clk) begin
    integer i;

    if (i_rst) begin
        `include "cpu_inc/reset.v"
    end else if (push_edst1) begin
        push_edst1 <= 0;
        push_edst0 <= 1;
    end else if (push_edst0) begin
        push_edst0 <= 0;
        `END_INSTR;
    end else if (~transfer_in_progress & (load_from_address | store_to_address)) begin
        transfer_in_progress <= 1;
    end else if (transfer_in_progress) begin
        if (~o_bus_clk) begin
            load_from_address <= 0;
            store_to_address <= 0;
            transfer_in_progress <= 0;
            `END_INSTR;
        end
    end else if (delay < 5000000) begin
        delay <= delay + 1;
    end else begin
        delay <= 0;
        reg_cycle <= reg_cycle + 1; // Assume micro-instructions will continue.

        if (reg_6502) begin
            if (load_from_address) begin
                load_from_address <= 0;
                `include "6502/post_read.v"
            end else begin
                case (reg_cycle)
                    0: begin
                        `include "6502/cycle_0.v"
                        end
                    1: begin
                        `include "6502/cycle_1.v"
                        end
                    2: begin
                        `include "6502/cycle_2.v"
                        end
                    3: begin
                        `include "6502/cycle_3.v"
                        end
                    4: begin
                        `include "6502/cycle_4.v"
                        end
                    5: begin
                        `include "6502/cycle_5.v"
                        end
                    6: begin
                        `include "6502/cycle_6.v"
                        end
                    7: begin
                        `include "6502/cycle_7.v"
                        end
                endcase
            end
        end else begin // 65832
            case (reg_cycle)
                0: begin
                    `include "65832/cycle_0.v"
                    end
                1: begin
                    `include "65832/cycle_1.v"
                    end
                2: begin
                    `include "65832/cycle_2.v"
                    end
                3: begin
                    `include "65832/cycle_3.v"
                    end
                4: begin
                    `include "65832/cycle_4.v"
                    end
                5: begin
                    `include "65832/cycle_5.v"
                    end
            endcase
        end
    end
end

endmodule
