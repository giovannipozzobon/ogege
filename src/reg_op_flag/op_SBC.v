always @(posedge i_clk) begin
    if (i_rst) begin
        op_SBC <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_E1_SBC | op_E5_SBC | op_E9_SBC | op_ED_SBC | op_F1_SBC | op_F2_SBC | op_F5_SBC | op_F9_SBC | op_FD_SBC) begin
            op_SBC <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_SBC <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
