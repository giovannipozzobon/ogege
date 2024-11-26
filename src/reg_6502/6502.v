always @(posedge i_clk) begin
    if (i_rst) begin
        reg_6502 <= 1;
    end else if (delaying) begin
    end
end
