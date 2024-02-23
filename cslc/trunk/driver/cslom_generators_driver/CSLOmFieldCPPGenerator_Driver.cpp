/*
 *    CSLOM_FIELD_CPP_DRIVER
 *
 ***********************************************/

#include <string>


#include "CSLOM_Field_CPP_Generator.h"
#include "../support/CommonSupport.h"


using namespace NSCSLOm;
using namespace NSCSLOmVisitor;


void CSLOM_FieldCPPGenerator_Test() {
  std::cout<<" asa ";
  RefCSLOmDesign design = CSLOmDesign::build();

  RefCSLOmField  field  = CSLOmField::build(17, RefString(new std::string("test.v"), design, RefString(new std::string("Field 1")));

//visitor\
// FIX-DEP
//  NSCFieldCPPGenerator::CFieldCPPGenerator * fcppg = new NSCFieldCPPGenerator::CFieldCPPGenerator("Field CPP Generator");
//  design->acceptVisitor(*fcppg);
//  delete fcppg;
}

int main() {
  CSLOM_FieldCPPGenerator_Test();
  return 0;
}


