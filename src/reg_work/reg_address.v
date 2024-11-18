if (cycle_1_6502) begin
    if (op_08 | op_48 | op_5A | op_DA) begin
        `ADDR <= dec_sp;
    else if (op_28 | op_68 | op_7A | op_FA) begin
        `ADDR = `SP;
    end
end else if (cycle_2_6502) begin 
    `ADDR0 <= i_bus_data;
    `ADDR1 <= 0;
    `ADDR2 <= 0;
    `ADDR3 <= 0;
end else if (cycle_3_6502) begin
    if (~am_IMM_m) begin
        if (~am_PCR_r) begin
            `ADDR1 <= i_bus_data;
        end
    end
else if (cycle_4_6502) begin
    if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        `ADDR <= inc_addr;
    end else if (op_BBR | op_BBS) begin
    end else begin
        if (am_AIIX_A_X) begin
            `ADDR <= {`ZERO_8, reg_code_byte} + uext_x_16;
        end else if (am_AIA_A) begin
            `ADDR1 <= reg_code_byte;
        end else if (am_AIX_a_x) begin
            `ADDR <= {`ZERO_8, reg_code_byte} + uext_x_16;
        end else if (am_AIY_a_y) begin
            `ADDR <= {`ZERO_8, reg_code_byte} + uext_y_16;
        end
    end
end else if (cycle_1_65832) begin
end
