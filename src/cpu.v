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
    input   logic i_cpu_clk,
    input   logic i_bram_clk,
    output  reg   o_bus_clk,
    output  reg   o_bus_we,
    output  reg `VW o_bus_addr,
    output  reg `VW o_bus_data,
    input   logic `VW i_bus_data,
    input   logic i_bus_data_ready,
    output  logic [3:0] o_cycle,
    output  logic [15:0] o_pc,
    output  logic [15:0] o_sp,
    output  logic [31:0] o_ad,
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

//`define END_INSTR           reg_cycle <= 0
//`define END_OPER(op)        op <= 0
//`define END_OPER_INSTR(op)  `END_OPER(op); `END_INSTR
//`define STORE_AFTER_OP(op)  `END_OPER(op); store_to_address <= 1
//`define STORE_DST           store_to_address <= 1

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
assign o_sp = reg_sp;
assign o_ad = reg_address;
assign o_cb = reg_code_byte;
assign o_db = reg_data_byte;
assign o_a = {op_08_PHP,op_4C_JMP,op_JMP,am_ABS_a,cycle_3_6502,cycle_2_6502,cycle_1_6502,cycle_0_6502};//`A;
assign o_x = reg_bram_doa_r;//`X;
assign o_y = reg_bram_dob_r;//`Y;

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

endmodule
