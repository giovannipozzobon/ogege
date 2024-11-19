always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_DEC <= 0;
    end else if (cycle_1_6502) begin
        if (op_C6 | op_CE | op_D6 | op_DE) begin
            op_DEC <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
