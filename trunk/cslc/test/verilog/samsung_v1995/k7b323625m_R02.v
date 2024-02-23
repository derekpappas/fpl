/****************************************************************************************
* 
*  SAMSUNG 32Mb SB SRAM Verilog Behavioral model
*  
*  Description :  K7B323625M (1M x 36)
*
*  File Name   :  k7b323625m.v 
*  Version     :  Rev0.2 
*  Date        :  Dec 22th, 2001
*
*  Simulator   :  Velilog-XL (CADENCE)
*
*  Author      :  Seungmin Lee 
*  Email       :  smlee5253@samsung.co.kr
*  Phone       :  (82) 31-209-3823 
*  Company     :  SAMSUNG ELECTRONICS Co,. LTD.
*
*  Note        :  - Set simulator resolution to "ps" timescale
*                 - IEEE 1149.1 Serial Boundary Scan (JTAG) is not implemented
*		  - Following case is prohibited 
*			-- Not selected -> (Continue or Suspend)  Read/Write
*		  - Not selected operate after "tHZC" delay of the same clock 
*                 - CS2, CS2_N is used only 100-TQFP.
*                   if you want to use in the 119-BGA or 165-FGBA, you must set CS2 = '1' and CS2_N = '0' in the input file
*
*        Copyright(c) SAMSUNG ELECTRONICS Co,. 2001 
*        All rights reserved
*  
*   Revision History :
*
*   Rev  Author          Phone            Date        Changes
*   ---  --------------  --------------   ----------  --------------------------------------
*   0.0  Seungmin Lee   (82) 31-209-3823  10/11/2001  
*   0.1  Seungmin Lee   (82) 31-209-3823  11/22/2001  modify the part of CLK, async signal  
*   0.2  Seungmin Lee   (82) 31-209-3823  12/22/2001  correct the pin configuration
*
****************************************************************************************/

// Define time scale $ accuracy  
`timescale 1ns / 1ps

`ifdef qc65
	`define		tCYC	7.5
	`define		tCD	6.5
	`define		tHZC	3.8
	`define		tLZC	2.5
	`define		tLZOE	0.1	
	`define		tHZOE	3.5	
	`define		tCH	2.2	
	`define		tCL	2.2	
	`define		tAS	1.5	
	`define		tSS	1.5	
	`define		tDS	1.5	
	`define		tWS	1.5	
	`define		tADVS	1.5	
	`define		tCSS	1.5	
	`define		tAH	0.5	
	`define		tSH	0.5	
	`define		tDH	0.5	
	`define		tWH	0.5	
	`define		tADVH	0.5	
	`define		tCSH	0.5	
	`define		tPDS	15	
	`define		tPUS	15	
`endif

`ifdef qc75
	`define		tCYC	8.5	
	`define		tCD	7.5	
	`define		tHZC	4.0	
	`define		tLZC	2.5	
	`define		tLZOE	0.1	
	`define		tHZOE	3.5	
	`define		tCH	2.5	
	`define		tCL	2.5	
	`define		tAS	2.0	
	`define		tSS	2.0	
	`define		tDS	2.0	
	`define		tWS	2.0	
	`define		tADVS	2.0	
	`define		tCSS	2.0	
	`define		tAH	0.5	
	`define		tSH	0.5	
	`define		tDH	0.5	
	`define		tWH	0.5	
	`define		tADVH	0.5	
	`define		tCSH	0.5	
	`define		tPDS	17	
	`define		tPUS	17	
`endif

`ifdef qc85
	`define		tCYC	10.0	
	`define		tCD	8.5	
	`define		tHZC	5.0	
	`define		tLZC	2.5
	`define		tLZOE	0.1	
	`define		tHZOE	4.0	
	`define		tCH	3.0	
	`define		tCL	3.0	
	`define		tAS	2.0	
	`define		tSS	2.0	
	`define		tDS	2.0	
	`define		tWS	2.0	
	`define		tADVS	2.0	
	`define		tCSS	2.0	
	`define		tAH	0.5	
	`define		tSH	0.5	
	`define		tDH	0.5	
	`define		tWH	0.5	
	`define		tADVH	0.5	
	`define		tCSH	0.5	
	`define		tPDS	20.0	
	`define		tPUS	20.0	
`endif


// speed option 

////////////////////////////////////////////////////////////////////////////////
//////////////////       Main module       ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

module k7b323625m (A, ADV_N, ADSP_N, ADSC_N, CLK, CS1_N, CS2, CS2_N, WE_N, OE_N, GW_N, BW_N, ZZ, LBO_N, DQ);

	// Constant Parameters
	parameter	addr_bits =      20;    // This is external address
	parameter	data_bits =      36;
	parameter	mem_sizes =  1048575;

	// Port Declaration
	input		[addr_bits - 1 : 0]	A;
	input					ADV_N;
	input					ADSP_N;
	input					ADSC_N;
	input					CLK;
	input					CS1_N;
	input					CS2;
	input					CS2_N;
	input		[3 : 0]			WE_N;
	input					OE_N;
	input					GW_N;
	input					BW_N;
	input					ZZ;
	input					LBO_N;
	inout		[data_bits - 1 : 0]	DQ;

	reg		[data_bits - 1 : 0]	SMEM [0 : mem_sizes];
	reg					Write_N;
	reg					zz_tm;
	reg		[addr_bits -1 : 0]	Addr_reg;
	reg		[addr_bits -1 : 0]	Init_addr;
	reg		[data_bits -1 : 0]	Out_reg;
	reg		[data_bits -1 : 0]	Out_buf;
	reg		[data_bits -1 : 0]	Out_buf_tm;
	reg		[data_bits -1 : 0]	In_reg;
	reg		[data_bits -1 : 0]	Data_tm;
	reg		[2 : 0]			Command_pi	[0 : 1];	// 001 : Begin Read, 010 : Begin Write, 
										// 011 : Conti Read, 100 : Conti Write
										// 101 : Suspend Read, 110 : Suspend Write			
	reg		[addr_bits - 1 : 0]	Addr_pi		[0 : 1];
	reg		[addr_bits - 1 : 0]	Addr_tm;		
	reg		[1 : 0]			Baddr_tb	[0 : 3]; 	
	reg					Int_clk;
	reg					enable;
	
	integer					id;
	integer					addr_cnt;


	// Initial Condition
	initial begin	
		enable = 0;
		zz_tm = 0;
		Baddr_tb[0] = 2'b00;
		Baddr_tb[1] = 2'b01;
		Baddr_tb[2] = 2'b10;
		Baddr_tb[3] = 2'b11;
		Out_reg = {data_bits{1'bz}};
		Out_buf = {data_bits{1'bz}};
	end	// initial end

	always	@ (posedge CLK) begin
			Int_clk = CLK & ~zz_tm;
	end

	always	@ (negedge CLK) begin
			Int_clk = 1'b0;
	end

	always  @ (posedge ZZ) begin
		zz_tm <= #`tPDS ZZ;
		Out_buf <= #`tPDS {data_bits{1'bz}};
		Command_pi[0] = 3'b111;
	end

	always  @ (negedge ZZ) begin
		zz_tm <= #`tPUS ZZ;
	end

	always	@ (posedge OE_N) begin
			enable <= #`tHZOE OE_N;
	end

	always	@ (negedge OE_N) begin
			enable <= #`tLZOE OE_N;
	end

	assign 	DQ = enable ? {data_bits{1'bz}} : Out_buf;

	always @ (posedge Int_clk) begin	// always-00

	$display("$m : at time %t : ----------------------------------------------------------------------------------------",$time);	
	// Command pipe
	Command_pi[1] = Command_pi[0];
	Command_pi[0] = 3'b111;

	// Address pipe
	Addr_pi[1] = Addr_pi[0];
	Addr_pi[0] = {addr_bits{1'bx}};

	if (GW_N == 1'b0 || (GW_N == 1'b1 && BW_N == 1'b0 && (WE_N[0] == 1'b0 || WE_N[1] == 1'b0 || WE_N[2] == 1'b0 || WE_N[3] == 1'b0))) begin	// if-00
		Write_N = 1'b0;
	end 	// end-00 
	else begin	// if-000
		Write_N = 1'b1;
	end	// end-000
	  
	if (ZZ == 1'b0) begin
	// Begin Read or Write
	if ((CS1_N == 1'b0) && (CS2 == 1'b1) && (CS2_N == 1'b0)) begin	// if-01
		if (ADSP_N == 1'b0 || (ADSP_N == 1'b1 && ADSC_N == 1'b0 && Write_N == 1'b1)) begin	// if-02
			// begin read
			$display("$m : at time %t : comand = begin read !!",$time); 
			Command_pi[0] = 3'b001;
			Addr_pi[0] = A;
			Init_addr = A;
		end	// end-02
		else if (ADSP_N == 1'b1 && ADSC_N == 1'b0 && Write_N == 1'b0 ) begin	// if-03
			// begin write
			$display("$m : at time %t : comand = begin write !!",$time); 
			Command_pi[0] = 3'b010;
			Addr_pi[0] = A;  
			Init_addr = A;
		end	// end-03
	end	// end-01

	// Continue Read or Write 
	else if (((ADSP_N == 1'b1 && ADSC_N == 1'b1) || (CS1_N == 1'b1 && ADSC_N == 1'b1)) && ADV_N == 1'b0) begin	// if-04

		if (Command_pi[1] !== 3'b111) begin	// if-040
			if (Write_N == 1'b1) begin	// if-05
				// continue read
				$display("$m : at time %t : comand = continue read !!",$time); 
				Command_pi[0] = 3'b011;
				AddrCnt;

			end 	// end-05
			else if (Write_N == 1'b0) begin	// if-06
				// continue write
				$display("$m : at time %t : comand = continue write !!",$time); 
				Command_pi[0] = 3'b100;  
				AddrCnt;
			end	// end-06
		end 	// end-040	
	end	// end-04

	// Suspend Read or Write
	else if (((ADSP_N == 1'b1 && ADSC_N == 1'b1) || (CS1_N == 1'b1 && ADSC_N == 1'b1)) && ADV_N == 1'b1) begin 	// if-07
		if (Command_pi[1] !== 3'b111) begin	// if-070
			if (Write_N == 1'b1) begin 	// if-08
				// suspend read
				$display("$m : at time %t : comand = suspend read !!",$time); 
				Command_pi[0] = 3'b101;
				Addr_pi[0] = Addr_pi[1];  
			end	// end-08
			if (Write_N == 1'b0) begin	// if-09
				// suspend write
				$display("$m : at time %t : comand = suspend write !!",$time); 
				Command_pi[0] = 3'b110;  
				Addr_pi[0] = Addr_pi[1];  
			end 	// end-09
		end	// end-070
	end	// end-07

	if (Command_pi[0] === 3'b111)  begin
		$display("$m : at time %t : Not selected!!", $time);
	end	
	end	

 	// Read Operation
	if (Command_pi[0] === 3'b001 || Command_pi[0] === 3'b011 || Command_pi[0] === 3'b101) begin	// if-10
		Addr_reg = Addr_pi[0];
		Out_reg = SMEM[Addr_reg];
		$display("$m : at time %t : read : address = %h, data = %h!!", $time, Addr_reg, Out_reg); 
		#`tCD Out_buf <= Out_reg;
	end	// end-11

	// Write Operation
	if (Command_pi[0] === 3'b010 || Command_pi[0] === 3'b100 || Command_pi[0] === 3'b110) begin	// if-11
		Addr_reg = Addr_pi[0];
		Data_tm	= SMEM[Addr_reg];
		if(GW_N == 1'b0) begin 	// if-12
			In_reg = DQ;
		end	// end-12
		else if (BW_N == 1'b0) begin	// if-13
			if (WE_N[0] == 1'b0) begin 	// if-14
				Data_tm[data_bits/4 - 1 : 0] = DQ[data_bits/4 - 1 : 0];
			end 	// end-14

			if (WE_N[1] == 1'b0) begin 	// if-15
				Data_tm[data_bits/2 - 1 : data_bits/4] = DQ[data_bits/2 - 1 : data_bits/4];
			end 	// end-15

			if (WE_N[2] == 1'b0) begin 	// if-16
				Data_tm[data_bits*3/4 - 1 : data_bits/2] = DQ[data_bits*3/4 - 1 : data_bits/2];
			end 	// end-16
			 
			if (WE_N[3] == 1'b0) begin 	// if-17
				Data_tm[data_bits - 1 : data_bits*3/4] = DQ[data_bits - 1 : data_bits*3/4];
			end 	// end-17

			In_reg = Data_tm;
		end	// end-13
	 		
		$display("$m : at time %t : write : address = %h, data = %h", $time, Addr_reg, In_reg); 
		SMEM[Addr_reg] = In_reg;
	  
	end	// end-11

	// Not-select Operation
	if (Command_pi[0] === 3'b111) begin
		$display("$m : at time %t : not selected effect ", $time); 
		Out_buf <= #`tHZC {data_bits{1'bz}};
	end

	end	// always_end-00	

	task AddrCnt;
		reg	[addr_bits - 1 : 0]	tmp1, 	tmp2;
	begin
		tmp1 = Addr_pi[1] % 4;
		tmp2 = Addr_pi[1] - tmp1;
		if (LBO_N == 1'b0) begin
			Addr_pi[0] = (tmp1 + 1) % 4;
			Addr_pi[0] = Addr_pi[0] + tmp2;
		end
		else if (LBO_N == 1'b1) begin
			if (Init_addr % 2 == 0) begin 
				Addr_pi[0] = (tmp1 + 1) % 4;
				Addr_pi[0] = Addr_pi[0] + tmp2;
			end
			else begin
				Addr_pi[0] = (tmp1 - 1) % 4;
				Addr_pi[0] = Addr_pi[0] + tmp2;
			end
		end
	end
	endtask

	// Timing Check
	specify
		specparam 	tCYC_p	=	`tCYC,	// cycle time
			 	tCH_p	=	`tCH,	// clock high time 
			 	tCL_p	=	`tCL,	// clock high time 
				tAS_p	=	`tAS,	// address setup to clock high 
				tSS_p	=	`tSS,	// address status setup to clock high
				tDS_p	=	`tDS,	// data setup to clock high
				tWS_p	=	`tWS,	// write setup to clock high
				tADVS_p	=	`tADVS,	// address advance setup to clock high
				tCSS_p	=	`tCSS,	// chip select setup to clock high
				tAH_p	=	`tAH,	// address hold from clock high
				tSH_p	=	`tSH,	// address status hold from clock high
				tDH_p	=	`tDH,	// data hold from clock high
				tWH_p	=	`tWH,	// write hold from clock high
				tADVH_p	=	`tADVH,	// address advance hold from clock high
				tCSH_p	=	`tCSH;	// chip select hold from clock high
		$period		(posedge CLK,	tCYC_p);		
		$period		(negedge CLK,	tCYC_p);		
		$width		(posedge CLK,	tCH_p);		
		$width		(negedge CLK,	tCL_p);		
		$setuphold	(posedge CLK,	A,		tAS_p,	tAH_p); 
		$setuphold	(posedge CLK,	ADSP_N,		tSS_p,	tSH_p); 
		$setuphold	(posedge CLK,	ADSC_N,		tSS_p,	tSH_p); 
		$setuphold	(posedge CLK,	CS1_N,		tCSS_p,	tCSH_p); 
		$setuphold	(posedge CLK,	CS2,		tCSS_p,	tCSH_p); 
		$setuphold	(posedge CLK,	CS2_N,		tCSS_p,	tCSH_p); 
		$setuphold	(posedge CLK,	GW_N,		tWS_p,	tWH_p); 
		$setuphold	(posedge CLK,	BW_N,		tWS_p,	tWH_p); 
		$setuphold	(posedge CLK,	WE_N[0],	tWS_p,	tWH_p); 
		$setuphold	(posedge CLK,	WE_N[1],	tWS_p,	tWH_p); 
		$setuphold	(posedge CLK,	WE_N[2],	tWS_p,	tWH_p); 
		$setuphold	(posedge CLK,	WE_N[3],	tWS_p,	tWH_p); 
	endspecify

endmodule
