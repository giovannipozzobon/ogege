always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            if (am_ABS_a) begin
                if (op_JMP) begin
                end else if (op_JSR) begin
                    push_edst0 <= 1;
                end
            end
        end
    end
end
