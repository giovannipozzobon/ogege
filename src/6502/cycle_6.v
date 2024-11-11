// 6502 cycle 6

if (am_AIIX_A_X | am_AIA_A) begin
    am_AIIX_A_X <= 0;
    am_AIA_A <= 0;
    `END_INSTR;
    if (op_JMP) begin
        `PC <= {i_bus_data, `IADDR0};
        `END_OPER(op_JMP);
    end
end
