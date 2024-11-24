logic rst_or_clk; assign rst_or_clk = i_rst | i_clk;

reg test;
reg bram_start;
/*
always @(posedge rst_or_clk) begin
    if (i_rst) begin
        test <= 1;
        reg_bram_wea <= 0;
        reg_bram_web <= 0;
        reg_bram_clka <= 0;
        reg_bram_clkb <= 0;
        reg_bram_put_byte <= 0;
        reg_bram_dib <= 0;
        reg_bram_addra <= 0;
        reg_bram_addrb <= 0;
        //reg_bram_get_byte;
        //reg_bram_scan_byte;
    end else if (test) begin
        test <= 0;
        reg_bram_addra <= `RESET_PC_ADDRESS;
        reg_bram_clka <= 1;
    end else if (reg_bram_clka) begin
        reg_bram_clka <= 0;
    end
end
*/
// this was to test compilation; need to merge this code with code above
always @(posedge rst_or_clk) begin
    logic enable;
    logic do_write;
    `LOGIC_16 address;
    `LOGIC_8 write_data;

    enable = 0;
    do_write = 0;
    write_data = 0;
    address = 16'h00017;

    if (i_rst) begin
        bram_start <= 1;
    end else if (delaying) begin
    end else if (bram_start) begin
        bram_start <= 0;
        // Force load of reset vector
        address = `RESET_PC_ADDRESS;
        write_data = 0;
        enable = 1;
        reg_code_byte <= 8'hCC; // Illegal instruction
        reg_data_byte <= 8'hDD;
    end else if (reg_bram_clka) begin
        reg_data_byte <= reg_bram_get_byte;
        enable = 0;
    end else if (cycle_0_6502) begin
        address = `PC;
        enable = 1;
    end else if (cycle_1_6502) begin
        if (op_08_PHP) begin
            write_data = `P;
            do_write <= 1;
            address = dec_sp;
            enable = 1;
        end else if (op_48_PHA) begin
            write_data = `A;
            do_write <= 1;
            address = dec_sp;
            enable = 1;
        end else if (op_5A_PHY) begin
            write_data = `Y;
            do_write <= 1;
            address = dec_sp;
            enable = 1;
        end else if (op_DA_PHX) begin
            write_data = `X;
            do_write <= 1;
            address = dec_sp;
            enable = 1;
        end else if (op_28_PLP | op_68_PLA | op_7A_PLY | op_FA_PLX) begin
            address = `SP;
            enable = 1;
        end
    end else if (cycle_2_6502) begin
        `ADDR0 <= reg_bram_get_byte;
        `ADDR1 <= 0;
        `ADDR2 <= 0;
        `ADDR3 <= 0;
        address = `PC;
        if (am_ZPG_zp | am_ZIX_zp_x | am_ZIY_zp_y | am_ABS_a) begin
            enable = 1;
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
                    write_data = `A;
                end else if (op_STX) begin
                    write_data = `X;
                end else if (op_STY) begin
                    write_data = `Y;
                end else if (op_STZ) begin
                    write_data = `ZERO_8;
                end else begin
                    enable = 1;
                end
            end else if (am_AIIX_A_X) begin
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_x_16;
            end else if (am_AIA_A) begin
                `ADDR1 <= reg_data_byte;
            end else if (am_AIX_a_x) begin
                enable = 1;
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_x_16;
            end else if (am_AIY_a_y) begin
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_y_16;
                enable = 1;
            end
        end
    end else if (cycle_5_6502) begin
        if (am_AIIX_A_X | am_AIA_A) begin
            `ADDR <= inc_addr;
        end else if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
            enable = 1;
        end
    end else if (cycle_1_65832) begin
    end

    reg_bram_clka <= enable;
    reg_bram_addra <= address;
    reg_bram_wea <= do_write;
    reg_bram_put_byte <= write_data;
end
