always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_DB) begin
            op_STP <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
