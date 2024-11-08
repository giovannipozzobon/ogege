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
        delay <= 0;

        reg_6502 <= 1;
        `PC <= `RESET_PC_ADDRESS + 2;
        `SP <= `RESET_SP_ADDRESS;
        `P <= `RESET_STATUS_BITS;
        `X <= `ZERO_8;
        `Y <= `ZERO_8;

        reg_65832 <= 0;
        `ePC <= `ZERO_32;
        `eSP <= `ZERO_32;
        `eP <= `RESET_STATUS_BITS;
        `eX <= `ZERO_32;
        `eY <= `ZERO_32;

        reg_cycle <= 2; // Force JMP via Reset vector
        reg_which <= 0;
        reg_address <= 0;
        reg_src_data <= 0;
        reg_dst_data <= 0;
        reg_code_byte <= 8'hCC;
        reg_data_byte <= 8'hDD;

        am_ABS_a <= 1; // Force JMP via Reset vector
        am_ACC_A <= 0;
        am_AIA_A <= 0;
        am_AIIX_A_X <= 0;
        am_AIX_a_x <= 0;
        am_AIY_a_y <= 0;
        am_IMM_m <= 0;
        am_PCR_r <= 0;
        am_STK_s <= 0;
        am_ZIIX_ZP_X <= 0;
        am_ZIIY_ZP_y <= 0;
        am_ZIX_zp_x <= 0;
        am_ZIY_zp_y <= 0;
        am_ZPG_zp <= 0;
        am_ZPI_ZP <= 0;

        ame_ABS_a <= 0;
        ame_AIA_A <= 0;
        ame_AIIX_A_X <= 0;
        ame_AIIY_A_y <= 0;
        ame_AIX_a_x <= 0;
        ame_AIY_a_y <= 0;
        ame_STK_s <= 0;

        load_from_address <= 1;
        store_to_address <= 0;
        transfer_in_progress <= 0;
        push_edst0 <= 0;
        push_edst1 <= 1;

        op_ADC <= 0;
        op_ADD <= 0;
        op_AND <= 0;
        op_ASL <= 0;
        op_BBR <= 0;
        op_BRANCH <= 0;
        op_BBS <= 0;
        op_BIT <= 0;
        op_BRK <= 0;
        op_CMP <= 0;
        op_CPX <= 0;
        op_CPY <= 0;
        op_DEC <= 0;
        op_EOR <= 0;
        op_INC <= 0;
        op_JMP <= 1; // Force JMP via Reset vector
        op_JSR <= 0;
        op_LDA <= 0;
        op_LDX <= 0;
        op_LDY <= 0;
        op_LSR <= 0;
        op_ORA <= 0;
        op_PHA <= 0;
        op_PHP <= 0;
        op_PHX <= 0;
        op_PHY <= 0;
        op_PLA <= 0;
        op_PLP <= 0;
        op_PLX <= 0;
        op_PLY <= 0;
        op_RMB <= 0;
        op_ROL <= 0;
        op_ROR <= 0;
        op_RTI <= 0;
        op_RTS <= 0;
        op_SBC <= 0;
        op_SMB <= 0;
        op_STA <= 0;
        op_STP <= 0;
        op_STX <= 0;
        op_STY <= 0;
        op_STZ <= 0;
        op_SUB <= 0;
        op_TRB <= 0;
        op_TSB <= 0;
        op_WAI <= 0;

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

                if (op_ADC) begin
                    `A <= adc_a_var;
                    `N <= adc_a_var_n;
                    `V <= adc_a_var_v;
                    `Z <= adc_a_var_z;
                    `C <= adc_a_var_c;
                    `END_OPER_INSTR(op_ADC);
                end else if (op_AND) begin
                    `A <= and_a_var;
                    `N <= and_a_var_n;
                    `Z <= and_a_var_z;
                    `END_OPER_INSTR(op_AND);
                end else if (op_ASL) begin
                    `DST <= reg_data_byte;
                    `N <= asl_var_n;
                    `Z <= asl_var_z;
                    `C <= asl_var_c;
                    `STORE_AFTER_OP(op_ASL);
                end else if (op_BIT) begin
                    `N <= and_a_var_n;
                    `V <= and_a_var_v;
                    `Z <= and_a_var_z;
                    `END_OPER_INSTR(op_BIT);
                end else if (op_CMP) begin
                    `N <= sub_a_var_n;
                    `V <= sub_a_var_v;
                    `Z <= sub_a_var_z;
                    `C <= sub_a_var_c;
                    `END_OPER_INSTR(op_CMP);
                end else if (op_CPX) begin
                    `N <= sub_x_var_n;
                    `V <= sub_x_var_v;
                    `Z <= sub_x_var_z;
                    `C <= sub_x_var_c;
                    `END_OPER_INSTR(op_CPX);
                end else if (op_CPY) begin
                    `N <= sub_y_var_n;
                    `V <= sub_y_var_v;
                    `Z <= sub_y_var_z;
                    `C <= sub_y_var_c;
                    `END_OPER_INSTR(op_CPY);
                end else if (op_DEC) begin
                    `DST <= reg_data_byte;
                    `N <= dec_var_n;
                    `Z <= dec_var_z;
                    `STORE_AFTER_OP(op_DEC);
                end else if (op_EOR) begin
                    `A <= eor_a_var;
                    `N <= eor_a_var_n;
                    `Z <= eor_a_var_z;
                    `END_OPER_INSTR(op_EOR);
                end else if (op_INC) begin
                    `DST <= reg_data_byte;
                    `N <= inc_var_n;
                    `Z <= inc_var_z;
                    `STORE_AFTER_OP(op_INC);
                end else if (op_LDA | op_PLA) begin
                    `A <= reg_data_byte;
                    `N <= i_bus_data[7];
                    `Z <= (reg_data_byte == `ZERO_8) ? 1 : 0;
                    `END_OPER(op_PLA);
                    `END_OPER_INSTR(op_LDA);
                end else if (op_LDX | op_PLX) begin
                    `X <= reg_data_byte;
                    `N <= i_bus_data[7];
                    `Z <= (reg_data_byte == `ZERO_8) ? 1 : 0;
                    `END_OPER(op_PLX);
                    `END_OPER_INSTR(op_LDX);
                end else if (op_LDY | op_PLY) begin
                    `Y <= reg_data_byte;
                    `N <= i_bus_data[7];
                    `Z <= (reg_data_byte == `ZERO_8) ? 1 : 0;
                    `END_OPER(op_PLY);
                    `END_OPER_INSTR(op_LDY);
                end else if (op_PLP) begin
                    `P <= reg_data_byte;
                    `END_OPER_INSTR(op_PLP);
                end else if (op_LSR) begin
                    `DST <= reg_data_byte;
                    `N <= lsr_var_n;
                    `Z <= lsr_var_z;
                    `C <= lsr_var_c;
                    `STORE_AFTER_OP(op_LSR);
                end else if (op_ORA) begin
                    `A <= or_a_var;
                    `N <= or_a_var_n;
                    `Z <= or_a_var_z;
                    `END_OPER_INSTR(op_ORA);
                end else if (op_RMB) begin
                    `DST <= reg_data_byte &(~reg_which);
                    `STORE_AFTER_OP(op_RMB);
                end else if (op_ROL) begin
                    `DST <= reg_data_byte;
                    `N <= rol_var_n;
                    `Z <= rol_var_z;
                    `C <= rol_var_c;
                    `STORE_AFTER_OP(op_ROL);
                end else if (op_ROR) begin
                    `DST <= reg_data_byte;
                    `N <= ror_var_n;
                    `Z <= ror_var_z;
                    `C <= ror_var_c;
                    `STORE_AFTER_OP(op_ROR);
                end else if (op_SBC) begin
                    `A <= sbc_a_var;
                    `C <= sbc_a_var_c;
                    `V <= sbc_a_var_v;
                    `N <= sbc_a_var_n;
                    `Z <= sbc_a_var_z;
                    `END_OPER_INSTR(op_SBC);
                end else if (op_SMB) begin
                    `DST <= reg_data_byte | reg_which;
                    `STORE_AFTER_OP(op_RMB);
                end else if (op_SUB) begin
                    `A <= sub_a_var;
                    `N <= sub_a_var_n;
                    `V <= sub_a_var_v;
                    `Z <= sub_a_var_z;
                    `C <= sub_a_var_c;
                    `END_OPER_INSTR(op_SUB);
                end else if (op_TRB) begin
                    `Z <= and_a_var_z;
                    `DST <= and_not_a_var;
                    `STORE_AFTER_OP(op_TRB);
                end else if (op_TSB) begin
                    `Z <= and_a_var_z;
                    `DST <= or_a_var;
                    `STORE_AFTER_OP(op_TSB);
                end
            end else begin
                case (reg_cycle)
                    0: begin // 6502 cycle 0
                            // Fetch instruction
                            reg_code_byte <= bram[`PC];
                            `PC <= inc_pc;
                        end
                    1: begin // 6502 cycle 1
                            case (reg_code_byte)
                                8'h00: begin
                                        op_BRK <= 1;
                                        am_STK_s <= 1;
                                    end

                                8'h01: begin
                                        op_ORA <= 1;
                                        am_ZIIX_ZP_X <= 1;
                                    end

                                8'h02: begin
                                        op_ADD <= 1;
                                        am_ZIIX_ZP_X <= 1;
                                    end

                                8'h03: begin
                                        op_SUB <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'h04: begin
                                        op_TSB <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h05: begin
                                        op_ORA <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h06: begin
                                        op_ASL <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h07, 8'h17, 8'h27, 8'h37,
                                8'h47, 8'h57, 8'h67, 8'h77:
                                    begin
                                        op_RMB <= 1;
                                        am_ZPG_zp <= 1;
                                        reg_which <= (`ONE_8 << reg_code_byte[6:4]);
                                    end

                                8'h08: begin
                                        // PHP
                                        var_hw_address = dec_sp;
                                        `SP <= var_hw_address;
                                        `ADDR <= var_hw_address;
                                        `DST <= `P;
                                        `STORE_DST;
                                    end

                                8'h09: begin
                                        op_ORA <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'h0A: begin
                                        // ASL
                                        `A <= asl_a;
                                        `N <= asl_a_n;
                                        `Z <= asl_a_z;
                                        `C <= asl_a_c;
                                        `END_INSTR;
                                    end

                                8'h0C: begin
                                        op_TSB <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h0D: begin
                                        op_ORA <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h0E: begin
                                        op_ASL <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h0F, 8'h1F, 8'h2F, 8'h3F,
                                8'h4F, 8'h5F, 8'h6F, 8'h7F:
                                    begin
                                        op_BBR <= 1;
                                        am_PCR_r <= 1;
                                        reg_which <= (`ONE_8 << reg_code_byte[6:4]);
                                    end

                                8'h10: begin
                                        if (`NN) begin // BPL
                                            op_BRANCH <= 1;
                                            am_PCR_r <= 1;
                                        end else begin
                                            `PC <= add_pc_2;
                                            `END_INSTR;
                                        end
                                    end

                                8'h11: begin
                                        op_ORA <= 1;
                                        am_ZIIY_ZP_y <= 1;
                                    end

                                8'h12: begin
                                        op_ORA <= 1;
                                        am_ZPI_ZP <= 1;
                                    end

                                8'h13: begin
                                        // NEG
                                        `A <= neg_a;
                                        `C <= neg_a_c;
                                        `N <= neg_a_n;
                                        `Z <= neg_a_z;
                                        `END_INSTR;
                                    end

                                8'h14: begin
                                        // NOT
                                        `A <= not_a;
                                        `N <= not_a_n;
                                        `Z <= not_a_z;
                                        `END_INSTR;
                                    end

                                8'h14: begin
                                        op_TRB <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h15: begin
                                        op_ORA <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h16: begin
                                        op_ASL <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h18: begin
                                        `C <= 0; // CLC
                                        `END_INSTR;
                                    end

                                8'h19: begin
                                        op_ORA <= 1;
                                        am_AIY_a_y <= 1;
                                    end

                                8'h1A: begin
                                        // INC
                                        `A <= inc_a;
                                        `N <= inc_a_n;
                                        `Z <= inc_a_z;
                                        `END_INSTR;
                                    end

                                8'h1C: begin
                                        op_TRB <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h1D: begin
                                        op_ORA <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'h1E: begin
                                        op_ASL <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'h20: begin
                                        op_JSR <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h21: begin
                                        op_AND <= 1;
                                        am_ZIIX_ZP_X <= 1;
                                    end

                                8'h24: begin
                                        op_BIT <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h25: begin
                                        op_AND <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h26: begin
                                        op_ROL <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h28: begin
                                        op_PLP <= 1;
                                        `ADDR = `SP;
                                        `SP = inc_sp;
                                        load_from_address <= 1;
                                    end

                                8'h29: begin
                                        op_AND <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'h2A: begin
                                        // ROL
                                        `A <= rol_a;
                                        `N <= rol_a_n;
                                        `Z <= rol_a_z;
                                        `C <= rol_a_c;
                                        `END_INSTR;
                                    end

                                8'h2C: begin
                                        op_BIT <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h2D: begin
                                        op_AND <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h2E: begin
                                        op_ROL <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h30: begin
                                        if (`N) begin // BMI
                                            op_BRANCH <= 1;
                                            am_PCR_r <= 1;
                                        end else begin
                                            `PC <= add_pc_2;
                                            `END_INSTR;
                                        end
                                    end

                                8'h31: begin
                                        op_AND <= 1;
                                        am_ZIIY_ZP_y <= 1;
                                    end

                                8'h32: begin
                                        op_AND <= 1;
                                        am_ZPI_ZP <= 1;
                                    end

                                8'h34: begin
                                        op_BIT <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h35: begin
                                        op_AND <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h36: begin
                                        op_ROL <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h38: begin
                                        `C <= 1; // SEC
                                        `END_INSTR;
                                    end

                                8'h39: begin
                                        op_AND <= 1;
                                        am_AIY_a_y <= 1;
                                    end

                                8'h3A: begin
                                        // DEC
                                        `A <= dec_a;
                                        `N <= dec_a_n;
                                        `Z <= dec_a_z;
                                        `END_INSTR;
                                    end

                                8'h3C: begin
                                        op_BIT <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'h3D: begin
                                        op_AND <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'h3E: begin
                                        op_ROL <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'h40: begin
                                        op_RTI <= 1;
                                        am_STK_s <= 1;
                                    end

                                8'h41: begin
                                        op_EOR <= 1;
                                        am_ZIIX_ZP_X <= 1;
                                    end

                                8'h45: begin
                                        op_EOR <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h46: begin
                                        op_LSR <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h48: begin
                                        // PHA
                                        var_hw_address = dec_sp;
                                        `SP <= var_hw_address;
                                        `ADDR <= var_hw_address;
                                        `DST <= `A;
                                        `STORE_DST;
                                    end

                                8'h49: begin
                                        op_EOR <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'h4A: begin
                                        // LSR
                                        `A <= lsr_a;
                                        `N <= lsr_a_n;
                                        `Z <= lsr_a_z;
                                        `C <= lsr_a_c;
                                        `END_INSTR;
                                    end

                                8'h4C: begin
                                        op_JMP <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h4D: begin
                                        op_EOR <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h4E: begin
                                        op_LSR <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h50: begin
                                        if (`NV) begin // BVC
                                            op_BRANCH <= 1;
                                            am_PCR_r <= 1;
                                        end else begin
                                            `PC <= add_pc_2;
                                            `END_INSTR;
                                        end
                                    end

                                8'h51: begin
                                        op_EOR <= 1;
                                        am_ZIIY_ZP_y <= 1;
                                    end

                                8'h52: begin
                                        op_EOR <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h55: begin
                                        op_EOR <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h56: begin
                                        op_LSR <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h58: begin
                                        `I <= 0; // CLI
                                    end

                                8'h59: begin
                                        op_EOR <= 1;
                                        am_AIY_a_y <= 1;
                                    end

                                8'h5A: begin
                                        // PHY
                                        var_hw_address = dec_sp;
                                        `SP <= var_hw_address;
                                        `ADDR <= var_hw_address;
                                        `DST <= `Y;
                                        `STORE_DST;
                                    end

                                8'h5D: begin
                                        op_EOR <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'h5E: begin
                                        op_LSR <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'h60: begin
                                        op_RTS <= 1;
                                        am_STK_s <= 1;
                                    end

                                8'h61: begin
                                        op_ADC <= 1;
                                        am_ZIIX_ZP_X <= 1;
                                    end

                                8'h64: begin
                                        op_STZ <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h65: begin
                                        op_ADC <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h66: begin
                                        op_ROR <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h68: begin
                                        op_PLA <= 1;
                                        `ADDR = `SP;
                                        `SP = inc_sp;
                                        load_from_address <= 1;
                                    end

                                8'h69: begin
                                        op_ADC <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'h6A: begin
                                        // ROR
                                        `A <= ror_a;
                                        `N <= ror_a_n;
                                        `Z <= ror_a_z;
                                        `C <= ror_a_c;
                                        `END_INSTR;
                                    end

                                8'h6C: begin
                                        op_JMP <= 1;
                                        am_AIA_A <= 1;
                                    end

                                8'h6D: begin
                                        op_ADC <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h6E: begin
                                        op_ROR <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h70: begin
                                        if (`V) begin // BVS
                                            op_BRANCH <= 1;
                                            am_PCR_r <= 1;
                                        end else begin
                                            `PC <= add_pc_2;
                                            `END_INSTR;
                                        end
                                    end

                                8'h71: begin
                                        op_ADC <= 1;
                                        am_ZIIY_ZP_y <= 1;
                                    end

                                8'h72: begin
                                        op_ADC <= 1;
                                        am_ZPI_ZP <= 1;
                                    end

                                8'h74: begin
                                        op_STZ <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h75: begin
                                        op_ADC <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h76: begin
                                        op_ROR <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h78: begin
                                        `I <= 1; // SEI
                                        `END_INSTR;
                                    end

                                8'h79: begin
                                        op_ADC <= 1;
                                        am_AIY_a_y <= 1;
                                    end

                                8'h7A: begin
                                        op_PLY <= 1;
                                        `ADDR = `SP;
                                        `SP = inc_sp;
                                        load_from_address <= 1;
                                    end

                                8'h7C: begin
                                        op_JMP <= 1;
                                        am_AIIX_A_X <= 1;
                                    end

                                8'h7D: begin
                                        op_ADC <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'h7E: begin
                                        op_ROR <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'h80: begin
                                        op_BRANCH <= 1; // BRA
                                        am_PCR_r <= 1;
                                    end

                                8'h81: begin
                                        op_STA <= 1;
                                        am_ZIIX_ZP_X <= 1;
                                    end

                                8'h84: begin
                                        op_STY <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h85: begin
                                        op_STA <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h86: begin
                                        op_STX <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'h87, 8'h97, 8'hA7, 8'hB7,
                                8'hC7, 8'hD7, 8'hE7, 8'hF7:
                                    begin
                                        op_SMB <= 1;
                                        am_ZPG_zp <= 1;
                                        reg_which <= (`ONE_8 << reg_code_byte[6:4]);
                                    end

                                8'h88: begin
                                        // DEY
                                        `Y <= dec_y;
                                        `N <= dec_y_n;
                                        `Z <= dec_y_z;
                                        `END_INSTR;
                                    end

                                8'h89: begin
                                        op_BIT <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'h8A: begin
                                        // TXA
                                        `A <= `X;
                                        `END_INSTR;
                                    end

                                8'h8C: begin
                                        op_STY <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h8D: begin
                                        op_STA <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h8E: begin
                                        op_STX <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h8F, 8'h9F, 8'hAF, 8'hBF,
                                8'hCF, 8'hDF, 8'hEF, 8'hFF:
                                    begin
                                        op_BBS <= 1;
                                        am_PCR_r <= 1;
                                        reg_which <= (`ONE_8 << reg_code_byte[6:4]);
                                    end

                                8'h90: begin
                                        if (`NC) begin // BCC
                                            op_BRANCH <= 1;
                                            am_PCR_r <= 1;
                                        end else begin
                                            `PC <= add_pc_2;
                                            `END_INSTR;
                                        end
                                    end

                                8'h91: begin
                                        op_STA <= 1;
                                        am_ZIIY_ZP_y <= 1;
                                    end

                                8'h92: begin
                                        op_STA <= 1;
                                        am_ZIY_zp_y <= 1;
                                    end

                                8'h94: begin
                                        op_STY <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h95: begin
                                        op_STA <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'h96: begin
                                        op_STX <= 1;
                                        am_ZIY_zp_y <= 1;
                                    end

                                8'h98: begin
                                        // TYA
                                        `A <= `Y;
                                        `END_INSTR;
                                    end

                                8'h99: begin
                                        op_STA <= 1;
                                        am_AIY_a_y <= 1;
                                    end

                                8'h9A: begin
                                        // TXS
                                        `SP <= `X;
                                        `END_INSTR;
                                    end

                                8'h9C: begin
                                        op_STZ <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'h9D: begin
                                        op_STA <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'h9E: begin
                                        op_STZ <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'hA0: begin
                                        op_LDY <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'hA1: begin
                                        op_LDA <= 1;
                                        am_ZIIX_ZP_X <= 1;
                                    end

                                8'hA2: begin
                                        op_LDX <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'hA4: begin
                                        op_LDY <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'hA5: begin
                                        op_LDA <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'hA6: begin
                                        op_LDX <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'hA8: begin
                                        // TAY
                                        `Y <= `A;
                                        `END_INSTR;
                                    end

                                8'hA9: begin
                                        op_LDA <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'hAA: begin
                                        // TAX
                                        `X <= `A;
                                        `END_INSTR;
                                    end

                                8'hAC: begin
                                        op_LDY <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'hAD: begin
                                        op_LDA <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'hAE: begin
                                        op_LDX <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'hB0: begin
                                        if (`C) begin // BCS
                                            op_BRANCH <= 1;
                                            am_PCR_r <= 1;
                                        end else begin
                                            `PC <= add_pc_2;
                                            `END_INSTR;
                                        end
                                    end

                                8'hB1: begin
                                        op_LDA <= 1;
                                        am_ZIIY_ZP_y <= 1;
                                    end

                                8'hB2: begin
                                        op_LDA <= 1;
                                        am_ZPI_ZP <= 1;
                                    end

                                8'hB4: begin
                                        op_LDY <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'hB5: begin
                                        op_LDA <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'hB6: begin
                                        op_LDX <= 1;
                                        am_ZIY_zp_y <= 1;
                                    end

                                8'hB8: begin
                                        `V <= 0; // CLV
                                        `END_INSTR;
                                    end

                                8'hB9: begin
                                        op_LDA <= 1;
                                        am_AIY_a_y <= 1;
                                    end

                                8'hBA: begin
                                        // TSX
                                        `X <= `SP;
                                        `END_INSTR;
                                    end

                                8'hBC: begin
                                        op_LDY <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'hBD: begin
                                        op_LDA <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'hBE: begin
                                        op_LDX <= 1;
                                        am_AIY_a_y <= 1;
                                    end

                                8'hC0: begin
                                        op_CPY <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'hC1: begin
                                        op_CMP <= 1;
                                        am_ZIIX_ZP_X <= 1;
                                    end

                                8'hC4: begin
                                        op_CPY <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'hC5: begin
                                        op_CMP <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'hC6: begin
                                        op_DEC <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'hC8: begin
                                        // INY
                                        `Y <= inc_y;
                                        `N <= inc_y_n;
                                        `Z <= inc_y_z;
                                        `END_INSTR;
                                    end

                                8'hC9: begin
                                        op_CMP <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'hCA: begin
                                        // DEX
                                        `X <= dec_x;
                                        `N <= dec_x_n;
                                        `Z <= dec_x_z;
                                        `END_INSTR;
                                    end

                                8'hCB: begin
                                        op_WAI <= 1;
                                    end

                                8'hCC: begin
                                        op_CPY <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'hCD: begin
                                        op_CMP <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'hCE: begin
                                        op_DEC <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'hD0: begin
                                        if (`NZ) begin // BNE
                                            op_BRANCH <= 1;
                                            am_PCR_r <= 1;
                                        end else begin
                                            `PC <= add_pc_2;
                                            `END_INSTR;
                                        end
                                    end

                                8'hD1: begin
                                        op_CMP <= 1;
                                        am_ZIIY_ZP_y <= 1;
                                    end

                                8'hD2: begin
                                        op_CMP <= 1;
                                        am_ZPI_ZP <= 1;
                                    end

                                8'hD5: begin
                                        op_CMP <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'hD6: begin
                                        op_DEC <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'hD8: begin
                                        `D <= 0; // CLD
                                        `END_INSTR;
                                    end

                                8'hD9: begin
                                        op_CMP <= 1;
                                        am_AIY_a_y <= 1;
                                    end

                                8'hDA: begin
                                        // PHX
                                        var_hw_address = dec_sp;
                                        `SP <= var_hw_address;
                                        `ADDR <= var_hw_address;
                                        `DST <= `X;
                                        `STORE_DST;
                                    end

                                8'hDB: begin
                                        op_STP <= 1;
                                    end

                                8'hDD: begin
                                        op_CMP <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'hDE: begin
                                        op_DEC <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'hE0: begin
                                        op_CPX <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'hE1: begin
                                        op_SBC <= 1;
                                        am_ZIIX_ZP_X <= 1;
                                    end

                                8'hE4: begin
                                        op_CPX <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'hE5: begin
                                        op_SBC <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'hE6: begin
                                        op_INC <= 1;
                                        am_ZPG_zp <= 1;
                                    end

                                8'hE8: begin
                                        // INX
                                        `X <= inc_x;
                                        `N <= inc_x_n;
                                        `Z <= inc_x_z;
                                        `END_INSTR;
                                    end

                                8'hE9: begin
                                        op_SBC <= 1;
                                        am_IMM_m <= 1;
                                    end

                                8'hEA: begin
                                        // NOP
                                        `END_INSTR;
                                    end

                                8'hEC: begin
                                        op_CPX <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'hED: begin
                                        op_SBC <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'hEE: begin
                                        op_INC <= 1;
                                        am_ABS_a <= 1;
                                    end

                                8'hF0: begin
                                        if (`Z) begin // BEQ
                                            op_BRANCH <= 1;
                                            am_PCR_r <= 1;
                                        end else begin
                                            `PC <= add_pc_2;
                                            `END_INSTR;
                                        end
                                    end

                                8'hF1: begin
                                        op_SBC <= 1;
                                        am_ZIIY_ZP_y <= 1;
                                    end

                                8'hF2: begin
                                        op_SBC <= 1;
                                        am_ZPI_ZP <= 1;
                                    end

                                8'hF5: begin
                                        op_SBC <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'hF6: begin
                                        op_INC <= 1;
                                        am_ZIX_zp_x <= 1;
                                    end

                                8'hF8: begin
                                        `D <= 1; // SED
                                        `END_INSTR;
                                    end

                                8'hF9: begin
                                        op_SBC <= 1;
                                        am_AIY_a_y <= 1;
                                    end

                                8'hFA: begin
                                        op_PLX <= 1;
                                        `ADDR = `SP;
                                        `SP = inc_sp;
                                        load_from_address <= 1;
                                    end

                                8'hFD: begin
                                        op_SBC <= 1;
                                        am_AIX_a_x <= 1;
                                    end

                                8'hFE: begin
                                        op_INC <= 1;
                                        am_AIX_a_x <= 1;
                                    end
                            endcase;
                    end
                    2: begin // 6502 cycle 2
                            `ADDR0 <= i_bus_data;
                            `ADDR1 <= 0;
                            `ADDR2 <= 0;
                            `ADDR3 <= 0;
                            `OFFSET <= 0;
                            `PC <= inc_pc;
                            if (am_ZPG_zp) begin
                                am_ZPG_zp <= 0;
                                load_from_address <= 1;
                            end else if (am_ZIX_zp_x) begin
                                `OFFSET <= {`ZERO_8, `X};
                                am_ZIX_zp_x <= 0;
                                load_from_address <= 1;
                            end else if (am_ZIY_zp_y) begin
                                `OFFSET <= {`ZERO_8, `Y};
                                am_ZIY_zp_y <= 0;
                                load_from_address <= 1;
                            end else if (am_ZIIX_ZP_X) begin
                                `OFFSET <= {`ZERO_8, `X};
                            end
                        end
                    3: begin // 6502 cycle 3
                            if (am_IMM_m) begin
                                am_IMM_m <= 0;
                                //`DATA_BYTE = `ADDR0; ??
                                if (op_ADC) begin
                                    `A <= adc_a_var;
                                    `N <= adc_a_var_n;
                                    `V <= adc_a_var_v;
                                    `Z <= adc_a_var_z;
                                    `C <= adc_a_var_c;
                                    `END_OPER_INSTR(op_ADC);
                                end else if (op_AND) begin
                                    `A <= and_a_var;
                                    `N <= and_a_var_n;
                                    `Z <= and_a_var_z;
                                    `END_OPER_INSTR(op_AND);
                                end else if (op_ASL) begin
                                    `DST <= reg_data_byte;
                                    `N <= asl_var_n;
                                    `Z <= asl_var_z;
                                    `C <= asl_var_c;
                                    `STORE_AFTER_OP(op_ASL);
                                end else if (op_BIT) begin
                                    `N <= and_a_var_n;
                                    `V <= and_a_var_v;
                                    `Z <= and_a_var_z;
                                    `END_OPER_INSTR(op_BIT);
                                end else if (op_CMP) begin
                                    `N <= sub_a_var_n;
                                    `V <= sub_a_var_v;
                                    `Z <= sub_a_var_z;
                                    `C <= sub_a_var_c;
                                    `END_OPER_INSTR(op_CMP);
                                end else if (op_CPX) begin
                                    `N <= sub_x_var_n;
                                    `V <= sub_x_var_v;
                                    `Z <= sub_x_var_z;
                                    `C <= sub_x_var_c;
                                    `END_OPER_INSTR(op_CPX);
                                end else if (op_CPY) begin
                                    `N <= sub_y_var_n;
                                    `V <= sub_y_var_v;
                                    `Z <= sub_y_var_z;
                                    `C <= sub_y_var_c;
                                    `END_OPER_INSTR(op_CPY);
                                end else if (op_EOR) begin
                                    `A <= eor_a_var;
                                    `N <= eor_a_var_n;
                                    `Z <= eor_a_var_z;
                                    `END_OPER_INSTR(op_EOR);
                                end else if (op_LDA) begin
                                    `A <= reg_data_byte;
                                    `N <= i_bus_data[7];
                                    `Z <= (reg_data_byte == `ZERO_8) ? 1 : 0;
                                    `END_OPER_INSTR(op_LDA);
                                end else if (op_LDX) begin
                                    `X <= reg_data_byte;
                                    `N <= i_bus_data[7];
                                    `Z <= (reg_data_byte == `ZERO_8) ? 1 : 0;
                                    `END_OPER_INSTR(op_LDX);
                                end else if (op_LDY) begin
                                    `Y <= reg_data_byte;
                                    `N <= i_bus_data[7];
                                    `Z <= (reg_data_byte == `ZERO_8) ? 1 : 0;
                                    `END_OPER_INSTR(op_LDY);
                                end else if (op_ORA) begin
                                    `A <= or_a_var;
                                    `N <= or_a_var_n;
                                    `Z <= or_a_var_z;
                                    `END_OPER_INSTR(op_ORA);
                                end else if (op_SBC) begin
                                    `A <= sbc_a_var;
                                    `C <= sbc_a_var_c;
                                    `V <= sbc_a_var_v;
                                    `N <= sbc_a_var_n;
                                    `Z <= sbc_a_var_z;
                                    `END_OPER_INSTR(op_SBC);
                                end else if (op_SUB) begin
                                    `A <= sub_a_var;
                                    `N <= sub_a_var_n;
                                    `V <= sub_a_var_v;
                                    `Z <= sub_a_var_z;
                                    `C <= sub_a_var_c;
                                    `END_OPER_INSTR(op_SUB);
                                end
                            end else if (am_PCR_r) begin
                                if (op_BBR | op_BBS) begin
                                    `SRC <= i_bus_data;
                                end else begin
                                    am_PCR_r <= 0;
                                    `PC <= `PC + {(reg_address[7] ? `ONES_8 : `ZERO_8), `ADDR0};
                                    `END_INSTR;
                                end
                            end else begin
                                `ADDR1 <= i_bus_data;
                                `PC <= inc_pc;
                            end
                        end
                    4: begin // 6502 cycle 4
                            if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
                                `IADDR1 <= i_bus_data;
                                `ADDR <= inc_addr;
                            end else if (op_BBR | op_BBS) begin
                                reg_data_byte <= i_bus_data;
                            end else begin
                                if (am_ABS_a) begin
                                    am_ABS_a <= 0;
                                    if (op_JMP) begin
                                        `PC <= `ADDR;
                                        `END_OPER_INSTR(op_JMP);
                                    end else if (op_JSR) begin
                                        `PC <= `ADDR;
                                        `END_OPER(op_JSR);
                                        `eDST0 <= `PC[7:0];
                                        `eDST1 <= `PC[15:8];
                                        push_edst0 <= 1;
                                    end else if (op_STA) begin
                                        `DST <= `A;
                                        `STORE_AFTER_OP(op_STA);
                                    end else if (op_STX) begin
                                        `DST <= `X;
                                        `STORE_AFTER_OP(op_STX);
                                    end else if (op_STY) begin
                                        `DST <= `Y;
                                        `STORE_AFTER_OP(op_STY);
                                    end else if (op_STZ) begin
                                        `DST <= `ZERO_8;
                                        `STORE_AFTER_OP(op_STZ);
                                    end else begin
                                        load_from_address <= 1;
                                    end
                                end else if (am_AIIX_A_X) begin
                                        `ADDR <= {`ZERO_8, reg_code_byte} + uext_x_16;
                                end else if (am_AIA_A) begin
                                        `ADDR1 <= reg_code_byte;
                                end else if (am_AIX_a_x) begin
                                    `ADDR <= {`ZERO_8, reg_code_byte} + uext_x_16;
                                    am_AIX_a_x <= 0;
                                    load_from_address <= 1;
                                end else if (am_AIY_a_y) begin
                                    `ADDR <= {`ZERO_8, reg_code_byte} + uext_y_16;
                                    am_AIY_a_y <= 0;
                                    load_from_address <= 1;
                                end
                            end
                        end
                    5: begin // 6502 cycle 5
                            if (am_AIIX_A_X | am_AIA_A) begin
                                `IADDR0 <= i_bus_data;
                                `ADDR <= inc_addr;
                            end else if (am_ZIIX_ZP_X) begin
                                `IADDR1 <= i_bus_data;
                                am_ZIIX_ZP_X <= 0;
                                load_from_address <= 1;
                            end else if (am_ZIIY_ZP_y) begin
                                `IADDR1 <= i_bus_data + `Y;
                                am_ZIIY_ZP_y <= 0;
                                load_from_address <= 1;
                            end else if (op_BBR) begin
                                am_PCR_r <= 0;
                                if ((reg_src_data & reg_which) == 0) begin
                                    `PC <= `PC + {(reg_src_data[7] ? `ONES_8 : `ZERO_8), reg_src_data};
                                end
                                `END_OPER_INSTR(op_BBR);
                            end else if (op_BBS) begin
                                am_PCR_r <= 0;
                                if ((reg_src_data & reg_which) != 0) begin
                                    `PC <= `PC + {(reg_src_data[7] ? `ONES_8 : `ZERO_8), reg_src_data};
                                end
                                `END_OPER_INSTR(op_BBS);
                            end
                        end
                    6: begin // 6502 cycle 6
                            if (am_AIIX_A_X | am_AIA_A) begin
                                am_AIIX_A_X <= 0;
                                am_AIA_A <= 0;
                                `END_INSTR;
                                if (op_JMP) begin
                                    `PC <= {i_bus_data, `IADDR0};
                                    `END_OPER(op_JMP);
                                end
                            end
                        end
                    7: begin // 6502 cycle 7
                        end
                endcase
            end
        end else begin // 65832
            case (reg_cycle)
                0: begin // 65832 cycle 0
                        // load instruction?
                        case (i_bus_data)
                            8'h00: begin
                                    op_BRK <= 1;
                                    ame_STK_s <= 1;
                                end

                            8'h01: begin
                                    op_ORA <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'h06: begin
                                    op_ASL <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h08: begin
                                    op_PHP <= 1;
                                    ame_STK_s <= 1;
                                end

                            8'h09: begin
                                    op_ORA <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'h0A: begin
                                    op_ASL <= 1;
                                    ame_ACC_A <= 1;
                                end

                            8'h0C: begin
                                    op_TSB <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h0D: begin
                                    op_ORA <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h10: begin
                                    if (`eNN) begin // BPL
                                        op_BRANCH <= 1;
                                        ame_PCR_r <= 1;
                                    end else begin
                                        `ePC <= add_epc_4;
                                        `END_INSTR;
                                    end
                                end

                            8'h11: begin
                                    op_ORA <= 1;
                                    ame_AIIY_A_y <= 1;
                                end

                            8'h12: begin
                                    op_ORA <= 1;
                                    ame_AIA_A <= 1;
                                end

                            8'h16: begin
                                    op_ASL <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h18: begin
                                    `C <= 0; // CLC
                                    `END_INSTR;
                                end

                            8'h19: begin
                                    op_ORA <= 1;
                                    ame_AIY_a_y <= 1;
                                end

                            8'h1A: begin
                                    // INC
                                    `eA <= inc_ea;
                                    `eN <= inc_ea_n;
                                    `eZ <= inc_ea_z;
                                    `END_INSTR;
                                end

                            8'h1C: begin
                                    op_TRB <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h1D: begin
                                    op_ORA <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h20: begin
                                    op_JSR <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h21: begin
                                    op_AND <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'h22: begin
                                    op_JSR <= 1;
                                    ame_AIA_A <= 1;
                                end

                            8'h23: begin
                                    op_SUB <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'h26: begin
                                    op_ROL <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h28: begin
                                    op_PLP <= 1;
                                    ame_STK_s <= 1;
                                end

                            8'h29: begin
                                    op_AND <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'h2A: begin
                                    op_ROL <= 1;
                                    ame_ACC_A <= 1;
                                end

                            8'h2C: begin
                                    op_BIT <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h2D: begin
                                    op_AND <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h30: begin
                                    if (`eN) begin // BMI
                                        op_BRANCH <= 1;
                                        ame_PCR_r <= 1;
                                    end else begin
                                        `ePC <= add_epc_4;
                                        `END_INSTR;
                                    end
                                end

                            8'h31: begin
                                    op_AND <= 1;
                                    ame_AIIY_A_y <= 1;
                                end

                            8'h32: begin
                                    op_AND <= 1;
                                    ame_AIA_A <= 1;
                                end

                            8'h36: begin
                                    op_ROL <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h38: begin
                                    `C <= 1; // SEC
                                    `END_INSTR;
                                end

                            8'h39: begin
                                    op_AND <= 1;
                                    ame_AIY_a_y <= 1;
                                end

                            8'h3A: begin
                                    // DEC
                                    `eA <= dec_ea;
                                    `eN <= dec_ea_n;
                                    `eZ <= dec_ea_z;
                                    `END_INSTR;
                                end

                            8'h3C: begin
                                    op_BIT <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h3D: begin
                                    op_AND <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h40: begin
                                    op_RTI <= 1;
                                    ame_STK_s <= 1;
                                end

                            8'h41: begin
                                    op_EOR <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'h46: begin
                                    op_LSR <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h48: begin
                                    op_PHA <= 1;
                                    ame_STK_s <= 1;
                                end

                            8'h49: begin
                                    op_EOR <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'h4A: begin
                                    op_LSR <= 1;
                                    ame_ACC_A <= 1;
                                end

                            8'h4C: begin
                                    op_JMP <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h4D: begin
                                    op_EOR <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h50: begin
                                    if (`eNV) begin // BVC
                                        op_BRANCH <= 1;
                                        ame_PCR_r <= 1;
                                    end else begin
                                        `ePC <= add_epc_4;
                                        `END_INSTR;
                                    end
                                end

                            8'h51: begin
                                    op_EOR <= 1;
                                    ame_AIIY_A_y <= 1;
                                end

                            8'h52: begin
                                    op_EOR <= 1;
                                    ame_AIA_A <= 1;
                                end

                            8'h56: begin
                                    op_LSR <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h58: begin
                                    `I <= 0; // CLI
                                    `END_INSTR;
                                end

                            8'h59: begin
                                    op_EOR <= 1;
                                    ame_AIY_a_y <= 1;
                                end

                            8'h5A: begin
                                    op_PHY <= 1;
                                    ame_STK_s <= 1;
                                end

                            8'h5C: begin
                                    op_JSR <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'h5D: begin
                                    op_EOR <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h60: begin
                                    op_RTS <= 1;
                                    ame_PCR_r <= 1;
                                end

                            8'h61: begin
                                    op_ADC <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'h66: begin
                                    op_ROR <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h68: begin
                                    op_PLA <= 1;
                                    ame_STK_s <= 1;
                                end

                            8'h69: begin
                                    op_ADC <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'h6A: begin
                                    op_ROR <= 1;
                                    ame_ACC_A <= 1;
                                end

                            8'h6C: begin
                                    op_JMP <= 1;
                                    ame_AIA_A <= 1;
                                end

                            8'h6D: begin
                                    op_ADC <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h70: begin
                                    if (`eV) begin // BVS
                                        op_BRANCH <= 1;
                                        ame_PCR_r <= 1;
                                    end else begin
                                        `ePC <= add_epc_4;
                                        `END_INSTR;
                                    end
                                end

                            8'h71: begin
                                    op_ADC <= 1;
                                    ame_AIIY_A_y <= 1;
                                end

                            8'h72: begin
                                    op_ADC <= 1;
                                    ame_AIA_A <= 1;
                                end

                            8'h76: begin
                                    op_ROR <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h78: begin
                                    `I <= 1; // SEI
                                    `END_INSTR;
                                end

                            8'h79: begin
                                    op_ADC <= 1;
                                    ame_AIY_a_y <= 1;
                                end

                            8'h7A: begin
                                    op_PLY <= 1;
                                    ame_STK_s <= 1;
                                end

                            8'h7C: begin
                                    op_JMP <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'h7D: begin
                                    op_ADC <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h80: begin
                                    // BRA
                                    op_BRANCH <= 1;
                                    ame_PCR_r <= 1;
                                end

                            8'h81: begin
                                    op_STA <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'h86: begin
                                    op_STZ <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h88: begin
                                    // DEY
                                    `eY <= dec_ey;
                                    `eN <= dec_ey_n;
                                    `eZ <= dec_ey_z;
                                    `END_INSTR;
                                end

                            8'h89: begin
                                    op_BIT <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'h8A: begin
                                    // TXA
                                    reg_a <= reg_x;
                                    `END_INSTR;
                                end

                            8'h8C: begin
                                    op_STY <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h8D: begin
                                    op_STA <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h8E: begin
                                    op_STX <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'h90: begin
                                    if (`eNC) begin // BCC
                                        op_BRANCH <= 1;
                                        ame_PCR_r <= 1;
                                    end else begin
                                        `ePC <= add_epc_4;
                                        `END_INSTR;
                                    end
                                end

                            8'h91: begin
                                    op_STA <= 1;
                                    ame_AIIY_A_y <= 1;
                                end

                            8'h92: begin
                                    op_STA <= 1;
                                    ame_AIA_A <= 1;
                                end

                            8'h96: begin
                                    op_STZ <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h98: begin
                                    // TYA
                                    reg_a <= reg_y;
                                    `END_INSTR;
                                end

                            8'h99: begin
                                    op_STA <= 1;
                                    ame_AIY_a_y <= 1;
                                end

                            8'h9A: begin
                                    // TXS
                                    `eSP <= `eX;
                                    `END_INSTR;
                                end

                            8'h9C: begin
                                    op_STY <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h9D: begin
                                    op_STA <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'h9E: begin
                                    op_STX <= 1;
                                    ame_AIY_a_y <= 1;
                                end

                            8'hA0: begin
                                    op_LDY <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'hA1: begin
                                    op_LDA <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'hA2: begin
                                    op_LDX <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'hA8: begin
                                    // TAY
                                    `eY <= `eA;
                                    `END_INSTR;
                                end

                            8'hA9: begin
                                    op_LDA <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'hAA: begin
                                    // TAX
                                    `eX <= `eA;
                                    `END_INSTR;
                                end

                            8'hAC: begin
                                    op_LDY <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'hAD: begin
                                    op_LDA <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'hAE: begin
                                    op_LDX <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'hB0: begin
                                    if (`eC) begin // BCS
                                        op_BRANCH <= 1;
                                        ame_PCR_r <= 1;
                                    end else begin
                                        `ePC <= add_epc_4;
                                        `END_INSTR;
                                    end
                                end

                            8'hB1: begin
                                    op_LDA <= 1;
                                    ame_AIIY_A_y <= 1;
                                end

                            8'hB2: begin
                                    op_LDA <= 1;
                                    ame_AIA_A <= 1;
                                end

                            8'hB8: begin
                                    `V <= 0; // CLV
                                    `END_INSTR;
                                end

                            8'hB9: begin
                                    op_LDA <= 1;
                                    ame_AIY_a_y <= 1;
                                end

                            8'hBA: begin
                                    // TSX
                                    `eX <= `eSP;
                                    `END_INSTR;
                                end

                            8'hBC: begin
                                    op_LDY <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'hBD: begin
                                    op_LDA <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'hBE: begin
                                    op_LDX <= 1;
                                    ame_AIY_a_y <= 1;
                                end

                            8'hC0: begin
                                    op_CPY <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'hC1: begin
                                    op_CMP <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'hC6: begin
                                    op_DEC <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'hC8: begin
                                    // INY
                                    `eY <= inc_ey;
                                    `eN <= inc_ey_n;
                                    `eZ <= inc_ey_z;
                                    `END_INSTR;
                                end

                            8'hC9: begin
                                    op_CMP <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'hCA: begin
                                    // DEX
                                    `eX <= dec_ex;
                                    `eN <= dec_ex_n;
                                    `eZ <= dec_ex_z;
                                    `END_INSTR;
                                end

                            8'hCC: begin
                                    op_CPY <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'hCD: begin
                                    op_CMP <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'hD0: begin
                                    if (`eNZ) begin // BNE
                                        op_BRANCH <= 1;
                                        ame_PCR_r <= 1;
                                    end else begin
                                        `ePC <= add_epc_4;
                                        `END_INSTR;
                                    end
                                end

                            8'hD1: begin
                                    op_CMP <= 1;
                                    ame_AIIY_A_y <= 1;
                                end

                            8'hD2: begin
                                    op_CMP <= 1;
                                    ame_AIA_A <= 1;
                                end

                            8'hD6: begin
                                    op_DEC <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'hD8: begin
                                    `D <= 0; // CLD
                                    `END_INSTR;
                                end

                            8'hD9: begin
                                    op_CMP <= 1;
                                    ame_AIY_a_y <= 1;
                                end

                            8'hDA: begin
                                    op_PHX <= 1;
                                    ame_STK_s <= 1;
                                end

                            8'hDD: begin
                                    op_CMP <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'hE0: begin
                                    op_CPX <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'hE1: begin
                                    op_SBC <= 1;
                                    ame_AIIX_A_X <= 1;
                                end

                            8'hE6: begin
                                    op_INC <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'hE8: begin
                                    // INX
                                    `eX <= inc_ex;
                                    `eN <= inc_ex_n;
                                    `eZ <= inc_ex_z;
                                    `END_INSTR;
                                end

                            8'hE9: begin
                                    op_SBC <= 1;
                                    ame_IMM_m <= 1;
                                end

                            8'hEA: begin
                                    // NOP
                                    `END_INSTR;
                                end

                            8'hEC: begin
                                    op_CPX <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'hED: begin
                                    op_SBC <= 1;
                                    ame_ABS_a <= 1;
                                end

                            8'hF0: begin
                                    if (`eZ) begin // BEQ
                                        op_BRANCH <= 1;
                                        ame_PCR_r <= 1;
                                    end else begin
                                        `ePC <= add_epc_4;
                                        `END_INSTR;
                                    end
                                end

                            8'hF1: begin
                                    op_SBC <= 1;
                                    ame_AIIY_A_y <= 1;
                                end

                            8'hF2: begin
                                    op_SBC <= 1;
                                    ame_AIA_A <= 1;
                                end

                            8'hF6: begin
                                    op_INC <= 1;
                                    ame_AIX_a_x <= 1;
                                end

                            8'hF8: begin
                                    `D <= 1; // SED
                                    `END_INSTR;
                                end

                            8'hF9: begin
                                    op_SBC <= 1;
                                    ame_AIY_a_y <= 1;
                                end

                            8'hFA: begin
                                    op_PLX <= 1;
                                    ame_STK_s <= 1;
                                end

                            8'hFD: begin
                                    op_SBC <= 1;
                                    ame_AIX_a_x <= 1;
                                end
                        endcase;
                    end
                1: begin // 65832 cycle 1
                        if (am_PCR_r) begin
                            `eSRC0 <= i_bus_data;
                            `ePC <= inc_epc;
                        end
                    end
                2: begin // 65832 cycle 2
                        if (am_PCR_r) begin
                            `eSRC1 <= i_bus_data;
                            `ePC <= inc_epc;
                        end
                    end
                3: begin // 65832 cycle 3
                        if (am_PCR_r) begin
                            `eSRC2 <= i_bus_data;
                            `ePC <= inc_epc;
                            am_PCR_r <= 0;
                        end
                    end
                4: begin // 65832 cycle 4
                        if (op_BRANCH) begin
                            `ePC <= add_epc_src_24;
                            op_BRANCH <= 0;
                            `END_INSTR;
                        end
                    end
                5: begin // 65832 cycle 5
                    end
            endcase
        end
    end
end

endmodule
