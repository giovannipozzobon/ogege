always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_IMM_m <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_03 | op_09_ORA | op_29 | op_49 | op_69_ADC | op_89 | op_A0 | op_A2 | op_A9 |
            op_C0 | op_C9 | op_E0 | op_E9) begin
            am_IMM_m <= 1;
        end
    end else if (cycle_3_6502) begin
        am_IMM_m <= 0;
    end
end
