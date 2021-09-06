`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 08/25/2021 12:55:56 PM
// Design Name:
// Module Name: pc
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


module pc(
         input   wire    clk,
         input   wire    rst,

         input   wire    branch_flag_i,              // 是否发生分支转移
         input   wire[`RegBus]   branch_target_i,    // 分支转移地址

         input wire[5:0] stop_i,

         output  reg[`InstAddrBus]   pc_reg,    // 输出指令地址
         output  reg     ce                     // 指令存储器使能信号
       );

// 根据 rst 控制 inst_rom 使能
always @(posedge clk)
  begin
    if (rst == `RstEnable)
      begin
        ce <= `ChipDisable;
      end
    else
      begin
        ce <= `ChipEnable;
      end
  end

// 根据 inst_rom 的使能信号，判断是都进行 pc += 4
always @(posedge clk)
  begin
    if (ce == `ChipDisable)
      begin
        pc_reg <= `ZeroWord;
      end
    else if (stop_i[0] == 1'b1)
      begin

      end
    else if (branch_flag_i == `True)
      begin
        pc_reg <= branch_target_i;
      end
    else
      begin
        pc_reg <= pc_reg + 4'h4;
      end
  end

endmodule
