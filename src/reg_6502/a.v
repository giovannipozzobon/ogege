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
    else if (op_8A) begin
        `A <= `X;
    else if (op_98) begin
        `A <= `Y;
    end
end else if (cycle_3_6502) begin
    if (am_IMM_m) begin
        if (op_ADC) begin
            `A <= adc_a_var;
        end else if (op_AND) begin
            `A <= and_a_var;
        end else if (op_EOR) begin
            `A <= eor_a_var;
        end else if (op_LDA) begin
            `A <= reg_data_byte;
        end else if (op_ORA) begin
            `A <= or_a_var;
        end else if (op_SBC) begin
            `A <= sbc_a_var;
        end else if (op_SUB) begin
            `A <= sub_a_var;
        end
    end
end else if (cycle_1_65832) begin
end
