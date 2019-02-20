//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   dff.v
//   Module name     :   dff
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   D触发器，带同步复位
//********************************************************
module d_ff
(						//模块名及参数定义
input clk,rst,d,	
output reg q,
output wire qb
);

assign qb = ~q;

always @( posedge clk )   //只有clk上升沿时刻触发
	if(!rst)				  //复位信号判断，低有效
		q <= 1'b0;        //复位有效时清零
	else
		q <= d;           //触发时输出q值为输入d

endmodule
