always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_08) begin
            `DST <= `P;
        end else if (op_48) begin
            `DST <= `A;
        end else if (op_5A) begin
            `DST <= `Y;
        end else if (op_DA) begin
            `DST <= `X;
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            if (am_ABS_a) begin
                if (op_JMP) begin
                end else if (op_JSR) begin
                    `eDST0 <= `PC[7:0];
                    `eDST1 <= `PC[15:8];
                    push_edst0 <= 1;
                end else if (op_STA) begin
                    `DST <= `A;
                end else if (op_STX) begin
                    `DST <= `X;
                end else if (op_STY) begin
                    `DST <= `Y;
                end else if (op_STZ) begin
                    `DST <= `ZERO_8;
            end
            end
        end
    end else if (cycle_1_65832) begin
    end
end
