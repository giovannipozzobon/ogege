if (cycle_1_6502) begin
    if (op_C0 | op_C4 | op_CC) begin
        op_CPY <= 1;
    end
end else if (cycle_3_6502) begin
    if (am_IMM_m) begin
        op_CPY <= 0;
    end
end else if (cycle_1_65832) begin
end
