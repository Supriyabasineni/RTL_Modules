`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2024 14:37:22
// Design Name: 
// Module Name: mul_fptb
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


module mul_fptb(

    ); localparam i1=3,f1=2;
localparam i2=4,f2=2;
localparam out_i=5,out_f=3;
reg clk;
reg [i1+f1-1:0]a;
reg[i2+f2-1:0]b;
reg sign;
wire overflow,underflow;
wire[out_i+out_f-1:0]out;integer i;
mul_fp#(i1,f1,i2,f2,out_i,out_f) a1(clk,a,b,sign,out,overflow,underflow);
always #5 clk=~clk;
initial begin
clk=1;
sign=1;
#10;
for(i=0;i<15;i=i+1)
begin
a=$urandom;
b=$urandom;
#20;
end
a=9'b011101011;
b=9'b000110100;
#20;
a=9'b100100000;//overflow=1;
b=9'b110100000;
#20;
a=9'b000000100;//overflow=1;
b=9'b000000010;
end
endmodule
