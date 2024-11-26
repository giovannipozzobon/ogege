always @(posedge i_clk) begin
    if (i_rst) begin
        am_ACC_A <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
    end
end
