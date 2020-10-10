`timescale 1ns / 1ps

module com_in_state(clk, rst_n, data_in, state_out, data_out);
input clk;
input rst_n;
input [7:0] data_in;

output reg[23:0] data_out;
output reg[7:0] state_out;

reg [3:0] state_now= state0;
reg [7:0] state_save;
reg [23:0] data;

parameter state0 = 4'b0001;
parameter state1 = 4'b0010;
parameter state2 = 4'b0100;
parameter state3 = 4'b1000;

always @ (data_in or rst_n)
	if (!rst_n)
		state_now = state0;
	else
	case (state_now)
	state0: 
		begin
			case(data_in)
				8'h01: state_out <= data_in;
				8'h02: state_out <= data_in;
				8'h03: state_out <= data_in;
				8'h04: state_out <= data_in;
				8'h11: state_out <= data_in;
				8'h12: state_out <= data_in;
				8'h13: state_out <= data_in;
				8'h14: state_out <= data_in;
				8'h51: state_out <= data_in;
				8'h52: state_out <= data_in;
				8'h61: state_out <= data_in;
				8'h62: state_out <= data_in;
				default: state_save<=data_in;
			endcase
			state_now <= state1;
		end
	state1:
		begin
			data[7:0] <= data_in;
			state_now<= state2;
		end
	state2:
		begin
			data[15:8] <= data_in;
			state_now<=state3;
		end
	state3:
		begin
			data[23:16] <= data_in;
			state_out<= state_save;
			data_out<=data;
			state_now<=state0;
		end
	endcase
				