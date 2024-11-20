always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        op_RMB <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_07_RMB0 | op_17_RMB1 | op_27_RMB2 | op_37_RMB3 | op_47_RMB4 | op_57_RMB5 | op_67_RMB6 | op_77_RMB7) begin
            op_RMB <= 1;
        end
    end else if (cycle_1_65832) begin
    end
end
