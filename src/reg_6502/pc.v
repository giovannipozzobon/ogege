if (cycle_0_6502) begin
    `PC <= inc_pc;
end else if (cycle_1_6502) begin
    if ((op_10 & `N) |
        (op_30 & `NN) |
        (op_50 & `V) |
        (op_70 & `NV) |
        (op_90 & `C) |
        (op_B0 & `NC) |
        (op_D0 & `Z) |
        (op_F0 & `NZ)) begin
        `PC <= add_pc_2;
    end
end else if (cycle_1_65832) begin
end
