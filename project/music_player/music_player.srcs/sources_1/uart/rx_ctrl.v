`timescale 1ns / 1ps
module rx_ctrl(
    input clk,
    input rst,
    input rx_pin_in,
    input rx_pin_H2L,
    output reg rx_band_sig,
    input rx_clk_bps,
    output reg[31:0]rx_data,
    output reg rx_done_sig
    );
    localparam [5:0] IDLE = 6'd0, BEGIN = 6'd1, DATA0 = 6'd2,
                     DATA1 = 6'd3, DATA2 = 6'd4, DATA3 = 6'd5, 
                     DATA4 = 6'd6, DATA5 = 6'd7, DATA6 = 6'd8, 
                     DATA7 = 6'd9, DATA8 = 6'd10, DATA9 = 6'd11, 
                     DATA10 = 6'd12, DATA11 = 6'd13, DATA12 = 6'd14, 
                     DATA13 = 6'd15, DATA14 = 6'd16, DATA15 = 6'd17, 
                     DATA16 = 6'd18, DATA17 = 6'd19, DATA18 = 6'd20, 
                     DATA19 = 6'd21, DATA20 = 6'd22, DATA21 = 6'd23, 
                     DATA22 = 6'd24, DATA23 = 6'd25, DATA24 = 6'd26, 
                     DATA25 = 6'd27, DATA26 = 6'd28, DATA27 = 6'd29, 
                     DATA28 = 6'd30, DATA29 = 6'd31, DATA30 = 6'd32, 
                     DATA31 = 6'd33, END = 6'd34, BFREE = 6'd35;  
    reg [5:0]pos;
    always @( posedge clk or posedge rst )
        if( rst )
        begin
            rx_band_sig <= 1'b0;
            rx_data <= 32'd0;
            pos <= IDLE;
            rx_done_sig <= 1'b0;
        end
        else
            case( pos )
                IDLE:
                    if( rx_pin_H2L )
                    begin
                        rx_band_sig <= 1'b1;
                        pos <= pos + 1'b1;
                        rx_data <= 32'd0;
                    end
                BEGIN:
                    if( rx_clk_bps )
                    begin
                        if( rx_pin_in == 1'b0 )
                        begin
                            pos <= pos + 1'b1;
                        end
                        else
                        begin
                            rx_band_sig <= 1'b0;
                            pos <= IDLE;
                        end
                    end
                DATA0,DATA1,DATA2,DATA3,DATA4,DATA5,DATA6,DATA7,
                DATA8, DATA9, DATA10, DATA11, DATA12, DATA13, DATA14, DATA15,
                DATA16, DATA17, DATA18, DATA19, DATA20, DATA21, DATA22, DATA23,
                DATA24, DATA25, DATA26, DATA27, DATA28, DATA29, DATA30, DATA31:
                    if( rx_clk_bps )
                    begin
                        rx_data[ pos - DATA0 ] <= rx_pin_in;
                        pos <= pos + 1'b1; 
                    end
                END:
                    if( rx_clk_bps )
                    begin
                        rx_done_sig <= 1'b1;
                        pos <= pos + 1'b1;
                        rx_band_sig <= 1'b0;
                    end
                BFREE:
                begin
                    rx_done_sig <= 1'b0;
                    pos <= IDLE;
                end
            endcase
endmodule
