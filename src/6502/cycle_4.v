// 6502 cycle 4

if (am_ZIIX_ZP_X | am_ZIIY_ZP_y) begin
    `IADDR1 <= i_bus_data;
    `ADDR <= inc_addr;
end else if (op_BBR | op_BBS) begin
    reg_data_byte <= i_bus_data;
end else begin
    if (am_ABS_a) begin
        am_ABS_a <= 0;
        if (op_JMP) begin
            `PC <= `ADDR;
            `END_OPER_INSTR(op_JMP);
        end else if (op_JSR) begin
            `PC <= `ADDR;
            `END_OPER(op_JSR);
            `eDST0 <= `PC[7:0];
            `eDST1 <= `PC[15:8];
            push_edst0 <= 1;
        end else if (op_STA) begin
            `DST <= `A;
            `STORE_AFTER_OP(op_STA);
        end else if (op_STX) begin
            `DST <= `X;
            `STORE_AFTER_OP(op_STX);
        end else if (op_STY) begin
            `DST <= `Y;
            `STORE_AFTER_OP(op_STY);
        end else if (op_STZ) begin
            `DST <= `ZERO_8;
            `STORE_AFTER_OP(op_STZ);
        end else begin
            load_from_address <= 1;
        end
    end else if (am_AIIX_A_X) begin
            `ADDR <= {`ZERO_8, reg_code_byte} + uext_x_16;
    end else if (am_AIA_A) begin
            `ADDR1 <= reg_code_byte;
    end else if (am_AIX_a_x) begin
        `ADDR <= {`ZERO_8, reg_code_byte} + uext_x_16;
        am_AIX_a_x <= 0;
        load_from_address <= 1;
    end else if (am_AIY_a_y) begin
        `ADDR <= {`ZERO_8, reg_code_byte} + uext_y_16;
        am_AIY_a_y <= 0;
        load_from_address <= 1;
    end
end
