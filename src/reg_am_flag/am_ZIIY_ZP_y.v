always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_ZIIY_ZP_y <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_11 | op_31_AND | op_51_EOR | op_71_ADC | op_91 | op_B1 | op_D1_CMP | op_F1) begin
            am_ZIIY_ZP_y <= 1;
        end
    end else if (cycle_5_6502) begin
        am_ZIIY_ZP_y <= 0;
    end
end
