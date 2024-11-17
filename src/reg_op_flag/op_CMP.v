if (cycle_1_6502) begin
    if (op_C1 | op_C5 | op_C9 | op_CD | op_D1 | op_D2 | op_D3 | op_D9 | op_DD) begin
        op_CMP <= 1;
    end
end else if (cycle_1_65832) begin
end
