// main.cpp

#include "systemc.h"
#include "cnt.h"
#include "cnt_display.h"

int sc_main(int ac, char *av[])
{
	// signals //////////////////////
    sc_signal<bool> reset, clock;
	sc_signal<sc_uint<length> >	cnt_out;
	/////////////////////////////////

	cnt cnt1("cnt1");
	cnt1.reset(reset);
	cnt1.clock(clock);
	cnt1.cnt_out(cnt_out);

	cnt_display cnt_display1("cnt_display");
	cnt_display1.clock(clock);
	cnt_display1.cnt_out(cnt_out);


	sc_initialize();		//Initialize simulation

	// generate VCD file
	sc_trace_file *tf = sc_create_vcd_trace_file("cnt");
	sc_trace(tf, reset, "reset");
	sc_trace(tf, clock, "clock");
	sc_trace(tf, cnt_out, "cnt_out");

	reset.write(0);
	clock.write(0);
	sc_cycle(5);
	reset.write(1);
	sc_cycle(5);		// 1 clock cycle

	for (int j=0; j<20; j++)
	{
		clock.write(1);
		sc_cycle(10);
		clock.write(0);
		sc_cycle(10);
	}

	sc_close_vcd_trace_file(tf);

	return 0;
}