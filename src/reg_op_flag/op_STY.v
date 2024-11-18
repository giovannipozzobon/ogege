if (cycle_1_6502) begin
    if (op_84 | op_8C | op_94) begin
        op_STY <= 1;
    end
end else if (cycle_1_65832) begin
end
