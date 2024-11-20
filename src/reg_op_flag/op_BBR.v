always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_BBR <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_0F_BBR0 | op_1F_BBR1 | op_2F_BBR2 | op_3F_BBR3 | op_4F_BBR4 | op_5F_BBR5 | op_6F_BBR6 | op_7F_BBR7) begin
            op_BBR <= 1;
        end
    end else if (cycle_5_6502) begin
        op_BBR <= 0;
    end else if (cycle_1_65832) begin
    end
end
