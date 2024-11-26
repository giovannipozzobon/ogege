always @(posedge i_clk) begin
    if (i_rst) begin
        op_ADD <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_02_ADD) begin
            op_ADD <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
