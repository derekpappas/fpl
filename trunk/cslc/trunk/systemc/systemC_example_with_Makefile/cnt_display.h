// cnt_display.h

#include "systemc.h"

#define length	4

struct cnt_display : sc_module
{
	// port ///////////////////////
	sc_in_clk				clock;
	sc_in<sc_uint<length> >	cnt_out;
	///////////////////////////////

	// internal signals
	sc_uint<length>	cnt_tmp;


	void display_process();

	SC_CTOR(cnt_display)
    {
		SC_METHOD(display_process);
		sensitive << clock.pos();
    };
};

