`timescale 1 ps / 1 ps

module latch ( d, clk, q );
   input  d;
   input  clk;
   output q;
   reg    q;
   
   always@ ( d or clk ) begin
       if ( ~clk ) begin
           q = d;
       end 
   end
endmodule 