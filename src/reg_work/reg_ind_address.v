if (cycle_4_6502) begin
    if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        `IADDR1 <= i_bus_data;
    end
end else if (cycle_1_65832) begin
end
