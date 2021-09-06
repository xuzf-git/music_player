`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/28 16:19:17
// Design Name: 
// Module Name: mips_min_sopc
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


module pipeline(
        input   wire    clk,
        input   wire    rst
    );

    // ���� inst_rom �� CPU 
    wire[`InstAddrBus]  inst_addr;
    wire[`InstBus]      inst;
    wire                inst_rom_en;

    // ���� data_ram �� CPU
    wire[`RegBus]       ram_rdata;
    wire[`RegBus]       ram_addr;
    wire                ram_we;
    wire[`RegBus]       ram_wdata;


    // ʵ���� MIPS_CPU
    mips_cpu cpu(
        .clk(clk),
        .rst(rst),
        // inst_rom ���͸� CPU ��ָ��
        .rom_rdata_i(inst),
        // CPU ���͸� inst_rom ��ָ���ַ��ʹ���ź�
        .rom_raddr_o(inst_addr),
        .rom_re_o(inst_rom_en),
        // data_ram ���͸� CPU ������
        .ram_data_i(ram_rdata),
        // CPU ���͸� data_ram �����ݵ�ַ��ʹ���źš�д������
        .ram_addr_o(ram_addr),
        .ram_we_o(ram_we),
        .ram_data_o(ram_wdata)
    );

    // ʵ����ָ��洢�� ROM 
    inst_rom rom(
        .a(inst_addr[11:2]),    // [11:2] WORD ��ַ����Լ��
        .spo(inst)
    );

    // ʵ�������ݴ洢�� RAM 
    data_ram ram(
        .a(ram_addr[11:2]),    // [11:2] WORD ��ַ����Լ��
        .d(ram_wdata),
        .clk(clk),
        .we(ram_we),
        .spo(ram_rdata)
    );

endmodule
