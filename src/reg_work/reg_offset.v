if (cycle_2_6502) begin 
    if (am_ZIX_zp_x) begin
        `OFFSET <= {`ZERO_8, `X};
        load_from_address <= 1;
    end else if (am_ZIY_zp_y) begin
        `OFFSET <= {`ZERO_8, `Y};
        load_from_address <= 1;
    end else if (am_ZIIX_ZP_X) begin
        `OFFSET <= {`ZERO_8, `X};
    else
        `OFFSET <= 0;
    end
end
