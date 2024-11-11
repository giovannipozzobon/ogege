// 6502 cycle 0

// Fetch instruction
reg_code_byte <= bram[`PC];
`PC <= inc_pc;
