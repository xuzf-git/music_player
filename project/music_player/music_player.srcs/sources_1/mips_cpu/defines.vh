//******************  全局宏定义  ******************
`define RstEnable       1'b1    // 复位信号有效
`define RstDisable      1'b0    // 复位信号无效
`define ZeroWord        32'b0   // 32位的数值 0
`define WriteEnable     1'b1    // 使能写
`define WriteDisable    1'b0    // 禁止写
`define ReadEnable      1'b1    // 使能读
`define ReadDisable     1'b0    // 禁止读
`define InstValid       1'b1    // 指令有效
`define InstInvalid     1'b0    // 指令无效
`define True            1'b1    // 逻辑真
`define False           1'b0   // 逻辑假
`define ChipEnable      1'b1    // 芯片使能
`define ChipDisable     1'b0    // 芯片禁止

//******************  指令存储器相关的宏定义  ******************
`define InstAddrBus     31:0    // 指令存储器地址总线宽度
`define InstBus         31:0    // 指令存储器数据总线宽度

//*******************  寄存器相关的宏定义  ********************
`define RegNum          32       // 寄存器个数
`define RegAddrBusNum   5        // 寄存器地址总线根数
`define RegAddrNone     5'b0     // 寄存器地址总线宽度
`define RegAddrBus      4:0      // 寄存器地址总线宽度
`define RegBus          31:0     // 寄存器器数据总线宽度

//********************  ALU 相关的宏定义  ********************
`define AluSelBus       7:0     // alu 操作选择信号
`define AluSelNop       8'b0    // alu 无操作

`define OP_SPECIAL     6'b000000
`define OP_J           6'b000010
`define OP_BEQ         6'b000100
`define OP_ADDI        6'b001000
`define OP_ADDIU       6'b001001
`define OP_SW          6'b101011
`define OP_LUI         6'b001111
`define OP_LW          6'b100011
`define OP_ADD         6'b100000   // sepcial 000000-100000
`define OP_AND         6'b100100   // sepcial 000000-100100
`define OP_OR          6'b100101   // sepcial 000000-100101
`define OP_XOR         6'b100110   // sepcial 000000-100110
`define OP_NOR         6'b100111   // sepcial 000000-100111
`define OP_JR          6'b001000
`define OP_ANDI        6'b001100
`define OP_ORI         6'b001101
`define OP_XORI        6'b001110

`define ALU_ADD         8'h01
`define ALU_AND         8'h02
`define ALU_OR          8'h03
`define ALU_NOR         8'h04
`define ALU_XOR         8'h05
`define ALU_LW          8'h06
`define ALU_SW          8'h07

