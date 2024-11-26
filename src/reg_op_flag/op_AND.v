always @(posedge i_clk) begin
    if (i_rst) begin
        op_AND <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_21_AND | op_29_AND | op_2D_AND | op_31_AND | op_32_AND | op_35_AND | op_39_AND | op_3D_AND) begin
            op_AND <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_AND <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
