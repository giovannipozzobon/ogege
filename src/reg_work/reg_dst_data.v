if (cycle_1_6502) begin
    if (op_08) begin
        `DST <= `P;
    else if (op_48) begin
        `DST <= `A;
    else if (op_5A) begin
        `DST <= `Y;
    else if (op_DA) begin
        `DST <= `X;
    end
end else if (cycle_1_65832) begin
end
