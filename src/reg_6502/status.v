if (cycle_1_6502) begin
    if (op_0A) begin
        `N <= asl_a_n;
        `Z <= asl_a_z;
        `C <= asl_a_c;
    else if (op_13) begin
        `C <= neg_a_c;
        `N <= neg_a_n;
        `Z <= neg_a_z;
    else if (op_18) begin
        `C <= 0; // CLC
    else if (op_1A) begin
        `N <= inc_a_n;
        `Z <= inc_a_z;
    else if (op_23) begin
        `N <= not_a_n;
        `Z <= not_a_z;
    else if (op_2A) begin
        `N <= rol_a_n;
        `Z <= rol_a_z;
        `C <= rol_a_c;
    else if (op_38) begin
        `C <= 1;
    else if (op_3A) begin
        `N <= dec_a_n;
        `Z <= dec_a_z;
    else if (op_4A) begin
        `N <= lsr_a_n;
        `Z <= lsr_a_z;
        `C <= lsr_a_c;
    else if (op_58) begin
        `I <= 0;
    else if (op_6A) begin
        `N <= ror_a_n;
        `Z <= ror_a_z;
        `C <= ror_a_c;
    else if (op_78) begin
        `I <= 1;
    else if (op_88) begin
        `N <= dec_y_n;
        `Z <= dec_y_z;
    else if (op_B8) begin
        `V <= 0;
    else if (op_C8) begin
        `N <= inc_y_n;
        `Z <= inc_y_z;
    else if (op_CA) begin
        `N <= dec_x_n;
        `Z <= dec_x_z;
    else if (op_D8) begin
        `D <= 0;
    else if (op_E8) begin
        `N <= inc_x_n;
        `Z <= inc_x_z;
    else if (op_F8) begin
        `D <= 1;
    end
end else if (cycle_1_65832) begin
end
