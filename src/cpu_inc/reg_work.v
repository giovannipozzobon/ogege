`define SRC   reg_src_data`VB
`define eSRC  reg_src_data`VW
`define eSRC0 reg_src_data[7:0]
`define eSRC1 reg_src_data[15:8]
`define eSRC2 reg_src_data[23:16]
`define eSRC3 reg_src_data[31:24]

`define DST   reg_dst_data`VB
`define eDST  reg_dst_data`VW
`define eDST0 reg_dst_data[7:0]
`define eDST1 reg_dst_data[15:8]
`define eDST2 reg_dst_data[23:16]
`define eDST3 reg_dst_data[31:24]

// Processing registers
wire delaying;
reg [3:0] reg_cycle;
reg reg_6502;
reg reg_65832;
reg [2:0] reg_which;
reg `VW reg_address;
reg `VW reg_ind_address;
reg `VW reg_src_data;
reg `VW reg_dst_data;
reg `VB reg_code_byte;
reg `VB reg_data_byte;
reg `VW reg_code_word;
reg `VW reg_data_word;
reg `VW reg_offset;

wire cycle_0; assign cycle_0 = (reg_cycle == 0);
wire cycle_1; assign cycle_1 = (reg_cycle == 1);
wire cycle_2; assign cycle_2 = (reg_cycle == 2);
wire cycle_3; assign cycle_3 = (reg_cycle == 3);
wire cycle_4; assign cycle_4 = (reg_cycle == 4);
wire cycle_5; assign cycle_5 = (reg_cycle == 5);
wire cycle_6; assign cycle_6 = (reg_cycle == 6);
wire cycle_7; assign cycle_7 = (reg_cycle == 7);

wire cycle_0_6502; assign cycle_0_6502 = (cycle_0 & reg_6502);
wire cycle_1_6502; assign cycle_1_6502 = (cycle_1 & reg_6502);
wire cycle_2_6502; assign cycle_2_6502 = (cycle_2 & reg_6502);
wire cycle_3_6502; assign cycle_3_6502 = (cycle_3 & reg_6502);
wire cycle_4_6502; assign cycle_4_6502 = (cycle_4 & reg_6502);
wire cycle_5_6502; assign cycle_5_6502 = (cycle_5 & reg_6502);
wire cycle_6_6502; assign cycle_6_6502 = (cycle_6 & reg_6502);
wire cycle_7_6502; assign cycle_7_6502 = (cycle_7 & reg_6502);

wire cycle_0_65832; assign cycle_0_65832 = (cycle_0 & reg_65832);
wire cycle_1_65832; assign cycle_1_65832 = (cycle_1 & reg_65832);
wire cycle_2_65832; assign cycle_2_65832 = (cycle_2 & reg_65832);
wire cycle_3_65832; assign cycle_3_65832 = (cycle_3 & reg_65832);
wire cycle_4_65832; assign cycle_4_65832 = (cycle_4 & reg_65832);
wire cycle_5_65832; assign cycle_5_65832 = (cycle_5 & reg_65832);
wire cycle_6_65832; assign cycle_6_65832 = (cycle_6 & reg_65832);
wire cycle_7_65832; assign cycle_7_65832 = (cycle_7 & reg_65832);

wire op_00_BRK; assign op_00_BRK = (reg_code_byte == 8'h00);
wire op_01_ORA; assign op_01_ORA = (reg_code_byte == 8'h01);
wire op_02_ADD; assign op_02_ADD = (reg_code_byte == 8'h02);
wire op_03_SUB; assign op_03_SUB = (reg_code_byte == 8'h03); // New (custom) instruction: Subtract immediate value from accumulator
wire op_04_TSB; assign op_04_TSB = (reg_code_byte == 8'h04);
wire op_05_ORA; assign op_05_ORA = (reg_code_byte == 8'h05);
wire op_06_ASL; assign op_06_ASL = (reg_code_byte == 8'h06);
wire op_07_RMB0; assign op_07_RMB0 = (reg_code_byte == 8'h07);
wire op_08_PHP; assign op_08_PHP = (reg_code_byte == 8'h08);
wire op_09_ORA; assign op_09_ORA = (reg_code_byte == 8'h09);
wire op_0A_ASL; assign op_0A_ASL = (reg_code_byte == 8'h0A);
wire op_0B; assign op_0B = (reg_code_byte == 8'h0B);
wire op_0C_TSB; assign op_0C_TSB = (reg_code_byte == 8'h0C);
wire op_0D_ORA; assign op_0D_ORA = (reg_code_byte == 8'h0D);
wire op_0E_ASL; assign op_0E_ASL = (reg_code_byte == 8'h0E);
wire op_0F_BBR0; assign op_0F_BBR0 = (reg_code_byte == 8'h0F);
wire op_10_BPL; assign op_10_BPL = (reg_code_byte == 8'h10);
wire op_11_ORA; assign op_11_ORA = (reg_code_byte == 8'h11);
wire op_12_ORA; assign op_12_ORA = (reg_code_byte == 8'h12);
wire op_13_NEG; assign op_13_NEG = (reg_code_byte == 8'h13); // New (custom) instruction: Arithmetic negate accumulator
wire op_14_TRB; assign op_14_TRB = (reg_code_byte == 8'h14);
wire op_15_ORA; assign op_15_ORA = (reg_code_byte == 8'h15);
wire op_16_ASL; assign op_16_ASL = (reg_code_byte == 8'h16);
wire op_17_RMB1; assign op_17_RMB1 = (reg_code_byte == 8'h17);
wire op_18_CLC; assign op_18_CLC = (reg_code_byte == 8'h18);
wire op_19_ORA; assign op_19_ORA = (reg_code_byte == 8'h19);
wire op_1A_INC; assign op_1A_INC = (reg_code_byte == 8'h1A);
wire op_1B; assign op_1B = (reg_code_byte == 8'h1B);
wire op_1C_TRB; assign op_1C_TRB = (reg_code_byte == 8'h1C);
wire op_1D_ORA; assign op_1D_ORA = (reg_code_byte == 8'h1D);
wire op_1E_ASL; assign op_1E_ASL = (reg_code_byte == 8'h1E);
wire op_1F_BBR1; assign op_1F_BBR1 = (reg_code_byte == 8'h1F);
wire op_20_JSR; assign op_20_JSR = (reg_code_byte == 8'h20);
wire op_21_AND; assign op_21_AND = (reg_code_byte == 8'h21);
wire op_22; assign op_22 = (reg_code_byte == 8'h22);
wire op_23_NOT; assign op_23_NOT = (reg_code_byte == 8'h23); // New (custom) instruction: Bitwise invert accumulator
wire op_24_BIT; assign op_24_BIT = (reg_code_byte == 8'h24);
wire op_25; assign op_25 = (reg_code_byte == 8'h25);
wire op_26_ROL; assign op_26_ROL = (reg_code_byte == 8'h26);
wire op_27_RMB2; assign op_27_RMB2 = (reg_code_byte == 8'h27);
wire op_28_PLP; assign op_28_PLP = (reg_code_byte == 8'h28);
wire op_29_AND; assign op_29_AND = (reg_code_byte == 8'h29);
wire op_2A_ROL; assign op_2A_ROL = (reg_code_byte == 8'h2A);
wire op_2B; assign op_2B = (reg_code_byte == 8'h2B);
wire op_2C_BIT; assign op_2C_BIT = (reg_code_byte == 8'h2C);
wire op_2D_AND; assign op_2D_AND = (reg_code_byte == 8'h2D);
wire op_2E_ROL; assign op_2E_ROL = (reg_code_byte == 8'h2E);
wire op_2F_BBR2; assign op_2F_BBR2 = (reg_code_byte == 8'h2F);
wire op_30_BMI; assign op_30_BMI = (reg_code_byte == 8'h30);
wire op_31_AND; assign op_31_AND = (reg_code_byte == 8'h31);
wire op_32_AND; assign op_32_AND = (reg_code_byte == 8'h32);
wire op_33_WTX; assign op_33_WTX = (reg_code_byte == 8'h33); // New (custom) instruction: Write to text controller
wire op_34_BIT; assign op_34_BIT = (reg_code_byte == 8'h34);
wire op_35_AND; assign op_35_AND = (reg_code_byte == 8'h35);
wire op_36_ROL; assign op_36_ROL = (reg_code_byte == 8'h36);
wire op_37_RMB3; assign op_37_RMB3 = (reg_code_byte == 8'h37);
wire op_38_SEC; assign op_38_SEC = (reg_code_byte == 8'h38);
wire op_39_AND; assign op_39_AND = (reg_code_byte == 8'h39);
wire op_3A_DEC; assign op_3A_DEC = (reg_code_byte == 8'h3A);
wire op_3B; assign op_3B = (reg_code_byte == 8'h3B);
wire op_3C_BIT; assign op_3C_BIT = (reg_code_byte == 8'h3C);
wire op_3D_AND; assign op_3D_AND = (reg_code_byte == 8'h3D);
wire op_3E_ROL; assign op_3E_ROL = (reg_code_byte == 8'h3E);
wire op_3F_BBR3; assign op_3F_BBR3 = (reg_code_byte == 8'h3F);
wire op_40_RTI; assign op_40_RTI = (reg_code_byte == 8'h40);
wire op_41_EOR; assign op_41_EOR = (reg_code_byte == 8'h41);
wire op_42; assign op_42 = (reg_code_byte == 8'h42);
wire op_43_RTX; assign op_43_RTX = (reg_code_byte == 8'h43); // New (custom) instruction: Read from text controller
wire op_44; assign op_44 = (reg_code_byte == 8'h44);
wire op_45_EOR; assign op_45_EOR = (reg_code_byte == 8'h45);
wire op_46_LSR; assign op_46_LSR = (reg_code_byte == 8'h46);
wire op_47_RMB4; assign op_47_RMB4 = (reg_code_byte == 8'h47);
wire op_48_PHA; assign op_48_PHA = (reg_code_byte == 8'h48);
wire op_49_EOR; assign op_49_EOR = (reg_code_byte == 8'h49);
wire op_4A_LSR; assign op_4A_LSR = (reg_code_byte == 8'h4A);
wire op_4B; assign op_4B = (reg_code_byte == 8'h4B);
wire op_4C_JMP; assign op_4C_JMP = (reg_code_byte == 8'h4C);
wire op_4D_EOR; assign op_4D_EOR = (reg_code_byte == 8'h4D);
wire op_4E_LSR; assign op_4E_LSR = (reg_code_byte == 8'h4E);
wire op_4F_BBR4; assign op_4F_BBR4 = (reg_code_byte == 8'h4F);
wire op_50_BVC; assign op_50_BVC = (reg_code_byte == 8'h50);
wire op_51_EOR; assign op_51_EOR = (reg_code_byte == 8'h51);
wire op_52_EOR; assign op_52_EOR = (reg_code_byte == 8'h52);
wire op_53; assign op_53 = (reg_code_byte == 8'h53);
wire op_54; assign op_54 = (reg_code_byte == 8'h54);
wire op_55_EOR; assign op_55_EOR = (reg_code_byte == 8'h55);
wire op_56_LSR; assign op_56_LSR = (reg_code_byte == 8'h56);
wire op_57_RMB5; assign op_57_RMB5 = (reg_code_byte == 8'h57);
wire op_58_CLI; assign op_58_CLI = (reg_code_byte == 8'h58);
wire op_59_EOR; assign op_59_EOR = (reg_code_byte == 8'h59);
wire op_5A_PHY; assign op_5A_PHY = (reg_code_byte == 8'h5A);
wire op_5B; assign op_5B = (reg_code_byte == 8'h5B);
wire op_5C; assign op_5C = (reg_code_byte == 8'h5C);
wire op_5D_EOR; assign op_5D_EOR = (reg_code_byte == 8'h5D);
wire op_5E_LSR; assign op_5E_LSR = (reg_code_byte == 8'h5E);
wire op_5F_BBR5; assign op_5F_BBR5 = (reg_code_byte == 8'h5F);
wire op_60_RTS; assign op_60_RTS = (reg_code_byte == 8'h60);
wire op_61_ADC; assign op_61_ADC = (reg_code_byte == 8'h61);
wire op_62; assign op_62 = (reg_code_byte == 8'h62);
wire op_63; assign op_63 = (reg_code_byte == 8'h63);
wire op_64_STZ; assign op_64_STZ = (reg_code_byte == 8'h64);
wire op_65_ADC; assign op_65_ADC = (reg_code_byte == 8'h65);
wire op_66_ROR; assign op_66_ROR = (reg_code_byte == 8'h66);
wire op_67_RMB6; assign op_67_RMB6 = (reg_code_byte == 8'h67);
wire op_68_PLA; assign op_68_PLA = (reg_code_byte == 8'h68);
wire op_69_ADC; assign op_69_ADC = (reg_code_byte == 8'h69);
wire op_6A_ROR; assign op_6A_ROR = (reg_code_byte == 8'h6A);
wire op_6B; assign op_6B = (reg_code_byte == 8'h6B);
wire op_6C_JMP; assign op_6C_JMP = (reg_code_byte == 8'h6C);
wire op_6D_ADC; assign op_6D_ADC = (reg_code_byte == 8'h6D);
wire op_6E_ROR; assign op_6E_ROR = (reg_code_byte == 8'h6E);
wire op_6F_BBR6; assign op_6F_BBR6 = (reg_code_byte == 8'h6F);
wire op_70_BVS; assign op_70_BVS = (reg_code_byte == 8'h70);
wire op_71_ADC; assign op_71_ADC = (reg_code_byte == 8'h71);
wire op_72_ADC; assign op_72_ADC = (reg_code_byte == 8'h72);
wire op_73; assign op_73 = (reg_code_byte == 8'h73);
wire op_74_STZ; assign op_74_STZ = (reg_code_byte == 8'h74);
wire op_75_ADC; assign op_75_ADC = (reg_code_byte == 8'h75);
wire op_76_ROR; assign op_76_ROR = (reg_code_byte == 8'h76);
wire op_77_RMB7; assign op_77_RMB7 = (reg_code_byte == 8'h77);
wire op_78_SEI; assign op_78_SEI = (reg_code_byte == 8'h78);
wire op_79_ADC; assign op_79_ADC = (reg_code_byte == 8'h79);
wire op_7A_PLY; assign op_7A_PLY = (reg_code_byte == 8'h7A);
wire op_7B; assign op_7B = (reg_code_byte == 8'h7B);
wire op_7C_JMP; assign op_7C_JMP = (reg_code_byte == 8'h7C);
wire op_7D_ADC; assign op_7D_ADC = (reg_code_byte == 8'h7D);
wire op_7E_ROR; assign op_7E_ROR = (reg_code_byte == 8'h7E);
wire op_7F_BBR7; assign op_7F_BBR7 = (reg_code_byte == 8'h7F);
wire op_80_BRA; assign op_80_BRA = (reg_code_byte == 8'h80);
wire op_81_STA; assign op_81_STA = (reg_code_byte == 8'h81);
wire op_82; assign op_82 = (reg_code_byte == 8'h82);
wire op_83; assign op_83 = (reg_code_byte == 8'h83);
wire op_84_STY; assign op_84_STY = (reg_code_byte == 8'h84);
wire op_85_STA; assign op_85_STA = (reg_code_byte == 8'h85);
wire op_86_STX; assign op_86_STX = (reg_code_byte == 8'h86);
wire op_87_SMB0; assign op_87_SMB0 = (reg_code_byte == 8'h87);
wire op_88_DEY; assign op_88_DEY = (reg_code_byte == 8'h88);
wire op_89_BIT; assign op_89_BIT = (reg_code_byte == 8'h89);
wire op_8A_TxA; assign op_8A_TxA = (reg_code_byte == 8'h8A);
wire op_8B; assign op_8B = (reg_code_byte == 8'h8B);
wire op_8C_STY; assign op_8C_STY = (reg_code_byte == 8'h8C);
wire op_8D_STA; assign op_8D_STA = (reg_code_byte == 8'h8D);
wire op_8E_STX; assign op_8E_STX = (reg_code_byte == 8'h8E);
wire op_8F_BBS0; assign op_8F_BBS0 = (reg_code_byte == 8'h8F);
wire op_90_BCC; assign op_90_BCC = (reg_code_byte == 8'h90);
wire op_91_STA; assign op_91_STA = (reg_code_byte == 8'h91);
wire op_92_STA; assign op_92_STA = (reg_code_byte == 8'h92);
wire op_93; assign op_93 = (reg_code_byte == 8'h93);
wire op_94_STY; assign op_94_STY = (reg_code_byte == 8'h94);
wire op_95_STA; assign op_95_STA = (reg_code_byte == 8'h95);
wire op_96_STX; assign op_96_STX = (reg_code_byte == 8'h96);
wire op_97_SMB1; assign op_97_SMB1 = (reg_code_byte == 8'h97);
wire op_98_TYA; assign op_98_TYA = (reg_code_byte == 8'h98);
wire op_99_STA; assign op_99_STA = (reg_code_byte == 8'h99);
wire op_9A_TXS; assign op_9A_TXS = (reg_code_byte == 8'h9A);
wire op_9B; assign op_9B = (reg_code_byte == 8'h9B);
wire op_9C_STZ; assign op_9C_STZ = (reg_code_byte == 8'h9C);
wire op_9D_STA; assign op_9D_STA = (reg_code_byte == 8'h9D);
wire op_9E_STZ; assign op_9E_STZ = (reg_code_byte == 8'h9E);
wire op_9F_BBS1; assign op_9F_BBS1 = (reg_code_byte == 8'h9F);
wire op_A0_LDY; assign op_A0_LDY = (reg_code_byte == 8'hA0);
wire op_A1_LDA; assign op_A1_LDA = (reg_code_byte == 8'hA1);
wire op_A2_LDX; assign op_A2_LDX = (reg_code_byte == 8'hA2);
wire op_A3; assign op_A3 = (reg_code_byte == 8'hA3);
wire op_A4_LDY; assign op_A4_LDY = (reg_code_byte == 8'hA4);
wire op_A5_LDA; assign op_A5_LDA = (reg_code_byte == 8'hA5);
wire op_A6_LDX; assign op_A6_LDX = (reg_code_byte == 8'hA6);
wire op_A7_SMB2; assign op_A7_SMB2 = (reg_code_byte == 8'hA7);
wire op_A8_TAY; assign op_A8_TAY = (reg_code_byte == 8'hA8);
wire op_A9_LDA; assign op_A9_LDA = (reg_code_byte == 8'hA9);
wire op_AA_TAX; assign op_AA_TAX = (reg_code_byte == 8'hAA);
wire op_AB; assign op_AB = (reg_code_byte == 8'hAB);
wire op_AC_LDY; assign op_AC_LDY = (reg_code_byte == 8'hAC);
wire op_AD_LDA; assign op_AD_LDA = (reg_code_byte == 8'hAD);
wire op_AE_LDX; assign op_AE_LDX = (reg_code_byte == 8'hAE);
wire op_AF_BBS2; assign op_AF_BBS2 = (reg_code_byte == 8'hAF);
wire op_B0_BCS; assign op_B0_BCS = (reg_code_byte == 8'hB0);
wire op_B1_LDA; assign op_B1_LDA = (reg_code_byte == 8'hB1);
wire op_B2_LDA; assign op_B2_LDA = (reg_code_byte == 8'hB2);
wire op_B3; assign op_B3 = (reg_code_byte == 8'hB3);
wire op_B4_LDY; assign op_B4_LDY = (reg_code_byte == 8'hB4);
wire op_B5_LDA; assign op_B5_LDA = (reg_code_byte == 8'hB5);
wire op_B6_LDX; assign op_B6_LDX = (reg_code_byte == 8'hB6);
wire op_B7_SMB3; assign op_B7_SMB3 = (reg_code_byte == 8'hB7);
wire op_B8_CLV; assign op_B8_CLV = (reg_code_byte == 8'hB8);
wire op_B9_LDA; assign op_B9_LDA = (reg_code_byte == 8'hB9);
wire op_BA_TSX; assign op_BA_TSX = (reg_code_byte == 8'hBA);
wire op_BB; assign op_BB = (reg_code_byte == 8'hBB);
wire op_BC_LDY; assign op_BC_LDY = (reg_code_byte == 8'hBC);
wire op_BD_LDA; assign op_BD_LDA = (reg_code_byte == 8'hBD);
wire op_BE_LDX; assign op_BE_LDX = (reg_code_byte == 8'hBE);
wire op_BF_BBS3; assign op_BF_BBS3 = (reg_code_byte == 8'hBF);
wire op_C0_CPY; assign op_C0_CPY = (reg_code_byte == 8'hC0);
wire op_C1_CMP; assign op_C1_CMP = (reg_code_byte == 8'hC1);
wire op_C2; assign op_C2 = (reg_code_byte == 8'hC2);
wire op_C3; assign op_C3 = (reg_code_byte == 8'hC3);
wire op_C4_CPY; assign op_C4_CPY = (reg_code_byte == 8'hC4);
wire op_C5_CMP; assign op_C5_CMP = (reg_code_byte == 8'hC5);
wire op_C6_DEC; assign op_C6_DEC = (reg_code_byte == 8'hC6);
wire op_C7_SMB4; assign op_C7_SMB4 = (reg_code_byte == 8'hC7);
wire op_C8_INY; assign op_C8_INY = (reg_code_byte == 8'hC8);
wire op_C9_CMP; assign op_C9_CMP = (reg_code_byte == 8'hC9);
wire op_CA_DEX; assign op_CA_DEX = (reg_code_byte == 8'hCA);
wire op_CB_WAI; assign op_CB_WAI = (reg_code_byte == 8'hCB);
wire op_CC_CPY; assign op_CC_CPY = (reg_code_byte == 8'hCC);
wire op_CD_CMP; assign op_CD_CMP = (reg_code_byte == 8'hCD);
wire op_CE_DEC; assign op_CE_DEC = (reg_code_byte == 8'hCE);
wire op_CF_BBS4; assign op_CF_BBS4 = (reg_code_byte == 8'hCF);
wire op_D0_BNE; assign op_D0_BNE = (reg_code_byte == 8'hD0);
wire op_D1_CMP; assign op_D1_CMP = (reg_code_byte == 8'hD1);
wire op_D2_CMP; assign op_D2_CMP = (reg_code_byte == 8'hD2);
wire op_D3; assign op_D3 = (reg_code_byte == 8'hD3);
wire op_D4; assign op_D4 = (reg_code_byte == 8'hD4);
wire op_D5; assign op_D5 = (reg_code_byte == 8'hD5);
wire op_D6_DEC; assign op_D6_DEC = (reg_code_byte == 8'hD6);
wire op_D7_SMB5; assign op_D7_SMB5 = (reg_code_byte == 8'hD7);
wire op_D8_CLD; assign op_D8_CLD = (reg_code_byte == 8'hD8);
wire op_D9_CMP; assign op_D9_CMP = (reg_code_byte == 8'hD9);
wire op_DA_PHX; assign op_DA_PHX = (reg_code_byte == 8'hDA);
wire op_DB_STP; assign op_DB_STP = (reg_code_byte == 8'hDB);
wire op_DC; assign op_DC = (reg_code_byte == 8'hDC);
wire op_DD_CMP; assign op_DD_CMP = (reg_code_byte == 8'hDD);
wire op_DE_DEC; assign op_DE_DEC = (reg_code_byte == 8'hDE);
wire op_DF_BBS5; assign op_DF_BBS5 = (reg_code_byte == 8'hDF);
wire op_E0_CPX; assign op_E0_CPX = (reg_code_byte == 8'hE0);
wire op_E1_SBC; assign op_E1_SBC = (reg_code_byte == 8'hE1);
wire op_E2; assign op_E2 = (reg_code_byte == 8'hE2);
wire op_E3; assign op_E3 = (reg_code_byte == 8'hE3);
wire op_E4_CPX; assign op_E4_CPX = (reg_code_byte == 8'hE4);
wire op_E5_SBC; assign op_E5_SBC = (reg_code_byte == 8'hE5);
wire op_E6_INC; assign op_E6_INC = (reg_code_byte == 8'hE6);
wire op_E7_SMB6; assign op_E7_SMB6 = (reg_code_byte == 8'hE7);
wire op_E8_INX; assign op_E8_INX = (reg_code_byte == 8'hE8);
wire op_E9_SBC; assign op_E9_SBC = (reg_code_byte == 8'hE9);
wire op_EA_NOP; assign op_EA_NOP = (reg_code_byte == 8'hEA);
wire op_EB; assign op_EB = (reg_code_byte == 8'hEB);
wire op_EC_CPX; assign op_EC_CPX = (reg_code_byte == 8'hEC);
wire op_ED_SBC; assign op_ED_SBC = (reg_code_byte == 8'hED);
wire op_EE_INC; assign op_EE_INC = (reg_code_byte == 8'hEE);
wire op_EF_BBS6; assign op_EF_BBS6 = (reg_code_byte == 8'hEF);
wire op_F0_BEQ; assign op_F0_BEQ = (reg_code_byte == 8'hF0);
wire op_F1_SBC; assign op_F1_SBC = (reg_code_byte == 8'hF1);
wire op_F2_SBC; assign op_F2_SBC = (reg_code_byte == 8'hF2);
wire op_F3; assign op_F3 = (reg_code_byte == 8'hF3);
wire op_F4; assign op_F4 = (reg_code_byte == 8'hF4);
wire op_F5_SBC; assign op_F5_SBC = (reg_code_byte == 8'hF5);
wire op_F6_INC; assign op_F6_INC = (reg_code_byte == 8'hF6);
wire op_F7_SMB7; assign op_F7_SMB7 = (reg_code_byte == 8'hF7);
wire op_F8_SED; assign op_F8_SED = (reg_code_byte == 8'hF8);
wire op_F9_SBC; assign op_F9_SBC = (reg_code_byte == 8'hF9);
wire op_FA_PLX; assign op_FA_PLX = (reg_code_byte == 8'hFA);
wire op_FB; assign op_FB = (reg_code_byte == 8'hFB);
wire op_FC; assign op_FC = (reg_code_byte == 8'hFC);
wire op_FD_SBC; assign op_FD_SBC = (reg_code_byte == 8'hFD);
wire op_FE_INC; assign op_FE_INC = (reg_code_byte == 8'hFE);
wire op_FF_BBS7; assign op_FF_BBS7 = (reg_code_byte == 8'hFF);

wire op_ADC; assign op_ADC = (op_61_ADC | op_65_ADC | op_69_ADC | op_6D_ADC | op_71_ADC | op_72_ADC | op_75_ADC | op_79_ADC | op_7D_ADC);
wire op_ADD; assign op_ADD = (op_02_ADD);
wire op_AND; assign op_AND = (op_21_AND | op_29_AND | op_2D_AND | op_31_AND | op_32_AND | op_35_AND | op_39_AND | op_3D_AND);
wire op_ASL; assign op_ASL = (op_06_ASL | op_0E_ASL | op_16_ASL | op_1E_ASL);
wire op_BBR; assign op_BBR = (op_0F_BBR0 | op_1F_BBR1 | op_2F_BBR2 | op_3F_BBR3 | op_4F_BBR4 | op_5F_BBR5 | op_6F_BBR6 | op_7F_BBR7);
wire op_BBS; assign op_BBS = (op_8F_BBS0 | op_9F_BBS1 | op_AF_BBS2 | op_BF_BBS3 | op_CF_BBS4 | op_DF_BBS5 | op_EF_BBS6 | op_FF_BBS7);
wire op_BIT; assign op_BIT = (op_24_BIT | op_2C_BIT | op_34_BIT | op_3C_BIT | op_89_BIT);
wire op_BRANCH; assign op_BRANCH =
    ((op_10_BPL & `NN) |
    (op_30_BMI & `N) |
    (op_50_BVC & `NV) |
    (op_70_BVS & `V) |
    op_80_BRA |
    (op_90_BCC & `NC) |
    (op_B0_BCS & `C) |
    (op_D0_BNE & `NZ) |
    (op_F0_BEQ & `Z));
wire op_BRK; assign op_BRK = (op_00_BRK);
wire op_CMP; assign op_CMP = (op_C1_CMP | op_C5_CMP | op_C9_CMP | op_CD_CMP | op_D1_CMP | op_D2_CMP | op_D9_CMP | op_DD_CMP);
wire op_CPX; assign op_CPX = (op_E0_CPX | op_E4_CPX | op_EC_CPX);
wire op_CPY; assign op_CPY = (op_C0_CPY | op_C4_CPY | op_CC_CPY);
wire op_DEC; assign op_DEC = (op_C6_DEC | op_CE_DEC | op_D6_DEC | op_DE_DEC);
wire op_EOR; assign op_EOR = (op_41_EOR | op_45_EOR | op_49_EOR | op_4D_EOR | op_51_EOR | op_52_EOR | op_55_EOR | op_59_EOR | op_5D_EOR);
wire op_INC; assign op_INC = (op_E6_INC | op_EE_INC | op_F6_INC | op_FE_INC);
wire op_JMP; assign op_JMP = (op_4C_JMP | op_6C_JMP | op_7C_JMP);
wire op_JSR; assign op_JSR = (op_20_JSR);
wire op_LDA; assign op_LDA = (op_A1_LDA | op_A5_LDA | op_A9_LDA | op_AD_LDA | op_B1_LDA | op_B2_LDA | op_B5_LDA | op_B9_LDA | op_BD_LDA);
wire op_LDX; assign op_LDX = (op_A2_LDX | op_A6_LDX | op_AE_LDX | op_B6_LDX | op_BE_LDX);
wire op_LDY; assign op_LDY = (op_A0_LDY | op_A4_LDY | op_AC_LDY | op_B4_LDY | op_BC_LDY);
wire op_LSR; assign op_LSR = (op_46_LSR | op_4E_LSR | op_56_LSR | op_5E_LSR);
wire op_NEG; assign op_NEG = (op_13_NEG);
wire op_ORA; assign op_ORA =
    (op_01_ORA | op_05_ORA | op_09_ORA | op_0D_ORA |
    op_11_ORA | op_12_ORA | op_15_ORA | op_19_ORA | op_1D_ORA);
wire op_PHA; assign op_PHA = (op_48_PHA);
wire op_PHP; assign op_PHP = (op_08_PHP);
wire op_PHX; assign op_PHX = (op_DA_PHX);
wire op_PHY; assign op_PHY = (op_5A_PHY);
wire op_PLA; assign op_PLA = (op_68_PLA);
wire op_PLP; assign op_PLP = (op_28_PLP);
wire op_PLX; assign op_PLX = (op_FA_PLX);
wire op_PLY; assign op_PLY = (op_7A_PLY);
wire op_RMB; assign op_RMB = (op_07_RMB0 | op_17_RMB1 | op_27_RMB2 | op_37_RMB3 | op_47_RMB4 | op_57_RMB5 | op_67_RMB6 | op_77_RMB7);
wire op_ROL; assign op_ROL = (op_26_ROL | op_2E_ROL | op_36_ROL | op_3E_ROL);
wire op_ROR; assign op_ROR = (op_66_ROR | op_6E_ROR | op_76_ROR | op_7E_ROR);
wire op_RTI; assign op_RTI = (op_40_RTI);
wire op_RTS; assign op_RTS = (op_60_RTS);
wire op_RTX; assign op_RTX = (op_43_RTX);
wire op_SBC; assign op_SBC = (op_E1_SBC | op_E5_SBC | op_E9_SBC | op_ED_SBC | op_F1_SBC | op_F2_SBC | op_F5_SBC | op_F9_SBC | op_FD_SBC);
wire op_SMB; assign op_SMB = (op_87_SMB0 | op_97_SMB1 | op_A7_SMB2 | op_B7_SMB3 | op_C7_SMB4 | op_D7_SMB5 | op_E7_SMB6 | op_F7_SMB7);
wire op_STA; assign op_STA = (op_81_STA | op_85_STA | op_8D_STA | op_91_STA | op_92_STA | op_95_STA | op_99_STA | op_9D_STA);
wire op_STP; assign op_STP = (op_DB_STP);
wire op_STX; assign op_STX = (op_86_STX | op_8E_STX | op_96_STX);
wire op_STY; assign op_STY = (op_84_STY | op_8C_STY | op_94_STY);
wire op_STZ; assign op_STZ = (op_64_STZ | op_74_STZ | op_9C_STZ | op_9E_STZ);
wire op_SUB; assign op_SUB = (op_03_SUB);
wire op_TRB; assign op_TRB = (op_14_TRB | op_1C_TRB);
wire op_TSB; assign op_TSB = (op_04_TSB | op_0C_TSB);
wire op_WAI; assign op_WAI = (op_CB_WAI);
wire op_WTX; assign op_WTX = (op_33_WTX);

wire am_ABS_a;       // Absolute a (6502)
wire am_ACC_A;       // Accumulator A (6502)
wire am_AIA_A;       // Absolute Indirect (a) (6502)
wire am_AIIX_A_X;    // Absolute Indexed Indirect with X (a,x) (6502)
wire am_AIX_a_x;     // Absolute Indexed with X a,x (6502)
wire am_AIY_a_y;     // Absolute Indexed with Y a,y (6502)
wire am_IMM_m;       // Immediate Addressing # (6502)
wire am_PCR_r;       // Program Counter Relative r (6502)
wire am_STK_s;       // Stack s (6502)
wire am_TXT;         // Text controller
wire am_ZIIX_ZP_X;   // Zero Page Indexed Indirect (zp,x) (6502)
wire am_ZIIY_ZP_y;   // Zero Page Indirect Indexed with Y (zp),y (6502)
wire am_ZIX_zp_x;    // Zero Page Indexed with X zp,x (6502)
wire am_ZIY_zp_y;    // Zero Page Indexed with Y zp,y (6502)
wire am_ZPG_zp;      // Zero Page zp (6502)
wire am_ZPI_ZP;      // Zero Page Indirect (zp) (6502)

wire ame_ABS_a;      // Absolute a (65832)
wire ame_ACC_A;      // Accumulator A (65832)
wire ame_AIA_A;      // Absolute Indirect (a) (65832)
wire ame_AIIX_A_X;   // Absolute Indexed Indirect with X (a,x) (65832)
wire ame_AIIY_A_y;   // Absolute Indexed Indirect with Y (a),y (65832)
wire ame_AIX_a_x;    // Absolute Indexed with X a,x (65832)
wire ame_AIY_a_y;    // Absolute Indexed with Y a,y (65832)
wire ame_IMM_m;      // Immediate Addressing # (65832)
wire ame_PCR_r;      // Program Counter Relative r (65832)
wire ame_STK_s;      // Stack s (65832)
wire ame_TXT;        // Text controller

assign am_ABS_a =
    (op_0C_TSB | op_0D_ORA | op_0E_ASL | op_1C_TRB | op_20_JSR | op_2C_BIT | op_2D_AND | op_2E_ROL |
    op_4C_JMP | op_4D_EOR | op_4E_LSR | op_6D_ADC | op_6E_ROR | op_8C_STY | op_8D_STA | op_8E_STX |
    op_9C_STZ | op_AC_LDY | op_AD_LDA | op_AE_LDX | op_CC_CPY | op_CD_CMP | op_CE_DEC | op_EC_CPX |
    op_ED_SBC | op_EE_INC);
assign am_ACC_A = (op_0A_ASL | op_3A_DEC | op_1A_INC | op_4A_LSR | op_2A_ROL | op_6A_ROR); 
assign am_AIA_A = (op_6C_JMP);
assign am_AIIX_A_X = (op_7C_JMP);
assign am_AIX_a_x =
    (op_1D_ORA | op_1E_ASL | op_3C_BIT | op_3D_AND | op_3E_ROL | op_5D_EOR | op_5E_LSR | op_7D_ADC |
    op_7E_ROR | op_9E_STZ | op_9E_STZ | op_BC_LDY | op_BD_LDA | op_DD_CMP | op_DE_DEC | op_FD_SBC |
    op_FE_INC);
assign am_AIY_a_y = (op_19_ORA | op_39_AND | op_59_EOR | op_79_ADC | op_99_STA | op_B9_LDA | op_BE_LDX | op_D9_CMP | op_F9_SBC);
assign am_IMM_m =
    (op_03_SUB | op_09_ORA | op_29_AND | op_49_EOR | op_69_ADC | op_89_BIT | op_A0_LDY | op_A2_LDX | op_A9_LDA |
    op_C0_CPY | op_C9_CMP | op_E0_CPX | op_E9_SBC);
assign am_PCR_r =
    (op_0F_BBR0 | op_1F_BBR1 | op_2F_BBR2 | op_3F_BBR3 | op_4F_BBR4 | op_5F_BBR5 | op_6F_BBR6 | op_7F_BBR7 |
    op_8F_BBS0 | op_9F_BBS1 | op_AF_BBS2 | op_BF_BBS3 | op_CF_BBS4 | op_DF_BBS5 | op_EF_BBS6 | op_FF_BBS7 |
    (op_10_BPL & `NN) |
    (op_30_BMI & `N) |
    (op_50_BVC & `NV) |
    (op_70_BVS & `V) |
    op_80_BRA |
    (op_90_BCC & `NC) |
    (op_B0_BCS & `C) |
    (op_D0_BNE & `NZ) |
    (op_F0_BEQ & `Z));
assign am_STK_s = (op_00_BRK | op_40_RTI | op_60_RTS);
assign am_TXT = (op_33_WTX | op_43_RTX);
assign am_ZIIX_ZP_X = (op_01_ORA | op_02_ADD | op_21_AND | op_41_EOR | op_61_ADC | op_81_STA | op_A1_LDA | op_C1_CMP | op_E1_SBC);
assign am_ZIIY_ZP_y = (op_11_ORA | op_31_AND | op_51_EOR | op_71_ADC | op_91_STA | op_B1_LDA | op_D1_CMP | op_F1_SBC);
assign am_ZIX_zp_x =
    (op_15_ORA | op_16_ASL | op_34_BIT | op_35_AND | op_36_ROL | op_55_EOR | op_56_LSR | op_74_STZ | op_75_ADC |
    op_76_ROR | op_94_STY | op_95_STA | op_B4_LDY | op_B5_LDA | op_D5 | op_D6_DEC | op_F5_SBC | op_F6_INC);
assign am_ZIY_zp_y = (op_92_STA | op_96_STX | op_B6_LDX);
assign am_ZPG_zp =
    (op_04_TSB | op_05_ORA | op_06_ASL | op_07_RMB0 | op_17_RMB1 | op_27_RMB2 | op_37_RMB3 | op_47_RMB4 | op_57_RMB5 | op_67_RMB6 | op_77_RMB7 |
    op_14_TRB | op_24_BIT | op_25 | op_26_ROL | op_45_EOR | op_46_LSR | op_52_EOR | op_64_STZ | op_65_ADC | op_66_ROR | op_84_STY |
    op_85_STA | op_86_STX | op_87_SMB0 | op_97_SMB1 | op_A7_SMB2 | op_B7_SMB3 | op_C7_SMB4 | op_D7_SMB5 | op_E7_SMB6 | op_F7_SMB7 | op_A4_LDY |
    op_A5_LDA | op_A6_LDX | op_C4_CPY | op_C5_CMP | op_C6_DEC | op_E4_CPX | op_E5_SBC | op_E6_INC);
assign am_ZPI_ZP = (op_12_ORA | op_32_AND | op_72_ADC | op_B2_LDA | op_D2_CMP | op_F2_SBC);

assign ame_ABS_a = 0;
assign ame_ACC_A = 0;
assign ame_AIA_A = 0;
assign ame_AIIX_A_X = 0;
assign ame_AIIY_A_y = 0;
assign ame_AIX_a_x = 0;
assign ame_AIY_a_y = 0;
assign ame_IMM_m = 0;
assign ame_PCR_r = 0;
assign ame_STK_s = 0;
