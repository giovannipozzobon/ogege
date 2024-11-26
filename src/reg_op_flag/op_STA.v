always @(posedge i_clk) begin
    if (i_rst) begin
        op_STA <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_81_STA | op_85_STA | op_8D_STA | op_91_STA | op_92_STA | op_95_STA | op_99_STA | op_9D_STA) begin
            op_STA <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ABS_a) begin
            op_STA <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
