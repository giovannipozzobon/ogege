always @(posedge i_clk) begin
    if (i_rst) begin
        op_LDX <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_A2_LDX | op_A6_LDX | op_AE_LDX | op_B6_LDX | op_BE_LDX) begin
            op_LDX <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_LDX <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
