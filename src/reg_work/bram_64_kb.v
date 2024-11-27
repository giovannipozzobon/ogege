logic rst_or_clk; assign rst_or_clk = i_rst | i_clk;

always @(posedge rst_or_clk) begin
    if (i_rst) begin
        //reg_bram_start <= 0;
        //reg_bram_active <= 0;
        //reg_bram_clka <= 0;
        reg_bram_wea <= 0;
        //reg_bram_addra <= `RESET_VECTOR_ADDRESS;//16'h0200;
        reg_bram_dia_w <= 0;

        reg_bram_web <= 0;
        //reg_bram_clkb <= 0;
        reg_bram_dib_w <= 0;
        reg_bram_addrb <= 0;

        `EADDR <= 32'hC001C0DE;
        reg_code_byte <= 8'hCC; // Illegal instruction
        reg_data_byte <= 8'hDD;
//    end else if (reg_bram_start == 0) begin
        //reg_bram_clka <= 1;
//        reg_bram_start <= 1;
//    end else if (reg_bram_start == 1) begin
//        reg_bram_clka <= 0;
//        reg_bram_start <= 2;
//    end else if (reg_bram_start == 2) begin
//        reg_bram_clka <= 1;
//        reg_bram_start <= 3;
    end else if (wire_bram_doa_r == 0) begin
        //reg_bram_clka <= 0;
        reg_data_byte <= wire_bram_doa_r;
        reg_code_byte <= wire_bram_doa_r;
//    end else if (reg_bram_start != 4'hE) begin
//        reg_bram_start <= reg_bram_start + 1;
//        reg_data_byte <= wire_bram_doa_r;
//        reg_code_byte <= wire_bram_doa_r;
    end
    /*
    end else if (reg_bram_start) begin
        reg_bram_start <= reg_bram_start - 1;
        // Force load of reset vector
        reg_bram_addra <= `RESET_VECTOR_ADDRESS;
        reg_bram_dia_w <= 0;
        reg_bram_clka <= reg_bram_start[0];
        reg_bram_active <= 1;
    end else if (reg_bram_active) begin
        reg_data_byte <= wire_bram_doa_r;
        reg_bram_active <= 0;
    end else if (reg_bram_clka) begin
        reg_bram_clka <= 0;
    end if (delaying) begin
    end else if (cycle_0_6502) begin
        reg_bram_addra <= `PC;
        reg_bram_clka <= 1;
    end else if (cycle_1_6502) begin
        if (op_08_PHP) begin
            reg_bram_dia_w <= `P;
            reg_bram_wea <= 1;
            reg_bram_addra <= dec_sp;
            reg_bram_clka <= 1;
        end else if (op_48_PHA) begin
            reg_bram_wea <= 1;
            reg_bram_addra <= dec_sp;
            reg_bram_clka <= 1;
        end else if (op_28_PLP | op_68_PLA | op_7A_PLY | op_FA_PLX) begin
            reg_bram_addra <= `SP;
            reg_bram_clka <= 1;
        end
    end else if (cycle_2_6502) begin
        `ADDR0 <= wire_bram_doa_r;
        `ADDR1 <= `ZERO_8;
        `ADDR2 <= `ZERO_8;
        `ADDR3 <= `ZERO_8;
        reg_bram_addra <= `PC;
        if (am_ZPG_zp | am_ZIX_zp_x | am_ZIY_zp_y | am_ABS_a) begin
            reg_bram_clka <= 1;
        end
    end else if (cycle_3_6502) begin
        if (~am_IMM_m) begin
            if (~am_PCR_r) begin
                if (op_BBR | op_BBS) begin
                    `SRC <= wire_bram_doa_r;
                end else begin
                    `ADDR1 <= wire_bram_doa_r;
                end
            end
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
            `ADDR <= 16'h0101;//inc_addr;
        end else if (op_BBR | op_BBS) begin
            //??reg_data_byte <= reg_data_byte;
        end else begin
            if (am_ABS_a) begin
                if (op_JMP) begin
                end else if (op_JSR) begin
                    `eDST0 <= `PC[7:0];
                    `eDST1 <= `PC[15:8];
                end else if (op_STA) begin
                    reg_bram_dia_w <= `A;
                end else if (op_STX) begin
                    reg_bram_dia_w <= `X;
                end else if (op_STY) begin
                    reg_bram_dia_w <= `Y;
                end else if (op_STZ) begin
                    reg_bram_dia_w <= `ZERO_8;
                end else begin
                    reg_bram_clka <= 1;
                end
            end else if (am_AIIX_A_X) begin
                `ADDR <= 16'h0202;//{`ZERO_8, reg_data_byte} + uext_x_16;
            end else if (am_AIA_A) begin
                `ADDR1 <= reg_data_byte;
            end else if (am_AIX_a_x) begin
                reg_bram_clka <= 1;
                `ADDR <= 16'h0303;//{`ZERO_8, reg_data_byte} + uext_x_16;
            end else if (am_AIY_a_y) begin
                `ADDR <= 16'h0404;//{`ZERO_8, reg_data_byte} + uext_y_16;
                reg_bram_clka <= 1;
            end
        end
    end else if (cycle_5_6502) begin
        if (am_AIIX_A_X | am_AIA_A) begin
            `ADDR <= 16'h0505;//inc_addr;
        end else if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
            reg_bram_clka <= 1;
        end
    end else if (cycle_1_65832) begin
    end*/
end
