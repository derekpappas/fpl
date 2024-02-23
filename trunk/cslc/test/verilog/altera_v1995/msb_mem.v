// megafunction wizard: %RAM: 1-PORT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altsyncram 

// ============================================================
// File Name: msb_mem.v
// Megafunction Name(s):
// 			altsyncram
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
// ************************************************************


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


module msb_mem (
	address,
	clock,
	aclr,
	data,
	wren,
	q);

	input	[7:0]  address;
	input	  clock;
	input	  aclr;
	input	[17:0]  data;
	input	  wren;
	output	[17:0]  q;

	wire [17:0] sub_wire0;
	wire [17:0] q = sub_wire0[17:0];

	altsyncram	altsyncram_component (
				.wren_a (wren),
				.aclr0 (aclr),
				.clock0 (clock),
				.address_a (address),
				.data_a (data),
				.q_a (sub_wire0));
	defparam
		altsyncram_component.intended_device_family = "Stratix",
		altsyncram_component.width_a = 18,
		altsyncram_component.widthad_a = 8,
		altsyncram_component.numwords_a = 256,
		altsyncram_component.operation_mode = "SINGLE_PORT",
		altsyncram_component.outdata_reg_a = "CLOCK0",
		altsyncram_component.indata_aclr_a = "CLEAR0",
		altsyncram_component.wrcontrol_aclr_a = "CLEAR0",
		altsyncram_component.address_aclr_a = "CLEAR0",
		altsyncram_component.outdata_aclr_a = "CLEAR0",
		altsyncram_component.width_byteena_a = 1,
		altsyncram_component.ram_block_type = "AUTO",
		altsyncram_component.init_file = "C:/DSP/soft_mult_an/parallel_var/msb_mem.mif",
		altsyncram_component.lpm_type = "altsyncram";


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: WidthData NUMERIC "18"
// Retrieval info: PRIVATE: WidthAddr NUMERIC "8"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix"
// Retrieval info: PRIVATE: SingleClock NUMERIC "1"
// Retrieval info: PRIVATE: UseDQRAM NUMERIC "1"
// Retrieval info: PRIVATE: RegData NUMERIC "1"
// Retrieval info: PRIVATE: RegAddr NUMERIC "1"
// Retrieval info: PRIVATE: RegOutput NUMERIC "1"
// Retrieval info: PRIVATE: BYTE_ENABLE NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "9"
// Retrieval info: PRIVATE: AclrByte NUMERIC "0"
// Retrieval info: PRIVATE: AclrData NUMERIC "1"
// Retrieval info: PRIVATE: WRCONTROL_ACLR_A NUMERIC "1"
// Retrieval info: PRIVATE: AclrAddr NUMERIC "1"
// Retrieval info: PRIVATE: AclrOutput NUMERIC "1"
// Retrieval info: PRIVATE: Clken NUMERIC "0"
// Retrieval info: PRIVATE: BlankMemory NUMERIC "0"
// Retrieval info: PRIVATE: MIFfilename STRING "C:/DSP/soft_mult_an/parallel_var/msb_mem.mif"
// Retrieval info: PRIVATE: UseLCs NUMERIC "0"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
// Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "256"
// Retrieval info: PRIVATE: DataBusSeparated NUMERIC "1"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Stratix"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "18"
// Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "8"
// Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "256"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "SINGLE_PORT"
// Retrieval info: CONSTANT: OUTDATA_REG_A STRING "CLOCK0"
// Retrieval info: CONSTANT: INDATA_ACLR_A STRING "CLEAR0"
// Retrieval info: CONSTANT: WRCONTROL_ACLR_A STRING "CLEAR0"
// Retrieval info: CONSTANT: ADDRESS_ACLR_A STRING "CLEAR0"
// Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "CLEAR0"
// Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
// Retrieval info: CONSTANT: RAM_BLOCK_TYPE STRING "AUTO"
// Retrieval info: CONSTANT: INIT_FILE STRING "C:/DSP/soft_mult_an/parallel_var/msb_mem.mif"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
// Retrieval info: USED_PORT: address 0 0 8 0 INPUT NODEFVAL address[7..0]
// Retrieval info: USED_PORT: q 0 0 18 0 OUTPUT NODEFVAL q[17..0]
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
// Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT NODEFVAL aclr
// Retrieval info: USED_PORT: data 0 0 18 0 INPUT NODEFVAL data[17..0]
// Retrieval info: USED_PORT: wren 0 0 0 0 INPUT NODEFVAL wren
// Retrieval info: CONNECT: @address_a 0 0 8 0 address 0 0 8 0
// Retrieval info: CONNECT: q 0 0 18 0 @q_a 0 0 18 0
// Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @aclr0 0 0 0 0 aclr 0 0 0 0
// Retrieval info: CONNECT: @data_a 0 0 18 0 data 0 0 18 0
// Retrieval info: CONNECT: @wren_a 0 0 0 0 wren 0 0 0 0
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all