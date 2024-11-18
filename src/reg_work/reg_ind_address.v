if (cycle_4_6502) begin
    if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        `IADDR1 <= i_bus_data;
    end
end else if (cycle_5_6502) begin
    if (am_AIIX_A_X | am_AIA_A) begin
        `IADDR0 <= i_bus_data;
    end else if (am_ZIIX_ZP_X) begin
        `IADDR1 <= i_bus_data;
    end else if (am_ZIIY_ZP_y) begin
        `IADDR1 <= i_bus_data + `Y;
    end
end else if (cycle_1_65832) begin
end
