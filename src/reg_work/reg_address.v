if (cycle_1_6502) begin
    if (op_08 | op_48 | op_5A | op_DA) begin
        `ADDR <= dec_sp;
    else if (op_28 | op_68 | op_7A | op_FA) begin
        `ADDR = `SP;
    end
end else if (cycle_1_65832) begin
end
