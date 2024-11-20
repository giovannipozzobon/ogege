always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        `PC <= `RESET_PC_ADDRESS + 1;
        `ePC <= `ZERO_32;
    end else if (delaying) begin
    end else if (cycle_0_6502 | cycle_2_6502) begin
        `PC <= inc_pc;
    end else if (cycle_1_6502) begin
        if ((op_10 & `N) |
            (op_30 & `NN) |
            (op_50 & `V) |
            (op_70 & `NV) |
            (op_90 & `C) |
            (op_B0 & `NC) |
            (op_D0 & `Z) |
            (op_F0 & `NZ)) begin
            `PC <= add_pc_2;
        end
    end else if (cycle_3_6502) begin
        if (~am_IMM_m) begin
            if (am_PCR_r) begin
                if (op_BBR | op_BBS) begin
                end else begin
                    `PC <= `PC + {(reg_address[7] ? `ONES_8 : `ZERO_8), `ADDR0};
                end
            end else begin
                `PC <= inc_pc;
            end
        end
    end else if (cycle_4_6502) begin
        if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
        end else if (op_BBR | op_BBS) begin
        end else begin
            if (am_ABS_a) begin
                if (op_JMP) begin
                    `PC <= `ADDR;
                end else if (op_JSR) begin
                    `PC <= `ADDR;
                end
            end
        end
    end else if (cycle_5_6502) begin
        if (op_BBR) begin
            if ((reg_src_data & reg_which) == 0) begin
                `PC <= `PC + {(reg_src_data[7] ? `ONES_8 : `ZERO_8), reg_src_data};
            end
        end else if (op_BBS) begin
            if ((reg_src_data & reg_which) != 0) begin
                `PC <= `PC + {(reg_src_data[7] ? `ONES_8 : `ZERO_8), reg_src_data};
            end
        end
    end else if (cycle_6_6502) begin
        if (am_AIIX_A_X | am_AIA_A) begin
            if (op_JMP) begin
                `PC <= {i_bus_data, `IADDR0};
            end
        end
    end else if (cycle_1_65832) begin
    end
end
