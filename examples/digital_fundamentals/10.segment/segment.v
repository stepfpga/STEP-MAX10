// Description: Segment_led//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   segment.v
//   Module name     :   segment
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   数码管驱动显示。
//						MSB~LSB = SEG,DP,G,F,E,D,C,B,A
//						seg共阴极端，DP小数点，G,F,E,D,C,B,A 七段LED
//********************************************************

module segment
(
input  wire [3:0] seg_data_1,  //四位输入数据信号
input  wire [3:0] seg_data_2,  //四位输入数据信号
output wire [8:0] segment_led_1,  //数码管1，MSB~LSB = SEG,DP,G,F,E,D,C,B,A
output wire [8:0] segment_led_2   //数码管2，MSB~LSB = SEG,DP,G,F,E,D,C,B,A
);

reg[8:0] seg [15:0];           //存储7段数码管译码数据
initial 
	begin
		seg[0] = 9'h3f;   //  0
		seg[1] = 9'h06;   //  1
		seg[2] = 9'h5b;   //  2
		seg[3] = 9'h4f;   //  3
		seg[4] = 9'h66;   //  4
		seg[5] = 9'h6d;   //  5
		seg[6] = 9'h7d;   //  6
		seg[7] = 9'h07;   //  7
		seg[8] = 9'h7f;   //  8
		seg[9] = 9'h6f;   //  9
		seg[10]= 9'h77;   //  A
		seg[11]= 9'h7C;   //  b
		seg[12]= 9'h39;   //  C
		seg[13]= 9'h5e;   //  d
		seg[14]= 9'h79;   //  E
		seg[15]= 9'h71;   //  F
	end

assign segment_led_1 = seg[seg_data_1];
assign segment_led_2 = seg[seg_data_2];

endmodule
