#include "output_cell.h"

namespace NSCsimGen {

void output_cell::defaultInitialize() {
      //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void output_cell::connect() {
}
}
