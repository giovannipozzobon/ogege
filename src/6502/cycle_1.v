// 6502 cycle 1

case (reg_code_byte)

    8'h0A: begin
            // ASL
            `END_INSTR;
        end

    8'h10: begin
            if (`NN) begin // BPL
                
                
            end else begin
       
                `END_INSTR;
            end
        end

 
    8'h13: begin
            // NEG
            `END_INSTR;
        end

    8'h14: begin
            
           
        end

    8'h18: begin
            `END_INSTR;
        end

      8'h1A: begin
            // INC
            `END_INSTR;
        end           

    8'h20: begin
            op_JSR <= 1;

    8'h21: begin
            

    8'h23: begin
            // NOT
            `END_INSTR;
        end
    8'h26: begin
            op_ROL <= 1;

    8'h28: begin
            op_PLP <= 1;
            
    8'h2A: begin
            // ROL
            `END_INSTR;
        end

    8'h2E: begin
            op_ROL <= 1;

    8'h30: begin
            if (`N) begin // BMI
                
                
            end else begin
                
                `END_INSTR;
            end
        end

    8'h36: begin
            op_ROL <= 1;

    8'h38: begin
            `END_INSTR;
        end

    8'h3A: begin
            // DEC
            `END_INSTR;
        end

    8'h3E: begin
            op_ROL <= 1;

    8'h40: begin
            op_RTI <= 1;

     8'h46: begin
            op_LSR <= 1;

    8'h4A: begin
            // LSR
            `END_INSTR;
        end

    8'h4C: begin
            op_JMP <= 1;

    8'h4E: begin
            op_LSR <= 1;

    8'h50: begin
            if (`NV) begin // BVC
                
                
            end else begin
              
                `END_INSTR;
            end
        end

    8'h56: begin
            op_LSR <= 1;

    8'h58: begin
            `END_INSTR;
        end

    8'h5E: begin
            op_LSR <= 1;

    8'h60: begin
            op_RTS <= 1;
\
    8'h64: begin
            op_STZ <= 1;

     8'h66: begin
            op_ROR <= 1;

    8'h68: begin
            op_PLA <= 1;
            
      8'h6A: begin
            // ROR
            `END_INSTR;
        end

    8'h6C: begin
            op_JMP <= 1;

    8'h6E: begin
            op_ROR <= 1;

    8'h70: begin
            if (`V) begin // BVS
                
                
            end else begin
                
                `END_INSTR;
            end
        end

    8'h74: begin
            op_STZ <= 1;

    8'h76: begin
            op_ROR <= 1;

    8'h78: begin
            `END_INSTR;
        end

     8'h7A: begin
            op_PLY <= 1;
            

    8'h7C: begin
            op_JMP <= 1;

      8'h7E: begin
            op_ROR <= 1;

    8'h81: begin
            op_STA <= 1;

    8'h84: begin
            op_STY <= 1;

    8'h85: begin
            op_STA <= 1;

    8'h86: begin
            op_STX <= 1;

    8'h87, 8'h97, 8'hA7, 8'hB7,
    8'hC7, 8'hD7, 8'hE7, 8'hF7:
        begin
            op_SMB <= 1;
            
           
        end

    8'h88: begin
            // DEY
            `END_INSTR;
        end

    8'h8A: begin
            // TXA
            `A <= `X;
            `END_INSTR;
        end

    8'h8C: begin
            op_STY <= 1;

    8'h8D: begin
            op_STA <= 1;

    8'h8E: begin
            op_STX <= 1;

    8'h90: begin
            if (`NC) begin // BCC
                
                
            end else begin
                
                `END_INSTR;
            end
        end

    8'h91: begin
            op_STA <= 1;

    8'h92: begin
            op_STA <= 1;

    8'h94: begin
            op_STY <= 1;

    8'h95: begin
            op_STA <= 1;

    8'h96: begin
            op_STX <= 1;

    8'h98: begin
            // TYA
            `A <= `Y;
            `END_INSTR;
        end

    8'h99: begin
            op_STA <= 1;

    8'h9A: begin
            `END_INSTR;
        end

    8'h9C: begin
            op_STZ <= 1;

    8'h9D: begin
            op_STA <= 1;

    8'h9E: begin
            op_STZ <= 1;

    8'hA0: begin
            op_LDY <= 1;

    8'hA1: begin
            op_LDA <= 1;

    8'hA2: begin
            op_LDX <= 1;

    8'hA4: begin
            op_LDY <= 1;

    8'hA5: begin
            op_LDA <= 1;

    8'hA6: begin
            op_LDX <= 1;

    8'hA8: begin
            // TAY
            `Y <= `A;
            `END_INSTR;
        end

    8'hA9: begin
            op_LDA <= 1;

    8'hAA: begin
            // TAX
            `X <= `A;
            `END_INSTR;
        end

    8'hAC: begin
            op_LDY <= 1;

    8'hAD: begin
            op_LDA <= 1;

    8'hAE: begin
            op_LDX <= 1;

    8'hB0: begin
            if (`C) begin // BCS
                
                
            end else begin
                
                `END_INSTR;
            end
        end

    8'hB1: begin
            op_LDA <= 1;

    8'hB2: begin
            op_LDA <= 1;

    8'hB4: begin
            op_LDY <= 1;

    8'hB5: begin
            op_LDA <= 1;

    8'hB6: begin
            op_LDX <= 1;

    8'hB8: begin
            `V <= 0; // CLV
            `END_INSTR;
        end

    8'hB9: begin
            op_LDA <= 1;

    8'hBA: begin
            // TSX
            `X <= `SP;
            `END_INSTR;
        end

    8'hBC: begin
            op_LDY <= 1;

    8'hBD: begin
            op_LDA <= 1;

    8'hBE: begin
            op_LDX <= 1;          

    8'hC8: begin
            // INY
            `END_INSTR;
        end

    8'hCA: begin
            // DEX
            `END_INSTR;
        end

    8'hCB: begin
            op_WAI <= 1;
        end

    8'hD0: begin
            if (`NZ) begin // BNE
                
                
            end else begin
                
                `END_INSTR;
            end
        end

    8'hD8: begin
            `END_INSTR;
        end

    8'hDB: begin
            op_STP <= 1;
        end

      8'hE1: begin
            op_SBC <= 1;

    8'hE5: begin
            op_SBC <= 1;

    8'hE6: begin
            op_INC <= 1;

    8'hE8: begin
            // INX
            `END_INSTR;
        end

    8'hE9: begin
            op_SBC <= 1;

    8'hEA: begin
            // NOP
            `END_INSTR;
        end

    8'hED: begin
            op_SBC <= 1;

    8'hEE: begin
            op_INC <= 1;

    8'hF0: begin
            if (`Z) begin // BEQ

                
            end else begin
                
                `END_INSTR;
            end
        end

    8'hF1: begin
            op_SBC <= 1;

    8'hF2: begin
            op_SBC <= 1;

    8'hF5: begin
            op_SBC <= 1;

    8'hF6: begin
            op_INC <= 1;

    8'hF8: begin
            `D <= 1; // SED
            `END_INSTR;
        end

    8'hF9: begin
            op_SBC <= 1;

    8'hFA: begin
            op_PLX <= 1;
            
            

    8'hFD: begin
            op_SBC <= 1;

    8'hFE: begin
            op_INC <= 1;
endcase;
