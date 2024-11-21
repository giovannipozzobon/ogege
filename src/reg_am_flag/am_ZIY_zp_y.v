always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_ZIY_zp_y <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_92_STA | op_96_STX | op_B6_LDX) begin
            am_ZIY_zp_y <= 1;
        end
    end else if (cycle_2_6502) begin
        am_ZIY_zp_y <= 0;
    end
end
