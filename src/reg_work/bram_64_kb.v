logic rst_or_clk; assign rst_or_clk = i_rst | i_clk;

always @(posedge rst_or_clk) begin

    if (i_rst) begin
        bram_wait <= 0;
        reg_bram_wea <= 0;
        reg_bram_web <= 0;
        reg_bram_clka <= 0;
        //wire_clkb <= 0;
        reg_bram_put_byte <= 0;
        reg_bram_dib <= 0;
        reg_bram_addra <= 0;
        //wire_addrb <= 0;
    end else if (bram_wait == 0) begin
        reg_bram_clka <= 1;
        reg_bram_addra <= `RESET_PC_ADDRESS;
        bram_address <= `RESET_PC_ADDRESS;
        bram_wait <= 1;
    end else if (bram_wait == 1) begin
        reg_bram_clka <= 0;
        bram_read_data <= reg_bram_get_byte;
    end else if (bram_wait == 2) begin
        bram_wait <= 3;
    end

/*
    bram_enable <= 0;
    bram_do_write <= 0;
    bram_address <= 16'h27E9;

    if (i_rst) begin
        bram_wait <= 0;
    end else if (bram_wait == 0) begin
        bram_address <= `RESET_PC_ADDRESS;
        bram_write_data <= 101;
        bram_enable <= 1;
        bram_wait <= 1;
    end else if (bram_wait == 1) begin
        bram_enable <= 0;
        bram_wait <= 2;
    end else if (bram_wait == 2) begin
        bram_wait <= 3;
    end else if (delaying) begin
    end else if (bram_wait) begin
        bram_start <= 1;
        bram_enable <= 1;
    end else if (bram_start) begin
        bram_start <= 0;
        // Force load of reset vector
        bram_address <= `RESET_PC_ADDRESS;
        bram_write_data <= 0;
        bram_enable <= 1;
        reg_code_byte <= 8'hCC; // Illegal instruction
        reg_data_byte <= 8'hDD;
    end else if (bram_enable) begin
        reg_data_byte <= bram_read_data;
        bram_enable <= 0;
    end else if (cycle_0_6502) begin
        bram_address <= `PC;
        bram_enable <= 1;
    end else if (cycle_1_6502) begin
        if (op_08_PHP) begin
            bram_write_data <= `P;
            bram_do_write <= 1;
            bram_address <= dec_sp;
            bram_enable <= 1;
        end else if (op_48_PHA) begin
            bram_write_data <= `A;
            bram_do_write <= 1;
            bram_address <= dec_sp;
            bram_enable <= 1;
        end else if (op_5A_PHY) begin
            bram_write_data <= `Y;
            bram_do_write <= 1;
            bram_address <= dec_sp;
            bram_enable <= 1;
        end else if (op_DA_PHX) begin
            bram_write_data <= `X;
            bram_do_write <= 1;
            bram_address <= dec_sp;
            bram_enable <= 1;
        end else if (op_28_PLP | op_68_PLA | op_7A_PLY | op_FA_PLX) begin
            bram_address <= `SP;
            bram_enable <= 1;
        end
    end else if (cycle_2_6502) begin
        `ADDR0 <= bram_read_data;
        `ADDR1 <= 0;
        `ADDR2 <= 0;
        `ADDR3 <= 0;
        bram_address <= `PC;
        if (am_ZPG_zp | am_ZIX_zp_x | am_ZIY_zp_y | am_ABS_a) begin
            bram_enable <= 1;
        end
    end else if (cycle_3_6502) begin
        if (~am_IMM_m) begin
            if (~am_PCR_r) begin
                if (op_BBR | op_BBS) begin
                    `SRC <= bram_read_data;
                end else begin
                    `ADDR1 <= bram_read_data;
                end
            end
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
            `ADDR <= inc_addr;
        end else if (op_BBR | op_BBS) begin
            //??reg_data_byte <= reg_data_byte;
        end else begin
            if (am_ABS_a) begin
                if (op_JMP) begin
                end else if (op_JSR) begin
                    `eDST0 <= `PC[7:0];
                    `eDST1 <= `PC[15:8];
                end else if (op_STA) begin
                    bram_write_data <= `A;
                end else if (op_STX) begin
                    bram_write_data <= `X;
                end else if (op_STY) begin
                    bram_write_data <= `Y;
                end else if (op_STZ) begin
                    bram_write_data <= `ZERO_8;
                end else begin
                    bram_enable <= 1;
                end
            end else if (am_AIIX_A_X) begin
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_x_16;
            end else if (am_AIA_A) begin
                `ADDR1 <= reg_data_byte;
            end else if (am_AIX_a_x) begin
                bram_enable <= 1;
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_x_16;
            end else if (am_AIY_a_y) begin
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_y_16;
                bram_enable <= 1;
            end
        end
    end else if (cycle_5_6502) begin
        if (am_AIIX_A_X | am_AIA_A) begin
            `ADDR <= inc_addr;
        end else if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
            bram_enable <= 1;
        end
    end else if (cycle_1_65832) begin
    end
*/
end
