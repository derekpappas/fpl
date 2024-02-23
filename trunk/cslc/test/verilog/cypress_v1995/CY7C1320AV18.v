//*****************************************************************************
//*****************************************************************************
// This model is the property of Cypress Semiconductor Corp. and is protected**
// by the US copyright laws, any unauthorized copying and distribution is    **	
// prohibited. Cypress reserves the right to change any of the functional    **
// specifications without any prior notice.Cypress is not liable for any     **
// damages which may result from the use of this functional model.           **
//									     **
//  									     **	
// File name		:		CY7C1320AV18.v			     **
//									     **
// Date			:		Aug 16th, 2003			     **	
//									     ** 									 
// Model		:		CY7C1320AV18(512K x 36 Two word burst   **
//					with DDR-II Architecture)            **
//									     **
// Revision		:		Rev 1.0 : New	model created	     **
// 									     **
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
`define tCYC    3.6     //Average Clock cycle time
`define tKH     1.32    //Clock high time
`define tKL     1.32    //Clock low time
`define tCO     #0.29   //Data valid from positive clock edges
`define tDOH    0.29    //Data hold(negative) from positive clock edges
`define tCLZ    0.29    //Positive clock edges to Low-Z(negative)
`define tCHZ    #0.29   //Positive clock edge to High-Z
`define tCCQO   #0.27   //Positive clock edges to echo clocks valid
`define tCQOH   0.27    //Echo clocks hold(negative) from positive clock edges
`define tSA     0.40    //Address setup time to K rising edge
`define tSC     0.40    //Control signals(BWS_n, R_W_n, LD_n) setup time
`define tSD     0.30    //Data setup to K and K_n rising edge
`define tHA     0.40    //Address hold time after K rising edge
`define tHC     0.40    //Comtrol signals hold time
`define tHD     0.30    //Data holdtime after K and K_n rising edges
`define tSCddr	0.30	//Control signals(BWS_n, R_W_n, LD_n) setup time
`define tHCddr	0.30	//Comtrol signals hold time


/*
//Timings for 250 MHz

`define tCYC    4.5     //Average Clock cycle time
`define tKH     1.60    //Clock high time
`define tKL     1.60    //Clock low time
`define tCO     #0.35   //Data valid from positive clock edges
`define tDOH    0.35    //Data hold(negative) from positive clock edges
`define tCLZ    0.35    //Positive clock edges to Low-Z(negative)
`define tCHZ    #0.35   //Positive clock edge to High-Z
`define tCCQO   #0.33   //Positive clock edges to echo clocks valid
`define tCQOH   0.27    //Echo clocks hold(negative) from positive clock edges
`define tSA     0.50    //Address setup time to K rising edge
`define tSC     0.50    //Control signals(BWS_n, R_W_n, LD_n) setup time
`define tSD     0.40    //Data setup to K and K_n rising edge
`define tHA     0.50    //Address hold time after K rising edge
`define tHC     0.50    //Comtrol signals hold time
`define tHD     0.40    //Data holdtime after K and K_n rising edges
`define tSCddr	0.35	//Control signals(BWS_n, R_W_n, LD_n) setup time
`define tHCddr	0.35	//Comtrol signals hold time
*/


/*
//Timings for 200 MHz

`define tCYC    5.5     //Average Clock cycle time
`define tKH     2.0     //Clock high time
`define tKL     2.0     //Clock low time
`define tCO     #0.38   //Data valid from positive clock edges
`define tDOH    0.38    //Data hold(negative) from positive clock edges
`define tCLZ    0.38    //Positive clock edges to Low-Z(negative)
`define tCHZ    #0.38   //Positive clock edge to High-Z
`define tCCQO   #0.36   //Positive clock edges to echo clocks valid
`define tCQOH   0.36    //Echo clocks hold(negative) from positive clock edges
`define tSA     0.60    //Address setup time to K rising edge
`define tSC     0.60    //Control signals(BWS_n, R_W_n, LD_n) setup time
`define tSCddr     0.40    //Control signals(BWS_n, R_W_n, LD_n) setup time
`define tSD     0.50    //Data setup to K and K_n rising edge
`define tHA     0.60    //Address hold time after K rising edge
`define tHC     0.60    //Comtrol signals hold time
`define tHCddr     0.40    //Comtrol signals hold time
`define tHD     0.50    //Data holdtime after K and K_n rising edge
*/

/*
//Timings for 166 MHz

`define tCYC    6.75     //Average Clock cycle time
`define tKH     2.4     //Clock high time
`define tKL     2.4     //Clock low time
`define tCO     #0.4    //Data valid from positive clock edges
`define tDOH    0.4     //Data hold(negative) from positive clock edges
`define tCLZ    0.4     //Positive clock edges to Low-Z(negative)
`define tCHZ    #0.4    //Positive clock edge to High-Z
`define tCCQO   #0.38   //Positive clock edges to echo clocks valid
`define tCQOH   0.38    //Echo clocks hold(negative) from positive clock edges
`define tSA     0.70    //Address setup time to K rising edge
`define tSC     0.70    //Control signals(BWS_n, R_W_n, LD_n) setup time
`define tSCddr     0.50    //Control signals(BWS_n, R_W_n, LD_n) setup time
`define tSD     0.60    //Data setup to K and K_n rising edge
`define tHA     0.70    //Address hold time after K rising edge
`define tHC     0.70    //Comtrol signals hold time
`define tHCddr     0.50    //Comtrol signals hold time
`define tHD     0.60    //Data holdtime after K and K_n rising edges
*/


`define wordsize (36 -1) //Size of the data bus to be defined
`define no_words (524288 -1)		// 512K X36

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

module ddr2_burst2 (TCK,TMS,TDI,TDO,K, K_n, CQ, CQ_n, C, C_n, BWS3_n, BWS2_n, BWS1_n, BWS0_n , LD_n, R_W_n, A, DQ,ZQ,DOFF);

input 		TCK,TMS,TDI;
output		TDO;
input 		K, K_n, C, C_n;
input		LD_n, R_W_n;
input		BWS3_n;
input		BWS2_n;
input		BWS1_n;
input		BWS0_n;
input	[18:0]	A;
inout		CQ, CQ_n;
inout	[35:0]	DQ;
input 		ZQ;
input		DOFF;

wire	[3:0]	BWS_n;


reg	[35:0]	data_in1, data_in2, Data_out; 
reg	[8:0]	Mem_array_lb [21'h1fffff:0];
reg	[17:9]	Mem_array_ib1 [21'h1fffff:0];
reg	[26:18]	Mem_array_ib2 [21'h1fffff:0];
reg	[35:27]	Mem_array_ub [21'h1fffff:0];
reg	[18:0]	Address_reg; 
reg	[3:0]	BWS_n_reg_pos, BWS_n_reg_neg;
reg	[18:0]  Wr_Address_reg1, Wr_Address_reg2;
reg	[18:0]	Rd_Address_reg1, Rd_Address_reg2;
reg	[1:0] 	present_cycle, prev_cycle1, prev_cycle2;
reg		read_write;
reg		Rd_Clk, Rd_Clk_n;
reg		dll_Clk, dll_Clk_n;
real	 	tdll, techo, tk1, tk2, text_cyc;
reg		notifier;
reg 		setter_clk, echoclk,echoclkb,echo_on;
reg 		Set_CQ_Rise_Flag1, Set_CQ_n_Rise_Flag1, Set_CQ_Rise_Flag2, Set_CQ_n_Rise_Flag2, Set_CQ_Fall_Flag1, Set_CQ_n_Fall_Flag1, Set_CQ_Fall_Flag2, Set_CQ_n_Fall_Flag2, Modified_Setter, Setter, Single_Dual_Flag, Count_2_10_Flag;

integer  Count2, Count10, Count1000;


parameter DLL_SwitchingCycles = 1000;
parameter Wait_Cycles = (DLL_SwitchingCycles - 1);
parameter Sampling_Time = 10;

`define Read	2'b00
`define Write	2'b01
`define None	2'b10

assign BWS_n[3:0] = {BWS3_n, BWS2_n, BWS1_n, BWS0_n};



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

initial
begin

	  Count2                = -1;
          Count10               = 1;
          Count1000             = 0;
          Single_Dual_Flag      = 0;       ///  Single_Dual_Flag => This flag indicates when switching occurs
          Set_CQ_Rise_Flag1 = 0;
          Set_CQ_n_Rise_Flag1 = 0;
          Set_CQ_Rise_Flag2 = 0;
          Set_CQ_n_Rise_Flag2 = 0;
          Set_CQ_Fall_Flag1 = 0;
          Set_CQ_n_Fall_Flag1 = 0;
          Set_CQ_Fall_Flag2 = 0;
          Set_CQ_n_Fall_Flag1 = 0;
          Count_2_10_Flag = 0;            /// Count_2_10_Flag = 0  => Count2 is running; Count_2_10_Flag = 1 => Count10 is running;
end

wire [`wordsize:0]  chip_out =  read_write ?  Data_out : 36'bz ;	// data bus coming out from the SRAM
wire cq_out = echo_on ? echoclk : 1'bz;			// echo clock coming out from the SRAM
wire cqb_out = echo_on ? echoclkb : 1'bz;			// echo clock coming out from the SRAM

wire TDO =  !tdo_tristate ?  tdo : 1'bz;	// Output TDO pin

// When EXTEST-enable is 0, the data output should use the chip data, when 1, the EXTEST data.
wire [35:0]pre_out = !extest_en ? chip_out[35:0] : preload[35:0];
wire CQ =  !extest_en ? cq_out : preload[36];
wire CQ_n = !extest_en ? cqb_out : preload[37];

// oe is the output enable for the entire chip. Controlled by extest_oe during EXTEST. Active HIGH.
wire oe = (!extest_en ? read_write : extest_oe) && !samplz_en;

// Output buffer logic  
wire[35:0] DQ = !oe ? 36'bz : pre_out[35:0];

reg[2:0] ir_p, ir_s;	// Dual Instruction Registers (p=parallel-load, s=shift-load)
reg	 byp;		// Bypass Register
reg[31:0] dir;		// Device Identification Register -- parallel-loaded with Vendor_code during IDCODE instruction
reg[106:0] bsr;		// 107-bit boundary scan register.

// ****************************** End signal definitions 

initial
begin
        setter_clk = 0;
end

always @(K)
        `tdly setter_clk = K;


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
	end

always @(Modified_Setter or K or K_n or C or C_n)
        begin
                if (Modified_Setter == 1)
                     begin
                        Rd_Clk <= C;
                        Rd_Clk_n <= C_n;
                     end
                else
                     begin
                        Rd_Clk <= K;
                        Rd_Clk_n <= K_n;
                     end
        end


always @(posedge K)
begin
        if(Count2 < 2)
                begin
                        Count2 = Count2 +1;
                        Count_2_10_Flag = 0;
                end
end

always @(negedge K)
begin
        if(Count10 == Sampling_Time & Count2 == 2 & Single_Dual_Flag == 0 & Count_2_10_Flag == 1) Count2 = -1;
end
always @(posedge K)
begin
        if(Count1000 < Wait_Cycles & Count2 == 2 & Single_Dual_Flag == 1) Count1000 <= Count1000 +1;
       /// Count1000 running as toggling occured "Single_Dual_Flag == 1"

        else if(Count1000 == Wait_Cycles & Count2 == 2 & Single_Dual_Flag == 1) //// Count10 has to reset if Count1000 reaches its MAX value
                begin
                        Modified_Setter = Setter;
                        Count1000 <= 0;
                        Single_Dual_Flag = 0;
                        Count10 <= 0;
                end


        if(Count10 < Sampling_Time & Count2 == 2 & Single_Dual_Flag == 0)
                begin
                        Count10 <= Count10 +1;
                        Count_2_10_Flag = 1;
                end

        else if (Count10 == Sampling_Time & Count2 == 2 & Single_Dual_Flag == 0 & Count_2_10_Flag == 0) Count10 <= 1;    //// if "Count2" completes 2 cycles Count10 has to reset.

end

// The next process is to check if the clocks are in single clock mode or multi clock mode

always @(posedge K & Count2 < 2)
begin
        if (Count2 == 0)
        begin
                if (C == 1)
                        Set_CQ_Rise_Flag1 = 1;
                else
                        Set_CQ_Rise_Flag1 = 0;

                if (C_n == 0)
                        Set_CQ_n_Rise_Flag1 = 1;
                else
                        Set_CQ_n_Rise_Flag1 = 0;
        end

        if(Count2 == 1)
        begin
                if (C == 1)
                        Set_CQ_Rise_Flag2 = 1;
                else
                        Set_CQ_Rise_Flag2 = 0;

                if (C_n == 0)
                        Set_CQ_n_Rise_Flag2 = 1;
                else
                        Set_CQ_n_Rise_Flag2 = 0;
        end
end


// This process is to check if the clocks are in single clock mode or multi clock mode

always @(negedge K & Count2 < 2)
begin
        if (Count2 == 0)
        begin
                if (C == 1)
                        Set_CQ_Fall_Flag1 = 1;
                else
                        Set_CQ_Fall_Flag1 = 0;

                if (C_n == 0)
                        Set_CQ_n_Fall_Flag1 = 1;
                else
                        Set_CQ_n_Fall_Flag1 = 0;
        end

        if(Count2 == 1)
        begin
                if (C == 1)
                        Set_CQ_Fall_Flag2 = 1;
                else
                        Set_CQ_Fall_Flag2 = 0;

                if (C_n == 0)
                        Set_CQ_n_Fall_Flag2 = 1;
                else
                        Set_CQ_n_Fall_Flag2 = 0;
        end

end

always @(negedge setter_clk)
begin

if ((Set_CQ_Rise_Flag1 == 1) & (Set_CQ_Rise_Flag2 == 1) & (Set_CQ_Fall_Flag1 == 0) & (Set_CQ_Fall_Flag2 == 0)  & Count2 == 1)
        begin
                if (Setter == 0)
                        begin
                                Setter = 1;
                                Single_Dual_Flag = 1;
                        end
                else if (Setter == 1 || Setter === 1'bx)
                        begin
                                Setter = 1;
                                Modified_Setter = 1;
                                Single_Dual_Flag = 0;
                        end
        end

else if ((Set_CQ_Rise_Flag1 == 0) & (Set_CQ_Rise_Flag2 == 0) & (Set_CQ_Fall_Flag1 == 1) & (Set_CQ_Fall_Flag2 == 1) & Count2 == 1)
        begin
                if (Setter == 0)
                        begin
                                Setter = 1;
                                Single_Dual_Flag = 1;
                        end
                else if (Setter == 1 || Setter === 1'bx)
                        begin
                                Setter = 1;
                                Modified_Setter = 1;
                                Single_Dual_Flag = 0;
                        end
        end

else if ((Set_CQ_Rise_Flag1 == 0) & (Set_CQ_n_Rise_Flag1 == 1) & (Set_CQ_Fall_Flag1 == 0) & (Set_CQ_n_Fall_Flag1 == 1) & (Set_CQ_Rise_Flag2 == 1) & (Set_CQ_n_Rise_Flag2 == 1) & (Set_CQ_Fall_Flag2 == 0) & (Set_CQ_n_Fall_Flag2 == 0) & Count2 == 1)  /// This condition and the next one satisfy if the toggling starts just after a half cycle of the first sampling cycle.
        begin
                if (Setter == 0)
                        begin
                                Setter = 1;
                                Single_Dual_Flag = 1;
                        end
                else if (Setter == 1 || Setter === 1'bx)
                        begin
                                Setter = 1;
                                Modified_Setter = 1;
                                Single_Dual_Flag = 0;
                        end
        end

else if ((Set_CQ_Rise_Flag1 == 1) & (Set_CQ_n_Rise_Flag1 == 0) & (Set_CQ_Fall_Flag1 == 1) & (Set_CQ_n_Fall_Flag1 == 0) & (Set_CQ_Rise_Flag2 == 0) & (Set_CQ_n_Rise_Flag2 == 0) & (Set_CQ_Fall_Flag2 == 1) & (Set_CQ_n_Fall_Flag2 == 1) & Count2 == 1)
        begin
                if (Setter == 0)
                        begin
                                Setter = 1;
                                Single_Dual_Flag = 1;
                        end
                else if (Setter == 1 || Setter === 1'bx)
                        begin
                                Setter = 1;
                                Modified_Setter = 1;
                                Single_Dual_Flag = 0;
                        end
        end


else if (Count2 == 1)
        begin
                if (Setter == 1)
                        begin
                                Setter = 0;
                                Single_Dual_Flag = 1;
                        end
                else if (Setter == 0 || Setter === 1'bx)
                        begin
                                Setter = 0;
                                Modified_Setter = 0;
                                Single_Dual_Flag = 0;
                        end
        end

end


//----------------dll clock generation------------------------------------------
//Generate dll clocks which are an offset of C and C_n and which are used to
//turn on and turn off the bus before the rising edges of C and C_n

/*initial
      begin
	tdll = text_cyc - `tCLZ;
      end
*/

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
		Address_reg 	 <= A;
	if (present_cycle == `Write)
		Wr_Address_reg1 <= Address_reg;
	if (prev_cycle1 == `Write)
		Wr_Address_reg2[18:1] <= Wr_Address_reg1[18:1];
	if (present_cycle == `Read)
		Rd_Address_reg1 <= Address_reg;
	if (prev_cycle1 == `Read)
		Rd_Address_reg2[18:1] <= Rd_Address_reg1[18:1];
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

always @(posedge K)
	begin
		if (present_cycle == `Read && !LD_n && !R_W_n)
			$display ("Illegal operation. A NOP should be provided between a read and the subsequent write");
	end


//---------------Write data and Byte writes latching----------------------------
always @(posedge K)
	begin
		if (present_cycle == `Write) 
		    begin
			data_in1 	<= DQ;
			BWS_n_reg_pos	<= BWS_n;
	            end
	end

always @(posedge K_n)
	begin
		if (prev_cycle1 == `Write) 
		    begin
			data_in2 	<= DQ;
			BWS_n_reg_neg	<= BWS_n;
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
			if (!BWS_n_reg_pos[0])
				Mem_array_lb[Wr_Address_reg1] <= data_in1[8:0];
			if (!BWS_n_reg_pos[1])
				Mem_array_ib1[Wr_Address_reg1] <= data_in1[17:9];
			if (!BWS_n_reg_pos[2])
				Mem_array_ib2[Wr_Address_reg1] <= data_in1[26:18];
			if (!BWS_n_reg_pos[3])
				Mem_array_ub[Wr_Address_reg1] <= data_in1[35:27];
		     end
	end	

always @(posedge K_n)
	begin
		if (prev_cycle2 == `Write)
		     begin
			if (!BWS_n_reg_neg[0])
				Mem_array_lb[Wr_Address_reg2] <= data_in2[8:0];
			if (!BWS_n_reg_neg[1])
				Mem_array_ib1[Wr_Address_reg2] <= data_in2[17:9];
			if (!BWS_n_reg_neg[2])
				Mem_array_ib2[Wr_Address_reg2] <= data_in2[26:18];
			if (!BWS_n_reg_neg[3])
				Mem_array_ub[Wr_Address_reg2] <= data_in2[35:27];
		     end
	end

//-----------------Reading from the memory array-------------------------------
always @(posedge Rd_Clk_n)
	begin
		if (prev_cycle1 == `Read)
		    begin	
			Data_out[35:0] = 36'hzz;
			fork
			Data_out[8:0] <= `tCO Mem_array_lb[Rd_Address_reg1];
			Data_out[17:9] <= `tCO Mem_array_ib1[Rd_Address_reg1];
			Data_out[26:18] <= `tCO Mem_array_ib2[Rd_Address_reg1];
			Data_out[35:27] <= `tCO Mem_array_ub[Rd_Address_reg1];
			join
		    end	
	end  

always @(posedge Rd_Clk)
	begin
		if (prev_cycle2 == `Read)
		    begin
			Data_out[35:0] = 36'hzz;
			fork	
			Data_out[8:0] <= `tCO Mem_array_lb[Rd_Address_reg2];
			Data_out[17:9] <= `tCO Mem_array_ib1[Rd_Address_reg2];
			Data_out[26:18] <= `tCO Mem_array_ib2[Rd_Address_reg2];
			Data_out[35:27] <= `tCO Mem_array_ub[Rd_Address_reg2];
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
		echoclk <= `tCCQO 1;
		#techo echoclkb <= 0;
		join
	end

always @(posedge Rd_Clk_n)
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
	vendor_code = 32'b00011010100010100101000001101001;	// IDCODE for DDR2 CY7C1320AV18 device. This may not be changed.
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
                                                preload[1] = bsr[18];
                                                preload[2] = bsr[17];
                                                preload[3] = bsr[21];
                                                preload[4] = bsr[26];
                                                preload[5] = bsr[30];
                                                preload[6] = bsr[34];
                                                preload[7] = bsr[43];
                                                preload[8] = bsr[42];
                                                preload[9] = bsr[10];
                                                preload[10] = bsr[14];
                                                preload[11] = bsr[13];
                                                preload[12] = bsr[22];
                                                preload[13] = bsr[25];
                                                preload[14] = bsr[31];
                                                preload[15] = bsr[35];
                                                preload[16] = bsr[39];
                                                preload[17] = bsr[38];
                                                preload[18] = bsr[66];
                                                preload[19] = bsr[69];
                                                preload[20] = bsr[73];
                                                preload[21] = bsr[78];
                                                preload[22] = bsr[81];
                                                preload[23] = bsr[85];
                                                preload[24] = bsr[90];
                                                preload[25] = bsr[93];
                                                preload[26] = bsr[97];
                                                preload[27] = bsr[65];
                                                preload[28] = bsr[70];
                                                preload[29] = bsr[74];
                                                preload[30] = bsr[77];
                                                preload[31] = bsr[82];
                                                preload[32] = bsr[86];
                                                preload[33] = bsr[89];
                                                preload[34] = bsr[94];
                                                preload[35] = bsr[98];
                                                preload[36] = bsr[46];          //CQ
                                                preload[37] = bsr[64];          //CQ_n
                                                extest_oe = bsr[47];            //Extest Output enable;


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
                                                bsr[2] = A[1];
                                                bsr[3] = A[2];
                                                bsr[4] = A[3];
                                                bsr[5] = A[4];
                                                bsr[6] = A[5];
                                                bsr[7] = A[6];
                                                bsr[8] = A[7];
                                                bsr[9] = DQ[0];
                                                bsr[10] = DQ[9];
                                                bsr[11] = 1'b0;
                                                bsr[12] = 1'b0;
                                                bsr[13] = DQ[11];
                                                bsr[14] = DQ[10];
                                                bsr[15] = 1'b0;
                                                bsr[16] = 1'b0;
                                                bsr[17] = DQ[2];
                                                bsr[18] = DQ[1];
                                                bsr[19] = 1'b0;
                                                bsr[20] = 1'b0;
                                                bsr[21] = DQ[3];
                                                bsr[22] = DQ[12];
                                                bsr[23] = 1'b0;
                                                bsr[24] = 1'b0;
                                                bsr[25] = DQ[13];
                                                bsr[26] = DQ[4];
                                                bsr[27] = ZQ;
                                                bsr[28] = 1'b0;
                                                bsr[29] = 1'b0;
                                                bsr[30] = DQ[5];
                                                bsr[31] = DQ[14];
                                                bsr[32] = 1'b0;
                                                bsr[33] = 1'b0;
                                                bsr[34] = DQ[6];
                                                bsr[35] = DQ[15];
                                                bsr[36] = 1'b0;
                                                bsr[37] = 1'b0;
                                                bsr[38] = DQ[17];
                                                bsr[39] = DQ[16];
                                                bsr[40] = 1'b0;
                                                bsr[41] = 1'b0;
                                                bsr[42] = DQ[8];
                                                bsr[43] = DQ[7];
                                                bsr[44] = 1'b0;
                                                bsr[45] = 1'b0;
                                                bsr[46] = CQ;
                                                bsr[47] = extest_oe;
                                                bsr[48] = A[8];
                                                bsr[49] = A[9];
                                                bsr[50] = A[10];
                                                bsr[51] = A[0];
                                                bsr[52] = LD_n;
                                                bsr[53] = BWS_n[1];
                                                bsr[54] = BWS_n[0];
                                                bsr[55] = K;
                                                bsr[56] = K_n;
                                                bsr[57] = BWS_n[3];
                                                bsr[58] = BWS_n[2];
                                                bsr[59] = R_W_n;
                                                bsr[60] = A[11];
                                                bsr[61] = A[12];
                                                bsr[62] = 1'b0;
                                                bsr[63] = DOFF;
                                                bsr[64] = CQ_n;
                                                bsr[65] = DQ[27];
                                                bsr[66] = DQ[18];
                                                bsr[67] = 1'b0;
                                                bsr[68] = 1'b0;
                                                bsr[69] = DQ[19];
                                                bsr[70] = DQ[28];
                                                bsr[71] = 1'b0;
                                                bsr[72] = 1'b0;
                                                bsr[73] = DQ[20];
                                                bsr[74] = DQ[29];
                                                bsr[75] = 1'b0;
                                                bsr[76] = 1'b0;
                                                bsr[77] = DQ[30];
                                                bsr[78] = DQ[21];
                                                bsr[79] = 1'b0;
                                                bsr[80] = 1'b0;
                                                bsr[81] = DQ[22];
                                                bsr[82] = DQ[31];
                                                bsr[83] = 1'b0;
                                                bsr[84] = 1'b0;
                                                bsr[85] = DQ[23];
                                                bsr[86] = DQ[32];
                                                bsr[87] = 1'b0;
                                                bsr[88] = 1'b0;
                                                bsr[89] = DQ[33];
                                                bsr[90] = DQ[24];
                                                bsr[91] = 1'b0;
                                                bsr[92] = 1'b0;
                                                bsr[93] = DQ[25];
                                                bsr[94] = DQ[34];
                                                bsr[95] = 1'b0;
                                                bsr[96] = 1'b0;
                                                bsr[97] = DQ[26];
                                                bsr[98] = DQ[35];
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
	$setuphold(posedge K &&& ~LD_n, A, `tSA, `tHA, notifier);           //Address
	$setuphold(posedge K &&& ~LD_n, LD_n, `tSC, `tHC, notifier);      //LD_n
	$setuphold(posedge K &&& ~LD_n, R_W_n, `tSC, `tHC, notifier);      //R_W_n	
	$setuphold(posedge K &&& DQ1_setup, DQ, `tSD, `tHD, notifier);	      //DQ1	
	$setuphold(posedge K_n &&& DQ2_setup, DQ, `tSD, `tHD, notifier);    //DQ2	
	$setuphold(posedge K &&& DQ1_setup, BWS_n, `tSCddr, `tHCddr, notifier);	      //BWS_n1	
	$setuphold(posedge K_n &&& DQ2_setup, BWS_n, `tSCddr, `tHCddr, notifier);    //BWS_n2	
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
