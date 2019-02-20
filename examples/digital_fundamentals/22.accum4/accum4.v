//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   accum4.v
//   Module name     :   accum4
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   4位串行累加器
//               用移位寄存器和一位全加器以及JK触发器构成串行累加器    
//********************************************************
module accum4
(
input wire datain,     //数据输入
input wire clk,rst,    //脉冲和输入信号
output wire [3:0] sum  //累加结果
);

wire [3:0] adder;      //寄存器1，存储输入加数内容
wire [3:0] sumer;      //寄存器2，存储被加数内容
wire cin;              //全加器超前进位信号
wire sumout;           //全加器输出

assign sum = sumer;    //累加结果输出

shift u1               //移位寄存器，把数据存入加数寄存器
(
.clk(clk),           
.rst(rst),			 
.datain(datain),  
.dataout(adder) 	
);

adder1 u2              //全加器，两个寄存器的最低位相加，进位由超前进位逻辑输出
(
.a(sumer[0]),           
.b(adder[0]),
.cin(cin),
.sum(sumout),     
.cout()
);

ahead u3              //超前进位逻辑，产生进位信号
(
.a(sumer[0]),.b(adder[0]),.clk(clk),.rst(rst),
.q(cin)
);

shift u4              //移位寄存器，将全加器结果存入被加数寄存器
(
.clk(clk),           
.rst(rst),			  
.datain(sumout),  
.dataout(sumer) 	  
);

endmodule
