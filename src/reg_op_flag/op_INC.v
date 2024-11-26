always @(posedge i_clk) begin
    if (i_rst) begin
        op_INC <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_E6_INC | op_EE_INC | op_F6_INC | op_FE_INC) begin
            op_INC <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
