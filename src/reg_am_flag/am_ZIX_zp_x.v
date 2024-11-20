always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_ZIX_zp_x <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_15 | op_16 | op_34 | op_35 | op_36 | op_55 | op_56 | op_74 | op_75_ADC |
            op_76 | op_94 | op_95 | op_B4 | op_B5 | op_D5 | op_D6 | op_F5 | op_F6) begin
            am_ZIX_zp_x <= 1;
        end
    end else if (cycle_2_6502) begin
        am_ZIX_zp_x <= 0;
    end
end
