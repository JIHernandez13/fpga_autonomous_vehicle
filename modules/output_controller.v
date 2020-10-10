`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2018 02:40:12 PM
// Design Name: 
// Module Name: output_controller
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


module output_controller(pdata1, pdata2, pdata3, pdata4, cmdata, clk_sm2, rst_n, dout,pwm1,pwm2,pwm3,pwm4);
    input [7:0] pdata1, pdata2, pdata3, pdata4;
    input [11:0] cmdata;
    input clk_sm2;
    input rst_n;
    
    output [7:0] dout;
    output [7:0] pwm1;
    output [7:0] pwm2;
    output [7:0] pwm3;
    output [7:0] pwm4;
    
    parameter state0 = 4'b0000;             //states to be used based on cmd
    parameter state1 = 4'b0001;             //coresponds to integer value of cmd
    parameter state2 = 4'b0010;
    parameter state3 = 4'b0011;
    parameter state4 = 4'b0100;
    parameter state5 = 4'b0101;
    parameter state6 = 4'b0110;
    parameter state9 = 4'b0111;
    parameter state10 = 4'b1000;
    parameter state11 = 4'b1001;
    parameter state12 = 4'b1010;
    parameter state15 = 4'b1011;
    
    reg [3:0] state_now = state0;
    reg [3:0] state_next;
    reg [7:0] dout = 8'b0;
    reg [7:0] pwm1;
    reg [7:0] pwm2;
    reg [7:0] pwm3;
    reg [7:0] pwm4;
    
    wire [3:0] cmd;
    wire [7:0] data;
    
    assign cmd[3:0] = cmdata[11:8];         //split cmdata [11:0] into cmd and data
    assign data[7:0] = cmdata[7:0];

    always @ (posedge clk_sm2 or negedge rst_n)     //update state on each posedge of clock
        if (rst_n==0)
            state_now <= state0;
        else
            state_now <= state_next;
     
    always @ (state_now,cmd)                        //if state update or command update
        case(cmd)                                   //update next state based on command
           0: state_next <= state0;
           1: state_next <= state1;
           2: state_next <= state2;
           3: state_next <= state3;    
           4: state_next <= state4;
           5: state_next <= state5;
           6: state_next <= state6;
           9: state_next <= state9;       
           10: state_next <= state10;
           11: state_next <= state11;
           12: state_next <= state12;
           15: state_next <= state15;
           default: state_next <= state0;
       endcase
    
    always @ (negedge clk_sm2)                                  //perform desired task
        case(state_now)                                         //as listed in table
            state0: dout<=8'b0;                                 //with newest data available
            state1: dout<=pdata1;                               
            state2: dout<=pdata2;                                  
            state3: dout<=pdata3;
            state4: dout<=pdata4;
            state5: dout<=8'b0;
            state6: dout<= ((pdata1+pdata3)/2-(pdata2+pdata4)/2);
            state9: pwm1<=data;
            state10: pwm2<=data;
            state11: pwm3<=data;
            state12: pwm4<=data;
            state15: dout<=8'b1010_1010;
            default: dout<= 8'b0;
        endcase
endmodule
