// Verilog HDL for "gates.lib", "addacc" "_functional"
// Module Adder Accumulator
module addacc (a, b, clk, rd, cout, sout);

input
	a, b, clk, rd;

output
	cout, sout;
wire
	cout, sout;

parameter
	t_hold	= -43,
	t_setup	= 48,
	delay	= 12,
	rd_hold = -14,
	rd_setup = 35,
	rd_delay = 17,
	t_separation = 10;

defparam
	  aacdro.delay = delay,
	  aact1ff.rd1_delay = rd_delay,
	  aacconf.t_separation = t_separation,

	  aact1ff.t_separation = t_separation - 2,

	  aacconf.delay = 20,
	  aact1ff.delay = 20,
	  
	  aact1ff.t_hold  = rd_hold  + 20,
	  aact1ff.t_setup = rd_setup - 20,
	  aacdro.t_hold  = t_hold + 40,
	  aacdro.t_setup = t_setup - 40;

wire
	t_in, t_out;


conf_buff  aacconf(a, b, t_in);
t1ff       aact1ff(t_in, rd, t_out, sout);
dro_cell   aacdro(t_out, clk, cout);


endmodule
	