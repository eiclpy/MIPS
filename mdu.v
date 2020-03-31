`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2020 10:18:51 AM
// Design Name: 
// Module Name: mdu
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


module mdu(
    input clk,
    input [2:0] MDUCtrl,
    input [31:0] SrcA,
    input [31:0] SrcB,
    output [31:0] MDURes
    );
    wire signed [31:0] SrcASgn,SrcBSgn;
    reg [63:0] Resault;
    assign SrcASgn=SrcA;
    assign SrcBSgn=SrcB;
    always @(posedge clk)
        case(MDUCtrl)
            3'b000:Resault=SrcASgn*SrcBSgn;//mult
            3'b001:Resault=SrcA*SrcB;//multu
            3'b010:Resault=SrcASgn/SrcBSgn;//div
            3'b011:Resault=SrcA/SrcB;//divu
            // 3'b100:MDURes=Resault[63:32];//mfhi
            3'b101:Resault[63:32]=SrcA;//mthi
            // 3'b110:MDURes=Resault[31:0];//mflo
            3'b111:Resault[31:0]=SrcA;//mtlo
        endcase
    assign MDURes=MDUCtrl[1]?Resault[31:0]:Resault[63:32];
endmodule
