always @(posedge i_rst or posedge i_cpu_clk) begin
    if (i_rst) begin
        //store_to_address <= 0;
    end else if (delaying) begin
    end else if (cycle_1_6502) begin
        if (op_08_PHP | op_48_PHA | op_5A_PHY | op_DA_PHX) begin
            //`STORE_DST;
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            if (am_ABS_a) begin
                if (op_JMP) begin
                end else if (op_JSR) begin
                end else if (op_STA) begin
                    //`STORE_DST;
                end else if (op_STX) begin
                    //`STORE_DST;
                end else if (op_STY) begin
                    //`STORE_DST;
                end else if (op_STZ) begin
                    //`STORE_DST;
                end
            end
        end
    end else if (cycle_1_65832) begin
    end
end
