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

//`protected
IL?jHSQH5DT^<1X:XTD`^h]FP^VC<<m]mOHnf30ep1dbLWmOKAPfTDjBFkGIkbfX
XBF^oL:m6f^oJH1RoQ>@e07Y;3Un7G;f02Uhh>iO;_0_eHK=picBmT2JaeRF:@lJ
QO@bB8XT:m2c?Z6E8L=93DBYV5f7;Ddq9iE@\MpDh^N[GpnWGg<:iqL63ni@HN^`
eViEi6^mQ[HG[A[3n0:Ho>bnaC<d_nJ6Z\Q[NnlVT`O>eQgmUp`RBifB5H5BU8L?
7ahC[Y1Nj`7R=e:nb_9eE_6CpfWc@b=g;TgZ8K\F6lckI42H6I1e]>bNK5=qH0NM
cYOiC:mNb>_HIUc9\`=_d49L6h35=loidFG??Foq?g0k_ciMD56nB]=8f57WgjK=
Q4PBM=7NS0jFQ783n6`qQ9UCUYMXF6@@X^U8Ya0aATQ>WJ^OanObQZ_[jC@FDKNe
JD>M`_bK`b75;e[?8kmmq]:o2@P0P;KMKXaIMdcj`Q7Oj>fe[SRVfpmAeZK60:4C
<WWNDC[]nSE1XajdeaED0RD2qVTPnaCQ?>?MaWa@5XDBcLS]=1F82`eKpimB9]12
\L@A=iS?P@hI46YgF7@>KWhS\kd:O0>ZF\j>=g5546`8[Df6Y96q`BLk`ekpFLmm
M<Xhm6KdXE^oOB76C8OU@YiM9FfZBKmTpcX=AEicW0HATRh^76fj]5lfK\U4R<Ie
@;XF1F8IZQ96Np@d>@N`mp@44Y_?l?9DZ@]1]5]XX`hRl2J7>GPCPUh@9o_]`cRM
:4g909NQfAmUDS`hj1;bSH[Kp[N7I=N]h`CPIO8M4NfoC_Mm[WicmqTVm<_?FdF]
RjQP>^PCkoig0R8m5YIhW=jo_gSYb91;M0:Ff48cVCALhKqY]@Mb^MkT:eOd0lI0
YIMejW3i2aZWL9B]?qlec2A_ZpIW9[Xm5q59NX5VQaaXS?Vi^Z3T<BEIfKT[ZLaj
kY0J`OZ\F22m5MFR>Y;2N8`QZTTdck19d:PD3VEQi0P]iAW7AoIQ_R8j_R;AJi]7
oU_RFi;C;S;;MICc8E>np@Mam;DQ^G649oG>j`L[VXkcVFW_8DjVa_QbA^F?HKNZ
mZ\Ap]k@FfR`=Ok[Y_6l3o]Jm;dAjdi^2QjY?9Ud3AB3=Fi2GLfgTgHW[j6@SnO1
5pHZ@?fKDRLBc>nYVm;ADl>I2nmC0P@c[jX1nclA_@=^FLN5?S2kq<dVSo4jaF`R
IcXNfcHgSILG@jG?YT0US_JAXR[QA]PQi_>Bh9I`Jpdb4caG]E:7:99GT7XDFReK
emQX6]K10ZOAhFQgOFeIV6S1>@P_SARUcK=A<EZmVipE8ZIKToZUiFJZZae53E:9
?8YSS4hgNAm_3N?P@d_[UT9H5g7gMUdOAc2Ic0qj17lDEn2jE<iS>2Im3jg0S03N
go]NUG3qem17EJ\kE?T4gHB1J_KoflJ5iOV:3_HD_6@O^?b7boJ[Wi\T7KdoKQ4V
FGLLTf3Vgf8eMn;fSo`bga<<^Pq[G:3aGW9I>kcKQ=3YLhjCk_PJd2YGUeR4UEdQ
TPl>K[9hjmjE[5nX\jbWQ[`mY57@IYHlRa?Z7HTS4=`361>_NM[eaZ1FRZ]64?DC
aNS9Jm36C9p24bJ47[P>JNYWD;eECKX^T5S^lTK5I:Y;UO@OAJB?8NC?@=>S;Wml
DF;UAhm9WhaqCNYl\A_<e5=<0\a4@5`<O>Np]=>Pl_`3S@?LWl=E?ofhbdcRk<QD
b76mT]8lc;RWS<8P3ESD6=5i9Qc6^Q4`Maf:m^V70M1QgDidXUHV`X2f3Z:gCGZS
TZRIAlVLVlpKQO54oIifIGjhV<07k_Q`;Z0T7QNWLY]K;bn[7GU_kQ6ES`<oU3lC
^lH1ZWXm_AHdAE>[;:bHXqoE8JKUE]`\ajkQ=qi?9]Kl>_2A6L^[R3;7@X5WbEbL
0W]5P9a<m1oPpT9W0IcJ6klJc>Re_9I^JmCU[BlqNDa7BcjR1n<hJ0<LmG54FG;Y
HU3_MiI0\LXbZfgqFM<j1@R>gC``IG0n6DSi;1p_S@B[Oioo]4E_RAhmN?3N69qC
Gj]XEa<hbDY^@A[bVHUFGEnl@g[pTZRTeKa2NKM=;@`@V>pkSPiIL@Ug`W4YYM]1
;a9\>85N3dd`7C[\TqPMHE8=g>1R6HFkXFo4qbRK3K[CIE6U]CdASGCWp1:ATENi
2n=BklooO0I\P_H9mnXFnR0<U?0Cq5Xfch9K5h6U53Y=@Y_[7Wl4^Q??LFeLAld[
F`Pklk;L8K`Yj@nBm?DY1]`]aphKH]UF5dIW9To:N:]VD`K]W\ZC3_R4;GSPJXJ<
i]Nh8i:fFNQTe7LV6mEmnm`7jg<7ch8BM9BmeE;IqCI\Ma^SWSA7O0Ld:nWHKQV;
D5\[<_]@8NgR8g[145VI0D`YoK3XNfM2EmkQMMR9AC>ODk^$
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
FV<TZSQd5DT^<KJiiE`ELDkc:TMiemWVi\nCeE`]EDN]i0@12N9Q>oUR?5:h13BF
B@2\V7=Wj]fq<UUlT9JTQn<Xf2DD6R7EPA:FYL=JOXN4mQ7BEYUpdEO]^<GMh7Ol
\7i\oJ=?O8l::lOIQi1ZRZ2oH`k841[Af`878oRbXaAo^0O9N42`?M:GqL[;RDHq
9GbP\WFP\<RcE5j;c@Q2mgmpXC7BQGh[_io[PZOTXKCdE93Ug\`7VfFlNRcfGhEY
NGKZHAgpF[]g3XR[JOhKo:T?5Ha2C4_hK<IKBU4@NO?=d`pdG03KYp=?oHd0QNTJ
AjhkVlQ`l9K0WB0agqC@S_N0m2H2;aYh3q9nO[<8S8d=KJKPYTmP2m``kHa65R4=
U]Te3in7q`gGG;9a1=;mnb\K6docTk1lc<hIRq[j1ecbVmXnA57k76YmDPE;0BdP
jjk:dY9:ilX2NICS]9ljj`5:Sl7Po0bkn_nT<qnZ8@cI[q@bafgW9[\gPA^`Ee>O
aCg@o1eOWMNRJ\Io=WjOjmm;UjCl?E<Q`03D<R5;ccYL^qkV9@D6pP>d:@\D\ZV:
YC_]i3A[P75<ST7m<beUqoeeEkKGH5A`A>C^`fnWW1T8C@_?@aLCHoS]k7cmOJ2f
9O;0kFQJ1lG26Tn\SpPLKZkgMWGLZA[XLb[8W;PafgQI6W\\dfjBh\[n`pKVXRER
kKbH:IH7@WbB16_7=XLm_UbeifqUAUBj6q9Pca>f3P?`\gGd@6F1U7cW\dp3W0WB
;<IFoQe1R3b5n]]E`4[F9?W>CCFDlNJD\f?d^_b9oLY<IX[`2p_gQLO:T@]AjjIh
haLG;5DORN?Rq6>mOR7HSXMdPk5@k5\Y0J;@DY^401hk[;e6pOgIkD2q1I\^=0Wq
m_gWQN6dXBIB2ffX@NJJ8LFVN1H<KKj^j4ImU?2Dh4YVNR_c6H1^FWq3VV`l0eh[
5k9FDBYI<<>K?q?W@F16LiS^GCfhFJTV9QU0eq12HYg6]F0E>`ShS6j[<eHA9pUU
kFL_2X_n^m0ci:O1@gfX8qegQOZoNUloFT71IV:cnU?OG21UB<CK0^Agm2D1_m6A
43L?]G[_D6>Q>5@JaXp091?46B<TKCfJaL;abYg3lqlTkimeQOY1jfBe0IWomkl9
p^IShWI<da`JRFY@D`V=EKWq87bG0RnYH7JcQE2\[XnKKVFj:ebp^\ghT@6F:BJ<
ne[\HljhkBVdV_<pfZ9[Q`kHgB7;[^KjC\hm_jd`IdZ`qWIhUCC1K<AF9hQFMC^T
X`E6>GYn0p\6im^<JRfEWHV4860Yao:Tbk6VXYY0k1fJ<X58R^3gaDO^V<UG8Ncm
HSBWO3`MHa6RAYHWpA0OWPjCdG0=bi<k8N0IdGRToSb2pCJP8AFO=NfEPYlg0_MY
8RU1gN`n`KaBq_P;B`JB][HBQb];ZGd[RfM?>:3LC8n?gp8\CI=NVi[3j=[^ldF4
El8X2bb]OTq4Fh<eZ;1NnC1H1ANMg\@DOcoc=TKWF0h0^ahmkCNRA1S[<qi:;eGB
c=E[iK3H<n8^UD121`1GN6JFb:WkkQdlIH[^:>7IfNAL=lVSGk42pfPjbRmH5JLd
V_e@?LOX[Od5G9X<lQBm7PMp7haI]Aph5BmHAp=l3OUaqGKcQeGEJFdKdiX5p6hm
@Anp66]Uj2U4UO8YUO:KOD@00FmCH6K?8;`pdgP]ceO;TKTHNVCS\8^i6LK6RXGn
VcHp3^9@4ibDb4Kk:81efPdiUIHH2QJPc^q76O3FbYHO7WdZFRMQN_R06VE4630d
@qJh1Ad5mSAlOX??YcTPlpEl?1TcVnegS^:^01Fio4Y271Fa4N]`fYH^F^l1RnTM
ck<?l]<SfMOmQ?FXDfp2<4J`Wq1L6YLWq=?@]_dq4^INhmpoP1UE]TiYT9kY0IiA
dk]^fhh[j5oeX:qBWH<EGA;SP7H]Z`]QS;ioNT\XcOgdVgp=X=]G>ZH`P>Gjn\75
AIDTE07Leh0`^qo:VW[jEZS;?TPMSWB62EC=17Y@Z4mJpnU3;W5\`pB_j_9M?l03
li^8hVeVUn@iha[AR\jB=<2>DT_P9@CFAP2YiTV@T]m:bX9Jb:df@Zo;[q9a9QTi
iqPHhcZJqB;o6Mm:qo:iPlhNa9l^E^F0WWZZU@^_XkbhLUbQgmol2bJ9i<aSITkg
P:cn_:dheF9?alY5SZ@DqLbaU<\4<>OCSOiDPfNOh@eA2gNWQENBpLICXHFm<0`V
SBIPHCjn:HLD5DkXaVCKpZiMc9`^Rj03o=@^IH3EX?g7OhGJl0ep6RaQh3mLPPP`
`aNo]lkYAXnIcFiI]Eq?lQ>gBb0P12Rc9AU:HF_BYdM^ibOpYW@ckmoq76LKAIq>
J6FGohpnMcMR3U?KM=ZZj4F9@l7CIia^3fo[COD402`j>P6Gh4U4FHbialNQAd?^
aQ22VHXdNVgGkMJqJ1IX\1HlJRi=]2R7m??AljKEqSUBnGJ_7VV@]<1O?QD7JHm?
=ZbmkNJpn;B7gfR=`TZfgW5j4?<_CFRK539S1E]5_IqX>VTn5jZ5o8Qhd[S07;1c
FlM@d\8l<c2pRRgh^@<f_X;]`c_862]>4mO_4gA7d@K1Ge`MQK:pd:`RiWX2BVnG
gYCG`Dk]i[Q]gO6Wk9RU6mH?dSncqgiRa2P9Gk[\jFi978lD1XFU9<@<Gba0cIe\
\pGmce6ij^8ZjnG]7SWb3DaZT_DVDVPA2lb5aAp?63Don87ijhZe4C=6WZ>2F[JO
b_dF9dc\TYGgIe_lWZ_6=<X8mhd72`08VnaB=]pFB\eaBK=V\;Z^k:@?l0?74mS[
B\>h9iXhGgFp;Gd^dCJY<;MF\W7?qIZTk425M5N7?NeD@@AbJ\Ph3f:6C\EgWX\<
p9Jk5[ffb84FRUG7WHLHI5l`BdXNHAI3WKb]qkgkX;1M94WNA2NJ<mgED8ZMI:8p
c[FnUXPpMXF[cNUP5R5o0eh<CnpoZ:8OY\dQ`CbQneXU;I0lWmcJ>Z9aopelWQ20
M>GHO@k<CMXAin8A=LhZ@d;Tgql_ElZl]lHE`6ZL5KVmgZN>?kGV8Q767pkZeeoF
epM<jiIV>IAUQTMnpBih]e@@l^NZcn>KXLe=a=i46TeZe5[Lj<ZRqDBbg`gVilNQ
^c;a6c;?2FL5N?^OoFfBCbn^Sp1j:]602mbRCc4F=SN_HAAG1HfhEO1fDqCJ19GK
2QTBYQIL`[6?f_]UmQHQQAfLR[pm`3<n?Bq4l`Ajlii=Rb5FP3YSTI`iRi6>77>n
`:VYaipbfnMJ`8phEV04mFalal_nMRY63cP4B^FAo^G2@O_THmbUUPI3N=Hm]33:
DIO]b3XnaT92[]`K;KC_mg`bNl_n@fg8CA6P1F>qXRk^FDcO10b8QG076P5JCXO2
^E6\?CeV50fApd]PUk>Ee3;BiM@NQ3`_^93p\T;;MR3m7;IT;74_L8PJ`k?BNVjQ
p5c\ISHS_3SM=dBP[:GqkPXL80URZ]B=6]2nmolc\Ign6_@i<`VhFPhqoZ`oH3a^
Njl^OB9F2=Zhk6cXFTW0aJOMSQeRQ39X<i?VeLUBAI1<EVh=cR3:[eYUI26E4GqB
j1aE`Oq8A_:?ELQ;ZnS`J\jaSISYJMiTMRENm;6W_60@<5]p?If4BPZCnien[e6c
p[Q9hL?;q^4\a\b\CO_21R6;OK=n8I8k[;lIB9B=d5N?jYP_VEEgEYmambAmVT<G
Z\6830XpXZ3O7I=q06g^F;d?D9oG_[_fJ;2d0hQUCeg9Db\HWBN`Y]Va`:GOOE2G
[bd0bm9RC:4b@GXNn:M`KmFSUkG=E\V[ASiYoQn5ondK43MnadqlUm16o<p^1Ta9
HRP]>9HV92_:=<1pm:deSFo3_=nIFUY`Y_9nDCf@Slb>fS@JS7jbNQXJdXAZEmSV
L^f;8Q^YW9:>]>>:lC]VYOB2kBo0m[8;pfAa?Zl:`H2AlAomeeWk=\ZE^@k3<JGX
N[jjbqmb5<LnJpIBS\1@Z_cEmplU3Oc\hpYb>hF7LB6G1:J\kOEcR5k6\1UV;0k3
NlRiPCm^PqVYNmXY;J7W=6T83L:?>Xd[bQ_TgD;Vh$
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
[`WPQSQd5DT^<ANlFigAGciVBJhX2U53fT?DIU]^X\i??VnKp;h\Al7\NW3b<Wn5
_j@2?WBB`_od9O]e53FI3fQKkVEF1FA@iC=H1]9eD;oYqc@Q=M^YKN3R\5:a]I@2
BmI2]W]@DNHpIolh4OqdOL13Z80T<W:Tl4>;1YKGJ0]^7N0OFX5XJEU@dR[GWW?_
EPIAJ>c6TA97YpGFcjm=\CGUlX:O3?EDk9TRnW8RSW`H5A4N64K6Vc?eGOX4b8]i
JV^HaA9V`gj`TWD@Y;`lFGIo;pRkGG74fh]\:LH8Q`h]N>F4pdl@Z[Tg8OK`UnJ\
NK?5ISAU2lVTmJnGf1Ek@hCHNl4Fl2WmOd;hlUf;qX<DoGZ=61i]1VZ9o^\3KK_G
]o1;RgFjYm8H3^70JW5fVYZ4@RgN`eOXLmWBPl`>lHGi1S:o7h=<i]88_:jKqlQj
]08bDSH\6GhPCccf5o]8SRgPVHemi7DSS?;D1\Q0P7V4lq_m>On6^p;V8Q9UGE@3
:7gkmH6Ea]NO0iM7TCqJZGN:H[[bGP2a?gaiS@5j;;<<f`n2_I9F=pZRUaF?kqiS
mNYA018I0XXNm3<nG60nfIo1H@\anA=FX?a7YH]=FA07d4M@FQbWJ2p1?ccmDO`k
bWH8<;d>_?Bo4e=6PVhkY8GU`5Zah\Dnjj:eb<B\<SF]kJOe9W2?PXG?NCR<[@H@
8QJ<R9om3_gqJaA5IEoqi8O@YmVPO==7MW@]O@[W7cDjV:QRgnH`HmgWFF=84;dZ
=cN>_PE1k>\DpC=lhJIP<9EZ\miCR=K\;=cInDWXSNU[p^ICjREV:Y]PV\Lh_@36
>;>jYI3gQ]ZBIgQKol63oCCWHY>l8];k9I;?eq>37ZiK3UNcMdZkO0JQo6bgd2ZC
Um:]Jg;?INC:[_S7PIIBH\G0?9BO7Bd[lY61XjiO;XNH4@>Vf\NQfK9KRHq1T<P6
m\pM>__OQ9?PGO]3G4<>Fb<:;J_Y^IC_S;p9Nl<Rlqnm1:gfVMOT2;c2ehEleg5P
3IojnZ1a>BC5QbKn_@fe6dUI1B0YeZ@0`qoY888lNaGH5[HB@p7SH2bKWSGnHiZ@
;6lV0mHQh]?2lng0EMEQXEEZfW?=X]f?ll2QZM<Iamg\iJKE82neYZRdNZD8MDYh
4cLR@pFVTGKG4qeR@Zi5E2S65B09P>UfglI<lak2boq;9dS3Z:pk7ATgb9VYeM^`
jCo6[oElEV__R<MnnRI]P1[7j3SHXdBa4fNo0V4jVc`anZUqHLWRCROolUFlf0Qc
_dC7h:l`i;DogXfAC^gd>h\3bbaT^P7_TXB8ElNCN0a5IlPDAnnk@5\3@XH=Eiq>
CVjlRO>aIhC873V^7ifE?TMGG=T]]m<dWJ:nYA0cAFL6<YOS\bQ5j;Im`=k\FTT>
eRjDMfOJ>2=JWD>9\lRYZ2[^AC^UKpBco>BnafKepEK6ni11]UY7EbXb:75M?7]N
A]j^f_H]DSWoC8Q6qHG@d8>QHK@FkloiKOijI5FlKUhe=m?bR25EApQCb`d6LnDY
?ZKN6\SU^?:KX0f`eHij<oM4B=ple^nRcTp^ebcD\bq3:0C_SLqnXjRMEIBf_J8I
FYB0O>DY:OZ5AoTL?LUp46bkYUF4]<Ye9`bUGMh=@5e9A<PXlc;A8SP?R\gJ890^
dgF=_@`MMV9N9J_8RK9CpkAgce7fqB8:nAmiSid8BWeCd@<CE[S;p1@OH0OMSi\W
LcV_6HBjWXna<c^=epZ\7>D?6n_I1YM5367ke`Jlp[>fK]]A`A\MX=nD39Sc1p\h
f3O2hI72SjROon9X@Z[UT4`Y50JnB6;opn512LW=A`X]hNYNCj[cP96YT63308cT
b:=q;5c7M9\MSLFgbPGm@HFCfSFZ7>ng8HACiY=OaeZON0Q<CNCG2jgTpBQ:Y^<<
HD@F`4H>H8`JeR40=aGOp[=P25gZZ4A7mmP`k0`gggY\;WJ8jomQC`7p8;=0m8gp
SRd8g`BWYNOa7eFMil@_pUjd0hXZ3FB;c2]6aNcfU?G6K[E@9DJPnYgB?Q[glH[2
egeT4iP2]]afD@BMCTCCWAZD=4bLXgD7HP:6j:idR;JmmpMffiNR`[mXD21@>l_N
>JMNMSK`qEQ`?Dj\f:hK;ZQWpl_Zhh:bpNjDcQG?AcGY7OE3INN]^`AnEdPW[B1g
HO?JcOInh;?bU\5<VhC:Z\48bp]5Q5]B0aBYj_4oN8>cQm1I=k1Y9lhA5kD<K8=@
Ji`1[dE7Y6>nU?CeOfcf<9hA=;TY[hSCo=CBaJO3NO@F0]iY8:p<JOf;:9@8ZJoG
fJV2NpLORGA:=JEd8`aDiXj<f4;XTI]gpLlnlOkPKLk\6R1D?clR`TSU<`0I2Fim
EoSF;`;X@gX2Jc9;=@Df`@\Xgg6oE[ekRLNhTC@73p5ogW30mm\f5f[EUe5AaTEJ
3g1[S`B_XZ=ie=cPlOM?E59H^Eh7lc11pSGgWJBkq4V07]JO6ifLK[?U@1[?mQTP
gSk6\l:LRM2j=l3Ja:hm:J0P^1^HH2^JiOFTIB@\6CcOXPW?MQf?SAY5T^]^3;PD
F9b3FPIa;W[:AAI]Kk8qe<bS@idIRMYmZXYSiMU[S\Z73nq?6aGHd_qg0J<dWhFM
176igq2J0Vm`:?^]7kejp4`cge^9?=ZmU7k=0>d0gJ9cOfi``a`99bM\D5Yj0q_o
b4H3adT_HX?;@1L1@LJH27KRg6GGTH2SOI2MnHId0oJKa4bkAh4j]Q^Qm>RnS?:@
MG[Z^HYX>oa83IL]1>mP`CGRA<6A=`nTWH\;n_mgL9DdpghPlN2iVUa^9W=f];b5
E`092SV<A7444I^>0Z^XPJLePedRW`PW`Kg<U>YMqhTZ?oL6Z1j\]?K?No6>AB0i
gT\qhRZhU\2q?b\E;Mc`4LMmHFM]m`1JB0f1HT4Hn@Qq_[S:d_AU=AYeNGQSW3Z:
4`d;K[L2WUPMB\MR1jlpE1hmiVd48l=\o\1P8>QCFWm1Fc5F;fXW9JB6n4_h8QhM
hOep=<^hg4S4BmblJ5ML3eO;Eo=S>8FOPgS@O@B3>Gb[gd[1>:m7EmHh<0b@dRjj
AYFJ?_^TgZTCA6qNV1<^UQN5PcWa\S@0;a[a>;X0K=Oqa<Sn^7]KMl<Y0T4\_lXq
32T\b[A<1_o4Y]Ygf`8RD9^_Yo`9DYS13n8qKk_;H0?dVWA_IC\`F9BOb3Dm6lm^
R_iU;iIPSXfTEYGmnJ7h5\?p9ZcH:HmCq;5YZJZY>QC`[fMj>MgRpEk99\UE<gMY
TTX@nDaPLlOj2I7HT7P5kN@;5cPcn?>?aONha0THDfM1I1f``Tm3[7ShUqCD^6ll
j=[4eD?GY_2HDdd2_oF2j=g_^BVUIhld=Zf:qd:7L]H<4f2Cn0LM6k6kB]nKOno8
oL4NM\iG@;3:WhcphlJDJW8PXb>TOO69SlZ9QKPZj;U=i50M]jMmM1A<[doQB1b=
eH>qg5EZBhBcp5WX39SXgj5G\UgSpMM]8fW2JqTln8WY=bPZn@5dG7;^_`I?;Ykj
O]W]GDqE9DSF@VV4WZGBcY^P6hCD2pL?7FZjRplBYoTBPa7dfZFg0dQM=P>nH[;H
Mc@PAI<FTebiC5e=JU2SiT>WM3`Hn32bP1^3K:>`jkIAc4c]U:4geLG;ZA>EW_YC
5QhcG1?mClJ9N3d2g<L0_KZ69Bma_jmWgK64qhf8`U\:p;g=LH^49=[ilePO2@M<
<4\]7UJ:ao:\Y2g_6dL8L32ZR:>jNSlKMWjZ\hA099jc[;QO[]`8qG[UM2FZhZhn
=3P;Ab:>7DJLNS<ZNWN^;YfVMVWFOV7j`RZb_FVIjjTj__g;dVWMD1W9SR@^i`<U
C?Ie=P6piJ<4XbBARJo=iCg]XXM[WFdh]K=Ap34;7X:fb_QDKi;Q=K[kUF`S]0Kc
1i\eZTEc[:`Rl=0O@EMT3NQ6ViKqmV82RS1f7SbV7]RDZ<[<`DeKpH\J6[dIqo2M
cC<b9IWZToJGIRW^`9d33mZn6Mm8T`iU`=QR5cNHMiBJWm;67=hE\XPYDS`37C>;
]3b9a@7Be@013R\mHDf1fPSXBUO8R34iD3QUY\T[bM=X4Z>3OMf=IMPddlI<j44K
q^Wdh5V;p7jgA_j9`]fm<;bdK]YNGGO@2EFPGbmUi]M><LMf55:pM[7fc8\X8C^R
i\?]DEb=c5]1k2[6=lm\QPYYeCn<IaDb26g\NJ165TSLoob@RXmCKX7A[FSYV?p9
gXmjeYBTON[k5?e0ic10^\cUja>eV\FY\ofX@hdmRYFThplb[d2^@7I0HNGhco0N
I\`d6\8C`lgW>7Wk6Ap=Ho:OHTRBlK7h^F`NO@;bg>QWa8mD>OWqAdm2LCN?feII
C<OP7Wopl3;=NESq7\MlG]>JW8^hT0>KglK@J:\:=JdHIln61hBH3^PnCReXZ4C6
W;]noDiTA=Uo`KlB2k[\;<Tn6gc[CcDKkY^mpC9k[^^nPF<NR^d9=kRP3jT8Cq4M
9[\\:qFQS8W;PZJ_RRL`^idIn]TiFLM8:jSYoh@d]3Rff`q_e76LjkE=m0ZnFfBQ
mi9JRl`5jM_ni76FlK8[gBHlK`=FQ]nX8X^PkDlKif=F1=3k]T5<MIT9O0NG=C6>
Z3a]IMJ5[3M`F;JkIP3KF@9SUNFYQ]n5KNCI0mn;\O=pMJ9dc==qmYLoRLSpSX@Y
keqNG_XV2fGJYQRnB\ak@8oK2NKC`L5SAZGoY=g2noJA[7\Qi9U44T9ckO@H`<ei
mWphBOGMiZqG;FTdV:kO@3EPKSd3a\=I\QFA]Toq[R6F>_6F[n543bA3[^>YoAM@
2nL^f5YkqF>ha;:9pKb]?i\Q_aN\R@S0k?hFam@iBlEX]HY0f=dG_5NZN@V>Bn_j
<cGG>8N;@WLpMEWmmI]CPjeCRTE:qO5_c^Q4pG8M:lUUWjcI4g43cqcmZgi\7;H2
;IcndNN>\Dn[L3E?6KpFlZkV8IR\m]ce_hN@T`q8MecmTdaV1hhBfkdVRZF^HHnl
EZ`5P5Gf`Mqd30:1ka;hh5=U3oRIg4N^NW9jHVK3RnYjhl;bJLHKEjVH:8fWH`pL
Yl5<hDFqlHEjN:`h[L`D;fHXf][p1Mij>X@6iH`_o?o06h?^iNEh6CCHCl?YFTN]
5[c[O=qUlPmC367cH8HfXU?XM8]c:c=aR9W23I=[:D9VfmI@ipMS;OdTh@?9cJ?D
AVfB4hiUh8gUVS^kUaHCDN0Cebh]eacijhIJPqBPKPmJ;_C9jFJ8]E20K6OUYW\e
iab\DpadNQnCATpNbE1mC\<qVF9c:6MnKf`5ll^qeNJ5l9NQ?T?h1A1eDM9Zm6;n
8PYoWIo]]O6?I^3=V]WMd]pJTJK0VP1qCBM@8OR:6h5U;`AZ[Ng]0YqQAJVUH4pb
><<:aTdjlg=I4QapDaQPYf>K1ii@an;4kYq81a>KS316R6A762kc3WZqT>FY826q
aig1Dd?lclI1HI2UKRM>Mbm1`D1?HWH3OX;4H85=nSYp6`NBUl_KJS]S[\Be1R[<
DGMOq5U:9KZfqnM?F3=>jhe@1MC0ApFHYZ97GqSkCobY]OMEhbbK?f7A@W;P@SjF
8ZnXYLA^q29OHZNiFif4mBFL@02`qfY1PQ=^;eQ>:b>EZ_C8NA@dj2\bH@LV@pHO
]Y=Wdklb2lLXljTZGU\_WVB7D9gC:[_Ek_:R^TRhh_X3V0M4qbc6W]UHpm>^dY9\
FJWZn4[6LIA_pc93kYiA;ZdFMiVW@lA[c]fJ=Unq9nFfVK9q`k@CR6TqjmCF=W3A
OMV3NfB8^927kl<K4ajTX:fpQfOWQ;OeNLmESfma1fh?6MoXn^bYPP?CV@T59ALh
U`ZGDKS;RcD^g]S7[hNhManF\8c]UFdG@4I1mk3c`XB;P=6eA3dQ2o?;5_71lj94
JZ@pRR1T_H[qE6PCU9qcDjFd6@biH]pe;AXbi4?mFSo[=Ln;n51PM_mFg8T4LTT6
=LPBWMi3cncTlDL4l[l1Lb:VB?Z<6G:ef]FJF<ek0nf^J?C6nAYCJ7Y?QaWGVB<8
j0U3Dog3>U8XH:qD^4JegHpWcH9aB9pg3UP9=Q;li@L^VWADVbjieTKimp;c_B6c
FidAMhb<h4p:`2M96\p8?:<O[DqWno=<Q=;jd>og=5i4:OJ2FZVlJ`BBRFEp0VXK
ccKEaV2X@4U[cDMcn81Q6e9TFo_0VnkNP6@LZ0n8=KQd4<G=W9mEq9;1BmbO=ij1
GVmYHq2X_Zmj3p8=H@3FF6C]YY=I2`ZJoVo9A:4S6bmeQU2Bl_9lgF;<2?aiOG[>
Tm1efp_\16`@dZ4b?BDl[W[j8kNciM?`GhHI9>K0qQ>UNL1]I@iDTY:85Bc^pK8J
PEOc;DWLGTD]^eO>CWK`K]\21BgOIp0ge3g\8pbaTb;nP3;LD3\`PM9\1p>MPEZG
k@9RTl[Ib0fi@4TVg=gGpVE\X?DZqn67gSabqVo7Km9:X?OM\=1WXb0BBhXI?]L9
Zp35Ao:V]mS3^`G[@fK;7P<oLDTPF^>FM9Z>kF[1d_>QdBPE@_V\W8kHKgaIKNXA
VIE644nih7m^^12_f=:>K:LL_Ibo]E<4MUP=`88\:lHNAp7S]BaJBqG>aP7B6[8F
IbJB=5q=gQ<AOJ_ULon8:2mBFlSYWTdUnA7No[[Q6TeE5Yg21Pb8\ad0GVZDCQi=
N:WVKUe^L:lp4C[b[DXpmHI>bOM;hn8J^\Km2NMRgdoUKIdG^CG[@[qC0gLCnTqM
FCAI_W8J90mBOIgEV5mbclW1;X]YQWAZb`ZbK6hm^:qcoS2UX4CNQSM9O@BdEK<9
V@5H68@H9^5RNW\q03\S2`jRUm@`Z[ZOU0o`fEM@h?iMboaiG<[<^AS=q`f;l2QG
Uo\nal]G6;TkkV4KBaL;JHjInEgRdH]QdIcL5h4S^E12KU6X_SI2WMhcE`nP3`cC
[KLH9<dc5fUO1:oKJ?dRgCJHMOo;k2_m[aXF7AHdQ]hq@l5Eg`[pSa>^Lbli?M<B
b9j3BWq45Sg]`6a>5bZiKaDTL8^QB@AMRlkf1HiMfIcNn=g2dZQ\UfXK9c`GL`3n
oLqM0_jL>`pc\m:OMGoD?Nh6KF@7TXKbkVFgO71kU9cRep=\JFU@?R44S3E2CZif
fV=;\gI_9bDCIo:d^P5?V>lEM^9\h]];T[K@_fOLD]\J?H\[^L>cL^Be^3LcA^;7
HAO5f`[SoUgC_FG:hN8^[JQJq\jJl;VE94XnJ4]XGbQm<d:7QCNL4?ceJp`1jJCK
LKf?;agh00bo:Y0T`g`PeP`G0AKfc12Y19AfOjRWTnUkALSeOHnG[DXD^CS\9MX<
Mo5TaVS9NCK:oh6fHWTa_3GHE7A7W]@K989PWeDeJKCTCAeBYCD9oQ9LB@G?Bp3T
WD8`:$
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
[d;>_SQH5DT^<>lKOQcOg9Eq;ET`oiWTW?__B:d1;`[KRmhYmM491n\UmRqYR18c
]V2NgKKEo<Ge9bBed4h3H?9e4GA7<Yg;VDL9m@j<YZUUVO^bB@>]J8Up;VghCPq]
C[V=hK2M4@fB>mDW[]DX1Uk=g^5GC=b9N<C6Fe4HnTWp1BA5h:nqUU5=WN=Hb>k2
Fla<IMg]H56=@X1Q9W?Y@^9Eq0mA_V^fp9DoS1b9EX62?n]i:UIMemKPEaX7AJZp
FnjB;Oh@MDOE6F\mQZl`m`_FaH`8F<Uf[5QC>F_[ImDlBV_oM6Zq`9O^g:A;1e=P
KYUeibJ?V90N:DNG]:5PVWU;4C^BoP`2YHYY_UHhKKn2EPcZPfmo0d[HPk6FMNBj
h<gkpLT:?UCU`b\GISVkXXm7k:2f=IHNB\ci2CHFF_W?fELa7pQUT]5@FGU@W]V@
Q3U2Iaj9eP8eFcV\lp>A:mW75@@Gi_aIfAk^1A=1^VL?p>H@Z2K1qe=23b\7qUGf
QSjjXljDaoS_O>2YJkd\dV\M1B=H<p3:?]TYT3HeTf^Ho58al:>c0D`]EVUE<LoN
T49Q1iMfYUUlPZ^Ao^`>qVB=8B<HKD2\nj4S?H=K9G>UdaQIknPKq]6J:]H>pdTD
K^b`]hU3RQK3lNOk>Q8L=97FfV99Gb=M5oSp@o5?3`[qZL7G\YJDS00?2eKKhF:2
i>SI\JX:d10bI7f1Gee5;_AapmDC^S8jBWKCf]NUZcK2JPa7Khc5d;0p0XSTFEFV
ZYbPS1B2FK6O?=ZnfjdHNcWi<jn81jEke49L:cT_N2lIVkZ`OJ4XW3Cc>2DEaNiA
KTVKcmhKpFo[1@eGim<R3V@cNV<j_j4Yh=4]:qK4dKl]Sc88E_m9I``oH>57nll3
IHJff?Wo4H4V[;8L;j]Gp]2PmYF<`I21d;N9FOc6BI6F5HKR_E_k5pYQ4jHCjpd?
@L4BX2_mp8G\aBa`[:9Mm^`VXJ3nlb5`a87n@^\:XhXif^O3d_XE=qYD<[=bQ^H`
=ndNTDL0KCIfIL?FB8_[`q?FGfGU0ULj2?553KYcCHBG:J4>5:b^cdfdG>aUS9XF
o3\]OcqoEmNm`Ap7eI00DZpFkaWA0bq2biZ2dCZ>QgnA^D0@=h5C9[Of;Mj1=UU3
_qkl=]^SHcWaeM`XEcg8L^qf674YgG86Z1SZYh5lEHR7B>no;qa0RjcV=pGVY0_g
7C7NI0^ME\h7VAim]9>\edWk1gm>^pAAMk^aQ;HVOTOeHgAo3IJ]X_UAmYkaF<Fb
BPcChfEeD\jSRPiL9gWX7pT=J^ldl;?F0R@bSeATDnOh?A6kQOjg<fA@<^5WX1h@
;Z:i7g@XS;hkgQbTq8L:QcM6dVccff@l_?ie4]D7gnOTHNl4d3k@BYMi;]>V?_0X
4ZZSCDIdVX0d:lI=koZ>n[8FaCW80RSYJTJBpW3EM1`KpMY82[elTH_7YKC?=O`f
NAo;d<<gTbbZ[fnK>HA0Lc=RaSij_Sm\kF7o[E^;iMoA75IEpR3BVO[Mgnk1b8\?
`K5]5gWgBLAq\1c29hanZ34e8XD4n]^=FR7V;Uen`Nn0ECL`@Z:hRMq8be347:kU
^g3eT2iR87P978^2\ZfIYOm61nZ_T?DB3p2`YacL;T81HU3jCDC41E=7V5^D\kQW
Q[KobqDPR[kRqO6Y?41NBOEj^E^Q6@W0_me;EhgDZQZMGL7qTIL5G^NQ\lW?=Om5
Wf^clhjP\HnH1B\l9e3WF5K@nHQ`qk:?i;G@q1O]VTf<mIM@RD@6VVcKiWiK;LM0
gc:[Lj[Gqe1S:22lpf@X5LmMoG@foToGbjG4m54Zcdia]0QRPK0>]<[=UXXfdE38
=59M01gmB8B<QZQ1\^^kFS[27_EWmoio[P5o_l8@m>:R2=HRo[RX6>BaPWU;gq48
AD`CqJ]KNTCPp3YXfjPQ^;8b=3=W8pVBa[eLODGjQm]DpX?LfbM4KBJGFCLa6\4l
oRJO4V=C\LnmpF3GZFohh]d`XF=<Z:YU9bJ;\]CImXMAAi9p3l1KVkhbnj7;PHkH
`h5P3R6:32Rp1QYfIICG`W@ghmlfo6kHZEcMaDc[H38Hp`YMlNj6pO8b:VPS1V@@
b5fNYHH9R<_<Y;SJ;bJDC8@[8>f\\R`AM;3WqWPS\Vd[p>Xl:^dK2J:>91gLbDDY
Oomn:5d<Qn\cPT0Rj7FMKCXdbp6JiS4^dqh1YVK0mSd8O_Q74aUT@?mGPd;QV_PE
UaoHIapH]?OV33qJ07R1O7bilS?MWK?5>PKhMl5>Q?2cXF2p=`N8T8a3dgj<jMg;
EPFmB7\W_EeZedUPQ:iUeO9Y^l?R\SVR_e1jS4QfR5RQ\JbW6oahRJ]XLP1V`c83
qJMj9H;mE4KdbEn7TP_3oLRJfOgaSBG18;7BUn6;nXlc4U\52d=OacD2i`f[fN@p
T47Il3IpH`D8S2IB9l3HY9XCF1[`h\bdqbeXRo9kqTXOeR1e__;<7hD4\<HBcm6L
k>4QWc3@h2dNQ<A4p8mkJ:?Zq]`JSC<1@@cNGPWXX6:hqeaJ^^XqbHgXa4jIcG1=
bV83?@>L0le8]U=M7cV2Ln9dMO76PR9JMQYGl[WLE3IbFR=c1l\53o5>Y^;IJRGb
oBK0qGn[2IX_pD;mUVa:CJ\KdioS;25AoaWd\WDp7LK:;BN87S?PX=CBlCaL5V8]
me_2j01oeDYZCH]]0o7P8bWGqiU\=8Oa@pQ6EW<<BLhT0PDDKnXU5h6QbU`^RLRY
dR89p<RlMQV5Bm:Pna4\>cjoE\4cl8K?T15XXh1C;H?B4fAK[[9^^@;DEQ[j]Vch
I[cmpDROfkKYip8kVeL8=DGdiDUoBTTj141Q:=D9pKmON7\^pDNRIg]7I@jbAMl@
O>W3=NnA<3X;5m`TnCKK:fSEZbck1DOOdY8j2l@]P2T`IJTF<f8Pqaa^o4D6p[2:
JdYZYiBUZ?Ccbqn=mQAVh$
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
Q2SlISQV5DT^<Q4aMlP3FKeha3?8XL0KB^O`WCPe5RUVK2F\We<f4nMHpK72SEga
7`aQ12laf6oPEO=TR8eEMjh8Y1J;NOI6N>T_9j9me9cmGV4CV[2ph2Q?DSGWEb<:
3hJ[;1_Q<X4EH`n65VF`[nA[OHSNJ6l_n:L9@8qWhgl``qNWGKID5DMoRD^Lbl]V
jq7631nOf>8U<RfUT\_BqJoIGl7_a]eMSW;oK];G73V\Wq0FFcABU88a3VDSLle0
ch>ZpbDU81OLQn^D39:n]\K6EU>Zkq`:P_Yn<pg_WiX^ddoPRqmMT;oS15hDKb8H
YkqF^_<>lSpKMl=R0=qi_8>IE`qRU1g2Q8p;3Ei^ChZ9fFKJk03>0Sp^^PB_DmTI
`>a<E>a`W5bqmG_^doFW3VAg5^C`:o]_f=`\_9Emd<RMg@9djYl:NQ1Kj?@TdbMM
aXpJQF3c[^`N`]40F9[>_[a\UVh:PI<7g0VcD:gg8=\@YN\4^`VSo23FLj1AK3q8
CkEm;o`iJp<QV7B2?9`3ib_?oGH=6KbJ_;KJ?mFEX;[Z[K^ZUO70DHUFBe8mhcmb
43aNWj40jBTWd?>nBE8MF3i0GUKa>01S_GGH\RHXqMkDBmKMp:6V1YDopLZ9;>Hk
lYg4:=TWff>KTqK04<L07@Lb@Ph1FLb9b9^<O^]c^0FS_ja_EA[@[Va4>;M:K;PW
4Z3XO\md8UP9g2a03UW>qnI\0W:gW;UG=HZF<:CSLZ1X8\OHlZOkHBap6o;fTDZ2
imGcHPF7k?S?Te_IG9_^\jMQ039P:AqT7gL=F[q`Ug^1Zl64JP__^@7\mY;k>Vf\
gpUjklN8<D:_oA6\n\4GW\;a<kU2VQWKLb1YO[N9H86bgZfGZi^DYH;5_Th;^jIo
haBGM3gGB0DWLY=XkHWYe4pEBk1Fhdb\`2ZT\9b<So0pGQ=GD`fqDY^T3i\aEg5B
[3a7XZHJ=;V5W0;00oFFBR4>fN@pf<`POH_JOL?=TMfP2cieY\>_V;fBCBgpV?<5
2:9qg631;FVqmkCQf1Tik1pDF@OVV8PbVW\]=>ZP06L=]Ha?ZPpK02k;8EaZ:NAV
BmWDEE]8L2gD4lXg@UkYkPRCECmbC9_bAIYhnA=C05bWFmS11=X?<Xa0o:3U^247
HWU^m5O6D2n`KSIYhp1_?:T>apTI;8Nh8pA3^ho:2qBGLX5BSS=;MI^@9IY9C1ed
TqL<:V4Tg6edSI?72;B0K:;?=;MCM473_i[Ao80@=Ljb_m@VkI8`W@BHN\b`Gif>
05fnDmh>jMEdk9?@d^_9FdlWUoT^6V_;J:NDD>H_mIPJ@k6hq\:;_h;1p02ilEJJ
6=2ZNek<NZNScoSWLDc@JnedQo]pRc_H8HZE_Me`cXYe:Gm_KN[m][Ajc?`1GWR6
75d5_SfL?NhZ=jfaMkbXe0U8q;M96nc0qo2^Q^Wc5_RfC6XgfY0<<jhi7Pb`_Y5b
SO9]b;P5N>Ai50=LmSL`bK?bY@L7<\hV7kUf73jG5_L\7\>qI3]JoAIpJ8cb^2:6
o@6VLdd5Ggf2\dVY^7cNKl7dZHfDU@pb=__]D1q9F]jZaMpl8JhdJKA0NfF4OK2U
L35UX;M39^]VW__pUf2Im^3qP?RU4124ihbJP;cHL26fk;K`e0ge11Ci@LFl4f5U
J`G1baHbGcb36>[V;C`ma<[WYRE^h0dFFA1Bj;[N6;m31Rqm[\7M5RqPZmSOY]D_
:ie3mUh3^@TF^oBIWGL52ORl65qNfSU@QWqNd57TO>pH9T1Q?BmW^cl7o8SUmDQg
HqLc4NJBQ1cb32T5UCmK2@g<]WGi]Lpk4OPEEZpee^>JM7cic9jbk_K>lp9iUD;n
magna4\3C\cT?5PI_jW20To5bMgP_qUKUVb4J7`3njBlO^gjjdgIB[VNH5SiDl[O
iT9_B[k[mdFOSBV_Hc9=A@P7q5Sa=kTjL@Zn_SQTEb8f0@M1bm]LNZYSImZ2OI]\
Pi5nokT0IkU<N__P<`c;^0@M^BNk;Y920oXSpk6M6F<9UJ9FcBkfjC6bST6HVh@V
jM=TFqA_Z5ChIc>AefF[iThRB`cLfLXgl^`lp=gD:9kWqeJ?IIeP9BC^F5b3Gpnd
R`B_RqkYlWU:Wh3f05lP[XPCEh77Z_N^YL3JFjRW9qdNRJDU9oe1MQ1Z7YSb8BDI
XDEeeXp\;=PP2ef3R9S[_:XV2Q`Ql89HP44iGEF0bNJGZdAjl7TkZ6FC]5odA3E@
7IV`ilF\ePMaMOM5[==Q[d^KTWlDod8fG]gY]qL\bYcBQ;mL5J301M\7]cGhOUZG
8M[fI:ac2o66:b_A7;NehX1UXo_NhI?7WeFTB96=IO4=1ci[i^bnHD5>pPPH<cim
5Q8C8GO2DD0456P=0>^c7AXjN2cJZC:cDV9UNZblA`c7EPEah1KM^EDCX=WqHO:2
=mUb0mS6FZ[9MA[=^0Jg2GjP5OC]81=qe_JCnX^RSLIXK:FRi=dCa8iF3KfgPDqH
ZaKl[MoX:PcLg:WM6H:2BTZ0BeB6Dqg4cW\UXqb^>\@6N0Bb:hX;ZkcMpE^l<h[\
pl6\i54H@E=hjO`YV1I0Knn1>]T@d=P7NnBZpeemoAoOk^\94K1kB]Loc?=IQmfR
2R:XPgA4hjcZ5c_hR?^:^4LWWd9ZZFMJLE]N^^fm6dgHT<50qFSicdb63KD:Bf>Q
M_SIX_H1LN7n8fHTf1lUe4`^7j2UH0lUeOg:3f3B]M1pm0TmiTo63d>n04EJ?T6=
`Ki9@Dm^aUQP6LC5jiSi72;KOW^mn;5InOT:<3RWP:^nClN1@VmFiHgV49nbi=Ln
UTeq11B8a4PUPhUDUVO4V6N;q[X7a@ImVL4kCUI5OF?6NfNVa<1S\H27qZOVLMa9
qMj\kZ[_\IUA3aa;MFIm:GO05HQd>a7Pj;WfpWkTHm4Ka<c_:7Y3c3b1\f?QD:SP
@E1;hWIhA_`T_AJ9R@FOm\>9Gj\<@0RU\0`qB4NfL[Uq8PJH:o6_TJmjkX8dH0nP
]W?MGO38IVJmgK[pElH5E]QO39A5H?419m=BS2=ZeS15c?lA8gPL_0IZI3QVRLik
hh7[i4qSRjAH;@E^mSK9Fk>LZ21E31imbLQ3Nf7^:N_c2cGK\ZobN;gSBiO8\O:Y
lSEGETT9__[h[H3;GTP0d6qCXb9nE=FnKXPm8cn5cLD?7V[5TR;]8:eMIfI^SBfO
V[o?clIeiD2UZCP=eLIWhcU_Zm2<OXM7jT3nIGVk3[pWB2B?k?MiU:Bb;j^pL3Tc
NFP3M_XG91IWJP[E=Xl9fiJ:2<[qA21oDLh]gYf0hBHjIX3`:iEofLXmR9Nq6j@E
0<KRAA[G@f33M3U4@]9QV7G6Y7g`c3Qm]Re=anUP\E08PNWL21I@XcJ\b<j@q=UR
4?\gpe53[jUoQHch0US;aj\QIMS=gMPh1]2HgOIUqEJhd2SJqP4el6ECfe@\kSbU
VX9=n2[FcMgPHXJ_P4T:q@h6fLg]20OREQC6RM6GR6YV2M=daS1GI4?^gEA>S3Z7
Ifk?9XKc9n1qAPNM6BmZY=9H=_2P7V2j`afgbYXSg:FQ`hT5dUoBjRTdc:kN1NJ<
<:;gFVRAWJT4KZ`;]H=[5S7bV42pJ>>I2Y^P@Kg[ReZPc^XClA0H:Z]doh>di>XO
LRRH_E>N_nnN]5@`g\JP\4pGGELgXoh[jenZTGc`M2KQ]`N[^6cGLlO9eRd_eS7n
hNRkVQAf^QKV2S>]k?aMK4neP`W1JK9RdF00T3<@DAp@=<d:[6bC^5`e5oPp40:b
TSD77J=Ej\DW67UJ4QQMMl6]K0Xqk?9fWW2TZBcBTOlCkA90RaVide?JDa^pfQPD
Jj7q0eB2Yg^j[J`E3EZGA3YFbFnLYQbn=IV1paTf^<EgpdF4iiV?enZ;aVPFT=N`
2DLD3aU5W:]6<V`ZqD6Zh:8d8L3ZKE\`?;:m?7Vg8m<OSKn1]Kb0RZ>=qd\E_K@j
k0J`=WY197Eq8`CadNn1MKEh@HMmeQNcRh]OfgKXQGTgRC<HZdE2IBhni2PZmF0E
6_aUd[jMFU;59g0Tq]56WC6PdZGWSB@K`[WdXiOcoK2_ZiUmPU8DOOb9\X1D\L]>
66gMgCk2>eJaigBoeoK3BJIlj9`5KNcOL<GRSiB=0b1de0hQiY<fq\K]]bSNT3;o
RLRXBXEJ0Gc8iIO@;lXYf5icF3ZHA@Ba^F:H0RZbNbm:omS^^Rd<LlICdEW`E]R5
P[i5^HmpD4VC[0nWSCg>`_S@kQHCm^^BcKK4`YpY_I7Tm2p:_KjXOd_6OUb\74QT
9Vk8kUeaU4PMXj4qC[=VWcXhLjdM?J_UGoC63\i5fm?oYH7cJZQBN<4=G^2C:`Ch
XXjWdj[n=m0W9feJIAP?qF1\k=>ap@aGgKLHU=4o`AAS=1JVKA?7a\>D?:mEN^0a
q99bbk?`MI>[TE=S;_hW<68jZl5IMlSI6Yia:o4BNaINi0Wn9kk\TkmpgRA9j9eo
K8laSb99@aGSmZ44l_JV^^CL?RkA_^nO4Q?JdDM1inJ8Y41aaAE>BLO0@]Fiob4k
;UOF9VGq@6Q?V79SgVA=T[bLEH86h02XI6i23DQo@JIh3gj5n2m2\J5MR]>GJfb8
BIIS:7Z^QH1@7GG_B;Yamd=_Kap\KZ4FjgCWi624a4q7Od?I1@D8Y0U>a]eCl0>o
R5bo1hgGnp?bdZf_mq`lKbfjSaa^S=8:WUR<fU]@Z]mnKPp\8<W3b`WUM47FUg_G
Z8:42\HWm2U]bVMK<;6pQiKjIY[NB_WVgISPZV@LLmK4W5jh=2p9R]?G@9pCC;R4
IYROV?@M?[]pCH0nDGbpa0M\G>LL==1:H6l<IB92O`f@VTIqF]175\bp?@`SHL\6
[O]>4Z\b94fF<XHfb]>:BmP;?\hq1:KNIioCAGSm`RL>conCTMA?PS@SI8aBdRA:
:CH\Qg8i0GU_kDl7=N4F]@pijQJ:N9T;G2\NJiFbTbM20p7QOZM8_Mbga3l^=_mT
A1WdVTT@6FOLSoFfMSbH5lQ6mUAFbn:H5A>6?kDG]kl3a1`03aL=B_6ZEl4loKZb
p5B7?W]fq2`YU0bj17fcT?@NdG?K^ETm<6I3gOBq6N4h:L<p?0Vdod:EjI[1dT15
ZQ5hBZO5YNU]DUbGYeLUFF1Sl>NmG9Dgj42Q0c21DK=R2cqS_nI=ZQ7X[YWBL57c
YSp\APl:`K^IK?5gZIIZ:5bVjcBho2^2JQ4=X;pahbZhHED^TKR2aIga?_83<XUX
U@qaUOoj6UNLU5Zg5d\>>_cjPAiaLmTSXhb5E>aGaF_HI7S25HF?k:Mia<Rc`9>q
j[WQ2m?j^jbZV4`o1I`8E65<>h7gXPZkdNRd9[m4a8UBWl<1J\D8Q]2c0BVfYaM;
2on?1^Xa8j=Q=ep5?6jSbRHW2Vcnl5NFck^o;6YA`G>j@K?]iLB1^Thlc0OcUg=h
mM?]hmWG^GcaJ;DVjY^DCTD;<4IFH84[24OChk:]LBjqD[l4FE;A2118SMQh8J\D
7MaB5OZY6NbMD;5mD`fb?M0MYY<>M1DXqOeimaUDpnh>_4cC0N]_Lm9JLI4=b<gB
F`VchK3cX@2cj]:ZhJgbBm35l[Y7VG3:;f6N0A[IEkiaTP3pcI^n:6q1\GSHApdG
37YYSpEG_fQ_`HS?8DY5YcX[5\Tn[cD^>\pNN7C3M_b5FcP8=qR1V2<h89KK^jD?
RO4TPTonY7p_C34SJ2o`F^6fWlcTULoJiZRm:qQ=o=WZHq5DWFEMebKk6j9hTeUD
didfo9<[AS8Km<QU0eehY==V1\l]ONVbV?SaYqMaV]OB8pIZjEef5d4;aMl<L`\`
onC?T>NQVJ=In4f3NJL0;nlGDmqkU8iG@M2DNmQ:31nje>C]CFG6ek5p_cK<44Pq
:U>gXiKq[KA6<05W1XlLa3O=G@GjRhc6Jk6^<U5h1\W8fIT[WaqjEah5?Nq8MQJ`
Xbp87[;NGB8eZJ3BJ1bOW2j_fnYCOeo1]Qq4Mc31?G2bCDJWUC<AM?JP5=cbJIqH
;`O3R`n\dMH]XVYfW`CZTRMl]`TRQ;6q`bb`aLe[:NdYW]9dXCHJ=;M02K3^>Xpc
]WBbVoBQKX6<bLT;FglUN_Yg=Tjei?;BKlVXSf0XZYlWKn1YI1nlR\PbQ9B1`\@Z
dl7BLRCcmq_5\2_aDp1DlPJDmTaNdO2heiCJ:alnOT3Hm0Z^H4f]k4EEJQg=_9<I
[C:HhpHLn6h2^p2]FN3B9p[YjCLf@]RXI>1h^gRAH`I4q\:5>A;Q=H@iLe?P:7mj
TpdGWMXFKP``:2?lQI4SK<XF5K^ZakhaDfhSm:WMgKA`OnXbpj4kQ6\0pjJ3^@Y1
:ZU]gh1@bAAG6eUO?613m@bo=Q5<F@UZkkC46R;CFEj?bo[3BN[@oYG3>^WoCTG;
:cC6AjZib55mS6PSL57^]N:E7o_R`LdW4^4fCp0=XlhY:CNK;ahBCD_bQboEbDdA
j90EOO6l>mbae_5OkYP318C6<;P<0hdbDEK2p>7YfV==kUMJB`]Zi60>q9Bd:VOW
p:WA8MGCQ@1UX>EJhV>lQ_IoMWjemLM=bpmgWaVHZ=[JbmLJX_H1Q<R3Oa0JJhYE
<36fnhY4hh1a;k_Ce[eZcL475XN=N\O@;]R9boGC_Cq>42@:_mpg<P^e`fpENo5S
S:U2?>j>KD]<VPGCX3;Lf]f:g8m2H>]>alo<J1?HFTn\]bhbIb6W\JZ9e@05jg^J
`H4@dUU4]>ebmq7;K]:4nDl00YViO4EDaDo`Fp_NXF^><\L]>IeiEQJgcqJ2oe>I
=p@?P<\Sh1lIYVP8g<]7B=HRYVc<NLEWqk716m][q1JeMF?QkiCkRl<YVpF6[BWD
iqM[7mKJhkghKVXea`kg61M6c6\^PopQj`1iYfUES=ZZX4kS_UQqGWT7I3:Pi55l
nPnBhmap76?KbiWSf`:^SVX:[i?74RGBK^DCTGGD2F7HEMMbl4X<2_e_i6;B0H`]
F^pIR][R:JJgD^cbSI4g3GcqD\C9kO:GMIh=@]<eIfOS>[HaTSRG?WIXa=30[T:4
OA8D3WX;pEb2ddg<qaTZ@bKG^H<en<]m@<Wl=qPi3^d9k<R7ZCc^fbhlEqHG_dH[
b4e;JQQAQDL3B7qhb_mBZM30HmX@4IYbV1C:U8BP998C[BE[E<M]ATAGL@?D=U@q
3_[XU1N2PM?1eXHd;Bff1jEMQ:Ode=GqCU9CEcTpn3:0Z3[liUKBJZXPhiO9q_Rb
5[dT1Ln_REZdbX^NqdQG4I^Tgdn@WQZA6E?TBpQ5olN[UF8[8LmR]g:KI2b0\Zg>
[3e6bhbYQM^Id=37k\cJeZqcCdlTZ24MOB8WTNcaTT4U\`p_FNlIF\qBajI^3iK`
F<<ee`YPUlOqGmRZmCcW>g_eIK]HW>@p2CZ?\>HokiiU]]l5b6gCplNWlUnTGFYG
2LbYDm^EDH016e3TLl^DY6nPDclWd;a]X`PSkqEdSdoeCqcNE`4LT_05UA>L1[6G
d<q\8jN?[8`87F4BdGXWZGL9laADZM8qo^2HdIb`OH33834kULlMBd6oZ]EBF9B;
AW>0YH:X`YWEhGcPAT_XXMmO3\aA06TgP^=qCY:In2nJ;]R7j[Ra==lLW\\=N6V>
_Iq1j5TJd?>\]=5F:n3=_9>c08IV_<9j0d0fCj^;a:fN]^cM4;o1RCePI92_2`k=
I_Dleq\JH24XPpKYgmH21_XWTca3:ZYojH[04ncTHd9686\3hbQCJE8P57L6bfm_
?j:Z5RdkKGeSTIV^pbS61o>b$
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

//`protected
8KO9JSQd5DT^<iAl0RG<:7dPB5OV5=pd16U31IMS8OPA:Dl4_[\BbFBgK0eGF1Ik
;m:?CqL8bA><<gF?[DUNXIAS4d537`Wo;aXVR:fhUXYIa=A6Q32d?\?LYSiXOmZJ
M87G>6;mdpYl4Sh=pWYkiB=E:ak:A`^m@\7>Ip>Tnc47JU6dXGEZWf`S5Xo^>bp[
S2XJRhQGn_`BYJ_R4[5q\5k@\`d@W:I:Dg5NgPJKDd7L2272_@K3E7qkOo8RJl`I
DKk`MN;BJ^J13Y<KKET`iP>dZiUVW1S1C9jN1]>a<eS0A`Qp^jfj]i3qZFTQ>`Qh
Hik>fbmnn3O9j3nB;JUR73IAhL:8h^N1Q1XSBVLW^h_>n`BbZ32f=P2;j9V`;1@`
_FT_p@f:SV]<hE1TJaM3I]7WJ\QV=KobWi3<J5LgCUSJkfSGe=1KnQUmB7@K6[_?
eY:_1]9l<Q9_gphONB?;@P?;;=N3I`bTll1G]q[:276o<q\]NZ;63Fi_nQ]OJZ5>
3EmPQHG^QHGh6p_@gj[cPTE46_Yc:mEc:?4BT@cg>aBbla2bDoH\TX<ZPQlAQf^8
bMhE;U3U`M^7]2H2F6XE`qjH`RTSKEU:6Sn`J@@f3AR4bThSd=bEBCl65`RW>gf^
AqbE1TCTg]ZN4HnZ1@816KQ]E6l5iP=QK8_ZLgp<gfYKVq6C_o@HPU>RUAPKQM]]
B@8b@b0Zm0gN0\Uf2CLW9kX6h]P1bB\7QdQjF1`oR6B\ANBOC9>jS>c6XKY^\F]c
=G<GhqCdZBTj_R6JnK3R^kEc>^n69K3>R_oOSiZ8_KXTTl2nVI:3FMSNJ5@9egG;
8Pbg_KZG]HPRWSD[hR`MBjG3WqGIjOgWUk`eJf:dB>`]KKBb\h78TdFY9FHnjfRc
HS5mTe1cb95S2VMCVag5`5_GNWcBdn13Vc^?SfKQKGW?9qYURnaA@T\]o6gbY8a0
WkBY4m7jT_H0HH=\4bookBQ03MlPJmQY3Ji<dB_B7G_4m`Y00G<kXPH1Ln[dhc4G
p>2c9J`fpmD[KBQNKQ3]7DcAn28LmBai<n7<n`DHO=`paSllCnI:6DUKkgBf_gA0
2OYRfIWZ9Z>PHHI>lVJY6EjJi3<Sd5hkIg_OZ@n>G9n[`U:S8oW4Xm7pQ<HFH>@X
G7;VlC9M[6W\=KfpKUXMD\EpcWLE\DpQZCF<CXfQBmOVZkPAdHOe]AkX9lX[?k8X
M6<`nk659T4cPJD?<I9cGo22I86QTUaQnCB8DXAA0\;\HNJ4<=Ko0SepTGcI55P[
fOBW87O6mMO7T]>FG2Rf=K=;O5f9<6m?n>4<WL3gE7>ne`jiE;5\?b^AT<cXC]Kh
M3f@bB5k`gT3p90diQi5B<=`TI^=OQG:nU5FkElA=aJLWpQ^EdWEh`k]\gZW1>k5
8QjI>30olkHa_bXJ_e8:LR6JYG^<F5H95l4IB:M\B=aQf[Q?EHQMXAeCSafhC0dT
TnqCa[:aFIde5B8=cdDYiR^kle4KXeMeHnP[g2lHlf1nLPS5N;Bl[T[T_JdNh3jT
LgV]4J?DAF^@:5X7R3Vn@3p;Qc2cc4p6We0WJ4o_ZAOMMIOC75LA0n\c`m@[m94V
5T34jnLNYcS1jjRA3DNVjDcjM@hEk0On_3Z:GS1N1Oq[b@QnD^[N4?^j9=TGV3mR
1KpM6\`U4Tq3U?]lkiNMTZZoOWf?El:oR39`RlHFU^;3_P^6b`iqQ4PZhhhBMAVM
f1^LB=7DF^pRBX=i2Lp49a?gc5D^QdFoo^76Ba?JIolSORea[\G:icZ6<2QDE39F
Xk>2iD_@Z3jB[bl\2n54b9OVflm?27Hj^eik?Ab6aR=L=Wb<7TX0OLlN9Bi_`XUB
e:ME1p[Z3o]aRqZ_V:`bCqKP5fMh5qHGJP\AV85MHa=n7CFVi?Y6ZM@FWAalgDB0
n=Zo@Nqe=8Q]W69P`I@_EFg=PoZdU\Cl_lhoZn=Z4leMi`Y@d10;XFO[GM^WPBl_
J6kN=U<5VR<gR[O5Jm:;XhZq6o^aoh?3>W[\7bapIL5LISnqOHK[n6pL:1TT<hV]
jLC42Om`R3Fpa?e2TX8DZ<?Y6W^YPT741:Y:XY`LcgJ_>H>AWhYWF[Wp]PbkkcMo
9k56dAHRH[kM;faDL5DScdmj`[_9G69GA1IqF0cXTMccJ=PSWX1?MRH1NlBBfRG4
FOhmh14=W8mcW71qb9Zgaa6B0kG\oKlC4O4R9ij8gmG0>dEo0RL2DDM>Xm7p6kIV
_E^p?Z73`7RLlSg7mDPZh853R5664e6YT?C@BHc`IV:QKX00n=nnG486>9Z:EJpA
eF^\=k[UZBB3bl]c@9bD_nelG_FLZlj7a6X]F2`Ne=I0InFK\2?j:2ZNCaep>bGE
BeQqSb3IZ=q^kaaO7KGMUGmn0dUN_0MpHGgRe_4]N<Fn\imGUSDk`[eH<2O;caEb
J^;NRWf?<h@qXcVci@S?G^hafCC;?1`FREdQVQniZnc@K2hL^JgYI<7pn[=D4TiW
JPc_Z=D5agJR5BcRcm0]D`YDHGHOnBi[WQ`p3JToad8NK0PaoQ4D2JK8TEbP5KWB
Y@5T@>^Mn=coLc=qiFFY3D_E[>RLLOm931j8dV37H6qA7Q_95hpINKF1KT:84FbA
DYOM[6`[X8g\B?Y9`clp3K=7fQBp@=M_N1Xc5S?QBIc3SdqJR7k;<33Te<VaDb9k
60gBWP\qO^kmiH[XF4TF?Y@FP9V;pU?W^R3^Gd:1G>XAI8o;KJ2jKU<BTW5l=;]:
fJie3IC><7<N0q5cUL\RXK=1P^EXFPkC@lAPcY[Seb>K_7bnqikcTnhCRc;A^ET8
e_b9OcHeH<H^9aYcI9lCi4FI9JWb11KXAGk\jIaQTqE5jE_BmpHET3oZe>B5o?@O
bVlCiThWgWGH58nOo`UOa9?INLB??nX5>cf;D=I88H]f3=X86]=deCqJ5W;fL^LP
9gCXd^WaOg2Ej9lNmf9U9Ec8XcBmg<^RQH6:HP<G[l93?TB>iLOl9[<o7<Lhe3h8
V_lq>4\l8<KNI]1F[f5@dbgNGMVZp>KJScl5p8M[A5nECJ<hKkPJW0K`2q1_n5mK
L?XL3T@;U\XF6nq4Wg6X;f5F2ZaGNcJ;8N^;1GZ5XZZ9R>ni4OY6K:_\jBBdlDRY
8eDcP??d?nHiF7CNU2SAMC>p8SbQaL6_qa8>2[:Bo`IfIa9\T?bCLqUla`=AF[@Q
=EgdeoCh[Fg3nD5VlE1eLSaigbD?W<HjMG`h5=Z03]ImcE92RWh_hDP8p<JF@5>Q
:piQ5egR9Bl?9EiMA954BOS6\FW:WaPLXDbW^9VDkS_MUj24iO;D9WH`SpA\I\Ak
SQ?E;fcV^BBSGK?ZA>HR?q?:Z[_oNdkY06F]H=VK@^gmCMa9YUZ_1XNVnWHQWmCD
>::2QM3NAbG1_mmK5oLS_AJlq;XYV0RC]qh231A\J`6H2GV73hCbKI^k5J6iS46`
F`49A\1Gq3j7mWnQcpSkLfOE6ip`[HXm720Y<AnTHe>eMI?SXTddo7qP4Zco`?hp
LE6g?<CKWcTDE@AKCbcaYFe8HHVN5AUpiFSfFo1XaE`2::6lTg;?>@W=d5>D0Rm0
SjHT[:PVbD=ql6ViSS\;4B2C^oEE^6m;1KlC4ObRJB1bFO@@pZY@ld4p81WCXfCJ
ND;UL;]KEJZ<Dl[V_bYnBmRg7LX46NUEiD0E_>U^pjoZjbe;56\jG]E>Fko^E6K[
TdIa=gQFajdiAVF:Fl55^>2C`P7j7Bjld?KWdCc_cm@TRf03H:9Bia^IB`aQ:;3B
fCYqA<BBL@Sc5B7>J^FfU:85S>hlVg\EMI=R9jP34G0eQlHCa]47ARN6gND5AneP
^m^R7[WkYFIaaf8=LQl>n7hb7[pUe;aifN`V8:ca@7AhIcm>``aZf@\1CiijHEWa
;Me^O26^iYcfSCCOM99n>7BSQ5i>^\]F03iS^OELM^m9E5dcbqc3KoNOQgcO_Vj6
o\;jceBc7bheYRm1eRmMVmPCGi[lQQ:K4PRR>>Djf>:ZZ72F?7c5PEAYYRNYRgdf
D9ES;1qKkXG;DJqRj5??<oP\PC3Bgfh1=kOQ29g5>^nH1k<]3lI2mm=O7Jf692di
F\_ZCL:5YRgeJQi8DX\^4TnJQhRpY_:e:RP:4SW[]3=AmKc?hBbOq7nXhOFZmWTn
52aUGeIn;C>6iI2?51SN0jOXTc7X1CJ25H0KC4nZBX3PlE;WFA<jF>912pHLO^[6
TqghLih7baWHjPBkjZk@;kChc^7L]PK@TeoGYk_BFVA7ED$
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
>cecWSQH5DT^<beamUQWCUYQdioK:?dhl2B>82j:JV6lAbU\RF?3a31hRbMB7ZFa
pFgQXkgk5kEmR_gc:q?o>9DQ6AMJECOCdakMRbkNRllRZ>jN?l[`OF=N0\hF;8DU
CAm21KpiUOQS4qDd<_3mEBNH`^JUWb^9iU@GIBi@ipP\d\\:np\cU]eaC5E=SA<S
ejJACoaFLMeQpV_H:gVa[8Xg4G0JY[1\^>F0ZN:9Rp\dSIQ\K4P2UGGHkAAl`eQc
]h]Zo_P^qL`QY7g?q1]7HhYOfDIf]EIh[j2`DPGaCY^ol46pUZbB46np@<_GU>c9
FDaY^<ScGik5\JHXWl8pbYE`Z[EX?oI[VQVN[Se\\9qm<eDV>keHnf?[_aII:QlO
m?BBngg]\lMh3RnTgYNT4^A@8cTZ;:32[Gaq0cl[0f;e9?R=742C^U:OWJ^<V[:j
WN0f83NMmH[pNnK<`LKp]KcbJgA5;bP[Gf:`O2P2F7ol_R:fS;38PLihHCXn9JgB
9TKD>`Y[S4mV:hn\CDR>nnAallJk3Nki6UP3nD_`nm=qIWFZ2OiH6n9L2_nfdl>T
p0AS;WJIq>Pk@8i`9G1WoMg;VahWeJNofnkAob6:2Em<qbm826N<BH1Z7gnR0Uf2
[1[<b[Xh_odMOKA9`_4CRVB^c?WEANG<nAEH1:0LOIle]Ha<c5TgMB;JHM8R<9j5
C_iUp531blGT9V\[fR;7J6DHGa:K`pMi0SZEnM;5n6I=33nT[?pRjj_4:ap?BjVl
KU^Hbf<:AU\clX>Q3^2W?k[]LA``IcpfE@7J?RWkOQqLnQ731WMCMWGB\2A9Jdc7
>78HQUHo4<;jRaKJPa8D480H`B9AKg>le3MCf@ZkkP?X76\DbI_qe=23b\8pa=lX
j2_M9eF`[Aa=S1EhMC``l^::oXTHS87liAj_5T6B9ICq7L2HObh`]VNFKO4j`bKc
E2:@fJ`lcmBkI\5KTe[SFB=c^bhqTGEbDR[q?6Dg:]Z;oKiRSe`DG\K0eiWP6PYq
I1<olWTgnW6X<8@]Z4UR?3qkMi_TSWGhB0>?D7jA7MaW1C==9T^:R^H4^\q4=0a]
`4[nHJb]PEPiAkQ5g`W5FkiShkcHG7pZd[:Z_2<J=lpC9a^ed3[044EV1lc\QKjD
>V6UWfPgXT4GP9Dc2JPWDN:L00qT9R?1dXBW2EdiNLBpYP6feeYE2JainjMlb5fW
HPdSX]nigna9LPk?N5qL1XO;9CemcISU0TlW3lVghFP0MGm=9XKOg\WC]@NfD]e@
KBfk5b?Y`7laVmAhVn]6ZE_5]DF`<BWHJeP:BV>B0[\UYhqVOnW8Q3e]E@>PQ7XG
2\<VV=<\HdMnBbcP8f=6Np80O7KVUnN7Lm7]<4P^[Om^72UI=21ibUf::1l\Bnpe
NOM`bidm5>ISmjS[CG9h;C6=?H8Q>hJlXnG6=V[2>Jk5V^2>[nIl0h98ZoYG^_nV
d]Yd8?k_5f5ilY;Pn]Ia83[:lVp1:?:CaAql\03o>[qU4^RddNb<4O8dK2l[kYFC
`Z`1H6:Jk>J:O]coVJ;f;89W[`f9g:CnWdD251BgCpU53G<HiW>Y@jWV]o6aq^X5
S=E<TfM=`OQ9?Iec:T?=\M9;YPPPWP0ql6RT7[9Y:S:><OBC>E<[M8^JZ>oIQZda
f^2^b\7>\;`QD<YPebNYP5nMP>YnM^\MK7hb2dfRTbMJj3fCCABo8[JD9N5K;`SI
01F?cP`qj\3Joj0NBbZ6[RA`fM2^N=omEh0`[6EUKk@8p3AQe7JXXDWUIALZU3I2
3ENDQ4fKZF0k0I?<_B5Yb<Y3e>>E0[J\jE=6iVL\\Hk>fI]3oSR_D36kI^FPS58L
X@jma;4?CO\Xd0jd8jS]p1\YU`GGJ[V4e[\MEeo7Q8A_OHj1AEZZ1[o0lq[ga6a7
`Xa@dL^A4@JQZlfG<]E[C7GCb7iEldkgXciF8P;i7I<?;2JiZ6OYM;dDhMXg`GbF
FC[fjUBWLBhDfB`?aGfc<9Ckgi1L>Jg;UqETZA14DpC5FdGiiqlVcKiC?ij]=I39
NUO1\kY9p\KC@>R@d\<B;LXi6O@m_Fo6E23L6HEg5@VUUmScjiG^U_C17Q;h8g0X
4C[kR6[:L=kjPHbUn4]mLcnI?YiVqBaDF46^p<JbT__2Q9]S1gBLi_@Z3n6BN6<7
DQZIpecIVnV6pi2NG>EC7G^pb]a6J4N_QWoO9BJOb3:AAkb[gMPniik9OQ_ak89b
3;aO^<J3Mc;@7MCbmEVV=YA_bSXdL[J6\f3?iIZfdS3SP[5V[`FWR6q`n1]d8>D8
i]F\PWGkWISqI0?gffPqU4Zf1aL>HBa0ddaK2aPDK@?W3^HQ<kjNgg1]KCd7GO8m
18og?\W803qbQF=8SZSX`4PE>q]cKVWDVp]e<7V4q6_?kDbPNT:oKIa2QT_3ENYf
lEDnEC8k4^^G=F:GAmHCRWJ9;0F\2gJ2Gc2ONJX`h6F?XG5Ob8Nf2I]j]q;Iom74
VUGlF7c^\lLK:c:d9KjTE^B<k8bOA8;9ZL]QE]4V>WS@D_lJP1nO8J=;5Z;1ok<@
[KXMD8pXki73I<2<S_EFA?8h9UXEO8JRdOcAOKYM\ZpbZc[VZO:ZOn@cl[PKZOo7
BJ_QIYTIQj>ROd99`A_D5;FKEM^\IgDVm^SLgB\P6Q5bEc>0oI6ET@Ep>WiL]K;H
>4e8kBaVhl<RUFSJWh7PK4c]L>OQ=577GP=MJGOln;j;>FFX>g]G<W[L68hWY<`h
jMTpSXD<XX_XJlCY^=g2JjjJJ5cRbl>SlH;PZJ^=6VBC\HEi0T00[:O8:h_nUafX
R?jMS6fH;D`g\NqF@fh?Q?qP5WdVdAp@`kjDI0Tm3U_9BG:40GBdVWq;TOKg8a<5
L5;A8[bIb@dY\QR>np;>nO`fdg3c1;l;bCE6aEHbY\iei0;HZIqH31[:IHC?BQOV
2W9`^k:S0f_D3hiM`j\7JK@^:FXlNiOg^Xp6IIC\[$
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
V[=[hSQH5DT^<QCRC?LV7G4FYKIFPVje3FVD1Pq_\^^TSB@4GlHXF1=<`L63RBhq
[afI`4=<l^FV]??3`kjb>=mf:]\]iM<lCYJAo6Qa>jU>4X>Nd3>L^jK<CZeM<g?=
po?fD?6p>EQjaZl\aC^;el1U\]Z1ME7g>O`8ieIlM6cVjPW]N4p\?8BoEZq^li1f
]Nm:8SA?VhImS^gMdKh>TM[7[hDP0a7\d2Oh39pHnBCo78Q8lbd_[L5KQ]iF>Ydq
j?cdL[hpLog6>=pSkjEZ`m;\S22AMNP]94ekj[K<]n^^nS:bacb:X^4e`>2H>54^
S6ia?aQJ[Y@ZM8IDn@>c<cKb8X<eT^Pi\ZXKZmn9iX3T9pkKnB<>QLfLE?4?a;Z0
G374[1j<]e`GRD?f0TXkC8P\HjGKTiH?8Y?F5`IGF8hcP`[Fn2I\]hX_N1f`2TW`
i<VR?olcqEX8V?6BYk0lla_lIqZfHaa;QATD75Ji8<TAK?lN6n4>jjAD8`I>:S>h
=bV?k5Lo?nQ<n?L]4Km<A40<68TaS14]>BggI3UDYgbW:fUO^>VlqjM3R11MIGo6
\^jg7c8DbQG3L\kB2=EjCnEjo=[1S^XF;2fX3BD5RY>9^n@hHJXjjCSMhWD4VQ6N
hdTmjPo=b_?;SpEU0_[YnpW`AbnLVO>=>IOJI>3M^LZK[@EenqKYgmb<]M9:Gboh
Y]MMj4HDm:I;8A0`5=hk41KS8jTM]<a>FhOI2=M?5;@?jo\2cC[S\X;E^k]nT8_K
mff:oVBTYh8TcO[f1U^Rq_8RPOQE8G[;jYdeOE]1[n8q4>_SYV<pkhj^d@q<hEk<
W2Ch]jd_5W[g5IFb?W36b@PKKJNJjc@la]BTX>Z_T<Q<0:VDM]FQRC05RkA6JFI1
^CLN<cDaGb^:ncdK<HVa]c5B27l6i_\7oXD44mOP[>n=CC1HJ?gj[aa7?`n<aTMQ
[:pHW\aKYGZFej8\=hg@n:P7jaechS`A:Q1=@a2I;JUa3WcSJPRYQ;RehCK7oNeJ
j5fIKHfdncFJ09=IVT`n0F2Akm8E^qna]G][UiLb=OU6;4Y`ncL05ok_VHAYHC^F
>4C;^`4A`PAd2[j:gLTaioXQPj[abehWL@WE7YSKUYQSA64WoPBa3Bjdp_DkO<ZQ
LlNfn>3PUKcBD=\J`A=VT]W=ZDQSNm7Z49OQAoX3Joabd=jaaJiibX:fH>ZhO4;m
gq^4dd8_E\V:MHA;5NnXi^cNA?NCl]JB3i<EdlQk`=\h@iQPo4m9IIAE?:`9O]Bn
PoR4ahPh:M4WK@jR>?C;Zn19SQ[hp5\k@R6A^Wn5TJR;F=NGf2lOQ5`:BLWHSLPO
o_:I>_]NO62NSKQ;cPYlTb8MeFaIg;6n<N>HKI7UZD=k`nakZCkT^Go>SK=b30Xp
8B131O9=aUPj_g`XbH\_XU@Bl[>Oj[oM<[>4\2DgRW6:QopmBG5@9GIIG2f<P_>S
b2SU\1[dGPL16HT:E7@:Q\4@XRm^ZN]HLWqWFmji20LN\7U9FNhi98?HEqRM\kb8
EV_8cRnJS47QECYan6bfH15QC@qo2?DLjGLWV8j;Mh3ll0EOnqf\MCH<n]@flUSV
G`Tm0D63SZYX=P5TfQR>712ndLTo]CgImMV]E;5]X0nJ^XK64R?l;4cmJOqMHfG@
<XU\bPMd4II^_VHSLPdBaD?bA@O7bM_J3<7ODCiOg^dM@KnBe@9@jC29`1]LLHOf
2ia;AlX41Il^cQ1IjZq1DNZ\Zcq6g_>Y:7qh<=@F=7p5ZL_gbgpLR1H]MG6X_5GW
iWLZ2_@>^Y9QIf[Q4PRn@^N1dF3?X[d3?F2ZYa?WC60`J3=j77W1?IVo;[PhS7TE
P[CYh:G;fX99ccT]Dc2b8pX?>IRFbp>8I2Y]C;R9`MSZ8LO\E0>hp1L=4]_Qq68b
?TYH1]9eDJI3pm7iTi]NI;K]5DPXdWlbWZT`mcU?91=hGm4XmF:jYAG_a09aCCH]
peec6cfN7G>Ifg>XmoR2TWmeB`8MEh:2o9[;pUGBRY0floe<<i@:`fc7_C^]V4<Q
Afo87_lopaV7WBSq]D2N>EEM3FUlPaGlE3hHp=gBfVkbR97EQ>08LkfWR:`D]DCQ
hUOMb>]l>g^KK8mpGH`TcR7`0iMCKA97G8\1Kc_jj[AlM7YN`jeV=N6J<[^[A93K
8ALPl1qKZim2Mh;QBmi8S?]ZffRcmn0[6\MBRD1567;;0RQ^Xpm<fSRGlTl[iW_I
k5bNoWLgLakeO?S=l>]K5VkZTlZnp77loBQN8;IE_F2J?\J0;jSn6<MEGM1Q>[I1
ZhPM;@AqkLATMF4pINi55:GpWhZRIbpLhklE?mq8fN_]_jq;<`4>mNA65?bPNiWk
G^W?W3UcnT@^32\D9BGHc59WbB90TgNX91]piW;T?D?DZ_oW[>AG<e3h;M2mVigm
dWAdBD;?hnOfKV]Ga[RBa::NA_O_H5pDQ?4A\XqW?k>J\e03gf2ZbkG=l8`=VESb
2neb`1GFM:3_9K3`I:BMQA8Z28m9jHqNcMS3_`paEm[EkQY@RBl;OQKcb:S;oIU\
SJfb2jP>6XJ80YBKQ4@[W3W39KoiTD;=Yi:6UoL9`pk\@NWb;b03LGqKneTdXP4e
U^STZp4Q:[\l4Go?hN\9;;Z92aNl=627@XYDpXk0^DJA;37[Db1qGfafgc_OQcJo
LEMl3`<V1egd^0^VmQqDA_\Ko?4nM_`N]OY>]a8;><eTL<NiHk2@TQnhDjDROj9I
e;CVhqaGJ7_R5acjEiJ9qO4d@0::^H[hIO:DGXWm66>ND^IfR?hqc=l370eeJZNo
UWq]@oIMKLh>P`mU>97@YLi1F9X<BB_FPp?<cC2A?2ObaLEkd:VMZVi>MK:i4I=A
bL6Xf`>1CL9081619Q0JRTKSY68Rdp?WkAa@Db5epQRlLBOoZbSDQd@3o6:J?TKa
;eVeSP^nqIjETkN^qBnTi<Yq9V\S7EbBQCeHAl9U5jM3TUTC?_Oba>NH>a_ZTeBY
@3eimBZjfJKHOdZLGES2PF`1I?NXV`BQFBnSl@Lf?@]M5YXK^gYX<FMG>[h[]U_U
RhTBmB<UB\@8qQmf]hSD`3bLE476EGIEjAmT@[`1XXVGX3>q2HC]c3DndNZn\7if
oce959XbEaGZQjclcGe>hbXa>SYQEQ>=;M2^TL^>YER:1TMUIEGfeL[>U^J5@>_a
9RqYclHW<=7fACHS_JeN::T2d:LAN=8NCmC<4HLRd4knGJ@@NLmR2FeP?EbNkA_]
UK1cHmhMP>VLEGjDg@_`1q\j@^EnoWcjRgY:_DmGE4OW`_LYmNP0G4?G2C`H\3_U
JSZ^[QGbT<hK9QQEBITH^<EbKVfQif:NRJTWW8YXp?=Ed8>fq167Wi2W4E1LQYGm
\6kkYL2a_ZQmZO><n>Y0[WE>8MjlmXK05Y@NLl5mA3YTB=]mfbgbmOk_l_hSjCT;
X<[LMN^hD7Q5WLn:F>mJnpU8<J@3f7MT5:mm<lBNhoK;p?YJU[]Yh?5f>doAECEN
kMEAQkXG=CEbH`f][_?i]ZAN=PT>[o>9>?IX`=RVY`b4p367`kKkpMQPnKdpTS4<
FggY3:ad@X652@U`o]7bT^dQK\l5:7>QLS<Y`]S9ONeZbG?Heb6Yn^\A_8<gn=RY
`2Ill@b_0d0E`BdjoC^K6^VkkH?CaNaCEOl:d\F`^VCC\BXgE]F7>M6<_9<e`@7:
AJeI;[bT0cPZ8meLp@JAoG3LK^`FPBV;YA:0X^ko3bd`CeM;NgW6CH4E8Rmc0`ZH
]8Uj6AE_4ehJXW@Cln6R3j<<W2bgAn2N=X0qna;^LPng90>B@Ch^OTSe;U;><;Y8
P9i[W;fY>:\7GC:CfUoR8R]6<Y2eMObLbc[`IHMh2X[o]J8LIE@X1EqHcQA20CB<
ZlEH3Lej32aQCQ5:QKP0h`NUPQMV`0j??K2?2>ZnISNcmmRcS2Zi9_d7A;?]K3HS
L_3hTVj9lp1@FJM0`SOMN@O[:akdT1@0kPZn3<[\bnJ153Eo?@TR>L[VZmaXn73F
QZh[BFEh>;]P?>P7dXD4:Sa=@GYFDibjlLk2g4g^U9J>^npA\>_>JVRe=29X:>9K
iYDD1pP\XFfnBMXQ9cHl3<W9R\BDKNg0odG\b8Bl@8B6pKPSGnFJ1H8[0XOh\glT
e?Oc3POFE31CgqEKI;X90Zhf?N8855gDRgT^^Kg9J[mlI:>hCg`gklTNbqMX]XNP
q[5C0nG=l?35<pMjC`SJ?Z4[b\<_PB0k\[N8QkZAX0gEaR8jjAlfcm]`q;:8;a:;
XCiDgaW5^e46N;X0hoeEJIWGDdP^9gh8U1Jp_7^>AXeKTf4>50:K`KBDf2mB`MAI
;lFC@`iLp5>2\eD<I>7MU4AR2jM6=E43nCT5Od2k3jK6`UkSBEmpW9jK2R9NiBjm
H1NiH8BB2e8@AhnfNH0cc;>>BAh6VIq0OVBcbBq`kbj1ADebEZhbV4aHhLGNK>=E
Z6gJD<T5[ZQoSqIb4[d\Wq1mXLX[pY_Af;SCS^Pecf?Bo0iq[[W4Y6Z>c?32TD3<
\NCpc@A]e\LQO=4SM6>a^<]SVfP\[>_]G2S]eV9_09TPcA4<Y;mbXWTVVGJm0\K5
7aBJ_U@9gD_;j78hcg^LeVLXKS29oJPqnF4gZ=8q\eh5EGMmqm1oFf>\j[Y5i7LG
1V>3qJgbiB`jjiAKF?ZQMKnQ=OfLF7SDf2g>Yh]75NL7j]b?gCc76Vk=Jab10kBO
8\O<;hIRi7Pf3Uh@e>>X3R\Q3_e5H4nDkKRO_=jpOUFQ\Oh9PUaH[P@jg_SIM[L9
lHGTaH?i2gWOkIXI`3FI6Bq94gnEBaq8dI9bHb0q\JU4n^4qbG]54iKg1QJlc5FL
j?BDDCG=1>]gQ@[1G7@3[fcBMI5^pPYTYf7Aq7MM3M]7q1:gEF[X[fnbDMF_5Fc4
XSY7n:?fkL;=<I>OJ>gQgmR=\M76HV16`3VO9faLSg00DfHO[QX5fST9R<^a4hD`
iBYDN?RNfc5?VK7pZXfYXe=8LM_<oQW7IbS^n]R\0loZc93hVH]8]S3Cm47MJm?G
J88KE?8W[J9mWibp=bMRl]bp\nYSFi:jLWR_15:cPj7Nedp2>HWO6[pS^YBY[FTm
G@XK;@F0Y=?aKnP9o9odkljkNHqOe6^G]Wn6>\Q8:SE_=EkOm?P7YVa49ZnlT=pg
[bg_iCpW:\1;hiA=ioY<n:FnFK>]MQH4C71=2q=OLX\B;>U@UB7FfUnQT\V\1HJI
02GPMqRDh;^=@$
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
DK;4SSQ:5DT^<oaMKVV@6f=3O\480IZ?G]Y^7FY<?mlcIjOOVZEOAJBM9^R@`mUG
I9hXmRM`qa^iUC_aZaf@aT9C2jD2?O?bo3K?MlK3RK[EkENp:GU^:GcTXgCUGF\E
6Yf3`Fc?I=<jGD:Yc[f1I;ikb<BTh3o]CPaYW::`dEL9clThEhh40E9p:Y=XZmqD
8hf1V9GcHJ2V`VWYe<mHZ0o^=mR2>DUpMa?;TnZf]=M3nWdWOj`51mp?jL;FcX_o
GAYKbEDFY]UpY=KHMbGGA=_jZ_C?RV@AW?H3TDP^nGf[Z`q]G4WCUFF7S=c]dX[B
X4[j;3W=ARYf<ejf8b:pD3@6cFTg_iCEh`F`6h`K86QFA_p06SNm_QpXj2<EN2C7
2@RH^o>o?`H@<4@IN6cD27oEo]R0fJ;O<WQ\ISU?iEPS8@qmPHkcEWbBC]TO13@F
J]3XamkTkhFN<KD88MCZSh?Jjd^CJe3p`koQWMZIGdY>O90`4J^lKYDi8P?;Jj:X
`71nAD24eElq5cS5MJTpYJj:S]9@1SWd9j8`N<Sk2c1J0V23D^@O8A`A8`<jfZd1
_o;A1Vn`JV6Xe6qg0ciRW>fT77DmCCY`EJFYglSbfB^_`FN0iQSa3kF1AMAfHWEA
T3SO6AVh@1knSAdC0SgS<<[T=CHmc[cCdiS2EpY]Fhll2pSGVM`kZDnRQ=;SXcgn
YVB;:2\l@MRDbSp19BG9@W7]:34S7<VS\nGek0S<<T@>O]efl]F^>n`^@EqYj_KL
kO;ECF;heFYLi>ic36GqeOFkLOLqF;f@>NfqmJcZ]47HRU^>c6`KeRZ_V;E>>5NM
aRc_VKUB<Sp3N=`E`cq[<OCFjQ0k_2Q[mY48Y1@W]7=WaO;e0Fc4CN@W\Q4_c1Mb
]B3jW?H9cUpd<@58VeK1;Sc?`1C\BYGB=_iK_KU<l@=97?\CTCgC`3Nb=A`pSic?
A^\UA[cDF;bdM@gd^`=n;=l0U;3D_2bd?3@`9:Yp_42<U8JZGnf0acJB=<l>7NZg
lmIbh=0E1bRhFjq<NfMgeCp6Vel3C=KQ:eZ\RfI@o<3_d`lHf8SZJD`kDZ_Cdk\9
1Oke3iBWH;Ib>Qi7Ic:>@kR]ZIeTWELi`kiOnB\a2P=_<BqQQQU19Vq>^GM:DL34
RWWSPV[Ad^Qh?LUJMo:0XG?Od?Fg:RSB93T<iSC^2?MMm<7HMBRT;K698=Pe=ST\
6`TFB`CEG<OpNMjMV<T::n^N06i[1GmT840[[K:Q8GhFWmip=FebOYA5oQNT3=ng
[Vb3F3FkjiU2jR5gGm8?QL[QKn:9`L[=hdTmIMN5NETH8Thm09^g[dgXo`2NiBq`
S<V>a2qAgIQNFmXOXZ?:0i>YQLXpejCN`P7pf<mQMSM^JCbHb1VOU]a[oAATnMOb
fo;UONhkL9kP6jMV6hdmUVAE^45[k?jfpNYdW:l5qKJa3R8eaf6@9?Uam5ZWDjJg
fQPkGh=1:V0qmA8ZN[Bl69VX^l69=7fABeBK\gq[ZnRD9hp8J`;;Gbp^leQC:bqf
?g:5Og>A;UDaIGl?[i5T3g_oFTSbU9VSK0Y1jmfqBhc5k=CQKN4HXfHWEnn=LS[J
\V]3TNYT[62?5mC6AaLZqd`]VO^9==TcBgdmWoZE>XSOdCg8PmB<_a3JR^5DO8QS
OBnZ]keiX>5<Yq6[R?Gb8fOi0UVdloiT0TnoB5bEbYHHX;;>5O^0`FKhSfAEEoF^
npX\9<5ce9hOn4;k:IX<Pbl;QP`hRaNLLXR4_ST0=enP2FCDZmai2\@;__e9=Pq3
dP<B5cqPnj8X]m5PopB804SfKSH:?k8mKP7QIk6>nB==:3XE5A8;LPf2XE4LQk?3
@Zp_M_dL4j81P66577;Q>Bb87R4lQWo6><nE3`=SlfO\k_i]BSGG21LG<TdKj=Bi
7lS9jNP[dIqEDm<]\@q[:[JH:pILKRQ698GaV;o>@_hUnYe7<>[jIdi59mbMO<b4
BE2cE<qFa\2h4;mV63k8>`1On7:H1aD?D=o3hnddOagM\@Ybg43qd=6ARmN=h6Ke
>4D=^k>SK1W9DAV0fP0BHPEWI2HLAJ>fp0C\Fh7?5ce_NlaPX<GFZ`[9Bm5m<O`J
oY37HgiF;PT:^dHKaJ<`VSSm<p>RBAm8L^FH8SJAl;Xo=48]oMGIKGAUWN3mmHQ_
18;`gl:_\?HOk]JA_^J=^Gp_lIc\jLE3CUb<KpoEfoX>CpFIjiY3?dPIpL4D[bTU
3Ohk:Y42cSVQR::iiYj;kkSEDOJT3ah>Q3JBDo;`V@RYMpBHn_?;D;kAZ2^=KVmb
Y?6kAR:e;7Xb3g;Sin8jI[GUb?ok?lGDZ8[AWSC:QU_l5K2`fD8UKjZ?cqZcC]F`
Gq9YjZ7?qPj5laX=l>b?oDABagK>[R6jJ279LC6Wb5L?AOWVkloIVq2\`3fg8VRP
>@[?11^;IoAAG5GBaP`0BIM:]5hciob[LRp434jdHgQ\1gaI?i9Pg];2IQL@60@4
i00Z3p3mJC9@>D`lMAP`H>ee;=m_c`jnSZo:jSbS_BE]mMfI:gZi3HBO72Q2:]pk
8jLla2nD?0EkL56`o_HCAGdLS?:>1?lQJ?OG`8^18oB^Rd3l[dEM4eiOP6nqDd>n
CiTp5fn@MKD<A=pSlBPVRC`9?QIINYL\OT2ekqRl@a`7]X8\1PYoD@\PDofW8MN9
n?T`OB@?lPCaNOl4i^?V7Aca8]pUT1UmndOc?A2`XoNQoHgn9hQZWo3D>n?h\QUI
kUbB[@b9gT;J87AQKi@Y=4k>K5]DFhPGhH<JX`pMJ62]91qgNFjI@eY8EZnj[nlh
\gcHMRf[jPK`52nE>GojW7AfY5Kk2lagi[R\KRNccG:8bjp:12Y]>$
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
