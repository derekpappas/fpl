module oscillator(clk,clk_n);

	parameter cycle =200 ;
	output clk,clk_n;
	reg clock;

	assign clk=clock;
	assign clk_n= ~clock;

initial
	clock = 1;

always
     begin
	#(cycle/2) clock=~clock;
     end

endmodule 