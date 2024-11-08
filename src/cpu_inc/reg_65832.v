// 65832 CPU registers (enhanced/extended)

reg `VW reg_ea;             // Accumulator
reg `VW reg_ex;             // X index
reg `VW reg_ey;             // Y index
reg `VW reg_epc;            // Program counter
reg `VW reg_esp;            // Stack pointer
reg `VB reg_estatus;        // Processor status

`define eA  reg_ea          // Accumulator
`define eX  reg_ex          // X index
`define eY  reg_ey          // Y index
`define ePC reg_epc         // Program counter
`define eSP reg_esp         // Stack pointer

`define eP  reg_estatus     // Processor status
`define eN  reg_estatus[7]  // Negative
`define eV  reg_estatus[6]  // Overflow
`define eU  reg_estatus[5]  // User status/mode
`define eB  reg_estatus[4]  // Interrupt type (1=BRK, 0=IRQB)
`define eD  reg_estatus[3]  // Decimal
`define eI  reg_estatus[2]  // IRQB disable
`define eZ  reg_estatus[1]  // Zero
`define eC  reg_estatus[0]  // Carry

`define eNN ~reg_estatus[7]  // Not Negative
`define eNV ~reg_estatus[6]  // Not Overflow
`define eNU ~reg_estatus[5]  // Not User status/mode
`define eNB ~reg_estatus[4]  // Not Interrupt type (1=BRK, 0=IRQB)
`define eND ~reg_estatus[3]  // Not Decimal
`define eNI ~reg_estatus[2]  // Not IRQB disable
`define eNZ ~reg_estatus[1]  // Not Zero
`define eNC ~reg_estatus[0]  // Not Carry

// Working/Temporary registers

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
