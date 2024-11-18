if (cycle_1_6502) begin
    if (op_A0 | op_A4 | op_AC | op_B4 | op_BC) begin
        op_LDY <= 1;
    end
end else if (cycle_1_65832) begin
end
