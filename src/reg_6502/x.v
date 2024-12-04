always @(posedge i_rst or posedge i_cpu_clk) begin
    if (i_rst) begin
        `X <= `ZERO_8;
        `eX <= `ZERO_32;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_AA_TAX) begin
            `X <= `A;
        end else if (op_BA_TSX) begin
            `X <= `SP;
        end else if (op_CA_DEX) begin
            `X <= dec_x;
        end else if (op_E8_INX) begin
            `X <= inc_x;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            if (op_LDX) begin
                `X <= reg_data_byte;
            end
        end
    end else if (cycle_1_65832) begin
    end
end
