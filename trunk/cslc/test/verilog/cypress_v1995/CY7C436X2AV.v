/*********************************************************************************
Developed by  Intrinsix Corp.

(C) Copyright 2001, Cypress, Inc.  All rights reserved.

Created 02/21/2001

Author  : Ravisankar Pillai
Project : Cypress Memory Models
FileName: CY7C436X2AV.v
Summary : Verilog Behavioural Model of the Cypress Bidirectional Synchronous FIFOs
		CY7C43642AV, CY7C43662AV and CY7C43682AV.

$Log$

Description: 
	This module is the Verilog behavioural model of the Cypress Bidirectional
	Synchronous FIFOs (CY7C43642AV, CY7C43662AV and CY7C43682AV).
	
	The reference data sheet used for this design is
	CYPRESS 3.3V 1K/4K/16K x36 x2 Bidirectional Synchronous FIFO, 
	dated August 14, 2000.
	The "Almost Empty / Full" flag behaviour was modified according to the
	datasheet dated March 19, 2001.
        
        Both the functionality and the timing performance of the device is captured
        in this model. Also the timing checks are performed on the input signals.
        
        The FIFO depth is parameterised. So the required FIFO can be selected by
        setting this parameter appropriately. The default value of the 
        FIFO depth is 1K.
**********************************************************************************/

`timescale	1 ns/1 ps

module	CY7C436X2AV	(
			A,   		// Port A data 
			B,  		// Port B data 
			
			AEA_N,     	// Port A Almost Empty Flag
			AEB_N,     	// Port B Almost Empty Flag
			AFA_N,     	// Port A Almost Full Flag
			AFB_N,     	// Port B Almost Full Flag
			
			EFA_N_ORA, 	// Port A Empty/Output Ready Flag
			EFB_N_ORB, 	// Port B Empty/Output Ready Flag
			FFA_N_IRA, 	// Port A Full/Input Ready Flag
			FFB_N_IRB, 	// Port B Full/Input Ready Flag
			
			CLKA,		// Port A clock
			CLKB,		// Port B clock 
			
			CSA_N,     	// Port A Chip Select
			CSB_N,     	// Port B Chip Select
			
			ENA,       	// Port A ENAble
			ENB,       	// Port B ENAble
			
			MBA,       	// Port A Mailbox Select
			MBB,       	// Port B Mailbox Select
			MBF1_N,    	// Mail1 Register Flag
			MBF2_N,    	// Mail2 Register Flag
			
			MRST1_N,    	// FIFO1 Master Reset
			MRST2_N,    	// FIFO2 Master Reset
			
			RT1_N,     	// Retransmit FIFO1
			RT2_N,     	// Retransmit FIFO2
			
			W_RA_N,    	// Port A Write/Read Select
			W_N_RB,     	// Port B Write/Read Select			
			
			FWFT_N_STAN,	//First Word Fall-Through / StandardMode Select
			FS1, 		// Flag Offset Select 1
			FS0 		// Flag Offset Select 0
			
			);
//------------------------------------------------
// Parameter Declarations
//------------------------------------------------

parameter	FIFO_DEPTH 	= 1024 ;	//  Depth of the FIFO
parameter	OP_RATE		= 133 ;		// Freq. of operation of the FIFO

parameter	DATA_WIDTH	= 36 ;		//  Data width of the FIFO
parameter	ADDR_WIDTH	= (FIFO_DEPTH == 16384) ? 14 : ((FIFO_DEPTH == 4096) ? 12 : 10);

parameter	SIG_DELAY 	= 1;

//------------------------------------------------
// Input / Output ports
//------------------------------------------------

inout [(DATA_WIDTH-1):0]		A ;
inout [(DATA_WIDTH-1):0]		B ;
			
output			AEA_N ;
output			AEB_N ;
output			AFA_N ;
output			AFB_N ;
			
output			EFA_N_ORA ;
output			EFB_N_ORB ;
output			FFA_N_IRA ;
output			FFB_N_IRB ;
			
input			CLKA ;
input			CLKB ;
			
input			CSA_N ;
input			CSB_N ;
			
input			ENA ;
input			ENB ;
			
input			MBA ;
input			MBB ;
output			MBF1_N ;
output			MBF2_N ;
			
input			MRST1_N ;
input			MRST2_N ;
			
input			RT1_N ;
input			RT2_N ;
			
input			W_RA_N ;
input			W_N_RB ;			
			
input			FWFT_N_STAN ;
input			FS1 ;
input			FS0 ;

//------------------------------------------------
// Register and Wire declarations
//------------------------------------------------
wire [(DATA_WIDTH-1):0]	 	 A_i;
wire [(DATA_WIDTH-1):0]	 	 B_i;

wire			A_en ;
wire			B_en ;

reg			AEA_N_i ;
reg			AEB_N_i ;
reg			AFA_N_i ;
reg			AFB_N_i ;
			
reg			EFA_N_ORA_i ;
reg			EFB_N_ORB_i ;
reg			FFA_N_IRA_i ;
reg			FFB_N_IRB_i ;

reg			MBF1_N_i ;
reg			MBF2_N_i ;
	
reg [(DATA_WIDTH-1):0]	FIFO1 [0:(FIFO_DEPTH-1)] ;
reg [(DATA_WIDTH-1):0]	FIFO2 [0:(FIFO_DEPTH-1)] ;

reg [(DATA_WIDTH-1):0]	Mail_Reg1 ;
reg [(DATA_WIDTH-1):0]	Mail_Reg2 ;

reg [2:0]		FIFO1_clk_count [0:(FIFO_DEPTH-1)] ;
reg [2:0]		FIFO2_clk_count [0:(FIFO_DEPTH-1)] ;

/*******************************************************************
Note: portA_wr_ptr and portB_rd_ptr are associated with FIFO1.
and  portB_wr_ptr and portA_rd_ptr are associated with FIFO2.

********************************************************************/	
reg [(ADDR_WIDTH-1):0]		portA_wr_ptr ;
reg [(ADDR_WIDTH-1):0]		portA_rd_ptr ;
reg [(ADDR_WIDTH-1):0]		portB_wr_ptr ;
reg [(ADDR_WIDTH-1):0]		portB_rd_ptr ;

reg [(ADDR_WIDTH-1):0]		temp_portA_wr_ptr ;
reg [(ADDR_WIDTH-1):0]		temp_portB_wr_ptr ;

reg [(DATA_WIDTH-1):0]	AFA_offset ;	// almost_full_flag offset reg. for PortA  (Y1 reg)
reg [(DATA_WIDTH-1):0]	AFB_offset ;	// almost_full_flag offset reg. for PortB  (Y2 reg)
reg [(DATA_WIDTH-1):0]	AEA_offset ;	// almost_empty_flag offset reg. for PortA  (X2 reg)
reg [(DATA_WIDTH-1):0]	AEB_offset ;	// almost_empty_flag offset reg. for PortB  (X1 reg)

reg [(DATA_WIDTH-1):0]	portA_output_reg ;
reg [(DATA_WIDTH-1):0]	portB_output_reg ;
reg [(DATA_WIDTH-1):0]	portA_output_reg1 ;
reg [(DATA_WIDTH-1):0]	portB_output_reg1 ;

reg			FWFT_N_STAN_reg1 ;
reg			FWFT_N_STAN_reg2 ;

reg			offset_over_portA_flag ;
reg [3:0]		wr_count;

wire			portA_wr_enable ;
wire			portB_wr_enable ;

wire			portA_rd_enable ;
wire			portB_rd_enable ;

wire			portA_mb_rd_en ;
wire			portB_mb_rd_en ;
wire			portA_mb_wr_en ;
wire			portB_mb_wr_en ;

wire			op133 = (OP_RATE == 133);
wire			op100 = (OP_RATE == 100);
wire			op67  = (OP_RATE == 67);

wire		popA , popB ;
wire		pushA, pushB;

reg		assert_ira ;
reg		assert_irb ;
reg [2:0]	FFA_del_count ;
reg [2:0]	FFB_del_count ;

reg [ADDR_WIDTH :0]	fifo1_word_count ;
reg [ADDR_WIDTH :0]	fifo2_word_count ;
wire [ADDR_WIDTH :0]	fifo1_word_count_del ;
wire [ADDR_WIDTH :0]	fifo2_word_count_del ;

reg		fifo1_half_full;
reg		fifo2_half_full;

integer			i,j,k;

event			RT1_N_deassertion ;
event			RT2_N_deassertion ;
event			reset_validation1 ;
event			reset_validation2 ;

event			retransmit_validation1 ;
event			retransmit_validation2 ;

reg			mode_latch_enA ;
reg			mode_latch_enB ;

wire [2:0]	temp_clk_count0 ;
wire [2:0]	temp_clk_count1 ;
wire [2:0]	temp_clk_count2 ;
wire [2:0]	temp_clk_count3 ;

//----------------------------------------------
// Enable signal for timing check qualification
//----------------------------------------------

wire op133_pA_wr	= op133 & MRST1_N & MRST2_N & (portA_wr_enable | portA_mb_wr_en) ;
wire op100_pA_wr	= op100 & MRST1_N & MRST2_N & (portA_wr_enable | portA_mb_wr_en) ;
wire op67_pA_wr	 	= op67  & MRST1_N & MRST2_N & (portA_wr_enable | portA_mb_wr_en) ;

wire op133_pB_wr	= op133 & MRST1_N & MRST2_N & (portB_wr_enable | portB_mb_wr_en) ;
wire op100_pB_wr	= op100 & MRST1_N & MRST2_N & (portB_wr_enable | portB_mb_wr_en) ;
wire op67_pB_wr	 	= op67  & MRST1_N & MRST2_N & (portB_wr_enable | portB_mb_wr_en) ;

wire op133_ena		= op133 & MRST1_N & MRST2_N & ENA ;
wire op100_ena		= op100 & MRST1_N & MRST2_N & ENA ;
wire op67_ena		= op67  & MRST1_N & MRST2_N& ENA ;

wire op133_csa_n	= op133 & MRST1_N & MRST2_N & !CSA_N ;
wire op100_csa_n	= op100 & MRST1_N & MRST2_N & !CSA_N ;
wire op67_csa_n		= op67  & MRST1_N & MRST2_N & !CSA_N ;

wire op133_ena_csa_n	= op133 & MRST1_N  & MRST2_N & ENA & !CSA_N ;
wire op100_ena_csa_n	= op100 & MRST1_N  & MRST2_N & ENA & !CSA_N ;
wire op67_ena_csa_n	= op67  & MRST1_N  & MRST2_N & ENA & !CSA_N ;

wire op133_enb		= op133 & MRST1_N & MRST2_N & ENB ;
wire op100_enb		= op100 & MRST1_N & MRST2_N & ENB ;
wire op67_enb		= op67  & MRST1_N & MRST2_N & ENB ;

wire op133_csb_n	= op133 & MRST1_N & MRST2_N & !CSB_N ;
wire op100_csb_n	= op100 & MRST1_N & MRST2_N & !CSB_N ;
wire op67_csb_n		= op67  & MRST1_N & MRST2_N & !CSB_N ;

wire op133_enb_csb_n	= op133 & MRST1_N & MRST2_N & ENB & !CSB_N ;
wire op100_enb_csb_n	= op100 & MRST1_N & MRST2_N & ENB & !CSB_N ;
wire op67_enb_csb_n	= op67  & MRST1_N & MRST2_N & ENB & !CSB_N ;

wire 	op133_mode_latchA = mode_latch_enA & op133 ;
wire 	op100_mode_latchA = mode_latch_enA & op100 ;
wire 	op67_mode_latchA  = mode_latch_enA & op67 ;

wire 	op133_mode_latchB = mode_latch_enB & op133 ;
wire 	op100_mode_latchB = mode_latch_enB & op100 ;
wire 	op67_mode_latchB  = mode_latch_enB & op67 ;

//---------------------------------------------------------
// The specify block is seperated out in different file

`include "CY7C436X2AV_timing.v"

//---------------------------------------------------------
// Retransmit related

wire	EFB_N_ORB_i_rt ;
wire 	FFA_N_IRA_i_rt ;
wire 	AEB_N_i_rt , AFA_N_i_rt ;
wire	EFA_N_ORA_i_rt , FFB_N_IRB_i_rt ;
wire	AEA_N_i_rt , AFB_N_i_rt ;

reg	rt1_rtr ;
reg	rt1_rtr_2clkA ;
reg	rt1_rtr_2clkB ;
reg	rt2_rtr ;
reg 	rt2_rtr_2clkA ;
reg 	rt2_rtr_2clkB ;

//---------------------------------------------------
// Flag control during the Retransmit recovery period.
//----------------------------------------------------
assign 	EFB_N_ORB_i_rt 	= (rt1_rtr | (!MRST1_N)) ? EFB_N_ORB_i : 1'bx ;
assign	FFA_N_IRA_i_rt 	= (rt1_rtr | (!MRST1_N)) ? FFA_N_IRA_i : 1'bx ;

assign 	AEB_N_i_rt	= (rt1_rtr_2clkB | (!MRST1_N)) ? AEB_N_i : 1'bx ;
assign	AFA_N_i_rt	= (rt1_rtr_2clkA | (!MRST1_N)) ? AFA_N_i : 1'bx ;

assign	EFA_N_ORA_i_rt	= (rt2_rtr | (!MRST2_N)) ? EFA_N_ORA_i : 1'bx ;
assign	FFB_N_IRB_i_rt	= (rt2_rtr | (!MRST2_N)) ? FFB_N_IRB_i : 1'bx ;

assign	AEA_N_i_rt	= (rt2_rtr_2clkA | (!MRST2_N)) ? AEA_N_i : 1'bx ;
assign 	AFB_N_i_rt	= (rt2_rtr_2clkB | (!MRST2_N)) ? AFB_N_i : 1'bx ;

//---------------------------------------------------------
// Buffers for qualifying the outputs as accelerated nets 
// (Verilog-XL requirement for timing checks on outputs.)
//---------------------------------------------------------
buf b1 (EFB_N_ORB,EFB_N_ORB_i_rt) ;
buf b2 (FFA_N_IRA,FFA_N_IRA_i_rt) ;
buf b3 (AEB_N, AEB_N_i_rt) ;
buf b4 (AFA_N, AFA_N_i_rt) ;
buf b5 (MBF1_N, MBF1_N_i) ;

buf b6 (EFA_N_ORA,EFA_N_ORA_i_rt) ;
buf b7 (FFB_N_IRB,FFB_N_IRB_i_rt) ;
buf b8 (AEA_N, AEA_N_i_rt) ;
buf b9 (AFB_N, AFB_N_i_rt) ;
buf b10 (MBF2_N, MBF2_N_i) ;

//bufif1 b11 [(DATA_WIDTH-1):0] (A, A_i, A_en) ;
//bufif1 b12 [(DATA_WIDTH-1):0] (B, B_i, B_en) ;

bufif1	bufa_0 (A[0],A_i[0],A_en);
bufif1	bufa_1 (A[1],A_i[1],A_en);
bufif1	bufa_2 (A[2],A_i[2],A_en);
bufif1	bufa_3 (A[3],A_i[3],A_en);
bufif1	bufa_4 (A[4],A_i[4],A_en);
bufif1	bufa_5 (A[5],A_i[5],A_en);
bufif1	bufa_6 (A[6],A_i[6],A_en);
bufif1	bufa_7 (A[7],A_i[7],A_en);
bufif1	bufa_8 (A[8],A_i[8],A_en);
bufif1	bufa_9 (A[9],A_i[9],A_en);
bufif1	bufa_10 (A[10],A_i[10],A_en);
bufif1	bufa_11 (A[11],A_i[11],A_en);
bufif1	bufa_12 (A[12],A_i[12],A_en);
bufif1	bufa_13 (A[13],A_i[13],A_en);
bufif1	bufa_14 (A[14],A_i[14],A_en);
bufif1	bufa_15 (A[15],A_i[15],A_en);
bufif1	bufa_16 (A[16],A_i[16],A_en);
bufif1	bufa_17 (A[17],A_i[17],A_en);
bufif1	bufa_18 (A[18],A_i[18],A_en);
bufif1	bufa_19 (A[19],A_i[19],A_en);
bufif1	bufa_20 (A[20],A_i[20],A_en);
bufif1	bufa_21 (A[21],A_i[21],A_en);
bufif1	bufa_22 (A[22],A_i[22],A_en);
bufif1	bufa_23 (A[23],A_i[23],A_en);
bufif1	bufa_24 (A[24],A_i[24],A_en);
bufif1	bufa_25 (A[25],A_i[25],A_en);
bufif1	bufa_26 (A[26],A_i[26],A_en);
bufif1	bufa_27 (A[27],A_i[27],A_en);
bufif1	bufa_28 (A[28],A_i[28],A_en);
bufif1	bufa_29 (A[29],A_i[29],A_en);
bufif1	bufa_30 (A[30],A_i[30],A_en);
bufif1	bufa_31 (A[31],A_i[31],A_en);
bufif1	bufa_32 (A[32],A_i[32],A_en);
bufif1	bufa_33 (A[33],A_i[33],A_en);
bufif1	bufa_34 (A[34],A_i[34],A_en);
bufif1	bufa_35 (A[35],A_i[35],A_en);

bufif1	bufb_0 (B[0],B_i[0],B_en);
bufif1	bufb_1 (B[1],B_i[1],B_en);
bufif1	bufb_2 (B[2],B_i[2],B_en);
bufif1	bufb_3 (B[3],B_i[3],B_en);
bufif1	bufb_4 (B[4],B_i[4],B_en);
bufif1	bufb_5 (B[5],B_i[5],B_en);
bufif1	bufb_6 (B[6],B_i[6],B_en);
bufif1	bufb_7 (B[7],B_i[7],B_en);
bufif1	bufb_8 (B[8],B_i[8],B_en);
bufif1	bufb_9 (B[9],B_i[9],B_en);
bufif1	bufb_10 (B[10],B_i[10],B_en);
bufif1	bufb_11 (B[11],B_i[11],B_en);
bufif1	bufb_12 (B[12],B_i[12],B_en);
bufif1	bufb_13 (B[13],B_i[13],B_en);
bufif1	bufb_14 (B[14],B_i[14],B_en);
bufif1	bufb_15 (B[15],B_i[15],B_en);
bufif1	bufb_16 (B[16],B_i[16],B_en);
bufif1	bufb_17 (B[17],B_i[17],B_en);
bufif1	bufb_18 (B[18],B_i[18],B_en);
bufif1	bufb_19 (B[19],B_i[19],B_en);
bufif1	bufb_20 (B[20],B_i[20],B_en);
bufif1	bufb_21 (B[21],B_i[21],B_en);
bufif1	bufb_22 (B[22],B_i[22],B_en);
bufif1	bufb_23 (B[23],B_i[23],B_en);
bufif1	bufb_24 (B[24],B_i[24],B_en);
bufif1	bufb_25 (B[25],B_i[25],B_en);
bufif1	bufb_26 (B[26],B_i[26],B_en);
bufif1	bufb_27 (B[27],B_i[27],B_en);
bufif1	bufb_28 (B[28],B_i[28],B_en);
bufif1	bufb_29 (B[29],B_i[29],B_en);
bufif1	bufb_30 (B[30],B_i[30],B_en);
bufif1	bufb_31 (B[31],B_i[31],B_en);
bufif1	bufb_32 (B[32],B_i[32],B_en);
bufif1	bufb_33 (B[33],B_i[33],B_en);
bufif1	bufb_34 (B[34],B_i[34],B_en);
bufif1	bufb_35 (B[35],B_i[35],B_en);


//------------------------------------------------
// Enable signal generation
//------------------------------------------------

assign portA_rd_enable		= (~CSA_N)  & ENA &  (~W_RA_N) & EFA_N_ORA ;
assign portB_rd_enable		= (~CSB_N)  & ENB &  (W_N_RB)  & EFB_N_ORB  ;

assign portA_wr_enable		= (~CSA_N)  & ENA &  (W_RA_N)  & FFA_N_IRA ;
assign portB_wr_enable		= (~CSB_N)  & ENB &  (~W_N_RB) & FFB_N_IRB ;

assign popA			= (~CSA_N)  & ENA &  (~W_RA_N) & !MBA ;
assign popB			= (~CSB_N)  & ENB &  (W_N_RB) & !MBB ;

assign pushA			= (~CSA_N)  & ENA &  (W_RA_N)  & !MBA ;
assign pushB			= (~CSB_N)  & ENB &  (~W_N_RB) & !MBB ;

assign portA_mb_rd_en		= (~CSA_N)  & ENA &  (~W_RA_N)  & MBA ;
assign portB_mb_rd_en		= (~CSB_N)  & ENB &  (W_N_RB) & MBB ;

assign portA_mb_wr_en		= (~CSA_N)  & ENA &  (W_RA_N)  & MBA & MBF1_N ;
assign portB_mb_wr_en		= (~CSB_N)  & ENB &  (~W_N_RB) & MBB & MBF2_N ;

//--------------------------
// Generic Timing Parameters
//--------------------------

time	tRSTS ;
time	tRSTH ;
time 	tRTR ;

time	tSKEW1 ;
time	tSKEW2 ;

initial	begin
#1
	if (op133) 	tRSTS = tRSTS_133;
	else if (op100) tRSTS = tRSTS_100;
	else  		tRSTS = tRSTS_67;
	
	if (op133) 	tRSTH = tRSTH_133;
	else if (op100) tRSTH = tRSTH_100;
	else  		tRSTH = tRSTH_67;
		
	if (op133) 	tRTR = tRTR_133;
	else if (op100) tRTR = tRTR_100;
	else  		tRTR = tRTR_67;
	
	if (op133) 	tSKEW1 = tSKEW1_133;
	else if (op100) tSKEW1 = tSKEW1_100;
	else  		tSKEW1 = tSKEW1_67;
	
	if (op133) 	tSKEW2 = tSKEW2_133;
	else if (op100) tSKEW2 = tSKEW2_100;
	else  		tSKEW2 = tSKEW2_67;
	
end

//-------------------------------------------------
// Reset Assertion - Width check
//-------------------------------------------------

always	fork
	begin	: reset_check1
		@(negedge MRST1_N);
		-> reset_validation1 ;
		#tRSTS ;
		fork
			repeat (4)	@(posedge CLKA);
			repeat (4)	@(posedge CLKB);
		join
		#tRSTH ;
		disable reset_check11;
		
	
	end
	
	begin	: reset_check11
		@(reset_validation1);
		@(posedge MRST1_N) 	$display ($time,":Error: Reset signal MRST1_N changed during the 4 clock window.");
		disable reset_check1;
	end
join
//------------------------
always	fork
	begin	: reset_check2
		@(negedge MRST2_N);
		-> reset_validation2 ;
		#tRSTS ;
		fork
			repeat (4)	@(posedge CLKA);
			repeat (4)	@(posedge CLKB);
		join
		#tRSTH ;
		disable reset_check22;
		
	end
	
	begin	: reset_check22
		@(reset_validation2);
		@(posedge MRST2_N) 	$display ($time,":Error: Reset signal MRST2_N changed during the 4 clock window.");
		disable reset_check2;
	end
join

//-------------------------------------------------
// Retransmit Assertion - Width check
//-------------------------------------------------

always	fork
	begin	: retransmit_check1
		@(negedge RT1_N);
		-> retransmit_validation1 ;
		#tRSTS ;
		fork
			repeat (4)	@(posedge CLKA);
			repeat (4)	@(posedge CLKB);
		join
		#tRSTH ;
		disable retransmit_check11;
		
	
	end
	
	begin	: retransmit_check11
		@(retransmit_validation1);
		@(posedge RT1_N) 	$display ($time,":Error: Retransmit signal RT1_N changed during the 4 clock window.");
		disable retransmit_check1;
	end
join
//------------------------
always	fork
	begin	: retransmit_check2
		@(negedge RT2_N);
		-> retransmit_validation2 ;
		#tRSTS ;
		fork
			repeat (4)	@(posedge CLKA);
			repeat (4)	@(posedge CLKB);
		join
		#tRSTH ;
		disable retransmit_check22;
		
	end
	
	begin	: retransmit_check22
		@(retransmit_validation2);
		@(posedge RT2_N) 	$display ($time,":Error: Retransmit signal RT2_N changed during the 4 clock window.");
		disable retransmit_check2;
	end
join

//------------------------------------------------
//------------------------------------------------
// PortA  Read/Write pointer operation
//------------------------------------------------

always @(posedge CLKA or negedge MRST1_N)	begin

	if (!MRST1_N)
		portA_wr_ptr	<= {ADDR_WIDTH{1'b0}};
	else if (portA_wr_enable & !MBA & !offset_over_portA_flag)	begin
		if (portA_wr_ptr == (FIFO_DEPTH-1'b1) )
			portA_wr_ptr	<= {ADDR_WIDTH{1'b0}};
		else
			portA_wr_ptr	<= portA_wr_ptr + 1'b1 ;
	end
end
//------------

always @(posedge CLKA or negedge MRST2_N or negedge RT2_N)	begin

	if (!MRST2_N)
		portA_rd_ptr	<= {ADDR_WIDTH{1'b0}};
		
	else if (!RT2_N & !ENB & FWFT_N_STAN_reg2)
		portA_rd_ptr	<= {ADDR_WIDTH{1'b0}};
		
	else if (portA_rd_enable & !MBA & FWFT_N_STAN_reg2)	begin
		if (portA_rd_ptr == (FIFO_DEPTH-1'b1) )
			portA_rd_ptr	<= {ADDR_WIDTH{1'b0}};
		else
			portA_rd_ptr	<= portA_rd_ptr + 1'b1 ;
	end
	
	else if (portA_rd_enable & !MBA & !FWFT_N_STAN_reg2 & (fifo2_word_count !== 'h0) & (FIFO2_clk_count[portA_rd_ptr] >= 3) )	begin	// 09-17 TBD
	//else if (portA_rd_enable & !MBA & !FWFT_N_STAN_reg2 & (fifo2_word_count !== 'h0)  )	begin	// TBD
		if (portA_rd_ptr == (FIFO_DEPTH-1'b1) )
			portA_rd_ptr	<= {ADDR_WIDTH{1'b0}};
		else
			portA_rd_ptr	<= portA_rd_ptr + 1'b1 ;
	end
	
end

//---------------------------------
// Retransmit-2 related checks
//---------------------------------

always 	fork
  begin
	@ (negedge RT2_N);
	if (FWFT_N_STAN_reg2)	begin
		if (ENB)	begin
			$display($time,":Warning :Retransmit RT2_N was asserted when ENB = 1");
			$display($time,":Warning :So Retransmit on FIFO2 was NOT honoured.");
			disable validation_block2;
			disable validation_block1;
		end
		else	begin	: validation_block
			@ (posedge RT2_N) 	begin
				disable validation_block2; 
				-> RT2_N_deassertion ;
			end
		
			#tRTR	disable validation_block1;
		end
	end
	else	begin
		$display($time,":Warning :Retransmit RT2_N attempted in the FWFT mode.");
		$display($time,":Warning :So Retransmit on FIFO2 was NOT honoured.");
		disable validation_block2;
		disable validation_block1;
	end
  end
  
  begin : validation_block2
		@ (negedge RT2_N);
		@ (ENB)
			$display($time,":Warning :Transition on the ENB signal while the RT2_N is asserted");
  
  end
  
  begin	:  validation_block1
	@(RT2_N_deassertion);
	@(ENB)	$display($time,":Warning :Transition on the ENB signal during the retransmit recovery period.");
  end
join


//------------------------------------------------
// PortB  Read/Write pointer operation
//------------------------------------------------
always @(posedge CLKB or negedge MRST2_N)	begin

	if (!MRST2_N)
		portB_wr_ptr	<= {ADDR_WIDTH{1'b0}};
	else if (portB_wr_enable & !MBB)	begin
		if (portB_wr_ptr == (FIFO_DEPTH-1'b1) )
			portB_wr_ptr	<= {ADDR_WIDTH{1'b0}};
		else
			portB_wr_ptr	<= portB_wr_ptr + 1'b1 ;
	end
end
//------------
always @(posedge CLKB or negedge MRST1_N or negedge RT1_N)	begin

	if (!MRST1_N)
		portB_rd_ptr	<= {ADDR_WIDTH{1'b0}};
		
	else if (!RT1_N & !ENB & FWFT_N_STAN_reg1)
		portB_rd_ptr	<= {ADDR_WIDTH{1'b0}};
				
	else if (portB_rd_enable & !MBB & FWFT_N_STAN_reg1)	begin
		if (portB_rd_ptr == (FIFO_DEPTH-1'b1) )
			portB_rd_ptr	<= {ADDR_WIDTH{1'b0}};
		else
			portB_rd_ptr	<= portB_rd_ptr + 1'b1 ;
	end
	
	else if (portB_rd_enable & !MBB & !FWFT_N_STAN_reg1 & (fifo1_word_count !== 'h0) & (FIFO1_clk_count[portB_rd_ptr] >= 3) )	begin	// 09-17-01TBD
	//else if (portB_rd_enable & !MBB & !FWFT_N_STAN_reg1 & (fifo1_word_count !== 'h0)  )	begin	// TBD
		if (portB_rd_ptr == (FIFO_DEPTH-1'b1) )
			portB_rd_ptr	<= {ADDR_WIDTH{1'b0}};
		else
			portB_rd_ptr	<= portB_rd_ptr + 1'b1 ;
	end
	
end
//--------------------------------------------------------
// Retransmit-1 related checks.
//--------------------------------------------------------

always 	fork
  begin
	@ (negedge RT1_N);	
	if (FWFT_N_STAN_reg1)	begin
		if (ENB)	begin
			$display($time,":Warning :Retransmit RT1_N was asserted when ENB = 1");
			$display($time,":Warning :So Retransmit on FIFO1 was NOT honoured.");
			disable validation_block5;
			disable validation_block4;
		end
		else	begin	: validation_block3
			@ (posedge RT1_N) 	begin
				disable validation_block5; 
				-> RT1_N_deassertion ;
			end
		
			#tRTR	disable validation_block4;
		end
	end
	else	begin
		$display($time,":Warning :Retransmit RT1_N attempted in the FWFT mode.");
		$display($time,":Warning :So Retransmit on FIFO1 was NOT honoured.");
		disable validation_block5;
		disable validation_block4;
	end	
  end
  
  begin : validation_block5
		@ (negedge RT1_N);
		@ (ENB)
			$display($time,":Warning :Transition on the ENB signal while the RT1_N is asserted");
  
  end
  
  begin	:  validation_block4
	@(RT1_N_deassertion);
	@(ENB)	$display($time,":Warning :Transition on the ENB signal during the retransmit recovery period.");
  end
join
//------------------------------------------------
// PortA  Read operation (FIFO and Mail_Reg2)
//------------------------------------------------

always @(posedge CLKA or negedge MRST2_N)	begin

	if (!MRST2_N)
		portA_output_reg	<= {DATA_WIDTH{1'b0}};
	
	//else if (!MBA & portA_rd_enable)	begin		// TBD
	else if (!MBA & portA_rd_enable & FWFT_N_STAN_reg2)	begin
		portA_output_reg	<= FIFO2[portA_rd_ptr] ;
		FIFO2_clk_count[portA_rd_ptr] <= 3'b000 ;
	end
		
	//else if (MBA & portA_rd_enable & !MBF2_N)		// Resetting the MBF2_N flag, when the Mail_Reg2 is read.
	else if (MBA & portA_mb_rd_en & !MBF2_N)		// Resetting the MBF2_N flag, when the Mail_Reg2 is read. 09-06
		MBF2_N_i 	<= 1'b1 ;

end
			
assign A_i =  (MBA) ? Mail_Reg2 : ((FWFT_N_STAN_reg2) ?  portA_output_reg : portA_output_reg1 ) ;

assign A_en = (~CSA_N & ~W_RA_N) ;

//------------------------------------------------
// PortA  Write operation (FIFO and Mail_Reg1)
//------------------------------------------------

always @(posedge CLKA or negedge MRST1_N)	begin

	if (!MRST1_N)	begin
		for (i=0; i < FIFO_DEPTH; i = i+1)	begin
			FIFO1[i] <=  {DATA_WIDTH{1'bx}}; 
			FIFO1_clk_count[i]	<=  3'b000;
		end
			
		//Mail_Reg1 <=  {DATA_WIDTH{1'bx}} ;	// 09-27
		Mail_Reg1 <=  {DATA_WIDTH{1'b0}} ;
		MBF1_N_i 	<= 1'b1 ;	
	end
	
	else if (!MBA & portA_wr_enable & !offset_over_portA_flag)	begin
		FIFO1[portA_wr_ptr]	<= A ;
		temp_portA_wr_ptr 	<= portA_wr_ptr ;
		#tSKEW1
		FIFO1_clk_count[temp_portA_wr_ptr]	<=  3'b001;
	end
		
	else if (MBA & MBF1_N & portA_wr_enable & !offset_over_portA_flag)	begin	
		Mail_Reg1 <= A ;
		MBF1_N_i 	<= 1'b0 ;
	end
end

always @(posedge CLKB or negedge RT1_N)	begin
	//if ((!RT1_N & !ENB & FWFT_N_STAN_reg1) & (EFB_N_ORB) )	begin
	if ((!RT1_N & !ENB & FWFT_N_STAN_reg1) )	begin
		if (portA_wr_ptr == portB_rd_ptr)	begin
			//for (i=0; i < FIFO_DEPTH; i = i+1)
			for (i=0; i < fifo1_word_count_del ; i = i+1)	// 10-04
			  FIFO1_clk_count[i]	<=  3'b100;
		end
		else	begin
			for (i=0; i < portA_wr_ptr; i = i+1)
			  FIFO1_clk_count[i]	<=  3'b100;
		end
	end
	else	begin
		for (j=0; j <FIFO_DEPTH; j=j+1 )	begin
			if ( (FIFO1_clk_count[j] != 3'b000) && (FIFO1_clk_count[j] != 3'b100) )	
				FIFO1_clk_count[j] <= FIFO1_clk_count[j] + 1'b1;
		end
	end
end
//------------------------------------------------
// PortB  Read operation  (FIFO and Mail_Reg1)
//------------------------------------------------

always @(posedge CLKB or negedge MRST1_N)	begin

	if (!MRST1_N)
		portB_output_reg	<= {DATA_WIDTH{1'b0}};
	
	//else if (!MBB & portB_rd_enable)	begin		// TBD
	else if (!MBB & portB_rd_enable & FWFT_N_STAN_reg1)	begin
		portB_output_reg	<= FIFO1[portB_rd_ptr] ;
		FIFO1_clk_count[portB_rd_ptr] <= 3'b000 ;
	end
		
	//else if (MBB & portB_rd_enable & !MBF1_N)		// Resetting the MBF1_N flag, when the Mail_Reg1 is read.
	else if (MBB & portB_mb_rd_en & !MBF1_N)		// Resetting the MBF1_N flag, when the Mail_Reg1 is read. 09-06
		MBF1_N_i 	<= 1'b1 ;

end

assign B_i =	(MBB) ? Mail_Reg1 : ((FWFT_N_STAN_reg1) ?  portB_output_reg : portB_output_reg1 ) ;

assign B_en = 	(~CSB_N & W_N_RB) ;

//------------------------------------------------
// PortB  Write operation (FIFO and Mail_Reg2)
//------------------------------------------------

always @(posedge CLKB or negedge MRST2_N)	begin

	if (!MRST2_N)	begin
		for (i=0; i < FIFO_DEPTH; i = i+1)	begin
			FIFO2[i] <=  {DATA_WIDTH{1'bx}};
			FIFO2_clk_count[i]	<=  3'b000 ;
		end
			 			
		//Mail_Reg2 <=  {DATA_WIDTH{1'bx}} ;	// 09-27
		Mail_Reg2 <= {DATA_WIDTH{1'b0}} ;
		MBF2_N_i 	<= 1'b1 ;	
	end
	
	else if (!MBB & portB_wr_enable)	begin
		FIFO2[portB_wr_ptr]	<= B ;
		temp_portB_wr_ptr 	<= portB_wr_ptr ;
		#tSKEW1
		FIFO2_clk_count[temp_portB_wr_ptr]	<=  3'b001 ;	
	end
	
	else if (MBB & MBF2_N & portB_wr_enable)	begin	
		Mail_Reg2 	<= B ;
		MBF2_N_i 	<= 1'b0 ;
	end		
end


always @(posedge CLKA or negedge RT2_N)	begin
	//if ((!RT2_N & !ENB & FWFT_N_STAN_reg2) & (EFA_N_ORA) )	begin
	if ((!RT2_N & !ENB & FWFT_N_STAN_reg2)  )	begin
		if (portA_wr_ptr == portB_rd_ptr)	begin
			//for (i=0; i < FIFO_DEPTH; i = i+1)
			for (i=0; i < fifo2_word_count_del ; i = i+1)	// 10-04
			  FIFO2_clk_count[i]	<=  3'b100;
		end
		else	begin
			for (i=0; i < portB_wr_ptr; i = i+1)
			  FIFO2_clk_count[i]	<=  3'b100;
		end
	end
	else	begin
		for (j=0; j <FIFO_DEPTH; j=j+1 )	begin
			if ( (FIFO2_clk_count[j] != 3'b000) && (FIFO2_clk_count[j] != 3'b100) )	
				FIFO2_clk_count[j] <= FIFO2_clk_count[j] + 1'b1;
		end
	end
end
//-----------------------------------------------------------------------------
// Loading the offset register for the almost_full/empty flags
//-------------------------------------------------------------
always 	begin
	wait (!MRST1_N);
	offset_over_portA_flag = 0;
	wr_count = 0;
	
	@(posedge MRST1_N)	begin
		case ({FS1,FS0})
			2'b00:	begin
				offset_over_portA_flag = 1;
				$display($time,":Msg: The Flag Offsets (X1,Y1,X2,Y2) will be programmed over the PortA.");
				end
			2'b01:	begin 
				AFA_offset = 8; AEB_offset = 8;
				$display($time,":Msg: The Flag Offsets X1 = 8, Y1 = 8, for FIFO1.");
				end
			2'b10:	begin 
				AFA_offset = 16; AEB_offset = 16;
				$display($time,":Msg: The Flag Offsets X1 = 16, Y1 = 16, for FIFO1.");
				end
			2'b11:	begin 
				AFA_offset = 64; AEB_offset = 64;
				$display($time,":Msg: The Flag Offsets X1 = 64, Y1 = 64, for FIFO1.");
				end
		endcase
	end	
end
//--------------------
always 	begin
	wait (!MRST2_N);
	//offset_over_portA_flag = 0;	// <-------------TBD (commented out on 4-3-2001, after getting clarification from Cypress)
	
	@(posedge MRST2_N)	begin
		case ({FS1,FS0})
			//2'b00:	offset_over_portA_flag = 1;	// <-------------TBD (commented out on 4-3-2001, after getting clarification from Cypress)
			2'b01:	begin 
				AFB_offset = 8; AEA_offset = 8;
				$display($time,":Msg: The Flag Offsets X2 = 8, Y2 = 8, for FIFO2.");
				end
			2'b10:	begin 
				AFB_offset = 16; AEA_offset = 16;
				$display($time,":Msg: The Flag Offsets X2 = 16, Y2 = 16, for FIFO2.");
				end
			2'b11:	begin 
				AFB_offset = 64; AEA_offset = 64;
				$display($time,":Msg: The Flag Offsets X2 = 64, Y2 = 64, for FIFO2.");
				end
		endcase
	end	
end
//---------------------
always 	@(posedge CLKA)	begin

	if (offset_over_portA_flag && 
		(wr_count < 4)	 && 
		portA_wr_enable )	begin
		
	  case(wr_count)
		3'b000:	begin
				AFA_offset	<= A ;
				$display($time,":Msg: The AFA_offset (Y1) is programmed with value %0d.",A);
			end
			
		3'b001:	begin
				AEB_offset	<= A ;
				$display($time,":Msg: The AEB_offset (X1) is programmed with value %0d.",A);
			end
			
		3'b010:	begin
				AFB_offset	<= A ;
				$display($time,":Msg: The AFB_offset (Y2) is programmed with value %0d.",A);
			end
			
		3'b011:	begin
				AEA_offset	<= A ;
				$display($time,":Msg: The AEA_offset (X2) is programmed with value %0d.",A);
				offset_over_portA_flag <= 1'b0;	// resetting the flag.
			end
	  endcase
	  
	  wr_count <= wr_count + 1 ;
	  
	end
end
//-----------------------------------------------------------------------------
// Latching the FWFT_N_STAN value into the FWFT_N_STAN_reg1 and FWFT_N_STAN_reg1
//------------------------------------------------------------------------------

always	begin	: fwft1_main_loop
	mode_latch_enA = 1'b0 ;
	
	wait (!MRST1_N);
	@(posedge MRST1_N);		

	@(posedge CLKA);
	mode_latch_enA = 1'b1 ;
	
	@(posedge CLKA) FWFT_N_STAN_reg1 <= FWFT_N_STAN;
	
	if (FWFT_N_STAN)	$display($time,":Msg: The FIFO1 is set in the STANDARD Mode.");
	else			$display($time,":Msg: The FIFO1 is set in the FWFT Mode.");
end

//--------------------

always	begin	: fwft2_main_loop
	
	mode_latch_enB = 1'b0 ;
	
	wait (!MRST2_N);
	@(posedge MRST2_N);
	
	@(posedge CLKB);
	mode_latch_enB = 1'b1 ;
	
	@(posedge CLKB) FWFT_N_STAN_reg2 <= FWFT_N_STAN;
	
	if (FWFT_N_STAN)	$display($time,":Msg: The FIFO2 is set in the STANDARD Mode.");
	else			$display($time,":Msg: The FIFO2 is set in the FWFT Mode.");
end

//-----------------
// Generating an error/warning msg., if the FWFT_N_STAN input changes after the 
// deassertion of the reset signal.

always	begin	: fwft1_warn_loop
	wait(!MRST1_N);
	@(posedge MRST1_N);
	@(FWFT_N_STAN) $display ($time,":Warning: The input FWFT_N_STAN changed after the MRST1_N reset deassertion.");
end
//-----------------
always	begin	: fwft2_warn_loop
	wait(!MRST2_N);
	@(posedge MRST2_N);
	@(FWFT_N_STAN) $display ($time,":Warning: The input FWFT_N_STAN changed after the MRST2_N reset deassertion.");
end
//--------------------------------------------------------------------------
// The block to disable certain validation loops, when the Reset is asserted
//---------------------------------------------------------------------------
always 	begin
	wait(!MRST1_N);
	@(posedge MRST1_N);
	@(negedge MRST1_N);
	disable assert_ira_loop ;
	disable fwft1_warn_loop ;
	disable fwft1_main_loop ;
	
	disable rt1_rtr_loop ;
	disable rt1_rtr_2clkA_loop ;
	disable rt1_rtr_2clkB_loop ;
	
end
//--------------------------------
always 	begin
	wait(!MRST2_N);
	@(posedge MRST2_N);
	@(negedge MRST2_N);
	disable assert_irb_loop ;
	disable fwft2_warn_loop ;
	disable fwft2_main_loop ;
	
	disable rt2_rtr_loop ;
	disable rt2_rtr_2clkB_loop ;
	disable rt2_rtr_2clkA_loop ;

end

//-------------------------------
// FLAGS RELATED
//-----------------
// PortA Full/InputRdy Flag
//-------------------------

always	begin	: assert_ira_loop
	assert_ira <= 1'b0;
	
	wait(!MRST1_N);
	@(posedge MRST1_N);
	
	@(posedge CLKA);
	#SIG_DELAY	assert_ira <= 1'b1;
	@(posedge CLKA);
	#SIG_DELAY	assert_ira <= 1'b0;
		
end

//-------------------
always 	@(posedge CLKB or negedge MRST1_N)	begin

	if (!MRST1_N)
		FFA_del_count	<= 3'b000;
	else if ((!FFA_N_IRA & popB & EFB_N_ORB) || 		// 09-12 added EFB_N_ORB
			(!EFB_N_ORB_i &&  (FIFO1_clk_count[portB_rd_ptr] >= 3 ) && !FWFT_N_STAN_reg1 )  )	begin
		#tSKEW1	 ;
		@(posedge CLKA) ; 
		FFA_del_count	<= 3'b001;
		@(posedge CLKA) ;
		#SIG_DELAY	FFA_del_count	<= 3'b000;	
	end
end
//-------------

always @(posedge CLKA or negedge MRST1_N)	begin

	if (!MRST1_N)
		FFA_N_IRA_i	<= 1'b0 ;
	else if (assert_ira)
		FFA_N_IRA_i	<= 1'b1 ;
		
	else 	begin
		if (FFA_N_IRA_i)	begin
			if (pushA && ((portA_wr_ptr +1'b1) == portB_rd_ptr) ) 
					FFA_N_IRA_i <= 1'b0 ;	
			else if (fifo1_word_count == FIFO_DEPTH)
					FFA_N_IRA_i <= 1'b0 ;	
		end
		else	begin
			
			`ifdef	WARNING_ON
			if (pushA)
				$display ($time,":Warning : PortA write attempted when the Full/InputRdy flag was Low.");
			`endif
			
			if( (FFA_del_count >= 1) )	// 09-06
					FFA_N_IRA_i <= 1'b1 ;
		end
	end	
end
//-------------------------
// PortA Almost Full Flag
//-------------------------

always @(portA_wr_ptr or portB_rd_ptr or RT1_N or ENB or FWFT_N_STAN_reg1 or fifo1_half_full)	begin
	if (portA_wr_ptr > portB_rd_ptr)
		fifo1_word_count 	<= (portA_wr_ptr - portB_rd_ptr);	
	
	else if (portA_wr_ptr < portB_rd_ptr)
		fifo1_word_count 	<= ((portA_wr_ptr + FIFO_DEPTH) - portB_rd_ptr);
	
	else if ((!RT1_N & !ENB & FWFT_N_STAN_reg1)  & (portA_wr_ptr == portB_rd_ptr))
		fifo1_word_count 	<= FIFO_DEPTH ;
	
	else	begin
		if (fifo1_half_full)
			fifo1_word_count 	<= FIFO_DEPTH ;
		else
			fifo1_word_count 	<= 0 ;	
	end
end
//-----------
//always @(posedge CLKA or negedge MRST1_N)	begin		// 08-30 
always @(MRST1_N or fifo1_word_count)	begin
	if (!MRST1_N)
		fifo1_half_full		<= 1'b0;
	
	else if (fifo1_word_count > (FIFO_DEPTH/2))
		fifo1_half_full		<= 1'b1;
	else
		fifo1_half_full		<= 1'b0;
end
//---------------------

always @(posedge CLKA or negedge MRST1_N)	begin

	if (!MRST1_N)
		AFA_N_i	<= 1'b1;
	else	begin
		if (AFA_N_i)	begin
			//if ( (pushA & FFA_N_IRA) && (fifo1_word_count == (FIFO_DEPTH - AFA_offset -1'b1)) ) // debug 08-23-01 (test - ez_program)
			if ( (pushA & FFA_N_IRA) && (fifo1_word_count == (FIFO_DEPTH - AFA_offset -1'b1)) && !offset_over_portA_flag)	
				AFA_N_i	<= 1'b0;
			else if (fifo1_word_count >= (FIFO_DEPTH - AFA_offset ))
				AFA_N_i	<= 1'b0;
		end
		else if (!AFA_N_i)	begin

			if (fifo1_word_count_del < (FIFO_DEPTH - (AFA_offset +1'b1) ))
				AFA_N_i	<= 1'b1;
			else 
				AFA_N_i	<= 1'b0;
		end
	end
end

//--------------------------------------------------------
// PortB Empty/OutputRdy Flag
//---------------------------

assign temp_clk_count0 = FIFO1_clk_count[0] ;
assign temp_clk_count1 = FIFO1_clk_count[1] ;
assign temp_clk_count2 = FIFO1_clk_count[2] ;
assign temp_clk_count3 = FIFO1_clk_count[3] ;

always @(posedge CLKB or negedge MRST1_N)	begin

	if (!MRST1_N)	begin
		EFB_N_ORB_i	<= 1'b0;
		portB_output_reg1	<= {DATA_WIDTH{1'b0}};
	end
	
	else	begin
		if (EFB_N_ORB_i)	begin
			if (popB)	begin
				if ( ((portB_rd_ptr+1'b1) == portA_wr_ptr) && FWFT_N_STAN_reg1 )	begin	//09-06
					EFB_N_ORB_i	<= 1'b0;
				end
				
				else if ((fifo1_word_count == 0) && !FWFT_N_STAN_reg1)	begin	//09-06
					EFB_N_ORB_i	<= 1'b0;
				end
					
				else	begin
					
					if (  !FWFT_N_STAN_reg1 )	begin	//	08-30
						EFB_N_ORB_i	<= 1'b1;
						//portB_output_reg1 <= FIFO1[portB_rd_ptr+1];	// TBD
						portB_output_reg1 <= FIFO1[portB_rd_ptr];
						
						FIFO1_clk_count[portB_rd_ptr]	<= #1	3'b000 ;	// TBD
					end
				end	
			end
		end
		else	begin
		
			`ifdef	WARNING_ON
			if (popB)	
				$display($time,":Warning : PortB read attempted when the Empty/OutputRdy flag was Low.");
			`endif
			
			if ( (FIFO1_clk_count[portB_rd_ptr] >= 2 ) && FWFT_N_STAN_reg1 )	begin
				EFB_N_ORB_i	<= 1'b1;
				portB_output_reg1 <= FIFO1[portB_rd_ptr];
			end
			else if ( (FIFO1_clk_count[portB_rd_ptr] >= 3 ) && !FWFT_N_STAN_reg1 )	begin
				EFB_N_ORB_i	<= 1'b1;
				portB_output_reg1 <= FIFO1[portB_rd_ptr];
				FIFO1_clk_count[portB_rd_ptr]	<= #1	3'b000;		// <----- TBD
				portB_rd_ptr	<= portB_rd_ptr + 1'b1 ;		// <----- TBD
			end
			else
				EFB_N_ORB_i	<= 1'b0;
		end
	end	
end
//--------------------------------------------------------
// PortB Almost Empty Flag
//---------------------------

assign #tSKEW2 fifo1_word_count_del = fifo1_word_count ;

always @(posedge CLKB or negedge MRST1_N)	begin

	if (!MRST1_N)
		AEB_N_i	<= 1'b0;
	
	else	begin
		if(AEB_N_i)	begin
			if ((popB & EFB_N_ORB) && (fifo1_word_count == (AEB_offset +1'b1)))
				AEB_N_i	<= 1'b0;	
		end
		else if (!AEB_N_i)	begin
			if (fifo1_word_count_del > (AEB_offset+1'b1))
				AEB_N_i	<= 1'b1;
			else 
				AEB_N_i	<= 1'b0;
		end	
	end
end
//--------------------------------------------------------
// PortB Full/InputRdy Flag
//-------------------------

always	begin	: assert_irb_loop
	assert_irb <= 1'b0;
	
	wait (!MRST2_N);
	@(posedge MRST2_N);
	
	#SIG_DELAY ;
	
	if (!offset_over_portA_flag)	begin		// if the OFFSET values are set with  8 or 16 or 64
		@(posedge CLKB);			// ie. {FS1,FS0} != 00 ;
		#SIG_DELAY	assert_irb <= 1'b1;
	end
	
	else	begin
	
		wait(!offset_over_portA_flag);		// {FS1,FS0} == 00 ;
		#tSKEW1 ;
		@(posedge CLKB);			// so the offset values are programmed over the portA
		#SIG_DELAY	assert_irb <= 1'b1;
	end
	
	@(posedge CLKB);
	#SIG_DELAY	assert_irb <= 1'b0;
		
end
//-------------
always 	@(posedge CLKA or negedge MRST2_N)	begin

	if (!MRST2_N)
		FFB_del_count	<= 3'b000;
	else if ((!FFB_N_IRB & popA & EFA_N_ORA) || 		// 09-12 added EFA_N_ORA
			(!EFA_N_ORA_i &&  (FIFO2_clk_count[portA_rd_ptr] >= 3 ) && !FWFT_N_STAN_reg2 )  )	begin
		#tSKEW1	 ;
		@(posedge CLKB) ; 
		FFB_del_count	<= 3'b001;
		@(posedge CLKB) ;
		#SIG_DELAY	FFB_del_count	<= 3'b000;	
	end
end
//-------------
always @(posedge CLKB or negedge MRST2_N)	begin

	if (!MRST2_N)
		FFB_N_IRB_i	<= 1'b0 ;
	else if (assert_irb)
		FFB_N_IRB_i	<= 1'b1 ;
		
	else 	begin
		if (FFB_N_IRB_i)	begin
			if (pushB && ((portB_wr_ptr +1'b1) == portA_rd_ptr) ) 
					FFB_N_IRB_i <= 1'b0 ;
			else if (fifo2_word_count == FIFO_DEPTH)
					FFB_N_IRB_i <= 1'b0 ;		
		end
		else	begin
		
			`ifdef	WARNING_ON
			if (pushB)
				$display ($time,":Warning : PortB write attempted when the Full/InputRdy flag was Low.");
			`endif
			
			//if( (portB_wr_ptr  !== portA_rd_ptr) && (FFB_del_count >= 1) )	
			if( (FFB_del_count >= 1) )		// 09-12
					FFB_N_IRB_i <= 1'b1 ;
		end
	end	
end
//-------------------------
// PortB Almost Full Flag
//-------------------------

always @(portB_wr_ptr or portA_rd_ptr or RT2_N or ENB or FWFT_N_STAN_reg2 or fifo2_half_full)	begin
	if (portB_wr_ptr > portA_rd_ptr)
		fifo2_word_count 	<= (portB_wr_ptr - portA_rd_ptr);	
	
	else if (portB_wr_ptr < portA_rd_ptr)
		fifo2_word_count 	<= ((portB_wr_ptr + FIFO_DEPTH) - portA_rd_ptr);
	
	else if ((!RT2_N & !ENB & FWFT_N_STAN_reg2)  & (portA_wr_ptr == portB_rd_ptr))
		fifo2_word_count 	<= FIFO_DEPTH ;
	
	else	begin
		if (fifo2_half_full)
			fifo2_word_count 	<= FIFO_DEPTH ;
		else
			fifo2_word_count 	<= 0 ;	
	end
end
//-----------
//always @(posedge CLKB or negedge MRST2_N)	begin	// 09-12
always @(MRST2_N or fifo2_word_count )	begin

	if (!MRST2_N)
		fifo2_half_full		<= 1'b0;
	
	else if (fifo2_word_count > (FIFO_DEPTH/2))
		fifo2_half_full		<= 1'b1;
	else
		fifo2_half_full		<= 1'b0;
end
//---------------------

always @(posedge CLKB or negedge MRST2_N)	begin

	if (!MRST2_N)
		AFB_N_i	<= 1'b1;
	else	begin
		if (AFB_N_i)	begin
			//if ( (pushB & FFB_N_IRB) && (fifo2_word_count == (FIFO_DEPTH - AFB_offset -1'b1)) ) // debug 08-23-01 (test - ez_program)
			if ( (pushB & FFB_N_IRB) && (fifo2_word_count == (FIFO_DEPTH - AFB_offset -1'b1) ) && !offset_over_portA_flag)
				AFB_N_i	<= 1'b0;
			
			else if (fifo2_word_count >= (FIFO_DEPTH - AFB_offset ))
				AFB_N_i	<= 1'b0;
		end
		else if (!AFB_N_i) begin
			
			if (fifo2_word_count_del < (FIFO_DEPTH - (AFB_offset + 1'b1) ))
				AFB_N_i	<= 1'b1;
			else 
				AFB_N_i	<= 1'b0;
		end
	end
end

//--------------------------------------------------------
// PortA Empty/OutputRdy Flag
//---------------------------

always @(posedge CLKA or negedge MRST2_N)	begin

	if (!MRST2_N)	begin
		EFA_N_ORA_i	<= 1'b0;
		portA_output_reg1	<= {DATA_WIDTH{1'b0}};
	end
	
	else	begin
		if (EFA_N_ORA_i)	begin
			if (popA)	begin
				if ( ((portA_rd_ptr+1'b1) == portB_wr_ptr) && FWFT_N_STAN_reg2 )	begin
					EFA_N_ORA_i	<= 1'b0;
				end
				
				else if ((fifo2_word_count == 0) && !FWFT_N_STAN_reg2)	begin	//09-012
					EFA_N_ORA_i	<= 1'b0;
				end
				
				else	begin
					
					if ( !FWFT_N_STAN_reg2 )	begin
						EFA_N_ORA_i	<= 1'b1;
						//portA_output_reg1 <= FIFO2[portA_rd_ptr+1'b1];	// TBD
						portA_output_reg1 <= FIFO2[portA_rd_ptr];
						
						FIFO2_clk_count[portA_rd_ptr]	<= #1	3'b000 ;	// TBD
					end
					/*else	begin
						EFA_N_ORA_i	<= 1'b0;
					end
					*/
				end	
			end
		end
		else	begin
			
			`ifdef	WARNING_ON
			if (popA)	
				$display($time,":Warning : PortA read attempted when the Empty/OutputRdy flag was Low.");
			`endif
			
			if ( (FIFO2_clk_count[portA_rd_ptr] >= 2 ) && FWFT_N_STAN_reg2 )	begin
				EFA_N_ORA_i	<= 1'b1;
				portA_output_reg1 <= FIFO2[portA_rd_ptr];
			end
			else if ( (FIFO2_clk_count[portA_rd_ptr] >= 3 ) && !FWFT_N_STAN_reg2 )	begin
				EFA_N_ORA_i	<= 1'b1;
				portA_output_reg1 <= FIFO2[portA_rd_ptr];
				FIFO2_clk_count[portA_rd_ptr] <= #1  	3'b000 ;	// TBD
				portA_rd_ptr	<= portA_rd_ptr + 1'b1 ;	// TBD
			end
			else
				EFA_N_ORA_i	<= 1'b0;				
		end
	end	
end
//--------------------------------------------------------
// PortA Almost Empty Flag
//---------------------------

assign  #tSKEW2	fifo2_word_count_del = fifo2_word_count;

always @(posedge CLKA or negedge MRST2_N)	begin

	if (!MRST2_N)
		AEA_N_i	<= 1'b0;
	
	else	begin
		if(AEA_N_i)	begin
			if ((popA & EFA_N_ORA) && (fifo2_word_count == (AEA_offset +1'b1)))
				AEA_N_i	<= 1'b0;	
		end
		else if (!AEA_N_i)	begin
			if (fifo2_word_count_del > (AEA_offset+1'b1) )
				AEA_N_i	<= 1'b1;
			else 
				AEA_N_i	<= 1'b0;
		end	
	end
end
//------------------------------------------------------------
// Flag delays related during/after Retransmit operation
//------------------------------------------------------------
// FFA_N and EFB_N becomes valid after tRTR period, after the deassertion of the RT1_N

always	begin	: rt1_rtr_loop
	rt1_rtr	<= 1'b1 ;
	
	@(negedge RT1_N) rt1_rtr <= 1'b0 ;
	@(posedge RT1_N) ;
	#tRTR	rt1_rtr <= 1'b1 ;
end
//--------------------
// FFB_N and EFA_N becomes valid after tRTR period, after the deassertion of the RT2_N

always	begin	: rt2_rtr_loop
	rt2_rtr	<= 1'b1 ;
	
	@(negedge RT2_N) rt2_rtr <= 1'b0 ;
	@(posedge RT2_N) ;
	#tRTR	rt2_rtr <= 1'b1 ;
end
//--------------------
// AFA_N flag becomes valid , 2 CLKAs after the tRTR period.

always	begin	: rt1_rtr_2clkA_loop
	rt1_rtr_2clkA	<= 1'b1 ;
	
	@(negedge RT1_N) rt1_rtr_2clkA <= 1'b0 ;
	@(posedge RT1_N) ;
	#tRTR	;
	@(posedge CLKA) ; @(posedge CLKA) ;
	rt1_rtr_2clkA <= 1'b1 ;
end
//--------------------
// AEB_N flag becomes valid , 2 CLKBs after the tRTR period.

always	begin	: rt1_rtr_2clkB_loop
	rt1_rtr_2clkB	<= 1'b1 ;
	
	@(negedge RT1_N) rt1_rtr_2clkB <= 1'b0 ;
	@(posedge RT1_N) ;
	#tRTR	;
	@(posedge CLKB) ; @(posedge CLKB) ;
	rt1_rtr_2clkB <= 1'b1 ;
end
//--------------------
// AFB_N flag becomes valid , 2 CLKBs after the tRTR period.

always	begin	: rt2_rtr_2clkB_loop
	rt2_rtr_2clkB	<= 1'b1 ;
	
	@(negedge RT2_N) rt2_rtr_2clkB <= 1'b0 ;
	@(posedge RT2_N) ;
	#tRTR	;
	@(posedge CLKB) ; @(posedge CLKB) ;
	rt2_rtr_2clkB <= 1'b1 ;
end
//--------------------
// AEA_N flag becomes valid , 2 CLKAs after the tRTR period.

always	begin	: rt2_rtr_2clkA_loop
	rt2_rtr_2clkA	<= 1'b1 ;
	
	@(negedge RT2_N) rt2_rtr_2clkA <= 1'b0 ;
	@(posedge RT2_N) ;
	#tRTR	;
	@(posedge CLKA) ; @(posedge CLKA) ;
	rt2_rtr_2clkA <= 1'b1 ;
end
//--------------------
initial	begin
	#1 $display ("\nThe Freq. grade of the FIFO = %d", OP_RATE);
	   $display ("\nThe Depth of the FIFO = %d\n", FIFO_DEPTH);
end
//------------------------------------------------------
endmodule
