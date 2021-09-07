`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/08/26 15:11:05
// Design Name:
// Module Name: mem
// Project Name:
// Target Devices:
// Tool Versions:
// Description: 访存模块，对于数据加载存储指令进行存储器操作，对于非访存指令直接传到写回模块
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

// TODO 注意 uart 使能跳变的时候记录一个标志位输入第一组数据，不然会死锁
module mem(
         input   wire    rst,

         input   wire[`RegAddrBus]   ex_waddr_i,
         input   wire                ex_we_i,
         input   wire[`RegBus]       ex_wdata_i,
         // 来自 EX 模块的信号
         input  wire[`AluSelBus]     ex_alu_sel_i,
         input  wire[`RegBus]        ex_ram_addr_i,
         input  wire[`RegBus]        ex_reg_rt_i,
         // 来自数据存储器的信号
         input  wire[`RegBus]        ram_data_i,
         // 输出到 WB 模块的信号
         output  reg[`RegAddrBus]    mem_waddr_o,
         output  reg                 mem_we_o,
         output  reg[`RegBus]        mem_wdata_o,
         // 输出到数据存储器的信号
         output  reg[`RegBus]        mem_ram_addr_o,
         output  wire                mem_ram_we_o,
         output  reg[`RegBus]        mem_ram_data_o,

         input   wire[31:0]          uart_data_i,
         output  wire[31:0]          music_freq_o,
         output  wire[31:0]          music_timer_o,
         output  reg                 uart_data_recv_end_o
       );

reg mem_ram_we;
assign  mem_ram_we_o = mem_ram_we;

reg[31:0]  reg_music_freq_o = 0;
reg[31:0]  reg_music_timer_o = 0;

assign music_freq_o = reg_music_freq_o;
assign music_timer_o = reg_music_timer_o;

always @(*)
  begin
    if (rst == `RstEnable)
      begin
        // to WB
        mem_waddr_o <= `RegAddrNone;
        mem_we_o <= `WriteDisable;
        mem_wdata_o <= `ZeroWord;
        // to RAM
        mem_ram_addr_o <= `ZeroWord;
        mem_ram_we <= `WriteDisable;
        mem_ram_data_o <= `ZeroWord;
        uart_data_recv_end_o <= 1'b0;
      end
    else
      begin
        mem_waddr_o <= ex_waddr_i;
        mem_we_o <= ex_we_i;
        mem_wdata_o <= ex_wdata_i;
        mem_ram_we <= `WriteDisable;
        mem_ram_addr_o <= `ZeroWord;
        uart_data_recv_end_o <= 1'b0;
        case (ex_alu_sel_i)
          `ALU_LW:
            begin
              mem_ram_addr_o <= ex_ram_addr_i;
              mem_ram_we <= `WriteDisable;
              mem_wdata_o <= ram_data_i;
              if(ex_ram_addr_i == 1023)
                begin
                  mem_wdata_o <= uart_data_i;
                  uart_data_recv_end_o <= 1'b1;
                end
            end
          `ALU_SW:
            begin
              if(ex_ram_addr_i < 950)
                begin
                  mem_ram_addr_o <= ex_ram_addr_i;
                  mem_ram_we <= `WriteEnable;
                  mem_ram_data_o <= ex_reg_rt_i;
                end
              else
                begin
                  case(ex_ram_addr_i)
                    1022:
                      begin
                        reg_music_freq_o <= ex_reg_rt_i;
                      end
                    1021:
                      begin
                        reg_music_timer_o <= ex_reg_rt_i;
                      end
                  endcase
                end
            end
          default:
            begin
              mem_ram_we <= `WriteDisable;
            end
        endcase
      end
  end
endmodule
