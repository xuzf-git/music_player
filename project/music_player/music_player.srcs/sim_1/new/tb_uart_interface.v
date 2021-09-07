`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/07 00:03:24
// Design Name: 
// Module Name: tb_uart_interface
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


module tb_uart_interface;
    // ��ʱ�ӡ���λ�Լ�ʹ�ܽ��г�ʼ���Ϳ���
    reg clk, rst, en;
    
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        en = 1'b0;
        #10 en = 1'b1;  // ��ʹ��
        #10 rst = 1'b1; // ���и�λ����λʱ��Ϊ10ns��һ��ʱ�����ڣ�
        #10 rst = 1'b0;
    end
    always #5 clk <= ~clk; // ����ʱ�䵥λ�����룬��basys3��������100M������basys3��ʱ�����ڵ���10��ʱ�䵥λ
    
    
    // ���������ݹ��ܡ��򴮿ڿ���������һ�����ݣ����ӽ��ջ����ж�ȡ�������ݡ�
    reg read, rx_pin_in;
    wire rx_buf_not_empty, rx_clk_bps, uart_out_ready;
    wire[31:0] rx_get_data;
    // ���ò���������ģ�飬���ڷ��淢�Ͳ����ʣ�����Ҳ���Ե���tx_band_genģ�飬����һ����
    rx_band_gen rx_band_gen( 
        .clk( clk ),
        .rst( rst ),
        .band_sig( 1'b1 ),  // ʼ����Ч
        .clk_bps( rx_clk_bps )
    );
    
    initial
    begin
        read = 1'b0;  // ��������ʼ��
        rx_pin_in = 1'b1; // �������ų�ʼ��
        #100
         // ����һ֡���ݣ�8'b01010101���������ɵĲ����ʷ������ݣ����Ҵ����λ��ʼ���͡�
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
        @( posedge clk ) read = 1'b1;
        @( posedge clk ) read = 1'b0;
    end
    
    
    // ��ⷢ�����ݹ��ܡ��򴮿ڿ������ķ��ͻ�����д���������������ݣ��۲췢������ tx_pin_out ���Ρ�
//    reg write;
//    wire tx_pin_out, tx_buf_not_full;
//    reg [7:0] tx_send_data;
//    initial
//    begin
//        write = 1'b0;
//        #10000
//        @( posedge clk ) tx_send_data = 8'b01101001; write = 1'b1;
//        @( posedge clk ) write = 1'b0; 
                        
//        @( posedge clk ) tx_send_data = 8'b01010101; write = 1'b1;
//        @( posedge clk ) write = 1'b0;
//    end

    
    // ������Ҫ�� uart ���з��档��Ϊ input_signal_processing �� data_show ģ��
    // ֻ�Ƕ���Χ�豸�źŽ��д������Ǳ���ģ�飬��������ֻ��uart_topģ����з���
//    uart uart(
//        .clk( clk ),
//        .rst( rst ),
//        .en( en ),
//        .rx_read( read ),
//        .rx_pin_in( rx_pin_in ),
//        .rx_get_data( rx_get_data ),
//        .rx_buf_not_empty( rx_buf_not_empty ),
//        .tx_write( write ),
//        .tx_pin_out( tx_pin_out ),
//        .tx_send_data( tx_send_data ),
//        .tx_buf_not_full( tx_buf_not_full )
//    );
    
    uart_interface uart_interface(
        .clk(clk),
        .rst_n(~rst),
        .uart_ce_i(en),
        .uart_out_en_i(en),
        
        .rx_pin_jb1(rx_pin_in),
        .rx_data_o(rx_get_data),
        .rx_buf_not_empty(ex_buf_not_empty),
        .rx_buf_full(),
        .uart_out_ready_o(uart_out_ready)
    );
endmodule
