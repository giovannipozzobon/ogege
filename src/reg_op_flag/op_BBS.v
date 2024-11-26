always @(posedge i_clk) begin
    if (i_rst) begin
        op_BBS <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_8F_BBS0 | op_9F_BBS1 | op_AF_BBS2 | op_BF_BBS3 | op_CF_BBS4 | op_DF_BBS5 | op_EF_BBS6 | op_FF_BBS7) begin
            op_BB <= 1;
        end
    end else if (cycle_5_6502) begin
        op_BBS <= 0;
    end else if (cycle_1_65832) begin
    end
end
