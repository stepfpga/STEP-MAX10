//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   stepmotor1_tb.v
//   Module name     :   stepmotor1_tb
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   步进电机Testbench，仿真必须先修改stepmotor1程序里的分频时钟
//********************************************************
`timescale 1ns/100ps    //仿真时间单位/时间精度

 
module stepmotor1_tb();          
 
reg    clk,rst_n;     	//需要产生的激励信号
wire   [5:0]clkout;    	//需要观察的输出信号
 
//初始化过程块
initial
begin
	clk = 0;
	rst_n = 0;
	#25                      //#表示延时25个时间单位
	rst_n = 1;               //产生了一个初始25ns低电平，然后变高电平的复位信号
end
 
always #10 clk = ~clk;       //一个时钟周期20ns的clk，频率为50MHz
 
//module调用例化格式
stepmotor1   u1 (      
		.clk	(clk),     //.clk表示module本身定义的信号名称；（clk）表示我们在这里定义的激励信号
		.rst	(rst_n),   //在testbench里定义的信号名称可以与所要调用module的端口信号名称不同
		.led	(clkout)   
);
endmodule
