`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2024 12:07:08
// Design Name: 
// Module Name: fp_add1tb
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


module fp_add1tb();
localparam i1=4,f1=5;
localparam i2=4,f2=5;
localparam out_i=4,out_f=4;
reg clk;
reg [i1+f1-1:0]a;
reg[i2+f2-1:0]b;
reg sign_add;
wire overflow,underflow;
wire[out_i+out_f-1:0]sum;integer i;
fp_add1 #(i1,f1,i2,f2,out_i,out_f) a1(clk,a,b,sign_add,overflow,underflow,sum);
always #5 clk=~clk;
initial begin
clk=1;
sign_add=1;
#10;
for(i=0;i<15;i=i+1)
begin
a=$random;
b=$random;
#20;
end
end
endmodule

