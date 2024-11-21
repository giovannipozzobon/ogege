always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_ABS_a <= 1; // Force JMP via Reset vector
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_0C_TSB | op_0D_ORA | op_0E_ASL | op_1C | op_20 | op_2C_BIT | op_2D_AND | op_2E |
            op_4C | op_4D_EOR | op_4E | op_6D_ADC | op_6E | op_8C | op_8D | op_8E |
            op_9C | op_AC | op_AD | op_AE | op_CC_CPY | op_CD_CMP | op_CE_DEC | op_EC_CPX |
            op_ED | op_EE_INC) begin
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
