//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   coded_lock.v
//   Module name     :   coded_lock
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   4位二进制密码锁
//						4位密码输入代码分别为Q、U、N、B，开箱时，钥匙插入钥匙孔右旋
//						使D＝1，如果输入密码（如：QUNB＝0101）与设置的代码相同，则
//						保险箱被打开，即输出端G＝1，否则箱体发出报警。
//********************************************************

module coded_lock
(
input wire q,u,n,b,           //四位开关作为密码输入
input wire d,				  //一位按键作为开锁使能信号
output wire led1,    	      //保险箱打开信号对应的led输出
output wire led2			  //报警信号对应的led输出
);

wire  [3:0]   code;			  //四位变量存储密码
reg			  open;			  //保险箱开箱信号
reg			  alarm;          //报警信号

assign		code = {q,u,n,b};

always@(d or code)
	if(d == 1'b1)             //使能，开始判断密码
		begin
			if(code == 4'b0101)   
				begin
					open = 1'b1;  //开锁
					alarm = 1'b0; //没报警
				end
			else
				begin
					open = 1'b0;  
					alarm = 1'b1;
				end
		end
	else
		begin
			open = 1'b0;
		end

assign  led1 = ~open;		//led亮表示密码锁没开
assign	led2 = ~alarm;		//led亮代表发出报警信号

endmodule
