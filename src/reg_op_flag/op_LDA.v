if (cycle_1_6502) begin
    if (op_A1 | op_A5 | op_A9 | op_AD | op_B1 | op_B2 | op_B5 | op_B9 | op_BD) begin
        op_LDA <= 1;
    end
end else if (cycle_1_65832) begin
end
