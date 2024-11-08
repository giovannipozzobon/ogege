`define BRK_IRQ_ADDRESS             16'hFFFE // Break/IRQ interrupt handler
`define RESET_PC_ADDRESS            16'hFFFC // Initial program counter
`define NMI_ADDRESS                 16'hFFFA // Non-maskable interrupt handler
`define RESET_SP_ADDRESS            16'h0100 // Initial stack pointer
`define RESET_STATUS_BITS           8'b00110100 // initial program status flags

`define ZERO_7 7'd0
`define ZERO_8 8'd0
`define ZERO_9 9'd0
`define ZERO_16 16'd0
`define ZERO_17 17'd0
`define ZERO_24 24'd0
`define ZERO_25 25'd0
`define ZERO_31 24'd0
`define ZERO_32 24'd0
`define ZERO_33 24'd0

`define ONE_8 8'd1
`define ONE_9 9'd1
`define ONE_16 16'd1
`define ONE_32 32'd1
`define ONE_33 33'd1

`define ONES_8 8'hFF
`define ONES_9 9'h1FF
`define ONES_24 24'hFFFFFF
`define ONES_25 25'h1FFFFFF
`define ONES_32 32'hFFFFFFFF
`define ONES_33 33'h1FFFFFFFF

`define TWO_16 16'd2;

`define FOUR_32 32'd4;

`define LOGIC_8     logic [7:0]
`define LOGIC_9     logic [8:0]
