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
SHJYISQH5DT^<ZP]L^OdYgS9pC164XICaFjPh6`X:9=oN[oAnejaXC[P8M\9QE1b
Nd@jLF:eaX95UQ``YVop1[aOD`TM15@;fHUo:R^KU;=HgmJlZB_2LMC?iBRnMdAn
^7KH;AC>@Sh;giB_09KX5:RjmSIpamFV8Lq\5QXb?p\Xe8oi5pHA;blDBdnh[kj9
8Z;<1c^U?<ILDh]_`BVg`Fi]FLjLh1LShceClmJbeB:1=p<1Ah;h6i<ob]RnMRGd
6L;ACb=\7Qk[kjQT1Om3qe;]<^0eQ2Fn0Lc7LAUA;5Vg:5WaP?N8b\1pUG@643MG
fcoJ?3lck>BTe77Un>Q82\IlYCTXa_OQ76gq@J]CIYF;VX:V3E=[GVO]l8@P>;`_
liKlR529\_5QCa2pIK\Wh^8ldaR;PKY[iUa2;W5eqS_PI\V0BoRY7mhGb8?Mh@b2
IfHa`efBCp7FB2XI<LkYW9_jWW0KMLlSo163OA5Ol=P9qkR428V=2F75fl?dWmG4
OTLgXbJ>k7Q5pi1\bLUnRX:6<>n2g7I8J`mbq=mTb@5Mh@`]9NlIV8Oh^i;USI@?
_dTkEGdEeGLOR6HB<aSN_W2@6F0P2aWqcemFXSlpV9UOV9R7k3XS6]6=Z^]E;DJn
n^[IhEKWKAS1qa9g@2fFJ<G_SBmcQ5XQlPaU2dIeaI@`0KV_C]@n_eXPkqg6WS[J
2qK54b;3]n=X5W;aoOL1@hKL11`F88qSA1Hm@[I`bNTRbA;WYIRB^fH\SAH]NlLU
c[dP4M\2jjO=<kBBJ0\Z9Wfpb]3B7[1BjmF4;9Fhm4n?j\0df?_1D>CHP0q]MlPO
L3pEHnTgZ<nlS6j<`L63@>1qoFC0H^;pCcMG9_F56FA]ZFL9;DeWE7`S8`0KgRW2
2b\5]MFSmgOcob46WhSH]EWSCCkM<JK\6@P1DAh\JJmT]B<jHQ<X<OdY:eVMf34g
^[H07mX@W4SkonlmIGp@PZC]f6c^k\B\;N?BDeJeagFEKBTV<nS?lHO:64AaB\CM
R=P;YG[;NF_Xb<XqnRUPk7<<GeVYhG<bn>Ah17JkM^lSH5Qn6gf01W:^BmYHES57
`7qCPoY^GJ=l=I\9KVhWkmPY9kSEnK<imh=N@3LCkmZ1GU@Bf9XkC;jqbRinV]gm
;GI^8l=NkUI@1>b@flm\VQB\AiRPI3f563UQ>I7VTnQP?1foP<?B>JDSp282[l<D
]6i\MOn5jf;YaK7`eJ`me9Of4R=;6UZYhbS5nVdL\8Qc2HIh\Y\gq8MdimKR[1Wc
@6iGLCVa\D0MK=T\^aCbIdI6O5?Q3_hSP_JlaIf25jK80U4i>0[4U6AT1naoGIH<
i>N5a`cqARI\?L=6R28oKFJ^9Y9J64nm4=Imffe6eGU8nP]RgTI]7PSNFYAm<Rb1
;`[BLPT1^OO_VV9^N:FJ>iJSk]1UjXaNeN7`Qk0oZ>0A8E;BPX_@0;XpDfIm3aM9
kFeHhI?A=goHNLKGTd=4hF;M9bY:QTYEnd^44`DV[34gb29IPA3:>;`GDRapBhoi
i`AWhhk=4`cRQ1ZkRTfDkfVmE9\Oh0R3P9cWNCOAP4OiAQ8dbcE^>QPA3=LlpA84
k6T?Xi<fSRF=<aojC?^Qq2oI48I;K<:l]RT8R<6U`7j8n=VahXjhAC:he6Y9[gl^
2QEWISRfJmYDLWc=jnGi<GFVMjJbO8STLX5<Y6Nl1FUZZOX;jaWM9Xm2`AIpHhmh
02i\;c6\LhPfQIk:28AjC`@fQo`iFi8B:4Ve2mTA[j<PQ7MLG:Z5GJCLYn65^3\n
B]I^_1qJgbW_MlFQ9A`F:SqhHOk<VgVKjebJDRS9?1jQ9`Pk1_fI6X\U?fG1CpaY
VA^Nk<I]=9nAibDE@o>F_5L=`J4hN:=R7nmibZ]\coVP02QKEH\NY>UCJ_ARfpA7
b2^WDJefCiYDcCIFaXL2]09W=_TNSBonR9AQTph4T8;?n:mQK9mJ4IIkNfE9pW:F
3P1]\a^kajX1G0C?mJWapdf5OU>5Ug;Ai@]5[Jc<GJA2oQm_=p3;BB93b^ffS^C^
:CdZd>lgJk=llEF9D@>XqX6fiAC;ZnJQ@4SPAfS3eiSARokkiDH?F27U5jE[FU3T
54a]4icR;q_QcGm3jB^\SN=@LUDlpD3oEWlo\SiZm40E;:bkql6bNhXle0?lP?di
GAD8NBj>nPiGbA2WZX1apk5MOY;?cM:=8QoTn\UjgkG]oHZN^GR;HQfM^Gc1Jf@4
o1j:iP1CMAgNkI9E7]9Yf4V]Q]>Y>MgbID1pmUeYGFQRoMV5U2f9F1UObREM93O<
=IYc7UI_e4L;pJaFQ]MO0CVCi;JZ<TBc8R6^BVeL1G_m;@>3019PJ?TnKhWOVnQK
L_BjBIX6[Ge[[Jd8jXQ$
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
?QkD<SQH5DT^<QNHdfc[h_Il_F\511Bk?m]GVIQFmcqL=S4V^nj3j^HG]JVf>XJV
9Hm_545kJAKe^;8_0jEmf=6ge1;ZQ]T\EgLK61Oq\Qj?hRNC@ooFELN5Y=`J2`a1
Q3W@oWSC]VfcE7MAM?4E]^UXFRmo7JONd6HTOmM;=Sfg5Mlp=UePa1qoIkF6H6:3
Na=oEmKP[iWBGfpmC?P7:hTdL`6`RJUTJ?gPB`Yha7e_oD]W^Okg6Wl\ge7Ql_qo
gMhCkeHgT3a8Od9mZ@OV9GKb<<UVF1Y`=HoJ6pBSIN9mp^AE25PX^CGd[b=kaV5\
W8LQ[^K;p99]0Kj7>BnjgMJT`R900e>IVGPSfg\V?fO8Qm55Og@A;^6dVJSD;pTN
kjn<Y4g:AX@bXq0bEJEeA]BNQ6DT\SnBaU4>?de[L6jBL4foV:>Cqk:PKRb05A]T
l2@@7ZAdN4@]=Oj:R6<=2<4VDF9<W\RkD8[^eLf[1GV[@XmGGT?XqLRmOLb9q<7J
oM:?2ORm4a>NZbD]1_3=qoZb2_9j[L>`I3__Jd`kIUEY>Y9Meg@m0L2@4cV;DB0Z
RbWDogn<J>nX0ZLIadRTpl5oR7hpkaa5d0ghiL[@fVMZLHGHR[e4FW:YR;5q7?j2
Uod80CG_<]ELi9jpaPj<fNIPFe3fO<0R^J>dC>K6CgAa8bDiMja`H3bpoY4A3To3
^KCD[<i8093NITaZ6RHg7O5Wplg7iZBpcg_NEgiZ0N1i]846?HG5XEB=pUlJ0VnZ
[3lKQ[MA5XYYG7CPXiL^V0GK99TOP`<hGoN^]k;n^YUh3`IpZRjn2Eoh?DG]U=HX
GVhdij6\2\<FbLZQK6Wp6688N_BFJRHJDOOII24UG`R_0K6aISOTe\8A3JGTZ4B=
ahGV5C4MXiNdo><D;d0Pm\>_=kWqaTEc^lqQoYSK\jqGXgOT@n3`7lPN<BkFF;fe
6mhPAoW<2_lVO1Z=R>]@2Bhhl7cJHZFXTqOE`hE2J^YcmN70f6^W\2c1q2YFBXbg
XdcDKJ^DLNWR?VM\qUOc^nQJ_cEf?;TF;_43\BBF?iff5M\>YW??IDE88cjJJkgD
^KBECBbK3FQn;:cW<Zh[\1l^qY;=7T;m\eORH5PAPDQ5<j3Bq8^_^689[eeg6>fQ
`R@QYh2>p?;`\AkO0IcUJXg=\6Be1>mpMgii37E4[7]Jh]>8=iIdU8p7@GfGe`No
UogMT^^3@8`9Pp3NJ;:9fL>HDG3Yd_G3W77DVR3AGp6VVbh`Ck]FD1giiJDOO^[5
n9eLBp5`=TfKiDC0YFhM;nD[qV:hH2JLa]X[b<Ya>W7lkaPY>6ATTpYNW=J1\5AN
6`Ed=eg0^L?Nmk=KL7qcmJH@E`0T0l[DEG?<O5=>VY\U\1pVEDiN93]@^9@<U`4S
3WP?;HERNb[LbMqbbgVLUA7jm=SLMS>hoNFHoiQbRQMl`CJ]Dnk3@Lq^Zj3gKIE3
ZLRdei5dMGV]QR97]\b5jI3p<\_oUL7>:ITofR[N0gdjLbRZoh7Fq1_e1ceWe_>O
6n4\2`6m@H>DHfKYT7^Y?NCm@kiQR=GmZi6VIBCT2:iLCfWpjGZmoMgW`Kcg?nFV
@@C727Xm:e6DeN7ZlYqjcLD3?p:<4Pl2q<IV[i2pmJ0;klTnQQ4fQ;9`PPe]WVCZ
f2]a;eKq4ocLj`p57MDbNV702a[IjGlncDh<1kHe_IQCd7qf9;J80[;b\GIXFaHm
_cE7cM_Rj6E10:pD11mIT[O]NNR5gI_7WlWD6oOcEFZ<1qkH0;?liPA_JYV2g39;
kla3VVC`<EH6p>_Sh7g8c\4cHF3f;kb?qOQAWj3pn>a:V\3OOI`<4FZhF@4ZR9P\
OfneHl<OX:DLlkQfE7\LZl]pmT`6F`q8l\E9`p@<UKgdp>]<OgL<]DMT[I^RA206
4`a7PMH1fkY;q86YoH:\jRUimY\oJmC0ea^fV1]EZS\9qOn5j[8l]K025RHdJl@1
U>U?Bh`i4>Xq6ZN9m<k;]LeK3T:p8iPCNmcYi9FCcdUkUHGo:9^I9AU_WVpfLa8W
DDRqiG[NiN]p4`jREhpj>N:XQCq1hBj5HnUDC0PRg:0;a;1?WoC:SEQ]_<32WLOH
PoHh^582P1V[nfKD^a`OI2Ej=C2naQRSSKOqej?]H8[L3A1bLk`BDjZc9QggmCGV
>\Gph=Skn;alC`Yn3F7NSYFmKDRilZG6mF2plI?kR\ieD:k]8@@E6]DEiZ;<ZEL0
[Bp`jCd[fDB?lFgaB]8H2do81>>BGE2i6pF8;c?hMp;^e<nQpHb>Bo9OpiMgd:Ca
f>_eg;b64;=H1qNU0L5RX^e?`<4l\>S5=fP@=^pe>JH]?[9mZGJj0h2o^7_O8V]=
OYfXRp70A6[ToW>=9RZ8n`eD71QVR;ZY^^hU;OK=q;g]1>=F6DK]S]YbV^A06QE\
d@>d5f?>Rqcgg@@Ch\YJO0nJdf>gj]W24UBoa^4nL]Od?8X8AqT0mh@4f3FTkH57
iHFVZcOABpaACJD0c^Hhd\N0aUOFdm4KD5jW5<^IjoF^l[_:9?qA<^flk4ABWb3d
^nCoefLY25mOg1>GOIFfFYXpf6IMJZJ6:VN4oE679CDQfO^>NQSi87P_HH1aq45S
1[Ik[k?]0=4QSbmd:<bN2Y8^TXkeF:j><po564R]YeS;PVS3X\q<4;e`AVo_Z7L[
Dhkfo<5Y5LC21eNGeGUl?Pq^:4cbnBV68X2BX[bZfUE2bU[5\nodUL60KLpSTiJ2
F8pUa=<U08Wl1[hl\OAMapV73dQY5KHN6O\gKelAgIdlXRqebl3XNO?5lVKA854N
hjDXMWk6kjHHWpUT1UmndOc?A21Mka\ihGEnOXN\NUobPpXgN4ni3XGXnoZ`E^jb
bmCf`=8\BQ;5Wq?VhR7AipEO4W;3TgI=M[o2^^i[loCg]FWmjh\5AIPYIB]nPcCE
hPQ6BqQf3MVTeIMcWeCgqQLD@oLd]MlBQ3b]emHFV=>ma>@MJ@4SE1gCp5PhYAmT
ZRM4TXE7B[WW>>jfBMAF6J^^k?C_7p>BkO65kK=>0VP4?HG@8dfg5n;\NXNnT=pj
FBBU`[qc0a3a^8TaegZK663m;gB0`20lRDRg33<<gDq7MXnj7WphjZjC9jH[[:QF
Q1XQBhd;O?1cHL2]RLbbcFEmbLI7]CFO8JApUdQQR1e:9N\dnUI>86[C3JHkI?f]
X?U:kCS\XOJ4_=4VD3\2>>H;P\ak9Lc;CmTP;jA]71c:JH\RnZXMeW_AX?]Fp<gg
CF2>miD\P0lkUgGhj2SpUkGOH[n4EfUEF9iGbK4E5TgGRMiKp9\[XkBoY3HmeKQB
bih9IjYP6cUZ0GUo=jd0lpPmSdM5YA8>ECOhMGf^q]a4V=<k466GocQMDROjI=8f
3RJJ?^kXl`I4pnWO7aT>7[5Ulb^hD;EcoBQ7l=E9T4:4Pc4E7FR9?QPViXZ?5Uf?
Z1KIWnd=E3eLM:\i[WlpT[D04nAqKgnoVf8ST7UYl:Zl`W5?EcAPFn:`Nnl_3U14
2L`bqIX0ZPnmqNn>n3d02g3\10>9mDFJXJZbPLo`^6^hZSfgfT`RjRf\D2M=Gff]
81]d<F8VH0Xq`a^aT@amKaRRZn]4Be?_ZU`P7?H`4ceC;^O2a>niN>NAFf5j\_PG
g79pE^l<h[;qQe0E<LVa7VDlcKH5eAU]U^Tk=_KVMn^MHo8gL`immi30NM;__S:F
E:Z0AVlS7k^BE9;G2O`_Zi`7ZPDj7RmC]]TQiccJ8?l;blp0F_NMnbp6Mo9GQ;=^
ifUK=AMQRF>p9gn>1m62VNJ<`;Lng@97TfOK@23\`WiFnY?1868GP^QgjPkJnlFo
`QRF7PaE0ZVn\3KaJj^\XfH7f;Nnpfe>ge6hqgQjSFeFH1m2qM>UD8;ooUJIMfV7
cZK>2`^BUf905gV8^g:lX51IFG^l`J?YKiUL`kFC<L]oWq`RbDg:UqdVMdUeX642
j1N@D:L1PAb_;1<EhHU[TgRY>cBCop8mCb\iJXHfg[Y\C`^9oU\oe]dKn>Xm3$
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
jYI;fSQH5DT^<bT];b4<6ZPk1<Hl^R9Rko\4OAkBF1R]n7XGZlQkjj2aNYpQ\bW]
eNjH`3Va[O\3ZC?B\O2YT3ZM=kIlZf]B15eWgKB@Y>qS`7VKiPd9i90T:bFbW>9=
X2NUlP2i5TLC`Pk[hflg@J7SYHZU>50_cW<4g6AMo:O<FXqD=7o[Gq[RX@QRZ?9<
XRCe5HN6C;?N^OYf6aRbAK:\n=W:<4fjB>8DilB=J;EAX2IbqI6QWXnjCW8G;B1[
Zf[5j@hF5R5i2gnYOYD9]8K;[Y1Nk42::7l`OIPiM=E8Zl3^f<Dg1ja7aZ=IpRTU
]]7=hc`>9l<YPDMHm[ape4c6KY>5Ln?oE[Si\Z7YODaB?H@La<hDWPKXh0di@W]7
ENnLH8335lPp[B5Keo5O@e^Dg[M232>STIbB=]`]>o?EMb\23VW\H\^kG_LhDVod
ZnMWS`aH0GU5JXX06[=B\8dQAgJ]HLZpNUk?HKSpYYE4SX;oEiS3X@^ZDUFCiBY<
Rdi\qc6cdTfg@M_4SoY[aoUMVdVL[k4LC_HEDf[pRIIa>8Gc8gJQ;gL<g\\ZmA[;
3Uipf73ComJqD_BCgfFk\?P^jJ2ZO5aB7`PWJ[W8H6?_amNooi5Gl>=;PO5cQ;5]
WoR=q08DOnD4EZVT`K@`mMJ=DH>RDZk7kS[RYaeT591@NVBAeJdDDVlY_7`848N?
TRL]jcon:2PB]=1Pe\Nn5588bp=>^cYh>pf<i8[ihlF=0loAKQXm5:lPLGo;f<0B
>pe^>L^S<LYg3^Qc3;D<FkDeimn^39@0M1O@Qk>QJ_DbB>C9g]V8B7flhIq2nBNC
:2gPZfV=n1aU<j2@a0UNHN>EgE^@UX2fkHEfAbkB?=\9GA=iR6Df5Im\PBdf>Vl[
@]k9`=dS@i_ORhPq@USmA:Pp\c7n[flSJoS=PB9BmE0RF2D70RR22e3qQj_@6Q\`
Snf5Nb\p9om^^lqH3Bj@?ASBeoU[X\icdD>E[SaF@PaB>b?<ClD6oYY]j1b7oLV4
M:V]A;q]g3>X3e[fS5R_K_6mW]nNmX]@_W=c`@MBj;Z3JfOnUXPW;]Al@H`P7fHh
N:5>oWLGWX9M_oE=GKOLnd??j`qUf8ReFlp0@cF3@f_>3BT?SP?P7N4UgWDhM_Jq
jbSIP0QnS\WR7aN2@;>>@LJM09W>l_6<LCI<7g3mA>_gPoeceDN1>;>Qg=XYDZ]@
:^fq^=3]\`?pgGikA108VGKU7Umjjj1RUiQ?Ho:ZGZ4KXFgnCC_1IB\V[ZKXYj;I
NF>\Lj=Spk;Sj1imHQglS[_hMP]\J`9\Hf29^FKgcTKCUi7LV>IIKMKR_f:OGdhY
\96MZDf>mVDI6?<fLG05Pf:qMQMj:`UbjBgUGToR;J<hao^]l7Hf\FK0kEP:JP]b
n2ifAdog`PHA^^;[RJ[^6Q>5MXEF<NcTLPbC;S7V\]V@lfa5O=2ZRPqZ0<_9X>NX
5qcVaVeQ^j:0]Dn:F0i:^XMS:RE8nWRe2Ph968EnDpJGXoYZ`0J[^1h^2LdkOkjc
NMka2m96eORIGN7DOM>SZH[e1]q79^1k:aFR5eInPhMm[JIYDKS;8fB\k=LHMTLp
FbO4=_Np<cCN<j3qKh4KdioqTfA6WVOfBk];m2FJlFPA><^?gYXNHTgZp7k2[5`2
qAKP8[07c4?nQMo`^hdlJT4nqniLS_A6>]07V`i5S0ci^T?ONdca]QT]I>jE9\La
fpDF:ljGQHHAI\Z6E8`oY?BfUU\o=YqLCXH1eAP>_1f2S;XgL\o`=q=[30SBO1go
_e]X5GgR>^qV[HEWYgP4mCLo8@OQk0]lAJ40DIg=J4G]jp574YXdj:DN:e5ZBFmG
L?FP9@Wam79WUIU>qGRC?>39g;8@chiEG\44G1iJZF7fp?LT1TS6\=]gd>D3FYaU
=<cL_ZW@m_3ddqGIDB3`eHTMEC1g89EoN4]m8^e<`1Sd1`okp\2WC6Y2qf>VEfZo
8I9ADYOaUSacFpm;dFo>E:8Uj7O3fH;2NJ;Gb_MU[5Doi5KG:nGN;[b1K1N\C3hC
BghIS\Q[_n0[I[=Y1?>Fg^4QH6<]f9U7@N2@i>qJ1iQ4QU=ejK[BU8]gk`VH\2q?
O9HoXRhC4F\]efE<c0ffH@8T\qF<]5:\1p]FIaEZ]Ug8UM[oQ`4A]mCXRj][O<[U
EXFGTZPSo]5Nfgl1=E9kV2Bm6\qSjgo[R14cW5UZ3=>AZN6TO;ADX6geERQd0>^0
Ud@9SlO_Sb;[nAh:^:hE36GN@7a>f4HBj\3OW17<@9GKR0C1bNQqlWelcfHb6=\^
JYYSe<qe]LP@9iAM_K5DCI4XKD[:kQ?3><9^5JSpnhkSEb?\;bFn8fajjBgdFI@_
PRqe[A97=I2?MR4^CQmn=ajno=SO0m1d6l:ROV=bBTZ_@W[E;WGi2XKoFBCI[X>3
Q=OenUX^eIPq1hN<1UaqdFl?eZ[RO?V54lnj?AB;`9>IA?BP6\:ULMT2cII?9`Ni
dJnlG[1@7O=SF5<hBEjaCSMiN0jTLfjKF:n2S`AAjP<VPS0EZ3e<_mSdTS\cj8pR
0UkcK`SoW[e9HN\C`lYC9HWijp@NCXogF;?Q\AWoi]WjpM:TAYi[pnCVM5BVI;BC
PZ`qCc8I4VamodTjg[l1RB\_A=AM=7FEJA5l2?IhLK@ip0jPWJIhDc482123ZU<]
dClgW>_XSkfH9MAEbokaeV;Y960G[IDkBi_RC3@K[niR3HAoOYfBk\6YXQm>9U[8
Lg?@LL_;eE^AA=EUj1fa:Ri_DCmpW731>UMomlaNb;ThT0Z;e2=X9bqJ7?;CHmqW
l9o3aUPPoEoVS^=eST[5m]U`S7UMYnpKcbM;a69]jQIN;`co\2bSd4e`V]5V2]g[
D_iDREpJb7?X6GnVMjH5h@gDNfQUU03`4f2e1SIHVjcoTfhEjf2BULNgDI`PIBgj
lW6m]IcTE7TL\[Hj\pXXn[<k:PE3LX]50IFANm2[CA5UC]?eF?:[SkS_hVDk\Bqc
kd[>K;`3XT8:l<N:>KkL>DJQ]d>qQmeVnb>=?LhSP`?GKa1pPK9Ka]m8S\ZS>;i7
hRWDPDmgFn>6FdYZCGRqT`;YQVANDf3c0gBAe>i`h`gDj@@^li17YKXGORW[=l4U
P<[>QXFpc`>Nm@68qW>VI`<dZV:6iEM_cp\Nl=7==kCcg]XB=J90>qKn4ib4kA=]
kQ2:nOKBhHBE[d1b6<9;YA_XV[AJT3HSq1Qh7]iQ_YkMUCYf72\OEbWG`LIgWU6>
31^e85]99S6qIi39WEPY9m_LBmkcS2=FQHma2kVWjM9a7KiUCJX_Gk\b4Ac5_iLT
YQoh8<FSiOqj8b<3j@DdW`Xo:3DB]4kaXSN0US<oFVO\U_jG2:j:dX:\E70J4WpS
\dCm4b>p<TVILW@iphe9F`9e[EHPYEaWf3a_PI_WV:dm>RB:Xpi]C<U6Uf>Kd]7Q
7GnF?eO[ELK0gf;;iU_1<4]cQHfQFL`9SkjTeeAb04dc2pM\fJFOL8=UjG=ek`E5
SWI5p?jL5@6LpE]C`JKef0;<6m3Lc=>iEkXBh[Dm2XRAOg3E66A9]@oaEc\S5oD\
3HWPNPm9jX41@4IT>gfXbAae6R3TlR7BBk>2I^Sbf>lR1<Jn9E7PLoghS]<WNfDA
m]joo7CQQ0mp>31TTc=pn3kODhAQLC`3?G>SfE9YZHWJWH68PG;6IDdf2n:<GbML
NGdO]CW3<CJemiYnHeL4nI:O<K2pDJF51SI[k4fWY0BBO9Tdj7IE]1lHln4;VJ@g
2^mXXJ4c1jd`2]k=C7mBb4lNdPmY6535k`2nTicX>F_7D0qIQJWaXCdO^0dU@E3B
nIXj^1LR=AhehZI^Q6=0Hm?7eFj2Xb]=BK:]Kpo4bUVcgYdWBHhf6Y1OdLAZDLq0
1aZ?e8q^_:R9KY7>U3O2>AbVnEHVS>LK@55p]^nJ:WWJCLH`]o4iDjWM2WlHI=6g
Pdm]FQ?^=f\[K\JJgB`=N7FT4hGX4ZR6JDF:[cW:IPbLljER:P1;D0^MUcCMfcgR
JlmjUCDT6Cj@23YQ7>[_49\bcNiTnZLQ@g_d2g5pO9EEHa@qMFmFSYdj3[h7MT79
`>b:_@DFF44;jBAQ=cn@2F:16OqS^j51\DbjJUY:PONRiLoOAn_GLjRE59_jLY5O
kW6a2_1NNH6K]mA3LIUR8LG9iE`mVj4_2]gakp5OXFJHSP@ekg=hC0iBk8L^oEQ?
`cRV>lG]GqJ8G26QPUiAFmM8H4_L:ZClDEdVdka0?i=^\Sq1Gm;BN36R:8K7]5TY
FPaG3OFg<:`hULcpjoICmW4iBAmZY02Ei4:q0QY4L`IpW`1Moh8lB787;Wb:2`dR
SDhP0L0IjhJ<GV[Ib2m78i8i:LWQ[^>@34cj[8dc3hbXBo:M;V8DoB=ik9D?jJ<=
qZRRH]:BA^m<GC?Wmj[8kIoaap=1Q0\:Eqnk5IP=fEl68c7WiWONn7^lR8>iUPHc
^TN:mD8gQ_na1J8aV9ZN9;Q]SI0n@?Vj7GSKfJZdQYE;SRIiO7A3c<C=l\>3H@KS
nH3l71Cg455^e68aVg@i[]f@[N`Ol0qZI\4UOF^e1V8NW_AOaGU@MWO6]cb<2Ml8
A8\la^ipc]7?nbApXRNTNj3q^Hmjh6pd`ZC_b_ql86PPKT9Pa[WP<;Ce_68Ze0Y[
dd>p>91?X;V597k`IaH_qQ6EfOH:TbIj:OC^^c<XN]XKXDRIJj7R5qYf@hBDSqe;
Clc2^X2e\<]64HEL9j5[6m?Z<cV97_=?_T@5MVR_GKUW06]AWb31@><Aqc^H3SCM
]kjkASKU<qLWKNn0WpLQ9Dci23RUXHHUiZQ9ddk0ST1_jSqWmj`]f0EX]bA^JjTm
QBp_8jgeG:7C_5C<0Fh<2bWli0d06_\DekqF_AR3WUIThD5:A\fBS:YY;n:jN0o2
=fBQLBp4NMObVb\WcLio^SH9]o8:F^0M0b<_5k]Jc^4;`lK9>Z6c\IH2m9pnZdMi
^hLpFAXRlhG\m^RM`PP@TT`qQ\j=D1G@>9lMPk]cl?hT6M29acH4CW;^YS4i\82C
JCq5Gld6M@>?XDMa?;>fL=L@GKc_E=TC1[1nG745oT2Y4qP1_Gf:C:hWkld>@EQQ
]]Y@g=ZI5;Z4ki2iJ[[AkW=BNH2O=4jagpGFSZ?K;Od7P7@D3Ya`D:>1K8RNgU?[
P1[GkUpZg3KA908p9Zi]MWh;pMeieQNXmEeQ@hhlpW0Q36QTC1;VFZIoF4UFelnf
Hi5GRnPimXn2gp@Ai=\<_GoVJ92Y@mobjbj@<\;9FhOdiK<iFRbe1jD>7H^1q1fn
P41SLpj5L<83fa<6N2b[;iW]A42mqlQI=eDNqJ=A1V8g\LRYZ>gBmp=VE1D4liJb
j35We4c1qm=7Jj\lqQa3d;FV6M]0>ShR1lG=4?NW1PIN`<B_`XZNlLdMho15pANL
:h>\GRBDPnP\P@?jJXe[24<n8CR0`PW3hRABmgf0VcC[ZdO[mEiCBpdBJTHVkoU^
m2bDVUVUIeVUfPqaIGjPSLq>]4@?oED03BBmKoRqB:j9IU8paa3:V]Xj7_6\Q`]M
Afi2caZilC4=LCFE5QpHC0H\NW8g?]f]b4;MTVq?Rm[iA6Y_f^=ZN]mKH:X_Hk3E
2F0dXkjp5lmkcP;pGZhNcJen:NPgY]@8jZ_pM009IGQcZU]4m=cfI1b?aM?6FGdV
Dme5V@;\9?K][_cPU481=JH>:n\LV6q=fW\8JX94G1:0ag@5AF0WFIj0dq=gD:9k
3q<B7Q`6op1<O_P>6nX5c`8M>3ZXM]T<]0L9MEinDbQ3LR5F3X5JH;P>X9cE6Xd2
2Z4\?8g]X1L\cK2g5^i14hK7Qb;UX>=8oDG5VI1VD=[m[eG6F_23ipo=:4BG[pXd
ag^6pGn;j_iYOAb5pg?XWTMT1_1Db?Nc:\6h22SHmoOE9F\_ga3lZd73TmIJEA^G
baHh8^4o5UFnJ=R9MIQ]cP=4LPLYEYM7VK6@2<=0X8dRU^c3oib2=4:3?m[=E191
qDLj[PUjp_ikUD>3D1>n]lK0_2d5?hRPf8ImmVm^a]nYV9ih^Rm4pPAdZW^Qp=i?
D8o3F=l5TLJmi31dH7B<RDhqB4J?cH>qm`8O2Y?p<_dCZQjn]V3^JTaGFJ_W;GFQ
Ji08KgE\;]9Zc<Zl4YXkh\TD1AbkjGgIhHU^aFVNC\`4hWK;p7Q0ZgV[gE1L\h=]
K7:OUm98JXTnnW_9VqK\BHTXb[=\G=>L1CQfc6>Veb>P2Y^>c3VH8^7hleOb[S1<
mk76JY?FNSp\IF9fg018kM;<I8=pmV`S6YSpl>1lVbcYVA[BEEZ:1A_5MENRTSnZ
oP;GbQp;KZ0jMTVk9Ck][eXicKqIXjfDOY?d57`Y7^W=MA0EHe8^GS5g\UHp\ZY9
WP;qYI><3@`CXcOaP>i`?AXWA5g<]@ONG:E=AY00beaIHHhd0\:gYF2gPZXGbR5c
mYpl@0POk4c7SBM>^L0eYcp`oDSLa<d4WNOBWf`ABM?<<of^`q1_Ijh=Hq;^[1VL
1pN?TD;WTfIf`7AG61<m?0Z9FVI\P8ejOIRm?9GM:eM6[Ed8f4HbRU3\PWJlE`Gn
lo4k:^9=`Iobo0C7dghUZM8cAQMXF3eAOP<LPWG;YV`<5q>924BE]q6E^nm8Sl1a
[>:OeiqHn>fjg`qgeb2Y=b]Vgd32LM^Dk4<B<gBLEnQjXG`9Aen]b^fPaOI?;<PA
n=<90L[b_k_9W?=;Sj@2CqcJjF>if<SISR<C2iBDCUQh1=5FR16?ZI>npZ[X_`ej
p1VBXk[a_X?6>oX3dFEUZU9G5G`loSFN:b_Q8m:k6Y`5q51ODI5V?RE=e06\<`Bl
7GW\`X[n^Lkei7iF:p6oXHi0?Pj_M5?5?@P[b>=DC_X\K5]onU2fG7P;KXp`Rb4W
c?=]S1Em7g87P1DKEmP`=aT]VP8Co@>@`KER[b^\9YIoM54EVW^V]cAbG_L`VUoi
3`5F=hFbQUP;CYME8KIliN\F0LR`3djGmkm1d\P5:d9L6qhVkaabhqW5IY04geh`
W9MiAdR>XXZ0>o<dH<`2n50<K6SfXQNmo:4Jfqj9US;bA_mEcO?4iUOeqP2MmDZQ
pdPVoT2bN:[mQVl[m>8EETFTf]XFD6`0SF2pKJ\[Fd`0k:0^:QUAnm<ILNj;F4=[
>d]TjEbJ]S3@Ejikp=A?EF3EY=^fZWoKjJO=hGbnHag56;jGmaNnC@BRPDO6@[O6
0i]XS;?bo@NKl1IjH6aXWNdJA6kVIj=:4BaS@`;46GYIiQj7GUW3?S=AjbQpI]=?
KTM^kg3Rm4M[@UBAEO;G@Z:7MVBRq`B_ZVNhZS^SN9Ah^b?h6WOZg:hPT:^Z`acK
1AD5k9RcUiN1;H7:\LOCH25NA;UG@kQXW\mVAUN@a[]X7@NK^1hDU@0;F1;04^i3
`kCYmAS;L`nM<Yh=BAPWlkh>\BO;T6k`qe0[7fB=$
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
`THlhSQH5DT^<WUR6]Zi?\EC<lb\k7\l7Oo@a[eZjmPXRc:Qbc0GT=10;@2maa@=
b22JV7=WDbOq534mU52?Gjn`laILodCKSXYKYKWeaWd3ea?j0G]ZK3W^M]EX^Teq
[6D??JU>8CQda`[=ZSNX?hX\XdA:Q:IA6:cV`=D\^\]@UVMDiTi5J=S<?=>aVYpb
cD_EXpZRInZ2RVA\==a`SN_Hk?]F@h:jYM4SdB4Ge\=I[LJ6Y\qXl0c`Y4qdX9[J
GhMR]D^WY`IkjRm]PC7iI<QhZ?c2`^`qFEU@j9aV=lRb6F0>noMM7haYT[lHUnh@
_gUq2OH@:7@q4f4M\;NnoPTbX@bQnO_R@R2`\[]GLJqk]A5QeKLga0L>Xj0N=ZA=
H5>LYnI95=19aP@hbPBTX]24`B2ASe7:HZkX5^_P1OZIeh0E^dYkSHMg?fAqZ<iY
lJ6M[Kl`h0ijcO<_kK57dFQP4JoJ>5@[WbZXnS8kp^H=;3C0>IWNgKJkBLdANNXN
N?]^gqVXW8[8DejVG8KHE@R^nFn672R`I0eeeqCbiFSFVqY<F3>S`q07CL0L7j<m
`FoESGdDg^[6i4CKdTnTV:pVcdbMBNKN\Z1>ao088RACXa2a`Gd]`6YTP@G\bP?\
H3UFQ_RnK1XRcp@D0OM5<<AS4\NmJ:Z`=UjNm:JmmKd:nphhACGXlpF851\<J`A4
GM4oPggFN12[mI<g6ckd]AhS6jJBqnYW=JEXpGY=1JQLZeYdk8CZ6BkN4T[85l2F
8@gp^[eTZ8Z4aN9foT@TZ49UKj2eUK8WPDpBoeLDA:aiA56j`C8Egh4WCg5Q4Di:
9iZ<?UmdA>M9^;R>NhMHEd1ASa08;RMJN=?STC\>KC`jk^2]?i<qd2a34K7VInaK
AK<Ai:R32FY<5m:Zp9il6A4<<;0B<fB1CECWa]A43Xm4dPTiAckcVI^ehB7Xhn0p
`MZY8OG\PT@BhK;RFK1?LeTb?gj:7QU\p_RDZ?lH0\o_U<^=^haSPEKkF[[9n?3i
75albaDmkpGbEa2mkpEn9>U4B>cdpSKYP]KBQFbg^F;C`n>FE`dg4X\D3A?RB=19
8S]GXNmgSpDc0`ka5G[iU7NIoA=5V\`QWQBDZoZh[q]>a][l35cKi8[16B[fZ\`7
7Y3b]Dp7CWaeD:qeAX\:9Qqoo4@^^HqEjP_V2CamK0BWH`J3dSBE>b8jLG[Y_hV>
Jqk>ZfeGXFA;]1N]:\TM\b1k=k=Pq>m0o3_BpKl8Z?f`Cd;AVb6eC01;=Tb^=G@J
62HAe3Z9qM6DJNEZR38R=Dnb;q[Q[S5;ajNFf`Pl55[gM>:g3jV464Bfb?omi49k
IN<FJ8ae_W@F=kbEmq4\ZJ3;@c1ZnQBUCd=@>QE^h?o]NAN5]\@fkYchMLHB=OY\
gkE0@5Sm:eBfd;K0nDMS8:hQK_RDQClRQVP=kq\LmohZJpX[iQ^lC>:B=In7OLZF
O;]8:BY4D>dM>W?YWB3kY_YnR\l`1hNT_jM:G7<7`GVd`0C@UpJn@KilEPh:jbRQ
]3Hg9FO_f6fYNLidZTWV32T_SadP=VAB8Bk]<hV:AS:jG>TES_>_]XJKpTHNiK^>
AT^Wb=a7>Md2U0H>\i0p4eMi7SDUbRB8EH^1CBdk`NkBO9IVSJVWBIDS??6CURpi
gIlJIijQGQi[K:B\R>ST74nO=Sfk:6nH2bM=>eLIBqHHb0ZVAYV94G=GG<?GqQhV
_[GqjhKbSOfd=NgCoam0>3oDM;G9VXePWOnd6mp`?K56iTcY]bFS_cadj5LhCJ>b
Wj39THLMD0^HVKW:R9Tp<4g\U\_qX[L4ahWqTD8nY4Q`5KCCe2=LU^jf7ZEB<<\n
`L9>Bj<TdQO6]bMQXOX>:6lGG1QHTd14o8:]\57>Zk?oVZA8fXgGIA7Id@gO;]iT
Ql9@`bXQ45\Z76;Jqb=AmncqNOEmm<1qM[FOE?@m9U1gYcEDpg9PJS]gQ7o79ShV
JIaT0W>f<f5aVlI\9<QQ?b`pbead:JDQg]2A_8pR\?RMW_l0?JGe?eb=6f6OF5Tg
J=`[PBpQmMaL;n>ifONk6FYHi6C3^DSf[[pLQN\Z8Ql0>0i\4`iIS0o_AhQa7Ebg
_meqJe\Kk^HpEi@[1<<e5n]IWin7YIXHkjhSXYaaHTMVRVQ_PL=KUj:`NHY]kHcp
?I;eignpgf:Q[nkGSU796bQXNbgV`R]5=2Sh\fTL067RbUkmX<h2q4AAUSmopfne
OP>a[LbhF[c6kT2l>kjjA42VnL=9Mg5>gqObm2]b@pHYWfh>VRULOOEm4c@ih=Vh
d]K1YU151Cp2JgV8bJdI_1a7dG_T880Y@_SOQUPedhZ:aacDNhamAYRB3Ya:?2@2
KXb4KfdZJSlZY0jCf441=];ROZDqLA?loZn<?UDb4gPf[m;KdoO>S;O_o9TO`2m:
FJWC_aDG2_N:>M;E\Ne7=?pQ:d]DanqO@9Pel4L\OCQOH=UgG^nCc0Uq[LZ@e?Kq
J8H9aUT[KCH0=]7<4Z8[1W<V:KaoD\[8W@Fk1Y_q0;P?GZRqN7RQ;BpUoJGj3=3T
1<`Z9m@TUALm:S8XGC4M`WahVgS8jpSjgo[R14cW5UZ3=>AZN6TO;ADX6g6E0gbW
[KA8a3@Ymf87o\2CgPnnZ;87f128m@:>JbQ[e@`V<RfK_DpTh0S>mSq^?PaV;?KR
_\KNLcK0aNnF[24=:q7o;@14XRIW74S[2pf_:kGHb^=KP>L;8D<Je23>Bcm5Bh6X
9H=U`b<@k4A_ITiAJQpmZf?8g\Zp\mZ^4;djm<2`gLkI_3]NNKCWBO?NHl4IAkqm
P:\T3hnpm`f_PBVM9c_Q2[>W6N:nbS\\P]pXM1@@H1pG]f[6cFXK@1kO=_IGfjo=
`9MVeI@0dU\g9R?GWPb9PNfG551?kGPjnhHkdMP@jlCGK=q`Q1@dO1pbVaNi2k[\
Z]48=h2qoDKfP`UkdBJ]h9G4K4V^JN6l66o>^TZ76o6i:j<9@_1plOnc3LW$
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
jXL=gSQV5DT^<jfMKmNdX]oE>UlQRo=9qek7IThbTSU8Rn^<;UQAf12AC?^^1_di
?6;b@1=2:XEXF]RZD5M?3qLT?jYg2n=[Yf:?5H5YQ>Pn@:3A;N57qS7\=kRq\I;<
CZCXfXX[LWnNfBbq?h[aNhR>J:N@7@_PP?q25>mHjV[WWKj=`JiCnGVn5_hqG1d2
HP<Y6CC6T[kjo^OZ>lp`0DWINk@>3d>;c<1X67?NEffql8o7=R[p2e@UmUe0gHa<
VCW96A9Ko3NNFQ`BGI?A3[b:e8>p`S5IQab2K<Ap_dR@cXKpIGAncd_pXjj\5KXq
:e=l96npJ\g8KWJXChg:OmW8Vcap]Gk4oJ7gm40HK1]do<0Aq4X7Bii2fmG41RN=
A`MPM[B\D8mQ:W8mkh]CfLgegIRNgK@BlMR]:?PpHj>=?YoDFkq9;QXcadjeD`^D
X6B:i@HCX0Z^gKCaE;BT=4;qh=AAHEbQ<@]7U6^fYR99?o2h35PVoC\OCSJZf:kL
J>CSoU0>2=3Gd7Eoke9RJWk^5]2E;CnjaJKn2_^L47j;@22l?jYa;iq16_TBg6qE
CX6e@kq[lI3d=D_S\a_TY9fEoV2qoebU?`RIda?BY<;oQgnXgj9LRY4S<S`@>>qP
1\:YfCd^\V>h8\A8Xo_mh1RY6adKReaGcD>PBGi<Y\@FUeBScXCL_XM5cf1_EohV
PG1W9K]qBP\G3AfI9HNLk4m1ekU7Vo@7A7L<TK<A?NPka5q>Fm=VUhqIAI\He[dn
DQJ^696akPAegG87Ypi_NjSFaHf4RG5aF?3_\g`n\n=h7]ERlmh_[nEA85S<X:[g
3PNcHok_AFPJ;B;7g[E3fZp@RXPn1P>=5RXTJ3X3^d7<hU@]8Z]EkZcMH2ZbP4]8
k1[8kAn8MdF3fN5>\0Q8_NN\o4A2[^M?Je;>gl>mE^1qS8W`19lqEkljC[PB57b9
neP9F`V4O\P[oSEh14Ze5?JO724q<SC^<OQea6;EQ8^Sfo>\ocGMBVE6FPep\<ag
eIHqGd96Kc@q[E3KUlF@EHHnTb1EbXN\KEa<VHFkLa]^DWiM94S3hHo<\98jpgE`
G35fIMWpo\e@Ya4W9OMYV_EDUec[ZaFKTakTZge86P9Rm@2dSZCMjG6k[`;l04G_
:U`dM>A]^mo5\2>WRAJ^^oJlh5OM?iFR\GOb<1qJD18E_QpRaMSG::=f;7n3iVJC
>JMU=<CFN4]FcDa4kRXS:OU_n@I;=];L<a29jb8EDin<No9EadWS=pY\aL1`>p4F
g@Y_6pmAmdAe[Z?Ah^MkTL]47_Z5mpFg5XfLD62]b=Q8]Ak7eL@Se]P41WQ4WO;I
bTfQe`F3AOmo4fN>ZL`L^Y[:ZmjTDkUaf\Jkd4C]gAQiLVDRT2iC:BKGJR4oBB0Y
6?ZnJ_]4Z6g>qj61=Q3Xp^dm^bZoKk^=I_O1iSLa:HVo7<PbUk_BK3jpRWkIL>Cp
eGMl5ZF32n4olNg1J8LkJB75YSk<6g=hJioGk8J6R:q<9=WM69_kR[S<97;=VIaW
MW49>TbGVFOm[WNgK5\D5MEXIUjco65;UKWeHfeNe>jZ<djgn@=kJodRcpTBinZf
;qfXGi:SD6V]YATJnm>f[KCa]FiM1E<ik@lZLkRJqHghAhY[qbH@WOATp7<[>V?D
qBoQ`oUMl<ZQn?amnZ=d1hKBO@>N:[f\`c:H:PG<19LQ9S>BEPCAf]12BNe:>e;P
<3m:m]?CRikYI[nHAjC[19Cq`DQmOEApfo29PTKNS2XeTeKMO@k3T7SK`\X1L8C0
<0lphTG<DD1^LYDFK<k2pUZHGgYTqPclmC^aqH4@[mI6;NGCga@bBXY\4A4qCClD
@M`C@fTnHconcWQPLT^hZZN?p\TlAC6oqdC<SQGd0Pl8gHNV;6>:hiY`W70Ek1aP
nVMRp3_Q44BAYT<4bKQ3LjSXMjU;BoYAMge\\HabENGfkGi=9`4<R]8Z\T9<V:Kq
m1dC?KcIhF=dj8io59BOXlEdNE5POG^de`JUYO4VT?9L_7ZdKd9OnImW3]>6k\Nb
Ud;WL<\J>_0qj5IfGi33Ch0[9D1ga5g=i>Z@^5SGYDlf00[kUUA:i\YkCGPR0Dp6
i59X3WZg^7YI=0ZCM3fiiem<2=iD0IXqlXdmlJ_pL5AL^f?2Wm8`hElWqYegSTN;
p]M2mIo8QU_gdR2aC91mhQfHndb5XaGR9]S=pUANL9hQU7_lGkO0fX38b8iJM>^G
Up\hZ7<Xe=64=<gK2;S69qTI?H2X:6j9>]_o1O0`8eO?WP4[lB]l]]QeXhm7\?Ia
ck24NRT[>KEa1J0iAVNgVbTgogIIJ6^G\i<MZN;>elfmM26VHg2Ep6l1`O2`Vkdj
R[VgIa@7f?26G<45T4ZNFnNJB5kTP_GE2aT_SaalKU]QmX\DiXAj4K_:lQDW``1>
`=V93=7qTN2MYhY4dUN^Y8=k3R@nn14mUVj0?QkgQ:ANo<kZRBEDXO_nUZA]E52O
\6PbS:bU;Yp0QKcMmISnnP>oG?\=`>D<`IaDK6V^jjmFa>E\d[>mKBDXbPZCEhPT
84qH83M9iZOL3Le`CgC;mU\IadTibHDA^p>=J^fFOaiVSRiaPQ?P=DG@1gg\fOV4
pf_9WdgTqMh3dmI>o7gCKFc]jZ?qN]hAMD2<;VhKdBT]MdCK7`8h?1l86m@McK4?
WYUk;=Af6P:]q\?I;\j4pgVL55BZb7WgL_\c=Xk63^B84gAAnQWDLIlWpJh6D^EW
k]9PmNniUT[h9;>JB`<X;o2=`I[kPGb1[LSf1XZH]9iVif;I?BH>]:@aUkB62l9c
B_=Iqd=Ve]foYVXQ^IE2R;iK;lWZNfkoTEM<KhFi^W;j6O?8SaIEk0Wn9kkJ57mq
Zi:c`_DEdeN?g^PV60]jfOH2aa:_UkR@mO[36Y2n6Y6D5=3=`RoQ<=jh6_l1_O>Z
ch7aod\e4>7aB0]c46K8Ujgp<G14bP9X5<[1nNI`iG<IE67LU9Rn895pdV\a?>lq
cXWE6LcKTMmOeB`DI^Y73VMlC3J>jGBnf67qX11ocU[kZ]QbThe^PZBpYJJfTRgp
B[gdV\473fHYF6LN8g2ZJnO3_TKl`ZKkOT5pF;iDlN]dJCAgVhX4l14fNT^dQe8J
PK`2M]EOlW=>178j4EeICA`@c<qD3g064Uiee33O@K<Y@N[_?[;j^Qljo6OZdea\
6cJBhJD^aU6a<]Inna7g<n;ReAhMk9`>cDX`DB1>2SpXk:4^FZ<6G6nSM_lIW1>g
XoHMWGD6P5FUi96bICPl?lMSMK0C7qO81ZJLQm@?`TdA=Y:n54bhicnb15VDFW2[
5G<H_<3Mn60N0PSS5jeD`^1HA[;RNY\W=^k;2;Q@<\V>aJ68YpGL\X>DEhX7AhQI
Qdq8@?E^kLm?PBW9UDV9[f3Mo:?<4:\LBgqJ3?Sbam=C[MQ]F<n?jdI6;5G1N`Am
aHCm\<RbJD\5@k9=mP@>bZ0pQR7IJgjDCWQ:1UcjmTX2V>jc7TSm^k3pN5Zgnm<q
82DJgN5oo@7^Jmb9D7O@fX0[1aSc?4cB]beqBAT4:43p6Ymm5I1T`dIgR5gDH7A=
HFN<dAWcP573GTlp?Y]NEnl`=fMMQbfH1F\bXB8NOk=:9@KdiHL0lL>Z18mnVdBV
hA[ke1E`Di32R\Vp_@_a2X0O[NZYe\HaC;BgCRKc2a`lCaQ4eUQWaaG:@P\93EL@
<T6CbeqNEgh^]2@NT7\7o4mRa;MMLFb@oTTSQe1X^L[\9O4Cc`BmRTb93;WjFU0B
Ki=NN;H7:K8j_k9Hk9ZoP5qO>JdPWO2ZZXEXQNSPNEK`W2Dc>L8EMZJ^Ek[;g<j4
\>_2Ci39\K`OXVVClPm1O4QjHCI@A>UQgo<UFDPimAp7GU>XE2AoW3oBdGJpDa0S
B_FVa8kUSVAN`52A>eZeaD<mPjOqX<A8@XHl81MnPV9kM<7^:gVZFhMqU;BN<6Vk
2P>0bkLT;PZ3@ABWHkjHbn\q[``7@B4p1;cCP4^W;8]LFQ6Q=AlVJhDG@_fS_;gc
p1_?7I6Kp0^L=FY<jf06;WYXiT9VMI8TZi@IXO7PUeMEpTVX1fEJN^C4NHQjVGQq
7:iKSQ9S>A@hC1Z;G8lgo^ZFWfBm>8RDSF>m\@0JHDmfAeKJOiL7Ooa\i`dmhC^[
=adKpFb8<HjN8od4dPQ=T4QiS\`i\Z0S0hJLPT8j;5_hPNiBIOBH46MD?Bgq\fe\
863bfW@6P0<1T9E`l0eZdTHV5Uc4D=1Vg`SG0c`>[^XH7jSKG9h4RDgonFb>7m@\
hJC[lJ`F1<1@@So\lPSeBM36j7T^\_3pDaZfc[AF3n5jk00W@]DeFdQ=PbiBN6Uj
m`JK=jj[_a7e]_Ee:W6CJL]Z<hOZE`@?Tfn<PiG\`eRJbE7dI`pSUBnQcO49ce:T
@LNL[XcHUXUZbJ1JlqnF?SU23E^chAVB7YHD4J]KXml_d:ZbI1Zc[nkOhjZjZhAn
_aJ3k3E4GhQ9pG2MILo7pZ:47FCXTTaLV74e_k?Z]5D]HRZ;`UG3_pH8UnVH`q;G
2:dZNZcQnfB<1S=[OD7A=E2GGEjKQ62ReqJ8P4ETBXFng7^@]WCYN=d6>9OMU]LO
HXbci35>5Y0I;?1=hOSARWMip0m2^^AeAgVccU0@T4PjmKZR8iSHICZd50>1hXo3
oZ9acJgOMZ8?HZM>SdO<\iP;[0@1nePW@lb[`nYXqClS<X1[dMgjH:B9CgTD5W2Y
5=WDN49:^e\<7Q2E7l9?c<[IdcXCb]S`[Y@]G4[HgJ1`C0_eoP7km]4f@i2qgCV:
Dg245g6RbUhpEKGIUZmYYjYOof518OnFV[HTVF72nQS:W55`c=Y`=6Wp2@Xf\Z];
`I>:IJ1NQFM7VVGo27XKLCp^OL_K;7pk[DHEHPdUbP][e@38`a?88Cn`II<q22j;
D1_oG8EM_gEhmO4PFAJoE]<;X:>Se7EI>R@Iodf896RR7kmokoGp2kL@m6oMB@TO
B:ghdBO4PRGhNTA;Y4p;e34^BaqL^eo0fHK?gj8A`omqE7fg24Rp7>H[H_XdC]gU
NYH0^6C6E2WliB=pPoOEa>hpBF\g3OSO2b8;bXJ6PGl1fIUa2C?C]g]Xgbaqj?6h
MN4:lA0=3:A`7WS=OXMKYaWbg=hmW0ojPAnndd=n>;OlNWlW[iViaTql0\CWWBKl
66@:nDUehQ0f:JLW2]5`7qGKOgbjDolCM2:S?W@lm40Zo>_LVC]j9l;HT9>NGR=0
R6PmNLQYTAIh;`U8QI`ZKf8__?SPESZ37`fN?JeBq2>HWO6[p?nfkAZ6=hJ[n8S`
`c1FD:T<]k9FY96qm^c>NQ?qDi=I5aCT;J2F?ce\kSYp<U47jWKm6Doi[3\lkJ=k
ZaDm3=Pn\T^gPH;q^>Hdg5@Wl`;d[iEZf_D_22DnJok]95?j<7`F=Do1oUjh@bln
=cX0McpNjPXV?od@L:RmTAAOf7S4UUj_99ql[HTZm=>MkQ:ngNE0\QlDk\3JlV4Z
aU7iW7_=kOGdT0dQiUC:Q><jT`nQcNkqb8Wj_2Fi>DJK3]637_jG[UgnESLI]>[g
R[GTHdPbfZb>Y=`9VTM^1jig42CY]M]M0CKbbcU`aD7aCbqn__ZY127LanOEBCT6
fZdT3UaBkoh@=GX7HR_nmAIXalc]Ipn_LFa<;E:GBK27G@RAW>`VZPmc7aA^:Co8
d<o^GB:ERQjW^D9NS;9V<OB41@Zj]V40YX3OLa23@?OWVH=Ud5BFQ=b>@bpn;Z9o
K_n9kbn6lZQ9Q]:km1HQTBZLfQNjIh;F^21@IoEIAgg>PfTqLS89Nn:pMZU;\lLn
75AB[CD@RXK9i\3NCEFO502ha32M9No1Y49Uofl?<1\TX`piol?_dqZD=Semp<`C
gBjfph_e7]b\L=7k[V<8Cl_f:o=]V:[dc[ndc93CobYh8F\U39RA9V>hdLc0p^<A
TGUa]@DeJXXD]YIDXI063<m0gqV6O@0WTeG]9nBPogh68_BAgbpb0Ml:FdIL;a1K
M^8=3X1>YPb5[qDWaRI=6q75O;>gY>cZjN^?[`T0m:J47BfBVAV9[jWR>d^gLkdE
FoOLQ6;j95C`>qGl8Io7DE>Ui_PcW;DET\16F=SKgcg=2POnVWeLR0dRSiV`0CV>
eTSnqSNi?Xh5qnnllBV;ciJcP=Z=WCKSN0GXDT9[coOHl@LGHS9K;JL=hpAJ<5eD
4Mo[B60VWe@m24FUd@YF6GqH7:[R2^q\iU_nc0p8RTnj8li84X0A\c94c:32RQgA
^R^p_o9ge?2pEL2jcm8qPP8WncZUWLCf<PK9o>FaT;_MKK9;Lk9qJ;N0QP^M@N?<
?V17P4bDgGHnTAVqiHSM@V]X^H]fY0Vmh;Oe8C6<Lk:153bnB_T1AN0IWAh5U>\\
46c06KP@M4jfU=qQ]d=U3WF3RB^=OaUV\JV@[DjPVYAI5>bqMWg7[[;jJKWJP<M]
O3EfkU\@=iFi[PpgMCE0=>3UlRGIC:EOji;Wd@]BKEE6U9895MEeL1T\9Shcaa>_
ATAeWDQMA]T4b8Z0\6S^N]:5Wp:N7Mme4PQh96RW?_hWmdXP7J2@m:LFccQ?Q6RS
BlUfnVj8TaIBpDh5?8d4qY3Rk6n:q:cfR^ZcpA4P65;S@0g?;TG[_e:`6PmpDXWJ
2c53e2lYR^^GC3Nk]6q;4h\0McCRG3dhaM\RP86pbe>RFcO7hX2GGfm;i`^U7W=T
BN<@U\O:cEVVT>f2dKY>QcqREbMEI^OW8UOPE[Q7\7\obcUUFXh882jWE1_fa=Pp
fRWmA2;q8FPcF>^f@0ZGDm6oYK;X8J68TdK[[1EhP>mX;K5lj]LT4j10idTHNlF`
FTM[iVno;O`8Z=75WOcKZ^cUXL`Q>XVlm?kCS[hj3NE4WX7Wd:2jpFhC\:8UGW4n
C]FY48PYpS4J>:b<phKQo8R<e]H7XSYP_<>k6OZ@gN_J>GY8Ap<=og@D8fGGeao6
>@MLRj:\1SWb<QLmXO_4B4QdKW[dH32_ViXl@7:5O;b:>1H73:PZg?\ZZgq1GH8K
7AiT:2VW[MVpI]c^H\[p6nYSmClq5\2fP^C47HWAhE<F^e8a4VRN63PiH>@KYYbR
@YPmMjZa8Xd?eJKjG_?9b<3O]mbcEKaPeU_;kR?46QoHjSqc`FMcCZ\l56^Q=E[?
08pn5h_@m;qPIi1:j]hA;0kT8RoenWWMYNXnIg2Qn7e223OGPg6?aU;NQ>pAaQd8
AJ0?iV>[7IR0ETkZF5fB4LJ]2qJY4S2XjqJfio2M[JP>\U6B9CpokRPXkDqkSH\C
IlRg`:>0RVV?i<?JYF90`>mqc;KOZ04E1DjgVND3j>A?peFb@ig]hSoF[N:3eM7p
RR9^[ed;CS^Z>Tc82<:pN]PQjl_WhfHaDXNGBi<YqbiPkO0Le<\mYB63bdUSWKWO
Zl^0SGXHI3Gjd1\`M=RL?8o7CqF\JWcZGp;B9h@=R8KGhi5DGgZO\d33c7KS^Lqe
Knf0laWa:^6W8hn>0bbqd6lbbaHVM@DNCg_jo04q0_]e767dhXS=:6=@7aV3p:If
eU3MeNIB:AjdUHSgNRW2@IOn948Y3hoXT^EEb^\JV_?K8q40^^Q6cp1<?P<Ga^7j
24E=QV_\Aiq?J`16?SL7O?;Vmnc24PpHZLeiXO^b9hojic<kmNEp^03S8V_m?Vnf
F8JlYdXbC`?_4JF?\`@on3Ti9U>^2f7;Bbh0q7IV^e3AMj\f]lLBPV;>mV0LlEOY
q3P<]9J6qV5ZgD@`jDVNRAbQmCJ0HpPd<@2cG]loh?X0YU6F^pSTU@MffZ=[XVj;
?T9UKOp6:H7K^?H6E?Chf31iQA?7dlCi31H8]Wc<=`P7Wdb<7;LIO<Bp`ng_ETJq
[m[UoDoFQX\;3g\cfT2hqcO=AaJ4PZRh92ZZ3k>Df21pg0SJUZ=IEgLTMbn5<Y`g
gA`WbBgApn=6T:TO4Skan8d:S>h:j=aE`0Xi\N2p::g9FNn:\7T[KmN;>b;GafHD
]g]hgN@>SnSkT`P5h0@F:R[Y22GK:Cnb`1b84B>NE0p`ci2BnLpD=HA=QRQLJO5K
PhMpiF;D@\mI5NcTX@KeXWo5ZX\:Jh]G_`GM5YeSc:2XfC=ZBoZUHiVMlF^Um3M_
o_HJ0gpK2kbJAh$
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
LQKC9SQd5DT^<ila:6bhZ@>dlOZWC7K=JbJeOkGUB7Sj<lV[X6p86mj:7Z=1GLlW
^[q<eTiSm0^_^>jHhA2=<9<GVa;a_BlD8NCNfU4:ZVC4]3`@7?=i_Hlgi`C]bLp2
NOmEnqi8M<AbOo4aeF`gV_6e0Gq=QHL?Z4klcG:9jKeMn6<io7fqKe>KBQUkl>am
dk=a8KDRqT86NahhKY^CM\e8nO9dG]=AKn5Rf>S60cmpbZo8j]OLdcc>aLHqObEC
EdOa0^J<Z7]966EaMMGlILj^2I_K?^4;fIM]>Gd]UJ4?A[2Z]AZQpDY09^JBplY2
jRE[>aTB4aUNDlec;oAafU?@AL`X>1aW6QlE:W0P0f7R:F2EVXNbdU;II15gd^gQ
E61=@iV0HpbI2NbjYLQ>GD`Ib<ES^=g>aqZB065SQqBS5VUDXgbg[P18:nYRfSXn
m22?bQNRd6P5:?qZ4CM94gX;mSJh3KK6bM>N?Ddd__e<\[q4Zd`Mo1X?\@^H0Q6Q
hH4^bamEWAL^;B4g2W<1f@koK1pC89f7O\=Bh\co;mf[YBG:Lh:0e=CXAJ1SLDaq
VV<cEgp3ho2\PQUCk[U`[e5D`M2KI:DE<4g_C2hY4T1nT=m`N_9;_ZQGLko4KGS`
k=QiiIH1IFb[ZkdlIdcleI`ldk_[LKq5U?]hfV2^?ChAYCgeejJ5IGCO1SdYTDZZ
<_;LgiRN]hM@_h;OVj;ZnmMb83?;Sh4Q;U_oLSKFRI[M[W0i[2pM3_cE_6T2o5T3
9n9kUg0E0cF36T\LCPIo>?_el]iZ^Og6=N?67i>Ri8TL_D_G7^gn<2G?2@aH^o>B
5e84ZWq[KG[:6R<m0FBDL2p_Ea9?HlDLWJmJR^hZl[T4ZhE[9ALW9>14danjO;;n
O[XE0J^ZBEh37SRWDlKM0KQ_5c0A2iDbA\QPOJR<OqH;J<N9TpaS>KLj2QPVhG73
oMJdJnW<bndiKjaNLbl0m>Sn_XNYGo?0U1QSZX^lST[W7\2d=ZC[dQTm^S523q^T
f=PlQjcJ<DKGYBcPBoIU<qQ[c:E@^cISdWA1EcXQAdf6Bc`=SGn==6;>oUpJ:XlO
O:pOb6;d9pPdR3oM3Va8]n06h_^QngfaB@3Geje:9Tk=LEJf8Dm]JAiD?GmV0GLH
:ZP4I3jWg4PmR3dWRn:V6=30GSjY;=c[2Hp?CEdSQH`82\8D>fVhM3iDDIMmaA[K
@<kT65@QM3BZifU<?TUohZ\NV^iNeYS=d6j?eEdk<H;Hm=RX4UH8Oe5q:]oej?k<
FXCH0`R];>gEEddmTC`XM6[1k:QIBHH>51VoJ_6J:ifL^klff>h9mb?l:0oJJ0Z?
;JFNAO8Q`^b`qA:<Vm`CmFSCUdn8U;bf=BHE?;AZAEV_WaT`VVP\_LKWHj7oRPOB
HV5TWD[CQ4]5m=B@MgO4;31]dBBWWGVJqLo9_aE^q8k_:26X@B]WMV6bc9LNIB_D
ggMDo8OTW8`=f3EKYm2Ckjd63Y\RWE;LYN9SL[omOMGD9AmF_[dLpPECl96Uoe`V
X^`T6PORlRV=piW>>ES]Og7PVBlmKJ_h0XXKc[=HYk4d^g^X`E`6^]MFN@K=3UOf
>V6J7GVfRn05hG]8FpoMFZTO?pSKegX_CQ=RXj<CKg_bVOo<YEYBNOfD?je71`m:
EjpJT_nAm\q@M4FfVl5nO6TWZ7HeiPE[mobe6j_kE=d^nMm]M^EC5UbkhjK@60CO
H[Y081D8K;9@LC3XAEKa@W\4WKK_ej2R05QEQ_ObTQnIQceg?bDQCM\=l?FinqdD
AIUhPp2BZQ9Q8p[QXAK?NpnhB?CBh\;Agcd0aE[ALNV\3GO2_7o2aoY\TB5:UiqA
0KWICQ8HEIL?ZGR7m7dWc958cS\eT3OiT<]^WDH]FXFmEM>\4km:GiT:@ADlmg<T
G?bPB6=LV9]Yd3mq3JgVo2kZLl2HO3=<A;QLiHYdmVn2L:bIdHYC\5a>BD5P1H>p
dl@e@9mpE=KDBSpama8YZ=6KMLkMgF\o:heqZ<E^57EC?h1O5k?46AaN\n`be67M
RDH9Zn4X6XIYM?kqEJIbA0C;CCN]g3>caaP>bcli=Lf`X]4a1aEA_Q=]Q6cqkUkF
`@M6=@NET1BMUWGk`oY;VX8];d:E>g`f7HMSG=:pE==CS?QMGTRd0fRGLiPTm8T]
IA72iX:D<a<]O;o4fKAk?RaeVCElhgV461D;MWq>aXj4mnfRb\PRaRgY9N<]Z<_n
m:=YK3nX4RLOZbDD`3pkGPkFHLqY?0lSd57=6:Y<ZWWWWk>7oV1;k6FOOVMRcg[k
<WLV9G>Y:NZ8ccXZdoe_@3Ap48D?_nB^alAM:?MjB=]a`<YU;:IV[PAl:6A;O^c?
^Gq012O4BkqY5I_XjpWZQ9=0Ud?;[aRd^5RK:npmWgMbVfL:cdfJ03k@UK4_6g\<
k6hiX?WoAF>jFjDP7fqnXB]j3;Z3<`1HNE5bWK9_TcJ1UgV4Y>]YmZ7c2_IjaSqX
>YPV`MdMdZOnOnXS8\G[gHNmm]g4[MMiRjdLk2Yhf=qQ]1je9Fl6@EhTU?8f4i9o
goFY5k2ZHbC@fUhAo6ngY=pSF7nT?np8ml:^EE;;:1TYZ;Jmf^4N;S`W5aKYhiap
kOCU3l=?3<[0H7k7U;6U;fcQWm7=^L>O@<PMbU8P03AG1@\9<R_F<0DKSTHAp3g@
`TY7qH12bN:><Y77WLGG<Tkq\_?GQNOcNgG]HL?U>Q_EgHk@p:8WeZSDeg]hVF7@
58<cUqG30`eIiEnCCb_KQFGO[IMdoOk39>[SBZ;np@5Ch2Cg<<UckF485VQQBGL4
;hj3Bh?84gaG8@E?W[hR^VEDkLZdAVST<pf2?e1F>p4[EK<[nmGA7WD2H[UFijdN
^@@37?kB<eT2J4QO_RDFfF_j\X^PC8UldYY`2BWc\aSOnOpV3NY2mON[i_JGETTh
0g4;@3Nich6iljdVb`]Jg]2ac]ZDBK7\2897^4ID`GXNIHEG5>MOm9?T?V;pSkTn
_Na?VJjdQ=ke;OSBcZ`dq<a0H]f]q]3L[KB9R6F\GHaW1i3a\2EZ`5oG3QVOo4=I
IL=F>lQe_ACioih[LNWO1?ffN`dfL2EHhU\bqb1RD:TVS?Z2aVga8X]lipdkYhbM
\^:=?nPWN[>HmVQ\b0GNeej4M3kUgmiN_GEUc7\SYE9X`9fanmMkOd?EcIbVM1C8
9>pHjNDZ5b3p=RAQ<a=?1ETO:TE]n?]9W5\Z86oh>gFXK0:;?`Hq?P\BP6n]T2GG
mU<NADLjp1]hYkTHid<@ZK@8MW?8ZTmI7e7l8`:<aV^?:AWKW:395fQ2TV2][;em
gNSKU@3n\0HqnkF=nMZUqS8RNZkY\3_dW7fi6Non]^l<_e@>p5n`O=9lGY5J@G2Z
\eTBJ1h9_Tm`AeA74]oZNnDlW^jf0bQ3AU0LWS7b4Xco4BWKFfSU_qLa<<U^ERGS
?0TNVO6bYd:Tj[g;4`T5b5<dMo`KGYVde^CoZ`5ghU1[gS9=YGbBgd\JpbBmhWb_
`p?Fj2g2cfDM:2dJ1@AdWNP=SQ15Wgi0UGPoPK39q4N6]j=l9p1gbR^hi2pJ7M5G
fo]oD:SdJ2dBOWXnG<bF@CaD03@h@07PG]a3oB3GUYfRkENjC:lcYG^p97L=gHK=
pXXN7hIkXEA^I9?<[^oKQnc2VF?Df5aBqH7VSEC_TX0A_]SZWPJld1752Z5;Jm4F
XQf[NUO\FDj<pl?6`AS_X==Mh1YA?i>o2fbQBLRBgQ3f2odJOA^:IZe3TEbKiaU1
J`J73qdV6XHI7C4oX??hk<fVJcVb^0`d\PB^fIh?Dcp6l35^WqOM<TFU2V;@55^Z
R[08oD\F\BlMXdP2Eo\nI6<XW<Th`lMDLkS]F^bK_EIRoM]4ThO6BWdlS\7e8;`F
bZ>3XI\<l:8nq<:KcCofGdb8gXP1IboX2LTmf_5C]DonAIQeBHDF6cCCnI63f36?
JD:D:d^IVa=Dfdm^PS2TUCMS_;V<M7H6[U=pWC@`Ml`g5iLoj47[Og>:eY_c[Y>E
8DE]:Dm=fF;@i9IhAK8me7LG@BoVYfV7@FQ`2FMUfS\>aRaBS1J0gX[7D?qC[T^7
\8On``jQnHnU2ljAK5hTH9NH@?X3G_dI?1<Tf<i22BlOBm1b^NELJAnSSJMCcZ9c
WVYg0jeCFT_I5fep1ac5C>3qPS]Jba6Hk\XWT_>XCiR\`obDbDi?QX22ONgRV=Y[
Y1Ch1cIC_hBFV?B;3m\^CJ2HajNVCREOAG=IpNTPFVd8m]Z_FmMJEd<E7aBQ4pf>
F[M1T<SB?S;b3fCiaC;5F5hW:_ETFo:FOPg_jUf79R6\h^k:DW2g:flS6qoV;mFX
Cp6VKYi2_MSj<PRLLS<IW1jo?o3VMl73hjHT2f7l^=X46J$
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
78c:bSQ:5DT^<Hi:IE<PiaR0;9OWljCZ2Qg6O^g^=l4W:^WamR12Qm9:\NOnJKWG
Y0Aq?jU0gURMSNYL[^Q^]n:]OFX@ERY<W?I2R[cL]US<O=4D5h?aCjYXZ4?GqDg<
f`@Ji4n8nE4P82NWf74NgLLBl9I=Pib\9jc=4PQU\cQMg2\[9i;^AenXqoi[gYmp
`7:GVEkdf9cO98R`RJU@ZmYg6KkpKGI<k6\qi;4W2aDc[hmk7C18a4ZoPi8`2^p0
Ye`S^OMTL0gS=gOZNQEX;YZF7HWpM>n`inAqFbd1a9L4e@l=0LMnb@iYkSMaWOhG
?dqkoj1@9apEKGc56\fm0QLS;=3o@BHTFl^77Cqm?IbTVTg:XBbhZdWJ4:6^hocT
kcD=UYXC3n>bXCL<]]Z\NJ;o^aiqKBMh<DCZ\ZhlSFJK3Fm?WIp6meki<[dAh=4E
iOEb_hPK05lBh\^ln5oYogN0L[6[K:YLmW2gNl6``goqWnF8Lm=p6o0=DAHTUdNg
J[P>i1ZSUl5V20EG0:je[U1Z9:2Ob?>W;GHikOH3i?;E_IaC]V<:;1QlHcL`4c<G
_FIihR4F]oaqk<bnZ<`2egX5^[AL[GRdq?ZR5MkCpe\5iZcVX_Q<CNc5ehhj<:XZ
`S?X?[QfQiPLhqR9>[[d4@Y^UY@F`8gC^m38iJUTHf6E@QFg]qT`0_Y<X2lNnVoB
Dao0hk@kQF[c4D>U4=9B=E9]eeaQPU7MI3ak4OMQR30hIGE;V@?<NK]a@Ag`63_W
goTbSDeY=qWC0jPnjGSmBLlMPAgA:gqWhL8\4Tq`OEX804g?b_HC]01Y`0Eb]fA0
A>fP`TS?]bp_5^k8Nc:`A^pX?m<8T1ehMAOMI]26lQ=lHQ47TFLBAm6jkIEkYB@2
\JBUk[QNL4JJ<eP6^0j7jSG7FY>N4kHq?YF3PFKqFO18RSM@RBYGACOX22a=4MK3
qI_>meb8o<jj3nmWn[2<UVkNAhKJBK8W`8EjgGkV0lTF5`PFq43SZ^4hp]?eZGS9
[HMJkMYaA]hiF]WDA@K`qgG0>^d3EW>:\<ZiX@5HGkbpe;c<_Dck5eNMIgDBK@Y>
OVAZNk_9P4WoIY=p7o@clidl]9ZeRfNk9m;E;PbOOXLUK5Jd\gipIXbJ[W2a?i=q
N:R0`KJK9ZF8H@Q1p0dW\\`j`EFf4NFk46a=`]iBW3V0>H^9]Y>:ea[XG59q=b`d
OmB_G]dhZSDV38TDOgg?W[^cjR?OeQVOW7qk5K\0McMKh^5Sf9T0iP7?CdFV7O:Z
;Y>4Y;d_:nf0PNJXYUaB`;T1I@FYiS\ecY^14JL@h^=2ege5FSlOY20XSA__96pD
7lTmoXW`1X1BDCL<2T9Sa2GO_B5FVT@LON2o2_`qUbgTYo2OoQLHRGhWMlYF\<NH
8ij?M=d>:3Gi<?HV9@mH_fkn[8BN?Q9O[SLVLMBQl2lYm`NFSnX2BWXX>DEXd\F_
`\Hq<HHFBhZq=minaK69L`AlQBeNLIjG5@U2nV_=qE;A:?GbpNm7Ln?F=igIVQT=
:H6qeXG`CgK[TXa3Rho8WDIdnVA2:7F_aHX\>=q9@FVmUfmGRW\?7jQ92im>iTkQ
GP\7FLNHibmdE=6`=GmO1T2;YTcDg7k:`akiMb<1SE=AHjJ`bjG[W27Nk9Z<QQTI
:RSg>cK811AUaap_jb<dOcg]@;KDBe79E@pkH>`fWMPNK][Y=aP4X\G2d^jAH4?n
3KSU:>EqlZEDZ`aVMd0aRbY06Y<:8U65[[FMCNfIm^gj7mW=?GMW1X;\HU9RTc6G
LfHD^@Ci:TA9_GVCnS@O?08mO?i6b3o9YLnh>V[04e8C;N@p]7\Z1a3<KgPVi3:E
>laOYk7@kY<]lofYBP9NqKmDPNFDF?n=lne6ZhJa9Ue\5I=G[WAbb2Hna<DbJSDP
4hYNnQPCTJ7pnUiUoQ<OCGZdKd6LA_J7hm6EFA5aJSb;Jj6<9@<JHcGfE3fe9Fgf
`:K3NAegG>Li`SFZ6RLn;<^hcHT@o4c?4jo[ebXeS?RJ;Go;nJdqEb<`3``pml^N
ZCbq>jAJ<Bfm7_Elc@_[X=@Hfa]8W@k?oX`C4DB2?=SKo3H4S:[LPhO6niAaEcW<
`S3eRXn^?;MG<@XD6L0eaZipnYVb`X[qTTm^YT\nRVYf]AloG80Z05b_]N84V<dp
VEFl@NdqLZT@MLXO92pFYL4n6I>Y[B^L<0DlJL8Nf2Y_Tl:f>jeEF58Qe_ig9Lgg
GmD8H`eDjhY53JYX08jF7>SG:fQL9ZHKc57U=L;JWP3;lUY4@pKH7e^F;bOI`D:Q
o1ODqAf5S`KNMS7nC?7`IdFENqW4Q?6eQq1=HdHS`debFVYVL1YdK`g9gDcBEM`i
mZG@@U]gMYWg9`bGHHhRa`NBq2L0EjhZqmC9XHmp9T096[daPR5gAjN`M8QeTAbK
21=f1TeJS[MCYkBLL\IIoPih`]>cXK]RVB=eCQkU9Z0M_3k797lTEmWkqPDbfiBT
ZY;d9lIW<dhP:8l]QmaUJ86dO;dZ@^3n09?GAaUoHDJSQ:d7Scnj4JUN=PZbfMa\
027Hepo?;A0jFS:I>nZmn]G]`a2g_XOhf0n<;WZOdSoBLfc]_@TR;W[jf8aoVV]I
`QX[?coE;e?gbFBN\7p17WCD[;dSmgP3dQT95RWioVS7b?LX5GoP`hS0i<pXDRRA
T^@OM7i2[M<jEHDl95iCPD`AcUJhL;G5cbiRZT[AXX>b_@FLna2_4E6AjTmIQK6j
D:7G;]p5FflTWI_>a=;KQhU<U_P^a\@XIk_0M3h<GH3>lM7L8_K8T1^Bb:9\_c@b
^`Z1kAhE8]em=XXEipb3gCFG6p;\<kT0>^`VDT56caBP@KoOOHi=U?;l1BN7P??3
6gX5m6]8^[7JApAYX3M?RqK;V5mLlB`0_fo0@HRdmbJR@O@WqARMVjfZZoYU?H;^
jbSe`AoUIdomDl4bMq^b9PbiK_]7ih0;NY`C@GgHKJR@==>mIa^AjQWi@JJfB5kf
hqU\NNH0$
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
LE>McSQd5DT^<<KlL^OdY1Sgpeh`G8ZbF]1X`ROQ@MhX7Z=I1QFR\WDY8Ph=abB6
`p@8cOl^^F6:he`YA2CLM`gRi8bAE]nS]a[aDnXUFPUa7PQC;qj:6PP2pIFM55:n
>>]fk=Pe]Ff>;2AATmc6K0E_Y:URdKYGTaBpS[n:UgSp^EGBZfkU;YdiOD\TjARa
RHXlBf5Z7f;`U?lOiXBdG:Kpk13aEU;V9o6T5kT?@XOREOXWE6H=G[@J>aG0_?jj
[\Y>nJb4AORV>`OCYECH[CgqB0g;ZhPpoG:JiBqRgb:[h>^O`G@d]IHY97M_8;dP
VKHPZV6^_J]a]UXiQ6JKNELRK]KjWeBM@GKMI@kIRN3kjVN30Wa;jGMDN?8BPf:L
50`K7qd^IOP=]?nXOXg]FmoE<WEe]W2WFMVi<7:?IgXMKofmdXE2mThP5K\hF5[^
LZ5ZgY6mlH147U=?89MoT0KfPlS;IFN7q36bGO]PL]BZT:HDCAjFN6eJhO3V4?kH
IVhklLW4Wm=Bga725_0_niPjcXGCc1U5W_V6?EW11lQNnk7O4hJfYG\Z381qD<mX
`@5XSLEm2NUSMU<MN;TCO]8PW95A;H>V6MKMABZ`ZaB;6L6c1ZHUUDU?aaM\GGTZ
`e0PKcISK8_30a\72;ZHp6;]Cm\hqJRhTjdlFQC:95obdKMkjE]JQ5EhEVEJAZXO
Xn?4212gVo6Ajkbckoe6IXRo]lSPL71:;0`]fB]V=n=b31QJH`I44Pi2nkUk[4Wq
;S_NHRAY@72dOfA8aS=7C:PdCH=6N5;i8n09AZDDiJ^`=0pmG4;?5Oj3k1i1?o45
Q1ZM?pY9FAiifpSH8aZ=p2<^]kJB7o`T@Ho@=Sm3IeIQoPJDZ\>Y@i=kdoSdc^df
m0[oV3@V3Ra^0FmVEeF9OPCdYnlf?JnNJIF1a^j3c3LSOVI_?<<lYXNEiW?P^R^F
m1]ja@aJ0oU4cK:F><iMY2H>I1RApj;SkNn@;ZWLK?A31:S5`alF=bfJLAEI8em?
X8@LZoIgRE6f2nNGD?O>G@l2Ul0KZU3o82RFXaAknKRMZ2iG1`kP?jdpYS\OPCQd
4TL`iAjcTFOl5QRjJjIdIU[KAfTo`[`DT=l5GJd5_25ARVYONYm?QklPTNCjWLT5
GbNfT9Qh[b2HGFhi\eq1;7`gLdfJ1N]?JMgU_DTPfJci0m4DARV<PU\Z1@@7l5na
7^oMO:O5F76<1]Z:7UkZgk[g6RlV\C2P=eX>=QV><=\BnpHiXgP0GBPkAC@_eKKd
@\hVijdNT;;KHaRkP`<1V:b0Wg2ZgH@IW8bn[@QLlQL9\5c=WTaR9:KQP8HZoZ3S
C>@G2_Pd_Q6:ja5XqUiH=9<Wi33_40k91GkTT7AE3Q=R?QojK2nVlEGY4TPe\Dcp
@VUNTh>8U4`[4PB>:g<d9bH;2_JcTmgIPX_TjjbN71BKZ4eZ`heb`YmMF8?7c4gA
mRoqWK`E8X1Pai;\eOTQAR@X>gqbDoElT=J[1col:Q6>P@YMD:j_<bjoRM7q82=G
<:;LKNNTf:[17C=4>DpenQLVZZMV^L1TMiNc542>`cooi?EKg7FoFU66=hAf03C@
gj=9^kd?NSgc[\j94a3CEDWhgoI>GM5I[iLcN7Q=;Hq9Zi]ME[qSldNh4>qj0h\9
Yj[83bd36j?1XCScDgI<2CFJ]]m]d@QE^943H>bq91;c:K`qd_m:eEYp]XQ?^^<=
2QDLmRgMAdcd;9d?8ZaO<THDea\1ongd\cRCJiW85kge2nj_QL@=Slk=772Xe8f]
2k2d3Ah;54V9bM=XC_L=SR?X:Wp]DX=RJYpM56L0Y@lOc;=3WejV=eP7<qZG_Y:L
32d3kbJFPCI5UNaEULUe=^BmBF;jM53dgYg;qh@[a1:2p]BancX_MjBhZQNLQ^YL
04BI1h>SN0QlVL];g]E_f`X:k`RA9abepB:UH;FkVmZ1<50iF6b7GTYjmAL[dBk@
@bE`q0Nj[FI0=l9eK6<>GiH;<AHA6cW3_:mmRoCRpGUF4nlpRZbE[dQMh>c]FI>K
ph\aDTmRG^c[Zc9>i>W00pbgk<6S\Jj@NPT^l^0jZPRR:=0XBL7`M?aa^kD=Cm2C
p^e87:YDT=LN>B?`faG7EnlF\GT9K_C]6W9l6c<c`8[pg1V`I\BI^1Pded?gR\JQ
PgjYeBjI9<T@40`3DJ1h9WqoXPWKB@jUYoIXj6KeQ8_JJD9l0b]jb7o\NjE:lq]2
e=;aP7jKg<LbSbCo7YO\HX<`2hjh7C\AkRD[IDWgqeSmbgh\qk;YVfQZqdRH74Cq
ZG;>o@1bQ0dLE3KKhf@8XSd:YI5>M^\CagaKqZ<RA:ibq<NX=>@9pX?MA`6CJ`_U
Fl?ImHc\7dE53FmW\[TH0`YUlO1aM`o4c]H>MEo_Aq^DZ0oATqA:=YFi`21>U;KE
NDOY9kIGEDl][eT0JdNmV_I]Zcg1cQa:;jOF5KVZ;qV;a4<kDqSmU8FhUX[RKfpD
UDfTNMma;iD1jqP<R4PW8X;5HUWhZ?12AXDaQR;jcV>Op]lDa=GJ;K7bkCm3]DN;
9JkolIN1f39l3kOR?]G]QB=dHc^pA8LUiNJE:XhSjSqkEVkk3T700JSa;4TgB4CN
O>2I\lOC3p66nS]PZk0EWB]CpWW4h0U6`FmZT>`mUjbYMhg_]FLC10`pVFaDEABj
CeLmQTMI4inaFWTDq[A89n[KZ7TaN`7p]6?VcjfHZ1[=X]^5[<QcMNI;ii1LAcp7
\Ih3d3=AJqaS=TVdoi_5cndBPKWWYR?;TV\G<IgblpL@@`aNlpQ7E4<PqH?BQ=6K
i[<@<GS?<]nC\fbedY=6a`ejlfQ98_GAkANiOQ:Z]F_@l2O8GVijXIef3G25Z\fA
Z2ol[7ZA1]ZRW:NF@W6jZfkGa8O4>oRIERQ_9N:fRQa?eq2eJNhk32JbcmP^WHqR
`d0m^2\BMcc?>iae>fm@Bi9Jb6[:6R8oe2d@M=[PWPhF^_BAn[;dJ^EbO5[l@[P<
NQ3h\@46_Ckj077;nqSVNokV:YhnX=82b2cfoJFCGGFi?6<oO@3PJ[3eB41[f2Q\
T\^7I\ifF9<S\Y6GXlbjkMRgcibnN74S>OXcpS5a9:KIf[O^2]HWMSMj]aCKPaCl
USnbYe3cHG=moTFG6UI;o<SW8KP9380WcMQ0>b>i3C_lMOkZ>WE4XJEq=J@5Q6Kp
NBgHPebTIeZ@U<[N;H:AWeL;^5M;i_>NJ2m31F`_1\ljMF;C?^JUeb4pS:^dY:Se
le0^4Ja8BcA?kCndBUg[agk7kf?Xc4XP[T_`W[;^F:<B^9lPH6ZnXNX\WbFThb1Z
cALCe^ZBdSY0IO]YWGE\i]nDk6[1p]ZM6H\:PV:`ZOKm2n]eo\dp5dnbjkgp:EEa
F0q79bEE]a1A8QXML03=hQ9;fGR?f1k1d]G7fn]MB76[ISNJV6_H^KmKWfcne_KJ
3=I]QK=Y8\:6nlQd<V?nGSR;B5Tgf0;P>^8I[hRRbbR_iP0f^76N2R<B_mVZ<c4J
1=N\k^XU]g6gal;d2Uj@kU6pI\b]XiQkN;mo2jJA]\J>6cKDTiBX^o0HF`J0EV5Q
9_HVNPiHH79OIX;aci=jKWD@FE7CecEBSQ8R<Fj70Iq7>LI7^;=M]bRGhXZ[TH^8
\a6?>bgG=7pK:Y0UkWSiG2D<PIiLYRUaELBOg76N8aC^WVeTHH2PdX]V4jPkBm_C
F:iZWlgNAjf52HDNm]hW3femPoJPbpT3nXA@d<6n7D\h^f;T4d56gak057]=OIV4
<SQONhU3TeglIlTGB]]TRbcRRAIEUOR?LhOl6?ni_:_3Bifmpnbc;f68\YQe65V?
iNDF_UG]cEl7e9;n;m9WVHG>jSKo`nb<=2_JjZP9J0>Z2`n9=CEhgUiAE;J6AGFK
X=[XGh@AN`o^ac1a^m[LHp1aAke[B\G23UdkNGgjjKV=:IJFoTf_koQFj8g0ph7e
0Pf^]T4?DiN8Ccie2f@a^UF;`Wn7Np43iGI7]2]ASon4JfEdH=c`45:cfGeTAm[<
alB@Y06[lqed\=@>pTmRZ]_A[fM@fpLYjL`3lQG;;CAU9VFK>NkhodNFaNi3RFF7
A8?lnk53mJqTFU_J_X03O1mPFL>_HBZ^Yh_^5I19=kN:K9aJg`LfLq?m_CoE0=mg
YAK4J40hfgZdJYe4]N\ED[:Hle^BQiUhqaM^>DKBbmbn?RXO76^BPoKK<U^5b>Um
YL[o;0ES>JKp7cQ>Ti;N^S3Ml;j8:gYg_c4Xj^@dj6kR1:H6jNj9>dqWV1jY:U?Z
>0LfJOcNH@27:2[=YgOZ^VmGa3b;dS5RjM=p?^Uk<0=qV@lU>33`]oilGGKG\hO1
?moILQHQCFHVH[]55>p0Z@7l?Ap@D?g9SpnmLmW9:KDac6=HAjB6:pNT_RV>h_Gk
eWoST<EiZAC5i[eF7N`cj`;=^icEHRRYgHNe`Lg4G:?TS>DnoNcI@iaEFaW9DSQT
jQ07>^Woe44\=jae=q:@CbFe^qf8GH<jlm6>dJ606;mE>CCX:ol[SO4H^8978FBj
6dH=UC?Lk_q0<LJW=41qVT7WJ7?_g6O3F6UTXm=pOB5<HFMbcT9e\Bli:C8o=hS0
miG\3m5SUO6LZ][>A8Af0\BEb[mUi:WTMJW1=[BlPKf?\U9LZP=1EgO[lNE>F^J1
02G>d:g5IaqQa:;FS_>QjoY6oCLK>mMI2pGeimn63pK[_F0:Mfq7d:FL;`p^e`EB
kIqMGCdX`2phlj36MdRf>NEDIa1e:_b?\GSGd@GS9ncmj>0n[ESSJXZ4_g`E8aEd
MnkPG5eC<2N<hRLkl22K5[_5B<=aA68>]>6?3E`YjHdWHpA@L<UHjqHQdiWVTGl0
<<Y8P5VLdI4lqnonAk_mpNQ6;mILO0M_>EACm<Q5O]:_2e>@EW1V?M^BA1B>aVbE
`IY_P2K]e9IAV4GA=GCUqJ_fi\6@L2C\onAIfZkPA_hGH?]`1YOfmV3FqOWKY1:D
O]mcoDkGngj1o59iiioIKlA`28mGqk10USc0pd:PM@jn<e5D2:PHfEGEB>g<dC_>
]JlpaTPoZLa$
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
9[NE3SQd5DT^<kaDZ4\<P\kgPF_<aW_G^m]`VILK^cpLJU1Gk>R]0GSn_e2Z6kKS
JW^0]RcQJMQ8L35:Uj0`iHD2R0k_RUIoUFiVH60<0GFp]g?VCcFl;5P4Zl?iJG<T
67Zhij_ZJm_Co^oS?JWQ`g4Zq6N2LHmqUbG\fSMR>SM_]SV69ngZWnaK6;HH6HV:
qoUL:bbmZfnY41L:MPmogU?qFol2OHYV8OdA]RLG>3kfq:Obl3F=2Lo?6jj=Ee8T
`B5hQJ6@KDFAX4np94:9]dSYCPePH>`<0eDBB;moGZI;\:i]f`pk2R6GoX@D2`j3
e5b2kaX[9g6coU8m^1OJ8oIqPFHfA4mqF1VM<f0\h4JLPg\K;^YDe<EL9\bK_oP>
2>YTB_0E]<ldQO=Vh=0^YWPqlU3TWS:`YgD05J\@Bgi8K`SmWb0?bK^^_1Sml_;N
k7hi5^5=pgdm1f=WUNA;@SMgIXiS4MbVFYEXRMIL@EF=QAZh9;>Eqg7_9KC=ql@@
[R4NcB\bcBbP0e8lB=`nN[HAh8Z^neI\=>D1A664mf<nf>\^`X9K87aSm<aOYBlg
`3CVYBe?O^8@^l5QQN9p<>jooHAqlKbQk43_odYjO\6qMNgBG3nodF0kdlJCdiKa
=9F7ThEBBE]PpRZU>N4k22dKe`L7KQ0DE\Ecap?K>4@7?phNC8Vkj^PH<kRIBh17
q9S?iTQnqdYX2OCb^1V_LRQQDa:oh1N84XblTJTlHZ[\f]6pIQd`_KgpbBHM?cg>
PYjDmA3nU2_lC8VL^B3_i1Ja@R:2h[FDAiVTX4S2:Qm1[;Cq5?h96UnHl0=\KPiF
_:TOAOAI7k5>]C>`6Z:AFNKH2JRiKmldqI7mDnDYi3JEf^meo=T]O[RUEXV=Tm7B
Lnc?CVle1@SjpbfVP3VM_DQj^aRJ`dhT]=]@mon]hV9G0ogf?CSfCV@f@KiZ9?A:
n52>>a>FL\WkZ8Eo8L?[mpaW\`R?Cp4d_OOHRf[G[A<DGY]]?<0oJmZ7oOYHHAhQ
dmFNPDi;JJ2Lf2NE`OK5n_n8l4ZPRYcEX]Z7BY\mCTbnk94]n_a=7pjC3`f?np>H
:TAMZXoUH?MLKcked:0OgEq;og]jL[IPb@cRL0gdETJJ6f<=i3:WLFB^48M^Hf<`
hU^R]L8_eD`AHSiVSCfG6>>Fh`6CKnR]@b<SMDRWCoApK2o;JdiX82?nIgK]^DJS
Y\A679<E2[XaDa;pZ\ELFNhY]1dVh`kR;oC\SUJjHlY=[fj=Yi`F;e5Uccll][f@
Ci8dYJWQfALGMO:N3lo[>Q_P]A0c11pP8h:5i`p?j>2:GafM1g16G2bmCDjp@j>]
`:EqEOG@<2^pI=TCcbF<W`M`a_A?@Wd56<G`D8cnVlj3=EpHh5FAffHP3WQU:C=k
f_o\4AmkEqS99j3idmmooGHTS1j5C<`oSSE<gHUo2qR\:lbX[q5CZMb64pN[geJK
Vp^QTO1kWiL:f?gL0jdIUQ24MFc7Nl;>RS1OIJaQ<`9TYpOo:]UI[;0l6[2:LIi_
Pehl^a=b`o:[O>fOG15GaPqUfm[MNf^?S_D0GgDhBKgPYlKD4>KPnd8LE4PUIk_0
ST`p60cAKhA<eZk;PGAND1aVE56>hn^I?0Am4da^Q5P;7ec3=DU6;NEb=M89qNMN
YdGEf4JedO]Lch9T]9>ec`3\mD`1e:5<_UmE7emb:9X7T_57N@N?;gQ2]q@9L<Kj
P_<n84[MP?l6>4na2a\2<NBc<IMi7g9g<qE586PIfqYDQJf0OHO^p;2O6`SX[1Ab
>Rm:aJn;WPM@9ETY4Se`[acCMnKSId537e]elqW;na0C;NW9E]TRiDG6=dDhbaTD
<<mi^4l1A=C19>mg41ManYXZo0f:5KR_P:>mL>Aj`F4nLqR?L:O@EqPLLc?kqAbZ
GT8J_8g>Cd=i;emGCM<k\GSdh[mh5e[@bZH8`^iF`eSV2qS_iF93dBD\HZk?EESQ
:[_EE8CYmIcV]G[WMKm@cX\<J6qb1TUV`0a\2?Y`Ol65eFSVC@WiEC2U;mFYd@SH
M8_Hg`>pIac2nb71Ii[TbEOA@QR:>EQKBAXBFjfTf6e4KUd0e^84l_<]@g3m`<`[
q_;043bXRmb?QU^U?j>3WPR<RB_6HEdVnN;X@X2Yei4H8iZ;caDCPY_]<hEUnqba
dPUVUp\cV<U^7lH^q=g77g5bRlkS^?dJNg9i37W6LnD?9Kj\hH^3cO<Z^f=ggO`J
F]64gq5Y9^ZLW_Df\bIf^kHN9Rg;M>:];D<RZLejh68_EfF45\Hkj86BNa5ILFmE
G`lO;G5Y_YWblJERGq8n`JC?DTg]Q1hI`dOVdDLi;6X>RWD_hh6C8M?7IiQ_S;;D
J_jCVVGPL=1X5pj2B^h7Vp`n<iD2p1?27FUH01_2P`iQWjKUNCP52LS:9`_ie[a2
cm9M@]lSLq8;l?E9cBhQBc[EROJIhdVj]8TXcET_W><ZjBRJOnbFO`qj;Jb6FnR2
WoiP`ljVUhP0\ADM?Z5e1fFgikm^d`AQ9:V0m]?H1FhbAl@q>A5[6gj8C_13ZFFk
MLj>=W?^AXBlR^Jj`c?KZCV<kFg?ZYo?WCe@Td:PE3k2pcUSdAh^q4IgCdM[X1dg
?ATB]JgWOX78k3O@0qmWC[NG:nSkpkFU;S<C6HUXeM<[_8f@0dNaARORe5g@;8fI
^n2H[FEU?Lj`:U8V_pW_TNgh5:\Z]c85<l@l6[1;gR[^]VlPR^<7;A:b[Xk<Pkdb
5<AD`4@5LBb[G:daUg<0ZIbJI3jnZpZfDTGifpk64fEh$
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
