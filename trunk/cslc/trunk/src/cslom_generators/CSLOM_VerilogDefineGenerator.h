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
#ifndef INC_GUARD_CSLOM_Verilog_Define_Generator_h
#define INC_GUARD_CSLOM_Verilog_Define_Generator_h

#include "../cslom/CSLOM.h"
#include "../cslom/CSLOM_Visitor.h"
#include "../support/CommonSupport.h"
#include <iostream>
#include <fstream>
#include <string>
#include <stack>
#include <map>
#include <algorithm>


using namespace NSCSLOmVisitor;

namespace NSCVerilogDefineGenerator {

class CVerilogDefineGenerator: public CVisitorTraversal{

  private:
    //used for AddressRange
    //TInt m_childCountAddressRange;//to remember at wich child is(used in inTraversal)
    //TInt m_noChildren;//number of total children of an AddressRange node(can be 3 or 4)
    //TBool m_isAddressRange;

    //used for memoryMapLocation
    // RefString m_memoryMapLocationId;
    //TBool m_isMemoryMapLocation;
    ///TInt m_counter;
    //NSCSLOm::RefCSLOmAddressRange m_gladd; //global adress
    // NSCSLOm::RefCSLOmAddressRange m_lcadd; //local adress
    //NSCSLOm::RefCSLOmNumber m_lu; //lower or upper number
    //RefString m_localOrGlobal;

    //used for memoryMap
    //RefString m_mapSuffix;
    //RefString m_mapPrefix;

    //RefString m_localName;//= RefString(new string("_LOCAL"));
    //RefString m_globalName;//= RefString(new string("_GLOBAL"));
    
    //used for memoryMapPage
    //RefString m_pageSuffix;
    //RefString m_pagePrefix;

    /**
     * Bool variable that specifies if the current node is inside a simpleBitRange node.
     */
    TBool m_isSimpleBitRange;
     /**
     * Bool variable that specifies if the current node is inside a multiDimBitRange node.
     */
    TBool m_isMultiDimBitRange;
    /**
     * Counter for the dimensions of a multidim bitrange.
     */
    TInt m_dimNo;
     /**
     * Bool variable that specifies if the next id should be printed out.
     */
    TBool m_printId;
    /**
     * Bool variable that specifies if the next number should be printed out.
     */
    TBool m_showNumber;
    /**
     * Bool variable that specifies if the current field is an instance or not. If there is no current field, then it has the value FALSE.
     */
    TInt m_fieldCounter;
    TBool m_firstTimePass;
    /**
     * Bool variable that specifies if the current isaField is an instance or not. If there is no current isaField, then it has the value FALSE.
     */
    TBool m_isIsaFieldInstance;
    /**
     * Bool variable that specifies if the current element has a default bitrange or not.
     */
    TBool m_isDefaultBitRange;
     /**
     * Bool variable that specifies if the current element is a signal or a port.
     */
    TBool m_isIsaElem;
     /**
     * Bool variable that specifies if the current node is in the subtree of an enum node.
     */
    TBool m_isEnum;
     /**
     * Bool variable that specifies if an output file is open. An output file is created and opened foe every unit in the csl code.
     */
    TBool m_isFileOpen;
    /**
     * Bool variable that specifies if the isa output file is open. Isa elements and fields are outside of a unit so there will be no output file opened. So a new file is 
     * necessary.
     */
    TBool m_isIsaFileOpen;
    /**
     * Bool variable that specifies if the enum output file is open.
     */
    TBool m_isEnumFileOpen;     
      /**
     * Counter for the children of a node.
     */
    TInt m_childNumber;
     /**
     * Counter for the children of a expr. op. node.
     */
    TInt m_opCounter;
     /**
     *Variable that keeps the value of the current interface or signal group.
     */
    //RefString m_ifcSgName;
     /**
     *Variable that keeps the value of the current field 
     */
    //RefString m_fieldName;
    
    RefTVec_RefString m_ids;
    RefString m_name;
    std::string m_path;
    std::ostream *m_out;
    std::ostream *m_outIsa;
    std::ostream *m_outEnum;
    // TBool m_hasFile;

  public:

    CVerilogDefineGenerator(std::string fileName);
    ~CVerilogDefineGenerator();

    void checkForIsaFile(std::string path);
    void closeIsaFile();
    void checkForEnumFile(std::string path);
    void closeEnumFile();
    RefString getName();
    RefString getNameUpper();
    std::string convertExprOp(NSCSLOm::CSLOmExprOp::EOpType);
   
    //beforeTraversal block

    void beforeTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {}  
    void beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {}
    //    void beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) ;
    
     void beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {}
    //inTraversal block

    void inTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) {}
    void inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) ;
    void inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) ;
    void inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) ;
    void inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {}
    void inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) ;
    void inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) ;
    void inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) ;
    void inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) ;
    void inTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) ;
    void inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) ;
    void inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {}
    void inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) ;
    void inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {}
    void inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {}
    void inTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {}  
    void inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {}
    void inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {}
    void inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {}
    void inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {}
    //    void inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) {}
    void inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) ;
    void inTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) ;
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) ;
    void inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) ;
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) ;
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) ;
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {}
    void inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {}
    void inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) ;

    void inTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {}
    void inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {}
    void inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {}
    void inTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {}
    void inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {}
    void inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {}
    void inTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {}
    void inTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {}

    //afterTraversal block

    void afterTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) {}  
    void afterTraversal(const NSCSLOm::RefCSLOmParameter                         & parameter                       ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmListExpr                          & listExpr                        ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall              & exprHybridOrFuncCall            ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature                 & exprFuncSignature               ) {}
    //    void afterTraversal(const NSCSLOm::RefCSLOmParameterOverride                 & parameterOverride               ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmEnum                              & enumeration                     ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmField                             & field                           ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                         & memoryMap                       ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmAddressRange                      & addressRange                    ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation                 & memoryMapLocation               ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                     & memoryMapPage                   ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) {} 
    void afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) ;
    
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {}

};

} //namespace end

#endif
