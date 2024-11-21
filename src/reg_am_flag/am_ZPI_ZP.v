always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_ZPI_ZP <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_12 | op_32_AND | op_72_ADC | op_B2 | op_D2_CMP | op_F2) begin
            am_ZPI_ZP <= 1;
        end
    end
end
