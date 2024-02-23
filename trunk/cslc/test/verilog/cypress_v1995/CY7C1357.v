//************************************************************************
//**************************************************************************
//** This model is the property of Cypress Semiconductor Corp and is      **
//** protected by the US copyright laws, any unauthorized copying and     **
//** distribution is prohibited. Cypress reserves the right to change     ** 
//** any of the functional specifications without any prior notice.       ** 
//** Cypress is not liable for any damages which may result from the      **
//** use of this functional model.							  **
//**												  **
//** File Name	:   CY7C1357							  **
//**												  **
//** Revision	:   1.0 - New release(10/04/2002)				  **
//**									  			  **
//** The timings are to be selected by the user depending upon the 	  **
//** frequency of operation from the datasheet.					  **
//**									  			  **
//** This model is intended to serve the purpose of verifying the 	  **
//** funtionality. Only some of the timings are implemented.		  **
//**									  			  **
//** Model	:   CY7C1357 		- 512k x 18 NoBL Flowthrough SRAM	  **
//** Queries	:   MPD Applications					        **
//**		    e-mail: support@cypress.com			              ** 		
//**************************************************************************
//**************************************************************************

`timescale  1ns /  10ps

//NOTE :	Any setup/hold errors will force input signal to x state
//		or if results indeterminant (write addr) core is reset x
//NOTE : 	READ CYCLE OPERATES #0.01 AFTER CLOCK   	 
//	 	THEREFORE DELAYS HAVE TO TAKE THIS INTO ACCOUNT	 

// define fixed values

`define address_size (19)
`define wordsize (18)			//
`define no_words (524288)		// 512K x 18 RAM

module CY7C1357 ( d, clk, a, bws_b, we_b, adv_lb, ce1b, ce2, ce3b, oeb,
                cenb, mode);

inout	[`wordsize - 1:0] 	d;


input 		clk, 		// clock input (R)
			we_b, 	// byte write enable(L)
			adv_lb, 	// burst(H)/load(L) address
			ce1b, 	// chip enable(L)
			ce2, 		// chip enable(H)
			ce3b, 	// chip enable(L)
			oeb, 		// async output enable(L)(read)
			cenb,		// clock enable(L)
			mode;		// interleave(H)/linear(L) burst

input 	[1:0] 		bws_b;		// byte write select(L)

input 	[`address_size - 1:0] 		a;		// address bus

//	*** 	NOTE: READ CYCLE OPERATES #0.01 AFTER CLOCK   	***
//	*** THEREFORE DELAYS HAVE TO TAKE THIS INTO ACCOUNT	***

//************************************************************************
//**This model is configured for 66 MHz Operation. User
//**should change the below values for a different frequency of operation.
//************************************************************************
  `define thzoe #6
  `define tlzoe #0
  `define tchz #5
  `define tclz #3
  `define tco   #11.0
  `define tdoh  #1.5
  `define tas 1.5			 
  `define tah 0.5		
//************************************************************************	 

reg 		notifier;	// error support reg's
reg 		noti1_0;
reg 		noti1_1;
reg 		noti1_2;
reg 		noti1_3;
reg 		noti1_4;
reg 		noti1_5;
reg 		noti1_6;
reg 	 	noti2;

wire chipen;     	// combined chip enable (high for an active chip)

reg  chipen_d;		// _d = delayed
 
wire writestate;   	// holds 1 if any of writebus is low

wire loadcyc;        	// holds 1 for load cycles (setup and hold checks)
wire writecyc;     	// holds 1 for write cycles (setup and hold checks)
wire [1:0] bws_b;     	// holds the bws_b values

wire [1:0] writebusb; 	// holds the "internal" bws_b bus based on we_b
reg  [1:0] writebusb_o;

wire [2:0] operation;	// holds chipen, adv_ld and writestate
reg  [2:0] operation_o;

wire [`address_size - 1:0] a;       	// address input bus
reg  [`address_size - 1:0] a_o;

reg  [`wordsize - 1:0] do;      	// data  output reg
reg  [`wordsize - 1:0] di;      	// data   input bus

wire tristate;		// tristate output (on a bytewise basis) when asserted
reg  cetri;       	// register set by chip disable which sets the tristate 
reg  oetri;    		// register set by oe which sets the tristate
reg  enable;         	// register to make the ram enabled when equal to 1
reg  [`address_size - 1:0] addreg;   	// register to hold the input address

reg  [`wordsize - 1:0] mem [0:`no_words - 1];	// RAM array

reg  [`wordsize - 1:0] writeword;	// temporary holding register for the write data
reg  burstinit;    	// register to hold a[0] for burst type
integer i;  		// temporary register used to write to all mem locs.
reg  writetri;		// tristate
reg  lw, bw;		// pipelined write functions
reg  we_bl; 
wire nobyte_write;	//Gets asserted when the operation is write but bytes not asserted

wire [`wordsize - 1:0]  d =  !tristate ?  do[`wordsize - 1:0] : 18'bz ;	//  data bus

assign chipen 		= (adv_lb == 1 ) ? chipen_d :
                                ~ce1b & ce2 & ~ce3b ;

assign writestate 	= (~& writebusb) | ~nobyte_write;

assign nobyte_write     = (  we_b  ==0 & adv_lb ==0) ? 0:
                          (  we_b  ==1 & adv_lb ==0) ? 1:
                          (  we_bl ==0 & adv_lb ==1) ? 0:
                          (  we_bl ==1 & adv_lb ==1) ? 1:
                                                       1'bx;

assign operation 	= {chipen, adv_lb, writestate};

assign writebusb[1:0] 	= (  we_b  ==0 & adv_lb ==0) ? bws_b[1:0]:
                          (  we_b  ==1 & adv_lb ==0) ? 2'b11 :
                          (  we_bl ==0 & adv_lb ==1) ? bws_b[1:0]:
                          (  we_bl ==1 & adv_lb ==1) ? 2'b11 :
                                                       2'bxx ;

assign loadcyc 		= chipen & !cenb;

assign writecyc 	= writestate & enable & ~cenb & chipen; // check

assign tristate 	= cetri | writetri | oetri;

pullup    (mode); 

// initialize the output to be tri-stated, ram to be disabled

initial
	begin
// signals

	  writetri 	= 0;
	  cetri 	= 1;
	  enable 	= 0;
	  lw		= 0;
	  bw		= 0;

// error signals 

	  notifier 	= 0;
	  noti1_0	= 0;
	  noti1_1	= 0;
	  noti1_2	= 0;
	  noti1_3	= 0;
	  noti1_4	= 0;
	  noti1_5	= 0;
	  noti1_6	= 0;
	  noti2		= 0;  

end

// asynchronous OE

always @(oeb)
begin
  if (oeb == 1)
    oetri <= `thzoe 1;
  else
    oetri <= `tlzoe 0;
end

//	***	SETUP / HOLD VIOLATIONS		***
always @(notifier)
begin
  for (i = 0; i < `no_words; i = i + 1)
    mem[i] = 18'bx;
    $display("NOTICE      : 000 : Memory has been reset");
end

always @(noti2)
begin
$display("NOTICE      : 020 : Data bus    corruption");
    force d =18'bx;
    #1;
    release d;
end

always @(noti1_0)
begin
$display("NOTICE      : 010 : Byte write  corruption");
    force bws_b = 2'bx;
    #1;
    release bws_b;
end

always @(noti1_1)
begin
$display("NOTICE      : 011 : Byte enable corruption");
    force we_b = 1'bx;
    #1;
    release we_b;
end

always @(noti1_2)
begin
$display("NOTICE      : 012 : CE1B       corruption");
    force ce1b =1'bx;
    #1;
    release ce1b;
end

always @(noti1_3)
begin
$display("NOTICE      : 013 : CE2       corruption");
    force ce2 =1'bx;
    #1;
    release ce2;
end

always @(noti1_4)
begin
$display("NOTICE      : 014 : CE3B      corruption");
    force ce3b =1'bx;
    #1;
    release ce3b;
end

always @(noti1_5)
begin
$display("NOTICE      : 015 : CENB      corruption");
    force cenb =1'bx;
    #1;
    release cenb;
end

always @(noti1_6)
begin
$display("NOTICE      : 016 : ADV_LB   corruption");
    force adv_lb = 1'bx;
    #1;
    release adv_lb;
end

// synchronous functions from clk edge

always @(posedge clk)
 if (!cenb)
  begin
   // latch conditions on adv_lb
   if (adv_lb) 
      we_bl 		<=	we_bl;
   else
      we_bl 		<=	we_b;

      chipen_d		<=	chipen;  
      writebusb_o	<=	writebusb;
      operation_o	<=	operation;
      a_o		<=	a;
      di	         =	d;
      
   // execute previously pipelined fns
   casex (operation_o)
     3'b101	: loadwrite;
     3'b111	: burstwrite;
   endcase

  end

always @(posedge clk)
if (!cenb)
 begin
 #0.01
  // decode input/piplined state
    casex (operation)
     3'b0??	: turnoff;
     3'b100	: loadread;
     3'b110	: burstread;
    endcase

  if (operation_o ==3'b101)
  writetri <= `tchz 1;
  
 end

//			***	task section	***

task read;
 begin
  if (enable) cetri <= `tclz 0;
     writetri <= `tclz 0;
fork
  do <= `tdoh 18'bz;
  do <= `tclz 18'bx;
  do <= `tco mem[addreg];  
join
 end 
endtask

task write;
begin
 fork
  if (enable) cetri = `tclz 0;
  writeword = mem[addreg];  // set up a word to hold the data for the current location

  if (!writebusb_o[1]) writeword[17:9]  = di[17:9];
  if (!writebusb_o[0]) writeword[8:0]   = di[8:0];

  writeword = writeword &  writeword; //convert z to x states
  mem[addreg] = writeword; // store the new word into the memory location
 join
end
endtask

task loadread;
begin
  burstinit = a_o[0];
  addreg = a_o;
  enable = 1;
  read;
end
endtask

task loadwrite;
begin
  
  burstinit = a_o[0];
  addreg = a_o;
  enable = 1;
  write;
end
endtask

task burstread;
begin
  burst;
  read;
end
endtask

task burstwrite;
begin
  burst;
  write;
end
endtask

task turnoff;
begin
  enable = 0;
  cetri <= `tchz 1;
end
endtask

task burst;
begin
  if (burstinit == 0 || mode == 0)
  begin
    case (addreg[1:0])
      2'b00:   addreg[1:0] = 2'b01;
      2'b01:   addreg[1:0] = 2'b10;
      2'b10:   addreg[1:0] = 2'b11;
      2'b11:   addreg[1:0] = 2'b00;
      default: addreg[1:0] = 2'bxx;
    endcase
  end
  else
  begin
    case (addreg[1:0])
      2'b00:   addreg[1:0] = 2'b11;
      2'b01:   addreg[1:0] = 2'b00;
      2'b10:   addreg[1:0] = 2'b01;
      2'b11:   addreg[1:0] = 2'b10;
      default: addreg[1:0] = 2'bxx;
    endcase
  end
end
endtask


// Setup and Hold time checks

specify
// notifier will wipe memory as result is indeterminent

$setuphold(posedge clk &&& loadcyc, a, `tas, `tah, notifier);

// noti1 would make ip = 'bx;
$setuphold(posedge clk, bws_b,  `tas, `tah, noti1_0);
$setuphold(posedge clk, we_b, `tas, `tah, noti1_1);
$setuphold(posedge clk, ce1b, `tas, `tah, noti1_2);
$setuphold(posedge clk, ce2, `tas, `tah, noti1_3);
$setuphold(posedge clk, ce3b, `tas, `tah, noti1_4);

// noti2 would make d = 18'hxxxxxxxx;
$setuphold(posedge clk &&& writecyc, d, `tas, `tah, noti2);

$setuphold(posedge clk, cenb, `tas, `tah, noti1_5);
$setuphold(posedge clk, adv_lb, `tas, `tah, noti1_6);

endspecify

endmodule
