if (cycle_1_6502) begin
    if (op_06 | op_0E | op_16 | op_1E) begin
        op_ASL <= 1;
    end
end else if (cycle_3_6502) begin
    if (am_IMM_m) begin
        op_ASL <= 0;
    end
end else if (cycle_1_65832) begin
end
