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
`define MOB30V
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
G[5RJ[WYQRKR-;Y,9H_^<UGU,09A=)c;,?dV)OMPC<a8g&FbSg]F(WYB9/;69Q;#
-VY0XZVMC7e&S@&.C_97_a^:g@(>YNe)+Ie)bI?^C-EJ0(X2;6\Ed<EW^<Z_LX[Y
HB[R_S+7TX)g=C_IM2_e214ROcVYU#2CS:V1V0[L)PfG8,b2W=gZ9&ORgU[J0H47
fJ8)KNZG6g\RQcI#-Yg\_IcABf@.2DdFYM70IJcPI>TZ,K#C(F9-U[Q<DgB^:DZM
CB_E#+9?LFO27g2;2?U/;][6U\>46\E<V0DAO#(;3U-<;QXSPO+F#QX3=c/O-UA3
UEE+11:gb3/9Y=76C15U^DH66.KPNH/AW^/=3cK(=c<O.b;K-F+b_]X_a:e4K:-a
fMeZbB5:PPcRK)L3;]W/K-#P&(,9#f,dE^6J[76##>#P61UF,KGT/Pe)WNCdU(4:
G3#b1_O-,[2;WI.^&AS+C=M#7>C73>W.?J]DaZ2KfCG#9V-AN;S,4bbcJ?NM/:5;
KX4JME/C;f_Q=:JE2#NH7PEX:.>P#9)[Z]TKdK+]HS9R4&gLO/(9N_gZ&?3QS\;f
VNa8,+DO6@5SbP8S08c/05M/KOG43TM\GLJ>T+fP;:Z-:^>,7D3;-O/fGf]Y\@K8
DAMa^Da>g.aQ_UHC_O5H&+R/F.b:Lc.VJXe)]BXHNW@X]KCM4E=1)EE-\&J#5I+;
R49cd3YPA]\\g+CQ(Zg>Q=;O;KFL6U(eI,/\G]Z/WPRc-QId-JX##EZ.)Ib.8)X/
dQPT0O&>YUW.J\[</[+GI-I4eB;D5+):HVGV0CD-DBQcB9](E[:\e)X&K.WaM/]7
ddc<-d/5D>[B@Yc#&O^P&<4Yc218MU-ROAJ0e&?_6LdaK]=&\OgK8(&A],3IC^@M
D\X?dUCSOUeM@0>3ICE_8,f(N.D:1Xgd[E4V2L8b03R7PQWU=)3X.4\1#J\EB8:c
9=/-=XX/f6bYcWdZ2gGeS<@D3IUePV_UQX_L?:]:+_D3[K04:SVXZG3IQ[)CDP7]
NbU^c8Lg)#,ZTPYQ_HUXA=SEN)Z80,K#<CA8--A]c\;\\aRZRe)HeNGPV1W/0e76
:XNJ@JgCP3=YH)WUB3/_<&@]Ef5d?I-XF=M-7IPCY1a]e+ZJcC7ATQ&R0LfgU]O4
5c_&A5N9WO:/QZ?V1Q.,f.a/0;aOb[PXb9Y6cB+RRFA3ZM4I]O8.A>a[J1WLfb/Q
_R/].,>QeHY[g<BJb<W?4++KR2?,_aMcG#:dT)5TG3#,e-^FFgZN3[WA;QaQKM\>
8F[5&24&ZK>+U_8b4?=R(<EFgRfYTQ_7\;J:\Y9T-;OHJTd26MLgES&?;GX(cC93
c;M14I(0=05T=?OTb-0W)O[[\JfOE\U3(M::041G.+Ma@J,V-M,<=ddK0RLF^8.4
5BE,9+I^;e^Fc:](aEWT7Lf+gM80+@75]X78U#J[66V516FcH+_W=)ANM&a#PRX8
H/XIZ.C;0fEB?A)#^e-I#HH-9GN/,Cf6aY>KD3O<^//0M@1c>[5U3UG&T/e+C8WD
c-[Z\:WX6gFRI8(YcA/M7P;X^33RdR:6-\EL?1G;.Y]=FGFYI+G)fM,DPG/;R8\T
L57MV)D(PCd=AVI:BFd<^K5^/JI5T?OR1:N>6,-0>0&KECA^J.D=I^I_.d:;II(R
[[()Ub_\]4#0SSV704Ia#S);R/I7C-Ged-G=,2+YIQ,#W-_EXNUMeT/?JEdL<a.6
B\O7HQ\&2T,Ha6C#^YBVS&2;T&\3SJS/.+QCCL4)SWeg<eF=VaBR8TZKJ91_g/7e
:4ObYOgM7^(23WNDaHW(N[HOc#&bJ7+/>V,4ae7M[<8S:cN3?5?CKIHcJ>9_?R9[
F6W6P[DfE2?TZaUe(&NXO1N7QM/d4?F>?$
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
BA=_EZZ4\ZEG,W1G=,_U,2V.<P=5(bfA,O>E=HcL10=IQH=.<@\4)1CW,aBK(-G#
TI;G?#(KQ3M^7TKUN[G)^36(e?@Q6.UZ8@]=eT9WC.T-CM3DZ[1+X?B(TPY??(Q)
0-.)E-3GQbcf(&\0[))NHZHRUId4;-b8DDe4K2F>O5R3f/<33gQ91UA3;4O\PFL2
^=DgFLc??_:P42d=EH1:X2F-UaAQ8dGZ&QM8be2eZdJDQ4<HbJ-I+W^FEYZAFaX&
]+:+SSQ>G8UGPKcGcU-KVWAf@=H(D#)&O5:30D[/SSGTH[W-(?/F(ED?].+#QBZ]
=U9\&LLJ@GBL/@c)/14<[5g(Ze=<=CYDQHA1>\)bV:._]<,OKGVd<.MgCJ)Q2D;I
gF&N/8e208NW<6^KHg:3gR&C3ObX=/f0302QDA-+7:#LS[^O@XA4b7b/9;RYDeNG
cZIECU)IEKG1d38UGYBf;P2@]^gG)V<VQXc=OaJ@N8W?/_H-&)_e/5]Wf(=&b_Ng
7>?09[d<ZZU<^=:5X/_(?JISPQ,RDICIU4cCf#17]CM=fXVRf6:ZbRX-a/G\?=.N
6C.bXB,gP>NM4c-2F=PHP?-D:FM:2c>4@8;M+G)R/]RY8G+ZIZ:2V8DBg1=C(Xb^
K,,B0><Jg[3:[VG&A<6U0L@7/f^1&ZDW<MQVP7<<6^e-.XCQ&,7)cME0@U=Q[5M7
?[4&)_0Weg^K@8MGN_SNC,?/-WYg??]R8?4K?K6e.0<>=(WUBGf8WfPYg29IGQ&V
LJgO2F^15:B27N>-95QB0c(U@Qc#M(_bN306KO?LT>/_cKA&Z9OefUV62+2cC]J?
=<G6gF7F+S/7=R/Lf<8R])IPO<3K1ER][egP^g[Wfb)+MOLJW#aZQF)?,a)^/C/)
RT6f1.\VAS<+8[V@H)#>@:e_G#7+Q,CZC@=WHEe,d;1W=V99@YYN=-8/;A>53SK;
UK2C5XK[gSMHX<S;TDBK4?Zd+G1g:(OY2?3W4Z-,)AIbdI7dM30Edbfc+cJ[[<WQ
\HSe91>&:^3B)AV7J<^Cd9_5-UNZU2>V)L@S_g<#C==E2+YW2^9Ta@UaBWUX)cA/
dX039^c&WCP2G25AS:T<OKM.\CG:8:8@<Xg2=_]P/Xbb<W^T8]/R6H&/2:dMa2XP
a,.=aCMREK9?UfMRN9KY>.g:?K,QD-dc#GA?&:I@RQ2>-_Z1P@APcXP\+F167dT[
BR4:QJLeN.Y8>RS9A+O-c2[G]Ca<GDU+<,gGAg&&93:(Q>gC?AGFcQ.BMcP9YQ7W
<2X8fB-T>HcbR-FW18(D[&3@=bSdU.bP8W-Cd0UX6^0,B8L=@Y0L^U?7C-.7A.8>
MZOF=HN35dRXMa)P.RX5D#FT&A+N>g;bQ.=Z)O?1bgNZ>_cJUZE(ddf;:3(gXZ39
Y(M;EWFTW89KX_[\(F3cV)<7;cV@EJZM:V<?&+XJETD2.ND)C,TeQQ^]663@IAXT
ggY5?XXWV39ZU8J4Ab0JQIUP>;bD>(PB-YS:CfJWD,+bUE<EN<@?7<-TMIMSOK1d
e]87KVKJBRM;f_F(AAOd=@R<:,<3(N>BIE\&b)?M?_K-+@:S7?C[c[cfCb9=T96P
c,Jf7A=.4.CXAgJ1&D^c?G;a_d7^-Zb2CSM_gd+T:F(C-<cR1;MSA:J[IO3^a43<
fcF#/-JP@>53ff1^8-DfP^::/Ee-Q&6SMJYNH#Qb#8d;[dXVF]&7\RdggU@>gefb
A/@9J;F-eRc4b2?c#G18FSLKIN80-TE</)9RMUT9ZVQV(b1g2++;+=W:4,B/X#UV
5IIETQ.AH@_JXD[:>Nb@FG5&D+R8dW@=(#@W_[f-GN)A&I:LX1:\T^,Z;1\1#@UR
CV1Ac(J]V^VPZOL4,dM)7]ATK.,gLZKN/_+2?EcAS#Mf4S6gR7M-&.8&:PU@)d)0
9_g=NaZ?F&.Z1XFVCgD6I-BEOSL?Y[,?^3dGb,@(ISDS87;0,\+=C(b\(R1ISI>B
a,B>[/<+/.2a3/43(TE0UJ9N^L<ZGRWM:aQ=MVMPKZ\KZd\L#V#TC-L7HTN)-BJb
R31b+1G)E-.a4[P0#LJ7RMPKFaFg9WL<8><B=f?A\UG2-e#W3&9.I,0A=Ld_RPBF
-[fa6]E_Z6\C[722XYNI=8DA3-=@UTT#Md)LO1Lba4gJR:WY.=Y?)Z1A=Ug2@AY5
4C6ON)5RT<9aO0R[b@W8Z,)2Y^[A/fXAS,<I>]VI;eX;VO&6,?PU]P1\-_Jb+JDT
LA+52Wc7D\cPDNb+cgL@\aY-C6&dLLcdOaWVeQ-;ZSX#^bL9A9]33-Fd8>E_=9@,
R9gP5&XM^F=O3<d@=X,^#e#.9VCc0@N@2X2/5/,S7Zd&aaAFVI(7Y1;JZ]W.4VF=
V]ZC)I:NF(13.X#7OZWUCF/#NL]DV&d)0N3Jf7Nd_IY\Qa\)9E.JV2?4EfOYebZM
D0@P[=d^W,2^-C+0G_GOY6bg&>Oa/Dg88F&206G:3UPBRL9(:#/_V#[DSYAefYY@
_N&ZI&7/H)RUgBXN?g;=4D5)(\-8^8eMG4\EV.dKPg.(8GO\V^;P1.?<W+Ac\AA9
2Z5X<;12]&E^OL1/fcA06UN2T#f-8+\<#_8SGJ3>3W:PgHE:PdWg9=H[g-gK#B#a
0g(a,EbHVO:>B6WX&0AG-Cg?VHMNe6:e]-YeG=[T6?ZdE-1ZJ+_d(_PHGLRcP><S
IUZY1SF;Gc39+B(=N5aKaHB/BNA?W3P8]U34&-L,9)f5NF;]fN&+RSS-4?66e0D#
I.S,X^<MEN&:BSa[9X3YH:/MW</Y:@;]4;,WB).@QZ3M=/UF:&1ES?0:YH[b&[K-
QGc0IP9]g2ELD,E\9<Te.Zd@J1Gc>gQ(4=B-O621(IKR=:Kf21YIfC=Q,.YMZMc<
H#H4eUS=V^N3XPS:H0dD8CX<TH<S.<5[V>/(0&AO[A-:39@^g?R;]EHc^H;dNdd6
8-P+WW6cf9e30$
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
#&/_3NC682Z7-<8W8<Ja9.S/9H\E8&)](,.)=5,Q9;&B8QBAL;3.(UAF-1J[9B=G
M)9L/CC7(;T32X+dQHO#N^cEDYM8KOZ]]@CgX?:T[XB##LU#\SU)G,7XEK^N2>Y(
?I0EMUWMP\9UL3M13+YSEaVBXbAUY/3MUOe;0Z1d@]R31TK8b7&cY:L+Q7.YB=)D
&7Z9W_AMO7EW&7W156[[I@cX4IVNg&5V&BPU/T^e=ZB8X^R9:>0aeF=8^QS(Z;K3
C&ZA70Cb2T?CTe1NELW&>aUb8<Edc9J)[;RS3c;/)2([KM3Db5VJ554?ZAT]CKZX
XZbKXU,6RF4,@==7OFQ_G5Kd>/G.R<E3Kg7^N<Q\1Pe^2[/[A]3?L;\Q5+JU>4]T
-XR7<6WUSQ@KSP\0#]FbFY1N>8Q^6BMdDFL;95&AW4E.ILEV<b>S7SS>dEOX#]a=
TWPKKY2UR5)2B:EIN+O40OW4S/8gCN_af@E3HSHQT@LU<=7UUDMS2>G;c3Kc)U=^
O=)CG^T^Z1HMCT9.MMBRDQNcFWF7)Q+Se,MN^-3+I],]c[M:-dJRXL@K4>E#]EY/
+[/@49(e[](V[_-;;;0WXf[43?W)C[,e[U[8Teb8#\CVa-0Pe8;0F6U8L]DLT-_\
G)eU<Q/YUS;-d-<Q_S2BXZP_JG-=4-ebYT,]W-fVN)FJPAWL7]>+C)Y#Q6\>:,I1
CJYU>&Qa?4S<eRU=c3aAT3A(,#VMeT4R.T../=Jd3+R^J>?:N5S2I^2&OWe0bXa>
CU)8/MG0U^@]2?CUX2O]8b7LXT9Q0gId8DGa^?T_f:GEWOLSDK=e[W?&)PT@?P40
b;fgeJd/T0S1DA(aC1;SX3/82IKG_Z>eJXg\Z[ARIZabVK2<[dR5-)=(Q.6fW:50
S^QHG+5ZW>6SN\baXN5-Ee-7)^&Kb04:X_g]gY?#gJ=C5A::#0W#P@-d_\;+><B(
S=OR8>/GMUOFORZ36-N&GGa-8#7(IJdZLXbJ)g35]_ST)+NNLZS++T\?d/(e=UPI
U3Q@WL:H_[)7(,]T5YE75LT3eDPS_+HD^B;:+ZMa3addd;/6IW5[6^1-GRK.RXB;
7LHgc_5g,9&d5Og-6:-BRa7XU=aB+6F?72AXd-80/)9+V(dLKQ^3U^G&@H(;Q\V@
gc02>3L4M=:&;edO8/C)31Da8CUK>e??SAC<(U5=KHUVHe6K(HdVN;=P.V5?B\S(
QF(@d-QCG.SS)=F/?TN,@g0;O(3E:6c0Q-=_QG^;3<JL8.@DfdKRMX4I/TH(LZbO
4ML9d3G7\,8TMZKMbJ_M9HY)9<4GN/XRB]/67V7MS;eW00&&8R0&3_X8NCa(\RY6
?cL9K>9gea&DWM:4>&WFeaQZ+fA=N<#I4:7[<^#0Z6PdRa@@KD-Y0^J<-2H?+O4/
c7JV-DX7bE3b?+@[W4Y]^C7H#aI:?J\&WVZ#YS+&P7S8\077)g/Gg7+:O96FLNIU
4<8_WMf<,\aHg/<QAI;8ECC-GVL<D9Vg.[egBf=>NaVgF?^9^D7Z]]V,L.VID33B
MVQEJcCeQ;+OYZAb5HO#U.61(^0cMR4;,5ebP75^S8EP&cUS9O<=Of8V?N4SS?e)
<^ff8C]?EMSg2c=&_^ICO?98d#>@:H^WA/J3M,+#DG=N+[5FO&Hf4#A+,L[G^=XU
2:_#EQ:E)-\0@F3LKa8.\B@5X2@bEfH.,Y6)[5dB86T\FU,CG7?a4TA8[SU(g54:
,)44)NN^^]1WP9<>4BW06c+Wb65[fC<5B4S0gc#I7O5T<^S@cZ,E2AJ1e<<<2Qfd
1>_1JD?Q0UfH\Ub5IHb3.?:;WcSTN3g)E)#O\SLVVVT(D]-@:06d;gY0:>W>]]DF
N,aE[@H0]6JN9HaAZQM#>12J9\7KE\<,KNaDC/)XEA]-]Y2(=4;YZJ:Ie=5gYSKC
(7VQCb1>;XNN(eB/]Q4=9)HdReGb1&NNE\@gC]^5JG?Q9AIb3XRH5-0JBU<D(gU[
#XK,6#2g2B_8@#@Sa(Df@A^:9fV1H8&L/5:</&TENN8[P73:B[?\/M;]6Q/A./c[
<#+0a9QD^&QAJ@<a/>EVa0=<5eD4@0;@WJL?+BL^T@<YPP^1RZ6M:#Mc__G<ZUdV
:bXL]AYQ;OE,]1AZ09@</[3\K5KL4eFPOVYF#)FZ#)c90fX.I1g=3X<5d@\Z;NAf
e+3eB3ZU[gR[ZE[5BJSXTI+b>X?15WRK_BVV.FEE.GL[5)WJ=>#eU(=IH+=:B&/:
^8/85.W4&R7Y@UFE<4U/;XUEL@M=[@IH583PZ@6)5:TL9Tg\,D3B((d=7d]/CJZ]
4EE>3cg7S(L#,0O>\gL;871GWH,L:>].I\/JC>Y(,]66Y>PKCA^QP8/TZH7S?_UP
Tb76U[&Y)>gZ-5,g/CVA)+:+;+AaU:GY0bNZF\PO67,T28V[R6UTS3EbCV&7bK4J
TGQ<NC/Rf4Q_&a8[;Z:Ya5HS,L-GX.CS;DC.X_^4<S+]V]d3=T1MO2(_Q5.G93?=
V\^>?AH7Y?<cRMNN_KBBMR=g+V&KT:?gP.42e5>&:M\NER+IM9]LA\NVb9RPf1@b
)K<69>^0#_2LATa7/X&3aWQY#UEO##W/V[UF-4\HbBG(4?0SVgLP1e;MaEQ2J>6c
d9-Z)_=K:;5I7\1@2bJe,E+IY:EU(8;R/25Z&H&ZP,;C(a8RKcH,<@()aLF:W75/
4M=\<3M<b<DGKYB12BgcVJGV4_[GQWYa<<^ZOS#Lg_)OdA-E.U2QPVYQM4MX?1HW
HO7AY/FIK<&C8[GH+FY9P?L9=a(gVLH=_#Vd^JWT;1?^6/=Ma9b,,27B=_M:dRO?
]Z/5bbTB3J_d<0_gWe-U#LEHWdEfaCXE:.,7O>>S,RB[D+-3#90=36CU17,K0+.b
E#RW>J+AY+\OU>+c9Nae,<Z35\6Q6Z@,\EQ5MFCSX]<1TN/N8SS]dW(c9Lc8O?Hc
Mc0L[PCNTXN#Z5T\fbfceI.P.I;,CKW^[\A?2DDKI2P\:8OD1gH-],(]NP:=Z+/e
H.bSRZM-QJ1fZG//8Q=\1X\g\HKJ=D^NCS78TVDQ;&,X-_GdgY>=eESV6PM^?;,W
,C\V)V3+<9@BIA(0fN/U^L/#IV^=ZS.SG7fc;O\C\G3Lb<E:0C,GUUe38)Q/GZ4G
T(9YD9F3J9NG;a)E8EAd]4H\S;\]>L3M6a=N?5C_BV;DVZ7A(\-Ed?8a>8]7\#4f
K\ba:6\d70G=<ebWH/5/H(?(eR(9>bY.A^Y:O1X_N#4G04<8M3[6@IQ4Xd9)?c_8
5ZFR0#=OeQAPI4HVG^<U>?J?RF-a(R3aOMb#7EEO-[96F;N/IaGKY737QE7f4L0f
D(&C;,VZLZTKGJ<D+IZ3=/:W922NLD:-=eOUd\Dg^:K)YD<N<7)Y747Q&4+DG]#D
RC;0\.3JOcXACWgQ]G4gGWJ,[7B\MXJAEX2LGU8PCce]]4ZBD)+Je+=441V#-eM_
ZSc<2OKAd-(0T#3f680#LZMacdY?YHK\[Ra&g^fP\4[S;)<1gDFJA.0=E)]H;^9E
3cTb7X<&UCbe71e2;J/2\b+TB<g\B/]+IeLFNWR^#ILR13G<;@V(L251E#V:FB#7
1)>(?4D^7K/8T#OQQ]@T.3V2GCD8N.93Z:E\/1>eR7V7JBWe=La(0?G;,-(K5(P(
OU.R2RMAP2#,Cb.IQ\2;GL))Z_3-OP\^Sf0;;,A1OfH..R.2#.#g;5M/O0WgE[N1
cG2338AcDRD2(QGBNIP943&?F[Id#/b(CP;>/D#JZC&AGX7I))XJ+/Z5AZ0_Z2R<
42Y3G1GNYJ5a(fO9c;=#R-FFT/7)2QQ#6-)eaN_TWLUZ=.]NGg,_]<QA_Y#EZL/H
W@)-J?5I\g5&\N7XBVI/4K=C]0<9Z&D1KT6Ub][&#F_RdLV9KH)@<GF8EQA=R=)/
]/3dPJ:[ZW(-/6DWcX_K+@)HdKHC9gZ&G-GB+CTK-F[+bL40YBB>4FH>gIPOWaIU
B,Jf(B_.aKd<gJBX^RR;9T?g07/XRb^\Lg4ISWe+\T+L53,:A#c[\.O9TM3D2fD3
DdMNM;?J.K0AZ,DTfS]cQ05A60R:]FUE+B1E\:Sg0^0=FFQeJ8EI1Ug((Y=M#LCZ
MfTCeN^JSK+N7BZg9Fb8(/,Lg^R4[\CQe44J]2U5P&#^,6;Ka&1X\Y(HF9M&#BGV
1JZ(<@PZ)^g#/.?fH8AgYbD0XB,7Gf#L9aPZ9d3+@b(#R6,FgFEbJf&<=(_(;PU=
>/CVb^3,,KL=[0-M#Ce2-R3].\f5Wd2KQg[>#JZ?/XgTaBUa+<PRGQA_N7I5L)LJ
b\,AHYWJI#S&?ZYT.d,#c4KAYPKc><BMSE],7A&+&[45RV[Z(g[c(^N-(/25Wc[a
2K4g6/\CF<=6FBR9,P=Y\b(JUU1cF(30@=1>;[26/ffQgaA\^#a8d=8A]]DJC2?e
HB.T[GC8[8bB(a4)6FLEG8De-NR8_1#.W4BOWT7+2F(b)gW18LaN(&7(5&B&2K,D
CMMR:e:7+YgfX-Z?#J,]5.>2()9PceZAWaV.\?79A8D;Q^AQK38fe+AF_:7+5X&4
=&S,[5(:dW#c2W-RB&6,<2F4#^@Y2)g-6X_#<AHO=8&JP)1b9MSW90.G70KL+d,@
<0[e;O_/3e@3NA<.Q0WU72BONGee)<J7)BV4RA1/+18X0L+,+Y#_H1eb?,@[]J;N
K=K>1PQ,5:C^K:B=C<Ce>MG=64L[5+;2TW-^>\__GS]5.V+98C[T/G+X9a96a>R1
&D3K(?5VKBD>?(TUE7b.8;a-:.eQ)DMUgDHK=gb/@ZTN/-ac0K-;,F_]e4YY#GbL
]S/)^KNE)&bHKY(8>NSRN).GPBK^ZDMZ0-OP^@M6Q[(1=0P7\bSIL?F0<c[??VY,
?#M^G[WDB^GY31S<:&g:AO)V154DPUVSNUSX+6T>U-)gMBB_a-H)[J2eFO5Y>0@g
1]/=eO9&/Ye@)d>DO5OP0f.(NVVL[J+aT2^T^=d/2@N496e<D[GN]bB:,Jdd>7/C
<Lfc4GQ24#4OeKfKD_gfe-bbVKLWNc>Y9EQA3U&+W;e8K]_3BGULILY:G&BH;a)]
UdB:.d6Mc^5DW0dH3bafM9/WX_^W+)RFA1<6()?\WGU<\QMHS9;X)C0IIC2MX&1<
PH74AZI-dJIIK6KV[.]Y(HDNb;Oe3I^G?V0FVG;<\AI16:,)JC@99/_VEOSa,L#S
cVMY?8[KSA_.G>cUPGX3Q&F#KScJEPaF@]X2_gSb78S:,IQB4GHcT7NY5_d0bR/)
D7cJNRJUN2<^,&2cbYCJ)7V&Z-MY&J968(2T>d-N).cAU(I\?>[&?S&g0:<bYPK^
5LR=V9Mbg>dJS;gWK8ESR4O_B\^5-c._F8a[b##\(,aO.O-<TEW..EBF67=FN?b3
dU&VQ0fBX5ATG>W95;GD6AU:#LJ@CNS6=C&9_KZ@cB7I+b0_42?K4\_CHS<&eZ/A
8F_<2YbP)-8,N;B4P\eCH0C6?FZGREDD0ZP4T=PKEC.R5-bEc./f;.D<-LgL1JK3
@&c0Ae,C1cRUJX4c>G&]+Q97POc+6?F-UbN:Ob.C1R+3C0:#-:7bd_6C<MC.b</V
9U2<+b&ea=0U#M[]P0ReJPaSL[NR?:aVb0Y8S8.<7Nb#G9OZ=79aAG<OfSU<R,9M
f]W(&Wf1FU(b1]D:R9I?bXV+<D3>&7>b<[b?V6KI&4(,(aMCJcU-M85&N8?GD@9R
bEf)<RPSU7-KQ&:<VFNA[Cc];@-UCU^0#S)9MS6\L.BS&N.W9=?XHT3.-R9[7b\V
?AfV6SG)g?F=aCM:\>G]f^W#Ra1]d(_^7ggOM31eAZ+-4-_1PFIH;,5/M&.[df9_
E9NW_:=O]KYS33I(U+1>JY?F<H-A9S,\d#U\=2ZRd3,T]4Z6<;OB]e4UU:JXfJH0
^c5#B;S]/VIC\MO?2>Y_NO[XK,P4QT1KffN8;UbV/+L7PE\_:.XE?OOG(06aWG\2
L9decUXRCeG(E[T.U_=I\19A^)7Y_aY[fgB&YJ</:66aZC(YC.B8;ZOF8[,aN##]
BJ,WNY]FUeQ6(;M-#\,+R]5H3Af^QD968;QBJ15Ig5[LPfIKFfUJf-f3#3+fKUOO
#A0Sd0U_6;R3]UW)(XC&ab9c5X_1]8(52OR6#TJFdP#Z6>K5&(\D4<#;1N)WAP<0
AUd]I][)A?\?ACALM>2LROg>7.QA=:RH.V7N+-?)=g90eE=3aTUR<K;M8MG?+K25
[Q^U(<<G<[gg6RNf=)QRPb/P+BM6dUF,Wb81O_VU4C:1B33^3[B=(9<VAD[WTL-B
E55^QGJ1);[VM4g]SE3Lc3]NfO?R>L4LIZU2ZYfI0KgG0X>:_A5cFNF_3Q:5dO3:
\&[aa7,2A#DNP]N+M.R#]Y6FSa71G)0I=:B;bQI8bWTJU4YSG^G_g^]fPJ)U7FZ]
W[L9;,3L(HL=5NZf>>aG(BC>CIANWLa&?W:1O+aA;f90X8F[\M2<^1DKZ[:8SD>\
YW5GHWK@)PeV;WPc,g>\[^,O51B[:67g(Q,bV/(dOY/@)-,=D&S4V;R9IOH-;b\I
M)HVY\;3P>9ff).BO8.4e<TFQ^:ZSK&.V)&\B;bdQ1]&P_@#(&+[YT.@c\(?[O?W
EFHaR;.dQX^dG/+ReWW9_4AT^f.e<4R/2/C1+L\[TN4-Y4DRZG,U7EDXF6#,7MX,
4[X<QQ?B<.S@S]&VKTLgUZYPeQ-1@Da(f7;\N:2NFJSSMTS?.CR[8\B.UNF3bO9T
g&9]6-:;WeHZ@T7<?-(YTgfG^:dH#N><d^U@?I3^]bJY4aH/?If_09EKZPDe4fYR
V1bC)c9e>P\L/:#ffUX^Y5RgA;PSS0&S1::KXS5;#-B0F+dWAH[BRYNV@[DW?EEK
#/./<8_)cNbCYBRT0\&@^OeHcBE:Sa[<//LX0I)<:aG_CRTY\><B-1T5D<TBZAf<
JP6TJ[6d2f49>8Ig+34VaeXR]VTQK31@MH_/cbIO@>H#NV)D:EF_]eT5I$
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
V;@CJA+dLR2g-eZ/9Aaf(P]T<0W?=I=^9Kd()]De.?Ia4Pg6U_+D)dHA,OZd8&I:
3aYaM?-/+HbDQF6T_Q#(4f38.YW)X;E2T@AVS(==-BCCA4B1gLeb+;g35WW?/QRJ
\):VM<[fS.OF\G\3:cd&=]c6.91=f6dM-8OG&gcc+ZP2_JA[2-0U@T.&SI@^<@d.
df3DI\P+)5O[e^K[UCQK9<4AM0A3E.g2,K#)^a,V@_c,.<,VS.6BdNgI#XYH.A,F
TF-T9HU4+S92+L_5-36W^1UF;/WI=@:;&DHf?@OOBE)#2\(2dC+VH:N]Wg,/D_^a
5I&HI#c9))b&LSWU@-XSO6[0b;U0]HL1@bf9.Q.Zdf+aYFZKMJb:90]>?,d[Yd>K
Z]f6(@T3ZT1V>Vd^N##8B\SB1S,cc[<UCNI,6G3E/&H1OPN2MbYf8CNCUYd9FDd]
/5XU3O.<H6G&=KU76g4Y@,&Q9X+T;W3^NQY[K<_a:=E:1)HaCW.YIZ1Ve+G.O8_-
S8YFIB7@I?gIM;CLQ>RBB#>]]]/D0c\E3d,#];3?Ng\EQ4SIWGN++c(Cg#U]A)3\
1.)U0]?M6)R91#F7PGEQ[fHL6@Xa:PL?B.<1P7gCPQD>?Ue-DA#?O9(F._f6e(C0
DGA+I7W9^BIL5NB8E^\-dMVHTO#\cF9E90TWGOC_Na)2DZ>eKFA/XFd2=EVa[\U=
W@Vb4)M#)(b9^ZCP<48-Vg:dY]&NF-,bf737/,PXe<5-YZ;edSJ9W]f@P64V;RCV
[HTL_4S0Ie@&edIR8f+0/52.dJW6?C9(BL_-^YJYM8/J=,f/^<;@:T-,N6A]=Q3]
[SF&2.gH\YBJ_a(6Y:3?>&[]HCUFCM5<#)LD\8&V>@SS:+?6,8c6ZZ[QfB(PX]90
:\bA9_,eY>)S#[WZ^GQ0JNI02\V@[#g:ND66QBe/f<)4P;/IS6[@MU^MVLQ8T,=&
FI\E=c))3B[d(D=RF>&Oaa,MR^+@B?MZ]E[>D9A(He)V29;J17Q3;K7D:P4U?fWO
>C=+UEX<_&-fJ,STWQK@7D=c19@?a#&W\]0TRf\J3N\R4=HM(&ZE67GT/RV3Y97[
e@>TD<g,5E:U:e[VCIL=;]eYd_4F/Te(<W)T4(\0>Ob-S45ZE/EJb,cJA9ZP4O9Y
.0.fW(&:,U26GNT0?42[5YPZ8T&?=L8&fC\b>\[=T-?Y2Cg?PPd-T=4D8=V(4:e7
NA_)fdcgR5fSWHd3WN[a1Y-;:[4/762)_a.8ag]<Q:M+\a@::[Q1+D.,gQNFGOcf
\gFKJLQ60,6-L8,GCaX1c=gJJ^XPLZYP0.2],W+aRb@@bC5ZA3g?bMEU@D=<(Y.6
#[Cff\.R::I#RAea21+J/GE9OND+:.>gK]SB-#_C60b8@E#Gg&85ZZFFCcL+a^M>
:9d8#+K(8ULdG0Mf@M@63g3[;/YY=e,?Nc1>a^0Ze6gP0O0B9?0e0W6L(_.&F[+4
.P?1CYDa<A@;?3_77KI0a8FTSC;TH]5+_P&150T4/(,W0R]8Ddc\4>g<:5X5&b]A
M3OY0_9gIgYPg:dILX4<B2\#A\Q](8b3]GY1;6@5/d[b1?d^Y-@+a43Q<,:Y3eI7
02NL1MR+PR1aa&9GO4-3f7E[+eKL:QP)?IP4KP@>,^Fd4efUL&?L?&7)d]662M;O
_YgMb3Y>KUGEeIfMgdIYBP+6+7^A412U4c,=8K&B_II(1P6;#]0a87faU(I?9CT.
PNMe<Q#4@KQ;YR?6\,=Qc4/IWC>,K>8=-7U1R)DR<NS]\?H:?1P2dJZ>9:()\Da_
HE0)U?JK6]LEf-4VQ:R5^9((E4]N&M4;8SGNLQCIcUMc(?^ONBa/bPe[<)abH6Z;
<MRSL,ba?3W8:HF0H>V\PbcI8C_^ALOOF8J>KH^^V]CC1=?\0L&G4&6dPEPAc-V>
8b1I)8fOaGCJ(aBAT]:-K75.^1V,+Ba_T7S>^JK/_KT_cIf[M0M-&.T./9]8E)a7
N)1ObDc;</;;e<GPY\/#aT21gVEGUbPaJ-7f2_-]\B\K.OK;T\Yc9-R/<GD9/5D6
]W\AV.9R=Cb_+I-?@IBK)/Tdg\67fe\CQ>:L?<OUN#Y<d#3eGT(J4RHHdD3^>LQQ
2@8H^),P;:7=:NcC=IEOC::]N1CCVRd#Z6A1N2JF8g>5Z3F+3(Z.RH&##P46+]^M
&H;N=C;>Q_TH1Ye]Ed?I=dbP=ePZ5S?W[-O&&\\QY^=+GCJ9;QM3@:O:K<XE?VL9
TLbZ1CR@#WAL^4[D+>c22\F0dE+QH#b),81e_eT7RGCLDO.D(6Tb]&;Q5JOXU_JE
LXU-R,97D&JCU_BKWX>9J(+BA+4FA6@AH7+76GOe+Y3>4/ZORg3@FQ3gF:(+5;fg
Q2X5DHNQV344.7#)^+E-9Z;PBMKM/>;BV(bE<V=G22HC=.d4WQT46@:B)L\aKc^R
,ZP)56.QQHO6OV=D931^WL?<[Ad^,?d3[D+[dHFHFTMgJ=KLE4aE\-MQI=A7CQ;1
A->cPgT^QfN@I,W7Q4JT<,SK:c:82)c+.:aR).3GS<_<4XN0]<\c1/b<eX;K)QWL
SZUFUGL+e9F==/MPE:L:7>[AX:3A<C^f(B;,e7?IE\YAYMQEgdTB0_Q79B6_-5/Y
G2D_A^DU@0V<IBONd.U+97NQ&&X)F(B3TOdW)c(^(IG.J(T(P_K[8]\WVVLE@]RK
#[[17&BMXeF#Tf]bc,Ce:.4F<K=TU3R_G0Oe5YV?\.[K<[?M@_W7D^Z>4W\2G[5S
gJH7HV&bI4_Q?3Hf)UDQI-,Dg84a?C3L-OXY22@2R-V\M]?cB9@bW+Z;,;+8O]OE
87;SUE+G5K>Ga:@V&8BC2HPQH-(R:1(>-<@#URYfLU-N(P.+gObVd,6@f2B)[1fP
<L]=WQdIg51#d&7T3F]a(OP=N@\+B1aSQA/HAYC)0C04PS\=a4C-:^VZg^2=]>Of
>>]^^?c.H)=GRd<a1]R@16F\3XA3[1P&593^YYS4,APD<?DH/_7XC^>PIWF:bE2a
\S,DJU0QV3H?NU[]QO#aS4(]<X21I6NZU86@_A^FC=T2@UdeKS:7&[.O+gELc-9e
GHadfJD6TL(1=O=]&,>4VAA>QKYF:>d7Y-]:bf()XbNG@.b]8A(J:O.OP$
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
0(,>Nc:Daf>Z)V])9+#/,DbU8P138?/28LB0<=^:C3(-/3#GSGHe(Ke\8_d,8^#e
)c2M^E+-;cSfB(#;,GH#BOYP5DdK?_(/=Z:\6fKKL,6M],@L6VD0cCc/Qe#Q=:J0
J8[@RP@MD(&Hb-FYIM;J\-TgSAe-XN6BT^M]H]H:MHPE_0NV\IJX?-^A7(]W2g:G
7TV<>7)]M+J=N^3DJ.S2UMET7@#6<=<H1B70E33L&S-<^Y076N]D:f<SXf-3@,11
e090g^_e>WT\Z[EJC#,P>C:S-WGZFeM6-S+P96O)d\705,EJR12V=5N0,QRZ?I)\
1FSF?6/1[a\O(R&3P?=FHF-d[/\O3T0FP0I>>?:K5.HeT6,N0PfSCH:@)gHc9EOS
1ELG+3g9EDe.]N&+)^AYPM4TaJV(:^_FE<c(\FI/Q5Ea1F#N3Q&+4,#0M?2XAI1)
<>aOY-[e>g##5W-4_9eWA4KXMY@;1YQ85)GQRW]8>gU;,Q;?Be77A/f4&+WBaa(,
Mb78:=YU_VS9ORg:b^VHLGe&:a-3cHfbd7TJ>KIUfD&0HBUVg:5NU#;+;I[NL1ES
N9DL:T/c;__b(_.7_5PY#PO65dL2\MIaAUWF^/1TG:^^PY6eE(Q4FB3.>IF9cOa:
bTF#:T>[LOE&/=]_PYV=[6EbTB)1CAcTK^57=][2-S>2V5A3Z45B,6XFb]+&+0,;
G8cZE.SW8FB2];APfIgRY,]:=O0(7;NJU@a\[@+F@)CFDc_)@)\Ea-6<)f)5@#9U
.<=-6gR8,PZY:7?.RXCd,N^X+?,#3E+>5XWVL4YZAR=7(CfC91dEK8fC=L41F7LE
R&Red5EcUUMDPP@IUF9WKZ8ac9S<4RY=B/^TQ#(3E,P7eQG;4cC>8eVA,W]NN1CL
+HG+Y6L/f:Hd=:3e^HSP7dI9d=L1:(;XLg^3&I=&3+C@<EG_=PDM.KCKI_>(N^1Z
N>UD;fWBU5F5+3FRbU]3-_)5_X]9c2]FU((A=a(NMJaE4V>=A7];bD21bUV.&CLR
[9a6UU96,E6#(PNEY#/<BFC2[AOddJ0A3W(1ee@KcV29aDcK8K>HR6L^9AR0Y5][
5P7+SGCTcR.3<HO=Ja=1D=UPT1&B;,dDDHbd+&:<be\_,WR&:D/J^R+)6P,G^#=1
@d>J\N\(bOAP/>V2RO.^@4#,Beg[@[MPL^Z7Y0R4DM6]MQ&:_+2;dF)]ZR?19.c1
KZg#X1)<0BF9<9.a0BC7:EaNb7RB9e:<C8F,F(R>+[O.+[<X36@OfR.aM+IIP.UB
1()DdAc;PSfc5[^MR67.OHCIQI]>R(g_/Ad>A&V8-1+W=bTVZW;&g)1a_\2\L6[.
U4U@HSOH]aG/DB<-F(_=e052Z2K(&O^g5PeF^W-/4SO6?=[PX6:=3PTf]OX=C#I1
ReZLLSX2MW3PYVbUS^LadI(eOLPYcYE@=&CI@Kb#2+L-2&.1d+DHZ5E?MTU.9.O]
gSUM&BfAC]b4A>Z5I^Z9?QKPP?8\&CDO<JX8(<>4_@EO33<0,cIH\BR^;E+R2T)P
#OZ8.:f,N^WNUZIYK[8+/YYXG;K,]Wf+(W([e?;U>>B=2OK2dFC9<Y^R6]]K:b7T
EYJGQO(V)U:YQ;TP?00FZUM9H]^I^O6?S_+R@MFGS66,N\eIg2Z3bGT.,:1JP]L,
+TT[R28H?&E??ebg1/AAC[=U.0f3@,aM)T/W/e@L//,0^?@fd<9W13O#g3/((D2&
ddM85(^PaM0-NL#J_?H-TM@6\K>Ma#Jd9.VR0EL?RK2LaQHE.^#eWI<H)BM<(C:>
HY^B?[/c;B;?DD]>E)K_egI[(1g2:#Q#1\H^^,(D(0d^Cac6We0@LICd[0THT[P)
WdJ0D?Pd;<Ibc@UWX=K1X_cF&HVBHaIIcK3E[EN\BXeg;6UVDPY=-WH_ILf4/OTN
d>/J^=]VZA2c-b_\]ML/d2CHC<AWbZ5//G#Q#;=Ha-_(Bg:.F#H,C0(f)e=SXD#\
(e+b[4XF(e+MNE4;JY:;/U_#Zd<9</;U[KH:JbZa-9B>7@+^)+/@:?70_eab@5f/
4@XGJBX-WeCS<,)&5BX,L:BHPXVATYKag>bWM6OQ70),4-PaeUN2?#.AZY3c[[=Y
>>9D)6#N>.G]@5\DB4(6620,(T3A/:YE-::<_NcdQ.?]?T^(B067CgS0.J0X^F>T
PD\(>3TJLWQ/e;/&B39)/B5O+^XdQ@e\CP>&[,FNgYU]cZ98L_A/LC8P2.Z1(c81
E<3f[T2gE5265G7Db4HTG95-REgCD1?f^-AEJ=2@HcSfd7P^6Z;HgOaA:L@3:[G(
4]\GKeB/W1/<3;62d4U6E1>F._FPdA#La/2V8(e1Cd\A3#K=>P78GVc<[Vb/M.N4
N&TVMCb7R329>K=?LL2+eKgFXUO27F>K;/9H?Ye5PM2SRWMc^aG?)g8@C\52^W3e
EAFV?T34L>8J>NE7\7Cf\D;cgI\Kd#S2R1EDcJ<N[b<?\,0:_1bfaZ:V1IR;g88)
R-R\#7a@WY2_adEE0aWTeJ>M9)M:X7)5\0V64K95YNd+MD2;FA+DEH.O45LQeV+f
3ELH@7SDR#4J^U2g(7#?Z,]^EK<OUW\d/U<GB\2-J>VIa-dUZ:)_U9G;B&[C/,C@
eF/YSEXMPb83_gUGb/OcO6a16SJ05?Td\fJWL;K=3K5f+MH\OId9CJ<?g#a:M^1-
^-/I2],b1@7CORX)D]QV<=->]3gL3fc<\/3NMP7])K4()YVcVBT28KWS.N>MeD(N
_[,-#H0&U[T&:8.D6C0I8aON8]HC?GU>&BE1=-TB@LYAA:AX:g.F1-Ja,N-N(Q:G
KS?=bX1C5dEb2bGBU27fP5Yg>M[1+X?:#?STI?367<,(BZ@M214I0=KG^,UWU#[<
]1e7G/fN\a6_@c&WQOOZd>J)H;NPM;,Sg1>GXC7OJ<P3&-,XQ4L:6MXdJ1ad/be)
?(ZPgf(L6Le;DJ:B5_AD+_W]P(\B#(Lg3K5VR[93[eD4.7,[WX]ZCJGfHYM_G3VB
GQa?,&>+XC5&J)a_4\.c6B?]@?LSD#6U6_^0/9g,&[UHYH>UMKK0CeM,C0:C[VCU
):6\YAS@,dF76FR01JJZXZHa7+S?/eYIB>6e,b\DFS/XA+4OPU/9J1[(.68RSVKG
SQM3O[&V.eY#Q5G71&5+><fP4&9H&-&[+5Z8W>Jg+4d\?W1&)a\9T:DF5-UcW+<;
LS]J&Z-U4a25Gb7UUN?HQEP1AdDaHcUd,S4cQ@YK<C])[_.@f,_O?d0>9K?8#)..
2XQL@6Jdg^#(&9SUA+4B(.A0)/4D-\d5A^8d1+X.9cN29UT\3Fg\Y:dZ5\7Y)KP&
6-EOT[W^bJIdNbZ,1JA,c0M=bAH&0UFFF2;Ie]HE:?NE:IfTWg8/=TD939Q84g7[
.BTV8,#.]22=H^QaH_9A3eR1Bd;Ra&HWgK(TF)+R61<X56Rd9_?E[=2E1e7KZ5Ec
\N:TF@N?\5RDGU/1__LMK&8;6T]50&5]CdP_,b73=U+@5>KZfD20X=7YHPKQGEfW
EJ]YTe=I2U&eUUR_8AY2LTVIX5I9&GDJUR675O&A][FY;<&(BUD4_aO]gc+748c9
NePLab^.]/.4H4WbgeGX1QYQb9TWa5D].f=SA4cO\3CFEM(^?<=aD:+F#bG-M>ce
\MU<Z)[O+8be.9V/WJ25fNgWa:^/Z86[H8+4=5FM5D&AQULPZ7\9N)QY@(^XbH\@
IM_bKH,RTJOL:AXC_Z5DGaY,d]G8VWf2;;XI:W_f>W1S>JW3R&e8HBS/]HF.VR0H
,HQ^<Z][<^5.RQ#8^;#D,Y>W#M-&:<G8H]-=5c[aO4U#f;eT3YF]EbKc:[&,.0L?
WEGLT=FE6B#Kd]C+dFLL@C9aO><56_:1L0;fNf.C.+a\DWRFbFWGa=L2P\H.+9Oc
2=[RT_AQA1R,<L8\)<.XE^6P(_ZMU&CWAf>F5PG16[J](]bS+YUN_R)0=aMYA,=&
d,HQ.;f7OWU)cEY7Gc;T/_SCF;b<E13@U>;TG8Q3OO)VF/J&X;Cg^E:-&_W7#)F?
IT9@.Q09_600E\GDdBDLM/L7HS_]Q#;DR:Z_.W[@,dF]=A83LF8ZS[=J1]OEAOfd
,D2GOc:;Q,[7a(9f:\;[1M#5LC-+,Xf-YJ,>R,+;cLQg\H5(BTM7aa^,eS\5&1NJ
Y/;:-b^dH5J<ZV2@eU[8P96>MW3a^K.NN5#X&&fCdN.39NX<<I_fMKK4+>&WW&-#
a]8e.+1SD&RSHJ]V=<gKJ&C2gEQ<K9#Q?2JSVD&I6Jac:&S6A#65K=R_,OV<<)=4
,(#.XOMfBZ(XWfOU,]QUL4ATMOAQd>2O+c[2&\V61?TMFcAF1:UOJ@@;?8Q1K0F[
&V)gUT:e59H\AD:VR&^c^>+7VY7fE@e_bKS3<2gf,S5\F4#&?9DK-I@K\-X2]Y2H
\A5NI+g6@QP8^+JL-YL65^Db?VeD-G=E>^7O]7EU_P70e;@1ONHNgG,[AMEN#<DR
\dXMOZS#eKU)_HI;S?e9V^W1LFa/&=_dH=d?W?A?J1-cQ>QI1E-\Q-bfJQWcST>L
CK6I@7RML+-,LKP_MX;21c5YL-Wg:66UTOF;QE>PLM[4O=IFMLZF5BNW;4Od7C)#
6aO2<5a[gGe<<bSVC[RNH>\6U94/LRMeIOGV7S9(,3Me<2:L\5,eOZ>faXFEDaVc
UF4cKLe8@IeMZNLPHScb?X;V^<28?&gBA\>D-E(Zd-V&fRV&&gb);Wf+&61=HO>Q
>/fe)SXI7/Ue_X?+AFb+DN3aT:@^JTF]HZea1/_IIfR@Q@WXSN=@cU?JTRKdW@fH
Z/IWa)>H,;d000)+R>E51KE4OIN5?P=_Y&Nb^A]b-LI01e_V[L3MCJd=S/X,VKOa
@Y^X00DSY[M-MNgEFZCL4_T4L^.dg:+,EVCIdCb;SB+V@3T-,I<UQ&X\B(5\#Y[F
7C>]\B_6:+W^X4AGQEDVXQQgRaPXMRQF_UMOf_-TCK6_N9]=&b9bDETWY3O/D_U<
NXb9[.b^=I&(6C\FU4#E5Nff9<JbdIB(.\FVXP2b,:N:+X<#^]:JSDX_J5MPYY&2
D:G<=Ja_\:70VIME/<Xa3BcXMbaZ=0ABY/@dG/HXQBQCVB1W(BQaM@_b@Dd..e&g
6?U<++UW,/K/L0f>M:5HW4aa@C9&UZ<G972=X26bg@,2IB:-+0L_]eaV&,W(LSR<
Fdc&bL>2AF5D\=0A9HIF:WG0\BeBV;1Pd39eFa#C,aVGKbM]H8AY.4,,d?EV[c-N
INBHePO#a:R]FHO5-,df@)#@+g6TUD-NcLXE/Z2U.L#73:)]Q,0Q#^N+,_S1f>@_
KdWY/7)\RKR(?e8T,U:>ZRUfWPE(GaE>JG/3_5Vg(&>Q72YR<c#fF]Kc=:+Z8U84
X8/60B?<UX/^ffg\=K5V-RQL8X_=dE6c-6^E@a]-VBH-V<:-1+6ESH\O^Ce4JT62
5HT@Y3:1W1YQ2GD?Nc5T#86E#QZH&dR[5LXVe@W=P4OE-1M,^E^OR-?;]2f:7<4b
^4f9Y79B/f&f^9_f:c&)cL^./YFY#BX]DX+GSH.&N+PJ83]&DeJ^<-9UI26W[e8a
(D,PFA1+A81eM[J=+?A-BdUg?85:5_#B0KR:5IPUXc]1E0BMV<\a&@/P)a3Og9K0
7U)BbR4f]@aO<DJ5I8X9F-62HMR4@,26(Ncc?^9_cd1N\M_@]Gc+.IO.-fIV6Wc&
),^SgWPTN_daIJBG9L:&:=[\5D+(6b\_Vg]SeC#K[AMQJWH:B]+T)Rd,_YRf+,BD
fXQf/_?dS+C[C(a;4bGTG>7_2?<B@T,ESafZMZ8UGKR0@gbM/I\=d\#5UW_JC5_4
0Ref7GR:C,VLE=5eF6@eI=3CJ1M+.61+_IJ[VO5J#^_2GcOUaHJH[/5;#JW6]BdM
W18W^fRNJI#TIK+0_d)CUY-PY5/:?WMXOY4KB,^WPgHBN5H,T>^&]6S.b+DPHfeK
LI]Wb1c@\9X3d(](1HSM(W:]_:>3ZOW2GEAUJ^LER+6LRQ#d;JV>N5<gS7W4UT#L
cNC;8Pc6egRK@a(5g</Z)TZKR(-GdbK0&>EfbV)\_)<(G0c7LNa/96/0\_X=\G0e
GO[4UL)?:,2J?&E_/W9EbZTH-N&_8.3?Sc7VcVPH;3[BG2X+Y]MP9U[(D\+Ub>+c
Sf\eYP-@4Z5]Y&0X+GBOJ\6GJ;ae1+O/(FET@0g8RaY>N;<.3Y@261;a]WEQ(:??
@cg9U0(#B+.46P:3_/__R9).8/3?9BO;<US2MYd^:7,Q@+DO^II<@SMOd#88N9+G
V&SS0_DP34bG0/SW-&\+K\LP:J&ZW:L<_d-G)^6UeN>EAa+8M#HA45WgIMO4QV[]
2S0RYKGbWdC_Q)[@,6DEDJaB\/,P[?fU^a:JN:]NSBM>Qa;)Ac7d/-7\g:RF4g;c
E9,MIOGJSJY9:O5-e=gAC<@8cN1()RTbRWN<P,S4:2J-@[g/4bd8QbSYJ/[<[c-B
>[4c9Y-E/O5AG8=daZVH_.80LWG)9,6),GTB3IASg6@]2/YI_]d8,(&=5K4eabHX
L:bE4LeFKK;#W)W7]D=0#J31+dM=_<(fLXL?-8)BB[0GPbf?IHPf[C]:?Hg^d5V1Q$
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
f<AQ[;W)L#<]-d1;,aW<=-37-1??9R\7)K0H)^QD-2F4PC=.,X/)9VR_9RTM9FIG
UB8e7BZZZdc,XY#.<DLf:Q&T(\7Z76&3R25^&V[aYP^+=GCMLU,]4d<Pf@N73&6\
WJ?&cP6>[,2cVg[T<PS[a&c-ggG\E5ITWg4MFHd2G>S:)Y+d[N7M&DKZM/NQ;V0\
cXBgA08YgU281g8Q2UNR-[;0><GQB1O]<&;bDO3c<5]]@b+8FfMXL2E:P50:2@3F
]<[KH/KC0&&JRU:JeW([J/@)XECZ<,6g.8:(N5XW&NgSHeaf)?Wf3O6&AB/gJe+L
1+LcGSB7[cU>:F7E;2,?N@a?JV#ED-gY48Kg6\5NKgL/14Q_RG6Ye?d6MTeE+&Ae
58S+GB5+SODUU1&?g9g4,K++Y/W?0JN1PM2fJ]^L&9XNQ?eZa\7G4K)<-)cQg6#[
&+1HV(YZJU=(PSag2;5c[JK#.W2.aTg)/eY]RdK7@BX^)H^R[>I(EE0/JKL4X#bH
Z-NBCUD[)#H7>f(NA?=gU4<,[+RCJ?D:E#ff:)_<NXHY^FRA7X624257M5/(GDI1
A+5+bOHJBb#6,]F?Rf_@Y-=F)cKN=:K@+/G3I,d+cb)O.2-2cM9K5=[RR<E/-b.6
6\^fPbY\14DUT(-Z=6SXYM)Y-]>08C6ZS]^O_&cf=<a))bT?F.PdD?Ea]PZJ-2cI
?FL,5E#0YS3\YWHW]eY]6,6M^,_dY-L8b3WHc5E/+[ZGEZDB10g5614fS?O^0]e:
WJ3:SSAE;+Ye0)]=Cec?[3&3Ca\7\ZgI:GRV#C6E;#?cTMLD1dE9Uc-#H)9KJSc=
RR4L[f=&Be>R>,:6A@(4EfM&Q##:(LC&NK&[M4dA0:_5G-Q>DLU)28>4+XPHGMM?
eCW+=#.B;JSDCVV=6CTY]H-A=LIBG3V57I-eBE[4)g^f782@\SC9=7P@4?.@+(9e
3]CP<JVAbK9d#\K1A&Q:fa1W8ILb35==[9BVUG&L=-E^d&cgOWKg\-<OXD<&PEHG
CS8cL(E6J]TO\ZI;d0?@b):eTdQcC<UMYUIHITCCYAae2^/\,FO/>bf6P(Bb?HKI
5D>GGW?KPGId7.,SB<f0,+_c&WeX8<OFLBMJK].C^F9M66^Y#7?8Mc<7AEXdI[K,
P(;e:RU&&<WC8<C7I;=..OWA@;XIS84=M#_JT#IQMcg23&=HBZL#DN#g4=[?I\+c
R]ZfWe[FSI7>W-&+<?B:S?@;gRK;J/KP&LTW,BU9@YA2&^FW5eFHSNBRgEa@cf\H
C#PE?:KNfY(:@\E/;7E@HTgT&9f-/;EA4UKUJO[0,MD8TIQ)/76+0IZD05F+caD6
=84X0<9FffC=-GbNb>?D.Z-OU1+cdWPX:Z2PT.;\eHJ9<;CFU:gTaMGeS[5)RcKR
[CCPOIHef]PL]?ea@7&R1b[>;C84MDXDX[)JV\>BgRGS)aU<[K]=D.P,g2[=_3Bb
(]JfFLK[=KVM2dAf)Vf9&)[_Y7KG329FH3Q4&=a4HI8\dL&G-e<g7Q4Ib:@+OF[P
X?0BU_JI6Vg]ID7[eP-+@@:ABBTN4(X?O=VR;G4bFM/>cSY.b&,6@HMUg-0;&74A
;&8T=8A_H\97[BZ>J8U:JC5fVQTAa>;bKD(]];RB,9T/X)>ee?0>6H&I+4B:;aM:
KP[-F.@?@\S\R^=S[GG2e50fVca#&_1gG6SB0?1[/e+c]HT^0]+9G;V#04eDcG;)
W;1/6Ad7JCAFO;e=(^87V&\agg&W9Y@f?#K\If>=)M>00ceTd-(T<ecDO&.J\-;P
DTPbLd^,0LXX+?2_XC9&2(#)e=FO9WP]Cf\,;+&66SL4:S#ZaPYB-?);JK;EI8b3
@/f1Q=:#JQ)9.<]V,;6D)7\Wdf3,@IUUUF9V<9_K8T=1;Q^:G\gD\SIQV/<7BDaJ
KBF)2@NC&a;G82g]B[PTNF]^[2@XB=TVB=8;U^f_MJcKRFW[K]aQL);>U^I:MQ::
6GG13/0(A<B]3ENTQ1cLcYC;&#WG/PN?ZVJ4L8C>JJZ[,NB>DD(>NP+N;><ON_=0
CV_C^-V\\\RN.?KYMDXX7D2e_.OY7IN?D;Ec<<L5W9#_VX:-FC#U,dRa:R7T&U&f
-:C69/LU:11KZ]2,OB/H@&5NOQ&29S6WR?bC,#5B=,J[c:VKZ^Y9Lea^<3BYA?34
#O]3F<B\H8#^@K^Z03b#.JB:O]2;Q>Hf336=f75fB5K^[5[b(#d()5ODI.(4?8[5
OTOEIAO)ZT@7^.a76O\O:(V(NT>9,BF<6M9dA,/GGBTR4I=6J^N#_^4\UbH=(bf8
Qgf?3aNec@9:VID/?dcI4g0IWI3U7]AA3;K+eg_3?Bc6H#J6Z,2Z6TUR-ZB3PH-T
BK<@.\A8dT_d12J5WUJT0[aI/?a7G\_bT+RC6JSVLX6gL>D-]<Y/QR@H@b-6PD8Z
,I7?;3(3=U)/0=fV_.;N_PP/ZR@3D4.E:96UPfR&<)_1b9E:FPK)K-1#5fUR-Y+@
gMS#X=+Jb[eN__(+V.WgZSJL77g+SV5+]aV.C&+(EM.TV\MS5WO;D7\dOW)377,G
/8LbZHTG],U_\1Z.f[>(X#ZOB_W2+,dJV^WROd#>aEH.V&,)+c\:)3Qb[fb^Q8>9
Q+D3MNSU+>1=E_d4D(Q+K5a+R[S?O2[6L#X2(RWGAWYS@YJ((OE)ac?+-GH+VPPg
4M(6HI/#U2AK(O.TA,>_1)U:H.5A<?OS3\Q.4-DU[1CY=@g.B]#7#(_G_J/WE&JL
.,\=38D(YfXG:Y\Wf^6N)63VcDX5gF[EY1(HQVA,>_e4G<_WB.[1OYRKSQ<Z;c5B
R8>5/H;=2];50B+6F42ZKK[(f2Q&Z12[YST;5(\Ee_[PNI_7:-PY,4c8<I,EdTc9
6_Z<I60Jg:RTcVD2(9)9f2cJXAZ(6/g=E1W[McO)#Jf?H>aO04PZQ)U8XA7cg4\2
V;@G=fJFWF8+<+fUR\bVY0aaG<g^V)G.=gAH6.E0+Q^HM@be?]P8VN\KCDLQ_M24
MJ@T_N:]aFD=CKK=U6VU9d1Z]2VL,bg&(9,?FO&ME\b]a_TTg[<IX4UA(/=(aSH&
YMJ[-aEL-N/MM@GT(A4e<<:^FS<3U2LX34JXJKc_b]9KP>(_\:J=L5C0<KV#QZMK
V8JWU6Q?^f&@E6F8cOaBSYI[bR4<33]:aIF/)Md\H,C&^NY\<OT>FY+G-SZ.5Te8
^POeDZ#57NGFT\^XY=Pc]]G7SCU&e&<f0N1d;^XDLAeIGO@Y,=KCcPgf67YWbT#H
^+F1TF;Z8+I==&FDMX-\8I/1eW/Z/=WS>X(+H5#0<+XS/2bG6?8@,^f6K;/7S5=b
4SHF93=QU/,>J4BC/R/WSCNC4GQ_KYg+K;A.MWNF,c2G+AQdc[9bLef6L$
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
AX9QGg?HUe@W8G<D-O3O=4VX-+7_,#<F<,g^8b.F/L&QN:1CID#N-=CU(/#I9J0H
>]0BH(05T[;##1]>[bNQGX#)8-e7]AA;M_ZM-;QF<L/T+6G2W7SEd1#,AT\FeaZK
18J^b1Z+RISDRdM9S#QVU93A33PfB&f4;U.@Ya6Y-5C;0RUZET&@cBg4._26A.HF
?8a(e5JE3U-ZR^BCRJa;YB7RJbK?;OUJd]>::1a\<SU3?f;OD2F+-1_dTBIUe2Oe
+KKFXF.9a>[dWTY_O#;51E3F&VDH1=AFQI--5#9G-[T4eOMJ+HdIO=V8QS\aQEUF
CR9-e#VG9:W@RP3Pf\(X&1.&_A@_E16RcTG4S>.-=b:UPW<Z:ZeeFV\?<fQcBC]7
=2NF-N3)RF/:-33a?D9f+BR@KW?+->fb_0ZdcO#O\#+A^\64GS(OU,JN6;gg<,E\
MKPF[JacH@&<gW9_N>2M6)/)@9Zc.Gg7:2U=89;SN:807^,;)>PJJAHHA&eXQV#D
J3.GLH<A?JgfZD,I_R3F<5bMXCX/Q5;#X1ZUff>(QKB,CS;F9=2aGUd3;9R[PJ]R
(A23XD8>86VN_4/F>)DdZ(5#1b6^=1VHMXCV62gE.b4g#.=?Db@E-D_O91U/E;b<
6:XQ?-Y;@O0TG57VX_BU\#L)@bOeP4fbNJD[()7,NAI87:D/=7S\MJd]/MUgL7AW
^1<>34=)\^_MgaP&HPF&_)&=eOR1;&J,:]-LBgS27O\=M)-cd[@9bY,H=Ab71&)<
U..?=^YKHTJEU\Ec@,fPJFK1E-WCUC^ZOQ__,=N_ScgFI6)<@ZddF/e]A,Y3a^2A
=Fa;@Q#>#U9K;I-gI5-I(GEaCWAT=5&IR[fP#a>7bXIfbKLRV<&5Y+UVBb_37<aX
H^9HS]Q2AS(9g\&LX1]B.8,U3OJVaga.-VDT,db0bQQ:E).IE4aV1AY92@28XXZI
??ffA3<WQPMEQ8(#@EP1LaY-+G\?.&DGR-B5FR(5\EG2L13071&U)\M]DNY5P0a?
]^3a.d2>PESR3g+HeU&/DJ4OWH]XMR,eE6O9EUKaR@?[><FD1Xa6GAQ.Cc0GUdd[
)#-4L,,<0LXCd8;GDT-2AS[[_IAdS5DcV9eF8K-K72UL>5J@0QT)^.2XV#EL(\LY
E3ffZc1fdS48/ZM.W3^N-ER:OVYB<-PDb>_XY>;>gZaFC<b;_V[VHD0]26G>F[Ra
/_TLO,8-,7/E0LTMQ;-;KBf&H&.FW3MH^N2;7CbP87\d9Z;N&Q8_dWbG6,E@0Tf4
,22?/AC;^7N<@MJ4K_OUf<aIJUg\Dg36GK>?9OF(aLKe:_^X-&WUa<5.U.JMGebb
+&&;^ZP[G#1VA(U0#T?LO7b^&O_dV;b]@d>:/e3#5N\fMI=JI)f95N@-B+f1aZ[5
<:VVI3GV./U?4LL=-M.B?C5@e03T=5Y)<RM.(D7V0gKM)Gdd\\a5(R2MFgOdY6+F
R:+H3./M-;JGC>/=Xc6KJ3Gc^a@,[afF7(@],/(>L#1P#6]?;5(.+27WS=-:JM^8
A[VKbS_O9:9K-7ZSH<>,?J;MJFN+@>H)&],&ea;)F^AJ\6K@D\,BWe-bFPbDg&^0
[-JZSG:(7GdA-=bfMEE0/2H=SZSH0VcJcJ/F54419K2<2bDM-e)VNU+HTG9.f3P,
ff;a#QGSJBDH)ZE7I\P0GGLJ5O,?G3]096[(PKUBVScc#/36RWN,/U,.]>URYc9=
[7ee4O?ON<KRAK1D0/(:J8#4GI^T/\+FZ050a(75Q.6(=@[Ma2#KOPL2H\59:S3B
48FOc:I=3E0gO]04K_W2f^Z>fU1dbR7>Ce_bUBN]A4dXTNF:DOaXTPb@I?f3QN6V
/E)MJ&LO[=eT#-FVY0\[(Za=JE;1Z]H<:=9(#1E=?Sg,99)US,-Zad4+^R;dM\IO
C,KZXcRJDeDKb>f>,]+P06T84@]Ug-+-JW\]Z)P\EW]19?)?8O04UP&QHD)AVIaA
Sfg?D5N4F5BS>:7G2\>A_[B0ER,&_:24SDE;aKcN8+QGQ5Of=K.+NP6d<XRCcVOZ
VAR1@Q^-V:JTM[g@b59;GL<SXc[]=7Y<J0/(BU73e/)d9<cGDSXd3=5fM2a^]fXD
J,]d.4-N7cOe:LL?OGL-N)IF\4_U/)A-+JE[.I0aS#\5WD\^:WC(Nd^bLZ_EWMXW
RMKT,^Q&/M.6dIbdVdZ372Wa^VC:=g=X#)\9[XOS>NcP2E),MYSVU#5QYP27ZMD<
:S3;V)([MU8S]bOPRDF,f]2gG]Y]3V?F,.^=IKKgZY_4M8ST8^DA6VK\J+]D)D-@
7gMOfO#H7G5\:G>\#AdNKG5^Gg2V]9<23\_Y/:D-=^_=:RQXNBFQG(7g75\HBM9E
1@aT@a/(7<H:FL10X<J89XZPg<[55?<&M0YH-_GN]?;&-GL>Ve#E8I4I+-#eAgQT
G02AVR^8<\L\XU^7:5JWV/KYb/EZWDZITQ2gR^>P<D;bH.:HM]58JZ\AHaSaXQ]/
?-^SgYNQ_Z2NM>aY-Sc]MX34FMfQRfJK5V2DE<T=0CgbC$
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
cb3>#Da1][cZ,-/\9;RC(VRE=:B?,02F-1F]-VKc&W5_BOV[A8(9875]8fVY)d6E
Q1F.SMSf.XI]9?H&_b=]<F\ZR;WPME-KP(@adIVKMAc\SC8IHd.CUG#?&A5?CP-B
?4SP=>(]ZVE24?0O0I_4&0+&Jf>L5[0bH>Q:NFW(d[;-7@=GSEBQ=6FISP8C6E3H
Y357,>XYK9()E_]YGB?:MPTZIg<LafS\8c(3/Tg=-Q&&1[\/RU&MJ=^?bROJR06W
48,KHB.Rg1d#/7bLJVBB)0)E>@-IBIY_O_7>OPUPTP,^JXL2WBF;=d9AV#+\10aQ
JYM+MIXVb0??-e8MZ..#CA,(-:af:Q73/;cg)E3b[CUFC5PefgN1OF6XRQ@U_)7@
,U>(c)f2G(](f=1:[LDM9<^?;A[&X#)FIH[5&#1JZ],W/-B>8+L?&be;&-Pf.7?6
K,MR5e8d.XLILC1)2N]?P=AdAcA63W^@IN3;cQ5<_Q2_(I+7@>\F8:BP(V=E(-=K
dG6,G#(JCg37+X(@1+#YTSa2KaePUPR.Y7FaKTE#JJd+F@[O8<cQ0N+,fM#3K[.V
d8e@O-f9LeVIbG5]F<;M/BOVI<UYN1,)T#(:0KQ=G:BH_L\=A4fR_FYZ)ZN0#ZOY
]a]aPQfN]/9^)aF7LNdI]Y)aYPELeI[5PJ]OK(P2bf)^J5T,ZGf+U;+aT>C@b_-P
;OS95;+J0H9=]H9UB@)gJ))#&=)f^.LT5-T4[O&d,6<4>TPT)MF@>JCaI,f)R+;-
Y.FLUSRINLBEe-WRUIJ_gN7M9PKJ2;4Na^-geaZC9(M9CCE(+J\@E/+IUX/_LP\>
_-^?^&IcJ/g__#5DRILWFEO&5W;D1>^B:KIH7Xa^)F/N5G4Oc/YF,Q=[4fO^PTg?
/g+UN+dTcIX7fQ0&3NY\aV+K_c:R^BAK0Ab,?Y^M&-E_DfNNgCeQ.YZbJYDaC+Y&
1fY3&XccNH3,Cf)CP)+Y,=,3AA#EK\0XO\PS^R1GNgGG.:Y/EV::3g:@dHBa<cfN
;Fc3K,Z@XSG+1cQ8M-.DbK/H6R\F/]>CA3?_?2;G.S@6#O0:5N_.6O#):F3&+a5=
^c<4K9/\LESE3]1ROK@bHdR8V+:]04gbFG(DV7^+(:Sfb>;60(XUV\bg;Ee_gPHL
@X>J>2ORR-YW^<IGP7ZJbaO-M0=W8I84/>N?cZcFF>HgY56fA]DEZI28A-OE[EY4
bf52&XDP71W,J\2BJfZ_(eQ),I1K_EPf-HW?6CZ;[dGG\01[]AZOKeMTV?/Z0L6/
(]/GV/M9_@aFgcUc(X2CRZdMAO_>]Z6[Y?cJD3DgIU+,<38OZ[&>Z8Q.d-:@4UW,
>(<]^-RgfYNJLS124KK8/</WE+H?18bKOJCYE?RfgKZ3O,HS:aRe&E44\)<eXL8Y
:P)S-VMP>eRAbRILSLa745J72Q.IFAY^[@Q,QWIAEB3^N>8:cUHC[G]6Gfc3f7<.
E)fSZV?^D:503K5]D@XX?1Q9C#H8C\D^+bLJ,ZJR.-GG13IA)g(&<4G_He[H+G2W
eUP(MO5S:6YENL+]Q2e^1/MD)UQ1,,MZ-;?5D9[:S8:=-;[G<G>#<>d1[G^-T0ZQ
H_.<&=+f3,fR2V\R&0gb7:8H0:_V#D2fT=J(89Z7X304\&U@DQ920D+PNB1[O)H6
@^;,F6\[^.#+IM?7e@71SG[8(B,K#3d3dLYN_XCP9Q4@EXX\dOaPJ_PE:3T(bg_W
M-Q&9;HJCS,<OH<SG..Z>XS,cG:Ca_+ZF__NR]1(@E)I^],K8Ed9edLD7WJYP>H9
+XFJ;-ZA]d&+NB2Yc7#a^:=AS.@gCZY(SIg)Q_P@a_ZCV\Vb>B7g7=[@_5BT<e3H
Z;[J+DUH5DCRCAULf,c-LNbf@X99Z9AGB/d)M(44LAV6.De9;eS>;O61.Ua;e9#5
-]A_LEYL;4e=U-:8__Q9e:7VN(2KfN//3Z@;\WX+07Og=0e&dCc&/]N<SB/K/^N:
PQJ/ZG5]K=<[L)_=3]F@>T44.,RE--4;(-0Gg13)\,e2J,0OfDLH5IVc[<]_1D>F
b&N=P/SOE8?B(P7.#c:3aBI(f0,We2:TL:(7#KaG46dT#=>OL\d7,),#ff.[#:b6
?O2O2NGEXZQ@2D5(XU6OReKB]g5R_[R#>Q>Md<,[5MK-6IEYQ8\;bN.)F.A=<XI0
#He:[COV8#U7O;E,1RW>.aSKH#=599-A<9:0Aa)WW7:7W[B=D8D0D3K@?W3d0KI/
Q8D<621]g?>Ge@84C>\2&@BTCOG<Y]I/+d1:6c63V?UM_<N.O+3YJYTg>>)VVN+a
Y.eXR9,ff)AB@P(23M\20KU2(8??D2E4dQfa_<-,7dM=A-IL>bT^]6<F3PT./MH5
Uf<a@,W[Z:PZA#\ScXCL2eE^7BFGc#c8g,fQ;C[GD1\QLX+2?.edbCJ[f=KBC7[)
)6=@6>N#;?ZB>@6faIE<QNGFgZYUd7G;IG.M;VN/?0H,#8Kb+;KLK7SaFKF([2<#
V[OHWX7_63N)bd4fd36;4BD0&6DL@>1TC[.;8=_G=(&+:RFO]cY?:;\7IJ>(#d]<
I9A\0&].bE)8ZF>))U8g#V\JM.82^gM]ag[]L]K_&2,S-C_P_E&14:UJX(IR9ZB6
G>C>KWFNGG7^\&;.INJ\MTN9,A[]QfNV+3;<eFO?8274KaYTSU]5;B@KN(FY:,AU
gKB\8&+0(C,/&-N&;7]R^XN7edL83,M4,U,E[EccC,f-Cb-Y,^:M;a0>XEL9S)EN
-E:g4]XPa\d>Pf/+gPN/>C)3._NQTI.]<?D620SeH[8);.NY5J=#4d;8U3VGb@)>
+FUS^+=^?BK_85PP^X+,CgcU>1,T#b1,Z5a])K.D#d1Y,AeI5)?^c2faK4S0fMTA
FgV^-H.J>@#VRENQ>[T5YYg,[eIB,dKS6EKG)Z44g#Q.[V-@/Q2VMJ:_C3DAcZ7_
XKP)e\Q6G)+KQKNZ6gO92X5YCMJ.fGA#Z__GG>@^-XcaT<dWG9.gMc4C\]=)f17?
^OET+RAKB4^gHF+@^(6I3VUYE2>.MO+]-S&56,f-fJaU\9Z[D.MYe<]e>ZKI+?D)
#JT)f)9H<+[0VWA(R.g#3[6R<+Ncg_K6,4GVI;@AfN^ZN4>V.GX#)&BV>-+@.T(?
2P,S54-7(I;_d^Rd?0):8^aAKJKB@#:,\]X^ER+DEcW-F>B_dK/fCgY6_\LFa@),
8Ve?J^#\0]]Ecg982CceHY63#]QSd7+VSH)C7J]LgS#_[G&-S-:bG0@(7[Be<PUV
1NFQVSQ2^<9]XQ[/1J-#:)AT2^5JWKDR:IDd?a3]TY(+eQ>2@7PE59Ag.AIaCGR/
NLb</R_e-:7:PL6>GI0-1T5HFHDS=Ka6W2DV@)3E^-6N.WIJ^?)b[#=e=)M/,8QS
@XUU(g9T+e4;KW\PI32)1OW60^,G3e7/1H[(F/c4gH8DSB@,FX^DC&C&D2)^C@]T
AZ+N&19Q\YQ+?L]]@_0O#_bFG2KWZYF[3JMFF^#PIVY2)76f?GO4AD/K=a41FLZ-
B9#-C@RL7>QBFf;@T7S[CFc8YaAES&?^P8GW+,-/L0f?C1N)^.Z+=DaN5UZ&N:L<
3U?KHE8XOb2\;d2>W_O331,5;/dGL@L\9Z94Cb.DH5I=H\_JTfJHZcD.4]D,ggB_
I?T/a5S:E=L9gTE-YX)OJQ35A<?3?X0S+b.8e<T8M[1dPE7Za/F:CO7<E61K8?_O
=GJY=GKfT^#>NU+:=X469+^/W9a;f>51[Kb\/eHM^@B^Y\Q3.T[E_2Jg^WWZP-\/
PaH[D0bVK0Ea^M3e/T77>OgF@L-/82bFTH5a[&PI/W>M-_G5C2Ec8NJ,X;_8M16N
d3V=1]NgH7fJ@MDC.@If6g<JAAdUBcJDfP?,96_H&08@W>ZDVagcf)XII1/(V^[&
\g]J0HL?7GUKX7e#RW#9@66Z?R@)\?Pa^X#U;80QPTa1EWX_K/#+WL9OYJ?d8+?=
.IPCdELCBHGd>C.SRQ1Id:]-]^@Vb&;ZQT:SfY9fPS199A4[N4\;L#,8P\CDbP2>
-IQeQV6=GF]Jb]>8Ye=ZAYbTPc.NT(AgGTg2=bX)Mc];a]_Q(F0b>]R/a8ZT-S3f
cTCG];MAHS6(\)0-1:,<@Ed4b^06Hc>V:]3e.J+cO>8LA,I:0V&DC[AdHD;Z/2(Q
[NUJZA#)c4)G8OLOc2.>KU5<5Q29ABgN&=c6:QA@)a_0V+)BBNQ7)P=)8GO(]JWH
N1d.Tc+LZ+0BJ3WXUceSYdbZ87OFL0V5FOWfg^E<UXR,/A@XVYDOGgL2V1?eK;-S
:FW(/Vd\b,U_J.FJ)U[d@V:4#8(aJb^GKE8&;YH=)L&S)_e[5>+2,/(REa,H-3V0
3CNY[+3C\TcR95&+cX(1a7)\_P9Y;/U_Gd.8AL5a\C#RS#E[MGSSY^\eD7:K=L72
1\R(LLeaKA5<@&:W[BH>+G(2,gK0T:dAKY]&86QO+4:e:Z;Q2S++E;deX)bX(W^\
^\3M\Yc_5:&36EP-]5\9Q5CVcO&4NC+c1&<O3U.g]65M2^CN4G>0C:cKFABgdY6H
4B8[e)F,(5NMJ6+=8G@Pdd;&7P61@1BX#bc:DG)d5NPR[/U/HC;0NbJ6OY/2[_P@
.=9D4d4aZd6B@Ub+A[c(a?VL]dL+;^19\AVPJG9gM9/P5NDLU6K]1C\3\V&^f?e(
@T4-58<M[SOfF\U1d^1B_M:W;a/[&KK?J@]G.e(RI>EFKZ#O/H6;=f>N>CHH>e\?
FN#Q1OW@O;4LEdP.b-<.6F=-CD=T&W3-fB;=TGRGA+<T]fPeEI9Hb8T<BI8YI5\G
28JENWd,10?>;gYZDGMPLYK[aU8RQ7XVC5^aCUM#4aeS?L7JL9:ag5d?XdgEA,e@
49DU0LE@;Ec[e0Nc3G.;:aIg6AUd+f3#,0fXEM)88+JAP<aO)1>Va8)(I=4MRf1D
f_U?a_@HYe0gD8.#^Vd-T^C/XO&UdD-.,YM-;?GC3#:8[Ec<WNaU?,.fUa(MLAD5
.QSPE8]bTB_Y@OZB48Z3TN^;A@Q.M8aR8JfQ&S9dH4K<D4\W():b7]3)CRZZ3Zg9
Sb\^b1@fW&RW,47I9Z,PKEJR^R3N6,7cgLeSfM;7gc<RFNRLIS5,4J4J>5[=&PF3
9N\D=[-fNX?-g+_<+bJY>34B@UJW/d_G9P(2Z3bV7Z6./[.<d/>?-B^,65DP-^RV
C2MZL_A+KIJIeV;g24E,=07N\:)UM4G0OL@J,T=_B\7[NcAIGQK\ZR:KL^EJG/fJ
H/GM[E?EcPa0A6OS--Ca7<OL7ICHD_PSP<O_,7B7V>M7V+H]Xe#Ce7/V5IS88:]#
VdQ^J_.B&[Rd7-+I:;UNOQP<;:S=VfU[LGPJK1;b(KBAVecW5C<gb+;C4#_OAL]:
5PXOd8abMV8]DWQIGQ@75ZcZBN-IWg5C5]gOT+2.<:H])=cH7@M<gVPc2YM?TQdY
-.\/=U?[Eg7[-Q@aO0WM+2LXFa(a^e#H/]<+OY]-MTBPfG_QbQc1M:\U,:^<ec&I
7)5DF1><\3^T84:?0:4-ADFJ=OLSKdNV)ODX(05.8DL\:ZGPP#KE5\K#2Y224(W&
2:gV,UIf./M5bL75CGEY,c+e8PD,]JF-@aI[4Z=TZMN=?-H:aBXFHWb7eeB6=]&)
IX2ZcSG()dZX7FFfRI,A3+[<^#;;XdU?-_4MP=GVMX2\-Z;Ggc2TK5Gc-K7@40RR
;DF3&?[JG?6?cJ.[>@)2,d#ZHI_CL2ZGS);DO.)>FfNY\Z7-&13J[HGcJ$
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
?VM;dT:ED433=GQf8PRT-7@E)HJI,?b<8E_5)=V-)<cfg7->?gA:<JD;)a/<=&B_
eDRZ8[,.IVdQ[TK[U6D\Pad3dd15;Y,S]WY;Vb=H>b]W7?1PW.Kb0LUC2ag9>I9g
D0\[HYf4M7Zg,\cI]f.<f+E<M0)I@DeOdL]f[M<^S)073;FaC[6W-aD(UI5;eH9c
>)VF7._<P^&BgU&GNW00NI_SJbM4(,=NKM&NSBaC5aO1C6;VJB5EVJ+M,+dMTb5Z
E-BL[5+=GD:Mc4<W/Efdb;653:/J+NG6:)DN#CfD_M9=>0fUN\)W?8)?X1(.,]#W
L#PdZg?\1gLKQCNL&?=T(VM)CPBbVP/)b1RR-Z@Kg87<#d..45;TP]a.;eWLdTYb
O6HT+G0bQ^8GX@Z,M(S^-@/^7VbXO/^M4L]G9TE;9A1^7@@+gb,+G34;P0/eOIa6
.gY3G[Ag\f>V4I9JRR>3PY+]W\J?RJ#KFQ)VKB+IFdeX@WKX)ECJ(0gQ?8Z+1Z6]
^(6bTP.2BXJ2R:H5S&QWKa\A=]U)K,RcK[1N&&.B>7fRYE<U&WGV<cc#;<a:U_AF
)3LfTK?-E8eAP0BYU]>\\[.D7^C:A;S\YJACS3TCKM5G.a4-\Efc@c6Q)@db[,M>
95@Da92a=D)LP:4G.Z++.+H<VMf;e2b4[e@Qe70.3O=J)Y:<F_2W0HW?]4)]6(ZV
8WV6NB@acRBMVIWQ@eD5G4K(P2/cA8VU.:JR.Nc#5Kc2M^[cUNN/)A)NSJZ2X8EM
IOIaY:UNQ4b[V^:XP:T\[HJWgC]c61M=:SUG5d0XT2Wd8bZ]0P]5]OPS&C]\&LO#
8;E6FZK(7(Uca9aR3P:)6IYJ#gB1dJL@fX6WM[ULd2\beZfL#YSN?/B1/I]YFJE\
,15;D]I4:>TO6JQC3KJOZb[L[T]+IJ1?EX_Y4L.gLBG8JTQBY@,S.B_0T?<.;4AX
\EZZ4_Z=?IARG^;J^XZ..&R2_bg&PZ1@ORdd:-T61Re]3<eQ6fD(gG=EIHVH>(JL
<7-,fQG^UP4M>a6/>Q,D/XfHQg/6PeJ3e^1\<\XHE<?eZa\WHb;GH@gA<4^P9>+A
,da;IKI&LT2D_)I0Fc4-8(^T[SYT9?NA=_#LCXSXDD;OX(484:6PHP+0C\?YWO(B
3B@VOLH;=154&)ZF@I>M@:b?B0Q[E[1;7TJG;Z07(B.dL;K[bR#UKO(8H1,&XOWT
_/N?NF+=3^#CB<[I;Q8\0G9EP&QS^L3@5=8O/_(6C(2\SI?g#XD2+;?Sg4ZNXbf5
g3DfM>=HS+GId0@S._P+:T^YBODf:SFKZO7.0TFWLQ^TKKJ\^.E@S(P?HWEJX__U
TB3^R@E(TE-a7W951V^B?D(3+I)c);3A4@I<I;KCUXObT@a3WdHe_R[\\?KbeZ9e
)#gS:/d_]<1HI@D_Yb[GR4QT6eAM/>H3aW.d6:A95eDgRJ)1R<P0-A\L>Vb=/3H=
17N=5_J+OFa8B62O:.(GZ7VIB-09BaTBL_(:DGV&LSCR/,(^?U;KeT60PeQ\4Z?D
b6R53]);V+a0@WDZ19^<Y-9A/^,1IU.NVcW@1G=HMe>3.Y&1EMf?d<.2Z7E#bK:e
g>_g+Y52Z/RaNcUW,;c/YQ9.HZQKTH3<EV=?e6KDF+3Y8H_MH\;[#AH88MP(a@KX
>b,Nb>RMf>116CRMf#(\A)^119(K;15ZW[1KKX5dED&2M_bE+eDPTd>@_<Md/K9_
ULP:2Y+HE7@eW]Q(CK]>;D5dKQI\O3+Fc&;875VQB.K?KPD8E>82]EDL:g(7We,.
R&c2/Pf:@Yg&^^3TD08XPAG(cWaSXF[\Tb,BT_gBc<97J(:J0fg7X]3gAJ?B#^NA
X08.dR4Z5:_1<&.UM)HRgaVD2-Mac-gFYH49d@Y[a)\KW66gOg#YdN=;UCSCQD>U
L78I:J8QP2cfSfFZ76<4dZ>W#D<]9\7;>8C80Q[fe/0M5?BZ4ZaQEa)VX2BS\dM8
=B(N>)HT3RdNX8Y)O?P&/(]>QcL;f_JgGFQY]1=bBDV1R(fIF:.2^[b#b-03EL(@
:;X/dI1@=1N0>;]E+TSEIa1c/[TZN/aM8f;R5)0S:CFT?,:KK;_<-0gR0b6#WDX]
]B<^B?Qf7Q<C-EOQ6JgIKE/_Q0_Ad9]EEBA;8WR:5QA=dGaK_[8e.S]>RYFdUa/G
:ggKU10Vc(R3ZdX]9d(S-9XKLMI3NWD\dcFUJOAc;0)=1@GI84M.Af6YSC,R.Z9S
=BB/\.XQcO@30$
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
