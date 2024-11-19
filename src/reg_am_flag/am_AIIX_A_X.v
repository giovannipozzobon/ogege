always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_AIIX_A_X <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_7C) begin
            am_AIIX_A_X <= 1;
        end
    end else if (cycle_6_6502) begin
        am_AIIX_A_X <= 0;
    end
end
