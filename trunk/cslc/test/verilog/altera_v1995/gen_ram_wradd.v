module gen_ram_wradd (
clk,
aclr,
rama_wren, 
ramb_wren,
ramc_wren,
rama_wradd,
ramb_wradd,
ramc_wradd);

input clk, aclr;
input rama_wren, ramb_wren, ramc_wren;
output [4:0] rama_wradd, ramb_wradd, ramc_wradd;

	//Register Declaration
	reg [4:0] rama_wradd, ramb_wradd, ramc_wradd;
	
	always @ (posedge clk or posedge aclr)
	begin
		if (aclr)
			rama_wradd <= 0;
		else if (rama_wren)
			rama_wradd <= rama_wradd + 1;
	end
	
	always @ (posedge clk or posedge aclr)
	begin
		if (aclr)
			ramb_wradd <= 0;
		else if (ramb_wren)
			ramb_wradd <= ramb_wradd + 1;
	end
	
	always @ (posedge clk or posedge aclr)
	begin
		if (aclr)
			ramc_wradd <= 0;
		else if (ramc_wren)
			ramc_wradd <= ramc_wradd + 1;
	end

endmodule