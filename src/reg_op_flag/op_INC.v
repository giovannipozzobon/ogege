if (cycle_1_6502) begin
    if (op_E6 | op_EE | op_F6 | op_FE) begin
        op_INC <= 1;
    end
end else if (cycle_1_65832) begin
end
