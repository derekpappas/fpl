// File: case_ex.h
#include "systemc.h"
enum weekday {sunday, monday, tuesday, wednesday,


thursday, friday, saturday};
const int OUT_SIZE = 4;

SC_MODULE (case_ex) {

sc_in<weekday> day_of_week;

sc_out<sc_uint<OUT_SIZE> > sleep_time;


void prc_case_ex();


SC_CTOR (case_ex) {


SC_METHOD (prc_case_ex);


sensitive << day_of_week;

}
};
