/****************************************************************************************
* 
*  SAMSUNG 16Mb SP(R-R) SRAM Verilog Behavioral model
*  
*  Description :  k7p401822b (1M x 18)
*
*  File Name   :  k7p401822b.v 
*  Version     :  Rev0.0 
*  Date        :  May 4th, 2002
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
*
*        Copyright(c) SAMSUNG ELECTRONICS Co,. 2001 
*        All rights reserved
*  
*   Revision History :
*
*   Rev  Author          Phone            Date        Changes
*   ---  --------------  --------------   ----------  --------------------------------------
*   0.0  Seungmin Lee   (82) 31-209-3823  3/4/2002  
*
****************************************************************************************/

// Define time scale $ accuracy  
`timescale 1ns / 1ps
//`include "k7p401822b_sop"
`ifdef hc33
	`define 	tKHKH	 	3.0 	
	`define         tKHKL     	1.2 
	`define         tKLKH     	1.2 
 	`define         tKHQV	 	1.5 
 	`define         tKHQX	 	0.5 
	`define         tAVKH	 	0.4 
	`define         tKHAX	 	0.5 
	`define         tDVKH	 	0.4 
	`define         tKHDX	 	0.5 
	`define         tWVKH	 	0.4 
	`define         tKHWX	 	0.5 
	`define         tSVKH	 	0.4 
	`define         tKHSX	 	0.5 
	`define         tKHQZ	 	1.5 
	`define         tKHQX1	 	0.5 
	`define         tGHQZ	 	1.5 	
	`define         tGLQX	 	0.5 	
	`define         tGLQV	 	1.5 	
	`define         tZZE	 	15 	
	`define         tZZR	 	20 	
`endif
`ifdef hc30
        `define         tKHKH           3.3 
        `define         tKHKL           1.3 
        `define         tKLKH           1.3 
        `define         tKHQV           1.6 
        `define         tKHQX           0.5 
        `define         tAVKH           0.5 
        `define         tKHAX           0.5 
        `define         tDVKH           0.5 
        `define         tKHDX           0.5 
        `define         tWVKH           0.5 
        `define         tKHWX           0.5 
        `define         tSVKH           0.5 
        `define         tKHSX           0.5 
        `define         tKHQZ           1.6 
        `define         tKHQX1          0.5 
        `define         tGHQZ           1.6 
        `define         tGLQX           0.5 
        `define         tGLQV           1.6 
        `define         tZZE            15 
        `define         tZZR            20 
`endif

`ifdef hc25
        `define         tKHKH           4.0 
        `define         tKHKL           1.6 
        `define         tKLKH           1.6 
        `define         tKHQV           2.0 
        `define         tKHQX           0.5 
        `define         tAVKH           0.5 
        `define         tKHAX           0.5 
        `define         tDVKH           0.5 
        `define         tKHDX           0.5 
        `define         tWVKH           0.5 
        `define         tKHWX           0.5 
        `define         tSVKH           0.5 
        `define         tKHSX           0.5 
        `define         tKHQZ           2.0 
        `define         tKHQX1          0.5 
        `define         tGHQZ           2.0 
        `define         tGLQX           0.5 
        `define         tGLQV           2.0 
        `define         tZZE            15 
        `define         tZZR            20 
`endif
////////////////////////////////////////////////////////////////////////////////
//////////////////       Main module       ////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

module k7p401822b (DQ, SA, SS_N, SW_N, SBW_N, G_N, ZZ, K, K_N);

	// Constant Parameters
	parameter	addr_bits =      18;	 
	parameter	data_bits =      18;
	parameter	mem_sizes = 1024*1024 - 1;

	// Port Declaration
	input		[addr_bits - 1 : 0]	SA;
	input					SS_N;
	input					SW_N;
	input		[1 : 0]			SBW_N;
	input					G_N;
	input					ZZ;
	input					K;
	input					K_N;
	inout		[data_bits - 1 : 0]	DQ;

	reg		[data_bits - 1 : 0]	SMEM [0 : mem_sizes];

	reg					zz_tm;
	reg					zz_tm1;

	reg		[addr_bits -1 : 0]	waddr;
	reg		[addr_bits -1 : 0]	raddr;

	reg		[data_bits -1 : 0]	Out_buf;
	reg		[data_bits -1 : 0]	Data_tm;
	reg		[1 : 0]			command_pi	[0 : 2];	// 01 : write 
										// 10 : read 
										// 00 : no operation			
	reg		[addr_bits - 1 : 0]	Addr_pi_w		[0 : 1];
	reg		[addr_bits - 1 : 0]	Addr_pi_r		[0 : 1];
	reg		[1 : 0]			BW_pi			[0 : 1];

	reg		[1 : 0]			BW;

	wire					int_clk;
	reg					int_k;

	integer					enable;
	integer					id;
	integer					ktemp;


	// Initial Condition
	initial begin	
		ktemp = 0;
		enable = 0;
		Out_buf = {data_bits{1'bz}};
		#0.01 int_k = K; 
		      zz_tm = ZZ; 
		      zz_tm1 = ZZ; 
	end	// initial end


	// for sleep mode & differential clock
	always  @ (posedge ZZ) begin
		zz_tm <= #`tZZE 1'b1;
		Out_buf <= #`tZZE {data_bits{1'bz}};
		if (command_pi[0] == 2'b01) begin
			$display("$m[%t] : warning !! : forbidden WRITE before ZZ ",$realtime); 
		end
		command_pi[0] = 2'b00; 		// when wake, initial command is no operation 
		
	end

	always @ (negedge zz_tm) begin
		if ($realtime > 0.01) begin
			if (int_k == 1'b0) begin
				zz_tm1 = 1'b0;
			end
			else if (int_k == 1'b1) begin
				ktemp = 1;
			end
		end
	end

	always @ (posedge zz_tm) begin
		zz_tm1 = 1'b1;
	end

	always @ (negedge int_k) begin
		if (ktemp == 1) begin
			zz_tm1 = 1'b0;
			ktemp = 0;
		end
	end

	always  @ (negedge ZZ) begin
		zz_tm <= #`tZZR 1'b0;
	end

	always @ (K or K_N) begin
		if (K > K_N) begin
			int_k = 1'b1;
		end
		else if (K < K_N) begin
			int_k = 1'b0;
		end
	end 

	assign int_clk = int_k & ~zz_tm1 ;

	// output enable
	always	@ (posedge G_N) begin
			enable <= #`tGHQZ 1;
	end

	always	@ (negedge G_N) begin
			enable <= #`tGLQV 0;
	end

	// output
	assign DQ = enable ? {data_bits{1'bz}} : Out_buf;


////////////    MAIN FUNCTION   ////////////////////////////////////////////////

	always @ (posedge int_clk) begin	// always-00

	$display("$m : at time %t : ----------------------------------------------------------------------------------------",$time);	
	// command pipe
	command_pi[2] = command_pi[1];
	command_pi[1] = command_pi[0];
	command_pi[0] = 2'b11;

	// Address pipe
	Addr_pi_r[1] = Addr_pi_r[0];
	Addr_pi_r[0] = {addr_bits{1'bx}};

	Addr_pi_w[1] = Addr_pi_w[0];
	Addr_pi_w[0] = {addr_bits{1'bx}};

	// Byte write pipe
	BW_pi[1] = BW_pi[0];
	BW_pi[0] = 2'b11;

	if (ZZ == 1'b0) begin

		if (SS_N == 1'b0) begin
			if (SW_N == 1'b0) begin
				command_pi[0] = 2'b01;  	// write enable
				Addr_pi_w[0] = SA;
				BW_pi[0] = SBW_N;
			end
			else if(SW_N == 1'b1) begin
				command_pi[0] = 2'b10;		// read enable
				Addr_pi_r[0] = SA;
			end
			else begin
				$display("$m[%t] : error !! : SW_N is invalid",$realtime); 
			end
		end
		else if (SS_N == 1'b1) begin
			command_pi[0] = 2'b00;	// no operation
		end
		else begin
			$display("$m[%t] : error !! : SS_N is invalid",$realtime); 
		end
	end

	// write operation 
	if (command_pi[1] === 2'b01) begin 
		waddr = Addr_pi_w[1];  
		Data_tm = SMEM[waddr];

	 	BW = BW_pi[1];	

		if (BW[0] == 1'b0) begin      // if-14
                        Data_tm[data_bits/2 - 1 : 0] = DQ[data_bits/2 - 1 : 0];
                end

                if (BW[1] == 1'b0) begin      // if-17
                         Data_tm[data_bits - 1 : data_bits*1/2] = DQ[data_bits - 1 : data_bits*1/2];
                end   

		SMEM[waddr] = Data_tm;
		$display("$m[%t] : WRITE(%b) = %b",$realtime, waddr, SMEM[waddr]); 
	end

	// read operation 
	else if (command_pi[1] === 2'b10) begin
		raddr = Addr_pi_r[1];
		Out_buf <= #`tKHQV SMEM[raddr];
		$display("$m[%t] : READ(%b) = %b",$realtime, raddr, SMEM[waddr]); 
	end

	if (command_pi[2] === 2'b10) begin
		Out_buf <= #`tKHQX {data_bits{1'bz}};
	end
	end

		
	// Timing Check
	specify
		specparam 	tKHKH	=	`tKHKH,	
				tKHKL   = 	`tKHKL,
				tKLKH   = 	`tKLKH,
			 	tKHQV	=	`tKHQV,
			 	tKHQX	=	`tKHQX,
				tAVKH	=	`tAVKH,
				tKHAX	=	`tKHAX,
				tDVKH	=	`tDVKH,
				tKHDX	=	`tKHDX,
				tWVKH	=	`tWVKH,
				tKHWX	=	`tKHWX,
				tSVKH	=	`tSVKH,
				tKHSX	=	`tKHSX,
				tKHQZ	=	`tKHQZ,
				tKHQX1	=	`tKHQX1,
				tGHQZ	=	`tGHQZ,	
				tGLQX	=	`tGLQX,	
				tGLQV	=	`tGLQV,	
				tZZE	=	`tZZE,	
				tZZR	=	`tZZR;	

		$period		(posedge K,	tKHKH);		

		$width		(posedge K,	tKHKL);		
		$width		(negedge K,	tKLKH);		

		$setuphold	(posedge K,  	SA,		tAVKH,	tKHAX); 
		$setuphold	(posedge K,  	SW_N,		tWVKH,	tKHWX); 
		$setuphold	(posedge K,  	SW_N,		tWVKH,	tKHWX); 
		$setuphold	(posedge K,  	SS_N,		tSVKH,	tKHSX); 
/*
		if (command_pi[1] === 2'b01) begin
			$setuphold	(posedge K,  	DQ,		tDVKH,	tKHDX); 
		end
*/

	endspecify

endmodule
