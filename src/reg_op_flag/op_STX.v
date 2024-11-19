always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_86 | op_8E | op_96) begin
            op_STX <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ABS_a) begin
            op_STX <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
