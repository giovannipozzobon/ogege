reg [7:0] bram [0:65535];

initial $readmemh("../../ram/ram.bits", bram);

logic rst_or_clk; assign rst_or_clk = i_rst | i_clk;

always @(posedge rst_or_clk) begin
    `LOGIC_16 loc_address;
    logic must_read_code;
    logic must_read_data;
    logic must_write;
    logic dst_data;
    logic src_data;

    loc_address = 0;
    must_read_code = 0;
    must_read_data = 0;
    must_write = 0;
    dst_data = 0;
    src_data = 0;

    if (i_rst) begin
        // Force load of reset vector
        loc_address = `RESET_PC_ADDRESS;
        must_read_data = 1;
        reg_code_byte <= 8'hCC;
        reg_data_byte <= 8'hDD;
        reg_address <= 0;
    end else if (delaying) begin
    end else if (cycle_0_6502) begin
        must_read_code = 1;
        loc_address = `PC;
    end else if (cycle_1_6502) begin
        if (op_08_PHP) begin
            dst_data = `P;
            loc_address = dec_sp;
        end else if (op_48_PHA) begin
            dst_data = `A;
            loc_address = dec_sp;
        end else if (op_5A_PHY) begin
            dst_data = `Y;
            loc_address = dec_sp;
        end else if (op_DA_PHX) begin
            dst_data = `X;
            loc_address = dec_sp;
        end else if (op_28_PLP | op_68_PLA | op_7A_PLY | op_FA_PLX) begin
            must_read_data = 1;
            loc_address = `SP;
        end
    end else if (cycle_2_6502) begin
        `ADDR0 <= i_bus_data;
        `ADDR1 <= 0;
        `ADDR2 <= 0;
        `ADDR3 <= 0;
        if (am_ZPG_zp) begin
            must_read_data = 1;
        end else if (am_ZIX_zp_x) begin
            must_read_data = 1;
        end else if (am_ZIY_zp_y) begin
            must_read_data = 1;
        end
    end else if (cycle_3_6502) begin
        if (~am_IMM_m) begin
            if (~am_PCR_r) begin
                if (op_BBR | op_BBS) begin
                    `SRC <= i_bus_data;
                end else begin
                    `ADDR1 <= i_bus_data;
                end
            end
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
            `ADDR <= inc_addr;
        end else if (op_BBR | op_BBS) begin
            reg_data_byte <= i_bus_data;
        end else begin
            if (am_ABS_a) begin
                if (op_JMP) begin
                end else if (op_JSR) begin
                    `eDST0 <= `PC[7:0];
                    `eDST1 <= `PC[15:8];
                end else if (op_STA) begin
                    dst_data = `A;
                end else if (op_STX) begin
                    dst_data = `X;
                end else if (op_STY) begin
                    dst_data = `Y;
                end else if (op_STZ) begin
                    dst_data = `ZERO_8;
                end else begin
                    must_read_data = 1;
                end
            end else if (am_AIIX_A_X) begin
                `ADDR <= {`ZERO_8, reg_code_byte} + uext_x_16;
            end else if (am_AIA_A) begin
                `ADDR1 <= reg_code_byte;
            end else if (am_AIX_a_x) begin
                must_read_data = 1;
                `ADDR <= {`ZERO_8, reg_code_byte} + uext_x_16;
            end else if (am_AIY_a_y) begin
                `ADDR <= {`ZERO_8, reg_code_byte} + uext_y_16;
                must_read_data = 1;
            end
        end
    end else if (cycle_5_6502) begin
        if (am_AIIX_A_X | am_AIA_A) begin
            `ADDR <= inc_addr;
        end else if (am_ZIIX_ZP_X) begin
            must_read_data = 1;
        end else if (am_ZIIY_ZP_y) begin
            must_read_data = 1;
        end
    end else if (cycle_1_65832) begin
    end

    if (must_read_code) begin
        reg_code_byte <= bram[loc_address];
        reg_address <= loc_address;
    end else if (must_read_data) begin
        reg_code_byte <= bram[loc_address];
        reg_address <= loc_address;
    end else if (must_write) begin
        bram[loc_address] <= dst_data;
    end
end
