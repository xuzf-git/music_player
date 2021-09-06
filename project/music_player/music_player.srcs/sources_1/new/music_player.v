`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/09/06 10:54:05
// Design Name:
// Module Name: music_player
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


module music_player(
         input wire clk,
         input wire rst,
         output buzzer_out
       );

pipeline pipeline0(
           .clk(clk),
           .rst(rst)
         );

uart uart0(

     );


music music0(

      );

endmodule
