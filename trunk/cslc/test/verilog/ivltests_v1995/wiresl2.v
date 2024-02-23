/*
 * This test is from PR#193
 */

module tshl;

   reg [2:0] bit;
   wire [7:0] shbit;
   integer    i;
   

   shl shl_0(shbit, bit);

   initial begin

      for(i = 0; i < 8; i = i + 1) begin
	 bit <= i[2:0];
	 #1
	    $display("out=%h", shbit);
      end // for (i = 0; i < 8; i = i + 1)
      
      $finish;
   end // initial begin
endmodule
     
module shl(out, bit);
   
   output [7:0] out;
   input [2:0] 	bit;

   reg [7:0] 	out_reg;
      
   always @(bit) begin
      out_reg <= 8'h01 << bit;
      
   end // always @ (bit)

   assign out = out_reg;
   
endmodule // shl


   


