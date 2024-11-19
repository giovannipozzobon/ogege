always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        reg_data_byte <= 8'hDD;
    end else if (delaying) begin
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
            reg_data_byte <= i_bus_data;
        end
    end
end
