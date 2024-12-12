/*
assign am_PCR_r =
    (op_0F_BBR0 | op_1F_BBR1 | op_2F_BBR2 | op_3F_BBR3 | op_4F_BBR4 | op_5F_BBR5 | op_6F_BBR6 | op_7F_BBR7 |
    op_8F_BBS0 | op_9F_BBS1 | op_AF_BBS2 | op_BF_BBS3 | op_CF_BBS4 | op_DF_BBS5 | op_EF_BBS6 | op_FF_BBS7 |
    op_10_BPL |
    op_30_BMI |
    op_50_BVC |
    op_70_BVS |
    op_80_BRA |
    op_90_BCC |
    op_B0_BCS |
    op_D0_BNE |
    op_F0_BEQ);
*/

if (am_PCR_r) begin
    if (cycle_1) begin
        if ((op_10_BPL & `N) |
            (op_30_BMI & `NN) |
            (op_50_BVC & `V) |
            (op_70_BVS & `NV) |
            (op_90_BCC & `C) |
            (op_B0_BCS & `NC) |
            (op_D0_BNE & `Z) |
            (op_F0_BEQ & `NZ)) begin
            `PC <= inc_pc;
        else if ((op_10_BPL & `NN) |
            (op_30_BMI & `N) |
            (op_50_BVC & `NV) |
            (op_70_BVS & `V) |
            op_80_BRA |
            (op_90_BCC & `NC) |
            (op_B0_BCS & `C) |
            (op_D0_BNE & `NZ) |
            (op_F0_BEQ & `Z)) begin
            `PC <= `PC + {(reg_code_byte_1[7] ? `ONES_8 : `ZERO_8), reg_code_byte_1};
        end
    end else if (cycle_2) begin
    end else if (cycle_3) begin
    end else if (cycle_4) begin
    end
end

