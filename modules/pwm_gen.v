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
#`def CLK_SPEED_HZ = 16;  // temporary definition of clock speed until we figure out how to grab clock from master module


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

// Needs testing to validate module with duty cycle as an input
module pwm_dc (
    duty_cycle;
    clk_pwm;
    rst_n;
    pwm_output;
);
    input [7:0] duty_cycle;     // duty cycle as a percentage
    input clk_pwm;      // input clock to generate pwm
    input rst_n;        // reset pin
    
    output pwm_output;      // output pwm signal
    
    reg [7:0] count;        // software counter
    reg [7:0] pwm_set;        // software counter
    
    /*
    so what i need is some way of converting the dc to ticks from the clk input. 
    I have to make an assumption about the period of my clock though. 
    I need the clock frequency to determine how fast the counter will increment. 
    Should this be another input to the module? 
    */
    
    /* Time(1 - dc/100) = count */
    always @ (duty_cycle)
        count <= (1/CLK_SPEED_HZ)*(1-(duty_cycle/100));
    
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