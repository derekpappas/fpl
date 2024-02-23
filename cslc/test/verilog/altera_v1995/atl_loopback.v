//------------------------------------------------------------------------------
// 
// Name:                Atlantic Loopback Design Example
// Module Name:         atl_loopback
// Company:             Altera Corporation  www.altera.com 
// 
// Revision History:    v1.0 | 06/14/2004 ko | Documentation Complete
//                      v0.1 | 05/25/2004 ko | Initial Release
// 
// Description:
//   This Design Example presents a small block that can be used to loop the 
//   output from an Atlantic source slave back to the input of an Atlantic Sink 
//   Slave.  The design example here has a 128-bit Atlantic bus, and assumes 
//   that near side receive and the near side transmit interfaces are both slave 
//   interfaces, such as the read and write side of a buffer.
//
//   When the loopback input is not asserted, the far side transmit block and the 
//   far side receive blocks are interface masters, and controls the near side 
//   blocks.  When the loopback input is enabled, the loopback block itself acts 
//   as the interface master, reading data from the near side receive, and pushing
//   it into the near side transmit.
//
// Copyright:
//   Copyright 2004 Altera Corporation, All rights Reserved
//
//------------------------------------------------------------------------------
module atl_loopback (
		     clk,
		     loopback,
		     // Atlantic Sink Master "A Input" interface 
		     ain_dav,
		     ain_val,
		     ain_sop,
		     ain_eop,
		     ain_err,
		     ain_dat,
		     ain_mty,
		     ain_adr,
		     ain_ena,
		     // Atlantic Sink Master "A Output" interface 
		     aout_dav,
		     aout_val,
		     aout_sop,
		     aout_eop,
		     aout_err,
		     aout_dat,
		     aout_mty,
		     aout_adr,
		     aout_ena,
		     // Atlantic Sink Master "B Input" interface 
		     bin_dav ,
		     bin_sop ,
		     bin_eop ,
		     bin_err ,
		     bin_dat ,
		     bin_mty ,
		     bin_adr ,
		     bin_ena ,
		     // Atlantic Sink Master "B Output" interface 
		     bout_dav,
		     bout_sop,
		     bout_eop,
		     bout_err,
		     bout_dat,
		     bout_mty,
		     bout_adr,
		     bout_ena
		     );
   
   //---------------------------------------------------------------
   // I/O Definitions
   //---------------------------------------------------------------
   input                clk;
   input                loopback;
   
   input [128-1:0] 	ain_dat;
   input 		ain_dav;
   input [7:0] 		ain_adr;
   output 		ain_ena;
   reg 			ain_ena;   
   input 		ain_eop;
   input 		ain_err;
   input [4-1:0] 	ain_mty;
   input 		ain_sop;
   input 		ain_val;
   
   output [128-1:0] 	aout_dat;
   output 		aout_dav;
   output [7:0] 	aout_adr;
   input 		aout_ena;
   output 		aout_eop;
   output 		aout_err;
   output [4-1:0] 	aout_mty;
   output 		aout_sop;
   output 		aout_val;

   reg [128-1:0] 	aout_dat;
   reg 			aout_dav;
   reg [7:0] 		aout_adr;
   reg 			aout_eop;
   reg 			aout_err;
   reg [4-1:0] 		aout_mty;
   reg 			aout_sop;
   reg 			aout_val;
   
   input [128-1:0] 	bin_dat;
   output 		bin_dav;
   input [7:0] 		bin_adr;
   output 		bin_ena;
   input 		bin_eop;
   input 		bin_err;
   input [4-1:0] 	bin_mty;
   input 		bin_sop;

   reg          	bin_dav;
   reg 			bin_ena;
   
   output [128-1:0] 	bout_dat;
   input 		bout_dav;
   output [7:0] 	bout_adr;
   output 		bout_ena;
   output 		bout_eop;
   output 		bout_err;
   output [4-1:0] 	bout_mty;
   output 		bout_sop;

   reg [128-1:0] 	bout_dat;
   reg [7:0] 		bout_adr;
   reg 			bout_ena;
   reg 			bout_eop;
   reg 			bout_err;
   reg [4-1:0] 		bout_mty;
   reg 			bout_sop;

   //---------------------------------------------------------------
   // Internal Signals
   //---------------------------------------------------------------
   reg 			ain_ena_del;
   
   //---------------------------------------------------------------
   // Create a delayed version of A Input's Enable signal.
   //---------------------------------------------------------------
   always @ (posedge clk )
     begin
	ain_ena_del <= ain_ena;
     end

   //---------------------------------------------------------------
   // Do loopback fuctionality combinatorially.
   //---------------------------------------------------------------
   always @(ain_adr or ain_dat or ain_dav or ain_ena_del
	    or ain_eop or ain_err or ain_mty or ain_sop or ain_val
	    or aout_ena or bin_adr or bin_dat or bin_ena or bin_eop
	    or bin_err or bin_mty or bin_sop or bout_dav or loopback)
     begin
	if (loopback==0) begin
	   // Not looping back: Pass ain to aout, and bin to bout
	   aout_dav  <= ain_dav;
	   aout_val  <= ain_val;
	   aout_sop  <= ain_sop;
	   aout_eop  <= ain_eop;
	   aout_err  <= ain_err;
	   aout_dat  <= ain_dat;
	   aout_mty  <= ain_mty;
	   aout_adr  <= ain_adr;
	   
	   ain_ena   <= aout_ena;
	   
	   bout_sop  <= bin_sop;
	   bout_eop  <= bin_eop;
	   bout_err  <= bin_err;
	   bout_dat  <= bin_dat;
	   bout_mty  <= bin_mty;
	   bout_adr  <= bin_adr;
	   bout_ena  <= bin_ena;
	   
	   bin_dav   <= bout_dav;
	   
	end else begin
	   // Looping back!  
	   
	   aout_dav  <= (1'b0);
	   aout_val  <= (1'b0);
	   aout_sop  <= ain_sop;
	   aout_eop  <= ain_eop;
	   aout_err  <= ain_err;
	   aout_dat  <= ain_dat;
	   aout_mty  <= ain_mty;
	   aout_adr  <= ain_adr;

	   bout_sop  <= ain_sop;
	   bout_eop  <= ain_eop;
	   bout_err  <= ain_err;
	   bout_dat  <= ain_dat;
	   bout_mty  <= ain_mty;
	   bout_adr  <= ain_adr;
	 
	   bout_ena  <= ain_val && ain_ena_del;

	   ain_ena   <= ain_dav && bout_dav;
	end // else: !if(loopback==0)
     end // always @ (ain_adr or ain_dat or ain_dav or ain_ena_del...
   
endmodule // atl_loopback
// --==[ EOP ]==--