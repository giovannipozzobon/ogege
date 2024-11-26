always @(posedge i_clk) begin
    if (i_rst) begin
        op_SMB <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_87_SMB0 | op_97_SMB1 | op_A7_SMB2 | op_B7_SMB3 | op_C7_SMB4 | op_D7_SMB5 | op_E7_SMB6 | op_F7_SMB7) begin
            op_SMB <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
