//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   shift.v
//   Module name     :   shift
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   4位移位寄存器，右移串行输入，并行输出
//********************************************************

module shift
(
input wire clk,           //输入时钟
input wire rst,			  //复位信号
input wire datain,  	  //串行输入数据
output wire  [3:0] dataout 	  //并行输出数据
);

reg [3:0] data;

always @(posedge clk)
	if(!rst)
		data <= 0;			//同步复位，复位时并行数据存入变量data
	else
		begin
			data[3] <= datain;		//移入
			data[2] <= data[3];
			data[1] <= data[2];
			data[0] <= data[1];		//右移一位
		end
		
assign dataout = data;		//并行输出

endmodule