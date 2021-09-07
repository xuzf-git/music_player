`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/09/07 09:33:41
// Design Name:
// Module Name: music_tb
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


module music_tb(

       );

reg clk;
reg rst;
reg trans_switch;
reg music_switch;
wire buzzer_out;

parameter PERIOD = 10;
initial
  begin
    clk = 1'b0;
    rst = 1'b1;
    trans_switch = 1'b0;
    music_switch = 1'b0;
    #20;
    rst = 1'b0;
    #200;
    music_switch = 1'b1;
    #20;
    music_switch = 1'b0;
  end

always
  begin
    clk = 1'b0;
    #(PERIOD/2) clk = 1'b1;
    #(PERIOD/2);
  end

music_player music_player0(
    .clk(clk),
    .rst(rst),
    .trans_switch_i(trans_switch),
    .music_switch_i(music_switch),
    .buzzer_out(buzzer_out)
);


endmodule
