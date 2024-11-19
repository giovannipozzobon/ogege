always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_0C | op_0D | op_0E | op_1C | op_20 | op_2C | op_2D | op_2E |
            op_4C | op_4D | op_4E | op_6D | op_6E | op_8C | op_8D | op_8E |
            op_9C | op_AC | op_AD | op_AE | op_CC | op_CD | op_CE | op_EC |
            op_ED | op_EE) begin
            am_ABS_a <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            am_ABS_a <= 0;
        end
    end
end
