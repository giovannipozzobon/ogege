if (cycle_3_6502) begin
    if (~am_IMM_m) begin
        if (am_PCR_r) begin
            if (op_BBR | op_BBS) begin
                `SRC <= i_bus_data;
            end
        end
    end
end else if (cycle_3_65832) begin
end
