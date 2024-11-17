if (cycle_1_6502) begin
    if (op_88) begin
        `Y <= dec_y;
    else if (op_C8) begin
        `Y <= inc_y;
    end
end else if (cycle_1_65832) begin
end
