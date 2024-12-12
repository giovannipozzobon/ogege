always @(posedge i_cpu_clk) begin
    if (i_rst) begin
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_0A_ASL) begin
            `A <= asl_a;
        end else if (op_1A_INC) begin
            `A <= inc_a;
        end else if (op_2A_ROL) begin
            `A <= rol_a;
        end else if (op_3A_DEC) begin
            `A <= dec_a;
        end else if (op_4A_LSR) begin
            `A <= lsr_a;
        end else if (op_6A_ROR) begin
            `A <= ror_a;
        end
    end else if (cycle_2_6502) begin
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
end
