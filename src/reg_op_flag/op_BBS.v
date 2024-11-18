if (cycle_1_6502) begin
    if (op_8F | op_9F | op_AF | op_BF | op_CF | op_DF | op_EF | op_FF) begin
        op_BB <= 1;
    end
end else if (cycle_5_6502) begin
    op_BBS <= 0;
end else if (cycle_1_65832) begin
end
