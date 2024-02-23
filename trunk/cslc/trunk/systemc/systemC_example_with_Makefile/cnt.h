// cnt.h

#include <systemc.h>

#define length	4

struct cnt : sc_module
{
	// port ////////////////////////////////////
	sc_in<bool>	reset;
	sc_in_clk	clock;

	sc_out<sc_uint<length> >	cnt_out;
	////////////////////////////////////////////

	sc_uint<length>	cnt_tmp;

	void cnt_process(); // counter processor

	SC_CTOR(cnt)
	{
		SC_METHOD(cnt_process);
		sensitive << reset;
		sensitive << clock.pos();
	};
};