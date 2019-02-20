//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   mult4.v
//   Module name     :   mult4
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   4选1多路选择器
//********************************************************

module mult4
(
input wire a,           //定义四位输入
input wire b,
input wire c,
input wire d,
input wire [1:0]  sel,  //定义输出的选择变量
output reg  led    	   //定义选择器输出结果对应的led
);

always@(sel)           //根据sel结果选择输出，当sel变化时执行
	begin
		case(sel)
			2'b00: led = a;
			2'b01: led = b;
			2'b10: led = c;
			2'b11: led = d;
		endcase
	end

endmodule
