// Reset initialization

reg_6502 <= 1;
`PC <= `RESET_PC_ADDRESS + 2;
`SP <= `RESET_SP_ADDRESS;
`P <= `RESET_STATUS_BITS;
`X <= `ZERO_8;
`Y <= `ZERO_8;
`A <= `ZERO_8;

reg_65832 <= 0;
`ePC <= `ZERO_32;
`eSP <= `ZERO_32;
`eP <= `RESET_STATUS_BITS;
`eX <= `ZERO_32;
`eY <= `ZERO_32;

transfer_in_progress <= 0;

op_ADC <= 0;
op_ADD <= 0;
op_AND <= 0;
op_ASL <= 0;
op_BBR <= 0;
op_BRANCH <= 0;
op_BBS <= 0;
op_BIT <= 0;
op_BRK <= 0;
op_CMP <= 0;
op_CPX <= 0;
op_CPY <= 0;
op_DEC <= 0;
op_EOR <= 0;
op_INC <= 0;
op_JMP <= 1; // Force JMP via Reset vector
op_JSR <= 0;
op_LDA <= 0;
op_LDX <= 0;
op_LDY <= 0;
op_LSR <= 0;
op_ORA <= 0;
op_PHA <= 0;
op_PHP <= 0;
op_PHX <= 0;
op_PHY <= 0;
op_PLA <= 0;
op_PLP <= 0;
op_PLX <= 0;
op_PLY <= 0;
op_RMB <= 0;
op_ROL <= 0;
op_ROR <= 0;
op_RTI <= 0;
op_RTS <= 0;
op_SBC <= 0;
op_SMB <= 0;
op_STA <= 0;
op_STP <= 0;
op_STX <= 0;
op_STY <= 0;
op_STZ <= 0;
op_SUB <= 0;
op_TRB <= 0;
op_TSB <= 0;
op_WAI <= 0;
