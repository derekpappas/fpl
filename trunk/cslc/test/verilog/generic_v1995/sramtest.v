`timescale 1 ns / 100 ps

module sramtest;

reg [15:0] data_bus;
reg [15:0] address_bus;
reg rd, wr;
reg eeprom_reset;
reg clk;

sram		sram1(rd, wr, address_bus, data_bus);

	
//************************************START SIMULATION********************************	
	initial
	begin
		rd = 0;
		wr = 0;
		clk = 0;

		$monitor($time, " addresss_bus = %h data_bus = %h ", address_bus, data_bus);

		begin
			#10 	address_bus = 16'h0000;
			#0	data_bus = 16'h6789;

			#10 	wr = 1;
			#10	wr = 0;

			#10	address_bus = 16'h0000;
			#0	data_bus = 16'hxxxx;

			#10	rd = 1;	
			#10	rd = 0;

			#10	address_bus = 16'h0002;
			#0	data_bus = 16'h0000;

			#10	rd = 1;	
			#10	rd = 0;

			#10	address_bus = 16'h8002;
			#0	data_bus = 16'hxxxx;
			
			#10	wr = 1;
			#10	wr = 0;
			
			$display("The data bus = %h", data_bus);

			#10000 $finish;
		end

	end // initial	
		
	//****************SIMAVE*******************
	initial
	begin
		$shm_open("waves.shm");
		$shm_probe("AC");
	end
	
endmodule // sramtest
