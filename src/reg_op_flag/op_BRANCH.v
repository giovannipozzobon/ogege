always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_BRANCH <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if ((op_10 & `NN) |
            (op_30 & `N) |
            (op_50 & `NV) |
            (op_70 & `V) |
            op_80 |
            (op_90 & `NC) |
            (op_B0 & `C) |
            (op_D0 & `NZ) |
            (op_F0 & `Z)) begin
            op_BRANCH <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
