module d_reg(clk,q,d,clr);
parameter width =32 , prop =8;
input clk,clr ;
output [width-1:0] q;
input [width-1:0] d;
reg [width-1:0] q;

always @(negedge clr)
   begin 
	#(prop) q=0;

   end

always @(negedge clk)
   begin	
	#(prop) q = d;
   end
  
endmodule  
