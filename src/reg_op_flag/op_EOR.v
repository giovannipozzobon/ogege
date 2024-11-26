always @(posedge i_clk) begin
    if (i_rst) begin
        op_EOR <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_41_EOR | op_45_EOR | op_49_EOR | op_4D_EOR | op_51_EOR | op_52_EOR | op_55_EOR | op_59_EOR | op_5D_EOR) begin
            op_EOR <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_EOR <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
