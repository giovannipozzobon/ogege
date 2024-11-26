always @(posedge i_clk) begin
    if (i_rst) begin
        op_BIT <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_24_BIT | op_2C_BIT | op_34_BIT | op_3C_BIT | op_89_BIT) begin
            op_BIT <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_BIT <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
