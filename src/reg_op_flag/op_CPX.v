always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_CPX <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_E0_CPX | op_E4_CPX | op_EC_CPX) begin
            op_CPX <= 1;
        end
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            op_CPX <= 0;
        end
    end else if (cycle_1_65832) begin
    end
end
