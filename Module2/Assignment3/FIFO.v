`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2024 22:28:38
// Design Name: 
// Module Name: fifo_4096
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


module fifo_4096(
input clk,
input resetn,
input rd_en,
input wr_en,
input [7:0]s_data,
input s_valid,
input s_last,
output  s_ready,
output  empty,
output  full,
output  [7:0]m_data,
output  m_valid,
output  reg m_last,
input m_ready
    );
   // reg [12:0]mem1[2048:0];
    //reg [12:0]mem2[2048:0];
    wire empty1,empty2,full1,full2,t_valid,t1_last,s1_ready,mlast;
    //wire [11:0]m1,k1,n2;
    wire [7:0]temp;integer i;
    fifo_2048 f1(clk,resetn,~(empty1 | full2),wr_en,s_data,s_valid,s_last,s1_ready,empty1,full1,temp,t_valid,t1_last,m_ready);
    fifo_2048 f2(clk,resetn,rd_en,~(empty1 | full2),temp,t_valid,t1_last,s_ready,empty2,full2,m_data,m_valid,mlast,m_ready);
    assign empty=empty1;
    assign full=full1;
    //assign m_last=(k==5);
    //assign m_last=t1_last;
    initial begin
    m_last=0;
    end
    always@(posedge clk)
    begin
    if(rd_en)
    begin
    for(i=1;i<=4096;i=i+1)
    begin
   //m_last=0;
    #20;
    if(i%10==0) begin
    
    m_last=1; end
    else 
    m_last=0;
   if(i==0)
    m_last=0;
    
    end 
    end
    end
    
endmodule


  
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2024 10:53:36
// Design Name: 
// Module Name: slave
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


module fifo_2048#(parameter data_width=8,
                  parameter depth =2048,
                  parameter Ptr_width=$clog2(depth)
                 ) 
//module fifo_2048
(
input clk,
input resetn,
input rd_en,
input wr_en,
//input [7:0]s_data,
input [data_width-1:0]s_data,
input s_valid,
input s_last,
output reg s_ready,
output  empty,
output  full,
output reg [data_width-1:0]m_data,
//output reg [7:0]m_data,
output reg m_valid,
output reg m_last,
input m_ready//input [11:0]k
    );
   // parameter depth=8;
   // parameter data_width=12;
    reg  [data_width-1:0]mem[0:depth-1];
   
    integer i;
    reg [11:0]n=0;reg [11:0]m=0;
    reg [11:0]k=0;
    //reg [2:0]rd_ptr,wr_ptr;
    reg [Ptr_width:0]rd_ptr,wr_ptr;
    reg [11:0]count=0;
    
   /* always@(posedge clk)
    begin
    if(~resetn)
    begin
    wr_ptr = 12'b0;
    rd_ptr =12'b0;
    count = 13'b0;
    end
    end*/
    always@(posedge clk)
        begin
        if(~resetn)
        begin
         wr_ptr = 12'b0;
        // count = 13'b0;
        end
     else if(s_valid && s_ready && wr_en && ~full)
         begin
         mem[wr_ptr ] <=s_data;
         wr_ptr <=wr_ptr  + 1;
         
  
    end 
    end
     always@(posedge clk)
        begin
        if(~resetn)
                begin
                rd_ptr = 12'b0;
                
                end
      if(rd_en & ~empty & m_ready)
     begin
     m_data= mem[rd_ptr];
     m_valid=1;
     rd_ptr = rd_ptr  + 1;
   
    
     end
     else
     begin
     m_valid=0;
     m_data=0;
     end
    end
       always@(posedge clk)
           begin
           s_ready<=m_ready;
           end 
           always@(posedge clk)
           begin 
           if(s_valid && s_ready && wr_en && ~full)
            m=m+1;
           if(s_last)
           n=m;
           if(rd_en & ~empty & m_ready)
            k=k+1;
            if(k==n && m_valid)
            m_last=1;
            else
            m_last=0;
            
            
            end
           always@(posedge clk)
              begin
                if(~resetn)
                   begin
                     count = 13'b0;
                    end  
                    else if(s_valid && s_ready && wr_en && ~full)
                    count = count + 1;
                     else if(rd_en & ~empty & m_ready)
                    count = count - 1;
                    end
                          
         assign empty=(count==0);
        
         assign full=(count==depth-1);
         
endmodule
