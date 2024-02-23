/********************************************************************************
*  Copyright (c) 2001 Galvantech,Inc.						
*  All rights reserved.
*
*  File Name:     CY7C1366.v
*  Release:       1.0
*  Last Update:   10/04/2002
*	
*  Function:      256Kb x 36 Synchronous burst SRAM (Pipelined DCD)
*  Part #:        CY7C1366
*  Notes:         -- Ref Cypress CY7C1366 Datasheet (www.cypress.com)
**********************************************************************************/
`timescale 1ns / 10ps

`define SP167MHZ              // Check our datasheet, pick up the speed. (Default)
//`define SP200MHZ            // *************************************************
//`define SP250MHZ
//`define SP300MHZ

module CY7C1444 (addr, bwa_, bwb_, bwc_, bwd_, bwe_, gw_, clk, ce_, ce2, ce2_,
                    oe_, adv_, adsp_, adsc_, mode, zz, dq);

   parameter          addrbits = 18;
   parameter          databits = 36;
   parameter          memsizes = 262144;                // 256Kb
   parameter          regdelay = 0.1;                   // 100ps

input [(addrbits - 1) : 0] addr;                        // Address
input bwa_,bwb_,bwc_,bwd_;                              // Byte Write
input bwe_;                                             // Byte Write Enable
input gw_;                                              // Global Write
input clk;                                              // Clock
input ce_,ce2,ce2_;                                     // Chip Enable
input oe_;                                              // Output Enable
input adv_;                                             // Address Advance
input adsp_;                                            // Address Status Processor
input adsc_;                                            // Address Status Controller
input mode;                                             // Burst Mode
input zz;                                               // Snooze Mode
inout [(databits - 1) : 0] dq;                          // Data I/O

reg [((databits / 4) - 1) : 0] bank0 [(memsizes - 1) : 0];          // Memory Bank 0
reg [((databits / 4) - 1) : 0] bank1 [(memsizes - 1) : 0];          // Memory Bank 1
reg [((databits / 4) - 1) : 0] bank2 [(memsizes - 1) : 0];          // Memory Bank 2
reg [((databits / 4) - 1) : 0] bank3 [(memsizes - 1) : 0];          // Memory Bank 3

reg iclk;                                               // Internal Clcok
reg [(databits - 1) : 0] data_out;                      // Data Out Register
reg [(databits - 1) : 0] pipe_data;                     // Pipelined Data Register
reg [(addrbits - 1) : 0] addr_reg;                      // Address In Register
reg [1:0] burst_cnt;                                    // Burst Counter
reg ce_reg;                                             // Chip Enable Register
reg pipe_ce;                                            // Pipe Chip Enable Register
reg wa_reg;                                             // Write byte A Register
reg wb_reg;                                             // Write byte B Resigter
reg wc_reg;                                             // Write byte C Register
reg wd_reg;                                             // Write byte D Resigter
    
wire ce = ~ce_ & ce2 & ~ce2_;                           // Chip Enable
wire aden = ~ce_ & ~adsp_;
wire addrset = ~adsc_ | aden;                           // Latch External Address
wire wa = ~((bwa_ | bwe_) & gw_ | aden);                
wire wb = ~((bwb_ | bwe_) & gw_ | aden);                // Byte Write Enable
wire wc = ~((bwc_ | bwe_) & gw_ | aden);
wire wd = ~((bwd_ | bwe_) & gw_ | aden);
wire outen = ~(wa_reg | wb_reg | wc_reg | wd_reg);                      // Output Enable
wire ckaddr = addrset & ce;                                             // Check Address
wire ckdata = ((ce & adsp_ & ~adsc_) | (adsc_ & (adsp_ | ce_)))
              & (((~bwa_ | ~bwb_ | ~bwc_ | ~bwd_) & ~bwe_) | ~gw_);     // Check Data

wire [(addrbits - 1) : 0] burst_addr;                  // Read / Write Address
wire baddr1;                                           // Burst Counter1
wire baddr0;                                           // Burst Counter0

wire [(databits -1) : 0] dataout;
wire daoten;

// Snooze Control
always
  begin
     @(posedge clk) 
         iclk = ~zz;
     @(negedge clk)
         iclk = 1'b0;
  end

// Register Input
always @(posedge iclk)
  begin
     if (addrset) 
       begin
         addr_reg <= addr;                                // Latch Address
         ce_reg <= ce;                                    // Latch Chip Enable
       end

     pipe_ce <= ce_reg;

     if (addrset & mode)
         burst_cnt <= 2'b00;                              // Burst Control
     else
       if (addrset & ~mode)
	     burst_cnt <= addr[1:0];
	 else
	     if(~addrset & ~adv_)
	        burst_cnt <= burst_cnt + 1;

     wa_reg <= wa;                                        // Latch Byte Write
     wb_reg <= wb;
     wc_reg <= wc;
     wd_reg <= wd;
  end

// Burst Address 
assign baddr0 = mode ? (burst_cnt[0] ^ addr_reg[0]) : burst_cnt[0];
assign baddr1 = mode ? (burst_cnt[1] ^ addr_reg[1]) : burst_cnt[1];
assign burst_addr = {addr_reg[(addrbits - 1) : 2], baddr1,baddr0};

// Write
always @(posedge clk)
  begin
     #regdelay;
     if (ce_reg & wa_reg) 
        bank0[burst_addr] <= dq[((databits / 4) - 1) : 0];
     if (ce_reg & wb_reg)
        bank1[burst_addr] <= dq[((databits / 2) - 1) : (databits / 4)];
     if (ce_reg & wc_reg)
        bank2[burst_addr] <= dq[((databits * 3 / 4) - 1) : (databits / 2)];
     if (ce_reg & wd_reg)
        bank3[burst_addr] <= dq[(databits - 1) :(databits  * 3 / 4)];
  end

// Read
always @(posedge clk) 
  begin
     #regdelay;
     if (outen)
	begin
           data_out [((databits / 4) - 1) : 0] <= bank0[burst_addr];
           data_out [((databits / 2) - 1) : (databits / 4)] <= bank1[burst_addr];
           data_out [((databits * 3 / 4) - 1) : (databits / 2)] <= bank2[burst_addr];
           data_out [(databits - 1) :(databits  * 3 / 4)] <= bank3[burst_addr];
        end
     else
           data_out [(databits - 1) : 0] <= {databits{1'bz}};
  end

always @(posedge clk)
	pipe_data <= #regdelay data_out;

assign daoten = ~zz & ~oe_ & pipe_ce & outen ;
assign dataout = pipe_data;

// Output
//assign dq = ~zz & ~oe_ & pipe_ce & outen ? pipe_data : {databits{1'bz}};
bufif1 (dq[0],dataout[0],daoten);
bufif1 (dq[1],dataout[1],daoten);
bufif1 (dq[2],dataout[2],daoten);
bufif1 (dq[3],dataout[3],daoten);
bufif1 (dq[4],dataout[4],daoten);
bufif1 (dq[5],dataout[5],daoten);
bufif1 (dq[6],dataout[6],daoten);
bufif1 (dq[7],dataout[7],daoten);
bufif1 (dq[8],dataout[8],daoten);
bufif1 (dq[9],dataout[9],daoten);
bufif1 (dq[10],dataout[10],daoten);
bufif1 (dq[11],dataout[11],daoten);
bufif1 (dq[12],dataout[12],daoten);
bufif1 (dq[13],dataout[13],daoten);
bufif1 (dq[14],dataout[14],daoten);
bufif1 (dq[15],dataout[15],daoten);
bufif1 (dq[16],dataout[16],daoten);
bufif1 (dq[17],dataout[17],daoten);
bufif1 (dq[18],dataout[18],daoten);
bufif1 (dq[19],dataout[19],daoten);
bufif1 (dq[20],dataout[20],daoten);
bufif1 (dq[21],dataout[21],daoten);
bufif1 (dq[22],dataout[22],daoten);
bufif1 (dq[23],dataout[23],daoten);
bufif1 (dq[24],dataout[24],daoten);
bufif1 (dq[25],dataout[25],daoten);
bufif1 (dq[26],dataout[26],daoten);
bufif1 (dq[27],dataout[27],daoten);
bufif1 (dq[28],dataout[28],daoten);
bufif1 (dq[29],dataout[29],daoten);
bufif1 (dq[30],dataout[30],daoten);
bufif1 (dq[31],dataout[31],daoten);
bufif1 (dq[32],dataout[32],daoten);
bufif1 (dq[33],dataout[33],daoten);
bufif1 (dq[34],dataout[34],daoten);
bufif1 (dq[35],dataout[35],daoten);

  specify
      specparam  
     
      `ifdef SP167MHZ

      // Timing Check for (6.0 ns / 167 MHz, VCCQ=3.3v)
       tKC     = 6.0,     // Clock        - Clock Cycle Time
       tKH     = 2.4,     //                Clock HIGH Time
       tKL     = 2.4,     //                Clock LOW Time
       tKQ     = 3.5,     // Ouput Times  - Clock To Output Valid
       tKQHZ   = 3.0,     //                Clock To Output In High-Z
       tOEQ    = 3.5,     //              - OE To Output Valid
       tOEHZ   = 3.0,     //                OE To Output In High-Z
       tSA     = 1.5,     // Setup Times  - Address
       tSAD    = 1.5,     //                Address Status (ADSP#, ADSC#)
       tSAV    = 1.5,     //                Address Advance (ADV#)
       tSW     = 1.5,     //                Byte Write Enables (BWa#-BWd#, BWE#, GW#)
       tSCE    = 1.5,     //                Chip Enable (CE#)
       tSD     = 1.5,     //                Data In
       tHA     = 0.5,     // Hold Times   - Address
       tHAD    = 0.5,     //                Address Status (ADSP#, ADSC#)
       tHAV    = 0.5,     //                Address Advance (ADV#)
       tHW     = 0.5,     //                Byte Write Enables (BWa#-BWd#, BWE#, GW#)
       tHCE    = 0.5,     //                Chip Enable (CE#)
       tHD     = 0.5;     //                Data In

      `else

       `ifdef SP200MHZ

      // Timing Check for (5.0 ns / 200 MHz, VCCQ=3.3v/2.5v)
       tKC     = 5.0,     // Clock        - Clock Cycle Time
       tKH     = 2.0,     //                Clock HIGH Time
       tKL     = 2.0,     //                Clock LOW Time
       tKQ     = 3.0,     // Ouput Times  - Clock To Output Valid
       tKQHZ   = 3.0,     //                Clock To Output In High-Z
       tOEQ    = 3.0,     //              - OE To Output Valid
       tOEHZ   = 3.0,     //                OE To Output In High-Z
       tSA     = 1.5,     // Setup Times  - Address
       tSAD    = 1.5,     //                Address Status (ADSP#, ADSC#)
       tSAV    = 1.5,     //                Address Advance (ADV#)
       tSW     = 1.5,     //                Byte Write Enables (BWa#-BWd#, BWE#, GW#)
       tSCE    = 1.5,     //                Chip Enable (CE#)
       tSD     = 1.5,     //                Data In
       tHA     = 0.5,     // Hold Times   - Address
       tHAD    = 0.5,     //                Address Status (ADSP#, ADSC#)
       tHAV    = 0.5,     //                Address Advance (ADV#)
       tHW     = 0.5,     //                Byte Write Enables (BWa#-BWd#, BWE#, GW#)
       tHCE    = 0.5,     //                Chip Enable (CE#)
       tHD     = 0.5;     //                Data In

      `else

       `ifdef SP250MHZ

      // Timing Check for (4.0 ns / 250 MHz, VCCQ=3.3v/2.5v)
       tKC     = 4.0,     // Clock        - Clock Cycle Time
       tKH     = 1.5,     //                Clock HIGH Time
       tKL     = 1.5,     //                Clock LOW Time
       tKQ     = 2.7,     // Ouput Times  - Clock To Output Valid
       tKQHZ   = 2.3,     //                Clock To Output In High-Z
       tOEQ    = 2.7,     //              - OE To Output Valid
       tOEHZ   = 2.3,     //                OE To Output In High-Z
       tSA     = 1.5,     // Setup Times  - Address
       tSAD    = 1.5,     //                Address Status (ADSP#, ADSC#)
       tSAV    = 1.5,     //                Address Advance (ADV#)
       tSW     = 1.5,     //                Byte Write Enables (BWa#-BWd#, BWE#, GW#)
       tSCE    = 1.5,     //                Chip Enable (CE#)
       tSD     = 1.5,     //                Data In
       tHA     = 0.5,     // Hold Times   - Address
       tHAD    = 0.5,     //                Address Status (ADSP#, ADSC#)
       tHAV    = 0.5,     //                Address Advance (ADV#)
       tHW     = 0.5,     //                Byte Write Enables (BWa#-BWd#, BWE#, GW#)
       tHCE    = 0.5,     //                Chip Enable (CE#)
       tHD     = 0.5;     //                Data In

      `else
       
       `ifdef SP300MHZ

      // Timing Check for (3.3 ns / 300 MHz, VCCQ=3.3v/2.5v)
       tKC     = 3.3,     // Clock        - Clock Cycle Time
       tKH     = 1.5,     //                Clock HIGH Time
       tKL     = 1.5,     //                Clock LOW Time
       tKQ     = 2.3,     // Ouput Times  - Clock To Output Valid
       tKQHZ   = 2.3,     //                Clock To Output In High-Z
       tOEQ    = 2.3,     //              - OE To Output Valid
       tOEHZ   = 2.3,     //                OE To Output In High-Z
       tSA     = 1.5,     // Setup Times  - Address
       tSAD    = 1.5,     //                Address Status (ADSP#, ADSC#)
       tSAV    = 1.5,     //                Address Advance (ADV#)
       tSW     = 1.5,     //                Byte Write Enables (BWa#-BWd#, BWE#, GW#)
       tSCE    = 1.5,     //                Chip Enable (CE#)
       tSD     = 1.5,     //                Data In
       tHA     = 0.5,     // Hold Times   - Address
       tHAD    = 0.5,     //                Address Status (ADSP#, ADSC#)
       tHAV    = 0.5,     //                Address Advance (ADV#)
       tHW     = 0.5,     //                Byte Write Enables (BWa#-BWd#, BWE#, GW#)
       tHCE    = 0.5,     //                Chip Enable (CE#)
       tHD     = 0.5;     //                Data In

      `endif
      `endif
      `endif
      `endif
     
    // Output Delay
    (clk *> dq) = (tKQ,tKQ,tKQHZ,tKQ,tKQHZ,tKQ);       // (0>1,1>0,0>Z,Z>1,1>Z,Z>0)
    (oe_ *> dq) = (tOEQ,tOEQ,tOEHZ,tOEQ,tOEHZ,tOEQ);   // (0>1,1>0,0>Z,Z>1,1>Z,Z>0)
    
    $period     (posedge clk, tKC); 
    $width      (posedge clk, tKH);
    $width      (negedge clk, tKL);
    $setuphold  (posedge clk &&& ckaddr, addr, tSA, tHA);
    $setuphold  (posedge clk, adsp_, tSAD, tHAD);
    $setuphold  (posedge clk, adsc_, tSAD, tHAD);
    $setuphold  (posedge clk, adv_, tSAV, tHAV);
    $setuphold  (posedge clk, bwa_, tSW, tHW);
    $setuphold  (posedge clk, bwb_, tSW, tHW);
    $setuphold  (posedge clk, bwc_, tSW, tHW);
    $setuphold  (posedge clk, bwd_, tSW, tHW);
    $setuphold  (posedge clk, bwe_, tSW, tHW);
    $setuphold  (posedge clk, gw_, tSW, tHW);
    $setuphold  (posedge clk, ce_, tSCE, tHCE);
    $setuphold  (posedge clk, ce2, tSCE, tHCE);
    $setuphold  (posedge clk, ce2_, tSCE, tHCE);
    $setuphold  (posedge clk &&& ckdata, dq, tSD, tHD);
   
  endspecify                        

endmodule

