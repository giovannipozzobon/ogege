always @(posedge i_clk) begin
    if (i_rst) begin
        op_SUB <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_03_SUB) begin
            op_SUB <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_SUB <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
