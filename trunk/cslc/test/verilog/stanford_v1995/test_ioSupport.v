// #define COM_PUTS	7
// #define COM_PUTCHAR	5
// #define COM_GETCHAR	6
`define COM_PUTS	7
`define COM_PUTCHAR	5
`define COM_GETCHAR	6
`define COM_EXIT	13
`define COM_PUTPDS      14

module test;
    reg[31:0] val, cmd;

    initial begin
	cmd = `COM_PUTS;
	$io_write(cmd);

	val = 'h48;	// H
	$io_write(val);
	val = 'h65;	// e
	$io_write(val);
	val = 'h6c;	// l
	$io_write(val);
	val = 'h6c;	// l
	$io_write(val);
	val = 'h6f;	// o
	$io_write(val);
	val = 'h0a;	// \n
	$io_write(val);
	val = 0;	// NULL
	$io_write(val);

	cmd = `COM_GETCHAR;
	$io_write(cmd);
	$io_read(val);	// get it
	if (val <= 0)
	    $display("Unexpected return value");

	cmd = `COM_PUTS;
	$io_write(cmd);
	cmd = 'h47;	// G
	$io_write(cmd);
	cmd = 'h6f;	// o
	$io_write(cmd);
	cmd = 'h74;	// t
	$io_write(cmd);
	cmd = 'h3a;	// :
	$io_write(cmd);
	$io_write(val);	// write it
	cmd = 'h21;	// !
	$io_write(cmd);
	cmd = 'h0a;	// \n
	$io_write(cmd);
	cmd = 0;	// NULL
	$io_write(cmd);

	cmd = `COM_PUTPDS;
	$io_write(cmd);
	cmd = 'h1;	// string #1
	$io_write(cmd);

	cmd = `COM_EXIT;
	$io_write(cmd);
	cmd = 'h1;	// exit(1)
	$io_write(cmd);
	// $stop;
    end
endmodule
