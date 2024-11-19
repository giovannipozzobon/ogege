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
