// #define COM_PUTS	7
// #define COM_PUTCHAR	5
// #define COM_GETCHAR	6
`define COM_PUTS	7
`define COM_PUTCHAR	5
`define COM_GETCHAR	6
`define COM_EXIT	13
`define COM_PUTPDS      14

module test;
    reg[31:0] val;
    reg[31:0] data;
    reg[3:0] read;
    reg[3:0] write;
    reg enable;

    initial begin
	#10
	read = 0;
	write = 0;
	enable = 1;
	#10
	write = 15;
	data = `COM_PUTS;
	#10
	data = 'h48;	// H
	#10
	data = 'h65;	// e
	#10
	data = 'h6c;	// l
	#10		// value the same, need to pulse something
	enable = 0;
	enable = 1;
	#10
	data = 'h6c;	// l
	#10
	data = 'h6f;	// o
	#10
	data = 'h0a;	// \n
	#10
	data = 0;	// NULL
	#10
	data = `COM_GETCHAR;
	#10
	write = 0;
	read = 15;
	#10 // need for synchronization
	val = data;
	if (data <= 0)
	    $display("Unexpected return value");
	#10
	read = 0;
	write = 15;
	data = `COM_PUTS;
	#10
	data = 'h47;	// G
	#10
	data = 'h6f;	// o
	#10
	data = 'h74;	// t
	#10
	data = 'h3a;	// :
	#10
	data = val;
	#10
	data = 'h21;	// !
	#10
	data = 'h0a;	// \n
	#10
	data = 0;	// NULL
	#10
	data = `COM_PUTPDS;
	#10
	data = 'h1;	// string #1
	#10
	data = `COM_EXIT;
	#10
	data = 'h1;	// exit(1)
	// $stop;
    end

    initial $io_handler ("name", data, read, write, enable);
endmodule
