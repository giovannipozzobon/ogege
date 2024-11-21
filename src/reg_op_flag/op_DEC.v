always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_DEC <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_C6_DEC | op_CE_DEC | op_D6_DEC | op_DE_DEC) begin
            op_DEC <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
