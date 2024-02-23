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

`ifdef VCS  // VCS Release 6.0
//`protected
:4(J0,2Q,]g@9Vab,_SG-G9H,?Ab(PER-900(F:?1])^E]:@e8\b<52P=CHH)U5F
WV<BQ&BHWHFEZ2AVc5IM)I;4Fd^6YKG[(-3Y^U^aP3=a8O6^=0^FV3&7PC_C6([3
Rf\8#(^9Nc+A2L.Z[ZIMGDARe,dO)ZS1FdHQ-MU=MK^;#bL+aUO<BL1DGR(6KCZb
cBT9YSLDD&VV\8@S]D;5N8UE?=7bE&3a_^EP0K0c/ISWN&1>g[f=)IUa_NO-f1\Q
A8Y85M&e)2^0@c;T&T8/&c;#fe#]XV?g(XN0FX_K/Z3eR]++/LK&R_.PR/L;e6H-
c::SgeA:b5]ZGW3-DH(@FGRbN>gEJ8:09+g,@<G(gJYL.</fR(3?H.XL-HQZ,.BT
FD32,V=b:?X+XL;K=5V.^Dg[\K>TfHH-?OgGT^=&aX\5#3-Ta-741@TB;?]f>C>0
c6@f:f@P9H]9^5)@[W1\V0g9;Lg=2992M9Ze7AIA6NN2A[aO9C:02=dXU8S,ZN-\
Ff&B7I/XV58YP1:U0EQfW&L/GT/^<ZWB;E.#Wf[Q.S^J>(6-&RF@51#eH&\aKD0#
<B;<::<+=]/SDL(:C]H[J_0=[dQH9gbYA^<KHSe;89(S_^QX1DA97E)X7RPdHg3.
M_^,[2)C_Ja4O2_U+H]-b;BP#APa,T(0^RHRb)68D7QFc=<(46B]HV.NPdM=?4g-
H+bM-DQ7gS(TXZ=;.Q5:g8gE5;4(TZS/PK&]BXXHf-Vf_(PBYP_d,]2Qb\[9-QOA
3IWIV_#:\.+>XNZJNR:=J.91[A#C;#^2Y5FK:_<BcS<76(3/Jd>g;4EV2/e2^@^]
G^9&Y,Q\I\G0R@d[#I#QOUUT):@Y0J=F,L6V?9ZZ=M(QJW.-9N7AIUDJ4=60#/21
Q##6[^R2CBIc<[NR&1>#.4HIBf#DL:C7/8aGZDG.\P?A1Q,#CWO\3BY4GM&EEOZ<
98(Y26?gb,7M2^T2=7Y8X0NIES2>:g._QZ0>aC=SYdWM#QA:F4EI)AZXHQ?CdU5C
VFWa,;Q8,2H18SS02W?L(NZVe-Of5UaJ&G#M(FY7W,@gZ;VZVUB.>3f.4>+6FIU9
H1P\8HJ;K=O1Ye-^f<9.-J\?gS0Y5fM5M1>d3.KP^P>[AM0@LOV\-CG3AXXDA<dG
75D[7:D51gJ&MTAW9]9+1JL@gH-X\B_@K<3MY[S&MH/Q#)8-)251WRgK#?YMC\Yc
Wg>TK^Q:J@VF,2Z\>\-;=E&1(3a,(Wg&UA8e9]LVJ(:^g?gGHK?E9CPW[)D&L>VO
)>g;]d^/(U4UPf/-3Q6_5BSd^?HI5XV&=g+]=f06.68MKHMZ^bQW]6fXX/A16(@4
R(gNS+E5IM4P95(ETH=X:>?;U4.2FHY#eTG[(Eg8F3I\7V)@UXV0A;)Q#8MYFQbQ
;5g-3,TYUgZEG2A=CG4a1<B,(dg<aEZE:M_V&3@^Z^Kf_VQ>_3-&@<(5d]gUAVH8
W/EQf0OUF(U7c6;Dd??NQK]:[6bY235P]V[egRK;&,H6_gT3OONBE?9<9cBNb;ET
/#XZ?,F1U._T]PcdRHW-_<].e5)2b_6UO_<[92U=L<1Pe+#H>SOP@ZNWUD6)VT&Q
&(VXE&1d(#13B_Y8L^.gV\aeb381Y\W8f4CCO)]cXEaGRFQ27VEW&ZWUfJcZ;E&1
I]-D_X5^^Q80,-MUCgKcSX<MYaXcK[AgfSW(LA,PT?-E?PZ-3L0,1U/aKOg[3AG+
<Z;Of2[KbR?f.\>f945I.[SR56=#V/.RYDOG\:](#,&<F(8Oc<ae\-Y>T9M4e47T
N:_9#6X)FcZL=]B==P/SM@+dD#)Cb7&/Z]\bC+.E-a,,?W)K8W.O\B9P\HA(dIeH
dBC1#.ON:>,4R[_a,0^O5/S\ROL(-/(6?$
`endprotected
`endif


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

`ifdef VCS  // VCS Release 6.0
//`protected
bA9=_Y#-5.&D<aK:(VE3(\)E8@6/<1X\=.Q#)WB?F,LQd4C.FT)d9=C;,.,/([SS
MAWc?<cD8U&1;U0W:V;8I.D^cH017+:HdXCDE&6K9LXWC/;P)&_IdW/H,[5UVHD]
@9F;CPKE9:eacEC\2L54dIg.?/&cF;bQ_gg.KF+MFcP\UT&]#(_3:&fGK+L>\KC\
777#_MaK7TF=6:,+WL51e,-S)6D=Egea&BL3+4AG3DZI8FRZ.(X:NDW,]X>94S=b
;RBB_?QWP[,YeJ?_F/+2KeE^RcZ/5Ad)BL.GZ0R@SRXeGa#[=G7[-)9\8cO0O=5[
57^3UA/JP8?S9+DVIRfPZ,+3)1C+V9L=\2D2F>ac<6>FM=^(Ng]_L>_Z.C6ADNgL
=KZ>,\]U_E#&J,.?47Z)UW;Z8?Ve_8LO>47=eHRdO3J;1gS(HNB=N5@_/31B4YeT
.,-_#EK&&8RSERE:M71O&=#CF3(6P[Hb>Z&X]G/?Id)OV(.I>;6&A3UXfI?A>S44
;HQ)d3?/#/c1g]B]+/C1##ee#\EIF1I,&_G=E5^49;7=F8>Y)?AdT-,5D-9Sdf?f
[^@A817>0SS_I=03?5[M.3.gC\PMDDb[G=(;ISDWRX<>+,a?X;;bD8B:/dWc+(X)
/feVCIFVC_FbX:fgP?Q?42Ga<Lf<3_b04NJVDPeVGHTM..:Y;@X,PcN[X96gGbSc
T^3(#J9YI^ZMe8f8\Q8S8/KbD.0>,QSg40[#dVUBGE\fW8ZQO/JXEOO@/MWM6f>S
;Y.,N1I8J^:cKIDB-X\aV;;c?]7(J@FO\BNIXA^JY;YR41UVTPaPcPVMR/02;-?@
^g:MY5XC1LdDA)+@\6OCZZE-85]>TI6@[:U0K=fH;MEfIDDFR5;FXUX;S9E#N^X<
3;UJY\ff36dM9MV(PQ3@L>D1W_OS+8f<4=XFES;.A?d#b])f53YSTdd32<6.0GOF
:)8/6Y[4[fUge(^E?95::.48_9D/eS>O(ZcG4GI(<<?(BL0;&&ZX&aQ]FH9YCJ,[
2DTDUKX=B2K+1<1,\>d72MN0+)40KW<7(0?d[40YSf=47-]OJC)>^<[dBQSBO/C1
#F:<QF,^IFVU,Wb7[bRM?+BXe5>^>IX1UCfJ=@-D:>b@]>1;g49Z/V6ERa](;6Rf
=(CAGDNeEf5.?_CbJ>MYFdS4#1M>735\>Z7K.ZDR@RL&8-T/3CQ(DeT\,FVP-&18
dZ#93/[^gX1.F;g2bb-_Y+G,Je.E1-41.8FETe?;:#ANLVX]P0X<-E4XM,=(;#GW
E72+TN:LIE7X9YPbO:S^:S&5<U@;(F#I#QV,e:JZ3@-VD2YG)H_>GF6:]D^);#KH
b#)g_,<6KDC,G&ZE>&2ZYI><7=:-+FEce+g4Q0NG7ZI5R_#NL#L_4cUUNJ(.<\+U
[&PM;\V,6A?eI(K)>J9RK<,[Y:Q(<aa:RSC^J));70bUA&JB7?Hb1ZcU5B&X?12.
(\J(L5OL-,^E.7/b^79K/bHUCAUWAgGcF5-g:TC_.VP(G_8O&+RNIY3+(O.D[d(7
Ce7+PAG9H71VWD@KS3/-a.2e^gCNV(ND(/K4,]I2?8[\YP@\X[(PE[+45T55I]-A
0CUPGKPPLf;4GLJ+D@8EXGV_S3GB(CF;>1K#Y:6(\ZY[BY@60(W;T<UgQB&B1SB6
7&gOQ\bQV.77NA.8JJePR9\\I_+2<a<YSg3I3_XG<9I))-.g8f)7dN6N9cSP35ef
GC5MWJW,IRXJdE<?-Xc580YSd.K]R>2?fZ&LeedbY&CM@-6[1+fRNd4+e@FaBYPU
:=cB(WgB.cQZXWK+HUIIS_cQPY+SdEUEX.ETM<5=J-U#N@(d^6VX&^@.?482OHVU
P_LMCBT&(/)=-)J/U=UV-8^HP)bCU=b6FVba[E0=6(0VEV5IKLE46-RNSKE)c=FB
]J]2JPbc+LdW6>+RANc1U,HQRHbQENR9K5ZF]27J-[gYYT1HIQMCS6<:8fD]Y[?9
g(<I/@65=6R5CQC.VfNP6&>G/Y40ZNb9^b^:T/K]L43#1g7]:(T3ePdbT8H=FIRA
>ICB^22_YB8_9,:3?a.^=Ob/CR=C6.RWKXe;8BC-UIMeI7(FL(X5J,TYUfJc0fC3
M)52VWJZM2EL.28RDWc(>Ee;V9T1#cU(S=+D<cY]DQ??1R56UcS?Y:A<B[ZLF+FB
dGAKH.O)0F><\@EBX,VHY@U\8:#3M1_HY8A?g<=A:2g@UC(9Dc5<c]C<,g4;d9LE
>Q)f2cA7^Bg9T,E4#,G:=g3;^d/;TM^K2=gB0DH8J.DE68Cc\-(&87H/T5_V,D/D
)/MdX-XgUWX.9ITM=;:d-@I<?0<_-IMQH_0U4a\893?6cGH_0V@Z@J&B+dSK;X0c
)2<(ID2-.SL-aJ=HX[Z;K>QP;H:=FSZa5T3b3YS19,R[Ng52B72,KZ.K;V.KJF?,
;>V4cV/;-U[7B3L,26?LOd#,^5c9KJ1ZFJ3Q:H9\SZLOf\A^7J\J))ccLZ>[Ad]4
W7DaX1MO#9P.2_UT^]?8,6dL^_\NFXXH8#.954((S1g-b53IV5M.Y_f_83S(SUPB
eZ&UD[\JZOE;d\<0_b7K@,S9eX5Q+dX68VI:@VWaG17C?CZ,?(Of&WPC5XC20Ae>
b_N.#S/fT;.9HH2WcF.<3Lc1?Tb3+OA,56F98>BYcUf18eA,2;EPR^G<&bX19VAK
F:+(=.0PeZLH3<HY+eNCN<K:Z39^UF0F>6g#)a^/OcfGK<9T&fK/_X1c:I#EI>6d
WC5/E]Cg+C-BUO5QCUT_1gH[-<69[BJT7EZ?S,ZJ,I:fIe#WRMf24B<[^UT<7L]4
YdH^-)]5Dg^_+CM14?U:;QK\NH1@=3(74DC\eZ=S@DLgP0PBIX+5.\TV>e7S\SBb
3@W^TD+W(DBb[9fZZWVSYO,DEF(@ZD&UcK[BD6fOOSaNHK^;N?ZYO.<Q;7a[Z20O
E[Kf-d3EP-&b0$
`endprotected
`endif

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
`ifdef VCS  // VCS Release 6.0
//`protected
Bg:aRb_CT40#-[gP=2O.-[S3,Q4,)M0R8X>1-LC]9DB7c:-.>SVS(.c/,TQ+(AM_
eM--P0E#W;?g\Z_[]:D:3OWZFW>[N\3+J@G2;If+G#NV<<-c0ZaRe9-Z.E0N;/9-
9&@F7S2G]TB/Z,[;ZM@ONFM<U@1B3>B@BTD:TEDH0]e9LZ_/]#68=_R_T\AILXUc
RYeX[KceP7QgJ59,dFVJE#)0YEGLUWd1_][-]>T&M-g<1.3UL9EQUT@A[;\MKMUI
P=G>MN8Fg5+e_Ua][N9CV]:ceSSK1>?PP@\YI;?D.=_<g4P]S5RJf/]KX)AD21R8
4U&V.e-[FG:;U\bO+I@R?UcT<eQY+c40TP5UN^S/E6)369LSRgZ(E#,1?bO\V?E&
JWIZ=FF)GI=2)C723^R;9FG_-V+E=G9FQG3>#6:-5+\-/>^fL^ZJ.-RMDe3.S/L#
LPaEb?(HaXYbUBLWD,<599HC@GT\[dVY6TT52R6&X-8HN<;5^a>#L5.NF8>c>gA,
UaGWX4aacAfU#E<RKM70IbVT/_0?I8]=/BGb>4-(cM?]2eJ.[7a^J=b-CH8SJC2N
8>=\?0Jb0YaHBN);^6NK\]2RBKNN&)b#J.OB),P02&I7X4>CgTF:dLLYR0^f/M\9
]+B/\@^KdeR0c(a)(HN)C(YQ&8.#8<A#Q8e+B0C?)Q7K?0>4MPB03WN-AD-EPLU]
e]9<RV0L5)J+GePF&I&)&(#@#[>U@UU#\H/1Y@F;]V/82HC;I>QWVFe8[^EK@]MF
:DY,3]UePbdLTXLeKYAFQPO]fdHVg6S.<g>dWP@aEc2#PVN<#1+UCcKP,1Cg)MeS
81PM37I3B>1ddd):8Of/VC(\VaX<#T&4H&CdH0.YE:AIf<a)Z8^aDR]&U2?21Y_\
cIA^149a-B]Y\4D.S:G)H:Uf[f>ENa:YG;bKW\?ZS#PfI,XBW5&/(-I+)HUUYQ2A
^W]1TZ)I>D?JS-]4XYKfY-Ea4FB<X^)3-Q5L^7Bd)XbBR9I?QRe2VOc;IHHHPD^)
:9&DHR3=&a,8W5aHc,5Y<4Z30gQ7]e2FK,T#7F-9\2G9:19H[RXgPVQJGI@HG&@b
29O6&R?Q]bO(a)E#J&_?5Y#:IK;bc@F-8fR1KMTIT6-eB\1YI7[8fAJS+^Q0c9X,
]5@JWKL=?9&5.&DPMQMO^7b#GT^]MW=>(5:J=QV,4f[1GUE;^32PGDVZRb:G0dH,
[JgCaDW;^JAGFL:aK.-3F=.0NgLP[XW#aX(Ic-O5Ra(D@,+OS-]-,@d@ceabDLG+
-U<PG(N/dX._/OMD:B=0XaA..Z/Z.;[S6a7B]_UV,OOEeSCE42GHZ\;SCdQdZ1MH
_LO)R):-:ZK?M\f),/)VbI)6#400Z5UB__3/acHdbCO0\fX@L#(<?17Y6ad9H/)P
>[(/<H/W@1B&PW0,+ULKNHQFgI9UUb^>]#N5K&\cfR47dc4SF?80fA)N2#HKcWg2
#<de@IC5C\8?8LI1:VDX_/@EWRaCA26,(Q,IOaAMdPa#<E[[.FG=\Pb^;&ZFbN5b
^>K09AK\]@E[e15cY-gGbe@c_LEKC)15;OT&[?TNLH0<S:C0?/SX8P@a^eR1#FWN
3B/6PZfR;-9\1#X-ZFI42>2&)Y=6/3ZLT,4/KBG]/3ZY>gaa@?Ne2Q&fJQW+:>;U
M_[L,&TB=E_F=JcOEMHI97d5Oa\8]>RW2eW-4GQKd/T?HO)UG@_GQ.N&QMO,/J#8
G(=/WG/:.1_T&YY@<)NEOW3Ed1YX,Re^T7SC6R)5OO8IJ8TB;\KEZ[+TYQ/OPAEV
ORM;UL.dF\[fMO4CQ0AW38_Z?A]e_I^#RPZV&?AH#BM?Q:PE,)ScPKfL(LD78_-T
SLe-I1-#(QOgN<&QRLB/gN9aKK39]UA3ORXVPR]fU4Aa(?B)RZgaA;0BY\a=F+44
cV>;[Jb+0ab07,e+9W_M/H\GH[9C/+MGCF5PcKE/@H0;]S^TUO\WXUTCDJ/KF>1=
SH:f)d8+WDd(:R>#1W7X4WV?\27B0T#Zf4_g6)EV#QEBL:KDL;Y&L70YX_B\-[5+
bbSYeJf@g:#WU&]A9=_S0@b/Wa:Qe,Y5/+N>B)O1Ta;0-]_BOS[De2@TXZ?_-Tg=
T7K,_2\K;H^;a5-<c2@5<G.FDEPgZc@8O_.+L([.dQG&Y4(7(&/(bGE0DVCd<[ZL
M=XMR_8eQG&5\EUQ?a5-:#@+L3)CIPRXUPV^@c<PZGT9[f0&236XEZJW4N&]I1.V
<:5XB+f+agO<5a31^DYI_IQ=@WRd1+9E4=97M8d93D5;8MQC(UOAJ.eHOZab#WY9
S>76YP>D/PBWaAIXZ)EPWf3K6572JUKKC[a9T>e]c]H.Ua>aXg<J:J)A(-Agf^<O
469F<>65(WRN:bDK/33LNU]e/_U,fN0VJL5)B@V?N;8Ld2d.S))559=6&cM562S9
_EMQEP4+)CNHI>=I#\TOOd)B/dQcW_ZgTf[,7f7T@Z<4>0JE[LWgSgP2/#P3P8@\
@Dd1P)1WYYO#-V^=[?If_JMTbVPY(RBFF(e&^&8;#Z&b5BdW^-,ZP1,E6Q^G,\XG
6<P\<SGJ;H8M:,Y+7BX(3-eaV21&DbKJBA+G=bP:0Q6a1JOCX):.:FXM3\#1@W\-
#MBfc1eAS:BL0;D+0TgdOZ:..AB2AF-]12+7HT_(P)3)^,C8OX]&.SNa]c+O;3CG
U:QJIC(;=&OfOIb7)(cI2V.RQ[#?5Q]6.O.L&dE,Odd[I06;CaQGc>f.E(b-GZ(1
IN9SPF(Q1ZSRCe9,c:7UZ([<VC7^^2GB&]^7V_5A[WQYfaPMAXd5/5TaX>O#:CO>
Ac5TJX[Z+@(<=_e4=S7:R7&?YMX,UVEYaB7aP)?L_70^@YD2CS9OWHZYI(1,9F3-
UK8aFNFE\#47XNAbJaNGCDNXZ>P\+.P_?B4EdNfIVg&&<bQJM46,G@&.,PFG>DZ4
L#3K58+?)4b2KP.EL&a24CNDHZJN3N_?]Q1<dK_]&0QQb[_3XbRB-f4V/Zb1SW[=
(J_F?JP0c2O2>7+L.1=/1Q&;[0?7OW;,\XRN7ATX_N9SWFBUUfdb)7V7;Y;HOG]1
-6e=2QX=X[gY5]2?<Q>KK1:e1+30B[+cDA9KARXTNO8Lf4^(HAc;)g+5?E)6<,T.
a8@:SYd?HYWBV#:B74^#Jc2<W?)X:20DKO(ZYW_b65\d+_fVbAWTIF;)BMcW8-Ab
A#LKM]]9TL=e(WMZ<&BEbPYU?@O8SGRZ>&HM:(T0C4,NIYU&FZeX_F^I)T[&>RSK
[QY#5\7JKf-.6CK=KcNISO@1/&2cPOX::@[^cKF[9H^Q=5YdP[0BL\S+4<40]:<E
eW>Aa7aeEJY;gfO;dLF:RNJ.M5<PU/X71@@g1TP5cTgYDMC61P&gE992<N#Ce\/&
e/d2&8XX#43gb[Q)G.Q1TH^M/fUOgC[e\c2#_eK9KfA&SXYb1;]:B8a<BTM)=.E+
(gOc2EJ4Ha7NL2f,T8[G4^+(TeL#49?[2L&EQ=aYfTE10bPY/8\ZYL,S^4J>&(#?
(/.;0TZ^G70>0BY=b(?PJf.Yac:KfSgf=4-:4C?X/g6H#DBMFDB.\>M>GVbBI[R6
TaEBgSQ>L)F[_60Q=+?6Bc-QJHB/_NU7A)\[-5KWZCG/+GeF/6PD:9J-aH16<<Lg
^BDObNA3I[7T-#=b]8f&EK^eFQ\,Rf/ASd1^??_@LbX-O)d5]e2]cEQZ<N0;(,3G
P^V@0H/>_J7[fa45M.aL7TK>?R]B51L9[R4f\SP(M.S;9;7aLD@HaZTP):b4gLI-
G]_69KeQ&I:DD3U;ga:WR_AC::1EZD(1EU7B:U);f6M:JTG7g&3LV^efe[.][68/
+N^VY2J/JR&-EWZ778ab_M/#_L3efIB=B\db6,[Z_bH4L3:2;T\@0&MB:Nga3WR;
=^Af=V@]BWaZ4#QE-F.S);)J([<[-J[Ca:++PD:N.\2GZ@eA<gab(F3f@;U+RST4
Ia4YBZIcg+:NDQ=a3Z-SFA]\baTCQT]F#c5gebX7V[g>9MFI>DLWW8GLb&7Da,>0
Y;J&::6D+cR+-78+.UfJ-8A3=AA/T=a15bX=BDF:c2#?WFVZAFR<:FOAPHL\).TP
O23)3_5WD/_f^>2,dN8_,1VKb,c1T(E]eP8H<P6>4K/C?7SS.TI].Q<O_,@>&.83
Q0V;3]PARQTBJ3bC<Na-a:e_;&PMO1/]0aU?WIT@#)ZE\)P0./YW^R2A5Ve-,^3;
CJX0KTde1MAOUQ,ZHCS6MB.:5(FYU)1I.R@2//CTD]K)[8E2.0SLJ>I0F;EE2T0[
XcWe0)UU4[eZ:RG<S=2[=C1gQ7d4T.H#=]09X,_NXSLRAK.KZ:DW)gd6.O0:\FK?
/B#Da6M3@gD7V/KLEfO4c?N/_=X;>QLX3\0&b_5P:OMY_0,/dVZgVWF\JEZU23A&
<3Rd[5>QM8fW-@K4cWZfGEYT6U6=U?LDQ:\_#eS0IHJ@55L+H#N-BUPaNfNGb9OG
bH_4Vc/2@Z1Md>BX4.Z/G?Vb:0SN<:P/0PCAMe1V^cLRgS_H]=?O>,CSeXS28@E4
fX9BK#)b3?;b9_6;MU05\7\LSQg;Y6TWeU>SN)2_.)BJE98aH@TL<]->Je9X6MS/
FcH2-b73E7Z#I+VBH&b/IC5X8].JSXWd-_(U\TNbL3Nf58Z@86LI_HI:d<:59TgP
1N@5CZf<O]\Q_ZFLQ8.+Z&9-.,^_cPg]7\.SW+PS&I@A,GILDOeJ<0,8:DXZd]95
&X1#_)MG43/Ngf2;\g(G^+)>:GQ,6\b=d>A9R/+C=Gb:7=<\HE[QXRQ0PgJ+##0A
;8AF?@_B+bFR@PZ#RY]\;HS)\1gag0B2;;_ae9g6L]0GC[950[^)2LfG+bga,MJB
+<.V^I:?EZ?KeRT#__cYO-OT_RMN_38[.5[Z:MTOfe/RMDCc02=4,a>01eM93NXE
C__(<59I//Y\..ec^Of=3V#J(9@Tf:M\Q-WN0d6feLC^Sf+FJL]2Z_dJUA\5)P[P
Je8:TPJ4H@FCD\0)Cg\20:F6A5fO8&P&Aeg)9TZP9F\D#HDUK]0AH6/)WKGKGg;#
2U8^I(&?JBH=WOAL2XZWdbX\.ffd9EOXK,3=C_RFW9cgRZ@&3+b1X>A>G4I\M\[J
:P?XN8EeXB[[:Wf.(IF;>AS(R8CNUB(?1H3(1AFbK))Ne?^_1):)CQF^LOJE&&)Z
/9HTS8T0dABX@ADBBFPF8E#Tbg54KV&Y<:dZ:Qd.G\1[bO/&\TG>V;B?0H#JMDa+
Y4Kd@c9ddYZ.T]Z82U?-:,C8@#VK[c\SS<.HZIH\QR&YLeT1d/La5J8ZUS0,9[B#
,_[(6@^KHK)F[1b+Dd2/:ab,5T-]GD2?G-PVCbG,D,./]J7MD=5f7F^e^5VRD#]e
OG(c6A-T]c_8Y-7I#B5bO.@Lg6&a&R6&9c>X;Y68X;G,(CEF998C<g6PGVIQ<DKB
IdQYNW2,fQE&HEee\::BKYe/3+81gGc)1MQcNRT]X3a_:,;F1N]bO5gX?J5Ke]:5
9FND;?LXL;aa]8,2:ADXL75I6e&ZE)3LS4?R+PLP>d#BO&>E&WaET;+^ZPS;fRA0
=G4N1P]fY6\?T<QI.feY]UXE.cPXZ98ZA;dY#Z<W87UD3T3d]RKg\HP]Z.B,AXND
@B[9baCC_gg]^D?<Sb/D=>T.BK,PKJL0e\:^48+NRB/\Ocg/5_7C6-TO&,1^-,+/
;Na-N@;K2>L2GWA\S3?;F0C&QO;4UKCA[,(K_;622b(2@dQa\c7[(U[QXJEYD-YE
O=RPXK&-@C,Z-11JKaFf-JU8QA7[cAOAP]T::?WU(&d6>@9,=-M8/IDQ3QQE@67>
4&#<JC4@(B33d>dX>A8NIG\]/a;EG(P)YeM(G++J8ZE<=C^;P(2#X^>IGW,>@LPM
HbK0gc?Q07cDd-0JI1;<9G[e.=K_]gMd>S;]2MY1JYS1YDW5Y1#11&RD_QCKH-I>
_H->:&:J,3@H::L]>-NccecKWE.;713T2aM#A/7G8g8TWS7.[E_cBcP^aOY6_QP?
^FFQR;DVWBAWg.#eLdIBC\38NWaaI?UD8T_dF@](]Hf6>WON^QQ[?#RRa&_(1/Od
,3TcddA/S=eJ/C:-F29VKHDEf?J.QJf8N74e_P8O0@Mc6,SU-VY__PJe>K7AP5OE
e-EY3\-)[2;]f&Wbb3aCc3e6M9I)MNROe>U_c.8N57]U)&8#1(I&LCc=#b2+(SC.
@J9VCD4bZ^3=NTUQ,IfbT.[\D^WUFO;C0JARY5+N=]<a39CEg[eW-d76=OSeSR/[
YAU&E5GHE>6,VFL)[8_d7FJ8NYO[Q&U3^gX_/(GAE7],KGTdF&:QJ/WW,6.Z)M[D
/_<]V@FSLIW=0[6;1_8Yd2DT?[]@SUTGbTHg?52,U4:(dBJIeWcTS,C2N1APHg7>
U^D6UfYEaHO382Q5ID+OFJ4.,d73MJO+,LF2A.B=WWKba0c#AF;?0MAM=9+DOU1_
,d0EK:SBFV#<_R0H,a_/8?RR@ANK2,EcJ5+O(Ya+U/4#/J]/\.VESNS0^N>T.(V-
a&\[RF0NF3\V,KSZ]G:ebI-T-K,5&ec2&4@<feS6.]ec-(09F\gWS9<F@(;3dGH>
Le2&>d03C<FX24:Vc=/1P?fT7Q>K.:)I/,NeM^&,N?[EcW_d;_3>MUV0#MXEAAEO
a4.8I:N\G]NT2UA,F5RVI63V+]Q2T,ZKYbbISOF:OcA#0&&[S.gM30MaB18MOEUW
4I-&(NIBJMFCZ)f\-fZMd0=CeDeIAP=^TM_,,U-HQ73J3N8L(LF&G-H7>5^P9_;E
JfF9KGYYZ30>T<#-X8<G:e6<I634M=H8f0b(.7e3Pb(XQ^48LF/2)GBABE,OdB<S
EeWG;9N([.VG=-=L2T-6](6?/B7,]Y<=-;L6S(D]&5T.3-BN3b8PN\(32C0=O9G4
T@B<.W;Ud/g7dVE4WE4dY:aBM;WR^b6OLS3->QT##O).P_]FQ0](NA(3I$
`endprotected
`endif

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
`ifdef VCS  // VCS Release 6.0
//`protected
F<GS[Q2XeB+Q))2e)9d#<<52,bKT9[-R<:G.9U-J@e(TN)H/WW).),+4=#a(-DF0
15XX]fOR(_[P@0)TQSgg:G?D(WW6W>1AcH;^[TXb/b.)D&SEdcUI3ZU;QP4ab6,L
?08<gH)A@f-IeNeV@VY7#]+1H[Va2M.,QEXG3bI>70N8S7>5SRM6,E>-_Kd,>Y@N
J;#_De0;225;\OH3,VLOQ_eV\MTegDM3GaWU=+e+4;^QHc.Gf20@PJd/=U2&SVd5
3/E=Age:We=[8ffF\]V#_J;b0e(RA^_&?3PcA&Q2]\,K.A5Wa^9gYXZbFN><MV1<
I.Z<KQ6LWN]3T.[CI2)]/JKb2^2CUIQ301@)=_>JW&b7^LP-<G]U6Z;Y)9T#7U]e
Ac#Y35C/J:^[0,OH88>c)0f&(6fGU+S.#N]gG,(,Qb_&;V^/870-TRO&81aI,bOM
b:08a=YA)G#]6KIHf;9EfHC9##[Da7=^RG60I3ZC:K2E?\@-D1I&#\03W7;D5<=b
+C4\:)&)7J@cH(bD>cH[;eHCfN7LLdU?&EgWgHRY&?fB3Wf89ce(Q;VW6cWXPC9]
g^_0XC/G3dC5A_??-[>5UT(LGMJd:N2]EI\Ga6TK>?N@bBf#6aL9<U#_H/ZFRGT,
_KBU5A-EDaD8Bg9C250?4:R=@<E?B?ZNd1]Dg@7.SGf<C-LJ_5D+_bYa(S8>R.fc
3(Cf74>NTZ;(AEAE:6Ke?Y-I+XBL:S^T9]7:WY7]gg/[Z=Q0g\C@JVUM\]_f#1Q@
M5(=,b=f?OQdd#J?b548)e.;.8;:.&2JI^5_U23[4V1U4,RD7fO735Sbg6,Me?Ce
WFYGN:E58)^RG]ZNGQUNA(&V[HN0a)>2.E;A^)<G>>AOLgM=:]P?[:f@(Z(M_?U0
2?D:T.&Q?102g.JX@0Q3#X1H(_Wc4+PFT5_bN,=Q6d.U3UQ2gKD+@bO)XB4;:bD1
N#Wb&(DS<H[Z/d4Q/R,J\?G-@QNV53d/0#CZ;TR3)F:)[V@T]@4Q@EdO,H1>E:0e
:_cLf?aRE<\T^+P,4XEUSWU@AO67^.cK4cXA^E]Q61\eQINHB?9I2NK&ZJ1JJ1cN
aX]):L]PZFK_WR5_fIE(R-TTaAZT]+Bf4^8,RVS(_U.^1>^gZ4DTVdg<1^I@?V&_
FQX-:S:2B.?X29a[/K.g=HU&KL5UI_0QZ_HZ<Af->9&6KWWZAg9fM@>9&XZ7c3(P
1Ie5R],_eDZ\_?TG=9^1U9+G<;_LaM9#)[&NDX<U,eY5J&DTO\CD6Sf,W:GNEXVD
M<R<X;c_2LJ,TcCM@UWJH/UJUW#/AKDDGfFIY&Pc#-G-.YY<\V9=FAOJAK,7MLSC
cFSR/&2(.)-6DECP[3LMC&D7a5AXX0#SI9Z.;_M81H6&PG[HJ:R@R=@?XIFfXCPa
WI<fFf,<3>gc=@J=g,HcYP().Y,cQ-]M&=VBJ-7d9U/Se#12Y^bFF5::]PE9)E3N
TJ;-??PeG.6N[Qa.MXRdCUd>0S.ZO>=XN6R[90FBgK_BHVfG3BD;1_L?3Rf6-+L)
V3U[QH[]G>S608W1<6bN0=a:^>AK99@\[^<EN:=X7?L1L1fBAE23?FG3f2gfMN00
P>G@VZ2e8Y+RJARDM7)(VZ#][\SH80YSe1f>F&B4EI]2d4c]f,.QZDRZS#KB]5IV
=FLL\AQJIg&8HV\Y-I?Za<b\W_4UP&UHDNHg#O\5KN/]W^&eP]U>1F0#G\6^Y?>.
W_BGTU:TL73268dMHBFCV#J9VEDZ0R/U@Rc;4&65Y]9D8.UL1Sg^[H8CJ;c\F1\f
U4AMS+CG6;S;)QJg-W=8F^-+Bb[E-]TeFS\;\CL,HE,CA3[XZ>KO-T&c2?[OMY9b
-g[eQee:=XU<.N8,HKF.&b[VgUPFDGWSX/J:5H>@:@51@e3;YB1a9),&S7EVBO6I
[:dE^Hf>:Rg<4::TR:?B0S;W\b71]#LXfS2C5KY812&R^GI#,@(S,,&P[fW,=TO7
eO+/Xb2\UZXWK(#\59RHG\J_BA_aNY;#c,I>()_dHa&NcSN7S21.Od\,9]^:b([&
53Z4WQFQ4TS/B[>_^IOdNZ(aRL.YW.Z([?OTJ:JE2XW_bM/O)L\GS/H-/f2cP_Y3
GUT/852G8\3\)c:E3c_/JWKbROM3TdFNIMV6JHNA8Q?H6O>9[)88R_M:S@:T1Y4X
F?OB7dg8C\0Z=XaI/A8VT.V.d)N-?#fZUMQMF]61(>4N:TdbaB;f]3<:Je(fZ^+5
+#XF](AKaf+.T_^W1e3c\cOfO)S@QZY.^gQF#,)+HdR6+7<+GG/Jd8C&bJC52c\A
W83f[MaaBVH#VBEZe_U32<JB.83:RNLNA\TPP.Ha1NS?&25b84:^<OJ4;?)RY7?+
N).gAH<E+2e37(O;3]>/RX\R=V]+Y@R;P1Y?4^Z9X#XRVOJ:gG5b(G5FBY.N+@bK
[=R]d2R3W,FAY+Se3MUQ?e3@=GX[JYQ+7aD:@A4Z^aEE_\VGI-gB]^-&DLW&Y/G^
;>U@b_K/?\A]dcC0#]/dKSN]:dPDd)CA?^C;9YeXF0.S5,d,Gf(1AG.C:fS8_K#R
c+@D/9P.V<]W3F8X)_WOZ[(gVA-(9)dVe4T6DH^FI4[4)8-3.g8;,Q+139UU1R&a
<1;a;I]b#+]?bT/33LaVca_3K-.C??-CP5gZ.fPD6>3CQ7U^EX8GNf.A3LS[#\_Y
Df0AdcO-BI,42S4SFNcHFX\=W8\B6O?_Z;:>aMW:<[J]7CNd#\WVIKd&SL8?M&;^
4S#HX\[RHf9d3,ag]PT:3@O4>LH#]+7\E,,5:bTa-YZV=[@Z,O<5PUA7:V34eEaM
5)1@g-=UR1OP7)VXAKFQD:e+8Wc.Y-e<b/9a(PbGLa2.^3e[#ARXKQEP/2FLEe-F
ID_:E44cLXIF+8GdM==N8TH]d;?N7Z+LE9-,G3Zb.+fA0;\]A])##H456?0.&aM1
>2L&Peb,<44(dC:c+^H<.6\7DX9JT&1_LB8f7V,>UJCF&5>KSW[0<,IWQ@G:V7D)
&,K[>JfbFMAdbaRAR[Xd,eId80bTIX9_#a-2TF0JCUIeO4G4.QPfYZZd^V#0\#:S
NV8E<#/3:Of]a+;b7.W.W<^XE-V_8=7/1;N\=0+8Db9,^X?9,.?SIXZdP$
`endprotected
`endif

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
`ifdef VCS  // VCS Release 6.0
//`protected
=1-PY>_A-f^X,ZF0-#^^<B(D<^3e)46=(LU2)ANO=g(XGa42FF<2=PY]8<W]<+-8
N<b/KN1ZU4&X1b.:;.Z::S#V]11e/>5O)BS7&AQ@=53gR#186JY;>HR[K(#+P,E9
3\69##2gW,d5a^#+gSX6fM3C;(<+)f@9]^.?7)J1^CICC669Q^W&8[:OVPU&/EUU
aLGTFf9VXJJ]^#@C[ZbIYMFN7>6]Ae?5b(<GCA0&V\_dW#KJK/1WR?T(f/=M:QES
eJLc+EGfXR]=U98Z(:6+23\F=SS3LW5f^5^R/dZ-(.NW>#\]b8HW7dT:<6abRG[0
&0N@(Tcd)GD:]\V4g]gbCL^Z^Lg6](H@K5;5M[[g-f9L6]YHHfRV:GD0[\/\,DEc
0cX.^.2ZB.O]+@ZPX=B<+WQPAAIFU2eRVNMS#<C5;?AC+V5I,,>.4aXK)66(N-^E
J0^DgO(05AXc2Wc5,O\#g71.,P-1.#TS6WKa64Wb-,852@AN_?KLe5T/=cM-gJ7-
bRY9Y^-IRd8E@KITMATWVLG@B^DH\\d+Y-#EE3&1[7Q[2(]K^Fa3_<=[U010T^-#
)bZ.]Cg\S_AC+\OA2gR:?X&V(@[-+0=/<SRQPI-R&[a0BP5I#1a\PaHg3eH0b3=B
eKY(O^S5gJ15-^>Q:\,-da9GRB&BaBB1[@FWN)U1A/e:,:gdZDAdaM_4&D,&d#OJ
4;<<CLAIB/Xce4XJN:a34.gS_\L=H#f=WQA2(D;AeWHgDRA3>WQ@12^UWaV4:g0W
X<JN49HBSEeL:,6[7JHUN/Xa_F0:X:K<U<#dX:5CP9VId2I=PUWdFE+84E7&;X,=
8R9TDLeeVc9NeF9^X,M;U>.XWRd+0L\IU]@@:&&B&>e,-M^1&A88V(,:3SFFbQV3
g=.#dX0BQ3U[]A8B[2UUbTLB1&?]K@)(==0:TY[W\H8U&SQSA.Q@^,_^c0W@C:+[
IL_#X6<4(#R4V4ec,BQ.K=fCX<=F/4SaZeg#CNF+EL<<-N6=P]@)19[&HY)YVF\H
702Wa(<?f4ZK4X@6)e/gD^>W)-P.b#K@U,]^e(.5be^gdIAa17A#<IaJ[0f^=O@?
.JGQ2eF-EY<a3,[5e;9E6+DK/K@+_]TeD0:&14BC7OB/>.d8,VWDA<&I^a^f,_^C
82P@0eA.E]ZC^W2?5cD:=7?:>0H.?5WB_f4&)VfM.J/,^>[_OF<K8+SP8EGM._#(
Zb[#FC&_O+FQaXOT0L0eVCHc5M(2XN?]U_:P9J#HRFYUAX0=IC6[50B]]KL,c\:6
LL6E376V)6+Rb^2>[[P@CT;+Q=[,H/4-36[cYRYaaQOF4BGb>G3<Z^_@Y7b/.@X.
FSgOJ<LSDC<DY5^EOBIK?fe.-.bG8ReW1(A>IAG9f7:EPbAJg^B<<LeEOc\)&eT:
9Q9Q7VLBN9f;b)DZ#a=JeA;[F5&G.a2[@.<_?[2..:cH3J:0SZD[7\31PaJ1#4C1
R4&)Q-EE];:<Q].JEJ6(]#P.Q_+QfO_eZcY4XAJ0?G1^M?Ra/]V.X[A<FCB-K2LN
@OR7O^[X10([2<79[7D<YQM.B+fDLcg/f(dNK[K6Yd4f?eN_T>GLU=&Y11Sce:H>
#)_(C/6<SR4E^LW,+=I-&:Ne@Y[,MS=WeXJS<RA92.?f,;cFTS#@V-YKKc#&1G]F
9U(YC[VJ]++O04HWC0B>-=5S._=RU#5:ZeU\1\^<I.?Vf?>FA_CZ-V\)+C9E7^=K
3WXf3)Q4-bWK^LWG;a2WgH.2X^:Bb);3F#7P=I\K5)Z6B4.1N8/L=G3DN?EMfd,+
+CZN?(5Kga\FF)cQAE8SS_5V5X=-XA-7VG6F_FQ./WLW5f&CRN5#8G8BLVbR3]NF
W+TE4OXY/-WNK\.QJLg69BFAW,-NE:CMTB;7NZ9-U\-6Z5Q3Y]e>LZ-\RM+\fDN2
]540Y_F/13;95AQ.N?M:EYB^0O/LOf7B<Seg__QUDKY&NSE6.[D,:H+^KHa?.)70
#&45W.b<EIHFMT1:R^e)XYD7,3YSH_@J+^e+M<IO=&6c?R58V6)BYG<(WTRH@,:H
M0I7+T<8Sc3@7@Z+E)F6\W1]9CO#N:f+=^81C)RAb_Me7+6a)DA6:1PfSb3OAI,8
NDDZ(?+/IM=XcMUE@:R6[/&3^]@ANe\Ge0R0)X@6U9AB5?4dRZ[1eWV]P-b6U^g:
ND<:e\6>PNfJdR^5XG[\0_,L4ZbP#^-0_DI_-b>0[39A).)SN+Dc(P>S,c-@4CEU
]A@SB7QeL6//I^](6EG3>c((^DD5SUMA2]GVO77N@#NgXM^c@DD;HSE=L9fKZV+;
-]TQg0gIB+0SSfD#T>UI8D)&BffP0&0E>bg7;[<@e5(BDDJ<=0FDM8=LRR9-g<SM
E<JK,2ba?K-P0a@47B-EE3T2^D4R^+AfVI19U/f992JX0d/D;56R:QP3LM:VF&g7
,KUAY>?#@=d;1\^6,?4R+7[3?E1X],S)>>D\PSE4Y^ZGRDb8V4ZbRHE@>Q?DcCNS
AQ4Q4JJYI7dUQDNKUfRcadVA)R=5#Z^2DL[9YdG@/T+XNB7G>YT5DPIOKO^&WJJe
A(L-,/ZW]PV@c)_B;F<DWQf_.T_V[IP@U8c-\_^/@0DO>DN)\@IHB)B6=PLXg6P#
3RH^.F1]8FLYfI4^3+^?#E4.1]:<)]S(QgK^)WO)X\>a(VfSP8bT@<TJT)SVC^()
2PLVHYYfF&+ffQP>J,c;2P5L7DAg0H:3f9Yg:f-W26K(?]MF4-dOY#X_Y>@]g<E=
+S#,VIa<-L70#beC5<C>1^XZ5])5(E@PW+-H6,7NDWJBe-OI./EP)2&@5:QP)B+8
D0L3#K?d?85#),=cVU>a11^AJ<->\F[]]:ICS@,R>g28_H^^0MLA3<K)d1P.,W+T
QbNQ4GD:XOL6X3-YN;P5d/^ND4XAbIFA^\8O5a;,->9267a[KM1Pa10XR_9_Z<V^
K/-1@1X#?HF8M834a7fD+>^/3cZe)@2YS1T+UPFg8=fIDU@:NP[L8I.P+ND5TXNL
6E[)fE9@=L\;O)Xg.>,(C@gIDg]3a.+DX29_/,RE<D=M89eO7;74D8^#g44/:9b1
EC.BV+@fQ-D3<+9GdM5NW8Z[,&.Qe+W4aH?_&+DM8Z#cYTG,d:FgeeRNN<FE)>L:
0C>HKWfZ>\(Ib,=NeR8.SABFSD)->K>^;BYD2#/?R1T0L+<&#L-[9>PO:fgX1#U8
W<]DDa8@D.A\Kd=(Ua0Tc>gK/&]J^e<JB:.,Xc2(KBdeU(<;O>FIC:/6(W>[5c_O
7J=TLM28+gg6T?K?^1&#)CF#R:ee1VeMBJL-WU7I0UYI\=O);>G0c<,7af>4+:=(
Dd;]&Q.DRS_HU6GYNd\?bO41gc7:<X>&F2K7G;)<&<c4.Gb_U&7KbLP=XXd;KW>2
9O=E-)5=9=C-B>.e1<3@;6Md[D_H7Kf1;_,J#=FX+=SO<(TPd5-6W28AXNXP7DSJ
)&+gcA5>4)3TYJTC0Ge,8UBV)1OEN69M2V&VF5AVI-83,2P-Kd2d6NMJ_d]?FCbI
0D0BR;8I=5PBL^CYO]f0V//4QSU^2>0)(0J7FC0gL5LV#JLTNKWAHXT.-GLB[=H\
RRDC[+<ZE-?B3O<d@D&+HX<H)Oa).]+:HQ#be&&-FC9cJ,=V_ZY5XQR_(_QdgL4@
(S,,FK-9\15:&V@&NdQM?T5?;UbONC52ZLS<g\&85^_H^b?^7JdeA(/IbgFX0L-S
)QXGV=2Y51M51+&f-X;>T_XP@]PU?4>/)dC:G[4aSQ+#M^+4b7[4GeIJ5f-64/7O
5RX:YCd\R8-;PT(BOOYQd+4W\VWTFMO//44M7),#KSS[.L,B08H8Ac_6]ZL:?7LN
gS-104GG4A2P00O3GK:cR=:fU87;FJ84D[A9-eA5,V-E5)f2-Wf?64>5WL8QZgfQ
\PP5F^.A\/I]=A;b9(Q:HEWKLgIc3b<dR9;00cYabED_[4.Kd9VT4]]ET;a[5H9Z
M9V=gWVHUE]R;C3SIHFH=1+\1]8P#G.8d1>XfL4#eYaZA+f7-:^=WH3-XQ6dU<ag
6Be@FN(F#QSedg-5AN^I1MUE?-0.d((<U3cY?bEG#)5T2AQ^A-^(J+(Sf3a))/F9
FE(7[3C=U).4_1[_H(FUIZVGcX.7L<3)+FPMZAbd1@A@A4SHTLI9fW#?FbBSB#8,
/HdgM/))YfK5\7>fEP9(NXFgF-3S2C9C-VUEER,SO4BRK@SR5<EVQSbUE99VOdBT
&0+TVa:N&,QQW/bU+12#;QER<#RUAP<FIfYDFgQ0Ae^_(C+d^Fd@cVaT[#M>9g9(
P/=(dXOMZT@GOeReY.)4SK^b3cME.14g7,^&16DU\R4KF\CMFSa<C8HS27:Db@9)
FHWRJ[?&ICBE9PW?>EA<1DNHC0YO1EXFW?[EQCf5LB(46+N94V8#7[S83Afd4FQd
g,Z9fF(-aagT#;4EKULV\#I,S3=Z>,^_^-T,M2Q7JM0A&,+WNDaTOOQ]I@TI0B[O
[SRBBH[@,U7-VG07=U;ZfI9.Z#[J9Z1G\F^0/P1J+@;)99@H,L[<=W3GOe^NW=&A
LZB4B#U/O2R87FMB?d0N=d7Y?eOIg27G>4_fR=I?2YfId]C4C/R#KD1TUJ_-d5O5
J)-abDYaL-O]aN48Sb)]aFE@MBW-K1H=P_1O#NdY9:.Q<KGH5B3VS;L_TbfW?C&9
.1?0>Hg@A>#J2]7ZLY93Z8fc?(_I+M=]<fJ#bT=J\4;=#LA][48\B-C^@/?afBF;
J62=FYEdI.P\83eU?1F6/BCW&MDHZ/<Bfc7bVE\RBdVD#Jc>eV1_#;[?BMV@)1d;
Y]6g0]AD+^=,70\4)<7#HL1:).C=ZSYN9?a@B)EKL^]/c:VMe)a9g0K09M;T?]YI
f[8aR6OXJ:c@?ROW^8e>-dL7S[QD?>#WeMf2(OYad([DF]DEaA8e#c@3/;gXBC)Z
@@:#5,5/^c[V)/0XH15JI#E+]=C5P=W,#AA4EBJ.E._N/a_Z[H6()_M(S@>R&BRe
G885e\6129&:0/=QRJf)G56e1C,Q,&OH;-U:>UTQ1La=?.;R6S23(d5S>\:#aR[d
]N&)?)4251V,;aL=-=Qf&##UT,fR9KQW_A0Y>K8M>S799g>[ATF(C5d)c@d0;YGg
e7fLEaOa1[?(M6>8&-^M6<)Md2<I<aL1Q>9XE^VM,,eF&NV+I6]+Z\5PPH^4&f0G
6:^E61K/4G0Ycf\K-.cBIM]V(+1HIQQM(F>G@S@ELPYgYFU,VC<bY9(\5PO,/#:H
J=.N]<U1BRN?+>(/(;1-(2cM=e0V_Q7[879d7N:/M::R4<,H^]NI+8FIV1]<d+E;
FO@FOVW2CSHe/0WaS0B:H5BM-E.,A,]3CBB#.)eA^2:#.1V4NIE9bG]L0&?ZWOWY
=M6VRcTQcB#/TAE6O(OTI8EBCK0PbA4/]N8a@c2V1<A6\&g^+3?A[eKWdPJ-dLS)
)LCAX?8bXVNK[]W[fT1R:>X&daXN_??&MEZ6]fVV&6Z<^@.U+)0[DW)b,JDOU7CI
MD((31E7HAIe8GMSf=X)a>YHIK0TQWW,EU?-2]ZP<1I&MH4e+CD&#YT1(M(]8XNd
[+8D6PYRe6Q/HD9W&M+XV<NWL-RXTX,OKGFAgWMJ4#E-PCVfSP\V5LdNL?e=,[:2
SSYQ(fNI^;+TNEW5)AT8:E6^GcdNS:#d<DLLS36&f_K=9d[-ATa/.7LK)W/K5YEa
0O8fc15)OVZPRF]BFY?EA?-&EBCP&RB11g5M4WGG)e[KRCE7U;/=&UFH2fFJV=c;
C7DZ]@4:gGHAU/fY83WBdbUfJbQ#102;JdNC.4bbf4#&,JABeI/91<5A<K2[5D2e
eP?D3e4#FafB,^+F75:A]JAbXT>];K6\Ff_P+<=NKW\JX7bT0ZZ:7?)0eO\U\dac
W]RSTF35.D3MG]NcSD@MbJGR15+WJYRXR5(]A#c-JeSHL9Qfccb]U^C?RQ?W\9gA
^N\+.V=8@4ZH?BEUM^YP_E#bB=#8[d?fO43IW69J6GXAg/=78,==1;//@<.)NTc,
2a&04W(f+T_cQ(O9M[bccB73Xb/3aFEafCB8^5gLP=KT)/G[TQe+?QV)JM1].Qg\
UINL>f&Cc^S)6KK5-96a<9>UgF[HNMN8#A&QZFL.>>M.&9/ZWZ+51#GYdW->e#Q2
.\a4CQ=1V?KRALeZ4EHgI,Y/2gU#.&I^S3#1#,](_2.V6@g0TY.8a26&GF-fB8M+
A;?Q8_/-@Gf[KT0d?[R5GU4K#70IN32B86bdHIB[[:&gP3If;R=0458>eQ;XfD#K
HO8FUUHbf:R7\?7CHBZe##:_5Zb50)G[IR>1UXDf&d_]1UOO>,9.DKKbK@Y&a<K/
=g_49<N/>+^)_)c0:C.#Sa])5JB(_c8[N8>/RM_TVIQJ=D,QDd;;]35IdKE/V63#
2T-]/47DSAZBNSPNVg<NES&WXYG#EI?BBX4I?\1[1H(8YHF/=7aJJV9;4<-]SKdU
;3+ZU[/L^K+WWgc2O7H?]b9UL.@]P9;C,?Y)I?g?YY(GFdN?,I4+YgW?6[=Z_/)V
gM^:H8c&.6AbZ[N>>/[-=JTPATPZ>bVLMGUUZ]7\0KAP;O1WX#3\MF&>KOZOHJ+MQ$
`endprotected
`endif

	
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

`ifdef VCS  // VCS Release 6.0
//`protected
.E.=e(@F<FYH=</()ZR<<Q2b-6_6,#EL)G=;)Ue]4QL22aJ:=1R+);\X9fQb,TK&
fBSNb\X78N5G]cVS]M#Uf[JZc73cY/OcG36YH>:b<OFgM:H<59DTFCP#SLN<-4^U
eB#Qg\c6HT#-2g7-J_+10W&7^XEC6d/KECEa-^?[S]4JM<d3A]02]6QGT69Z.-I9
]H57f?aH.O)#+5;X&V-JV6NG2>2;K8?^1bR]gP8W&[?8KIPDKVZ^-e#X8WAc4H]-
IYJX(]UZXdMRLZ;A1#;e5(dN@)E/fHaM7(-Y;AeQV@,e1ZbYZNC/RS>07<0P^8LC
EZXQ>ce,A9P>PTgg44D>GO5^7GL70J,g&?,I,OP8ASbVb4NIb.#(bJF7:O7[^6Q-
(TLA+[Dd#LEOT9[3U8]X8[#.\D_5,#GB^B74WMGAVJ?5E/F3;4E98Q#.:W;+,=87
Vg04BO7;WGB4<5cf]\[((SF57(/U8XNK&IXf4D;U1R0DCZ8fST-egWOX\SC.L6LG
M95;3Ga2Q0IGCDRRJc[.90(R=(TYH.^OfM6fe7M:f3V_58^Tb6)-SZN0K:f6.,;=
4bE6BfKdd8bB&92VGCC]AN(7c1YbP[fa[595J[8-SJ\,_DH9@f(&)fca9Re96MEd
ILcV3#:Ac0]QGc+XET7.b7bZT6=8[c>)d(7-=RR7M>JT5]983>/]^>a>[^#WD<[;
eOIdD+5^9XW1Z>HGS?;,?7&_C#_#C(91g):=,[LXP.)fKP^bUWU1G_gRE#,?1[NM
LF/JUGdTO<]>beb,B_EFL2W:Q(=-HP=:.-60)+DY;G2K-9@.Te#/6R]]Y:1<Z<fb
#_d=[U=99Pd-WYG-M;9C=)eWE7HgT1QRa^EDW,&,:ATXITg:5@]I(M0O4Hc#85?K
@JgO)5a=4]4SF_2[7AT&AJNMd9D1][;;Z?34X)O=7;88[]Jd@Xd&1I&@LJP9[+4]
cN6Mf?B.B)US<2gH(OC71KRME.;4+(_7X;-3,@bJ49cE)2-(RNe)321N8/]?Y5I<
+_-,a;<N?QH:=b+/-4)eASLf]SE7=UG;S..AY&WZ>f[Q6;](L3?\8.b<Yd&S^bW+
DU?7FV25Hd\+>#LZ^(<Ma1GQWX58d@YA&3AM8L\43XN)65_g#gcTTaDbTG@DIRK>
GfXd5a]A,1g>+,G:dU,HM\V6XY+\DaJ>XFe1f1;.<QN1XH.b::[V#DGU=QH2eKJ&
QXAOW+=K;S4&Ea>#0^&Dd]Q=@#aH7;9RDW9[PW@ZI:fY<QEFP]9?83\>E1d&O/67
\E3M:EAEf4I4ee0a;FJ5cRY9;=&O,S69A?Tdb>.>GKQ5OR,Xe8J8@NbF+5KWMaRF
bJUccCB:2@A,f>)8WXG;3U5D,9WW9XF@+F9/YLWU^+VF(#C<eFYXd\JZY[2Jeb/.
dNL(17TaF<43P\,9+D3I0Y9c^)BE+N=)A5?&I>g8IaL\AKf3^J&CJ/[+\N)6PaQ^
XG0MCZ(@G\OF0;H1FWdUZ(;0<,,WL-eX&_(LfD+DZZ:#H)2^-8U]3X4OcfZL.]d=
<TMKCSgeA,C1_\92^AG[H-+BE(&?NcM,^-OGH_Qaf)JS]b]AT:9?MeF<1fR\47^N
4XN^M@/G##]G5(7g]=J,Ka]KITaI<Nb.D50<a2O(Jc&Y,LP]1-7KU7R0;)M8Z&:5
)S>YgbF-I/021B?3b5LMQ&2>,I.2\AfYag.WE<Vd#?@=EO_S6Fb<4D@I[:ea5U68
0gVM-M)dDJ\d9LdP(HKH\]GH73QM:A9_7555=J8AY+F<OT#1\a3@:&RG(W:&1@+@
Z8F2XIg]J&L][5L[.0(/HK/_6_]2a):b.\=_P?Q-:f81&HB7(GY\#N=U(+@dXQ)8
XU5gd:;Q;GF<C&[dMd#.X027#d@g2b;@V99]N0.OZ40YUACIONeeR(,J,aPX(5-[
S3TD8?5T.3?GV2<@#F]cSH=DAYZ#&=/Q(gMNYg]F&T:dOR]S,AIKOVfKPec=&EW=
BP5T,>7YG53?g1HM>/98W262R;T?&0=H[W:IWE.d&)a>;)G<7P:G,V99Y9&:S/@]
>7491X9;ZLQO4H?8C&UR0I\ZI6NZMUfBN,M:GeO,1.UKKUU/178feXG-UFU+)Q7[
KK;Q&e>c+CK3gc?6T>aMG-f91(#,1=f&HJ[JBa=TQ7094N3?#@[1SeB#45dQ;L)T
D6?PK1NK4Wa2ABWI5D3-NCZ2dQ,agQKK4&_#eCDUe5]C7Xe5Q[7Q<gNf_FJT0#82
8cDObX3V&._9d_U=J2=6-B6/dd#9-4&YCU(2VBKe7+ZY:\>U;R)dU1L^.d-2E0>e
(GDDQdLI;^ObZ/Cca/G51CTWPG@#GQPP#\XMD[PSSMH?^1OC@;AcB@D5(B0:L?fL
SB;e-^^.\+aIL)25P\O85BK?K(QPC4bc>V5V[(]V5G7Dc=CN4JD4KWg88A4/>a)4
::[/O:e>?5F@E0e9^&_eE5)ZZ1^7eVb.7F.20&aT^1D;/6EJP([L>(=(/I-DFP_=
Ta)b75_-N(N2?6<E9C\Fd#\);^cB^-H\^dbdRJ:MABaM=5IINWZ6(HFZ[^6<&2_6
<ca598<S&Sg?0Y^NF&#aQ9BMY[T(SSB=?:[dL>G:M5F:D#JW.\)R6Z_C?Haa4QGI
EBK_LDFRga:+[W@d]TK1a;&c#7:6bM/J\M&KUQFI[]I^X.W=cKA+(RgcG0f0208+
)U,MP+:ZH8SF7UG;9+.X0T@&?S9J\8ec<g9D_@G7H_P=OXA5/d,f+M^_._@,R^1<
D@[<=Rf@219=ZOg_Cd@D695S)R<>2/E(fB;UC5XANaLJK5UBHJ,@Z#VSQCacC1[+
J/Be?9O;_L2?b-C&T+SQD4GLb,)B@,^;ZA]T-2:QB_5T/K1=HN.<;<[Z4UPee\c=
BUI;=/<4g4F0C#6A@^/g;&IbVWF</-@LLW>NJF@?NA,CO3+H?I3.<H&BRZNd)]a.
D56XJ^N,1c/XVf&3:<+>[gPa=[/(N5MO6O_L2(]XaF1TgJMOIA8(R+c289WF=aA.
.JLD4;[fJR>[XeTLD]?@[DL@#DQf,G?1S\L0LM,7Dbf=cF73VEV=RWAF&OL,<?Q,
DPV0\@@HJFDY^<K/WM-EbUH843#[&7YRDIbfRYJ7SNB--XP-QJf2_?[SNF7D..dd
)7S49=LS0H,0X](P=WJQZ&=\a4^eVU=30&:@P,G_b\_]OUZ6PYQ>71([Z)T54O?I
AbV4[JY@F]]X^/a+OO#a,->)0<>V=.0AB:I(9:TA/P62R4C6B0VNMIP?g?<Z8cF1
:5#7YO^KgBCb:AO8[\N=:.?A::</@[a6>P=M,eA^)TbJfaF0/V.P>XB&9<^/(3UW
E6gC(:I3&Df]BKZS<ZU<B^^7F3W(DQPT:BV<YMRcG-C]HN0CYB?]N7B&L$
`endprotected
`endif


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

`ifdef VCS  // VCS Release 6.0
//`protected
KbWM]G^7(gWU8f9U=(YX=9QD)4KD=e9\)6Q4=S-[+gN7A5AN#BT68_g@):^?<CYB
YUYDV]dGc)Se8JScQ(#)d+F9S=9a7,e5CTA8T/CF#7[gKR3Y#3>;Bd^]_<->F&Pb
\;VRC9+@6W=)DJSE3B_A2g<_4JOad0J(MKEeN]8.+]GBg90_8&LP27QD#3U92>b_
JW/EW&ggg5YGLc3Af414bCJ1]6PVHZc)LAIA#F9[/fQU@Q^bW1(f9U[e65gQTL@H
ScS9eCDN]RWF7/dP7AC<Kd-@Xf+<H<\<_LFG7^ONb3c(U5/,-9KPE/gH1U#UTbFc
eKWd)KRE<Bb8)]IODHQKP\)IB+GGT5#],8TR-2NM1[O14-^H.#?=W+-5ec)42f#[
eE#@AUNMLYX\9B8?([AV&.d-0DJaU<#]/FJ^R1:(R)ggX\=1+Rf1Y7eA61&L#b1_
2@IUCIOdc&Xa_73+17fgCMHV]0?L=Y4+_&W8/W(2(6\WC\NMZ+,VL/gX<]E;0Z^b
<;F(H,FY,H49K=]Jc6B:@U59-a7+Y:J7:>:<\SISbW4;W-]G0]Db#\W2/fY@:A9=
4ZM)CeCTBIGgZg6U2XG3ZX1BFF-9Q>6I85;?^^_AKLE_.M1?MP?dKRD5<VMg0[,@
RNT)(7eU1@_56&fB8.d?g=XF:8AbA#AI(:cf@69>-McL,gN:?HWS&f?4(P#,N4NR
>]=8,Z(]Z=0#-ZD9C+ec.WS)F(K&@&K4TXICd+3b^^:(a_PeJ-.fD(_NENN:<UcR
39ZETMY\V;=2?L\b1C6=BD-b\5UF)WdZ-fJ57cUbWd7D;:VBAW1D=bfJd1M:+S#^
A(O<LTEXBO.TJ;.X>?NY+D;;67-J_E8\3(8.8Q>f7#PH7VH?1_eT4+:U4UUMW.1O
DXD+XHB7.T,75e_4NV+gQ]TWRCNW^7GEPVM4OUE>Bf49Oc:DKJ;8Q:B#<,DT/XO3
44E+:&&?7c5&897Cg<V])G:OYC9+(+Ld/^Ac3N4?6Q3TE.2BfZYGPDa@KYP3DHae
fI2=.]TKbG^C=IA3W,1@[2I9Oe.-WQ,7+Q5[3VFG\21F]_^11^S>^?FO?<PX7:)d
A[DQU7Q1W8c&6/A,(e2bd,T2\K[FD:eV:4K&G78Z^Z1\MHC\E)V(g\I#QZIB>U,P
M-VYHcIN)7gZV2\]GAgRS,,e>=c(_]NQ,X8,+I<O#+f(K6Zdf1J4+?F63L-.>R=:
110TGKQ4\M(F7[4P/K3;ZWGaRA[DIXXcY<HV\ET8KGc]DT0:#RN)S:M&C+G3P:bO
a13A0I8#(9.\O@6McQ\_76Ig1S[FABAMQe(eY]c64O.gPae<8=IT+;4@@d:?O7DA
G<JW64>0TWM#^TKL+3Te7,TDf#YP^0TcH@#(I,g\a:MJ^>+e.^V@JE^W2@4f)A#+
eHB4CK^W5SbE]U34c4aMS/4FSDg[\;&AaV&6T6QJI4P#OI#XN1+I#>g]ZE(Z:^?c
QU3QOf;5)KH^4<3:YR]\RD[@1[e0SHCJ^bI7ESgXSTY88PC<4YNg9)XJL89R+T=+
+27NI1<g1\d0#=-1Q-B@bReBVRG;SH81FUW0XMF^S\.E?)Q=2./@)e:a;K4??/X=
3[Q(;0L7Ua[0ISW4=QgVS)J@</EGN1[?aCb@5MG&7Ycd&PbNT4g9[5R.S_X0D[]@
YCGT];J8A(7E8G-Ad:g)bHL5cfN.K9Q+IR#b[51Q,GBd+aH,e@0Y89UH#8T)He@]
4EC>&A2HB_R#YDPWH>N,#CZ7NMHW@_#60&KP&g-FIQ20eE=/,HE+]S>(4U3QdY^d
dAAQ:ffOCWaMUXBAS]Zc1HVPD&+KD>?0<5WDTRFQ?LfSPSZgcf:EYZ6Q[AIKVJ,>
Q&(1)Gf:d,FBKafAG[><eUK[WeO//82TAMZ=X2VaT40@MF1>256;5;agVE6Q?NJ>
RRA=Y,RKbe_^AUGU;;GU)eKG2[<LW=LIP3ZbF;O#6):K42ZNfB[P,0](>ZPX-@4;
(@J5R1(79\5TEAHCDgX=([4DfJ\[fa(a[Y+I<fNb1]&UXPF.F\[SUS>^0S[M(:,U
7.)eET;^1P/N^fCFN@_W2VT(7W<R_&&>D@WG1OeB(<A5?Q>d<cDS86Q:/O0Yc7AA
&>H3XWMJLUH4_22=3F5^^>W9ag0\Jg4)7#A?:-:HKN@?5KJ&R9?5QVa;OE,:0-=g
QG\6>](fCQJ\4?4:S[+;5TB<f5c6c=[Z)^I+C0Ta<+WZH7N6Q_KF>^f]9^J85<8O
9(UKOIK\FNNcGU4fOZ+7CP4F^8UHK3#YSFZL-:+0Td]9^5VF7ICH6FZB=^NNG-7b
5U0@+DG_6Ofd/]OW[Ng_R9].KZ&fMc3M).+:3YWPH1>e<[9[6<FKOQ?ACf;-C[NI
0M7&L>(cU/11;^]E/FW^CPXI2KKGDXfP]U@D7:]4;XEQaB=gDe-EO]03ed_Oa_RI
FK,[<M5#9D(8C.R\-)Y#4I394#d0L\fL:gV5KEI4(]UGUg41.-eFO94b??f?60,T
/\.ESUg6B1A+DgSUb)6(3\BXDdeB\VK5.&EWG&H0)8<85:c1IKa]M:C)0S_aT]55
9N.]7Df0J[I=@1Y3eCYM&2;>1SL2d:JZ;0d<^.<BG=EELeEb?2\0<@[U&#/=5<;S
=#85c\PE(c&\ec=AO=:AQ-?SfSUTHYOV\cbI-B6LYB;>V7#21^[QeEA^5=XZ>\P7
_97^YVR[69TA-d];@dP#QL?S8$
`endprotected
`endif


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
`ifdef VCS  // VCS Release 6.0
//`protected
N(>9]c-&=7:&)LCb(&g/8FN:9MNB=\f@<H-L,Q191:_Kg;DL@..E<Y>+)GP7,6L^
?:16MF2#18I?V:&aBA\20G1eJ+73?XaK[9JG?(#<=LIMZN-B^\VfC]^c2bF>7QZ)
gB_=O\GEHI+a+cZ5\EXPT)485e9T+B[K\N&:2@UL:2ZKLM]Z#BMORRHL;FbFD:Q:
cEg-X&AZ7IA)4#\caWNaQ_G/WZJZ&-?#_-<P2bBFJg_/MZb]WWgG,5&2AYW#TdD3
@.KT<^O;7&N/ZY(;L4:RC0V6HURXafgP=TV,04AG[VcIB[&J7CfE^=ZP8c3.6-XB
>I?OF5G,T;SAT[OO?:O0(8QWa&gW,8WGXEM+F//O(b\.+/UUIE6Ld_cg]S4&HacA
0f#:615cDLN\)_5QWDQEc=Se\?fI(IZCXZVLFY<_>BfTb>W=.dU/#@3VG>?cUP9:
U4;;GNIYCeC<Y[VBJ6=M-;29WQTE5#K^_B=<4W9OB:V.V6W;[>SgLYf(/[.deD_e
g(7fZUI6Y22;9/HF5DR)8-_F;M#^?J6#AFA5ZA2XL77Y1]\JY4bI^/@cD5HCRJ#.
R2K&eY^YXS/S,?_.P0>B_IF-.[c5\g&I,A(;fbEIMQ8594daOT0[2(KZ>_]fI]F8
eXeMK;9d1=18a.]f6F#NEA3/A#QZ]\S>TRXeGBd&Q)@/[HC^N[BTebDaV.?aL9,2
2Z(TZLQT,VR2T+,43Q\3@^.<H/K\g;-CR/38PIFgX329JG^>94c<ZX<dOCM1E?]c
1S0/e9M8N5&&a0HCMHT^0T3/HGH[<b[^;01<^LbKa=BWYO8,5RaXT)6VGdgPAgf1
_fD/f_<CV6^T=a;f4/_9..22@AM4^)=Z:,<4?X6fc.Tb81@c/+AY>0,FBc>S\.<F
6Z\g&<6+?S]VQ6:?D(GDP@/S=,YFL\V8XE^9RO>C.GT.QZ0V):=Id[QB;D,=dH5e
?D3_?]N/RQ(V7DIdB#MCf5=DaC4f94L&7eZNJBL:>D5@=.cHMLY/RA89R[+J:c[W
N.;a<YDdV^?=LZ_P9:bT;CF.0-/79[S7b]Z?e)_9:BfWcbLV&I?&::29c^+P5\C<
)0PJF]0BT@W;>IPE#[V]3c7K\5@QFP@bY3Q,g<]eC2KX\&3.Kd=D(YG?]S&3HB?0
/GbcRfc53<XU,0OI#,T:[]9EQAW\]fQ&Kee[C<A<WgAdXL)-1M&KEPO.d(@=TD2<
KG3LS<0AQL<a,6D0194_f@@X>2ON#XH#O6RESP:BDU&cC]?N>V/NLDILSPT8/:MD
6Q4XL+P)JE@ZC>CQZ\E,W_>U;U+SD89E-PdSXL&JM[IHC5+e75g_>a>^-fdQO)TN
/>_21D-/,<OKUHDG0-_IGHQ5.5X9bbH]>;;fDGdP3HY>OeCR\/[UdgZ>Y?QCKZRF
Sb&.W09L<,-OKL]/N(U-J,d4S;b0;EKg[N.9E9KVD[,T[K;,\8IdL.0Y?P=B/Qf-
;@?<PGCC[\#K-a\@H;B^a0;Y]a7=.1<#&KS23Q-&V^?62T1<V^033Sd@G\\1aa7P
Q:LTd].B64,0Xb0dL.MZUVOVAaD92Y-f0(d<UIA#CZg=OM]MAIX]e;J0(c?D+8(_
2e69+AZ_TM\^J,e>Y14VT_D9#CJ<O+,<=;3X#b9:fRKL[705N[8R[cPcPReG6dg/
8ZAg[NHU<R/Q8M<<@NQBJe[AL#CB9f,-U/<-]&V(Q1+dUCD=S9_Cc/N887L7WQIM
E>f_,ZB<M&KL8Kdc9ZE8D\-,#dNa2)0WGG]NZI)V<>^b&X:Z+O/WQYTR?-dd_b3P
3T8cXUf9#_aIGQD+-_cL>I0d:YW-4B/[<SL?MQcdGAHBZTT_[[D2eC^Ha3gAS]-0
S5KEFY++e1:@[dQ#Y1/T1M@IF2,.>Ta[LW0J6.SWB[H_fB-33dES.GHD;XZ=-K0(
#6TGIVSA1XE)0=R.LA:36WWD->9JSTfcf9aH_T)?UCGTA:,>4KT7;U/ZY>DT,RQ1
QSY>81dBL5TCE(CNE@fURf[EGH6]./)5F[Y9Xb?PdP]A)Cd-@]BMG:+[,TR6IIV9
/RH8X,NM7^V&\eG.3BQ>4Y3b5_U?#4AHY93Q^AN_0BWcG]EQU&5dU@YcUMYa:B=C
8C,(D;5(98/N5;DH->3\V47_(/=[Wc?&0,EO\.W\2//e_JRS&2+aIfXOc&)g0B8^
;)S2c&Ybec\0?PK[U,XZ79dZH3gc;P6VRAX(ceT3+Q/)[(U)KQ1D4a#0<745XP.P
&[b/[>&K4EDNL@T\>6UGX86(QA3A<D(O6()L9KfA72&N)X4FX0:bV5G]5J,g?I??
d\NZ2;Z4d_N..Wc69]9gHR5?COb136c-6Z=0H8a^RY;Z2a2[]8-UYIOZYe/H#f\<
YPEg72Cg,,L-P7(7+bgJ)6Ra#/gQU=N7LCI:M7D9AEUGCCW86d8Q<46IP6H?Q/W9
AXa]/L8I06X)/OF,?D9U.c<4<d##XT=cI7[?aW8e,4c6a=,<a6:S=]#GQ5M.7410
E>2\L43.[\PfY@@KcSOS80OZ<G,3[g\f;aK))X0N+&M.:Z&?b,O;c[T=]66<^80T
KdbAKO>aKQLZRX-Ad/ZEOLA(#P+VR0JYN<B)9)1/5(LY5X2I&@a3Y4+&F;Ib(;Kf
NI:LWO>S3dYd.<D1_Z_RU12Z6,BfOIe=+I440OV;RC&Z0_N:]/H;@[.aWZe9KXNX
WC]f@S1J\JR0FX\@GQ]XEGY&NB4:;]aC-aUDY,;-G^c-CEe0V,S>g&_(SP\DEKaQ
O;^Rb]Z2OcLYW/YW/7BOF-@-)4P#Sg;-d5U39/3IY-3ASLGe63G_L7HSLJ)ODT<f
_7BLgATW=fHb_H>WU2Y4AP@H;>G,eV3#Jb(-WeJP6K9_:f</dg=K<I5Q;1DOf/eZ
1&OT5Me+X10PY,a=PbI0ad:PAeg_X.GPI0::>?JeLR,G;G2;1<<LH)^(@5W6O.+@
H0G.W?<3=Q-VeSQRI4#::RZ6((7eK\NB6RG_F;g^^5?QII=KUXF&T(W7DJSe[\_G
#1MIOB1<=E+FM?cRU4gISNFc_RDO>:9bDA7Vd:QJS1^G.,EMLIgU=gI[PNR_T0eE
5#[/,aZB4?/,\\?1:.V_>@2dP[;RD5(D)cTM.g8O0)8YQ#.99aZ3\@?g@G=Tb6U_
GFBG,8(>b?#L7-NI_f/Z.2bZT7P;\@X:03N(WS&KT2VMe32<8gCNKf\521aG8g13
O_-FH)3-<=P18b<[fR]X,d,dBYI3>UT#R&)6HHXX9<)W7K[]NWS(?-JCZNUa_+?a
C)?P8;5OG)L\K+803,dVbgDIQR..SY81L.SHY-Sd<\_@)g8aKSUI=A1/YTe<B+SO
O]1d8(]TF_GR]&Pc;(B\KK+R1=(S<gGI/Y5R]_4g)g(2B\AfXaSB((c;@N:E93,@
Q#ZZ#IX6Ua?1Hab_1ec3[BT?B&FbFQ1_aD)Rd^,^#><PF0DLc,LIH]-USBI8<KS]
#eY3gDSOb?Z4?<\c8&I^8;YfT3Rc2aA8&IU2e<PTRO5Kc,g^@Z/-?471P,EI6.a3
UBI0DIDaa3&V6:bI+5NJWgcZaZE;8U_ZN)V+ARR&50BS4^A.a>/,F7//C<?Q1JJ6
CK.Q@JTW&:<B\g#C6(/RIFX;S+Kg9:aSeD^TL,eMDeEGA]2Z=Gg^_M@aY-T&P@3E
ed<gT/]=BS0,8,P\TXG.gG#5#)2Xce0Q.3[@PJ&1e&gJ=+-5^.:V,Y^^AT:cc5@Q
&)&M3H96R=3c@<PIY_7<1.<H5a728]T)>3[OYeD/RO[BPRCYA<faFB1KTEJfa?F(
E4YN,J1#8cAX8-QD71\SG)Y=7A_-B,Q_5-Q=-;dQ/X1Q3I-eOcJREfG8+c,#7ca7
dLRZ,PPDMCQ7562UL[\L5>PN34V@d[9ZHAYF#c349bBJ_/Ig-gcLKP?)E&5B=M[5
d21.0YUL+SP@W]I.<^0@fe+NZ#&bPd.UT<bL;eN,8JZC-7V@QWXLR6;\>2C@,@P6
1^3^Zg72]:UYJ>H2e2Z;C=8OL:b]ULDG;BL=Z6:I?S#7SH14CB=cKQJTcbMB3L;O
>),TbH6:67?3WKcb6&Sd2ETbb5VK&C\-+]S2^D-NFeLDgZR+4CVX:@H^Z5)SF]1?
a>b<a/>.d6=c\aacG)>#Qf/=#XFSK2dZ>&g_\P4\ZN@:Ig:5Jea#^-T9]CVA:9MK
W<S8VM+(a<O:6LP+(cD+FA=VGHZ.&]OU8XB1M)>b6#[/947R8QCc::I>HH3YU_>P
)#-8,Z,RG[,=X6F2dWDY\L>7C)+B#:GW5N++V79EDD#,>J9fRZ\SCbfQE/:&S5G\
b2R;cNY\)Mb3-Me^<R3+^39(\H2-4a1V3MJf:89#/^8G8dZXM3/<JU#2A@20INV0
?7<FMV>H=aF9_6UN2[\@)_>S>c@_X3e;T^8,BF\./ZXY8KbTGSad<?P0#)GBgRdN
C9#VC7N-0gED:B8)6&-FPC>57WINBF+Yc8RUNNXI?=7@U;TUPDU).0(P,G<90-JX
1aMC.95,5T\24)/)K.Vb<b5f,fCd;9feLDfa:,/E#M^8TX#L7D6=KUb@7/.>S8BT
#4YTg6>+4>2</QLC>;?f_.R3/gMI<0d6Z720V3(VJ6#&H]QL9eae.G\#;1BZ1K(d
MRg:7e?7,<=SF_](]2G]9eXMJ[SVW.F41c9S2CEY7.-\\I@g&PS9I32/F6Uae,^;
19BG^Af8db8?B[IP(4JC+GK1W?fad;VTSd:IR06PcD@JNDEKM60R-\^5(2^.@Mb9
[W&#UR(\:(DDRU4PcT^-8+/R?LVJ(B)^278ZY]F]OLgTfZ/YMa@8@V<:0BM;(deK
a3,^):_4&Nge/Dd0EM]__[[)fA90[.GH]U6?b-GP-9+]9eM(&37J+fJ#@E^Sa]LV
U#35@N&>H0U=3gT_[0Ra7fLQ+gXD7D]DZ#OgZBG^+TEQLS:O7\J<VK8.+RgPSFMO
LQI#&ac>]1Jg8^Bf#Hb7KU,EL7Sgb0>-\5H0913:09[#3N8:g_LKSH:4D_#_fe?0
aNDSA0I;Af_HVX[SW.NZE(a&N0XQF&XfR#>e^^T)/&AE8aXXO/546^;87?UTR^/b
VG,MX^R[UJYgAE3[-\4E:W27LOIVORW]-,UR,NVDgPc?P@T_M]X[EO:P@RT1S^-@
7J8fM^:5<KCbd)MF^Z(1CQ^AK(<VBMb[K[aHWP\(W#cA^#5/4K[XM(V+DM-43Q##
=2L4+]fX_1I;[5I?Y8RI+WN[R0R2#W=+)^.M+4X\@-DKSWJ/;:N[Qf>GX]_ELe=>
)Q7XP2+bH1F?8e4-/KV(7X,b+D,e,@;ZX=EQd#QLHO=P=4J1a@W_P=>?SFVC#_#L
=g2F+)0I/-QCPg>bW>TL.&@)RS._-?<Y+28:A65ZY,=FGSKa<=_c[S;LH&K&I=C4
]&V76XJZ/?U,VR2#8D?7_8O:a3M4ZX&Wc?:KJ-<;#3_ZRI\_;>db7?K8Z[)7ZQ:1
Na5\^^W&2PS+?-7<g<D9.C53L8Q67_6B?9A9UHR-<Y:((&g8.Q2Zd3N1A1H;LagR
4TaE4^F2SISI37>4+,L,]/TXH+9QeVI601[PM)-_3W>d\,,MW2&)e0.Qe1_WF]#>
SG?\a)-K^;E_#eg?R:EIB]PO:5J:0Z:HGMe2-K7F-X9J_DNSCeO&cNXf]3(//[I=
]?g,VBQ9Y0e<C2<223_QV@^d\/T8aK@;cQg]4?gfJ&9)X926P<_:[/=SdZSRPV+?
g#a3D^b@?1@U9e2^W7QdBAN4?4\9(?cIf&T6_,6#9g(RH>JH^UED;U=SJ$
`endprotected
`endif


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

`ifdef VCS  // VCS Release 6.0
//`protected
W#(aMM6;d.?2=MJ+)2V))VO6--(+(:fS-_KA,F[?&5]NGV3GK6a^)9I;([H_-0eG
N@@KJ/F9V5dg]5@)Sc?K?<cC_RL+E#_\-M^RQNfV1eWBR0Ib:L4aM_@d/1Q:V,e>
/U\,)&,+5P<&6>+RQ_4Yb>:Dc>NKA>LgO:a[1N27W1=HGPe)UN<<HB1QLM,ZB(aI
3J-5D7;K96A#M]?SHQP\>Qc3=e[C4cfDNR7&7/-RS#1@XA197;Ce_:J7Z:[\Vac;
)5bVZ7bI(d5Q+V::]UA4Qa.<3CSY78-#8X34,Ne\CX6EJOAC1\deJ-DDDE/20#5>
0JWONF96aQ)7H4gRKZ;GH=NXQcBL#ZF>=bW[.6^e\6)XfJ/H2S.19^]c0fP_\TEa
F:BQ2JV>-D[==-]W^X=Wb;CI)GDAI/MU3[V@Ud=YS0T)K\@DgU]c-.^b8WJRV9N6
c9HV:X5IKR:MTSQUHAGF?:c4Q.TQXD[AK_0cU]20I)H7\>MZL4WV,/a-:@>(IC>Y
c0R_5H=BQWPRFUXc<&cS5?,dH11I0R8K2P[-Ea&CA4.0Q[,Q6A9VH0=H(S@CW6bO
^]KBgG)^+IE9UZRBE)@4N^QC@&Q&4,:V_+/d@9:2JLb2dFc8f&\A;:EM0b>@AO8[
@[0fMTG7cU&PJ@#]8g8KTC_&1ee#L;aEAee1H[3HM6G,&c/V51N_\TM0b/bR]YSH
9J_V3?T/X\E3DQ6aN@/<N8IS2/&X0YUF@eQH4G,2.5eA:NE)<0]DWU8Y0_a\Qc\A
71(fMG&+E2g&917GE<[&VO(OEg)].abD&e];SXTZAG\R\2BcM,AOP-gW;5\C/U4;
g0,9@6\V8PAe,9Zee4<\W..58e_AU@(P0F(+)Q@PH14O=#F&GLL9EI>XED@WZOF(
c?9Q\UES&DM?8I;<5)g/QR4]1;]c=d\gYP0fS(&6YX>/>d93BML^FDYH\RU#AMPO
)7(PT0XgP[&]NbZA(WJU+.Y=H2FXYGdGdYJNf+_\7-.I1fAEAY7:T_>aa+V[_6E5
?9^ZQUb)Z7L1.[H7XM5)EA/bg90IK,Oc<^)PX>>2D&J8#@>If\[S>7FE1>[NEaEI
VLgB=#Z]<e6.COQ?Z,e:J<RPEH@<>;C2H=]NM=B7Pe_;8N^2RWMA+]UXK=f8^ZAZ
6gaOG]Q\I=]b]<E6B#?2WF(^NA-,X:Z^d<]c<==+U[c5DRY@IPLH/5]OBM64J-LM
2a/SdOQ8Q)S1L&]dMYML@5A.X0fX568T;b6a[cFTT@8E9^[eQYNe(a8)#8B(R7\H
.eN+QfW6Q-([^Md9MS#XV\0Xb5\:9&^LD/+0=93D_E>/<OR.B,:STNIEAaI/QJcA
;[e)KfgQP-@.Re\BWXDU7GfN3VENB=<-1JSg[:G[L1cc.I5>eI)UBYg#KcKPBcXJ
f&YHPcWKB(GA&^/T#/-U^0A)M&URIFIBV/)>f)CaBC98H#>]/\M-_->R_S+GY<#.
)S>QL&UgD;gc.IYF]N@0X]D;233-4]_SEWL:G1KeX]EJT-Z4Kgg7Ve)K(b^2aU=S
EaN<G6P)1289b/#N6QY/ef84T^@VcJT][7M78AJ.6PFXdGP9+RB0fCUaV3(37PR1
(Cad.=HIH=J@]f10[DX(;<eZO)RA8cbMY00C<R[(Y9D[YLX3,B1?aa+V<[92T5:/
<_HM-9&0=B)WVg9C#0-7MO\=;#?H0;]G@H8J:?O8H.,#:X#CO9[JdG>46QN-SX3U
3S@I7L\NM_A^(;R5DG[1(,K?ABN-V6d@Ja/FP36N-PXc[T?Hf?Wf5U[2Y<S]]c1Y
:e2HfY&H2Y&WTTX:&NJg]JOe#73(8<;G?dIF^gS)&XGAX-+c(QWRcAR\J(#F3dOL
8J.+dXAda1V-S:e<^EJOT4f5b@P#AWMOI&YUF2IQR8-P1X;Bf]PI<+;3+c8?&QM:
>J)D96+_=-\af,5NZG&ZMR(W?,Y0@-/Oac3(>)^8Q_9c8W8O;d/XKPM+\.W77;fc
A-.4:VT&c7=cHL<ARKKT+.&A)(?R3R3I;B,0Ke3-bHaY:8N)-<.ba&Q1LO,J<2@1
<Y0#HXX@G,Y\^AI.4gT:,O18^D8\=&QOXLZ6>E\;8238PTEIC.-#0LfPFH147+XT
50YQ-+ga8+e5Y3K?MP,UKVIUP)K)@ET>_G/272TK[H^&.\/A?eVEG73d>EC#F)Q\
0J#^]b0FTEXTH)::1B[LY6(:J1AE,]U5e<R]\c@VLe8QdF6U])V54NcGI)ETJ.(4
HL/MN\>;@5GT0$
`endprotected
`endif


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
