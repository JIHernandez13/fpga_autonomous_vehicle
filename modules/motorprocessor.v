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


module motorprocessor(A, B, clk_sys, clk_sm1, clk_ph1, rst_n, pulse_data);
    input A, B;
    input clk_sm1, clk_ph1, clk_sys;
    input rst_n;
    
    output [7:0] pulse_data;
    
    wire pulse;
    
    QD decoder(A, B, clk_sm1, rst_n, pulse);
    pulse_measure measure(pulse,clk_sys, clk_ph1, rst_n, pulse_data);
    
    
endmodule