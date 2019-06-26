// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: first demo
// 
// Author: Step
// 
// Description: firt demo, Top module
// 
// Web: www.stepfpga.com
// 
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.0     |2016/04/20   |Initial ver
// --------------------------------------------------------------------
module FirstDemo
(
input clk_in,  //clk_in = 12mhz
input rst_n_in,  //rst_n_in, active low
input  [3:0] SW,  //switch key
input  [2:0] BTN,  //button key
output [7:0] Water_led,  //Water_led output
output [2:0] Color_led_1,  //Water_led output
output [2:0] Color_led_2,  //Water_led output
output [8:0] Segment_led_1,  //Segment_led output, MSB~LSB = SPGFEDCBA
output [8:0] Segment_led_2,  //Segment_led output, MSB~LSB = SPGFEDCBA
output [35:0] GPIO
);

assign GPIO = {36{clk_1Hz}};

//Debounce for key
wire [2:0] key_pulse,key_state;
Debounce Debounce_uut
(
.clk(clk_in),
.rst_n(rst_n_in),
.key_n(BTN),
.key_pulse(key_pulse),
.key_state(key_state)
);

wire clk_1Hz;
Clock_div clk_1Hz_uut
(
.clk_in(clk_in),  //clk_in = 25mhz
.rst_n_in(rst_n_in),  //rst_n_in, active low
.SW(SW),  //switch key for speed
.clk_div_pulse_out(clk_1Hz)  //clock divide output
);

wire Lightness_out,Lightness_out1;
Lightness Lightness_uut
(
.clk_in(clk_in),
.rst_n_in(rst_n_in),
.color(Color_led_1),
.up_pulse(key_pulse[1]),
.down_pulse(key_pulse[2]),
.Lightness_out(Lightness_out),
.Lightness_out1(Lightness_out1)
);

wire [3:0] heart_cnt;
Heart_beat Heart_beat_uut
(
.direction(key_state[0]),  //switch key for direction
.rst_n_in(rst_n_in),  //rst_n_in, active low
.clk_1hz_in(clk_1Hz),  //clk_1hz_in
.heart_cnt(heart_cnt)  //heart_cnt output
);

wire [7:0] Water_led_temp;
Water_led Water_led_uut
(
.clk_in(clk_in),  //clk_in = 25mhz
.rst_n_in(rst_n_in),  //rst_n_in, active low
.heart_cnt(heart_cnt),  //heart_cnt input
.Water_led(Water_led_temp)  //Water_led output
);

wire [2:0] Color_led_1_temp;
wire [2:0] Color_led_2_temp;
Color_led Color_led_uut
(
.clk_in(clk_in),  //clk_in = 25mhz
.rst_n_in(rst_n_in),  //rst_n_in, active low
.heart_cnt(heart_cnt),  //heart_cnt input
.Color_led_1(Color_led_1_temp),  //Water_led output
.Color_led_2(Color_led_2_temp)  //Water_led output
);
	
wire [8:0] Segment_led_1_temp;
wire [8:0] Segment_led_2_temp;
Segment_led Segment_led_uut
(
.heart_cnt(heart_cnt),  //heart_cnt input
.Segment_led_1(Segment_led_1_temp),  //Segment_led output, MSB~LSB = SPGFEDCBA
.Segment_led_2(Segment_led_2_temp)  //Segment_led output, MSB~LSB = SPGFEDCBA
);

assign Water_led = Lightness_out1? Water_led_temp:8'hff;
assign Color_led_1 = Lightness_out? Color_led_1_temp:3'b111;
assign Color_led_2 = Lightness_out? Color_led_2_temp:3'b111;
assign Segment_led_1 = Lightness_out1? Segment_led_1_temp:9'h00;
assign Segment_led_2 = Lightness_out1? Segment_led_2_temp:9'h00;
	
endmodule