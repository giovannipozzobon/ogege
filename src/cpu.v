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

module cpu (
    input   logic i_rst,
    input   logic i_clk
);


`define VB  [7:0]
`define VHW [15:0]
`define VW  [31:0]

// 6502 CPU registers

reg `VB reg_a;              // Accumulator
reg `VB reg_x;              // X index
reg `VB reg_y;              // Y index
reg `VHW reg_pc;            // Program counter
reg `VHW reg_sp;            // Stack pointer
reg `VB reg_status;         // Processor status

`define A   reg_a           // Accumulator
`define X   reg_x           // X index
`define Y   reg_y           // Y index
`define PC  reg_pc          // Program counter
`define SP  reg_sp          // Stack pointer

`define P   reg_status      // Processor status
`define N   reg_status[7]   // Negative
`define V   reg_status[6]   // Overflow
`define U   reg_status[5]   // User status/mode
`define B   reg_status[4]   // Interrupt type (1=BRK, 0=IRQB)
`define D   reg_status[3]   // Decimal
`define I   reg_status[2]   // IRQB disable
`define Z   reg_status[1]   // Zero
`define C   reg_status[0]   // Carry

`define NN   ~reg_status[7]   // Not Negative
`define NV   ~reg_status[6]   // Not Overflow
`define NU   ~reg_status[5]   // Not User status/mode
`define NB   ~reg_status[4]   // Not Interrupt type (1=BRK, 0=IRQB)
`define ND   ~reg_status[3]   // Not Decimal
`define NI   ~reg_status[2]   // Not IRQB disable
`define NZ   ~reg_status[1]   // Not Zero
`define NC   ~reg_status[0]   // Not Carry

// 65832 CPU registers (enhanced/extended)

reg `VW reg_ea;             // Accumulator
reg `VW reg_ex;             // X index
reg `VW reg_ey;             // Y index
reg `VW reg_epc;            // Program counter
reg `VW reg_esp;            // Stack pointer
reg `VB reg_estatus;        // Processor status

`define eA  reg_ea          // Accumulator
`define eX  reg_ex          // X index
`define eY  reg_ey          // Y index
`define ePC reg_epc         // Program counter
`define eSP reg_esp         // Stack pointer

`define eP  reg_estatus     // Processor status
`define eN  reg_estatus[7]  // Negative
`define eV  reg_estatus[6]  // Overflow
`define eU  reg_estatus[5]  // User status/mode
`define eB  reg_estatus[4]  // Interrupt type (1=BRK, 0=IRQB)
`define eD  reg_estatus[3]  // Decimal
`define eI  reg_estatus[2]  // IRQB disable
`define eZ  reg_estatus[1]  // Zero
`define eC  reg_estatus[0]  // Carry

`define eNN ~reg_estatus[7]  // Not Negative
`define eNV ~reg_estatus[6]  // Not Overflow
`define eNU ~reg_estatus[5]  // Not User status/mode
`define eNB ~reg_estatus[4]  // Not Interrupt type (1=BRK, 0=IRQB)
`define eND ~reg_estatus[3]  // Not Decimal
`define eNI ~reg_estatus[2]  // Not IRQB disable
`define eNZ ~reg_estatus[1]  // Not Zero
`define eNC ~reg_estatus[0]  // Not Carry

// Working/Temporary registers

`define RVB     reg_read_val`VB
`define RVHW    reg_read_val`VHW
`define RVW     reg_read_val`VW
`define WVB     reg_write_val`VB
`define WVHW    reg_write_val`VHW
`define WVW     reg_write_val`VW
`define ADDR    reg_address`VHW
`define EADDR   reg_address`VW

`define ZERO_7 7'd0
`define ZERO_8 8'd0
`define ZERO_9 9'd0
`define ZERO_16 16'd0
`define ZERO_17 17'd0
`define ZERO_24 24'd0
`define ZERO_25 25'd0
`define ZERO_31 24'd0
`define ZERO_32 24'd0
`define ZERO_33 24'd0

`define ONE_8 8'd1
`define ONE_9 9'd1
`define ONE_32 32'd1
`define ONE_33 33'd1

`define ONES_8 8'hFF
`define ONES_24 24'hFFFFFF
`define ONES_25 25'h1FFFFFF
`define ONES_32 32'hFFFFFFFF
`define ONES_33 33'h1FFFFFFFF

// Instruction (operation) mnemonics
typedef enum bit [7:0] {
    ADD,
    ADC,
    AND,
    ASL,
    BEQ,
    BIT,
    BBR,
    BBS,
    BCC,
    BCS,
    BMI,
    BNE,
    BPL,
    BRA,
    BRK,
    BVC,
    BVS,
    CLC,
    CLD,
    CLI,
    CLV,
    CMP,
    CPX,
    CPY,
    DEC,
    DEX,
    DEY,
    EOR,
    INC,
    INX,
    INY,
    JMP,
    JSR,
    LDA,
    LDX,
    LDY,
    LSR,
    NOP,
    ORA,
    PHA,
    PHP,
    PHX,
    PHY,
    PLA,
    PLP,
    PLX,
    PLY,
    RMB,
    ROL,
    ROR,
    RTI,
    RTS,
    SBC,
    SEC,
    SED,
    SEI,
    SMB,
    STA,
    STP,
    STX,
    STY,
    STZ,
    SUB,
    TAX,
    TAY,
    TRB,
    TSB,
    TSX,
    TXA,
    TXS,
    TYA,
    WAI
} Operation;

// Processing registers
reg [2:0] reg_cycle;
reg reg_6502;
reg reg_65832;
reg [2:0] reg_which;
reg `VW reg_address;
reg `VW reg_src_data;
reg `VW reg_dst_data;

logic [7:0] var_opcode;

reg am_ABS_a;       // Absolute a (6502)
reg am_ACC_A;       // Accumulator A (6502)
reg am_AIA_A;       // Absolute Indirect (a) (6502)
reg am_AIIX_A_X;    // Absolute Indexed Indirect with X (a,x) (6502)
reg am_AIX_a_x;     // Absolute Indexed with X a,x (6502)
reg am_AIY_a_y;     // Absolute Indexed with Y a,y (6502)
reg am_IMM_m;       // Immediate Addressing # (6502)
reg am_IMP_i;       // Implied i (6502)
reg am_PCR_r;       // Program Counter Relative r (6502)
reg am_STK_s;       // Stack s (6502)
reg am_ZIIX_ZP_X;   // Zero Page Indexed Indirect (zp,x) (6502)
reg am_ZIIY_ZP_y;   // Zero Page Indirect Indexed with Y (zp),y (6502)
reg am_ZIX_zp_x;    // Zero Page Indexed with X zp,x (6502)
reg am_ZIY_zp_y;    // Zero Page Indexed with Y zp,y (6502)
reg am_ZPG_zp;      // Zero Page zp (6502)
reg am_ZPI_ZP;      // Zero Page Indirect (zp) (6502)
reg ame_ABS_a;      // Absolute a (65832)
reg ame_ACC_A;      // Accumulator A (65832)
reg ame_AIA_A;      // Absolute Indirect (a) (65832)
reg ame_AIIX_A_X;   // Absolute Indexed Indirect with X (a,x) (65832)
reg ame_AIIY_A_y;   // Absolute Indexed Indirect with Y (a),y (65832)
reg ame_AIX_a_x;    // Absolute Indexed with X a,x (65832)
reg ame_AIY_a_y;    // Absolute Indexed with Y a,y (65832)
reg ame_IMM_m;      // Immediate Addressing # (65832)
reg ame_PCR_r;      // Program Counter Relative r (65832)
reg ame_STK_s;      // Stack s (65832)
reg op_ADC;
reg op_ADD;
reg op_AND;
reg op_ASL;
reg op_BBR;
reg op_BBS;
reg op_BCC;
reg op_BCS;
reg op_BEQ;
reg op_BIT;
reg op_BMI;
reg op_BNE;
reg op_BPL;
reg op_BRA;
reg op_BRK;
reg op_BVC;
reg op_BVS;
reg op_CMP;
reg op_CPX;
reg op_CPY;
reg op_DEC;
reg op_EOR;
reg op_INC;
reg op_JMP;
reg op_JSR;
reg op_LDA;
reg op_LDX;
reg op_LDY;
reg op_LSR;
reg op_ORA;
reg op_PHA;
reg op_PHP;
reg op_PHX;
reg op_PHY;
reg op_PLA;
reg op_PLP;
reg op_PLX;
reg op_PLY;
reg op_RMB;
reg op_ROL;
reg op_ROR;
reg op_RTI;
reg op_RTS;
reg op_SBC;
reg op_SMB;
reg op_STA;
reg op_STP;
reg op_STX;
reg op_STX;
reg op_STY;
reg op_STY;
reg op_STZ;
reg op_STZ;
reg op_SUB;
reg op_TRB;
reg op_TSB;
reg op_WAI;

`define SRC reg_src_data`VB
`define eSRC reg_src_data`VW

reg `VB reg_ram[0:65535]; // 64 KB

initial $readmemh("../ram/ram.bits", reg_ram);

`define LOGIC_8     logic [7:0]
`define LOGIC_9     logic [8:0]
`define LOGIC_16    logic [15:0]
`define LOGIC_17    logic [16:0]
`define LOGIC_32    logic [31:0]
`define LOGIC_33    logic [32:0]

`LOGIC_9 sext_a_9; assign sext_a_9 = {`A[7], `A};
`LOGIC_32 sext_a_32; assign sext_a_32 = {`A[7] ? `ONES_24 : `ZERO_24, `A};
`LOGIC_33 sext_a_33; assign sext_a_33 = {`A[7] ? `ONES_25 : `ZERO_25, `A};
`LOGIC_33 sext_ea_33; assign sext_ea_33 = {`eA[31], `eA};

`LOGIC_8 sext_c_8; assign sext_c_8 = `C ? 8'hFF : `ZERO_8;
`LOGIC_9 sext_c_9; assign sext_c_9 = `C ? 9'h1FF : `ZERO_9;
`LOGIC_32 sext_c_32; assign sext_c_32 = `C ? `ONES_32 : `ZERO_32;
`LOGIC_33 sext_c_33; assign sext_c_33 = `C ? `ONES_33 : `ZERO_33;

`LOGIC_9 sext_src_9; assign sext_src_9 = {reg_src_data[7], `SRC};
`LOGIC_16 sext_src_16; assign sext_src_16 = {reg_src_data[7] ? `ONES_8 : `ZERO_8, `SRC};
`LOGIC_32 sext_src_32; assign sext_src_32 = {reg_src_data[7] ? `ONES_24 : `ZERO_24, `SRC};
`LOGIC_33 sext_src_33; assign sext_src_33 = {reg_src_data[7] ? `ONES_25 : `ZERO_25, `SRC};
`LOGIC_33 sext_esrc_33; assign sext_esrc_33 = {reg_src_data[31], `eSRC};

`LOGIC_9 sext_x_9; assign sext_x_9 = {`X[7], `X};
`LOGIC_32 sext_x_32; assign sext_x_32 = {`X[7] ? `ONES_24 : `ZERO_24, `X};
`LOGIC_33 sext_x_33; assign sext_x_33 = {`X[7] ? `ONES_25 : `ZERO_25, `X};
`LOGIC_33 sext_ex_33; assign sext_ex_33 = {`eX[31], `eX};

`LOGIC_9 sext_y_9; assign sext_y_9 = {`Y[7], `Y};
`LOGIC_32 sext_y_32; assign sext_y_32 = {`Y[7] ? `ONES_24 : `ZERO_24, `Y};
`LOGIC_33 sext_y_33; assign sext_y_33 = {`Y[7] ? `ONES_25 : `ZERO_25, `Y};
`LOGIC_33 sext_ey_33; assign sext_ey_33 = {`eY[31], `eY};

`LOGIC_9 uext_a_9; assign uext_a_9 = { 1'd0, `A};
`LOGIC_32 uext_a_32; assign uext_a_32 = { `ZERO_24, `A};
`LOGIC_33 uext_a_33; assign uext_a_33 = { `ZERO_25, `A};
`LOGIC_33 uext_ea_33; assign uext_ea_33 = { 1'd0, `eA};

`LOGIC_8 uext_c_8; assign uext_c_8 = { `ZERO_7, `C};
`LOGIC_9 uext_c_9; assign uext_c_9 = { `ZERO_8, `C};
`LOGIC_32 uext_c_32; assign uext_c_32 = { `ZERO_31, `C};
`LOGIC_33 uext_c_33; assign uext_c_33 = { `ZERO_32, `C};

`LOGIC_8 uext_nc_8; assign uext_nc_8 = { `ZERO_7, `NC};
`LOGIC_9 uext_nc_9; assign uext_nc_9 = { `ZERO_8, `NC};
`LOGIC_32 uext_nc_32; assign uext_nc_32 = { `ZERO_31, `NC};
`LOGIC_33 uext_nc_33; assign uext_nc_33 = { `ZERO_32, `NC};

`LOGIC_17 uext_pc_17; assign uext_pc_17 = { 1'd0, `PC};
`LOGIC_32 uext_pc_32; assign uext_pc_32 = { `ZERO_16, `PC};
`LOGIC_33 uext_pc_33; assign uext_pc_33 = { `ZERO_17, `PC};
`LOGIC_33 uext_epc_33; assign uext_epc_33 = { 1'd0, `ePC};

`LOGIC_17 uext_sp_17; assign uext_sp_17 = { 1'd0, `SP};
`LOGIC_32 uext_sp_32; assign uext_sp_32 = { `ZERO_16, `SP};
`LOGIC_33 uext_sp_33; assign uext_sp_33 = { `ZERO_17, `SP};
`LOGIC_33 uext_esp_33; assign uext_esp_33 = { 1'd0, `eSP};

`LOGIC_9 uext_src_9; assign uext_src_9 = { 1'd0, `SRC};
`LOGIC_16 uext_src_16; assign uext_src_16 = { `ZERO_8, `SRC};
`LOGIC_32 uext_src_32; assign uext_src_32 = { `ZERO_24, `SRC};
`LOGIC_33 uext_src_33; assign uext_src_33 = { `ZERO_25, `SRC};
`LOGIC_33 uext_esrc_33; assign uext_esrc_33 = { 1'd0, `eSRC};

`LOGIC_9 uext_x_9; assign uext_x_9 = { 1'd0, `X};
`LOGIC_32 uext_x_32; assign uext_x_32 = { `ZERO_24, `X};
`LOGIC_33 uext_x_33; assign uext_x_33 = { `ZERO_25, `X};
`LOGIC_33 uext_ex_33; assign uext_ex_33 = { 1'd0, `eX};

`LOGIC_9 uext_y_9; assign uext_y_9 = { 1'd0, `Y};
`LOGIC_32 uext_y_32; assign uext_y_32 = { `ZERO_24, `Y};
`LOGIC_33 uext_y_33; assign uext_y_33 = { `ZERO_25, `Y};
`LOGIC_33 uext_ey_33; assign uext_ey_33 = { 1'd0, `eY};

`LOGIC_9 add_a_src; assign add_a_src = uext_a_9 + uext_src_9;
logic add_8_n; assign add_8_n = add_a_src[7];
logic add_8_v; assign add_8_v = add_a_src[8] ^ add_a_src[7];
logic add_8_z; assign add_8_z = (add_a_src`VB == `ZERO_8) ? 1 : 0;
logic add_8_c; assign add_8_c = add_a_src[8];

`LOGIC_33 add_ea_src; assign add_ea_src = uext_ea_33 + uext_esrc_33;
logic add_32_n; assign add_32_n = add_ea_src[31];
logic add_32_v; assign add_32_v = add_ea_src[32] ^ add_ea_src[31];
logic add_32_z; assign add_32_z = (add_ea_src`VW == `ZERO_32) ? 1 : 0;
logic add_32_c; assign add_32_c = add_ea_src[32];

`LOGIC_16 add_pc_src; assign add_pc_src = `PC + sext_src_16;

`LOGIC_32 add_epc_src; assign add_epc_src = `ePC + sext_src_32;

`LOGIC_9 adc_a_src; assign adc_a_src = uext_a_9 + uext_src_9 + uext_c_9;
logic adc_a_n; assign adc_a_n = adc_a_src[7];
logic adc_a_v; assign adc_a_v = adc_a_src[8] ^ adc_a_src[7];
logic adc_a_z; assign adc_a_z = (adc_a_src`VB == `ZERO_8) ? 1 : 0;
logic adc_a_c; assign adc_a_c = adc_a_src[8];

`LOGIC_33 adc_ea_src; assign adc_ea_src = uext_ea_33 + uext_esrc_33 + uext_c_33;
logic adc_ea_n; assign adc_ea_n = adc_ea_src[31];
logic adc_ea_v; assign adc_ea_v = adc_ea_src[32] ^ adc_ea_src[31];
logic adc_ea_z; assign adc_ea_z = (adc_ea_src`VW == `ZERO_32) ? 1 : 0;
logic adc_ea_c; assign adc_ea_c = adc_ea_src[32];

`LOGIC_8 and_a_src; assign and_a_src = `A & `SRC;
logic and_8_n; assign and_8_n = and_a_src[7];
logic and_8_z; assign and_8_z = (and_a_src == `ZERO_8) ? 1 : 0;

`LOGIC_32 and_ea_src; assign and_ea_src = `eA & `eSRC;
logic and_32_n; assign and_32_n = and_ea_src[31];
logic and_32_z; assign and_32_z = (and_ea_src == `ZERO_32) ? 1 : 0;

`LOGIC_8 asl_a; assign asl_a = {`A[6:0], 1'b0};
logic asl_a_n; assign asl_a_n = asl_a[7];
logic asl_a_z; assign asl_a_z = (asl_a == `ZERO_8) ? 1 : 0;
logic asl_a_c; assign asl_a_c = `A[7];

`LOGIC_32 asl_ea; assign asl_ea = {`eA[30:0], 1'b0};
logic asl_ea_n; assign asl_ea_n = asl_ea[31];
logic asl_ea_z; assign asl_ea_z = (asl_ea == `ZERO_32) ? 1 : 0;
logic asl_ea_c; assign asl_ea_c = `eA[31];

`LOGIC_8 dec_a; assign dec_a = `A - `ONE_8;
logic dec_a_n; assign dec_a_n = dec_a[7];
logic dec_a_z; assign dec_a_z = (dec_a == `ZERO_8) ? 1 : 0;

`LOGIC_32 dec_ea; assign dec_ea = `eA - `ONE_32;
logic dec_ea_n; assign dec_ea_n = dec_ea[31];
logic dec_ea_z; assign dec_ea_z = (dec_ea == `ZERO_32) ? 1 : 0;

`LOGIC_8 dec_pc; assign dec_pc = `PC - `ONE_8;

`LOGIC_32 dec_epc; assign dec_epc = `ePC - `ONE_32;

`LOGIC_8 dec_sp; assign dec_sp = `SP - `ONE_8;

`LOGIC_32 dec_esp; assign dec_esp = `eSP - `ONE_32;

`LOGIC_8 dec_x; assign dec_x = `X - `ONE_8;
logic dec_x_n; assign dec_x_n = dec_x[7];
logic dec_x_z; assign dec_x_z = (dec_x == `ZERO_8) ? 1 : 0;

`LOGIC_32 dec_ex; assign dec_ex = `eX - `ONE_32;
logic dec_ex_n; assign dec_ex_n = dec_ex[31];
logic dec_ex_z; assign dec_ex_z = (dec_ex == `ZERO_32) ? 1 : 0;

`LOGIC_8 dec_y; assign dec_y = `Y - `ONE_8;
logic dec_y_n; assign dec_y_n = dec_y[7];
logic dec_y_z; assign dec_y_z = (dec_y == `ZERO_8) ? 1 : 0;

`LOGIC_32 dec_ey; assign dec_ey = `eY - `ONE_32;
logic dec_ey_n; assign dec_ey_n = dec_ey[31];
logic dec_ey_z; assign dec_ey_z = (dec_ey == `ZERO_32) ? 1 : 0;

`LOGIC_8 eor_a_src; assign eor_a_src = `A ^ `SRC;
logic eor_a_n; assign eor_a_n = eor_a_src[7];
logic eor_a_z; assign eor_a_z = (eor_a_src == `ZERO_8) ? 1 : 0;

`LOGIC_32 eor_ea_src; assign eor_ea_src = `eA ^ `eSRC;
logic eor_ea_n; assign eor_ea_n = eor_ea_src[31];
logic eor_ea_z; assign eor_ea_z = (eor_ea_src == `ZERO_32) ? 1 : 0;

`LOGIC_8 inc_a; assign inc_a = `A + `ONE_8;
logic inc_a_n; assign inc_a_n = inc_a[7];
logic inc_a_z; assign inc_a_z = (inc_a == `ZERO_8) ? 1 : 0;

`LOGIC_32 inc_ea; assign inc_ea = `eA + `ONE_32;
logic inc_ea_n; assign inc_ea_n = inc_ea[31];
logic inc_ea_z; assign inc_ea_z = (inc_ea == `ZERO_32) ? 1 : 0;

`LOGIC_8 inc_pc; assign inc_pc = `PC + `ONE_8;

`LOGIC_32 inc_epc; assign inc_epc = `ePC + `ONE_32;

`LOGIC_8 inc_sp; assign inc_sp = `SP + `ONE_8;

`LOGIC_32 inc_esp; assign inc_esp = `eSP + `ONE_32;

`LOGIC_8 inc_x; assign inc_x = `X + `ONE_8;
logic inc_x_n; assign inc_x_n = inc_x[7];
logic inc_x_z; assign inc_x_z = (inc_x == `ZERO_8) ? 1 : 0;

`LOGIC_32 inc_ex; assign inc_ex = `eX + `ONE_32;
logic inc_ex_n; assign inc_ex_n = inc_ex[31];
logic inc_ex_z; assign inc_ex_z = (inc_ex == `ZERO_32) ? 1 : 0;

`LOGIC_8 inc_y; assign inc_y = `Y + `ONE_8;
logic inc_y_n; assign inc_y_n = inc_y[7];
logic inc_y_z; assign inc_y_z = (inc_y == `ZERO_8) ? 1 : 0;

`LOGIC_32 inc_ey; assign inc_ey = `eY + `ONE_32;
logic inc_ey_n; assign inc_ey_n = inc_ey[31];
logic inc_ey_z; assign inc_ey_z = (inc_ey == `ZERO_32) ? 1 : 0;

`LOGIC_8 neg_a; assign neg_a = `ZERO_8 - `A;
logic neg_a_n; assign neg_a_n = neg_a[7];
logic neg_a_z; assign neg_a_z = (neg_a == `ZERO_8) ? 1 : 0;

`LOGIC_32 neg_ea; assign neg_ea = `ZERO_32 - `eA;
logic neg_ea_n; assign neg_ea_n = neg_ea[31];
logic neg_ea_z; assign neg_ea_z = (neg_ea == `ZERO_32) ? 1 : 0;

`LOGIC_8 not_a; assign not_a = ~`A;
logic not_a_n; assign not_a_n = not_a[7];
logic not_a_z; assign not_a_z = (not_a == `ZERO_8) ? 1 : 0;

`LOGIC_32 not_ea; assign not_ea = ~`eA;
logic not_ea_n; assign not_ea_n = not_ea[31];
logic not_ea_z; assign not_ea_z = (not_ea == `ZERO_32) ? 1 : 0;

`LOGIC_8 or_a_src; assign or_a_src = `A | `SRC;
logic or_a_n; assign or_a_n = or_a_src[7];
logic or_a_z; assign or_a_z = (or_a_src == `ZERO_8) ? 1 : 0;

`LOGIC_32 or_ea_src; assign or_ea_src = `eA | `eSRC;
logic or_32_n; assign or_32_n = or_ea_src[31];
logic or_32_z; assign or_32_z = (or_ea_src == `ZERO_32) ? 1 : 0;

`LOGIC_8 rol_a; assign rol_a = {`A[6:0], `C};
logic rol_a_n; assign rol_a_n = rol_a[7];
logic rol_a_z; assign rol_a_z = (rol_a == `ZERO_8) ? 1 : 0;
logic rol_a_c; assign rol_a_c = `A[7];

`LOGIC_32 rol_ea; assign rol_ea = {`eA[30:0], `eC};
logic rol_ea_n; assign rol_ea_n = rol_ea[31];
logic rol_ea_z; assign rol_ea_z = (rol_ea == `ZERO_32) ? 1 : 0;
logic rol_ea_c; assign rol_ea_c = `eA[31];

`LOGIC_8 ror_a; assign ror_a = {`C, `A[7:1]};
logic ror_a_n; assign ror_a_n = ror_a[7];
logic ror_a_z; assign ror_a_z = (ror_a == `ZERO_8) ? 1 : 0;
logic ror_a_c; assign ror_a_c = `A[0];

`LOGIC_32 ror_ea; assign ror_ea = {`eC, `eA[30:0]};
logic ror_ea_n; assign ror_ea_n = ror_ea[31];
logic ror_ea_z; assign ror_ea_z = (ror_ea == `ZERO_32) ? 1 : 0;
logic ror_ea_c; assign ror_ea_c = `eA[0];

`LOGIC_9 sbc_a_src; assign sbc_a_src = uext_a_9 - uext_src_9 - uext_nc_9;
logic sbc_a_n; assign sbc_a_n = sbc_a_src[7];
logic sbc_a_v; assign sbc_a_v = sbc_a_src[8] ^ sbc_a_src[7];
logic sbc_a_z; assign sbc_a_z = (sbc_a_src`VB == `ZERO_8) ? 1 : 0;
logic sbc_a_c; assign sbc_a_c = sbc_a_src[8];

`LOGIC_33 sbc_ea_src; assign sbc_ea_src = uext_ea_33 - uext_esrc_33 - uext_nc_33;
logic sbc_ea_n; assign sbc_ea_n = sbc_ea_src[31];
logic sbc_ea_v; assign sbc_ea_v = sbc_ea_src[32] ^ sbc_ea_src[31];
logic sbc_ea_z; assign sbc_ea_z = (sbc_ea_src`VW == `ZERO_32) ? 1 : 0;
logic sbc_ea_c; assign sbc_ea_c = sbc_ea_src[32];

`LOGIC_9 sub_a_src; assign sub_a_src = uext_a_9 - uext_src_9;
logic sub_a_n; assign sub_a_n = sub_a_src[7];
logic sub_a_v; assign sub_a_v = sub_a_src[8] ^ sub_a_src[7];
logic sub_a_z; assign sub_a_z = (sub_a_src`VB == `ZERO_8) ? 1 : 0;
logic sub_a_c; assign sub_a_c = sub_a_src[8];

`LOGIC_33 sub_ea_src; assign sub_ea_src = uext_ea_33 - uext_esrc_33;
logic sub_ea_n; assign sub_ea_n = sub_ea_src[31];
logic sub_ea_v; assign sub_ea_v = sub_ea_src[32] ^ sub_ea_src[31];
logic sub_ea_z; assign sub_ea_z = (sub_ea_src`VW == `ZERO_32) ? 1 : 0;
logic sub_ea_c; assign sub_ea_c = sub_ea_src[32];

always @(posedge i_rst or posedge i_clk) begin
    integer i;

    if (i_rst) begin
        reg_6502 <= 1;
        `PC <= 16'hFFFC;
        `SP <= 16'h0100;
        `P <= 8'b00110100;
        `X <= `ZERO_8;
        `Y <= `ZERO_8;

        reg_65832 <= 0;
        `ePC <= `ZERO_32;
        `eSP <= `ZERO_32;
        `eP <= 8'b00110100;
        `eX <= `ZERO_32;
        `eY <= `ZERO_32;

        reg_cycle <= 0;
        reg_which <= 0;
        reg_address <= 0;
        reg_src_data <= 0;
        reg_dst_data <= 0;

        am_ABS_a <= 0;
        am_ACC_A <= 0;
        am_AIA_A <= 0;
        am_AIIX_A_X <= 0;
        am_AIX_a_x <= 0;
        am_AIY_a_y <= 0;
        ame_ABS_a <= 0;
        ame_AIA_A <= 0;
        ame_AIIX_A_X <= 0;
        ame_AIIY_A_y <= 0;
        ame_AIX_a_x <= 0;
        ame_AIY_a_y <= 0;
        ame_STK_s <= 0;
        am_IMM_m <= 0;
        am_IMP_i <= 0;
        am_PCR_r <= 0;
        am_STK_s <= 0;
        am_STK_s <= 0;
        am_ZIIX_ZP_X <= 0;
        am_ZIIY_ZP_y <= 0;
        am_ZIX_zp_x <= 0;
        am_ZIY_zp_y <= 0;
        am_ZPG_zp <= 0;
        am_ZPI_ZP <= 0;
        op_ADC <= 0;
        op_ADD <= 0;
        op_AND <= 0;
        op_ASL <= 0;
        op_BBR <= 0;
        op_BBS <= 0;
        op_BCC <= 0;
        op_BCS <= 0;
        op_BEQ <= 0;
        op_BIT <= 0;
        op_BMI <= 0;
        op_BNE <= 0;
        op_BPL <= 0;
        op_BRA <= 0;
        op_BRK <= 0;
        op_BVC <= 0;
        op_BVS <= 0;
        op_CMP <= 0;
        op_CPX <= 0;
        op_CPY <= 0;
        op_DEC <= 0;
        op_EOR <= 0;
        op_INC <= 0;
        op_JMP <= 0;
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
        op_STX <= 0;
        op_STY <= 0;
        op_STY <= 0;
        op_STZ <= 0;
        op_STZ <= 0;
        op_SUB <= 0;
        op_TRB <= 0;
        op_TSB <= 0;
        op_WAI <= 0;

    end else begin

        if (reg_6502) begin
            if (reg_cycle == 0) begin
                var_opcode = reg_ram[`ePC];
                `ePC <= inc_epc;
                case (var_opcode)
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
                            reg_which <= var_opcode[6:4];
                        end

                    8'h08: begin
                            op_PHP <= 1;
                            am_STK_s <= 1;
                        end

                    8'h09: begin
                            op_ORA <= 1;
                            am_IMM_m <= 1;
                        end

                    8'h0A: begin
                            op_ASL <= 1;
                            am_ACC_A <= 1;
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
                            reg_which <= var_opcode[6:4];
                        end

                    8'h10: begin
                            op_BPL <= 1;
                            am_PCR_r <= 1;
                        end

                    8'h11: begin
                            op_ORA <= 1;
                            am_ZIIY_ZP_y <= 1;
                        end

                    8'h12: begin
                            op_ORA <= 1;
                            am_ZPI_ZP <= 1;
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
                        end

                    8'h19: begin
                            op_ORA <= 1;
                            am_AIY_a_y <= 1;
                        end

                    8'h1A: begin
                            op_INC <= 1;
                            am_ACC_A <= 1;
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

                    8'h22: begin
                            op_JSR <= 1;
                            am_AIA_A <= 1;
                        end

                    8'h23: begin
                            op_SUB <= 1;
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
                            am_STK_s <= 1;
                        end

                    8'h29: begin
                            op_AND <= 1;
                            am_IMM_m <= 1;
                        end

                    8'h2A: begin
                            op_ROL <= 1;
                            am_ACC_A <= 1;
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
                            op_BMI <= 1;
                            am_PCR_r <= 1;
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
                        end

                    8'h39: begin
                            op_AND <= 1;
                            am_AIY_a_y <= 1;
                        end

                    8'h3A: begin
                            op_DEC <= 1;
                            am_ACC_A <= 1;
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
                            op_PHA <= 1;
                            am_STK_s <= 1;
                        end

                    8'h49: begin
                            op_EOR <= 1;
                            am_IMM_m <= 1;
                        end

                    8'h4A: begin
                            op_LSR <= 1;
                            am_ACC_A <= 1;
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
                            op_BVC <= 1;
                            am_PCR_r <= 1;
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
                            op_PHY <= 1;
                            am_STK_s <= 1;
                        end

                    8'h5C: begin
                            op_JSR <= 1;
                            am_AIIX_A_X <= 1;
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
                            am_STK_s <= 1;
                        end

                    8'h69: begin
                            op_ADC <= 1;
                            am_IMM_m <= 1;
                        end

                    8'h6A: begin
                            op_ROR <= 1;
                            am_ACC_A <= 1;
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
                            op_BVS <= 1;
                            am_PCR_r <= 1;
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
                        end

                    8'h79: begin
                            op_ADC <= 1;
                            am_AIY_a_y <= 1;
                        end

                    8'h7A: begin
                            op_PLY <= 1;
                            am_STK_s <= 1;
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
                            op_BRA <= 1;
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
                            reg_which <= var_opcode[6:4];
                        end

                    8'h88: begin
                            // DEY
                            `Y <= `Y - 1;
                        end

                    8'h89: begin
                            op_BIT <= 1;
                            am_IMM_m <= 1;
                        end

                    8'h8A: begin
                            // TXA
                            `A <= `X;
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
                            reg_which <= var_opcode[6:4];
                        end

                    8'h90: begin
                            op_BCC <= 1;
                            am_PCR_r <= 1;
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
                        end

                    8'h99: begin
                            op_STA <= 1;
                            am_AIY_a_y <= 1;
                        end

                    8'h9A: begin
                            // TXS
                            `SP <= `X;
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
                        end

                    8'hA9: begin
                            op_LDA <= 1;
                            am_IMM_m <= 1;
                        end

                    8'hAA: begin
                            // TAX
                            `X <= `A;
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
                            op_BCS <= 1;
                            am_PCR_r <= 1;
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
                        end

                    8'hB9: begin
                            op_LDA <= 1;
                            am_AIY_a_y <= 1;
                        end

                    8'hBA: begin
                            // TSX
                            `X <= `SP;
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
                            `Y <= `Y + 1;
                        end

                    8'hC9: begin
                            op_CMP <= 1;
                            am_IMM_m <= 1;
                        end

                    8'hCA: begin
                            // DEX
                            `X <= `X - 1;
                        end

                    8'hCB: begin
                            op_WAI <= 1;
                            am_IMP_i <= 1;
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
                            op_BNE <= 1;
                            am_PCR_r <= 1;
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
                        end

                    8'hD9: begin
                            op_CMP <= 1;
                            am_AIY_a_y <= 1;
                        end

                    8'hDA: begin
                            op_PHX <= 1;
                            am_STK_s <= 1;
                        end

                    8'hDB: begin
                            op_STP <= 1;
                            am_IMP_i <= 1;
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
                            `X <= `X + 1;
                        end

                    8'hE9: begin
                            op_SBC <= 1;
                            am_IMM_m <= 1;
                        end

                    8'hEA: begin
                            // NOP
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
                            op_BEQ <= 1;
                            am_PCR_r <= 1;
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
                        end

                    8'hF9: begin
                            op_SBC <= 1;
                            am_AIY_a_y <= 1;
                        end

                    8'hFA: begin
                            op_PLX <= 1;
                            am_STK_s <= 1;
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
        end else begin
            if (reg_cycle == 0) begin
                var_opcode = reg_ram[`ePC];
                `ePC <= inc_epc;
                case (var_opcode)
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
                            op_BPL <= 1;
							ame_PCR_r <= 1;
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
                        end

                    8'h19: begin
                            op_ORA <= 1;
							ame_AIY_a_y <= 1;
                        end

                    8'h1A: begin
                            op_INC <= 1;
							ame_ACC_A <= 1;
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
                            op_BMI <= 1;
							ame_PCR_r <= 1;
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
                        end

                    8'h39: begin
                            op_AND <= 1;
							ame_AIY_a_y <= 1;
                        end

                    8'h3A: begin
                            op_DEC <= 1;
							ame_ACC_A <= 1;
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
                            op_BVC <= 1;
							ame_PCR_r <= 1;
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
                            op_BVS <= 1;
							ame_PCR_r <= 1;
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
                            op_BRA <= 1;
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
                            reg_y <= reg_y - 1;
                        end

                    8'h89: begin
                            op_BIT <= 1;
							ame_IMM_m <= 1;
                        end

                    8'h8A: begin
                            // TXA
                            reg_a <= reg_x;
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
                            op_BCC <= 1;
							ame_PCR_r <= 1;
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
                        end

                    8'h99: begin
                            op_STA <= 1;
							ame_AIY_a_y <= 1;
                        end

                    8'h9A: begin
                            // TXS
                            reg_sp <= reg_x;
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
                            reg_y <= reg_a;
                        end

                    8'hA9: begin
                            op_LDA <= 1;
							ame_IMM_m <= 1;
                        end

                    8'hAA: begin
                            // TAX
                            reg_x <= reg_a;
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
                            op_BCS <= 1;
							ame_PCR_r <= 1;
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
                        end

                    8'hB9: begin
                            op_LDA <= 1;
							ame_AIY_a_y <= 1;
                        end

                    8'hBA: begin
                            // TSX
                            reg_x <= reg_sp;
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
                            reg_y <= reg_y + 1;
                        end

                    8'hC9: begin
                            op_CMP <= 1;
							ame_IMM_m <= 1;
                        end

                    8'hCA: begin
                            // DEX
                            reg_x <= reg_x - 1;
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
                            op_BNE <= 1;
							ame_PCR_r <= 1;
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
                            reg_x <= reg_x + 1;
                        end

                    8'hE9: begin
                            op_SBC <= 1;
							ame_IMM_m <= 1;
                        end

                    8'hEA: begin
                            // NOP
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
                            op_BEQ <= 1;
							ame_PCR_r <= 1;
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
        end
    end
end

endmodule
