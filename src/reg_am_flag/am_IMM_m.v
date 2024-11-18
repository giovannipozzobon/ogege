if (cycle_1_6502) begin
    if (op_03 | op_09 | op_29 | op_49 | op_69 | op_89 | op_A0 | op_A2 | op_A9 |
        op_C0 | op_C9 | op_E0 | op_E9) begin
        am_IMM_m <= 1;
    end
end else if (cycle_3_6502) begin
    am_IMM_m <= 0;
end else if (cycle_1_65832) begin
end
