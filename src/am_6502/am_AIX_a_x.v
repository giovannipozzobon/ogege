/*
Absolute Indexed with X a,x (6502)

assign am_AIX_a_x =
    (op_1D_ORA | op_1E_ASL | op_3C_BIT | op_3D_AND | op_3E_ROL | op_5D_EOR | op_5E_LSR | op_7D_ADC |
    op_7E_ROR | op_9E_STZ | op_9E_STZ | op_BC_LDY | op_BD_LDA | op_DD_CMP | op_DE_DEC | op_FD_SBC |
    op_FE_INC);
*/

if (am_AIX_a_x) begin
    if (cycle_2) begin
        // use code_byte_1 and code_byte_2 and X
    end else if (cycle_3) begin
    end else if (cycle_4) begin
    end
end
