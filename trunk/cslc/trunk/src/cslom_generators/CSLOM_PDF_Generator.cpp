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
#include "CSLOM_PDF_Generator.h"
using namespace NSCSLOm;
using namespace NSCSLOmVisitor;
using namespace std;
using namespace boost;

namespace NSCPDFGenerator {

CPDFGenerator::CPDFGenerator(string fName) {

}

CPDFGenerator::~CPDFGenerator() {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmInclude & fileInclude) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmDesign & design) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIdentifier & id) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprLink & exprLink) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl & unitDecl) {
   
}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSignal & signal) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance & unitInst) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange & simpleBitRange) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange & multiDimBitRange) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal & groupSignal) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmNum32 & number) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmInterface & interface) {
  
}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation & unitInstantiation) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmPortDecl & portDecl) {
}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprOp & exprOp) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprConcat & exprConcat) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat & exprMultiConcat) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmList & list) {} 

 


void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmParameter & parameter) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmListExpr & listExpr) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall & exprHybridOrFuncCall) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature & exprFuncSignature) {

}

/*
void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride & parameterOverride) {

}
*/

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmEnum & enumeration) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmField & field) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap & memoryMap) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmAddressRange & addressRange) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation & memoryMapLocation) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage & memoryMapPage) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance & memoryMapPageInstance) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmContainer & container) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIsaField & isaField) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIsaElement & isaElement) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo & unitInfo) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign & stmtAssign) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo & memInfo) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo & fifoInfo) {
} 

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo & regFileInfo) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo & regInfo) {

}

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmTBInfo & tbInfo) {

} 

void CPDFGenerator::beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo & vectorInfo) {

}   

//inTraversal

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmInclude & fileInclude) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmDesign & design) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmIdentifier & id) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {
}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
 
}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {
  
}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {

} 

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {

}

/*
void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) {

}
*/

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) {

} 

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {}   

 

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {

}

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {

}  

void CPDFGenerator::inTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {

}

//afterTraversal

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {
 
}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {} 

 

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {

}

/*
void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) {

}
*/

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {}

 

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {

}   

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {

}

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {

}   

void CPDFGenerator::afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {

}   

}// NSCPDFGenerator
