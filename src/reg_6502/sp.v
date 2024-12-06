always @(posedge i_cpu_clk) begin
    if (i_rst) begin
        `SP <= `RESET_SP_ADDRESS;
        `eSP <= `ZERO_32;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_08_PHP | op_48_PHA | op_5A_PHY | op_DA_PHX) begin
            `SP <= dec_sp;
        end else if (op_28_PLP | op_68_PLA | op_7A_PLY | op_FA_PLX) begin
            `SP = inc_sp;
        end else if (op_9A_TXS) begin
            `SP <= `X;
        end
    end else if (cycle_1_65832) begin
    end
end
