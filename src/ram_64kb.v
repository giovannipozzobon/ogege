/*
 * ram_64kb.v
 *
 * This module provides block RAM space for the lower 64KB of memory.
 * 
 * Copyright (C) 2024 Curtis Whitley
 * License: APACHE
 */

`default_nettype none

module ram_64kb #(
        parameter DATA_WIDTH=8,
        parameter ADDR_WIDTH=16
    )(
        input wire wea,                         // write enable A
        input wire web,                         // write enable B
        input wire clka,                        // clock A
        input wire clkb,                        // clock B
        input wire [DATA_WIDTH-1:0] dia,        // data in A
        input wire [DATA_WIDTH-1:0] dib,        // data in B
        input wire [ADDR_WIDTH-1:0] addra,      // address A
        input wire [ADDR_WIDTH-1:0] addrb,      // address B
        output reg [DATA_WIDTH-1:0] doa,        // data out A
        output reg [DATA_WIDTH-1:0] dob         // data out B
    );

    localparam WORD = (DATA_WIDTH-1);
    localparam DEPTH = (2**ADDR_WIDTH-1);
    reg [WORD:0] ram_memory [0:DEPTH];

    initial $readmemh("../ram/ram.bits", ram_memory);

    always @(posedge clka) begin
        if (wea) begin
            ram_memory[addra] <= dia;
        end else
            doa <= ram_memory[addra];
    end

    always @(posedge clkb) begin
        if (web) begin
            ram_memory[addrb] <= dib;
        end else
            dob <= ram_memory[addrb];
    end
endmodule
