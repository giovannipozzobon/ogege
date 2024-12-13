/*
Immediate Addressing # (6502)

assign am_IMM_m =
    (op_03_SUB | op_09_ORA | op_29_AND | op_49_EOR |
     op_69_ADC | op_89_BIT | op_A0_LDY | op_A2_LDX | op_A9_LDA |
     op_C0_CPY | op_C9_CMP | op_E0_CPX | op_E9_SBC);
*/

if (am_IMM_m) begin
    if (cycle_2) begin
        if (op_69_ADC) begin
            `A <= adc_a_var;
            `N <= adc_a_var_n;
            `V <= adc_a_var_v;
            `Z <= adc_a_var_z;
            `C <= adc_a_var_c;
        end else if (op_29_AND) begin
            `A <= and_a_var;
            `N <= and_a_var_n;
            `Z <= and_a_var_z;
        end else if (op_49_EOR) begin
            `A <= eor_a_var;
            `N <= eor_a_var_n;
            `Z <= eor_a_var_z;
        end else if (op_A9_LDA) begin
            `A <= wire_data_byte_0;
            `N <= wire_data_byte_0[7];    
            `Z <= (wire_data_byte_0 == `ZERO_8) ? 1 : 0;
        end else if (op_A2_LDX) begin
            `X <= wire_data_byte_0;
            `N <= wire_data_byte_0[7];
            `Z <= (wire_data_byte_0 == `ZERO_8) ? 1 : 0;
        end else if (op_A0_LDY) begin
            `Y <= wire_data_byte_0;
            `N <= wire_data_byte_0[7];
            `Z <= (wire_data_byte_0 == `ZERO_8) ? 1 : 0;
        end else if (op_09_ORA) begin
            `A <= or_a_var;
            `N <= or_a_var_n;
            `Z <= or_a_var_z;
        end else if (op_E9_SBC) begin
            `A <= sbc_a_var;
            `C <= sbc_a_var_c;
            `V <= sbc_a_var_v;
            `N <= sbc_a_var_n;
            `Z <= sbc_a_var_z;
        end else if (op_03_SUB) begin
            `A <= sub_a_var;
            `N <= sub_a_var_n;
            `V <= sub_a_var_v;
            `Z <= sub_a_var_z;
            `C <= sub_a_var_c;
        end else if (op_89_BIT) begin
            `N <= and_a_var_n;
            `V <= and_a_var_v;
            `Z <= and_a_var_z;
        end else if (op_C9_CMP) begin
            `N <= sub_a_var_n;
            `V <= sub_a_var_v;
            `Z <= sub_a_var_z;
            `C <= sub_a_var_c;
        end else if (op_E0_CPX) begin
            `N <= sub_x_var_n;
            `V <= sub_x_var_v;
            `Z <= sub_x_var_z;
            `C <= sub_x_var_c;
        end else if (op_C0_CPY) begin
            `N <= sub_y_var_n;
            `V <= sub_y_var_v;
            `Z <= sub_y_var_z;
            `C <= sub_y_var_c;
        end
        `PC <= inc_pc;
        reg_cycle <= 0;
    end
end
