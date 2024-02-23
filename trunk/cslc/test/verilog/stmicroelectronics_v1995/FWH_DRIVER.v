/*****************************************************************************

  M50FLW040 FWH Interface Access Driver for Verification

*******************************************************************************

  Driver Version : 1.1

  Author : Xue-Feng Hu

*******************************************************************************

  Driver Version History:
-------------------------------------------------------------------------------
  :1.0 Jul. 2004  First Version Driver.
-------------------------------------------------------------------------------
  :1.1 Sep. 2004  Add "vccaux" Output Pin.
                  Add "four features" test. (Testing 16~19)
                      
-------------------------------------------------------------------------------

******************************************************************************/

`timescale 1ns/1ns
//-----------------------------------------------------------------------------
`define LPCBUS_DIM          4
`define FWHBUS_DIM          4
`define DATA_BITS_NUM       8
`define MEM_ADDR_BITS       19
//-----------------------------------------------------------------------------
`define CLK_CYCLE           clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; #8
`define CLK_HI              15
`define CLK_LO              15
`define VCCLKO_MIN          1.8
`define VCCLKO_MAX          2.3
`define VCC_MIN             3.0
`define VCC_MAX             3.6
`define VPP1_MIN            3.0
`define VPP1_MAX            3.6
`define VPPH_MIN            11.4
`define VPPH_MAX            12.6
//-----------------------------------------------------------------------------
`define Time_Program        200e3   //200us
`define Time_SectorErase_f  4e9     //4s, Vpp=Vpph
`define Time_SectorErase_n  5e9     //5s, Vpp=Vcc
`define Time_BlockErase_f   8e9     //8s, Vpp=Vpph
`define Time_BlockErase_n   10e9    //10s, Vpp=Vcc
`define Time_ProgSusp       5000
`define Time_EraseSusp      30000
/*
`define Time_ChipErase      10e9    //10s, Vpp=Vpph */

//=============================================================================
//=========          M50FLW040 Stimuli by FWH/LPC Interface          ==========
//=============================================================================
module M50FLW040_FL_DRV(vpph, vpp, vcc, vss, vccaux, ic, clk, init_n, rp_n, wp_n, tbl_n, fwh4_lframe, gpi, id, fwh_lad, rfu);
 
//--------------------------------
//Signal IO Attribute
//--------------------------------
  inout  [3:0] fwh_lad;
  output [3:0] id;       //id[3] is shared with rfu[5]
  output [4:0] rfu;
  output [4:0] gpi;
  output vcc, vss, vpp, vpph, vccaux;
  output clk, ic, wp_n, tbl_n, fwh4_lframe, rp_n, init_n;

//--------------------------------
//Signal and variable definition
//--------------------------------
  reg clk, ic, wp_n, tbl_n, fwh4_lframe, rp_n, init_n;
  reg [3:0] id, id1, fwh_lad_out;
  reg [4:0] gpi;
    
  real vcc_real,vpp_real;

  assign vss = 1'b0;
  /**************************************************************************************
  vpp = 1, vpph = 0: 0V <= vpp_real < VPPH_MIN
  vpp = 1, vpph = 1: VPPH_MIN <= vpp_real <= VPPH_MAX
  vpp = 0, vpph = 1: vpp_real > VPPH_MAX
  vpp = 0, vpph = 0: vpp_real < 0V
  **************************************************************************************/
  assign vpp     = (((vpp_real >=  0) && (vpp_real <= `VPPH_MAX)) ? 1'b1 : 1'b0);
  assign vpph    = ((vpp_real >= `VPPH_MIN) ? 1'b1 : 1'b0);

  /**************************************************************************************
  vcc = 0, vccaux = 0: vcc_real < VCCLKO_MAX
  vcc = 0, vccaux = 1: VCCLKO_MIN <= vcc_real < VCC_MIN
  vcc = 1, vccaux = 0: VCC_MIN <= vcc_real <= VCC_MAX 
  vcc = 1, vccaux = 1: vcc_real > VCC_MAX
  **************************************************************************************/
  assign vccaux  = (((vcc_real >= `VCCLKO_MAX && vcc_real < `VCC_MIN)||(vcc_real > `VCC_MAX))? 1'b1 : 1'b0);
  assign vcc     = ((vcc_real >= `VCC_MIN) ? 1'b1 : 1'b0);
  
  assign fwh_lad = fwh_lad_out;
  
//===============================================
  initial begin
    ic = 1'b0;          //FWH and LPC
    $display("=======================================================================");
    $display("        Testing 0: Checking the level of Supply Voltage.");
    $display("=======================================================================");
    #10 vcc_real = 0.0;
    #10 vcc_real = 2.5;
    #10 vcc_real = 5.0;
    #10 vpp_real = -3.0;
    #10 vpp_real = 15.0;
    #10 vcc_real = 3.0; vpp_real = 12.0;
    #10
    clk = 1'b1;
    init_n = 1'b1;
    rp_n = 1'b0;
    #100
    #30000
    rp_n = 1'b1;
    wp_n = 1'b1;        //the protection of the block 0~6 is determined by the lock register
    tbl_n = 1'b1;       //the protection of the top block is determined by the lock register
    //id = 4'b0000;
    id1 = 4'b0000;
    fwh_lad_out = 4'hz;
    fwh4_lframe = 1'b1;
//-----------------------------------------------
    #30000;

    $display("=======================================================================");
    $display("        Testing 1: Lock Register Lock Down Feature Testing.");
    $display("=======================================================================");
    #10 fwh_readreg_op(`MEM_ADDR_BITS'h00002);
    #10 fwh_writereg_op(`MEM_ADDR_BITS'h00002,8'h00); //Reset Block 0 lock reg
    #10 fwh_readreg_op(`MEM_ADDR_BITS'h00002);
    #10 fwh_writereg_op(`MEM_ADDR_BITS'h00002,8'h02); //Lock down Block 0 lock reg
    #10 fwh_readreg_op(`MEM_ADDR_BITS'h00002);
    #10 fwh_writereg_op(`MEM_ADDR_BITS'h00002,8'h05);
    #10 fwh_readreg_op(`MEM_ADDR_BITS'h00002);
    rp_n = 1'b0;
    #100
    #30000
    rp_n = 1'b1;  //reset
    #30000
    #10 fwh_writereg_op(`MEM_ADDR_BITS'h00002,8'h00);
    #10 fwh_readreg_op(`MEM_ADDR_BITS'h00002);

    $display("========================================================");
    $display("        Testing 2: Read GPI Register.");
    $display("========================================================");
    gpi = 5'b00000;
    #100; fwh_readreg_op(19'h40100);
    gpi = 5'b10101;
    #100; fwh_readreg_op(19'h40100);
    gpi = 5'b01010;
    #100; fwh_readreg_op(19'h40100);
    gpi = 5'b11111;
    #100; fwh_readreg_op(19'h40100);

    $display("========================================================");
    $display("        Testing 3: Read Manufacturer Code Register.");
    $display("========================================================");
    #100; fwh_readreg_op(19'h40000);

    $display("========================================================");
    $display("        Testing 4: Read Electronic Signature Code.");
    $display("========================================================");
    #100 Fwh_ElectronicSignatureCmd;
    #100 fwh_readmem_op(19'h00000,4'h0);
    #100 fwh_readmem_op(19'h00001,4'h0);

    $display("========================================================================");
    $display("        Testing 5: BLOCK0~6 WRITE PROTECT AND WRITE LOCK.");
    $display("========================================================================");
    #100; wp_n = 1'b0;  //write protect enable
    #100; fwh_writereg_op(19'h00002,8'h00); //reset block0 lock reg
    #100; Fwh_ProgramCmd(19'h00000,8'h55);  //program to block 0
    #`Time_Program;
    #100; Fwh_ReadMemoryArrayCmd;           //read data
    #100; fwh_readmem_op(19'h00000,4'h0);

    #100 Fwh_ClearStatusRegisterCmd;

    #100; wp_n = 1'b1;  //write protect disable
    #100; fwh_writereg_op(19'h00002,8'h01); //set wr lock bit in block0 lock reg
    #100; Fwh_ProgramCmd(19'h00000,8'h55);  //program to block 0
    #`Time_Program;
    #100; Fwh_ReadMemoryArrayCmd;           //read data
    #100; fwh_readmem_op(19'h00000,4'h0);

    #100 Fwh_ClearStatusRegisterCmd;

    #100; wp_n = 1'b1;  //write protect disable
    #100; fwh_writereg_op(19'h00002,8'h00); //reset block0 lock reg
    #100; Fwh_ProgramCmd(19'h00000,8'h55);  //program to block 0
    #`Time_Program;
    #100; Fwh_ReadMemoryArrayCmd;           //read data
    #100; fwh_readmem_op(19'h00000,4'h0);

    $display("===========================================================================");
    $display("        Testing 6: TOP BLOCK WRITE PROTECT AND WRITE LOCK.");
    $display("===========================================================================");
    #100; tbl_n = 1'b0;  //write protect enable
    #100; fwh_writereg_op(19'h70002,8'h00); //reset block7 lock reg
    #100; Fwh_ProgramCmd(19'h70000,8'h55);  //program to block 7
    #`Time_Program;
    #100; Fwh_ReadMemoryArrayCmd;           //read data
    #100; fwh_readmem_op(19'h70000,4'h0);

    #100 Fwh_ClearStatusRegisterCmd;

    #100; tbl_n = 1'b1;  //write protect disable
    #100; fwh_writereg_op(19'h70002,8'h01); //set wr lock bit in block7 lock reg
    #100; Fwh_ProgramCmd(19'h70000,8'h55);  //program to block 7
    #`Time_Program;
    #100; Fwh_ReadMemoryArrayCmd;           //read data
    #100; fwh_readmem_op(19'h70000,4'h0);

    #100 Fwh_ClearStatusRegisterCmd;

    #100; wp_n = 1'b1;  //write protect disable
    #100; fwh_writereg_op(19'h70002,8'h00); //reset block7 lock reg
    #100; Fwh_ProgramCmd(19'h70000,8'h55);  //program to block 7
    #`Time_Program;
    #100; Fwh_ReadMemoryArrayCmd;           //read data
    #100; fwh_readmem_op(19'h70000,4'h0);

    $display("===========================================================================");
    $display("        Testing 7: READ LOCK BY SETTING BLOCK LOCK REGISTER.");
    $display("===========================================================================");
    #100; fwh_writereg_op(19'h70002,8'h04); //set rd lock bit in block7 lock reg
    #100; fwh_readmem_op(19'h70000,4'h0);
    #100; fwh_writereg_op(19'h70002,8'h00); //reset read-lock bit
    #100; fwh_readmem_op(19'h70000,4'h0);

    $display("===================================================");
    $display("        Testing 8: PROGRAMMING VALIDATION.");
    $display("===================================================");
    #100 wp_n = 1'b1; tbl_n = 1'b1;
    #100 fwh_writereg_op(19'h00002,8'h00);  //reset write-lock bit
    #100 fwh_writereg_op(19'h10002,8'h00);  //reset write-lock bit
    #100 fwh_writereg_op(19'h20002,8'h00);  //reset write-lock bit
    #100 fwh_writereg_op(19'h30002,8'h00);  //reset write-lock bit
    #100 fwh_writereg_op(19'h40002,8'h00);  //reset write-lock bit
    #100 fwh_writereg_op(19'h50002,8'h00);  //reset write-lock bit
    #100 fwh_writereg_op(19'h60002,8'h00);  //reset write-lock bit
    #100 fwh_writereg_op(19'h70002,8'h00);  //reset write-lock bit

    #100 Fwh_ProgramCmd(19'h0ffff,8'h55);
    #`Time_Program;
    #100 Fwh_ProgramCmd(19'h20000,8'h55);
    #`Time_Program;

    #100 Fwh_ProgramCmd(19'h10001,8'h11);
    #`Time_Program;
    #100 Fwh_DoubleProgramCmd(19'h10002,8'h22,8'h33);
    #`Time_Program;
    #100 Fwh_QuadProgramCmd(19'h10004,8'h44,8'h55,8'h66,8'h77);
    #`Time_Program;
    #100 Fwh_ProgramCmd(19'h10001,8'haa);   //can not change 0 to 1
    #`Time_Program;

    #100 Fwh_ClearStatusRegisterCmd;
    
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h10000,4'h0);
    #100 fwh_readmem_op(19'h10000,4'h1);
    #100 fwh_readmem_op(19'h10000,4'h2);
    #100 fwh_readmem_op(19'h10000,4'h4);
    #100 fwh_readmem_op(19'h10000,4'h7);
    #100 fwh_readmem_op(19'h0ffff,4'h0);
    #100 fwh_readmem_op(19'h20000,4'h0);

    $display("======================================================");
    $display("        Testing 9: BLOCK ERASE VALIDATION.");
    $display("======================================================");
    #100 Fwh_BlockEraseCmd(19'h10000);
    #`Time_BlockErase_n;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h10000,4'h4);
    #100 fwh_readmem_op(19'h0ffff,4'h0);
    #100 fwh_readmem_op(19'h20000,4'h0);

    $display("======================================================");
    $display("        Testing 10: SECTOR ERASE VALIDATION.");
    $display("======================================================");
    #100 Fwh_ProgramCmd(19'h07000,8'h77);
    #`Time_Program;
    #100 Fwh_ProgramCmd(19'h07fff,8'h77);
    #`Time_Program;
    #100 Fwh_ProgramCmd(19'h06fff,8'h66);
    #`Time_Program;
    #100 Fwh_ProgramCmd(19'h08000,8'h88);
    #`Time_Program;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h06fff,4'h0);
    #100 fwh_readmem_op(19'h07000,4'h0);
    #100 fwh_readmem_op(19'h07fff,4'h0);
    #100 fwh_readmem_op(19'h08000,4'h0);
    #100 Fwh_SectorEraseCmd(19'h07000);
    #`Time_SectorErase_n;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h06fff,4'h0);
    #100 fwh_readmem_op(19'h07000,4'h0);
    #100 fwh_readmem_op(19'h07fff,4'h0);
    #100 fwh_readmem_op(19'h08000,4'h0);

    $display("=========================================================");
    $display("        Testing 11: PROGRAM SUSPEND/RESUME VALIDATION.");
    $display("=========================================================");
    #100 fwh_readmem_op(19'h6ffff,4'h2);
    #100 Fwh_QuadProgramCmd(19'h6ffff,8'h56,8'h78,8'h9a,8'hbc);
    #5000 Fwh_PESuspendCmd;
    #`Time_ProgSusp
    #100 Fwh_PEResumeCmd;
    #`Time_Program;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h6ffff,4'h2);

    $display("===========================================================");
    $display("        Testing 12: BLOCK ERASE SUSPEND/RESUME VALIDATION.");
    $display("===========================================================");
    #100 Fwh_BlockEraseCmd(19'h60000);
    #5000 Fwh_PESuspendCmd;
    #`Time_EraseSusp
    #100 Fwh_PEResumeCmd;
    #`Time_BlockErase_n;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h6ffff,4'h2);

    $display("=============================================================");
    $display("        Testing 13: SECTOR ERASE SUSPEND/RESUME VALIDATION.");
    $display("=============================================================");
    #100 Fwh_QuadProgramCmd(19'h00fff,8'h56,8'h78,8'h9a,8'hbc);
    #`Time_Program;
    #100 Fwh_ProgramCmd(19'h01000,8'hde);
    #100 fwh_readmem_op(19'h00000,4'h0);  //read sr
    #`Time_Program;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h00fff,4'h2);
    #100 fwh_readmem_op(19'h01000,4'h0);
    #100 Fwh_SectorEraseCmd(19'h00ffe);
    #5000 Fwh_PESuspendCmd;
    #`Time_EraseSusp
    #100 Fwh_PEResumeCmd;
    #`Time_SectorErase_n;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h00fff,4'h2);
    #100 fwh_readmem_op(19'h01000,4'h0);

    $display("======================================================================");
    $display("        Testing 14: PROGRAM DURING BLOCK ERASE SUSPEND VALIDATION.");
    $display("======================================================================");
    #100 Fwh_BlockEraseCmd(19'h00ffe);    //Block 0 Erase
    #`Time_BlockErase_n;
    #100 Fwh_ProgramCmd(19'h00000,8'haa); //Program "aa" to address 00000h
    #`Time_Program;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h00000,4'h0);  //Read data from address 00000
    #100 fwh_readmem_op(19'h4ffff,4'h2);  //Read data from address 4fffc~4ffff
    #100 Fwh_BlockEraseCmd(19'h00ffe);    //Block 0 Erase
    #5000 Fwh_PESuspendCmd;               //Block Erase Suspend
    #`Time_EraseSusp;
    #100 Fwh_QuadProgramCmd(19'h4ffff,8'h56,8'h78,8'h9a,8'hbc); //Program data to address 4fffc~4ffff
    #`Time_Program;
    #100 Fwh_PEResumeCmd;                 //Block Erase Resume
    #`Time_BlockErase_n;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h00000,4'h0);  //Read data from address 00000
    #100 fwh_readmem_op(19'h4ffff,4'h2);  //Read data from address 4fffc~4ffff

    $display("======================================================================");
    $display("        Testing 15: PROGRAM DURING SECTOR ERASE SUSPEND VALIDATION.");
    $display("======================================================================");
    #100 Fwh_BlockEraseCmd(19'h00ffe);    //Block 0 Erase
    #`Time_BlockErase_n;
    #100 Fwh_ProgramCmd(19'h00000,8'hbb); //Program "aa" to address 00000h
    #`Time_Program;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h00000,4'h0);  //Read data from address 00000
    #100 fwh_readmem_op(19'h3ffff,4'h2);  //Read data from address 3fffc~3ffff
    #100 Fwh_SectorEraseCmd(19'h00f11);   //Sectror 0 Erase
    #5000 Fwh_PESuspendCmd;               //Block Erase Suspend
    #`Time_EraseSusp;
    #100 Fwh_QuadProgramCmd(19'h3ffff,8'h11,8'h22,8'h33,8'h44); //Program data to address 4fffc~4ffff
    #100 fwh_readmem_op(19'h00000,4'h0);  //read sr
    #5000 Fwh_PESuspendCmd;
    #`Time_ProgSusp
    #100 Fwh_PEResumeCmd;
    #`Time_Program;
    #100 Fwh_PEResumeCmd;                 //Block Erase Resume
    #`Time_SectorErase_n;
    #100 Fwh_ReadMemoryArrayCmd;
    #100 fwh_readmem_op(19'h00000,4'h0);  //Read data from address 00000
    #100 fwh_readmem_op(19'h3ffff,4'h2);  //Read data from address 4fffc~4ffff

    $display("===========================================================================================");
    $display("        Testing 16: Programming on the erasing block during a Block Erase Suspend.");
    $display("===========================================================================================");
    #10 fwh_writereg_op(`MEM_ADDR_BITS'h20002,8'h00);
    #100 Fwh_BlockEraseCmd(`MEM_ADDR_BITS'h20ffe);    //Block 2 Erase
    #5000 Fwh_PESuspendCmd;                           //Block Erase Suspend
    #`Time_EraseSusp;
    //#100 fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h40);
    //#200 fwh_writemem4_op(address,data1,data2,data3,data4);
    #100 Fwh_QuadProgramCmd(`MEM_ADDR_BITS'h20ffe,8'h56,8'h78,8'h9a,8'hbc);
    #`Time_Program;
    #100 Fwh_PEResumeCmd;                 //Block Erase Resume
    #`Time_BlockErase_n;

    $display("===========================================================================================");
    $display("        Testing 17: Programming on the erasing sector during a Sector Erase Suspend.");
    $display("===========================================================================================");
    #100 Fwh_SectorEraseCmd(`MEM_ADDR_BITS'h00f11);   //Sectror 0 Erase
    #5000 Fwh_PESuspendCmd;                           //Sector Erase Suspend
    #`Time_EraseSusp;
    //#100 fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h40);
    //#200 fwh_writemem4_op(address,data1,data2,data3,data4);
    #100 Fwh_QuadProgramCmd(`MEM_ADDR_BITS'h00f11,8'h11,8'h22,8'h33,8'h44);
    #`Time_Program;
    #100 Fwh_PEResumeCmd;                 //Sector Erase Resume
    #`Time_SectorErase_n;

    $display("============================================================================================================");
    $display("        Testing 18: After Suspend Command, No Command(except Read SR.) are acceptable until PG/ES CTR has paused.");
    $display("============================================================================================================");
    #10; fwh_writereg_op(`MEM_ADDR_BITS'h60002,8'h00);
    #100 Fwh_BlockEraseCmd(`MEM_ADDR_BITS'h60000);    //Block 6
    #5000 Fwh_PESuspendCmd;
    #100 Fwh_ReadMemoryArrayCmd;                      //read data
    #100 Fwh_ElectronicSignatureCmd;
    #100 Fwh_ReadStatusRegisterCmd;
    #100 fwh_readmem_op(`MEM_ADDR_BITS'h00000,4'h0);
    #100 Fwh_QuadProgramCmd(`MEM_ADDR_BITS'h00f11,8'h11,8'h22,8'h33,8'h44);
    #100 Fwh_BlockEraseCmd(`MEM_ADDR_BITS'h60000);
    #100 Fwh_SectorEraseCmd(`MEM_ADDR_BITS'h00f11);
    #100 Fwh_ClearStatusRegisterCmd;
    #100 Fwh_PESuspendCmd;
    #100 Fwh_PEResumeCmd;
    //-----------------------
    #`Time_EraseSusp
    #100 Fwh_ReadStatusRegisterCmd;
    #100 fwh_readmem_op(`MEM_ADDR_BITS'h00000,4'h0);
    #100 Fwh_ElectronicSignatureCmd;
    #100 fwh_readmem_op(`MEM_ADDR_BITS'h00000,4'h0);
    #`Time_BlockErase_n
    #100 Fwh_PEResumeCmd;
    #`Time_BlockErase_n;

    $display("=======================================================================================================");
    $display("        Testing 19: No Erase Command is acceptable when another suspend erase operation is on going.");
    $display("=======================================================================================================");
    #10; fwh_writereg_op(`MEM_ADDR_BITS'h60002,8'h00);
    #100 Fwh_BlockEraseCmd(`MEM_ADDR_BITS'h60000);
    #5000 Fwh_PESuspendCmd;
    #`Time_EraseSusp
    fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h20);     //block erase
    #200 fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'hD0);
    #`Time_BlockErase_n
    #100 Fwh_PEResumeCmd;
    #`Time_BlockErase_n;
    //-------------------------------------------
    #100 Fwh_SectorEraseCmd(`MEM_ADDR_BITS'h00ffe);
    #5000 Fwh_PESuspendCmd;
    #`Time_EraseSusp
    fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h32);     //sector erase
    #200 fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'hD0);
    #`Time_BlockErase_n
    #100 Fwh_PEResumeCmd;
    #`Time_SectorErase_n;

    #200 $finish;
  end

  //=======================================================
  //Firmwire Hub Interface Bus Operation and Commands
  //=======================================================
  task fwh_readmem_op;
    input [`MEM_ADDR_BITS-1:0] address;
    input [3:0] msize;
    integer i,n,nibble;
    reg [3:0] msize;
    reg [`DATA_BITS_NUM-1:0] rd_data;
    reg [`MEM_ADDR_BITS-1:0] address;
    begin
       fwh_lad_out = 4'b1101; fwh4_lframe = 1'b0;
      `CLK_CYCLE; fwh_lad_out = id1[3:0]; fwh4_lframe = 1'b1;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {1'h1, address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-3]};
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-4:`MEM_ADDR_BITS-7];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS- 8:`MEM_ADDR_BITS-11];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-12:`MEM_ADDR_BITS-15];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-16:`MEM_ADDR_BITS-19];
      `CLK_CYCLE; fwh_lad_out = msize;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE;
      case(msize)
        4'b0000: n = 2;
        4'b0001: n = 4;
        4'b0010: n = 8;
        4'b0100: n = 32;
        4'b0111: n = 256;
      endcase
      nibble = 0;
      for(i=0;i<n;i=i+1)
      begin
        fwh_lad_out = {`FWHBUS_DIM{1'bz}};
        case(nibble)
          0: begin
              clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[3:0] = fwh_lad; #8;
              address = U_M50FLW040.mem_address;
             end
          1: begin
               clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[7:4] = fwh_lad; #8;
              if(U_M50FLW040.read_status == 2'b10)
                $display("%t, Read Memory Array, address = [%h], data = [%h]",$realtime,address,rd_data);
              if(U_M50FLW040.read_status == 2'b01)
                $display("%t, Read Electronic Signature, address = [%h],data = [%h]",$realtime,address,rd_data);
              if(U_M50FLW040.read_status == 2'b00)
                $display("%t, Read Status Register, SR = [%h]",$realtime,rd_data);
             end
        endcase
        nibble = nibble + 1;
        if(nibble >= 2) nibble = 0;
      end
      fwh_lad_out = {`FWHBUS_DIM{1'bz}}; `CLK_CYCLE;
      fwh_lad_out = {`FWHBUS_DIM{1'bz}}; `CLK_CYCLE; `CLK_CYCLE;
      $display("%t, Note: FWH Bus Memory Read Operation is Completed!\n",$realtime);
    end
  endtask
  
  //=======================================================
  task fwh_readreg_op;
    input [`MEM_ADDR_BITS-1:0] reg_addr;
    integer i;
    reg [7:0] rd_data;
    begin
       fwh_lad_out = 4'b1101; fwh4_lframe = 1'b0;
      `CLK_CYCLE; fwh_lad_out = id1[3:0]; fwh4_lframe = 1'b1;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = 4'b1011;
      `CLK_CYCLE; fwh_lad_out = {1'h1, reg_addr[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-3]};
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-4:`MEM_ADDR_BITS-7];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS- 8:`MEM_ADDR_BITS-11];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-12:`MEM_ADDR_BITS-15];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-16:`MEM_ADDR_BITS-19];
      `CLK_CYCLE; fwh_lad_out = 4'b0000;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE;
      fwh_lad_out = {`FWHBUS_DIM{1'bz}}; clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[3:0] = fwh_lad; #8;
      fwh_lad_out = {`FWHBUS_DIM{1'bz}}; clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[7:4] = fwh_lad; #8;
      $display("%t, Read Configuration Register, CR[%h] = [%h].",$realtime, {1'b1,reg_addr}, rd_data);
      fwh_lad_out = {`FWHBUS_DIM{1'bz}}; `CLK_CYCLE;
      fwh_lad_out = {`FWHBUS_DIM{1'bz}}; `CLK_CYCLE; `CLK_CYCLE;
      $display("%t, Note: FWH Bus Configuration Register Read Operation is Completed!\n",$realtime);
    end
  endtask

  //=======================================================
  task fwh_writemem1_op;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data;
    begin
       fwh_lad_out = 4'b1110; fwh4_lframe = 1'b0;
      `CLK_CYCLE; fwh_lad_out = id1[3:0]; fwh4_lframe = 1'b1;
      `CLK_CYCLE; fwh_lad_out = 4'b1111; 
      `CLK_CYCLE; fwh_lad_out = 4'b1111; 
      `CLK_CYCLE; fwh_lad_out = {1'b1,address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-3]};
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-4:`MEM_ADDR_BITS-7];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-8:`MEM_ADDR_BITS-11];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-12:`MEM_ADDR_BITS-15];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-16:`MEM_ADDR_BITS-19];
      `CLK_CYCLE; fwh_lad_out = 4'b0000;
      `CLK_CYCLE; fwh_lad_out = data[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
      `CLK_CYCLE; fwh_lad_out = data[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; `CLK_CYCLE;
    end
  endtask
  
  //=======================================================
  task fwh_writemem2_op;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data1,data2;
    begin
       fwh_lad_out = 4'b1110; fwh4_lframe = 1'b0;
      `CLK_CYCLE; fwh_lad_out = id1[3:0]; fwh4_lframe = 1'b1;
      `CLK_CYCLE; fwh_lad_out = 4'b1111; 
      `CLK_CYCLE; fwh_lad_out = 4'b1111; 
      `CLK_CYCLE; fwh_lad_out = {1'b1,address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-3]};
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-4:`MEM_ADDR_BITS-7];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-8:`MEM_ADDR_BITS-11];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-12:`MEM_ADDR_BITS-15];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-16:`MEM_ADDR_BITS-19];
      `CLK_CYCLE; fwh_lad_out = 4'b0001;
      `CLK_CYCLE; fwh_lad_out = data1[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
      `CLK_CYCLE; fwh_lad_out = data1[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
      `CLK_CYCLE; fwh_lad_out = data2[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
      `CLK_CYCLE; fwh_lad_out = data2[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; `CLK_CYCLE;
    end
  endtask
  
  //=======================================================
  task fwh_writemem4_op;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data1,data2,data3,data4;
    begin
       fwh_lad_out = 4'b1110; fwh4_lframe = 1'b0;
      `CLK_CYCLE; fwh_lad_out = id1[3:0]; fwh4_lframe = 1'b1;
      `CLK_CYCLE; fwh_lad_out = 4'b1111; 
      `CLK_CYCLE; fwh_lad_out = 4'b1111; 
      `CLK_CYCLE; fwh_lad_out = {1'b1,address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-3]};
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-4:`MEM_ADDR_BITS-7];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-8:`MEM_ADDR_BITS-11];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-12:`MEM_ADDR_BITS-15];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-16:`MEM_ADDR_BITS-19];
      `CLK_CYCLE; fwh_lad_out = 4'b0010;
      `CLK_CYCLE; fwh_lad_out = data1[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
      `CLK_CYCLE; fwh_lad_out = data1[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
      `CLK_CYCLE; fwh_lad_out = data2[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
      `CLK_CYCLE; fwh_lad_out = data2[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
      `CLK_CYCLE; fwh_lad_out = data3[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
      `CLK_CYCLE; fwh_lad_out = data3[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
      `CLK_CYCLE; fwh_lad_out = data4[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
      `CLK_CYCLE; fwh_lad_out = data4[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; `CLK_CYCLE;
    end
  endtask
  
  //=======================================================
  task fwh_writereg_op;
    input [`MEM_ADDR_BITS:0] reg_addr;
    input [`DATA_BITS_NUM-1:0] data;
    begin
       fwh_lad_out = 4'b1110; fwh4_lframe = 1'b0;
      `CLK_CYCLE; fwh_lad_out = id1[3:0]; fwh4_lframe = 1'b1;
      `CLK_CYCLE; fwh_lad_out = 4'b1111; 
      `CLK_CYCLE; fwh_lad_out = 4'b1011; 
      `CLK_CYCLE; fwh_lad_out = {1'b1,reg_addr[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-3]};
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-4:`MEM_ADDR_BITS-7];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-8:`MEM_ADDR_BITS-11];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-12:`MEM_ADDR_BITS-15];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-16:`MEM_ADDR_BITS-19];
      `CLK_CYCLE; fwh_lad_out = 4'b0000;
      `CLK_CYCLE; fwh_lad_out = data[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
      `CLK_CYCLE; fwh_lad_out = data[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`FWHBUS_DIM{1'bz}};
      `CLK_CYCLE; `CLK_CYCLE;
    end
  endtask
  
  //=======================================================
  //Firmware Hub Interface Command
  //=======================================================
  //-----------------------------------1
  task Fwh_ReadMemoryArrayCmd;
    begin
      fwh_writemem1_op(19'h7FFFF,8'hFF);
    end
  endtask
  //-----------------------------------2
  task Fwh_ReadStatusRegisterCmd;
    begin
      fwh_writemem1_op(19'h7FFFF,8'h70);
    end
  endtask
  //-----------------------------------3
  task Fwh_ElectronicSignatureCmd;
    begin //Command Data: 90H or 98H
      fwh_writemem1_op(19'h7FFFF,8'h90);
    end
  endtask
  //-----------------------------------4
  task Fwh_ProgramCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data;
    begin //Command Data: 40H or 10H
      fwh_writemem1_op(19'h7FFFF,8'h40);
      #200 fwh_writemem1_op(address,data);
    end
  endtask
  //-----------------------------------4(1)
  task Fwh_DoubleProgramCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data1,data2;
    begin //Command Data: 40H or 10H
      fwh_writemem1_op(19'h7FFFF,8'h40);
      #200 fwh_writemem2_op(address,data1,data2);
    end
  endtask
  //-----------------------------------4(2)
  task Fwh_QuadProgramCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data1,data2,data3,data4;
    begin //Command Data: 40H or 10H
      fwh_writemem1_op(19'h7FFFF,8'h40);
      #200 fwh_writemem4_op(address,data1,data2,data3,data4);
    end
  endtask
  //-----------------------------------5
  task Fwh_BlockEraseCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    begin
      fwh_writemem1_op(19'h7FFFF,8'h20);
      #200 fwh_writemem1_op(address,8'hD0);
    end
  endtask
  //-----------------------------------6
  task Fwh_SectorEraseCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    begin
      fwh_writemem1_op(19'h7FFFF,8'h32);
      #200 fwh_writemem1_op(address,8'hD0);
    end
  endtask
  //-----------------------------------7
  task Fwh_ClearStatusRegisterCmd;
    begin
      fwh_writemem1_op(19'h7FFFF,8'h50);
    end
  endtask
  //-----------------------------------8
  task Fwh_PESuspendCmd;
    begin
      fwh_writemem1_op(19'h7FFFF,8'hB0);
    end
  endtask  
  //-----------------------------------9
  task Fwh_PEResumeCmd;
    begin
      fwh_writemem1_op(19'h7FFFF,8'hD0);
    end
  endtask
  //=======================================================
/*  
  //=======================================================
  //Low Pin Count Interface Bus Operation
  //=======================================================
  task lpc_readmem_op;
    input [`MEM_ADDR_BITS-1:0] address;
    reg [7:0] rd_data;
    begin
       fwh_lad_out = 4'b0000; fwh4_lframe = 1'b0;
      `CLK_CYCLE; fwh_lad_out = 4'b0100; fwh4_lframe = 1'b1; 
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {2'b11,~id[2:1]};//A22 = 1, A[21:19] = ~ID[2:0]
      `CLK_CYCLE; fwh_lad_out = {~id[0],address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-3]}; 
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-4:`MEM_ADDR_BITS-7];	
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-8:`MEM_ADDR_BITS-11];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-12:`MEM_ADDR_BITS-15];	
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-16:`MEM_ADDR_BITS-19];
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE;
      fwh_lad_out = {`LPCBUS_DIM{1'bz}}; clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[3:0] = fwh_lad; #8;
      fwh_lad_out = {`LPCBUS_DIM{1'bz}}; clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[7:4] = fwh_lad; #8;
      if(U_M50FLW040.read_status == 2'b10)
        $display("%t, Read Memory Array, address = [%h],data = [%h]",$realtime,address,rd_data);
      if(U_M50FLW040.read_status == 2'b01)
        $display("%t, Read Electronic Signature, address = [%h],data = [%h]",$realtime,address,rd_data);
      if(U_M50FLW040.read_status == 2'b00)
        $display("%t, Read Status Register, SR = [%h]",$realtime,rd_data);
      fwh_lad_out = {`LPCBUS_DIM{1'bz}}; `CLK_CYCLE;
      fwh_lad_out = {`LPCBUS_DIM{1'bz}}; `CLK_CYCLE; `CLK_CYCLE;
      $display("%t, Note: LPC Bus Memory Read Operation is Completed!\n",$realtime);
    end
  endtask

  //=======================================================
  task lpc_readreg_op;
    input [`MEM_ADDR_BITS-1:0] reg_addr;
    reg [7:0] rd_data;
    begin
       fwh_lad_out = 4'b0000; fwh4_lframe = 1'b0;
      `CLK_CYCLE; fwh_lad_out = 4'b0100; fwh4_lframe = 1'b1; 
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {2'b10,~id[2:1]};//A22 = 1, A[21:19] = ~ID[2:0]
      `CLK_CYCLE; fwh_lad_out = {~id[0],reg_addr[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-3]}; 
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-4:`MEM_ADDR_BITS-7];	
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-8:`MEM_ADDR_BITS-11];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-12:`MEM_ADDR_BITS-15];	
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-16:`MEM_ADDR_BITS-19];
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE;
      fwh_lad_out = {`LPCBUS_DIM{1'bz}}; clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[3:0] = fwh_lad; #8;
      fwh_lad_out = {`LPCBUS_DIM{1'bz}}; clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[7:4] = fwh_lad; #8;
      $display("%t, Read Configuration Register, CR[%h] = [%h]",$realtime,reg_addr,rd_data);
      fwh_lad_out = {`LPCBUS_DIM{1'bz}}; `CLK_CYCLE;
      fwh_lad_out = {`LPCBUS_DIM{1'bz}}; `CLK_CYCLE; `CLK_CYCLE;
      $display("%t, Note: LPC Bus Configuration Register Read Operation is Completed!\n",$realtime);
    end
  endtask
  
  //=======================================================
  task lpc_writemem_op;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data;
    begin
       fwh_lad_out = 4'b0000; fwh4_lframe = 1'b0;
      `CLK_CYCLE; fwh_lad_out = 4'b0110; fwh4_lframe = 1'b1;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {2'b11,~id[2:1]}; //A22 = 1, A[21:19] = ~ID[2:0]
      `CLK_CYCLE; fwh_lad_out = {~id[0], address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-3]};
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-4:`MEM_ADDR_BITS-7];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-8:`MEM_ADDR_BITS-11];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-12:`MEM_ADDR_BITS-15];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-16:`MEM_ADDR_BITS-19];
      `CLK_CYCLE; fwh_lad_out = data[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
      `CLK_CYCLE; fwh_lad_out = data[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; `CLK_CYCLE;
    end
  endtask
  
  //=======================================================
  task lpc_writereg_op;
    input [`MEM_ADDR_BITS-1:0] reg_addr;
    input [`DATA_BITS_NUM-1:0] data;
    begin
       fwh_lad_out = 4'b0000; fwh4_lframe = 1'b0;
      `CLK_CYCLE; fwh_lad_out = 4'b0110; fwh4_lframe = 1'b1;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {2'b10,~id[2:1]}; //A22 = 0, A[21:19] = ~ID[2:0]
      `CLK_CYCLE; fwh_lad_out = {~id[0], reg_addr[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-3]};
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-4:`MEM_ADDR_BITS-7];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-8:`MEM_ADDR_BITS-11];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-12:`MEM_ADDR_BITS-15];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-16:`MEM_ADDR_BITS-19];
      `CLK_CYCLE; fwh_lad_out = data[`DATA_BITS_NUM-5:`DATA_BITS_NUM-8];
      `CLK_CYCLE; fwh_lad_out = data[`DATA_BITS_NUM-1:`DATA_BITS_NUM-4];
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; `CLK_CYCLE;
    end
  endtask
  
  //=======================================================
  //Low Pin Count Interface Commands
  //=======================================================
  //-----------------------------------1
  task Lpc_ReadMemoryArrayCmd;
    begin
      lpc_writemem_op(19'h7FFFF,8'hFF);
    end
  endtask
  //-----------------------------------2
  task Lpc_ReadStatusRegisterCmd;
    begin
      lpc_writemem_op(19'h7FFFF,8'h70);
    end
  endtask
  //-----------------------------------3
  task Lpc_ElectronicSignatureCmd;
    begin //Command Data = 90H or 98H
      lpc_writemem_op(19'h7FFFF,8'h90);
    end
  endtask
  //-----------------------------------4
  task Lpc_ProgramCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data;
    begin //Command Data = 40H or 10H
      lpc_writemem_op(19'h7FFFF,8'h40);
      #200 lpc_writemem_op(address,data);
    end
  endtask
  //-----------------------------------5
  task Lpc_BlockEraseCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    begin
      lpc_writemem_op(19'h7FFFF,8'h20);
      #200 lpc_writemem_op(address,8'hD0);
    end
  endtask
  //-----------------------------------6
  task Lpc_SectorEraseCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    begin
      lpc_writemem_op(19'h7FFFF,8'h32);
      #200 lpc_writemem_op(address,8'hD0);
    end
  endtask
  //-----------------------------------7
  task Lpc_ClearStatusRegisterCmd;
    begin
      lpc_writemem_op(19'h7FFFF,8'h50);
    end
  endtask
  //-----------------------------------8
  task Lpc_PESuspendCmd;
    begin
      lpc_writemem_op(19'h7FFFF,8'hB0);
    end
  endtask  
  //-----------------------------------9
  task Lpc_PEResumeCmd;
    begin
      lpc_writemem_op(19'h7FFFF,8'hD0);
    end
  endtask  
  //=======================================================
*/
endmodule

//=========================================================
//
module test_bench;

  wire vpph, vccaux;
  wire vpp, vcc, vss;
  wire ic, clk, init_n, rp_n, wp_n, tbl_n, fwh4_lframe;
  wire [4:0] gpi;
  wire [3:0] id;
  wire [3:0] fwh_lad;
  wire [4:0] rfu;
  
  M50FLW040_FL_DRV U_M50FLW040DRV
                       (
                        .vpph(vpph),
                        .vpp(vpp),
                        .vcc(vcc),
                        .vss(vss),
                        .vccaux(vccaux),
                        .ic(ic),
                        .clk(clk),
                        .init_n(init_n),
                        .rp_n(rp_n),
                        .wp_n(wp_n),
                        .tbl_n(tbl_n),
                        .fwh4_lframe(fwh4_lframe),
                        .gpi(gpi),
                        .id(id),
                        .fwh_lad(fwh_lad),
                        .rfu(rfu)
                       );
                        
    M50FLW040 U_M50FLW040
                       (
                        .VPPH(vpph),
                        .VPP(vpp),
                        .VCC(vcc),
                        .VSS(vss),
                        .VCCAUX(vccaux),
                        .IC(ic),
                        .CLK(clk),
                        .INIT_N(init_n),
                        .RP_N(rp_n),
                        .WP_N(wp_n),
                        .TBL_N(tbl_n),
                        .FWH4_LFRM(fwh4_lframe),
                        .GPI(gpi),
                        .ID(id),
                        .FWH_LAD(fwh_lad),
                        .RFU(rfu)
                       );

endmodule