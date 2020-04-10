`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 06:05:23 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input clk,
    input [3:0] ALUCtrl,
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [4:0] Shmat,
    output [31:0] ALURes,
    output Zero,
    output Overflow
    );
    wire signed [31:0] SrcASgn, SrcBSgn;
    reg [32:0] Result;

    assign SrcASgn = SrcA;
    assign SrcBSgn = SrcB;
    always @(posedge clk)
    begin
        case(ALUCtrl)
            4'b0000://and
                Result = SrcA&SrcB;
            4'b0001://or
                Result = SrcA|SrcB;
            4'b0010://add
                Result = SrcASgn+SrcBSgn;
            4'b0011://addu
                Result = SrcA+SrcB;
            4'b0100://sub
                Result = SrcASgn-SrcBSgn;
            4'b0101://subu
                Result = SrcA-SrcB;
            4'b0110://slt
                Result = (SrcASgn<SrcBSgn)?1:0;
            4'b0111://sltu
                Result = (SrcA<SrcB)?1:0;
            4'b1000://sll
                Result = SrcB<<Shmat;
            4'b1001://srl
                Result = SrcB>>Shmat;
            4'b1010://sllv
                Result = SrcB<<SrcA;
            4'b1011://srlv
                Result = SrcB>>SrcA;
            4'b1100://lui
                Result = {SrcB[15:0], 16'b0};
            4'b1110://xor
                Result = SrcA^SrcB;
            4'b1111://nor
                Result = ~(SrcA|SrcB);
            default:
                Result = 0;
        endcase
    end
    assign ALURes = Result[31:0];
    assign Zero = Result==0?1:0;
    assign Overflow = Result[32];
endmodule
