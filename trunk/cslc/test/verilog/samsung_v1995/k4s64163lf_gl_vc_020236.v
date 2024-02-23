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
K2_01deRQb/U8FKg<Ee<)_JC)?V#,]4d9Q6.)+A,7DTf8XECI4C\()?b(2R/)-[e
fOSLUe3e.):9J[fY.L^D135X/JXC(W8/@]ER6ON5Yg,4:fM]81<]gHD6@OObeNa7
6_3J2.=;@##QIZb4NZOdQ_66^8_1Z<8HU:_,(ZSegW,IJ_OLa&COZd82d_cBfO95
\RXJ,4NSOILP+WT@L;BfJ@NdX_J;;5R=-.[Be?50[;dAI/]/a6JNT]]DFB_[P#4N
T@]TUa44gC^?\&;KJ:A<bdLYQ,WISY.H)58T[U8JBENW.CIJF,T&KS#C15ZcK.._
4-Pg7>)=1LQQL+G[HUSWe6WK#5@?XdF&@&VcH6#?)^^,0)2HG6.88_8T)W,YN_C2
I#S4,N]^\.^+LM1WD])1KTC9MZL+dUW9:/I8:;ae<Qg&XE@72/McNWNaE>K]]Y7B
J:VZgM>WeH6AOb)DQXH6bEE(=-<OCG1E,/:GO#\_MNF<[I1-&gN4@c&)2@9UDDaF
+b;)aKF_AR^TDAN4[L;BZ^6Y2&\C.^:#JGJP9c5#H7GBeE8LN-S.)R+/I(g=G\<F
/4?;]YTDU)TY\8TCBC\;-;ZZR+2&Zc@U44geKQ(W,M8N&AeC9QSVJLUIAW,Z;&,g
3I;6TgT5:G^;VKJfF&e]_b2gN/],_#=)g28FC8P/==U<I_.T#K4BH3F<-DfJ55YO
?aEQcQN#ZEM,][&g,c>fX,PQ\3GK3X.;(7VEZf2OSIP_H)Sf,W+BeW3S]Za^E62.
Nd_,ZbaW:8524FFJ-(FQNS=[A[+>H#&AI(S?_c_2_M_NY_PcKZO.8]&>=QKKZ^OE
>]I0e0)bA>RE_@Fa.=W1G]M.GTO0:Ra->^R9\E#T#7=+3^Ef\)d?4UD-Uc7(;1?B
?-5O^(:g7Db3E_X-XLdN7IgN.C(bd#ATJ]eG5gT_K-EPH?edaAb(U26ALZVgC@Hb
R6[3f;c6G11Y\;a9TNY5EA&/I3.ATAC/\O]0UJ6S15X@(<89T>,OYW8[W/S+eYMK
#Z#C^I#<85B11?+855[QO:)Y6IY-A7V4+81?=4:SJ+]Ob55/A1Pb/89gMRag#K?H
OE&MWDL0g4Q]-4R59W+3]G+\N&KfZaIY]8)g<78NJ,4/(eB(69FRJ^?/^LPH7Vb\
636UBZbZ&c;UE<-Qg?O[EBE#@1S95XYTL.-WX^d+]eDd8Rc5MX8XGVaU_Y(5^_ZM
Z>A]>@7P36McG)df\C02[)W?b^J2>GLU8FYTKA6-a0\N0F#(:,;=Q@(b\e-C^1@N
JO@.5^3a<bOJH<@\][V59(15/:dAH;;M<DUOEf1_]UfR@fPM>P[NILaCN3Q^JGG;
MF(\D4P.M4@e4#LQ8bGb7/4OD<)R:,7SOO#Z6W^HRY78-ZFO_J7AI:@DfcLVaIY;
-YD+_&FXK=8^#X78a]1+P_YXN&P+6IbGaV,A\/]8N\XMH;&E48:O[Ug?\UdYIB8\
)ZJdg_ZET^^JPT(ZgcZ^@__:14#f52TV-/L+UP4R2Z^1cTTXTMU[#@,R7@PfQL/g
=(GX4gQ-481=?FGL[.JCeGZgU?OS_-0A^L2/>]2::C1_8K-R08>16T1V\@2\U[cJ
QJ4f(3^eEA[6#;#Jc&S-b\>S;D2LdA1L:(0fVB6I##>+:b=GIEL.MRF8PMBQ>#0&
RB[31g8650<VdBLYQ.U[[Y.3MD+>474a.F_J>^CI##^L9(&).]=:aIK20^VI@0=D
FCMU<fC0H548#,^]^gSI&PQeZ2<J+dP)].#/^JS4D+Q_???M&(<7HQS50<:H@2aX
DUMd=Me)H99#PCM&F4LCL0O8eg?91FJRYV#OXeeI^Z^(+R1._..UK;9O5_cUe.?,
>Sf20UFMADaWG[cTU[-/Pc_\[,B)afBC?$
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
/02>.O^UY1.J0-(19_UL(]_.(;AA-?^\<dfC,QR88M(M>5Qf3+W/8;0:8G\g<C1K
>dK&8d,XB?79[C=JI62OF@PVP9)(9IQZC+@(&YO:A]VNB3VE751>M-#C@ZR8Ya@G
+d<8&Jb9IT]Yg84c/NV9K6L2S@7Wb04&<E\ALM7<9E-_TcM77F@1/W_\)T8VCGG&
,PLXf)E:&b/VEHN@1)-7:JA@.(3/P,RN>1O,-UY91D&7/02a@RCCC=9Dfc_B0GA,
KM98W<B:?c#Fb?Z,fWH\86QDVM4(+RF)4<GJ\N>F#;bU>LSWT=1^J(3]bJN(06.6
Zb>;,V&8S[G:4,EW.K?F>@8_0&NP8c5e^]OPYW5Q_9QX2g-Z#<;P_D20AZ?0MO;b
;geK>HC/+3K1Z[>RLK.e=Y][8cE-Z:=MF_0[Z-.gaJ,)TH&bG:3Zgd>>O6V[=-GC
CH<A6QSICFY=C,bF:S3[2^d@4cC#_F/gD/?Q#Zbg;@2;R3Q/>M0:-B.2::#-(6>Y
QNX)NLP\fP^(:/a/HfVaNLaZaaF:d&43FB9V1X:D?=(Z@DW)Y:<Y)LGH\5gH&S]e
YFV/0PN1.A:UB).+)4NT7S>,bJ:D_#R\1CB++Y:YPcL5P;-c;)3;P]bB_Ieb8HB0
/6-Sb&?:8?ZO#IdQEDHf)M;NR(GJ#+O(]^O3R\3g,,LR-<8e&L,Ze0O8&3QS9CD/
.,F=#Y]P_:@7NgNFVD(.Y7KGO?93C(GB/B.U#T-Z,?U3Xa6K9[LQe2Y0R22Be,RC
?eG5K0LE<Qe4^/I]7CLOf&JF@W^-C1DD=S2^(W(7YM8e1>caG:D4aJ5BW(S_WLd1
:c)6?-cAIEPGE4N54F/..\/IG2S8f3,#9M;K9gaB<,7Q>=b#[g36?eDL@NdA#eb@
6XX//ZVQP\Hd1+fQg6/018DO9#92-WJ;fUV)\3-)#[cJJLU6N\:K7]9Ke>6;F(0f
)+/9W_=#7TJ.&Z4OPVFEU[a2Y59:bUNF,>fZ3+N+ICXG83#J>:X^9OIgR?E\&Q-G
b&G.7DTNM:BW^NVLdEKI^D9C0FVA;?41f(4])6ITP?=U/J6Z8.;515fY9@\9)7Z4
HICFU/DJ^b^^ScFHRUcE2>977LfVURSFSfW(PZa#fbFW65OD^+(1D]N)AeN0<_?<
DYZRIS9Ka8^3RK(#0\8(.:2HbB5M&cQU4CT9eH9A4[1<:O-L(TY&J_1.Q[.OJ^L)
.ZbASL;GR-J_(D,5O8\?[CfJ&W]FB+D=W/<a_[:1Y_/[6TD@7M[S8:HFA7ACE>>Q
9M\DWO?/@X?\8<\Y[fR+Cf(FdE_.6JX&eF?f54@g;^YEbO/6<2\JJbf_DBG^DZ7C
2WC&8VRg:(IGN;/&AX@@U<bZCfM\dCH<)+cg&9)J8#9ff\dF9Ya2a91UFI:f\Lf[
&Z_OZS&a,+@8B/CRfXEC_Hd3W6)b&ZgCUQCGLLFF]IF.P0cgf_\#OKX2-a)g.7dc
367_N>[gM4?\58,^-N4e]AD(QK:W0M4FI7G0PfXKE#-J1W;H67]?FJ(?\-:=IVUg
/B/B)3S3L@#PR=4W?TTEe+]NU,DNP_-B(/a@E(_e\dbJV(&93<8Ve-a4,1/T^Ka[
35I]6@Of;/L#-(T9>TaU3Z_499ad079ZJ>SND8>8E)4f8QDIZKQ>IMUENGU.Z=;P
:NRQ]4)KOZRYA-)H37^-8FLJ=^a<]3:.Z(V6DIZQZ831(<_OI3IGS;VA8-JL2d?\
S,)4&;4[PQF3..a)I+6R(1M(=Ka1GVW9g8;d/@G;+4;7]8I^&(.^g;RVR]?d+Yb+
2/3[Z]YTOc/]ASgL5@QB^M[f-NG=-^YC4?@6A,9RA^<Y?VN]@C\TRQ,8Of66H6&&
Yd5:aS<ZW]Jb@-\:FE+Z8F38?RP[8Zb&EJJ9;?TX?A)Y=\+N;.0U4<eDPS))c0?-
F=:(((Z4EVPFJJSGdeL@/BYF8/4\CM]Y)YH?DZ1+D)eV<FZO4IICV,WcLc--84Y+
50)6-C069M>RGU^J:4#gfO-Z7]^Cb=CGcG9QN5:DKdKR^OYSRM3D6Y#O58><1(K2
CIX44@[-4G[U(+FbD0GVb8Cf/@2LFc0QY?2d7KX,3].W0;0Y=#bU,AL1ZUMR+_)C
Z]O3([W^7bZIL1\bI<R&T&&(1S&N75[5R+U29OFQ\f)FW<7P#?DCHP.Da_IIPST#
^Fg9I/&&)8dV=-;]3-TXVL7YPCQ#I(e7aRM/>Ae7Q==&^2UEK2S1UeLIR]L#QcT2
=B4L7;V&T.\>M;^Gf]/I>c8a6E^U6dL-Bc;NA9b.,.N<XNTQOIW_O)?a\NA3Zb;<
967^IWZI&H>-L?)LRQ03W<]U@56A<MC0XOO]g@-b]Jbc;<RdGR4](CF<gZP0)TD2
e2agcN.O41KKY7ZJ_80fEH[W86;b;O?Se.,Lb>Wd]#9>I-6OZM[VBEgd@I7,YE7V
7e^]6D5Lef?=OOBe=?2aP9R?L&_KH#a)/1@OM&e.Y1fANJWA6B_b<^+eHRf#NB)S
XWe&<WUVV\[S2E3Q8d9S7aG,1=][3.FFH<9V-;F_X93FL@KZ<PUOS0][=HU,3gMd
gRA1D+8YD]9=G(/N2YT7LW+[5S4>5B.=Y^#L_J6>=G]G49A36QJ=8VQE2+gE/E-R
S3NaJ@4/I1.&@f@8.ggJEYR2-(?6&9I)4X/G200K(77+@0,8:,b+E?W]Bg_N4#G\
Sd,+GTGHPAMM[b-aOG4&<H_e7X)W..)F/OOMB&&FEMDYJ-08BX0B;HQgB:aISP.@
;YQgINA#3U.BITOA>D(W7,MYZE.f=c1ER2E=>)=/<EY[LM,G-I)#OTUZdRGP.#Fg
Gc7:Bc&eM@f(CQ#/A(G&G)42R\]^:aPE,Vg6>RA3IJKd(&1XB.]7MZ;RXR&^dP@P
dX,cH3I>fDZe4DYK5U)5a?MFIX,K4R)Z,D:d/b_cHfN(1Ge5[A?CO+EJ<-N[O7TB
X+Y2-fDP2Ace0$
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
(&Wd,ZOEaDE29_8M@L(Y(^.+)Lfd=@&F9DHK8b.SCaR\:>f3a&I.<5AU)VI(-WS<
K\OH4+Od<6B+#g42@8=8H<PaMKHFS-d<Te1^YOAMe#,W<VQTB0Q;W\9Qd0b2BH#D
:VD/4[cH4NZ_V<S6CZ47U=Tb^#.+/]2V5LIZM6W4g+E&]dbU.P9Ca31]UK,\GU86
T1=@eF(A+@A=@LTYP7I3B>Pf+C+NN6ed.EdY8#.JN.GHIQ-6B853=6Y/WDV<S@:9
c[e6LN7+EGCH@<,#Z/A0D;9^T:4C?VW;PY0O:54.[6R,/QEWDXc#fWT>SKS-c7BW
R=<=7#bS)&)#_NO]0==+L5g^T_XI/[OH86:N&D_c/0#MV(?,9+L^OEC-UKL7#/ZE
.=@ZQ32[O_@YU&dbeR8:I]#.ZZd5./O;39[4Hg?<133DOd5HYZaE@\M#5bSO2Cg3
2,_O(YFM[X_Xc.Q_X>4&Y<cPJ:(I7VG\@fbJ9g]E#O>Xb.2@.XW?7PRgYU;c=<KZ
,Qc4fUO50LgE6.f7E-f-fa(D5@=Bc2PXC8\;L;JVM>S)P4a#>E[ed6+@JGGY8XZU
,DdFE6>_BbY\YBN;9XP/OfddO6TDEI?-OM&?bQ)V_HH@Ad/>7OUgR>?NaUP6Ud;^
W_#7;g(>UMgHQEF_-9=d-@GC1SbcO3fOg0BF8WK[7G1E<g9aOP.<J#/Wa^HSH+O:
NK/XdF/#3fWC\;TeAS)^;R?ccAQDH]L28f,]c]7#g;5.F-0=dY)S-A(a/&5]Aa\9
AM&?-27I,XP/Ee6XdD^OI0a5.aV5VGg5]+T=V0+T@#^dM2<V6L&^D;cC[[f.>9[A
TYe\E;:F7?1[Z]>KD=6Nc+H-V0g@;]R)7B@ZPQ21Va^/e)#,8XLEgR9d_@^4&SIJ
H.UJ)FVf4JWR1ce^f?RW:<V8S^@NP5FK\E/TGEHZB9IJ#B0e/QeX-;-?=Zb3aXBa
#T>WJQWUagE-JP#c9a=_6HQEeC_?=YCN_W&8e::.4S2Jg1T.E.5\OXAJJ;[1EX,9
.;IYJ\Y9Lb(@KA2aRA@768fT&:;EB3cGdF<[)L_dSSW_W)OQTOM4_+f+ePZ3U^<6
<&cPB2Q8P=1</R+L&KJgbX?DGLXKB4_K\8PRAO>@bFabQc#);b?2/1GHd9eUKC+X
-T2(P;AP(EB+LcE\O=78QEO/CG85G@[JBP#M0[OX__(d,0#(C-#@\F302;Bg<A8S
eMS5OSGD<T5?QEH2F>3Eb@VCAd2abV.;2ae8M=+6PDU=R\UY,_I+FVZ90Y1)KKL#
WVfI//.L5FaO591@4^+L?A,J^Fc3Z.OfX47&TJbT5>9bbN-.=9PY\GQUURIXA/M9
0c\XP[#3-R,80b,a<;OF/L7gGcg#d[I5:fCE;VF8g<^XSNUD/&[=(W&B]G[Y]M:P
V&VIIa1Pd=+4Ed#]+a?f6D?01,bO).fBB47T?3#HdcM-[##&<)5_41BTXN(b<PK[
QC_bV+YJ;UKHC]63G/<NQ>S;(T)M6GC2KG)/Q):_I+,QW-K.\,5<16MMZ)SZ)7+2
gAK-bbXbY2AY93[cbKEE6VUTC99PgNML#)50#@[?1YHM::4ff7fC#&ZHgf1Z+MeC
6CD?Z07\XgL.J7@V=8ITXATc#M2ELGMTZV.)^?C8UN^6OPE(UCPRGW6;/T<XJf;+
AO6QP1BL)Y6(-2QS76A2C<VOENa^==WeZ=62\eeR@6CW[G_X7Pg2KP01B)<c+Z/I
K2-dQ?(@&4D\N5^EF)aS)6.9g&J7cPM;B_?JNLU22>4a2N=.)S@YTHTTe111Y^69
0A9LXA=XZ<?JC)D;EBcMS/J-eR,9dLQ_d5FGfb=D;[/:A)dd)^0]EK<VBE+A#X=_
3VE5;&@D&3f+I771d?S.:II<I4@/B02T.fIX)FIX)FbR?B+gRJQQ&1=M/?Z@-Ug^
F3c,F7O;3X?K&)8BMgeJQ-A.>cIPZ=:O5IXET90?aS1IRBP(-XYaWOR-.L+=ZE[S
#:]fcBS+RQa\e2R<e4PIY]#OA#_KQOS/O?eQ&W]A\d:__PD.P<bcC+9aV8a5YP2]
?g^90>IO,D_45??W8Y)55YFS+fW]_Nc@KL\GKcLLde5d9H7f[J/b.2(_W?X2LR=;
\53AIYGe7\;Q=<H0;\6W5,CCLFHdQX5-T?WN=<dUD6^K3JO5FBF?:O.fM-G]e/Jb
H:ILSJB:<eLd_\N74;=9d_Y\^R\VW[2:J)G#NXXKgc-;_RJ>/R#BM:c^F984>8W#
N-<9T@_.3PagaYHdaV@V]BTUZ50.X;afNZ):P=FWGg9(b.cI0:;_efT=H8SM4=;_
BMeI#9=[HR)M/F/c,gFBM>@I;/cVWA77W[a@Y[JV8E^[0I_A4\>B?XBN^/:&U,/J
gg38?#@6^S1][XaN9QZ<DX.,]M^3,VK2+1>WKe7gQJf>V4BV5f5<MLZ]W)QMYV<P
;>A)OdR1OI9WG#S>BA1B.HLF_C5@X=-,Y,U(71+1EVgF;PaZD&=(_)+N>E1TQ@BQ
TLe()H/:-^NCD==f:B_FDWG_G6\(-C^Hb25&f89^(1ET2cS;2OV/[6-U.;]3b)/#
FMT4VKCI#G7T+?0)P_;2F/f1#6J_bNbS]Ef7=W;OKI,0:04a1ERd+E[DT5f+YDNF
,BO0b&fNM#1He[ZPK3Ogg]J=G8PXMSN[4<71gabDDeN?&(K-U/D2aBX/e33F1Fa9
07(;-3I:^d]B>;E5^BLd(\K<(V3Y/dbV055GH79dJ0-Y>(O[OKH9aDfNBc]1]CT-
#F<c1WTAWZ/[B\G#NT=PC(&gW;B9P,G3Ue_?@PTdB<fTJ_Pf&QP/c/;J23PI1WJY
)<(O[bY=/c#g[>A;NQD9=BfUR,&-c_H];AN>JB#AP/5#c7L\QZRZeA(9@S-VNHCJ
Jf_H@)g=IZV,RJ4?90K2LQ)G#QD0H[CbU_2^]bfJOX6;]UY#LQ(bR/FQCXLcd+5T
8(G.e,/T\[,I=&g0b,YS\9P@Cg?THOCe>=aeVS4DbZKVf-<E;g[\1LZb.99#gD?P
^:.]6OMZb6XC?b,Ha:RQMDE:_MHR7<0R+CX6(UT:>>_5A3efb7B_INH,3X[W7^2[
PPU13J<,+K.W?LFCLS#B/7U1:2.G.M9_UOEW-Ja0^NY[(7:?\8PaB6EX]^eN&)ff
Y(L)2JQ^W\P,g,I]D>cPJGf3J:I.]?a>8VOP0G7?>XIQL^F\_Uc\>0QT(g\edIcb
dcJ?Ca?ZU90A8K0D=+6+c[\_DPUQ7R6E4gWM(RC6dYcOddE/I<_.#697b2GW(7)T
.Q4WERKN3-3_+DIHFG+>U+cgbTC>@O#Zf#IB8U@#OQSG2daQR&cZ.S)VDOWD@@/P
L]>E#HJ&0T_V_9D/c:]T:cED6E65e_<a&cOU-4BHF3SB#,[^RR=b;=ZP0SU/S6L^
3.U),NaaSNI7=?.5@,R\bRP>-VCLH-7^H+V-KdEG<@F=)e2D?6RE/EFf54,UWS=T
TFA#>38a-=.^QX:7d<E+a\A??=7D=[YW0;]O(cILOe]JY7J-EUU/b[e>S@&]3/&9
ILMZLMJ8;&d#>ce/L/\G=d]ZW<g-A@@:c1E)Xe,O(TG0bIN.EgLc95ZHYb<1e64R
=5#X,()FbA6D?JJg<+0?0[T=IE\aBg?_:6=@Pe6I<EMPZ@gb+#&?#F]@RK^D;MLR
#Z@SLQdcgZYa/4Pc[e7&R4gE/CbN</&[c<XT(XK5_NB-S.D1]Lg=gOGagB/MH.#4
C-<OF1Ab917I,U?WaI<5S^Q<TYN9[==?<=f\40Na3]GWVeC2Y:A_&IM<&I51PGY1
VT9?O2M=U]LTaP7W9d@=QW;eV]I+.aG/9E_/TUSJ.IUFBC\eX_gF@@;O62OG+L_+
XN[J+Ubd=,E)Z-4OV/4\^f^Y0^/?c;(M_C_0;fQ32V(d\)CQb0.U3@:\,4#\;WN-
V)Q)c8gB5Z:9[dVC+Y)f=P47PODNM7_,O(E8efA)2;3(D39C,6H&2U#7]2#>@]/\
^453,3])SC,6bfA>LZe9DM5QA]\\96]VGH?@\XV?>Kf#,U(f3>UQf0#H\g900.Mg
dF70LB4<5C+dIJXJW(OUDX;c1P9-R:b2.C5\0;J-9VA63MRLaD_FHOSCG-Jge-YT
N,UGZI+]IN0??b2e_.IdCEgM:-7R=CBH&Q^9Q6JWYKYHS21W#8@X>c_&PcV<.A/H
>51O6=g7E/W@B32MT-:0a.@^]5F8>_8MQI7SR3NOfF48g#C)e[A6#<YM(UJ8>9TT
c.@Q>5f>])8C&+e:bQZ]5>_PcCWX.K09[)P,d=25G\DZfTN7HgP789(+L2:EL@NX
CIGbUO/]=c./:UGM76B5A_a@bRT+,::8\KL?EC0QPS6]V7\bHdX#)@#TA?3=PH>a
C6c9=)Y^0JL.HO-8[Ib?WP1;CI-.a6TBI?TZ1/DM6?@(Q.?[f]22g0f#.ed1Se#^
f,1&/:X>KbaWS#3d=P=+G8DY_Q7@24.^SLJ2Q^NPf#8[:TXFdGQ>cGb1+NHT<S\L
gY,AWT]RM-9NRFD#JSVfTdQX/T]CNe7UK4<DgMDI1_=SGfV?8S=TZ:]egEYA<BB-
>(E3H;GZL^2d3B0N^07aKM8RgLS1L?fL8?#eU=cD1ESC+3)^ENMUTH+=O6GVBF;M
<;ZB9_S#dF]>]c7b[;4SON_8-W9202[_3R&NO/#d4[G>M9\XP5B2=VT.QgAM@S82
#=bd,AYO<B3fBLON#[<Y.U[V:18F_Za/.+g7;C&EYM(<@5gdbZ#AZ0RZ4@bHa,F<
B^E2[LU\7Rg_.KFS/V1PI+f@+@8YLS(eK9d\/H-M:&ALd(64.?UF,]@FD95Gd8)@
YA#;S(1@H,1&TgB_OZ7K/=VCUcD;@[5ZHB>4_#e:/F\IJ@4fG?_=P\:6ab:5=6XZ
A4R3/5LU3#XM61a<P[<WbR.&:b=M)BMDR#&60H337[fIY+A+I?\_H_g0=Q?H2g?>
@]eFL.HV>_[\:>Hce@?d5b6g8eb_5:6GV>H6D;S78:-TPNNK6DTg1@F)1#aE=[+T
(MAc(&V9Y&B2C?MA8;&^9Me[>Q(,b80Kd+34O(\+/2dY+.4\6<+Kb:W:,I=V(,VV
9fBT19E>Z:8/HOUQ>#(L4ZLC526M>d8f>Mb;/I^0V.#=KH7FJH64L7/:_Vd\EB]a
E_U&ENZ07Td+_76;<P/8867@XXb9B37_SGI49BA&.F\LK1T)+W96K-XgPd5UQCJ_
<LS[[-KJ9/HK.T<[@F1aCf.fgK<a^6,PH6aMc5D:9_8DU1SU.W9#MHLg8J2fLEC:
)G0B=AC#Y[=@,6.PXO&P8I/d=cTM@ZYc1@b_NVAcT:LKX>b-MFO-Y,1L<#HJ(W79
+M?GW-E\3[#1;JZ+FJHFVOE2W^-I#CO&=KdLG<>/^aNE\8)Z0CL716IA5.?G@(KS
YMO93\]@C#LAF4Y>UE?.([V;0d.&=RGW+a0?\3c#\W0S3^Q77MG19SbSXC[H=-&)
fOgcDd75OV<H:+851OI@N>F89KW7UV>db1Xd/XFX-b8Q>QIDQef2P8)AYSN7S.Mg
CKb?N&:GDJ]dCM6&+a7c&ORd?>0ZB2Gf7O4L-E-4T>(ReS+Pc(FaM1##-3ZbM3-]
DAD>OgRJS6:P8&^PV11,ENP9K;@XIPf[,SSNE8W[7V:fJ9V>4eX;&1>EK_P^W(53
R,fI9-:;4IK41I8IFQ:/L\DLYPW9Ye[2OdbbRP\U0CIH@-WS/7(PeD)-HMDC0CJM
=A7.CWWA_B/_M^N6^UN&.7_)-,HSK-:D[]NVJ1^:_.cKR[_+SMOM\+B-A>]-(_G=
@<BTH.+MHaA.dU@YMb\TgSV#^(E.8-faO#7Q?_OQ@PXdUdg)[WU6BHJ=>/+X/XIU
,N.?XZ>?HX?fG8N>g6+aV3=Z+B0+=A@E:=&P9e7Xa]=J^T7&T(GfGDL8V@dTD7Wb
@,&1fb././GY_/1YEe#NA\F,SWVdf;>T?A<e76.CA/8II/c3^b<@9VP)YIKd368\
,J4.BS.;[?HOfY_T;5TgTcd#T22a:U_]f_b(fTM-^SPW3FJQD)<2NPH5[34IWV#?
-OH=IV[eYUVJ9U-SB66\<W\96BSI^DC,\^GNI[<5Y98bRYE=,[OHM:caI1fGeSYM
bNeEXK>KQb?1d,CT6VL(aB3CZK##U.g7]KFW^I5(W.Ne8NO/:=g5E3Ad\W??(XU[
Z,XIe&1K9ZQ,8HV;3_bff\#b^TL=>O1Z11:D:/b_;82[bDZ88R?GRR83CD+FFRG/
KIXEHZd@Db)&+H>D6;c4#)[N-#0(g/.0.\+(#4Mg.bU+(EONF3?bUBCSY-65HbY.
^?V_aRBB@F.CS@beH]7/U4^\]X]^J:G9&ab_fK.D,M<9cY@X4;AgWE=UA##3M@bZ
1)Zcd&3(H><^[V1UK?+H^JBIU]a#0F7KEIQcd.H&T@2.K;;JHa=ZXPeE9XU8.2I0
?+e3,C21#X.X61IK#=<TN31Y#S-L6a7d:=a&_fa_a?1eTY;aeDUL+Q6T)/JP.2_:
,P\ZAS6>YU>,4d5^>>cF]]U0>aETc]18CcL=38d/@YXa([LWF?fH>VD6DJ,eUH8(
aJ2aCc:28::E@?LFWCSd>,@=Ea+]fYGGHQ/=;=.S9]&,I,7?5:H63,EAF(c@?)@W
A@:,R8Qa7_c6XO0>20&1VQ0@;e8_e4@:+cPXCA;WFf_5S<Te&.\&;;+Z\ZR6C8b)
6A/aAZ-[5:Y:bE^&)9KL?cV0X+/fGCOQK2VTA7MV0PAI)CF4aE_Y[>)9;\bAD]a\
eWT9e@KLMSeQ6F^U_OFTXMO5(7EVdF^8\/a-GVDC8eQeAJQH>Dg<WU;D1_B.R=+R
69/_65gVNWT@3QWfOfQ3SG<M=LC2/ONG#7G.72T0Z?VTTNNO?0B<e;];@+_=?CUa
\BW)e_=05+(@f-?3XM<JW+JN8cCaV#3C_7V,2)>g1OSD.E,T1&>_<a;0D6EL[>1K
F#WW>O-:XQ,?,I5=;Ke&,0NRfYM,cVX_LL]aH[<&6K5bHg&2SO2JLV;0I$
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
7AgaI;d><J/79?AS=4#U)g_G(:)>(8+.-VN1)c\#1[2Mf>RJ-EU@,-aA)A^f,@TS
a87cNYV6ED&B5T_NJH;aFSeTP/IIF);A4(4b=OV^>4P#g(_G#VSIYQRJHIA_a/[D
NY.dR6Q)(HGI<+cO4]0KV^Y,cgNR5#FV9V160/f6>@ffZDOFYMb<[HSH5672[X5\
D9OT;HNO,0fc<(-+T6)>=&<;1];491_N5V)YXc_<8E^@?6OF#V:G.K9Q85\455b8
KD3?HXYL^;@^.?.c8YWEH.P5+DB=>a9Lb?C556^KNBKU2cMH)MK.MdN@dL2BB.(G
\^Z]N9Fb>c:P7)dJ,<_&#89=YD^\0:3_3-T<9;?-\HfCBV>3E2&\Qf5dX-dGQ.=/
B[I_;e^)67P3/(=+?)B=a:(Z_/X>=F28]N71,:;G/<+PfICC?F=;D1;B_H]MdaFd
77_ZKd9eFce8C#?5>[eX2WQcHL&EPZ\ZPJcdE8/4DFeGUY_BJ.RF4g28bX88eRdS
/bH++08#@UW_DSRb,GVRX9(Y^&U?<[S0<HbbC\HG.UWbP8=XX\/Yg@#O<I1P9R[R
<@G<-/\\^,5>F-941PBTa/a(\)F]Nd3Pd+@A&L.X)CFCV#24<S=A+fe4f0L:&B94
)=<[OCIYY2JWEF5CNRDPVc4H1Nbc@O0T]LY[>LLOM(Z(1=#_1N0?M8_1(fVP2fd@
WOFbAHdT64e[UE)0@D&07]3GO@0#B57>\b#EE14[SF<P=74UbLD+C#?(:,\fDXIK
?GHD(BOX:1>.#V]fT3N)+]+Oe<Za6@.B\?\_ZKA1FQI_AVfP8R;J(CdF@OM2DS9A
caH^ObW0#?M(H&5O9c\Nb@Ia>U)_K2J+ID1\BNIYC;?9<<V0[>UF;d^2)-C:c845
N;gOZa?&^726);;^FVDM/RS32)IS4IF.D#&YE:+#3P844c:beF^c0/T1\(De,7Y0
T[H5XPRFG8KdHB?+OOF@-Q@25NIT]E]J/.V-]c<dB@C0.M7P6(Y6^4YZOB8(BV#I
e\(c5DUE6;/TJ:4D?(TPZ9JdDf>+^CV->Xg3Yb8(?0daP4J)D2&2+64.aX9W4\W2
>GA0DB:D<82S9aXcTH<B[[]L0Z8+^UEPMaRVZV4?3:Y8;+NW1N2,>Zb@AF:f?1?6
&FM&M02+D3LVgJ:.;&2Sc[-e#Y8^^NC<3JCC65F7d7+>;0H4B8dB#[,H8e:7ea@;
JIY5]\-202c:&53:>-2:^@<@BL;\/,FD=T/@05;@PW30e=&dH@cK0_:#gPf\BL9(
_g:0R/\8Ka:eR?WHbTEQ;;a9RS]L1&57-5PZIX@JLIDBP18Q:<G8)A+EV4>2^:<F
c[0[6]G9=]aD#LX,@CMP18]<M+&JcHN41<M-b[d3S>f43:2.F9gI4^TN@6.DW<X^
WdQ@IbOOUL:>#N(0/=0c1G5_KdB#_.&Ode0^bK[;/eO&SX@8:+(f?A@T+9dDVNR1
]P/aD3N(R4/&;>J-.OCA#Q-Y1].9(N:/S_0c]:;ZOTO]SIeW:LI4POa=R?7dYcG/
4@M_,29E3B):13R8GA[9P]G9ARE2)QE-7/a;?+\ES[d;@&EFWfPU/=?85VERJ(Sg
cd=cDSQS-+6#8fSZE.MD^O[]I+N<a)1/C<(X(7:D;HO_H&@cFJB=WGP7ff/<RFL>
53c/We,.gd;OTEY&;J?M-.)ZZD8H4ZA)6a=-SQ9Z:6/LA>A^[#]e6Y]1D^84fT1+
.a[d;^4;2d;09a8#=7]#M<Y>_U<+[:C:=VR5<IVcDV53P(0a+Lc&_=5XIFdOK)4V
)(<Ed5[3N//]0P+ZI#P[+KE-@OCf7WSb&X+R+2^7(&K>S2\V@Y>>_;b&R#1-O+Z&
,Q;?P+-F_JX0AD\0[Y^;D)TP]e#H+Sf.Y4_M-QL=MbK8>2@a2/]Z3I5CHSQA][[#
^ONb?52KcK?Z3;,MDL@e(?ZRdaD:6A-H-d]0+\UFKP3=@HBYP.A=d6&H4HY,OQ\@
Ua8,:N?b3]FNQ8ODVEc_+AVCUT6/@&9?Q>EJ8U)1YZXf\IcEE95.1]@\fX0W9a(Z
ITdZ)^aB0PC#A)TIH#A:81L)a0#D0KK/U_GX0#IXbOW5Ra.>=CDbZ@]_?;NW@b#G
N>1<;^B6g]_dU.,8S.R#aH?e2V((?[(X;:[We\N-85^W(#VbORV9T_&c&L_8\\^A
]59RZNJ9__JGTS644^SP73G-_Z2ZUXXd,^TI+KST2acb]Q&34J2L_fKc_4]:;OY[
)/59g&&D-PFgac-e>^IW/83X_QUe[LPaE78?b=ON_EQ<#<M);:/_;.K_(IcGRQ)^
0TgU=1cAM9I&KVIS?LV_>/>OO>UP5T;;XZI&E3W?NT,L3R@QEAd-U\LI+;O,]YP#
IO>VA9YDWa0WMT^1OgM=55K,<Y_EJ3HON3=31ZFH^WIPc(.b0&S\fE]80P(ggC):
E>MgccG51S407eU<K;?&DZJ/2dM_.Nb](I(fC4=>3:JAPL]B,K0:MI8g\:(H>G,P
S__XeZ.HWOZUTTLIF.Yg7:0LY.+5Y:UD72UgUcZf(<?:<KdMS(Z2,]@_Y)CEOe-N
WPRb<8.3XT,b-O#G<6)da,a[VVR]_2.HR<+0K1+=cd=SFd?6I+:3+6,.=L0d-fA/
#R:AfX(<GIO\bIH[PA-B^SeDL:_;NDR+HE+6LH67:XgF1J5=&=IcQUI^_H,L/g>[
7-&IZAg=ETELAF:W=9<P6#SPb?V?;eC^;=O9NYU<Y?3.Qg5&.a2U0>S1BUV8DfH@
^NWd[HGM@YRAc\;)84M,(+.#?e+b5BYO02[-Q-.)&L_JS\-AEW.Jc)F:?52\]H=3
PBCNQY?cH#F2/\==S/\d([g7JQYMTG0ZJ:a6MJ,TbKIT=9gXOES-N[bRR1af?cRa
d1Y\;E-/(4R6;Ge\/EI<D:>\STCgRAHMH6>4@J)[X-_aN4e;(XQ--d.V/;5IYKY7
+S\IIDY84(9[Zd58Q7cM(H^ga&AOP9DW1::DFfE#KVfbRKcX/Jg&Pc0VLb^0Le8D
R_PBRb_>TG#7#=0(K1bT58<-QK2^UYGXY\5#VD)TF6cT\d.19NUU7Fa_)c1Q,\[M
S=+2<(BR58LRIE&39VFA\c;0ZCHD>,D8O0g80F],,,R<[g\+]);GWBa_P$
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
..DYO;6ZMZR#(IgX9IT]<VLc9@ee,N71(K-/-K[F-/@FgV)3IV5Y(==D9b@>,FQd
IBdEV8-&P:&4\L[)[A/6SOL+8++UG<DTFF,AP(:KHIAGMP7&@OV)X^d0&6_IH1^@
eMJU-:43Te=/828cGR:I97.CSUW_;&2R>9;\9&/E+8I(3TGcZ4:1J072XO]0B#cW
2_bAD[20Qd)YN>T,afOKK]-_L1SbdKP#46,)O]^T=\?I5;M\;\@Q4AV(F4;DQbf8
Zd.]MdYN[),T@L2[8@C,T8^I+f2c0eP&X5d=N[@??[GP.Q8V@O=S+NWd_:aMSGEX
-YQ=f3WSNaVU]:a?X,LP-S?cd/D/#-c9.)ZKLCZ\S[S0Y[TN8bPW-ec@5b5H\T,4
gLeKD\5]Q<aL9;+H2RR^J>\)TEaT0#]SgVbAJYU14&_-UCg-L>N\2W>6&L;;2e4G
3,&@6&[]O-dc/BZH]JZ9UP&73NP:.1F.QU##UVL&..TH&1F(;GF?RNY(#C[W#BHd
fSRee7?#N6M3KOMN?<dWM+:;?WZ(QEL)S#CeZ)4.cSJL],@:>adDP?XB/GR^SaAF
&QT>I^]6&\JKQ+TY)-2-2Jg7W_D-Kbe+#U/<4KTHRaF4E/;0(3KJWd</7199)d[N
J/CI#1d/I<=SU&AO/(M:R;JG2=.842b_d4<[\OMdG8F7]88CMZc_E17MWT+/(dVF
5-cDcQ&L-@19XDWc+=2V(B[O=U02f3#80CNK?Wg2E_DP@1DZ&1g.2)DE;=FA/^3+
6,[6&OSKgOPEP(V3\LSH-^Z0([W\4OCg#I6N<aKJ>DY#@d8F+>a?^>DA3E9A;.87
\>7<).XD(2Y.X?\EZeM&8/X^R1/EA]YJIV2([QN0M4>;_RDc_T-T=LFOTVc+IHPU
:A(Ig6OBYfD2L_c.2+M=QLVa7U_C8Nd98Tf<D2=S:d<:\.)8#J^4=66E3)f6cZ9B
RWC3[V9P_M,AYMR8ce(b^e-RIRd.TJCG7VdaFK4f/T[P,A,^V53eRY/3I[DH04@g
-gg]4?Ne8,SRAeP^A3cbZA9E-F3CFgf,dDD9c^HKQD0U#Wc)7(?]W/@0@5F).[=?
58W(TY2g9LOWAK9NCJa#1>TXRSNL]6@W5\[J,SM&,=Ya\Ecd5].\,SWLLSH2d<Fa
NM,NQ=>GF(\.H;CV:d[.WBGS-[-45HHB@N(U0O@fbQddU3.3TbEHQeXf<+Q2f:fQ
8Q_QSQ\HQ(NS\-9d(3g_/=e<CA<P1Q];f7W&KMAV/0UFRNI:4ZMTN\FBe?\Ad9@P
4e3_?,R6U+5-b=\T:VM0,55RY,FBG1DKI5C.,]R0-MRQ\+/<T\;dJF_945554aRA
)-5I34_<W<.>U3>7#ST:;(RL._f)&?K:U^fN.e4Ha\[2TCgRKBCfdUb;#BV\L/3-
UO+X+N?>_CV3TLO4gEf.4+@U>MOcVQJ7QcW\9/d3KfI,5B@c9E;#_K26_?F9=bc_
=\:?X\_9K2)5CH7TPTU\:NXAH3a(@@KE]38G)K3aVR;BCQ]K0F1@Wb8a4&=/S<#_
eR_;5]#^CN6=PG9@bYg:SF==ZZY9(HD3O+@HEb@SBH)^.>IM_AF9&:9=&,:e6gG3
]8O]=-9M_,6bTBOCKC=8<;gDDBBg?dYbg(Z&Wd+N#,V3C9DQ]](EYeNY_F.T6<Of
KPHH8HI9>;b&94(N,0DYe3e..[SFZYd4>=+JefM(E^^-(X1F2):OLaCYfNdE>CdV
Z#XAUIf7O0d?3.H-dVD,>+G\4C;J(e,Ob\492X7-(NB;Dg()KPZ.P&/X8XK.cf5>
dEW]Bc07e+aY@K5\@P\8>\-#N;&I3<W-YNY-F1UYd[HeR0:@Q5c-#DHSVVLG>e?=
;9U.feW8_B7,+U0DA;c:B421KST=3ZKd1W:6?M/1f?,=:P[c^]c70LD&7[W4UKWT
W-gE5)FJg1:O\1\[:-YfbKGd#/)@bCTIQDHY]&1&9@YJTS#S6@Z:N+g1JT8I#Vbb
\A&_cST8\=-SZ@,W(CRW2C#=JFZG:^^\5fD,E_/HHL72TOd,D?T_Y,_H2/PZ(4YZ
@9++\\D5,,LPPX<<[;7)#W&&U-0X]&=+Y+5MgQ,GD#N4.</ZSaS8K_c_,;VBCFO]
>\CA[(RKP+/[3Q&fgTRUeF?SIEYU?1<N^/<>-G9VF7aag(DV(f&c++0U6N3M,H-A
BA,PG/HRfRMS.3_E=]9>bY7OV4)X&IO_VE)ZOBI+R#b,<-):A,4TRb-N8eJ:>><<
e+J81#_X^RQgF<FAUO4D(@=W88QZ=4fB#<UZSRBCC.P\@ZM1C)b>@T^aG+3@Q\0\
Z9=2YQ)[@G@BG5f(3?))A/d@D=IA:OZ1eGAOD=/f1=_dc4/Bb;K7PN?RBF\(1=[-
?@WF74<>1JVB.E-I99N@Zb36SZX>E9>F#,AJZ@eFeQfW4#U^3@;MX7CSMKQ9T5YG
[g#?S]LX7QM)V(1T;+VA090BC\MXW_a6ZL^--_DIb-VFIGBg\I6H&=+RIJ:(EN:9
,0b?]JCI_B7_[KbS59?FOL@<N)X191HFA?Ug;5Yc(\,:-I^?8c_5EX<caE5U<eA\
(^c._E+d)Z:7&=APW<c[;W+:?e3-\>dGXD[O8PS8.5<HVVQVUI^g^f.GaSb3f1gg
QaM2>MZJ5?GB,CQI^X)c[60UFEG#HHD5S9?IL6O6>],_6bg&B<b0+\QF1Hd+R)RW
6fJfCe?Kee&[X@NJ=[0#?2_,(Y1FRH-90gaR9<2PP+60G.S3);NQ&]e=N.0C,3Jc
Y,9V-(3V#N?)>5XL7;L_]Z#LLWA#6Ie]/4XIb?:NcF@:.Y2SQR,7&ZO&/^7F3Z.\
L#@PXS,&X9IG-^04HYR/P0CG.UaeP;IJ4R#RX2(eCcQ0#B5Nd://M_+8EA_39cFP
W9a7CIBWHDIgG+MFGB)G[g-/:VJARdgCGNZ,4H&M.gAWb1dKNZ5C=ILVTT]Y^d^c
\R#B?D_U6-UQD_Sg/V#bQ3?fgGe5KXQOR&P1F6bIP\-7d]\8b#_a/CO;fZWE>CPK
Y2[#I-[(ReE/[7BG(;e3[5Q2RJCQS<ONZ.V@/ZdedcdVZ&SeL>UG9G0A\W7+bKZ^
gO\3\PbJ8L4/U6@b^).-UQ8.2^1M?b(M)e?U;b?g#Q>&d;1f,HE8#P3,<V=K,#)f
&FLEEba1^N7FWWU9/5>I4PLf]f+JH9Ef\CRMB,3HT/3CcAcHW+a//Y>Me/7>19XR
XXBR:KY.@Q[S/eR+_^_,0X@<Kg5GKITKHbIaI8;GEG^[_Xf-.E<f4E=QZGQ/B+dQ
.1g3.QI;b]6)[Q;?=@2\2]-ODC<M3d=BABJM<>]ZYC9M]UfO/PI?N.-IOCcF6>0;
,EX<_^bBT=dZYD@ZILTB^0H.?dDJbGTAMBU#eK;S@dC\K^0=5^H\Hce_#gGF>LZ&
23W7#GUHEMA8129gDF#V1Q#?X3eb67K(e^PL:Q+W1;HESf08fHZ6T\?-UNFSa6H,
7#6TDN3)^(2HDY-/FeIZOP\JbI)9V9YR8-H_Q5cXP</fOG6OaRBV.2G-_7bUN:J_
G^.6XO1U6V7XN+Eb+3#A]MH_Q<bT)9f3@>.RM,>NQaFc,Kd>TA+3\.>bgL:WT(Tg
E]/ALFRW(R-6LMHF3GNO)E-=#X:\WFUL<XJ/U:fD8+aA:(1KX8]7I:&e)C-b>Y+_
1^+=<b(^[D)89N/Fe&4KXG;QQ(0)NLTX]b_U0OC:F=N32<1UIW_def<#,H<C/Ge<
_VOPc,R_XGgQ>0B-2&Ec+:>d@OB;S[>+M.Z<QE@(P&;,<JeQF398:@c_ZN5[E=PT
OZ@SG;QJP99AW\;0f75UM(;EbV?#>0N1aY=N[I;cbXPZ#)K_-L&.D3W0g@]R8fK_
FQ,_F.VG>O6/3bLQ+M/3_)b(Q?0BaPJ?9/EagL.E..?[<MdO8N>_)1?)B^6R@aA8
;IATVf9NC)Y(@(_E:ef&P71G3ZGA4VB,-,GU1?(Y2<Z,?GU\8bD1g5=.(Z<\2\,[
N9PO-IIR1KFQRcLd#3cQ?KbQ53;S^9V(DBIOYJ10Rf/cNbe9QFdDY.U>5IE(<N#0
QU..0&,CWf_RQbO5B#T:RTKC8_ROLTJ4#,BO&:PF[W,;#_K-U33@N48&V9Ade/ac
fXe.>9?=G2>BG)b,0BK2TFC#aEGXA(6S2UJgD]K)?5>Df[:E^S?./[7&J9K^1)e,
b>:Sg2d6:e:I\H:0c[M[,.&K>BL.[PG_J:HY#1M(:3\_X,;:d(@GTA@Ha<08N6+K
Z#;7&7fBb[IId,W7ZQTG15feMa3Fe(-JAT,dFI[[KJ=S#(M&fgR@(GBBIZBJIM\M
E&eAb3bO?F6T9O9E6WdPOF;<;-D2e)+;[b:bN#[5NC+@4[)dLHFN26X?9V[ENO4]
,?LW8T(>)NJM;bcYDD?#,eeF[/:-gYK&\M(c8>Pe48QKbbIOW_-@C@,;g1\>0WGY
EKX1J0d:<K/074N_eG_3c,bQ>2O1N2ZaB0[77\IW?\T+b+Q>^Z-gEg+BP&9NI9cU
\gK-Y3>MV??ecU\DcFf/GH8C4>NSGOQ\,6,bOH6K\AEgYVD3La;S;/V,W=NBcV1L
=Z9]D#[G1O2-USgZ68:)Ze.)_O6Rg(#RR1=Q3aM17YQIKI]=;A;Ib1(@>UIPYM_d
6L7/b+QU]3)GKTN\-+OJ+@?>S7L.VV+c0S1@@^,H[(DZ)U7LPYP[-K70);-\5dNQ
/F)fFgU-e^^^8c\L=ZZ3LOC\dDBVVY).9cL9aTEG8fQ28=E6,W]f)?e[1M2a81/^
.VF/3;:\=E7(QTfT]BU.:2]CB75L?TH2^YEXJ/S37aQS\8[e8dQb)>^WEFZ<E0PB
^UH63QV;NgcTO9Lc+69SCfC8E#V,K.HOWXUU<XXDM=BFX+_LN>>J+>4IXZ&930Yc
&W7Sg7OMC-4?fE.9?JcJ]0F^;YJ;R)8PH8@R2C6@LO]V[/9VFU.RN2U<,JK3R9H)
g8)V-Ng&35+UAR&Y1[dG-\0R;:ZOFWQ[A/.FW2J=W-E<Mb3;<WUfR#I\FF5e0A>3
=J,@X=_L.,PGS8&898<GQZeXK7a#5O3GY^aYXF^T(&R9APFF9EXJJ,YNY?CN^,YS
/;&dK>?AN#GTN1SP2M-[L2,<,VI,e?<[Wb#+B>6H/aOfD@&L,D+;#EBNX,>,/6bW
2XAFW1e(_T)O-)eGEQ;Af9Z=7R]DLH;O7>4cMC/B,AeZ2YN;JF?J?TCKSJXKN46I
\,(9#[=[+T+J]6@B;L#ENU+3R@BK1KZ<8U.f:FD2XV:TVW>A9IE^+cD]DU+b6;(#
3?SFgZe-52A>&VCA=a._BNW:+<URS+e5E]S4C#]2A@.,&1:e[8Qb[+:FE3VAJPQ9
Y+.g0N9d/#<,LPcU06Eg+M0:^HW8P8/R9X.9d^FgRS-RdJ>C)B0[??@gW6NO\a&#
@9G00Ge?.0c)#Kea_8R@)T\RdHg,12P3=4O06U].?SGC.3-VJRdDb4c^/_+&.fVa
Y)A^LZg3H.,@;[b;1X6.B9M7Se9J9IdW#d^[Z;?B>e6L_ddK@(<I0ZU1<N>A:aaB
];PggC1_;VW47417e@D#YZ]@>M9;LE;H/^3=TH9KV2?.fcHb\/Va9+-@a+8J9>>_
[^9SB-U>Xd&a662(ACS_^4;X998;[<2O?d0UP6Vf6MT0O\Gb@-95L;J+>@eWe-<<
MXbTOP4]S5c(7K/EP.Pf7/P@8\CU7JY0OUZJ0)f83ATCVIa^HR#QM;TZLQXZ(2W-
L.eDQX,]\FD9ZF;+,Dd#WPW92a@L4(7T_&,a2faY<S0+6dV9+UA3#>0N9LY6[2f)
2IM=Z?P1PT4ASa@&AbXK6WCJ.R:D?YGdL0#1CTMb43VY1eH[^._Y.2KEYe0+(=#b
]Xa&d148dCg(Z\HS+&WL@V@f41&OWQ3\^595_(DA7YOG1WDEV&f66>2UF)LOAK,Q
6M+Rb1[C(g0dbUG>VT6QEI_I=\Yc3N:L26:6M+;>L_(Q319ZT4\a6L1F@GVI47a5
8K.)_=ZOUVIN9b<JAF3UU.Y9=bFJ1aR]G5fYe?9:WK>cA\2\.JOE74Ua[,WR[_##
AS_@XcC:;;33Cc[4;)ZCYgG235QEL33BGX&QbFSfNDV4PLebZaeMD94V+A=]G:f6
V^6OM\^PIOKb((UKf;V(,fU2dO2ZKV56?PG;F@7HO4a>>U7D29M^cMN0J6T/)P&^
7O>6_:.K0,D.X2W[YO?.c+P_&g/\dC-V_XD>e->@VNNX_X2@7YNDD\]3J.ERgEAX
8JM\N.TH=O9_+77cH3JUY=P7eeB\D:DF;g-79d9DY]U:6f.ZOBH]_C=K>6F-@R&4
J06feE/HNFEI>&1:QYYJc+4_/=Z.CFd[58U;_,N2PDE_>@^R-VT^E^=c:d+I]C<(
-H.SCafQe]C5P^b?^FC+)003@USgIZ;NGW749B:BZK4A53V1N>E\)K>0[5A7?Md/
D;S&]3U#/23:S/R+AQ89,>_XD0+PCag<8eG]0C#69gE7\VA5&K1_b5cVTE:FH[LS
=gY_F/+PG6-918>a78#,7D(Uf\E.YX&@?D-?--J0gc:3U/RFP:OOc:>Odb7ZT.Bb
?(3?b;70ZOf#YXT^HdAIFPT8O1P5K>e:X8(N>?@,=?V0EG_AUL(K_E5JRP:/0WM)Q$
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
V0EUf+AI,.+f8]<A8W?E83X>)_>c)B5P-67Y(L6A4:Y,.8=I&&Le8PQ)8eAK-5>M
eGE&NF9.Y:#1bd&P&OY000TFAWaJdCX12U\6:W9B.8^I:A)2gOHV^Y75<CK9VP[E
8Ng3=_FKGb)<4[56RBTL&;H662gVF2382AU(W<^84K</Uc>E.8H[fU8G1KAbPT#:
C/C@S\#.UF&>^:@(,PH7e644FD=7eI=;:ATGe/-74R[#Ua+3>9K_[JQPKX8?&dVc
AW>RfGcZES&#D1&/735FELeFRgDTAPQ)SE-I#gfNZ;GGF,L]:#94<=cdMaJ:...Z
V/+@9TZM8TDH6^,QU8+C6FN]-A>JL>Pge0Z]Le1A&eGg+.:#G:?X76a#K@;)YF;(
TH9NK_K>G2GO(W)S?RH6(+SDaXX\2:U>ggS#IN@A7YRCf5EgEQWFf(]8M52aD&5/
>L]dS#&)[dDV3TD3F/M]TXI]JL8bK[&^;3T^Oc9a7BKT5<Z7;/N#f_MIcQF>#6[6
T->aY[L#1#TK?9UISIM#;6::KaM:Kc;D_+7>LW&)e06Y6N)RD_^\J3EgWTYc[c]b
]a]/&e[??Qf>PJ4&<:b6.Z&f@C92)<dPcL/c)\P2?)QE]TURdVGBM2(?<A2;ba[3
J4&)HTF(Y)>+(I-f:?Z4bf\PY@g;EL6.?V7]ITRNd\)-LREMBI(W[J=DGVZ]^[5.
g?Z_cGZ&,OJM]/Ua75gYf-2-d1f2,G3U0WgJCM>A9dQGaIeg-C6&+Ng<Q=\D6J>2
8\7K0Zc^[Z/0dKgV)EYRHH-_gTg:IScN<W.1eccbF5a7cR89O43NDP)#.NV+G[(3
F8[/^OfcG[0;F07)_KZ_LVQHg#3.<P5.Y0cE.<bQWAb:[8#>#=KO7@T+F4Md]<5S
KaB6c)A=YDR1V5-S4715(V]K,,X<ae7FV,KfUS2IBCUaM.Aad/;AUYL+N&\0V8f\
-@dR+_PGH24X+A=1Hd2IcJTL542PE57YBBf=)0CI5O^@(Zc58IIHJ,37M9,WQU&X
Kd(]ED97.Ja\X]6-6IJQAN865A61JHaFRc&:8JGC_bU;2aGc,/:N8N6:O4UaQ8-K
L5BN.XN>>9S>3YD6.Z2BNQ&?BJY1Ad4b)N(.ef,[=_H=<RY=5PX1aFG</>ada\7c
C&3&DFe9HCU-P_AJ5(_Y-1:Q7dP7BS7bDSfZ<Z#)T)X^)/dH9IS(F1RH;cCP/T3H
b2+85K2)P/?QW6(E-d=^+Q+XPFL5=Z82^.cWT<8M?U8=:0JUSg,d=XQ-F,.3D+<)
++,bg7O6?6BWJ)H540?@a@>5X^W@e=Z>3FO+(Gf,LVO^)1,M66FJ39NHNC4(#6bT
W/J]O5_ff?SR46QEDY]EQ7PC1ZH[5SN2NL0,/3Pf&8.H:P](3d:_?CZD&<65=GfC
C3O33<JH\/GI,;M=cFKM<-KTVM?C]NFZR/,]BI#<[LPNSM;<+<Oe74AW1XQf9g8d
Vfb&,]3^(4:[?bK4EF86SV;EaK-=TE-f9#34Oc0abIFX4KF8]E#<SYG<8MRT\2DG
fN(dHQC8>-YU+TTKGX.:,,-YeFE9)Gf5;X28Y^Af,)IcebWJ-]_:3V)<ebQNac/V
YKf1a^UB0,,VeAXRJL1&Ig]9J)9D;)[d389Ce4QT@=O-W.#9Z^R#TaK=eX7<C((+
B(1;CDU4),Z+^D[&]a@M8>Ce(4eZ@6bUcc0^DN[8J7[2SYVOHbGd.)#_([ML5,3C
Hg\dDb2Gd4P<=VQBW_#\P605NGUR=JG^T5662:TTE:&1(\dZc.]T-J95:B?g,Z__
D:3,GgUPd=#\UNM9gR=SDNC[8Q<LbdTcFN[Ba?2^10IcN571^SL0^(92?@5W?IIC
+/Q[Q<9#.5^LO>((5K@TL;Z3g[d?+NPa6W_&9R=V/B7@FJ]&8131YOGd,T=Y/W;e
a,SC:M60P1?GGaW^46-,d(;cCV(G@,O<E>,C-A-O>ePX.R]>6CGSa9&6,I^T_R&b
())R(FEeTcf1:##MeN0I\8MHTM4)<cZMHDbgd#@?SGMAgE3(LR]6bQ:RY0S;7eSc
VTa^9+\L5C_dQ0[O],g)+;#DH)5PUYG52YH9D8_6XR2.K)Y;TR4\#4WB<8L^aX3^
G+?:^+@)-S]<cH#Z:0KM7ENTI9L_<T3^@)CCa=;KF0177bERc9cELCc\S37#=<>S
]VQ\3;f,;a^)_gcE7Mb6ZZDTK]><=Y,^S(fEU?AP_D8@3;T^JY4HEW(R<7HE8f]3
9_V.0aE]d+YLI-NK7UEVbAW).?EJGYNLF:R/LAf\Yg>B,Bf6NP1KE@R<H,JQ06Y^
PJLI1Mc:F\Y\JQEBRL#a,G3SeWC#U1?3?f\a0W3@<e?BATLZ1>-&2a:Za.6I[4?(
LZ<ZEW]4GV:MM]0,ee,eA,6Z8HWV)&7/5:dHO[a(?b@S>VNa\XOH@2/1;XE?;FB1
&K;M?+g^WJCcNWRg95)@[,4e&8<:H_I3^94Y^cH4N0O=?eD#dK.\?NS>7ac6XKM)
C#>7NI2PL\_25aL^M8;dO\P39)_I32O0J>=e\JK1OKA)NK-+#OM#b=KZAPFPV^P[
T_=g7&LOR91RL96(dQU?.K&T1MM\;AF:-,F6NRR,.8FVLb&M/JfO<W>9Q7N.eHKL
E7],GL5b1WBAe,5;5]cA<^^7-572@g4McI#GV/bZ]XLQe2].7a[eH@O,X]dN6cae
U/V#Pec>Z.;AbPG?#Se<P:WM6^c1(8?0A-AY,@S_I>beL]-8LRHR007(SD0cWd)/
_Za7+F6>;7gK8<9,_@DKN6I&fCCFG3J+CGS4^.8W:T(:Q\)TKG>P>cgEK2_[AS.(
V4e?(,I08agDYP]4H,PO07B#_80X^<IR]Oc#RT&9LU<.aE+LB]S:@(WQYC@_3&83
.?D=_YF3=D8ZOZ^Sc@Q;.-3W3E;48?aBYZ?>d2bCAbdCcV717)H)LYYNUc2RY&6?
2@Q)(d#8Wa.PU(U&,5A(&H5^&BgF5KaJ@MMM;KW#SfC;05EAYRa4XYC<c.67U)<5
+H_K20e#^a76JU2L;)4^>5_JNN1@9B_6KZT;R)=MQI7FKIX)(GGgYL,R\-;:=^3W
d;\ZC[gP3-SQ5O6A7<U(CaB8Ue^LE]9<=9TQg7T7OYaSMZ0gVZaGOcc::.,(+Qd_
^<U]=.12654\#US-<aeR0[P.aIBOPdO[K=KZHAWE&a8/<KER,aK^1eO@&5;?&^K)
_D,bEeK68W]2R-P7)gKMQSfb;:29;)B0:T/MWc50:Q13?d7;=0\V2)YNP>,N2H?-
B,4Y]\(13b>W#6VSf8DbK>9ZJ:M_@6A/LA-C,d+a2g;4BFG7BEH:E6DJ6:OcC@TO
\+^(/XTaNaeBO#<VY)SMS._(IW3g6N+:#(Z[@Q;:Gc<AF>cf5Wgc5HDJL$
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
62Y9M1)<#)B>8WMN=UM),?;E<.(D9@-;<Wb0(gR0)QQDE7MLcH-8)17U)M0.8.9G
=(\gR\/d#K/cPe.FCJ/[KK5J#@-Y8=.c,KgCZ+g>eNA,IVf3<Bg./4+bJ/03G7T;
4DaQ4W6gW.Dg.CKJZ#GT&.F7,d0H5;S<@R4)fD]fe4#;JD8aHc7^?.LA3QXK^G@9
.\dEM-MQ_cYe[BQb<KSVgRbRaf<8I(XJX+g<f&.:M_3)=INPG=OC_UXY:@6c:OQ=
].T&b;L:f9P3:.+;Q#[Z2DGbOaAJ,YfE=7Z,gC8eH9&>#>dH/fGbI>/?SMLU^=E2
,OF&[Z);X/_YD;9(AM]5[[RE0YXd0ef@V^V6?9\IK=#+?X#GLSg?W?0@^g\6A2&,
ZdE1&V[IZbgZ.&Y#QYWI#-GQUSA-5b#;_,gFDH&/^@IgH;:3/8\3608:C\<.J<(9
#VM:cRV^<abT@HDQ@aS6a5)>_3^d&+PL9W876f?/K_RNK#760e\f&SY=^gK+Q^=>
cM<PBRdb=feW6X2O+dSeR8e,De]NJ53_,+aX8-#e4bHcO)e72DY3R<C10<WZ6(4N
c^6KKgBD&@aJX#@6V\?ECL&7(D4-OEf<_0^?>fSWP&X3\=JD=9LRV-e5LbZVRV_Y
)2cOG^EI1>4W+8MO[:5A)(YHG/9?/TG-D7LBI0O]D;&>IDa.8L94M[,2X2YK&O(f
f4C1BN?aQ_ZK3Pf:P9)67@U1?[fHX13B>;5a0ED3^HZSVRUbE;ZXb<38\W68AD?_
D,OTWP6&HFYULV+FL+C30HU>>Ld0O;/.STLDF]P;Y&D9N51Ee387ZFAY.&Y+5g1(
5@_B>Qb@9caI/@Q42GPQ\+IT)#/a9Bf)8K[L<W1/;?2)2\:+J/K?3>GS+4>7F>9\
VdMXD5eUX01A8Rc^Vfd>^7TQ2R[+b,Y=fX/Ygag/FODK__+SEaS>3OR,\Z+M-I-(
1E>f-64T^0V/N-f\XcVD=T9FZ1d=-/T+<bND+@._UK,7Z+PFL176];eT0N2.)/1O
NcfLDe=Wb=)[39]H9</2O=D#<1\]VBXeH8LRfQS?<P/J.H2RKGAO[1@PBdXO&M&V
dWGCgd9U<-c)^Lf8]+O])28]cAVg4R^UgF]K6\DYEd<eW7SNd&>)Qg>5N]EX:ec2
P(-Hc4b61EJfZ0>=O6-PU;#UJ0.^Jb,F=XGC[7FLVQ_J:(E=4H35K?S:Vb67,NC4
MOC]CT8&gO_cK_?4=P:J)CM6BGB[LTO2LTDB>CRNCE^#&L\7AfUb>O:#U^GOcA0]
2NY-a>=P@;:dA[,]56b1G98<P\C]-FON#/AYdfPO2NOBc3\6TZV^00_&)#N::-R-
5fSMBWND@0-gK58<Rd4C86:5:fBS,O9R92c.FK==\E+[d^#\+97NTc,-Ta&#LT;7
HJ_a)d4E5D>8XR@&,?6;R&>3@[4@:81AA5OZM8gVfL>e/a.4E4d#_(:QZHN0D]AK
E-UPA@PO8\4]6gRedG1Gdc0;C\:THEPV0QA)1:_KcH5S8=6&9DHH^T\B7:.:N)[e
V,&T78BeW\+]PC&<&21/;,V))QZ_:ID&T+B<^E3]Kc#_E;?G>bZ(d-P(J[K+/H?C
<8fg\:cZC>-S52)JFD_b5If>/aSJEaH+c9WJ:f56]I^3KS,JG1O.KUZ_DP5(F@X4
)bb99C<E/3^AC5Rg_-<gRXZ^<:5]2L(CR#1V[6Z[A]3,Q)]ENS<Hf;+^KR7SXAaL
Vg0eJ3K:F\AP+Q=aU[bX;_L8EJ-P5Z;W:ULLZFFK,VQ<5VJWZ3bc_N2ICCGB_W]>
D#\SdKH_F4N2O8]VLeU8d/aK2a(#OTS)bd:]0M:W[d^,KT:NN5M1LP0)dLSE]6>C
&F@<9Y-6?7[cR6ac.[IUVYO4S2^VXCG+(1?]^+NN1GSL#JW;QS5GTQ>_TfZF06fQ
]G12cI3=<R[c3YP__??YI;/?DJ&T3R-7Y.)J9.gUF?-AIFU4DS]ObZf)^I,X\:W/
\HTES/CI).PBAfH_eS\5E#_c(W:QI[89e&K(B@HU8N/+G^db5XI#MZL1T\:OGU65
9V3J/&#1Z:79ZYPYMR=?+BVLW_+Q=USZEPNdJB.?DcWf::FaMdD7[8c:5<#3YK&?
R3GPX@_8:f.9XH7DgNVAM2/dg[&EGd<&JG&5Ge0>A4V.?_0?SH-[Yd77aP]L5)<U
70+C5E(4TX0\T;2\05JLUTI(+WZ8d/1BW50\9Ib4B4XJW7HD3c;Nd2a:WJEIZ&HX
)gS<SYG5EHW,]Df:G.E)4,ZF?A7#.Z6&P5:1FPLfU)dG\QIc&E#9Y7X-/#G1&6fB
S-YF48):EHegK,HKX/5Z7106UB@HHVO0gA8HQ2LXUZ<CT;DBMF#V=AV6;(cOO17[
HHNaR4cffYgg<g:3,4S?O6#&&#ga_ZU68PA(XR+P&_f3MYLg22cO[#85#(87XNFS
g^EPV[3BDX_]ZbA/Z@_UDG;@,DeN56<ZUaXP>,.F.CRKKX@-c(.C@cT)NJJ/#99N
YED2^88ILT>ARINa85#HK-=0_U3J=U+=H4V)\RH<&TMKC$
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
]:+?16.Y):-.9X4/-51@&FX(<eAg-0Ue,-]4=:@fDS=XH-?^Yb=&8#9U9P,(-6Y3
=39?BM,g1;3TEO;U>]U[E_aQBJVRC+#eZ&d(\.B0ObZ9c0I8_TR8\>=Ze;-Jabf=
X-,\<Uc&NN)G&F1@J25X6:cU_g813MD9&ZeZM+IX9KV>Gf#KFD1NS=NUM-LSC]_:
AA(H<54.Fd+?U1d:^e+#VFFD]8[HM_0KYZAG5T)6-Ka1ZY(,DW/Q8Q3C2US:RbRa
5cO2B<cES&>)TR<SVW6/a+UHC4\e[AYFVV6U9#M8&O.IL.ID1CA+AU_,D_?D^gO3
S;5aGHf]eN1<J=H/T93JI7e4B7D_V+&?]]_LGDMMOf_=ANH@L_)/f:;Cbe&KZNY]
TI],f-76@G_?fG:CX:#Pc.1YWSFX2HEMUbDdGeV9\2OH_,I,b-X/A(fK.d8H-e9R
^>:T._BKf+4>6>0e<YFb+K>CC0R]f]E0X1FE^4T<VH)L=eKL?>0)]?d<^],>^5JN
&&J.aA8Q.-e?=@53;-+PfKN@gM<O/a,T@^=+6&eY9LXe6ZWcR,b-91e9TXM&:^eY
+a?O6[,)4;&=7V,]RE.FCN_Z-^;+TNQWb^9^U2OWO:R7]HK9M5.+[IgO2Y,cQFfg
eVYP6PDf=EC:BUf@D&43/^3.[YU\AZ75[bW24@dLdTLSJ-ZA/V#FI>S48Z@0<P&b
NPP<.2ZJN0+01](Qcg4ARg(\G4<+44[B>&4dLF^#HSW3#,>Z](47)VFa]a(NM3^g
)V_G;L6W-g7-;UfU6\=+.U;4Je?K1Hb-PKg9fA9cRHF_AXWL)fXQHI0\#IOC:U0-
eL6]FOJ04PD3d2Md8Z:(2&_GUYWUZ7,8EG,?AUF4dG#7XD<7V\Ya\e5?2?DHX>g;
Oc8eE<a)?A2^D&AVS#CFBIP^Qd,EJcLLRP<X,FHDAKIHWCb^?VM@2E6&>5,[SIK6
Fe7GR\/O@.+?Y^D2Q#7]M@J?9SBd>]S>gQ)J9&CNZAF-&+@B9)^WC</S/[AX3aWA
]NG\eW)A,^EE[A4g^Te3)b_Y_EC]]2F>2KYK:@HGee09X=K>?+3#BY8X[6P<?AIE
/\N-<+22NdJM,D>-O76^0IUJ5ERfQ=g4Of^ACb8,;P86g9Y[f>cU;E/9IT<B;dNP
;Y58K6SfH;X,8K0PK.A1ebZ@#=-4]JDNYQS^@C[^4/?M7d_cYN=3]b[]E1&1A,(f
\@JV03GRT?G<]9?)X.?(S(/^L\FZ1:M@AL?E/e=UgcGb+_/=J&2ID]I/&12[QD-A
-_<\XJCRRER)YEU(C@WZDa^PI@Fc:=04Sd[36-TV;a)L&)0(4XD^_>/[8R8QRJd)
,ELY1#@,1B5F.MCf627)UB,_8A96GB_,125eBN]L69QSC782H8/BGUJ+1M+9g7eY
^BE(dAS/OWGLZ_-L<BA9c6.:J.X:^2SPa0?7.\SS[#J]#KY4(K(ON6G=a30@1eFE
aYA<&)]KB14S&>fGKR84<N0:7GYX/^SH+JFaNUBa4K484bJe#E;B=DWKSWYg<UEd
^&LeOEOF1><F;gTY<,bK?TOH3AAN\74bJINQBC;)eMA<4D1dE?3b].7^Ac15/3,H
7\B/EAcZ961UZ]T<A,_7U4G.C,8aRR\<U?G\YBL8=U9fJ.A=,gQ_Re,&>2IKD428
7S@aAeHM(\g2?^.W[Ke;WQT/#FQ.@ZV0Tg=^_0[8?H[,DS^U4E3&b<6C>/.+C(]^
AY=4b[P@[<KUZ8+WM+.QSU_SM8?7?f(NEaTTN<J_BO7H?2YCQWg2;VWPL=?1gXga
[Z=Z)g)IX46&:G^[)d0UIFRDU_9PS3[]KJ>)g(K8d,YdNd,N>N6G3aeN4O1116e^
cf5)8\29\+g]P6TA=8bBR_VTa7/ET?dQA?;P@>#E-]3H->3U&#=0Y7IgdIO6d+.@
6&LOW77-&gd(=8U-GA>>D&IW:BUKee_VPYa2ZZ1]\=9:W26ZagdGd?X??Z68YT<L
K+D1_+A+#OK-g7WK0NN@aII>G/KK\Md;/P4D(GBc4W5.G/Y+MEK=f[ggaV.M:bXR
XNB[)O7_T9H\V#(R3MgX][ADRG65e?:_M#UCDCb;\S;Zd&,X:L,?]V^7Ie2&g_:\
g]VaUT?]HD?CTQ\Bc[Ib5f10c&E]TQ9Fa\MAfK@(Y,9L_.d[F&7F>BW.24c<[,8C
Q\E,Jd)S=K4dLF(CUSDd4<GO]Z)[d=gSV<KJHbT)]?Q0#<e1PBb_0J52YW;YM?M=
RDC:X@\Ma[>5++N@&g1E8MZcJS&>.Y8Ba_-YLg2_KL4b5:\.]EB2J^\@]ZT>5+J2
g35YK=9[bBI7AHL#@U,Ce::=/HRVb)3SX2FIP/@/3(:0-e1MRF^:1I;&@H^)g<5,
_I9E++1LNc/Ja4Z.Ie4O^8]d)&[bb6\eK\+B<C;UA2cZL7GS\HTaIBL]HRF3IM_?
:D;O,5\dWEAZ5=]HM=>)YM^NJ[@fZf_J54DS69;^R;?=NbW^9:6+f01R7VRb99gC
S](507DJQA9:N&<Lad4fZ8L7KJ#,[+(Q6]5)N?,dN.)YN(,1@\?D>bJY)EETH(V>
gP+K]4&D8cA)IeC[-T_<)#TC+@KI01FE53)eQg>XJ>]P8@67)YX&YgGad>H&PDFH
d8+^X6Q0aG/Z<Pg##33).Q2FbDFc#6SON@5ZO)bMc(dYO_a38(&8WcB5Qd@<Q[cC
fU^fE[@(H;>Ca5d\dDMWFZUJ;:-C=&DeU(JBD4:f]/<(Wb+M&8a7I2T^0dDcN09;
DQ5OZE+_Fb_e0FWS@EEII#U93aQ[b;fC1:cQP57F3-?.?AZ:(@]V8U8&A5L05gP,
@W7G:OgP@gaTZJ/>HOc.7/cc+3D6c;FM7]R^g_HH&4>B@?)/a2F=[MZ[DJb_1;1<
APVM.a<-\Q6[e9B)-/cC37()VG_>X>edT?[15/eWJ=ae?D8gQ++6^O6#5,AG)6IM
&XXf#TW4=cFTW/gA,K4D4_/+=)(/.UecFa)d+N#+.Icf##_gUIZb49IWXRVC7<JH
<D8UfL=<LK(a3W&@d^8.-O>-f#/OX=DGU_1XNOc[H>d12fXXbRa9<TL-AM6.UM(U
9d6H;Rg--(B>dAXV46=CX@,+[Q1I,B-(;3)eET,[VV,6S<G(D?Q,?Vg-3f/86<50
\-[SLF0,2S5Idg0D2RAGBGUc&^6POZJd&D+[U7aPcg#;,:P7LT)K-EOTB5_bP)>F
@/<NX(ME-W.d(9.?bOG?KcE=,0f=0\c1;EJ/a_ZTW2A#aTaC02>?c0?C+aZ8B8(#
3(D=^M,B1US9L#9U@Y;\X4gXc0_QP,GefXH3V:e[,FDA=;LRAIQB-2BUMO]--D+0
F2YCLc_eF;aN)4ND7S335O/34JR918<A7\GDN[NX)LGG_0]Fg9VP_BENVYGde.^U
M0)HA@#A&CS^=W3JDP\:Z-V)UN]<QL-Y5[C8AWJ<7MWPI9&dFcXS(:WCWBKNQVA+
<)c9WTGe^WPNA@?g<=PUQT)<A5DW;ONe,:bZ?LO9&FEc,P1AN^:)NfC\gOM#J>6]
3A^FR3Zb-?XN]+QHT<FBZb09aB)B#Cg0cV9:fI>56N5+@TJ-#O2Ocb;:6T34HNTd
OM#>EN&;#_U(#@I>MR(5>-(gEQZ)42XUQ,-K:bY3U=YKUZ>S5&MKX6TWS#Q=YPaa
.+C>H43DCXYO-81aL#+0;ZaWNX69+aKS0@gA<R?65e#LGdQAWD.PN-c4(a6-K&+L
/9E^S7W(TA22(Ff5@ee^Gg?)^]9H>VU#BHbe5=I9V;04?EYeV0A4O7L8g=OEP-Bb
<4+VZ3:JX8T9Sf1)X;1(-PGcbG@\e3<)DHQ^Xa\T7EAX:f\AW;J;G.1XMa;6E.[E
KL]BM3L3#M5BD:=(\S\0Y9;+.I@S0U4H-[e[=D6Cf_R0P[1?:-eHKI)?M\D2N1FH
b]fUaa)MF1?F<^;RF&d7#]6DF6WHg8<?YeY>C__6C_4>I0R_-d7Z:PE&Fb,=^Rd<
a6\B8UQH[E)cL^?92+_2UdaeOac.X=0[WQ+\60]JeH_aMP+9-HYE.FBRe8QXN^KJ
Z5d(;=I5d]N)1eGVLPfT=SWIN=-J:/\HTf)P2ICe7O0,,&Vc/eA5^E>@3X_QZRUM
?S@#]Nfc):AMEQ8XVKc<6bc;0U=3KK-FSBeTLQe50K6:cSEXCF962+S2QLF2PMB8
._,\.caUb#;<.#5cS,;\Q^ZA<1M46_EL^RG0O<(UT,de0=^>M@\WB6@.6T.Id?Ef
RHf6S<WXQaHGMSKEH-8V2g<\>g/@a,AIKWON1?+ZCe-gOUA4P.Z28>d?TRPM/QAA
bg7G?42>[D<gKUDMcD2;<]8gbTMYc4NVJf=6]5GXSO=A\IVC.RFF[R^d_,;^96@(
SK:0]9\a[[@Z#+c.Sc.A-e0R<66Y0H+RR;)+aS\>(..N&Y\/J>YS9VUKe-3^HGd7
,+@AF<#^d+],,a#.fP2SO>N5AKUUO+#M?fD<]f./bb,?#@9+B=1FbN4JZUb@>W=9
LC#Cc[GFZGR^PNe9ZVS[V?CE77/)U)@G(.A_PJ\ECJdf-d/3_f4H7N^8F.)GR?KF
-Mc,g([4b^+b,::E;CX2dXaNdI1\dAf1EWX4SI8\+WcGE/B)[BW<LYA=5B1JKWVf
>FCGCWbE6]33Q6d^1C]4#4/\@-Y/X@G8OE>M5(b+_OaIdKJZB8K4D,\::g_BY;(C
@e&=)5S+-G0C7gb?N;BaZ:?:B(9f<XD?[##;Y6:E=EOP9PPbd+C&8/W_7>I-7?8N
TD>JIGdO-MOPMJG]J)^]QOSXK3d3LC&_N&01bXPU-_\_[>2AcSeTWY^PRFb&&8I:
>F7#B^8MAV5+;L_Kd[G2TVBR5C1/9,TOIJBH5NL(KKX.2Cd:L\\G_T:)BRL=FRB2
+g]<f:FBAbI+(3W#U.P\)S,9^SD?4U;aT.Mc>)0KgZQL:6T4OFcJW[F=P.WJC(b1
(W8?<PFT)C8@@=[5aQF1e=A]/H8LB2T(S\F=B-ASE5#dU&e7?)#&ZZ79)#YK--d>
S33\UUP9b;GR+2]]8U(]7U1DB=,(>KL;@_8U.4B8>X8EBZfVb5R9Ia1aGNf<D]IN
WAd6WN\;f8^:2I1VLC3;S:HaLLB[B59/3A.@&Z)NN3MRcL##]c>U.CZRf-83X0<c
+B.=39a(ME]:S=#^3T5@&-@3;JX8:W2^<Zb=c5c,J+3QILT=YfDY7dG(0CBJ@6a;
/IS=;;&Bc_Z4BWPDTBTBB)7.g+YFSO+Y(\[/DB9Acb];EHU[4QBg-Kg,:c0OW]8G
RNX5V&[[B/cEMa+EY00\RHA>+aE&NKa2=\3HOEQE\H^[239XbKHEOU8FAYKTD3bD
cN5UX-UH8ERJ45b>]KBGV5Zg>H(>2@4E,+d1-(&8;/f?OEU[a^AZD(H0MfBX-CO;
TH,8&IQEGCLLV#FTD<cRC-D/LfS4EM(+,caa6Y:eVLFbU<:WJ#U+96=Dc5Q^QUc5
Ha67BB6]0a&/H\,)Md#-UBLQ.JaBU7PSd^E:/g+-NRg8>QO=K9g2C)YUUQHH=CBD
YeDK6B0NB9I2FHDebAa)0f0BccI&@)fZVb)7+EEXJ?[:^)CBe=T7^QRKQeSLPZR8
fJVSdCKA@Jcc;3<\0A#BMc)N8Wb0U&W0gL>C8U(0.+gC:d<,D;I2H@:P(eAbL@85
7DEY[ILD;g7@5aWT_[9K2[(<+Qc_5c2=:F7W(NC\5]ba\39K26>29b:/NIZY-AcF
])fE5.HCT/VODU/7U5Z(AX2435FBR(DadFE6;B7gYbL+KP(3-W,5)#:/J$
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
DHP9UDYH<K?X@Y(P<4/),-Ce86\O=GgS8F#08RJ9F5gBf,./USK[<\^,,[0#<C<.
#7P0=b,N]IAMf#dP-7J(FKS#L>OTgTTe[b3ZX7Nd[\a&c:,dE9MB/1@[_-#1U5La
GZJa78EJ(d[/]O&U:XMH-g3/<(9IWJ?=FAJF4TgT1_:[5E]/]g/c^R>M9(EVgQ;G
?/?FgTF#;,\:G5;+ff9P]b.;DZQ?0P17X_ORAeZ0.B5/\_>CFGN6Z\\d(,F2a=a\
a,b4#JdVXYH@E/-/,c-fN9f,.]^V+?>^J&BP(2>ZO[b/@PXXC(UPTC801LU7b61F
NVB.^H#R5/-3c4JYVJTILFH[.e;a4NO2N7f335G,@7?Jgd#VT^VPPL^D7>a.PB:[
A_+32c.68V<UD)F#0>_g8FP2A(55b/:;^8I-V14XG;f@de::bA#&^+.<8<8L)_g?
aT+59]C^SG3RPP-5?C6L46NfH+^gcGBYZ===G;Rf1OgHCZ-499<V2T0Ldg^eD)@&
57M;fXa0036C@XD.,R3S<J/@]3d+cG2NPa(5a=(DLHBA_VKb-HR2)Q._JQ;7R++Z
4&O_75S?EEb-2\b2JAPE@C8e6WPLPBX3NY<I5I6C>,E]d6a?@H\NIT=D?VTN5&J8
0TJ>(.;+e]&@-b\=>4;)dAR377K4K>?1(D8:[b<g0-\:KbOBDUW4M2W4&52-@a.Q
U^,F5(.EQT)^96/3d<cIbQ^-P.QSHEHO3e(Zcb6fI,NgYb6?Lb<);+98X7/.WKC6
P\YdFNB=<fF(d4aD)=XP]<.ZZV[\^T4gS&C>@(:ZbALa[MR.^YeUP9E3,8Bd[_7>
)Pc+G2J.ENJC<]_RG092IFf22+5g0Q:9(N@gX5]?ZEQ1+V_^US:P]dN[+g1>8#^M
E[KTF,P&&g)+EG(VSA8Tb(f8QEW1YBD5XG3@cIAD2T(4M1BX+?0DA6-;L7BgS#L^
9-M<OK_BV#RPIE_.L/Ma=BfN_WV02/6;2a:>e4^+B?cNEfA247EKJSPIbCA=<1/[
ERcZ/J=U8YY]9,TZI89@W>=3JSP/Y<I2=A8L\\b(M[f9.3[KC>O]0=L]QHE8120(
<ZUMfQUGbdJVd7fVTd.F-2Y0MU#J)8DRJ[H@97@,>T3AY@[FLXZg.C@GISB;EZd.
Hd0#]M6258I;G+QX-BWb:02SJE#1:C4GAQR,.\?N]R0T8>#M/S73BRGed#gT=]_c
][2S\gF@1A+RLQ,cM=BCbTe0F>+ZET@6P>(KSP=c:?1DS#aMI\/:1[DLYFOaQ\P2
/:c+(PTA4:MP&cBN2bL/6,/I+S<ZO+DU&ASd0(HA.HF;H0.\eT7/Z3XYAD@\48f#
V.5V/U+LH<@T<GNN[AN-/[G9F[,(AK(LKGKdA>:OH&?c8YYW9)Rc^dZceO<@9Z^b
8Mcf9,1X&CR_<R]9caJ(0(<NGYRV<TcN855g=4G>#b>/>RTR(d32.JG)#.K4(=c5
FM6RfL]XZCe5G:1M_P[dCYMLWJd/fJKGcdeWe&QWXH#SH<1UCcVVN6]b\T/Ec;B<
]+)/-BSRZ7a<,_8Z>cRe92&&JS0Zc\_/Y6+TEbKJI3,CENI2<:RY=dCI&J^Heg#G
[7---UcASa&HPA_2N\eV;J+/7FF)g10Nc+4b.#;?6f-;D5)IMI8f[UcHEL]9M75P
8ab7K_Xc/ZLS3Gb8JBNI6<^:>^J1,8[F4P_Lba?(L\K2[(;&OdV2AS:g<_Z#KDYE
[<&F?=C\O,bgV72#:/]#1T].0D4B?>?[PYWc0Ae+W+<Q<UBEa8,<=WUBC2E4\5c4
FSggT4J9VY6g/O(aV;\WGag#3#<c@eQ8a?25fBZGTZ(;T.MJ)9f@4:)3:<V@C\X]
/?UgKL-Y+]Zg0M)e</TFA:943-JM<0-_>:Y?HFcQW<9D-CP07c#5D0f6:G7#I#DH
#;0D,)>=-O4HSCYED4AT@T,[/OQ30OZZa3dSeb_]C[0bJI<T;=(Y&3EG6[f/b/9Y
J982)D_Ag)862^dL#@dMWY:99I-.1aLRK+?RW/UO1XW+dA(WecLeJ51IV/.b]BVF
9-9^-^e3BNH,6-7bK+TZ](JX(3G6F^K=MDFf0]#RIB&>/(A]cFI^b6G&5H;V[1[M
.BO+(d\><,2BE@WB963/Uf]b9ED45RI#840d8C,F9,4&#[XEO4LG?B2a78b4O,<\
d8(Y6KI(#>[UTHC8c3^>-X,cG8A^Y2.)[ZC,52QWWS-&8bL]?&a_BLC;+;Q^M8Yg
@@cFJ&)Cdc)U0$
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
