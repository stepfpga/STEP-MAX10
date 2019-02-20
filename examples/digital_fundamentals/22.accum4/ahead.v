//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   ahead.v
//   Module name     :   ahead
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   超前进位逻辑产生 
//				JK触发器：Qi+1=J!Qi+!KQi
//				全加器进位：Ci+1=AiBi+(Ai+Bi)Ci=AiBi!Ci+!(Ai+Bi)Ci
//				推导得出：J=AiBi，K=!(Ai+Bi)
//********************************************************
module ahead
(
input wire a,b,clk,rst,
output wire q
);

wire j,k;

jk_ff  u1              //例化JK触发器
(						
.clk(clk),.j(j),.k(k),.rst(rst),.set(),	
.q(q),
.qb()
);

assign j = a&b;        //根据推导得到J,K与加法器输入信号逻辑关系
assign k = ~(a|b);

endmodule