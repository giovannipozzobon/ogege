always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_11 | op_31 | op_51 | op_71 | op_91 | op_B1 | op_D1 | op_F1) begin
            am_ZIIY_ZP_y <= 1;
        end
    end else if (cycle_5_6502) begin
        am_ZIIY_ZP_y <= 0;
    end
end
