always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_01 | op_05 | op_09 | op_0D | op_11 | op_12 | op_15 | op_19 | op_1D) begin
            op_ORA <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_ORA <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
