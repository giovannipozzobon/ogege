always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_JMP <= 1; // Force JMP via Reset vector
    end else if (cycle_1_6502) begin
        if (op_4C | op_6C | op_7C) begin
            op_JMP <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            if (am_ABS_a) begin
                op_JMP <= 0;
            end
        end
    end else if (cycle_6_6502) begin
        op_JMP <= 0;
    end else if (cycle_1_65832) begin
    end
end
