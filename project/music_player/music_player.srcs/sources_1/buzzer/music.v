`timescale 1ns / 1ps
module music (
         input wire clk,
         input wire rst,
         input wire music_ce_i,
         input wire[31:0] music_freq_i,
         input wire[31:0] music_timer_i,

         output wire is_play_end_o,
         output wire buzzer_out
       );

reg t=0;
reg[10:0] cnt = 0;

assign is_play_end_o = t;

always @(posedge clk)
  begin
    if(cnt == 10)
      begin
        t=~t;
      end
    else
      begin
             cnt= cnt+1;
      end
  end


endmodule
