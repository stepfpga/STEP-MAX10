// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: Debounce
// 
// Author: Step
// 
// Description: Debounce for button with FPGA/CPLD
// 
// Web: www.stepfpga.com
//
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2015/11/11   |Initial ver
// --------------------------------------------------------------------
module debounce #
(
parameter	KEY_WIDTH = 1,
parameter	CNT_NUM = 19'd240000
)
(
input   					clk,			//system clock
input   					rst_n,			//system reset
input   	[KEY_WIDTH-1:0]	key_n,			//button input
output  reg	[KEY_WIDTH-1:0]	key_jit,			//key jitter output
output  wire[KEY_WIDTH-1:0]	key_pulse		//Debounce pulse output
); 


reg [KEY_WIDTH-1:0] key_n_r,key_n_r1;   
//Register key_n_r1, lock key_n_r to next clk
always @(posedge clk or negedge rst_n)
    if (!rst_n) begin
		key_n_r <= {KEY_WIDTH{1'b1}};
		key_n_r1 <= {KEY_WIDTH{1'b1}};
    end else begin
		key_n_r <= key_n;
		key_n_r1 <= key_n_r;
	end

//Detect the edge of key_n
wire  key_an = (key_n_r == key_n_r1)? 1'b0:1'b1;

reg [18:0]  cnt;
//Count when a edge of key_n is occured
always @(posedge clk or negedge rst_n)
    if (!rst_n) cnt <= 19'd0;
    else if(key_an) cnt <=19'd0;
    else cnt <= cnt + 1'b1;

//Sample key_jit when cnt count to CNT_NUM(20ms)
always @(posedge clk or negedge rst_n)
    if (!rst_n)  key_jit <= {KEY_WIDTH{1'b1}};
	else if (cnt == CNT_NUM-1) key_jit <= key_n_r;

reg [KEY_WIDTH-1:0] key_jit_r;
//Register key_jit_r, lock key_jit to next clk
always @(posedge clk or negedge rst_n)
    if (!rst_n) key_jit_r <= {KEY_WIDTH{1'b1}};
    else  key_jit_r <= key_jit;

//wire [KEY_WIDTH-1:0] key_pulse;
//Detect the negedge of key_jit, generate pulse
assign key_pulse = key_jit_r & ( ~key_jit);

endmodule
