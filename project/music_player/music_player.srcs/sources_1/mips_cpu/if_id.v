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
// Description: IF/ID ģ�鱣��ȡָ�׶εó���ָ�������һ��ʱ�Ӵ��ݵ�����׶Σ�
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

         // ����ȡָ�׶ε��ź�
         input   wire[`InstAddrBus]  if_pc_i,
         input   wire[`InstBus]  if_inst_i,
         input   wire branch_flag_i,

         input wire[5:0] stop_i,

         // ��ָ�����������׶�
         output  reg[`InstAddrBus]   id_pc_o,
         output  reg[`InstBus]   id_inst_o
       );

always @(posedge clk)
  begin
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
        id_inst_o <= if_inst_i;
        id_pc_o <= if_pc_i;
      end
  end

endmodule
