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

`ifdef VCS  // VCS Release 6.0
//`protected
VT#51fF8=Q^/,97.(NVa<G&])#2c,MZT(1LH,=T43bcIAO+&,]4c-c@Q(-+X92=(
^4P#-BJ1Uf\&;;6HTIH?U3D2(O(-4;&3UVb(I8R0cBS[/ESGBY#1&>96;MM<4<N>
65EV,HSYWOT.:Y]^(fL&d([@>B@H6g=G.[J_X&<I@aKJX89L4FPC>,R=]L2@?fD=
_:X)_&(F?dTVBf5K9.JedE51-)1dEQ6A3RV?=Vd<Ub:4S;1YHPMa]IUfUfC,H&CX
72WAAZSYVPM1]V]X35Q<Sd9;TU/.WEG+f6KL_1^>&75@+)9O#=8DFFAL]F?L.1gP
2/\F7FVB0R_&,Kc\1L\Gg:T=8O5;fCF:\-[-@H)MP&VCeTgG-Q#Q^R^fCN,^C(^6
Cd5e-[O?0#7S]&DTE>b92B\]TNT=7:Z-]\-XJ4Q6&7)PcO33QEDIIB@U?gL0Y3<8
f0.gL;GSg\RWg[;YU(_M[A6-E2XY70C@AI3)?KT^8HDJK7Y#@^A):=CS3=WEEeRQ
a/cJE7]-P2#5R)3aG;X;4:NE3K?UVL;5\^@?)VB^0H<1E/3I\B&Qa3??M^G?SCW]
CE^Ef.?RC,g:\4Yg(-a_B)J@,&-a59/[^aJ8IQ3BW[AY^2c2Jda.ScT=0T_>\KZ4
XDXb&g4]Z;?W:f6I>Xbfb9\GVMZN398H(c0e48CJADbCV2_EZY.@4@#FZ?LgIU+?
/C9(;8]XPB<0]#8,U>:/a>[@F#WM[-1-@>A,(a<UKO40SZ5H<>gW=5U^7,Z+K[0W
6#K]7-fS[<V:=/+Hd)I2d8-?S+1.(Vb:=H\[Fa)A=d<H0U-EZ>]7];X1_PSX:7Ia
0(N,:>3]\,[7HY9KfcLIR6<X@1/E4,KM,@0]eBQLc,QER/[a>G?<GN.O7GTD>V\T
)#?B16-ZAMf^G]\J#L764@<4&X;TWD.eP7#K\RYT,YSG)\0-8TR&4NVZ7N-B,2B8
38M<E)L?@^Z=Z3,Sf37&F39@9-J+f,F2CW&0DPS8ORYU)3]I(N.RDN[Vc59ZIK.e
+\>?.2_,5VfCLAIIcOV+c-&=39?]7T/&E+d2\CNHFB1\>DVaBTgZRHZQXQ>6@,2M
fR15ec9<QWa6M\2cQ]]RFGO^3W.Q:N)]a9c53RP/KM7c4D;)[U)8@F7W1K_S@KgB
-(Ge](3bCR]]ONS[VQ6QbQ=\UJZZQ4X[/eGY8MTfO]=3ON/-PYNT\7\EJ,8g1Q=e
#=.H67U_DT^=B#L+K&T,[[&EIOX-E3W_-E+9E7A?X&81PN_^:TV2aPfUe9KWg,(F
DX1B81Y.QAU#CYOWRdg3=L,?+3[(U?C-QfR&G\O]<a=C/-2?OaDfV&RXWbST#[T^
g+22eA=56Fgc0<^J#61:gJ1N]DDH#[Gg_77YcPc0_G;39:(T8M7\V[ad)#+_Q5?S
Qe>EdB.]]WWDBEag]gFQ&KOd_93MB^[0@0e]C2U<CYWIDF[^0<9#Ac:#gDU&PP4[
QN9AP9PI+8/WcBLJ+OT?)?B?/BBWGM9S1gI&/_F#Z2(a&DVBDZ[;a:SJ=19?@CZV
7+(=[f@VPfENKfSA,U59F1Rg^ZH(PCI485U,QWT9VYCH)XQYA8,/(C^HGg9F/,C8
B,Q1S(1>^dMD<MVP>,7^KS>FcK4N0egNbVK5T+B^U7>F,,:_=7TA7;RGJTF)Ia\8
:=,=(BV#KGJWX?#:2;3AXW[E+RA3bOP(CTXNG&f1.aJ,?UKbX8cg_K.[_C7BAI2C
^8@cE-a]&XV26HKFN;<J]_&]UIZX3ZNbSd]DFOU0LcPWB0ab=^6-<M0b<gL-6TIU
gY[Z0<Wa8FOPD)OKIX?4f7>3a(P5LH2<[3e0(W?W9)OfS?LDV:JHAW84?>5]Lb4S
P(VAd.b43,7-9/Q6L#]X>Q[=>-#^5QRa?$
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
[bSUOc[BTPLS<b#/,9Rg(Z.-8DGC(B=g<D+W83YTFQWI+XG+K#C7(&A\(7@J<)RB
271X@HP,c=]S0V3_+U@)HfIc1f+B.PSSc=5?O5IE<eN&&a.Q#\3FM9Z6H80b1,BN
QP2A[2#Ue7>FBNPCTGbO>Ce81AG_bYNA3g-XETK,;>/e#=<^4S2Y3VUR3KDY:882
Z2^(S=9dW3S,]TAgA<9d[N)6W-N73?CFS&Q,5c0[U,c:QT()(,8/YXHXg1W]]2aK
X(<W8DD)_4fLK7O<f22DTY5;--7F6f_7ABa\+U^Z=bZ9Kd^P\#V>5>:WAbDSd8RD
Kf?_G(,?#E1b.\S16WdF811W>QSVI1Y#])DQVNKN<;LA&Y32Y4LTdd+(\R@044@/
Q)^gf]AAQ[UQ(b>.bZF^[dOM>;<Q,J?dR_==4N#TPX-VQ#JMfK]1dA=@+A[UUAF2
W/]WA0^F=b^Y+g>/2T)g0?/F0-3VJ:D,9-(KdeAgPc8G#0DHY5gU>6b8<Jab3Bg#
L^O#A19O>@#X)Uc,gb-c]:6E(:]gONU\N6==(25_T+:[f,a:Q/[(P<eE[P304A(8
RKUC[]@Zg@)]_UKSJ.cCRO#.EN)C@URUbNf.Ra,+\E0?R8N\H_Ua<JJ2cL[Wg-ae
G<YfVE@1PJPVNQe1:#41F4(b8A1(:fFG&,]-g#JX-I1F_2XUYdLJVI]-3[9^=P3T
6EX;Q,)8SI&<^A@XI:^Q3eXN?eIVTB2\]X:a-Z-f1HHRU]F@//=<2O9:f7_YPJP9
:6+8>7Nd9[>4?AFLG&KY^^?7?NA9UFHVE\C?8R)e7ccGCJ41>2[KaQ/26@+cg&KW
IAP<#L&ReYDYA.]KOV+178P@ae.;U@H;Q(R[0NPCRa5I(WWE^F\B&8T7b&&I_G;_
\KE;#>gg(RQSGDD5.L/AZ_0ccR,/M-&9.dV2T&V=+M^fRM7@EUe\N^0b><=CF_g.
.2R979>8PY^f84(-c9F8<UAUV>,+Q>?:1G=^X9]VI/Oc[9LN^a</=:INd,+Z1g<3
P8D-A9]KP28)_V&Na>-a[cdYGGB3M1Qg(c1W:aGTB:][=JaWcE/T=1@>JJgTTe?;
;-,7IQLDQcIP0E1T:)BeCIg)a3OEI1D=_>>5)XQF;N:0f(AH6bN<Qa[2CaL@_/QF
U=F,?P>IEHI?BVGBX7#(#G7<K7GJ;(f(]Z)#:EI=K0^67=B[-TW:<,8bMaa19R:H
:AdO9EFLWZIAO8@&:>SYbU4a/eFUSee^8.Y94=LdOZ5<3g18e]4Dc[+I#\9JDWNH
;UcDFgLHOW=OTC<_/E_b-8-Q?gC^B\bDX(OA\TPVU,-8B/X,\gF/FK/Y^FHg-5_g
,eK2-ggg#D8F[EYM?+-U\>15NTbJ_A9.;4-\]ZXCgTf[-]:(6T3PO>6,HBBae7E-
<14UNH6I<&e5A+_Z4bU+XWR0Q78&3QKSO#4PCFZU##8b^Q&HGMC.g70O3L8:64QX
9Be5aWCP(__,(e?(4bQfBebO6.EPHB#^VM-2Y5>\ee=>:EfF;38MBg<H<9.Q8V7c
L/K9#+^,^+eD2-VYC6)2=[)-A>XUf,GOP5^G^XMO<g,Z9(G<;\O2#C,eIcd.H97Z
(J^dP4[5V>IaU<,BV9/9I.J58+R;GNE&T>c/F0E[=Y7SfQKS@ITI;^d]1(eH+]E^
Mb7A?NIMUScc]8\;37\I[9ZaTgRZ,]OJ91e8;YZBQcL0N69G[0P6Nb6943e^M]OD
#@VH:C5QM#c?-RKCNU)^JW35(9U>NTSD:VKfDIN9>M^_Ud07Ue5I&61SgKYDc1DF
Uc#MD+#T6c_/XE;#BX.,IBP)EceAJ.BgaH<&ISP/MQYY=/Y#&56UFFEKO0\C7+=P
QB#LMD4R&/QT3,XA_V=#B,\T.L1:b504)89D34895#N37f@3Qf>9+f+KKZ,(@Wf3
c?W7PMd91g#2:C/(PU?)7@+,a-?5c,P[U(K?,\9FSRO3Bg?(eFCHg:IdR,3Ie9Fd
K8P4.:I([;e:)[PRN@03)LUUO=e.:Of4L>3D#2M<X)D1G-Y#P+AMbX6YO-E#SW,g
Vd:JBUda6d#D2I3.:NIS/AJ>[2E=GG5)A-/[#ISE:OgL.3_NIeERA1>L^?fa:0(&
;g/#e6eX;7f_Y[+0_D-JR=((d)#231cd(fc8gaaR1UcKQ)FgV7K7Y8NH\O6<^WX@
TE0FUMIfMZ9LTGNZKB]H2XE]5,4cd>KS4@30O4AGH,MI:YE_G1VaGES>CU(e/Z,>
5N+Q&A2J4\DT0#gQHQW(SCfcMF0^V-_gdc1Q?a5b/fe=CS-GMK,P8fCLS+>)d4M0
I+D+2<;AX^2G;3,Q;.]5,,?^0&\CTefB>E&T4FY^07Kaf]8gCX?Cd;QXPAXU2GA_
eDR[)#I>I2S9SYUb<^)7JIgYE#[b(7<aH&QgJQ8Gb:IfG77Sd#2/eH^P8R@4D)^C
^R=B@,=a>(F<S&bAAaS)1@QFA@;QQ_8D2,/,OLVZ9)BW.c.ee,V8^Y7L3YXO011]
BZd\aOJJ<2/3WX>W&+_<_3UNOS\6.E,?R8+=2VQSNZ.<,RALbS1_W,fZGgJKCB_b
=UJ:MTC-g,=I/;+<OVg-U0<CITe[FS[RL9(a@PF_J\^Z6f[b4DXGc;=fc><FCa)A
db79L(AI3ae=+42,EbP(@)#MASV])TH2_GGb745D,KG6<5=N7X-cV8acPZ)\MT+9
6;<1O?)=PD:UE.N(5@,C62HAA?HF<a8]dZ0b]:-8SIF91)gBY+.0QcD)fCNYTBQ&
GI1:25Y<[ITNR5IMW.0^7a6ZPROH?W#U4e+8Z?IVM?-ca1C.28K>Q^e#W7]KHFeM
<PK@^#ITK#ZcNgC5/=;W?L]MQ(Zc=3aWYVANec),VF@Uf<0ae<a5b^MFAC-5:g[M
@O4d2B+^#g:KS]5\RSW/@-)F/aI>_f\N3eBOfY(ZY0KUY\;OTbFLAUCCKb1WgSO]
VE+TL#+P8);K0$
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
BD@Pb?g1E=AC8V<1<A]X)QUg=#&X9<O.=3_2)bFO5[RF^?UP\gdJ9+cM-^_#,XIW
K/HJ7fgZ9H8Ugb\K)R,8LBB)P,<b9QHSe?=g_;1WLP=>I=TOYP/7W+S:.PRA-J3U
;T9\Y;\SFBWYXc4,Fg-KH0Aa3[\)YU2^]Z;5-4YG577SV0L0FNJ]^,e\1L14.Z3O
5;-^9J^-@5Z<2=(DQN0&FKE[J9f>DMH6YP&,EN3._[UMVCga:[[bG[M3CKd-9FL=
9D6B/X<?Z6[_?gV@PYg-4.&A2<>Ka,MBA])&Rc4U)C66.]I(FWCC.fF>]7RLC?5F
9R1IRc2G[F2:+GIEB10MJ2QT0@)-Fd9HXQ@IfG\?a^b1W=ZVBLgQ5O1\JI1ZF>9a
cf@T4/ZXc>#;MU@7:S6MLRQ@SSOZBcAD[/gZO_Gb8fB.RHYOCUO=^DBXfH>)K^7F
&F6K^EFC_Nd4?:>2S]>)Kf=e,3_A27[WO>[[/N#KJUS^&08);aU-DXbT+Ne[#FXc
Ve8_#bQ<:)R)fb<=HJDfKAc1e@G(-d5QCfGOFWfC0Cbe3[M-NbA@22R6gKFdWD(2
gIBEID2KG_:fF(C.=e/#BZ3+_afSG>CI,]?_>BcZ[55IY,ETD;CJAK\LQBD+gH+a
ggRKcA1DdX\EG_8W;8(O/)2W40<_3V&ZKVA;QE;YK?0G4\/IZ_]a2M1P@E3fPV^C
N00SS-LGUC9FGV@^7a83^3]B)8eFc00f<A,5^ZAD/c?F2J<(=C2:7[a,7TF=-g:H
S=G4?WZ,O4f.Pd.]_);,S)VdMcgUA,R@[[242-fUTH9.<F9VIA3(#WSWE+dIM(JM
-9?=X;G5(Uf5ZNU+,5A#G;eFVEFYb6.;THYEI/:4J=VGCVC-f/)#3NIN9A:-8H9K
WI#Tc_fZ[UDBD7XQd8AMg6)&a10,(\Hb8ZQO,EVG;D[NcKL/@8-<+><R.KU7.fTI
O76KJeJDV<JLd_)-^XCJECb_D#4XJZY/=Q?B#<PLeg^U=g@,QDZP:eS+5OMCeGZ?
E?g(0BNBRYe]WPdI4a,G@&A^/)1^1P.&Y#&NbG32dTA(#KE3BdT[(?^VNDb3.d;6
>>FXbc::O;1)3aH/<Q9VY?ZdNNc:=88@>b^TKD&W>GAWF(65SF&,LOYIND>RB4^>
b33:3V)BAeJEF@MEV]S\MHf]6]=D-I03_NJ=10-<-IKJTc/gLEV4=RYS?bQ-(83;
O1G/0-cF2G8#P<\dH#B?/RP2CB:2#EPXJdaN;OA:/-\EYHg8\WTE.d]D&.JcT?V_
V>9aVa@3K0#4A\A7#b-B3M2P6^FY##X9AIOZ42^@O_OaBI;-4beBBR<EMNDP<RHU
JW]JWJ/(f43YZR]:54[7O^6V?SR5@&_Q::E7Zd98>7\Efc-c#AK(UXe#C6DQ-G./
3ABSK?>bJ]7>L_dffV2>.)c4bHX1LB\IJcWgc(40bM2>2?K29>([6LWR3QNb>M[f
ZOBe^#/Z@L1W2<0\)G:-)[.U:D7._XDTM4F3S_/_/N)/e_aQ9ABNbS:&cZEb1-a7
^WJ#)KEJ5IBF1<?3>F]H>N#Q&#;#FgV:N(LW?R;3g8aC)I-dPC=33gEF-W5C.8=2
H3&JCc7]T/KWDc4-<V2cfJDK5D^]=bH/&)\Sg(TA9/0<b<Tc[H)M#SAdZK@-#e-J
1T=Ka6@@G^GCIF]O/R+4OV;V^CY+6c[(f=Q<OSI;aJG6[DP)B1+BJYHXI^e@U.]C
)g:/]0P>)_d@UfYGH#S-:4P&/212O/5Cf#)\9I_O,[)<-=W(eYDT:_DN9&bQM^1-
TC-1_PU-:.GAV1:AgJG?@e[U,FF6V;N9:a?DFY=+L[J;)>0TDF\P+K1F5eZ2YEJ6
:A=-bb(/0RJ-L)@V9E/F7PCef0<0@8T2)Kb_=13XEB=;5e&f9UbYJL\?:SVZSDb@
:0JZ9M]7/Bg,J5EF5c\]8N:Zf#<3&;D_FfS?OI?@YaBKKVV1b=P9&fH:Lfa11c/O
?a9LI^;.PA<X[F&@d;JI?fb,YWQ&@RY,:(N-L:#fG@V&6KG;U6ebDOOecb3&L,T(
S>2UX0(=9^7/?+EF&5c//PXC]EBDNW255;CfccCK^9aD(MA#ge1\]_])\G)ZQO?C
>E]UfPPb8K9MSg>8=7&dXFc4Wb[--#J1.;Oc:3cWK?K+W7-G(e8VJS1AC\T,?NQ<
)6VU?]P?VTLK^^H6HF/46LA5OY9-S83X+AB9@(0=.^QY\4XEA3]T>BT+^MggcDU7
;BcB^)8&3ILH2(bXZgMI22;?J7OIU;>5V95FZ+8L]FF7g;,A1S4DOT[1L8B(K4C_
63R>(>LVEQ4L2HR2+aDW_[2YTCM^KI&8cIH:)F[@HdeS1__^Y0M9_8]XfTe<904:
US8-99557FE=5J8\4cOTLJ^^F;E>e0:?2b#[P;SA_/:JJ&+<AZBD9RM)Z[@G4eI5
DC[&gSORX:R:RE]NeSEeUHJX&.WN;ZK6FG@C76(7A@SXQK<VJZEge:?-BT+E(CMA
LWY5SE)([BQdaeQ7T\3SYI./8aN6G:LJ1QdgJIZ]HRH2UWVELC_S/a6a&@.^H;5;
HBR;D/E,L,G^fg;Q_5CTFJ[1CegfUAUbH:S<=M80LR/AUW^+abN5[QdK?,Zfd#7L
bW6?FTYI/H(Z<YT(c\Qb-8a(NM\;KNZ&34T(M/^<Md\7,&<F2FUT>0PSgAgG-F.b
?R2dXG?P)][=3=aO,3R5&\/0]aC_>N=]Z9ANg_=0EQfS;==#R^;=1,,b9O>RGJ?4
Z_f/+C]a>3MXXXb)].I9##5K[RJ]-\M:6D@b3KIdU9:_4>J5LCIAeBT_^DI1Z>I]
)^Q,K?-9fEg+64<f0+J8LBFg(_Kf)]3>1DF-.-@<f3-BZM;T2[^37Oc<<Df,6=ZH
UDS<<ZF\d:SO,?:M)&?,4#\A[)I;]+@ETF1A9(gAJJfE@4]\)+U=-RU?b@1P-]6R
=W(2,L2HC5,&FKOd?Gb75#2<43gC:XED0@d,G4eYba9@ZZ,<Xd0E>;?.4^4Hd#H1
1O66MTY?>M\J?:5TT07SaRTPR/RI/#LJ(4UBDf=1NcDRV8O+9b2G@X,fSZQcTYVb
/@>.a1bcdPTgc+,CDG<L2g92#QYfNCFWZ0(IDA2J-VK^gc>;^,&;I[OJILD57<6U
-U<UP__@RbIeUAcW(IXM:>ZF0(L9DLNbQ?:e,^C+7XbU2)b]>AEO_WE/d/2]&&&H
)a3g)e;RY_&:WN<X@H2PI[dRZF.<:Y7?M&H3P?=JKbY^aRZ7/SSBHBB9CTB(<HL6
&a^@]cP,8/#C9^>VY5D@^4:\^T4PLVICZ@2X]H3b5&;O);U,b\1X#B-@/93,AT:b
2]8A^OQDd/,GBZ>\0?:;;FT&Ae312[-N(R,#Y-U0L3^#Z7fY4OR5)H7SddS=;SB&
9,BfQ?P&\@?A4J8_OM1Ad?D^?/(4e@#Pe<\89O0&a3B,9T^aJH,XJ#db&-2KCRe[
W3Tbd&^HJSV5Pg>;BT<#=7DL((19RXZ)g7EX.73YI;>@##0T,\L/IBCURBd5/(9=
2PgTdJ@[-WF9E;<;C?>R)_QY9[DJQ-\d?;6dQa,7/W6gU]@U5gXG3fTX3LL]Rd5?
81Pg/TU.?=dX7H3dJT&LX&5Vdb/(SG8KH^(EUDdM/?IV2HPB(D^Jc7VfDaE67_@D
>6ZQ(T8PR.B:/,(fE,52(#H-<:_?8=OCRM[Rg[=B>69ac1W52N>?()\HWA<73ZCP
e@7[&6eUf[GIg50&+7\#B_/d0#H&CV6X6@)\<>1@5\c<X]]R<N,8dOTC-?\\+51V
0f5gLHN@Q#M_,AJWUAf=gg-d)Kd=@BW?=dgTXUbNaCQ/9>2cG]K(0-Ib]e6;6HR\
=H7aDGG2K@BZQ_A7C4B0F/M24:PXKA8b<a\^C<C/;U?TeKE9L9.20L8.D0_Y+.MM
=A4V/_/cA+Ab5KU9-TKQZA4dQLIUZ:I3Pf#O[bdaaO5.\CZ31/WPWKJ+SK1NG6HJ
:BFN@W1g5E;:[^0PFG-MH7D(LS4gF>:DSH5Yg^54CX9Y#6cSW>cY@&T78Y\YN5,J
ILg>>FaSPGbMAddV8)X8I<VOW:3f-JfUTMK3XWTVACUR[OVR:=0E9O6IDc9PP;2C
OI&+?@.fG&,;3;ZZ&=PgS^<fDZN3TX\D,2UdgB^gCN<Z=G[-OFIRT@1YJ=(0U2-T
OOIN)9/4DdSVMZ;IYU<RF?b)KNd3M_PDbg2V8GZ-FRS?72EbDI(+FSNM+^3E/gVV
:N@7S\HDJS_?:@f=H-Y=fbcdK=dbAO0J6((PQ:=X[.B\Ye:VfD.f=0Q2^G^AY2I2
[@(VNI017e0g\bZ)aeT+I\N&UXY#,a-8&TP,TB[OZ=ERE3P)Z(R1c=L+K=U.YdE\
ADV?Q[RXYTRU4b@OU/#5;32+E-@;K@H6),B;Z=2>a+<^AU0)IY^6G:K#P(@3fe70
3GN5:>L@]<_YN,2&CJ(?]TLdffeTO-ZC)]KZMQ^/GeXWNG=b;2b9b.:e;ZYP-+gd
NPG_[WZXb0EDWc0O.[-VK&<IC2GdE8WCJ5_1c2]Y\NF<=fDM(?fO;d_b].A\e)(8
K4T=aaG].D4+=.KFN&#;8&GPS+WPF)_QE9QaZ,CI&/L4&7Tc2,80#LI<&JeN?<5a
Y?>)PK+D8(:FTXAMQ<U:I1KdJ8KODgX4H\..>LIGgd\ZA9F4C;MV]bYK\SYEQP+Q
)I742PDV/^g[0;]^]<_\;;=OGB.+5N>HY;0JM#R^C@9I0-a]3TY,3ZOW=670#:;.
BF#L>34XRH9FD);e8J0BMU=#9BeN<=7@7^gB:T6)^D[IHS;9MbO@aV>6+DI.,RX[
YSC)aEc)X51L#<>GK9_4D)Mb(]2?\,NY(#BI4G47Rg2(g=-NYYeCK5dYe2,@E\][
_B&_9L>]B[WbGAW]BQEICH24,;Y<.NH,:#PUV._&TJ\c.9S^QS#Vd(\;<P,N)ZY<
@U)ePMY.[J/cIN,[UJODf]36>47XeaZJ&86P+2;5Pe?DXNXGBfLV;TK;#]J6,0fY
)WfD#Q8QV#_?-J&Cc/484B97a\0:^^<&7<_e[9LMNU8G=72)T1T[D2>M4\^.6T/E
THJ_]T_3;^S^GAcBKITA3e8.YAA;BN+._DPKP@G?Z1cV/1;cQ0U8:NKf61F6dbTM
(H/L.J6,Xc/^CV9<9NgXg:IabJ=32gcIb=A>(,7W3<7:fJ-=1_bU[E[:)0b;_&M3
CI(IGA=>Tcg2g1-6U6O(&XV\1OVIJX??0N/Bf7I6;4T;T1T7Y3CJa..Oc5-LD5Z)
=YY7\=C)Q#FN2B;ZCOJ)?=,QR0OcP:K<6(#6:-,/0ZKTHSa;<OB,YICCZ9OS&:/@
@ad,_:GPMJ)?8?D\XH@\2f8GN@/B74K&_N4/Aa)XWSSYO&3dEY<-GE&a\JB[,RW;
IP4OG>YP#8=A5SS,EYU-@)R4b)c0=MIE7g73S(F6-f_gEZYAb/NP-dIP2RTd;bMO
MaWNU>RU,(I_Y]/L:MTaPJY.S<MS)SR:8A#)]M#Z?+@1CO:e[db<7QEL;R:L[TU2
_20&RR#/SGbL,I,2IZgUEeO<I&<Q>d<G+><a4>Z6G[@(=\6^/XEN\?ZMfS@Mf)DP
039-K4[DDc;9c1<S^:(gNKH;CH+J6Vc4.ZSM^WN^F.99EL1[H5I1RO[\Vab//+H9
C1a,bME+ML&#<3IDA3Af_e6bW(YU+Q0Kb;F]TI+MFQG281@<0-NZHLg=8T0NP:TS
(DY.SaVYDZT:4(^eBZKN5L1:I8Ma1&AZ#3,a:TI=;6dQ638e=Q_HC7^V2S)02g_9
E6(dUG=O1<6LG4Vb9575+=[@)e__42++-Y/EB[&]1-]JbZaHB69H&GRE3QN;/GS6
,U\T1eHH1ZJA/a(4<aUa:I4FX6KNBQD8W,J+S/C/E3A4,OX1]F[:-O]9KU3BFKFD
cS8RZ94RTgP5-Kb/0CRB.@YP(47YbMX36A-B.fL(Z3VYdU4H(a9UgA</IfS^#(WC
//[RP.fF)D:WSFd^PTT0[=;TIg^Kf1T//ffLIKLIEb^>c8=\]HRQ.(#,Y[:6VJ^2
gJBFJ_+9;cdR:II5R\4^Ab]SS^O/IYLL[F7X<\a\IJc?]bQT1;83gWAV?8WG&4N7
)U[?)FO0Ie;f=+U6/8OQ4SYWD\D-+N=EF<FQT-Q\XXbH:5e07>Z0>+e_-E2Nd3<?
BPdK>HD:/T7ZS_G->gFC]JXTHHf]K.SO/d?8/\D&7R[_&MDC3:V03>>H^]G2KEBQ
&#?OHDK5<0(2,N]LV>=G2=D<\K;/4SVQ@gZ?TKTHIJ4\-I1?<JAU8U[(4eg=LO:T
9:1^;AQEBYZ_Ba-VRaU7)?e9MccCQO4Q&-8^]LX5#f9Md>gacA+:gJJ<?-ILN)T9
MR\-1Z0.+-N0G[;IA@HQIHJ)=\)d[I12aO8:9f(IRY/gfH_3;+K)V3N#_\==e[A7
^J747BDBQF+:4dX+F]-9TY>-4T_FKE2/M=Re0<)MZYJ>^>9^BUQ)/.>GWTG-E:2T
U1=Vf:?_0JT7\+DgBGYT2>)(#&2=KJ8(1_O_TJJL--D+bTcAOCZ-@D7g6e-D7+U?
ef)_+1E389Z/#C-=MM-J45>[[+1W227BN7:(CB]M5#0(c.I5)25XATON&#Qfd@KJ
6a@=R20Yce#e,:cCQ4.dDdeVGbK>\S422Q=WKb+PR:>8AQV0a.]SN@B=<Tg;V-<f
g9/@BU\2(BA[A/P.]GAVg8ILTWO\A4KJX+b<U3+)5?W\_OBUbc@-dPQT.,dg24/D
VQJQ:CGV.95;Ef\&c2#-ZYa],X_Vd?N8QWDX/?/A,e-/gXOL]f\8TBU?/6(Xb9V@
#f2P57ad8JLZ<IU5.2f+E0_ES<L9f[eU#JKgJc0V,_S8/:^TGJ@=KQX+ecC#UH:.
A],(^M,=\IK^1c^g&)/.];L?.TI&V_1=dfX[DeeN/O;Z@d&8gSNH]Aa2ee3]X4KK
c;330)DFH:KY</Z@1BHU.254[TL[NaZ5ad+/g1R5L1f5[><<e[eC=Ka2I$
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
9QY@f.L68#.<-;3U(IE8(DLC9>TH-.c<=(6<=A]><UGJQe]7D&?78XL-9UbJ,;WB
]A-1R\GO0d4T#1GU,#]T#N>M.9]N7-I1Ug6JC(15eW9C#>38KZY>:4g2ZdM)&aYL
)VX#[ee--d.6T)SUTI?Y]:YHB2gb6bQ8;HV4)R)64?c+>E,bf2U58cYfH\#<P^Tf
EE?W^bXA)8_@fK72/83=3Lb=b5eQHLcMFJ<^4Q,^)4=^gaF;Y1T&Y5RXU5_T[[^S
^[dbLKKX0K1I=_.M<^edXa-1.feF[K&C+0>XT2F3d(I2+4M<\W=4IQgZe<59#XM@
19P3@K@AN&@AI6RYHQ9X,cH?3b2)XVH#8K:#6HX(?EdXB)B04P0#E-H:ZG>1&^Wb
75&)N+HNIO^[Y&VM?6QCGQ2HC+^<.?9YYKMF[V6PdFd+fXX_/?YXN2=\C\NP3YIW
[dcEfPY:E))(=[\/(HRVKQQ2Vb(JGG,D]XYC4.>1T,6EJLG3/9RSM2@96N>R)=3T
f@:Yd[fWcCCI]#\EV6ZP#J)HX_\Z?/WJLQ10?H.LHKIN>:CNCOH95fJ8@JQA_72S
L\MS6S;GK42UWdE/L@O^E-.8^J)5ePPL)ZY0bPKB_7b-YfD->;Q9U3EX\US=g-DE
6NIf][H4JIcJ<Mb?NU^)P,8XcV(7EfYV3+OZa<dfI@?3;_OeQdOef\K147TJ&+K[
Ja+A5gC-/NOE>]SMeRcB>eFE6HBRRQNJ31CYN?a-98cY8IGHE-+g3DHL?U4K)YZ+
B.([XYeQHVLX);GYIfeMIRd(f;2(=>3NFTDVG]d[F@b(T>_^g7^]g4T+F[-3HYD7
?cUe57#/QC,]@(,aaO_Web](Ic?3JI\<a0\O^4dX]^XB-eZMPVE]QPO#b]&XWE)W
M3?3=A(J&H0T[7+GKBZ8QbBWU&M;J8:WAd-2JPK9=,G)WZ?b,bJa5>4g/cb+CCf2
,,[G6_LL[-Z97\ZQ\b)EM2JRD/1>T?0QF?KOA[IO>9L@Q)DXM2eO=#[ZDH&WcPc:
Te0TMG8\7E^J]2f=LU4g^-\/>I#.]0gMB[M-8>Jcd<6\[N4)S[9EfZ&4#cCX[RM>
4P#Eec^]PG?b8]?9T)e[>:WGcY4a.FGCLYDfL-7Fga04E67E7@Y^/8)6SNeOJ/0Y
Hd2e0R3?Z:+aFc@?BNe>TdG-DO7IU?:#PO/<@,7S+UXf65YP-CLB_e9NZ[;\b6A;
:Da-><NB/7_##c?_-f#JeHMXf(dB);EA<VU>Z\0<],;SbEV,TD\]RT[7Rbe]cT)J
f<1LE_;:J2R@Q_3\-]fV6KK:]C2eUBAOU0R+YZJ&4e9)Ag&0(M1^^7aW\F,E^2c6
1UP]-d&L^DO=W3Wd6^a,+YQIBWAF+YYG@,bg^7aWW69Md?6DZ+f^N+K2@)=O\-D4
1J\;d.fbQ[Ff&3<L3U82=ZM+CNJf-a\T24+VY5:G<Y.W+VV8^\8V#/N1d]H[8U7O
^=))<]/\(D\OH^-5OZ6R>WS=&&aJ23#YY)U3Q)_EPGEeC@92OGMF)MAQgEQ:=.6<
bDK>)GRSI4IR&F1QVP(-#b?M7W=Ca/TCM4Z\PQH<0#U4R^V;cDQK^<gR;cC62Sc>
5[MfV1NO=X&)&5--4J\?CHX2a-0H=(cE.b6^5f8;XbV7USQagB/P\#ZUSPG[TU5<
Y=:;^WTeI5LT#G:+XJ[TPKB.]YcW:>5+P=;O:?LQEOAaNH3&U;=V,PY8GF)0U\aZ
^W3S7_Ua/G)+=Q?F:TNf-]5_)L+C8.4)6&KUW,K<\?9Yc9V6La?)([AL?P(UDE=F
VKOUJU2eZ(S>QcUF6NffR=8K/0NT^B;.,_Y^+^9O)_Y624gAcJ8ZG+4I1dK2TQ5W
@\/GG#7F#DX;L;@1U<VIJ?VDIZHJ7OfZZKJSXU[4\>C1UASK<DGdIAM3P6-cV[9E
cX)aLIg6(75TBP^?E.V2Z+/X:=U;_I58&;2(@(\Xf7A?C>Y=2L5FS.Q,3#;25g\B
_4;BIZ2f#PSJ-A3/UE]P/115T>7Q^IbS5e81DWE/=/77Y;4--cIB])d41J4d9(MW
#;ELQZG_DI1&I/.E0SMK&EDEL7d/60>3c:.6bC)UfV=OC(_4?RA0U_+UU@/Xd:)C
aPdSFDW-L#=C)PUVBIQ=+;.DbA[@Q299bQV7EV-B)5T4^91a)OEB[#K]T_SK6Q92
+e3<@cV<eB3DG&<#EY6;HA?-,aVRLRSSTK,E9<[LOb;L-d\aF</:PO)c.L#WfSAT
CP^f(Z0-,&@5LN7EL>U:/aTILBH6VT?WZa#d5[8+,JP:;bT(0a9ODCZdEI<=J>1/
EUIE\KY=QgZ37D8gWT,OcdAAQ7(&b7N-,./LV[6D97B2N/2bFY.X4?V4M@]^BK&9
/P2@H@+V6^L=)aSPc2M&H[>_#;CDeR7XcY/YECS,b]Y1:WY]Ia0?.<7\7PdGg8@H
#YT))3^^Ff]?aB&CI/..K4H=2Ga1T+P8X1Z[\)_@T-YcAKYS72ABSbS3)C/YC1bd
1c2ZQCQKSIHMA,/<\EFT7[g9LPeETeN,adME]1TeE8#/^AC2SK&3P^0K9A64^T+?
,6GU+f=<f3f>b.:H^Z+&MB^bQ+@,GSN1+DaWe-0DcH1a=fZJ,fH#L,B+X56+_\:I
CQ5[MSN?_PaV<(O>,7V?VA2#EF@/)]^e,Y^[42Kd0cLBGFHEGXKA/<?HBNTA]UWH
;JR@+K4If;_V/^dL:1,=M;]XRE_I-?M@.9UO-67Y)+CKBWLTFL/6NZ](?&AVD\F;
ZC8?GdQ5R>54J9)MYI]e8aGScf2>>]#X?@B0,?7QH,L#;\d.>B-b:&OUH3Z^aA6@
Q58#D9,4FJQC+BaPIZWSW)#VFCV^GDV22;<fa#cV5HONOeaTT0R)dg44#0cK462R
d7A3I@(=UJ#FcSH)LH(Tg>L-J]B[R3/]_M[S0+:Pb#(4P@Wb\=9248KR/IW>bG;_
;-EALOS?GB68Rd9C3PgH6#X:Y2CIc7C]a<EC?J):Q@ATFO[:g^g<a4-V8IG.g8)B
GPE+_0S[P4KAPLWB0;G^UGH[T^2b5L.fdE;>XefB1<8M7G1g.b@M.<(aRf2a-?8\
KMF(+7EcOJX.55]VXca3f[M?XEX;9=YV/?Icgg>JSaSCS[6X</WI.5(aP$
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
bAbAZ+^R@(+/=cQg=?3+9Dd?,J@A-<e3-/^2)_^J0f8NUA7)M83,9d1T,S-g=F51
._4aRTOX9f[EI/\0g/J,O9,IgQMG=?@T/466],)8d+)M.EQO^-a^2UV,4,^TB#B]
Y<UJ<CZ^GYFGLP1K:(WC0;F^5M)C+8OQ5L2S?Y<.@(O,MBR#@J_<gR\dZHEN6B-Z
3H[+bUV8c3a^aTW#37L8C28A3WUeS5c/I=4OG5G)&2J7Cb/39:OG)1H61=#OLWQ4
f=\McN(dVWRH7,)Xf/[F7L9.G=ZEPI2,DCJP8^OI_f[BTRX/OZQ_;?La\RC@a0VX
#_]O?N6dV5>JC6;\9(AYUWW^D6<M;+^BAGeIKaMeSY_(cQ]g9\5;aeEQ+YPa?,+_
&GQ-+]_,b8H?KgAWaa7ae:5](DX-HQ^@dbZOgNYZA77E(<XWL,#B]CFO-(B:HAS0
//?L1UMda1?:Ha]VEff_af8gFDb4[18aY2E\?B1#2@C&(WLd:b^>2J&1<2Pe,#&N
6>BJV^M?6[.H\?:K?3IH2ZNL_O-I^V/GbbN5XHB3(S157bEKN\<(R;>P-4bg2U=,
MK(XQbUKM-73)Ta.6XFgf&G#3dOY3cLfD>C_UYDK6g3-9+A-5,8?QGJX9SH]-a-F
>C4e\U7f<;?>[ZL=W_BENL^_GI7&)C9agMM=VZUNJ/INRN:,Gd]#<H]1M)JeCN7#
b,,Ma:SH7UP325]AMU/9:O5bGE[8>554&,U;P_DN_ASBMB<HEaD:>:#[^Q?c[FI-
3fOe&=a)VL\D22#N(;EH1U9)gE?5,TbZTbce)JYTY-6Jc?I2V6)3]K0E,UaG^8X8
e;VLZNSAZL3<B;If<WY-f[3.@YUe>6U/L4(bZ3;96/>+I2^Z#-IB<3C2BYZ1bS1]
C_V7I(CX#&b;Rfc[K6#4dd^Z^+@8A9#N104f3OI&^GTZ2EGLg]XUT>R0+,8/.\cF
[Sb1(eA8\XRcZDADcT\+Hg2A-gJKB<ZUcF+(Q>=NTD\ZG[13[\PdX__^M?;WE/>V
AK:2\Rbc5R6=ZT):VA10?GKZS+eY?<IMWI-;7B9D)0),f:LI<A\Z&G?bLZ->)O4b
,GY_BLaaUJXZ]bHEI&d/:M:W;@eWC,:F&7gdW(>X,cNbgL.4_AbH-fO])8dZ8c\Y
<W9:R6e6GW:Q2Z9K,b)X&JMAHZ2BRH=BMc2[I[7fG;J1GBP&Ng6DRZf&2>]Q?&Eg
P_8G&.-5<^?G.X5;+8H)SO,eJb84e4@5NebHG_TZ&dRUbG]IBI4^K0>^aRPS_f_H
c,3G2KHH3JJ>YEHOZ.DgKJf?:F>)NX=9?=4NRb=9?T6W5+b_7bPX^,23HNa(.656
,@cJ?DG-4[Q,UL2&:SeF97\M&.Sc@O4-?0e^HgWG6R^E0YKV>J0GNd>LC,P3AJY;
P;CXBe-3eHXQ.ZcX(?J2O=8<0WHa3DC>Pb?IY7RRN&/R72/<AZ-#0Qeb.JNQH:e)
.a+FVT@<J^8;@cB@@[6=7,#-50fC&Ob:H[N9Q_FC<?.c?HFIeS8dY>+R,c>Od8?H
\<gUPYD50,X+U4;O5_6=05HUIH>ILb>;S^g>VaAT-dP^-5-;Z,\bdScg&WZ>P<NK
g8#^^?D?\4#KNeGQ)&46f>6gLV,XCb1ER4?8GXRW+I87)BF::(,6J&@,b8B]KQCR
UHMI<;4TgQD78HLQ9ga.RV_fg7U]G@>VG7Yg1@M4PNWcLY]L)/S0PY7Q=H@+PG6#
,.V]@I#P4AYedbJ/[ab[=e/5Je\BRDP9KbV8D366dNJ/?&<aNc<Z?M.GF[dA,_CH
>gXW#F@^MP.U22Y#0B7\S-@0CXWU3f_)59,2,aT0D#?57Z2bUFVJ,+DEfFFc9OQ]
e0M;C82D0=f,6+gK3D,:TZP\H@[()E+?94&,6C(=U&BeJGgT7e@dNf;@=((Vb(.:
CC7Q:&L[IPM)O-aFA.G)Ed&53V>Q2aYMG^&LeIAP^ADEK3G&H?G6S;D_&7ZI-SJf
KS1BJ#aOM3/AEV,>:YMO9,L-NC]T[.Jff>M#YIW:(5LRS(K>(7EbP/@e;+Q7#RKb
Ka@GFY6aZe6.>2b&U[\LD^d<J_e0EZ+^6fC/H1NT&LaL@VJR@^g5cL)_;M>=]d<G
5A_HK=f9;9PcaQ89cZE=cO;c/+0K\-]]/LG[]93UNcX7D-ACgaALY=P7@:4g+<WU
ELfDNg^OSUDV9;PM?E(6,3VIR@a:+bQP(7GHf51C=WANI_NP:#,W>NB\HJQ-_X;3
#8;>T;;8ca2PDFBI[8&25Q-8-Ua#S1<>6eV[5#?JO<a1KUGg/&\(a\O^29(f)>(K
@f#\W,\c?:Q<Z:TJM:HN,\aP[2+_T^QE9-b5GSO-d^HbfgE_=6VA>R;YQX2Z0#?g
5N-1d83+5=W)V>Q3?MP&HS/cTb\We77ddRCJ7+NMLfb?))IU_V)D&,#]@,4O2d.?
_c-@@;[XaK-&Z,9IN+&0DH\A+G1U4E/_?Q8#Cgf@[B(IK:H5K;Y=M/863D(d_7,/
.9/e4KBb0/DOLc,1aX#-CG[b>OCD(=,cg_C2;^0a->M@G5XDI74VSOOD4QMbIVAR
4)8)RM#<RXJWJ9@H]a]^Z+);NWB_,9^^O&XaS6I/WM(40aA,V.K<=7NZ,T(OU:eE
17^/M#@QLaI8=J;d8ZGe@RZBOFLT9f^26MX?L]I>?^\P5PGF#8TFZ4CUC76)GW<#
H_KW#1TCWB0]5Y/-D\RR;3VA4OBI9\g&G6O?,VHeHH7+c_Q7OYUJG?J79f01>5d<
Ia]#b;Hf:.#_#6+\UC#;+(8D=3Yc?@WTX].MJUT2T90(1S)F8.ZG6?4Q#SN\+[=H
26M,<EF]<A6[+ga66]c5:B;()&3)61KTT4XGF<]e6<F1W-U.<1WS1-HHY?L,<_T3
DD?3R4#D)665QC-P_7C_9R-5I3K5EH<U./Pa/S.X1P[\Vb_BDR<#fPK/Z_8]/eEe
L<+G#[LH6;[TIc.VH48N(/O\V@M2Z34J4+?F@6,/FL::eY[D;?-R\=CRXB=T2&@]
RY9NJ&K+/2?Y)2e7;[6[4S@GXQ8E9DC_Ye/d[)FDc?\#(f=B?\e)+.dEJ0(;T&^Y
;X(;D#WERG?a#60@_7_#.UCTA9C\V35K,L,TFQ6G<DOR]H#Y7/BO/)g::/fYePUc
UaLR,D7@&ZXK)EC-])1M08@5?g^E_gTY_b<A1F_3//M_FTMC2L7IM<;>V4E_U8EY
NUII>\]aSTX?e?QKBUgeA_#Z]g)gfGYf<;.=aTQ:BN:8cYQLVW>VW.XG]=A-PXD6
ZXeHBb);R07fN9BXN:&&>2aA?F7(<X60X:a;[dVW:D^\Ja0<(^_@Jc?BZ@K^AJ^d
?bPU+74^g/;U::/\2^)SOQK[XNX])HTC=([_Wb@KG3EE=70FdbE2FVPg=DM;;fOc
O=[5SbW[ecWQcR)Rd;;ZOU_eH@N.fc554G_9QM\8M#&6XNYdIH6^RPD&\-@E(9b[
//7[99K5UP5b-4:/?W7DI75;gQJccZ1[JGV]<3OM/,H:P3CDT\A0dOR8<7^4-HQ8
&D)Y@E/=8I:,CO]L<AVPc;RNQg;QH+cVO9Y[QYcGON[W<Y]6#-=/TSK&_T&SX?;f
)P[,RZ+/f3Fb(5MS+-;RVB/cKPI/XW9_M_baR2fS0E,JNd+9\DUZ+,L27Dg5g2X1
Be@7^BO.K3K-WRK(?=QS#N67WIYPKec3\K+K9ed^=KDdg1SQJJ7T;Ue>^X7cKWFL
OfENYJM+6@LH]779-BQ?6Y;H,A.1<6W_]=IVS9,OI^GQb<-PCNHE:e#V]\8GO5#E
=G+YP[;6W^3N6,\([+CH(Yg[EH?5f1QG])3FNTR.J4JE@;VD@^-eQ+4KQ0.WGHZ(
K2]NCWHg5f>Ib16ab><;V;Z-8EA?,LE1K^FfL.E/_96[Z@?dfH1NJ.<6-G6)Sc0^
X@/2YLSL1f@d:<cTFA>(P?L#7]]AMe>S83>If[B4b?]PZ9^AU+)C2^2?IQQA2@RF
WKM0KOd[Q1WC(Q#/IK7VB,a?OQV,f]AcD7<8W=361(Ub,CYY/_>e6N#?;(,65CH@
P5EZ+TEV75]P4G?B:CSMP_:)>gc[:DeL@7BAAI^GAc;V^_15QXDN6KKbU@_,)&;5
]BO1+L5c2_GTWAe5F9_&Z(5:c\9S<Wb;&\.BgROe4I=g?,>?;29/P.U.:^acL]E=
bD#dPd+WTbKSgN);MCO169fO<gCeMg-<3gC_b,0+6bHVc-Y=eS#fN4NT]75MJ0c7
g5S&CUG\fP(7?DF9J:ZeAMC/BE&R+UfU9O,.Y820@<4:0KcSAG.QM8Z(R/>0SZXE
Md6,H^9/2TVHda?Fb66]<WN@6/Y_.EC=57)VXcSB;[F0UeWA9)N6>T6X@EcP=(1E
^G[@>^#8#8BabAbB3]FY[b//HB/.T-TCXS+4O<61<\adXb377:UU(c\[G9[1Xg@c
12aGT:1YGQfA,UOGQd=e9I1,Vd)_M/L?YB4?N#g#.8\aZ+K1.a[J[[7(,#c<HHfS
J935N=g+Q1:/[(+(?GRHY&:S2de,404,>GEC>6Gf(U3,T.UZUPYRAO+OaX7f@.?c
X0Y+R=/c=Ja[+b0ffA>82>KC:E<<2<:M84I?D1g[LETA0O7Igf[/@Z>B;dPdB/O9
#Sg3<+I?E^D5FFY9d^E6KCE>3.g:\(XUf.)c#F64\QY6bJ#J]MR7[eD:NR?HU_.2
c[D]>3d/gd3ab=W,0QZ(=2DN9\G#<_UINKIX62]RcaHF#aRTP>SG@B+?(7J>Z\].
e;N48b3-=gb5T;149K7X.99<(7He??Q?:KQ?gXSB+^9NfX<DZ75)ZS:f]Va;7K2.
--4]F=1C#Z;LS.ZQ#;b0YgRZB;@NC1a_O1gW&>V]<P)#GcF@2>K9Q)FP1QC\?O6<
/#771.=5OI>b@gXQ\(3#=,^9,2F6WU@9H(b;?854.@L-G)<,KP0CUb[gfNL&8X^H
GVS^a@5Jd#JU/IL5#-6PdI@8[F<VDNF]8LbWM)R#(d&Z^&IU\3(T#E#=;aAC<Q]]
ZZW^L9L[,HTD-QU(27_GTaA6X^HF,[Mga+0@F/ZJc;cA<2C^dU<8cecA;,S(UdYd
c4FPGNG2&6Cd94<TP0#4I<[@eLf3>)C2ESEF/.@a\^(;[)@fS>)DcB_W>C>E,,Wg
93>2KY>#\PI)LZ=JDIa@O##ZJA:MI5/8^Oa]JKR[.^=>:\<(fJ5DG3R1e_WB1)g#
c>5&^E+P9=DJ+4RdY0+cW.cc@_e1M4d:E;Bd7/TVK4ag6YO+7)+3+&c9WfU818NI
(4ZX7++I+P(5U4O&N(D^eJ94a3a>&cgD,PT8.H,Ve5RKO?HgNF9#Z^c1dNSdQagc
:27:,)_MDT]b43<ge37M5f,S@V7CA,9L2,E^g<7:e;S361PY2@T&W5_#,Mf[KAZ(
DK<WR(0JH2RR>eLf>ZR@2T1:NP=4B.0++;9QW>M91P>cfdW6U><43UeT2H(J6:.3
G/:1Gc_SKBBKfT,UZ-+]I2GcB\(;bAE],30UbSYA@<0O&f/e.IF5\fT-DF&&fLIB
Oa_)aRN4+EA]&>FSB>?MT2BAI.EJ+RQE\c\^L=LI:8cOgJgeFM@LN&<2U(c?P?W\
f(-<SF?9(19[P[R(Oad-bD]8)Ic\^>]Wa=82c.4/[5><F5,&\5]NPRBg-.;)@fG4
5dF>[X)]YD.B@M5C_1=D^KHB3@&eUVb/DW0[K<GP,R\-DM9@GKYcG9A)BQ4(6QPU
+@bM/^FOA@]cS4.QcUU^,P<a_b++53F2K71Tff-_57]Z)A0dZPc&A0@OW9RPZD69
8E=.4dPJfJO6M1@>W+-JCI+TdQOO@C3/?&)M>)0#6NBGXZN3+(cOX6^U_[\f:;UN
;K_Z9[Kg;CZ0CeY/?QbCf</?b&TJ@+5+_IcL32(@2#&cP>@<PFZ5],C#;D<5W>II
cV2O]3X@R06ISF8NJc-#g[D8P\/EHF4Z=HUM.,c>FA7e9ddLVWbR3HdBYE)_B4PC
-XMD;KRKa<O;L)SG]&-Y1R/3[F9846<&2]Y5ZLXGKH97f&)9^[:0F;9:H^XN&Sb5
a<O=O6IRL\>ZT+U=TF6RcBYJH#RMBJRJWH@OQcL&=SC8=^a\S;[Q?XW#)DfdC6/4
PZ3A3KCRX.94;6bZIT,Ic8[/d#5W?Xd@88.<RCA8<6FSVD.V++[G]?3L<<;]O[X>
&\OJM]FEd&dCc\B-BO0@FD2-_a,O1VHV-;#\YJ=629e35XEBHCM19g(UR63.f8V+
fZb(#HU,SEPI,E5b4^Ce;L+AE(&NJR0D2G=a2](959E>=?caPd\b<F9:-KI;1^+:
B,WE(JTE8Z21CIKZF11<2gM5@T\0MCNO#8Nc1H0ZeM5#Ic3-[;THUG0QTNI9_-(L
7.P+e^MUU)9][-LL65U/=VW[BY0F)bRP;dd^H^c4]\a(<W3XJcXK?4)4e,K\SCS1
A(e/IL0S<OE3XVZNM\V\RL#J[J.95W7F>bYX;QX(OGT0:U8g;2<H+=638Y?XJcJ\
8\L+VIgBM>@]Z#L#:GG8L]L+c^a?EU\Eb:PWZNMD+@N7Q>VZJ>A[)G.R)(SI)L6^
^UgD^I[0KUcNA4WU;X,1S-PVL;Q+4:8EXRTbIa9-U)0&@&1/GQX@E)beV77HC/EOQ$
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
7DR34D:94Z=N(a^0)28M9)-1)^BF)P-U,E36-;S4DZUEE:bbVUPK=S,9=&BS,8/?
3E<3Z<4\Y:.g.D)/4YIF9EeJB(TBTQC;6^SSB-B5CA&>gA0_+e.I>#KU:7>;fc>\
]b=BZZ<?Q#aX-6,@UC]f8Ya+.f]G6KIL?cKNJ:^P.L\bD<YJ6a0Q02-&28)NNBSG
R+Q6N^&3&B\+UE;O^88Z+62><(4L]&F.SJ1C>W@&]J&=SX&.bV#=gf7_G<]Y:bV,
2YKFYOaA5c@1C;DF;I]-M<I3UBKA9[+/VWV+Lf=<TJ>,^+;?E]MNHA0<#WCX.:QM
./^CAFDdgKa]aW^BJ:OC8@GP2)b&??Q9b>JJ5KH]:g9KB;d9W,I:.+&eJ2N-CbS3
fefMZ7K#H_VddRNGA41_gF/R1&bXe_YVO_],Q0:P?<KQHfCLfbJY/<S)5,Y,N-/Z
]=ec)BD<:UV5AM_PHbAS.X\F#])1.363?2XXHT\W?5b@ZKV/,E,A=2X#d01\Xd\g
CBdKObdAQf>2[X0#K-b-^bC(f<RPDC79+=5N:.c(P19If?J4]/Q>O,&;QQ;99bZM
JTWUPX,^OI4aMSPGIXZ3_DQ<Z/]+Ga?<NIYNO(57D77Y,513ADKXME[R63f51Z?Q
LFY6K^_3-Y7SNC9HfFC2<3NDE0@-EEH@a)?AYB=eHN,,d#QZZZ8-Q/VC_&gb\GKD
K3TN](FH80b&f]a>+@M[g=?V07+Q8AWfC3X=WJb[ZXa,<JQS\<^J#S6RB9Mf_0FW
,:Fa\?XLf\O2Cgg(6K8,0]0&S];X=-IDF5R9]baP+cYI=Hg,_@PRPL;R(EgKY3Df
+1PR_=WZG0/<:^3(&PcP#I<EM?QHdd/)0I6^WZgc;38]R.<:VBbA;U5,CA\/OT4G
;bJ<8R_J?48-E7>(Sb4AC47/FK/,A5F#X_ZPX,aN9[-N>RDc;,2-d[#>H#fW\C-^
5<2C9VgKc;4FZ5VHBX>?&5KZ]f-29?#SEX&Ye8\eOc.V=3(PV,V>ba13M1;AQb><
_D,,^)4PC)=]@O[H_.PZ#e7-B?DLWc/&AEU)FZ>T[99cfW:UMF;eZBY^gZI@PMPb
_2gFLE1^=WB3gM6:/BOUAWDD]4cL9aX.K=0ICYR#Q_fCJ#=^d@\VWR_M9?d\XKB0
?b1_RHA;4TbX2C^;)#K;CV)]\^)X66,7Ad.P#_<355@>ea-b?F<+[Z(NTR_IaYCc
VJ&9fE<B@00.UDRT?Q>eGfJZKR+<H6/daJ[L1Me7))DT;-2<F)2O.S^WA/9e8P((
#LfFc#Q@?1cCe(2,9A5PG78ZgR&S:YL&4aHc)/RcAH2Q<KD/8H2U#7Ud2MC+KL_=
<S#Pe41J&8QfL-cN]aIcQXT[2?+UO<6-?7>(SCI,aC-1PLZ/MeG7C0JK-C-4-V-1
(dPR?^JcA.HDIX5#]=eLE1gVcHAQ,4G&;SWX.efa6/bJ><OL9g;@&_EaLFec)5S2
(P&S^;OT=:9MbW1-,RYFYWP;dKQ16GCKed<.L\R>OG)3fF8Ja3[Z(\JeA?)B3Af/
W2GSQa0-E23L@A+X#ZNRG=IA-0a?\&>W_-ATAT,/(e)f136d54,=U)YI7PO+U>fI
7\Y1bN(G9DFdPN?F#(5;b:6M5W#W(f6XD&27E/dVW\#5be&_<[Y)6Y511W?(dVF-
c5KbeBH54bH,-0)Y[F8#I0EY;EZe#[JDZc6&V^Y6dB9CTF@\4Z9#a;<QDIPP;0P8
1;J4.acNUg99T,2_<c>1&HT:35XcD.9BC=..cB(2eGZgLPA=Z5_2eeR^aFZ,#d,,
M^YWAVJ/cB#W/Uf7AHH>@SOaR9a=\f?XbI50LQQC>^,dAASf^PW\b62(N[4.5cOD
[VBVQ;3(_(703=@)93Hb=]cFN@WCCL86TW#I4S#,F]=3I9.\84g:b5e@GK-Q?)G:
X_?3A2U37d?e_RRK<,3_\VNMBC@\aaEF&bQ\#\(6K01<\<A5Y\V[EKcb7<Eg2B\1
Q6-=BK8V3Y:2)VHP;eTG6)MQ?S(M9ZE53+.4gDW#;D4D[;bYBO(#bA(,CFgUG7J&
\KWf+.fYDHQ2J#dC=K6>I1Y7\OC0AJ)<\0RPc[W8;V6J)B7R:.(-3;aK=4PGXG;S
V1P>gG(2Te40TJ-:F7]JDa,0Q9P_\HI=MUJWNYEVC\:H^?6]cW4,/&/M8Cf8>SMS
J#AI;RFf:I&X29;WYZ6,Fbb+\_._-#g(?EK;#\5NO(<O31-G?(/.^,NNF?N+]/(X
bG&[RNQa_@TZ7QB+SbQ:3RFVbLV_DTa__359AZ\J.AO#GURZB&[RfEH?Xf6Zc&WL
X[\Z-\F>MIJ5c^b>-?&+gRL,QccXe>#)[M[)@TBTPV:Q,A7Qe5f8^>51ZdVDBVBc
W&@LEK4N?]KD#;G]:_T-(c7:=NED-,T91L06C^/6F<1_O^PUU>S60UV\:@+^1.F_
Z)02:MKESe]S3G^WVU-2ca/AcVDG;OfAB.;9=6NRA,CQVC[_6d:@Oa@2#3)UA&ML
A<XBbCP6g#4)1R76[7@U^4:(Ib>&f=P&#>?NaRb9=EeW\B9bdW[-8Mb[->@f7<\)
]-20+edfd;>.R]&4?F5Bbc:ZNNB=1CF/&C5eUC29AT#aO8=Y40aPYIH(X^4YYCKN
R]P\E?GXK:c.^b9^J[#(^D.74X,-IGLR6()V.)1>IC=V]Wbb^gFVW3BO/Z&6G#4f
G[84\J\Le,=eg3N9Kg+D)c(N6<\EEUG]PQRO3BAaZ2dF[SZUZL@^dQ4C;gU;-#c-
Y-.B#J4D7OdC;T3X@EE9gZd..PMHDKfQ1SZVe^gF8JHa&\7&6JCR5-(9O-dNeTX#
3X;KO,O-@JW_f5+4N1T,G,_aN\VFJb,/<cY:&<QK#XTLWO9H\<GJa1PKXa:QMJQF
(He7[ZWXM1:g_4J)PaV?_-3+D?bfXN;[Y+7&fg&0DRPRBV]17XGUCD)_14]Q(3cQ
-]+]7W\O5e0R/00KVP5.<Ic(@)SMHgT12d#ZD[9VEaUK<+/TI4[=OWf.L808I/ge
&0UGG=26A3A]XU8B/gZ:OW^e/98^8[eeSVL\+_5VX]KKERC2W;=PNDU4.+W<^(NB
ba<O4Rd7Xc_0ZST6:W?#5=\_.9UR)ePFE;I9241<eB4CJceTeX3Z_=T6@f?XT=JZ
>WM@F<F##cK[SZK]KPObd&fa<]19:N1#[/L4WZQ4DXBQdaDN6..5\>?X#^gGI+,4
:<^ZHA)cYB4>\B7/L4??0D_1H)\7R>f<G]U<5X_MWDI]J<]FK5_a?NVFGYOEILBU
4Wd2f,)@Z[DfHCPccP1>WVNRa4\F[37@\aWQD\8\3,1<8ZS81D#LW-OP<LM/<ObT
<XBA>)0Df7-S^S78./D68H[.OCN0I8V9F4C9eK=BW<Hc4+0g3(3A7;OPL$
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
8O,S6feB9>c]9VgG([d:(f=T9TO?)ePW,)Pc@P(gE.Cg=eP<4eg&9IG@(QQ69,5>
LM#]R&7\cDD=@Q=cMQT8cbGBW&J&\6<@ZM810LR4a4(Z4<#3]DE43U-#(Y]QWfK7
:](U=(?&XA=HX>VV)[#+fIQ/7OOfge/<\OgV(aK/.<_G_A6ab-,G43>--0>/&Y?]
@E_HeMHDT-J,-=:2S??a600;7/Y1^e:H3RE6(W,8Q#[66#g,f8CcbeY(@RI15UFa
GICAI)-0TQ>N=0E9ZfYVOB@RRVS8DD^_KIH3W^LDV;d)@BMO^/URg.>78B9\.O9>
9(MWg._\=2Y@V/_3C]cQg:M-d/:9-83\?I?\8:G0DcMND93dcH)FENKSEg3MG.QE
=]#Q30DfPYE.BJB2FCC]F+c[VO)-VfgF5ION6O-Zb)dd4PS;&_5+(OeH.IF6CE@a
b@g-4.PZaM<d0W)^X.;&^+PZ8M2JBCJ)]aTU)&P.b+<=M@bd5^&4AAP_:Od37:=R
7SQ2:(B59?G8-H4);9d;N.&9[cM6&+\(A7<_0#6U:=8HaC)\]WKKQ=8\:3bW806G
e81E[S:Y/a\@_1eHB=XgQ6EW/DUe.aYbR3(\-S\M2\,Z>/PF.3RF2-73f-Z)@\cV
#5.0P/4-2gaeIP/,OcV[GX.E7.daDP>:A,M-,86F?8^=gLEWZG.R4SI0CQNH^<EW
bc-V/[b.<5GYSZd<BLPNO]BIXK8/:b.=HVTEG4<+#L+:WH]1B^6e>_A7SH2R&6dQ
CcN\4L-bYFZ[R[Lg_7)5;^287L3.B3]7]+f,3RHL5TJ#.TCG3J7fcWOF>0N-LOVd
M-+Ua/V;DT):RG)g7UG.O1^W,/^Ag]0;/aa3?@b,SR-V#Of1S1S0bVg+ZdFaIIOY
eK,:H:TX#@bI=U<;;Kd_].X=P8UU_+^D]XWWD(KJB2KB>Q_N[X0<UX+08SXW6fO]
,>6/AO](b>,,BbeT+BcQC8-_Q/F\ZYBe.d#@08-Y(?bB262aU.)/-a,9/;VYNHTA
#+7?@O/9ZJCKOLAN_]D6IM:92X,3S;BQEI(fd,;@G0\]aBX3Y)=(4/GgM(:3Gg77
6?Z.)^E8H3c.]J]dE_(7QM,fB@GA3Ua0?(C)M=fA8TB<26@_,W;2;=S1dO561a/d
\+IMLU#dE68Z/?cOAZU.BM=C/1H06&eE;:)WN3?-3W[Y<E+ZZNK0NgN_.bgX.d4R
(Ad(^,94K>SSKAW8NJg-G5g/D5G],[,2NZE.1Q(+EBf2PR(0#bDQ?Z.F4#0f]1;J
E&b7^+^4:\G<NScGPH&5^>+TA<cF[fV1CEG@bD<ND>;6?[SY;WR,49VRYB.I;<&+
XI3NFDF(>,S].J]]Scf85)RfA+VaT/))We1X4#eNeN;cE:_QX<K/&7a]Xf[4,H(e
,7O1LKP8J>R>Ua(B.BBT<9@CF-;CD)F:X6G6a=KR;VRM;EAeZ,bGBPECTf3CQI6e
d]c(ZW_4C3Yd/,)P;&3VRB@5I(&=IH5FFb,YW]#QQW>cP>?#2^YQbg5)\A:@T0\\
aG>Mb+.D=N+D<1-HU)gK3(J&fP\)fG.&_>?WAf&S+g^I\EPLO=QA_f=,3#;&/VX=
fS.SS_T9fIT_)==U;b:=^.8b\GNb?(a;LM&O=,A;T1Wd_cMY_Yd_Y8@>?E-#+b,V
Z:HH4#AEQ:J>-SGGCHLO[DJ0dD5>^FMe(#S<a]N;eU:JFe5/G/@:I4)#b&/D3@gP
bbTVQ70UL>KI;GZaH&>BBF_GW#TWU/F?N[+G>&YJ1J8S^F^_\fa.eCWMN-AQF.\B
C^695L\UUb=CCALDS,O2)C+>.f1]c;K8ITS7Qc#gRcQMFDY.bKOfSWQ\5T\#e0-c
]79RQ[:;M4cf__-bIKLMHM/&CAZMI>))MW<[8NL\94FV<7_;8D#).CFPf@I#dOKI
H+@Y6&d^&K-37IWNO4U8H7T<ZR(1aEPEgEFYXKS>L\>:DRQeb8F=B?S-2a6^b&#2
SXTUbQWV)(]035eBTT;)>TE#K(I7IEBVg.;M\gI>+[R&L(/GJ9C5?.bA#29SdOF9
3/4F-HLA8QKeM11(GYc9Jg211TUBDMR/)4KYF(YD@HbNbS158SUL)H^8P)J@5)>^
#?#U<7?fW@)CA:QSBDH(VeL<EZHe,320VF/^HS<3b;G=+O^DG6?93)L?XNGE3Rb2
<N:RU8DPA94(E(:cC,c&dKB/_GQQaB8VgR.A^:+0#P2c;:N;/P(EF7XG)Hg-Rb>-
.;@bM.Sce:e&eWY9N#[&;:9321(9W@d>8K8YN#KY8Z>H9BN#KMZ5ca++HK#FCX[,
U-bbUPORMV&]=Zfe]NfE#d-QU3+<QH@M@H8Y_<a1Y/99;c-A=81?eV.YD++c+5U-
5@E6H96;3T39OWSd,4QZ1CZUd2+L9Z,O036c-SUd6V=bFW6+X(d>2#1gdJbG-STL
Xe7edR5d(HYCOaa-9JST(OP7\N/.&9d1<==NLZ?H15QV0BI7TWd4[+>86b.R@L)4
bMa3U.DUZM>7HT#^F?J(?U>Ve]YS<]g0g2)YK[9>]S:VC$
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
eg9C<+PFAb>A9AQ#,5Pd=UF[9WRL(X-.),#\9d5K1e?HeA\3CNRY(ZMO=9DY9(+J
-bc17_TK:[W3-b=gSbF,aSc\&Y+FFcM,a]Hd^]16U6+(#3E5/P[+0<dG,#cgA=Y2
8AQR9I_5C6(EHJD1UHR.P:NJ8<\,AH;O(H3b:.PX<[0g07FXBQIK._+KXedG#ON)
e,(ZKC:-XF1,(:NG^++5>6?N&]2?J?feLC&_2F^@IT+2O\)Y65F4FRP:&Z\>5@DS
+gB(_W9@XgR\9;0@Aaf,+&GI_Q&9J+A@R1IE5ZN_HSfZQbD6bDA3?GKV4OLeXC(7
Je\5&eXSS6RCR4G[^bQ@b12K9&G+<74:[M<L\_gEdHWCY&9S-+IDI2bOGB-D8LaK
VXGABSW2QbMbGHZ:I91<0U^NQ28[24FK.g::b#+IU,F=RdS6QN2T8K]K2X^Z6/KJ
]:+6]1<<?GE<+IPG6eGW<]aDab2GH^Yc=K3Db0XA)fR#\G-UQ=DgfZ.BAH1XIAAM
dUEJLC#Z\U[<FR?b;N:?H+a1S#K@WE-W97?(?90EZ_1+8gBa(-]O=,9RS6&^0L:8
@,8I#):6EUGF6RbCXdQC&_)T1,AT_NQ^26:_McW@BQMcd4H(:S]-HZHMd:[L=_T0
ee#+K(&FUN328\ZAK^V#-#_A]f3da2YTUN7XObMSA4(>/D47C9HRE8,_&V=ePQLG
TROcTQ8e8b@_X+W._JQS>.@.[)]IcWL]&E(fI@N_6VNZa7-_V1Vda5P31H<<_\SF
:c0M3YXaVJd7bed)Og1OQWPPT5H[?;4B^F&c84RWH?GEBB@>1=XbVe.Y(9+1I?H_
A7ceG.4DU.I-^III@eG69LE=PL@//ZJ6.8d06eOJ[0@cb&TcG(Rd_XTQ@:Z/0NMA
?Z4ZA2f?NR.e;F00GcCW=X?2fJN,Q34#dd>599(&K9YO./NgUPHH&f:71B7X_@)]
X@K=IQgN?2HZfX.b0FB058M7U\D:<ZJ3?aNTXPEFA_WW_cC@[,EDM4:&T:ZfVb;+
#9U;_4;:gK]T>F_CX3WTW-LMc0#;MIe@(f0LEC,5E9_d&7&HW<KO)UaXD(9UO;Pf
#e=CO=d&]Ec9A=J\Cg9GP5GUQR1)J=UY/N;WLD7gK7UGg2&W4F(gXK^VHEROL,XW
P+FI.DC[XbaACM<[?#SO01:YID5>CQ](P)dgg^NFCQU^>G@W79=9A081_UQa0<H9
]+7;O2[Q/-A-W[X:#FD&67_+:dbffCBG-?5>LOKgd;AUEJI1B,71KaEP;[9Hg.A@
FV]-(Ve]49JNDY2#L>5[.MMLe1?OQ#-17&N_ZX&:g6JAMS>3.e-f3<f8BS/Q5EDB
b&YA\MC&;7=1]<e5ONTa(:[gT\1IC>W2,.KV=@_eQ9/c(Q:1.)E,HE:f9BZF17ED
.TNe=X]V/R_)0C^E^b7YTAabRDY^MSLKY482^#d5?EdVgLE@76PgbgCC/8Y1-C9]
=#IJ;dN8LAEY6CVdeVG[1>@G#4f?[L@ZDVX:BdO;B3(56<UA#V[H(0J@a.-_4R1.
0X37D6g)c(?Y#(=T&^(HU1gbgY<#U0)1COU#AI[4&3K=8^V8TFSAEK:^?KJD&64R
>VZd2:YTEXcU99XA(0_.S7Ug.D+PP@??IWGJ9USP3<a)9[QP_N_3K/e[K(;URWFR
CN0(]@@AIa+4d[eY4IPH]f8?S4=7+[SDNf\<;2ZMaL:c3)1A9Ng>#,UCdS^L5d,b
9WeI.EP97WYPF2Y@HT?^XF^ZKbM5B9ABPR8_X/7>b:4,RCMZI8E+D?0SSbC3Lce-
S_/.K[LSe2A8-29F0GAL:&-g\:)1agVXaW[F=V&6F(W>(09F\48NIB-fC,,=^,58
/I.g@?PF\7(gWW\e[aSgaV_A^Aa>(;B\G>6S)+#0/OJgSd3\#>/H,C);fD5ZUWQ-
(KZYX,](X=0L0-\Z,M--Z1d#DQV5[U2b:#X=aQJ#O8W8M1[,\1_GOQIOVGbVZ0MT
b06g?Iaad\c2P)BOA6)D3/KX,I2&9)5_]>[QJL4R<EF+^5<N\a=S2=fQO;bNHDUE
;@dUN]M=U\I1,<d^4U3e;KP69^J?OBY8UZC@;[e>bU6N,F#=8S]?DA+UWfCeYR-&
22,[9WM+8RVCM+X+<CSF@I7LbUHINXTQgU-8:Ug3?[Z8+TSGOVM2^fSUSDT@?DIa
+)d1.7]=VQ_(@=\VN1eEL9)S=X56Ub,-XY,?O8[VP.e+ZO1bP]@gU3T.42,X4_66
LE+K0T<FW]bUP=,;.NT/7_#ZD1/U]1?_9Xg8c>N.=G=)-5d/V(PDbHSP]KFRGP</
S-\edTdb>e[AJTf^WC>2-RS=cR]ZdcW,^+Z<aJD1IS\=QHL:(P/Y(O2@+70&[?@X
_?6\(Ue=\=Y>^?Q:(]FR\_-.<MMVWbN6.ND;9#P<VgRJ(^/<4,0Sg(I5LK]dbV6@
IHKH(caTQ4[P]/GOcM09We)?HIIV780a.3KTK_VAJcM=EUW#HM)<.-T,MB:M\=)N
>4XX\dRb]RWGKT>R/U9&]]AL-/YcXI<MO-01HTD])Fgb>_,@E>GO,J&ef_;[#WID
M]2UZg#f2I^X<._>?/P4)BJW_,@4+,<Gf5e@=g_f#YX@S&JPHP#Bf1fF8MDTESBS
HF-3M:S5Z6]?1P21+L<GGIY\KcAL=?4f8,BL[e9?A#T\@V#PQSIP:X+^bba)bcV^
T^cIb#7:ED5O12:I&F\e498V6[5a_TW&d:BIC;ILc&?_OW.\cX3F>,-P;b1;W:5J
5@A8N-O8dd@ULaa0U>(FYG;O7]Q.I-f=eGT8BEc;,.)f]YM.9VL8EU/P(BKV_b)M
^-AR8I)=1A^6DQN;?6cF4W\e)8a@V2)+bbSXH9RV0-I\eI>ZbPM4aS;NB<HVX8fG
;W4GCeBUPO,F=g;4M0X)F0<_?UC^:]DGf>GB980;fI9/b7UE#acA[ObRYNZD[]UG
\[bUa?1TgZ0:gf^?5b,:WfWHfC9RYX]E7>+5/YfgYL/X,@ZQ]cU@VLX7:_U7c02(
_Va.GVGR9/B#2NQB9=,0Nb[ES>AaZBSdd7Q7R7[@L05.Qb3cL,T>/&;YUROQWB]]
LgEQ?58g7,7EEf(+fOa[=<adB3aA+c9O8:]G:[,0XZ1QeR^G+[cBcd+K4O5cIO9,
P9&_b_45ceN;Ne&81X<L1N_7C6BR9Q6AUEM-fcbUb/cB4c9@0,[S\5<dENaC?([/
L/45KT?fVJ\T=C+([^f,L&Q,J#JJPP/#G7P>DG,G3(MG^5?I\>;65CG&?_H1&K^S
<C7AgRUN]IVc?5ANf4_=#1M.MJ_S.A_7+S;beE;+)507^BEJa,&,7=6bD([PN>^J
c:?-c5>bXS4YD8XY+>L,=f[W?-;[c3ODRRZ:fQ\X05DBBH]4f\X:D5/?HVLV<RIf
CD(L10)SWbNcO_]7>;a1J]IHG3FJS0aQV&(0C^Z&4R3(920aRQ4-6T/Mf/Q6XL^f
<)L@egeY]aaC4aUaBcH=V2J;f;1PH4fUATE<3@(V1_M^704+cAHXdZ#OX71(C\D&
[+N?K][#ID38:(7a:O2BE96;0,]Z73QBQc,dW4g0M[8cZ64R96,Jc\\LX_M>cR7.
PID.8+@&_fW05PX@:9[.(QXI=Q1Qed1T>&2G[3<\?EKVZYLa^8_8XA?MMX?VW5L7
d]P7QFFLIQIg<S3Q]DD@Y)4?6:TS)L:V[W7<(bN(Q]CAWVSFa\NIQ^4,;(BP=#-b
7e>&f3SL[QB9@@APW^5Ned;:ZQJQVLFJ^7/P_P424)I\Uf+&N#=e-&#PJI>NC56V
cXB6,bR=MD^M:=KMUcB2F35=De0^NCG2PBTY[LPgIWeJ7A4?FZSBVFN=S(aB6b>L
CB3d#D7;Y[\,eJAME8ION49+:B]U&#^+TLJZ:dWe7-c=b(>ILSXgObI7XB]W@-d7
6a[LB;)9N50<b5)O,\Vga[8?=<fd(#[g][&;BWf[0B#YFKP</@0QI64bIK1@I81/
,C?#JYKU9aFGL.aD.Y66REMBf?4F/Z<d_JQG7Ja9K-:-5Ca0GJb&fZ0(9(aNRRb:
R8DAT+#F.12EJ68F.9b)4QM9=D+70OE#@c3T,:+Q;;aU&_A66BdQ(^_):?cXAL@E
@4YWRQa[:0VN1->;@bKT@MHc#>OGJ][-8Yc\7be>^b.G4b2C<X>R9#PMT&#-KQ;<
VB+PE@@4(&_51\MZNBRJLX2B]7fWB),<UXYC8V;/2E=T(3[)4adMYVEWN97_<)J)
I\X2Q5HM^-<8:M1BQL2&F:/Ye\YOR,a5,S)?ZFPP:T.7>fKL&;D<<NK,YM@XeCR,
MUH(<7:c3EE^O;BV10bU)F3LNFUHbV5Ve/OcKF#80=6,O#)FeG@NP6;X<]QR?<[b
SZ18/:#PdZ5_D[g3SK5TL<FeM#b9C]::>Y5TJf9a1K/.1_PXc@83W@N<2W->U@cV
=)_A4=\11\2N&?d^>+[HD^dC]GcU^SgeR&8,2@b+)_dDTWID6EK0X]S2_eWW]&P,
5aM^5-XJTb[a_M2>,(G),RD,XdCWF\g)RD:6N6DUE.Q87KW6beWK:>?[DeQ+L>@.
P#CI/g;97H_b>H#U2E<1g+1Sg7K35Y^DU&^H:.PcD7W^>27:6AK(9WBKf?N+IS&H
&8HbE^cF-EFA+V#Q)XA4;7MTgR?QZIR(&ZgeV3cNHc/H/78@1_JeO)+C?d@I0?4;
<TVGCce2Y(bcQ4>(5BT8D<=a9e<V:W(6Me+c3KH,Q-C)dgScIaWeD[L)VQ47?<0S
?,F3O@#Y>cS1Yc8;,UfX,NW]/OK/B?Lc#R&.HJ>RWfS7W#K(Q]NC=U]T[e1OR&.?
:E8c08_Ic/+1H6,eS2BWE;^G8D+9Q)J&>faBN=?)#73V>S]M+[F2^1-2->]X_MaC
2J&3-.df<KLeUgOS2&39=PI7\IL[C2UF:eM[5KdC][EMEe&eACa[0CaFAHc577(N
L9F4>S_9L>+11HE/IVUDE^:e1>ST1>cPACD3>1)FF&:L_^AJP4@UNUXBZ?cc6;Y=
^_O:E?:Me2E/\VNJ.Y]Q3\.[(/=c/A+U/,+VE)F9-0@WbKN7D=42JXVUaMe=):D<
J/U^3FfS46<6M]f#NGMS<@KY4]FgZCR=-Q@-EQC3/ZX\9GMSX+NEF8?d#D@(NV)d
;?]E:1O\Xb0;.RS9b4cMGYd6+>ZM?Yd7LU.R>;)BL135#]Z>V5GNPH3abYfgC<Q#
bf6gb(3g)[dg[7T.+b<DR?-ZCSR.1V&=Le;=<@e0YP@B^Q?eCI-)bHBeZW-b&Z12
T,<LY\/9.JOP4XB.2HcB.[;Ye]Q9VK_e5aP21:M8.&YUUPIMM:4d2B5V8UBPNb@;
;g-6#4IKTa+e1O)4W^Rg7e/G>eD9,L8f+X?I<3(>NN(J3_d=,8S0-_DaQSF2(MC#
^H/)GO\9\7N#SS#=W#U,7.I6R3(ZUE^O#>=N(.(06A&];-:bCZQ,<Pd0/A:cQ+CN
31)7R4cKG3b6.^3IdP703G,HMH)+2D;)Q18D3HW(W1dANJ.=U#G&JZ)aJ6WgZ=.<
^@R,2XbJgGE\f8aV3_V^F3&YZPXQcaX;6=JZe6S]MQCD,PAcF+I8V=BF)Y==OL6U
X[FCG0dB:f;0W/])G/BSZe;/7f^9Y.-O+D[7Sc5=Mb+FA.L@92(XG)>A)ZNEALMB
S/1MG><]E0Kb-9Zf@&^II5(^CLCJ=W<+D794K@f(feH9\[P-d+AM8b#&Bf,=&]F>
0.=GgJZ=[MQD7Y+Ya606#I0dBG.C?9,cD&b2M[7?I>/#<XOCcEVWX:#&J$
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
+dN,AF\XQ2HS9Q&Y9E.#-Jc@-1;O9:@_(@+]9[PRFW;]#9d(JC5B=]]X9ZT0(+9U
/N3fgeZ,DCK5ffZ8FF0C<F]4LSabWf>=\,?<3C8>,GLI8BVUAAeJE2<Me&8Ue^HH
\X=_?;<:0@Qd4<X@fS-@]G3:1cYNG96CX1e-c+@a,M9P&;A<5H[LW0O4D\P@@-aL
)0A?NS2ac-(P4L.g1>7>W(-PIJF>CKaZWEDN#_I-bGPYaLRYb\#2Qd60QAfEcLT=
UQ65]daK@?dQZ>U96dPHg.R0Q_LTD.[6<C:2Pcbc0?[<=/HUO=UEK7a/??SUL@_]
&BJNCT5Q:#C_JNMG\C3S@9VN)cDI,3_8&P[#;J#TNAfH49fHSe7SRX?W7@\65)YD
]AMKG.JM.f+N4;I#4LJB]<+S-8&6YebfEBL\MMDZK?f/CMBWJ1W?bS\+V++XS3C3
6A7=M_YP4.Cd#1;+.E#S@Na0G7#VBa;20=8f5T:/GJSD@??LaVde-M=c5@<(HJ>V
/,2Va&IJ^3@HN#IVJ/bYJGgIVRTR\^=OcA=7/ZH\0dde5\@:WPXDNQ(Q03dZf2/R
Z0T.\_GK+4&_]F+MLXL8#BXQ](bHa4[bWQW0]0N;GV#[>DY>;J^G5J<LNBg,^;2O
1\a3G,>/KJFS4Ma)>\g_G13NYG+&X8Q6L8VKI4F=]W#D8^JYT6JW=34#]CJ8-=9>
SKTb];D:M8@329VG8IcRDYW>(:cFS19O<9Q(QF(If-^D8.2c24S#^W#9cG<5F;QS
c/1ZG=55Faf?1L?d2RPI+eGbbBFE#gBAC&]=I_?X)M&Y#3_A5BNUcbZ\FaS,M>GV
J>T(S7Q8&Vf.gY#;ABTKTc[>;,+VTK@B#S&@^;QQG)+VVE@SEg-#(DSUT(7d:d,G
ZHXT-f?(J^1IJ\e@;VSNUWeH?,f_ZTfe88Z;[\Ce_=c2Z?Ie@gV12ed6<PH;:M-Q
D(JWC4,Qb<ISHU,C;RHRTS9EXQRKU[87Q\N,e2+HOX0?g.:b[cGPN?XQCNCAW73S
O)^H(1\[cc8BDAg=FcWL.TA,),C,#,1fa6]:Y9TW:TNV6[@>HTg@C@DN(NTG1TDZ
Uff(]:8A(/K_LOH\[<ebN1F,<]A8UUN?c+6TPY(]Nd#_?N=;dB]Z9eg>P#MceU<C
ae8E[&OU7c&5K(ZZM2A>TD:GC1cEHU(8,J>9T#=TKAHfYAgAOXGR;2@#AL.[#e,E
e[aUKS#MVE7\&c18FL],McL2/ZPG#Rf5>_/[]KG9R?1KF-VV0M=J>8(FTb2/@]g]
ET=:d<bX#-LM=;;&6XSOEOZ5Rf_Z]aO5)PI4RV5>JJ2-/0/TH.^D8UcA_?KMNd\2
H+N</D<7UT>N;C8^V5?.)U9Ne#PLLT7,9YZEV(::>UM.)A2GOKK08T<B&=<CJ6+6
3WHXG@UK^]W20P]LX9R7D5A;Db0<]V(O(WeM>G4FdS^RQG>UXE3=3);://C<W+/P
,_1dPGLYDed6;V.61:89&/KJ+-]M@0Z/-:)E.d-XK?V_>5NU92;dee=G)MJBEIFe
:bCU<=^V8Xb@PC+(&0VAF@#\SI,>OSV7,_QS.0LBB09IQEVJHZ0@:F1.JIFg(3CE
2e<-U4g[/0LCJ6_PYO8D,)Q,eMcKK9bb<R>D(Y1#edFdX1ZN>aGT9O43\LSJQEea
C=@dbTc:-Z9>/VbA2(>4]04I9VQbM9Fb4Y9N?H=g6NO8L=0e)(F##QNcN36/,P0Z
K:P06Y&(32L7&CeZ)XTP#SO1X;.=X\E,Xd_HDPM/=AEN(GPS--[XS;PaL[@/R[Q0
,5eU4UB\\@WJ?5J#D:Aa0ZTAP(G:STXO)^Td.LVf:N?PJIC>Z1).U^SS1cM/Ibg8
V6LL8E^K:A3]_P0XFR,>gL;Ag63/U9T=6BV?(^Re0I5V?OCKW/:^;Z/22[J;,gFb
dM?EG3Udg6a9X_#:L7P9;DfZSFWdE_e;JS8[4L0\X9,K6bP4\P-c3M6.M5]dB7^;
(N8LEaY)gd3Z?^b?f2[Fee9GZ2H6_L)3)#9T?2L9ac[Pd;G\,daO;\P-U5L=fA4N
&@WeRdd5VS/GV#LTELMIZ/GMKH:d#;@;_S0K0QG8GaIE[Zdc52Gg4JT[U6?G95MT
X8UQS1b/\9DL,R]1Z0,96AbB.T9Gc65aVHB,N0BUOe,C_-WCGgS@FN[gDK>F^8JX
6H:3-5cN/6941;AQ(9H.>0dc,LCT0+EJ+d&26)8B((fEGPg7Y6b6^gM/5eSLGgBW
NdFWS+_-;OH40$
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
