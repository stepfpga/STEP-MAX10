//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   score.v,debounce.v
//   Module name     :   score
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   计分模块
//					主持人可复位选手分数，根据抢答选手的号码判断输出的分数，同时可加减分	
//********************************************************
module score
(
input wire clk,rst,
input wire add,sub,               //加分减分
input wire reset,                 //复位选手分数
input wire c1,c2,c3,c4,           //答题选手
output reg [3:0] score1,score2,score3,score4 //答题选手分数
);

wire reset_k,add_k,sub_k;         //消抖后按键输出
wire reset_p,add_p,sub_p;         //消抖后按键按下脉冲信号

debounce #                        //按键消抖
(
.KEY_WIDTH(3),
.CNT_NUM(19'd240000)
) u1
(
.clk(clk),			
.rst_n(rst),	
.key_n({reset,add,sub}),			
.key_jit({reset_k,add_k,sub_k}),
.key_pulse({reset_p,add_p,sub_p})
); 

always@(posedge clk )
	begin
		if(!reset_k)begin            //复位选手分数
			score1 = 4'd5;
			score2 = 4'd5;
			score3 = 4'd5;
			score4 = 4'd5;
			end
		else
			begin
				if(c1 == 0)          //判断是否该选手答题
					begin
						if(add_p == 1)   //判断加分按键
							begin 
								if(score1>4'd9)
									score1 = 0;  //分数超过9分，清零
								else
									score1 = score1 + 1'b1; //加1分
							end
						else if(sub_p == 1)//判断减分按键
							begin
								if(score1!=4'b0000)
									score1 = score1 -1'b1;
								else
									score1 = 0;
							end
						else
							score1 = score1;
					end
				else
					score1 = score1;
				if(c2 == 0)
					begin
						if(add_p == 1)
							begin 
								if(score2>4'd9)
									score2 = 0;
								else
									score2 = score2 + 1'b1;
							end
						else if(sub_p == 1)
							begin
								if(score2!=4'b0000)
									score2 = score2 - 1'b1;
								else
									score2 = 0;
							end
						else
							score2 = score2;
					end
				else
					score2 = score2;
				if(c3 == 0)
					begin
						if(add_p == 1)
							begin 
								if(score3>4'd9)
									score3 = 0;
								else
									score3 = score3 + 1'b1;
							end
						else if(sub_p == 1)
							begin
								if(score3!=4'b0000)
									score3 = score3 - 1'b1;
								else
									score3 = 0;
							end
						else
							score3 = score3;
					end
				else
					score3 = score3;
				if(c4 == 0)
					begin
						if(add_p == 1)
							begin 
								if(score4>4'd9)
									score4 = 0;
								else
									score4 = score4 + 1'b1;
							end
						else if(sub_p == 1)
							begin
								if(score4!=4'b0000)
									score4 = score4 - 1'b1;
								else
									score4 = 0;
							end
						else
							score4 = score4;
					end
				else
					score4 = score4;
			end
	end
	
endmodule
			
			
					
							
			