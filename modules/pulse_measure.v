`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2018 01:02:54 PM
// Design Name: 
// Module Name: pulse_measure
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module pulse_measure(pulse, clk_sys, clk_ph1, rst_n, pulse_data);
    input pulse, clk_ph1, rst_n, clk_sys;
    output [7:0] pulse_data;
    
    reg [7:0] pulse_count;      //counter of system clock pulses while pulse (enable) is high
    reg [7:0] pulse_data;       //counter value clocked in on clk_ph1 posedge for output to state machine
    
    always @ (posedge clk_sys or negedge rst_n)
        if (rst_n == 0)                             //if reset is activated, reset counter
            pulse_count <= 0;
        else if (pulse==1)                          //if pulse is high, count up
            pulse_count<= pulse_count+1;
        else
            pulse_count <= pulse_count;             //else, do nothing
        
        
     always @ (posedge clk_ph1)
        begin
            pulse_data <= pulse_count;          //store count value
            pulse_count <= 0;                   //reset count value
        end
        
endmodule
