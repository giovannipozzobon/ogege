always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_RMB <= 0;
    end else if (cycle_1_6502) begin
        if (op_07 | op_17 | op_27 | op_37 | op_47 | op_57 | op_67 | op_77) begin
            op_RMB <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
