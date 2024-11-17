if (cycle_1_6502) begin
    if (op_61 | op_65 | op_69 | op_6D | op_71 | op_72 | op_75 | op_79 | op_7D) begin
        op_ADC <= 1;
    end
end else if (cycle_1_65832) begin
end
