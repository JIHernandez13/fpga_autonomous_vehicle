`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2018 02:18:37 PM
// Design Name: 
// Module Name: pwm_gen
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


module pwm_gen(pwm_set, clk_pwm, rst_n, pwm_out);
    input [7:0] pwm_set;        //desired pulse width
    input clk_pwm;              //clock with 8bits of resolution compared to output
    input rst_n;
    
    output pwm_out;             //PWM signal at ~16kHz

    reg [7:0] count;            //counter to facilitate correct pulse width
    reg pwm_out;
    
    always @ (posedge clk_pwm or negedge rst_n)
        if (rst_n == 0)
            count <= 0;
        else
            count <= count+1;
    
    always @ (count or pwm_set)
        if (count < pwm_set)        //if smaller than desired pulse width, be high
            pwm_out <= 1;
        else                        //else go low;
            pwm_out <= 0;

        
endmodule
