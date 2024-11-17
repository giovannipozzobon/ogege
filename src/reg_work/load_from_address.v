if (cycle_1_6502) begin
    if (op_28 | op_68 | op_7A | op_FA) begin
        load_from_address <= 1;
    end
end else if (cycle_1_65832) begin
end
