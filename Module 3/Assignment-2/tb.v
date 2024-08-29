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
  reg [4:0]k,len;//count;
  integer i;
  assig_2 dut(clk,resetn,s_data,s_valid,s_last,s_ready,m_data,m_valid,m_last,m_ready,k,len);
  always #5 clk=~clk;
  initial
    begin
      clk<=1;//count<=0;
      resetn<=0;m_ready<=0;
      #10;
      resetn<=1;m_ready<=1;
      len<=5'd10;
    end
  initial
    begin
      #10;
      for(i=0;i<31;i=i+1)
        begin
          s_data<=$urandom%10;
          #10;
          if(i>4 && i<10)
            s_valid<=1;
          else
            s_valid<=1;
          if(i==len-1 || i==2*len-1 || i==3*len-1 ) 
            begin
              s_last<=1;
            end
          else
            begin
              s_last<=0;
            end
          if(i==1)
            k<=4;
          if(i==len) 
            begin
              k<=5;
            end
        end
    end
endmodule
