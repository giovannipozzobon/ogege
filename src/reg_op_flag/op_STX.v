if (cycle_1_6502) begin
    if (op_86 | op_8E | op_96) begin
        op_STX <= 1;
    end
end else if (cycle_1_65832) begin
end
