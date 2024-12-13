// 6502 CPU registers

reg `VB reg_a;              // Accumulator
reg `VB reg_x;              // X index
reg `VB reg_y;              // Y index
reg `VHW reg_pc;            // Program counter
reg `VHW reg_sp;            // Stack pointer
reg `VB reg_status;         // Processor status

`define A   reg_a           // Accumulator
`define X   reg_x           // X index
`define Y   reg_y           // Y index
`define PC  reg_pc          // Program counter
`define SP  reg_sp          // Stack pointer

`define P   reg_status      // Processor status
`define N   reg_status[7]   // Negative
`define V   reg_status[6]   // Overflow
`define U   reg_status[5]   // User status/mode
`define B   reg_status[4]   // Interrupt type (1=BRK, 0=IRQB)
`define D   reg_status[3]   // Decimal
`define I   reg_status[2]   // IRQB disable
`define Z   reg_status[1]   // Zero
`define C   reg_status[0]   // Carry

`define NN   ~reg_status[7]   // Not Negative
`define NV   ~reg_status[6]   // Not Overflow
`define NU   ~reg_status[5]   // Not User status/mode
`define NB   ~reg_status[4]   // Not Interrupt type (1=BRK, 0=IRQB)
`define ND   ~reg_status[3]   // Not Decimal
`define NI   ~reg_status[2]   // Not IRQB disable
`define NZ   ~reg_status[1]   // Not Zero
`define NC   ~reg_status[0]   // Not Carry

// Working/Temporary registers

/*
`define RVB     reg_read_val`VB
`define RVHW    reg_read_val`VHW
`define RVW     reg_read_val`VW
`define WVB     reg_write_val`VB
`define WVHW    reg_write_val`VHW
`define WVW     reg_write_val`VW
*/
/*
`define ADDR    reg_address`VHW
`define ADDR0   reg_address[7:0]
`define ADDR1   reg_address[15:8]
`define ADDR2   reg_address[23:16]
`define ADDR3   reg_address[31:24]

`define IADDR   reg_ind_address`VHW
`define IADDR0  reg_ind_address[7:0]
`define IADDR1  reg_ind_address[15:8]
`define IADDR2  reg_ind_address[23:16]
`define IADDR3  reg_ind_address[31:24]
*/