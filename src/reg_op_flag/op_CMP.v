always @(posedge i_clk) begin
    if (i_rst) begin
        op_CMP <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_C1_CMP | op_C5_CMP | op_C9_CMP | op_CD_CMP | op_D1_CMP | op_D2_CMP | op_D9_CMP | op_DD_CMP) begin
            op_CMP <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_CMP <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
