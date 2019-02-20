//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   voter3.v
//   Module name     :   voter3
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   3变量的多数表决电路
//						当3个输入端中有2个及以上输入1时，输出端才为“1”
//********************************************************

module voter3
(
input wire a,           //3个输入变量a、b、c
input wire b,
input wire c,
output wire led         //显示表决结果led
);
          
assign 	led = (a&b)|(b&c)|(a&c);   //根据逻辑表达式得到表决结果

endmodule
