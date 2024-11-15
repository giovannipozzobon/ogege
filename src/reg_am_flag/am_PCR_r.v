if (cycle_1_6502) begin
    if (op_0F | op_1F | op_2F | op_3F | op_4F | op_5F | op_6F | op_7F |
        op_10 | op_30 | op_50 | op_70 | op_80 | op_90 | op_B0 | op_D0 |
        op_F0 |
        op_8F | op_9F | op_AF | op_BF | op_CF | op_DF | op_EF | op_FF) begin
        am_PCR_r <= 1;
    end
end else if (cycle_1_65832) begin
end
