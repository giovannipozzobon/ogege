if (cycle_1_6502) begin
    if (op_21 | op_29 | op_2D | op_31 | op_32 | op_35 | op_39 | op_3D) begin
        op_AND <= 1;
    end
end else if (cycle_1_65832) begin
end
