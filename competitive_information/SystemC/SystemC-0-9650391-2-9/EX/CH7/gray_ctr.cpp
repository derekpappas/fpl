// Copyright 2003 Star Galaxy Publishing
// File: gray_ctr.cpp

#include "gray_ctr.h"

void gray_ctr::prc_counter() {
  if (! reset)
    gray_count = s0;
  else
    if (! hold)
      switch (gray_count) {
        case s0 : gray_count = up_down ? s1 : s7; break;
        case s1 : gray_count = up_down ? s2 : s0; break;
        case s2 : gray_count = up_down ? s3 : s1; break;
        case s3 : gray_count = up_down ? s4 : s2; break;
        case s4 : gray_count = up_down ? s5 : s3; break;
        case s5 : gray_count = up_down ? s6 : s4; break;
        case s6 : gray_count = up_down ? s7 : s5; break;
        case s7 : gray_count = up_down ? s0 : s6; break;
        default: gray_count = s0; break;
     }
}
