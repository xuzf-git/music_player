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


module uart_out_ctrl(
    input wire clk,
    input wire rst,
    
    input wire read_sig,
    input wire[7:0] rx_get_data,
    output reg uart_out_ready_o,
    output reg[7:0] rx_out_data
    );
    
    always @( posedge clk or posedge rst )
        if (read_sig == 1'b1) begin
            uart_out_ready_o <= 1'b1;
        end else begin
            uart_out_ready_o <= 1'b0;
        end
        
    always @( * )
        rx_out_data <= rx_get_data;

endmodule
