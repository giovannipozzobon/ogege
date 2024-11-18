if (cycle_1_6502) begin
    if (op_E1 | op_E5 | op_E9 | op_ED | op_F1 | op_F2 | op_F5 | op_F9 | op_FD) begin
        op_SBC <= 1;
    end
end else if (cycle_3_6502) begin
    if (am_IMM_m) begin
        op_SBC <= 0;
    end
end else if (cycle_1_65832) begin
end
