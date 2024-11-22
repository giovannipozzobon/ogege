`LOGIC_32 delay;
assign delaying = (delay != 0);
localparam BIG_DELAY = 1_000_000_000;

always @(posedge i_rst or posedge i_clk) begin
    if (i_rst) begin
        delay <= BIG_DELAY;
        reg_cycle <= 2; // Force JMP via Reset vector
    end else if (delaying) begin
        //delay <= delay - 1;
    end else begin
        delay <= BIG_DELAY;
        reg_cycle <= reg_cycle + 1; // Assume micro-instructions will continue.
        if (cycle_1_6502) begin
            if (op_0A_ASL |
                (op_10_BPL & `N) |
                op_13_NEG |
                op_18_CLC |
                op_1A_INC |
                op_23_NOT |
                op_2A_ROL |
                (op_30_BMI & `NN) |
                op_38_SEC |
                op_3A_DEC |
                op_4A_LSR |
                (op_50_BVC & `V) |
                op_58_CLI |
                op_6A_ROR |
                (op_70_BVS & `NV) |
                op_78_SEI |
                op_88_DEY |
                op_8A_TxA |
                (op_90_BCC & `C) |
                op_98_TYA |
                op_9A_TXS |
                op_A8_TAY |
                op_AA_TAX |
                (op_B0_BCS & `NC) |
                op_B8_CLV |
                op_BA_TSX |
                op_C8_INY |
                op_CA_DEX |
                (op_D0_BNE & `Z) |
                op_D8_CLD |
                op_E8_INX |
                op_EA_NOP |
                (op_F0_BEQ & `NZ) |
                op_F8_SED) begin
                reg_cycle <= 0;
            end
        end else if (cycle_3_6502) begin
            if (am_IMM_m) begin
                reg_cycle <= 0;
            end else if (am_ABS_a) begin
                if (op_JMP) begin
                    reg_cycle <= 0;
                end
            end else if (am_PCR_r) begin
                if (op_BBR | op_BBS) begin
                end else begin
                    reg_cycle <= 0;
                end
            end
        end else if (cycle_6_6502) begin
            if (am_AIIX_A_X | am_AIA_A) begin
                reg_cycle <= 0;
            end
        end else if (cycle_1_65832) begin
        end
    end
end
