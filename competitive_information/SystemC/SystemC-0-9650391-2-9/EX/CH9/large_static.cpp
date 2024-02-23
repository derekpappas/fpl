// Copyright 2003 Star Galaxy Publishing
// File: large_static.cpp

#include "large_static.h"

void large_static::event_process() {
  static_list_event.notify();
}

void large_static::another_process (){
  sc_time timeout (2, SC_MS);

  while (true) {
  wait (); // Wait for an event on spi_clk or usb_rdy.
  cout << "Found event on static sensitivity list" << endl;
  wait (timeout); // Wait for timeout period (2ms).
  cout << "Finished waiting for 2ms" << endl;
  wait (timeout, static_list_event); // Wait for 
    // timeout or an event on stat, bus1, ucint or
    // adr_match.
  cout << "Either timeout occured or an event occurred on stat, bus1, ucint or adr_match" << endl;
  }
}
