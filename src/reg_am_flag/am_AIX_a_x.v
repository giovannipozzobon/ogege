always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_1D | op_1E | op_3C | op_3D | op_3E | op_5D | op_5E | op_7D |
            op_7E | op_9E | op_9E | op_BC | op_BD | op_DD | op_DE | op_FD |
            op_FE) begin
            am_AIX_a_x <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            am_AIX_a_x <= 0;
        end
    end
end
