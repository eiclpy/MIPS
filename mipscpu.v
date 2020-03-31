`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2020 09:26:43 PM
// Design Name: 
// Module Name: mipscpu
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


module mipscpu(
    input clk,
    input rst
    );
    wire [31:0] TempPC,MuxPC,JumpPC,JumpPCNR,BranchPC,SquencePC,Imm32,Imm32S,Imm32U,ImmL2,RegWD,RsData,RtData,ALUIn2,ALURes,MDURes,MemRD,Instr;
    wire [4:0] RegWA;
    wire [27:0] PsudeoPC;
    wire BranchZ,J,B,Zero,Overflow,RegWr,ALUSrc,MemWr,JR,Sgn,Ne,MemSgn;
    wire [3:0] ALUCtrl;
    wire [2:0] MDUCtrl;
    wire [1:0] RegDst,Mem2Reg,BHW;
    reg [31:0] PC,PClst;
    assign PsudeoPC={Instr[25:0],2'b00};
    assign JumpPCNR={SquencePC[31:28],PsudeoPC};
    assign JumpPC=JR?RsData:JumpPCNR;
    assign SquencePC=PC+4;
    assign BranchPC=ImmL2+SquencePC;
    assign MuxPC=BranchZ?BranchPC:SquencePC;
    assign TempPC=J?JumpPC:MuxPC;
    assign BranchZ=B&(Zero^Ne);
    assign ImmL2={Imm32[29:0],2'b00};
    assign Imm32S={Instr[15]?16'hffff:16'h0,Instr[15:0]};
    assign Imm32U={16'h0,Instr[15:0]};
    assign Imm32=Sgn?Imm32S:Imm32U;
    assign ALUIn2=ALUSrc?Imm32:RtData;
    assign RegWA=RegDst[1]?(RegDst[0]?31:31):(RegDst[0]?Instr[15:11]:Instr[20:16]);
    assign RegWD=Mem2Reg[1]?(Mem2Reg[0]?PClst+4:MDURes):(Mem2Reg[0]?MemRD:ALURes);
    
    alu UnitALU(clk,ALUCtrl,RsData,ALUIn2,Instr[10:6],ALURes,Zero,Overflow);
    mdu UnitMDU(clk,MDUCtrl,RsData,ALUIn2,MDURes);
    dram UnitDram(~clk,rst,BHW,MemSgn,MemWr,ALURes[11:0],RtData,MemRD);
    irom UnitIrom(~clk,PC[11:2],Instr);
    regfile UnitRegFile(~clk,rst,Instr[25:21],Instr[20:16],RegWA,RegWr,RegWD,RsData,RtData);
    mainctrl UnitMainCtr(Instr[31:26],Instr[5:0],BHW,MemSgn,ALUCtrl,MDUCtrl,JR,Sgn,Ne,RegDst,ALUSrc,Mem2Reg,RegWr,MemWr,B,J);
    always @(posedge clk)
    begin
        if(rst)
        begin
            PC<=0;
            PClst<=0;
        end
        else
        begin
            PClst<=PC;
            PC<=TempPC;
        end
    end
endmodule
