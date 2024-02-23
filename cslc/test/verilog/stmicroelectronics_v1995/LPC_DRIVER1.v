/*****************************************************************************

  M50FLW080A/B LPC Interface Access Driver for Verification

*******************************************************************************

  Driver Version : 1.1

  Author : Xue-Feng Hu

*******************************************************************************

  Driver Version History:
-------------------------------------------------------------------------------
  :1.0 Jul. 2004  First Version Driver.
-------------------------------------------------------------------------------
  :1.1 Sep. 2004  Add "vccaux" Output Pin.
                  Add "four features" test. (Testing 17~20)
                      
-------------------------------------------------------------------------------

******************************************************************************/

`timescale 1ns/1ns

`define M50FLW080A
//`define M50FLW080B

//-----------------------------------------------------------------------------
`define LPCBUS_DIM          4
`define FWHBUS_DIM          4
`define DATA_BITS_NUM       8
`define MEM_ADDR_BITS       20
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
//=========          M50FLW080 Stimuli by FWH/LPC Interface          ==========
//=============================================================================
module M50FLW080_FL_DRV(vpph, vpp, vcc, vss, vccaux, ic, clk, init_n, rp_n, wp_n, tbl_n, fwh4_lframe, gpi, id, fwh_lad);
 
//--------------------------------
//Signal IO Attribute
//--------------------------------
  inout  [3:0] fwh_lad;
  output [3:0] id;       //id[3] is shared with rfu[5]
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
    #10 lpc_readreg_op(`MEM_ADDR_BITS'h00002);
    #10 lpc_writereg_op(`MEM_ADDR_BITS'h00002,8'h00); //Reset sector0 lock reg
    #10 lpc_readreg_op(`MEM_ADDR_BITS'h00002);
    #10 lpc_writereg_op(`MEM_ADDR_BITS'h00002,8'h02); //Lock down sector0 lock reg
    #10 lpc_readreg_op(`MEM_ADDR_BITS'h00002);
    #10 lpc_writereg_op(`MEM_ADDR_BITS'h00002,8'h05);
    #10 lpc_readreg_op(`MEM_ADDR_BITS'h00002);
    rp_n = 1'b0;
    #100
    #30000
    rp_n = 1'b1;  //reset
    #30000
    #10 lpc_writereg_op(`MEM_ADDR_BITS'h00002,8'h00);
    #10 lpc_readreg_op(`MEM_ADDR_BITS'h00002);

    $display("========================================================");
    $display("        Testing 2: Read GPI Register.");
    $display("========================================================");
    gpi = 5'b00000;
    #10; lpc_writereg_op(`MEM_ADDR_BITS'hC0100,8'h00);
    #10; lpc_readreg_op(`MEM_ADDR_BITS'hC0100);
    gpi = 5'b10101;
    #10; lpc_readreg_op(`MEM_ADDR_BITS'hC0100);
    gpi = 5'b01010;
    #10; lpc_readreg_op(`MEM_ADDR_BITS'hC0100);
    gpi = 5'b11111;
    #10; lpc_readreg_op(`MEM_ADDR_BITS'hC0100);

    $display("========================================================");
    $display("        Testing 3: Read Manufacturer Code Register.");
    $display("========================================================");
    #10; lpc_writereg_op(`MEM_ADDR_BITS'hC0000,8'h00);
    #10; lpc_readreg_op(`MEM_ADDR_BITS'hC0000);

    $display("========================================================");
    $display("        Testing 4: Read Electronic Signature Code.");
    $display("========================================================");
    #100 Lpc_ElectronicSignatureCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00000);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00001);
    rp_n = 1'b0;
    init_n = 1'b1;
    #100
    #30000
    rp_n = 1'b1;
    #30000;

    $display("========================================================================");
    $display("        Testing 5: SECTOR0~15 WRITE,WRITE PROTECT AND WRITE LOCK.");
    $display("========================================================================");
    #100; wp_n = 1'b0;  //write protect enable
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h00002,8'h00); //reset sector0 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h00000,8'h55);  //program to sector 0
    #`Time_Program;
    #100; Lpc_ReadMemoryArrayCmd;                       //read data
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h00000);
    #100; Lpc_ClearStatusRegisterCmd;
    #100; wp_n = 1'b1;  //write protect disable
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h00002,8'h01); //set wr lock bit in sector 0 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h00000,8'h00);  //program to sector 0
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h01002,8'h00); //set wr lock bit in sector 1 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h01000,8'h01);  //program to sector 1
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h02002,8'h01); //set wr lock bit in sector 2 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h02000,8'h02);  //program to sector 2
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h03002,8'h00); //set wr lock bit in sector 3 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h03000,8'h03);  //program to sector 3
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h04002,8'h01); //set wr lock bit in sector 4 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h04000,8'h04);  //program to sector 4
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h05002,8'h00); //set wr lock bit in sector 5 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h05000,8'h05);  //program to sector 5
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h06002,8'h01); //set wr lock bit in sector 6 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h06000,8'h06);  //program to sector 6
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h07002,8'h00); //set wr lock bit in sector 7 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h07000,8'h07);  //program to sector 7
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h08002,8'h01); //set wr lock bit in sector 8 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h08000,8'h08);  //program to sector 8
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h09002,8'h00); //set wr lock bit in sector 9 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h09000,8'h09);  //program to sector 9
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0a002,8'h01); //set wr lock bit in sector 10 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h0a000,8'h10);  //program to sector 10
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0b002,8'h00); //set wr lock bit in sector 11 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h0b000,8'h11);  //program to sector 11
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0c002,8'h01); //set wr lock bit in sector 12 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h0c000,8'h12);  //program to sector 12
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0d002,8'h00); //set wr lock bit in sector 13 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h0d000,8'h13);  //program to sector 13
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0e002,8'h01); //set wr lock bit in sector 14 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h0e000,8'h14);  //program to sector 14
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0f002,8'h00); //set wr lock bit in sector 15 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h0f000,8'h15);  //program to sector 15
    #`Time_Program;
    #100; Lpc_ReadMemoryArrayCmd;                       //read data
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h00000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h01000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h02000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h03000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h04000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h05000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h06000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h07000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h08000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h09000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h0a000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h0b000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h0c000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h0d000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h0e000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h0f000);

`ifdef M50FLW080A
    $display("===========================================================================");
    $display("        Testing 6: TYPE A SECTOR16~31 WRITE,WRITE PROTECT AND WRITE LOCK.");
    $display("===========================================================================");
    #100; wp_n = 1'b0;  //write protect enable
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he0002,8'h00); //reset sector16 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he0000,8'h55);  //program to sector 16
    #`Time_Program;
    #100; Lpc_ReadMemoryArrayCmd;                       //read data
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he0000);
    #100; Lpc_ClearStatusRegisterCmd;
    #100; wp_n = 1'b1;  //write protect disable
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he0002,8'h01); //set wr lock bit in sector 16 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he0000,8'h16);  //program to sector 16
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he1002,8'h00); //set wr lock bit in sector 17 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he1000,8'h17);  //program to sector 17
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he2002,8'h01); //set wr lock bit in sector 18 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he2000,8'h18);  //program to sector 18
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he3002,8'h00); //set wr lock bit in sector 19 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he3000,8'h19);  //program to sector 19
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he4002,8'h01); //set wr lock bit in sector 20 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he4000,8'h20);  //program to sector 20
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he5002,8'h00); //set wr lock bit in sector 21 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he5000,8'h21);  //program to sector 21
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he6002,8'h01); //set wr lock bit in sector 22 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he6000,8'h22);  //program to sector 22
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he7002,8'h00); //set wr lock bit in sector 23 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he7000,8'h23);  //program to sector 23
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he8002,8'h01); //set wr lock bit in sector 24 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he8000,8'h24);  //program to sector 24
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'he9002,8'h00); //set wr lock bit in sector 25 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'he9000,8'h25);  //program to sector 25
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hea002,8'h01); //set wr lock bit in sector 26 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hea000,8'h26);  //program to sector 26
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'heb002,8'h00); //set wr lock bit in sector 27 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'heb000,8'h27);  //program to sector 27
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hec002,8'h01); //set wr lock bit in sector 28 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hec000,8'h28);  //program to sector 28
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hed002,8'h00); //set wr lock bit in sector 29 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hed000,8'h29);  //program to sector 29
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hee002,8'h01); //set wr lock bit in sector 30 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hee000,8'h30);  //program to sector 30
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hef002,8'h00); //set wr lock bit in sector 31 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hef000,8'h31);  //program to sector 31
    #`Time_Program;
    #100; Lpc_ReadMemoryArrayCmd;                       //read data
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he0000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he1000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he2000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he3000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he4000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he5000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he6000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he7000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he8000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'he9000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hea000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'heb000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hec000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hed000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hee000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hef000);
`endif

`ifdef M50FLW080B
    $display("===========================================================================");
    $display("        Testing 6: TYPE B SECTOR16~31 WRITE,WRITE PROTECT AND WRITE LOCK.");
    $display("===========================================================================");
    #100; wp_n = 1'b0;  //write protect enable
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h10002,8'h00); //reset sector16 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h10000,8'h55);  //program to sector 16
    #`Time_Program;
    #100; Lpc_ReadMemoryArrayCmd;                       //read data
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10000);
    #100; Lpc_ClearStatusRegisterCmd;
    #100; wp_n = 1'b1;  //write protect disable
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h10002,8'h01); //set wr lock bit in sector 16 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h10000,8'h16);  //program to sector 16
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h11002,8'h00); //set wr lock bit in sector 17 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h11000,8'h17);  //program to sector 17
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h12002,8'h01); //set wr lock bit in sector 18 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h12000,8'h18);  //program to sector 18
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h13002,8'h00); //set wr lock bit in sector 19 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h13000,8'h19);  //program to sector 19
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h14002,8'h01); //set wr lock bit in sector 20 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h14000,8'h20);  //program to sector 20
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h15002,8'h00); //set wr lock bit in sector 21 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h15000,8'h21);  //program to sector 21
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h16002,8'h01); //set wr lock bit in sector 22 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h16000,8'h22);  //program to sector 22
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h17002,8'h00); //set wr lock bit in sector 23 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h17000,8'h23);  //program to sector 23
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h18002,8'h01); //set wr lock bit in sector 24 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h18000,8'h24);  //program to sector 24
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h19002,8'h00); //set wr lock bit in sector 25 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h19000,8'h25);  //program to sector 25
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h1a002,8'h01); //set wr lock bit in sector 26 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h1a000,8'h26);  //program to sector 26
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h1b002,8'h00); //set wr lock bit in sector 27 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h1b000,8'h27);  //program to sector 27
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h1c002,8'h01); //set wr lock bit in sector 28 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h1c000,8'h28);  //program to sector 28
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h1d002,8'h00); //set wr lock bit in sector 29 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h1d000,8'h29);  //program to sector 29
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h1e002,8'h01); //set wr lock bit in sector 30 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h1e000,8'h30);  //program to sector 30
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h1f002,8'h00); //set wr lock bit in sector 31 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'h1f000,8'h31);  //program to sector 31
    #`Time_Program;
    #100; Lpc_ReadMemoryArrayCmd;                       //read data
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h11000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h12000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h13000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h14000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h15000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h16000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h17000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h18000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h19000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h1a000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h1b000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h1c000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h1d000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h1e000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h1f000);
`endif

    $display("===========================================================================");
    $display("        Testing 7: SECTOR32~47 WRITE,WRITE PROTECT AND WRITE LOCK.");
    $display("===========================================================================");
    #100; tbl_n = 1'b0;  //write protect enable
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf0002,8'h00); //reset sector 32 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf0000,8'h55);  //program to sector 32
    #`Time_Program;
    #100; Lpc_ReadMemoryArrayCmd;                       //read data
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf0000);
    #100; Lpc_ClearStatusRegisterCmd;
    #100; tbl_n = 1'b1;  //write protect disable
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf0002,8'h01); //set wr lock bit in sector 32 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf0000,8'h32);  //program to sector 32
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf1002,8'h00); //set wr lock bit in sector 33 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf1000,8'h33);  //program to sector 33
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf2002,8'h01); //set wr lock bit in sector 34 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf2000,8'h34);  //program to sector 34
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf3002,8'h00); //set wr lock bit in sector 35 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf3000,8'h35);  //program to sector 35
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf4002,8'h01); //set wr lock bit in sector 36 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf4000,8'h36);  //program to sector 36
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf5002,8'h00); //set wr lock bit in sector 37 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf5000,8'h37);  //program to sector 37
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf6002,8'h01); //set wr lock bit in sector 38 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf6000,8'h38);  //program to sector 38
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf7002,8'h00); //set wr lock bit in sector 39 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf7000,8'h39);  //program to sector 39
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf8002,8'h01); //set wr lock bit in sector 40 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf8000,8'h40);  //program to sector 40
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf9002,8'h00); //set wr lock bit in sector 41 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hf9000,8'h41);  //program to sector 41
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hfa002,8'h01); //set wr lock bit in sector 42 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hfa000,8'h42);  //program to sector 42
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hfb002,8'h00); //set wr lock bit in sector 43 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hfb000,8'h43);  //program to sector 43
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hfc002,8'h01); //set wr lock bit in sector 44 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hfc000,8'h44);  //program to sector 44
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hfd002,8'h00); //set wr lock bit in sector 45 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hfd000,8'h45);  //program to sector 45
    #`Time_Program;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hfe002,8'h01); //set wr lock bit in sector 46 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hfe000,8'h46);  //program to sector 46
    #`Time_Program;
    #100; Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hff002,8'h00); //set wr lock bit in sector 47 lock reg
    #100; Lpc_ProgramCmd(`MEM_ADDR_BITS'hff000,8'h47);  //program to sector 47
    #`Time_Program;
    #100; Lpc_ReadMemoryArrayCmd;                       //read data
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf0000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf1000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf2000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf3000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf4000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf5000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf6000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf7000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf8000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf9000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hfa000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hfb000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hfc000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hfd000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hfe000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hff000);

    $display("===========================================================================");
    $display("        Testing 8: READ LOCK BY SETTING BLOCK LOCK REGISTER.");
    $display("===========================================================================");
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf0002,8'h04); //set rd lock bit in sector32 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf1002,8'h04); //set rd lock bit in sector33 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf2002,8'h04); //set rd lock bit in sector34 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf3002,8'h04); //set rd lock bit in sector35 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf4002,8'h04); //set rd lock bit in sector36 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf5002,8'h04); //set rd lock bit in sector37 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf6002,8'h04); //set rd lock bit in sector38 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf7002,8'h04); //set rd lock bit in sector39 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf8002,8'h04); //set rd lock bit in sector40 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hf9002,8'h04); //set rd lock bit in sector41 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hfa002,8'h04); //set rd lock bit in sector42 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hfb002,8'h04); //set rd lock bit in sector43 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hfc002,8'h04); //set rd lock bit in sector44 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hfd002,8'h04); //set rd lock bit in sector45 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hfe002,8'h04); //set rd lock bit in sector46 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'hff002,8'h04); //set rd lock bit in sector47 lock reg
    #100; Lpc_ReadMemoryArrayCmd;                       //read data
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf0000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf1000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf2000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf3000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf4000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf5000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf6000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf7000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf8000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hf9000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hfa000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hfb000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hfc000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hfd000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hfe000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'hff000);

    $display("===================================================");
    $display("        Testing 9: PROGRAMMING VALIDATION.");
    $display("===================================================");
    #100 wp_n = 1'b1; tbl_n = 1'b1;
    #100 lpc_writereg_op(`MEM_ADDR_BITS'h20002,8'h00);  //reset write-lock bit
    #100 lpc_writereg_op(`MEM_ADDR_BITS'h30002,8'h00);  //reset write-lock bit
    #100 lpc_writereg_op(`MEM_ADDR_BITS'h40002,8'h00);  //reset write-lock bit
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h2ffff,8'h55);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h40000,8'h55);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h30001,8'h11);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h30002,8'h22);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h30003,8'h33);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h30004,8'h44);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h30005,8'h55);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h30006,8'h66);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h30007,8'h77);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h30001,8'haa);   //can not change 0 to 1
    #`Time_Program;
    #100 Lpc_ClearStatusRegisterCmd;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h30000);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h30001);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h30002);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h30003);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h30004);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h30005);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h30006);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h30007);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h2ffff);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h40000);

    $display("======================================================");
    $display("        Testing 10: BLOCK ERASE VALIDATION.");
    $display("======================================================");
    #100; Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h30000);
    #`Time_BlockErase_n;
    #100; Lpc_ReadMemoryArrayCmd;
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h30000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h30001);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h30002);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h30003);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h30004);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h30005);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h30006);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h30007);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h2ffff);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h40000);
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h00002,8'h01); //reset rd lock bit in sector0 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h01002,8'h00); //reset rd lock bit in sector1 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h02002,8'h00); //reset rd lock bit in sector2 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h03002,8'h00); //reset rd lock bit in sector3 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h04002,8'h00); //reset rd lock bit in sector4 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h05002,8'h00); //reset rd lock bit in sector5 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h06002,8'h00); //reset rd lock bit in sector6 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h07002,8'h00); //reset rd lock bit in sector7 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h08002,8'h00); //reset rd lock bit in sector8 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h09002,8'h00); //reset rd lock bit in sector9 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0a002,8'h00); //reset rd lock bit in sector10 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0b002,8'h00); //reset rd lock bit in sector11 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0c002,8'h00); //reset rd lock bit in sector12 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0d002,8'h00); //reset rd lock bit in sector13 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0e002,8'h00); //reset rd lock bit in sector14 lock reg
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h0f002,8'h00); //reset rd lock bit in sector15 lock reg
    #100; Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h00000);
    #`Time_BlockErase_n;
    #100 Lpc_ClearStatusRegisterCmd;
    #100; lpc_writereg_op(`MEM_ADDR_BITS'h00002,8'h00); //reset rd lock bit in sector47 lock reg
    #100; Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h00000);
    #`Time_BlockErase_n;
    #100; Lpc_ReadMemoryArrayCmd;
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h01000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h03000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h05000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10000);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10001);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10002);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10003);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10004);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10005);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10006);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10007);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h10008);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h2ffff);
    #100; lpc_readmem_op(`MEM_ADDR_BITS'h40000);

    $display("======================================================");
    $display("        Testing 11: SECTOR ERASE VALIDATION.");
    $display("======================================================");
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h07000,8'h77);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h07fff,8'h77);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h06fff,8'h66);
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h08000,8'h88);
    #`Time_Program;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h06fff);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h07000);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h07fff);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h08000);
    #100 lpc_writereg_op(`MEM_ADDR_BITS'h07002,8'h01);
    #100 Lpc_SectorEraseCmd(`MEM_ADDR_BITS'h07000);
    #`Time_SectorErase_n;
    #100 Lpc_ClearStatusRegisterCmd;
    #100 lpc_writereg_op(`MEM_ADDR_BITS'h06002,8'h00);
    #100 lpc_writereg_op(`MEM_ADDR_BITS'h07002,8'h00);
    #100 Lpc_SectorEraseCmd(`MEM_ADDR_BITS'h07000);
    #`Time_SectorErase_n;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h06fff);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h07000);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h07fff);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h08000);

    $display("=========================================================");
    $display("        Testing 12: PROGRAM SUSPEND/RESUME VALIDATION.");
    $display("=========================================================");
    #100 lpc_writereg_op(`MEM_ADDR_BITS'h60002,8'h00);  //reset write-lock bit
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6fffc);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6fffd);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6fffe);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6ffff);
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h6fffc,8'h56); //Program "56" to address 6fffch
    #5000 Lpc_PESuspendCmd;               //Program Suspend
    #`Time_ProgSusp
    #100 Lpc_PEResumeCmd;                 //Program Resume
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h6fffd,8'h78); //Program "78" to address 6fffdh
    #5000 Lpc_PESuspendCmd;               //Program Suspend
    #`Time_ProgSusp
    #100 Lpc_PEResumeCmd;                 //Program Resume
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h6fffe,8'h9a); //Program "9a" to address 6fffeh
    #5000 Lpc_PESuspendCmd;               //Program Suspend
    #`Time_ProgSusp
    #100 Lpc_PEResumeCmd;                 //Program Resume
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h6ffff,8'hbc); //Program "bc" to address 6ffffh
    #5000 Lpc_PESuspendCmd;               //Program Suspend
    #`Time_ProgSusp
    #100 Lpc_PEResumeCmd;                 //Program Resume
    #`Time_Program;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6fffc);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6fffd);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6fffe);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6ffff);

    $display("===========================================================");
    $display("        Testing 13: BLOCK ERASE SUSPEND/RESUME VALIDATION.");
    $display("===========================================================");
    #100 Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h60000);
    #5000 Lpc_PESuspendCmd;
    #`Time_EraseSusp
    #100 Lpc_PEResumeCmd;
    #`Time_BlockErase_n;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6fffc);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6fffd);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6fffe);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h6ffff);

    $display("=============================================================");
    $display("        Testing 14: SECTOR ERASE SUSPEND/RESUME VALIDATION.");
    $display("=============================================================");
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h00ffc,8'h56); //Program "56" to address 00ffch
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h00ffd,8'h78); //Program "78" to address 00ffdh
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h00ffe,8'h9a); //Program "9a" to address 00ffeh
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h00fff,8'hbc); //Program "bc" to address 00fffh
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h01000,8'hde);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00000);       //read sr
    #`Time_Program;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00ffc);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00ffd);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00ffe);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00fff);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h01000);
    #100 Lpc_SectorEraseCmd(`MEM_ADDR_BITS'h00ffe);
    #5000 Lpc_PESuspendCmd;
    #`Time_EraseSusp
    #100 Lpc_PEResumeCmd;
    #`Time_SectorErase_n;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00ffc);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00ffd);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00ffe);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00fff);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h01000);

    $display("======================================================================");
    $display("        Testing 15: PROGRAM DURING BLOCK ERASE SUSPEND VALIDATION.");
    $display("======================================================================");
    #100 Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h00ffe);    //Block 0 Erase
    #`Time_BlockErase_n;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h00000,8'haa); //Program "aa" to address 00000h
    #`Time_Program;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00000);       //Read data from address 00000
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h4fffc);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h4fffd);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h4fffe);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h4ffff);       //Read data from address 4fffc~4ffff
    #100 Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h00ffe);    //Block 0 Erase
    #5000 Lpc_PESuspendCmd;               //Block Erase Suspend
    #`Time_EraseSusp;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h4fffc,8'h56); //Program "56" to address 4fffch
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h4fffd,8'h78); //Program "78" to address 4fffdh
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h4fffe,8'h9a); //Program "9a" to address 4fffeh
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h4ffff,8'hbc); //Program "bc" to address 4ffffh
    #`Time_Program;
    #100 Lpc_PEResumeCmd;                 //Block Erase Resume
    #`Time_BlockErase_n;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00000);       //Read data from address 00000
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h4fffc);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h4fffd);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h4fffe);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h4ffff);       //Read data from address 4fffc~4ffff

    $display("======================================================================");
    $display("        Testing 16: PROGRAM DURING SECTOR ERASE SUSPEND VALIDATION.");
    $display("======================================================================");
    #100 Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h00ffe);    //Block 0 Erase
    #`Time_BlockErase_n;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h00000,8'hbb); //Program "bb" to address 00000h
    #`Time_Program;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00000);       //Read data from address 00000
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h3fffc);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h3fffd);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h3fffe);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h3ffff);       //Read data from address 3fffc~3ffff
    #100 Lpc_SectorEraseCmd(`MEM_ADDR_BITS'h00f11);   //Sectror 0 Erase
    #5000 Lpc_PESuspendCmd;               //Block Erase Suspend
    #`Time_EraseSusp;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h3fffc,8'h11); //Program "11" to address 3fffch
    #5000 Lpc_PESuspendCmd;               //Program Suspend
    #`Time_ProgSusp
    #100 Lpc_PEResumeCmd;                 //Program Resume
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h3fffd,8'h22); //Program "22" to address 3fffdh
    #5000 Lpc_PESuspendCmd;               //Program Suspend
    #`Time_ProgSusp
    #100 Lpc_PEResumeCmd;                 //Program Resume
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h3fffe,8'h33); //Program "33" to address 3fffeh
    #5000 Lpc_PESuspendCmd;               //Program Suspend
    #`Time_ProgSusp
    #100 Lpc_PEResumeCmd;                 //Program Resume
    #`Time_Program;
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h3ffff,8'h44); //Program "44" to address 3ffffh
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00000);       //read sr
    #5000 Lpc_PESuspendCmd;               //Program Suspend
    #`Time_ProgSusp
    #100 Lpc_PEResumeCmd;                 //Program Resume
    #`Time_Program;
    #100 Lpc_PEResumeCmd;                 //Block Erase Resume
    #`Time_SectorErase_n;
    #100 Lpc_ReadMemoryArrayCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00000);       //Read data from address 00000
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h3fffc);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h3fffd);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h3fffe);
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h3ffff);       //Read data from address 3fffc~3ffff

    $display("===========================================================================================");
    $display("        Testing 17: Programming on the erasing block during a Block Erase Suspend.");
    $display("===========================================================================================");
    #10 lpc_writereg_op(`MEM_ADDR_BITS'h20002,8'h00);
    #100 Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h20ffe);    //Block 2 Erase
    #5000 Lpc_PESuspendCmd;                           //Block Erase Suspend
    #`Time_EraseSusp;
    //#100 lpc_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h40);
    //#200 lpc_writemem4_op(address,data1,data2,data3,data4);
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h20ffe,8'h56);
    #`Time_Program;
    #100 Lpc_PEResumeCmd;                 //Block Erase Resume
    #`Time_BlockErase_n;

    $display("===========================================================================================");
    $display("        Testing 18: Programming on the erasing sector during a Sector Erase Suspend.");
    $display("===========================================================================================");
    #100 Lpc_SectorEraseCmd(`MEM_ADDR_BITS'h00f11);   //Sectror 0 Erase
    #5000 Lpc_PESuspendCmd;                           //Block Erase Suspend
    #`Time_EraseSusp;
    //#100 lpc_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h40);
    //#200 lpc_writemem4_op(address,data1,data2,data3,data4);
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h00f11,8'h11);
    #`Time_Program;
    #100 Lpc_PEResumeCmd;                 //Block Erase Resume
    #`Time_SectorErase_n;

    $display("============================================================================================================");
    $display("        Testing 19: After Suspend Command, No Command(except Read SR.) are acceptable until PG/ES CTR has paused.");
    $display("============================================================================================================");
    #10; lpc_writereg_op(`MEM_ADDR_BITS'h60002,8'h00);
    #100 Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h60000);
    #5000 Lpc_PESuspendCmd;
    #100 Lpc_ReadMemoryArrayCmd;                       //read data
    #100 Lpc_ElectronicSignatureCmd;
    #100 Lpc_ReadStatusRegisterCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00000);
    #100 Lpc_ProgramCmd(`MEM_ADDR_BITS'h00f11,8'h11);
    #100 Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h60000);
    #100 Lpc_SectorEraseCmd(`MEM_ADDR_BITS'h00f11);
    #100 Lpc_ClearStatusRegisterCmd;
    #100 Lpc_PESuspendCmd;
    #100 Lpc_PEResumeCmd;
    //-----------------------
    #`Time_EraseSusp
    #100 Lpc_ReadStatusRegisterCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00000);
    #100 Lpc_ElectronicSignatureCmd;
    #100 lpc_readmem_op(`MEM_ADDR_BITS'h00000);
    #`Time_BlockErase_n
    #100 Lpc_PEResumeCmd;
    #`Time_BlockErase_n;

    $display("=======================================================================================================");
    $display("        Testing 20: No Erase Command is acceptable when another suspend erase operation is on going.");
    $display("=======================================================================================================");
    #10; lpc_writereg_op(`MEM_ADDR_BITS'h60002,8'h00);
    #100 Lpc_BlockEraseCmd(`MEM_ADDR_BITS'h60000);
    #5000 Lpc_PESuspendCmd;
    #`Time_EraseSusp
    lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'h20);     //block erase
    #200 lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'hD0);
    #`Time_BlockErase_n
    #100 Lpc_PEResumeCmd;
    #`Time_BlockErase_n;
    //-------------------------------------------
    #100 Lpc_SectorEraseCmd(`MEM_ADDR_BITS'h00ffe);
    #5000 Lpc_PESuspendCmd;
    #`Time_EraseSusp
    lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'h32);     //sector erase
    #200 lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'hD0);
    #`Time_BlockErase_n
    #100 Lpc_PEResumeCmd;
    #`Time_SectorErase_n;

    #200 $finish;
  end
/*
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
      `CLK_CYCLE; fwh_lad_out = id[3:0]; fwh4_lframe = 1'b1;
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
              address = U_M50FLW080.mem_address;
             end
          1: begin
              clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[7:4] = fwh_lad; #8;
              if(U_M50FLW080.read_status == 2'b10)
                $display("%t, Read Memory Array, address = [%h], data = [%h]",$realtime,address,rd_data);
              if(U_M50FLW080.read_status == 2'b01)
                $display("%t, Read Electronic Signature, address = [%h],data = [%h]",$realtime,address,rd_data);
              if(U_M50FLW080.read_status == 2'b00)
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
      `CLK_CYCLE; fwh_lad_out = id[3:0]; fwh4_lframe = 1'b1;
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
      $display("%t, Read Configuration Register, CR[%h] = [%h].",$realtime, reg_addr, rd_data);
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
      `CLK_CYCLE; fwh_lad_out = id[3:0]; fwh4_lframe = 1'b1;
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
      `CLK_CYCLE; fwh_lad_out = id[3:0]; fwh4_lframe = 1'b1;
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
      `CLK_CYCLE; fwh_lad_out = id[3:0]; fwh4_lframe = 1'b1;
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
      `CLK_CYCLE; fwh_lad_out = id[3:0]; fwh4_lframe = 1'b1;
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
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'hFF);
    end
  endtask
  //-----------------------------------2
  task Fwh_ReadStatusRegisterCmd;
    begin
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h70);
    end
  endtask
  //-----------------------------------3
  task Fwh_ElectronicSignatureCmd;
    begin //Command Data: 90H or 98H
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h90);
    end
  endtask
  //-----------------------------------4
  task Fwh_ProgramCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data;
    begin //Command Data: 40H or 10H
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h40);
      #200 fwh_writemem1_op(address,data);
    end
  endtask
  //-----------------------------------4(1)
  task Fwh_DoubleProgramCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data1,data2;
    begin //Command Data: 40H or 10H
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h40);
      #200 fwh_writemem2_op(address,data1,data2);
    end
  endtask
  //-----------------------------------4(2)
  task Fwh_QuadProgramCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data1,data2,data3,data4;
    begin //Command Data: 40H or 10H
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h40);
      #200 fwh_writemem4_op(address,data1,data2,data3,data4);
    end
  endtask
  //-----------------------------------5
  task Fwh_BlockEraseCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    begin
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h20);
      #200 fwh_writemem1_op(address,8'hD0);
    end
  endtask
  //-----------------------------------6
  task Fwh_SectorEraseCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    begin
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h32);
      #200 fwh_writemem1_op(address,8'hD0);
    end
  endtask
  //-----------------------------------7
  task Fwh_ClearStatusRegisterCmd;
    begin
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'h50);
    end
  endtask
  //-----------------------------------8
  task Fwh_PESuspendCmd;
    begin
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'hB0);
    end
  endtask  
  //-----------------------------------9
  task Fwh_PEResumeCmd;
    begin
      fwh_writemem1_op(`MEM_ADDR_BITS'h7FFFF,8'hD0);
    end
  endtask
  //=======================================================
*/  
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
      `CLK_CYCLE; fwh_lad_out = {2'b11,~id1[3:2]};//A22 = 1, A[21:20] = ~ID[3:2]
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-4];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-5:`MEM_ADDR_BITS-8];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-9:`MEM_ADDR_BITS-12];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-13:`MEM_ADDR_BITS-16];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-17:`MEM_ADDR_BITS-20];
      `CLK_CYCLE; fwh_lad_out = 4'b1111;
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE; fwh_lad_out = {`LPCBUS_DIM{1'bz}};
      `CLK_CYCLE;
      fwh_lad_out = {`LPCBUS_DIM{1'bz}}; clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[3:0] = fwh_lad; #8;
      fwh_lad_out = {`LPCBUS_DIM{1'bz}}; clk = 1'b1; #8; clk = 1'b0; #`CLK_LO; clk = 1'b1; rd_data[7:4] = fwh_lad; #8;
      if(U_M50FLW080.read_status == 2'b10)
        $display("%t, Read Memory Array, address = [%h],data = [%h]",$realtime,address,rd_data);
      if(U_M50FLW080.read_status == 2'b01)
        $display("%t, Read Electronic Signature, address = [%h],data = [%h]",$realtime,address,rd_data);
      if(U_M50FLW080.read_status == 2'b00)
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
      `CLK_CYCLE; fwh_lad_out = {2'b10,~id1[3:2]};//A22 = 0, A[21:20] = ~ID[3:2]
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-4];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-5:`MEM_ADDR_BITS-8];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-9:`MEM_ADDR_BITS-12];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-13:`MEM_ADDR_BITS-16];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-17:`MEM_ADDR_BITS-20];
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
      `CLK_CYCLE; fwh_lad_out = {2'b11,~id1[3:2]};//A22 = 1, A[21:20] = ~ID[3:2]
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-4];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-5:`MEM_ADDR_BITS-8];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-9:`MEM_ADDR_BITS-12];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-13:`MEM_ADDR_BITS-16];
      `CLK_CYCLE; fwh_lad_out = address[`MEM_ADDR_BITS-17:`MEM_ADDR_BITS-20];
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
      `CLK_CYCLE; fwh_lad_out = {2'b10,~id1[3:2]};//A22 = 0, A[21:20] = ~ID[3:2]
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-4];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-5:`MEM_ADDR_BITS-8];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-9:`MEM_ADDR_BITS-12];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-13:`MEM_ADDR_BITS-16];
      `CLK_CYCLE; fwh_lad_out = reg_addr[`MEM_ADDR_BITS-17:`MEM_ADDR_BITS-20];
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
      lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'hFF);
    end
  endtask
  //-----------------------------------2
  task Lpc_ReadStatusRegisterCmd;
    begin
      lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'h70);
    end
  endtask
  //-----------------------------------3
  task Lpc_ElectronicSignatureCmd;
    begin //Command Data = 90H or 98H
      lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'h90);
    end
  endtask
  //-----------------------------------4
  task Lpc_ProgramCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    input [`DATA_BITS_NUM-1:0] data;
    begin //Command Data = 40H or 10H
      lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'h40);
      #200 lpc_writemem_op(address,data);
    end
  endtask
  //-----------------------------------5
  task Lpc_BlockEraseCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    begin
      lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'h20);
      #200 lpc_writemem_op(address,8'hD0);
    end
  endtask
  //-----------------------------------6
  task Lpc_SectorEraseCmd;
    input [`MEM_ADDR_BITS-1:0] address;
    begin
      lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'h32);
      #200 lpc_writemem_op(address,8'hD0);
    end
  endtask
  //-----------------------------------7
  task Lpc_ClearStatusRegisterCmd;
    begin
      lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'h50);
    end
  endtask
  //-----------------------------------8
  task Lpc_PESuspendCmd;
    begin
      lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'hB0);
    end
  endtask  
  //-----------------------------------9
  task Lpc_PEResumeCmd;
    begin
      lpc_writemem_op(`MEM_ADDR_BITS'h7FFFF,8'hD0);
    end
  endtask  
  //=======================================================

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
  
  M50FLW080_FL_DRV U_M50FLW080DRV
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
                        .fwh_lad(fwh_lad)
                       );
                        
    M50FLW080 U_M50FLW080
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
                        .RFU()
                       );

endmodule                                            