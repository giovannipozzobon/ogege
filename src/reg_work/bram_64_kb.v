logic rst_or_clk; assign rst_or_clk = i_rst | i_clk;

`LOGIC_8 bram_start;

always @(posedge rst_or_clk) begin
    reg_bram_clka = 0;
    reg_bram_wea = 0;
    reg_bram_put_byte = 0;
    reg_bram_addra = 16'h00019;

    if (i_rst) begin
        bram_start <= 4;
        reg_bram_web <= 0;
        reg_bram_clkb <= 0;
        reg_bram_dib <= 0;
        reg_bram_addrb <= 0;
    end else if (bram_start != 0) begin
        bram_start <= bram_start - 1;
        // Force load of reset vector
        reg_bram_addra = `RESET_PC_ADDRESS;
        reg_bram_put_byte = 0;
        reg_bram_clka = ~bram_start[0];
        reg_code_byte <= 8'hCC; // Illegal instruction
        reg_data_byte <= 8'hDD;
    end else if (reg_bram_clka) begin
        reg_data_byte <= reg_bram_get_byte;
    end else if (delaying) begin
    end else if (cycle_0_6502) begin
        reg_bram_addra = `PC;
        reg_bram_clka = 1;
    end else if (cycle_1_6502) begin
        if (op_08_PHP) begin
            reg_bram_put_byte = `P;
            reg_bram_wea <= 1;
            reg_bram_addra = dec_sp;
            reg_bram_clka = 1;
        end else if (op_48_PHA) begin
            reg_bram_put_byte = `A;
            reg_bram_wea <= 1;
            reg_bram_addra = dec_sp;
            reg_bram_clka = 1;
        end else if (op_5A_PHY) begin
            reg_bram_put_byte = `Y;
            reg_bram_wea <= 1;
            reg_bram_addra = dec_sp;
            reg_bram_clka = 1;
        end else if (op_DA_PHX) begin
            reg_bram_put_byte = `X;
            reg_bram_wea <= 1;
            reg_bram_addra = dec_sp;
            reg_bram_clka = 1;
        end else if (op_28_PLP | op_68_PLA | op_7A_PLY | op_FA_PLX) begin
            reg_bram_addra = `SP;
            reg_bram_clka = 1;
        end
    end else if (cycle_2_6502) begin
        `ADDR0 <= reg_bram_get_byte;
        `ADDR1 <= 0;
        `ADDR2 <= 0;
        `ADDR3 <= 0;
        reg_bram_addra = `PC;
        if (am_ZPG_zp | am_ZIX_zp_x | am_ZIY_zp_y | am_ABS_a) begin
            reg_bram_clka = 1;
        end
    end else if (cycle_3_6502) begin
        if (~am_IMM_m) begin
            if (~am_PCR_r) begin
                if (op_BBR | op_BBS) begin
                    `SRC <= reg_bram_get_byte;
                end else begin
                    `ADDR1 <= reg_bram_get_byte;
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
                    reg_bram_put_byte = `A;
                end else if (op_STX) begin
                    reg_bram_put_byte = `X;
                end else if (op_STY) begin
                    reg_bram_put_byte = `Y;
                end else if (op_STZ) begin
                    reg_bram_put_byte = `ZERO_8;
                end else begin
                    reg_bram_clka = 1;
                end
            end else if (am_AIIX_A_X) begin
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_x_16;
            end else if (am_AIA_A) begin
                `ADDR1 <= reg_data_byte;
            end else if (am_AIX_a_x) begin
                reg_bram_clka = 1;
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_x_16;
            end else if (am_AIY_a_y) begin
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_y_16;
                reg_bram_clka = 1;
            end
        end
    end else if (cycle_5_6502) begin
        if (am_AIIX_A_X | am_AIA_A) begin
            `ADDR <= inc_addr;
        end else if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
            reg_bram_clka = 1;
        end
    end else if (cycle_1_65832) begin
    end
end
