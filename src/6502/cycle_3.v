// 6502 cycle 3

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
