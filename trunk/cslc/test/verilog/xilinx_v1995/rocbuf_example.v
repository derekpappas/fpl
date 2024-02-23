/* 
 Note: In Synplify, set blackbox attribute for ROCBUF as follows: 
module ROCBUF (I, O); //synthesis syn_black_box 
input I; 
output O; 
endmodule  
*/ 
module rocbuf_example (reset, clk, d0, d1, q0, q1) 
 ; 
input reset; 
input clk ; 
input d0; 
input d1; 
output q0 ; 
output q1 ; 
reg q0, q1; 
wire reset_int; 
ROCBUF u1 (.I(reset), .O(reset_int)); 
always @ (posedge clk or posedge reset_int) begin 
  if  (reset_int) begin 
    q0 = 1'b0; 
    q1 = 1'b1; 
    end 
  else 
    begin 
    q0 = d0; 
    q1 = d1; 
    end 
  end 
endmodule  
module ROCBUF (I, O);  
input I; 
output O; 
endmodule       
