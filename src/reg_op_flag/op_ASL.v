always @(posedge i_clk) begin
    if (i_rst) begin
        op_ASL <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_06_ASL | op_0E_ASL | op_16_ASL | op_1E_ASL) begin
            op_ASL <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_ASL <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
