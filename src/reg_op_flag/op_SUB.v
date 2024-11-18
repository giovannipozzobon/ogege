if (cycle_1_6502) begin
    if (op_03) begin
        op_SUB <= 1;
    end
end else if (cycle_3_6502) begin
    if (am_IMM_m) begin
        op_SUB <= 0;
    end
end else if (cycle_1_65832) begin
end
