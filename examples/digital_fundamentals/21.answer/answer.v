//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   answer.v,judge.v,score.v,debounce.v
//						 dseg.v,segment_led.v,divide.v
//   Module name     :   answer
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   竞赛抢答器
//			1，一共4组选手，用开关k1,k2,k3,k4表示，			
//			2，主持人复位开始抢答，获得抢答的选手显示对应led，答题时间超过30秒报警
//	        3，每位选手初始分数5分（RESET复位），主持人控制加分减分按键，每次增加
//			或减少1分（最多9分），答题选手分数显示在数码管
                                       
//********************************************************
module answer
(
input wire clk,rst,             //时钟和复位信号
input wire k1,k2,k3,k4,         //选手开关
input wire reset,add,sub,       //复位分数，加分，减分按键
output wire led1,led2,led3,led4,//选手对应led
output wire buzz,               //报警信号
output wire [8:0] segment_led   //数码管信号
);

wire clk1h;
divide #(					//产生1秒时钟信号
.WIDTH(24),
.N(12000000)
) u1
(
.clk(clk),
.rst_n(rst),
.clkout(clk1h)
);

judge u2                    //判断抢答选手，答题超时报警
(
.clk(clk1h),					
.k1(k1),.k2(k2),.k3(k3),.k4(k4),			
.start(rst),				
.out1(led1),.out2(led2),.out3(led3),.out4(led4),	
.buzz(buzz)					
);

wire [3:0] score1,score2,score3,score4;
score u3                      //主持人控制答题选手分数
(
.clk(clk),.rst(rst),
.add(add),.sub(sub),
.reset(reset),
.c1(led1),.c2(led2),.c3(led3),.c4(led4),
.score1(score1),.score2(score2),.score3(score3),.score4(score4)
);

dseg u4                       //数码管驱动显示答题选手分数
(
.rst(rst),
.c1(led1),.c2(led2),.c3(led3),.c4(led4),
.score1(score1),.score2(score2),.score3(score3),.score4(score4),
.segment_led(segment_led)
);

endmodule