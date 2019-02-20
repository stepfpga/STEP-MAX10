//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   shift7_tb.v
//   Module name     :   shift7_tb
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   移位寄存器Testbench
//********************************************************
`timescale 1ns/100ps    //仿真时间单位/时间精度

module shift7_tb;
	
reg clk, rst;       //需要产生的激励信号定义
reg [6:0]datain;    
wire dataout;       //需要观察的输出信号定义

initial
	begin
		clk =0;
		rst =1;
		datain =7'b1110101;   //所需移位数据
		#50
		rst =0;
		#100
		rst =1;
	end
	
always #20 clk =~clk;     //产生时钟信号 频率25MHz
 //module调用例化格式
shift7 u1 (
				.clk	(clk),
				.rst	(rst),
				.datain	(datain),
				.dataout(dataout)
			);
endmodule
