always @(posedge i_clk) begin
    if (i_rst) begin
        op_BRANCH <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if ((op_10_BPL & `NN) |
            (op_30_BMI & `N) |
            (op_50_BVC & `NV) |
            (op_70_BVS & `V) |
            op_80_BRA |
            (op_90_BCC & `NC) |
            (op_B0_BCS & `C) |
            (op_D0_BNE & `NZ) |
            (op_F0_BEQ & `Z)) begin
            op_BRANCH <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
