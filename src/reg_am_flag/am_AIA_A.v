always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_AIA_A <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_6C) begin
            am_AIA_A <= 1;
        end
    end else if (cycle_6_6502) begin
        am_AIA_A <= 0;
    end
end
