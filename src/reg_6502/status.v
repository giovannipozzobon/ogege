if (cycle_1_6502) begin
    if (op_0A) begin
        `A <= asl_a;
        `N <= asl_a_n;
        `Z <= asl_a_z;
        `C <= asl_a_c;
    else if (op_13) begin
        `A <= neg_a;
        `C <= neg_a_c;
        `N <= neg_a_n;
        `Z <= neg_a_z;
    else if (op_18) begin
        `C <= 0; // CLC
    else if (op_1A) begin
        `A <= inc_a;
        `N <= inc_a_n;
        `Z <= inc_a_z;
    else if (op_23) begin
        `A <= not_a;
        `N <= not_a_n;
        `Z <= not_a_z;
    else if (op_2A) begin
        `A <= rol_a;
        `N <= rol_a_n;
        `Z <= rol_a_z;
        `C <= rol_a_c;
    else if (op_38) begin
        `C <= 1;
    else if (op_3A) begin
        `A <= dec_a;
        `N <= dec_a_n;
        `Z <= dec_a_z;
    else if (op_4A) begin
        `A <= lsr_a;
        `N <= lsr_a_n;
        `Z <= lsr_a_z;
        `C <= lsr_a_c;
    else if (op_58) begin
        `I <= 0;
    else if (op_6A) begin
        `A <= ror_a;
        `N <= ror_a_n;
        `Z <= ror_a_z;
        `C <= ror_a_c;
    else if (op_78) begin
        `I <= 1;
    else if (op_88) begin
        `Y <= dec_y;
        `N <= dec_y_n;
        `Z <= dec_y_z;
    else if (op_C8) begin
        `Y <= inc_y;
        `N <= inc_y_n;
        `Z <= inc_y_z;
    else if (op_CA) begin
        `X <= dec_x;
        `N <= dec_x_n;
        `Z <= dec_x_z;
    else if (op_D8) begin
        `D <= 0; // CLD
    else if (op_E8) begin
        `X <= inc_x;
        `N <= inc_x_n;
        `Z <= inc_x_z;
    end
end else if (cycle_1_65832) begin
end
