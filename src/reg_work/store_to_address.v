if (cycle_1_6502) begin
    if (op_08 | op_48 | op_5A | op_DA) begin
        `STORE_DST;
    end
end else if (cycle_1_65832) begin
end
