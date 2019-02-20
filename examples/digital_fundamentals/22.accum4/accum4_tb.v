//********************************************************
//   Copyright(c)2018, STEP FPGA 
//   All rights reserved
//   File name       :   rs_ff_tb.v
//   Module name     :   rs_ff_tb
//   Author          :   STEP
//   Email           :   info@stepfpga.com
//   Data            :   2018/08/01
//   Version         :   V1.0
//   Description     :   RS触发器Testbench
//********************************************************
`timescale 1ns/100ps    //仿真时间单位/时间精度        
module accum4_tb();         
 
reg    clk,rst,datain; 
reg [7:0] data;
wire   [3:0]sum; 
 
//初始化过程块
initial
begin
	clk = 0;
	rst = 0;  
	data <= 8'b00100001;   //串行输入数据初值
	#25                      
	rst = 1;               
end
 
always #10 clk = ~clk;      
	
always @(posedge clk)       //产生串行输入数据datain
	if(!rst)
		begin
			datain <= 0;
		end
	else
		begin
			data <={0,data[7:1]};
			datain <= data[0];
		end
 
//module调用例化格式
accum4   u1 (
		.clk	(clk),     
		.rst	(rst), 
		.datain (datain),
		.sum	(sum)   
);
endmodule
