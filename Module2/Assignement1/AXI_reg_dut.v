`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2024 20:58:02
// Design Name: 
// Module Name: slave1
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


module slave(
input clk,
  input resetn,
  input [7:0]s_data,
  output  s_ready,
  input s_valid,
  input s_last,
  
  output reg [7:0]m_data,
  output reg m_valid,
  output reg m_last,
  input m_ready);
  reg [7:0]mdata;reg mlast;reg mvalid,mready;
  always@(posedge clk)
  begin
  if(~resetn)
  begin
    mdata=0;
    mlast=0;
    mvalid=0;
    mready=0;
  end
  else if(s_valid && s_ready)
  begin
    mdata=s_data;
     mlast=s_last;
     mvalid=s_valid;
     mready=m_ready;
  end
//  else
//  begin
//      //mdata=0;
//      //mlast=0;
//      mvalid=0;
//      //mready=0;
//    end
  end
  always@(posedge clk)
  begin
  if(~resetn)
    begin
      m_data=0;
      m_last=0;
      m_valid=0;
      
    end
    else if(m_ready)
    begin
         m_data<=mdata;
         m_last<=mlast;
         m_valid<=mvalid;
         
    end
    else
    begin
    m_valid=0;
    m_last=0;
    end
  end
  assign s_ready=m_ready;
endmodule
