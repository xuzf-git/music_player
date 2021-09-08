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
    #15000
    trans_switch = 1'b1;
    #20
    trans_switch = 1'b0;
    // #30000;
    // music_switch = 1'b1;
    // #20;
    // music_switch = 1'b0;
  end

always
  begin
    clk = 1'b0;
    #(PERIOD/2) clk = 1'b1;
    #(PERIOD/2);
  end

// 检测接收数据功能。向串口控制器发送一个数据，并从接收缓存中读取接收数据。
reg rx_pin_in;
wire rx_clk_bps;

// 调用波特率生成模块，用于仿真发送波特率（这里也可以调用tx_band_gen模块，功能一样）
rx_band_gen rx_band_gen( 
    .clk( clk ),
    .rst( rst ),
    .band_sig( 1'b1 ),  // 始终有效
    .clk_bps( rx_clk_bps )
);

initial
begin
    rx_pin_in = 1'b1; // 接收引脚初始化
    #300
    // 发送一帧数据：32'h55555555, 32'h5f5f5f5f 根据生成的波特率发送数据，并且从最低位开始发送。
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;        
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;        
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    
    
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b0;
    @( posedge rx_clk_bps ) rx_pin_in = 1'b1;
    
    // 等待两个波特率周期后读取接收缓存数据
    @( posedge rx_clk_bps );
    @( posedge rx_clk_bps );
end

wire rx_buf_not_empty, rx_buf_full;

music_player music_player0(
    .clk(clk),
    .rst(rst),
    
    .trans_switch_i(trans_switch),
    .music_switch_i(music_switch),
    .uart_rx(rx_pin_in),
    
    .rx_buf_not_empty(rx_buf_not_empty),
    .rx_buf_full(rx_buf_full),
    .buzzer_out(buzzer_out)
);


endmodule
