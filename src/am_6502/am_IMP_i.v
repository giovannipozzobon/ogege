/*
Implied Operations i (6502)

assign am_IMP_i = 
    (op_13_NEG |
    op_18_CLC |
    op_23_NOT |
    op_38_SEC |
    op_58_CLI |
    op_78_SEI |
    op_88_DEY |
    op_8A_TXA |
    op_98_TYA |
    op_9A_TXS |
    op_A8_TAY |
    op_AA_TAX |
    op_B8_CLV |
    op_BA_TSX |
    op_C8_INY |
    op_CA_DEX |
    op_CB_WAI |
    op_D8_CLD |
    op_E8_INX |
    op_EA_NOP |
    op_F8_SED);
*/

if (am_IMP_i) begin
    if (cycle_1) begin
        if (op_13_NEG) begin
            `A <= neg_a;
            `C <= neg_a_c;
            `N <= neg_a_n;
            `Z <= neg_a_z;
        end else if (op_18_CLC) begin
            `C <= 0;
        end else if (op_23_NOT) begin
            `A <= not_a;
            `N <= not_a_n;
            `Z <= not_a_z;
        end else if (op_38_SEC) begin
            `C <= 1;
        end else if (op_58_CLI) begin
            `I <= 0;
        end else if (op_78_SEI) begin
            `I <= 1;
        end else if (op_88_DEY) begin
            `Y <= dec_y;
            `N <= dec_y_n;
            `Z <= dec_y_z;
        end else if (op_8A_TXA) begin
            `A <= `X;
        end else if (op_98_TYA) begin
            `A <= `Y;
        end else if (op_9A_TXS) begin
            `SP <= `X;
        end else if (op_A8_TAY) begin
            `Y <= `A;
        end else if (op_AA_TAX) begin
            `X <= `A;
        end else if (op_B8_CLV) begin
            `V <= 0;
        end else if (op_BA_TSX) begin
            `X <= `SP;
        end else if (op_C8_INY) begin
            `Y <= inc_y;
            `N <= inc_y_n;
            `Z <= inc_y_z;
        end else if (op_CA_DEX) begin
            `X <= dec_x;
            `N <= dec_x_n;
            `Z <= dec_x_z;
        end else if (op_CB_WAI) begin
            // TBD
        end else if (op_D8_CLD) begin
            `D <= 0;
        end else if (op_E8_INX) begin
            `X <= inc_x;
            `N <= inc_x_n;
            `Z <= inc_x_z;
        end else if (op_F8_SED) begin
            `D <= 1;
        end
        reg_cycle <= 0;
    end
end
