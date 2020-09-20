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
    reg [63:0] Result;
    assign SrcASgn=SrcA;
    assign SrcBSgn=SrcB;
    always @(posedge clk)
        case(MDUCtrl)
            3'b000:Result<=SrcASgn*SrcBSgn;//mult
            3'b001:Result<=SrcA*SrcB;//multu
            3'b010:begin
                Result[31:0]<=SrcASgn/SrcBSgn;//div
                Result[63:32]<=SrcASgn%SrcBSgn;
            end
            3'b011:begin
                Result[31:0]<=SrcA/SrcB;//divu
                Result[63:32]<=SrcA%SrcB;
            end
            // 3'b100:MDURes=Result[63:32];//mfhi
            3'b101:Result[63:32]<=SrcA;//mthi
            // 3'b110:MDURes=Result[31:0];//mflo
            3'b111:Result[31:0]<=SrcA;//mtlo
        endcase
    assign MDURes=MDUCtrl[1]?Result[31:0]:Result[63:32];
endmodule
