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

////`protected
<65I2SQ:5DT^<`@Rk:IB8\YO2ekQnkIUmWQaqObl3?KWa3dJ8a^o[SKg?HKSH7cb
`KG@1n9G`2aEc4UCp;emUTE?clDL;mRDDeMSYUOmgBk[D8RUBkV2Z8X\M7fL1N\f
9hi32L@q31:LLmpZHJ1Hmp9l73<>EqSkhh`HhP\Tbc?jlO=g2RfgPVQ?4H@]BaDH
Dncok4L6E`^nBh:5TT6[23dD=qKA5GZYQdc@35R:[5gYoN1QD=6YZNhK\N7Zk1Z3
qa;^_3;egdX`jZNUbJ<6Rb4MQ;nDBE>imhOq4Q0?1D^2KEc8RS97kmEEkCV[Gk>;
U@T2?dLZT\VJQ7PqN0XIi2ISn3?b;I[S[b4q7>aLQ>NRlBWhTW5`i>RCkE^b3]iI
R0CW;];F?bGLNl@qMQe6SDaX7i?CbeG:[KKAZHDJC;Pe4@0nqXPXS6C[]gkYaC8e
?LPQG8=P6VW?PVLRj0dpKlTVIHoW^WdiPG^SnO1i9n@emR4;Rk`qb=1i=573JZJ@
CU`b@G5EDLjNXIXBA4X031G2PCHRc2o\ENkkka1PRif^L^T[dg<<=J=0m@UGp4ml
U0]l:RTO@N6MF:eD]cK@49>9SWIXbEK`k:S]Y@m_bAEchB9GW]eMCS9q6W[W5kap
VYUVM<ETjK[U`kA6T8P;00dVhH9eoihTkJObpJ\di24H6g[dgabCH^I2l@Di9AOM
_g\0ICJ;;R5ZkdhFXp4WL2l4MpQ^4FIhGf`S6m`TKhL1Bc]HXC43GmqC[dZ^;?PK
aOG53IT7HQ@FOkPkj[N?8QEC`C;Q1KQY0871CPXJ795I:oKqQ<F\>eL^cg@TlGhg
^QS60TCWb8@AdD6:TaC=31n^DoUZ5Ic<?`RNF0qPk7Nk:f>?>i=@dMIIP^a>A6g8
Vn>Na>gSJp<\<Xm=WqIE<h7Y[p4Gb?_In=@?OknF3DJ[Wh\^F5N:;mSXOQTj@25\
JdpC1PmlAIoe@Jo8a?Q5fIQ]S_6[dg]?MBCRATVWL_S_oQkIWD9XcDBR=\1dRom9
CFhRVoAf7WiCbR]oI=AN@K>XhSNjckcBlOnMJTB9=nEF@3jfCWi9lq:IHjn@U<58
5kWN^0Y:@;WGH;jTFOfJbj7hUOH4mc<3Eddff3mT141L2mFdUBp`7W^L6RjUI5F<
4XnVEZnA39`3]8LM_ZP6U>ge32PcERKEMQhLPqMES?fnWINb0idPccaTN0@ZJDCQ
Uc2f03eJUf7dKI]9h_4o^aAgL?pdgbFCI3iE2FMIfOmf8:j4Q=<^4^F_D<8j]bd`
eC32Vi^hOc<B>MdOLeVPb7C@GM]pII_`T4lZB]CcdWe6a479OZjhffWY1b\=P<21
`VkabMS9J6X>iKK1\HdTf]=qHHm;3Zc\kHn?IE]1MALb_Lh@nMLH:cqJ>0_dDdM]
gJ^QQ7@?SMf\TE:nkjT8=PTW<W?h2Yd]ld?84;[n[D[fKEho`CUXZfNl8]34:[k5
6PA5Q>T19qS@AZ\HQ4AY8e`\i1[Hg\kWo0OMQFOIma`I1Xn2?oYKHK@DDI`IS3IK
IN[[n4_9VE58E90jk_KlY8=5i1Zoe5Z<7eH@aLU<bk0mZM8FfA^j0nME[p^=@Gmo
3Rg100kk82UBVON07[d8OTRlPC1@XZ^OO@7k107OK9FL5N4L7;87lNG?clqfYClB
cYnK]T4B[RgE5Qm4@0piTfVbgo;gEWgP0j==^RkkC``2Ij<_ZTfk<gH`E>M8>A29
gULk]`d:lL[FJhkC\CH4eTL]hllBiP?1O^oj\G6G6RX:;D6hP`\:6XXXnqHY:IHP
BTEZAT4JD>QC1_I^EQ^<::eY@RWoUb=\4>U9^J4Q<?16;j90]F2<XfXFaPRYocZ<
J4Hbq16f2=bZFbAF8U>Hp;<;JHNC`aEg8?efmNN6oM5CPEIijD\XdEhUd]i<l3=n
:cVG<hPU1nXp3:]FghVeGTm;iD:685aZJA8Eg@?ASOm=[EOA]9qC@[QNInEWSO4H
oQ>;kiUl\:g;L6BoS5d2lkh;Rfpoh1]nIOfd8EV=DDh1jE4Ckpe\7Xo:]IaSLF2>
ZQIiXB7diqmfemYGJ0e;nhID<QEUGh?aEi5L@DqH4^KZ]\;`VW0X4N8]\^iCB0H]
DVBX:G?o1pU]2I\E=AoKSiK=<50?p@9cV6N?JNZo^g15_:\fqkOOAjcY08ec;eNa
_XL?:gLiKl^jJV_Z:D><pG9_b?I4ZQaS?Fh9USm81hmdg>Mn1RU1\5Ck?Dbmo2k^
1c]RP<ZmIZ0a>KoXaqO>hKN]Hkhdg?Y2[KS0CJei?FD\o`C1Pl_UleHJ1Io[fgI7
]Hk8hc_B4;[@km;03@_X?:in4Y]EXoh6q_1JHN5`E4akEW=2<@_Kh>H_on:AZk7>
eaNFBOGR=;V<kd^i9;Oo6\cUHN1NZieK\_^8TRQ$
//`endprotected

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

////`protected
X=Mc;SQV5DT^<<ilXWbSC^YFQ3UO6^SXR[XDIN:gd6nF;=gOT6bK?89`YQAa8[4U
?EqQ^I19PE]EmW9574g:\KKl?oYN`>0^eW7G0qCRZe<72Gl0A<<e`nFZK6J`ZEOI
RHQME;\dKVFl_]kTgTZ1j=NgfpHc6PnDqkjI?VnCnRNG]:Ki@loTeL[fqZF_3hW?
i=_Of[Cb:jL_k2XagWXKdo`U[kOi;9nLdMM[4_R\p=C52fZmj2Qoo_N`CT6U?=[g
9U^HFnK]?ZE:oo1qhLkTdb\;^>WY?oqT[g3d^p^Z:@jPP]Z1o0EfRj52T@b_]CR6
bpA?dNHSF8ZJ\j^C9qWRX1Y71n?]9U5[DMYHIdS5e;kl?CLSa2L5>93;pb9F^5BQ
gLTI^KdCc<=?T@7d>1nQl9m8:AMX>KXDZ_7;G1H7S3FI1lD3AA54M=Ebp]V?DXcM
j7S>5[cRI1T`CeZNJghYHdmi[8CpdhDfIKWqB>5@^:0m:EnUOf]HFUVd0meS<Xj2
bfPnQ?cGF[=7Men75e]3eDTT2O5m<jEZ=V^pF_Rhb<qk:N^7]BN_=3kR>mTNd<Jb
<QYb_^PP>>qiBBm47lD=kebeeHSR;<JU0VAHibmIi2UAiSfLK0q]`>m_<W;o;COa
2_[iAXBT]Zd\UldHde4pF=3Db;3J5IgZWlJAW[R17L>6gF\^0lRTi30PHP94;49Z
hRVbmlG8GBKj7KIp8=cIB2qXj>hS82c<`IANkP27eO7>>H1p>JR]?gJgI\^@Y;I`
aiD<`<JNXmPaS>O_oF:RCk1gIcQ0LQkiWg4gacpIdKb[Xc]`a[^?_=<JeJa852AK
NW=G^:eYG3qg`ISLKp`TfV\eRpQomINo602LCZ5CCWF^2;TF6B6T7C`EDmnTCP[8
9Xe<m\WnOYIXn_PQqkTYVRnB?P?Wfob:]ka5o<Gq0UYAB_OWD;T97SZS91LmGWSp
Q<lgEjAc:aoGS?Ve;1:c=]I>GHX6::lJGbNH3b>Rq75Y\EK@JTJheYmBjQJ]MdHL
p<Daa^D8V\F?U;D]NRnikYi5p`:^jg5?N=jY8Tem?<e?Ce1pFG\`7PPRO^h\g5UX
ea:CG1qe\n2Wkl6Ba3Na1]E``IHEPlIqiXRXBNMXX_lQT9lD@2bO\9q]YJccY7ib
S`VUh>;dfn_1]_:B10qA1eW\[B`VWaOib]<A6PFW?AP[_WqD7LK\6>gSe<[S@oLP
oj`A<:mMYgaqQ4ANGJ6nJbn5EbH[0<8LCUWGQE=8qYU@J\5jIKSjIej4jO4`^hPE
jQ_^qoAnP;[Y_hAGO5;OH:Y=R8<aieb]V_@Iq4ojTNNY[aNM3j@96C=>HC;nSih[
d^Ve>pEAjZm2C5ndD[lncKlm5FFE]:a8F03<9SKG76THOlH=<3?Rl>mD7ViXHCpl
1Xhnh8YlQQ:k5k[I\>EWibTiKHWpjL;U4_h4d9:dPH43l?:gdFfc8aGaZ>]5U:^m
91N<ML0SPgD;AQ8e7S86N[pj8^dR>?gM?MVi5F1g[8N1\MXoZELW8YTLBqm\1dE3
p4DB[L6q2Lj8H0qOK2Mb7p[8\6@X=W9]lAAi_^bhK100qS0>CB@_AW7;YR?3J@>:
7NY<?jg\P0Vip9@3na3bKOBG39J8kgI;\D?h]gILA:ZNpEV4i<ScmYigo5I40ej?
gD4\Do00UfRq>2<d?GTW<lW6SHC8LoZjfSEfKmK7P2pZRFnkG3kV0BeUK5DPlib>
\`VIA9Z3]l`mEfY:ha\3=kbMlqU8;GL@;fWo9f<Q2T5mgqoOAQgTq6M24i`qXVF;
``qLn=gn>p\K9mFa>Nef9X<KgjHDF[Ddg8G]kWHRoqOijihP_@UQkcUHdZ_4MnB;
GGWnS<ljLjE7p5l[<bSkcPX^X:XOo5N5bkc0KoS=R^Pbp<=9l[SN;8Io9\lH=9_Y
KH_l7ok<2m`p_gT6mkGIH?j??BkO1m`DQgSEQZDGBaqKUJcOWhfpZS?0?:2pAN6V
bDq\AK0N`Sp^U407TC8W<k8hM@BV2IbM`QR:NBGOC9p9GT[CeDTW`lD94KRI0\Ff
5g2<;d8ORbqFa>\QSaL`_Q[`L^TU5GkUn`;eg1J`<CiKgFZ]A;7PNbm@1:\Sb7gA
`EXa_0Hq[0VC^eGBdoLI4^U_05hDMkZn^Fk1LcqQi?jRYEmY4fNo;AG7JCa[]3WW
5\h=<q=G6Q`?cpa`B`:bp\N2NeE6qN1`a_biS0Dj1UD@qU8L@4`V29l7eHdT4kGa
T\VB3pZeV9mN`f2?P52cSD?50mEE?7e_^I2hqGAVAbkjC\[V7JMBkGjB8gk]Sj6;
Knc?DWBpk[>HL<VXgPO0cnJ?;aM`QAL>JOX<PlIjpS>d<5RIDETk[D]Y^B?60f]j
89Ob?J]WXU_f6clhqjTSCH\G0JgIFU\WTlI?dkUVRR;XBP28?Tl5VaeYUp5BH^LZ
6A212:]oiB?mJSFCT[Rj[_gBThJ9=N=Ac4FV8kd0A]5S0Ao63K:;bUpBkoN`^]`=
m_b]^Im]LXMYMFbNHo7RY8a8=JIph^^POo]l8lhmV8RWj;jDZS^El6l`9dIBa3lD
p9Uf2H`jDEl0RWGEMj0^_e8e3>IfN0Icg<5e8qOC8nPL;MjEDOYDCiqZN_`BF3I;
eG`84E8O1]>gZA4?ZP0aEKh>C@p?o>V^:5[dcYJ=8@Fg5Peho\_N_EKK>;REXV^W
Ug:[NlO;NB=^>NgJUi4p4ffdbA]cdgdi20aODWS3?]A[LTJF<LIle1ep0bam3SCq
fUPjd;<XGkhIimA3SdqkYaLB>Nc884@YCqFB\ek>68n@G`B80_9\GL^9RW`V]eYW
p[]IW9RA_HM7>nZchk6j:h\`m[BRgJFGqlP<=O8933Ym0N0bggNSoief_AU]=Ba1
pfY5N0AWq0LcgN4;=l9<:[:PgA7p5?2`<^h35O=BUWqH?@00[38GI5;E6iQd=Rgg
<RaEEAod_`ECelpD6hFQ`V^KR@IMkWPMj9nmIX2`_FO4kjJGC:=qZVOodOlcA0h`
SMMpG^R^;hLD94_Mgm23EChUhjhI\fh:DYXaqk@E\YgnpOb<OF7Y7GThR6?015n3
mScMJc=8^BMFgLChp[1>@4Y8qSfVGmf^]OY:0G\2HOhQ]8Y0FiegBH`DfLAZMX<e
jiTU:\N^=oG:R`hWMUmYM]ZCD<aOZZfEGc;:^G:XI`boZc3hip9VkK=7jEg:l7\b
RD8lAB6RqjXo5B>Yg_j0@Qd3Nqb_>NNQ;CRGKP6lE^lRT^8RN1]MdEqM;bIA^9fB
1l45Q[W_AqMDWCNVjG_bP5Rjlf6X[iGi`Eiic@B?5HR;XpTEbBM5\51acQo17@gM
i2KCJ7VDL6e1\El571^YnBMNf3QAjRm^hV9fj>Po8^=D;Ci:0nhDp2I9h[l3q2fZ
XNdI_V6nRZYK_V<6diiOo53Id[2FoNXKRXQ@qO[710hE`T7>9^8Y0B08kRmCJ<2@
OMh<@\Xh\Gh:_q<hI;Icap05A6lj\VI6`1ki5X`7SBPXl>fOVgiHT3Z\`6ImnUNY
[Kn_<bc]da:6M[2>nb:Hqmf5cOe4qd1LK83aAN]Bg?AGF1249K]\Si[mFLFD0SUh
5XH0FVnnNC^<?14P9XfSVISbmF6hJCDJO3Ln4S1JRSDQg9EDbNFbgOT]\I9J^@Cp
1[4R718FUJVC6Nf^PmXeO@XF[m:^Hfn<A1dA1B6<e3K^_Y2V9C<kT1FcOln^WU:p
7D9fS_Gq]c7_gmWRJ==S4mRL2LLlq>GkAZJ6D<Vf@XDKO0IUJKFMh4]63^_^Tij<
UPiAEonP62ABLk6NOj6K;>;PR2Y?6Xnf4CXAaI]_9ZQ0^pigN:Z:`pA:Z<b_=GXO
2pPjeYd^[p8?O;8DlSobf@ffADc8nKfKfV_\4f7JTQj1q=3X[9dYC_NhMWW2B[Xk
KU@Zj<;6ZaW5B]_HTS\aqoZ\fZgMa?in4=S_CeQ730JF@U]4[2Mg$
//`endprotected
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
////`protected
W^Y<4SQV5DT^<Snh?^9lKK;[i4gDAh0^V74qL2eoUQ<2Y?^Lb_jM[1j4<F6m8_IK
hEQYPOFf?WKI45c2k2l1169pOo:bnaNHU>g_YHaSMn\^]X4L46cip27;K60q^Re3
35?mgnIHI2XC3TY@iREaMCP;L:hMJH=CLlM1d[H0m:]_^DJ5Vd=bA`pU5\<VWMDK
OIO<0PDGNE^iR7\NBPG?DGcRh0@o5J?kbVY]`6S6YXXEHGM_LR=Of;FOZYj0`k98
1AqAQT8jh508^J<?7:UQU_=H3qiB;hY^KNZoe^;Vi\K1FM0<_2:mlWlZKMn]Fj>B
=2;[NYJJ6hnj^5VbaqJTBonKfnQHOQ4F7IIPT_JR]jh\ll^g7BX>Kk:3h7Q;`_Kl
6_m;SlWn[A?oY:=Jc3_TTc57O[YBWON04LaQgpF4f@hZ1q4EXjX>6<jOco2``@a8
QAOaVkG3`;qHB=l<E4^KFgf?n7=C:D^?km<3@VY`nV<N==3i98X6XTo1Ng>pCKd7
FojGf7NRF88klj>VTSeYE6gX0HM<1>p8_gnYEPqGo1hOL16IS7^cdRFWDH>T4>bY
>N[eDgbnf@QkZkohUBjQY>R9QB5D<B\qCIJfL_hF;\Y1N:?ZX>=h6EQDb?7Y@Dio
@kZ>]\cZ:BTgDjn8\N779I3?AOQ\fKI66h<hK[Fg@cQjgOOmdEe0pJGndXk3qTn]
dl4PoUDID=:JDDP<7ATD4e\WL@A]q4knU350JiiagAAnJ7`Bkci@RGNMgR1[KQH]
8O7I\h[cKeAMNZ;=<R_UIpjkHXJ9FB6mM4E7kcWmGhmWD=ITR;<n?`Mb;IqB0ZUF
@XHXSi2Jk:mg_?:mmhoiMkR@]eGg@AD5c=aOX4LM7iXLMlUkcTFO@E7K\KQNJbl9
7ioT_m>=`\6jC=:qlP6^XJ;qbcDPfY[[_]9EIDG=LH;:82YnmVFc\XCp]ZKg:7qH
gIC2Ba=\LZM_fCI2TQ9m=F;Oo__92ogSYkI>O;NOKd36^^D1OOJ@<KpQZVKNQBIZ
jG=4aDDR\n=G0WCSL30ie8ML\_f]ka>>Eo2NljPB[@ZJNGfM>2WUC9gE92O?H[oS
MU4Q3LW=c[qhK:EnF8pUkD6;]b4`:`X@RcQ0B6Po8f8=Fenq@JX6R:mpi]NX:9A?
4\Rf89E:AfmDP4Jn;WJd:>05Cf9`;8ES1WndJ`kc]o@0@\M54JQcpL:P_oQjNfbJ
Nn0We?BI0<]YXUhc>0fle<G=nP?XbIff[7E?200=RdiLkcLmap3A`\38BiY4m;1M
Cg5ZVclI[BLe2[4=H4PM:I6\jL=LCKJ5gIFbk`B[f8=PTF]hY=SBnNQ7MK=7g>N9
pifo^[S]EAH@To<Hm3Ai@Q_lLW6NTZNWT@7gg=T?ZD^gfflfZ4hS@P>1D1nlQ[f7
GiO>K;1?T:8<TQcDl0ePG2if>2k\khRplSOLdWZa10qZ8T`Uk8Jb`M2VZ]2HoW`l
5YP=^;a65NCa:V=SV2q]70<?E2@ljL007CceQ4b@aa6L5ihcXjW`KSjqTC0_9e6M
6^?1RdPY;`^FnjB9jUXT?e`L1T<\[gf8H9OZQT?3WW9iR1NJhg`B>]8pO\C]1\Xp
ZZ=F>5lqQRV8bAXqEA2U7]MhZ0C=PbBiFMldRjbG__7NR_OJpNUSRLXnp9KR39V9
m^@@:WIjK^3kGF@ipGn82QeT1H6cYUK8oo\Ue_iC>Wg[dpBbl[8gP:L2He4igUKE
chKh<PWSA8nb^]9QR]qO^aGaIY:i8R7UOUc]_idClq>hY=A[:O0aA97;5PRgTKq3
EMoFPB?6Zb:la0hD<P;GJDA<D]4\]SY^Lp>jf<[d`_dA?lcG8[CcMEYiX3kNE:ZU
6daQqJTi:A32gkHSbf99\VhIA;4JS97;qSAMYX0\QD\ioSc1TjNF>j@NTIQ>Wg1W
M^]a7e1ooEdCKbiTV\43_=;f5Beaq[GIXen5GnQ[\I=]D8=3YmT13jd[6DIOCS8p
[`iekVRp7I]N4=7c\N6G^1XeZM<^qX7jI0i^DBOI1IiVE]5ljio]SU4b[k:`UYgY
lSL3B`6JC^PLeX1e3ejjKI[A@ANj>`1DQNaQd]5L4QBV4LJ`Y9]ZhqfP;3[CF@e?
caC?77hVfT<];<oCqb8ZY6V@pmD@_SbCb;_:N=^M8mK:RD2:HPT2:<K5AFcH_A<m
:S:Qp`G2ToE?D9A:UelJl2V9X8QAXIjU3`CLRc7lfGOM@HV;h;RZ70bZe>@bGp[L
WA4^:Fl8PgDe?E4Gfn2GYd\6c]P9m32[9h47HI1^IS@eGiC6>QmW66aReaAN8Mh5
9o<UVNWPhSGc<Noc>VoFOFpUBYJ7FjiBXN0`RKB6aq=j78Uf6mJ3c]V@P]LWbYif
5ORMqCE1VI2Mi3Nlndch67XboFC9Yo5^T7JQm<_`]FI1_AGEP<[fjZM;Te4AUn34
^aYV4CmC:fI2_pi\0IIiWp2kdoYlKW5\0^LHDU1?dFX;MA\obRHl?SoROUMLcSN^
Wn4jb]C_WhHVMC3ogC<[CGK1Jn:1V`[[klj89m6gPanajEU_1HA0Y?9_cRmm4KD?
p?6TO?VnU?407KLT6?k:>fEZ^doq01aZ?e4pSUZH]9W@X@PgaAglFUQ_6g?8AS_H
onRHSebU?o<qBR^R=I3bZjm9h<poP;<W3TNeC]ci?7MY^bI2FSE7aJ8>j5ge01WG
;cSqIMFFK@kVb8WhTbBmQ]1gW_T4XT=J@niOi;ngMXGY_k_=>LUdgWS\gN]XE4`3
o96CXRV4N:D?T0^Q2=niQTZPPo97MTAnUW3o^D[3K6Gh94a:i5p`>`YNQ7K5WaQC
mOA99W4:nZmeep`;ERhF<p[UPQ_4MXiBQlTLVWM0H3jl>6egg^1Y@pOL7WH1ocmj
H?<@FjXF:CnFI\gDb^=ZoXOn6_JRYpi]^9??D:[aC^Wm:\3iiO>VHGX97XTnpLWE
Y\^Z[4[hm2GZ_J84Tal4:mGQW<g:_:8B1:0EWPIFk0b?hA1fAmc][dccHH8GdnPE
@O\[PoMq5AG1k^L`Ved9j1f[GTO:7a:o;69Uq6?OOXlaF22O;nALd4VMp3\_2f@0
I_:N[=iRM3ZUgd>`[QieMDM^LHaDp6NER8MifA7nA@V]W?P[dL5:EPTFiL<82L`^
^Fb71d9dWhi;D2Xgpe0MbK56Dq:lTB]R[m>1`Q\h>Fko2q4Fb6Z[YYDNP?Q@e<U;
B<0U@4N8:<:DR:oigaIiK=jlpe?]XVO`7<_T`E8j[C_LR\OC_lDNg7XWCRg=qO8Y
0J7f2?<N8C`L?`jUZ>kbhUGeXKZ>JDW;PgOS3Jop?8bTAhHIh7=;4>0HBKmD2oJG
aUE_6ec2^[c4a9X<]01X3KkJE6GpKWXc`Smnq`1T?OioQpI=HAGgK^j??G9?lG8`
5I?Q;l[Pa[<O6BpV_9lAMSAV5>KPmLm3]AL<JpBl7HKl;Y_nXQFe2FRa\a\@CJSg
\Ybm8ZC71d<bC5oCiBfOY;lSVbP5<ZB9V5]X4L4_>UpHE=OPU6p[:NZ_8<bZ;4[M
80k48Inn:8V<?4RH1CCITe5m[>EE0^BdV^QKDYES82:AR6MbIf4h]9Q]GSVYT3kP
8;Q2T]0njlZR7`mR^cK?>V6oOnKF80`2SgSdKb8WMS_GjP]?<p0W]I^cGqR4P<WX
FAcZi7PEb5J[UnkciQe:[BBg=XP[VQOPNG11]_j2h[<XN0eT_hbkCA3=QYRcU=Ug
@pLH68dmW8cCBCKk[;>mRTTJ\VkK\T7[Mm;PWaC3IFkJRi>bBi`8oD7OFnKfJD<X
8LSiV3^1fBX?;?D1N3XRpK2EA8c6>lf_j8R]D;IXAiQYo<`ZWDlm[3DEYhfLcmh]
jU_eT3^[=oJphQ3?g2C>eg>`VL2V@<c=IUP<p?WGW@VTp08D_UQ[EWOb4O`k5We[
:0kGkYBbo4CJeKmYl=f22De_15C6k81`[XULZlO7lVQc;NkS_^=9\nfEgEPB7WbP
U_Z>^0:7mSgJ^>\Zmh6;]5174H0THj^7^\jZ4_ODNW_0Vb7Vq\]330_a1TGcc?TG
60`ITX`iVLHg\EEf;OI9kSTVdH_MUdQ1G:Z[F^0;=io@];\IER8EYpadWJ8?Sq:B
eCnQmo[;4T?21]T1h1Ego[CQ=SHKTn4l[ba^UIlLqVSjD^TjO^M9<To?USVfZN[\
4NJAN9_:hNX5m6>5`9IY11`>@A<f6^FCHV\QV7:572Sj]IS8;_2q`EL0`DW]h@Z=
PQ=O=QF`DLYEA8Kl`l_hD>cEp82\PZ6;]KN>TRI4LdM;6ZIG2LjoV_3EkpCcG@]A
D0A]TZg1k6:k1q]696THlL\EaI:?PHkgg\_TlXQ7ml<RBQ3d\UpMYf<HhnpaWQRl
H1iT=\N9LQ4R6BF^dJ2QnkDN;NQK0[9Hg0of[RNndM5PRI6L=@_UY\Kb[9Q0:XlN
g3oGWZMZJ]EQ_D`p>^AaWi:M<BHA4j@YdG@WIL?Tq436@j=@ql3?SGR03cL4alb9
onNK2B99mGnTK84N88iiDo1Ib:TSeV6EROH?]^;GXC[^O^O=CZDEe<`@1\56lGPR
fU6KKJlf\GPNhc1og>^lcilSf<al0H6ER;TUTZGUCHT0Cp4CUPn@9pBF_3LJUpE0
OJoQB`KCI`ZPbX1?>KFC\TNOha?MD>WRo07hmXnOb`RL:aE7CZanMQqjOiOL8pK<
YTX?Xp7PNOBB7fo1PfD>4hcTCXJF7\T09Aq^FT6K1\<fR72>Q?ebeDDh>8=b]J5l
=0Tp;DiS>lgpjF[F^I2X0YTRB]DFjZE@KnQ><_k\:ZkBjH\CE=0QD6BD]4:k]1SP
B9Hg:mpUIcZo3fWMBfE_bHRpNL;>]ZS1bc5=U5:WGUklGLeR50LB;`Zaalp><XO5
CgqR2RC8e`Y?P;eei0L5K>d\7KjQ_G6q7f[hM<2L2N>@ik32DTAq8mC?PVV<_2Z4
RnQBieiZZhTUi@]P\Q01SbcpI88E?Q?hMUI<OWj011]kB7`FL0^<hHiFb^0Z0NiK
dMo>So?VGLbp4iS5ST^Dq[I;ngXUGCmM?]gg4`MA=A:p1iYcH=7kel_2nMmZ7R1p
0_c7WjLAQMmn_gWdd[g_d=UME0d5mY:MlH8Lej@hhVqC<ef>[0HVN=`79:T:jaTH
CR;CYO2K8LDOeCVkUC`=QpgZ2Lamb10@WXTW0QOR@D?GBVZh7>0dVXh5Yi`KJV:3
1n<83Lh?UqoYnO0gDgp^CPCM<]j8K2g=fGA^Ic4]8Y?6Dn^[g`p]m?cKXX\qLEn[
T>8:N_0G`oSpU>39fBL>6ifX\OiG\P[0OI7@2<o]0VB8REBS]9eSokheO:p?BlB7
03BGbaeZ9ZEG1CVm81gV3MZ]?0N;F80XInV<N3OcW^ooei>NR8YmojlRaqhW_JD?
K\qI[02U1=@e]^kggV08J;`U6p`dgIH^<qQ=n8JW8BmbXa0GUMpo8k9Y;=^l0`VF
AQP\6q<XCka62q2D7cVYa><?B3Zi[@oV^DfZ@`W\_Q7c3XJW]7gH75jobp7[:9P>
5H@Ha]6]Mb0Te6GLk9aH^fk=Y^gBh2Dj;R777O<AQCXEZb^aQLkb^2fmqD60Q<@:
T<0Q@glX7<YTTQmgPpM;kJLcEp:7\E\5RT=i80c4Y6p;\dHdHaq:jPQnP@TCa;kh
XZ]2iM7RGhN=0DbcNKFfgFL;cFPf84NmLq=M:mVL_d?Z5L8kbMfCKOnTMo[JCk_g
`l]`p=i=2D9?T[bBjMKRNC6Zq>QHG?SV=]7DF55Dh6UHcTj0S;4I4dQGbp6G?EIU
o_6:E1PboESBg^@W]<BVd08fjcY;KHlg[_aPkbl20QaA;^MjP<PM_]ED[p<Pe9KU
FqW1?\Zmc_oom=>d=^SOopnlI@l<1o=T[_<8C?JKD\SnBGI5pNU`nj6[qN9`\I5S
pgn>N18ojRTn_dg9f9SEJ2YK6mfenjTTT@Z;Zm;N9a1d<U2UHJ86VZJH4i?7nIA>
k0B7ANoBkGHeJiOcl5h^^L7d6NXH^YNT7J73bBC0`>D@q5dL`M:7pDdP]@Ya_9EZ
[WnAWgf:HMOl9:h;2\=8?IkiTd7Y[6Ue@Q`]N_58m35^5F>Y8`7:3VWBqJa697hp
6A>i[fjCF07q@[iYR>aa6>I0c49DHPO2W>;kaeRFiTl\bJY>5_bROInQ>kG23V<;
]^Q`YW5N]M6QW[NjYOJZhQK>7YLS[PFhn6c6aYb;06V5`J@;gmoiOFlQ1IGp0Sf>
WZhpf7<m[U2qkgV_>hKg7cX_=g_3him8iGUnQnq;8O4Q2cpCc5h3]7p0fe:G^dYC
T=fh5=][[bJ2BOU16XndK[AqXD58;d3J4?197]`^7JBQf^cRmc<G4bCQ0[VKIZ`k
kn\T`7aKZ35d:0]H@klqGO?4U]]kW;l`U5NmS9:nJ<8W?df8=e[]@oHL0PTl`B1k
bZk=TG5I5DGQp4L@>Za1H7Z[oc:43qK1O_EN>qkX9H<KkPG5Y]@P[]4KEmaZ9\E]
7k]d>9E7qAAL452Ch0GAijKUmPE8p<YVZefVFWj@5PIbI5iW5WRg2^`cCcDqMnGG
<>L85]lS7^1;Dg89C77V:bPP1lFTpOKPJJD:qM0KbgNF5Rk]VBQQ5m3<p10HZH8k
j1SUCGHkDCmcdIdSbQ1==WBHhdoa929omL3JTWQE^H5fNAIRQldMBg647R<q0AmS
iWd;Y^boFlC]E65Nd3CaJlqaUlKULUqK@nCM6;pTA2AD1_0FCV5h@1HcN\cNh60=
M_bUfCH57jmnPNcW`bKoOB3Ie5nI[]_Z[\cn<=6VSDBclIBKPQ5jm_7<P:L2_@g9
hOlLiC<U>[F5LIZ12dpX;mDR:RqoOimIi8R[18j?E:HqlOhEQLYpIo6]HbijPc\D
Bm1[JVbMcbk@<TGW05RkEVqQNB[P6\pRFZPjGA1[ni4>k\fbak5NbcXD[Yhh12Ug
PJed:22ToIpGZgNQ<HV78V<2khQ065m;SL2K<GNbbZTUN8YTZk@7VVq1kU`beB=i
e=<n9YHW_fg0gBUf[[40hLa7n63qe4U:C``XOjV5c[^GK=NR23m`[o82RC74n:;9
Mimkpb[<=m8^aLH3?abn??5GDCmUbcNK0Mlo>hE[ST2b2l?M];jWE2K\c46R:9lL
HGg6abmP[R4?IldT_m?U]cHoE21I^??GSdiY?Web0UCn7U8X>P_QT`GqBP<MA@Zp
33m[<<UC^>m0TS;FDlq;9\jBU4pFKP`JfJ=^ZF76Xf2;m]15ZR=lcAJc>TDVRLp;
6U68R2_T3Ic=R3A08;TBjg=d]Yia;oD31pNA@OQkUEi229XaOBf7ao6_lJSAInoX
:_Y8iQ^]6=H;LWoIFkAOC4SGa7\PVUK497kQN4K[QfSP?6<UgK;44o5FS>h:HRIX
W<P4NF^B8^lDpe9>h:5;0[Lk@0Fnn]jg8:?Qd]N062RmXpSDg8>Nc9]6Q1bO8JZ\
U7;@<Q@B[TkkjbQNjO]gkXBdKVXlB]b_B13:<5CB;DX4Df5JTocb:KTIn2Fe>RJg
E\1H]GI4iiVbioMXlj_2><4_TF0bANOWn^N^_[Ye>_5Qo9W:Gp=GoNIJd$
//`endprotected
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
////`protected
Uje1OSQ:5DT^<k?KNHoQnY0V]ck^_F[R>=o0B=8i2[MEJcc3cBY7ZOFZRbMB71FD
p3=@KR<ij_@T`C;9pUmIU\c4`M:X9Q9ODQjdYYXM^m>=_W0qQ23d7?qOdOgF5cjL
Fl19J;X^F;813@54`1o6k`S1ASFRCnRY2@Up=cAL3F<pL2=@MeG2]UgFkQNYVAm6
MRm7=Oi_ACM@X?mPpM@>_K^aqZYmN7LMF@XOCj756a8e16<U6jeU=ZdpAP7;L3Ri
@Ke1:6aQmL82_\CDI5m8i@0fE3QeaC@S57J:W`@]aNi[nT7SHN6YRgS0]\]BI:Fa
>bh\gO82pigQA:CnCJE86G6nCJ;5gKELlV6eU^OJ3ZA3Lg=a@^gc9jOemhWcifm<
SpE@b=6EY`3e`d?Hb@8@l6hcdbZb:?`;:b5fel^mPD_l1TqBIFbjgh3D2`2mk<3Q
bVgNQ@f23lE3nZpNIUhAYIqbo6R4_>qSQBk19m]:OZN<I95N6`aKmm@AG_LRfZmp
XEkXk1a]2Abem<bNaC6^bn5P:J@nFG5Z5NC9_bIEKooVHESCS;Mfi4pbIWI2>=fb
>`:M:K8]9TC0J>g[[mKhISqdm263;g`3c_^AUN=bbg`[R@kmbo=WYD5k4S<\^aHg
11IIS3YLIJ23H>NKa6lZf[fENLGqG@19PHkpQm=`D]ZoOCn_oidV5Q89<DIgADH_
U56W4:e2UcqfE_3bP5pE90SW4;Q>`CAE4MmaBBfg<Z093B]@b9h2KH8?7dnL[FPd
l^c_1]K_Lhc;=@h7QpnLNhX0iNRb4F@jh63VV:[UoG^02m\Dq3YX?b;Lj7UgSnJj
VdnkaVU=<fDHZO3;mc0VN]QVV`5F@EdQLWQLW;mie4nF2dd248B^fBg7g\D8YYF6
MpQDDO_Uc39E>YEACZmAQ[Nb:b0R43p`njTE82>L5j4\PUV>DgJ@ni`2GLI8cRJI
\I8K\7kmYeMLlq3A^ZI0S9c60]8FK@DVFP@^Z>R:87\<\UpVc5^\KN8_L9ndOIQY
5SFOlYHZ@jQ@kASYkh9=cjL6C]h40M8Han3qFcF^@QmpW@[bEcb_1Cp_D60j[0[e
`Q@RmnC::h?YHB7J8TZ>L=3ZiVXnCHI9WdVq=oS=h\0j]oDG@ATAiD42]X=W3@:K
=D?pgW:AWYcpFLGjK^YIMS4>Xa6i=<?mE?ii8[WK6Mf<7;KjA8i53i1jP1gpJ\`X
AXbpcB>hR6[qCHM;60=9DP]?hk^F?>oQ7ai=J@R=0N6_boq1_BN08d^W]5Z;gNJ_
EkD^^RGD]q:XQ?ah6qPFN6Lj4Wf[S1^05XEojB307k1BN[9CmlF64qA<noU02ccI
FZD[=oicU_1Wo\9?W<XX9Ae:TAb8A;G90k_`_mN8WX6<<qhod=30VD5^i\7Om<k_
lB\A;bMIk348oHkO09M5^Mf<;fLaAF:7GdLi0>7g:HOVIi48o^Dc[gEQLi[ggkA=
7pa09S^JbpkBUCN>FGgREck;Sqo?FB^lO;iY^878VGK6?_kbYJ3A81R?_MWQh;Zg
;EMZ>G`[i:MjeC2=2@EEiWi^F[nRMqn>gZ@^^gd?5ic[oOG;o:_NZ53SpBDYoE3k
8[U?F=6Eolohj;cR1``9]3fPMjd[ZnP>[RYq7G`aKo9XBI\;a>3FQb3>0H1Z4;iX
jm]=NW@h7UWP\@p_cmDH3N\aM9fC4E?\WfMDN?k=R\SkNQQb_BbnIe8]M70ReHGH
b\Ej;>Y0Bi0afbqgC596Qpk5g@lc]P@HN88@`j9b5Y9AncLR0IWaYB:1p7HoI@C7
?EM5Ea@mGG:IWH7FKAOD^9_f3Ki5UFL^3bdf4q`PSMTTa;0BjMoc>23iD[iLEKU5
glf[N?I5TRp546`4F3p2dTfFF:q90475idnX38NahikkWR:6PT[52f2\fFo?DP3V
\E\BW[Kd^8:kHNW?[]7iYT2]RA4:Q_E?T>EJF;[1gY0ZPZ4b?IKfo8R[MFhm[l\T
^_=IeL?pJjY^j2q^`dh6o=qT4DI8O>RIig1G;=BpJQ8[S^HTg_Hm`XqM1c^_>=Z=
40Le1d=[5`?:G[OAP_f=h6b<FX;kSW5Q;9_IWY4S[9:pQZ>m4Vb7K9o[E?5W0P;l
VaOf2`I`TJlpIF6JN_10f5YoOf0oQDAi7Y3liaPpZWAeM@AIAoJa7IGEQUWJ\j\C
H^<fUHbGpeVE6HOOp:eD\JBUp:C^2lDPMF@bZR>KCNEZKZoj4<G425B4:H5N8E?Z
0DFj9p?bnY<_jp]o3^hf61P@nA@HS=1MnJIL\i;;Kf0`j^mI]YqThKcg8kmmFf0F
7VZe8H1AmM7HJ2\8MfakM\7iF4@aWjjhO>jKd8Y^OncTop?Z8BBd3p<ZW:>I]AOC
WlnG[iOTZA21YL<8PYM_b4qD8kMRb22eHgW?=;YOL0i=l\jeOP;7CL3iUT0UMfS`
148WK;Ze5bnbD^Q]bDH_ELTG8;@PVDam[?BM`[RpZQY2JLCq2E\=D^_Q:?EEZE?^
?B0g=@]MqMSWCFeCp<>P614A>1HE6T5mNoYQeN>Ldh_M`:26YlhOTgEZqhYfBQhP
pSUH8>Hi]5J<a[i1ocSBKU0`6FD@H]VLpk9ieh7pHe7ofmHUS4QLAaFYV>NBVVH:
g4QHKoD>VV9l]Z4eH?\JLQYnWam[iX4`dje2<UCUK?@e_LD_8EWnWc=_qkdkj2\@
q9CO@1H^N1T3JZlgq2O:QNk4OmbU2YG\MEHKLABl5dnq95Q`>5B`a1h<871iR^ah
Xf_m\ZU@AdiLGn[mMT81fKEENOg1q9=OC5b9Oq>kH4l9k@Y`@Qh?N3j8e873];dG
>3aN2b?Yp34e8XSl\qFMVgS<BBo[8McaIo\NBhk_m3>2poj[@C6PQO_RTO35DkR\
8P:IWH?HXlV`k1b=V^WETB[UXP1=;H9=2k3eAb1Sj5R0o]JG\?KJfq\o4ho5YpTa
=9BS;g\iP]im8]=ZHfDTo?XVIQANo6=_J8kc@[gNB7i1OcSLX1?c\6_13RJFSKe0
gpHE=4a@\pUL\@8Jb:URbYRYZAp;mIVV25$
//`endprotected
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
////`protected
HA8k4SQ:5DT^<lQbE1DlF77ZmiCWP`HmRQpgYC4cDaoi_;RKDke]j^n0o7\IAPc0
gkG^T@^R;ZIf>8XG;0=f<4nEZK49YPCWM=_mY3<aSp>V_8GnTgIU]@L<_T5OVO77
Zq8BL9LmpBCDAl;QC@IGjmSOed<gqi17WWjg:1eRF`cAZCOpO>@c>^5bfj2<G?Q0
jf9b9:m[pWhb3LVN[GoCfGU]32TjkajkE7CZA6I4XeU0YZkKEina]`@l<eHESdQ`
Ep;DGCQefAiO`7BPQM=7cYGOp^b<P6?2n0idgkb\>NB_>A>NMp7Y1aUhCpfb_jE1
oA4j2qdbdUYB@pXlREWDaqS69_1aLq1f\]eb0qHP\Khj;J;\NU:XNW34_q2HDcmK
?:AX1okIl5Z19Y:Dpj?87FnJTjDkD=]ilSkP;pQe:j\:9`dagPDk\G5TSKSA<Y?H
J\RcVD9D788M<JUb==cVjR3n3gm7p4Kb[oD@`07pki71=Oe?]9W<@_:@JJAG]_44
@`hE8B3V?<_O5GNU;YhcSSQiceQVo3YnY6nKQJ3D_6ed7Y2VLe?ZI@6^i_njH_4J
EWCFPBpii57<D=q_=hgdY]q5PJIW2VO84_[cRUDY7Zmpk5>hA;kDE5DcF^[el[[E
[8@EYEMHPIe<fNN7qX3BdIQbSe4GG1_^60gg1?fRF\E]PdTP>d<qIi:Dd[l`gK_<
n;F5I\d_0dOa=d8K=c=7BaN^]WpQfd?U4dqi][TH3iM0OMZjb@MW^31A^h@@Ep]9
47EC4RS`^RYlVLa=5`=cSLJ5PGeTKI>FcJH`Q^2c[@5MBETMJ5FH2RQAn4XBRjF3
]7@^2UQj^DT0UP:64`q[W7jf`cp>\TO11]hePo1N1W_YUL3K5IbGD9JnnfKeff`G
N\po;VTHMKD9FC:F_J1NVco9Oh3_BCCVo5pmbdo\O>qSNf??V2g[@2SQb7iYS<0W
EAQOYb>54?b\5JI2BqB@E9T:3q>QLm7TS>GXq?P=E^AHVgRmmP;kb1kT;97S_TUd
9PC]GmP?7>m;?M>XJ:G>813>c:1P>5R]ZS6iLkgnekSJ`6;\N@QD3P[M`KiSZ^?7
6SdqHIEh3AUpGanQ@oXqR_;mQP4qBHg@2<heQA\bP>MU0LkMeJofV^a`[XLL;nWe
N2ICkdC4KDZ68CTlg^I:52]qFhPjV1HZ9mLm@hk>cb?b>66qbE]USGQHk39D1`4_
]<Ek\A^`l4AK53XabNN0WJZc=VU<6c4I2EF>aLUl_:4NMYBXDN5Vn@SHj3a>16SF
g@^?d;NL_Q;XhTITIG<NcE]AAL@GW1q75c`HESqRchg`28;3cV^Jm@Y8dlfDd5]7
^I<?WOoS<q5OMKRDPFVGi;8XD_kLfSYoh^QLA1iC4gBa`UaJCK]R]ElGpS66LA2^
q[>fbhZcdm^lRYO`TXfh[gVbNRKdj^E:ZG8WE97lY>gS0f_>0EBm<9TY4eJBa1j<
NdE`89KDbmFX3XXqSfHRS4mqFndkbGaJ7\TQLE;Fl]6=`flnnREJ>DAME;D1GopT
Rg0IDhpiJ?]io0>Pk:9H`T`ac0Wj^n92F5]5aia8aODTKY9O1OIJeC5ZDpP5UQ=?
=pifdDX_gqk^7OaW=NWTiSTO0W8Kk[bLGZ^E[GiGC^ViE<>9faORZ]lJV70Y@8cK
;_1ODjD7^lRD5^dIaDCB;SD9`fj35I3Aq2k98UmDql1:aZfW1Q_TBAo6J3F\5MNN
QRb;_ZJ`=2[TpL<3CBNaba<bafW=@2CGL@LoSH]:MQHg]O[I?EjmOSUj0bGR5Aag
6PbnG;G3ZWcjAVL5T;^q7MG9PgSq7X0UB@ZpAkCS3>4EK<32SfX<C7XoY^pjF`8_
n`HZ[\7n8PLcWCdHR^;Q\A5:OP9U06Qgi;UK=YX?O>pcI_\^X_jmAMMV[MYAEg=C
7dLklHNpUYj?2hWp;gj2neo024EM<h]IP5fe4THI@e7KT\EmiHmpXHa3;>QkJFQ1
88YWD4T0ScTK5AhE_I_D9V1DM<hDhlNFR=`\`JIZ82?_7PpJ@jhX<CDBlXh<kMkP
Z8O0^[2m^>9gfibVo1Aj8O6Am@?cY5T?2mlZQKdoL?ob[V_[4JhhQX;^_TqaH2fY
VPAKeS[@\F8J:hklD>f]kOYC_7XpR?^55;DdRh^nKS]X@P8T[0aLKja6@KI5;6gH
Eafiinp=]8?:b7pCjAY]`RMW8^]OC`oq6PUHZ@bq7?<MLOM1>Hh`[gn2Y\FPQk^W
3im2LMbiJ4KpClOKn_2[OoZMK>ngi5YCn\;oUOaJqo8=T=ZXFZfmo4J2I0hYh8ML
KB9HD:3dPWj\OhU7oToD5UIgRM?>\MUEgcQ_PVH4Ao_XjM<]`k\2F3akB:UC_=NE
n^`n<X2pTP\_KclQeAHfjikJKE<beTh_^ci_<moJbH[:g2dJ]hP[Hn@K50T=Ck2U
l1Ym0=dj16@J>UJe8:2IMJBU;bq]2oBTe]e[DIdTE@5SSMBd6FJd8FBKe5Tncff`
@<N5Cg[T[_oaIpL7@@1c8XH4T98>okSaTX`XZ=:R4cKmc\F9L>9nYLa;\<U:g03c
FZ6\nb]eEF4>gGJ`pG63gieCRXijJCJ[aPRP1@aDMTdl:Y?p>X6Rj0>B4M?al>4\
<2PXR?0<PhANOXp_78mLo[j[2GVihDO55oA3m4KO\WjHlq[UH_Cm2qEGX907G2P0
Ll1jPK]^qST0l9Y@pokJQbjG7c]9bVRC1ekGAjeHoiRoiNZVAcI\pNKbB^cCXiMM
9[M@aRW1Td3oiY9P1XEMGa[IVQ=2P`G\DMi3Iea[IjKSY^`MDeb\\FebOab5<i<>
pD2h`Q5P@AkRCI1\i=4Bok=S[5hKd>LOccoE49CYcGP[Bl6g_R4KOG5@W7?qQDJ\
D:1WjoWj29QBn2Ld@U0bq=fH1oCd=NXA_:DCnn=JURKKFkA0M01\R\WQ\Km_]Ed2
[lIM`1Bfa@F;7?jMd7_W_PHX]][PJ^Pi5IlIWBnS[CehqH8h7A`Td`LH;NEU?6I7
ITLL@TS>Tb?PpQd5gYDHpDChJh8@iFF@jQb=C8?Yh1gGQb3TeXiPTdZ^q4D[e@Yl
KO2lG@Oi?YCPgjhZGf;TJmbR4`Yi?q4NSKb\lqiY@No4cf0d8VOEa?=I[M:>n7l_
488oLLRUbp>V3]6Fl_Q049m^@So9egiL8\m;^lcSc>l1P]fHGAMRX`a6MR[JPf3K
qL]faZ@UTNi;eGFfP3`mkg\E[<KUNo?o`8DOEQUhKi;^eI6YlV>Z204<YX0q[Jle
B^iD3nc9\;9VSF;c;e?]P=i[To=\2_3=hiZ=meQL5j7WnkB4XM2;E`WNdDkfTlXL
EKP8JJRJ\<nqNfE_8C`X84U479l^j[@goMP`gIY^^`_IT3kZMZR:VngDD>=S;TWL
E;TB8]A5G2f1CO2n``X642cSE6gj?^VpGS5MaQH5E2nAZDFEqlB1eMVe\87DL:Ln
[P4I6;>>n[37HeUZpnB40gLlQ0`DC0:4YXDOa69K?7E[kdO4qhK1=\DapnEWU4NU
bNiACM6XST@>bpPEZUl46]Te:QE\cEZ>:[jcfIoY^ebFRJ_AUp?[7]PVHp\ON@GQ
hCng_EXM\7]Qobno^gfh4Xf8DEa?7qk3[_i`R2TBMCSfiM^V37I?V<ahIL`mM^Re
5<X3iTjZL42Fo]:^JBThpTKm`lLMg3906F<N1>TdL09[`=WamYj6F[^Q`U9dhL^[
o73bWBH5HTP=V947kVmh4@b3Q1PWkm:i3I81qJ?G_Sj:T7_N50c>Q_Bmm0`MRcOm
[XDN4GA\;BTEHlKU7BGlPZj`DO\\RMN;m1V2G5F9PkNJOen8AW<O>KX;qTMMoZ\5
A4?QQ3a7Aq?g3f:bRT4Sld>W_2jg`7RjB\6VmcMi>p4630`S6n92cNUdHlCgn5M:
GN==6O9c=qZIi3h`oI?2aUH=fHW_fZ:nSm<7Ql`6=>m4;N4EF\XXdi5c0X3kCAY=
kRX36L6bR@m@K1WBp8S8HVVQpK\FXZH@R?hSoYhYTHQQibJ^N5\o9FQWMpQJaHU;
hqoJZGZAY[nTFD]LIG_W=oU`nORZ:Fo=<NCO@pb<Iof09=A5D;1S;^Z:pcDOcdVK
e5kT7oZ49\R`MR5f[0hWgH7Sbm574dn1CZl^XB;k@9j51RTXeNCSHBJC;2Co7pdC
d^`?MeWdd8]:N27^6abW1>[L89V7<W4o6n?^7XRj8JT@U_[`7Q1;2g<cd7XSKK3T
g<hL^d0];3kO6;S<mib`mSe79?B>`QQ`iqlGb5?jZkCZF?0j8dO7gkHUOP9Va;fh
fHALLO@b?7m3b^DTB^N_`9``V@k0B[YbX1I[SnDI11T_5QUe71E`qUSCkI63f36?
JD:c:]>OOg4lCaZj6?4pU>:VTDbZ^bnb6Z?RE]G\`6NiTko7KMfFa?qJSnLennp>
54S5fLQ_8l9UT:S_XSG=EK39cUlegY2pP<WC?dAq<0gb\KJY7QLic`;UHm5fL9RG
8mTZMTgXP9f8L\nhq8Wb\=Yo`0<BTIDYF=iG0K=TVl^1aEf_>aOIqV38?Y@olb=C
<8g964GW@D9`@dFa:E\<OUA4i94o4WX\i3G7LgFBPcap43SQKGf6^7SVRi:ZiZgc
:]<RHJ`Y83XHC<80U<7LXc3M6Z:bFN<`WoUb=\H\U63cG3DAnn_ojWj0LkXq?BBV
gFP`Em^kGQ\_LBSZ3W8Zh>0;UKmMZ^k>b1a2EDPj@3lHkH@[MNS>:m?73o[Yl6fi
<ke5:LWJ[g5Db2pC@U62_Xc[6^S@n^qP;Qma\B0oe6SQd]FQ39_KkWb>aLT@0pa7
^dDKjpZbcS\Ne`PCkomBeId`Ho21Y`6[bfpcOXo;70P[l__[?[3i>LQcCP[W[Ah<
Gpc@NW[@8MDI5IKhXnKg@jABc?ChAAG9;bh1dbpDMfVU>9p:VE;gk_ei]]]ITYGq
XLo<[n;pSW=eR8^?TigD=@TadHRY?Ln3XJ4a`J\6MOSac?NJ5ZB=N@O0=>G>nd5R
GYRB=Ac9W7LLqml3^SX5HJnRQ`GW\[[iF_K8ER@Yq8YFc7PXp]W2j^:2So@dP33l
0<P6LCa0`;25OkXfMLGHp1NkWHk4Q;IFF96Q_WZ^2937Y7h?kH3O=h@\F6\?J_J1
]3=92glkimR60Edq<J3Yk<P7bPddOD`_UV`h^^eb=_W3E985[SJM7cQR0Z:W7=<B
laHSOGS@9CA:K9El`[_`R1c6RhDTAefX`mq9c]fh286[J9mZ3Kp`>\0Ub<qY>e2o
HVFl2fP=Cg;<PjiFD0?KX0M_nqG89G9^Xp[dO=VJJ7kWaAG<N:T<_pchoaINbOJD
5J<C]gL^92ffCiXT>gIXkPC;oq=MYa;E3[MjHK9E1_P:J\JdG64eEpLI;;S`ML57
FC0LESYcU:L0RTYL]4S:131C0]5oCL3Za1PF>739coqRbD02lEc_6PE4MlW=oE2O
ckj5`@BPUg2Hj1\gP_b[WhhYG]_G^>2ogj]kIAhp8ZjoZGVHO;e`:ZYfJJIXPe1k
jKHdX7@TCX^?`SBIWjJ@_?Dog`<Uj<PbD0:?eQe=hUYh`26Eo;;FE^qP\3mTR\f<
W`Bg9;ZFId?bZW`IA0d2XA3UNoK=\^Mm:iVbg;h\ZNU8SFmDVOTXXhZUmgBZhL]W
afA6Hm1<LY]kfhdbghiqJREA[3\PeAFLDh9Dc5^H_gB]i=e@dS8WeSXH\6MEYf?2
M>B;;JXkqlVHQ[^hpPG?hOdqiZEn`dp8>aVeHDSaiRoiIldK[`EQ9CY?lYBo;TK;
AL=3U3qKMJAQiWp@2:Kg02b9G\EUdM\AWP\>QA7fSeip0chUTnKcdOm5WFnLTaNb
5UdGp=E_6o`9O`@`Nf0`VeSSeZ:D=5KpR\IUgc3qHES2be?Y8i\[EU=3Ng4fI<S7
gH<[NKal0B=NHdUQ^OHL_H3:PiOEYBgp3Gk[H71p<h4@<h;fhe\CmFf?6?A]aW`0
^V9hK56Gb\dhBec23BRKdD6\Ymbb[<qdROETiD^eNj3B3;FN5YfXLChm;\I4eCWT
cZ06;Eh@W3aqKme88c7k[8io=09G:aMe5<<U<j_1p_dBZ=GXq;MgiZ:7qa8d86F>
pe?ZN9K_p]jYDg\2?GZ2hniC?D^kf:4JFU[a>?M>pa1DhC?aKKn3]<F1\mH@95=I
3n=hqff?1A_g9kK]6fc5TJf3aWWH52?QV73F5qY[7Oh?k>aLTnioQ`C>]I`Jac6\
Wn<5cQq4iD7O3hAU^hcMA06C;CXjo7?9FKdj<qkkB<OX0[nHQh3?8ED7Q7d;NCD8
k@T9jO@ZGkESa0?Y7A67f_;kEf;J]1Sg\<RI8:b6YAACIBCEqf8[e13UZ9<4GdfP
@n1VjcV?c2QM:ZcIkIg`m>LX0alFZ0CA^6]DgEQ_FoRVUZ>VlAE[eq\V8W:Hapje
hMP>jq1YLCWh=qLeRP5CLBe_IQjLe8ik8J<@?JRUHBl4gAY:n2a=mp9j8J13<H9G
IBB_<>gOWRA4pT94DcO?[HZ;DO[P?R3cZpDZ;i;F`<5m<A7P]aG7\l][JA@RUBC`
cNN;gCQ?Y:eU<SlTpVGBBOknqm;Lc><\LWUFTXbe8QFnobd>QbToiOb3C]RVc6b0
=A<lfb2:3O69Llc^gLQOFbZF_Q\m4UMK7\GXgm[A<BfBZa]BR@YO?O3QXc5IY_gi
Y0c4IqiMkSNCF[2>b9egIZBcCqG8BZghN0DhAEO>K`ZVHk>:cW`gICg=<QO>IIId
UYJBYTd4kC7b[m:DB:qkCdU<KWp:MQ]og\ABV\Mg^P>3;4DO619X>U54nbUp2kdo
YlKW5\0^LHDU1?dFX;ok\obR8OGGaEPdPNGIjjD44PPUo>W_Vi>f;FgWiS]AQemF
k1`2qHCWDJ2^pCRK<nDP8<[>@9_iB=SOPU1HD4d`NU5RNTJ_ShQSFp2A^=H\4p@4
ZlKcW?FSIU59hN^X:lGSWa[YLSh?_^FT7LQ:Le3FX^Ho25WCTLC?j<=YSlXF:O4P
RW8EY<`@ik72=WfMp_KNPFf62?E]ZSc8ahh0qFH9>Mb_qRT:47VD[n@W[g;IiP]L
_0n:EcPK]eepjGfa0F]qU\7_Hc`GdNBl`dXM0YQjgSb@G?=g<ic8Wl7EKGXpW6eD
@YD=d6\k7dQJplKGOAcLpQGg@m::QD8Y@R<m6\NK]^7ULSk[Xq21e6cdWm:BQg;d
^MO2@38Jl<nEd3b<gWRG;YeA15=;5U6Dj3e^CeYee^Ub1o2X85Y;3jIZqf1QI7mA
dBf6G?gW@61PGp0OlZIREcFJO\L^4?ADEq_M_RD``b>3W[BX^>6i<ip7hl4Q9hVd
``D=P3Vg;7W2jFbcTVAR0X:[MPCJTL@W86PL`\ORhnY[H=cXT^dVo4CVQ0HCV65q
7GoWV4nH[AaaYl@hoCiM7QjZJaLm^OkCh<25biXT>Q31eYleq6gNjdj_q:Z:4;=n
:c6[al6fMaRPaqEN:o]H=?n5TOBCK:7DfpV_5:@o2DGbC>k[jP0AX1pjGinPcEKc
iX2N]\idd]<8SDJl]Vf@bCS;CZE`BBPe:i[OM=Op<om0W@N]FMik[PYP_PHSoXX3
dDVAX><_LY]ZJlf[e]pGem?bQ?pFcW;;TfBjSPo>blZnJm9pU2RoIcG<:JbodMmT
X>BpL4N22[H>K[KnG0\C_E]=S_d=CYCkgb2IN964Hjic6l8dnS4WA3?3AGMX=\V=
GO=q=\C\;@nhm^XB;YO<A1^VqRng]BA3KaX[jD>R8aj8L5e;6Hd0EbB2N^@<Zc33
CEL2E^Sh>qaYBI`3WqOWDW619gDP9kGWnc^g7oqdZZFBAG3DQTF;c3fkj]_MEWhi
8kW4L=o^8In;AED7YMV;>pbaAoI9[L?c9MmmUHYV4q=5ITCc:733fL\17V7nCoq?
k14mH_fYWc]QM?167:41Gd>TQOf6U]7JH6n@XLMdQB@45N;p3CXicToo=CQ:>Zeb
oFBL]I;N0JIQ8L<?C6k:205agPL<NG`mVXP9?aADg;;JLDIJEP4[pc6a4]O>plff
j?UeiK7Q;H_Z8BYK1p:@7BC6iobo?Qg=8_a^XOJ]^NTikKqaNP>V1A0ZMk6o;J?m
]=V[Jm3`mHEQTPEj43of520_cjV]CXf>DFoOBlF[1q?2:5]a=QP?5nklgoMm[2<O
P9mlC_\gp=goaI_FN6M5c>96f=@R[K<U`WN[88X0lHDi3^U5d:k[A^SgiUO1[?JV
[aNHUlI_`R=q7\M^fhIqUj[gDcGTE_GF\oiAoB63Pi7hj;F?>;HKWTfo1kqW[_JO
X<SE0l9HkQ@O9dC8hgENJ^dRTb@mAZcQOQo`<iB@S2SPJELkW\UjEfN:fW5<VqmD
360c1$
//`endprotected
	
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

////`protected
;GOL3SQd5DT^<Y:HHjKCkdigSET6ZdDSeLiJZDk50V[I36I:THl9c24=X<cofLPp
jkf5ffH[fORh^Fifhi3;NJc=07ZbH9MhDRVaW5BkI>VRcC=i6YkeCnkip?ciJ0ii
f:VcU3LqTVX@ampJ0@[[O[d\N2B1_eMY:Voq8dnIaO1aL2??RbiLT:b_E0GZqLj2
M7UnF:G@7IFAOWbM;RF0LGC^@\oAKM?Fo0<]m7WmJhi8E7mJI0\JI7`pm0g:5^I7
<Oc;?IIjnbk]phQXN9J7UbNEJBBUS8eSlln1:`nnTV\YZhTq[HIg6EOGBkSo<]5Z
2kSHTi11nQ6UB2fcUm;E4`OLBBMS\Bc[PDBSQ7iipL]bmeKfpUR5:ZHXGgcQk`OK
`_XE:cL6UONGD^VKel5fb?`6cfJ1b7MmjJ=56Zm5PdG`Hbdb2aSNLL2630[Piq1V
lJ[c6Rj`V8:`ZT`NEgRdjqccFP@[[HjhZH:jWNNL;cY1]ZMHA=Cn7WbCCFR;KlFW
b:;JlcAeLV0T7qL2QVZaVqnXGJB[5PYGh8F1U[9nfLS5MS9jnO<YWp``>c8bWOlA
^=e8JUjU2lo5B5^E[a[\<COGO\eYBKVShq1Z8K[LE[?Z`c`cL89TEWPhNNQfXBcg
Y9oFbPq`n^D_mp[]L4YLNMSU4:R3Ga9VjBV\;HFHBG058Z0n;0lkIHQO75F0E6gi
3RaPCYUk;68I>;e0GF`Q`YgHcgjUTW]`\e;Cnp069H80odHffhR4h>VYqOdh:^f0
;Jhb[Da]Ig`jdWnYQkO^jT_VJRN16LHDjEOd:O2UFdmPj8kB@XG`k@lmSLJJNOjA
DWkJQA\=Ya]WqX^6bI78SC4Ni[:^j@dAWO5egIoOj<UlNco9Q8\3>S>`[SnLOgbP
>ShSGibVP5[Q=PaJ?]:ld:RZ?jFQOLiXq@H9JXM^jNPWdVN>BP::9eX7hbf>;Uh0
HSc_OKDOG?=XQaM70>gTc\dY[@<j]CaoM@2=l]1T5YNGKEj<3jHqXjR[=goqQ5Ga
?NB2AQceV3AV^G6;73<S>aV\_JlY1[8MBR`cASjILC9`nGbN6k>cT<=m3Q6KKBZi
Mag[FIIqU4nWHa8EWN`GFX3?o5kW4WD_f0E1S`3Lj887=YH^0Y36]Cb\70l<a>4K
o=KN7O<pej3CIXZ^Klk0;3m:k7kPYNBqf4IO^L7pg1JXk;p9X]<7\8XhI3Nj^Nch
?`gGe=:=QD6;?Qe:J5T_ZNe0hiVObdRS[TW7WAVjmJ5V0]39b]j_bElG1VVA[Z76
3kOSD`Tp?ID@nSlnYnH;3eM72<2R[CL5mkIEgZSS23dSH:?B<m\boNAFPUBPQoJa
YPMWkR2O?ADSLMMaW?9B3IkXNgM5pM`jSSDXUQoZZE[\>^eX482o]GOD8=>lOBWo
<eD2Zf^bE6I6WAl0022Tg>PhooVNBM`j\g\8SE0l74N>iJ^jmq5P749B^aLGWI4H
`4kVUM5BYSa]f23ENI^X6HU];<XWS0@[U[W`fgO;E7?m\K9]nfoiRa`hHi0A=1_j
^B`U1p]>`b@h8P_3cQ6Y5>oDaXBDnMi4hK<n?`MiG?pGF\miC5qn5[R2[fVgZXl7
n6`kTXgXfg\[cD=2;B1fM4>8LPlhh1\9kUZKVf4j3Sj\dcQ:<bO31bXV8VfQ[Mpl
6bbc3Pc2`_5lbZ2[\T?UocqEmMR8iQpl4madAJ;;jTFeH10oZ76GD=:gTL\42e1h
5cId\7ZqZ9T?iNUpk[]H<9<nGJOc`2@WcIY4c;_`LL>HmAna1\YocMRY[oWf9j0f
CQjH_Q\7cFOc_jgkk]51NO5X<n:P7o4B_cP>I<XcdF:eFnlfjP8[I>_Cc:deBQVm
F`pgVl?g79kG2>S=o2UiaUJh74AF;bmUB78Q=EB]N@=q>I_34V>q0_:kcc3qn>DJ
NOEq8_4kf]Y;ldDgR\Y003\[:0IqgGXU8n?O7M\:e\LJWYOjfkG5b:K1ZN8[8EP2
74J@pfWR]li8coA]S48`NIg[kOeY;9YCQ]M?02GZV_\W5P[i4dPHIc5CR99[]CNT
g@967DeVVJ_`8Se0A27f=p\g96ZH`q?fGen<qoP=OhQD3L7DZJQQX2fgFABpMoDi
HJb\[FD6:i^1ojJ:p0SFihU[E^M=flGZ\7>8\;5db:L7kT[`=W2GUO5[bWa1p3[J
cY>AVjGcD8^8WBePSdLEI@>gVWblfg>SIB30<:WXp^KH\U>LPnhUAOdH_]NhKMF0
2^?GGj4P2d?UQRKNoFGRpikgb8m[608fJ?Q7mOY[mZ:Gb1;HD=YHh1@FI7BJOj<G
qi_cKkbSqkiO`a0eR>o<@<NgSiM=ljE1MQ<6^9FTXiLDF[YW:0d??:U7[[FUZmT9
?C2Oq62aYgZeI:D`nZEQ@7f@IRN9HdTE6EAC6>dbONa_oC7e[7TO^L<N@Be4Pk:U
Tq0Ho]Id3pLAI7KQp:X]ThM]iQ4Z=W\a:EX^NqkRPeh0M4=:S?mmQkC9_W`jSJk6
3S1<JMCXbfMDcPWGjpc`7MkeiRoS]Po6F3NYTFhaDYDiiIR3l7Q@PAZ_S_KbIq9i
<2oA;=oA0oJNCkcTWW=ODPAQl`U5b^lh]^\7A5mJ@qV=o_9]ff5Rm2hBgbZ`cLN?
3F`PMiEfBIm>fefU:8O8FqKcENjSZAgi;V8d>]49=q6P@C:JYqn`Wj@1`h;o]WDi
\S[TfcmN?Uj^IFT`g0qI_:bHDaq]F8E7=ECX@dH@2aOUB;6P2CfMCHPh82mHLK6k
cf6ZICBP;4Z`JqScok[7LaG[?ZL_`8HWq7dVIWM5QKLNn]H>1NS_^3Zi=pg=goOZ
AaHYLHk0S8KHOip>HS]:GT=jA88J8Jl2kaW5P2UONK=X;?T:Cq@ad4?HInndFW\K
oeLbKEnobB0P?I?0>6WNM<RbfQKOXM?D?SEkEeGdmlpV_j1lXCp]QB8ndfM<01EG
dQg5fl79>DSmfT;EHcZ;iOP1c>^A3g`[GYP[m_Jl9TjJG4DOhcOniM]W\U>h?dlq
R5[gMG6\]EYF3hL3ek7EA752p<mdDgjGqgPZ]c1;fV?53QBBNJ^>lPDIp2mYD;iG
4\=gho:V4?A^1p1eDLeZghiUefD:]d9a^A<0>K8iIO`LlZ>ocAI_Dk4f16@;CkBm
7G>:hFeRFijbSM_<NB8mCEqIO`UoX2[pETm]ikf0d3@]aCn2ZS2Lp^lg[nTlG5`B
?neYC[K8GlGOS0[kcbm_4:0B6T7dV;U<lPLUGX<hR8O5]_5nMkTD=4aq211lT]i\
p[X7XB0TL>;Q;nN=Ie?KHNC[7GjgqbLimU:`Wa@>UTb2BU_AA:2`JmmNmX``:9DR
bGPTjgn[MgcH4oe;\g\Pcf^hde?M8[Onp2IX<MlX08<YhK@jTmIFb]IiaQ>E>5Q5
TgF:Yi<iW@o3E4fGaN?8`>@ch25S6_eW2^1qZdhO1_KLpob[LCcD;:`iX?k4aV]:
A:XD8`UCPO0begSlMaQp0Fm09Sn8MX0SS<<o5kqiEHPa@h2q@V3McNJ?pK_gPlgi
YqVn1_P^BodGho:m`:`]bl92e9NL1ZXTIqKf=WgS[\k2@cM0?S7MIoZl;H1gGgF?
0Cl:aoS_H5gOBpWLb1iUoNX@d^O?V;@oN?7Ka\>02\55@eBheBpG3Y[nlq15Eo=f
8m15fWj@ZaDMLmf=`jIiSTXkho7gkDo>fGj>X=6nF3DCB;d1V]Q`?Tq]?M7l34\;
WE@]GO]hm=E=_^aLiIdA6KJ^PQ;jbnYgc1>ISR6L@FlEFN0QZnI@08O`d5AWb>\h
25ak:V6=[3fLe>dbYq[`7hLY?0j\GflcK41S?CjIiC@O@ha_ZoNY\FJnGf1Ek@hC
HNl4Fl2W`[BWV`oOl35lP>;VdjRZbDdiCJcZ?k>cq89bcQkc5E7EC:O0R3E8kGAP
iD0<6RkQ;nM_51Yj0Yoc1`W3Zk;LT=@UO>A6>902PFiaM:5iXjkZ]Vc=SoJY9I2q
]PcCJ`=OCPWTXhak:<gEd3l4@9E@ZTnjRK?^AOCaVOQHgjbKm@L4?G_=C=I_eY^P
]0gkWY8N8VIjTgaMR6[0p8GKgB[HcC5Z\]d26_cm2I1NfFfdQM=Tq9SmNHc@q3bP
ZUaZE0Ic9OeLKlSAM@VNf\aT:Wb\]b_NcUDaekK68TYRI<iCaN\WK9E9W9o0o;2V
B\a86X[9Gq?[`Tm]7>SIiGXVUJm26MNMMNqnND:oX]pMBl2C1g[B>nVc14N_GB[m
A4`8e\KU:;FeJZeTQSD:FQi$
//`endprotected

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

////`protected
QY?o3SQd5DT^<>J1iAPE_\?Y>UlQRMF0p;AES0ZW<gcLZ5Dgb[>H_[6[QX:lJ9nh
F<Em\5Ff_eIc7G>R_9Y^JWR3A:L<2onnR[QZ7q7@j\O=HM:<DA`T6^MFPPK[9;9O
Hh`lDVH5IhB\feH=@bDAfpIolh4OqnFXI@QbJn`WgLOQl5KF5:Xi>iiep0>QKDF\
q^Mi?o?QSkc10V8mP?3E0=QH1hQ7TEIjZU>K6IGHPpOC]n>5SL7U<IJ^3gj6\D\<
?:Q<qlkL=oT?`BdR^S<hUQ<hXZOTdAQ@\p;A^3^>JpD[@]BE]\1ii0QZo@S]5OM0
MU<AX:D6q9H_le6nq^>PjBSTb40j>5[PcPG0J@?B7mHJKaE4lmRNQK5>qlX?\dMc
b\a]M^Y`hQ=lA9b[aJC>qM4OIZ9?A?G\3Q\EU>cdV<cqYc1[^n\EYfK3boR8TEdm
NOoM9YEMHKc3K0QCEWUHCg:NhSf@[[bC^gccqeLEf@L2p7L0@DNcKAC8<g9[YkNc
\CFH\C9dRjXOjS6lUcV0EW[6EBR:k^^O^doWRD1C0m4ogMAGi:[I0@[B;?\fa`3B
fTfPq<eMNl[4fCBRMi[\Of:3Lq7`n18A05D74=nUA>3BZm@@2<O945JaD4;bYnaf
k`9a[d1>nP:D0Df_S5GXL;>gJkZ>m]M6q9?9:G\:p0^SI5aNYcYiAa7E_F75=gB]
Z=J3lj]\dRLcq7SH2bKWSGnHiZ@;6L0l<YP8;knS5gbZOa`I09nATa18le7VUe\J
lO;2f[jSOGDLZYkO=J<O5?aZ87O:f63BOjLiqOK2Y[`oOZBl5G>R;mbOfpFiBaB:
cqXO]=hAlV[dgF=0hEBlYGAh@emaEd2MlSRSJq8E]_``:eTR?\\nm>77_6_e41N?
H;7jH0A_5?`PdV?36pa36<OZ75J22p3NR3l[g8E4hb`ZSAW21AY`O0eO[9f`C8o>
l?[Kb>;NV0L73kDNhOiK]TCJCAn5Q:FJKXjOEFqha8f;GBqcZ9A[^=FK=\\;>KTH
=UU9FA7UHnSgBZY]n^aPPDPSo4<:^bpW=8g3kOp?hM2`3g<Qf@c6g=52P[VeeiY9
MYBI\^>?nIYnKe41i8<Indko0G;CCYHoOqVaIAV>DmgSSJiZiAb\E=VMTLR9Tp?j
Q=G44Xemh45MF8j\>24ap3So1g6IGfY>0=G7AhBe=R\O;i\<la=U4D`Gpn`O]RDC
JWW>Xm89_ob062c@jTG;\`jVFO`;pTjhaD=Jc^62pU2_GF3N8X@XZSDTaH?k1ZP8
EHI=XWD;\T2a94Pqea3aEVOU:g2>3?`:q`AWaa2P6j;WEgTIM_cOEQ:im;ei24Vm
1BQMGG]pkT_JMS83_Xd7hU4GH<91`^HXoC]Y_Fc\9lg84GW@72n2jO7QPLJJEWi8
7hng@;oGKmalZO1AE=f9b2Ag0S5@9JSV4]5qF3W=^eM1EIYB;5HoTCVnfNQ0b6b2
j0oRbc5ANhGEQoRZEEa13foHiTaOS:aZKfTc0X0QqOc^a;cPBZRgK88LK8b3oJ7]
4eYZ5E;lUPf7PKFHEqTKKLTA:h^CaPI\P98SJLQ]`<=m]XWlnT>N`<LD:7;[TCcY
P7WTC0HDZPL`lo>0:=CHPhf7kih\F^g4GU>=7<Yn39lBIq<T;e;Lcq63[SQ4Hp8X
^KZl6b0RMl@R<hPNLXfcVMn[AUm:8T]R;R857fMBUJUia7O3IloMB_`OfHfAnNT=
`PMGSRqQUdX30N1U3H5L7Q@OHpkiE3APmbb9Y4WQJ3W;]QXh9m?<V?3hKR6Xq<4c
d0e3fJB;Kd[7^HmU5gUIK^`Jl8GQ<313:ICghI]CEA@FB:ADWQ0AJZmUO0Q61dG[
`QWBdn`Y79<:aJ4RfMdhoiX?UnQ`9iS\E^2<pA8CoCM8h:`a:lYEKf@=S_Y19FC3
XPG3?JflPp1R:kVZLb9SYClZla]2ISFoDQF=Qg=5TGb<[S_Y9]_RWG227j5hLO1;
QWDOQX?<NPDZSJa;G2mNfG`K3_gJo@iXkfT2ZOWOk>GR24OS0p4UZHJ1SiF6Z0]H
ZLnaW8j;J@l\5>Q9a@M037p^_:TE8STQ6fI^HSNDFc;\c`4;4Sok[S@SUZHKAUhc
@haRfJGBk5cj<A5p9PKReEI_6^IkV`Ak;C]:Hml_iMO]ajnZ9:FUhCg]LQ544dL2
=caQC4XGl57nEPiF;31SW3VOI^W?<XEEl93aj=ZK]9MB`^g9IbcFM=Xq>T0bdOCp
e`LbBBXpdH^D_FE6Co2BV>GV=T;C`;oieHJl`]_jEGgJWP4GR[L;_9R_lLA16O77
iPmoaTOUHkND1E_Gf@Fm??O:0IjqBLRhP\ipXFIKAK35?UA6bQLGjk^Rg`cLKJJP
2]\q9VlT:S\=081VOAhfB<8cdlfgjYV\BFa]LCaQ1h:e`d^3GSA2?bH?[cCqDl6m
AEHpIn<h\eeLE`q<Wl3Q\F2=fl>a1hb@GA7eJYg8BBSIL_PKk2NcBC?oPQUVfkAb
`K:n61]DTXjGGDY<7G6NUcB4iRA]2IY@0RE2N<F3>WGD?p1kMO<TP7cEdR@o>o\>
M8p`f@Z36nq@b[jXEcb;c6Sll[gMm;9c05Co500G0JH:2kQaXf^H50g]Vk]YIXO<
Kpn^OK>LhZX:bNQ4@gifn^JEa62AbbYNL?VP5ikBhe1^K;=IeaY^^qkF1PC\TqbC
8KODq6oMGSR<Udg6fk?H>\7QP7N8\T=A9F^:j^d91H9Q?RW5KOPJIZOMMlIDWBh8
]Q]0?6AMdLa><9`b:gi`<pJ;20XADJGOmTE4Oh0iBO=Q@TLF[bXUCNNGbJ5HiN5\
lc9a3I_\NgZ\PgcNS^mT4]J;28XF`_9NE_pSBV_=Ee[K5mZlk7498I:`a<=XH>a]
Zb7nJT0oi^8:Bj=DP?ThJSedC7E4o_EGRdqk^S4]B^CM3nIh\;hYPFmG;e[aV4BK
kZSR3g9Uhn?DCdK9W_B=?[HWe`Lhf71QOi1k\S4A:C=Z<HIpZb_hmH5Bn@MQeSBN
X_U>AEBAR;Y;;gePVm>hfW25hLBKV_PW:YKZ8B1koJ`Vgdf8adlB_?__iGTp;UbD
bdHO2Qn8S9D@DR>E;cMVkJJ[5:cDP;FmWUn_Tcc5BDLI6T67TbjQkJ70cBW_W:5^
L0f`HapC;We[oJp;=0l>lYqV>Xcg<Pl]m1ofSi]`P5Af6d;ngC=l_\dkYAlUL[m6
jg6n=h9YIIAD6o:NLKpl3ejim5b\nJid2:lkl0MgkfTB4p<aLQZ2jdBm_O@BcR3P
aTCgM=@X]kkj^KqV93[HZnn][H[R2A56e22?`V`_nZja`S_9PH_XF7FoYK1Ve_pW
I?@k3$
//`endprotected

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
////`protected
L:IL9SQH5DT^<`\bkX3[>nKH=b=;Ickkh6K>NDeaTP0fR4YPbWM\NjoYGBlY:opH
DRKkC[kgc[fDI?QpmH79m_2D9Q`\CFRSc8hVeSAZkVqh:`k0cpLKV=ilf1[Q=\eG
80JW:j:@Oac=BD]8HUO^oA0`jPIBpY=Y<Ei0qI>IIHKHlaUged?`NYS>\B>>_7?N
R5mJ3nm4GCPm5dRKqGe_Q<47p4=Cl=@q6oaX<\mL=YI1OQdI^AdHAE0YTfX3c?j6
c<7QOB^6d_6H2><Sk6YX9cH<X7KJ[NW`YBOeZXM0Rj<@`2F4W\nI0dU6WB<QmXqi
eGfeF;n3N0J_i0VeDX2:KS=1V]^4TS8ndXCb5JfmcR_hP[[0fUGXJ\0Ylo2:I6jc
8OI1UD31JXKC47bc\BCmM:VdQp:[\`AZ>4=WhFmK\ig;64_oTEMC1`^C[daUi_I^
n=eLhnieOKGIY5U1RiV:6EfaSg0`apT3_oHhd\EjEP43a3FdhhkhV[Y0CN9i9ARH
>djA?CNjgNBMbB_VI`[^akH6OnlU;0Z:UU1kbCT7>BA13_jRPV??J^P6pGC^J0`N
_P49_9YYV>IHo5UbSK597<<m[_045WJ2hO7]MCKV4k9ERL5Be6gQ7aXBWEI_Ql8S
gaV\b0Q9QBF[kR4MipoPjSL?OqkTXa1Mb:5Hm5mngeb5M2qM0k_dhCR7<4GaS_O>
3Iii5_;@`J_j<CF[;36nQm:F^3e@54XT3<`Rf_R]>:AHAKm8[2fbR;2[gP?M0CRg
U\DCV;h>XP05FoT04p=agI3?]AI_[Zc:LaVYUce2qXJ5Z2n@q^N3Udkp0mfSo\iP
4Z:L?JaZNcgcSkYeNe>]JL]f1KAFEhl1B@IJU6dGd:RD]FPKUB[U@=IaIfDaiJI3
DCEO6boGXX:Sa?=J<_Zem[0`[5g_eV6`aWFRkjjiWh=g=116dOVde66N0YKiHH8q
][Z@bLL\3K<`^Y9cnPKXCl6CX;=_[2;B\ELP>=pmKnfBA[R<3F=k_BRP<ncY9@a?
3YcQ5^0BL`4kgOYU8nG\lDVK=nEAV93R6g<AH=KN>U]Z]2W<4dkN7g@Xo>^h\hO3
Pq3D4>\j6;6D3E9fmA\F;2_YP3`d<Bo`6g>Vk2;OVYg0_5IQo>G0jgd?ggdfj_?K
ncCBTm7l0^n1NHAHjmf;mY[DQ=4:q4[L_I?SjYVEZEZ]dNmn^<igG8N21`>OUd0`
K1mFh@nlhG:P2QkoGC1VPfAk=7lh4klC;\:aEj@L:TNUflodk`KUIJ9p1>\cKmbi
30>AJCi2eFlFHPJ:TJ:M>>JJG9Ri?U`e@^LGHj^Q;]R0FLg\XJLeK5fOeP3KG;hG
>HPT7T?Y_hhb2cgFTaFSC<0k:mph;Wn\e?b;oP`Km;6U]o[>O7eZTf1\b7b[IB:=
]c13IdTbgq8Te<eaBTho7KK_0CqTm=W2>iUgmPSKS\`lQkRLAp9c9hUPA5n_W1[l
>8Ll781Aj03dEUliWaqiO<V<DWP0DH^CRG:\7;k54p=f5Xk6m2VDJdd@0W_Yi3^B
l2<i32O4doCT02LRN>m>BiVJPOe1SC:Zj@_80V5AW;a0c:RhZ5>e7FTK0G_ZMk2;
1pD7EC8EV7ZWbI<I0<=b9SbR@?f8?7dNX5<m`oVW1oHfAJ?>7[q5DWJ8?KpAdllC
KhqDkUffEZqEbcW_m5qjNUViAQb`b5P\hiKUm8^kC]QXOihZBRFgeT9<:A7BR_V1
TNCSAeBL:Q^]YJTCPmN5?jL?To38k2>4Km_i[@mi;LfcZB7<9eYhdqT3fGO4:12@
cJoDMPG=<DAY67qTb198?;p9Sdn5=YOOK[Ye<TeX\NfZJplcme[:Jq\bhAh^Id3I
Ie_I3>[g]=1DJB]BdRoG`EQ:UqXnDDe[Mk:_MF[1>MS53c6kdaD<l@DMMd7E2R:b
Qmo_]?>mn0@>bqo23j3`l]8O2NF:Cjh7`g:5Id_aV]BL3CogCpT[65N5hA?H8b=>
S_CdLmVX4T>E2=49D?;HGpXH1kdAqT:c2<_g0:BRLKe@UhCQHq1J95?DNk`CBm^\
JYYXFKeANTf6g?@aNICZkSTkHa^^qAUVQ12\ohbQ^;c7A?]>0YZ\B<eAih0:1>lQ
;MoR?8WpIIPDo8X\Mn<4eU]dcf4n2R@[3L`Rim^gJegfEj6O4BpJ>U76dNmGE7XO
SO;jMg^aYnF>^1>VX=96<MbGPVMeBq41UKUEm7f]kZi4KdJeP3qo0AoAa1qf;f\=
FCpT<Noh6pCkdlSbTp\NJjO`bqHk=Bh0]a[n:BkXE99A[Kl64e9;<DRB5n2;VCH8
P[g85AKBR0CBYLq11SLZL[pCEkM[[B6Rff0c2QK_4Cd@RJB6aH<6YKfQKC]l\?Bq
5K[ce3DS0@cS^oCY2TbaGU=0I<ISPND3IEl>0o:ENmOE4KkM@iY4cfTpIh=N38_q
_2ejGV3mGneKqh1k[Fg>iO7E51Xq9e14KaOMKCM12KoE:nQcgAZlledX^<qiI[CJ
H9GdMNS^L`kV]``_Y@\GP<MKg`LKnWb=7=TbONfGGF6ga`lh7nUgW\qT6hoGDS\F
3S1?7pZm:2Sb9<Lgn;DgLGVk2[hPcjWP4=9lqg2AGP6_SU7\[1`qUiUia@i`PBHZ
`><L>Z4l0]3;Vjj?]cpfAY:NI\TL>bFW_qdPNAIo65ILK8^e:J_N6Z9N58dN:2?C
pPIZ>@Cjj77q<I<@f[\a`Xm;@i_<?b8K=Hj1kP1HFT`q0H3=b4_p@bHoNcVghKT>
K=BM<@RINglCeZ4EW:?<E^eo6nEY]oX<M^kQ83SN3?TbS?34q[:S^a1pAIjWgKGJ
55BALaDhGXV4X4gBLP]LQ^ln_Tdn9<^V_FKGidL]E0<0WV]=n`f2Bb8P^H>aeKjV
`457OYIHMIX3`9;c4m>mIQ_RYWGWK5EJZRfODd\?fF23pYVBNoOHiAQ6PiZ6JTI2
DV6_X24i5<`Me6kVi\lknWOP:iG>7V31D>U9^3VT__6E9B8`0XlHBcE:nkQg;YQp
h[mha[k?iSicAGfVMCCQ<XnW[kPf;4o3dR6MTKF38_OgTT]WnVVj3Ff\NJ679e0;
;8]@g_=iG1k1mokon5pLm7D1ZHV>cHD3S]V:IBPQ@[`JGb3QHLaddlk``nYJaO;\
OMc;3ERMa]KXn=gBQ@>NUM4>`WYO??a^I=gIYpi`E>=MKqno_3XcK41VBcIB\bgf
90l38QKUY\MMM3VF?02:7UK02j<jgYRbZhY^np1j5TE[QVk7icF;@O_NB3K8^Yk8
[3H0h_66=1;:TcMlC;MmAla?8^``PQh22dHN?V04QS9n;NBYkb2BEC_^;>iDHfHS
N\OH:86`ONp2m5`[7HOea0DKV=CYgA>bkpL^4NYHRp1AL47n[_JOd:mGHHL<Ki9K
0\E]C6[3HjSEKm0:G]3]JN8h^PAXmb^jJ1aU^h\FNJp[B``\DqDdSkj5geWh^AjM
jf91F28M1h?JPN6ZVRNAjPHfb7_mVK[hn;OVR6O5[9Yn0QC<6_EjS[OPHJAR>;@R
bJfj6f8RdTjJi6K94anCEhj_`n_OR=YX\<B1Xm9Ff9ikLICe6WF6;BTK6^7Z>P@m
T^LW?TpAMl0[1Gi1A:95=PUY@@9m8OKa>XdFh9LU;CYLahP5PhfK49P:4C3;4>IO
i8KE^b2<aMdmaH>NFAeaWRdjnpiKcocjJX^RWR;ODij?[Hmm]gMY3[agjg]gJ;c=
8AKeom\I9Jb6e;2gE53E`CX[j9A2jL0<^^A4Y<02;?ekp<cSNmF>VnCg<:0n5?1b
GD7YDJbK9JTC<XN]E?;52OOKioNB4@PZS@?kTS;FnJSG@Kf5;dGP:aI29d8T35op
F:dP<GQiZ?Tlcj=p6CM]XB\WnVF8f\TRTOVaCMnbNTAK[?0Zd8GUS\Y@@Z[iTQ9N
[`F13>B4cY[9ffBDljODR_mE>\kk`dN2>7f7oCLgJXkMOK`=dRZXq\a`Qn\haA:X
]ZA>2mb@EY83D`>V>>2EIGaj4J8q6g8Z3b67;2YbX^m\j\9Zo`mXl9UfN7eVp4?l
glf<A82MdGhn8o=TE0KhT8@e=NDDSdFhHVLoQHS?pKS^9_dqXBMoLGd9bgNbqF:]
m2WR7@TKg0:UE@9e\ZPNV9ZmDUVmlT<bWiXCB`QpbKd`b^VBfGR@JLVN\54jD_i^
kiiH_bKfdgCPJYQI`Bp0m72kK9:TN_^P>Yei;]WUT3eB78M[ElYYN:kXW15bWqAR
@jgki\c579QDaYA754=M2cV93D;]fQZ[8cKY`]SCWaV6>;<Q8?CPA84dh4a2ALK=
qT[e<m=YMoAUhVV5YUcJEHA4DJIAcE2:<lLS[W1VY7=qf8To07Zqhb7YX]1m3YSh
I1B\[HD13d6]UWDWfiXSdoTH4<qm5[`6Fbq64cDhXpB4l\U[[57GF;Q44dEP^q1Q
kFdZbS9>VB:LED[ajZmh>Y2oQ8?mDmk\[07T;kPPeU`\]Q>k2>FfDjS<UnkZomC?
Q?\m_fD5_OfNAS96R9O;V4Y?BpMe3flemqXI\KoYnApoZQc_U`8RTfP[[28V]WLe
UE=CkQnc\lo]baD0XTfMPmn93OJM@U_A@b1_mkbTD>_pEMV>oXIRMO`OZP_deDTq
J3kYLIAJOGljRO37<cV?`g@[lDV7NJV:m]cKXhlP=8:2b`hl`Y<HJ18Z8ZOA]2Ve
ELNk:S4Di7dGo\1adj=ncJV@oNV4oNJQGDqN<5dZP3pYXbUU1SHpDa6MRO3pI245
W9=q9oo@HXfpj;bkhaHVAl=fQ=^HLIR^MLa<24CoQog>Sk9o7U=S1\0^?<=0SZEK
a`D\:6S9Y5^jBAR]_JO345E;DZYJX^;nJd;_7eJfTCnRC?qF>EB_dZUYikB5NPOl
_3M:EH:NYAe0nlhJ5MP`gAX7CVAIammJf>F@^jYq\mLbBPhq69<J^FGD3:Q73[Vn
Bn@KbCqAJAlnLUqOBX<iZQM8:1KnGnZE``T6?HngN^SYE314Vcp@^in0Hc>eeOg?
mBCaXUVjX0YYANGHjDPYcjp^RRZ[]Sqe5SR6jQgh7@hN;cK<X_\h]KK1`S^Wmq[Q
;ioT4$
//`endprotected

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

////`protected
h<3JCSQV5DT^<hYDfY02YfS4BaMnaRjp\ccW`M3P9o8<fNm55318iEIXo_WMF_M;
T\;pLi=?3oXAD25bR0T0blXq8lJGeDpX0Ci8TlA=cIJ\dAf:UWWnVhoHkc92Q^=q
?UH[KMj7f]^5;eAomCk4TTq>cgOW[_okT\V=bng0dZEp]lSALd4YhEKD1lL^Y`>=
m9M;lY7:<38kOdUSj9a=5^`TbeD>CTF_I;0Rhb1=oB3@`4B;LLq?a4[R45HCVZYR
QMSHC2Of\NZh9d1BGE4PgqE9;^_hDn4:eXWXB_LD=TE;3EdihQ]K[4o<]MqYROW=
oZpb16SR[1iR3^l:Cf:ZQ[Co`T8JO:>3lCW?]g4XU6OeZ39EhZJcbCm:DHqI[bDJ
gYL1]2fibkkL1<GcAiTTBQT9c`3^i]8iZjH<?LJOH8dpjU<Ljfeld[1AHZEdYFU>
BjG>nU\0A9H5cBF^MXE6FgLpno5jaFTQ0m^=8oEThm15_c19PUSPhDJO71N84XR:
D^Y\oF>d_;^^q2RZUHB2qeeT50G5FQ:6miaLocnL4TUgA6Lg;XIUH\PIC@I]?@9S
85b7]6LZgcQJai26nCZJ=FUGOb22X7<mgjj0U[>mKF]pBmSOFY<p>H1N[UffJed1
7=D7<gh<5;@k^A1U@X\`p<=mZ9Pb^c9RFbj`5dIgSbXW4q?N0Fe7l\Pc4d;]S^mm
4AYK6V=IU46a5jQ=CfRk6=ZeX`ihIM9ilMeL^9fgF9SMqL8=d\:Gq\1;<:g0p6j9
h9=_@MJZ=_dREX`;6EIRUh:DZBH^L1fO2IKqT^3TW^8p=3jPf20QC3bbNKJPAg?c
e<TWjDMe[o;OQNPL]DQcRd2gkS^N;2Z<;`MqCVZnEL\h=?l>W^bCbMLogTW3J`70
k;oR]Y:;j7YbZgS]Rm_dpl;CllN@ADi7JLeXD9fOdLi]9aWbe2>eOng3H?OHIegG
qlmR3`^eqnn@gRDZ@;\MCJ`D<GJNbV=43nYBdCc`\?8Mm>X[;0JVWfCA?nO\aTcN
oH4n7SIAWUS<e^KcNG67JEjB:\i;]Jn2q;d2[@B[JjXL121q>:[?lOnp@W:m77TL
_mgI1CCD5>?2S2o9^MXS1\Xjn18fNlYhIBAW6>Q[gC7EIJBdf38lK:FFY2`K1c>H
bS6O@>Be<WR[pa\[QP\MYDkmCc28O>g0QU:a45:DQQS\m0NZpbiTK8RE]7][<i;m
=bb5FYlSQD;WTmJF]Lc3R`X60;:55jAFFL\139XCBJNWb8fUgneOKP6:_7IY=KEp
mDU:TLkRB;]k>`77lQ<SXKg7eb9BBl<=I3Pn3Fc`d4?_Qb054_f>^kd8[V_9R8BG
jmmpDR\Yj]^qLOL?SQ9K19:8on08V:cXqT1bY2Ynq^Wdh5V`qf616kkP6T:3APji
dC_CO4o?kgUJ4bkaFe<qncbKhY5gWVZe;h4MEiWiPll0nie1R9dXD9[j5fj[TN3g
GMfR1?l\bCGgqXim25DfC4AZ;:O@E]K0k3dSDAApc\K@Q_UpWj[^[m]qY]0gNZhq
38cEEB>3cQ5\;7[DkN:7ZoWG<QI^m6O2I9LQ]H;O8d>]g_XqG<>i<j[B?5UnGVH1
<UO9?_:j?hPhZngblNUBNi?TqL_JIjPR3CXRPkY\0ieDd06D>UckZKM7@G9HM\W:
kjMeMq^]WmcjmGUif`;o@6\bUiMIj>[h^ISZOVAjE:8CUG;B0AP3H[dcP\;YRhqh
K?N?T@CDIXAXVmI;S:NBVIET0Cf0^U1>h2Q0ATH<mQ\NJmnA>B1;ihKNa6YaHCIe
R@Je1qDA\\Elc_Rc67aaaLAND[]P7M26mfSR[\1SJj8=SDbigE7BLKoek=Q\>6N]
Xdqn2b9DX]qmNE0d;D\Y<qfI:S4j3VAD97@CLUbVTkGC3CTEafFn`[\2W1dM2`@o
37:oI`qgg`NBk:\S?Y4][FBR3`6Vn?8IGBB9S0WB]PG<65]55mFT0T6X_X9L7na1
Vi=i;RVni^^?M>pU=4<Oe6;[PbUS?gafECL=?EC[=MSh]UD]dCKP\AlT27Mg]nO?
=iP=aq=OCGmamq:7ljH1qX?Xa5mJhR1DWkMT9NSiE:E75eoaK6M3``Wml[@8JH@J
Oq6NAWT?Z9YJeM6E36cVM8K7569DhVMkbXe@\1pV9k@g1eg7\lZE_ThMVh8oKD]e
MceUMk6\01`SP2e]F<Tp;5k>b^Mc@OjnLlG=7b\<?<IFm@If]>Z==\NdXIPm;[YV
6HbVaX1a=B;ApOPITJPVVB?iXW<X65?Yl@jDSTl^dFS7=>=RWV9GRn]S99@<X`S=
nYShTScRRph5EZCeJSEbUQ;W141I6FT:U;gOVmiBl[PKlCD`^EiFgSq@S@V^\DpY
LMD8G8:K=pMNgJJDoO1a7`N;T1@km:<nYK_fhATA=RB\RI<?jZ1bE[HU\GIi]]pd
]T0e6<k`bSBb\X[Z]Xhon^F:oh=N42fS<DW>?R_Xc=66KmD3efTP`kh8GaZ5QcW0
ANokCcFUWZpV0n`EcJqFRV`7XqDMR_SEceig`K;L3lk76lBam_?^H8m3b7Z4MRkZ
[7CdBPR@[5G4<3k1pSBdA;4j=oTG?SeCijQZL<[e3LRMiaWmoBe1>Xl8lVS1cpaD
2HgQ@jgB3UDGSK<bPf2]2G`[V9UOWk`iJGUYR_d^WJpk_W\6mnl@hM5?Um:e^H7h
GLC=oh7B4XN5OkS?=cAkJh=hVVPm]>@<9oZq4g`ojPGQJ`5\m9_OoZZMFn]CPRG0
KP]ZnU]GVUeN>GXU`a\6j6ChSM^jg?Ddq8bF=CaDqF1ikIFcE<9q[:UZ4k`?WhmT
3NLRDXnnY3K;F?]ZP;TjCk3`[NIX^:F^P@n6d1Hde^`NZ3AQqE>MBb7K1B[lV@=U
kWd[B9AXKa[<bXn5UIYkL<:RT6^e=3Y4_UQR`pI?5c?jEl;_XNF_d=X?6DF09^:l
MYS4NZn_Y>=jFm=[6ac?XeghM5L@NXh]fUM=kaE0oVCBL;ef2q50Gl9f;qnFKMZB
$
//`endprotected

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
