/*
 INTEL DEVELOPER'S SOFTWARE LICENSE AGREEMENT

 BY USING THIS SOFTWARE, YOU ARE AGREEING TO BE BOUND
 BY THE TERMS OF THIS AGREEMENT.  DO NOT USE THE SOFTWARE
 UNTIL YOU HAVE CAREFULLY READ AND AGREED TO THE FOLLOWING
 TERMS AND CONDITIONS.  IF YOU DO NOT AGREE TO THE TERMS
 OF THIS AGREEMENT, PROMPTLY RETURN THE SOFTWARE PACKAGE
 AND ANY ACCOMPANYING ITEMS.

 IF YOU USE THIS SOFTWARE, YOU WILL BE BOUND BY THE TERMS
 OF THIS AGREEMENT.

 LICENSE:  Intel Corporation ("Intel") grants you
 the non-exclusive right to use the enclosed software
 program ("Software").  You will not use, copy, modify,
 display, rent, sell or transfer the Software or any portion
 thereof, except as provided in this Agreement.

 System OEM Developers may:
 1.      copy the Software for internal support, backup
         or archival purposes;
 2.      internally install, use, display, or distribute
         Intel owned Software in object code format;
 3.      internally modify Software source code that
         Intel makes available to you for internal use
         only as an OEM Developer;
 4.      internally install, use, display, modify, distribute,
         and/or make derivatives ("Derivatives") of Intel owned
         Software ONLY if you are a System OEM Developer and
         NOT an end-user.

 RESTRICTIONS:

 YOU WILL NOT:
 1.      copy the Software, in whole or in part, except as
         provided for in this Agreement;
 2.      decompile or reverse engineer any Software provided
         in object code format;
 3.      distribute any Software or Derivative code to any
         end-users, unless approved by Intel in a prior writing.

 TRANSFER: You may not transfer the Software to any third
 party without Intel's prior written consent.

 OWNERSHIP AND COPYRIGHT OF SOFTWARE: Title to the Software
 and all copies thereof remain with Intel or its vendors.
 The Software is copyrighted and is protected by United States
 and international copyright laws.  You will not remove the
 copyright notice from the Software.  You agree to prevent
 any unauthorized copying of the Software.

 DERIVATIVE WORK: OEM Developers that make Derivatives will
 not be required to provide Intel with a copy of the source
 or object code.  Any modification of Software shall be at
 your sole risk and expense. No Software or Derivative
 distribution to any third party is permitted under this
 Agreement.

 DUAL MEDIA SOFTWARE: If the Software package contains
 multiple media, you may only use the medium appropriate
 for your system.

 WARRANTY: Intel warrants that it has the right to license
 you to use, modify, display, or distribute the Software as
 provided in this Agreement. The Software is provided "AS IS"
 without WARRANTY of any kind.  Intel makes no representations
 to upgrade, maintain, or support the Software at any time.


 THE ABOVE WARRANTIES ARE THE ONLY WARRANTIES OF ANY
 KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WARRANTIES
 OF MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE
 OR INFRINGEMENT OF ANY PATENT, COPYRIGHT OR OTHER
 INTELLECTUAL PROPERTY RIGHT.

 LIMITATION OF LIABILITY: NEITHER INTEL NOR ITS
 VENDORS OR AGENTS SHALL BE LIABLE FOR ANY LOSS
 OF PROFITS, LOSS OF USE, LOSS OF DATA, INTERRUPTION
 OF BUSINESS, NOR FOR INDIRECT, SPECIAL, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES OF ANY KIND WHETHER UNDER
 THIS AGREEMENT OR OTHERWISE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGES.

 TERMINATION OF THIS LICENSE: Intel reserves the right
 to conduct or have conducted audits to verify your
 compliance with this Agreement.  Intel may terminate
 this Agreement at any time if you are in breach of
 any of its terms and conditions.  Upon termination,
 you will immediately destroy, and certify in writing
 the destruction of, the Software or return all copies
 of the Software and documentation to Intel.

 U.S. GOVERNMENT RESTRICTED RIGHTS: The Software and
 documentation were developed at private expense and
 are provided with "RESTRICTED RIGHTS".  Use, duplication
 or disclosure by the Government is subject to restrictions
 as set forth in FAR52.227-14 and DFAR252.227-7013 et seq.
 or its successor.

 EXPORT LAWS: You agree that the distribution and
 export/re-export of the Software is in compliance
 with the laws, regulations, orders or other restrictions
 of the U.S. Export Administration Regulations.

 APPLICABLE LAW: This Agreement is governed by the
 laws of the State of California and the United States,
 including patent and copyright laws.  Any claim
 arising out of this Agreement will be brought in
 Santa Clara County, California.

 Copyright 1996, Intel Corporation, All Rights Reserved

 Copyright 1997, Intel Corporation
 Functionality and specifications based on StrataFlash(tm) - MLC EAS Rev 2.0
 specifications (Ref. FM-0911)
 Refer to Intel Folsom Document Control for spec.


 Release History --
 Date           Rev    Comments
 --------------------------------------------------------------
Aug 5, 1998     1.0    Initial Model Complete
Nov 3, 2000     1.1    Modify page mode operation per current spec as default mode
                       Prevent erroneous reporting of TDVWH
Nov 6, 2000     1.2    Correct error and status reporting when writing to a programmed cell

*/

/***************************************************************************
*  This INTEL(R) StrataFlash[TM] MEMORY 0.25 micron GENERATION behavioral 
*  model was designed based upon preliminary specification information during 
*  the initial development cycle.
*/
`timescale 1ns/1ns

/***************************************************************************
* Standard Constants
*/
`define AddrRange            `DeviceAddrSize-1:0
`define MemoryRange          `MemorySize-1:0
`define WriteBufferRange     `WriteBufferSize-1:0
`define WriteBufferAddrRange `WriteBufferAddrSize-1:0
`define QueryTableRange      `QueryTableSize:0
`define MasterBit            `NumEraseBlocks1

`define WORD          15:0
`define BYTE           7:0
`define UPPER         15:8
`define LOWER          7:0
`define FALSE         1'b0   // Logic 0
`define TRUE          1'b1   // Logic 1
`define BUSY          1'b0
`define READY         1'b1
`define VIL           1'b0   // Low Voltage
`define VIH           1'b1   // High Voltage
`define PROGRAM       1'b0   // Program Flag for changing Memory Array
`define ERASE         1'b1   // Erase Flag for changing Memory Array
`define UNLOCKED      1'b0   // Unlocked Block Lock Status
`define LOCKED        1'b1   // Locked Block Lock Status

`define NoErr        8'h00   // Indicates Command Execution Success
`define VoltErr      8'h01   // Incorrect Voltage 
`define LockErr      8'h02
`define BytebErr     8'h03   // byteb toggle during operation
`define SuspCmdErr   8'h04   
`define SuspAccErr   8'h05
`define SuspAccWrn   8'h06
`define CmdErr       8'h07
`define AddrErr      8'h08
`define BlAddrErr    8'h09
`define AddrWarn     8'h0A
`define PreProgErr   8'h0B
`define Suspended    8'h0C
`define AddrTogErr   8'h0D
`define Redundancy   8'h0E
`define NoSuspErr    8'h0F
`define NoBusyErr    8'h10
`define BuffSizeErr  8'h11

`define ReadArray    2'b00   // Read Modes
`define ReadQuery    2'b01
`define ReadID       2'b10
`define ReadStatus   2'b11

/*****Module Definition****************************************************
*
*    Module Name : modIntelStrataFlash
*       *Note: Signals, variables, etc. that are logic-zero enabled (active low)
*              are specified by a terminating 'b' (i.e. ceb1, oeb, byteb, etc.)
*       *Additional information on these inputs/outputs (Verbose excluded) can be
*        found in Table 1
*    Inputs      : dq              -- Data pins (also output)
*                  addr            -- Address pins
*                  ceb0,ceb1,ceb2  -- Chip enable pins   **see Table 2 for more details
*                  oeb             -- Output enable pin
*                  web             -- Write enable pin
*                  byteb           -- BYTE/WORD pin
*                  vcc             -- Device power supply
*                  vpen            -- Erase/Program/Block Lock Enable
*                  vccq            -- Output buffer power supply
*                  rpb             -- Reset/Power-Down
*                  Verbose         -- Provides more explanation during simulation (debug aid)
*    Outputs     : dq              -- Data pins (also input)
*                  sts             -- Status pin
*    Description : This module is the most significant of the entire model.  By manipulating the
*                  inputs one should be able to accurately simulate the Intel(R) StrataFlash(TM)
*                  device, as evidenced on the output pins.  All other modules utilized in this
*                  model are instantiated within modIntelStrataFlash.
*/
module modIntelStrataFlash(dq, addr, ceb0, ceb1, ceb2, oeb, web, rpb, byteb, sts, vcc, vpen, vccq, Verbose, Debug);
  inout [`WORD]       dq;
  input [`AddrRange]  addr;
  input               ceb0, ceb1, ceb2, oeb, web, byteb; 
  output	            sts;
  
  input [31:0]        vcc,    // These four voltage inputs are 32 bit vectors treated
                      vpen,   // as unsigned integers which correspond to millivolts.
                      vccq,   // i.e. 5000 = 5V.
                      rpb;    // Reset/Powerdown pin
                      
  input	  Verbose, Debug;     // These inputs restrict/enable extra text output from the model. 
                              // Verbose output decribes device operation information
                              // Debug output describes model operation information
  
  wire [`WORD] wirInternaldq;
  wire  wirInternalCEb = (!ceb2 & (ceb1 | ceb0) | (ceb2 & (ceb1 & ceb0))) & device.voltOK;
  wire  wirInternalOEb = (oeb | wirInternalCEb) | !device.ioVoltOK;
  wire  wirInternalWEb = web | wirInternalCEb;
  wire  [`AddrRange] wirInternalAddr = (byteb) ? {addr[`DeviceAddrSize-1:1],1'b0}: addr;

  reg [`BYTE] ReadErrFlag, EraseErrFlag, ProgramErrFlag, LockErrFlag, ConfigErrFlag,
              BufferErrFlag, SuspendErrFlag, ResumeErrFlag, ClearSRErrFlag;
  integer i;

  // Instruction Decoder Module Instantiations
  InstructionDecoder_1 // one write cycle instructions
                   ReadArray_ID (dq[`LOWER], "      Read Array", `ReadArrayCmd,     Verbose, Debug),
                   ReadID_ID    (dq[`LOWER], "         Read ID", `ReadIDCmd,        Verbose, Debug),
                   ReadQ_ID     (dq[`LOWER], "      Read Query", `ReadQueryCmd,     Verbose, Debug),
                   ReadSR_ID    (dq[`LOWER], " Read Status Reg", `ReadCSRCmd,       Verbose, Debug),
                   ClearSR_ID   (dq[`LOWER], "Clear Status Reg", `ClearCSRCmd,      Verbose, Debug),
                   Resume_ID    (dq[`LOWER], "          Resume", `ResumeCmd,        Verbose, Debug),
                   Program_ID   (dq[`LOWER], "         Program", `ProgramCmd,       Verbose, Debug),
                   Program2_ID  (dq[`LOWER], "         Program", `Program2Cmd,      Verbose, Debug),
                   Buffer_ID    (dq[`LOWER], "    Buffer Write", `WriteToBufferCmd, Verbose, Debug);
  BusyDecoder_1        // one write cycle instructions (valid only when device is busy)
                   Suspend_ID   (dq[`LOWER], "         Suspend", `SuspendCmd,       Verbose, Debug);
  InstructionDecoder_2 // two write cycle instructions 
                   Erase_ID     (dq[`LOWER], "           Erase", `EraseBlockCmd,    `ConfirmCmd,        Verbose, Debug),
                   SetLB_ID     (dq[`LOWER], "    Set Lock Bit", `LBSetupCmd,       `SetBlockLBCmd,     Verbose, Debug),
                   ClearLB_ID   (dq[`LOWER], " Clear Lock Bits", `LBSetupCmd,       `ClearLBCmd,        Verbose, Debug),
                   SetMLB_ID    (dq[`LOWER], " Set Master Lock", `LBSetupCmd,       `SetMasterLBCmd,    Verbose, Debug),
                   STSProg_ID   (dq[`LOWER], " STS Prog Config", `ConfigurationCmd, `ProgramPulse,      Verbose, Debug),
                   STSErase_ID  (dq[`LOWER], "STS Erase Config", `ConfigurationCmd, `ErasePulse,        Verbose, Debug),
                   STSDefault_ID(dq[`LOWER], "STS Deflt Config", `ConfigurationCmd, `RdyBsy,            Verbose, Debug),
                   STSBoth_ID   (dq[`LOWER], "STS Er/Pr Config", `ConfigurationCmd, `BothPulse,         Verbose, Debug),
                   ReadPage_ID  (dq[`LOWER], "  Read Page Mode", `SetReadConfigCmd, `SetReadConfirmCmd, Verbose, Debug);

  // Execution Handler Module Instantiations
  modProgramHandler       ProgramHandler(dq,wirInternalAddr,byteb,device.progVoltOK,Verbose,Debug);
  modBufferWriteHandler   BufferHandler(dq,wirInternalAddr,byteb,device.progVoltOK,Verbose,Debug);
  modEraseHandler         EraseHandler(wirInternalAddr,device.eraseVoltOK,Verbose,Debug);
  modLockHandler          LockHandler(wirInternalAddr,device.lockVoltOK,device.lockOverrideOK,Verbose,Debug);
  modReadHandler          ReadHandler(wirInternaldq,wirInternalAddr,device.ioVoltOK,Verbose,Debug);
  modStatusConfigHandler  STSHandler(sts,Verbose,Debug);
  
  // Internal State Module Instantiation
  modDeviceInfo    device(rpb,vcc,vpen,vccq,Verbose,Debug);
  
  // Data Structure Module Instantiations
  modOutputBuffer  outputBuffer(wirInternaldq, wirInternalOEb, byteb, dq);
  modMemory        memory(Verbose,Debug);
  modStatusReg     SR(Verbose,Debug);
  modIDTable       IDTable(`FALSE),
                   QueryTable(`TRUE);
  
  // StrataFlash Constructor Sequence
  initial begin
    $timeformat(-9, 0, " ns", 12);             // Format time displays to screen
    -> device.evtReset;                        // Reset Device upon startup
  end

  // Recognize command input
  always @(!wirInternalWEb) begin
    @(posedge wirInternalWEb) begin
      -> device.evtCommand;                    // Alert the command modules that a new command
    end                                        // has been written to the device.
  end
  
  always @(device.evtCommand) begin : Verify   // After issuing a command wait for a verify...
    @(device.evtVerify)                        // if a verify occurs...
      disable Timeout;                         // then disable the timeout check.
  end
  
  always @(device.evtCommand) begin : Timeout  // When a command is written...
    #1                                         // wait a nanosecond...
    -> device.evtError;                        // trigger error
    disable Verify;                            // discontinue wait for verify.
  end
  
  // Default to Read Array command
  always @(negedge wirInternalOEb or wirInternalAddr) begin
    if (wirInternalOEb == `VIL)
      -> device.evtRead;
  end

  // Reset the device
  always @(rpb) begin
    if (rpb < `VILrpb) begin
      -> device.evtReset;
      if (Verbose) $display ("%t  Flash Device has been reset", $time);  end
  end
  
  //
  // Call appropriate execution handler for each command, based on decode results
  //
  always @(device.evtDecode1[`ReadArrayCmd]) begin                   // Read Array
    ReadHandler.SetMode(`ReadArray, ReadErrFlag);
    device.Report(`ReadArrayCmd, 8'hXX, ReadErrFlag);
    #1 -> device.evtComplete;
  end

  always @(device.evtDecode1[`ReadIDCmd]) begin                      // Read ID
    ReadHandler.SetMode(`ReadID, ReadErrFlag);
    device.Report(`ReadIDCmd, 8'hXX, ReadErrFlag);
    #1 -> device.evtComplete;
  end

  always @(device.evtDecode1[`ReadQueryCmd]) begin                   // Read Query
    ReadHandler.SetMode(`ReadQuery, ReadErrFlag);
    device.Report(`ReadQueryCmd, 8'hXX, ReadErrFlag); 
    #1 -> device.evtComplete;
  end

  always @(device.evtDecode1[`ReadCSRCmd]) begin                     // Read Status Register
    ReadHandler.SetMode(`ReadStatus, ReadErrFlag);
    device.Report(`ReadCSRCmd, 8'hXX, ReadErrFlag); 
    #1 -> device.evtComplete;
  end

  always @(device.evtDecode1[`ClearCSRCmd]) begin                    // Clear Status Register
    SR.Clear(ClearSRErrFlag);
    device.Report(`ClearCSRCmd, 8'hXX, ClearSRErrFlag); 
    #1 -> device.evtComplete;
  end

  always @(device.evtDecode1[`SuspendCmd]) begin                     // Suspend
    if (ProgramHandler.IsBusy(1'bX))
      ProgramHandler.Suspend(SuspendErrFlag);
    else if (BufferHandler.IsBusy(1'bX))
      BufferHandler.Suspend(SuspendErrFlag); 
    else if (EraseHandler.IsBusy(1'bX))
      EraseHandler.Suspend(SuspendErrFlag);
    -> device.evtComplete;
  end

  always @(device.evtDecode1[`ResumeCmd]) begin                      // Resume
    ResumeErrFlag = `NoErr;
    if (ProgramHandler.IsSuspended(1'bX)) begin
      ProgramHandler.Resume(ProgramErrFlag);
      device.Report(`ProgramCmd, 8'hXX, ProgramErrFlag);
    end
    else if (BufferHandler.IsSuspended(1'bX)) begin
      BufferHandler.Resume(BufferErrFlag);
      device.Report(`WriteToBufferCmd, 8'hXX, BufferErrFlag);
    end
    else if (EraseHandler.IsSuspended(1'bX)) begin
      EraseHandler.Resume(EraseErrFlag);
      device.Report(`EraseBlockCmd, 8'hXX, EraseErrFlag);
    end
    else
      ResumeErrFlag = `NoSuspErr;
    device.Report(`ResumeCmd, 8'hXX, ResumeErrFlag);
    -> device.evtComplete;
  end

  always @(device.evtDecode1[`ProgramCmd] or 
           device.evtDecode1[`Program2Cmd]) begin                    // Program
    @device.evtCommand                                               
    -> device.evtVerify;
    ProgramHandler.Program(ProgramErrFlag);
    device.Report(`ProgramCmd, 8'hXX, ProgramErrFlag);
    -> device.evtComplete;
  end

  always @(device.evtDecode1[`WriteToBufferCmd]) begin               // Buffered Program
    ReadHandler.SetMode(`ReadStatus,ReadErrFlag);
    BufferErrFlag = `NoErr;
    @device.evtCommand
    -> device.evtVerify;
    BufferHandler.SetCount(BufferErrFlag);
    if (BufferErrFlag == `NoErr) begin
      for (i=1;i<=BufferHandler.GetCount(1'bX);i=i+1) begin : GetData
        @device.evtCommand
          BufferHandler.Load(BufferErrFlag);
          -> device.evtVerify;
        if (BufferErrFlag != `NoErr)
          disable GetData;
      end
      @device.evtCommand
        if (dq[`BYTE] != `ConfirmCmd)
          BufferErrFlag = `CmdErr;
        else begin
          -> device.evtVerify;
          BufferHandler.Program(BufferErrFlag);
        end
    end
    device.Report(`WriteToBufferCmd, 8'hXX, BufferErrFlag);
    ->device.evtComplete;
  end
  
  always @(device.evtDecode2[{`EraseBlockCmd,`ConfirmCmd}]) begin    // Erase
    EraseHandler.Erase(EraseErrFlag);
      device.Report(`EraseBlockCmd, `ConfirmCmd, EraseErrFlag);
    -> device.evtComplete;
  end

  always @(device.evtDecode2[{`LBSetupCmd,`SetBlockLBCmd}]) begin    // Lock Block
    LockHandler.Lock(LockErrFlag);
    device.Report(`LBSetupCmd, `SetBlockLBCmd, LockErrFlag);
    -> device.evtComplete;
  end

  always @(device.evtDecode2[{`LBSetupCmd,`ClearLBCmd}]) begin       // Clear Lock Bit
    LockHandler.Clear(LockErrFlag);
    device.Report(`LBSetupCmd, `ClearLBCmd, LockErrFlag);
    -> device.evtComplete;
  end

  always @(device.evtDecode2[{`LBSetupCmd,`SetMasterLBCmd}]) begin        // Set Master Lock Bit
    LockHandler.MasterLock(LockErrFlag);
    device.Report(`LBSetupCmd, `SetMasterLBCmd, LockErrFlag);
    -> device.evtComplete;
  end

  always @(device.evtDecode2[{`ConfigurationCmd,`ProgramPulse}]) begin    // STS Configuration 
    STSHandler.SetProgramPulse(ConfigErrFlag);                            // Program Pulse
    device.Report(`ConfigurationCmd,`ProgramPulse, ConfigErrFlag);
    #1 -> device.evtComplete;
  end

  always @(device.evtDecode2[{`ConfigurationCmd,`ErasePulse}]) begin      // STS Configuration 
    STSHandler.SetErasePulse(ConfigErrFlag);                              // Erase Pulse
    device.Report(`ConfigurationCmd,`ErasePulse, ConfigErrFlag);
    #1 -> device.evtComplete;
  end

  always @(device.evtDecode2[{`ConfigurationCmd,`BothPulse}]) begin       // STS Configuration 
    STSHandler.SetBothPulse(ConfigErrFlag);                               // Program & Erase Pulse       
    device.Report(`ConfigurationCmd,`BothPulse, ConfigErrFlag);                               
    #1 -> device.evtComplete;
  end

  always @(device.evtDecode2[{`ConfigurationCmd,`RdyBsy}]) begin          // STS Configuration 
    STSHandler.SetDefault(ConfigErrFlag);                                 // Ready/Busy
    device.Report(`ConfigurationCmd,`RdyBsy, ConfigErrFlag);                               
    #1 -> device.evtComplete;
  end

  always @(device.evtDecode2[{`SetReadConfigCmd,`SetReadConfirmCmd}]) begin // Page Mode Access
    ReadHandler.SetPageMode(addr[16:1], ReadErrFlag);                            
    device.Report(`SetReadConfigCmd,`SetReadConfirmCmd, ReadErrFlag);
    #1 -> device.evtComplete;
  end

  /*******************************************************/
  //  Timing Constraint Handlers
  //
  //  Look for when the device becomes disabled (from state table)
  always @(negedge wirInternalCEb) begin: negEdgeCEb
    time tref;                                               // scope variable declaration
    while(`TRUE) begin                                       // loop forever
      tref = $time;
      fork : negCEb
        @(byteb) device.CheckMinTime("TELFL", `TELFL, tref);        // R11 Time Constraint
        @(negedge web) device.CheckMinTime("TELWL", `TELWL, tref);  //  W2 Time Constraint
        @(negedge wirInternalCEb) disable negCEb;                   // recursive progression
      join
    end
  end
  
  //  Look for positive edge of CEb
  always @(posedge wirInternalCEb) begin: posEdgeCEb
    time tref;
    while(`TRUE) begin
      tref = $time;
      fork : posCEb
        @(negedge wirInternalCEb) device.CheckMinTime("TEHEL", `TEHEL, tref);  // R14 Time Constraint
        @(posedge wirInternalCEb) disable posCEb;                  
      join
    end
  end
  
  //  Look for RP# chenging into appropriate range
  always @(rpb) begin: posEdgeRPb
    time tref;
    if ((rpb >= `VILrpb) && (rpb <= `VIHrpb)) begin
      while(`TRUE) begin
        tref = $time;
        fork : posRPb
          @(negedge web) device.CheckMinTime("TPHWL", `TPHWL, tref);           //  W1 Time Constraint
          @(rpb) disable posRPb;
        join
      end
    end
  end
  
  //  Look for positive edge of WE#
  always @(posedge web) begin: posEdgeWEb
    time tref;
    while(`TRUE) begin
      tref = $time;
      fork : posWEb                                                   
        @(posedge wirInternalCEb) device.CheckMinTime("TWHEH", `TWHEH, tref);  //  W6 Time Constraint
        @(dq) device.CheckMinTime("TWHDX", `TWHDX, tref);                      //  W7 Time Constraint
        @(addr) device.CheckMinTime("TWHAX", `TWHAX, tref);                    //  W8 Time Constraint
        @(negedge web) device.CheckMinTime("TWPH", `TWPH, tref);               //  W9 Time Constraint
        @(negedge oeb) device.CheckMinTime("TWHGL", `TWHGL, tref);             // W12 Time Constraint
        @(posedge web) disable posWEb;                 
      join
    end
  end
  
  //  Look for negative edge of WE#
  always @(negedge web) begin: negEdgeWEb
    time tref;
    while(`TRUE) begin 
      tref = $time;
      fork : negWEb
        @(posedge web) device.CheckMinTime("TWP", `TWP, tref);                 //  W3 Time Constraint
        @(negedge web) disable negWEb;                                
      join
    end
  end
  
  //  Look for data setup 
  always @(dq) begin: EdgeDQ
    time tref;
    while(`TRUE) begin  // loop forever
      tref = $time;
      fork : setupDQ                                                  //  W4 Time Constraint
//      @(posedge web or posedge wirInternalCEb) device.CheckMinTime("TDVWH", `TDVWH, tref);
        @(posedge web && !wirInternalCEb) device.CheckMinTime("TDVWH", `TDVWH, tref); //(rev 1.1 added)
        @(posedge wirInternalCEb && !web) device.CheckMinTime("TDVWH", `TDVWH, tref); //(rev 1.1 added)
        @(dq) disable setupDQ;
      join
    end
  end
  
  //  Look for address setup 
  always @(addr) begin: EdgeAddr
    time tref;
    while(`TRUE) begin  
      tref = $time;
      fork : setupADDR                                                //  W5 Time Constraint
        @(posedge web or posedge wirInternalCEb) device.CheckMinTime("TAVWH", `TAVWH, tref);
        @(addr) disable setupADDR;                                    
      join
    end
  end
  
  //  Look for vpen setup 
  always @(vpen) begin: EdgeVPEN
    time tref;
    while(`TRUE) begin
      tref = $time;
      fork : setupVPEN                                                // W11 Time Constraint
        @(posedge web or posedge wirInternalCEb) device.CheckMinTime("TVPWH", `TVPWH, tref);
        @(addr) disable setupVPEN;
      join
    end
  end
  
  //  Look for sts going high
  always @(posedge sts) begin: EdgeSTS
    time tref;
    while(`TRUE) begin
      tref = $time;
      fork : holdSTS
        @(vpen) device.CheckMinTime("TQVVL", `TQVVL, tref);           // W15 Time Constraint
        @(addr) disable holdSTS;                                    
      join
    end
  end
  
  //  Look for rpb override
  always @(posedge device.lockOverrideOK) begin: EdgeOverride
    time tref;
    while(`TRUE) begin
      tref = $time;
      fork : holdLockOverride
        @(posedge wirInternalWEb) device.CheckMinTime("TPHHWH", `TPHHWH, tref);  // W10 Time Constraint
        @(posedge sts) device.CheckMinTime("TQVPH",`TQVPH,tref);                 // W14 Time Constraint
        @(posedge device.lockOverrideOK) disable holdLockOverride;                                    
      join
    end
  end

  //  
  // Timing Delay Handlers (internal delays associated with part)
  //
  // Decode Delays for Page Mode Reads
  always //(rev 1.1) Changed to reflect current device operation. Original code follows as comments
    begin :nopage
     @(addr[`DeviceAddrSize-1:3]) //upper address change = new page access
     disable page; //lower address lines may have also transitioned
     outputBuffer.SetX(`TOH);
     outputBuffer.SetValid(`TAVQV);
    end //nopage
//
  always
    begin :page
     @(addr[2:0])
     outputBuffer.SetX(`TOH);
     outputBuffer.SetValid(`TAPA);
    end //page

//  always @(addr) begin
//    outputBuffer.SetX(`TOH);
//    outputBuffer.SetValid(`TAVQV);
//    while (ReadHandler.UsePageMode(1'bX)) fork: PageMode
//      @(addr[`DeviceAddrSize-1:3]) begin: InitialReads
//        disable FastReads;
//        outputBuffer.SetX(`TOH);
//        outputBuffer.SetValid(`TAVQV);
//        disable PageMode;
//      end
//      @(addr[2:0]) begin: FastReads
//        outputBuffer.SetX(`TOH);
//        outputBuffer.SetValid(`TAPA);
//        disable PageMode;
//      end
//    join
//  end
 
  // Output Buffer delays  
  always @(negedge wirInternalCEb) begin
    outputBuffer.SetX(`TELQX);
    outputBuffer.SetValid(`TELQV);
  end
  
  always @(negedge oeb) begin
    outputBuffer.SetX(`TGLQX);
    outputBuffer.SetValid(`TGLQV);
  end
  
  always @(rpb) begin
    if (rpb >= 5000)
      outputBuffer.SetValid(`TPHQV);
  end
  
  always @(posedge wirInternalCEb) begin
    outputBuffer.SetHighZ(`TEHQZ);
  end
  
  always @(posedge oeb) begin
    outputBuffer.SetX(`TOH);
    outputBuffer.SetHighZ(`TGHQZ);
  end
  
//(rev 1.1) Redundant code commented out below
//  always @(posedge oeb) begin
//    outputBuffer.SetX(`TOH);
//  end
  
  always @(byteb) begin
    outputBuffer.SetX(`TOH);
    outputBuffer.SetValid(`TFLQV);
  end
  
endmodule
  
/*****Module Definition****************************************************
*
*    Module Name : modOutputBuffer
*    Inputs      : inputData    -- This is the data that, if all conditions
*                                  met, is to be the output of the device
*                  OutputEnable -- The universal output enable signal
*    Outputs     : outputData   -- The data to be output from the device
*    Description : This module regulates the flow of data out of the memory
*                  device.  Specifically this module determines whether the
*                  output pins are in a high impedence state, invalid state
*                  or valid state.
*/
module modOutputBuffer(inputData, OutputEnable, byteb, outputData);
  input [`WORD] inputData;
  input OutputEnable, byteb;
  output [`WORD] outputData;
  reg [`WORD] outputData;
  time timeValid, timeX, timeHighZ;
  
  initial begin
    timeValid=0;
    timeX=0;
    timeHighZ=0;
    SetHighZ(0);
  end
  
  always @ (byteb or outputData) begin
    outputData = (byteb) ? outputData: {8'hZ, outputData[`BYTE]};
  end
  
  /*****Task Definition*********************
  *
  *    Task Name  : [modOutputBuffer].SetValid
  *    Inputs     : delayTime -- Time until output can become valid data
  *    Outputs    : none
  *    Description: The SetValid task is called upon an input signal transition
  *                 which is an output enabling event.  When called, SetValid
  *                 checks to see if this new delay is longer than the one that
  *                 is currently set, if so it updates the delay until valid
  *                 data is put onto the output.
  */
  task SetValid;
  input [63:0] delayTime;
    begin
      if ((delayTime+$time > timeValid) || (timeValid < $time)) begin
        timeValid = delayTime + $time;
        disable waitValid; 
        disable goValid;
      end
    end
  endtask
  
  always fork
    begin:  goValid
      #(timeValid - $time) if (OutputEnable == 1'b0) 
        outputData = inputData;
    end // goValid
    begin: waitValid
      wait (`FALSE);
    end
  join
  
  /*****Task Definition********************
  *
  *    Task Name  : [modOutputBuffer].SetX
  *    Inputs     : delayTime -- Time until output can become invalid
  *    Outputs    : none
  *    Description: The SetX task is called upon an input signal transition which
  *                 is an output invalidating event.  When called, SetX checks
  *                 to see if this new delay is shorter than the one that is
  *                 currently set, if so it updates the delay until invalid data
  *                 (XXXXh) is put onto the output.
  */
  task SetX;
  input [63:0] delayTime;
    begin
      if ((delayTime+$time < timeX) || (timeX < $time)) begin
        timeX = delayTime + $time;
        disable waitX;
        disable goX;
        if (timeX < timeValid)
          disable goValid;
      end
    end
  endtask
  
  always fork
    begin : goX
      #(timeX - $time) if ((OutputEnable == `VIL) || (timeHighZ > timeX))
        outputData = 16'hX;
    end // goX
    begin: waitX
      wait (`FALSE);
    end
  join
  
  /*****Task Definition********************
  *
  *    Task Name  : [modOutputBuffer].SetHighZ
  *    Inputs     : delayTime -- Time until output can become high impedence
  *    Outputs    : none
  *    Description: The SetHighZ task is called upon an input signal transition
  *                 which is an output disabling event.  When called, SetHighZ checks
  *                 to see if this new delay is shorter than the one that is
  *                 currently set, if so it updates the delay until the output
  *                 goes to high impedence (ZZZZh).
  */
  task SetHighZ;
  input [63:0] delayTime;
    begin
      if ((delayTime+$time < timeHighZ) || (timeHighZ < $time)) begin
        timeHighZ = delayTime + $time;
        disable waitHighZ;
        if (timeHighZ < timeValid)
          disable goValid;
        if (timeHighZ < timeX)
          disable goX;
      end
    end
  endtask
  
  always begin: waitHighZ
    #(timeHighZ - $time) outputData = 16'hZ;
    wait (`FALSE);
  end
  
endmodule

/*****Module Definition****************************************************
*
*    Module Name : modProgramHandler
*    Inputs      : data    -- The command and data to be programmed
*                  address -- The address at which data will be programmed
*                  voltOK  -- VIH when no voltage problems exist                 
*                  Verbose, Debug -- for decriptions of device and model behavior
*    Outputs     : none
*    Description : This module handles all program-related writes to the device.
*                  It remains in a sleep mode until either of the program
*                  commands are written to the device.  Upon one of these commands
*                  modProgramHandler waits for the next write and sends that data
*                  to the memory module to be programmed.
*/
module modProgramHandler(data,address,byteb,voltOK,Verbose,Debug);
  input [`WORD] data;
  input [`AddrRange] address;
  input byteb, voltOK;
  input Verbose, Debug;
  event evtErrorCheck, evtComplete;
  reg [`BYTE] ErrFlag;
  reg [`WORD] latchData;
  reg [`AddrRange] latchAddress;
  reg Busy, Suspended;

  time startTime, delayTime;

  initial begin                 // constructor sequence
    Busy = `FALSE;
    Suspended = `FALSE;
    delayTime = `ProgramTime;
  end

  function IsBusy;              // boolean function primitive
  input required;               // all functions require a parameter
    IsBusy = Busy;              // return Boolean value
  endfunction
  
  function IsSuspended;         // boolean function primitive       
  input required;               // all functions require a parameter
    IsSuspended = Suspended;    // return Boolean value             
  endfunction                                                       

  function IsAddrSuspended;     // boolean function primitive       
  input [`AddrRange] addr;
    IsAddrSuspended = (Suspended && (addr == latchAddress));
  endfunction

  /*****Task Definition********************
  *
  *    Task Name  :  [modProgramHandler].Suspend
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Keeps track of program time through suspend operations
  */
  task Suspend;
  output [`BYTE] suspErrFlag;
  reg [`BYTE] suspErrFlag;
    begin
      delayTime = delayTime - ($time - startTime);
      #`Program_Suspend
      suspErrFlag = `NoErr;
      ErrFlag = `Suspended;
      Suspended = `TRUE;
      -> evtComplete;
    end
  endtask

  /*****Task Definition********************
  *
  *    Task Name  :  [modProgramHandler].Resume
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Restarts programming operation after suspend  (1st priority)
  */
  task Resume;
  output [`BYTE] ErrFlag;
    begin
      Suspended = `FALSE;
      Program(ErrFlag);
    end
  endtask

  /*****Task Definition********************
  *
  *    Task Name  :  [modProgramHandler].Program
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Main programming execution
  */
  task Program;
  output [`BYTE] outErrFlag;
  reg [`BYTE] outErrFlag;
    begin
      if (delayTime == `ProgramTime) begin
        latchData = data;
        latchAddress = address;
      end
      fork
        begin : Operation
          Busy = `TRUE;
          startTime = $time;
          -> evtErrorCheck;
          #delayTime
          memory.ProgramByte(latchData[`LOWER],latchAddress,ErrFlag);
          if (byteb) memory.ProgramByte(latchData[`UPPER],latchAddress+1,ErrFlag);
          delayTime = `ProgramTime;
          -> evtComplete;
        end
        @evtComplete
          disable Operation;
      join
      outErrFlag = ErrFlag;
      Busy = `FALSE;
    end
  endtask

  always @(evtErrorCheck) begin
    ErrFlag = `NoErr;
    if (LockHandler.IsLocked(latchAddress) && !LockHandler.lockOverride)
      ErrFlag = `LockErr;
    else if (memory.IsSuspended(latchAddress))
      ErrFlag = `SuspAccErr;
    else if (!voltOK)
      ErrFlag = `VoltErr;

    if (ErrFlag != `NoErr)
      ->evtComplete;
    else
      fork : ErrorCheck
        @(byteb) ErrFlag = `BytebErr;
        @(negedge LockHandler.lockOverride) ErrFlag = `LockErr;
        @(negedge voltOK) ErrFlag = `VoltErr;
        @(ErrFlag) -> evtComplete;
        @(evtComplete) disable ErrorCheck;
      join
  end
  
endmodule

/*****Module Definition****************************************************
*
*    Module Name : modEraseHandler
*    Inputs      : data    -- The erase and confirm commands are passed through here
*                  address -- The address of the block to be erased
*                  Verbose -- Provides more explanation during simulation (debug aid)
*    Outputs     : none
*    Description : This module handles all erase-related writes to the device.
*                  It remains in a sleep mode until the erase command is written
*                  to the device.  Upon this command modEraseHandler waits for
*                  the confirm command and then tells the memory module to erase
*                  the block at the specified address.
*/
module modEraseHandler(address,voltOK,Verbose,Debug);
  input [`AddrRange] address;
  input voltOK;
  input Verbose, Debug;
  event evtErrorCheck, evtComplete;
  reg [`BYTE] ErrFlag;
  reg [`AddrRange] latchAddress;
  reg Busy, Suspended;
  integer i;
  time startTime, delayTime;

  initial begin                   // constructor sequence             
    Busy = `FALSE;                                                    
    Suspended = `FALSE;                                               
    delayTime = `EraseTimeBlock;                                      
  end         
                                                                      
  function IsBusy;                // boolean function primitive       
  input required;                 // all functions require a parameter
    IsBusy = Busy;                // return Boolean value             
  endfunction                                                         
                                                                      
  function IsSuspended;           // boolean function primitive       
  input required;                 // all functions require a parameter
    IsSuspended = Suspended;      // return Boolean value             
  endfunction                                                         
                                                                      
  function IsAddrSuspended;       // boolean function primitive       
  input [`AddrRange] addr;
    IsAddrSuspended = (Suspended && ((memory.BlockNum(addr) == memory.BlockNum(latchAddress))));
  endfunction

  /*****Task Definition********************
  *
  *    Task Name  :  [modEraseHandler].Suspend
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Keeps track of erase through suspend operations
  */
  task Suspend;
  output [`BYTE] outErrFlag;
  reg [`BYTE] outErrFlag;
    begin
      delayTime = delayTime - ($time - startTime);
      #`Erase_Suspend
      outErrFlag = `NoErr;
      ErrFlag = `Suspended;
      Suspended = `TRUE;
      -> evtComplete;
    end
  endtask

  /*****Task Definition********************
  *
  *    Task Name  :  [modEraseHandler].Resume
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Restarts erase operation after suspend (2nd priority)
  */
  task Resume;
  output [`BYTE] ErrFlag;
    begin
      Suspended = `FALSE;
      Erase(ErrFlag);
    end
  endtask
  
  /*****Task Definition********************
  *
  *    Task Name  :  [modEraseHandler].Erase
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Main execution of erasing memory blocks
  */
  task Erase;
  output [`BYTE] outErrFlag;
  reg [`BYTE] outErrFlag;
    begin
      if (delayTime == `EraseTimeBlock) begin
        latchAddress = memory.BlockNum(address) << `EraseBlockAddrSize;
      end
      fork
        begin : Operation
          Busy = `TRUE;
          startTime = $time;
          -> evtErrorCheck;
          #delayTime
          memory.EraseBlock(i+latchAddress,ErrFlag);
          delayTime = `EraseTimeBlock;
          -> evtComplete;
        end
        @evtComplete
          disable Operation;
      join
      outErrFlag = ErrFlag;
      Busy = `FALSE;
    end
  endtask

  always @(evtErrorCheck) begin
    ErrFlag = `NoErr;
    if (LockHandler.IsLocked(latchAddress) && !LockHandler.lockOverride)
      ErrFlag = `LockErr;
    else if (device.Suspended)
      ErrFlag = `SuspCmdErr;
    else if (!voltOK)
      ErrFlag = `VoltErr;

    if (ErrFlag != `NoErr)
      ->evtComplete;
    else
      fork : ErrorCheck
        @(negedge LockHandler.lockOverride) ErrFlag = `LockErr;
        @(negedge voltOK) ErrFlag = `VoltErr;
        @(ErrFlag) -> evtComplete;
        @(evtComplete) disable ErrorCheck;
      join
  end


endmodule

/*****Module Definition****************************************************
*
*    Module Name : modLockHandler
*    Inputs      : address
*                  lockOverride -- needs to be VHH for override to occur
*                  voltOK  -- VIH when no voltage problems exist                 
*                  Verbose, Debug -- for decriptions of device and model behavior
*    Outputs     : none
*    Description : Main execution of Locking features of the device
*/
module modLockHandler(address, voltOK, lockOverride, Verbose, Debug);
  input [`AddrRange] address;
  input voltOK, lockOverride;
  input Verbose, Debug;
  reg BlockLockArray [`NumEraseBlocks1:0];  // Note: BlockLockArray[`NumEraseBlocks1] = Master Lock Bit
  reg [`BYTE] ErrFlag;
  reg Busy;
  reg [`AddrRange] latchAddress;
  event evtErrorCheck, evtComplete;
  integer i, ptrFile;

  initial begin                                     // constructor sequence             
    Busy = `FALSE;
    for (i=0;i<=`NumEraseBlocks1;i=i+1)
      BlockLockArray[i] = `UNLOCKED;
    $readmemh(`BlockLockInFile,BlockLockArray);     // Read in initial configuration
  end
  
  always @(device.evtReset) begin
    if ($time != 0) begin
      ptrFile = $fopen(`BlockLockOutFile);          // write block lock status to file
      for (i=0; i<=`NumEraseBlocks1; i=i+1)
        $fdisplay(ptrFile,"@%h %h",i[`AddrRange],BlockLockArray[i]);
      $fclose(ptrFile);
    end
  end
  
  function IsBusy;              // boolean function primitive       
  input required;               // all functions require a parameter
    IsBusy = Busy;              // return Boolean value             
  endfunction                                                       
                                                                    
  function IsLocked;            // boolean function primitive       
  input [`AddrRange] address;
    IsLocked = (BlockLockArray[memory.BlockNum(address)] == `LOCKED) ? `TRUE : `FALSE;
  endfunction  

  /*****Task Definition********************
  *
  *    Task Name  :  [modLockHandler].Lock
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Main execution of locking memory blocks
  */
  task Lock;
  output [`BYTE] outErrFlag;
  reg [`BYTE] outErrFlag;
    begin
      Busy = `TRUE;
      latchAddress = address;
      fork
        begin : Operation
          -> evtErrorCheck;
          #`Set_LockBit
          BlockLockArray[memory.BlockNum(latchAddress)] = `LOCKED;
          -> evtComplete;
        end
        @evtComplete
          disable Operation;
      join
      outErrFlag = ErrFlag;
      Busy = `FALSE;
    end
  endtask

  /*****Task Definition********************
  *
  *    Task Name  :  [modLockHandler].Clear
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Clears lock status of all blocks
  */
  task Clear;
  output [`BYTE] outErrFlag;
  reg [`BYTE] outErrFlag;
    begin
      Busy = `TRUE;
      fork
        begin : Operation
          -> evtErrorCheck;
          #`Clear_LockBit
          for (i=0;i<=`NumEraseBlocks1;i=i+1)
            BlockLockArray[i] = `UNLOCKED;
          -> evtComplete;
        end
        @evtComplete
          disable Operation;
      join
      outErrFlag = ErrFlag;
      Busy = `FALSE;
    end
  endtask

  /*****Task Definition********************
  *
  *    Task Name  :  [modLockHandler].MasterLock
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Sets Master Lock Bit of device
  */
  task MasterLock;
  output [`BYTE] outErrFlag;
  reg [`BYTE] outErrFlag;
    begin
      Busy = `TRUE;
      fork
        begin : Operation
          -> evtErrorCheck;
          #`Set_LockBit
          BlockLockArray[`MasterBit] = `LOCKED;
          -> evtComplete;
        end
        @evtComplete
          disable Operation;
      join
      outErrFlag = ErrFlag;
      Busy = `FALSE;
    end
  endtask

  always @(evtErrorCheck) begin
    ErrFlag = `NoErr;
    if ((BlockLockArray[`MasterBit] == `LOCKED) && !lockOverride)
      ErrFlag = `LockErr;
    else if (device.Suspended)
      ErrFlag = `SuspCmdErr;
    else if (!voltOK)
      ErrFlag = `VoltErr;

    if (ErrFlag != `NoErr)
      ->evtComplete;
    else
      fork : ErrorCheck
        @(negedge lockOverride) ErrFlag = `LockErr;
        @(negedge voltOK) ErrFlag = `VoltErr;
        @(ErrFlag) -> evtComplete;
        @(evtComplete) disable ErrorCheck;
      join
  end

endmodule

/*****Module Definition****************************************************
*
*    Module Name : modReadHandler
*    Inputs      : data,address
*                  voltOK  -- VIH when no voltage problems exist
*                  Verbose, Debug -- for decriptions of device and model behavior
*    Outputs     : dataOutput -- Results of read command
*    Description : Operation Hander to recognize all read commands/modes.
*/
module modReadHandler(dataOutput,address,voltOK,Verbose,Debug);
  output [`WORD] dataOutput;
  input [`AddrRange] address;
  input voltOK;
  input Verbose, Debug;
  reg [`WORD] dataOutput, regReadConfiguration;
  reg [1:0] Mode;
  reg [`BYTE] ErrFlag;

  initial begin                // constructor sequence
    regReadConfiguration = 0;  // Default to byte/word mode
  end

  /*****Task Definition********************
  *
  *    Task Name  :  [modReadHandler].SetMode
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Execution result of setting read mode of device
  */
  task SetMode;
  input [1:0] newMode;
  output [`BYTE] ErrFlag;
    begin
      ErrFlag = `NoErr;
      Mode = newMode;
      if (Verbose)
        case (Mode)
          `ReadArray   : $display ("%t  Device now in ReadArray Mode ", $time);
          `ReadQuery   : $display ("%t  Device now in ReadQuery Mode ", $time);
          `ReadID      : $display ("%t  Device now in ReadID Mode ", $time);
          `ReadStatus  : $display ("%t  Device now in ReadStatus Mode ", $time); 
          default      : $display("%t  Model ReadMode error.", $time);
        endcase
    end
  endtask

  /*****Task Definition********************
  *
  *    Task Name  :  [modReadHandler].SetPageMode
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Specifically enables/disables page mode read access
  */
  task SetPageMode;
    input [`WORD] newConfiguration;
    output [`BYTE] ErrFlag;
    begin
      ErrFlag = `NoErr;
      regReadConfiguration = newConfiguration; // Set MSB to indicate page mode
      if (Verbose) $display ("%t  Device now in Page Mode ", $time); 
    end
  endtask

  /*****Function Definition****************
  *
  *    Function Name :  [modReadHandler].UsePageMode
  *    Inputs        :  required -- all functions require a parameter (not used)
  *    Outputs       :  none
  *    Description   :  This is a boolean function that returns true
  *                     if read mode and configuration indicate page mode
  */
  function UsePageMode;
  input required;
    if ((regReadConfiguration[15] == `TRUE) && (Mode == `ReadArray))
      UsePageMode = `TRUE;
    else
      UsePageMode = `FALSE;
  endfunction
  
  always @device.evtReset begin
    Mode = `ReadArray;
  end
  
  always @(negedge device.Ready) begin   // Configure according to status register
    Mode = `ReadStatus;
  end
 
  always @device.evtRead begin           // Main execution of a read is based on an event
    case (Mode)
      `ReadArray   : dataOutput = memory.Get(address);
      `ReadQuery   : dataOutput = QueryTable.Get(address);
      `ReadID      : dataOutput = IDTable.Get(address);
      `ReadStatus  : dataOutput = SR.All;
      default      : $display("%t  Model error.", $time);
    endcase
    if (Verbose) $display("%t  Read result : %hh, %bb", $time,dataOutput,dataOutput);
    if ((Mode == `ReadArray) && (memory.IsSuspended(address) == `TRUE)) begin
      dataOutput = 16'hXX;
      device.SetWarning(`ReadArrayCmd,8'hXX,`SuspAccWrn);
    end
  end

endmodule

/*****Module Definition****************************************************
*
*    Module Name :  modBufferWriteHandler
*    Inputs      :  data, address
*                   byteb   -- used to set byte count from write count command
*                   voltOK  -- VIH when no voltage problems exist
*                   Verbose, Debug -- for decriptions of device and model behavior
*    Outputs     :  none
*    Description :  Operation Hander to detect buffered writes
*/
module modBufferWriteHandler(data,address,byteb,voltOK,Verbose,Debug);
  input [`WORD] data;
  input [`AddrRange] address;
  input byteb, voltOK, Verbose, Debug;
  event evtErrorCheck, evtComplete, evtWatchAddress;
  reg [`BYTE] ErrFlag, Count;
  reg [`BYTE] bufferData [`WriteBufferRange];
  reg [`AddrRange] latchAddress, startAddress;
  reg Busy, Suspended, Empty;
  time startTime, delayTime;
  integer i;
  
  initial begin                 // constructor sequence             
    Busy = `FALSE;                                                  
    Suspended = `FALSE;
    Empty = `TRUE;
    delayTime = `BufferTime;                                        
  end                                                               
                                                                    
  function IsBusy;              // boolean function primitive       
  input required;               // all functions require a parameter
    IsBusy = Busy;              // return Boolean value             
  endfunction                                                       
                                                                    
  function IsSuspended;         // boolean function primitive       
  input required;               // all functions require a parameter
    IsSuspended = Suspended;    // return Boolean value             
  endfunction                                                       
                                                                    
  function IsAddrSuspended;     // boolean function primitive       
  input [`AddrRange] addr;
    IsAddrSuspended = (Suspended && ((addr >= startAddress) && (addr < (startAddress + Count))));
  endfunction

  function [`BYTE] GetCount;    // gets the number of writes (of bytes of words, depending on byteb)
  input required;
    GetCount = Count;
  endfunction

  task SetCount;                // sets the number of writes
  output [`BYTE] outErrFlag;
  reg [`BYTE] outErrFlag;
    begin
      outErrFlag = `NoErr;
      latchAddress = address;
      Count = data + 1;
      if (Count * (byteb+1) > `WriteBufferSize)
        outErrFlag = `BuffSizeErr;
      else if (memory.BlockNum(latchAddress) != memory.BlockNum(latchAddress + Count * (byteb+1)))
        outErrFlag = `BlAddrErr;
      else
        -> evtWatchAddress;
    end
  endtask
  
  /*****Task Definition********************
  *
  *    Task Name  :  [modBufferWriteHandler].Suspend
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the operation
  *    Description:  Keeps track of erase through suspend operations
  */
  task Suspend;
  output [`BYTE] outErrFlag;
  reg [`BYTE] outErrFlag;
    begin
      delayTime = delayTime - ($time - startTime);
      #`Buffer_Suspend
      outErrFlag = `NoErr;
      ErrFlag = `Suspended;
      Suspended = `TRUE;
      -> evtComplete;
    end
  endtask

  /*****Task Definition********************
  *
  *    Task Name  :  [modBufferWriteHandler].Resume
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Restarts buffered write sequence after a suspend
  */
  task Resume;
  output [`BYTE] ErrFlag;
    begin
      Suspended = `FALSE;
      Program(ErrFlag);
    end
  endtask

  task Load;
  output [`BYTE] ErrFlag;
    begin
      if (Empty) begin
        startAddress = address;
        if (Verbose) $display("%t Buffer start address = %h",$time,startAddress);
        Empty = `FALSE;
      end
      bufferData[address[`WriteBufferAddrRange]] = data[`LOWER];
      if (byteb) bufferData[address[`WriteBufferAddrRange]+1] = data[`UPPER];
    end
  endtask
  
  /*****Task Definition********************
  *
  *    Task Name  :  [modBufferWriteHandler].Program
  *    Inputs     :  none
  *    Outputs    :  ErrFlag -- returns the status of the program operation
  *    Description:  Main programming execution of write buffer
  */
  task Program;
  output [`BYTE] outErrFlag;
  reg [`BYTE] outErrFlag;
    begin
      Busy = `TRUE;
      fork
        begin : Operation
          startTime = $time;
          -> evtErrorCheck;
          -> evtWatchAddress; // disable address watch
          #delayTime
          for (i=startAddress;i<(`WriteBufferSize+startAddress);i=i+1) begin
            memory.ProgramByte(bufferData[i[`WriteBufferAddrRange]],i,ErrFlag);
          end
          delayTime = `BufferTime;
          -> evtComplete;
        end
        @evtComplete
          disable Operation;
      join
      for (i=0;i<`WriteBufferSize;i=i+1)
        bufferData[i] = 8'hFF;
      Empty = `TRUE;
      outErrFlag = ErrFlag;
      Busy = `FALSE;
    end
  endtask

  always @(evtErrorCheck) begin
    ErrFlag = `NoErr;
    if (LockHandler.IsLocked(latchAddress) && !LockHandler.lockOverride)
      ErrFlag = `LockErr;
    else if (device.Suspended)
      ErrFlag = `SuspCmdErr;
    else if (!voltOK)
      ErrFlag = `VoltErr;

    if (ErrFlag != `NoErr)
      ->evtComplete;
    else
      fork : ErrorCheck
        @(byteb) ErrFlag = `BytebErr;
        @(negedge LockHandler.lockOverride) ErrFlag = `LockErr;
        @(negedge voltOK) ErrFlag = `VoltErr;
        @(ErrFlag) -> evtComplete;
        @(evtComplete) disable ErrorCheck;
      join
  end
  
  always @(evtWatchAddress) fork : AddressWatch
    while (`TRUE)
      @address
        if (memory.BlockNum(address) != memory.BlockNum(latchAddress)) begin
          ErrFlag = `AddrTogErr;
          -> evtComplete;
        end
    @evtWatchAddress
      disable AddressWatch;
  join
  
endmodule

/*****Module Definition****************************************************
*
*    Module Name :  modStatusConfigHandler
*    Inputs      :  Verbose, Debug -- for decriptions of device and model behavior
*    Outputs     :  sts            -- status output configuration
*    Description :  Execution Handler to configure status mode
*/
module modStatusConfigHandler(sts,Verbose,Debug);
  output sts;
  input Verbose, Debug;
  reg sts;
  reg [1:0] Config;
  reg [`BYTE] ErrFlag;
  
  initial begin                      // constructor sequence
    Config = `RdyBsy;                // default configuration is Ready/Busy
  end

  always @(device.Ready or Config) begin
    if (Config == `RdyBsy)
      sts = device.Ready;
  end

  task SetProgramPulse;              // configure STS to pulse on program complete
  output [`BYTE] ErrFlag;
    begin
      if (Config != `ProgramPulse)
        ErrFlag = `NoErr;
      else
        ErrFlag = `Redundancy;
      Config = `ProgramPulse;
    end
  endtask

  task SetErasePulse;                // configure STS to pulse on erase complete
  output [`BYTE] ErrFlag;
    begin
      if (Config != `ErasePulse)
        ErrFlag = `NoErr;
      else
        ErrFlag = `Redundancy;
      Config = `ErasePulse;
    end
  endtask

  task SetBothPulse;                // configure STS to pulse on both erase & program complete
  output [`BYTE] ErrFlag;
    begin
      if (Config != `BothPulse)
        ErrFlag = `NoErr;
      else
        ErrFlag = `Redundancy;
      Config = `BothPulse;
    end
  endtask

  task SetDefault;
  output [`BYTE] ErrFlag;
    begin
      if (Config != `RdyBsy)
        ErrFlag = `NoErr;
      else
        ErrFlag = `Redundancy;
      Config = `RdyBsy;
    end
  endtask
  
  always @(ProgramHandler.evtComplete) begin
    if ((Config == `ProgramPulse) || (Config == `BothPulse)) begin
      sts = `VIL;
      #`STSPulseWidth  sts = `VIH;
    end
  end
  
  always @(EraseHandler.evtComplete) begin
    if ((Config == `ErasePulse) || (Config == `BothPulse)) begin
      sts = `VIL;
      #`STSPulseWidth  sts = `VIH;
    end
  end
  
endmodule

/*****Module Definition****************************************************
*
*    Module Name : modMemory
*    Inputs      : Verbose, Debug
*    Outputs     : none
*    Description : This is the main memory array.  Note that the entire contents 
*                  of the memory array are read out to a file upon device reset.
*/
module modMemory(Verbose,Debug);
  input Verbose,Debug;
  
  reg [`BYTE] Array [`MemoryRange];
  reg [`BYTE] ErrFlag;
  integer ptrFile, i, j;  
  
  initial begin
    ErrFlag = `NoErr;
    if (Verbose) $display("Formatting memory array...");
    for (i = 0; i <= `MemorySize; i = i + 1) 
       Array[i] = 8'hFF;                // Precondition Array Bytes to FFh
    $readmemh(`MemoryInFile,Array);
  end
  
  always @(device.evtReset) begin
    if ($time != 0) begin
  
      // Write memory contents to file
      ptrFile = $fopen(`MemoryOutFile);
      j =0;
      for (i=0; i<`MemorySize;i=i+1) begin
        if (Array[i]!=8'hFF)  begin
          if (j == 0) begin
            $fwrite(ptrFile,"\n@%h %h ", i, Array[i]);
            j = j + 1;
          end
          else if (j < 16 ) begin
            $fwrite(ptrFile,"%h ", Array[i]);
            j = (j + 1) % 16;
          end
        end
        else
          j = 0;  // reset j to a new line
      end
      $fclose(ptrFile);
    end
  end
  
  /*****Function Definition****************
  *
  *    Function Name:  [modMemory].Get
  *    Inputs       :  address
  *    Outputs      :  none
  *    Description  :  Returns the data word at a given address
  */
  function [`WORD] Get;
  input [`AddrRange] address;
      Get = {Array[address+1],Array[address]};
  endfunction
  
  /*****Function Definition****************
  *
  *    Function Name:  [modMemory].BlockNum
  *    Inputs       :  address
  *    Outputs      :  none
  *    Description  :  Returns the block number of a given address
  */
  function [`AddrRange] BlockNum;
  input [`AddrRange] address;
    begin
      BlockNum = address >> `EraseBlockAddrSize;
    end
  endfunction
  
  /*****Function Definition****************
  *
  *    Function Name :  [modMemory].IsSuspended
  *    Inputs        :  address
  *    Outputs       :  none
  *    Description   :  This is a booloen function that returns true
  *                     if two addresses are in the same block.
  */
  function IsSuspended;
  input [`AddrRange] address;
    IsSuspended = ProgramHandler.IsAddrSuspended(address) || EraseHandler.IsAddrSuspended(address)
                   || BufferHandler.IsAddrSuspended(address);
  endfunction

  /*****Function Definition****************
  *
  *    Function Name :  [modMemory].ProgramByte
  *    Inputs        :  address, data
  *    Outputs       :  ErrFlag
  *    Description   :  Erases a memory block
  */
  task ProgramByte;
  input [`BYTE] data;
  input [`AddrRange] address;
  output [`BYTE] ErrFlag;
    begin
      ErrFlag = `NoErr;
      Array[address] = Array[address] & data;
      if (Array[address] != data)
        ErrFlag = `PreProgErr;
    end
  endtask
  
  /*****Function Definition****************
  *
  *    Function Name :  [modMemory].EraseBlock
  *    Inputs        :  address
  *    Outputs       :  ErrFlag
  *    Description   :  Erases a memory block
  */
  task EraseBlock;
  input [`AddrRange] address;
  output [`BYTE] ErrFlag;
    begin
      ErrFlag = `NoErr;
      for (i=0;i<`EraseBlockAddrSize;i=i+1)
        Array[address] = 8'hFF;
    end
  endtask
  
endmodule

/*****Module Definition****************************************************
*
*    Module Name :  modIDTable
*    Inputs      :  IsQuery --
*    Outputs     :  none
*    Description :  Data Structure containing quesry table information
*
*/
module modIDTable(IsQuery);
  input IsQuery;
  
  reg [`WORD] regQueryTable [`QueryTableRange];
  reg error;
  
  initial
    $readmemh(`QueryFile,regQueryTable);
  
  always @(posedge error)  begin
    if (IsQuery)
      device.SetWarning(`ReadQueryCmd,16'h00,`AddrWarn);
    else
      device.SetWarning(`ReadIDCmd,16'h00,`AddrWarn);
    error = `FALSE;
  end
  
  /*****Function Definition****************
  *
  *    Function Name:  [modIDTable].Get
  *    Inputs       :  address --
  *    Outputs      :  none
  *    Description  :  Retrieves the contents of the query table at a given address
  */
  function [`BYTE] Get;
  input [`AddrRange] address;
  
    begin
      if (address == 0)
        Get = `ManufacturerCode;
      else if (address == 2)
        Get = `DeviceCode;
      else if ((address[`EraseBlockAddrSize-1:0] == 4) || (address == 6))
        Get = { 7'h0, LockHandler.IsLocked(address)};
      else if ((IsQuery) && (address < `QueryTableSize))
        Get = regQueryTable[address];
      else begin
        Get = 8'hXX;
        error = `TRUE;
      end
    end
  endfunction
    
endmodule

/*****Module Definition****************************************************
*
*    Module Name :  modStatusReg
*    Inputs      :  none
*    Outputs     :  none
*    Description :  Data Structure to capture behavior of the status register
*/
module modStatusReg(Verbose,Debug);
  input Verbose,Debug;
  reg EraseSuspended, EraseClearLBError, ProgramSetLBError, 
      ProgramVoltError, ProgramSuspended, ProtectionError, BufferReady;
  reg [`BYTE] ErrFlag;
  
  wire [7:0] ReadyAll = {device.Ready, EraseHandler.IsSuspended(1'bX), EraseClearLBError, ProgramSetLBError, 
                         ProgramVoltError, ProgramHandler.IsSuspended(1'bX), ProtectionError, 1'b0};
  wire [7:0] All = (device.Ready) ? ReadyAll : 8'b0zzzzzzz;

  always @(All)
    if (Verbose) $display("%t  Status Register Update: %b",$time, All);
  
  always @(device.evtReset) begin
    BufferReady = `TRUE;
    EraseSuspended = `FALSE;
    ProgramSuspended = `FALSE;
    Clear(ErrFlag);
  end
  
  always @(device.evtError) begin //Update status register bits upon specific errors
    case(device.GetError(1'bX))
      `VoltErr    : begin ProgramVoltError = `TRUE; end
      `LockErr    : begin ProtectionError = `TRUE;  end
      `CmdErr     : begin ProgramSetLBError = `TRUE; EraseClearLBError = `TRUE; end
      `AddrErr    : begin ProgramSetLBError = `TRUE; EraseClearLBError = `TRUE; end
      `BlAddrErr  : begin ProgramSetLBError = `TRUE; EraseClearLBError = `TRUE; end
      `BuffSizeErr: begin ProgramSetLBError = `TRUE; EraseClearLBError = `TRUE; end
      `AddrTogErr : begin ProgramSetLBError = `TRUE; EraseClearLBError = `TRUE; end
      `PreProgErr : begin ProgramSetLBError = `TRUE; end //(1.2) Added
    endcase
    case(device.GetCmd(4'h1))
      `ProgramCmd       : begin ProgramSetLBError = `TRUE; end
      `WriteToBufferCmd : begin ProgramSetLBError = `TRUE; end
      `EraseBlockCmd    : begin EraseClearLBError = `TRUE; end
      `LBSetupCmd       : case (device.GetCmd(4'h2))
                            `SetBlockLBCmd  : begin ProgramSetLBError = `TRUE; end
                            `SetMasterLBCmd : begin ProgramSetLBError = `TRUE; end
                            `ClearLBCmd     : begin EraseClearLBError = `TRUE; end
                          endcase
    endcase 
  end  

  /*****Task Definition********************
  *
  *    Task Name  :  [modStatusReg].Clear
  *    Inputs     :  none
  *    Outputs    :  none
  *    Description:  Resets the status register to 0's
  */
  task Clear;
  output [`BYTE] ErrFlag;
    begin
      ErrFlag = `NoErr;
      EraseClearLBError = `FALSE;
      ProgramSetLBError = `FALSE;
      ProgramVoltError  = `FALSE;
      ProtectionError   = `FALSE;
    end
  endtask

endmodule

/*****Module Definition****************************************************
*
*    Module Name :  modDeviceInfo
*    Description :  Device control and state information monitored here
*/
module modDeviceInfo(rpb,vcc,vpen, vccq, Verbose, Debug);
  input [31:0] vcc, vpen, vccq, rpb;
  input Verbose, Debug;
  event evtCommand, evtVerify, evtError, evtComplete, evtReset, evtRead, evtProgramComplete, evtEraseComplete;
  reg voltOK, progVoltOK, eraseVoltOK, lockVoltOK, ioVoltOK, lockOverrideOK;
  reg [8'hFF:0] evtDecode1;
  reg [16'hFFFF:0] evtDecode2;
  reg [`BYTE] lastErrFlag, lastCmd1, lastCmd2;
  wire Ready = !ProgramHandler.Busy && !EraseHandler.Busy && 
               !LockHandler.Busy && !BufferHandler.Busy;
  wire Suspended = ProgramHandler.Suspended || BufferHandler.Suspended || EraseHandler.Suspended;
  
  initial begin                 // constructor sequence
    evtDecode1 = 8'h00;         // initialize decode success status variables
    evtDecode2 = 16'h00;
  end
  
  always @ (voltOK) begin
    if (!voltOK) $display("%t *ERROR: Invalid operating voltage.",$time);
    -> evtError;
  end
  
  // 
  //  Check Voltage Constraints
  //
  always @(rpb) begin
    if ((rpb >= `VhhMin) && (rpb <= `VhhMax))
      lockOverrideOK = `TRUE;
    else
      lockOverrideOK = `FALSE;
  end
  
  always @(vcc) begin
    if ((vcc < `VccMin) | (vcc > `VccMax))
      voltOK = `FALSE;
    else
      voltOK = `TRUE;
  end
    
  always @(vcc or vpen) begin // program/erase/lock
    if ((vpen < `VpenHMin) | (vpen > `VpenHMax) | !voltOK) begin
      progVoltOK  = `FALSE;
      eraseVoltOK = `FALSE;
      lockVoltOK  = `FALSE;
    end
    else begin 
      progVoltOK  = `TRUE;
      eraseVoltOK = `TRUE;
      lockVoltOK  = `TRUE;
    end
  end
  
  always @(vcc or vccq) begin  // check i/o voltage constraints
    if ((voltOK) &&
        (((vccq >= `VccQ1Min) && (vccq <= `VccQ1Max)) || 
         ((vccq >= `VccQ2Min) && (vccq <= `VccQ2Max))))
      ioVoltOK = `TRUE;
    else 
      ioVoltOK = `FALSE;
  end

  function [`BYTE] GetError;
  input required;
    GetError = lastErrFlag;
  endfunction

  function [`BYTE] GetCmd;
  input commandNum;
    GetCmd = (commandNum == 1) ? lastCmd1 : lastCmd2;
  endfunction

  /*****Task Definition********************
  *
  *    Task Name  :  [modDevice].SetWarning and [modDevice].SetError
  *    Inputs     :  Cmd1, Cmd2
  *    Outputs    :  none
  *    Description:  Sets specific device errors
  */
  task SetWarning;
  input [`BYTE] Cmd1,Cmd2;
  input [`BYTE] ErrFlag;
    begin
      Report(Cmd1,Cmd2,ErrFlag);
      lastErrFlag = ErrFlag;
      //case (ErrFlag)
      //endcase
    end
  endtask

  task SetError;
  input [`BYTE] Cmd1,Cmd2;
  input [`BYTE] ErrFlag;
    begin
      SetWarning(Cmd1,Cmd2,ErrFlag);
      -> evtError; // Only errors set error event
    end
  endtask
  
  /*****Task Definition********************
  *
  *    Task Name  :  [modDevice].Report
  *    Inputs     :  Cmd1, Cmd2
  *    Outputs    :  none
  *    Description:  Reports errors of the device operation based on command
  */
  task Report;
  input [`BYTE] Cmd1, Cmd2;
  input [`BYTE] ErrFlag;
    begin
      lastErrFlag = ErrFlag;
      lastCmd1 = Cmd1;
      lastCmd2 = Cmd2;
        if ((lastErrFlag != `NoErr) || Verbose) begin //Display error and trigger "evtError" to update status.
          $write("%t",$time);
           case(ErrFlag)
            `NoErr      : begin $write("  Successful completion "); end
            `VoltErr    : begin $write(" *ERROR: Insufficient voltage "); -> evtError; end
            `LockErr    : begin $write(" *ERROR: Cannot complete operation due to lock; must raise rpb to Vhh to override "); -> evtError; end
            `BytebErr   : begin $write(" *ERROR: Cannot toggle byteb while busy"); -> evtError; end
            `SuspCmdErr : begin $write(" *ERROR: Cannot execute this command during suspend"); -> evtError; end
            `SuspAccErr : begin $write(" *ERROR: Cannot access this address due to suspend"); -> evtError; end
            `SuspAccWrn : begin $write(" *WARNING: Cannot access this address due to suspend"); end
            `CmdErr     : begin $write(" *ERROR: Invalid command received"); -> evtError; end
            `AddrErr    : begin $write(" *ERROR: Address out of valid range"); -> evtError; end
            `BlAddrErr  : begin $write(" *ERROR: Buffered write cannot cross block boundary"); -> evtError; end
            `AddrWarn   : begin $write(" *WARNING: Address out of valid range"); end
            `PreProgErr : begin $write(" *ERROR: Cannot program to a non-erased cell"); -> evtError; end //(1.2) changed message, trigger evtError
            `Suspended  : begin $write("  Successful suspend of "); end
            `AddrTogErr : begin $write(" *ERROR: Cannot toggle block address during command sequence"); -> evtError; end
            `NoBusyErr  : begin $write(" *ERROR: Nothing to suspend "); end
            `NoSuspErr  : begin $write(" *ERROR: Nothing suspended "); end
            `BuffSizeErr: begin $write(" *ERROR: Buffer size is %d bytes ",`WriteBufferSize); -> evtError; end
            default     : begin $write(" *ERROR: Unknown error: %h  [cmd1=%hh, cmd2=%hh]",ErrFlag,Cmd1,Cmd2); -> evtError; end
          endcase 
          case (Cmd1)
            16'hXX            : $display(" [General Error]");
            `ReadArrayCmd     : $display(" [Read Array]");
            `ReadIDCmd        : $display(" [Read ID]");
            `ReadQueryCmd     : $display(" [Read Query]");
            `ReadCSRCmd       : $display(" [Read Status Register]");
            `ClearCSRCmd      : $display(" [Clear Status Register]");
            `SuspendCmd       : $display(" [Suspend]");
            `ResumeCmd        : $display(" [Resume]");
            `ProgramCmd       : $display(" [Program]");
            `WriteToBufferCmd : $display(" [Write to Buffer]");
            `EraseBlockCmd    : $display(" [Erase]");
            `LBSetupCmd       : case (Cmd2)
                                `SetBlockLBCmd  : $display(" [Set Block Lock Bit]");
                                `ClearLBCmd     : $display(" [Clear Lock Bits]");
                                `SetMasterLBCmd : $display(" [Set Master Lock Bit]");
                                `SetReadConfirmCmd: $display(" [Set Page Mode]");
                              endcase
            `ConfigurationCmd : case (Cmd2)
                                  `ProgramPulse   : $display("  [(STS) Set Program Pulse]");
                                  `ErasePulse     : $display("  [(STS) Set Erase Pulse]");
                                  `RdyBsy         : $display("  [(STS) Set Ready/Busy Mode]");
                                  `BothPulse      : $display("  [(STS) Set Erase/Program Pulse]");
                                endcase
            default           : $display(" [unknown command:  %hh]", Cmd1);
          endcase
        end
    end
  endtask

  /*****Task Definition********************
  *
  *    Task Name  : checkMinTime
  *    Inputs     : tstr    -- The string value of the timing constraint i.e. "TELQV"
  *                 tdiff   -- The actual constraint value
  *                 tprev   -- The time that the initial event occurred
  *    Outputs    : none
  *    Description: This task is used to check the timing constraints by comparing the difference
  *                 of the current and the initial trigger time against the timing constraint.
  *                 If the difference is less than the constraint, checkMinTime displays
  *                 and error message and sets the error event flag.
  */
  task CheckMinTime;
  input [8*6:1] tstr;
  input [31:0] tdiff, tprev;
  
  begin
    if ($time - tprev < tdiff) begin
      $display ("%t *ERROR: %0s timing constraint violation:  %0d-%0d < %0dns ", $time, tstr, $time, tprev, tdiff);
      -> evtError;
    end
  end
  endtask

endmodule 
          
/*****Task Definition********************
*
*    Task Name  : InstructionDecoder_1
*    Inputs     : dq   - device input pins
*                 Name - descriptive string name of command
*                 Cmd  - 8-bit command value
*    Outputs    : none
*    Description: This module is designed to decode a one write cycle command.
*/
module InstructionDecoder_1(dq,Name,Cmd,Verbose,Debug);
input [`BYTE] dq, Cmd;
input [8*16:1] Name;
input Verbose,Debug;
          
always @device.evtCommand begin
  if (dq == Cmd) begin
    -> device.evtVerify;
    device.evtDecode1[Cmd] = !device.evtDecode1[Cmd];
    if (Verbose) $display("%t  %0s command recognized",$time,Name);
  end
  else begin
    if (`FALSE) $display("%t  The %0s instruction decode unit is waiting for operation to complete.",$time,Name);
    @(device.evtComplete or device.evtError)
      if (`FALSE) $display("%t  The %0s instruction decode unit is listening for next command.",$time,Name);
  end
end

endmodule

/*****Module Definition********************
*
*    Module Name: InstructionDecoder_2
*    Inputs     : dq   - device input pins
*                 Name - descriptive string name of command
*                 Cmd1 - first 8-bit command value
*                 Cmd2 - second 8-bit command value
*    Outputs    : none
*    Description: This module is designed to decode a two write cycle command.
*/
module InstructionDecoder_2(dq,Name,Cmd1,Cmd2,Verbose,Debug);
input [`BYTE] dq, Cmd1, Cmd2;
input [8*16:1] Name;
input Verbose,Debug;

always @device.evtCommand begin
  if (dq == Cmd1) begin
    -> device.evtVerify;
    @device.evtCommand
      if ((dq == Cmd2) || (Cmd2 == 8'hxx)) begin
        -> device.evtVerify;
        device.evtDecode2[{Cmd1,Cmd2}] = !device.evtDecode2[{Cmd1,Cmd2}];
        if (Verbose) $display("%t %0s command sequence recognized.",$time,Name);
      end
  end
  else begin
    if (`FALSE) $display("%t  The %0s instruction decode unit is waiting for operation to complete.",$time,Name);
    @(device.evtComplete or device.evtError)
      if (`FALSE) $display("%t  The %0s instruction decode unit is listening for next command",$time,Name);
  end
end

endmodule

/*****Task Definition********************
*
*    Task Name  : InstructionDecoder_1
*    Inputs     : dq   - device input pins
*                 Name - descriptive string name of command
*                 Cmd  - 8-bit command value
*    Outputs    : none
*    Description: This module is designed to decode a one write cycle command.
*/
module BusyDecoder_1(dq,Name,Cmd,Verbose,Debug);
input [`BYTE] dq, Cmd;
input [8*16:1] Name;
input Verbose,Debug;
          
always @device.evtCommand begin
  if ((dq == Cmd) && !device.Ready) begin
    -> device.evtVerify;
    device.evtDecode1[Cmd] = !device.evtDecode1[Cmd];
    if (Verbose) $display("%t %0s command recognized",$time,Name);
  end
  else if ((dq == Cmd) && device.Ready) begin
    device.SetError(Cmd,16'bXX,`NoBusyErr);
  end
end

endmodule