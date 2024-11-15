if (cycle_1_6502) begin
    if (op_12 | op_32 | op_72 | op_B2 | op_D2 | op_F2) begin
        am_ZPI_ZP <= 1;
    end
end else if (cycle_1_65832) begin
end
