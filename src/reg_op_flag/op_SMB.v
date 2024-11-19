always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_SMB <= 0;
    end else if (cycle_1_6502) begin
        if (op_87 | op_97 | op_A7 | op_B7 | op_C7 | op_D7 | op_E7 | op_F7) begin
            op_SMB <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
