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
    input   wire i_rst,
    input   wire i_cpu_clk,
    input   wire i_bram_clk,
    output  reg   o_bus_clk,
    output  reg   o_bus_we,
    output  reg `VW o_bus_addr,
    output  reg `VW o_bus_data,
    input   wire `VW i_bus_data,
    input   wire i_bus_data_ready,
    output  wire [3:0] o_cycle,
    output  wire [15:0] o_pc,
    output  wire [15:0] o_sp,
    output  wire [31:0] o_ad,
    output  wire [7:0] o_cb,
    output  wire [7:0] o_db,
    output  wire [7:0] o_a,
    output  wire [7:0] o_x,
    output  wire [7:0] o_y
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

`wire_32 offset_address; assign offset_address = reg_address + reg_offset;

//-------------------------------------------------------------------------------

ram_64kb ram_64kb_inst (
	.wea(reg_bram_wea),
	.web(reg_bram_web),
	.clka(i_bram_clk),
	.clkb(i_bram_clk),
	.dia(reg_bram_dia_w),
	.dib(reg_bram_dib_w),
	.addra(`PC),
	.addrb(reg_bram_addrb),
	.doa(reg_bram_doa_r),
	.dob(reg_bram_dob_r)
);
reg [3:0] reg_bram_start;

assign o_cycle = reg_cycle;
assign o_pc = reg_pc;
assign o_sp = (bus_busy ? 16'hBBBB : o_bus_addr[15:0]);//reg_sp;
assign o_ad = reg_address;
assign o_cb = reg_code_byte;
assign o_db = reg_data_byte;
assign o_a = reg_a;
assign o_x = reg_x;
assign o_y = reg_y;

`include "reg_6502/6502.v"
`include "reg_6502/a.v"
`include "reg_6502/pc.v"
`include "reg_6502/sp.v"
`include "reg_6502/status.v"
`include "reg_6502/x.v"
`include "reg_6502/y.v"

`include "reg_65832/65832.v"

`include "reg_work/bram_64_kb.v"
`include "reg_work/reg_cycle.v"
`include "reg_work/reg_ind_address.v"
`include "reg_work/reg_offset.v"
`include "reg_work/reg_which.v"
`include "reg_work/store_to_address.v"


`wire_32 delay;
assign delaying = (delay != 0);
localparam BIG_DELAY = 100_000_000;

always @(posedge i_cpu_clk or posedge i_rst) begin
    if (i_rst) begin
        delay <= BIG_DELAY;
        reg_cycle <= 1; // Force JMP via Reset vector
        reg_bram_start <= 0;
        reg_bram_wea <= 0;
        reg_bram_dia_w <= 0;
        reg_bram_web <= 0;
        reg_bram_dib_w <= 0;
        reg_bram_addrb <= 16'h0200;
        `EADDR <= 32'h99887766;
        reg_code_byte <= 8'h4C; // JMP absolute (sets op_4C_JMP and op_JMP)
        reg_data_byte <= 8'hDD;
        reg_src_data <= 8'hBB;
        `A <= `ZERO_8;
        `eA <= `ZERO_32;
        `X <= `ZERO_8;
        `eX <= `ZERO_32;
        `Y <= `ZERO_8;
        `eY <= `ZERO_32;
        `SP <= `RESET_SP_ADDRESS;
        `eSP <= `ZERO_32;
    end else if (delaying) begin
        delay <= delay - 1;
    end else begin
        delay <= BIG_DELAY;
        reg_cycle <= reg_cycle + 1;

        if (cycle_0) begin
            reg_code_byte <= reg_bram_doa_r;
        end else if (cycle_1) begin
            reg_code_byte_1 <= reg_bram_doa_r;
        end else if (cycle_2) begin
            reg_code_byte_2 <= reg_bram_doa_r;
        end

        `include "am_6502/am_ABS_a.v"
        `include "am_6502/am_ACC_A.v"
        `include "am_6502/am_AIA_A.v"
        `include "am_6502/am_AIIX_A_X.v"
        `include "am_6502/am_AIX_a_x.v"
        `include "am_6502/am_AIY_a_y.v"
        `include "am_6502/am_IMM_m.v"
        `include "am_6502/am_IMP_m.v"
        `include "am_6502/am_PCR_r.v"
        `include "am_6502/am_STK_s.v"
        `include "am_6502/am_TXT.v"
        `include "am_6502/am_ZIIX_ZP_X.v"
        `include "am_6502/am_ZIIY_ZP_y.v"
        `include "am_6502/am_ZIX_zp_x.v"
        `include "am_6502/am_ZIY_zp_y.v"
        `include "am_6502/am_ZPG_zp.v"
        `include "am_6502/am_ZPI_ZP.v"
    end
end

endmodule
