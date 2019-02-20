//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   twist.v
//   Module name     :   twist
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   右移扭形计数器
//********************************************************

module twist #
(
parameter  CNT_SIZE = 8
)
(
input clk,rst,           //时钟和复位输入
output reg [CNT_SIZE-1:0] cnt    	  //计数器输出
);

always@(posedge clk)
	if(!rst)
		cnt <= 8'b0000_0001;        //复位初值
	else
		cnt <= {~cnt[0],cnt[CNT_SIZE-1:1]};  //右移循环计数
		
endmodule
