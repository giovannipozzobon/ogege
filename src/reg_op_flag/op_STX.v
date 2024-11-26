always @(posedge i_clk) begin
    if (i_rst) begin
        op_STX <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_86_STX | op_8E_STX | op_96_STX) begin
            op_STX <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ABS_a) begin
            op_STX <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
