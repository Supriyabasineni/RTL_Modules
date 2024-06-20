`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2024 12:05:56
// Design Name: 
// Module Name: fp_add1
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


module fp_add1#(
parameter i1=4,f1=5,
parameter i2=4,f2=5,
parameter out_i=5,out_f=3
)
(input clk,
input [i1+f1-1:0]a,
input [i2+f2-1:0]b,
input sign_add,
output  reg overflow,underflow,
output   [out_i+out_f-1:0]sum);
 localparam high_i=(i1>=i2)?i1:i2;
 localparam high_f=(f1>=f2)?f1:f2;
 

 reg [i1-1:0]ai;
 reg [high_i-1:0]temp_ai;
 reg [f1-1:0]af;
 reg [high_f-1:0]temp_af;
 reg [i2-1:0]bi;
 reg [high_i-1:0]temp_bi;
 reg [f2-1:0]bf;
 reg [high_f-1:0]temp_bf;
 reg [high_i+high_f-1:0]temp_a;
 reg [high_i+high_f-1:0]temp_b;
 reg [high_i+high_f:0]temp_sum;
 reg [out_i-1:0]temp_sumi;
 reg [out_f-1:0]temp_sumf;
 wire signed [3:0] max_int ;
     

 always@(*)
 begin
 ai=a[i1+f1-1:f1];
 af=a[f1-1:0];
 bi=b[i2+f2-1:f2];
 bf=b[f2-1:0];
 end
 
 always@(posedge clk)
 begin
 if(sign_add)
 begin
 if(i1==i2 && f1==f2)
 begin
    temp_ai=ai;
    temp_bi=bi;
    temp_af=af;
    temp_bf=bf;
 end
 else if(i1>i2 )
 begin
  temp_ai=ai;
  temp_bi={{(i1-i2){bi[i2-1]}},bi};
  if(f1>=f2)
  begin
    temp_af=af;
    temp_bf={bf,{(f1-f2){1'b0}}};
  end
  else if(f2>f1)
  begin  
    temp_bf=bf;
    temp_af={af,{(f2-f1){1'b0}}};
  end
 end
 else if(i2>i1)
   begin
   temp_bi=bi;
   temp_ai={{(i2-i1){ai[i1-1]}},ai};
    if(f1>f2)
    begin
      temp_af=af;
      temp_bf={bf,{(f1-f2){1'b0}}};
    end
    else if(f2>f1)
    begin  
      temp_bf=bf;
      temp_af={af,{(f2-f1){1'b0}}};
    end
   end
   temp_a={temp_ai,temp_af};
   temp_b={temp_bi,temp_bf};
   temp_sum=$signed(temp_a)+$signed(temp_b);
   
 end
 end
 //assign sum=temp_sum;

 always@(posedge clk)
 begin
 if(!sign_add)
 begin
 if(i1==i2 && f1==f2)
 begin
 temp_ai=ai;
     temp_bi=bi;
     temp_af=af;
     temp_bf=bf;
     end
// temp_sum=a+b;
// overflow=temp_sum[high_i+high_f];
 else if(i1>=i2 )
  begin
   temp_ai=ai;
   temp_bi={{(i1-i2){1'b0}},bi};
   if(f1>=f2)
   begin
     temp_af=af;
     temp_bf={bf,{(f1-f2){1'b0}}};
   end
   else if(f2>f1)
   begin  
     temp_bf=bf;
     temp_af={af,{(f2-f1){1'b0}}};
   end
  end
  else if(i2>i1)
    begin
    temp_bi=bi;
    temp_ai={{(i2-i1){1'b0}},ai};
     if(f1>f2)
     begin
       temp_af=af;
       temp_bf={bf,{(f1-f2){1'b0}}};
     end
     else if(f2>f1)
     begin  
       temp_bf=bf;
       temp_af={af,{(f2-f1){1'b0}}};
     end
   end
    temp_a={temp_ai,temp_af};
    temp_b={temp_bi,temp_bf};
    temp_sum=temp_a+temp_b;
 
 //overflow=temp_sum[high_i+high_f-1];
 end
 end
 //assign sum=temp_sum;
// assign overflow=temp_sum[high_i+high_f-1];
always@(posedge clk)
begin
if(sign_add)
begin
if(out_i>high_i)
overflow=0;
else if(out_i==high_i)
overflow=(temp_a[high_i+high_f-1]^temp_sum[high_i+high_f-1]) && (temp_b[high_i+high_f-1]^temp_sum[high_i+high_f-1]); 
else if(temp_sum[high_i+high_f]==0)
overflow=|temp_sum[high_i+high_f:(high_i+high_f-(high_i-(out_i)))];
else if(temp_sum[high_i+high_f]==1)
overflow=(~(&temp_sum[high_i+high_f:high_f+out_i]));
else
overflow=0;//==temp_sum[high_i+high_f]);//overflow=0;
end
else 
begin
if(out_i>high_i)
overflow=0;
else
overflow=|temp_sum[high_i+high_f:(high_i+high_f-(high_i-out_i))];
end
end
always@(posedge clk)
begin
if(sign_add==0)
begin
if(overflow)
//sum={{out_i{1'b1}},{temp_sum[high_f-1:0]}};
temp_sumi={{out_i{1'b1}}};
else
//sum=temp_sum;//{{temp_sum[high_i+high_f:high_f],;//{{out_i{1'b1}},{temp_sum[high_f-1:high_f-out_i]}};
temp_sumi=temp_sum[high_i+high_f:high_f];

end

else
begin
if(overflow)
begin
if(temp_sum[high_i+high_f]==0)
//sum= {{temp_sum[high_i+high_f]},{(out_i-1){1'b1}},{temp_sum[high_f-1:0]}};
temp_sumi={{temp_sum[high_i+high_f]},{(out_i-1){1'b1}}};
else if(temp_sum[high_i+high_f]==1)
//sum={{temp_sum[high_i+high_f]},{(out_i-1){1'b0}},{temp_sum[high_f-1:0]}};
temp_sumi={{temp_sum[high_i+high_f]},{(out_i-1){1'b0}}};
end
else
temp_sumi=temp_sum[high_i+high_f:high_f];
//sum={{temp_sum[high_i+high_f:high_f]},{temp_sum[high_f-1:0]}};//{temp_sum[high_f-1:high_f-out_i]}};
end

end



always@(posedge clk)
begin
if(sign_add==0)
begin
if(out_f>=high_f)
underflow=0;
else if(//temp_sum[high_i+high_f:high_f]==0 && (temp_sum[high_f-1:0]!=0) &&
 out_f<high_f)
underflow=|temp_sum[high_f-out_f-1:0];
else
underflow=0;
end
else
begin
if(out_f>=high_f)
underflow=0;
else 
//if(temp_sum[high_i+high_f]==0)
underflow=|temp_sum[high_f-out_f-1:0];
//else
//underflow=(~(&temp_sum[high_f-out_f-1:0]));
end
end
always@(posedge clk)
begin
if(sign_add==1)
begin
if(underflow)
//sum={{temp_sum[high_i+high_f:high_f]},{{high_f-out_i}{1'b0}},{1'b1}};
temp_sumf={{{high_f-(high_f-out_f)-1}{1'b0}},{1'b1}};
else
//sum=temp_sum;
temp_sumf=temp_sum[high_f-1:0];
end
else
begin
if(underflow)
//sum={{temp_sum[high_i+high_f:high_f]},{{high_f-out_i}{1'b0}},{1'b1}};temp_out[f-1:f-out_f+1]
temp_sumf={{temp_sum[high_f-1:(high_f-out_f)+1]},{1'b1}};
else
//sum={{temp_sum[high_i+high_f:high_f]},{temp_sum[high_f-1:high_f-(high_f-out_f)]}};
temp_sumf=temp_sum[high_f-1:high_f-out_f];
end
end
//always@(posedge clk)
//begin
//if(sign_add==0)
//begin
//if(overflow)
//sum={{out_i{1'b1}},{temp_sum[high_f-1:0]}};
//else if(underflow)
//sum={{temp_sum[high_i+high_f:high_f]},{{high_f-out_i}{1'b0}},{1'b1}};
//else
//sum={{temp_sum[high_i+high_f:high_f]},{temp_sum[high_f-1:(high_f-(high_f-out_f))]}};
//end
//else
//begin
//if(overflow & temp_sum[high_i+high_f]==0)
//sum= {{temp_sum[high_i+high_f]},{(out_i-1){1'b1}},{temp_sum[high_f-1:0]}};
//else if(overflow & temp_sum[high_i+high_f]==1)
//sum={{temp_sum[high_i+high_f]},{(out_i-1){1'b0}},{temp_sum[high_f-1:0]}};
//else if(underflow & temp_sum[high_i+high_f]==0)
//sum={{temp_sum[high_i+high_f:high_f]},{{high_f-out_i}{1'b0}},{1'b1}};
//else if(underflow & temp_sum[high_i+high_f]==1)
//sum={{temp_sum[high_i+high_f:high_f]},{{high_f-out_i}{1'b1}},{1'b0}};
//else
//sum=temp_sum;

//end
//end
assign sum={{temp_sumi},{temp_sumf}};

endmodule
