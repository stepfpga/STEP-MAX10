//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   voter4.v
//   Module name     :   voter4
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   4变量（A、B、C、D）多数表决器，4个输入中A代表2，B、C、D分别
//						代表1，当输入数值大于或者等于3时，输出高电平，否则，输出低电平。
//********************************************************

module voter4
(
input wire a,           //定义输入的低位进位及两个加数a、b、c、d
input wire b,
input wire c,
input wire d,
output wire led        //定义显示输出结果的led
);
          
assign led = (a&b)|(a&c)|(a&d)|(b&c&d);    //根据逻辑表达式赋值

endmodule
