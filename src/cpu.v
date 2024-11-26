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
    output  logic [15:0] o_sp,
    output  logic [15:0] o_ad,
    output  logic [7:0] o_cb,
    output  logic [7:0] o_db,
    output  logic [7:0] o_a,
    output  logic [7:0] o_x,
    output  logic [7:0] o_y
);

reg reg_bram_wea;
reg reg_bram_web;
reg `VB reg_bram_dia_w;
reg `VB reg_bram_dib_w;
reg `VHW reg_bram_addrb;
wire `VB reg_bram_doa_r;
wire `VB reg_bram_dob_r;

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

/*
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
*/

ram_64kb ram_64kb_inst (
	.wea(reg_bram_wea),
	.web(reg_bram_web),
	.clka(i_clk),
	.clkb(i_clk),
	.dia(reg_bram_dia_w),
	.dib(reg_bram_dib_w),
	.addra(`PC),
	.addrb(reg_bram_addrb),
	.doa(reg_bram_doa_r),
	.dob(reg_bram_dob_r)
);

assign o_cycle = 0;//reg_cycle;
assign o_pc = 0;//reg_pc;
assign o_sp = 0;//reg_sp;
assign o_ad = 0;//`ADDR;
assign o_cb = 0;//reg_code_byte;
assign o_db = 0;//reg_data_byte;
assign o_a = 0;//`A;
assign o_x = 0;//`X;
assign o_y = 0;//`Y;
/*
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
            end else begin
                o_bus_clk <= 0;
            end
        end
    end
end
*/

`include "reg_6502/6502.v"
`include "reg_6502/a.v"
`include "reg_6502/pc.v"
`include "reg_6502/sp.v"
`include "reg_6502/status.v"
`include "reg_6502/x.v"
`include "reg_6502/y.v"

`include "reg_65832/65832.v"

//`include "reg_work/load_from_address.v"
//`include "reg_work/push_edst.v"
`include "reg_work/bram_64_kb.v"
`include "reg_work/reg_cycle.v"
`include "reg_work/reg_ind_address.v"
`include "reg_work/reg_offset.v"
`include "reg_work/reg_which.v"
`include "reg_work/store_to_address.v"

`include "reg_op_flag/op_ADC.v"
`include "reg_op_flag/op_ADD.v"
`include "reg_op_flag/op_AND.v"
`include "reg_op_flag/op_ASL.v"
`include "reg_op_flag/op_BBR.v"
`include "reg_op_flag/op_BBS.v"
`include "reg_op_flag/op_BIT.v"
`include "reg_op_flag/op_BRANCH.v"
`include "reg_op_flag/op_BRK.v"
`include "reg_op_flag/op_CMP.v"
`include "reg_op_flag/op_CPX.v"
`include "reg_op_flag/op_CPY.v"
`include "reg_op_flag/op_DEC.v"
`include "reg_op_flag/op_EOR.v"
`include "reg_op_flag/op_INC.v"
`include "reg_op_flag/op_JMP.v"
`include "reg_op_flag/op_JSR.v"
`include "reg_op_flag/op_LDA.v"
`include "reg_op_flag/op_LDX.v"
`include "reg_op_flag/op_LDY.v"
`include "reg_op_flag/op_LSR.v"
`include "reg_op_flag/op_ORA.v"
`include "reg_op_flag/op_PHA.v"
`include "reg_op_flag/op_PHP.v"
`include "reg_op_flag/op_PHX.v"
`include "reg_op_flag/op_PHY.v"
`include "reg_op_flag/op_PLA.v"
`include "reg_op_flag/op_PLP.v"
`include "reg_op_flag/op_PLX.v"
`include "reg_op_flag/op_PLY.v"
`include "reg_op_flag/op_RMB.v"
`include "reg_op_flag/op_ROL.v"
`include "reg_op_flag/op_ROR.v"
`include "reg_op_flag/op_RTI.v"
`include "reg_op_flag/op_RTS.v"
`include "reg_op_flag/op_SBC.v"
`include "reg_op_flag/op_SMB.v"
`include "reg_op_flag/op_STA.v"
`include "reg_op_flag/op_STP.v"
`include "reg_op_flag/op_STX.v"
`include "reg_op_flag/op_STY.v"
`include "reg_op_flag/op_STZ.v"
`include "reg_op_flag/op_SUB.v"
`include "reg_op_flag/op_TRB.v"
`include "reg_op_flag/op_TSB.v"
`include "reg_op_flag/op_WAI.v"

`include "reg_am_flag/am_ABS_a.v"
`include "reg_am_flag/am_ACC_A.v"
`include "reg_am_flag/am_AIA_A.v"
`include "reg_am_flag/am_AIIX_A_X.v"
`include "reg_am_flag/am_AIX_a_x.v"
`include "reg_am_flag/am_AIY_a_y.v"
`include "reg_am_flag/am_IMM_m.v"
`include "reg_am_flag/am_PCR_r.v"
`include "reg_am_flag/am_STK_s.v"
`include "reg_am_flag/am_ZIIX_ZP_X.v"
`include "reg_am_flag/am_ZIIY_ZP_y.v"
`include "reg_am_flag/am_ZIX_zp_x.v"
`include "reg_am_flag/am_ZIY_zp_y.v"
`include "reg_am_flag/am_ZPG_zp.v"
`include "reg_am_flag/am_ZPI_ZP.v"

always @(posedge i_rst or posedge i_clk) begin
    integer i;

    if (i_rst) begin
        `include "cpu_inc/reset.v"
/*
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
    end else begin
        if (load_from_address) begin
            load_from_address <= 0;
            if (reg_6502) begin
                `include "6502/post_read.v"
            end else begin // 65832
                `include "65832/post_read.v"
            end
        end*/
    end
end

endmodule
