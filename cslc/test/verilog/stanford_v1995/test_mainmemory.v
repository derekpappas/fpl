module test;
	reg [31:0] addr;
	reg [63:0] data;
	reg [7:0] read, write;
	reg enable;

    initial begin
	enable = 1;
	$gr_waves ("Addr", addr, "Data", data, "enable", enable);
	$gr_addwaves ("Read", read, "Write", write);
    end

    always begin
	read = 0;
	write = 0;
	#10
	write = 255;
	addr = 32'h1000;
	data = 64'hf0e0d0c0b0a09080;
	#10
	write = 255;
	addr = 32'h1008;
	data = 64'h1020304050607080;
	#10
	write = 255;
	addr = 32'h1020;
	data = 64'hf1e2d3c4b5a69788;
	#10
	read = 0;
	write = 0;
	#10
	data = 64'bz;
	read = 255;
	addr = 32'h1000;
	#10
	read = 255;
	addr = 32'h1008;
	#10
	read = 255;
	addr = 32'h1020;
	#10
	read = 0;
	write = 0;
    end

    initial $main_memory ("mem", addr, data, read, write, enable);

endmodule
