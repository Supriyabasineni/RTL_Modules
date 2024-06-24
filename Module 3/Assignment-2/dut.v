`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2024 12:26:22
// Design Name: 
// Module Name: assig_2
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


module assig_2(
input clk,
  input resetn,
  input [7:0]s_data,
  input s_valid,
  input s_last,
  output  s_ready,
  
  output reg [7:0]m_data,
  output reg m_valid,
  output reg m_last,
  input m_ready,
  input [4:0]k,len,
  input nw

    );
    reg [8:0]fifo[15:0];
     reg [3:0]rd_ptr,wr_ptr;reg [4:0]n;
     reg rd_en;
    /*always@(posedge clk)
    begin
          if(~resetn)
            begin
              wr_en<=0;  
            end
          else
            begin
              if(n>=len-(k) )//&& n!='d1)
                wr_en<=1;
              else
                wr_en<=0;
            end       
        end*/
      always@(posedge clk)
            begin
              if(~resetn)
                begin
                  rd_en=0;//count=0;
                end
                  else
                    begin
                      if(nw)//|| count<=k)
                        begin
                        rd_en=1;
                         // count=count+1;
                        end
                      else begin
                        rd_en=0;//count=0;
                      end
                    end    
            end 
   always@(posedge clk)
                begin
                  if(~resetn)
                    begin
                      wr_ptr<=0; 
                    end
                  else
                    begin
                      if(n>=len-(k) && nw!=1 && s_valid && s_ready) 
                        begin
                          fifo[wr_ptr]=s_data;
                        wr_ptr<=wr_ptr+1;
                          $display(" write fifo[%d]=%d",wr_ptr,s_data);
                        end
                       // else
                        //rd_ptr<=wr_ptr;
                    end
                end 
   always@(posedge clk)
                    begin
                      if(~resetn)
                        begin
                          m_data=0;
                          rd_ptr=0;n=0;
                        end
                     else 
                       begin
                       if(rd_en && s_valid && s_ready ) 
                       begin
                        m_data<=fifo[rd_ptr]+s_data;
                        rd_ptr<=rd_ptr-1;
                        m_valid<=1;
                        $display(" read fifo[%d]=%d %d %d",rd_ptr,fifo[rd_ptr],s_data,m_data);
                      
                        end
                      else
                         begin
                           m_data<=s_data;
                           // n=n+1;
                           m_valid<=0; 
                           
                        end
                         if(n<len)
                         n=n+1;
                         else
                           n='d1;
                             end
                             end 
     always@(posedge clk)
        begin
          if(s_last)
          begin
          m_last<=1;
        //  rd_ptr=wr_ptr-1;
          end
          else
          m_last<=0;
          if(s_last)
            
            rd_ptr=wr_ptr;
          end
          assign s_ready=m_ready;
                                 
endmodule
