always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_JMP <= 1; // Force JMP via Reset vector
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_4C_JMP | op_6C_JMP | op_7C_JMP) begin
            op_JMP <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_ABS_a) begin
            op_JMP <= 0;
        end
    end else if (cycle_6_6502) begin
        op_JMP <= 0;
    end else if (cycle_1_65832) begin
    end
end
