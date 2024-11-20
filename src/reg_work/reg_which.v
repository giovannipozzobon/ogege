always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        reg_which <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_07_RMB0 | op_17_RMB1 | op_27_RMB2 | op_37_RMB3 | op_47_RMB4 | op_57_RMB5 | op_67_RMB6 | op_77_RMB7 |
            op_0F | op_1F | op_2F | op_3F | op_4F | op_5F | op_6F | op_7F |
            op_87_SMB0 | op_97_SMB1 | op_A7_SMB2 | op_B7_SMB3 | op_C7_SMB4 | op_D7_SMB5 | op_E7_SMB6 | op_F7_SMB7 |
            op_8F | op_9F | op_AF | op_BF | op_CF | op_DF | op_EF | op_FF) begin
            reg_which <= (`ONE_8 << reg_code_byte[6:4]);
        end
    end else if (cycle_1_65832) begin
    end
end
