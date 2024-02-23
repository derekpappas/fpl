// display.cpp

#include <systemc.h>
#include "cnt_display.h"

void cnt_display::display_process()
{
	cnt_tmp = cnt_out.read();
	cout << "counter value:	" << cnt_tmp << endl;
}


