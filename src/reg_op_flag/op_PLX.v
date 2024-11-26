always @(posedge i_clk) begin
    if (i_rst) begin
        op_PLX <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_FA_PLX) begin
            op_PLX <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
