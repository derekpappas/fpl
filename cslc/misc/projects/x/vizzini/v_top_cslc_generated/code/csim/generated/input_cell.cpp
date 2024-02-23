#include "input_cell.h"

namespace NSCsimGen {

void input_cell::defaultInitialize() {
      //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void input_cell::connect() {
}
}
