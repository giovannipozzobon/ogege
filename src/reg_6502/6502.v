always @(posedge i_rst or posedge i_cpu_clk) begin
    if (i_rst) begin
        reg_6502 <= 1;
    end else if (delaying) begin
    end
end
