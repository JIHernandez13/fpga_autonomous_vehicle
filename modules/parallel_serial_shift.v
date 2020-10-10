`timescale 1ns / 1ps


module parallel_serial_shift(clk, en, data_in, bit_out);
input clk;
input en;
input [23:0] data_in;

output bit_out;

reg [23:0] data= 0;

assign bit_out = data[0];

always @ (posedge clk)
	if (en)
		data = {0, data[23:1]};
	else
		data<= data;

		
		
		
always @ (data_in)
	data<=data_in;