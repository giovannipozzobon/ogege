always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        `Y <= `ZERO_8;
        `eY <= `ZERO_32;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_88) begin
            `Y <= dec_y;
        end else if (op_A8) begin
            `Y <= `A;
        end else if (op_C8) begin
            `Y <= inc_y;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            if (op_LDY) begin
                `Y <= reg_data_byte;
            end
        end
    end else if (cycle_1_65832) begin
    end
end
