// This model is the property of Cypress Semiconductor Corp and is protected 
// by the US copyright laws, any unauthorized copying and distribution is prohibited.
// Cypress reserves the right to change any of the functional specifications without
// any prior notice.
// Cypress is not liable for any damages which may result from the use of this 
// functional model.
//
//  
//	Model:	CY7C1305AV25
// 	Date:		March 22, 2004
//
//	Revision:	1.0
//
//	Contact:	MPD Applications
//			www.cypress.com/support
//			MPD New Product Development
//			Cypress Semiconductor, San Jose, CA 
//		
// 	Comments:	This is a functional model and does not replicate the actual functioning of the
//			device with all the timings. Select the timing bin which you use from the big table 
//			below
//	Revision Hisory
//	Rev 1.0-	Model Created
`timescale  1ns /  10ps
//
//	NOTE :	Any setup/hold errors will force input signal to x state
//		or if results indeterninant (write addr) core is reset x
// define fixed values

`define wordsize (18 -1) //Size of the data bus to be defined
`define no_words (262144 -1)		// 4 arrays of 256K x 18 RAM

/* Timings added for a 200 Mhz. Operation

`define tcyc	#5
`define tkh	#2.0
`define tkl	#2.0
`define tkhkh	#(2.4:2.5:2.6)
`define tkhch	#(0.0:0.75:1.5)
`define tco	#2.3
`define tdoh	#0.8
`define tsa	0.6
`define tsc	0.6
`define tsd	0.6
`define tha	0.6
`define thc	0.6
`define thd	0.6
`define tchz	#2.3
`define tclz	#0.8

`define tdly	#0.3
*/

// Timings added for a 167 Mhz. Operation

`define tcyc	#6
`define tkh	#2.4
`define tkl	#2.4
`define tkhkh	#(2.7:3.0:3.3)
`define tkhch	#(0.0:1.0:2.0)
`define tco	#2.5
`define tdoh	#1.2
`define tsa	0.7
`define tsc	0.7
`define tsd	0.7
`define tha	0.7
`define thc	0.7
`define thd	0.7
`define tchz	#2.5
`define tclz	#1.2

`define tdly	#0.3


/* Numbers added for a 133 Mhz. Operation
`define tcyc	#7.5
`define tkh	#3.2
`define tkl	#3.2
`define tkhkh	#(3.4:3.7:4.1)
`define tkhch	#(0.0:1.0:2.5)
`define tco	#3.0
`define tdoh	#1.2
`define tsa	0.8
`define tsc	0.8
`define tsd	0.8
`define tha	0.8
`define thd	0.8
`define thc	0.8
`define tchz	#3.0
`define tclz	#1.2

`define tdly #3

*/

/* Numbers added for a 100 Mhz. Operation
`define tcyc	#10
`define tkh	#3.5
`define tkl	#3.5
`define tkhkh	#(4.4:5.0:5.4)
`define tkhch	#(0.0:1.5:3.0)
`define tco	#3.0
`define tdoh	#1.2
`define tsa	1
`define tsc	1
`define tsd	1
`define tha	1
`define thc	1
`define thd	1
`define tchz	#3.0
`define tclz	#1.2

`define tdly    #4

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





module cy1305( TCK,TMS,TDI,TDO,D, Q, A, K, Kb, RPSb, WPSb, BWS0b, BWS1b, C, Cb,ZQ); 


input 			TCK, TMS, TDI;
output			TDO;

input	[`wordsize:0] 	D;

input 			K, Kb,	// clock inputs 
			RPSb, 		// Read Port Select
			WPSb,		// Write Port Select
			ZQ,
			BWS0b, BWS1b ;	// Byte Write Select

input 	[17:0] 		A;		// address busses

input			C, Cb;   
inout [`wordsize:0]	Q;



wire BWS0b_o, BWS1b_o ;	//Previous Copy of BWS0,BWS1
wire [17:0] A;       	// address input bus
reg [17:0] Read_Address, Read_Address_o,Read_Address_o_o,Read_Address_o_o_o, Write_Address, Write_Address_o, Write_Address_o_o, Write_Address_o_o_o;
reg tristate;		// Signal to tristate the output, when no read is being done
reg rpen_o_o_o, rpen_o_o,rpen_o, rpen;
reg wpen, wpen_o,wpen_o_o,wpen_o_o_o;

// ********** JTAG signals..... ************

reg[3:0] state, prev_state;
reg[2:0] reg_flag;
reg[2:0] instr;
reg	 extest_en;		// Signal designed to indicate when an EXTEST instruction is entered -- active high
reg	 samplz_en;		// Singal designed to indicate when an SAMPLZ instruction is entered -- active high
reg	 extest_oe;		// Controls the output pins during EXTEST. low: high-z, high: enable
reg[31:0] vendor_code;
reg[17:0] preload;

reg tdo_tristate;		// tdo disable pin -- Controls the state of the tdo pin -- low enable
reg tdo;			// Internal tdo pin
reg shift_out;
integer i;
reg [17:0] Data_out;

wire TDO =  !tdo_tristate ?  tdo : 1'bz;	// Output TDO pin
wire [`wordsize:0]  chip_out =  !tristate ?  Data_out : 18'bz ;	// data bus

// When EXTEST-enable is 0, the data output should use the chip data, when 1, the EXTEST data.
wire [17:0]pre_out = !extest_en ? chip_out[17:0] : preload[17:0];


// oe is the output enable for the entire chip. Controlled by extest_oe during EXTEST. Active HIGH.
wire oe = (!extest_en ? tristate : extest_oe) && !samplz_en;

// Output buffer logic  
wire[17:0] Q = oe ? 18'bz : pre_out[17:0];

reg[2:0] ir_p, ir_s;	// Dual Instruction Registers (p=parallel-load, s=shift-load)
reg	 byp;		// Bypass Register
reg[31:0] dir;		// Device Identification Register -- parallel-loaded with Vendor_code during IDCODE instruction
reg[106:0] bsr;		// 107-bit boundary scan register.

reg 		notifier;	// error support reg's
reg 		noti1_0;
reg		noti1_1;
reg 		noti2_0;
reg 		noti2_1;
reg 		noti2_2;
reg 		noti2_3;
reg 		noti2_4;
reg 		noti2_5;
reg 		noti2_6;
reg 		noti2_7;
reg 		noti3_0;
reg 		noti3_1;
reg 		noti4_0;
reg 		noti4_1;


reg [17:0] temp_reg,temp1,temp2;

reg  [17:0] mem1 [0:`no_words];	// First Array
reg  [17:0] mem2 [0:`no_words]; // Second Array
reg  [17:0] mem3 [0:`no_words]; // thrid Array
reg  [17:0] mem4 [0:`no_words]; // fourth Array

reg [`wordsize :0] Data_in1, Data_in2; //Temporary location to hold data before being written into array



reg Byte_write_din1_l, Byte_write_din1_h, Byte_write_din2_l, Byte_write_din2_h;
reg Byte_write_din1_l_o, Byte_write_din1_h_o, Byte_write_din2_l_o, Byte_write_din2_h_o;
reg Byte_write_din1_l_o_o, Byte_write_din1_h_o_o, Byte_write_din2_l_o_o, Byte_write_din2_h_o_o;
reg Byte_write_din1_l1, Byte_write_din1_h1, Byte_write_din2_l1, Byte_write_din2_h1;
reg Byte_write_din1_l1_o, Byte_write_din1_h1_o, Byte_write_din2_l1_o, Byte_write_din2_h1_o;
reg Byte_write_din1_l1_o_o, Byte_write_din1_h1_o_o, Byte_write_din2_l1_o_o, Byte_write_din2_h1_o_o;


wire [`wordsize:0]  Dout =  !tristate ?  Data_out : 18'bz ;	// data bus

reg Set_CQ_Rise_Flag1, Set_CQb_Rise_Flag1, Set_CQ_Rise_Flag2, Set_CQb_Rise_Flag2, Set_CQ_Fall_Flag1, Set_CQb_Fall_Flag1, Set_CQ_Fall_Flag2, Set_CQb_Fall_Flag2, Setter;

integer Count;

reg update_clk,setter_clk, Clocks_in_Sync;

wire IoutClk = Setter ? C : K;
wire IoutClkb = Setter ? Cb: Kb;


initial
	begin

// error signals 

	  notifier 	= 0;
	  noti1_0	= 0;
	  noti1_1	= 0;
	  noti2_0	= 0;
	  noti2_1	= 0;
	  noti3_0	= 0;
	  noti3_1	= 0;
	  noti4_0	= 0;
	  noti4_1	= 0;  
	  Count		= -1;
	  Set_CQ_Rise_Flag1 = 0;
	  Set_CQb_Rise_Flag1 = 0; 
          Set_CQ_Rise_Flag2 = 0;
          Set_CQb_Rise_Flag2 = 0;
          Set_CQ_Fall_Flag1 = 0;
          Set_CQb_Fall_Flag1 = 0;
          Set_CQ_Fall_Flag2 = 0;
	  Set_CQb_Fall_Flag1 = 0;
	
	  rpen_o = 1;
	  rpen_o_o = 1;
	  rpen_o_o_o = 1;

	  wpen_o = 1;
	  wpen_o_o = 1;
	  wpen_o_o_o = 1;



end

//We create another internal clock, offset off clkb which can be used to do all updations

initial
begin
tristate = 1;
update_clk = 0;
setter_clk = 0;
end

always @(Kb)
 `tdly update_clk = Kb;


always @(K)
 `tdly setter_clk = K;

//	***	SETUP / HOLD VIOLATIONS		***




always @(noti1_0)
begin
$display("NOTICE      : 020 : Address bus corruption on K");
 
end

always @(noti1_1)
begin
$display("NOTICE      : 020 : Address bus corruption on Kb");
  
end

always @(noti2_0)
begin
$display("NOTICE      : 020 : BWS0 problem on K");
  end

always @(noti2_1)
begin
$display("NOTICE      : 020 : BWS1 problem on K");
end

always @(noti2_4)
begin
$display("NOTICE      : 020 : BWS0 problem on Kb");
  end

always @(noti2_5)
begin
$display("NOTICE      : 020 : BWS1 problem on Kb");
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

// Add the following
// Check for the output clocks to be turned off or on
// Check for the output clock to be skewed from the input clock

// The next process is to check if the clocks are in single clock mode or multi 
// clock mode

always @(posedge K)
begin

if(Count < 2)
Count = Count +1;

end



always @(posedge K & Count < 2)
begin

	if (Count == 0)
	begin
		if (C == 1) 
			Set_CQ_Rise_Flag1 = 1;
		else
			Set_CQ_Rise_Flag1 = 0;

		if (Cb == 0) 
			Set_CQb_Rise_Flag1 = 1;
		else
			Set_CQb_Rise_Flag1 = 0;
	
	end

	if(Count == 1)
	begin
		if (C == 1) 
			Set_CQ_Rise_Flag2 = 1;
		else
			Set_CQ_Rise_Flag2 = 0;

		if (Cb == 0) 
			Set_CQb_Rise_Flag2 = 1;
		else
			Set_CQb_Rise_Flag2 = 0;

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

		if (Cb == 0) 
			Set_CQb_Fall_Flag1 = 1;
		else
			Set_CQb_Fall_Flag1 = 0;
	
	end

	if(Count == 1)
	begin
		if (C == 1) 
			Set_CQ_Fall_Flag2 = 1;
		else
			Set_CQ_Fall_Flag2 = 0;

		if (Cb == 0) 
			Set_CQb_Fall_Flag2 = 1;
		else
			Set_CQb_Fall_Flag2 = 0;

	end

end
// Now use the information provided above and change the C clock

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

// Now for checking if the input clock and the Iout clock are skewed
//

always @(posedge K)
begin
	if (Count == 3 & Setter == 1)
		Clocks_in_Sync = 1;
	else if (IoutClk == 1) 
		Clocks_in_Sync = 1;
	else if (IoutClk == 0) 
		Clocks_in_Sync = 0;


end


// This assignment should allow us to look at RP on the next rising edge, without any changes

// We also need to look at the past and present conditions of read/write port selct to complete read/write blocking


always @(posedge K)
begin

rpen_o_o_o = rpen_o_o;
rpen_o_o = rpen_o;

 if (rpen_o == 0) 
  begin
   rpen_o = 1;
  end
 else
   begin
   rpen_o = RPSb;
  end

 
 wpen_o_o_o = wpen_o_o;
 wpen_o_o = wpen_o;

if (wpen_o == 0) 
 begin
  wpen_o = 1;
 end
 else if((RPSb == 0 && rpen_o_o == 0) || RPSb != 0 )
 begin  
  wpen_o = WPSb;
  end 
else
  begin
  wpen_o = 1;
  end

end



always @(negedge update_clk)
begin
	if (rpen_o_o == 0 || rpen_o_o_o == 0)
	begin
		tristate = `tchz 0;
	end
	else
	begin
		tristate = `tchz 1;
	end    

end


always @(posedge K)
begin
	Read_Address_o_o = Read_Address_o;

	Read_Address_o = Read_Address;

	Read_Address = A;
     
    

	end 

always @(posedge K) 
begin
Write_Address_o_o = Write_Address_o;
	Write_Address_o = Write_Address;
	Write_Address = A;

	
end



always @(posedge IoutClk)
begin
	if(Clocks_in_Sync == 1)
	begin
		if (rpen_o_o == 0)
		begin 
			Data_out = `tco  mem1[Read_Address_o] ;
			temp1 = mem1[Read_Address];
		end
	
		if (rpen_o_o_o == 0)
		begin
			Data_out = `tco mem3[Read_Address_o_o];
		end
	end
	else
	begin

		if(rpen_o_o == 0)
		begin 
			Data_out = `tco  mem1[Read_Address_o] ;
		end
	
		if (rpen_o_o_o == 0)
		begin
			Data_out = `tco mem3[Read_Address_o_o];
		end

	end
end

// This process is to pump out the data on the rising edge of CQb


always @(posedge IoutClkb)
begin
	if(Clocks_in_Sync == 1)
	begin
		if (rpen_o_o == 0)
        	begin	
			Data_out =  `tco mem2[Read_Address_o];
		end

		if (rpen_o_o_o == 0)
  		begin	
			Data_out = `tco mem4[Read_Address_o_o]; 
		end	

	end
	else
	begin 
		if (rpen_o_o == 0)
        	begin	
			Data_out =  `tco mem2[Read_Address_o];
		end

		if (rpen_o_o_o == 0)
  		begin	
			Data_out = `tco mem4[Read_Address_o_o]; 
		end	
	end
end

always @(posedge update_clk)
begin
	if (wpen_o_o == 0)
	begin
		if (Byte_write_din1_l == 0) 
		begin
		      temp_reg = mem1[Write_Address_o];
			temp_reg[8:0] = Data_in1[8:0];
			mem1[Write_Address_o] = temp_reg;
			
		end
		if(Byte_write_din1_h == 0) 
		begin
			temp_reg = mem1[Write_Address_o];
			temp_reg[17:9] = Data_in1[17:9];
			mem1[Write_Address_o] = temp_reg;
		end
		
		if (Byte_write_din2_l == 0) 
		begin
			temp_reg = mem2[Write_Address_o];
			temp_reg[8:0] = Data_in2[8:0];
			mem2[Write_Address_o] = temp_reg;
		end
		if(Byte_write_din2_h == 0) 
		begin
			temp_reg = mem2[Write_Address_o];
			temp_reg[17:9] = Data_in2[17:9];
			mem2[Write_Address_o] = temp_reg;
		end
	end

      if(wpen_o_o_o == 0)
	begin
		if (Byte_write_din1_l == 0) 
		begin
			temp_reg = mem3[Write_Address_o_o];
			temp_reg[8:0] = Data_in1[8:0];
			mem3[Write_Address_o_o] = temp_reg;
		end
		if(Byte_write_din1_h == 0) 
		begin
			temp_reg = mem3[Write_Address_o_o];
			temp_reg[17:9] = Data_in1[17:9];
			mem3[Write_Address_o_o] = temp_reg;
		end
		

		if (Byte_write_din2_l == 0) 
		begin
			temp_reg = mem4[Write_Address_o_o];
			temp_reg[8:0] = Data_in2[8:0];
			mem4[Write_Address_o_o] = temp_reg;
		end
		if(Byte_write_din2_h == 0) 
		begin
			temp_reg = mem4[Write_Address_o_o];
			temp_reg[17:9] = Data_in2[17:9];
			mem4[Write_Address_o_o] = temp_reg;
		end
	end


end

always @(posedge K)
begin
	Byte_write_din1_l_o_o = Byte_write_din1_l_o;
	Byte_write_din1_h_o_o = Byte_write_din1_h_o;
   

	Byte_write_din1_l_o = Byte_write_din1_l;
	Byte_write_din1_h_o = Byte_write_din1_h;


      Byte_write_din1_l <= BWS0b;
	Byte_write_din1_h <= BWS1b;
   


	Data_in1 <= D;  

end

always @(posedge  Kb)
begin
	Byte_write_din2_l_o_o = Byte_write_din2_l_o;
	Byte_write_din2_h_o_o = Byte_write_din2_h_o;
    


	Byte_write_din2_l_o = Byte_write_din2_l;
	Byte_write_din2_h_o = Byte_write_din2_h;



      Byte_write_din2_l <= BWS0b;
	Byte_write_din2_h <= BWS1b;
  
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
	vendor_code = 32'b00001011010011010101000001101001;	// IDCODE for QDR CY7C1305AV25 device. This may not be changed.
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
						preload[9] = bsr[65];
						preload[10] = bsr[69];
						preload[11] = bsr[73];
						preload[12] = bsr[77];
						preload[13] = bsr[81];
						preload[14] = bsr[85];
						preload[15] = bsr[89];
						preload[16] = bsr[93];
						preload[17] = bsr[97];
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
						bsr[0] = Cb;
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
						bsr[11] = 1'b0;
						bsr[12] = 1'b0;
						bsr[13] = Q[1];
						bsr[14] = D[1];
						bsr[15] = 1'b0;
						bsr[16] = 1'b0;
						bsr[17] = Q[2];
						bsr[18] = D[2];
						bsr[19] = 1'b0;
						bsr[20] = 1'b0;
						bsr[21] = Q[3];
						bsr[22] = D[3];
						bsr[23] = 1'b0;
						bsr[24] = 1'b0;
						bsr[25] = Q[4];
						bsr[26] = D[4];
						bsr[27] = ZQ;
						bsr[28] = 1'b0;
						bsr[29] = 1'b0;
						bsr[30] = Q[5];
						bsr[31] = D[5];
						bsr[32] = 1'b0;
						bsr[33] = 1'b0;
						bsr[34] = Q[6];
						bsr[35] = D[6];
						bsr[36] = 1'b0;
						bsr[37] = 1'b0;
						bsr[38] = Q[7];
						bsr[39] = D[7];
						bsr[40] = 1'b0;
						bsr[41] = 1'b0;
						bsr[42] = Q[8];
						bsr[43] = D[8];
						bsr[44] = 1'b0;
						bsr[45] = 1'b0;
						bsr[46] = 1'b0;
						bsr[47] = extest_oe;
						bsr[48] = A[7];
						bsr[49] = A[8];
						bsr[50] = A[9];
						bsr[51] = 1'b0;
						bsr[52] = RPSb;
						bsr[53] = 1'b0;
						bsr[54] = BWS0b;
						bsr[55] = K;
						bsr[56] = Kb;
						bsr[57] = 1'b0;
						bsr[58] = BWS1b;
						bsr[59] = WPSb;
						bsr[60] = A[10];
						bsr[61] = A[11];
						bsr[62] = 1'b0;
						bsr[63] = 1'b0;
						bsr[64] = 1'b0;
						bsr[65] = Q[9];
						bsr[66] = D[9];
						bsr[67] = 1'b0;
						bsr[68] = 1'b0;
						bsr[69] = Q[10];
						bsr[70] = D[10];
						bsr[71] = 1'b0;
						bsr[72] = 1'b0;
						bsr[73] = Q[11];
						bsr[74] = D[11];
						bsr[75] = 1'b0;
						bsr[76] = 1'b0;
						bsr[77] = Q[12];
						bsr[78] = D[12];
						bsr[79] = 1'b0;
						bsr[80] = 1'b0;
						bsr[81] = Q[13];
						bsr[82] = D[13];
						bsr[83] = 1'b0;
						bsr[84] = 1'b0;
						bsr[85] = Q[14];
						bsr[86] = D[14];
						bsr[87] = 1'b0;
						bsr[88] = 1'b0;
						bsr[89] = Q[15];
						bsr[90] = D[15];
						bsr[91] = 1'b0;
						bsr[92] = 1'b0;
						bsr[93] = Q[16];
						bsr[94] = D[16];
						bsr[95] = 1'b0;
						bsr[96] = 1'b0;
						bsr[97] = Q[17];
						bsr[98] = D[17];
						bsr[99] = 1'b0;
						bsr[100] = 1'b0;
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


$setuphold(posedge K, BWS0b,  `tsc, `thc, noti2_0);
$setuphold(posedge K, BWS1b, `tsc, `thc, noti2_1);
$setuphold(posedge Kb, BWS0b,  `tsc, `thc, noti2_4);
$setuphold(posedge Kb, BWS1b, `tsc, `thc, noti2_5);
$setuphold(posedge K, RPSb,  `tsc, `thc, noti3_0);
$setuphold(posedge K, WPSb, `tsc, `thc, noti3_1);

$setuphold(negedge K, D,  `tsd, `thd, noti4_0);
$setuphold(posedge Kb, D, `tsd, `thd, noti4_1);

$setuphold(posedge K, A, `tsa, `tha, noti1_0);
$setuphold(posedge Kb, A, `tsa, `tha, noti1_1);


endspecify


endmodule

