always @(posedge i_cpu_clk) begin
    if (i_rst) begin
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
    end else if (cycle_3_6502) begin
        if (am_IMM_m) begin
            if (op_ADC) begin
            end else if (op_AND) begin
            end else if (op_ASL) begin
                `N <= asl_var_n;
                `Z <= asl_var_z;
                `C <= asl_var_c;
            end else if (op_EOR) begin
            end else if (op_LDA) begin
            end else if (op_ORA) begin
            end else if (op_SBC) begin
            end else if (op_SUB) begin
            end
        end
    end else if (cycle_1_65832) begin
    end
end
