if (cycle_1_6502) begin
    if (op_AA) begin
        `X <= `A;
    else if (op_BA) begin
        `X <= `SP;
    else if (op_CA) begin
        `X <= dec_x;
    else if (op_E8) begin
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
