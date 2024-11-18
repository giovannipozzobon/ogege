if (cycle_1_6502) begin
    if (op_46 | op_4E | op_56 | op_5E) begin
        op_LSR <= 1;
    end
end else if (cycle_1_65832) begin
end
