if (cycle_2_6502) begin 
    if (am_ZIX_zp_x) begin
        reg_offset <= {`ZERO_8, `X};
    end else if (am_ZIY_zp_y) begin
        reg_offset <= {`ZERO_8, `Y};
    end else if (am_ZIIX_ZP_X) begin
        reg_offset <= {`ZERO_8, `X};
    else
        reg_offset <= 0;
    end
end
