// 6502 cycle 2

`ADDR0 <= i_bus_data;
`ADDR1 <= 0;
`ADDR2 <= 0;
`ADDR3 <= 0;
`OFFSET <= 0;
`PC <= inc_pc;
if (am_ZPG_zp) begin
    am_ZPG_zp <= 0;
    load_from_address <= 1;
end else if (am_ZIX_zp_x) begin
    `OFFSET <= {`ZERO_8, `X};
    am_ZIX_zp_x <= 0;
    load_from_address <= 1;
end else if (am_ZIY_zp_y) begin
    `OFFSET <= {`ZERO_8, `Y};
    am_ZIY_zp_y <= 0;
    load_from_address <= 1;
end else if (am_ZIIX_ZP_X) begin
    `OFFSET <= {`ZERO_8, `X};
end
