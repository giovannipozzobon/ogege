if (cycle_1_6502) begin
    if (op_4C | op_6C | op_7C) begin
        op_JMP <= 1;
    end
end else if (cycle_1_65832) begin
end
