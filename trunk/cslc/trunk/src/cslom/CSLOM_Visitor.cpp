//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007, 2008 FastPath Logic
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

#include <iostream>
#include <iterator>
#include "CSLOM.h"
#include "CSLOM_Visitor.h"

using namespace NSCSLOm;

namespace NSCSLOmVisitor {

CVisitor::CVisitor() { }
CVisitor::~CVisitor() { }

CVisitorTraversal::CVisitorTraversal():
  m_isUnitJumpEnable(FALSE),
  m_isIsaJumpEnable(FALSE),
  m_isPageJumpEnable(FALSE),
  m_isOnlyTopEnable(FALSE),
  m_noTesting(FALSE),
  m_noTb(FALSE),
  m_visitDesignFields(FALSE) { 
  initMaskValueEnableAll();
}

CVisitorTraversal::~CVisitorTraversal() { }

void CVisitorTraversal::initMaskValueEnableAll() {
  //initialize the mask with 1's
  m_mask.set();
}

void CVisitorTraversal::initMaskValueDisableAll() {
  //initialize the mask with 1's
  m_mask.reset();
  enableChildrenTraversal();
}

void CVisitorTraversal::enableObjTraversal() {
  m_mask.set(OBJ_TRAVERSAL);
}

void CVisitorTraversal::enableExprTraversal() {
  m_mask.set(EXPR_TRAVERSAL);
}

void CVisitorTraversal::enableCmdTraversal() {
  m_mask.set(CMD_TRAVERSAL);
}

void CVisitorTraversal::enableObjBeforeTraversal() {
  m_mask.set(OBJ_TRAVERSAL_BEFORE); 
}

void CVisitorTraversal::enableObjAfterTraversal() {
  m_mask.set(OBJ_TRAVERSAL_AFTER); 
}

void CVisitorTraversal::enableObjInTraversal() {
  m_mask.set(OBJ_TRAVERSAL_IN); 
}

void CVisitorTraversal::disableObjTraversal() {
  m_mask.reset(OBJ_TRAVERSAL);
}

void CVisitorTraversal::disableExprTraversal() {
  m_mask.reset(EXPR_TRAVERSAL);
}

void CVisitorTraversal::disableCmdTraversal() {
  m_mask.reset(CMD_TRAVERSAL);
}

void CVisitorTraversal::enableDesignTraversal() {
  m_mask.set(DESIGN_TRAVERSAL);
}
void CVisitorTraversal::enableDesignBeforeTraversal() {
  m_mask.set(DESIGN_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableDesignInTraversal() {
  m_mask.set(DESIGN_TRAVERSAL_IN);
}
void CVisitorTraversal::enableDesignAfterTraversal() {
  m_mask.set(DESIGN_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableChildrenTraversal(){
  m_mask.set(CHILDREN_TRAVERSAL);
}

void CVisitorTraversal::enableUnitDeclTraversal() {
  m_mask.set(UNIT_DECL_TRAVERSAL);
}
void CVisitorTraversal::enableUnitDeclBeforeTraversal() {
  m_mask.set(UNIT_DECL_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableUnitDeclInTraversal() {
  m_mask.set(UNIT_DECL_TRAVERSAL_IN);
}
void CVisitorTraversal::enableUnitDeclAfterTraversal() {
  m_mask.set(UNIT_DECL_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableUnitInstanceTraversal() {
  m_mask.set(UNIT_INSTANCE_TRAVERSAL);
}
void CVisitorTraversal::enableUnitInstanceBeforeTraversal() {
  m_mask.set(UNIT_INSTANCE_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableUnitInstanceInTraversal() {
  m_mask.set(UNIT_INSTANCE_TRAVERSAL_IN);
}
void CVisitorTraversal::enableUnitInstanceAfterTraversal() {
  m_mask.set(UNIT_INSTANCE_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableUnitInstantiationTraversal() {
  m_mask.set(UNIT_INSTANTIATION_TRAVERSAL);
}
void CVisitorTraversal::enableUnitInstantiationBeforeTraversal() {
  m_mask.set(UNIT_INSTANTIATION_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableUnitInstantiationInTraversal() {
  m_mask.set(UNIT_INSTANTIATION_TRAVERSAL_IN);
}
void CVisitorTraversal::enableUnitInstantiationAfterTraversal() {
  m_mask.set(UNIT_INSTANTIATION_TRAVERSAL_AFTER);
}

void CVisitorTraversal::disableDesignTraversal() {
  m_mask.reset(DESIGN_TRAVERSAL);
}
void CVisitorTraversal::disableDesignBeforeTraversal() {
  m_mask.reset(DESIGN_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableDesignInTraversal() {
  m_mask.reset(DESIGN_TRAVERSAL_IN);
}
void CVisitorTraversal::disableDesignAfterTraversal() {
  m_mask.reset(DESIGN_TRAVERSAL_AFTER);
}

void CVisitorTraversal::disableChildrenTraversal() {
  m_mask.reset(CHILDREN_TRAVERSAL);
}

void CVisitorTraversal::disableUnitDeclTraversal() {
  m_mask.reset(UNIT_DECL_TRAVERSAL);
}
void CVisitorTraversal::disableUnitDeclBeforeTraversal() {
  m_mask.reset(UNIT_DECL_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableUnitDeclInTraversal() {
  m_mask.reset(UNIT_DECL_TRAVERSAL_IN);
}
void CVisitorTraversal::disableUnitDeclAfterTraversal() {
  m_mask.reset(UNIT_DECL_TRAVERSAL_AFTER);
}

void CVisitorTraversal::disableUnitInstanceTraversal() {
  m_mask.reset(UNIT_INSTANCE_TRAVERSAL);
}
void CVisitorTraversal::disableUnitInstanceBeforeTraversal() {
  m_mask.reset(UNIT_INSTANCE_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableUnitInstanceInTraversal() {
  m_mask.reset(UNIT_INSTANCE_TRAVERSAL_IN);
}
void CVisitorTraversal::disableUnitInstanceAfterTraversal() {
  m_mask.reset(UNIT_INSTANCE_TRAVERSAL_AFTER);
}

void CVisitorTraversal::disableUnitInstantiationTraversal() {
  m_mask.reset(UNIT_INSTANTIATION_TRAVERSAL);
}
void CVisitorTraversal::disableUnitInstantiationBeforeTraversal() {
  m_mask.reset(UNIT_INSTANTIATION_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableUnitInstantiationInTraversal() {
  m_mask.reset(UNIT_INSTANTIATION_TRAVERSAL_IN);
}
void CVisitorTraversal::disableUnitInstantiationAfterTraversal() {
  m_mask.reset(UNIT_INSTANTIATION_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableAddressRangeTraversal() {
  m_mask.set(ADDR_RANGE_TRAVERSAL);
}
void CVisitorTraversal::enableAddressRangeBeforeTraversal() {
  m_mask.set(ADDR_RANGE_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableAddressRangeInTraversal() {
  m_mask.set(ADDR_RANGE_TRAVERSAL_IN);
}
void CVisitorTraversal::enableAddressRangeAfterTraversal() {
  m_mask.set(ADDR_RANGE_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableMemMapLocTraversal() {
  m_mask.set(MEM_MAP_LOC_TRAVERSAL);
}
void CVisitorTraversal::enableMemMapLocBeforeTraversal() {
  m_mask.set(MEM_MAP_LOC_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableMemMapLocInTraversal() {
  m_mask.set(MEM_MAP_LOC_TRAVERSAL_IN);
}
void CVisitorTraversal::enableMemMapLocAfterTraversal() {
  m_mask.set(MEM_MAP_LOC_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableMemMapPageTraversal() {
  m_mask.set(MEM_MAP_PAGE_TRAVERSAL);
}
void CVisitorTraversal::enableMemMapPageBeforeTraversal() {
  m_mask.set(MEM_MAP_PAGE_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableMemMapPageInTraversal() {
  m_mask.set(MEM_MAP_PAGE_TRAVERSAL_IN);
}
void CVisitorTraversal::enableMemMapPageAfterTraversal() {
  m_mask.set(MEM_MAP_PAGE_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableMemMapPageInstTraversal() {
  m_mask.set(MEM_MAP_PAGE_INST_TRAVERSAL);
}
void CVisitorTraversal::enableMemMapPageInstBeforeTraversal() {
  m_mask.set(MEM_MAP_PAGE_INST_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableMemMapPageInstInTraversal() {
  m_mask.set(MEM_MAP_PAGE_INST_TRAVERSAL_IN);
}
void CVisitorTraversal::enableMemMapPageInstAfterTraversal() {
  m_mask.set(MEM_MAP_PAGE_INST_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableMemMapTraversal() {
  m_mask.set(MEM_MAP_TRAVERSAL);
}
void CVisitorTraversal::enableMemMapBeforeTraversal() {
  m_mask.set(MEM_MAP_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableMemMapInTraversal() {
  m_mask.set(MEM_MAP_TRAVERSAL_IN);
}
void CVisitorTraversal::enableMemMapAfterTraversal() {
  m_mask.set(MEM_MAP_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableContainerTraversal() {
  m_mask.set(CONTAINER_TRAVERSAL);
}
void CVisitorTraversal::enableContainerBeforeTraversal() {
  m_mask.set(CONTAINER_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableContainerInTraversal() {
  m_mask.set(CONTAINER_TRAVERSAL_IN);
}
void CVisitorTraversal::enableContainerAfterTraversal() {
  m_mask.set(CONTAINER_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableIsaFieldTraversal() {
  m_mask.set(ISA_FIELD_TRAVERSAL);
}
void CVisitorTraversal::enableIsaFieldBeforeTraversal() {
  m_mask.set(ISA_FIELD_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableIsaFieldInTraversal() {
  m_mask.set(ISA_FIELD_TRAVERSAL_IN);
}
void CVisitorTraversal::enableIsaFieldAfterTraversal() {
  m_mask.set(ISA_FIELD_TRAVERSAL_AFTER);
}
void CVisitorTraversal::enableIsaElementTraversal() {
  m_mask.set(ISA_ELEMENT_TRAVERSAL);
}
void CVisitorTraversal::enableIsaElementBeforeTraversal() {
  m_mask.set(ISA_ELEMENT_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableIsaElementInTraversal() {
  m_mask.set(ISA_ELEMENT_TRAVERSAL_IN);
}
void CVisitorTraversal::enableIsaElementAfterTraversal() {
  m_mask.set(ISA_ELEMENT_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableUnitInfoTraversal() {
  m_mask.set(UNIT_INFO_TRAVERSAL);
}
void CVisitorTraversal::enableUnitInfoBeforeTraversal() {
  m_mask.set(UNIT_INFO_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableUnitInfoInTraversal() {
  m_mask.set(UNIT_INFO_TRAVERSAL_IN);
}
void CVisitorTraversal::enableUnitInfoAfterTraversal() {
  m_mask.set(UNIT_INFO_TRAVERSAL_AFTER);
}

void CVisitorTraversal::enableStmtTraversal() {
  m_mask.set(STMT_TRAVERSAL);
}
void CVisitorTraversal::enableStmtBeforeTraversal() {
  m_mask.set(STMT_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::enableStmtInTraversal() {
  m_mask.set(STMT_TRAVERSAL_IN);
}
void CVisitorTraversal::enableStmtAfterTraversal() {
  m_mask.set(STMT_TRAVERSAL_AFTER);
}


void CVisitorTraversal::disableAddressRangeTraversal() {
  m_mask.reset(ADDR_RANGE_TRAVERSAL);
}
void CVisitorTraversal::disableAddressRangeBeforeTraversal() {
  m_mask.reset(ADDR_RANGE_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableAddressRangeInTraversal() {
  m_mask.reset(ADDR_RANGE_TRAVERSAL_IN);
}
void CVisitorTraversal::disableAddressRangeAfterTraversal() {
  m_mask.reset(ADDR_RANGE_TRAVERSAL_AFTER);
}

void CVisitorTraversal::disableMemMapLocTraversal() {
  m_mask.reset(MEM_MAP_LOC_TRAVERSAL);
}
void CVisitorTraversal::disableMemMapLocBeforeTraversal() {
  m_mask.reset(MEM_MAP_LOC_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableMemMapLocInTraversal() {
  m_mask.reset(MEM_MAP_LOC_TRAVERSAL_IN);
}
void CVisitorTraversal::disableMemMapLocAfterTraversal() {
  m_mask.reset(MEM_MAP_LOC_TRAVERSAL_AFTER);
}

void CVisitorTraversal::disableMemMapPageTraversal() {
  m_mask.reset(MEM_MAP_PAGE_TRAVERSAL);
}
void CVisitorTraversal::disableMemMapPageBeforeTraversal() {
  m_mask.reset(MEM_MAP_PAGE_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableMemMapPageInTraversal() {
  m_mask.reset(MEM_MAP_PAGE_TRAVERSAL_IN);
}
void CVisitorTraversal::disableMemMapPageAfterTraversal() {
  m_mask.reset(MEM_MAP_PAGE_TRAVERSAL_AFTER);
}

void CVisitorTraversal::disableMemMapPageInstTraversal() {
  m_mask.reset(MEM_MAP_PAGE_INST_TRAVERSAL);
}
void CVisitorTraversal::disableMemMapPageInstBeforeTraversal() {
  m_mask.reset(MEM_MAP_PAGE_INST_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableMemMapPageInstInTraversal() {
  m_mask.reset(MEM_MAP_PAGE_INST_TRAVERSAL_IN);
}
void CVisitorTraversal::disableMemMapPageInstAfterTraversal() {
  m_mask.reset(MEM_MAP_PAGE_INST_TRAVERSAL_AFTER);
}

void CVisitorTraversal::disableMemMapTraversal() {
  m_mask.reset(MEM_MAP_TRAVERSAL);
}
void CVisitorTraversal::disableMemMapBeforeTraversal() {
  m_mask.reset(MEM_MAP_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableMemMapInTraversal() {
  m_mask.reset(MEM_MAP_TRAVERSAL_IN);
}
void CVisitorTraversal::disableMemMapAfterTraversal() {
  m_mask.reset(MEM_MAP_TRAVERSAL_AFTER);
}


void CVisitorTraversal::disableUnitInfoTraversal() {
  m_mask.reset(UNIT_INFO_TRAVERSAL);
}
void CVisitorTraversal::disableUnitInfoBeforeTraversal() {
  m_mask.reset(UNIT_INFO_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableUnitInfoInTraversal() {
  m_mask.reset(UNIT_INFO_TRAVERSAL_IN);
}
void CVisitorTraversal::disableUnitInfoAfterTraversal() {
  m_mask.reset(UNIT_INFO_TRAVERSAL_AFTER);
}


void CVisitorTraversal::disableStmtTraversal() {
  m_mask.reset(STMT_TRAVERSAL);
}
void CVisitorTraversal::disableStmtBeforeTraversal() {
  m_mask.reset(STMT_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableStmtInTraversal() {
  m_mask.reset(STMT_TRAVERSAL_IN);
}
void CVisitorTraversal::disableStmtAfterTraversal() {
  m_mask.reset(STMT_TRAVERSAL_AFTER);
}


void CVisitorTraversal::disableContainerTraversal() {
  m_mask.reset(CONTAINER_TRAVERSAL);
}
void CVisitorTraversal::disableContainerBeforeTraversal() {
  m_mask.reset(CONTAINER_TRAVERSAL_BEFORE);
}
void CVisitorTraversal::disableContainerInTraversal() {
  m_mask.reset(CONTAINER_TRAVERSAL_IN);
}
void CVisitorTraversal::disableContainerAfterTraversal() {
  m_mask.reset(CONTAINER_TRAVERSAL_AFTER);
}


void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmInclude                        & fileInclude                        ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmInclude                        & fileInclude                        )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(fileInclude);

    if((*this.*isInTraversalEnabled)())
      inTraversal(fileInclude);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(fileInclude);
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmDesign                          & design                          ) {
  __tbool isNodeVisitEnabled         = &CVisitorTraversal::isDesignTraversalEnabled;
  __tbool isBeforeTraversalEnabled   = &CVisitorTraversal::isDesignBeforeTraversalEnabled;
  __tbool isInTraversalEnabled       = &CVisitorTraversal::isDesignInTraversalEnabled;
  __tbool isAfterTraversalEnabled    = &CVisitorTraversal::isDesignAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11, "void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmDesign                          & design                          )" );
    if((*this.*isBeforeTraversalEnabled)()) 
      beforeTraversal(design);

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase enumDeclarationsVec = design->getEnumDeclarationsAsBase();
      if(enumDeclarationsVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = enumDeclarationsVec->begin(); iter!=enumDeclarationsVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(design);
          }
        }
      }
    
      //     DCERR ("nr of design children " << design->getChildrenSize() << std::endl);
      //     for(TVec_RefCSLOmBase_const_iter iter= design->getChildrenAsBase()->begin(); iter < design->getChildrenAsBase()->end(); ++iter) {
      //       DCERR ("design child type " << (*iter)->getType() << std::endl);
      //     }
      RefTVec_RefCSLOmBase unitDeclarationsVec = design->getUnitDeclarationsAsBase();
      if(unitDeclarationsVec.get()) { 
        for(TVec_RefCSLOmBase_const_iter iter = unitDeclarationsVec->begin(); iter!=unitDeclarationsVec->end(); iter++) { 
          if ( (!isOnlyTopEnable() || (isOnlyTopEnable() && CSLOmUnitDecl::cast(*iter)->isTopUnit()) ) ){
            (*iter)->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()) {
              inTraversal(design);
            }
          }
        }
      }

      if (!noTestObjects()) {
        RefTVec_RefCSLOmBase verifCompsVec = design->getVerifCompsAsBase();
        if(verifCompsVec.get()) { 
          for(TVec_RefCSLOmBase_const_iter iter = verifCompsVec->begin(); iter!=verifCompsVec->end(); iter++) { 

            (*iter)->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()) {
              inTraversal(design);
            }
          }
        }
      }

      if (!noTestObjects() && !noTestBench()) {
        RefTVec_RefCSLOmBase tbVec = design->getTBsAsBase();
        if(tbVec.get()) { 
          for(TVec_RefCSLOmBase_const_iter iter = tbVec->begin(); iter!=tbVec->end(); iter++) { 

            (*iter)->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()) {
              inTraversal(design);
            }
          }
        }
      }
    
      if (isVisitDesignFieldsEnabled()) {
        RefTVec_RefCSLOmBase fieldsVec = design->getFieldsAsBase();
        if(fieldsVec.get()) {
          for(TVec_RefCSLOmBase_const_iter it = fieldsVec->begin(); it < fieldsVec->end(); ++it) {
            if (!isIsaJumpEnable() || !(*it)->isIsaElement() || (isIsaJumpEnable() && (CSLOmIsaElement::cast(*it)->getIsaType() == CSLOmIsaElement::ISA_ELEM_ROOT || CSLOmIsaElement::cast(*it)->getIsaType() == CSLOmIsaElement::ISA_ELEM_UNDEFINED))) {
              (*it)->acceptVisitor(*this);
              if((*this.*isInTraversalEnabled)()) {
                inTraversal(design);
              }
            }
          }
        }
      }
      else {
        RefTVec_RefCSLOmBase fieldsVec = design->getISAAsBase();
        if(fieldsVec.get()) {
          for(TVec_RefCSLOmBase_const_iter it = fieldsVec->begin(); it < fieldsVec->end(); ++it) {
            if (!isIsaJumpEnable() || !(*it)->isIsaElement() || (isIsaJumpEnable() && (CSLOmIsaElement::cast(*it)->getIsaType() == CSLOmIsaElement::ISA_ELEM_ROOT || CSLOmIsaElement::cast(*it)->getIsaType() == CSLOmIsaElement::ISA_ELEM_UNDEFINED))) {
              (*it)->acceptVisitor(*this);
              if((*this.*isInTraversalEnabled)()) {
                inTraversal(design);
              }
            }
          }
        }
      }
      

      //RefTVec_RefCSLOmBase children = design->getChildrenAsBase(TYPE_ALL_TYPES);
      //if(children.get()) { 
      //  ASSERT(children->size()!=0,"There are no children (Design children vector size is zero. It should have at least one child)");
      //  for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
      //    (*iter)->acceptVisitor(*this);
      //  }
      //}

      //     RefTVec_RefCSLOmBase fields = design->getFieldsAsBase();
      //     if(fields.get()) {
      //       for(TVec_RefCSLOmBase_const_iter it = fields->begin(); it < fields->end(); ++it) {
      //         (*it)->acceptVisitor(*this);
      //         if((*this.*isInTraversalEnabled)()){
      //           inTraversal(design);
      //         }
      //       }
      //     }

      RefTVec_RefCSLOmBase memMapPagesVec = design->getMemoryMapPagesAsBase();
      if(memMapPagesVec.get()) {
        DCERR ("memmap Pagges: " << memMapPagesVec->size() << std::endl);
        for(TVec_RefCSLOmBase_const_iter iter = memMapPagesVec->begin(); iter!=memMapPagesVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(design);
          }
        }
      }

      RefTVec_RefCSLOmBase memMapsVec = design->getMemoryMapsAsBase();
      if(memMapsVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = memMapsVec->begin(); iter!=memMapsVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(design);
          }
        }
      }
    }
    
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(design);
  }
  else DCERR( "isNodeVisitEnabled = " << isNodeVisitEnabled << std::endl);
}   

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmIdentifier                      & id                              ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11, "void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmIdentifier                      & id                              )" );
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(id);

    //RefTVec_RefCSLOmBase children = id->getChildrenAsBase(TYPE_ALL_TYPES);
    //ASSERT(!children.get(),"There are children (Id shouldn't have at least one child)");

    if((*this.*isInTraversalEnabled)())
      inTraversal(id);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(id);
  }
}
  
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isExprTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isExprBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isExprInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isExprAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(exprLink);
    
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefCSLOmBase bitrange = exprLink->getBitRangeAsBase();
      if (bitrange.get()) {
        bitrange->acceptVisitor(*this);
      }

      //RefTVec_RefCSLOmBase children = exprLink->getChildrenAsBase(TYPE_ALL_TYPES);
      //ASSERT(!children.get(),"There are no children (Id should have at least one child)");

      if((*this.*isInTraversalEnabled)())
        inTraversal(exprLink);
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(exprLink);
  }
}
                                                                                                                     
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ) {
  __tbool isNodeVisitEnabled         = &CVisitorTraversal::isUnitDeclTraversalEnabled;
  __tbool isBeforeTraversalEnabled   = &CVisitorTraversal::isUnitDeclBeforeTraversalEnabled;
  __tbool isInTraversalEnabled       = &CVisitorTraversal::isUnitDeclInTraversalEnabled;
  __tbool isAfterTraversalEnabled    = &CVisitorTraversal::isUnitDeclAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(unitDecl);

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefCSLOmBase id = unitDecl->getIDAsBase();
      ASSERT(id.get(),"UnitDecl should not have NULL ID");
      id->acceptVisitor(*this);

      if((*this.*isInTraversalEnabled)())
        inTraversal(unitDecl);

      RefCSLOmBase infoClass = unitDecl->getUnitInfo();
      infoClass->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()) {
        inTraversal(unitDecl);
      }
    
      RefCSLOmInterface defInterface = unitDecl->getDefaultInterface();
      ASSERT(defInterface.get(),"UnitDecl should have at least one default interface");
      defInterface->acceptVisitor(*this);

      if((*this.*isInTraversalEnabled)())
        inTraversal(unitDecl);
    

      RefTVec_RefCSLOmBase            signalsVec       = unitDecl->getSignalsAsBase(); 
      if(signalsVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = signalsVec->begin(); iter!=signalsVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)())
            inTraversal(unitDecl);
        }
      }

      RefTVec_RefCSLOmBase sigGroupVec = unitDecl->getSignalGroupsAsBase();
      if(sigGroupVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = sigGroupVec->begin(); iter != sigGroupVec->end(); ++iter) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)())
            inTraversal(unitDecl);
        }
      }

      RefTVec_RefCSLOmBase paramVec = unitDecl->getUnitParamsAsBase();
      if(paramVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = paramVec->begin(); iter!=paramVec->end(); ++iter) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)())
            inTraversal(unitDecl);
        }
      }

      RefTVec_RefCSLOmBase unitInstancesVec = unitDecl->getInstantiationsAsBase();
      if(unitInstancesVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = unitInstancesVec->begin(); iter != unitInstancesVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(unitDecl);
          }
        }
      }

      RefTVec_RefCSLOmBase includeVec = unitDecl->getChildrenAsBase(TYPE_INCLUDE);
      if(includeVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = includeVec->begin(); iter!=includeVec->end(); ++iter) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(unitDecl);
          }
        }
      }
    
      RefTVec_RefCSLOmBase stmtAssnVec = unitDecl->getChildrenAsBase(TYPE_STMT);
      if(stmtAssnVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = stmtAssnVec->begin(); iter != stmtAssnVec->end(); ++iter) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(unitDecl);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(unitDecl);
    }
  }
}
                                                                                                                     
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmSignal                          & signal                          ) {
  __tbool isNodeVisitEnabled         = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled   = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled       = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled    = &CVisitorTraversal::isObjAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmSignal                          & signal                          )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(signal);

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefCSLOmBase id = signal->getIDAsBase();
      ASSERT(id.get(),"Signal should not have NULL ID");
      id->acceptVisitor(*this);

      //RefTVec_RefCSLOmBase children = signal->getChildrenAsBase(TYPE_ALL_TYPES);
      //RefTVec_RefCSLOmBase children = signal->getSignalList();
      //ASSERT(children.get(),"There are no children (Signal should have at least one child)");
      //ASSERT(children->size()!=0,"There are no children (Signal children vector size is zero. It should have at least one child)");
      //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
      //  (*iter)->acceptVisitor(*this);
      //}

      RefCSLOmBase bitrange = signal->getBitRangeAsBase();
      ASSERT(bitrange.get(),"There is no bitrange associated with this signal");
      //DCERR("i got here : "<<*(CSLOmBitRange::cast(bitrange)->getID()->getName())<<std::endl);
      bitrange->acceptVisitor(*this);

      if((*this.*isInTraversalEnabled)())
        inTraversal(signal);

      //     RefTVec_RefCSLOmBase fields = signal->getFieldsAsBase();
      //     if(fields.get()) {
      //       for(TVec_RefCSLOmBase_const_iter iter = fields->begin(); iter < fields->end(); ++iter) {
      //         (*iter)->acceptVisitor(*this);
      //         if((*this.*isInTraversalEnabled)()) {
      //           inTraversal(signal);
      //         }
      //       }
      //     }
    }
    
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(signal);
  }
}
  
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isUnitInstanceTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isUnitInstanceBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isUnitInstanceInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isUnitInstanceAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(unitInst);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefCSLOmBase id = unitInst->getIDAsBase();
      ASSERT(id.get(),"UnitInst should not have NULL ID");
      id->acceptVisitor(*this);

      if((*this.*isInTraversalEnabled)()) {
        inTraversal(unitInst);
      }

      RefTVec_RefCSLOmBase unitParamOvr = unitInst->getParameters();
      if(unitParamOvr.get() && unitParamOvr->size()) {
        for(TVec_RefCSLOmBase_const_iter it = unitParamOvr->begin(); it < unitParamOvr->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(unitInst);
          }
        }
      }

      /*
        RefTVec_RefCSLOmBase overridesVec = unitInst->getOverridesAsBase();
        if(overridesVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = overridesVec->begin(); iter!=overridesVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        }
        }
      */

      //RefTVec_RefCSLOmBase children = unitInst->getChildrenAsBase(TYPE_ALL_TYPES);
      //ASSERT(children.get(),"There are no children (UnitInst should have at least one child)");
      //ASSERT(children->size()!=0,"There are no children (UnitInst children vector size is zero. It should have at least one child)");
      //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
      //  (*iter)->acceptVisitor(*this);
      //}
    }

    if(isUnitJumpEnable()) {
      unitInst->getUnitDecl()->acceptVisitor(*this);
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(unitInst);
    }

  }
}
                                                                                                                     
 
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(simpleBitRange);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = simpleBitRange->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(simpleBitRange);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(simpleBitRange);
    }
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMultiDimBitRange                     & multiDimBitRange                     )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(multiDimBitRange);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = multiDimBitRange->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(multiDimBitRange);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(multiDimBitRange);
    }
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(groupSignal);

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = groupSignal->getChildrenAsBase(TYPE_ALL_TYPES);
      //ASSERT(children.get(),"There are no children (groupSignal should have at least one child)");
      //ASSERT(children->size()!=0,"There are no children (groupSignal children vector size is zero. It should have at least one child)");
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) { 
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)())
            inTraversal(groupSignal);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(groupSignal);
  }
}
                                                                                                                     
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmNum32                           & number                          ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isExprTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isExprBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isExprInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isExprAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmNum32                          & number                          )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(number);
    
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = number->getChildrenAsBase(TYPE_ALL_TYPES);
      ASSERT(!children.get(),"There are children (Number should have no child)");

      if((*this.*isInTraversalEnabled)())
        inTraversal(number);
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(number);
  }
}
                                                                                                                    
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmInterface                       & interface                       ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmInterface                       & interface                       )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(interface);

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = interface->getChildrenAsBase(TYPE_ALL_TYPES);
      ASSERT(children.get(),"There are no children (Interface should have at least one child)");
      ASSERT(children->size()!=0,"There are no children (Interface children vector size is zero. It should have at least one child)");
      for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) { 
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(interface);
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(interface);
  }
}
                                                                                                                     
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isUnitInstantiationTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isUnitInstanceBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isUnitInstanceInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isUnitInstanceAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(unitInstantiation);
    
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefCSLOmBase exprLink = unitInstantiation->getUnitDeclExprLinkAsBase();
      exprLink->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(unitInstantiation);

      RefTVec_RefCSLOmBase unitInstantiationsVec = unitInstantiation->getUnitInstancesAsBase();
      if(unitInstantiationsVec.get())
        for(TVec_RefCSLOmBase_const_iter iter = unitInstantiationsVec->begin(); iter != unitInstantiationsVec->end(); ++iter) {
          (*iter)->acceptVisitor(*this);
        }

    
      //RefTVec_RefCSLOmBase children = unitInstantiation->getChildrenAsBase(TYPE_ALL_TYPES);
      //ASSERT(children.get(),"There are no children (unitInstantiation should have at least one child)");
      //ASSERT(children->size()!=0,"There are no children (unitInstantiation children vector size is zero. It should have at least one child)");
      //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
      //  (*iter)->acceptVisitor(*this);
      //}
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(unitInstantiation);
  }
}
                                                                                                                     
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(portDecl); 
    
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefCSLOmBase id = portDecl->getIDAsBase();
      id->acceptVisitor(*this);

      if((*this.*isInTraversalEnabled)())
        inTraversal(portDecl);

      RefCSLOmBase bitRange = portDecl->getBitRangeAsBase();
      bitRange->acceptVisitor(*this);

      if((*this.*isInTraversalEnabled)())
        inTraversal(portDecl);

      //RefTVec_RefCSLOmBase children = portDecl->getChildrenAsBase(TYPE_ALL_TYPES);
      //ASSERT(children.get(),"There are no children (portDecl should have at least one child)");
      //ASSERT(children->size()!=0,"There are no children (portDecl children vector size is zero. It should have at least one child)");
      //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
      //  (*iter)->acceptVisitor(*this);
      //}
    }
    
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(portDecl);
  }
}
                                                                                                                     
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isExprTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isExprBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isExprInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isExprAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(exprOp);

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase exprVec = exprOp->getExprsAsBase();
      ASSERT(exprVec.get(),"There are no children in exprOp vector (exprOp should have at least one");
      for(TVec_RefCSLOmBase_const_iter iter = exprVec->begin(); iter!=exprVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
	if((*this.*isInTraversalEnabled)())
	  inTraversal(exprOp);
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(exprOp);
  }
}
                                                                                                                     
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isExprTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isExprBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isExprInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isExprAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(exprConcat);
    
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase exprVec = exprConcat->getExprsAsBase();
      ASSERT(exprVec.get(),"There are no children in exprConcat vector (exprConcat should have at least one");
      for(TVec_RefCSLOmBase_const_iter iter = exprVec->begin(); iter!=exprVec->end(); iter++){
        (*iter)->acceptVisitor(*this);

        //RefTVec_RefCSLOmBase children = exprConcat->getChildrenAsBase(TYPE_ALL_TYPES);
        //ASSERT(children.get(),"There are no children (exprConcat should have at least one child)");
        //ASSERT(children->size()!=0,"There are no children (exprConcat children vector size is zero. It should have at least one child)");
        //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
        //  (*iter)->acceptVisitor(*this);
        //}

        if((*this.*isInTraversalEnabled)()){
          inTraversal(exprConcat);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(exprConcat);
  }
}
                                                                                                                     
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isExprTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isExprBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isExprInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isExprAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(exprMultiConcat);
    
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase exprVec = exprMultiConcat->getExprsAsBase();
      ASSERT(exprVec.get(),"There are no children in exprMultiConcat vector (exprMultiConcat should have at least one");
      for(TVec_RefCSLOmBase_const_iter iter = exprVec->begin(); iter!=exprVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(exprMultiConcat);
        }
      }

      //RefTVec_RefCSLOmBase children = exprMultiConcat->getChildrenAsBase(TYPE_ALL_TYPES);
      //ASSERT(children.get(),"There are no children (exprMultiConcat should have at least one child)");
      //ASSERT(children->size()!=0,"There are no children (exprMultiConcat children vector size is zero. It should have at least one child)");
      //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
      //  (*iter)->acceptVisitor(*this);
      //}
    }


    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(exprMultiConcat);
  }
}
                                                                                                                     
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmList                            & list                            ) {  
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isExprTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isExprBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isExprInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isExprAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmList                            & list                            ) {");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(list);
    
    //RefTVec_RefCSLOmBase children = list->getChildrenAsBase(TYPE_ALL_TYPES);
    //ASSERT(children.get(),"There are no children ( should have at least one child)");
    //ASSERT(children->size()!=0,"There are no children ( children vector size is zero. It should have at least one child)");
    //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
    //  (*iter)->acceptVisitor(*this);
    //}

    if((*this.*isInTraversalEnabled)())
      inTraversal(list);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(list);
  }
}


void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmParameter                       & parameter                       ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmParameter                       & parameter                       )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(parameter);

    RefTVec_RefCSLOmBase allChildren = parameter->getChildrenAsBase(TYPE_ALL_TYPES);
    if (allChildren.get()) {
      for (TVec_RefCSLOmBase_const_iter iter = allChildren->begin(); iter != allChildren->end(); ++iter) {
        (*iter)->acceptVisitor(*this);
        if ((*this.*isInTraversalEnabled)()) {
          inTraversal(parameter);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(parameter);
  }
}

  
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isExprTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isExprBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isExprInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isExprAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(listExpr);

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase itemsVec = listExpr->getItemsAsBase();
      ASSERT(itemsVec.get(),"listExpr should have at least one item child");
      if(itemsVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = itemsVec->begin(); iter != itemsVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
        }
      }

      //RefTVec_RefCSLOmBase children = listExpr->getChildrenAsBase(TYPE_ALL_TYPES);
      //ASSERT(children.get(),"There are no children (listExpr should have at least one child)");
      //ASSERT(children->size()!=0,"There are no children (listExpr children vector size is zero. It should have at least one child)");
      //
      //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
      //  (*iter)->acceptVisitor(*this);
      //}
    }

    if((*this.*isInTraversalEnabled)())
      inTraversal(listExpr);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(listExpr);
  }
}
  
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isExprTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isExprBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isExprInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isExprAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(exprHybridOrFuncCall);

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase objectNamesVec = exprHybridOrFuncCall->getObjectNamesAsBase();
      if(objectNamesVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = objectNamesVec->begin(); iter != objectNamesVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
        }
      }  
    
      RefTVec_RefCSLOmBase functionSignaturesVec = exprHybridOrFuncCall->getFunctionSignaturesAsBase();
      if(functionSignaturesVec.get()) {
        for(TVec_RefCSLOmBase_const_iter iter = functionSignaturesVec->begin(); iter != functionSignaturesVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
        }
      }  

      //RefTVec_RefCSLOmBase children = exprHybridOrFuncCall->getChildrenAsBase(TYPE_ALL_TYPES);
      //ASSERT(children.get(),"There are no children (exprHybridOrFuncCall should have at least one child)");
      //ASSERT(children->size()!=0,"There are no children (exprHybridOrFuncCall children vector size is zero. It should have at least one child)");
      //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
      //  (*iter)->acceptVisitor(*this);
      //}
    }

    if((*this.*isInTraversalEnabled)())
      inTraversal(exprHybridOrFuncCall);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(exprHybridOrFuncCall);
  }
}
  
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isExprTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isExprBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isExprInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isExprAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(exprFuncSignature);

    //RefTVec_RefCSLOmBase children = exprFuncSignature->getChildrenAsBase(TYPE_ALL_TYPES);
    //ASSERT(children.get(),"There are no children (exprFuncSignature should have at least one child)");
    //ASSERT(children->size()!=0,"There are no children (exprFuncSignature children vector size is zero. It should have at least one child)");
    //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
    //  (*iter)->acceptVisitor(*this);
    //}

    if((*this.*isInTraversalEnabled)())
      inTraversal(exprFuncSignature);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(exprFuncSignature);
  }
}
  
/*
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride                      ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmParameterOverride                      & parameterOverride                      )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(parameterOverride);

    RefCSLOmBase value = parameterOverride->getValueAsBase();
    if(value.get())
      value->acceptVisitor(*this);

    //RefTVec_RefCSLOmBase children = parameterOverride->getChildrenAsBase(TYPE_ALL_TYPES);
    //ASSERT(children.get(),"There are no children (scopeBlock should have at least one child)");
    //ASSERT(children->size()!=0,"There are no children (scopeBlock children vector size is zero. It should have at least one child)");
    //for(TVec_RefCSLOmBase_const_iter iter = children->begin(); iter != children->end(); ++iter) 
    //  (*iter)->acceptVisitor(*this);
    //}

    if((*this.*isInTraversalEnabled)())
      inTraversal(parameterOverride);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(parameterOverride);
  }
}
*/

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmEnum                    & enumeration                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(enumeration);
    }
      
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase enumChildVec = enumeration->getChildrenAsBase();
      for(TVec_RefCSLOmBase_const_iter it = enumChildVec->begin(); it!= enumChildVec->end(); ++it) {
        (*it)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(enumeration);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(enumeration);
    }
  }

}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmField                            & field                     ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmField                    & field                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(field);
    }
      
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase fieldChildVec = field->getChildrenAsBase();
      TVec_RefCSLOmBase_const_iter it;
      TUInt i;
      for(i = 0, it = fieldChildVec->begin(); it!= fieldChildVec->end(); ++it, ++i) {
        if (i != 4 || field->getFieldType() == CSLOmField::FIELD_HIERARCHICAL){
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(field);
          }
        }
      }


      if (field->getFieldType() != CSLOmField::FIELD_HIERARCHICAL){
        field->getChild(4)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(field);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(field);
    }
  }

}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isMemMapTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isMemMapBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isMemMapInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isMemMapAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMemoryMap                  & memoryMap                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(memoryMap);
    }
      
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase memMapChildVec = memoryMap->getChildrenAsBase();
      if(memMapChildVec.get()) {
        DCERR("Memmap has " << memMapChildVec->size() << " children" << std::endl);
        for(TVec_RefCSLOmBase_const_iter it = memMapChildVec->begin(); it!= memMapChildVec->end(); ++it) {
          DCERR((*it)->getType() << std::endl);
        } 
        for(TVec_RefCSLOmBase_const_iter it = memMapChildVec->begin(); it!= memMapChildVec->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(memoryMap);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(memoryMap);
    }
  }
} 

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isAddressRangeTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isAddressRangeBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isAddressRangeInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isAddressRangeAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  ASSERT(addressRange->getParent()->getType() != TYPE_INCLUDE, "phuck");  

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(addressRange);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase addrRangeChildVec = addressRange->getChildrenAsBase();
      if(addrRangeChildVec.get()) {
        DCERR("addrRange has " << addrRangeChildVec->size() << " children" << std::endl);
        for(TVec_RefCSLOmBase_const_iter it = addrRangeChildVec->begin(); it!= addrRangeChildVec->end(); ++it) {
          DCERR((*it)->getType());
        }
        for(TVec_RefCSLOmBase_const_iter it = addrRangeChildVec->begin(); it!= addrRangeChildVec->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(addressRange);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(addressRange);
    }
  }
}
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isMemMapLocTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isMemMapLocBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isMemMapLocInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isMemMapLocAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMemoryMapLocation                    & memoryMapLocation                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(memoryMapLocation);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      DCERR ("Inside memmap location" << std::endl) ;
      RefTVec_RefCSLOmBase memMapLocChildVec = memoryMapLocation->getChildrenAsBase();
      if(memMapLocChildVec.get()) {
        DCERR("memMapLoc has " << memMapLocChildVec->size() << " children" << std::endl);
        for(TVec_RefCSLOmBase_const_iter it = memMapLocChildVec->begin(); it!= memMapLocChildVec->end(); ++it) {
          DCERR((*it)->getType());
        }
        for(TVec_RefCSLOmBase_const_iter it = memMapLocChildVec->begin(); it!= memMapLocChildVec->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(memoryMapLocation);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(memoryMapLocation);
    }
  } 
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isMemMapPageTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isMemMapPageBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isMemMapPageInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isMemMapPageAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMemoryMapPage                    & memoryMapPage                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(memoryMapPage);
    }
      
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase memMapPageChildVec = memoryMapPage->getChildrenAsBase();
      if(memMapPageChildVec.get()) {
        DCERR("mempage has " << memMapPageChildVec->size() << " children" << std::endl);
        for(TVec_RefCSLOmBase_const_iter it = memMapPageChildVec->begin(); it!= memMapPageChildVec->end(); ++it) {
          DCERR((*it)->getType() << std::endl);
        }
        for(TVec_RefCSLOmBase_const_iter it = memMapPageChildVec->begin(); it!= memMapPageChildVec->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(memoryMapPage);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(memoryMapPage);
    }
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isMemMapPageInstTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isMemMapPageInstBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isMemMapPageInstInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isMemMapPageInstAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(memoryMapPageInstance);
    }
      
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase instanceChildVec = memoryMapPageInstance->getChildrenAsBase();
      if(instanceChildVec.get()) {
        DCERR("memMapPageInstance has " << instanceChildVec->size() << " children" << std::endl);
        for(TVec_RefCSLOmBase_const_iter it = instanceChildVec->begin(); it!= instanceChildVec->end(); ++it) {
          DCERR((*it)->getType() << std::endl);
        }
        for(TVec_RefCSLOmBase_const_iter it = instanceChildVec->begin(); it!= instanceChildVec->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(memoryMapPageInstance);
          }
        }
      }
    }

    if(isPageJumpEnable()) {
      memoryMapPageInstance->getPage()->acceptVisitor(*this);
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(memoryMapPageInstance);
    }
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmContainer                         & container                       ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isContainerTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isContainerBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isContainerInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isContainerAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmContainer                    & container                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(container);
    }
      
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase containerChildVec = container->getChildrenAsBase();
      if(containerChildVec.get()) {
        DCERR("Container has " << containerChildVec->size() << " children and has Type "<< container->getType() << std::endl);
        for(TVec_RefCSLOmBase_const_iter it = containerChildVec->begin(); it!= containerChildVec->end(); ++it) {
          DCERR((*it)->getType() << std::endl);
        }
        for(TVec_RefCSLOmBase_const_iter it = containerChildVec->begin(); it!= containerChildVec->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(container);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(container);
    }
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmIsaField                         & isaField                       ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isIsaFieldTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isIsaFieldBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isIsaFieldInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isIsaFieldAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmIsaField                    & isaField                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(isaField);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = isaField->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(isaField);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(isaField);
    }
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmIsaElement                       & isaElement                     ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isIsaElementTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isIsaElementBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isIsaElementInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isIsaElementAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmIsaElement                    & isaElement                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(isaElement);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = isaElement->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(isaElement);
          }
        }
      }

      if (isIsaJumpEnable()) {
        RefTVec_WeakRefCSLOmIsaElement isaChildren = isaElement->getIsaChildren();
        if(isaChildren.get()) {
          for(TVec_WeakRefCSLOmIsaElement::iterator it = isaChildren->begin(); it < isaChildren->end(); ++it) {
            (*it).lock()->acceptVisitor(*this);
            //           if((*this.*isInTraversalEnabled)()) {
            //             inTraversal(isaElement);
            //           }
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(isaElement);
    }
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isUnitInfoTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isUnitInfoBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isUnitInfoInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isUnitInfoAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmUnitInfo                    & unitInfo                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(unitInfo);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = unitInfo->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(unitInfo);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(unitInfo);
    }
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isStmtTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isStmtBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isStmtInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isStmtAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmStmtAssign                    & stmtAssign                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(stmtAssign);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = stmtAssign->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(stmtAssign);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(stmtAssign);
    }
  }
}     
      
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isUnitInfoTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isUnitInfoBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isUnitInfoInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isUnitInfoAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmMemoryInfo                    & memInfo                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(memInfo);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = memInfo->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(memInfo);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(memInfo);
    }
  }
}     
      
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isUnitInfoTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isUnitInfoBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isUnitInfoInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isUnitInfoAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmFifoInfo                    & fifoInfo                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(fifoInfo);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = fifoInfo->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(fifoInfo);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(fifoInfo);
    }
  }
}     
      
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isUnitInfoTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isUnitInfoBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isUnitInfoInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isUnitInfoAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmRegisterFileInfo                    & regFileInfo                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(regFileInfo);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = regFileInfo->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(regFileInfo);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(regFileInfo);
    }
  }
}     
      
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isUnitInfoTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isUnitInfoBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isUnitInfoInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isUnitInfoAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmRegDeclInfo                    & regInfo                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(regInfo);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = regInfo->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(regInfo);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(regInfo);
    }
  }
}     
      
void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isUnitInfoTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isUnitInfoBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isUnitInfoInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isUnitInfoAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmTBInfo                    & tbInfo                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(tbInfo);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = tbInfo->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(tbInfo);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(tbInfo);
    }
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmVectorInfo                          & vectorInfo                          ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isUnitInfoTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isUnitInfoBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isUnitInfoInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isUnitInfoAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmVECTORInfo                    & vectorInfo                  )");
    if((*this.*isBeforeTraversalEnabled)()) {
      beforeTraversal(vectorInfo);
    }

    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = vectorInfo->getChildrenAsBase();
      if(children.get()) {
        for(TVec_RefCSLOmBase_const_iter it = children->begin(); it < children->end(); ++it) {
          (*it)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(vectorInfo);
          }
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)()) {
      afterTraversal(vectorInfo);
    }
  }
}

void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmVeriNum                           & number                          ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isExprTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isExprBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isExprInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isExprAfterTraversalEnabled;
  __tbool isChildrenTraversalEnabled = &CVisitorTraversal::isChildrenTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    TRACE_ME(11,"void CVisitorTraversal::visit(const NSCSLOm::RefCSLOmNum32                          & number                          )");
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(number);
    
    if ((*this.*isChildrenTraversalEnabled)()) {
      RefTVec_RefCSLOmBase children = number->getChildrenAsBase(TYPE_ALL_TYPES);
      ASSERT(!children.get(),"There are children (Number should have no child)");

      if((*this.*isInTraversalEnabled)())
        inTraversal(number);
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(number);
  }
}


} //END of NAMESPACE

