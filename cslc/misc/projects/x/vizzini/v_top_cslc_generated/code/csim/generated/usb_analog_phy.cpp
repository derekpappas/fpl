#include "usb_analog_phy.h"

namespace NSCsimGen {

void usb_analog_phy::defaultInitialize() {
      //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void usb_analog_phy::connect() {
}
}
