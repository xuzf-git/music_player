`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/08/28 16:19:17
// Design Name:
// Module Name: mips_min_sopc
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


module pipeline(
         input   wire    clk,
         input   wire    rst,

         output  wire     uart_data_recv_end_o,
         output  wire     music_data_write_end_o,


         input wire trans_switch_i,
         input wire music_switch_i,
         input wire is_play_end_i,
         input wire uart_finish_i,

         output wire uart_ce_o,
         input wire music_ce_o,

         input  wire[31:0]           uart_data_i,
         output  wire[31:0]           music_freq_o,
         output  wire[31:0]           music_timer_o
       );

// 连接 inst_rom 和 CPU
wire[`InstAddrBus]  inst_addr;
wire[`InstBus]      inst;
wire                inst_rom_en;

// 连接 data_ram 和 CPU
wire[`RegBus]       ram_rdata;
wire[`RegBus]       ram_addr;
wire                ram_we;
wire[`RegBus]       ram_wdata;


// 实例化 MIPS_CPU
mips_cpu cpu(
           .clk(clk),
           .rst(rst),
           // inst_rom 发送给 CPU 的指令
           .rom_rdata_i(inst),
           // CPU 发送给 inst_rom 的指令地址和使能信号
           .rom_raddr_o(inst_addr),
           .rom_re_o(inst_rom_en),
           // data_ram 发送给 CPU 的数据
           .ram_data_i(ram_rdata),
           // CPU 发送给 data_ram 的数据地址、使能信号、写入数据
           .ram_addr_o(ram_addr),
           .ram_we_o(ram_we),
           .ram_data_o(ram_wdata),

           .uart_data_recv_end_o(uart_data_recv_end_o),
           .music_data_write_end_o(music_data_write_end_o),
           .trans_switch_i(trans_switch_i),
           .music_switch_i(music_switch_i),
           .is_play_end_i(is_play_end_i),
           .uart_finish_i(uart_finish_i),
           .uart_ce_o(uart_ce_o),
           .music_ce_o(music_ce_o),
           .uart_data_i(uart_data_i),
           .music_freq_o(music_freq_o),
           .music_timer_o(music_timer_o)
         );

// 实例化指令存储器 ROM
inst_rom rom(
           .a(inst_addr[11:2]),    // [11:2] WORD 地址对齐约束
           .spo(inst)
         );

// 实例化数据存储器 RAM
data_ram ram(
           .a(ram_addr[11:2]),    // [11:2] WORD 地址对齐约束
           .d(ram_wdata),
           .clk(clk),
           .we(ram_we),
           .spo(ram_rdata)
         );

endmodule
