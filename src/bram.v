/*
 * bram.v
 *
 * This module provides a 64KB block RAM space for lower RAM.
 *
 * Copyright (C) 2024 Curtis Whitley
 * License: APACHE
 */

`default_nettype none

module bram_64kb(
        input logic rst,             // reset
        input logic csa,             // chip select A
        //input logic csb,             // chip select B
        input logic wea,             // write enable A
        //input logic web,             // write enable B
        input logic clka,            // clock A
        //input logic clkb,            // clock B
        input logic [7:0] dia,       // data in A
        //input logic [7:0] dib,       // data in B
        input logic [15:0] addra,    // address A
        //input logic [15:0] addrb,    // address B
        output reg [7:0] doa,       // data out A
        //output reg [7:0] dob,       // data out B
        output reg dra             // data ready A
        //output reg drb              // data ready B
    );

    reg [7:0] bram [0:65535];

    initial $readmemh("../ram/ram.bits", bram);

    logic siga; assign siga = rst | ~csa | clka;

    always @(posedge siga) begin
        if (rst) begin
            dra <= 0;
            doa <= 0;
        end else if (~csa) begin
            dra <= 0;
        end else if (wea) begin
            bram[addra] <= dia;
        end else begin
            dra <= 1;
            doa <= bram[addra];
        end
    end
/*
    logic sigb; assign sigb = rst | ~csb | clkb;

    always @(posedge sigb) begin
        if (rst) begin
            drb <= 0;
            dob <= 0;
        end else if (~csb) begin
            drb <= 0;
        end else if (web) begin
            bram[addrb] <= dib;
        end else begin
            drb <= 1;
            dob <= bram[addrb];
        end
    end
*/
endmodule
