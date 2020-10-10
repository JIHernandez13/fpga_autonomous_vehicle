`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2018 12:32:40 AM
// Design Name: 
// Module Name: sys_test
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


module sys_test;
    reg [3:0] A, B;
    reg [11:0] cmdata;
    reg rst_n;
    reg clk_sys;
    
    wire [7:0] dataout;
    wire pwm1,pwm2,pwm3,pwm4;
    
    systemprocessortop UUT(A, B, cmdata, clk_sys, rst_n, dataout, pwm1,pwm2,pwm3,pwm4);
    
    initial begin
        rst_n = 0;              //reset everything;
        A = 0;
        B = 0;
        clk_sys = 0;
        cmdata = 0;
        #1000;
        #10
        A = 4'b1111;            //set A high to have A and B oscillate different numbers
        
        rst_n = 1;
        #1000
        
        cmdata = 12'b1001_1111_1111;    //start pwm1
        #1000

        cmdata = 12'b1010_1111_0000;    //start pwm2
        #1000
        
        cmdata = 12'b1011_0000_1111;    //start pwm3
        #1000    

        cmdata = 12'b1100_0000_0011;    //start pwm4
        #1000    
        
        cmdata = 12'b1111_1111_1111;    //display test 8'b 1010_1010 (0xaa) in data out
        #1000
        
        cmdata = 12'b0;                 //to go to dont care mode and display 0
        #1000
        
        cmdata = 12'b0001_0000_1111;    //to display pulse measurement of encoder 1
    end
    
    always #2000 A<= ~A;                    //have A and B channels of encoders oscillate in pattern to get pulse measurements
    always #2000 B<= ~B;
    always #16 clk_sys<=~clk_sys;           //setup system clock at ~32MHz
endmodule
