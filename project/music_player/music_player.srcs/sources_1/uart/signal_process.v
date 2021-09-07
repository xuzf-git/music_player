`timescale 1ns / 1ps
module signal_process(
    input clk,
    
    input rst_btn_c,
    output rst,
    
    input rx_pin_jb1,
    output rx_pin_in,
    
    input uart_ce_i,
    input uart_out_en_i,
    input rx_buf_not_empty,
    output read_sig
    );
    
    meta_harden rst_meta(
        .clk( clk ),
        .rst( 1'b0 ),
        .sig_src( rst_btn_c ),
        .sig_dst( rst )
    );
    
    meta_harden rx_pin_meta(
        .clk( clk ),
        .rst( rst ),
        .sig_src( rx_pin_jb1 ),
        .sig_dst( rx_pin_in )
    );

    read_ctrl read_ctrl(
        .clk( clk ),
        .rst( rst ),
        
        .uart_en_i(uart_ce_i),
        .uart_out_en_i(uart_out_en_i),
        .rx_buf_not_empty_i(rx_buf_not_empty),
        
        .read_sig(read_sig)
    );

endmodule
