if (cycle_1_6502) begin
    if (op_64 | op_74 | op_9C | op_9E) begin
        op_STZ <= 1;
    end
end else if (cycle_1_65832) begin
end
