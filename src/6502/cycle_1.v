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

    8'h23: begin
            // NOT
            `END_INSTR;
        end
            
    8'h2A: begin
            // RO L
            `END_INSTR;
        end

    8'h30: begin
            if (`N) begin // BMI
                
                
            end else begin
                
                `END_INSTR;
            end
        end
    8'h38: begin
            `END_INSTR;
        end

    8'h3A: begin
            // DEC
            `END_INSTR;
        end    

    8'h4A: begin
            // LSR
            `END_INSTR;
        end

    8'h4C: begin
            op_JMP <= 1;
  
    8'h50: begin
            if (`NV) begin // BVC
                
                
            end else begin
              
                `END_INSTR;
            end
        end

    8'h58: begin
            `END_INSTR;
        end
\   8'h6A: begin
            // RO R
            `END_INSTR;
        end

    8'h6C: begin
            op_JMP <= 1;

    8'h70: begin
            if (`V) begin // BVS
                
                
            end else begin
                
                `END_INSTR;
            end
        end

    8'h78: begin
            `END_INSTR;
        end

    8'h7C: begin
            op_JMP <= 1;

    8'h88: begin
            // DEY
            `END_INSTR;
        end

    8'h8A: begin
            // TXA
            `A <= `X;
            `END_INSTR;
        end

    8'h90: begin
            if (`NC) begin // BCC
                
                
            end else begin
                
                `END_INSTR;
            end
        end

    8'h98: begin
            // TYA
            `A <= `Y;
            `END_INSTR;
        end

    8'h9A: begin
            `END_INSTR;
        end


      8'hA8: begin
            // TAY
            `Y <= `A;
            `END_INSTR;
        end

    8'hAA: begin
            // TAX
            `X <= `A;
            `END_INSTR;
        end

    8'hB0: begin
            if (`C) begin // BCS
                
                
            end else begin
                
                `END_INSTR;
            end
        end

    8'hB8: begin
            `V <= 0; // CLV
            `END_INSTR;
        end
    8'hBA: begin
            // TSX
            `X <= `SP;
            `END_INSTR;
        end

    8'hC8: begin
            // INY
            `END_INSTR;
        end

    8'hCA: begin
            // DEX
            `END_INSTR;
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

     8'hE8: begin
            // INX
            `END_INSTR;
        end
    8'hEA: begin
            // NOP
            `END_INSTR;
        end

    8'hF0: begin
            if (`Z) begin // BEQ

                
            end else begin
                
                `END_INSTR;
            end
        end
    8'hF8: begin
            `D <= 1; // SED
            `END_INSTR;
        end

endcase;
