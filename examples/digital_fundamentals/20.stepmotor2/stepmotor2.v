//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   stepmotor2.v,divide.v
//   Module name     :   stepmotor2
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   步进电机运行控制电路，A、B、C、D分别表示步进电机的四相绕组，
//						步进电机按四相双四拍方式运行。
//							控制端T＝1，电机的四相绕组的通电顺序为AC—DA—BD—CB—AC……
//							控制端T＝0，电机的四相绕组的通电顺序为AC—CB—BD—DA—AC……
//********************************************************
module stepmotor2
(
input wire clk,rst,
input wire dir,					//控制端 1：正转 0：反转
output wire [3:0] led			//四相控制对应的led,A(led[0]),B(led[1]),C(led[2]),D(led[3])
);

wire 	clk1h;				//1秒时钟
reg	[3:0] ctrl;				//DCBA四相控制

parameter 	S1 = 2'b00,		//电机步进状态 AC
			S2 = 2'b01,		//DA
			S3 = 2'b10,		//BD
			S4 = 2'b11;		//CB
			
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

always@(cur_state or rst or dir)        //第二段，状态转移,dir控制方向
	if(!rst)
		begin
			next_state = S1;
		end
	else
		begin
			if(dir)                         //当控制端为1，正转
				case(cur_state)
					S1:next_state = S2;     //正转S1-S2-S3-S4-S1
					S2:next_state = S3;
					S3:next_state = S4;
					S4:next_state = S1;
				endcase
			else                             //当控制端为0，反转
				case(cur_state)
					S1:next_state = S4;      //反转S1-S4-S3-S2-S1
					S2:next_state = S1;
					S3:next_state = S2;
					S4:next_state = S3;
				endcase
		end

always@(posedge clk1h or negedge rst)			//第三段，当前状态输出
	if(!rst)
		begin
			ctrl <= 4'b0101;
		end
	else
		begin
			case(next_state)
				S1: ctrl <= 4'b0101;           //AC
				S2: ctrl <= 4'b1001;		   //DA
				S3: ctrl <= 4'b1010;		   //DB
				S4: ctrl <= 4'b0110;		   //CB
				default: ctrl <= 4'b0101;
			endcase
		end
assign 	led = ctrl;		             //状态输出动作对应的led

endmodule
