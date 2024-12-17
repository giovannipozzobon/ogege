/*
Accumulator A (6502)

assign am_ACC_A = (op_0A_ASL | op_3A_DEC | op_1A_INC |
 op_4A_LSR | op_2A_ROL | op_6A_ROR); 
*/

if (am_ACC_A) begin
    if (cycle_1) begin
        if (op_0A_ASL) begin
            `A <= asl_a;
            `N <= asl_a_n;
            `Z <= asl_a_z;
            `C <= asl_a_c;
        end else if (op_1A_INC) begin
            `A <= inc_a;
            `N <= inc_a_n;
            `Z <= inc_a_z;
        end else if (op_2A_ROL) begin
            `A <= rol_a;
            `N <= rol_a_n;
            `Z <= rol_a_z;
            `C <= rol_a_c;
        end else if (op_3A_DEC) begin
            `A <= dec_a;
            `N <= dec_a_n;
            `Z <= dec_a_z;
        end else if (op_4A_LSR) begin
            `A <= lsr_a;
            `N <= lsr_a_n;
            `Z <= lsr_a_z;
            `C <= lsr_a_c;
        end else if (op_6A_ROR) begin
            `A <= ror_a;
            `N <= ror_a_n;
            `Z <= ror_a_z;
            `C <= ror_a_c;
        end
        `END_INSTR;
    end
end
