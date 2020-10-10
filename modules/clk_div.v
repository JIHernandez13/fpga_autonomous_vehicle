`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2018 12:41:24 PM
// Design Name: 
// Module Name: clk_div
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


module clk_div(clk_sys, rst_n, clk_pwm, clk_sm1, clk_sm2, clk_ph1, clk_ph2, clk_ph3, clk_ph4);
    input clk_sys;
    input rst_n;
    output clk_pwm, clk_sm1, clk_sm2, clk_ph1, clk_ph2, clk_ph3, clk_ph4;
    
    reg [7:0] count;
    reg clk_ph1, clk_ph2, clk_ph3, clk_ph4;
    
    wire clk250;         //wire to help with creating clocks out of phase
    wire clk125;         //wire to help with creating clocks out of phase
    
    assign clk_sm1 = count[4];       //1MHz  50% duty cycle      in phase clock for      state machine
    assign clk_sm2 = ~count[4];      //1MHz  50% duty cycle      180 out of phase        state machine
    assign clk_pwm = count[3];       //4MHz  50% duty cycle      in phase                PWM
    assign clk250 = count[6];        //250kHz to help facilitate 25% duty cycle for phase clocks
    assign clk125 = count[7];        //125kHz used to start ripple effect and align clk_ph1 to be in phase
    
    always @ (posedge clk_sys or negedge rst_n)
        if (rst_n==0)
            count <= 0;
        else
            count <= count+1;
        
    always @ (posedge clk250)
        begin
            clk_ph2 <= 0;
            clk_ph4 <= 0;
        end
        
    always @ (negedge clk250)
        begin
            clk_ph1 <= 0;
            clk_ph3 <= 0;
        end
        
    always @ (posedge clk125)
            clk_ph1 <= 1;

    always @ (negedge clk_ph1)
            clk_ph2 <=1;
    
    always @ (negedge clk_ph2)
            clk_ph3 <=1;
            
    always @ (negedge clk_ph3)
            clk_ph4 <=1;
    
endmodule
