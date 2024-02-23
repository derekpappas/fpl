#include "csim/user/top_user.h"
#include "../../../../../../../trunk/src/csim/CsimShell.h"
#include <iostream>

using namespace NSCsimLib;

int main(){

  RefCsimShell shell = CsimShell::getInstance();
  shell->start();

  return 0;
}
