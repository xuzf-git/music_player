`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 15:11:45
// Design Name: 
// Module Name: mem_wb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 将访存阶段的运算结果，在下一个时钟周期传递到写回阶段
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mem_wb(
    input   wire    clk,
    input   wire    rst,

    input   wire[`RegAddrBus]   mem_waddr_i,
    input   wire                mem_we_i,
    input   wire[`RegBus]       mem_wdata_i,
    input   wire[5:0]           stop_i,

    output  reg[`RegAddrBus]    wb_waddr_o,
    output  reg                 wb_we_o,
    output  reg[`RegBus]        wb_wdata_o
    );

    always @(posedge clk) begin
        if (rst == `RstEnable) begin
            wb_waddr_o <= `RegAddrNone;
            wb_we_o <= `WriteDisable;
            wb_wdata_o <= `ZeroWord;
        end else if ((stop_i[4] == `True) && (stop_i[5] == `False)) begin
            wb_waddr_o <= `RegAddrNone;
            wb_we_o <= `WriteDisable;
            wb_wdata_o <= `ZeroWord;
        end else if (stop_i[4] == `False) begin
            wb_waddr_o <= mem_waddr_i;
            wb_we_o <= mem_we_i;
            wb_wdata_o <= mem_wdata_i; 
        end
    end
endmodule
