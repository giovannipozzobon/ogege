always @(posedge i_clk) begin
    if (i_rst) begin
        op_ROR <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_66_ROR | op_6E_ROR | op_76_ROR | op_7E_ROR) begin
            op_ROR <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
