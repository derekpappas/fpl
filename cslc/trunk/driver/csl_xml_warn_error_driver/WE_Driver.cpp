#include <iostream>
#include "we_logic.h"
#include "CSLC_Errors.h"

using namespace NSWarningErr;
using namespace NSWarnError;

int main(void) {
  //all_errors anError = CSE_CSP_FUNC_FCT_NON_BLOCK;
  RefCslWE errors = CslWE::Instance();
  std::vector<RefString> errVec;
  errVec.push_back(RefString(new std::string("mata.xml")));
  errVec.push_back(RefString(new std::string("10")));

  errors->addError(CSE_CSP_FUNC_FCT_NON_BLOCK, errVec);

  return 0;
}
