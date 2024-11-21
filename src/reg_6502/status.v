always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        `P <= `RESET_STATUS_BITS;
        `eP <= `RESET_STATUS_BITS;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_0A_ASL) begin
            `N <= asl_a_n;
            `Z <= asl_a_z;
            `C <= asl_a_c;
        end else if (op_13) begin
            `C <= neg_a_c;
            `N <= neg_a_n;
            `Z <= neg_a_z;
        end else if (op_18_CLC) begin
            `C <= 0; // CLC
        end else if (op_1A_INC) begin
            `N <= inc_a_n;
            `Z <= inc_a_z;
        end else if (op_23) begin
            `N <= not_a_n;
            `Z <= not_a_z;
        end else if (op_2A_ROL) begin
            `N <= rol_a_n;
            `Z <= rol_a_z;
            `C <= rol_a_c;
        end else if (op_38) begin
            `C <= 1;
        end else if (op_3A_DEC) begin
            `N <= dec_a_n;
            `Z <= dec_a_z;
        end else if (op_4A_LSR) begin
            `N <= lsr_a_n;
            `Z <= lsr_a_z;
            `C <= lsr_a_c;
        end else if (op_58_CLI) begin
            `I <= 0;
        end else if (op_6A_ROR) begin
            `N <= ror_a_n;
            `Z <= ror_a_z;
            `C <= ror_a_c;
        end else if (op_78) begin
            `I <= 1;
        end else if (op_88_DEY) begin
            `N <= dec_y_n;
            `Z <= dec_y_z;
        end else if (op_B8_CLV) begin
            `V <= 0;
        end else if (op_C8_INY) begin
            `N <= inc_y_n;
            `Z <= inc_y_z;
        end else if (op_CA_DEX) begin
            `N <= dec_x_n;
            `Z <= dec_x_z;
        end else if (op_D8_CLD) begin
            `D <= 0;
        end else if (op_E8_INX) begin
            `N <= inc_x_n;
            `Z <= inc_x_z;
        end else if (op_F8) begin
            `D <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            if (op_ADC) begin
                `N <= adc_a_var_n;
                `V <= adc_a_var_v;
                `Z <= adc_a_var_z;
                `C <= adc_a_var_c;
            end else if (op_AND) begin
                `N <= and_a_var_n;
                `Z <= and_a_var_z;
            end else if (op_ASL) begin
                `N <= asl_var_n;
                `Z <= asl_var_z;
                `C <= asl_var_c;
            end else if (op_BIT) begin
                `N <= and_a_var_n;
                `V <= and_a_var_v;
                `Z <= and_a_var_z;
            end else if (op_CMP) begin
                `N <= sub_a_var_n;
                `V <= sub_a_var_v;
                `Z <= sub_a_var_z;
                `C <= sub_a_var_c;
            end else if (op_CPX) begin
                `N <= sub_x_var_n;
                `V <= sub_x_var_v;
                `Z <= sub_x_var_z;
                `C <= sub_x_var_c;
            end else if (op_CPY) begin
                `N <= sub_y_var_n;
                `V <= sub_y_var_v;
                `Z <= sub_y_var_z;
                `C <= sub_y_var_c;
            end else if (op_EOR) begin
                `N <= eor_a_var_n;
                `Z <= eor_a_var_z;
            end else if (op_LDA) begin
                `N <= i_bus_data[7];
                `Z <= (reg_data_byte == `ZERO_8) ? 1 : 0;
            end else if (op_LDX) begin
                `N <= i_bus_data[7];
                `Z <= (reg_data_byte == `ZERO_8) ? 1 : 0;
            end else if (op_LDY) begin
                `N <= i_bus_data[7];
                `Z <= (reg_data_byte == `ZERO_8) ? 1 : 0;
            end else if (op_ORA) begin
                `N <= or_a_var_n;
                `Z <= or_a_var_z;
            end else if (op_SBC) begin
                `C <= sbc_a_var_c;
                `V <= sbc_a_var_v;
                `N <= sbc_a_var_n;
                `Z <= sbc_a_var_z;
            end else if (op_SUB) begin
                `N <= sub_a_var_n;
                `V <= sub_a_var_v;
                `Z <= sub_a_var_z;
                `C <= sub_a_var_c;
            end
        end
    end else if (cycle_1_65832) begin
    end
end
