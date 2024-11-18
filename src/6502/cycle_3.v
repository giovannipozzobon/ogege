// 6502 cycle 3

if (am_IMM_m) begin
    //`DATA_BYTE = `ADDR0; ??
    if (op_ADC) begin
        `END_OPER_INSTR(op_ADC);
    end else if (op_AND) begin
        `END_OPER_INSTR(op_AND);
    end else if (op_ASL) begin
        `DST <= reg_data_byte;
        `STORE_AFTER_OP(op_ASL);
    end else if (op_BIT) begin
        `END_OPER_INSTR(op_BIT);
    end else if (op_CMP) begin
        `END_OPER_INSTR(op_CMP);
    end else if (op_CPX) begin
        `END_OPER_INSTR(op_CPX);
    end else if (op_CPY) begin
        `END_OPER_INSTR(op_CPY);
    end else if (op_EOR) begin
        `END_OPER_INSTR(op_EOR);
    end else if (op_LDA) begin
        `END_OPER_INSTR(op_LDA);
    end else if (op_LDX) begin
        `END_OPER_INSTR(op_LDX);
    end else if (op_LDY) begin
        `END_OPER_INSTR(op_LDY);
    end else if (op_ORA) begin
        `END_OPER_INSTR(op_ORA);
    end else if (op_SBC) begin
        `END_OPER_INSTR(op_SBC);
    end else if (op_SUB) begin
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
