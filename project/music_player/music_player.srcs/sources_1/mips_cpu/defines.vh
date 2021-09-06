//******************  ȫ�ֺ궨��  ******************
`define RstEnable       1'b1    // ��λ�ź���Ч
`define RstDisable      1'b0    // ��λ�ź���Ч
`define ZeroWord        32'b0   // 32λ����ֵ 0
`define WriteEnable     1'b1    // ʹ��д
`define WriteDisable    1'b0    // ��ֹд
`define ReadEnable      1'b1    // ʹ�ܶ�
`define ReadDisable     1'b0    // ��ֹ��
`define InstValid       1'b1    // ָ����Ч
`define InstInvalid     1'b0    // ָ����Ч
`define True            1'b1    // �߼���
`define False           1'b0   // �߼���
`define ChipEnable      1'b1    // оƬʹ��
`define ChipDisable     1'b0    // оƬ��ֹ

//******************  ָ��洢����صĺ궨��  ******************
`define InstAddrBus     31:0    // ָ��洢����ַ���߿��
`define InstBus         31:0    // ָ��洢���������߿��

//*******************  �Ĵ�����صĺ궨��  ********************
`define RegNum          32       // �Ĵ�������
`define RegAddrBusNum   5        // �Ĵ�����ַ���߸���
`define RegAddrNone     5'b0     // �Ĵ�����ַ���߿��
`define RegAddrBus      4:0      // �Ĵ�����ַ���߿��
`define RegBus          31:0     // �Ĵ������������߿��

//********************  ALU ��صĺ궨��  ********************
`define AluSelBus       7:0     // alu ����ѡ���ź�
`define AluSelNop       8'b0    // alu �޲���

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

