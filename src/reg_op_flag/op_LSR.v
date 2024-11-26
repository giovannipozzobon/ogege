always @(posedge i_clk) begin
    if (i_rst) begin
        op_LSR <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_46_LSR | op_4E_LSR | op_56_LSR | op_5E_LSR) begin
            op_LSR <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
