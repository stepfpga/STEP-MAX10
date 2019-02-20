//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   stepmotor1.v,divide.v
//   Module name     :   stepmotor1
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   控制四相绕组的步进电机电机正转、反转、停止的控制电路。
//						电机运转规律为：正转30s→停10s→反转30s→停10s→正转30s……
//						三色led显示转动状态：正转：RGBLED1亮
//										  反转：RGBLED2亮
//                                        停止：同时亮

//********************************************************
module stepmotor1
(
input wire clk,rst,
output wire [5:0] led
);

wire 	clk1h;				//1秒时钟
reg	[5:0] dir;				//电机转动方向控制。正转000111，反转111000，停止000000
reg	[5:0] timecont;			//计时

parameter 	S1 = 2'b00,		//电机工作状态 正转
			S2 = 2'b01,		//停止
			S3 = 2'b10;		//反转
			
			
parameter	TIME_S1 = 6'd30,	//正转计时30秒
			TIME_S2 = 6'd10, 	//停止计时10秒
			TIME_S3 = 6'd30;	//反转计时30秒
			
reg [1:0] cur_state,next_state;	
			
divide #(					//产生1秒时钟信号
.WIDTH(24),
.N(12000000)
) u1
(
.clk(clk),
.rst_n(rst),
.clkout(clk1h)
);

always@(posedge clk1h or negedge rst)        //第一段
	if(!rst)
		cur_state <= S1;
    else 
	    cur_state <= next_state;

always@(cur_state or rst or timecont)        //第二段，状态转移
	if(!rst)
		begin
			next_state = S1;
		end
	else
		begin
			case(cur_state)				     //判断当前状态
				S1:begin
					if(timecont == 1)        //计时结束跳转到S2，否则保持S1
						next_state = S2;
					else
						next_state = S1;
					end
				S2:begin
					if(timecont == 1)		//计时结束跳转到S3，否则保持S2
						next_state = S3;
					else
						next_state = S2;
					end
				S3:begin
					if(timecont == 1)        //计时结束跳转到S2，否则保持S3
						next_state = S2;
					else
						next_state = S3;
					end
				default:next_state = next_state;
			endcase
		end

always@(posedge clk1h or negedge rst)			//第三段，当前状态输出
	if(!rst)
		begin
			timecont <= TIME_S1;
			dir <= 6'b000111;
		end
	else
		begin
			case(next_state)
				S1:begin
					dir <= 6'b000111;           //正转状态输出
					if(timecont == 1)			//计时控制		
						timecont <= TIME_S1;    //计时结束赋新的值
					else
						timecont <= timecont - 1;//计时减1
					end
				S2:begin
					dir <= 6'b000000;
					if(timecont == 1)
						timecont <= TIME_S2;
					else
						timecont <= timecont - 1;
					end
				S3:begin
					dir <= 6'b111000;
					if(timecont == 1)
						timecont <= TIME_S3;
					else
						timecont <= timecont - 1;
					end
				default:begin
							dir <= 6'b000111;
							timecont <= TIME_S1;
						end
			endcase
		end
assign 	led = dir;		             //状态输出动作对应的led

endmodule
