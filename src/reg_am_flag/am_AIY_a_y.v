if (cycle_1_6502) begin
    if (op_19 | op_39 | op_59 | op_79 | op_99 | op_B9 | op_BE | op_D9 | op_F9) begin
        am_AIY_a_y <= 1;
    end
else if (cycle_4_6502) begin
    if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
    end else if (op_BBR | op_BBS) begin
    end else begin
        am_AIY_a_y <= 0;
    end
end else if (cycle_1_65832) begin
end
