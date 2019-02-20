//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   parity4.v
//   Module name     :   parity4
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   4位奇偶校验器电路。要求当输入的4位二进制码
//						中有奇数个“1”时，输出为“1”，否则输出为“0”
//********************************************************

module parity4
(
input wire a,b,c,d,           //定义4个输入
output wire led    	  		//定义奇偶校验输出结果对应的led
);
          
assign led = a^b^c^d;		//根据逻辑表达式赋值

endmodule
