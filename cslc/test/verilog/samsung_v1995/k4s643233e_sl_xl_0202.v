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
`define D19X32
`define V30
`define LVTTL
`define NBANK4
`define X32


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
5nL7_SQH5DT^<4\KlW`G8FFO2T5HDg\AmnVZeDbQ^g4hI?4SJMS=dRlHhi\PdbB0
mI2jV7=W18fqn;DD@_B\MR?>g`QTqCOA8NFP@1f?P2[K_k2p5j>ShJpnKWI5QqT;
LDf;7pQZZD\bn5Ld>o5l[USPQZ\V_c`lPfb:phS]5gLUaNZYLUh7A9\mf4BOVYfL
XiRfjSK^mWnoG2640<HgQoheoPHPRWH5qOUF`\nPnW1cedZ]8XU_E43>JMY8G`Di
UQmDJJoqD^d7A<CH543nQHP^b81LBoGQPDG4LBEYIjqU:Pg=765_UQ]X7@O?:f:V
PO]_C@[^?q?1]kLg9>N0H2O]aLS2ISXQGnX^mn;1:@6aJHidVeJT0pF5bTR6>o10
=IWBi76eF9NJOM>mc@lnVY:NPbIbfOkQ_p]k<KV]L`nE_XZlRaI\E?9BmAacdN;[
20qE?F9[:>oIE6>4MbY8Aa03i@>JmGfo?K==Cp0GWK>K]MIIA8G2ZaYAA?fg1\QC
3V=bgp9H9`OHoCO5FcmRam0L925W6oFkmA[nQJEX^Iaj8<Q7Yf[?e16_YT98K`hT
qT@V[0SLqTACn=D6D`f_1HW;C?V;MAG2OS0[6k>8NAJJ=pE`UG0W=13=Tj>\Z6UP
I<DhdI7VIUliVYXh3LU5QGQX2VfQ2qb<cE\aM2SC[R?m9L\RcCZ?dVgSG1k;2:GV
\:dL;VPClKqOGTL75Pq7SZ=1;1mOc0EafehCHD@C\lg@feJqN=UVFVVJH\bCWR<L
^?`6h8\1e7GOb11g82ZEE4A?LN<_EkbkE>oW]S>iq[gRI90V@55lB>9:b>8IIgkD
1h>4_?@A?\Wp^RWb`\[q[lR>?3ifQUcZ\I5=Yf>oTA]_R;;GEddGpk:;eZVlqiT9
\Mj<EMm4Fl2J>O5AJ5:cD@:^V2d=maDi_FIP<GTjBVcJE?g`[[1]^jA_TG6HifJT
<<4AjL^mGDE?g6gZN=gK=6Rm8YSj_:U1RGEIiUIX[GJ7Va^q[aDC2K]>B]`0ZI2:
Eh0FF51W6USo@]SVHSC=c6bhKDQ:EDaYJ:aIBdgZ^IC1qZ7HPJ<D[2PSN02Y@TS]
QLUTf9oD0eOY=dT\h=jVo4PZfFXRl?Lq^RT2jOS?gRGFD6WPJbB?QL9hUbYHkMYg
ZF@MD<ONg:N1OK[hgQ8Rp4hiU7?C?j`RTI:I?^_WA:KF@ma@eT0jWd3U<g:bgTjb
95[K[kI?h54S_Bg2LicGMq@P[GRm=<hQIj^ob6[Sa\UCHenYR>VBE\n?S1ZGVF<b
d>SEAR`BUd4f_Y\M5pT^L2<PoA:T0ZgNbqQG=A\<FYP[1m?^P[T_CfkKlXY`CGJE
E_>jl[FD<7Q5<HU4AH<K;mBo8hS95837IT]YQ3AK[k@XdK0^mmR4phC;Dn_6GId;
JE<2^YeL_TZ;lN4@UWV_E;WJCWSO2IYWnG@2]P^m>e8W<J`mKL_@UV8J3SGF_Q4o
<Y22>Ie\3ROEK@DoG^25oEBM5Pe3ZSiP7^dKp\=nVX^3ET5Eo0TJQPIT:dWeJ;I8
\A@AUQK>4?7X^Gj5o=eM6a]IR3Xb64j8in7;GpOeZ>`RkHoEXBQMiib_A>nD6pbe
\c=MXLIK7SUMJIf[Vf2iV3c3LFh5jJXmaOdZn;jih?35ZZc_cJAQ5obmT5C^gNqk
l:_ZZ@FkJ9T<[c:^nVONIUP[HTc?QGbLOo8c2\hX[ZnU95gAfB?<63iARoQK8OYG
He]i\Mgem9P^@49PX8ID9=N4b8@2WY`9^BIoaqfT@d]6E8:@F6SJi\2>0^?jK^\@
cAY2CDKAR2A_hi9aBWf4AIg6EbaPRBH_QkXk3RY7[;C2QQLopZjbF:aJSj[6k3@:
qhYfe>T2]Z0nZ[hPmfcBj:j?P^>FQjGCb42XUi^qWg[ok=6m<XJkjC_WH[M4RM]K
oRT`jT5<\DC0ka_qeXTUCW116O9leD1bfj;Ip:Ze4gOQF<AoH_Vg;Jg9Eo6p_mIO
dShe@DIkSWeaON[<H`lq5=85@Zo>;`3ldB5:9<hO>=@0EDOJq4oFAIVQcbk4D>PY
nDd]GIo8533`6e1HicKqeRfZc:@mf4TU81_SUWqA<AkEWC<<M:?fchV9O@p=8RHZ
[`j<GdOZKV?\UpEkBjHTK\XE9KnPH^P^8ahdA8PMVM3?;<RFapQlIi1e6Gn0_@SG
:Y>9hRA=e8Q8cnfnhFkTSJg^a0]MEdCPToacQRXf7Ao\3ab8a6b;o6G1=fXOmEn9
p`h_A8Y4fdfPW8[X0>j3FW4;WK8k[AAlaQN_[29kWoO?[d44=2M<1^KN_^1@;H^f
;`l\S[a$
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
ON;eiSQV5DT^<ilKOQcO49[qLRMAc0eZEH0:5HQg];SVe;Hg6;1W5=342N_5S2pH
eHOHM\jGe4OKEBg30mB1<Xq>KVMZ=qV4iZm?N;`G9dCQWmL>cnmiDqS3TGO\Mh@:
?VjD:o9ki=g=j[62<T`OSLA5_PLR5jPIP9>blqD[C\8FV5e5XP@N61ABUR=i8h2e
[D73R@M4<=QXq\;fcBKAlK\g\N6<>D>N>^;RSmZ9JWAi^_B]lJV>l@hgGE1J]jjd
IN2X3pH0Q8[=pkbHb2jQMIR95bd0m;O<VDS6fdZGpmYH]C]H0B2<:3CZp27a_]jS
56_K1_5E6WNS0GiPK`LZL57Ah78EDAeqaM5Q1e;6I`k]Mo9=7Q9Of0e<CdT_;kdN
MKcP^bf9OBS?iecmW>m_nRdKce6b[W>pRX;m5NlpM`nZXOSJnY9oZ5L_6BN7Fm6a
m^k0\HC]gYSC5EVF>2fko4Jk\j5;DGB5o=NiXE4^IHSbH7ZpFiE]hd\g[ddZQkDJ
VE]h;W2O\c08UaMcacjMXPScLIXSoVN_I7JcHdU2QR6hDgWpK>@f:9p65V06IFki
=hm=i[U6m_P@2HJkaa2cD;pejR0e_T<k2C_jbim>\ASmn?KO\CH:GDFjaAcQ4RqN
DL861cW0JCDJ8462U0PEl>n;RhQ5D4?qOOPihEq[Jeh`XYk>LHY2haC78MRb620q
D8[VUKAf<J3kA[iZY2BB=9P=I@2<WL7Y]T:PMHobn@lnYE[ea>BXRapCnGSRALSf
S5@Sb6[Ee2II=PPPZ_SCXW2Y=Qq16DdYBX1WhH^lhC?h;Tko8jcH;h4@^aY8T?5i
fXlD;jdLXjqKSWQ>Dq[KkAjc[p>1G_S18[6Z9D[T;Ca`4[MSm8=XOX9<\3`J;Y>3
N^h>LGm1Dkj1G<T@pQl<R08LWkCASVD`ZfMC30`p]=CBmm1lY`^AC^AVkX15\4ap
@Fo;7AQPMUj^H19UBKIFFEjqbYPf=GVf2o5::L^?W?Bm[Kap5_=mdPPSD:nVQQ0f
d=dRN`qRZhi9>LLNB4<l=?CceA6PCY51RmdE3UjOUdPTP=<??eM6IhM[;AOWfj>\
4e7RnITkmbp9>aQlP^P901ZE]FUCik07`pm1:CFaLiDS`nc?Xgdi1R<Jp39m>_?i
I7`EDej:_VHDOhS<=Cj1qi9dnT4gmPh8N2V>7oC94^7QQN=Ip1aXVPXXdT3ncKVD
^<hRm_Kc67l\gqYDhc8DG9jcF<H@_lSmQU0IYPlEDPqX=`7lXLk?M^QS7EV@M7m1
gTVg82q@gD3e6A?TIVR:ID8GY@2bnf1cnA[G`]]ZSf7WgJ_5l0UJdgM0Yj^45JbX
T<]Aa6mK9Ri_Vq9KakieFhND6098KAe[=Y\cL3U2gf:daqD\KO0SMg_7ml9MY0Q6
\?QdJl1Y_ONTMXqJiNRU547g=OKLb`]G<mnQ`e47Q^1q4S^TU8X2iIIi3dPEmHMW
N4_lcSVE_>6FN6LL04NT_A_mWG:55^\9;cEo3<q@60bVJ<^\cQNeVLc`V51Z_5b4
3f;Lk1QPBqR>lIZ6qVPZBb7pU8SQFVq>>IJT9C:oe;SaYk7CJ0L`ApZHl;DopLIG
OLee?WkZ=8_dPUln410C4AkXaNS1p\0H2NkjkE14YcF=CSN\@EB095^TdbLhpgLB
hFQ;Yh;ZcRbn^OCVFU1jGkIQg1SpQa3dN2`]Y@HbMh:]G?nJ2=[WAlno@KqX8Hno
]F@?n>i1?g`h`Dq9NgN?6qmA5PB1pVH4Gh5D=k[0G=clad9QPBlW_VSVKLM7K;So
m]XU_f@X4iZf8<WI61bYqCWAc^lpg1aA;1q]D8Yfl9W81I\mZBe=nYO7lnX\]9g7
^9p\IUVICbQ@O<6`01ka<jQ=6b?:?5^UaEpFG\`71eR`fH>eeGlVX0?9DF:?:bj^
LpnodMC`@MomI?<DRPk\=OPXgV__edAJq0A0E2\Hgp?Wa7TF3pMKaK0;5m>j;Alb
oW1]3?eS>=57CjZ^pTmDFfJqFUT8bG4qeXGhYZC_MHZUhLG0c:aEXYj>>JXRfe>q
b53m9B5?bB8`bW:7B=i6>X@G[TFS=HWpPPW`gaSdC]SRXl7K4ZSfQmKhPGHm95q1
Jj3WSQLCUCCWRC=InFXS>\CcMOmSnAS?DqhHDScmn3[5FKgHm@@U\`<G9jW4UjP]
pV9b5jHmpeV1=b<qNmE:Ch`qi0Q=5eRV2MN2nC[ZX[7eIidQqaS6ifVEJHE[LYo:
XloCAEAJR8Sj5CKpZ7?]8Acd`DdP\TBP1R=?9UZg;UIhe;b84Wq6C;O[TPiX]JNK
mAPP4H7>19lX3NT7mG6q=\Olfo1oaZHL[b]RVIRMFkkfGTO]]YnbBKU1kElq<amI
6o`_nEC`SU7UmE:WIYF:UCZY^K;gPJZ[JRIQ\847:bYi<I832malMYeO@m0QoMBp
HKcOVQo;4UFZBhB<ZOJA[@>odW5H9kaJ9R>`YEGapD40QkNH0X<U[7JM^<l8ci6K
Gd;I\;=\2J3o`qNVWLhN9Nn[0K0@GUb^73?9m`I=MQnS]:U_b>q\@Am6cHD1MF1C
B8;Q6Uj?AXYCWX^WZl7WZ:2pFn8>2UhB?Gf_;haJpE[>bn@N`<:Tgh::E;0i:b^X
I1g5oC:16H_GqC1bJj3CLJ^fEA2aO_QX6EQacag[W<73QcI\9nShpEHbWh9E61\>
k^cIUH5@@nVT0M02D4?5SZWAqg3W;:KXqlllA6H5i;lZ<9O>Pm1qQGQVCZ5e9_SF
KdR>EhEDVaHb40NQjJq>8OCgYVZjCVc[G_^Y3JbjYM>n3Ygc]2pZO\T]YjJ>h99A
[af;kQMFDY:?NGXW3dp48Lbda0p2VAYgf2<WhmDF=:YQ=eMSM6mJ9FTgO\bqGVd6
;dXfohfaBJqQ[L0hYf>YKJh9HBdTnY868VCCl`I8Bjoin3p[RS7dR58G70\o[HjJ
R5>Nd]LH^MTO@>84P=0q>>Kn=gZ<_Jl07M\Ak>nb0o84VDe53@ZGp?nHme`YqR]V
F8<LfkC5@SLlDob[0mA^;gX?Nk0\NGFUqeoc[=T?H^VWcW[DeEkl_EIROQCl?Rd7
65WPZOfd:WOc=561k?c;RWfV4N=NXOJm<3BAf2`J<pJOSHn\[q_WKjbLSb2gG73f
abhlU]O7584HJKMI`_fB?MXj0h<h\VSS]:9NeSO@5\LO>\A85]5B`7VLJcVEGo3n
b80N0ZaGoHqhO?6=^<;;gcC[D^PBbaFF<qH[7b_6:[[9XUg[HVpcM9oMGedO^mld
9<i<^dj_9dT5:5Wpn7hPl33FH:SRj4B4WDq]1oE74:l\;>JQ?H4g`MiW0=5fU=lA
6^YfY4qc^IJa;Hd<oOU47YOTCQke7OF1<K_K6a36Z45aUH2i:iWQ_UeNh<DnaNgX
o;^?`GhHIUFk6p@SbJ:JSqXLhnGalKif8DCf[1aCbak[QT@W6A82VJc2:ad3\Pp\
NW`JOQq7\5155CBU[8jV\eKbFI>MKIc3X]>e_62PkeM5cbjiRMfAg[KRjWFV10Wq
[g<2nGTLBSJWhbTj9IlkL14K_;AZh41B\\o;QOBPCX0Lj=[<YIPakJBNV]e3JTp0
WaTSUbqim<fag]k:mfD5Wa`^cXgW]BFLDH?k^<YoFU=DHZGH:KBdLajcFA9K2oej
g?2h1n4XeUcfO::;>o289;U3=V?Mdb3bYa=LHYj0kq_elHIdjk?Ee6:WZYUm^MJ4
6298f>7Bm<R=d_XG<><YeVgOCkC8WM<@[]L]ikYBk]Wc60K4p8=hILXcpcdj94KF
o^m?cXYfUTEZGpMPWIjRCi;bMo?m\_ACVMZXHFhC^?cnGB7U2n9I=^A1d6ZgmgQM
N]od\`cBKbMXcCj@23GfSDN>@9N?dGpF7\oIL0q=XVN:N_gDghq;hO3g::>[A`\l
@G?j8;cbZQQkP7_Se2RG_j^VUOW^LjZ;Dha9SDYkUIJ_K6Upfo;_Bk9q7k7Oii49
NBQWI]aUGI2KfbN\:QjO?MlEkGg9YHep[aWC\C3bIA59=I=SEMIehdR9AT^<KV7p
54TnQg3G>YP5l?<cG0L:cUFOdnIOo3;\]M$
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
FnYK6SQ:5DT^<M9`f5`S\]SSBaMneEgpgZTY[0A8fOhSSG?cnT=aC@j1]183e0Rj
>MgHV=e?hKZhm04_J_2Rpjf>aL0b@lA[@3kW`_=jm1<?4i]\5DAAF]^l[8`I638W
cQjN@8l1Kp2mQh?6pNYT@\o>m>\AmnQdhPLPhS8Fd1OXC\3bA?=ge?ef5J4BXL\6
B5i8=T5U>iCpZWH`cnASFh7Po78[QT8U@5;fTD462SFgV36FhA[C0:kVSE?jAn>m
j<?c]`<\E<[S2T8AGDJeaPjq@1Fa1iHe>00F^dM9G`1Segp4jPBC>kcB0:Hk=Gje
`\5\2mD]::BoR2YAiAUOX?eJaUnE9ZP4_C^?>Mp^CbVl^X1An3Xo4_a[RLI^T[gb
6E6HWDi]USJ]TOQIVS51hClKanF2^<3iF`5Cbik?;K^gKc`3?boQ0>ZcgQpLjD6C
h2NX80OL6n884Z<0@?PhhTPH^FnAIe>QEJKf7p`W3XD6<pLXe_NeFnA2QM>XAaRA
F?o6W]2lbgp@7ee>fIh:I:h9cD^_XSB0e4Z4V;DVN`L51paOe>Xa0q9b0S^<ho>4
`9nFd@O00^c3PN1UGhcEE766gZKKM[W0FATMK2>^lG2YebqJa[6\aKLIKT7XHATU
VfCDhq<fR2^8=HEC3_KN53B>PBje:=XTJ`h:I583M:`S>X@f_4hVckN\b=:jSd\_
>=4<FoJBNc=37Mb;KXEkf?kQBIqc3a:`EZp7cMloaf0MhdQ?Pl7AY4ibgZ1BM5La
=^q>ncSLEamQAkOjG:R0FTCko\c8Kai`;61DoaG=@CdAKa^nI357>n?5]eMq1WCC
09DF<<cnK6f<T[G<_W3HGm?UnT6XdAQAC?CNmheCYkBe]cL7O8d60C\:832kH_l5
G5Z1Q0Aa:]4Hf@;^qHF\ZjDJpF4cE?:1C8lMR^:b4S<4KIZW[O0\S\d9pj@4BFbp
H2:3B]=_@l:JTRQZ1hKcN;Yl[1Om@23V17SWMI]S7D>ZJBq]]70Dg7VebEH3g8P:
Oed^oOYR@YkZWA4\Imnc6W@[9]QL>5GKZI7h1FpcVPgT;oXESJZk<HJIMd:VZ7nM
dRj7iL5VH<jA612>PH`d0[oVa>]fIl?SV@h6@HP9TWi9bWj1IHgbh42Ef\pEJ@OQ
L[qCnS_11XhQ\dYgZDn<H[RBbWVeFh_pnDn\KmH>V5SfVRoECNK86T1N]?M_8L_[
V<BD4<;i4Yi`]2pXlkZL:aqCaCXh[ikNiPlUnl=@U=MSM4Qo:3eIgXiR0o:?8S;c
lmnIAX[3DYS=l76nRZFp:lfn<R7ODN2<@AQ9WiiO0nSjFMFn4S]<\koBY@0B?Z37
1GCikEdFgjKX@SI8g8>LdNB`ZJn4W^CBDipFWE:a\5kC]>[Y3?j7\KHIH]?B5`h:
;CL\aLNadP8Z31HfSY54YlB6^=aARhhkdkkF2O9f2d@5O<8XCY2NW5nfUoLeOd=I
mpj=ZaL?N7:WpnVLW9fQZ?ca[URX1IJS@:9O_0YqUOCHM`\?6h@SV>Cjk@F>69;M
67jJH^]0[ILY45Kq7^d26M6P]mIm<7EU]1N7[]DjLM8aR_OgTj[Nqa2en<21q]B4
d_]7qK_7O0=Wq2KoWXNWac6E0daZ[pIk0on4UbZTKh7ZG5[A;o@OTfPTiMOWihpD
>iJW\Dq835GRkW>jZ68AhIMZIVhO;Xq^hAeoiH<eZ8b^=077beY\[_60eH<p?7a3
PLZC[SLjCm^f1\0A4^qM7R\S>ANSEjhW^eEA_F3qBD:S9flK2PcDf?bS2b0ZLbI^
nK8i=MCq]c\j;cSO2QD_Ea:hK2?LO=N?JERZA5@VG1q=GZaiXBTOL3\:`TngE>LB
SU^:O9nkUU1W`q`a0@339Ti2lR[6b435_6lIfC]OFpEfPJXE9@^b_HL_eRXO\GYY
]FKcXYk:G`Yhpf:4RYb2qfcSaR9PKPJENP?1oHd>Kj<0qVnm^nV25]S@g]i[PE[P
hpR>Y\5L\MD6^;O<l_GOO4^KdGcECBTid87XL:4mOZ;TkinoLM@dL^EhnbFQ?HS2
]OLFlX<9IE@BdcJdl3WSfAO^M8q^Tc\:\oE`>gmeIn\S\8PmYJ4k<qSG7h_i;qR=
^eIF[`Q<<hD?\obV1E>_T?ZjkUN3IkU<2C_ba<^=8SliICF\E[P`f7pN`^Q_[6H@
>SoRH01K:]0]^;8S4JMOI0j08E[fbBC1ADQohT6M=amcgCUcXF@Qn9HRI`I;?B86
lUf@2Q0>IR]0;O>p9[6T[=]dPC]7Znk2Eep>K;MeeP?g5<lh;EaWieYmlDj:00nA
0mHMP3o3B:`FD6:YmoGl2p1lO^@mFORFFS193<kl^::Wl=KEqKVCOkXICWc\jYQ`
?Fm5CB@m<>g;K>n_5eZ]8nU]aX?JoNL6lk>@GJM@QD]FKM07JKO<OjGE4qGa133V
]p?;SVg=D9]JGZGgX?^Rh:BoB3TEnU51o9AHPZnBJEgnec4_9a7^Fee;E>][IERa
d>`bU^41B<I_hP1Vk>e4lYlW>_D7gBVg5Ol1GT07`FQ`pmL@<DmoP[1a95M;VcoB
I4=Z6\Qp51BOYDDKeY>M;cPjBGE0AfcRO6N^Y3J6@9@p>eAhQ6RpP;D9ZA]9C>;C
6=phVHnLYD`?3XkJ8DaUA9lh\;PHF`lF_eY31l2[6g]pOm8iCN?HMCjlH]\Ck<hD
Z2aM9=\cP0?FXk45`eTD1d\[g@dkTe943<bcTXUcTlOJOEKJOh?iJl8<dkYbk_Q2
Ac0WK=cWH3J658=AHWT_8HC9Rcpc5ONTomID`bQEEP>1B4hJ;P]Hlp\nUc1Yap0c
PC=F@9[@<kjKO@e43514:bmKi@j]bqHZXc>R8`NWAcN^=9Qi\jP\=hd=?`ZF<bWS
WHme]pX=dW9]?lLEP3[mUQoOERojYRh<CO^?H3eQ7a_mimIaFF?3k9U[5lMRR_=m
=h3N^[kgdW5M0nCcq0jQ9QBRm0oK_gD:J@MUcn;7O;9CU4DgFZ\D[G^E6n;lS?Nk
OYVe;aG2ceV=k_`qdf;j_621WWl7hJIlg]I>m;i<2jK@qo7OmJo`cAJC1ED[?_P8
ph`_T\9EA:9<NJgboE]1m@29?1NVVX3_<FNSqA^Pc03m_YDk24_]B]ajJJgEMZLe
WOSHE[HB]E7c3@iJ`WkDY;Y2plMaF]7glp6:bkC=C9mgKcJo9@AT4pC]n>K<4=A@
=N]2EgZS>;4T5]R]WY_=nQ>QH0I?YNUop7`BRA20Y`=o2Wd\YZX^6ABUiTf9ilYl
:B_Ja082W;^qOmVh]X?Zd^h22PnnAGakCJ\dOa`l8bCK\5EojB4k]R7`k4G[II8q
OcK>ZA8i=lcX6A2mDNDicL561A36[mfkBAhNc8B5MC;nJn5=Y`iS;b6JoX:hE\S0
3IV17OpYoAe63HOpmY46L]ePp3aCNIaVLBJFcEE\9kD\UN60S@1_=SOZ\q[Vm69a
K@RmACeXiSd]=A<<q;L`0o48pi<77b^Ilk:J3nD^USB=lUF_Ln5[;TVO@T<2Xf^b
k5[93nRf@P8H:0L<I66dA]FjghVDKL8>hA57UgD8FlZ86UofNR[KLclgQImT7h52
PV]3edleOeSH8dOa@RK0WFmq;;:Ah;[p4M;@jk9`SI5i\8LWoXZEm<qbk^XK4EkW
^g3C\_ZkJoZP:=1JUH<dZo9eVYH?LRom[5QDMonL@X63dEjQl8ROJPXb5D9IaSqA
eOXF\a\^X<Hc^=Y@ef@6]iV;>:Gg2a;h\A5c0b_R?gKl[]3I[ToTm6A9I`YjJQ1<
>anl\BH^l_CbbcgK>q<44lL9WMReBDgnhofE3VYG]mP@Nf4Fkdd1VnCJPnj9NSJD
;?TA8Fh<pfNZd0AmXScM\`]QN`mmG687ZpPjU]C@\qhRRIlRkhjhfV76ZXPLWDHW
]7gLFCTlFg<XaLUlZnMX_Z;a]5CkfnY>H\?Ke6<0BcjTMal[\W]\IRQ^?LPOiS4g
5>W8kM=ZF?QZ;RTndS=HB4^GEBaC2=NnJjYKTLlYXTF`nq9>o:XXfq0V5b;FHN@_
GRkJF>L^XOPA^I9d_<QHA3lVGaI@e8N6N@M3@Ld?c86WWR?RXE[\>RNFH5pC76ce
0:`[E9C\iT]FS7jIc`X4K<XL9DYbZ;JD6^P\nq09ZW;fo]Yh6lJ6[JBnooBh<`c3
BW<K57f5DMAl5LYXP4c;NJZGBQ\o5nS?X@8MV<N`ZmdBi15IpiZaC5kD2`i3B<2N
l_Z]KmNNReHN6k?7T8U2JqMM]5[:9>bg:?9dhO?L;XBQO[[kV3GOm[pCEc@QJWBW
kJM5b\O8?9q4L8;B]0pmQjYZ[UafBL[;GfNM2X4^XkiNl@5Hg<ACm:T5Th062Z[R
;k4JconCDJ6SWBhgGMhECC[7]g68Y>nGbMZC0\9q4QMHnVIaWk1>LD=W1Y^PP5M:
pKISd[X5qTL7g]haQm60BiP2Ea8cQIld6g`CAWd4<958RH=Olj`c0JZ55>Ke?iFV
kYjB55YD`ceYQYMnRpZ6lCL;Aa@XgclQ6074Ngl@D^U86Ldb0IWlAM]ZQCZIf3d[
2PQa<M:?Q[kgh6Kj=Ab\5C4CFK<_0aH0W4XhnGPe:EUKg4hR:<;f\6^j9EonOaD[
2cb=Thad\dH@<<qnE<0G@\p?ci8lC6p8WmT:RpfOSZ[DgpL<gi2C73OERG?[]Qbk
;N;:;1IJj^pKPE5DVel^b=aX]F<6gLBM6iG1?DFAZ;Cqhda9f[\ph4i;KHRHT5I[
clHgYK7_9kTICmhgeCo73<?@QSI4BWV`:ei3FUCe8]<0K2qB[U=KX<?<iVJS;noM
fRB9=9jqf>URf4LCJ7]>c][ipg3=RBDnq0dZhd>Z\]Wm74hdIDhX=Qc<`]7HIpc\
<eNdW3Y;2KRn]WmPba_noS0bEh=Cg7mXKU?oiBqH?k8e_EU;1:0H`13<`JqA`B;a
DY]?PgTJR?SI<[7HH6S;X;3W1IiHa9pJDNF5n[JQbLaGa^W0id\2TMjW^VTI9hIo
Bh9d`[=Joo395>^2nGpZ3G:]6NFq>;6fV][V99ITGRn<^`gpQ:d>gi2aH6iJ1<_1
k@W0iK:BRg1:]C^H>XDU@^E>5:qLRG_nQ@VeLNb05A=E9choB:lF9EjiMFT^BUO?
6K4ThpjVkZ3Sg<i:1Y36^[\R1=XbRB@]aK6nNh3cT_c8gR@F1`L6Bd85Tp<jIe_d
HHInCdiR\2Q9R4f\;@W3lP79n_S_b;1n^Bdh@6S:VJK2`EIfkga2q[EBYJ58Lp@o
_K3;QTq3X970:4jH8oLJaXq=>jWk:16B^Z_ck8D]Clo^Th0QgH_oh@]e9W>fiI>`
4jl]9q>E[kji>T?QF0Tn@`iVa2X[jTne;YSj;[K=YX5cOpk:bnnA\]q88MC=K?nQ
I:>Jh\R4;?nlSq4SWED0EqN;M0TiU<]:e2_S2HR6ACiMnBNV1lZRPTEOIb_<2?CV
dh]Y85HH94^g:B\2O<ilAYpCIQYDDILZAhc9?V`pW=ZciC>nLioFSiiT0>pA<@5l
Y[pD4XK:@Mbo]]9kXjYgdF2Pj]?OjKG1H=mXc@e=K8SJfYpC5PG^DncilLEgDYRE
h_\5bKEp?g5?SmlqL:jE\kdmG_ae^?1ZqJVEN9m>UfH5kDYhRY;H7h6Gb0DRJ:7i
mh8nWd=Nen0q5U4`oE<pHPl@R2j^OA=dUEU2:=U?GAXJRJKDA=>K\Wqmn>XT\GaW
Zk^3TX[?LMp2Jn?NZOE@nUD9neLU28@8]8WN>;m6^UZpX3AB>Gj1_g]njg?NU?@e
HWbPclliQC79IK@o_icG\fl3[=?ZI8W7=4J6Gf56VA\Z`dGpEk4;9Fgp`RVZH>b5
K\EJVU_UjL7pO7;C?Z7d^DDVl7WSfX>V;TdhL;q>UaN4cfp:7kVIOTp7OE?Qa3?T
GB0KCk8l?nZGI\MmZcSY60KS0B7D3WGjEBM0JfL>5^VFR497kQmU1oXaNHR8^A\O
8?<joKJ1C>eSkkM0iI7SL0J=XVcRZ4MVmaqR64WkifqnP@HfS4]MEF?cba\fMX?G
9A6RPRkgfWGWWlB;1QqH_jIb9q^SkM^:bSeA=qN>XhW@d9ei\?\0_4Ak4i>22A8b
[YIam9Z?ahJ4N3=n5XG\1>NS_>HbZ`2iMaRo`oQBa0A5XESn`;khAB4kofBjFD>A
;<BKEKZ;7:?VIJ=h@De;9pn5h`JiSqRS0][S\qdm`NXD=SO7C7KgU59M`S`UY_`W
qFC6N=>YpC2]_Ph>q5H1BS_56=1SE^P\8kb@NL4hhIVKCIHKi5]qD73\R]JO`cYQ
M7P0oV`OcdohS3C]n3PPpQ4WecSHK`8JGbM[3\81WSQUVch6jjH1XQe^O=;_^a73
XF:bdUQVMYUGOpNCjOUFD\?WJLBm5Kp^9f;PjipJRSijjchDXVil=01e@EP3fPMk
n<R3QaZSHpQfl7J0TAjCRkL:I]TQHbVXp9eBiWJmj8?H8T9f`UCGqXgm<Vbk:?GK
Q4iC1kD[OR;OI\d1@>FOLqYSEP5a@q?Pbn\3L`2<SeM86mekHqSnA=?8f?B66@be
2VmS[\GE5l^CqGKHEH[hpFhINZYoqHb`^^LWD3=Z>F_j`F6<n0XdDajmT7f3i\c4
bSS^UMGa>nKG4[c9[SEcDR?YW1fEV5KdiW01kn`8>_l<P];C\VhAmJ8D31S3HZ9M
\\;3McJTq6oeAHfmpf_NYkWU5ndbeIP>g9UGp[g5?05aVi3>=O]C`qbiA:`ZaqUE
Z_IXVoaB1^A<FNEYQeiMLD3S_7nl=J\hpJe:O=1Hae0jVcIA4O7472YZ?fGdWJio
JOLUDAXgpL_8@TGkqSjHN]IMGc^Hjag5AfakV69Ud@ARKdUH0UR133a[RPbgpNK[
BEhj:?TS`e[\BlVl@S3i_]JIkR[2Gfoc=p=feCE8\g^2Zh[0BbJ1o=`38KNaB5ao
7e:M:3cbaRqFYA4oP<llQ0?L=lM:[7@l?eFoon1lPg]@_lXO62[]C:KL@f^ni`_@
BOojOVFRcDQp?jcn[aUZjcH287M]dBZ1Z<[SUEf5lbHC5IVRXQ]jVn8nY5KONKiW
b9@6]WeemHn:?><]URT25UnA=lEnoX\oK4UO7a@;GajhklWMOO8Cf:6@HC:QS^qH
ncji\bq[G^HKCDX_VUCeVoLoDpA2Vf<UXpg@h>a5:85=<=MDkc3?5ng]6W[X280<
4e]QpQa]GJjSSeh0LD1<_K23LY>k6cdf8>VJKA]h>j70qfk?eN:bEN6U^`YjF?Qj
F:>BeL^dlWYS`Xd0_XCLGgHWmIES0<LA8f1V=P3H8DH^K\X`[kLb<]CccVf24<Wn
Cil@V1iJB[YC3:oX?gd;o:lqI]5iE;gFMXFQ=Wi;4k]L[<gDJcbgj1bDqkeAgK[o
?2=mIlL<\Sg^hKAMW4HkNdG;Bn[E@J72a]NZ3YEY^@RO3mXaMR:I>X6a3Vgagg^i
eThX2c[ofJ>`O@MK9WCfc<?CccQc9=RNXVHGBooRCVh[Mno71RUg80n]`Z^CqXm>
=c=`$
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
hWb_OSQ:5DT^<FVDQTfAEHNk0d8H_12^Ke:LU8fq4U0UPFZ6Y\MG[5]QP`>c\i8b
QE?d]kHEeNb]?JU8dj6qM\1cdOWUd;bB;YD\<F@5;F`ZVe@1EMc7UDoiOnSUoEBk
@LXHk0OJj8=8C:[BG0pAA64LmqR`[H>;UXiVRD:[Gm3ZkS1T2:0K]>aE4<]_YRbJ
d:gZHkp\i6A\gTp`hLR?l2@ZmJ`oYDNDnYkOANPUkM@<@55JXRXq^RYjdFSp]VEh
Z>;NXHc6>obJ<IMIiP?>l65`>4q0?JbQZAPST9bAg_;YTA3=olOJ8EAE\D1[TOR0
RS6Q_UZP5lkneF]HGH[hjIWYiacF>LL4;e=Dg3VQM_5p6J<fGFL5nSVWbc<ahB<Q
3XIefTd7h50gcL0HWG_9>Y13qUVnSgfBYJG<8F]O`ZlX`I=njEe[8o;<p;KjDGnA
F5<5nY`OLP44JUHjX7;gXRFN0YOB2^7TURa@`Y^^i2`fI0n]T6Qc:6_m?<O:P5K;
qE3OnInEq5MH=Pi?qLHhZU_c6@:e8`:o?QU;2<ZklDgRG\68\qK3;M3h?3S^QG4g
YHL=DcRC0P18Ucb`7Fcm?O_XdZ5Y_9hG5^H`bA@Iqm104EGY]FMQ2KC_Ug7@nGRW
Rp?XjR2OfMSN;@=hc?4YbeI1G\[mXb:4nq;;QZ\_mq6XAJ]o1_8BHVOebNIjiUN7
ZaEU;Ui^A:o@;Ohbpg7_9KCIp5PNmA;4SiE=4LMPUlTJVH2PAYAKijBpo@?j?_Uf
`i>>fT450?fVAdCVAl\2a1h6XEkk2DRP8PF@O0<>d5jOEJ>oUITLiGT5K9RY5RBB
eObOM?YRqUWZPVZJ4KhBYedk_U`nE1YmiK4?nq8cOdZim`b_ElIC1PL5M8Ejd^^X
>bEN]UNLV];2jRn^QLk8V<_OTGBf6[9U;\q5kQo3R>Qf6n9QMm`23<dk02^a[<Di
c`mSGDDLZVcah4<]Xq?A`aDHLVZa8CnA<[G9:ImWM_^ojl>ae\qK^6d:n@qPcK4g
a`AXBp^e\L9KlK13ZmInf47=65l3UE;:;[3QASJhcDD@44Q@^QEcg>LQFlO;YpNd
WiABX9n=]:Oh;1lGUYMId92AAImP9GCQDk6;H3:OL1p0<7kK9GAiT\l[[RnZ3W^Z
IiPb<`l]`1q^_fmgM[q]iYR0G[qBd\o>:OqeRFWP5HQaCOY0eKA][7fl7J\V`ho_
O1VPWpQZE8T;Pni_ebLa:on2mEamOejPq6[<T3`gqeM=VKil5n5nM<f]=1ObLe=;
9j3iUMI0_MBIqDZho<`:698K]@[e:ZgXg?Zap=A5V4T[0kLRO4Zk2H@biW`cNbZ2
MF`]gXPKQ66K5M\6Bff0af8[VfH^p>2^b5m[oZLgFF4[a]F1f8\DW^ZBbOg2;U[l
j:PN6oYSn8:JanP^0:1hE@i89=9HYRf5;F@LQ?G[ZNeWj]f8p1k=5cmlpc5N_]FZ
4ddPJE[ISWO5AIed`UQJ4A1D^o6W[IeIDbagXJB<=iB0KGhN<::SCEX_>T_HpCX6
e6W1N<nR@FLh_Q8Ta;KfMkap0X;^D4FV<C>I:4:=Q^3_jnU?d0[F;h<Vb8LeOE[7
d7:ahe]X0V[Jh8E_aaPq@@hdcMg?>\YBDRB5V>l<E4E1oHHB1Ti=@G1:=aAdempC
=ln8KaQFHC9hPaT<jF2@[?TMf=7VKB4RRRU:PLD`?q?g:g?>qQGJJ^:LU7FL8Fl7
5=K?S?UES@ddFIB0X=`pQIR3^23\b]JcoEnSfkAiINLKPX<3Xi8NnLZH][<Um5N^
qBdeUnD=pG29ON[hq6<kPhEV1QH7?o:Nk]diW4LhPgO3@ePH@IGAofHHAMeI9<YT
Zco793BAVEoNP_I=5J3kbdV7R?K?6IXeMnKnUJJb4`L1f=1H2b5J_cCMn@ABYqNh
33>aq_m]0YEZ<hcU4kR:mQA9^;CJ>EK;o39GmcdQWjE_pVRi\jL7pMZ^L]>nVj5J
[UfC\p`^gGN_j;A4c2Okp^bH;S7TV[Agg^XBbeR_8ij`J^^kWlKfpD2:0^]kTeoC
KFHV:7?9amHb9hM:pM46YB3^HK>hOTPdM[Lbf7ZD;^ji185bOeeABmYjB1JOoPn?
KEF`mqd[Sgk3IlAjUd^::VS_59Vdoa`NO0_Fl6p]:Hb=L8qi7?^AL0q?XEl3mJOO
oY?51c]=MVd:Y]VW6PJXEeI;7Q[`mbX1b]GqJf4a`nJpnamXS]XT5La3U>=>dckE
]\[AWa^L6gD?YnHpR4cN?QPQ\COTNT\bBZcfOWRUlie8mh8c=cfGpV@;MaFYq1B7
T>5gaG0cDhhZGT<dLQ0be7D4Ui0<RqGd_]WP\eC]jA9hQL@Pb?RXLCHdTb;76Sg`
=c9k\<j^?:P_KP2EHaXi\^A8Qj]W4H=2NU4aoGc;XQc5]HpZaQVoAXqU3Hg2aU0k
LOS<nCcR2]hnGDhpOQ5@SXfq3SEg>jW94cU=_?bBB]6ZcKiq;W0[X9H@Dn>[`b[8
=f`lLT<oAaWQhcCI8BZO:@hq^k>lhVSp5`RVVlpKAa<8fWTR@U8S6A?To]YLoZDC
gGo2\9gk]C`XG\2a[KLk0RVO5ko2^6j3419jdP@[]8N_2JD=T:O8lGZpl1eTFK5q
MoT:`=P7n<4KL`@X;b<C2l[@X`q=5KPII4]:QljQGccTenN^4ZIJ=I>[BdAK?m^<
VH\aFW4i7]8p[C?8SJeIIbFYPm0@idnoLJEq7YKX[SIkp5Ee=e2lnH^?lHGddaZj
ToBeG:ja^]L0F7dpc<61b[YZp1N<DnTRLZglk>9889JjPI=oPihpReYc;9LQ[AQg
MYSLA4JgS3KBdnq^FIVUKSp4Eme@?bdim=DdVNPBk@m[DC=AYRITL6`1D=<`fle6
N?N]d=DKJLKfD>D2IgmfS2Vailq1?[\?_oq]g5F3F;WG]_>h^GTq9NUnkk7ZL9h=
EmkOW@GKEKVTigYOMUK`eC7=EohRnP@;<gD@RDdKIFUHYI^_RGa>L0@^V;]hqoBi
IW60$
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
Ae97USQd5DT^<O4HPXT__>oaVek]aG0M9N`828mN\M`dQTXp8?`4i8c^^KDPMBhR
ZUI?oCTGVMaJ;KP8OL`aeBRh6_jSAQW3KBq9:\dUc2QaAK]McBEDEi<h>84CfJlM
iDX0\TPT^pNPdYbDqM?KORKKC<49MCS:MKM9plUjLe_:a0l=^<VbX:1qBbf3<ICT
10g07l@XNU_MKQBDqMkK`KWEd28GN[OTlmRQIidplBEQCJkVVJPnV9XdT4RPlM4E
pdhKcQVmqD0EKW6MkT?4q;EFUf4hqQS`4SWd]U;]ZGjeaVV>e=PZ5Q6NAP`NiNOA
eT[M[__nS^0[p?0E?SO:qJ3V@mB:p]S^F\D]pUm0megca35<m`dN4Q:>pmRI:Y<V
HE6lX45AF3T`cqQn:<XDhfe]ROoeQ]L4j=mXCKaE]0_cV1KmI;V01iFl_>7S^Z6S
W2iX@pEl@jM>?T5<bg\EL43S<84Y6PIeMcQToA]SVOZNQ=WBVh?Gdk9LWHlJqQQY
4am\1R5qml3B=SgSXOGgo3[ObYn]Cm16BPRlZW33ETaj_FedLXP9h3DE]Bm13;e:
\4``[[QGLng82hS\d7Q<jGRDPb@e9h1;87Q`Mep\Jk`]3Qqh>UKl:6phjG\Thm]^
?HNf=jC=QPCpJZd[M5IhP8NIV>HhZl=onf`hW0h;f7kI7RPjT;L^W_5>0\3a==U8
N>qFM5hnOKPA_mJk\T[DZJTmM0i4bnnh^_N=0q9cRS6AVAoc;LAP:[Z9f_EWUkMb
iH\8@?978=V]q:jJRI^1q_nSjfG\fL29XQ[6EL5C5F>6nk>p4?h?5e2BHP?9W?o1
g01?65EcQb0CanoQ@FQR50b?0lfA^;ZA1hB7FFM1Z[2oGRcmQBEMf]Z4?<Td?dMm
WJdZq6UMOL9lpC2>[gD6mE_@hlEcJnOh0Si[1V24cG_9lpLf;j[`SXTN;O@I91R[
Tcdh?Iii<89EaHR>iDb8fq@SmWmbJYk_6o6l<WLeVQG3<:\^KP6fnp1d;ABV;q6Z
]K8]7poBe>0CGjEBqaWCO8D20M]U=8:FB@VC=fCCOcL@oM]BLC[bZcFHnUMC`IPV
TcGT6bL438:R1^h?9[]ei\G9^ZbMdV4:=KD<6e5C3keE6JVpLY[cWUopD0\Z3??7
_7cTLEK>?ImJab<WBbgJhX6HIh>i?@U0ZU\1j;:Io4a<@Ulg[@j4BLV14n`<k0Pp
M3?4XeRqiiJgZ\]qmmF\A<j_XJ\O=RT1`S2Oi^]q762aY3_1Q7`BX2=6Eo5B0[jY
6\6BBQOcWCXa=j=d^YII7kJ]hRf<oOFnj\iDLgZDFKhi8Wje87G6XTf=_=I\NHYl
ldBbD[fQ_979oc3RQATe=>q_Q]9BIBq4X]TG>Q?gfgQ5h5nU\5KH;jI`KCb99dUL
eqX04LoD4p;7mo\NOYNdlNXWS1[I[Qi^RZ5o]>cQB^O\Cp2dbIUc:lc`k6PKd`iB
I2=mO@JAjniD19fYHQM1j2k[So2W;M7=\n=LkC9lg9iALXVN?oHoJ]cfkEc2pgb[
IkKgq_Q]7NAFKf`VXCmfic:;HBKf@QK`Zib1FB@EgIDp\gjaINfpQ>nXF6hq;6aT
WH5pAC@f[FUC[\TF<D22EI60d]>3CT:@f55`@Eh?nl]VEeWKV=lGYKWJZD_;gg6p
aLOMDIj3B6aViZXK7`D1;e2lXAZMacON`:2FE]:5CE@FbY?0AY`KPld7o8PU3JbX
n>fP=G?n]Zj3dFXShQD];bqGD=jja@q>S@=7@R;1V?7>GlN`X7=2YQFEK`AEb;1P
JRqn09FP>JpacMl^cAqbE7FWcg[58X1C_A2`TL7;7q5oHIPFbT;h9iaeZ]ola4JL
:fY\WIp0Yc]d7Yq>lk9_Z?=c<56SnK]>HJ_4SXfdb`AjJqX@?DHhkIYc:9jel`<W
T>a=7c1HeME?A]fHMq>=DX6DHdOma[MJMF8LM>VTO9j;@o8FF4LdZYgVa43<RIZ;
>V6ffj7E0o?Vp6RnM?6\ae[R1lal7HKGKmL2XZSX2a7689kBkQ53Bc>L<j6Sd=Q@
06F3B7RQ]S7FoAmn?VlR11J>qoX0W3iXTX8KoNj]6kGh][SWeb]H]D`ikqBjYj>b
9qD1[mBc\YSib<Z4fnq^S8nKfopP3FYg[G@iAX]]i?P60BC=45fmS4jm\Eb^6Gp^
16@f835M6cc6dioZ7DFR=j=j`GKoTM[PYCo_;Hob5W?;FR]G2mERaFhCO18cnR7T
fHQY`9pL:m[B^Y4`_WKC[Kj^JFkRhL<Vhg2p\hCOF;46AhI0MoOIj^:dRbP<[enn
d1R_aEkoV[I4:>iUmUlU_3Jm]>Al7LLRG1k@\kQUcR:k6\_LV;a=3N?iiVOg3XjX
Zgp0570jGm`3>SGom7;9f0l?Kje@UfG3[D>`nQK]6[n]1P`0^NT=XFIMl[iHHY3@
LfcYWQ3^@P[VG5:Y7l]:^pg\<36LIJjbE[kc;D;cZCG?7iB0lR[ZjY4]7eWb3DaP
PC5mHWS]bYh3lj>nlVCKMB3bpTa>2T^H1H6PRnV1MQdTLP8LD>I988ecK\hX?o:]
KT<cfXg4:1f[N>KEecmRA5:h2q3c0cQhm?2KXZ^1K0_Ln_=TLK>66C8QqK43OKGB
@nB8La7HTY^V^bX=[NRj36WpI8N`bmmq<fE1F8JB0_Vk4j5SePpU:Ne[V=qgl<HA
P2d0b\_X3:GYGe;2709FmN]lGgUF:7pGeS2=RSGVBb=NZ>IQY0]NgZJ7T?hQ0]\e
d0a7g]]@jPm8[CKjcEo?h>FSPZNbiL3N?S<BlV4e54p?];1>kDjjk::leCXdSfFN
WFS9:D3S6OK<?1S\2W5h5AMNeM[R^HXYZdNL>qP01a^oQ>^MaCCSN6[OCO``aFnb
a<UV7OTeVGm9:l^>f:PHiSUc\CabCF4HkQZR1][\He7=[`lQ_`aQa5bN:HPd?pHO
M87JlUVCY4`R>=\cAq9c7MZM3KTjFY?lFh=;C55TRL]Uo_7JOqViXH2UXp5m;VX?
nlIgL<6I>f7a`8I8:7ZOU6nKie>YNqYH7n8ZlqVTXQA:I]YZSN1Q7LdNlEV@bm^<
[@@Vmo@O[pMUabgI6K5>neSl^<J_SQODFE0P^oYkJnS`2Pld:^AR2bX:EFUN=C6W
pLV?5adS5Y[Amh:HfD_[l\P1O0^=`E97@nPVSf0JjcJ?<<FSO[e9ObDDQ9PS1d5L
J>RfG8oUm5iQSd`TqU@4EQ\ia]YJh^O9b6^OIRH6jeV4[:5I`TcAe6YL<QZ?a\_b
j1CAU=JCa8Y\^TTPc6Z_XjNN4:8G6:N81=5:q:DAb2lTM??70KEn_qn8Sl[DMZHW
I]LBQnoZDo79oBA`a8VB^5nI3AOKSeeQ0OiSYBhLglqGkJB0TNEGlF<5P^cmd<`N
UgAPc1jOV2pO>O4?HdMVP6>8d1glnZ`H@i=FURABEHq`QM\_OEqWCY5\g_:^B:J0
<Z73Q4\7aRMb:CjonXWZE`plfM1Sc@pOfeIc`M8EY?XjTU^Sh`eWV:A]^YV8UEW2
50q0g3PJnX`cFg^nM=C0EYo^9jYL]KR@OlfENhoAn[eL3K]Od9lnl:n24phnn3J8
nLK3TINbWfaM=:0he[<9\cX^bP5;`YDc^aL_@FmP6ipQoZYZ?9f;<Q^Q8?W@4C0e
KhEi@U7:<OjXMoUee_kHcREeo3O;?Wg`[QTC?B>n^\WEgnOhQkYCXQR>N6pAlkL:
];JfFLCWFdjE]fNSUJJ:2\f5n`Geie0<V@QZ<3[FmF?cET=D9kP[O=\g?Z16M0nH
5l3Z``GXIf39Khpj6^S<d3D^;72>fMUqT6;eIXZH=JE8gO1Jd=`=bCB?]9McH8ep
06mC<;\2GBa^7GX>cj[[CSd`8=KB^]Mq1;M<?R2jW^dPl[0^=NI5W198GChC<9=S
fjQJGVMi;@XQ<ZO^Xn]`4h7eG3CpL3J_Xb0q_PXg1>ISeP>LbTMUMY@B`ZId8`nm
l;YbqHE5m1B8qBPloO_7C1dlXXi[1NeBG\dVd=h<L]9?Yb;cqPkgOI?kU4>ECRF7
=]^q]]i8=Yi78`OU^=HT=gP72?O\Y95T_ZNe0hiVObdRS[TW7W8Ga_8^@FhT@Z8Q
e;3N0Zl[qBMf<HbE@eARE311m95BnPmiC;@fZQIn;J]75hV67AJ]j31I5aj@UE]I
FRXA]lKSVWH2\Phll`PReF=lnZL?mPhhoU9VKd`ZWQU2qOlAiKIOQA6mPB4Uo5kX
d]KF=gCG3J70mf9iKl[<U1OT>Z3>j]_hZ7Kf40H4C4ej:\SWVkZMin@d<]BAnFnp
TjdPWmIdQeiBB3Ce[ShKG>0q>;D=[DbiMiYND[F`fiK\M>l2lf_I?hpM?`bSLRp\
eSUAT]WLIgX]m5B]iIhceRmiIbKif>2qQfThH\ak3oSSZ<JV3gBkPSjbF;leO=36
E_O2BUS3\b\<nYp5d\044ZqGEDnHR4:FmFK6j3]<26Za4X9mk`42;:8M0Op6_hEX
fnUBGFBlYX4lO^;63a896PXMi`<OoNRSI>n@S1XW7`9;IcIH2q;K^m\034oEol4Y
dn]1RBJD?1fEdXmXQHQ]l8QSNBZ\;AR]h=1<F1kbQalZ81aL3=Po^gMQRDinZ5Q\
GqdRnaB1N>UR@YgP>`?i?:YkCG0n\E6iC`1_B^Yh9V4>EOljXa^Mj[jVgm;HH684
lRN3AbCAYBU6R=A7[jC?qL_8R2Yj`FI`dmQHq\T:lhE=5dgGU[bLaC954k?e=dgH
=@YpVd\=6>epKJ\5SfOHilH5:M@E6?e5A>FoWh13b\9EIiL85l_qLlgTG5o`<>G8
]Chf7;\8Wo@Tn]efqPS6lO6Z9Rj?`n0Ro`<l\1_a4JQ2gPJqYLGVDHLpSYF>ceEi
Kn]BiIcGqbBgChiEpleDPY`gS@3T1l:Oa\><m3:lLb_Apho6H7L;p`TWSeZQK=[?
;2fHXnkZ^FeYH4:ObfUk6L01p=ENg7=10kTIhmK2KK^ddAYW`8_9;\W?>5UDG0>R
hUBlLBk68>@lk@gQF`Gb[pXlWD[0]idg0IZWCKi`>\^A8R@TTn765NPSgMbfFjPW
0<VVGEm9ZbP16?Ghp]X]g3[H<34\`2B16NAT4:e:3iQ=YM>i=MCLK`QG1PgkAE4V
_3;LPhPEWGKfW:?l4f@B;c7D4Qahb1lNl41q4cN[SLWq6YRj]^:O=0\YY8gVLG`B
bK8R@JV4V1p^I\4JP2p?1I>UXCRo_n^=L6OA14pIW:C3R7_^m`ak5<]WN18lR8UE
ATa8neGFc8pFKg^hWjZ5jBZ3M@1_@9@CMjXPe=Xcec_`ln[n`Al6_[Yg>N1LY`cM
Oj]@5bXPdWE[Rp@agUORUL3BUF0IUl;U3=k?YPBLDqVTYiS9P<H0:P1@^R3AA4Mj
l02Cn;@Vfl7n=6\>\BC@nScYBJ=5^d_mKM?g1epl4F;Tc;];jTFejI^Mc??Z3Tk?
<P?_>eXa4K;A@[jZb[ZBhNoaVkCAEC@j4D]YWnKO^dPi9gCMj?FI7pk\Mj<nN?NX
ZjedD\:HS^n\3`RD4[M:iUU0UoEXA3SL0fi@<7R>NV7`]U>le[O_Yc9DelFMna\Q
J1On>`n=G\;]Z[`63UqFO[j`2C^\80bQk7pf[TCl?UHW5;1o>baPd0hE[>NSV4]1
AP^fAP`2MNZ2Ya<OX]lk0m=q8]WH<?Kq?m>X6:p8N0=mKpM9Tedgap^3V;=FLSC1
`Rj`n1T0Y351O0IlFAq\Zg5HR<O1C\aZDCj43B9ANABp<3^C@VSl@=aem1q8\X4R
ZC<4hN^EMbjb0IkjC5bG`p]<40g8ap3[`AiK=LUB7I:K?FFIGU^cZlEOo`QKIC83
5MOk;@DhA2XZb79[IXDd5p=DY^31m]Ff504=egoDHEZ=LiUFM7VJmcR_HCq^ALQG
?Rq5F>_4IHNGhjJTZdKl=QfZD6B0iVd8H_M@dHDTSeNI@1Sqik?ZBDk[I]=SWkU0
?mZ17J4I4JfWpn?RaH6hqnJPi5kRqe2`eo7WqcGGNbP2qZAQ2d93aKU\L4gPZj`a
[gI\4UW=c:9Aqe@^]SV^gH:Gi40GB[<bpP<Ek4Io9fH\aE[f`@gdh9j_lgkWpkFC
;>QLVLdk]?h>Ko1CmL]Ge`>JfShUAq:@GGTmFSlY`K28OHTGm<jSi9^`>Z\=pQ0J
Z<5]]jM]ikPGhDT1HAnUhL`Q9\0B>8Q6QGTQS_^D[h_6=i02eP?GB[WJd1CP0ele
m7Yl_<Wqo6SjQh<pR4nd^QD_SO_Pd_?FZdDWQZM8><k59E1q\bbfGfjq>UO=:GGq
e134Zo`oi4P:c340OB7SKSpi2ia1P7iJ?6a;dNeBekcpO;5]jkN;cTdXUXUP=AjE
Tf0TCM]L1n2Y632\<]IRIQk_mLq@CKV3S5\9Hf75o4=c5@56GXeTQ0W<W@eJac9h
7mjh[e^[3g7ST@6hfWeH^]VeJq:aEBC>3p2E3aj]<J^SolQIRDl<<DF1l;:b6<c\
\EA>Lb1YnZmTBgNi1Tk:M[cVkO:BLSgL@B^fMcAA==C>LNZ?JP3\\67:iHZUZO@;
`7:J1OYmi>WXUjq3a9TGH4Z8O0VdBP9d8?q:QS3ek^pVTnki;5L378BIR?Z7giRi
9ea7_Jf\\L>qhZoP`eYSYFOmeEi``7;S]2W0DX9g\bATYLZ`TQF9mFB8N0NUIhZU
fUl;fo;nIkCOWknf1AVPq6lReHnlqDTc4g<YqcMWgT:NE`@^8HR;aYT7eiI;mWKi
>1=9@Bm9cQ5AB]C[h;dZgS?O97k]Ah\^OW]ZlnDm6U1^7d7gi<>;FfmqP39B_U>9
Q7^=7gjL@1j?KIW[k7d4AC517CT0RTX\bn:;_D1bK`F8YKf@qAELN5K7<BiMAhbm
7<FQq\FM[]F6qcKV3P0_EnIXJfKj^fd4fgDiddYhTYDq;Y_FN6hq<B@Q;AB^k94b
ROLCqaFPo]LXpP7MOQTQAgl5ZFRn>8@J33nKaeE_dWI=cT^=SD1_bC0Z]8B_3W<[
@?G\`1M^Z?gqkK>S`nda^4Do87UPc1cCn?3<j998q3;0kF421UG8T=A<MCdHLp1K
0OCFi]f:2TO>=`:CdqbQ6oOf^dM@GQZ=Z;I=<Pqdj0j8dXOD7FG1lb5EgA595>?2
]?a[giCJ1ZI^ObP3DihJb[mqjOo^mYgpTR\J_JS5N=iI@k:L:GPPq8@0VGnSV`aM
ZMe2EnWcL5@nKjNED@FFcKQgc5nlHqW<1AFgME`FWWf^j=gGnqEM1gSKAlE9UZmn
e_?R<QqP^aNkcdND:9i_E77dVNISKn0<RS4oMOj?@2fP;UD2Jf1Ga1Yq<4W\a^Kq
>RYY^B;oM74?YWnoU^qn>10U43b@<Ai\:LU;BLVqbc^<eD9<BMA219176WRpSOQ2
`L]kZ1;CMllPh6]kq36WLWTBeJkG:[5jj`ZheWhORVMnPJ?LJNia>]79g?IA29om
[>i[5<NF1]Z4VAQ21I`FnGmpFNMWl4LIGoK?4TIAe98Ym@G`;J0oRPYO<Ta6W[4V
BkT<Y7W[p2j=43ncp\^FOBOOeg>_ff\6^eh\GpO1\PCiU8i:0o7IkHlcWqJJ=Ma=
^hAmCJ^hSm@]cPpXFSQl?ebCTEmP3J35AlA<I]ZFIc;KKX9M2Q5a`Vi1iBJY0qDG
TC]FSkUk@6R]@HRYA_fFNJ`[S;@WeNBT>]FQ[nKU]kURhKqV@b9]^Gq^IBMVEf`o
;om^>8?JFKVpFNNL6?[UUR1ho1k@l9n=G2>38CYYpAC9QW3;HjMETCcW8571Hcj6
kZo<XHQpSa2[cfToX\M^8[7LeG:<CloRbUk`<VF1mf1Y?ii9[V:@ijM3?P_gI>NI
?gD4fjjkNdq[M_UaDRpN=3nRb4_9VQ\bCXA<Xa0C^aR3l9G2g91_d?@l93pbRAIY
Ve_moi?cAJl[l;mo;IE;cb7]>_>B4UP9;ZOGi2ZBIi0X\LL>fCS2@QXCcQ@o>p23
MRM]<$
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
YYlPMSQd5DT^<mOi48`D5;bUPXkbFIbgGmI8;W;WULIZC0i<6=dgFi4pEAYkn9Dh
1GKJI_GT;O0Y8@?ERU^:U3JAT^[qcjU\jPCgIE7ESb0aZAnA`e\9MfS`8Z=GphIK
5Ejql?k8E[8;b2NcBWkH5B5XpM_m0D;S[Id>Waf=8H\Mh5SdRq_QATMFko88N5BK
=dZbk=p=1Fn2PoL2\Z_nY=lDFnKHPhN]Ce^@b76RYq_d05<[RURhjPjSo7h08cj[
Y35Y[D:I]3Z`_BA4<aaRanm\181L:Q0iH3pIZfPJ6\p]VkffjiAk?JgUa9AjWn1d
an<fo:XokSInMDP;EefogC`Q0N0<d;Q1ceJOiP[Aka>65=b_W?X\I@Uq8BG53\o7
<9h]^F3F=J4cM@]pSZ[:UheW9[fdf[3HNIBflM]=HWpBdQHnDiqRbQLD=mbi=gL?
Ul4GJS>_Z73?K52Ea3pd5RUEmF8HAJ^g;XEikk3e\[ObE@gDhCPG9cDkJn=aA^q3
jAkf`db?bo7a^D\ci:T4SJL:1bYneBWeH`\q>oAPC6qc;MD6Xe9]hB5D;RGLA2o[
aX^4X38?4MIYWc4N5bBNAcTTIWkPk=Q?=HEmU8Za8X]lA2n;AkGO_[lXY6Ea9gl]
dSpBUchP9eL3Oa]2KWEh\I0fY48Xcj2][o22B`DOOCL66k:6C74j[SSk;`W0?cDL
Y2WVMZ8IJCFLfd9?5UPnO^pbDa@6VmH0E`l`UPeeeGP<CJ6hRm;WnEEeFdDY5SP@
4=AUZee10ZB[R@e:f?XB0J1=1`gkacqh?cS3BI0e]D@GP7L_b_?Ti?]4_4PGdc2T
9PNnmOc@ThD4<\L_`2T7Xh]PInd>`[FK2nUJkiU`JnB<h3B`L4pN0kUhL<SS>5bG
i<`I9;SdY^4`lEmCOTQfgB1dVnIF?[E6mKBYZfRT<?V94IIgW]@NC;;g38WOjb=X
:dWC1q@W7aje_qdLh9b;5XnO\dDXmK1oQbA0RM;ejIPDE5NkB7A9ETij6?V<0=V]
?4]]^_]kS:b7IgXfm9eHF7Wh[pHe9oP>0C[mR`FHFYVQEUc\3p:3\mfZ>pV_abmN
1COH@4W_BG\_OTLW:L8<iIKg;UjkO;A[1iH85>3CURC@XW3CjCc<qj2]BC;pBXcf
k1MlZ:K@SWXW;>dW=CCl<W6]P057A3Qemmf22\dP8ajYEIj>9n?I=e:IJ:G@BLcC
cdE5>LHhQn4DQ7N@@I2Hpa4^nAHJ43H1jXJ@f0ojQ6]<1c=_RShO2_:of^1^ILG7
o>i7XlPIXn@RPU>1G6o^3a_^Tc\2Ld7?0=`[DQF6]pL>AGCA5m4TO;<AAKPBeKFQ
aCiJHlg?beAUH^U_UJ?@B`VF78VI_>OE71@XGC9Bl<LHAeZbXeWnUYlij:R`]>q4
i8j\<l:6j<AG?^PefheV]3hoeh;Vb:lmCdW7\HEH7ka@]]N5IiTQhLbOR\1AVf_^
B;XNHm46e6hT_D]4KAqQmVE@I\p9eeVVE8odQ2::_?O^P>WoXeMd>N?D17TLaXhA
<j_XD4TJ^UdGoRP8XhTKdB8?3\Un^E<e@9IhIipX4iCA5lZH=DL_Eh152c1U:@q?
a6jWm>nJ_b:IVj:`m8?6V8fXbadQ8=\I8mSN9e5QLB6?\ToLDO<m0P]d3`>7l:mW
>D[@gp8I=TA8:qOOKhb@=4lH<MQXVG]_@71PiGKikC;EK<aaj:QQ:Ep4lGD?7dqC
d3ZbMmP;BPeEEkhY=a4aFV`oC_1jMJ`BTDaG8PaCJj0>`77EL2[fH;O;doAPaWQC
iPdn?j^na<26:D^mIiDG`UdX0H\T2C\nM0^;il\K793XA6:JepoToTnmL:m6Q>^3
o1GRVV>eVmqRhJbImiqE79`5Y2pI9Uoa_CpBiXLNfDKCe<fVb8]M]:RZ^S=aKi8N
0WV0[7iS?k45a:qJ>B7hSHo@hobG\HI5j4_L^:jXoPV_;P=d]K:AV@LqNH^0Tja\
K[2Ag<U6k;DILnW9H9FU0GaI=aIZV6>n]8BQ1cJ0KKGVnPI:cX]K<N<kYk@co87k
<:Cn1a9JpV1]hjYSph:YD7hp1^]FGEKT4X3CaceKhN<RqCm5X5ZBE8oVFlZTKTU2
g3Oj45]a:KL>Wc6UPqUdOYkjY>;PVjEg@;Nk1\nLYKndV\2XM_9>8gdajKnSWpAl
oRTMd[h@]EHIlhT`IinAXE[]Qe@HDhT]T3_FQfJCopFfbnNjRaK1kno0oG<3VFjd
N93UN]=6DQ>SUOmej\jOZpiibI4CNbCNi7:RVLBJXYjCIaSNj8LK5nXHPSA`R^hK
mqj`I?UnLqZQVN?id1@BWjUg23EValo?kN@BAWd4m?fdRVX>F8Yb9Rj8h?LXKmRj
^_:No^q]X6TQo@:IRGXSj_qAB]G[:np9iQg:?qTG1Q3L9`cn[dl89nBTCnpZ5ClB
3d[I4Rj4:oVJPf`DnP2fBQYJD<Zakn]`l;Pc:YpQ\GD5jomW@^ID;2FkJ_>:^nh0
\jYMHg]ERjJmL`ng@T?Dc<S;?DKYCm@=C2?]VET9m7pJG4<ZYK@?eGoeR\6h\`]P
RXbVe0PX^4S]n4g2YAKmA7pEN]XQf8MB6MF;1RjU]eDBR\IVMkXm>cSHdo]gM92b
NbpV9UO1eR1Lg5>c06H>Z5oHCJ>NZMUAP6nbneJ8>MGg>opRKQ=JRGqB1jjj`Aae
NGODJN^eoGVAc=mJh<agKfBpBKF_9\NgWXA5YFB]T8?^UE40kJ_kY6m^V@Wk`Go^
H[SeGZHYN<\J?[ha:d8UXX1\S3kf<eq1SD\_i:q:4iF^9Jk0fNN`h=lDBq8YF`aC
`kJEoO3:UO]2?dMTL5qXP6SCZJ7MTNXS8iE^kbIp=^PdU]\>:T0dUN2;IMXKd<f]
fVAaJDTYbnpdUB8Ke2TH^`?hP2;oeTk^Af3l2C4\I1d25XSM`QTPm>TUaYa_1:4J
`nWqHg=D1Ndq<Ief21KQG\iQhDG_2Y7DNk<2XB]c;16m]<DQPHO2BQ_VOQ^Z;nk1
RCdV6;?ncL<>X9VWBo9l<DIVpFdD_8=`h;X;SLGBeP1Dc31O]q?5gS01PDONihX>
M5UOS]MP^nO`V>CgHAJ>4nE<__Y=o__:o7oYq3:n3gm[pYRSOHM1^UIFnPcG[5Ob
7pLhRbGSoPedjT@4T;^QdFY\Y]7oJ[^:SaW[e8RMY`_eXa7L^0DEm3=`j1lS=V`_
2Cn:dG^\QIq]QWbad\Bq@77?N>Z=`Rc]W6L;G10`pe]<YJgc2RJBc3NPiIgS3j3i
>:R1g99?^G;BfSdJ@d00cKlk41J=15=DCK0G1@jP`d^q5FKobW`<pO>\g81fBcG[
_2_l5=nVn``qo49SG8naYoeg58=X>mbIa2PM09KqoZOFFCWnRk7_Qo@Ko2X>8ObN
1AKM5lmNmf7^GI4L<n;YG6;aT_O[`9<i=3IN9aHUg1q4ASnOZcDqVAYcXigG=EdQ
GWh7KjVf:[P6IUSGWahEnHZ70hpRn`Ena>Gp`U@9S662pUiWWlC]UpgaG<TBbHbI
eR0cii]jgh?_GZD9qiXFBCYH7MLlJlQ\i]5aX5A1_f^1Gb=:pJC[:I=<67lAO==3
^cakn:@S_B`d2mg7@EXRkNHV]VnDqo:onJ[XGFdWK9R54SjnJaR;;^U0I^T\PL3B
CqmYY>a<q=SKb82ge6gbT=]^<^k7Xo9WI?9>Q1I;Zk93BH1gW[G>7B1i_K4oSFS:
W\QSZGS_hfG4[3gZde<mT_[m2g5QgVY77GGp:1P;ddj37SeaGn<PN4PHU^:=Zb8^
F@UE5JkDLEIEgMP6`6cTZIj;l=2lcQEJCaWo@n5>W5YF0VS`mT6e6mi6QbpTZfb:
<QbmUfC9JO_:0fP_@ODM_4_\]IUMSjBg>X;\SVo^0>n_WP62U\QlD0h?JaRYg^hN
aSTWOR\\UgJGIOJaWqm;@aV3Q2e9D7YJ>L6>=o?3onF\<m]na65GMH3N?Z`bQfcI
0>^[BSe5[IMSBQTK?dmc4mB^ji=9Xc:hJAR[gNq;_W8Lh54TAgi`VM^5T=U0dqIX
Qd;AapAm_9\\a9<c>??3dEiL8@kkoN5BFRdU0;M<PQOd1eV@RQBSj;N4KfG4edRI
_a[d6J7:6UgSo^]onHp929IDmc_5FD42X<\hVhmZ?e1pT\Y[iF3qlQho0[k=bZ7I
=8m1:IC?C2RoUGg^kBg3@8F8cHEI5K?E$
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
Yb4@=SQV5DT^<8fHHIjXA\`MiM[714^J86UBQJ?fnXlKNWKX_9NA184ZX<coN];q
?9noY\:2GcW3lBD;591Hj]dfC3_7m^GVE]V1FED_Cd6@L7h^@]VQkaIPlAJ\ekfL
`=k]cnhq_i[dcAK<l8c?:RG]G3Qbicb:LlP`Xh?kmoJI[MX]@WAX4hM<fToWce]N
42>jWPN3o9g0pV0:[]OpU9j=[TKgN5<>=N@:nKV11DHX\Z@pemN>`;Cqk@[W3Km?
B[Kn3O_;D:J^D``Z?6pfGWbjI>KbIi`8[S0SJ]ZHJAUe>[Fpo?WSSN>\dE?hoQ54
QbTp583e2j0qC74HEgoWA@>ZOgN]mmf?[C8dojn^gJpkfEhhDaqZPAb4gKCSk_B<
9gF]HC?X1^TQCHqD02UC7i7P>P<ALWP7bD63cpPQiKN3OnF[Q86V?eEVJbB9NOcF
J_41FXDEKPSlqK<06=8PEgaiM7XZJiV6\T>jmh15Z;W67Scjc4K58_=dbBWjED1j
jURR;q0OKSf;[p:8]jOHM6INKKTHXBKVS<4Zdm]3@GKlSW5;>3WHO_gHlcRBVKSc
:C=WJ@4O7d\^93??NQ0fE[79@jZC=ZFZ:[Y=<qk\lJDfK7_j2[;dFMJdMGqWkHQ`
\Dp229c69m?;8Ua`3HZ35J0DIelA8a9QS45;;Ip:f0e5m6HU5Kdn3RWBcT;FDHU4
DT>2X\eTnbC\;4Ba=>hVIno@:oCbGAjN6[[@Dg<]HMQ\W5RLXW4XLB2HnQT3YFqU
lNS:6m=kimc`Rb\A[>GjoH:gi3:37VgQO5nK1<GLGGj3Mpf9[QfE2M[J;G25nFDA
?AqJU_\J]Lp[Qm9PRDXIk>L]Td0IA9FlLGJfl6VH:29Saop;:6AajQT[MIp`enFH
];OLY][UMDSPZJE6FcSDm=Ahn;K5Ll1TMgU<0:SB4e:UYi[B=6\E4S;:[G8jH6:i
WAQq:femMjSp2eiHXEKQ21eo;JESd^\?oojiZ?OPUaB;a5<pA7\L06K9^\AAUES1
_BkH04nl761?ZW4POmdK]`aiPOBTL_4p<GoLRkOpe;MaaABfeiM`L`V1N?VC`AcE
Eniq5Vkm:7U8QgPYOja^3mMYZgql:oUG2JZ>Cf8egBK_KSJl]FA2`e]_BP<IcTpP
221VP<oZ0?GlH_GOimA2;k[jj:?>8S;biTpTC9><c<6o2TqM[`YB74ni?n\8Nk3q
<O6Y7Xin=16EZWX=LNaUR3DE5VDOKS7RP98\WMfP?ogIFckdoVJC[;mWc3Oe0=JV
:FTi`F<qFU1Ie;T5Ol__b7^a4oeZP]MPo68GFU=P:VoQB<pYoe70Y5f1RGQ@Ac3@
NGNP\]YoLkLbi7onmOW59XXglheBRB]8=HS03WdMlO:Um5KEGcS4BDTDVllkVfl>
GADWBA8WU9pAToEaLCRmBfd13[17oFn5E:2Q<mH81_fbmWCD17dqk?FGYhFY1M32
ZeG7]Q7^Yi;^9j5l<@g:`FMDKG83^Y[d4g4nd6^nPcf?OTPJg[IXP2AoCUF`2GY^
5dXdHXdG06M`;R7qR82iib@plGXSNj3pIGLV;HS84\:V<<FV;Ep6gB5YeGjn5h;`
RETGGMO\U6J\D=?VUXcB6q@DE27UG:B;RZ;XAhAa<J@\Jb_KA5jabhD^^CB46ng`
X<ABJ_aKSRE7X<6XOKB:Sa_5PhmMkGKHbg\@QiRg2X>]ZCVg7Sf:[Sa5D5joJqMm
RodO^UR[hk[SYF>_7HMahUE??<X3k7]]1<8YVp:6ckF``H4<b`FVZj[0XW10B5>I
<d7d30\9NPpQ_;Oke5Q5Q]mc:_<1If_=l61GO=6m:]G?CWLAH10l[UZkmAW=^]e7
[2\615`BUci0?<[2n[KXe[[WOIl[??oo_UBC`CIcN@gG?oKA;ApT6PN7WVGd8\9N
[2>84gCGeJ>coflBB^g=ohaq=H2fKSC0>oW^c0Z>cdkbebjaKaR48@bXH9mLW^:]
V5Y6P@75VLCK\`]ebRGQh2GDOg\5O[l5nUE7Cj8X27:ZgQ^W4kP;_UUI=G3^2BFq
PR^b??KqK:bBUDZqY@;QgCZ]I81HHa?:[d:O=:n4j0JMLjA>7@0BDJQS8`\WK1^I
hWUQ[gSZG7<PZ:XZ0CH6H9S;MEi@eT23R[kqJWLn6X5pZ8H<j2BeQ8VjS6q]=91J
dmF63I4M`>3i>BF7lB;>9YY7T<qhDF82?>qaSTESl1JA]qdUbUCY]FCV6T\QoF`m
Nlg^48m>:\OAQecWkT6]^L9_LlhENFcW:Ki2I4UF?iS;5>dJA8lFfVZGcKW39aKW
\o3kX16aD5WSqCGea_27EE6X?>>ZGcVb>p]iPEXk9p3l2OG;J>HIg\E:4k5ZN407
hoI1\b]BTPfiPI`BdmU`OeRH;gN=7a]nq22^>L2nik<5om>NE<3T3DNR1]aqBUbN
3IPpKj@oV@pO;GZRCC]YY\d4aDH44^W9@k`QLh\U7TA5;;M@PFHIW[;[7V^IPckK
AUo0oXKlCGYOFGEKP^CH\M5GDV@pN6YOAnki;GaXQZiV2eLm=ljh4S=DC:\RUB30
G<9MdnM]oCEMgW9<R96kiUA`TBeiN[YaYYf?Y2R;pmKoKFMWgCc86W_d[2i>gTe0
4DKdX9W128B\1Yeg]EI;GW0Kf?_BDUAYY:kNWVSZ1mNoYO3dJNdXBpOPXh8EQ=dS
Ik663PmAR9^YF==H`:ISRjOPZBVle=V=i?4KO17VmYE:YDS:Q@9m[=PGUI6V1]Ra
>pNfkZO`cTG[jj<1jE_JdD`T0E4<`MlP8KJQnVh4W\_o41^hC]KbaA5Z`=4KYRD7
Fh=Wk7F3Y0HCplh2gLICpONQfQ8o81j[8<AF6757balUP?oJnOkHH`PX`I0NeqGo
n]Gm9qHm3`m_S<7lS6eLl5\?NB6LlZ]5p:gk[I5=6U66Sj:;VHli^@I\A;=O2``^
>p>K?X4V1V]a]\kAPc[eM?e3o2HINbn94;RF@Rj@Y\k2FQ]O7pnaI<3X$
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
F4><gSQH5DT^<Qi1IFm3]mV7:R[=FJYlT5AnYXkkI1XOd]BcN1od`U<E=GGO]l63
WfNE>3TqTH`e1oaK9je?dU2]a5ICploH4mTRN@cZ6AD8ZMIjTIW0DpmH7gD2pnF>
DfEPG\n=UF5;E5?kYENfU<37ZaZ68[^RQ0PCD\?p5mM4ch<qP=nbfTJ2\TZEQgUm
dfIW^kWoGO2QUB88b1XV5mm>M_hq3\O3=napMSoTF^q^:`e^ZaGKXBeP@PBjO;1;
ZP47@Q`E[f5ZhSk^;UqoSm77?06=R7JE[`7OYL]S5\K>jDB^S`6]^>A7O]G8:H@Y
77mkeLF9[K4W9QegJYEL2lc9[\WE[6cZ\d34V1gZn1S5Nf;;?pGe\?HKS;n6?`Na
^\9:inlWY?JLE3;EUoP6[L^>7<fGHRZYeLe_jXLdIkK^COT<E1L2`8T>L<RVX^fA
b]57M9gEO>bDq97Eo[S3Y:I4ilFRRIDb`:G<[P7Vl1<A5oej1A`PCD?G4VW5`Odg
3FN_aGAkZMNU_geC=kAjleWIXVnPUmLmY4VSjSEqTbEMA5kV`HOYDQ\2;i^=cUi3
S<SB^U<i2gQ^Vc?<GBjT1<VboO0fGIVPNVgU0Dib63h71ibg?8OHm5LF0;n6OomP
pMZdJ==aqA\^YP\S``JL=KULmY;8:`5KGlYkL_H6TNEEN`jYZTnWDU>nf303d`LI
ToE3_Q3AK^Q0\m<dF71cUoOiMZAkGa65Cd_W:LGF]=Sq37f1k:I:[\^K?XQ=8G;>
>@qA?8i;9hqaoWbZBp\_Yc96SmDP4GP428Ojmaf>8E_4V_7D;F1`XPfKL>Y1P`c@
<gJ2``q;Ck2=U5@2ZgmmMZ41AFR@PHPV[VY`Jm9dPj<T9^:^Mm\0VU]RCFJECh87
1l[7:h3`KiIE0d\LUnS]44oceco?YXgnRCjiZA<Ja]5kc0a4Ee3N1@8DmdS[E5Zg
I54fCfd;XTkQDCp]YJ>kC@eKFeCdS5BYjjhf:KH^6RWEQQJ3^?OLU1I0Onf?B3\U
]^]T`RYNIW4IF<_Wl>^nDUhijSgOBe3\225B3bDS=qbM?T=^X5oD\7jGoKh]Bgd3
Nn9l<dlaIU0R5I?6SNeUNo1]F>96ZK=hEQIkX7`2]UlK1E?jJAUI=Ohm?gP7Xbd^
]aZ1pS5kWV4jDWmmgI::BYU_TJ>nNc?U48_\994TbP<;o4YC0o2pW=0g9TB7blL^
fZWWRFL[9iQ>YYAYd:`m=>DaZ]:dc9W_S9eDX4XI@^n1[eSRFQl<9j?RlcooKgkO
PEP<F;8j=cVK]WpYOGo7GVP92g1Y_hBkQ\b^dHg[eHQ7ecYk^7>UZ]K8>Q5:^RDH
_fNhgk1:Q>0F^I:1d4Dl5=3K^\m6Inc^7PHX`k:N<R8^a:[FnqN<L_24K1Q=FS^<
a_=Z@=[FVbH0[f_^GXmPRjPTfUU>fWZSpFAF5@1_29@3;WQ=HRLAZC9qClj61Il<
:a;a62mhQV2]FGaf:bWS1Wn8p140gMPXb@5BZJUQTG1Wg7KpF^YP\:o_B=d08:=e
=9dn<oq;V_>5:;^013DlikeWd_WE`=ghoRX4KYboe2ZUn@FOnUfJGjSeV;GMP6NY
@SWLg2;E^mSVZXPFSXCCTkQWRWjIgTq_:\U4LRp<]cWe4Tpg8N9;ioqC]\BN\jq8
njliSNIhPK0i@@6;`e?QVYE\aB5TT:Lp3ej7<3KMHh6C[^[TX5KaU`[e1XNW`c0P
JCR0M:al3?2cC^NA?gRnNWM;72LI;1:]K72\AD\\=]o<Bhj@aG0YMDWPGLF3jP?>
UOq_C4I92lp>gmR^DSF<fSb\GS14^D[Omqb]SJh[?qOh6a:M<Di4OgbA<YhVXYK4
E[FGSoho>Mhg<<1H@CGQ5K0Beci]4pnb]eM;bXX>4MbNT>NC0?obPP`OnT\HbRd>
3p_LWT^bMMFK[Hn9TS67JFIhneOBoj6Vl\M92qUl[[kNhhdTAm@W?RDgmmk\IA96
KiEB0_lTNlR>5>D1T3Y3U<FW3dXb?aM6XSTX@iqI:fcXWpc4^Q[DcS>_ToIi@i>F
oJp9h[eMHo[ea2Nc9>_GhnA9Ag;9>nMdFCDB\h`lh`Wj=p5>2\eD<I>7MU4AR2jM
NSE43nCT5Od2k3j66RUkBXEmp9F`gU`3_02>0:e=h<8mKaK:aIHLo<MXn<[:ORc`
<KIqQI_9``35TRc@YI1EeUQ13VNeP`TjNF0ZgKKh<a;ne<qHAP8N8I7cXekE1I`5
Y`4>[kJG>eTNn5aJC;W?^JU9e^qB\Z9BXXpF;E1mETqWEdVZ6p1SK>MF[qiR<JY8
4qH2SYgl47X>oeOmE58]jG0nB7l`AEB8pa0C8?@AMM^8<T[[2Q:KK\02g8IWDM^B
2VTfYGA8`m4P_c\dnQVXfpL\VOAC4pFd[gD7Mbna]Gj?e[WeS4m]FHEOP]=\VbPj
H]CfWXgKN\jmmF67NBQD6p;MB>iG7pHDi45n`oB??VqMa?64BFN4TfoSjqMIKQ37
o[ZjR^Nl7T2<6NL:ZcO`;ZO^pid77Q0B@32deAmpQY1]e5O\^d4bl6g1kcC?RU0W
TZO91[a0i7657=?1jKVU<IYNXA>AcQR4p=lA7gk;ndcAVof05Yl7k4gBjQ0BC[gq
<[P>Q>B0XIeM?op:@\HLSZK_3>h<a6YP6;hHm^H2bb5hTpLH6[@gSZnQRHejp\22
:3KlR8jUbLV=H:U=[H4kAEQXaSQq2B^ASFa7CGbK<`oMF=ih1=;`ll:a@2]I^M=X
og:6D48`9eF0p=D=b8RF`g9p7aHUdCgIXmA:=gbY91]A]OLX@NMMF0>pdO89mAJq
`:JbRR3g`]?IlH\MDo9F<2[5`=2hJU=2=OF?p9Vfcj7p<]m<WDdSe5bYTAboGi5K
obU3Ee2@28SBUWXkH:65d>^8ncULGKA0R\n@cHH`nLo0FaAUh2=1U:@<`E]EGRXS
<fohf[ZWGNEQLH_L_<oP\nPlac]9IIZ1p8>fY4G6Po\JQ7a\fiU2eflDnCZH0KbO
U<_8GI>@gV3`6CJcJ=b@e9QIEfCA\P0TAQ66:6U5bC\DXn7fUiKpl7>2>IbNQ^Ti
]S1\oIXa:d=]AgkggD9^=aHBkiJ\fZNe0gOMG`GFdH5A>WoZZgE4C:CWG3hiY6df
n;=I56q2TSgBO:T=;L:nchh<LbR?gdnN@^i1?j\oh2N=P<WWJDQA=`m_j1:=5m>i
kL:LVhi?dWOUC[FVU7I`l1RP<qlKnNhcLpEmYY]ElYEJ09RP\\>l]nL3[hS3T1qK
a4>97>2^XVWJIn30bh^6ZHS9U12lP7cD?ORJiUBEba5B<4m4n@Dig]hCSP\[f:n6
H9H>ThLEK;JJb^7GWo1@mDDoIb\1baZDTREp\k2ZkgcA?V[HA?B:O`cUR<pQQEl>
ZPp0oZKHBpm[K_;[RkXj;HX\_S`e[G>C0TY5g;B4lkUkLXXK8Snek0FA`P<CJ2fN
[LQ1V^;YgB_Wl6aGe=cBR9>HcVTc4n>VIL85d[`5bY:^ElQ:3]EX<PTJZI=K;KCC
@NdGfj;HgI><YT[f2PAIR3>5]L4WIlp?JGWOl;@FRe0L5P1C=_mnd6nYAGU:mJfh
:e7OC=C`YfoILl_I[`ce=\f5SQ[^ZBEi`BXBaQ:1SL7Cg9L;Jq7S2S__Y>56Ej^Q
k8jLZ?^NQ\]K>gAY=ZFm6p1F>[i^P3;]n0cXTAXk^7o=6d<XH0i<Ta5iFSON93i5
4K:_LYIZYfiAn\Jjo8lb2dJU`EF6XO2N80T\e;Z:pSV\^IE7^:K?_Z4><E5giOIU
0?neUGAR>Te;2:amE2<ddBEe0;@OEe646\7AZjZHVh3C30ZI<35IV_\i5R2qL=4]
V`mk;JEJBiO?>M\dLf6n3WF=eS@oOje?`Dmf2=123^^25gU14_Y:j=UkU5R[eKan
7SiC255NW3P@Wb6ieRDF84[>gnlWOE<Ipj389Re[PQo5^Bb;\[HYPfo8D@9nT2B\
eieN0g?pn>TaUk>ac1mDJfCc;PbWjEo51IEMQhagpRm1h7Vo:dA[]TXOiL[a@4^C
fIM[Aog]@Tb85Lh1l3ALpC9BBHfg[H6:\P9Ja7]8SYIH`19U@<@jX5<hPBalAVfn
C>GD[5mp^]iE9mp^BO1cceB1JYgqS1B<jF9;D;3e03H9:^452hmRe`j\iA7jc[BN
g5DF01qgLIh_ocbkiNog^^M0A;hO5ln2ZL_CXdRFhXSE0WQlLpRKhUBBm6Feh:SX
DMR`c8D?0DS:H:G]<9=VgE41X=^9pd5RWoDe\fnB=ikkI`[XjSB=k]:he4UGTo43
ON;@fW7qV?SVJCPqmSkk;Ehjjk]X?F`MRMS>l<V]_<\I9WAoPdFFQkp@@MTllO0H
_D\B[iO_Ul:BZ[I\^0h7`<^GZH\3d5T8?q0@cg5eXqOnkV4kp9E;:_c2fO]RGgaY
\07]qe>TC?_<=SaKQK[lNdW;k><MW5]=j=ICGFk[?BURFC9FDBk<YH`kcSWGjbDE
2LVWWP[:Ip>5@]k`U@j_1;o1HF2T=c[9h;W=k[>0N>Hbc;fJ<]lGUNePXHfRbjj^
kAEb3`LSZR]^Y048GF1EcSj=^V0jG\7^F?W<Bp>]1SnZ=p4^YKf^6nqGVc:Q<T]m
BihkB2CbcApY^]_BkmgQkl<S^n^iR76c3<n\<@[g=Fd^mQWiRHlL]c`4`>_G;fV[
?QPnY\1;5PY48kFJ8W;QVT^\H@`;oJJZkQi[[@[M7fiA5qb<IfjO[qZlCWPUZbCe
F=ZKfW:A`aEaRJpXA2jPl\XqjIZRADVqfW^IC>Eq6ATME7Ep3GS5Ilb9F74L9GMe
VUXFiZoU_Dk`KmcB;^`iAH5TnY1`M`YR>??@[5_eX9Kcga?Gj;B`OEA7k]nXYYlD
naZh?]lP0OSn@4WVVDq`RngZ<hK?XZ3:?h<a:g7Oi6AS=kUa`dBmT3CmMC8[FOVV
lR>qX]7Q=S;q^eQj`HLXH`:XiA[K^J2C2dq9DbNQDGq:dkkCa_Rg0LHmUUMKAZ8N
g9>bET2_lXD98ZqJHQmnZ29<LkdhSH0bmdL>mgXJPD@@EV7\6<p]A?2PQ3pdeEIO
;8>6F^_V2fVg@TG3J@MF2c6L9qmRGX<U2]e=[4K`Z1Sljbh5eGE2\JK@f\5XFEDn
aplCT5kc=$
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
Y8GjSSQH5DT^<\3hWZ3307PaeMS8h1gmg3mGSF5><AF6[4[:P0`la6_5AjE<9dNS
6>Xgc8FoB;\k[nWpWUE5E\_9_Bk>m2P_:Ebd]MRiojHMb@bFQ5=4iWqZPK21o]fA
?Y<RTBFX17dAA]<8ZLYp3^NdXjqal>A>?Q\PQ5bBf7^ndUCb<0_0fhAQU9XpF8T7
>cEKN_Zh38jXd6WkCQpXA0nP4AY_6<l^?BDCcNYpfRQ[O;Pa]Y8hOGW8\;W99BMY
14A73=RP>7qn><=8MKR0;c\THIF]o98gKh;fmZ:T??bN5BipCBY<B\\pGY^D?SU6
bQ;8SBhPdomiZ\]:j7G=MVD]389\2_[YEd^k0CdbdPg9BH>FTg3R_7pk@Ui7_V;]
nZeCaKQmJK:8cM0<hI?jUc7d1GdeII><=7?^X:B2RX::YPp@L@dXbkR8WlOHY5M^
m5S]8cS[?:TIi1:8Hl3?DX9f_4Ri7;BqDDBQD8<\nUH6Y>SD9Gb^;MJO:4g=hC^c
_I\;fcLB?j2pj2aH_><qmA@PSoCmSS5ChVTHKH[kP7>d_iV\;1;9C^\HF41f57FD
XV=9L_aTeWdTYl6fTNEl9]nZV1Q@:UInFQNYS4l`N1pQRFY4jGqH?L^_9:^0kgZU
klFNLN?UEnleT?21LB\p5gZ@BA:I>i1m3ZaH:\hlF51lWm;=N1c^m?2ege7JC>MK
achH9XPLg4cf=EehKT`Wmh[oqDfQB0F1jEgOU5To6IGX6;4WVqA5?j=2=p^3o3<c
4q4:_i<N]Q8bg\9BGdY:J4RXGXa9dN4BkXn4VaGPq?mTQ6L3p1;j4o]7SmLQ\Q1H
3@WhdfW=;na5Hcn:[^RJi<:iM32oo=OP23GZ79DGq?[5T:nGbKIAZ@Bck=3lQUC<
26d`;cm2hImo@U>\6C0:KHSfWq4h8P4JQVch[S:P]j7NiGURV0OgWDlJ69gimco_
kJ1I=q\^PecZUqlN:e2OkgA;7]bPDa3kUYAkZ\f`AKb^;C0HJFAc?5:eRpc^]QnT
_D944m:FRHSL_bPFCF<gN4`adBBo7D8f9`W@[O?L5W[RCIZlCAn^U><\L9ZWQP`9
>83MiM@Nl[^QZkG7=q4>X`<@ep59;3fPLB3FkDO5XJ?^UV8:W6:BeCnQoo[;a:?W
D\?<nk;^?d1:IkW:nj46[bPj<=AW?leaQPT05TRV4ia?P`q33YWePd`Cd:n0T;9X
DW9]7HBb3P=V\b?f^JpgdAFFFG;S`lE1VCgkAKRlg5U@7hjjnCd5HU:_NE?9YK?1
8_^d=5nc`3TP]B[2Qel=[CNPNg:SAgRTlplMA4c^lpM`j^oKQ9hgeO1ENBR]GL6Y
cKqhj>MR`eRWY]lnWhT3Rhgpg3D^e7hpoi5H5^aq3^4`\FI5K<oeVEo1XXn8gcoe
5hj6dFU`Mlp`G_NFbcHVZH>n8f:06qSjoBlXbDYNGf`\5iHO=68amN?Iq0W2V09E
qmLiaiUDqa@g:QD1q15RIFkiF7jUeI:b<3W[ADXl`dPR[:=iXDagK7mgJq2XC;GZ
a^R2NE15Tn52^2KUg0O0Zj7eM>`<04?R?7g]QEq`WPnGkC[EPmiToU[`d;IK53j:
cjaDCdY1oZ=D35YOjZ>QC_IZ=PJ1DYIp?N3Ag;m\h<Dd]jS;VEdLfklf2YEdaDG0
dPCea:J95c`KQ3=?3MdZCHVmXnfl>l_qlBn^^KF;V8DRHL>d@9Nj<\QKAMWkS4Bi
?E5:;l>dV<f`h1;6a2<6Z:SK^cY4qC];X`[hp95]@EjM2Tdp^UDb@Pih=MS;S0E3
Y[Q>XJ?Ua34Tq^85Sbj6SOUloahlB:D@k1JO9:2]iN]Ye8:d7ZWJ20[BD8fj1qZJ
1;OXl?dB0>?87ATIZe`hc_fg1FEaLBNN^?cRWLWXWicFF7JnZOZgWo]14VLU?9PC
?f5EJqP8@0ILKp]V<3?7qcd`T5[5mQLOHk^:@GTMlonkgJ:3G:EiKWg:=e9]8dJL
3pibY5N0_UO:a;NJjk<QZ4_\C4ekU\XQ\fU[LN>SmdFL83pdYZoQ1aRR<nY8\FH4
6:ggoCin;:5YTfb]]M?iBMWL_NDa=NFX>aGGoJ=qoZG>9C5B111OYL2Tj:oC`MVE
Wb3m8U7V<C35iM2p>LBW2Sg:DR5L7Z3B]Ih?Nn:bmja8PS4n>IP_O:AgO2@1G3XO
R4DCJA==OG;eqC8=R`mEpkicl6l36E1qHfEU0?=V41A[>E[EK7FnTUYCY1YPXG0L
<4o^ojOJC1GS]5d>QncDpH:TaicnM4gi?3bJ\=@USM5:kV\;IO=lDMbIM6DiFa76
HjBRRjUK;259`h;VEEDEhCo?AKlI]S9Ap^_oWBeUqL@AS4Mp604<O><kd3b>R5k9
]5jHOU@cbka0j@_EVO_G:8mOeiE3p=jnDRoTa4]DUm_o?<L^in;d_D722Q<Q@CP:
ZIYDU8B8hhCY36hQn:7`S7^pn;KlJUh4H7IR_D1KdBJS_bS=5FAh7fmEOcJN5`;d
EXc7p34b_8CM]R>?N6b2\>UUYkGDIol;`ZefXYOBARl2AYVm8h<CU\e_ZC8LWpS?
jnCO2^PB\V=f@3gCNMganN>D9Qh[hMEblZPYhjaA>M9Af8LP81YM60Kj3Gqm@0@V
\2plQe5bfAUTkpY5cN09^@F;jY<GgRU=6ic`D7D5Yh;AYE`399KRCF6f7:5ZdGb?
JgqEko_o[n;n`GcFU_:cknc3XDUCTY_Eb9PCPmRd]oqUPD4JW8B1LifPX::mJX?h
K;HhQ=ENgPAa`Hkm08V?8FP[dPRELgSG6dMG212FR7>KV?obQ0ML[1pnHE\K:bpK
5GMKo$
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
