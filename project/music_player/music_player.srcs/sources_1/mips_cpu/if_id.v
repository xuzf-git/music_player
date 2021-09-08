`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 08/25/2021 01:01:00 PM
// Design Name:
// Module Name: if_id
// Project Name:
// Target Devices:
// Tool Versions:
// Description: IF/ID 模块保存取指阶段得出的指令，并在下一个时钟传递到译码阶段；
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module if_id(
         input   wire    clk,
         input   wire    rst,

         // 来自取指阶段的信号
         input   wire[`InstAddrBus]  if_pc_i,
         input   wire[`InstBus]  if_inst_i,
         input   wire branch_flag_i,
         input wire uart_finish_i,
         input wire is_play_end_i,

         input wire[5:0] stop_i,

         output reg uart_finish_o,
         output reg is_play_end_o,

         // 将指令输出到译码阶段
         output  reg[`InstAddrBus]   id_pc_o,
         output  reg[`InstBus]   id_inst_o
       );

reg uart_finish_reg = 0;
reg is_play_end_reg = 0;

always @(posedge clk)
  begin
    if(uart_finish_reg == 1'b0 && uart_finish_i == 1'b1)
      begin
        uart_finish_reg = 1'b1;
      end
    if(is_play_end_reg == 1'b0 && is_play_end_i == 1'b1)
      begin
        is_play_end_reg = 1'b1;
      end
    uart_finish_o <= uart_finish_i;
    is_play_end_o <= is_play_end_i;
    if (rst == `RstEnable)
      begin
        id_inst_o <= `ZeroWord;
      end
    else if (stop_i[1] == 1'b1 && stop_i[2] == 1'b0 || branch_flag_i == 1'b1)
      begin
        id_inst_o <= `ZeroWord;
      end
    else if (stop_i[1] == 1'b0)
      begin
        if(uart_finish_reg == 1'b1 && if_inst_i == 32'h14000007)
          begin
            uart_finish_o <= 1'b1;
            uart_finish_reg <= 1'b0;
          end
        if(is_play_end_reg == 1'b1 && if_inst_i == 32'h14000005)
          begin
            is_play_end_o <= 1'b1;
            is_play_end_reg <= 1'b0;
          end
        id_inst_o <= if_inst_i;
        id_pc_o <= if_pc_i;
      end
  end

endmodule
