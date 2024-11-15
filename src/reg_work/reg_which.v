if (cycle_1_6502) begin
    if (op_07 | op_17 | op_27 | op_37 | op_47 | op_57 | op_67 | op_77) begin
        reg_which <= (`ONE_8 << reg_code_byte[6:4]);
    end
end else if (cycle_1_65832) begin
end
