`timescale 1ns / 1ps
`include "defines.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/08/28 10:09:24
// Design Name:
// Module Name: mips_cpu
// Project Name:
// Target Devices:
// Tool Versions:
// Description: ʵ��������ģ�飬������ˮ��CPU
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module mips_cpu(
         input   wire    clk,
         input   wire    rst,

         input   wire[`RegBus]   rom_rdata_i,
         input   wire[`RegBus]   ram_data_i,

         output  wire[`RegBus]   rom_raddr_o,
         output  wire            rom_re_o,
         output  wire[`RegBus]    ram_addr_o,
         output  wire            ram_we_o,
         output  wire[`RegBus]    ram_data_o,
         
         output  wire                 uart_data_recv_end_o,

         input wire trans_switch_i,
         input wire music_switch_i,
         input wire is_play_end_i,
         input wire uart_finish_i,

         output wire uart_ce_o,
         input wire music_ce_o,

         input  wire[31:0]           uart_data_i,
         output  wire[31:0]           music_freq_o,
         output  wire[31:0]           music_timer_o
       );

// ���� CTRL ģ�������ģ��
wire                    stopreq_from_id;
wire[5:0]               stop;

// ���� PC ģ��� IF_ID ģ��
wire[`RegBus]       if_id_pc_i;

// ���� PC ģ��� ID ģ��
wire                branch_flag;
wire[`RegBus]       branch_target;

// ���� IF_ID ģ��� ID ģ��
wire[`RegBus]       if_id_pc_o;
wire[`RegBus]       if_id_inst_o;

// ���� ID ģ��� Regfile ģ��
wire                reg_re1;
wire                reg_re2;
wire[`RegBus]       reg_rdata1;
wire[`RegBus]       reg_rdata2;
wire[`RegAddrBus]   reg_raddr1;
wire[`RegAddrBus]   reg_raddr2;

// ���� ID ģ��� ID_EX ģ��
wire[`AluSelBus]    id_ex_alu_sel_i;
wire[`RegBus]       id_ex_alu_opnd1_i;
wire[`RegBus]       id_ex_alu_opnd2_i;
wire                id_ex_reg_we_i;
wire[`RegAddrBus]   id_ex_reg_waddr_i;
wire[`RegBus]       id_ex_inst_i;

// ���� ID_EX ģ��� EX ģ��
wire[`AluSelBus]    id_ex_alu_sel_o;
wire[`RegBus]       id_ex_alu_opnd1_o;
wire[`RegBus]       id_ex_alu_opnd2_o;
wire                id_ex_reg_we_o;
wire[`RegAddrBus]   id_ex_reg_waddr_o;
wire[`RegBus]       id_ex_inst_o;

// ���� EX ģ��� EX_MEM ģ��
wire                ex_mem_we_i;        // ���� ID ģ�飬����������
wire[`RegAddrBus]   ex_mem_waddr_i;     // ���� ID ģ�飬����������
wire[`RegBus]       ex_mem_wdata_i;     // ���� ID ģ�飬����������
wire[`AluSelBus]    ex_mem_alu_sel_i;
wire[`RegBus]       ex_mem_ram_addr_i;
wire[`RegBus]       ex_mem_reg_rt_i;

// ���� EX_MEM ģ��� MEM ģ��
wire                ex_mem_we_o;
wire[`RegAddrBus]   ex_mem_waddr_o;
wire[`RegBus]       ex_mem_wdata_o;
wire[`AluSelBus]    ex_mem_alu_sel_o;
wire[`RegBus]       ex_mem_ram_addr_o;
wire[`RegBus]       ex_mem_reg_rt_o;

// ���� MEM ģ��� MEM_WB ģ��
wire                mem_wb_we_i;        // ���� ID ģ������һ��ָ���������
wire[`RegAddrBus]   mem_wb_waddr_i;     // ���� ID ģ������һ��ָ���������
wire[`RegBus]       mem_wb_wdata_i;     // ���� ID ģ������һ��ָ���������

// ���� MEM_WB ģ��� WB ģ��
wire                mem_wb_we_o;
wire[`RegAddrBus]   mem_wb_waddr_o;
wire[`RegBus]       mem_wb_wdata_o;

// ���� WB ģ��� Regfile ģ��
wire                wb_we;
wire[`RegAddrBus]   wb_waddr;
wire[`RegBus]       wb_wdata;

// ʵ���� CTRL ģ��
ctrl ctrl_real(
       .stopreq_from_id_i(stopreq_from_id),
       .stop_o(stop)
     );

// ʵ���� PC
pc pc_real(
     .clk(clk),
     .rst(rst),
     // ���� CTRL ģ�����ͣ�ź�
     .stop_i(stop),

     // ���� ID ģ��ķ�֧ת����Ϣ
     .branch_flag_i(branch_flag),
     .branch_target_i(branch_target),
     // �����ָ��洢�� ROM ����Ϣ

     .trans_switch_i(trans_switch_i),
     .music_switch_i(music_switch_i),

     .pc_reg(if_id_pc_i),
     .ce(rom_re_o)
   );

assign rom_raddr_o = if_id_pc_i;

// ʵ���� IF_ID ģ��
if_id if_id_real(
        .clk(clk),
        .rst(rst),
        .if_pc_i(if_id_pc_i),
        .if_inst_i(rom_rdata_i),
        .id_pc_o(if_id_pc_o),
        .id_inst_o(if_id_inst_o),
        // ���� CTRL ģ�����ͣ�ź�
        .stop_i(stop),
        // ���� ID ģ�����ת�źţ����ת�����
        .branch_flag_i(branch_flag)
      );

// ʵ���� ID
id id_real(
     .rst(rst),

     // ���� PC ģ�������
     .inst_i(if_id_inst_o),
     .pc_i(if_id_pc_o),

     // ����� PC ģ���ת����Ϣ
     .branch_flag_o(branch_flag),
     .branch_target_o(branch_target),

     // ���� Regfile ģ�������
     .reg_rdata1_i(reg_rdata1),
     .reg_rdata2_i(reg_rdata2),

     // �������ָ����������
     .ex_reg_wdata_i(ex_mem_wdata_i),
     .ex_reg_waddr_i(ex_mem_waddr_i),
     .ex_reg_we_i(ex_mem_we_i),

     // ���� EX ģ���ָ��ѡ���źţ��ж� load ���
     .ex_alu_sel_i(ex_mem_alu_sel_i),

     .is_play_end_i(is_play_end_i),
     .uart_finish_i(uart_finish_i),

     .uart_ce_o(uart_ce_o),
     .music_ce_o(music_ce_o),

     // �����һ��ָ����������
     .mem_reg_wdata_i(mem_wb_wdata_i),
     .mem_reg_waddr_i(mem_wb_waddr_i),
     .mem_reg_we_i(mem_wb_we_i),

     // ����� CTRL ģ�����ˮ����ͣ�ź�
     .stopreq_from_id_o(stopreq_from_id),

     // ����� Regfile ģ�����Ϣ
     .reg_re1_o(reg_re1),
     .reg_re2_o(reg_re2),
     .reg_raddr1_o(reg_raddr1),
     .reg_raddr2_o(reg_raddr2),

     // ����� EX ģ�����Ϣ
     .alu_sel_o(id_ex_alu_sel_i),
     .alu_opnd1_o(id_ex_alu_opnd1_i),
     .alu_opnd2_o(id_ex_alu_opnd2_i),
     .reg_waddr_o(id_ex_reg_waddr_i),
     .reg_we_o(id_ex_reg_we_i),
     .inst_o(id_ex_inst_i)
   );

// ʵ���� Regfile
regfile regfile_real(
          .clk(clk),
          .rst(rst),

          // �� WB ģ�鴫����Ϣ
          .we_i(wb_we),
          .waddr_i(wb_waddr),
          .wdata_i(wb_wdata),

          // �� ID ģ�鴫������Ϣ
          .re1_i(reg_re1),
          .re2_i(reg_re2),
          .raddr1_i(reg_raddr1),
          .raddr2_i(reg_raddr2),

          // ����� ID ģ�����Ϣ
          .rdata1_o(reg_rdata1),
          .rdata2_o(reg_rdata2)
        );

// ʵ���� ID_EX ģ��
id_ex id_ex_real(
        .clk(clk),
        .rst(rst),
        .id_alu_sel_i(id_ex_alu_sel_i),
        .id_alu_opnd1_i(id_ex_alu_opnd1_i),
        .id_alu_opnd2_i(id_ex_alu_opnd2_i),
        .id_reg_waddr_i(id_ex_reg_waddr_i),
        .id_reg_we_i(id_ex_reg_we_i),
        .id_inst_i(id_ex_inst_i),
        .ex_alu_sel_o(id_ex_alu_sel_o),
        .ex_alu_opnd1_o(id_ex_alu_opnd1_o),
        .ex_alu_opnd2_o(id_ex_alu_opnd2_o),
        .ex_reg_waddr_o(id_ex_reg_waddr_o),
        .ex_reg_we_o(id_ex_reg_we_o),
        .ex_inst_o(id_ex_inst_o),
        // ���� CTRL ģ�����ͣ�ź�
        .stop_i(stop)
      );

// ʵ���� EX ģ��
ex ex_real(
     .rst(rst),

     // �� ID ģ�鴫������Ϣ
     .inst_i(id_ex_inst_o),
     .alu_sel_i(id_ex_alu_sel_o),
     .alu_opnd1_i(id_ex_alu_opnd1_o),
     .alu_opnd2_i(id_ex_alu_opnd2_o),
     .reg_waddr_i(id_ex_reg_waddr_o),
     .reg_we_i(id_ex_reg_we_o),

     // ����� MEM ģ�����Ϣ
     .reg_waddr_o(ex_mem_waddr_i),
     .reg_we_o(ex_mem_we_i),
     .reg_wdata_o(ex_mem_wdata_i),
     .alu_sel_o(ex_mem_alu_sel_i),
     .ram_addr_o(ex_mem_ram_addr_i),
     .reg_rt_o(ex_mem_reg_rt_i)
   );

// ʵ���� EX_MEM ģ��
ex_mem ex_mem_real(
         .clk(clk),
         .rst(rst),
         .ex_waddr_i(ex_mem_waddr_i),
         .ex_we_i(ex_mem_we_i),
         .ex_wdata_i(ex_mem_wdata_i),
         .ex_alu_sel_i(ex_mem_alu_sel_i),
         .ex_ram_addr_i(ex_mem_ram_addr_i),
         .ex_reg_rt_i(ex_mem_reg_rt_i),

         .mem_waddr_o(ex_mem_waddr_o),
         .mem_we_o(ex_mem_we_o),
         .mem_wdata_o(ex_mem_wdata_o),
         .mem_alu_sel_o(ex_mem_alu_sel_o),
         .mem_ram_addr_o(ex_mem_ram_addr_o),
         .mem_reg_rt_o(ex_mem_reg_rt_o),
         // ���� CTRL ģ�����ͣ�ź�
         .stop_i(stop)
       );

// ʵ���� MEM ģ��
mem mem_real(
      .rst(rst),

      // �� EX ģ�鴫������Ϣ
      .ex_waddr_i(ex_mem_waddr_o),
      .ex_we_i(ex_mem_we_o),
      .ex_wdata_i(ex_mem_wdata_o),
      .ex_alu_sel_i(ex_mem_alu_sel_o),
      .ex_ram_addr_i(ex_mem_ram_addr_o),
      .ex_reg_rt_i(ex_mem_reg_rt_o),

      // �����ݴ洢���������ź�
      .ram_data_i(ram_data_i),

      // ����� WB ģ�����Ϣ
      .mem_waddr_o(mem_wb_waddr_i),
      .mem_we_o(mem_wb_we_i),
      .mem_wdata_o(mem_wb_wdata_i),

      // ��������ݴ洢�����ź�
      .mem_ram_addr_o(ram_addr_o),
      .mem_ram_we_o(ram_we_o),
      .mem_ram_data_o(ram_data_o),

      .uart_data_i(uart_data_i),
      .music_freq_o(music_freq_o),
      .music_timer_o(music_timer_o),
      .uart_data_recv_end_o(uart_data_recv_end_o)
    );

// ʵ���� MEM_WB ģ��
mem_wb mem_wb_real(
         .clk(clk),
         .rst(rst),
         .mem_waddr_i(mem_wb_waddr_i),
         .mem_we_i(mem_wb_we_i),
         .mem_wdata_i(mem_wb_wdata_i),
         .wb_waddr_o(mem_wb_waddr_o),
         .wb_we_o(mem_wb_we_o),
         .wb_wdata_o(mem_wb_wdata_o),
         // ���� CTRL ģ�����ͣ�ź�
         .stop_i(stop)
       );

// ʵ���� WB ģ��
wb wb_real(
     .rst(rst),

     // �� MEM ģ�鴫������Ϣ
     .mem_waddr_i(mem_wb_waddr_o),
     .mem_we_i(mem_wb_we_o),
     .mem_wdata_i(mem_wb_wdata_o),

     // ����� Regfile ģ�����Ϣ
     .wb_waddr_o(wb_waddr),
     .wb_we_o(wb_we),
     .wb_wdata_o(wb_wdata)
   );

endmodule
