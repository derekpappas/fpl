//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007 Fastpathlogic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of Fastpathlogic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------
#include "CSLOM_Field_CPP_Generator.h"
#include "../cslom/CSLOM_Declarations.h"

using namespace NSCSLOmVisitor;
using namespace std;

namespace NSCFieldCPPGenerator {


CFieldCPPGenerator::CFieldCPPGenerator(string filename){
  if (!filename.empty()) {
     m_out = new ofstream(filename.c_str());
     m_hasFile=TRUE;
     if(!m_out){
       cerr << "Warning: opening output file" << std::endl;
     }
   }
   else {
     m_out = &(cout);
   }
  
//   m_counter = 0;
//   m_isMemoryMapLocation = FALSE;
//   m_isAddressRange = FALSE;
//   m_childCountAddressRange = 0;
//   m_noChildren = 0;
//   m_mapSuffix = RefString();
//   m_mapPrefix = RefString();
}

CFieldCPPGenerator::~CFieldCPPGenerator(){
  if(m_hasFile){
    ((ofstream*)(m_out))->close();
  }
  delete m_out;
}


void CFieldCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmField& field) {
  *(m_out) << " const unsigned int ";
}

void CFieldCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmField& field) {
  static RefString fieldString = RefString(new string());

  fieldString->append(*(field->getID()->getName()));
  fieldString->append("_Upper_index");
  fieldString->append(" = ");
  //  fieldString->append(IntToString(field->getUpper()->getValue()));
 fieldString->append(IntToString(CSLOmNumber::cast(field->getUpper())->getValue()));
  fieldString->append(*(field->getID()->getName()));
  fieldString->append("_Lower_index");
  fieldString->append(" = ");
  fieldString->append(IntToString(field->getLower()->getValue()));

  fieldString->append(*(field->getID()->getName()));
  fieldString->append("_Width");
  fieldString->append(" = ");
  fieldString->append(IntToString(field->getWidth()->getValue()));

  fieldString->append(*(field->getID()->getName()));
  fieldString->append("_Local_Range");
  fieldString->append(" = ");
  fieldString->append(IntToString(field->getUpper()->getValue()));
  fieldString->append(":");                             
  fieldString->append(IntToString(field->getLower()->getValue()));

  fieldString->append(*(field->getID()->getName()));
  fieldString->append("_Global_Range");
  fieldString->append(" = ");
  fieldString->append(IntToString(field->getUpper()->getValue() - field->getLower()->getValue()));
  fieldString->append(":");                             
  fieldString->append(IntToString(0));
}

void CFieldCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmField& field) {
  *(m_out) <<";"<< endl;
}

} // NSCFieldCPPGenerator
