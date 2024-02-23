/*
 *    CSLOM_CPP_CodeGenerator_DRIVER
 *
 ***********************************************/

#include <string>


#include "../cslom/CSLOM.h"
#include "../cslom/CSLOM_Visitor.h"
#include "CSLOM_CPP_Generator.h"
#include "../support/CommonSupport.h"
#include "../csim/csim.h"
#include <algorithm>


using namespace std;
using namespace NSCSLOm;
using namespace NSCSLOmVisitor;


void CSLOM_CPPGenerator_Test() {

  RefCSLOmDesign   design = CSLOmDesign::build();
  
  RefString fn = RefString(new string("genericFilename"));
  RefCSLOmNumber   width  = CSLOmNum32::build(25,fn, 8);

//   RefCSLOmNumber   noDim  = CSLOmNum32::build(27, 3);

//   RefCSLOmNumber   dim1   = CSLOmNum32::build(29, 0);

//   RefCSLOmNumber   dim2   = CSLOmNum32::build(29, 1);

//   RefCSLOmNumber   dim3   = CSLOmNum32::build(29, 2);

//   RefCSLOmNumber   expr1L = CSLOmNum32::build(29, 0);

//   RefCSLOmNumber   expr1U = CSLOmNum32::build(29, 100);

//   RefCSLOmNumber   expr2L = CSLOmNum32::build(29, 300);

//   RefCSLOmNumber   expr2U = CSLOmNum32::build(29, 400);
  
 

  RefCSLOmSimpleBitRange sbrange = CSLOmSimpleBitRange::build(37, fn,design, RefString( new string("mySBRange")));
 
  sbrange -> setWidth ( width );

  //  visitor
  NSCCPPGenerator::CCPPGenerator* fcppg = new NSCCPPGenerator::CCPPGenerator(std::string("test.h"));
  design->acceptVisitor(*fcppg);
  delete fcppg;
}

int main() {
  CSLOM_CPPGenerator_Test();
  return 0;
}
