always @(posedge i_cpu_clk) begin
    if (i_rst) begin
        `PC <= `RESET_VECTOR_ADDRESS;
        `ePC <= `ZERO_32;
    end else if (delaying) begin
    end else if (cycle_0_6502) begin
        `PC <= inc_pc;
    end else if (cycle_1_6502) begin
        if ((op_10_BPL & `N) |
            (op_30_BMI & `NN) |
            (op_50_BVC & `V) |
            (op_70_BVS & `NV) |
            op_80_BRA |
            (op_90_BCC & `C) |
            (op_B0_BCS & `NC) |
            (op_D0_BNE & `Z) |
            (op_F0_BEQ & `NZ)) begin
            `PC <= inc_pc;
        end
    end else if (cycle_2_6502) begin
        if (op_80_BRA) begin 
            `PC <= `PC + {(reg_data_byte[7] ? `ONES_8 : `ZERO_8), reg_data_byte};
        end else if (~op_33_WTX) begin
            `PC <= inc_pc;
        end
    end else if (cycle_3_6502) begin
        if (am_ABS_a) begin
            if (op_JMP | op_JSR) begin
                `PC <= {reg_bram_doa_r, `ADDR0};
            end
        end else if (~am_IMM_m) begin
            if (am_PCR_r) begin
                if (op_BBR | op_BBS) begin
                end else begin
                    `PC <= `PC + {(reg_address[7] ? `ONES_8 : `ZERO_8), `ADDR0};
                end
            end else if (~op_33_WTX) begin
                `PC <= inc_pc;
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
