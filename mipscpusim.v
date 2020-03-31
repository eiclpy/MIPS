`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 10:11:46 PM
// Design Name: 
// Module Name: mipscpusim
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


module mipscpusim(

    );
    
   reg clk,reset;
   mipscpu cpu(clk,reset);
   parameter PERIOD = 10;
   always begin
      clk = 1'b0;
      #(PERIOD/2) clk = 1'b1;
      #(PERIOD/2);
   end
   initial
   begin
   reset=1;
   #20
   reset=0;
   end
endmodule
