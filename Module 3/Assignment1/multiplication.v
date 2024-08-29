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
 //output reg flag,
 output reg  [output_width-1:0]z
    );
  always@(posedge clk)
    begin
    if(reset)
    begin
    z=0;
    end
        else
        begin
        z=(a+b)*c; 
end
end
endmodule
