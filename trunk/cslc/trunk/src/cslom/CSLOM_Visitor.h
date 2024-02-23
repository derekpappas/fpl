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

// Author BogdanZ

#ifndef INC_GUARD_CSLOM_Visitor_h
#define INC_GUARD_CSLOM_Visitor_h

#include <iostream>
#include <bitset>
#include "CSLOM.h"
#include "CSLOM_cmd.h"
#include "../support/CommonSupport.h"

namespace NSCSLOmVisitor {

//********************************************************************************
// CVisitor class
//********************************************************************************
class CVisitor {
  protected:
    CVisitor();
  public:
    virtual void visit(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmDesign                          & design                          ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmSignal                          & signal                          ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmNum32                           & number                          ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmInterface                       & interface                       ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmList                            & list                            ) = 0;  
    //    virtual void visit(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmParameter                       & param                           ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) = 0;

    //    virtual void visit(const NSCSLOm::RefCSLOmParameterOverride               & paramOverride                   ) = 0; //
    virtual void visit(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) = 0; //
    virtual void visit(const NSCSLOm::RefCSLOmField                           & field                           ) = 0; //
    virtual void visit(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmContainer                       & container                       ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) = 0;

    virtual void visit(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) = 0;    
    virtual void visit(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) = 0;    
    virtual void visit(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) = 0;
    virtual void visit(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) = 0; 
 

    virtual ~CVisitor();                                                                        
};                                                                                            



//********************************************************************************
// CVisitorTraversal class
//********************************************************************************
class CVisitorTraversal : public CVisitor{
  private:
    typedef TBool (CVisitorTraversal::*__tbool)(void);

    TBool m_isUnitJumpEnable;
    TBool m_isIsaJumpEnable;
    TBool m_isPageJumpEnable;
    TBool m_isOnlyTopEnable;
    TBool m_noTesting;
    TBool m_noTb;
    TBool m_visitDesignFields;
    std::bitset<72> m_mask;

    enum ETraversalType {
      DESIGN_TRAVERSAL,
      DESIGN_TRAVERSAL_BEFORE,
      DESIGN_TRAVERSAL_IN,
      DESIGN_TRAVERSAL_AFTER,

      //Tb
      CHILDREN_TRAVERSAL,
      //~Tb

      OBJ_TRAVERSAL,
      OBJ_TRAVERSAL_BEFORE,
      OBJ_TRAVERSAL_IN,
      OBJ_TRAVERSAL_AFTER,

      EXPR_TRAVERSAL,
      EXPR_TRAVERSAL_BEFORE,
      EXPR_TRAVERSAL_IN,
      EXPR_TRAVERSAL_AFTER,

      CMD_TRAVERSAL,
      CMD_TRAVERSAL_BEFORE,
      CMD_TRAVERSAL_IN,
      CMD_TRAVERSAL_AFTER,

      UNIT_DECL_TRAVERSAL,
      UNIT_DECL_TRAVERSAL_BEFORE,
      UNIT_DECL_TRAVERSAL_IN,
      UNIT_DECL_TRAVERSAL_AFTER,
      
      UNIT_INSTANCE_TRAVERSAL,
      UNIT_INSTANCE_TRAVERSAL_BEFORE,
      UNIT_INSTANCE_TRAVERSAL_IN,
      UNIT_INSTANCE_TRAVERSAL_AFTER,

      UNIT_INSTANTIATION_TRAVERSAL,
      UNIT_INSTANTIATION_TRAVERSAL_BEFORE,
      UNIT_INSTANTIATION_TRAVERSAL_IN,
      UNIT_INSTANTIATION_TRAVERSAL_AFTER,

      ADDR_RANGE_TRAVERSAL,
      ADDR_RANGE_TRAVERSAL_BEFORE,
      ADDR_RANGE_TRAVERSAL_IN,
      ADDR_RANGE_TRAVERSAL_AFTER,

      MEM_MAP_LOC_TRAVERSAL,
      MEM_MAP_LOC_TRAVERSAL_BEFORE,
      MEM_MAP_LOC_TRAVERSAL_IN,
      MEM_MAP_LOC_TRAVERSAL_AFTER,

      MEM_MAP_PAGE_TRAVERSAL,
      MEM_MAP_PAGE_TRAVERSAL_BEFORE,
      MEM_MAP_PAGE_TRAVERSAL_IN,
      MEM_MAP_PAGE_TRAVERSAL_AFTER,

      MEM_MAP_PAGE_INST_TRAVERSAL,
      MEM_MAP_PAGE_INST_TRAVERSAL_BEFORE,
      MEM_MAP_PAGE_INST_TRAVERSAL_IN,
      MEM_MAP_PAGE_INST_TRAVERSAL_AFTER,

      MEM_MAP_TRAVERSAL,
      MEM_MAP_TRAVERSAL_BEFORE,
      MEM_MAP_TRAVERSAL_IN,
      MEM_MAP_TRAVERSAL_AFTER,

      CONTAINER_TRAVERSAL,
      CONTAINER_TRAVERSAL_BEFORE,
      CONTAINER_TRAVERSAL_IN,
      CONTAINER_TRAVERSAL_AFTER,

      ISA_FIELD_TRAVERSAL,
      ISA_FIELD_TRAVERSAL_BEFORE,
      ISA_FIELD_TRAVERSAL_IN,
      ISA_FIELD_TRAVERSAL_AFTER,

      ISA_ELEMENT_TRAVERSAL,
      ISA_ELEMENT_TRAVERSAL_BEFORE,
      ISA_ELEMENT_TRAVERSAL_IN,
      ISA_ELEMENT_TRAVERSAL_AFTER,

      UNIT_INFO_TRAVERSAL,
      UNIT_INFO_TRAVERSAL_BEFORE,
      UNIT_INFO_TRAVERSAL_IN,
      UNIT_INFO_TRAVERSAL_AFTER,

      STMT_TRAVERSAL,
      STMT_TRAVERSAL_BEFORE,
      STMT_TRAVERSAL_IN,
      STMT_TRAVERSAL_AFTER
    };
  protected:
    void initMaskValueEnableAll();
    void initMaskValueDisableAll();
  public:
    TBool isUnitJumpEnable() { return m_isUnitJumpEnable; }
    TBool isIsaJumpEnable() { return m_isIsaJumpEnable; }
    TBool isPageJumpEnable() { return m_isPageJumpEnable; }
    TBool isOnlyTopEnable() { return m_isOnlyTopEnable; }
    TBool noTestObjects() { return m_noTesting; }
    TBool noTestBench() { return m_noTb; }
    TBool isVisitDesignFieldsEnabled() { return m_visitDesignFields; }

    void enableUnitJump() { m_isUnitJumpEnable = TRUE; }
    void enableIsaJump() { m_isIsaJumpEnable = TRUE; }
    void enablePageJump() { m_isPageJumpEnable = TRUE; }
    void enableOnlyTop() { m_isOnlyTopEnable = TRUE; }
    void enableNoTestObjects() { m_noTesting = TRUE; }
    void enableNoTestBench() { m_noTb = TRUE; }
    void enableVisitDesignFields() { m_visitDesignFields = TRUE; }

    void disableUnitJump() { m_isUnitJumpEnable = FALSE; }
    void disableIsaJump() { m_isIsaJumpEnable = FALSE; }
    void disablePageJump() { m_isPageJumpEnable = FALSE; }
    void disableOnlyTop() { m_isOnlyTopEnable = FALSE; }
    void disableNoTestObjects() { m_noTesting = FALSE; }
    void disableNoTestBench() { m_noTb = FALSE; }
    void disableVisitDesignFields() { m_visitDesignFields = FALSE; }


    void enableDesignTraversal();
    void enableDesignBeforeTraversal();
    void enableDesignInTraversal();
    void enableDesignAfterTraversal();

    void enableChildrenTraversal();

    void enableUnitDeclTraversal();
    void enableUnitDeclBeforeTraversal();
    void enableUnitDeclInTraversal();
    void enableUnitDeclAfterTraversal();

    void enableUnitInstanceTraversal();
    void enableUnitInstanceBeforeTraversal();
    void enableUnitInstanceInTraversal();
    void enableUnitInstanceAfterTraversal();

    void enableUnitInstantiationTraversal();
    void enableUnitInstantiationBeforeTraversal();
    void enableUnitInstantiationInTraversal();
    void enableUnitInstantiationAfterTraversal();

    void disableDesignTraversal();
    void disableDesignBeforeTraversal();
    void disableDesignInTraversal();
    void disableDesignAfterTraversal();

    void disableChildrenTraversal();

    void disableUnitDeclTraversal();
    void disableUnitDeclBeforeTraversal();
    void disableUnitDeclInTraversal();
    void disableUnitDeclAfterTraversal();

    void disableUnitInstanceTraversal();
    void disableUnitInstanceBeforeTraversal();
    void disableUnitInstanceInTraversal();
    void disableUnitInstanceAfterTraversal();

    void disableUnitInstantiationTraversal();
    void disableUnitInstantiationBeforeTraversal();
    void disableUnitInstantiationInTraversal();
    void disableUnitInstantiationAfterTraversal();

    void enableAddressRangeTraversal();
    void enableAddressRangeBeforeTraversal();
    void enableAddressRangeInTraversal();
    void enableAddressRangeAfterTraversal();

    void enableMemMapLocTraversal();
    void enableMemMapLocBeforeTraversal();
    void enableMemMapLocInTraversal();
    void enableMemMapLocAfterTraversal();

    void enableMemMapPageTraversal();
    void enableMemMapPageBeforeTraversal();
    void enableMemMapPageInTraversal();
    void enableMemMapPageAfterTraversal();

    void enableMemMapPageInstTraversal();
    void enableMemMapPageInstBeforeTraversal();
    void enableMemMapPageInstInTraversal();
    void enableMemMapPageInstAfterTraversal();

    void enableMemMapTraversal();
    void enableMemMapBeforeTraversal();
    void enableMemMapInTraversal();
    void enableMemMapAfterTraversal();

    void enableContainerTraversal();
    void enableContainerBeforeTraversal();
    void enableContainerInTraversal();
    void enableContainerAfterTraversal();

    void enableIsaFieldTraversal();
    void enableIsaFieldBeforeTraversal();
    void enableIsaFieldInTraversal();
    void enableIsaFieldAfterTraversal();

    void enableIsaElementTraversal();
    void enableIsaElementBeforeTraversal();
    void enableIsaElementInTraversal();
    void enableIsaElementAfterTraversal();

    void enableUnitInfoTraversal();
    void enableUnitInfoBeforeTraversal();
    void enableUnitInfoInTraversal();
    void enableUnitInfoAfterTraversal();

    void enableStmtTraversal();
    void enableStmtBeforeTraversal();
    void enableStmtInTraversal();
    void enableStmtAfterTraversal();

    void disableAddressRangeTraversal();
    void disableAddressRangeBeforeTraversal();
    void disableAddressRangeInTraversal();
    void disableAddressRangeAfterTraversal();

    void disableMemMapLocTraversal();
    void disableMemMapLocBeforeTraversal();
    void disableMemMapLocInTraversal();
    void disableMemMapLocAfterTraversal();

    void disableMemMapPageTraversal();
    void disableMemMapPageBeforeTraversal();
    void disableMemMapPageInTraversal();
    void disableMemMapPageAfterTraversal();

    void disableMemMapPageInstTraversal();
    void disableMemMapPageInstBeforeTraversal();
    void disableMemMapPageInstInTraversal();
    void disableMemMapPageInstAfterTraversal();

    void disableMemMapTraversal();
    void disableMemMapBeforeTraversal();
    void disableMemMapInTraversal();
    void disableMemMapAfterTraversal();

    void disableContainerTraversal();
    void disableContainerBeforeTraversal();
    void disableContainerInTraversal();
    void disableContainerAfterTraversal();

    void disableIsaFieldTraversal();
    void disableIsaFieldBeforeTraversal();
    void disableIsaFieldInTraversal();
    void disableIsaFieldAfterTraversal();

    void disableIsaElementTraversal();
    void disableIsaElementBeforeTraversal();
    void disableIsaElementInTraversal();
    void disableIsaElementAfterTraversal();

    void disableUnitInfoTraversal();
    void disableUnitInfoBeforeTraversal();
    void disableUnitInfoInTraversal();
    void disableUnitInfoAfterTraversal();

    void disableStmtTraversal();
    void disableStmtBeforeTraversal();
    void disableStmtInTraversal();
    void disableStmtAfterTraversal();

    void enableObjBeforeTraversal();
    void enableObjAfterTraversal();
    void enableObjInTraversal();
  
    void enableObjTraversal();
    void enableExprTraversal();
    void enableCmdTraversal();
    void enableInTraversal();
    void disableObjTraversal();
    void disableExprTraversal();
    void disableCmdTraversal();

    TBool isObjTraversalEnabled()       { return m_mask.test(OBJ_TRAVERSAL); }
    TBool isObjBeforeTraversalEnabled() { return m_mask.test(OBJ_TRAVERSAL_BEFORE); }
    TBool isObjInTraversalEnabled()     { return m_mask.test(OBJ_TRAVERSAL_IN); }
    TBool isObjAfterTraversalEnabled()  { return m_mask.test(OBJ_TRAVERSAL_AFTER); }

    TBool isExprTraversalEnabled()       { return m_mask.test(EXPR_TRAVERSAL); }
    TBool isExprBeforeTraversalEnabled() { return m_mask.test(EXPR_TRAVERSAL_BEFORE); }
    TBool isExprInTraversalEnabled()     { return m_mask.test(EXPR_TRAVERSAL_IN); }
    TBool isExprAfterTraversalEnabled()  { return m_mask.test(EXPR_TRAVERSAL_AFTER); }

    TBool isCmdTraversalEnabled()       { return m_mask.test(CMD_TRAVERSAL); }
    TBool isCmdBeforeTraversalEnabled() { return m_mask.test(CMD_TRAVERSAL_BEFORE); }
    TBool isCmdInTraversalEnabled()     { return m_mask.test(CMD_TRAVERSAL_IN); }
    TBool isCmdAfterTraversalEnabled()  { return m_mask.test(CMD_TRAVERSAL_AFTER); }

    TBool isDesignTraversalEnabled()       { return m_mask.test(DESIGN_TRAVERSAL); }
    TBool isDesignBeforeTraversalEnabled() { return m_mask.test(DESIGN_TRAVERSAL_BEFORE); }
    TBool isDesignInTraversalEnabled()     { return m_mask.test(DESIGN_TRAVERSAL_IN); }
    TBool isDesignAfterTraversalEnabled()  { return m_mask.test(DESIGN_TRAVERSAL_AFTER); }

    TBool isChildrenTraversalEnabled() { return m_mask.test(CHILDREN_TRAVERSAL); }
    
    TBool isUnitDeclTraversalEnabled()       { return m_mask.test(UNIT_DECL_TRAVERSAL); }
    TBool isUnitDeclBeforeTraversalEnabled() { return m_mask.test(UNIT_DECL_TRAVERSAL_BEFORE); }
    TBool isUnitDeclInTraversalEnabled()     { return m_mask.test(UNIT_DECL_TRAVERSAL_IN); }
    TBool isUnitDeclAfterTraversalEnabled()  { return m_mask.test(UNIT_DECL_TRAVERSAL_AFTER); }

    TBool isUnitInstanceTraversalEnabled()       { return m_mask.test(UNIT_INSTANCE_TRAVERSAL); }
    TBool isUnitInstanceBeforeTraversalEnabled() { return m_mask.test(UNIT_INSTANCE_TRAVERSAL_BEFORE); }
    TBool isUnitInstanceInTraversalEnabled()     { return m_mask.test(UNIT_INSTANCE_TRAVERSAL_IN); }
    TBool isUnitInstanceAfterTraversalEnabled()  { return m_mask.test(UNIT_INSTANCE_TRAVERSAL_AFTER); }

    TBool isUnitInstantiationTraversalEnabled()       { return m_mask.test(UNIT_INSTANTIATION_TRAVERSAL); }
    TBool isUnitInstantiationBeforeTraversalEnabled() { return m_mask.test(UNIT_INSTANTIATION_TRAVERSAL_BEFORE); }
    TBool isUnitInstantiationInTraversalEnabled()     { return m_mask.test(UNIT_INSTANTIATION_TRAVERSAL_IN); }
    TBool isUnitInstantiationAfterTraversalEnabled()  { return m_mask.test(UNIT_INSTANTIATION_TRAVERSAL_AFTER); }

    TBool isAddressRangeTraversalEnabled()       { return m_mask.test(ADDR_RANGE_TRAVERSAL); }
    TBool isAddressRangeBeforeTraversalEnabled() { return m_mask.test(ADDR_RANGE_TRAVERSAL_BEFORE); }
    TBool isAddressRangeInTraversalEnabled()     { return m_mask.test(ADDR_RANGE_TRAVERSAL_IN); }
    TBool isAddressRangeAfterTraversalEnabled()  { return m_mask.test(ADDR_RANGE_TRAVERSAL_AFTER); }

    TBool isMemMapLocTraversalEnabled()       { return m_mask.test(MEM_MAP_LOC_TRAVERSAL); }
    TBool isMemMapLocBeforeTraversalEnabled() { return m_mask.test(MEM_MAP_LOC_TRAVERSAL_BEFORE); }
    TBool isMemMapLocInTraversalEnabled()     { return m_mask.test(MEM_MAP_LOC_TRAVERSAL_IN); }
    TBool isMemMapLocAfterTraversalEnabled()  { return m_mask.test(MEM_MAP_LOC_TRAVERSAL_AFTER); }

    TBool isMemMapPageTraversalEnabled()       { return m_mask.test(MEM_MAP_PAGE_TRAVERSAL); }
    TBool isMemMapPageBeforeTraversalEnabled() { return m_mask.test(MEM_MAP_PAGE_TRAVERSAL_BEFORE); }
    TBool isMemMapPageInTraversalEnabled()     { return m_mask.test(MEM_MAP_PAGE_TRAVERSAL_IN); }
    TBool isMemMapPageAfterTraversalEnabled()  { return m_mask.test(MEM_MAP_PAGE_TRAVERSAL_AFTER); }

    TBool isMemMapPageInstTraversalEnabled()       { return m_mask.test(MEM_MAP_PAGE_INST_TRAVERSAL); }
    TBool isMemMapPageInstBeforeTraversalEnabled() { return m_mask.test(MEM_MAP_PAGE_INST_TRAVERSAL_BEFORE); }
    TBool isMemMapPageInstInTraversalEnabled()     { return m_mask.test(MEM_MAP_PAGE_INST_TRAVERSAL_IN); }
    TBool isMemMapPageInstAfterTraversalEnabled()  { return m_mask.test(MEM_MAP_PAGE_INST_TRAVERSAL_AFTER); }

    TBool isMemMapTraversalEnabled()       { return m_mask.test(MEM_MAP_TRAVERSAL); }
    TBool isMemMapBeforeTraversalEnabled() { return m_mask.test(MEM_MAP_TRAVERSAL_BEFORE); }
    TBool isMemMapInTraversalEnabled()     { return m_mask.test(MEM_MAP_TRAVERSAL_IN); }
    TBool isMemMapAfterTraversalEnabled()  { return m_mask.test(MEM_MAP_TRAVERSAL_AFTER); }

    TBool isContainerTraversalEnabled()       { return m_mask.test(CONTAINER_TRAVERSAL); }
    TBool isContainerBeforeTraversalEnabled() { return m_mask.test(CONTAINER_TRAVERSAL_BEFORE); }
    TBool isContainerInTraversalEnabled()     { return m_mask.test(CONTAINER_TRAVERSAL_IN); }
    TBool isContainerAfterTraversalEnabled()  { return m_mask.test(CONTAINER_TRAVERSAL_AFTER); }

    TBool isIsaFieldTraversalEnabled()       { return m_mask.test(ISA_FIELD_TRAVERSAL); }
    TBool isIsaFieldBeforeTraversalEnabled() { return m_mask.test(ISA_FIELD_TRAVERSAL_BEFORE); }
    TBool isIsaFieldInTraversalEnabled()     { return m_mask.test(ISA_FIELD_TRAVERSAL_IN); }
    TBool isIsaFieldAfterTraversalEnabled()  { return m_mask.test(ISA_FIELD_TRAVERSAL_AFTER); }

    TBool isIsaElementTraversalEnabled()       { return m_mask.test(ISA_ELEMENT_TRAVERSAL); }
    TBool isIsaElementBeforeTraversalEnabled() { return m_mask.test(ISA_ELEMENT_TRAVERSAL_BEFORE); }
    TBool isIsaElementInTraversalEnabled()     { return m_mask.test(ISA_ELEMENT_TRAVERSAL_IN); }
    TBool isIsaElementAfterTraversalEnabled()  { return m_mask.test(ISA_ELEMENT_TRAVERSAL_AFTER); }

    TBool isUnitInfoTraversalEnabled()       { return m_mask.test(UNIT_INFO_TRAVERSAL); }
    TBool isUnitInfoBeforeTraversalEnabled() { return m_mask.test(UNIT_INFO_TRAVERSAL_BEFORE); }
    TBool isUnitInfoInTraversalEnabled()     { return m_mask.test(UNIT_INFO_TRAVERSAL_IN); }
    TBool isUnitInfoAfterTraversalEnabled()  { return m_mask.test(UNIT_INFO_TRAVERSAL_AFTER); }

    TBool isStmtTraversalEnabled()       { return m_mask.test(STMT_TRAVERSAL); }
    TBool isStmtBeforeTraversalEnabled() { return m_mask.test(STMT_TRAVERSAL_BEFORE); }
    TBool isStmtInTraversalEnabled()     { return m_mask.test(STMT_TRAVERSAL_IN); }
    TBool isStmtAfterTraversalEnabled()  { return m_mask.test(STMT_TRAVERSAL_AFTER); }

  public:
    CVisitorTraversal();
    void visit(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     );
    void visit(const NSCSLOm::RefCSLOmDesign                          & design                          );
    void visit(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void visit(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        );
    void visit(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        );
    void visit(const NSCSLOm::RefCSLOmSignal                          & signal                          );
    void visit(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        );
    void visit(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  );
    void visit(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                );
    void visit(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     );
    void visit(const NSCSLOm::RefCSLOmNum32                           & number                          );
    void visit(const NSCSLOm::RefCSLOmInterface                       & interface                       );
    void visit(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               );
    void visit(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        );
    void visit(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          );
    void visit(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      );
    void visit(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 );
    void visit(const NSCSLOm::RefCSLOmList                            & list                            );  
    //    void visit(const NSCSLOm::RefCSLOmParameter                       & parameter                       );
    void visit(const NSCSLOm::RefCSLOmParameter                       & param                           );
    void visit(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        );
    void visit(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            );
    void visit(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               );
    //    void visit(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               );

    void visit(const NSCSLOm::RefCSLOmEnum                            & enumeration                     );
    void visit(const NSCSLOm::RefCSLOmField                           & field                           );
    void visit(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ); 
    void visit(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void visit(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void visit(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void visit(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           );
    void visit(const NSCSLOm::RefCSLOmContainer                       & container                       );
    void visit(const NSCSLOm::RefCSLOmIsaField                        & isaField                        );
    void visit(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      );

    void visit(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        );
    void visit(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      );
    void visit(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         );
    void visit(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        );    
    void visit(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     );
    void visit(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         );
    void visit(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          );    
    void visit(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      );
    void visit(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         );



    virtual void beforeTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) = 0;  
    //    virtual void beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & param                           ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) = 0;
    //    virtual void beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) = 0;

    virtual void beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) = 0;

    virtual void beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) = 0;    
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) = 0;    
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) = 0;
    virtual void beforeTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) = 0;


    virtual void inTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) = 0;  
    //    virtual void inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmParameter                       & param                           ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) = 0;
    //    virtual void inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ) = 0;

    virtual void inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmField                           & field                           ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ) = 0;

    virtual void inTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) = 0;    
    virtual void inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) = 0;    
    virtual void inTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) = 0;
    virtual void inTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) = 0;

    virtual void afterTraversal(const NSCSLOm::RefCSLOmInclude                         & fileInclude                     ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            ) = 0;  
    //    virtual void afterTraversal(const NSCSLOm::RefCSLOmParameter                         & parameter                       ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmParameter                       & param                           ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmListExpr                          & listExpr                        ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall              & exprHybridOrFuncCall            ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature                 & exprFuncSignature               ) = 0;
    //    virtual void afterTraversal(const NSCSLOm::RefCSLOmParameterOverride                 & parameterOverride               ) = 0;

    virtual void afterTraversal(const NSCSLOm::RefCSLOmEnum                              & enumeration                     ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmField                             & field                           ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                         & memoryMap                       ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmAddressRange                      & addressRange                    ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation                 & memoryMapLocation               ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                     & memoryMapPage                   ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance             & memoryMapPageInstance           ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmContainer                         & container                       ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmIsaField                          & isaField                        ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmIsaElement                        & isaElement                      ) = 0;

    virtual void afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) = 0;    
    virtual void afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) = 0;    
    virtual void afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) = 0;
    virtual void afterTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ) = 0;

    ~CVisitorTraversal();
};

} // end namespace NSCdomVisitor

#endif /*INC_GUARD_CDOM_Visitor_h*/
