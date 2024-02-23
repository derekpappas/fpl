`define COM_SYSCALL	20
`define SYS_fork	2

module test;
    reg[31:0] data;
    reg[3:0] read;
    reg[3:0] write;
    reg enable;

    initial begin
	#10
	enable = 0;
	read = 0;
	write = 15;
	#10
	data = `COM_SYSCALL;
	enable = 1;
	#10
	enable = 0;
	#10
	data = `SYS_fork;
	enable = 1;
	#10
	enable = 0;
	write = 0;
	read = 15;
	#10
	enable = 1;
	#10
	enable = 0;
	#10
	enable = 1;
	#10
	enable = 0;
	#10
	enable = 1;
	#10
	enable = 0;
	$display("a4 (errno) = %d", data);
	#10
	enable = 1;
	#10
	enable = 0;
	$display("return value = %d", data);
	#10
	$stop;
    end

    initial $sc_handler ("name", data, read, write, enable);
endmodule
