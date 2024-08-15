`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2024 10:49:34
// Design Name: 
// Module Name: tb_1
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


module tb_1();
  reg clk, resetn;
  reg [7:0]s_data;
  reg s_valid;
  reg s_last;
  wire s_ready;
  wire [7:0]m_data;
  wire m_valid;
  wire m_last;
  reg m_ready;
  integer i;
  slave s1( clk, resetn,s_data,s_ready,s_valid,s_last,m_data,m_valid,m_last,m_ready);
  initial
    begin
      clk<=0; resetn<=0; m_ready<=0;
      s_last<=0;s_valid<=0;
      s_data<=0;
      forever #10 clk=~clk;
    end
  initial 
    begin     
      #30;resetn<=1;
      m_ready<=1;
     end
     
  initial begin   
     #30;
     for(i=0;i<15;i=i+1)
        begin
       #20;
         if(s_ready==1)
            begin
               s_data<=$urandom%50;
          if(s_data<30)
             s_valid<=1;
          else
            s_valid<=0;
          if(i==12)
           s_last<=1;
           else
           s_last<=0;
           end
     end
     //@(posedge clk)
     s_last<=0;s_data<=0;s_valid<=0;m_ready<=0;
     end
   initial
       begin
         //forever #20 m_ready=~m_ready; 
         repeat(2)@(posedge clk) m_ready<=1;  
         repeat(5)@(posedge clk) m_ready<=1;
         repeat(2)@(posedge clk) m_ready<=0;
         repeat(6)@(posedge clk) m_ready<=1;
         repeat(2) @(posedge clk) m_ready<=0;
         repeat(2)@(posedge clk) m_ready<=1;
         repeat(2) @(posedge clk) m_ready<=0;
       end
    
endmodule
