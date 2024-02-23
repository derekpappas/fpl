// This model is the property of Cypress Semiconductor Corp and is protected 
// by the US copyright laws, any unauthorized copying and distribution is prohibited.
// Cypress reserves the right to change any of the functional specifications without
// any prior notice.
// Cypress is not liable for any damages which may result from the use of this 
// functional model.
//
//  
//	Model:		CY7C1302
// 	Date:		November 2, 1999	
//
//	Revision:	2.5
//
//	Contact:	Rajesh Manapat
//			Ph#: (408)-432-7064
//			e-mail: mpr@cypress.com
//			MPD/MTI New Product Development
//			Cypress Semiconductor, San Jose, CA 
//		
// 	Comments:	This is a functional model and does not replicate the actual functioning of the
//			device with all the timings. Select the timing bin which you use from the big table 
//			below

// Revision History
//	Revision	1.0(7/9/99)-mpr 	-	New Model
//	Revision	1.1(07/xx/99)-mpr	-	Updates to some sections - fix byte enable problems
//	Revision	2.0(10/28/99)-mpr	-	Major Change - first two cycles are used to look
//							at CQ clock, if not available switch to main clock
//	Revision 	2.1(10/28/99)-mpr	-	Changed counter, so that count will stop at 2
//	Revision	2.2(11/2/99) - mpr	-	Fixed the fact that internally model was not addressing
//							the whole array
//	Revision	2.3(11/2/99) - mpr	-	Changed the update of old read address, pushed it out by 2.5 ns. 
//	Revision	2.4(12/7/99) - mpr	-	Changed the way update clock was generated. Tdly moved out
//	Revision	2.5(7/13/00) - mpr	- 	Changed the clock on which Byte writes are captured
//	Revision        2.6(12/12/00) - mpr     -       Changed the address statement to address 512K locations

`timescale  1ns /  10ps

//

//	NOTE :	Any setup/hold errors will force input signal to x state
//		or if results indeterninant (write addr) core is reset x

  
// define fixed values

`define wordsize (18 -1) //Size of the data bus to be defined
`define no_words (524288 -1)		// 512K x 18 RAM


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
`define tchz	#1.8
`define tclz	#1.2

`define tdly	#0.1


/* Numbers added for a 167 Mhz. Operation
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

`define tdly #0.1

*/

/* Numbers added for a 167 Mhz. Operation
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

`define tdly #0.1

*/




module cy1302( Din, Dout, A, Clk, Clkb, RPSb, WPSb, BWS0b, BWS1b, CQ, CQb); 



input	[`wordsize:0] 	Din;

input 			Clk, Clkb,	// clock inputs 
			RPSb, 		// Read Port Select
			WPSb,		// Write Port Select
			BWS0b, BWS1b;	// Byte Write Select

input 	[17:0] 		A;		// address busses

input			CQ, CQb;	// Echo Clock Out

output [`wordsize:0]	Dout;



wire BWS0b_o, BWS1b_o;	//Previous Copy of BWS0 and 


wire [17:0] A;       	// address input bus

reg [17:0] Read_Address, Read_Address_o, Write_Address;


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


reg [18:0] temp_reg;

reg  [17:0] mem1 [0:`no_words];	// First Array
reg  [17:0] mem2 [0:`no_words]; // Second Array

reg [`wordsize :0] Data_in1, Data_in2; //Temporary location to hold data before being written into array

reg Set_CQ_Rise_Flag1, Set_CQb_Rise_Flag1, Set_CQ_Rise_Flag2, Set_CQb_Rise_Flag2, Set_CQ_Fall_Flag1, Set_CQb_Fall_Flag1, Set_CQ_Fall_Flag2, Set_CQb_Fall_Flag2, Setter;

//reg IOutClk, IOutClkb; 

integer Count;

reg tristate;		// Signal to tristate the output, when no read is being done

reg Byte_write_din1_l, Byte_write_din1_h, Byte_write_din2_l, Byte_write_din2_h;

reg rpen_o, rpen;
reg wpen, wpen_o;

reg [17:0] Data_out;

wire [`wordsize:0]  Dout =  !tristate ?  Data_out : 18'bz ;	// data bus

reg update_clk,setter_clk;

wire IoutClk = Setter ? CQ : Clk;
wire IoutClkb = Setter ? CQb: Clkb;

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

	  Count		= -1;
	  Set_CQ_Rise_Flag1 = 0;
	  Set_CQb_Rise_Flag1 = 0; 
          Set_CQ_Rise_Flag2 = 0;
          Set_CQb_Rise_Flag2 = 0;
          Set_CQ_Fall_Flag1 = 0;
          Set_CQb_Fall_Flag1 = 0;
          Set_CQ_Fall_Flag2 = 0;
	  Set_CQb_Fall_Flag1 = 0;
          tristate = 1;
          update_clk     = 0;
          setter_clk = 0;

// Initialize all the memory locations to 0
//
//
//	  for (i = 0; i <= `no_words; i = i + 1)
//		   mem[i] = `wordsize'b0;
//
end

//We create another internal clock, offset off clkb which can be used to do all updations

always @Clkb
`tdly
update_clk = Clkb;

always @Clk
`tdly
setter_clk =  Clk;

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
$display("NOTICE      : 020 : BWS1 problem on CLKb");
end

always @(noti2_2)
begin
$display("NOTICE      : 020 : BWS0 problem on CLK");
 end

always @(noti2_3)
begin
$display("NOTICE      : 020 : BWS1 problem on CLKb");
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
$display("NOTICE      : 013 : Din problem on Clk");
  end

always @(noti4_1)
begin
$display("NOTICE      : 014 : Din problem on Clkb");
 end

//always @(Clkb)

//if (Clkb == 1)
//update_clk = `tdly Clkb;
//else
//update_clk = `tdly 1'b0;

//end

//assign update_clk = `tdelay Clkb;

// This process is to update the clocks

always @(posedge Clk)
begin

if(Count < 2)
Count = Count +1;

end


// The next process is to check if the clocks are in single clock mode or multi 
// clock mode


always @(posedge Clk & Count < 2)
begin

	if (Count == 0)
	begin
		if (CQ == 1) 
			Set_CQ_Rise_Flag1 = 1;
		else
			Set_CQ_Rise_Flag1 = 0;

		if (CQb == 0) 
			Set_CQb_Rise_Flag1 = 1;
		else
			Set_CQb_Rise_Flag1 = 0;
	
	end

	if(Count == 1)
	begin
		if (CQ == 1) 
			Set_CQ_Rise_Flag2 = 1;
		else
			Set_CQ_Rise_Flag2 = 0;

		if (CQb == 0) 
			Set_CQb_Rise_Flag2 = 1;
		else
			Set_CQb_Rise_Flag2 = 0;

	end

end

// This process is to check if the clocks are in single clock mode or
// multi clock mode

always @(negedge Clk & Count < 2)
begin

	if (Count == 0)
	begin
		if (CQ == 1) 
			Set_CQ_Fall_Flag1 = 1;
		else
			Set_CQ_Fall_Flag1 = 0;

		if (CQb == 0) 
			Set_CQb_Fall_Flag1 = 1;
		else
			Set_CQb_Fall_Flag1 = 0;
	
	end

	if(Count == 1)
	begin
		if (CQ == 1) 
			Set_CQ_Fall_Flag2 = 1;
		else
			Set_CQ_Fall_Flag2 = 0;

		if (CQb == 0) 
			Set_CQb_Fall_Flag2 = 1;
		else
			Set_CQb_Fall_Flag2 = 0;

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

always @(negedge update_clk)
begin
	if (rpen_o == 0)
	begin
		tristate = `tchz 0;
	end
	else
	begin
		tristate = `tchz 1;
	end    

end

always @(posedge update_clk)
begin

rpen_o = rpen;

end


always @(posedge Clk)
begin
	
	wpen_o = WPSb;
	rpen   = RPSb;
//	rpen_o = rpen;

end

always @(posedge Clk)
begin
Read_Address_o = Read_Address;
Read_Address = A;

end 

always @(posedge Clkb) 
begin
	Write_Address = A;
end



always @(posedge IoutClk)
begin
	if (rpen_o == 0)
	begin 
		Data_out = `tco  mem1[Read_Address_o] ;
		
	end

end

always @(posedge IoutClkb)
begin
	if (rpen_o == 0)
		Data_out =  `tco mem2[Read_Address_o];
	
end

always @(posedge update_clk)
begin
	if (wpen_o == 0)
	begin
		if (Byte_write_din1_l == 0 && Byte_write_din1_h == 1) 
		begin
			temp_reg = mem1[Write_Address];
			temp_reg[8:0] = Data_in1[8:0];
			mem1[Write_Address] = temp_reg;
		end
		else if (Byte_write_din1_l == 1 && Byte_write_din1_h == 0) 
		begin
			temp_reg = mem1[Write_Address];
			temp_reg[17:9] = Data_in1[17:9];
			mem1[Write_Address] = temp_reg;
		end
		else if (Byte_write_din1_l == 0 && Byte_write_din1_h == 0) 
		begin
		
			mem1[Write_Address] = Data_in1[17:0];
		
		end

		if (Byte_write_din2_l == 0 && Byte_write_din2_h == 1) 
		begin
			temp_reg = mem2[Write_Address];
			temp_reg[8:0] = Data_in2[8:0];
			mem2[Write_Address] = temp_reg;
		end
		else if (Byte_write_din2_l == 1 && Byte_write_din2_h == 0) 
		begin
			temp_reg = mem2[Write_Address ];
			temp_reg[17:9] = Data_in2[17:9];
			mem2[Write_Address] = temp_reg;
		end
		else if (Byte_write_din2_l == 0 && Byte_write_din2_h == 0) 
		begin
		
			mem2[Write_Address] = Data_in2[17:0];
		
		end
	end
end

always @(posedge Clk)
begin
	Byte_write_din1_l <= BWS0b;
	Byte_write_din1_h <= BWS1b;
	Data_in1 <= Din;  

end

always @(posedge Clkb)
begin
	Byte_write_din2_l <= BWS0b;
	Byte_write_din2_h <= BWS1b;
	Data_in2 <= Din;
end


specify
// specify the setup and hold checks


$setuphold(posedge Clk, BWS0b,  `tsc, `thc, noti2_0);
$setuphold(posedge Clk, BWS1b, `tsc, `thc, noti2_1);
$setuphold(posedge Clkb, BWS0b,  `tsc, `thc, noti2_2);
$setuphold(posedge Clkb, BWS1b, `tsc, `thc, noti2_3);

$setuphold(posedge Clk, RPSb,  `tsc, `thc, noti3_0);
$setuphold(posedge Clk, WPSb, `tsc, `thc, noti3_1);

$setuphold(negedge Clk, Din,  `tsd, `thd, noti4_0);
$setuphold(posedge Clkb, Din, `tsd, `thd, noti4_1);

$setuphold(posedge Clk, A, `tsa, `tha, noti1_0);
$setuphold(posedge Clkb, A, `tsa, `tha, noti1_1);


endspecify



endmodule
