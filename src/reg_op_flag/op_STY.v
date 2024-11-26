always @(posedge i_clk) begin
    if (i_rst) begin
        op_STY <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_84_STY | op_8C_STY | op_94_STY) begin
            op_STY <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ABS_a) begin
            op_STY <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
