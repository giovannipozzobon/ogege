always @(posedge i_rst or posedge i_cpu_clk) begin
    if (i_rst) begin
        reg_which <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_07_RMB0 | op_17_RMB1 | op_27_RMB2 | op_37_RMB3 | op_47_RMB4 | op_57_RMB5 | op_67_RMB6 | op_77_RMB7 |
            op_0F_BBR0 | op_1F_BBR1 | op_2F_BBR2 | op_3F_BBR3 | op_4F_BBR4 | op_5F_BBR5 | op_6F_BBR6 | op_7F_BBR7 |
            op_87_SMB0 | op_97_SMB1 | op_A7_SMB2 | op_B7_SMB3 | op_C7_SMB4 | op_D7_SMB5 | op_E7_SMB6 | op_F7_SMB7 |
            op_8F_BBS0 | op_9F_BBS1 | op_AF_BBS2 | op_BF_BBS3 | op_CF_BBS4 | op_DF_BBS5 | op_EF_BBS6 | op_FF_BBS7) begin
            reg_which <= (`ONE_8 << reg_code_byte[6:4]);
        end
    end else if (cycle_1_65832) begin
    end
end
