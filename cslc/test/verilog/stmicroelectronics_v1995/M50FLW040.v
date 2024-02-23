/******************************************************************************

  M50FLW040A/M50FLW040B Behavioral Model

  4M Bits (5 x 64K Byte Blocks + 3 x 16 x 4K Byte Sectors)
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

  Based on Preview Release of M50FLW040AB Spec Datasheet (May 2004)

*******************************************************************************

  THIS PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
  EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO, THE
  IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS for A PARTICULAR
  PURPOSE. THE ENTIRE RisK AS TO THE QUALITY AND PERforMANCE OF
  THE PROGRAM is WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU
  ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

*******************************************************************************/

`timescale 1ns/1ns

`include "M50FLW040_MACRO.v"


//===============================================
//M50FLW040 memory simulation model
//===============================================
module M50FLW040(VPPH,VPP,VCC,VSS,VCCAUX,IC,CLK,INIT_N,RP_N,WP_N,TBL_N,FWH4_LFRM,GPI,ID,FWH_LAD,RFU);

//--------------------------------
//Signal IO Attribute
//--------------------------------
input VPPH,VPP,VCC,VSS,VCCAUX;    //Power Supply Voltage and Ground
input RP_N,INIT_N,TBL_N;          //Interface Reset,Top Block Lock,CPU Reset
input IC,CLK,WP_N,FWH4_LFRM;      //Interface Configure,Clock,Write Protect,Input Communication Frame
input [`GPI_NUM-1:0] GPI;         //General Purpose Inputs
input [`F_ID_NUM-1:0] ID;         //ID[F_ID_NUM-1] is RFU pin in LPC mode
inout [`IOC_NUM-1:0] FWH_LAD;     //FWH/LPC Input/Output communications
inout [`F_RFU_NUM-1:0] RFU;       //Reserved Pins, leave disconnected

//--------------------------------
//Signal and variable definition
//--------------------------------
reg FWH_LPC,A_A_MUX;              //FWH/LPC or A/A MUX, any time only one is "1".
//reg invalid_cmd;
reg power_on,complete_flag,A22;
reg fwh_interface,lpc_interface;
reg fwh_rd,fwh_wr,lpc_rd,lpc_wr;
reg reset_fall,reset_rise,clk_fall,clk_rise,din_change,fwh4_lfr_fall;

reg [2:0] n_block,erasing_block,programming_block;
reg [5:0] n_sector,erasing_sector,programming_sector;
reg [7:0] DEVICE_CODE,MANUFC_CODE;

integer start_addr_block[`BLOCK_NUM-1:0];
integer end_addr_block[`BLOCK_NUM-1:0];
integer start_addr_sector[`SECTOR_NUM-1:0];
integer end_addr_sector[`SECTOR_NUM-1:0];
integer i,nibble,fwh_nByteRead,fwh_nByteWrite;

//----------------------data output register
reg[`IOC_NUM-1:0] fwh_lpc_dout;
reg[`DATA_BITS_NUM-1:0] data_out_buf;

//----------------------input address latch register
reg[`FWH_ADDR_BITS-1:0] fwh_address;
reg[`LPC_ADDR_BITS-1:0] lpc_address;
reg[`MEM_ADDR_BITS-1:0] mem_address;

//----------------------input data latch register
reg[`DATA_BITS_NUM-1:0] lpc_data_in;
reg[`DATA_BITS_NUM-1:0] fwh_data_in[3:0];

//--------------------- Status Register
reg[`DATA_BITS_NUM-1:0] status_reg;

//--------------------- FWH/LPC Block Lock Register, GPI Register, ManuCode Register
reg[3:0] cr_addr;
reg[`DATA_BITS_NUM-1:0] CR[`BLOCK_NUM+1:0];

//--------------------- Memory Array
reg[`DATA_BITS_NUM-1:0] memory[`MEMORY_SIZE-1:0];

//---------------------------------------------------------
reg[1:0] vpp_status;
//=========================================================
//parameter definition regarding the vpp optional power
//=========================================================
parameter vpp_lockout = 2'b00;
parameter vpp_normal  = 2'b01;
parameter vpp_fast    = 2'b10;

//--------------------------------------------------------- 
reg[1:0] read_status;
reg[2:0] write_status;
reg[4:0] bus_op_status;
reg[2:0] running_status;
reg[2:0] previous_status;
//=========================================================
//parameter definition regarding the read_status 
//=========================================================
parameter read_status_reg = 2'b00;
parameter read_elec_sign  = 2'b01;
parameter read_memory     = 2'b10;
//=========================================================
//parameter definition regarding the write_status 
//=========================================================
parameter write_command   = 3'b000;
parameter program         = 3'b001;
parameter quad_program    = 3'b010;
parameter block_erase     = 3'b011;
parameter sector_erase    = 3'b100;
parameter chip_erase      = 3'b101;
//=========================================================
//parameter definition regarding the FWH/LPC bus operation
//=========================================================
//-------------------------------------FWH bus_op_status
parameter get_start       = 5'b00000;
parameter get_idsel       = 5'b00001;
parameter get_fwh_addr    = 5'b00010;
parameter get_fwh_msize   = 5'b00011;
parameter get_fwh_tar_in  = 5'b00100;
parameter get_fwh_data_in = 5'b00101;
parameter fwh_tar_out_1   = 5'b00110;
parameter fwh_wsync       = 5'b00111;
parameter fwh_sync        = 5'b01000;
parameter fwh_data_out    = 5'b01001;
parameter fwh_tar_out_2   = 5'b01010;
parameter fwh_tar_float   = 5'b01011;
//-------------------------------------LPC bus_op_status
parameter get_cyctype_dir = 5'b01100;
parameter get_lpc_addr    = 5'b01101;
parameter get_lpc_tar_in  = 5'b01110;
parameter get_lpc_data_in = 5'b01111;
parameter lpc_tar_out_1   = 5'b10000;
parameter lpc_wsync       = 5'b10001;
parameter lpc_sync        = 5'b10010;
parameter lpc_data_out    = 5'b10011;
parameter lpc_tar_out_2   = 5'b10100;
parameter lpc_tar_float   = 5'b10101;
//=========================================================
//parameter definition regarding the running_status
//=========================================================
parameter Free             = 3'b000;
parameter ResetCycle_Busy  = 3'b001;
parameter ProgSusp_Busy    = 3'b010;
parameter EraseSusp_Busy   = 3'b011;
parameter Program_Busy     = 3'b100;
parameter BlockErase_Busy  = 3'b101;
parameter SectorErase_Busy = 3'b110;
parameter ChipErase_Busy   = 3'b111;

//=========================================================
//variables definition regarding ac characteristics
//=========================================================
time BlockErase_Time,SectorErase_Time;
time PGM_Start_Time,CE_Start_Time,BE_Start_Time,SE_Start_Time,PGM_Susp_Time,ES_Susp_Time;
time power_on_time,tr_reset,tf_reset,tr_fwh4_lfrm,tf_fwh4_lfrm,tr_clk,tf_clk,tr_clk_p,t_din;

//==========================================
//A/A Mux Interface Signal Name
//==========================================
//Note: VPP,VCC,VSS,IC,RP_N Signal name is 
//      same in the FWH/LPC interface mode
//      and A/A Mux interface mode.
//------------------------------------------
reg R_B;
reg [`AAMUX_DAT_BITS-1:0] aamux_dout;
//-------------------------------------
wire R_C = CLK;
wire G_N = INIT_N;
wire W_N = FWH4_LFRM;
wire [`AAMUX_ADD_BITS-1:0] aamux_add;
wire [`AAMUX_DAT_BITS-1:0] aamux_din;
//-------------------------------------
assign aamux_add[0] = WP_N;
assign aamux_add[`AAMUX_ADD_BITS-6] = WP_N;
assign aamux_add[`AAMUX_ADD_BITS-7] = TBL_N;
assign aamux_add[`AAMUX_ADD_BITS-1:`AAMUX_ADD_BITS-5] = GPI;
assign aamux_add[`AAMUX_ADD_BITS-8:`AAMUX_ADD_BITS-11] = ID;
assign aamux_din[`AAMUX_DAT_BITS-1:`AAMUX_DAT_BITS-4] = RFU[3:0];
assign aamux_din[`AAMUX_DAT_BITS-5:`AAMUX_DAT_BITS-8] = FWH_LAD;
assign RFU[4] = A_A_MUX? R_B : 1'bz;
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
  $display("%t: NOTE: Load memory with Initial content.",$realtime); 
  $readmemh("M50FLW040_Init.txt",memory);
  $display("%t: NOTE: Initial Load End.\n",$realtime);
  //-----------------------------------//Block Addresses Setup
  for(i=0;i<`BLOCK_NUM;i=i+1)
  begin
    start_addr_block[i] = `BLOCK_SIZE * i;
    end_addr_block[i] = start_addr_block[i] + `BLOCK_SIZE - 1;
  end
  //-----------------------------------//Sector Addresses Setup for M50FLW040A
  `ifdef M50FLW040A
  DEVICE_CODE = `DEVICECODE_A;
  MANUFC_CODE = `MANUFACTURECODE;
  for(i=0;i<`SECTOR_NUM;i=i+1)
  begin
    if(i<(`SECTOR_NUM/3)) start_addr_sector[i] = `SECTOR_SIZE * i;
    else start_addr_sector[i] = `BLOCK_SIZE * (`BLOCK_NUM - 2) + `SECTOR_SIZE*(i-`SECTOR_NUM/3);
    end_addr_sector[i] = start_addr_sector[i] + `SECTOR_SIZE - 1;
    //$display("Sector[%d] start address = [%h], end address = [%h]",i,start_addr_sector[i],end_addr_sector[i]);//hu
  end
  `endif
  //-----------------------------------//Sector Addresses Setup for M50FLW040B
  `ifdef M50FLW040B
  DEVICE_CODE = `DEVICECODE_B;
  MANUFC_CODE = `MANUFACTURECODE;
  for(i=0;i<`SECTOR_NUM;i=i+1)
  begin
    if(i<(`SECTOR_NUM*2/3)) start_addr_sector[i] = `SECTOR_SIZE * i;
    else start_addr_sector[i] = `BLOCK_SIZE * (`BLOCK_NUM - 1) + `SECTOR_SIZE*(i-`SECTOR_NUM*2/3);
    end_addr_sector[i] = start_addr_sector[i] + `SECTOR_SIZE - 1;
    //$display("Sector[%d] start address = [%h], end address = [%h]",i,start_addr_sector[i],end_addr_sector[i]);//hu
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
    if(reset == 1'b0)                 //reset is driven low,in reset mode
    begin
      if(A_A_MUX == 1'b1)
        aamux_dout = {`AAMUX_DAT_BITS{1'bz}};
      else
      if(FWH_LPC == 1'b1)
      begin
        fwh_lpc_dout = {`IOC_NUM{1'bz}};
        bus_op_status = get_start;
      end
      reset_fall = 1'b1;
      tf_reset = $time;
      running_status = ResetCycle_Busy;
    end
//-------------------------------------
    else if(reset == 1'b1)            //reset is driven high, device in normal operation
    begin
      if(reset_fall == 1'b1)
      begin
        reset_rise = 1'b1;
        tr_reset = $time;
        CR_Initialization;
        status_reg = 8'h80;
        if(tr_reset - tf_reset < `tPLPH)
        begin                         //Reset Pulse Width < Spec requires
          $display("%t, Warning: Reset Pulse Width(tPLPH) violated.\n",$realtime);
        end
        else if(tr_reset - tf_reset >= `tPLPH && tr_reset - tf_reset < `tPLRH)
        begin                         //reset driven low to RESET must above tPLRH
          running_status = ResetCycle_Busy;
          while($time - tf_reset < `tPLRH)  #1;
          $display("%t, Note: Memory is Reset OK!\n",$realtime);
          running_status = Free;
          status_reg = 8'h80;
          write_status = write_command;
          read_status = read_memory;
        end
        else if(tr_reset - tf_reset >= `tPLRH)
        begin                         //Reset Pulse Width > the time bewteen RST_N low to Reset
          $display("%t, Note: Memory is reset OK!\n",$realtime);
          running_status = Free;
          status_reg = 8'h80;
          write_status = write_command;
          read_status = read_memory;
        end
      end
    end
  end
  else $display("%t, Warning: VCC is less than Vcc Lockout Voltage. Reset has no effect!\n",$realtime);
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
  begin                               //After Power on, IC can be changed during a Reset
    if(IC == 1'b1)
    begin
      A_A_MUX = 1'b1; FWH_LPC = 1'b0;
      $display("%t, Warning: A/A Mus Interface is not support in this model, it will be supported in future!\n",$realtime);
      $finish;
    end
    else begin
      FWH_LPC = 1'b1; A_A_MUX = 1'b0; //IC pin is left to float or driven low, FWH or LPC interface is selected
      $display("%t, Note: FWH/LPC Interface is selected!\n",$realtime);
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
  if(reset_rise == 1'b1)
  begin
    if(tf_fwh4_lfrm - tr_reset < `tPHFL)
    begin
      $display("%t, Warning: Reset High to FWH4/LFRAME Low(tPHFL) violated.\n",$realtime);
    end
  end
  if((FWH_LPC == 1'b1)&&(power_on == 1'b1)&&($time - power_on_time > 0)&&(running_status !== ResetCycle_Busy))
  begin
    fwh_lpc_dout = 4'hz;              //FWH_LAD as input
    if(bus_op_status !== get_start)
    begin
      bus_op_status = get_start;
      $display("%t, Warning: FWH4_LFRAME is Low during a bus operation. The operation is aborted!\n", $realtime);
    end
  end
  else if(power_on == 1'b0)
    $display("%t, Warning: VCC is less than Vcc Lockout Voltage. FWH4_LFRAME has no effect!\n",$realtime);
  else if(running_status == ResetCycle_Busy)
    $display("%t, Warning: FWH4_LFRAME has no effect during RESET mode!\n",$realtime);
end

//=====================================
//General Purpose Input
//=====================================
always@(GPI)
begin
  if((FWH_LPC == 1'b1)&&((power_on == 1'b1)&&($time - power_on_time > 0))&&(running_status !== ResetCycle_Busy))
  begin
    if(GPI[0] == 1'b1) CR[8] = CR[8]|8'b00000001;
    else CR[8] = CR[8]&8'b00011110;
    if(GPI[1] == 1'b1) CR[8] = CR[8]|8'b00000010;
    else CR[8] = CR[8]&8'b00011101;
    if(GPI[2] == 1'b1) CR[8] = CR[8]|8'b00000100;
    else CR[8] = CR[8]&8'b00011011;
    if(GPI[3] == 1'b1) CR[8] = CR[8]|8'b00001000;
    else CR[8] = CR[8]&8'b00010111;
    if(GPI[4] == 1'b1) CR[8] = CR[8]|8'b00010000;
    else CR[8] = CR[8]&8'b00001111;   //CR[8]: General Purpose Inputs Register
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
    else begin                          //Suspend complete during a program operation, PG/ES CTR is Paused
      $display("%t, Note: Program Suspend, Program/Erase Controller is Paused!\n",$realtime);
      status_reg = status_reg | 8'h84;  //SR=1x00_0100(84 or C4), Program Suspended
      running_status = Free;
      write_status = write_command;
    end
  end
  else if(running_status == EraseSusp_Busy)
  begin
    if($time - ES_Susp_Time < `EraseSusp_Time)
      complete_flag <= #(`EraseSusp_Time - ($time - ES_Susp_Time)) ~complete_flag;
    else begin                          //Suspend complete during a sector/block erase, PG/ES CTR is Paused
      $display("%t, Note: Erase Suspend, Program/Erase Controller is Paused!\n",$realtime);
      status_reg = status_reg | 8'hC0;  //SR=1100_0000(C0), Erase Suspended
      running_status = Free;
      write_status = write_command;
    end
  end
  else begin
    if(running_status == Program_Busy)
    begin
      `ifdef M50FLW040A
      if((n_block == `TOPBLOCK)||(n_block == `TOPBLOCK-1)||(n_block == 0))
        $display("%t, Notes: Sector [%d] Program Operation Complete!\n",$realtime,programming_sector);
      else
        $display("%t, Notes: Block[%d] Program Operation Complete!\n",$realtime,programming_block);
      `endif
      `ifdef M50FLW040B
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
    status_reg = status_reg | 8'h80;
    running_status = Free;
    write_status = write_command;
  end
end

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
    din_change = 1'b1;
    t_din = $time;
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
//FWH/LPC Interface and A/A Mux Interface Operation
//=========================================================
always@(posedge CLK)
begin
  tr_clk = $time;
  if(clk_rise == 1'b1)
  begin
    if(tr_clk - tr_clk_p < `tCYC)
    begin
      $display("%t, Warning: Clock Cycle Time(tCYC) violated, tCYC < 30ns.\n",$realtime);
    end
  end
  clk_rise = 1'b1;
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
  if(fwh4_lfr_fall == 1'b1)
  begin
    if(tr_clk - tf_fwh4_lfrm < `tFLCH)
    begin
      $display("%t, Warning: Input Set-Up Time on FHW4_LFRAME(tFLCH) violated!\n",$realtime);
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
    //else if((bus_op_status == get_start)&&(FWH4_LFRM !== 1'b0))
    //begin
    //  $display("%t, Warning: The bus operation is not initial because Input Communication Frame is not low!\n",$realtime);
    //end
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
        nibble = nibble + 1;    //most significant nibble first
        if(nibble >= 7)
        begin
          A22 = fwh_address[`REG_MEM_ENBIT];
          if(A22 == 1'b1)       //A19~A21,A23~A27 are treated as don't care during memory array access
          begin
            mem_address = fwh_address[`MEM_ADDR_BITS-1:0];
            nibble = 0; bus_op_status = get_fwh_msize;
          end
          if(A22 == 1'b0)       //A27~A23,A21~A19 must be "1",A18~A16 for lock register accsee
          begin
            nibble = 0; bus_op_status = get_fwh_msize;
            case(fwh_address[`REG_ADDR_BITS-1:0])
              28'hFBF0002: cr_addr = 4'h7;    //Top Block Lock Register (Block 7)
              28'hFBE0002: cr_addr = 4'h6;    //Top Block [-1] Lock Register (Block 6)
              28'hFBD0002: cr_addr = 4'h5;    //Top Block [-2] Lock Register (Block 5)
              28'hFBC0002: cr_addr = 4'h4;    //Top Block [-3] Lock Register (Block 4)
              28'hFBB0002: cr_addr = 4'h3;    //Top Block [-4] Lock Register (Block 3)
              28'hFBA0002: cr_addr = 4'h2;    //Top Block [-5] Lock Register (Block 2)
              28'hFB90002: cr_addr = 4'h1;    //Top Block [-6] Lock Register (Block 1)
              28'hFB80002: cr_addr = 4'h0;    //Top Block [-7] Lock Register (Block 0)
              28'hFBC0100: cr_addr = 4'h8;    //General Purpose Inputs Register, Read only
              28'hFBC0000: cr_addr = 4'h9;    //Manufacture Code Register, Read only
              default: begin
                nibble = 0; bus_op_status = get_start;
                $display("%t, Warning: The address[%h] for CR access is not correct! Bus operation must be re-started!\n",$realtime,fwh_address[`REG_ADDR_BITS-1:0]);
              end
            endcase
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
          #(`tCHQZ_MAX);  //TAR OUT Field, Clock to Inactive
          fwh_lpc_dout = 4'hz;
          if(fwh_wr == 1'b1) begin nibble = 0; bus_op_status = fwh_sync; end
          else if(fwh_rd == 1'b1) begin nibble = 0; bus_op_status = fwh_wsync; end
        end
        else begin
          nibble = 0; bus_op_status = get_start;
          $display("%t, Warning: The host must drive FWH_LAD[0~3] to 1111! Bus operation must be re-started!\n",$realtime);
        end
      end

    //----------------------------------------------TAR OUT Field, Firmware Hub Interface Bus Operation
    /*else if((fwh_interface == 1'b1)&&(bus_op_status == fwh_tar_out_1))
      begin
        #(`tCHQZ_MAX);  //Clock to Inactive
        fwh_lpc_dout = 4'hz;
        if(fwh_wr == 1'b1) begin nibble = 0; bus_op_status = fwh_sync; end
        else if(fwh_rd == 1'b1) begin nibble = 0; bus_op_status = fwh_wsync; end
      end*/

    //----------------------------------------------WSYNC Field, Firmware Hub Read Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == fwh_wsync))
      begin
        #(`tCHQX_MIN);  //Clock to Active
        fwh_lpc_dout = 4'h5;
        nibble = nibble + 1;
        if(nibble >= 2)
        begin
          nibble = 0; bus_op_status = fwh_sync;     //fwh_sync is equal fwh_rsync
        end
      end

    //----------------------------------------------RSYNC(SYNC) Field, Firmware Hub Interface Bus Operation(TBD)
    else if((fwh_interface == 1'b1)&&(bus_op_status == fwh_sync))
      begin
        #(`tCHQV_MAX);  //Clock to Data out
        fwh_lpc_dout = 4'h0;
        if(fwh_wr == 1'b1)
        begin           //Drives FWH_LAD0~3=0000b,indicating data(cmd) has been received in this cycle (Write Bus OP)
          if(A22 == 1'b0) RegWriteOp;
          if(A22 == 1'b1) MemWriteOp;
          nibble = 0;
          bus_op_status = fwh_tar_out_2;
        end
        if(fwh_rd == 1'b1)
        begin           //Drives FWH_LAD0~3 to 0000b,indicating data will be available in next cycle (Read Bus OP)
          if(A22 == 1'b1) begin
            case(fwh_nByteRead)
              1:    mem_address = mem_address & `MEM_ADDR_BITS'h7ffff;
              2:    mem_address = mem_address & `MEM_ADDR_BITS'h7fffe;
              4:    mem_address = mem_address & `MEM_ADDR_BITS'h7fffc;
              16:   mem_address = mem_address & `MEM_ADDR_BITS'h7fff0;
              128:  mem_address = mem_address & `MEM_ADDR_BITS'h7ff10;
            endcase     //memory address aligned according to the MSIZE granularity
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
             #(`tCHQV_MAX);  //Clock to Data out
             fwh_lpc_dout = data_out_buf[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
           end
        1: begin
             #(`tCHQV_MAX);  //Clock to Data out
             fwh_lpc_dout = data_out_buf[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
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
        #(`tCHQV_MAX);  //Clock to Data Out
        fwh_lpc_dout = 4'hf;
        nibble = 0; bus_op_status = fwh_tar_float;
      end

    //----------------------------------------------TAR float Field, Firmware Hub Interface Bus Operation
    else if((fwh_interface == 1'b1)&&(bus_op_status == fwh_tar_float))
      begin
        #(`tCHQZ_MAX);  //CLock to Inactive
        fwh_lpc_dout = 4'hz;
        nibble = 0; bus_op_status = get_start;
      end
  //################################################################# Firmware Hub Interface Bus Operation over

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
        begin         //A23~A31 must be set to "1"
          if(lpc_address[`LPC_ADDR_BITS-1:`REG_MEM_ENBIT+1] == {(`LPC_ADDR_BITS-`REG_MEM_ENBIT-1){1'b1}})
          begin       //ID line and A21,A20,A19 must be set according to the rules(for LPC interface)
            if(lpc_address[21:19] !== ~id_in[2:0])
            begin
              nibble = 0; bus_op_status = get_start;
              $display("%t, Warning: In Low Pin Count Interface mode, ID line and A19~A21 is not according to the rules. Bus operation must be re-started!\n",$realtime);
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
                if(lpc_rd == 1'b1) begin nibble = 0; bus_op_status = get_lpc_tar_in; end
                if(lpc_wr == 1'b1) begin nibble = 0; bus_op_status = get_lpc_data_in; end
                case(lpc_address[`MEM_ADDR_BITS-1:0])
                  19'h70002: cr_addr = 4'h7;    //Top Block Lock Register (Block 7)
                  19'h60002: cr_addr = 4'h6;    //Top Block [-1] Lock Register (Block 6)
                  19'h50002: cr_addr = 4'h5;    //Top Block [-2] Lock Register (Block 5)
                  19'h40002: cr_addr = 4'h4;    //Top Block [-3] Lock Register (Block 4)
                  19'h30002: cr_addr = 4'h3;    //Top Block [-4] Lock Register (Block 3)
                  19'h20002: cr_addr = 4'h2;    //Top Block [-5] Lock Register (Block 2)
                  19'h10002: cr_addr = 4'h1;    //Top Block [-6] Lock Register (Block 1)
                  19'h00002: cr_addr = 4'h0;    //Top Block [-7] Lock Register (Block 0)
                  19'h40100: cr_addr = 4'h8;    //General Purpose Inputs Register, Read only
                  19'h40000: cr_addr = 4'h9;    //Manufacture Code Register, Read only
                  default: begin
                    nibble = 0; bus_op_status = get_start;
                    $display("%t, Warning: The address[%h] for CR access is not correct! Bus operation must be re-started!\n",$realtime,fwh_address[`REG_ADDR_BITS-1:0]);
                  end
                endcase
              end
            end
          end
          else begin
            nibble = 0; bus_op_status = get_start;
            $display("%t, Warning: In Low Pin Count Interface mode, A23~A31 must be set to 1! Bus operation must be re-started!\n",$realtime);
          end
        end
      end
  //------------------------------------------------------- DATA IN Field, Low Pin Count write Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == get_lpc_data_in))
      begin
        case(nibble)  //only 1 byte data transfer, LSN first
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
          #(`tCHQZ_MAX);  //TAR OUT Field, Clock to Inactive
          fwh_lpc_dout = 4'hz;
          if(lpc_rd == 1'b1)  begin nibble = 0; bus_op_status = lpc_wsync; end
          if(lpc_wr == 1'b1)  begin nibble = 0; bus_op_status = lpc_sync; end
        end
        else begin
          nibble = 0; bus_op_status = get_start;
          $display("%t, Warning: The host must drive FWH_LAD[0~3] to 1111! Bus operation must be re-started!\n",$realtime);
        end
      end    
  //------------------------------------------------------- TAR OUT Field, Low Pin Count Interface Bus Operation
  /*  else if((lpc_interface == 1'b1)&&(bus_op_status == lpc_tar_out_1))
      begin
        #(`tCHQZ_MAX);  //Clock to Inactive
        fwh_lpc_dout = 4'hz;
        if(lpc_rd == 1'b1)  begin nibble = 0; bus_op_status = lpc_wsync; end
        if(lpc_wr == 1'b1)  begin nibble = 0; bus_op_status = lpc_sync; end
      end*/
  //-------------------------------------------------------  WSYNC Field, Low Pin Count Read Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == lpc_wsync))
      begin
        #(`tCHQX_MIN);  //CLock to Active
        fwh_lpc_dout = 4'b0101;
        nibble = nibble + 1;
        if(nibble >= 2)
        begin           //fwh_sync is equal lpc_rsync
          nibble = 0; bus_op_status = lpc_sync;
        end
      end
  //------------------------------------------------------- RSYNC(SYNC) Field, Low Pin Count Interface Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == lpc_sync))
      begin
        #(`tCHQX_MIN);  //CLock to Active
        fwh_lpc_dout = 4'b0000;
        if(lpc_wr == 1'b1)
        begin           //Drives FWH_LAD0~3 to 0000b,indicating data(cmd) has been received in this cycle (Write Bus OP)
          if(lpc_address[22] == 1'b0) RegWriteOp;
          if(lpc_address[22] == 1'b1) MemWriteOp;
          nibble = 0; bus_op_status = lpc_tar_out_2;
        end
        if(lpc_rd == 1'b1)
        begin           //Drives FWH_LAD0~3 to 0000b,indicating data will be available in next cycle (Read Bus OP)
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
              #(`tCHQV_MAX);  //Clock to Data out
              fwh_lpc_dout = data_out_buf[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
             end
          1: begin
              #(`tCHQV_MAX);  //Clock to Data out
              fwh_lpc_dout = data_out_buf[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
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
        #(`tCHQV_MAX);  //Clock to Data Out
        fwh_lpc_dout = 4'b1111;
        nibble = 0; bus_op_status = lpc_tar_float;
      end
    //----------------------------------------------------- TAR FLOAT Field, Low Pin Count Interface Bus Operation
    else if((lpc_interface == 1'b1)&&(bus_op_status == lpc_tar_float))
      begin
        #(`tCHQZ_MAX);  //Clock to Inactive
        fwh_lpc_dout = 4'hz;
        nibble = 0; bus_op_status = get_start;
      end
  //################################################################# Low Pin Count Interface Bus Operation over
  end

  //=======================================================
  //A/A Mux Interface operation TBD
  //=======================================================
  if((A_A_MUX == 1'b1)&&((power_on == 1'b1) && ($time - power_on_time > 0))&&(running_status !== ResetCycle_Busy))
  begin
    //TBD: A/A MUX interface operation
  end
  //################################################################# A/A Mux Interface Bus Operation over

  if(power_on == 1'b0)
    $display("%t, Warning: Memory has not been Power-on before clock cycle starts!\n",$realtime);
  //if(running_status == ResetCycle_Busy)
  //  $display("%t, Warning: This clock cylce is of no effect during RESET mode!\n",$realtime);
end
//=======================================================================================

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//task definition
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
task CR_Initialization;
begin
  CR[0] = 8'h01; CR[1] = 8'h01; CR[2] = 8'h01;
  CR[3] = 8'h01; CR[4] = 8'h01; CR[5] = 8'h01;
  CR[6] = 8'h01; CR[7] = 8'h01; CR[9] = 8'h20;
end
endtask

//=============================================================================
task find_block;
input[`MEM_ADDR_BITS:0] addr;
integer i;
begin  
  for(i=0;i<`BLOCK_NUM;i=i+1)
    if(addr >= start_addr_block[i] && addr <= end_addr_block[i]) n_block = i; 
  end
endtask

//=============================================================================
task find_sector;
input[`MEM_ADDR_BITS:0] addr;
integer i;
begin
  for(i=0;i<`SECTOR_NUM;i=i+1)
    if(addr >= start_addr_sector[i] && addr <= end_addr_sector[i]) n_sector = i;
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
  if(cr_addr == 4'h8)     //gpi status register (read only)
    $display("%t, Warning: General Purpose Input Register is read only, writing to it has no effect!\n",$realtime);
  else
  if(cr_addr == 4'h9)     //manufacture code register (read only)
    $display("%t, Warning: Manufacture Code Register is read only, writing to it has no effect!\n",$realtime);
  else begin
    if((CR[cr_addr] & `DATA_BITS_NUM'h02) == `DATA_BITS_NUM'h00)
    begin
      $display("%t, Note: Block[%d] Lock Register Write Begin!\n",$realtime,cr_addr);
      CR[cr_addr] = data_in & 8'b00000111;
      $display("%t, Note: Block[%d] Lock Register Write Complete!\n",$realtime,cr_addr);
    end
    else
      $display("%t, Warning: Block[%d] Lock Register is locked down and can not be changed!\n",$realtime,cr_addr);
  end
end
endtask

//===================================================================
task MemReadOp;                       //Task for read Memory Array
begin
  find_block(mem_address);
  //----------------------------------Read Status Register Command
  if(read_status == read_status_reg)
  begin
    data_out_buf = status_reg;
  end
  //----------------------------------Read Electronic Signature Command
  if(read_status == read_elec_sign)
  begin
    if(mem_address == `DEVICECODE_ADDR)
    begin
      data_out_buf = DEVICE_CODE;
    end
    else
    if(mem_address == `MANUFCCODE_ADDR)
    begin
      data_out_buf = MANUFC_CODE;
    end
    else begin                        
      $display("%t, Warning: Invalid Address! It's impossible to read Manufacturer Code or Device Code!\n",$realtime);
      data_out_buf = {`DATA_BITS_NUM{1'bx}};  //Output "X", if address is incorrect
    end
  end
  //----------------------------------Read Memory Array Command
  if(read_status == read_memory)
  begin
    if(FWH_LPC == 1'b1) 
    begin
      if((CR[n_block] & `READ_LOCK) !== (`READ_LOCK)) data_out_buf = memory[mem_address];
      else begin
        $display("%t, Warning: Invalid Address! This block[%d] is protected to read!\n",$realtime,n_block);
        data_out_buf = {`DATA_BITS_NUM{1'b0}};
      end
    end
  end
  //-----------------------------------------------------------------
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
    case(data_in) //Command Decode
    //-------------------------------------------
      //-----------------------------------------1.Read Memory Array Command
      8'hff: begin
        if(running_status == Free && status_reg[7] == 1'b1)
          read_status = read_memory;
        else $display("%t, Warning: Invalid Read Memory Array Command! Device Busy, or Program/Erase controller error!\n",$realtime);
      end
      //-----------------------------------------2.Read Status Register Command
      8'h70: begin
        if(running_status !== ProgSusp_Busy && running_status !== EraseSusp_Busy)
          read_status = read_status_reg;
        else $display("%t, Warning: Read Status Register Command can not be accepted until the Program/Erase controller has pauesd!\n",$realtime);
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
            previous_status = running_status; //save which erase op. before suspend for resume
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
          status_reg = status_reg & 8'h40;    //SR=8'b0x00_0000
          read_status = read_status_reg;
          complete_flag <= #(`Program_Time-(PGM_Susp_Time-PGM_Start_Time)) ~complete_flag;
        end
        else if(running_status == Free && status_reg == 8'hC0)
        begin
          if(previous_status == BlockErase_Busy) 
          begin
            $display("%t, Note: Block Erase Resume, Program/Erase Controller is re-start!\n",$realtime);
            running_status = BlockErase_Busy;
            status_reg = status_reg & 8'h00;    //SR=8'b0000_0000
            read_status = read_status_reg;
            complete_flag <= #(BlockErase_Time-(ES_Susp_Time-BE_Start_Time)) ~complete_flag;
          end
          else begin
            $display("%t, Note: Sector Erase Resume, Program/Erase Controller is re-start!\n",$realtime);
            running_status = SectorErase_Busy;
            status_reg = status_reg & 8'h00;    //SR=8'b0000_0000
            read_status = read_status_reg;
            complete_flag <= #(SectorErase_Time-(ES_Susp_Time-SE_Start_Time)) ~complete_flag;
          end
        end
        /*else
        if(status_reg==8'h98 || status_reg==8'hD8 || status_reg==8'h92 || status_reg==8'hD2 || status_reg==8'h90 ||
           status_reg==8'hD0 || status_reg==8'hA8 || status_reg==8'hA2 || status_reg==8'hA0)*/
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
    find_block(mem_address);
    find_sector(mem_address);
    if(((fwh_nByteWrite == 2)||(fwh_nByteWrite == 1)||(lpc_interface == 1'b1))&&(vpp_status == vpp_lockout))
    begin
      $display("%t, Warning: Program/Multiple Byte Program is failed because Vpp error!\n",$realtime);
      write_status = write_command; read_status = read_status_reg;
      status_reg = status_reg | 8'h98;  //SR indicates "Program failure due to Vpp Error"
    end
    else
    if((fwh_nByteWrite == 4) && (vpp_status !== vpp_fast))
    begin
      $display("%t, Warning: Quadruple Byte Program is failed because Vpp error(Vpp is not at Vpph)!\n",$realtime);
      write_status = write_command; read_status = read_status_reg;
      status_reg = status_reg | 8'h98;  //SR indicates "Program failure due to Vpp Error"
    end
    else
    `ifdef M50FLW040A
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
    `ifdef M50FLW040B
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
    else
    if((FWH_LPC == 1'b1) && ((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
      (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_block] & `WRITE_LOCK) == `WRITE_LOCK)))
    begin
      $display("%t, Warning: Program is failed because the block[%d] is write protected!\n",$realtime,n_block);
      write_status = write_command;
      read_status = read_status_reg;
      status_reg = status_reg | 8'h92;  //SR indicates "Program failure due to Block Protection"
    end
    else begin                          //a/a mux interface or write to an unprotected block in fwh/lpc mode
      write_status = write_command;
      read_status = read_status_reg;
      status_reg = status_reg & 8'h40;  //SR=8'b0x00_0000(00 or 40)
      `ifdef M50FLW040A
      if((n_block == `TOPBLOCK)||(n_block == `TOPBLOCK-1)||(n_block == 0))
       $display("%t, Notes: Sector [%d] Program Operation begin!\n",$realtime,n_sector);
      else
       $display("%t, Notes: Block[%d] Program Operation begin!\n",$realtime,n_block);
      `endif
      `ifdef M50FLW040B
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
    end //end
  end
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  
  //else if(write_status == quad_program) //under a/a mux interface
  
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

  else if(write_status == block_erase)
  begin
    //if(invalid_cmd == 1'b1) begin write_status = write_command; invalid_cmd = 1'b0; end
    //else begin
    find_block(mem_address);
    if(lpc_interface == 1'b1) data_in = lpc_data_in;
    if(fwh_interface == 1'b1) data_in = fwh_data_in[0];
    if(data_in == 8'hD0)
    begin
      if(vpp_status == vpp_lockout)
      begin
        $display("%t, Warning: Block[%d] Erase is failed because Vpp error(Vpp < Vcc)!\n",$realtime,n_block);
        write_status = write_command;
        read_status = read_status_reg;
        status_reg = status_reg | 8'hA8;  //SR indicates "Erase failure due to Vpp Error"
      end
      else
      if((FWH_LPC == 1'b1)&&((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
        (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_block] & `WRITE_LOCK) == `WRITE_LOCK)))
      begin
        $display("%t, Warning: Block[%d] Erase is failed because this block is write protected!\n",$realtime,n_block);
        write_status = write_command;
        read_status =  read_status_reg;
        status_reg = status_reg | 8'hA2;  //SR indicates "Erase failure due to Block Protection"
      end
      else begin                          //A/A Mux interface or erase an unprotected block in fwh/lpc mode
        write_status = write_command;
        read_status = read_status_reg;
        status_reg = status_reg & 8'h00;  //SR=8'b0000_0000
        $display("%t, Notes: Block[%d] Erase Operation begin!\n",$realtime,n_block);
        BE_Start_Time = $time;
        running_status = BlockErase_Busy;
        for(i=start_addr_block[n_block];i<=end_addr_block[n_block];i=i+1)
        begin
          memory[i] = {`DATA_BITS_NUM{1'b1}};
          if(memory[i] & 8'hff !== 8'hff)
          begin                           //SR indicates "Erase failure due to cell failure
            status_reg = status_reg | 8'hA0;
            $display("%t, Warning: Block[%d] Erase is failed because address[%h] cell failure!\n",$realtime,n_block,i);
          end
        end
        erasing_block = n_block;
        //--------------------------------//block erase operation complete
        if(vpp_status == vpp_normal)  BlockErase_Time = `BlockErase_Time_n;
        if(vpp_status == vpp_fast)    BlockErase_Time = `BlockErase_Time_f;
        complete_flag <= #BlockErase_Time ~complete_flag;
      end
    end
    else begin
      $display("%t, Warning: Block Erase Command Sequence is invalid!\n",$realtime);
      write_status = write_command;
      read_status = read_status_reg;
      status_reg = status_reg | 8'hB0;    //SR indicates "Command Sequence Error"
    end //end
  end
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

  else if(write_status == sector_erase)
  begin
    //if(invalid_cmd == 1'b1) begin write_status = write_command; invalid_cmd = 1'b0; end
    //else begin
    find_block(mem_address);
    find_sector(mem_address);
    if(lpc_interface == 1'b1) data_in = lpc_data_in;
    if(fwh_interface == 1'b1) data_in = fwh_data_in[0];
    if(data_in == 8'hD0)
    begin
      if(vpp_status == vpp_lockout)
      begin
        $display("%t, Warning: Sector[%d] Erase is failed because Vpp error(Vpp < Vcc)!\n",$realtime,n_sector);
        write_status = write_command;
        read_status = read_status_reg;
        status_reg = status_reg | 8'hA8;  //SR indicates "Erase failure due to Vpp Error"
      end
      else
      if((FWH_LPC == 1'b1)&&((TBL_N == 1'b0 && n_block == `TOPBLOCK)||
        (WP_N == 1'b0 && n_block !== `TOPBLOCK)||((CR[n_block] & `WRITE_LOCK) == `WRITE_LOCK)))
      begin
        $display("%t, Warning: Sector[%d] Erase is failed because this sector is write protected!\n",$realtime,n_sector);
        write_status = write_command;
        read_status = read_status_reg;
        status_reg = status_reg | 8'hA2;  //SR indicates "Erase failure due to Block Protection"
      end
      else begin                          //A/A Mux interface or erase an unprotected sector in fwh/lpc mode
        write_status = write_command;
        read_status = read_status_reg;
        status_reg = status_reg & 8'h00;  //SR=8'b0000_0000
        $display("%t, Notes: Sector[%d] Erase Operation begin!\n",$realtime,n_sector);
        SE_Start_Time =$time;
        running_status = SectorErase_Busy;
        for(i=start_addr_sector[n_sector];i<=end_addr_sector[n_sector];i=i+1)
        begin
          memory[i] = {`DATA_BITS_NUM{1'b1}};
          if(memory[i] & 8'hff !== 8'hff)
          begin
            status_reg = status_reg | 8'hA0;
            $display("%t, Warning: Sector[%d] Erase is failed because address[%h] cell failure!\n",$realtime,n_sector,i);
          end
        end
        erasing_block = n_block;
        erasing_sector = n_sector;
        //--------------------------------//sector erase operation complete
        if(vpp_status == vpp_normal)  SectorErase_Time = `SectorErase_Time_n;
        if(vpp_status == vpp_fast)    SectorErase_Time = `SectorErase_Time_f;
        complete_flag <= #SectorErase_Time ~complete_flag;
      end
    end
    else begin
      $display("%t, Warning: Sector Erase Command sequence is invalid !\n",$realtime);
      write_status = write_command;
      read_status = read_status_reg;
      status_reg = status_reg | 8'hB0;    //SR indicates "Command Sequence Error"
    end //end
  end
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

  else if(write_status == chip_erase)     //only under a/a mux mode
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
        status_reg = status_reg | 8'hA8;  //SR indicates "Erase failure due to Vpp Error"
      end
      else begin
        write_status = write_command;
        read_status = read_status_reg;
        running_status = ChipErase_Busy;
        status_reg = status_reg & 8'h00;  //SR=8'b0000_0000
        CE_Start_Time = $time;
        $display("%t, Notes: Chip Erase Operation begin!\n",$realtime);
        for(i=0;i<`MEMORY_SIZE;i=i+1)
        begin
          memory[i] = {`DATA_BITS_NUM{1'b1}};
          if(memory[i] & 8'hff !== 8'hff)
          begin
            status_reg = status_reg | 8'hA0;
            $display("%t, Warning: Chip Erase is failed because address[%h] cell failure!\n",$realtime,i);
          end
        end
      //----------------------------------//chip erase operation complete
        complete_flag <= #(`ChipErase_Time*1000) ~complete_flag;
      end
    end
    else begin
      $display("%t, Warning: Chip Erase Command Sequence is invalid!\n",$realtime);
      write_status = write_command;
      read_status = read_status_reg;
      status_reg = status_reg | 8'hB0;    //SR indicates "Command Sequence Error"
    end
  end
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

end
endtask
//=============================================================================

endmodule     