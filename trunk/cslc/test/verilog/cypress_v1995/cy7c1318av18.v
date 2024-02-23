//*****************************************************************************
//*****************************************************************************
// This model is the property of Cypress Semiconductor Corp. and is protected**
// by the US copyright laws, any unauthorized copying and distribution is    **	
// prohibited. Cypress reserves the right to change any of the functional    **
// specifications without any prior notice.Cypress is not liable for any     **
// damages which may result from the use of this functional model.           **
//									     **
//  									     **	
// File name		:		CY7C1318AV18.v			     **
//									     **
// Date			:		February 5, 2003		     **	
//									     ** 									 
// Model		:		CY7C1318AV18(1M x 18 Two word burst   **
//					with DDR-II Architecture)            **
//									     **
// Revision		:		Rev 1.0 : New	model created	     **
//					Rev 1.1 : Model modified to include  ** 
//						  JTAG 			     **
// Queries		:		MPD Applications		     **
//					Ph#: (408)-943-2821		     **
//					Webpage: www.cypress.com/support     **
//									     **
// Comments		: This is a functional model with most of the timings**
//			  and closely emulates the actual device. Select the **
//			  timing bin which you use from the below table.     **
//			  The model would still function even if the timings **
//			  are violated, but these are notified.    	     **
//*****************************************************************************
//***************************************************************************** 

`timescale 1 ns/1 ps
 


//Timings for 300 MHz 

`define tCYC	3.6     //Average Clock cycle time
`define tKH	1.32	//Clock high time
`define tKL	1.32	//Clock low time
`define tCO	#0.45	//Data valid from positive clock edges
`define tDOH	0.45	//Data hold(negative) from positive clock edges
`define tCLZ	0.45	//Positive clock edges to Low-Z(negative)
`define tCHZ	#0.45	//Positive clock edge to High-Z
`define tCCQO   #0.45	//Positive clock edges to echo clocks valid
`define tCQOH	0.45	//Echo clocks hold(negative) from positive clock edges
`define tSA	0.40	//Address setup time to K rising edge
`define tSC	0.40	//Control signals(WE_bar, LD_bar) setup time
`define tSCddr	0.30	//Control signals(BWSx) setup time
`define tSD	0.30	//Data setup to K and K_bar rising edge
`define tHA	0.40	//Address hold time after K rising edge
`define tHC	0.40	//Control signals(WE_bar, LD_bar)  hold time
`define tHCddr	0.30	//Control signals(BWSx) hold time
`define tHD	0.30	//Data holdtime after K and K_bar rising edges         
/*
//Timings for 250 MHz 

`define tCYC	4.5     //Average Clock cycle time
`define tKH	1.6	//Clock high time
`define tKL	1.6	//Clock low time
`define tCO	#0.45	//Data valid from positive clock edges
`define tDOH	0.45	//Data hold(negative) from positive clock edges
`define tCLZ	0.45	//Positive clock edges to Low-Z(negative)
`define tCHZ	#0.45	//Positive clock edge to High-Z
`define tCCQO   #0.45	//Positive clock edges to echo clocks valid
`define tCQOH	0.45	//Echo clocks hold(negative) from positive clock edges
`define tSA	0.50	//Address setup time to K rising edge
`define tSC	0.50	//Control signals(WE_bar, LD_bar) setup time
`define tSCddr	0.35	//Control signals(BWSx) setup time
`define tSD	0.35	//Data setup to K and K_bar rising edge
`define tHA	0.50	//Address hold time after K rising edge
`define tHC	0.50	//Control signals(WE_bar, LD_bar)  hold time
`define tHCddr	0.35	//Control signals(BWSx) hold time
`define tHD	0.35	//Data holdtime after K and K_bar rising edges    

//Timings for 200 MHz 

`define tCYC	5.5     //Average Clock cycle time
`define tKH	2.0	//Clock high time
`define tKL	2.0	//Clock low time
`define tCO	#0.45	//Data valid from positive clock edges
`define tDOH	0.45	//Data hold(negative) from positive clock edges
`define tCLZ	0.45	//Positive clock edges to Low-Z(negative)
`define tCHZ	#0.45	//Positive clock edge to High-Z
`define tCCQO   #0.45	//Positive clock edges to echo clocks valid
`define tCQOH	0.45	//Echo clocks hold(negative) from positive clock edges
`define tSA	0.60	//Address setup time to K rising edge
`define tSC	0.60	//Control signals(WE_bar, LD_bar) setup time
`define tSCddr	0.40	//Control signals(BWSx) setup time
`define tSD	0.40	//Data setup to K and K_bar rising edge
`define tHA	0.60	//Address hold time after K rising edge
`define tHC	0.60	//Control signals(WE_bar, LD_bar)  hold time
`define tHCddr	0.40	//Control signals(BWSx) hold time
`define tHD	0.40	//Data holdtime after K and K_bar rising edges  


//Timings for 166 MHz 

`define tCYC	6.75     //Average Clock cycle time
`define tKH	2.4	//Clock high time
`define tKL	2.4	//Clock low time
`define tCO	#0.50	//Data valid from positive clock edges
`define tDOH	0.50	//Data hold(negative) from positive clock edges
`define tCLZ	0.50	//Positive clock edges to Low-Z(negative)
`define tCHZ	#0.50	//Positive clock edge to High-Z
`define tCCQO   #0.50	//Positive clock edges to echo clocks valid
`define tCQOH	0.50	//Echo clocks hold(negative) from positive clock edges
`define tSA	0.70	//Address setup time to K rising edge
`define tSC	0.70	//Control signals(WE_bar, LD_bar) setup time
`define tSCddr	0.40	//Control signals(BWSx) setup time
`define tSD	0.40	//Data setup to K and K_bar rising edge
`define tHA	0.70	//Address hold time after K rising edge
`define tHC	0.70	//Control signals(WE_bar, LD_bar)  hold time
`define tHCddr	0.40	//Control signals(BWSx) hold time
`define tHD	0.40	//Data holdtime after K and K_bar rising edges 
*/     

`define wordsize (18 -1) //Size of the data bus to be defined
`define no_words (1048576 -1)		// 1Mx18

// JTAG Definitions
						// State definitions	 Binary	  Hex
						// ----------------------------------------
`define reset		4'b1111	// Test-Logic-Reset 	= 1111	  0xF
`define idle		4'b1100	// Run-Test-Idle		= 1100	  0xC
`define select_DR_scan	4'b0111	// Select-DR-scan		= 0111	  0x7
`define select_IR_scan	4'b0100	// Select-IR-scan		= 0100	  0x4
`define capture_DR	4'b0110	// Capture-DR		= 0110	  0x6
`define capture_IR	4'b1110	// Capture-IR		= 1110	  0xE
`define shift_DR		4'b0010	// Shift-DR			= 0010	  0x2
`define shift_IR		4'b1010	// Shift-IR			= 1010	  0xA
`define exit1_DR		4'b0001	// Exit1-DR			= 0001	  0x1
`define exit1_IR		4'b1001	// Exit1-IR			= 1001	  0x9
`define pause_DR		4'b0011	// Pause-DR			= 0011	  0x3
`define pause_IR		4'b1011	// Pause-IR			= 1011	  0xB
`define exit2_DR		4'b0000	// Exit2-DR			= 0000	  0x0
`define exit2_IR		4'b1000	// Exit2-IR			= 1000	  0x8
`define update_DR		4'b0101	// Update-DR		= 0101	  0x5
`define update_IR		4'b1101	// Update-IR		= 1101	  0xD
						// ---------------------------------------

						// Command Definitions	 Binary	  Hex
						// ---------------------------------------
`define extest		3'b000	// EXTEST			= 000		  0x0
`define idcode		3'b001	// IDCODE			= 001		  0x1
`define samplz		3'b010	// SAMPLE-Z			= 010	  	  0x2
`define resrv1		3'b011	// reserved			= 011	  	  0x3
`define sampld		3'b100	// SAMPLE/PRELOAD		= 100	  	  0x4
`define resrv2		3'b101	// reserved			= 101	  	  0x5
`define resrv3		3'b110	// reserved			= 110	  	  0x6
`define bypass		3'b111	// BYPASS			= 111	  	  0x7
// ----------------------------------------
// Commands are determined by status of ir_p register.
// JTAG AC Timings

`define tclkcyc	#100		// TCK cycle time (min)
`define th	#40			// TCK clock high (min)
`define tl	#40			// TCK clock low (min)	
`define ttmss	10		// TMS set-up to TCK clock rise (min)
`define ttdis	10		// TDI set-up to TCK clock rise (min)
`define tcs	10			// Capture set-up to TCK clock rise (min)
`define ttmsh	10		// TMS hold after TCK clock rise (min)
`define ttdih	10		// TDI hold after TCK clock rise (min)
`define tch	10			// Capture hold after TCK clock rise (min)
`define ttdov	#20		// TCK clock LOW to TDO valid (max)
`define ttdox	0		// TCK clock LOW to TDO invalid (min)

`define tdly	#0.01

module ddr2_burst2 (TCK,TMS,TDI,TDO,K, K_bar, CQ, CQ_bar, C, C_bar, BW, LD_bar, WE_bar, A, DQ,ZQ,DOFF);

input 		TCK,TMS,TDI;
output		TDO;
input 		K, K_bar, C, C_bar;
input		LD_bar, WE_bar;
input	[1:0]	BW;
input	[19:0]	A;
inout		CQ, CQ_bar;
inout	[17:0]	DQ;
input 		ZQ;
input		DOFF;



reg	[17:0]	data_in1, data_in2, Data_out; 
reg	[8:0]	Mem_array_lb [20'hffffe:0];
reg	[17:9]	Mem_array_ub [20'hffffe:0];
reg	[19:0]	Address_reg; 
reg	[1:0]	BW_reg_pos, BW_reg_neg;
reg	[19:0]  Wr_Address_reg1, Wr_Address_reg2;
reg	[19:0]	Rd_Address_reg1, Rd_Address_reg2;
reg	[1:0] 	present_cycle, prev_cycle1, prev_cycle2;
reg		read_write;
reg		Rd_Clk, Rd_Clk_bar;
reg		Sel1, Sel2;
reg		dll_Clk, dll_Clk_bar;
real	 	tdll, techo, tk1, tk2, text_cyc;
reg		notifier;
reg 		echoclk,echoclkb,echo_on;

`define Read	2'b00
`define Write	2'b01
`define None	2'b10
// ********** JTAG signals..... ************

reg[3:0] state, prev_state;
reg[2:0] reg_flag;
reg[2:0] instr;
reg	 extest_en;		// Signal designed to indicate when an EXTEST instruction is entered -- active high
reg	 samplz_en;		// Singal designed to indicate when an SAMPLZ instruction is entered -- active high
reg	 extest_oe;		// Controls the output pins during EXTEST. low: high-z, high: enable
reg[31:0] vendor_code;
reg[37:0] preload;

reg tdo_tristate;		// tdo disable pin -- Controls the state of the tdo pin -- low enable
reg tdo;			// Internal tdo pin
reg shift_out;
integer i;

wire [`wordsize:0]  chip_out =  read_write ?  Data_out : 18'bz ;	// data bus coming out from the SRAM
wire cq_out = echo_on ? echoclk : 1'bz;			// echo clock coming out from the SRAM
wire cqb_out = echo_on ? echoclkb : 1'bz;			// echo clock coming out from the SRAM

wire TDO =  !tdo_tristate ?  tdo : 1'bz;	// Output TDO pin

// When EXTEST-enable is 0, the data output should use the chip data, when 1, the EXTEST data.
wire [17:0]pre_out = !extest_en ? chip_out[17:0] : preload[17:0];
wire CQ =  !extest_en ? cq_out : preload[18];
wire CQ_bar = !extest_en ? cqb_out : preload[19];

// oe is the output enable for the entire chip. Controlled by extest_oe during EXTEST. Active HIGH.
wire oe = (!extest_en ? read_write : extest_oe) && !samplz_en;

// Output buffer logic  
wire[17:0] DQ = !oe ? 18'bz : pre_out[17:0];

reg[2:0] ir_p, ir_s;	// Dual Instruction Registers (p=parallel-load, s=shift-load)
reg	 byp;		// Bypass Register
reg[31:0] dir;		// Device Identification Register -- parallel-loaded with Vendor_code during IDCODE instruction
reg[106:0] bsr;		// 107-bit boundary scan register.

// ****************************** End signal definitions 


initial
	begin
		tk2 = 0;
		tk1 = 0;
		echo_on	= 1;
	end

//---------------Single clock mode----------------------------------------------
always @(posedge K)
	begin
		tk2 = tk1;
		tk1 = $realtime;
    		text_cyc = tk1 - tk2;
		tdll = text_cyc - `tCLZ;
		techo = text_cyc - `tCQOH;
		if (C == 1'b1 && C_bar == 1'b1) 
			Sel1 <= 1'b1;
		else
			Sel1 <= 1'b0;
	end

always @(negedge K)
	begin
		if (C == 1'b1 && C_bar == 1'b1) 
			Sel2 <= 1'b1;
		else
			Sel2 <= 1'b0;
	end

always @(Sel1 or Sel2 or K or K_bar or C or C_bar)
	begin
		if (Sel1 == 1 && Sel2 == 1)
		     begin
			Rd_Clk <= K;
			Rd_Clk_bar <= K_bar;
		     end
		else
		     begin
			Rd_Clk <= C;
			Rd_Clk_bar <= C_bar;
		     end
	end
//----------------dll clock generation------------------------------------------
//Generate dll clocks which are an offset of C and C_bar and which are used to
//turn on and turn off the bus before the rising edges of C and C_bar

always @(posedge Rd_Clk)
	begin
		#tdll dll_Clk <= 1;
	end

always @(negedge Rd_Clk)
	begin
		#tdll dll_Clk <= 0;
	end

always @(posedge Rd_Clk_bar)
	begin
		#tdll dll_Clk_bar <= 1;
	end

always @(negedge Rd_Clk_bar)
	begin
		#tdll dll_Clk_bar <= 0;
	end

//---------------Address latching-----------------------------------------------
always @(posedge K)
       begin	
	if (!LD_bar)
		Address_reg 	 <= A;
	if (present_cycle == `Write)
		Wr_Address_reg1 <= Address_reg;
	if (prev_cycle1 == `Write)
		Wr_Address_reg2[19:1] <= Wr_Address_reg1[19:1];
	if (present_cycle == `Read)
		Rd_Address_reg1 <= Address_reg;
	if (prev_cycle1 == `Read)
		Rd_Address_reg2[19:1] <= Rd_Address_reg1[19:1];
       end

//---------------Read and write cycles implementation---------------------------
initial
	begin
		present_cycle <= `None;
		prev_cycle1   <= `None;
		prev_cycle2   <= `None;
		read_write    <=  0;	
	end

always @(posedge K)
	begin
		prev_cycle1 <= present_cycle;
		prev_cycle2 <= prev_cycle1;
		if (!LD_bar)
		      begin
			if (!WE_bar) 
				present_cycle <= `Write;
			else	
				present_cycle <= `Read;
		      end
		else
			present_cycle <= `None;	
	end        

always @(posedge K)
	begin
		if (present_cycle == `Read && !LD_bar && !WE_bar)
			$display ("Illegal operation. A NOP should be provided between a read and the subsequent write");
	end


//---------------Write data and Byte writes latching----------------------------
always @(posedge K)
	begin
		if (present_cycle == `Write) 
		    begin
			data_in1 	<= DQ;
			BW_reg_pos	<= BW;
	            end
	end

always @(posedge K_bar)
	begin
		if (prev_cycle1 == `Write) 
		    begin
			data_in2 	<= DQ;
			BW_reg_neg	<= BW;
		    end
	end

//----------------Burst counter implementation----------------------------------	
always @(posedge K)
	begin
		if (prev_cycle1 == `Write)
			Wr_Address_reg2[0] <= Wr_Address_reg1[0] + 1;
		if (prev_cycle1 == `Read)
			Rd_Address_reg2[0] <= Rd_Address_reg1[0] + 1;
	end

//----------------Writing into the memory array--------------------------------
always @(posedge K)
	begin
		if (prev_cycle1 == `Write)
		     begin
			if (!BW_reg_pos[0])
				Mem_array_lb[Wr_Address_reg1] <= data_in1[8:0];
			if (!BW_reg_pos[1])
				Mem_array_ub[Wr_Address_reg1] <= data_in1[17:9];
		     end
	end	

always @(posedge K_bar)
	begin
		if (prev_cycle2 == `Write)
		     begin
			if (!BW_reg_neg[0])
				Mem_array_lb[Wr_Address_reg2] <= data_in2[8:0];
			if (!BW_reg_neg[1])
				Mem_array_ub[Wr_Address_reg2] <= data_in2[17:9];
		     end
	end

//-----------------Reading from the memory array-------------------------------
always @(posedge Rd_Clk_bar)
	begin
		if (prev_cycle1 == `Read)
		    begin	
			Data_out[17:0] = 18'hzz;
			fork
			Data_out[8:0] <= `tCO Mem_array_lb[Rd_Address_reg1];
			Data_out[17:9] <= `tCO Mem_array_ub[Rd_Address_reg1];
			join
		    end	
	end  

always @(posedge Rd_Clk)
	begin
		if (prev_cycle2 == `Read)
		    begin
			Data_out[17:0] = 18'hzz;
			fork	
			Data_out[8:0] <= `tCO Mem_array_lb[Rd_Address_reg2];
			Data_out[17:9] <= `tCO Mem_array_ub[Rd_Address_reg2];
			join
		    end	
	end 

//------------------Read data enable------------------------------------------
always @(posedge dll_Clk_bar)
	begin
		if (prev_cycle1 == `Read)
			read_write <= 1;
	end

always @(posedge Rd_Clk_bar)
	begin
		if (prev_cycle1 != `Read && prev_cycle2 == `Read)
			read_write <= `tCHZ 0;
	end

//------------------Implementation of negative hold times--------------------
always @(posedge dll_Clk_bar)
	begin
		if (prev_cycle1 == `Read || prev_cycle2 == `Read)
			Data_out <= 18'bz;
	end

always @(posedge dll_Clk)
	begin
		if (prev_cycle1 == `Read || prev_cycle2 == `Read)
			Data_out <= 18'bz;
	end

//------------------Generation of Echo clocks--------------------------------

always @(posedge Rd_Clk)
	begin   
		fork
		echoclk <= `tCCQO 1;
		#techo echoclkb <= 0;
		join
	end

always @(posedge Rd_Clk_bar)
	begin
		fork
		echoclkb <= `tCCQO 1;
		#techo echoclk <= 0;
		join
	end

// **********************************************************
// ******************** JTAG Section ************************ 
// **********************************************************

//---------- Initial statements --------------//

initial
begin 
	state = `reset;
	prev_state = `reset;
	vendor_code = 32'b00011010100010010101000001101001;	// IDCODE for DDR2 CY7C1318AV18 device. This may not be changed.
	tdo_tristate = 1;
	extest_en = 0;
	samplz_en = 0;
	extest_oe = 0;
        read_write = 0;
#0.1;
	ir_p = `idcode;
end

//------ State Control - TAP controller ------//   

always @(posedge TCK)	
begin
	prev_state = state;
	if (TMS == 0)
		begin
			if (state == `reset)			`tdly state = `idle;
			else if (state == `idle)		`tdly state = `idle;
			else if (state == `select_DR_scan)	`tdly state = `capture_DR;
		 	else if (state == `select_IR_scan)	`tdly state = `capture_IR;
			else if (state == `capture_DR)		`tdly state = `shift_DR;
			else if (state == `capture_IR)		`tdly state = `shift_IR;
			else if (state == `shift_DR)		`tdly state = `shift_DR;
			else if (state == `shift_IR)		`tdly state = `shift_IR;
			else if (state == `exit1_DR)		`tdly state = `pause_DR;
			else if (state == `exit1_IR)		`tdly state = `pause_IR;
			else if (state == `pause_DR)		`tdly state = `pause_DR;
			else if (state == `pause_IR)		`tdly state = `pause_IR;
			else if (state == `exit2_DR)		`tdly state = `shift_DR;
			else if (state == `exit2_IR)		`tdly state = `shift_IR;
			else if (state == `update_DR)		`tdly state = `idle;
			else if (state == `update_IR)		`tdly state = `idle;
		end
	else if (TMS == 1)
		begin
			if (state == `reset)			`tdly state = `reset;
			else if (state == `idle)		`tdly state = `select_DR_scan;
			else if (state == `select_DR_scan)	`tdly state = `select_IR_scan;
			else if (state == `select_IR_scan)	`tdly state = `reset;
			else if (state == `capture_DR)		`tdly state = `exit1_DR;
			else if (state == `capture_IR)		`tdly state = `exit1_IR;
			else if (state == `shift_DR)		`tdly state = `exit1_DR;
			else if (state == `shift_IR)		`tdly state = `exit1_IR;
			else if (state == `exit1_DR)		`tdly state = `update_DR;
			else if (state == `exit1_IR)		`tdly state = `update_IR;
			else if (state == `pause_DR)		`tdly state = `exit2_DR;
			else if (state == `pause_IR)		`tdly state = `exit2_IR;
			else if (state == `exit2_DR)		`tdly state = `update_DR;
			else if (state == `exit2_IR)		`tdly state = `update_IR;
			else if (state == `update_DR)		`tdly state = `select_DR_scan;
			else if (state == `update_IR)		`tdly state = `select_DR_scan;
		end
	else state = prev_state;
end

// -- When in reset mode, the selected instruction should be IDCODE -- //

always @(state)
begin
	if (state == `reset)
		begin
			ir_p = `idcode;
			extest_oe = 1'b0;
		end
	else if (state == `shift_IR)
		shift_out = ir_s[0];
	else if (state == `shift_DR)
	begin
		case (ir_p)
			`extest:	shift_out = bsr[0];
			`samplz:	shift_out = bsr[0];
			`sampld:	shift_out = bsr[0];
			`idcode:	shift_out = dir[0];
			`bypass:	shift_out = byp;
			default:	shift_out = 1'bx;
		endcase
	end		
	else	shift_out = 1'bx;
end

always @(ir_p)
begin
	case(ir_p)
		`extest:	instr = `extest;
		`idcode:	instr = `idcode;
		`samplz:	instr = `samplz;
		`sampld:	instr = `sampld;
		`bypass:	instr = `bypass;
		`resrv1:	instr = `resrv1;
		`resrv2:	instr = `resrv2;
		`resrv3:	instr = `resrv3;
		default:	instr = `resrv3;
	endcase
end

always @(instr)
begin
	if (instr == `extest)
		begin
			extest_en = 1;
			samplz_en = 0;
		end
	else if (instr == `samplz)
		begin
			extest_en = 0;
			samplz_en = 1;
		end
	else
		begin
			extest_en = 0;
			samplz_en = 0;
		end
end

always @(tdo_tristate)
begin
	if (tdo_tristate == 1)
		tdo = 1'bx;
end

always @(negedge TCK)
begin

	case (state)
		`shift_DR:
			begin	
				tdo_tristate = `ttdov 0;
				tdo = shift_out;
			end
		`shift_IR:
			begin
				tdo_tristate = `ttdov 0;
				tdo = shift_out;
			end
		`update_IR:
			begin
				tdo_tristate = 1;
				ir_p = ir_s;
			end
		`update_DR:
			begin
				tdo_tristate = 1;
				if (ir_p == `sampld || ir_p == `extest)
					begin
						preload[0] = bsr[9];
						preload[1] = bsr[13];
						preload[2] = bsr[17];
						preload[3] = bsr[21];
						preload[4] = bsr[25];
						preload[5] = bsr[30];
						preload[6] = bsr[34];
						preload[7] = bsr[38];
						preload[8] = bsr[42];
						preload[9] = bsr[65];
						preload[10] = bsr[69];
						preload[11] = bsr[73];
						preload[12] = bsr[77];
						preload[13] = bsr[81];
						preload[14] = bsr[85];
						preload[15] = bsr[89];
						preload[16] = bsr[93];
						preload[17] = bsr[97];
						preload[18] = bsr[46];		//CQ
						preload[19] = bsr[64];		//CQ_bar
						extest_oe = bsr[47];		//Extest Output enable;
					end
			end
		default:	tdo_tristate = 1;
	endcase
end

always @(posedge TCK)
begin

	case (state)
		`capture_IR:
			ir_s = 3'b001;

		`capture_DR:
			begin
				if (instr == `bypass)
						byp = 1'b0;
				else if(instr == `idcode)
						dir = vendor_code;
				else if(instr == `sampld || instr == `samplz || instr == `extest)
					begin
						bsr[106:0] = 106'bx;
						bsr[0] = C_bar;
						bsr[1] = C;
						bsr[2] = A[1];
						bsr[3] = A[2];
						bsr[4] = A[3];
						bsr[5] = A[4];
						bsr[6] = A[5];
						bsr[7] = A[6];
						bsr[8] = A[7];
						bsr[9] = DQ[0];
						bsr[10] = 1'b0;
						bsr[11] = 1'b0;
						bsr[12] = 1'b0;
						bsr[13] = DQ[1];
						bsr[14] = 1'b0;
						bsr[15] = 1'b0;
						bsr[16] = 1'b0;
						bsr[17] = DQ[2];
						bsr[18] = 1'b0;
						bsr[19] = 1'b0;
						bsr[20] = 1'b0;
						bsr[21] = DQ[3];
						bsr[22] = 1'b0;
						bsr[23] = 1'b0;
						bsr[24] = 1'b0;
						bsr[25] = DQ[4];
						bsr[26] = 1'b0;
						bsr[27] = ZQ;
						bsr[28] = 1'b0;
						bsr[29] = 1'b0;
						bsr[30] = DQ[5];
						bsr[31] = 1'b0;
						bsr[32] = 1'b0;
						bsr[33] = 1'b0;
						bsr[34] = DQ[6];
						bsr[35] = 1'b0;
						bsr[36] = 1'b0;
						bsr[37] = 1'b0;
						bsr[38] = DQ[7];
						bsr[39] = 1'b0;
						bsr[40] = 1'b0;
						bsr[41] = 1'b0;
						bsr[42] = DQ[8];
						bsr[43] = 1'b0;
						bsr[44] = 1'b0;
						bsr[45] = 1'b0;
						bsr[46] = CQ;
						bsr[47] = extest_oe;
						bsr[48] = A[8];
						bsr[49] = A[9];
						bsr[50] = A[10];
						bsr[51] = A[0];
						bsr[52] = LD_bar;
						bsr[53] = BW[1];
						bsr[54] = BW[0];
						bsr[55] = K;
						bsr[56] = K_bar;
						bsr[57] = 1'b0;
						bsr[58] = 1'b0;
						bsr[59] = WE_bar;
						bsr[60] = A[11];
						bsr[61] = A[12];
						bsr[62] = A[19];
						bsr[63] = DOFF;
						bsr[64] = CQ_bar;
						bsr[65] = DQ[9];
						bsr[66] = 1'b0;
						bsr[67] = 1'b0;
						bsr[68] = 1'b0;
						bsr[69] = DQ[10];
						bsr[70] = 1'b0;
						bsr[71] = 1'b0;
						bsr[72] = 1'b0;
						bsr[73] = DQ[11];
						bsr[74] = 1'b0;
						bsr[75] = 1'b0;
						bsr[76] = 1'b0;
						bsr[77] = DQ[12];
						bsr[78] = 1'b0;
						bsr[79] = 1'b0;
						bsr[80] = 1'b0;
						bsr[81] = DQ[13];
						bsr[82] = 1'b0;
						bsr[83] = 1'b0;
						bsr[84] = 1'b0;
						bsr[85] = DQ[14];
						bsr[86] = 1'b0;
						bsr[87] = 1'b0;
						bsr[88] = 1'b0;
						bsr[89] = DQ[15];
						bsr[90] = 1'b0;
						bsr[91] = 1'b0;
						bsr[92] = 1'b0;
						bsr[93] = DQ[16];
						bsr[94] = 1'b0;
						bsr[95] = 1'b0;
						bsr[96] = 1'b0;
						bsr[97] = DQ[17];
						bsr[98] = 1'b0;
						bsr[99] = 1'b0;
						bsr[100] = 1'b0;
						bsr[101] = A[13];
						bsr[102] = A[14];
						bsr[103] = A[15];
						bsr[104] = A[16];
						bsr[105] = A[17];
						bsr[106] = A[18];
					end
			end

		`shift_IR:
			begin
				ir_s[0] = ir_s[1];
				ir_s[1] = ir_s[2];
				ir_s[2] = TDI;
				shift_out = ir_s[0];			 			 		
			end		

		`shift_DR:
			begin
				byp = TDI;
				for(i=0; i<=30; i=i+1)
					dir[i] = dir[i+1];
				dir[31] = TDI;

				case (instr)
					`bypass:	shift_out = byp;

					`idcode:	shift_out = dir[0];

					`sampld:
						begin
							for(i=0; i<=105; i=i+1)
								bsr[i] = bsr[i+1];
							bsr[106] = TDI;
							shift_out = bsr[0];
						end
					`samplz:
						begin
							shift_out = bsr[0];
							for(i=0; i<=105; i=i+1)
								bsr[i] = bsr[i+1];
							bsr[106] = TDI;
							shift_out = bsr[0];
						end
					`extest:
						begin
							shift_out = bsr[0];
							for(i=0; i<=105; i=i+1)
								bsr[i] = bsr[i+1];
							bsr[106] = TDI;
							shift_out = bsr[0];
						end	
					default:	shift_out = TDI;
				endcase
			end
	endcase

end

//------------------Setup, Hold and width checks--------------------------------
wire  DQ1_setup = (present_cycle == `Write);
wire  DQ2_setup = (prev_cycle1 == `Write);

specify
	$setuphold(posedge K &&& ~LD_bar, A, `tSA, `tHA, notifier);           //Address
	$setuphold(posedge K &&& ~LD_bar, LD_bar, `tSC, `tHC, notifier);      //LD_bar
	$setuphold(posedge K &&& ~LD_bar, WE_bar, `tSC, `tHC, notifier);      //WE_bar	
	$setuphold(posedge K &&& DQ1_setup, DQ, `tSD, `tHD, notifier);	      //DQ1	
	$setuphold(posedge K_bar &&& DQ2_setup, DQ, `tSD, `tHD, notifier);    //DQ2	
	$setuphold(posedge K &&& DQ1_setup, BW, `tSCddr, `tHCddr, notifier);	      //BW1	
	$setuphold(posedge K_bar &&& DQ2_setup, BW, `tSCddr, `tHCddr, notifier);    //BW2	
	$width (posedge K, `tKH);
	$width (negedge K, `tKL);
	$width (posedge K_bar, `tKH);
	$width (negedge K_bar, `tKL);
	$width (posedge C, `tKH);
	$width (negedge C, `tKL);
	$width (posedge C_bar, `tKH);
	$width (negedge C_bar, `tKL);
endspecify

//-----------------------------------------------------------------------------

endmodule
