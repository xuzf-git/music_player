`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/08/26 15:08:31
// Design Name:
// Module Name: id_ex
// Project Name:
// Target Devices:
// Tool Versions:
// Description: 将译码阶段取得的运算类型、源操作数、目标寄存器地址，在下一个时钟周期传递到执行阶段
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module id_ex(
         input   wire    clk,
         input   wire    rst,

         input   wire[`AluSelBus]    id_alu_sel_i,
         input   wire[`RegBus]       id_alu_opnd1_i,
         input   wire[`RegBus]       id_alu_opnd2_i,
         input   wire[`RegAddrBus]   id_reg_waddr_i,
         input   wire                id_reg_we_i,
         input   wire[`RegBus]       id_inst_i,
         input   wire[5:0]           stop_i,


         output  reg[`AluSelBus]     ex_alu_sel_o,
         output  reg[`RegBus]        ex_alu_opnd1_o,
         output  reg[`RegBus]        ex_alu_opnd2_o,
         output  reg[`RegAddrBus]    ex_reg_waddr_o,
         output  reg                 ex_reg_we_o,
         output  reg[`RegBus]        ex_inst_o
       );

always @(posedge clk)
  begin
    if (rst == `RstEnable)
      begin
        ex_alu_sel_o <= `AluSelNop;
        ex_alu_opnd1_o <= `ZeroWord;
        ex_alu_opnd2_o <= `ZeroWord;
        ex_reg_waddr_o <= `RegAddrNone;
        ex_reg_we_o <= `WriteDisable;
      end
    else if(stop_i[2]==1'b1 && stop_i[3] == 1'b0)
      begin
        ex_alu_sel_o <= `AluSelNop;
        ex_alu_opnd1_o <= `ZeroWord;
        ex_alu_opnd2_o <= `ZeroWord;
        ex_reg_waddr_o <= `RegAddrNone;
        ex_reg_we_o <= `WriteDisable;
      end
    else if(stop_i[2] == 1'b0)
      begin
        ex_alu_sel_o <= id_alu_sel_i;
        ex_alu_opnd1_o <= id_alu_opnd1_i;
        ex_alu_opnd2_o <= id_alu_opnd2_i;
        ex_reg_waddr_o <= id_reg_waddr_i;
        ex_reg_we_o <= id_reg_we_i;
        ex_inst_o <= id_inst_i;
      end
  end
endmodule
