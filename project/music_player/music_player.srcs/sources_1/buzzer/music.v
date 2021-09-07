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
         input wire music_ce_i,             // ������ģ��ʹ���ź�
         input wire [31:0] music_freq_i,    // Ƶ�ʣ������İ����ڣ�
         input wire [31:0] music_timer_i,   // ����ʱ�� ��λns    (clk 10ns)
         output  is_play_end_o,             // ��������������ź�
         output  buzzer_out                 // �����������ź�
       );

reg clk_10000;    //0��1 �����ض�Ƶ�ʷ��� �����ź�
reg this_over;    //0��1 ��������������ź�
reg [31:0] cnt;
reg [31:0] play_time=0;
reg [31:0] fre = 0;


always@(posedge clk)
  begin
    if(fre != music_freq_i)   //CPU���������µ�(time, frequency)
      begin
        clk_10000 <= 0;
        this_over <= 0;
        cnt <= 1;
        fre <= music_freq_i;                 //Ƶ�ʣ�����������ʱ����
        play_time <= music_timer_i;
      end
    if (~rst)
      begin
        clk_10000 <= 0;
        cnt <= 1;
      end
    else    
      begin
        if(play_time == 0)       //����ʱ������
          begin
            this_over <= 1;      //�޸ķ�������������ź�
          end
        else  //else �������Ŵ�Ƶ�ʵķ���
          begin
            play_time <= (play_time-1);  //����ʱ���ȥһ��clk
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

assign  is_play_end_o =this_over;   // ��������ź�
assign  buzzer_out =clk_10000;      // �����ź�

endmodule
