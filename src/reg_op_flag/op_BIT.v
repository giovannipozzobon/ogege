always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_BIT <= 0;
    end else if (cycle_1_6502) begin
        if (op_24 | op_2C | op_34 | op_3C | op_89) begin
            op_BIT <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_BIT <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
