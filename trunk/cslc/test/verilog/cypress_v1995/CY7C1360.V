// This model is the property of Cypress Semiconductor Corp and is protected
// by the US copyright laws, any unauthorized copying and distribution is prohibited.
// Cypress reserves the right to change any of the functional specifications without
// any prior notice.
// Cypress is not liable for any damages which may result from the use of this
// functional model.
//
//
//	Cypress Contact:        MPD Applications	
//				support@cypress.com

`timescale  1ns /  10ps


//
//				CY7C1360
//			Behavioral Verilog model 
//
//

// define fixed values

`define wordsize (32 -1)		//
`define no_words (262144 - 1)		// 256k x 36 RAM

// define various delay specs

`define thzoe #(1.56:2.86:3.75)
`define tlzoe #(1.47:2.92:3.74)
`define thzwe #(2.08:3.96:5.16)
`define tlzwe #(2.10:4.20:5.59)
`define thzce #(2.23:4.31:5.63)
`define tlzce #(2.25:4.38:5.73)
`define tcdv  #(7.50:9.50:10.50)
`define tco   #(2.25:4.28:5.59)
`define tdoh  #(2.15:4.18:5.49)

`define tas 2.5
`define tah 0.5

module CY7C1360 ( dp, d, clk, a, gwb, bwb, bweb, advb, adspb, adscb, ce1b, ce2, ce3b, 
                oeb, cenb, mode);

inout	[`wordsize:0] 	d;		// Data Bus
inout	[3:0]		dp;		// Parity Bits

input 			clk, 		// clock input (R)
			gwb,		// global write enable(L)
			bweb, 		// byte write enable(L)
			advb, 		// burst(L) address
			adspb,		// addr strobe(L)
			adscb,		// addr strobe(L)
			ce1b, 		// chip enable(L)
			ce2, 		// chip enable(H)
			ce3b, 		// chip enable(L)
			oeb, 		// async output enable(L)(read)
			cenb,		// clock enable(L) ZZ
//			ftb, 		// flow through(L) 
			mode;		// interleave(H)/linear(L) burst

input 	[3:0] 		bwb;
input 	[17:0] 		a;

reg 			notifier;



wire adspbi;      	// adsp combined with ce1b
wire chipen;    	 	// combined chip enable (high for an active chip)
wire writestate;   	// holds 1 if any of writebus is low
wire loadcyc;        	// holds 1 for load cycles (setup and hold checks)
wire writecyc;     	// holds 1 for write cycles (setup and hold checks)
wire [3:0] bwb;     	// holds the bwb values
wire [3:0] writebusb; 	// holds the "internal" bwb bus based on gwb and bweb
wire [4:0] operation;	// holds adspbi, adscb, advb, chipen, and writestate
wire [17:0] a;       	// address input bus
reg  [31:0] do;      	// data output bus
reg  [3:0] dpo;		// parity  output bus

wire tristate;		// tristate output (on a bytewise basis) when asserted
reg  cetri;       	// register set by chip disable which sets the tristate 
reg  oetri;    		// register set by oe which sets the tristate
reg  enable;         	// register to make the ram enabled when equal to 1
reg  [17:0] addreg;   	// register to hold the input address
reg  [31:0] pipereg; 	// register for the output data
reg  [3:0] piperegp;	// register for the parity data

reg  [31:0] mem [0:`no_words];	// RAM array
reg  [3:0] memp [0:`no_words];	// parity ram array

reg  [31:0] writeword;	// temporary holding register for the write data
reg [3:0] writewordp; // temp register for parity

reg  burstinit;    	// register to hold a[0] for burst type
reg  [17:0] i;  	// temporary register used to write to all mem locs.
reg writetri;		// tristate
wire ftb;		// Flow thro Pin

pullup (ftb);

wire [31:0] d = !tristate ? do : 32'bz;       	// data bus
wire [3:0] dp = !tristate ? dpo : 4'dz;		// Parity output


assign adspbi = adspb | ce1b;
assign chipen = ~ce1b & ce2 & ~ce3b;
assign writestate = ~& writebusb;
assign operation = {adspbi, adscb, advb, chipen, writestate};
assign writebusb[3:0] = (gwb == 1 && bweb == 0) ? bwb[3:0]:
                        (gwb == 1 && bweb == 1) ? 8'b1111:
                        (gwb == 0)              ? 8'b0000:
                                                  8'bxxxx;
assign loadcyc = chipen & (~adscb | ~adspbi);
assign writecyc = writestate & adspbi & ((adscb & enable) | (~adscb & chipen));

assign tristate = cetri | writetri | oetri;

// initialize the output to be tri-state, ram to be disabled
initial
begin
  writetri = 0;
  cetri = 1;
  enable = 0;
// uncomment the next two lines to initialize all memlocs to 0
//  for (i = 0; i <= `no_words; i = i + 1)
//    mem[i] = `wordsize'b0;
end

// asynchronous OE
always @(oeb)
begin
  if (oeb == 1)
    oetri <= `thzoe 1;
  else
    oetri <= `tlzoe 0;
end

// synchronous functions from clk edge
always @(posedge clk)
begin
  if (ftb) do <= `tco pipereg;
  if (ftb) dpo <= `tco piperegp;

  case (operation)
    5'b00000, 5'b00001, 5'b00100, 5'b00101, 5'b01000, 5'b01001, 
    5'b01100, 5'b01101, 5'b10000, 5'b10001, 5'b10100, 5'b10101: turnoff;
    5'b00010, 5'b00011, 5'b00110, 5'b00111, 5'b01010, 5'b01011,
    5'b01110, 5'b01111, 5'b10010, 5'b10110: loadread;
    5'b10011, 5'b10111: loadwrite;
    5'b11000, 5'b11010: if (enable) burstread;
    5'b11001, 5'b11011: if (enable) burstwrite;
    5'b11100, 5'b11110: if (enable) read;
    5'b11101, 5'b11111: if (enable) write;
    default : unknown; // output unknown values and display an error message
  endcase
  if (!ftb) do <= `tcdv pipereg;
  if (!ftb) dpo <= `tcdv piperegp;

end

task read;
begin
  if (enable) cetri <= `tlzce 0;
  writetri <= `tlzwe 0;
  do <= `tdoh 64'hx;
  dpo <= `tdoh 8'hx;
  pipereg = mem[addreg];
  piperegp = memp[addreg];
end
endtask

task write;
begin
  if (enable) cetri <= `tlzce 0;
  writeword = mem[addreg];  // set up a word to hold the data for the current location
  writewordp = memp[addreg]; // temp location for parity

  /* overwrite the current word for the bytes being written to */
  if (!writebusb[3]) writeword[31:24] = d[31:24];
  if (!writebusb[2]) writeword[23:16] = d[23:16];
  if (!writebusb[1]) writeword[15:8]  = d[15:8];
  if (!writebusb[0]) writeword[7:0]   = d[7:0];


  if (!writebusb[3]) writewordp[3] = dp[3];
  if (!writebusb[2]) writewordp[2] = dp[2];
  if (!writebusb[1]) writewordp[1] = dp[1];
  if (!writebusb[0]) writewordp[0] = dp[0];
	
  writeword = writeword &  writeword;
  writewordp = writewordp & writewordp;
  mem[addreg] = writeword; // store the new word into the memory location
  memp[addreg] = writewordp; // store the parity       

  pipereg = mem[addreg];   // store the new word into the output register
  piperegp = memp[addreg];

  writetri <= `thzwe 1;    // tristate the outputs
end
endtask

task loadread;
begin
  burstinit = a[0];
  addreg = a;
  if (!ftb) cetri <= `tlzce 0;
  read;
  enable = 1;
end
endtask

task loadwrite;
begin
  burstinit = a[0];
  addreg = a;
  if (!ftb) cetri <= `tlzce 0;
  write;
  enable = 1;
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

task unknown;
begin
  do = 32'bx;
  // $display ("Unknown function:  Operation = %b\n", operation);
end
endtask

task turnoff;
begin
  enable = 0;
  cetri <= `thzce 1;
  pipereg = 32'h00;
end
endtask

task burst;
begin
  if (burstinit == 0 || advb == 0)
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

specify
// specify the setup and hold checks
$setuphold(posedge clk &&& loadcyc, a, `tas, `tah, notifier);

$setuphold(posedge clk, bwb, `tas, `tah, notifier);

$setuphold(posedge clk, adscb, `tas, `tah, notifier);
$setuphold(posedge clk, adspb, `tas, `tah, notifier);
$setuphold(posedge clk, advb, `tas, `tah, notifier);
$setuphold(posedge clk, gwb, `tas, `tah, notifier);
$setuphold(posedge clk, bweb, `tas, `tah, notifier);
$setuphold(posedge clk, ce1b, `tas, `tah, notifier);
$setuphold(posedge clk, ce2, `tas, `tah, notifier);
$setuphold(posedge clk, ce3b, `tas, `tah, notifier);
//$setuphold(posedge clk, ce4, `tas, `tah, notifier);
//$setuphold(posedge clk, ce5b, `tas, `tah, notifier);

$setuphold(posedge clk &&& writecyc, d, `tas, `tah, notifier);
 
endspecify

endmodule


