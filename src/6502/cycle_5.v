// 6502 cycle 5

if (am_AIIX_A_X | am_AIA_A) begin
    `IADDR0 <= i_bus_data;
    `ADDR <= inc_addr;
end else if (am_ZIIX_ZP_X) begin
    `IADDR1 <= i_bus_data;
    am_ZIIX_ZP_X <= 0;
    load_from_address <= 1;
end else if (am_ZIIY_ZP_y) begin
    `IADDR1 <= i_bus_data + `Y;
    am_ZIIY_ZP_y <= 0;
    load_from_address <= 1;
end else if (op_BBR) begin
    am_PCR_r <= 0;
    if ((reg_src_data & reg_which) == 0) begin
        `PC <= `PC + {(reg_src_data[7] ? `ONES_8 : `ZERO_8), reg_src_data};
    end
    `END_OPER_INSTR(op_BBR);
end else if (op_BBS) begin
    am_PCR_r <= 0;
    if ((reg_src_data & reg_which) != 0) begin
        `PC <= `PC + {(reg_src_data[7] ? `ONES_8 : `ZERO_8), reg_src_data};
    end
    `END_OPER_INSTR(op_BBS);
end
