always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        reg_code_byte <= 8'hCC;
    end else if (delaying) begin
    end else if (cycle_0_6502) begin
        reg_code_byte <= bram[`PC];
    end else if (cycle_0_65832) begin
    end
end
