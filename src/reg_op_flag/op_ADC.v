always @(posedge i_clk) begin
    if (i_rst) begin
        op_ADC <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_61_ADC | op_65_ADC | op_69_ADC | op_6D_ADC | op_71_ADC | op_72_ADC | op_75_ADC | op_79_ADC | op_7D_ADC) begin
            op_ADC <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_ADC <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
