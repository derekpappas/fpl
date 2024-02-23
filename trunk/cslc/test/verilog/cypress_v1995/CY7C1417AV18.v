//*****************************************************************************
//*****************************************************************************
// This model is the property of Cypress Semiconductor Corp. and is protected**
// by the US copyright laws, any unauthorized copying and distribution is    **	
// prohibited. Cypress reserves the right to change any of the functional    **
// specifications without any prior notice.Cypress is not liable for any     **
// damages which may result from the use of this functional model.           **
//									     **
//  									     **	
// File name	:		CY7C1417AV18.v			     **
//									     **
// Date		:		Sept 29, 2004		     		**	
//									     ** 									   
// Model		:		CY7C1417AV18(4M x 8 Four word burst  **
//					with DDR-II Architecture)            **
//									     **
// Revision		:		New				     **
//									     **
// Queries		:		MPD Applications		     **
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

//Timings for 333 MHz 

`define tCYC	3.3     //Average Clock cycle time
`define tKH	1.2	//Clock high time
`define tKL	1.2	//Clock low time
`define tCO	#0.45	//Data valid from positive clock edges
`define tDOH	0.45	//Data hold(negative) from positive clock edges
`define tCLZ	0.45	//Positive clock edges to Low-Z(negative)
`define tCHZ	#0.45	//Positive clock edge to High-Z
`define tCCQO   #0.45	//Positive clock edges to echo clocks valid
`define tCQOH	0.45	//Echo clocks hold(negative) from positive clock edges
`define tSA	0.40	//Address setup time to K rising edge
`define tSC	0.40	//Control signals(BWS, WE_bar, LD_bar) setup time
`define tSD	0.28	//Data setup to K and K_bar rising edge
`define tHA	0.40	//Address hold time after K rising edge
`define tHC	0.40	//Comtrol signals hold time
`define tHD	0.28	//Data holdtime after K and K_bar rising edges   

/*
//Timings for 300 MHz 

`define tCYC	3.3     //Average Clock cycle time
`define tKH	1.32	//Clock high time
`define tKL	1.32	//Clock low time
`define tCO	#0.45	//Data valid from positive clock edges
`define tDOH	0.45	//Data hold(negative) from positive clock edges
`define tCLZ	0.45	//Positive clock edges to Low-Z(negative)
`define tCHZ	#0.45	//Positive clock edge to High-Z
`define tCCQO   #0.45	//Positive clock edges to echo clocks valid
`define tCQOH	0.45	//Echo clocks hold(negative) from positive clock edges
`define tSA	0.40	//Address setup time to K rising edge
`define tSC	0.40	//Control signals(BWS, WE_bar, LD_bar) setup time
`define tSD	0.30	//Data setup to K and K_bar rising edge
`define tHA	0.40	//Address hold time after K rising edge
`define tHC	0.40	//Comtrol signals hold time
`define tHD	0.30	//Data holdtime after K and K_bar rising edges         

//Timings for 250 MHz 

`define tCYC	4.0     //Average Clock cycle time
`define tKH	1.60	//Clock high time
`define tKL	1.60	//Clock low time
`define tCO	#0.45	//Data valid from positive clock edges
`define tDOH	0.45	//Data hold(negative) from positive clock edges
`define tCLZ	0.45	//Positive clock edges to Low-Z(negative)
`define tCHZ	#0.45	//Positive clock edge to High-Z
`define tCCQO   #0.45	//Positive clock edges to echo clocks valid
`define tCQOH	0.45	//Echo clocks hold(negative) from positive clock edges
`define tSA	0.50	//Address setup time to K rising edge
`define tSC	0.50	//Control signals(BWS, WE_bar, LD_bar) setup time
`define tSD	0.35	//Data setup to K and K_bar rising edge
`define tHA	0.50	//Address hold time after K rising edge
`define tHC	0.50	//Comtrol signals hold time
`define tHD	0.35	//Data holdtime after K and K_bar rising edges  

//Timings for 200 MHz 

`define tCYC	5.0     //Average Clock cycle time
`define tKH	2.0	//Clock high time
`define tKL	2.0	//Clock low time
`define tCO	#0.45	//Data valid from positive clock edges
`define tDOH	0.45	//Data hold(negative) from positive clock edges
`define tCLZ	0.45	//Positive clock edges to Low-Z(negative)
`define tCHZ	#0.45	//Positive clock edge to High-Z
`define tCCQO   #0.45	//Positive clock edges to echo clocks valid
`define tCQOH	0.45	//Echo clocks hold(negative) from positive clock edges
`define tSA	0.60	//Address setup time to K rising edge
`define tSC	0.60	//Control signals(BWS, WE_bar, LD_bar) setup time
`define tSD	0.40	//Data setup to K and K_bar rising edge
`define tHA	0.60	//Address hold time after K rising edge
`define tHC	0.60	//Comtrol signals hold time
`define tHD	0.40	//Data holdtime after K and K_bar rising edges  

//Timings for 166 MHz 

`define tCYC	6.00     //Average Clock cycle time
`define tKH	2.4	//Clock high time
`define tKL	2.4	//Clock low time
`define tCO	#0.50	//Data valid from positive clock edges
`define tDOH	0.50	//Data hold(negative) from positive clock edges
`define tCLZ	0.50	//Positive clock edges to Low-Z(negative)
`define tCHZ	#0.50	//Positive clock edge to High-Z
`define tCCQO   #0.50	//Positive clock edges to echo clocks valid
`define tCQOH	0.50	//Echo clocks hold(negative) from positive clock edges
`define tSA	0.70	//Address setup time to K rising edge
`define tSC	0.70	//Control signals(BWS, WE_bar, LD_bar) setup time
`define tSD	0.40	//Data setup to K and K_bar rising edge
`define tHA	0.70	//Address hold time after K rising edge
`define tHC	0.70	//Comtrol signals hold time
`define tHD	0.40	//Data holdtime after K and K_bar rising edges  
*/                                         
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
`define wordsize (8 -1) //Size of the data bus to be defined
`define no_words (4194304 -1)
	
module ddr2_burst4 (TCK,TMS,TDI,TDO,K, K_bar, CQ, CQ_bar, C, C_bar, BWS, LD_bar, WE_bar, A, DQ,ZQ,DOFF);

input 		TCK,TMS,TDI;
output		TDO;
input 		K, K_bar, C, C_bar;
input		LD_bar, WE_bar;
input	[1:0]	BWS;
input	[19:0]	A;
inout		CQ, CQ_bar;
inout	[7:0]	DQ;
input 		ZQ;
input		DOFF;

reg	[7:0]	data_in1, data_in2, data_in3, data_in4, Data_out; 
reg	[3:0]	Mem_array_lb [`no_words:0];
reg	[7:4]	Mem_array_ub [`no_words:0];
reg	[21:0]	Address_reg; 
reg	[1:0]	BWS_reg_pos, BWS_reg_neg;
reg	[21:0]  Wr_Address_reg1, Wr_Address_reg2, Wr_Address_reg3;
reg	[21:0]	Rd_Address_reg1, Rd_Address_reg2, Rd_Address_reg3;
reg	[1:0] 	present_cycle, prev_cycle1, prev_cycle2, prev_cycle3;
reg		read_write;
reg		dll_Clk, dll_Clk_bar;
reg		Rd_Clk, Rd_Clk_bar;
real	 	tdll, techo, tk1, tk2, text_cyc;
reg		notifier;
reg 		setter_clk,echoclk,echoclkb,echo_on;

`define Read	2'b00
`define Write	2'b01
`define None	2'b10

reg Set_CQ_Rise_Flag1, Set_CQ_n_Rise_Flag1, Set_CQ_Rise_Flag2, Set_CQ_n_Rise_Flag2, Set_CQ_Fall_Flag1, Set_CQ_n_Fall_Flag1, Set_CQ_Fall_Flag2, Set_CQ_n_Fall_Flag2, Modified_Setter, Setter, Single_Dual_Flag, Count_2_10_Flag;

integer  Count2, Count10, Count1000;

parameter DLL_SwitchingCycles = 256;
parameter Wait_Cycles = (DLL_SwitchingCycles - 1);
parameter Sampling_Time = 10;

initial
begin
	  Count2		= -1;
	  Count10		= 1;
	  Count1000		= 0;
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



// ********** JTAG signals..... ************

reg[3:0] state, prev_state;
reg[2:0] reg_flag;
reg[2:0] instr;
reg	 extest_en;		// Signal designed to indicate when an EXTEST instruction is entered -- active high
reg	 samplz_en;		// Singal designed to indicate when an SAMPLZ instruction is entered -- active high
reg	 extest_oe;		// Controls the output pins during EXTEST. low: high-z, high: enable
reg[31:0] vendor_code;
reg[9:0] preload;

reg tdo_tristate;		// tdo disable pin -- Controls the state of the tdo pin -- low enable
reg tdo;			// Internal tdo pin
reg shift_out;
integer i;

wire [`wordsize:0]  chip_out =  read_write ?  Data_out : 8'bz ;	// data bus coming out from the SRAM
wire cq_out = echo_on ? echoclk : 1'bz;			// echo clock coming out from the SRAM
wire cqb_out = echo_on ? echoclkb : 1'bz;			// echo clock coming out from the SRAM

wire TDO =  !tdo_tristate ?  tdo : 1'bz;	// Output TDO pin

// When EXTEST-enable is 0, the data output should use the chip data, when 1, the EXTEST data.
wire [7:0]pre_out = !extest_en ? chip_out[7:0] : preload[7:0];
wire CQ =  !extest_en ? cq_out : preload[8];
wire CQ_bar = !extest_en ? cqb_out : preload[9];

// oe is the output enable for the entire chip. Controlled by extest_oe during EXTEST. Active HIGH.
wire oe = (!extest_en ? read_write : extest_oe) && !samplz_en;

// Output buffer logic  
wire[7:0] DQ = !oe ? 8'bz : pre_out[7:0];

reg[2:0] ir_p, ir_s;	// Dual Instruction Registers (p=parallel-load, s=shift-load)
reg	 byp;		// Bypass Register
reg[31:0] dir;		// Device Identification Register -- parallel-loaded with Vendor_code during IDCODE instruction
reg[108:0] bsr;		// 109-bit boundary scan register.

// ****************************** End signal definitions 

initial
begin
        setter_clk = 0;
		tk1 = - `tCLZ;
end

always @(K)
        `tdly setter_clk = K;


//---------------Single clock mode----------------------------------------------
always @(posedge K)
	begin
		tk2 = tk1;
		tk1 = $realtime;
    		text_cyc = tk1 - tk2;
		tdll = text_cyc - `tCLZ;
		techo = text_cyc - `tCQOH;
	end

always @(Modified_Setter or K or K_bar or C or C_bar)
        begin
                if (Modified_Setter == 1)
                     begin
                        Rd_Clk <= C;
                        Rd_Clk_bar <= C_bar;
                     end
                else
                     begin
                        Rd_Clk <= K;
                        Rd_Clk_bar <= K_bar;
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
        if(Count1000 < Wait_Cycles & Count2 == 2 & Single_Dual_Flag == 1) Count1000 <= Count1000 +1;		 /// Count1000 running as toggling occured "Single_Dual_Flag == 1"

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

///-------------------------------------------------------------------------------------------

// The next process is to check if the clocks are in single clock mode or multi clock mode

always @(posedge K & Count2 < 2)
begin
        if (Count2 == 0)
        begin
                if (C == 1)
                        Set_CQ_Rise_Flag1 = 1;
                else
                        Set_CQ_Rise_Flag1 = 0;

                if (C_bar == 0)
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

                if (C_bar == 0)
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

                if (C_bar == 0)
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

                if (C_bar == 0)
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
//Generate dll clocks which are an offset of C and C_bar and which are used to
//turn on and turn off the bus before the rising edges of C and C_bar

/*
initial
	tdll = text_cyc - `tCLZ;
*/

always @(posedge Rd_Clk)
	begin
		#tdll dll_Clk = 1;
	end

always @(negedge Rd_Clk)
	begin
		#tdll dll_Clk = 0;
	end

always @(posedge Rd_Clk_bar)
	begin
		#tdll dll_Clk_bar = 1;
	end

always @(negedge Rd_Clk_bar)
	begin
		#tdll dll_Clk_bar = 0;
	end

//---------------Address latching-----------------------------------------------
always @(posedge K)
       begin	
	if (!LD_bar && present_cycle == `None)
		Address_reg[21:2] 	 <= A;
		Address_reg[1:0] <= 2'b00;
	if (present_cycle == `Write)
		Wr_Address_reg1 <= Address_reg;
	if (prev_cycle1 == `Write)
		Wr_Address_reg2[21:2] <= Wr_Address_reg1[21:2];
	if (prev_cycle2 == `Write)
		Wr_Address_reg3[21:2] <= Wr_Address_reg2[21:2];
	if (present_cycle == `Read)
		Rd_Address_reg1 <= Address_reg;
	if (prev_cycle1 == `Read)
		Rd_Address_reg2[21:2] <= Rd_Address_reg1[21:2];
	if (prev_cycle2 == `Read)
		Rd_Address_reg3[21:2] <= Rd_Address_reg2[21:2];
       end



//---------------Read and write cycles implementation---------------------------
initial
	begin
		present_cycle <= `None;
		prev_cycle1   <= `None;
		prev_cycle2   <= `None;
		prev_cycle3   <= `None;
		read_write    <=  0;	
                echo_on = 1;
	end

always @(posedge K)
	begin
		prev_cycle1 <= present_cycle;
		prev_cycle2 <= prev_cycle1;
		prev_cycle3 <= prev_cycle2; 
		if (!LD_bar)
		      begin
			if (present_cycle == `None)
			     begin
				if (!WE_bar) 
					present_cycle <= `Write;
				else	
					present_cycle <= `Read;
			     end
			else
				present_cycle <= `None;
		      end
		else
			present_cycle <= `None;	
	end        

//---------------Write data and Byte writes latching----------------------------
always @(posedge K)
	begin
		if (present_cycle == `Write) 
		    begin
			data_in1 	<= DQ;
			BWS_reg_pos	<= BWS;
		    end
		if  (prev_cycle1 == `Write)
			data_in3 	<= DQ;
			BWS_reg_pos	<= BWS;
	end

always @(posedge K_bar)
	begin
		if (prev_cycle1 == `Write) 
			data_in2 	<= DQ;
			BWS_reg_neg	<= BWS;
		if  (prev_cycle2 == `Write)
			data_in4 	<= DQ;
			BWS_reg_neg	<= BWS;
	end

//----------------Burst counter implementation----------------------------------	
always @(posedge K)
	begin
		if (prev_cycle1 == `Write)
			Wr_Address_reg2[1:0] <= Wr_Address_reg1[1:0] + 1;
		if (prev_cycle2 == `Write)
			Wr_Address_reg3[1:0] <= Wr_Address_reg2[1:0] + 1;
		if (prev_cycle1 == `Read)
			Rd_Address_reg2[1:0] <= Rd_Address_reg1[1:0] + 1;
		if (prev_cycle2 == `Read)
			Rd_Address_reg3[1:0] <= Rd_Address_reg2[1:0] + 1;
	end

always @(posedge K_bar)
	begin
		if (prev_cycle2 == `Write)
			Wr_Address_reg2[1:0] <= Wr_Address_reg2[1:0] + 1;
		if (prev_cycle2 == `Read)
			Rd_Address_reg2[1:0] <= Rd_Address_reg2[1:0] + 1;
		
	end

//----------------Writing into the memory array--------------------------------
always @(posedge K)
	begin
		if (prev_cycle1 == `Write)
		     begin
			if (!BWS_reg_pos[0])
				Mem_array_lb[Wr_Address_reg1] <= data_in1[3:0];
			if (!BWS_reg_pos[1])
				Mem_array_ub[Wr_Address_reg1] <= data_in1[7:4];
		    end
		if (prev_cycle2 == `Write)
		     begin
			if (!BWS_reg_pos[0])
				Mem_array_lb[Wr_Address_reg2] <= data_in3[3:0];
			if (!BWS_reg_pos[1])
				Mem_array_ub[Wr_Address_reg2] <= data_in3[7:4];
		     end
	end	

always @(posedge K_bar)
	begin
		if (prev_cycle2 == `Write)
		     begin
			if (!BWS_reg_neg[0])
				Mem_array_lb[Wr_Address_reg2] <= data_in2[3:0];
			if (!BWS_reg_neg[1])
				Mem_array_ub[Wr_Address_reg2] <= data_in2[7:4];
		     end
		if (prev_cycle3 == `Write)
		     begin
			if (!BWS_reg_neg[0])
				Mem_array_lb[Wr_Address_reg3] <= data_in4[3:0];
			if (!BWS_reg_neg[1])
				Mem_array_ub[Wr_Address_reg3] <= data_in4[7:4];
		     end
	end

//-----------------Reading from the memory array-------------------------------
always @(posedge Rd_Clk_bar)
	begin
		if (prev_cycle1 == `Read)
		    begin	
			Data_out[7:0] = 8'hzz;
			fork
			Data_out[3:0] <= `tCO Mem_array_lb[Rd_Address_reg1];
			Data_out[7:4] <= `tCO Mem_array_ub[Rd_Address_reg1];
			join
		    end	
		else
		if (prev_cycle2 == `Read)
		    begin
			Data_out[7:0] = 8'hzz;
			fork
			Data_out[3:0] <= `tCO Mem_array_lb[Rd_Address_reg2];
			Data_out[7:4] <= `tCO Mem_array_ub[Rd_Address_reg2];
			join
		    end	
	end  

always @(posedge Rd_Clk)
	begin
		if (prev_cycle2 == `Read)
		    begin
			Data_out[7:0] = 8'hzz;
			fork	
			Data_out[3:0] <= `tCO Mem_array_lb[Rd_Address_reg2];
			Data_out[7:4] <= `tCO Mem_array_ub[Rd_Address_reg2];
			join
		    end	
		else
		if (prev_cycle3 == `Read)
		    begin
			Data_out[7:0] = 8'hzz;
			fork
			Data_out[3:0] <= `tCO Mem_array_lb[Rd_Address_reg3];
			Data_out[7:4] <= `tCO Mem_array_ub[Rd_Address_reg3];
			join
		    end	
	end 

//------------------Read data enable------------------------------------------
always @(posedge dll_Clk_bar)
	begin
		if (prev_cycle1 == `Read)
			read_write = 1;
	end

always @(posedge Rd_Clk_bar)
	begin
		if (prev_cycle1 == `None && prev_cycle3 == `Read)
			read_write = `tCHZ 0;
	end

//------------------Implementation of negative hold times--------------------
always @(posedge dll_Clk_bar)
	begin
		if (prev_cycle1 == `Read || prev_cycle2 == `Read || prev_cycle3 == `Read)
			Data_out = 8'bz;
	end

always @(posedge dll_Clk)
	begin
		if (prev_cycle1 == `Read || prev_cycle2 == `Read || prev_cycle3 == `Read)
			Data_out = 8'bz;
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
	vendor_code = 32'b00011010100011000111000001101001;	// IDCODE for DDR2 CY7C1417AV18 device. This may not be changed.
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
						preload[0] = bsr[17];
						preload[1] = bsr[25];
						preload[2] = bsr[34];
						preload[3] = bsr[42];
						preload[4] = bsr[73];
						preload[5] = bsr[81];
						preload[6] = bsr[90];
						preload[7] = bsr[98];
						preload[8] = bsr[46];		//CQ
						preload[9] = bsr[64];		//CQ_bar
						extest_oe = bsr[108];		//Extest Output enable;
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
						bsr[108:0] = 108'bx;
						bsr[0] = C_bar;
						bsr[1] = C;
						bsr[2] = A[0];
						bsr[3] = A[1];
						bsr[4] = A[2];
						bsr[5] = A[3];
						bsr[6] = A[4];
						bsr[7] = A[5];
						bsr[8] = A[6];
						bsr[9] = 1'b0;
						bsr[10] = 1'b0;
						bsr[11] = 1'b0;
						bsr[12] = 1'b0;
						bsr[13] = 1'b0;
						bsr[14] = 1'b0;
						bsr[15] = 1'b0;
						bsr[16] = 1'b0;
						bsr[17] = DQ[0];
						bsr[18] = 1'b0;
						bsr[19] = 1'b0;
						bsr[20] = 1'b0;
						bsr[21] = 1'b0;
						bsr[22] = 1'b0;
						bsr[23] = 1'b0;
						bsr[24] = 1'b0;
						bsr[25] = DQ[1];
						bsr[26] = 1'b0;
						bsr[27] = ZQ;
						bsr[28] = 1'b0;
						bsr[29] = 1'b0;
						bsr[30] = 1'b0;
						bsr[31] = 1'b0;
						bsr[32] = 1'b0;
						bsr[33] = 1'b0;
						bsr[34] = DQ[2];
						bsr[35] = 1'b0;
						bsr[36] = 1'b0;
						bsr[37] = 1'b0;
						bsr[38] = 1'b0;
						bsr[39] = 1'b0;
						bsr[40] = 1'b0;
						bsr[41] = 1'b0;
						bsr[42] = DQ[3];
						bsr[43] = 1'b0;
						bsr[44] = 1'b0;
						bsr[45] = 1'b0;
						bsr[46] = CQ;
						bsr[47] = A[7];
						bsr[48] = A[8];
						bsr[49] = A[9];
						bsr[50] = A[10];
						bsr[51] = 1'b0;
						bsr[52] = LD_bar;
						bsr[53] = 1'b0;
						bsr[54] = BWS[0];
						bsr[55] = K;
						bsr[56] = K_bar;
						bsr[57] = 1'b0;
						bsr[58] = BWS[1];
						bsr[59] = WE_bar;
						bsr[60] = A[11];
						bsr[61] = A[12];
						bsr[62] = A[13];
						bsr[63] = A[14];
						bsr[64] = CQ_bar;
						bsr[65] = 1'b0;
						bsr[66] = 1'b0;
						bsr[67] = 1'b0;
						bsr[68] = 1'b0;
						bsr[69] = 1'b0;
						bsr[70] = 1'b0;
						bsr[71] = 1'b0;
						bsr[72] = 1'b0;
						bsr[73] = DQ[4];
						bsr[74] = 1'b0;
						bsr[75] = 1'b0;
						bsr[76] = 1'b0;
						bsr[77] = 1'b0;
						bsr[78] = 1'b0;
						bsr[79] = 1'b0;
						bsr[80] = 1'b0;
						bsr[81] = DQ[5];
						bsr[82] = 1'b0;
						bsr[83] = DOFF;
						bsr[84] = 1'b0;
						bsr[85] = 1'b0;
						bsr[86] = 1'b0;
						bsr[87] = 1'b0;
						bsr[88] = 1'b0;
						bsr[89] = 1'b0;
						bsr[90] = DQ[6]; 
						bsr[91] = 1'b0;
						bsr[92] = 1'b0;
						bsr[93] = 1'b0;
						bsr[94] = 1'b0;
						bsr[95] = 1'b0;
						bsr[96] = 1'b0;
						bsr[97] = 1'b0;
						bsr[98] = DQ[7];
						bsr[99] = 1'b0;
						bsr[100] = 1'b0;
						bsr[101] = 1'b0;
						bsr[102] = A[15];
						bsr[103] = A[16];
						bsr[104] = A[17];
						bsr[105] = A[18];
						bsr[106] = A[19];
						bsr[107] = 1'b0;
						bsr[108] = extest_oe;
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
							for(i=0; i<=107; i=i+1)
								bsr[i] = bsr[i+1];
							bsr[108] = TDI;
							shift_out = bsr[0];
						end
					`samplz:
						begin
							shift_out = bsr[0];
							for(i=0; i<=107; i=i+1)
								bsr[i] = bsr[i+1];
							bsr[108] = TDI;
							shift_out = bsr[0];
						end
					`extest:
						begin
							shift_out = bsr[0];
							for(i=0; i<=107; i=i+1)
								bsr[i] = bsr[i+1];
							bsr[108] = TDI;
							shift_out = bsr[0];
						end	
					default:	shift_out = TDI;
				endcase
			end
	endcase

end
		
//------------------Setup, Hold and width checks--------------------------------
wire  LD_bar_setup   = (present_cycle == `None);
wire  WE_setup = (present_cycle == `None && LD_bar == 1'b0);
wire  DQ1_setup = (present_cycle == `Write);
wire  DQ2_setup = (prev_cycle1 == `Write);
wire  DQ3_setup = (prev_cycle1 == `Write);
wire  DQ4_setup = (prev_cycle2 == `Write);

specify
	$setuphold(posedge K &&& ~LD_bar, A, `tSA, `tHA, notifier);           //Address
	$setuphold(posedge K &&& LD_bar_setup, LD_bar, `tSC, `tHC, notifier); //LD_bar
	$setuphold(posedge K &&& WE_setup, WE_bar, `tSC, `tHC, notifier);     //WE_bar	
	$setuphold(posedge K &&& DQ1_setup, DQ, `tSD, `tHD, notifier);	      //DQ1	
	$setuphold(posedge K_bar &&& DQ2_setup, DQ, `tSD, `tHD, notifier);    //DQ2	
	$setuphold(posedge K &&& DQ3_setup, DQ, `tSD, `tHD, notifier);        //DQ3
	$setuphold(posedge K_bar &&& DQ4_setup, DQ, `tSD, `tHD, notifier);    //DQ4
	$setuphold(posedge K &&& DQ1_setup, BWS, `tSC, `tHC, notifier);	      //BWS1	
	$setuphold(posedge K_bar &&& DQ2_setup, BWS, `tSC, `tHC, notifier);    //BWS2	
	$setuphold(posedge K &&& DQ3_setup, BWS, `tSC, `tHC, notifier);        //BWS3
	$setuphold(posedge K_bar &&& DQ4_setup, BWS, `tSC, `tHC, notifier);    //BWS4  
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
