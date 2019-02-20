//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   jk_ff.v
//   Module name     :   jk_ff
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   同步jk触发器，带异步复位和置位
//********************************************************
module jk_ff
(						//模块名及参数定义
input clk,j,k,rst,set,	
output reg q,
output wire qb
);

assign qb = ~q;
//clk上升沿以及复位和置位下降沿时触发器工作
always@(posedge clk or negedge rst or negedge set)
	begin
		if(!rst)
			q <= 1'b0;			// 异步清零
		else if (!set)
			q <= 1'b1;  		// 异步置1
		else
			case({j,k})
				2'b00:		q <= q;		//保持
				2'b01:		q <= 0;		//置0
				2'b10:		q <= 1;		//置1
				2'b11:		q <= ~q;	//翻转
			endcase
	end
endmodule