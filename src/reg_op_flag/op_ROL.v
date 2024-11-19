always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
    end else if (cycle_1_6502) begin
        if (op_26 | op_2E | op_36 | op_3E) begin
            op_ROL <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
