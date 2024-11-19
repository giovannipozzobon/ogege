always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_A2 | op_A6 | op_AE | op_B6 | op_BE) begin
            op_LDX <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_LDX <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
