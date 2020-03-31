`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2020 10:10:45 PM
// Design Name: 
// Module Name: dram
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


module dram(
    input clk,
    input rst,
    input [1:0] BHW,
    input MemSgn,
    input MemWr,
    input [11:0] Addr,
    input [31:0] WtData,
    output [31:0] MemRD
    );
    reg [31:0] regs[0:1023];
    reg [31:0] out;
    reg [3:0] BE;
    integer i;
    always @(BHW or Addr)
    begin
        case({BHW,Addr[1:0]})
            4'b0000:BE=4'b1000;
            4'b0001:BE=4'b0100;
            4'b0010:BE=4'b0010;
            4'b0011:BE=4'b0001;
            4'b0100:BE=4'b1100;
            4'b0110:BE=4'b0011;
            4'b1100:BE=4'b1111;
            default:BE=4'b0;
        endcase
    end
    always @(posedge clk or negedge rst)
    if(rst)
        for(i=0;i<1024;i=i+1)
            regs[i]=0;
    else if(MemWr)
        case(BE)
            4'b0001:regs[Addr[11:2]][7:0]=WtData[7:0];
            4'b0010:regs[Addr[11:2]][15:8]=WtData[7:0];
            4'b0100:regs[Addr[11:2]][23:16]=WtData[7:0];
            4'b1000:regs[Addr[11:2]][31:24]=WtData[7:0];
            4'b0011:regs[Addr[11:2]][15:0]=WtData[15:0];
            4'b1100:regs[Addr[11:2]][31:16]=WtData[15:0];
            4'b1111:regs[Addr[11:2]]=WtData;
        endcase
    always @(*)
        if(MemSgn)
        case(BE)
            4'b0001:out={24'b0,regs[Addr[11:2]][7:0]};
            4'b0010:out={24'b0,regs[Addr[11:2]][15:8]};
            4'b0100:out={24'b0,regs[Addr[11:2]][23:16]};
            4'b1000:out={24'b0,regs[Addr[11:2]][31:24]};
            4'b0011:out={16'b0,regs[Addr[11:2]][15:0]};
            4'b1100:out={16'b0,regs[Addr[11:2]][31:16]};
            4'b1111:out=regs[Addr[11:2]];
        endcase
        else
        case(BE)
            4'b0001:out={regs[Addr[11:2]][7]==0?24'b0:24'hffffff,regs[Addr[11:2]][7:0]};
            4'b0010:out={regs[Addr[11:2]][15]==0?24'b0:24'hffffff,regs[Addr[11:2]][15:8]};
            4'b0100:out={regs[Addr[11:2]][23]==0?24'b0:24'hffffff,regs[Addr[11:2]][23:16]};
            4'b1000:out={regs[Addr[11:2]][31]==0?24'b0:24'hffffff,regs[Addr[11:2]][31:24]};
            4'b0011:out={regs[Addr[11:2]][15]==0?16'b0:16'hffff,regs[Addr[11:2]][15:0]};
            4'b1100:out={regs[Addr[11:2]][31]==0?16'b0:16'hffff,regs[Addr[11:2]][31:16]};
            4'b1111:out=regs[Addr[11:2]];
        endcase
    assign MemRD=out;
endmodule
