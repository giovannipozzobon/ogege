if (cycle_1_6502) begin
    if (op_0F | op_1F | op_2F | op_3F | op_4F | op_5F | op_6F | op_7F) begin
        op_BBR <= 1;
    end
end else if (cycle_1_65832) begin
end
