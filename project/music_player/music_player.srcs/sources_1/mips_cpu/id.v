`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/08/26 15:07:43
// Design Name:
// Module Name: id
// Project Name:
// Target Devices:
// Tool Versions:
// Description: 对指令进行译码，得到运算的类型、源操作数、目标寄存器地址
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module id(
         input   wire    rst,
         input   wire[`InstBus]    inst_i,
         input   wire[`InstAddrBus]   pc_i,

         // regfile 读寄存器端口的操作数，输入到指令译码器中
         input   wire[`RegBus]   reg_rdata1_i,
         input   wire[`RegBus]   reg_rdata2_i,

         input wire[`RegBus]   ex_reg_wdata_i,
         input wire[`RegAddrBus] ex_reg_waddr_i,
         input wire ex_reg_we_i,

         input wire[`RegBus]   mem_reg_wdata_i,
         input wire[`RegAddrBus]  mem_reg_waddr_i,
         input wire mem_reg_we_i,
         input wire[`AluSelBus] ex_alu_sel_i,


         // regfile 读端口的使能信号
         output  reg    reg_re1_o,
         output  reg    reg_re2_o,

         // regfile 读端口的地址
         output  reg[`RegAddrBus]   reg_raddr1_o,
         output  reg[`RegAddrBus]   reg_raddr2_o,

         // 输出到执行阶段的数据
         output  reg[`AluSelBus]     alu_sel_o,
         output  reg[`RegBus]        alu_opnd1_o,
         output  reg[`RegBus]        alu_opnd2_o,
         output  reg[`RegAddrBus]    reg_waddr_o,
         output  reg                 reg_we_o,
         output  wire[`InstBus]       inst_o,

         // 对于分支跳转指令
         output  reg[`InstAddrBus]   branch_target_o,
         output  reg                 branch_flag_o,
         output  wire                stopreq_from_id_o
       );

// 指令是否有效
// reg instvalid;

// 将指令传入 EX 模块
assign  inst_o = inst_i;

// 记录指令中的立即数
reg[`RegBus]    imm;

// 指令解析
wire[5:0] op = inst_i[31:26];
wire[4:0] opnd_rs = inst_i[25:21];      // I or R
wire[4:0] opnd_rt = inst_i[20:16];      // I or R
wire[15:0] opnd_im = inst_i[15:0];      // I
wire[4:0] opnd_rd = inst_i[15:11];      // R
wire[4:0] opnd_sa = inst_i[10:6];       // R
wire[5:0] opnd_func = inst_i[5:0];      // R
wire[25:0] opnd_addr = inst_i[25:0];    // J

// 指令译码
always @(*)
  begin
    alu_sel_o <= `AluSelNop;
    reg_we_o <= `WriteDisable;
    reg_re1_o <= `ReadDisable;
    reg_re2_o <= `ReadDisable;
    reg_waddr_o <= `RegAddrNone;
    reg_raddr1_o <= `RegAddrNone;
    reg_raddr2_o <= `RegAddrNone;
    imm <= `ZeroWord;

    branch_flag_o <= `False;
    branch_target_o <= `ZeroWord;
    case (op)
      `OP_SPECIAL:
        begin
          case (opnd_func)
            `OP_OR:
              begin
                alu_sel_o <= `ALU_OR;
                reg_we_o <= `WriteEnable;
                reg_waddr_o <= opnd_rd;
                reg_re1_o <= `ReadEnable;
                reg_raddr1_o <= opnd_rs;
                reg_re2_o <= `ReadEnable;
                reg_raddr2_o <= opnd_rt;
              end
            `OP_AND:
              begin
                alu_sel_o <= `ALU_AND;
                reg_we_o <= `WriteEnable;
                reg_waddr_o <= opnd_rd;
                reg_re1_o <= `ReadEnable;
                reg_raddr1_o <= opnd_rs;
                reg_re2_o <= `ReadEnable;
                reg_raddr2_o <= opnd_rt;
              end
            `OP_ADD:
              begin
                alu_sel_o <= `ALU_ADD;
                reg_we_o <= `WriteEnable;
                reg_waddr_o <= opnd_rd;
                reg_re1_o <= `ReadEnable;
                reg_raddr1_o <= opnd_rs;
                reg_re2_o <= `ReadEnable;
                reg_raddr2_o <= opnd_rt;
              end
            `OP_XOR:
              begin
                alu_sel_o <= `ALU_XOR;
                reg_we_o <= `WriteEnable;
                reg_waddr_o <= opnd_rd;
                reg_re1_o <= `ReadEnable;
                reg_raddr1_o <= opnd_rs;
                reg_re2_o <= `ReadEnable;
                reg_raddr2_o <= opnd_rt;
              end
            `OP_NOR:
              begin
                alu_sel_o <= `ALU_NOR;
                reg_we_o <= `WriteEnable;
                reg_waddr_o <= opnd_rd;
                reg_re1_o <= `ReadEnable;
                reg_raddr1_o <= opnd_rs;
                reg_re2_o <= `ReadEnable;
                reg_raddr2_o <= opnd_rt;
              end
            `OP_JR:
              begin
                alu_sel_o <= `AluSelNop;
                reg_we_o <= `WriteDisable;
                reg_re1_o <= `ReadEnable;
                reg_raddr1_o <= opnd_rs;
                reg_re2_o <= `ReadDisable;
                branch_flag_o <= `True;
                branch_target_o <= alu_opnd1_o;
              end
            default:
              begin

              end
          endcase
        end
      `OP_LUI:
        begin
          alu_sel_o <= `ALU_OR;
          reg_we_o <= `WriteEnable;
          reg_waddr_o <= opnd_rt;
          reg_re1_o <= `ReadEnable;
          reg_raddr1_o <= opnd_rs;
          reg_re2_o <= `ReadDisable;
          imm <= {opnd_im, 16'b0};
        end
      `OP_ADDIU:
        begin
          alu_sel_o <= `ALU_ADD;
          reg_we_o <= `WriteEnable;
          reg_waddr_o <= opnd_rt;
          reg_re1_o <= `ReadEnable;
          reg_raddr1_o <= opnd_rs;
          reg_re2_o <= `ReadDisable;
          imm <= {16'b0, opnd_im};
        end
      `OP_LW:
        begin
          alu_sel_o <= `ALU_LW;
          reg_we_o <= `WriteEnable;   // 读出的数据写入 rt 寄存器
          reg_waddr_o <= opnd_rt;
          reg_re1_o <= `ReadEnable;   // 存储器地址由 rs 寄存器和指令立即数给出
          reg_raddr1_o <= opnd_rs;
          reg_re2_o <= `ReadDisable;
        end
      `OP_SW:
        begin
          alu_sel_o <= `ALU_SW;
          reg_we_o <= `WriteDisable;
          reg_re1_o <= `ReadEnable;   // 存储器地址由 rs 寄存器和指令立即数给出
          reg_raddr1_o <= opnd_rs;
          reg_re2_o <= `ReadEnable;   // 写入数据由 rt 寄存器给出
          reg_raddr2_o <= opnd_rt;
        end
      `OP_BEQ:
        begin
          alu_sel_o <= `AluSelNop;
          reg_we_o <= `WriteDisable;
          reg_re1_o <= `ReadEnable;
          reg_raddr1_o <= opnd_rs;
          reg_re2_o <= `ReadEnable;
          reg_raddr2_o <= opnd_rt;
          if (reg_rdata1_i == reg_rdata2_i)
            begin
              branch_flag_o <= `True;
              branch_target_o <= pc_i + {{14{inst_i[15]}}, inst_i[15:0], 2'b00};
            end
        end
      `OP_ADDI:
        begin
          alu_sel_o <= `ALU_ADD;
          reg_we_o <= `WriteEnable;
          reg_waddr_o <= opnd_rt;
          reg_re1_o <= `ReadEnable;
          reg_raddr1_o <= opnd_rs;
          reg_re2_o <= `ReadDisable;
          imm <= {{16{inst_i[15]}}, opnd_im};
        end
      `OP_ANDI:
        begin
          alu_sel_o <= `ALU_AND;
          reg_we_o <= `WriteEnable;
          reg_waddr_o <= opnd_rt;
          reg_re1_o <= `ReadEnable;
          reg_raddr1_o <= opnd_rs;
          reg_re2_o <= `ReadDisable;
          imm <= {16'b0, opnd_im};
        end
      `OP_ORI:
        begin
          alu_sel_o <= `ALU_OR;
          reg_we_o <= `WriteEnable;
          reg_waddr_o <= opnd_rt;
          reg_re1_o <= `ReadEnable;
          reg_raddr1_o <= opnd_rs;
          reg_re2_o <= `ReadDisable;
          imm <= {16'b0, opnd_im};
        end
      `OP_XORI:
        begin
          alu_sel_o <= `ALU_XOR;
          reg_we_o <= `WriteEnable;
          reg_waddr_o <= opnd_rt;
          reg_re1_o <= `ReadEnable;
          reg_raddr1_o <= opnd_rs;
          reg_re2_o <= `ReadDisable;
          imm <= {16'b0, opnd_im};
        end
      `OP_J:
        begin
          alu_sel_o <= `AluSelNop;
          reg_we_o <= `WriteDisable;
          reg_re1_o <= `ReadDisable;
          reg_re2_o <= `ReadDisable;
          branch_flag_o <= `True;
          branch_target_o <= {pc_i[31:28], opnd_addr, 2'b00};
        end
      default:
        begin
        end
    endcase
  end

// 获取源操作数 alu_opnd1
always @(*)
  begin
    if (rst == `RstEnable)
      begin
        alu_opnd1_o <= `ZeroWord;
      end
    else if(reg_re1_o == 1'b1 && ex_reg_we_i == 1'b1 && reg_raddr1_o == ex_reg_waddr_i)
      begin
        alu_opnd1_o <= ex_reg_wdata_i;
      end
    else if(reg_re1_o == 1'b1 && mem_reg_we_i == 1'b1 && reg_raddr1_o == mem_reg_waddr_i)
      begin
        alu_opnd1_o <= mem_reg_wdata_i;
      end
    else if (reg_re1_o == `ReadEnable)
      begin
        alu_opnd1_o <= reg_rdata1_i;
      end
    else if (reg_re1_o == `ReadDisable)
      begin
        alu_opnd1_o <= imm;
      end
    else
      begin
        alu_opnd1_o <= `ZeroWord;
      end
  end
// 获取源操作数 alu_opnd2
always @(*)
  begin
    if (rst == `RstEnable)
      begin
        alu_opnd2_o <= `ZeroWord;
      end
    else if(reg_re2_o == 1'b1 && ex_reg_we_i == 1'b1 && reg_raddr2_o == ex_reg_waddr_i)
      begin
        alu_opnd2_o <= ex_reg_wdata_i;
      end
    else if(reg_re2_o == 1'b1 && mem_reg_we_i == 1'b1 && reg_raddr2_o == mem_reg_waddr_i)
      begin
        alu_opnd2_o <= mem_reg_wdata_i;
      end
    else if (reg_re2_o == `ReadEnable)
      begin
        alu_opnd2_o <= reg_rdata2_i;
      end
    else if (reg_re2_o == `ReadDisable)
      begin
        alu_opnd2_o <= imm;
      end
    else
      begin
        alu_opnd2_o <= `ZeroWord;
      end
  end


reg reg1_related;
reg reg2_related;
wire pre_inst_is_load;

assign pre_inst_is_load = ex_alu_sel_i == `ALU_LW ? 1'b1 : 1'b0;

always @(*)
  begin
    reg1_related <= 1'b0;
    if(pre_inst_is_load == 1'b1 && ex_reg_waddr_i == reg_raddr1_o && reg_re1_o == 1'b1)
      begin
      
        reg1_related  <= 1'b1;
      end
  end

always @(*)
  begin
    reg2_related <= 1'b0;
    if(pre_inst_is_load == 1'b1 && ex_reg_waddr_i == reg_raddr2_o && reg_re2_o == 1'b1)
      begin
        reg2_related <= 1'b1;
      end
  end

assign stopreq_from_id_o = reg1_related | reg2_related ;

endmodule
