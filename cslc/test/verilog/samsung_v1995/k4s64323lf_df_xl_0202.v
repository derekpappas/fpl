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
    `ifdef M128
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
   `ifdef M512 //
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
E:<48SQV5DT^<akaU=cZ^CFCIfb=]KF;gNJmL]8M<SeVKg;1ZmUA`ci[<K`oC\AF
HU`gpIM>Ve?l0dc;ddU7^MK2d?j6F;bM09ESiAHX]\B^U73T9]Epf`9IHQh?LD@Y
i0i?88YjKBf1dknQKR_S6RQY7hf_[@qJm[7?>pJ@dn::pAF4eaE<pB[Z=3d2FHYJ
m9?LGZKD70aCg?9WQidDBJj?I;C7\`E>Y7N]Sg<4EoCc[fhnpg95a<J]L2C7G6GN
XC<Zb6@>OdOI46fJ5IX[V6bqTHei2B9m]`n\@4LlEd<_\LHjfh3[\7[meJqP1k^F
^^UaU0]];NJ9ZER_b68>5f@4l[RJmWhZ\91Rlo=`3[]^4:B2M5`QKb?m]2BUF=qm
I]YD[U2CJ7Q]XJ7agk_aPP3FmG2m:Z_kciRCjH2YV=q]AcJ[k9n0_P^fVd<?P[`7
KZ:^j;4]IdIO=8:<eoYM89qg]3NT1:NaJd5Vi0MYZioMQ>5dJAU79B?p^N1O_Uli
]3kIZ`k_=LWe^E6ml3Xk`\AUb`pUWc61oXHK17\UPaTF`81GeiGc268nGXp1h9m2
0F3d2I2Qn>@`@Ng?cbl`XE?R8F>Ki5<B7ZP3mS<VY>FGalXEnW@k1q^1DXkDKqWC
k=hYEBY6dnhP64G?nWV?X[aTC3a[3LcYWPq[Z9=Ik@KP8;6b4dnFIYPiLPg8Cm65
BDDH<ZFDR5`oj<Upef=NgJ\6HH<goZeN7nBP5GZJKC8AS5m0^0E_MPSUbOeZ^hn[
U0[p9eABV2=pJeEiC\>@jPcG3JPZaLj\:?j]aI\@pC0`9Yb<8O`fa1L@iLo5ZgL^
?<B]@7POe\7Y0eS8G2FjGloC5BHL]Z^DCqNY=EP6<YERH=?80^eoF:Fo8d@H6=P`
e=JNqd3>60iope7m8Xh;p]^V4K7ZhcREdnaU`2BhLhN<C;OIHj>[PTEH@UcK4n`b
F6JkcNNO^`lQFZVlLi>?FN;ELlVlVG\c`cGl^KY3[<5OB=OjD;3F2XceU1MRJ3\J
D:n@H]`q1O[iebAG^BG0<B6=Um3R:6Y5>cUZgKS]adaK4SRTU;MV25RHffCLHlZ;
cG88q6F?D7EWW=XRKf[d\J<P^MO1?O6L_m_mPVKKOWJQZRCEVAi]IZT<EFiACpZm
NngkgDZFcK:Qo[dD_fJmNFI3CjnIgmn>@i=9jnOJ0edn?EMnpUMlW9YLA?jUC3Uh
g>X:J94BJY0_Bnd?i8V2IA29Cn[PZ@^eG]DW5qU\hR@>^>\TZ]O546iI@30F<ASa
?iOH4WeHchgCeDf@g2J\[BnhN\cfXE02OP_dS\q>8bCBl19EQcjNG9Ycm1U0DCYI
3MShjRHFAYN^>\mH\YW59ga7II:aYgH[^1qB`dI3ocW4:]8I;\7_M5Ed:ck[<R4h
\;FS4Fe6lQb_1^1QhA2<l]YcZS_mPDcbN6ZahG7^e;\McBA^9=^;_qgbNNQ>_bX5
4GdA;Q1ITNoVIK71MFQN3WgeNlX978^l_hOC2T>J7;^XoL>iSb5a_DCQjGY8WEF^
dc>`;SkQ@Qk=cBehAKO2KMD<MF^M[`8OWfL`Pp?Ae4S6ibDVPgAAmCa88dkj3h<o
FHH8eLOSYHV:haWXJVk0iWi67LNI23VaiO0VM3qQeH:`<VI0U>KWJ3h`VKgkdXqA
HLl\N9MQ;TKH2WQ[[4dFJG=P9Q^BaH?M>?Lfd^G?Y>XIbgSWU]]M[;J=?qOB^[om
klb_m`6NSPXU=e@[aM?o[?B;BPL;08P4XokD170k:fJ^?8fRK59LcJIC0o5ogZK`
>>EEnY;=479oG=KVAdfIiLg;SBR;R>90q]Sa9cR<FkeVcMbNW\QLIEVTZJ=dN@Pl
k9A^k`5A;]6Ch[EOBcQTVSA@2OK[8:\?hK71=UAX9U4p603fKM\?3ShQ3f7pf702
lfnc^IN`V=<d]6`2OZ2mXWUSl?KeoO8_VlpL;Ca>Fb<5ACYgk]DoMfhnL9YZKaYM
X5MSRGANZ?pQJQ=?gRNcPMN:9[d[2?YkhqWRAVnonf<6f9\?MTTL1Hd0=CBPTRX`
U_Lk\h:C8TbiZWl7DqX1:jG8doG\Y<fkRn[93;2<gp7d0U]<bcYh_lBcl9PNUVK`
bLM0IBq?HK=Z^OS13Zc`f^L0>11[A45C3A=SgFEO[pKo1HVQ?Yg6SL0=<UOSqKh\
=hcniFJGVXAa]NA[pUUC2C89PLbFRS7ZFL1]ahWBcVPTD^N;P0\1pml@iH@_dQ7>
K>GTG`Vg_JF0FF=emU=K\fYTYG3d77]QABO60oWm=efOSb_UDeiV0IDnkVj?^eS7
^m2q[J;ZJjekK8?HXTQBb``;kTRPZ@Snn^JFE_=adJoZE<?IL[0fiPMXW@:ISDV?
mNnf[E^XaB$
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
To7hbSQ:5DT^<5ja8<:B>j=EQ4JGl;?]5V:aeM5n[k:bU?QMeIm:Kb^;^n@P9<EH
^aSmHAqVib=H<[ZXADXcQXWHF\h=Uj]8T=fWcf`b<TqS\MH^L:I`A:SZiL^2`Zeg
KCqEoFR5Qq]V[8;FCTG2Vb;PE>N;o1;BnqaLXjGlnIn^ciXE<?:i=bLOL\b31HX<
13WO6gk>?M2jc^[Ohq?4G5JGd:HRW7LhL2]@mI\AM=MEMTZFS>nI5QBmqXdoI3OX
1V4l;1@MK55;:9aO\Ndlc=:_HP6pJE9FkSpV=He2]oFd?KQe`91=FCionXW;cApX
[Ikl72Bj@g`<05qhOV=N@E70aT@5RnHM;aLJQAOCJO@L^HZ?XZBB6qDHmkOnO@T[
GQMAG:QIg^X=\C>cZ3e]Q:;DS@NAl8<o8KcBo1c3\IM]0?3\lkcX[pBPQTG^>q2O
fP\k5djdN9O3T0]dU?ZF5A_A0cMW627oZlliI<ZY9U`hdZXZIn:4^7UJSh5b4qS9
^9KPqBIQCKR<1\V]3n8k[L625a8JT`nbkNb9q5mj<@3_Z1b>UcW1TF:?bTib[c0b
6G]gRiiq@l1=<Fdk4b]H`i<lK:L;3ocZd=H?Jj8XRng>]BKqCS>ceE6YiENE\`Y]
Xb0NaY_GESO:oc8Lp8e1>6\pd6R`mg=[_0JXc8e3]\4Xf1d[pZ6\\\SV11TVH]SQ
;;@BnGUU<?:<A<SFSVUTlWofVlXim?BZabjgn^^pcCSOE7QNUDBlXZg]_8Ei3DAQ
hXEU1iLbh9fq08GJJRpKEIJ\mLpL?PY^X4OCkTAFS_mkFN>H\`ZiUP4::IQ<_MV;
2AaNTmm;S^<oO]E[2pKlTYo2S<DlMc]I7<c=pOfe5W=W^A8PeFW:XRKl3dPpD<eo
Xo8[\k5Rg_]>YFSMnGdq^G1`b31I0QoWCF[H:k30QAAp0Q2O6Z>0UXNOa3bLN50B
f\HqjSQ8FBh;]CH2j=@o1ag\mHqJ3mYRPS3_8X06ndFl4L2Y5Gl1K52=PaJ>2>mb
:>@[f8;9Zq8k8Ne221lKIYk<1jh3U]0XqYDhc88EkF4mSQVX^dM??hlp_NHlQa8A
1__^4CX@45[d9l7P11<q17K<lIQ:M5G8oJ^?6c153UoEbW>pRROol9?D03PVkkW0
FiOL7>YUU<mlqMG<ZlllN7e05IUX_J4b^EXd<DLC:pa]REO>AbO]3OF^5YH9W<_Q
XT7aFBm94QaS>Jg5ZJ<TYZlelkompm]0lXI^`_cI=ldF6L>HnVa8d^NnpKe:VAZ6
mW4FJB34MIfdN4[Q]Je;3H:?p3abTlf0\QZ<f]4W;:KG4lUN7TbQEWX^:ql9D<6Z
I39UfX2k]P0EBgXW2DYLgmqIHJ5Vm:5@h=kQ=Tn0O^V5]pD0m:d<?MALan8gkR[f
B>B;HNa9f23VgF3M9]GYNmTI`]cc?`n]`K99S6Lhq5R<IP`QB>khS]107I8Y9PUS
W9=^UXaHdLeqlPKo\\q_e6U6\qSQ;_CU[YRR=aCe2;QPjn0l;3@KZ]pMRI7X[p7`
=FnEqLdZ?b^RWNGT`BIP0C2ajAOUUno1PZ6bp9O^913N;CPMV8m^Ee@GdVG>J\dX
9NLfqlmOhT;bIeVP0:]88@UCn4Xk1EohY>6p@bhjL9QTZo>oYI>X>SKPZWRb_gOe
eap<c3MO7b01kX9Ha6>f\<SNa0Y754]kFFi6_fMN]@XQdBJ8hYl2jZYjiQQHEoB^
71Q?f1R=^qCCHKFUBi=?XlVHfF[7XqIha8;=p]Dla\0p1WE9EKVT25XYKgfhcGGT
FHl\RIQq2J@7nOqkj:lB1q3[C:R73QJ97N2<n0DYh>FIF98aB8ZUVpC2k?0N2:[R
WcNE3eh4mJ9OFJnM15jUApHEX2i_e6R8?S`cG1UePCIa<`gO?[JZq8Y_=lJVoo_[
b;iSNF5A]cS\VQ`CFb1pUM^<79_1q@Ik7Wjfq1<V3empaQYG^2M?[F7MnLB=1nG1
3EmeU:\OEO[44V9j@AkT==cpHNa5bSCq:VNWTfM3gZ>AZh]RJ8TXk2Eo_i]Xja[q
:dGb@DP5m`b\Ef6NQ]GR5Q=jbdXaeN7q?\aJ8eFWmU`_X7[P5PnE]9p]QZ7Cgebe
38ji5@Ok`WeDhZMmR3K87pHbKAn=Vin:I2]nQb;Y5Gn:?V=Ac_jhpNJ1n>c1p_6m
U7TqZ5=J4T4q=`l>BMJL^<BDlPjdURBXIgeQp=I<E:3:J38>ia?Z3;dhYi\W;AVq
4W`N?8DhEESF<n[oRkJ@Q9`GAJCo8nqSda]1Di\VZGndb;ILdWVVgDN8WIUJ?Qi3
Cp6j]P1SQJZn^FQO9JiPLI59mB?7M1[LFBpO?VA<A:;8MCTK0PX9Vf17^L;BUhP?
S\A2Enlh;op91mVU2McZa34]mC0=Q=l<0NAgh1450IKmWRgX6BapdPI8I`=;Go@L
@LdDVGgYfXMR^i\YBoEdkbQIpIhLkD`4LYNQHi>SZLD=7nPg:<OdgQLC=ZPl_qI5
;fLCRF^4;=ddBQocOQfj97YaYApoCJdMTH[=MG9HS\8EdfKWooBh7DH??8<IURFp
i@PW9<b_F2G^L`^FpIaF4o5JTSZ_<>1C17TT:3`;]=7hBaQ8oPJ1phl87\jXgUZh
^m^i`SFAmC60mU47;8^?Np9[=PI20RQ6MY:PNJKia8BDGTE6FJ6?ob`=3qUQR`_b
>q\;cDgFZ==NDVQ=`ICXpPj>cNmU\[BXflZJcXdYiR<^FkCN@58pCDK95AeHjb`h
;]5X;HUMYJ>;LFO^:42U]Q6XKO2Xg[S5^Y7HT3GDQ;Pp2iS74n;67A498HbTYiI7
UN?L@PiA[;RqTo[28bOEL=FIiAUl:\W?jE?mJ3Q\5Ijq0bam3SCqFI0ERJR2O@i1
@<phEG9Onh@IR\OS3^L<h^GRh]>7:\AbU2FV39RU5fa0\;ak<EN4WB0Eb[p^fFS6
>KnlV=jKJ`Kk^Cdg]BfK^BNM;e]H;7p7JC\HfJ647PO\\D_T<<lYjSE716F<Id08
k@eqMADUW2^4PA[:fBAA1MFScW:jV3U4?0Ujq5]8Dll=pioU[HS_nCPVY1hGV4hN
937UE_]:]@F0@4:Bpg:<leFVq2RjH8d2LU;JnlVJ>fL9[NNZDNG54`m<G?fA2S>P
Y^T9:B3[q^cINo:AQJl5V\dY>Z;V9e8d9eG12:A]1RdV`f>aDc=<[aN@Ma\l:NfU
Z5^06cP3:@X7KB:6U9M5V\PL>C@4QXo0mqn7FYX:C4:UAV9MkX6`]017pYA:6FoG
XS<I?0Om=9m;LnlYUfnGNpL1WUfF0bXk8mKaHH[EplS@;2nXf3Q_BX;?:feFMjPm
=OmGDJHdD=e1pB2O[]<AfAIS=>?MCKU6gA27o\Pefh^nl]C6oHnAG4CMGdDB1=c\
h<hUkUWBa`XnWLc0?S2qgkd@GToq5^J7kMR^@j28M?8`[VV]=K^OJcdkOnBV\iYe
VloQpCD\D\5Tf64;aND0N3\M`5`_1V3VB1<HAqUYNL33Sqb92Fm@R\6ZQIH:5ohl
50ZK62G1;caQ_WNoDGPdPJD8Mn28LQi@kbX0>Dh>HEPjpP67<oHapI1[2R;KlWfm
F_^o4c`Kb:KZ_]3RU1]o9DRkMiOQBA4S_`29kVjm5BdNJNF3ETE;hEC;OSO4Hbno
l6_]NhH?`cODeAe>_gBYf^8q^YjJl0hWg85]9:\09HgDo:8A0=]YKkQ\OSQlB@@O
SH9W7^a@5kpL1lc9GKp9<kTYJfj7S4kg2TVjBXKqfb3aCh9ZM3=DT0WE]I0d8RZ:
`W=PYeAI?N4EMeQXjHI=PF8H^8mE[l6Ajjl2_JImWWB5N4a1[;\U1dQ_q6D<L8k]
]Z`kY21\1elS_Kghf[IOSRb@e6`pQb:0`Ucq5aUBXm]Johbq17R`^H1p9L3;\5A6
<?eceL\cobl78L;?^:_5GM?E>PgIT\8>cI`gZB97QgQm;Zh<\l>jRipHC\=O\>jP
RElk11QfR:HeV`S=@^DO[I]baM`0]gpalIU9Q]dU]P^CPP9?beemU<FRN?_C7=$
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
UjjXJSQd5DT^<<<YhQV7c8FYZQO5IA?I\c\6nS?gf9`PQD>HTcSP@8f>MeA85JZX
I9hXmPPNpZ_V4RQW8>03]96I=f^DLi_Sb^2hBAhZP2_4=c\b^MHjp2V[@@Ch1[4R
]`KmiHB99G`4c@7qZi3m8Lp::@NG^2_n3\jWg[a>YdFkhA;`bmID;7Z88fM6o24\
b0GG6]<I5Fn;af6M4q;3AgFF0HdI[eOT_n>djUPNWL@glaMJ_ZoNe=;aJC3RfQVT
RGRjQ2o6nlc1\BMhVO5@<Wm]HGIeTqXdaQj[:7I^J8BN]T?mIC0Cp584::J7Eomj
XoNj?4;f9e7_0Pnjl5OC]58`paW@el=hD5]GBLARLJm4PKORW:WMfD4O1T9KU3VA
?lhB0O@5V8_WYeAbpQ5Ga?NB2AQceV3AV^G6;73<S>aV\_JlY1[8MBR`cA<X:LPA
Y;@NKgfWg4dS:V9di:fXa7Fbj@BNCQ0JVKmdph15F`H`pZcdPXXWJ[Vf^3k2=Z=l
@<7PKQ4]=pkb`ciF^`MG_6]FDiMUNDh7o@7\XRhfdg2HdCS>\_I9\b5KXq7_2455
<[KAc6:h1P4@VTX_ELac6jEn`G9nq;\EQ@j7qNh\AEGO6Y5KfjFZ;=c9m[7WGFLS
BS>Hd2;bSS6A4\KS:EEUO=aNM@27Ip_ZGP5>TN<9=X^`h=SV^Nke@=B?iaef2DPn
A[9Z74GL\_@\PEN6WHFngIU@IADY_QhBFoL]\D^_D7JfeXo_k3pNX2OY<4@\hSiB
LYlT`RY1a2E=C>F4UXp6Gf4oeUqOU4Rl5LhHZUk1``k;>?>\_YhX^GR=bYp^C11j
eoAWekA_\SPecWNYhWKM;A7<YL3X5F<nUUSgmCYCd8b?B589dd?qFCN6KoY_PF[>
Uh?1aF67V[@kMf5Mb[>PR_>O75k8ZndJHo4;<KfD6F1ETSU_<1508GXm\::\T;Ua
dOE=]SDQq?W?UXAOqQ`cb2a6iXBfCh\o^hRZdmVT`X3I8FUbqcX]1`dqPD]M7\U`
PK\Bji\MXSPm=\Vb8Dk:cUkaiKdZo[iB>GMGDcAGOGcl6kPq8el[UJen`Wj2hWNe
;:D:ViN]m`fD9@5b43GXINhO>K0<IcBV``Oh=2lJ1Kj09XZn5[8nTQjp1YDkVkgU
\S]LQV@b7o8RQ>DZ2kkgmV>ikTo_O_fQ?P\3l9@8=oHEG1ab;<S>:UA3PBT0K\>V
U@o`cD^B\hSq?RQ?IK=qh^<RVLIBKIUfGN6Eo:]W7kAH7Wicpgc;jQhnqcm4KgoS
0cnFGD4]Pg0`4nRFoWR4WS3e_22lHE]>fYMQdVk1WL^]`\G;AL<79qQkb^V<1XS1
Oe]k5Z<9OgO3bb3nk\B\0g1Y:2X:ZcER:>JMDKC6O`K7iAfNTbQkIJ]7h1<]X_km
S?<nq1oBLo2WcSoADaZKd?;9\kGLgf8JNmZ7mBP8jFc8;N478\]MNHGe2c<XV=JN
_lPH]1h;73?C0iAX>o_7Qc4bQO:D^YkMgjKqKMkihch;SdcPK\8IO?@m;696bAVB
?DM__KqkHP]3;Wc3^qS_^=m;\>dm]CFg@flSnb=S_WT59^1UZ5gGbeB?dp<X1\d3
:f[Y4;2JY_li1V<PkEP63ndWU0;cZ3q@nnT0mXq:gY9]Bhb5O<Q1M]:BC;QhFGM>
Z=[9M5VXTl>\Z\bce_PQRLh67bn^iMEjL3e\2IqI8N`bmDq`<kR89TpifBdChae7
H^dD;RPf?2WRiEBF4V:kkOQp[T5To5hY1URL86fT`lQoAjJSm`aTXMbc6dd3Y[G[
fX9pG_lJSYHq0ZYNfihneG;jZXG^dAWYGeXqGLi=d<`NVO2=bBNm]XVF5IND`F^S
qBfb2JlONOL:gjJNK6?To`DpnS5X0icCUP<joZV6fj2>qZ0>@A[_m1=b1R0^;bXl
;X^@>TbcadAZXX7qb@I4g2ickOn0UKP_8_J8`9gjBEe:OeV9WJqocm6CRC`n@jBM
8U5_7D_OaG@7Y0pUea>9cNK6@76a`]^1O1Ff_3ihVbGKTcgC]Z_iee[dLE`ZcaY6
GY<qWB:oMaH9HNfgZ<Hf?`UQgNH7RaLe8c3RAkp>c8ljEhp97[6_eP[dZAh@oKIU
2dTpm]O^1:@HRCCi@UY:V@Poa<_Ubb_[6CZhnlWk09HWU61g^3@ec4UKCdA7M?V2
WTgA`CeiTEm8Lalb`iYMU\WjF@4[p3nb?^1>g?B1U8ZIC7[9F`]NMg[q>UIaj6\p
aRoAlC_2D4[[]71[EGU`]4b`@I6l=14e^XlK03R9:9^0A;f>:S@iV_ib[hLE42E6
>JCpoc9icFY1dI>DncbFYUbUm0SSSV58P6E8@R<Ym9OUo28MeZ[5<4XnWB[CpN8I
b2I6bX2IDI\XLjL]]j\_3o2Xb86V5@8bBdPK85neaDgK5JMN73TIBFXHUFYE:TNM
dDQRo7H5UlMaXlcnm@XDBpGLi=@T9:kPRV<3V:8SqAj^TgRLbYmDiPZHjUDC1mZD
QL?p`@IBe;;_e:OMgh@]2^[2h?f0EN44hT6]=DgjP9eZPCQU]Ua444K7:hZ2B<KW
E``a`UiaE8TAqMaGl6SgFc@>Bi?NDl7S:E:Z_m?WE3iOU?]>if7\2a[14WlJXaL`
nen`X4Q0M0Y4pl:<?0hAq<9=WM69_kR[S<97;ZH38OBWo9>TbQ>A_5Ond=M5N:6i
oXkMGYdCl9dOGFS9>QB^fkIZLf]]cj>f>T:mCP[iTL;>GXQeGY7YE4l`N71H^S_q
;1Do@A0SiiZLic79ZKd9lX6enJqN;fMHf8c4<O`?7J>keFNQPqJFM2f]bp\6A:=b
:@c@a_MPp:5?5WL1oElODil;bZLB5>N\OV4AVcBbP>8Taj6oJpGeh`88;_bD6_4R
Ynhc8<1aIObDOVjBfH=fc;QN[Y`d\cNkYDR_9O22TOljeI^>F6VS[bW3jEeIPIXh
X8h_ZWiA\5KDUEPFRm8Bi[jX[k?mDiS4q2m2WBiX[ifOKHB`=2kK6aFJlicpnRPF
5k3q[@hm5Xi;hW5M\KACaG_\USYdaP>FjCUDdEmh=Le46HSQ0G;61WkaFbX=`QP\
7[;e3Qc\`62qb\I@Tm9NXDEJZbIO8DT7djBPic2BD9ap7DHiJl_DD\`gaPCN>eY]
_CYcgJ;A0aKHf@lJd9\qemBO_dX4mIA6h00Bc09[jCVjcDn=DbF4[W=4SU63T]Ge
Bo`UTT8JnJ:h1g3AkHZ02CBP>eo\Odqho5QS9O>6k]P0HEg3YCNB7MYJBaLqOlJ?
1U<PJB3k4M;LIgd`_joLbPj3lV:cb5EYX0iO2bMJhSjI6VcT<ZlCqV0n^o12?K>]
2<1IX@4Lq0XH17`h:LQ>HQdXe56<1ZJANEUZ]NWdHBfFpYo[;W`9YL6i:=B;j[FQ
IWXZbTL<T7\P;36T49;H>hgHTVdQ6L77pNGiRSLhmp`n0K]BL=M49]S]hLd40pU@
c[kk?>]F6]lhT46Am93A:c?ZX<AiP2R?HC7Xn;Y4pdOY_FNbIcM03RP8\7`1Cg9A
OO8WDYclWH?<3\l?eF1qB;oYnk7i5>W5i]@m39o`I<8a>??M_VkL<ggpTOC:gBEK
mTm]2>LGIZ^FUjUgjb_cVnZ[^dl1@\E0bLkHTI=P3K]pGo5<Q5@\qN[cBKhYFpO3
S_<UJK@XjS^AcKC;70=NjN[e;CJQi2pZeBL=eB`VI3b9bi_>eiP3mpO3g8AD>jG?
cC^]H9cZg:1H0hPG6XPh=@_>Gj=nXVN2CL7iE6qXoK@VKCpdE8]c9[6nEJ31^ooI
4fOgQ<H>a`;16\;U@c\TVAifQH`8N=m9Q<:70a@gK=L]JH<a0eAVYIf2Q0GQ^VW_
4JVgbe@IZ;=lnaeDQY@5[8JFOeG:<7UiEn6F_eQl_JACWpnGAH3[BqEbDAZnJ;kR
;69^PdBbW5bCfblU:X[;h]]FXO;2Zb5ID66B8R>96K9fbU:djTC;RPEJLoOCoqU`
8_A4T31:Bmg<k8>[;Al;CV[\HRAjfFQ6onhH^ed[KR@Xpg0o=LJ5omT<jim5D=]d
HDG1aPTfkg2`bL`Y:M2WIA7HnPilbQ[oV@clkgVAFc=8Ac5@1ih@\lal\V[8;Z1q
JlKMhi9b:nT6TQ`oNdGOhnUIZ1OeBP9T<c8?e1JIELKm6fT^=J\oW^pdK4:aU?0f
nZI`[Y4GGcNNSVipM:L\jom8i95mV=WXl<6<LSQ2H=0HdMlgd5=K@If37THI0FED
N:5>PB`RLEYl9Cq26VJa6;q01^=7\ZAcc5QeYhoo>bJE<cFi1X?mD<am=7[QfZSY
oUYH3;GR5jNHG5jeamC:@hHO_G:4ePKQTOnekmfo^::TCfafK<[Ll<M\JL?<dPPc
>8N0^iYEoLn@e>E_aY9aYgF2_CqX>a=G^HqBF3gl:3631HB^:l`S[O3;hcLMf@6A
\gSM54dMTKJdWq61<MD\38IQ>59^9Mj`1aXH]gao^:d7l]h3IBF\CA7`mM7h1[`R
4<^VifPfnd^NGA:U<0Zk:4\4pX?cFDj9ih1?c6XPb\WdWcTeC3?AB^a4:8CTXpQ0
HZ:neIA<gL0IDW^<ZRX2nR2gBdQEYJq297U<j909HSmm]_0[O4qkVf:UghLV^ZBW
57UJ_Vdm0\JG:6`Odi=1kI[:5aWQXemcC_FTFV@Eo\qaTI8U];q]NMBc^B@DcdEU
Q4E?lPB8l<ThhRbmMhKPIe4M3\^m3i@iH6aKcH?@FhT@Z8Qejkl<ECOSYi`WF2ge
eoBn59Sp73SjZF85hH<fO9kB6?gFMd=Uq[i3?>IHqCCaE`PG`D8`?@T:Vk1Ld;E:
9e]BG?MGO;Sf35ALS>llS_ClJP7FZkS4K8=2bScT]?`K[2Z;iG2fHmQljNTQF6F]
MeMiA?Z8[a?HK<TUnEAjYCCl4=nFLbFchfV3;pTI;8Nh8pkE\;KPAlbA]E0TVH@P
TFGiLo[gmQ;26\_o1Z2\m5IhAB?`PM:3DT1?42I;ZHp[bIWg3EpT=MS6kp>ROfDH
MqhA14V?GKKbPE^`5f19;e6JLKEe9`q4HChQfNE:CCo6jkJjZd44=JD[H:BJ1q?V
2?39=SHYVh4P\^i\M_nIkD4KlY?8afpi?NK4L6qAej9:3]V13YS39Nj0g?2ii^6U
c5LMLIdnAB0TCQld;DCEVbFj;ZAlmY7VWpZkmM6<2k_n0S^CGbqVP6bdhCWYeKF7
l[UE16bVHA;D=f8?\Dp\FNXOYBpJ6WNU]6KKDniJP\[j:<L4L6Q2_Q=qFOFkRkLX
SEWY\VTjj`IpmcSg9IeTmOk8bIj:Mhej8e]IRbVq;7c6hdF>TV7LR[3;YW=<FE;9
KCY]cB^MkbApOfl78Ce\oK^gXYW=L2fMLnBP_dYY<aXRlfm@DTeR4KCh9BQIS8^p
LlnFUmB@pgFOcMY=o@\9W2o[Dgc3qT1L;XnMGTPO[l@ZSH]9@7h;9N5ilZRMlFKJ
]<AX>^IqP@UHQg9ROTI\<4<4nTU@QS4O^hXQ>TZBgHnY=D6NCoq:1oP9ET[G87][
a;oJ>A7=l5nf7e`CYM^cMIf\ajG2MS6fAm<c2MpZRV;XXi[pfFg0NM6DZPBFgP_:
C]29CMPN_9QejSZlKTOAh[6:d1=W>YF]]op]Uh;Je@kqIWTW=AjlcA84YEkq7]O=
1e8Fn\a`dkU2`Q`di``LDSoHZDell58m`MGQ\^d2D>qima;AoMQpRH<Dli1QE1>H
diE3SPW_\mpm78oXh^q8hW<^1h;4=Uj?0?ap>Rh@K]?^XaJQM@\o>JqF]1o?D51G
DJ6jFQVGE?VSXWSKgjbNh[4`M8c;UhP^kq_B90RF0qGC5S?>;Qg6OO0:ahJgP<Vh
3KeXH\mIZfHgF`G]@Ge_jpQ_k_M?0UhJo?c`a<3kClPOblpSKW95`gqH[i?BBTk8
iA`[IbDq31:ifnnqinjY7X[nh9c_hIW4`CQHYT>IiXd3iWZfElpHHa7gAo:OdR;X
0IU8<oZ_U^;n>WDnTYqB3mIL]a\Ac\D_bJQN<Wqfl?UJe>^L\HogCEmCYkjaikn9
]69_Sc2pddCNC:`p3X@1AhJ\N94n@CmIRH`^?69[ZS`q6DcAkV5>:naKG>R]3eXq
8M2jkR:7VLeF8`:V@`5c52a`ZIp0SMI>V`p5L`XR^Cp:7aj2ceh\ZmQN;7hB=MV;
Z0<OaH7J9U04PhAUc8h`UZBG:bYn_T@<18?;EWnS@6lcJk^:A`LAKhP<dA=AlLJ6
W2OXh?c]JU180i`A;07GB0q3j;aM:SpK4`=g5qd9HnLDa>ekbqS9DIG@5jUAFODT
TOhL^4UmN4RTGPd?\MM1J<I?D;?FY6?i37?]XboOYC>Cl]Nbn5mc?h3:RQ5Z`D8>
E;ALTjVX;?<FTl^9coYUj5WGR[?nT6h=fpQAjaXa^4PnDUG]gc]6b0jHb]l>g^P5
nPBQi?HEcMM[HV;XeE2\4iOPg1H[5f]aQ8?Naq2QhkC]aph8>JLUHpG@bFIdM1Ui
3K;D\X8=P9Hnf1_6qB49QJLOq3V5kde@q;jcDT=h4D>6k=BHoU4?<c5N0o^K\`8=
ipM8<aA[;gU9E3UHV6iR_U1h0cbLVnAbBS;e7M=3XQLn[Ik<:Z>Q<L0N=Sqg<B<Y
WABJdJK1MXipNj9boCLpQ43olbE`2m>a<JnK8G1jIgdnd^L1iPbAVSFb3W=_6f?Q
2[@JbhpD4?;Yc5EPiC@dd?CaEbn3hmAWokG02GW\dq_<ZRVXTfVf50aVTo^a[pBR
MaYd;;lMn64m2=0b7nKW1GJeZ^1TW>qfn3N97`pK6e0GDQ@RA7_4l6X\Dbqg]V1b
Im6\<7QM?DQ[Df<?9iMb`p0?:0g19l147:XS;@dmBp:7blgi`p7;D2;?bq81B1ln
9D>_o]aP>PhkLj1MhhoMO@6fSYURfD?[GPCM9K0oQi`\]TC>_F2:Cllb3K?i\Dh5
mJ^8@dY3<>71VLIlNiLL>O4IS4Pl]U\md>3TkpChnF@NcqdRdgP`jI1Mb7^KV\q9
7gdbX[ql^X=?MSKOK2n7KSeJP951ESlS7D]^cbJ]6p3n9:lKUq[d]E7jG1TSd;HI
ZXN:mdK6q9h5H6`[8Wf?VoAh]n6XnUXBRAHTF1M@0E]K1k:?LB;YqT[UoC@:3PO@
PWBV<IfXj3L>\3DU8<gSbL>O8pAj<2nUHDCWLNG674QNQ0M_R5kL5_Ol\0?YUQn=
5Zp_foS3V0na2;8ej]AU=PP^0>J:B@S3KjBGIKQ\M:_f7ibXB[h<5:^eSCe2?<^n
IQL_c;k2`\_LjDU@7fBMQLbIoPi3<D^Qf`QBH8:l0W?8?eaVo:[ZBq`=d^VnWqaZ
RVEl`\aLN:O<KWEOqcN2IPH;VkFXW`X89=LdPS?`pD=7=K9[p^<QI@3G2X_>j_lf
ob;W6]n9_2>mA[bNDAPqEE6^G=0]n<ol6c[EGRc^f00JKBjh<V2Ua:`]a?UlbjPQ
NAJ3Li1DklhN?=GOXE:glll4MnFPVD=WloSZ;0:^VSgjWDD^OVCR:661Uk_55WpV
^Mmd6kL?^id:YSI9^ThNO`UkV>X0P5eq;4@EhPm3MYRcP>CR[6@62m;i4=>JSN=F
T]Q:5eRSgidKEeR9?<^Yg6VBbaNR=9NDLnLhP?^HjlC]7^QV`mS?QQ]ElAn[KSiK
;V;gQB4n7b6;0oakEN9a53<>b];U:[CW:aPqEc2o0mZ$
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
0P5WXSQd5DT^<U6HY5Jj:S_h6F8mKHJG6a:D<bGL]`Ye^f1L`HocJ83]CFFKWE^W
nJhaJe_NBgpL\OfhV@cMfeVW5df=9Em<1I7YkTh;c`SZ6F_>GOJFo<_QEbqcnNeA
mc97i_9AYlimc:j@92m]ZVa`I1SA[C]kHbLl7AMAUG\?NmCcg1P@O_XqhgOdn>qV
ie?M4N1F\65^R0^T51II:KTEV9D;\DEAdcX;3B>iX3:qH7`D]2@pZ8YVAm>Jk]IX
eFZcRO2Pfom0;9k9N7EB3`kYp89;fn4@qD>i=WVj]3Q7=?[_Q[QmYQbeZiN?fJ0=
p3>WON7D88W_KSMIna:GCl;^m4]HOJJpo]IC`\P@j]@ZMOkgFYU1da_cPKXZgS<K
P8>VnFUJ?K3XSI;]h]RFR9Lce:jNNo4@BHn`fc=591dDNf[oqXCH<FeEMlMdgITH
Fn3GSPKc]`D707oQlAg=OAb^M77Pdqg^<GN\GI:D0<3Y]MKKHQAce:nf0aM59p^;
n[]A<qOe1jZEBCKMJ<VV:cK=m@2:oC:0o`4EQecKA@Mc`oU?RaqjF@2?8`pi<T:0
g]2H2o75Hk1fRAHVUGbFngP=W6Sq6`GH`G[c^eC4:NoLSRhU29CS=ONA0S<YJDC>
1I8f;:h@LRlZc^:Yh1pHSG^WE[di`V>GUD?o1bN4[BP3Mb;>k9qA@V`cnJpF]9;K
4A=>3PG?Zg64`n4iQBlIJ9]2Dh[b]hOMPSVqbP<BIbhK;S>FVSe8>Ef<n\a4=LkC
14mBJJ:32ep4bRZ?C7qLT?gAU\7knk6bZYdUhaP8PZk\kTG=4q_:4WffN9J>4KNk
lJah?jGa]m20cS=3^AUF89MOHIlS@=WhI^VMg2W[^UF?hX^Dl`JeD>7Oc6=ITF\\
f<qJWgWTGRC7ZjX3;c@@5TR?c;:kfI^pd82mCT@?e?m@1j;[U5mh_b2@_M4\gda6
c\7SbFA94^MX7=qUS1`oPhJ:ANFKUKb@b\3oKP_ghhQK]QQqK`PhE2@pRlE1QDm:
ASqK=e6l_XOVZhmGhf=DPKp^RA337BZU?MZ=fhS?jbaME6O60\?djNjCi`S;gZ27
O;Xq7an=TBo23]2^<V2>BUR]YMb5KU14P0>pcoi[W1VpkfDXDRlR\f47JHi0h=q3
>3jWbJp@C??8`TphRcU4YQ1fFMiNe7<X77a?3`eKe]4_DUmOTqS_haFlO37YbC?]
]>lFU1LlP00[pX4=j_kWphM0DUn=3F\ECIJkVd]WYLJQEaccTf>2@=S[pUZ;:M^1
4c]Z=N7DEEOh8fNfB6_3>9VNOKAI2[1`Wl1i[JeLn^oIS1Cp1i2B2\0R^]F2DNo[
WRO=>BbcG=jTBm_TiWc5LQSAVP7_3RWD2hF<mG2p1DTQCW5Z2fl3ZN]E=S=>SL77
>96Pml88ej;7`NV;PGRm@TY8FV3hJH>aQ_lX[56GEFJ<RZ;`ZZ]G@N@XYhap_N0?
G;CqD;41WHQ\l^F?8ljgNiZVM6h0EoUZDLm5egdadILh;V2CF:BH<?^G:AAb3So`
<JJ=[eepGX=KhS^H<X_0^PcigV]Ck8:o=Ap\6O]ZfiMA_S5\[PdDZo_?>9DE1<hH
mPd@`aDRXjeN=p?jnAbXkaWWT^if_Ebg]NE_Emhk09:]bhcQ=AkP]^6SqFi9og[]
5MTVeFZea0A7cNINEO[dF@Z2>MkPO[h1pG8S?XMq24bJXH\AicHn1B77W58W[0am
<:Bo1IKab:p6l>RfdJ]lGPj0O8X=XY`oBQ7cbEn[a^H4fO5GNVQJ<NNpGOK<aE<p
m`TQ6m5q;6\O4k;<E_hjXn^3]n2UTK]DbjRm\d4\JEdHQJM[0:<XSVf@0?;<_jcA
DY5F0Z7i>31Dm8M9QO<5C7KRlX^mWFVWd8Q;hO4A[Y1h?BC;4<1OpSKcCnnq``VX
EB:q;7EP51SmM>QIkeJ?F]cF\JqkJd8Dc9oiB_=2b<WqCgQ7:c<@0mnR^ap:W:?U
aQX?:QY@laR0F0iHGLZ2mTU@eRqJ1oW7Vlh\ggD\lfD:hW_0XkLaPmph@<eGdK[N
S:AU=D<;572PKXFIo;2g?FJp@6^Vhmiqb>]JRYmfAb`LYQYnQO>idZgOVU1TK``_
Ff4jI?Pb?Z2Va?SW7g2gPgC>9=lc\>qFYndAfepJOKB<<<;\fZ@?VZ?k82VT3J7a
fUQoEBehIhMAToaeV1mq3XdHg=ap;@@0MWMm:jK[3M83[JDdAMY8U_?dL1Bhd2c0
qKTb2SZ>q\\T4OJRG?>jK6EBkAGQpYOboIfKE9G4B::FJ>Mk@jbUcjb<OfGmVqMf
\=3>[@9:ei_BE?KGlUJ6jPVM\D5WO`9hCR;\H9]fUE[`LN_N0``=4_H8W>VHkQWS
:?=ZAgdMWU==Q=pWEb>ENQqV7L<?VJkf\C[^a6U]7IU=7>\plcC1A[BqoomcoEOC
?1W:Q_oX[N15`5h9UgCQ_g8Z10VWUW>qdfaIRKjqd_6l;=qEBj3_D[Se4H\SeC9R
YVd4Dn0;mT7iGFBDUCAmH46q7m4ikX=\f`gi<<0Q=PGo@VUFiA7:lZ:1knF@dM89
RHn;Y\Mn6?@94PgN6[_TjGb:`n^Ba@3hg7nFP=;4pXQokDcdpRkne;j7@Y0i_kg8
l_c81N^dL3nqmSQdSg4Q;f>kI46g3k9DK2Na<]MY>Ik9;JNDqBbJo9\hC2Lc3aGI
Ccg6NiSmn;=CPAKhAk0C>UnUV[Cjak@hHpC8ah?22HqLW4:II6nnlgL7e02>bn1f
IF<eGON]SQE`lpGebY_JPep1PoCh>GGBLJO[5S7]i@9U2RYC2qO^=@W4gpSj>jl2
]85[g<ef=bZXjib?q\8Y4Po:fWA_fP_gb^<=l98kJLmeTThWAWG<Ab4O161C8G5\
1S782MBN3;6>bH`\P6V4q[0PaV[epVZ[;8PBBVBi^JK7<qlB6oN]O$
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
4_k?mSQH5DT^<@6loDiYBfePnfO6KP4_TZ5^Vfki:9G3S2?PLBf_ZBCToA8f_e@c
hQ2RV7=Wk]WpHgQMQL5IlmIQf\R`]c9]5?e:o_5P^0pX8?iN^b[n?c2Whhg`BXkP
e9=Hi\nCj<bRSB\a7KTlY8gSfZ[;6enI9G9ZO;ZpSTgPC:p9LPA\IfXd?RN41S1`
:Qq<CL`^Ni]BKnhlWmAU?pHoYEAl`FkNc9=UXf@;DT[6ceqlS6f8^L3[4T\@T_UE
`[62^q0Ng[4E]>>2djg6ef7@e2eMR;pOO^W8\Iq]RiB?j7YIJTqGZTG@_nDaEF4>
Ue9;d5L_kWhm_JadNJn^Y:eT^niQPHp8>VaoL[pB>@4GaWpNhFHZFaq@]QYVFlqi
2doR<Na\`=\nC7>B40p=XAmD`fMCP^FWeW]W5F=q8Bgdn>f?VKPZ5SD4?kQ6[dcC
bBYLbHIVTY^I:MWZ:n2D?JnV2:J=X`qjf=\ake>Gkq6gofMCRH=HM\ffP0]NF4_<
6on?NZS0:>[>bJlCphlj36MdRf>NEDIa1<X@hAjlooKEMXI:Ncd>959d`4VGTeW5
h<O^>Y_IWQe1LL<_8_h4l<E[9Vjn5OAE6VhPofKl?jRPNieqi5;=TZYp;XXed:6q
iW[gc4hi`H0^02d8XJcPqW0FAlgT1kG_T:hnYaOX1JKnZ:cD:ZaOV>lq9G5WE=Y^
<IG^ZinfZ:W;9@F6P9SDF2?]1ejmDRN1GQA>fj7f29Il1B]<bLo:qSY6W>4K?4C_
d^SW`h71EK`23nW1Gc^P\IZFNc4qDeU38U2p05I`C01:45mOL2dZf7l\^Sn8QnpB
4gdLXG9L7T:\6_X1?Bn_=g_GQCR:E_FPX1e[PGABcD[Ae`1K=4i`?`7E@64HJ4qQ
]VIIAXiHlZD@CiNIhCnIBO4O8ooj1GSGa;gOLKOZ\1QedQl@\6FX<:Ym5Od>A3CA
VX8k\J>A]@T@PlHjg`Lql[LbnDYqO>EgS^eV_hBMFNH:HGXeFKh;83DNlP;c:?nG
9FAqF9=F<?F4E@Qai=?dKjBRGJ_m8U0^7K\p9C@Y<\op5WIoDD=q0KFefG1Z6`qk
h7jcN>THhEMnH_ec40Pmi5:j_KWna=aP9de:a1l6l:8H:\Xl5Lk?F@clLo4\cQfk
4ZDMkl:qLc5^SG;X<^YMMgLSJMA_FCO`\MZ?Z2:ga6:\]`@To30cA50:?UVZNeF=
5aGhlXOJmeBM1:?;H3?nIQi2b29]B0OEN0Dg6=p0H_dWAMq`n<SR?KqP<iY8DZqK
55D05DFGkaOJe6_H1g``?eqDLS;?cJCmB?nFQK_YI1QQZeiQcBcNWY1lk;o<V=:8
hRFl3b>no\2XE]n9=Kh>eZ=:jR2nQ1ESB:>FeREEIN7jlKfFPb:YmBGGNMK>OAno
66?H`pH<BNY@kpP^NQeJaJjdb5=l`G:j:bpf`97oY]9WS`_M0=Pn:>oeJ]Of3H^9
U[Y8Gp=YLLb:6pA?e^YOKnFaB34Y?A384IDk]n3mga8[2jgc3YaHhPVVjo@_<>6H
g6hmc[gNI?K<;bCGhgianWFWg;Dnp6YooT[AToOC[hOATAZ=Uf9g_KXdk3jeEWF@
HDnnIZ?H703j3N96`Pk0\Zaa^GRqoOk<5g1p`0M7kN`Em5AlE]P3J@VU5TeF>Kfj
A2l1?5V0S0qBHdjdUWqeBKN`k5qXoD_1RA^2Z=:_1`TG`_LPe;<2S:gAIcDU9j\`
2cSo0I\gBgP;opjWM75JIpfaZ6hkE3I=H:ON7\JhbSgKB>LaFdhWhF=;_5S5DmSQ
gMhe_LaMoTh[<RX<hE]S=?WPYh;9[^0>=\WI3lZjA9abq5QMOgVNp@?P<\3@Ck^i
9];R7hBBIZPJd[NbIS^Uf6K\q0_63<Gh0Tk@4B:iHHYhFZWej>PI:7PB[LhC3ED=
CMN52Ua3hOIL[G5<Y>jNqMhILmiSpkDFjAhCpY4FGTjW]cAKBIU_Y9nY@\9q?0f6
JN0OG9@gb9Y`<8H]7jo2E4fmpU8@P?CTqP`b]=ERfD`?6kJK[U^23iCV>KJYAGV0
=Q9HqS55P7Q\GNg>0@DmWe@T6n;GUYI182PG9TMZDYTeTQ`WojXncODQ2J3bRClq
bE<C`h0Z<loojP_5;?l:LjYekQgASW8Y[jk3bOJma\jQjPhQJ>T0TK5N1I_4Ahd6
d@28^A[aJP7qX:JLfZ\\AF8`oWS@DL8e>eAOqn:K]gB4hk4k:<BK[H1?<CboAOeB
C^]n?pT]A6dc0qf>B8lYmRb=_oGFC]pB0[3;ZYpjd[kk64>^FgeSO3oLk>OMi\Vo
2cma:FGT[5pDbFTi1mH^X3YX]QEV;?H=6D^D;HAqNW[IC>O6AHG_\g??MM[]o86B
^cZ:TiMI;OSKQlEMWJGaZ=VRM=daS13fJS]S?:nAN2A<N123\bcQ=2OPB<nKfUMa
k`0^dIpfDBBh<BMFZZJ[SC99TdMQ\oDQ:EX<b=i4YdS9lIe?CT8c@0Z[VGeMi3PI
[]4m<381KC==[gf;V@bi;E?^<pDk`mCMk;b0K0;Z:_0CbElAVAV=ZKQ:Tf;:KqWb
1U]YL6gZ42aDfLeOVj[g^7Z<U\``C6j4?0kh1OSZSY1FK08]f0a_3_g6[j2o8<h1
pL?6;LblGnk]`lX6V>Wl3DF`bLMMg9Xp9jdI<L3<jVPCICde:b]\VHf>5mfS8^pG
8LUVW]b6QoQi`:BV@_HIa4UdQARY<I]m4=CYYdokJ?2UEDMgaHOCCgmO;]bMHY8S
=RLH?FPp6C=MIW=q6S:gPEHW[DZFIZ?KV<qPhaPmU]pLX@R4eFUlmBkJjX2ZATeS
>1cci3G?^Sl[EIpD1L_miRAQEmVKQIBfhT:>7a]?nfXecZ<39b3h<dT8M`egfB?l
lfgc_j27^5miGYP>OLDP?C1aJ<p:^FVJ9BhXZQM30R8o1iamfP[0Zf=EB;lLm1AO
]?IH_jJFCR^1:QO9a\\7aq^1CZ1d;4i[@mgD]iD85WT@O^DNLF@8Yfdc7aT?LcXg
fSe^Fm1C]cHmlgC9KHU2hc]IaBFAKNB:W\NNVNlShei02q19@JmjE[\Q_QLFVkb@
;[Go:6SQ:7nmnpCaa^Kc<qSHO@jTI43hK\SGXRU;k?p[G9F5jEPZQ=FIE@RLEfjn
A5iOd[6d9AI_94qCS><?_6pXLWj:>QIc\=M8PkQYab@0^od1A\0;:R2C:`pdlXem
FVln>24FfEOVb0Zp_1mJe1>\4Z[8[<AR^Lo1X6j4Vl08mJlag\W65`]Ldo6Uj64:
Uf9F<DqAISI[ea^lcJ\H07BDMYl^CAOejgAVS2oMUjnHc]USO\3K^cN5Tdhd5Y0n
efok^jmW:W^mFSAP]`6O^bq>4n<>dbEF]OKZL?iSN?cU6Ke[oU6]_[a2L\8US58Q
OdW\E<g2ARnVTY2ocVaGQgJ>60TZ?KDDl6KLSKI=93pf==6^6jEQfDFeT\RqabZ6
Wd8<1c8YZ9XR4`=R>^NbXaC2G3Wp[>9T@TO[g?kOH=P9MEP:nfj=>SJde__qdS67
eF_q8gLaA@U>Z65ZH;kMD?ooFC:[f4TG;`]6Uo[2amfn@3b;d9\]WDI;_Y3H>m8o
=BFR9dOOQJqEgaD[>lMdf6dhIGeWmWN8CCPZDG<N2`jV2Sq>`]Fd:Pp^IUh;AZ<:
fA\o5o3VAlZKfNV5@<aPTDnO\>p[1jHH9^dj[DibaK0oC6nE4<a0JXWSPaG=A^_m
_5;4eW^g0m_Z\[FYdpcW;R:NP`=WSnN6gQK2AfZ^C0nP[OnaGOZfHd3jk=e1AeW;
\S_K8=[:2d?TfQC07Sa1EJq^UMeg8?6jSg44gA4GVEI`=^ZMK319TdSe6Sj@:HcC
G]5:k7GPJ^L[7geV8eRkjh[jhCT4ZL__Q1@PeYq3RG27[i27:Uke^\V_RUdn5[ZT
]K@gHFX?^gaoaHjUieKOY\;_[iNCgY^Tn07CMBI]\3^Wo3jXZAf=:<UkDKqdHe=_
QfRMc0;\megp2:f9E>5>lBICHAd5iB=P:N_f:Ab^3e]qDhaRGl0a\:Il[4WceImT
jAV1o85@UcXq1_E[`8BhK5AGlMZo2J[c=nSCPM0?DKM1T@n>H>K@8Mh_Tm_LkPJY
M3qA<m\?k4qE8Ki0:93N6aA_H^AWg[b\N;<oE25\1]VpLh79bi9pab?[0g:^QJZ;
2G4lA8EmadhISleVaWjD:`6pP`94I_\9e5TRKR81P`q=CN<^L7VZIZ\QQ7ciKRmb
EV@1`Q6gO9n;]daRaV8Z=?hMQJKEU[3eg5[9N^k5kD3RRAfqLZOP8[d1VEBRObNM
C7Lb5_5IE`cjLU=@H21<kjfMSHQFQ;;ZNMqNd1CcaBVPcIB@4h_g8_8dH=HK[h>=
RF=CZE?eiY6BdAI@o:`0QXA68dSJ=5XXaJchHY9^P^RT7CI`H1=D44<dXLX6WY@4
O]RgSQpCKBoIW0Gj0;V[mA`=UW37gW02V5:RCbBi2EogVf4b_c^6DYi@CDa^5lcT
gW[XlEX;M5dPg;Z37N^Xe^nKkqe5Pfb5l>NZ]Fm3i^I^HPUZbl6HPf]7q0BZoCNj
p^Q_^Hch\1^gcRSR]C71G30oU07kX^4=3p55lPVaDq:@9:D^Fh`Q3MnnC]Wc3AbB
<HCAEn7P>?C3;qg[]CBB8i0Ia_^C<IaXKabmo=9bVhmEL=F2Gh1@DdT[0<HgHXk@
@_aAq\AX=U<VdH6`33kj5]b`=]B\`8cfZBGA3\A<HFa4[@OfD[DT>T3[k_IMmC=`
^DQQl=7]UIXqPVm@FRQVXMn<NW43=4I1=AA4GU5deg[MoKgPJ2U2\ig7gd?5eh\I
JmOZoXGalSAV[Sd@\MkY1Kc8V?jqVhEiV=i?4KO17VmY1ZFPOn3_PB[HcOU;nQD=
jlPgi`k@hToGJ5ObF]oRP;6U@bV_Fd[Ea\NN1f:?FmAFD0qebgLeaWijGn3h;LqS
@7hakc2<^16GCMN[=HaJX:OdLkd^0pFigDK7GpKlflEFP:L6aDc<VX1PYTge7LH`
bg\6fQ4=afg^>gK?I?pPC>0B[BikIj2U=]\f7GPI=_<NA_4p<P_f01_[92o?lhl_
DmINaP:io4Em5dqd[]6F=3p7=8E4?3[7hYGenbEpE4YMPm=q1V6N\lN?DUnk5YkP
jVE7ic8_i[bq61jBRoSa652R3T7QdS=V9lMS6H[@jFYCRm:gEai<5_:V7_dLeaE2
bBpjgE1ISIpG1X@dUJCQAl0mQhg6:XO^Z=aUjAk4^TECQQpB>aKJ\M32`Zg`]`kT
618^aiNW6DA4S`49J8aHZ0Aj:PgJX;W4WcMfgeMA5pWIYAGOMAWKFgJN<lj_C<KA
F74_id9\TI\GN1;b8i>b@EWG7Y^\5K[_d<DJ9I`6fIS5KVHbA^dWHFoZBCMKqXeT
B_KWpU=Y:l0[`HYNHn?01o[[4omgLmo0V`cpUMD1S9mpQ2>V2aH:5hcAYcWdjebq
Mm3G<OMXkMAS_dN?W1<l_^2U59bM?GHDHADp_[VgAIac`ZPTeQ@q8_cl[P;0_bj_
Qn<IoU9d1@EK?hlq[Tm]Yd_dd`?SfFL<R@\h1V9JOVc`_:jW<[\m4^8\HZnn49aR
MFJ7]mU=:L^gp1K>^5L?J4LN[9l5_kVQ7C4\4M]VWC?Ae3beDk_IUEK4ES?cY<96
kU84QREP5XJe>f8XkQdff_L\@B6q:ilAd<IQnAX<aI6fLR:4cn[DGY7TTR5_29ZS
6YmC=QofiBXP[Bn?UoE\\:CkONj:SWC>W@TNNOHhobHiE@_CVKV0HB26qh]jEF[h
2Ta=Rlai[=0gHAJoW45>]1PUX9KY0lVo3m6kR_id`N9;2qLcYO>:3q6`ZH_MpWAb
fDHpL\795RS3`3NTbe1?M6YYU293QOnY0Y7BWoThVieVYLgASUfq]cSKhH\qmdP0
ZmKfD0[]FWKKP1oQ\b]]fm?>p6_]Yne1AHL]Oh\4kMnh2Hn0Dq]a\5SPETgU_\Mg
:mOMmF8\WP@^k]5HCf1b8QGWPmiTTpV8i\EJVE=P=ehnL]>W<[R0fa79p2__1:g@
pK4UZ:V71RDhkYMD;`ei2K\5\KjNj8iDVY5>:aZSa]2K5:OFMG1m7aC]q6kReISQ
qf<Z9m3W67L1N0o?\_Nl?8U]\LTLWE5]8>^P8^g:_cj=[pZ\;g\FeB0Nd>_Zo3;:
S4na2hH:@VqUa=\5`5c9bZl79pdm5RQi?qL;4^7hnqNlo\=4OqN@WG<Bmq>3<i=j
loLGbl[^fIXl\De84^1:HleX1qYLk\29>RP38R0XZHE3A?KlY=b_9qVf9QjK8i5l
N?S4V_e_X7_O4:@;;cV3EA\_2S0YfKWf:_@d@>pQGMRYAJ=?@;g0V>[C3`7910Y>
dYk[F\mpc<<QH0_[5gSj5nH3n0FD3QZCeGBAB9pLj7aYa?]?dFjkWkDo7DA6Q2]S
`P32ObO59OTL8o6YGk@Y<C>N?;UgE1;O2XolI^UmDXAdMUMg2qSH8ST^<pFN;5[O
bpUZjZ;NQqQ\L2UH?7UFMI`;[0o@PA2Wp<9[Fbf9\[DZGb4=<^k0_;OMJOCG;:BH
T9kQXE=E2X]Xe7l^=Pllp[W2\Yi;^I?9nG4?<8^BCpodhP3TJX:N4Cek?NiMjA]j
E:1Z3kgN=Y]DSdgM95OO]kQ8q:X?R1Cjq7haB[C\_kmO=3Tj87R1RU]Rij81g7I<
Kl]O3kbnh?^F=2QR`E2:>?jgddS@5hSSoPNifojc]hboaMh\^WAJTkTZfFF=aQdR
T_`eDhaEWAfB1q;6OFlKkZkR0=RSHbA9d3>2jaS9O4KY>UQjjBm^M0:@0q_Med=5
7GFRVkLR;YYLPqaRNY`D:p^0Y<famJA3Zl;nHVaFn\TL1HT4KU4AE^p7fFl>`Z]g
M:n0oEl`OZ43S0BnEGFW:dGLKh>WQ@3LR21UKMA7AE9ZM\DbH0RGigg7b>HNoanq
G2LZ];WpPoMjOmLb>ccf7I`fDmUIAVqQHMEihnqQ>Ml]R6RP3ggL3\OkQoE;4aOh
Yl_99Cl\Y`1X?S8n\\P1oELkCf7JKB?]98ePhc;XK?6W9XlcTA3[]HME9qB4<n9N
fUS3TkhaaFP^BqXSZZMVL=QNl:UlBhoQZ@akCW85j1kEmelD:QW6pIm?ZI`7qFFB
VX`CaCY@ZUZOh<:6YA]=P]^>7Aoqcf<RVLZp2EMe;80LGYmK312\q0m`0UF4pLhT
hJ[jonmeAeA6EE>I6gjG`Df>Zp:<][maLT6T>m4l0IB[PVp_`V4<FO62b0iB_gc_
E2:I0fXXcb`UIFMG:NIYTJd;W6YMR\nOe[QgQh86Y4^gY^APEp`OjmQRgehbU>=O
SQYdWqjMKnTFe^@=G]Ll30^cldp8\AD][9CBA<ISHUgZ]hbN0h1^WX=BiJH:ET72
HHjO4Z0;`U9qk]mSTCjp8fHjWd1TN]gnOf234aUZp`9EP43abEkGAcP?[dUCqk^b
;Tb=EgeTiHQCHOkVLp\7ejcjHAR2hdRXo6:n4O0UAQ0BXq6;fVQDL094V8T>FRje
0YAP2NSUn0eTTM?f=Za;F2bXB:VN>lpoXSmonmq[FVK0Qj^331h2^;UdY37pH6Fn
n:?ocO<gaPV]\;OqFFi;__bN`8k:OURKo0>1qa[8beRgl8CbZe5kZdOho<9Bk0[m
o?26Jk;5<<@`??DNgc]6Kp\b12Dc@q`3=0[jS>6f[[2o65mNlCq^i3M3eM:P40:O
lDa?OR2@9EY:G4[YINM^IQLHep;0nWI_YHRdAP>?TTF5kpO]W7eGb1lJ8`fo0^3]
47pQ27DUDCe[0ESG=`kVJJSVMb5RO90eb]WDmDS2F`QR=^h\4?=poQBZ:NYqk4TY
@j3d<UdF=>CIXWi;qh[1@=ek^oI>]fU2:3`dDd9KK^^P3pA5NomB4g1I]MKThoX_
MJfZ=MhY5E7lqcC@oi0cIm<ZTQIA1NmJZ>OGWg9ZB>nhVfojAGZfhdcI=KP>GPBA
ZCVCoQ\[ck7J`oJpM:1nIESpUe0^e21Y_YFC`7LfG\An6ICh]7U0ki0=OKp@DE2a
>2g<VUnYM6B?f4VBS4<U@7ljDbn4^:O8Y^CeJLHbmRE7KLfU6QE;A:N`R64>5pTm
jMKeH$
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
_PS8mSQV5DT^<5ViH=Co^T4aeg6[XB8>Gm_34akkPPFl`k]2dP[acH];3B2GA1b>
f4\2m81`Y8dFOAqIZT=N:>8dEQTE2DIOAfXTO`]2JFiVYoTf8Z9RDEQ3AL0_M;fC
h^:FZX9F:_oYNgnp;<dFae>EN3<<3?C?_b=>7Fl>d6[>img_qRF\o^Xq9LgPeM@O
FV`]aCP3]CUMq:dgUn513k`;RFn1AOPUcM=8Lp^M=0W4im]S?=O=:MH3PgpmE]H0
IKCRTmh57BjU3IK5GX9cOI7^@[Hbmp80\o]=:ILgH\lne@Id=OLK_E1<NLR]fhS\
kU9I]R<]G_[bK<ZfL?gd2@q<f\Lb>8pn;Z9oK_n9kbn6lZQA[fUSYjDQbm[Rk^id
jl82^>C@3RnL>Uk9^DPh8c<o_5QSEI41JIh4O8SS21IpRnm?GNKCJbHjnOlikF?S
Bc<pE2>kLFa\K;i9Yf]7J\;M\>O43fQFL>H2BBGMlQoR?ABSiTV^:CaB1R\I<1aM
840DkS\:hGq^ZGG5j6q6ACPVeA3X]oAU6QX@T3J3FP?^_SU:89pXO@L12P4^XdPJ
X9jEdi;92dg`27Q1V9kS1E8cB;7bQ0p=@@Z?;JSgdL<B??\65@@lE\n]LKE5<^n9
Q^;pC_QL_mpR4>Mcg;AGR\j11LW8RXeY?E0Y3L<ceOAA<BMlKB;TZ\P^;5DHA1E=
IA\OW?TE9Li:P=hLDSj`4=0EeHahecEL^0p^EA2;[<jeLbOOA^o=dII<mE]3:o<B
\1b57ee4WNgI\3dSaaiWYOZbDfG\oDZT5Ko09AiPSgLK7iUBmmAoQ4qi_cL3^Ui5
SSLi<GiKbEcSIJg`_GE]8_R9G1=cFmWOnUSPCc3>K3P`A>AU\;LnA7f;?Q_iA2Jj
<_Ed\hmC?9p2847<1WMB7Uk>M4JX<BcljC67MJQZWgKHmdO`3BOld_U1Y[1F]<DX
dp6iTAmI4;=0kB5VH:PPUhLkn@AbdgefN=Kfj1EjYPLamIi[L]n8S49k?4oZ1E0D
dh66`F6LMQNh@g_=N^]^pl6S?5hPqN2<9G]>R;Ej;a:bF\abk_gd@]@d9=8Bd7=_
^d3f]\7l\E_8jl1KZMNY=TbC=hnkI`]2Jk7g=9o[qST@;KjU[XmMJnR`l8LbDhUG
pOUZVX^>qTmm\a=qkhJYgGX4^2FlHmF=Jn:VgVhO@hOO9SF35ljBNTe`;=Af6k=8
p]Kne3:E:X]ZaW1nn@\7]`9i5M^f>;\ifk]0j?MX07W0M^Y\@j0caXMgdMlni7E1
H]Vn4\EaFGkD\Mj=eJj6B>Y<2q_NV_OMm;AMHK0`EOYXB\f<bKe<MVZHfA8mnk]J
jY:?bQE1;CQHGERGYd@YR]VJBC_^V_Ib`<N3[X;@KoJ6F=qDDPe6a5b4jBn:AcSC
O^D<TLacoB2nQg?AA;N0h8ZhUUXACD?\oMfZ=WbBQKo=fa;D^PB`496o62eb]g@O
2TKpg3J^OP6\T76^G^a;MMFpWb_K2XR2bon<jdcngm?l`ogd4W`6YJDOM[S^S4DB
7foo[3eH4hY4SBF;K<RL^39eB[4WE3K7<Y8eZgPh914pL]cVjg\p]XE5oQgkXHEF
L4IV3[1`UVM^gT_U;f2B^HmERjb[0dnIEoH]gQ2hU`4m^gll1UeYJ3=cMenRacVp
=C;<EMi7IJX7TMGLiNP8lPVqm0?TAC2pfSY\WiB7K?Nf9=XU0_LaTRUnWHC@dV^h
9A\O82KUq1T>523i@Fna0gWTLJ25;VWpmoooAmGq=<DW3U9lJZoefo]ajPf`d7\H
oSIE_930gETnK=MU8]DSaCKAdc8PTadOEOjJWH]5=4B`If5bNjZnMaSF76NDJ0ba
YaEdel=^;WbdYHRAFNYK\SFV16pEDgn=mSq^JV_cZVpB\KHo:Oqk<eHQ\cO\AWo\
TS;1DaTjBKnYTf9eZ;VV7H77=kGoPLg]3D0\Vdg:NSkhH]Mh[HMDR>Ff@OlpMaPe
8OnRXW5_oLTfgH]\9VUA5@FoOA=0@WB0j\LSq8Gb;@:US?hKi0VDKImm]6\=L8`c
T>dl14i5\2O4km:`DS1bJcfLnZeEFMCQSIhSD>Y7APc=N2b^dXbg6qT[^l46^pdI
8[:nqZd8f4cSM<OgLNEFO8UPXpM_2DllGXWf?;hPcAS`eZ`29<:9_b]Dk^^05qR4
2NI42>n6G^6Od>ed217cYKMHPC44_K[LmYQLAh;H6p@:@@gf^m_d\34S6_VbGOnf
e\hQR;cDGQZQOUaE50_52qM`Smh[6hGYkZe_89daXgPhhTeIfmTCMBhNKQE_kbm:
Dp`[R8gE;WG4V_Ee:M5NN6A_UW^]BhX7]A_>oCK55_oUCqP8;cameqTYaIj9Y3UY
CPSHdR<KDPIl>i565FoBSRhUd9ME>I:_kl[HoDG^ZA15^KbkJBp4eWh=9=[UE>jF
CLQ6ITCHd4VBAA0ZDR>jW:l@C6NqNSkoN]Gp6\H>?Oq6Y6Kc?]UZnDNe;MbdnP`p
R;eY3cFDW\P\e5Xg6X^dm0AePOEe>gSbXEgk^N7=E4Hqh<[di7\Rc;5F`e:1[BCX
okJ1n2jOGjKLa]V>8BnURWGqi<jOCmgn27lJUgB=;JfM[oWd6KTO\hEUggJ4T]K4
K[@_9QZq<oCe@_d\F6C[mVJN6[>]OEkJI1nAA[2JQ:J4K6VCIVUqlj5?<j7MnJX0
5HS@lVjmiKXEm7`\5<D<`JYK[kLM7@@pjLC6``?pf[aCI[KZ>^j7c4;\SLbiICA>
<^j?VkWUpX:O3a7Zp8ZNTEnk_BkX=A;If`<p:77Vb:Q^<4G84>f]:d[Y<=m3lZYb
^Wl@Q\;[n<dHkaKp6;AITaSJ5g_ZX2k6XXlWQ@UaqFNfLMdnGdg6:JfKIkkOGqlh
2@R9=_;SclnC\e]TiC[nPH7>gccMm[TEpe]iMblMb;[8M6l`MGJcaMF@Vk0RCaPW
mMPCTKiWg\Wd?WM2aXPC<gNAcql>;BBcop1I5N91C2kR=ne@<X?Jn@U0fCbL7>8P
gFf@TcGGaHEo8o@:\<Xg`JVl;5MjB8U\h<I5;E[LY<2aFBqXOoC@KMf]j6XOn0[I
b<H5RNHpG0o20Y[qc?@_o5;_UfN8d>IeH>EaC`b2UG2b04gA9SmnRnFn6oCT;c>S
<Rq<CYA>XmBWidaG?:oXNQ`p^ATX8YD0hU:LUI:LNKS<mHLKbmAokC\\JOZo0\Z@
okm:=m>l=<C<@N[85m1i@4P:O\F4i>^mqHT3T=dn\pjBbgJoRKEc=``]6XS<:Oqf
<29[PmJJ>0?0ROUk`OC^hA[f_cm^_[<3@EM7D<`UKmL5n_Nhk@IP^8DoQaD2X@4]
lqB==ZYO3JpA2XT0om^m=`]?GLn\DC10<a20bQqmf;O5DZb[hBGJD3NUGbj@jWcD
]5dSM@2044AMXPj9Wj<Vo?Nk<>Bi^<PD`<XSXPCO5p@;B[Cdlm4f`[E_j]1[^Q5e
@E?JU@RF4CWLbJSTGge`e2>K@L[^acj1D\]R`qI=JGSJ^:pj4M5M7f\4KeG39mD\
:D=f^`OLN5;=XW>H<`Khdq\8[Ob`W1pg[HPJ`E8q88B\iVOAqgAmdI]n_aB4bTHf
]Bm[kT]9a>ZH71<@p0UQ<0;FWP^EcB7i3FUoZBi1L8[\DLMeA:BC]GUYnFMVIk0^
2QIY;B?WAc:a:]?`ROL6qA<<UXijDVFS^6]49Mdlbdo4mi^Q=J;?5XLcWPX?5Ld`
q]B7d0H?A2FBHA\NY\P<SZ>@VFf=c=kj3NYT`q53YFNEqoG<foa<IPZcKV09T?GG
<ohI=5I?J2bNlDdVfbk_jN8VM>99NNCVT:^WPj0ZAlfd255iWB57hGP2OiSD7Y0a
3DODiioqaW[bP^gHQIfTajU@<Ri7Rib3G;`_dO5]^Gl@GC3LcTLV7Q1L^CLW_J]^
o`b6?`RINN`MO:2[A<4iod3G9g9`mWpIW0Z8XW<Q>bEQW30NkfWQ9`PD0W<l^mGR
5;^dCK6XGQQC^dG4^<kkg?Djk;N\_o?;ZgGa5_OCd?mTG:dbGdjd:pCHfJVPg0X9
?9gE[jZnQEoR3QD`X0o2MJ9SnFNgAYQ]>KXdLIIab9oNe5MA3l>4ZXC\`g=D`>C=
<7i;FR`WMZq<XWh6ONq2Wjc6]C7?lZCL7;mnlHKZ=pVYAA\TJG4\l<kdHZo9P@_n
hg\ggmDGh]0^ea9ZKe^\]3h:oIkQhM0BE99G\5TP`TVBB;X;icD;EDqmMS2PHCPn
NiF0Ci6=^\WG;DFp[NjQ\jopmL<oQ[Z?^KFcW08WSjCJ;58PJMC:LQC4_e>?bUIV
p^gKjI?\51YSL6E>kJONE8R1IZne?J767G?L16]\OWA64$
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
:diU5SQV5DT^<MMHI3Y;>jPa`h2Z8aClXDKaab5BUoJ5Vld[mc^4Dm6`0GbhPHg;
9CF05QFnB;\kZh8qm_bD;ihAUP0Hf054OFcha[e`AR7fqm1J384RLUTC2;?DbM:e
4:IEVQ\]Xp1^\CAmpYjjO5gJN7k>o`kj6i3f4Ph<@\A;pl1:kU_hq@H8YAh6]\>1
CX]F_mNEFhR5o=0pf@1G>jG24c_`2jS]Lk<]FhJ5`_o]ph0h_oL1pe;_Nm@:`7h]
@IhF;CV0W@IDOOdG@]1p:2K760c\C:n=Fl0Pn23P^<CoE8e2n4\Hhkf<SMTKp<;Q
_NiWp?A@1\\cl44\:BMeN<nYk>6MdWjQph8o^47j53\oQZ5o;0`d`4eq8An3^L8<
CX=ag9:NJ9h_Qcc<hFR=l14EMZ_MkZ69E8i9GT_ZO9^4QX[]p??R2_\@q>`[OgDN
M@IbTIb>OFI03ie1Y2mPDWBdL_HMS;f=0Yk?1YFSX5j7adX1b6=giC33cjgJ>]8:
1IKk_XTT8Wk2]P9hq9Fk5`[5Eh[K\h]B\lGe<Y1[AdASO>=8lchj1^?T[`IC7bl@
7hjGE>13iVCYm4BC@@_5pRWdAVeCAE==\cZllW4Wjp>R^C0cTq0kM]PSF;nZFgXN
ejE];IJ9X@iF6;M;@ASd<q7iJKB>6W0=8Z`^UF[mhoBNaJo2Rlk8UeUf23Oe>dCj
MKFf^k]KUj9I0DD0F^_naQR]Of3Z<PjT;\5:M;ZHPn^TTqlIJjPRMC5`9C4B84=^
_op`UCGEcYpT6LmC>N1=JE8gfRn<5`KhJaj6DiJb^TVNLiqQ\7;Y]aA<M=qRbYRa
O;FJ2DV7D9ZULgHW3VgT0L8j4kIESi=311TN]Z;Nn>0bXZ]JR142aGVK8BodCXI>
:?Cq=A^46hUG`>Z1a006C7YP]4nf\\\<0XjqZhb`Q?ZqPjj75QTIV=[<97og]Pnh
_hVFRUI0046?LS=0U89i>=f?1<BpRR1T_HaqE=V]ocULl62f@1LmE]FITG_\i_Tq
?n8L^2@<UhWh>;QUW15V]1p8O0WSo762gR4GnXdUk02iUI5Dmn>dAJ[J93b1hS<5
T=O<ZQZ:_>j`0=bplU6RkEio2dPC7CgBCG4`7ShK>c^WljSPQ2FqOhPYADFR3J1M
NhaNa9?l`CKiRlO6GPHXaD=q1aTSNhmn=@Mq^0Yafhg>lZ@KE[Y2p7A<KmYMET0=
A30<iZZPCgH8h1:lRi`b9?2n8C`p:m7i1\e`3>IgLoFekaLEdDD1S3`A[95QLR``
PMg_qNbX:eOXI1NI]?7ST]UobF5]E4XDk6VAG5^\7[bD2[HfWDZhb1<gmZm_eLc1
dQm_64KF]c<6eIbgX0lANOgBlc4<KYoWqA9kUJF4IkHNARXJ?dbU[NE3@Z0MI08c
\GXVoNdMVpGTL8dI58SC_3`<Q:g1T9B0h1d64[>XH2oV>j]A29Yb8H3l8_LOM3Rn
Q:E1hZ2AAd;b5>_g1IF;V9EJ85=Pe^7da3d81qP1nHIC6pZNgZe_jqfE4`\W1_b<
4bFc:Q>gqL017e9Uh=\M`:k5TkoB6:ca3H<o\O6MenT@>TK0TIj84L4HIZa[?UFP
D[6=01_9qNR9C[LUl_[MSSn>PUY<DSTC?\Lan\>CY:6p?8O=e>2gb\TI83PMHhPm
SRJh]W>XG?HLE0oK^E;JH?CYS?b:>Ji@ePMWIc?>lNiDU;A;:53SAU2ElFi]6]B@
RT8M@XiJ@dg`2<J_cbNqV>X@mPiNPE^\5d_Z_AVHd:SL4jc\LM76omQEp02C^]Hm
EaFNYd\;mM0L40PkD_ZK@Q^^iQiL>`i77fajkha=6I4=XY2ihE5TR52WfGnYZ1[V
m1jOcVdcnEk`dlK`kTeM5ml[:^OCo=V:pM=GVgXH<YkURTkjLA;ZFRNPMn3E6F5T
T<jM8qGLIl?<4V1@L=><QLjP]`OdRcXF8j1ObQJ`C48HRO]`Vm28dfdY]En1=>PO
mWV;Dgo`\n:aa?V\K^F=E_V^T0Dok0h:F@7IkU:7na3XbpJ7c<76Lp?efnk5<pD^
_`1E4?SaR\J>4>e:VT566@M6>Pf8NoOm=H:`DFmK:B[k0PkV52RToKo2I;c>in^2
UKXJ23VE4AmDgNNK2qRNW7?O>W?[o9j<2NJ=KQL??:7hSRaV5M@;XEPZ>jM=4@FI
6;TL^[G3@dWBdp?Z?_R7>qiijDHYkR13KoRgh1K6[<2mb3Ge\ZN0CpP]cM5mlpBA
C=dejnI>^33ce6R55ScjhbehoVI@UE=AYnICV`g]]_3O0Yl[9FTenQgi60l6pbEc
VYCmhERpmX9d[KB5d0HELMbdi@468K<fGnZX7CFDW5i4UCH1gQTj_kiU;RB95oZ1
XDfBE5e<m@OFh09^^XFUb]dQiaVeLHMnOj19d]q<O8k8_EIdh[cc_RZW9dVqG9kD
2KjqS5VfW_QG?>GEcgDi\P2CKd4R0PSgjeDmb=H3^mi>TLi<O1;Hb1Ek;4q:h7\m
Y8ioc^>hNZMgWP[T82Ci`:2o2nOXa0SjT=FNmHC]J@`gZi0n?\Fm0O2[V=3?DqPS
=Rj\oq0XZL64qnlcQCS49m^J`=1QTWJN\CiS0aUcTNHSDde;J0@JX0A5Wb_g8REl
idXLh=^ID0KXWn=cQ7dXnIk^Ma38Vqg<Ua2?kI4baWJdYKVJS;DHo9L1jmI^mB:W
3\^DFhJ6dF56`_UhaWhLed_?eYnYMMgOU4][NOZSAfpi>;[5ffLOe]KK7K:Ri70K
i1:KdcbUSTB=RdF0>1hXo3oZ9acJgOMZ\MC_QJn39UOiP;[VkW>J6e\qh>Go?5Xn
L;K=L5B9Oo5DN`@32G>6]=m>fgWLUT>AbYCCFHl9BZnBh:L2GBbbSg3Wea6dGl<E
979qmP4=`EXnM;0N`R@Ne15U0@19JC8?01KgElYE@6ndK@H7d;S5NHdaDQVcL<DY
bd<SH_\G;LMEqKZ2PQIS\dU_e<h>U0WAiAT^8X@g4@;0YC>]dBoid[OTKOH59m41
2`EkfF\>g_84Y9O2S\h[1EnqKUVj6Eap^kH\9aMqR@I;[8DX>0;ek_IIQc=<_5qS
4?SBcZaH4FjX1I>PM:bK>_?VAq2Z\;BSEIj`gGFZm=O_Gk_XUUb0Y:@3KVpcH\nW
BA`AQWf?KJ`>8PE<ic_dT\mc2LHRoekBX__cVGMl;hp?g6R^K$
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
eQBKWSQH5DT^<cYMUXaDGSm1TIL]4_eXE@=cV[eDLPC2FWQ\Fd1=EN;<n80X=b5J
one5Vh\bGVO^Z@eRp7ERP;VhWl=^Q2ZLI\A6M33q:boF17k?8T9k@2kCM4>JGTq[
9A^ampBeh4Kg66LC1o@kH][n5@AdVCi_:@F@Ih2=c?2=DJQXq8E8G]^GphD4V?@_
f3J[M<TDS5_@YH2hZWkR85i4labhnc_aXe8@q[OQ87U3qR]]AD?ph@R?m5Lco7<A
3jFVebOLUmbeDf=KYYFB`mHDdES:VWkRQ>IXP8nL1EGTiafLM:2ZC;aIed6N1cnf
l]V<iR`5D`FG^gVAhdqITWH5klM<ISbBPcYTd@i098]`hMRh<`O`E4H\F@4QnkCS
FokN6=9nZVi0>R1eaSMW13@VGO\`h\R@HT4MgPW@?6@bDqgUBaoJ@6[TkJ<]^::<
_QUW`ConHe:]2ibM;U3S0^BgK=[G[I9OeNH@;5K5hm^DTCO>=cH[=Zi5@L5f4CoD
k<LnGgSEp[jPm6>UX6WVL===5GP@5VI48XgES<8T8aHOeYngi5\X163\hh54p9o8
JLo2[d^`1e]fe7;^B9TDbmO3?GFKSkdmE>Vb6nVG^PUkN:gcgHSR7_`ac3YN98ca
EX\<b3\3L1W4W=@96DMlcq>Qml6iSpYS=8hYG;96F8Kkn7:13:EMN7PXU=On]h5@
O4;L?KXoeI>l6nB@J8[JcZE26Ko9Y=0[]<QX1B1EX92S<Pj?ko6fLF:a24K9_P@@
pPRM^i8A::;o]1e;JKV5nT=q5dJdmeRqLWlEm<Xidb^k]CYnYJ:oo2DNGH:H`KPV
]WnE;ZEEf[]GJ>8q4jOhn4q1^?Cb@N5W91O06IVAl^;NXbXoB_hCBK6Oj=5F\kSd
H4VQG<6=XdCEo\X3Yg\4R28Q3M4g8Bal>RPIN`6YBEeZ0g7\[F530W5UbI?Ac_j6
n4[P^?Ca5o?WXGU\`cPTiYl1Qg[mF=paMPXUKhRT`KS_PM2IJl]XBHb8C0P;[on_
DloZ7bT17THPC_4hYi8EDb3T:kK_USNN2jGE\e0[K6oYfdRbhGYQ<ZACCp>;[mDY
_9f3?R3Ng;_f`Q2L:Si8DF@Ad=T20=]^[ZiW\3NcX\[Oo08Sk3ZIEJ>_JCaf7f6?
[>;dLK9kHi7cEFeNMN87q4]h=M2Ee=GOj7NJj99ZAL?kfbPUE<fT@\k2c;AC5Lll
5cWTlCbHB3NYGbAf[h[09[moF49Cn:UCeo[Cl_k?bTY0WjaqH3SoW\H<8kC[hKVN
9]h6MoFHG?=ipM3Ai7>d\Q@MVKWIm[2Fl3_\6;hn4FOC;_@`YiIV<ZFYKB0i[4b=
P?mEXXaPPb[LWcKMN?8W[`_eCoOVGUO;<QdgZ4MYmCCVcRhp8o:jfDcM59U\3=]c
06F7DCQ>W8eRDh>e4MjRldA]E4K=K]q;35^W[a<iD0TdeYMHWG>d2q=WDWLfeH2H
KU7=M8Kd^UR]=>FHSRBkQVq79M1Z:RnPE81^I?;IBnKPMpX4LJH8VHMWQQjQb3@3
WaB]PE]cY@bH6iX8`pGOM]F1?MYeORa4?\m[bIED6:bfBPR?iT^3Gg\oT^fg[BBl
bV1Tf8c]?]1NGQ\hn:1[Z_H97F;\9]HT?JmJIWm9np?PMXXDepDQeMQ9epG[>;`G
@p<;Ll[U4q`S4C80b;B]S^=inB^efW3;gE<RG8Y232OWd;3HGdfAWZ\=]A<HSZ;O
Uj7<:KfW[jESS\P7pdkfhEcjMZ9H]BR8L@S1ZSPe>KXhUDBJL1FJC_Q:_aF^jfZU
@g@`mZdo;UeihJL40n6^HNLRQ:<BL0=\h^=JOiJkjGfd^gG`k7dpmJ[LOF;pSLf3
KaNDm>lKYiA>6G51ICpgSQlW22p82X3Uj;eeML5CnLjBLZJYEF9E9GIfLUT2MaBZ
NF6D<lW6Jm]Ak6:][eB_C41F9p<nDlleZ2F4KS>1O\1:h2c;aH2Z2N3X;QfQ0`Dm
57X8V`TT8e77apK3cidF2Y:FdO41HTfdcWNb?3Sa]`Kf1nDHSqmbM766A3<C>`jG
5TS3gdE5oU>Kn:4[6LL6Dqo9FbH>qIWZfmAVCS[dSJ0B@g=c<6@21a@?6<g6CaKa
o3EoJ62hD:M2QZ6]IFYK_QZ>q[R1D1SML>fTh\EH2@k\6qQaoce99AMGESjLCVJV
9_PJZf=`oo[Z`98galQH6QaaqhSb9h3n3Qf2947Hg@N5g=f5ZIcO>82Y`Fb1L7Z=
l\WqH98h_FSTcMKPLYb@5:8Pogm6gDcVA`ZT`DRXITo\aQqolZLmDP;HM4Th_?01
VT8lW3f_=^?=MT_Dno14IXQeNqSdWYjCXp<iZnmlgqH]R<P2pM530cbXKFZIC?\1
_RC]CeQ[Jbfb1SlL?kaXagTiF0:<:Uda]=\[0dY?3ol_p=1UO^\Zp28o4R9Tq>I3
IgdlF_>E^?eU<m?fPQN7dGHlU;6^910ERNbf_3YO7doU]ZVIeq?LDVC[JpMP^K8I
UJ0<MNAn?7Q7VUe_]KBGG3eM3j8o;]jF[6j^k;oSa<F[<4icWTDG`336AcpP?h2h
R5fO@hn3WClS;KhBOoZb`0We\QT]WJ?]=;Lc^l0PnCjQ3RS_kmpKloBBgOqS8IM@
F=3?;Xdq\=TN[IFEG9o=N9p69O9Y6Ei83noN>81hCN:JGhi=RAkP2p^1`bF\_FGV
_IXif@6Cam>bPn??DTnA^GG:_>]RipW@;OnnnS=0l9ldqW5[TW@6ZN`TV\lgKE@T
=EcR=_d^6boq@X:5^iIi<Tlo`<pOPalC?eMdmG595j_TcPOnXHFlHRUG[qY__EOW
5D:;OF_NI8RXJiGc5K1:E@P[U;LR43\l>8gRcG8M[q=WCP1A0;^PZLCapnmk[0MK
fPR5OIWTV;^0m^M>MGeMI@Vq4D9Q4Y@nVKqk:UZ;6^917D[chA=NB3c80@TfB=d]
;Cqa=0jnPH1cHc6JUS:Y9MYXcmoOZK23HnHah4580DIgm5OXHTb0EZSlodVDXJFE
OLAiQ<\==pB5f82gbpI^WW`Yp<HW0=M;0b`Oj>F94c0o=_M4hOJE_LR6PB:G338o
e8ZWR9ZeROPofWm6:A1S;oaSJg_Bl=o?QjcTT=Q29=B69c=@_RY\QD3@IQAfRCjl
E;dOQEZL13`ICqECT7^i]A]R<0V`:m8j]SI12gG\3kG=41_;l0]d\[VG?kBfS\`0
e2^67I;HBeFX7`pV[][>B<lAF6:B]@S1ZBXH>PU_63@0]D=IiKCRoQLH4GGmBaM8
o0_TnDhg9nDIGn]hM@`oeP<_ieP\3KdeHp8S[AoT8T8eOjKJm<TEV?oNQ>`=R]_>
V<IoD\ieUAQ6c@jCAeXm8ino9VOZk<c<<B`nWgY=PXZ^]:<NGcXWq;GU>L]_QTMS
]9?m6?CVfRSB:CVWMTIeYN6mGSb^7MB0\:ni22Mh;QBmi8SNB75ne=?aR7@jL0;l
hcLNobPq`I^KXVHpakkVaoefPd5Pd<LlJ3Qe^1@Emc[m^=MGAM]1^1Do=o5HCYlC
@@oj]_oo[`^28lUo\38TE3^Nek`:iP\_RJb6\GPY;]G17iDkAS2BqW>IPi7W]_ZY
08?aeUPYA4`qEmPRc`:qE1?Mncq<OZRYaXaoI`9lSQ3f7hb>[=X@f4XP4qMHDc[<
EhS;=ln0Ae`F]AV[`C_3<8AVd<e6;eXW`0C>YCVY=PYTY0<Y31Q57<c<U>HJJ;><
4mokUjgf`F`FiBVFjNm3d<B1o9IEEUo3@BQHac[_1:M3^e]Mh\^=_?cnUeB_Gg5i
mI5>U:g4`25@0=qDkoJWV`ZJ`CTP=3a5@GPCgUYUF5UA6=LWmUWjV\TGS=`^iZJ]
nHO;XCUHLJh@m1iPEa@8IkV;RWAWiCf7YqboNl;iU13]j=@bk3WkNR8=>Q6Lk2Eb
6;67D3Z@^7mFO=7k=jlf7XABC8fVZj`JKCkmOU7^MfCSZh\R3kM6pXGEej_2]CMl
3_Yk6gaWZ]i3Ub1X7]Y6NfTmT1fi:07CUkb0kYM]gKBbYA1k]A_n8aCg]Oh:m\Yk
GLe;SVOq\FYGjYS79\12jcGNNh16>4^f1c630>ckPcYgaC;1Ll`KSFdZikbhZ@2Z
BOF@ML5`[B5>:P`aQJe4=dbdSNl`H0j11?G=KVm^P8Fhp2KXPJga4J5<A24>g\:K
ki>\@CggiXcS5Agm7RhqHeaC\22bi`Tj1KmJ>n@8Kd>jE9cgND\?p3<?8=:BVFS2
A1S3i6DlfIO:QIT[WR]N8LM[86M4k\>[pc9\@U9q6:8m^o\j46@h6k43:>opCoU:
Zmek[SMHq9[ek2P1_b^?VUI=RR_amTPNCBRbboGQN<dJ@^n?6i9pS385^oM:]FoJ
?e:JIH29^emIKKLLQ3edg_1;`6:g4<p;GI31^R]`_lJj>1A=[RhNCZId6dnKUc]B
[5DiVKW@KpEW_\4;X4j^e=1CUOYYXCh:h8oDU?IE@F40SSV4g]L[qkP]n:SlpTNf
XnUFd>hQfFYAdmi?XZgW\Af>l8K]S2766Zhqh5em4]mp0J66LTq`XanS<??H9N1m
hnbh\[8E@jM<AFF\B5iBapL9`oA_AaMb^]?mD>RBipC=PnQNEX<ljjWnal2:mY23
fTCi=_7YRN`HU;]?2egbQ5Q1DO5\=LAZ0kVnTlIX@:InA8DheM3YanA4IW;Bcg`7
5XTRbq=HHA4L>p5dQ9156>p`>mnW7U<XLnXLPNLf^epO_>?U0\441Bg6LT;]P<bW
lVEb1W8[UZVeG:<2mad^OjXjdmS:S]mK18mF3I<P]n]8PJ8=T7O>5TA8c<^WNCZo
=7HJMW^N:g7WbpC3A3\C2p]3^NWUE]q[^n9Km5q?RD^FJ3]\EJj3WiS;9g9=JhKL
X\k;Pe[T^LUKi6YhInp=dT7YZ>p<ZMne47p\E<c0^K:G[4;ca_4ZkW2e9c3]BLWS
:fk?S@@Lj;m[?f<<91B9LkSB_D4IDZ>bJiBG@6a1@Vcb]fcP4n4TGGEAo_QmZ6jG
;JjW8pGfWQ\aRqU0FmOVnC9U^Bc6BfKhO>A9X[_CQ44Gjp>lGhV^AC=B0A?bRDo9
6?P9pTfP?bbHpE1c50C05j0N:U3HKCPcBQkZA<S[9P4]\`LkqBUPcKS;MM@VBZKW
_:ng[BF1h9Kl1i<d`Q8bq<cTK1XPq`[M6k6PfI2F8CTSlie0[4H0d^g@EBDp9KMF
<TYe0^TTIH6di976:1HMqk2974>l$
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
C^\QKSQd5DT^<1lKOQcOF9[p=9P6mOAIO?G7^NPXlHc3l=WH]R8=F2_aLRp4RiD\
kV@5Z\S4NJlVQAL_Ye^k7Va1Bm^of=UaEf3CIq1??OnJpd9<7QV_fE6Zl`@oSKJL
GRV?Vome_8O7`pAnN8JAf\XN\5QZgBo_j:_Tp3[d^YHc;UMLEB<aQhG`9qNg8O4]
8^ZLkf8nkkXAfbU9_9GC]R@fX5X0pWHMc9Y@WPHHSk4JA2QnD<TH0?A_MGJkjb0R
?qa3h^CD;n4\c0\V5ebYF26Z7;=Z\BJ@TEqHSAb`eCp2mLUDe6YK`X?Oc<XZ@dBA
a]f:7]@XffC9CjI<?OHKd5_6[XicLF;oBap\[>65^W5TIaDQ^c2e<TD__6<04YKk
?^986RQibJPTamJC9_3q4jB5YP5KO[UM9@D@m?em>j:d_4lBdbiH7]jQhEWTLN=q
@kikDVipd:6K8WI1lDX4l=3JAko4N7[[@^o<I=CjYWmCiRk8>?K^:@ai=QLB4_L3
e[>[d\c_PdRG@T@C9Yj]aNLi8AWSeIp<UK=T:Rq7XX31`2TDk<bQTm<ehibVAO1Y
ff50ARY[IKqXf@e@ol^<Q^E]S;BdL_4G5]U2R0GZ1Rlpg=R`OmidLa3];obLLWA1
944YpkJoIVV`p3<aHh]dp\kbBH[_d0dJkTGl6m8Hd2^mf54B:[dWkZOjln:q@J4D
MnXp@n>JdRR;e>N94L^NI4An57RTZ<ajV?EIQlbMOU\<N:FZfIUYYA3B`JHq\Wcc
8]E3Q`DMeUU3@G;5J\_;@^]OPle1`IU;[gQ9>XQ^?JXZqe1;R5nX1W4ng=M^mn_Y
Lo=1QL@7[3A87U4kI6i8J6]8p@eW\OQ=0Ijm6WE8MA_P82O@HKogW4NnaKkAl6eF
fB0W>Gb_\ZSceeZ6l2N?X6[?n_M6PBoq1Kejl8Dq:KD^3X8Xd;XZ8TOBE1:U^o54
65`]o5bUD[1aFRX@J]8FfN8XD\UG4nFeKX3cmCCSfSAA6ZKEOUfYaJLFPGj30FQp
P;GXf6Tp_We^=6ScklXhkE2a[omOCfl990ZP7388nM6kP=8H4Q9@j:qT\Ye3ZB]=
<bhA94YGbXkP7`Y4oJ_aPe9d8>e`:<SOhMe090F]FhDGLPonn;NcW5nmRA<VF9lH
UIaQVgj;>60qn8h`MWKRlH\HM^2[joBUg\cn^kKM99]ROKmp19L<DEHPPT?YBRS5
CE]WmaeDfK8f<2S9KJ8Z[diOB1V:4;V\R0\B\R5hDOC0Emj6`Cn=CM_OP37Ri7pi
:NVV1=XkT:CG^gMKe0==Fh8d33g9@`;`;DKTZbMAjQpe;ZnQFlpkO`G\\0]7>oK8
BDA;4d<qOa3LV_MpZl250feq?3bHfG6agIBRYdZXVWKKj`SkLaWF6b:HQ^qU:eiE
cF:jULkZlP_1H9eijUEZGpQh5VXD4q?BLic[DpQ=C6X@fnnD4^S@FLb]j_D5]bV_
5I7_025Zb\alglqZ2?K];eqQC=A2lmV^FmcH?M097j;fAoRGNRB:2WlN8>N[<80p
k6nn<R6nJl8W8jFl@YW>G>_d:dmhoNGe0FK7GOdLB0J:qcPL6SkndJdYl^D8l4=`
B]CeY5AO9A1=dZSBLo<8T<DNO2:A]BS>aBea[pbM23LMT_1l6\O8h7XQ1=BH61O:
6heSBGORWo[M2cGo5_m<3nj?gPj0EF5J51q[]Ke7XRp7A^hZbB51bqcSTdZVo_H@
EIkS^[FSR9`LYA7P@6:h]I=b2BGXXalCeQ]^l;pPV<;^a5DJ^;LOigZeeCEeW_6Q
U>g\ReW;ZP\^WhFdOh=@2ER9]m4[K5W6D2:@b^Xc37bk;Lp9YA\[762P]m@9YJ33
MdoP[UMVOC^I9?5p?ID:79@q@]R]BmpLNWHLFQac7TI[QeBWg[8>T25;VD5?gm6b
;E]93lU2M3Fq8k36`@oHh=c9JH=k[efj`URBf=EEW=h[]LRU1U8iSLMap<]F?2[F
[@nj]lQ\8f;g[eX7IC_3M7PdS_gEBOfeg6daUY=c8WJfaTJR7pQH?TBM>;EC1lPE
a@8[j^jk93WZlC<4>==]cAAgNFF0HlT4^4ei<mS90D1SGRqUKW=W`:pUA\G5P335
eq[c[b4U[l^jb_^fRRSJYPER8TVdCFmL@XLW_WM4\4biESI]mp16SlKb8RKJYFhc
c^cHmFC3JBKMC41kXUFO[L8Ydla=aPFg_Pl5Ocq`oJF>@ePUkDdJLO0n6OY_;DQ3
1T=alWl9@9_L=LmcPnOW?=:dHVbIjTMQ_SbX6MF0M_]<H7D[mJql6_SZG3qm>V7^
WpG\5P_:N=iAaA>_4[R`nGfCD`WHOe>j29K2094O3^DkQApPM]f=5nW\]A;XUBn?
N^S>6lmFK0D:Z6Toi\?;j@D4?V[pIDGjZg`QhSCVJma3@3MBf<LVJM7>09ZkP03^
>N<WPZITUCd4GI5d0F3\q0@9BBG5_;jBKm`:ZK^Kk2YYeeXRb>R0MVT?]FJYI^[X
?U]?h52aVJd`[4R15q\`eI5^mWYWCMD6fV94M`Zmq^ND@fm=q9_U[a?6<cdpDXNV
hjQWmi:g71GMU5ognZF<M?hL672UOINU9EHagDM2NK\4m`>TqGcla>;BQIacK0]I
g1Z:eA[ZdbWgGK=Z]bj4EWAB@gg0FGhO8YG<4EX8SBYo[0aD3mhq:R5NTNmLKMPk
A9:LiN28dJROU4FI5>Q\UoNkLU<RIieHD8eL4lekF2BJdA;E8fC0<P?\nWBS]ogp
n7=@KiiqafdGZJ$
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
