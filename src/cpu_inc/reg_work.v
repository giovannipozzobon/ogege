`define EADDR   reg_address`VW
`define EADDR0  reg_address[7:0]
`define EADDR1  reg_address[15:8]
`define EADDR2  reg_address[23:16]
`define EADDR3  reg_address[31:24]

`define EIADDR   reg_ind_address`VW
`define EIADDR0  reg_ind_address[7:0]
`define EIADDR1  reg_ind_address[15:8]
`define EIADDR2  reg_ind_address[23:16]
`define EIADDR3  reg_ind_address[31:24]

// Processing registers
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
reg load_from_address; // Load from or use the computed address
reg store_to_address; // Store computed value at address
reg transfer_in_progress; // Load/store in progress


`LOGIC_8 var_code_byte;
`LOGIC_8 var_new_val;
`LOGIC_16 var_hw_address;
`LOGIC_32 var_w_address;

reg am_ABS_a;       // Absolute a (6502)
reg am_ACC_A;       // Accumulator A (6502)
reg am_AIA_A;       // Absolute Indirect (a) (6502)
reg am_AIIX_A_X;    // Absolute Indexed Indirect with X (a,x) (6502)
reg am_AIX_a_x;     // Absolute Indexed with X a,x (6502)
reg am_AIY_a_y;     // Absolute Indexed with Y a,y (6502)
reg am_IMM_m;       // Immediate Addressing # (6502)
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
reg op_BRANCH;
reg op_BBS;
reg op_BIT;
reg op_BRK;
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

logic cycle_0; assign cycle_0 = (reg_cycle == 0);
logic cycle_1; assign cycle_1 = (reg_cycle == 1);
logic cycle_2; assign cycle_2 = (reg_cycle == 2);
logic cycle_3; assign cycle_3 = (reg_cycle == 3);
logic cycle_4; assign cycle_4 = (reg_cycle == 4);
logic cycle_5; assign cycle_5 = (reg_cycle == 5);
logic cycle_6; assign cycle_6 = (reg_cycle == 6);
logic cycle_7; assign cycle_7 = (reg_cycle == 7);

logic cycle_0_6502; assign cycle_0_6502 = (cycle_0 & reg_6502);
logic cycle_1_6502; assign cycle_1_6502 = (cycle_1 & reg_6502);
logic cycle_2_6502; assign cycle_2_6502 = (cycle_2 & reg_6502);
logic cycle_3_6502; assign cycle_3_6502 = (cycle_3 & reg_6502);
logic cycle_4_6502; assign cycle_4_6502 = (cycle_4 & reg_6502);
logic cycle_5_6502; assign cycle_5_6502 = (cycle_5 & reg_6502);
logic cycle_6_6502; assign cycle_6_6502 = (cycle_6 & reg_6502);
logic cycle_7_6502; assign cycle_7_6502 = (cycle_7 & reg_6502);

logic cycle_0_65832; assign cycle_0_65832 = (cycle_0 & reg_65832);
logic cycle_1_65832; assign cycle_1_65832 = (cycle_1 & reg_65832);
logic cycle_2_65832; assign cycle_2_65832 = (cycle_2 & reg_65832);
logic cycle_3_65832; assign cycle_3_65832 = (cycle_3 & reg_65832);
logic cycle_4_65832; assign cycle_4_65832 = (cycle_4 & reg_65832);
logic cycle_5_65832; assign cycle_5_65832 = (cycle_5 & reg_65832);
logic cycle_6_65832; assign cycle_6_65832 = (cycle_6 & reg_65832);
logic cycle_7_65832; assign cycle_7_65832 = (cycle_7 & reg_65832);

logic op_00; assign op_00 = (reg_code_byte == 8'h00);
logic op_01; assign op_01 = (reg_code_byte == 8'h01);
logic op_02; assign op_02 = (reg_code_byte == 8'h02);
logic op_03; assign op_03 = (reg_code_byte == 8'h03);
logic op_04; assign op_04 = (reg_code_byte == 8'h04);
logic op_05; assign op_05 = (reg_code_byte == 8'h05);
logic op_06; assign op_06 = (reg_code_byte == 8'h06);
logic op_07; assign op_07 = (reg_code_byte == 8'h07);
logic op_08; assign op_08 = (reg_code_byte == 8'h08);
logic op_09; assign op_09 = (reg_code_byte == 8'h09);
logic op_0A; assign op_0A = (reg_code_byte == 8'h0A);
logic op_0B; assign op_0B = (reg_code_byte == 8'h0B);
logic op_0C; assign op_0C = (reg_code_byte == 8'h0C);
logic op_0D; assign op_0D = (reg_code_byte == 8'h0D);
logic op_0E; assign op_0E = (reg_code_byte == 8'h0E);
logic op_0F; assign op_0F = (reg_code_byte == 8'h0F);
logic op_10; assign op_10 = (reg_code_byte == 8'h10);
logic op_11; assign op_11 = (reg_code_byte == 8'h11);
logic op_12; assign op_12 = (reg_code_byte == 8'h12);
logic op_13; assign op_13 = (reg_code_byte == 8'h13);
logic op_14; assign op_14 = (reg_code_byte == 8'h14);
logic op_15; assign op_15 = (reg_code_byte == 8'h15);
logic op_16; assign op_16 = (reg_code_byte == 8'h16);
logic op_17; assign op_17 = (reg_code_byte == 8'h17);
logic op_18; assign op_18 = (reg_code_byte == 8'h18);
logic op_19; assign op_19 = (reg_code_byte == 8'h19);
logic op_1A; assign op_1A = (reg_code_byte == 8'h1A);
logic op_1B; assign op_1B = (reg_code_byte == 8'h1B);
logic op_1C; assign op_1C = (reg_code_byte == 8'h1C);
logic op_1D; assign op_1D = (reg_code_byte == 8'h1D);
logic op_1E; assign op_1E = (reg_code_byte == 8'h1E);
logic op_1F; assign op_1F = (reg_code_byte == 8'h1F);
logic op_20; assign op_20 = (reg_code_byte == 8'h20);
logic op_21; assign op_21 = (reg_code_byte == 8'h21);
logic op_22; assign op_22 = (reg_code_byte == 8'h22);
logic op_23; assign op_23 = (reg_code_byte == 8'h23);
logic op_24; assign op_24 = (reg_code_byte == 8'h24);
logic op_25; assign op_25 = (reg_code_byte == 8'h25);
logic op_26; assign op_26 = (reg_code_byte == 8'h26);
logic op_27; assign op_27 = (reg_code_byte == 8'h27);
logic op_28; assign op_28 = (reg_code_byte == 8'h28);
logic op_29; assign op_29 = (reg_code_byte == 8'h29);
logic op_2A; assign op_2A = (reg_code_byte == 8'h2A);
logic op_2B; assign op_2B = (reg_code_byte == 8'h2B);
logic op_2C; assign op_2C = (reg_code_byte == 8'h2C);
logic op_2D; assign op_2D = (reg_code_byte == 8'h2D);
logic op_2E; assign op_2E = (reg_code_byte == 8'h2E);
logic op_2F; assign op_2F = (reg_code_byte == 8'h2F);
logic op_30; assign op_30 = (reg_code_byte == 8'h30);
logic op_31; assign op_31 = (reg_code_byte == 8'h31);
logic op_32; assign op_32 = (reg_code_byte == 8'h32);
logic op_33; assign op_33 = (reg_code_byte == 8'h33);
logic op_34; assign op_34 = (reg_code_byte == 8'h34);
logic op_35; assign op_35 = (reg_code_byte == 8'h35);
logic op_36; assign op_36 = (reg_code_byte == 8'h36);
logic op_37; assign op_37 = (reg_code_byte == 8'h37);
logic op_38; assign op_38 = (reg_code_byte == 8'h38);
logic op_39; assign op_39 = (reg_code_byte == 8'h39);
logic op_3A; assign op_3A = (reg_code_byte == 8'h3A);
logic op_3B; assign op_3B = (reg_code_byte == 8'h3B);
logic op_3C; assign op_3C = (reg_code_byte == 8'h3C);
logic op_3D; assign op_3D = (reg_code_byte == 8'h3D);
logic op_3E; assign op_3E = (reg_code_byte == 8'h3E);
logic op_3F; assign op_3F = (reg_code_byte == 8'h3F);
logic op_40; assign op_40 = (reg_code_byte == 8'h40);
logic op_41; assign op_41 = (reg_code_byte == 8'h41);
logic op_42; assign op_42 = (reg_code_byte == 8'h42);
logic op_43; assign op_43 = (reg_code_byte == 8'h43);
logic op_44; assign op_44 = (reg_code_byte == 8'h44);
logic op_45; assign op_45 = (reg_code_byte == 8'h45);
logic op_46; assign op_46 = (reg_code_byte == 8'h46);
logic op_47; assign op_47 = (reg_code_byte == 8'h47);
logic op_48; assign op_48 = (reg_code_byte == 8'h48);
logic op_49; assign op_49 = (reg_code_byte == 8'h49);
logic op_4A; assign op_4A = (reg_code_byte == 8'h4A);
logic op_4B; assign op_4B = (reg_code_byte == 8'h4B);
logic op_4C; assign op_4C = (reg_code_byte == 8'h4C);
logic op_4D; assign op_4D = (reg_code_byte == 8'h4D);
logic op_4E; assign op_4E = (reg_code_byte == 8'h4E);
logic op_4F; assign op_4F = (reg_code_byte == 8'h4F);
logic op_50; assign op_50 = (reg_code_byte == 8'h50);
logic op_51; assign op_51 = (reg_code_byte == 8'h51);
logic op_52; assign op_52 = (reg_code_byte == 8'h52);
logic op_53; assign op_53 = (reg_code_byte == 8'h53);
logic op_54; assign op_54 = (reg_code_byte == 8'h54);
logic op_55; assign op_55 = (reg_code_byte == 8'h55);
logic op_56; assign op_56 = (reg_code_byte == 8'h56);
logic op_57; assign op_57 = (reg_code_byte == 8'h57);
logic op_58; assign op_58 = (reg_code_byte == 8'h58);
logic op_59; assign op_59 = (reg_code_byte == 8'h59);
logic op_5A; assign op_5A = (reg_code_byte == 8'h5A);
logic op_5B; assign op_5B = (reg_code_byte == 8'h5B);
logic op_5C; assign op_5C = (reg_code_byte == 8'h5C);
logic op_5D; assign op_5D = (reg_code_byte == 8'h5D);
logic op_5E; assign op_5E = (reg_code_byte == 8'h5E);
logic op_5F; assign op_5F = (reg_code_byte == 8'h5F);
logic op_60; assign op_60 = (reg_code_byte == 8'h60);
logic op_61; assign op_61 = (reg_code_byte == 8'h61);
logic op_62; assign op_62 = (reg_code_byte == 8'h62);
logic op_63; assign op_63 = (reg_code_byte == 8'h63);
logic op_64; assign op_64 = (reg_code_byte == 8'h64);
logic op_65; assign op_65 = (reg_code_byte == 8'h65);
logic op_66; assign op_66 = (reg_code_byte == 8'h66);
logic op_67; assign op_67 = (reg_code_byte == 8'h67);
logic op_68; assign op_68 = (reg_code_byte == 8'h68);
logic op_69; assign op_69 = (reg_code_byte == 8'h69);
logic op_6A; assign op_6A = (reg_code_byte == 8'h6A);
logic op_6B; assign op_6B = (reg_code_byte == 8'h6B);
logic op_6C; assign op_6C = (reg_code_byte == 8'h6C);
logic op_6D; assign op_6D = (reg_code_byte == 8'h6D);
logic op_6E; assign op_6E = (reg_code_byte == 8'h6E);
logic op_6F; assign op_6F = (reg_code_byte == 8'h6F);
logic op_70; assign op_70 = (reg_code_byte == 8'h70);
logic op_71; assign op_71 = (reg_code_byte == 8'h71);
logic op_72; assign op_72 = (reg_code_byte == 8'h72);
logic op_73; assign op_73 = (reg_code_byte == 8'h73);
logic op_74; assign op_74 = (reg_code_byte == 8'h74);
logic op_75; assign op_75 = (reg_code_byte == 8'h75);
logic op_76; assign op_76 = (reg_code_byte == 8'h76);
logic op_77; assign op_77 = (reg_code_byte == 8'h77);
logic op_78; assign op_78 = (reg_code_byte == 8'h78);
logic op_79; assign op_79 = (reg_code_byte == 8'h79);
logic op_7A; assign op_7A = (reg_code_byte == 8'h7A);
logic op_7B; assign op_7B = (reg_code_byte == 8'h7B);
logic op_7C; assign op_7C = (reg_code_byte == 8'h7C);
logic op_7D; assign op_7D = (reg_code_byte == 8'h7D);
logic op_7E; assign op_7E = (reg_code_byte == 8'h7E);
logic op_7F; assign op_7F = (reg_code_byte == 8'h7F);
logic op_80; assign op_80 = (reg_code_byte == 8'h80);
logic op_81; assign op_81 = (reg_code_byte == 8'h81);
logic op_82; assign op_82 = (reg_code_byte == 8'h82);
logic op_83; assign op_83 = (reg_code_byte == 8'h83);
logic op_84; assign op_84 = (reg_code_byte == 8'h84);
logic op_85; assign op_85 = (reg_code_byte == 8'h85);
logic op_86; assign op_86 = (reg_code_byte == 8'h86);
logic op_87; assign op_87 = (reg_code_byte == 8'h87);
logic op_88; assign op_88 = (reg_code_byte == 8'h88);
logic op_89; assign op_89 = (reg_code_byte == 8'h89);
logic op_8A; assign op_8A = (reg_code_byte == 8'h8A);
logic op_8B; assign op_8B = (reg_code_byte == 8'h8B);
logic op_8C; assign op_8C = (reg_code_byte == 8'h8C);
logic op_8D; assign op_8D = (reg_code_byte == 8'h8D);
logic op_8E; assign op_8E = (reg_code_byte == 8'h8E);
logic op_8F; assign op_8F = (reg_code_byte == 8'h8F);
logic op_90; assign op_90 = (reg_code_byte == 8'h90);
logic op_91; assign op_91 = (reg_code_byte == 8'h91);
logic op_92; assign op_92 = (reg_code_byte == 8'h92);
logic op_93; assign op_93 = (reg_code_byte == 8'h93);
logic op_94; assign op_94 = (reg_code_byte == 8'h94);
logic op_95; assign op_95 = (reg_code_byte == 8'h95);
logic op_96; assign op_96 = (reg_code_byte == 8'h96);
logic op_97; assign op_97 = (reg_code_byte == 8'h97);
logic op_98; assign op_98 = (reg_code_byte == 8'h98);
logic op_99; assign op_99 = (reg_code_byte == 8'h99);
logic op_9A; assign op_9A = (reg_code_byte == 8'h9A);
logic op_9B; assign op_9B = (reg_code_byte == 8'h9B);
logic op_9C; assign op_9C = (reg_code_byte == 8'h9C);
logic op_9D; assign op_9D = (reg_code_byte == 8'h9D);
logic op_9E; assign op_9E = (reg_code_byte == 8'h9E);
logic op_9F; assign op_9F = (reg_code_byte == 8'h9F);
logic op_A0; assign op_A0 = (reg_code_byte == 8'hA0);
logic op_A1; assign op_A1 = (reg_code_byte == 8'hA1);
logic op_A2; assign op_A2 = (reg_code_byte == 8'hA2);
logic op_A3; assign op_A3 = (reg_code_byte == 8'hA3);
logic op_A4; assign op_A4 = (reg_code_byte == 8'hA4);
logic op_A5; assign op_A5 = (reg_code_byte == 8'hA5);
logic op_A6; assign op_A6 = (reg_code_byte == 8'hA6);
logic op_A7; assign op_A7 = (reg_code_byte == 8'hA7);
logic op_A8; assign op_A8 = (reg_code_byte == 8'hA8);
logic op_A9; assign op_A9 = (reg_code_byte == 8'hA9);
logic op_AA; assign op_AA = (reg_code_byte == 8'hAA);
logic op_AB; assign op_AB = (reg_code_byte == 8'hAB);
logic op_AC; assign op_AC = (reg_code_byte == 8'hAC);
logic op_AD; assign op_AD = (reg_code_byte == 8'hAD);
logic op_AE; assign op_AE = (reg_code_byte == 8'hAE);
logic op_AF; assign op_AF = (reg_code_byte == 8'hAF);
logic op_B0; assign op_B0 = (reg_code_byte == 8'hB0);
logic op_B1; assign op_B1 = (reg_code_byte == 8'hB1);
logic op_B2; assign op_B2 = (reg_code_byte == 8'hB2);
logic op_B3; assign op_B3 = (reg_code_byte == 8'hB3);
logic op_B4; assign op_B4 = (reg_code_byte == 8'hB4);
logic op_B5; assign op_B5 = (reg_code_byte == 8'hB5);
logic op_B6; assign op_B6 = (reg_code_byte == 8'hB6);
logic op_B7; assign op_B7 = (reg_code_byte == 8'hB7);
logic op_B8; assign op_B8 = (reg_code_byte == 8'hB8);
logic op_B9; assign op_B9 = (reg_code_byte == 8'hB9);
logic op_BA; assign op_BA = (reg_code_byte == 8'hBA);
logic op_BB; assign op_BB = (reg_code_byte == 8'hBB);
logic op_BC; assign op_BC = (reg_code_byte == 8'hBC);
logic op_BD; assign op_BD = (reg_code_byte == 8'hBD);
logic op_BE; assign op_BE = (reg_code_byte == 8'hBE);
logic op_BF; assign op_BF = (reg_code_byte == 8'hBF);
logic op_C0; assign op_C0 = (reg_code_byte == 8'hC0);
logic op_C1; assign op_C1 = (reg_code_byte == 8'hC1);
logic op_C2; assign op_C2 = (reg_code_byte == 8'hC2);
logic op_C3; assign op_C3 = (reg_code_byte == 8'hC3);
logic op_C4; assign op_C4 = (reg_code_byte == 8'hC4);
logic op_C5; assign op_C5 = (reg_code_byte == 8'hC5);
logic op_C6; assign op_C6 = (reg_code_byte == 8'hC6);
logic op_C7; assign op_C7 = (reg_code_byte == 8'hC7);
logic op_C8; assign op_C8 = (reg_code_byte == 8'hC8);
logic op_C9; assign op_C9 = (reg_code_byte == 8'hC9);
logic op_CA; assign op_CA = (reg_code_byte == 8'hCA);
logic op_CB; assign op_CB = (reg_code_byte == 8'hCB);
logic op_CC; assign op_CC = (reg_code_byte == 8'hCC);
logic op_CD; assign op_CD = (reg_code_byte == 8'hCD);
logic op_CE; assign op_CE = (reg_code_byte == 8'hCE);
logic op_CF; assign op_CF = (reg_code_byte == 8'hCF);
logic op_D0; assign op_D0 = (reg_code_byte == 8'hD0);
logic op_D1; assign op_D1 = (reg_code_byte == 8'hD1);
logic op_D2; assign op_D2 = (reg_code_byte == 8'hD2);
logic op_D3; assign op_D3 = (reg_code_byte == 8'hD3);
logic op_D4; assign op_D4 = (reg_code_byte == 8'hD4);
logic op_D5; assign op_D5 = (reg_code_byte == 8'hD5);
logic op_D6; assign op_D6 = (reg_code_byte == 8'hD6);
logic op_D7; assign op_D7 = (reg_code_byte == 8'hD7);
logic op_D8; assign op_D8 = (reg_code_byte == 8'hD8);
logic op_D9; assign op_D9 = (reg_code_byte == 8'hD9);
logic op_DA; assign op_DA = (reg_code_byte == 8'hDA);
logic op_DB; assign op_DB = (reg_code_byte == 8'hDB);
logic op_DC; assign op_DC = (reg_code_byte == 8'hDC);
logic op_DD; assign op_DD = (reg_code_byte == 8'hDD);
logic op_DE; assign op_DE = (reg_code_byte == 8'hDE);
logic op_DF; assign op_DF = (reg_code_byte == 8'hDF);
logic op_E0; assign op_E0 = (reg_code_byte == 8'hE0);
logic op_E1; assign op_E1 = (reg_code_byte == 8'hE1);
logic op_E2; assign op_E2 = (reg_code_byte == 8'hE2);
logic op_E3; assign op_E3 = (reg_code_byte == 8'hE3);
logic op_E4; assign op_E4 = (reg_code_byte == 8'hE4);
logic op_E5; assign op_E5 = (reg_code_byte == 8'hE5);
logic op_E6; assign op_E6 = (reg_code_byte == 8'hE6);
logic op_E7; assign op_E7 = (reg_code_byte == 8'hE7);
logic op_E8; assign op_E8 = (reg_code_byte == 8'hE8);
logic op_E9; assign op_E9 = (reg_code_byte == 8'hE9);
logic op_EA; assign op_EA = (reg_code_byte == 8'hEA);
logic op_EB; assign op_EB = (reg_code_byte == 8'hEB);
logic op_EC; assign op_EC = (reg_code_byte == 8'hEC);
logic op_ED; assign op_ED = (reg_code_byte == 8'hED);
logic op_EE; assign op_EE = (reg_code_byte == 8'hEE);
logic op_EF; assign op_EF = (reg_code_byte == 8'hEF);
logic op_F0; assign op_F0 = (reg_code_byte == 8'hF0);
logic op_F1; assign op_F1 = (reg_code_byte == 8'hF1);
logic op_F2; assign op_F2 = (reg_code_byte == 8'hF2);
logic op_F3; assign op_F3 = (reg_code_byte == 8'hF3);
logic op_F4; assign op_F4 = (reg_code_byte == 8'hF4);
logic op_F5; assign op_F5 = (reg_code_byte == 8'hF5);
logic op_F6; assign op_F6 = (reg_code_byte == 8'hF6);
logic op_F7; assign op_F7 = (reg_code_byte == 8'hF7);
logic op_F8; assign op_F8 = (reg_code_byte == 8'hF8);
logic op_F9; assign op_F9 = (reg_code_byte == 8'hF9);
logic op_FA; assign op_FA = (reg_code_byte == 8'hFA);
logic op_FB; assign op_FB = (reg_code_byte == 8'hFB);
logic op_FC; assign op_FC = (reg_code_byte == 8'hFC);
logic op_FD; assign op_FD = (reg_code_byte == 8'hFD);
logic op_FE; assign op_FE = (reg_code_byte == 8'hFE);
logic op_FF; assign op_FF = (reg_code_byte == 8'hFF);

`define SRC reg_src_data`VB
`define eSRC reg_src_data`VW
`define eSRC0 reg_src_data[7:0]
`define eSRC1 reg_src_data[15:8]
`define eSRC2 reg_src_data[23:16]
`define eSRC3 reg_src_data[31:24]

`define DST reg_dst_data`VB
`define eDST reg_dst_data`VW
`define eDST0 reg_dst_data[7:0]
`define eDST1 reg_dst_data[15:8]
`define eDST2 reg_dst_data[23:16]
`define eDST3 reg_dst_data[31:24]
