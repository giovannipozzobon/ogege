// 65832 cycle 4

if (op_BRANCH) begin
    `ePC <= add_epc_src_24;
    op_BRANCH <= 0;
    `END_INSTR;
end
