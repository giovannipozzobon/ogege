if (cycle_1_6502) begin
    if (op_E0 | op_E4 | op_EC) begin
        op_CPX <= 1;
    end
end else if (cycle_1_65832) begin
end
