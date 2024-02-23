// Copyright 2003 Star Galaxy Publishing
// File: mealy.cpp

#include "mealy.h"

void mealy::prc_state() {
  if (reset)
    mealy_state = S0;
  else
    mealy_state = next_state;
}

void mealy::prc_output() {
  switch (mealy_state) {
    case S0:
      if (a) {
        z = 1;
        next_state = S3;
      }
      else
        z = 0;

      break;
    case S1:
      if (a) { 
        z = 1; 
        next_state = S0; 
      } 
      else
        z = 0;

      break;
    case S2:
      if (!a) 
        z = 0; 
      else {
        z = 1; 
        next_state = S1; 
      }

      break;
    case S3:
      z = 0; 

      if (! a) 
        next_state = S2; 
      else 
        next_state = S1; 

      break;
  }
}
