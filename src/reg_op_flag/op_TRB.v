always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_TRB <= 0;
    end else if (cycle_1_6502) begin
        if (op_14 | op_1C) begin
            op_TRB <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
