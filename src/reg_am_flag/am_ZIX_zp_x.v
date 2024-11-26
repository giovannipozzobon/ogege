always @(posedge i_clk) begin
    if (i_rst) begin
        am_ZIX_zp_x <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_15_ORA | op_16_ASL | op_34_BIT | op_35_AND | op_36_ROL | op_55_EOR | op_56_LSR | op_74_STZ | op_75_ADC |
            op_76_ROR | op_94_STY | op_95_STA | op_B4_LDY | op_B5_LDA | op_D5 | op_D6_DEC | op_F5_SBC | op_F6_INC) begin
            am_ZIX_zp_x <= 1;
        end
    end else if (cycle_2_6502) begin
        am_ZIX_zp_x <= 0;
    end
end
