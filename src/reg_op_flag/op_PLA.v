always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_PLA <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_68_PLA) begin
            op_PLA <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
