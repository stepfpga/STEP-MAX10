//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   adder1.v
//   Module name     :   adder1
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   一位全加器，采用结构化描述方式
//********************************************************

module adder1
(
input wire a,           //输入的低位进位及两个加数cin、a、b
input wire b,
input wire cin,
output wire sum,        //输出的和与进位
output wire cout
);
          
wire 		s1,s2,s3;   //定义中间变量


xor (sum,a,b,cin);      //调用基本异或门
and (s1,a,cin);			//调用基本与门
and (s2,b,cin);
and (s3,a,b);
or (cout,s1,s2,s3);     //调用基本或门

endmodule
