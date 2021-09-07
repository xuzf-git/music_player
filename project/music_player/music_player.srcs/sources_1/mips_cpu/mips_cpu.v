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
// Description: ÊµÀý»¯¸÷¸öÄ£¿é£¬´´½¨Á÷Ë®ÏßCPU
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

<<<<<<< HEAD
// ï¿½ï¿½ï¿½ï¿½ CTRL Ä£ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä£ï¿½ï¿?
wire                    stopreq_from_id;
wire[5:0]               stop;

// ï¿½ï¿½ï¿½ï¿½ PC Ä£ï¿½ï¿½ï¿? IF_ID Ä£ï¿½ï¿½
wire[`RegBus]       if_id_pc_i;

// ï¿½ï¿½ï¿½ï¿½ PC Ä£ï¿½ï¿½ï¿? ID Ä£ï¿½ï¿½
wire                branch_flag;
wire[`RegBus]       branch_target;

// ï¿½ï¿½ï¿½ï¿½ IF_ID Ä£ï¿½ï¿½ï¿? ID Ä£ï¿½ï¿½
wire[`RegBus]       if_id_pc_o;
wire[`RegBus]       if_id_inst_o;

// ï¿½ï¿½ï¿½ï¿½ ID Ä£ï¿½ï¿½ï¿? Regfile Ä£ï¿½ï¿½
=======
// Á¬½Ó CTRL Ä£¿éºÍÆäËûÄ£¿é
wire                    stopreq_from_id;
wire[5:0]               stop;

// Á¬½Ó PC Ä£¿éºÍ IF_ID Ä£¿é
wire[`RegBus]       if_id_pc_i;

// Á¬½Ó PC Ä£¿éºÍ ID Ä£¿é
wire                branch_flag;
wire[`RegBus]       branch_target;

// Á¬½Ó IF_ID Ä£¿éºÍ ID Ä£¿é
wire[`RegBus]       if_id_pc_o;
wire[`RegBus]       if_id_inst_o;

// Á¬½Ó ID Ä£¿éºÍ Regfile Ä£¿é
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
wire                reg_re1;
wire                reg_re2;
wire[`RegBus]       reg_rdata1;
wire[`RegBus]       reg_rdata2;
wire[`RegAddrBus]   reg_raddr1;
wire[`RegAddrBus]   reg_raddr2;

<<<<<<< HEAD
// ï¿½ï¿½ï¿½ï¿½ ID Ä£ï¿½ï¿½ï¿? ID_EX Ä£ï¿½ï¿½
=======
// Á¬½Ó ID Ä£¿éºÍ ID_EX Ä£¿é
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
wire[`AluSelBus]    id_ex_alu_sel_i;
wire[`RegBus]       id_ex_alu_opnd1_i;
wire[`RegBus]       id_ex_alu_opnd2_i;
wire                id_ex_reg_we_i;
wire[`RegAddrBus]   id_ex_reg_waddr_i;
wire[`RegBus]       id_ex_inst_i;

<<<<<<< HEAD
// ï¿½ï¿½ï¿½ï¿½ ID_EX Ä£ï¿½ï¿½ï¿? EX Ä£ï¿½ï¿½
=======
// Á¬½Ó ID Ä£¿éºÍ ID_EX Ä£¿é
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
wire[`AluSelBus]    id_ex_alu_sel_o;
wire[`RegBus]       id_ex_alu_opnd1_o;
wire[`RegBus]       id_ex_alu_opnd2_o;
wire                id_ex_reg_we_o;
wire[`RegAddrBus]   id_ex_reg_waddr_o;
wire[`RegBus]       id_ex_inst_o;

<<<<<<< HEAD
// ï¿½ï¿½ï¿½ï¿½ EX Ä£ï¿½ï¿½ï¿? EX_MEM Ä£ï¿½ï¿½
wire                ex_mem_we_i;        // ï¿½ï¿½ï¿½ï¿½ ID Ä£ï¿½é£¬ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
wire[`RegAddrBus]   ex_mem_waddr_i;     // ï¿½ï¿½ï¿½ï¿½ ID Ä£ï¿½é£¬ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
wire[`RegBus]       ex_mem_wdata_i;     // ï¿½ï¿½ï¿½ï¿½ ID Ä£ï¿½é£¬ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
=======
// Á¬½Ó EX Ä£¿éºÍ EX_MEM Ä£¿é
wire                ex_mem_we_i;        // ´«»Ø ID Ä£¿é£¬½â¾öÊý¾ÝÏà¹Ø
wire[`RegAddrBus]   ex_mem_waddr_i;     // ´«»Ø ID Ä£¿é£¬½â¾öÊý¾ÝÏà¹Ø
wire[`RegBus]       ex_mem_wdata_i;     // ´«»Ø ID Ä£¿é£¬½â¾öÊý¾ÝÏà¹Ø
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
wire[`AluSelBus]    ex_mem_alu_sel_i;
wire[`RegBus]       ex_mem_ram_addr_i;
wire[`RegBus]       ex_mem_reg_rt_i;

<<<<<<< HEAD
// ï¿½ï¿½ï¿½ï¿½ EX_MEM Ä£ï¿½ï¿½ï¿? MEM Ä£ï¿½ï¿½
=======
// Á¬½Ó EX_MEM Ä£¿éºÍ MEM Ä£¿é
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
wire                ex_mem_we_o;
wire[`RegAddrBus]   ex_mem_waddr_o;
wire[`RegBus]       ex_mem_wdata_o;
wire[`AluSelBus]    ex_mem_alu_sel_o;
wire[`RegBus]       ex_mem_ram_addr_o;
wire[`RegBus]       ex_mem_reg_rt_o;

<<<<<<< HEAD
// ï¿½ï¿½ï¿½ï¿½ MEM Ä£ï¿½ï¿½ï¿? MEM_WB Ä£ï¿½ï¿½
wire                mem_wb_we_i;        // ï¿½ï¿½ï¿½ï¿½ ID Ä£ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ò»ï¿½ï¿½Ö¸ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
wire[`RegAddrBus]   mem_wb_waddr_i;     // ï¿½ï¿½ï¿½ï¿½ ID Ä£ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ò»ï¿½ï¿½Ö¸ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
wire[`RegBus]       mem_wb_wdata_i;     // ï¿½ï¿½ï¿½ï¿½ ID Ä£ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ò»ï¿½ï¿½Ö¸ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?

// ï¿½ï¿½ï¿½ï¿½ MEM_WB Ä£ï¿½ï¿½ï¿? WB Ä£ï¿½ï¿½
=======
// Á¬½Ó MEM Ä£¿éºÍ MEM_WB Ä£¿é
wire                mem_wb_we_i;        // ´«»Ø ID Ä£¿é½â¾ö¸ôÒ»ÌõÖ¸ÁîÊý¾ÝÏà¹Ø
wire[`RegAddrBus]   mem_wb_waddr_i;     // ´«»Ø ID Ä£¿é½â¾ö¸ôÒ»ÌõÖ¸ÁîÊý¾ÝÏà¹Ø
wire[`RegBus]       mem_wb_wdata_i;     // ´«»Ø ID Ä£¿é½â¾ö¸ôÒ»ÌõÖ¸ÁîÊý¾ÝÏà¹Ø

// Á¬½Ó MEM_WB Ä£¿éºÍ WB Ä£¿é
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
wire                mem_wb_we_o;
wire[`RegAddrBus]   mem_wb_waddr_o;
wire[`RegBus]       mem_wb_wdata_o;

<<<<<<< HEAD
// ï¿½ï¿½ï¿½ï¿½ WB Ä£ï¿½ï¿½ï¿? Regfile Ä£ï¿½ï¿½
=======
// Á¬½Ó WB Ä£¿éºÍ Regfile Ä£¿é
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
wire                wb_we;
wire[`RegAddrBus]   wb_waddr;
wire[`RegBus]       wb_wdata;

// ÊµÀý»¯ CTRL Ä£¿é
ctrl ctrl_real(
       .stopreq_from_id_i(stopreq_from_id),
       .stop_o(stop)
     );

// ÊµÀý»¯ PC
pc pc_real(
     .clk(clk),
     .rst(rst),
<<<<<<< HEAD
     // ï¿½ï¿½ï¿½ï¿½ CTRL Ä£ï¿½ï¿½ï¿½ï¿½ï¿½Í£ï¿½Åºï¿?
     .stop_i(stop),

     // ï¿½ï¿½ï¿½ï¿½ ID Ä£ï¿½ï¿½Ä·ï¿½Ö§×ªï¿½ï¿½ï¿½ï¿½Ï?
=======
     // À´×Ô CTRL Ä£¿éµÄÔÝÍ£ÐÅºÅ
     .stop_i(stop),

     // À´×Ô ID Ä£¿éµÄ·ÖÖ§×ªÒÆÐÅÏ¢
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
     .branch_flag_i(branch_flag),
     .branch_target_i(branch_target),
     // Êä³öµ½Ö¸Áî´æ´¢Æ÷ ROM µÄÐÅÏ¢

     .trans_switch_i(trans_switch_i),
     .music_switch_i(music_switch_i),

     .pc_reg(if_id_pc_i),
     .ce(rom_re_o)
   );

assign rom_raddr_o = if_id_pc_i;

// ÊµÀý»¯ IF_ID Ä£¿é
if_id if_id_real(
        .clk(clk),
        .rst(rst),
        .if_pc_i(if_id_pc_i),
        .if_inst_i(rom_rdata_i),
        .id_pc_o(if_id_pc_o),
        .id_inst_o(if_id_inst_o),
<<<<<<< HEAD
        // ï¿½ï¿½ï¿½ï¿½ CTRL Ä£ï¿½ï¿½ï¿½ï¿½ï¿½Í£ï¿½Åºï¿?
        .stop_i(stop),
        // ï¿½ï¿½ï¿½ï¿½ ID Ä£ï¿½ï¿½ï¿½ï¿½ï¿½×ªï¿½ÅºÅ£ï¿½ï¿½ï¿½ï¿½×ªï¿½ï¿½ï¿½ï¿½ï¿?
=======
        // À´×Ô CTRL Ä£¿éµÄÔÝÍ£ÐÅºÅ
        .stop_i(stop),
        // À´×Ô ID Ä£¿éµÄÌø×ªÐÅºÅ£¬½â¾ö×ªÒÆÏà¹Ø
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
        .branch_flag_i(branch_flag)
      );

// ÊµÀý»¯ ID
id id_real(
     .clk(clk),
     .rst(rst),

<<<<<<< HEAD
     // ï¿½ï¿½ï¿½ï¿½ PC Ä£ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
     .inst_i(if_id_inst_o),
     .pc_i(if_id_pc_o),

     // ï¿½ï¿½ï¿½ï¿½ï¿? PC Ä£ï¿½ï¿½ï¿½×ªï¿½ï¿½ï¿½ï¿½Ï?
     .branch_flag_o(branch_flag),
     .branch_target_o(branch_target),

     // ï¿½ï¿½ï¿½ï¿½ Regfile Ä£ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
     .reg_rdata1_i(reg_rdata1),
     .reg_rdata2_i(reg_rdata2),

     // ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ö¸ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
=======
     // À´×Ô PC Ä£¿éµÄÊäÈë
     .inst_i(if_id_inst_o),
     .pc_i(if_id_pc_o),

     // Êä³öµ½ PC Ä£¿éµÄ×ªÒÆÐÅÏ¢
     .branch_flag_o(branch_flag),
     .branch_target_o(branch_target),

     // À´×Ô Regfile Ä£¿éµÄÊäÈë
     .reg_rdata1_i(reg_rdata1),
     .reg_rdata2_i(reg_rdata2),

     // ½â¾öÏàÁÚÖ¸ÁîµÄÊý¾ÝÏà¹Ø
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
     .ex_reg_wdata_i(ex_mem_wdata_i),
     .ex_reg_waddr_i(ex_mem_waddr_i),
     .ex_reg_we_i(ex_mem_we_i),

<<<<<<< HEAD
     // ï¿½ï¿½ï¿½ï¿½ EX Ä£ï¿½ï¿½ï¿½Ö¸ï¿½ï¿½Ñ¡ï¿½ï¿½ï¿½ÅºÅ£ï¿½ï¿½Ð¶ï¿? load ï¿½ï¿½ï¿?
=======
     // À´×Ô EX Ä£¿éµÄÖ¸ÁîÑ¡ÔñÐÅºÅ£¬ÅÐ¶Ï load Ïà¹Ø
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
     .ex_alu_sel_i(ex_mem_alu_sel_i),

     .is_play_end_i(is_play_end_i),
     .uart_finish_i(uart_finish_i),

     .uart_ce_o(uart_ce_o),
     .music_ce_o(music_ce_o),

<<<<<<< HEAD
     // ï¿½ï¿½ï¿½ï¿½ï¿½Ò»ï¿½ï¿½Ö¸ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿?
=======
     // ½â¾ö¸ôÒ»ÌõÖ¸ÁîµÄÊý¾ÝÏà¹Ø
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
     .mem_reg_wdata_i(mem_wb_wdata_i),
     .mem_reg_waddr_i(mem_wb_waddr_i),
     .mem_reg_we_i(mem_wb_we_i),

<<<<<<< HEAD
     // ï¿½ï¿½ï¿½ï¿½ï¿? CTRL Ä£ï¿½ï¿½ï¿½ï¿½ï¿½Ë®ï¿½ï¿½ï¿½ï¿½Í£ï¿½Åºï¿?
     .stopreq_from_id_o(stopreq_from_id),

     // ï¿½ï¿½ï¿½ï¿½ï¿? Regfile Ä£ï¿½ï¿½ï¿½ï¿½ï¿½Ï?
=======
     // Êä³öµ½ CTRL Ä£¿éµÄÁ÷Ë®ÏßÔÝÍ£ÐÅºÅ
     .stopreq_from_id_o(stopreq_from_id),

     // Êä³öµ½ Regfile Ä£¿éµÄÐÅÏ¢
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
     .reg_re1_o(reg_re1),
     .reg_re2_o(reg_re2),
     .reg_raddr1_o(reg_raddr1),
     .reg_raddr2_o(reg_raddr2),

<<<<<<< HEAD
     // ï¿½ï¿½ï¿½ï¿½ï¿? EX Ä£ï¿½ï¿½ï¿½ï¿½ï¿½Ï?
=======
     // Êä³öµ½ EX Ä£¿éµÄÐÅÏ¢
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
     .alu_sel_o(id_ex_alu_sel_i),
     .alu_opnd1_o(id_ex_alu_opnd1_i),
     .alu_opnd2_o(id_ex_alu_opnd2_i),
     .reg_waddr_o(id_ex_reg_waddr_i),
     .reg_we_o(id_ex_reg_we_i),
     .inst_o(id_ex_inst_i)
   );

// ÊµÀý»¯ Regfile
regfile regfile_real(
          .clk(clk),
          .rst(rst),

          // ´Ó WB Ä£¿é´«À´ÐÅÏ¢
          .we_i(wb_we),
          .waddr_i(wb_waddr),
          .wdata_i(wb_wdata),

          // ´Ó ID Ä£¿é´«À´µÄÐÅÏ¢
          .re1_i(reg_re1),
          .re2_i(reg_re2),
          .raddr1_i(reg_raddr1),
          .raddr2_i(reg_raddr2),

<<<<<<< HEAD
          // ï¿½ï¿½ï¿½ï¿½ï¿? ID Ä£ï¿½ï¿½ï¿½ï¿½ï¿½Ï?
=======
          // Êä³öµ½ ID Ä£¿éµÄÐÅÏ¢
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
          .rdata1_o(reg_rdata1),
          .rdata2_o(reg_rdata2)
        );

// ÊµÀý»¯ ID_EX Ä£¿é
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
<<<<<<< HEAD
        // ï¿½ï¿½ï¿½ï¿½ CTRL Ä£ï¿½ï¿½ï¿½ï¿½ï¿½Í£ï¿½Åºï¿?
=======
        // À´×Ô CTRL Ä£¿éµÄÔÝÍ£ÐÅºÅ
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
        .stop_i(stop)
      );

// ÊµÀý»¯ EX Ä£¿é
ex ex_real(
     .rst(rst),

     // ´Ó ID Ä£¿é´«À´µÄÐÅÏ¢
     .inst_i(id_ex_inst_o),
     .alu_sel_i(id_ex_alu_sel_o),
     .alu_opnd1_i(id_ex_alu_opnd1_o),
     .alu_opnd2_i(id_ex_alu_opnd2_o),
     .reg_waddr_i(id_ex_reg_waddr_o),
     .reg_we_i(id_ex_reg_we_o),

<<<<<<< HEAD
     // ï¿½ï¿½ï¿½ï¿½ï¿? MEM Ä£ï¿½ï¿½ï¿½ï¿½ï¿½Ï?
=======
     // Êä³öµ½ MEM Ä£¿éµÄÐÅÏ¢
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
     .reg_waddr_o(ex_mem_waddr_i),
     .reg_we_o(ex_mem_we_i),
     .reg_wdata_o(ex_mem_wdata_i),
     .alu_sel_o(ex_mem_alu_sel_i),
     .ram_addr_o(ex_mem_ram_addr_i),
     .reg_rt_o(ex_mem_reg_rt_i)
   );

// ÊµÀý»¯ EX_MEM Ä£¿é
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
<<<<<<< HEAD
         // ï¿½ï¿½ï¿½ï¿½ CTRL Ä£ï¿½ï¿½ï¿½ï¿½ï¿½Í£ï¿½Åºï¿?
=======
         // À´×Ô CTRL Ä£¿éµÄÔÝÍ£ÐÅºÅ
>>>>>>> 9d83e32732efc4df159bf09ffd139628b133025a
         .stop_i(stop)
       );

// ÊµÀý»¯ MEM Ä£¿é
mem mem_real(
      .rst(rst),

      // ´Ó EX Ä£¿é´«À´µÄÐÅÏ¢
      .ex_waddr_i(ex_mem_waddr_o),
      .ex_we_i(ex_mem_we_o),
      .ex_wdata_i(ex_mem_wdata_o),
      .ex_alu_sel_i(ex_mem_alu_sel_o),
      .ex_ram_addr_i(ex_mem_ram_addr_o),
      .ex_reg_rt_i(ex_mem_reg_rt_o),

      // ´ÓÊý¾Ý´æ´¢Æ÷´«À´µÄÐÅºÅ
      .ram_data_i(ram_data_i),

      // Êä³öµ½ WB Ä£¿éµÄÐÅÏ¢
      .mem_waddr_o(mem_wb_waddr_i),
      .mem_we_o(mem_wb_we_i),
      .mem_wdata_o(mem_wb_wdata_i),

      // Êä³öµ½Êý¾Ý´æ´¢Æ÷µÄÐÅºÅ
      .mem_ram_addr_o(ram_addr_o),
      .mem_ram_we_o(ram_we_o),
      .mem_ram_data_o(ram_data_o),

      .uart_data_i(uart_data_i),
      .music_freq_o(music_freq_o),
      .music_timer_o(music_timer_o),
      .uart_data_recv_end_o(uart_data_recv_end_o)
    );

// ÊµÀý»¯ MEM_WB Ä£¿é
mem_wb mem_wb_real(
         .clk(clk),
         .rst(rst),
         .mem_waddr_i(mem_wb_waddr_i),
         .mem_we_i(mem_wb_we_i),
         .mem_wdata_i(mem_wb_wdata_i),
         .wb_waddr_o(mem_wb_waddr_o),
         .wb_we_o(mem_wb_we_o),
         .wb_wdata_o(mem_wb_wdata_o),
         // À´×Ô CTRL Ä£¿éµÄÔÝÍ£ÐÅºÅ
         .stop_i(stop)
       );

// ÊµÀý»¯ WB Ä£¿é
wb wb_real(
     .rst(rst),

     // ´Ó MEM Ä£¿é´«À´µÄÐÅÏ¢
     .mem_waddr_i(mem_wb_waddr_o),
     .mem_we_i(mem_wb_we_o),
     .mem_wdata_i(mem_wb_wdata_o),

     // Êä³öµ½ Regfile Ä£¿éµÄÐÅÏ¢
     .wb_waddr_o(wb_waddr),
     .wb_we_o(wb_we),
     .wb_wdata_o(wb_wdata)
   );

endmodule
