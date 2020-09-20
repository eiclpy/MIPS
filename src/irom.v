`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2020 10:30:19 PM
// Design Name: 
// Module Name: irom
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module irom(
    input clk,
    input [9:0] Addr,
    output reg [31:0] IR
    );
    reg [31:0] regs[0:1023];
    always @(posedge clk)
        IR=regs[Addr];
    initial
    //$readmemh("testalu.hex",regs,0,18);
    //$readmemh("testmdu.hex",regs,0,20);
    //$readmemh("testmem.hex",regs,0,48);
    $readmemh("fib.hex",regs,0,26);
endmodule
