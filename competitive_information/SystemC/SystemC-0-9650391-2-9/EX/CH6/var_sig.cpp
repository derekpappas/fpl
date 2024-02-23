// Copyright 2003 Star Galaxy Publishing
// File: var_sig.cpp

#include "var_sig.h"

void var_sig::var_sig_1() {
  bool qst_1;

  qst_1 = tmq;
  bds_1 = qst_1;
}

void var_sig::var_sig_2() {
  qst_2 = ! tmq;
  bds_2 = qst_2;
}

void var_sig::var_sig_3() {
  bds_3 = qst_2;
}
