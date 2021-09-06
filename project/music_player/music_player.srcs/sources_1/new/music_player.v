`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/09/06 10:54:05
// Design Name:
// Module Name: music_player
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


module music_player(
         input wire clk,
         input wire rst,
         input wire trans_switch_i,
         input wire music_switch_i,
         output buzzer_out
       );

wire uart_ce;
wire music_ce;
wire[31:0] uart_data;
wire[31:0] music_freq;
wire[31:0] music_timer;
wire is_play_end;
wire uart_finish;
wire uart_data_recv_end;
wire music_data_write_end;

pipeline pipeline0(
           .clk(clk),
           .rst(rst),

           .uart_data_recv_end_o(uart_data_recv_end),
           .music_data_write_end_o(music_data_write_end),

           .trans_switch_i(trans_switch_i),
           .music_switch_i(music_switch_i),

           .is_play_end_i(is_play_end_i),
           .uart_finish_i(uart_finish_i),

           .uart_ce_o(uart_ce),
           .music_ce_o(music_ce),
           .uart_data_i(uart_data),
           .music_freq_o(music_freq),
           .music_timer_o(music_timer)
         );

uart uart0(
       .uart_ce_i(uart_ce),
       .uart_data_o(uart_data),
       .uart_finish_o(uart_finish),
       .uart_data_recv_end_i(uart_data_recv_end)
     );


music music0(
        .clk(clk),
        .rst(rst),
        .music_ce_i(music_ce),
        .music_freq_i(music_freq),
        .music_timer_i(music_timer),
        .is_play_end_o(is_play_end),
        .buzzer_out(buzzer_out),
        .music_data_write_end_i(music_data_write_end)
      );

endmodule
