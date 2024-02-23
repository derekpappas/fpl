module unsig_altmult_accum (dataout, dataa, datab, clk, aclr, clken);

input	 	[7:0]		dataa;
input	 	[7:0]		datab;
input				clk;
input 				aclr;
input 				clken;

output		[31:0]		dataout;

reg		[31:0]		dataout;
reg		[7:0]		dataa_reg;
reg		[7:0]		datab_reg;
reg		[15:0]		multa_reg;

wire		[15:0]		multa;
wire		[31:0]		adder_out;

assign multa = dataa_reg * datab_reg;
assign adder_out = multa_reg + dataout; 

always @(posedge clk or posedge aclr)
begin
	if(aclr)
	begin
		dataa_reg <= 0;
		datab_reg <= 0;

		multa_reg <= 0;

		dataout <= 0;
	end

	else if(clken)
	begin
		dataa_reg <= dataa;
		datab_reg <= datab;

		multa_reg <= multa;

		dataout <= adder_out;
	end
end

endmodule
