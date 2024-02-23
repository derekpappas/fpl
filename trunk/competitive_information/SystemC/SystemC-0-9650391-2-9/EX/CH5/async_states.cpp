// Copyright 2003 Star Galaxy Publishing
// File: async_states.cpp

#include "async_states.h"

void async_states::prc_async_states() {
  if (!reset)
    // First asynchronous condition.
    next_state= 0;
  else if (set)
    // Second asynchronous condition.
    next_state = 5;
  else
    // Negative clock edge (implicit).
    next_state = current_state;
}
