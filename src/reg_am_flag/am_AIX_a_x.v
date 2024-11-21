always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        am_AIX_a_x <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_1D_ORA | op_1E_ASL | op_3C_BIT | op_3D_AND | op_3E_ROL | op_5D_EOR | op_5E_LSR | op_7D_ADC |
            op_7E_ROR | op_9E | op_9E | op_BC_LDY | op_BD_LDA | op_DD_CMP | op_DE_DEC | op_FD |
            op_FE_INC) begin
            am_AIX_a_x <= 1;
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            am_AIX_a_x <= 0;
        end
    end
end
