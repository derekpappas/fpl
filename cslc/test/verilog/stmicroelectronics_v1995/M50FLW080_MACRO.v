/******************************************************************************

  M50FLW080 Parameters Definitions

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

`define M50FLW080A                    //Memory Block and Sector Organizes to M50FLW080A
//`define M50FLW080B                    //Memory Block and Sector Organizes to M50FLW080B

//----------------------------------
`define TOPBLOCK            15        //top block is block 15
`define MEMORY_SIZE         1048576   //memory size 8M bits = 1M bytes
`define BLOCK_NUM           16        //divide into 16 uniform blocks
`define BLOCK_SIZE          65536     //64k bytes/each block
`define SECTOR_NUM          48        //3blocks,subdivided into 16 uniform sector,total 3*16
`define SECTOR_SIZE         4096      //4k bytes/each sector
//----------------------------------
`define IOC_NUM             4         //number of I/O communications
`define F_ID_NUM            4         //number of ID inputs in FWH mode
`define F_RFU_NUM           4         //number of RFU in FWH mode; Note: ID0,1(FWH mode) in LPC mode is RFU
`define GPI_NUM             5         //number of general purpose inputs
//----------------------------------
`define DATA_BITS_NUM       8
`define FWH_ADDR_BITS       28
`define LPC_ADDR_BITS       32
`define MEM_ADDR_BITS       20
`define REG_ADDR_BITS       28
`define REG_MEM_ENBIT       22
//----------------------------------  Address and Data Bits under A/A MUX Interface
`define AAMUX_DAT_BITS      8
`define AAMUX_ADD_BITS      11
//----------------------------------  Block Register Bit Definition
`define WRITE_LOCK          8'h01
`define LOCK_DOWN           8'h02
`define READ_LOCK           8'h04
//----------------------------------  Electronic Signature Code and Address
`define DEVICECODE_A        8'h80
`define DEVICECODE_B        8'h81
`define MANUFACTURECODE     8'h20
`define DEVICECODE_ADDR     20'h00001
`define MANUFCCODE_ADDR     20'h00000
                         
//=========================================================
//=====     FWH_LPC Interface AC Characteristics     ======
//=========================================================
`define tCYC                30
`define tCH                 11
`define tCL                 11
`define tCHQV_MIN           2
`define tCHQV_MAX           11
`define tCHQX_MIN           2
`define tCHQZ_MAX           28
`define tDVCH               7
`define tCHDX               0
`define tFLCH               10
`define tCHFH               5
//------------------------------------  Reset AC Characteristics
`define tPLPH               100
`define tPLRH               30000
`define tPHFL               30000
//------------------------------------  Program and Erase Times Definition
`define Program_Time        200e3       //200us
`define SectorErase_Time_f  4e9         //4s, Vpp=Vpph
`define SectorErase_Time_n  5e9         //5s, Vpp=Vcc
`define ChipErase_Time      5e9         //5S, Vpp=Vpph
`define BlockErase_Time_f   8e9         //8s, Vpp=Vpph
`define BlockErase_Time_n   10e9        //10s, Vpp=Vcc
`define ProgSusp_Time       5000        //5us
`define EraseSusp_Time      30000       //30us