`timescale 1 ns / 100 ps
`include "epromshift.v"
`include "sram.v"
`include "interruptbuf.v"

module dptest;

wire [15:0] data_bus, address_bus;
wire sce12, sce34, swr;
wire sal, scue, scu, sclr;
wire [1:0] sa;
wire [6:0] sd;
wire rd, wr, iom, inta;
reg  clk, disp_clk;
reg bus_select, intr;
wire p24_dir, p25_dir;
reg reset;
integer counter;


reg eprom_reset; // These are used for our simulated EPROM


eprom		eprom1(rd, address_bus, data_bus, eprom_reset, inta);

sram		sram1(rd, wr, address_bus, data_bus, inta);

interrupt	interrupt1(inta, rd, iom, data_bus);

micro		micro1(data_bus, address_bus, wr, rd, iom, sal, sce12, sce34, scue, scu, swr,
			sclr, sa, sd, clk, reset, bus_select, disp_clk, intr, inta, p24_dir, p25_dir);

//************************************START SIMULATION********************************	

	initial
	begin
		eprom_reset = 0;
		intr = 0;
		counter = 0;
		clk = 0;

		$monitor($time, " add=%h data=%h rd=%h wr=%h iom=%h intr=%h inta=%h",
			address_bus, data_bus, rd, wr, iom, intr, inta);



		/*$monitor($time, " add=%h data=%h r0=%h r1=%h r2=%h r3=%h r4=%h r13=%h r14=%h r15=%h rd=%h wr=%h iom=%h intr=%h inta=%h",
			address_bus, data_bus, dptest.micro1.regstore1.register0,dptest.micro1.regstore1.register1,
			dptest.micro1.regstore1.register2, dptest.micro1.regstore1.register3,dptest.micro1.regstore1.register4,
			dptest.micro1.regstore1.register13, dptest.micro1.regstore1.register14, dptest.micro1.regstore1.register15,
			rd, wr, iom, intr, inta);*/

		#1	eprom_reset = 1; // Initialize our EPROM to have some user
		#1	eprom_reset = 0; // code burned inside of it.
		
		#0	reset = 1;  // Reset the IP to 8000H
		#50	clk = 1;
		#50	clk = 0;
		#50 	clk = 1;
		#50 	clk = 0;	
		#50	reset = 0;

		repeat(1800)
		begin
			if (counter == 350)
			begin
				 intr = 1;
			end

			#50	clk = 1; // Keep clocking the RISC 
			#50 	clk = 0;
			counter = counter+1;

			if(inta == 1)
			begin
				intr = 0;
			end 
	
		end // End Begin

		#10000 $finish;
	end

	/****************SIMAVE*******************/
	initial
	begin
		$shm_open("micro.shm");
		$shm_probe("AC");
	end

endmodule // dptest

