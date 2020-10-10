`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2018 12:07:28 AM
// Design Name: 
// Module Name: systemprocessortop
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


module systemprocessortop(A, B, cmdata, clk_sys, rst_n, dataout, pwm1,pwm2,pwm3,pwm4);
    input [3:0] A, B;
    input [11:0] cmdata;
    input clk_sys;
    input rst_n;
    
    output [7:0]dataout;
    output pwm1, pwm2, pwm3, pwm4;
    
    wire clk_pwm,clk_sm1, clk_sm2, clk_ph1, clk_ph2, clk_ph3, clk_ph4;              //wires for clocks to be routed to specific modules
    wire [7:0] pdata1, pdata2, pdata3, pdata4;                                      //wires to hold pulse count data
    wire [7:0] pwm_set1, pwm_set2, pwm_set3, pwm_set4;
    
    clk_div CDIV(clk_sys,rst_n, clk_pwm, clk_sm1, clk_sm2, clk_ph1, clk_ph2, clk_ph3, clk_ph4);
    
    motorprocessor ch0(A[0], B[0], clk_sys, clk_sm1, clk_ph1, rst_n, pdata1);
    motorprocessor ch1(A[1], B[1], clk_sys, clk_sm1, clk_ph1, rst_n, pdata2);    
    motorprocessor ch2(A[2], B[2], clk_sys, clk_sm1, clk_ph1, rst_n, pdata3);    
    motorprocessor ch3(A[3], B[3], clk_sys, clk_sm1, clk_ph1, rst_n, pdata4);
    
    output_controller smcontroller(pdata1, pdata2, pdata3, pdata4, cmdata, clk_sm2, rst_n, dataout,pwm_set1,pwm_set2,pwm_set3,pwm_set4);
    
    pwm_gen motor1(pwm_set1, clk_pwm, rst_n, pwm1);
    pwm_gen motor2(pwm_set2, clk_pwm, rst_n, pwm2);
    pwm_gen motor3(pwm_set3, clk_pwm, rst_n, pwm3);
    pwm_gen motor4(pwm_set4, clk_pwm, rst_n, pwm4);
        
endmodule
