// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Color_led
// 
// Author: Step
// 
// Description: Color_led
// 
// Web: www.ecbcamp.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module Color_led
(
input clk_in,  //clk_in = 25mhz
input rst_n_in,  //rst_n_in, active low
input [3:0] heart_cnt,  //heart_cnt input
output reg [2:0] Color_led_1,  //Color_led output
output reg [2:0] Color_led_2  //Color_led output
);

always@(posedge clk_in or negedge rst_n_in)
	begin
		if(!rst_n_in) begin 
			Color_led_1<=3'b111; Color_led_2<=3'b111;
		end else case (heart_cnt)
			4'd0: begin Color_led_1<=3'b110; Color_led_2<=3'b111; end
			4'd1: begin Color_led_1<=3'b101; Color_led_2<=3'b111; end
			4'd2: begin Color_led_1<=3'b011; Color_led_2<=3'b111; end
			4'd3: begin Color_led_1<=3'b000; Color_led_2<=3'b111; end
			4'd4: begin Color_led_1<=3'b111; Color_led_2<=3'b110; end
			4'd5: begin Color_led_1<=3'b111; Color_led_2<=3'b101; end
			4'd6: begin Color_led_1<=3'b111; Color_led_2<=3'b011; end
			4'd7: begin Color_led_1<=3'b111; Color_led_2<=3'b000; end
			default: begin Color_led_1<=3'b111; Color_led_2<=3'b111; end
		endcase
	end

endmodule
