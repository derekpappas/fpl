// megafunction wizard: %ALTSYNCRAM%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altsyncram 

// ============================================================
// File Name: mem16x18.v
// Megafunction Name(s):
// 			altsyncram
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
// ************************************************************


//Copyright (C) 1991-2003 Altera Corporation
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


module mem16x18 (
	address,
	clock,
	aclr,
	q);

	input	[3:0]  address;
	input	  clock;
	input	  aclr;
	output	[17:0]  q;

	wire [17:0] sub_wire0;
	wire [17:0] q = sub_wire0[17:0];

	altsyncram	altsyncram_component (
				.aclr0 (aclr),
				.clock0 (clock),
				.address_a (address),
				.q_a (sub_wire0));
	defparam
		altsyncram_component.operation_mode = "ROM",
		altsyncram_component.width_a = 18,
		altsyncram_component.widthad_a = 4,
		altsyncram_component.numwords_a = 16,
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.width_byteena_a = 1,
		altsyncram_component.outdata_reg_a = "CLOCK0",
		altsyncram_component.outdata_aclr_a = "CLEAR0",
		altsyncram_component.address_aclr_a = "CLEAR0",
		altsyncram_component.read_during_write_mode_mixed_ports = "DONT_CARE",
		altsyncram_component.ram_block_type = "AUTO",
		altsyncram_component.init_file = "C:/DSP/soft_mult_an/sum_mult_fixed/16x18mem.mif",
		altsyncram_component.intended_device_family = "Stratix";


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: VarWidth NUMERIC "0"
// Retrieval info: PRIVATE: WIDTH_WRITE_A NUMERIC "18"
// Retrieval info: PRIVATE: WIDTH_WRITE_B NUMERIC "18"
// Retrieval info: PRIVATE: WIDTH_READ_A NUMERIC "18"
// Retrieval info: PRIVATE: WIDTH_READ_B NUMERIC "18"
// Retrieval info: PRIVATE: MEMSIZE NUMERIC "288"
// Retrieval info: PRIVATE: Clock NUMERIC "0"
// Retrieval info: PRIVATE: rden NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE_A NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE_B NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "9"
// Retrieval info: PRIVATE: Clock_A NUMERIC "0"
// Retrieval info: PRIVATE: Clock_B NUMERIC "0"
// Retrieval info: PRIVATE: REGdata NUMERIC "1"
// Retrieval info: PRIVATE: REGwraddress NUMERIC "1"
// Retrieval info: PRIVATE: REGwren NUMERIC "1"
// Retrieval info: PRIVATE: REGrdaddress NUMERIC "1"
// Retrieval info: PRIVATE: REGrren NUMERIC "1"
// Retrieval info: PRIVATE: REGq NUMERIC "1"
// Retrieval info: PRIVATE: INDATA_REG_B NUMERIC "0"
// Retrieval info: PRIVATE: WRADDR_REG_B NUMERIC "0"
// Retrieval info: PRIVATE: OUTDATA_REG_B NUMERIC "0"
// Retrieval info: PRIVATE: CLRdata NUMERIC "1"
// Retrieval info: PRIVATE: CLRwren NUMERIC "1"
// Retrieval info: PRIVATE: CLRwraddress NUMERIC "1"
// Retrieval info: PRIVATE: CLRrdaddress NUMERIC "1"
// Retrieval info: PRIVATE: CLRrren NUMERIC "1"
// Retrieval info: PRIVATE: CLRq NUMERIC "1"
// Retrieval info: PRIVATE: BYTEENA_ACLR_A NUMERIC "0"
// Retrieval info: PRIVATE: INDATA_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: WRCTRL_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: WRADDR_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: OUTDATA_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: BYTEENA_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: enable NUMERIC "0"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_MIXED_PORTS NUMERIC "2"
// Retrieval info: PRIVATE: BlankMemory NUMERIC "0"
// Retrieval info: PRIVATE: MIFfilename STRING "C:/DSP/soft_mult_an/sum_mult_fixed/16x18mem.mif"
// Retrieval info: PRIVATE: UseLCs NUMERIC "0"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
// Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
// Retrieval info: PRIVATE: MEM_IN_BITS NUMERIC "0"
// Retrieval info: PRIVATE: OPERATION_MODE NUMERIC "0"
// Retrieval info: PRIVATE: UseDPRAM NUMERIC "1"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Stratix"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "ROM"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "18"
// Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "4"
// Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "16"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
// Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
// Retrieval info: CONSTANT: OUTDATA_REG_A STRING "CLOCK0"
// Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "CLEAR0"
// Retrieval info: CONSTANT: ADDRESS_ACLR_A STRING "CLEAR0"
// Retrieval info: CONSTANT: READ_DURING_WRITE_MODE_MIXED_PORTS STRING "DONT_CARE"
// Retrieval info: CONSTANT: RAM_BLOCK_TYPE STRING "AUTO"
// Retrieval info: CONSTANT: INIT_FILE STRING "C:/DSP/soft_mult_an/sum_mult_fixed/16x18mem.mif"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Stratix"
// Retrieval info: USED_PORT: q 0 0 18 0 OUTPUT NODEFVAL q[17..0]
// Retrieval info: USED_PORT: address 0 0 4 0 INPUT NODEFVAL address[3..0]
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
// Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT GND aclr
// Retrieval info: CONNECT: q 0 0 18 0 @q_a 0 0 18 0
// Retrieval info: CONNECT: @address_a 0 0 4 0 address 0 0 4 0
// Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @aclr0 0 0 0 0 aclr 0 0 0 0
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
