//*****************************************************************************
//*****************************************************************************
// This model is the property of Cypress Semiconductor Corp. and is protected**
// by the US copyright laws, any unauthorized copying and distribution is    **	
// prohibited. Cypress reserves the right to change any of the functional    **
// specifications without any prior notice.Cypress is not liable for any     **
// damages which may result from the use of this functional model.           **
//									     **
//  									     **	
// File name		:		CY7C1394V18.v			     **
//									     **
// Date			:		March 20th , 2003		     **	
//									     ** 									//									     **
// Model		:		CY7C1394V18(512K x 36 Two word burst **
//					with DDR-II SIO Architecture)        **
//									     **
// Revision		:		New				     **
//					1.1 Added JTAG functionality         **
//									     **
// Queries		:		MPD Applications		     **
//					Ph#: (408)-943-2821		     **
//					e-mail: support@cypress.com	     **
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
`define tSC	0.40	//Control signals(LD/ , R/W) setup time
`define tSCDDR  0.30    //Double Data Rate Control signals(BWS_nS0,BWS_nS1,BWS_nS2,BWS_nS3)
`define tSD	0.30	//Data setup to K and K_n rising edge
`define tHA	0.40	//Address hold time after K rising edge
`define tHCDDR  0.30    //Double Data Rate Control signals(BWS_nS0,BWS_nS1,BWS_nS2,BWS_nS3)
`define tHC	0.40	//Control signals(RPS/WPS) hold time
`define tHD	0.30	//Data holdtime after K and K_n rising edges         

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
`define tSC	0.50	//Control signals(LD/ , R/W) setup time
`define tSCDDR  0.35    //Double Data Rate Control signals(BWS_nS0,BWS_nS1,BWS_nS2,BWS_nS3)
`define tSD	0.35	//Data setup to K and K_n rising edge
`define tHA	0.50	//Address hold time after K rising edge
`define tHCDDR  0.35    //Double Data Rate Control signals(BWS_nS0,BWS_nS1,BWS_nS2,BWS_nS3)
`define tHC	0.50	//Control signals(RPS/WPS) hold time
`define tHD	0.35	//Data holdtime after K and K_n rising edges      


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
`define tSC	0.60	//Control signals(LD/ , R/W) setup time
`define tSCDDR  0.40    //Double Data Rate Control signals(BWS_nS0,BWS_nS1,BWS_nS2,BWS_nS3)
`define tSD	0.40	//Data setup to K and K_n rising edge
`define tHA	0.60	//Address hold time after K rising edge
`define tHCDDR  0.40    //Double Data Rate Control signals(BWS_nS0,BWS_nS1,BWS_nS2,BWS_nS3)
`define tHC	0.60	//Control signals(RPS/WPS) hold time
`define tHD	0.40	//Data holdtime after K and K_n rising edges      

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
`define tSC	0.70	//Control signals(LD/ , R/W) setup time
`define tSCDDR  0.40    //Double Data Rate Control signals(BWS_nS0,BWS_nS1,BWS_nS2,BWS_nS3)
`define tSD	0.40	//Data setup to K and K_n rising edge
`define tHA	0.70	//Address hold time after K rising edge
`define tHCDDR  0.70    //Double Data Rate Control signals(BWS_nS0,BWS_nS1,BWS_nS2,BWS_nS3)
`define tHC	0.40	//Control signals(RPS/WPS) hold time
`define tHD	0.40	//Data holdtime after K and K_n rising edges      
 
*/     

`define wordsize (36 -1) // size of the data bus to be defined
`define mem_size (262144 -1) // 2 arrays of 256K x36 RAM
`define bus_size 36
`define address_bus (18 - 1)
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
`define tTMSs	10		// TMS set-up to TCK clock rise (min)
`define tTDIs	10		// TDI set-up to TCK clock rise (min)
`define tcs	10			// Capture set-up to TCK clock rise (min)
`define tTMSh	10		// TMS hold after TCK clock rise (min)
`define tTDIh	10		// TDI hold after TCK clock rise (min)
`define tch	10			// Capture hold after TCK clock rise (min)
`define ttdov	#20		// TCK clock LOW to TDO valid (max)
`define ttdox	0		// TCK clock LOW to TDO invalid (min)

`define tdly	#0.01

module ddr2_sio_burst2 (TCK, TMS, TDI, TDO, K, K_n, CQ, CQ_n, C, C_n, BWS_n, LD_n, R_W_n, A, D, Q,ZQ,DOFF);

input 			TCK, TMS, TDI;
output			TDO;
input 	K, K_n, C, C_n;
input	LD_n, R_W_n;
input    ZQ,DOFF;	
input	[3:0]	BWS_n;
input	[`address_bus:0]	A;
output	CQ, CQ_n;
input	[`wordsize:0]	D;
output  [`wordsize:0]  Q;

reg	[`wordsize:0]	data_in1, data_in2, Data_out; 
reg     [`wordsize:0] 	temp_reg,temp_reg2;
reg	[`wordsize:0]	Mem_array1 [0:`mem_size];   //First Array
reg	[`wordsize:0]	Mem_array2 [0:`mem_size];   //Second Array
reg	[`address_bus:0]	Address_reg; 
reg	[3:0]	BWS_n_reg_pos, BWS_n_reg_neg;
reg	[`address_bus:0]  Wr_Address_reg1, Wr_Address_reg2;
reg	[`address_bus:0]	Rd_Address_reg1, Rd_Address_reg2;
reg	[1:0] 	present_cycle, prev_cycle1, prev_cycle2;
reg	read_write;
reg	Rd_Clk, Rd_Clk_n;
reg	Sel1, Sel2;
reg	dll_Clk, dll_Clk_n;
real    tdll, techo, tk1, tk2, text_cyc;
reg	notifier;
reg 	echo_clk,echo_clkb;
reg     echo_on;

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

wire [`wordsize:0]  chip_out = read_write ?  Data_out : 36'bz ;	// data bus coming out from the SRAM
wire cq_out = echo_on ? echo_clk : 1'bz;			// echo clock coming out from the SRAM
wire cqb_out = echo_on ? echo_clkb : 1'bz;			// echo clock coming out from the SRAM

wire TDO =  !tdo_tristate ?  tdo : 1'bz;	// Output TDO pin

// When EXTEST-enable is 0, the data output should use the chip data, when 1, the EXTEST data.
wire [35:0]pre_out = !extest_en ? chip_out[35:0] : preload[35:0];
wire CQ =  !extest_en ? cq_out : preload[36];
wire CQ_n = !extest_en ? cqb_out : preload[37];

// oe is the output enable for the entire chip. Controlled by extest_oe during EXTEST. Active HIGH.
wire oe = (!extest_en ? read_write : extest_oe) && !samplz_en;

// Output buffer logic  
wire[35:0] Q = !oe ? 36'bz : pre_out[35:0];

reg[2:0] ir_p, ir_s;	// Dual Instruction Registers (p=parallel-load, s=shift-load)
reg	 byp;		// Bypass Register
reg[31:0] dir;		// Device Identification Register -- parallel-loaded with Vendor_code during IDCODE instruction
reg[106:0] bsr;		// 107-bit boundary scan register.

// ****************************** End signal definitions *************************************************
initial
        begin
		echo_on = 1;
	end

//---------------Single clock mode----------------------------------------------
always @(posedge K)
	begin 
		tk2 = tk1;
		tk1 = $realtime;
    		text_cyc = tk1 - tk2;
		tdll = text_cyc - `tCLZ;
		techo = text_cyc - `tCQOH;
		if (C == 1'b1 && C_n == 1'b1) 
			Sel1 <= 1'b1;
		else
			Sel1 <= 1'b0;
	end

always @(negedge K)
	begin
		if (C == 1'b1 && C_n == 1'b1) 
			Sel2 <= 1'b1;
		else
			Sel2 <= 1'b0;
	end

always @(Sel1 or Sel2 or K or K_n or C or C_n)
	begin
		if (Sel1 == 1 && Sel2 == 1)
		     begin
			Rd_Clk <= K;
			Rd_Clk_n <= K_n;
		     end
		else
		     begin
			Rd_Clk <= C;
			Rd_Clk_n <= C_n;
		     end
	end
//----------------dll clock generation------------------------------------------
//Generate dll clocks which are an offset of C and C_n and which are used to
//turn on and turn off the bus before the rising edges of C and C_n

always @(posedge Rd_Clk)
      begin
	tdll = text_cyc - `tCLZ;
      end

always @(posedge Rd_Clk)
	begin
		#tdll dll_Clk <= 1;
	end

always @(negedge Rd_Clk)
	begin
		#tdll dll_Clk <= 0;
	end

always @(posedge Rd_Clk_n)
	begin
		#tdll dll_Clk_n <= 1;
	end

always @(negedge Rd_Clk_n)
	begin
		#tdll dll_Clk_n <= 0;
	end

//---------------Address latching-----------------------------------------------
always @(posedge K)
       begin	
	if (!LD_n)
		Address_reg[`address_bus:0] 	 <= A;
	if (present_cycle == `Write)
		Wr_Address_reg1 <= Address_reg;
	if (prev_cycle1 == `Write)
		Wr_Address_reg2[`address_bus:0] <= Wr_Address_reg1[`address_bus:0];
	if (present_cycle == `Read)
		Rd_Address_reg1 <= Address_reg;
	if (prev_cycle1 == `Read)
		Rd_Address_reg2[`address_bus:0] <= Rd_Address_reg1[`address_bus:0];
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
		if (!LD_n)
		      begin
			if (!R_W_n) 
				present_cycle <= `Write;
			else	
				present_cycle <= `Read;
		      end
		else
			present_cycle <= `None;	
	end        

//---------------Write data and Byte writes latching----------------------------
always @(posedge K)
	begin
		if (present_cycle == `Write) 
		    begin
			data_in1 	<= D;
			BWS_n_reg_pos	<= BWS_n;
	            end
	end

always @(posedge K_n)
	begin
		if (prev_cycle1 == `Write) 
		    begin
			data_in2 	<= D;
			BWS_n_reg_neg	<= BWS_n;
		    end
	end
//----------------Writing into the memory array--------------------------------
always @(posedge K)
	begin
		if (prev_cycle1 == `Write)
		     begin
			if (!BWS_n_reg_pos[0])
			   begin
				temp_reg = Mem_array1[Wr_Address_reg1];
				temp_reg[8:0] = data_in1[8:0];
				Mem_array1[Wr_Address_reg1] =temp_reg;
			   end	
			if (!BWS_n_reg_pos[1])
                            begin
				temp_reg = Mem_array1[Wr_Address_reg1];
				temp_reg[17:9] = data_in1[17:9];
				Mem_array1[Wr_Address_reg1] =temp_reg;
   			    end
			if (!BWS_n_reg_pos[2])
                            begin
				temp_reg = Mem_array1[Wr_Address_reg1];
				temp_reg[26:18] = data_in1[26:18];
				Mem_array1[Wr_Address_reg1] =temp_reg;
    			    end
			if (!BWS_n_reg_pos[3])
 			    begin
				temp_reg = Mem_array1[Wr_Address_reg1];
				temp_reg[35:27] = data_in1[35:27];
				Mem_array1[Wr_Address_reg1] =temp_reg;
			    end
		      end
	end	

always @(posedge K_n)
	begin
		if (prev_cycle2 == `Write)
		     begin
			if (!BWS_n_reg_neg[0])
			   begin
				temp_reg = Mem_array2[Wr_Address_reg2];
				temp_reg[8:0] = data_in2[8:0];
				Mem_array2[Wr_Address_reg2] =temp_reg;
			   end
			if (!BWS_n_reg_neg[1])
    			   begin
				temp_reg = Mem_array2[Wr_Address_reg2];
				temp_reg[17:9] = data_in2[17:9];
				Mem_array2[Wr_Address_reg2] =temp_reg;
 			   end
			if (!BWS_n_reg_neg[2])
			   begin
				temp_reg = Mem_array2[Wr_Address_reg2];
				temp_reg[26:18] = data_in2[26:18];
				Mem_array2[Wr_Address_reg2] =temp_reg;
  			   end
			if (!BWS_n_reg_neg[3])
			   begin
				temp_reg = Mem_array2[Wr_Address_reg2];
				temp_reg[35:27] = data_in2[35:27];
				Mem_array2[Wr_Address_reg2] =temp_reg;
			   end
		     end
	end

//-----------------Reading from the memory array-------------------------------
always @(posedge Rd_Clk_n)
	begin
		if (prev_cycle1 == `Read)
		    begin	
			Data_out[35:0] = 36'hzz ;
			fork
			Data_out[35:0] <= `tCO Mem_array1[Rd_Address_reg1];
			join
		    end	
	end  

always @(posedge Rd_Clk)
	begin
		if (prev_cycle2 == `Read)
		    begin
			Data_out[17:0] = 36'hzz;
			fork	
			Data_out[35:0] <= `tCO Mem_array2[Rd_Address_reg2];
			join
		    end	
	end 

//------------------Read data enable------------------------------------------
always @(posedge dll_Clk_n)
	begin
		if (prev_cycle1 == `Read)
			read_write <= 1;
	end

always @(posedge Rd_Clk_n)
	begin
		if (prev_cycle1 != `Read && prev_cycle2 == `Read)
			read_write <= `tCHZ 0;
	end

//------------------Implementation of negative hold times--------------------
always @(posedge dll_Clk_n)
	begin
		if (prev_cycle1 == `Read || prev_cycle2 == `Read)
			Data_out <= 36'bz;
	end

always @(posedge dll_Clk)
	begin
		if (prev_cycle1 == `Read || prev_cycle2 == `Read)
			Data_out <= 36'bz;
	end

//------------------Generation of Echo clocks--------------------------------
always @(posedge Rd_Clk)
	begin   
		fork
		echo_clk <= `tCCQO 1;
		#techo echo_clkb <= 0;
		join
	end

always @(posedge Rd_Clk_n)
	begin
		fork
		echo_clkb <= `tCCQO 1;
		#techo echo_clk <= 0;
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
	vendor_code = 32'b00011010100100100101000001101001;	// IDCODE for QDR2 CY7C1394V18 device. This may not be changed.
	tdo_tristate = 1;
	extest_en = 0;
	samplz_en = 0;
	extest_oe = 0;
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
						preload[9] = bsr[12];
						preload[10] = bsr[16];
						preload[11] = bsr[20];
						preload[12] = bsr[24];
						preload[13] = bsr[29];
						preload[14] = bsr[33];
						preload[15] = bsr[37];
						preload[16] = bsr[41];
						preload[17] = bsr[45];
						preload[18] = bsr[65];
						preload[19] = bsr[69];
						preload[20] = bsr[73];
						preload[21] = bsr[77];
						preload[22] = bsr[81];
						preload[23] = bsr[85];
						preload[24] = bsr[89];
						preload[25] = bsr[93];
						preload[26] = bsr[97];
						preload[27] = bsr[68];
						preload[28] = bsr[72];
						preload[29] = bsr[76];
						preload[30] = bsr[80];
						preload[31] = bsr[84];
						preload[32] = bsr[88];
						preload[33] = bsr[92];
						preload[34] = bsr[96];
						preload[35] = bsr[100];
						preload[36] = bsr[46];		//CQ
						preload[37] = bsr[64];		//CQ_n
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
						bsr[0] = C_n;
						bsr[1] = C;
						bsr[2] = A[0];
						bsr[3] = A[1];
						bsr[4] = A[2];
						bsr[5] = A[3];
						bsr[6] = A[4];
						bsr[7] = A[5];
						bsr[8] = A[6];
						bsr[9] = Q[0];
						bsr[10] = D[0];
						bsr[11] = D[9];
						bsr[12] = Q[9];
						bsr[13] = Q[1];
						bsr[14] = D[1];
						bsr[15] = D[10];
						bsr[16] = Q[10];
						bsr[17] = Q[2];
						bsr[18] = D[2];
						bsr[19] = D[11];
						bsr[20] = Q[11];
						bsr[21] = Q[3];
						bsr[22] = D[3];
						bsr[23] = D[12];
						bsr[24] = Q[12];
						bsr[25] = Q[4];
						bsr[26] = D[4];
						bsr[27] = ZQ;
						bsr[28] = D[13];
						bsr[29] = Q[13];
						bsr[30] = Q[5];
						bsr[31] = D[5];
						bsr[32] = D[14];
						bsr[33] = Q[14];
						bsr[34] = Q[6];
						bsr[35] = D[6];
						bsr[36] = D[15];
						bsr[37] = Q[15];
						bsr[38] = Q[7];
						bsr[39] = D[7];
						bsr[40] = D[16];
						bsr[41] = Q[16];
						bsr[42] = Q[8];
						bsr[43] = D[8];
						bsr[44] = D[17];
						bsr[45] = Q[17];
						bsr[46] = CQ;
						bsr[47] = extest_oe;
						bsr[48] = 1'b0;
						bsr[49] = A[7];
						bsr[50] = A[8];
						bsr[51] = A[9];
						bsr[52] = LD_n;
						bsr[53] = BWS_n[1];
						bsr[54] = BWS_n[0];
						bsr[55] = K;
						bsr[56] = K_n;
						bsr[57] = BWS_n[3];
						bsr[58] = BWS_n[2];
						bsr[59] = R_W_n;
						bsr[60] = A[10];
						bsr[61] = A[11];
						bsr[62] = 1'b0;
						bsr[63] = DOFF;
						bsr[64] = CQ_n;
						bsr[65] = Q[18];
						bsr[66] = D[18];
						bsr[67] = D[27];
						bsr[68] = Q[27];
						bsr[69] = Q[19];
						bsr[70] = D[19];
						bsr[71] = D[28];
						bsr[72] = Q[28];
						bsr[73] = Q[20];
						bsr[74] = D[20];
						bsr[75] = D[29];
						bsr[76] = Q[29];
						bsr[77] = Q[21];
						bsr[78] = D[21];
						bsr[79] = D[30];
						bsr[80] = Q[30];
						bsr[81] = Q[22];
						bsr[82] = D[22];
						bsr[83] = D[31];
						bsr[84] = Q[31];
						bsr[85] = Q[23];
						bsr[86] = D[23];
						bsr[87] = D[32];
						bsr[88] = Q[32];
						bsr[89] = Q[24];
						bsr[90] = D[24];
						bsr[91] = D[33];
						bsr[92] = Q[33];
						bsr[93] = Q[25];
						bsr[94] = D[25];
						bsr[95] = D[34];
						bsr[96] = Q[34];
						bsr[97] = Q[26];
						bsr[98] = D[26];
						bsr[99] = D[35];
						bsr[100] = Q[35];
						bsr[101] = A[12];
						bsr[102] = A[13];
						bsr[103] = A[14];
						bsr[104] = A[15];
						bsr[105] = A[16];
						bsr[106] = A[17];
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
wire  D1_setup = (present_cycle == `Write);
wire  D2_setup = (prev_cycle1 == `Write);


specify
	$setuphold(posedge K &&& ~LD_n, A, `tSA, `tHA, notifier);           //Address
	$setuphold(posedge K &&& ~LD_n, LD_n, `tSC, `tHC, notifier);      //LD_n
	$setuphold(posedge K &&& ~LD_n, R_W_n, `tSC, `tHC, notifier);      //R_W_n	
	$setuphold(posedge K &&& D1_setup, D, `tSD, `tHD, notifier);	      //DQ1	
	$setuphold(posedge K_n &&& D2_setup, D, `tSD, `tHD, notifier);    //DQ2	
	$setuphold(posedge K &&& D1_setup, BWS_n, `tSC, `tHC, notifier);	      //BWS_n1	
	$setuphold(posedge K_n &&& D2_setup, BWS_n, `tSC, `tHC, notifier);    //BWS_n2	
	$width (posedge K, `tKH);
	$width (negedge K, `tKL);
	$width (posedge K_n, `tKH);
	$width (negedge K_n, `tKL);
	$width (posedge C, `tKH);
	$width (negedge C, `tKL);
	$width (posedge C_n, `tKH);
	$width (negedge C_n, `tKL);
endspecify

//-----------------------------------------------------------------------------

endmodule

