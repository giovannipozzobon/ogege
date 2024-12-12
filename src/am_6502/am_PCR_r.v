/*
assign am_PCR_r =
    (op_0F_BBR0 | op_1F_BBR1 | op_2F_BBR2 | op_3F_BBR3 | op_4F_BBR4 | op_5F_BBR5 | op_6F_BBR6 | op_7F_BBR7 |
    op_8F_BBS0 | op_9F_BBS1 | op_AF_BBS2 | op_BF_BBS3 | op_CF_BBS4 | op_DF_BBS5 | op_EF_BBS6 | op_FF_BBS7 |
    (op_10_BPL & `NN) |
    (op_30_BMI & `N) |
    (op_50_BVC & `NV) |
    (op_70_BVS & `V) |
    op_80_BRA |
    (op_90_BCC & `NC) |
    (op_B0_BCS & `C) |
    (op_D0_BNE & `NZ) |
    (op_F0_BEQ & `Z));
*/

if (am_PCR_r) begin
    if (cycle_1) begin
        // use code_byte_1
    end else if (cycle_2) begin
    end else if (cycle_3) begin
    end else if (cycle_4) begin
    end
end

