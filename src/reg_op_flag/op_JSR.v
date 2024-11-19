always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_20) begin
            op_JSR <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ABS_a) begin
            op_JSR <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
