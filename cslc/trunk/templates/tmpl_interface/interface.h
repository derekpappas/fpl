//interface header for template interface

#include "../../src/cslom_generator/CSLOM_VerilogTbCodeGenerator.h"

using namespace std;
using namespace NSCSLOm;
using namespace NSCSLOmVerilogTbGenerator;


typedef boost::shared_ptr<CSLOmVerilogTbGenerator> RefCSLOmVerilogTbCodeGenerator;

void CTmplInterface(RefCSLOmVerilogTbCodeGenerator &tbGen);
