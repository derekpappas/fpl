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

`define M128
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
////`protected
FO69Q5gTLd+W=2Z:9DCg-VEE-T(]<[AP-UAC-b;TC5AB;BJNC=cA)IAY,[UG=4PN
OcA/-EeB;)^D-eB#D]JR-7C?&OP8I=?=<;T>ac]QdR4b)8S7g67gdX[YQKbCBQFP
[0GC)0TO#6XR-LVN9L&;fV:#338A:0]ICQ)]WMS4]2+854VP:L@bALNcB3.19U.d
UQ3&^c?/O?=KG&:HH,C/>Sa]aSc.;1CF>H@/7S)3;UV3ZM:-PT4PU/(+[<5a^X88
8QN9+>.G_Y5IFHKLa+(LA0Y.Od=ga[e(00YR<(Bc):UP13@^7MD:]I16X7FR&?OA
#E0;c(WU=3eI3C_SKZTXY\MaQTd464UPfL/Bff-+_Z7[VYa9-4TF^/Jb3HFeZOK;
8^G<C,Cb_?IWb3/:Yd(S6GZ2c>FA^N97]b7T6ZY8gWXaX6[V\UdX^TC4&1^2^c1.
1/?]YO:.;S?SW.9-S,O+EF<=;<-d\#Y]_#1VBZA:[8[+a6(&ZHf/2U&ge/Hc/2:+
L4H:>,;KagSTH1)LAfd1DH1>Q8=XgcJLBa0\D9IT32If[IG)4A,^BI;2Q#Z3-4,K
Kg<EVE#04ELY=Wa&fK4aV4M=fYKdP6,MZYgaH/H<)GI#C5],UgWYT-.8dE+@/g3V
5Y-72^#O(:G7=:;6/@HS5XN6L<(W(6=?S[+:[M&?]bI6?TU[Eee^6MS+E,@C]_XF
Qg?QPMH:4H#\+@dgIZKdJZKL?W#MX;.]&=Ve5^D&3.(W/1(VRXU\3QC35M,:dd,.
IWaB&c_+<QXIKJ>.&6cgM@&\>7gV1?E)E_BL6=RY_M9e>A&A]AE;.X4-/Xb[Z^Y:
]@)AHZHWE?bUQJ_-+dL90Va_VXd)ME)X6W7fT(RMTHIS)L#JBfgL?-7^0Hd<=4bM
VKJ2XR>Bb=&-/Z?a?CV&V5RfZT,M^Q1+4TM=F6^/>V7M,L#7L_WF_][.6BQ<Wf[.
NdEJ&O-77Ad\dQ&SB5U.SC(YM@P^8Qd,X(H+DRX:6.YOSA1#A^P6)WG1gf/ZY:7<
g.>06_2:AYfHT42J7b:>UW,(6<HEa-5d^[I,G-]>[#:_9<##7<1NMfAF0A;A&Y=0
.,S.0X&-]I(6W:dSRJ^,dCSF[NSc,XDc(FBOM3Lc91M3eKgdV]6@LTb8^=cBZIF5
@3T.MGI>R/Aa_\g:ZN[9a2g_ASW\-/Q/T.YHXKA=d@UYWHA;:6P0WPF9@+cN,?g1
18J?=;(TUZ9gHRYd4(FW)EM6R0+]B9-;M/2X4EgGFUMe@&+-de8=\E2U\X^]X:F0
2&4[AgDZ^>9b;Q<bQ)Y\34IMa7#2/7WQK^@,LNYeZZ+321JY_fYV2,8R@Z6&BO:^
>HC?HJ<8bFT;V.1BX/,/U^/ILOf?2UcDcJ>b><&7aOBQ4c,P)&[XFfMA:&ec#6^d
#Rgc)Ie\074[FG6F\L.dGUb]dN2?4g@g&I^;47K,Ke3Y<R;>T:YIagWZaRDT./cZ
a;+TAE<)V@;2[9Y)+R^e9cA<fUdWJ5[+/]U\-@QXV3MBVaG[Xc7FEFMf<_9:OPJ\
XR>6#A_9:6IfUT=-RRfKE3MM:S2aV^H-\f<XfRQ1D<589Y5QaU;AK1Bg#+DZQ\8+
<)_\H-_V4Zf<N5RA=Q3>U1<OZ3O=;X2#]YS&KX6=+YcP?X0\].\XV55f@eUTPYRX
+AY3&2:EH&]DJCE@/bU<6f=7X3(GIV=-B6U6f+?+)B.+S>8U4KbQL;P\C>4Q^3HV
-N;]-9W;PIfSMZSd;/S;(e\M7OAGGY=#cVA[eKN5R6SXTAdJK^97>8<0\HYJT3b.
4Ye8TKIHaR9FAOg4;c-1@^FgJ87+FX?aU,3b6,S>O&XPX\_W8<e(8a4<c4[N]UIQ
ZH.G6C4[K(&IM0@0=OG9>E&]2?TV_DV/?$
//`endprotected
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
////`protected
g?KeVF9]U?P;8a,#,TXa)b72=TZZ,<0J-GH>(^\=?^,[HLcPH)LU,=::=L.Z=W7Z
@8,Z0IS80MW>D6NA+ffXYgGTcK<)g-=C;+B&BQ?.)OT(KX<]6C(;eHX6FT>Q;RPH
N-CGTc?Q]f@?047dMfH,_R@PLQ&L^AW0:e50U4e[=c,U4)KG@N/VVYOBUOO1dAaC
R9/)>=0;L3(=WOQ&Sa/&M(G6_bK122Vg:G3V^JM=JJ_14C?[1I).V&.#Q4[A3S2_
8;#Ua@0N4LVQ@?Sa8NGM8KQ\-+#75;,J;Hf@a<+MGRT;cWSRWcI4@9-)#Q[&b5SJ
ccO.YFC@[Y.d4-b,FNGH803;:gXTI&P_I<MdZTSZ.>Q7N-UO+6].HRE=-f=UK,)Z
8\=<(@POFJZNUH@GKB-P.N),X3[/V_Q#YdR4I;I.2H6FG6CL150&;:W=a3.XG8O0
XHXdX^X]9M?T6@:_B#^;.L?&TAaY)a0)IMVd?gKg.DYaH0XY&D2)R=.-^aVRGSWA
53HC.4(;Q:PRGK&QRe7MJ&Eg_?6,0F@NOO)=g;IMNV=\IJ>@eJa#Z(3S[)ZQYS+X
GO5@KRa/MK>J[+E1Y0MW6M9b5W5<RE[d)G[f_^Q(Pg^,=Z/cBTg1)9A3<VXIB(24
A7:c:@c<]?#?g<d/A>gW#/)M@6U3H,HHcfNa;115Y;1U47:aQa6=PGGVH)+#)]D-
K[4.W=UT+ZVX+&E4(UaTE-(Y=fDM(?,cGe\Q+N\HY+/2HH<_])f5A(b0]A8YUF:S
X7.8aR\+]8b.JaBTgcU?4/;XCUc.OHKNF3PK7AHA#6<PfT?8:#^/SA_I2cKEZ(&G
L@=Bd-SP->/;VWF/bC=/>D?QJ<](6dR0(.##QH5C_^[V-@JQdBRb^NbU][HLIWRf
]c:bPNg4e)PQdTa@<c\^+_3?gJWE\2@Vb>2ENZED^7;8YE;E))KNNOP:NYS[bN@W
;@KGD7QJ:gVU@5Df8)D&KSdRPCWH#NRdXG6c/V<J8^OO@NWLfRHe2.0<WfH2.]d+
</PS+>[fP59VD+2E-Y\#Jc4GCWBES<cL,&&7765JTR?ZWV\G>K8_H(+7a9#?^cNS
\B1C^g@b\W?eM5HTA,8-A;CFG<U;PC/:3A[=AQ,J9W+\bXN[T=TOK?)CL?2SL>PU
NE5_XT<_V3+)3C6^CGB855K=XP3S#/F>f(/^A@S/<,&J;2Na^-4?8J>,^74OLBQ\
g(0.1#UI.E+(M=>(W(a93#TbRRKV=gf:=a^d9O<GZ<)<-3JJ^1dD.P^WcJg/.c-Q
CZX)GOGUI26;?;3CL8D92F.VC(8Qb77A5d4>9-VFLMC;)aSZa>RKTdC+3IX/+.MC
KFdSG7,D0c_W#KNCK>2./A8@<dFM&T<S3cD.Z2W&^6RB&C[@2N:1fN;2KQ:=feEP
eUaC^A^1FKLKKS]MR?\ZVGK=Z7bDCH14cX\Z,aAX1RPCJW&^YZAR-W<9BF2+IbWZ
,XVZ#O>5Lf#CF2(CH+KH6+Lf/@>;;U<;A>12S]O69:KD9Y+6-1TEW7/2Hb3Z],86
c5-M7OGbcO:S_)^7gJ_3eE^9+TAEM&GJ\NCCcO)R<-(efHD;VBGDJJ4LBBRQJ#/2
KY1Y&[<?Tb;;G[7^(C07]SV\ZW>gcM,,\1^/V7F23\.NZQaV?U.]df,\908@4e??
4H]W[J7YEgI&aN:/fdL3SD0XVWa=K-dTW0a1B;LId\=F->/bFVZXDb&YIT(]30G^
FBCEbUKW(?I]/Q]GEMCSTaf+#:Yg5Q1I^;^b32<W54.-(TME?&SH6eecN6?NE[_O
&A+6JaY8A>M0CCe.->NEef6(5K;JKLUfDb3dUf>:3U:P<1>/-8W]VV\,QZ#>@7/#
^(TG-N#CIEbg#>R:<)<AR9A3WV>7T\AJN[_TWJe20FN]V7I38U_;BTg](&&QZ77X
XC#H^_O8e3KRU[gB;LOQc/MAEZF[:R,+0ReO9[N[OL-?==M;?^7[2LQU@:L\)WF3
#H:8RaK6:b9;_gSC[,WHbM9cgQF?IaU7&CP(GM=@<b@Z4(GY4C;D_WA9&<e1#RQ/
]7S@7G?f</1B[IaN=;O@JIPbHE]?@QG3P>KQ/Q7R;L&0fR-E,)3C\[GT4)_X<Jd]
J]Bf5K>=R]PAC8M2SZ8/RMf@g&27127]W1LbJ#NP:=SF.7]PPKaZ\=2NHRf?[Y/1
A<3HW-_<_X=;6TbPB6O;OVBPT7;RgH\2FKe@3UWDUNbP0b0HVILE@O?_0O)0WPJT
bCCK&]f/UX9L6<2W^#+#7L@4SWQEBGW\.=6D-]>DcOT(fKc6=+>JMF1EYgO1GS/-
QGRIM6E,&<8b)Q7OX_5:;DYb7e\b1]W(&0RCf7UW=3S.A.^E+Y2\I<=f1cHgAVeX
<YZfB0A/3eFJOEJeK;IKKSWDcPXD+[J,bHTC:NL]S,OC+cDXe-IaO.D\F[M)d#+a
J[;ID:#59\=XZa_[#6^]GBDe#)5\YVVaEcWVYbc(W795/91SD0P8-bf1:+N]GXTW
H5]AQ7ddQ@D2.2PLDDc>deT+6V(\CW](,1VfYW92XS+IIH[9dK^(EF:;/2(B?fE.
dW_9>Af+&_1)[N^/9d407[GQN](aGM7K]806@ZScQBQ.A>9Ua](C:\8?SI79O.9I
/fQ?5C()O_?4L.J_34?GJJM4D0RUHR?[E9I4_f/PN6G8MbQED]0:KBV<\LO]a\#B
X)NL.d9,CG\JTQdb5R<L_UT[>,_d(U/T_:G,5a-B5:.NTQC6.cc=cL+&4OEBeb6N
fLHU&<E[aeD[cD+LD6/7-[HF.PHICUS7+H<&L4Y+(10fLRMZ0KJ3F=d>2b@X]Gg]
;COEK3.S8/Q67;YFc^>4Y@AMKJN+XI[)BFU[P+FC8Ec0N?HY\-dWfBH=DBX?(;LW
DO8\3M-R&@QP2XG7,^PKYd8N)D2HK]13OL]&eBVP9cg?GP,PNG=JDgE:;40:bDDd
d>ceKbJ(NJTP0$
//`endprotected
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
////`protected
,TU@6UJOT9[,=O1#85BL<5Ob8&VY,PIG8(:X8e524Y/8eKBbD70f8Y\;(.B09cdV
02)03Lg5/S:Ff)_YM+WI5T-#A6Z:505aM2[J0(X/O>X][LF?1G0[fD.ZY3SB^==g
91YGEFfPGc[)S8Bg8,Cg+<+CgHg1652)Te-[ML_d-NV./WMG_DR\+,H3N-5ecdV:
S2NR4S5OX&GcF&fS:B#8\P/2ZLGI;]_+IOC8SQ.c,JJW9VG5^bF&_MCWC)c+(F2O
J?U6B@:Tb\SE>1<-0#QA[I8VZ=A@_ZJJcF=a,6<GC0/Y6?C3gELMOV)8O\<a-?,5
2V>7E<22&Lf1=B3;bLDX#e#Hc._b(gEWM1VK(=Z[QMNYc]TcB70eG]e\F^UM1H_=
Wd_#<dF78.6bT77V?,/.D]ba-6K/(:1<PEZB+@DHB5G;=6QI;=MJ6T:##=,6G0ga
O,PfO[/<MT,aJg?XWM5CEDFMI)&X4VgB4>.V<b_Qbe7LKF?L&PTP,M7:\,J.=)3:
Vf<T5W01Tb;)dG]#?a(=6g39]AEeAgUI5FDc<@fO?^^O]Q<?]HZ<SLXSL>cfKUee
8CUbe0([)1GS#B0R2UW\;Y5IET87Ib/=+5@ZF0Hec>AD?0R9<Q8H]7^eF0(FI;A4
T>FD#E<^XgTcH(,2&S4HC@]+QC,#MPG52[=e)QF7+WGV0];1Rd(35&GH?X.&R8I&
4YO->5^0=DBJHIP_9^0P+85MWJ,RafI<W-.547;6&Y+BQN81T;TG=::aNFF#/NKg
K_J3UbIHZ8S_Q4^_gO2>[-3L3JSf;:Ae+P#V=/?18TO-I;<9PY[<BF:H?He@]/1U
H/X0@AV0aOEQVK<&IS?33>(B48Z,WH?bT1HP2QJU4G\G_RT8@)]#K[f#bMP)1TG4
eY3KageLc0&7,+;6;a_ccKK;UQW1/VPQ7R_:\e/YW.f@)U\]BI9;\VV<\M;a5D=U
Ef4]>Vb]b6;4AREY7IONB^g0f)AW):ATV,]^<b^&cJF.1HHd+O(QcTId0@@4M,6I
U;B)OA+f3GEeae\FGX7KGIQde/OcV2^)6IS@K^IVMa@JdZD0FWK?4a,3;@_F6bfL
8g_I/Bg&;42X<:0_H:@=4dEP?3J]_3)E0TDNc8\ZZ/[B5ZOC<Ca7fP7XI&f)QS=3
J4R(36TZ7g\+8M^F&Z]_cG)+EGDSU=0QQ<@/K9bE5@;_798\6ODMae]\UNX?Za-G
S,2:\8,(6Eb-=F<6TTc0ZN,65,[_-8[eDD?=I<J7Y)(/N(g#RJGPUX7KY>;2>1I=
W2<c2<=Xg:,)^>TI5eO?)[@F15G1TMYQ7S^YG)#.W&HM(SIN8b2dd=gRCK;ec0J6
^T1TK\VgJ+46?EJLKH/0R8=f\Q8T1\?XPLbP;<ODWZ=+)3=6U)9Y.[SLK)4V9QO;
G\8>F[PS2fgMY_(#Q=>Q(\,2KVcNP^E)T\;a2UJXR\#+9S>)0ANKd6W9/AccaH_[
;8V0X5Z=RccbK-dDY>a@eK#S.E]e?5TLZ&U-A(2T,?&X_@1\-dd8/C]_?J599GF6
WU]H#L9JR9dOU=4Q<9[]FX)G2-ce>7dN&cRM^3L[-83\7X.,F^&]][YRK5>WcHHB
>U#OaG/V/@D&XgP-,;_d?O+[\BROb;7G(QP.Q(gdA(/@Ud,QOMbY.<AXcc?e.5Le
3/(0-)U4:PKKeSDK_O@A09U_E,SJMJJf+d9DTfHUA_/\S<d:6H)1G6OXE)0eK]Z8
&DB?,TTHNI(I<0XSE6MTLTP;\3TOPU3afGZV;Ec:KJGDf-YX)L@7cT];5J<Q/fI)
23))@DC-0>&D6CM3E-:;8OAKgIN,M@F@0\6\-B7J_W4=b>eW/Z1(7?X36/MFTG.b
M#I#\a;7H#48N+(L/O;c.,R\8C1_)(_S]3F&)M.VE;TR/B39OLD8Z;SL=aAL&4C5
,IPR<XQ1@aO?C2>-?C7Fg=X7QW#U+JX1&>65e=MI88E^;3)_/<P+0?54;9+d^+^G
Q]9@fNT=,R8_T&cGC_+3\QF[X?4\d@K2S:Nfe^1fO\L4KUN8J,L\#-+aMA7O79/E
N1U#R7BcY>?KD=222cE=D3\E]eA-7KDFVbHR^S\L^EKR?d]U;I,T\[N?NR2.DXS(
e30?Z&T64SH)[_,?O:Vab2GT8D_U0K=87aM7D[.8]D),cbJTG;ERK@AJ]OQ18#eA
&3b)gAFI/[aS4E-8=?=D/XbB2VaLR>+\3V<Q>BNaX]]/E<8cGOfIQ-]f3c2URI#Q
&Ydg.]&8E;P[@#5)UDW<g273d)QN2Uge_TbNEE+MZQ<9S0P,MJ5N;-]67EICBeEL
,^b<6^[DU5&K1.\_Z.,aNeD::=F^PSf&G<<NTFMR(+_&=V<JUBYMeb-QGDF&[Pg8
6PIG<_02cLC^>?#GSXDQB]:X()<J)#<T,[039O)OJMafM-,1BFJ=EdbZ7&N_=]F>
<eHXD5eLfB6c5aC4;E#d_@S_2UfNI(]3[:_UK[>F]I,[EY<M[I>WVC5;[V0<BS0A
33\C5^Z=+g?eNS2;UcYSHSQRL]?#9@=7O-7JC.\<H75X4G75]Q_R6[^8&QYK\cF+
A8b>JeEdH@?Uc4[VeZ:KG\)>#U2159A:><<@D6[G]Dc3BMI3M4TI2?U?K5&LO_eF
N<7cCGeC2]NBMPd)GOc)N[;gF)4<A=a=g@T+;.:>g457SH-&,F5M/fTOHQ0IT-[5
G9#=2E<F9A7I6U+]c[WM255U4IgPFPU3TdN76CL7ZC(IPJ)YUVO3(Ccf?e\OA:C,
&-.WKMP,&U8[Z:G#TAM#,,L\&@H@6P9,[e&4X0,c_S]cLTaccN9;/^[6TDbR5-\7
DZ9+-D@^WSc4<e]<^e/8?=.@]MS[CV1TM,5(-=Y_;P47-B/H<AD\,L1]g(8F^\\7
0;f/O_eC-#eg:?[1PXUS9D#5U#/UeUg:TR=^I-2#5@E1f5GJQRHYQXU:0d_H).=+
Q_4R45,J422>OH12aS2?:.<Y@X_K_U</P0BC+<0GZ@,G+=52L/2f2:[dXEX]#ASJ
[Ab]d<?F_2X;bV1Uf>0&AZ06(^[&3,CD4Yd\?8cdN<>b6>Z5YP0Q3SHRLU];\8LV
PPG,]82EDYF\)A0#bRNgAeHL-K5gNY<WF[>bLe88(Wc+Y(>^5O]90Bb>=S==dP2U
SUPga2Qe0FH;/4ZcQ_.JP#dS=-d<+-?L4&5KV:QRI-#Me/HbQZUF5dZ2@;6TPa6g
Hb?QNN7/TAdR4ALA\d5[L0a;bVF1;BHdJ03fS,[;,QA-N9cZZaU_Jg&e\5OWH@P;
@JO^aOGcF;(DaFYfR=0Je68#Y.]/N(GR/:.:OR#Z#5?c8_.8=aN.?(,;G4T(T7fX
0)1S]FU:OaW6QK+VPO-g#D(VbNTMAOSRZ5JH^aa_\Ef<<I&TI673(#:F0&DBCJL8
-6LEa=&TgO]0?T++O]AdLKPFB2IRQW7VCPQG>>@e1Be0@T#&;SEBObR:#11e_(<=
IE9d:d>3WUf^]JW5f1L6@c1\:dS:8V:<f#gIb_#XfKC6S3>QN]GOEB8)#3+/&[JX
7,P]FTV/c^,ALgR7HDR_7INdLQ@6ba7\-BU;1SJJGLZF;>Ja&>a>AYN6#7;8Ub6D
H(g\8GHN5FZ8F04[JKT[/39\Wc2EBf[@+7X,S_B=U@dX#GT4c&H]]3d>gHEZD=QP
R7TYd(cE.c(,2N:5;_KC0;?g)\NFe^BI34;.5_d7R1ZBcV7^AUZ)bZZ6^#c1QSM4
RTCG-RB^\8CN/LS@5CHPPBWSa3/b5/KeI_VbQQ2A6)YaABT\=[Be.+=A+P8\W>Fc
#K@;4\3\<W,e)Y>8.Wbf5g-ZIOP4;Q^,PK3CF9I--.O.1P#K2O\?@OV#3AIbVCT3
CX7Z<S)K>@_gfJ(<Yf=fON#J]5F#]b9:6,]\ATZCSPJE3GEN_e454IDPK-T1R01;
LUX<]]dEGARaQ\cJ(0JZ1/66.R\3b]0dM_]./dC#8<?:aNIYR=A6&XF1/@T-bEKF
a.(LO=gdg3@dZ&,ARQ\R+:\E8aP#:bW\:2Pd/IT>52W1-ML9=Z713/Y(b@?,e5IP
c[>K:TRNVE/BWebH=KK=J:15D,;BDE2PCPGWCABW_&A:G3bS-^UW[K;[bW(-NU0K
_\NfBQ3GPT)ZT2[A,96<RDX_/9IbR9;3\=M/3FA:GPO/GcG)#5;QHPK>?_:36e[]
D478#E26-/1S^X<0Bc7HbA4;TaPS_Z8bVfg0Kd1ZU5.Z00/QcX;E;SW-GFF<3gUb
)E5:0]OgF@)5W]Me>(K_M9D4N23CI?P0NZcOU0T/J)41)NH:R09WH07Y0P<XD>f5
?>WPX17W]8(cR=eMHdW4?MU7UYU]a;Zc;cIf:&-#U1359-A^^(=6Q,78Z9f]5.]>
8aLUI;T+C8DZ:[&-dIa;-ZPCa8M?P<<7FENTH##=)UHGJ5A\.W/>[BU/#HR?R[\D
_,EHE+I3LL0\\.F?G/3G><cIRBK-(b+A:176;_V>F:]:&#1(@&Z^#\KOZad+H-J6
3)=QWbUK51a<&A^G_01GU#:CQ_F=9JFQTU?dU\MY]4/A#U8XOe.74([<<^4IKdTV
RG>Q1_/(/V2ISI=HbK0,K=Tacb5[R;ZaMM<IYPafKa=SEB#2T02:Na#8PM#IRW\N
\CX8A?Q2>6,LF<HVMa3)ZKdXO9bP#=Ue[Zec=F35TQ5YP1SD>NYCJBFW>4e&4?E4
4[dYF;_NgIY31B0d@<gG^f3+DYU]NV2E-UcA\5:[CG9)GPC0#[E4VPE07Z35@2@P
]B=[#f.c0g8M0X)#8#X4DF)gOHbIZ8\]a?28,EQDG/-U/\A9D]aOXU4_09/E^BHG
A-7/[\&C.J,\eg+8bBH_e98GdA\&?,a/XS,Y(CQ.FV];I5]]&dDM1He@S79aY0R^
a,VVa@?[(A+ZL3D+J:F78-)#+\@1U?09<[5V(bAT\KP9+^Ge./9Ya#5B[g3d:B@V
e4EX7YdYGSVL8R)XVTP50cKJZ7g\NP1+6<R?eQ/B-U,=#FU9WHN1>DRLD.1/8D^&
+#5/VJTg,d,MKgX&O6YgeSSc<<1_g.9e)@KABcL?JW(<Od:_6R^>6KMH1UI[E-Wf
GM9[gX628:f&[c_2.DZYQWeFeFT<AF]>BFB7aK<BRYE:4C.SZ:b0R>E<+Q65#/#G
2Y.7^47Pe(->2g/K/F9JZP3Cg(DL;D#9HgaWOK,>\aQ@F?c2&ZOG1b/^V^M@N8?:
3&?^eeS9]J-E9FI3K)LMEEWbGUDXgBK<?0E-H(QUW[CXIU^[L.7A(<,c4O2Ig;H3
W;[02@?(YRMD\Za7/ZacU-]Hb]<GGCbbaL1LO5R>4>BN@479/-0WUf/(+MRRE<N6
NPIXWFO1VD7MOWO8d[8NWc1eHEG7LV-O3;F4dcCf^UE6>f>;a>a5:F//<M4IaIKC
CXc3+\YA/Q,&5Me?DKW3+=E-X[F2]eLF-B,#Z^@G/-Lf7?;X>?0f^W[I4[01O#59
B5./#CAKd0YSG@O[c1H9U.FX=M6c4_98>&_-N0U,/fKHc((S5^+R:AOE>40EgE\?
dP5N.d-3>(E383<UECSabD?50+DAd7bZ&P_HE40D_?Q1fHG3a^Qg^BeM>+RWFNR_
2)HNAQ4f.Zgg.658[]:2U6Mb2PP)KEM-c@KU74T?6V^O2I(e9QfA_A4ZSRB7J37O
-B(>=?POCfD-e;)#W57&aH=_8FUaI6#/<AUbB5+(+?KJ\S4I[eB7.CYZUWV\>),F
>9;(C.PQUZ,_a8)aA(A7;+=,WD&_++67[EPP(b]6Kg_Nd5P/GMM\dY0S/N/Vb#<)
V(g6[CRJ<JM)>GUPEMZ4N0@[G:S+^(QJ8P^OW/F^N1QAJ6#W>^81P+S(]+YIgXc7
E6dRCQE--_=&81PZ-I=3G-T&KULRS?7C6D=HJgQ:U\A\WdT^_)MA/K_?.ReP(-JA
TJ9+^g?&)Kb&SKT9;M[X=^0-<AH&_ITfHSTH9GaO>2#+,J&I==;7aK#G&RTP3EcY
X3?728g[GAQ,\dRZ8K4e6IG0(YPUDT6K3:2a7bJRZ]K[SU\L;>;=@KcE-7dW2S=e
gBMU-9JD_Z-IB6H.TJ^J716A&O<1FB)DgaEGD<-(JJX4B1;ZIBDX+&e^]]57fL\G
e.OeS0]CeI]8+DZef<d6caHUI:J/,4,UIIXYW?<\ZCdCN6N@I^2ELd1ZGQUb1@F\
-\Q><>#gP_?G):MOU5QXNO_3a7cY#;63[#FH2>a9^],#4T[\0UXV6[FSQ;48eEV\
_-H(bKZ7O/<6/>OK1:U(GK5JOW)PE7ZB7F6F,4^5OY[MO&T;<JS2RIAX+]4[Q<^f
b8\6&2NHe12.6EC&#B5(FRP;5E>AKP<eF43=+_)8(fJ2_V8\G@=]?bT]]R98<Hf:
VXC:JEZ4&-U<PW7GM7g2RB(f[Y?8.NH5A\]?H?aC_5QB,>]88;GZJ[XVYK?>+@BS
N,EaZUVUU0A\25/H;&04JfSD-(0,RWP.I=WHL493F8G#).:Q@MS;H1WE;QFNVBNe
WE6=XRbVOG^(^3#cHI1J98B3>B-gORadF>Gc+L@T73]eT1V-/,LA[D68f--3(]2?
HeKUS?dfG;K-4\SP]f^48KYJ9T)N4SIM9]G&Ba94Ud1\)@2fCUA34TdB61ZRF;3G
Gd<e>bg-E.POd)]a11MQ=eUX,Lb#I[_?ZPDKd=NQSe_:LD\(8c-5K5S:TA\99@2>
;C4S+a\33(Xb@H0>H:DX?XGA8:;.\BF,XW72&Fg^^=)T/J?]=F(DHJT=[+M#\39^
d4c[A[8PdBF,6+6;KF9:[d^5G\O\@R?4W\(bL94&eWIMBW)@XZK/X+R5SP.e90aH
6.<,KN-)^KGVGE#847UAWV9NSGRbR58>/?YgEL<&f;_KReO]/TNOc/)&g(J,cIN0
=R_?)N.Y,\&/fJ,K3g3f-&^+1@VNgU[&/+ESA9\(gO0X,5RKC:0aR-ERI7P(ZA-7
3aSW\/Hc9=Ud?11T3#@3/-:O&A<HAH5FOC@f/>fQCMIO/E1e@c<eB(ERI$
//`endprotected
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
////`protected
[LJ1KP9MUWfH(MP;=:I49UUB,/[,1g(B8/V<-IW=>9S^?QbCKDV]8GHX,@B),4B^
0)M7;T)1NfVWOe0?AUe\-]<X7fVNG6_,?3U27/Ob)Ea:&d->fE8a-/F]ZY(4B&^H
ba4XWNAZF#3<N=cV:f?T_;ZGRR&JWR:=:4dC&>CT)<=d/,=HJ5GEH?Zf8dO@(3F,
>3+HVPZ,Ra#b<a4HOB0<G@c6+/E/EG@/4eVNUTSb6P\VN89c16RgY@3d.SS9@.)S
T?c>D>(<C.g2N.CM25PVgBHO]c/Y@-9S+CcAcPZZ5B]9VO<(bFK[PVM@W6,CW#c#
3fJdfNGE1RQ9RRE5\9SgA<5A=./G,)>FdS&+:94/P?O<dbC#M/9e]2N\A@9b=<XF
)(0)<@(9&NL3PaT=ff4fNJa_0GfYNU^OUWJH2,8L_#+<U;0aWI&>+S]BGGc=RgOQ
?/>=fFdFFG/ON><eM[#dcA._M5LSI>aGGS)@IOX6^E>-B-OM:OE7(OQMTQS.PXZ_
<UHG#,^HS>T8T6<4U@@S;SXH)Zd8+6XXE(I>>;Pag+Ld?Ad&.[MXg+,TAX^6bfaD
D#]0<D],c7@QB5RJ6@9VLI7VRMKMMUPZ0\A#8]1DDRBPHA5NGe/^M]^D&)\N&7]_
\=0Tb>?Y0N[VQ8NTCCbdUC@DZWRg?c]b817McdJIK+If<>/E?E82(ZXT<(Td(g]X
>WTSP4)-[:D@-9eR^<ba2F+C1W6[GfKZCU&U3RRQ0>9Me;FfH&)ASF1cJbLXO1Cc
\1M1L10VUQ0N(Ud>g1<]9RA_[+7TNMfMWQcH+DI0[>)E+(Y]AG;:bN,IMWU5:)?&
D)ZYA/c9JP[=Pg\,._4NS0f02W9+9=DP6<(d#e3g.>?01c\c:^,&1JN(E#/F]X>g
M/\Re9J]T(\U._bE;ZAY5PK;N.eHM)PdS)VRHAI]U-TTJ/?8HHHXbX9df]/+?/^7
AZUKbJ^d5M^ba?Z40R4J>RA?<<+HO<S6dW2[0/TRZNZ=69cb?<IP>Ua-AWab.O/[
ZXL.Z^U&&TXHR^VZ61aM_;Z)#HO(a_WU)@382D7B1=@Cg3HR090TCRWg15\86@a]
9-/DEYNJ@+#X+D2H4PO@0RYK>7]4Y3#D8fR+LWA6<Z2G17#b>VX/C.\]<N1fK,(#
,/-[PU9PdU2gGXVK(g1)#Ub&EgI#fXW<fge+5a;XeBb&gd:B@P><#V#WKdL<4>VI
TIcXB7MT8,?OQ>cR9.71/?M)]ggNB3&BI:]T2b&B_2+e]GgUAWf?KUf)&@&Re]9A
OYd0#b@^#M(/^CPQYJ5X0T)_MEC1SB>3agfU-2N=R-[5(H4?,=66TS70>;6M(Y;S
V4aOKc2YWAHdX9;CXPCfIO&02<8C./=IaSNNI0gb6C?V;RP<L:6=O#(BTg#H1NHT
WAL:<L?E/;+,?E]+5]17_L2,=#(,-ACe7\-K/15b9OIfM2,5L[7+1bKWNQR];I,;
b^@UL5#YeW_=6f?I=ebNL#YcYUR7[dGRGM,U\OLJ4WeN?JH>[G[]2EWQOaUd?2Ed
^Z?F]&R&a:Z95NL\Y2Y>XNS8>@:CF1_:3d)3VTJB#CHWBee59X]Ya@6EX5S-PXc?
,0&U=D>6-YZLcHc#@2=MY>T0255QN1IW6V>g:;2+.>a>4\)LFEG8+J:G@g[TAD7I
e)DKC_f=;f3aM?I/^7V2P1LCWP:a7_0Q&DQcUZFBL_aSO3Y#KZ15_G,;_<^(9BD2
=^?\bTJ6A\;16;FI-UEL+M;fHIG3^;@8MPga>O;8TXb?QX2da6e1d([66HF+3.?H
(b+aS6#//1f^L31acYR:0H9TSAa1O;(LM0^P[#DM?\cX\eMI3@cH44IfQ_C7T:XI
E@1ZN49fWES5R3(G^QW7?\PQS80>W<f#H_:-U-=@\-OTF5;.<W#9)>SPbe8PA_&E
XUef-ae<UXRdYeU2),8XWff:QeeO]:R0[A5c7XL,55S+BL7(cK0OVC;Xe>eN^=>/
L-W,652D:UaK>8fJBaR<S:,<W]2GM[:.0G+cgDM6c)8b[JZ1#6;S-\fRB)V/@b=]
c?\<D3JLIW>f6fT^1NXVCP<^aK3f-a_XbR(NDC-KZ?#O@NQf<\8Ig(VY;D,6dD)g
W=+(YKU:<4GC)MDDf7)MTKa59fTHG#EHRaD36ZQ)KZEX<5#;FUMg.45SbZ:4291<
\NO+E_XDc8Hd,/g975BB@Vba6T^2;Be2@B>32T).GTIXACbCVFRd\S6I#RJ\[)5Z
\5eVSM>D)M[L>dU.W<Id;<JWW\-J/d2@YCL+03C1NBN[#T+,KTVSYZLN8VJg[@EZ
c/BSLa(BV:1/O2[e&bcBLBJd2.@_Ha-\54.+g+4VPI(_#ESaS5dBePRS@]aK>VDA
QdXMJGW0)XI,,@3LM;]DEQ[g.62B;YFA)E)(0UD5W0b@1c^]eH?>:_\O@(N9CRJP
eefRQ8PW6_bGR9_9]b&NAa2:1UDB@S<P;ZND7[+8cZI]<6:36BM:NQIWCW+2[#48
WOTAO7)3;YF3B]F41H#8;&<F>0N(/17H+eJ,O-<)0)#]3E=K(7O8Q,7bI8:dfA]D
cd#:XY3SM8&7K;[FLDCU3BO8)-QNUf.0:UOH@?=1Q<AT_HR1DG_bbL]PX0;T&&RG
?R2L<A#Ie0Z=A??A9.c5WL=_(fUD42a4P[55EKd:EZ_)?2dIZ[@\6WFYN_ZRNR8S
)42U#2LU_B,bP(?[OdXgf-1]AN#VK6e]=ZeBbE<EH>[09=#f@J6WLYaAT^/Ac?5e
e)G0QUXc#TRIC-Y07fcVUG.&)+4UQDWS+,UD:8;gT6Nd2<>RO5+5TMe+b,4([1UH
,\<TD+U\B7D/6?8cB&)EXb[XL,X_VC\Y=L+D9=+SQZbV_0A@GfAGMg]S(5VKW\9:
]/J&B.MC5.Z#YJ-Q3EAK=5B:/,>FBZ6A,NRfD2gEMMgKP8,fNP695cB@T_;([F=R
S5e8fIWX81)BS:GHgdeMbVWX:U\U9>&17X0G.TAT\eT,3cQS?9b]OL2219A=9G2c
e@I3eO;b,Qe75=DN-DOOdKGS@f#8H#,=0?W6/_H28?M__;>7Hd@4RBfd>CaVX8K6
3SZX5)W[=N3YL=06W],MWSXG=I=F9.2G8]2/R;c,GaVVOGBY<IYab7fdP$
//`endprotected
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
////`protected
&U@K058]<[;+(c-S=#(&<C(/=M>c=9L--C?A,g-LEI)5,@Z#3b]L-O>c<_\.99c(
@QFT,JXG2->d40d>9,9[=M(5cZ9K:^PS9.T;McZRRZ9+;?_U(I=_.U\5E^&2I::\
OH-7.P.P78B_#1F\]B7YK=d:;E+K:G.VQKGQ,OM6771&P>NcFRS)9#SDR][Q-OU<
^2)QLJMVK3g#7)FCP/Q>><O:baG?=F?<f4;&9fFIXfg>fJCVF]9LZFPZ[S-66XJ_
fH./c#=7)QYfM.,A\/6A,?g(58DeSgOPZIaM^T;Q^&6(G0=E3C/3D6=2F3-JF_5U
eT0bfCUKJC=e-<RLV8]O,YP7/C^UZc[b<H_Cfb6Z-W:ACS,[=(AE?M#HGHZ\<XTI
7&a:C7LB-0I5-OBDEBV#YS2Kd2bOPdg)ZX3OX-g:7B)1US\RC70QUP(ZdaaG/5?O
L1eCB6JRZ\44A9&FX:5V,:?4RV\Pegd^355\N,WA3-&KMX]^BRaWH(:?2b1G#c)T
K+4P&1))8NN(#f]3V\RRTL_79SSQ@NR,V(^^;R@#EVfe<d9&8+BPP=7FObD]&V]P
R/U#2G#Rc(MQ][X^^&P3;LIF@H)T-d_22d#PbG;5]8XN?3038aX]8W]c2:3H00LD
C<AG(R]@c3VD7183N2Dd6KHU><5J?Z7RIYbMa?Uc,UeQ]FTfX=8VYL3K?FHG79RT
aC-(9Vg1a)/#6\H/Dc[9W4>e97bdXWFbCJL<#^T<-VIM>:?S,YOJQH:]\gM(9T33
8?)D@+&-;QZ8eCF]3T:]0OIYS\)4Y)_96;<df1^0KKJ[SUHS7,JeR,RA6+J2JY#/
eOGW2aA3QX8:e+<O?Ib<dBdRb#bW1B5]HI/D?VOKdU8OOJDEK1<cIX;W,_IP-)OM
b]\462XU-XT^18BF..#HI7\KKOZ>_5_]W8<Xc3TgL-5GNMW]gE-H,ER;&E7Z&&ZB
_YZgg&aRV&A)#I,08A4&/E8DF#Qc2GZB+Y3#Q?6g-@P,)B8G7XFY&KNd,[;YIfCX
R:/c(^S&CTZCD.D+<=c95_6V_KPLd@eF9EET&.Z+8f?E=VX197];O=Z?C>_M@-\>
)7PR4/@f^@T:^M&/L,>DE3[83=B\ac,a+VH_S,UV7bBYQ+fAX8(J51-D:?EF@3>;
DHK.GE0\>fV->f?YT[^Sf#(K^;2Of13L=-NdV9U)?5(_QTU)\6M):#>[IO(g<6H,
(.TCM+@4SBJ>bJ>WJ=f:L/<W=6)(:;]=_<GUN.bNe+2#]g<1S84F5F/,dJ^V(\4f
dP[1W+fI<K8KJISF.53bUH1.X.K:;ZWF.D>/DY=OBK+c?1,dCZG[_;TVD^7QeIaU
+ES3E#\-,L-;,>FRDJ^UZ?5ZU:3]4Sb5E/+c7>J.IF@Ae;N/7e<30<.a6>R0=IC/
GP>c\8+Y:D-3<?PHE##[Ea:[(/I:1YVf;aD(D@?(:/GT;&d2b#^1dF3IcKdcWd45
AQV+17<\O\(;e#Qc>VC\)Y+6+bD&DSZZee?3.#eX9]\V1347UgF/f;SN=900fe:>
5E2<B.g<K+YXOO&;?g<;^Y6LBH(<I=Q,EF_\P(;EgH)K7Oe=DJ?[J^NdO8E.3-gE
daSES>1OSG-7_3(-b5A=1FOY;F9L=Y\,ZKRF_UCM\8P=9gY+/bd^Q:=e]c7NMP96
<&C9BHT[aeS4ESJ([E^Z/]\=6cH49&^G&eTS]R-9Se+;,TH-;Ad^=N(=/YQd-R)#
TXCa+_SY3S_g75[[C9F2CWK(Y5P2;S2IdQ66-gPK2aN0_P<1#fO7&gTCdJK(aD0/
DT)OgF/Ld_H+;)F[N+/[9DEIH-Mg0S#S#I:5c[:ZO30g/]XYH^WY9Kd;<99@c53I
M;,18KZIH2[Uc3,3b)&&YD<2-[1O==)M)^88(D0Bg1:,ZHUa63;O_b\TSgV3HRD6
\CCNL27F5MUAV^W1;JHfW&J4T:4/KNGT00,F]6R.2B.UXO4T.&4S.bGX=3L;.aDa
K=)d)Z6#8/HEV6J68[8?CEd(O7<#V]D/SCf.AQ-CW0L]J5PLQ-SX&HR#U\6[IHMJ
VYT,GgD7,,aC;\GX#XECTFf,JA^Y/NRcXX/cK]UP?JfE6@#)D#DF3S</aa?+8Xb8
:<CBg-3g=>FEWVbZ+M)#[9gFR>,WKE?4e7D6<)2:Ga5T8ZeFFI.C8;ZK14A-#YPH
UW4/a?V5QcOM6(AOg:RFfY;_/3g>0HD(A5<S@\>JOOaAILLYgUN8FDFa@T.;03c=
RGRK4:0RY_F_LLCY6(8C^XNE0I/+?R52F#M,1HgV\B&O-<S<gdU0(A=PS:(-5VN8
@4&F82d<[(MLIS4)f6U3<>W6#;f?FWL__3.8LZ2O)24/A\f\T/K:bbId;DH;T\Ud
MJB-C75]Z#A4b#LJ/D0f=9\Ca]VA>9_aKdN@-KG@X)DN1.UZ6[S)ZQOe=OB35C&2
.XHfVD[_I27XDaK4^A=2HP,UI>E661Y)(Be@.AN_0Y>U0d:0]FE8ba>5AX+G/@TG
aK3ZgffFKE5<@ZWA@2(]RPZHSSL92+P5#B/O?7C262Aa.<NU[9A25=4,&f;?<Z[7
P9VL8@:>[(fIVXf1@RVD)Y<2R5>ROK8D8CA/^[Sb#CM^f7Z[95eR#Dd594&(H_LO
f(b(QK5],(S#L#89f43-SAac>-Q&dSE6e;VG;B/M4Jg@G3NR-;fQ?B2N(bSPP586
O9RJ++a#5_N_fBW<FJf<..XX\\FDaH_gU_MDXgXTZdJQ[DXO.?D;2/c4?VgG\TP5
I^_280<(@[,=Ad6?U8ZA:COd,N-&BfbS1<A)O<@3.E(JU[5S7fOSMHDcA]HdX5V6
CUIKBgD47@)#0-&g\QUZR0;FfGFK)=a8Wc/PK09-_=Y_EHe&^BVEPcKJW4DZBXeb
RN6.N:KJB4KVD4I:a=KM,XgJ5HIa;8,Dd_\OMK#fV(8]&b#;M[fBY53TWX]1gE?f
+0<MJ7M9JCLEL?_5&ES8ZY;V?MI7)>H7VgBSB>1P)S4_FIG&8KEfM=b[PXT1?gcO
Jb8D9^I1+_Ya>KbB7b?6Vf9N#Y7Q<30Tg&ROVFFVbU[[:LaMF+F4,5MRW.LV0&MP
/>BW36gL[99+_6#D:Qg+]1D(A@FHBN[/WA#77AE;_bZ]WRc&gTM-7?SAK1dgT[(R
EU.8C+5CJDHE=Ma#/f(PY[K#?5PgG=6@d3ffAB44KQ_ESMK^Y2YJJBCD(W+2ZKG<
6:[Q>bI9Q^__/CSJT;A,@E);XT5M@T4gF][^JP^==T/KSM2OT&-cB>MD#/,N84QR
2,;1cNXYWJS>]I9.3f0SQV0(0_0,^7</+R&ICIN^LR<6F<5XJR)fgT?)/,;38Y-W
&gaQMJ(LR[[9geN98RBUR(:b^T_XDXK\1Y/WR5Td9L8#\)e-7A/PYG4<1_X:3H/;
NdT7FB[e-DK5#\+]Dd7&)O:JIW4?WO[J=eYS79Y5JZK=SW2<V^#6BG9NHFd[](SW
;P]LP)4=]H\&=+Y+R\ND2<.13fH3ID3>6V84eZa42?_Q57<8cbYL[_)&-5BM?S<Z
dRVE@.8K;?1DOSV,QGWg^FU;M0@aMIO8-X/PJ7:8AaOD/N;>B&ONR8UP<O)>RB;P
;DK]V6Q[GCW-QU)cb0XI2K:+>OGU[7\/W=.ON&)B7+_OTWA9YP=\\UB?N2XB[[@f
F3;g=6\^;/(E79&&^#TXf-C&YF[.(NYWDQf1B5-.e1eB=GS&<E[Q>aZ-9c0(E2PP
PCa2A&4De=.V3AGZ?#P>((f^=f0<.XKba4BbW_a;PN6N.eZRC1=f+;)Q](c]U9ZJ
=EU++P[-8C:)GaVcFX/BTFDRGA>/N81@39,?50A9+92D6-[45eXMQ2X=HOMFT4]6
L\Q<^@@ZQd@7#C_e<8@XQ^GS]RN<gC[)L<TX,75^PB19d7JYM6^/.-WQ76,YW;_)
/E2<H:>V[NEb:NJL@W_--9D9?SZbCJ2BM5WNPR7Z+BWF6[E.><;Q[]/I&V2dLe2A
?<MM_-[,D5B2,2fQb9VCR89&-8DbaQS1/W_B1cbC^3YJI4>E,#bXK&\;ZTRQ5HWJ
,&1I\[A&<EK;?7Z9N#\QLIE6^,Ha<9^R[fF5B03ge&;JbT@I0EM.[@SYPUIE3QJH
0U-F(#O\O:426fCaXYaKbQE=Of+eaeE^R1Z=b,LL,Y8S@Z54bf@Z9-Vd#Q]@-8B\
00E1gY(K08=M-LIBC\Z:W6a0L<6]1bK6Y)Ob-WC:O97:H\R?-4E3#FY,\]He<Pa)
Vd<S\U]?/76JT6<))@CL<K(TCF3SAO<W?3?HTSCb88EZgEbd,g4d3e#<.J1+OVP3
^=\X[R.dHLfV+#3(MZZ&]0RCeW3(@bX76/M>EC+)a?/P>]2IQZ])::E=f&:4Oc6#
?@CO\]MA@QN9f@J=\HA&f)\]&6a2SM2.QOM80:_bBg?6@^G[Keb5P+(9&<PbK0UK
Y2H9)_cV<XF]]RX0Q6<^8^68\0_W##YPa+B+8>;_)DG.QaXe8b1;eg.+VE)B<+9K
\/g?g1d/PaMaK/g(1P7&TE>C6E&\E^U;4Gd;7De[JSaUB-],BX>BfX[;1bEgM[[9
SHTeYY))#8EHB)efY9J+\GHM</gDN5D2DFe7OB1+dIKVAYT((-X6.36-g:\^:I3a
N)<8<PdZa^5AGdWA.N8-Ve5SCYa]gaE_=;&I_;AE?U^L)XDJ,-Y5(1OOaYEb[\D,
>FCIIAK@+^IFNeO(JC9?\0K@)V03ag),5R]3(F(aF>+&?<;6Ta@:6cQC04V2GP]V
CPAZD\0c5F<KROO7(R-57^0g+;\Fa\Z+UXcYBGVegG>bY5S1CTfURbFRV>OgI@XD
))=(/<F.YN[/L--#aW5^+Y@EQ)YeU2RSN^4@>57ScZe#9L>Z[G[?=Vd4NCQa::L9
N,Xd_6VHe6f>ZfB\&cCZ/a(H0f.8e09+.R6==GF[:Id+I>#1GD(6>-QZe?cH\J_M
gO5+b6[<MUe#-NP?@H\W[:B=YE[^MHFT58eL&<]Hf;&7R=XFc0AD1NKeA=H#M2.9
]A;AA:_NN/K6YR^XL@AD=OE26/fDSIgTMGb3YM8H7JQB\:Wd6;,Zg]\Nf4_T--U.
NI^=IU6EEI42E:9&XQ4;I3(1Y6Vf&#.&N;+2[LaO4>&>,R=Z8Ng=@e1.X5EZ_C;]
Q8IF&W^f,6(D]4+4J#>fS)d8L4;afQ9\((\/;9&c5_A6#GD3YPFI@0TVKLbX2\JP
_)YR-(0]#5fMFNN2DFbBCN[V/=&K,TSK2BXKK==D;+:#g,>=X;^eH68?#6T?ZaI)
3&@e7S_4_YH(D2d/W:;AE2H=W#8:OaEV5XgJC[RLg8C3T)O\8;4cg5(6>=8;F2):
[8,gFa4MY.V[C^0;S+.5b1J](6d[G:;#B6NOULaW&Ld7?>eBMS6gHHdKc\L^W:A?
C7HMU@:Fa/b8b5L;BQZWdUZ8-FVF/55)03T,a3&;D]]eb5SL(58Sb6;P[SU:2g[,
XF?b.:R,^B8bAW?5?bJ78(MBbA5eQ0#5K04^dadLIY3&O+J^<L@5[Ld^MTDSQT<-
YE#W)V-16g@)LdQE/:W)11W>1089Ua8TE48CZcH-U1M^+\CA4@JU]F^/5e@[bCBW
EMPaIH[1>VJ<9NO5&SLHb/OVP<c]+@,T2U@N=(#fN..KN>:X].dTW=XI+(T?\TJ_
J[WF5@3d;VN9AL46TKBgMU(24IDAXc2f#?d6BR,Ng2>_-H;8;4&W,0^HPb7DRI=&
N2cV#^]+J]^C+Ce_FV(U^H,fGK.&2V(g8[S2cKP\c:3S@dRCP(ZBVDE9=W>gE/@8
3J=RQ,1CKAA:e/D#N+500c(7H;L+_:9.FHQ256HeU-GY]3Q6AG@_B(GDKK=,ReFL
H0O1&CR-:<JH+fS#^B,&MB>REg<@HVLVd_VZAGcf5<<;cBa4bU@-K4WG3_AJVFef
YCSN&4M9^7R^O^9#?5\^BVQGM[<+ZAR86P+X;Mb@.4Rc:4(PPHf,L_Q#5a24\E^E
A;\X30,.LggNS-,PU5)+g>G?CI^J<47K#dZbH)\(EG=@O-bXIUMB#+)b3(^W>d#^
E1U&@\G\O/WcGgBH#4d1=25?6N05\GV):/;0.Q()N^/JTdC,_GG;-_F?+4aYXWaa
ITBT<b)6C)QM@#7=R4,ZH-3HXD2@&V1=.WU[K:7E#e9]A?c<ZL[WB+SDNANK)BA#
,S^SI&=A;;Z&WD>(S26#CUYa>;f6&(&R6@@N0/,4O:RAb0;FFT7CdW4)2-;O]c^c
=KZ;W9RK-A9->\QB[5UAf3RfTQe]W(82K9[@EAXA[TDV^WK<4:N7,R3P_87VTP).
#QEbD-51[1>?&#3WYRbA1U@.__51XDRb\S/Z^+IVL5PB5?(ZZ;.VCI_G^<US&2Y>
fVc16YCfa-aL>eS[96I9HX\+gR0J&fV#>BEX^)>)a_Y:K4CLOXB\<_(gX:[[J_I?
R)f]9WZF?32MbQ-Ha0YRCQ++LP-;f2NQfV9@<9>3d08J9BS\LZIgfS2EJ:>YO04K
?=L^R3SOWfQ5TU=YXVg[NLY-e/?(,^3AbVYK?2Q,8M=gP3=JO:5\TGTfTdb5PB..
81IX]Y:GIHUO-_GI5>_;Y_K#_\]&cL)2)1WVUBaX<IU>=E&&DbD8b(INC:\d2/.fQ$
//`endprotected
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
////`protected
>C-g-,>J0C/?=#73(_aZ8FOE=U:d)?b7<GS<<<N>1]^/;>GHFIT](//V9RKC=BUT
6_QWaK<8b,g&U]f:5bUBKIWW?O=;@5D^H;PX,AeP]:G/JIM8N4IcRf<N>@29^H]K
]XR9faH4f7cbPLbQ)/0T:Q.2b=5b)[H>=N>52,_bd6BHaYU(cd]a2<TC0U1f76BC
Q<V<^IG5TF^LKf<D5F8V6C:g=?L;(4E.F0TUcY&3Qf<LTAb^>e+R9=aL=SE^3<GP
Qd.+0:#68^gcA3/Q#KAe<@283/XP:+BX[YMT)YS3N-M_1K4IPB)a5/-L,.R_@2&2
e3ZXbUX08P?/=a8gXVeNS,)f,M@7<L2b&7U]/<eT-]EZ]&@OM+d.J,3=^HH=@PUB
[&cWS;6J45\TG+HD@Q;D2A5fLX_R+C38L9+c(V^a4+)B[@K<PK[O7TQK/S2<#?e2
_+^f4aSI]YPVDO/HIM,/N/\MMCPa7e>9Ee+)4ZgIgL>Ka/?=eGMBAPK[9Y;ZA?(I
1M1<_AU2M:L?YUB7)FbWQV(+1OT;d\2[,(&CV1[RF-\.+[O[EZC[XKJ2cB@.8eSN
:-GaL(0\d51QH[QKf/EY(]/:#6:#LIX0EBc8XJ8,J]J_,Ff?bS:736T>07>0[X?H
7M.eMfG[R>-PNOZ/73VMAf]P])B#H?e0.R;L+QP=N6<gH(CS/++ZLbM_B1H6ST>T
N/5f7&4ZO<,ME\XL07Yf0&QL36d6PECWZ;L>J41TH/(;bMg/g?BF>5g3<GN07GSE
9MSb58A:0R)Te6W9]B/^D\#7OgJYegW^RZDV[GWbUUfHbE[GKcAUe/U^&+dX,O_E
T.G:(.;RReC)a7K(DX)HPJ2,PMaGN0LPXE>)PBbMOYaY<I<QMf>-d\KN6GB0V[=6
IMdQ7=c5a[=:T-35WW#Fe2&eV_N#8<F]=X#K4J]+G]?KD=IHD(5S3H87c6FK+AEM
?3aHV)<[;<.bZD#E__R^VXc:<?&QI&-D,A07e?7dB\?(=UGeW4QD3dc<V;KWfbOK
SW>&KMK^&(_Y\c&1:FeCW/DRI]##BO(SS@1EJHCOP(N3;b_[ZWKHJH<dS>0Y<OQ@
D1)]SDUM.VCR.8IGE=_NE<+d62;;/AdJW7IaL)[C.D(E\b\ZD.BI4W\>T&3>dfQ]
J98aU&gS+JS1RS?R0=TR+A)3/_8UaeacOHHX#Q-P./L]1:.D6#-7Q__8@_?<WcOE
=(]2N#4]BeB&^[73Yf@7O736#(W_fHVP6P(2cR76,+B=Z07/?<LP-RJR:aJ+f.ee
H9f<;LOf:-dKS_Uf6Y1c521Of(@,FdUD(M0XKfaH3(8;:5]&<2aE5D2bJ87W+]TM
Ec]M8V?dRW7/=.LJd.V=GC+T.IY8RDOG\2X&?^[V9Z867Z0f0:#.1Q@.cb=QXEHJ
Z>8Ld^VaI4(@>O#+gdd>EEXSUQ[JVd^CQFYXW5T=4Fb:THH<X&RYA^)[:S8W@XD-
a<6P:=gR7+W\P4[#)bQ,IR@=ceD:1U<H0:<<]C7gP<=3Dd7^_QL+5=0-?Uf>I>1X
B62\4Xd&@aV)O6?+b9cOcV/]L(5T7BZZPgJ6VAI]b?FNY&1>+ObZXc4P64<@U+B#
^:TQTV2/0P?4_1+T,eX04.,aS2Ia/Ug<(_:_:?[>eZHRO4V,+/IE>&9dg?&/M[a/
CCIBB_]#JN[b,g(C-:aYB8Y>T#(.a/I6>73L6-bS41;-=DU1D^_P5+/1E&,;aH.L
GU3d<)+\-<&afa(B>.CF)3:TO4FO(.b_:A9IZIgVB1c2SBO,90)1Q/c1SB[OIN0E
eIPaCM,PQ^I:-c.(EO-TK+F#\00a3gTW>/K:6F,+#&:aYDH1<g(aabJd,,0VC0=?
9K)HFY[_NYD5HAAYLa93,A6>/;EM<O>KPU(5K<V3Of..ZAH0;/\3_b99gY&=_QYU
MUgB/NWb>ERdZMc?RX=NP;++CD+.5Q0BQ39C1BW6I=/JW:b>Y#([RP/(Vf&([e:)
X9_d-4f1[B]+[)PN&)C.4E1&1RG5bKgXd>M0;UUX+]Z1_8c85-VB9AcM:_UX,=+J
.>Xa->-2ZV0@MY+Q-VLV[@P0Ue^XT>U\/@Q]aWYC@514A(<];1B#[RE\Jb#&=MbH
ZJ+a(;H[=4a#]7G440bTg3,bLDaUaYE,e_.86[RJDS-JP)Oa&FI=,6BQ>Wc(FJ@I
:9[^9N42)b(ZZ[LRO>I[][3X\DGM)_aN\We=6gHZDV;NQ44dK6^IaHT2][NO\@ZR
Db+HK]Y+=]\60gLH\9^=7YK<TIU]WY+WfR/8O:[GTb3/-Q\bSU7I40QdMMcZZLe1
3[MD0aa.,/9M_N=P7#T3(3E8CVFQ1Qgg-F:(Y]F9EN#SLeaO:J[P]b)>#;4>>I:0
2a7S3&^gU=bXY;N/2d,Re1QeTFd]VQa>B3RG8R4DWXU#H(\cYROVQ2)QbQ-F:>A,
#0-86)c&?gFKd,=GRdR>M@?6^./7Xe;9?<K7A2T#:/K,Bg6I<c?[:ODfI(T2ZMf)
M[I/K_SIN\0[#E,TN&Z#>Y?5?L>DF96/dFg0gXOeZ<I@e\?(0?_X3Q8HF:,4.bVJ
Y0]Q6XQ][SeHeK<AA2E2?)CfVC:;@CSFY>5Y,5K_2fA:8X=;f2a987gI>F7:/.aW
ab]Y]f.TC-\;KbNHC]I]2R<T^-9[,J6WTFCO)ZDJX9g<BaDf-<TP<,X3?Hf[RR3J
fdW^Qb2=\;gQJTW8\I&=VB&CVN]37d4R6&[E(:XbHS\IcVa_a7MKXL.I]Vdg<NbB
16cVfGW\LG<7LK6NL5XCCXCHYX:NF_&?PJ(^7eD^4/4OGJA>-<&78BJEN9;2,OW]
#?59Lc:ePF3\W6d<^=LC<\3IEa=4#=^>7<XR-=Z&AX)a/4@8AaJ7KeUECU[.&VIE
9Af\8<1YcMI@(MAPX)a5.ZYb_#I@PeH7O>I2gCKfJ56JTKa_:C<<M\<YFfbQ5L(8
gQBdCB;N.QW&=S38+f6-FJe/5(U4WC.aQe,03[4g>]K=:.S\[H6N@=K+#AE,C^Z:
cQ-7VU#6,K3M/1FcdRTc8TZ\Y>e(gRb9(;.MFdY@DW^Ce?5b=8TQU(),,DaWO>SI
.#DT3?:J]XTa5/8ee^1EQ7V[AdR0-59H3DdbZL\6ACW#UXP2&DTF7<S1Y1e+aR0H
-\[ffYS4YcE:ad1Wg8&T6H26U&=Nb@5W6^@QC_UTQaIG8V6gE4bQ&QW&]S#H@AQ?
V1FBLX\5Ze;5]dgPNb]fB]RVT)VW6HVM5XFX#VMaXReVN1ARM];7CXDJ(JZB_(\B
_=QJV48,[XKfRYV8M=COFTHB56YX@E+,dDda2+.e##g/8#L]aW&/]V4-dE,4>;9>
6^@?;df[)VM1cF,)6dA]0-#\d.J4N)W]^XCTMPZ38UBEQgc.[XB.-_4-L$
//`endprotected
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
////`protected
?:\Q[:UB51GN8,<f9:F[)DF0)M@889Yd,17N(2I:8b=37QY/65]>=eGc-_)Y9W,<
Ff<d((7:WDF9_)AL7^>2#R>]WNTeMMadG@Wf(VKaT-QCbVXc@<I+gbEBd/.b2#S_
J#6ICU4N]_d\L47M4b]B)>[gOWJ]LJQ_52V0YM]B3\+BFK3L]H06E1X[+\T^QX[-
^8KNge3(c7:1+bL,],(1/b1[b#)5+A>H27.=:]&&1bK#7-e(gE=<E]_[G>X2U+V<
>ZR?8bL=MUBFc(0OYg:A)dS(YL7F4<9=5V8:Q^0Z.XACG#ae_HHbLA/+<D(CK2RJ
M9gIZ<Fd#=S>b^ZBS2^0_L/O>gFW&O,XcH9W<P3YL5)E#[QUc[GHFE@2OE)\J>Cg
V.UMMg2H.>,ddJO@BffcOYL/b:JZ4/N3c[_5f248)NC+c\>5dIdDX3BdEd_\0[PP
A]#g40M6Q:P6.X_6&A+3+D6&RZGC<g,MX+N84O0FI:D7R/4]c1,RO#eC()&LG(ed
2g(GcWBb5ZX?dRLdSf@=Z>LIUW(NYCgB.+0=Qa6A28:W:WUR/YDCJ9D(E<BGT3dB
TQU3;c0Y5;6T\0PWdfd7\_-3<O2a785.)P5^S,H_a[F<-1f)MP_^YaeAOIBA\-EQ
?==)AKW4K^;JUU;4JTX5CG\;W>6-&LF0UaY+QIMeC5]AW-NZ+gNZg/ZYY@,aWH]>
>QeY2c#M,9J:e[G\^5E5dN^[=KNaA2[_X5UU4YTD,_V>,<Ye/K21JG\:J&G;BJX5
LOGGFG)A>/<A9FI0UVFSaZA))JcWMT^)b:dTBa:XgCf=e,,>/Y;DTHJIFXI3@A^?
\a,OBZ0.&C,N2O#9/-H[?Jg?(-PN7g_AN;HYC#VPP51>.3CB3e4fW_^VXO#DVG5Y
G&L_N,<eX_d:(,P6E3#^)+S68ROG](+\=XM_NCO)>6c2(eCe?3&_.:-P0;f_;DXK
<.-4Q&-[,^ZQI<96Je\H(SK-[CZ&4<6Y>Y(9CQ_]6[^)c8)7T,;9fa1AN?X23S4]
AZ9,TC_JG.S<//3(LFDW9O;BgU?4_VPKMR:AP^TW=)3bV>MWgVBW+]D&[4EMe,Hf
=)a9b@I@_fG[O:L^5I/O0?XY[-6CREFPB1=@0)a9@/:/&-X?g,7,c[?L=S2__L2D
;)QSZH/\P#4(@?a;A0B[O\T7b-E#+(1c_2\Ea;60RD\:A4cbddQKa?L<a3[8f<a0
E\-YW^,f8K(EWV_N@M;YKDLF7505;CDEggEM_M^g89W<]+&>6BacbH>SBRLC3/&g
cAD#].QR4:)7(QQ=0PR5&.[MX\[Ob&1##Y5)5c)U+M)A6Ja@W@3bO7?&_gZEP8AO
e/-9(2Fg^f(CgL>1E7WFU8.#LH_B4RD]EL1McUJ_^dX-?Y0[Y^T=Y;2,NP[0UJ<I
R^F+NHQ5^>e&U+Z0CB0B>cacPE9D>g:Be40^eZDIVCX700./I38V-:,b4[GOK_FP
P=;fAA09E9D[K=,[4+)Yd7_BPO5F;8&VFLdW\WS5,,2d6W.H89KG#R.LRH9[Z,&#
KNGM;:0S.13GKJ?\Z\2164^+WR_gBK9\-)=?Rbe9[TAd>F6UDcMN?MHRecd])+H]
/1TC>UTYE_<c6^7^8HQC]KMLe=WY.HX&(AZ#@I2K06<WZIF49C<FU1JG[PDKPCRZ
S5>8=JB7bQ?Ag50ELaC+b5M@A)Fa5fE9P.XOPCLTX]5XLEPfbGf+&?C&TgO2dJ,4
S\_?cCXX2W(&YP_K>6eI-O0;1XO8X(9&]F/3PWX@,VRV+T8;.P85G)Oe/0C6gW;.
JVIb1)F_9QW1\APWP7,6K.#d&]ACOYDMITSA#J(bP8.d4LJ-5D4I573g]5HD/X0;
4c?Q+(-fQFDAZV<+:f@;P5:JWLfa0)4R7B\::8J?K&S10(1dKSa.5/U:FYEQ^aWQ
BQHgN9:36#5(SB2GeS5G+V1N/M].ESdG5e]4(W&g-:1#UZ-E-J95<MSSW1OM,27P
QSL)#]94XBTE+g.B#g#-.]7#bcJNK;&e0Gg.VLG\XaIKI/ME3,XA0JcYT@R)2)(?
Q2KYY4LG4DE4IP^SWZ^]9-D4=0P3&:gLg,d2>\1f,LKHP;^)8.H(FL\/D1KU7KfF
E5]5X2?ING+W@#IV,T86TQ_gPZg2(5>eT^5aHS<EKObacA5C>AYV1Z3]:M/8gBg\
eX<F2K97^GPYb02D][33OdXZ;71Pa=QXC8#/Zb8X9CQH>9F8;S,V.3/:]?H&E316
H,dH1/OWK3.0^A&_NE-UT6A<Ef-+4L7A@OUZP6>c1N/3+@=/c0N<eb[D5I)78>SF
H:/e[GJc/,,D#(V.345OCR4cDI:^6D2J]8)@e,U_:7Wf0#VXKE)ab8K(MQ;U#+[7
?H<,?Q&[6/gW19XTXGGKHU.Kc1CZ,H2@\ID[4AEERfJG6S2G?QDMWN;?ZY:PIR_B
H^Lc/9<UB70/X_K.&5M&PC@_c6\e,WJ5.IbIb,V06@^E(05#=Bb16;6:Q8T&-V36
)R;WO,RSGU+4XGbT2^b,>Z)S5Be#SXJD&GDdOIG:>CVEC$
//`endprotected
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
////`protected
Gb_HcCDVMXXQ9W5E<NN79GQ=,=EW)E0X=S(6,1<69.JAKf5cc+X:)ADD)Z=X8@WB
c1TYg_UP9D(S,f<]>M1X.C1J<=^2\^b^/(BS0ZSU)Dg(VbS3##E)L+0D&NGOKANF
IJ+>+CX)6:KLdK=2G+cHC)ZQ+ZG2,48aZT:#Ke@]FgI#VPLS\?]N=(:9C\WM-H0:
_E&^Qe7^-I3&e7P>R:8cWQ;<\3OF,S<bG2.Zfa7>gKWKF6GL(^Y[,CJH^VgI7CEY
<O&8fD?d.1ARPPe5#R=<1SJd+3=:UG8.e<2I/OQ][B,X]X>.7WKK@a37^2^MLA5>
DPF^OML23D:2[2D8[T#6HMV_9__;W0^.DFaW1NE@Ea,ce?0]^#=dZ.e52YYTJEAJ
T5+ZEaA&[0EF4-J&2E9dRN/RcUBEG.<=\;_?+T.9R7(8:+\LZ^[dDHPa?W/<#>VE
OQMIR0b=&>Jde;W(JDfBFD.-f<?T_d:<]7(:GL6X75eXQ3[9R0&@e,8=<Zd(\U)=
W)#6Y=OC<.&B#WJ683If4^[@#+J&g[07]I6eB=PDFPH3K+^_cBfI&7:JZe5B73fH
cNT2?M+Y0P71-I-,[AB:A)YOYXMV6W1UZR\gB\F[&ZP?3J/7ZGWXf4AP7&;QgX<8
FHKRKd+ge5RT;-/Ye-5V/7d5G8R#[:WO;N/WbRQZS=WSJIdLY3?aacbW<]H,EF91
.)L+a7,RJCJV/9_0ERLQ.DP&<DIBZ=O#/2@1cI6N42-8;@RY-ON(<-2EJG_MQ.CW
2\L>;\O9fT;b\>(LaYK9\>HM7-8_0Ic)YW-[+0DU-V:e^P68RF?4a.N_7@8c+(9T
c5IVC0O6>?25f^4W,U7-T^89#4.+\IZGIN]_WX0?B+ZCNYJLI4RSK)KKFJ<#\;]C
(Y,;N^+&J6dALO;))/R^fg\8DeN93OcYHIOUV=3g?DA?e-8ED\L:1V1MgU)4-0?L
MED>]U#0ORLTBa,0<X1E,[d[a9@;ZNG3QYdY9/SQQ7a<U9:XHfBM@McGfRL^O.[G
08/>.e^6<bR3N=.fHcZCHA=1^BeM^(V=0CXI_T.<NF3YS)#1eaR19>_Z5^8W]X?Z
GQR_Fc]4:IU3X/AA/;S>06eOE</Tb7=B+#.TZH.]6OgYa\O?0:QI3DZ)KY8@L_fQ
:A:93QU30Z>gLE&c9gSG3:?+d6S4.GW4@_(&P]ND<e]-^b0F7Q49(\+DMN+eIZHU
de97O0Gb6D5FDCZ,EC#6V.CAa1[5R_Y<SBfLJ?/bWQ981D)U77Pa]W>R,);d=NO6
c^T8K.Q\QIO6=]\W-BJ[S4SEUO&Qf)2?C1KJa5Q@^MSEE]RHM>MB?e\9XJ\07X[f
,HE8JXT3A0CSVYe4Z;>MJ1)A[()[&+EL,?-M2:N;8FJU55Fb2b.D9C;FaU.4^#>C
NFGBaf\[=D=,D0-f;HG+gYQGCbTC\_@G#=gB@c8Vc4VBHIS63SOc1ZB]cK<VbR^X
O_,B9f0]@UPC(G6dOEN->5>.YP=.Re8b;R?@1_.K7UV.N<Pc+\NNb&XU[+/DCfMc
SW&7/?C(_>CTR>N6]bVb_S_dK@#B&)P=CZYW/g+@^6H4IJa:FHN(O0K(F+=_U(b-
X#.5S)0_D^KR;@W4&N2]f;+.BV0I0:?e^cF[WNV@IcVHLRePG(XP^/F(O_VJ6d.3
OZFLKH+:.)0b3JLe3c[:>Gb4U86@Bg6DdOdK)SGJ=2>:JUM=PD1.&=bKE4?2XRcP
=WG75A8?<gX[(K05cBRX3D8#4g92#58BQHe/&7XSC=c;g_^;X3W#U13T]6<9,+Fe
U5MIA3?L(6-91Y5CT::4AJS=,EI<C/M^H^\3?]a3P+.fB#0<4La?SZA>P6;,b-^A
&G3+:3TF_0<]TA2A\TP\9I.I7?^ZKOQ._O?V;a_0#faM+O&MOYJUBR-S+YX-LC98
1S0.L<G.NK5UbP5[,_fO0gL?\D4#-7WI8XOZE+U5S<2::F0WKB;d1eL/F/@.6#H[
KR&DUd<,_X3I40G^@8\Q+BQd2+7:LP<ee)a8;5#eC,DVH-2XR/g_K4MSBbXXWZ3Q
57276KXd;OOM3M_:&,&)B#fS\@2_C1TUIH+Jg5A[VK1=3IM8D(.cXE3fSLFPM2H;
(g;.Yc:@8]J3XU0F,L8G1UT_WI=8H;S<#VO\[/7A>AS+BFeC]28.&f/=>D5\dJ=U
(f]1B.(\D19IG&BffBS]ZK&cf+.L:,S]C#dN4a9Sf((@LBKKfOR^)B_BfKf0a.D[
5?95,b6,&\Q:=.gKNS@Q()Q9#N=RVR>3)LR_:aI#9;Kg:;ZIc(;a-C,_S41WB?<f
ga@YJe)2gXLcY@E;N0Qb6@3C);7<a1@\[Q<_DaB?e8J_7&^7S^FMIF^4U)c-d-,@
NBS9=SG-IbB&]+W7,L@7-KHO98[4;XTLNE4U\Q=f]PJd70<:(b,4gKc>HM,HHg+3
CZ+(VIH(RI1&eaMATKb2=_K+[&2@X@SN8:8&JX38G;bB._B(9396VgKK0^JQ&Sb6
^YE_T:>H5&1AR#U2:eH)[B)T=B&(2+ZdA-S-fg6L>PF>9,a:;+b)^B/HMT^<+6=7
?D7Y<Z#@WRc+07^:I6W:UZ&c2DaOSX6Uc85Mc.(:b]\\5_&TN>/acD+C9-,VE)Dc
f@,O5CNg.Y<E12-Dc<_D@/8>SY)W)2OAWL[8b.EeMJ)gf3JaX:3aX2U@QSGZ.[R@
eSNY7&59IRbRACOV_W7cN0g<&&()SS8B>OF(E9c;e\6YS>]Uf_&d6F947LfKb#Ea
[E\8D#]]b_.g:.UDXS5aS2.=5a:Eb@DB<??PIIgJ1+AQPQWJO_EIUL_]/<EQNO.?
a]K15Y(#5e6Ebf,b6cg8aE5ZIF0;X(c#-@I,.eV+2b;\DU_1B<PI08HefY_008,=
MU:Z()fgeO<Xf?Z2J+,:6]8O9YM@[#<8UGYD)5N1HI,KYfO(GU:a@8;YPW-.e6LZ
B^O6#X[Q7e[FTHga(d<.>1C_YCJF9P2TDF.Z6eH-J92=B0QROdNJT]3a\WXSP^-2
+G5&?dc^D2BLcb@30@VUgJRL#N<a:T7KQg5Bg)BI<g<?&I(/QV]-U.>0.NM/e5U,
PHd@\=-ac@NV7YAN84bT#d@H&33V?;:F<.EKT5H4:[,=A(FKeATYX;fW]IS_2&2V
TfE/T?\@/Q:Bc@;?-^)[_d0OJL;,de(0_E7Oc<LebaMG;[1WCK-MF>CTMb\6^>dD
\aSHQY4LT.[]W2OU:<M7gf-DEWg6OY=NY_-bX&R+@)(e&cNfd.Q;=.9GXQb(>,V@
8PAfBFCHRZ&IW?Mac]^8H.VV66SAL.QWVMBaSI:1T.@O=g?3Dd)JQ8/4J_A_,0=.
Z.\X5FK]cgW=0cFU:ALIA8.)4&G)WeNSVJc/bB6>SM+?U7;68Q/5+NT]:JdD,CZ_
CAX_@4eE#QLH/:TFTWZ[EKg@b)<)Z?N22>IZ>X/DW.Y.4L0MP(,HI@HU\>DS]H,[
,)ZZa]Hf1IagW;ZDGP<)a06LYagb.WTOVOb)7&TSf_Be<08V:d>GEPb@g/a[Mda0
#aAW=-P\[TP2JED:(1Q.S:AU@L6U5U@9?Q=?=JN]d\^-V2OZ3>Q<Q01F><(EI32U
&gO;57)D>K[G=dF60#OR:RLY:47X(XcZOG3c3FcJ?R7SU,.TbfY5d\6RUDa#f]Y&
L(Gfbb&)^7.?:C,6L<]5C=@?)@6W#PXd2UOPBKPL=IV;fQ<eaeBIe][H6NTEK#L_
H>R]IX1K@-KfV.\73M0GB(&dJ(gBAOOAHAK>->/CS4]S_19UOLfV@5#SGa^;F\&B
2>f3>#1YcTR5L/)E>ANG0I_f#0Ee[aW#;PZ(1KFgSc]FA9VIadgU<./MD4HcG6ZD
#[@P7Q_(<[@4,V2KU(;56Y[QS8f5,QR8&IgMOKG<^N3B[5_HMWXF)_U8W&]M+]d<
BfL[_D4M9TLf_4G;aN8aGNI0-=K?c-52/Z_JDb[#bEedV6J+21c&(8[L_46e&.7D
V^ES7dY4bBaP81;b8TfAK_I,S2P8>eZW<2611;J-E<b=#7?RGYT5M\R1KLOcQAV\
K7fb?6D/YNGBJ_ge01F==3-VE+][8;CgKOdc2ddF1[Pb^.HN\O+S.Y4;@Zd4cI3/
C>RH#,7dP9^)Q.-.RRYI&VN;SET\?JE6^AGe4VB+?,FF:VGf@Y2F>HDc[8J]&,G4
)1bDIAQC\\JJ#4;):=MMWJQ\_2#T,1T=8V-=[#R1MaUe=J9XX4<fBfRJSJ+(#H&L
;]CRZ4ASZdZA3,-0V>c@G-Le5I;,\DZSgZ&61VQG#eL]/+aW.3><CX;Xb=2N4OG_
Oe>3JSPZ,2.XVZVU-&\Z3dGc7_RF:0E4-C17VRF)8\B42U/XAQ4B&_Q\:M)76+VW
#/+IUaW41G]f&:@M#g<NJb(K&L\5(JWc3L^K]P-A6RO&HW6ZJ9XH.,#3>(@?-YR:
SJ0ePJ3:7UY#-83HF^]OC@-KKeL=L4V]K@a_O@a;G1FL^C9]+TRUU\fLC8&g:&&2
(5V11A/2dNF((L,d:/6RQC(fM1X-V.WfX,EW^;YZd,D)?W(2a<CI<I.Ad7WMCZfN
/Oa)[eQPS1)PMP>[1&@(.ZZRdceD6(G63B9<9a1/GJWOPM,6I\g&]L:<K)PTNBAc
0WOfSZ3):77@\?e-E>0dS:fX]OQ?_edN438[2YUON5ZN^aD,\;VN&:D.S[T2^>O4
B:>8=+\X9Wf#,Id]Fd\1cTfDQ]YaeT6-dFZRR/g?dL/0<4WC&FOG6Q3eLQ;GEa,8
T7b1+(M<Z^]4,=(JfN7IfA:b9F[#4RZ#K9211Kb7UBI^6->D?g:>G><WGB^Q(a7[
\30K<#U\C#/F^.Q9?aPY^#SSJK5;IVLYfJYVA/g-Pf]-R@1,&/LE4[9Sb9\Cf;_/
f5S+A?CNVO9c=(L<HCJ:/E5XEH+K-<e_C3S>_dP,9NY[_71b+2V[.P+FRHa5WW&H
L0H86[H-E>6R6R8PLT6ND(cBd-2b:Tf;>4Ne+BBdC>#&1MM_7[>2;TVR1Q5fdZgS
_2B0/a+c2S9:a^=d/d_a@++B=YP9d/]+/[H:/B@&K#6^O4J/+)VU].-KT_d/fYac
@9H7)^AE039Wd_I014APIX=XP19Q+90F.)7952L4X/[2S4/TZC188H#R#EJZK78C
HX@X+V\E,WY7K1<K_A2(SZXbIDO9LRGa3HU[JKJ=A(C@4g8g:ST(<KZ6<EafVN;P
:-g6YbSSePE:d1^@,?A;S3+VNbONV:YFbP6^X(379cd(K8-.a3-E60#+X638a/=#
+),gf-e8P/R0;>ZIdKBY,SPW,IG2aX.O9d6cBg)eYJX/]W(O_&NgM#T#,/1]e<CS
b-R5<4<YI-6VWYD49&,@eT1N.5U8[WK28a1;:P+GUEQP6HaJCV7)YUQZN(&[[F#f
A3&d>](E^Wd?#Q8Rg06gX,dePIgKMfY\@.Ld,edLWZUS,6P-+Z(<gP\MMZ^#\I@H
Hf\XFb=WW6@K-d\MeST6JG1Gfaaf07ZcX8^a+JF4aE[Z&V:^a&_dM^X1>BXE3[W0
A;MIX\YU9I+6D;L0;940_[TTZXG_3Q7FP#LBX;9URSNO5#QG1\],_1-OJVD?<L@/
[;#_eY/LcMN+>[6&87VCe1Ra]^fI_;?\A4^Cf0eY3K(_&R-.450C>BW,3Z/TU5]f
>;/C\C&L)Ld@KBGFL[&+aCPYA4Re.P88T[^[3?0gOGf,Z88+B@[0^#^D2>IIO6N\
Q4X#H;WNO.GH-<KfZ239O&Yd1F@^<6]bDK+WD>H&T4ReNEXU,R,Y.5^DJ$
//`endprotected
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
////`protected
ZTDg1NO:Y3[?I(YF=bcG9WIf9EUA9-G)8.I]=/\O,O([VL:.ff&F93BK90K5,[+e
D>MH]2:f.&LY2T44TU:20V]Ea,L@+a;K4LJCDU-MYL&_ZHa[9S&LY/bU^T0\\?#f
]L1c[&CS2OEeX6b4OdM]5X0aC>[gZZ#U;O<[TSHMS?e+<F9Y#C_RY<QF(64e<;Yc
28-Kg9#R;.M?P+KF&@>cZ)4RRdGb9^(Y=8\JITNDC@M>1dX+MCZQB[&<@H_@Z[gc
D-@fdH=OGAA)C<?>Y]gYVB?)-27OM+D<:L]&>TE@W@GB5A&>\P]UaKaCd3:8L&c7
<)A;@)LJ/6:>Z&E?KBcRd3Y3V83Cb478?f>R)Ja)Ne@6]>S)W4Q.GMBA^@6?U9OP
I4YD&Q3g<Z#RO2#(cDO6\L?X=+H[J0V=7/VaWed(F1Vc8L.2fY9#G((Z,<JG/XG.
#Z<Dg-Q^>(?EV^.((B;GgcJM6WADU0:_bcH^MH@e=G[dFFNY1I8dCAX&.T4FNFQW
BP:G-(EM0bM6>>B<@GSeZ_LJ;C#F7UD;fL+XV#<F.V\bL[(T.44I.N.L,9E+1@6M
^1X;[&1eE@9/=?f3_@Bb]TAEc0_\ccObXc[>]fDKD+DP^](\&gbIF3\1^e2BK58f
2).TY,Y[K?<PfE:e#+f<KS:\N)LEHEeN8_][@YCd9H42,[8:QUG<Y#S/c,Jd=>S<
a;V./^2gJ))Jd^E/+.-c?&;F_O6T1#)c\Q[FII00Q(SH^_7A6g:bGPgN?U0N8I,M
RZ_B^OG5NOM#abX\I&9\3J]_Fgb(7VZ.5>)C\Y2D->>MJ6fRA827Ae8I5#P]YBJJ
AVJFHYb05_7D:&^U?b>c/,eN@V]]c=K07P4?Z/B?1K,A@(N_=\WS>F5E)QQRb<+5
1PWHR,SE#IIT(D87C\K.T1a@P?Y5]a&EaAK\0eRE>)GH,8f(6M+Mc\PND/&F_XT9
FbT_TT2]59Vf4(#8SG9VHH;>d\_DE(==JF)A:T,LWAO5GA8_<H3)-U,CU;D.O5<U
^_fB2R5LN[=G3]U(;\3=c<8W;R^)#<[4?U[LYS^0JOdIMZ\aKc@fPM)&KObe2O0Z
6B?,+gdZ88ATRPaPZCSB_,(fGaV+/:?07H5Q+0_.f@:OJDbI#5W6>L;;]-8NGebJ
:,QDD>.J/>B43-(/Lab_LK&]@fNNfdOJ=1eE_03?<HL>>87A(CcVRdODV(0Fa#WS
/&&/(K(OI(EGDGd7=POdVRc)>7UOH2Z)U6FP)N-H^8MHK>f]e2E+GP<A0-L]3WE1
O(M^(KBY#_X3D60ZX5_\eCND/1L=N@MC6)=AbZ1f?+TY,?g4?M@SPY46QM<PYWPI
VCN]PT0<>W>f^/^fBV7D(-FJgX):WBJ=)PJaNKaRX::LaK3[K]-P#\ET<H@_SI.b
<dDBJHD(K,Q\F+^+U>_<,Z31V#@Og)aPDW9[1ffR\R(-2\;-AMI4g9,=]9FG#@GD
V1JbLUJO9\9/<SULN#J?/HMOSc3J[CR#^F.8^QBDS&Z>8Hf?gB=9eT/ULQ1f,bJ+
1Y\Hc;K(g;#CGWa:WE[fK\45&5QA7dX8a8&K7SD,](-c?Ff=#[<5F@ae48BU+=GJ
SZJd>AP.:4:/]^BH)X9?E)HaJ50J#7Z(4/0(^3PRZY2##>)bcR+7=GT3R_SBG<:?
=<egRV+V?XHC143?\<=aA.;1.@CB(-6Y.-N.JL9;bR,Xf#ab+.Q79G2PX^>-HWcA
QX)Ae)LVQ7^9_4IZLg3G_6#].Cb@gQFB3DNb@=S]eJ(PMP(a]P#@V9+W73O=3///
C7:5Y93\Sa?G^1#=f(:Db4VB0,Q,_H\HOPD;NAc3:9c[XANC,>cKYCT0ZX0gI09#
41W_FNa.;fL.(a?H2ZX=-V1;<)DU1X\O2[bU&/\>FQ1=\@A)&R;@(JOc2AL;0fC:
XHeP#VIR5JM(I^a/bNER#AKZDA9HWI9\3-=5+bL+Q=dUBXT(SD1_Ef1P?<UO9ALN
L7bJ+-U@>ZYT#U2-S>AbU#8(/T&)4E.J::42O-EN7/(_U_f8g&8MI@ea[C;>CR^/
5d_R]^+YK.(YX6Y7Y(Q2,H6?WNA#TNZE9KB\Z1<1\YAH.DKXf<AgSB\W[7N71\f^
E2eFSI/4>cKL5X,/6[Z1PLIH-PgER>JB_JV:E6B9)<e#f\(L/2ELKA>/7SXa)SZ3
O_eW)<C.AT6YP8I<(RaS)(-Y+_T>Q@^D-6L3<A<;8J?/G=SQJOKgE=XNXf@)-X5:
X5&QFVb#]=IY0$
//`endprotected
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
