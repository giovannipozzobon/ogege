if (cycle_1_6502) begin
    if (op_0A) begin
        `A <= asl_a;
    else if (op_13) begin
        `A <= neg_a;
    else if (op_1A) begin
        `A <= inc_a;
    else if (op_23) begin
        `A <= not_a;
    else if (op_2A) begin
        `A <= rol_a;
    else if (op_3A) begin
        `A <= dec_a;
    else if (op_4A) begin
        `A <= lsr_a;
    else if (op_6A) begin
        `A <= ror_a;
    end
end else if (cycle_1_65832) begin
end
