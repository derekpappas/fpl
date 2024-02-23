// Copyright (C) 1991-2002 Altera Corporation
// Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
// support information,  device programming or simulation file,  and any other
// associated  documentation or information  provided by  Altera  or a partner
// under  Altera's   Megafunction   Partnership   Program  may  be  used  only
// to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
// other  use  of such  megafunction  design,  netlist,  support  information,
// device programming or simulation file,  or any other  related documentation
// or information  is prohibited  for  any  other purpose,  including, but not
// limited to  modification,  reverse engineering,  de-compiling, or use  with
// any other  silicon devices,  unless such use is  explicitly  licensed under
// a separate agreement with  Altera  or a megafunction partner.  Title to the
// intellectual property,  including patents,  copyrights,  trademarks,  trade
// secrets,  or maskworks,  embodied in any such megafunction design, netlist,
// support  information,  device programming or simulation file,  or any other
// related documentation or information provided by  Altera  or a megafunction
// partner, remains with Altera, the megafunction partner, or their respective
// licensors. No other licenses, including any licenses needed under any third
// party's intellectual property, are provided herein.

module filter(
	clk,
	aclr,
	clken,
	coef1_1,
	coef1_2,
	coef1_3,
	coef2_1,
	coef2_2,
	coef2_3,
	coef3_1,
	coef3_2,
	coef3_3,
	row1_1,
	row1_2,
	row1_3,
	row2_1,
	row2_2,
	row2_3,
	row3_1,
	row3_2,
	row3_3,
	result
);

input	clk;
input   aclr;
input   clken;
input	[8:0] coef1_1;
input	[8:0] coef1_2;
input	[8:0] coef1_3;
input	[8:0] coef2_1;
input	[8:0] coef2_2;
input	[8:0] coef2_3;
input	[8:0] coef3_1;
input	[8:0] coef3_2;
input	[8:0] coef3_3;
input	[7:0] row1_1;
input	[7:0] row1_2;
input	[7:0] row1_3;
input	[7:0] row2_1;
input	[7:0] row2_2;
input	[7:0] row2_3;
input	[7:0] row3_1;
input	[7:0] row3_2;
input	[7:0] row3_3;
output	[19:0] result;


wire	[18:0] res_blka;
wire	[18:0] res_blkb;
wire	[18:0] res_blkc;
wire    [16:0] res;

wire [8:0] row1_1_x;
wire [8:0] row1_2_x;
wire [8:0] row1_3_x;
wire [8:0] row2_1_x;
wire [8:0] row2_2_x;
wire [8:0] row2_3_x;
wire [8:0] row3_1_x;
wire [8:0] row3_2_x;
wire [8:0] row3_3_x;


assign  res_blkc[17:0] = { res[16], res[16], res[16:0]};
assign result = res_blka + res_blkb + res_blkc;

assign row1_1_x = {1'b0, row1_1};
assign row1_2_x = {1'b0, row1_2};
assign row1_3_x = {1'b0, row1_3};
assign row2_1_x = {1'b0, row2_1};
assign row2_2_x = {1'b0, row2_2};
assign row2_3_x = {1'b0, row2_3};
assign row3_1_x = {1'b0, row3_1};
assign row3_2_x = {1'b0, row3_2};
assign row3_3_x = {1'b0, row3_3};

//PIPELINE = NO
//four_mult_two_add	b2v_inst(.dataa_0(row1_1),.dataa_1(row1_2),.dataa_2(row1_3),.dataa_3(row2_1),.datab_0(coef1_1),.datab_1(coef1_2),.datab_2(coef1_3),.datab_3(coef2_1),.result(res_blka));
//four_mult_two_add	b2v_inst1(.dataa_0(row2_2),.dataa_1(row2_3),.dataa_2(row3_1),.dataa_3(row3_2),.datab_0(coef2_2),.datab_1(coef2_3),.datab_2(coef3_1),.datab_3(coef3_2),.result(res_blkb));
//one_mult	b2v_inst3(.dataa_0(row3_3),.datab_0(coef3_3),.result(res));

//PIPELINE = YES
four_mult_two_add	b2v_inst(.clock0(clk),.aclr0(aclr),.ena0(clken),.dataa_0(row1_1_x),.dataa_1(row1_2_x),.dataa_2(row1_3_x),.dataa_3(row2_1_x),.datab_0(coef1_1),.datab_1(coef1_2),.datab_2(coef1_3),.datab_3(coef2_1),.result(res_blka));
four_mult_two_add	b2v_inst1(.clock0(clk),.aclr0(aclr),.ena0(clken),.dataa_0(row2_2_x),.dataa_1(row2_3_x),.dataa_2(row3_1_x),.dataa_3(row3_2_x),.datab_0(coef2_2),.datab_1(coef2_3),.datab_2(coef3_1),.datab_3(coef3_2),.result(res_blkb));
one_mult	b2v_inst3(.clock0(clk),.aclr0(aclr),.ena0(clken),.dataa_0(row3_3_x),.datab_0(coef3_3),.result(res));


endmodule
