always @(posedge i_cpu_clk) begin
    if (i_rst) begin
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
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
