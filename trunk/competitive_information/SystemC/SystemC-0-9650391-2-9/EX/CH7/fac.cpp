// Copyright 2003 Star Galaxy Publishing
// File: fac.cpp

#include "fac.h"

const int TEMP_SIZE = 12;

void fac::prc_fac() {
  sc_uint<TEMP_SIZE> next_result, next_inlatch;
  sc_uint<TEMP_SIZE> t_exponent;

  int k;

  if ((start & done) | reset) {
    fac_out = 1;
    exp_out = 0;
    inlatch = data;
    done = 0;

#ifdef DEBUG
    cout << "Being reset ..." << endl;
#endif
  }
  else {
    if ((inlatch.read() > 1) & !done) {
      next_result = fac_out.read() * inlatch.read();
      next_inlatch = inlatch.read() - 1;
    }
    else {
      next_result = fac_out;
      next_inlatch = inlatch;
    }

    if (inlatch.read() <= 1)
      done = 1;

    t_exponent = exp_out;

    // Normalization:
    for (k = 1; k <= DATA_SIZE; k++) {
      if (next_result > 256) { // 2 ** OUT_SIZE
        next_result = next_result / 2;
        t_exponent = t_exponent + 1;
      }
    }

    fac_out = next_result;
    exp_out = t_exponent;
    inlatch = next_inlatch;
  }
}
