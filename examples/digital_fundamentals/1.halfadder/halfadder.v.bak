//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   halfadder.v
//   Module name     :   halfadder
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   一位半加器，采用数据流描述方式
//********************************************************

module halfadder
(
input a,             //第一个加数a
input b,             //第二个加数b
output sum,          //显示和的led
output cout          //显示进位的led
);
          
assign sum=a ^ b;     //sum=a⊕b
assign cout=a & b;	  //cout=ab

endmodule
