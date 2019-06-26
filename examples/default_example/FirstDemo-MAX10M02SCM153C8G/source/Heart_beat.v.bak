// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Heart_beat
// 
// Author: Step
// 
// Description: Heart_beat
// 
// Web: www.ecbcamp.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module Heart_beat
(
input direction,  //switch key
input clk_1hz_in,  //clk_1hz_in
input rst_n_in,  //rst_n_in, active low
output reg [3:0] heart_cnt  //heart_cnt output
);

//heart_cnt cycle from 0 to 7
always@(posedge clk_1hz_in or negedge rst_n_in)
	begin
		if(!rst_n_in) heart_cnt<=4'd0;
		else if(direction==1'b1) begin
			if(heart_cnt==4'd7) heart_cnt<=4'd0;
			else heart_cnt<=heart_cnt+4'd1;  
		end else if(direction==1'b0) begin
			if(heart_cnt==4'd0) heart_cnt<=4'd7;
			else heart_cnt<=heart_cnt-4'd1;  
		end
	end

endmodule
