always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_STK_s <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_00_BRK | op_40 | op_60) begin
            am_STK_s <= 1;
        end
    end
end
