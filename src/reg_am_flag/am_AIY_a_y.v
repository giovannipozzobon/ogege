always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_AIY_a_y <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_19_ORA | op_39_AND | op_59_EOR | op_79_ADC | op_99_STA | op_B9_LDA | op_BE_LDX | op_D9_CMP | op_F9_SBC) begin
            am_AIY_a_y <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            am_AIY_a_y <= 0;
        end
    end
end
