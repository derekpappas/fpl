// File: buses2.h
#include "systemc.h"

SC_MODULE (buses2) {

sc_in<bool> a_ready, b_ready;

sc_in<sc_uint<4> > a_bus, b_bus;

sc_out<sc_lv<4> > z_bus;


sc_signal_rv<4> driver_bus; 



















// Resolved signal.

void prc_a_bus();

void prc_b_bus();

void prc_ab_bus();


SC_CTOR (buses2) {


SC_METHOD (prc_a_bus);


sensitive << a_ready << a_bus;


SC_METHOD (prc_b_bus);


sensitive << b_ready << b_bus;


SC_METHOD (prc_ab_bus);


sensitive << driver_bus;

}
};
