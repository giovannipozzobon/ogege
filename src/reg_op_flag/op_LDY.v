always @(posedge i_clk) begin
    if (i_rst) begin
        op_LDY <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_A0_LDY | op_A4_LDY | op_AC_LDY | op_B4_LDY | op_BC_LDY) begin
            op_LDY <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_LDY <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
