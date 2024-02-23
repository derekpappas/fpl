//modiffications by GabrielD at BigSurSoftware.com
module new_event_control(y,a,b,sel);
	output y;
	reg y;
	input a,b,sel;
	
always @* //combinational logic sensitivity
	if (sel)
		y = a;
	else
		y = b;

endmodule

module new_parameter;

parameter [2:0]    // new width
	IDLE = 3'd0,
	READ = 3'd1,
	LOAD = 3'd2,
	SYNC = 3'd3,
	ERROR = 3'd4;

RAM #(.SIZE(1023)) ram2 (); // parameter

endmodule
//added by GabrielD
module RAM;
    parameter [15:0]
       SIZE = 16'd2047;
    reg [7:0]ram[SIZE:0];
endmodule
//end
module mux8 (y, a, b, en);

output reg [7:0] y;
input wire [7:0] a, b;
input wire       en;

endmodule
