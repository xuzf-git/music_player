`timescale 1ns / 1ps
module music(
         input wire clk,
         input wire rst,
         input wire music_ce_i,             // ������ģ��ʹ���ź�
         input wire [31:0] music_freq_i,    // Ƶ�ʣ������İ����ڣ�
         input wire [31:0] music_timer_i,   // ����ʱ�� ��λns    (clk 10ns)
         output  is_play_end_o,             // ��������������ź�
         output  buzzer_out                 // �����������ź�
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
