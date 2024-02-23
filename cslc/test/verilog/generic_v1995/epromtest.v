`timescale 1 ns / 100 ps

module epromtest;

wire [15:0] data_bus;

reg [15:0] address_bus;
reg rd;
reg eprom_reset;
reg clk;

eprom		eprom1(rd, address_bus, data_bus, eprom_reset);

	
//************************************START SIMULATION********************************	
	initial
	begin
		eprom_reset = 0;
		rd = 0;
		clk = 0;

		$monitor($time, " addresss_bus = %h data_bus = %h",
			 	address_bus, data_bus);

		begin
			#10	eprom_reset = 1;
			#1	eprom_reset = 0;

			#10	address_bus = 16'h5001;
			#1	rd = 1;
			#1	rd = 0;
			
			repeat(2)
			begin
				#5	address_bus = 16'h8000;
				#1	rd = 1;
				#1 	rd = 0;

				#5	address_bus = 16'h8001;
				#1 	rd = 1;
				#1 	rd = 0;

			end

			#5 address_bus = 16'h8002;
			#1 rd = 1;
			#1 rd = 0;

			#5 address_bus = 16'h8003;
			#1 rd = 1;
			#1 rd = 0;

			#1	eprom_reset = 1;
			#1	eprom_reset = 0;


			#10000 $finish;
		end

	end // initial	
		
	//****************SIMAVE*******************
	initial
	begin
		$shm_open("waves.shm");
		$shm_probe("AC");
	end
	
endmodule // epromtest
