if (cycle_1_6502) begin
    if (op_1D | op_1E | op_3C | op_3D | op_3E | op_5D | op_5E | op_7D |
        op_7E | op_9E | op_9E | op_BC | op_BD | op_DD | op_DE | op_FD |
        op_FE) begin
        am_AIX_a_x <= 1;
    end
end else if (cycle_1_65832) begin
end
