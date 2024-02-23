//-------------------------------------------------------------------
// This is a status bit module for the 6502 processor project
//
// parameters:
//	clk...........system clock
//	reset.........system reset
//	load..........when true, loads selected data into reg, otherwise hold
//	a.............data input
//	b.............data input
//	c.............data input
//	d.............data input
//	sel...........data input select
//	s.............register output
//---------------------------------------------------------------------

module status(clk,reset,load,a,b,c,d,sel,s);
    input clk;
    input reset;
    input load;
    input a;
    input b;
    input c;
    input d;
    input [1:0] sel;
    output s;

	reg s;

	always @ (posedge clk or posedge reset)
	begin
		if(reset)
			s <= 0;
		else
		begin
			if(load)
			begin
				case (sel)
					2'b00: s <= a;
					2'b01: s <= b;
					2'b10: s <= c;
					2'b11: s <= d;
					default:s <= 1'bx;
				endcase
			end
			else
				s <= s;
		end
	end


endmodule
