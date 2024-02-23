/*
--
--  LOGIC CORE:          12x12 Firm Multiplier
--  MODULE NAME:         top
--  COMPANY:             Copyright 2002 Altera Corporation.
--                       www.altera.com 
--  PROGRAMMER:          SYL
--  REVISION HISTORY:  	 Revision 1.0  07/31/2003  
--  DESCRIPTION:         Initial Release.
--
--  FUNCTIONAL DESCRIPTION:
--
--  This a design example of a 12x12 Firm Multiplier. This design
--  was created to show users how to implement a multiplier
--  consisting of a combination of LEs and DSP Blocks. This design
--  accepts signed inputs and produces signed outputs.
--
--  Copyright  2002 Altera Corporation.,   All rights reserved.  
--  Warning: THis program is protected by copyright law and
--  international treaties.  Unauthorized distribution of this program,
--  or any portion of it, may resulte in severe civil and criminal
--  penalties, and will be prosecuted to the maximum extent possible
--  under the law.
*/

module top (result, data_a, data_b, clk, sclr);

output [23:0] result;
input [11:0] data_a;
input [11:0] data_b;
input clk, sclr;

reg [23:0] result;
reg [11:0] le_mult2_out;
reg [15:0] le_mult1_out;
reg [17:0] dsp_mult_out;
reg [11:0] add1_out;
reg [14:0] add2_out;

// LE-Based multiplier implemented using altmult_add megafunction (LE Multiplier 2)
le_mult2 le_mult2_inst (.dataa_0(data_a[11:9]),.datab_0(data_b[8:0]),.clock0(clk),.aclr0(sclr),.result(le_mult2_out));

// LE-Based multiplier implemented using altmult_add megafunction (LE Multiplier 1)
le_mult1 le_mult1_inst (.dataa_0(data_a[11:0]),.datab_0(data_b[11:9]),.clock0(clk),.aclr0(sclr),.result(le_mult1_out));

// DSP Block-Based multiplier implemented using altmult_add megafunction
dsp_mult dsp_mult_inst (.dataa_0(data_a[8:0]),.datab_0(data_b[8:0]),.clock0(clk),.aclr0(sclr),.result(dsp_mult_out));

// Computation of bit shifting and end-stage adder
always @(posedge clk)
begin
	if (sclr)
	begin
		add1_out = 12'b0;
		add2_out = 15'b0;
		result = 24'b0;
	end
	else
	begin
		add1_out = le_mult2_out + dsp_mult_out[17:9];
		add2_out = {add1_out[11],add1_out[11],add1_out[11],add1_out} + le_mult1_out;
		result = {add2_out,dsp_mult_out[8:0]};
	end
end

endmodule