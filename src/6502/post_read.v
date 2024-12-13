// 6502 post-read


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
    `DST <= wire_data_byte_0;
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
    `DST <= wire_data_byte_0;
    `N <= dec_var_n;
    `Z <= dec_var_z;
    `STORE_AFTER_OP(op_DEC);
end else if (op_EOR) begin
    `A <= eor_a_var;
    `N <= eor_a_var_n;
    `Z <= eor_a_var_z;
    `END_OPER_INSTR(op_EOR);
end else if (op_INC) begin
    `DST <= wire_data_byte_0;
    `N <= inc_var_n;
    `Z <= inc_var_z;
    `STORE_AFTER_OP(op_INC);
end else if (op_LDA | op_PLA) begin
    `A <= wire_data_byte_0;
    `N <= i_bus_data[7];
    `Z <= (wire_data_byte_0 == `ZERO_8) ? 1 : 0;
    `END_OPER(op_PLA);
    `END_OPER_INSTR(op_LDA);
end else if (op_LDX | op_PLX) begin
    `X <= wire_data_byte_0;
    `N <= i_bus_data[7];
    `Z <= (wire_data_byte_0 == `ZERO_8) ? 1 : 0;
    `END_OPER(op_PLX);
    `END_OPER_INSTR(op_LDX);
end else if (op_LDY | op_PLY) begin
    `Y <= wire_data_byte_0;
    `N <= i_bus_data[7];
    `Z <= (wire_data_byte_0 == `ZERO_8) ? 1 : 0;
    `END_OPER(op_PLY);
    `END_OPER_INSTR(op_LDY);
end else if (op_PLP) begin
    `P <= wire_data_byte_0;
    `END_OPER_INSTR(op_PLP);
end else if (op_LSR) begin
    `DST <= wire_data_byte_0;
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
    `DST <= wire_data_byte_0 &(~reg_which);
    `STORE_AFTER_OP(op_RMB);
end else if (op_ROL) begin
    `DST <= wire_data_byte_0;
    `N <= rol_var_n;
    `Z <= rol_var_z;
    `C <= rol_var_c;
    `STORE_AFTER_OP(op_ROL);
end else if (op_ROR) begin
    `DST <= wire_data_byte_0;
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
    `DST <= wire_data_byte_0 | reg_which;
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
