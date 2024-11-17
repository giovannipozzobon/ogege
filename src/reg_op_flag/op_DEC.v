if (cycle_1_6502) begin
    if (op_C6 | op_CE | op_D6 | op_DE) begin
        op_DEC <= 1;
    end
end else if (cycle_1_65832) begin
end
