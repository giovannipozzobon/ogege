if (cycle_1_6502) begin
    if (op_07 | op_17 | op_27 | op_37 | op_47 | op_57 | op_67 | op_77 |
        op_0F | op_1F | op_2F | op_3F | op_4F | op_5F | op_6F | op_7F |
        op_87 | op_97 | op_A7 | op_B7 | op_C7 | op_D7 | op_E7 | op_F7 |
        op_8F | op_9F | op_AF | op_BF | op_CF | op_DF | op_EF | op_FF) begin
        reg_which <= (`ONE_8 << reg_code_byte[6:4]);
    end
end else if (cycle_1_65832) begin
end
