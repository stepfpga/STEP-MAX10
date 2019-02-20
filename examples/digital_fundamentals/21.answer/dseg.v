//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   dseg.v
//   Module name     :   dseg
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   数码管显示模块
//					根据抢答选手的分数显示在数码管	
//********************************************************
module dseg
(
input wire rst,
input wire c1,c2,c3,c4,          //抢答选手
input wire [3:0] score1,score2,score3,score4, //抢答选手分数
output wire [8:0] segment_led
);

reg [3:0] score;

always@(rst or c1 or c2 or c3 or c4 or score1 or score2 or score3 or score4)
	begin
		if(!rst)            
			score = 4'b1111;   //复位时，数码管不亮
		else if(!c1)
			score = score1;    //抢答选手为1号时显示1号选手分数
		else if(!c2)
			score = score2;
		else if(!c3)
			score = score3;
		else if(!c4)
			score = score4;
		else
			score = 4'b1111;
	end
segment_led  u1                    //驱动数码管
(
.seg_data_1(),  
.seg_data_2(score),  
.segment_led_1(),  
.segment_led_2(segment_led)   
);

endmodule

	