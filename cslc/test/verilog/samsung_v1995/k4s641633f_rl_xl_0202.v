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

//`protected
5:Fn7SQH5DT^<KBM:2[[_j4Cm\YWZCPKhLAI_DJiM39=bSV40oS_jSP6A_ma0<En
^aCj_Apm`f?o^LAHDHB@hJ`TF?@@:T8UC`aE2>1[Ib_ah];elCYXOE0l==2T22Hq
jMU<DL?la<LlfTjP9lMZU2fLT\08AVR4bK7f_gf7?=\VTQ3ZB5M8OS2?p@;JXCHp
c@>RZmpo`W\;UipL=2i:i@Cf]QPT0Fd4gVV1lB?^OXNa:DQXWJ8p;Q9K=l>H<E]G
T5]?0kioSai5eVOJh:XQ=EXf2S1dBaNQWAHHXF2Tl]W61hYq1F4nYDWeSZd:PYS@
Qf52:hZ;:Q_X];FKPYEL69p3gO[n35aYmE\MO3E[ZNaU5l?2PlJR_A96WpSFN?C?
3N^NcieJVkcF[HG_C<5LHnI5oZ5Y6i1K`:27[qgj>_k[eG]5CTfNDNc;XaFZNmoE
A^5;RcR9G[1Y=<QSVpoZL72FMX?UA4:aP9B;PN;28Si=@TKB:cq?8QZeZiKG]PCk
hgafmH0EGQUAo5UXYWa3BpCeZjWS>cMB4`oid^U8b7OMVeJ;5\A3T1TmLO5ilbDA
miB0d``HL1DQ?>ZHQ<E2Aq45<kaFo[4SAX<eKH[^Khn\RKTC3UP?0pJ_AE0@0O`5
AmoI\ic]T0GQ_=Z1k96K61[mI]M_TP6U>ga;dKMlJS1DmK=<qNXO7jndql\_=g21
emEWEC6;RM7<;Cmcakl=Nho:jeG]Ap=cQ5k9TCXFVK2o2\^?D44D4<ea3^\gbk<S
<nJ0:_alDfqa>V>``9]VRJ4gA8\Oje<dg52E8jLn6OebakV>HA8\]2lo<`34KDO=
X4L2_=34X6qOijkK`2pgR[a[_c5jVQlTC9W4j2Z88<fNma9p>;B1g0i;NCFjo199
kIj2;IE4_23c]jVJ9GC`3bdLQ]K_6co>HJ^TLaWPpe5]X\C_C=NAeTlnY7^9hi5R
P<1H?K]Xh>6qE?lLfDGpRMkMm>JpkhK^FYbiFN2A664@Yj^N^G52b:l4IKX:a^YD
NOQl_0nT>1i_2RTFaJijJ>cI1Gl^Um]Up3DJ?6n0J7[`8A;VDPfUPage>[cBI\cQ
SEb65XFXiWU4>PI1]YQ\7NID8d1IJPOekQEFSYcfhKUF8F:89aj\:=bf[Q4:<O0n
?DXkRJT4B;4?:XU[PYCq1[G8Qb`:O2hN?2`5nB7=NXmXnRoJ2SB3VETYm5Rb^>eF
T^l?82JjgZ]\oWVWpeMg?_[nLU0lQ;lohIc]@0m6VU[<F?la7=<;<`9iE9@1iMV:
`m_p9S5IO4W9N?l\3IZnK6jj\dd96<LoHH<=52_Og9d?i=>JmNj^8gL1qGk_e3JF
Z\cbJeJ_]C\QXQlQAZI;5M4VNV<V6GdS@?:1e=gY?8iXEqCE\W[jA04NYQbLQ5O9
_R?UoUBkC>=1VfN``j=]QE7kgS49:I>K=`eVnD:?QEK>XVpOWj@]T]8QkAJd3QR4
1o6P`H1Dbbf:=20`Yl`EN<B0ejEPl^=>E]4Z;h3Y\3qfdS9P<7l=R@?X9=GkQJNN
XRJXWn8f>22h\n`DR>D[PllmeDl`0d5IHZLZ3CGBUg[MNLdKZoXRUJZhR1o<Apn:
C?[icTJ7KcR[OeFKUYPWcmF7dXHK[V\JK71\FS0DI4J=fHKP[JUDbhB7LFH?@=>o
=DAFP4aRNl3jON3KDe[]bj>nkn[@1e3fo1WBU_Vlj8D`YpLCRa9o[Xc5fA_]SdG1
jT?beBoEH>`@;McR>09L:XgY=M@aS2neS[cjRc78GFl9RBp][2IXA<Q1Z_12SR7a
RoEJH=q<7e8M_656kGd=FMT9Ho[IFY;R<F7<\E>nin_]__3PLLk`@AR_fZN=BlQH
8S5jVS[ZbQBPN@3?[_?B\M3COjTNjdR2DcM<c;?nPkD><q?oiMAMlT>NDVfOP`3]
0dKnE8Q<d[gn=QnGP965apjUedlOLFbK?7nF>_bdc]CcIJ]OY1Sg7?ADX056Qik2
SjKHF2VSN6W98k72<R;J]OPZfA[cZaM9qSPc0cUEZm45lTSjpJJ>Mk3XnobneY0f
iHP;`Dce0dP=XfGKE?XHNjDqI4_6chh:hA14S0@^9XG\eOO71^mLdGV^?WoK8HYq
?AZmU=U1D^HkC:;<H=TZ_6p\6?oKo@l_6FCH4S>XQU9<J>?TK;>Wl2QQZMoqXM_;
X]MgWkjOPi@I_SEE:P@p[d2O0TSfPRhjb6iAY:VjB6Se_So_qB<FWN:KfDSPYAbY
ECb_P]aHYmgD8M89T<hqolk3TFee;?=7N=beN9p3KBGDNh0mX4V@hk7?<ODDK3e]
60hODe\Gi=A:6LpJ9C3dl;2:c0;_2X88SPp]P]kbASkP>d`WhWY^9QYQ@S4kmY53
]bNF2=qE89Qd6<_mVVCKoXH1kF]PjAGRLc:biX\d_S9JFES6gF?NDYRCORRn_A\l
hmhJ_aXaM6nC9RD\aD[_Aq]`BiVbA]b7Ko0LD=5L68QL5mVi=fXWdl\=ZAq_2a3l
^UHI9EiNWPlM>VZ[GQZ@QU@3CjAfhQhfJhOZUKk^9=GZcWI>^fbMgH<jA42_QX9d
3$
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
aY1Z=SQV5DT^<VC1kkYEOL9WIS;QXeQ]b:TRLh2dgbNJgKI=E]k=_l]`2PR<7<HE
HJhRJeKfBgq^_fZ;]A`3onNhge\_EU`IG\O>9mU`=c`MRMhLla0<oQ0<f^ZWn]G[
K9Hk?p4DhJfCb8bmYWHjgG7VC`8SUHkMiA_hj6<mO`B9T4BRT?USnQof<[]KGlpl
R48F^p_[CfT`@>?Cff_LK2=0^?NQHqn5aQG095Oh3g=hC79`QmL_XZL5[<YhK^C<
9MEDHlOP4TfUEpla0k35G02l6AJUl08mbP80n_TXbHlE^00neLAJqb3F5DCp\WCl
IKN<3F:VVOa=I^R3DVJ[:<>pOL7SZ><l^1JbP8Oq_8W=VQI_>IcmlI@>\f>@elME
S^S@N<PcnCcUKJpB?=]WRS``5b@nO:h=5D;kSnI13@4=nAY`\3f:m`N2acRhES>Q
IWHFc2Ob;PkjaC>ck>p_`oiUD:9NkcK><F_aIM]PBSRo@EBglm[UY[M=P1^Cb\0b
f]A11A][NQA:m\SbJ6qAgoTahXpeUSX:UaROiDMBcHTgD>Ej13l]n\?TKXg8bC4M
bVbnF0;MaDK?CQb6<2^:hl2WPcqhVGe:np0f2hN_nTRXmSU1Q1DP9fK@W@UdKc=N
7p4IMo7SDUb`;8EO3ko`WQ2YE[TjiCZ1iJ7Z=92o6p[VR6CGhA:M^\58eW^n9FH<
kEUFkE4OeApXJ<1b7qDPBV1f7L<gXZg6\KBLgZF^K0RIWk:8dZoBK:Ya@VKJC=cd
`IB9SBd0^8hO<QJ<NBO5qH4PTVU\4^N]dB`TmT<^T1\hFqQXnf:\Y5l\jSE7Zbf<
H@?6Em6Qd;3R5dlMOE033QbalTQ\c`3;a6GOp_]OBiEKil;AD8OG@R2cPmoKW?17
FKBME49>pSfkn::q?X32>EZp>O:YI6bhZM1Nd>So=`Ef=7o9;6B;LHkAi98Y1bLl
CPgQd9eCN0gi]6phRGe9K1QV6E`TA`[k1k`jYq813LC:A2SW4gcO\U36W`S[bp0=
JNOH7\^^F@MaO>SglIN6eHLB[Unece0M?L6hTXqH8cS=6n4QnG0NETlRA<RjL4qE
\eOocM0d80U04P_k0YKCe4qLH71]4N02mJ6S304=d9H0hqi=10n2KFP6RbG>[gGa
I]813\6Xc6ZU_?ZCcoX]_i@aUV[JZpJLj`O4^LVLh>n]QKm<Rm4Wp=WS@AA`;>eI
CcAMgRh=VkXqE?N^=7Sb=:5:>cP^@cB`U46YW8:qacmT2bc3ZX>jNGjnl1B6RQ7T
FY?@;LVSO6R2X`pdJLgPm5ClL]UWNLlnGdYX^Mg]oHqb^3m:2_8VjY@K7<3`95D<
:]G5>_XqNk0=\m^L2bRb_=iHYm90XbB9Wg74p`OL3ao5<OYDn@JUGHO^H`TQT0;P
pUe;7>ZCC^@HQ?RDeB7S23KAYNj`JiH6qc=>:nNETKBLI_l8AC\5?@^IIm^9aG?:
TpJj0<;?KLMn2=JjA>IKcAn4F2J_BfpClL86eFZjA\Qhl0<TQ_9@2=MM>^T9_No;
EI5J556Z\e=0NkmZ9Ol4^UW42q8I]H5b\P?QO:n6nLoZnF<>C;RH=KIT@4682G0=
pHm5kJ7A2CFj;gGU0YDS2YVF=oK4=@DX8iIqKUP7Z=phG:4`Mq0oeN6kpkSB[Ikq
@QCQ\]YBcBAWE93HlkoXfBM6]N\`OI6p;8GbmBAb7ZAm;iYq[:9mbI7BYAn9W^]g
CAc]kXS@8A><UF@pY2Q^9:OmNcQKQ3P<n;bS?C<AR6hkX0pc3jC^CMlmIEaOj]Hb
06Gf]=dTfY4QWpeT4Q=E:<8ohQI_mMb6AGloZeQKjgJ4kkWV3?R;;GkCN^@Xb3`L
9SEEH9p3a\N4\]m7J6_^ae_U0Wq?j7Rk3pd9_@AopdIQ=77q>W8L:g1n`1SO[DIG
5Q>[U=D]eKU]Fh1UmK0L6_DJ4I948>D2Z9D<?]o\mEXFolqWnGn_lq19O8DnJAOT
JNH[<[Ik2<h:2hLmie6bGq1[_8oIhDnXWb`2H@GDChnI6C;@JfD2WqRnW];ck@jD
oSS4b^DojP]7VgNN>Uc?pJljEGi1GeA1nW=ZMBCNZ32\^7CqHedZQ]gJ`F05fTn`
Bjl2Mo7d1NH6>bpGaW00NXgq5^@b3EPp4Wa4X8SX:b=5:2:nCDMEEk1Ta>2gbBQg
cPL;h]bBGPM0YU7m0IYLpP^CeF>qnFe71]OpHo\EZ=h07BV>JfgkMlfE<>Lie_D6
E^Wq_l:O9>W\X5c^a<6l67j@5L[Q^5miDbgp2B6^2TEk45S6od^aSENDNn8e9WQT
jSpP:SP<1FhNgf1T@<]F8>bM>cajhKB\aqjT\Z:mmpO9DOAIqKe4f7o2pV\855=>
:VJ^VCIfdH`m>J9M?q5[U;6e;i^@aa0C61YDaEh5KLq8?M>Ci=VK=mi:EnD=FeCj
Cd=eUcf:8q\g;<bOZcWd<0iB`KdYA4]JWig6^abZ@]`Jphc?>YFBC<N^3WV?I4S^
N8j9^fjXg;5KGXZjiZj13\9=GqobCPjRT9NW5UZi]`N[gdXmVH:eG=b?JCp=TL79
32L<WkITZOC5EiI5Xn0?C:G<`@I0c0LW0UqbHX:5AhJPOI8V><]e`j>33VDQ]:AZ
7`VmNlhJQ4Tp>gG0QjRf=3G4W0=UPZO6KGWfJo6GV`NIEB0_q2j[VIi;VT\cc7c4
OHOK4ndh:Go_8A:nT5]\op`d4GFGBJ1<C:D679]HB:aC4=?HJ[^Id6OV=iqQ7NOU
JbB_SkRM_GWS46kNb4]@DWF`c]7@cX]8lAfRC3Vo8jTAbC`PX;pF^nCT6^calGAf
5VKq9@fTfb?X6jG79J<<iG\J8m0Q:GLaK\gDQaPqZAFj]`IkCh60Ml^nnRNK;P`i
041cda^``AmqdL]<>e9qkN8SWa_2QeNm?XF`ldqAd8bmWQZ6[dIngb<OWiMGZAWW
?3PUoqWae;1PBjBm<41O4nCoD84_UfV8C[n9Dq90h]O]PGGlWMF`c_Z\6GQaL3:\
;SDW4q9XB:ol=]mLRR??bG=dE^VYNo3Q^;@H6TKThWB2\PqS4IBlD4q>EO<UaJ?`
4PCl^pfFZDPCm]hM3LejdALJj?[m;ENEGm3HOUgf<q3lBb1UNU[P:h<f0B_EdPLe
49Zj93O1L5CelVp9E__GU4kSkiC2?WHoh<eGVFN?6e3>^96q8TQ:59?@TNWiaBG^
6L47H\nln8qYlmbD^8qET9CU[4O0Q^j\E;oC^o1nG[0nAd93O12:BHp^jQK>6Kp`
UK3XlSlWM98HDD9cRmf156KWbB@boIOX6K_H=ngo89W;XPU4=oI8?jM=joSZPkWD
4GFSl@k5a93Ho9gbe?kPYDgql0<SmMD3d=0CET6OgPhmmmpgSSF1iP:i_U7=PK12
iC>P\nSJCl0_Sq3nSc`JZKhJo[>H63a9gMNYe8?YeZqLER0]@A4YO9o8R<E`=pH^
b0l60=kjW;73LAdXaJ0MbO;A^TU=b9;]_qJJn6kf^KmAYL@ZF;nRAdgo_52HHcFD
fQN<SKlXU22o6oLS`hh2b@>?>a[dPlRKY;eQ1>D7pRX<`FJip3]2RY1H>;_b1E7[
L?n;FfLPHd[A\m:oVO3dE_634qXZRblICq0hb>4[j0KoB3ooL@mhPLRNQ1mHJ1G6
7iLK]S4kSB><2N83kQlnakdh8D2?]0qG[d2gejQ]NoijU^W=eUQ@dWi6MmKRR?dk
LDI[>jHX2@E:NQNki5fjCPHGIDj52pnlD9DX5qYhi2d\b;]ac19=?^5[=H`@OH]4
D?<9Mn:7_B_9hkd\;ORbW;d]0@:16@DIf3KZ1GL6BED1ZAEg3:4aS>OEBb^Pmb]G
Ab[R_J=nq6d^m7^F9He@=9BVT=A3d@V6=W1npm3Te[hEpb^[Z5G2l:F<iH9SlCf9
hpTI>1Z6Pk^Pda061dke98f`0\Gjl6lUU=S6[bGIiZ<H9g`0h]FWA6]i:m4M?6Mm
Gha@i@bQRVG8JYkAinpRRZXjaYpYV_c8;f8jXmqeKJa@]LpbEkHP\:XJQl[Z1]:S
U45mmmbShS21WK=2KFPUoXqd\9I;b?U9aO^`fjVbZ2]gBG<:]4bQ@6$
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
c0EVXSQH5DT^<ZLM@2CSY9A5O=j6bWe_Sc5P>3Jle4;@X:3kmb@9j_KccT6^ogE\
W_KN781hY8;3oAq3ibP:baIN@[d<=oYVjh[fPa`j:IB6<eKTlmcXojq8SDdM:MKh
k\2FHU5Ic5>[GkZPe\NgZmkde:OK6>CG3f^2@IB[Bhk>0DIG^qj_`S2^p3BPLQ=R
9m0E1IOe4>6V5:LV_3Df[]GQ[5]El=B44j0KSi<F3=[1N8dKEM?q<<FjW9?4@Gbd
UKIJP8He]aj8PaAYcKQ;@g_aUD_]O8_EjmiWaPg[PO2d3e0X6N:ZK\EEdWQG[T>p
0P8ldJ\OPFJ=3YCNNZc:APdgD^86^IJhNDdV6QB811YJ?kql7:UiLOCiZS496Ee]
4jnbCp4>59jVN]Xnm:TkRJKQQCK>B_R33bD6Ib31o51F>iKi3;lg9K@_ga893qEl
O5Q^aW]n]`VKVGo2J^bn8A_SjQ4KM1K_11?jQn3PB9bgM=Oc5M\^L][7ZAT3OcSD
A5NiF<f^PR?OAW0@1qk;iZ1h`qGkmhI4d4?kAdS\ioKZo;[DK9`YY@pnF=>S>2gN
jChKIkjaCRbj[K3?U>JGbKI\mpCDBKWNPg<<YmOa]AJSoX5nA=5B?Nb^3WaV2XDZ
@;cMRk=noEOI41qUlOkW_UpXFn=j<1:2[:JKS6K?88U3NmX@5jC9[`3AH\N^Cggd
G[Jk4d[S^\hZ;=SqRScM2@KgfQ[7DlI28`QfAZJmbl2QdFlMX?J6349F2dZ770i[
2[4f^bImU7cK7iDmClVi^8[9T>2;^F1ca1CepmWNEE\Lq8V`VRbKcFBhC?BoX>2j
FZXTS2<IS3`RqlS?TE=N;QA5FdUIEah]>nY=mAhXi7>>WAij@G]GSF2klhDLg3ZY
5?L3WqKV2GVK`fTIQkYAZCDcVFL`D5H\n?4[eA4U>[jJIdNiEWUGkb]h4bi6VR1C
X25L]S9;Qme7NKULOZ^87RLO0ApIQ9mUR2oZQjZ=n?PIJ:q?jTXQ88pZbg5QQmC0
PHSniA`f77^m;=KQG1V2BAq?R><m8qH@3l^PThOhYo^S@Zh@7d67k=?Y3Jan8cOl
4I[:^jON:oIEHD2\NWg5HqDlUm`^eZn_FJ0<BS0?6>dk\@4T`b7h;BBPaEnd^F7E
OTBm5EWc>:7Ehdj<39n7M@;3F@MT1Jg65]Agm]6i:q;912:5d\<U8OTK\>jPAc<6
c?RREWdbnRd_OM\_R7:?TbQMZDn<Jn[0HSd5bY8JKVBlqWH[dGe_qFj5<Ha\HRP=
4Q?0C8SJBlKCR=dKYpUJh_:Aip6m^AkV0[hVPk4lI7iibbR`RfXSD=clI6gPBJ\A
]^E\D2Y`aoQZ__VakgJ::4q\?9RXaBG=h0oBmI=if[]=HAIZWb^_;[3mJ;8\Y4?^
YgiaH7RfYAL;4HaIeWYUQM=hCM>l@o2@^i`3[q\lBFEa_R4EXZRTO7Q_<LUJT:UG
Vem9fUoXRaU3GbRM;1ZfLY6Y]<:FfmcH<<cceV\\G6\DR9BmhT4nMLIX54>dQ5He
B_;0qPRk]B0ZmEopl@kPc61d]4Z@ij]4BJMU\KLlS6KeheI[i6TkJOgq>?<6eame
CT\mfc??NI:m]@:6HDjmCmj`p65:BTJ8?F8YGe_^RJF8J7KNS^m\^>=W4>Sf[qQ8
m^3\Xqf2XbimFqUbiK57VpA`E\FEf]?LZQBmjUegLH0mPDi[lS_CBhpmBN0nFEpB
_I?`K=>=b66jIiW2n_g3F@IY_@g_bDWa124XYnfoD8X[`^=fN:OB2SgFF<he9``Q
NbqdFlD@L1f;OH?e`eHb5XTZYSpERoi@5W62oLYc>gn7UPHGgTLf[dSqLP>bAknZ
B7eWT<b4aRha?=pZkXe:aamCLWdca2N6bG\p]RfD:2Vg]Eof4hWmfg<_pC]2JLFI
n\H:o<6`R=Edi]5?fA6RUG]I=mJp0l^^M9aEmX0jX<1A3RklLnFPJ8PjEgNW1dpU
T@97To=BHkaLgeRnoEF[YddWQNplmnlk48hLNoclXJ?ATTE`f9FioeAF9?EcVq89
GK0k_pC^^5oRhWN2\m_YSi4hSn90L[22jNIPd[AHEJd_CePk1Qp?67Ed_TDC7I^C
]:8;k`PqCm]m`<53bG[6h`1XM_fd7c@g=X:4G54YC:P0YAlEZcaO[<bYC5Xjj9:H
`^19RiKT\<4HNZb76U]7b81ia>ODMISap?dcOAfBmO3W[iL;9ML\1elJ<_BqkIBW
mDhq:F1FBhLiG2AFZ64[Z:LfTP5NDR>djUl[dPIckMUJdDCVNSd:L^:n;a6BpUd>
QkiVeYETa1[X3aFLC`4H8^RTK8a6>hD44L59nkFYOECHeZO:1:>X1j7bU>nICH=O
DQa@bZ^_CIhDK5fLl@Yb\p5G8lTf1WVSo\;;P<<Pq3aSE0F\oM=2oAHH?O29\l;X
O_6pUnG1GDWR\L[n4kNbq6_7\nQQi5L34;eV5^R^P3AXoM0SO_eRaR<1XkJ879AG
dW0\GTC8YnBO_`6O^jd_36?nN\ULWqPfiBA]HqJZgeKWMDOikDFXQVEcL8LbG1XZ
HB>H\PV^g33m?EgK3gMCbP;cIG:>>P4SnWCf>e>o1oFgV\QK@]=FHloI45RDJXY:
[lZ6fkS^nmD_g7ndqDD8>m_53ad@lN6oA]49c7f[CDJp3fg4Oh5qYXoXh8D9XKNY
bJpdB<o8]nA^[aXK_OC[AMMW4XEP^VW:leJ>kmCVcC=T^5Mim^`H\DXHSEAImHkj
?gp6CBYT<bQSn2\Ff85jD0Lh1?9C`6LAFXGY6eI]YUdp;bIh5LChn4mR>aZATOoF
nhZ]2RYRfd\NDmn8[l=M59H8^9^][B;oXIS2I>0:ei9\1J\85LMHSHKSbafRT>6`
UAc1@Rf6MJd56Za;@Q=QLcJi^[pWN[cg0<NN>7JbkU70Vi@]_J2o^qF`Wn:LaqP[
KbCWAU_mF:AkNTUjLEf<Ll43WA9?cpgfX4Xm4m>hnbR]FSSI[fQJU\5bOYTFOYZF
:kfGNpJU6VCoQNXW=?8XNA>K[\AoP094D13291T``=9Ci[MD]hd5C\DT6PB@VTm8
2_6H^9Y\6G0hXaVSpf6^mGI>Pko=KL=XfUC5Oa[O8c;<?F1COG9MXadS79n<O5fW
\HDVb9dR1H9JiFo6L6VccYYq=8C@=<K8\BU_?HWKmEBl8L]RaTH4p5RTWN;:b8oR
ccK?BCc2qT51A>^dn@nUOl]bF[_>g<]:gj1keA9mWYGKqQiPZGDh:QL;N;mA^8mJ
eA4eqGH;b8iP>^dC[GBe^3c664RJRWYV`ljYKGmFK\\B4a6PO5TE<6U\qXEg:TS]
Kp^mBaB00F?fQMOTPS:CVpK?WXcALWVL9[?@;[7CahH@mc[ljUKI^CO>NKL2lk]?
q>F43=3eHm9EO:;c9lXjL\_14Qcm>Le2Y@Q\m3SAHaQq4?UN<DW>39Q2m;gCc9Tp
e\?\7GS\ol\8lOS[X\l;ZIV^[fK\25cK]45e@oBF@W0j@4VagW\pTHV:ATIcpV@<
I2XW_pFo`XX:kmY=hbnbW5E97Y8@a]dkQMVo;@q2@P1aBA`5;gMPiQ[_O[]H2qJo
_SIiiqLA7a2WdeHcW>]UV[[2ChPS_Ze4P?1UWU2;MYjFNO`AC8KgF\=1lHFLCAoD
Z3Mc?nU3ERccQA<^GSOU7T:OSCP@48Y>RWUP3Mh@:X@kJePa1dBGN?U_HkdQm7BG
^QcSp8Q\flm4pKEI6<MfTL6UBB=6k=PIgnI2;bKeUg`\U2l?0q46QPE=LJFi8LYk
jdYc:9_>cUi\hgZ;EaN0KZdXXaQ;ikNG5DSP8eQO6?;Ao\XoDS4Ec:WchpV^DXgY
iPfSng9@PaP:C4Zm1WfV;U`iHlS@O=D1km=F03XVkblQboV[`aCDQg6Zm0g^FHfc
6<aIb14Ni`6BqYeB`KQ9MJ;5Sd:N=nmL;dO0\lWYSajE1GnAK50>@FjX;BD?^\2?
e7RqBHmVbF[iSZ1[R6<]404JR[dmplG^U`5Rp7EInbO9VVMQ@:S^OCce]e=CIVE9
m@]9`C?fgna=ek[a7LcfK]AiFgC6ehmT;1=m>I9OE;4P=ldR5c;0aCSF=VP4KkiS
h?Z98\@5Redl94?8cG:KQ3Ng5c5Yk_m`:DXdBkC_pF^l_ag?p_IF:kPUN]Ui^6:1
J]Li>ZSeOb[gE;XkIS[07XYU2]`q\FcR\>[N17H\ZZQGE4RDmL^DICqK5GjIfkA;
2<b6[b1bc?DlRCZ<cQBCcjC]DnfCMUSSnc=EUc;kJJWi7Qb?C=`31I?M`GjcKAHT
Cp1SkgcWd=N:^kglMn<DOghB8k@DoX1Ml8h0RNq\E[[B@4DVoG>=OeB47<JK5AhL
3==:9bdpl:7P8T_2R`UZ]J]ZlnSRU4\`mb0]2V3<fSV=<?nQ7<g7IF?Ocf]EofKM
TLORpe2m4IE91>T3K05P[BPbq_9cQHL6qU]64]_kBJI<WhjdD3:nK`^_BKU\ig0;
:`mMc4;K4C;VnhUc_AiL]]n5fa0I[>D1M7jF@Sj4MDG@XVM\l_\=LpMWWhYoQZ:e
nLSo]IN_Td_JL8pm4P7M`[qhLffbZO_S`gfT2jgnc\Ihd]fHR?HK:5e>8ROA?fAE
OLNC6=NZQS>D3261\IT0Xe_\FQ\A;<Z9T2OK]XM@DI=Mf>=HJaW:CY10Rkb7E6_]
k7c76=mQAQCeb:i9_3:qoFW07fLpi7NPM^=pZU^HUEqb@oH1DFB<m@OaK32fnde6
7;cHJC5nkU4E3n]lfldbGFBf_E=32RTQ3_FK41UBbWgRV0efS^`q_\ZkBeHqJ7dA
=WH0\efdnkBAlTB:`b:b40Y[pD5KMYo\iX=@3GHcgKjkCa:A]DEU_lcTlplS:>Oj
<pb685k1VS@4SRI:C8P5T[li=<WU7>3`YMO7Rl;dJ_15cgL[ATfN8I]Bh3Cgp9o[
bFT_3GWU]dIZ0qK?Zd@f_^7J_^o@jc;G3TLcIX79Oc:94F_@FejS@Uco_:Z3Mh;?
5p8G`7:j=pOLBRK_Sn\Mc<n:0?N;NVklPl6:GjqDA0gk1So2N4^kCiaC9`q:7HR5
Qi50`8QjlQJFca;I7FLRSbSZ9]j9HHqVMEY]j[W2So=mbQJGm_CXHBoGQK^AV[pR
1hHnc_iMQb\6jcB6@K7addIH_@MPN?5ik2ED89I4QnRRFT7PD3q=BEbFjDcp6e2S
MKL]cgJ?GEZIo][qESR>:oMWE03^O4OFA]jEUMDK<O8Q77^X_PPIk]n3N6q]<=1M
7<[emC6L`c>AYOlDD0k;anSJ09GLiiC?jeW2CqZUK\ied^Ime34`V<`I=0<7\fJS
neYITl0SQWRGAoAGN>:QNYiTjpH7:C8VACpahFZH?f68Vh`m2oW0]iK5YX<<c9Ml
b`AO@Q00lq3CJij_dIpmfNU6fB9UI7XQo8q0RSF@nhDo2<ih_PUDH7BYeg<CjUe9
UV_Qa0D`?jfGKd5h6p@PDJBSVXfM5ME[iKkLKUJH2pPVPOC?EApO^HNK:?1PkcE6
UN>T_efY<q?LXZ:B^q2AO;A50HCB?5]9NEp9F^5e>Y_[hID2B243apj6IflLXqP=
mh`1@^em@97QP0:QZV[nZbL`SS`C`>lFD_?I<U9gnq`^0W3485W_9:0QZRgojMY;
YeqZDUmLgo?FdRdm\M>VVH8dYY>9QV[5oKaE0E74dF8^jPqk2974>?p\C>SOViaJ
fY2Aj`XpBMi`P?ApI8h52BTi@eTGBI@Y^B7DMncfUnnT=nC?e`pB;;j@bRn2_5Hn
QOFKkMqIe_MK96B6gC79]`bHR]IID03<5mOC^[bpJT@L4^<pcjEP^RL]a1i@3YOP
bajqWBCKnO^LD<AeT_a2JJh^bBYQVmph^B@4<@5a>B5e\l^pAoLbh48qoQ8J^B@p
Sc?47lVM3gh?cXSQo@lFBc\_FZmb<H2mIAMZ`G2bQd4:Fe6k;a07DHcNJU6cn3GF
XD\NaEKjojJ2Kl=MSI5hoE\e8Y4=o12dOT>BF;Ei4^]pl8KbEeXpYF=8i21:K]gR
U9X;6hqCkU[0PqQhH2SnTF@R>poKf4Z3m97PDM\`KY;5QRidNT:D7[cCUjNl1[W9
;h8XDElO0SaM^S7IdM^GFKY1FkWG05HE8\n_JPE\AKX5ESI0aJPbHUTnMN7QJ1^=
>B83RgR48pnGAH3[CqELL\eYJqbj>SNlLK;CP[;NY4ZhRkcKdm:hqR0^^BX[pTSP
2<6^qbAC3bD==c6KND?mAM;JnE^NbhPL9HZ`CqcQghOm4Ic[mIC6q1HFSPZ1\Nbl
C__eR32SNgmK=\;[cYIX<>YbRelRoakhR=YY2:<YAjLiIpS]=]Onk_j]6bO;H[qR
0SJgaTp^Vih[0ZiWJB`SJE4KS9XI@>LB3n7`Pe;BRq=YFo\A7?@eF;g8AUVcDp4m
2SnQ:7:nmFTg`3cWnO_1W:L7D87B[LpOEfU05RqL@o[3R5CL7M]c>f\`5iHgFPPS
W5XcJ5k3:<a\>RN5PSp?0OTg@5g9me\_RS0\eYq13:B_80cCo^CZ^XiDReg5A2>6
?q9UPikmDqmeO_K9gp8i>A<05?;Q0N0GSAC0Ll7AoP5`=P<W9iE3Q7:mG14VCgB8
IISgi^H9UMGeX_WOSE@O\;U1GLKaTV869:e99n[_e26\l@]<9mfJdD1_jb<c0qEQ
\J;CRAW\k>5Z9GY29CPAES2\IaREiAR=@43>dY@\V;OcDaQKqlTGkhCTqZMJeQU]
iiRknG02]peZSe827qXB=;3E5<XYnWk41[gKN4LVm65:8F@?i@`lp?QWMUAMp0nI
PKR[WP^kWQX]Zc>_mb3FfA2QMnk[5:hJj0ZImld9q@>\S0E0CiL9C<7X^X>ABMVl
6imOWaV9TnTL`p=Do9Aa1Xe\0X2Bn7nNDOBUY6];Lb18CCEeNWfB;TS^5IdDmqdG
U?eRadNXSE7@ccg7J^XR8=Hc\\nj3\BTZmRXN^qR;RY8AHYElM]2^l_X5@AZZ\:d
9_:Y?F>R`B_M=U2JF8@I?@cORIP1KgFoFDE=\;\RcEYJH]W]N]9LinKmYZ_b[Yeb
nELONmDP[RlK^i?_96a9FMFFKp]GZE]bTp7H@@9VGZeZ6>1=m2[0pElSWoG3p^9I
QjX1ZO2ZW=HJ:Vmmg@GfbT913`\106Dp4=i;>U0JX9U:n6CcJD?meUlN1@g2W8ZW
>3T^S^Ep\i[OY<MKmf9Q5Skb5FZj<Je^k:_JG1SJh<dD3V_Chec`6BP=dKND=Q^A
;GIN039ajYaM?QN3L@dAYjg>mRTjO^d]O?BhN1MTfI]:7fla[GqTko2DA@T3APc4
0Dm`B:CAWSnV0dbnRZ3qV[kIT@66CLIi92LY:Bhj=k?P\EaklYHm8[nC3d0Q;H``
]BFCij7WFGd6amfQjhE=H`WZ=JSaoZJobV?jKa8khV_L]me=OFbY48LJ5SXeZZi7
HYgkida95G]kI=P_k8O@7jQqFS8?k:m$
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
mUVj]SQd5DT^<TBR;]=W<\`5ba4cYc7cPW?egELD\GINnbaHnlBWPNGi?P@:nA9m
[=dcB:TYGVO^ZCfHqMVSj_imKkFUh7m8Lq\F5n2jE7KnoZcM:G8f[^[CfVI^5WnY
q_<4oP2p@=H^iJHiZ[Am4Lnhg;<cZ@FO5?imegVe5ZWi=\Z@^1FCpS;H4?JYpB0@
<>Rfh>8n0`@^_1DB3D9W9m^hFbKoe`\:bqgSVMbB:pA_7U[=RgFWb7E5oFMKDC;S
ioNm7G\mqAX^_0D7=H31Z63BL>NiFCH=V06Dal`kRaMNKc3B1ocgkhhETPN[Tfh1
l_J^N?T7>H1Gaj:K6AhK1YK6:p1IH^I:UZilT2=LQ2NB`[fH6?o4am\DL5RARE1_
JmikMnq;KQ]4=DcWkK0QQSSe``hKVNF7Xb<6[Yl_J\naD9B7PR3qm?BDA07[Hm<b
gCG?\S4EH]SPgZRafB=pQKR3AH_pEb7`94gpa`Yad@[;PjXKW6UjT8RG8bf9mkL6
N[B@p]D3Bb?Z\CYX`SWA`b7C:Sf1b[i5fPRoV8AR>Qn^N33DQd@[hV:Vd7aXqmg[
E6@?6153^`YXUHIX5CUXL]Ib9iPLKKJIc`RFIE33aAN;QTO??_EqiBWm\KA=P;me
cbR`;XnI00KSaleiSUcqIWZBSekpES`KVn:2QW@dBH85?dc;m3CJdeiQ>n_=0Wd4
5bp?UeZK0gplSbbVnkkfo;4Y>1bKUCNo[oTKTT\GEq1Rk1ZBQ0K6j@RVHiS>F4X?
2?Gd\5QLHk`@;FERoH^IKad;U5=iCDQj;ik^5X8hDmfSZllZ@gQ0k34TE_pHMSC:
;M7n;d]kHV@OoKh[kkBnF_Vp<XHQ1O6jYMck>SMDP4oj;A`;^GjgcPO1oKdGKYYe
G;U1GOq5b^h8NC@6==JMA7T0>0nH2eYK5Qf\OZPn6JNiHm4;gWA5dOWS5l9_QKpb
dU6b=RT99d=iU4nYZ8gFGB`;UnH?RDTq\k6cL:@pB:A9ghI0P0pR1kl8eYXnQB72
SjFO5YhbmejbIRAl=?QDG?EGBG\Da=a0oQqB55Vc[oOG;o:_c`V<fdY5f3G;0]:9
niCPBF6PPb;9h]Vp=@djJ8F3:]^G]E3`QBY?24YLR<Z:\0kpSin]XJ`qeW0bT`Sq
Ekj34CTqM?Fj\[dAlc[E75C[00ji1^_<JeL^>W?VBUq_KXBTKNL:iAW:kN>[;<aP
@h;A[q1@:jaPbLQc5V>Q>q]G;22c@q5LhBQPIO>j:`oQhOJ0nT1hGf4AGF?SP1;e
Cp2bgG3`gCCL1[RF4D2GZ82kHmPJG\lJK>^gmPiMZEn=^VAZUJYPGJP8epfXd_kg
cBFENlLl`<R3a0HMQ:W4CRldWIL^L3KC>LS1GMT_`Sgj?]YKeFFW\g1?[WINO<<i
>0XJ\Y3NFNV7CqP7Sh`4nqX@J\YmI@Qco<eM\BhY6cgYF?RY<iD^:ZZ8M9hWIld^
EOce9_M>jenRecnG[1l>3i==Xpi?@gW\\RohbD\h<S:>A19CS7FlpK0Xe4YB8a2h
?kiA=X?AYHJWUC6Li`hnoG63d\fTcY2q0?AcK9@TnZ^^Q]TB\H=m1D;Co3C?>D5P
]^>Oj3CUgN5YAPnM9bUcq3J2Zjm17[[GB<I2<FZQ1<fBbI2n2^G770gJIL77b:cp
8KJgm4pE?F9Nmke<W]j1SnKOS]<3`B;Sk_Fo?8A>5p1K^Ag2Ec?`mY]G<08Z[Cl>
EkNnB2;fKFGJ6f6U`jo>a>gc2WddB?HO7nIV8ge<qSo9F0`bHM8bZ3G9^h3dJ61M
ffL6_UGATS22\:BT<`DJlp=0NESKYpPlYC:]Ypkc]MmCeMJ7^D]i]l3A\:h\ML56
b6Jk641K1360:K3<D\;>Oj0<X<h@RVdUTF6OV^[N\0S>7D33d0\C;80[Og1W95k<
jB216XOAYbP\ZnjOGFpX[DS`7pe1PHEDfq_Wl]VGXnaeNL]L68pckg[eeWc^ASb=
UPKEfgmSPGNbd\aV9pmFm^Y^6C9:4]e=pVQM@DFWDkMDMMC[_Ya1?ieedkW\;46a
pkkm5ZNT80IZ6VI:O2Xj3@EdQ2bGp@F\Nd=Z7N@e\Kn8ZMokQBQ90L2>>GnN;pW2
FJ8^4p`l[dTH]JBS4e;:mDo[@kdfiNIKnp4QSCnK1qCgYZ9^m@^1P^eo0?W5JR:k
gHZ;f=NXo\W9T6DF3KUMi1qad]B7:DqSRjAbTIONFG_WGGLZ>NQYO30nj]ADfiD=
`nGpQ?P@WcGq07R5^9NcFPgeHaIkQ9\l<D^[YmgDe\R[p>MSZFgJ[?<F5Ym3C>bB
lbZJ=b98MfY?OMk]8`nK_?6OleWImXi=ceVB2aNgPaEbL::nL_WiTao5C526_q02
l3V?Cp=O>Pf^G5i37NS2?17=@P_?XAme5YjfYq6]_@0hh:HYhbI]b=GjZM2C\dp5
\c9eZOpd5fGUQnIcH\0Wl^nZeeWjkG;lWZ3k0RoP5T?Comq0\\LX:cpI[;mHAp8C
nDUHoSFXNJBe^:3`7;nmUNQKWh[b1@hLjU0dK3?2`TL8YYMjXA2@6\UDb:2H>6VW
2Q4QPQdAmoWZ5ep@0nD5E[q7b>aD?_YTDhYi3W7Y3F]c9iR]mp?=gjVA@27]URlN
BL?dUY\1X@=9aij@KD8>gqdjOo>]Q`N\kH66IICddNN5\@NeJR0N4hdH>oADQCIO
Uc;8D3qJG`46O:;pnUbj=S:ibDoHPdB6]80HHQM_e2S>Xhc36gqcFg>?bc3q>N_E
<O\j`;bk5NE2J=X96NMA3npRYbo<d_q?AOXeLD@@T4jfk]CLWWXU;h4dgVTk=A3l
jKiO89Zm;\`[kWmgjLcSkWJZ?oN=`Kl80]q;nSVCRBj60WX91CBRD\mCZJTpZkaP
bBgpIdIAe==NT55nGaQcpLAAJoN:$
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
Q7Eh0SQd5DT^<Y<YL^OdYiSDq;nn<ddb;_=m;HZ>6cl`iUo]m0IaOoGUIM4Vpb?Q
Q@@9Bo0\_73n5<A0ZV12=cY27>V627nIjIBODHlIS:a5iO5VE1`a4F;Ac@HQD7;=
`\8JphW3k?6pk5k;8NQ6F_5hkVD_0\jpTXGad?n:\jnZ:cXN:GqadY6n41178L\\
EQU?C5g_m<]qoeTL3bKPBkc8AQ2^_WiiLSpZk`l]_MNIfHJ0TjNJc=0ki<E>^=\S
UiDPolLk>5A7\0\M@]DCS@;`?lBb@X<p]FDV=XKN1g\GGG;DVUiSUZ^Mq`;]b_0h
q5LheHe_SoI@p3G^S:?nq95;29Xbp<\YU9E;pO@Jo[aRqWLT:jH:HC>4aCaHPlS>
pQd1D9bmM4]91LPEklik7mh;JDM3MKbA=eaRpOd@eOF3O56V;d1WK6@c:qJ\MK>3
?SCg_PmOLHL4GZG0jcEGkUI8f2P:B?SQUdmT6TiWdiCJ9koCpcm<5VAncldpUM7_
@>c[89U3b7kf:Sl:PoZ^oMmaU@G@^7hgPW18oD:X=ShB>R<ehI5fIC:N;CA`6SU=
<VTkEJ864mV12`;I0?Z6^XdGN6pm_N2d]_p@<h`ASaW[7Qc`?cl3^QPd6^npXdI2
i=9p7CCBkXQ>QZDNMWO]20Ojp>FFFQ5mYAS^i2Ajj^^_eViK_<SBVW2Fo>lqDQ[m
d=4c43LLmd]g8Cm7ej2HQ2chFk5QgMoKm6pTanVNi8pD6;6PnfP2H2[0H^8ReLlh
Rl[?3bnn[Y3]mMl2G=PG7VJhULfAE9clUT^=ET0>0VMpK`dB0VRaN86a]\Li`64C
o9n`mRp8hKY7RI@R3940R`]]<>S4P7VCPBV@H<X_NCkQhGne9o9mhIZa@g2k?lf^
aD<RC1c^ZlLnF>]nS=lc0ITDMcRq1KWdXK9q22ng4@:JK6TT=YWYe9IZPNfX`\FL
2G^2gDFfbQLp[1n8k94HhmbE^>cQg^LIehQX^L@G6f@p0HmRdF_qVM3DTN8M`HGN
`4nfU\8;WUR4@Fd=J:ISX\ZS`U8An[?2O100nhRj;bPo[:]>H\<@0R<jdLq7fNm\
\Tq]o?2\J=4fXpb?@6GPK3L`2oZ33;TU[f1P?LLVSXU1K4JTaKY=]>\174]cn7K@
kR27?1kAR@B>dTLE>=NBS;b8UWLXOSg\8Y`N?clC<Q39pZnTnoCTqAVOYP_QqTBg
S>m<p:\Sa7HSKLlEaSUM<GFk\:i5[B:pFNU<MBgoZ^A3LIYl[9O7nD>qg;g@m8LO
045U4>h3[m_nQ>fh7ZD9AdRgE56bkT[=4WdcL0h6Ug\N^`niDEFOd`FQUD1B`MCl
44PH4<iD<mjR3]3?dJ5c47^b5i@cEJabB1Rn7aqJ3BX3U1pT:LP;L]\CoQC7_InG
=9oL<EWR2QYSY:XnXp?;XMCE6qPS4K4gS<?^WA^ejG\D6_4E@:2Wi;16^b<BHnM;
H`ZJP6WgDF3ge=Mf9Hgn<^`8EQAHiMFlGT?kM[HBqJ64SJWoNTJklbMZNN<O8SMm
EkNJ8ikRZ6ARM_c]Z_:>^O]VS=g<cqbUDa?0dp@dmTo:C>fIiG;nW_igoC?PBDfU
=`f\mi>JF<EgpmM:2kJMpVe94jibpjaNiEn=q>TlOlf_IKG>S[m<ZcbNijW82;?R
mA9cl06[E6V5B<`;OGYFmXeDA8TlDa_Jhd@`fP;R_<hh@km5FKoc8XTFeO6q8m9:
Ya\f<l^4\]:Ai@@S^ic4T>[NU?a_oF`7Jjg5pYb4ej;7qV@lUB6W`IGWGL;^G0ik
;5Gc3XjKo98;=n]Bpo7FZ`QEqS]OY2F=L@8f0hbq_d_Pkanph77cQ1TMJhLj[h4C
J;XdOHqO5nFTmR6Ja[5MSO@=OB[`SH794ePp7mNV02<pMG`nFBiJnc0P=ZR`PET0
>j86YQaQJ`JKX?Yp:4U4W2;_1nko\hWIaOWg4P9?@gdXe:InQA??nN]B1BbYbKN0
J7QU4;@2OGq^fRAT?H]RlbMCSBW@?PC506><RBD[<AQdV5A;Li4\DD6OBD?4[hO_
3b]N4AR;E6>m0ge79@Z<Aepf7gHm\B;Kjg13N1[GBM0PbiiFOiLo<9Cq^2ZKg^=p
XUl^n0:4_h7:`eIcNfJm6KGognD]DNa:;77n`hYm>NFec1q74b]6cknCU==j\k6p
`PRNDiiqWD:H9<4GlaVegl7j`aofUk]CJKd:@ZlTNUEqRkG^Rj\P5UG:1f9X:lXN
a<aE>VjSp:gK\><d[mSL0^4JeUUIA9AZioGPA9a7UFacR1^[59Z=0[OQ]G:?Aj5K
DhjGA:C:5:VfiF?F\18lTN5Nb:Ci\oPW=>SAM5Yp9hIBkm@gMEHJGXS:CYEOSQOg
njf]DkDCn4LEm04f<oZncLRZ2>AkaNTcG`^d@3@=206eOa\h>WJ67oKDQ=p?TMSh
2cTD?]5E_<Cjo3SUVa@cIZ6UdU`[AWD][6NN<FDB0=BLk1lK7[mYRpbBL\WfF8];
^e<P6=oPmcU6inMe7X;8oX_>R2iGC7An;0[8fd7dX4023AC\\[9K5?lYq?;;Tg?:
NGeG`=hDGG5Je>]d__=gZ]6pJ;?i`9XE6P>7BON1X>8]gW8Q<k7:hXpF0[[Ea^pW
f\Lki]@^`@RC2U?`GqNcED;?KpPj;cn74jIY@QDP9C=n3]cijH2eo6LLa6UEhp_\
16eX:`Jb?BDl:TAWnL?bXCmVPI\JIfM`O?]]AOdke_PHi4O=f1MbU:Y6A1gZXILI
16BTVbk<7pjd1YDj8>a@>Ti`RCb>S@BEBV=]j4=67UlIf]5W3;?ROSC>L`iXb0c^
3]aQ=_p\3L]W7m]3aNH<=8[NcDkBmQ[11na0HEYL1nCGa4[1M4PeMV6\6<TacB?n
5q27dZY7faB`;\OS6nk2XO`jJfo=9cg_m_`FB5ZLh^\mVPUg5Q\Ql[BdIg:YmWd[
540W8@_lW`V<nC^aaJEXloLajpEMSIDJb9LI^I8n>kCJoNAGO_E:?dV=Jp?9nd2U
1q`iD;WKC5TLfGOX3L3O5A`l=g2Pi]h@\D>Y?p>@e[8ZJq=WoCj`KD@`bgL5WbI7
8N5jXP[SJ0Y2Rh@OBqFO?8_4jS6SXRS<PS\i22E[;c;Ac;2E^0MgXS6i=?KZ4?N3
FPd?=p9j3FVeZ;EV@agj^NKL8H\Z_U>?ihD9=_@cHTTD>W2M7RMRFb_PD15RqgO=
GDZM\5GDXFKCPlaNgMiX5TZiRV\_R2]J=EBKheg1OXP40HOY5dm6OVYY2YYD2Y]6
[;SXFmD4Gc[bq7no^ZhRUG>KF3K@[;<Gl^a3_S8V:mg3H;GggC\W:MGiU3CaR2f[
a4SAoKX@<Go@Q1WX^iXk>DZb61E=ZkdNp4l;oQ>c4kiK3^J@epOMbbTB=F9;Q3o_
aC3RBTM;>eAHWQd3jqCe75AkINUl8RPAl`D^95`j]hn=g@gDfqk:ln9:9qkSk9dl
lF\fha[0M62ZhjL1VgJ]KWadGj:RAqB7Jf?YgpdJHa^YmZZmCj06I>dQSjI2YqI6
NWR>6Ai`X7cj60Hj\_l3VToAF062?\GbbpB=g4XEj;72cNHR[`3[7Q5JPWBn1Meg
9MEQ^d[[UT2AaV7gfW?fBc3:p10P1J97\Jk:3gEFM`36]jDZ4>DLmAl4[9@2W9>`
T=l=dZ;H;a9NVnFlKe=]2H0@JBMJ;3O;Xa1@9DQLq3JPob^2kI6_5@=RUdlo<\_G
dn?R[^9]QW9\E;kmY5@e00eO<\EVFP@3Xm]<Gl3?5NDdXGLKI\]FDaZGJE6aqhS@
2YG5<QO\5P<1<qX<8QBDF1UhiR>=8>P=lgQo6]d;KZ@4HmC]e>@gJ8pa=S5A=XSb
W_lG4Y\k^dkmXNM08XY246p^S9=Mcml;n:kaF;^9eLOQXifK>>a:B^p>UIaj6\qW
?oiS4?Gal3RSacZLO3EEdDhVV[j^NPCql4hZXZJqhf0GD\H3;^XRdW>Re5_RTo:4
Y1N=TjU=ObapWOR83Nej?2RLQ0>c_9IT0H:GcU[mgNTaNO2K@B=5FoU7A4hPLW8K
?kD=gkqm5IP`nPMAUVf9>[?Oeq2n9a47U:<o<m=Gi9kki<Y7PnlIZXYk[2XcE70J
VgbDZnBja=[803_<nP70dZkedk4R2HpLZ9>9h\Jk4\34Uo5XVkZ;nF5kL:>?7Ok1
]@SK\bdO:g?>i\Q07T3KO05QSZh\7Q=g?^HX[I5IoaE7@Hch9Hm;EDoPS7OhghX<
k3p<7;gjDhe;]e95SER9l<3d4hDEdM59fNUpE\EbBC\g;feeXU11m<=Nh\6>SNJJ
2VYe@7ZRUSeNk;l;:Hi2`NE4YXmWC5;PPA^Z0HaF_>S]n>M[RU@NkhqSQ1i\QF>\
SLUm1k_U5m9<T9;f?lhVBp`lT?4^4pX>oe6O1A]JA@Q^X@BZFe7fBCb]ikXic[5M
]g^c7@9bL`heeP_<YEGL5PTM5Nd67lplKadeHnM?IQF@PZ]J0I6A2\>0ZH7kdK2q
]CBX;C=p2P2T^1A?`jEKd_TGIHNZ8:@HDKg4RI1>_L9pHVZnlC>gEbmXedUR50CG
km<n5=3iaP9:bPCiX]UUGJjaf83C7]N?Y9q:EJYnP9OimiF@:FU?RXW]1N^eZRLI
2Qd3KDMXjKAB@GQA0@i>X79>e8P`cfJ0CflD^5ldQBJoIYiH9Sp?3O6`Q7g9^i?^
n=m]h\f[dUb:;m_S3\CR2>]E>ML3a4_GiE1dV>?6Yd<FmlZ\V^\3fO83\YENAB[o
E5i[VqN65l7D_8Kcd_GbBpiGPXS<;8\RbAEWkEUh1d4lAnGBhG^MpR@cW;L3p9^Q
7=1hEe7CLCFOKJmAmkb`pS`]P[WLeZ9>NO\cDj?8^cjMMnYo`q12ZUI;L_M_LMbj
1chQWnRWI<6FkQ]6p2;4<m0PpH?7US:Mf:a5O7d6PpC<cW6XnpFom1ZfR\1kji]W
Gj[=VdZaBEDaYpG8WN^b0qUlj<0:jR2h`Sa@j3I?Le3aE1`nZVi3D>F9Hp`F^]QQ
kc2QX8]V3Ao>Pfnn;NA\7:BA^W`F>VHC_L5i4RRSdPP7JY?SS?X`pGSi7eHg`goc
8f68LQbKm]DlTNb42;W28A2e?UXG60J00BeEY<:YbWBeE^9qDE\J@8L4J<82@Ci@
`hOm2=\co^E4Lb@^VaIhXUBF^lB@OH5lK>Q<jD651FRJ7a9o0n6nU0VVHbWcO`Ql
gkqFldGiZcpUa]==]jdHI7>FG_4Y3LeN^n1i<@<QmpA>aHfLgp6TV4][UeKlXUY`
DZCk=pm_UIJUGH8V<7k:=bT68kMSGoQFWRUTMcXbop7@TNIdB6fLP`\:coIRCJ\m
bWi`WpBCkEgW3G?RNEH4LWgAiQckIa9ici54SI3:FO_]X;HiB;i?afi^[gj\W16E
j=q`<ML\SQdV=M5^`:UR`J@EThf0NcnAQoXbGc<KdD5;gC`;`l6jWGS2VZ9KC:18
T<kJn[IXIPS3=>\e>p=]?::^2h3`l:@1:R3[b[?2O3p4f0X\iDmQ=a0g=cHm6_T1
gW`kcYYN4BC3i[2_G?0f^AMGZ?R81Oj1\00POhCW2GPXXG:AbcjGFPB1KW14d3QX
d>2D?_Up0[JChSU[fAVIB<la;LHnGHSLG3<8h7P3;B?72Y<RV0^e;T08K;2;pXUR
2e\DqC3mf`Mp14;J6kqAW0^?5Rqdl:Hl<g]86cE0bXa;j@mlZe9ODL8qY]a4@QS3
I<CgXG30@de8`P6cTkD[@4WlE0eLJY_=VlG9[J]<20GHUcPR=1DEIBQUXL[pjB]i
F`Bj92YeLLfo2NMTHYikq_XQQU=8kah^=U?KD9Y5WYA1CZCq]F_H?OTqia_h;U4P
@m^Ml?Jf0eXqSOc9H`7hfAbj1g_^=82HEk:@WDac0TcHRPFlgmA;F7^1J2O:2CVN
lHcqEii=DFIq@j;;C[\;M<>i2SPgCZ>f42]cUlRaM=GhlSZA^4UePh1SqHD9^ie0
gi]i@=EUShEOae@cKo2P@p;8OeNTFqUDE7oLKp>`3W^6Ipkjc[_M<\o;;Y5od5<]
`?BTeXaYI>0El_YMF5SeD1YIUTD^k`iW`YqDk;W6C=qaHNe;dUhKY@_8hn`JmUTP
h:3;MX6VlXp4<_]OcK<LYJckVQOMk\JP:i\ULBqS]f9iWXTHJZK<]3;D[paV3OXN
\0:fjKN7E__70UGUKQgA_XhEDaplWVOgTg\R^4aHkYFdGJd]e7?jhgb?1pm6IL=_
8MH2RFUahoo0A>TX6YEmhO1mQB[EF?o?hG9cDX4SP:KW?OBSXM;g7SH7HdO3X7T^
8o=WpE0WY=na8Za@k0oVf1EUb9:o2]U9JBTnIH8dc?CdH\hj]ddmfN63G]C6Yik\
d8@Jp2;VIWVeqR]]S5aYqEcXGcSLpgdohK6L6AfK1ZfK`I<L2AWp<Xbj=_=j0BaJ
aX3fbJ?5pNF@6`HAF2VZVS<6EMk9b^K;61hl_2@jIcKkAdKGiA=OlbGcGC[<L[2p
Sa@@R0n4bU[?2JD7>Z5^VV]P1dJ;0XWhbTe2Y2n@Ofo>6?qK4@^fgQpiGmdkPEFi
be94X0Qb2=Gd@OTKH38V\aP2k\ZWLN3UW:XdZ95Q8fT\^8cPokN@1gGgZ536EAff
X;4LeYQlh1k_EU>A5=4FFIC>g_eJPK^;cVkq`SJ_W6RjVVMkSXId`3fq8YFi90=q
:dmJ14:AOl^bKgd?ZV=\66JnbDB<4R=LQ5VVgCShfSRk6H\O;HQcUH^h;_O5KmjZ
XW^mpfGeoA\CR3<@LPej\cXY8PSV85ilK6MUQp1KK5\=hFaM7Z0ijndh09SDF[Uo
>UI?3719eHKAEo:NSj1n6dZ_cWAoNO5a;L3H65aC4bkAhZqWYdf8``pV9DD?o<pn
BI0U0^[[lC[hQDc5B2@HV\=1biEe0TbA96BnUgS?Zl1K_kkVK@OFc>L4S4<7QLNU
coFK:YC;mF>g79PJ<pBm?5\Eh4ocT?bnckg_AqbZ:=AN@ajAa>_LIUjOIW?co8:j
JDag@S]A5<a2cQP4Q?6^3MR=WHICZN@>GPN6YR9icMf_<pVD`Kd6kpO5:WeIeSQP
5P1806o\U0`\gfF6L3:6q6HLnfinqk_ii=SYLG76a4GVUq2hW[mUXqnDU;jaERbA
T<W2clEa7;1Ai[kf>^p8X1JUkfeH1EV23l[MVOJcS0hBePHCLNPj4NSjmfDiJ@13
G`a[>7]<a]n4h[<qlGXHZ3411=:YH<;O7Y?jqW<mm3;3n]m1Zb:m6Y`lqN6dCZ8^
QS7[VKID44ab<qg;eNOW>LQaJaBY2p\Z_o;1_?mf8;9Mc\^4L\YgGLoF:e19VA`<
0kKm]X2OHAc\MZqIS]fQ@Zq`<;3??^oJgX;1cU8ha:IpZUYYMcI[X^oDXkkkTkCq
64CVYi;bTakBAgFklHf^pb7mQYXOT:H:RQY>hlbkVfLd^BHN\bXNU8nj?id@ZPkl
N^2]]q6l5PgJB8NE_[_K7506nGWdoJI7X0E^SnCoY@5ca^VVC``R<l\DaMW1kPB9
pPh3L]9apTTO[nOB7Ejjgcl:YjnHmqSI4eBRGiPlH7c6M1U<Hp4A?L9@UQe2mGiV
Uj9WD8qEC0NoA891VDRUJF1`:^9hmC9OJidNBFk?hdYomL[aDY_7fHGq^G^1e\Qp
FHm5GX<nGPDQnFb:9:XZpC]o>=W<ii2FM4F4o2e<pWIhUbn5L1N^\J0_IQ40Dp:D
D8;d3PPDY3g[3Nd8<j:]Qk>FRWmBX?f7gPk3WA\c@FSb2e`U^>`f<q5edI=6f?V]
Q_=6[lZP06AYO1KYg?L:1nRc78GCLdS[SWDWY[qH7K9KB9pL5@m4SU_ai=0c3_01
aZoq:eIdad?nOL15[Fj9EP3B_hkS0ZdCq>NmE6H74R7UV<^B^1cXbCEA?0KadPSp
]NRNR\jRO19:keMd^=nZ`51jo0`I^aWE<iL4qMEa39B7BUWZNb[_D[V[G1CiZTF2
Z7hB>@T6jYZWPNN6?n9f56XC^kEaMdAbA:kafIQqdbS;2\bpmO8_g86U`\1QTTAj
Wa>][kRUT@\GnQLjkPNTIPa6A:?l2=jgZafDbBh[<3oo@@Th\0piHW8nJi$
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
]fIVMSQH5DT^<6GHf03_glT:h9DpPCnkWk<e^5Hf]\4e@koajUEkBgcYF39E3i`H
:\[_fFUjgng\=C_g@Gaq5mIjOLNV1^OiW:Bf19B?^\g?HSde=m_8SLA6GNpIa[S7
?pfCJZSPTPcDf^LJ>7=^VWpAh<IS9]n4cHmj:`?ML3QO_<nqYHNjZ@0dS6Q5WKL?
54dSqB3D^e<LnP>ff<BnFBk<0:>D0;K5OVH1G4`pGOYC_KEi4bo^BVfmDSF4cPO\
X>Bg7;NVSB0O8n4bY5Tn<X1XW]<3Zaj=qWcnLC9`3ZBB=k`Wj^TUL4VJXB8fRO\X
b5J=1JUd;<CL^DNMfZ2M88Z=Epf^:F=4BqTFV2JYFW83C_M_VBLWROZR0o<SCML5
=dgN8_c_O[TXb[AOnUC7Z5RAjO?K8cBM[k\5>g<GSl;PTBpLTVBJcfOHa5<BCG7i
]b2@PDq;TmC9>2qbCTja;E5BA=20Uo`01ZIUO9o]SkWRS:q2dbIh1?P;;jU;`GTe
5c`9ojc4fj6GPR:HO:A_LJDi6Aqhc;_K6=hJSFKP^]n[^`9][<nF?P]8M48CQF\q
GCT?_oq;eKoEIm1eWWR6^7MRRHRg\aZgGEa\kbVemZIN37J<b^oa`?3bVU^ZiC=E
C9oDYLLa3Db9LOgVk<LJdfbe\eCi3apgVi7AFT\50D3gfDWG9I9C7P30k[R[LU4j
LYiSCA1@J[HPECRNIOY?3kb<\U\0;PiTloGHRap<_`]<ZYljdlVF;OCjEofF^f7_
eDmGKU4j63G3Ib8ZCAWZQQ85;Y7J;jS@h=DGAb0dbEfi[mj<EFfi\a1>50p_PBeK
nO5n1c;^SYjR=8]HO<G6FeORLY5Eh4JPG1OgRVI]IScce;R\cIgZZZ^TO]gkVAPf
3;^dY]k_6aXoD6qgI8S^c;Y^0Kgofa?22TFLIc6aR0R@R>3ed`228HA07KOQRFdo
RQ3NPBL6Hf23S2DgTBPbRcJkTmk_^c?ITpdNJ]6Zjq8:FM9c[DgIC4=O5Hf]N76G
=`8X2Bh1c]\62naaNcJl@2[h><;S1ZaQ[eaW6;0c46hZ=4e7LUW9gplAHVc4A5<c
foIVUj^6Q91i]\B2fj[?`OCZ3FG<eGUI8WLh>e\J=nRCqES@@6UM170OTFO^<EnR
eUCEp^TghS2CqcdQaFeqnj_a_j9fScQ`Adb<Ij@<AM^LCOZ_c]Hg;g7ce:GYBFnC
FcTMnalmjcBARlEf>elXnf_1na2FeQRO39nWeMcTK?Y<p?aX=F8_KcNnWG0hbMSg
lN5gg?ZjR07g2QN?jAW>nGncMOcd>LDHICMJmdbPCe9<Q?CX:XS^7[42[EjhQ21H
CqEEYGG0oBYa_URJa;AC=?V`?2kFIel9Pe^I3aD7l6dY2Fh01LO[a9kbbWFB[GjS
d0EJY7H]:Db;5O8jnkY64<qmZ_B3KhhSPJYBJ@2iCJVWN7:YW]?Qmm[E@1ZG<]:B
ii_0cICRoB9AO4jS3:5[3<7OPOgDYjPJE;[mYjooP`q?[RZSclKaCE6Ukik2<3C6
=WLfefe?:9Ep6kKC=3ipn29Q0Z0I@XiX?8?gMg:=E5Yga_\J:8U05e7I7gR5h8R8
h21R\chEKKCNSMk^W69lN\FNNk7H]^5qK6o@fk0Bi1lJOfH98O9>XmZqI=P0fbFq
[;E\eB[cL:o46o7<>P[oFa]_3QSg1M>5bSc9p6iGEedI\R_>P`2H00<9QFe=>KlL
\X4BVc9=2\?BVq`9QZi\3pjocBNHDh`Q<icE:JYmkY9@:i6n4Q3W=dQQg?52fcRV
Y[@3Ei6en7QC>IC8g<R`8^j`Udi2QX8jD<GY4YIHonSoEL1d`GL4YnbKD10W=Y46
F<a;@1fJp9@Y;iG[pYHb6m:_qS`Y\Z_So9QiID=g]7kh9j^ipU^ceO6Eq9:_`HHY
M5\o6MILfW`5M_R8KJhKYI0hF]jh`fT_iqie[gPmZ\=QMBFBQEHX7RBh]4^hlkS1
KFda96C=1G;AIkmdbUoQA:U^^0jN@M8Ba1eQjT`eSWkj3YbH9TpWB8g@FVp96gOD
SH?1:fXZ4]og>:OfWRF\YdiqgolXY]qIQMNidYTKH4V?2c:_MZcq_^_dZ\L]Ehaa
1VbBaf1]8<65@o@H[nom]mT0d_hJBF9qDN5KZi><\6XmYX[<]=FJPigBP>U95QVj
[?\K]mT3@3:p;kJkS6ndFQb9l^FmeVeORb\MdCGWQ4H1MB>W1J;>AUBp[W57_]Ui
hB\]bTkLnHB3WSCQ1e:BKg53g6DpiBMHH1G2=<9BROkDS;fVkCbXWnYKQ6Eb?QU`
6?alY3>qm=N;[YEqd]PTR@:iOcmOBoQTBdgc:]KAEYGUV0Ba__>@]0d?8ohbM6l0
hlN9N]lQ3Oo:qi4QCD0^qClE[0cqiBhG>@3^;CE>?R:c]aPQp0JiV>Z@PRQEMmF:
]P0aa14MfkY_l^FW\D>VbS>S\8aHqF;C7HZd9AIB;@i6ZomU=TdJ]9DnNiA5j5@C
37YEOd9ip9R1jUTb4Q`\j>3Rg7G]]Q\BKc2=ATife9a^J;Ph^:W<qMJaJ2R86Y9D
eSmI0cf0:7NWD5W2\OgB9na^BK9Jh3]J0VKc@7C8[9;fEDCq1M1l7K1Ke9@AkS^l
FT]?Wl`[hO_[I8BlcNTa3<2YaIGq;hoN8^KqI9cHVJ3K@e2Y\bdCiH8=O4RmRoB6
nf6Vp@;_dWTFpWhN7JdX]_NCjUlJeA7q9l6Jl_8_fL>^\iG_ja6ammU9qE;2@6I4
Smb\oVa33bko]qL`VVYe@1OoCSo7BBhMQR=PaOPeElA5dlOgqEIJRf^D_<@6eOId
L\Ho`C8T<\Z0Kh6P@oaJVB465\[l3O=L>SEVHIXVYpKSfbZ4nL[gWUTHJ4F6SlWf
77_@6mCJnDKK^NEODS3fU@;^2ka0G0m^A@WR5>bGaKq0E`aTc>qU9a0QPn_Q6Udl
3[HPNNfbeWTTR:9^h@jUHc_AbW9U\dTQOGUhg7^@lL2e?RShLlQ4`o;;l]>BOH\q
B@a0?ZLPh4jB7>b^kSM5l7CXp[10AfC6p0UnkBS?2F>Oe5<_UKIg9p_]mEM2>:eE
h`fL8SdMR4RTenGmnTGNcg6UZliRIOkT9GCF\nCGAj]BO1@M3Q=Y2i=9B@H]JCqc
EQ^8=fcpEdjS;hoH1jOZb:9HYd@JdjNm>9O0@glXq4Bed?f1_VbBf_G30MD<JqXm
V3TCg35c=X>l1ITS6c]]`4EE6:3WMdmk_:4aHDcKM__T@=P@?6mP`1:h2RlSjNL1
qF7cU5oiIqWHjeYNO<A=d_gJO:B8J6DA10SohqW_NP`7fiLK8;IV3N3FQl]S_0<2
@n[;^B]h4]hTb378[QTe6ah\;[1?3d8:0jXNRQ6^q_j5Q6d5dq=NOLU2S5ASm][l
XV>`CVX1@;d]h]4PA_?SIEK9qfjD]mZEVpo]Mf>o8kqAjd07bILG<0k6J8[4eqG_
<4=Gl0q6@InI^ARI;E_`>>7KX3gGV6g^obcXb@q8RQNoDcnASP:L7]fkJYic]BSb
];827[a_Y?]n2Yh8^aqCH9_ii2Y9?XE;cZOSQ>H]FA@kBRcNAcM[9:?qA`Y]0dp3
6]>A`7ij:a_<JDg0HG\0U@KmS<U=U\0JgC@TYXTeXB4d7O5T77>>QBa9A3F05\:;
VnMgYh1`S1lm\l9d?a]Ojdi26qQZ2YU^iZ[^1[M[12XLQ<F>h6ccfPN3]c:To3]`
8]AkOcK7`>>Qk@Uc13^7lm@M8GiAedGB6<p5Xfbm]HjG[VGmF2Z82^OAkDMhlT;W
KQmM=mT6Q:4<8Xgd?\M=jjL\8bT^m8LgPc:`gG=6RJTY`?M2dCHI>^=G7qaK`X\>
WU[IEY0GeU_[he747996CkGF\SGn_:0WH3SELD4Q_lW43N:ODNCRhPacfFR5BPYc
fSVM8nd`RfmWT6PAp?1RhR;m;O=;f\>[;JKhR9HkY6JAimZlc70:h[E\DZ[UHC;l
U@eGl^[kOGX91mGA=?I80Nn;MXX63S<fLg;\_qD08R:7cO=:?ej16E5kUSn4E?jg
m`g8po=>E?gaqJ5W;fL^LP9gCXd^WaOg2Ej9lNmf9U9Ec8XcBmg<^RQH65HPLG[l
93?TB>iLOl9[<o7<Lhe3h8k_5pUiV\?2KC`5S2`CY<B_F2]kVCqL[Rg_jTQW`_=9
fkblnb5ETX0K9qE\4;V>8pkMU@X@kI1`FjlTkkd7l]X=>jkC`N4`ogQ8`@jCK91Q
@2$
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
Ph^i6SQH5DT^<6:`W_ILCCSSBaMnERgp<W^39E>NknHTb4q0C:nn66FB=`^QRHjV
2[9ScH<b0CA<KiDAceN`[]dJVqfcbBQDpCS@Kl?kZ0X_=2B123O[lPLJS[W1q9Mh
J=3Gq=m;Bll]SC@ff]f_0imj0TC0GcbWWin3BhnBb7;=X:L`;@:Wg5@BE67fpbD?
WG07o@J7RG=cj>6e>_f8k`^piM:5[diD=1KL8AmkCgO?eegR]fRXp9c^b^6\p`Bc
DP?K02_C6Ec48a6?\14jG4NTOP3pT\i_RLGqS^BH:6POFjjAQXDaGeO[a=EB9iVp
diUFm3XH:9ajcBM>Meninbi`djNS4oeI[;?_R=gpXO6e0FjdWLjYXoODJoQdOQq0
BL^IT9Na<LjCdKlXVgngn7a7;DNIMY01l4>Aha=6k@X]=[?\L_RD47GqL?8d1STp
;_G;QSC2:@L74mXmP4:9:Wle12CJNTEW>S7EZJ]fT6mIdFbXU5S<VHiOpNYf6Hjc
Ch`D1A\PPT0nl7U_;BF8Le>ELmRm3GelAc;f0T>oO7^>BSi@CI5BTF;RF`iV3GT:
Ck4`TE4lN_ND__jPpNWV?KZIU6ATHCTZT`HJVqlXkTEc0pLl<^ZCEQ5gDCb97jmm
5Q`?5KhjSbhIZV;>epJVd8m:Tob:g`L\7=1<DaMnYb_X^A2Zf4lHj`9KYHToFXJ8
nh>QK^O5N5AQ]8LbZTH6f550oa<]kZXHaAESRf<g[qRJg=JMSlfD1jmaRilomPqZ
mR93i8qD:f`DWoCIf:aXLHF^Fd5CZ6?h9oF<?Fb6OLpJYT:@1<AB]<f98QnbF7So
V7FlP9f5OL3aL;UbDR>?a6iX21GS<@pS?QSBCBjYLDpWJIXa^oj;n5XX2g\NNY9e
WY_D:a`^MafH\YZn41178L\Po8X:eMTEeD\?oekRRVT<8XKmY6bpm2OkdLAqQ6EW
<<BLhT0Pl3K5gIK1`CdIC^U5ZGJY>3R96MAP`<jcM_hq63i;C3L0YUmR3ZPnf`<Q
^KbfHf=nG;C^V<ndBhSOS6_Uh<KUD_f<p5=6PXDGpG<O2B\jn:nF49Sb^5oHji`D
PlUXqR?0@NH>7d4[C078aN7;S0OqgjhV[@>eQmG[h6ik0BF9[j5;K\PP]0WgkWmp
>?iPDkELC4\o27nn7XPBmm52:kV;lTc8eV0q3=S>b^]3XS2pWH]_[[oBZ_PM`1\d
c5\OoG9nn?@cgUCnBdOV_kI1_Dd=a568C0Sei>n547_aP1q^9jRENVQn1:6cTEfp
3MRle?YoAjZbZFgTIm]0ZNUaaQVRC7VKbP>nS`qWleS?RD:5DJ_XGe3Q>k_31>JC
7Y9;m[a6@eT8hcB0>PnGi`V8MM1XZoA`28IMVn:CdEW93oFC`W0lW9O>V6jeVQl2
lDp3>lQQCe7DLc?=@16Td6mnfYdbHjU>\bj>0O19@W0qmfCMIam5YUM770MRYCZf
OG2ANbJ9L9[G[ehK6>`]^XNVDFIZ^CLPfM<aFngmG8@lBIig`hK9]W4B_K5C>haj
2R0=Lm9p6jA4;BEpW;J>aDEpjHfZR4=Y<HF^mJ;kDY;:^^5eWmBSK\LbS8Xq@hUR
`c>V4O1ZVB8UY<pJ`Y_oa@gkjHA_kmb[ajl>Q?5abm[kK0l`JpG4QR:jVTaJgOS4
809d\m3S=:fhikD6oND2aeF;Oh]^\e\Wl]K[_QEGO=aOMF462:CH;^FP_>UAQ<TK
8R=0_VZ1DmcC^?>EO:k4R<1]ZpGDa?\jjbXPGVJ2o?d^p0`[`@FEfd9Mf:E5GDUA
BTC6L2>0XXD3Q6\OYq<nI97UCZZ8C2nFDXd^I]\5fLJcOkE^Hc1DIROiV4CF<gZa
YSE]dhTN9b[KCEaYmcQmdg0Ag9loEefP3Oa=a]OjS]DeME3XJ@FJKR6?<pf@0<3O
KVd:L[ITiI>H7gngkP0`78BZ54Y2T9q9?l3@<SP<o>]2ohW7mYSWaR;dXD;AI:O`
l3>nocDCIm1>m4UK^A2B9=P>0?3dlB1S:8GGR^MQdE5QL8?j;@E;c@j=>aO5_LAM
7jlk7Ipl_<FJhnqLbB76K1qnnGJmH@0c5^jkf:6=mpZB;IiXdIn;]H9?TIcPOgAI
l>D[]jDG:iYU\:o?]A>MA`QWJQCCX:KVk@gai=?k8TWQKm8Yj38_oWdYYWTH`qe5
j[>H^q?<J\Zd_Sgm1CIJZlE;E>J^CZ:flIgI1qG<DU[LWqVY;`WAZTF[pQiZa\RG
i4l[HX_I7e\3COfeG2LDE\=`IYeeXJRieZb6>ViGJ>OX;EgXA>X24Vf\1Q7AJMdU
]iXJ5ehYJXidSUn]]Q2PA96q=:DkCioOI?nG_3eS?K6GpQMK7HObqoH7VQd5WUdJ
HeA^:8Tf\M;eeBU^P;:IU>8aeKOQ]JYoo>6q`gJ^2@Fk[VIKa7^a`o4?b0BRc61V
J83<4Zh]K6Mn7o7g1oZo2o8?g2p=9_Nm0^p:[f0Ncp;PVRh<S`on;OOYZghg[]Ve
=BK>VC[\I@QS]ZKWdlP:K@`^Z9?mQkAkP85Qd1_ea>U[SaVnqF65fTX5aEb`69nT
cEOTDC[]O439Jo@D7A8RKYiLOPYoO1`S2A970]0A[e@DedEe[Fc5NV85b?9oLhZ<
IqBP2PR?Do\4C4K=BjQd5Pdm60@FYgm[CeHIQi5:QTmeJY[BkmggNT[U5VdEM[\5
eRB92Z2?RhUJmap=n<bUnonM[D[CIATfComA<4GAZKDTEHdloQ_;^@2[RAMIA54G
k1Yj@Z^o3j<TVZB=D<D]3UWP[R:q>7kjm3L0E^NbT7K`^n6XfDWUO5jS\1H9`Po;
ef4J9@\Y^M]nagRC\Nb^:0M@k:TRXjZJlo9VD`iqX0?`De<5Z8c`Wi;EgC=Dln^b
InKlF5oL0Hf:3MK0e2SaM3migbNH=YjkV8b2NkNhNE9UJEgmDEqhMKo=?14bKk]U
[V56N[\SBN8QH=^OO=qBMKM`L7q:`2M96\qS_`TE59HgQMfMh>9IUD9h^S\Bjq=K
;S8mOXdcVBTm5@0J=2jlWKMm>@\_ObpNNC?MEIiVYDCjECTlnjYH;`;6DD1T_EOo
>a>:^1LI26KDlmqg2jmFV$
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
_AZBVSQ:5DT^<NHbd^\AW4l6m\gPAh0^R74p40K]R3CgNON2jOJFPc1BdFES>=YS
Shcb3Gh>Cb3YVE9oq>:AVknP<b40lW<S0KhAW:<HH7DHg6khiMfcAOXH3?LHYf>]
?Mlqj9F9amqZhYSSnc2nMo::L9o;R6HJ>W@1P3FZ4lKAdY5>`jAhXpGQa7ggTpDd
elFf3o_gmo\iNP_32Zb7BLDj=gkYU@:9f\<k5aQS4pGU@iUAMqcA6LV`pK@MBgmK
D[DIe=1VV=daFD>e1B;3onKLO=`JciXHm<2U_cnM9JdSlG:n9afkiaXhVkU6M[R4
6Bld8IK>lFh^<;lBm16hn:1qQ;NK=V79KDP0T82>^eUeN8mX@l9i<=H2e`V6aH83
Z^Wi_d0UQjPXGBG1eKCcD>j[W=:Dd]a6n?;baU`L2>l;PIRo@Wq5^1VUV[78i31^
L=:I<deeE8g3^=Qi[oemo]E6;\U9H\oDmgccabZQIVVg^STFAnbc]CLZl_?bUX?Z
4n]_CQB0N:No6pA9;8=bjY`k@n;kT8N=FFW:i6fA]pG^9NRX:fa@l29G^D23]c;g
32_Gee?AOAekJ[jJXFaRI]?[LCTLHb_JkaSOh3Zl7ld1jRh3S\T7:`@PdR^Lhi[F
\Xp0mBnUi2q^oaLkBfS\12\NDUdlN4=Qa=0IgU_Z?eZ=P6QCE1KJ;^j:77L:ik\D
NC9V;PC?Noh1_3CmY=@?IjTh\ZJ0gEU5he3PHB;<F0];@pWPE>9\5T:[i`ginV<O
mLDRpg9;EFGQHgX]WFcgQCUoJa2TW5nMBg_>9=1R:9;`oGmp2GNUB9=qEeROC1qD
LLK6W7cQY?:G:@JLTf[0ohab33`RXGm6ZRJ[S30>geDE\3N;T;dfB:<ejMa9ogJa
3A?Akh[;T>W`WS_489Oh5oO[E]0mF==;6`^j`IF[nO36WkLPk9mNOK@^WITT6W^D
56a^BAqnHFCh6BBBBojVEX1EIZn`S?@CgaH<T?g8YYF;cMkD[c^YKj8Vo<mZ]_E@
jCl=n2N<c6ZSnHh`VVJQegfgKiNjBUjJVq4iNSkL`kCTK\WLN81OiHjKQ9jmfB2o
W[Zn;J>ZUNFn9N@l`hR6k43g[Z3\OEnC>XFL9N>h\I1:Z?gDRLJ\64QVIJLCpU?J
3FSMND6Fh==4=LcS:QQKWSCQ?ahgc9?G56VCbR_ZQgU6oDYR;^Y^4hOSBh80DL2e
Ti1F\J9Yc=Pm90bm0P8?[W:q=oFIOZ=G?i_bQ]U5?kGbnVheK6NI:U4GIW3G`]U[
DGeJc:Tl]WVgH?fRb_P<ZABLiI^374Z0Pa]d@jZABf91AP;DDjl524H;9GqOWoMU
Y6LeN[km3@h5dIM;@dGjP31PnHV?OigYM8W=dbRV6Zg]cGq<8@Cbn`P@5A`jgKWn
a2FeQRO39Kd_:[MZ]f7U:WLK0^=ikqbK>7C2kfR1KbGJ<HDfhgAWp?[3NQneXP6F
I@S9DPb<:ERd4U@<UXN_:p62]3OI4j<QYM^<3LQm_bcIpPTT_ZRf0QA3]Z@kHB`Z
jiAZ6KRege=XL1a<OR[[VJhkH]fS[Of3bBaXY6j^Yg=ToJBhY9Dah[5d3DBkHB1;
\V1Uq@iEa1iip>H8\ec@qHUBMi\Qqb5cAFS@pVdKZn?fGSjYm?4pM5R82Z3fYgb1
C<Z2IXnTo?Fak03hm[HeTVg@aYgO7Uk_BAj9GNV<N3l^oOVmRXmYS?;7MXneWb^T
DgkbUJ[QaWE\_?6d@SWAn?pm1[@bUoq^X1lIChEideW]ZMS]aF]>JpNUkbkJip<>
YIgG_DdC]^c<Ei9aoXNWFDWm]DSl=a:REMZadV0>;?cTA?ah=p8lO>QYc=TWoWZB
Ai=2lllJ@;?<j@`NTjDT=pXX2AHKo]>2^a:b6dhFc]1IK=CCiE=^kNa?Jqd@dYdE
4mJUHc5H5H[d5K[ZMgj\C6:l<j`<XX6a>FX8haPE9oN\U3JAEL>Q`opg]bL^gqPE
c;:4d6b[ROh[mAZNg>p;R7h>X]X4VDfPVQ:][8JKIEEAJ3INg[8d4<D^66nDhqR`
lNg\fLG7f6P<3]:gkaWC0;;[Xl@Kd[lUgfo9A6L6qNO@2\dY3@QjGT;?Q:8hIF0j
W<cVQ4PR9?U?\KN8n9Ap^oimgPNW47IWbH@1`nMT0^eMpO\lH28JV`3SJJ^Fl<F_
AhWmJIE8`ZbDDRTiJG@_8XWpH@PnYZlpBE[X_U2qc:WU:Eqch=Ko@THPdgXOhlIM
>CNdNg3O41o\`T;OXhSi@KmLXhgUX^1JHhpUb671Y\qNBaCH_lp>Im`jg:YUOoBg
aYR@CClZ56?i;QnL`0bon<=IY[9@H1060][i6BdqWIICcLZfMb0]cl1cVMHM9clE
9G=Dg?dBJ`do8jNC];L:3a]>`hHDqbBgChiZpf``2Nd34A>cPOJHnabKDPIkY:Jf
H;OnL=DSNFiIAFILU;\OGC`enWm[q;R4JDIGqEQc1R>o0kQg3p7Q[Pk`47F2im70
qE:e\H2?]QUX6603gVHjoLHWWSjA0F1pW;?@<7d9O3TdWYp`TZNNa;]LFn48QQ:n
1p>Fb5C^IWH8Liam_AD5F@1C^?3Eb`CkqYAM74;FRhj0@1`qW>;AS@Smh:<4mZa5
^Pk7fOT@gbdj\cpWZcYA9Y\VLhGShqF;<R^>G3^T=mgS6jomU=YAQ=SbdkGIq=^g
i474G77p<JW;H;gGHo\LXU9eBOo\9IiGYY6ha9fpk^m5Cejp>A1cBA<DI?F_QIYI
?_RGj8SimE9HjT]3OUnAI3JH]aq^>inEhqmLgAfGXfS6?a:NS6i8M0_a^UKEJ\QX
fD_A]n?PFo5TE[gDI9<gfOl9j<hWhdN73X`lge`D17T6U[SRbe7NT`Q?WHRGJGK9
E5k[[7?H?U2:9Z?DLGCOGgpeS_?19K=4P3F^XhPIUNadW^G?;O1fQOQO=o;o=]6Y
WPI?0f:BOb]lI?E5=PSDUQnB9@SRRA=mdF]_II]CKp=Vi5D8Hi\QUT=^1e:8\a\`
FmhHa81h9hB4B]BXFL]EkQ?hHjk?51e?om[Xi]R8;U60O[<eiGP;Q:]cA0<bp>DF
JE<egZR4L`An^5XUb35S4KWPgqN?E\eolV5Be=0F3HCQW;`5nA8_1lH=jGU4OJfk
US`E6?=XE`=Nig<Mcj1f;GTVbYG>Z[cJSXmGifWEo[T3qXj=gBS<pVl4ZnBh6Yfb
IOMnRb;kD8G5RU=GPBNCSTOoaGFXQhiAWMa[oU21iJaN[YZ=NOMSYRanY]^LC]bM
6XGC^4f82:9b9n[_hL`0ET0V[q5Q3K3IKCjJXBlXaUejJ]coq<L2]F_M6?ZEXP77
VALmng=]CN0UJeG7e?e<2`bMf=iD3G>b?1DqAK0gS9aqj[D\Cmq_3F49Cf0_l\[W
lL4gl\mE0oP`@k6aAeWU[3f]O>HORo4@123EoKTP`?Q4S2l0ZD:JP`6NGiF4o]kB
aH:477<E>RWc@9Z?1<@f[j5R?3:Wbfai?I1SgN?1VP730`g0iD1a<BK1kdYN=]jB
WonBa8RpKMATXMD]>da4K:bjo_41McBTHHHH79bFk]I=S3U=PTZeF3H[Z0BOXiZH
8?W9F0HR[0bH[\kBLU<fEZi_`6p8TH4R1gP<mTLQS1U9=bWZJdY3MVC9kDYJOWpd
=ib_OmXMB:P6Fieml3T[6`;<=a\ZjeHl_5>EK<GQSe:;QieEf:fb04mNIa4ENlfB
V528o?:V3RkOaGeG\pmn8[mWnEe5@1;f[n_Z1=I34Ff7Mbd\RO2I55HVbJbNb6\H
kc\:0=Vc@SXUFY0D5KG\Yj[n9mhIQ^;LKclSq\khjf38ll_>HB1800@gVCl=AK3M
SVFn5jAe?HXXcB12VVU\ellR=^:7??agT;BSK=[[Bj[]6_TOYR_5>fd3C]MMZJ:W
1gJKSjKP>qCfld3Cd<U4Z`bYSYbaf1@45An\;Idb9W^5KeOXp@QCG0Io@lc=HBA3
Y@8fD;b\=85UmFR:cgmcKkggGbA@;OIm0_mpXTgC7TgDafk\JDJI<RnCDj_nmXbW
NY5kp;cS\NJLK`bnD1aa?BUK;NB@FV^EV6[KOY9a_MmD`_J>qfX]JZBp81A6XfcM
2\`Jl^hD4nd23Dd9k:<QAT6ZD[^Jn]S]kTFDb:7GpMd@S[fMDWXY@qEHFRAcAIi0
Pe3Xfo\`KY]C:F`DLnS>F[I;QOgG]HWTpl@QloRQGC_1ChDB`FkEW=nG5LcmTk^g
4=h1XQSVmB2p2bQFPQ?\APec:6U[eP3HCOSCA<ID]Y5E8YB4A5amd7qgn5N<eW`C
AnUSV2CHIF4Z`<:Fb;LVPGFdk`^<`PIk_pX\N?ohnq>GB0Tmgf6Z<5=UdEL]2>?3
AN[c>`WGN88=I@aXqAhE\C`YpL[fPfoH2B7CMidT`^I\hh1R?\k8Q66]n@Do`G2<
P;CnO[[?7gdYG;dVJDSq\Vj_H>p][M>n7:_@f7b=hUEV1mqQ>[]Y1[KAf72nT`cj
<<R8m2EYin]Seij7gePP]^QiZnibGnI;874`_cG\CPC7VjGFCPBS0KKEAlEnCNbO
<`mN\Ab9Y>qo?cn@F`q`I]LUo`lhd32fop_UXE;NKIqTRIE[Fm5Yd`MJM8l0gVqi
BhCgU1RWjRmjRHC]SgPG8VZ=keM;2^?NUF8PFc8N;Z=Waof3U`LKaCdcnSi[LU[U
ZTJV?<Ich\A<@@bXa?>1;R_4\ekQJE=]Mp0EAYHd>pJCV`4DlQqKd;mBNPpH]agW
h9pWJoR;QTq@nm71kjSS9Q[f[D]R8jZd>eE8[NlZ8bVRTi?XgPWljAg8j:8i3@K^
0doo_cN\?lPbD;7OMK5H>R:AKgRPCFD[3229NJj_Xje>1pPcUS8b4Xk;BKCSP^qj
dZcF_mq?e`^BlOW[05fijl;B\aAI1p\1N6`dnpX^ann`UX3P=2JgY^1N6Me0GDee
?K76gCjg<q\bDmD:`AK`Aabek>PT:hOR2L=T=dj4B@b]apIEdbSKcpOenfDNj:gc
jdLMLcO]F7pSaAPk`]`S39F1WVUoGZXN3g7=4W[Z[pO;CSB]S$
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
A;aMhSQ:5DT^<>;`QMTPgobI8R_2LVj@3FP]KPqXRm;=YO:I@W?=jZT1kdJNKfL6
a`faEbP;9WQ2T9E]ELA=3E:Yi>8FTHICYpc3E>h5[;[<;Eom^kbF`=18PS_m]cME
jDG46Hq]0EjX=pSPH4026gdD=Q<e2bQBoF8d]inZ:CgCA`pEEbC5RoYjP629]Tg^
P7?G^p:dH5ZfeNKocBMfSDlaCkpkEiPEXBa1M03:Jn`OO7BHF8XgM^YlLB7[opgd
6EK?7CPeaka=?g8F;SI>d3B_O\3WEQ3QgEp1X`;>_A7=MfD0@<Ja`m5L[d_^>XHA
_E=4JX0ObgS;KJi;PfT1^fImFR_;h;DbIq<lN=P`SqZUg_V6]j?Za\QWDoLa<jBP
?VLe1iHG:IOHOSe_jWJ=14Z>CPOPE@YN^p=@@ZlRmKXBo`Y]8U6DmFQM>]^`d4kE
if;EeaFGUDh\lQN83ApIdYeMG`NS=jV4c92SbbCDl47:>h^DVo5[jARiIQd>5Gpb
\\SLA1pN3[lh\870_KK2D2j2\4l_lY^Kd<;?lZN=Z5W\XEXfI<]ZIg\`\JJUEZCg
T=Li3?Z:f@5l[>dZh\\KdKfJUfMi1pUn@?i3GB:fSQ71Eco`a^kT?JVGWX=TIJ?:
5pCg<Q37>q==X2EiJ]og9oh8K2BPa7mA9PK63Ue<BfqUUYT\fklZYUQ<97HNe`@^
bQ`pLHU2F0gqQGmCaE^pUDPE;9l9XEK1QIElK>Y354>M0jTTT_f^DegBl^pHmXQX
JapV8GU;65UV_iPiA^37:5>=_8qB73ADPa3JLCEmB[G10]S_9@aAebOK]oaVTJ>j
WH@@IU\Ob\HI3Q1g3hpXJA9RMKG>>hO^>dl[]NnA<5^SZAE8LI99JgYMZb2HYBW6
506q52dg4H>A97[HQg;KM=j?`E@i9k[l46Rhd;0YPXL_DBfqGjI:Q_ZqVRBaAVW?
Dmhfj@RH5n\5RkaSND>]4R35<dUN;hMD=QCa;2OdH3giZ^dngS<S][l]94@66b=J
>ZHgD;`>YJZRT:3pXnGHV]Tq4DAhbB]lCM^XCW@:8LF1RE:SOid1c9^]m32<H4C6
T:e\4^kB9EegMo1??G6:^YS\eLIoE3I;m>]NAYT_mUiRpRCV_<]]8B;IO64B54MV
Gcj3:e8KeVDlOCAXq5AE7InK0QCB@Ze@7L_5<6T;[VmYW2h]c6PC<lZ;^P1Na0jm
HdAC_5LeL[QLm^;Ym[R[Di=PaQiKdEkpkXb2<b7?Q5F=GC7CGf_:R;Xm8ZFY[GOg
;PdQg52;BiIGEAJUgcBqa2<CdLmpYUd6jBYW188m01Hh_dVKpA^Xj2B:qW:fR=4^
h4^3[[NNHaZ7SefM\2Qo[=leO\^Ol]?mFcV`3j>]jp9ZDhg]^q3@B3D3i0SD]Y6b
RU@]=Do4MnVKBn74I^bEq5YQNbPkK_BH<9_a6[c>946QaQhpm^V]65Ypf?O=h;Cp
V;4mZJ2pSERBJQboD@]Xa;nXER;21Mm_loSHc>JA9Uk39aY;qGeEPN0M6EP1X5b?
dgLi<E_;ReGKh;PkSakT2N]]`GZiCpG\^H?3>Vk<Jg@A466`EpF<PDnX^cDl>g^i
6kXL9EG1DE:nBX>YSjZe37>GA;OaKOhAilZ_mX0`6jpJfmZ`bHS@DMGG]>J:k:Ba
IUb<oK06:mB:S?]>9f[ZC_O<[6AKU?4jgO;0Ni0q4\_aYKhpPP:N_ZE6MXqN8Z3j
a9J\18DE2A<>Z5^aEjjnn=BZ`BaM\S6T@[hSWNU27OkpLYG>JlAkh5d4_]kLMUVc
oZXhT:8DFaAa:olOV<55_1[P[IcH9>8<@BATT^hA7:gSU13jj2@p4j_@mQ3qXad@
nh0U78H5OdP;0:Zo<<Q[Tn6\;F>UUC^LD6FC3;pPb>4D=q5?c]cWnU\b\`Hb=4GQ
6M:YPQa7F<\P[LRaf8X:E_HKEPq2`0N7I@3b:MiYc5HdVF1D@lK9H^K1=W\KKSi?
6i46mE;pDM@if5S561OhJjciUO=71=7iEgONGGER07BGL3hSMAYA>d3\NK>k`YB1
pXQdh`KI3FQFa`1h;UAaE=1<WJV;nGCMKCP40b8EJV\Me3G:ac0V3S;fTgKOjq7b
;YMi=p@UXDaYefXYpKDmU@Z]Gnef<7OY8^U0BOY_g?ZQ5I9UbElaLjA5PFTbdK0=
oolVLqaUjif7c@_??WV[b7jhQ=^BGCc5KlG5F>KH:^H1beCll>82pnYM7SD1NBnb
8[f^GCf;1YFCFJ5GH@C5]YMP<?ic5Ua3d0`cOQ6onP7_4A\B_5Hi;dk9C5dF;haC
pkA;^QVTqZn8Gd@qk7m5FG3f\1nVUQa<LDn^Tg@iSHTBP?<H_GV>2^LTiN@7q:9L
LRZRkZ5NS=HcGV<^MnG>ET^7ZOYgKgfMTCHSn^oCMpK?i_e:hJ?4SUhCNFb71=\o
=ja?L5iURVQ>_9`OUDRhjC<K1>AHT09Sn3qnDfWk3Dd2EFoj0Xe<T4<\S\X1DaVU
on91d7]2OP5DeT?ekaW85lVL;ek4AFGpBaDLe>epVc<^@;k5MWqVOJ]FEV6o10[P
75:G=VlA=fMFJVb@GU=]Wd@Gg><qf^c@Qc453RA?bX6YX9QZG3;g[ZB@UT5<i7iP
Fi2cO=Q_CYM<WDUjpUTCLka>kdT[R3n^bRD`nH8:MO`12A`2G<:dLN`AL[XP_60m
k?cP0;GRLlFMSKDLfZ6OTDhGX3QQqJBGnXYdpiLo=7T$
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
