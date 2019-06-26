// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Lightness
// 
// Author: Step
// 
// Description: Lightness control
// 
// Web: www.ecbcamp.com
//
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2015/11/11   |Initial ver
// --------------------------------------------------------------------
module Lightness
(
input				clk_in,
input				rst_n_in,
input		[2:0]	color,
input				up_pulse,
input				down_pulse,
output	reg			Lightness_out,
output	reg			Lightness_out1
);

localparam	CYCLE_ONE = 5;
localparam	CYCLE_TWO = 10;
localparam	CYCLE_THREE = 15;

reg	[3:0] cycle;
//Control duty cycle
always @(color) begin 
	case(color)
		3'b110: cycle = CYCLE_ONE;
		3'b101: cycle = CYCLE_ONE;
		3'b011: cycle = CYCLE_ONE;
		3'b100: cycle = CYCLE_TWO;
		3'b010: cycle = CYCLE_TWO;
		3'b001: cycle = CYCLE_TWO;
		3'b000: cycle = CYCLE_THREE;
		3'b111: cycle = CYCLE_THREE;
		default: cycle = CYCLE_ONE;
	endcase
end 

reg	[3:0] duty;
//Control duty cycle
always @(posedge clk_in or negedge rst_n_in) begin 
	if(!rst_n_in) begin 
		duty<=4'd2;
	end else begin
		if(up_pulse && (duty<CYCLE_ONE)) duty <= duty + 4'd1;
		else if(down_pulse && (duty>4'd0)) duty <= duty - 4'd1;
		else duty <= duty;
	end
end  

reg	[3:0]	cnt;
//counter for cycle
always @(posedge clk_in or negedge rst_n_in) begin 
	if(!rst_n_in) begin 
		cnt<=4'd0;
	end else begin
		if(cnt>=cycle) cnt<=4'd0;
		else cnt <= cnt + 4'd1;
	end 
end 

//pulse generate with duty
always @(posedge clk_in or negedge rst_n_in) begin 
	if(!rst_n_in) begin 
		Lightness_out<=1'b1;
	end else begin
		if(cnt<=duty) Lightness_out<=1'b1;
		else Lightness_out<=1'b0;
	end 
end 

reg	[3:0]	cnt1;
//counter for cycle
always @(posedge clk_in or negedge rst_n_in) begin 
	if(!rst_n_in) begin 
		cnt1<=4'd0;
	end else begin
		if(cnt1>=CYCLE_ONE) cnt1<=4'd0;
		else cnt1 <= cnt1 + 4'd1;
	end 
end

//pulse generate with duty
always @(posedge clk_in or negedge rst_n_in) begin 
	if(!rst_n_in) begin 
		Lightness_out1<=1'b1;
	end else begin
		if(cnt1<=duty) Lightness_out1<=1'b1;
		else Lightness_out1<=1'b0;
	end 
end

endmodule 