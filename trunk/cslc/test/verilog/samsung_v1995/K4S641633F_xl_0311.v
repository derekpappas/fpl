/*=============================================================================
* Copyright(c) Samsung Electronics Co., 1997,1998. All rights reseved.
*
* Verilog Behavioral Model of Synchronous Mobile SDRAM
*
* Description : This is a synchrounous high data rate DRAM,
*               fabricated with SAMSUNG's high performance
*               CMOS technology.
*
* Revision No. : V4.5
* date         : Jan. 21. 2002
*
*===============================================================================*/

`define M64
`define MOB25V
`define LVTTL
`define NBANK4
`define X16

`ifdef MOB30V  //3.0V Mobile 
    `ifdef LVTTL //
	`ifdef S75 //
	    `define tCCmin  7.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.5			// clock minimun cycle time at cas latency=3
	    `define tCC2    9.5			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    15			// row to row delay(min)
	    `define tRCD    19			// ras to cas delay(min)
	    `define tRP     19			// row precharge time(min)	
	    `define tRASmin 45			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     65			// row cycle time(min)	
            `define tRDL    2			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   5.4			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   5.4			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S75
	`ifdef S1H //
	    `define tCCmin  9.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    9.5			// clock minimun cycle time at cas latency=3
	    `define tCC2    9.5			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    19			// row to row delay(min)
	    `define tRCD    19			// ras to cas delay(min)
	    `define tRP     19			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    2			// Last data in to row precharge : 2 clk
	    `define tCCD    9.5			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1H
	`ifdef S1L //
	    `define tCCmin  9.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    9.5			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     84			// row cycle time(min)	
            `define tRDL    2			// Last data in to row precharge : 2 clk
	    `define tCCD    9.5			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`endif //end of LVTTL
`endif //end of MOB30V

	
	
	
/*==================================================================
 * Copyright(c) Samsung Electronics Co., 1997,1998. All rights reseved.
 *
 * Verilog Behavioral Model of Synchronous DRAM 
 *
 * Device: -  16M SDRAM(2nd Gen., 3rd Gen., 4th Gen., 5th Gen.) 
 *	   -  64M SDRAM(2nd Gen., 3rd Gen., 4th Gen., 5th Gen.)
 *	   - 128M SDRAM(1st Gen., 2nd Gen.,)
 *	   - 256M SDRAM(2nd Gen.)
 *
 * Description : This is a synchrounous high data rate DRAM, 
 *		 fabricated with SAMSUNG's high performance  
 *               CMOS technology.                                
 *
 * Developer   : Jae-Ha Kim.
 *  		 CAE Team. Semiconductor R&D Centor. 
 *		 Semiconductor Division. Samsung Electronics Co.
 *
 * Revision    : Yong-Cheol Bae. ( e-mail: jjbae@samsung.co.kr )
 * 1.0~2.3	 DRAM2 Design. Semiconductor R&D Centor. 
 *		 Semiconductor Division. Samsung Electronics Co.
 * Revision    : Kyung-Woo Nam. ( e-mail: aboverim@samsung.co.kr )
 * 3.0~		 DRAM2 Design. Semiconductor R&D Centor. 
 *		 Semiconductor Division. Samsung Electronics Co.
 *==================================================================
 * Revision No. : V2.3 
 * date		: Aug. 20. 1997
 *		: Oct. 22. 1997
 *		: Jan. 15. 1998   - 16M 4Gen. & 64M 3Gen. spec update
 *		: Jun. 30. 1998   - 16M 4Gen. & 64M 3Gen. & 2Mx32 & 
 *		                  128M 1Gen. & 256M 2Gen. AC spec update
 *		: Oct. 08. 1998   - all-bank precharge revision
 *		                  bank note change: ba0=MSB,ba1=LSB @ 4banks
 *		: Nov. 18. 1998   - option set for verbose (e.g. +define+v )
 *		                  128M 2Gen. AC spec added. 
 *                                conformed model through verilog-XL 2.6.27 
 * Revision No. : V3.0 
 * date		: Apr. 07. 1999   - tRDL=2
 *			1. parameterize auto-precharge address : ADDR_AP
 *			2. divide auto-precharge process read/write
 *			3. divide precharge_flag_kill process normal/read_autopre/write_autopre
 *			4. generate wr_autoprecharge2 process excuting when tRDL=2
 *			5. modify same-bank-autoprecharge-disable function
 *			   (disable gapless, other bank interrupt case)
 * Revision No. : V3.1 
 * date         : May. 19. 1999  
 *			1. Add 16M 5th Gen. LVTTL(-10,-8,-8.7,-7,-6)
 *			2. Modify 2Mx32 5th Gen. tSAC value
 * Revision No. : V3.2 
 * date         : Jun. 11. 1999  
 *			1. Modify -A AC parameter(64M 5th, 128M 2th, 256M 2th)
 * Revision No. : V3.3 
 * date         : Jun. 24. 1999  
 *			1. After 64MSD3, auto_flagx signal is not used, 
 *			   let auto_flagx be not enabled to device which is after 64MSD3
 *			2. compile new versions 
 *			   verilog-xl : 2.7.17, NC-verilog : 2.1., VCS : 5.0.1a
 * Revision No. : V3.4 
 * date         : Jul. 12. 1999  
 *			1. To prevent roundoff error in AC parameter violation check procedure,
 *			   define MARGIN paramter. (MARGIN=0.1ns now)
 * Revision No. : V3.5 
 * date         : Sep. 28. 1999  
 *			1. Warning message 'tCCmax violation' is appeared during self refresh operation.
 *			   When self refresh or precharge-power down, clk can be don't care state. (can stay 'low' or 'high'-level)
 *                         Therefore tCCmax violation should not be checked during self refresh or prech. power down.
 * Revision No. : V3.6 
 * date         : Dec. 14. 1999  
 *			1. Make MODELSIM version and add partial REF./VREFi change function for NOKIA
 * Revision No. : V3.7 
 * date         : Jul. 11. 2000  
 *			1. Add dynamic memory allocation function using VERILOG-XL PLI,
 *			   then you must build verilog-XL excutable file containing PLI, and use +define+DYMEM option.
 * Revision No. : V3.8 
 * date         : Jul. 13. 2000  
 *			1. Add 128M SDRAM 3rd/4th Gen., 256M SDRAM 3rd Gen.
 * Revision No. : V3.9
 * date         : Feb. 5. 2001
 *                      1. remove CL2 parameter at -A, -7,... when violated, error messages are printed.
 * Revision No. : V4.0
 * date         : Jun. 11. 2001
 *                      1. 128M SDRAM X32 MCP (64M SDRAM X16 7th) parameter added
 * Revision No. : V4.1
 * date         : Jun. 23. 2001
 *                      1. 256M SDRAM 4th parameters are added
 * Revision No. : V4.2
 * date         : Jul. 31. 2001
 *                      1. because array of reg is not work at vcs 6.0, change array of reg to real variable (TRAS_PP, TPRE_P)
 * Revision No. : V4.3
 * date         : Aug. 09. 2001
 *                      1. There is an error that use "<" instead of ">", in tRASmax violation check routine.
 * Revision No. : V4.4
 * date         : Oct. 05. 2001
 *                      1. Add 128M Mobile SDRAM 5th Gen. (8Mx16, D-die)
 *                      2. Add 64M Mobile SDRAM 7th Gen. (2Mx32, F-die)
 * Revision No. : V4.5
 * date         : Nov. 23. 2001
 *                      1. Add mobile function (EMRS:PASR/TCSR/DSC, DPD:pin/cmd control)
 * Revision No. : V4.6
 * date         : Jan. 15. 2002
 *                      1. Add 512M SDRAM
 * Revision No. : V4.6
 * date         : Aug. 27. 2002
 *                      1. Add 128M X32 SDRAM
 * Revision No. : V4.7
 * date         : Nov. 25. 2003
 *                      1. Add 512M X32 SDRAM (1 CS DDP)
 *==================================================================
 */

`timescale    1ns / 10ps
 
`define K1	1024
`define M1	1048576
`define BYTE	8
    

`ifdef CS2
    `ifdef DPD_PIN
        module sdram_cs2(clk, csb, cke, ba, ad, rasb, casb, web, dqm, dqi, dpdb);
    `else
        module sdram_cs2(clk, csb, cke, ba, ad, rasb, casb, web, dqm, dqi);
    `endif
`else
    `ifdef DPD_PIN
        module sdram(clk, csb, cke, ba, ad, rasb, casb, web, dqm, dqi, dpdb);
    `else
        module sdram(clk, csb, cke, ba, ad, rasb, casb, web, dqm, dqi);	//default port name
    `endif
`endif

    `ifdef M16
	`define TBITS	16*`M1
	`define nBank	2
        `define ADDRTOP	10
	`define	ADDR_AP	10
        `ifdef G2
                `define M16G2_M641G
	`else
                `define M16G3_M64G2
                `define M64G3_M128_M256
        `endif
    `endif

    `ifdef M64
	`define TBITS		64*`M1
	`define	ADDR_AP	10
    	`ifdef NBANK2
      	    `define nBank	2	
	    `ifdef X32
	    	`define ADDRTOP	11
	    `else
            	`define ADDRTOP	12
	    `endif
    	`endif
        `ifdef NBANK4
     	    `define nBank	4	
	    `ifdef X32
            	`define ADDRTOP	10
	    `else
	    	`define ADDRTOP	11
	    `endif
    	`endif
                `define M64_M128_M256    // for prech_reg 
        `ifdef G1
                `define M16G2_M641G
        `else
        `ifdef G2
                `define M16G3_M64G2
        `else
                `define M16G4_M64G3
                `define M64G3_M128_M256
        `endif
        `endif
    `endif

    `ifdef M128
	`define TBITS	128*`M1
	`define nBank	4
        `ifdef NBANK4
     	    `define nBank	4	
	    `ifdef X32
            	`define ADDRTOP	10
	    `else
	    	`define ADDRTOP	11
	    `endif
    	`endif
	`define	ADDR_AP	10
        `define M64_M128_M256    // for prech_reg 
	`define M128_M256        // RFU, c_addr 10->11 
        `define M64G3_M128_M256  // from M64G3
        `define M16G4_M64G3
    `endif
    `ifdef M256
	`define TBITS	256*`M1
	`define nBank	4
        `define ADDRTOP	12
	`define	ADDR_AP	10
        `define M64_M128_M256    // for prech_reg 
	`define M128_M256        // RFU, c_addr 10->11 
        `define M64G3_M128_M256  // from M64G3
        `define M16G4_M64G3
    `endif

    `ifdef M512
	`define TBITS	512*`M1
	`define nBank	4
        `define ADDRTOP	12
	`define	ADDR_AP	10
        `define M64_M128_M256    // for prech_reg 
	//`define M128_M256        // RFU, c_addr 10->11 
        `define M64G3_M128_M256  // from M64G3
        `define M16G4_M64G3
    `endif

`ifdef M512
    `ifdef X4
	`define M512_X4
        `define B		4
        `define nCOL		12
        `define	PAGEDEPTH	4096
        `define nDQM		1
    `endif
    `ifdef X8
	`define M512_X8
        `define B		8
        `define nCOL		11
        `define	PAGEDEPTH	2048
        `define nDQM		1
    `endif
    `ifdef X16
        `define B		16
        `define nCOL		10
        `define	PAGEDEPTH	1024
        `define nDQM		2
    `endif
    `ifdef X32
        `define B		32
        `define nCOL		9
        `define	PAGEDEPTH	512
        `define nDQM		4
    `endif
`else
`ifdef M128_M256
    `ifdef X4
    	`define M128_M256_X4			// 98.6.30 BYC
    	`define B		4		// number of bit(x4)
    	`define nCOL		11
    	`define PAGEDEPTH	2048
	`define nDQM		1
    `endif
    `ifdef X8
        `define B		8		// number of bit(x8)
    	`define nCOL		10
    	`define PAGEDEPTH	1024
    	`define nDQM		1
    `endif
    `ifdef X16
    	`define B		16		// number of bit(x16)
    	`define nCOL		9
    	`define PAGEDEPTH	512
	`define nDQM		2
    `endif
    `ifdef X32
    	`define B		32		// number of bit(x32)
    	`define nCOL		8
    	`define PAGEDEPTH	256
	`define nDQM		4
    `endif
`else
    `ifdef X4
    	`define B		4		// number of bit(x4)
    	`define nCOL		10
    	`define PAGEDEPTH	1024
	`define nDQM		1
    `endif
    `ifdef X8
        `define B		8		// number of bit(x8)
    	`define nCOL		9
    	`define PAGEDEPTH	512
    	`define nDQM		1
    `endif
    `ifdef X16
    	`define B		16		// number of bit(x16)
    	`define nCOL		8
    	`define PAGEDEPTH	256
	`define nDQM		2
    `endif
    `ifdef X32
    	`define B		32		// number of bit(x32)
    	`define nCOL		8
    	`define PAGEDEPTH	256
	`define nDQM		4
    `endif
`endif
`endif

`ifdef tCC1
`else
	`define NO_CL1
`endif
`ifdef tSAC1
`else
	`define NO_CL1
`endif
`ifdef tSHZ1
`else
	`define NO_CL1
`endif
`ifdef tCC2
`else
	`define NO_CL2
`endif
`ifdef tSAC2
`else
	`define NO_CL2
`endif
`ifdef tSHZ2
`else
	`define NO_CL2
`endif
`ifdef tCC3
`else
	`define NO_CL3
`endif
`ifdef tSAC3
`else
	`define NO_CL3
`endif
`ifdef tSHZ3
`else
	`define NO_CL3
`endif

`ifdef	tRDL
`else
	`define	tRDL	1
`endif

`ifdef DPD_CMD
	`define DPD
`endif
`ifdef DPD_PIN
	`define DPD
`endif

  `define HB		`B/2
  `define BIT		`B-1:0
  `define BIT_C		`nCOL-1:0
  `define BIT_T		`nCOL+`ADDRTOP:0
  `define nWORD		`TBITS/`B/`nBank
  `define WORD		`nWORD-1:0
  
  inout   [`BIT]  dqi;
  input   [`nBank/2-1:0] ba;
  input   [`ADDRTOP:0]  ad;
  input   rasb,casb,web;
  input   clk,cke,csb;
  input   [`nDQM-1:0] dqm;
`ifdef DPD_PIN
  input   dpdb;
`endif
  
/*
  `ifdef M64
    	`include "m64.ac"
  `endif
  `ifdef M16
    	`include "m16.ac"
  `endif
  `ifdef M128
    	`include "m128.ac"
  `endif
  `ifdef M256
    	`include "m256.ac"
  `endif
*/

  parameter       pwrup_time = 200000, pwrup_check = 0;

wire     [`nBank/2 + `ADDRTOP : 0] addr;
assign addr = {ba, ad};

wire	[`BIT]	dqi;
`ifdef DYMEM
initial begin
	$damem_declare("mem_a", `B-1, 0, `nWORD-1, 0);
	$damem_declare("mem_b", `B-1, 0, `nWORD-1, 0);
end
`else
reg		[`BIT]	mem_a[`WORD];	// memory cell array of a bank
reg		[`BIT]	mem_b[`WORD];	// memory cell array of b bank
`endif
`ifdef NBANK4
`ifdef DYMEM
initial begin
	$damem_declare("mem_c", `B-1, 0, `nWORD-1, 0);
	$damem_declare("mem_d", `B-1, 0, `nWORD-1, 0);
end
`else
reg		[`BIT]	mem_c[`WORD];	// memory cell array of c bank
reg		[`BIT]	mem_d[`WORD];	// memory cell array of d bank
`endif
`endif

reg 	[`BIT] 	dqo, t_dqo;	// output temp. register declaration
reg		[`ADDRTOP:0]	r_addr_[`nBank-1:0];
reg		[`ADDRTOP:0]	r_addr;
reg		[`BIT_C] c_addr;	// column address
reg		[`BIT_T] m_addr; 	// merge row and column address 
reg 	[`BIT]  dout_reg[`PAGEDEPTH:0];
reg 	[`BIT]  din_rega[`PAGEDEPTH:0];	// din register for a bank
reg 	[`BIT]  din_regb[`PAGEDEPTH:0];	// din register for b bank
`ifdef NBANK4
reg 	[`BIT]  din_regc[`PAGEDEPTH:0];	// din register for c bank
reg 	[`BIT]  din_regd[`PAGEDEPTH:0];	// din register for d bank
`endif
reg 	[`BIT]  clk_dq;				
reg		ptr;

reg		[`BIT]	ZDATA;
reg		[7:0] ZBYTE;


// define mode dependency flag
`define INITIAL 0	// no bank precharge
/*
`define IDLE_AB	1	// both bank precharge
`define ACT_A   2	// a bank active and b bank precharge
`define ACT_B   3	// b bank active and a bank precharge
`define ACT_AB  4	// a & b bank active
`define IDLE_A  5   // only a bank prechage
`define IDLE_B  6   // only b bank prechage
*/

`define TRUE   1
`define FALSE  0
`define HIGH   1
`define LOW    0
`define	MARGIN	0.1

//parameter	pwrup_time = 200000, pwrup_check = 1;

/*
 *-----------------------------------------------------
 *	We know the phase of external signal 
 *	by examining the state of its flag.
 *-----------------------------------------------------
 */

reg		r_bank_addr;				// row bank check flag	
reg		[`nBank/2-1:0] c_bank_addr;				// column bank check flag	
reg		[`nBank-1:0] auto_flag;					// auto precharge flag
reg		burst_type,					// burst type flag
		auto_flagx,
		self_flag;					// auto & self refresh flag
integer	kill_bank, wr_kill_bank, rd_kill_bank;
integer	k;
reg		[`nBank-1:0] precharge_flag;			// precharge each bank check flag
reg		[`nBank/2:0] prech_reg;		// precharge mode (addr[13:12] && addr[10])
reg		[`nBank/2-1:0]	rd_autoprech_reg;
reg		[`nBank/2-1:0]	wr_autoprech_reg;
reg		[`nBank/2-1:0]	wr_autoprech_reg2;
reg		[`nBank/2-1:0]	prev_ba;		// bank address of previous command
reg		pwrup_done;
reg		[`nBank-1 : 0]	first_pre;
//reg		[8*8 : 1]	str;
integer auto_cnt;
integer i;

`ifdef M16
	wire	[3:0]	RFU = {addr[11:10], addr[8], addr[7]}; 
`endif

`ifdef M64
  `ifdef NBANK2
	wire	[3:0]	RFU = {addr[11:10], addr[8], addr[7]}; 
  `endif
  `ifdef NBANK4
	`ifdef X32
	  wire	[4:0]	RFU = {addr[12:10], addr[8], addr[7]}; 
	`else
	  wire	[5:0]	RFU = {addr[13:10], addr[8], addr[7]}; 
	`endif
  `endif
`endif

`ifdef M128 // 98.6.30 BYC
  `ifdef NBANK4
	`ifdef X32
	  wire	[4:0]	RFU = {addr[12:10], addr[8], addr[7]}; 
	`else
	  wire	[5:0]	RFU = {addr[13:10], addr[8], addr[7]}; 
	`endif
  `endif
`endif

`ifdef M256 // 98.6.30 BYC
	wire	[6:0]	RFU = {addr[14:10], addr[8], addr[7]}; 
`endif

`ifdef M512 // 98.6.30 BYC
	wire	[6:0]	RFU = {addr[14:10], addr[8], addr[7]}; 
`endif

reg [`nBank-1:0] Mode;			// check mode dependency
reg 	[`nBank-1:0] md;
reg		rd_reautoprecharge, wr_reautoprecharge;
`ifdef NOKIA
	reg	REF16M_MODE, REF32M_MODE;
`endif
`ifdef DPD
	`define	tDPDEXIT	200000
	reg	D_POWERDOWN, D_PDOWN_EXIT;
	integer	PROC_DPDEXIT;
`endif
`ifdef MOBILE
	reg	REF4BANK, REF2BANK, REF1BANK;
`endif
integer	BL, WBL, CL;	// burst length & cas latency
real 	tSHZ;			// clk to output in hi-Z
real	tSAC;			// clk to valid output
reg	write_event;//KyW ... 0408 for VCS

event
	active,		// main operation of SDRAM
	modeset,
	read,
	dqo_event,
	write,
	flush_write,
	precharge,
	rd_autoprecharge,
	wr_autoprecharge,
	wr_autoprecharge2,
	precharge_start,
	precharge_flag_kill,
	wr_precharge_flag_kill,
	rd_precharge_flag_kill,
	autorefresh,
	autostart,
	selfrefresh,
`ifdef DPD
	deeppowerdown,
	d_pdown_exit,
`endif
	selfexit;

//`protected
SR5^5SQd5DT^<G?YnYXJo9b<LUUIBFn[n6F5UG@ELGLC8_YH?1OgdiBLF?okghD5
KF1AoZl\GVO^ZbfDp?BP1k>hKfVN]H2;i]BkBgG5N1J>[oSk`acdj;5M9D3GMVOT
MM@F3mUZ1Oh1^9dMqm<ilXjc=e__Xfh<0Tk8@GWPm[9Vp0>Sl::q8UBk\MqMW:l_
_eq_;5C8o8Xmf:k]0afSgFNUT0C9KOY;?A2mMnkHc^m;EaPLSo1oU:XRhOe;kYqE
77\nC1ILn`5>d@fTU=3@RbcnnokCW5h0[hP6bpRRgh^@<f_X;]`cWOP3CWBjnQ@D
2bSTF4jJq?JG9eg3AV>iMbjoenLRkgLInPAnA[D7`0ak4MVFZ]FHpBL>H`=_44n;
Re3kW8ga:<4?InGJ=ja\`1Sji0l;3@O68qnh]PJB=Z^51WcRoPmM;Slb4Q@kONT;
EIXRWVP]>Uh=@q9Qb]26]MZJh;j4L^gEoZeef_<n2FkK9jp>ViBX>Ed;5k:9A^aL
6a8f\LcD_T8TAlnTYpnBFac>67K898@RJal7IS<7@gQaRPn=]q3BPg`IP:m_O97T
lYN5j2`iK7gHX<_R_PdODV2:2O]6g^?ZF\A7D_4Uhm6cpiW;4[XMpAmQM1:1UIGd
:M?o:dbOq\8?\dQAZ^[^akBm]D:7o8fkig:F6=d\eE33^p]=91NG`F]eJZ4mPioX
fk1WA8DJBC<hMj5fS6j7QEV87<p5A:`4:;qX_j?VS_6VjdBY1kO8;7bKka3OdH@S
Dcf^?fcdlUPNV;IqGI=fGfWlOa@49T^5bFBha1]^cF[Yq6UkV[3[mm;Jm6?SE^3L
Mb@VB0^XkXLTdOobK5`C5fe@Om:>BEFgLeD7<qA[_@X<l4:AF<AKO1`^dDjG6j7;
6lI0d:N?q?fEGRZ`qVkmRnU4qDjD6f[:VDBAbLC2EQ<YIoGhNoXGLE4m5^9RD8dk
IIOhX94[he0`;6?I\DVPQ<mA8`]i5]m4d`D:JQGEihN8jOf>U@KlKK8P^f8[?;^2
[:cl@SJZ0=6p@0XIZB21k3D=<7dMbA=R5l4QMff;jT=MOMZDe`@EbFFDloUXQWAI
5c?TJT`We:OgV2pIZL1^O:Y9<OhUNGDCmoEB@^Cfch[Uo;UA_^UKK<Hkl4:^83BZ
W7ao5QjFCj`qlJMD:@;SF1McK0LmBSXKVe=1YIV:f_Glj_nlXk23AU90cGbjjJqZ
akVgQ0gg3gOSU8?GRf@VCI\L\3AZ1S`5b9Ei;G]Z718:b9A`S;RpJh3ok\Oe4dFX
0IJJBBHhpdP0Feo`1eF;T_1S4aeXeG>NR`4Sd9dXoHRe9d8VO3obR[`:FVcW6B<P
:bA<lhla6qo9lQCZiQRIUdjW8h_E2VCY0aYLLMU[g[406hCme5K[MlBdj;^eeSSm
lSmH6q7`:iT[FC?OX8nDc\4?elU8LC[<A;^^0\:X?[88hHaOHYddd:0fcnkGYI]S
T>]`LIg_@MgWH;iWZfTe`8V6pAO^d;fcTN3]f>D<:9NegBIZC_IL`KTb\de_P`T9
aX]M=ImQNIIU`m:@Wb0_9@1gX9c;8_f`aLm9\oe<;_ikal1dd^@Eo0T^lk@2HE>B
1kkQ^nZHqf=A5[M[9<DJ4]YWVBBl8B2OQ673Vec`IYYYSa@V8d14h6K_0TjjKD]>
ERQI[ilMdqD1Z65nj_`B83iAU]6S[FJ0@pjIV?j1Bjc]2j:?2dk=2X\oPaDic@^A
3@J:`c;fXNN@20Ch\glI=aDljFlPU7_:RDMdK@a^apI5Aj1^Z2[CVg]Oal?:\C2>
Fi>llj_UMW0McE_g8bWPWhB1X@T2?Llk8aa:bn]dVYmfN\oFZg_JYE0YJ1:NN5EN
iHiiB>M_ULh3E;Jcq8oF4anh>M2MjFIBHh2=S?kRfJUg_d3noD1A`YC_45Jg1:o?
2[HTYN5jA;QPP>G]jl08i[DCeC=p2i_75RDInLAWok<qmh]dH4DB1_?3`AM;9XDB
0ZC7YdWd5MT8Io=IGlp6e8Vfo>>O_<04?9al_9MjM@liSDHclI6:VFN2S1pKDUA`
d1<A@kdH1h5n;1Bl1p3;<2lG<9f0bBdXL0VULTKSBpNYL0eW`0BnaH]8bbj;=c9A
^PUnQ[qcCdiVf[kTKLk2L=1iMo<`=cV]^7IP;d7[jq;cXb_iKE_R<[X39adII6<6
VFeiqc]LZVD3mEZ@4;fYSCipK@RF2Y6L]UNGGP^4Z\Bp92YV<@jfZ6UT;`RRTkdl
bn7i4P=jS\j;mfYp2_<^K7Ib1e_J1SWYi[N<JCbU5KI]CoG^b4b2=0:iSc8Me4XJ
4gNkll0K=S>0k4coQU1P0Hc_ThHBWoq`HXCK\X3f`[Y765Ym124JeC_ToNI25Tj]
BmI8HJVO`VP@R_Mmg_SiaE^q3nEf34EdKHceaDOYQL_\15]KKcMWogcRPcN7ff15
:HDVXYlGD@KTPN:lY7LbEJn\3QEMA7$
`endprotected

`ifdef X32
assign   #(tSAC, tSAC, tSHZ) dqi[`B-1:`B-8]= ( data_read & ~dqm_r[3] & ~rw_dqm)?dqo[`B-1:`B-8]:ZBYTE;
assign   #(tSAC, tSAC, tSHZ) dqi[`B-9:`B-16] = ( data_read & ~dqm_r[2] & ~rw_dqm)?dqo[`B-9:`B-16]:ZBYTE;
assign   #(tSAC, tSAC, tSHZ) dqi[`B-17:`B-24]= ( data_read & ~dqm_r[1] & ~rw_dqm)?dqo[`B-17:`B-24]:ZBYTE;
assign   #(tSAC, tSAC, tSHZ) dqi[`B-25:0] = ( data_read & ~dqm_r[0] & ~rw_dqm)?dqo[`B-25:0]:ZBYTE;
`endif
`ifdef X16
assign   #(tSAC, tSAC, tSHZ) dqi[`B-1:`B-8]= ( data_read & ~dqm_r[1] & ~rw_dqm)?dqo[`B-1:`B-8]:ZBYTE;
assign   #(tSAC, tSAC, tSHZ) dqi[`HB-1:0] = ( data_read & ~dqm_r[0] & ~rw_dqm)?dqo[`B-9:0]:ZBYTE;
`endif
`ifdef X8
assign   #(tSAC, tSAC, tSHZ) dqi[`B-1:0] = ( data_read & ~dqm_r & ~rw_dqm)?dqo[`B-1:0]:ZDATA;
`endif
`ifdef X4
assign   #(tSAC, tSAC, tSHZ) dqi[`B-1:0] = ( data_read & ~dqm_r & ~rw_dqm)?dqo[`B-1:0]:ZDATA;
`endif

//`protected
Ck9;aSQH5DT^<=QX?i<n5McbDiCAP`5[GQqGd8QX:2IK27W6DobhhSNfB_AcLOI6
Yf]ha^MoSSUX34mneNNjRVl8eGSh@9nb2qmU@3Efn0RJ:0meoRP9hq0KB>g2qdN7
>Z_^0_8dAiV<3a3;M2bAp4_^JEJ@5IabLYWX@6hQn9Nkg4iPnjTc>m=eZd@JmiZ8
U]EVqBk86g^MYOAT5OU[dikNDLgWS0F@JWj9a9Ag>\YqE0:H4?p6ZaL<ZKIDjnNR
V^XK1BGcf2Kci5p?0S33F88PX9hOO:dqN2FTBXH5oJN_f05pAc0JR<6R1NZa9@kD
oXU=nEdj6oFgT_2d_B^2B6qT[@CJh<k=:0mM5`K;6`6@9S2H^iY:B[NUd4jOX<U[
QiacjRU^hDSD5^ei[ORQXip\iBH`^>pdjaW<kcj<JlkQY[7l69;RJ:lYn4<YJR78
TeP2P1L?3dmY336ITIoG\_ooBgjhb4pCG7iKPqo[j\^ZXFTEXTe]ah>FHBL7_[o3
:k0>bqe4k2HC_B:Sd:ZCH9VA<XNg2mO8^m<?LOlb990M@pi?05SMBCCXHR]9>eB;
QMNbNf=D<4:h:jhia\qkd@aQX1;DL=52dbc;M\CmICV`JVHV^RHq15N:kCpU6;Bb
7FJ[FOaLKeeMKJRPe]^qIHbBh;d>4glfDBN;OF8iG;9foY0DnGklZ><[LFY9gCha
712>[A4Tl<pb9^RcijGjCG@^<QNi\>4W0g7SicTiW3Z8Afq`m7@5na7=RMkHSRcX
V4p]nem>EqjT^8\B6qI:0B6`BnLJJe3V<[EY0S<X7f;BQ:UNgU@J927\dcc_fB`^
db7eCjlVpZ@;NFHhmWW2B^VKX>56Ldcq@PMK45Jd^lX5ZM=U=ie6:@aqFi]`9?m[
V]dl8ob5ik`1PWZE`ZaKlHpojP6S0:XFN2_jY3GYW=^]Dep7moS\=k_ofhQ^4H;M
`<4h=GqZVc_\A8\ml75mjIL?e?o>lpD\KO0g:2eI1_MM`:nNOEV0qBHS>U1ibfQD
Q:Fb4k:O3g`pEEabK1Fo4CJY\k0XSQO5@j?4>8Yq>Iko0iQ3L8lCP0K\h\ha??^f
_NfpPGRn\VleCW1fC;GLVZc<mGVL@oG<qHOcL3>8TN:\:W7_:6QA>eQW48=b<qaJ
a^`cJ;LYB`NDDc7FE@S]X]OfbX>7EB]5=2LM6V`jDD<F>p1YnkC[M=SNPY[S0Ga_
]9L=g:nT2qBW0:Be?FkldIUkhc2Jd2295fL^EN>m>pWG??beA\n?3SLkHho2=;o;
b0LPmSFBTopY:17?BoHOeaNWLQPGMYn9_dd[<J?qgdJd83e<T:XFf_XX3KD`o@F:
eV]di[JIb7V<M20FURF?ETb=NjF0\m3Xohp85NHLc;m6c4AS5:f;\i58MgOU5jaP
?QEBaq\<mNEgp4b5S00oK7:HI\YpCX9iV[q_ODM^[q5b]b;<pG^2o:;dD2_2SlMK
bTajEA2MWjngNLZCp;EIIgBAdbRmP[b55Jik4n=48h]QF5L^>Lfbp[G`X`HID:lI
NNGVQO4E<>NSda@j@XiTpcgOKA<^oeb5_Jlo2<`@c<UA\8gjV45p1[j\hLaG9RH4
n46NV2MRMD]IfIjecaqD>4j0IoQLNc1k1V[Xa8qWX6Yc0qX^N8IAp<k9N^@q>j8;
c=VXb<OU^gDC94^0Ab@CH6@KGXG=4^ki]:CL=2@iqLj;NV6q=aDeYO8?SV>8QW0P
^Y6mmB[5C[ZFH7Ep\:Ao2gZHboI[1oDVeWV@XPAVSabd[9hqKh3VNTIXLnhd]CZM
keRHP81YFmVcYlpBB3P`J<=j[;[bdTd?I9ZKiKHNQ\6d@pG;BH3OFTpFIKSU]GqY
B^mIOqDc4aiciqFm4Me0hM>6g9W7io;LJ`]=;C9]_pSFLA7TZZe<ecE=XI\_E:`k
i`mA5M[`WqOZ=W=4Gn5ifMMAYEgQHcF2NAKI:ekZ=pRO[[2]`QB[BASKfT?min2P
9b9QU79lpATQR>[D6H^2kZH7D\A0JShJeiA3nWhq\CfDQiLlOCeTF?Gdg2?ll=IY
Ij9JMR`K\l<S8F^MT4f@_>L;D1;D[P4K<6O5J`S@EDqaTPoZLap08^OF7qX2kL@>
]p]OmX9O^WCnl`8T1J_2@eILRIpJO\D3;:ka<1=FgZ`M>eU>a\^QS6i:7pcMV^6<
M[DX3XRcG3_i21`YKc01NN[[a]X`qga4`8h6^_HFGAc7KI[;L<Hoe]hMRETNYpSk
b@8=nWPe[V59mgoC3Hg?NUjjS]\h?P_;i\]ZR4ejBg`HeaOa]2>^AhpcoC0K@]LT
k53iam0PBFgK27Phk[TX<fLZDQ\>S1qh6KCCl0TJhhMoX28bCDQH:k_X[d^=<>7X
@:WX9gbqFQ=dR\EZ65@>d4PU3o9RJK[@_MEGdBgfQmLapO[<dXnLFbM5=`M`ReFh
`aWi5dLNWgd3C]nF6q3DQJ^[BB:d>NIIDf<L`8MVK922I;_k:KZAeBqPLn1T;Tf<
bVP`^[EpG>]=XT[LTd0mVHf7Sm309;`0?^Em;HS1gA3LaCc<:a;;Ge]C3NZI253P
agfgBGb6;k4qYHBiWOARkT9RJGMNXi5@;U<6e0f2@b7bd3HqKGEBAW9l8XUZa[D_
a\4mAn^P47m;lih0G@<qXJWRQf5pNQeV47]A>R@lUKaWJQqCiKXc1f5^;U?RooYo
A5<hZ4\MhKmUmq75daT9mc[9i72QP0kISb5WWF0@fma4@p^>o<]j9]CRN[:?go9`
f4BXb_IIPH@aWp2Mc]NnAq2aMYj=MWdA2Ae[\lm`52F><2ZSeITeoSc739]>O<m6
=qOV9jVBjT]jAdnDqTbldL\ND<IGL;DKk^=k\4[LWiIoV0kh>e>]q19@JRT79hI0
hkB6b@jI3`k4QMa<mX\ZoQ81SpjBb:3lPof>Wg;[\SYNLi7XI498i39iBNqMhif2
\Ip7]=Oh=`Uak?TfZE_W<F2l\RIo3efcnKhG8]q_[2SRAjWYac4olON`OKbdb<[H
Jo?Th^K`h\obEHG?kn7pP`WKR4Cp`nQMgG;BXAZ[P8KSL\J<eeM?gPoc\0Y4b`]@
L8mZ@?m=g[^j_AO:aYCf<c5_1RLQObZD^G^EQCZZP@bMQb`55_OcqIIR^Di`8h8;
OPD\Tlak>VTqcW3]O^H]bUChMl;Z:aj54VTQEbUgp\nAiPeIWOSNc;Lc3MnqeeIR
QYT`EPWfg<F^F9Z<ZDP6;^Tii4hI4GOq11?2Yn7e=Mm6fhi^;]?@XUE8UV_kcB`E
Qn40TBDaH<n:@^kZkok0[oMXXfW6ZkYPb0_b9Ip6PC<Y4LULI_G`df73Hcn;Dj`E
RiqK14WB3hpmhK5T86CX90;FDomZNjRS33k[QQ5MM\>hZC8HLV]qDLe;f`Nq6>0:
QcafBNaVUBATk@hgE68h:7>0KWB5<HOFl5mV7^9]O:GeF7[618A9LHPP_Rp:?3=g
n_pPSm>UAQ2Ll\o[kCdFFmcZ48Fh\6WO7\1L8P0WaLHB0p>6AYAkokFY^BVUkk4Y
edl7>jn5G?igHIA?RoiP@oQVbeA9CTf1DUd::j4Pe7n\Y6S]Zgn9iTY;gOVBEU@M
?dShn^]`E;H^9\M`pNTYhO5hpXPNVikkgk[>jLC_Jo<W@q]<]na2\jlYC_HWNSJN
6\bZ<AN3PPdNONpK?:Zd`^BWZa_OR\;n?B0UOZ?^4i:8h\E==c01030?beCJZd3c
<`K5WC2g7Q]S1i>WMV41i`I<I>_miJ:qWX7nK6@p1SBAnG<;4cbqWHG<:La`majR
2JDh4@KSAbD:gn=Nd^k7U`bTM^3D0U2iZbBEQmn2?TL68[ADI]32XMaFFEUpfM8S
5b7pIBPJgJ=cbA7Y2f]Of4C1bZ6LW]f:>Xa7B4AF?6Sp_DlWmU6?be7QncD8Vn67
jKNnLMPY>hB$
`endprotected
				`ifdef M16G2_M641G
				  pcke <= repeat (1) @(negedge pclk)  cke;
				`else
				  #0 pcke = cke;
				`endif
				
			end
`ifdef DPD
			else if (D_POWERDOWN == `TRUE)
			begin
				->d_pdown_exit;
`ifdef v
		$display(">> deep power down exit at 	%t", CUR_TIME);
`endif
				POWERDOWN_MODE = `FALSE;
				CKE_FLAG = `FALSE;
			end
`endif
			else
			  begin
				`ifdef M16G2_M641G
				  if (CUR_TIME - TCKE >= `tPDE-`MARGIN)
				`else
				  if( CUR_TIME - TCKE >= `tSS-`MARGIN )
				`endif
				begin
`ifdef v
			$display(">> power down exit at 	%t", CUR_TIME);
`endif
					POWERDOWN_MODE = `FALSE;
					CKE_FLAG = `FALSE;
				    pcke <= repeat (1) @(negedge pclk)  cke; 
				end
				else
				begin
					`ifdef M16G2_M641G
					  $display("Warning: tPDE violation at %t", CUR_TIME);
					`else
					  $display("Warning: tSS Precharge Power Down Exit Setup Violation at %t",CUR_TIME);
					`endif
					disable main;
				end
			end
		end

		if( POWERDOWN_MODE == `FALSE)
		begin
			if( CUR_TIME - TCKE < `tSS-`MARGIN )	// check cke setup timing
				$display("Warning: CKE setup violation at %t", CUR_TIME);
			else if( cke && SUSPEND_MODE == `TRUE )
			begin
`ifdef v
		$display(">> clock suspension exit at 	%t", CUR_TIME);
`endif
				SUSPEND_MODE = `FALSE;
				pcke <= @(negedge clk) cke;
			end
			else
				pcke <= @(negedge clk) cke;
		end

// clock timing check

			TCC_P = CUR_TIME - TCLK_H;  // saving current clock period

			if( CUR_TIME - TCLK_H < `tCCmin-`MARGIN && POWERDOWN_MODE1 == `FALSE)//KyW ... 0928 for NOKIA claim
				$display("Warning: tCCmin violation at %t", CUR_TIME);

			if( CUR_TIME - TCLK_H > `tCCmax+`MARGIN && POWERDOWN_MODE1 == `FALSE)//KyW ... 0928 for NOKIA claim
				$display("Warning: tCCmax violation at %t", CUR_TIME);
//`protected
B:?A[SQV5DT^<@QHi?KJ@iBfn_O`BcKQ_?5hmZmQ\M`d`ZOqf[QaF5kU0;XeDk28
REl0dUUUSBm83@WWLaL50gV^IPPCp_@h:aYSHhDV\UWRcSofJS_N[9;WLL@E02gH
P3VQV9B7U?QJI4ahXcM4W86[D^;_pakeH::qnHkUZhQ2fVP>CgCok6XK@3eo4VQJ
fMj876gHOWIYoPLooUESGdl:2<:i5=q;:KO\<K?74C2GKJ=_Q]50H6h:Z0hD<oj:
P;\4dN?9M`O>l1E:GZZWNW;RKQZ?<f5QcI1BD4M5f7p3jOM@j6bi22Jf7RG2g1Gk
X74;3C7iQpcZe0`O2c5jDJQNK;hmWSD_pGP5P@TUE0[6TofX7BO6Al=HdF=XL<5L
WgZnA3jO9=YaI;WVLLfI?]Roq1QmfZe5C[?3]m9beJE@6lEV_N;m95TBQ1X?DhTL
X9KFhFoFYCGeRc9e6^;<Jl5LKaPfRM8H3<56kVjOI39[pfKA^Ta`q^`U5H<ci=Tc
7N8L^[6>fMgA_;IhDpWh]W?^`L3`>f0\lnXES=iC7AL@[A:C=?9mqP?DnHScp8`Y
8Rc`XSPbFfZc0MYg[?S]OhJ^ST<C4LJ=g]?[=<^4lplhT`mbJ[8SDHHB2^@b?oSE
UCUFXZQX23j?7gd9;]N3\[mWg8;1oY8CnVqkOFmYY8FaIQfMTZOhTA_0W6ndXVGg
OX?_iMbR_S8B9E7W126GBFM@]`P9f0WHkYBgF0dKFl;En@1[71Cf5VKp@43UfSLq
OCKK[IOVOgik9j?DIZTTX96;]De[5K8q50_?4c4bHZ@1FYkD>cIlFc;;koG5^JHi
W>SZh8KgL2c0fRAa54QNl>Xgq_A<WfX`HGV37fK8YkYl7RIJJL=`7X\FUV5V@MNT
G3HOj4:;>V`Z7dJcKC9A2d>Xl7L=@W`JP3E5iYRZ0Y;E3pBZof8^4phd]bAOKL[P
TeGg?8I`2Y=9EK>K[Ik8_qDFoPe0iF1L1fl:G@UElNTCq1hei_dq4GE8eRc2_b_a
KaC7\VhaVgi^8o`khL1eEahGP87NbgPdA_3f<ndIMXaqXm2^E;n_jWccPM:dKIS:
0=[m?`0?o\B7cPnNhaoeSdNbDFaSP<QJVRTG>e7kA[XR=i5^2:0Dm>DIJOLJaeQq
fU`T]3Eqh[1`c[@1XDGOJiG4^LB[1K`=:dl4qlM8QlIFmLMD66L[QJe0efbcl7HE
6:im1GlEoiXINX_E]kCi=kUWm[IdY[gK\;>ap^SWl`QOq<J6YbE]Ml3cf12UMaR`
\AmOI2;HAicLd]UljX25J^l147c2`Kb88WJAXE^nCphd8_8:LA<VS2P<gnl`mn0X
FmG9Gcf4_5ETNWnNNS5ilO<<Z6Q:6fCOgS80\e0TgH=DC3;X_WTIm<g<pN5cC?Pn
RGL=dI5DWQL[:VSdTFdHQGHfM<Gm4IF9;0N6CFIIh_3]nLNbS`R2aEhZ_N3TFj^`
Fd^Kj0l8N[iUfih8=RkVok6qM7a5X7Uj2Aq8B7`TIVPi]CmglZ]@^JJJ@;GG3JTS
WM0ImRmA>8pR>d90<LF=]iR9VZ0TK79ERoMNUX0;Z^Kb@0cqRh035bD=5RaK5?qF
KFWDJHpIA^HBmFq^bE^?`fp]Den3Ag8<Pa4HMXiRD^oECcCPF<h1U<6>9dS^:DmV
CfN0l4qD[OiHFP\48>KKmVWd_iYdc:3Wm_269H^qGHZDgG@poeTLX^KGSoc<elGR
:OmjOVSqcf1LVYnW;k5I3a;Rbcl:2F6?Ihn4qDK0;<6<BUEc\_i3lOE2<2Ypbok:
HPEX76OBLRZog`e:qkhjb43X8I7h]E]IogIVofYMjbDOjST_8\>qS8UI[4VP:UBL
L_R9=>CnnRoZW4MF^he6T?BOo9BLMA?18F8hGI59]H7`a?jMYQ?1:jHHR8qXNZFN
M\QM9Y??oG?mal9YV`L2\gA8\?J>Jp430NBY>?gKo^F90Q<hHU]IbWX\[pHBjm8>
]9L\?nP^U:SNEgL[6[EL^8mZRKWPqFYP786V\A3FS\`KHQcaq7:f]b`EpYb7DE68
:Kl<55cY[B<<aqNB5Z]lU1^Z2Fl3SXSUE6[n11aX5n:gYoWfgVH^@chF4@Z<YW?[
JkEWHX2V8O2?\196lLbYA;1kXoR6SZ3W<Z9<P=qb=^48nUW>jI`8fAmcY=c6J3`=
VqfPbW[_`p2CdA@fC<S>M1;QJe;>05_c761GQe8K`\o9:8A<YakZHmXj:7BY<ZDf
nUpgJBSY5oB6XX[lYC^T1Yc=hLREid<oSoXU<NCTg5>oN0>pP2BKE@eSTZ6\dg:K
bTmH8_YOJHNE^]mak7I0QmgGW4LL2FOJl:Gd]L\mL9RM_lg[]]MMl]R;9:j\7S@k
cD0HL\N_p5SbRCFLk?N81a8_EE=qFM2g<gX9Rbk^jIfiSf1A=G[Fi3pX7:aWPa03
8U4XWIb0YNH`OLaoEehLfaPC@2YjH;X@E]^^DGoZZ=Dd8Cg[??:O8]NXK6db641q
Dh>;:MGpLABc9YfMIOX@DNUkg5jKH<Tj9b2HaG\\[`n^PE`NCY^eKH1oTj;`7ki\
71GE^AJEc6EKX8A6g>;aiY8leJa?UC]5`j:K7SVE1gWADI2oZ6pL2=l]fP0M6i;:
4I`OR2^fC<JMCqS;0lHX:pYg^KYMe=HTNQ:YVZaQg@fMS\hhFBA4V\;TehQ;1T`<
ll\eHjmOfB2HSq>dH3aRh72=18g^pQ5PJZZ<ZfiFWejcae8cD7N2Jj9o5n=MkSgU
@BS8jq[one1=1jlXfWO[j]2UG]O9@oIcAOhc>^UT7N25ac=j\OXH2X4EB`P555_j
JODeTAUL`0XRI2Cl42d\_G2R`?KmG]RcA`fj;0RFBRU9aZKDZ2Cnpn1El^5il0:m
I5`AdZOD^:Bc@impjOo^mYBq5In@^XLgh0TNOZgR\QdEGG:ReKM6e[5q4LCIm\?e
2BJ8QcfFkVi4RRi=[hlZL6bA2`B;4acV@^GX>W5:C>p^:B83?ke3loB0PPia7=eb
72<gZi>@X6H>K1;=4YphAXOikRWn<Bk;OBVOWUUQBlSXVjLU7FOJ8B7QBJW?HgK>
OeYI7^^aeoBQ8lE1]hW0MXG?>nm5bqZSCOQWeQU4\b<fE@F45RQKBC@f;Wqj9];o
5^ab]4TPTGOGWjqLci0Tdgl83Yj<?eN2an3beVDFK0enj0Q[:MqLCiBmb1N<>TWD
\[D>kFa98l7:5l=Kn6UW9?>O0:T1G06RlHP^2kq9A8BMJHZd66][_YL\@nV_4J;;
Y565DYmM05eaci\WbWV8ZpEo;bA5nKpTL]Di?9\9Z;LBjXUnRAqUF6]DDC`KGXcE
6Jh7X3W2cGM870ak43S`nHVQnA7PDq4YmG3eeWKddn_Q>N0HQIXff061cbL[7Ug4
=f4oK<1GpZQ7@h?4oQAWEh5=OR1`Gk\R5nO<e2[X@nS3G@D6R7AB]nd0I=@Gq>>g
Z]cKVpM2Ta7Gmap_ejehAklJ;06]Q[c7?:DZ`9EaBQSOSMef;lhZ_K@H:;X>N:9Z
k@ApE?FA]ao[ER4SB^?GgPWcMN<cZZjK6b\;qATYomRWCQ\6iS\_4eAV7^1p3I\9
`7Eqlm?LE:f4AdH5^7eX3T[5kaFU[gZgcoNFEb<mD<BmOk5UU7O2NJ8DR<g5^AG]
;^H]MYCHoOPDKjklF7l_=MIakEJ5BdlD_R==MVbNAWC1T7;RYMcB=7QC@jXf1TOi
QEpn7=@KiJq_4[cC]YY7?Aig?VLc[c4V_fbb[_S@HQRff4am>k2m94[T=8R4Y7Ze
:90>>Q;KgOF_PX2[fgpj>WV1j5?h^Z`_XikoNEl]LHg<UEPLneGaAj:ACP@9oe=j
@DSYb8R_Dn^7nN;dOAeQf?4ohGMd@Ind5@A<Np<Z^Sea7<=ZfW979>ad4E2G1<``
U<gLFF3jdW?_]R0GDYLiMal^K1\Iq^b\k:B2H]aTTZ<k\Q0]dJGkkbe><8O:`PgX
U];Zp;K5JMPB3kJ_8F3>=7i6J4cliqciNO>4TpE>OAoGCl>4UE0Zl\FPaOSng@n4
3[?O89U2h_3nbI6gU;R8;5A8NggYbPaN0ehCEiSCbSW7CdS2olHemjFE_86PNKf9
IX6j8HnJL?N?H5L@e@A_nU80ZbKj7koN<fmgGm923pP=aQb6TpB:XRTPP`7VEJ]R
\f[9T`JP8A9hOQ]lVPCFGXhk`=S=q9j:DeQ?cb0nb^WSZIUMYm7:Bk<F?Rl20gPS
ZMVVn644PAN6o`c5RQV=7_[X2bhdW=Y:_g9PV;dqaF37U?XSMWT5I7`PSfDh^2G;
DDW]7nF[8Nc`qIn1[WJ3NGo_Wf7TH4D4]mBQ_OOTC7PiFC8SUeTU@jSXEqW<inRM
h3[l4NkQ=baioffT6G=NSGZm9fqf;l3Y<^OTJ1@?L0JH6:pZ>XdOh6qG\m?ji8:@
I?R4j6GG2379KF5oGT4aljo`89JOk3XFQn6lQSM]e:Ijlj;S5[^DE0iohlEjW91?
8@SDZABUhG6p[hQ]On_Z2OdSi\9nWf>A=?RJqc;`GjX[p37O=cdlBM9=J=dYe2fS
G0Rh]_]Yh\_a[iFUVV@EKJYhc;A@Q`N15?7nI5V3O5^EOEImeB_Y?0Dc5o4D]o49
:14H1_oZ>We1OojYmn3@GLU`;IA@A`OQ2Qo9RmIaUpk9O=Vg1q2_d^gc6qJUXZH3
lVa@J=8[6WPMjI=eMMc^HbHSU5GO1bV<jE2MQY@YOqCU[TYnpDB6WU_Qqn9oZHP1
mo:]J`m@Pi=7[OZKd8<Pgq^ne_WQDd?4]b=gSRDNfj\5g\QTB1K?=?p7O7khXnq<
Uc5LPYBSilRJ>Q\;G8o_61O_M=<AT=<3f05P?UTLCk=K5m^F7Tol>FWg3qT@FLd0
gLUaS\:5MJ6h42TQJUGZZD;aV2mSoV\oUj8ZCLP3N=Y6Z0G>4TY7ZQq>?bfS^gD?
@[8ATWBp>W;Td\\pf6Dklka89ZaD<JWK@RA?<^V<3[Lfq=jZ7;0?<\FCC`hh6Z2e
q:54Shd5AaRM=lKfM6b4eE;7S8;AQO[e`L5Qp:RVnT5@F;Pde?aKT<h;?an@ED^Y
9a5o17`JAcU7jM1RSSAUa5H8qBoJ^]nkIqEgn]`>P5CCaA@?ikFh\q1W30bUETRe
M:KFS@6HFV4<VnAHQohE@qAoeefk8=ha7\?8dYX:0NnW8?M]A]LXm9_PTl?f4kii
pRS[8?UP1g[Schom86Tbok_:f:e5IRm8lSSmk>Q5n3mqF3JK^E4JmMei2Q6`X:Sn
^?:O:3]LTJ=k?5j<OXJXY`1NV35Xo>PpK9MR^S`IpVf<Kf`eHqTEFjcL3LQNhVeG
SM72Q0fHaMTo7oWiZP6XNmVhVZnMia82=Y_7X[U>UOOhIg7CgUESNdqJ\28Jgf<K
1NUO66qUlIDSR=MbC8BbG7be?\M5]4PWi8CE9A?2iX47F^]AmDYJDp2R:dgB2cpG
P3`h[BX=cNm@PNY:e[kW4qeIbiDh2T7RoDXLj=9<U\:7PdpBKN0g[IqOC8U;Nm4N
YLe@MnXqJif2Oc7W5K?D95]2T?p2D]\K6fpKV>GdDWZYZ9n6PlNG\;?8mD:INcI4
JbB`998^L:OF4GpFKZ:<\3gHO0i[F>J[kkNic7DpT\aNe2ZG]i`R1dW?IMNMCD20
o^MimV1AmY>V`X5FHi5NXC[WG^a_HBUXgV<Hk?_lSZk72`qgn<J_kaq<oN`=KUT?
o?BhGO5pYbWEJ`[pG9ZH<60o5g<B]5j1ol<0bQoPRHXS2h`\=`p2fL?Co4h^K7Qk
^No93aqe\VLI6chcYO9WMiPEmNiND:;@Gc@]Ub0phVjn^0>0@eZUF7n8mORkI]a:
bge[Ffn3A0@B2AXTpn@PMMG4pVH64<oX=]1^5l6kYKS0q]S\:DRLeIV7?cD?0\AL
I`Lg:SUqLm1LQZapdX<_I:apUi?9bd_ii4;IBg;>]eDEUi6ohbg8YC:jU9@[WB`X
:Eo7=`7?:]O7jBnCL@C>d<JIT^M0G^a60?35;^i7iPg5PMfA@:dc4@:`VffnnYWM
2B`pghYQEn6q_G_i9Sp^ZU]jm_jO6R@ckSB^M2NpKI<4cQdo]icqML`B:f<@ORC6
7SmaO?7oR>Qb795PeDU;d^jCnG3n0CPU8=?\T2VNM:R@gj6eDXDF?a>m]cI=h@NO
_[EM:?IMcFn]S;6diK1UhX6gECTF0^ZC\;CqldfR3JRpA8M6RmIpiII1Ui;d:H^n
8UI78Yj88oJ?RFC9ODgCL@LWVFOJ<>@30_UYBU;P73ghfa`SP?QL<Qp20YlHL6K\
^?8R;PMY8SgdU03>ApedgNDF6pm1IH^IUpakGmAj=nXiO5ek\X5]oI`4J9T]Q:Tk
8Oq9_o@P>_Zd6J7SYhoIA4ELb5A`m[O4NLD\Q?P?Y<_FBPcO?XNG^[o;nb]q8>T8
VNjM0DH]gW2RpW@IUY?Wq54D7Y[>PWREUhdUm\H[1oBnKSb`N0D=c:^q2dJ:H_X1
@RZ11]0da4<qmPU7eHV;PFj>dgR<eJ:pgfA?Q3RR0m\GciThm5c=L6e2bbKGkk5d
p`:POh]apIQejCRQ;4giWb<JXIC9pRY]nlGN30UQbNa295DAF80bMI1pD[\:=jP0
XcEi=RNlUm_SqGCa[jnAq`jVa@K5q@^ToV\WYZohm4>>C>B2n@8ZCG<:Sk3^?jR^
bknVgTkK571Y:CQVXbWYD\N:_MEbIS:]OfjS^n;QCjL8^_V=3nb2[OVnSRQ^kP2m
JnD0edDfq]FMP9>mpH;g>PmR;eIeCkW4HpDTc4g<1pikj6A_O`555G6CGZ=bQ4m4
WKYdNVZD;hMmNLA?q0de__FXj9ofdn5>`^2og=66[lFCTWnmVTDqRAO@Wj^pFPVh
>_H1X7`:>Ae]]<VKhN[YM<@SOF8nY<>BQ^:PkU^p@DESB^k\]IeahQ>\lFl`I_Ii
5AYJfdbn>4AfpH`J29=m:>KK8>Oma1_AJI7U>9F;gZ_Z@W:N>:>8Jpb2WRK\f2aH
A1WWN7m1K^b4:BQ]iEIVX`FaS2CR^Xg`6Ih_IW1OHDfh`D7QSTY>SQb:JeXLbn=6
^HiR1HZ:=J17P^N`WjZ<k:AF<QFbW\`7;9<?nJ^WqMLlebgApfKKQm]A?j>0S:a4
Teg1a2`E=22\ohE8ak_g1DD3bH0`nW=KZF>3>G?i01Y0q7TNS;CRR1iMEQLZRc0p
oSMbT\jqf8VVm0F48kgFhGS4D5k_ZLNfFAZ3_0P\:>qcLooC=TH7D;PoldjC6\?9
im48JVjXJlMR<BhKm=2\=19hPTcnkfUHia=e=_Gi3?hMn?G6j5@PL@9d>kmXJ>Fn
4_LcW1l`JUS9OM3gP4C^?qS_<EiI`SK=>ki^5_QQ;`U?2`e]^fTG@<pI@94Gj2oA
OKk4cL6>i>40HQIe\5P0ESmn[GfcobMhYDaY2N4gIWF16VPUB9147\JYMQYV<Fb>
>YO`J;5\h8<oK71V=K8]@A:]E8n]YogHhYjmQ:88148QP?_iBAo>^a[BYipZGFKK
>d$
`endprotected
			'b101 :
				begin	// read command
					bank_id = BankSelect(ba);
					str = PrintBank(ba);
                    gapless = (pclk_high == last_rw && auto_flag[bank_id]) ? 
								`TRUE : `FALSE;
					`ifdef M16G4_M64G3
					  if (precharge_flag[bank_id])
					    begin
						  $display("Warning: Illegal command in precharge operation at %t",CUR_TIME);
						  disable command_sel;
					    end
					`else
					  if( auto_flagx )
					    begin
						  $display("Warning: Illegal command in auto-precharge command at %t",CUR_TIME);
						  disable command_sel;
					    end
					`endif
					else if( Mode[bank_id] == `TRUE)
					begin
						if( READ_MODE == `TRUE)
						begin
`ifdef M64G3_M128_M256
							if (auto_flag[prev_ba] == `TRUE && prev_ba != bank_id) begin
								rd_autoprech_reg = prev_ba;
								->rd_autoprecharge;
							end
`endif
							READ_MODE = `FALSE;
							#0 disable read_block;
						end
						if( WRITE_MODE == `TRUE)
						begin
`ifdef M64G3_M128_M256
							if (auto_flag[prev_ba] == `TRUE && prev_ba != bank_id) begin
//`ifdef RDL2
								if (`tRDL == 2) begin
									wr_autoprech_reg2 = prev_ba;
									->wr_autoprecharge2;
								end
//`else
								else begin
									wr_autoprech_reg = prev_ba;
									->wr_autoprecharge;
								end
//`endif
							end
`endif
							WRITE_MODE = `FALSE;
							disable write_block;
						end
                        last_read = CUR_TIME;
                        prev_com = {RASB_FLAG,CASB_FLAG,WEB_FLAG};
			prev_ba = ba;
                        rw_dqm <= `FALSE;
						#0 ->read;
					end

					else
						$display("Warning: Illegal read (%0s is not acitve) at %t",str,CUR_TIME);
				end
			'b100 :
				begin	// write command
					bank_id = BankSelect(ba);
					str = PrintBank(ba);
                      if (prev_com == 3'b101) begin
                        if (clkh_dq !== `B'bz && data_read_delay == 1'b1) // 98.6.29 BYC
                            $display("Warning: HIZ should be issued 1 cycle before write op at %t", CUR_TIME);
                      end
					`ifdef M16G2_M641G
					`else
                      gapless = (pclk_high == last_rw && auto_flag[bank_id]) 
								? `TRUE : `FALSE;
					`endif
					`ifdef M16G4_M64G3
					  if (precharge_flag[bank_id])
					    begin
						  $display("Warning: Illegal command in precharge operation at %t",CUR_TIME);
						  disable command_sel;
					    end
					`else
					  if( auto_flagx )
					    begin
						  $display("Warning: Illegal command in auto-precharge command at %t",CUR_TIME);
						  disable command_sel;
					    end
					`endif
//`protected
^PIWHSQ:5DT^<=5:5QV9iLnoN3TbLW]e?AcHMDB<hEV\=RRO8>b10f?M_O_dqS5O
B;;aT2Z_[bJ2JK=Kfbm]JWCGOC=kk9X0aJe_pB4AiNVOZIIfR=Qa\:E2fNELW6]:
3X?<\EYeUqjoL]B1pT@5K\joWQllE>9Ue^bgICE>WMEjomoP:2aR8;^lNl\\DpG2
f_g@ZqNhQVkPLAJ^H__l]\`oKbR\<>VSY<_a`DUF\PpIdG1>2dRF91c:V@JM3nQ>
Vi4KY`0PGbdH=cGQAG9OUA3Pf5]<S^QdJjapblY<]L[q:KUP\6l9fDG3508Y]LX2
]gQ>>Dn<Ymq:nf4T:<b=1@=3MSmWa[QR1bBSWDFQA=9AgUg64_ef^5EPYjWk[ed9
^bU^GF@W@[<[O>`Y_a^QD[ooVXFqJ@Ke]H\g:Q9]T^CAPh<lJQ2o`ZUeaf8\hoS>
E>2]9SZ2q9m9[?0J_5QQYSM`ZSY836QAb?3:NW7aq8ZZ>`J^qQoflkC?nm4809CS
Q`eTh@]]jgGl[R8_78YC6JHYdKTDJ?H[;cJ\0cY]NDmpbVJRhE=qN`UIh@Dbg;@L
JjW`KF9DRXYZAPAQliBBpL5_hUA=Pa]oZgX^EQ1BKJM\;\HWBiBO]T]?BjBT6jSB
mW^mBRaP>kaq9KjGLBd^\aBWTe=lWC[H?[6OcR^\?Y0q8WG@;k9qOYWDJRm>1hAQ
U3S?goge`L;YJ8mp8^H0@`9S?cOShPbTE]BOZT8]lhcU?M]d2bGR2ep6c@\6JUpN
]^Ub;KfXK]7>TK=51KUiId6_I:U9nqZeF_d@1QPnA@>]Adgb6E]]WQf:<hIM:ei9
0>aPIj:Kf332W04jRE\]R2];1Cn:YI\IWh;W_2M7OX;@jDqG8Cc02co;X:6EDhhJ
UL0n_k2Kg6hpW^XiCZ0QQL1Q@nohI4nAfk5iVKk?:a;hfZI0TVjTFg7na8p9MdOc
KSJF8k;YFmE>4B:l0A_]El8ISeOpJ`gg8S[q??6>[6\9N@pZ[4[g\^5No41I1;JA
g38@:j5LDdLQ8J=32kmq1S\adNkS<Dfl=f^n\NBcB1SaT6KbjnW@DDdb74G]^a]`
qn1=U6:V@[SL69QO>SZ>YSdESWemLWLgqD[:RWj_pJ`8BP8bqfN7cbgQq6A47LMc
9GYe\J7g4jG8=6G3U23`:TXe`5JqHE5kl15Fg_NHhF`MnR@EFjOf@CqD;PBe3jp6
@=45ja]<fmkg]C`f_a7S\Xm>3DZV=I6V1^SZ8Zbjm@3^G8h:k5Zq[nXV1X9;[]iU
8STJHXT1;`@9W2ejHN2@Q>EpWdkTRFO1:N1`AWN61LF888R[O1J<5<XLg3lKFf`I
0b9iGN^DZ:@LYd<q?dHA;]VMf4`m`OFeaZDZY`^c0TBk475>BXgoXlHIPUM0ije=
57UPIcdTQkd>g3hUh<AH@l1<cEhVHIjKlfGqe=^EXD8p[3D450PBmI=BkT`1J[h<
R?9qTSPBeBYlHZ2jO8J:T^mY@DI^gVWPSNEZ8c^Sii9VI4mQ=8;_8WSLV623^0>3
lPo00mEqlJ@5^JLdThYWOk[Ha1VPIgY9<0pgld2>>G4aCLlD^Mm>FEhIkdTCJde_
7ddmVS3j]mS8Wpnk]R<X@kU;6P5kR^Z:nh44>Ml\LaVZI@K^KVa<=c8?qXO1BHAq
ZF41>mUVG:BMCkS]_lCo_\@4L]H;]hIEkSp2DO>74g;oUX=g^oeeI;@g[Z6ZUU68
0d3>MB`:>q0KMRgY^9Wg=PdnF;]?;aT`9NJOWCckANlEHUPHfNhMf\pX8]_IJ;p8
k=ln`Wp9c3QOdGPj9^njEDU:h5=[AKfc1be=S:a6]`MbKSCda:Y4ko_In7TOm69b
\<eaQbBRPXb^2ADGmE[`4[78U1=\Xh[Ne4J15:a=CTjTUQkgY6:q0i3L:EMK`0CZ
K2HnH11`5AJ;MPG_<Tp5dY;l1q<[_YYN=qY]3MZ@fM@iG9^b@2pOkGOD3F7[o[6D
Dpd8RcZ61cZBfmLlS9RFHHX6SN`:5@D2>EI;dQmI6ZCYekpf>=TP9\7m<f\C5kTL
=Y3n6hiQ`^Ad;bq2=a9Wo[h;lnj@?0HS?`Bf7@KH?^qLM2Nfd2NWaSLOOC=`;<:P
kf\Dg<Plm0KqXA>A`m:q?0Tcdd[p1N8]j1U5\5dS2IFFW:TQdWLCo7oc9kXmC67j
e2ikTkELdY8GC[IdI`^CEQYj<P3S9folq9^YDGUb9K;0N\MO3m6B1Lnm4V=DW1[b
JJi43g9V[fbf1p2V0;:Scpc:XlZ0OQ@jmGTOJV;Q4BU5maR=;TG6U^UT[SpkC3i]
]aqDA^;?5Qle\7>LeMM]Y;nnO<ZQN>fYSf<qf3GB:^oJ\]F5T?eNXnE:LGPKiL2]
LMKE;Mo@a^UgXB2>hCG>4@am47LJhWkLnQ049>9QN[<W1Cbe^YlepOP9nM:;pc>l
UJ\ch>72=[Q_?nDmfB[C5pa3i=c6aeGHZQbDo<4aYe;cVI6dNRK11AXBJVH_SVpD
<[hj_nqO6>l^oBBa<_WT_Z4Q]U\bOLei[K\k\[RDeUSJ]mp9MAJA72pQ0^bg2q0E
YO]Ma`;fDn]G@lHFiK>OHlOVg87c=Z^VUf`n0dS?A>=?DSo8EAII0G`9:bL\ON4Y
TIaHi7og;1PDBGpKRcYDFLpE6TQKFbi?g\><IXLQkdRJ@Ea?dpP2PkXWOddTGe`T
<3oN\fkeBaMd4UH7X?Al^4T@`jUF5i6PDbi@o_K\`<R\XmqX0`XCi^VL_WT?I^Cm
;:5i23N1n0i<`5OdNC0bHFVLHW6MMFlp@i?c1Vi7p1KZ>PW::M4_MV2B:Rk8o5C9
LVcBC_=m=aJqQWY5ELg<nZjKK>W8oX_dAXnefCAKm74`9hS4a5EiR3V91fAIFl0m
XPpRl<5@[fMpF2@^H^3]Dl:aDM@hLa]ff4ll[dp>eEM`XPqi3He?@2NOUn5FgP;X
VNRil>4j?Yf_FCo1b]o<gY;_]G??=^QmNgkYko09AFXOg7nPHGqCMfMoa7pR;X<`
NfC0cVQg8Q0q;b3<5Jd$
`endprotected
				`ifdef M16G4_M64G3 //KyW ... 0624 : rev 3.3
				`else
					if(auto_flagx == `TRUE && (addr[`ADDR_AP] || ba == c_bank_addr))
					begin
						$display("Warning: Illegal command in auto-precharge command at %t",CUR_TIME);
						disable command_sel;
					end
				`endif
					`ifdef M64_M128_M256
					  `ifdef NBANK2
					    prech_reg[1] = ba;
					    prech_reg[0] = addr[`ADDR_AP];
					  `endif
					  `ifdef NBANK4
					    prech_reg[2] = ba[1];
					    prech_reg[1] = ba[0];
					    prech_reg[0] = addr[`ADDR_AP];
					  `endif
					`endif
					`ifdef M16
					  prech_reg = addr[11:10];
					`endif
					->precharge;
				end
//`protected
oh\0QSQV5DT^<J?`A^TTnb1RNH@J6M2Bh2JNSiRoVo<8Dh0<4H8DhG]`L?B2lcbG
DJhRJeoNlgp2?1LGa]eG]EogT;CA@B?28<`^9@O[ICnMDPaB2V8H2LPT>a[>R\h[
j?Ed?3MC0qBmQ8BJ<IW^jT<N\3>X^KmBnRa2cKZU6_51p3]bQb?p<<=naNIEKMf6
EMniECGqMQRKU`kU5\JAh2V=gQqAk87H721hQFC1hNLfZ<CoK=M2WfUN\I@5PZjh
hmJ3Y5mqV?iUe1LDCUnLKl[ij6Y0SO>JpRXg;PY4I0TU1M23@6?LcUnqEa?3]\1Q
<mNhYQ;`8KH<>g:cqM:TAYi[p98]ek10JS2`pdEoNC?nq;if2;UaNQCSePngq_MM
L7aWpT3gE6>8qUk<`lj_pI^?ie_RG`>DKE5=N1OKp9>cheKhbe_U3>0[[]9d8q[H
FE3o`mS^:c@Wl<Dg>d:lC@1:]>j_FY@V35aB@6AX\G]k1>XG<eR1p2M3_bC?YD3J
MJK:]V=OAimJZ>mqd7ncH2_gTWpU7^T1l0G?2fmlX=[Sb[5]Mj5f4fnmAoOZ<N06
mZn_I<:8DWaQjTAL^G3PlASoQ]YZkE979lL6b=JIlgJjham\fj>:H0C_lqRd2O4U
ap4DjHDK=N;NV@^bC^abSA<m?89ZU>8H]Lla32IZdOgIB::;NIZbRR@4_kkl8[2I
kp=4LVa_KplF;?hEGkV>VTfK3?e3_Xp_lm3\]a\mg\N]8?ogJ@KKU2V4=CaiG6k7
cqFoAn7KScA:nTHnUSE364dcFTLXPo1cdREca0E2pD>3_I[ej33XHER[5bL7X1AP
7CVL;QNUMHoV22?=Yp`Ph=FF6pM>5JG;7I4\AX@Xa>IE_B]ZdF?apoJdQlHK3YeD
\N=WXjQReAd8FWOcPkMIYJ3[iUEYfFV5mcd5n6n7JBoQ`diT\Qboloe_C<=]HX?a
I>M``nE\Fp2>OZ1P;q5G;X4[6TVoGn90H^[W`[W8Cl_2P92lbf:LWm:@Uqf?J>7i
g3cmjLb]bl=GCgK>neN0nGQFCqA0KO`@Zp4j\d4EZpD\J5L0k4U7pCEeC0ZhL0ld
5U2d@WnIlNZP\g5F[^kQN2Wh5L6SAe]lI5ljkHSe_n3jLo;>WUhD?pB2GDANIXP8
;3I1maTfdJ:InCLdOGfge\j88lEl9VDmWBOJ^JN8aWmc7a^>=4AQb[LIdZI5\;NX
K\=JaLoZ4GbYn4cjEX2PqCGYdiiTq>n:`e?ep=?hG5Kcp74J?RTj[@DcVdDZ9l=?
Ucm]K=4kgSQU=2nQVgLL<p?]lYZTd:Kn71Za?W^N\jPDgpb6aGiV0Hm\SC1>L02\
QlAN3LDh6F522^ZT??GPo6fIki_Z>AbU5@O?iMD]Mgk8UL:?Hdi_MAo\o71<31Ci
;j[Sf8TBFRMPGFB@C`V5VA>:437aqD5AQEUcpdmWMh3Ze1@O6JAi1fOJ]aPnKKoY
Sbc>oVXq=1FeBnh[WQKKa[0q[AB\CG6qI?b2ZNgBbPG\S[fZg`g3U<oT[:_aXf`k
F`F=b>bME1kORgjNWfkCkXdl::Im;U<fOESaRNFRbfXJPip>W;a@4^pc>BM1_M1F
W1ZD0B;m7AL:=X7VPX[Uh^N9WLXgoq64dg=dj;70l2gf7K;LVGq:WST1OCq1k4eM
9Eq1hN<1UDq3O6_IT2B7oBbeDYCch?ZBDb[jX6Ekle<9MDP35\[^i_RjPZC87iaJ
O4]6J[PS@HHN>nq3beFWAeR[]8hGg[:OgGjj;8Z@IR49fMm3AU@D?S1Nk7Vl[]15
`X`TbC97ImGB33gN<6M8O05N_U5e^A3gjF]lDqlC_E@JIpbaOR8ajYOh8nW@0_g3
3@:U8F<[Zl[5H\gL8qf>XelLHqRN2gVaFqFBYgA9QKB^:EPn\B\QV=4^qfI\nY[j
;L16_PhOTXQiVa?pTFk?h8h@LiDHKK4dgOKaY<EJo9D1qH2B3T2@p6LUB^Hac\UX
kajVkQCTb3BC;Ql8@k16V4TbpQJDY8m;nT[;87WnHO3VHSLgIF<RBB`oZK:2nAnY
h\UFUNnj?0NA2Dg@XfBpe?_V7\KUacIi4NnV[G[3Ua^VA]HdhkM;cZ@0IZ3FJ89X
TE7>HI7GNc;cIbfDoaOA9KLcYd>IKX;pR=fDhOcCE`oB]G6?E3C`AWM4Acn<Bb;@
qH?8GMLcp2@m6bE^<I7Vb26;4pHRUdG_GpfbTT1AE>IP@KnN>8LA595?;l@l2aC6
37M`FXF6S`Hdh]^KPC[WFeQE<O`WpH8fSI3NH8IT2?b1PY`KAP<o0oSJ`C<XPf\h
q@FNY8FXGTLNNXm6KfIPIRObbf]UFq17@8hCAmk]7aKRD7LW]N9gKMjQ]?nTg==3
<1_8?AAP3coeIBgcl0M_6=PZkGmka\1W[O]VC<nHefhcmAJLeBj]^Wd6Ac?Sq5A4
X_M3gO8PB[<eYF]LA`hU8PU:ab55TD86eo?H71\c`GBj]O3h_2@A_7]K9XXdTXLn
Oq^I152eTno?GnMg2fFO]<aSn0KK<@nH3QMllY:G\]EWWCE[<gKYc\O9VPOkX9hl
]XfNjKC@QH4kS5648nIIqKm3ibBna^kO0CDR=ZLZmX6D5Jma7kJL2P8kc[FDLUg;
Lc;8J9gHZfkN:0Zjo\1doBAqYGP:^L=Rc@[lBdc:IiA`CORVeTYAf7pAYBQh_F5l
m[K;\l8@ECYaiHh3g?0:>pFJZHfiWpQ\RS^XCUk^>bHQIan?p^FlQFbYp;Pk5jMA
XI<M:5bhCIVL1O\j7c?WS:RTmBD<p<CL`T>:ko0\;o3DgdQM]^>TF^=BPJ`3VGmG
XQB>co[JAYREm`OIcU1LAP6<8?aWgWdLkoSJS7_HqPF<Tn9P<N:H5B3MH00eH[W?
SqZ4LVhalOBFhFfWEM1cOE7Ef\BAF0g@a6kHniNQ`D4oJAL7>^QWeb:QYD_Bq44=
Y>mUo00a7c8S1WAU8gXBZEK<?IRZY9]IVWDBaTT?:B^IgO\l=9MbmHW_m4Li_FQ8
V;:k][_PDe`4BV<jj`1Qq6I7bUQ_iNA4Ll:W89_D;N;hgCi[>o@`q]hDCf`>qOdU
`b:3>1nF@X8cCdOV?2Z@BLUAVaDK0DB:q^d\^O`Ep@R\@7Il`;NJ^>ghDa\hl>2<
VIR1hgDo@V;H1liB;a^A?f=?DK\p=@RRo_46j_F5<2f9M\Ca=AMR8CT3F0fcX6<p
iFE8XbVI]K4T3dF4jBBMdLMVo2YeGcAmZQbI?90AH:oVMC<lJETJ]lqkc6h5D[[A
`F;0`T^bk0F8b=T`?SjGj84jbi8iC5MMNCBCB[19H?QCk=TkS:dYll[`G3^87@KB
;BH[R8pXFASlW>Lieni9i@ME:c_cVX>Ho0lPKBCIlbZOoh9emHjOk0KNn=5F6B5j
no9;1?:mk??fQL\]oWm>iQXi7Lp7CCBE5BDQe>H<ZNipEFgiBK\1WJ>M:T5dGU;h
UgaJ1>AgZ^Cq\lJP]7VQHZhI>N1]C7ACNY?aQMWXWg1qQ\H@O;hpLVd5BYY0IaGE
lLgIRaUIKP1GI\:>6o<J5O@q::G\nGS0HX@S3^HcLDLWT9KPYZ_nWH=IR<@kL2[;
SMepbaFc@ZTqBmFh:?T@aIP02SHlnFYcO4=ckWQm3\]en5Kp]dSJ:kko:cd4PmiN
RJSQ3nG^G9720l35=dA@9IRhS`F5j5SPamD^FMph4<[Y7TB3;Z2UU]L:bjcCW8I1
K_Tna^k;3JHJ>RKIk5n^DRhnHb9D2RRRjKP2SMW?HMMOK0JMddMbdbqD2AAW46Md
a=h6[@Wlh^a80j`M9h1>P=mn_>dFTYC6=3JnUN[k8i0`lb3^ISecYkekaX]]gEFY
A;?N<3Wc?=q@81AQNQc@[S]P5kMp`=X[TZ[MmK_CofBoq[Z0Dg4DP8\WA8J@]T1b
N>gD:G;dYI72pfFWkIdcFX@b@=[:i]IdbNQPGke;JZbEplOn_NaDqF8PTaIL4DF_
o]I>`mANT=R@X>G5C7L`mq:K_@mfGp3TA`b=eGXN51]C=lVd:fCPZ1eRQRjJhf16
Dp2cKn8jmS8>AciiF0VTqAYkgICncXZ?RU>6d]S652bJDm_m0^_7SAQdP>j=Llaq
HjaMIalkB<5l>YEgkE5`7[\d11KUOH9`<lKF5?;jeTVA\MZbibWK@CYdfinU4G:I
OgoGqAej9=ZLkkP`Z]VEig\ia>B8ET3_=?L3FU8NAF>h3UV9;Ee6?5DKCn>d3ila
^B:8HEo\3Dg1Hm9HAhamgkIoU>N_DMV]D]H5?4Y[qPYXZQQ]>V7;jIHOo?CKd3Df
em_>a8Q8L<5EeZmnBd^_nnh9CoGg87_`;R9;XdXm;2L0dN;18O`2eGHTI<mqO::?
2E>@N0A3dk9cHLKdI4\:kEXaFlpDCcQk?Kqj638AH7[HCWSPj^henGj=6c;`NGZQ
<9EqF9:AX^4pI]O\NoZTH5=BYXB:VQi3h1UKI<IOGEVW>BBqM;XnTmZ@8BBO0SFj
AS7U`]E>;Yc?M?Ql]8IZq^YS8:ho25:^a]]g]<=W1mh1;HW]RKV4;OiA>;c`P58?
N^A:`S_24=BqZkHojj4XjUAaX:g=NIaF6>:5dR2=ObN<]I_9b3>OTVYh;KJWN`X=
_=TiI4Aed:86b30ZADd83B_\;9EqK]Zl^hdW5e?Kj:B_X6IQ_Rng>eGmSchRAcQ6
dW5Jeo<hM2S?c:E[Hmh[D3PSDe6@H3`RGYFPGQd>cm4\=[pd5[eb;nF]Jek:C7po
YKk@3R@]LM:o4aikHojdkTmcjH]fip?I@jO:bpBMgnlkjn?o3OLe7SZTQ7IM72Bc
I:qO_E<O0MIAg<VC03GfPGKKNJVDSR>880dnID2U2lCa8kl_nBM``UV[c5C1bI<8
m=:6Z;>qNCHSmLL4V8P[WB6QV]L`jjY[5gZj@ap3X;h]inq?OaekhifiYlYj`@Tp
]H>cXD`qGmFUdL3FA1l7JmZN>Da0hd\]I=Tpe02k^Fd1DmR;V::lFGdVHZ\XpU>9
Q_9hp]MOD5dN1LX_^i9Mn\O:S;KjBfmGC^ooXjIHqBdnV6@Y;@oC\`hZAA^]TnSK
TPKP;AW9D^>GaLCC9CMoOJLl7]Gb:j25gKop6ROKaack1VAN\mhRBST19Wd77cm@
=SKC;Z;eH761Sh[o_iFmMH:]ZRdK5=JIOO43eEafXDNUgj<kYJ4]LoqZEK<@_`pC
KS66alc:BC;h4n`g]I[3VH>P07Q9<p\aeCkT@`SZh>6M@cYT`Lf^8>M@N>1FDR<m
M8JopU?d8K[JpJj7d2TOY=heoTC<\;W5pODBO^RNEOI7:Xf\9`jcmk5cJomlL?gb
=FWSp7fnTNCc1HXJGbIGZ732=8RK7ACEqP3?mY?\I6306OW>eId\QnW9WjLliM5j
PMWIjg2PZ1:ZAVR]PkLb`RBmA`7aCqG_iOhX;nn]4Feddm;TUXXTfK:eZ:5A^U7]
VTfFUHm<13G9J<lQaPT[c2Eaa5BD>S>6cFoh?fm]\L=kpE9MJ47YS_dfo9bPc]KN
51Vc0ZK;p0RH:M_l[ODgbFD_BH6FeG9lHSgPNVS4WNTOf\GN5I=A0bPQ>WOZ1kJ2
>UHZZN;_b^ZT2FXU1;M`Mb`E1=0Z82hMibaBep^:62F6:<QDX0[hc5A0URH4ZZlG
e[;bo>b];8=72aAaFeAeIj^c51qj[eZ=>4qg;HGYSpSgb27hq4QdUl^aqX[mTkT[
S7BjHLbAP`LcN>dA6NIJmpn<onTh]NXod;edm?^c2e1Y<UpMQe3OPcC;dh^o35o\
LB5cU2kYI=dd0KE:i^K?GQRKfGek^\c76p5gVbSGWSYLE\cfh1;K85CMD1jDp04d
8a\LqUB`iCDoI:?h?SZMi6F9CA[ikTmFPkWhfHdba1?;oUSol?iIK<TE[JAbqiY8
?LRd=>OOa2VL3YiYT7HJAg5>cS?Dq;lEd2Z9pb2hjKdjZIXbEGhT\RY]=JcD8IEM
:TKC7;:RNJKh]]0]_qhZEa`ocZ3bi@d8:^`WTX9lEjTYLophcfKeC3pfOR_;K`qT
Wm<[D<p3FI_ZM71o@E0PLIhTC11L=?JoRV1KSMqf_UHPZ>p]<FS33;CThGIZMG0D
Fg@0[6_cgD`AU0qH=aTf5e0<`[I8K7DZj0bGilP`1<qSah[M^<7j3P<72c?HGN_m
EKDcXGHXZW_p7L@aE;=oL9^8na=_57OO1gKcjODYg=qM0EmN1F:fSi=SNkB9LG^B
?ej3bd?73RQk6FkQG=[7iA4?Fbbj9d[]HPEbl98Maannk6kKh@SM7qlm`2oHPd`g
^I_:0[V@QBM1C<dfChn\?ca^M0060AD^k?RH1gN^a2fPgAcKT<2FDb[7GpMD?IRA
[pNFnQdDCpe3:l7N]qAJCU2I0o1Z0H;Hd8WM]C:e?2A:O3a]AGQjg0m5[odV_B_K
OM76CiKfWTE=OD32@eq\b5a\0k1lg;8<Rgb1JXGKnqB9=3APPobjIDL7U>Bb:<qi
TR=I2GdgNU`BN^8LhUMJCWHW9FEK@ggjfU3fh=o^KU8_1qI4m5_BKO=PcUTO0?Xk
N=BNZVV=U:[EG7j9oDcj7nREdk8C<00VQ5HWMg=V3>LUWoaIiqZbEh>H6pbXFNFX
CUa@YE:TRg9f<?mTbVGWUX2I9F7aLll8j7AWX^RA[IZNE_U23QCe8g8>1`c91VkA
GLgO@f;nCXJo3RY1Pn0O0OW:H6Ei7gL`8[D02VqBQAVOGS\4nF?=;QM`0ZpWI7]S
mhpc]<mc?Q\6o^3a_^T[c7al=bSd_EYQ@oZqR`M2A0?5[X:l<CJOA61SU`Um7?38
T=2P`@coPo_9JDOhSiT8gb;=00FC\deHnaaTo:[X5@70p`Cl]^3Rp`9NYS2lqP]Y
<a45`S`N7BRZfG0VBl;nmj?1IeUGEi@h>EJoYOiX2abYlBlnF`F=?Fm>0oi3\:L7
bjCRSH68PI:MJ4dpnlbfD@i8aW<ZO=WFQ:]m^UAm2Yk7Ol=AJ@^DHN4?lc>g^3XM
6F]1kh2RNmd^N3\;UJhWP?>p]EGKO[YoXNRCDcJVJJjqCR\8ncLpf0h8nfV48bd:
E5^]2hU`BFiY?>?M5Jq14dlm]0p133SO?E831K;f<YopK;77WNXpk101FZIjaK>e
FYfL\?QTE;6ML4UepJBOF1n2Nik]Y]X;jLf]^YO>1o=?JXEX3C7<?>2Z9oZZgq6@
?X\[9TM?F?O<g7Q4LJqQGRh3:YikWCGZGUD[m>pQ6Eh2GO@mIg63d3LTiQgpjL9R
cLb?JDZ;1PLYAad9KYV[RK\n\LC>4\C^9[]AWekTdaEBp[kkH;YBp2NO5`@Hki5b
04h@7cIBGqRL7bH]dYH`^;fKV0SG`Ji1K6nZfD?=5cC?iPQ_\Vn]^06ZL7nYqe8P
4YL>EV5o^mKVM?TPp<?j6QX:AdbTKBTJHcbZcp@FO@[GQQ0U4;joA\E6e7=2k<=N
d]N;F7I<4T?RdOoAnX9mYOqSHa6[21pQdj162bGhE=QN1IW6]2_q@;a[gcS5=]m5
:RK:g>eqdkgBmJWCWHM<AWMhH>?Zq@TWSg\HMo5Wd_;bSA\Q\pjgdJa\OFJi8hjo
EO29B@8Y91jS]Cb^3T?lUe<DVj5CQJNF]PpVBmaKJ;p[>Q?0eK2YbScC:nb`f7T>
bG5pN\V`=g;gl3cneVUl3kZ6p^_^YZA]?b_Y:K<HHUPMqXcCHg20WOjaHOeQi>P^
oqPS9@Ei[^8iN5TVjbi34\jOg13]d@K\YO]I1kFHHlJ81a]JNWpgNjM3>o2N3ZO\
Mi=Z?RA8cP`lGOU`jBVJ=FVSRXCdQNUJ2HV0K_O0FRd=fffpIn8B<8IpEShgNc^k
DPLEOkm?inCkpM1i<9N8:dBgm8hU?27]>;Vkb[RTNp?X6KXIgY]G49JDj@W9535H
@k6OT3`lpO=j=S1[=WC9\;WRo@Tn\7^@MaUCH_`b]WbD<P5JUMii1C2bj:md9860
BX_JQ3iVVAkpRUSlfi`p>CW8S>FKb_@fj[ib]DV?@G1_^gLZC@C6]<4Q\PR=e1^i
acE8kFOZ`F>V3WKQToXESWpMc]=JV@$
`endprotected
	
				if(addr[3] && BL != `PAGEDEPTH)		// burst type  programming
				begin
					burst_type = 1'b1;   
					$display("-- burst type   = interleave.");
				end
				else
				begin
					`ifdef M16G4_M64G3		// jhkim(8.14)
						if (addr[3] && BL == `PAGEDEPTH) begin
						    $display("Warning: interleave mode does not support Full page Mode");
							$display("         interleave mode will be changed to sequential mode");
						end
					`endif
					burst_type = 1'b0;
					$display("-- burst type   = sequential.");
				end
	
				case(addr[6:4])		// CAS latency programming
					3'b001:begin	
					`ifdef NO_CL1
						  $display("Warning: cas latency 1 is not supported in 16M 4Gen. & 64M 3 Gen.");
					`else
						tSAC = `tSAC1; CL=1; tSHZ = `tSHZ1; 
						if( TCC_P < `tCC1-`MARGIN )
							$display("Warning: clock minimun cycle violation at cas latency=1");
						  $display("-- cas latency  = 1");
					`endif
					end 
					3'b010:begin
					`ifdef NO_CL2 //KyW
						  $display("Warning: cas latency 2 is not supported in this device.");
					`else
					   tSAC = `tSAC2; CL=2; tSHZ = `tSHZ2; 
						if( TCC_P < `tCC2-`MARGIN )
							$display("Warning: clock minimun cycle violation at cas latency=2");
					   $display("-- cas latency  = 2");
					`endif
					end
					3'b011:begin
					`ifdef NO_CL3 //KyW
						  $display("Warning: cas latency 3 is not supported in this device.");
					`else
					   tSAC = `tSAC3; CL=3; tSHZ = `tSHZ3; 
						if( TCC_P < `tCC3-`MARGIN )
							$display("Warning: clock minimun cycle violation at cas latency=3");
					   $display("-- cas latency  = 3");
					`endif
					end
					default	$display("Warning: Invalid CAS latency!");
				endcase
	
				if(addr[9])
				begin
					$display("-- Burst read single bit write mode");
					WBL = 1;
				end
`ifdef NOKIA
				REF16M_MODE = `FALSE;
				REF32M_MODE = `FALSE;
`endif
`ifdef MOBILE
				REF4BANK = `TRUE;
				REF2BANK = `FALSE;
				REF1BANK = `FALSE;
`endif
			end 
`ifdef NOKIA
			else if (addr[8:7] === 2'b01) begin
				if (addr[6:4] === 3'b000) begin
					if (addr[3] === 1'b0) begin
						$display("-- Partial Refresh mode (16M)");
						REF16M_MODE = `TRUE;
						REF32M_MODE = `FALSE;
					end
					else if (addr[3] === 1'b1) begin
						$display("-- Partial Refresh mode (32M)");
						REF32M_MODE = `TRUE;
						REF16M_MODE = `FALSE;
					end
				end
				else if (addr[4] === 1'b1) begin
					if (addr[2] === 1'b0) $display("-- VREFi is set to 1.4V");
					if (addr[2] === 1'b1) $display("-- VREFi is set to 0.9V");
				end
			end
`endif
`ifdef MOBILE
		else if (ba[1] === 1'b1 && ba[0] === 1'b0) begin //Extended MRS for Mobile DRAM
			case(addr[6:5]) // Drive Strength
					2'b00:
						$display("-- Full drive strength");
					2'b01:
						$display("-- Half drive strength");
					default	$display("Warning: Invalid drive strength address!");
			endcase
			case(addr[4:3]) // TCSR
					2'b00:
						$display("-- TCSR (46'C~70'C) mode");
					2'b01:
						$display("-- TCSR (16'C~45'C) mode");
					2'b10:
						$display("-- TCSR (-25'C~15'C) mode");
					2'b11:
						$display("-- TCSR (71'C~85'C) mode");
					default	$display("Warning: Invalid TCSR address!");
			endcase
			case(addr[2:0]) // PASR
					3'b000: begin
						$display("-- PASR (4 banks) mode");
						REF4BANK = `TRUE;
						REF2BANK = `FALSE;
						REF1BANK = `FALSE;
					end
					3'b001: begin
						$display("-- PASR (2 banks) mode");
						REF4BANK = `FALSE;
						REF2BANK = `TRUE;
						REF1BANK = `FALSE;
					end
					3'b010: begin
						$display("-- PASR (1 banks) mode");
						REF4BANK = `FALSE;
						REF2BANK = `FALSE;
						REF1BANK = `TRUE;
					end
					default	$display("Warning: Invalid PASR address!");
			endcase
		end
`endif
			else
			begin
				$display("-- reserved for future use !!");
				$display("-- check address: [11,10,8,7] = %b",RFU);
			end

			`ifdef M16G4_M64G3
			  MRS_SET <= repeat (2) @(negedge pclk)  `TRUE; // From 3 -> 2
			`else
			  MRS_SET <= repeat (2) @(negedge pclk)  `TRUE; // From 3 -> 2
			`endif
		end 
	end

//`protected
\]8RZSQ:5DT^<ZNX6e3HglT:Z4apj[@IKL:44aI0kj55KF:VAK14cYc6XGoRAOk0
^[@YXH`gSlXZ_Lm7q>fQ>4jh_]Oc?MGBi7<AJMLb62RO[OA9>IMk3OM[YkU=F?`E
bcE8@ilp=;1VS4pOP1DC]II;aP6Of1BV4mdpXO6e0VLjAJg9IQOE3MoGI]lNq1Ri
0RKXmkNTGh4aXCB7`qm;1PW1mdC5dUYFdcPcUj9>GhZ7\EC?^:m^qZFJ7ZDKgN4o
PZ7=Di[;3:<fUb2jJdXo_O^\d2dW6ZMKL<>HL4MVFcAZepD_DR^J0qOZo3HXQ8E^
T06NbnECf7NbqVIT^H\n:beO6@K5CchVTVbo5<:FGQNI]>5\:X@VR?6lVi3ge?U>
gn6N@HKJR`PDn_><;G^f=MmKFqA@M9lfc?IIEYlFDS8Wf8e3bpbg?LM?aq>1_MQ`
D\1j>Bmoc5`TIU:GDFC]M=e_IqE8e]nR4Q6Y:2aW^<i^RHIHFZXI28Z69RDLJ3^\
b1aEHp<\Y;`hWLcXMWAKSoK3gNXmO4Tf5`5_i7m1T1pB_b[`:p?H3nh2^X;oWR4@
QJh_ja=XnPcV1m<>4V[l_d8G5jeJ1M>bQc58kYZITO10T17V;BK96IDa1U9n@L\c
6LDj:KKNQp7;cUc?]N=9AmW;EN]Q;FkXTjQl7GUVaCe>\0@GOZCGVZSiMo1UO==f
GU_;=OBjEQcKH^6[NQ7Z[^PUdkPYXqK\@2>ZB`LY3BKD?6enO^ADfh`<pVeO_T<_
g8YZh41VMmGWZYNZG7LOB1Dajk3V^5C7ecWnV:f]DFgU3eJnD_V`5_Q\TmdbMabc
7nc]nKC<;21cqcFA?dh6JkZ`lU1?nZ:^KCibcW_I>5Jn9DU3Ko`^FYLYH9?SPXiA
NM^d2QRa?MKi`cE=X^;N\YidKSiTJYoqk4Oj8bUq>5@]k`U@j_1;o1HFoY@D=Xh6
W=k[l1IQebG;eB7@U^]65M02idMKe^kmR\OnLm:B5P1V0aBTiXZpLc=3P877XMi6
YE9Pc:BnAdjq@_Y_9e4q3P9;ZBp^\[AR_LdLF:KS6@fLZPXTH259PKn@T7o=laPO
lZanaXdODg0COCinj\A1SMh>cHg^0[6I;[3^fh0GdKkgY28?hk[qNN8gf=49W0nH
P:cnBLe\H77__A`9k@6]7TVVdQTdL9WTD9f>bQ6XeM=`1no0j;CnNe8gS7fTkYCb
1a[]DGGdp0jcCKdi<3g^OgMZ2E?qN53Xc?KdQmYKEVd]U5PhmN1d>\>jWM5;bAQa
R<:M^^8?bEC;iKN]5d\EB?fnJc=<Nc3RM66;ckCZRIkZFDB>p`b_Zk?S1R1AMJMI
1W1A=42Ca8McMU3;\gSebf8BRKPF8Q5nXU?jlkgRH]j>1?An<>7nFYJeQ@53F`df
9QRKq`d]TgjRp?J;enU2A934mZ7F]LLhY`hoKlTm=6?=aTFUA@HkN6>2SkbCiX\Z
G=[gm4`I]fQ@Y58DhR>=`WkjpKGIJ=Q0jc3g66eFTKn7U;fVpb\g42nIqklDP;L7
:XSU6bIW`A<:_LllFV`7T=Z\l=cB8l9aFaOdFlOf6H7=2^`nVLk^\^@GYiApUJO1
8U=BLJ5=5;\3?Vc@ITbR6YWKe[DC8L4EIQ^gpCalL>bFpkMhCk?\0W4hB@UE3H7>
IE37o5VIM3;:H:\M]OUNa^1[l8NfVjQYH^D3>lnXUkdHVkARaMd[YUiUg?8boK7K
F2?TH7_RIB7G?coV@jQ:7>[XHk\?_d^p1KC5>KYpjIB9O\\qAK>Je3ibjY1]RddL
MCG497^6QDife67W@`g0c7l4S]^[>TSp@jg_obJp?C=[E5_A]Na?MI2D80^aiKN>
<>_^ZYBmn\;nfJeiqBBTlEMH1VH5Y4KD^U=h0di?F1e[04S]Z3mgaPKl4FH3>W2:
S<m3H8VQ9957ilc\L=fS:Khgi9A]I:fcbqI[agA^Fa[;S_P[I33VU@Zae;TlNjS<
85<HQE=^;?R;A^gc<pokVYbXcpWY6=Dlp`IU97?GdS2W]3O2BRl5QqNWal^PCH3f
hoWZFaEX1GOIdNHdnnFBoh<?8`;e_hDK^pg^Sao9R_\Q7YcXEYjhf]0OcgVm;o\F
Xoh1FJTcDR<Dnq?mVd1]cT<LcIc?:NFdAEA@eBoP9Id0gQUlQGiGAW7=Yq;G3A[C
UM6[F8L4hJO4jAO02CR2lI71[4[2VQNgCG;5E9hVBYp`[NY06Ro6iGo^9cQoYUKN
QkH`3f^FbN2k==e0@;Pfh[qOllkYgGpdGdKJXh]79TaZ]e0`]3mBVm_k=9\keR=>
jV4L<D?l^k;[7hQJC7dHjU>i=53qJ]aRC\gq82A[XMq?RkUII]U;io>6M0`Fhc]p
>meY[ll?PR:i1;[WL@@fUiEGY5m;CUe?a\nKg9cI=cRqG63gRTCif?If[:aob9eo
WLZ;heRWgE[<egnPM3]`HJGq1:XJi[:O4DQ?[hQ>GX]8g[EF^N;JL=;aq9Jm3U>f
5;<GdoD@46Jij<i>76ie<EflnAh;AD6l=IPKq4WS7ObU1cQ<DFE<9@NP57Q=hB@D
ATiVW;gfIN6XUSTTqJ^A^bE=piUIMP:EL_<QVa_6>AU?SJN=ea]bYH<g]qS[iBhJ
`p`_@RaMBY]==hCmXe?9pR3gkOUa\F`:??Pl<WMjq7@Xga6kDT=PFLXijaA^5DNd
eqS_7DmYg`BYU9OZn^T>V_qge8lT1RP@nG@Y^YS?`HO@OJ?@dhZ0=QAUmq\ka8Wf
U^kM2X?CVRK8f?n8mBA>nB`d;R>Ni3>VT]d5jkY9N9RL_`[YWSpBojDkT[W_2VBN
\HB[\a]e=;eC5;lbDoEFk@_BAE5b8UXlhqVihG_Z]qnOfmRQ58l?`UF6<djkeYeV
O0D7gg_5nc`S?jRDRE2<f4Mg3]]QfCCY_<:@95EOVFM6m@og81NJZ=q^nj]=ED`5
5TgjDECS_A<gIb?pPI54SmopnImEeEgA5YZ:?ISc]_1iqWHOR6`a;0o<l]dDS]XQ
\o`onMlJ`inSh1o22f8K4I7ZOWRV=\kCGeoEJYWmZ`mRkL9g3nmN5p79XMLdJAYh
beL2hpPE:?gOAnp@R4:Yen8mjG[U;cARLcYqKH5O;0P;\MUG8>3:N4^Ia4MHh_9n
d2\DIPl>Aba>69IKcZH;lXY9P;TOHWX>K7^BG8p6Q`7X8M]pEj?f@a@N6YbPEP73
@1g_^]907HjpG4:FeM9J\1j\Soi5K2iK0LaPXc_nG3ELaeU]L058h8Wq_648FHk3
=_FKN<NXULaAaMTgo@W2ED01TKAQZ3iN`g_OZHJFmNDFU3V3]@YG=H1_9^p?;3ae
;\SqX[J`;[3oaG7LWVG;6H_K6eHRMSQ5]McU7fIKIGqc?3mE]SGqX;F]8kB]qM_h
[OF`RpCLAJFiEIhVOooD]BNNiloMY9kU3OaZ>UDaiW=X^f^Bj=[g<bN?3HDEj8NQ
Od2A>pG`0Gn812_YF>5:VmagAANZK3V8`RQ8<q4_3;dZE;YH_YV1`\3LOY=k8kiW
:b<h5b<nBZDQVJ2Xgpn_@l\jNP1>2k:8h\^gmd32L>d]RodOa^`lJ<qE775BSqhQ
o4D6lRRR@3HXX]^[ATVh98;[^c5N>b;Nak\NjDJ:[JoUG7GD1mP;OieS0mQYDXT[
ID\No?7^ej@Y_=HeKW9UHE8>p0a>BO_I6]g8@i_4[dgDV:Q7fNSV;>6=XbMBPH?Z
QJ\GmcT6a?3@3SK5WH^D\mOh1aaEcBTZ6^kbmN]S5><\EAEpM56\4j3o0Mh^;D`G
dg>h@kUngi:SMhEQAkl8nKdTAlR5j\P;^nbhf0<k8I`4Q?Jj^GRo?=0Xo><Eg:f0
k\FVjbpnEkM?ZKM8ak_[;D<O<^g@Sk:lL@hBTo6h=c5D=1Vg`SG0c`>[^XH77YL3
?;AoAHPnFb>f`Y71GI>`^\8VZoEpWiBLZKhqcXL7NHE:CS?00<Z0BTeF:1H]MRgO
FP?ag7oo?GEAU0RgW6;^<9i]1>kOq\4bj4JMg]A23@4d;6AOG3RQPP<nM]>c3ZC8
dXk>^O:lYSk3IZD<i<a=fYT?OYLXj:igc@=8`f?45q3JWoV`i_ag?2eW_XeJkPRF
dQp?kcX2_mqPSR=9jGOhE_m4kUHSH_ZV[oP_T<Lc^7kJXTGU0Ado>Un$
`endprotected

		if(Mode[bank_id] == `TRUE)
		begin
		    if( addr[`ADDR_AP] == `TRUE)
		    begin
`ifdef v
		$display(">> read with auto precharge(%0s) at 	%t",str,CUR_TIME);
`endif
				auto_flag[bank_id] <= @(negedge pclk) `TRUE;
				rd_autoprech_reg <= @(negedge pclk) ba;
			end
		    else begin
`ifdef v
	    $display(">> read (%0s) at %t ",str,CUR_TIME);
`endif
				auto_flag[bank_id] <= @(negedge pclk) `FALSE;
			end
		end 

		else begin
`ifdef v
	$display("Illegal Read %0s is not activated",str);
`endif
			disable read_block;
		end

		READ_MODE = `TRUE;	// read operation start
		TCAS_P = CUR_TIME;

		m_addr = {r_addr, c_addr};

		if(~burst_type)
			increment_read;
		else	
			interleave_read;

		`ifdef M16G4_M64G3
		`else
		  if( auto_flag[bank_id] )
		  begin
			if( BL != 1)	
 				auto_flagx <= @(negedge pclk) `TRUE;
			->autostart;
		  end
		`endif

		read_task;			// task call

		READ_MODE = `FALSE;   // read operation end.
//        last_rw = CUR_TIME;
		last_rw = TCLK_H;

		if( auto_flag[bank_id] )
		begin
//			rd_autoprech_reg = c_bank_addr;
			if ({CSB_FLAG,RASB_FLAG,CASB_FLAG} == 3'b010 && bank_id === ba)
				$display($time, " Warning: For actual device, this gapless command would be illegal");
			else
				->rd_autoprecharge;
		end
	end

/*
 *-----------------------------------------------------
 *	 WRITE command									 
 *-----------------------------------------------------
 */

//always  @(write)
always  @(posedge write_event)//KyW ... 0408 for VCS
	begin:write_block 
		integer bank_id;
		reg		[8*8:1] str;

		if(CUR_TIME - TCAS_P < `tCCD-`MARGIN)
		begin
			$display("Warning: tCCD violation at %t", CUR_TIME);
			disable write_block;
		end

	`ifdef M512_X4
		c_addr = {addr[12:11],addr[`nCOL-3:0]};
	`else
	`ifdef M512_X8
		c_addr = {addr[11],addr[`nCOL-2:0]};
	`else
	`ifdef M128_M256_X4 // 98.6.30 BYC
		c_addr = {addr[11],addr[`nCOL-2:0]};
	`else
		c_addr = addr[`BIT_C];
	`endif
	`endif
	`endif
		c_bank_addr = ba;

		bank_id = BankSelect(ba);
		str = PrintBank(ba);
		r_addr = r_addr_[bank_id];

		//if(CUR_TIME - $bitstoreal(TRAS_PP[bank_id]) < `tRCD-`MARGIN)
		if ((bank_id == 0) && (CUR_TIME - TRAS_PP0 < `tRCD-`MARGIN) ||
			(bank_id == 1) && (CUR_TIME - TRAS_PP1 < `tRCD-`MARGIN) ||
			(bank_id == 2) && (CUR_TIME - TRAS_PP2 < `tRCD-`MARGIN) ||
			(bank_id == 3) && (CUR_TIME - TRAS_PP3 < `tRCD-`MARGIN))
		begin
			$display("Warning: tRCD violation at %t", CUR_TIME);
			disable write_block;
		end

		if(Mode[bank_id] == `TRUE)
		begin
			if(addr[`ADDR_AP]) 
			begin
`ifdef v
		$display(">> write with auto precharge( %0s ) at 	%t",str,CUR_TIME);
`endif
				auto_flag[bank_id]  <= @(negedge pclk) `TRUE;
//`ifdef RDL2
				if (`tRDL == 2)
					wr_autoprech_reg2 <= @(negedge pclk) ba;
//`else
				else
					wr_autoprech_reg <= @(negedge pclk) ba;
//`endif
			end
			else begin
`ifdef v
		$display(">> write ( %0s ) at 	%t",str,CUR_TIME);
`endif
				auto_flag[bank_id]  <= @(negedge pclk) `FALSE;
/*
				if (auto_flag == `TRUE && autoprech_reg == ba)
				  auto_flag = `FALSE;
*/
			end
		end
		else 
		begin
			$display("Warning: Illegal write command at %t",CUR_TIME);
			disable write_block;
		end

		WRITE_MODE = `TRUE;
		TCAS_P = CUR_TIME;

		m_addr = {r_addr, c_addr};

		`ifdef M16G4_M64G3
		`else
		  if( auto_flag[bank_id] )
		  begin
			if( WBL != 1)	
 				auto_flagx <= @(negedge pclk) `TRUE;
			->autostart;
		  end
		`endif

		write_task;

		WRITE_MODE <= #(`tSH) `FALSE;
        	last_rw = CUR_TIME;

		@(posedge pclk);
		if(auto_flag[bank_id]) begin
			if ({CSB_FLAG,RASB_FLAG,CASB_FLAG} == 3'b010 && bank_id === ba)
				$display($time, " Warning: For actual device, this gapless command would be illegal");
			else begin
//`ifdef RDL2
				if (`tRDL == 2)
					#0 ->wr_autoprecharge2;
//`else
				else
					->wr_autoprecharge;
//`endif
			end
		end
	end

//`protected
UB?lkSQH5DT^<H?1`Vi2icebk0ibOP0:mOHnfb5Aq6TGd]<Ym\Ho]N4TcH6><=g3
h5^7BW4_BIj;mG[1IRUTn:bj<pP_78d@IHGAh6OjQVqXXFdP2qBC[W94b1dA6hb>
haSPgnLLal1e\p]c>0K>jqA>L\QTRCga:5^6kTWF\:X?KRU1qTeLSLCQT^4PcXSk
D2;o@WZOf6VC_qfhRUa^4qN3W`l[`_Ue>d_]aVm@E@V6mLe83OJZp0i\gW?CpnX[
OjZmWVP<0f65GG43]3X@mPBNl0dJn<F;lln0OgLp=^QfS3Vk77fh1>Vl:8i\CU\f
S6IpXe9C<djIbElRknA02`CO2lq@39JCO6HC[Da;J2C_:\ADUE@26O^4kMe6FZd6
RUXQP:RaI7ij?49j64lqLJW1A20qHP[k@Rb<dc[]hmVXWS`mW_@DAn?kbN2=j[F5
6CZA;gI?2oZTA_n69BF7glh<S5:;a9G8X^78GXG@<]dGZ`eRml2pZU1Xnm^aLLhN
?MLBj>9Yp8FgeYi`qIX`gf1>Z8lM@2egc361RF0aHMJJ\^FI_E>=po=OB\nI3T[k
nR>AA6UkSOP6F[B[SJE7p6>ebBab4Wj2We`\7G@<[Fmo]`:a_Lfc8VmK`^C9<OhM
41RAlUXC]9UC:<@21iPM5M<7ZhNCG\i@Bjm2AIWMa9ZCp0a8ME_9HaAS]KTUJfY3
Vp8[l;`NgpHfHREYn4jlnM7LiBgjeUO_P3=nVRR=5hQXZ7DkY^VD6N^Ch_g[`fY?
N]2Mq8LJQM\dLQ`FEP_9aWA;k:do\T?\dW__9L@Np[ULm]OjoUg7qM9M8cn=QFAk
?Qf@1RIISn2a@AZVlS7kSTWNfQ=KY>QL_^nLNT;_L^b;gCI0=>R`T<AOUfnoZqBK
<4Y0Wq6<0GQnaeTCm@0]6RqZcfcH7AQJI<<6<bfDJl_3d\2`00HFi?j_3GjVn2_O
Jd=D]OR^mp`NGHJFLpXTYS=eZU=j[?KkoEPLkF][UY8kUUhKhW_:E00jL4RUDL`F
WqF99`0V;q[2dWS0?:FAQ63U`_^`d3`=9_IafXT<k1k93aG0cLKF:>CS02f]J97J
Zncm8lq3C8^naWq4O@DZAI=gd2o1^J\Ien[U^Y[7hTpC;;ZO<\1LWWmC6R3HbEdK
WpehXB?2_^X1HI15DFPTk3NU:<=Ek4NAZ?<m>p]C\aL[4YD[GD:LVadW_NP5JhC7
coGK52F8mqUfe[b8::R7Sd\0nNMhH3Iki7TVc3KdFnek@UQ2BC>Cg><9XAh=\ad7
\K[Kl823ELJhpM^:1F_54`4Vqn9PhO4Y7DXFc:RA9po[ofJ88?7]Y3cQAfaI]Xf@
7KEH1XiX\nd^Ik`SpbUA;aN9;nE1LJlDMJjchA>8jgF[oEWLjfdB2[2[<VgHNZPB
IW_Hl^0LM[F\GYDb]GKXjfTJJoUS`R[ZU4Zkfk@IWl0KpEJKCN<bRnSK9QNiDln8
P2icOK_<om2X5]28\g[fdqcV?8M8L0DQ[8MIdBXZWPjP5M9HnYHV9>ch8GOnmG@1
2VZH[7X055m^h55N`\_mjfgZM@I3BDfaD;bNj@kcbb]FW`DJUpBD_e8GjhOP23EV
5N61K@`@mAYfbeeXgAVN:;G>O9<V`T8ddTE73JLHae@n>0pea\>b4Eq7iXcmBbq2
8@6ffeN_b7SMjNAA:q_^HLifRRPAhfNVW^4U=jM:ibjGgP=P4L00qZ:=cZ89T:3\
LMbfae41NO1L`4nHi:LIDfKceY1Z4HcTJ6e^4lc6V:=dG3:?Q6[fCe0^JnRQGCGC
80;=WZ01C`j3EogU_2L`KK\?hYdAqLn]^ced:i^9I64;D8JmmH_GR_bkS6<mGFNG
opdm1dUGSglGR@QFU]`:D3B0o]]VDD:^YbW[CR^K7fQDS4A[RI9od]Mi9PAg4e2I
;@ZXojRfaW70Z<B8mY@Yc]odPd=>0fd7j>E2K6Zj1q\:513mXVnFS3U5oZEIm]4S
1RYGc4JWE6=@MZqJ]iS?G2jVHYXdkbSfN=G[;]U9ZN[3\RWf]`79cY5EGD0LTOFn
j85IbMp6Hb=0OJXUGd:3WaGk7[<WE\W?W9dW6KK3d>E90@=5jh=_A3`W[BEGaYRh
fZ^g9o6h<EN6`@^@Dl>BGeO73?VRU3MFEMS`ND;\cA@E]=pde^>N\lpYgHZ@nJpO
HR2oaOiMh@1K^?7cMN7lX]GMWW\nmkfJ<kT;2BO;CPKP_b67<QSikJI@S_ml6j]5
5^i:GdL4ee6nH`6HeBpC[fK:c0i1W_U>:1c6mK_\7?Lb6pHHG5JHLq]AcJP1SZK2
`8QmN?_FLH_\DeC^<PWIKpaR>PUL=p1W5GWQ=^FMq;E1KNCBPESoJimBaU0F`DIq
?H^YPc_SXEDg=3fdU_g1T5fOWZRU:6RYfgj6W5POKKk_4=7?Slij@5gLoRM^in;O
?AbDES10cJDc;L64Li5LfNOXN05hh>q4U3AYJ=;oP<9H<]^^NVCp]C<^om2p;2ib
hSn^^XK:miUdXHRP^MKM<1^=h<KfH<ghd:m2C7OC>?A:C_<MQGq40Xd\gfpM7^QN
gqm`clC:IePW]lQQ4X=TS65RVOc\l9DaA;_>fp6;hNVlWOAnQ9P73LcRTeQ8k@aI
O@hhT6IfJbCT_Yl2^02\ZojN5L<lXEdbflTT056KhEo2H<6Gge9ln@qSV=D`>9KY
>I\TbRVaBdggoiGDc`idh2i:<BIH]oc6A00bMcnWZB[HRFSUXdB[40[S`=D>5HYR
?DmpWDQU2kMA`oL3obd;1lEj[2X?QOD46m:X:NagZl0jhga3IMal?c=dK_D`MR98
LD4RWSQ@=RJ]UmAIp9\@3Tn`<5:mHo70\<Me2`l2mSDGN2YB;>@`b`7]]:E2GL0g
V:l=m;VmN14J:eLN3Ij1T;V`P2n2qEGbVATo00H:e4<OAh9EYTMaRb=ZO_bSidfA
aY5Mhfa_HHXLo4?6k>]nEhH5Z[AEbLNeO;;<SLJqiD5NKF[pZ<1:<=C:;J`9XT2P
J6AcG2[IBH4U2Xd]7Z1Z@3IYqNcUh`gGq_iFHU9m78M;MP^X?UoVo3XfK^6q_Z6]
HETi9Dk0`ei>M80GRBUJPPk5><I5qSL378FfigPfGd0]Ap@DGbVK410VUL1AS57X
n9Qb]nSG><fmSNWH]EE4QQT10BkL\R`gqUZM\U]0KSY1;O2TcfUh;CjoVfBG<k1U
ZNKiHI\E<nWL5L7YR7b5oaj]jANN0fH5p3MjA]^cpKk3H\@H504iJBL7LUY9Y@O4
Yd]j>1J43Zid^HPga4>G8oB;qb\D^<^<qEc?<]d$
`endprotected

/*
 *-----------------------------------------------------
 *	 PRECHARGE command								 
 *-----------------------------------------------------
 */

// precharge command performs to disable active operation.

always	@(precharge)
	begin : prech_op
		integer bank_id;
		integer i;
		reg		[8*8:1] str;
		reg		[8*8:1] str1;

		`ifdef NBANK4
		  bank_id = BankSelect(prech_reg[2:1]);
		  str = PrintBank(prech_reg[2:1]);
		`endif
		`ifdef NBANK2
		  bank_id = BankSelect(prech_reg[1]);
		  str = PrintBank(prech_reg[1]);
	    	`endif
//`protected
GJISASQ:5DT^<i0YH9Ic1O;:2UF_3dJa<Vb2FAl[AD^7iK8]o;:1i6qP<gK>Fbo1
bXFD2d7mE7q7kncJ[mJ:1K>@?MQMN8Qlgji:3TZFVdCUO70Zl46mf\DA^8pQPnL?
6qIALkD`4LYNQHj>KAN5[gi=dl?eWYD@C;@3KIGD:^N4pRa;W2EZq1kabFX1?eFe
kTIA=lAacUo1RM3?L<d3?9m2TjIePK7Yp@M6ZDTHq@09lCSqc`3hmUCcLl?ARe:F
<=63\<FTdDBLgC84]BKUkJ?oa;3JaJ>OQIkhA^Dcanh@=R?`:f?;22S14Ol6CQ8K
03j13Vj=7\6bP8q77:fnCPQNCfjK;Db@mVHk4SMjOeX@=@j9_16C_3O1PG9[gTA9
8Q@IKo?]G5_gIIqSTU4Ef2Y9ZMl6icYD@SZ9d\JTleZeW2CZQ\3e8nLC19hUE@8R
7BOT7`c6Fc2S83TG7l0nDNAj^`NoPoNjlcZ`Ui]nkp41bU_YYm8kK@XGkfcYMakX
c`ajc9lk?Vi@NES2\3<]P=8DBPISL^Q1WN98Elh>Jd\IWi`IlL_40^<?dKYIMOJW
o64:pFNOQo^SMJeU]o8\RWC`i7`gE==GPK[niZg2PX7cJGPkoXAkP^e_KY[nZ9d=
me]eJ;^ol@\^U\A>m:EIi>5JTCESIq\H_P6P5pP=NLW<[e\Z<m@WRM?^S9^lKMG9
J=M2F0K:BcP[\:V0j3oF;1>@K:\gSIB?H_i`BHUZBk24C;Y[WmiL<\\8GO`W@\JN
[h3ESPeApkb;f`eLTIW2A=P\oKTOkHj^CfLCEG4RB0L7E\h[1??e_=2eMimAio;?
QCYpnVY3=Ka9QCHkSbjQfK]>7Lq>[>YDXfpDmY0X=qj2EcEZn_V3T3;ZfcMEWe2b
T;h3[gG6IhMf:1fNFicfm4J@VViUO5gV?O7KSn29FfdP1lD:fL\XlOn5S<8l3mnn
eFV:>14hFLSBQj>LaA[fiPg86H<m>U4;TUWI]Te>oPjNO?RB`p75hnkDkn35f6>7
81Uji]U[:?HQ4c]T>P5<[>oj0TgVSMDalo6^>Y7?Q8^<^0mCK?3XmFM4h?`Xk682
`l_Zg]c>gYVVqB22CSkPbBaal6Gh1cTRdgkFe[ZGSF<GE_fdcWfBn9dD3R[e\QE;
D6FFO28^ecWko<?ikL<KEZ?h`I11:>dFjG4[dl9pJ3TMSJ^80KSi4cR\ACdLfB\>
hXMYNmQ0e@GdVG>J\dd94M_9RIc>39GVR`JieEYO`C;hL]cUToYAX3Tmm4>M64VA
@cpm;K26=<W00Cn0j=1HFWY:<f]T7OHSU>9RQ4X^`9j;2miM5XCJN`D@8W<Ak^Tc
6l9`RBEnVOIGf?Og4F[Z>WNaSh:IhX6Vc8>kNp>l]CX;o]edkYAFcMYma<M]k8LS
_AckmB8;Y;7[J3<PC_heqdHHD0BbRi`OCFHa\@=07mE=d90KKFC5^k9k4bQ0nM;i
BaApWlc[C]C?JDX;WEm>CjIi]2q\<A0D4_R[@Me6ikYV61BUBH`MPaioD9Fq1CgD
boYH9=XnSlTUR?\N3aq1]RXA[b>>Q77\42T:=5fWMe2aNjILQ>eg2VUC3d99^k<1
Vf9BGc2iJAeQY>5<mTKV63AO6acO4LD7]2G:\d7FIcqY_ZEYaKpQZ@F9F?qi[[LJ
E;HSaNln`5p0bm\7n6q@@hWm@ZqSUPAMWOjlFHfjRUbGcceH1_jE`?NV^d`Mad`l
KEU0M`V0=g4OPL=ZNf_RNbJ0lSUN46TkNlo[RoBQIJ0kKj1Vhh5b\RTkAGbodp5T
j[f;Xp01EKNUClN;Um4NlH=JS3WRWXB?pM:5oW22<Q6VMegbF6@n4mkqMbo\UaWq
jMb;JLSA\_iKG:9oXYKF:64[14Ijf?5i>::an4@ggl\Oo;H?\hLqh]Y_AZ9Ba645
KgC=LeYZ`06SaL\1NK9>QNZqWDO^5o?4O1bBTK4<WUXWI7UWJheR:^FmD68qG\jZ
2a8<:i[5gHGi^?JJdD]lXPi\RdGmJghId?`2no_A@G5QUcM[YP=LYghSBG>o\RC4
<`3pml8oY]q@2HR@b6]]O=jbMG4UTU[p`5ng@d:cC1iU6a4d^=k51R9IjmQ0gke6
g:2`WBSVBipOR;TA0X7Y^_2hLPM?:TTW\8jbEh03nQcB=IBG9:k\GL<?:K]UQ;RZ
4d8dVC8:nm:24pLe?A?HL0@29UcCjCOJcZXJbblNT:V3T?[I:[\:M`H4p68C2lSK
9GeaJMQPC[SVGla3ec`cf;_PnJ78W`f6[ckqD5]_D_g7GiOFl1dK?105<loLK0Bn
m=_NHA5ISBRU@CpHVllggipdaefUcmphS<V7>pJI;oY];p7b[jV]DpBSPVhI7;eF
5h<V0P3B[L>lJ8G2ZHFJB3Z=5n[Np8_AI>i5[j4a1HdZ4:0X;iPZ]cg>0a9j6kbb
8fUQM__I@:1kB<8acqDk0Yn?6q1b?NO2DTP9b\V:1aeLE\W:JEU<hD4WG_mPW7Xd
QQOEEgC7FlBDIFRZWqL_8V:ZPp[k`]^Gf8eF9?qWinDjLEQU:=0``qQ178jA<D2k
C=FfB2ckafAaFe>Pl[46p2V48QgB6?cLen1pB9TWFhD<XH0<kLk^dN9L<_4fJn_N
A>p:Y0li^M0;TZJWK:YR7jQ9\X4EKLEAWVf7mgNH:S<eJSa[WR1^nWf;S30JA\qd
H5DBOWaO>lFG=pf_BkG?fM?b_i\WZ9T`egUYEEOIJD47p]I2ZGQ6NDPJOYUp_a2?
AZB<[3kM3YUCA@?=?M[391ni`8p?=Rf9OkHUnT7e6PcU?aC>9fWZ]RFfJejq;ndb
AfFk4npmUT041Ng_bYQAO32XIiTS=\W:a]4ic^pGGWQ;bbqZ<4gg6qLc[g`N1E5Y
fcH=@b0Elq_kD:bPSaCh9<;Uch`EcWG]C>jZB]D]oUAoj;QSPWkIZX9?i[^Tn5[0
9lgi\T9l<XAbca6c8S`ZZZV5oV@_;[`KGSNF2W3NN0lfdQl7h3A7Ln2?Ic6<7Wq_
NV]IbX8^<O5D1PI9Q_eQcQ87Fei28<lF@\o]]>dG3AjmDIF3gF0_MH2IA=XOWDBm
eHClEPBE>B[PCAJ\6qF?gCSP[`kJ@YUL[QnTFXP5`\_1T`OCll`0RZ87MdAhOckE
?chB]cVDbmHH^4`_l:ih\dg`3VZe2]=KocdRp6HZ1RagBj3_M311ia:??leUA]M]
Q<I9<fPWRga[fk^emHO`PSDmV56S6noLS5:fHmW<\HYN89dChI>]WSDqn<O7i^dp
6Hb=0OJXUGd:3WaGVB:LVN2QYWMD56b6Jk641KL4YVg;M5D;`>K0e@2L16dnNIo`
JIDiOQ@<k=in>2V85>:jS<3_<9kCX4jZJOCXqFHgaX\Ih:>D8dbQMcXR>Q1p0;Rl
4o`pMb[A_WhD3keCU<?dgkVfpB4Ue4?p`cZA06XnT7Sc<LA>AP_4N1[4QXLXNlaO
?_o38DYS9ZQ1fIjBfRTljfi^`jDGaP94AZGAHg@@@kTBTO0]cKZ3N=l4BXi0j<5e
>FMNaJ1_e\^:PD7LFDJOWH<:SKM0a]9W`=m]Y7EiK;TmTRV@7Q0XqXNHA?Wlo`JS
K89=AiUDZa<GE`Fl`nAO2mV=gJXBX;_?:@eFbjPm=OmGDJHZFDZNoh[7;`4SkUDK
g1bC]lhpP^Z>?KigY@hk0?KbTX5823VfK=FiV3UH5JBS[IGX[KbDoDZ8;cE10X2?
2li]4U8VUg]U`[BQ<U`@^fKam[pASD8M1T<ec^lR9gP]0aK`oTDP3cd]>dWQioV6
@4gX80PbA@Cl\hmfI`l4?KJgTTodgORj9opc8V@]=7OXQ9fV98fQ?VYGC@8W>cXc
SNQjF\nMEC]o^^W9g\HBjFC^`XP@TH8HjMb9>bZlKFk:811UZh410pW^?=_G`bBd
HO<>WI]@QWb9b>>2IX7FnS50MO2GelJZS7J\onLgS[SO9KnoZ`AKfFN7:YDKb[UC
M\B>LcD3c\P[@:HdY[g`705^1Cq`IY;Tel4ePKA\ddZL`4QLe;oK605GfP1U]V0E
0p8M7OkdFJ2gH:Qn0cgOc6VaU^G09WHaeLp9j]7\b?;OjoTI[gN]0hBIKlT]6_HP
oRhVie_IlijU_lqbQj6LWpXLcSK2[2]dK2q3k8\Tg3\LM_KBn_D:kB7nifmNZHLQ
YmVlgQmo?ZigaqSc8_1G>o22HY><C?:6g]`H@:F9n61?n\4VFT^4@M`BpR]VF:9X
NX93Q1nN?:d?:9AmDTafCXYB4Se?`FcHGMWpHES27Z?9BdTlO[>N9^^9Zl@;F;_<
QR8I\?ge1JIJXnqa:=G4]=[cY?DhUG6o@RZDX6UnMfioK:\:mVW7S?j>dq=D00J\
dqW5X=PR^^l]T6P9:_P:h=7e<afDTMVMGRo3SR61pN?=56ZBp;H2`=V?GWD;2bS3
\@DeJ^bD77KDjH]6q8>Z1:bpFHJ6SDXI10M>^8POo>=p[[_bN8n[A80Cg=<bT9fM
>bn@WlNf6B]<VVRo6AYAVmS0ieK>?_oL=2f75f^BPR=;GOhDn<1bMa6_D7dgO<\N
5H\;4CTpb`M:hPnqC\jnQm2PqfCTh0Cio<jf@YTBTn;;Q^9l;gL<\l9;:gC`DJli
YHK9D>W@<U[;O^Y7U<8nbCnJUjdG>9IEYqc=:il5Z19DBNWo<5nUNpSQG\1cCnZD
R`59iI>M?c5>FNHJ`XmnHmN_GP8IgGa``DX1CiG32b9lAo;IkdOojE00hI^QQ<HM
8S:CR=kZOKD53NGE`UUgJ<kYqK0AlEO>poV]R>eX<pWFi=DLHqnNQBWaYp;Je4^>
hpAJQV;7lH@5Iia8@oG<5^4PCddn2d@ZODdcc>o5op:C?ne^S5Za?f\J[7QWiVQS
fHHBlekH@5cW>3<]i^=jf];?CIXII0?SoeTT`7@W67C\n6DX4;?k8c=W@W5<K[T5
G``[<EZhB7=mq>OV06\\pLM\MFXhIFTh9@EEKFRWcNbpheSgYSIqf3^mT<X2e^\H
jP:V3WbXk1SRA1SZSJ:[mkTq@\]lL6HKTW4dO]ZX@A6<bEQnN93>YIK[?BBp4IT6
IHjOHFWcK4EZRZW8=jd0b5Z:YYh8T1gEnRjeSEhM`Ui^ThOg<oc3MLh5_R\k39Cp
9a9QTiiqNl@efRfb6?=4TEcMi[CW<TELHHaYQ7pn=>ZWi?$
`endprotected

/*
 *-----------------------------------------------------
 *	 tRDL=2 AUTO PRECHARGE command	 
 *-----------------------------------------------------
 */

always @(wr_autoprecharge2) begin
	wr_autoprech_reg = wr_autoprech_reg2;
	@(posedge pclk);
	if ({CSB_FLAG,RASB_FLAG,CASB_FLAG} == 3'b010 && wr_autoprech_reg === ba)
		$display($time, " Warning: For actual device, this 1-clk-gap command would be illegal");
	else
		->wr_autoprecharge;
end

/*
 *-----------------------------------------------------
 *	 READ AUTO PRECHARGE command								 
 *-----------------------------------------------------
 */

always	@(rd_autoprecharge or posedge rd_reautoprecharge)
begin : rd_autoprech_op
real difftime;
integer bank_id;
reg		[8*8:1] str;
reg		tmp_reauto;
integer	prev_bank;
integer tmp_bank;

	tmp_reauto = `FALSE;
	bank_id = BankSelect(rd_autoprech_reg);
	if (rd_reautoprecharge == `TRUE) begin
		rd_reautoprecharge = `FALSE;
		tmp_bank = prev_bank;
	end
	else
		tmp_bank = bank_id;
	str = PrintBank(tmp_bank);
	//difftime = $realtime - $bitstoreal(TRAS_PP[tmp_bank]);
			case(tmp_bank)//TRAS_PP
				'd0:	difftime = $realtime-TRAS_PP0;
				'd1:	difftime = $realtime-TRAS_PP1;
				'd2:	difftime = $realtime-TRAS_PP2;
				'd3:	difftime = $realtime-TRAS_PP3;
			endcase//TRAS_PP
	if(difftime < `tRASmin-`MARGIN)
	begin
	  `ifdef M64G3_M128_M256
		//auto_flagx <= `TRUE;				// KyW ... 0624 : rev 3.3
		//auto_flagx <= #(`tRASmin-difftime) `FALSE;	// KyW ... 0624 : rev 3.3
		  prev_bank <= #(`tRASmin-difftime) tmp_bank;
		  rd_reautoprecharge <= #(`tRASmin-difftime) `TRUE;
		  tmp_reauto = `TRUE;
`ifdef v
  $display(" Info: Staring Auto precharge (%s) delayed by tRASmin violation at %t", str, $time);
`endif
//		  #0 disable rd_autoprech_op;
	  `else
		rd_reautoprecharge = `FALSE;
		$display("Warning: tRASmin violation at %t", $realtime);
		disable rd_autoprech_op;
	  `endif
	end
	if(difftime > `tRASmax+`MARGIN)
	begin
		$display("Warning: tRASmax violation at %t", $realtime);
	end

	`ifdef M16G4_M64G3
		if (tmp_reauto == `FALSE) begin
	`endif
`ifdef v
$display(">> auto precharge ( %0s) at	%t", str, $realtime);
`endif
	Mode[tmp_bank] = 0;

	precharge_flag[tmp_bank] = `TRUE;
	rd_kill_bank = tmp_bank;
		->rd_precharge_flag_kill;
	//TPRE_P[tmp_bank] = $realtobits($realtime);
			case(tmp_bank)//TPRE_P
				'd0:	TPRE_P0 = $realtime;
				'd1:	TPRE_P1 = $realtime;
				'd2:	TPRE_P2 = $realtime;
				'd3:	TPRE_P3 = $realtime;
			endcase//TPRE_P
	`ifdef M16G4_M64G3
		end
	`endif
end

/*
 *-----------------------------------------------------
 *	 WRITE AUTO PRECHARGE command								 
 *-----------------------------------------------------
 */

always	@(wr_autoprecharge or posedge wr_reautoprecharge)
begin : wr_autoprech_op
real difftime;
integer bank_id;
reg		[8*8:1] str;
reg		tmp_reauto;
integer	prev_bank;
integer tmp_bank;

	tmp_reauto = `FALSE;
	bank_id = BankSelect(wr_autoprech_reg);
	if (wr_reautoprecharge == `TRUE) begin
		wr_reautoprecharge = `FALSE;
		tmp_bank = prev_bank;
	end
	else
		tmp_bank = bank_id;
	str = PrintBank(tmp_bank);
	//difftime = $realtime - $bitstoreal(TRAS_PP[tmp_bank]);
			case(tmp_bank)//TRAS_PP
				'd0:	difftime = $realtime-TRAS_PP0;
				'd1:	difftime = $realtime-TRAS_PP1;
				'd2:	difftime = $realtime-TRAS_PP2;
				'd3:	difftime = $realtime-TRAS_PP3;
			endcase//TRAS_PP
	if(difftime < `tRASmin-`MARGIN)
	begin
	  `ifdef M64G3_M128_M256
		//auto_flagx <= `TRUE;				// KyW ... 0624 : rev 3.3
		//auto_flagx <= #(`tRASmin-difftime) `FALSE;	// KyW ... 0624 : rev 3.3
		  prev_bank <= #(`tRASmin-difftime) tmp_bank;
		  wr_reautoprecharge <= #(`tRASmin-difftime) `TRUE;
		  tmp_reauto = `TRUE;
`ifdef v
  $display(" Info: Staring Auto precharge (%s) delayed by tRASmin violation at %t", str, $time);
`endif
//		  #0 disable wr_autoprech_op;
	  `else
		wr_reautoprecharge = `FALSE;
		$display("Warning: tRASmin violation at %t", $realtime);
		disable wr_autoprech_op;
	  `endif
	end
	if(difftime > `tRASmax+`MARGIN)
	begin
		$display("Warning: tRASmax violation at %t", $realtime);
	end

	`ifdef M16G4_M64G3
		if (tmp_reauto == `FALSE) begin
	`endif
`ifdef v
$display(">> auto precharge ( %0s) at	%t", str, $realtime);
`endif
	Mode[tmp_bank] = 0;

	precharge_flag[tmp_bank] = `TRUE;
	wr_kill_bank = tmp_bank;
		->wr_precharge_flag_kill;
	//TPRE_P[tmp_bank] = $realtobits($realtime);
			case(tmp_bank)//TPRE_P
				'd0:	TPRE_P0 = $realtime;
				'd1:	TPRE_P1 = $realtime;
				'd2:	TPRE_P2 = $realtime;
				'd3:	TPRE_P3 = $realtime;
			endcase//TPRE_P
	`ifdef M16G4_M64G3
		end
	`endif
end

/*
 *-----------------------------------------------------
 */

always @(autostart)
	begin
		if( READ_MODE )
		begin
			auto_flagx = repeat (BL) @(negedge pclk) `FALSE;
		end
		else if( WRITE_MODE )
		begin
			auto_flagx = repeat (WBL) @(negedge pclk) `FALSE;
		end
	end
/*
 *-----------------------------------------------------
 *	 DEEP POWER DOWN
 *-----------------------------------------------------
 */
`ifdef DPD
always	@(deeppowerdown)
	begin : d_powerdown
		if (|Mode == 1'b0) begin
			D_POWERDOWN = `TRUE;
`ifdef v
			$display(">> Deep power down enter at         %t",CUR_TIME);
`endif
		end
		else begin
			$display("Warning: Illegal deep power down command at %t",CUR_TIME);
			disable d_powerdown;
		end
	end	

always @(d_pdown_exit) begin
	D_POWERDOWN <= #(`tDPDEXIT-`MARGIN) `FALSE;
	D_PDOWN_EXIT <= #(`tDPDEXIT-`MARGIN) `TRUE;
end
`endif

/*
 *-----------------------------------------------------
 *	 move memory data to dout register				  
 *	   by sequential counter
 *-----------------------------------------------------
 */

// This task models behavior of increment counter
// Simply, address is increased by one and one.

task	increment_read;
	begin:ir
		integer j,s,t;
		integer	bank;
        reg [`BIT_T]  maddr;
		reg [`BIT_C] check_111;

		bank = BankSelect(c_bank_addr);

        maddr = m_addr;
		for(j=0; j<= BL-1; j=j+1) begin

			case(bank)
				'd0: begin
				`ifdef DYMEM
					$damem_read("mem_a", maddr, dout_reg[j]);
					$damem_read("mem_a", maddr, din_rega[j]);
				`else
					dout_reg[j] = mem_a[maddr];
					din_rega[j] = mem_a[maddr];
				`endif
				end
				'd1: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF1BANK == `TRUE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_b", maddr, dout_reg[j]);
					`else
						$damem_read("mem_b", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_b", maddr, din_regb[j]);
				`else
					`ifdef MOBILE
						if (REF1BANK == `TRUE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_b[maddr];
					`else
						dout_reg[j] = mem_b[maddr];
					`endif
					din_regb[j] = mem_b[maddr];
				`endif
				end
				`ifdef NBANK4
				  'd2: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_c", maddr, dout_reg[j]);
					`else
						$damem_read("mem_c", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_c", maddr, din_regc[j]);
				`else
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_c[maddr];
					`else
						dout_reg[j] = mem_c[maddr];
					`endif
					din_regc[j] = mem_c[maddr];
				`endif
				  end
				  'd3: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_d", maddr, dout_reg[j]);
					`else
						$damem_read("mem_d", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_d", maddr, din_regd[j]);
				`else
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_d[maddr];
					`else
						dout_reg[j] = mem_d[maddr];
					`endif
					din_regd[j] = mem_d[maddr];
				`endif
				  end
				`endif
			endcase

			case(BL)
				'd1: begin
				end
				'd2: maddr[0] = ~maddr[0];
				'd4: begin
					check_111 = m_addr + j+1;
					maddr[1:0] = check_111[1:0];
				end
				'd8: begin 
					check_111 = m_addr + j+1;
					maddr[2:0] = check_111[2:0];
				end
				`PAGEDEPTH: begin    // case 256
					check_111 = m_addr + j+1;
					maddr[`BIT_C] = check_111[`BIT_C];
            	end
				default: begin
					$display("Warning: burst length is out of spec");
					disable increment_read;
				end
			endcase
		end // end of for loop

	end	
endtask

/*
 *-----------------------------------------------------
 *	 move memory data to dout register				  
 *	   by interleave counter
 *-----------------------------------------------------
 */

// Interleave counting mechanism is different from 
// sequential method. Counting step could be varied with
// initial address.(refer to data sheet)

task	interleave_read;
	begin:ir1
	integer j;
	integer bank;
    reg [`BIT_T] maddr;

		bank = BankSelect(c_bank_addr);
        maddr = m_addr;
		for(j=0; j<=BL-1; j=j+1) begin
			case(bank)
				'd0: begin
				`ifdef DYMEM
					$damem_read("mem_a", maddr, dout_reg[j]);
					$damem_read("mem_a", maddr, din_rega[j]);
				`else
					dout_reg[j] = mem_a[maddr];
					din_rega[j] = mem_a[maddr];
				`endif
				end
				'd1: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF1BANK == `TRUE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_b", maddr, dout_reg[j]);
					`else
						$damem_read("mem_b", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_b", maddr, din_regb[j]);
				`else
					`ifdef MOBILE
						if (REF1BANK == `TRUE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_b[maddr];
					`else
						dout_reg[j] = mem_b[maddr];
					`endif
					din_regb[j] = mem_b[maddr];
				`endif
				end
				`ifdef NBANK4
				  'd2: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_c", maddr, dout_reg[j]);
					`else
						$damem_read("mem_c", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_c", maddr, din_regc[j]);
				`else
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_c[maddr];
					`else
						dout_reg[j] = mem_c[maddr];
					`endif
					din_regc[j] = mem_c[maddr];
				`endif
				  end
				  'd3: begin
				`ifdef DYMEM
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						$damem_read("mem_d", maddr, dout_reg[j]);
					`else
						$damem_read("mem_d", maddr, dout_reg[j]);
					`endif
					$damem_read("mem_d", maddr, din_regd[j]);
				`else
					`ifdef MOBILE
						if (REF4BANK == `FALSE) dout_reg[j] = `B'bx;
						else
						dout_reg[j] = mem_d[maddr];
					`else
						dout_reg[j] = mem_d[maddr];
					`endif
					din_regd[j] = mem_d[maddr];
				`endif
				  end
				`endif
			endcase

			case(BL)
				'd1:begin
				end
				'd2: 
						maddr[0] = ~maddr[0];
				'd4: begin
					if( j == 0 || j == 2)
						maddr[0] = ~maddr[0];
					else 
						maddr[1:0] = ~maddr[1:0];
				end
				'd8: begin
					if(j == 0 || j == 2 || j == 4 || j==6)
						maddr[0] = ~maddr[0];
					else if(j == 1 || j == 5)
						maddr[1:0] = ~maddr[1:0];
					else
						maddr[2:0] = ~maddr[2:0];
				end
				default: $display("Warning: burst length is out of spec.");
			endcase
		end
	end
endtask

/*
 *-----------------------------------------------------
 *	 move memory data to din register array			 
 *	   by sequential counter
 *-----------------------------------------------------
 */

task	increment_write;
	begin:iw
		integer j,s,t;
        reg [`BIT_T] maddr;
		reg [`BIT_C] check_111;
		integer bank;

		bank = BankSelect(c_bank_addr);
        maddr = m_addr;
		for(j=0; j<=WBL-1; j=j+1) begin
			case(bank)
				'd0:
				`ifdef DYMEM
					$damem_write("mem_a", maddr, din_rega[j]);
				`else
					mem_a[maddr] = din_rega[j];
				`endif
				'd1:
				`ifdef DYMEM
					$damem_write("mem_b", maddr, din_regb[j]);
				`else
					mem_b[maddr] = din_regb[j];
				`endif
				`ifdef NBANK4
				  'd2:
				`ifdef DYMEM
					$damem_write("mem_c", maddr, din_regc[j]);
				`else
					mem_c[maddr] = din_regc[j];
				`endif
				  'd3:
				`ifdef DYMEM
					$damem_write("mem_d", maddr, din_regd[j]);
				`else
					mem_d[maddr] = din_regd[j];
				`endif
				`endif
			endcase
			case(WBL)	
				'd1: begin
				end
				'd2: 
			 		maddr[0] = ~maddr[0];
				'd4: begin
					check_111 = m_addr +j+1;
					maddr[1:0] = check_111[1:0];
				end
				'd8: begin 
					check_111 = m_addr +j+1;
					maddr[2:0] = check_111[2:0];
				end
				`PAGEDEPTH: begin 
					check_111 = m_addr +j+1;
					maddr[`BIT_C] = check_111[`BIT_C];
            	end
				default: begin
					$display("Warning: burst length is out of spec");
					disable increment_write;
				end
			endcase
		end
	end	
endtask

/*
 *-----------------------------------------------------
 *	 move memory data to din register array			 
 *	   by interleave counter
 *-----------------------------------------------------
 */

task	interleave_write;
	begin:iw1
	integer j;
	integer bank;
    reg [`BIT_T] maddr;

	bank = BankSelect(c_bank_addr);
    maddr = m_addr;
	for(j=0; j <= WBL-1; j=j+1) begin
			case(bank)
				'd0: 
				`ifdef DYMEM
					$damem_write("mem_a", maddr, din_rega[j]);
				`else
					mem_a[maddr] = din_rega[j];
				`endif
				'd1: 
				`ifdef DYMEM
					$damem_write("mem_b", maddr, din_regb[j]);
				`else
					mem_b[maddr] = din_regb[j];
				`endif
				`ifdef NBANK4
				  'd2: 
				`ifdef DYMEM
					$damem_write("mem_c", maddr, din_regc[j]);
				`else
					mem_c[maddr] = din_regc[j];
				`endif
				  'd3: 
				`ifdef DYMEM
					$damem_write("mem_d", maddr, din_regd[j]);
				`else
					mem_d[maddr] = din_regd[j];
				`endif
				`endif
			endcase
			case(WBL)
				'd1:begin
                end
                'd2:
                        maddr[0] = ~maddr[0];
                'd4: begin
                    if((j % 2) == 0)
                        maddr[0] = ~maddr[0];
                    else
                        maddr[1:0] = ~maddr[1:0];
                end
                'd8: begin
                    if((j % 2) == 0)
                        maddr[0] = ~maddr[0];
                    else if(j == 1 || j == 5)
                        maddr[1:0] = ~maddr[1:0];
                    else
                        maddr[2:0] = ~maddr[2:0];
                end
				default: 
				begin
					$display("Warning: burst length is out of spec.");
				end
			endcase
		end
	end
endtask

//`protected
C0hZ0SQH5DT^<1HiNP@`<GF_Z2cdCnieiDL:MUk3KYGRVVcOUR9ja:>S6QA68[L9
fEqL2f?K=6Q4f3`3YmZCX6he2:]VQDmE6^9qNAPfWI0N@g]UE:NP<^BT6?pIbVhX
jp^9<<VR4R=36n[GMIiA5DoKQNGIbGRZ9_qfc?jb@gHgbgcbE6L\ND1CQpgWRDbk
6N;\PC5AGNL=N2p^6Le]kf4UUm_K]\J:6kd4D\_bWjZlhPW>7piH?o_g6TN0:jVD
BfE;4i2a^dB4i9kGi2;bBGpQk0QT\5q@W^l4<fg?9MRQIM;NU2SFjaCm:55K`Xeo
[`Sk\;X9UbI>;X_5h\MlUap<5a^_if=6N=<6hcH^[baDnL>R;ld:OC4h1PeXY19o
QQhhJAG9?o`U^SeiIH=qKCFf537Rc:5RN_cbnKBJRnLI@Eh5W2dRPRFlR:L2mM?F
\6Nip0[SBbiocIi0mTW58oF_G<l^GF?flNbWCCG47g\_=>Qcp292Smh6q0m<dPgZ
]CAC1I8iJaXeM5RiQ>8Y@19dbUcFCk8L1fI4acoKZFbdDAIFRQhU59O\2HC^S276
fKQ7h5D]?U@SGJ[qn4X8DFWq^B65U;FoPU8\P4[OG=icaaaoa2HlLl?9qmlbR^_j
ejk32WR_=3d;nfFKKIIL^D]bkG[?h5lk_RhC\99Z\AQA[1^93pagNVPj8[HCTX^f
TCe62]eX<FqHjJCGUSp=eAZagAq_dFHg_45<>ZVkl[h5?[e<SlLSXm[jWD^f7TZ>
0p8JKTcV1q\4KFF?De8@\gVK@RDhcT=jhEFd:]JlRH7mT_JJOmGTW6W<jl?IQ]WB
SqbmWbCFT>di?hEW@I459;7cKEo9<K37e5kB6dYF`Y00jmMS3epY\Lm\XA7c][ME
m7hnam]YM`d\2G`0CY^1dp17RM93>UPPaVfi6h3e]]EZPeKAMDVo80EQMeNZbj5B
JpR8_kZ]TqjNHJ]1`=JNYEhH@TjE[fjJi`hH[aQLOmC?AIb1d7@6`HQa;X=hG[KH
Hg^@TW@j>E8jW=V?FKT[nDjJ]4;DI2kh?p^JQh@F3pk7_KVaTQB]el[39Ela6nY3
FIX]G[RDQ_QdWX=Oia\OHL0Gl>mR;4>coDga@BS]nO1A5c7NY7P6_@\SO2kC_bp=
cA<Z=9_8a:djVFodoolhe=UQ54n3IiT1IoqPlMI79Hl8GQMDfQ9>Y7W6SR3M]RJb
[l4fXU9a8G7R=Y[NWZjPmLl9nl[JS?<Ef:>DQl>iaPA85P?:jp;2ED?DoqkVUgQk
5kJOUlHB@T^]1jBgOPb4EaDS0h<V0GLiR\U>5M]<MMd>2DYnYYhchfD`S7:d;1fD
Z3pD2ITW6PJUdI6`ZZW^6cIp]53<bTBp;@E9^ZBqVmNZ<ERlkNM\MokP64M:a`O8
MF`]lNgJUcqo1[ml5SL75RLiVGj[X:XcQ02=RpRjiT_KYEFa?n2AMlARqeS]XcF4
pG\P`l:SpnOkSag0qbUJ2lBG9=a^;O5V@eC`2>jg6[1fJ4C^ZEPcGKe7lqbga`31
oPFf]kbo42]31U:SehWKmb23=_BI7TQY0WjUckq5b^0CZHX7gjJMfA[L>;01@hnK
jmfH;@1fn>7`ACDH=4Eg0A0\K6\S[lRpUE:5;inmf9712k?BPfn_F6=@d7qSJobE
`KY_k[=^IheICTM[iM`8h;_nR8Qnl]P3RBkDfhT<5aQcPZOJETOUj7@pIWQF]:7q
;Um@7?CoP0pIgPTJ0bgVD0EVXIRhD]<`Xh6DcA\UiXFa^GJc76R@5bTRX]DpQOBK
>TS`jBG\e;YXWC`Jin=Pg>9ZK1k5joE93RDeOMBF;bO`bIQU[LlbiGc6=LXLClS<
n>CqD9HT;UOq^HRW:aq3i`0k_QY`_PFSHoMA]mFL@OQ2KW<WVQncT1`EBU754^5_
;k0ZN]?0:lUOj@97hB>p`4PPJ3LS1\lJXWFmN00X_P2HPL<Q`5\8K8hZm[a>BE]L
q70>^C>Nf7_0;\BYoNOiI]1??Ol7SmSAGF:;;`QIlIaWfqlk2@egHjKk;=2QkOlX
Y5H9fm7cF3egc7PGUDXoBeKnAcboMLSgk9BEeWpkd^b1ca?D46>U=oYCXU\@:1;0
8:FEflB]BM[3n2IT^nkla^jdc^f?<]^^LcYpVVg:@7Wp^FYcPC4A2iqVSg5DKaAn
=MoO_4NcclcWf:\J@8C@2<GP\1bNI127ZBa]VTnIRI0p<4<C:8G?V5KYn_[Y0F5H
AAOP1[Oo_bh1h]H`@Sd[KQX7;XOWS\hZ>bLC8i00iG:o0YGL2A3\Hk8qP[n6AI0m
MQ=KGo=jSDInaD1;lZmcjKJ9FN?c6RnKRUh3OQ_F8k@4A@pBjoB[??pSP44B1qXQ
G:]nEVFFL9hUB<[`g6ebi`Rm5YRddjQNJJ9I;@@P1BpWOGS7J1V?=JnXQ_ifa<W6
]nTf^OoWN@`cYZXJ6MG7nSKpkGgA4BY47iT3bSdi5OoDfXUaDlGVSQ]mm]98WAcm
]YB37Te]AeXG^_9SqI41e_?\GfZFFIS^2nS\dld\?24>bAoJW8G?=9`fA2XULBUh
VXc7ZFBo<n3I8MZG5d>QXGJSeqKn@AS2PoJUBaLF25V@ETL98N1\OB;ZNTj8do1_
@6Z@Zfi7I^Hi\iRiiG@>7iqbbMLbnTpKPIF;f]SX^p8Coi]@CQMHTmI_?FP`B8GB
TLgA5=U_:Q45bG67cdNCX>2We=RiDUq1nA:<]11Ullm0<X;d27cG?O]e;Ph_LU=d
Be?FmV?X1aaM:[WS9UmaHP7jIfQA^?HFVgFW3N`kYPqHJb_hbbpGAG1g6$
`endprotected

/*
 *-----------------------------------------------------
 *	 read task 
 *-----------------------------------------------------
 */

task read_task;

	begin

		begin: read_op
			integer i;
	
			for( i=0; i < BL; i=i+1 )
			begin
				t_dqo = dout_reg[i];
				->dqo_event;
				@(posedge pclk);
				`ifdef M16G4_M64G3	// jhkim(8.14)
					if( i == `PAGEDEPTH - 1 )  
						i = -1; 			// full page wrap around
				`endif
			end
		end

	end
endtask

/*
 *-----------------------------------------------------
 *	 write task
 *-----------------------------------------------------
 */

task write_task;
	begin
		begin: write_op
			integer    i, j, k;
			reg [`BIT] tmp_reg;
			integer bank_id;
			reg		[8*8:1] str;

			if(~burst_type)
				increment_read;
			else
				interleave_read;

			begin: write_seq
				for(i = 0; i < WBL; i = i+1)
				begin  // { for loop
					begin
						bank_id = BankSelect(c_bank_addr);
						str = PrintBank(c_bank_addr);
						if(precharge_flag[bank_id] == `TRUE)
							disable write_seq;
						case (bank_id)
							'd0: tmp_reg = din_rega[i];
							'd1: tmp_reg = din_regb[i];
							`ifdef NBANK4
							  'd2: tmp_reg = din_regc[i];
							  'd3: tmp_reg = din_regd[i];
							`endif
						endcase

						
						for (k = 0; k < `nDQM; k = k + 1) begin
						  if (dqm[k] == 1'b0) begin
							for (j = k*`BYTE; j < (k+1)*`BYTE; j = j + 1) begin
							   tmp_reg[j] = (dqi[j] == 1'b1 || dqi[j] == 1'b0)?
										    dqi[j]:1'bx;
						     end
						   end
						end

						case (bank_id)
							'd0: din_rega[i] = tmp_reg;
							'd1: din_regb[i] = tmp_reg;
							`ifdef NBANK4
							  'd2: din_regc[i] = tmp_reg;
							  'd3: din_regd[i] = tmp_reg;
							`endif
						endcase
					end

					m_addr = {r_addr, c_addr};
					#0 ->flush_write;

					`ifdef M16G4_M64G3    // jhkim(8.14)
						if( i == WBL-1 && WBL !== `PAGEDEPTH )   
                        				disable write_seq;
					`else
						if( i == WBL-1 && i != `PAGEDEPTH )
							disable write_seq;
					`endif
					@(posedge pclk);
					#0.1; //KyW ... 0408 for VCS
					if( |dqm === 1'b0 ) begin // 98.6.26 BYC
					if( CUR_TIME - TDQI < `tSS-`MARGIN )
						$display("Warning: DQi setup violation at %t", CUR_TIME);
					end
					`ifdef M16G4_M64G3    // jhkim(8.14)
						if ( i == `PAGEDEPTH -1) 
							i = -1; // full page wrap around
					`endif

				end  // } for loop end
			end  // write_seq

//			m_addr = {r_addr, c_addr};
//			->flush_write;

		end

	end

endtask 

`ifdef NBANK2
function integer BankSelect;
input	 	c_addr;
integer		bank;
begin
	case(c_addr)
		1'b0 :
			bank = 0;
		1'b1 :
			bank = 1;
		default :
			bank = -1;
	endcase
	BankSelect = bank;
end
endfunction
function [8*8 : 1] PrintBank;
input				bs;
reg		[8*8 : 1]	s_bank;
begin
	case(bs)
		1'b0 :
			s_bank = " A Bank";
		1'b1 :
			s_bank = " B Bank";
		default :
			s_bank = "Bad Bank";
	endcase
	PrintBank = s_bank;
end
endfunction
`endif

`ifdef NBANK4
function integer BankSelect;
input	[1:0] 	c_addr;
integer			bank;
begin
	case(c_addr)
		2'b00 :
			bank = 0;
		2'b01 :
			bank = 1;
		2'b10 :
			bank = 2;
		2'b11 :
			bank = 3;
		default :
			bank = -1;
	endcase
	BankSelect = bank;
end
endfunction
function [8*8 : 1] PrintBank;
input	[1:0]	bs;
reg		[8*8 : 1]	s_bank;
begin
	case(bs)
		2'b00 :
			s_bank = " A Bank";
		2'b01 :
			s_bank = " B Bank";
		2'b10 :
			s_bank = " C Bank";
		2'b11 :
			s_bank = " D Bank";
		default :
			s_bank = "Bad Bank";
	endcase
	PrintBank = s_bank;
end
endfunction
`endif

endmodule

`ifdef CS2
`ifdef DPD_PIN
module sdram(clk, cs0b, cs1b, cke, ba, ad, rasb, casb, web, dqm, dqi, dpdb);
`else
module sdram(clk, cs0b, cs1b, cke, ba, ad, rasb, casb, web, dqm, dqi);
`endif
  inout   [`BIT]  dqi;
  input   [`nBank/2-1:0] ba;
  input   [`ADDRTOP:0]  ad;
  input   rasb,casb,web;
  input   clk,cke,cs0b,cs1b;
  input   [`nDQM-1:0] dqm;
`ifdef DPD_PIN
  input   dpdb;
`endif

`ifdef DPD_PIN
sdram_cs2 i0(clk, cs0b, cke, ba, ad, rasb, casb, web, dqm, dqi, dpdb);
sdram_cs2 i1(clk, cs1b, cke, ba, ad, rasb, casb, web, dqm, dqi, dpdb);
`else
sdram_cs2 i0(clk, cs0b, cke, ba, ad, rasb, casb, web, dqm, dqi);
sdram_cs2 i1(clk, cs1b, cke, ba, ad, rasb, casb, web, dqm, dqi);
`endif
endmodule
`endif
