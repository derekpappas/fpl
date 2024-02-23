//------------------------------------------------------------------------------
// 
// Name:                Atlantic 2:1 Bus Width Converter Design Example
// Module Name:         atl_conv2to1
// Company:             Altera Corporation  www.altera.com 
// 
// Revision History:    v1.0 | 06/16/2004 ko | Documentation Complete
//                      v0.1 | 05/25/2004 ko | Initial Release
// 
// Functional Description:
// 
//   This module converts data from an Atlantic source to an Atlantic Sink 
//   with a data width of double that of the source.  It is intended to be 
//   used to convert master/sink interfaces only.
//
// Copyright:
//   Copyright 2004 Altera Corporation, All rights Reserved
//
//------------------------------------------------------------------------------
module atl_conv2to1 (
		    clk,      // input 
		    reset_n,  // input
		    //----------------------------
		    // Input I/F
		    //----------------------------
		    ai_rddav,    // input
		    ai_rdena,    // output
		    ai_wrena,    // input 
		    ai_dat,      // input [in_datawidth-1:0]
		    ai_mty,      // input [in_mtywidth-1:0]
		    ai_adr,      // input [adrwidth-1:0] 
		    ai_sop,      // input 
		    ai_eop,      // input 
		    ai_err,      // input 
		    //----------------------------
		    // Output I/F
		    //----------------------------
		    ao_rddav,    // output
		    ao_rdena,    // input
		    ao_wrena,    // output 
		    ao_dat,      // output [out_datawidth-1:0]
		    ao_mty,      // output [out_mtywidth-1:0]
		    ao_adr,      // output [adrwidth-1:0] 
		    ao_sop,      // output 
		    ao_eop,      // output 
		    ao_err       // output 
		    );
   
   //----------------------------
   // Parameter Declarations
   //----------------------------
   parameter in_datawidth     = 128;
   parameter in_mtywidth      = 4;
   parameter adrwidth         = 8;
   
   parameter out_datawidth    = in_datawidth/2;
   parameter out_mtywidth     = in_mtywidth-1;
   
   //----------------------------
   // Port Declarations
   //----------------------------
   input     clk;
   input     reset_n;
   
   // Input I/F Control Signals
   input 		      ai_rddav;
   output 		      ai_rdena;
   input 		      ai_wrena;

   // Input I/F Data Signals
   input [in_datawidth-1:0]   ai_dat;
   input [in_mtywidth-1:0]    ai_mty;
   input [adrwidth-1:0]       ai_adr;
   input 		      ai_sop;
   input 		      ai_eop;
   input 		      ai_err;
   
   // Output I/F Control Signals
   output 		      ao_rddav;
   input 		      ao_rdena;
   output 		      ao_wrena;
   reg 			      ao_wrena;

   // Output I/F Data Signals
   output [out_datawidth-1:0] ao_dat;
   reg [out_datawidth-1:0]    ao_dat;
   output [out_mtywidth-1:0]  ao_mty;
   reg [out_mtywidth-1:0]     ao_mty;
   output [adrwidth-1:0]      ao_adr;
   reg [adrwidth-1:0] 	      ao_adr;
   output 		      ao_sop;
   reg 			      ao_sop;
   output 		      ao_eop;
   reg 			      ao_eop;
   output 		      ao_err;
   reg 			      ao_err;
   
   //--------------------------------------------------------
   // Internal Signals
   //--------------------------------------------------------
   reg 			      tophalfsent;
   reg 			      justpopped;
   
   //--------------------------------------------------------
   // dav gets wired straight through to avoid latency
   //--------------------------------------------------------
   assign ao_rddav = ai_rddav;

   //--------------------------------------------------------
   // rd enable also gets wired straight through - don't 
   // assert it when we're waiting to send out bottom half.
   //--------------------------------------------------------
   assign ai_rdena = ao_rdena & ~(justpopped & ai_wrena);
   
   //--------------------------------------------------------
   // Conversion Algorithm
   // - This is an active low async reset domain...
   //--------------------------------------------------------
   always @(posedge clk or negedge reset_n) begin
      if (reset_n == 0) begin
	 ao_wrena     <= 0 ;
	 ao_dat       <= 0 ;
	 ao_mty       <= 0 ;
	 ao_adr       <= 0 ;
	 ao_sop       <= 0 ;
	 ao_eop       <= 0 ;
	 ao_err       <= 0 ;
	 tophalfsent  <= 0;
	 justpopped   <= 0;
	 
      end else begin
	 //-------------------------------------------------
	 // Drive data to output registers.
	 //-------------------------------------------------
	 justpopped <= ai_rdena;
	 
	 if (ao_rdena) begin                    // If sink is okay for read
	    
	    // Default to not enable
	    ao_wrena <= 1'b0;  
	    
	    if (~tophalfsent) begin             // Top half has not been sent,
               if (ai_wrena) begin              // Source data is valid.

		  // Send out top half
		  ao_dat      <= ai_dat[in_datawidth-1:out_datawidth];
		  ao_sop      <= ai_sop;
		  ao_adr      <= ai_adr;
		  ao_err      <= ai_err;
		  tophalfsent <= 1;
		  
		  if ( ai_eop && (ai_mty[in_mtywidth-1]==1)) begin             // This is an EOP
		     // The bus is mostly empty, and we 
		     // will not need to send out the bottom half.
		     ao_mty      <= {ai_mty[in_mtywidth-1:0]};
		     ao_eop      <= 1'b1;
		  end
		  else begin
		     // The bus is mostly full, and we'll need 
		     // another cycle to send it.
		     ao_mty      <= 0;
		     ao_eop      <= 0;
		  end // else: !if(ai_mty[out_mtywidth-1]==1)
		  
		  ao_wrena  <= 1'b1;
	       end // if (ai_wrena)
	       
	    end // if (~tophalfsent)
	    
	    else begin                          // Top half has been sent
	       // follow up with bottom half (regardless of whether or not the 
	       // source has data .. we're still dealing with the old data!)
	       ao_dat      <= ai_dat[out_datawidth-1:0];
	       ao_sop      <= 1'b0;             // Bottom half is never SOP.
	       ao_eop      <= ai_eop;
	       ao_adr      <= ai_adr;
	       ao_err      <= ai_err;
	       ao_mty      <= {ai_mty[out_mtywidth-1:0]};
	       ao_wrena    <= 1'b1;

	       if ( ai_eop && (ai_mty[in_mtywidth-1]==1)) begin             // This is an EOP
		  // We have already sent the eop, and we're just waiting for 
		  // the source to catch up.
		  ao_wrena    <= 1'b0;
	       end
	       
	       tophalfsent <= 0;
	    end // else: !if(~tophalfsent)

	 end // if (ao_rdena)
      end // else: !if(reset_n == 0)
   end // always @ (posedge clk or negedge reset_n)
   
endmodule // atlconv2to1