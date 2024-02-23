module inc4(out,in);
	parameter width =32, prop = 12;
	output [width-1:0] out;
	input  [width-1:0] in;

        reg [width-1:0] out;

	initial
	out=0;
	always@(in)
	begin

/* This simulates the propogation delay required to increment the value */


        #(prop)  out =  in + 4;
	
	end

endmodule