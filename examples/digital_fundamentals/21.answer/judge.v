//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   judge.v
//   Module name     :   judge
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   抢答信号判断模块
//					判断选手抢答信号，当有选手抢答后屏蔽其他选手抢答，选手答题超过	
//					30秒输出报警信号
//********************************************************
module judge
(
input wire clk,					//时钟信号
input wire k1,k2,k3,k4,			//抢答按钮信号
input wire start,				//开始抢答信号
output reg out1,out2,out3,out4,	//抢答显示信号
output reg buzz					//报警信号
);

reg		block;               //屏蔽标志，为1时屏蔽选手判断抢答
reg		flag;                //报警标志
reg [6:0]count;              //计时计数器

always@(posedge clk)
	begin
		if(!start)
			begin
				block = 1'b0;        //初始标志清0，可以判断抢答
				{out1,out2,out3,out4} = 4'b1111;//初始选手led不亮
				count = 1'b0;        //计时清零
				flag = 1'b1;         //报警标志清零
			end
		else
			begin
				if(k1)               //判断抢答输入
					begin 
						if(!block)   //k1抢答，判断屏蔽标志
							begin 
								out1 = 1'b0;  //对应选手led电亮
								block = 1'b1; //k1抢答，设置屏蔽标志
								count = 1'b1; //计时器赋值1，开始计数
							end
					end
				else if(k2)
					begin 
						if(!block)
							begin 
								out2 = 1'b0;
								block = 1'b1;
								count = 1'b1;
							end
					end	
				else if(k3)
					begin 
						if(!block)
							begin 
								out3 = 1'b0;
								block = 1'b1;
								count = 1'b1;
							end
					end	
				else if(k4)
					begin 
						if(!block)
							begin 
								out4 = 1'b0;
								block = 1'b1;
								count = 1'b1;
							end
					end
				else
					begin
						block = 1'b0;
						{out1,out2,out3,out4} = 4'b1111;
						count = 1'b0;
						flag = 1'b1;
					end
						
				if(count!=0)          //计时器不为零时开始计数
					begin
						if(count == 6'd30)  //超过30秒计数清零，输出报警信号
							begin
								flag = 1'b0;
								count = 1'b0;
							end
						else
							count = count + 1'b1;
					end
			end
	end
always@(flag)
	if(flag == 1)
		buzz = 1'b1;
	else
		buzz = 1'b0;

endmodule
