// Copyright 2003 Star Galaxy Publishing
// File: case_ex.cpp

#include "case_ex.h"

void case_ex::prc_case_ex() {
  switch (day_of_week) {
    case monday:
    case tuesday:
    case wednesday:
    case thursday: sleep_time = 6; break;
    case friday: sleep_time = 8; break;
    case saturday: sleep_time = 9; break;
    case sunday: sleep_time = 7; break;
    default: sleep_time = 6; break;
  }
};
