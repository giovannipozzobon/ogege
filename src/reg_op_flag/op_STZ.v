always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_STZ <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_64 | op_74 | op_9C | op_9E) begin
            op_STZ <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ABS_a) begin
            op_STZ <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
