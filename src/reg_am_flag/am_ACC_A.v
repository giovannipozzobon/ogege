always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_ACC_A <= 0;
    end else if (cycle_1_6502) begin
    end
end
