`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2024 22:32:34
// Design Name: 
// Module Name: fifo_4096tb
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


module axi_4096tb();
 reg clk, resetn,rd_en,wr_en;
 reg [7:0]s_data;
 reg s_valid;
 reg s_last;
 wire s_ready, empty,full;
 wire [7:0]m_data;
 wire m_valid;
 wire m_last;//reg [8:0]m,k;//wire [11:0] n;
 reg m_ready;integer i;//reg [7:0]mem[2027:0];
 fifo_4096 f12(clk, resetn,rd_en,wr_en,s_data,s_valid,s_last,s_ready,empty,
 full,m_data,m_valid,m_last,m_ready);
 initial begin
    clk=0;
    forever #10 clk=~clk;
   // #210 wr_en=0;
 end
 initial begin
 //#220 wr_en=0;  
 end
 initial begin
    resetn=0;rd_en=0;wr_en=0;
    #20;resetn=1;
        m_ready=1;
   #410;rd_en=1;
   //#70;rd_en=1;
  end
initial begin
s_last=0;s_valid=0;
#10;
wr_en=1;
    #20;
     
    s_valid=0;
    //m=0;
    for(i=0;i<=4096;i=i+1)
       begin
      #20;
        if(m_ready==1 & s_ready==1 & wr_en & ~full)
           begin
              s_data=i;//$urandom%40;        
         if(s_data<25)
            s_valid=1;
         else
           s_valid=1;
         if(i%10==0 && i!==0 ) begin
          s_last=1;
         // m_last=1; 
         end
          else
          s_last=0;
         /* if(s_valid & s_ready)
          m=m+1;
          if(s_last) begin
          k=m;*/
          //@(posedge clk)
          //k=0;
         /* if(i==5 )//|| i==14 || i==28)
                     s_last=1;
                     else
                     s_last=0;*/
          //end
          end
           else if(full)
                     begin
                     s_data=0;
                     s_valid=0;s_last=0;
                     end
          //else
          //k=0;
    end
    @(posedge clk)
    s_last=0;s_data=0;s_valid=0;
    end
  
endmodule
