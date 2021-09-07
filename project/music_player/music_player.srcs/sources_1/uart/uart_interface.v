`timescale 1ns / 1ps

module uart_interface(
    input wire clk,
    input wire rst_n,
    input wire uart_ce_i,
    input wire uart_out_en_i,
    output wire uart_out_ready_o,
    
    input wire rx_pin_jb1,
    output wire [31:0] rx_data_o,
    output wire rx_buf_not_empty,
    output wire rx_buf_full
    );
    
    wire rst, rx_pin_in, read_sig;
    wire rst_btn_c = ~rst_n;
    
    signal_process sig_process(
        .clk( clk ),
        
        .rst_btn_c( rst_btn_c ),
        .rst(rst),
        
        .rx_pin_jb1( rx_pin_jb1 ),
        .rx_pin_in( rx_pin_in ),

        .uart_ce_i(uart_ce_i),
        .uart_out_en_i(uart_out_en_i),
        .rx_buf_not_empty(rx_buf_not_empty),
        .read_sig(read_sig)
    );
    
    wire [31:0] rx_get_data;
    
    uart uart_real(
        .clk( clk ),
        .rst( rst ),
        
        .en( uart_ce_i ),
        
        .rx_read( read_sig ),
        .rx_pin_in( rx_pin_in ),
        .rx_get_data( rx_get_data ),
        .rx_buf_not_empty( rx_buf_not_empty ),
        .rx_buf_full( rx_buf_full ),
        
        .tx_write( 1'b0 ),
        .tx_pin_out(  ),
        .tx_send_data( 32'b0 ),
        .tx_buf_not_full(  )
    );
    
    uart_out_ctrl uart_out_ctrl(
        .clk( clk ),
        .rst( rst ),
        
        .read_sig(read_sig),
        .rx_get_data(rx_get_data),
        .uart_out_ready_o(uart_out_ready_o),
        .rx_out_data(rx_data_o)
    );

endmodule
