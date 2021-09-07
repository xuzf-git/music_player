// `timescale 1ns / 1ps
// module music (
//          input wire clk,
//          input wire rst,
//          input wire music_ce_i,
//          input wire[31:0] music_freq_i,
//          input wire[31:0] music_timer_i,

//          output wire is_play_end_o,
//          output wire buzzer_out
//        );

// reg t=0;
// reg[10:0] cnt = 0;

// assign is_play_end_o = t;

// always @(posedge clk)
//   begin
//     if(cnt == 10)
//       begin
//         t=~t;
//         cnt = 0;
//       end
//     else
//       begin
//           cnt= cnt+1;
//       end
//   end


// endmodule

`timescale 1ns / 1ps
module music(
         input wire clk,
         input wire rst,
         input wire music_ce_i,             // 蜂鸣器模块使能信号
         input wire [31:0] music_freq_i,    // 频率（方波的半周期）
         input wire [31:0] music_timer_i,   // 播放时长 单位ns    (clk 10ns)
         output  is_play_end_o,             // 蜂鸣器播放完毕信号
         output  buzzer_out                 // 蜂鸣器工作信号
       );

reg clk_10000;    //0或1 发出特定频率方波 工作信号
reg this_over;    //0或1 蜂鸣器播放完毕信号
reg [31:0] cnt;
reg [31:0] play_time=0;
reg [31:0] fre = 0;


always@(posedge clk)
  begin
    if(fre != music_freq_i)   //CPU传来了最新的(time, frequency)
      begin
        clk_10000 <= 0;
        this_over <= 0;
        cnt <= 1;
        fre <= music_freq_i;                 //频率（方波半周期时长）
        play_time <= music_timer_i;
      end
    if (~rst)
      begin
        clk_10000 <= 0;
        cnt <= 1;
      end
    else    
      begin
        if(play_time == 0)       //播放时间用完
          begin
            this_over <= 1;      //修改蜂鸣器播放完毕信号
          end
        else  //else 继续播放此频率的方波
          begin
            play_time <= (play_time-1);  //播放时间减去一个clk
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
  end

assign  is_play_end_o =this_over;   // 播放完毕信号
assign  buzzer_out =clk_10000;      // 工作信号

endmodule
