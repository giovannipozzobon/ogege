always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        reg_65832 <= 0;
    end else if (delaying) begin
    end
end
