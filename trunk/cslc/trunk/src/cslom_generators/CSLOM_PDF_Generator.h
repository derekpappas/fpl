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
#ifndef INC_GUARD_CSLOM_PDF_Generator_h
#define INC_GUARD_CSLOM_PDF_Generator_h

#include "../cslom/CSLOM.h"
#include "../cslom/CSLOM_Visitor.h"
#include "../cslom/CSLOM_Declarations.h"
#include "CSLOM_PDF_Draw.h"
#include "../support/CommonSupport.h"
#include <iostream>
#include <fstream>
#include <string>
#include <stack>
#include <map>

using namespace std;
using namespace NSCSLOm;
using namespace NSCSLOmVisitor;

namespace NSCPDFGenerator {

class CPDFGenerator : public NSCSLOmVisitor::CVisitorTraversal {
  private :

  public :
    CPDFGenerator(string fName);
    ~CPDFGenerator();

    //beforeTraversal block
    void beforeTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     );
    void beforeTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          );
    void beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          );
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  );
    void beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                );
    void beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     );
    void beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          );
    void beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               );
    void beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 );
    void beforeTraversal(const NSCSLOm::RefCSLOmList                            & list                            );  
    void beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               );
    //    void beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               );
    void beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     );
    void beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           );
    void beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      );
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         );
    void beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        );    
    void beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     );
    void beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         );
    void beforeTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          );    
    void beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      );    

    //inTraversal block
    void inTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     );
    void inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          );
    void inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        );
    void inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        );
    void inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          );
    void inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        );
    void inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  );
    void inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                );
    void inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     );
    void inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          );
    void inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       );
    void inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               );
    void inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        );
    void inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          );
    void inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      );
    void inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 );
    void inTraversal(const NSCSLOm::RefCSLOmList                            & list                            );
    void inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       );
    void inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        );
    void inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            );
    void inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               );
    //    void inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               );
    void inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     );
    void inTraversal(const NSCSLOm::RefCSLOmField                           & field                           );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       );
    void inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           );
    void inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       );
    void inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        );
    void inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      );
    void inTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        );
    void inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         );
    void inTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ); 
    void inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     );
    void inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         );
    void inTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ); 
    void inTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ); 

    //afterTraversal block
    void afterTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     );
    void afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          );
    void afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        );
    void afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        );
    void afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          );
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        );
    void afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  );
    void afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                );
    void afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     );
    void afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          );
    void afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       );
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               );
    void afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        );
    void afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          );
    void afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      );
    void afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 );
    void afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            );
    void afterTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       );
    void afterTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        );
    void afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            );
    void afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               );
    //    void afterTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               );
    void afterTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     );
    void afterTraversal(const NSCSLOm::RefCSLOmField                           & field                           );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       );
    void afterTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           );
    void afterTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       );
    void afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        );
    void afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      );
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        );
    void afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         );
    void afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        );
    void afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     );
    void afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         );
    void afterTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          );
    void afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      );
};
}//NSCPDFGenerator

#endif