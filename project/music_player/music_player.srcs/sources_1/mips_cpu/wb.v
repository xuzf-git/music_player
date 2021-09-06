`timescale 1ns / 1ps
`include "defines.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/28 15:42:16
// Design Name: 
// Module Name: wb
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

module wb(
	input wire                   rst,

	//来自 MEM 的信息	
	input wire[`RegAddrBus]     mem_waddr_i,
	input wire                  mem_we_i,
	input wire[`RegBus]         mem_wdata_i,

	//送到 Regfile 的信息
	output reg[`RegAddrBus]     wb_waddr_o,
	output reg                  wb_we_o,
	output reg[`RegBus]         wb_wdata_o	       
	
    );

	always @ (*) begin
		if(rst == `RstEnable) begin
            wb_waddr_o <= `RegAddrNone;
			wb_we_o <= `WriteDisable;
            wb_wdata_o <= `ZeroWord;	
		end else begin
			wb_waddr_o <= mem_waddr_i;
			wb_we_o <= mem_we_i;
			wb_wdata_o <= mem_wdata_i;
		end 
	end
endmodule
