always @(posedge i_cpu_clk) begin
    if (i_rst) begin
        load_from_address <= 1; // Force load of reset vector
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_28_PLP | op_68_PLA | op_7A_PLY | op_FA_PLX) begin
            load_from_address <= 1;
        end
    end else if (cycle_2_6502) begin
        if (am_ZPG_zp) begin
            load_from_address <= 1;
        end else if (am_ZIX_zp_x) begin
            load_from_address <= 1;
        end else if (am_ZIY_zp_y) begin
        load_from_address <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            if (am_ABS_a) begin
                if (op_JMP) begin
                end else if (op_JSR) begin
                end else if (op_STA) begin
                end else if (op_STX) begin
                end else if (op_STY) begin
                end else if (op_STZ) begin
                end else begin
                    load_from_address <= 1;
                end
            end else if (am_AIIX_A_X) begin
            end else if (am_AIA_A) begin
            end else if (am_AIX_a_x) begin
                load_from_address <= 1;
            end else if (am_AIY_a_y) begin
                load_from_address <= 1;
            end
        end
    end else if (cycle_5_6502) begin
        if (am_ZIIX_ZP_X) begin
            load_from_address <= 1;
        end else if (am_ZIIY_ZP_y) begin
            load_from_address <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
