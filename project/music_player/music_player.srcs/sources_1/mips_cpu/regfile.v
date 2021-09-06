`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/08/26 12:53:25
// Design Name:
// Module Name: regfile
// Project Name:
// Target Devices:
// Tool Versions:
// Description: 实现了 32 个 32 位通用整数寄存器
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module regfile(
         input   wire    clk,
         input   wire    rst,

         // 寄存器写入端口：1个
         input   wire    we_i,
         input   wire[`RegAddrBus]   waddr_i,
         input   wire[`RegBus]       wdata_i,
         // 寄存器读出端口：2个
         input   wire    re1_i,
         input   wire    re2_i,
         input   wire[`RegAddrBus]   raddr1_i,
         input   wire[`RegAddrBus]   raddr2_i,
         output  reg[`RegBus]        rdata1_o,
         output  reg[`RegBus]        rdata2_o
       );

//********  32个寄存器  ********
reg[`RegBus]    regs[`RegNum-1:0];

//********  写寄存器  ********
always @(posedge clk)
  begin
    if (rst == `RstDisable)
      begin
        if ((we_i == `WriteEnable) && (waddr_i != `RegAddrNone))
          begin
            regs[waddr_i] <= wdata_i;
          end
      end
  end

//********  读寄存器 1  ********
always @(*)
  begin
    if (rst == `RstEnable)
      begin
        rdata1_o <= `ZeroWord;
      end
    else if (raddr1_i == `RegAddrNone)
      begin
        rdata1_o <= `ZeroWord;
      end
    else if(raddr1_i == waddr_i && we_i == `WriteEnable && re1_i == `ReadEnable)
      begin
        rdata1_o <= wdata_i;
      end
    else if (re1_i == `ReadEnable)
      begin
        rdata1_o <= regs[raddr1_i];
      end
    else
      begin
        rdata1_o <= `ZeroWord;
      end
  end

//********  读寄存器 2  ********
always @(*)
  begin
    if (rst == `RstEnable)
      begin
        rdata2_o <= `ZeroWord;
      end
    else if (raddr2_i == `RegAddrNone)
      begin
        rdata2_o <= `ZeroWord;
      end
    else if(raddr2_i == waddr_i && we_i == `WriteEnable && re2_i == `ReadEnable)
      begin
        rdata2_o <= wdata_i;
      end
    else if (re2_i == `ReadEnable)
      begin
        rdata2_o <= regs[raddr2_i];
      end
    else
      begin
        rdata2_o <= `ZeroWord;
      end
  end

endmodule
