if (cycle_1_6502) begin
    if (op_04 | op_05 | op_06 | op_07 | op_17 | op_27 | op_37 | op_47 | op_57 | op_67 | op_77 |
        op_14 | op_24 | op_25 | op_26 | op_45 | op_46 | op_52 | op_64 | op_65 | op_66 | op_84 |
        op_85 | op_86 | op_87 | op_97 | op_A7 | op_B7 | op_C7 | op_D7 | op_E7 | op_F7 | op_A4 |
        op_A5 | op_A6 | op_C4 | op_C5 | op_C6 | op_E4 | op_E5 | op_E6) begin
        am_ZPG_zp <= 1;
    end
end else if (cycle_1_65832) begin
end
