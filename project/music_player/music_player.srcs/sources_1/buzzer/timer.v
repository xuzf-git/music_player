`timescale 1ns / 1ps
module timer (
         input clk,
         input rst,
         input wire[31:0] last_time,
         output reg time_out
       );

reg[31:0] time_reg = 0;
reg[31:0] cnt;

always @(posedge clk)
  begin

    if(~rst)
      begin
        time_reg <= 0;
        time_out <= 0;
        cnt <= 32'hffffffff;
      end
    else
      begin
        time_out <= 0;
        if((time_reg != last_time) && (last_time != 0))
          begin
            time_reg <= last_time;
            cnt = last_time * 100000;
          end
        else
          begin
            if(cnt == 0)
              begin
                time_out <= 1;
                cnt = time_reg * 100000;
              end
            else
              begin
                cnt <= cnt - 1;
              end
          end
      end
  end


endmodule
