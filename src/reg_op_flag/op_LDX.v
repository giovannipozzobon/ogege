if (cycle_1_6502) begin
    if (op_A2 | op_A6 | op_AE | op_B6 | op_BE) begin
        op_LDX <= 1;
    end
end else if (cycle_1_65832) begin
end
