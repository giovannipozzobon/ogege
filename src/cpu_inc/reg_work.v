`define EADDR   reg_address`VW
`define EADDR0  reg_address[7:0]
`define EADDR1  reg_address[15:8]
`define EADDR2  reg_address[23:16]
`define EADDR3  reg_address[31:24]

`define EIADDR   reg_ind_address`VW
`define EIADDR0  reg_ind_address[7:0]
`define EIADDR1  reg_ind_address[15:8]
`define EIADDR2  reg_ind_address[23:16]
`define EIADDR3  reg_ind_address[31:24]

// Processing registers
reg [3:0] reg_cycle;
reg reg_6502;
reg reg_65832;
reg [2:0] reg_which;
reg `VW reg_address;
reg `VW reg_ind_address;
reg `VW reg_src_data;
reg `VW reg_dst_data;
reg `VB reg_code_byte;
reg `VB reg_data_byte;
reg `VW reg_code_word;
reg `VW reg_data_word;
reg `VW reg_offset;
reg load_from_address; // Load from or use the computed address
reg store_to_address; // Store computed value at address
reg transfer_in_progress; // Load/store in progress


`LOGIC_8 var_code_byte;
`LOGIC_8 var_new_val;
`LOGIC_16 var_hw_address;
`LOGIC_32 var_w_address;

reg am_ABS_a;       // Absolute a (6502)
reg am_ACC_A;       // Accumulator A (6502)
reg am_AIA_A;       // Absolute Indirect (a) (6502)
reg am_AIIX_A_X;    // Absolute Indexed Indirect with X (a,x) (6502)
reg am_AIX_a_x;     // Absolute Indexed with X a,x (6502)
reg am_AIY_a_y;     // Absolute Indexed with Y a,y (6502)
reg am_IMM_m;       // Immediate Addressing # (6502)
reg am_PCR_r;       // Program Counter Relative r (6502)
reg am_STK_s;       // Stack s (6502)
reg am_ZIIX_ZP_X;   // Zero Page Indexed Indirect (zp,x) (6502)
reg am_ZIIY_ZP_y;   // Zero Page Indirect Indexed with Y (zp),y (6502)
reg am_ZIX_zp_x;    // Zero Page Indexed with X zp,x (6502)
reg am_ZIY_zp_y;    // Zero Page Indexed with Y zp,y (6502)
reg am_ZPG_zp;      // Zero Page zp (6502)
reg am_ZPI_ZP;      // Zero Page Indirect (zp) (6502)

reg ame_ABS_a;      // Absolute a (65832)
reg ame_ACC_A;      // Accumulator A (65832)
reg ame_AIA_A;      // Absolute Indirect (a) (65832)
reg ame_AIIX_A_X;   // Absolute Indexed Indirect with X (a,x) (65832)
reg ame_AIIY_A_y;   // Absolute Indexed Indirect with Y (a),y (65832)
reg ame_AIX_a_x;    // Absolute Indexed with X a,x (65832)
reg ame_AIY_a_y;    // Absolute Indexed with Y a,y (65832)
reg ame_IMM_m;      // Immediate Addressing # (65832)
reg ame_PCR_r;      // Program Counter Relative r (65832)
reg ame_STK_s;      // Stack s (65832)

reg op_ADC;
reg op_ADD;
reg op_AND;
reg op_ASL;
reg op_BBR;
reg op_BRANCH;
reg op_BBS;
reg op_BIT;
reg op_BRK;
reg op_CMP;
reg op_CPX;
reg op_CPY;
reg op_DEC;
reg op_EOR;
reg op_INC;
reg op_JMP;
reg op_JSR;
reg op_LDA;
reg op_LDX;
reg op_LDY;
reg op_LSR;
reg op_ORA;
reg op_PHA;
reg op_PHP;
reg op_PHX;
reg op_PHY;
reg op_PLA;
reg op_PLP;
reg op_PLX;
reg op_PLY;
reg op_RMB;
reg op_ROL;
reg op_ROR;
reg op_RTI;
reg op_RTS;
reg op_SBC;
reg op_SMB;
reg op_STA;
reg op_STP;
reg op_STX;
reg op_STX;
reg op_STY;
reg op_STY;
reg op_STZ;
reg op_STZ;
reg op_SUB;
reg op_TRB;
reg op_TSB;
reg op_WAI;

`define OFFSET   reg_offset

`define SRC reg_src_data`VB
`define eSRC reg_src_data`VW
`define eSRC0 reg_src_data[7:0]
`define eSRC1 reg_src_data[15:8]
`define eSRC2 reg_src_data[23:16]
`define eSRC3 reg_src_data[31:24]

`define DST reg_dst_data`VB
`define eDST reg_dst_data`VW
`define eDST0 reg_dst_data[7:0]
`define eDST1 reg_dst_data[15:8]
`define eDST2 reg_dst_data[23:16]
`define eDST3 reg_dst_data[31:24]
