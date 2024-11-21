always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        reg_ind_address <= 0;
    end else if (delaying) begin
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
            `IADDR1 <= reg_data_byte;
        end
    end else if (cycle_5_6502) begin
        if (am_AIIX_A_X | am_AIA_A) begin
            `IADDR0 <= reg_data_byte;
        end else if (am_ZIIX_ZP_X) begin
            `IADDR1 <= reg_data_byte;
        end else if (am_ZIIY_ZP_y) begin
            `IADDR1 <= reg_data_byte + `Y;
        end
    end else if (cycle_1_65832) begin
    end
end
