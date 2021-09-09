`timescale 1ns / 1ps
module music(
         input wire clk,
         input wire rst,
         input wire music_ce_i,             // 蜂鸣器模块使能信号
         input wire [31:0] music_freq_i,    // 频率（方波的半周期）
         input wire [31:0] music_timer_i,   // 播放时长 单位ns    (clk 10ns)
         output  is_play_end_o,             // 蜂鸣器播放完毕信号
         output  buzzer_out                 // 蜂鸣器工作信号
       );

buzzer buzzer0(
         .clk(clk),
         .rst(rst),
         .buzzer_out(buzzer_out),
         .frequnce(music_freq_i),
         .music_ce_i(music_ce_i)
       );

timer timer0(
        .clk(clk),
        .rst(rst),
        .last_time(music_timer_i),
        .time_out(is_play_end_o)
      );

endmodule
