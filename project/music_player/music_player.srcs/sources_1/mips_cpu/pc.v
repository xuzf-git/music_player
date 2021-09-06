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

         input   wire    branch_flag_i,              // �Ƿ�����֧ת��
         input   wire[`RegBus]   branch_target_i,    // ��֧ת�Ƶ�ַ

         input wire[5:0] stop_i,

         output  reg[`InstAddrBus]   pc_reg,    // ���ָ���ַ
         output  reg     ce                     // ָ��洢��ʹ���ź�
       );

// ���� rst ���� inst_rom ʹ��
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

// ���� inst_rom ��ʹ���źţ��ж��Ƕ����� pc += 4
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
