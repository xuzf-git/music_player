`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/06 16:49:18
// Design Name: 
// Module Name: uart_out_ctrl
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


module read_ctrl(
    input wire clk,
    input wire rst,
    
    input wire uart_en_i,
    input wire uart_out_en_i,
    input wire rx_buf_not_empty_i,
    
    output reg read_sig
    );
    
    reg uart_out_en;
    
    always @( posedge clk)
        if (uart_out_en_i == 1'b1) begin
            uart_out_en <= 1'b1;
        end
    
    always @( posedge clk )
        if ( (uart_out_en == 1'b1) && (rx_buf_not_empty_i == 1'b1) ) begin
            read_sig <= 1'b1;
            uart_out_en <= 1'b0;
        end
        else
            read_sig <= 1'b0; 
    endmodule
