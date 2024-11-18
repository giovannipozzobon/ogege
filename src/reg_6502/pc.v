if (cycle_0_6502 | cycle_2_6502) begin
    `PC <= inc_pc;
end else if (cycle_1_6502) begin
    if ((op_10 & `N) |
        (op_30 & `NN) |
        (op_50 & `V) |
        (op_70 & `NV) |
        (op_90 & `C) |
        (op_B0 & `NC) |
        (op_D0 & `Z) |
        (op_F0 & `NZ)) begin
        `PC <= add_pc_2;
    end
end else if (cycle_3_6502) begin
    if (~am_IMM_m) begin
        if (am_PCR_r) begin
            if (op_BBR | op_BBS) begin
            else
                `PC <= `PC + {(reg_address[7] ? `ONES_8 : `ZERO_8), `ADDR0};
            end
        end else begin
            `PC <= inc_pc;
        end
    end
else if (cycle_4_6502) begin
    if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        `IADDR1 <= i_bus_data;
        `ADDR <= inc_addr;
    end else if (op_BBR | op_BBS) begin
        reg_data_byte <= i_bus_data;
    end else begin
        if (am_ABS_a) begin
            if (op_JMP) begin
                `PC <= `ADDR;
            end else if (op_JSR) begin
                `PC <= `ADDR;
            end
        end
    end
end else if (cycle_1_65832) begin
end
