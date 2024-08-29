module mod31_tb#( parameter widtha=10,
parameter widthb=10,
parameter widthc=18,
parameter widthd=6,
parameter output_width=(widtha+widthb));
reg clk,reset;
reg [widtha-1:0]a;
 reg [widthb-1:0]b;
 reg [widthc-1:0]c;
 //input [widthd-1:0]d,
 wire flag;
 wire  [output_width-1:0]z;
    
mod31 dut(clk,reset,a,b,c,flag,z);
always #5 clk=~clk;
initial begin
clk=0;reset=1;
#15;reset=0;
a='d9;
b='d5;
c='d0;

#10;
a='d11;
b='d5;
c='d0;

#10;
a='d12;
b='d5;
c='d0;

#10;
a='d13;
b='d2;
c='d0;

#10;
a='d16;
b='d5;
c='d0;

#10;
a='d10;
b='d5;
c='d0;

#10;
a='d8;
b='d5;
c='d0;
end

endmodule
