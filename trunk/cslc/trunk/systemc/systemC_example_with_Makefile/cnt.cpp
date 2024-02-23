// cnt.cpp

#include "cnt.h"

void cnt::cnt_process()
{
	if(reset.read()==0)
	{
		cnt_tmp = 0;
		cnt_out.write(0);
	}
	else if (clock.read()==1)
	{
		cnt_tmp++;
		cnt_out.write(cnt_tmp);
	}
}
