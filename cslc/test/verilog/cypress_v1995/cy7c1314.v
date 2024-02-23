// This model is the property of Cypress Semiconductor Corp and is protected 
// by the US copyright laws, any unauthorized copying and distribution is prohibited.
// Cypress reserves the right to change any of the functional specifications without
// any prior notice.
// Cypress is not liable for any damages which may result from the use of this 
// functional model.
//
//  
//	Model:	CY7C1314AV18 512K x 36 QDR(tm)-II Burst-of-2 SRAM
// 	Date:		February 3, 2003
//
//	Release:	1.1 (Timing changes implemented from rev1.0)
//
//	Description: This is the verilog functional model of the QDR(tm)-II SRAM. This information
//		     is confidential. 
//
//	Revision Hisory
//	Rev 1.0-(Scott N. Latham) Model Created, based on the QDR(tm)-II B2 x18 model w/ JTAG.
//      Rev 1.1 - (Kannan Srinivasagam) Model modified to automatically generate timing for data and echo clock cutoff 
//
//	NOTE :	Any setup/hold errors will force input signal to x state
//		or if results indeterninant (write addr) core is reset x
//

`timescale  1ns /  10ps
  
// define fixed values

`define wordsize (36 -1) //Size of the data bus to be defined
`define no_words (262144 -1)		// 256K x 36 RAM (Uses 2)

//Timings for 200 MHz 

`define tcyc	#5
`define tkh	#2
`define tkl	#2
`define tkhkh	#(2.2:2.5:2.75)
`define tkhch	#(0.0:1.2:2.3)
`define tco	#0.38
`define tdoh	#0.38
`define tccqo   #0.36
`define tcqoh   #0.36
`define tsa	0.5
`define tsc	0.5
`define tsd	0.5
`define tha	0.5
`define thc	0.5
`define thd	0.5
`define tclz	0.38
`define tchz	#0.38 

/*
Timings for 167 MHz 

`define tcyc	#6
`define tkh	#2.4
`define tkl	#2.4
`define tkhkh	#(2.7:3.0:3.3)
`define tkhch	#(0.0:1.4:2.8)
`define tco	#0.4
`define tdoh	#0.4
`define tccqo   #0.38
`define tcqoh   #0.38
`define tsa	0.6
`define tsc	0.6
`define tsd	0.6
`define tha	0.6
`define thc	0.6
`define thd	0.6
`define tclz	0.4
`define tchz	#0.4

Timings for 133 MHz 

`define tcyc	#7.5
`define tkh	#3.0
`define tkl	#3.0
`define tkhkh	#(3.38:3.6:3.9)
`define tkhch	#(0.0:1.6:3.5)
`define tco	#0.4
`define tdoh	#0.4
`define tccqo   #0.38
`define tcqoh   #0.38
`define tsa	0.7
`define tsc	0.7
`define tsd	0.7
`define tha	0.7
`define thc	0.7
`define thd	0.7
`define tclz	0.4
`define tchz	#0.4
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

module cyqdr2_b2(TCK, TMS, TDI, TDO, D, Q, A, K, K_n, C, C_n, RPS_n, WPS_n, BW0_n, BW1_n, BW2_n, BW3_n, CQ, CQ_n, ZQ, DOFF);

input 			TCK, TMS, TDI;
output			TDO;

input	[`wordsize:0] 	D;

input 			K, K_n, C, C_n,	// Clock inputs 
			RPS_n, 		// Read Port Select
			WPS_n,		// Write Port Select
			BW0_n, BW1_n, BW2_n, BW3_n,	// Byte Write Select
			ZQ,		// Programmable Impedance Pin
			DOFF;		// Internal DLL Off Pin

input 	[17:0] 		A;		// Address bus

inout			CQ, CQ_n;	// Echo Clock Out

inout [`wordsize:0]	Q;

// wire BW0_n_o, BW1_n_o;	//Previous Copy of BWS0 and BWS1

wire[17:0] A;       	// address input bus

reg[17:0] Read_Address, Read_Address_o, Read_Address_o_o, Write_Address;

reg 		notifier;	// error support reg's
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

reg[35:0] temp_reg;

reg[35:0] mem1 [0:`no_words];	// First Array
reg[35:0] mem2 [0:`no_words]; // Second Array

reg [`wordsize :0] Data_in1, Data_in2; //Temporary location to hold data before being written into array

reg Set_CQ_Rise_Flag1, Set_CQ_n_Rise_Flag1, Set_CQ_Rise_Flag2, Set_CQ_n_Rise_Flag2, Set_CQ_Fall_Flag1, Set_CQ_n_Fall_Flag1, Set_CQ_Fall_Flag2, Set_CQ_n_Fall_Flag2, Setter;

integer Count;

reg Byte_write_din1_0, Byte_write_din1_1, Byte_write_din2_0, Byte_write_din2_1;
reg Byte_write_din1_2, Byte_write_din1_3, Byte_write_din2_2, Byte_write_din2_3;

reg rpen_o_o, rpen_o, rpen;
reg wpen, wpen_o;

reg echo_on;
real tcqh,tk1,tk2,text_cyc;
reg [35:0] Data_out;

reg update_clk,setter_clk, datahold_clk, echo_clk, echo_clkb, echoclk_hold_clk;

wire IoutClk = Setter ? C: K;
wire IoutClkb = Setter ? C_n: K_n;

// ********** JTAG signals..... ************

reg[3:0] state, prev_state;
reg[2:0] reg_flag;
reg[2:0] instr;
reg	 extest_en;		// Signal designed to indicate when an EXTEST instruction is entered -- active high
reg	 samplz_en;		// Singal designed to indicate when an SAMPLZ instruction is entered -- active high
reg	 extest_oe;		// Controls the output pins during EXTEST. low: high-z, high: enable
reg[31:0] vendor_code;
reg[37:0] preload;

reg chip_oe;		// chip data out tristate control -- low: high-z high: output enable
reg tdo_tristate;		// tdo disable pin -- Controls the state of the tdo pin -- low enable
reg tdo;			// Internal tdo pin
reg shift_out;
integer i;

wire [`wordsize:0]  chip_out =  chip_oe ?  Data_out : 36'bz ;	// data bus coming out from the SRAM
wire cq_out = echo_on ? echo_clk : 1'bz;			// echo clock coming out from the SRAM
wire cqb_out = echo_on ? echo_clkb : 1'bz;			// echo clock coming out from the SRAM

wire TDO =  !tdo_tristate ?  tdo : 1'bz;	// Output TDO pin

// When EXTEST-enable is 0, the data output should use the chip data, when 1, the EXTEST data.
wire [35:0]pre_out = !extest_en ? chip_out[35:0] : preload[35:0];
wire CQ =  !extest_en ? cq_out : preload[36];
wire CQ_n = !extest_en ? cqb_out : preload[37];

// oe is the output enable for the entire chip. Controlled by extest_oe during EXTEST. Active HIGH.
wire oe = (!extest_en ? chip_oe : extest_oe) && !samplz_en;

// Output buffer logic  
wire[35:0] Q = !oe ? 36'bz : pre_out[35:0];

reg[2:0] ir_p, ir_s;	// Dual Instruction Registers (p=parallel-load, s=shift-load)
reg	 byp;		// Bypass Register
reg[31:0] dir;		// Device Identification Register -- parallel-loaded with Vendor_code during IDCODE instruction
reg[106:0] bsr;		// 107-bit boundary scan register.

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

	  echo_on	= 1;

	  Count		= -1;
	  Set_CQ_Rise_Flag1 = 0;
	  Set_CQ_n_Rise_Flag1 = 0; 
          Set_CQ_Rise_Flag2 = 0;
          Set_CQ_n_Rise_Flag2 = 0;
          Set_CQ_Fall_Flag1 = 0;
          Set_CQ_n_Fall_Flag1 = 0;
          Set_CQ_Fall_Flag2 = 0;
	  Set_CQ_n_Fall_Flag1 = 0;
end

//We create another internal clock, offset off K_n which can be used to do all updates

initial
begin
	chip_oe = 0;
	update_clk = 0;
	setter_clk = 0;
end
always @(K)
begin
	tk2=tk1;
        tk1=$realtime;
        text_cyc=tk1-tk2;
        //tcqh = text_cyc - `tclz;
end
always @(K_n)
	`tdly update_clk = K_n;

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

always @(IoutClk)
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
	$display("NOTICE      : 020 : Address bus corruption on Clkb");
end

always @(noti2_0)
begin
	$display("NOTICE      : 020 : BWS0 problem on CLK");
end

always @(noti2_1)
begin
	$display("NOTICE      : 020 : BWS1 problem on CLK_n");
end

always @(noti2_2)
begin
	$display("NOTICE      : 020 : BWS0 problem on CLK");
end

always @(noti2_3)
begin
	$display("NOTICE      : 020 : BWS1 problem on CLK_n");
end

always @(noti3_1)
begin
	$display("NOTICE      : 011 : RPS problem on Clk");
end

always @(noti3_1)
begin
	$display("NOTICE      : 012 : WPS problem on Clk");
end

always @(noti4_0)
begin
	$display("NOTICE      : 013 : D problem on Clk");
end

always @(noti4_1)
begin
	$display("NOTICE      : 014 : D problem on Clkb");
end

// This process is to update the clocks

always @(posedge K)
begin
	if(Count < 2) Count = Count +1;
end	

// The next process is to check if the clocks are in single clock mode or multi
// clock mode

always @(posedge K & Count < 2)
begin
	if (Count == 0)
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

	if(Count == 1)
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

// This process is to check if the clocks are in single clock mode or
// multi clock mode

always @(negedge K & Count < 2)
begin
	if (Count == 0)
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

	if(Count == 1)
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

// Now use the information provided above and change the CQ clock

always @(negedge setter_clk)
begin

if ((Set_CQ_Rise_Flag1 == 1) & (Set_CQ_Rise_Flag2 == 1) & (Set_CQ_Fall_Flag1 == 0) & (Set_CQ_Fall_Flag2 == 0)  & Count == 1)
	begin
		Setter = 1;
	end

else if ((Set_CQ_Rise_Flag1 == 0) & (Set_CQ_Rise_Flag2 == 0) & (Set_CQ_Fall_Flag1 == 1) & (Set_CQ_Fall_Flag2 == 1) & Count == 1)
	begin
		Setter = 1;
	end
else if (Count == 1)
	begin
		Setter = 0;
	end
end

// This assignment should allow us to look at RP on the next rising edge, without any changes

always @(negedge IoutClk)
begin
	if (rpen_o == 0)
		chip_oe = `tchz 1;
	else
		chip_oe = `tchz 0;
end

always @(datahold_clk)
begin
	if(chip_oe == 1) Data_out = 18'bz;
end

always @(posedge K)
begin
	wpen_o = WPS_n;
	rpen_o_o = rpen_o;
	rpen_o = rpen;
	rpen   = RPS_n;
	Read_Address_o_o = Read_Address_o;
	Read_Address_o = Read_Address;
	if (RPS_n == 0)
		Read_Address = A;
end

always @(posedge K_n)
begin
	Write_Address = A;
end

always @(posedge echo_clk)
begin
	if (rpen_o_o == 0)
		Data_out =  mem2[Read_Address_o_o];
end

always @(posedge echo_clkb)
begin
	if (rpen_o == 0)
		Data_out =  mem1[Read_Address_o];
end

always @(posedge update_clk)
begin
	if (wpen_o == 0)
	begin
		if (Byte_write_din1_0 == 0)
		begin
			temp_reg = mem1[Write_Address];
			temp_reg[8:0] = Data_in1[8:0];
			mem1[Write_Address] = temp_reg;
		end
		if (Byte_write_din1_1 == 0)
		begin
			temp_reg = mem1[Write_Address];
			temp_reg[17:9] = Data_in1[17:9];
			mem1[Write_Address] = temp_reg;
		end
		if (Byte_write_din1_2 == 0)
		begin
			temp_reg = mem1[Write_Address];
			temp_reg[26:18] = Data_in1[26:18];
			mem1[Write_Address] = temp_reg;
		end
		if (Byte_write_din1_3 == 0)
		begin
			temp_reg = mem1[Write_Address];
			temp_reg[35:27] = Data_in1[35:27];
			mem1[Write_Address] = temp_reg;
		end

		if (Byte_write_din2_0 == 0)
		begin
			temp_reg = mem2[Write_Address];
			temp_reg[8:0] = Data_in2[8:0];
			mem2[Write_Address] = temp_reg;
		end
		if (Byte_write_din2_1 == 0)
		begin
			temp_reg = mem2[Write_Address];
			temp_reg[17:9] = Data_in2[17:9];
			mem2[Write_Address] = temp_reg;
		end
		if (Byte_write_din2_2 == 0)
		begin
			temp_reg = mem2[Write_Address];
			temp_reg[26:18] = Data_in2[26:18];
			mem2[Write_Address] = temp_reg;
		end
		if (Byte_write_din2_3 == 0)
		begin
			temp_reg = mem2[Write_Address];
			temp_reg[35:27] = Data_in2[35:27];
			mem2[Write_Address] = temp_reg;
		end
	end
end

always @(posedge K)
begin
	Byte_write_din1_0 <= BW0_n;
	Byte_write_din1_1 <= BW1_n;
	Byte_write_din1_2 <= BW2_n;
	Byte_write_din1_3 <= BW3_n;
	Data_in1 <= D;
end

always @(posedge K_n)
begin
	Byte_write_din2_0 <= BW0_n;
	Byte_write_din2_1 <= BW1_n;
	Byte_write_din2_2 <= BW2_n;
	Byte_write_din2_3 <= BW3_n;
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
	vendor_code = 32'b00011010011010100101000001101001;	// IDCODE for QDR2 CY7C1314AV18 device. This may not be changed.
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
						bsr[52] = RPS_n;
						bsr[53] = BW1_n;
						bsr[54] = BW0_n;
						bsr[55] = K;
						bsr[56] = K_n;
						bsr[57] = BW3_n;
						bsr[58] = BW2_n;
						bsr[59] = WPS_n;
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

specify
// specify the setup and hold checks


$setuphold(posedge K, BW0_n,  `tsc, `thc, noti2_0);
$setuphold(posedge K, BW1_n, `tsc, `thc, noti2_1);
$setuphold(posedge K_n, BW0_n,  `tsc, `thc, noti2_2);
$setuphold(posedge K_n, BW1_n, `tsc, `thc, noti2_3);

$setuphold(posedge K, RPS_n,  `tsc, `thc, noti3_0);
$setuphold(posedge K, WPS_n, `tsc, `thc, noti3_1);

$setuphold(negedge K, D,  `tsd, `thd, noti4_0);
$setuphold(posedge K_n, D, `tsd, `thd, noti4_1);

$setuphold(posedge K, A, `tsa, `tha, noti1_0);
$setuphold(posedge K_n, A, `tsa, `tha, noti1_1);

endspecify

endmodule
