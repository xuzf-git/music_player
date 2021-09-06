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
// Description: ʵ���� 32 �� 32 λͨ�������Ĵ���
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

         // �Ĵ���д��˿ڣ�1��
         input   wire    we_i,
         input   wire[`RegAddrBus]   waddr_i,
         input   wire[`RegBus]       wdata_i,
         // �Ĵ��������˿ڣ�2��
         input   wire    re1_i,
         input   wire    re2_i,
         input   wire[`RegAddrBus]   raddr1_i,
         input   wire[`RegAddrBus]   raddr2_i,
         output  reg[`RegBus]        rdata1_o,
         output  reg[`RegBus]        rdata2_o
       );

//********  32���Ĵ���  ********
reg[`RegBus]    regs[`RegNum-1:0];

//********  д�Ĵ���  ********
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

//********  ���Ĵ��� 1  ********
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

//********  ���Ĵ��� 2  ********
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
