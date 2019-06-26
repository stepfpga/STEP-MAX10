// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Water_led
// 
// Author: Step
// 
// Description: Water_led
// 
// Web: www.stepfpga.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module Water_led
(
input clk_in,  //clk_in = 12mhz
input rst_n_in,  //rst_n_in, active low
input [3:0] heart_cnt,  //heart_cnt input
output reg [7:0] Water_led  //Water_led output
);

always@(posedge clk_in or negedge rst_n_in)
	begin
		if(!rst_n_in) begin 
			Water_led<=8'b1111_1111;
		end else case (heart_cnt)
			4'd0: Water_led<=8'b1111_1110;
			4'd1: Water_led<=8'b1111_1101;
			4'd2: Water_led<=8'b1111_1011;
			4'd3: Water_led<=8'b1111_0111;
			4'd4: Water_led<=8'b1110_1111;
			4'd5: Water_led<=8'b1101_1111;
			4'd6: Water_led<=8'b1011_1111;
			4'd7: Water_led<=8'b0111_1111;
			default: Water_led<=8'b1111_1111;
		endcase
	end

endmodule
