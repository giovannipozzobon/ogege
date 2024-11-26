always @(posedge i_clk) begin
    if (i_rst) begin
        reg_bram_wea <= 0;
        reg_bram_dia_w <= 0;

        reg_bram_web <= 0;
        reg_bram_dib_w <= 0;
        reg_bram_addrb <= 0;

        `EADDR <= 32'hC001C0DE;
        reg_data_byte <= 8'hDD;
        reg_code_byte <= op_4C_JMP; // jump to absolute address
    end if (delaying) begin
    end else if (cycle_0_6502) begin
        reg_code_byte <= reg_bram_doa_r;
    end else if (cycle_1_6502) begin
        reg_data_byte <= reg_bram_doa_r;
        if (op_08_PHP) begin
            reg_bram_dia_w <= `P;
            reg_bram_wea <= 1;
            reg_bram_addrb <= dec_sp;
        end else if (op_48_PHA) begin
            reg_bram_wea <= 1;
            reg_bram_addrb <= dec_sp;
        end else if (op_28_PLP | op_68_PLA | op_7A_PLY | op_FA_PLX) begin
            reg_bram_addrb <= `SP;
        end
    end else if (cycle_2_6502) begin
        `ADDR0 <= reg_bram_doa_r;
        `ADDR1 <= `ZERO_8;
        `ADDR2 <= `ZERO_8;
        `ADDR3 <= `ZERO_8;
    end else if (cycle_3_6502) begin
        if (~am_IMM_m) begin
            if (~am_PCR_r) begin
                if (op_BBR | op_BBS) begin
                    `SRC <= reg_bram_doa_r;
                end else begin
                    `ADDR1 <= reg_bram_doa_r;
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
                    reg_bram_dia_w <= `A;
                end else if (op_STX) begin
                    reg_bram_dia_w <= `X;
                end else if (op_STY) begin
                    reg_bram_dia_w <= `Y;
                end else if (op_STZ) begin
                    reg_bram_dia_w <= `ZERO_8;
                end
            end else if (am_AIIX_A_X) begin
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_x_16;
            end else if (am_AIA_A) begin
                `ADDR1 <= reg_data_byte;
            end else if (am_AIX_a_x) begin
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_x_16;
            end else if (am_AIY_a_y) begin
                `ADDR <= {`ZERO_8, reg_data_byte} + uext_y_16;
            end
        end
    end else if (cycle_5_6502) begin
        if (am_AIIX_A_X | am_AIA_A) begin
            `ADDR <= inc_addr;
        end
    end else if (cycle_1_65832) begin
    end
end
