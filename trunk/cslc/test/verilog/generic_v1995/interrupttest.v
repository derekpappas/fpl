`timescale 1 ns / 100 ps

module interrupttest;

wire [15:0] data_bus;

reg rd;
reg iom;
reg inta;
reg clk;

interrupt	interrupt1(inta, rd, iom, data_bus);
	
//************************************START SIMULATION********************************	
	initial
	begin
		iom = 0;
		inta = 0;
		rd = 0;
		clk = 0;

		$monitor($time, " data_bus = %h rd = %h iom = %h inta = %h",
			 data_bus, rd, iom, inta);

		begin
			#10 	inta = 0;
			#10	iom = 1;
				rd = 1;

			#10	rd = 1;
			#10	iom = 1;
			#10 	inta = 1;
			
			#1 	inta = 0;
			#10 	rd = 0;
			#10	iom = 0;
			
			#10000 $finish;
		end

	end // initial	
		
	//****************SIMAVE*******************
	initial
	begin
		$shm_open("waves.shm");
		$shm_probe("AC");
	end
	
endmodule // interrupttest
