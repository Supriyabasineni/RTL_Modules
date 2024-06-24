`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2024 10:46:34
// Design Name: 
// Module Name: assig2_tb
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


module assig2_tb();
reg clk, resetn;
  reg [7:0]s_data;
  reg s_valid, s_last;
 wire  s_ready;
  
 wire [7:0]m_data;
 wire m_valid;
  wire m_last;
 reg m_ready;
reg [4:0]k,len,count;
  reg nw;integer i,j;
assig_2 dut(clk, resetn,s_data,s_valid, s_last,s_ready,m_data,m_valid,
m_last,m_ready,k,len,nw);
 always #5 clk=~clk;
 initial begin
   clk<=1;count=0;
   resetn<=0;m_ready<=0;
   #10;
   resetn<=1;m_ready<=1;
 end
/* initial begin
 m_ready=1;
  repeat(2)@(posedge clk) m_ready=0;
     repeat(5)@(posedge clk) m_ready=1;
     repeat(2)@(posedge clk) m_ready=0;
     repeat(5)@(posedge clk) m_ready=1;
     repeat(2) @(posedge clk) m_ready=0;
     repeat(4)@(posedge clk) m_ready=1;
      repeat(2) @(posedge clk) m_ready=0;
       repeat(5)@(posedge clk) m_ready=1;
 end*/
 
 initial begin
 len=5'd5;
 //len=10;
     for(i=0;i<30;i=i+1)
      
         begin
           s_data<=$urandom%10;
          // s_valid<=1;
            #10;
            if(i>4 && i<10)
            s_valid<=1;
            else
            s_valid<=1;
           if(i==len-1 || i==2*len-1 || i==3*len-1 ) begin
              s_last<=1;//k=i-;
           end
         else begin
         // k=2;
           s_last<=0;end
            if(i==1)
       k<=3;
           if(i==len) begin
               k<=2;
             //nw=1;
           end
          // end
          // end
           
          /*always@(i)
          begin 
           if(i%len==0 && i!=0 )//|| count<=k)
           begin
           for(j=0;j<2;j=j+1) 
           nw<=1;
           #10; 
           //count<=count+1;
           end
           else begin
           nw<=0;
           //count<=0;
           end*/
          
          if(i==len || i==len+1 || i==len+2 || i==len+3 || i==2*len || i==2*len+1 
          || i==3*len || i==3*len+1 || i==3*len+2)// || i==2*len+3)
             nw<=1;
           else
             nw=0;
          end
 end
endmodule
