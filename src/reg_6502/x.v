always @(posedge i_cpu_clk) begin
    if (i_rst) begin
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        end
    end else if (cycle_2_6502) begin
        if (am_IMM_m) begin
            if (op_LDX) begin
                `X <= reg_data_byte;
            end
        end
    end else if (cycle_1_65832) begin
    end
end
