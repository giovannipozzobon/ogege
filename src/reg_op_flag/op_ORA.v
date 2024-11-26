always @(posedge i_clk) begin
    if (i_rst) begin
        op_ORA <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_01_ORA | op_05_ORA | op_09_ORA | op_0D_ORA |
            op_11_ORA | op_12_ORA | op_15_ORA | op_19_ORA | op_1D_ORA) begin
            op_ORA <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_ORA <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
