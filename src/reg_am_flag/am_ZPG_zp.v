if (cycle_1_6502) begin
    if (op_04 | op_05 | op_06 | op_07 | op_17 | op_27 | op_37 | op_47 | op_57 | op_67 | op_77) begin
        am_ZPG_zp <= 1;
    end
end else if (cycle_1_65832) begin
end
