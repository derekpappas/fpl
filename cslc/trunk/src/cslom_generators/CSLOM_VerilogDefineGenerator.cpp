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
#include "../cslom/CSLOM.h"
#include "../cslom/CSLOM_Visitor.h"
#include "CSLOM_VerilogDefineGenerator.h"
#include "../support/CommonSupport.h"
#include "../support/SupportFunctions.h"
#include <string>
#include <iostream>
#include <fstream>

using namespace NSCSLOmVisitor;
using namespace std;
using namespace NSCSLOm;

TBool cslomHasEnum = FALSE;

namespace NSCVerilogDefineGenerator {


CVerilogDefineGenerator::CVerilogDefineGenerator(string fileName):
  m_ids(RefTVec_RefString(new TVec_RefString())),
  m_childNumber(0),
  m_opCounter(0),
  m_dimNo(-1),
  m_fieldCounter(0),
  m_printId(TRUE),
  m_isSimpleBitRange(FALSE),
  m_isMultiDimBitRange(FALSE),
  m_showNumber(FALSE),
  m_isEnum(FALSE),
  m_isIsaElem(FALSE),
  m_isFileOpen(FALSE),
  m_isIsaFileOpen(FALSE),
  m_isEnumFileOpen(FALSE),
  m_firstTimePass(FALSE)
{
  string name = fileName;
  //  m_out = new ofstream(name.c_str());

  m_path                = fileName;
  
 // if (!filename.empty()) {
 //    m_out = new ofstream(filename.c_str());
 //    m_hasFile=TRUE;
 //  }
 //  else {
 //    m_out = &(cout);
 //  }
 // 
 // m_counter = 0;
 // m_isMemoryMapLocation = FALSE;
 // m_isAddressRange = FALSE;
 // m_childCountAddressRange = 0;
 // m_noChildren = 0;
 // m_mapSuffix = RefString();
 // m_mapPrefix = RefString();
}

CVerilogDefineGenerator::~CVerilogDefineGenerator(){
  //  if(m_hasFile){
  // ((ofstream*)(m_out))->close();
  // }
  //  delete m_out;
  closeIsaFile();
  closeEnumFile();
}

void CVerilogDefineGenerator::checkForIsaFile(string path) {
  //The isa output file is only created if there are isa elements or fields in the csl code.
  //The file will be created when the first isa element or field will be reached.
  if(!m_isIsaFileOpen) {
    string newVerPath = path + "isa_define.v"; 
    m_outIsa = new ofstream(newVerPath.c_str());
    m_isIsaFileOpen = TRUE;

    //writing the INC_GUARDs
    *m_outIsa << "`ifndef INC_GUARD_ISA" << endl;
    *m_outIsa << "`define INC_GUARD_ISA" << endl << endl;
    // m_name = RefString(new string(""));
  }
}

void CVerilogDefineGenerator::closeIsaFile() {
  if(m_isIsaFileOpen) {
    //closing the INC_GUARDs
    *m_outIsa << endl << "`endif" << endl;

    ((ofstream*)(m_outIsa))->close();

    delete m_outIsa;

    m_isIsaFileOpen = FALSE;
  }
}

void CVerilogDefineGenerator::checkForEnumFile(string path) {
  //The enum.v output file is only created if there are enums in the csl code.
  //The file will be created when the first csl_enum will be reached.
  if(!m_isEnumFileOpen) {
    string newVerPath = path + "enum_define.v"; 
    m_outEnum = new ofstream(newVerPath.c_str());
    m_isEnumFileOpen = TRUE;

    //writing the INC_GUARDs
    *m_outEnum << "`ifndef INC_GUARD_ENUM" << endl;
    *m_outEnum << "`define INC_GUARD_ENUM" << endl << endl;
  }
}

void CVerilogDefineGenerator::closeEnumFile() {
  if(m_isEnumFileOpen) {
    //closing the INC_GUARDs
    *m_outEnum << endl << "`endif" << endl;

    ((ofstream*)(m_outEnum))->close();
    delete m_outEnum;

    m_isEnumFileOpen = FALSE;
  }
}

RefString CVerilogDefineGenerator::getName() {
  RefString name = RefString(new string(""));

  for(TUInt i = 0; i < m_ids->size(); ++i) {
    name->append(*m_ids->at(i));
  }

  return name;
}

RefString CVerilogDefineGenerator::getNameUpper() {
  RefString name = RefString(new string(""));

  for(TUInt i = 0; i < m_ids->size(); ++i) {
    name->append(*m_ids->at(i));
  }

  return refStrToUpper(name);
}


std::string CVerilogDefineGenerator::convertExprOp(NSCSLOm::CSLOmExprOp::EOpType exprOpType) {
  switch(exprOpType) {
    case CSLOmExprOp::OP_UNARY_ARITHMETIC_PLUS          :return("+");    break;
    case CSLOmExprOp::OP_UNARY_ARITHMETIC_MINUS         :return("-");    break;// -op
    case CSLOmExprOp::OP_UNARY_LOGIC_NOT                :return("!");    break; // !op  - logical not
    case CSLOmExprOp::OP_UNARY_BITWISE_NOT              :return("~");    break; // ~op  - bitwise not
    case CSLOmExprOp::OP_UNARY_REDUCTION_AND            :return("&");    break; // &op  - reduction and
    case CSLOmExprOp::OP_UNARY_REDUCTION_NAND           :return("~&");   break; // ~&op - rediction nand
    case CSLOmExprOp::OP_UNARY_REDUCTION_OR             :return("|");    break; // |op  - reduction or
    case CSLOmExprOp::OP_UNARY_REDUCTION_NOR            :return("~|");   break; // ~|op - reduction nor
    case CSLOmExprOp::OP_UNARY_REDUCTION_XOR            :return("^");    break; // ^op  - reduction xor
    case CSLOmExprOp::OP_UNARY_REDUCTION_XNOR           :return("~^");   break; // ~^op or ^~op - reduction xnor
    case CSLOmExprOp::OP_UNARY_LOG_2                    :return("log2"); break;  
                                          
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_PLUS         :return("+");    break; // a + b
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS        :return("-");    break; // a - b
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY     :return("*");    break; // a * b
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_DIV          :return("/");    break; // a / b
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_MOD          :return("%");    break; // a % b
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_POW          :return("**");   break; // a ** b
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT   :return("<<<");  break; // a <<< b
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT  :return(">>>");  break; // a >>> b
    case CSLOmExprOp::OP_BINARY_EQUALITY_EQ             :return("==");   break; // a == b
    case CSLOmExprOp::OP_BINARY_EQUALITY_NOT_EQ         :return("!=");   break; // a != b
    case CSLOmExprOp::OP_BINARY_IDENTITY_EQ_CASE        :return("===");  break; // a === b
    case CSLOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE    :return("!==");  break; // a !== b
    case CSLOmExprOp::OP_BINARY_LOGIC_AND               :return("&&");   break; // a && b
    case CSLOmExprOp::OP_BINARY_LOGIC_OR                :return("||");   break; // a || b
    case CSLOmExprOp::OP_BINARY_RELATIONAL_LESS         :return("<");    break; // a < b
    case CSLOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL   :return("<=");   break; // a <= b
    case CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER      :return(">");    break; // a > b
    case CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL:return(">=");   break; // a >= b
    case CSLOmExprOp::OP_BINARY_BITWISE_AND             :return("&");    break; // a & b
    case CSLOmExprOp::OP_BINARY_BITWISE_NAND            :return("~&");   break; // a ~& b // !!! ???
    case CSLOmExprOp::OP_BINARY_BITWISE_OR              :return("|");    break; // a | b
    case CSLOmExprOp::OP_BINARY_BITWISE_NOR             :return("~|");   break; // a ~| b // !!! ???
    case CSLOmExprOp::OP_BINARY_BITWISE_XOR             :return("^");    break; // a ^ b
    case CSLOmExprOp::OP_BINARY_BITWISE_XNOR            :return("^~");   break; // a ^~ b or a ~^ b
    case CSLOmExprOp::OP_BINARY_SHIFT_LEFT              :return("<<");   break; // a << b
    case CSLOmExprOp::OP_BINARY_SHIFT_RIGHT             :return(">>");   break; // a >> b
         
    default: ASSERT(FAIL, "THIS SHOULD NOT HAPPEN"); 
  }
}

//
//beforeTraversal block
//

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) {
  //checkForEnumFile(m_path);
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                       & id                            ) {
 // ASSERT(id.get(), "id sent is null");
 //
 // if (m_isMemoryMapLocation ) {
 //   m_memoryMapLocationId = RefString(new string(*(m_mapPrefix)));
 //   m_memoryMapLocationId->append("_");
 //   m_memoryMapLocationId->append(*(m_pagePrefix));
 //   m_memoryMapLocationId->append("_");
 //   m_memoryMapLocationId->append(*(id->getName()));
 //   m_memoryMapLocationId->append("_");
 //   m_memoryMapLocationId->append(*(m_pageSuffix));
 //   m_memoryMapLocationId->append("_");
 //   m_memoryMapLocationId->append(*(m_mapSuffix));
 //   //   m_memoryMapLocationId = refStrToUpper(m_memoryMapLocationId);
 //   //in case it is still null
 //   if(!m_memoryMapLocationId.get()){
 //     m_memoryMapLocationId = RefString(new string (""));
 //   }
 // }
 
  if(m_printId) {
    RefString name = RefString(new string(*(id->getName())));
    if(!m_isEnum) {
      name->append("_");
    }
    m_ids->push_back(name);
    m_printId = FALSE;
  
  }
} 

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {
  ASSERT(!m_isFileOpen, "file already open");
  ASSERT(unitDecl.get(), "null unit declaration received");

  //For every unit there will be a_define.v  file with the name of the unit.
  RefString name = unitDecl->getName();
  string newPath = m_path + *name + "_define.v";
  m_out = new ofstream(newPath.c_str());
  m_isFileOpen = TRUE;

 if(unitDecl->isFifo()){
       m_printId = FALSE;
       string fifoPath = m_path + *name + "_fifo_memory_define.v";
       m_out = new ofstream(fifoPath.c_str());
       m_isFileOpen = TRUE;
     }
  //writing the INC_GUARDs
  if(!unitDecl->isSetDoNotGenerateRTL()){
    *m_out << "`ifndef INC_GUARD_" << *name << endl;
    *m_out << "`define INC_GUARD_" << *name << endl << endl;
    m_printId = FALSE;
  }
  else {
    disableChildrenTraversal();
  }
 
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {
  // m_isSignalOrPort = TRUE;
  //m_name = RefString(new string(""));
  //m_name->append(*m_ifcSgName);
  // m_name->append("S_");
  m_ids->push_back(RefString(new string("S_")));
  m_printId = TRUE;
  
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
  ASSERT(simpleBitRange.get(), "null simple bitrange received");
  ASSERT(m_isFileOpen, "no file is open");

  *m_out << "`define ";
  // if(m_isSignalOrPort) {
  //  m_isDefaultBitRange = TRUE;
  //}
  // if(simpleBitRange->isAnonymous()) {
  //   m_printId = FALSE;
  // }
  m_isSimpleBitRange = TRUE;
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
  ASSERT(multiDimBitRange.get(), "null simple bitrange received");
  ASSERT(m_isFileOpen, "no file is open");

   *m_out << "`define ";
  //if(m_isSignalOrPort) {
  //  m_isDefaultBitRange = TRUE;
  //}
  //if(multiDimBitRange->isAnonymous()) {
  //  m_printId = FALSE;
  //}
  m_isMultiDimBitRange = TRUE;
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {
  ASSERT(groupSignal.get(), "null signal group received");
  ASSERT(m_isFileOpen, "no file is open");
  // m_ifcSgName->append("SG_");
  //refStrToUpper(m_ifcSgName);
  //m_isIfcOrSg = TRUE;
  m_ids->push_back(RefString(new string("SG_")));
  m_printId = TRUE;
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) {
 // ASSERT(number.get(),"number sent is null");
 // if(m_isAddressRange && m_childCountAddressRange > 1){
 //   *(m_out) << number->getValue();
 // }

  ASSERT(number.get(), "null number received");

  if(m_showNumber) {
    ASSERT(m_isFileOpen || m_isIsaFileOpen, "no file is open");
    if(m_isFileOpen) {
      *m_out << number->getValue();
    }
    else if(m_isIsaFileOpen) {
      *m_outIsa << number->getValue();
    }
  }
  m_showNumber = FALSE;
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                          ) {
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {
  ASSERT(interface.get(), "null interface received");
  ASSERT(m_isFileOpen, "no file is open");

  if(!interface->isDefaultIfc()) {
    m_ids->push_back(RefString(new string("IFC_")));
    m_printId = TRUE;
  }
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {
  ASSERT(portDecl.get(), "null port received");
  ASSERT(m_isFileOpen, "no file is open");

  //m_isSignalOrPort = TRUE;
  //m_name = RefString(new string(""));
  //m_name->append(*m_ifcSgName);
  //m_name->append("P_");
  m_ids->push_back(RefString(new string("P_")));
  m_printId = TRUE;
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {
  m_opCounter = 0;
  if(m_isIsaFileOpen){
    //if(m_isSimpleBitRange){
      if(exprOp->isUnary()) {
        (*m_outIsa) << convertExprOp(exprOp->getOpType());
        m_showNumber = TRUE;
      }
      // }
  }
  else{
    if(m_isSimpleBitRange){
      if(exprOp->isUnary()) {
        (*m_out) << convertExprOp(exprOp->getOpType());
        m_showNumber = TRUE;
      }
    }
  }
 
 
}
void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) {
   checkForEnumFile(m_path);
  ASSERT(enumeration.get(), "null enum received");  
  //m_isEnum = TRUE;
  *m_outEnum << "`define " ;
  m_ids->push_back(RefString(new string("E_")));
  m_printId = TRUE;
  m_childNumber = 0;
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) {
  ASSERT(field.get(), "null field received");
  ASSERT(m_isFileOpen, "no file is open");

  m_childNumber = 0;
  if(m_fieldCounter >0) {
    *m_out << endl;
    m_ids->push_back(RefString(new string("F_")));
    m_printId = TRUE;
  }
  if(m_childNumber == 0) {
    *m_out << "`define " ;
  }
  m_firstTimePass = TRUE;
  m_fieldCounter++;
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {
 // ASSERT(memoryMap.get(), "memoryMap sent is null");
 //
 // *(m_out) << "Memory map" << endl;
 //
 // m_mapSuffix = memoryMap->getSuffix();
 // m_mapPrefix = memoryMap->getPrefix();
 // if(!m_mapSuffix.get()) {
 //   m_mapSuffix = RefString(new string(""));
 // }
 // if(!m_mapPrefix.get()) {
 //   m_mapPrefix = RefString(new string(""));
 // }

}
void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {
 // ASSERT(addressRange.get(), "addressRange sent is null");
 // m_childCountAddressRange = 0;
 // m_isAddressRange = TRUE;
 // m_noChildren =  addressRange->getChildrenSize();

}
void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {
 // m_isMemoryMapLocation = TRUE;
 // ASSERT(memoryMapLocation.get(), "memoryMapLocation sent is null");
 // m_counter = 0;
 //
 //
 // //inits
 // m_gladd= memoryMapLocation->getGlobalAddress();
 // m_lcadd= memoryMapLocation->getLocalAddress();
 // 
 //
 // *(m_out) << "**************************************************" << endl;
}
void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {
 // ASSERT(memoryMapPage.get(), "memoryMapPage sent is null");
 // disableContainerTraversal();
 // *(m_out)<< "Memory map page" << endl;
 // m_pageSuffix=memoryMapPage->getSuffix();
 // m_pagePrefix=memoryMapPage->getPrefix();
 // if(!m_pageSuffix.get()) m_pageSuffix=RefString(new string(""));
 // if(!m_pagePrefix.get()) m_pagePrefix=RefString(new string(""));
}


void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {
  checkForIsaFile(m_path);
  ASSERT(isaField.get(), "null isa field received");
  
  //checkForIsaFile(m_path);
   
  if(m_isIsaElem &&m_fieldCounter == 0) {
    *m_outIsa << endl;
  }
  if(m_fieldCounter > 0) {
    *m_outIsa << endl;
  }
  m_showNumber = FALSE;
  *m_outIsa << "`define ";
  m_ids->push_back(RefString(new string("IF_")));
  m_printId = TRUE;
  m_fieldCounter++;
  m_childNumber = 0;
  m_firstTimePass = TRUE;
}

void CVerilogDefineGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {
  checkForIsaFile(m_path);
  ASSERT(isaElement.get(), "null isa element received");
  
  //checkForIsaFile(m_path);
  *m_outIsa << "`define ";
  m_isSimpleBitRange = TRUE;
  m_showNumber = FALSE;
  m_ids->push_back(RefString(new string("IE_")));
  m_printId = TRUE;
  m_isIsaElem = TRUE;
}

//
//inTraversalBlock
//

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) {
  
}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {

}
void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {

}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
  ASSERT(simpleBitRange.get(), "null simpleBitRange received");
  ASSERT(m_isFileOpen, "no file is open");
  
  if(m_childNumber == 1) {
    m_showNumber = TRUE;
    *m_out << *getNameUpper() ;
    if(m_isMultiDimBitRange) {
      *m_out << "DIM_" << m_dimNo << "_";
    }
    *m_out << "UPPER_INDEX  (";
  }
  else if(m_childNumber == 2) {
    m_showNumber = TRUE;
    *m_out <<")"<< endl << "`define " << *getNameUpper();
    if(m_isMultiDimBitRange) {
      *m_out << "DIM_" << m_dimNo << "_";
    }
    *m_out << "LOWER_INDEX  (";
  }
  else if(m_childNumber == 3) {
    *m_out << ")";
    *m_out << endl << "`define " << *getNameUpper();
    if(m_isMultiDimBitRange) {
      *m_out << "DIM_" << m_dimNo << "_";
      m_dimNo++;
    }
    RefCSLOmExpr val = simpleBitRange ->getWidth();
    //if(val.get()->isNumber()){
    m_showNumber =TRUE;
    *m_out << "WIDTH  (";
    val->acceptVisitor(*this);
      //}
    *m_out << ")"<<endl <<"`define " << *getNameUpper() << "RANGE " << "`" << *getNameUpper() << "UPPER_INDEX:`" << *getNameUpper() << "LOWER_INDEX";
  }
  m_childNumber++;
}
void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
  ASSERT(multiDimBitRange.get(), "null multiDimBitRange received");
  ASSERT(m_isFileOpen, "no file is open");

  if(m_dimNo == -1) {
    *m_out << *getNameUpper() << "NO_DIMS ";
    m_showNumber = TRUE;
    m_dimNo++;
  }
  else if(m_dimNo == 0) {
    *m_out << endl;
  }
}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {
 
}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) {

}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) {

}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {

}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {

}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {
  if(m_isIsaFileOpen ){
    //if(m_isSimpleBitRange){
      if(exprOp->isBinary() && m_opCounter == 0) {
        (*m_outIsa) << convertExprOp(exprOp->getOpType());
        m_showNumber = TRUE;
      }
      else if(exprOp->isTernary() && m_opCounter == 0) {
        (*m_outIsa) << "?";
        m_showNumber = TRUE;
      }
      else if(exprOp->isTernary() && m_opCounter == 1) {
        (*m_outIsa) << ":";
        m_showNumber = TRUE;
      }
      // }
  }
  else{
    if(m_isSimpleBitRange){
      if(exprOp->isBinary() && m_opCounter == 0) {
        (*m_out) << convertExprOp(exprOp->getOpType());
        m_showNumber = TRUE;
      }
      else if(exprOp->isTernary() && m_opCounter == 0) {
        (*m_out) << "?";
        m_showNumber = TRUE;
      }
      else if(exprOp->isTernary() && m_opCounter == 1) {
        (*m_out) << ":";
        m_showNumber = TRUE;
      }
    }
  }
  m_opCounter++;
}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {
  if(m_isSimpleBitRange && !m_isIsaFileOpen ){
    (*m_out) <<*(exprLink->getName());
  }
  else if(m_isIsaFileOpen && !m_isEnumFileOpen){
    (*m_outIsa) <<*(exprLink->getName());
  }
  //else if(m_isEnumFileOpen){
  //  (*m_outEnum) <<*(exprLink->getName());
  //}

}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) {
  ASSERT(enumeration.get(), "null enumeration received");
  ASSERT(m_isEnumFileOpen, "no enum file is open");

  TInt n = -1;
  if(m_isEnum == FALSE) {
    m_isEnum = TRUE;
    cslomHasEnum = TRUE;
  }
  if(m_childNumber > 1) {
    *m_outEnum << endl ;
    n = (enumeration->getValue(m_ids->at(m_ids->size()-1)))->getValue();
    *m_outEnum << "`define " << *getNameUpper() ;
  
  }
  else if(m_childNumber == 1) {
    n = (enumeration->getValue(m_ids->at(m_ids->size()-1)))->getValue();
    *m_outEnum << *getNameUpper();
  }

  //check if the enum item has a user set value
  if(n != -1) {
    *m_outEnum << " " << n;
  }
  
  m_childNumber++;
  
  if(m_childNumber >1) {
    m_ids->pop_back(); 
  }
  
  m_printId = TRUE;
}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) {
  ASSERT(field.get(), "null field received");
  ASSERT(m_isFileOpen, "no file is open");  
 
  
  if(m_firstTimePass) {
    if(m_childNumber == 1) {
      m_showNumber = TRUE;
      *m_out << *getNameUpper() << "UPPER_INDEX  (";
    }
    else if(m_childNumber == 2) {
      m_showNumber = TRUE;
      *m_out <<")"<< endl << "`define " << *getNameUpper() << "LOWER_INDEX (";
      //  m_firstTimePass = FALSE;
      }
    else if(m_childNumber == 3 ) {
      RefCSLOmExpr val = field ->getWidth();
      if(val.get()->isNumber()){
        *m_out <<")" <<endl << "`define " << *getNameUpper() << "WIDTH " << CSLOmNumber::cast(val->doEval())->getValue();
      }
      *m_out <<")" <<endl << "`define " << *getNameUpper() << "RANGE " << "`" << *getNameUpper() << "UPPER_INDEX:`" << *getNameUpper() << "LOWER_INDEX";
      // *m_out << endl;
      m_firstTimePass = FALSE;
    }
    m_childNumber++;
  }  
}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {}
void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {
 // m_childCountAddressRange++;
 // if(m_memoryMapLocationId.get()){
 //   if(m_childCountAddressRange == m_noChildren - 2){
 //     *(m_out) << "`define " << *(m_memoryMapLocationId)<<*m_localOrGlobal<< "_LOWER ";
 //   }
 //   else  if(m_childCountAddressRange == m_noChildren - 1){
 //     *(m_out)  << endl;
 //     *(m_out) << "`define " << *(m_memoryMapLocationId)<<*m_localOrGlobal<< "_UPPER ";
 //   }
 //   else if(m_childCountAddressRange == m_noChildren){
 //     *(m_out)  << endl;
 //   }
 // }
}
void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {
 // m_counter++;
 // if (m_counter == 1) {
 //   //*(m_out)<< "Memory Map Location a trecut de Identifier" << endl;
 //   m_localOrGlobal=RefString(new string("_LOCAL"));
 //   m_isMemoryMapLocation = FALSE;
 // }
 // else if (m_counter == 2) {
 //   
 //   //    *(m_out)<< "Memmory Map Location a trecut de Local Address" << endl;
 //   m_localOrGlobal=RefString(new string("_GLOBAL"));
 // }
 // else if (m_counter == 3) {
 //   //    *(m_out)<< "Memmory Map Location a trecut de Global Address" << endl;
 // }
 // else if (m_counter == 4) {
 //   //    *(m_out)<< "Memmory Map Location a trecut de Addressable object" << endl;
 // }

}
void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {}


void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {
  ASSERT(isaField.get(), "null isa field received");
  ASSERT(m_isIsaFileOpen, "no file is open");
 
  if(m_firstTimePass) {
    if(m_childNumber == 1) {
      m_showNumber = TRUE;
      *m_outIsa << *getNameUpper() << "UPPER_INDEX  (";
    }
    else if(m_childNumber == 2) {
      m_showNumber = TRUE;
      *m_outIsa <<")" <<endl << "`define " << *getNameUpper() << "LOWER_INDEX (";
    }
    else if(m_childNumber == 3) {
      m_showNumber = TRUE;
      RefCSLOmExpr val = isaField ->getWidth();
      if(val.get()->isNumber()){
        *m_outIsa << ")"<<endl << "`define " << *getNameUpper() << "WIDTH (" << CSLOmNumber::cast(val->doEval()) ->getValue();
      }
      *m_outIsa <<")" <<endl << "`define " << *getNameUpper() << "RANGE " << "`" << *getNameUpper() << "UPPER_INDEX:`" << *getNameUpper() << "LOWER_INDEX";
      *m_outIsa << endl;
      m_firstTimePass = FALSE;
    }
    m_childNumber++;
  }
}

void CVerilogDefineGenerator::inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {
  ASSERT(isaElement.get(), "null isa element received");
  ASSERT(m_isIsaFileOpen, "no file is open");
  if(m_childNumber == 1) {
    m_showNumber = TRUE;
    *m_outIsa << *getNameUpper() << "UPPER_INDEX (";
  }
  else if(m_childNumber == 2) {
    m_showNumber = TRUE;
    *m_outIsa <<")" <<endl << "`define " << *getNameUpper() << "LOWER_INDEX (";
  }
  else if(m_childNumber == 3) {
    m_showNumber = TRUE;
    RefCSLOmExpr val = isaElement ->getWidth();
    if(val.get()->isNumber()){
    //*m_outIsa << endl << "`define " << *getNameUpper() << "POSITION" << isaElement ->getFieldPosition()->getValue;
      *m_outIsa << ")"<< endl << "`define " << *getNameUpper() << "WIDTH ("   << CSLOmNumber::cast(val->doEval())->getValue();
    }
    *m_outIsa <<")" <<endl << "`define " << *getNameUpper() << "RANGE "   << "`" << *getNameUpper() << "UPPER_INDEX:`" << *getNameUpper() << "LOWER_INDEX";
  }
  //else if(m_childNumber > 2) {
  //if(!isaElement->getShouldBeRoot()) {
  //  m_isIsaFieldInstance = TRUE;
  //}
  //}
  m_childNumber++;
}

//
//afterTraversal block
//

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) {
  // closeIsaFile();
  //closeEnumFile();
 
}
void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {}
void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {
  //  if(unitDecl->getUnitType() != CSLOmUnitDecl::CSL_VECTOR) {
    ASSERT(unitDecl.get(), "null unit decl received");
    ASSERT(m_isFileOpen, "no file is open");
    if(!unitDecl->isSetDoNotGenerateRTL()){
     *m_out << endl << "`endif" << endl;
    }
    else {
      enableChildrenTraversal();
    }
  
    ((ofstream*)(m_out))->close();
    delete m_out;
    m_isFileOpen = FALSE;
    // }
}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {
  ASSERT(signal.get(), "null signal received");

  m_ids->pop_back();
  m_ids->pop_back();
}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
  ASSERT(simpleBitRange.get(), "null simple bit range received");
  ASSERT(m_isFileOpen, "no file is open");

  *m_out << endl;
  
  m_isSimpleBitRange = FALSE;
  m_showNumber = FALSE;
  m_childNumber = 0;
}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
  ASSERT(multiDimBitRange.get(), "null simple bit range received");
  ASSERT(m_isFileOpen, "no file is open");

  m_dimNo = -1;
  m_isMultiDimBitRange = FALSE;

  
}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {
  ASSERT(groupSignal.get(), "null group signal received");
  ASSERT(m_isFileOpen, "no file is open");
  m_ids->pop_back();
  m_ids->pop_back();
}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmNum32                             & number                          ) {}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmVeriNum                           & veriNum                         ) {}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {
  ASSERT(interface.get(), "null interface received");
  ASSERT(m_isFileOpen, "no file is open");
  
  if(!interface->isDefaultIfc()) {
    m_ids->pop_back();
    m_ids->pop_back();
  }
}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {
  ASSERT(portDecl.get(), "null portDecl received");

  m_ids->pop_back();
  m_ids->pop_back();
}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {
  m_opCounter = 0;
}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {

}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) {
  ASSERT(enumeration.get(), "null enum received");
  ASSERT(m_isEnumFileOpen, "no file is open");

  *m_outEnum << endl;
  m_childNumber = 0;
  m_ids->pop_back();
  m_ids->pop_back();
  m_isEnum = FALSE;
  m_printId = FALSE;
}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) {
  ASSERT(field.get(), "null field received");
  ASSERT(m_isFileOpen, "no file is open");

  m_fieldCounter--;
  if(m_fieldCounter == 0) {
    *m_out << endl;
  }
  else {
    m_ids->pop_back();
    m_ids->pop_back();
  }
  m_childNumber = 0; 
}
void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                         & memoryMap                       ) {
  // *(m_out) << "Finished with memoryMap" << endl;
}
void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmAddressRange                      & addressRange                    ) {
  //  m_isAddressRange = FALSE;
}
void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation                 & memoryMapLocation               ) {
  //*(m_out) << "**************************************************" << endl;
  //  *(m_out) << "Finished with memoryMapLocation" << endl;
  // m_isMemoryMapLocation = FALSE;
}   
void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                     & memoryMapPage                   ) {
  // *(m_out) << "Finished with memoryMapPage" << endl;
  // enableContainerTraversal();
}   
 
void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {
  ASSERT(isaField.get(), "null isa field received");
  ASSERT(m_isIsaFileOpen, "no file is open");
  m_fieldCounter--;
  if(m_fieldCounter == 0 && !m_isIsaElem) {
    *m_outIsa << endl;
  }
  m_ids->pop_back();
  m_ids->pop_back();
  
  m_isSimpleBitRange = FALSE;
  m_childNumber = 0;

}

void CVerilogDefineGenerator::afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {
  ASSERT(isaElement.get(), "null isa element received");
  ASSERT(m_isIsaFileOpen, "no file is open");

  *m_outIsa << endl;
  m_isSimpleBitRange = FALSE;
  m_isIsaElem = FALSE;
  m_childNumber = 0;
  m_ids->pop_back();
  m_ids->pop_back();
}
   
}//NSCVerilogDefineGenerator namespace end
    
