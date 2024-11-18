if (cycle_4_6502) begin
    if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
    end else if (op_BBR | op_BBS) begin
        reg_data_byte <= i_bus_data;
    end
end
