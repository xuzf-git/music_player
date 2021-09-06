`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 15:09:20
// Design Name: 
// Module Name: ex
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 根据译码阶段得到的操作类型、操作数，进行算数逻辑运算（ALU 模块）
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ex(
    input   wire    rst,

    input   wire[`RegBus]       inst_i,
    input   wire[`AluSelBus]    alu_sel_i,
    input   wire[`RegBus]       alu_opnd1_i,
    input   wire[`RegBus]       alu_opnd2_i,
    input   wire[`RegAddrBus]   reg_waddr_i,
    input   wire                reg_we_i,

    // 关于访存模块的信号
    output  wire[`AluSelBus]    alu_sel_o,
    output  wire[`RegBus]       ram_addr_o,
    output  wire[`RegBus]       reg_rt_o,
    // 关于寄存器写回模块的信号
    output  reg[`RegAddrBus]    reg_waddr_o,
    output  reg                 reg_we_o,
    output  reg[`RegBus]        reg_wdata_o
    );
    
    // 逻辑运算的中间结果
    reg[`RegBus]    alu_res;

    // 将 alu_sel 信号输出到访存阶段，确定 load、 store 指令
    assign alu_sel_o = alu_sel_i;

    // 计算访存阶段的地址
    assign ram_addr_o = alu_opnd1_i + {{16{inst_i[15]}}, inst_i[15:0]};

    // 寄存器 rt 
    assign reg_rt_o = alu_opnd2_i;
    
    // 进行逻辑运算，指定输出
    always @(*) begin
        if (rst == `RstEnable) begin
            alu_res <= `ZeroWord;
        end else begin
            case (alu_sel_i)
                `ALU_ADD: begin
                    alu_res <= alu_opnd1_i + alu_opnd2_i;
                end
                `ALU_AND: begin
                    alu_res <= alu_opnd1_i & alu_opnd2_i;
                end
                `ALU_OR: begin
                    alu_res <= alu_opnd1_i | alu_opnd2_i;
                end
                `ALU_NOR: begin
                    alu_res <= ~(alu_opnd1_i | alu_opnd2_i);
                end
                `ALU_XOR:  begin
                    alu_res <= alu_opnd1_i ^ alu_opnd2_i;
                end
                default: begin
                    alu_res <= `ZeroWord;
                end
            endcase
        end
    end

    always @(*) begin
        reg_we_o <= reg_we_i;
        reg_waddr_o <= reg_waddr_i;
        reg_wdata_o <= alu_res;
    end


endmodule
