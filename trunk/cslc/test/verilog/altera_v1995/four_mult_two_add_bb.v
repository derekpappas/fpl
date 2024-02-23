//Copyright (C) 1991-2002 Altera Corporation
//Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
//support information,  device programming or simulation file,  and any other
//associated  documentation or information  provided by  Altera  or a partner
//under  Altera's   Megafunction   Partnership   Program  may  be  used  only
//to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
//other  use  of such  megafunction  design,  netlist,  support  information,
//device programming or simulation file,  or any other  related documentation
//or information  is prohibited  for  any  other purpose,  including, but not
//limited to  modification,  reverse engineering,  de-compiling, or use  with
//any other  silicon devices,  unless such use is  explicitly  licensed under
//a separate agreement with  Altera  or a megafunction partner.  Title to the
//intellectual property,  including patents,  copyrights,  trademarks,  trade
//secrets,  or maskworks,  embodied in any such megafunction design, netlist,
//support  information,  device programming or simulation file,  or any other
//related documentation or information provided by  Altera  or a megafunction
//partner, remains with Altera, the megafunction partner, or their respective
//licensors. No other licenses, including any licenses needed under any third
//party's intellectual property, are provided herein.

module four_mult_two_add (
	aclr0,
	clock0,
	dataa_0,
	dataa_1,
	datab_0,
	dataa_2,
	datab_1,
	ena0,
	dataa_3,
	datab_2,
	datab_3,
	result);

	input	  aclr0;
	input	  clock0;
	input	[8:0]  dataa_0;
	input	[8:0]  dataa_1;
	input	[8:0]  datab_0;
	input	[8:0]  dataa_2;
	input	[8:0]  datab_1;
	input	  ena0;
	input	[8:0]  dataa_3;
	input	[8:0]  datab_2;
	input	[8:0]  datab_3;
	output	[19:0]  result;

endmodule

