`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 15:11:05
// Design Name: 
// Module Name: mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: �ô�ģ�飬�������ݼ��ش洢ָ����д洢�����������ڷǷô�ָ��ֱ�Ӵ���д��ģ��
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mem(
    input   wire    rst,

    input   wire[`RegAddrBus]   ex_waddr_i,
    input   wire                ex_we_i,
    input   wire[`RegBus]       ex_wdata_i,
    // ���� EX ģ����ź�
    input  wire[`AluSelBus]     ex_alu_sel_i,
    input  wire[`RegBus]        ex_ram_addr_i,
    input  wire[`RegBus]        ex_reg_rt_i,
    // �������ݴ洢�����ź�
    input  wire[`RegBus]        ram_data_i,
    // ����� WB ģ����ź�
    output  reg[`RegAddrBus]    mem_waddr_o,
    output  reg                 mem_we_o,
    output  reg[`RegBus]        mem_wdata_o,
    // ��������ݴ洢�����ź�
    output  reg[`RegBus]        mem_ram_addr_o,
    output  wire                mem_ram_we_o,
    output  reg[`RegBus]        mem_ram_data_o
    );

    reg mem_ram_we;
    assign  mem_ram_we_o = mem_ram_we;

    always @(*) begin
        if (rst == `RstEnable) begin
            // to WB
            mem_waddr_o <= `RegAddrNone;
            mem_we_o <= `WriteDisable;
            mem_wdata_o <= `ZeroWord;
            // to RAM
            mem_ram_addr_o <= `ZeroWord;
            mem_ram_we <= `WriteDisable;
            mem_ram_data_o <= `ZeroWord;
        end else begin
            mem_waddr_o <= ex_waddr_i;
            mem_we_o <= ex_we_i;
            mem_wdata_o <= ex_wdata_i;
            mem_ram_we <= `WriteDisable;
            mem_ram_addr_o <= `ZeroWord;
            case (ex_alu_sel_i)
                `ALU_LW: begin
                    mem_ram_addr_o <= ex_ram_addr_i;
                    mem_ram_we <= `WriteDisable;
                    mem_wdata_o <= ram_data_i;
                end 
                `ALU_SW: begin
                    mem_ram_addr_o <= ex_ram_addr_i;
                    mem_ram_we <= `WriteEnable;
                    mem_ram_data_o <= ex_reg_rt_i;
                end
                default: begin
                    mem_ram_we <= `WriteDisable;
                end
            endcase  
        end
    end
endmodule
