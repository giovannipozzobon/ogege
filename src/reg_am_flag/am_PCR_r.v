if (cycle_1_6502) begin
    if (op_0F | op_1F | op_2F | op_3F | op_4F | op_5F | op_6F | op_7F |
        (op_10 & `NN) |
        (op_30 & `N) |
        (op_50 & `NV) |
        (op_70 & `V) |
        op_80 |
        (op_90 & `NC) |
        (op_B0 & `C) |
        (op_D0 & `NZ) |
        (op_F0 & `Z) |
        op_8F | op_9F | op_AF | op_BF | op_CF | op_DF | op_EF | op_FF) begin
        am_PCR_r <= 1;
    end
end else if (cycle_1_65832) begin
end
