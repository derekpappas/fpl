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

module control(
	aclr,
	data_valid,
	clk,
	data_end,
	rama_rden,
	ramb_rden,
	ramc_rden,
	rama_wren,
	ramb_wren,
	ramc_wren,
	row_end,
	rama_rdadd,
	rama_wradd,
	ramb_rdadd,
	ramb_wradd,
	ramc_rdadd,
	ramc_wradd,
	sel_row1,
	sel_row2,
	sel_row3
);

input	aclr;
input	data_valid;
input	clk;
output	data_end;
output	rama_rden;
output	ramb_rden;
output	ramc_rden;
output	rama_wren;
output	ramb_wren;
output	ramc_wren;
output	row_end;
output	[4:0] rama_rdadd;
output	[4:0] rama_wradd;
output	[4:0] ramb_rdadd;
output	[4:0] ramb_wradd;
output	[4:0] ramc_rdadd;
output	[4:0] ramc_wradd;
output	[1:0] sel_row1;
output	[1:0] sel_row2;
output	[1:0] sel_row3;



gen_ram_rdadd	b2v_gen_ram_rdadd_u1(.clk(clk),.aclr(aclr),.sel_rama(rama_rden),.sel_ramb(ramb_rden),.sel_ramc(ramc_rden),.row_end(row_end),.rama_rdadd(rama_rdadd),.ramb_rdadd(ramb_rdadd),.ramc_rdadd(ramc_rdadd));
defparam	b2v_gen_ram_rdadd_u1.idle = 0;
defparam	b2v_gen_ram_rdadd_u1.NA_row = 3;
defparam	b2v_gen_ram_rdadd_u1.PPR = 8;
defparam	b2v_gen_ram_rdadd_u1.RAMWIDTH = 5;
defparam	b2v_gen_ram_rdadd_u1.repeatA = 1;
defparam	b2v_gen_ram_rdadd_u1.repeatB = 2;
defparam	b2v_gen_ram_rdadd_u1.repeatC = 3;

gen_ram_rden	b2v_gen_ram_rden_u1(.clk(clk),.aclr(aclr),.rama_wren(rama_wren),.ramb_wren(ramb_wren),.ramc_wren(ramc_wren),.rama_rden(rama_rden),.ramb_rden(ramb_rden),.ramc_rden(ramc_rden),.data_end(data_end),.sel_row1_out(sel_row1),.sel_row2_out(sel_row2),.sel_row3_out(sel_row3));
defparam	b2v_gen_ram_rden_u1.A = 2;
defparam	b2v_gen_ram_rden_u1.B = 3;
defparam	b2v_gen_ram_rden_u1.C = 4;
defparam	b2v_gen_ram_rden_u1.idle = 0;
defparam	b2v_gen_ram_rden_u1.ZF = 1;

gen_ram_wradd	b2v_gen_ram_wradd_u1(.clk(clk),.aclr(aclr),.rama_wren(rama_wren),.ramb_wren(ramb_wren),.ramc_wren(ramc_wren),.rama_wradd(rama_wradd),.ramb_wradd(ramb_wradd),.ramc_wradd(ramc_wradd));

gen_ram_wren	b2v_gen_ram_wren_u1(.clk(clk),.aclr(aclr),.data_valid(data_valid),.rama_wren(rama_wren),.ramb_wren(ramb_wren),.ramc_wren(ramc_wren));
defparam	b2v_gen_ram_wren_u1.idle = 0;
defparam	b2v_gen_ram_wren_u1.rowA = 1;
defparam	b2v_gen_ram_wren_u1.rowB = 2;
defparam	b2v_gen_ram_wren_u1.rowC = 3;




endmodule
