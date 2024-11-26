always @(posedge i_clk) begin
    if (i_rst) begin
        op_LDA <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_A1_LDA | op_A5_LDA | op_A0_LDA | op_AD_LDA | op_B1_LDA | op_B2_LDA | op_B5_LDA | op_B9_LDA | op_BD_LDA) begin
            op_LDA <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_LDA <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
