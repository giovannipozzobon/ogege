// 6502 cycle 1

case (reg_code_byte)

    8'h08: begin
            // PHP
            var_hw_address = dec_sp;
            `SP <= var_hw_address;
            `ADDR <= var_hw_address;
            `DST <= `P;
            `STORE_DST;
        end

    8'h0A: begin
            // ASL
            `A <= asl_a;
            `N <= asl_a_n;
            `Z <= asl_a_z;
            `C <= asl_a_c;
            `END_INSTR;
        end

    8'h0F, 8'h1F, 8'h2F, 8'h3F,
    8'h4F, 8'h5F, 8'h6F, 8'h7F:
        begin
            op_BBR <= 1;
            
           
        end

    8'h10: begin
            if (`NN) begin // BPL
                
                
            end else begin
                `PC <= add_pc_2;
                `END_INSTR;
            end
        end

 
    8'h13: begin
            // NEG
            `A <= neg_a;
            `C <= neg_a_c;
            `N <= neg_a_n;
            `Z <= neg_a_z;
            `END_INSTR;
        end

    8'h14: begin
            op_TRB <= 1;
           
        end

    8'h18: begin
            `C <= 0; // CLC
            `END_INSTR;
        end

      8'h1A: begin
            // INC
            `A <= inc_a;
            `N <= inc_a_n;
            `Z <= inc_a_z;
            `END_INSTR;
        end

    8'h1C: begin
            op_TRB <= 1;
            
        end

    8'h20: begin
            op_JSR <= 1;
            
        end

    8'h21: begin
            op_AND <= 1;
            
        end

    8'h23: begin
            // NOT
            `A <= not_a;
            `N <= not_a_n;
            `Z <= not_a_z;
            `END_INSTR;
        end

    8'h24: begin
            op_BIT <= 1;
            
        end

    8'h25: begin
            op_AND <= 1;
           
        end

    8'h26: begin
            op_ROL <= 1;
            
        end

    8'h28: begin
            op_PLP <= 1;
            `ADDR = `SP;
            `SP = inc_sp;
            load_from_address <= 1;
        end

    8'h29: begin
            op_AND <= 1;
            
        end

    8'h2A: begin
            // ROL
            `A <= rol_a;
            `N <= rol_a_n;
            `Z <= rol_a_z;
            `C <= rol_a_c;
            `END_INSTR;
        end

    8'h2C: begin
            op_BIT <= 1;
            
        end

    8'h2D: begin
            op_AND <= 1;
            
        end

    8'h2E: begin
            op_ROL <= 1;
            
        end

    8'h30: begin
            if (`N) begin // BMI
                
                
            end else begin
                `PC <= add_pc_2;
                `END_INSTR;
            end
        end

    8'h31: begin
            op_AND <= 1;
            
        end

    8'h32: begin
            op_AND <= 1;
            
        end

    8'h34: begin
            op_BIT <= 1;
            
        end

    8'h35: begin
            op_AND <= 1;
            
        end

    8'h36: begin
            op_ROL <= 1;
            
        end

    8'h38: begin
            `C <= 1; // SEC
            `END_INSTR;
        end

    8'h39: begin
            op_AND <= 1;
            
        end

    8'h3A: begin
            // DEC
            `A <= dec_a;
            `N <= dec_a_n;
            `Z <= dec_a_z;
            `END_INSTR;
        end

    8'h3C: begin
            op_BIT <= 1;
            
        end

    8'h3D: begin
            op_AND <= 1;
            
        end

    8'h3E: begin
            op_ROL <= 1;
            
        end

    8'h40: begin
            op_RTI <= 1;
            
        end

    8'h41: begin
            op_EOR <= 1;
            
        end

    8'h45: begin
            op_EOR <= 1;
            
        end

    8'h46: begin
            op_LSR <= 1;
            
        end

    8'h48: begin
            // PHA
            var_hw_address = dec_sp;
            `SP <= var_hw_address;
            `ADDR <= var_hw_address;
            `DST <= `A;
            `STORE_DST;
        end

    8'h49: begin
            op_EOR <= 1;
            
        end

    8'h4A: begin
            // LSR
            `A <= lsr_a;
            `N <= lsr_a_n;
            `Z <= lsr_a_z;
            `C <= lsr_a_c;
            `END_INSTR;
        end

    8'h4C: begin
            op_JMP <= 1;
            
        end

    8'h4D: begin
            op_EOR <= 1;
            
        end

    8'h4E: begin
            op_LSR <= 1;
            
        end

    8'h50: begin
            if (`NV) begin // BVC
                
                
            end else begin
                `PC <= add_pc_2;
                `END_INSTR;
            end
        end

    8'h51: begin
            op_EOR <= 1;
            
        end

    8'h52: begin
            op_EOR <= 1;
            
        end

    8'h55: begin
            op_EOR <= 1;
            
        end

    8'h56: begin
            op_LSR <= 1;
            
        end

    8'h58: begin
            `I <= 0; // CLI
            `END_INSTR;
        end

    8'h59: begin
            op_EOR <= 1;
            
        end

    8'h5A: begin
            // PHY
            var_hw_address = dec_sp;
            `SP <= var_hw_address;
            `ADDR <= var_hw_address;
            `DST <= `Y;
            `STORE_DST;
        end

    8'h5D: begin
            op_EOR <= 1;
            
        end

    8'h5E: begin
            op_LSR <= 1;
            
        end

    8'h60: begin
            op_RTS <= 1;
            
        end

    8'h61: begin
            op_ADC <= 1;
            
        end

    8'h64: begin
            op_STZ <= 1;
            
        end

    8'h65: begin
            op_ADC <= 1;
            
        end

    8'h66: begin
            op_ROR <= 1;
            
        end

    8'h68: begin
            op_PLA <= 1;
            `ADDR = `SP;
            `SP = inc_sp;
            load_from_address <= 1;
        end

    8'h69: begin
            op_ADC <= 1;
            
        end

    8'h6A: begin
            // ROR
            `A <= ror_a;
            `N <= ror_a_n;
            `Z <= ror_a_z;
            `C <= ror_a_c;
            `END_INSTR;
        end

    8'h6C: begin
            op_JMP <= 1;
            
        end

    8'h6D: begin
            op_ADC <= 1;
            
        end

    8'h6E: begin
            op_ROR <= 1;
            
        end

    8'h70: begin
            if (`V) begin // BVS
                
                
            end else begin
                `PC <= add_pc_2;
                `END_INSTR;
            end
        end

    8'h71: begin
            op_ADC <= 1;
            
        end

    8'h72: begin
            op_ADC <= 1;
            
        end

    8'h74: begin
            op_STZ <= 1;
            
        end

    8'h75: begin
            op_ADC <= 1;
            
        end

    8'h76: begin
            op_ROR <= 1;
            
        end

    8'h78: begin
            `I <= 1; // SEI
            `END_INSTR;
        end

    8'h79: begin
            op_ADC <= 1;
            
        end

    8'h7A: begin
            op_PLY <= 1;
            `ADDR = `SP;
            `SP = inc_sp;
            load_from_address <= 1;
        end

    8'h7C: begin
            op_JMP <= 1;
            
        end

    8'h7D: begin
            op_ADC <= 1;
            
        end

    8'h7E: begin
            op_ROR <= 1;
            
        end

    8'h81: begin
            op_STA <= 1;
            
        end

    8'h84: begin
            op_STY <= 1;
            
        end

    8'h85: begin
            op_STA <= 1;
            
        end

    8'h86: begin
            op_STX <= 1;
            
        end

    8'h87, 8'h97, 8'hA7, 8'hB7,
    8'hC7, 8'hD7, 8'hE7, 8'hF7:
        begin
            op_SMB <= 1;
            
           
        end

    8'h88: begin
            // DEY
            `Y <= dec_y;
            `N <= dec_y_n;
            `Z <= dec_y_z;
            `END_INSTR;
        end

    8'h89: begin
            op_BIT <= 1;
            
        end

    8'h8A: begin
            // TXA
            `A <= `X;
            `END_INSTR;
        end

    8'h8C: begin
            op_STY <= 1;
            
        end

    8'h8D: begin
            op_STA <= 1;
            
        end

    8'h8E: begin
            op_STX <= 1;
            
        end

    8'h8F, 8'h9F, 8'hAF, 8'hBF,
    8'hCF, 8'hDF, 8'hEF, 8'hFF:
        begin
            op_BBS <= 1;
            
           
        end

    8'h90: begin
            if (`NC) begin // BCC
                
                
            end else begin
                `PC <= add_pc_2;
                `END_INSTR;
            end
        end

    8'h91: begin
            op_STA <= 1;
            
        end

    8'h92: begin
            op_STA <= 1;
            
        end

    8'h94: begin
            op_STY <= 1;
            
        end

    8'h95: begin
            op_STA <= 1;
            
        end

    8'h96: begin
            op_STX <= 1;
            
        end

    8'h98: begin
            // TYA
            `A <= `Y;
            `END_INSTR;
        end

    8'h99: begin
            op_STA <= 1;
            
        end

    8'h9A: begin
            // TXS
            `SP <= `X;
            `END_INSTR;
        end

    8'h9C: begin
            op_STZ <= 1;
            
        end

    8'h9D: begin
            op_STA <= 1;
            
        end

    8'h9E: begin
            op_STZ <= 1;
            
        end

    8'hA0: begin
            op_LDY <= 1;
            
        end

    8'hA1: begin
            op_LDA <= 1;
            
        end

    8'hA2: begin
            op_LDX <= 1;
            
        end

    8'hA4: begin
            op_LDY <= 1;
            
        end

    8'hA5: begin
            op_LDA <= 1;
            
        end

    8'hA6: begin
            op_LDX <= 1;
            
        end

    8'hA8: begin
            // TAY
            `Y <= `A;
            `END_INSTR;
        end

    8'hA9: begin
            op_LDA <= 1;
            
        end

    8'hAA: begin
            // TAX
            `X <= `A;
            `END_INSTR;
        end

    8'hAC: begin
            op_LDY <= 1;
            
        end

    8'hAD: begin
            op_LDA <= 1;
            
        end

    8'hAE: begin
            op_LDX <= 1;
            
        end

    8'hB0: begin
            if (`C) begin // BCS
                
                
            end else begin
                `PC <= add_pc_2;
                `END_INSTR;
            end
        end

    8'hB1: begin
            op_LDA <= 1;
            
        end

    8'hB2: begin
            op_LDA <= 1;
            
        end

    8'hB4: begin
            op_LDY <= 1;
            
        end

    8'hB5: begin
            op_LDA <= 1;
            
        end

    8'hB6: begin
            op_LDX <= 1;
            
        end

    8'hB8: begin
            `V <= 0; // CLV
            `END_INSTR;
        end

    8'hB9: begin
            op_LDA <= 1;
            
        end

    8'hBA: begin
            // TSX
            `X <= `SP;
            `END_INSTR;
        end

    8'hBC: begin
            op_LDY <= 1;
            
        end

    8'hBD: begin
            op_LDA <= 1;
            
        end

    8'hBE: begin
            op_LDX <= 1;
            
        end

    8'hC0: begin
            op_CPY <= 1;
            
        end

    8'hC1: begin
            op_CMP <= 1;
            
        end

    8'hC4: begin
            op_CPY <= 1;
            
        end

    8'hC5: begin
            op_CMP <= 1;
            
        end

    8'hC6: begin
            op_DEC <= 1;
            
        end

    8'hC8: begin
            // INY
            `Y <= inc_y;
            `N <= inc_y_n;
            `Z <= inc_y_z;
            `END_INSTR;
        end

    8'hC9: begin
            op_CMP <= 1;
            
        end

    8'hCA: begin
            // DEX
            `X <= dec_x;
            `N <= dec_x_n;
            `Z <= dec_x_z;
            `END_INSTR;
        end

    8'hCB: begin
            op_WAI <= 1;
        end

    8'hCC: begin
            op_CPY <= 1;
            
        end

    8'hCD: begin
            op_CMP <= 1;
            
        end

    8'hCE: begin
            op_DEC <= 1;
            
        end

    8'hD0: begin
            if (`NZ) begin // BNE
                
                
            end else begin
                `PC <= add_pc_2;
                `END_INSTR;
            end
        end

    8'hD1: begin
            op_CMP <= 1;
            
        end

    8'hD2: begin
            op_CMP <= 1;
            
        end

    8'hD5: begin
            op_CMP <= 1;
            
        end

    8'hD6: begin
            op_DEC <= 1;
            
        end

    8'hD8: begin
            `D <= 0; // CLD
            `END_INSTR;
        end

    8'hD9: begin
            op_CMP <= 1;
            
        end

    8'hDA: begin
            // PHX
            var_hw_address = dec_sp;
            `SP <= var_hw_address;
            `ADDR <= var_hw_address;
            `DST <= `X;
            `STORE_DST;
        end

    8'hDB: begin
            op_STP <= 1;
        end

    8'hDD: begin
            op_CMP <= 1;
            
        end

    8'hDE: begin
            op_DEC <= 1;
            
        end

    8'hE0: begin
            op_CPX <= 1;
            
        end

    8'hE1: begin
            op_SBC <= 1;
            
        end

    8'hE4: begin
            op_CPX <= 1;
            
        end

    8'hE5: begin
            op_SBC <= 1;
            
        end

    8'hE6: begin
            op_INC <= 1;
            
        end

    8'hE8: begin
            // INX
            `X <= inc_x;
            `N <= inc_x_n;
            `Z <= inc_x_z;
            `END_INSTR;
        end

    8'hE9: begin
            op_SBC <= 1;
            
        end

    8'hEA: begin
            // NOP
            `END_INSTR;
        end

    8'hEC: begin
            op_CPX <= 1;
            
        end

    8'hED: begin
            op_SBC <= 1;
            
        end

    8'hEE: begin
            op_INC <= 1;
            
        end

    8'hF0: begin
            if (`Z) begin // BEQ

                
            end else begin
                `PC <= add_pc_2;
                `END_INSTR;
            end
        end

    8'hF1: begin
            op_SBC <= 1;
            
        end

    8'hF2: begin
            op_SBC <= 1;
            
        end

    8'hF5: begin
            op_SBC <= 1;
            
        end

    8'hF6: begin
            op_INC <= 1;
            
        end

    8'hF8: begin
            `D <= 1; // SED
            `END_INSTR;
        end

    8'hF9: begin
            op_SBC <= 1;
            
        end

    8'hFA: begin
            op_PLX <= 1;
            `ADDR = `SP;
            `SP = inc_sp;
            load_from_address <= 1;
        end

    8'hFD: begin
            op_SBC <= 1;
            
        end

    8'hFE: begin
            op_INC <= 1;
            
        end
endcase;
