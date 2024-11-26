always @(posedge i_clk) begin
    if (i_rst) begin
        am_ZPG_zp <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_04_TSB | op_05_ORA | op_06_ASL | op_07_RMB0 | op_17_RMB1 | op_27_RMB2 | op_37_RMB3 | op_47_RMB4 | op_57_RMB5 | op_67_RMB6 | op_77_RMB7 |
            op_14 | op_24_BIT | op_25 | op_26_ROL | op_45_EOR | op_46_LSR | op_52_EOR | op_64_STZ | op_65_ADC | op_66_ROR | op_84_STY |
            op_85_STA | op_86_STX | op_87_SMB0 | op_97_SMB1 | op_A7_SMB2 | op_B7_SMB3 | op_C7_SMB4 | op_D7_SMB5 | op_E7_SMB6 | op_F7_SMB7 | op_A4_LDY |
            op_A5_LDA | op_A6_LDX | op_C4_CPY | op_C5_CMP | op_C6_DEC | op_E4_CPX | op_E5_SBC | op_E6_INC) begin
            am_ZPG_zp <= 1;
        end
    end else if (cycle_2_6502) begin
        am_ZPG_zp <= 0;
    end
end
