// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Segment_led
// 
// Author: Step
// 
// Description: Segment_led
// 
// Web: www.ecbcamp.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module Segment_led
(
input [3:0] heart_cnt,  //heart_cnt input
output [8:0] Segment_led_1,  //Segment_led output, MSB~LSB = SPGFEDCBA
output [8:0] Segment_led_2  //Segment_led output, MSB~LSB = SPGFEDCBA
);

reg[8:0] mem [15:0]; 
initial 
	begin
		mem[0] = 9'h3f;   //  0
		mem[1] = 9'h06;   //  1
		mem[2] = 9'h5b;   //  2
		mem[3] = 9'h4f;   //  3
		mem[4] = 9'h66;   //  4
		mem[5] = 9'h6d;   //  5
		mem[6] = 9'h7d;   //  6
		mem[7] = 9'h07;   //  7
		mem[8] = 9'h7f;   //  8
		mem[9] = 9'h6f;   //  9
		mem[10]= 9'h77;   //  A
		mem[11]= 9'h40;   //  b
		mem[12]= 9'h39;   //  C
		mem[13]= 9'h5e;   //  d
		mem[14]= 9'h79;   //  E
		mem[15]= 9'h71;   //  F
	end

assign Segment_led_1 = mem[heart_cnt];
assign Segment_led_2 = mem[heart_cnt];

endmodule
