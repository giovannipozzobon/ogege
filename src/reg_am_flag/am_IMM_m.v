always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_IMM_m <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_03 | op_09_ORA | op_29_AND | op_49_EOR | op_69_ADC | op_89_BIT | op_A0_LDY | op_A2_LDX | op_A0_LDA |
            op_C0_CPY | op_C9_CMP | op_E0_CPX | op_E9) begin
            am_IMM_m <= 1;
        end
    end else if (cycle_3_6502) begin
        am_IMM_m <= 0;
    end
end
