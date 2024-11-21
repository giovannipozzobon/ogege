always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_ABS_a <= 1; // Force JMP via Reset vector
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_0C_TSB | op_0D_ORA | op_0E_ASL | op_1C | op_20_JSR | op_2C_BIT | op_2D_AND | op_2E_ROL |
            op_4C_JMP | op_4D_EOR | op_4E_LSR | op_6D_ADC | op_6E_ROR | op_8C_STY | op_8D_STA | op_8E_STX |
            op_9C_STZ | op_AC_LDY | op_AD_LDA | op_AE_LDX | op_CC_CPY | op_CD_CMP | op_CE_DEC | op_EC_CPX |
            op_ED_SBC | op_EE_INC) begin
            am_ABS_a <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            am_ABS_a <= 0;
        end
    end
end
