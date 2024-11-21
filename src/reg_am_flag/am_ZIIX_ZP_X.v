always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_ZIIX_ZP_X <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_01_ORA | op_02_ADD | op_21_AND | op_41_EOR | op_61_ADC | op_81 | op_A1 | op_C1_CMP | op_E1) begin
            am_ZIIX_ZP_X <= 1;
        end
    end else if (cycle_5_6502) begin
        am_ZIIX_ZP_X <= 0;
    end
end
