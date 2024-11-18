if (cycle_1_6502) begin
    if (op_41 | op_45 | op_49 | op_4D | op_51 | op_52 | op_55 | op_59 | op_5D) begin
        op_EOR <= 1;
    end
end else if (cycle_3_6502) begin
    if (am_IMM_m) begin
        op_EOR <= 0;
    end
end else if (cycle_1_65832) begin
end
