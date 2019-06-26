/**************************************************
module: Clock_div
author: wanganran
description: clock divide, generate pulse and 50 percent clock_div
input: clk_in,rst_n_in
output: clk_div_pulse_out,clk_div_50per_out
date: 2015.10.23
**************************************************/
module Clock_div
(
input clk_in,  //clk_in = 12mhz
input rst_n_in,  //rst_n_in, active low
input  [3:0] SW,  //switch key
output reg clk_div_pulse_out  //clock divide output, duty cycle = 1/CLK_DIV_PULSE_PERIOD(one clk_in period)
);

reg [24:0] PULSE_PERIOD = 12500000;
always@(SW)
	case(SW)
		4'b0000:PULSE_PERIOD = 6250000;
		4'b1111:PULSE_PERIOD = 25000000;
		default:PULSE_PERIOD = 12500000;
	endcase
	
//clk_div_pulse_out = clk_in/CLK_DIV_PULSE_PERIOD, duty cycle is 1/CLK_DIV_PULSE_PERIOD(one clk_in period)
reg[24:0] cnt1=0;
always@(posedge clk_in or negedge rst_n_in)
	begin
		if(!rst_n_in) 
			begin 
				cnt1<=0;
				clk_div_pulse_out<=0;
			end
		else if(cnt1>=((PULSE_PERIOD>>1)-1)) 
			begin
				cnt1<=0;
				clk_div_pulse_out<=~clk_div_pulse_out;
			end
		else begin
			cnt1<=cnt1+1; 
		end
	end

endmodule
