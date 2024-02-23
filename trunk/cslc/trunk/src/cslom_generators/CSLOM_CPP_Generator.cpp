// Copyright (c) 2005, 2006, 2007, 2008 Fastpathlogic
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

//Author: MihaelaP

#include "../cslom/CSLOM.h"
#include "../cslom/CSLOM_Visitor.h"
#include "CSLOM_CPP_Generator.h"
#include <iostream>
#include <fstream>


using namespace NSCSLOm;
using namespace NSCSLOmVisitor;
using namespace std;
using namespace boost;

namespace NSCCPPGenerator {


CCPPGenerator::CCPPGenerator(string path):
  m_childNumber(0),
  m_exprOpChildNumber(0),
  m_dimNo(-1),
  m_fieldCounter(0),
  m_ids(RefTVec_RefString(new TVec_RefString()))

{
  ASSERT(!path.empty(), "null path received");
  
  m_path = path;
  
  m_isMultiDimBitRange  = FALSE;
  m_showNumber          = FALSE;
  m_showId              = FALSE;
  m_showExprOp          = FALSE;
  m_isEnum              = FALSE;
  m_isIsaElem           = FALSE;
  m_isFileOpen          = FALSE;
  m_isIsaFileOpen       = FALSE;
  m_isEnumFileOpen      = FALSE;
  m_firstTimePass       = FALSE;

  #ifndef __RELEASE_VERSION
  string newHeaderPath = path + "x.h";
  m_hOut2 = new ofstream(newHeaderPath.c_str());
  #endif
}


CCPPGenerator::~CCPPGenerator() {
  #ifndef __RELEASE_VERSION
  ((ofstream*)(m_hOut2))->close();
  delete m_hOut2;
  #endif

  closeIsaFile();
  closeEnumFile();
}

void CCPPGenerator::checkForIsaFile(string path) {
  //The isa output file is only created if there are isa elements or isa fields in the csl code.
  //The file will be created when the first isa element or isa field will be reached.
  if(!m_isIsaFileOpen) {
    string newHeaderPath = path + "isa.h"; 
    m_hOutIsa = new ofstream(newHeaderPath.c_str());
    m_isIsaFileOpen = TRUE;

    //writing the INC_GUARDs
    *m_hOutIsa << "#ifndef INC_GUARD_ISA_h" << endl;
    *m_hOutIsa << "#define INC_GUARD_ISA_h" << endl << endl;
  }
}

void CCPPGenerator::closeIsaFile() {
  if(m_isIsaFileOpen) {
    //closing the INC_GUARDs
    *m_hOutIsa << endl << "#endif" << endl;

    ((ofstream*)(m_hOutIsa))->close();

    delete m_hOutIsa;

    m_isIsaFileOpen = FALSE;
  }
}

void CCPPGenerator::checkForEnumFile(string path) {
  //The enum.h output file is only created if there are enums in the csl code.
  //The file will be created when the first csl_enum will be reached.
  if(!m_isEnumFileOpen) {
    string newHeaderPath = path + "enum.h"; 
    m_hOutEnum = new ofstream(newHeaderPath.c_str());
    m_isEnumFileOpen = TRUE;

    //writing the INC_GUARDs
    *m_hOutEnum << "#ifndef INC_GUARD_ENUM_h" << endl;
    *m_hOutEnum << "#define INC_GUARD_ENUM_h" << endl << endl;
  }
}

void CCPPGenerator::closeEnumFile() {
  if(m_isEnumFileOpen) {
    //closing the INC_GUARDs
    *m_hOutEnum << endl << "#endif" << endl;

    ((ofstream*)(m_hOutEnum))->close();
    delete m_hOutEnum;

    m_isEnumFileOpen = FALSE;
  }
}

RefString CCPPGenerator::getName() {
  RefString name = RefString(new string(""));

  for(TUInt i = 0; i < m_ids->size(); ++i) {
    name->append(*m_ids->at(i));
  }

  return name;
}

RefString CCPPGenerator::getNameUpper() {
  RefString name = RefString(new string(""));

  for(TUInt i = 0; i < m_ids->size(); ++i) {
    name->append(*m_ids->at(i));
  }

  return refStrToUpper(name);
}



std::string CCPPGenerator::convertExprOp(NSCSLOm::CSLOmExprOp::EOpType exprOpType) {
  
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



/////////////////////////
//beforeTraversal block//
////////////////////////




void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) {
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) {
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {
  
  if(m_showId) {
    RefString name = RefString(new string(*(id->getName())));
    //besides the enum and enum items, all the other elements will have const ints for lower and upper values,so a "_" will be needed
    if(!m_isEnum) {
      name->append("_");
    }
    m_ids->push_back(name);
    m_showId = FALSE;
  }

#ifndef __RELEASE_VERSION
  *m_hOut2 << "ID----------> " << *id->getName() << endl;
#endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {
  ASSERT(exprLink.get(), "null exprLink received");
  ASSERT(m_isFileOpen || m_isIsaFileOpen, "file not open");
  
  if(m_isFileOpen) {
    *m_hOut << *convertLink(exprLink);
  }
  else {
    *m_hOutIsa << *convertLink(exprLink);
  }
  
#ifndef __RELEASE_VERSION
  *m_hOut2 << "expr link" << endl;
#endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {
  ASSERT(!m_isFileOpen, "file already open");
  ASSERT(unitDecl.get(), "null unit declaration received");

  //For every unit there will be a .cpp and a .h file with the name of the unit.
  RefString name = unitDecl->getName();
  string newHeaderPath = m_path + *name + ".h";
  string newCppPath = m_path + *name + ".cpp";
  m_hOut = new ofstream(newHeaderPath.c_str());
  m_cppOut = new ofstream(newCppPath.c_str());
  
  //writing the INC_GUARDs
  *m_hOut << "#ifndef INC_GUARD_" << *name << "_h" << endl;
  *m_hOut << "#define INC_GUARD_" << *name << "_h" << endl << endl;
  m_isFileOpen = TRUE;

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "unit decl" <<endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {
  //the output for a signal will be like this: 
  //S_NAME_LOWER = value;
  //S_NAME_UPPER = value;

  m_ids->push_back(RefString(new string("S_")));
  m_showId = TRUE;

#ifndef __RELEASE_VERSION
  *m_hOut2 << "signal" << endl;
#endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
  ASSERT(simpleBitRange.get(), "null simple bitrange received");
  ASSERT(m_isFileOpen, "no file is open");

  m_showExprOp = TRUE;
  *m_hOut << "const int ";

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "bitrange" << endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
  ASSERT(multiDimBitRange.get(), "null multidim bitrange received");
  ASSERT(m_isFileOpen, "no file is open");

  //for multidim bitranges there will be a const int for the number of dimensions, and const ints for all the dimensions
  *m_hOut << "const int ";
  m_isMultiDimBitRange = TRUE;

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "multidim bitrange" << endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {
  ASSERT(groupSignal.get(), "null signal group received");
  ASSERT(m_isFileOpen, "no file is open");

  m_ids->push_back(RefString(new string("SG_")));
  m_showId = TRUE;

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "group signal" << endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) {
  ASSERT(number.get(), "null number received");

  if(m_showNumber) {
    ASSERT(m_isFileOpen || m_isIsaFileOpen, "no file is open");
    if(m_isFileOpen) {
      *m_hOut << number->getValue();
    }
    else {
      *m_hOutIsa << number->getValue();
    }
  }
  m_showNumber = FALSE;

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "====number" << endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmVeriNum                          & veriNum                          ) {
}


void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {
  ASSERT(interface.get(), "null interface received");
  ASSERT(m_isFileOpen, "no file is open");

  //every const int for an element from an interface(except for the default interface) will have as prefix IFC_IFCNAME
  // where IFCNAME is the name of the interface in upper case
  if(!interface->isDefaultIfc()) {
    m_ids->push_back(RefString(new string("IFC_")));
    m_showId = TRUE;
  }

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "interface" << endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {
  ASSERT(portDecl.get(), "null port received");
  ASSERT(m_isFileOpen, "no file is open");

  m_ids->push_back(RefString(new string("P_")));
  m_showId = TRUE;

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "port" << endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {
  ASSERT(exprOp.get(), "null exprOp received");
  ASSERT(m_isFileOpen || m_isIsaFileOpen, "no file is open");
  

  if(m_showExprOp) {
    if(exprOp->isUnary()) {
      if(m_isFileOpen) {
        *m_hOut << convertExprOp(exprOp->getOpType()) << " ";
      }
      else {
        *m_hOutIsa << convertExprOp(exprOp->getOpType()) << " ";
      }
    }
    m_showNumber = TRUE;
  }

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "exprOp" << endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {
  ASSERT(exprConcat.get(), "null exprConcat received");
  
  if(m_showExprOp) {
    
  }
#ifndef __RELEASE_VERSION
  *m_hOut2 << "exprConcat" << endl;
#endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {
  ASSERT(exprMultiConcat.get(), "null exprMultiConcat received");
  
  if(m_showExprOp) {
    
  }
#ifndef __RELEASE_VERSION
  *m_hOut2 << "exprMultiConcat" << endl;
#endif

}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {
#ifndef __RELEASE_VERSION
  *m_hOut2 << "parameter" << endl;
#endif
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) {
  ASSERT(enumeration.get(), "null enum received");

  checkForEnumFile(m_path);
  m_isEnum = TRUE;

  *m_hOutEnum << "enum " ;
  m_ids->push_back(RefString(new string("E_")));
  m_showId = TRUE;
  m_childNumber = 0;
  
  #ifndef __RELEASE_VERSION
  *m_hOut2 << "enum" <<endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) {
  ASSERT(field.get(), "null field received");
  ASSERT(m_isFileOpen, "no file is open");

  //The first field in the hierarchy will have a defaut name(because it is associated to a signal or port) 
  //so only for the rest of the fields in the hierarchy will the name be displayed. \n
  //The ";" is displayed here only for fields inside a hierarchy. For example, if we have field A inside a field B, then the ";" for A is printed in the afterTraversal 
  //function, while the ";" for B is printed in the beforeTraversal function for A, because the afterTraversal function for B is called after A is traversed. The order of the 
  //function calls is like this: \n
  //B:beforeTraversal \n
  //A:beforeTraversal \n
  //A:inTraversal \n
  //A:afterTraversal \n
  //B:inTraversal \n
  //B:afterTraversal \n
  //The output will be: \n 
  //F_B_UPPER = value;  \n
  //F_B_LOWER = value; \n
  //F_A_UPPER = value; \n
  //F_A_LOWER = value; \n
  //
  if(m_fieldCounter > 0) {
    *m_hOut << ";" << endl;
    m_ids->push_back(RefString(new string("F_")));
    m_showId = TRUE;
  }
  *m_hOut << "const int ";
  
  m_firstTimePass = TRUE;
  m_childNumber = 0;
  m_fieldCounter++;
  
  #ifndef __RELEASE_VERSION
    *m_hOut2 << "field" <<endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {
  ASSERT(isaField.get(), "null isa field received");

  checkForIsaFile(m_path);
  if(m_isIsaElem && m_fieldCounter == 0) {
    *m_hOutIsa << ";" << endl;
  }
  if(m_fieldCounter > 0) {
    *m_hOutIsa << ";" << endl;
  }
  
  *m_hOutIsa << "const int ";
  m_ids->push_back(RefString(new string("IF_")));
  m_showId = TRUE;

  
  m_fieldCounter++;
  m_childNumber = 0;
  m_firstTimePass = TRUE;
  
  
  #ifndef __RELEASE_VERSION
  *m_hOut2 << "isa field" <<endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {
  ASSERT(isaElement.get(), "null isa element received");

  checkForIsaFile(m_path);

  *m_hOutIsa << "const int ";
  m_ids->push_back(RefString(new string("IE_")));
  m_showId = TRUE;
  m_isIsaElem = TRUE;

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "isa element" <<endl;
  #endif
}

void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {
}
void CCPPGenerator::beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {
}



/////////////////////
//inTraversal block//
////////////////////




void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {
#ifndef __RELEASE_VERSION
  *m_hOut2 << "expr link  child" << endl;
#endif
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
  ASSERT(simpleBitRange.get(), "null simpleBitRange received");
  ASSERT(m_isFileOpen, "no file is open");

  if(m_childNumber == 1) {
    m_showNumber = TRUE;
    *m_hOut << *getNameUpper();
    if(m_isMultiDimBitRange) {
      //if the bitrange is multi dimensional, the number of the dimension must be printed out
      *m_hOut << "DIM_" << m_dimNo << "_";
    }
    *m_hOut << "UPPER = ";
  }
  else if(m_childNumber == 2) {
    m_showNumber = TRUE;
    *m_hOut << ";" << endl << "const int " << *getNameUpper();
    if(m_isMultiDimBitRange) {
      *m_hOut << "DIM_" << m_dimNo << "_";
    }
    *m_hOut << "LOWER = ";
  }
  else if(m_childNumber == 3) {
    *m_hOut << ";" << endl << "const int " << *getNameUpper();
    if(m_isMultiDimBitRange) {
      *m_hOut << "DIM_" << m_dimNo << "_";
      m_dimNo++;
    }
    RefCSLOmExpr width = simpleBitRange->getWidth();
    m_showNumber = TRUE;
    *m_hOut << "WIDTH = " ;
    width->acceptVisitor(*this);
    *m_hOut << ";" << endl;
  }
  m_childNumber++;

#ifndef __RELEASE_VERSION
  *m_hOut2 << "simpleBitRange child " << m_childNumber << endl;
#endif

}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
  ASSERT(multiDimBitRange.get(), "null multiDimBitRange received");
  ASSERT(m_isFileOpen, "no file is open");
  
  if(m_dimNo == -1) {
    *m_hOut << *getNameUpper() << "NO_DIMS = ";
    m_showNumber = TRUE;
    m_dimNo++;
  }
  else if(m_dimNo == 0) {
    *m_hOut << ";" << endl;
  }

#ifndef __RELEASE_VERSION
  *m_hOut2 << "multidim child " << m_dimNo<< endl;
#endif
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) {
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmVeriNum                        & veriNum                          ) {
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {
#ifndef __RELEASE_VERSION
  *m_hOut2 << "interface child " << endl;
#endif
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {
#ifndef __RELEASE_VERSION
  *m_hOut2 << "portDecl child " << endl;
#endif
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {
  ASSERT(exprOp.get(), "null exprOp received");
  ASSERT(m_isFileOpen || m_isIsaFileOpen, "no file is open");
  
  if(m_showExprOp) {
    if(m_exprOpChildNumber == 0) {
      if(exprOp->isBinary() || exprOp->isTernary()) {
        if(m_isFileOpen) {
          *m_hOut << convertExprOp(exprOp->getOpType());
        }
        else {
          *m_hOutIsa << convertExprOp(exprOp->getOpType());
        }
      }
      m_showNumber = TRUE;
    }
    else if(m_exprOpChildNumber == 1) {
       if(exprOp->isTernary()) {
         if(m_isFileOpen) {
           *m_hOut << convertExprOp(exprOp->getOpType());
         }
         else {
           *m_hOutIsa << convertExprOp(exprOp->getOpType());
         }
      }
       m_showNumber = TRUE;
    }
    m_exprOpChildNumber++;
  }
  
  #ifndef __RELEASE_VERSION
  *m_hOut2 << "exprOp - child" << endl;
  #endif
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {
}
/*
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) {
}
*/

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) {
  ASSERT(enumeration.get(), "null enumeration received");
  ASSERT(m_isEnumFileOpen, "no enum file is open");
  
  TInt enumItemValue = -1;
  //the "," after each element will be printed at the beginning of the next element; this way the last element will not have a comma after it
  if(m_childNumber > 1) {
    *m_hOutEnum << "," << endl << "\t";
    enumItemValue = (enumeration->getValue(getName()))->getValue();
  }
  else if(m_childNumber == 1) {
    *m_hOutEnum << "\t";
    enumItemValue = (enumeration->getValue(getName()))->getValue();
  }

  *m_hOutEnum << *getNameUpper();

  //printing the value of the enum
  if(enumItemValue != -1) {
    *m_hOutEnum << " = " << enumItemValue;
  }

  //printing the "{" after the name of the enum
  if(m_childNumber == 0) {
    *m_hOutEnum << "{" << endl;
    m_ids->pop_back();
  }

  m_childNumber++;
  m_ids->pop_back();
  m_showId = TRUE;
  
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) {
  ASSERT(field.get(), "null field received");
  ASSERT(m_isFileOpen, "no file is open");

  if(m_firstTimePass) {
    if(m_childNumber == 1) {
      m_showNumber = TRUE;
      *m_hOut << *getNameUpper() << "UPPER = ";
    }
    else if(m_childNumber == 2) {
      m_showNumber = TRUE;
      *m_hOut << ";" << endl << "const int " << *getNameUpper() << "LOWER = ";
    }
    else if(m_childNumber == 3) {
      RefCSLOmExpr width = field->getWidth();
      *m_hOut << ";" << endl << "const int " << *getNameUpper() << "WIDTH = " << CSLOmNumber::cast(width->doEval())->getValue();
      m_firstTimePass = FALSE;
    }
    m_childNumber++;
  }
  
#ifndef __RELEASE_VERSION
  *m_hOut2 << "field - child" << endl;
#endif
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {
  ASSERT(isaField.get(), "null isa field received");
  ASSERT(m_isIsaFileOpen, "no file is open");

  if(m_firstTimePass) {
    if(m_childNumber == 1) {
      m_showNumber = TRUE;
      *m_hOutIsa << *getNameUpper() << "UPPER = ";
    }
    else if(m_childNumber == 2) {
      m_showNumber = TRUE;
      *m_hOutIsa << ";" << endl << "const int " << *getNameUpper() << "LOWER = ";
    }
    else if(m_childNumber == 3) {
      RefCSLOmExpr width = isaField->getWidth();
      *m_hOutIsa << ";" << endl << "const int " << *getNameUpper() << "WIDTH = " << CSLOmNumber::cast(width->doEval())->getValue();
      m_firstTimePass = FALSE;
    }
    m_childNumber++;
  }
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {
  ASSERT(isaElement.get(), "null isa element received");
  ASSERT(m_isIsaFileOpen, "no file is open");

  if(m_childNumber == 1) {
    m_showNumber = TRUE;
    *m_hOutIsa << *getNameUpper() << "UPPER = ";
  }
  else if(m_childNumber == 2) {
    m_showNumber = TRUE;
    *m_hOutIsa << ";" << endl << "const int " << *getNameUpper() << "LOWER = ";
  }
  else if(m_childNumber == 3) {
    RefCSLOmExpr width = isaElement->getWidth();
    *m_hOutIsa << ";" << endl << "const int " << *getNameUpper() << "WIDTH = " << CSLOmNumber::cast(width->doEval())->getValue();
  }
  m_childNumber++;
}

void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {
}
void CCPPGenerator::inTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {
}



////////////////////////
//afterTraversal block//
///////////////////////



void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {
  
#ifndef __RELEASE_VERSION
  *m_hOut2 << "expr link END" << endl;
#endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {
  ASSERT(unitDecl.get(), "null unit decl received");
  ASSERT(m_isFileOpen, "no file is open");

  //closing the INC_GUARDs
  *m_hOut << endl << "#endif" << endl;
  
  ((ofstream*)(m_hOut))->close();
  ((ofstream*)(m_cppOut))->close();
  delete m_hOut;
  delete m_cppOut;
  m_isFileOpen = FALSE;
  

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "unit END" <<endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {
  ASSERT(signal.get(), "null signal received");
  ASSERT(m_isFileOpen, "no file is open");

  *m_hOut << endl;
  m_ids->pop_back(); //popping the name of the signal
  m_ids->pop_back(); //popping the "S_"

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "signal END" << endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
  ASSERT(simpleBitRange.get(), "null simple bit range received");
  ASSERT(m_isFileOpen, "no file is open");

  //  *m_hOut << ";" << endl;
  m_showExprOp = FALSE;
  
  m_childNumber = 0;

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "bit range END" << endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
  ASSERT(multiDimBitRange.get(), "null multidim bit range received");
  ASSERT(m_isFileOpen, "no file is open");

  m_dimNo = -1;
  m_isMultiDimBitRange = FALSE;

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "multidim bit range END" << endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {
  ASSERT(groupSignal.get(), "null group signal received");
  ASSERT(m_isFileOpen, "no file is open");

  m_ids->pop_back(); //popping the name of the signal group
  m_ids->pop_back(); //popping the "SG_"
  
  #ifndef __RELEASE_VERSION
  *m_hOut2 << "sihnal group END" << endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) {
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) {
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {
  ASSERT(interface.get(), "null interface received");
  ASSERT(m_isFileOpen, "no file is open");

  if(!interface->isDefaultIfc()) {
    m_ids->pop_back(); //popping the name of the interface
    m_ids->pop_back(); //popping the "IFC_"
  }

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "interface END" << endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {
  ASSERT(portDecl.get(), "null portDecl received");

  *m_hOut << endl;
  m_ids->pop_back(); //popping the name of the port
  m_ids->pop_back(); //popping the "P_"

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "port END" << endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {
  ASSERT(exprOp.get(), "null exprOp received");
  
  m_exprOpChildNumber = 0;

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "ExprOp END" <<endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {
}
/*
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) {
}
*/

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) {
  ASSERT(enumeration.get(), "null enum received");
  ASSERT(m_isEnumFileOpen, "no file is open");
  
  *m_hOutEnum << endl << "};" << endl;
  m_childNumber = 0;
  m_isEnum = FALSE;
  m_showId = FALSE;
  
  #ifndef __RELEASE_VERSION
  *m_hOut2 << "enum END" << endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) {
  ASSERT(field.get(), "null field received");
  ASSERT(m_isFileOpen, "no file is open");
  
  m_fieldCounter--;
  if(m_fieldCounter == 0) {
    *m_hOut << ";" << endl;
  }
  else {
    m_ids->pop_back(); //popping the name of the field
    m_ids->pop_back(); //popping the "F_"
  }
  m_childNumber = 0; 
  
  #ifndef __RELEASE_VERSION
  *m_hOut2 << "field END"<< endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {
  ASSERT(isaField.get(), "null isa field received");
  ASSERT(m_isIsaFileOpen, "no file is open");
 
  m_fieldCounter--;
  if(m_fieldCounter == 0 && !m_isIsaElem) {
    *m_hOutIsa << ";" << endl << endl;
  }
  m_ids->pop_back(); //popping the name of the isaField
  m_ids->pop_back(); //popping the "IF_"
  
  m_childNumber = 0;
  

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "isa field END" <<endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {
  ASSERT(isaElement.get(), "null isa element received");
  ASSERT(m_isIsaFileOpen, "no file is open");

  *m_hOutIsa << ";" << endl << endl;
  m_isIsaElem = FALSE;
  m_childNumber = 0;
  m_ids->pop_back(); //popping the name of the isaElement
  m_ids->pop_back(); //popping the "IE_"

  #ifndef __RELEASE_VERSION
  *m_hOut2 << "isa element END" <<endl;
  #endif
}

void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {
}    
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {
}
void CCPPGenerator::afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {
}

}

