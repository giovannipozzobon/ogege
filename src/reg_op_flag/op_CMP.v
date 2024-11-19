always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_C1 | op_C5 | op_C9 | op_CD | op_D1 | op_D2 | op_D3 | op_D9 | op_DD) begin
            op_CMP <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_CMP <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
