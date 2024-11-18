if (cycle_1_6502) begin
    if (op_0A |
        (op_10 & `N) |
        op_13 |
        op_18 |
        op_1A |
        op_23 |
        op_2A |
        (op_30 & `NN) |
        op_38 |
        op_3A |
        op_4A |
        (op_50 & `V) |
        op_58 |
        op_6A |
        (op_70 & `NV) |
        op_78 |
        op_88 |
        op_8A |
        (op_90 & `C) |
        op_98 |
        op_9A |
        op_A8 |
        op_AA |
        (op_B0 & `NC) |
        op_B8 |
        op_BA |
        op_C8 |
        op_CA |
        (op_D0 & `Z) |
        op_D8 |
        op_E8 |
        op_EA |
        (op_F0 & `NZ) |
        op_F8) begin
        reg_cycle <= 0;
    end
end else if (cycle_3_6502) begin
    if (am_IMM_m) begin
        reg_cycle <= 0;
    end else if (am_PCR_r) begin
        if (op_BBR | op_BBS) begin
        end else begin
            reg_cycle <= 0;
        end
    end
else if (cycle_4_6502) begin
    if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
    end else if (op_BBR | op_BBS) begin
    end else begin
        if (am_ABS_a) begin
            if (op_JMP) begin
                reg_cycle <= 0;
            end
        end
    end
else if (cycle_6_6502)
    if (am_AIIX_A_X | am_AIA_A) begin
        reg_cycle <= 0;
    end
end else if (cycle_1_65832) begin
end
