#include "../csim/CsimShell.h"
#include <iostream>

using namespace NSCsimLib;

int main(int argc, char **argv){

  RefCsimShell shell = CsimShell::getInstance();
  RefString fileName = RefString();
  if (argc == 2) {
    fileName = RefString(new std::string(argv[1]));
  }
  shell->start(fileName);

  return 0;
}
