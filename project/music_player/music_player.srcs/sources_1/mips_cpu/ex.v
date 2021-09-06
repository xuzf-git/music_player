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
// Description: ��������׶εõ��Ĳ������͡������������������߼����㣨ALU ģ�飩
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

    // ���ڷô�ģ����ź�
    output  wire[`AluSelBus]    alu_sel_o,
    output  wire[`RegBus]       ram_addr_o,
    output  wire[`RegBus]       reg_rt_o,
    // ���ڼĴ���д��ģ����ź�
    output  reg[`RegAddrBus]    reg_waddr_o,
    output  reg                 reg_we_o,
    output  reg[`RegBus]        reg_wdata_o
    );
    
    // �߼�������м���
    reg[`RegBus]    alu_res;

    // �� alu_sel �ź�������ô�׶Σ�ȷ�� load�� store ָ��
    assign alu_sel_o = alu_sel_i;

    // ����ô�׶εĵ�ַ
    assign ram_addr_o = alu_opnd1_i + {{16{inst_i[15]}}, inst_i[15:0]};

    // �Ĵ��� rt 
    assign reg_rt_o = alu_opnd2_i;
    
    // �����߼����㣬ָ�����
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
