always @(posedge i_clk) begin
    if (i_rst) begin
        am_PCR_r <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_0F_BBR0 | op_1F_BBR1 | op_2F_BBR2 | op_3F_BBR3 | op_4F_BBR4 | op_5F_BBR5 | op_6F_BBR6 | op_7F_BBR7 |
            (op_10_BPL & `NN) |
            (op_30_BMI & `N) |
            (op_50_BVC & `NV) |
            (op_70_BVS & `V) |
            op_80_BRA |
            (op_90_BCC & `NC) |
            (op_B0_BCS & `C) |
            (op_D0_BNE & `NZ) |
            (op_F0_BEQ & `Z) |
            op_8F_BBS0 | op_9F_BBS1 | op_AF_BBS2 | op_BF_BBS3 | op_CF_BBS4 | op_DF_BBS5 | op_EF_BBS6 | op_FF_BBS7) begin
            am_PCR_r <= 1;
        end
    end else if (cycle_3_6502) begin
        if (~am_IMM_m) begin
            if (am_PCR_r) begin
                if (op_BBR | op_BBS) begin
                end else begin
                    am_PCR_r <= 0;
                end
            end
        end
    end else if (cycle_5_6502) begin
        if (op_BBR | op_BBS) begin
            am_PCR_r <= 0;
        end
    end
end
