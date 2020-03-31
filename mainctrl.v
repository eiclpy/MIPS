`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 06:05:23 PM
// Design Name: 
// Module Name: mainctrl
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


module mainctrl(
    input [5:0] Op,
    input [5:0] Func,
    output [1:0] BHW,
    output MemSgn,
    output [3:0] ALUCtrl,
    output [2:0] MDUCtrl,
    output JR,
    output Sgn,
    output Ne,
    output [1:0] RegDst,
    output ALUSrc,
    output [1:0] Mem2Reg,
    output RegWr,
    output MemWr,
    output B,
    output J
    );

    reg [21:0] out;
    assign BHW=out[21:20];
    assign MemSgn=out[19];
    assign MDUCtrl=out[18:16];

    assign JR=out[15];
    assign Sgn=out[14];
    assign Ne=out[13];

    assign RegDst=out[12:11];
    assign ALUSrc=out[10];
    assign Mem2Reg=out[9:8];
    assign RegWr=out[7];
    assign MemWr=out[6];
    assign B=out[5];
    assign J=out[4];
    assign ALUCtrl=out[3:0];
    always @(Op or Func)
        casex ({Op,Func})
            12'b000000_000000:out=22'bxxx_1x0_xxx_010001000_1000;//sll
            12'b000000_000010:out=22'bxxx_1x0_xxx_010001000_1001;//srl
            12'b000000_000100:out=22'bxxx_1x0_xxx_010001000_1010;//sllv
            12'b000000_000110:out=22'bxxx_1x0_xxx_010001000_1011;//srlv
            12'b000000_001000:out=22'bxxx_1x0_1xx_xxxxx00x1_xxxx;//jr
            12'b000000_010000:out=22'bxxx_100_xxx_01x101000_xxxx;//mfhi
            12'b000000_010001:out=22'bxxx_101_xxx_xxxxx0000_xxxx;//mthi
            12'b000000_010010:out=22'bxxx_110_xxx_01x101000_xxxx;//mflo
            12'b000000_010011:out=22'bxxx_111_xxx_xxxxx0000_xxxx;//mtlo
            12'b000000_011000:out=22'bxxx_000_xxx_xx0xx0000_xxxx;//mult
            12'b000000_011001:out=22'bxxx_001_xxx_xx0xx0000_xxxx;//multu
            12'b000000_011010:out=22'bxxx_010_xxx_xx0xx0000_xxxx;//div
            12'b000000_011011:out=22'bxxx_011_xxx_xx0xx0000_xxxx;//divu
            12'b000000_100000:out=22'bxxx_1x0_xxx_010001000_0010;//add
            12'b000000_100001:out=22'bxxx_1x0_xxx_010001000_0011;//addu
            12'b000000_10001x:out=22'bxxx_1x0_xxx_010001000_0100;//sub
            12'b000000_10001x:out=22'bxxx_1x0_xxx_010001000_0101;//subu
            12'b000000_100100:out=22'bxxx_1x0_xxx_010001000_0000;//and
            12'b000000_100101:out=22'bxxx_1x0_xxx_010001000_0001;//or
            12'b000000_100110:out=22'bxxx_1x0_xxx_010001000_1110;//xor
            12'b000000_100111:out=22'bxxx_1x0_xxx_010001000_1111;//nor
            12'b000000_101010:out=22'bxxx_1x0_xxx_010001000_0110;//slt
            12'b000000_101011:out=22'bxxx_1x0_xxx_010001000_0111;//sltu
            12'b000010_xxxxxx:out=22'bxxx_1x0_0xx_xxxxx00x1_xxxx;//j
            12'b000011_xxxxxx:out=22'bxxx_1x0_0xx_1101110x1_0001;//jal regdst=11 $31
            12'b000100_xxxxxx:out=22'bxxx_1x0_xx0_xx0xx0010_0110;//beq
            12'b000101_xxxxxx:out=22'bxxx_1x0_xx1_xx0xx0010_0110;//bne
            12'b001000_xxxxxx:out=22'bxxx_1x0_x1x_001001000_0010;//addi
            12'b001001_xxxxxx:out=22'bxxx_1x0_x0x_001001000_0010;//addiu
            12'b001010_xxxxxx:out=22'bxxx_1x0_x1x_001001000_0111;//slti
            12'b001011_xxxxxx:out=22'bxxx_1x0_x0x_001001000_0111;//sltiu
            12'b001100_xxxxxx:out=22'bxxx_1x0_x0x_001001000_0000;//andi
            12'b001101_xxxxxx:out=22'bxxx_1x0_x0x_001001000_0001;//ori
            12'b001110_xxxxxx:out=22'bxxx_1x0_x0x_001001000_0001;//xori
            12'b001111_xxxxxx:out=22'bxxx_1x0_x0x_001001000_1100;//lui
            12'b100000_xxxxxx:out=22'b001_1x0_x1x_001011000_0010;//lb
            12'b100001_xxxxxx:out=22'b011_1x0_x1x_001011000_0010;//lh
            12'b100011_xxxxxx:out=22'b111_1x0_x1x_001011000_0010;//lw
            12'b100100_xxxxxx:out=22'b000_1x0_x1x_001011000_0010;//lbu
            12'b100101_xxxxxx:out=22'b010_1x0_x1x_001011000_0010;//lhu
            12'b101000_xxxxxx:out=22'b00x_1x0_x1x_xx1xx0100_0010;//sb
            12'b101001_xxxxxx:out=22'b01x_1x0_x1x_xx1xx0100_0010;//sh
            12'b101011_xxxxxx:out=22'b11x_1x0_x1x_xx1xx0100_0010;//sw
            default:          out=22'bxxx_1x0_xxx_xxxxx0000_0000;
        endcase
    
endmodule
