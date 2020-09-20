`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 06:05:23 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk,
    input rst,
    input [4:0] Rs,
    input [4:0] Rt,
    input [4:0] Rd,
    input WE,
    input [31:0] WD,
    output [31:0] RsData,
    output [31:0] RtData
    );

    reg [31:0] regs[0:31];
    integer i;

    assign RsData = regs[Rs];
    assign RtData = regs[Rt];

    always @(posedge clk or posedge rst)
    begin
        if(rst)
            for(i=0; i<32; i=i+1)
                regs[i] = 0;
        else
            if(WE)
                regs[Rd] = WD;
    end
endmodule
