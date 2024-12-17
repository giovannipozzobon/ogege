/*
Zero Page zp (6502)

assign am_ZPG_zp =
    (op_04_TSB | op_05_ORA | op_06_ASL | op_07_RMB0 | op_17_RMB1 | op_27_RMB2 | op_37_RMB3 | op_47_RMB4 | op_57_RMB5 | op_67_RMB6 | op_77_RMB7 |
    op_14_TRB | op_24_BIT | op_25_AND | op_26_ROL | op_45_EOR | op_46_LSR | op_52_EOR | op_64_STZ | op_65_ADC | op_66_ROR | op_84_STY |
    op_85_STA | op_86_STX | op_87_SMB0 | op_97_SMB1 | op_A7_SMB2 | op_B7_SMB3 | op_C7_SMB4 | op_D7_SMB5 | op_E7_SMB6 | op_F7_SMB7 | op_A4_LDY |
    op_A5_LDA | op_A6_LDX | op_C4_CPY | op_C5_CMP | op_C6_DEC | op_E4_CPX | op_E5_SBC | op_E6_INC);
*/

if (am_ZPG_zp) begin
    if (cycle_1) begin
        `PC <= inc_pc;
    end else if (cycle_2) begin
        reg_bram_addrb <= {`ZERO_8, wire_code_byte_1};
        `PC <= inc_pc;
        if (am_ZPG_zp_wo) begin
            if (op_64_STZ) begin
                reg_bram_dib_w <= `ZERO_8;
            end else if (op_84_STY) begin
                reg_bram_dib_w <= `Y;
            end else if (op_85_STA) begin
                reg_bram_dib_w <= `A;
            end else if (op_86_STX) begin
                reg_bram_dib_w <= `X;
            end
            reg_bram_web <= 1;
        end
        `END_INSTR;
    end else if (cycle_3) begin
        if (am_ZPG_zp_ro) begin
            if (op_05_ORA) begin
                `A <= or_a_var;
                `N <= or_a_var_n;
                `Z <= or_a_var_z;
            end else if (op_24_BIT) begin
                `N <= and_a_var_n;
                `V <= and_a_var_v;
                `Z <= and_a_var_z;
            end else if (op_25_AND) begin
                `A <= and_a_var;
                `N <= and_a_var_n;
                `Z <= and_a_var_z;
            end else if (op_45_EOR) begin
                `A <= eor_a_var;
                `N <= eor_a_var_n;
                `Z <= eor_a_var_z;
            end else if (op_53_SUB) begin
                `A <= sub_a_var;
                `N <= sub_a_var_n;
                `V <= sub_a_var_v;
                `Z <= sub_a_var_z;
                `C <= sub_a_var_c;
            end else if (op_65_ADC) begin
                `A <= adc_a_var;
                `N <= adc_a_var_n;
                `V <= adc_a_var_v;
                `Z <= adc_a_var_z;
                `C <= adc_a_var_c;
            end else if (op_A4_LDY) begin
                `Y <= wire_code_byte_1;
                `N <= wire_code_byte_1[7];
                `Z <= (wire_code_byte_1 == `ZERO_8) ? 1 : 0;
            end else if (op_A5_LDA) begin
                `A <= wire_code_byte_1;
                `N <= wire_code_byte_1[7];    
                `Z <= (wire_code_byte_1 == `ZERO_8) ? 1 : 0;
            end else if (op_A6_LDX) begin
                `X <= wire_code_byte_1;
                `N <= wire_code_byte_1[7];
                `Z <= (wire_code_byte_1 == `ZERO_8) ? 1 : 0;
            end else if (op_C4_CPY) begin
                `N <= sub_y_var_n;
                `V <= sub_y_var_v;
                `Z <= sub_y_var_z;
                `C <= sub_y_var_c;
            end else if (op_C5_CMP) begin
                `N <= sub_a_var_n;
                `V <= sub_a_var_v;
                `Z <= sub_a_var_z;
                `C <= sub_a_var_c;
            end else if (op_E4_CPX) begin
                `N <= sub_x_var_n;
                `V <= sub_x_var_v;
                `Z <= sub_x_var_z;
                `C <= sub_x_var_c;
            end else if (op_E5_SBC) begin
                `A <= sbc_a_var;
                `C <= sbc_a_var_c;
                `V <= sbc_a_var_v;
                `N <= sbc_a_var_n;
                `Z <= sbc_a_var_z;
            end
        end else if (am_ZPG_zp_rw) begin
            if (op_04_TSB) begin
                reg_bram_dib_w <= (wire_data_byte_3 | `A);
                `Z <= ((wire_data_byte_3 & `A) == 0);
            end else if (op_06_ASL) begin
                reg_bram_dib_w <= asl_a;
                `N <= asl_a_n;
                `Z <= asl_a_z;
                `C <= asl_a_c;
            end else if (op_07_RMB0) begin
                reg_bram_dib_w <= (wire_data_byte_3 & ~8'h01);
            end else if (op_17_RMB1) begin
                reg_bram_dib_w <= (wire_data_byte_3 & ~8'h02);
            end else if (op_27_RMB2) begin
                reg_bram_dib_w <= (wire_data_byte_3 & ~8'h04);
            end else if (op_37_RMB3) begin
                reg_bram_dib_w <= (wire_data_byte_3 & ~8'h08);
            end else if (op_47_RMB4) begin
                reg_bram_dib_w <= (wire_data_byte_3 & ~8'h10);
            end else if (op_57_RMB5) begin
                reg_bram_dib_w <= (wire_data_byte_3 & ~8'h20);
            end else if (op_67_RMB6) begin
                reg_bram_dib_w <= (wire_data_byte_3 & ~8'h40);
            end else if (op_77_RMB7) begin
                reg_bram_dib_w <= (wire_data_byte_3 & ~8'h80);
            end else if (op_14_TRB) begin
                reg_bram_dib_w <= (wire_data_byte_3 & (~`A));
                `Z <= ((wire_data_byte_3 & `A) == 0);
            end else if (op_26_ROL) begin
                reg_bram_dib_w <= rol_var;
                `N <= rol_var_n;
                `Z <= rol_var_z;
                `C <= rol_var_c;
            end else if (op_46_LSR) begin
                reg_bram_dib_w <= lsr_var;
                `N <= lsr_var_n;
                `Z <= lsr_var_z;
                `C <= lsr_var_c;
            end else if (op_66_ROR) begin
                reg_bram_dib_w <= ror_var;
                `N <= ror_var_n;
                `Z <= ror_var_z;
                `C <= ror_var_c;
            end else if (op_87_SMB0) begin
                reg_bram_dib_w <= (wire_data_byte_3 | ~8'h01);
            end else if (op_97_SMB1) begin
                reg_bram_dib_w <= (wire_data_byte_3 | ~8'h02);
            end else if (op_A7_SMB2) begin
                reg_bram_dib_w <= (wire_data_byte_3 | ~8'h04);
            end else if (op_B7_SMB3) begin
                reg_bram_dib_w <= (wire_data_byte_3 | ~8'h08);
            end else if (op_C7_SMB4) begin
                reg_bram_dib_w <= (wire_data_byte_3 | ~8'h10);
            end else if (op_D7_SMB5) begin
                reg_bram_dib_w <= (wire_data_byte_3 | ~8'h20);
            end else if (op_E7_SMB6) begin
                reg_bram_dib_w <= (wire_data_byte_3 | ~8'h40);
            end else if (op_F7_SMB7) begin
                reg_bram_dib_w <= (wire_data_byte_3 | ~8'h80);
            end else if (op_C6_DEC) begin
                reg_bram_dib_w <= dec_var;
                `N <= dec_var_n;
                `Z <= dec_var_z;
            end else if (op_E6_INC) begin
                reg_bram_dib_w <= inc_var;
                `N <= inc_var_n;
                `Z <= inc_var_z;
            end
            reg_bram_web <= 1;
        end
        `END_INSTR;
    end
end
