`timescale 1ns / 1ps
module buzzer(
         input wire clk,
         input wire rst,
         input wire [31:0]frequnce,
         output buzzer_out
       );

reg clk_10000;
reg [31:0]cnt;
reg[31:0] fre = 0;


always@(posedge clk or negedge rst)
  begin
    if(fre != frequnce)
      begin
        clk_10000 <= 0;
        cnt <= 1;
        fre <= frequnce;
      end
    if (~rst)
      begin
        clk_10000 <= 0;
        cnt <= 1;
      end
    else
      begin
        if (cnt == fre)
          begin
            clk_10000 <= ~clk_10000;
            cnt <= 0;
          end
        else
          begin
            cnt<=cnt+1;
          end
      end
  end

assign  buzzer_out =clk_10000;

endmodule
