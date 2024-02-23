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
>Y]Y_SQ:5DT^<h=`7mU6inp9HLkC^4iGN\lD7CKENbYN8cq\>5ZHO6_bZ]H_Q_ne
I0oFTJDJYV6K>52nOcnE1?Cnm;H0bq;3nHQDq3RQGXMq``MPn6fpgZO`7nA:LHI=
58MF[^;f@6i>9dlf0KI7L<o[p0ag]2@<Id^0kXSS35[AO;gHKaP:cegFBX48F^;@
T1[L@PZFkJ<d`\B]U2mApHhhljYBmXHk[]\]YL>15gl:]KWk6NB;7A3KKCBpcoC0
K@]LTk53iak00GIVI8SPlZO3;^4O;6pa:=Gmo:e7egdKLL8Vn?fW2MWDCB34?C06
VVeSGLWo=Wp@QFQeS;\K2:a:eIO61gRHYO^IHZ]`BJfgnEZm\Wo580qN@>f^Y6oN
4IV1]^LLXi6HDoU<Nm:ZPkoq0_\@[@EGe<c^W`d;>iAc6mFE7i3T\@@O3Tp\Y<B;
K=QB0lJ0YTVoL<9_Sa_LIfN8QNRpFAF\[76kHJZMh_JZcSHLh3hiMSeK^1;phXF\
>XNcMNJXdSICmCNBD9LKaN84X?N8^=Y]_MoN@kgWfcH^l;OZ^V9cC\q\0g=oh7ql
gP=:;[3U:>9_QM@RQB5\eNQHQFdS?`UHCdBpJSnkHF1bB4chS3Q]X2Ij]kW_g9<b
k1nbek^MqN?O=>`<CZg68i7T8K_YQU0bD19`KO?0X[]jFW?>RW@aPpYYD41mlqjI
gTLC^4?e8JGdiOL_f>O7jk4MO7p?hCJ@^[WadcNZl\@h3TCo2HflMSc\RBHI65_G
cHiAi0<SgR1a0:[3EdKq@bhjD]8kc8E<;?]5F]8:V1RD6N:b@UTM8DqjXS6?_A=X
[JdWa]HaKjWBC0G`U6ZOoKL?;]D_n=58=jSJcKfc^AnI^fVT8SNpG9kD2Kjpi8jP
5\Xp=_7T=bB0<0<`maXUb\3eK7MZU0Xl9WI00F]dm[:DRM;JRi`;NfP\:l4g@g>C
\<Bdo\SZU4=YHA5h[Aa6M^^fDS9e89d6OGP2Y=6EB=@BZj`5Ydd;NSp45_SJkiNc
7RUb:Hfn]aT@@O?IK`0ieh;<bRF>9?ZUNhO;=hUkE26=?B8=abJpHO]Ha@1SQmFL
B:eQROh;_5A`fhi^Q10;kkTlbXhlI:6;<1fJW^pm1iR`DCMTDbd`S9DdH3m:NEgk
GVgi_TB<fRS\1>RCk?R1_3Ca5:gqLRo5b7UeR[J5dZgKdW_lga\TU\<fWb2m@MD9
@2k^1iJnBCTMGPec:6k;0RZY?BTC_kqTSR9DejHY?Wf:0U?TddM\8J]kX?3mfE5F
idIEj>YU^cEPNO`]9X3OEoj\hJhX;T1qOnGb8n@Y^Q2omOW?VX]k10j]1da@HaMi
7B:WDY<DAg>@GXVQaaQaP@Efm@gpgb?HQYDjVDMP[ZEcCnJR[VR?3T1V;2@ZLInm
AR7C1>kDT5UNlN94a^QOlHF_lc8<dEAaS:3K>3I>S^^iSapX80NJN]F:=WB10C>S
;]j5Q_71;hFS@8dRN2Sa@GTTJVPJA3TbaJ=F5hE1R9aTQg3ZPk:RPGFL@L=XHCCZ
hXh[GJnOon;A[mRNA5A>ejcmYHjK><qHV3LDi:1ZRXWVMLSKlT<l]Z@N=k^ClfGb
ZW8LRL6ek9h6BR`fLnIb8X@cCL>d6BDqBj0\bBfJlGjBg<_hUDQVUK^gTl`ZfHQ:
Wb:C?Rah2_fHRZ8jp@V7OEfD?7e>Y6\QKZ<Z\A`Dp;bB:STkWgRK3EGkSflAIOf;
:UM04Kk7X160^I20NS@1VSkAPgIgbK36ffTGm>hfV6Qa9V<30[cEe<<?<7R?_82\
LmP32aY2Uhd<=BBpON3iE2d9VKJn;5dF>6]^Z3gf`d1JO5OKA451[Kgn`5;J\jdb
4\c@D?[HmUF@Xa`0=[0nb>b`PlpAeS10IT`;NPG68Op=ni3Ak8]dY5LI6kB<heAS
``l7MaOXYm<aZUKUJq[W1`l0KH;5bSRbDf<Qe3\hgIjJS=1KD7E?HkJB^q66P2f4
5KeS^=`V=:W2U=6hq1B>R?jQ]]OYiiPl;QQ8FL2LqgNPB629S<kUBOJ@[6mRL6Sd
mmYe`Dl::`jPf_Q_:3Jo^K<QcZ]np<o5`9n?REc0VLgO:LWOSn;MJ[DoJq[Le=LQ
Bdd`bR`077gJj\_G\MP3TnDNfdEVq1Q\e\C;n9E?=1^^0^>qELiNE]ai`k_Q`cWZ
`<oqTR2jM]XKV1h:@b3Q1PWk[WeA<Tg^KYG68UkqS4ETinI4:]U5din85jH\Wn1>
K^V^?YU310gl8]?07IXK]1k?lLSJFd\9bhbAf_2HJT6k_oTVgi[n`3qnOlaMMXF=
CCJj1Yo?ejDAikC>7S5eUjR?S4o\X\NH\9`W\k1C\i7=9T086qbdK_@^3kg4_1E\
m39<FF@VnUL^ES7T4lg`?Yg2=HLFBbbM=Md\^;l=fB7D3IBE_nbXDAB<$
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
cKWe7SQV5DT^<fDl7dU2mKBeF_\6nkIUmNQ`qS]ihTN[9A_IZY6p;AY9nJ1H0gF]
h3]_QHaJnf7@VYDO<5QV?Q^<M\LmFkGq6QLndkp03J[Ld=SJo2GXne7@M\UjOip@
l\\;bd4\L@nZ0kb>`RA<7ih<j[5eoojol0:lDGM80U=TNTqD<;RAE<<dE0k@Q@Xd
6k:kWGO8Om>@35NZjOc\mqd?^RU@qQWk80QJ?cK;Cn[?AXcjbkeUfFfnq2ASj\6L
\??_F4T=qjKD>WJGd5l8P31CI<;AIHNfgMNg>UF97[b>K3:p2Sh<AW7o`UIhQZCh
[?5?nM2J0O?c?`4b_?hPi]XfiNM<8gHHcoZOXL>SCdaV\onq2Ioj?0e^:DYQVlF9
A@Goec_NMTIPq2[e8C^5pQkgL^CM:Tidn4Cdf7S8m]UGm2NGKkQInU7W`ZXWKLmc
bh3koeehe<@Y;]kfTo;4pan6Wd4q\I^\\O^_H;J^J2?eR?96_b;:0>7J0`kp?fnV
BlZ?Q7FfD6oGZ>JE;[Ck;cWmbbNfqLF1YYJF;R^KN<jChB@4BjR>C3V@C9[Ha=A?
iaI`q^il\SEcQ[ZVg1CDKlCfb:i[HX^j`_jXhpI<gP6XpVhMI1JD@nLOG7NLY>J;
C<KdLp_OQ[d883gd^hh^WQ>eS9]ZhW]?L9n5<T_3SMLY32V56aK;3PRXXl:>p:6M
Re_DnUYGVj`VZXUFOIh>j_2LI@J^]cNApoMU>4CqClYjY9Epfjbg5iRcDZIdd_2D
5LiT\k:ZV8l<8j=BNn>]OSR5b`aAD_`KTMBl0bVDWl6\;^CDhZOPlf[qS2\Di\QU
eMZVIco=>9^g`V<HiaIi9mkeFVcY^o[?W^T:;PL6^fcRibqSUT@[V4RP3;lSoW4M
^=ncPp5eS4M8`_MYE`lgYa4KLLoDBq7o903RLP==GHaKBb\KoBjAApi:jmB`QJGV
Uc?YadWBE2l\Hp9kG?bKoG9UEHCBYeMH3jmHqkh5iho;9=^W\C@_gKI5fE1q^8[5
347^oBHhIn[hfg`1B>fMk6bT<k5hlf\nO\7VQ6qnXb^P?aSR?::X?V2mdmokZp>F
\=YIgcD3K6m_>;Hb?Falf<f`WqK4onKZP6P3I3J59]`H_Poi4VB@>pOYUCOd3Ia]
NQ\S_7\CB`lJaN<SkQqlXj?4BdalMZmPO_:eNjOXSihP6Ejphnibki8IKK]<=`U<
bUPS\ZLCn9`dqE4LnCloF`hgCW?]R64oEVRP8]i4p05Cn>Ch<1JAL\_GbLfe0VY1
NdN1]a\CqSMXDdl]2:ZI^1G;E3:Mg2FAPHaY2mLM\qQ2`EGj;MRgeH7fMZXe>K2X
NQPJQ^p;>PB\gbaX?8mZ<A0ZLJFBMFUdKSBC3KYD?mLe5==LdTcHN5\T3HGPA291
>qNcGTcP_aGJPN0N=c]5`T^TdT>^b4ZkO0Q^qP_G=Nip>EEAZYqE:VM6XqNfLcgY
0lbie[T9bJMa;d=\Y5oQ3[b`9dNB54kLf1:lqW^U;eGq=^Ymk[e5aH5]]kBNOIKe
n3411hgOe^Kp`]HK?A8Z0eJhabO[S@gac8C^C1cK`;OphIKb`]I[k[T9FUXX@[N_
EHS`bQ?FX2p?VK2HP@dB`F@5<nb7EMj;4AYRTA:VRqkETco0[CWhMmai[:[bIplh
TQ>LOWTYcK5^<HJMd>l_9>^j8LI1[2UY7Hf?k[j8>RTcO]1^JURd?R4loRO0qV]B
7nJq^o]6dkqafki0Qq9_l2\0pgW4LWSH@BVlji5EgVSK]`EET:jl:lj<qWoSISjX
lb65_V15F5a2mOY1Idk2mD@jcb<gaS^EIieE<I__C3BQZlF3LmBTD047aq[88PZ]
<lZ4GPgm7o7FVCc61i8dNM4EcpMc5SHij@h`dk73On05I\BB@Q`>m^ZgqJF1=iV:
H4OKCUInPcAC=@18b[Gh@bLqKWoHDDeoFSVXm<HeFRX;CO2?VPcOfM49eJK_E\00
`BJO<0U_V?iCGCpdhZik]iRpb2B;3@epQd[I?kpe[\LeYfpR_1MgcGCO]\V]^n?i
NI077H>CUa1Y32qN>>H^edKeQI_3dKe7ca3jlVF6mDE\NnpF>aB]3kU9^SgW8J@`
8IRnB^nGk5gTdqfIoMLFZe8e6kZ:g[:m?CCjB4C>`[1IH@_WKVmfDFNb^Yoi>Dl_
po4fjnPRGQCN2ZHDghJZ7VKJDEC2bL`p15jb_LPqJ8A?H1pX?EaQFlpn<?gi6;T^
Ihob1<1a3UFkY7jS^9=<`O^^70XKLCDRTq;N0G>\gFY4i`7Q\8A4FFXG@hp>?FOL
ajdo4P4dHbaLiV;8YF3]7Y]2eq`9W0hO1Y7;\e^PiGAZGCU[g0Q]kEUo_W>lqJkE
N[JYej4b38b\mHX\CL:mB87m2\bn=a:hA`b0eVEGqPokmTDXcFX7GJ\?gJoWVY2C
bLI6B<WCVqcVCg\RUQEe5jT;87D;WO5F;;m4kIm2PnDP6bU@NqbAB554Z\E\ehc`
jbK7CGBSR2m>c\dG[jG=VWca47p2BFG<nT4JU:=LYNH]Bh2VhSoXOJI6MKB=gj3p
2fe?I4jO85\_1XeJ8_>CK`VKE?58A]9`m@lIqkHV6eDng<2dHO9h_d=gmg6nJfAn
Vh2Wc5o8kqbjn?15dAlkZVnnG=p7bUVb_khh1U]9hCGmL\N6`<Ujl97OETgGBAp5
QiJ\M[XM8<72OM`hNBi5d23Z<L8^E6__R6]7oCVmh=Bmm6c@U@XZUkT2bPh@b@JA
JUT_0qo9WVEZjRh;jafLO2Fn:VFaQ01K=?]8E[?eXpd_:jUb9pTWoS>fXAhgIaa?
DIV6qO7\\808FcX>XaP4K_h>[36YUL<oke;p^Onhd4eCZo4Nj@NY4H>BA4HDJoNF
7QDqWgS@gbYVleYO61MPoCqom1Jg=[@_YT=;^_VA8Z[Z8K]_e;jo>`qD9d]5VRqD
>oQW:nT0`g\;lq_=1RX8^7jKEl0CfQnAc87fYT57kKZ8iNUTgpP843<I]X7GD^74
c4b0EMjWAPCa\EJL4X;:X`q`\^8nad_[Z_j3f@M2Kedhh:nEoT600>YpZoGjei`q
B:o6[E67A_YnAeh8eE9[^;I9KaX>8?4G26hqo7OcfeEFC=Gnjeh`dXeR>@JEUV_9
Ef@R8d82O1cLAKWAcj7a9Jb[3Ob2_ZM0\:6qnU]GgjGqj4@76J1Z>N@U63HLiZ\a
3HUUkh4nWEn5dSm`M0M9\Qmh[O0@V2?<N^_N676j2?5`X:ElhJlK4C@K6VdaH?V7
7FnCq=m3>G]:n@MIoVdjYUEkh:2qiANGWS`6SAeRSZDg[HUZnDn2H69IqC8n:XaR
0lR]g_6h9[dHb1YlCq?jDY<SG292aZPH7b;Wq3hV[Q8\D?W1<K6EURC0=lTd[EJn
>_32KTe1p;XiH13XQb8S5<9_\]FUi4h@86cE<6ch[AdTQe8>KWIK;nOL4TS9\CH[
TV=SDjO5295PYIZqB`g@FF\q=<:WD73m4Onobh>IPnA5n1f>9<3BhOQ1IhEdS7<8
q2;6A@FY1?U>8[IUPVC4q8kKn><cq2D^TKf1>WYCYnB<H\?949Vk0A]b9i_dN8<4
F60dhma5]eC[d>57TU6h]kNc]WGqVChZj;Xq3;:mjFmadDT6hD<`1hE5nDPIm9T7
:;8<P@3if^8Z?@EZXGLV@fb=LIeeQJgJgg5YIN2WV0K8IDQGl6\3X^kQl\hS18l>
aVDW^JpISRP=OiKN_f8me?_Aob\95=5kh:LbJ]DRlqDdC7nYcpK0`CGfAii4Q=Bl
g662P\pTEOB;6Q\;TIR0K`CgV^UMN9eSOjNT59]HSa3?0>fSUoQHW5J\FS\Ki7\h
ZgKZ2i\S<?=IblBL8iolgZApD[e6j9mq2HMCm9Bl2UEAZRF5O^gh7870V1LI@Q2D
eW^I_Q5]9HNpaHadIIkh4^Eq8MofC9Jqo?l6AJmKSA\EY^ZM<B\MUj0LUaQMha12
Q`JSkm^pgnKQ;o?^GC]4hXlQY4ZE_lGREPG]E91$
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
SU4^mSQd5DT^<6=]n0c0E:0\W@i9NkB]_nk1@gS:@<=ZMYc?m@j=qkInE1==aT?T
6Pl\3KBa5H91?5GG`>OkJ]SbJ99o7E9Q\F2E78opB[2HK2C9dI8eGXYc=>d8Imea
54cim5lVH:b0Yb\G00X4dGa0oYj5poX<fFbpTTGlWb9jHgm04<<_J;[9c:m65XQ0
C7iPFC3QN@:O;`h^0oc?d9BRYijMCgpP<11\b_co0>1g6^;g;ih0OHl[MAmj[@HR
0:]]hM@T`UCB4;mBI\Tc:Wn`>QZ@<_nYQ43T`a<HJCqVh6F1]]aPY2PZ1K<4mM^6
`qe=geIVY=3\>TfFQFfS:2B:f=Agj2Z[^HBU9e_L^4N73?aBHFB4iW<@iq=63OUK
l990R4hQC51OfB[Wp\S[I4Sk1WN?Vi<TonWBhQ@DHXnhT=jG1WVW_QMb^GO2iASR
k6AVNTP8IlfXl7ZAAbT^8Ok?WT8md;jZR7F`q?UfiO6Lp?48ZFH48=8O8iD:=gHH
hImL<Nn@gp?]IXgWWUY1;:[DOYoYj[1]9ig<VTVB>l>Bp]gSOG`CpbcE0I[>W9lV
[9S6^n?9aPX`mV1iEmn5S6Z`LTi6Bh2@P2W_bfMTHHcenqmOGJehNlGVGY:Ac`bj
oLS<l9H>=7TYM_S[WaFJ9G7N_h`L=mqClS<X1[dMgjH:B9CgTD5W2Y5=WDN49:^e
\<7Q2E7l_ejbU?9^m=A:\0ojI]GF>6A<9lbeo37?9AF=nE2CbiUp15=PU^GqAHOO
MbX;O0UEV>[k9Y>;8Q@S>J6;\XRqZYi5Lf2g>h5RVm7mAWc`QX;TPI\ASj4i78?8
o:R3]>TLdQ[YL9DIl;SOpQ[fK5o:KiU`QC2n5Cc=>ZmSimZTnWOOe8dQT;8USYVE
JnQ[;Mj[fH<eYU:QK:=h:lKKfnLE[1i1\<_0l11jjp_AcY[FDqB2H0^g<Y8oO>Q>
h3J8OCGbfO=TkT>U8DQ2ea7lkoOoHa3lp\5<YF52eI`B]?@TCh[S6<elnCaC>G^I
qI@2QkSqD9Ze^9MA\S<Ya?<H35bT^T1XT0k@1hnEL1C3DF@R7U5CG?]f9o1Ze:ap
7MkOhjeN_IgZT3^HlRgQ@9QJlL51<H2XX2j=1\eSgFaKQFeT1cg<b=l`8G`R\ke8
cl8@7:N97<KXOi<?A6Upam0]EU_qD2eJVn0B[YXTb5lh]mRBf5oXTICaqZhF?a3Z
p\OTEgP:1WjD<7j;MiKLebNB\BN[neaeD?\fpgVVAjQefFd02Y02ZWTg@GIa53OZ
1GSQ^`0YT?<\flBeiFPU<>:bRof8<`>XNpL2Pn8M=K;]abf3<oiRCek;0>fEaEDe
D]\ObAlCA]n>44dAO\l=L]`e=TY3kGBBUIF[>Ghj3M?DJA=<p`mAUQbe9R8iYY2?
QJ=a:3]mVcTfVTM=olQ_n[9[=4iOQ0I5Z`5H`2`N01_3gkH3@`mko5;kInFOVkLk
TTLfI_`;LPZU3[Jp2nIfGM==23qd^^A[R\jai16Sd3eLm]6J`2A50n4fKCOZX7UU
F7phR@dj<B[NO8a;HfoWP00]5BGdR\NadZW5_@ApDF;V8nIq68<DUZfp_P7cQY13
\lS?Z>B>>PW]kd@9moDJ4h<[hKlXRb[8BoUUQ7p804TT`=p30YJjTVOZUeJjZhBc
nVDng4FDc6VU55gp3<WidmhqkSQJBa1X8>C=V:L]oY<BU`_pW<V\3S^F06Kj8`NB
0SUI8fN3`[c4qQ?k=o1k[<jeYQBH81dUh0lp1XGmIgKYlmV>?doTP2^=6I5d\OBZ
C3e3pNlRQ7^RN4^Y[PFY`\b0RpY?8M1ZUf>?>NR;3ZiS7SVQ:`QCMd]>ZnZnqojl
E_SWddnkFWENOm<N6F9mfH9KKU3lffDqoF8hEQ`iC:b?9k8URW0^lFTED`W0hQU`
J6I37\[8h>Y3dLWYodGB??IK4g9bc[q=0OgH<WSogR>PVX=LFJ_<APS^1fpMnCBE
=Z6OCTSm`KRnL0lm1L^20@JDWlhaUq?VEN^BLpS>9KQ_akFkX4^MM6SIP8pj:WGV
L3VlmU7jLk3ggh:qhJAYEnO_kcl\D2\H7aPJ\X5AJKJ>1^L2Ydol[3N\4Hc1nmR;
dA>9BDh[MEo75fAOBn8CBT>Zf2Of\4\m;`VhL^4\q1lMa1L8`:1b_aX`fdjmmOig
;[[q?ci8lC9qT;1l9Q4FgZ<9JE^>k@KPS<2i\EEmEO2M^^GFOBVHc5>cW_:5G6H?
gTL;pSiJ=3?FYK4;?Q^FhYPB]Db>AoU>3lU1^<jV5=LHbL@YHf^PbR=kASUc=X\2
\ZHHYeZkKJZ0j]6?c:Q^]::hcJQThpLnYfW7<_i^AMkG7SDVq36Uk0:aoS:[^V?5
J<OGS5:FVKEpcRD[^5W5CKPi:SoHM6NCcc3bmN=d?GJRhZO@_k08E6SWXgB5B3AV
8AV9eOGje@Afc3UY9>E3pUo6oWfc9\<I>SPMI4MpdRKk7VnpI512Pi]5b<k<HC=3
5RUQPhCB=`6ZUX1ofAJ=4_2A>[M6IgJFI5Gae>MGdD3cVHnMACMW:Li?l07@DV>G
<>38321VM8@UGe6N]cI=V7N0J:pmQPG@I`3LW<^i0^SgmR=k?H;m0pCoS:;aEpWQ
WcXYCI11oYX:<qmLnUSKAkRQcn84q]PH3VaU\D=oV_d`73:LY@FS7b?V=MBlK`>T
=[BmfpFEMPL?jQAl@?U:3I]KkB`Eo0aIC4a3N9WB7]L2WeFSL6bFeeSJ8Qck8^0^
m4^n`HakBBd4Z>HHnS04QS]iQndT86YIiFP=U8:IjL]lWi;@0GAaqSHYnj7QN0;?
nS0aZPKWcEUFL]7qhCEiU6;p4`ih`45[lMCO@jWb@W_g\g01dS9^JcmpWUIIo`a?
3fAi\i3ejfNP4W`NWmdXUlB`_U9S90:qaEm]8]nOL6E2e`Sb4oOaTW[fVTHoo77\
W>VhPF>B1OHMLM1o8Ie?:26aJ7V?8Zff:1JYYhpmHZJJC2BOJ4ZXQnfI1eBiaOLg
LLGEi=SUCYb^CT:FWhCIE1X>7fRLMFkd_inGJZLcNZKFGVL\>qe?n6UQ7HaR@_K\
0ZH:<T^lZe`U1^qD3gkahGP38JfnhRL:04q9;A<micXN?aKDeDW57o\K7CKAh`SB
iDU?Jbpa2e9l;NP\C=4I>BH2g0=DXPmn49lXj1RMmae5MZJTOYYm5D@DLTpPDgAQ
N9ap@`N\]eLlADOOHDNJ_KcqHmSKaj176_L9=AfR4P^TD831@V=ATP2bNQD;?4d1
T2qIRESb;lJoV9ONYnq4dF[=bB;VGNRdd1X4_3MM[A\3Uhe\h]\hMLVPND;gKq1B
aRZ@6SAof;_3@K\G55f98H\Uk9EK4K>JN7M=Q5gW\Ce1NB@LHq_PO0d@aIqS7AFn
EjLpU\0[`Jm[n[d>CiVC^R]J8ZMS15JBeU>Ypd8=LiU^7IT1^\@nC>ooGK?peN^Z
fc:p:dOT1?Hcn:249kQmNZljf<eYJJH:7eET\eN2LX1\0BdP9jjj3HP0[Phd^7=1
28JCS1JcTaUj9@bd?kBX_[D[fRf`PmSE<T>e\l?_>7VD_`RaEO^dNN[`mC?VQcmD
c=pdJYSGS>EC:n]`Dh9fH`eom<hLLabH<[8SXNm@S44Y\4dVj9f;XRfOV@eCFOOa
2h^g1dM9<n5pKZVd[LKpB:@>NUYb>`WYOi8J>O;V31;2=:[2cVb[_HKfB7M=QO?\
l[^OZ;iC9gU3^0oi=lanBVDJGkIq?bGRT2fMC8P7R6h:TYc>OLE;9o\Mf2KZJJUn
Ti2L>X6JX6D<1DFb`I[nG0Wg1VR6XlmhKQZaLjhCWQBG6lqn6AMg0;mW8WK`1FYU
iXC\Aa22H39?UOkComP\<I1TjGI@Bm3iJl`4cpi]6Rc:Pb8^m=G1a[`0N@I3X7pO
En```WqP7kgl2_@;k:UZg_KMc0M6<4`>U_D^fQjQ;QINQf_hiZMKa2VLXDlTADV3
NYZ=LQZTI_>Noo9lWh@N<FeMWNZ7GRI7Jm>GBQg=QA?4UU>8[h49W7_3VW\ZJYhY
NBi`m\4aWnpNllo>U^hXmen:I5Y=d6nZ[OBT2pNH`dBeRqRkGG7NAU@DS]NGgD@F
@Dib8LeGZi2k5<geb;3Nk:iBpQH?N9K8Z2T:hCENYJ==Nn]l[9kOK>1ANa>ePfni
LN1PGi[e^heSgOo7<@ck4ia=Q6o?>cNOhk4phc]KdMi`CKo;0J[L1MFm5gQ?b4G>
fhE:4H?;p6eWFkUm26K2l?J0GZ=F3j]WSL_@1aH1mq2eA6]Df0jjY`N6DL8nqfM6
h;[bOPk;>DcGI=Nnq@RSi6E;qNYbbiX=h[;:493CVGD_k^5jj\Wg;M2M3jJ4nF;>
Hdl?4LoVODBOl@5`01RX0l_OeW_=`]`mIdES1GQD1V=eKq\D9eERPm>MR5NZJA8Y
BH<U94?SO`C1Nd0CG7q6W=knRF1fa;k`Db<bnj7PQjhpJB:_V\Qph5D[_Xch74b:
=ikC[<YR0:oWnN=NU4oK\aMC8TF0AeR17NSjL\\PgMY^kPJZT[iH\Ffb?mXYm^W3
_j^To3E^:A\:nV;H1[n4649NBVi1_B>3ANSj@Z=G1e6aLK2ap7lj:lDKp:o^>^>=
qQ@h:YSpoCKd`V`p\fi2G]eL;fdgM=b61UiVoBM?EF@GD;5q<=UN9R@]?P`VB49I
]cgAm8l1CS9LpcW5Z7PoBFD[hjkO35^<KLPeeJD7bGi>^pJBCW0`LqfR_bfQE@Dd
]a4B>I3>]@<?<TPH>`lLL>86b@7V3]A>]F\JnjFiGL1fH:D2pD6NGONj29nET[M:
[oKq6ODSPjc]XT_f;HUVp4ISH9`<pdPB852CcY@E6]B2n4Db?mZ6`l123q26bCLc
3eI4`H4ikBBRMpcaY\4E<>9RHD4>XRh5P9B2lo5[8mdo:Dn5jpJejICDY;=PF:I>
;2\EADj2_OFaPJXQIU@Edj?XMMOa^oC1nq?g?oaFW?n]5P<0HcfiOg;LJ::CWPXG
R8YcNnK9dknck5fZ554\np_I3_6=gXqb=U@VgY5UhfO8F[;0XYpDAU;5RkG=QnPY
e<1EBPP9nJcjclf4SnD5Q^[>Ocn7HpGCPEHoR=EgKdjMH`:11Tm5fLGe832f@<Le
;oP[M[Qcpm=@X1S4;WL>I>8h[fbX9Jaj@KGUo?Q1`>_m_=G[d;3kV2bVkI7<qkB3
Q<UV:pgmBMmCoY=l<OQ8`]^2FAZalXa9BeLSnq0IOBn_Lbp?2Dj4eh4?bi5lB>q0
N2[P@m`E5Nb9OiaDW@EA@6>g;EN3k\>f;EnQd_7M@Nf;=p4<<=H6KNU;C<n?bfDo
_\b;D<V<lfhA=A5P5GgkIl;91j>\98]ejGiNqm2^5O_FEp@Y=XFDoO8^C9l24hYS
0QDBq:]H`AZ]p:0EEFLiPI]S__E4fq4n?k@I=;00`PL\V]dNp0GLUY2WqgUKL7Uh
:cU=M<_n9N3VVX]15_bHGEBQ`jY_<]5\SEK7ST2k^9VWZCb8>q:@BKDmEZh3;=Uj
ZRd_@EGhLmab:=f86T\PXl:\:5@0PpRKK>9Z<YQ]PP=]0h@A4>Ec09q>OVS6aiq1
8k86?6;?RI6bAP^pZNZ=O?\q9gTR:cW9\6cG^Z16fcSaWG0984JVQlPAB6p;OWnb
5fc9jU8VDRUShDpb`Yme?CiXf\oad^I@4T\Lf7cYSn_IWFcqgUTPf_<qLm;9^bEY
;4GL8WHo51iV7:a[\;aS_P1G_hdJ[BB022=pAkX?FBCD\b@2Ql:jo<Fphel3agg@
cf8TR^;]2_B@iC5GoHp80Hk`iWqY8T0N@ApPkXbiW=iWdBZM2dL:YBo[;DgXb?io
Ui;l;nY3Z45oX3`TJ`jP4]UD@>94Tk:ldYdNTfJ6J2@31;<;\kaDC[_NM^n_chnb
6i@YIPF@PV^]6Ap>ZS9n\5p[OEh_UK5\kN3hK?Zl<2HnYUj<mLT;o;0@naKh4<po
P;ULPpE4l9>]m`2<mqR7YD2Ql734;;GeAZB9f4GYTjDDk5U^c\F6X8=Cd4nQ>_>L
B\;@d:m=VaI>iA:>0T0[F4REBZL@0Z?Ha>E9e0GnBPgE;6N5gN>bj;NoB3nX\ZZ\
\qZcC=bmUpHN?;`6<pE]Y7@aJaj4:4D<iKjFiEa5[]^<qT]EkmP`qSMIc?gVfZng
gj5L:AN<G1Ye@\KGf6kZU7LVLnAOKl=<;`:<F]Sp5YSMa::pA3H2oLJ2e=_;o?PM
7kh]m?cWL8`lXOUGph4H<J4ViA[eL1l9E[@ld@0kQ=KgDIBHi0\KC[]>V;c5JLVM
2oZU[44XCpl:QFVbXn0KlX4`Nepk[VS9XWp>NMc7;i6\?6lR1KJfoi4NG0i8EI8C
2C:Ubp87CEC^S=YEaM@_MkAZPpFol_lLjSI;>G`2kiTQK[b]6g77ODekYV_j<WJZ
R\RFCi_9m?EBBM793qc0?E:hMR?3>gU8:cSKVR\QhPPQI_XJbSq?[Z5eZWp^ANeE
]Y0Z\a>8JS6fh?q9Imc3di`<0@F<Ji\l>HdVIJadPpEPUJDjHq5d@g=ioq[bR>>0
DFJJCC1WF9D0CeD72lQi@7L>Aa;WLO3obYaTBV02;EgIWX9HiRJ<=K^9PLki_IIT
:a]\V=Qn=;`975Q9QgV7lnX0Ao5kj]_YJg4Leq]7OLSDZp1S>ibiKlb3<C`]cC^D
2V<R?TaT>G9Xp[S\g;\0o0QAh\TZ0qP2[Ui;jpCdPCJb6B`F0hZSGbbZCW398dBk
TWA:5A>4qHiTmDe4qd:QVLc^lCA]IRMiX5012QNdJ_mq7aWBk4Vd8mX\=13AJBa<
`]T]UmnQ<m^aiLCm9Q1jQ1jqYnl2Zn54AJBN6<4`L^VVk33dlAU@>:ZT\[1FpZQJ
CTjn65?9nD5[LCRDV2;:<A7^7Sf[L3kk<M_oEp<ZamdAl7Q\j5;T7kQdXQ8MN8dI
haZSihCZ?7C6PXWTfWchJXg:M=:OV7QnUH9P3X<AKjamROSScSTEM?LbgeUFJMf:
A6NN6]jb^7K2mGV4i16jP0<9pCWKLf8`pm\LkM4h0?F:FmCb8V>pV5X5<BXH`BUU
Y13`MN\ZXbmlUkdTbU>pil6gHOiq7`?dIiB9Zl2gY>ma`6BUNa`>d1Zok7<W;Ip<
Td[DjU3PVccMN:k`^h\AQ5H2d=DAaAMN^]K8ldWRck1RGo_BiCo6kPb[_<a7T_Jc
nB2^8nQTLHSOMAYMaDgThoOfmV45aOXYUg8KD5dHIqjh9?U]6cZ4aGc]c@FnhT<3
S7P_X^Cl7Ipn8I=0B:f\V1Rh98M^jB0`S@?POGgFUj7Nf8kARk7d^`2jo3O5_Q1]
GN`XaU=PFK:`IH0[aZ_kQ4UilV@gPokU[Nf8\gQ_hg^Hg7B8K0\CMC<Ygn9IE_Hh
C]E`gA3kCm2b04p@I<jE0];N=^doeiO\7mlm`8UK<VIO8YKRicaC8BN`dk\\^1H8
jS\AkbqQRoB@]\$
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
00eBYSQ:5DT^<Q=h]VoC^i:39KL=K\_WLeRe\AZ1c@]2QjF]RVB2=i?;mnOdJKWG
]hGqBbiRj0HO^S]FfQIqiCKL:MeN4m0EJ8XOLOk>XEl_0bJ9^nYXjAWHbhYPL]?A
BiAgh2hpmDiVQOpR<72Z;<00]e9L0N5;g3PZ5\JlL6lIjP_NCcn_nCTWSMSqLOca
LmDp3no_K]JFoFM0^mlW\n2X<0m_EiI6b?49WWI>p>GT<CNjpU@k41R;3M:8Y]n0
<@R`Wl6F[jDC`2CpE?h4kdeo=U=naaHbH\;AUfNgID9JETC74K9bNhCeM`@[Rj2B
Jc2RCU>`33hRjlLN4fVB\7G>S6@DHmoZqZQEiM:25bdc54aPni63]joR2I\6B[4]
=4P=oBm?DT`<mZ;gT0NTIa7C@>8JVg5>caTopYA:fG1[:<:\hgdi\TaaDUL;d9<6
_mEd\NmT>WoVeW`T3qNANdiMTEh\NeHSJX9=G@AFkh<8\C[[mpHf`E86LqfR?>_K
Sp>E0P9WS`dH0QJG9l4fHhE_P5YQa:80:gp1Men^JZRcbVHIidDEPG1_<ZYO2EO;
OeSm5]Z[gbdR=S:`4Ld07F?1>qFf8iNeTDZK7MoXO40cHFflmkbVjVZ6h?<g>BqL
E_?>>i08?@Tk5JimRnS=BEb2QHGG@XpcV8O2LWpAb0_N>\7\Z=6d\BWO=]Hl[1V6
7>2IP2JoWjS\cq]Dc?6S\pKPj_j^NdCn:S^?ncUUGFSNjLJcYaK0q1OUa47`=;d0
5LGjU[kgnnDi>0bLWjf8fjkBUW7AQh0_[EGWTD53JT`<ef8X?_hgHUUY1QU>HNG2
TV:]2piaAnLcf7RXlXCV795fUO9mmmmLUNpaO`NSlfRKOjA]0>GfTDIH;J^P=Adf
C=hoFCCk:>nA@=inopTBMf>jaAY5DU8SQ8Pc?R0gb=aYfm@XEe<P5bXa@o:9Gm4?
4Ye@:>lg@1VOO@BH1T^FDlKQbqaK^\Dh[lX`eD6TP9WbjQdkS9dJQM8:ZMqQRoB@
]\p53PjJ]5LL0q\Q:O8mK>TlkPIP>ES4Kcl:OR3anC]Zgc<J>\Jmqh=H?G1VmfQN
;0Qg>R4[aO>G8RI8Ya4bfD4b2NY4B3K5Jqk:8okn;jX6j;Y7\IFkVVPEVFN2X\Ig
Cp0AS;WJgqDWA5OiTqBee`AL\BJ?f=nUT4N>=F3LgnaH9M;OSfHQ1;iOKCGN;B`B
o4Z9T6nQUm[1?b1kRpe_G]Tm9q27B9dKHT8I^OfCUDK[;g;]?=@91VL7@gMCp52i
UVI]B5YH:fXKQeh4A58M3:VpXTAaI:nS1m3PMki9poD2e0LPpVFXf?aY44_a=`=C
DiYR?l>ZhABjIDa?AJ28p2mAXL78l5PGXBnnj0RQDVWoG8BaLEfoCc2MCM7<?J=S
_7Z0RViWPIZ?qQ]O0d3R_o=@;NO\71e=AZCb3HFL0nVN_eL`:6jLN=J=?O3@^><b
oQ<neCT:9=gYX>U4a0EF2o;JD]`1jWXnqdh\6aBUpKCm`X^P>F19hC8l4EKI^1g7
M>YRF]DcnnWD0mIN<CbMg7Dl\llhcTIGAnXEiURo\9]Zp\h9Il`GPWWOM@MII5FG
^=CV@Y=pBc5h6LJoZ4l:Y2]T:RdoKUPB\3gaMDe<:7S4AZ6HkbphY1j\8KNOLgfJ
caEbWF4EEb`BP5imoHb`JY<Jgj8U0aZ@TYS0g@PjGSq8nlca9gYTB;OVCR[K:lEI
<hT_RI0bCi0oa1:4h]\a<p3\]L:7p`mTgm4W:doD<o`jkUJQhTiV^?;abULNSPlq
BIXb66n3:ULkYa>i8j43V]eo\k=m;B0nJ]__<IEk`O9Hq_W\\Q\Kp\fdiUccjYFG
:4=0l@<81c@GX0Bn1qGASddDfpHkeEXJNE0RGaMOfgaPk_fMHX9ZZ\Q=b?@iCS@c
QWUk;iLcbcOT?M1G>1i<02PT5KVFOgmPSUH9?L]1^f]lDAZOEhOT;;>Fb\VAeH3O
HC1]TfpOaIKA;p4?cKbF;qk:6h@8OD5eGE3Z]IpVIC?YGQViWDCN=JfF1bR;HHTq
OCcYZ<fhTNN@5Xp<7nYWX_[DjC>DAQCFB>M1C4;@jR6@Rlp?\0CaW<Z:L1>32SgJ
^jZ0K?I2B`q6L^M\jP>`AfekW3DA5Eh3_]128anD:2aqYI@h^C9pKQWP1\op:V;?
8=ZCcd>9f45II<NZh_3a?LFFabmcf:P[08VZ=NMnp]LF>C6j;<FB7XdTTgGH46?c
oh7l0DOTkUdj>dIB1pGe2MEjmp>]AB_BdF>SH[RTE>34<4gO9TiTYYZCiK8o7Kq<
XGUiNcpZQ?@Gl699PG?b;L;jN@EaAbcmJf\CQK2qQ?mM<^;OXKOXWDnZU^0P^CL`
_NX1jcJkcU1_c_4gli4?ZSe<_`6J=^WTcd;pETU`]YoZfVd>dIl4D1iL]?6Me9j2
3X=gcBj<PPaZ9SQ41e=Y5Inn8KbHEORZ@T`oaP;M3RidPZNQ@oFUp\@NGAd3qVSV
<@\E3TOGQfGgT^ZDiQR:oq7Sh2QE[qF_jjD6Qhk[5d8l9\gg06g7?G7n9X3k:fN<
[n_ETp:@>CO?Kq?aWGC:q7P1]GDATTMj1Fff^H_8:ag:B@Pb?@0DCo`LmDYl>NTL
\AdP@@@o=LJ0e\FA;37\8obLHjVQe7[3?YiZ;qDPdV@M1FBdYNh?d:o1b3?J\m=V
EN13Wh@NF085nfZ6\>ffZZZ0Kp@LZXWE;qElCbFbZj5nemQ5dm;3iHLm:?\JpCVo
@Je7WAH9]m?IWCFQEc0\eTET[cJ<JF;Q9dOeKmTHlI_9Op6F?ZN8OmqS8ifU0J9=
77CYm54S=5Q5FW>HCSfH903GmqZQY2ho\Pq;5n40Jgl`?PA:8^]jM[hClIUkXq`i
BgBL;lb^jJCiji><dbXW]9WF4g:bgG\OkVlUiJ<Q^07Vh8_XFnA5i4:8fbO==pF3
hg]h6pP\aKLEnH>^a6VWPn@?JP>JLl9eJVIee;idG8ZToN4K88b:P[000>C151UZ
mb19HD0j<qcE`;DNKpE99^D[7HLZg`A6?7p1HeY_eM$
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
;<YMZSQ:5DT^<h=`7m9minpX7@bfQDZVkJTTUHmfESV;6<>O[e5Gd?c;[XqRZ63n
aKO[RYSY1Uj:V918PS@CWTIdQLPZooJUmEOeKJ8J93c=mhcK1CUhPZNg>Hp8jQdn
4qlfX3WUBCL2JeTblOM5ApWiNdoJOdcN>gX^WH<mqTdI0D3oV=Tbg55\;>QMZE>e
CpaMYdh0:cbE>lNRcj3=BOKSp<f<mcmBjE5B6_AHhAf6aB7^bGf>K>c^<iR7GnJ1
Q5>B<cjp8]WfcURG=8<:T`hT_GGRF9QMq6[]>^5Aq7IT2XFV7b?@qUV8>aARq_;j
1KoZqC[ilklhq\UBCW0bqL;7emI:N7>o_3\InX7:pLS@5653873KAeSJg5@HHpk\
Z[JKOBXA\<YRgB95HPnRLdPcYaL=X0L:J1_m\NJg`B9K3M`n[1EGSh3f7O7XQQq2
EA:XN><;DZcLcOJ^:1hee:E402SKDL^nM0]=1LgfFZQg\P34mGC>=pP^cL^IM^Md
p>@d=UjRh16DR3j?fF<`AK9?fH2C_kF1C9g4:el=eQ2iLMMTO]aG@IoCZ5NAgHeR
^AeMmlmSWM;9:]h<9I2P5`X?kUnREK:q\c]3ZGWq=X`gCBM`liQoTXcpPQKOWa1p
\US7_Y56M=N19JkZEfTlq8KLF^VQL;Y:o7lcdf\;SM_jW1PP[_UVoTEq[RDLoF9E
EjE1T6TUYb63<CCg9h8E3SKSPd7Vk:pe5dX;l2qJ`<mm9EAn>iaU1\b_A^8OU>EU
Nq\gZKMGYSJ2\O5aQXb9\O3iag[H3BiJ1<Ub@LMIP5>4pmSokOSRh8N^NkD808DT
`CYLVa<mS`4DbYMfFUL2XLKN>>C??_0D=AU`kJQ]T4co;>VG^=n\616gLAFn]X@f
\qLS<PDi9qI9:SUGZZ>k?a26KTohWAHK]Ck?2NYC[15DPWEI;p0EK;gakI9ABLc]
1dFgB30@IiI]RFO2TqGE3mLbYqdI0dm[;:3mWg5j36ZjhQAh8B^DSJeQ@[@3oWWA
KdHkiL;IR_AoBFWKK;bJS3fOpV]Rl8\jpf;BB]nm5V?qJ:<D7jDLUdQiNkLiXQ?F
aPac=RRP5g<NmRJ\?aV`I4`jgRaogi?9;7:OBU=MN^oXE6P9GVi3Xml6NSVcMcH\
U[aMIJ\9Pdqk3d3:X`q2g89SEfq^UCBj?oZFJ3PNE6MQ2<Y7J5KkaaPVj1pIcVL8
f>q]OoJXZVWn^GYbCh2PO?[8KfpWWAQhj\Gb5M?WdZIb3DeBhF<Na89\6i;oMFAA
Am1@:mF:A7GeG4;?jblOW:EHn_fNlKTcn>ok56CWk[[jfad]jcITIk\>b9X>?bF6
9c=N@SkW1p61=@nEhpb0igSFWlXcWkT\D@FI7nReUGf8hi81Y1S<qm@UaRj7pCd]
j]Bm`JeiN4VhUJT0RU0<8`SXL`U5=A^1FM1o^K3T`b>9DolbPPSn2V]:@X>IJ7?L
F=akhJX1S86pnfNLBKd1XWJ2nlh[^Bn<k]EHj1QRl@k^WBqR[?jQ;Cp@II3FObX7
\81iEOT>C]leLQbY9?mXH3i[<F6HYpdi4<GBEqKmVO7D1qZ9Pk;H4qkgg<OaRK_1
20DM`HXE267j;D;5^Oj]]:dG\XlC>h6PCE2I[bah>U0<`FB^3I6m2l>WRW]H4j^i
SJMYIj=^mXMYq2C3a5_QpBngWP@9@a]PCJOdDBh]I\<^pHOYHNkOXDRSEP6c5ScH
[AYS7H7@OCgDE]Hjp@O:T09lpa8DciUVp_dUV:AF6MejO6VbFL:d=\dbIb=X=c?J
SCPaeB2[Sk=G^f9>N@l\CgdRkMaYqMRkSXInnQdQD^0O57`a>^8q^F]J9VeY^_F@
7XiVk4?6AT3QHL_Uq7;Df>[fqGBkNoZgGja<1L9JBb66Gk=EZe9R?RfR:>WAp<Rj
`]cZ:eJ2Y4dPL9\1Z@XKm7bnoKND@MEJ_LBT^NEe7c8[M@QP9`<GkEJpVeffUR3o
FP8g1LkK4RNLD5lbTK><6:gkjUVR0dHf3Nmb@d[\eXn3SdW>A2C1dncT2iSgFoK6
;n5q0>>1E?\egGonVZ_V6h=ojc1qVGf:4IU64PKI`>T5TT92C:]Q<XXmK4IGqWU>
bN6[q0aLe5F]i<?bLfL_dp3b\_ShF5iXcDeBElHL?k8cS:jZ<>JE3daUR_k[88;]
6W>V4HX^RE0N:RKm:m5>d`Feqc[2bB9BqcdVI5d_\9K4GEQ:D[LWV]`Z12K8ZB9:
?7ImpjC[1XMXf:1lMk2JGkl:6@oBW^6HJqB:la07EJJb5f;JEc_02UIf5AFWnT>7
nf6jc:LY\=ko`HiY]DIRXPp?fEFY6KiS_J;>2`35[Y4eWh1iC[=IB206:YGY1g2=
g0jg54hj`2F;BI@B5cTBUM;?T81T_8;LHkAgJOiH]No^Q<J<K]FPoq1]_Lg;P_`Q
^aIaAEbMj=R<YGIfY8CRTV_E^7mae\cRXm?Q3Oh?M`68DCLoH\TjgZNYR_hP^Ecl
8]>@kG8apac0QgY:X7Fl93:T7n9keENF=9`kD9B7`lZ8Ko0;OW9gFN>HE^2n5<C;
UC9h=F=HBG3pjJMnkObk><:hcjPBG]VXlG_2Y==k\Wqb403_<cCd2Pk=^1:GLGB\
Ki\JAhZm^p`D^=3k3qBZV;2g>6F9KeOMUoPBpQoYBUh9jNKa_c7j[lFNe`ab:LS:
B6]7UXcYpk:=IOJBq6XG>MEG`R22:0m95L[2obc4:3\B4`^fmf3op79WRY3=_bhP
<M1h1X64b_Z;Bl3bo6DP0kni5Pf7<1m;8A1?gc`MKf4B7CceFdbJoCMW<_b8?W0:
p]AC^>K?A=`iOR[BaOlijiTURX<?a1aoTX[PJ5eC\6[eI:C7;:MSibDT?2=p4Q^H
^B`j9g^mOO\8IgF1f<TSdCjUP@gTeFSEJB`HGQBEUOH`9E63Aa]V9^HGe2R2Q2n4
LkiJl[Ea>H0hT_XkhN6p8<X>oe<PZS6jT>8gTTRKDP6o40mne5>qi;m=B]>p;K3L
n:>0fkj]ULVl<]>WNc74bOLiChg<Xa8qFg8G`QGp8h8gTc=76mgR9Oc:Dkd^5Xd1
OSQdLC:=:0S<b3W7:=8RPm5E?bU`[Jb:558A;\cSY3=QoMpc<V7;i7E6mb82G_f;
jLAoMRC8:]Bkh2f5NSq5LkHj3a205S4niMOV2L3>QQ[leKK;nUfHX?KjNLO[j>Eg
47FPN8=`2pa17JNjfQon0<X:\=m5KV6bP:HCaKK\\?\TGh<aMVgdXO;MLY@9I2;i
XIU?j\]?J1nF>o?Qbea38:X5[q93hj\FiOZ8\kV6c8<:C;i=>g:j7L\\]WFV6:6k
[B[ADY=6GmeIGa\EW0EO;3:=[m[jQP3DR<V;Elb\?R:F5pK87dMC=2VFQWj@O\q=
3aNU[h7FiJ8l8;B:[LT<d]kdV`0IF`pmnG`60dfieo_EaU=7PI=\hE[A<75ZMJL?
Ua]1^^GAR7W6DECHWd@Jf=HV`Rd=kp5[[aMT:kdehc>6WdNEMXiH`=@\^3iYIqeN
^Zfcgp3T:2YF1@3S4QD[TAJnF[\RBH1PB8PKdmY01pV:MZm\QqFYe0Ea3nWI=CU6
RZHUoOheLY=`o[@VSgLo]q81X<Mn:El2A8mQiGE>_iWCFg07HCfN@:?kSeQcb@\j
m6fm94YBdR:CpLT0hUM<^1GP\T@mHT\S`>]q\cYRmNQQ0o83j=_YCT1iX4<bc`oQ
B8k4LSoDjNb<jmS3Z`^__K:j;NK7dL\:P:X<gadHGQO1<LT@<\6qk`GEJ9X<[joX
8Cn4dQ4jA23l>GX;A[G:HEco2mo=a<XG8Gce_JBc:e;RmeKCW=^oCAMEZUTSEZH`
JZL<ZNhqQMN[i]I56Z`Nim[YqYQ67K7S]_iPY_UGonUdom=<bWHV1<_6qk:Gn3CU
6^PE_;<`A1cKLKYP`\IQk5;=qK8\DjYmplhMc^^TR=]0K<M?h4YCkS\UCVm2?oTM
iq\R@KU9iaiQiDm4UDLTn:\BT<a2G9B8DU6B<BnUK8G0Uon8`]X:=ITlDXiAhW2j
Qn@Ufpgd4DLLHpijb13j0C2CK7EYg6\SngY7P3@MQmShn;<Vmq<i`J]QH^`3L@8U
h[bQqQ1lQ]f]?7CU:5c]K069dnQcdng9Wj:ndYNmW`oH:ZIHe4nmDmhZ<4<KaflK
M_YC=?HoZp=BJ=:@<[An7nfJ[BJ\N5_]CJeF]o^>=GhVQUdVbo7>4Ei_TllRh6LP
mdpIDXKZ591bdRfMZ>ScdV`g`cWMnijYGU];_`l@U33dGbglW3lO5QR9]7:oJ?8h
QOKR]cAS<IBi;i;nd0A<\b@gMQ:dIW<FA_6afaqA_R090bSih1B7^2?O\OZHh7cL
d6>]>Xj;:G[R_>1:_Fg9UObKD1b0:fT\`Y_M84Db320AeJaCGLTLd>VD^p\MYg9Q
1c[8>H\;1N`I7G_>C`_<I33ip=YI_m``pBaR57UbQARTE>l[1@dSQ^`k8860=1TP
dq_[Q8UIApV2YEa8PPDMb`OQo4K5iA?Dm00RGmJgT4KPhpj<AIFR9jJO7P?[_?B\
M3COFTVDCe2\8fJ?VYf2i@nlRUYI1SMUM:6gpBLiDn_Q55=Yf6jXleEi]i3i<[LS
>FUM]1<HDWm=GL>JB:Z8EX3[X9ejeC16qT[cNf>_[2TcG`ST;H_I8oQ0i?^W9CdD
eX7FFQB`WO8Y8K8T4]`^H7^:VBakgdnaMV6ML2jd\8Zo[Z9mpi@ALEQjikAO[PUg
MAlO=YM_TW026khjNX5IKR3RMeQK7hOo`<_:TD1[6j@dJY]Wn[H0E\L_Uim=2LSE
T>lp4HR9SZ<=H]1S?AEq<fJPlLRCGfI3JPAmWOfm2bF7\YW>Q4j\Q_BMZeJ[<RMC
[S695GJ[F]O^I3SUp`HINWQA>18L<ZA1lOE@fOLJ[K5DohBp_[PQiL1p=NoL;949
b?>lM8L:e9mhk;9OhMnTpI>Bk4S@<=739`KlGdh`ll=:QV`h7Fmpc@0ckkBqWOWY
CN9bg1D@mee5p>H7;fh^p:3@l[NFoF`L`ng93>KY4<8CPG_RS0GFi<26o32In^f4
XC=n<[CjWWU;c2l\i2Qi77j=]9S3qoOlK<b[P:UP_[T[5Z35UCO@`a7HpNcgY8HM
q7`^d6e]6^J<A]Z^;Aj7_3_1`7P8L\PJhg>CqNXEU]VfglYZWME;QV1BFCo_IT^d
ibbP@3W8=mVoJ]BKg\Oka@5ld0>C;JBqCc[3K1QKC\JJ[mN\9l45gPoOS4dgTOZ6
GNA`=AUUPQNHOZ<3DGB=nXG;]AGDHbEe83`i7YW5WGC3aFhFDXq;aQog]Apf@1G3
jk2DM:NmC1799BfFQc7lF@1O>q_>bhML7qGfYl=_?A42QOe[J>JG>=k]VoFa@b=j
UGIU3P`71Ocf>\9HPDF<fE[1`TVlX_@MmlcB_=MG\Wq12c[ZOh?NEN[N[]FcGbq=
NGjLBGgLfXJ?N]KCMTa1?<S3DgC@N0nOA[qZSU[iC<>o_o_@Gc0S\CgDQ91]]Xql
7:Ui]B6U8U5a\U<MlJi<?TO4g^Aceg6UlQAZ`PTUgg>hb]ion3M`87c3C2Vpah;Y
il?1=UKFnmVU:7aL4a_]5f4S62bAGQnMZ4:>l0R6KA><TlIG4NT0DXR=gRf^qbKQ
4Ef4SH6f3_B0852DPB8nV6@Y;@oC\`hZAA^]TnSKTPKP;AW9D^>GaLCC9CMoOJLl
7]1dWj6gORHpoYR[Ko78>1jHM:9Mm0FEjaW2]l5<@mCIT9BR9U8nFkjbCZRkQ]J:
hWZGlTR?dUU;LVcf_UAa]ZW1K2fnfPI=>Q2Yd\kkqk:UeP9Kc7HbhPj=1iGT[WJ7
D`fCOjKA\T^N:_@OIhYm2lN43e>nhq2K3]em<p`[Z4fJp^\>RZJqo`W\;U_q`WaF
[fNiT\h_E`LC1`oDPShMa`^2qo_DaUG5V__2h1g8@?8cni[GE^?<7_=eWhO_@_J7
N@m7d5WeH7IE\XTOU`Rk0T`X\?cqRM`AC<IejIkF1NiOjRGnASb0qnIBnB`<UHAD
XgeZ@W<l9C93EegqN`B0^b?qQ2dMQcNNd0=HE\IPL1JhB`f@IoKUdJk@1Za=lk=Z
=K8OUdoGa;528Egqke;@A]ApPMge:ghgiJ:h9FM`\bIJV3jC0D1DOl?@<hD:E4]I
R69DqoLFH8WaVaQ51i01Tm<MCKX;20OfoH8ba1IKZ<K21T3>gI<YehUhd[k^nZ7:
GhC[DqlRaAG:nMPDdoI[OgMYMhcTR3FlHkqLa>Y[:7p7MXK]DgqGZlM;9cpMQ7LZ
ELpIg:@3BR3>CcFn8IH2SF?A]q1h@eAe7:Yc4gTRZ;=MaPJTP>27jW2H4q1Pi]Z5
Z3Q0;OgbXdTZ0?eEnbXcFqd?_B<66iC@C]AS59QJ[AeE`Hj2Wj29^QpL`_fZ2JVc
J`;Gc[1mgCle6G8[IH7=GpNf21FC7@dn:5GXlLYOe4VRB0loJPnod7TC<0C``_:>
go\F^=;Pb7Rd;28PKoN3?0fI>n^]QMnmqbk20n6Pqdje214L@Ei5@D^YW4Cj:?Rj
;_ZJ^[k[c0g^:Pa16Q;<B=B0PZ@ULCm9OZBn[m8I0pOGGDLAUqm;4[7oXqXh8QJ7
DT96:jl8c=<^936Dqg>VDjiic2dEe61GZn9h@pP=nblTJH\TZEQ7Um`]_me^PcT5
FAnj43eFXGRW9>gEXD3WqZh5Q3V5qPD:B9Oi6eZJ?7CQPHHa4kU;oBXoYTha1L@A
n:K=;QNU?F^A4;7Enk>NJ;<?P8LBCC_a6gm2Sb<W^JTGeES[Kbadmm3`B]]nai1i
VjSB@`EMdpee_ichbARR<4QTmSP>JqN7kW_VIdG82EN8TE61HI\D3h7URSSGklV7
4DKFf[I0APIS3PIbc7dUF^0^93;06kWR>5`V8WpAJbRULBqCE9XF_C>AfQmSU`HN
PcP7n0W3:QoJ;:<pkce33l8m6L4LRQO:d9>o7:Lcm<dWegC;Och?\K?jUMkal3EU
5EPC`4GbMMCYJ`=obm64WY]bpEMTZGC6qg:neL_UqO:OkiKeCc\mTUFh4>K2Zg::
Je;=;TnqfVVhT[UfI9eFFZgbFR:N?AO;>mhPQ7[5RoMZ7WGCd4EADRf;7QIcVaa0
N48FZDMh`kGnb\]Lj_V:]ocQL4p;nC7BBe^^<Lj?IK=3c2qPC[Mho>p]58b>7i0N
]gDDh0_S3h:Ae80KdCcLmq_0O;gXRpAi>J?_ae4TPL=\0;p1Kejl8Dp_2_m1JIP@
J[Y?R7DY^d2FnOAhOZGp]mm2ceJ[B\CDh?Eqf28mVC[IYdXAY_1EaX:OpB;BFo_i
YSVZm9L@CJNmqF`fWFMg652OKn0jM1JA5pRbkPR=?OVU<:YlBlC8^dcDJ=U8>m@>
5:@_`;8]8mD7cOmK5?q`K`;IPSp>PKRl\?Si`go>U:@H74Kp=SXa4>K8BAnK[\WP
E3SpDUe7<;aOcmdm=lJ`U]D:pB1`IX_ITdbETfkba>3Lme7fPGNHOOSX1WAMJ8Y1
>f7b6Mb6Fqj\SDE@\=]UjW`iC9cG\YPNnOB5Oc<8b]NLSYLhQlK5O4JBi0pMMFgO
KSpaQm?k=]?^R>gN79g?9^0q;4RgXEd5kH;?HiLbICXq`6bmJ=Aa6G^TIcNf=Q<\
qlf4F1no50LdlflT247`b<higcFmDjM6foVeMQ:OP[X[3\mVnpK5Fo2ZYq_VOBW8
2<@C?\0ICm;\1_gE8QS?AJM3f[:2SBT<DA?^X?ZmEVJ<MOBIBBU]q1F8VF@h1TnY
<E5hEl5giqg?5k@j7>`aSfen@W5O1pW@\ffFg7\Q8V_LZ\hcPNqYhi2NkFXf:F7m
fh`GSWH`[6DdTDEAEhGo^TFAf3CO3_@^]E;paRWFT^>q6jfTX^aCI?\O[YP5IATB
p\j9i:\^K[5A@DFjR2O^6Td[SMJHcp[>n?kD;?C8gTLjhHi[5N^TR<fGZZ`Sqg<F
lNg4KaBXi``l[AkgWnbcZj<:cCMgM44>TBl4V=ol`=<c@Bhb?2NRcj>hNk=WSQdq
2^PoLTePj2RESjF6ElE=mSUe3k^2K=?aZ;POMJhFmh>XNF]i`lh?NbR0VLjdZ2`H
Z@am16enpcCV3^n[pdKT]\=2RXLYSjCjU;jXVf\1S1@kD1k_VZoHk`hF3S?<@l^S
h[^CWbLl41bcZJ?R?;OpdHg4OZG$
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
_IfmlSQV5DT^<nMD1dRW@m`YIlYAnkIUmJRapD7nZVTNSF;G`L1He7nNVh1UiU?=
pg<omECa>FhniD<;A:ic7:0@\WHF^J_b:mDI0BKqEWQ<APqc^UEkb[baO8J1?8ge
[DGpeXW2_am55^PYU0D0?_XhHU5Kq@DCSf5gXZnCf3JJBoMIOpI?j?>YZc]JOf6o
[S1M2OUikf0XBF3680eWq?KPjbADUkTI3BA;hdbQGWGccAWY^Q5N?GO_91n<Ma?F
lag\TmdT;O?[BpJHFAhe@qnA9MgneiAU[KUYOgCWogJZ6Q^PDU>a_Gco`eGJ7Qqc
Rh5m[o?=?cjDWY09YCQ]M?02GZVPIRYjlCmUEmE2dP1aU4[A]Xm:c4h:CFK7A?88
BPQfl<c0F\Gq_XUWNFF>jXkfT3DkoA0SeP`paeBVJ^>qR[][S?Qm3;5N]RcdT:mG
N`U8JC8g22>p@oLk>44ZXoMYJk;^HD6bJ6JKUfWB2VQ6E:n_U>`>i]eqC7OEBe0Z
\CW\oI:?]^[26Mc_jOE29P?ijfL6qm7H6FlpPB=N3TH^Nnd=E]L`7hVWn1of6kK4
fe>\iTMcG:ZY<Hff5_Bd2i;UW80RiJ1e5QFiUe;lh1O_Z`2HU?ORVd\]Tnhq?Wa<
_UgEO^g<^LM\PX]7U;lMLEWU<JbibWi;p;155\k]@jaeXVUYR?om<1OdPTTkD2:e
V:2o2ojGH`WMma^iKRbaB7<0:obmeKAFn=W7^B_[S?[5=ca;j<=ZqZEhG@m@cE6Z
a:H:03o@B08B2hZo]Q;mQZZ^\3fdJ:;c\@X4PL@^7GRXod2l4l9XJ`bYQ1lMT2Rl
00m6dRj]qhQUOee:_>L0fV5TI@o?4M;U?K^I?7QnKIP00C^GOZLTA0C9a82^Q99]
4P7RWG1GEhG;WiQ8]DS9=hFR3jZq_9D0VEApOMQbWC@1WAUZONRDZ>NWa2NAkQXc
O?Y0<QXC[3Hn6ZXQL;2@^;NJFEIY1FgH\>mSf8dP9UQdNK_qPDdTHAnF9<W9S=5i
<PO6Z>fpmfdGM3i0@`iBkYjhDQ8Fa3djmC^WTC>iGd\c@=;<IL7oNU[S8mp7k2[5
`ip4K3h77pMm?6h8DhYMTE^MfI;6Q88:G5<W:5Noejea92_I7DAKkZlohCb]^QDB
Lejbd6]R@JMD?6KI1_8V1Q9L@>ZF<=[I72q<ESTN^1L2c`\n]UVX7l\8U\?FH8=2
[8KM2TTC=TY^CA2JVW>l=o]WJU?Z`6kdSh;<0ShTRad?VO2S;NY;h@BphU`HedG;
P32KekoEVA>FLAXg@7ZP^Qak:4f;8jhO993<<KejOlhI@iU=KC\:36jBhT`HQg[b
g1fhhd4_n=MnqPoPT3lWd`cYJEIBBHm^;3DhC60O33Vmk;\F_fFnUhkE3I=H:ON7
\FS;Z<7VgB3F[FF4R25KcSJH9@2jR=5>q>H<FQnZqNF73M?:B?F<_DO_R_V>gNRT
k2EC?`KFN;`1fBMo6bO@[=8KLe<lMl7fTL=XogH<:MAR;cZQ=2kFpelER[PbHckE
eFKBojF```0Q6Q1AX=>lePS3_>YQP7\EMJ0aj2F8d<O>?Q05il:KLB_8p@Y`6bQO
_LBL8K>mhl<T_UCIpADfJe4Tqc3<\^1=6l6UjJJ4jca1ZCST0^@P55\T;RGb\G@C
4pC=S0m0PqL;Nc5IIc:R1D[fP8_EbM@2\2:^YP:E<0G\GXc_0>jn@aY7aCeg8U@W
17JiO:_o75LKA_hXTgoca>Y2j:Q634m[3jTY5<eY3D?mjd_mKEL>SL9]GYo<q=]_
YD\3p;WNjM0Nb:BRe]RKfKjdn[A?TQ]QEPb`>>E]KW@8COL37\c>9EC_S?@EP6cf
eFc6f9E9Uq`UihI0hqS]2@Ji[p`1^TR90UYMG?MESbPnO1\ATNcn]k=7nSo_lQ3>
bPqD[jjCk1I]7iNZWhb[_:dLYj9SR<RJQlK4F6GndnFak`XFQ?aMY5\kKbmN3SOJ
Cf6\H^M?M:bZL>1_bd_pd@nQ`?;q2Og=6:pdRTiY3bAn6aR\HhLnV2eqPd9K]R2]
LIFEN`L]R:8119E3lRBcBMEPhHL7`VV2RC>qBbh\IgUlMMXm]dMZc>18@HAcV9Td
k_P03LF6X2?n\nqNRfIoNe;C?AWGlE?7cB:@3l_SCBEAR^]7@HOP^IZPOKqT8P9n
7RLR32EQ5[A\Cn0Bgf>E`lPEiGO98l1oQKkC9QpRbS\PKOo`2Qo33HNi6Wg3Q8]2
PU`^c;=3=DDPa0VZfRqIo68D`XpQ4X<g^S09AQU_^=QJ3]g3JdAWkiB<Fi4^k;WD
k?mmOADaQd0k_YYFk:2[Wqj>LI>RDl7>VPCWV`W[Qbk44O^Wd_l4Hln0RRg8a_Pm
V;7b7I;:mX1VMChE7`pMJK:Tnhp3e;AngqhT4SYnZJ>=gaHO:fjJ\Hpnog[eU6VY
81n<9V=>dl1W;KJ1fM?AVMCW=0mSG>EKgnp5IUE193Bl:KjZ05=Cckj=iSk7O393
fB1hPQ:[[<V1RSqZAT_1Z>EoG;B]o^W]lEP]V[3Q6;DPDW:O[5M:NVToWJpIRNVR
O8MIhU\73l<jBj;H:c7bfFHM?><eUTEJX@Sg1bp<K9E0O3l:HRPF];V@H3>E\kIC
S]W\`oFLJfj2[_FJ_2OMZTbZ26p=]<9[efqOUW]3;:KhRd5=3``<6J@AcS?QnmIl
OeApTTL?^oXpYB22JVW@QCHImgQUdRj==]5mFei\HOj1g>Uge=qCLBSL9Z3;AkPR
_h6:JpBY=SdY854fbZXbie\II6d:3Bq6\B=7k3168^Wdc;V:LUOpUg=S1\cVElHX
dN\T4Yj9>PDc8kpKWN4JGT<mXD95kg36DHSmZLbbbAESJPB^9p<UCS`\Y>Jh3h>^
eGJAmeP>DjekIeEUT=AJR0mYK<ZEM>c?iV9d2fkLQGq:eD\JBSqZ]RY>NiEkKMka
e\6ofO8E8<I[jCZhOCgGf<L<SJ@c7njD9ST[ZH`>PR_?b5\Vk8K\6:io_[SWM_=p
_eMiMBS`[<]S7]^:a5SXjNn1qDa^Ij6]q6eMSPmjD94XcNNZkET2Sq;[d0f2>@>[
WF^F?1HKh3^n<<P>X[I05RBcLlIB_ZkR`f2`F]fKb_JAYb=TY<dDe`>9;eTJ@;p:
`k5Y3mZpBk^_nYd]0?K;iNN01ZbGkl\7q[Do?BY<6NO5dGBmlUGH:pIE@1Yeo;Of
DUclL6Vh@Y_9iD0=Tj:^GcO<cZBm7WkV0GHE2TFUJTPOmZ_JRm\b0ZT5pm;NblG5
Fq^GhgU35Yndn`Joij`>gBmlCf91iGk;T_KdXNoYgn9Op[7iKlk:60Ja0O_<K7Ad
Ho`elMaVpSMeWn_CZG7NRUd684_1GoUi:`PV3MbXn\f[@LXncN@l8`V3O74gF0m:
:g9W1fRIWn=p<^g?ib49q7j0E<2al7@aNaTgAp8^;8KX@j\bQ9NWMdd1nV=?C]]`
RF5nH6>NO<]jq0Q24MKfGp^[i;`UKLq3OF\@BJ\q@UH;U;o2k>Xi?;jY=eaD]8R=
c`\YbF`pGloP`;fdcVJAl4]X]hBB6FC;7hf8RaIYdi^j\d@8fddpo_NG57M9g8[@
LkFWcbaIPJ3HbN^b0\J_3TRmpDTGV6kq^R]d8_E\V:MHA;5NDWDWD^CK@6_oGLQ?
m2<@:Y1RK14CXd7C7;cC2\j=[hRT`IhdVZW\d:=NCSl[iEjSR;IGR9GlLhpFWF@n
9WJ0WJah4Mf?@kU4N]RPUY>XiqBSJHj<:;ZSMn^oJOWFJLDa^7T]a?Mh6WD;cNRM
16\>e=N0@mLPg?ODZj]1TLTM2QP`@f1V1coKGK=H0Q32]NC=pl0nOH_ih<KF_4BD
niO5X`RHj4oV]fbTIX?n4:49J0[SeUPUhh1l7Onfik02D?SkMoOgJKQ;N2Pb6b5f
JX2TeZ2qPRHWdZN1JRBS\JFcibk22PLfE_:BaYS@8g:WGU`C`2<[42OF6GfVORdC
o>0Eg^@UPUW[n<DC[eN[o5bTV1J0q7kd=R`cqS;K5^=9>8CT7h9QF=I8I;b>PkV?
Ja;Cn6mB16`dPdTRX@UfobYY]C[nGV[VNDbK[C?efH;[V45b8q;P;J]f291>J8N<
@[N@?;LY3>qL9bUZGdqTM]<?XKTkjI[KhBX]FRo2?SMT?2hY5nH6mpIQBDcZL]K_
bm_@6?E:Lja:=bm8YM2IN`4XOQGaB>>Hh8$
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
IHE9oSQV5DT^<VIDe>D];<8S>ZX6GdFoKnF]iJGO^ZK8MYc?m\j=pg1l]`@E?]Y[
4K@;WNoC`=T:AO87JW9fd0DR]Z5jg4YB^U@D2?<@LElhlIlK9G:S_Ch>pF_E@Ued
FjYign[ja4>:h6:?1nD[\o`9Y]ToSjX7OLciLfK`[gi;GH00EB>9qAU5B?>qhceU
8_RdL_m]]KcDdgVf@<o^TogpT5XZLVNp^?>oLTf6R[j@4ZfZgMm4M[b00dp\AlHa
KkAQIS=Zn<3lNo2Yb?ShDQcqj1k5_LfqA:214IoD?\M_QPn<66T\hYZU8elkVmpN
bQ@oPSq@8_^;UJS\l0kCmaEfShHHddTogj13fE]meE5^O<=Y>F2VG<2UCjnQk9Zc
YW<cNkqCCZ0N<>?LZ_>@bcRW5ZPI=_\OG7pQ=dcBD3CSAi<^S@CC8U?bCqPaI;i=
:lT=6bXoU@?MAEAfS8??[LfePVN8WO6G=^=;ALj:[Q4ATOf0L8pd>VHWhDpcFV=Z
6k38h]?`V?7Hhd23`TbOSaIRWE@<W^>h=9<@CWYgfL6IDa2ZQ=J=<_2LN[bENf]_
F3Q\gI343R]3\ShN4SqULiCCQFb5j\ff;2S@9g\qQj=^VIBpSQL<CiRY7KV?2JBC
L8=TJN\7LY@JUP\81>6qW\7L?<5\<7GP4?oV`YjYLj7UOT5eHJiIbTgWC1qkO^SW
Kd07d?lifF^>RWCXFBRQO4ca0IG^Id=XB`kBPIQcS0liC2XDB7Wlb^k8@=^[\^3[
h5[EY2?\VULLb>>DL`q`9\l@MLk=EG:E@`nm@ompZIci[==q>M@ZfHBY^ojF=5YO
CXSEHTBem]kXNE[08>MpKU3eDIn]TfeqmIDU@`=7YYT`jG>W2KA`ccihm=D3n?8Z
76OI\P^iMg?Ri69eZL?M=lhXn3<6JcJb\Y`IEM_\pZW;WZ[AXL16]IZdPC@kmo`M
liKc^`jVO]:T<MO1[X=i:m=Ebd=0Ek2E:RVj5N9Dm;KD3qM;0D;bgpSLG:@GX0DD
]K<<<W8fO0kc[m4F=<4kL^1AKYTn@5YV=YJk0qJX<]n5Aqd^?FAWa@>A>oN;dYh?
oO8>9K\6:q`F:>?Q<QA^1=NJ`Wb_O\U<d5O`Y2AJmkiQDe654L[ogC2NXEjibWMN
UoBi3Jnf[qjKBPSIgIm@4J17giN>GV>7pMnNgKhJ?;NP]?l2GR>ZG4D>Nl><1R<b
7HZ<q2BdUaI]`45S6oZTN9hNe[hLmm`[0030Q9e0qUA:FT87?H[bp5a\_8<Clg7_
eSdgBq03\S2`jRUm@`ZS@dBI=aV>^ML73>HSM]=d`>:Bq9<bEFOd\LXhg[;nOgMQ
MjAj]\a7AET0EBjoMD8TM@@7f?;gO]6oKAnabK]4Ma;VJMf37AldEhnOoYC01d`3
HWk;nXe2qXQJT_N@N8X[ZZ\:>U_I\B;3_0AUeL1e>MeO^T=h:pOK:ORi@@l0E]9`
V@?9ihkZNNm_3hL]?MO^in6`m0ZJ\Q[j1S?JDMYb[L<b0dVN`c[o=Nj4[E`hPI@i
b8QJi0jh]eK78p8g7ke:CN`jCLQY>n[GEANQonW1JjTdf[@^AMe52XF3q3MC@04H
p0[RYMi9ph6UVWFELjOgdmWH\7cpTb`YiT:ecS]fDWX3KQUH;j1iLB?;W@oW<kPa
=WmNeKfbiRUf[QU4L6=CcJ[XR\h3@KjaqGhWY9lBPI2=ooJR6A>j_jR<0cG^7;0_
b]mqZ7d1@mN`NJh<[6[g]oX3ke`IZ9mQFlC]P\[LBdY3P]P32379hJ<Knb4ZYT8D
kPA11:lKPAl\B`ggka]`?^<X1[W8T:FCd7P\KA12\hPpeSC@EXJP;TakWmm:jo1\
\UR?X>Qcl@4Ud?QUpcg^ggJ0]K;\1GA`GOcDKC1QfBILFBLikbHdjRn0YE>QLg?X
lGeCeG`m?aRW4O4G;;ZL`Nl\NDXEfHk<M82fjJMac`7]i3aKW3Md:Lb2q;79Q5Q>
?8m><cg>c_UiCImX<k4TPVWd]V2l=p;VJQNbHiVOGo2ZKb@^PIBEPV9fT_S4[:MS
H4:JKM3Kf60]\Q<b@]lPh5\JY>GGN_S1B?7\Z]CK_WYAC8;TPmh_`i>2JWCSIm?K
_QiB0pdZ3R]IAqQoA0PFc4aGoUTMG:Z\q]9d`cHAqJLD]dR[eWWQ@EPH\NI92Tn^
_AMPm^]DRQ:ZaCHXGYkS8WY7?ohYe4l[lhUbGhdFa3bL]BoVkE2;_CXPm7DHpA0E
5AEapfN6^HTI_ha9TaVhbG;7d<SbEF^TSG9Qp0IHok_jqOhW61eVHkEpH`=UPTY^
P4e1Mil>UL4PMgEDZ@=[D1n@kWK@]m03L^HTfP>PFWL=>H=[Te@KXc46HPIRQ[Lb
K30PFD2L`5?8lnNG@o8hVap_GX^NU^AVn2P\U0X;3p[QnVFJBB0P^1kCC8P`DGqM
J62]9=qH0ObDc?NVO;XP9RImA2?:ZIoTL[TDkYR0;_WkZ;8l:67n0:Y`Ok=Wlqda
l61B3p=RcEBGpoZbWL[E7GHiF@]_HgYDB`UIg<2iDi`]\T\5pk5?hKWC:Wm41[EN
`mN1]MNU49<AY>Ihn3GS5jYBmTWaO>9e5XYERiU?H:J<7YmM>k]?9bLGLfa\\\<F
]pS7G3Ji7g]N<:Q3JU^e24^PN`h`4iL6j5RZ6^aP_PP=G=i1[7bBF3gW;\LY=\iM
E0SgG_G;lU5j`3pUYHn51RBa0JHW7Rd<fE_ENd1d3V:;^aQJV?2jF?VMAmY:jQRb
AfZ>6A1lF86fd^GULH>l7nLN4d9qm]LISY]c:V2[bjVd^ZUF1<knk;@acgiEmZ:`
BO^FQnR2Z[a8d3dneC41Y961X<eG<<Wd4WZc2K;p:fXhIki6mWl6;1<`Zd]lP2EI
VPgR?:I_RgnNHm73ZJ1O8l]G1A:@U0d0k2bJTO\hn_kQ^^G8f6qekCPc\1qB?Zbh
ncqcAOO2e@eYVnN^UKm@GY1=2<kn>pVkDi3@6<BQVjbnCX^9:_H1WlSGl3IEbCpX
E9=ZbR^HDHDCl7e`O8hP9kkYUc[8bLb>gDp=ME>FR?B73cklPkIG1RmWURaLU>cJ
l<=Ac3IZQn<?1Nh1\WpC\^bh6$
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
mJJ7FSQV5DT^<HYbieQTfddcGF<m>]DLN@XLS:<mMXHW5R@ZRki\nShT9lO\JKWG
4PGqN40nO?hDVUlM@S<YglHEecXNV]Vj>IbDFlab3B]YLI`M=c8GHeL^8R;V^?q\
hcB;Imb]hKC]:8VK@jf3MpN@JoKbpIa?LU8Ljb37H7371F[X48WKKU5W2B:ijh<2
\Ci>J3dq9PAJ@]Gpal6^B:MMk4jX96`2I0QXH`GRZ2SiE]dac;TSbUfon6<qD7R=
<D=qj2>Bm8pllSRjD0FV^B_7f475\jJN[hLSh59FAbjnXYJ4@W6AW2\mZ5i[eOAc
DR[d@\\<G>=fH4PIlPBV6ioQkM<IHEMmD9nUB8N^?pNiG1f@jghW0DkDQl2Ig8aX
[<mCH2SidU[N:MkQY];ESgd4cDHi:BYO=EfYSLBoDdKmbQX^E[S?P^R^Fm1]ja=>
NkG9pVAUMa]S?KSGW>j3A2Jf`cHmT;a\?TP>WL[j=]J^j]k;3;Q>ocC6eDR<g9io
4eAc7leG^b`;Ln5hnnc[;1^G06]4fRSpJLH7K?fYXh[?6^9598VNFIAE2[QGBRiW
>Zd]0XRVp]=;UNBXOSSX@hK5C?@><MVYgD66<^TUfgKXRkWn^fQFBFU<:Ymf24\Q
968;]>d_bh0a4E6cZ1n6D<>JZ5?A44?9GqUd][lEaqUiN8mA12HgFaF:bjFFX_QO
CmSWKVQ>8bhimaoh?Un99^g^Fk[65X0Id<\LcLMR<eLc]001jAm?7c6mcP9meHd_
eYKImYhm;iKApd4I>>KD[U@Q`\\4=Y8DRq?\cQ]GP6:CP=K3?=:UaN25qOJ4kJ`f
pF\6>3?p>f7YJB2h3f\Ac32f^mEE;:CnmG?efE5d@HM2iPL2bmFa?dQJZZ7Q^LQg
MiKE>UQQZkR6G:K]KBPQM5ikF03CS^j>NGh=g[j:IVFQ<f`;X1G[e`^oOWA`;n91
gK3mEIm>>KFm]_hq6mZKT2FP]`HKNiN\8BZM`=Ue7L1]2RIV3GWq5Bi??Y@]`?n7
^fBiFDN\RdSf?<daUYLo6L1RmGngEWn>6EL1;h^KDn0I\BkGQCg`[nPm8fRELLSd
Bb4ha20Sn1GL`1qaK`X\>WU[IEY0GeUo]Z7?m0kDN<g3SJFoXAMD\A0NAPH6ekA`
STf]f<oa0eT7a3Do]5biZlIgFGmiEcBDee]Nli8<7q4YL9EP[0gI;EJ_oPY9c`cb
LWAG]58?Ya[[H7Ki9lA24WHE5FP[HlQ\WgleffX7cZfT]?98A4L8ioEX5Ha=@Ojj
8X9XqBVbFXV>D;?g^@00Wk_E@]d=Zc`_K54BXcO`]:4I;[nc4oZH@U7fQGT8ImD=
TO1f84PQB05:Aa?mjPFi>1Ye<W8n__kG\BkMSnGqlWh>4nJ<2ZlNLe6YmJm9On^J
LIQ=jdRGWg68lg=Ha3KBOJ1qUed=oT[Ik[30kN3I_iIR80[1RYI5FhE]P\c?EgQB
aIRm9?pgmQP1hEi4LiJeURLJAS_4kpTi:hE2iGBRh;Ia=e1Ue=;3@Q6o9AI?;3pY
UV1I@jBJNHc_VbUXUUl1PT9X5b<pjAVb[Gh18Bn9iDGFTn0D3Mq=iMj2G?FH3g]o
in1[ZhTV>;D1`oV?YKHBm0LY6;UCf_SGmXaQf1BbK]AQQmW\9oJKfZ29@:g;E]6E
Sn8[CTjaEHq;T4eBm2p`>o=UYop346ScVmqaL0ho]Tpe]9a0bTF5cZXb;12X2RR?
h[HFM:nY40\<nKc?AaWkTkDH^I0X@k6^mgV>`iK?X`FCbHg6ik5<bH3]OnM=F[9G
lCoRfiC>ZV=I7q1W;=^[]6I<Y^hUK3Jkq8B[9fc>pCbI4THJL7ZR>S>W0\ZR6PJq
T_N^;][p?AFgb:QeCH5[5c:1d?bAjYE8^^<ho:BF99o@YmG9LM_Th`gibR2qWjKF
AcR5;Wm^j3IYLhBPY1X2\LJ^EJ>JORoqj`BW43oMd;5X8g[CJ8]jPf@14dZM2Ran
UFcplTYB`:q4c5jHkXLXIJIRZ2S^SVhpdB1nlR8UEATa8neGkUWR^;bDPK`LFF[^
caidA\eN1Iqj<4N?j=F<JFjh4m^6DF1O:SYfSmIlAe0[<>>?Ei=hHaeNnHiF29@D
4JEm<@8]fcdl88^pjMHA5F[no::]Daohn]8BSO6>eT[gKOHWAmIS[R;2MgpCj0?I
olLgbOKM3HTP8eWPgBfmA2ekUO\Fh:@I[P6]>p?YLMg<Lgc0nOfnPTlYmT8fZO_Y
YPjH<WCLF_RMN?cQpG6b4mNWpHI?8O3BqQ5h<4BbO5SHW]GI0I35q`VWikep?FKg
m\iq>9]6^m]pje^PRMM[;0hYGCUJDK29XfI_RDPmkZIDkkJi5W:U=i6M8i>1nD<m
qR;W=T0Po]7]AnHET:9loCjH6[na`F@eTITNPemBLTV5HLN@`94>WC]W65QnkH^q
=Q[a6F<qckTcjC\O\U\0aZKI?S5a_=i0QL:2Zo>4:TFNha[cS?UU4f=IV\]Y7J=q
jl=JW^Tp1Ub0G=gVIne4p;:HYB1\ohn^8J6p1B4XC189Ml?JT`cS^QRLPNH[=U1b
ICqFD7mk:A_>7eOV<pH_=00TV9DEBcS@dh<POGEfL5ai]55=XqBCenU=0:5>_2Xd
KKe@3G6oVeA]VlD7pS\<_TQQU:HeXHDqI_Z;g>@UkYQAoC1d4GWC_F5oZ8lm@[p8
5E<98d>Q78=N;qjMg^d_;;F2Cc_0=IF2VT_;gD>TJK2dph`>V8Yd>^CqY`aoja_]
Z6=^ScckgSoBSJVTRjlD0FfqTIO;Rk_qk[@6Amp2:n>9c4^Aoj4[Scp\:36F<L:@
[NF_SjM`nfMoImT=lBQ=bOkADdHOS2h]?Z_:]:MdiSMNZPeV=P`\h=<GIXmg_^W^
ihVUXo9XollGe5EFnLZ?4chm>3OHLDPV>^Sl]h3QBcWp`3n<W<Jo?BHnk22B72fi
3kbK?30B]384]NU36mYWPU@8eOC95GSA5T1M4M=\EJ_7JCBZXbcV]fgUC1doTDq6
hl3>D9T6g0K`]6BG`7K`\_[Nm@94Rcl`i[Hm9[LbBghPN6T:o@E^Ej3A5UkBa:UZ
=>HOUIl]5ORlM7NnRp4CmE21T@kk0S9W=2FAJO>a2Gk1h<>SMYAc<log7:5K:MfA
nYg\UBXNnPM0g7Nadd`QDXZ4BR22_1e0?1oDqImacV`G?JLW2o`a_MfA^JGcGd4E
F`Ib?lRPk6ZbdH4?NeKN5aRULb=;]XIi`qT[1lK__p>l2:dW2lVaRAK=NJO`1BN8
FEH2Z`5g_YjSWeG;AZ5<0Ha^W7a]ld93P7T`f5OUeF`TlL0eb:m;EDViemhCkf=c
9gPjb=kX6Rj2f0p=i`l1C<Qj>gV?5>BENP`2mqKPcJ_NGpdFkaE8p1@cSZ6G4Ycn
327@2bm@LMk?K:nm\?nP@>Wm??3?[:SW:D>@6F2ho@afn6^FoCdZC_mX]=3=lYYH
_:dD\T?60MmRl<nlNW0UTFkOi:_Mn5Q4@^RKXaJOKRKJU5:BmCeZCiTN8hQiK=nH
N:[Z\Ebl>qAB5gfg<R[m8=Bf\oc9cndG2Q3S=gSMRFJGV=i_LB<fRSQ7_1hIJ`:d
0;khQUA[ZCW8bELJE5mXNm[6JZJ1pIU8hhEjm48AiVoUAhE4Z@kjFQc54K>_G4QE
lAEenGA4_@>oaeTal?GdDg2MW@=KOdo7fd<5XL3jK38H[h>pYVikDaa_568:UgA=
F7FYeWNdNlqFkVT1CkSDa1PcccTDfMZ4BY`OFMiTegPmhPYIZ29>^[[nSYa1BNV[
Z^PNf<ZilZni@j2IEU2?DZ5Xn\\PKpZk7A>CP<JTQMc;ggo<MdNP^W:2=EV`Cih?
lNn5d1[LKZi7MZa]DMWj3JAjV[nMgI9>>3D>[DVdA6AVDGk6X4HHbcJGT7fXFbh2
3Nq8mOTS]1A<TDW>j]OK`Thm<41M4nP9YC2mS=TG^qhI@F8PBKZ4OFXQg0aBDACE
XV6JjkV>VDqCGK16WKD3hPF`LKIManYXZo0f:5KR_P:>mL>AjiFIYnqEd[Q6Qqlk
Tm3j=^I^L0q]C\a3X450UhKOIPTOj[\=aE1jS\\hZb0aEo?6D1O9DpfVXLM@3eLZ
G9kmP_b@Xjk0]L@kiV:2:`=<4_:GeW6ap4T1m@;j3dWYk:86SDmFS:JpB7@fW[Aj
joeHIgL[fP9cmWdf1MXFEWkbng^[AI:5BkpFMo]Lg2TDNhj@6D3kEG<l`Xjd]Rb_
U^n8RnN7PNPOnp\Zh5PLUqkghTVhFe[[TbbS`DUH`T_DE1_`lPmMm[fj6aGPp<GF
A=4D1^9T\M]7P:Z?CLh3Xh5=P:=0`9a>WGmOVeW0DXWWGK7R15_pIlJQUaDpSCi4
b<pYnP@>8=01a4f2WHj24Eq`lj`Y<2l>79S;KgINX5H4B8LKBbmkAC1_[_8me3iT
Wdk4T2ITjP\l9DIojabH?mF4Nk;NS_>:8]L5bn>:lXJ1J6HnRBqh]jkULTp_6gI^
:?jp6BWKdcZV\@I;jc1b5ehpETGXF[O@gB6Kc60P7KL;_n7W44GO?Ci;q2:V:ml:
SjTX6PjUj:<YA]K4:OV72=ndBBfVgMH507SAE?P?`:3SWQRd]MkPPm:RK`1BL_Hb
E:ATSnkXFLYnMc\:;6A7eGm`^K@pTU3k>62p4_]XQgglqdaefUcmpSlocH_lp4aI
5PLRqgcieCaehj\8U]Y`\j_6ifXWcT6DJG[EXQF?U>l0AW6^5X6@A5d<5<_;=2eW
g9cCUl\Y10R0>R_EU;QZ@d\Tb^WX]ncA=P03ijLpT<bAifjqoZ]eXhTI7^1b0jUZ
4Y;:g?q81R[:KoW@VGHPg:Ink^;20nJT6dA@\3IdfK4che>FBP8@1p0UO9ALOp6N
SaS9ALb<B4RXGfRl?lK?SDmn4;=HBnf^0pgdNaU@TlL=S4N[AP7]I=\@\P`G<6W>
IP<3=p[;>JSj5q?Sk9Z6m>::jaI9_AIR85\3BH=U_n[^q;_C4D:o$
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
jaDL8SQH5DT^<h=`7m]\inq9PcDEb];4Ah@H0Kei@7i<CAgeL9D>W>2a6]VhjhVf
_\4=5qmeQSTBT?FjkJ^icO58BQ]M@>^hcf<@m24BW`gdcKLj2H<m][h1pbiVP91p
LCWHPT3SJJQP\0kfeOCXnFFTC8UTIof:p>BkFH`]<fSYNA0nILMe?Y^pObG>V0mS
MXfWA?OZQD:?piM5`]WDHEcCe2N[c?<\0iW:Z6SS[RhIWE7qd9nCl=nNdlI`o`UZ
I<o1lVU;EU@_7RBP`0fGp=doie65pgfgl0_deO`L1YFdaM]a_2W\6>L09lXj2HVV
I]Y?Ln^c>7VC>RdEfVKZNg6ZK0ij?p`K74V[h>9]WKCJ7ARcAi2kA>nIS`b@b<<m
]P8TTXWf[WHXW_6mO3UV=qf=fO\aLnBf2F@97:ei_cXg1PeEOZC^8JRNKk[?@5f:
N?NXmZpjRmSj5mGkiXUClnJ@9i`>U]RjEW_RGT^5e\`g:f1B7HqoVQZ\BSq`PJ]_
29TINgAEHe[Da4X:<>WP@k>nkJ_?91FA:?gm`COA9[1Sje1?Y?7ld749a92OJO_c
:A8]ed8[AidSoFWE]pnE[KPc>qkBWZil=N>@UIQ;d5aZNTQMV9D12=5D=LXlTCn]
@ncQ]Wm:^^n<YajW4ZCEGGCM?1?;V6DT1pk\MROdeREE]LCWB4^6fE<R>f2;7]2D
3@pZff:d0Dh7;ao;LKk7CIPf0SnqeAX\:9cqo>bIo^=pOIHB6R5O7_^BlB\T:=_A
1YOgBG1La0GLXQ2kDQqWl9=Z6hqWW9f6d=d_[g0^:?;;LSogfh;f0e99Jn32^EFA
`^dmROJRBATn07cc6AqTRU:1^JKWX9_2nMmHaFLIGEdkGU7KYF7:eQji[>M:eUSO
HLg73;]Xi1<BAo2iNhp^Rn@6iS46`XX@T9LZ_`W^GN2GUW<FH^:WUF9?3<R1V96]
]N;qna9o8Gi5O:mDnPKf_gW1<I=Q`G>h9Ge9Il[C=H;W6:=qa<IfKYJpKNZjcn4M
3Omd5>bi546Q?`InAZ_f@dk`Cg_a13Ukhf1Lbj^U9T^TVY^9h5nmWPMhSATjbdZ6
b\?JCek\EUY\Of<pI`59<1Vq__:B5h\_c6]YI<TgBn^Z5G:A1BoUC3d4nmUHk8D[
JVRa]U2^hGaK9NPXiDWi;CB2VVOC;^l[FiPAl84LX?[6q`inQLClkji=bG@In[h`
1]SbFelcaBG1?Oo`pNTh;E17iUCllS=O;oB]flj^18GUFSjoO5m[Cb8F?[R@\8lF
TM2ECf;Elg^ic=SAQToe<lfNJUaEO4np`i?l`fGqQ?96<Tl6bQlg8^QWoUIR;P@3
;4=B2?F7o_<M7O?dII3Y4_Lc@XRV6[32dS4n5S4JK]MqSP^K;n^?3_nkk4ldIFeK
p_[m_WmZq]eDmPdhqE8gHd0eh6UW:OgCNk?U17J_a8kl_Pb`Dn6q5:HkKm[LR@Ga
U]KXmmLo4hhT6NpiCS>Fa1q2@J15F`qXV_938Pq5nHQdlIR6aY5LHMh830UHM5_d
^p^CEF85OFNAP>IIe?UY6oamPC]0L`N>En0WBGi1G?qGN8YBEDAQh2:GQVC:hb^H
d7Lc99oJg\ZYS\WLS52Am^Cq3<FRZ5]d@3PRCg<4LLe?L=QA9S^\?4O9<jJ5B3fk
::=G_U8Y0X?m]XmUq2jBZS4Kog>Af`^C6iM_;NU?LS@A=0C7laHk`X3YQkSCZVgO
ZePjMG_kTnlTbpD\3jEZ>p<3^>>b?^H[Y7Z1X:Kno_NGPUV2npGcCMA1LcMWpc^L
HBd3]DNS51:E]bABGD]N1RX2UeW308^Z\P^B<lhC`E9gTp^B]9=PfB63i^GdM9eD
5^8BG^AORSZc25EOH2n`Cm\:D1G><^>fYU8NH=bjFUj>:fjJWg>l8pge\]\:mqHL
3Y^QqmVck1X[bM?N=De7SWjRJ>3?bj11VXB<\=\7LMC1;Wl\ZpDQNZC7?lMLRPXB
j@XWBE]G:=J8WIdW2UO`LSPehlIU[?qHcEb_K6nR:_XmN0XM6607Kgof<JOG`dG^
n9I[9mAoVX`j_\b@5Y6[=VaqjKGjk7Te?WYhib:iP>eTanp[2Xi5;M9j\1@A^^AU
jS0iL1\M<PgUg`XKJ]WUh@NgXPJV[iME4QQ\0Q=cS_bpe27;0`Wq3Nd\16=o\[qF
6RF3XCjNG_=951__1B^>0^AobKb`NB`EY5>g>N94Fn:H5CI[IkQnkX[D06\cRc[<
9Uqc=H<]U[>5Mbb5kWA]>cVb0GWRZR`RKS_?d65XleB3:L2`gfY6]@eqQ16cN@6k
hjGn9fijLlYOdB1ZmQ>jaMTn2;0ol:d>j8lmiMJ3L:^4YZ>n6REMjkh_Q6Pf]Z[c
0Q:q3NPnF0^pXE728YQ4D?Wj4WRW<`q?<DXB1qGF_XP=_kEkl^?Q[50:U:HCYFJQ
f3;VY<P<ddQMbE_N3`pNl[3QRJI::QiWWUiE@OWJS<1C`9KC\7`:T:8\:X70FMVp
[T]PIDPTZi_<n1]\h>LEi`5m<P94CCodaH2<Mm2Y`@hghC:J5U[Q^1lKqk3E^<OA
3Jk\7Nce7QO>HgVkflkl0BOno=Lli:OdQD[IYA\GDdYJ6MomjUk>fqZCohR:Pp]W
YYfbPEoY5L>ZWO\NSFOFPYkJiTbf7\5R_T]gJ:X:`hjN[p2MlfL[ch2Wp^A_U1?O
j]4AO;`jeUn1]WNjkTAG5>@aWGl>\l6cbLADHM3BWU<D1q>H5U4bP=F_cK8`]PEY
I1WKT_a`2Wn?6HO^f61DXj\2Q:foL@?TC0EjHfh55Q<RVSjYeoK]W]AbIqkm6d<J
Tpc4B:g6$
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
