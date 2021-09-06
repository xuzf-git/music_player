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
// Description: 实例化各个模块，创建流水线CPU
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
    output  wire[`RegBus]    ram_data_o
    );

    // 连接 CTRL 模块和其他模块
    wire                    stopreq_from_id;
    wire[5:0]               stop;

    // 连接 PC 模块和 IF_ID 模块
    wire[`RegBus]       if_id_pc_i;

    // 连接 PC 模块和 ID 模块
    wire                branch_flag;
    wire[`RegBus]       branch_target;

    // 连接 IF_ID 模块和 ID 模块
    wire[`RegBus]       if_id_pc_o;
    wire[`RegBus]       if_id_inst_o;

    // 连接 ID 模块和 Regfile 模块
    wire                reg_re1;
    wire                reg_re2;
    wire[`RegBus]       reg_rdata1;
    wire[`RegBus]       reg_rdata2;
    wire[`RegAddrBus]   reg_raddr1;
    wire[`RegAddrBus]   reg_raddr2;

    // 连接 ID 模块和 ID_EX 模块
    wire[`AluSelBus]    id_ex_alu_sel_i;
    wire[`RegBus]       id_ex_alu_opnd1_i;
    wire[`RegBus]       id_ex_alu_opnd2_i;
    wire                id_ex_reg_we_i;
    wire[`RegAddrBus]   id_ex_reg_waddr_i;
    wire[`RegBus]       id_ex_inst_i;

    // 连接 ID_EX 模块和 EX 模块
    wire[`AluSelBus]    id_ex_alu_sel_o;
    wire[`RegBus]       id_ex_alu_opnd1_o;
    wire[`RegBus]       id_ex_alu_opnd2_o;
    wire                id_ex_reg_we_o;
    wire[`RegAddrBus]   id_ex_reg_waddr_o;
    wire[`RegBus]       id_ex_inst_o;
    
    // 连接 EX 模块和 EX_MEM 模块
    wire                ex_mem_we_i;        // 传回 ID 模块，解决数据相关
    wire[`RegAddrBus]   ex_mem_waddr_i;     // 传回 ID 模块，解决数据相关
    wire[`RegBus]       ex_mem_wdata_i;     // 传回 ID 模块，解决数据相关
    wire[`AluSelBus]    ex_mem_alu_sel_i;
    wire[`RegBus]       ex_mem_ram_addr_i;
    wire[`RegBus]       ex_mem_reg_rt_i;
    
    // 连接 EX_MEM 模块和 MEM 模块
    wire                ex_mem_we_o;
    wire[`RegAddrBus]   ex_mem_waddr_o;
    wire[`RegBus]       ex_mem_wdata_o;
    wire[`AluSelBus]    ex_mem_alu_sel_o;
    wire[`RegBus]       ex_mem_ram_addr_o;
    wire[`RegBus]       ex_mem_reg_rt_o;

    // 连接 MEM 模块和 MEM_WB 模块
    wire                mem_wb_we_i;        // 传回 ID 模块解决隔一条指令数据相关
    wire[`RegAddrBus]   mem_wb_waddr_i;     // 传回 ID 模块解决隔一条指令数据相关
    wire[`RegBus]       mem_wb_wdata_i;     // 传回 ID 模块解决隔一条指令数据相关

    // 连接 MEM_WB 模块和 WB 模块
    wire                mem_wb_we_o;
    wire[`RegAddrBus]   mem_wb_waddr_o;
    wire[`RegBus]       mem_wb_wdata_o;

    // 连接 WB 模块和 Regfile 模块
    wire                wb_we;
    wire[`RegAddrBus]   wb_waddr;
    wire[`RegBus]       wb_wdata;

    // 实例化 CTRL 模块
    ctrl ctrl_real(
        .stopreq_from_id_i(stopreq_from_id),
        .stop_o(stop)
    );

    // 实例化 PC
    pc pc_real(
        .clk(clk),
        .rst(rst),
        // 来自 CTRL 模块的暂停信号
        .stop_i(stop),

        // 来自 ID 模块的分支转移信息
        .branch_flag_i(branch_flag),
        .branch_target_i(branch_target),
        // 输出到指令存储器 ROM 的信息
        .pc_reg(if_id_pc_i),
        .ce(rom_re_o)
    );

    assign rom_raddr_o = if_id_pc_i;

    // 实例化 IF_ID 模块
    if_id if_id_real(
        .clk(clk),
        .rst(rst),
        .if_pc_i(if_id_pc_i),
        .if_inst_i(rom_rdata_i),
        .id_pc_o(if_id_pc_o),
        .id_inst_o(if_id_inst_o),
        // 来自 CTRL 模块的暂停信号
        .stop_i(stop),
        // 来自 ID 模块的跳转信号，解决转移相关
        .branch_flag_i(branch_flag)
    );

    // 实例化 ID
    id id_real(
        .rst(rst),  

        // 来自 PC 模块的输入
        .inst_i(if_id_inst_o),
        .pc_i(if_id_pc_o),

        // 输出到 PC 模块的转移信息
        .branch_flag_o(branch_flag),
        .branch_target_o(branch_target),

        // 来自 Regfile 模块的输入
        .reg_rdata1_i(reg_rdata1),
        .reg_rdata2_i(reg_rdata2),

        // 解决相邻指令的数据相关
        .ex_reg_wdata_i(ex_mem_wdata_i),
        .ex_reg_waddr_i(ex_mem_waddr_i),
        .ex_reg_we_i(ex_mem_we_i),

        // 来自 EX 模块的指令选择信号，判断 load 相关
        .ex_alu_sel_i(ex_mem_alu_sel_i),

        // 解决隔一条指令的数据相关
        .mem_reg_wdata_i(mem_wb_wdata_i),
        .mem_reg_waddr_i(mem_wb_waddr_i),
        .mem_reg_we_i(mem_wb_we_i),

        // 输出到 CTRL 模块的流水线暂停信号
        .stopreq_from_id_o(stopreq_from_id),

        // 输出到 Regfile 模块的信息
        .reg_re1_o(reg_re1),
        .reg_re2_o(reg_re2),
        .reg_raddr1_o(reg_raddr1),
        .reg_raddr2_o(reg_raddr2),

        // 输出到 EX 模块的信息
        .alu_sel_o(id_ex_alu_sel_i),
        .alu_opnd1_o(id_ex_alu_opnd1_i),
        .alu_opnd2_o(id_ex_alu_opnd2_i),
        .reg_waddr_o(id_ex_reg_waddr_i),
        .reg_we_o(id_ex_reg_we_i),
        .inst_o(id_ex_inst_i)
    );

    // 实例化 Regfile
    regfile regfile_real(
        .clk(clk),
        .rst(rst),

        // 从 WB 模块传来信息
        .we_i(wb_we),
        .waddr_i(wb_waddr),
        .wdata_i(wb_wdata),

        // 从 ID 模块传来的信息
        .re1_i(reg_re1),
        .re2_i(reg_re2),
        .raddr1_i(reg_raddr1), 
        .raddr2_i(reg_raddr2),

        // 输出到 ID 模块的信息
        .rdata1_o(reg_rdata1),
        .rdata2_o(reg_rdata2)
    );

    // 实例化 ID_EX 模块
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
        // 来自 CTRL 模块的暂停信号
        .stop_i(stop)
    );

    // 实例化 EX 模块
    ex ex_real(
        .rst(rst),

        // 从 ID 模块传来的信息
        .inst_i(id_ex_inst_o),
        .alu_sel_i(id_ex_alu_sel_o),
        .alu_opnd1_i(id_ex_alu_opnd1_o),
        .alu_opnd2_i(id_ex_alu_opnd2_o),
        .reg_waddr_i(id_ex_reg_waddr_o),
        .reg_we_i(id_ex_reg_we_o),

        // 输出到 MEM 模块的信息
        .reg_waddr_o(ex_mem_waddr_i),
        .reg_we_o(ex_mem_we_i),
        .reg_wdata_o(ex_mem_wdata_i),
        .alu_sel_o(ex_mem_alu_sel_i),
        .ram_addr_o(ex_mem_ram_addr_i),
        .reg_rt_o(ex_mem_reg_rt_i)
    );

    // 实例化 EX_MEM 模块
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
        // 来自 CTRL 模块的暂停信号
        .stop_i(stop)
    );

    // 实例化 MEM 模块
    mem mem_real(
        .rst(rst),

        // 从 EX 模块传来的信息
        .ex_waddr_i(ex_mem_waddr_o),
        .ex_we_i(ex_mem_we_o),
        .ex_wdata_i(ex_mem_wdata_o),
        .ex_alu_sel_i(ex_mem_alu_sel_o),
        .ex_ram_addr_i(ex_mem_ram_addr_o),
        .ex_reg_rt_i(ex_mem_reg_rt_o),

        // 从数据存储器传来的信号
        .ram_data_i(ram_data_i),
        
        // 输出到 WB 模块的信息
        .mem_waddr_o(mem_wb_waddr_i),
        .mem_we_o(mem_wb_we_i),
        .mem_wdata_o(mem_wb_wdata_i),

        // 输出到数据存储器的信号
        .mem_ram_addr_o(ram_addr_o),
        .mem_ram_we_o(ram_we_o),
        .mem_ram_data_o(ram_data_o)
    );

    // 实例化 MEM_WB 模块
    mem_wb mem_wb_real(
        .clk(clk),
        .rst(rst),
        .mem_waddr_i(mem_wb_waddr_i),
        .mem_we_i(mem_wb_we_i),
        .mem_wdata_i(mem_wb_wdata_i),
        .wb_waddr_o(mem_wb_waddr_o),
        .wb_we_o(mem_wb_we_o),
        .wb_wdata_o(mem_wb_wdata_o),
        // 来自 CTRL 模块的暂停信号
        .stop_i(stop)
    ); 

    // 实例化 WB 模块
    wb wb_real(
        .rst(rst),

        // 从 MEM 模块传来的信息
        .mem_waddr_i(mem_wb_waddr_o),
        .mem_we_i(mem_wb_we_o),
        .mem_wdata_i(mem_wb_wdata_o),

        // 输出到 Regfile 模块的信息
        .wb_waddr_o(wb_waddr),
        .wb_we_o(wb_we),
        .wb_wdata_o(wb_wdata)
    );
        
endmodule
