`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2024 10:30:26
// Design Name: 
// Module Name: mod31
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


module mod31#( parameter widtha=10,
parameter widthb=10,
parameter widthc=18,
parameter widthd=6,
parameter output_width=(widtha+widthb)
)
(
//i
input clk,
input reset,
 input [widtha-1:0]a,
 input [widthb-1:0]b,
 input [widthc-1:0]c,
 //input [widthd-1:0]d,
 output reg flag,
 output reg  [output_width-1:0]z
    );
    reg [5:0]d;
  // reg flag;
   initial begin
   d=6'd15;
  end
    always@(posedge clk)
    begin
    if(reset)
    begin
    flag=0;
    z=0;
    end
    //d<=a*b;
    else
    begin
    z=(a+b); 
    if(z==d)
    flag=1;
    else
    flag=0; 
    end
    end
endmodule
