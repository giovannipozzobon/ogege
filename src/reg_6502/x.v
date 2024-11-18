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
end else if (cycle_1_65832) begin
end
