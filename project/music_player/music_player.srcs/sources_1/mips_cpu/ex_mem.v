`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 15:10:40
// Design Name: 
// Module Name: ex_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 将执行阶段的运算结果，在下一个时钟周期传递到访存阶段
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ex_mem(
    input   wire    clk,
    input   wire    rst,

    // 执行阶段的信号
    input  wire[`RegAddrBus]    ex_waddr_i,
    input  wire                 ex_we_i,
    input  wire[`RegBus]        ex_wdata_i,
    input  wire[`AluSelBus]     ex_alu_sel_i,
    input  wire[`RegBus]        ex_ram_addr_i,
    input  wire[`RegBus]        ex_reg_rt_i,

    // 流水线暂停信号
    input  wire[5:0]            stop_i,

    // 输出到访存阶段
    output  reg[`RegAddrBus]    mem_waddr_o,
    output  reg                 mem_we_o,
    output  reg[`RegBus]        mem_wdata_o,
    output  reg[`AluSelBus]     mem_alu_sel_o,
    output  reg[`RegBus]        mem_ram_addr_o,
    output  reg[`RegBus]        mem_reg_rt_o
    );

    always @(posedge clk) begin
        if (rst == `RstEnable) begin
            mem_waddr_o <= `RegAddrNone;
            mem_we_o <= `WriteDisable;
            mem_wdata_o <= `ZeroWord;
            mem_alu_sel_o <= `AluSelNop;
            mem_ram_addr_o <= `ZeroWord;
            mem_reg_rt_o <= `ZeroWord;
        end else if ((stop_i[3] == `True) && (stop_i[4] == `False))begin
            mem_waddr_o <= `RegAddrNone;
            mem_we_o <= `WriteDisable;
            mem_wdata_o <= `ZeroWord;
            mem_alu_sel_o <= `AluSelNop;
            mem_ram_addr_o <= `ZeroWord;
            mem_reg_rt_o <= `ZeroWord;
        end else if (stop_i[3] == `False) begin
            mem_waddr_o <= ex_waddr_i;
            mem_we_o <= ex_we_i;
            mem_wdata_o <= ex_wdata_i;
            mem_alu_sel_o <= ex_alu_sel_i;
            mem_ram_addr_o <= ex_ram_addr_i;
            mem_reg_rt_o <= ex_reg_rt_i;
        end
    end

endmodule
