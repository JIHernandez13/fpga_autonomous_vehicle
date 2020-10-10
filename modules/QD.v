`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 

// Design Name: 
// Module Name:    QD 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This module takes a A/B Quadrature signal from motors and
// decodes the direction and pulse 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module QD(input A, input B, input clk, input rst, output Pulse);

//State Encodings
parameter State0 = 4'b0001; //0000 or 0000
parameter State1 = 4'b0010; //0001 or 0010
parameter State2 = 4'b0100; //0010 or 0011
parameter State3 = 4'b1000; //0011  or 0010

// state machine - use one - hot encoding

reg [3:0] PresentState=4'b0000;
reg [3:0] NextState;
reg Pulse;
reg Dir;

wire [1:0] AB;
assign AB[1]=A;
assign AB[0]=B;

  always @(posedge clk)
  if (rst)
    PresentState<=State0;
	else
     PresentState<=NextState;

	  
	always @(PresentState,A,B)
	 case (PresentState)
      State0  : begin // A=0 B=0
                  if (AB==2'b00) begin  NextState=State0;  end
						if (AB==2'b01) begin  NextState=State1; Pulse=0; end
						if (AB==2'b10) begin  NextState=State2; Pulse=1; end
					 if (AB==2'b11) begin  NextState=State0;  end	// should never occur but to prevent latches for AB
               end
					
     State1  : begin //A=0 B=1
                  if (AB==2'b01) begin 	NextState=State1;  end
						if (AB==2'b11) begin  NextState=State3; Pulse=1; end
						if (AB==2'b00) begin  NextState=State0; Pulse=0; end
				  if (AB==2'b10) begin  NextState=State1;  end	// should never occur but to prevent latches for AB
               end
					
     State3  : begin //A=1 B=1
                  if (AB==2'b11) begin 	NextState=State3;  end
						if (AB==2'b10) begin  NextState=State2; Pulse=0; end
						if (AB==2'b01) begin  NextState=State1; Pulse=1; end
				if (AB==2'b00) begin  NextState=State3;  end	// should never occur but to prevent latches for AB
               end
					
      State2  : begin // A=1 B=0
                  if (AB==2'b10) begin 	NextState=State2;  end
						if (AB==2'b00) begin  NextState=State0; Pulse=1; end
						if (AB==2'b11) begin  NextState=State3; Pulse=0; end
				  if (AB==2'b01) begin  NextState=State2;  end	// should never occur but to prevent latches for AB
               end
					
      default: begin
                 NextState=State0;
               end
   endcase

endmodule
