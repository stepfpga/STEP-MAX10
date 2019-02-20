//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   rs_ff.v
//   Module name     :   rs_ff
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   RS触发器
//********************************************************

module rs_ff
( 
input wire clk,r,s,			//rs触发器输入信号		
output reg q,				//输出端口q，在always块里赋值，定义为reg型
output wire qb				//输出端口非q
);

assign qb = ~q;

always@(posedge clk)
	begin
		case({r,s})
			2'b00:  q <= q;        //r,s同时为低电平，触发器保持状态不变
			2'b01:  q <= 1'b1;	   //触发器置1状态
			2'b10:  q <= 1'b0;     //触发器置0状态
			2'b11:  q <= 1'bx;     //r,s同时为高电平有效，逻辑矛盾，触发器为不定态
		endcase
	end
endmodule 
