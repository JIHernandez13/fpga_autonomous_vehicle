`timescale 1ns / 1ps


module serial_parallel_shift(clk, en, bit_in, data_out);

input clk;
input en;

input bit_in;

output [7:0]data_out;

reg [7:0]data_out;
reg [3:0]counter;
reg [7:0]data;

always @ (posedge clk)
	if (en)
	begin
		data <= {bit_in, data[7:1]};
		counter <= counter+1;
	end
	else
		counter<=counter;
		
always @ (counter)
	if (counter==7)
	begin
		data_out<=data;
		counter<=0;
	end
	else
		data<=data;
		
		
	