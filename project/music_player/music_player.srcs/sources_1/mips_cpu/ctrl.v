`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/01 14:20:46
// Design Name: 
// Module Name: ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 控制流水线的启动与暂停
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ctrl(
    input   wire    rst,
    input   wire    stopreq_from_id_i,
    output reg[5:0] stop_o
);

    always @(*) begin
        if (rst == `RstEnable) begin
            stop_o <= 6'b000000;
        end else if (stopreq_from_id_i == `True) begin
            stop_o <= 6'b000111;
        end else begin
            stop_o <= 6'b000000;
        end
    end
endmodule
