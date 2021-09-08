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

// ���������ݹ��ܡ��򴮿ڿ���������һ�����ݣ����ӽ��ջ����ж�ȡ�������ݡ�
reg rx_pin_in;
wire rx_clk_bps;

// ���ò���������ģ�飬���ڷ��淢�Ͳ����ʣ�����Ҳ���Ե���tx_band_genģ�飬����һ����
rx_band_gen rx_band_gen( 
    .clk( clk ),
    .rst( rst ),
    .band_sig( 1'b1 ),  // ʼ����Ч
    .clk_bps( rx_clk_bps )
);

initial
begin
    rx_pin_in = 1'b1; // �������ų�ʼ��
    #300
    // ����һ֡���ݣ�32'h55555555, 32'h5f5f5f5f �������ɵĲ����ʷ������ݣ����Ҵ����λ��ʼ���͡�
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
    
    // �ȴ��������������ں��ȡ���ջ�������
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
