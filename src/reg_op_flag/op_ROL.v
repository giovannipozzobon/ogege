always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_ROL <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_26_ROL | op_2E_ROL | op_36_ROL | op_3E_ROL) begin
            op_ROL <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
