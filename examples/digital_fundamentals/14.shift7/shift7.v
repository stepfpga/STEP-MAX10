//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   shift7.v
//   Module name     :   shift7
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   7位移位寄存器，右移并行输入，串行输出
//********************************************************

module shift7
(
input wire clk,           //输入时钟
input wire rst,			  //复位信号
input wire [6:0] datain,  //并行输入数据
output wire  dataout 	  //串行输出数据
);

reg [6:0] data;

always @(posedge clk)
	if(!rst)
		data <= datain;			//同步复位，复位时并行数据存入变量data
	else
		begin
			data[6] <= 1'b0;		//最高为补0
			data[5] <= data[6];
			data[4] <= data[5];
			data[3] <= data[4];
			data[2] <= data[3];
			data[1] <= data[2];
			data[0] <= data[1];     //右移一位
		end
		
assign dataout = data[0];		//串行输出

endmodule
