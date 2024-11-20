always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_TSB <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_04_TSB | op_0C) begin
            op_TSB <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
