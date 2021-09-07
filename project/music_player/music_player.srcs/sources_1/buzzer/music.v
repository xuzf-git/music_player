`timescale 1ns / 1ps
module music (
       input wire clk,
       input wire rst,
       input wire music_ce_i,
       input wire[31:0] music_freq,
       input wire[31:0] music_timer,
       
       output wire is_play_end_o,
       output wire buzzer_out
       );

endmodule