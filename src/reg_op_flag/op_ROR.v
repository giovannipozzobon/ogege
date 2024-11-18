if (cycle_1_6502) begin
    if (op_66 | op_6E | op_76 | op_7E) begin
        op_ROR <= 1;
    end
end else if (cycle_1_65832) begin
end
