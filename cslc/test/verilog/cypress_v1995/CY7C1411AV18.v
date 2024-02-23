// This model is the property of Cypress Semiconductor Corp and is protected 
// by the US copyright laws, any unauthorized copying and distribution is prohibited.
// Cypress reserves the right to change any of the functional specifications without
// any prior notice.
// Cypress is not liable for any damages which may result from the use of this 
// functional model.
//
//  
//	Model:	CY7C1411AV18 8M x 8 QDR(tm)-II Burst-of-4 SRAM
// 	Date:		Sept 29th, 2004
//
//	Revision:	1.0
//
//	Description: 	This is the verilog functional model of the QDR(tm)-II SRAM. This information
//			is confidential. 
//
//	Contact:	MPD Applications
//			www.cypress.com/support
//			Cypress Semiconductor, San Jose, CA 
//
//	Revision History - New model created from CY7C1411V18
//	NOTE :	Any setup/hold errors will force input signal to x state
//		or if results indeterninant (write addr) core is reset x
//

`timescale  1ns / 10ps

`define wordsize (8 -1) 	//Size of the data bus to be defined
`define no_words (1048576 -1)	//2M x 8 RAM (uses 4)

/*
Minimum Timings for 300 MHz Operation

`define tcyc	#3.3			// Clock cycle time
`define tkh	#1.32			// K clock high
`define tkl	#1.32			// K clock low
`define tkhkh	#1.49			// K clock rise to K clock rise (min/typ/max)
`define tkhch	#(0.0:0.7:1.45)		// K clock rise to C clock rise (min/typ/max)
`define tco	#0.45			// C clock rise to output data valid
`define tdoh	#0.45			// Min. Data Output Hold BEFORE C/C# clock rise
`define tccqo   #0.45
`define tcqoh   #0.45
`define tsa	0.4			// Address set-up before K clock rise
`define tsc	0.4			// Control signals set up to clock rise
`define tsd	0.3			// Data setup to K/K# clock rise
`define tscddr  0.3			// Setup time for double data rate control signals
`define tha	0.4			// Address hold after clock K/K# rise
`define thc	0.4			// Control Iputs hold after clock K/K# rise
`define thcddr  0.3			// Hold time for double data rate control signals
`define thd	0.3			// Data hold after clock K/K# rise
`define tclz	0.45			// C/C# clock to high Z (deselect)
`define tchz	#0.45			// C/C# clock to low Z (activate) (negative)
*/

// Timings for 250 MHz 

`define tcyc	#4
`define tkh	#1.6
`define tkl	#1.6
`define tkhkh	#1.8
`define tkhch	#(0.0:0.9:1.8)
`define tco	#0.45
`define tdoh	#0.45
`define tccqo   #0.45
`define tcqoh   #0.45	
`define tsa	0.5
`define tsc	0.5
`define tsd	0.35
`define tscddr  0.35
`define tha	0.5
`define thc	0.5
`define thd	0.35
`define thcddr  0.35
`define tclz	0.45
`define tchz	#0.45   

/*
Timings for 200 MHz 

`define tcyc	#5
`define tkh	#2
`define tkl	#2
`define tkhkh	#2.2
`define tkhch	#(0.0:1.2:2.3)
`define tco	#0.45
`define tdoh	#0.45
`define tccqo   #0.45
`define tcqoh   #0.45
`define tsa	0.6
`define tsc	0.6
`define tsd	0.4
`define tscddr  0.4
`define tha	0.6
`define thc	0.6
`define thd	0.4
`define thcddr  0.4
`define tclz	0.45
`define tchz	#0.45 

Timings for 166 MHz 

`define tcyc	#6
`define tkh	#2.4
`define tkl	#2.4
`define tkhkh	#2.7
`define tkhch	#(0.0:1.75:3.55)
`define tco	#0.50
`define tdoh	#0.50
`define tccqo   #0.50
`define tcqoh   #0.50
`define tsa	0.7
`define tsc	0.7
`define tsd	0.4
`define tscddr  0.4
`define tha	0.7
`define thc	0.7
`define thd	0.4
`define thcddr  0.4
`define tclz	0.50
`define tchz	#0.50

*/
// JTAG Definitions
					// State definitions	 Binary	  Hex
					// ------------------------------------
`define reset		4'b1111		// Test-Logic-Reset 	= 1111	  0xF
`define idle		4'b1100		// Run-Test-Idle	= 1100	  0xC
`define select_DR_scan	4'b0111		// Select-DR-scan	= 0111	  0x7
`define select_IR_scan	4'b0100		// Select-IR-scan	= 0100	  0x4
`define capture_DR	4'b0110		// Capture-DR		= 0110	  0x6
`define capture_IR	4'b1110		// Capture-IR		= 1110	  0xE
`define shift_DR	4'b0010		// Shift-DR		= 0010	  0x2
`define shift_IR	4'b1010		// Shift-IR		= 1010	  0xA
`define exit1_DR	4'b0001		// Exit1-DR		= 0001	  0x1
`define exit1_IR	4'b1001		// Exit1-IR		= 1001	  0x9
`define pause_DR	4'b0011		// Pause-DR		= 0011	  0x3
`define pause_IR	4'b1011		// Pause-IR		= 1011	  0xB
`define exit2_DR	4'b0000		// Exit2-DR		= 0000	  0x0
`define exit2_IR	4'b1000		// Exit2-IR		= 1000	  0x8
`define update_DR	4'b0101		// Update-DR		= 0101	  0x5
`define update_IR	4'b1101		// Update-IR		= 1101	  0xD
					// ------------------------------------

					// Command Definitions	 Binary	  Hex
					// ------------------------------------
`define extest		3'b000		// EXTEST		= 000	  0x0
`define idcode		3'b001		// IDCODE		= 001	  0x1
`define samplz		3'b010		// SAMPLE-Z		= 010	  0x2
`define resrv1		3'b011		// reserved		= 011	  0x3
`define sampld		3'b100		// SAMPLE/PRELOAD	= 100	  0x4
`define resrv2		3'b101		// reserved		= 101	  0x5
`define resrv3		3'b110		// reserved		= 110	  0x6
`define bypass		3'b111		// BYPASS		= 111	  0x7
					// ------------------------------------
					// Commands are determined by status of ir_p register.
// JTAG AC Timings

`define tclkcyc	#100			// TCK cycle time (min)
`define th	#40			// TCK clock high (min)
`define tl	#40			// TCK clock low (min)	
`define ttmss	10			// TMS set-up to TCK clock rise (min)
`define ttdis	10			// TDI set-up to TCK clock rise (min)
`define tcs	10			// Capture set-up to TCK clock rise (min)
`define ttmsh	10			// TMS hold after TCK clock rise (min)
`define ttdih	10			// TDI hold after TCK clock rise (min)
`define tch	10			// Capture hold after TCK clock rise (min)
`define ttdov	#20			// TCK clock LOW to TDO valid (max)
`define ttdox	0			// TCK clock LOW to TDO invalid (min)

`define tdly	#0.05

module cyqdr2_b4(TCK,TMS,TDI,TDO,D, Q, A, K, Kb, C, Cb, RPSb, WPSb, BWS0b, BWS1b, CQ, CQb,ZQ,DOFF);

input 			TCK, TMS, TDI;
output			TDO;

input	[`wordsize:0] 	D;

input 			K, Kb, C, Cb,	// clock inputs
			RPSb, 		// Read Port Select
			WPSb,		// Write Port Select
			BWS0b, BWS1b,	// Byte Write Select
			ZQ,		// Programmable Impedance Pin
			DOFF;		// Internal DLL Off Pin


input 	[19:0] 		A;		// address busses for a 1024K RAM

inout			CQ, CQb;	// Echo Clock Out
inout [`wordsize:0]	Q;
wire BWS0b_o, BWS1b_o;	//Previous Copy of NWS0 and and NWS1

wire [19:0] A;       	// address input bus

reg [19:0] Read_Address, Read_Address_o,Read_Address_o_o,Read_Address_o_o_o,Read_Address_o_o_o_o, Write_Address, Write_Address_o, Write_Address_o_o, Write_Address_o_o_o;

reg 		notifier;	// error support regs

reg 		noti1_0;
reg		noti1_1;
reg 		noti2_0;
reg 		noti2_1;
reg 		noti2_2;
reg 		noti2_3;
reg 		noti3_0;
reg 		noti3_1;
reg 		noti4_0;
reg 		noti4_1;

reg  [7:0] temp_reg,temp1,temp2;
reg  [7:0] mem1 [0:`no_words];	// First Array
reg  [7:0] mem2 [0:`no_words]; // Second Array
reg  [7:0] mem3 [0:`no_words]; // thrid Array
reg  [7:0] mem4 [0:`no_words]; // fourth Array

reg [`wordsize :0] Data_in1, Data_in2; //Temporary location to hold data before being written into array

reg tristate;		// Signal to tristate the output, when no read is being done

reg Nibble_write_din1_l, Nibble_write_din1_h, Nibble_write_din2_l, Nibble_write_din2_h;
reg Nibble_write_din1_l_o, Nibble_write_din1_h_o, Nibble_write_din2_l_o, Nibble_write_din2_h_o;
reg Nibble_write_din1_l_o_o, Nibble_write_din1_h_o_o, Nibble_write_din2_l_o_o, Nibble_write_din2_h_o_o;

reg rpen_o_o_o_o_o,rpen_o_o_o_o, rpen_o_o_o, rpen_o_o, rpen_o, rpen;
reg wpen, wpen_o,wpen_o_o,wpen_o_o_o;

reg [7:0] Data_out;

reg Set_C_Rise_Flag1, Set_Cb_Rise_Flag1, Set_C_Rise_Flag2, Set_Cb_Rise_Flag2, Set_C_Fall_Flag1, Set_Cb_Fall_Flag1, Set_C_Fall_Flag2, Set_Cb_Fall_Flag2, Modified_Setter, Setter, Single_Dual_Flag, Count_2_10_Flag;

reg echo_clk, echo_clkb, echo_on ,echoclk_hold_clk;
real tcqh,tk1,tk2,text_cyc;

integer Count2, Count10, Count1000;

parameter DLL_SwitchingCycles = 256;
parameter Wait_Cycles = (DLL_SwitchingCycles - 1);
parameter Sampling_Time = 10;


reg update_clk, setter_clk, datahold_clk, Clocks_in_Sync;

wire IoutClk = Modified_Setter ? C : K;
wire IoutClkb = Modified_Setter ? Cb: Kb;

// ********** JTAG signals..... ************

reg[3:0] state, prev_state;
reg[2:0] reg_flag;
reg[2:0] instr;
reg	 extest_en;		// Signal designed to indicate when an EXTEST instruction is entered -- active high
reg	 samplz_en;		// Singal designed to indicate when an SAMPLZ instruction is entered -- active high
reg	 extest_oe;		// Controls the output pins during EXTEST. low: high-z, high: enable
reg[31:0] vendor_code;
reg[9:0] preload;

reg chip_oe;			// chip data out tristate control -- low: high-z high: output enable
reg tdo_tristate;		// tdo disable pin -- Controls the state of the tdo pin -- low enable
reg tdo;			// Internal tdo pin
reg shift_out;
integer i;

wire [`wordsize:0]  chip_out =  chip_oe ?  Data_out : 8'bz ;	// data bus coming out from the SRAM
wire cq_out = echo_on ? echo_clk : 1'bz;			// echo clock coming out from the SRAM
wire cqb_out = echo_on ? echo_clkb : 1'bz;			// echo clock coming out from the SRAM

wire TDO =  !tdo_tristate ?  tdo : 1'bz;	// Output TDO pin

// When EXTEST-enable is 0, the data output should use the chip data, when 1, the EXTEST data.
wire [7:0]pre_out = !extest_en ? chip_out[7:0] : preload[7:0];
wire CQ =  !extest_en ? cq_out : preload[8];
wire CQb = !extest_en ? cqb_out : preload[9];

// oe is the output enable for the entire chip. Controlled by extest_oe during EXTEST. Active HIGH.
wire oe = (!extest_en ? chip_oe : extest_oe) && !samplz_en;

// Output buffer logic  
wire[7:0] Q = !oe ? 8'bz : pre_out[7:0];

reg[2:0] ir_p, ir_s;	// Dual Instruction Registers (p=parallel-load, s=shift-load)
reg	 byp;		// Bypass Register
reg[31:0] dir;		// Device Identification Register -- parallel-loaded with Vendor_code during IDCODE instruction
reg[108:0] bsr;		// 109-bit boundary scan register.

// ****************************** End signal definitions *************************************************

initial
	begin

// error signals 
	  notifier 	= 0;
	  noti1_0	= 0;
	  noti1_1	= 0;
	  noti2_0	= 0;
	  noti2_1	= 0;
	  noti2_2	= 0;
	  noti2_3	= 0;
	  noti3_0	= 0;
	  noti3_1	= 0;
	  noti4_0	= 0;
	  noti4_1	= 0;
	  Count2		= -1;
	  Count10		= 1;
	  Count1000		= 0;
	  Single_Dual_Flag      = 0;       ///  Single_Dual_Flag => This flag indicates when switching occurs
	  Set_C_Rise_Flag1 = 0;
	  Set_Cb_Rise_Flag1 = 0; 
          Set_C_Rise_Flag2 = 0;
          Set_Cb_Rise_Flag2 = 0;
          Set_C_Fall_Flag1 = 0;
          Set_Cb_Fall_Flag1 = 0;
          Set_C_Fall_Flag2 = 0;
	  Set_Cb_Fall_Flag1 = 0;
	  Count_2_10_Flag = 0;            /// Count_2_10_Flag = 0  => Count2 is running; Count_2_10_Flag = 1 => Count10 is running;


	  echo_on = 1;
	
	  rpen_o = 1;
	  rpen_o_o = 1;
	  rpen_o_o_o = 1;
	  rpen_o_o_o_o = 1;

	  wpen_o = 1;
	  wpen_o_o = 1;
	  wpen_o_o_o = 1;
end

// We create another internal clock, offset off Kb which can be used to do all updations
always @(K)
begin
	tk2=tk1;
        tk1=$realtime;
        text_cyc=tk1-tk2;
        tcqh = text_cyc - `tclz;
end

initial
begin
        tk1= -`tclz;
	chip_oe = 0;
	tristate = 1;
	update_clk = 0;
	setter_clk = 0;
end

always @(Kb)
 `tdly update_clk = Kb;

always @(K)
 `tdly setter_clk = K;
always @(IoutClk)
begin
	`tccqo echo_clk = IoutClk;
end

always @(IoutClkb)
begin
	`tccqo echo_clkb = IoutClkb;
end

always @(IoutClkb)
	#tcqh echoclk_hold_clk = IoutClkb;

always @(IoutClk)
	#tcqh datahold_clk = IoutClkb;

always @(echoclk_hold_clk)
begin
	if (echo_clk == 1) echo_clk = 1'b0;
	if (echo_clkb == 1) echo_clkb = 1'b0;
end


//	***	SETUP / HOLD VIOLATIONS		***

always @(noti1_0)
begin
	$display("NOTICE      : 020 : Address bus corruption on CLK");
end

always @(noti1_1)
begin
	$display("NOTICE      : 020 : Address bus corruption on Kb"); 
end

always @(noti2_0)
begin
	$display("NOTICE      : 020 : NWS0 problem on CLK");
end

always @(noti2_1)
begin
	$display("NOTICE      : 020 : NWS1 problem on CLKb");
end

always @(noti2_2)
begin
	$display("NOTICE      : 020 : NWS0 problem on CLK");
end

always @(noti2_3)
begin
	$display("NOTICE      : 020 : NWS1 problem on CLKb");
end

always @(noti3_1)
begin
	$display("NOTICE      : 011 : RPS problem on K");
end

always @(noti3_1)
begin
	$display("NOTICE      : 012 : WPS problem on K");
end

always @(noti4_0)
begin
	$display("NOTICE      : 013 : Din problem on K");
end

always @(noti4_1)
begin
	$display("NOTICE      : 014 : Din problem on Kb");
end

// The next process is to check if the clocks are in single clock mode or multi
// clock mode

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

always @(posedge K & Count2 < 2)
begin
	if (Count2 == 0)
	begin
		if (C == 1)
			Set_C_Rise_Flag1 = 1;
		else
			Set_C_Rise_Flag1 = 0;

		if (Cb == 0)
			Set_Cb_Rise_Flag1 = 1;
		else
			Set_Cb_Rise_Flag1 = 0;
	
	end

	if(Count2 == 1)
	begin
		if (C == 1)
			Set_C_Rise_Flag2 = 1;
		else
			Set_C_Rise_Flag2 = 0;

		if (Cb == 0) 
			Set_Cb_Rise_Flag2 = 1;
		else
			Set_Cb_Rise_Flag2 = 0;
	end
end

always @(negedge K & Count2 < 2)
begin

	if (Count2 == 0)
	begin
		if (C == 1)
			Set_C_Fall_Flag1 = 1;
		else
			Set_C_Fall_Flag1 = 0;

		if (Cb == 0)
			Set_Cb_Fall_Flag1 = 1;
		else
			Set_Cb_Fall_Flag1 = 0;
	end

	if(Count2 == 1)
	begin
		if (C == 1)
			Set_C_Fall_Flag2 = 1;
		else
			Set_C_Fall_Flag2 = 0;
		if (Cb == 0)
			Set_Cb_Fall_Flag2 = 1;
		else
			Set_Cb_Fall_Flag2 = 0;

	end

end

// Now use the information provided above and change the CQ clock

always @(negedge setter_clk)
begin

if ((Set_C_Rise_Flag1 == 1) & (Set_C_Rise_Flag2 == 1) & (Set_C_Fall_Flag1 == 0) & (Set_C_Fall_Flag2 == 0)  & Count2 == 1)
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
else if ((Set_C_Rise_Flag1 == 0) & (Set_C_Rise_Flag2 == 0) & (Set_C_Fall_Flag1 == 1) & (Set_C_Fall_Flag2 == 1) & Count2 == 1)
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

 else if ((Set_C_Rise_Flag1 == 0) & (Set_Cb_Rise_Flag1 == 1) & (Set_C_Fall_Flag1 == 0) & (Set_Cb_Fall_Flag1 == 1) & (Set_C_Rise_Flag2 == 1) & (Set_Cb_Rise_Flag2 == 1) & (Set_C_Fall_Flag2 == 0) & (Set_Cb_Fall_Flag2 == 0) & Count2 == 1)  /// This condition and the next one satisfy if the toggling starts just after a half cycle of the first sampling cycle.
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

else if ((Set_C_Rise_Flag1 == 1) & (Set_Cb_Rise_Flag1 == 0) & (Set_C_Fall_Flag1 == 1) & (Set_Cb_Fall_Flag1 == 0) & (Set_C_Rise_Flag2 == 0) & (Set_Cb_Rise_Flag2 == 0) & (Set_C_Fall_Flag2 == 1) & (Set_Cb_Fall_Flag2 == 1) & Count2 == 1)
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



// Now for checking if the input clock and the Iout clock are skewed

always @(posedge K)
begin
	if (Count2 == 3 & Setter == 1)
		Clocks_in_Sync = 1;
	else if (IoutClk == 1) 
		Clocks_in_Sync = 1;
	else if (IoutClk == 0)
		Clocks_in_Sync = 0;
end


// This assignment should allow us to look at RP on the next rising edge, without any changes
always @(negedge IoutClk)
begin
	if (Clocks_in_Sync == 1)
	begin
	  if (rpen_o == 0 || rpen_o_o == 0 || rpen_o_o_o == 0)
		chip_oe = `tchz 1;
	  else
		chip_oe = `tchz 0;
	end

	if (Clocks_in_Sync == 0)
	begin
	  if (rpen_o_o == 0 || rpen_o_o_o == 0 || rpen_o_o_o_o == 0)
		chip_oe = `tchz 1;
	  else
		chip_oe = `tchz 0;
	end
end

always @(datahold_clk)
begin
	if(chip_oe == 1) Data_out = 8'bz;
end

// We also need to look at the past and present conditions of read/write port selct to complete read/write blocking


always @(posedge K)
begin
	rpen_o_o_o_o_o = rpen_o_o_o_o;
	rpen_o_o_o_o = rpen_o_o_o;
	rpen_o_o_o = rpen_o_o;
	rpen_o_o = rpen_o;
	if (rpen_o == 0)
		rpen_o = 1;
	else
		rpen_o = RPSb;

	wpen_o_o_o = wpen_o_o;
	wpen_o_o = wpen_o;
 
	if (wpen_o == 0) 
		wpen_o = 1;
	else if((RPSb == 0 && rpen_o_o == 0) || RPSb != 0 )
		wpen_o = WPSb;
	else
		wpen_o = 1;

end


always @(posedge K)
begin
	Read_Address_o_o_o_o = Read_Address_o_o_o;
	Read_Address_o_o_o = Read_Address_o_o;
	Read_Address_o_o = Read_Address_o;
	Read_Address_o = Read_Address;
	Read_Address = A;
end 

always @(posedge K)
begin
	Write_Address_o_o_o = Write_Address_o_o;
	Write_Address_o_o = Write_Address_o;
	Write_Address_o = Write_Address;
	Write_Address = A;
end

always @(posedge IoutClk)
begin
	if(Clocks_in_Sync == 1)
	begin
		if (rpen_o_o_o == 0)
		begin
			Data_out = `tco  mem2[Read_Address_o_o];
			temp1 = mem2[Read_Address];
		end

		if (rpen_o_o_o_o == 0)
			Data_out = `tco mem4[Read_Address_o_o_o];
	end
	else
	begin
		if(rpen_o_o_o == 0)
			Data_out = `tco  mem2[Read_Address_o_o];
		if (rpen_o_o_o_o == 0)
			Data_out = `tco mem4[Read_Address_o_o_o];
	end
end

// This process is to pump out the data on the rising edge of CQb

always @(posedge IoutClkb)
begin
	if(Clocks_in_Sync == 1)
	begin
		if (rpen_o_o == 0)
			Data_out =  `tco mem1[Read_Address_o];
		if (rpen_o_o_o == 0)
			Data_out = `tco mem3[Read_Address_o_o];
	end
	else
	begin
		if (rpen_o_o == 0)
			Data_out =  `tco mem1[Read_Address_o];
		if (rpen_o_o_o == 0)
			Data_out = `tco mem3[Read_Address_o_o];
	end
end

//Edited nsl -- Added tristate control hardware to cut off the data after the minimum hold time...

always @(posedge update_clk)
begin
	if (rpen_o_o == 0 || rpen_o_o_o == 0)
		tristate = `tchz 0;
	else
		tristate = `tchz 1;
end

always @(datahold_clk)
begin
	if(tristate == 0) Data_out = 8'bz; 
	if(echo_clk == 1) echo_clk = 1'b0;
	if(echo_clkb == 0) echo_clkb = 1'b1;
end

// Write control

always @(posedge update_clk)
begin
	if (wpen_o_o == 0)
	begin
		if (Nibble_write_din1_l == 0 && Nibble_write_din1_h == 1)
		begin
			temp_reg = mem1[Write_Address_o];
			temp_reg[3:0] = Data_in1[3:0];
			mem1[Write_Address_o] = temp_reg;
		end
		else if(Nibble_write_din1_l == 1 && Nibble_write_din1_h == 0)
		begin
			temp_reg = mem1[Write_Address_o];
			temp_reg[7:4] = Data_in1[7:4];
			mem1[Write_Address_o] = temp_reg;
		end
		else if(Nibble_write_din1_l == 0 && Nibble_write_din1_h == 0)
		begin
			mem1[Write_Address_o] = Data_in1[7:0];
			temp1 = mem1[Write_Address_o];

		end

		if (Nibble_write_din2_l == 0 && Nibble_write_din2_h == 1)
		begin
			temp_reg = mem2[Write_Address_o];
			temp_reg[3:0] = Data_in2[3:0];
			mem2[Write_Address_o] = temp_reg;
		end
		else if(Nibble_write_din2_l == 1 && Nibble_write_din2_h == 0)
		begin
			temp_reg = mem2[Write_Address_o];
			temp_reg[7:4] = Data_in2[7:4];
			mem2[Write_Address_o] = temp_reg;
		end
		else if(Nibble_write_din2_l == 0 && Nibble_write_din2_h == 0)
		begin
			mem2[Write_Address_o] = Data_in2[7:0];
			temp2 = mem2[Write_Address_o];
		end
		
	end

      if(wpen_o_o_o == 0)
	begin
		if (Nibble_write_din1_l == 0 && Nibble_write_din1_h == 1) 
		begin
			temp_reg = mem3[Write_Address_o_o];
			temp_reg[3:0] = Data_in1[3:0];
			mem3[Write_Address_o_o] = temp_reg;
		end
		else if(Nibble_write_din1_l == 1 && Nibble_write_din1_h == 0)
		begin
			temp_reg = mem3[Write_Address_o_o];
			temp_reg[7:4] = Data_in1[7:4];
			mem3[Write_Address_o_o] = temp_reg;
		end
		else if(Nibble_write_din1_l == 0 && Nibble_write_din1_h == 0)
		begin
		
			mem3[Write_Address_o_o] = Data_in1[7:0];
			temp1 = mem3[Write_Address_o_o];
		end

		if (Nibble_write_din2_l == 0 && Nibble_write_din2_h == 1) 
		begin
			temp_reg = mem4[Write_Address_o_o];
			temp_reg[3:0] = Data_in2[3:0];
			mem4[Write_Address_o_o] = temp_reg;
		end
		else if(Nibble_write_din2_l == 1 && Nibble_write_din2_h == 0)
		begin
			temp_reg = mem4[Write_Address_o_o];
			temp_reg[7:4] = Data_in2[7:4];
			mem4[Write_Address_o_o] = temp_reg;
		end
		else if(Nibble_write_din2_l == 0 && Nibble_write_din2_h == 0)
		begin
			mem4[Write_Address_o_o] = Data_in2[7:0];
			temp2 = mem4[Write_Address_o_o];		
		end
	end
end

always @(posedge K)
begin
	Nibble_write_din1_l_o_o = Nibble_write_din1_l_o;
	Nibble_write_din1_h_o_o = Nibble_write_din1_h_o;

	Nibble_write_din1_l_o = Nibble_write_din1_l;
	Nibble_write_din1_h_o = Nibble_write_din1_h;
	Nibble_write_din1_l <= BWS0b;
	Nibble_write_din1_h <= BWS1b;

	Data_in1 <= D;  
end

always @(posedge Kb)
begin
	Nibble_write_din2_l_o_o = Nibble_write_din2_l_o;
	Nibble_write_din2_h_o_o = Nibble_write_din2_h_o;

	Nibble_write_din2_l_o = Nibble_write_din2_l;
	Nibble_write_din2_h_o = Nibble_write_din2_h;

	Nibble_write_din2_l <= BWS0b;
	Nibble_write_din2_h <= BWS1b;
	Data_in2 <= D;
end
// **********************************************************
// ******************** JTAG Section ************************ 
// **********************************************************

//---------- Initial statements --------------//

initial
begin 
	state = `reset;
	prev_state = `reset;
	vendor_code = 32'b00011010011011000111000001101001;	// IDCODE for QDR2 CY7C1411AV18 device. This may not be changed.

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
						preload[0] = bsr[17];
						preload[1] = bsr[25];
						preload[2] = bsr[34];
						preload[3] = bsr[42];
						preload[4] = bsr[73];
						preload[5] = bsr[81];
						preload[6] = bsr[90];
						preload[7] = bsr[98];
						preload[8] = bsr[46];		//CQ
						preload[9] = bsr[64];		//CQb
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
		bsr[0]	=	Cb;
		bsr[1]	=	C;
		bsr[2]	=	A[0];
		bsr[3]	=	A[1];
		bsr[4]	=	A[2];
		bsr[5]	=	A[3];
		bsr[6]	=	A[4];
		bsr[7]	=	A[5];
		bsr[8]	=	A[6];
		bsr[9]	=	1'b0;
		bsr[10]	=	1'b0;
		bsr[11]	=	1'b0;
		bsr[12]	=	1'b0;
		bsr[13]	=	1'b0;
		bsr[14]	=	1'b0;
		bsr[15]	=	1'b0;
		bsr[16]	=	1'b0;
		bsr[17]	=	Q[0];
		bsr[18]	=	D[0];
		bsr[19]	=	1'b0;
		bsr[20]	=	1'b0;
		bsr[21]	=	1'b0;
		bsr[22]	=	1'b0;
		bsr[23]	=	1'b0;
		bsr[24]	=	1'b0;
		bsr[25]	=	Q[1];
		bsr[26]	=	D[1];
		bsr[27]	=	ZQ;
		bsr[28]	=	1'b0;
		bsr[29]	=	1'b0;
		bsr[30]	=	1'b0;
		bsr[31]	=	1'b0;
		bsr[32]	=	1'b0;
		bsr[33]	=	1'b0;
		bsr[34]	=	Q[2];
		bsr[35]	=	D[2];
		bsr[36]	=	1'b0;
		bsr[37]	=	1'b0;
		bsr[38]	=	1'b0;
		bsr[39]	=	1'b0;
		bsr[40]	=	1'b0;
		bsr[41]	=	1'b0;
		bsr[42]	=	Q[3];
		bsr[43]	=	D[3];
		bsr[44]	=	1'b0;
		bsr[45]	=	1'b0;
		bsr[46]	=	CQ;
		bsr[47]	=	A[7];
		bsr[48]	=	A[8];
		bsr[49]	=	A[9];
		bsr[50]	=	A[10];
		bsr[51]	=	1'b0;
		bsr[52]	=	RPSb;
		bsr[53]	=	1'b0;
		bsr[54]	=	BWS0b;
		bsr[55]	=	K;
		bsr[56]	=	Kb;
		bsr[57]	=	1'b0;
		bsr[58]	=	BWS1b;
		bsr[59]	=	WPSb;
		bsr[60]	=	A[11];
		bsr[61]	=	A[12];
		bsr[62]	=	A[13];
		bsr[63]	=	A[14];
		bsr[64]	=	CQb;
		bsr[65]	=	1'b0;
		bsr[66]	=	1'b0;
		bsr[67]	=	1'b0;
		bsr[68]	=	1'b0;
		bsr[69]	=	1'b0;
		bsr[70]	=	1'b0;
		bsr[71]	=	1'b0;
		bsr[72]	=	1'b0;
		bsr[73]	=	Q[4];
		bsr[74]	=	D[4];
		bsr[75]	=	1'b0;
		bsr[76]	=	1'b0;
		bsr[77]	=	1'b0;
		bsr[78]	=	1'b0;
		bsr[79]	=	1'b0;
		bsr[80]	=	1'b0;
		bsr[81]	=	Q[5];
		bsr[82]	=	D[5];
		bsr[83]	=	DOFF;
		bsr[84]	=	1'b0;
		bsr[85]	=	1'b0;
		bsr[86]	=	1'b0;
		bsr[87]	=	1'b0;
		bsr[88]	=	1'b0;
		bsr[89]	=	1'b0;
		bsr[90]	=	Q[6];
		bsr[91]	=	D[6];
		bsr[92]	=	1'b0;
		bsr[93]=	1'b0;
		bsr[94]	=	1'b0;
		bsr[95]	=	1'b0;
		bsr[96]	=	1'b0;
		bsr[97]	=	1'b0;
		bsr[98]	=	Q[7];
		bsr[99]	=	D[7];
		bsr[100]	=	1'b0;
		bsr[101]	=	1'b0;
		bsr[102]	=	A[15];
		bsr[103]	=	A[16];
		bsr[104]	=	A[17];
		bsr[105]	=	A[18];
		bsr[106]	=	A[19];
		bsr[107]	=	1'b0;
		bsr[108]	=	extest_oe;

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
specify
// specify the setup and hold checks

$setuphold(posedge K, BWS0b,  `tsc, `thc, noti2_0);
$setuphold(posedge Kb, BWS1b, `tsc, `thc, noti2_1);
$setuphold(posedge K, BWS0b,  `tsc, `thc, noti2_2);
$setuphold(posedge Kb, BWS1b, `tsc, `thc, noti2_3);

$setuphold(posedge K, RPSb,  `tsc, `thc, noti3_0);
$setuphold(posedge K, WPSb, `tsc, `thc, noti3_1);

$setuphold(negedge K, D,  `tsd, `thd, noti4_0);
$setuphold(posedge Kb, D, `tsd, `thd, noti4_1);

$setuphold(posedge K, A, `tsa, `tha, noti1_0);
$setuphold(posedge Kb, A, `tsa, `tha, noti1_1);

endspecify

endmodule
