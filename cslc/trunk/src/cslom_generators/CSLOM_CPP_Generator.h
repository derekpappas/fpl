//----------------------------------------------------------------------
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

#ifndef INC_GUARD_CSLOM_CPP_Generator_h
#define INC_GUARD_CSLOM_CPP_Generator_h

#include "../cslom/CSLOM.h"
#include "../cslom/CSLOM_Visitor.h"
#include "../support/CommonSupport.h"
#include <iostream>
#include <fstream>
#include <string>
#include <stack>
#include <map>
#include <algorithm>


namespace NSCCPPGenerator {
 
class CCPPGenerator : public NSCSLOmVisitor::CVisitorTraversal {

  private:
    /**
     * Bool variable that specifies if the current node is inside a multiDimBitRange node.
     */
    TBool m_isMultiDimBitRange;
    /**
     * Counter for the dimensions of a multidim bitrange.
     */
    TInt m_dimNo;
    /**
     * Bool variable that specifies if the next number should be printed out.
     */
    TBool m_showNumber;
    /**
     * Bool variable that specifies if the next id should be added to the m_ids vector.
     *
     * @see m_ids
     */
    TBool m_showId;
    TBool m_showExprOp;
    /**
     * Variable that specifies the level of the current field.
     */
    TInt m_fieldCounter;

    TBool m_firstTimePass;
    /**
     * Bool variable that specifies if the current node is in the subtree of an enum node.
     */
    TBool m_isEnum;
    /**
     * Bool variable that specifies if the current node is in the subtree of an isa element node.
     */
    TBool m_isIsaElem;
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
    TInt m_exprOpChildNumber;

    std::string convertExprOp(NSCSLOm::CSLOmExprOp::EOpType exprOpType);

    RefTVec_RefString m_ids;
    
    std::string m_path;    
    std::ostream *m_hOut;
    std::ostream *m_cppOut;
    std::ostream *m_hOutIsa;
    std::ostream *m_hOutEnum;

    #ifndef __RELEASE_VERSION
    std::ostream *m_hOut2;
    #endif
  public :

    CCPPGenerator(std::string folder);
    ~CCPPGenerator();
    
    /**
     * There are some elements like isa field, isa element and field that are not included in the a unit
     * but need to have const ints generated. So separate file is generated for them. The file will be 
     * created only if there are such elements and will be named isa.h.
     */
    void checkForIsaFile(std::string path);
    void closeIsaFile();

    /**
     * Csl_enum elements will be transformed in c++ enums in the file enum.h. This file will be created only if there are 
     * csl_enums in the csl code.
     */
    void checkForEnumFile(std::string path);
    void closeEnumFile();
    /**
     * The function returns a RefString value composed of all the elements from the m_ids vector.
     *
     * @see m_ids
     * @returns RefString
     */
    RefString getName();
    /**
     * The function returns a RefString value composed of all the elements from the m_ids vector.
     * All the letters are in upper case.
     *
     * @see m_ids
     * @returns RefString
     */
    RefString getNameUpper();

    void beforeTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) ;  
    void beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) ;
    //    void beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) ;    
    void beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) ;
    void beforeTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) ;    
    void beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) ;    

    //inTraversal block

    void inTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) ;
    void inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) ;
    void inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) ;
    void inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) ;
    void inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) ;
    void inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) ;
    void inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) ;
    void inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) ;
    void inTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) ;
    void inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) ;
    void inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) ;
    void inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) ;
    void inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) ;
    void inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) ;
    void inTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) ;  
    void inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) ;
    void inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) ;
    void inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) ;
    //    void inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) ;
    void inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) ;
    void inTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) ; 
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) ;
    void inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) ;
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) ;
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) ;
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) ;
    void inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) ;
    void inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) ;
    void inTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) ;
    void inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) ;
    void inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) ;
    void inTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) ;    
    void inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) ;
    void inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) ;
    void inTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) ;    
    void inTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) ;    

    //afterTraversal block

    void afterTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) ;  
    void afterTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) ;
    //    void afterTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) ; 
    void afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) ;    
    void afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) ;
    void afterTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) ;    
    void afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) ;    

}; // NSCCPPGenerator





}  // namespace end

#endif
  
