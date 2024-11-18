if (cycle_1_6502) begin
    if (op_92 | op_96 | op_B6) begin
        am_ZIY_zp_y <= 1;
    end
end else if (cycle_2_6502) begin
    am_ZIY_zp_y <= 0;
end else if (cycle_1_65832) begin
end
