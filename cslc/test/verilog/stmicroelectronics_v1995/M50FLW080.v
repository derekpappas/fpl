/******************************************************************************

  M50FLW080A/M50FLW080B Behavioral Model

  8M Bits (13 x 64K Byte Blocks + 3 x 16 x 4K Byte Sectors)
  3V Supply Firmware Hub/Low Pin Count Flash Memory

  Copyright (c) 2004 STMicroelectronics

*******************************************************************************

  Model Version : 1.3

  Author : Xue-Feng Hu

*******************************************************************************

  Model Version History:
-------------------------------------------------------------------------------
  :1.0 Jul. 2004  First Version Release.
-------------------------------------------------------------------------------
  :1.1 Sep. 2004  Correct behavior of "FWH Quad Byte Program Operation".
                  Add "VCCAUX" Supply Voltage Input Pin.
-------------------------------------------------------------------------------
  :1.2 Jan. 2005  Correct behavior of "leaving ID input pins floating".
-------------------------------------------------------------------------------
  :1.3 Feb. 2005  Change timing message's severity from "error" to "warning".
-------------------------------------------------------------------------------

*******************************************************************************

  Based on Preview Release of M50FLW080AB Spec Datasheet (May 2004)

*******************************************************************************

  THIS PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
  EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE
  IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS for A PARTICULAR
  PURPOSE. THE ENTIRE RisK AS TO THE QUALITY AND PERforMANCE OF
  THE PROGRAM is WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU
  ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

*******************************************************************************/

`timescale 1ns/1ns

`include "M50FLW080_MACRO.v"

//===============================================
//M50FLW080 memory simulation model
//===============================================
module M50FLW080(VPPH,VPP,VCC,VSS,VCCAUX,IC,CLK,INIT_N,RP_N,WP_N,TBL_N,FWH4_LFRM,GPI,ID,FWH_LAD,RFU);

//--------------------------------
//Signal IO Attribute
//--------------------------------
input VPPH,VPP,VCC,VSS,VCCAUX;    //Power Supply Voltage and Ground
input RP_N,INIT_N,TBL_N;          //Interface Reset,CPU Reset,Top Block Lock
input IC,CLK,WP_N,FWH4_LFRM;      //Interface Configure,CLK,WR Protect,Input Communication Frame
input [`GPI_NUM-1:0] GPI;         //General Purpose Inputs
input [`F_ID_NUM-1:0] ID;         //Identification Inputs
inout [`F_RFU_NUM-1:0] RFU;       //Reserved Pins,Leave Disconnected
inout [`IOC_NUM-1:0] FWH_LAD;     //FWH/LPC Input/Output Communications

//--------------------------------
//Signal and variable definition
//--------------------------------
integer start_addr_block[`BLOCK_NUM-1:0];
integer end_addr_block[`BLOCK_NUM-1:0];
integer start_addr_sector[`SECTOR_NUM-1:0];
integer end_addr_sector[`SECTOR_NUM-1:0];
integer fwh_nByteRead,fwh_nByteWrite,i,nibble;

reg FWH_LPC,A_A_MUX,A22; //reg invalid_cmd;
reg complete_flag,wr_protect;
reg power_on,fwh_interface,lpc_interface,fwh_rd,fwh_wr,lpc_rd,lpc_wr;
reg reset_fall,reset_rise,clk_fall,clk_rise,din_change,fwh4_lfr_fall;

reg [7:0] DEVICE_CODE,MANUFC_CODE;                    //8 bits code
reg [3:0] n_block,erasing_block,programming_block;    //16 blocks,4 bits addr
reg [6:0] n_sector,erasing_sector,programming_sector; //48 sectors,6 bits addr

//----------------------data output register
reg[`IOC_NUM-1:0] fwh_lpc_dout;
reg[`DATA_BITS_NUM-1:0] data_out_buf;

//----------------------input address latch register
reg[`FWH_ADDR_BITS-1:0] fwh_address;
reg[`LPC_ADDR_BITS-1:0] lpc_address;
reg[`MEM_ADDR_BITS-1:0] mem_address;
reg[`REG_ADDR_BITS-1:0] reg_address;

//----------------------input data latch register
reg[`DATA_BITS_NUM-1:0] lpc_data_in;
reg[`DATA_BITS_NUM-1:0] fwh_data_in[3:0];

//--------------------- Status Register
reg[`DATA_BITS_NUM-1:0] status_reg;

//--------------------- FWH/LPC Block Lock Register, GPI Register, ManuCode Register
reg[6:0] cr_addr;
reg[`DATA_BITS_NUM-1:0] CR[65:0];

//--------------------- Memory Array
reg[`DATA_BITS_NUM-1:0] memory[`MEMORY_SIZE-1:0];

//---------------------------------------------------------
reg[1:0] vpp_status;

//--------------------------------------------------------- 
reg[1:0] read_status;
reg[2:0] write_status;
reg[4:0] bus_op_status;
reg[2:0] running_status;
reg[2:0] previous_status;

//=========================================================
//parameter definition regarding the vpp optional power
//=========================================================
parameter vpp_lockout       = 2'b00;
parameter vpp_normal        = 2'b01;
parameter vpp_fast          = 2'b10;

//=========================================================
//parameter definition regarding the read_status 
//=========================================================
parameter read_status_reg   = 2'b00;
parameter read_elec_sign    = 2'b01;
parameter read_memory       = 2'b10;
//=========================================================
//parameter definition regarding the write_status 
//=========================================================
parameter write_command     = 3'b000;
parameter program           = 3'b001;
parameter quad_program      = 3'b010;
parameter block_erase       = 3'b011;
parameter sector_erase      = 3'b100;
parameter chip_erase        = 3'b101;
//=========================================================
//parameter definition regarding the running_status
//=========================================================
parameter Free              = 3'b000;
parameter ResetCycle_Busy   = 3'b001;
parameter ProgSusp_Busy     = 3'b010;
parameter EraseSusp_Busy    = 3'b011;
parameter Program_Busy      = 3'b100;
parameter BlockErase_Busy   = 3'b101;
parameter SectorErase_Busy  = 3'b110;
parameter ChipErase_Busy    = 3'b111;
//=========================================================
//parameter definition regarding the FWH/LPC bus operation
//=========================================================
//-------------------------------------FWH bus_op_status
parameter get_start         = 5'b00000;
parameter get_idsel         = 5'b00001;
parameter get_fwh_addr      = 5'b00010;
parameter get_fwh_msize     = 5'b00011;
parameter get_fwh_tar_in    = 5'b00100;
parameter get_fwh_data_in   = 5'b00101;
parameter fwh_tar_out_1     = 5'b00110;
parameter fwh_wsync         = 5'b00111;
parameter fwh_sync          = 5'b01000;
parameter fwh_data_out      = 5'b01001;
parameter fwh_tar_out_2     = 5'b01010;
parameter fwh_tar_float     = 5'b01011;
//-------------------------------------LPC bus_op_status
parameter get_cyctype_dir   = 5'b01100;
parameter get_lpc_addr      = 5'b01101;
parameter get_lpc_tar_in    = 5'b01110;
parameter get_lpc_data_in   = 5'b01111;
parameter lpc_tar_out_1     = 5'b10000;
parameter lpc_wsync         = 5'b10001;
parameter lpc_sync          = 5'b10010;
parameter lpc_data_out      = 5'b10011;
parameter lpc_tar_out_2     = 5'b10100;
parameter lpc_tar_float     = 5'b10101;

//=========================================================
//variables definition regarding ac characteristics
//=========================================================
time power_on_time,tr_clk,tf_clk,tr_clk_p,t_din;
time tr_reset,tf_reset,tr_fwh4_lfrm,tf_fwh4_lfrm;
time PGM_Start_Time,CE_Start_Time,BE_Start_Time,SE_Start_Time;
time BlockErase_Time,SectorErase_Time,PGM_Susp_Time,ES_Susp_Time;

//==========================================
//A/A Mux Interface Signal Name
//==========================================
reg [`AAMUX_DAT_BITS-1:0] aamux_dout;
//-------------------------------------
wire R_C = CLK;
wire G_N = INIT_N;
wire W_N = FWH4_LFRM;
wire [`AAMUX_ADD_BITS-1:0] aamux_add;
wire [`AAMUX_DAT_BITS-1:0] aamux_din;
//-------------------------------------
assign aamux_add[`AAMUX_ADD_BITS-6] = WP_N;
assign aamux_add[`AAMUX_ADD_BITS-7] = TBL_N;
assign aamux_add[`AAMUX_ADD_BITS-1:`AAMUX_ADD_BITS-5] = GPI;
assign aamux_add[`AAMUX_ADD_BITS-8:`AAMUX_ADD_BITS-11] = ID;
assign aamux_din[`AAMUX_DAT_BITS-1:`AAMUX_DAT_BITS-4] = RFU[3:0];
assign aamux_din[`AAMUX_DAT_BITS-5:`AAMUX_DAT_BITS-8] = FWH_LAD;
assign RFU[3:0] = A_A_MUX? aamux_dout[`AAMUX_DAT_BITS-1:`AAMUX_DAT_BITS-4] : 4'bz;
assign FWH_LAD = A_A_MUX? aamux_dout[`AAMUX_DAT_BITS-5:`AAMUX_DAT_BITS-8] : fwh_lpc_dout;

//===============================================
//Internal Reset Signal
//===============================================
wire reset = FWH_LPC ? INIT_N & RP_N : RP_N;

//===================================================================
//0 is signified on ID pin by driving it Low or leaving it floating
//===================================================================
wire [`F_ID_NUM-1:0] id_in;
assign id_in[0] = (ID[0]===1'b1) ? 1'b1 : 1'b0;
assign id_in[1] = (ID[1]===1'b1) ? 1'b1 : 1'b0;
assign id_in[2] = (ID[2]===1'b1) ? 1'b1 : 1'b0;
assign id_in[3] = (ID[3]===1'b1) ? 1'b1 : 1'b0;

//-----------------------------------------------
initial begin
  //invalid_cmd = 1'b0;
  //-----------------------------------//Memory Array Initialization
  $display("%t: NOTE: Load memory with Initial content.",$realtime); $readmemh("M50FLW080_Init.txt",memory);
  $display("%t: NOTE: Initial Load End.\n",$realtime);
  //-----------------------------------//Block Addresses Setup for M50FLW080AB
  for(i=0;i<`BLOCK_NUM;i=i+1)
  begin
    start_addr_block[i] = `BLOCK_SIZE * i;
    end_addr_block[i] = start_addr_block[i] + `BLOCK_SIZE - 1;
  end
  //-----------------------------------//Sector Addresses Setup for M50FLW080A
  `ifdef M50FLW080A
  DEVICE_CODE = `DEVICECODE_A;
  MANUFC_CODE = `MANUFACTURECODE;
  for(i=0;i<`SECTOR_NUM;i=i+1)
  begin
    if(i<(`SECTOR_NUM/3)) start_addr_sector[i] = `SECTOR_SIZE * i;
    else start_addr_sector[i] = `BLOCK_SIZE * (`BLOCK_NUM - 2) + `SECTOR_SIZE*(i-`SECTOR_NUM/3);
    end_addr_sector[i] = start_addr_sector[i] + `SECTOR_SIZE - 1;
  end
  `endif
  //-----------------------------------//Sector Addresses Setup for M50FLW080B
  `ifdef M50FLW080B
  DEVICE_CODE = `DEVICECODE_B;
  MANUFC_CODE = `MANUFACTURECODE;
  for(i=0;i<`SECTOR_NUM;i=i+1)
  begin
    if(i<(`SECTOR_NUM*2/3)) start_addr_sector[i] = `SECTOR_SIZE * i;
    else start_addr_sector[i] = `BLOCK_SIZE * (`BLOCK_NUM - 1) + `SECTOR_SIZE*(i-`SECTOR_NUM*2/3);
    end_addr_sector[i] = start_addr_sector[i] + `SECTOR_SIZE - 1;
  end
  `endif
  //-----------------------------------//Configuration Register Initialization
  CR_Initialization;
  //-----------------------------------
  power_on      = 1'b0;
  complete_flag = 1'b0;
  FWH_LPC       = 1'b0; 
  A_A_MUX       = 1'b0;
  clk_rise      = 1'b0;
  clk_fall      = 1'b0;
  reset_rise    = 1'b0;
  reset_fall    = 1'b0;
  bus_op_status = get_start;
  read_status   = read_memory;
  write_status  = write_command;
end

//===================================================================
//Vcc Power Supply Voltage
//-------------------------------------------------------------------
//VCC=0,VCCAUX=0: VCC is less than Max.VCC Lockout Voltage(2.3V)
//VCC=0,VCCAUX=1: VCC >= 2.3V and VCC is less than VCC_MIN(3.0V)
//VCC=1,VCCAUX=0: VCC >= 3.0V and VCC <= VCC_MAX(3.6V)
//VCC=1,VCCAUX=1: VCC is more than VCC_MAX(3.6V)
//===================================================================
always@(VCC or VCCAUX)
begin
  if(VCC == 0 && VCCAUX == 0)
  begin
    $display("%t, Warning: VCC Supply Voltage is less than the Lockout Voltage, the Command Interface is reset to Read mode!\n",$realtime);
    power_on = 1'b0;
  end
  if(VCC == 0 && VCCAUX == 1)
  begin
    $display("%t, Warning: VCC Supply Voltage is below 3V but above the Lockout Voltage, the Command Interface will accept commands but the normal execution is not guaranteed!\n",$realtime);
    power_on = 1'b0;
  end
  if(VCC == 1 && VCCAUX == 1)
  begin
    $display("%t, Warning: VCC Supply Voltage is exceed the Absolute Max. Supply Voltage, permanent damage will be caused to the device!\n",$realtime);
    power_on = 1'b0;
  end
  //-------------------------------------
  if(VCC == 1 && VCCAUX == 0)
  begin
    $display("%t, Note: VCC Supply Voltage is Powered On!\n",$realtime);
    power_on = 1'b1; power_on_time = $time;
    if(IC == 1'b1)
    begin
      A_A_MUX = 1'b1; FWH_LPC = 1'b0;   //IC pin is driven high, A/A MUX interface is selected
      $display("%t, Warning: A/A Mux Interface is not support in this model, it will be supported in future!\n",$realtime);
      $finish;
    end
    else begin
      FWH_LPC = 1'b1; A_A_MUX = 1'b0;   //IC pin is left to float or driven low, FWH or LPC interface is selected
      $display("%t, Note: FWH/LPC Interface is selected!\n",$realtime);
    end
    fwh_lpc_dout = 4'hz;                //FWH_LAD as input
    running_status = ResetCycle_Busy;   //Power on reset, device enter Reset Mode
    status_reg = 8'h80;
    read_status = read_memory;
    //#(`tPLRH);
    //----------------------------------//Power on reset is complete
    running_status = Free;              //After reset mode, device is free
    status_reg = 8'h80;
    read_status = read_memory;          //Ready to output data of memory array
    write_status = write_command;       //Ready to receive command from microcontroller
  end
end

//===================================================================
//Vpp Optional Supply Vlotage
//-------------------------------------------------------------------
//VPP=0,VPPH=0: VPP is less than 0V
//VPP=0,VPPH=1: VPP is more than VPPH_MAX(12.6V)
//VPP=1,VPPH=0: VPP >= 0V and VPP is less than VPPH_MIN(11.4V) 
//VPP=1,VPPH=1: VPP >= VPPH_MIN(11.4V) and VPP <= VPPH_MAX(12.6V)
//===================================================================
always@(VPP or VPPH)
begin
  if(VPP == 1'b0 && VPPH == 1'b0)
  begin
    $display("%t, Warning: VPP is less than 0V, Program and Erase operations cannot be performed!\n",$realtime);
    vpp_status = vpp_lockout;
  end 
  if(VPP == 1'b0 && VPPH == 1'b1)
  begin
    $display("%t, Warning: VPP is more than Vpp Absolute Max. Program Voltage, permanent damage will be caused to the device!\n",$realtime);
    vpp_status = vpp_lockout; 
  end
  if(VPP == 1'b1 && VPPH == 1'b0)
  begin
    //$display("%t, Note: The VPP Lockout Voltage of this device is 0V, the Program/erase operation will be carried out!\n",$realtime);
     vpp_status = vpp_normal;
  end
  if(VPP == 1'b1 && VPPH == 1'b1)
    //$display("%t, Note: The VPP is equal the VPPH, the Quad-byte Program and fast erase operation is valid!\n",$realtime);
    vpp_status = vpp_fast;
end

//===============================================
//Reset, RP_N and TBL_N(FWH), RP_N(A_A_MUX)
//===============================================
always@(reset)
begin
  if((power_on == 1'b1)&&($time - power_on_time > 0))
  begin
    if(reset == 1'b0)       //reset is driven low,device in reset mode
    begin
      if(A_A_MUX == 1'b1)   aamux_dout = {`AAMUX_DAT_BITS{1'bz}};
      else
      if(FWH_LPC == 1'b1)
      begin
        fwh_lpc_dout = {`IOC_NUM{1'bz}};
        bus_op_status = get_start;
      end
      tf_reset = $time;
      reset_fall = 1'b1;
      running_status = ResetCycle_Busy;
    end
//-------------------------------------
    else
    if(reset == 1'b1)       //reset is driven high,device in normal operation
    begin
      if(reset_fall == 1'b1)
      begin
        CR_Initialization;
        tr_reset = $time;
        reset_rise = 1'b1;
        status_reg = 8'h80;
        if(tr_reset - tf_reset < `tPLPH)
        begin
          $display("%t, Warning: Reset Pulse Width(tPLPH) violated.\n",$realtime);
        end
        else if(tr_reset - tf_reset >= `tPLPH && tr_reset - tf_reset < `tPLRH)
        begin
          running_status = ResetCycle_Busy;
          while($time - tf_reset < `tPLRH) #1;
          $display("%t, Note: Memory is Reset OK!\n",$realtime);
          running_status = Free;
          status_reg = 8'h80;
          read_status = read_memory;
          write_status = write_command;
        end
        else if(tr_reset - tf_reset >= `tPLRH)
        begin
          $display("%t, Note: Memory is reset OK!\n",$realtime);
          running_status = Free;
          status_reg = 8'h80;
          read_status = read_memory;
          write_status = write_command;
        end
      end
    end
  end
  else $display("%t, Warning: VCC Supply Voltage is Powered On! Reset is invalid!\n",$realtime);
end

//=====================================
//Interface Configure Pin
//=====================================
always@(IC)
begin
  if(((power_on == 1'b1)&&($time - power_on_time > 0))&&(running_status !== ResetCycle_Busy))
  begin
    $display("%t, Warning: IC(Interface Configuration) should not be changed during operation!\n",$realtime);
  end
  else if(((power_on == 1'b1) && ($time - power_on_time > 0))&&(running_status == ResetCycle_Busy))
  begin
    if(IC == 1'b1)    //After Power on, IC can be changed during a Reset
    begin
      A_A_MUX = 1'b1; FWH_LPC = 1'b0;
      $display("%t, Warning: A/A Mux Interface is not support in this model, it will be supported in future!\n",$realtime);
      $finish;
    end
    else begin        //IC pin is left to float or driven low, FWH or LPC interface is selected
      $display("%t, Note: FWH/LPC Interface is selected!\n",$realtime);
      A_A_MUX = 1'b0; FWH_LPC = 1'b1;
    end
  end
end

//=====================================
//Input Communication Frame
//=====================================
always@(negedge FWH4_LFRM)
begin
  tf_fwh4_lfrm = $time;
  fwh4_lfr_fall = 1'b1;
  if((reset_rise == 1'b1)&&(tf_fwh4_lfrm - tr_reset < `tPHFL))
  begin
    $display("%t, Warning: Reset High to FWH4/LFRAME Low(tPHFL) violated.\n",$realtime);
  end
  if((FWH_LPC == 1'b1)&&(power_on == 1'b1)&&($time - power_on_time > 0)&&(running_status !== ResetCycle_Busy))
  begin
    fwh_lpc_dout = 4'hz;
    if(bus_op_status !== get_start)
    begin
      bus_op_status = get_start;
      $display("%t, Warning: FWH4_LFRAME is Low during a bus operation. The operation is aborted!\n", $realtime);
    end
  end
  else if(running_status == ResetCycle_Busy)
    $display("%t, Warning: FWH4_LFRAME has no effect during RESET mode!\n",$realtime);
  else if(power_on == 1'b0)
    $display("%t, Warning: VCC Supply Voltage is Powered On! FWH4_LFRAME is invalid!\n",$realtime);
end

//=====================================
//General Purpose Inputs
//=====================================
always@(GPI)
begin
  if((FWH_LPC == 1'b1)&&((power_on == 1'b1)&&($time - power_on_time > 0))&&(running_status !== ResetCycle_Busy))
  begin
    //CR[64]: General Purpose Inputs Register
    if(GPI[0] == 1'b1) CR[64] = CR[64]|8'b00000001;
    else CR[64] = CR[64] & 8'b00011110;
    if(GPI[1] == 1'b1) CR[64] = CR[64]|8'b00000010;
    else CR[64] = CR[64] & 8'b00011101;
    if(GPI[2] == 1'b1) CR[64] = CR[64]|8'b00000100;
    else CR[64] = CR[64] & 8'b00011011;
    if(GPI[3] == 1'b1) CR[64] = CR[64]|8'b00001000;
    else CR[64] = CR[64] & 8'b00010111;
    if(GPI[4] == 1'b1) CR[64] = CR[64]|8'b00010000;
    else CR[64] = CR[64] & 8'b00001111;
  end
end

//=====================================
//Program/Erase Operation is Completed
//=====================================
always@(complete_flag)
begin
  if(running_status == ProgSusp_Busy)
  begin
    if($time - PGM_Susp_Time < `ProgSusp_Time)
      complete_flag <= #(`ProgSusp_Time - ($time - PGM_Susp_Time)) ~complete_flag;
    else begin
      $display("%t, Note: Program Suspend, Program/Erase Controller is Paused!\n",$realtime);
      status_reg = status_reg | 8'h84;  //SR=1x00_0100(84|C4),Program Suspended
      running_status = Free;
      write_status = write_command;
    end
  end
  else if(running_status == EraseSusp_Busy)
  begin
    if($time - ES_Susp_Time < `EraseSusp_Time)
      complete_flag <= #(`EraseSusp_Time - ($time - ES_Susp_Time)) ~complete_flag;
    else begin
      $display("%t, Note: Erase Suspend, Program/Erase Controller is Paused!\n",$realtime);
      status_reg = status_reg | 8'hC0;  //SR=1100_0000(C0),Block/Sector Erase Suspended
      running_status = Free;
      write_status = write_command;
    end
  end
  else begin
    if(running_status == Program_Busy)
    begin
      `ifdef M50FLW080A
      if((n_block == `TOPBLOCK)||(n_block == `TOPBLOCK-1)||(n_block == 0))
        $display("%t, Notes: Sector [%d] Program Operation Complete!\n",$realtime,programming_sector);
      else
        $display("%t, Notes: Block[%d] Program Operation Complete!\n",$realtime,programming_block);
      `endif
      `ifdef M50FLW080B
      if((n_block == `TOPBLOCK)||(n_block == 1)||(n_block == 0))
        $display("%t, Notes: Sector [%d] Program Operation Complete!\n",$realtime,programming_sector);
      else
      $display("%t, Notes: Block[%d] Program Operation Complete!\n",$realtime,programming_block);
      `endif
    end
    if(running_status == ChipErase_Busy)
      $display("%t, Notes: Chip Erase Operation Complete!\n",$realtime);
    if(running_status == BlockErase_Busy)
      $display("%t, Notes: Block[%d] Erase Operation Complete!\n",$realtime,erasing_block);
    if(running_status == SectorErase_Busy)
      $display("%t, Notes: Sector[%d] Erase Operation Complete!\n",$realtime,erasing_sector);
    running_status = Free; write_status = write_command;
    status_reg = status_reg | 8'h80;
  end
end

//=========================================================
//AC Characteristic Checking
//=========================================================
always@(posedge FWH4_LFRM)
begin
  tr_fwh4_lfrm = $time;
  if(clk_rise == 1'b1)
  begin
    if(tr_fwh4_lfrm - tr_clk < `tCHFH)
    begin
      $display("%t, Warning: Input Hold Time on FWH4_LFRAME(tCHFH) violated!\n",$realtime);
    end
  end
end
//==========================================================    
always@(FWH_LAD)
begin
  if(FWH_LAD !== 4'hz)
  begin
    t_din = $time;
    din_change = 1'b1;
    if(clk_rise == 1'b1)
    begin
      if(t_din - tr_clk < `tCHDX)
      begin
        $display("%t,Warning: Input hold time(tCHDX,tCHAX) violated.\n",$realtime);
      end
    end
  end
end
//=========================================================
always@(negedge CLK)
begin
  tf_clk = $time;
  if(clk_rise == 1'b1)
  begin
    if(tf_clk - tr_clk < `tCH)
    begin
      $display("%t, Warning: Clock High Pulse Width(tHigh) violated!\n",$realtime);
    end
  end
  clk_fall = 1'b1;
end
//=========================================================

//=========================================================
//FWH/LPC Interface and A/A Mux Interface Operation
//=========================================================
always@(posedge CLK)
begin
  tr_clk = $time;
  if(clk_rise == 1'b1)
  begin
    if(tr_clk - tr_clk_p < `tCYC)
    begin
      $display("%t, Warning: Clock Cycle Time(tCYC) violated, tCYC<30ns.\n",$realtime);
    end
  end
  clk_rise = 1'b1;
  if(fwh4_lfr_fall == 1'b1)
  begin
    if(tr_clk - tf_fwh4_lfrm < `tFLCH)
    begin
      $display("%t, Warning: Input Set-Up Time on FHW4_LFRAME(tFLCH) violated!\n",$realtime);
    end
  end
  if(clk_fall == 1'b1)
  begin
    if(tr_clk - tf_clk < `tCL)
    begin
      $display("%t, Warning: Clock Low Pulse Width(tLow) violated!\n",$realtime);
    end
  end
  if(din_change == 1'b1)
  begin
    if(tr_clk - t_din < `tDVCH)
    begin
      $display("%t, Warning: Input Set-Up Time(tDVCH,tAVCH) violated!\n",$realtime);
    end
  end
  tr_clk_p = tr_clk;
  //=============================================
  //FWH/LPC Interface operation
  //=============================================
  //------------------------------------------------START Field
  if((FWH_LPC == 1'b1)&&((power_on == 1'b1) && ($time - power_on_time > 0))&&(running_status !== ResetCycle_Busy))
  begin
    if((bus_op_status == get_start)&&(FWH4_LFRM == 1'b0))
    begin
      if((FWH_LAD == 4'b1101)||(FWH_LAD == 4'b1110))
      begin
        fwh_interface = 1'b1; lpc_interface = 1'b0; //FWH bus operation begins
        if(FWH_LAD == 4'b1101) begin fwh_rd = 1'b1; fwh_wr = 1'b0; end
        if(FWH_LAD == 4'b1110) begin fwh_wr = 1'b1; fwh_rd = 1'b0; end
        nibble = 0; bus_op_status = get_idsel;
      end
      else if(FWH_LAD == 4'b0000)
      begin
        lpc_interface = 1'b1; fwh_interface = 1'b0; //LPC bus operation begins
        nibble = 0; bus_op_status = get_cyctype_dir;
      end
      else $display("%t, Warning: The data in START field is not defined!\n",$realtime);
    end
  /*
    else if((bus_op_status == get_start)&&(FWH4_LFRM !== 1'b0))
    begin
      $display("%t, Warning: The bus operation is not initial because Input Communication Frame is not low!\n",$realtime);
    end
  */
  //------------------------------------------------IDSEL Field, Firmware Hub Interface Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == get_idsel))
    begin
      if(id_in == FWH_LAD)
      begin
        nibble = 0; bus_op_status = get_fwh_addr;
      end
      else begin
        nibble = 0; bus_op_status = get_start;
        $display("%t, Warning: The Firmware Hub Flash Memory is not selected! Bus operation must be re-started!\n",$realtime);
      end
    end
  //------------------------------------------------ADRR Field, Firmware Hub Interface Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == get_fwh_addr))
    begin
      fwh_address = {fwh_address[`FWH_ADDR_BITS-`IOC_NUM-1:0],FWH_LAD};
      nibble = nibble + 1;    //Most Significant Nibble First
      if(nibble >= 7)         //28 Bits address is transferred
      begin
        A22 = fwh_address[`REG_MEM_ENBIT];
        if(A22 == 1'b1)       //A20~A21,A23~A27 are treated as don't care during memory array access in FWH
        begin
          mem_address = fwh_address[`MEM_ADDR_BITS-1:0];
          nibble = 0; bus_op_status = get_fwh_msize;
        end
        if(A22 == 1'b0)       //A27~A23,A21~A20 must be "1",A19~A12 for lock register accsee
        begin
          reg_address = fwh_address[`REG_ADDR_BITS-1:0];
          nibble = 0; bus_op_status = get_fwh_msize;
          CR_mapping(reg_address);
        end
      end
    end
  //------------------------------------------------MSIZE Field, Firmware Hub Interface Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == get_fwh_msize))
    begin
      if(fwh_wr == 1'b1)                    //In FWH Bus Write Operation
      begin
        nibble = 0; bus_op_status = get_fwh_data_in;
        if(A22 == 1'b0) fwh_nByteWrite = 1; //access CR, always single byte transfer, no matter the inputs
        else                                //access memory, the number of byte tranfer according to the inputs
        case(FWH_LAD)
          4'b0000: fwh_nByteWrite = 1;      //1Byte, 2nibbles
          4'b0001: fwh_nByteWrite = 2;      //2Byte, 4nibbles
          4'b0010: fwh_nByteWrite = 4;      //4Byte, 8nibbles
          default: begin
            nibble = 0; bus_op_status = get_start;
            $display("%t, Warning: This value[%h] of MSIZE for write is not defined! Bus operation must be re-started!\n",$realtime,FWH_LAD);
          end
        endcase
      end
      if(fwh_rd == 1'b1)                    //In FWH Bus Read Operation
      begin
        nibble =0; bus_op_status = get_fwh_tar_in;
        if(A22 == 1'b0 || read_status !== read_memory)
          fwh_nByteRead = 1;                //access cr, always single byte transfer, no matter the inputs
        else                                //access memory, the number of byte tranfer according to the inputs
        case(FWH_LAD)
          4'b0000: fwh_nByteRead = 1;       //1Byte,2nibbles
          4'b0001: fwh_nByteRead = 2;       //2Byte,4nibbles
          4'b0010: fwh_nByteRead = 4;       //4Byte,8nibbles
          4'b0100: fwh_nByteRead = 16;      //16Byte,32nibbles
          4'b0111: fwh_nByteRead = 128;     //128Byte,256nibbles
          default: begin
            nibble = 0; bus_op_status = get_start;
            $display("%t, Warning: This value[%h] of MSIZE for read is not defined! Bus operation must be re-started!\n",$realtime,FWH_LAD);
          end
        endcase
      end
    end
    //----------------------------------------------DATA IN Field, Firmware Hub Write Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == get_fwh_data_in))
    begin
      if(fwh_nByteWrite == 1)   //Single Byte Transfer, LSN first
      begin
        case(nibble)
          0: fwh_data_in[0] = {4'b1111,FWH_LAD};
          1: fwh_data_in[0] = fwh_data_in[0] & {FWH_LAD,4'b1111};
        endcase
        nibble = nibble + 1;
        if(nibble >= 2)
        begin
          nibble = 0; bus_op_status = get_fwh_tar_in;
        end
      end
      if(fwh_nByteWrite == 2)   //Double Byte Transfer, LSN first
      begin
        case(nibble)
          0: fwh_data_in[0] = {4'b1111,FWH_LAD};
          1: fwh_data_in[0] = fwh_data_in[0] & {FWH_LAD,4'b1111};
          2: fwh_data_in[1] = {4'b1111,FWH_LAD};
          3: fwh_data_in[1] = fwh_data_in[1] & {FWH_LAD,4'b1111};
        endcase
        nibble = nibble + 1;
        if(nibble >= 4)
        begin
          nibble = 0; bus_op_status = get_fwh_tar_in;
        end
      end
      if(fwh_nByteWrite == 4)   //Quadruple Byte Transfer, LSN first
      begin
        case(nibble)
          0: fwh_data_in[0] = {4'b1111,FWH_LAD};
          1: fwh_data_in[0] = fwh_data_in[0] & {FWH_LAD,4'b1111};
          2: fwh_data_in[1] = {4'b1111,FWH_LAD};
          3: fwh_data_in[1] = fwh_data_in[1] & {FWH_LAD,4'b1111};
          4: fwh_data_in[2] = {4'b1111,FWH_LAD};
          5: fwh_data_in[2] = fwh_data_in[2] & {FWH_LAD,4'b1111};
          6: fwh_data_in[3] = {4'b1111,FWH_LAD};
          7: fwh_data_in[3] = fwh_data_in[3] & {FWH_LAD,4'b1111};
        endcase
        nibble = nibble + 1;
        if(nibble >= 8)
        begin
          nibble = 0; bus_op_status = get_fwh_tar_in;
        end
      end
    end
    //----------------------------------------------TAR IN Field, Firmware Hub Interface Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == get_fwh_tar_in))
    begin
      if(FWH_LAD == 4'b1111)
      begin
        nibble = 0; bus_op_status = fwh_tar_out_1;
        #(`tCHQZ_MAX); fwh_lpc_dout = 4'hz;
        if(fwh_wr == 1'b1) begin nibble = 0; bus_op_status = fwh_sync; end
        else if(fwh_rd == 1'b1) begin nibble = 0; bus_op_status = fwh_wsync; end
      end
      else begin
        nibble = 0; bus_op_status = get_start;
        $display("%t, Warning: The host must drive FWH_LAD[0~3] to 1111! Bus operation must be re-started!\n",$realtime);
      end
    end
    //----------------------------------------------TAR OUT Field, Firmware Hub Interface Bus Operation
    /*
    else if((fwh_interface == 1'b1)&&(bus_op_status == fwh_tar_out_1))
    begin
      #(`tCHQZ_MAX); fwh_lpc_dout = 4'hz;
      if(fwh_wr == 1'b1) begin nibble = 0; bus_op_status = fwh_sync; end
      else if(fwh_rd == 1'b1) begin nibble = 0; bus_op_status = fwh_wsync; end
    end
    */
    //----------------------------------------------WSYNC Field, Firmware Hub Read Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == fwh_wsync))
    begin
      #(`tCHQX_MIN); fwh_lpc_dout = 4'h5;
      nibble = nibble + 1;
      if(nibble >= 2)
      begin
        nibble = 0; bus_op_status = fwh_sync; //fwh_sync is equal fwh_rsync
      end
    end
    //----------------------------------------------RSYNC(SYNC) Field, Firmware Hub Interface Bus Operation(TBD)
    else if((fwh_interface == 1'b1)&&(bus_op_status == fwh_sync))
    begin
      #(`tCHQV_MAX); fwh_lpc_dout = 4'h0;
      if(fwh_wr == 1'b1)
      begin  //Drives FWH_LAD0~3=0000b,indicating data(cmd) has been received in this cycle (Write Bus OP)
        if(A22 == 1'b0) RegWriteOp;
        if(A22 == 1'b1) MemWriteOp;
        nibble = 0;
        bus_op_status = fwh_tar_out_2;
      end
      if(fwh_rd == 1'b1)
      begin  //Drives FWH_LAD0~3 to 0000b,indicating data will be available in next cycle (Read Bus OP)
        if(A22 == 1'b1) begin
          case(fwh_nByteRead)
            1:    mem_address = mem_address & `MEM_ADDR_BITS'hfffff;
            2:    mem_address = mem_address & `MEM_ADDR_BITS'hffffe;
            4:    mem_address = mem_address & `MEM_ADDR_BITS'hffffc;
            16:   mem_address = mem_address & `MEM_ADDR_BITS'hffff0;
            128:  mem_address = mem_address & `MEM_ADDR_BITS'hfff10;
          endcase //memory address aligned according to the MSIZE granularity
        end
        nibble = 0; bus_op_status = fwh_data_out;
      end
    end
    //----------------------------------------------DATA OUT Field, Firmware Hub Read Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == fwh_data_out))
    begin
      case(nibble)
      0: begin
           if(A22 == 1'b1) MemReadOp;
           if(A22 == 1'b0) RegReadOp;
           #(`tCHQV_MAX); fwh_lpc_dout = data_out_buf[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
         end
      1: begin
           #(`tCHQV_MAX); fwh_lpc_dout = data_out_buf[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
           fwh_nByteRead = fwh_nByteRead - 1;
           if(fwh_nByteRead > 0 && A22 == 1'b1) mem_address = mem_address + 1;
         end
      endcase
      nibble= nibble + 1;
      if(nibble >=2)
      begin
        nibble = 0;
        if(fwh_nByteRead == 0)
        begin
          bus_op_status = fwh_tar_out_2;
        end
      end
    end
    //----------------------------------------------TAR OUT Field, Firmware Hub Interface Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == fwh_tar_out_2))
    begin
      #(`tCHQV_MAX); fwh_lpc_dout = 4'hf;
      nibble = 0; bus_op_status = fwh_tar_float;
    end
    //----------------------------------------------TAR float Field, Firmware Hub Interface Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == fwh_tar_float))
    begin
      #(`tCHQZ_MAX); fwh_lpc_dout = 4'hz;
      nibble = 0; bus_op_status = get_start;
    end
  //####################################################### Firmware Hub Interface Bus Operation over

  //------------------------------------------------------- CYCTYPE+DIR Field, Low Pin Count Interface Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == get_cyctype_dir))
    begin
      if((FWH_LAD & 4'b1110) == 4'b0100)  //LPC Read
      begin
        lpc_rd = 1'b1; lpc_wr = 1'b0;
        nibble = 0; bus_op_status = get_lpc_addr;
      end
      else
      if((FWH_LAD & 4'b1110) == 4'b0110)  //LPC Write
      begin
        lpc_wr = 1'b1; lpc_rd = 1'b0;
        nibble = 0; bus_op_status = get_lpc_addr;
      end
      else begin                          //Bit3:2 is not equal "01"
        nibble = 0; bus_op_status = get_start;
        $display("%t, Warning: The Bit3:2 must be 01b in the CYCTYPE_DIR field, Bus operation must be re-started!\n",$realtime);
      end
    end
  //------------------------------------------------------- ADDR Field, Low Pin Count Interface Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == get_lpc_addr))
    begin
      lpc_address = {lpc_address[`LPC_ADDR_BITS-`IOC_NUM-1:0],FWH_LAD}; //MSN first
      nibble = nibble + 1;
      if(nibble >= 8)
      begin           //A23~A31 must be set to "1"
        if(lpc_address[`LPC_ADDR_BITS-1:`REG_MEM_ENBIT+1] !== {(`LPC_ADDR_BITS-`REG_MEM_ENBIT-1){1'b1}})
        begin
          $display("%t, Warning: LPC Interface, A23~A31 must be set to 1! Bus operation must be re-started!\n",$realtime);
          nibble = 0; bus_op_status = get_start;
        end
        else begin    //ID line and A21,A20 must be set according to the rules(for LPC interface)
          if(lpc_address[21:20] !== ~id_in[3:2])
          begin
            $display("%t, Warning: LPC Interface, ID line and A20~A21 is not according to the rules. Bus operation must be re-started!\n",$realtime);
            nibble = 0; bus_op_status = get_start;
          end
          else begin
            A22 = lpc_address[`REG_MEM_ENBIT];
            if(A22 == 1'b1)
            begin
              mem_address = lpc_address[`MEM_ADDR_BITS-1:0];
              if(lpc_rd == 1'b1) begin nibble = 0; bus_op_status = get_lpc_tar_in; end
              if(lpc_wr == 1'b1) begin nibble = 0; bus_op_status = get_lpc_data_in; end
            end
            if(A22 == 1'b0)
            begin
              reg_address = lpc_address[`REG_ADDR_BITS-1:0];
              if(lpc_rd == 1'b1) begin nibble = 0; bus_op_status = get_lpc_tar_in; end
              if(lpc_wr == 1'b1) begin nibble = 0; bus_op_status = get_lpc_data_in; end
              CR_mapping(reg_address);
            end
    end end end end
  //------------------------------------------------------- DATA IN Field, Low Pin Count write Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == get_lpc_data_in))
    begin
      case(nibble)  //Only 1 Byte Data Transfer, LSN first
      0: lpc_data_in[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8] = FWH_LAD;
      1: lpc_data_in[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4] = FWH_LAD;
      endcase
      nibble = nibble + 1;
      if(nibble >= 2)
      begin
        nibble = 0; bus_op_status = get_lpc_tar_in;
      end
    end
  //------------------------------------------------------- TAR IN Field, Low Pin Count Interface Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == get_lpc_tar_in))
    begin
      if(FWH_LAD == 4'b1111)
      begin
        nibble = 0; bus_op_status = lpc_tar_out_1;
        #(`tCHQZ_MAX); fwh_lpc_dout = 4'hz;
        if(lpc_rd == 1'b1)  begin nibble = 0; bus_op_status = lpc_wsync; end
        if(lpc_wr == 1'b1)  begin nibble = 0; bus_op_status = lpc_sync; end
      end
      else begin
        nibble = 0; bus_op_status = get_start;
        $display("%t, Warning: The host must drive FWH_LAD[0~3] to 1111! Bus operation must be re-started!\n",$realtime);
      end
    end    
  //------------------------------------------------------- TAR OUT Field, Low Pin Count Interface Bus Operation
  /*
    else if((lpc_interface == 1'b1)&&(bus_op_status == lpc_tar_out_1))
    begin
      #(`tCHQZ_MAX); fwh_lpc_dout = 4'hz;
      if(lpc_rd == 1'b1)  begin nibble = 0; bus_op_status = lpc_wsync; end
      if(lpc_wr == 1'b1)  begin nibble = 0; bus_op_status = lpc_sync; end
    end
  */
  //-------------------------------------------------------  WSYNC Field, Low Pin Count Read Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == lpc_wsync))
    begin
      #(`tCHQX_MIN); fwh_lpc_dout = 4'b0101;
      nibble = nibble + 1;
      if(nibble >= 2)
      begin
        nibble = 0; bus_op_status = lpc_sync; //lpc_sync is equal lpc_rsync
      end
    end
  //------------------------------------------------------- RSYNC(SYNC) Field, Low Pin Count Interface Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == lpc_sync))
    begin
      #(`tCHQX_MIN); fwh_lpc_dout = 4'b0000;
      if(lpc_wr == 1'b1)
      begin  //Drives FWH_LAD0~3 to 0000b,indicating dat/cmd has been received in this cycle (Write Bus OP)
        if(lpc_address[22] == 1'b0) RegWriteOp;
        if(lpc_address[22] == 1'b1) MemWriteOp;
        nibble = 0; bus_op_status = lpc_tar_out_2;
      end
      if(lpc_rd == 1'b1)
      begin  //Drives FWH_LAD0~3 to 0000b,indicating data will be available in next cycle (Read Bus OP)
        nibble = 0; bus_op_status = lpc_data_out;
      end
    end
  //-------------------------------------------------------  DATA OUT Field, Low Pin Count Read Bus Operation(TBD)
    else if((lpc_interface == 1'b1)&&(bus_op_status == lpc_data_out))
    begin
      case(nibble)
      0: begin
          if(A22 == 1'b1) MemReadOp;
          if(A22 == 1'b0) RegReadOp;
          #(`tCHQV_MAX); fwh_lpc_dout = data_out_buf[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
         end
      1: begin
          #(`tCHQV_MAX); fwh_lpc_dout = data_out_buf[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
         end
      endcase
      nibble= nibble + 1;
      if(nibble >=2)
      begin
        nibble = 0; bus_op_status = lpc_tar_out_2;
      end
    end
  //------------------------------------------------------- TAR OUT Field, Low Pin Count Interface Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == lpc_tar_out_2))
    begin
      #(`tCHQV_MAX); fwh_lpc_dout = 4'b1111;
      nibble = 0; bus_op_status = lpc_tar_float;
    end
  //------------------------------------------------------- TAR FLOAT Field, Low Pin Count Interface Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == lpc_tar_float))
    begin
      #(`tCHQZ_MAX); fwh_lpc_dout = 4'hz;
      nibble = 0; bus_op_status = get_start;
    end
  //####################################################### Low Pin Count Interface Bus Operation over
  end

  //=======================================================
  //A/A Mux Interface operation TBD
  //=======================================================
  if((A_A_MUX == 1'b1)&&((power_on == 1'b1) && ($time - power_on_time > 0))&&(running_status !== ResetCycle_Busy))
  begin
    //TBD: A/A MUX interface operation
  end
  //####################################################### A/A Mux Interface Bus Operation over
  if(power_on == 1'b0) $display("%t, Warning: Memory has not been Power-on before clock cycle starts!\n",$realtime);
  //if(running_status == ResetCycle_Busy)
  //$display("%t, Warning: This clock cylce is of no effect during RESET mode!\n",$realtime);
end
//=======================================================================================

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//task definition
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
task CR_mapping;
input[`REG_ADDR_BITS-1:0] reg_addr;
begin
case(reg_addr)                             //CR[48,63] for (block 0,15) lock
  `REG_ADDR_BITS'hFBC0100: cr_addr = 64;   //GPI Register, (Read only)
  `REG_ADDR_BITS'hFBC0000: cr_addr = 65;   //MFC Register, (Read only)
  `REG_ADDR_BITS'hFBFF002: cr_addr = 47;   //Lock Register (block 15) Sector 47
  `REG_ADDR_BITS'hFBFE002: cr_addr = 46;   //Lock Register (block 15) Sector 46
  `REG_ADDR_BITS'hFBFD002: cr_addr = 45;   //Lock Register (block 15) Sector 45
  `REG_ADDR_BITS'hFBFC002: cr_addr = 44;   //Lock Register (block 15) Sector 44
  `REG_ADDR_BITS'hFBFB002: cr_addr = 43;   //Lock Register (block 15) Sector 43
  `REG_ADDR_BITS'hFBFA002: cr_addr = 42;   //Lock Register (block 15) Sector 42
  `REG_ADDR_BITS'hFBF9002: cr_addr = 41;   //Lock Register (block 15) Sector 41
  `REG_ADDR_BITS'hFBF8002: cr_addr = 40;   //Lock Register (block 15) Sector 40
  `REG_ADDR_BITS'hFBF7002: cr_addr = 39;   //Lock Register (block 15) Sector 39
  `REG_ADDR_BITS'hFBF6002: cr_addr = 38;   //Lock Register (block 15) Sector 38
  `REG_ADDR_BITS'hFBF5002: cr_addr = 37;   //Lock Register (block 15) Sector 37
  `REG_ADDR_BITS'hFBF4002: cr_addr = 36;   //Lock Register (block 15) Sector 36
  `REG_ADDR_BITS'hFBF3002: cr_addr = 35;   //Lock Register (block 15) Sector 35
  `REG_ADDR_BITS'hFBF2002: cr_addr = 34;   //Lock Register (block 15) Sector 34
  `REG_ADDR_BITS'hFBF1002: cr_addr = 33;   //Lock Register (block 15) Sector 33
  `REG_ADDR_BITS'hFBF0002: cr_addr = 32;   //Lock Register (block 15) Sector 32
  `REG_ADDR_BITS'hFB0F002: cr_addr = 15;   //Lock Register (block 0) Sector 15
  `REG_ADDR_BITS'hFB0E002: cr_addr = 14;   //Lock Register (block 0) Sector 14
  `REG_ADDR_BITS'hFB0D002: cr_addr = 13;   //Lock Register (block 0) Sector 13
  `REG_ADDR_BITS'hFB0C002: cr_addr = 12;   //Lock Register (block 0) Sector 12
  `REG_ADDR_BITS'hFB0B002: cr_addr = 11;   //Lock Register (block 0) Sector 11
  `REG_ADDR_BITS'hFB0A002: cr_addr = 10;   //Lock Register (block 0) Sector 10
  `REG_ADDR_BITS'hFB09002: cr_addr = 9;    //Lock Register (block 0) Sector 9
  `REG_ADDR_BITS'hFB08002: cr_addr = 8;    //Lock Register (block 0) Sector 8
  `REG_ADDR_BITS'hFB07002: cr_addr = 7;    //Lock Register (block 0) Sector 7
  `REG_ADDR_BITS'hFB06002: cr_addr = 6;    //Lock Register (block 0) Sector 6
  `REG_ADDR_BITS'hFB05002: cr_addr = 5;    //Lock Register (block 0) Sector 5
  `REG_ADDR_BITS'hFB04002: cr_addr = 4;    //Lock Register (block 0) Sector 4
  `REG_ADDR_BITS'hFB03002: cr_addr = 3;    //Lock Register (block 0) Sector 3
  `REG_ADDR_BITS'hFB02002: cr_addr = 2;    //Lock Register (block 0) Sector 2
  `REG_ADDR_BITS'hFB01002: cr_addr = 1;    //Lock Register (block 0) Sector 1
  `REG_ADDR_BITS'hFB00002: cr_addr = 0;    //Lock Register (block 0) Sector 0
  `REG_ADDR_BITS'hFBD0002: cr_addr = 61;   //Lock Register (Block 13)
  `REG_ADDR_BITS'hFBC0002: cr_addr = 60;   //Lock Register (Block 12)
  `REG_ADDR_BITS'hFBB0002: cr_addr = 59;   //Lock Register (Block 11)
  `REG_ADDR_BITS'hFBA0002: cr_addr = 58;   //Lock Register (Block 10)
  `REG_ADDR_BITS'hFB90002: cr_addr = 57;   //Lock Register (Block 9)
  `REG_ADDR_BITS'hFB80002: cr_addr = 56;   //Lock Register (Block 8)
  `REG_ADDR_BITS'hFB70002: cr_addr = 55;   //Lock Register (Block 7)
  `REG_ADDR_BITS'hFB60002: cr_addr = 54;   //Lock Register (Block 6)
  `REG_ADDR_BITS'hFB50002: cr_addr = 53;   //Lock Register (Block 5)
  `REG_ADDR_BITS'hFB40002: cr_addr = 52;   //Lock Register (Block 4)
  `REG_ADDR_BITS'hFB30002: cr_addr = 51;   //Lock Register (Block 3)
  `REG_ADDR_BITS'hFB20002: cr_addr = 50;   //Lock Register (Block 2)
`ifdef M50FLW080A
  `REG_ADDR_BITS'hFB10002: cr_addr = 49;   //Lock Register (Block 1)
  `REG_ADDR_BITS'hFBEF002: cr_addr = 31;   //Lock Register (block 14) Sector 31
  `REG_ADDR_BITS'hFBEE002: cr_addr = 30;   //Lock Register (block 14) Sector 30
  `REG_ADDR_BITS'hFBED002: cr_addr = 29;   //Lock Register (block 14) Sector 29
  `REG_ADDR_BITS'hFBEC002: cr_addr = 28;   //Lock Register (block 14) Sector 28
  `REG_ADDR_BITS'hFBEB002: cr_addr = 27;   //Lock Register (block 14) Sector 27
  `REG_ADDR_BITS'hFBEA002: cr_addr = 26;   //Lock Register (block 14) Sector 26
  `REG_ADDR_BITS'hFBE9002: cr_addr = 25;   //Lock Register (block 14) Sector 25
  `REG_ADDR_BITS'hFBE8002: cr_addr = 24;   //Lock Register (block 14) Sector 24
  `REG_ADDR_BITS'hFBE7002: cr_addr = 23;   //Lock Register (block 14) Sector 23
  `REG_ADDR_BITS'hFBE6002: cr_addr = 22;   //Lock Register (block 14) Sector 22
  `REG_ADDR_BITS'hFBE5002: cr_addr = 21;   //Lock Register (block 14) Sector 21
  `REG_ADDR_BITS'hFBE4002: cr_addr = 20;   //Lock Register (block 14) Sector 20
  `REG_ADDR_BITS'hFBE3002: cr_addr = 19;   //Lock Register (block 14) Sector 19
  `REG_ADDR_BITS'hFBE2002: cr_addr = 18;   //Lock Register (block 14) Sector 18
  `REG_ADDR_BITS'hFBE1002: cr_addr = 17;   //Lock Register (block 14) Sector 17
  `REG_ADDR_BITS'hFBE0002: cr_addr = 16;   //Lock Register (block 14) Sector 16
`endif
`ifdef M50FLW080B
  `REG_ADDR_BITS'hFBE0002: cr_addr = 62;   //Lock Register (Block 14)
  `REG_ADDR_BITS'hFB1F002: cr_addr = 31;   //Lock Register (block 1) Sector 31
  `REG_ADDR_BITS'hFB1E002: cr_addr = 30;   //Lock Register (block 1) Sector 30
  `REG_ADDR_BITS'hFB1D002: cr_addr = 29;   //Lock Register (block 1) Sector 29
  `REG_ADDR_BITS'hFB1C002: cr_addr = 28;   //Lock Register (block 1) Sector 28
  `REG_ADDR_BITS'hFB1B002: cr_addr = 27;   //Lock Register (block 1) Sector 27
  `REG_ADDR_BITS'hFB1A002: cr_addr = 26;   //Lock Register (block 1) Sector 26
  `REG_ADDR_BITS'hFB19002: cr_addr = 25;   //Lock Register (block 1) Sector 25
  `REG_ADDR_BITS'hFB18002: cr_addr = 24;   //Lock Register (block 1) Sector 24
  `REG_ADDR_BITS'hFB17002: cr_addr = 23;   //Lock Register (block 1) Sector 23
  `REG_ADDR_BITS'hFB16002: cr_addr = 22;   //Lock Register (block 1) Sector 22
  `REG_ADDR_BITS'hFB15002: cr_addr = 21;   //Lock Register (block 1) Sector 21
  `REG_ADDR_BITS'hFB14002: cr_addr = 20;   //Lock Register (block 1) Sector 20
  `REG_ADDR_BITS'hFB13002: cr_addr = 19;   //Lock Register (block 1) Sector 19
  `REG_ADDR_BITS'hFB12002: cr_addr = 18;   //Lock Register (block 1) Sector 18
  `REG_ADDR_BITS'hFB11002: cr_addr = 17;   //Lock Register (block 1) Sector 17
  `REG_ADDR_BITS'hFB10002: cr_addr = 16;   //Lock Register (block 1) Sector 16
`endif
  default:begin
    nibble = 0; bus_op_status = get_start;
    $display("%t, Warning: The address[%h] for CR access is not correct! Bus operation must be re-started!\n",$realtime,reg_addr[`REG_ADDR_BITS-1:0]);
  end
endcase
end
endtask

//=============================================================================
task CR_Initialization;
integer i;
begin
  for(i=0;i<=63;i=i+1)
  begin
    if((i==48)||(i==63)) CR[i] = 8'h00;
    else CR[i] = 8'h01;
  end
  CR[65] = 8'h20; //Manufacturer Code Register
end
endtask

//=============================================================================
task find_blk;
input[`MEM_ADDR_BITS:0] addr;
integer i;
begin  
  for(i=0;i<`BLOCK_NUM;i=i+1)
    if(addr >= start_addr_block[i] && addr <= end_addr_block[i]) n_block = i; 
    //$display("%t,block = %d",$realtime,n_block);
  end
endtask

//=============================================================================
task find_sct;
input[`MEM_ADDR_BITS:0] addr;
integer i;
begin
  for(i=0;i<`SECTOR_NUM;i=i+1)
    if(addr >= start_addr_sector[i] && addr <= end_addr_sector[i]) n_sector = i;
    //$display("%t,sector = %d",$realtime,n_sector);
  end
endtask

//=============================================================================
task Protect_Check;
output protect_flag;
begin
  `ifdef M50FLW080A
   begin
     protect_flag = 1'b0;
     if((n_block == `TOPBLOCK)||(n_block == `TOPBLOCK-1)||(n_block == 0))
     begin
       case(write_status)
       program:
       begin
         if((FWH_LPC == 1'b1) && ((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
           (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_sector] & `WRITE_LOCK) == `WRITE_LOCK)))
         begin
           protect_flag = 1'b1;
           $display("%t, Warning: Program is failed because the sector[%d] is write protected!\n",$realtime,n_sector);
           write_status = write_command;
           read_status = read_status_reg;
           status_reg = status_reg | 8'h92;  //SR indicates "Program failure due to Block Protection"
         end
       end
       block_erase:
       begin
         CR[n_block+`SECTOR_NUM] = 8'h00;
         if(n_block == `TOPBLOCK)
         begin                               //CR63 block 15 lock
           for(i=`SECTOR_NUM-1;i>=`SECTOR_NUM-16;i=i-1) CR[`TOPBLOCK+`SECTOR_NUM] = CR[`TOPBLOCK+`SECTOR_NUM] | CR[i];
         end
         if(n_block == `TOPBLOCK-1)
         begin
           for(i=`SECTOR_NUM-17;i>=`SECTOR_NUM-32;i=i-1) CR[`TOPBLOCK-1+`SECTOR_NUM] = CR[`TOPBLOCK-1+`SECTOR_NUM] | CR[i];
         end
         if(n_block == 0)
         begin                               //CR48 block 0 lock
           for(i=`SECTOR_NUM-33;i>=`SECTOR_NUM-48;i=i-1) CR[`SECTOR_NUM] = CR[`SECTOR_NUM] | CR[i];
         end
         if((FWH_LPC == 1'b1) && ((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
           (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_block+`SECTOR_NUM] & `WRITE_LOCK) == `WRITE_LOCK)))
         begin
           protect_flag = 1'b1;
           $display("%t, Warning: Block[%d] Erase is failed because this block is write protected!\n",$realtime,n_block);
           write_status = write_command;
           read_status =  read_status_reg;
           status_reg = status_reg | 8'hA2;  //SR indicates "Erase failure due to Block Protection"
         end
       end
       endcase
     end
     else begin
       case(write_status)
       program:
       begin
         if((FWH_LPC == 1'b1) && ((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
           (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_block+`SECTOR_NUM] & `WRITE_LOCK) == `WRITE_LOCK)))
         begin
           protect_flag = 1'b1;
           $display("%t, Warning: Program is failed because the block[%d] is write protected!\n",$realtime,n_block);
           write_status = write_command;
           read_status = read_status_reg;
           status_reg = status_reg | 8'h92;  //SR indicates "Program failure due to Block Protection"
         end
       end
       block_erase:
       begin
         if((FWH_LPC == 1'b1) && ((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
         (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_block+`SECTOR_NUM] & `WRITE_LOCK) == `WRITE_LOCK)))
         begin
           protect_flag = 1'b1;
           $display("%t, Warning: Block[%d] Erase is failed because this block is write protected!\n",$realtime,n_block);
           write_status = write_command;
           read_status =  read_status_reg;
           status_reg = status_reg | 8'hA2;  //SR indicates "Erase failure due to Block Protection"
         end
       end
       endcase
     end
   end
  `endif
//-----------------------------------------------------------------------------
  `ifdef M50FLW080B
   begin
     protect_flag = 1'b0;
     if((n_block == `TOPBLOCK)||(n_block == 1)||(n_block == 0))
     begin
       case(write_status)
       program:
       begin
         if((FWH_LPC == 1'b1) && ((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
           (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_sector] & `WRITE_LOCK) == `WRITE_LOCK)))
         begin
           protect_flag = 1'b1;
           $display("%t, Warning: Program is failed because the sector[%d] is write protected!\n",$realtime,n_sector);
           write_status = write_command;
           read_status = read_status_reg;
           status_reg = status_reg | 8'h92;  //SR indicates "Program failure due to Block Protection"
         end
       end
       block_erase:
       begin
         CR[n_block+`SECTOR_NUM] = 8'h00;
         if(n_block == `TOPBLOCK)
         begin
           for(i=`SECTOR_NUM-1;i>=`SECTOR_NUM-16;i=i-1) CR[`TOPBLOCK+`SECTOR_NUM] = CR[`TOPBLOCK+`SECTOR_NUM] | CR[i];
         end
         if(n_block == 1)
         begin
           for(i=`SECTOR_NUM-17;i>=`SECTOR_NUM-32;i=i-1) CR[1+`SECTOR_NUM] = CR[1+`SECTOR_NUM] | CR[i];
         end
         if(n_block == 0)
         begin
           for(i=`SECTOR_NUM-33;i>=`SECTOR_NUM-48;i=i-1) CR[`SECTOR_NUM] = CR[`SECTOR_NUM] | CR[i];
         end
         if((FWH_LPC == 1'b1) && ((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
           (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_block+`SECTOR_NUM] & `WRITE_LOCK) == `WRITE_LOCK)))
         begin
           protect_flag = 1'b1;
           $display("%t, Warning: Block[%d] Erase is failed because this block is write protected!\n",$realtime,n_block);
           write_status = write_command;
           read_status =  read_status_reg;
           status_reg = status_reg | 8'hA2;  //SR indicates "Erase failure due to Block Protection"
         end
       end
       endcase
     end
     else begin
       case(write_status)
       program:
       begin
         if((FWH_LPC == 1'b1) && ((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
           (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_block+`SECTOR_NUM] & `WRITE_LOCK) == `WRITE_LOCK)))
         begin
           protect_flag = 1'b1;
           $display("%t, Warning: Program is failed because the block[%d] is write protected!\n",$realtime,n_block);
           write_status = write_command;
           read_status = read_status_reg;
           status_reg = status_reg | 8'h92;  //SR indicates "Program failure due to Block Protection"
         end
       end
       block_erase:
       begin
         if((FWH_LPC == 1'b1) && ((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
         (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_block+`SECTOR_NUM] & `WRITE_LOCK) == `WRITE_LOCK)))
         begin
           protect_flag = 1'b1;
           $display("%t, Warning: Block[%d] Erase is failed because this block is write protected!\n",$realtime,n_block);
           write_status = write_command;
           read_status =  read_status_reg;
           status_reg = status_reg | 8'hA2;  //SR indicates "Erase failure due to Block Protection"
         end
       end
       endcase
     end
   end
  `endif
end
endtask

//=============================================================================
task RegReadOp;
begin
  data_out_buf = CR[cr_addr];
end
endtask

//=============================================================================
task RegWriteOp;
reg[`DATA_BITS_NUM-1:0] data_in;
begin
  if(lpc_interface == 1'b1) data_in = lpc_data_in;
  if(fwh_interface == 1'b1) data_in = fwh_data_in[0];
  if(cr_addr == 64)
    $display("%t, Warning: General Purpose Input Register is read only, writing to it has no effect!\n",$realtime);
  else
  if(cr_addr == 65)
    $display("%t, Warning: Manufacture Code Register is read only, writing to it has no effect!\n",$realtime);
  else
  if((cr_addr >= 0) && (cr_addr <= 47))
  begin
    if((CR[cr_addr] & `DATA_BITS_NUM'h02) == `DATA_BITS_NUM'h00)
    begin
      $display("%t, Note: Sector [%d] Lock Register Write Begin!\n",$realtime,cr_addr);
      CR[cr_addr] = data_in & 8'b00000111;
      $display("%t, Note: Sector [%d] Lock Register Write Complete!\n",$realtime,cr_addr);
    end
    else
      $display("%t, Warning: Sector [%d] Lock Register is locked down and can not be changed!\n",$realtime,cr_addr);
  end
  else
  if((cr_addr >= 48) && (cr_addr <= 63))
  begin
    if((CR[cr_addr] & `DATA_BITS_NUM'h02) == `DATA_BITS_NUM'h00)
    begin
      $display("%t, Note: Block [%d] Lock Register Write Begin!\n",$realtime,cr_addr-7'h30);
      CR[cr_addr] = data_in & 8'b00000111;
      $display("%t, Note: Block [%d] Lock Register Write Complete!\n",$realtime,cr_addr-7'h30);
    end
    else
      $display("%t, Warning: Block [%d] Lock Register is locked down and can not be changed!\n",$realtime,cr_addr-7'h30);
  end
end
endtask

//===================================================================
task MemReadOp;
begin
  //----------------------------------- Read Electronic Signature
  if(read_status == read_elec_sign)
  begin
    if(mem_address == `DEVICECODE_ADDR) data_out_buf = DEVICE_CODE;
    else
    if(mem_address == `MANUFCCODE_ADDR) data_out_buf = MANUFC_CODE;
    else
    begin                        
      $display("%t, Warning: Invalid Address! It's impossible to read Manufacturer Code or Device Code!\n",$realtime);
      data_out_buf = {`DATA_BITS_NUM{1'bx}};
    end
  end
  //----------------------------------- Read Memory Array
  if(read_status == read_memory)
  begin
    find_blk(mem_address);
    find_sct(mem_address);
    if(FWH_LPC == 1'b1) ReadMemArray;
  end
  //----------------------------------- Read Status Register
  if(read_status == read_status_reg)    data_out_buf = status_reg;
  //-----------------------------------------------------------------
end
endtask

//=============================================================================
task ReadMemArray;
begin
  `ifdef M50FLW080A
  if((n_block == `TOPBLOCK) || (n_block == `TOPBLOCK-1) || (n_block == 0))
  begin
    if((CR[n_sector] & `READ_LOCK) !== (`READ_LOCK)) data_out_buf = memory[mem_address];
    else begin
      $display("%t, Warning: Invalid Address! This sector[%d] is protected to read!\n",$realtime,n_sector);
      data_out_buf = {`DATA_BITS_NUM{1'b0}};
    end
  end
  else begin
    if((CR[n_block+`SECTOR_NUM] & `READ_LOCK) !== (`READ_LOCK)) data_out_buf = memory[mem_address];
    else begin
      $display("%t, Warning: Invalid Address! This block[%d] is protected to read!\n",$realtime,n_block);
      data_out_buf = {`DATA_BITS_NUM{1'b0}};
    end
  end
  `endif
  //------------------------------------------------------------
  `ifdef M50FLW080B
  if((n_block == `TOPBLOCK) || (n_block == 1) || (n_block == 0))
  begin
    if((CR[n_sector] & `READ_LOCK) !== (`READ_LOCK)) data_out_buf = memory[mem_address];
    else begin
      $display("%t, Warning: Invalid Address! This sector[%d] is protected to read!\n",$realtime,n_sector);
      data_out_buf = {`DATA_BITS_NUM{1'b0}};
    end
  end
  else begin
    if((CR[n_block+`SECTOR_NUM] & `READ_LOCK) !== (`READ_LOCK)) data_out_buf = memory[mem_address];
    else begin
      $display("%t, Warning: Invalid Address! This block[%d] is protected to read!\n",$realtime,n_block);
      data_out_buf = {`DATA_BITS_NUM{1'b0}};
    end
  end
  `endif
end
endtask

//=============================================================================
task MemWriteOp;
reg[`DATA_BITS_NUM-1:0] data_in;
begin
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  if(write_status == write_command)
  begin
    if(lpc_interface == 1'b1) data_in = lpc_data_in;
    if(fwh_interface == 1'b1) data_in = fwh_data_in[0];
    //-------------------------------------------
    case(data_in)
      //-----------------------------------------1.Read Memory Array Command
      8'hff: begin
        if(running_status == Free && status_reg[7] == 1'b1)
          read_status = read_memory;
        else $display("%t, Warning: Invalid Read Memory Array Command! Device Busy, or Program/Erase controller error!\n",$realtime);
      end
      //-----------------------------------------2.Read Status Register Command
      8'h70: begin
        //if(running_status !== ProgSusp_Busy && running_status !== EraseSusp_Busy)
          read_status = read_status_reg;
        //else $display("%t, Warning: Read Status Register Command can not be accepted until the Program/Erase controller has pauesd!\n",$realtime);
      end
      //-----------------------------------------3.Read Electronic Signature Command
      8'h90, 8'h98: begin
        if(running_status == Free) read_status = read_elec_sign;
        else $display("%t, Warning: Invalid Read Electronic Signature Command! Device Busy, or Program/Erase controller error!\n",$realtime);
      end
      //-----------------------------------------4.Program,FWH Mode Double/Quadruple Byte Program Setup Command
      8'h40, 8'h10: begin                        //pgm or ers controller is inactive, in erase suspend status or not
        if((running_status == Free) && (status_reg == 8'h80 || status_reg == 8'hC0))
          write_status = program;
        else begin
          $display("%t, Warning: Invalid Program Command! Device Busy, or Program/Erase controller error!\n",$realtime);
          //write_status = program; invalid_cmd = 1'b1;
        end
      end
      //-----------------------------------------5.Quadruple Byte Program Command(A/A Mux Interface) (TBD in future)
      8'h30: begin
        if((A_A_MUX == 1'b1) && (running_status == Free) && (status_reg == 8'h80 || status_reg == 8'hC0))
          write_status = quad_program;
        else $display("%t, Warning: Invalid Quadruple Byte Program Command! Device Busy, or Program/Erase controller error!\n",$realtime);
      end
      //-----------------------------------------6.Chip Erase Setup Command
      8'h80: begin                               //pgm or ers controller is inactive.
        if(A_A_MUX == 1'b1 && running_status == Free && status_reg == 8'h80)
          write_status = chip_erase;
        else $display("%t, Warning: This Chip Erase Command is only available under the A/A Mux interface!\n",$realtime);
      end
      //-----------------------------------------7.Block Erase Setup Command
      8'h20: begin
        if(running_status == Free && status_reg == 8'h80)
          write_status = block_erase;
        else begin
          $display("%t, Warning: Invalid Block Erase Command, Device Busy or Program/Erase controller error!\n",$realtime);
          //write_status = block_erase; invalid_cmd = 1'b1;
        end
      end
      //-----------------------------------------8.Sector Erase Setup Command
      8'h32: begin
        if(running_status == Free && status_reg == 8'h80)
          write_status = sector_erase;
        else begin
          $display("%t, Warning: Invalid Sector Erase Command, Device Busy or Program/Erase controller error!\n",$realtime);
          //write_status = sector_erase; invalid_cmd = 1'b1;
        end
      end
      //-----------------------------------------9.Clear Status Register Command
      8'h50: begin
        if(running_status == Free)
          status_reg = status_reg & 8'hC4;       //clear bit 1,3,4,5
        else $display("%t, Warning: Invalid Clear Status Register Command, Device Busy!\n",$realtime);
      end
      //-----------------------------------------10.Program/Erase Suspend Command
      8'hb0: begin
        //this command pauses PG/ES CTR during a program or a sector/block erase operation
        if(running_status == BlockErase_Busy || running_status == SectorErase_Busy || running_status == Program_Busy)
        begin
          if(running_status == Program_Busy)
          begin
            PGM_Susp_Time = $time;
            running_status = ProgSusp_Busy;
            complete_flag <= #(`ProgSusp_Time) ~complete_flag;
          end
          else begin
            previous_status = running_status;    //save which erase op. before suspend for resume
            ES_Susp_Time = $time;
            running_status = EraseSusp_Busy;
            complete_flag <= #(`EraseSusp_Time) ~complete_flag;
          end
        end
        else $display("%t, Warning: Invalid Program/Erase Suspend Command, No Erase or Program operations in progress!\n",$realtime);
      end
      //-----------------------------------------11.Program/Erase Resume Command
      8'hd0: begin
        if(running_status == Free && (status_reg == 8'h84 || status_reg == 8'hC4))
        begin
          $display("%t, Note: Program Resume, Program/Erase Controller is re-start!\n",$realtime);
          running_status = Program_Busy;
          status_reg = status_reg & 8'h40;       //SR=8'b0x00_0000
          read_status = read_status_reg;
          complete_flag <= #(`Program_Time-(PGM_Susp_Time-PGM_Start_Time)) ~complete_flag;
        end
        else if(running_status == Free && status_reg == 8'hC0)
        begin
          if(previous_status == BlockErase_Busy) 
          begin
            $display("%t, Note: Block Erase Resume, Program/Erase Controller is re-start!\n",$realtime);
            running_status = BlockErase_Busy;
            status_reg = status_reg & 8'h00;     //SR=8'b0000_0000
            read_status = read_status_reg;
            complete_flag <= #(BlockErase_Time-(ES_Susp_Time-BE_Start_Time)) ~complete_flag;
          end
          else begin
            $display("%t, Note: Sector Erase Resume, Program/Erase Controller is re-start!\n",$realtime);
            running_status = SectorErase_Busy;
            status_reg = status_reg & 8'h00;     //SR=8'b0000_0000
            read_status = read_status_reg;
            complete_flag <= #(SectorErase_Time-(ES_Susp_Time-SE_Start_Time)) ~complete_flag;
          end
        end
        /*
        else
        if(status_reg==8'h98 || status_reg==8'hD8 || status_reg==8'h92 || status_reg==8'hD2 || status_reg==8'h90 ||
           status_reg==8'hD0 || status_reg==8'hA8 || status_reg==8'hA2 || status_reg==8'hA0)
        */
        else $display("%t, Warning: Invalid Program/Erase Resume Command, No Erase or Program operations suspended!\n",$realtime);  
      end
      //---------------------------------
      default: $display("%t, Warning: This Input Command Code[%h] is not defined!\n",$realtime,data_in);
    endcase
  end

  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

  else if(write_status == program)
  begin
    //if(invalid_cmd == 1'b1) begin write_status = write_command; invalid_cmd = 1'b0; end
    //else begin
    find_blk(mem_address);
    find_sct(mem_address);
    if(((fwh_nByteWrite == 2)||(fwh_nByteWrite == 1)||(lpc_interface == 1'b1))&&(vpp_status == vpp_lockout))
    begin
      $display("%t, Warning: Program/Multiple Byte Program is failed because Vpp error(Vpp < Vcc)!\n",$realtime);
      write_status = write_command; read_status = read_status_reg;
      status_reg = status_reg | 8'h98;  //SR indicates "Program failure due to Vpp Error"
    end
    else
    if((fwh_nByteWrite == 4) && (vpp_status !== vpp_fast)) //add 2004-09-06
    begin
      $display("%t, Warning: Quadruple Byte Program is failed because Vpp error(Vpp is not at Vpph)!\n",$realtime);
      write_status = write_command; read_status = read_status_reg;
      status_reg = status_reg | 8'h98;  //SR indicates "Program failure due to Vpp Error"
    end
    else
    `ifdef M50FLW080A
    if(((n_block !== `TOPBLOCK)&&(n_block !== `TOPBLOCK-1)&&(n_block !== 0))&&((status_reg == 8'hC0)&&(erasing_block == n_block||running_status == ChipErase_Busy)))
    begin
      $display("%t, Warning: Program is failed. It's impossible to program cells in an erasing block!\n",$realtime);
      write_status = write_command; read_status = read_memory;
    end
    else
    if(((n_block == `TOPBLOCK)||(n_block == `TOPBLOCK-1)||(n_block == 0))&&((status_reg == 8'hC0)&&(erasing_sector == n_sector||running_status == ChipErase_Busy)))
    begin
      $display("%t, Warning: Program is failed. It's impossible to program cells in an erasing sector!\n",$realtime);
      write_status = write_command; read_status = read_memory;
    end
    `endif
    `ifdef M50FLW080B
    if(((n_block !== `TOPBLOCK)&&(n_block !== 1)&&(n_block !== 0))&&((status_reg == 8'hC0)&&(erasing_block == n_block||running_status == ChipErase_Busy)))
    begin
      $display("%t, Warning: Program is failed. It's impossible to program cells in an erasing block!\n",$realtime);
      write_status = write_command; read_status = read_memory;
    end
    else
    if(((n_block == `TOPBLOCK)||(n_block == 1)||(n_block == 0))&&((status_reg == 8'hC0)&&(erasing_sector == n_sector||running_status == ChipErase_Busy)))
    begin
      $display("%t, Warning: Program is failed. It's impossible to program cells in an erasing sector!\n",$realtime);
      write_status = write_command; read_status = read_memory;
    end
    `endif
    else begin
      Protect_Check(wr_protect);
      if(wr_protect == 1'b0)
      begin                               //A/A mux interface or write to an unprotected block in fwh/lpc mode
        write_status = write_command;
        read_status = read_status_reg;
        status_reg = status_reg & 8'h40;  //SR=8'b0x00_0000(00 or 40)
        `ifdef M50FLW080A
         if((n_block == `TOPBLOCK)||(n_block == `TOPBLOCK-1)||(n_block == 0))
          $display("%t, Notes: Sector [%d] Program Operation begin!\n",$realtime,n_sector);
         else
          $display("%t, Notes: Block[%d] Program Operation begin!\n",$realtime,n_block);
        `endif
        `ifdef M50FLW080B
         if((n_block == `TOPBLOCK)||(n_block == 1)||(n_block == 0))
          $display("%t, Notes: Sector [%d] Program Operation begin!\n",$realtime,n_sector);
         else
          $display("%t, Notes: Block[%d] Program Operation begin!\n",$realtime,n_block);
        `endif
        PGM_Start_Time = $time;
        running_status = Program_Busy;
        if(fwh_interface == 1'b1)         //FWH mode: single byte or double/quad bytes program according to msize field.
        begin
          if(fwh_nByteWrite == 2) mem_address = mem_address & `MEM_ADDR_BITS'h7fffe;
          if(fwh_nByteWrite == 4) mem_address = mem_address & `MEM_ADDR_BITS'h7fffc;
          for(i=0;i<fwh_nByteWrite;i=i+1)
          begin
            if((memory[mem_address]& fwh_data_in[i]) == fwh_data_in[i])
            begin
              memory[mem_address] = memory[mem_address] & fwh_data_in[i];
              if(fwh_nByteWrite > 1) mem_address = mem_address + 1;
            end
            else begin                    //SR indicates "Program failure due to cell failure.
              status_reg = status_reg | 8'h90;
              $display("%t, Warning: Block[%d] program is failed because the address[%h] cell failure!\n",$realtime,n_block,mem_address);
            end
          end
        end
        else if(lpc_interface == 1'b1)    //LPC mode: single byte program only
        begin
          if((memory[mem_address]& lpc_data_in) == lpc_data_in)
            memory[mem_address] = memory[mem_address] & lpc_data_in;
          else begin                      //SR indicates "Program failure due to cell failure.
            status_reg = status_reg | 8'h90;
            $display("%t, Warning: Block[%d] program is failed because the address[%h] cell failure!\n",$realtime,n_block,mem_address);
          end
        end
        programming_block = n_block;
        programming_sector = n_sector;
        //-----Program operation complete
        complete_flag <= #(`Program_Time) ~complete_flag;
      end
    end //end
  end

  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  
  //else if(write_status == quad_program) //under a/a mux interface
  
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

  else if(write_status == block_erase)
  begin
    //if(invalid_cmd == 1'b1) begin write_status = write_command; invalid_cmd = 1'b0; end
    //else begin
    find_blk(mem_address);
    if(lpc_interface == 1'b1) data_in = lpc_data_in;
    if(fwh_interface == 1'b1) data_in = fwh_data_in[0];
    if(data_in == 8'hD0)
    begin
      if(vpp_status == vpp_lockout)
      begin
        $display("%t, Warning: Block[%d] Erase is failed because Vpp error(Vpp < Vcc)!\n",$realtime,n_block);
        write_status = write_command; read_status = read_status_reg;
        status_reg = status_reg | 8'hA8;      //SR indicates "Erase failure due to Vpp Error"
      end
      else
      Protect_Check(wr_protect);
      if(wr_protect == 1'b0)
      begin                                   //A/A Mux interface or erase an unprotected block in fwh/lpc mode
        write_status = write_command; read_status = read_status_reg;
        status_reg = status_reg & 8'h00;      //Status Register = 8'b0000_0000
        $display("%t, Notes: Block[%d] Erase Operation begin!\n",$realtime,n_block);
        BE_Start_Time = $time;
        running_status = BlockErase_Busy;
        for(i=start_addr_block[n_block];i<=end_addr_block[n_block];i=i+1)
        begin
          memory[i] = `DATA_BITS_NUM'hff;
          if(memory[i] & 8'hff !== 8'hff)
          begin
            status_reg = status_reg | 8'hA0;  //SR indicates "Erase failure due to cell failure
            $display("%t, Warning: Block[%d] Erase is failed because address[%h] cell failure!\n",$realtime,n_block,i);
          end
        end
        erasing_block = n_block;
        //------------------------------------//Block Erase Operation Complete
        if(vpp_status == vpp_normal)  BlockErase_Time = `BlockErase_Time_n;
        if(vpp_status == vpp_fast)    BlockErase_Time = `BlockErase_Time_f;
        complete_flag <= #BlockErase_Time ~complete_flag;
      end
    end
    else begin
      $display("%t, Warning: Block Erase Command Sequence is invalid!\n",$realtime);
      write_status = write_command;
      read_status = read_status_reg;
      status_reg = status_reg | 8'hB0;        //SR indicates "Command Sequence Error"
    end //end
  end

  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

  else if(write_status == sector_erase)
  begin
    //if(invalid_cmd == 1'b1) begin write_status = write_command; invalid_cmd = 1'b0; end
    //else begin
    find_blk(mem_address);
    find_sct(mem_address);
    if(lpc_interface == 1'b1) data_in = lpc_data_in;
    if(fwh_interface == 1'b1) data_in = fwh_data_in[0];
    if(data_in == 8'hD0)
    begin
      if(vpp_status == vpp_lockout)
      begin
        $display("%t, Warning: Sector[%d] Erase is failed because Vpp error(Vpp < Vcc)!\n",$realtime,n_sector);
        write_status = write_command; read_status = read_status_reg;
        status_reg = status_reg | 8'hA8;      //SR indicates "Erase failure due to Vpp Error"
      end
      else
      if((FWH_LPC == 1'b1)&&((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
        (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_sector] & `WRITE_LOCK) == `WRITE_LOCK)))
      begin
        $display("%t, Warning: Sector[%d] Erase is failed because this sector is write protected!\n",$realtime,n_sector);
        write_status = write_command; read_status = read_status_reg;
        status_reg = status_reg | 8'hA2;      //SR indicates "Erase failure due to Block Protection"
      end
      else begin                              //A/A Mux interface or erase an unprotected sector in fwh/lpc mode
        write_status = write_command; read_status = read_status_reg;
        status_reg = status_reg & 8'h00;      //Status Register = 8'b0000_0000
        $display("%t, Notes: Sector[%d] Erase Operation begin!\n",$realtime,n_sector);
        SE_Start_Time =$time;
        running_status = SectorErase_Busy;
        for(i=start_addr_sector[n_sector];i<=end_addr_sector[n_sector];i=i+1)
        begin
          memory[i] = `DATA_BITS_NUM'hff;
          if(memory[i] & 8'hff !== 8'hff)
          begin
            status_reg = status_reg | 8'hA0;
            $display("%t, Warning: Sector[%d] Erase is failed because address[%h] cell failure!\n",$realtime,n_sector,i);
          end
        end
        //erasing_block = n_block;
        erasing_sector = n_sector;
        //------------------------------------//Sector Erase Operation Complete
        if(vpp_status == vpp_normal)  SectorErase_Time = `SectorErase_Time_n;
        if(vpp_status == vpp_fast)    SectorErase_Time = `SectorErase_Time_f;
        complete_flag <= #SectorErase_Time ~complete_flag;
      end
    end
    else begin
      $display("%t, Warning: Sector Erase Command sequence is invalid !\n",$realtime);
      write_status = write_command;
      read_status = read_status_reg;
      status_reg = status_reg | 8'hB0;        //SR indicates "Command Sequence Error"
    end //end
  end

  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  /*
  else if(write_status == chip_erase)         //only under a/a mux mode
  begin
    if(lpc_interface == 1'b1) data_in = lpc_data_in;
    if(fwh_interface == 1'b1) data_in = fwh_data_in[0];
    if(data_in == 8'h10)
    begin
      if(vpp_status !== vpp_fast)
      begin
        $display("%t, Warning: Chip Erase is failed because Vpp error(Vpp < Vpph)!\n",$realtime);
        write_status = write_command;
        read_status = read_status_reg;
        status_reg = status_reg | 8'hA8;      //SR indicates "Erase failure due to Vpp Error"
      end
      else begin
        write_status = write_command;
        read_status = read_status_reg;
        running_status = ChipErase_Busy;
        status_reg = status_reg & 8'h00;      //Status Register = 8'b0000_0000
        CE_Start_Time = $time;
        $display("%t, Notes: Chip Erase Operation begin!\n",$realtime);
        for(i=0;i<`MEMORY_SIZE;i=i+1)
        begin
          memory[i] = `DATA_BITS_NUM'hff;
          if(memory[i] & 8'hff !== 8'hff)
          begin
            status_reg = status_reg | 8'hA0;
            $display("%t, Warning: Chip Erase is failed because address[%h] cell failure!\n",$realtime,i);
          end
        end
        //------------------------------------//Chip Erase Operation Complete
        complete_flag <= #(`ChipErase_Time*1000) ~complete_flag;
      end
    end
    else begin
      $display("%t, Warning: Chip Erase Command Sequence is invalid!\n",$realtime);
      write_status = write_command;
      read_status = read_status_reg;
      status_reg = status_reg | 8'hB0;        //SR indicates "Command Sequence Error"
    end
  end
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  */
end
endtask
//=============================================================================

endmodule