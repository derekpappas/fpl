module inter_poly (
		   clk,
		   clken,
		   reset,
		   x0,
		   result,
		   load_data
		 );

   input clk;
   input clken;
   input reset;
   input [17:0] x0;
   
   output [37:0] result;
   output 		 load_data;

   reg [1:0] 	 address;
   reg 			 rom_clken;
   
   wire 	     clk1x, clk4x;
   wire [17:0] 	 datab_0, datab_1, datab_2, datab_3;
   wire [17:0] 	 rom_out0, rom_out1, rom_out2, rom_out3;
   wire   	     rom_clken_w;
   wire			 locked;


   assign rom_clken_w = locked;
   assign load_data = rom_clken;

   always @ (posedge clk4x) begin
      if (reset)
		 address <= 0;
	  else if (rom_clken)
	 	 address <= address + 1;
   end 


	always @ (posedge clk4x) begin
	    if (reset)
			rom_clken <= 0;
	    else
	   		rom_clken <= rom_clken_w;
	 end


   pll	pll_inst (
		.inclk0 ( clk ),
		.pllena ( clken ),
		.locked ( locked ),
		.c0 ( clk4x ),
		.c1 ( clk1x )
		);


   rom0 rom0 (
	    .address (address),
	    .clock (clk4x),
	    .clken (rom_clken),
	    .q (rom_out0)
	    );

  rom1 rom1 (
	    .address (address),
	    .clock (clk4x),
		.clken (rom_clken),
	    .q (rom_out1)
	    );

  rom2 rom2 (
	    .address (address),
	    .clock (clk4x),
		.clken (rom_clken),
	    .q (rom_out2)
	    );

  rom3 rom3 (
	    .address (address),
	    .clock (clk4x),
		.clken (rom_clken),
	    .q (rom_out3)
	    );

   mult_add mult_add (
		       .clock0 (clk1x),
		       .clock1 (clk4x),
		       .ena0 (rom_clken),
		 	   .ena1 (rom_clken),
		       .aclr3 (reset),
		       .dataa_0 (x0),
		       .datab_0 (rom_out0),
		       .datab_1 (rom_out1),
		       .datab_2 (rom_out2),
		       .datab_3 (rom_out3),
		       .result (result)
		       );

   
   endmodule