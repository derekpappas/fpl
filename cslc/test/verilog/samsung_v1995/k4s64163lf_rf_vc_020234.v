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
`define MOBILE
`define X16


`ifdef MOB25V  //2.5V Mobile 
    `ifdef LVTTL //M64+G7
	`ifdef S75 //M64+G7+LVTTL
	    `define tCCmin  7.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.5			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    15			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 45			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     65			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   5.4			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSAC1   16			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   5.4			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   16			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S75
	`ifdef S1L //M64+G7+LVTTL
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
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
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`ifdef S15 //M64+G7+LVTTL
	    `define tCCmin  15			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    15			// clock minimun cycle time at cas latency=3
	    `define tCC2    15			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    30			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     3.5			// input setup time	
	    `define tSH     2			// input hold time
	    `define tRRD    30			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    15			// col. address to col. address delay:
	    `define tSAC3   9			// CLK to valid output delay at cas latency=3
	    `define tSAC2   9			// CLK to valid output delay at cas latency=2
	    `define tSAC1   24			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   9			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   9			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   24			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S15
	`endif //end of LVTTL
`endif //end of MOB25V
`ifdef MOB30V  //2.5V Mobile 
    `ifdef LVTTL //M64+G7
	`ifdef S75 //
	    `define tCCmin  7.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.5			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    15			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 45			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     65			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   5.4			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   5.4			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S75
	`ifdef S1H //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1H
	`ifdef S1L //M64+G7+LVTTL
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
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
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`endif //end of LVTTL
`endif //end of MOB25V
`ifdef D19X32
     `ifdef X32
	`ifdef LVTTL
	`ifdef V30
	`ifdef S70 
	    `define tCCmin  7			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     1.75		// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    21			// ras to cas delay(min)
	    `define tRP     21			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7			// col. address to col. address delay:
	    `define tSAC3   5.5			// CLK to valid output delay at cas latency=3
	    `define tSAC2   6			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   5.5			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   6			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S70
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    24			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     80			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S80
	`ifdef S10 //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    24			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     100			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S10
	`endif //end of V30
	`ifdef V25 //
	`ifdef S70 //
	    `define tCCmin  7			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     1.75		// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    21			// ras to cas delay(min)
	    `define tRP     21			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7			// col. address to col. address delay:
	    `define tSAC3   5.5			// CLK to valid output delay at cas latency=3
	    `define tSAC2   6			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   5.5			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   6			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S70
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    24			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     80			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S80
	`ifdef S10 //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    20			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    24			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     100			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S10
	`endif //end of V25
	`endif //end of LVTTL
	`endif //end of X32
`endif //end of D19X32
`ifdef DDP
    `ifdef LVTTL
    `ifdef 128M
   	`ifdef X32
	`ifdef S70 //
	    `define tCCmin  7.0			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.0			// clock minimun cycle time at cas latency=3
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    14			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 49			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     68			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	`endif //end of S70
	`ifdef S75 //
	    `define tCCmin  7.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.5			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    15			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 45			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     65			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   5.5			// CLK to valid output delay at cas latency=3
	    `define tSAC2   6			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   5.4			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   6			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S75
	`ifdef S1H //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     3			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   6			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   6			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1H
	`ifdef S1L //M64+G7+LVTTL
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     3			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    24			// ras to cas delay(min)
	    `define tRP     24			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     84			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   6			// CLK to valid output delay at cas latency=2
	    `define tSAC1   18			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   6			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   18			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`endif //end of X32
	`endif //end of 128M
   `ifdef 512M //
	`ifdef X32 //
	`ifdef V25 //
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    16			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     68			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S80
	`ifdef S1L //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=2 	
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
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1L
	`ifdef S15 //
	    `define tCCmin  15			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    15			// clock minimun cycle time at cas latency=3
	    `define tCC2    15			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    30			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     3.5			// input setup time	
	    `define tSH     2.0			// input hold time
	    `define tRRD    30			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    15			// col. address to col. address delay:
	    `define tSAC3   9			// CLK to valid output delay at cas latency=3
	    `define tSAC2   9			// CLK to valid output delay at cas latency=2
	    `define tSAC1   24			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   9			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   9			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   24			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S15
	`endif //end of V25
	`ifdef V30 //
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    16			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     68			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S80
	`ifdef S1H //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1H
	`ifdef S1L //M64+G7+LVTTL
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
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
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`endif //end of V25
	`endif //end of X32
	`ifdef X16 //
	`ifdef V25 //
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    16			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     68			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S80
	`ifdef S1L //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    12			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=2 	
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
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1L
	`ifdef S15 //
	    `define tCCmin  15			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    15			// clock minimun cycle time at cas latency=3
	    `define tCC2    15			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    30			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     3.5			// input setup time	
	    `define tSH     2.0			// input hold time
	    `define tRRD    30			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    15			// col. address to col. address delay:
	    `define tSAC3   9			// CLK to valid output delay at cas latency=3
	    `define tSAC2   9			// CLK to valid output delay at cas latency=2
	    `define tSAC1   24			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   9			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   9			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   24			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S15
	`endif //end of V25
	`ifdef V30 //
	`ifdef S80 //
	    `define tCCmin  8			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    8			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    16			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 48			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     68			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    8			// col. address to col. address delay:
	    `define tSAC3   6			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   6			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S80
	`ifdef S1H //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    10			// clock minimun cycle time at cas latency=2 	
	    `define tCH     3			// clock high pulse width
	    `define tCL     3			// clock low pulse width	
	    `define tSS     2.5			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    20			// ras to cas delay(min)
	    `define tRP     20			// row precharge time(min)	
	    `define tRASmin 50			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     70			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   7			// CLK to valid output delay at cas latency=2
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   7			// CLK to output in Hi-Z at cas latency=2
	`endif //end of S1H
	`ifdef S1L //M64+G7+LVTTL
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
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
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`endif //end of V25
	`endif //end of X16
	`endif //end of 512M
	`endif //LVTTL
`endif //end of DDP
`ifdef MSD //1.8V D17
	`ifdef LVTTL
	`ifdef NOR
	`ifdef S1L //
	    `define tCCmin  10			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    10			// clock minimun cycle time at cas latency=3
	    `define tCC2    15			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    25			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     3			// input setup time	
	    `define tSH     1.5			// input hold time
	    `define tRRD    20			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    10			// col. address to col. address delay:
	    `define tSAC3   7			// CLK to valid output delay at cas latency=3
	    `define tSAC2   8			// CLK to valid output delay at cas latency=2
	    `define tSAC1   20			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   7			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   8			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   20			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S1L
	`ifdef S15 //
	    `define tCCmin  15			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    15			// clock minimun cycle time at cas latency=3
	    `define tCC2    15			// clock minimun cycle time at cas latency=2 	
	    `define tCC1    30			// clock minimun cycle time at cas latency=1 	
	    `define tCH     3.5			// clock high pulse width
	    `define tCL     3.5			// clock low pulse width	
	    `define tSS     4			// input setup time	
	    `define tSH     2			// input hold time
	    `define tRRD    30			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    15			// col. address to col. address delay:
	    `define tSAC3   9			// CLK to valid output delay at cas latency=3
	    `define tSAC2   9			// CLK to valid output delay at cas latency=2
	    `define tSAC1   24			// CLK to valid output delay at cas latency=1
	    `define tSHZ3   9			// CLK to output in Hi-Z at cas latency=3
	    `define tSHZ2   9			// CLK to output in Hi-Z at cas latency=2
	    `define tSHZ1   24			// CLK to output in Hi-Z at cas latency=1
	`endif //end of S15
	`endif // end of NOR
	`ifdef NOK // for NOKIA
	`ifdef S75 //
	    `define tCCmin  7.5			// clock minimum cycle time
	    `define tCCmax  1000		// clock maximun cycle time
	    `define tCC3    7.5			// clock minimun cycle time at cas latency=3
	    `define tCH     2.5			// clock high pulse width
	    `define tCL     2.5			// clock low pulse width	
	    `define tSS     2			// input setup time	
	    `define tSH     1			// input hold time
	    `define tRRD    15			// row to row delay(min)
	    `define tRCD    30			// ras to cas delay(min)
	    `define tRP     30			// row precharge time(min)	
	    `define tRASmin 60			// row active minimum time
	    `define tRASmax 100000		// row active maximum time
	    `define tRC     90			// row cycle time(min)	
            `define tRDL    1			// Last data in to row precharge : 2 clk
	    `define tCCD    7.5			// col. address to col. address delay:
	    `define tSAC3   5.4			// CLK to valid output delay at cas latency=3
	    `define tSHZ3   5.4			// CLK to output in Hi-Z at cas latency=3
	`endif //end of S75
	`endif //end of NOK
	`endif //end of LVTTL
`endif //end of MSD

	
	
	
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
        `define ADDRTOP	11
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
	wire	[5:0]	RFU = {addr[13:10], addr[8], addr[7]}; 
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
G,E0,7K]1N8O,\1Q)2OX=TFG9YTa<5ca9D];(cJ239fYd@b(b]Z48Y4Q<2;;9AE0
J2/>WGTN:\8?K4B[L8N24D,BJXWI:bKX9AQb^O>(Y>?L-99R[U#d+GG:LY>gUBga
-0(Y75T3-beA_CAW2ZbPac_1-83E[e_A?,RK-OL]AC+G,W_dQG/F9aFC;S/a]7)e
K?OE4^b)bJV>WGGg,E37Y^Ke0=VfJ4DX_.Eg?B=V7=A_Wg]O97/.19DSHB5J4C98
MGY^EBH;F?fZY::H<TB,\TRa+9&V2\J(RNdHgYNAO)_=;^IPW8]PKENTROTX.&YJ
GCS.Yb]IAfKCf=Q6SY1=MZD4H5E\>a=L8PD(K&K42D_U5/:V@fK6T#0BZ1;#&Y?_
K<J4[^Q2HA3f_RM-fD3;]F:+3[(+WbIQ:MZZ^FV?;S9LdL3(INI8LIL#O3.)+,8;
Q-0^AC2N,D0+\?76ff5MH@:SBG0b4(7>@ZE1U9RYKSA[GUL0T+ef/3Hf2+O2TDE2
JZ#0<@?:,=NIQc;/Re6K41SbPVeJ(IM&IVb#@#T9H2J7fR;BMMfW6;^R+5I9P(M8
_456ER3<<#9[8ZG4I\OT(51\)0</affZA=,()L^5[=Z?>.LAN=9P./_@;BZXdUcN
R=HKM.L(&&YYQ4T+/\K1.U)D-^Y3E>gE7BZ<NJ,;TW@\11)4#.0A_cbND4ZM[:Q\
XHc8_[c]I6:PTf?NL.H#gO[8-#W7>F)8<89b,[d&b?U>]DW;c:FaR?7_3CJcF1HD
U_e^BVD#/A<[D,R^gLB==LWWeeR2SdNC?J@8KPJ7RUBa@L_USP<7B#0,8Q&IE7D<
MP07RaPRc7UV>U)@CQMUL&.2CUMZTaIa)A<=L=PAEc/\N[AgY/L/GH=E9V+082J0
O<7,U);FQ9DX71NSaD867XfRg(dE2f(#5Jcc\G;179G=C@\]<DPCP\KH]e93D=eS
a]NLc9H/9gHPS.L;87(^_JJQZEBXS69G/Xc-9;XNA7?YZ/#GHX52<JJ1HCZ&1\+-
OefP6X=&=f?W&CfGX(4F>g>VGX[e:3,H47.(3Z-[d^K4LMKMMHRVegcbFV0<73<e
;cQG58GT+0DFa(9:e,.ZbP&bU=AXBUWI2A[5:2KcQH24(LW\G,96Y/;#G3PN2NQ)
#ZAgM2(\P_]dEg7S6S,eg^PWCNa]A?Fg3MNOU0I6[U4FfId#E=H-SPg2P-+ED@;)
K>[BH1AI;AcLQRF1>,3\&/SN,7d/6X=U5WPT[f?5C82C]e07d[d[fI09&Oaf/Gf)
]]56<,&K+NW5LCEdLGBM\G&d7(WeAc7c.OUa5SMX6f5b-/ZYb,8(K5[fG-[/V1Ie
1X=X=C)E<1GJ2MO;>_2de0F?6Ca/@&f#)+;bA9WIUDD,U7Qc0C<Ob0UM4YEa=OLc
b:0d-JQG1:C/M_YG0Ia7KaYI-bL=[eQZ@]P,M\;7A=0JL#OCD(<,;:E,OU]DG&(A
LZFbK[F&ecaX>?XS9dFV7,4d5Gc/^V5.&M_3Q-DGNfO,CY#(dP91X]bTBeQZ9@8Z
;M9YGVBU:ZE>3><@N(ONa]R]50.^^ZG,-a1c<N5<UfT9;ZJ:Bg]HdTZ#VOKF[Fbg
IbeNGOUc&(_&CAKJS,^]YF,86Q0HR4J&.5R],ZM#7]MXA.RJA[CJCW]1Z3/&P<0X
2_d/(Ag&C_I#/c,M<)XF_23cOTAT)-+MSeR:FH-MY\LIAFd[NII<D89K0/_7/-=-
bAI5X?EZ1.\HJ6Me0X:X>?8T]K=M0BRZOd[#c,cHbHD/FW4(P_<L(IYF+-,O;9a(
;#[SQI#=58_cUJ>2aZ65LN(V0N78+a[B[9>,Y5NRDY3<17>A:+YCL4E.=BC_YD;f
+,(>PB_8[dN#SS8MOF\==ge>V?J1R:#R?$
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
CZ5bJXA:QG&F9Xd_,/&B=Xe[(_0597/2(6[H<R6=3FL4^A\G3Z0X-:K<(+H5)b-,
K>_RUWJGA=M?,+,@&bAaG,Y\4D1UTUQG+SD;U[+6Q(0).Nf5&6NdVb4SH7fK[6JK
W?3<8E?X30\FPLfTg^[SY5V\.I7\gcfA&3MT#EKO>EBRKEcI@BSNP]5,ZMG&)_F<
E[2d(&NaP<JI8b=OL^cLV/@G3#<>GJJPfMHR,Y&,\DM+5bCaC3X9bW6#)ZS:F2R5
7/6_,e/2C7Wf45WD0A_G0)G;N8LH#EXRU8KY]))1M[[X@OaP>^C;/.T7Bd\SZF3W
-9>J?.7gY,gUO(Ac2UE?1]&G/YYL^0Og:M0D2R=&1-M7GgA6MS8P>><00-2J>ZUf
.]MK7]V-cEDF7^8OgY8+G]Se4;H.Q;7Z5>SG>?ZWX@C5)P<BRW.)(2Z0D&5HQ;,:
RUDdUCOG>_d.eA>_eX1-1::XYS7f2W+_N1@YUW/PY8;Q;CIaGcb\<OQ+@eb78<(]
_Z:SMOKc2P28EEEU\AUE&fSNT/FM>_QVP6:KPgVc17167\TV9\&Q9PZVU@fACCMQ
+0S<)H#gQfVU<b&+@GKVLBDD;TTFYRA[I2O=R<LUZK,96U)&<9@-fUD#7b=9C+6U
e;UPX&TOHX[MO64J//W0=EZ8d6V-]NR:L1E>UUaADYMV9G?G5#4.SE6QB-Eg^\=Y
RGS5?<OgOf)4E7OgCM&fR5WGQ4+@N<SV^E#&8_G1&g[ZX6f/A]9b7\J3&[BfJ,2U
cUPTS8)MW]0(D(7<#GRgTg3C\\&P,#J@;S&&JPb<G1LW>88c0X&V5D].7?Z\##a3
L73>(#dM9[N[6<4-R]E?f6WdEXEHF,LBdc5)d)VbNI57#E#fUeH(-#\L^,Nb7.?=
<S=>b13S\,K;(d==JT#<1WE6[NV0++;06XV.#AM31#T>.-=^JPQa.NP:be_L2CC0
+V\7M&EC74-KPe]a4]+C0bWF#CL-^(ZUTIZFZ>RJ]JFL_?7aRKfD,/dL78V:aSTT
eLLeL.Ig;GVT.OC_O#_54>RZ/M>X0QH^e7I<2).ZD_)51YNQSIWN7&T-:.E^[QeB
Q3c^-3Qf4a#2JZ)bI:+#f7R#&[?QM7Y7X>c]E&XVF+_d,4QQc;L[<;((W3\@0c;]
HA[b]1>K?YJS=GCgS.\Rf?V7_(#B,6T+X0U@,+/]\-:fE?K;HHH?]PYHa-M[E,(+
>T#OWg;]GBZE#]+4bZgBZeV\?_@R,RgFA]]S2J\O_U6OIC?RWMF-U<X0829\@8Y(
=+HQ^,D[H[JDg+ZS[.)[GcNYDAC)YS6;8E[;?2/.L.IfZ;dV9SLKT=TC(5bdC54K
4G.#SD#4UgdR4b6)O>H#>I>2;<]LSc[@13>c-0?L_@<c3_RIGB):X\5Y/2FM1dPF
>7=&\72,MdT<=).A.@LJKY^:+Rb3TaXQQWZI+&eW;MP0,,cDRN#O@FCb[5FFS=3/
)FF5HAV,64QJ/7+X1G7^9,_S5QEIO\=Q,0MG=TM4D3M[__Y?KCX.+WL?b(8JRcY1
=H@O)BcE]?23=7Y?DTd]AN6/.5_JYC[0e\Jcc.2EC3YM>)9BIX@,)a047AN(/NKM
O9+ED[&>^Xb(5K8Sf0:FRJHg6O-eWSZJ-[_cCT4@D&DW0>.Z,<>HKR0#OO^X;_>]
M=,3)/SW(#R0LR26>A\K/]C42M>1]R8b.VY3U/2eZY9P2J9ecO/1@QO(YW#A;@M6
H.+U8,S76cD2a24&XQN3_fa[A3,,V2>(W11e:66(dZU@6?NP.X[:I7V_(VEg30Dc
.(=;>=EPRO5OfW:&]7\<.e.57ae(dKS10,R,CF2Z;C#FLG6-Y;0<V#O(176.I&OB
S2=f-^+W(e]<2T]T7.eI<U[\HU7<gc3a94Gdc(U/<a>^d@F7dAN+9IO<eZPZ/Z0M
3ZDeDbZV;&H/+f:4O4G(QVEf53-cG)=7Ye+1#6AT(L&W)F?O&S50AASc:OQL_/f\
?Mgg8(R5\E6NZb:&CXGg9NUE[EYQG^S\-RYUX/.ALE>e,[;)TdR0_W6.>ELQA]&B
6A28-?MC/+NRGAcV?>KHSRPUX6-)0PEMH-e1-I=@)]YZ&+S?a6d:COIf&M9)\.#K
XaNf5\H_?c(Y<-N)4ZB6))HARYO?P4ED@60]dD<bFR+=-E43[K<3fB1;U42dF]/^
MJVa<-fd#AdKc@OLMED)I4#-&;GGU1dT<cV2B;FO4)b+;bRZ1PPR<>/c)]G2a+PU
E>7S7XL9]K639-/B\>IPAg)F?HR:KQaDN-a.(/gEMHN><5T=,C6CP--4_TZGQ_-L
Q7JZ(-bQ1:;N-V)-+[FfXWQM8X3a-O(2d>L54O/-&JX&VG]SK:?[=b)Z#8/Cdae&
V1/JO5LDYVOR3F/&E=LLKg/PF&)K6eO5K4U0ZYcBC_bfe0-daT0cSX.X>CFCRG/L
6LKOY)d-_7Q;f>S<UL;3]GR9Z+?>?FC/WT-c:Dc8DRY)C0J]1Ng0@B1AbV[SVWIG
0Y6RW]Z-PO?#ILOXYb1:Bd+=71WDKb(Q1(9A,d:]Re.#<c.4fM+,WT_>><Ue?DTe
5\(0=&U/g9[<[Q@#@-DQ)<a#+/dI=0#BL2=^cFLLO.7WE8g;WcIXCa=e<.)1QR;,
[A=J7QCELd12[KZ-S^-cUNJ0Qc4XH;^:cedO,FMa6N+1dX/FBG-cH[BUG49HU>.E
<1dM/9(/R:F(D+8e@=D1VUCM>39HS)4]cE4U>M-X?cFK@N3YDY1#.eddK.b1@LMX
G;5W>0LbF#_>T(BY;U5ea0_W2a;/L9D#eI.#_,C@^VYag,Q4+M#>ACEY\WRI2GOV
V,_NK_,E;XF^IN?:5F@Y)9@7T@<S@A:G@Ke[^a7=.@Q&0.P#S)8F/:?ERfGfFZ@.
R-bBJDP,6c9SG=/]I2f:NT378J^]:LR6;?#DMNMP2)FD6L2U;DI?85<dZB(ZO<&I
Sa,XJ^<@2EXS0$
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
LC//OQS?A14E8JaW8TEB-W43)-fJ8R8L8K&4,a0H@59/bCFAJ/FG-c^N=UKN-6J[
eGV@N3]N0N[UZ@I[\\=+5CACe,IOc)BbZI7@(C[_-8b8e>1Hf==UY<E[[f>@T:71
HYY2VCZ_)1^_e<eQbG4(e#30L;8HYW@,.6Fg3./.fA15Z6cM\:37[J:\ea.PMKc_
I7dRM9((C#C@fVJY.G+[7Q^AEKV9SNP8BWbDXW471:4[0b[(<;FKd]Rg)Z--N4Se
W3),3X=ZOJY25OL@Y,ADDFd2M:\JQ1)<=eZ<[eOLU:^G@_IeU^,)UbIO=2FT4SZH
a<:=\f(^g>Z/T+O<cSc0DS[/LAH+5d(.YG;5-XZdBdP.R<6c4HB,Xb+Y@)KB<LS/
aR8XDC0,OF=WW8X-;;cH@#]17.R;8L,#5BG&(@XNPNI4HcL5H+ccg&]a_90?&:R8
5E>_HCB8\;]5^e8X^X;#6=#05^:7GM6ATd5=W[TK_6+d<@YK/]B8F1fN?T8V^AW6
BH.cH?QSVV,<A@T4,)Rg^4f?[^KGM_9Ua.\,QOf+b&5a1493SQ62S(Ug5FE(M@<>
?Maf;APYeO7ebYHB(\Te+NU&\7_>:\Ya=5ELc4@<:X;AF+K]14<U2BRAXR1F>@00
\0US?G^[<\QbT&1.GK-P;+V^,DE,/U1X_Q;BNW[d,gYX<=:F;dXK?E8Q20NC0dXK
W;09KG@89/^)CcZ-RW;F;S6c+:JC6G/PVQ^GLSV(-c0;7#2Ke0bLTR[FZ<E+NddL
C\9BL(@<+TX6<K/Wb3=XV]IZ4b/H1B(EdB2dXb\&/(,4D5d&H?d1XQS;6fO9e8(6
=EGT5Z-V-.1V?T/1.YTZ^FHPO/RB,/O95a6aC.NG4XK@16V.^b(c=@cRBQ3Vc8Q1
Dc]W^AObfYO-T;Mfd\A-U]#=Z5]S5bON@P10=[?=^J=<&)L<5PC0RFEPC3.7?\[O
K;<(S<<M5[4,.6Kg>,43>_aL#LHDg)2ABV=RO:OJPZ<-ET123:.+8U)?(YgGf@0G
,AeH_.(4);bO.Y=EGRb@dQ=Wc+@;Hc5N1AJ4^+G@A/2SKb9;Gf#V],[P+1-X.^Y(
N/Z36<:Fc?Wcc(CZE0./D<Eg&f/N\ac76a?GERT=7CD6YL7X<KgLK]Q)Pb#c#7-\
-(2J4L\C@93ag)]1;RCM4B&S2Te_@</fZNa#GPgZ[KUH&2&ZK_VKD8MT2>SK<MPJ
)gAfX3W6I6#M6AAY<^c5Bd@:T:-&a&[P5OIRNbT6:\;-ZTBWe8SR6W,:-3TM>A7.
:/-47V,U(Q][e\c[A8WF;AFZ6?J<eEWUC<WYP9C[N:WQWGQ+>6EKZNBM<LL+9K6d
5EG8f^aDZU5a.d<;.gdEQR)-.d1>=/]<4aY[ZY.4?GW3bRFD:QP5Se_McWOBGWT4
+I(B-&0897Z]UPW^b\2).[-22H7VTCME&:97ffYJ7e0VOMeH=+g;<GS<)<U3F#C:
#&g^T<,g[2^NYUIMX9_QT7(RP7W+@80bf5c8T66aW+RHT?=c3deJ@P/B&F69Y9)C
UDB<HG=I.UgENAA8>FA-A014J45;(/5e(3]R&J;:O=&O@TBI-/^J-):.30WY]88W
KCWgg1F.bDQc\=0AKf>C7VbJQ2=@2)U\UVX?@MN5R,HYaLW6O(8TXbL3Z6LG^=D(
U1g=XN_LG2F4N:F=&:#XOE6)F6d6-?32[Fe=N>@+3e<K3V+Dd-P8(LMY(P5XA3/Q
8L_<0P.)F3B<R+c-a@/:ERM0BY8\WE08a&-L>OTcTLJQE:GVfC]D2/N=>e01?\V?
0<3B#g.N7F<]9=Z(&B4OMZPQ&W.O\3:d1ODE>9SN-G&7HW>SRIF+^A<S@d)IJ363
PDC^Q?,._@:Z])Y_)S]U4]D509):UfB&)S:ICTV(EgOZK&Q\[FU,DWcLOJHR7UD_
>ff4/S^P6G8c;P<[R.=[0CT#SEd@I@X?T-)-]2dA^GHIL/g((20+bdA)Peg+&aQg
Z<c&5&OLS]e;=d3BQA1M2QFJ0&e5)(=[PY8]CfB/^74#FV6BA+.dRS<U&1K5)4fF
VK@H(W>e7KOWg5VF7US.fIY<fGPQY<Q6871Q\/4;D36LR)0M7=ZNXHL<<fLY8YF&
YZ>7,K;bF4D\KO,EVYWab]JS2Tb#6-;9(>Q1-Q=+;1c]U6+BF:H<)2&<@31VbOTR
0I9NaCOB?MK0d=X,5;0ccWA@[/\#.)2dT@>W2f62UV0Ke(HW^D@+V&N<OGZZ^(Rf
MV88V>X24;@3XA,@(L4#e(9U2gc#Ad42GXHI9fg0S.2-75H&M8\:5NA&L]?UZX>Q
[-FOLaf:TB8(e\J<NC.XSCMY8G?7:I9V/J>E/Pa(f/&ZVMUO6Z<eY7L8O-d3.CN-
R[PIF5FVfc)8WBXOIM=U<XB;&BV/4eV<@]#c0gQ;BM;C.&aH39:S,#Y8//0c#f74
NVEb3V._0Z=X?H,EEa@3N<FF&;CH8?bIT.1?T_\F^_cGdXTF[2?<58B+\R@:fd<Z
2fd5aR698c#fPI8c:gPFX7?S^>Z=<P-\_0DFWT\A;F_b7X_\e+b+fccFPRAf0F6E
J,ALO&+-_-?0[TVO@4-\?]_P58>Y/0SVN34JV^fZTa8[TC:D@>HG@PD[O5>2G+Je
/9a_GVdP7a,,5QP/B9_IQ:P.5FM<#55IN8RZg8-f3ceT,-e1J5MY?<IC0TPJQ>+?
Q_P&[6ge+U@^Hb>fd78/_UB/NXTWZM+=&fDY;IH+G#e/(8T16S#)]+eV1M-(fWP4
UN,R;faU_M>5eA3Y\8a@NZ@.F>)E]ELX/X:]PGE+7[(A<\,,B28W?&/J/3gC=3X0
?/3<g3;Xf\G+c-JH5I=>fcFe6EE3@_\1#-]P]8>)7=Z(L2ge1e]R)V]9V.C8S=Rb
=--+IS-0/Yb+F9XOca(58<?DOeNVMgegM+FG?#B_Q&F&6PWc0D[O/SaQW4c?E^PL
43+T.P,\KfDG.;.CY7FRU9[,4_5F48-<;Z5AWHRX-1A4TFfO[)eQ)AaFEOOO)4)V
T@+[T;FdO_V/A\U/_20@6bT65COH4G);U3d3LH6Y?/0&16Q3c8]T+I.N._X27cTO
bgQ;Y299Hd,ZJOA?PDTCfB^B,R_4X67=;:a2>FN#]#]KI[MDO/TV^X3.?<S==aDZ
Kf6M0B3(#G^86D5QB2[N4L-K=K)@,18da@X7MH0NM>^CCYU6&ec:]IR/Ub_O?Hg0
CfG0X,7bOFg<H/HaV,Aa?SWY^H96>A#OD8H+/L=?f&ef^@4#M]POAFW5^()d_ED]
<:BC([.S4PCZCW:=@?f561QS<gN3Y.&M[(2&#P4Z\?G<Q2S8R1.f\=cQA9L5(dIK
1Y4FZ-6>V3<#Zb(3TY-<d7J/47AGYT.?<)]d,=;4SSR.;dB8)ZK9/(J(dQ(c08f(
a16T5BaDdM9TgGJ,bFEMcEK#8IJHGO:Y+]Jd):X-eaaCM]7<eOUA+KGUV>VWCKPA
VL26&@_aE0Ca_PNNG^50\#N.C\)2CHO9BddNedNXH#85/[EGb?=X@@_(^VWB2,VC
=A1BHfgHV+O>F,2CWPH(dT(^T]U+7dG6\BS\:[U=AJQPHTM23V&>D8a:V@D0EDR^
IVE:0_G-K-eH;ZH<;2>XR0+SRaS+@PD_J0ID.0RfYM&+/9=gfEgE.eFc83M[GT=G
S<SV8O>fT:0F<)3Q]K>P#,)-FgI8&O,).fA4T)_HcEZ.FQJ:UO4c@-1X_J1G-N[.
&ceIXV/3UGUAH;C8GM07:E6\F]#]<OZ;;\(46H6V_X8+F-STN)O&K#L>McDg-4Q(
6f9Q2=F2A8@IHV8HB:7MSW_O4TRfHCXZe+MSMN97&51T08JR1M#bR]a;gaP)CRFP
ZM44,ea;L44V6<+;SRR9V]E#b\SFe9.R:WFcI+_I<^-F6EAeZ&3-X<d?UCHI9-cO
aaGBK0<#3@,HI87/#TZS(G=/]LZ6S8b>/IN;;2KFY78e4:Q>(\6Jc272SU4:)^^(
),0FMV]?g;8GPBG:4/?a4PS.ISb,6M_JS6^B:X&@H-]P(G@a@=?+BQ=@XV(@Q7M3
FC,E=@()-;HG=P/.DbeQb.VG5LHa8fC^B.e9;IKC(F;DRO)LK?(:-=B9,98P]@,G
2.-1,K1g_6gDR,.V?3.BL?aX7a&0C2VbWU/XL/F[&LZK+K@XVHPbbFN.THfPK/CQ
4[ZPEE/9I3GW5-#-cSNb6g1VD;3R(GO3gVN,0ZXC5]]Q#([#655(J+028-P.S8Gd
3[SAJSFX<K16JJI<-c.GX3,38>VGf^OgSHa8OJ6+,:H)B/=+G4^.&CI\@^c;,;8#
//NcFFE1B9..0aX8\cQS)gcM\;0V#)ZSUEQ)-bIELEUY+5O],[RE0D5IM\T=?0F>
HDa(9La7(#9;TTM)F0:E9B/C8?2\FHPU;G#TbA(;U#,H_CS5O1?ceKM(BD8)UM&>
NY>d7TI9U^^XI#G4[W8g@/#YEHPVC&4@88=7\d@_LJ70\0T/@?&9MXfM[NXe:Me<
(_W<K1_)fJ>;;=A]9PJ#5(.4b20UXV81GegDaf/B#78QQWS^T2Z2#_eV+3PU6X,(
JP;SId>3a&Q+>Sa]8f7^K;;7a2>QeH#:AY7+PI;]8JOZ1b@U..;2A<M/CVM0A8,4
a<,f-QV@&MBK#gB&:8e.bAA:]11^K]#P68K;.\:+-JZ_^3BZE\1P+f]dZM>g^>e9
)0QM0HTA,7K5&#GE>&-@7(ZQ:6?]RB.JfgRX@\G>PRXD3FA)6T8]e.VJ)-,K18fM
^]=TaRTPc9@DFdfBeT\8,1,]O7Qe>C;[f/KXe_Pa-gP&:.:<c/ZY1HaD0#WQY=P3
fJ=[T1/aKYYG,b6.de)fbR&QeY5<f_&]f513AOCP/J8XBA(^LN])RD]8X0eLbI]c
\NP9^45L3\;\a(9N-X7TVGE/>OM30JY)4Rc1(0IW.O<J-.S2+_JAXEH0MZ7HEG)X
Nge?14\[X(gSg#]@O_eERRd?J?.8c81I<C&@,\W1b9.b]b#Nb7,LQ(@7f^^H(cNH
2JL+3M)E?g)[X7L/VJUSX0XDWK;^-d_eTKLae6H,0)11LEJI)DPA],H,UU&DO25J
B6afL\F8[ZRN<<9F1IR]b[<SZPSO@Q3gJ.PKfK)0G7VOKR5K2DA4f/J1b].3MR>[
L:\[RJ&1S69#:cgS3?3&]?1Vd@:)?:<>&LW0=?9CRL4dK-A?\ET,fCe<4.@U:6U\
XD+d23G,VX\EO^6SMc>7C\Lc?#W17BQbd&PQC/VM<@.\+2c99R=dgDWMe[G;Va2V
@IAVP3f:W[J.4>M,KfZ[b7[=5[SKQXR0HcAISX5B9aFTO?^\@9WC0#g.dU,0:a@-
A[)LEAR5a--+Q-L<G;>9[B=O\I9=TU>TebeDd]20Hg,YDM7C58FO1R0Od-^^D7aH
8fFE+YBQcQ:]Y2d,<RD@D4gOZ/aY?fB3dURWEH1N\RU;8-gI#O4E_g;5gYHTaK]O
\dC>T1R7.,?fKL&(g3;gTU064AV?(Y9;-):TSdfg1aSV);KDK+L8F+HTIE5UFX96
R29Z-b,G/BB0?f^BX.J<\8f?^D#\&3>8,&[B)BS9NM)7g[QJ)[Df-,:bZ>IF[/V3
&;K)QaD]#NSENV+CD?8_UTQ2,+PZaE-J+DD\W>M=3XWb#g:9IgQQP=^64cU7W9aT
=Z,;U<U=2\1T[7O2]BWQdb7.g9P)a#W1V4aXb-]>UfQNTU7;(K977-4GaAgLK0f(
[A/5PZ@I)7_Y0#(SJgNV;O:b5(^eD5Q5[)(VFXdN43.,#^Cb#dRS7;5S9Z;>g\^/
;(D1>=#4aa>SVO/(MVPA2L)=0FT(aY.26+^6+1)gEZ8<c-^8^f\THb&VHG&VV=J@
TOH#_gMEgaf.d_;WcEE;c7)S+83?7TF&T>:-bEYRZb3Y0EC7G6bCIH3c]U5U\Z]N
1@B7F/Q\cK_9>RKagZ1WN7Eg]5FEDP[1bY@-,)]#5Z0KQ<IJ4N9bLMNfLa#M0@K^
;V4-N1^L/#/Z5(6PPENCAf8^]gc:WQPHAIU(N5?M@K?^,.Td&D<6=A7;+3F:\?J<
#EUE]+HUB_(?ZDb;V^ef_UA;\@1Y8QKP\GG:H:eT#:_c1J_8X\8+a&_Z+J_/>._D
D5P#1g,-AZGK5)ZW6118)+JEfW7Y6GYf1W)W59UL,KPU_:0.@75aF5N/4a4:1W7[
\_2ZC(\3EDN&S:;Tb7O)E@FIebIc)2g4PQ;,ZKWccB?QAI9ab>?VB.<_Q85VX=A^
LT4d19>2&L=/bD<9B8(gT29R__2(NV[PFC_;0)>TB\=:\)fTK.7J4-H4P3(Z&+\e
LD#_Q1<R6Y7>AK]^\AJ.[fZfBQVI>1;NP4)(-]6<7aJ)H=^=FB]D?_>9#TP,g^9A
YgO,Y105GA?00d;QHLAZ9W?,]YReW,HP2H(AX77c\Yd2C5eAAeCV]C&=4[<,N4]\
+TCeNdQ9:f6M3HbBQ4UZg61a06UO3EIEA-D_318P6gc_JDR(3bI\OW0>?95GZ4Cb
E[W10G=YbPY2L9c&T](_,;XK7QXB&\GI?)2)c\S3^a5S9XRD[#T1O+YZcVF,c.J4
C(Y,3eI0-\#HGGd6CS;];)\2<&V^J::K:Pgeb33g#>CF@WD6+f==JTgE7Za:TKg0
>S7WPeR@)GR?AZ__+<aJMWcAR3T=F9I/_;e4?4&Yf#1+Q/Q\-Q=1EB7YO:>_\a>I
Y@O_>&VG)bP&M#(,Baa9Y3cf.g.T4cGOQ71H)-eeKQ2e1DP^,+R2&J2?Q2Xcb5T1
&@O>-X,^fTZE&a/c?)8e,K+1<(G^9((BKLb,+[QA9/Rg)VC<\OWT^.1#fG2J.P)Y
,#E-0@(,#42bb?6,ANH1N.WJ9HP2RBEI,;>;0?2#-OK/dL+T,+cN[RU-eGBb:FI+
Y?#DA#a6C.=\5.U<efN[DDbT2_#=//N(-M0V)&2D4a;P5KT2DSc.OJ@<UF_OTdS0
d9Y+-(DLYYZZ=M^O)>.CGTIC_7gEf-)H\)?1fFI;/Rd0>cO2.?,+OW@<I$
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
IgF5U2&V)aPI(_Mg(C+E-JEN<)\8(]_/8L1&9),KA]-4<WNdM?,B-8T2(2SY<0/A
#Y)H-QAB_Y=5f\F^M+/#8D46J^YBRP&6dB_6^&_K3:Yd>1ZKNW8@2R>MN&RYQe&c
EaA#T\N):N4QgPS<\&;UL,BN7N)MX2/_E&G36B,d6Ug-G)<9;K#VA:1?:=[M,(a]
B-3(CF;&P-,<9C>^UCeead6WJ[R.FIDFN)bdL?&TGfQ)8L^6?SB9EGF3>5=&[9VH
KE&N3&7WZZ#_+@+0JV^WX2&&WU)b^+dJc[,_9_RacQeTHV/.B#78^]&TWN86_YGJ
]URKcGHLb5@5EbOa>XZ&W(6c-/C7-F\\RY38^gOB:(ZYY:0P=D=@;[1D7:f<3F]O
6ZHJ-N;38421]7=D_@&dL+K^+/2FbOP@g0W6I_]/U7Q^b4IEJ,#MI#BaYJ?OF;S>
9UbX#gVUCK.9I2T6A7.9&O/P_\6G4CMJQ3Fa1.^R>aUPV-=SMQgM)_XYd>()O&e0
K=FJU+E&gGIOaT\V-SEHC7\8>K?GXTDM&J]8HFMC08JT9cdF=6QfR&g2RDNcb;=D
SMHf?+CAd0]VfNF999/#[6a#KG1e=&@=S6VU&(&#9e_7?(f1bT>.7TS\fL./Z]H?
-.O\8c/7^H<aP<Ud8[Z.gbAB6BPV\@:XWd11ed:/8<LIOcJKaEA71P<:P^_ec+VD
FdKM_\fKbTHQ=5f;KEHK.5.6ZM=J;.94ETA5b^:Y]^T;=fGGCeGW]Y:\aXQKU#B9
GV;KLIZ_+=;D#-6d:P/3R2^4B<7MVQ3e??bXKDBMC4_:Y8V2_;YWBI98FB.UV=bM
(U8d96I[(U]A@8;AC\84R>dB@O)]B)2PM?IG+aKQ=(G.8a;cAWM/;=bG_L8)/&^T
1XSH(^>\g02:3V;6&F/.&17(CEV):(Z8>+1Q@W\cQ0Ue;0F.IUM4VKO)4D4&Yb#L
ZFRE_[:Y\Y9JL<+H5TO:HUYCE7/,^4fIF;4]d-JSG#9(.UNCa?fYXMcNe-9>a>7A
CIM^?@/LZXH=:Ga_a8N0d^EUUf&(X,T2[0;&f0RU3bKW?EM7Z,QEU)e^JYFb\L>)
&43gZR93)^1Oc;P)W83#>XQTY1@UI:WXWF62dBAg)KXAVgLg9Wd1TbV1;@APgf^W
XWRD2(3K3GM2R+_H8]9J0SD]D)Ed?JfA#[;gA4aB,S<AM2YCT)QdER9[e(eK2+FR
Z#F[eU-G@C]HE#@E21ZQ3AR^+UgaI+]L4+?8SAC[(7,4QFcG\/ONDGTX)T@6H4<B
@Vgd7U5#U[e^VQ)a#S0>F_e>Td8\Lf9)Y<+;]/(B1C+:X=X:Je.^NX7IdPPEG?V@
-AZ[XPJ54+8AJ2BLRe.#H:__T,_?>UD6Ee<U<A@<bHXZV<HH7Ya_,?<f&ARQe]c;
F;S&JbN((^1/Sa,<]EW..\F0AA2/;5))_(>Bb[NMEa2aRP^Da2C?(5f@:&Gb[9C#
J(17^<?^0A\L<c^:-^W\Ea45QH?7&P=4D[SO2<W]5Y,9_@E:)0gC6FQfDP_g17Wb
b+GF83?5R]OGc##g[D0@#0N]V=N.;8FEGH,<5V)F0S7eMH3C:9@^>:Y^(c]Q>.]V
4[#f:gKUR0A)f75,.(A&UR>0[F,L\G1-;PP=;-,CPLN,e(&ZR&@4cDZN5>e9V0I0
He8<EcBG5@G[)VCJ[X4CYGROI#_^Z=VX\FLF??+N?ge\[B,1:,8gc0;9\_WU1:=2
]UAUb8;0W,C.9.;(P(:ME+<XYV@AgTEQ+dCda08(IC_ZM))637&\\CBKKOV9fg#N
9cDO06A+(BLV2EaMV=2&V,A+?f.g\8UX0?OCg/CS@J^Y;[ZE]:(&PJWZ@LIFf#09
e.57X>^>T;)[PCfOF+8H7bLFCa0CB_5>3^F&;:0.E^UY5eIY.<+8&NGBg\BAeLYL
TGgdfI>5MR0QRW\4]T^<E)9g4L0,VM>HBY2-=YbZAS<CX9eH,P)?4e<@@CTS&edM
\3;NQ/9\YWK/65DF42)QaL5/+B/P>])W83eH]>_f?EWK5ONE<,.:[&HT/<>._?<K
a@L[(7]A_]ITW)@Q-_]IZ[cOf_fN:.I(F+0e.[H6D5I,=NJ^WQE-g4c[SD)7-72&
g1N:RaS>K#dQ:MZNJg/c&XCX_eY^_6fJLMB=.[?CK3-U]=0V==eYOHaE9U,#=Q,,
@+KVb(MdZA09+_8U0)Y6K5W18AE+YgPfVN\JH&\<cWe6N7NQE;K_f,2XBJ+FW,2L
YUD3X6@Q:3:JMe2R+3)b0G0Yb;bN/2?fL?K45g-cDOZMY]0fb,/:;L/3J8E[c5I&
VV6fGL<O;;,@;CLK<-S.VWHQ7X(E5=AVfBbWFd@?L2;P#CV8K</IK4KT0VK=4?OC
d7+=1..V(;DT5)g<V>GaR6aR&:.b9cM3TAEbFAY8gN>QGI?3]a/C0.DeVJ(NJ9=K
E0;:I)Y8P2CD([DN1>Qc8]7Ub4N<L.JaXMB<^8)KMd:D_LTSCWR:T4LO3bFA^(VK
1+H0+aa>_;IA9:O^(<fe\).LT#0^XF2ZU=T35F=S_OaRWHLb&C7Z=L>@7<XFT>[K
R)M@1?A,6BQW&V&/dT;N=P7^5F\7UC9;.W&Fa>_?9687AgAM8:P+JZ-Ga#JfUd)d
<.;D8WD4I.^>\@KX\MO?I\_\_7^S/.^9=_cFf&31fK_,>6SA)gAH,3@&2&\dFS=V
4g3U9C(C]5_A)6\Oa0GXIX2II9E=G)/Rd3-=\Z(619YGe9\/b)>Hebc^1VQ7_>^@
K\3^5IE&E8:)GcFII-eXc6(W8\U1QV^aeK6[g2_S6ONIdHcN32W62M+KGHW4@8#W
Pb]Wg_gaV7^QML0L)aIUS&?d>S#_^)&R<b,L#<<\2V85<9PR@Pd;VgMI=O;CLL0A
@UPD@gP#\;;?)B\G_(XX(4QT_6Z3\1B)[JDJZeA)^S.f2&87[IBPW=X7G4AeCS[D
CTR8#_B)405I>;G?;?9A6b/9[H&5-#Dg:[g/W1(QV>I[Z:EBV>:3?Z@FM>a]J.(X
J5+^@V88D;R2P6=#7d](1>6+H<^X^W_7JcfE=JQT^#W#SZW/[.Q))NNWE:MJN&M1
TcB-QW1F,0A.9+Q\b3;CP3edHd+PT1B;/LSb=5-WOdeAF3AMWVd8IdNWP$
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
N_&(/D+fL:^d&YQ(=@Zg-VV8-U_Q=YL;)HXI8Z,]G5HGc#Oc+1d390FJ=f;&=U<.
f>gQ->Q0F+5</PP.XHafWIBbR:gAc9Z8OMKF2/_TVU8)CP]Uc&g])<4[GAeR-&_2
24R+68J,;;V=IZ?Y?,J?G/:82^Y(1bEPCdMKN/0SJ)\_CIP5CHg-_J=LbYW.85]L
K#X75>gXCU/+EU14KP9T]I^AeT:a;GZSAeS_0+]BUW@IS&G1(2#?cF)_([0W^AUS
MV?TZYQ=QD1OM79ON6.\a/gfTb<MVa,7W+>b=#3AV1fJULD3AX6C>F.e?39-:VMW
\(BD3]CF_+CN3RL>/+aBaG8GWBfK#c_7(=DaXMD7T9/YgCDR_7S@+3:=eB/9P1HJ
_2]DDYJ\F^\C>gRW=ZAYID/:c@@<EN8N:V8+X9@=(GK7e;A_CXg&cN-_VKX42.F/
I@Y-S-a^,:a]8,C<Y2SR2;JCa:0J9D6QHEGX7+3<EV],0YPWZeWOgSFG=fO[<JRY
NSJPR,VTLC]/P5D008AUA;ZDf:/&DDBC@U87DT4LS\6c[S-K\3a1319EZ5dHY.Oa
G6+-bSA9)@ed^9517W5eF:Y88/9V1Y[6^LbINMB\[6R5f-[MEf4YO.3<>^94Q_4=
7<KV,JP9b^H/&Ndf<3=DYBO=#Z6gRL\1eEcV(/d7d(7\\&L1XJ-^<eCO&]]R/3Q[
W@7aT,3NCTc6+-1(GF8OBZMRYUc(K8IMN#O>9--A1@ff0\1VIgeRJ.Q2Y2>a9?-]
RZQDZ#1Lc?CJO7-3D0W-62f41@NT\T\[S:^&OLGEW:DTH;C(RAY=9/H7aF]X:1CG
<agDV(fDS/FD\>LSAR3,SEX-bE#QFDKVb6T@S6K<4(W:9H]+f#)N1GR6BJD,[[6Q
NF0OPIgAD[K:=<3dB.D^F8FRQXPLMU4E\PRCP30)B@gPE+KIJ^3<VE;9)/f^dg^c
<49Z=HR,65V_RS)[7+.?C/?C@F4J:0P1JfQ[/N/4H9AGU84_@M6]B@^)_UM\ALge
+<4Yd6a16TKd1PR#;LVa@O^#.?Z+/JdQJ,>:3&bE8Y.7d@:abZbdX<XX:X)aNH_S
WIN;46#&I-0.SJg883c0FG,#1VB-HQKR(.4#.PL,Wg@/DGeBfH)?(N&EEd=N_6Q2
77(F>)E&,@Ha1&[L.g:K43C?84ZVV@W+.\N]dPOLZSQJHN,,-Id&?b#g()P2&_-P
R9c]C<OP33Qg2N4bHM<2aVV0bZ+dK0[:DJOQS&9]-(,,G=)AbSA=e#CB;AQ6JI<K
F>Pe8_cN9W[04X>EY2[e>6EBW]3G<U,_L;[<AB[=NNM@18dQO+FbJb/WD<&>_Qc;
=J8fRTQT9eUAO]Y<GSQ^^f78YOX7d_62+)dJ@5BYdbCD(Fd,b&1]]bE_&I0ebNG,
g^8R:B0:Dg5N50;4SX&&:MdfMG=.<2P<PS/GB_e84/HQ3LH3ZMTA744F#&]WB\Fc
F3/a.A-U=C\cN^cK1VSKI-b?)A#;\&29A4.,Hd=JT,L^)ZNV;N&-5^.S6#24\HEM
[9:K+Xf3D,4L;+,-N.4(ZIfS?23/eaAcTgSM5ORX3;C?A9E9PIVJbU?3CQJ=0Ab_
X<g(cSJBOf05fP]3_QdfK66L\@?DKMX892_+YF-,/55LB]3&N4#eNZ;e5ff8M,#-
_VS9GBP;RW8+\GUF(A(HQK;VS-c+[#<@VVY.?E37K),F-&8I2LBAA/\+5(\g5eb5
J,\#g.Z<^@A0QP;Z\TH/\)U@ZdX@]H7QX7TM3RSe5&\^eN^g<eTcY.^+QB.>aQ9I
<U/L[L#^ecfT<JZYJAPCC[O[;CPM06WGR(fgQ3WVR=J&N38QUcY3F1L:,?6;T18J
@d4PUB0+0Sc#CGC,3W@YfYD.23b>M>6K6g_+KN=>,c?4@XCg<fe\QaD3bbO0+M52
8(OK4)H;&-=-.B(aJ6SSOa7V;)WIB-YJCB++ETLR2gd3e#Se:#?4a6O2EOR(+#@T
M[3&-@[IGB@?CNDe?3=bHI,:a+OQ0B9Y@)=:2dOJGQ?E9U+7DJRP;CU>0a:<3IHP
XO7E^J@g(d(KP&O(MIW@KG8TB3,Wd.7,_d1I[>OgdY,.gc).3P6]f40/P=<[EZM8
P9J9/^]GB0<7&BCOY^KA3be6P&Dd\1fK69d[Qf<7\K:Ha[^B5BDR?&F#f)8g42f_
8_e5KT,R1=aR3Y-cGYgM[<FW_\bM5HATOQ&RV:egDJced-:A&J-+?RH3=?@URAKT
2EDgTXa]\#+02_MF>gWZ<30YDE6C\aN74J5\E@E9+_8&^U@FE\3Q#LFL#?:M90T9
b:)TJVO^:ebS>Y5,5\^AW0Z=TE9dPP876b0Y.Ga];A#I)JYR-@=HFAESDZM(0bXE
N;c.EBN,86..U-AA3,(4X+_?L/(K.U0OLQBWKa33(TR#11E.-f/4>7:dI[a+54]7
U\GPaWX29+D0T@A^U70b7)#_X1X^=e96D?C54+L3:-(dJE/<KMKH@OC<8JaeM26D
Nf7QV4PLg;NM&9Jf_-cNb,DdE2<TA:e]DG7DgM4A5gWf.dd6Gg;.CR1ZV<18@>K3
PQKeFZgIDd-G<2/\+;aM\.)0gI@+X1;Y):DAFaCe0A0gXgcHYU#P]-SUH@HXb,^;
UD7dN5-JL\E+U)_a<^-N9MOIYOT&57,cT>TW_(]d4^(SeGEVYWO3a56D1bYQSJD@
f&D5(CN@PW>8X5[BZeP([TT3gDE7ULag&3@cNSBS>Bcg&FPdC>(<VO,UK;Ia&YbH
:e/#XaeO<,CCd2D=JM,;NQd=>YF\bR=5A:\))I:bg7:ZbK\d,M^<dd+<gLc7\e_N
R>S/)=:-M-J4Y@LG3gOS>@L;M\_ZXE,I^_^A7FL3gLVV=FHgX\X&_1KMB57-1XAM
G9#7-/4:&[9a?RK7QFDM.8T05H3GD_JP96f)QM&BU-<MbR-6JePNM98IA(A_N0Yg
VONd.G@@Ng/Tb0:_3^;G;M.\I_UX[?V\>\f[/1:37)VX1YP&AV0;&e#YZQ^S#5XM
9V4OGc5YaU5O0A@]=c<O8<A[^Ed[a3ccHRPQN[9[.<,3<dSJ#;@4aaR\O0=YH4R]
Z=D>=a/,9=EO3d:@be8EdH,gFN1N_;X-QY/J,d)+/Z]3Ea5HU78A2E1Z+ZXZ<EfK
[S:BCF@Zc?HI7@e5-A-SEAWEC7_=B@RX-,Od-a3P6dR<930CM[8]PKJCJUTb;#Yg
285&(51H,-VK,:&D:+G;EgCS:=R@@P;0]9][0/g>-5YYVHY@>I(0CDPXZ1Ge);@P
L#eOZ:ALcG[#,\bHd?6RQX90eDF6G_+=/BLY.+MWQ91eUgTM_<Q4OK^WW.aEHU8^
6F<CFM.-]dZ;,fgR.)QdB21/I2A:\E3]\gKZLH>U6\^;O?V>)^dfC@NX-3e=ZC(2
8]ac(OVD=(^dBJE48S2YaJ6fJ65QXLCbd^0(FS,+A9-L]C58-XI[^TT23RWP?.?H
8I_DWdRa\cge&OMHAP(S>b<)+:,eL@2HOF2D:Y8[\(E-0@fB58)TEIH7\A3FaE8P
/@<)FQN?)-#.+cgYG(beQWQ5?ID=V&0=dR2Rgf&/7.^Ec@BQU=?8<^EU+1;b<F4T
HEFb0LYL4,45d6Ic#L,;ZY/S1=6-^X:d;;Q#b>@MT4:HfgS\gQe.//acC?>L[BYK
3AeZ71GYd=?;5CU<TH(_<SP=0<9F>c\L>LA^Ed..--9aeG@gBc9+GN+0/\DD.Y1I
=2>[cQ2><WA=MQC,:bTYGXeE?:Q]Jb<gbT?G5?a4@.3@;75Y=9KM>dO(c#QW1-6f
\>2PA#Gbf:<&M>)/&PaO2;]0YNcX#V4-YC&T/MKcUPDHA=>YO^VWQd:F\3,g@Z3E
=_6?#3K:>&GM^DHS6:.L#,;aP4ZFd+YP1WJ6/1F[V1\+]91M:(B)gaG9X87a\2(^
e/HeAX[O,GFPf<RO=7HPOO6;1=-KYC=[)G0d/7J](A0f#47EJa>?RM_,Dd)DKJT-
/K^RHI<,0J3?5VfcG\&,d_@&&fa_B<gd\FgGXI=O,^eN.@^E)_-79R=J1;8=.e8-
YR0OX5+3>^[-9BN/7?g+T6Y[=d:X6\Yg;G)J2,\SK[(c84TKOg\8b0_MR:Yd.EDc
L)g1,XK>;PC7;R_<K&>?M<F=8c.7MQ)5Jg4\;5-8R(=P;Sa+ZXM<^V8?gcZ&+PQO
+XE//cL^JdfLT=0JJ=&A@W?ZPZ7;A&Yd2<J3<b;PW/^8WXa9N=P9W4e[]3+dS=_(
eD;.5H0(J_9PH8g4GH:8+HQCHZTba)D0XJRA70[=N;]RV[C9dLf[H89PX&BV,g2C
[e5\79^<aH][QN2a6Og-P_ZE=_C_5]_^F]AOfKU&e;G,-.&G89g6UE6e?=YH13T0
]_-K&Nb(Xg9IF0TN^MZ4@/]W^Q2;LAd\;]SKM+1&K5Q;E(6_TC+,12C)HMS(c[Af
XH9D//M9T[#He2LCA:aB,[C_D#T93BK,/:,)aIE?X]Ve;TMQbO-3dQ4/]-DPVNS9
.[I7ATYI@?OHe4_&\Q<3Jc=H5[ScR-fbDfQ\eIPd98[C2O.FAL/4\@fCY>L&4PbX
FPHeg8bgA>+B)H+)dTO\=BV\LOQ_Nd/_LPY@/;0K&^CBcC@6\(?8EBb]#-cW=-5/
Z(;DW#D6L][T=CHFQZQ55^6\KE&\+d^JLD8a/=<DZTI+UD_I\Q^,8Sb/bd-;;24Z
D(g=H&c8,a=d_\8PJ0.dIg0eBQ]1V:^\\aJ[RAN\V..WHTC1BH?T_4=L(YKG4,MX
J2IA18>(:)Tf.bJ;G5M(8UNL@O+BcRD06RU@91GdMIVC&DZD403(EASC=EVQ80<[
AV2;Q263?CX\CPC0Q18_6Aa69(Tb[>YQ3>_.#(Q=A#M[]c-)UCb<6W_fYVg]?LYC
-OWEV.Y+UU<J;X:U-+)6Jeb1,&4.V6,8H-4TLW<W+(TN+gCd0/9,d(G3>:;KTSPX
L,L\[&<G=V\9Z6TVQ\ga:Og0f.UB48Ma):6cP<1#-Pg/>,J+NCJW6+<>,F2\=5.R
.e+PN;MHe/@]#@_IY3@K#G>IU_STg@UbQT?8EY(C]6]1]D0gbC2SfFg^40_OYQ2W
B/Q73_A(C<@8/]4.^fL<TQ2Nc+S>EI0/4[<;Y;B0PG9?)[L,IHQfMAL)XFgLN[J#
=+O>1bG<8N\@+(B(&Ge3W&6c(QC9HZ^/3>WCCBEAaddb9ARTPK?gfc;?0,)20\PG
LN>+DR.e5TO<@g,QXY6a7If+Oa,\-2#28Y[5I=H_888M3Sa[Na@Y[FQ475?H&6C@
d9O7A/.K[Z]Z//A?/ACX=C=CB5L>Oa&C?W;A@E_&N?I4KRdR7YY9=#+=,,bDL),I
g?UVA<\UNV-/.#YYU2WE)QPG3<e^e<RSR&gKL8(I5=R?VN/T]\W-XJJM2Hd((eYV
bf?B-A-ZFdSRZc=[GeJF^8D_eWfeHc=Vc7X^_46N?CdE6)dR&TE=S&3SYbQ?&:c2
Z[OSK[YF=-5?@1E^Td#FB9]:dN8\(<3K+N>-VEQY4#]B<g,VI851?:E=@AK24Q\]
DeT1Wf[GQ-e0BU85S[,>/)KLF/P9T^IY\;?8&Hd7,fBceAFIYKcJJ^)3KgZbRKS1
W[DI,972HAAee]Q1Q?]YU,/BBf3E]R)KQCIE)BQ5bc8=N#IWQ,P]6GX3YD?]?I5/
S[K26\/]ZdI.LKb05/a8#C=<.9RO>C&b0cV;?S@9cNHEMC/W7Oe]S2>+0?2B3(O>
4Y7Q)JLOQ39P>WR[-C5T][/0[;._=1<<@9Gd2<g39V?HBF5Lff)+3g?NY\42A]DI
5d?VO-/=;FcC15KF=Sg(Id1Ud\X/H+\);3OAH)<,)U??1e87VD?e24#bP32#]M-d
[.0BZ+3(T<YZ@P_LGF&=6+4M=7<N\;AA:ELAa:<JOQUf_Q]OYEa7#P0;JM-:R=I[
?CE4MgU>87QP.dW_5a#0BV.,9f1_6+DfMC)=@V<T=8&S8#F.H:cI1P6M?H27CEb/
aL#^9^?P9Q9;BX26AR_6DTH^\\D^+7&+33c3Yb3.0?g.,fV[AJG0gPB7,<>T.U.^
=9+(FW55Xf:U8fHO]0O>0b8<O/:A<7TV/R7f8L4f@I_fM,C@A@,Tg:7#[7KY5M(X
)WFZOK0a^;B.#Tg#1W#43BVBEWU\d)^_:?_B]eVPXS6J-e3P5<:R9WZZAFF\GgQ8
(_)[3:6J<DReCA^6&a^dO@)90c00=c+bX._51U(CHS(2H5+@U+L4NSRHb0:>,595
-0:B+<Z0+>FTE/=XbJ_/J@A;6XfB6?PA2\73;e5OZJ1+];8,O-X/AY1@?M#eV&@8
<JX(b-TUF3I+.+JP.DbS=38.(L:=g+98+#bE-RCT/a\d.EZWdaGfP-L52L<&2?26
E6QPXZd<[X2@ULegTTO8@^U\:cRGXE^5FFW7eV^BC6W56,=H<Q@F<dW,S.;V-0^V
<f<Y\&a1dA8>V__8,5eNYJCZaVgGJIC.a@+&-IN-+&e=eK\#/Fb_XUb+6O4\6]=U
7:,dFgY=8S?9)>/#f:c#]<38+SHYAa:Hg4dY:,73V-@,+91Z(WII26,9:XK9POX&
[CVdEKWJ?YCQLcJUT.?O-NSF#CAW/f8_=[I5A&X^8RfA,2eXcW>SDB9YTY&F)ZV^Q$
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
			case(addr[6:5]) // Drive Strength (DSC)
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
3&:B/7\:<AHL8bg-=@QC=Ua\8]-/=@<@(aa3=QUI?a8XdYZLE;-89^T<,I9f<H2F
?+=WbDF?12F.>_e4FB@G6d&E0AY5a(.-0=PK8.^I\EQ1GfW^U5\;7IJGLDf=0L_;
W:gE286AD=+TGI_baORL?PTB49CE4G<;4UO66#+6.a)f;2K&K>&IX[.EfeUF2:2U
8Q;Gc;XECJVT=gFH=)FO+5;cLf;LU]?<.5a=4T/M6+BI,57D?\_Hb,LL]a3JS=Jc
E.R,7=SG#1PM)Z+g-V\69ff=c?JLG6:/F9VP#3\/9CB90,JUYaBBF1c=Ua:CHa(e
34Fb\TW8W6=RHUaJaW^2)N6g4b5b0+1fYVS?eaT2LQ#]<N4/J==-C7=,R<6X+aV5
@BZOb1>6J4T:ZM4JRc)]C697I0KV?b>,O5TgI^W,ac>8SV[.>agJU3e549<Q#)5@
GE84:WT\YV@3[fBW)7MSYKI+8YWfQ0IZH^V6]C/#,c=VYTYT:MRRB40TD<^N,ffc
7_8Xg+d1)Y8\].N&X-JeXL])GZ>:>dY62B&H66HJC9Sg9P]IUH5Og70@[R\1c:HL
X:18e.85F4?Gb>3_\.G-Q^fNgL2Tc6?W3YS(XSfC)W5FB#;A,J9:2I(_FVRMfZN^
[V.FB[^RKO7MI5fAE1IRGL#g@,2\4:>eB]6a4^]ZH6CZSQ2(_;UONcc#1GF,Gc&J
ETMLaPF<;)e?gE#0^c8K163Ka1UROcQZ[\]61G5EE8Cd76YPZc,8&@JIOQ.A=+7Q
N:KfTe9W5.4O]3U0P@J?HIUfOYP_EZ#9J2a:]YF0,0@[<5U8e]Ma=F=:JF>9?J)L
Tb]a_#]AZ8TN.@AFE#86c0S@8U>:E2]C=f9D,eCBf#5&C#3@C/V+=gL5f.9LR\0a
/H/>RVHN&)-Gg@K.24K]/Q;?1/fI4Pfd,],D3WG)(/FLXS?_,A49+F#Zf^9?\=B>
]7I=V9C1Y_Q_A/ed\DN[K36Ua^7?G@ENJD^(\J5cQ6J?Q;;+[GO^,E[.,I+PC2.b
N4gC5+6R&f4>V@Q^-U_3_cN?I?;@M;)W+X>K^JI:XU\[].C4a;A0GU#/4(5\g3\a
2P.BIHRCI8ZMW[.YT[]WdH,1c^@PR/T)6W7S>FN(8dagH9EQg-\F^6)\aa[UCN8(
+IEK@,[0gAc<>=RZg>BI#N]5R8T^XH8_Uc_E-2YfPbM(YeFU^^bLZ5CK7dL=_+0T
E:KA-09&\2O>cO(#F6;17I,\K_EbKbZc8];AT].ET.A+e7e.,,7_RQ4KfY8&S]Nc
.\e(R9EW14;;c^7:\\[07.g@,4&HTNbYG#0<fFA\W^&8e=T#6:AK5OXMW&9;^eJb
gMb2dE<geYIDU5OF?K?#B\GUU[Z#MCVW9S1(9MHQ@B&-eZX8/:&d]6Z0QU<[+gbN
=K@De811Q?D](c)TV9+]-?GG\4100eRVbN7G?Z&LTE]bF;V<fB1?X@ABgSI>1;9W
L+3:=YQg9H2#MNX5-HF+UIUJ2;OTV7-&8CO1[JTO[?PR90?(X9;J1<G/JPWaKOI-
D>.LcUM-7B6JI)K6U-bQBO^]J)g<I/KTKD)IPBPa>d;cVI@-e0OLB^6EWR)Q1eD7
>KITCEU&0O_C[GW>\L<Ue;=c9b;@7)#2\<XY3KbF>)a0/D4&.\52=JEa?E?Z6H]>
[_]2O&gK/L+]M@,M3=6<GF_,VVV+5g4:)fbSY](3eGS;?GH?>J4d4I#/cDE(RO4I
],8f-6^OO_8/6/7GAaK++X5^=5Q</CefF5V40(E-8+JNb/4RX^0^Q8?g_SKH96[A
WV.P@W@L1BB&N-_=N=S]@HOQdKA6fF_9#;0Q(_;,BH8DS3Kd[?(<@O_&Q-KDF3_W
aGA+VGde-P;Ae,#@>+]QK-AV-faK/A(W7:d0a>-_:ef<8V?5V0<Y8,@b_ZJO]e;R
N4,cAc^KE@CCKZXDH8OL53?Z=C3TO@;,=SJdFd[YFZ:ceW@\ZTOC>ZN]b(64OFR_
&WX_MSd3V.MFT_BQY3b;(Cd4d7[D(b_?MMD@V-5Q3U;9;R&8c5B;(b<&D;a/dON+
PDZc&O/>gW9MV3W/0QLWP/-OFcD?Ogd.e9W8#1FAJb+CBPFeZ2Q\g[,8O)3&TU4@
#JAFAaEF+H[@a9K)W0]=UCQKfcA2/N4IgVQ:JPE)A&b4R46?,A=CLVYCa)((V((0
SfaQd-eeYMgUXWHXeaS4g:GPf5Md?+c^6,OMH#X8Z7cGIHQDgNJe_g=P7b1e7eGW
_a.b,MK)>)WPJ-;3)Re_ST@a:JX_8BG8C[+VY\L-YXL)&,K\<>:L/=FW.8[c]L^2
7E/DZ1gDSa\M@bf/aNfH_5Q4B-NQ;6G?&dB43.6(WM)gC&-L:(7T\_G8e@b=GCd@
b0RV[A=H)>4+5ZaOGNfY1Z[E@;Dc@MX+X0G<5ATac/gffNGR<_D@XVX-YAX]356a
^^,TF&L#+S-6LUUOHPXCGNSc1&/.VOQX#SR7DU?=;YTC)(5R,//5L_BKT65,g6VY
KTH.Y5J+C]-<QaE1J:.1OWUW@P\Y[b]#6QXZ_MJdA46JMJR9JI.Ze493>C\f:GG,
3d+F?AWIeg9dGI(L2S;)5BGgC.+0fZ?YP+ZTaf/.&\HTa24N2<EBS(RW?aJT5H8H
#8dE5RPTa.I_NCM?_@8+_Jb5ceRD[XT#_>W7ZP9;(1?-(1(\]:b[VCJZ2F.E<&eI
U88FIZ;7FG_^J8&b.c[6RB6cX4fNU:M31S,=N0<I9=.0#SQ0R/R7^(fD.a7WegH_
?b#>@)ET&7P_KIG((N#Nf(@.eHg\&2/6;P^Nd0?TB+eW>cD8V\T=^YFg)2#I3f:5
cN[T^4#B>3M]BF(.A/0QGOc@M;U\Z3.GN\V#A-J=3@]X(adeJ@P7ZW>9[W[4TQeC
:BbAI1V?1.Wc)(L(1e4W5GO&G[D?1N:>e<-)+J49=O62[W[GY&&6K-O47[YQ);I[
^c3HDR5[<4Z1SG_@5<)]ZR9:71NYO<458U^^b43Md&;D/.QN?0PNaZ^Ke09T(faS
G\J)XIA^=PC(W@2OSNB2-.XT=S[75Da2BI@MOWc6Of7048#Q0eaU1__/()W>3:ZX
O[:e/EI)JCA>\DC[P#9=7C\;V=(3GWf4SbQ6D7M^SX3<2H?e;3MD:J-D9)K2JB:R
\J(/;J[M5ga8#^\-Y?PWQIXHWBYW.Vb5I:,XO)9]_3AQ?bM<493)8?,4LVI=JLXd
Od:+NGW9HK&/UVR7;X&Of/#DR,<0fc7=@R:U5NafcbAMY=[RV1\6e=YGX5ZA,5LH
1812,OEF0\F17cL,g(I>dAV8e[\Va4.<?fRZTC(5H1Y;eND4NIDDOD;/1:f<ZO<e
bZ2]WT4c/()+XZe+)4,K]?;3CM;L&KB989?R>g\eSY4_FfE7a=-0_6;/L$
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
]T+M48?1U/G-=X-V86aD-&-R9(HE8WUN9^/[9);[.G9aN6-Jc[,H9H0G(51Q(c?X
V)a-N?,Q8AW_9C]Y:3H7SA(@0V4V^9e88/?W:b0FN79WGd<(]6-a6_V]REU-H08E
K/_V&H4IXJGV)UG,@CH.##RE=/7L[?TS&,2IGT/6A:5VH1,DFY>gK-J((g?fcDed
ZL2.OJ7\N+CQZ^:f^5G3ZR\US?O#EA[B#+\6G..-Yg_2K<PED7B70H:1X\XR<0EB
LeJ>=.K/0+TNERV<ZU/7Q_(@@>[)<0B+eVGf@;DG;Id9.1_]Gcc=>;6U-V76db_f
6D]IN7gV(SV3L#CO3aKXA]XUd?O<@-[B=E5:+H_.RF:>VV[Q,a4P9)W#f]R,b32^
_RggcSQRPC8;KQMIHKY8]Ca;7N^ZeGPC:cP9B@4<G;9)PANSb.Ldd@JLg;<])&X&
P&,66H,B(@.[3b0eWG@C=2.<D=H.,Y\5UcE.Z_X]aE)?E)PA5INC#INOVg4MFAYD
VV1eN.<05TDC3\BV/60VFfOcc<VP9872=)/G2AUU:9YBE)Gd;N>7?))O2Xf#FZ,9
O609?5P\?9Y;U6S^0Q(6Z^3=@KMG?[WfQG,2LN??5\=KCQa-158XE#G52L???<<2
]2[F/\Y>0f6RV4SF-7aDc#FLG=[1;+[IEKO+IJMXC@8YAX62a;>&#b0?X]NHBRVB
eZa1DVT0a)S_QUGC=M2SYC(<c?D2<\aa36OE+H?KM;O++Ob:8DV8G=>c29.:af@^
.5):XcA\[E0FDUW#T=[4XXNTeA>SK:.BV9#209cFSgUVZCOZXEI.Y]b/MX1P#B<S
B\=P,U(QMUS(R@[0=[65^,^]UP<]/>457,R;=)I^FW=D7>5#.1W5FJcI7CRQ55Z,
MV[aPI\c]a->6CV1dFbCA]IV>OFSRU23QO6_]#C_4>1GSZd,Ff/c]^<JC4Y1Q<T8
Mf4BELIOXC9G+4<Oa.(?8@JAX7a5H0=^OQG]()6YUK+X4O,?cf&f[&eF@I9ZFMdd
#U<8fKa]G79X\gN#WN+#W^8:(a)OYbIc=M[0e.?(9H:Jee3[7FB61^#e]OW;?:,T
8f042,V_Q,9C:bfJAWTK(4MgD2XJR=/HFY#5QQQ:2K=Md[#J]P;GId&,aHWLP+O^
Y8/W2QTgaJ_Q[H8TU_=-)1>(E1ITYSfVB([E0Kd9g^N6RPAGf^C>9P_9E<NZIV[<
4^<;TO?O;;<+I3OTRO4g44DC-B4,>;.gHA\eI]@0QINd/94dYHE?7/[B6eWa35TI
JOAS]=NM@^;P.VbM]0HfCb-E5K1.Y]L2J?R5^WbcFR-.?FFe.e@W:FXLDO6)A),5
^=?]:^>8\W<-;U?7P?g8=4eVR-Ed#RI@PeDNNBUB24Z8Z5,b<&G>^a27d8(WB,bL
#68<;IA)^K<[^6aD(33QFdVcHHQKWB:0;/28#?.OH50/9TIaXT/PB62c[-e3EPa<
#O>egY5CFHf)97e1T_?\\g4He<If9YDbf#O#5)8X&Y33M7>\P<J.^.0Z\6M88Jd6
AaWB#g?[(g)^>];aZ@#/bR8)71gd=O-O8^W@^BdGVQPd?,c6,.-84P>-1OE=/-F.
^94JV\<gMID^-69aV#a#<1CT#ZdZ(H7#gU68GT;T;A8gc&gF>[::RPUSc;)&f692
U=>[,-KfFWe8fG8;((<[&0@LXa0VabPfdW-@e)03:WZ?+(Z[dX,eT>g+W(9OFdBS
@.Z5aKH-BXITgHf_@(SFZ)gBKGX(^6-#B+\2GC+__RQ(/.9,6?RW:L,_F0-C_U(-
IgKd:<)Xgd)OL,^MaO_I/>NDWH6PWgQ:1,=.[#dU.2[e8e;6\>_)acB\\+fBKVQF
dI.19F+&C,<gZ2MQO_-CE<dV]S<WC_#.GNO+7AE0LM6Zc\B0D\YaO>JUW+ed+.b/
\gJ^5J:O4DB[3Y88TfQ&>^6,\fUC@c_;e-L\E=:FPd[3P\Y\?+R?Y3=DYQgWJ)@?
Afd7170>X#AROT&D.YO\;+bM0NPa(,0/+(ZC?Xde[M7KJgU[R9L#WO#ZV0.eEN;O
[&dM104Q;JfYTZ5OGN/XB5WgSP@46(V1\1_:;gILU;9L@dRVGa&N_Q?b9^<1W+58
;M.BD,^gW_g9^=0OS[7\GbKMb:>#UJFD(ZS)T>/8JB@7C&VVX&MZK;_I1_NIM=CW
E0-La2Z:\@(@G)4@Ic_TU#I1bfR,2JB;:01S-&/d1ffGIcaKW]NV74@WR4?=>c&D
&f2,1:VAd_3+bK?NRY+SW<4bZ/3c:PcN@QZI@\P@CB/EP[AH;LJK888.Rc@UA];(
H-_<&\gC3XK9>6gC4>XR_NSLDL@bYM+G_:F@b47:8M:QU4ST_c;3@_c<E2,)Z,.E
gF^&)EVT32DMf:BB_U-QQHE?1+fd==0Qae9<G;5/1F&2+<.81bN<HBA2L@b]^HO7
7@.6,3L[&0<3bEEWaI6E8R1#ZbWfP323=g[R6=FK3+?@25?72M2Q:M/dG(C[23_Q
fURGf,:0H4+@1[NLTK(DYB;L:=6#LSX3:95c.EgI/TB@C$
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
BbMeWDcVAc_68_5#L(<2=Q_/-gG.9;2C<;#Y8F50DYS1a.JN)OII824M)XAa,=Og
(+Y)_YI8V=O?5O@VXY[AY:\Mb&XJNJ-PHNP2@&8@Pa&9U:/9NeH_>_FL_R;#GWUY
cBg&8HEDP\<\1X,+:67)P3)+Yb[bW&_:@H<-,9;8K9K(=aGG42OTbFX#V,OP4RGU
=aOZC7JGSXRLXJ?-([Z,gXfPRGZb\E+\R4CT2CGZJ&]X_48aLGb#9M<8RS[?8F5b
SN3B^caMYDYP;E<QN@G13H;>9.Q9LNWO&g1<O8:1^U,Q1-gKFD59SSX#PX3W+3gD
9]^XaRd0<-JK3BTLE])Be2CLRQ)XW6a0[aA2dUF?T:@=HBYN(A.5L.(N[LXC\C=<
17.)K]7NSDc[3A)2LF=5SI,Ib:AaKE@I_#P+OgU3+_BS_CL2[]6b#:@UA7C7?Le\
G,J(5))KC/BHFDQS+YM3TDQ#)O]G\T]4GGVS8HPMe9BJ;\RU_JUAfKO+LCN)afL7
=c+g#/VUaFLDcO(GFe/PUO/aE9c,8HedT?)Lg-2BTSCcV_K,1R[fbB^Z,0c;]DP#
(_1>D;MU9?YSa8R@R6^:I6+Wa;W&Q:[\C3Zbe#cGB^<MP?YfRa.7MG=<<QKeW5[(
T]I;7=?R:C_eDFJ]Zg0;]9UL)&K=3H/EY]1NZ7B@4.JdL,KO&?/aDTQT\Q2\2IOF
bJ5dX@D48I\M-62I-AcPB47AA48)a_/1G)Og:GQLfJ5g/AD;LGC+16(U??N.X)K=
)KeU#agZ>0WS&BF>34;=+YJ_0b/>6<0@8&e5.3Z0YG]]SMBR+Z_OQV)bgE:8f;Fg
0E\M;eL?.g-&,XJNTT4\L_-4<B3ZB?\H#AN\3f6R8CLG=3B;e.FVA<d#0(CfJ9VJ
H,1Uf.AYc#C[-\M0eJRBD:e]eaZ:cNEWC2H)I+&@UTd0D7)Gb(?EC(BU#eF(gP77
_P]e1X:YJ^JSXe1;,c3ZT90CT[,R/T8Y^WK>ZIKZ:a4W&O]0E,+fO:4/YJ0F<K/W
5e^,cVKg<b(E=/J]X\]Q<+aP/c5B+FNccf@\V3.&MHO&\,[^=CA[<DR7f=C^??)S
,5=a@<\O8H;O(O76288Y,YB@b,;<BN)NdE1[,)/X1>/9&BL.\K&&(ME9ES+9&,M@
,S?D6C[JC:-JAYGca;5QGWOV0&9.c[+CH6)@0X<;PbZ60HbU:;J&Y=H:VXL)Qfc^
,N>Sa8(>^U><AGQCT[aHJC?8e-B22:=8ZQL+@.2RSV\?V^8IQU8)0A.7.T&+GB+&
R6+KAb=S4>][OJS+H^4-3SBDJ,95IJSLQ^Y)>=W<=YE#>,A6NP\/f8,,X_5g[Ff?
_N=>ADVH)&[IBX#PI_^P6GY1(Z9NN\.JL7,a0LGRaXO2.=#f/HAc.3<ZWZAG\^\X
c&>MTI<N78O[3\\]Vg+TO@;d9^M;4F?7D@J(<(N?\M^#,8?W/=e_Nd,.:K6V0PK_
^51b_@XO=]6/XaTc]>0TUQ&T^e0S2RYfL@FZBULW=&cNY>:_+3BJb9:5EH^/=Wa1
fL,[Y[+4e?YR>GMG;C/2fD^2[Pb7-QZ[\L=c;MNX=9(GQF@C9ZY9gP_?@-EO_.+e
+&Y0ULJR8;+8@./a#XJD9E\Y:\,\Rf<44PG<?eY@7aTRE.@//)XTU58/ON(97gMT
N3P;8=MIE?=8;G?c+3N:WcLN<BW]aU2B2^J^T](6WLTNWNC+=>Z#L,PQYS71[+XF
7a<S^?/).11]ZL>-]FD39YRZ.ZSMMOI]3YE1g\U/8eDB=DdW,UJ_gHDV?V#bRE?W
aB81:BWN&fN,Og-:,g1f0KC[ZRV/Ad_#RC&:\]//CCWeM;NJIKe]YW[#9_\1/F.5
Y[Q6-)?68Q;49SdMgS>AeZ:^d+:;5((U+X3R7&4D\W6WJ^\53M;EZJgD.dHgeXc2
9XR\=5KbYW;KJR6WUacS\[PD]GUE7<IZUCTQR.F>:WCAXZ7O>gRE/EZD^.B^:-8\
O5SeEEHL&/a,\dN];BZdV60R?6ddgG-(c2+Hb7A7FKZF=&f.D>OD@T[gQab9R#:F
_b01Sd58dZY]G?G5WVT08F:TCg2[QIU],/FWDX3.PG#0d&XUU8/9J#<PeG;,G4Ob
D[L&D<4YeD1Q9(G4b_;Egb987H68\YZR.P7cB5B)P?&&HXONG_#+<=G:e8fGWQ1e
W<a:,P>]X6C465TaZ4@,JBWDX<L(:b[=9c_#>ZEc[<bK0DL++5#\(H)^/Zb;FY(N
L[C#FQ670Vd)(N#F+,KTD)CW+AQ?IFY\TZ=U@++D007UPBN-(N#A4<E49c1FQRPa
\K0DN<e,@@TSKP.AVE7,?Mcc)ZgRQ69&X[OW@CSNBTUVK+7e_KWT)WO:]OB^RAYK
[Vb?Pdc&S44LINZ7^@c#A&GH:U8H+RcTJQD=YPc?OT30H:_;BE&bN26/NWEREPcH
AHW>AJI=80C76H+8N[Kb0a3?.A[b2CT&Jc3S47]7a2(NCA97HZ+ef0BPAMM77&C\
RP7,\IL;BgREa(WcML3(2O<1e_@VB(X.-:TRJ[Wg^bIRaC(7TUE,_>U&A7\f5fbA
AVA6FO\2YNV8E80<SW;LEV#/\ZPdL)=LF[g:1N/FbS,_V=<2YL+d==N;8YfQ1aDX
AV9QYH&VeVW<2<\;D6=/C6V8c4Kc6VP(JWHac)+1N))RfUFB-);D:P2E83.4(de7
c7WH&GHOf90KTU=0)LG0@RIA)UMTD>[dQeNLJ4aF&)0LYFDb2APA9X)8N]#d5b_L
5_]-4EV+Q/.^AENe=g0daQKGY#1_T0_?:MFUXT9K:4&8eP3(O7\_S/(EVFRg\QcJ
0:?ZP2(8]GdO=C.?+5F8FLg^5NF7E(J3.:N4[D>U\^4C(10<deT>,G8R5,()L[R>
PETQd[BMLR-/(Y=V:OaJQ(7XV=<?=Q)M\4V\+.LN):/gXG.B+\NN7I\FTM;WSPS#
L8^#ad0:U,#Z&ZS8Z?/.b[RFY,1]AbD6FIC[B3Bd@#DWIF;T3]#b.Xdd9<2]^VI4
GC3.T[<2RQ6,QUPH#&OMMIcG]Z)aIPK;(c;(152A]DLUG\dEfM+,_^I3X6J]g>A-
WE2&=N98-5FU8WR4C2UKXET^eW^(fZ+-]IJ7@6Nf;O,QXNXQ6GKaM[)bTC,[8RN^
?==GZfZ(&fab)FH,RIV58JeYeTaM<24gc3LQcDf/K;Y1g7a]_5Z[R/,BLNDfM3K-
VRd-UE,&gRb@1O\G?4;I6a&FL6__T/8QGZJDVMK;RAeb,cM?A8-:LOM+IePA_>O[
L3\:^7@^B,<BC=?f_V8K([EKU.UR@ANE_aF?:YGS1Ag])U2b(Tb=9+JOQK&-JJ2;
VH;U]MdX<(>1,#JP1L=SNIQH/CW>.33DgD3H(4/LU+H9T66&LU(>F:)@9I3A0C<V
D(?aS?OX/\B3&H:-7SBAEG&CO@XGR+.[fGNb>UcDC,9IeaCO-Z>ZTYI+,RF9e@/H
QB:.[Z51dIL7:F:.80B/SQ<X6@P1C6Z-V9Y,&YO-2&E@;LI?;cBIJ(UbIYea66HT
RKPM/T@5J=IY?d?/=@[M^\2R0(VT5c]&cbe.883;;9>VGSdVgI<P2?e3]Z8UN)CX
LTQ_]DL3]26[L:d(P-,E(R94Q7XD<01_B9,I9@]UB8^/^_9V#K0/DYEV<R+.Pa:Y
.[4F=NKWTfbFf?^1#^K224>.3;)EdBS\J<)YB3(0<eAJX[2X;/K[43TB7-KYg\J4
bUO)A+S-83W.3L@Fb&f6)@H\<aUK=Z]D8Y[<ZFW[@<Z4/LX+F[ACNBLfbQ,?)<D&
J7>X//ZQ=f8/;KT+8SM^4VO0dEL:+/1+b:&ODC,?c177g2HI3OC+#d]RQTF<966c
B^^9_3^ALeBd:B5>ec^C(0+QEW??(/2d0>LJ<A7VKX<9]^4[OKR5?A>;2=#1XgWS
44?U,D2^IIgE:UZ\118.W04B]&d#b3+0=#/AZ(a/,\YVeJQdV,QLA#_bB/+^(C7)
CD^dG\aNL#FF,33]=Z2]X(c\SH7.=<58EdfV?X(7,Q5TbL9-.fLdc+7eHd#0gP0Z
+0Q2-W<f(eb^G_]NEA7.A8dY/V(4K94dO+HHU\-DW<Y5>40Y06W2OL<U(,APHVEd
.#JcMRed<eg0LbO&M.(^aeC=6T>-^S7E79LN=KZN1R=CF.&NeC&.ebGIZSPKUdg+
0DZPRL>9I+4[TIM7fS3Id?.)RS[)Bd9)cW7f\J.X.0PEYL0_bYS)&@ET;dEKYf+2
_dA;MNZHcg=GEODP#;H3R:V64W)RGTK^6WCSbg=eWSJ@c5Z0L8[cLS@VPF;,(d),
L)V&W#1+1O3&6XU+9MM(K1TSU^7NR6=@=]f=#G-eggV>)E]1ZKKHf^4@>AbF6Y2D
b+Y;[QRD^degdGZ7N>O=+Z(R6_#IH=RG<Nc&H9#+f[HJYVSH=A\Q5&2D9CaY&VAb
#Xd3@c;dHCe?(^&K^0,S^/9>I>L0R]b,2;>Z]c;C8OYL=<d20d1cZ9]g5aB=VOY&
T)b9KO..\d8Z=2Z;<R9@,&J0gJU7DUIZS.9;e,66cbTQ/HfBRfK<N552T43,B4@B
>bFZP>Jd9P>N39]O\;]OPPMUL;0.f0b0)Z:?C3#MR)_(,C>R6cgeHQCU9e1&VJV3
3)J8;.(dUZN/PK9gC&C&A3.RLQed66Lege<GKZ:d?^e6[JOWKgZ)0cgd9F-8BRW.
bH#,SK_a8aO]K36MATS59bE<H3LWL9;5UHS<)V>]a2L-0YNJ85T];J7@8_&f.&>C
[S.OIa=X9&Q8W5Z9J3WRfS19WYQg_gNVfZ,dS5^U2SAeeUJI#20R(_FaJ/;D;-VK
D,g[7VQ^WA@gY[PCdYeQIM=XaQJ[=2I;^1,RSITR.Y>&T5</DM4aB:=#>4,HYYe,
I;Zd-DN^FO\Z_:Bg,,;9=YK3LECK#.4_G;LZ?a?YLY]4CS>^R38FNZNaOP.YG+)T
2+.RJc<T2IWgKg<&EQZHY,O;;cLRe8U^@>aN4MLL?KA0&4DU/51Y)>fZ3>]F0@PI
E-@KcgWWI/QP1V\BJ6K1_#7(P/Z,=dHN,ce]K_UegN9>47>WB)F<@X.CJ6>If(3e
MK_4CC>+YX;XT(N8K_F+\Yd_7VYQ[8XSY9c3W+-:UNTH_;.V8JdER>>QD>=-3=I-
,W\KV#6I]:SS9_<#6<0I<bX]Ldg@GZ=;5#G^VY&EK6R2M)63]7PT;K9d?QHfcTFa
d^@O,)\,F:5N2,>V[V&:(]C573-T;RaE,07^?SJYZAM\Y1WF3NY9TaN<)#WJ^HCI
b9=S+7H7(gZK0#DL?MAB?7G9eM_LR@P(@\WYP4/2)-BF:UcNL<DO^[Kd?,fQ1H3\
GacZ2.Dg_M^D;:2g6ZET8S_@02].9DD)V0,E;O0aEX?]^c4VeKILcR4@MOcJ2]:e
2_bOgN3dWEO6N:F9Lg4O4U/&+EZe0=(c?E+0\7[5JcO3:TI8D9ZF2cI#+]/73b66
AI<>^V]fe:[EQ2_K7>P481UA/I?RIH.0Bc,Fe9=M]J.,QRf[a3>bDXE[)g]?+,8+
g)MZ&XaDB\@?:PAMRdR>(^^fT,/EAdV_..APZP]A-IX-W/KGcUIG0dOKEN13^c:.
R,QBU?^(ANfBf09/7<X=&19E?N(<Z@0?&#JPE3,B<2NG.NC(#]A4A6XN^eb/3)HS
>I>bBGB[JQS;K7Y1<XdV@\+DX#;VN644N:FI?A)+/(OB:BT^PbZYceg0WA0[8:.:
1Y=Y>(9XLLcB,g2^X]]E?@(?04RVaX+>;X@A?5X-c0#BQc<3O\]YC6g0J$
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
;R.2Q03M8EH,<1P29<GD9&GW(gd?)67^(:T5<((H8(Sc\OT\AF0)90,e8ARN8A_A
;D9M6dRY]MNIV4P+FZ;CE(bbXOAbA2=B-Lb18R2e?=gZ>?1@Ie3/ID\TS1eTTFa]
(F:]_c+QWGdA9g/WD5<XDf@KPC4+UI89YN5L1dIXZJaf.LdT))O?^C[VW/)[(84.
G7cPS57574+A0,BZH>U(F]gR.f5a=U](3S36+.b+9<Y09)JT,?HP++(GDLUP8S/5
fA_5L.L>##8B^YH4I,(C;M;(Y86?dB5@3e[95WS/-@&aI;O&.2E+>Je4=Q(G,HA9
R>IK=^&_9(JC5JISB.5e^Y@<67a3498I[dL(?ANJ/LPG\H#W/&NU,&dMd2&WP#A\
]PNI<TC=E6LKR8>Z_3a[>UI7<CP7-FYg]:OdTd+R@LFU@d/A0-Tc,?CTW[ZX^fG0
R,X>&Q)FWAEgXKP=bXBX?)MBX/+dc?IN=bO??XD-1U8TC,17Y1fb/V^H(A:5O>>(
Y.^AGW+W6Va/#B[9+LIV=9[A3?KLXcSbP(ZScA1J,-]I&\>5&e9CAE[GHDQO._MR
XG<I+A3S<YA4+CC/XFOK+^+a7#C=fJ+aH:9O?[5.IZB6O6aK87#/+J>[BC/AM,<-
2T#S)Wc27^U5O5?4@dFD+K8cV0_&/.a:fR7<,[ec>Lda>8NH)0eM7-@=2f01>LNK
VfG1fAVa^3,VF3<7&B]3VQd@8DT<;I,QQ)K?2MLDO&R@8SaDM4ZZZU,DWTLfY3CK
A8a3N/(K87,-SGHN:dJE5(KbT0?.1:7b2&B..17G6G[O_N:0<IEQe]E=./UFY>Y#
;X=_4[NOHE9CgQUVD5O2Hg8USg>HCON&d[N@99<a2]ZOPcQX4DT\9+9b/>L[@EK3
EP:BZJD+\S@.20/O#<TEJ7+->DcBY^CM]N8(OR[GV)f1LPB<YbJN;?YF57&27Q9C
<\:=Y3R^LR+=a1VceR,Yc8#a+fW49E:K()\,/[\G30B7;N6GF=;B:2H/XEMCZXaW
2b_VOB3CGW3dT>0^X]+-#:ZJ<9]97\&3?cMTT>6IG]OAT>-,HfE&UPBaQ4C:-TAJ
IJ]IH.H0H?-67;;DLJ>I>g4O:.da\BKVH&JKHCTLXc@C)C/6Q[fRNJ4O(+CRV8:M
RMeR>?T1V6\GO9.V5JSYb?cEGFXgX4fHQa#4[AIbI(L#9?W+[)ZEPW.NBKd82\4Q
SHJ8T+Z[QfK&>fb1X;a_4+LY,9CM^S.)Q=YeJ^Q2PX+RO^IDUM(1;<C2a(.G8:C=
eG)Sc83^S8ML<M&c-IB9O\H/)S+#J;-)<:5@S_UCFc)JN7R<U3QZga,a_^H:f35@
^^:MCEKDc;ANd.CE]DQC2#)_22UOLU+NK,JR5^RZ4QEQFA)A2_S-+BWA=EI3gK[f
N@//LGMMH-K^+-<^]_ND8QZ)#,^O25QIbLf4e-5SJaBU65#/I<,]KRU^,S-KVWC(
<Y#[T5DVNTL4.Y220e5<H3T1H@&V:0Ig^<c=aa_/9SL/BK/YF_1_4=?IBg0B8f[S
8[YJEU@>,fJG47[:GO^:g+1EAL5ZK3)VOOc\Ic[(gE0KE)(,<O/AF[JKUW;ANaD<
9H.(N1IDGf_T7^ZLa2VLG8SV(\1P:X4=&d+32dX),Qe7A<d<Z9XNA:[bH>DbBI;O
6NP,[e_Pd\_JfZAA;VL-GE\Y-Q902eQ+K<5cLA@,>\DDD8=[I^44+4,/<P@)+6OC
g^)cQWg;g/]..OeXOGVU\ZZgX6.X]Bc2JCYXQ3e/7,>2MJMD=.\#7[I\8#>?4OJ_
A<cJ^g-2>+#G]2[Y:.V/5JA[K\7g7)8VCV,?W]&+\L]4.J>8c1EdR2bOE5BR(S]P
ec-TBVd;JH]7^)9FBOV63]7TL7/=TN=fH#I=^&g7=#OHCJX6ZZ#gb-#6a?E+3E0G
X8;LI@Z4;J&gW=LX3AIOd;Df(OD1[LLd?AUW3_UOQV#]+K_0Z7eJGL>&W@[^XKRe
fF3Y,RV7#6U;[G<A]C=7FW\21a6-;DFNU+T.F^Wb.M/5+:L]KC<R?K93,NP-XTK,
4[]V>:8AGX4HQg([Wc8ge3[K?YSd8bKHACVeY<V\7PXM=\54>b#FA?3D7F#_IdE&
cbW4]M=G[GfG,^NQ_^1gZ#O>c[b,[gC?EPGV5RO#gRN)\SQLS+V7V#@/g=Ve&6YW
<<53ePFNb0]SaHIac1AZ/LBG^QS8?246be>EIFT+MH<TA+K1?9)OdJP0;eA<GXKC
/<Z2<S8N>2,S0$
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
