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
//-----------------------------------------------------------------------

#include <iterator>
#include "CDOM_Visitor.h"


using std::endl;
using namespace NSCdom;

namespace NSCdomVisitor {

//********************************************************************************
// CVisitor class
//********************************************************************************
CVisitor::CVisitor() {}

CVisitor::~CVisitor() {} 


//********************************************************************************
// CVisitorTraversal class
//********************************************************************************
CVisitorTraversal::CVisitorTraversal() {
  initMaskValue();
}
CVisitorTraversal::~CVisitorTraversal() {}

void CVisitorTraversal::initMaskValue() {
  m_mask.set();
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmComment                        & comment                          ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(comment);

    if((*this.*isInTraversalEnabled)())
      inTraversal(comment);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(comment);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmInclude                        & fileInclude                        ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(fileInclude);

    if((*this.*isInTraversalEnabled)())
      inTraversal(fileInclude);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(fileInclude);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmDesign                              & design                          ) {
  
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    //TRACE_ME(11, "void CVisitorTraversal::visit(const NSCSLOm::RefCDOmDesign                          & design                          )" );
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(design);
    
    /*  RefTVec_RefCDOmBase topsDeclarationVec = design->getTops();
        if(topsDeclarationVec.get()) {
        for(TVec_RefCDOmBase_const_iter iter = topsDeclarationVec->begin(); iter<=topsDeclarationVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        }
             }*/

    RefTVec_RefCDOmBase defineDecls = design->getDefineDecls();
    if(defineDecls.get()) {
      for(TVec_RefCDOmBase_const_iter iter = defineDecls->begin(); iter < defineDecls->end(); ++iter) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(design);
        }
      }
    } 

    RefTVec_RefCDOmModuleDecl moduledeclsVec = design->getModuleDecls();
    if(moduledeclsVec.get()){
      for(TVec_RefCDOmModuleDecl_const_iter iter = moduledeclsVec->begin(); iter<moduledeclsVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(design);
      }
    }

    RefTVec_RefCDOmUdpDecl udpdeclsVec = design->getUdpDecls();
    if(udpdeclsVec.get()){
      for(TVec_RefCDOmUdpDecl_const_iter iter = udpdeclsVec->begin(); iter<udpdeclsVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(design);
      }
    }

    

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(design);
  }
}   
    
void CVisitorTraversal::visit(const NSCdom::RefCDOmModuleDecl                            & moduleDecl                    ) {

  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isModuleTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isModuleBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isModuleInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isModuleAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    //TRACE_ME(11, "void CVisitorTraversal::visit(const NSCSLOm::RefCDOmModuleDecl                          & moduleDecl                          )" );
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(moduleDecl);
    
/* Deactivated
    std::cout << "Beginning of types display" << std::endl;
    RefTVec_RefCDOmBase allChildren = moduleDecl->getChildrenAsBase(TYPE_ALL_TYPES);
    if(allChildren.get()){
      std::cout << "Children vec size " << moduleDecl->getChildrenSize() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = allChildren->begin(); iter < allChildren->end(); iter++){
        std::cout << "TYPE is " << (*iter)->getType() << std::endl;
        if((*iter)->getType() == 62){
          std::cout << "InitOrAlwaysChildren " << std::endl;
          RefTVec_RefCDOmBase initChildren = (*iter)->getChildrenAsBase(TYPE_ALL_TYPES);
          if(initChildren.get()){
            for(TVec_RefCDOmBase_const_iter iter2 = initChildren->begin(); iter2 < initChildren->end(); iter2++){
              std::cout << "_TYPE is " << (*iter2)->getType() << std::endl;  
              if((*iter2)->getType() == 25){
                std::cout << "StatementChildren " << std::endl;
                RefTVec_RefCDOmBase stmtChildren = (*iter2)->getChildrenAsBase(TYPE_ALL_TYPES);
                if(stmtChildren.get()){
                  for(TVec_RefCDOmBase_const_iter iter3 = initChildren->begin(); iter3 < initChildren->end(); iter3++){
                    std::cout << "___TYPE is " << (*iter3)->getType() << "and children size is " << (*iter3)->getChildrenSize() << std::endl;
                    
                  }
                }
              }
            }
          }
        }
      }
    }
      std::cout << "End of types display" << std::endl;
    */

/*//////////////////Delete ////////////////////

    RefTVec_RefCDOmBase moduleVecTemp = moduleDecl->getChildrenAsBase();
    if(moduleVecTemp.get()){
      for(TVec_RefCDOmBase_const_iter iter = moduleVecTemp->begin(); iter < moduleVecTemp->end(); iter++){
        std::cout << "type is " << (*iter)->getType() << std::endl;
      }
    }


    RefTVec_RefCDOmBase moduleVec = moduleDecl->getChildrenAsBase();
    if(moduleVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = moduleVec->begin(); iter < moduleVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(moduleDecl);
         }
      }
    }

*////////////////////////////////////////
    
    //Visiting the module ID
    RefCDOmBase id = moduleDecl->getChild(0);
    if(id.get()){
      id->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(moduleDecl);
    }

    RefTVec_RefCDOmBase modulePortItemsVec = moduleDecl->getChildrenAsBase(TYPE_PORT_ITEM);
    if(modulePortItemsVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = modulePortItemsVec->begin(); iter < modulePortItemsVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(moduleDecl);
        }
      }
    }

    RefTVec_RefCDOmBase comments = moduleDecl->getChildrenAsBase(TYPE_COMMENT);
    if(comments.get()) {
      for(TVec_RefCDOmBase_const_iter it = comments->begin(); it < comments->end(); ++it) {
        (*it)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(moduleDecl);
        }
      }
    }
    /*RefTVec_RefCDOmBase moduleVec = moduleDecl->getTwoExclusiveChildrenAsBase(TYPE_PORT_ITEM, TYPE_ID_SCOPE_DIRECT);
    if(moduleVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = moduleVec->begin(); iter < moduleVec->end(); iter++){
        //std::cerr << "Module child is of type " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(moduleDecl);
         }
      }
    }*/
  

    //// Replaced all individual methods below with the single method above ////
    /*
    RefCDOmBase id = moduleDecl->getChild(0);
    if(id.get()){
      id->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(moduleDecl);
    }
     

    RefTVec_RefCDOmPortItem portItemVec = moduleDecl->getPortItems();
    if(portItemVec.get()){
      for(TVec_RefCDOmPortItem_const_iter iter = portItemVec->begin(); iter < portItemVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleDecl);
      }
    }*/

    if(moduleDecl->hasParamDeclCollection()){
      RefCDOmParamDeclCollection paramDeclCollection = moduleDecl->getParamDeclCollection();
      paramDeclCollection->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(moduleDecl);
    }

    RefTVec_RefCDOmBase paramDeclVec = moduleDecl->getChildrenAsBase(TYPE_PARAM_DECL);
    if(paramDeclVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = paramDeclVec->begin(); iter < paramDeclVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){ 
          inTraversal(moduleDecl);
        }
      }
    }

    RefTVec_RefCDOmPortDecl inputPortDeclVec = moduleDecl->getInputPortDecls();
    if(inputPortDeclVec.get()){
      for(TVec_RefCDOmPortDecl_const_iter iter = inputPortDeclVec->begin(); iter < inputPortDeclVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleDecl);
      }
    }
    
    RefTVec_RefCDOmPortDecl outputPortDeclVec = moduleDecl->getOutputPortDecls();
    if(outputPortDeclVec.get()){
      for(TVec_RefCDOmPortDecl_const_iter iter = outputPortDeclVec->begin(); iter < outputPortDeclVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleDecl);
      }
    }

    RefTVec_RefCDOmPortDecl inoutPortDeclVec = moduleDecl->getInoutPortDecls();
    if(inoutPortDeclVec.get()){
      for(TVec_RefCDOmPortDecl_const_iter iter = inoutPortDeclVec->begin(); iter < inoutPortDeclVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleDecl);
      }
    }

    RefTVec_RefCDOmBase varDeclVec = moduleDecl->getVarDeclsAsBase();
    if(varDeclVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = varDeclVec->begin(); iter < varDeclVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleDecl);
      }
    }

    RefTVec_RefCDOmBase netDeclVec = moduleDecl->getNetDeclsAsBase();
    if(netDeclVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = netDeclVec->begin(); iter < netDeclVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleDecl);
      }
    }

    RefTVec_RefCDOmBase contAssnVec = moduleDecl->getChildrenAsBase(TYPE_CONT_ASSN);
    if(contAssnVec.get()){
      //std::cout << "It is!!" << "and it's " << contAssnVec->size() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = contAssnVec->begin(); iter < contAssnVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){ 
          inTraversal(moduleDecl);
        }
      }
    }

    RefTVec_RefCDOmBase instantiationsVec = moduleDecl->getInstantiationsAsBase();
    if(instantiationsVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = instantiationsVec->begin(); iter < instantiationsVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleDecl);
      }
    }

    RefTVec_RefCDOmBase initOrAlwaysVec = moduleDecl->getChildrenAsBase(TYPE_INITIAL_OR_ALWAYS);
    if(initOrAlwaysVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = initOrAlwaysVec->begin(); iter < initOrAlwaysVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleDecl);
      }
    }            

    RefTVec_RefCDOmBase includes = moduleDecl->getChildrenAsBase(TYPE_INCLUDE);
    if(includes.get()){
      for(TVec_RefCDOmBase_const_iter iter = includes->begin(); iter < includes->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleDecl);
      }
    }            
  
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(moduleDecl);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmIdentifier                            & id                              ) {

  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    //TRACE_ME(11, "void CVisitorTraversal::visit(const NSCSLOm::RefCDOmIdentifier                          & id                          )" );
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(id);

    //DO NOT activate the below commented lines - results in duplicate output
    //code kept for later bugs (if any)
    //use this method or the below commented one
    //RefTVec_RefCDOmBase rangeLists = id->getChildrenAsBase(TYPE_RANGE_LIST);
    //if(rangeLists.get()){
    //  for(TVec_RefCDOmBase_const_iter iter = rangeLists->begin(); iter < rangeLists->end(); iter++){
    //     (*iter)->acceptVisitor(*this);
    //    if((*this.*isInTraversalEnabled)()){
    //      inTraversal(id);
    //    }
    //  }
    //}

    if(id->getIdType() == CDOmIdentifier::ID_PARAM || id->getIdType() == CDOmIdentifier::ID_UDP_PORT_OUTPUT_PL || id->getIdType() == CDOmIdentifier::ID_VAR || id->getIdType() == CDOmIdentifier::ID_NET || id->getIdType() == CDOmIdentifier::ID_PORT /*|| id->getIdType() == CDOmIdentifier::ID_EVENT*/ ) {
      if(id->supportsPayload()){
        RefCDOmBase payload = id->getPayload();
        if(payload.get()) {
          payload->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)())
            inTraversal(id);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(id);
  }
}


void CVisitorTraversal::visit(const NSCdom::RefCDOmPortItem                        & portItem                        ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(portItem);

    /*
      RefTVec_RefCDOmPortItem portItemVec = portItem->getPortItems();
      if(portItemVec.get()){
      for(TVec_RefCDOmPortItem_const_iter iter = portItemVec->begin(); iter < portItemVec->end(); iter++){
      if(iter>(portItemVec->begin())){
      if((*this.*isInTraversalEnabled)())
      inTraversal(portItem);
      }
      }
      }
      RefTVec_RefCDOmExprLink exprLinkVec = portItem->getExprLink();
      if(exprLinkVec.get()){
      for(TVec_RefCDOmExprLink_const_iter iter = exprLinkVec->begin(); iter < exprLinkVec->end(); iter++){
      if(iter>(exprLinkVec->begin())){
      if((*this.*isInTraversalEnabled)())
      inTraversal(portItem);
      }
      }
      }
    */
    /*
    if(portItem->getPortItemType()==CDOmPortItem::PORT_ITEM_EMPTY){
      if((*this.*isInTraversalEnabled)())
        inTraversal(portItem);
    } else if(portItem->getPortItemType()==CDOmPortItem::PORT_ITEM_SIMPLE){
      RefCDOmExprLink portItemName = portItem->getExprLink();
      portItemName->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(portItem);
    } else if(portItem->getPortItemType()==CDOmPortItem::PORT_ITEM_CONCAT){
      std::cout << "Structure not implemented yet" << std::endl;
    }
    */

    RefTVec_RefCDOmBase portItemVec = portItem->getChildrenAsBase();
    if(portItemVec.get()){
      //std::cout << "POrt list has " << portItemVec->size() << " childre" << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = portItemVec->begin(); iter < portItemVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(portItem);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(portItem);
  }
}

//WARNING - Not finished::methods still need to be added here!!
//Update - finished
void CVisitorTraversal::visit(const NSCdom::RefCDOmExprLink                          & exprLink                              ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(exprLink);

    if(exprLink->isHID()) {
      RefTVec_RefCDOmExpr hidExprs = exprLink->getHidExprs();
      if(hidExprs.get()) {
        for(TVec_RefCDOmExpr_const_iter iter = hidExprs->begin(); iter < hidExprs->end(); ++iter) {
          if((*iter).get())
            (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(exprLink);
          }
        }
      }
    }

    RefCDOmListExpr  arrayIndexes = exprLink->getArrayIndexes();
    if(arrayIndexes.get()) {
      arrayIndexes->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(exprLink);
      }
    }

    RefCDOmRangeExpr rangeExpr = exprLink->getRangeExpr();
    if(rangeExpr.get()){
      rangeExpr->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(exprLink);
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(exprLink);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmExprOp                           & exprOp                               ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(exprOp);

    if(exprOp->isUnary()){
      RefCDOmExpr expr1 = exprOp->getExpr1();
      expr1->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(exprOp);
    }

    if(exprOp->isBinary()){
      RefCDOmExpr expr1 = exprOp->getExpr1();
      expr1->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(exprOp);
      RefCDOmExpr expr2 = exprOp->getExpr2();
      expr2->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(exprOp);
    }

    if(exprOp->isTernary()){
      RefCDOmExpr expr1 = exprOp->getExpr1();
      expr1->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(exprOp);
      RefCDOmExpr expr2 = exprOp->getExpr2();
      expr2->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(exprOp);
      RefCDOmExpr expr3 = exprOp->getExpr3();
      expr3->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(exprOp);
    }


    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(exprOp);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmPortDecl                        & portDecl                        ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(portDecl);
       
   
    //if(portDecl->getVarType() == VAR_UNDEFINED || portDecl->getVarType() == VAR_REG){
    if(portDecl->getVarType() != VAR_TIME && portDecl->getVarType() != VAR_INTEGER){
      RefCDOmRange range = portDecl->getRange();
      if(range.get()){
        range->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(portDecl);
      }
    }

    RefTVec_RefCDOmIdentifier idVec = portDecl->getIDs();
    if(idVec.get()){
      for(TVec_RefCDOmIdentifier_const_iter it = idVec->begin(); it < idVec->end(); it++) {
        (*it)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(portDecl);
      }
    }
        
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(portDecl);
  }
}



void CVisitorTraversal::visit(const NSCdom::RefCDOmVarDecl                        & varDecl                        ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(varDecl);
       
    if(varDecl->getVarType() == VAR_REG){
    RefCDOmRange range = varDecl->getRange();
    if(range.get()){
      range->acceptVisitor(*this);
       if((*this.*isInTraversalEnabled)())
      inTraversal(varDecl);
    }
    }

    RefTVec_RefCDOmIdentifier varIdVec = varDecl->getIDs();
    if(varIdVec.get()){
      for(TVec_RefCDOmIdentifier_const_iter it = varIdVec->begin(); it < varIdVec->end(); it++) {
        (*it)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(varDecl);
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(varDecl);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmNetDecl                        & netDecl                        ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(netDecl);
  
    RefCDOmRange range = netDecl->getRange();
    if(range.get()){
      range->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(netDecl);
    }

    //to be implemented
    /*if(netDecl->hasDelay3()){
      RefCDOmDelay delay = netDecl->getDelay3();
      if(delay.get()){
      delay->acceptVisitor(*this);
      }
      }*/
    RefTVec_RefCDOmIdentifier netIdVec = netDecl->getIDs();
    if(netIdVec.get()){
      //m_inNetDecl = true;
      for(TVec_RefCDOmIdentifier_const_iter it = netIdVec->begin(); it < netIdVec->end(); it++) {
        (*it)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(netDecl);
      }
      //m_inNetDecl = false;
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(netDecl);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmRange                         & range                              ) {
  
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(range);

    RefCDOmExpr firstExpr = range->getFirstExpr();
    if(firstExpr.get()){
      firstExpr->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(range);
    }

    RefCDOmExpr secondExpr = range->getSecondExpr();
    if(secondExpr.get()){
      secondExpr->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(range);
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(range);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmNum32                        & num                        ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;


  //---------OB added--start
  //  RefCDOmIdentifier id = CDOmIdentifier::cast(num->getParent()); 
  //  id->setIdType(CDOmIdentifier::ID_NET);
  //  id->build(1,num->getParent(),NET_WIRE);
  //------end

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(num);
       
    if((*this.*isInTraversalEnabled)())
      inTraversal(num);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(num);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmVeriNum                        & veriNum                        ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(veriNum);
       
    if((*this.*isInTraversalEnabled)())
      inTraversal(veriNum);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(veriNum);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmReal                        & realNum                        ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(realNum);
       
    if((*this.*isInTraversalEnabled)())
      inTraversal(realNum);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(realNum);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmModuleOrUdpInstantiation                      & moduleInstantiation                              ) {
 
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(moduleInstantiation);
    
/*    RefCDOmExprLink moduleExprLink = moduleInstantiation->getModuleExprLink();
    if(moduleExprLink.get()){
      moduleExprLink->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(moduleInstantiation);
    }

    RefTVec_RefCDOmModuleOrUdpInstance moduleOrUdpInstanceVec = moduleInstantiation->getModuleInstances();
    if(moduleOrUdpInstanceVec.get()){
      for(TVec_RefCDOmModuleOrUdpInstance_const_iter iter = moduleOrUdpInstanceVec->begin(); iter!=moduleOrUdpInstanceVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleInstantiation);
      }
    }

 */ 
    if(moduleInstantiation->getModuleInstantiationType() == CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN) {

      //exprLink to instantiated module
      moduleInstantiation->getChild(0)->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(moduleInstantiation);

      //parameters, in the same order as dictated by the m_explicitParamNameMap
      RefTMap_RefString_RefCDOmMinTypMax paramNames = moduleInstantiation->getExplicitParamNameMap();
      for(TMap_RefString_RefCDOmMinTypMax::const_iterator it = paramNames->begin(); it != paramNames->end(); ++it) {
        (it->second->acceptVisitor(*this));
        if((*this.*isInTraversalEnabled)())
          inTraversal(moduleInstantiation);
      }

      //instances
      RefTVec_RefCDOmBase instances = moduleInstantiation->getChildrenAsBase(TYPE_INST_MODULE);
      if(instances.get()) {
        for(TVec_RefCDOmBase_const_iter instIt = instances->begin(); instIt < instances->end(); ++instIt) {
          (*instIt)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)())
            inTraversal(moduleInstantiation);
        }
      }
    }
    else {
      RefTVec_RefCDOmBase allChildren = moduleInstantiation->getChildrenAsBase();
      if(allChildren.get()) {
        for(TVec_RefCDOmBase_const_iter iter = allChildren->begin(); iter < allChildren->end(); ++iter) {
          //leave this here (bug fixing)  
          //std::cerr << "cdom visitor moduleinstantiation: Type is " << (*iter)->getType() << std::endl;
      
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)())
            inTraversal(moduleInstantiation);
        }
      
      }
    }
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(moduleInstantiation);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmModuleOrUdpInstance                           & moduleInstance                              ) {

  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(moduleInstance);

    RefCDOmBase id = moduleInstance->getChild(0);
    if(id.get()){
      id->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(moduleInstance);
    }

    TUInt moduleInstanceType = moduleInstance->getModuleInstanceType();
    if(moduleInstanceType == CDOmModuleOrUdpInstance::MODULE_INSTANCE_NAMED_PORT_CONNECTION) { 
      RefTMap_RefString_RefCDOmExpr explicitPortNameMap = moduleInstance->getExplicitPortMap();
      if(explicitPortNameMap.get()) {
        for(TMap_RefString_RefCDOmExpr_constIter iter = explicitPortNameMap->begin(); iter != explicitPortNameMap->end(); ++iter) {
          if(iter->second.get()) {
            (iter->second)->acceptVisitor(*this);
	  }
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(moduleInstance);
	  }
        }
      }
    }
    else if(moduleInstanceType == CDOmModuleOrUdpInstance::MODULE_INSTANCE_ORDERED_PORT_CONNECTION) {

      RefTVec_RefCDOmBase exprVec = moduleInstance->getChildrenAsBase(TYPE_EXPR);
      if(exprVec.get()) {
        for(TVec_RefCDOmBase_const_iter iter = exprVec->begin(); iter < exprVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(moduleInstance);
          }
        }
      }
    }
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(moduleInstance);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmParamDeclCollection                          & paramDeclCollection                         ) {

  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(paramDeclCollection);

    RefTVec_RefCDOmParamDecl paramDeclVec = paramDeclCollection->getParamDecls();
    if(paramDeclVec.get()){
      for(TVec_RefCDOmParamDecl_const_iter iter = paramDeclVec->begin(); iter < paramDeclVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(paramDeclCollection);
        }
      }
    }
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(paramDeclCollection);
  }
}
void CVisitorTraversal::visit(const NSCdom::RefCDOmParamDecl                                    & paramDecl                                   ) {

  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(paramDecl);

    //this test is to avoid the illegal state error
    if(paramDecl->getParamDeclType2() != 2) { //CDOmParamDecl::DECL_2
      RefCDOmRange range = paramDecl->getRange();
      if(range.get()) {
        range->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(paramDecl);
        }
      }
    }

    RefTVec_RefCDOmBase paramDeclVec = paramDecl->getExclusiveChildrenAsBase(TYPE_RANGE);
    if(paramDeclVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = paramDeclVec->begin(); iter < paramDeclVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(paramDecl);
      }
    }
    //the following was disabled in order to enable pulse control traversals
    /*
    RefTVec_RefCDOmIdentifier idVec = paramDecl->getIDs();
    if(idVec.get()) {
      for(TVec_RefCDOmIdentifier_const_iter iter = idVec->begin(); iter < idVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(paramDecl);
      }
    }
    */

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(paramDecl);

  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmParamOverride                                    & paramOverride                                   ) {

  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(paramOverride);

    RefTVec_RefCDOmBase paramOverrideVec = paramOverride->getChildrenAsBase();
    if(paramOverrideVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = paramOverrideVec->begin(); iter < paramOverrideVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(paramOverride);
        }
      }
      
      if((*this.*isAfterTraversalEnabled)())
        afterTraversal(paramOverride);

    }
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmMinTypMax                        & minTypMax                        ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(minTypMax);

    RefTVec_RefCDOmBase exprVec = minTypMax->getChildrenAsBase(TYPE_EXPR);
     if(exprVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = exprVec->begin(); iter < exprVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(minTypMax);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(minTypMax);

  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmDelay                           & delay                           ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(delay);

    if(delay->getDelayDeclType() == 1){
      RefCDOmNumber number = delay->getNumDelayValue();
      if(number.get()){
        number->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(delay);
          }
      }
    } else if (delay->getDelayDeclType() == 2){
      RefCDOmReal realNum = delay->getRealNumDelayValue();
      if(realNum.get()){
        realNum->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(delay);
          }
      }
    } else if (delay->getDelayDeclType() == 3){
      RefCDOmExprLink exprLink = delay->getExprLink();
      if(exprLink.get()){
        exprLink->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(delay);
          }
      }
    } else if (delay->getDelayDeclType() == 4){
      RefTVec_RefCDOmBase mtmVec = delay->getChildrenAsBase(TYPE_EXPR);
      if(mtmVec.get()){
        for(TVec_RefCDOmBase_const_iter iter = mtmVec->begin(); iter!=mtmVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(delay);
          }
        }
      }
    }  


    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(delay);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                    ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(initOrAlways);
    /*
    RefTVec_RefCDOmBase initOrAlwaysVec = initOrAlways->getChildrenAsBase();
    if(initOrAlwaysVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = initOrAlwaysVec->begin(); iter < initOrAlwaysVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(initOrAlways);
        }
      }
    }
    */
    
    RefCDOmStmt stmt = initOrAlways->getStmt();
    if(stmt.get()){
      stmt->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(initOrAlways);
      } 
    }
    
    
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(initOrAlways);

  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmAssn                                 & assn                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(assn);

    RefCDOmExpr lvalueExpr = assn->getLvalue();
    if(lvalueExpr.get()){
      lvalueExpr->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(assn);
      }
    }

    RefCDOmExpr exprExpr = assn->getExpr();
    if(exprExpr.get()){
      exprExpr->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(assn);
      }
    }
    
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(assn);

  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmContAssn                                 & contAssn                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  //std::cout << "Called!!" << std::endl;
  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(contAssn);
    
    if(contAssn->hasDelay3()){
      RefCDOmDelay delay = contAssn->getDelay3();
      if(delay.get()){
        delay->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(contAssn);
        }
      }
    }

    RefTVec_RefCDOmAssn contAssnVec = contAssn->getNetAssns();
    if(contAssnVec.get()){
      for(TVec_RefCDOmAssn_const_iter iter = contAssnVec->begin(); iter < contAssnVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(contAssn);
        }
      }
    
      if((*this.*isAfterTraversalEnabled)())
        afterTraversal(contAssn);
    }
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmListExpr                                 & listExpr                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(listExpr);

     RefTVec_RefCDOmExpr exprVec = listExpr->getItems();
    if(exprVec.get()){
      for(TVec_RefCDOmExpr_const_iter iter = exprVec->begin(); iter < exprVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(listExpr);
        }
      }
      }
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(listExpr);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmt                         & stmt                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmt);

         if((*this.*isInTraversalEnabled)()) {
          inTraversal(stmt);
         }
    
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmt);
  }
} 

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtBlock);

    //is this method safe ?
    //std::cout << "no of children is " << stmtBlock->getChildrenSize() << "and type is " << stmtBlock->getType() << std::endl;
    /*
    RefTVec_RefCDOmBase stmtBlockVec = stmtBlock->getChildrenAsBase();
    if(stmtBlockVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = stmtBlockVec->begin(); iter < stmtBlockVec->end(); iter++ ){
        std::cout << "Type of element is " << (*iter)->getType(); << std::endl;
      }
    }
    */
    
    RefTVec_RefCDOmBase allChildren = stmtBlock->getChildrenAsBase();
    if(allChildren.get()){
      for(TVec_RefCDOmBase_const_iter iter = allChildren->begin(); iter < allChildren->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(stmtBlock);
        }
      }
    }
    
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmtBlock);
  }
}   

//WARNING: function not completed yet
void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtAssn                       & stmtAssn                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtAssn);

    RefCDOmExpr lvalueExpr = stmtAssn->getLvalue();
    if(lvalueExpr.get()){
      lvalueExpr->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(stmtAssn);
      }
    }

    if(stmtAssn->getControlType() == CDOmStmtAssn::CONTROL_DELAY_CONTROL){
      RefCDOmDelayControl delayCtrl = stmtAssn->getDelayControl();
      if(delayCtrl.get()){
        delayCtrl->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(stmtAssn);
        }        
      }
    }

    if(stmtAssn->getControlType() == CDOmStmtAssn::CONTROL_EVENT_CONTROL){
      RefCDOmEventControl eventCtrl = stmtAssn->getEventControl();
      if(eventCtrl.get()){
        eventCtrl->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(stmtAssn);
        }
      }
    }

    if(stmtAssn->getControlType() == CDOmStmtAssn::CONTROL_REPEAT_EVENT_CONTROL){
      RefCDOmExpr repeatExpr = stmtAssn->getRepeatExpr();
      if(repeatExpr.get()){
        std::cerr << "/* Repeat Expression Not implemented yet */" << std::endl;
      }
    }

    RefCDOmExpr exprExpr = stmtAssn->getExpr();
    if(exprExpr.get()){
      exprExpr->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(stmtAssn);
      }
    }
    
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmtAssn);

  }
} 

void CVisitorTraversal::visit(const NSCdom::RefCDOmEventControl                       & eventCtrl                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(eventCtrl);

    if(eventCtrl->getEventControlType() == CDOmEventControl::EVENT_CONTROL_HID){
      RefCDOmExprLink exprLink = eventCtrl->getHID();
      if(exprLink.get()){
        exprLink->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(eventCtrl);
        }
      }
    } else if (eventCtrl->getEventControlType() == CDOmEventControl::EVENT_CONTROL_EVENT_EXPR){
      RefCDOmEventExpr eventExpr = eventCtrl->getEventExpr();
      if(eventExpr.get()){
        eventExpr->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(eventCtrl);
        }
      }
    
      if((*this.*isAfterTraversalEnabled)())
        afterTraversal(eventCtrl);

    }
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmEventExpr                          & eventExpr                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(eventExpr);

    //assign a TInt with the EventExpr type
    TInt checkType = eventExpr->getEventExprType();
    
    //test the logic here
    if(checkType == CDOmEventExpr::EVENT_EXPR_EXPR || checkType == CDOmEventExpr::EVENT_EXPR_POSEDGE || checkType == CDOmEventExpr::EVENT_EXPR_NEGEDGE ){
      RefCDOmExpr expr = eventExpr->getExpr();
      if(expr.get()){
        expr->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(eventExpr);
        }
      }
      } else if( checkType == CDOmEventExpr::EVENT_EXPR_OR || checkType == CDOmEventExpr::EVENT_EXPR_COMMA ) {
      RefCDOmEventExpr eventExpr1 = eventExpr->getEventExpr1();
      if(eventExpr1.get()){
        eventExpr1->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(eventExpr);
        }
      } 
      RefCDOmEventExpr eventExpr2 = eventExpr->getEventExpr2();
      if(eventExpr2.get()){
        eventExpr2->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(eventExpr);
        }
      } 
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(eventExpr);

  }
} 

void CVisitorTraversal::visit(const NSCdom::RefCDOmDelayControl                          & delayCtrl                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(delayCtrl);

    //delayCtrl type TInt
    TInt delayCtrlType = delayCtrl->getDelayControlType();

    switch( delayCtrlType ) {
      case( CDOmDelayControl::DELAY_CONTROL_UNSIGNED_NUMBER ) :
        {
          RefCDOmNumber unsignedNum = delayCtrl->getNumber();
          if(unsignedNum.get()){
          unsignedNum->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(delayCtrl);
          }
          }
          break;
        }
      case( CDOmDelayControl::DELAY_CONTROL_REAL_NUMBER     ) :
        {
          RefCDOmReal realNum = delayCtrl->getRealNumber();
          if(realNum.get()){
          realNum->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(delayCtrl);
          }
          }
          break;
        }
      case( CDOmDelayControl::DELAY_CONTROL_IDENTIFIER      ) :
        {
          RefCDOmExprLink exprLink = delayCtrl->getExprLink();
          if(exprLink.get()){
          exprLink->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(delayCtrl);
          }
          }
          break;
        }
      case( CDOmDelayControl::DELAY_CONTROL_MINTYPMAX       ) :
        {
          RefCDOmMinTypMax minTypMax = delayCtrl->getMinTypMax();
          if(minTypMax.get()){
          minTypMax->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(delayCtrl);
          }
          }
          break;
        }
      default                                                 :
        std::cerr << "Unknown Delay Control Type";
        break;
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(delayCtrl);

  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtProcContAssn                          & stmtPCAssn                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtPCAssn);

    RefTVec_RefCDOmBase stmtPCAssnVec = stmtPCAssn->getChildrenAsBase();
    if(stmtPCAssnVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = stmtPCAssnVec->begin(); iter < stmtPCAssnVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(stmtPCAssn);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmtPCAssn);

  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtProcTimingControl                          & stmtPTCtrl                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtPTCtrl);

    //stmtPTCtrl type TInt
    TInt stmtPTCtrlType = stmtPTCtrl->getProcTimingControlType(); 

    if( stmtPTCtrlType == CDOmStmtProcTimingControl::PROC_TIMING_CONTROL_DELAY ){
      RefCDOmDelayControl delayControl = stmtPTCtrl->getDelayControl();
      if(delayControl.get()){
        delayControl->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(stmtPTCtrl);
        }
      }
    } else if( stmtPTCtrlType == CDOmStmtProcTimingControl::PROC_TIMING_CONTROL_EVENT ){
      RefCDOmEventControl eventControl = stmtPTCtrl->getEventControl();
      if(eventControl.get()){
        eventControl->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(stmtPTCtrl);
        }
      }
    }

    RefCDOmStmt stmt = stmtPTCtrl->getStmt();
    if(stmt.get()){
      stmt->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(stmtPTCtrl);
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmtPTCtrl);

  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtCase                                        & stmtCase                        ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtCase);

    RefTVec_RefCDOmBase caseChildren = stmtCase->getChildrenAsBase();
    if(caseChildren.get()){
      for(TVec_RefCDOmBase_const_iter iter = caseChildren->begin(); iter < caseChildren->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(stmtCase);
        }
      }
    }
    
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmtCase);

  }
  
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtIf                                           & stmtIf                          ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    /*
    std::cout << std::endl << "/// PRINTING ///" << std::endl;
    RefTVec_RefCDOmBase stmtIfVec = stmtIf->getChildrenAsBase();
    std::cout << "No of children is " << stmtIfVec->size() << std::endl;
    for(TVec_RefCDOmBase_const_iter iter = stmtIfVec->begin(); iter < stmtIfVec->end(); iter++){
      std::cout << "type is " << (*iter)->getType() << std::endl;
    }
    std::cout << std::endl;
    */

    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtIf);

    RefTVec_RefCDOmBase attrLists = stmtIf->getChildrenAsBase(TYPE_ATTR_LIST_COLLECTION);
    if(attrLists.get()){
      for(TVec_RefCDOmBase_const_iter iter = attrLists->begin(); iter < attrLists->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(stmtIf);
        }        
      }
    }


    RefCDOmExpr ifCondExpr = stmtIf->getIfCondExpr();
    if(ifCondExpr.get()){
      //std::cout << "<<< in if cond >>>" << std::endl;
      ifCondExpr->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(stmtIf);
      }
      //std::cout << "<<< after if cond >>>>" << std::endl;
    }
    
    RefCDOmStmt ifStmt = stmtIf->getIfStmt();
    if(ifStmt.get()){
      //std::cout << "<<< in if stmt >>>" << std::endl;
      ifStmt->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(stmtIf);
      }
      //std::cout << "<<< after if stmt >>>" << std::endl;
    }

    RefCDOmStmt elseStmt = stmtIf->getElseStmt();
    if(elseStmt.get()){
      
      //std::cout << "in else stmt " << std::endl;
      elseStmt->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(stmtIf);
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmtIf);

  }
  
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtLoop                                           & stmtLoop                          ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtLoop);

    TInt stmtLoopType = stmtLoop->getLoopType();

    switch( stmtLoopType ) {
      case( CDOmStmtLoop::LOOP_FOREVER ) :
        {
          RefCDOmStmt stmt = stmtLoop->getStmt();
          if(stmt.get()){
            stmt->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()){
              inTraversal(stmtLoop);
            }
          }
          break;
        }
      case( CDOmStmtLoop::LOOP_REPEAT ) :
        {
          RefCDOmExpr expr = stmtLoop->getExpr();
          if(expr.get()){
            expr->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()){
              inTraversal(stmtLoop);
            }
          }     

          RefCDOmStmt stmt = stmtLoop->getStmt();
          if(stmt.get()){
            stmt->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()){
              inTraversal(stmtLoop);
            }
          }
          break;
        }
      case( CDOmStmtLoop::LOOP_WHILE ) :
        {
          RefCDOmExpr expr = stmtLoop->getExpr();
          if(expr.get()){
            expr->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()){
              inTraversal(stmtLoop);
            }
          }     

          RefCDOmStmt stmt = stmtLoop->getStmt();
          if(stmt.get()){
            stmt->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()){
              inTraversal(stmtLoop);
            }
          }
          break;
        }
    case( CDOmStmtLoop::LOOP_FOR ) :
        {
          RefCDOmAssn initForAssn = stmtLoop->getInitForAssn();
          if(initForAssn.get()){
            initForAssn->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()){
              inTraversal(stmtLoop);
            }
          }

          RefCDOmExpr expr = stmtLoop->getExpr();
          if(expr.get()){
            expr->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()){
              inTraversal(stmtLoop);
            }
          } 

          RefCDOmAssn incForAssn = stmtLoop->getIncForAssn();
          if(incForAssn.get()){
            incForAssn->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()){
              inTraversal(stmtLoop);
            }
          }
    
          RefCDOmStmt stmt = stmtLoop->getStmt();
          if(stmt.get()){
            stmt->acceptVisitor(*this);
            if((*this.*isInTraversalEnabled)()){
              inTraversal(stmtLoop);
            }
          }
          break;
        }
 
      default                                                 :
        std::cerr << "Unknown Loop Type";
        break;
    }


    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmtLoop);

  }
  
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtTaskEnable                                     & stmtTaskEnable                   ){

  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  //NOT IMPLEMENTED YET
  //std::cerr << "System tasks and task enable not implemented yet!" ;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtTaskEnable);

    RefTVec_RefCDOmBase stmtTaskEnableVec = stmtTaskEnable->getChildrenAsBase(TYPE_ALL_TYPES);
    if(stmtTaskEnableVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = stmtTaskEnableVec->begin(); iter < stmtTaskEnableVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(stmtTaskEnable);
          }
      }
    }


      if((*this.*isAfterTraversalEnabled)())
        afterTraversal(stmtTaskEnable);
    }
  }

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtWait                          & stmtWait                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtWait);

    RefTVec_RefCDOmBase stmtWaitVec = stmtWait->getChildrenAsBase();
    if(stmtWaitVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = stmtWaitVec->begin(); iter < stmtWaitVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(stmtWait);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmtWait);

  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtDisable                          & stmtDisable                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtDisable);


    RefCDOmExprLink exprLink = stmtDisable->getHID();
    if(exprLink.get()){
      exprLink->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(stmtDisable);
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmtDisable);

  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmStmtEventTrigger                          & stmtEventTrigger                       ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stmtEventTrigger);


    RefCDOmExprLink exprLink = stmtEventTrigger->getHID();
    if(exprLink.get()){
      exprLink->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(stmtEventTrigger);
      }
    }

    RefCDOmListExpr listExpr = stmtEventTrigger->getExprList();
    if(listExpr.get()){
      listExpr->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(stmtEventTrigger);
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stmtEventTrigger);

  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmRangeExpr                                           & rangeExpr                          ){

  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(rangeExpr);

    RefCDOmExpr expr1 = rangeExpr->getFirstExpr();
    if(expr1.get()){
      expr1->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(rangeExpr);
      }
    }

    if(rangeExpr->getRangeExprType() != CDOmRangeExpr::RANGE_EXPR_SINGLE ){
      RefCDOmExpr expr2 = rangeExpr->getSecondExpr();
      if(expr2.get()){
        expr2->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(rangeExpr);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(rangeExpr);

  }
  
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmRangeList                                           & rangeList                        ){

  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(rangeList);

   RefTVec_RefCDOmRange rangeVec = rangeList->getItems();
   if(rangeVec.get()){
     for(TVec_RefCDOmRange_const_iter iter = rangeVec->begin(); iter < rangeVec->end(); iter++){
       (*iter)->acceptVisitor(*this);
       if((*this.*isInTraversalEnabled)()){
         inTraversal(rangeList);
       }
     }
   }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(rangeList);

  }
  
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmExprConcat                                           & exprConcat                      ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(exprConcat);

    //should this method be kept, or implement a method specific to the class ? eg: getExprs()
    RefTVec_RefCDOmBase exprConcatVec = exprConcat->getChildrenAsBase(TYPE_EXPR);
    if(exprConcatVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = exprConcatVec->begin(); iter < exprConcatVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(exprConcat);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(exprConcat);

  }

}

void CVisitorTraversal::visit(const NSCdom::RefCDOmExprMultiConcat                                       & exprMultiConcat                 ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(exprMultiConcat);
    
    RefCDOmExpr expr = exprMultiConcat->getExpr();
    if(expr.get()){
      expr->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(exprMultiConcat);
      }
    }

    RefCDOmExprConcat exprConcat = exprMultiConcat->getExprConcat();
    if(exprConcat.get()){
      exprConcat->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()){
        inTraversal(exprMultiConcat);
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(exprMultiConcat);

  }

}

/*
void CVisitorTraversal::visit(const NSCdom::RefCDOmModuleOrUdpInstance                           & moduleInstance                              ) {
  //TRACE_ME(11, "void CVisitorTraversal::visit(const NSCdom::RefCDOmModuleOrUdpInstance                      & moduleInstance                              )" );
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(moduleInstance);

     
    // what is this ?
    // RefCDOmRange cdomRange = moduleInstance->getRange();
    //cdomRange->acceptVisitor(*this);
    //RefCDOmExpr cdomExpr = moduleInstance->getPortExpr();
    //cdomExpr->acceptVisitor(*this);
    /* RefTMap_RefString_RefCDOmExpr explicitPortsMap = moduleInstance->getExplicitPortMap();
    if(explicitPortsMap.get()){
      for(TMap_RefString_RefCDOmExpr_constIter iter = explicitPortsMap->begin(); iter < explicitPortsMap->end(); iter++){
        (*iter)->acceptVisitor(*this);
      }
      }*/
    /// ** The following code needs to be rewritten ** ///
/*    
    if(moduleInstance->getModuleInstanceType()==CDOmModuleOrUdpInstance::MODULE_INSTANCE_ORDERED_PORT_CONNECTION){
      std::vector<TUInt>* emptyIndexesVec = moduleInstance->getEmptyIndexes();
    RefTVec_RefCDOmBase exprVec = moduleInstance->getChildrenAsBase(TYPE_EXPR);
    reverse(emptyIndexesVec->begin(),emptyIndexesVec->end());
    TUInt emptyIndex = emptyIndexesVec->back();
    TUInt cnt = 0;
    if(exprVec.get() && emptyIndexesVec != NULL){
      for(TVec_RefCDOmBase_const_iter iter = exprVec->begin(); iter < exprVec->end(); iter++){
        if(cnt == emptyIndex){
          if(isInTraversalEnabled && iter < exprVec->end()-1){
            inTraversal(moduleInstance);
          }
          emptyIndexesVec->pop_back();
          emptyIndex = emptyIndexesVec->back();
        } else {
          (*iter)->acceptVisitor(*this);
          if(isInTraversalEnabled && iter < exprVec->end()-1)
            inTraversal(moduleInstance);
        }
        cnt++;
      }
    }
    }
    

    if(moduleInstance->getModuleInstanceType()==CDOmModuleOrUdpInstance::MODULE_INSTANCE_ORDERED_PORT_CONNECTION){
      RefTVec_RefCDOmBase exprVec = moduleInstance->getChildrenAsBase(TYPE_EXPR);
      if(exprVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = exprVec->begin(); iter < exprVec->end(); iter++){
         (*iter)->acceptVisitor(*this);
        if(isInTraversalEnabled && iter < exprVec->end()-1){
          inTraversal(moduleInstance);
         
        }
      }
      }
    }
 
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(moduleInstance);
  }
}
*/

/*






void CVisitorTraversal::visit(const NSCdom::RefCDOmDelay                           & delay                           ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(delay);

    if(delay->getDelayDeclType() == 1){
      RefCDOmNumber number = delay->getNumDelayValue();
      if(number.get()){
        number->acceptVisitor(*this);
      }
    } else if (delay->getDelayDeclType() == 2){
      RefCDOmReal realNum = delay->getRealNumDelayValue();
      if(realNum.get()){
        realNum->acceptVisitor(*this);
      }
    } else if (delay->getDelayDeclType() == 3){
      RefCDOmBase id = delay->getChild(0);
      if(id.get()){
        id->acceptVisitor(*this);
      }
    } else if (delay->getDelayDeclType() == 4){
      RefTVec_RefCDOmBase mtmVec = delay->getChildrenAsBase(TYPE_EXPR);
      if(mtmVec.get()){
        for(TVec_RefCDOmBase_const_iter iter = mtmVec->begin(); iter!=mtmVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
          if(isInTraversalEnabled && iter < mtmVec->end()-1){
            inTraversal(delay);
          }
        }
      }
    }  


    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(delay);
  }
}
*/

void CVisitorTraversal::visit(const NSCdom::RefCDOmUdpDecl                           & udpDecl                           ) {
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(udpDecl);
  /*
    RefCDOmBase id = udpDecl->getChild(0);
    if(id.get()){
      id->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(udpDecl);
    }
   
    RefTVec_RefCDOmBase portDeclsVec = udpDecl->getChildrenAsBase(TYPE_UDP_PORT_DECL_OUTPUT);
    if(portDeclsVec.get()) {
      for(TVec_RefCDOmBase_const_iter iter = portDeclsVec->begin(); iter < portDeclsVec->end(); ++iter) {
        (*iter)->acceptVisitor(*this); 
        if((*this.*isInTraversalEnabled)())
          inTraversal(udpDecl);
      }
    }

    portDeclsVec = udpDecl->getChildrenAsBase(TYPE_UDP_PORT_DECL_INPUT);
    if(portDeclsVec.get()) {
      for(TVec_RefCDOmBase_const_iter iter = portDeclsVec->begin(); iter < portDeclsVec->end(); ++iter) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(udpDecl);
      }
    }

    RefTVec_RefCDOmBase initStmt = udpDecl->getChildrenAsBase(TYPE_UDP_INIT_STMT);
    if(initStmt.get()) {
      (initStmt->at(0))->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(udpDecl);
    }
    
    RefTVec_RefCDOmBase combOrSeqEntries = udpDecl->getChildrenAsBase(TYPE_UDP_COMB_ENTRY);
    if(combOrSeqEntries.get()) {
      for(TVec_RefCDOmBase_const_iter iter = combOrSeqEntries->begin(); iter < combOrSeqEntries->end(); ++iter) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(udpDecl);
      }
    }
    
    combOrSeqEntries = udpDecl->getChildrenAsBase(TYPE_UDP_SEQ_ENTRY);
    if(combOrSeqEntries.get()) {
      for(TVec_RefCDOmBase_const_iter iter = combOrSeqEntries->begin(); iter < combOrSeqEntries->end(); ++iter) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(udpDecl);
      }
    }
    */
    
    RefTVec_RefCDOmBase allChildren = udpDecl->getChildrenAsBase();
    if(allChildren.get()) {
      for(TVec_RefCDOmBase_const_iter iter = allChildren->begin(); iter < allChildren->end(); ++iter) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(udpDecl);
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(udpDecl);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmUdpPortDeclOutput                  & udpPortDeclOutput                   ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(udpPortDeclOutput);

    RefCDOmIdentifier id = udpPortDeclOutput->getID();
    if(id.get()){
      id->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)())
        inTraversal(udpPortDeclOutput); 
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(udpPortDeclOutput);
  }
}


void CVisitorTraversal::visit(const NSCdom::RefCDOmUdpPortDeclInput                  & udpPortDeclInput                   ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(udpPortDeclInput);

    RefTVec_RefCDOmIdentifier idVec = udpPortDeclInput->getIDs();
    if(idVec.get()){
      for(TVec_RefCDOmIdentifier_const_iter it = idVec->begin(); it < idVec->end(); it++) {
        (*it)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)())
          inTraversal(udpPortDeclInput);
      } 
    }
        
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(udpPortDeclInput);
  }
}


void CVisitorTraversal::visit(const NSCdom::RefCDOmUdpCombEntry                     & udpCombEntry                    ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(udpCombEntry);

    if((*this.*isInTraversalEnabled)())
      inTraversal(udpCombEntry);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(udpCombEntry);
  }
}


void CVisitorTraversal::visit(const NSCdom::RefCDOmUdpSeqEntry                       & udpSeqEntry                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(udpSeqEntry);

    if((*this.*isInTraversalEnabled)())
      inTraversal(udpSeqEntry);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(udpSeqEntry);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmUdpInitStmt                       & udpInitStmt                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(udpInitStmt);

    if((*this.*isInTraversalEnabled)())
      inTraversal(udpInitStmt);

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(udpInitStmt);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmTaskDecl                       & taskDecl                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(taskDecl);

    RefTVec_RefCDOmBase taskDeclVec = taskDecl->getChildrenAsBase();
    if(taskDeclVec.get()) {
      for(TVec_RefCDOmBase_const_iter iter = taskDeclVec->begin(); iter < taskDeclVec->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(taskDecl);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(taskDecl);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmTFPortDecl                     & tfPortDecl                    ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(tfPortDecl);

    RefTVec_RefCDOmBase allChildren = tfPortDecl->getChildrenAsBase();
    if(tfPortDecl.get()){
      for(TVec_RefCDOmBase_const_iter iter = allChildren->begin(); iter < allChildren->end(); iter++) {
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()){
          inTraversal(tfPortDecl);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(tfPortDecl);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmFuncDecl                       & funcDecl                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(funcDecl);
    
    RefTVec_RefCDOmBase funcDeclRange = funcDecl->getChildrenAsBase(TYPE_RANGE);
    if(funcDeclRange.get()){
      //We are only interested in the first element; Besides, there should only be one element here (Check Verilog BNF)
      (funcDeclRange->at(0))->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()) {
        inTraversal(funcDecl);
      }
    }

    RefTVec_RefCDOmBase funcDeclVec = funcDecl->getExclusiveChildrenAsBase(TYPE_RANGE);
    if(funcDeclVec.get()) {
      for(TVec_RefCDOmBase_const_iter iter = funcDeclVec->begin(); iter < funcDeclVec->end(); iter++) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(funcDecl);
          }
      }
    }
    /*
    RefTVec_RefCDOmBase funcDeclVec = funcDecl->getChildrenAsBase(TYPE_ALL_TYPES);
    if(funcDeclVec.get()) {
      for(TVec_RefCDOmBase_const_iter iter = funcDeclVec->begin(); iter < funcDeclVec->end(); iter++) {
        if((*iter)->getType() != NSCdom::TYPE_RANGE) {
          (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(funcDecl);
          }
        }
      }
    }
    */
    

      if((*this.*isAfterTraversalEnabled)())
        afterTraversal(funcDecl);
    }
  }


void CVisitorTraversal::visit(const NSCdom::RefCDOmFunctionCall                       & functionCall                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(functionCall);

    RefTVec_RefCDOmBase functionCallVec = functionCall->getChildrenAsBase(TYPE_ALL_TYPES);
    if(functionCallVec.get()){

      for(TVec_RefCDOmBase_const_iter iter = functionCallVec->begin(); iter < functionCallVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
           if((*this.*isInTraversalEnabled)()) {
            inTraversal(functionCall);
          }
      }
    }


      if((*this.*isAfterTraversalEnabled)())
        afterTraversal(functionCall);
    }
  }


void CVisitorTraversal::visit(const NSCdom::RefCDOmGenvarDecl                       & genvarDecl                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(genvarDecl);

    RefTVec_RefCDOmBase genvarDeclVec = genvarDecl->getChildrenAsBase();
    if(genvarDeclVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = genvarDeclVec->begin(); iter < genvarDeclVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(genvarDecl);
          }
      }
    }

      if((*this.*isAfterTraversalEnabled)())
        afterTraversal(genvarDecl);
    }
  }

void CVisitorTraversal::visit(const NSCdom::RefCDOmGenInst                       & genInst                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(genInst);

    RefTVec_RefCDOmBase genInstVec = genInst->getChildrenAsBase();
    if(genInstVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = genInstVec->begin(); iter < genInstVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(genInst);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(genInst);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmGenItemNull                       & genItemNull                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(genItemNull);

    RefTVec_RefCDOmBase genItemNullVec = genItemNull->getChildrenAsBase();
    if(genItemNullVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = genItemNullVec->begin(); iter < genItemNullVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
            inTraversal(genItemNull);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(genItemNull);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmGenItemIf                       & genItemIf                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(genItemIf);

    RefTVec_RefCDOmBase genItemIfVec = genItemIf->getChildrenAsBase();
    if(genItemIfVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = genItemIfVec->begin(); iter < genItemIfVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(genItemIf);
          }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(genItemIf);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmGenItemCase                       & genItemCase                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(genItemCase);

    RefTVec_RefCDOmBase genItemCaseVec = genItemCase->getChildrenAsBase();
    if(genItemCaseVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = genItemCaseVec->begin(); iter < genItemCaseVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(genItemCase);
          }
      }
    }


      if((*this.*isAfterTraversalEnabled)())
        afterTraversal(genItemCase);
    }
  }

void CVisitorTraversal::visit(const NSCdom::RefCDOmGenItemLoop                       & genItemLoop                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(genItemLoop);

    RefTVec_RefCDOmBase genItemLoopVec = genItemLoop->getChildrenAsBase();
    if(genItemLoopVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = genItemLoopVec->begin(); iter < genItemLoopVec->end(); iter++){
         (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(genItemLoop);
          }
      }
    }
      if((*this.*isAfterTraversalEnabled)())
        afterTraversal(genItemLoop);
    }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmGenItemBlock                       & genItemBlock                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(genItemBlock);

    RefTVec_RefCDOmBase genItemBlockVec = genItemBlock->getChildrenAsBase();
    if(genItemBlockVec.get()){
      for(TVec_RefCDOmBase_const_iter iter = genItemBlockVec->begin(); iter < genItemBlockVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()) {
            inTraversal(genItemBlock);
          }
      }
    }


      if((*this.*isAfterTraversalEnabled)())
        afterTraversal(genItemBlock);
    }
  }

void CVisitorTraversal::visit(const NSCdom::RefCDOmString                       & stringObj                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(stringObj);


    //RefCVeriNum getVeriNum() const;
    //RefTVec_RefCDOmBase stringObjVec = genItemBlock->getChildrenAsBase(TYPE_ALL_TYPES);
    //if(genItemBlockVec.get()){
    // for(TVec_RefCDOmBase_const_iter iter = genItemBlockVec->begin(); iter < genItemBlockVec->end(); iter++){
    //   (*iter)->acceptVisitor(*this);

    if((*this.*isInTraversalEnabled)()) {
      inTraversal(stringObj);
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(stringObj);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmEventDecl                       & eventDecl                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(eventDecl);

    RefTVec_RefCDOmIdentifier eventDeclVec = eventDecl->getIDs();
    if(eventDeclVec.get()){
      for(TVec_RefCDOmIdentifier_const_iter iter = eventDeclVec->begin(); iter < eventDeclVec->end(); iter++){
        (*iter)->acceptVisitor(*this);
        //RefCDOmBase payload = (*iter)->getPayload();
        //if(payload.get()){
        //  std::cout << "payload type is " << payload->getType() << std::endl;
        //}
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(eventDecl);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(eventDecl);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmSpecifyBlock                       & specifyBlock                     ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(specifyBlock);

    RefTVec_RefCDOmBase specifyBlockVec = specifyBlock->getChildrenAsBase();
    if(specifyBlockVec.get()){
      //std::cout << "Number of children is " << specifyBlockVec->size();
      for(TVec_RefCDOmBase_const_iter iter = specifyBlockVec->begin(); iter < specifyBlockVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType();
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(specifyBlock);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(specifyBlock);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl      & pulseSSCd                        ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(pulseSSCd);

    RefTVec_RefCDOmBase pulseSSCdVec = pulseSSCd->getChildrenAsBase();
    if(pulseSSCdVec.get()){
      //std::cout << "Number of children is " << pulseSSCdVec->size();
      for(TVec_RefCDOmBase_const_iter iter = pulseSSCdVec->begin(); iter < pulseSSCdVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType();
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(pulseSSCd);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(pulseSSCd);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmPathDecl                           & pathDecl                         ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(pathDecl);

    RefTVec_RefCDOmBase pathDeclVec = pathDecl->getChildrenAsBase();
    if(pathDeclVec.get()){
      //std::cout << "Number of children is " << pathDeclVec->size();
      for(TVec_RefCDOmBase_const_iter iter = pathDeclVec->begin(); iter < pathDeclVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType();
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(pathDecl);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(pathDecl);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmPathDelayValue                     & pathDelayValue                    ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(pathDelayValue);

    RefTVec_RefCDOmBase pathDelayValueVec = pathDelayValue->getChildrenAsBase();
    if(pathDelayValueVec.get()){
      //std::cout << "Number of children is " << pathDelayValueVec->size();
      for(TVec_RefCDOmBase_const_iter iter = pathDelayValueVec->begin(); iter < pathDelayValueVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType();
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(pathDelayValue);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(pathDelayValue);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmMinTypMaxList                 & minTypMaxList              ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(minTypMaxList);

    RefTVec_RefCDOmBase minTypMaxListVec = minTypMaxList->getChildrenAsBase();
    if(minTypMaxListVec.get()){
      //std::cout << "Number of children is " << minTypMaxListVec->size() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = minTypMaxListVec->begin(); iter < minTypMaxListVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(minTypMaxList);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(minTypMaxList);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmSpecifyTerminalList                 & specifyTerminalList              ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(specifyTerminalList);

    RefTVec_RefCDOmBase specifyTerminalListVec = specifyTerminalList->getChildrenAsBase();
    if(specifyTerminalListVec.get()){
      //std::cout << "Number of children is " << specifyTerminalListVec->size() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = specifyTerminalListVec->begin(); iter < specifyTerminalListVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(specifyTerminalList);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(specifyTerminalList);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmDelayedDataOrReference             & delayedDataOrRef                  ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(delayedDataOrRef);
    
    RefCDOmExprLink exprLink = delayedDataOrRef->getTerminalIdentifier();
    if(exprLink.get()){
      exprLink->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()) {
        inTraversal(delayedDataOrRef);
      }
    }
    
    RefCDOmMinTypMax minTypMax = delayedDataOrRef->getMinTypMax();
    if(minTypMax.get()){
      minTypMax->acceptVisitor(*this);
      if((*this.*isInTraversalEnabled)()) {
        inTraversal(delayedDataOrRef);
      }
    }
    
    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(delayedDataOrRef);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmTimingCheckEventControl             & timingCkEventCtrl                 ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(timingCkEventCtrl);

    RefTVec_RefCDOmBase timingCkEventCtrlVec = timingCkEventCtrl->getChildrenAsBase();
    if(timingCkEventCtrlVec.get()){
      //std::cout << "Number of children is " << timingCkEventCtrlVec->size() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = timingCkEventCtrlVec->begin(); iter < timingCkEventCtrlVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(timingCkEventCtrl);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(timingCkEventCtrl);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmTimingCheckEvent                     & timingCkEvent                    ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(timingCkEvent);

    RefTVec_RefCDOmBase timingCkEventVec = timingCkEvent->getChildrenAsBase();
    if(timingCkEventVec.get()){
      //std::cout << "Number of children is " << timingCkEventVec->size() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = timingCkEventVec->begin(); iter < timingCkEventVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(timingCkEvent);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(timingCkEvent);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmSystemTimingCheck                     & systemTimingCk                  ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(systemTimingCk);
    /*
    RefTVec_RefCDOmBase systemTimingCkVec = systemTimingCk->getChildrenAsBase();
    if(systemTimingCkVec.get()){
      //std::cout << "Number of children is " << systemTimingCkVec->size() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = systemTimingCkVec->begin(); iter < systemTimingCkVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(systemTimingCk);
        }
      }
    }
    */
    TInt m_timingCheckEventType = systemTimingCk->getTimingCheckType();
    switch(m_timingCheckEventType){
      case(CDOmSystemTimingCheck::TIMING_CHECK_SETUP    ) : { 
        RefCDOmTimingCheckEvent   dataEvent              = systemTimingCk->getDataEvent();        
        if(dataEvent.get()){
          dataEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmTimingCheckEvent   referenceEvent         = systemTimingCk->getReferenceEvent();  
        if(referenceEvent.get()){
          referenceEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               timingCkLimit          = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit.get()){
          timingCkLimit->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink           notifyReg              = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_HOLD     ) : {
        RefCDOmTimingCheckEvent   referenceEvent         = systemTimingCk->getReferenceEvent();  
        if(referenceEvent.get()){
          referenceEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmTimingCheckEvent   dataEvent              = systemTimingCk->getDataEvent();        
        if(dataEvent.get()){
          dataEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
                             }
        RefCDOmExpr               timingCkLimit          = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit.get()){
          timingCkLimit->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink           notifyReg              = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_SETUPHOLD) : {
        RefCDOmTimingCheckEvent       referenceEvent     = systemTimingCk->getReferenceEvent();  
        if(referenceEvent.get()){
          referenceEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmTimingCheckEvent       dataEvent          = systemTimingCk->getDataEvent();        
        if(dataEvent.get()){
          dataEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
                             }
        RefCDOmExpr                   timingCkLimit1     = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit1.get()){
          timingCkLimit1->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr                   timingCkLimit2     = systemTimingCk->getTimingCheckLimit2();        
        if(timingCkLimit2.get()){
          timingCkLimit2->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink               notifyReg          = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmMinTypMax              stampTimeCondition = systemTimingCk->getStampTimeCondition();
        if(stampTimeCondition.get()){
          stampTimeCondition->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmMinTypMax              checktimeCondition = systemTimingCk->getCheckTimeCondition();
        if(checktimeCondition.get()){
          checktimeCondition->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmDelayedDataOrReference delayedRef         = systemTimingCk->getDelayedReference();  
        if(delayedRef.get()){
          delayedRef->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmDelayedDataOrReference delayedData        = systemTimingCk->getDelayedData();       
        if(delayedData.get()){
          delayedData->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_RECOVERY ) : {
        RefCDOmTimingCheckEvent   referenceEvent         = systemTimingCk->getReferenceEvent();  
        if(referenceEvent.get()){
          referenceEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmTimingCheckEvent   dataEvent              = systemTimingCk->getDataEvent();        
        if(dataEvent.get()){
          dataEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               timingCkLimit          = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit.get()){
          timingCkLimit->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink           notifyReg              = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_REMOVAL  ) : { 
        RefCDOmTimingCheckEvent   referenceEvent         = systemTimingCk->getReferenceEvent();  
        if(referenceEvent.get()){
          referenceEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmTimingCheckEvent   dataEvent              = systemTimingCk->getDataEvent();        
        if(dataEvent.get()){
          dataEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               timingCkLimit          = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit.get()){
          timingCkLimit->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink           notifyReg              = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_RECREM   ) : { 
        RefCDOmTimingCheckEvent       referenceEvent     = systemTimingCk->getReferenceEvent();  
        if(referenceEvent.get()){
          referenceEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmTimingCheckEvent       dataEvent          = systemTimingCk->getDataEvent();        
        if(dataEvent.get()){
          dataEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr                   timingCkLimit1     = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit1.get()){
          timingCkLimit1->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr                   timingCkLimit2     = systemTimingCk->getTimingCheckLimit2();        
        if(timingCkLimit2.get()){
          timingCkLimit2->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink               notifyReg          = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmMinTypMax              stampTimeCondition = systemTimingCk->getStampTimeCondition();
        if(stampTimeCondition.get()){
          stampTimeCondition->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmMinTypMax              checktimeCondition = systemTimingCk->getCheckTimeCondition();
        if(checktimeCondition.get()){
          checktimeCondition->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmDelayedDataOrReference delayedRef         = systemTimingCk->getDelayedReference();  
        if(delayedRef.get()){
          delayedRef->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmDelayedDataOrReference delayedData        = systemTimingCk->getDelayedData();       
        if(delayedData.get()){
          delayedData->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_SKEW     ) : { 
        RefCDOmTimingCheckEvent   referenceEvent         = systemTimingCk->getReferenceEvent();  
        if(referenceEvent.get()){
          referenceEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmTimingCheckEvent   dataEvent              = systemTimingCk->getDataEvent();        
        if(dataEvent.get()){
          dataEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               timingCkLimit          = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit.get()){
          timingCkLimit->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink           notifyReg              = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_TIMESKEW ) : { 
        RefCDOmTimingCheckEvent   referenceEvent         = systemTimingCk->getReferenceEvent();  
        if(referenceEvent.get()){
          referenceEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmTimingCheckEvent   dataEvent              = systemTimingCk->getDataEvent();        
        if(dataEvent.get()){
          dataEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               timingCkLimit          = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit.get()){
          timingCkLimit->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink           notifyReg              = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               eventBasedFlag         = systemTimingCk->getEventBasedFlag();
        if(eventBasedFlag.get()){
          eventBasedFlag->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmMinTypMax          remainActiveFlag       = systemTimingCk->getRemainActiveFlag();
        if(remainActiveFlag.get()){
          remainActiveFlag->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_FULLSKEW ) : {
        RefCDOmTimingCheckEvent   referenceEvent         = systemTimingCk->getReferenceEvent();  
        if(referenceEvent.get()){
          referenceEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmTimingCheckEvent   dataEvent              = systemTimingCk->getDataEvent();        
        if(dataEvent.get()){
          dataEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               timingCkLimit1         = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit1.get()){
          timingCkLimit1->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               timingCkLimit2         = systemTimingCk->getTimingCheckLimit2();        
        if(timingCkLimit2.get()){
          timingCkLimit2->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink           notifyReg              = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               eventBasedFlag         = systemTimingCk->getEventBasedFlag();
        if(eventBasedFlag.get()){
          eventBasedFlag->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmMinTypMax          remainActiveFlag       = systemTimingCk->getRemainActiveFlag();
        if(remainActiveFlag.get()){
          remainActiveFlag->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_PERIOD   ) : {
        RefCDOmTimingCheckEvent   controlledRefEvent     = systemTimingCk->getControlledReferenceEvent();
        if(controlledRefEvent.get()){
          controlledRefEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               timingCkLimit          = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit.get()){
          timingCkLimit->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink           notifyReg              = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_WIDTH    ) : {
        RefCDOmTimingCheckEvent   controlledRefEvent     = systemTimingCk->getControlledReferenceEvent();
        if(controlledRefEvent.get()){
          controlledRefEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               timingCkLimit          = systemTimingCk->getTimingCheckLimit1();
        if(timingCkLimit.get()){
          timingCkLimit->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExpr               threshold               = systemTimingCk->getThreshold();
        if(threshold.get()){
          threshold->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink           notifyReg              = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
      case(CDOmSystemTimingCheck::TIMING_CHECK_NOCHANGE ) : {
        RefCDOmTimingCheckEvent   referenceEvent         = systemTimingCk->getReferenceEvent();  
        if(referenceEvent.get()){
          referenceEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmTimingCheckEvent   dataEvent              = systemTimingCk->getDataEvent();        
        if(dataEvent.get()){
          dataEvent->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmMinTypMax          startEdgeOffset        = systemTimingCk->getStartEdgeOffset();
        if(startEdgeOffset.get()){
          startEdgeOffset->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmMinTypMax          endEdgeOffset          = systemTimingCk->getEndEdgeOffset();  
        if(endEdgeOffset.get()){
          endEdgeOffset->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
        RefCDOmExprLink           notifyReg              = systemTimingCk->getNotifyReg();
        if(notifyReg.get()){
          notifyReg->acceptVisitor(*this);
          if((*this.*isInTraversalEnabled)()){
            inTraversal(systemTimingCk);
          }
        }
      } break;
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(systemTimingCk);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmGateInstantiation                     & gateInstantiation               ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(gateInstantiation);

    RefTVec_RefCDOmBase gateInstantiationVec = gateInstantiation->getChildrenAsBase();
    if(gateInstantiationVec.get()){
      //std::cout << "Number of children is " << gateInstantiationVec->size() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = gateInstantiationVec->begin(); iter < gateInstantiationVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(gateInstantiation);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(gateInstantiation);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmPulseControl                         & pulseControl                    ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(pulseControl);

    RefTVec_RefCDOmBase pulseControlVec = pulseControl->getChildrenAsBase();
    if(pulseControlVec.get()){
      //std::cout << "Number of children is " << pulseControlVec->size() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = pulseControlVec->begin(); iter < pulseControlVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(pulseControl);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(pulseControl);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmAttrList                           & attrList                         ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(attrList);

    RefTVec_RefCDOmBase attrListVec = attrList->getChildrenAsBase();
    if(attrListVec.get()){
      //std::cout << "Number of children is " << pulseControlVec->size() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = attrListVec->begin(); iter < attrListVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(attrList);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(attrList);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmAttrListCollection                           & attrListCollection                         ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

  if((*this.*isNodeVisitEnabled)()) {
    if((*this.*isBeforeTraversalEnabled)())
      beforeTraversal(attrListCollection);

    RefTVec_RefCDOmBase attrListCollectionVec = attrListCollection->getChildrenAsBase();
    if(attrListCollectionVec.get()){
      //std::cout << "Number of children is " << pulseControlVec->size() << std::endl;
      for(TVec_RefCDOmBase_const_iter iter = attrListCollectionVec->begin(); iter < attrListCollectionVec->end(); iter++){
        //std::cout << "Type is " << (*iter)->getType() << std::endl;
        (*iter)->acceptVisitor(*this);
        if((*this.*isInTraversalEnabled)()) {
          inTraversal(attrListCollection);
        }
      }
    }

    if((*this.*isAfterTraversalEnabled)())
      afterTraversal(attrListCollection);
  }
}

void CVisitorTraversal::visit(const NSCdom::RefCDOmDefine                               & define                            ){
  __tbool isNodeVisitEnabled        = &CVisitorTraversal::isObjTraversalEnabled;
  __tbool isBeforeTraversalEnabled  = &CVisitorTraversal::isObjBeforeTraversalEnabled;
  __tbool isInTraversalEnabled      = &CVisitorTraversal::isObjInTraversalEnabled;
  __tbool isAfterTraversalEnabled   = &CVisitorTraversal::isObjAfterTraversalEnabled;

   if((*this.*isNodeVisitEnabled)()) {
     if((*this.*isBeforeTraversalEnabled)())
       beforeTraversal(define);
  
     RefTVec_RefCDOmBase defineVec = define->getChildrenAsBase();
     if(defineVec.get()){
       for(TVec_RefCDOmBase_const_iter iter = defineVec->begin(); iter < defineVec->end(); ++iter){
         (*iter)->acceptVisitor(*this);
         if((*this.*isInTraversalEnabled)()) {
           inTraversal(define);
         }
       }
     }
  
     if((*this.*isAfterTraversalEnabled)())
       afterTraversal(define);
     }
  }

} // end namespace NSCdomVisitor
