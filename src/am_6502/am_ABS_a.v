/*
Absolute a (6502)

assign am_ABS_a =
    (op_0C_TSB | op_0D_ORA | op_0E_ASL | op_1C_TRB |
     op_20_JSR | op_2C_BIT | op_2D_AND | op_2E_ROL |
     op_4C_JMP | op_4D_EOR | op_4E_LSR | op_6D_ADC |
     op_6E_ROR | op_8C_STY | op_8D_STA | op_8E_STX |
     op_9C_STZ | op_AC_LDY | op_AD_LDA | op_AE_LDX |
     op_CC_CPY | op_CD_CMP | op_CE_DEC | op_EC_CPX |
     op_ED_SBC | op_EE_INC);
*/

if (am_ABS_a) begin
    if (cycle_2) begin
        if (op_4C_JMP) begin
            `PC <= {wire_code_byte_2, wire_code_byte_1};
            `END_INSTR;
        end else if (op_20_JSR) begin
            `PC <= {wire_code_byte_2, wire_code_byte_1};
            // TBD
        end
    end else if (cycle_3) begin
    end else if (cycle_4) begin
    end
end
