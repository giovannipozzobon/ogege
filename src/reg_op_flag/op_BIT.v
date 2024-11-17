if (cycle_1_6502) begin
    if (op_24 | op_2C | op_34 | op_3C | op_89) begin
        op_BIT <= 1;
    end
end else if (cycle_1_65832) begin
end
