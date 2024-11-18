if (cycle_1_6502) begin
    if (op_81 | op_85 | op_8D | op_91 | op_92 | op_95 | op_99 | op_9D) begin
        op_STA <= 1;
    end
else if (cycle_4_6502) begin
    if (am_ABS_a) begin
        op_STA <= 0;
    end
end else if (cycle_1_65832) begin
end
