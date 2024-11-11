// 65832 cycle 0

// load instruction?
case (i_bus_data)
    8'h00: begin
            op_BRK <= 1;
            ame_STK_s <= 1;
        end

    8'h01: begin
            op_ORA <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'h06: begin
            op_ASL <= 1;
            ame_ABS_a <= 1;
        end

    8'h08: begin
            op_PHP <= 1;
            ame_STK_s <= 1;
        end

    8'h09: begin
            op_ORA <= 1;
            ame_IMM_m <= 1;
        end

    8'h0A: begin
            op_ASL <= 1;
            ame_ACC_A <= 1;
        end

    8'h0C: begin
            op_TSB <= 1;
            ame_ABS_a <= 1;
        end

    8'h0D: begin
            op_ORA <= 1;
            ame_ABS_a <= 1;
        end

    8'h10: begin
            if (`eNN) begin // BPL
                op_BRANCH <= 1;
                ame_PCR_r <= 1;
            end else begin
                `ePC <= add_epc_4;
                `END_INSTR;
            end
        end

    8'h11: begin
            op_ORA <= 1;
            ame_AIIY_A_y <= 1;
        end

    8'h12: begin
            op_ORA <= 1;
            ame_AIA_A <= 1;
        end

    8'h16: begin
            op_ASL <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h18: begin
            `C <= 0; // CLC
            `END_INSTR;
        end

    8'h19: begin
            op_ORA <= 1;
            ame_AIY_a_y <= 1;
        end

    8'h1A: begin
            // INC
            `eA <= inc_ea;
            `eN <= inc_ea_n;
            `eZ <= inc_ea_z;
            `END_INSTR;
        end

    8'h1C: begin
            op_TRB <= 1;
            ame_ABS_a <= 1;
        end

    8'h1D: begin
            op_ORA <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h20: begin
            op_JSR <= 1;
            ame_ABS_a <= 1;
        end

    8'h21: begin
            op_AND <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'h22: begin
            op_JSR <= 1;
            ame_AIA_A <= 1;
        end

    8'h23: begin
            op_SUB <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'h26: begin
            op_ROL <= 1;
            ame_ABS_a <= 1;
        end

    8'h28: begin
            op_PLP <= 1;
            ame_STK_s <= 1;
        end

    8'h29: begin
            op_AND <= 1;
            ame_IMM_m <= 1;
        end

    8'h2A: begin
            op_ROL <= 1;
            ame_ACC_A <= 1;
        end

    8'h2C: begin
            op_BIT <= 1;
            ame_ABS_a <= 1;
        end

    8'h2D: begin
            op_AND <= 1;
            ame_ABS_a <= 1;
        end

    8'h30: begin
            if (`eN) begin // BMI
                op_BRANCH <= 1;
                ame_PCR_r <= 1;
            end else begin
                `ePC <= add_epc_4;
                `END_INSTR;
            end
        end

    8'h31: begin
            op_AND <= 1;
            ame_AIIY_A_y <= 1;
        end

    8'h32: begin
            op_AND <= 1;
            ame_AIA_A <= 1;
        end

    8'h36: begin
            op_ROL <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h38: begin
            `C <= 1; // SEC
            `END_INSTR;
        end

    8'h39: begin
            op_AND <= 1;
            ame_AIY_a_y <= 1;
        end

    8'h3A: begin
            // DEC
            `eA <= dec_ea;
            `eN <= dec_ea_n;
            `eZ <= dec_ea_z;
            `END_INSTR;
        end

    8'h3C: begin
            op_BIT <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h3D: begin
            op_AND <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h40: begin
            op_RTI <= 1;
            ame_STK_s <= 1;
        end

    8'h41: begin
            op_EOR <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'h46: begin
            op_LSR <= 1;
            ame_ABS_a <= 1;
        end

    8'h48: begin
            op_PHA <= 1;
            ame_STK_s <= 1;
        end

    8'h49: begin
            op_EOR <= 1;
            ame_IMM_m <= 1;
        end

    8'h4A: begin
            op_LSR <= 1;
            ame_ACC_A <= 1;
        end

    8'h4C: begin
            op_JMP <= 1;
            ame_ABS_a <= 1;
        end

    8'h4D: begin
            op_EOR <= 1;
            ame_ABS_a <= 1;
        end

    8'h50: begin
            if (`eNV) begin // BVC
                op_BRANCH <= 1;
                ame_PCR_r <= 1;
            end else begin
                `ePC <= add_epc_4;
                `END_INSTR;
            end
        end

    8'h51: begin
            op_EOR <= 1;
            ame_AIIY_A_y <= 1;
        end

    8'h52: begin
            op_EOR <= 1;
            ame_AIA_A <= 1;
        end

    8'h56: begin
            op_LSR <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h58: begin
            `I <= 0; // CLI
            `END_INSTR;
        end

    8'h59: begin
            op_EOR <= 1;
            ame_AIY_a_y <= 1;
        end

    8'h5A: begin
            op_PHY <= 1;
            ame_STK_s <= 1;
        end

    8'h5C: begin
            op_JSR <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'h5D: begin
            op_EOR <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h60: begin
            op_RTS <= 1;
            ame_PCR_r <= 1;
        end

    8'h61: begin
            op_ADC <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'h66: begin
            op_ROR <= 1;
            ame_ABS_a <= 1;
        end

    8'h68: begin
            op_PLA <= 1;
            ame_STK_s <= 1;
        end

    8'h69: begin
            op_ADC <= 1;
            ame_IMM_m <= 1;
        end

    8'h6A: begin
            op_ROR <= 1;
            ame_ACC_A <= 1;
        end

    8'h6C: begin
            op_JMP <= 1;
            ame_AIA_A <= 1;
        end

    8'h6D: begin
            op_ADC <= 1;
            ame_ABS_a <= 1;
        end

    8'h70: begin
            if (`eV) begin // BVS
                op_BRANCH <= 1;
                ame_PCR_r <= 1;
            end else begin
                `ePC <= add_epc_4;
                `END_INSTR;
            end
        end

    8'h71: begin
            op_ADC <= 1;
            ame_AIIY_A_y <= 1;
        end

    8'h72: begin
            op_ADC <= 1;
            ame_AIA_A <= 1;
        end

    8'h76: begin
            op_ROR <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h78: begin
            `I <= 1; // SEI
            `END_INSTR;
        end

    8'h79: begin
            op_ADC <= 1;
            ame_AIY_a_y <= 1;
        end

    8'h7A: begin
            op_PLY <= 1;
            ame_STK_s <= 1;
        end

    8'h7C: begin
            op_JMP <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'h7D: begin
            op_ADC <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h80: begin
            // BRA
            op_BRANCH <= 1;
            ame_PCR_r <= 1;
        end

    8'h81: begin
            op_STA <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'h86: begin
            op_STZ <= 1;
            ame_ABS_a <= 1;
        end

    8'h88: begin
            // DEY
            `eY <= dec_ey;
            `eN <= dec_ey_n;
            `eZ <= dec_ey_z;
            `END_INSTR;
        end

    8'h89: begin
            op_BIT <= 1;
            ame_IMM_m <= 1;
        end

    8'h8A: begin
            // TXA
            reg_a <= reg_x;
            `END_INSTR;
        end

    8'h8C: begin
            op_STY <= 1;
            ame_ABS_a <= 1;
        end

    8'h8D: begin
            op_STA <= 1;
            ame_ABS_a <= 1;
        end

    8'h8E: begin
            op_STX <= 1;
            ame_ABS_a <= 1;
        end

    8'h90: begin
            if (`eNC) begin // BCC
                op_BRANCH <= 1;
                ame_PCR_r <= 1;
            end else begin
                `ePC <= add_epc_4;
                `END_INSTR;
            end
        end

    8'h91: begin
            op_STA <= 1;
            ame_AIIY_A_y <= 1;
        end

    8'h92: begin
            op_STA <= 1;
            ame_AIA_A <= 1;
        end

    8'h96: begin
            op_STZ <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h98: begin
            // TYA
            reg_a <= reg_y;
            `END_INSTR;
        end

    8'h99: begin
            op_STA <= 1;
            ame_AIY_a_y <= 1;
        end

    8'h9A: begin
            // TXS
            `eSP <= `eX;
            `END_INSTR;
        end

    8'h9C: begin
            op_STY <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h9D: begin
            op_STA <= 1;
            ame_AIX_a_x <= 1;
        end

    8'h9E: begin
            op_STX <= 1;
            ame_AIY_a_y <= 1;
        end

    8'hA0: begin
            op_LDY <= 1;
            ame_IMM_m <= 1;
        end

    8'hA1: begin
            op_LDA <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'hA2: begin
            op_LDX <= 1;
            ame_IMM_m <= 1;
        end

    8'hA8: begin
            // TAY
            `eY <= `eA;
            `END_INSTR;
        end

    8'hA9: begin
            op_LDA <= 1;
            ame_IMM_m <= 1;
        end

    8'hAA: begin
            // TAX
            `eX <= `eA;
            `END_INSTR;
        end

    8'hAC: begin
            op_LDY <= 1;
            ame_ABS_a <= 1;
        end

    8'hAD: begin
            op_LDA <= 1;
            ame_ABS_a <= 1;
        end

    8'hAE: begin
            op_LDX <= 1;
            ame_ABS_a <= 1;
        end

    8'hB0: begin
            if (`eC) begin // BCS
                op_BRANCH <= 1;
                ame_PCR_r <= 1;
            end else begin
                `ePC <= add_epc_4;
                `END_INSTR;
            end
        end

    8'hB1: begin
            op_LDA <= 1;
            ame_AIIY_A_y <= 1;
        end

    8'hB2: begin
            op_LDA <= 1;
            ame_AIA_A <= 1;
        end

    8'hB8: begin
            `V <= 0; // CLV
            `END_INSTR;
        end

    8'hB9: begin
            op_LDA <= 1;
            ame_AIY_a_y <= 1;
        end

    8'hBA: begin
            // TSX
            `eX <= `eSP;
            `END_INSTR;
        end

    8'hBC: begin
            op_LDY <= 1;
            ame_AIX_a_x <= 1;
        end

    8'hBD: begin
            op_LDA <= 1;
            ame_AIX_a_x <= 1;
        end

    8'hBE: begin
            op_LDX <= 1;
            ame_AIY_a_y <= 1;
        end

    8'hC0: begin
            op_CPY <= 1;
            ame_IMM_m <= 1;
        end

    8'hC1: begin
            op_CMP <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'hC6: begin
            op_DEC <= 1;
            ame_ABS_a <= 1;
        end

    8'hC8: begin
            // INY
            `eY <= inc_ey;
            `eN <= inc_ey_n;
            `eZ <= inc_ey_z;
            `END_INSTR;
        end

    8'hC9: begin
            op_CMP <= 1;
            ame_IMM_m <= 1;
        end

    8'hCA: begin
            // DEX
            `eX <= dec_ex;
            `eN <= dec_ex_n;
            `eZ <= dec_ex_z;
            `END_INSTR;
        end

    8'hCC: begin
            op_CPY <= 1;
            ame_ABS_a <= 1;
        end

    8'hCD: begin
            op_CMP <= 1;
            ame_ABS_a <= 1;
        end

    8'hD0: begin
            if (`eNZ) begin // BNE
                op_BRANCH <= 1;
                ame_PCR_r <= 1;
            end else begin
                `ePC <= add_epc_4;
                `END_INSTR;
            end
        end

    8'hD1: begin
            op_CMP <= 1;
            ame_AIIY_A_y <= 1;
        end

    8'hD2: begin
            op_CMP <= 1;
            ame_AIA_A <= 1;
        end

    8'hD6: begin
            op_DEC <= 1;
            ame_AIX_a_x <= 1;
        end

    8'hD8: begin
            `D <= 0; // CLD
            `END_INSTR;
        end

    8'hD9: begin
            op_CMP <= 1;
            ame_AIY_a_y <= 1;
        end

    8'hDA: begin
            op_PHX <= 1;
            ame_STK_s <= 1;
        end

    8'hDD: begin
            op_CMP <= 1;
            ame_AIX_a_x <= 1;
        end

    8'hE0: begin
            op_CPX <= 1;
            ame_IMM_m <= 1;
        end

    8'hE1: begin
            op_SBC <= 1;
            ame_AIIX_A_X <= 1;
        end

    8'hE6: begin
            op_INC <= 1;
            ame_ABS_a <= 1;
        end

    8'hE8: begin
            // INX
            `eX <= inc_ex;
            `eN <= inc_ex_n;
            `eZ <= inc_ex_z;
            `END_INSTR;
        end

    8'hE9: begin
            op_SBC <= 1;
            ame_IMM_m <= 1;
        end

    8'hEA: begin
            // NOP
            `END_INSTR;
        end

    8'hEC: begin
            op_CPX <= 1;
            ame_ABS_a <= 1;
        end

    8'hED: begin
            op_SBC <= 1;
            ame_ABS_a <= 1;
        end

    8'hF0: begin
            if (`eZ) begin // BEQ
                op_BRANCH <= 1;
                ame_PCR_r <= 1;
            end else begin
                `ePC <= add_epc_4;
                `END_INSTR;
            end
        end

    8'hF1: begin
            op_SBC <= 1;
            ame_AIIY_A_y <= 1;
        end

    8'hF2: begin
            op_SBC <= 1;
            ame_AIA_A <= 1;
        end

    8'hF6: begin
            op_INC <= 1;
            ame_AIX_a_x <= 1;
        end

    8'hF8: begin
            `D <= 1; // SED
            `END_INSTR;
        end

    8'hF9: begin
            op_SBC <= 1;
            ame_AIY_a_y <= 1;
        end

    8'hFA: begin
            op_PLX <= 1;
            ame_STK_s <= 1;
        end

    8'hFD: begin
            op_SBC <= 1;
            ame_AIX_a_x <= 1;
        end
endcase;
