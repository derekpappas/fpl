//---------------------------------------------------------------------
// Copyright (c) 2005, 2006 Fastpathlogic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of Fastpathlogic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1\)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

#include "CSLOM_Design_Checker.h"
#include <cmath>
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include "../support/ErrorAPI.h"
#include "../support/CommonSupport.h"

TBool checkerHasErrors = FALSE;

using namespace NSCSLOm;
using namespace std;

namespace NSCSLOmDesignChecker {

// ********************************************
// CSLOmIsaPrefixTree class
// ********************************************

CSLOmIsaPrefixTree::CSLOmIsaPrefixTree():
  m_weakRef(),
  m_parent(),
  m_leftChild(),
  m_rightChild()
{}

RefCSLOmIsaPrefixTree CSLOmIsaPrefixTree::build(){
  CSLOmIsaPrefixTree *prefTree;
  try{
    prefTree=new CSLOmIsaPrefixTree();
  }
  catch (std::exception& e){
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmIsaPrefixTree refPreTree=RefCSLOmIsaPrefixTree(prefTree);
  prefTree->m_weakRef=boost::weak_ptr<CSLOmIsaPrefixTree>(refPreTree);

  refPreTree->m_instrName=RefString(new std::string("root"));
  return refPreTree;
}

void CSLOmIsaPrefixTree::addChild(TBool dir, RefString name){
  CSLOmIsaPrefixTree *newPrefTree;
  try{
    newPrefTree=new CSLOmIsaPrefixTree();
  }
  catch (std::exception& e){
    ASSERT(FAIL,"new operator failed");
  }
  RefCSLOmIsaPrefixTree refPreTree=RefCSLOmIsaPrefixTree(newPrefTree);
  newPrefTree->m_weakRef=boost::weak_ptr<CSLOmIsaPrefixTree>(refPreTree);
  refPreTree->m_instrName=name;
  
  refPreTree->m_parent=m_weakRef;
  if(!dir){
    m_leftChild=refPreTree;
  }
  else{
    m_rightChild=refPreTree;
  }
}

TBool CSLOmIsaPrefixTree::isLeaf(){
  if(!m_leftChild.get() && !m_rightChild.get()){
    return TRUE;
  }
  return FALSE;
}

// ********************************************
// CSLOmDesignChecker class
// ********************************************

CSLOmDesignChecker::CSLOmDesignChecker():
  m_dutClockNames(RefTVec_RefString(new TVec_RefString())),
  m_dutNames(RefTVec_RefString(new TVec_RefString())),
  m_dutClockCount(RefTVec_TUInt(new TVec_TUInt())),
  m_assPorts(RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink())),
  m_assVectors(RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase())),
  m_connectedSignals(RefTMap_RefCSLOmSignal_ECSLOmPortDirection(new TMap_RefCSLOmSignal_ECSLOmPortDirection)),
  //isa
  m_isaFieldHierSizes(RefTVec_TInt(new TVec_TInt())),
  m_curInstrFields(RefTVec_RefCSLOmField(new TVec_RefCSLOmField())),
  m_prevIsaElement()
{
  m_currentEnumItemFieldPosition=MAX_INT;
  m_currentNormalFieldPosition=MAX_INT;
  m_currentPosition=0;
  m_isaElemHierAddedWidths=0;
  m_isaElemRootCount=0;
  m_vectorsInWholeDesignCount=0;
  m_testbenchesInWholeDesignCount=0;
  m_unitInstancesCount=0;
  m_stimCount=0;
  m_expectCount=0;
  m_memMapPagesCount=0;
  m_dutCount=0;
  m_prefixIsaInstrNo=0;
  m_rootFormatWidth=0;

  //assign stmt
  m_lhsConcatAssignAllObjects     =TRUE;
  m_lhsConcatAssignVisited        =FALSE;
  m_lhsAssignStmtConcat           =FALSE;
  m_insideAssignStmt              =FALSE;
  
  m_insideFormalToActual          =FALSE;
  m_insideTestbench               =FALSE;
  m_insideIfc                     =FALSE;
  m_insideIsaField                =FALSE;
  m_memoryMapPresent              =FALSE;
  m_insideIsaElemInstr            =FALSE;
  m_insideTestbench               =FALSE;
  m_isaElemWait                   =FALSE;
  m_insideIsaElement              =FALSE;
  m_prefixTreeHasAtleastOneInstr  =FALSE;
  m_multipleConcatsInStmtAssign   =FALSE;

  enableUnitInfoTraversal();           
  enableIsaJump();
  enableUnitInfoBeforeTraversal();     
  enableUnitInfoInTraversal();         
  enableUnitInfoAfterTraversal();      
  enableVisitDesignFields();
}

void  CSLOmDesignChecker::checkConcatForObjects(RefCSLOmExprConcat concat){
  
  RefTVec_RefCSLOmBase exprs=concat->getExprsAsBase();
  for(TVec_RefCSLOmBase::iterator i=exprs->begin(); i<exprs->end(); ++i){
    RefCSLOmExpr it=CSLOmExpr::cast(*i);
    if(it->isExprLink() && CSLOmExprLink::cast(it)->getValue().get() && CSLOmExprLink::cast(it)->getValue()->isConnectable()){
      RefCSLOmExprLink expr=CSLOmExprLink::cast(it);
      if(!expr->getValue()->isPort() && !expr->getValue()->isSignal()){
        m_lhsConcatAssignAllObjects=FALSE;
        return;
      }
    }
    else if(it->isConcat()){
      checkConcatForObjects(CSLOmExprConcat::cast(*i));
      if(!m_lhsConcatAssignAllObjects){
        return;
      }
    }
    else{
      m_lhsConcatAssignAllObjects=FALSE;
      return;
    }
  }
}

void CSLOmDesignChecker::formal2ActualConcatReplicationCheck(RefCSLOmExprLink formal, RefCSLOmExpr actual, RefCSLOmUnitDecl formalUnit, RefCSLOmUnitDecl actualUnit){
  RefCSLOmExprLink it1=formal;
  RefCSLOmExpr it2=actual;

  TUInt formalWidth=0;
  TUInt actualWidth=0;

  RefCSLOmScope scope=formalUnit->getAttachedScope();
  CSLOmScopeBlock::enterScope(scope);
  RefCSLOmBase formalBase=it1->doEval();
  CSLOmScopeBlock::exitScope();
  RefCSLOmScope scope2=actualUnit->getAttachedScope();


  // DEP FIX - create buildError functions and replace the multiple lines for each args, addErr function
  if(!formalBase.get()){
    args.push_back(*convertLink(formal));
    args.push_back(*CSLOmIdentifier::cast(formalUnit->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, formal->getLineNumber(),formal->getFileName());
    checkerHasErrors=TRUE;
    return;
  }
  
  //formalWidth=it1->getWidth();
  
  //formal can only be port
  if(formalBase.get()){
    if(formalBase->isPort()){
      RefTMap_RefCSLOmUnitInstance_RefCSLOmBase widthParams = CSLOmPortDecl::cast(formalBase)->getWidth()->doParamEval(formalBase);
      for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=widthParams->begin(); it!=widthParams->end(); it++) {
        if(!it->second->isNumber()){
          //add error
          return;
        }
        RefCSLOmNumber width=CSLOmNumber::cast(it->second);
        formalWidth=width->getValue(); 
      }
      //formalWidth=it1->getWidth();
    }
    else if(formalBase->isInterface()){
      args.push_back(*it1->getName());
      addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_IFC_CR, args, it1->getLineNumber(),it1->getFileName());
      checkerHasErrors=TRUE;                                             
    }
    else{
      //error
    }
  }
  
  CSLOmScopeBlock::enterScope(scope2);
  RefCSLOmBase actualBase=it2->doEval();
  RefTVec_RefCSLOmBase exprs;
  if(it2->isConcat()){
    exprs=CSLOmExprConcat::cast(it2)->getExprsAsBase();
  }
  else if(it2->isMultiConcat()){
    exprs=CSLOmExprMultiConcat::cast(it2)->getExprsAsBase();
  }
  
  TBool objConcatOk=TRUE;
  for(TVec_RefCSLOmBase::iterator i=exprs->begin(); i<exprs->end();i++){
    if((*i)->isExprLink()){
      RefCSLOmExprLink expr=CSLOmExprLink::cast(*i);
      expr->doEval();
      if(!expr->getValue().get()){
        args.push_back(*convertLink(expr));
        args.push_back(*CSLOmIdentifier::cast(actualUnit->getChild(ID))->getName());
        addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, actual->getLineNumber(),actual->getFileName());
        checkerHasErrors=TRUE;
        objConcatOk=FALSE;
      }
      else{
        RefCSLOmConnectable connObj=CSLOmConnectable::cast(expr->getValue());
        if(connObj->getParentUnit().get()!=actualUnit.get()) {
          args.push_back(*convertLink(expr));
          addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, actual->getLineNumber(),actual->getFileName());
          checkerHasErrors=TRUE;                                             
        }
      }
    }
  }
  if(!objConcatOk){
    return;
  }
  
  actualWidth=it2->getWidth();
  CSLOmScopeBlock::exitScope();
  //if(!actualBase.get()){
  //  if(it2->isExprLink()){
  //    args.push_back(*convertLink(CSLOmExprLink::cast(it2)));
  //  }
  //  else{
  //    args.push_back("RHS object");
  //  }
  //  
  //  args.push_back(*CSLOmIdentifier::cast(actualUnit->getChild(ID))->getName());
  //  addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, actual->getLineNumber(),actual->getFileName());
  //  checkerHasErrors=TRUE;                                             
  //}

  if(formalWidth==-1){
    addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONCAT_OBJ_NOT_EXIST, args, it1->getLineNumber(),it1->getFileName());
    checkerHasErrors=TRUE;                                             
  }
  if(actualWidth==-1){
    addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONCAT_OBJ_NOT_EXIST, args, it2->getLineNumber(),it2->getFileName());
    checkerHasErrors=TRUE;                                             
  }

  if(actualWidth!=formalWidth){
    args.push_back(*it1->getName());
    args.push_back(intToString(formalWidth));
    args.push_back(intToString(actualWidth));
    addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_PIFC_CR, args, it1->getLineNumber(),it1->getFileName());
    checkerHasErrors=TRUE;                                             
  } 
}  

void CSLOmDesignChecker::checkIfc2IfcOrSgf2a(NSCSLOm::RefCSLOmExprLink first, NSCSLOm::RefCSLOmExprLink second, NSCSLOm::RefCSLOmUnitDecl firstUnit, NSCSLOm::RefCSLOmUnitDecl secondUnit){

  RefCSLOmBase firstBase;
  RefCSLOmBase secondBase;
  if(m_insideAssignStmt){
    firstBase=first->doEval();
    secondBase=second->doEval();
  }
  else{
    RefCSLOmScope scope=firstUnit->getAttachedScope();
    CSLOmScopeBlock::enterScope(scope);
    firstBase=first->doEval();
    CSLOmScopeBlock::exitScope();
    RefCSLOmScope scope2=secondUnit->getAttachedScope();
    CSLOmScopeBlock::enterScope(scope2);
    secondBase=second->doEval();
    CSLOmScopeBlock::exitScope();
  }
  
  //for the moment it is checked in the order given by getAllPorts() method
  if(firstBase->isInterface()){
    RefCSLOmInterface firstIfc=CSLOmInterface::cast(firstBase);
    if(secondBase->isInterface()){
      RefCSLOmInterface secondIfc=CSLOmInterface::cast(secondBase);
      RefTVec_RefCSLOmPortDecl firstAllPorts=firstIfc->getAllPorts();
      RefTVec_RefCSLOmPortDecl secondAllPorts=secondIfc->getAllPorts();
      TBool sameChildrenCount=TRUE;
      if(firstAllPorts->size()!=secondAllPorts->size()){
        sameChildrenCount=FALSE;
        args.push_back(*CSLOmIdentifier::cast(firstIfc->getChild(ID))->getName());
        args.push_back(*CSLOmIdentifier::cast(secondIfc->getChild(ID))->getName());
        args.push_back(intToString(firstAllPorts->size()));
        args.push_back(intToString(secondAllPorts->size()));
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_ASS_IFC_IFC_CHILDREN, args, firstBase->getLineNumber(),firstBase->getFileName(),FALSE,TRUE);
      }
      if(sameChildrenCount){
        RefCSLOmExpr expr = RefCSLOmExpr();
        RefString pName=RefString(new std::string(""));
        RefString sName=RefString(new std::string(""));
        for(int i=0; i<firstAllPorts->size(); ++i){
          RefTMap_RefCSLOmUnitInstance_RefCSLOmBase fwidthParams=firstAllPorts->at(i)->getWidth()->doParamEval(firstAllPorts->at(i));
          expr=CSLOmExpr::cast(fwidthParams->find(RefCSLOmUnitInstance())->second);
          RefCSLOmNumber fwidthNumber=CSLOmNumber::cast(expr);
          RefTMap_RefCSLOmUnitInstance_RefCSLOmBase swidthParams=secondAllPorts->at(i)->getWidth()->doParamEval(firstAllPorts->at(i));
          expr=CSLOmExpr::cast(swidthParams->find(RefCSLOmUnitInstance())->second);
          RefCSLOmNumber swidthNumber=CSLOmNumber::cast(expr->doEval());
          if(fwidthNumber->getValue()!=swidthNumber->getValue()){
            args.push_back(*CSLOmIdentifier::cast(firstAllPorts->at(i)->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(secondAllPorts->at(i)->getChild(ID))->getName());
            args.push_back(intToString(fwidthNumber->getValue()));
            args.push_back(intToString(swidthNumber->getValue()));
            addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_DIFF_WIDTH, args, first->getLineNumber(),first->getFileName());
            checkerHasErrors=TRUE;
          }
          if(firstAllPorts->at(i)->getPortDirection()!=secondAllPorts->at(i)->getPortDirection()){
            args.push_back(*CSLOmIdentifier::cast(firstAllPorts->at(i)->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(secondAllPorts->at(i)->getChild(ID))->getName());
            addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_P_P_CONECTION_DIFF_DIR, args, first->getLineNumber(),first->getFileName());
            checkerHasErrors=TRUE;
          }
          pName=CSLOmIdentifier::cast(firstAllPorts->at(i)->getChild(ID))->getName();
          sName=CSLOmIdentifier::cast(secondAllPorts->at(i)->getChild(ID))->getName();
          if(pName->compare(*sName)){
            args.push_back(*CSLOmIdentifier::cast(firstIfc->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(secondIfc->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(firstAllPorts->at(i)->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(secondAllPorts->at(i)->getChild(ID))->getName());
            addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_IFC_SG_NAMES, args, first->getLineNumber(),first->getFileName(),FALSE,TRUE);
            //checkerHasErrors=TRUE;
          }
        }
      }
    }
    else if(secondBase->isSignalGroup()){
      RefCSLOmGroupSignal sg=CSLOmGroupSignal::cast(secondBase);
      RefTVec_RefCSLOmPortDecl allPorts=firstIfc->getAllPorts();
      RefTVec_RefCSLOmSignal allSigs=sg->getAllSignals();
      TBool sameChildrenCount=TRUE;
      if(allPorts->size()!=allSigs->size()){
        sameChildrenCount=FALSE;
        args.push_back(*CSLOmIdentifier::cast(firstIfc->getChild(ID))->getName());
        args.push_back(*CSLOmIdentifier::cast(sg->getChild(ID))->getName());
        args.push_back(intToString(allPorts->size()));
        args.push_back(intToString(allSigs->size()));
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_ASS_IFC_SG_CHILDREN, args, firstBase->getLineNumber(),firstBase->getFileName(),FALSE,TRUE);
      }
      if(sameChildrenCount){
        RefCSLOmExpr expr=RefCSLOmExpr();
        RefString pName=RefString(new std::string(""));
        RefString sName=RefString(new std::string(""));
        for(int i=0; i<allPorts->size(); ++i){
          RefTMap_RefCSLOmUnitInstance_RefCSLOmBase firstWidthsParams=allPorts->at(i)->getWidth()->doParamEval(allPorts->at(i));
          RefTMap_RefCSLOmUnitInstance_RefCSLOmBase secondWidthsParams=allSigs->at(i)->getWidth()->doParamEval(allPorts->at(i));
          RefCSLOmNumber pNumber=CSLOmNumber::cast(firstWidthsParams->begin()->second);
          RefCSLOmNumber sNumber=CSLOmNumber::cast(secondWidthsParams->begin()->second);

          if(pNumber->getValue()!=sNumber->getValue()){
            args.push_back(*CSLOmIdentifier::cast(allPorts->at(i)->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(allSigs->at(i)->getChild(ID))->getName());
            args.push_back(intToString(pNumber->getValue()));
            args.push_back(intToString(sNumber->getValue()));
            addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_DIFF_WIDTH, args, first->getLineNumber(),first->getFileName());
            checkerHasErrors=TRUE;
          }
          pName=CSLOmIdentifier::cast(allPorts->at(i)->getChild(ID))->getName();
          sName=CSLOmIdentifier::cast(allSigs->at(i)->getChild(ID))->getName();
          if(pName->compare(*sName)){
            args.push_back(*CSLOmIdentifier::cast(firstIfc->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(sg->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(allPorts->at(i)->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(allSigs->at(i)->getChild(ID))->getName());
            addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_IFC_SG_NAMES, args, first->getLineNumber(),first->getFileName(),FALSE,TRUE);
            //checkerHasErrors=TRUE;
          }
        }
      }
    }
    else {//second base is not ifc nor sg... shouldn't happen
      ASSERT(FAIL,"this shouldn't happen");
    }
  }
  else if(firstBase->isSignalGroup()){
    RefCSLOmGroupSignal sg=CSLOmGroupSignal::cast(firstBase);
    if(secondBase->isInterface()){
      RefCSLOmInterface ifc=CSLOmInterface::cast(secondBase);
      RefTVec_RefCSLOmPortDecl allPorts=ifc->getAllPorts();
      RefTVec_RefCSLOmSignal allSigs=sg->getAllSignals();
      TBool sameChildrenCount=TRUE;
      if(allPorts->size()!=allSigs->size()){
        sameChildrenCount=FALSE;
        args.push_back(*CSLOmIdentifier::cast(ifc->getChild(ID))->getName());
        args.push_back(*CSLOmIdentifier::cast(sg->getChild(ID))->getName());
        args.push_back(intToString(allPorts->size()));
        args.push_back(intToString(allSigs->size()));
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_ASS_IFC_SG_CHILDREN, args, firstBase->getLineNumber(),firstBase->getFileName(),FALSE,TRUE);
      }
      if(sameChildrenCount){
        RefCSLOmExpr expr=RefCSLOmExpr();
        for(int i=0; i<allPorts->size(); ++i){
          expr=allPorts->at(i)->getWidth();
          RefCSLOmNumber pNumber=CSLOmNumber::cast(expr->doEval());
          expr=allSigs->at(i)->getWidth();
          RefCSLOmNumber sNumber=CSLOmNumber::cast(expr->doEval());
          if(pNumber->getValue()!=sNumber->getValue()){
            args.push_back(*CSLOmIdentifier::cast(allPorts->at(i)->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(allSigs->at(i)->getChild(ID))->getName());
            args.push_back(intToString(pNumber->getValue()));
            args.push_back(intToString(sNumber->getValue()));
            addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_DIFF_WIDTH, args, first->getLineNumber(),first->getFileName());
            checkerHasErrors=TRUE;
          }
        }
      }
    }
    else if(secondBase->isSignalGroup()){ //first and second are both sg's => error
      ASSERT(FAIL, "this shouldn't happen");
    }
  }
  else{ //first is neither ifc nor sg
    ASSERT(FAIL, "this shouldn't happen");
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmDesign      & design      ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ){
  
  //part select
  if((exprLink->hasBitRange() && m_insideAssignStmt) || 
     (exprLink->hasBitRange() && m_insideFormalToActual)){
    exprLink->doEval();
    if(!exprLink->getValue().get()){
      args.push_back(*exprLink->getName());
      addErr(NSWarningErr::CSE_CSC_SIG_ASSIGN_PART_SELECT_NOT_EVAL, args, exprLink->getLineNumber(),exprLink->getFileName());
      checkerHasErrors=TRUE;
      return;
    }

    RefCSLOmBaseRange objectBr;
    if(exprLink->getValue()->isPort()){
      objectBr=CSLOmPortDecl::cast(exprLink->getValue())->getBitRange();
    }
    else if(exprLink->getValue()->isSignal()){
      objectBr=CSLOmSignal::cast(exprLink->getValue())->getBitRange();
    }
    else{
      return;
    }

    RefCSLOmSimpleBitRange obr;
    if(objectBr->isSimpleBitRange()){
      obr=CSLOmSimpleBitRange::cast(objectBr);
    }
    else{
      //need to implement for multiple dim bit ranges
      return;
    }

    RefCSLOmSimpleBitRange br = exprLink->getBitRange();
    RefCSLOmBase upbase=br->getUpper();
    RefCSLOmBase lowbase=br->getLower();
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase upperBRParams = br->getUpper()->doParamEval(exprLink->getValue());
    RefCSLOmBase elUpper=upperBRParams->find(RefCSLOmUnitInstance())->second;
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase lowerBRParams = br->getLower()->doParamEval(exprLink->getValue());
    RefCSLOmBase elLower=lowerBRParams->find(RefCSLOmUnitInstance())->second;
    if(CSLOmNumber::cast(elUpper)->getValue()<CSLOmNumber::cast(elLower)->getValue()){
      args.push_back(*m_lastPSvisited);
      args.push_back(intToString(CSLOmNumber::cast(elUpper)->getValue()));
      args.push_back(intToString(CSLOmNumber::cast(elLower)->getValue()));
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UPPER_LOWER, args, br->getLineNumber(),br->getFileName());
      br->swapUpLow();
    }

    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase upperParams = obr->getUpper()->doParamEval(obr);
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase lowerParams = obr->getLower()->doParamEval(obr);
    
    //ASSERT(elUpper->isNumber(),"not number");
    //ASSERT(elLower->isNumber(),"not number");
    RefCSLOmNumber elUpperNo;
    RefCSLOmNumber elLowerNo;
    
    if(elUpper->isNumber()){
      elUpperNo=CSLOmNumber::cast(elUpper);
    }
    else if(elUpper->isParameter()){
      RefCSLOmParameter param=CSLOmParameter::cast(elUpper);
      while(param->getValueAsBase()->isExprLink()){
        param=CSLOmParameter::cast(CSLOmExprLink::cast(param->getValueAsBase())->doEval());
      }
      RefCSLOmBase paramBase=param->getValueAsBase();
      if(paramBase->isExpr()){
        RefCSLOmExpr paramExpr=CSLOmExpr::cast(paramBase);
        if(paramExpr->isOp()){
          elUpperNo=CSLOmNumber::cast(paramExpr->doEval(TRUE));
        }
        else if(paramExpr->isNumber()){
          elUpperNo=CSLOmNumber::cast(param->getValue());
        }
        else{
          ASSERT(FAIL,"cannot eval");
        }
      }
    }
    else{
      ASSERT(FAIL,"cannot eval");
    }
    
    if(elLower->isNumber()){
      elLowerNo=CSLOmNumber::cast(elLower);
    }
    else if(elLower->isParameter()){
      RefCSLOmParameter param=CSLOmParameter::cast(elLower);
      while(param->getValueAsBase()->isExprLink()){
        param=CSLOmParameter::cast(CSLOmExprLink::cast(param->getValueAsBase())->doEval());
      }
      RefCSLOmBase paramBase=param->getValueAsBase();
      if(paramBase->isExpr()){
        RefCSLOmExpr paramExpr=CSLOmExpr::cast(paramBase);
        if(paramExpr->isOp()){
          elLowerNo=CSLOmNumber::cast(paramExpr->doEval(TRUE));
        }
        else if(paramExpr->isNumber()){
          elLowerNo=CSLOmNumber::cast(param->getValue());
        }
        else{
          ASSERT(FAIL,"cannot eval");
        }
      }
    }
    else{
      ASSERT(FAIL,"cannot eval");
    }

    for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=upperParams->begin(); it!=upperParams->end(); it++) {
      ASSERT(it->second->isNumber(),"not number");
      
      if(elUpperNo->getValue() > CSLOmNumber::cast(it->second)->getValue()){
        args.push_back(*exprLink->getName());
        if(it->first.get()){
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
          args.push_back(intToString(elUpperNo->getValue()));
          args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_UPPER_INST, args, exprLink->getLineNumber(),exprLink->getFileName());
          checkerHasErrors=TRUE;
        }
        else{
          args.push_back(intToString(elUpperNo->getValue()));
          args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_UPPER_NOT_INST, args, exprLink->getLineNumber(),exprLink->getFileName());
          checkerHasErrors=TRUE;
        }
      }
    }

    for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=lowerParams->begin(); it!=lowerParams->end(); it++) {
      ASSERT(it->second->isNumber(),"not number");

      if(elLowerNo->getValue() < CSLOmNumber::cast(it->second)->getValue()){
        args.push_back(*exprLink->getName());
        if(it->first.get()){
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
          args.push_back(intToString(elLowerNo->getValue()));
          args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_LOWER_INST, args, exprLink->getLineNumber(),exprLink->getFileName());
          checkerHasErrors=TRUE;
        }
        else{
          args.push_back(intToString(elLowerNo->getValue()));
          args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_LOWER_NOT_INST, args, exprLink->getLineNumber(),exprLink->getFileName());
          checkerHasErrors=TRUE;
        }
      }
    }
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ){
  m_unitInstancesCount=0;

  //predefined but not declared
  if(!unitDecl->isDefined()){
    args.push_back(*CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName());
    addErr(NSWarningErr::CSE_CSA_ASE_DESIGN_NOT_DECLARED, args,unitDecl->getLineNumber(),unitDecl->getFileName());
    checkerHasErrors=TRUE;
  }

  /////////////////////////////
  //if we have a unit instanciated inside of a testbench... that means it has to have exactly 1 stimulus and 1 expected vectors.
  /////////////////////////////
  if(unitDecl->isDUT()){ //isDUT() should be self explanatory. It means that a unit it is instanciated inside of a testbench. 
    TInt stimNo=0;       
    TInt expectNo=0;
    RefTVec_WeakCSLOmVerifCompInfo dutVects = unitDecl->getVerifComps();
    m_dutCount++;
    
    //counting stimulus and/or expected vectors associated to that dut
    if(dutVects->size()>0){
      for(TUInt i=0; i<dutVects->size(); ++i){
        RefCSLOmVerifCompInfo tempVc = dutVects->at(i).lock();
        if(CSLOmVectorInfo::cast(tempVc)->getStimulusElseExpected()){
          stimNo++;
        }
        else{
          expectNo++;
        }
      }
    }

    //checking if a dut has atleast a stimulus and an expected vector
    if(stimNo==0){
      args.push_back(*(CSLOmIdentifier::cast(unitDecl->getChild(ID)))->getName());
      addErr(NSWarningErr::DEE_CSA_VEC_DESIGN_NO_STIM_VECT, args, 0,unitDecl->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
    if(expectNo==0){
      args.push_back(*(CSLOmIdentifier::cast(unitDecl->getChild(ID)))->getName());
      addErr(NSWarningErr::DEE_CSA_VEC_DESIGN_NO_EXPECT_VECT, args, 0,unitDecl->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }

    //CLOCK: needs to have atleast an input port with clock attribute
    if(!(unitDecl->isTestBench()) && !(unitDecl->isVerifComp()) && !(unitDecl->isRegister())
       && !(unitDecl->isMemory()) && !(unitDecl->isFifo()) && !(unitDecl->isRegisterFile())){
      
      TBool clockForThisUnit=FALSE;
      TInt clockCount=0;
      RefTVec_RefCSLOmPortDecl ports=unitDecl->getPortListFull();
      
      if(ports.get()){
        for(TUInt i=0;i<ports->size();++i){
          if(ports->at(i)->getAttr()==ATTR_CLK && ports->at(i)->getPortDirection()==INPUT){
            clockForThisUnit=TRUE;
            m_dutClockNames->push_back(CSLOmIdentifier::cast(ports->at(i)->getChild(ID))->getName());
            clockCount++;
          }
        }
        //this is part of the same name check for the link between testbench and dut's
        m_dutNames->push_back(CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName());
        m_dutClockCount->push_back(clockCount);
      }
      //throwing the error if needed
      if(!clockForThisUnit){
        args.push_back(*(CSLOmIdentifier::cast(unitDecl->getChild(ID)))->getName());
        addErr(NSWarningErr::DEE_CSA_MOD_DESIGN_NO_UNIT_CLOCK, args, 0,unitDecl->getFileName(),FALSE,TRUE);
        checkerHasErrors=TRUE;
      }
    }
  }  
}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ){
  m_lastPSvisited=CSLOmIdentifier::cast(signal->getChild(ID))->getName();

  //signal that has type clock must have width == 1
  if(signal->getSignalAttr()==NSCSLOm::ATTR_CLK){
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase widthParams = signal->getWidth()->doParamEval(signal);
    for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=widthParams->begin(); it!=widthParams->end(); it++) {
      if(!it->second->isNumber()){
        //add error
        return;
      }
      RefCSLOmNumber width=CSLOmNumber::cast(it->second);
      if(width->getValue()!=1){
        args.push_back(*CSLOmIdentifier::cast(signal->getChild(ID))->getName());
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_WIDTH_ONE, args, signal->getLineNumber(), signal->getFileName());
        checkerHasErrors=TRUE;
      }
    }
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ){
  m_unitInstancesCount++;

  //formal to actualmapping
  m_insideFormalToActual=TRUE;

  RefCSLOmBase parentBase = unitInst->getParent()->getParent();
  RefCSLOmUnitDecl parent=CSLOmUnitDecl::cast(parentBase);
  TBool hasError=FALSE;
  RefTMap_RefCSLOmExprLink_RefCSLOmExpr cMap = unitInst->getConnectionMap();
  for(TMap_RefCSLOmExprLink_RefCSLOmExpr::iterator it=cMap->begin(); it!=cMap->end(); it++) {
    if (it->second->isExprLink()) {
      hasError=FALSE;
      RefCSLOmExprLink it1= it->first;
      RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
      if(!it->first->isInUnitScope(unitInst->getUnitDecl())){
        args.push_back(*convertLink(it->first));
        args.push_back(*CSLOmIdentifier::cast(unitInst->getUnitDecl()->getChild(ID))->getName());
        addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, it->first->getLineNumber(),it->first->getFileName());
        checkerHasErrors=TRUE;                                             
        hasError=TRUE;
      }
      if (!it2->isInUnitScope(parent)) {
        args.push_back(*convertLink(it2));
        args.push_back(*CSLOmIdentifier::cast(parent->getChild(ID))->getName());
        addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, it->first->getLineNumber(),it->first->getFileName());
        checkerHasErrors=TRUE;                                             
        hasError=TRUE;
      }
      else {
        RefString name=it2->getHidName(0);
        RefCSLOmScope scope=parent->getAttachedScope();
        RefCSLOmIdentifier thatId=scope->lookupLocal(name);
        if(thatId.get()) {
          RefCSLOmBase parentId=thatId->getParent();
          if(parentId->isInstance()){
            args.push_back(*it2->getName());
            addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_RHS_INSTANCE, args, it->second->getLineNumber(),it->second->getFileName());
            checkerHasErrors=TRUE;                                             
            hasError=TRUE;
          }
        }
      }
      if(!hasError){
        if(it1->hasBitRange()){
          RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
          args.push_back(*it1->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_FORMAL, args, it1->getLineNumber(),it1->getFileName());
          checkerHasErrors=TRUE;                                             
        }
        if(!it1->getValue()->isConnectable() || !it2->getValue()->isConnectable()){
          args.push_back("instantiation");
          addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, it1->getLineNumber(),it1->getFileName());
          checkerHasErrors=TRUE;                                             
        }
        else if(!it1->getValue()->isPort() && !it1->getValue()->isInterface()){
          RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
          args.push_back(*it1->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_FORMAL, args, it1->getLineNumber(),it1->getFileName());
          checkerHasErrors=TRUE;                                             
        }
        else if((it1->getValue()->isPort()) && 
                ((it2->getValue()->isInterface()) || it2->getValue()->isSignalGroup())){
          RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
          args.push_back(*it1->getName());
          args.push_back(*it2->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_PORT_IFCSG, args, it1->getLineNumber(),it1->getFileName());
          checkerHasErrors=TRUE;                                
        }
        else if(it1->getValue()->isInterface() && 
                it2->getValue()->isPort()){
          RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
          args.push_back(*it1->getName());
          args.push_back(*it2->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_IFC_PORT, args, it1->getLineNumber(),it1->getFileName());
          checkerHasErrors=TRUE;                                
        }
        else if(it1->getValue()->isInterface() && it2->getValue()->isSignal()){
          RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
          args.push_back(*it1->getName());
          args.push_back(*it2->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_IFC_SIG, args, it1->getLineNumber(),it1->getFileName());
          checkerHasErrors=TRUE;
        }
        else if(it1->getValue()->isInterface() && it2->getValue()->isInterface() ||
                it1->getValue()->isInterface() && it2->getValue()->isSignalGroup()){
          checkIfc2IfcOrSgf2a(CSLOmExprLink::cast(it1),CSLOmExprLink::cast(it2),unitInst->getUnitDecl(), CSLOmUnitDecl::cast(unitInst->getParent()->getParent()));
        }
        else if(it1->getValue()->isSignalGroup() && it2->getValue()->isSignalGroup()){
          args.push_back("formal to actual: signal group with signal group");
          addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, it1->getLineNumber(), it1->getFileName());
          checkerHasErrors=TRUE;                                             
        }
        else if(it2->getValue()->isPort() && it1->getValue()->isPort()){
          RefCSLOmPortDecl firstPort=CSLOmPortDecl::cast(it1->getValue());
          RefCSLOmPortDecl secondPort=CSLOmPortDecl::cast(it2->getValue());
          RefString name1=CSLOmIdentifier::cast(firstPort->getChild(ID))->getName();
          RefString name2=CSLOmIdentifier::cast(secondPort->getChild(ID))->getName();
          if(firstPort->getPortDirection()==INOUT || secondPort->getPortDirection()==INOUT){
            //do nothing
          }
          else if(firstPort->getPortDirection()!=secondPort->getPortDirection()){
            args.push_back(*it2->getName());
            args.push_back(*it1->getName());
            addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_P_P_CONECTION_DIFF_DIR, args, it1->getLineNumber(),it2->getFileName());
            checkerHasErrors=TRUE;
            hasError=TRUE;
          }
        }
        if((it1->getValue()->isPort() && it2->getValue()->isSignal()) || 
           (it1->getValue()->isPort() && it2->getValue()->isPort()) ){
          RefCSLOmNumber firstWidth=RefCSLOmNumber();
          RefCSLOmNumber secondWidth=RefCSLOmNumber();
          RefCSLOmExpr expr=RefCSLOmExpr();
          RefCSLOmPortDecl firstPort=CSLOmPortDecl::cast(it1->getValue());
          RefTMap_RefCSLOmUnitInstance_RefCSLOmBase firstWidthParams = firstPort->getWidth()->doParamEval(firstPort);
          firstWidth=CSLOmExpr::getValueForInstance(unitInst,firstWidthParams);
            
          if(it2->getValue()->isPort()) {
            RefCSLOmPortDecl secondPort=CSLOmPortDecl::cast(it2->getValue());
            RefCSLOmExpr widthExpr=secondPort->getWidth();
            if(it2->hasBitRange()){
              widthExpr=it2->getBitRange()->getWidth();
            }
            //upper lower
            if(it2->hasBitRange()){
              RefCSLOmSimpleBitRange br=CSLOmSimpleBitRange::cast(it2->getBitRange());
              RefCSLOmBase upBase = br->getUpper()->doEval(TRUE);
              RefCSLOmBase lowBase = br->getLower()->doEval(TRUE);
              RefCSLOmNumber objUp = CSLOmNumber::cast(upBase);
              RefCSLOmNumber objLow = CSLOmNumber::cast(upBase);

              RefTMap_RefCSLOmUnitInstance_RefCSLOmBase secondPortUpper = CSLOmSimpleBitRange::cast(secondPort->getBitRange())->getUpper()->doParamEval(secondPort);
              RefTMap_RefCSLOmUnitInstance_RefCSLOmBase secondPortLower = CSLOmSimpleBitRange::cast(secondPort->getBitRange())->getLower()->doParamEval(secondPort);
              for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator wit=secondPortUpper->begin(); wit!=secondPortUpper->end(); wit++){
                RefCSLOmNumber value=CSLOmNumber::cast(wit->second);
                if(objUp->getValue() > value->getValue()){
                  args.push_back(*it2->getName());
                  args.push_back(intToString(objUp->getValue()));
                  args.push_back(intToString(value->getValue()));
                  addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_UPPER_NOT_INST, args, it2->getLineNumber(),it2->getFileName());
                  checkerHasErrors=TRUE;
                }
              }
              for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator wit=secondPortLower->begin(); wit!=secondPortLower->end(); wit++){
                RefCSLOmNumber value=CSLOmNumber::cast(wit->second);
                if(objLow->getValue() < value->getValue()){
                  args.push_back(*it2->getName());
                  args.push_back(intToString(objLow->getValue()));
                  args.push_back(intToString(value->getValue()));
                  addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_LOWER_NOT_INST, args, it2->getLineNumber(),it2->getFileName());
                  checkerHasErrors=TRUE;
                }
              }
            }
            //width
            RefTMap_RefCSLOmUnitInstance_RefCSLOmBase secondWidthParams = widthExpr->doParamEval(secondPort);
            for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator wit=secondWidthParams->begin(); wit!=secondWidthParams->end(); wit++){
              if(wit->second.get() && wit->second->isNumber()){
                secondWidth=CSLOmNumber::cast(wit->second);
              }
              if(firstWidth->getValue()!=secondWidth->getValue()){
                if(!wit->first.get()){
                  args.push_back(*it2->getName());
                  args.push_back(*it1->getName());
                  args.push_back(intToString(it1->getValue()->getLineNumber()));
                  args.push_back(intToString(secondWidth->getValue()));
                  args.push_back(intToString(firstWidth->getValue()));
                  addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_DIFF_WIDTH_DEF, args, it1->getLineNumber(),it2->getFileName());
                  checkerHasErrors=TRUE;
                  hasError=TRUE;
                }
                else{
                  args.push_back(*it1->getName());
                  args.push_back(*it2->getName());
                  args.push_back(*CSLOmIdentifier::cast(wit->first->getChild(ID))->getName());
                  args.push_back(intToString(wit->first->getLineNumber()));
                  args.push_back(intToString(firstWidth->getValue()));
                  args.push_back(intToString(secondWidth->getValue()));
                  addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_DIFF_WIDTH_INST, args, it1->getLineNumber(),it2->getFileName());
                  checkerHasErrors=TRUE;
                  hasError=TRUE;
                }
              }  
            }
          }
          else {
            RefCSLOmSignal secondPort=CSLOmSignal::cast(it2->getValue());
            //for m_connectedSignals
            ECSLOmPortDirection pdir=CSLOmPortDecl::cast(it1->getValue())->getPortDirection();
            if(m_connectedSignals->find(secondPort)==m_connectedSignals->end()){
              m_connectedSignals->insert(std::make_pair(secondPort,pdir));
            }
            else {//it found one... 
              //the signal needs to be wand or wor
              if(m_connectedSignals->find(secondPort)->second==pdir){
                if(pdir==INPUT){
                  //do nothing
                }
                else if(secondPort->getSignalType()!=SIGNAL_WAND || secondPort->getSignalType()!=SIGNAL_WOR){
                  //RefCSLOmPortDecl lhsPort=CSLOmPortDecl::cast(it1->getValue());
                  //args.push_back(*CSLOmIdentifier::cast(secondPort->getChild(ID))->getName());
                  //addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_SIGNAL_F2A_MULT_CONN_NOT_WAND, args, it1->getLineNumber(),it2->getFileName());
                  //args.push_back(*CSLOmIdentifier::cast(secondPort->getChild(ID))->getName());
                  //args.push_back(*CSLOmIdentifier::cast(lhsPort->getChild(ID))->getName());
                  //addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_SIGNAL_F2A_MULT_CONN_SD, args, it1->getLineNumber(),it2->getFileName());
                  //checkerHasErrors=TRUE;
                }
              }
            }
            //upper lower
            if(it2->hasBitRange()){
              RefCSLOmSimpleBitRange br=CSLOmSimpleBitRange::cast(it2->getBitRange());
              RefTMap_RefCSLOmUnitInstance_RefCSLOmBase upBase = br->getUpper()->doParamEval(it2->getValue());
              RefTMap_RefCSLOmUnitInstance_RefCSLOmBase lowBase = br->getLower()->doParamEval(it2->getValue());
              RefCSLOmNumber objUp = CSLOmNumber::cast(upBase->begin()->second);
              RefCSLOmNumber objLow = CSLOmNumber::cast(lowBase->begin()->second);

              RefTMap_RefCSLOmUnitInstance_RefCSLOmBase secondPortUpper = CSLOmSimpleBitRange::cast(secondPort->getBitRange())->getUpper()->doParamEval(secondPort);
              RefTMap_RefCSLOmUnitInstance_RefCSLOmBase secondPortLower = CSLOmSimpleBitRange::cast(secondPort->getBitRange())->getLower()->doParamEval(secondPort);
              for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator wit=secondPortUpper->begin(); wit!=secondPortUpper->end(); wit++){
                RefCSLOmNumber value=CSLOmNumber::cast(wit->second);
                if(objUp->getValue() > value->getValue()){
                  args.push_back(*it2->getName());
                  args.push_back(intToString(objUp->getValue()));
                  args.push_back(intToString(value->getValue()));
                  addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_UPPER_NOT_INST, args, it2->getLineNumber(),it2->getFileName());
                  checkerHasErrors=TRUE;
                }
              }
              for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator wit=secondPortLower->begin(); wit!=secondPortLower->end(); wit++){
                RefCSLOmNumber value=CSLOmNumber::cast(wit->second);
                if(objLow->getValue() < value->getValue()){
                  args.push_back(*it2->getName());
                  args.push_back(intToString(objLow->getValue()));
                  args.push_back(intToString(value->getValue()));
                  addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_LOWER_NOT_INST, args, it2->getLineNumber(),it2->getFileName());
                  checkerHasErrors=TRUE;
                }
              }
            }
            
            //widths
            RefTMap_RefCSLOmUnitInstance_RefCSLOmBase secondWidthParams = secondPort->getWidth()->doParamEval(secondPort);
            for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator wit=secondWidthParams->begin(); wit!=secondWidthParams->end(); wit++){
              if(wit->second.get() && wit->second->isNumber()){
                secondWidth=CSLOmNumber::cast(wit->second);
                if(it2->hasBitRange()){
                  RefCSLOmSimpleBitRange br=CSLOmSimpleBitRange::cast(it2->getBitRange());
                  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase widths = br->getWidth()->doParamEval(it2->doEval());
                  secondWidth=CSLOmNumber::cast(widths->find(RefCSLOmUnitInstance())->second);
                }
              }
              if(firstWidth->getValue()!=secondWidth->getValue()){
                if(!wit->first.get()){
                  args.push_back(*it2->getName());
                  args.push_back(*it1->getName());
                  args.push_back(intToString(it1->getValue()->getLineNumber()));
                  args.push_back(intToString(secondWidth->getValue()));
                  args.push_back(intToString(firstWidth->getValue()));
                  addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_DIFF_WIDTH_DEF, args, it1->getLineNumber(),it2->getFileName());
                  checkerHasErrors=TRUE;
                  hasError=TRUE;
                }
                else{
                  args.push_back(*it1->getName());
                  args.push_back(*it2->getName());
                  args.push_back(*CSLOmIdentifier::cast(wit->first->getChild(ID))->getName());
                  args.push_back(intToString(wit->first->getLineNumber()));
                  args.push_back(intToString(firstWidth->getValue()));
                  args.push_back(intToString(secondWidth->getValue()));
                  addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_DIFF_WIDTH_INST, args, it1->getLineNumber(),it2->getFileName());
                  checkerHasErrors=TRUE;
                  hasError=TRUE;
                }
              }  
            }
          }
        }
      }
    }
    else if(it->second->isExpr()){
      //we still need to eval the lhs operand
      RefCSLOmExprLink it1=it->first;
      RefCSLOmExpr it2=it->second;

      RefString name=it1->getHidName(0);
      RefCSLOmScope scope=CSLOmUnitInstantiation::cast(unitInst->getParent())->getUnitDecl()->getAttachedScope();
      CSLOmScopeBlock::enterScope(scope);
      RefCSLOmBase objBase=it1->doEval();
      CSLOmScopeBlock::exitScope();

      if(it2->isConcat() || it2->isMultiConcat()){
        formal2ActualConcatReplicationCheck(it1,it2,unitInst->getUnitDecl(), CSLOmUnitDecl::cast(unitInst->getParent()->getParent()));
      }
      else if(it2->isOp()){
        RefCSLOmScope scope2=unitInst->getParentScope();
        CSLOmScopeBlock::enterScope(scope2);
        it2->doEval();
        it2->acceptVisitor(*this);
        CSLOmScopeBlock::exitScope();
        if(!it1->getValue()->isPort() && !it1->getValue()->isSignal()){
          args.push_back(*it1->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_F2A_NOTPS_OP, args, unitInst->getLineNumber(),unitInst->getFileName());
          checkerHasErrors=TRUE;
        }
        if(it2->getWidth()!=it1->getWidth()){
          args.push_back(intToString(it1->getWidth()));
          args.push_back(intToString(it2->getWidth()));
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_DIFF_WIDTH, args, unitInst->getLineNumber(),unitInst->getFileName());
          checkerHasErrors=TRUE;
        }        
      }
      else if(it2->isNumber()){
        TInt actualNum=CSLOmNumber::cast(it2)->getWidth();
        if(actualNum>it1->getWidth()){
          args.push_back(intToString(it1->getWidth()));
          args.push_back(intToString(it2->getWidth()));
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_DIFF_WIDTH, args, unitInst->getLineNumber(),unitInst->getFileName());
          checkerHasErrors=TRUE;
        }
      }
      else{
        //change error
        args.push_back("formal to actual parameter");
        args.push_back("not concat or multi concat");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, it->first->getLineNumber(),it->first->getFileName());
        checkerHasErrors=TRUE;
        hasError=TRUE;
      }
    }
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ){
  //part select checks are being done at expr link visit
  if(simpleBitRange->getParent()->isExprLink()){
    return;
  }

  //getting the lower and upper params for repsective instances
  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase upperParams = simpleBitRange->getUpper()->doParamEval(simpleBitRange);
  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase lowerParams = simpleBitRange->getLower()->doParamEval(simpleBitRange);

  if(!upperParams.get()){
    //err design_bitrange_up_not_eval
    args.push_back(*m_lastPSvisited);
    addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_NOT_EVAL, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
    checkerHasErrors=TRUE;
    return;
  }
  if(!lowerParams.get()){
    args.push_back(*m_lastPSvisited);
    addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_NOT_EVAL, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
    checkerHasErrors=TRUE; 
   //err design_bitrange_up_not_eval
    return;
  }

  RefCSLOmNumber upper=RefCSLOmNumber();
  RefCSLOmNumber lower=RefCSLOmNumber();
  TBool hasError=FALSE;
  
  if((upperParams->size()==lowerParams->size()) && (upperParams->size()==1)){
    if(!upperParams->begin()->second->isNumber()){
      //error with design_bitrange_up_low_number
      args.push_back(*m_lastPSvisited);
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_NUMBER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
      checkerHasErrors=TRUE;
      return;
    }
    if(!lowerParams->begin()->second->isNumber()){
      args.push_back(*m_lastPSvisited);
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_NUMBER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
      checkerHasErrors=TRUE;
      //error with design_bitrange_up_low_number
      return;
    }
    upper=CSLOmNumber::cast(upperParams->begin()->second);
    lower=CSLOmNumber::cast(lowerParams->begin()->second);
    
    if(lower->getValue() > upper->getValue() && !simpleBitRange->hasSetWidth()){
      //throw warning
      //design_bitrange_upper_lower
      args.push_back(*m_lastPSvisited);
      args.push_back(intToString(upper->getValue()));
      args.push_back(intToString(lower->getValue()));
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UPPER_LOWER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
      //checkerHasErrors=TRUE;
      if(!upperParams->begin()->first.get() && !lowerParams->begin()->first.get() && !simpleBitRange->hasSetWidth()){
        simpleBitRange->swapUpLow();
      }
    }
  }
  else if(upperParams->size()>lowerParams->size()){
    for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=upperParams->begin(); it!=upperParams->end(); it++) {
      hasError=FALSE;
      if(it->second.get() && it->second->isNumber()){
        upper=CSLOmNumber::cast(it->second);
      }
      else{
        //throw error param is not a number or doesn't exist
        // design_bitrange_up_low_inst_number
        args.push_back(*m_lastPSvisited);
        if(!it->first.get()){
          args.push_back("default value");
          args.push_back("0");
        }
        else{
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
        }
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_INST_NUMBER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
        checkerHasErrors=TRUE;
        hasError=TRUE;
      }

      //if(CSLOmExpr::getValueForInstance(it->first,lowerParams).get()){
      //  lower=CSLOmExpr::getValueForInstance(it->first,lowerParams);
      //}
      //else{
      //  lower=CSLOmNumber::cast(lowerParams->begin()->second);
      //}
      //lower=CSLOmNumber::cast(lowerParams->begin()->second);
      lower=CSLOmExpr::getValueForInstance(it->first,lowerParams);
      if(!lower.get()){
        args.push_back(*m_lastPSvisited);
        if(!it->first.get()){
          args.push_back("default value");
          args.push_back("0");
        }
        else{
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
        }
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_INST_NUMBER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
        //add error param is not number
        //design_bitrange_up_low_inst_number
        checkerHasErrors=TRUE;
        hasError=TRUE;
      }
      if(!hasError){
        //lower should be smaller than the upper
        if(lower->getValue() > upper->getValue()){
          //throw warning
          //design_bitrange_upper_lower_inst
          args.push_back(*m_lastPSvisited);
          if(!it->first.get()){
            args.push_back("default value");
            args.push_back("0");
          }
          else{
            args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
            args.push_back(intToString(it->first->getLineNumber()));
          }
          args.push_back(intToString(upper->getValue()));
          args.push_back(intToString(lower->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UPPER_LOWER_INST, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
          //checkerHasErrors=TRUE;
        }
      }
    } 
  }
  else if(upperParams->size()<lowerParams->size()){
    for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=lowerParams->begin(); it!=lowerParams->end(); it++) {
      hasError=FALSE;
      if(it->second.get() && it->second->isNumber()){
        lower=CSLOmNumber::cast(it->second);
      }
      else{
        //throw error param is not a number or doesn't exist
        //design_bitrange_up_low_inst_number
        args.push_back(*m_lastPSvisited);
        if(!it->first.get()){
          args.push_back("default value");
          args.push_back("0");
        }
        else{
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
        }
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_INST_NUMBER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
        checkerHasErrors=TRUE;
        hasError=TRUE;
      }
      upper=CSLOmExpr::getValueForInstance(it->first,upperParams);
      if(!upper.get()){
        //add error param is not number
        //design_bitrange_up_low_inst_number
        args.push_back(*m_lastPSvisited);
        if(!it->first.get()){
          args.push_back("default value");
          args.push_back("0");
        }
        else{
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
        }
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_INST_NUMBER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
        checkerHasErrors=TRUE;
        hasError=TRUE;
      }
      if(!hasError){
        //lower should be smaller than the upper
        if(lower->getValue() > upper->getValue()){
          args.push_back(*m_lastPSvisited);
          if(!it->first.get()){
            args.push_back("default value");
            args.push_back("0");
          }
          else{
            args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
            args.push_back(intToString(it->first->getLineNumber()));
          }
          args.push_back(intToString(upper->getValue()));
          args.push_back(intToString(lower->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UPPER_LOWER_INST, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
          //checkerHasErrors=TRUE;
          //throw warning
          //design_bitrange_upper_lower_inst
        }
      }
    }
  }

  //now for widths
  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase widthParams = simpleBitRange->getWidth()->doParamEval(simpleBitRange);
  for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=widthParams->begin(); it!=widthParams->end(); it++) {
    if(!it->second.get()){
      //design_bitrange_width_not_number
      args.push_back(*m_lastPSvisited);
      if(!it->first.get()){
          args.push_back("default value");
          args.push_back("0");
      }
      else{
        args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
        args.push_back(intToString(it->first->getLineNumber()));
      }
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_NOT_NUMBER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
      checkerHasErrors=TRUE;
      return;
    }
    if(!it->second->isNumber()){
      //design_bitrange_width_not_number
      args.push_back(*m_lastPSvisited);
      if(!it->first.get()){
          args.push_back("default value");
          args.push_back("0");
      }
      else{
        args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
        args.push_back(intToString(it->first->getLineNumber()));
      }
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_NOT_NUMBER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
      checkerHasErrors=TRUE;
    }
    else{
      if(CSLOmNumber::cast(it->second)->getValue()==0){
        //design_bitrange_width_eq_zero
        args.push_back(*m_lastPSvisited);
        if(!it->first.get()){
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_EQ_ZERO_NI, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
          checkerHasErrors=TRUE;
          return;
        }
        else{
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
        }
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_EQ_ZERO, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
        checkerHasErrors=TRUE;
      }
      if(CSLOmNumber::cast(it->second)->getValue()<0){
        args.push_back(*m_lastPSvisited);
        if(!it->first.get()){
          args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_LT_ZERO_NI, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
          checkerHasErrors=TRUE;
        }
        else{
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
          args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_LT_ZERO, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
          checkerHasErrors=TRUE;
        }
        //design_bitrange_width_lt_zero
      }
    }
  }

}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ){
  //to add parameters to this
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           ){}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ){
  //useless to define a signal group without signals inside
  //this check only works if the signal group is instanciated somewhere. 
  TInt size=groupSignal->getChildrenSize();
  if (size<2) {
    addErr(NSWarningErr::DEE_CSA_SIG_DESIGN_SG_NO_SIGNALS, args, 0,groupSignal->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ){}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ){}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ){
  m_insideIfc=TRUE;
  //useless to define an interface without ports inside
  //this check only works if the signal group is instanciated somewhere.
  TInt size=interface->getChildrenSize();
  if(!interface->isDefaultIfc() && size<2){
    addErr(NSWarningErr::DEE_CSA_SIG_DESIGN_IFC_NO_PORTS, args, 0,interface->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  }
  //if a ifc has only one ifc inside it. 
  if(!interface->isDefaultIfc() && size==2 && !interface->isArGenerated()){
    if(interface->getChild(ONE)->isInterface()){
      args.push_back(*CSLOmIdentifier::cast(interface->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_SIG_DESIGN_IFC_NOTHING_BUT_IFC, args, 0,interface->getFileName(),FALSE,TRUE);
    }
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ){
  m_lastPSvisited=CSLOmIdentifier::cast(portDecl->getChild(ID))->getName();

  //portDecl that has type clock must have width == 1
  if(portDecl->getAttr()==NSCSLOm::ATTR_CLK){
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase widthParams = portDecl->getWidth()->doParamEval(portDecl);
    for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=widthParams->begin(); it!=widthParams->end(); it++) {
      if(!it->second->isNumber()){
        //add error
        return;
      }
      RefCSLOmNumber width=CSLOmNumber::cast(it->second);
      if(width->getValue()!=1){
        args.push_back(*CSLOmIdentifier::cast(portDecl->getChild(ID))->getName());
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_WIDTH_ONE, args, portDecl->getLineNumber(), portDecl->getFileName());
        checkerHasErrors=TRUE;
      }
    }
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ){
  if(m_multipleConcatsInStmtAssign || m_insideAssignStmt){
    RefCSLOmBase exprOpParent=exprOp->getParent();
    while(exprOpParent->isExpr() && CSLOmExpr::cast(exprOpParent)->isOp()){
      exprOpParent=exprOpParent->getParent();
    }
    if(exprOpParent->getParent()->isSignal() || exprOpParent->getParent()->isPort()){
      return;
    }
    
    RefCSLOmBase parent=m_lastStmtAssignVisited->getParent();
    RefTVec_RefCSLOmBase exprs=exprOp->getExprsAsBase();
    for(TVec_RefCSLOmBase::iterator i=exprs->begin(); i<exprs->end();i++){
      if((*i)->isNumber()){
        RefCSLOmNumber num=CSLOmNumber::cast(*i);
        DCERR(intToString(num->getValue()));
      }
      if((*i)->isExprLink()){
        RefCSLOmExprLink tempLink=CSLOmExprLink::cast(*i);
        tempLink->doEval();
        if(!tempLink->getValue().get()){
          args.push_back(*convertLink(tempLink));
          args.push_back(*CSLOmIdentifier::cast(m_lastStmtAssignVisited->getParent()->getChild(ID))->getName());
          addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, m_lastStmtAssignVisited->getLineNumber(),m_lastStmtAssignVisited->getFileName());
          checkerHasErrors=TRUE;
          return;
        }
        if(tempLink->getValue()->isConnectable()){
          RefCSLOmConnectable connObj=CSLOmConnectable::cast(tempLink->getValue());
          if(!connObj.get()){
            args.push_back(*convertLink(tempLink));
            RefCSLOmBase stmtParent=m_lastStmtAssignVisited->getParent();
            while(!stmtParent->isUnitDecl()){
              stmtParent=stmtParent->getParent();
            }
            args.push_back(*CSLOmIdentifier::cast(stmtParent->getChild(ID))->getName());
            addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, m_lastStmtAssignVisited->getLineNumber(),m_lastStmtAssignVisited->getFileName());
            checkerHasErrors=TRUE;
          }
          else{
            if(connObj->getParentUnit().get()!=parent.get()) {
              args.push_back(*convertLink(tempLink));
              addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, tempLink->getLineNumber(),tempLink->getFileName());
              checkerHasErrors=TRUE;                                             
            }
          }
        }                              
      }
    }
  }   
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ){
  if(m_insideAssignStmt){
    if(m_lhsAssignStmtConcat && !m_lhsConcatAssignVisited){//we are on the lhs concat
      checkConcatForObjects(exprConcat);
      if(!m_lhsConcatAssignAllObjects){
        addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_LHS_ASSIGN_NOT_OBJECT, args, exprConcat->getLineNumber(),exprConcat->getFileName());
        checkerHasErrors=TRUE;
      }
    }
    if(m_multipleConcatsInStmtAssign){
      RefCSLOmUnitDecl parent=CSLOmUnitDecl::cast(m_lastStmtAssignVisited->getParent());
      RefTVec_RefCSLOmBase exprs=exprConcat->getExprsAsBase();
      for(TVec_RefCSLOmBase::iterator i=exprs->begin(); i<exprs->end();i++){
        if((*i)->isExprLink()){
          RefCSLOmExprLink tempLink=CSLOmExprLink::cast(*i);      
          tempLink->doEval();
          RefCSLOmConnectable connObj=CSLOmConnectable::cast(tempLink->getValue());
          if(!connObj.get()){
            args.push_back(*convertLink(tempLink));
            RefCSLOmBase stmtParent=m_lastStmtAssignVisited->getParent();
            while(!stmtParent->isUnitDecl()){
              stmtParent=stmtParent->getParent();
            }
            args.push_back(*CSLOmIdentifier::cast(stmtParent->getChild(ID))->getName());
            addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, m_lastStmtAssignVisited->getLineNumber(),m_lastStmtAssignVisited->getFileName());
            checkerHasErrors=TRUE;
          }
          else{
            if(connObj->getParentUnit().get()!=parent.get()) {
              args.push_back(*convertLink(tempLink));
              addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, tempLink->getLineNumber(),tempLink->getFileName());
              checkerHasErrors=TRUE;                                             
            }
          }                                                                    
        }
      }
    }
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ){
  if(m_insideAssignStmt){
    RefCSLOmUnitDecl parent=CSLOmUnitDecl::cast(m_lastStmtAssignVisited->getParent());
    RefCSLOmExprConcat concat=exprMultiConcat->getExprConcat();
    RefTVec_RefCSLOmBase exprs=concat->getExprsAsBase();
    for(TVec_RefCSLOmBase::iterator i=exprs->begin(); i<exprs->end();i++){
      if((*i)->isExprLink()){
        RefCSLOmExprLink tempLink=CSLOmExprLink::cast(*i);      
        tempLink->doEval();
        RefCSLOmConnectable connObj=CSLOmConnectable::cast(tempLink->getValue());
        if(!connObj.get()){
          args.push_back(*convertLink(tempLink));
          RefCSLOmBase stmtParent=m_lastStmtAssignVisited->getParent();
          while(!stmtParent->isUnitDecl()){
            stmtParent=stmtParent->getParent();
          }
          args.push_back(*CSLOmIdentifier::cast(stmtParent->getChild(ID))->getName());
          addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, m_lastStmtAssignVisited->getLineNumber(),m_lastStmtAssignVisited->getFileName());
          checkerHasErrors=TRUE;
        }
        else{
          if(connObj->getParentUnit().get()!=parent.get()) {
            args.push_back(*convertLink(tempLink));
            addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, tempLink->getLineNumber(),tempLink->getFileName());
            checkerHasErrors=TRUE;                                             
          }
        }                                                                    
      }
    }
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmList                            & list                            ){}  
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ){}
//void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ){
  TInt width=enumeration->getWidth();
  if(enumeration->isEmpty()){
    args.push_back(*CSLOmIdentifier::cast(enumeration->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSC_HID_DSGN_EMPTY_ENUM, args, enumeration->getLineNumber(),enumeration->getFileName());
    //checkerHasErrors=TRUE;
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           ){

  if(field->getFieldType()==NSCSLOm::CSLOmField::FIELD_UNDEFINED){
    if(field->isDefault() && !field->isAnonymous()){
      args.push_back(*CSLOmIdentifier::cast(field->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_FIELD_WIDTH, args, 0,field->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }
  if(field->getParent()->isField() && CSLOmField::cast(field->getParent())->getFieldType()==NSCSLOm::CSLOmField::FIELD_HIERARCHICAL){
    if (CSLOmField::cast(field->getParent())->hasPositionsSet() && !CSLOmField::cast(field->getParent())->isSetPosition(field)) {
      args.push_back(*CSLOmIdentifier::cast(field->getChild(ID))->getName());
      args.push_back(*CSLOmIdentifier::cast(field->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSC_DSGN_NOT_ALL_FIELD_POS_SET, args, field->getParent()->getLineNumber(),field->getParent()->getFileName());
      checkerHasErrors=TRUE;
    }
  }

  TBool isDirectlyInDesign=FALSE;
  RefCSLOmBase fieldBase = field;
  while(fieldBase->getParent()->isField()){
    fieldBase=fieldBase->getParent();
  }
  if(fieldBase->getParent()->isDesign()){
    isDirectlyInDesign=TRUE;
  }
  
  if(!isDirectlyInDesign){
    //getting the lower and upper params for repsective instances
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase upperParams = field->getUpper()->doParamEval(field);
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase lowerParams = field->getLower()->doParamEval(field);
  
    if(!upperParams.get()){
      //err design_bitrange_up_not_eval
      args.push_back(*m_lastPSvisited);
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_NOT_EVAL, args, field->getLineNumber(),field->getFileName());  
      checkerHasErrors=TRUE;
      return;
    }
    if(!lowerParams.get()){
      args.push_back(*m_lastPSvisited);
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_NOT_EVAL, args, field->getLineNumber(),field->getFileName());  
      checkerHasErrors=TRUE; 
      //err design_bitrange_up_not_eval
      return;
    }
  
    RefCSLOmNumber upper=RefCSLOmNumber();
    RefCSLOmNumber lower=RefCSLOmNumber();
    TBool hasError=FALSE;
  
    if((upperParams->size()==lowerParams->size()) && (upperParams->size()==1)){
      if(!upperParams->begin()->second->isNumber()){
        //error with design_bitrange_up_low_number
        args.push_back(*m_lastPSvisited);
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_NUMBER, args, field->getLineNumber(),field->getFileName());  
        checkerHasErrors=TRUE;
      }
      if(!lowerParams->begin()->second->isNumber()){
        args.push_back(*m_lastPSvisited);
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_NUMBER, args, field->getLineNumber(),field->getFileName());  
        checkerHasErrors=TRUE;
        //error with design_bitrange_up_low_number
      }
      upper=CSLOmNumber::cast(upperParams->begin()->second);
      lower=CSLOmNumber::cast(lowerParams->begin()->second);
      if(lower->getValue() > upper->getValue()){
        //throw warning
        //design_bitrange_upper_lower
        args.push_back(*m_lastPSvisited);
        args.push_back(intToString(upper->getValue()));
        args.push_back(intToString(lower->getValue()));
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UPPER_LOWER, args, field->getLineNumber(),field->getFileName());  
        //checkerHasErrors=TRUE;
      }
    }
    else if(upperParams->size()>lowerParams->size()){
      for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=upperParams->begin(); it!=upperParams->end(); it++) {
        hasError=FALSE;
        if(it->second.get() && it->second->isNumber()){
          upper=CSLOmNumber::cast(it->second);
        }
        else{
          //throw error param is not a number or doesn't exist
          // design_bitrange_up_low_inst_number
          args.push_back(*m_lastPSvisited);
          if(!it->first.get()){
            args.push_back("default value");
            args.push_back("0");
          }
          else{
            args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
            args.push_back(intToString(it->first->getLineNumber()));
          }
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_INST_NUMBER, args, field->getLineNumber(),field->getFileName());  
          checkerHasErrors=TRUE;
          hasError=TRUE;
        }
        lower=CSLOmExpr::getValueForInstance(it->first,lowerParams);
        if(!lower.get()){
          args.push_back(*m_lastPSvisited);
          if(!it->first.get()){
            args.push_back("default value");
            args.push_back("0");
          }
          else{
            args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
            args.push_back(intToString(it->first->getLineNumber()));
          }
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_INST_NUMBER, args, field->getLineNumber(),field->getFileName());  
          //add error param is not number
          //design_bitrange_up_low_inst_number
          checkerHasErrors=TRUE;
          hasError=TRUE;
        }
        if(!hasError){
          //lower should be smaller than the upper
          if(lower->getValue() > upper->getValue()){
            //throw warning
            //design_bitrange_upper_lower_inst
            args.push_back(*m_lastPSvisited);
            if(!it->first.get()){
              args.push_back("default value");
              args.push_back("0");
            }
            else{
              args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
              args.push_back(intToString(it->first->getLineNumber()));
            }
            args.push_back(intToString(upper->getValue()));
            args.push_back(intToString(lower->getValue()));
            addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UPPER_LOWER_INST, args, field->getLineNumber(),field->getFileName());  
            //checkerHasErrors=TRUE;
          }
        }
      } 
    }
    else if(upperParams->size()<lowerParams->size()){
      for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=lowerParams->begin(); it!=lowerParams->end(); it++) {
        hasError=FALSE;
        if(it->second.get() && it->second->isNumber()){
          lower=CSLOmNumber::cast(it->second);
        }
        else{
          //throw error param is not a number or doesn't exist
          //design_bitrange_up_low_inst_number
          args.push_back(*m_lastPSvisited);
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));                       
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_INST_NUMBER, args, field->getLineNumber(),field->getFileName());  
          checkerHasErrors=TRUE;
          hasError=TRUE;
        }
        upper=CSLOmExpr::getValueForInstance(it->first,upperParams);
        if(!upper.get()){
          //add error param is not number
          //design_bitrange_up_low_inst_number
          args.push_back(*m_lastPSvisited);
          if(!it->first.get()){
            args.push_back("default value");
            args.push_back("0");
          }
          else{
            args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
            args.push_back(intToString(it->first->getLineNumber()));
          }    
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_INST_NUMBER, args, field->getLineNumber(),field->getFileName());  
          checkerHasErrors=TRUE;
          hasError=TRUE;
        }
        if(!hasError){
          //lower should be smaller than the upper
          if(lower->getValue() > upper->getValue()){
            args.push_back(*m_lastPSvisited);
            if(!it->first.get()){
              args.push_back("default value");
              args.push_back("0");
            }
            else{
              args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
              args.push_back(intToString(it->first->getLineNumber()));
            }
            args.push_back(intToString(upper->getValue()));
            args.push_back(intToString(lower->getValue()));
            addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UPPER_LOWER_INST, args, field->getLineNumber(),field->getFileName());  
            //checkerHasErrors=TRUE;
            //throw warning
            //design_bitrange_upper_lower_inst
          }
        }
      }
    }
  
    //now for widths
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase widthParams = field->getWidth()->doParamEval(field);
    for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=widthParams->begin(); it!=widthParams->end(); it++) {
      if(!it->second.get()){
        //design_bitrange_width_not_number
        args.push_back(*m_lastPSvisited);
        if(!it->first.get()){
          args.push_back("default value");
          args.push_back("0");
        }
        else{
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
        }
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_NOT_NUMBER, args, field->getLineNumber(),field->getFileName());  
        checkerHasErrors=TRUE;
        return;
      }
      if(!it->second->isNumber()){
        //design_bitrange_width_not_number
        args.push_back(*m_lastPSvisited);
        if(!it->first.get()){
          args.push_back("default value");
          args.push_back("0");
        }
        else{
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
        }
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_NOT_NUMBER, args, field->getLineNumber(),field->getFileName());  
        checkerHasErrors=TRUE;
      }
      else{
        if(CSLOmNumber::cast(it->second)->getValue()==0){
          //design_bitrange_width_eq_zero
          args.push_back(*m_lastPSvisited);
          if(!it->first.get()){
            args.push_back("default value");
            args.push_back("0");
          }
          else{
            args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
            args.push_back(intToString(it->first->getLineNumber()));
          }
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_EQ_ZERO, args, field->getLineNumber(),field->getFileName());  
          checkerHasErrors=TRUE;
        }
        if(field->isWithEnum()){
          RefCSLOmNumber fieldWidth=CSLOmNumber::cast(it->second);
          RefCSLOmEnum en=CSLOmEnum::cast(field->getEnum());
          TUInt enumWidth=en->getWidth();
          if(fieldWidth->getValue()<enumWidth){
            if(it->first.get()) {
              args.push_back(*CSLOmIdentifier::cast(field->getChild(ID))->getName());
              args.push_back(*CSLOmIdentifier::cast(en->getChild(ID))->getName());
            }
            else{
              args.push_back("default value");
              args.push_back("0");
            }
            addErr(NSWarningErr::DEE_CSC_DSGN_ENUM_WIDTH_BIGGER, args, field->getLineNumber(), field->getFileName());
          }
        }
        if(CSLOmNumber::cast(it->second)->getValue()<0){
          args.push_back(*m_lastPSvisited);
          if(!it->first.get()){
            args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
            addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_LT_ZERO_NI, args, field->getLineNumber(),field->getFileName());  
            checkerHasErrors=TRUE;
          }
          else{
            args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
            args.push_back(intToString(it->first->getLineNumber()));
            args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
            addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_LT_ZERO, args, field->getLineNumber(),field->getFileName());  
            checkerHasErrors=TRUE;
          }
          //design_bitrange_width_lt_zero
        }
      }
    }
  }
  else{ //is directly is design
    TInt width;
    
    if(!field->hasSetWidth()){
      RefCSLOmBase lowBase=(field->getLower())->doEval(TRUE);
      RefCSLOmBase upBase=(field->getUpper())->doEval(TRUE);
      RefCSLOmNumber upper=RefCSLOmNumber();
      RefCSLOmNumber lower=RefCSLOmNumber();
      if(lowBase->isNumber()){
        lower=CSLOmNumber::cast(lowBase);
      }
      else{
        //error
      }
      if(upBase->isNumber()){
        upper=CSLOmNumber::cast(upBase);
      }
      else{
        //error
      }
      if(lower->getValue() > upper->getValue()){
        //throw warning
        //design_bitrange_upper_lower
        args.push_back(*CSLOmIdentifier::cast(field->getChild(ID))->getName());
        args.push_back(intToString(upper->getValue()));
        args.push_back(intToString(lower->getValue()));
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UPPER_LOWER, args, field->getLineNumber(),field->getFileName());  
        //checkerHasErrors=TRUE;
        if(!field->hasSetWidth()){
          field->swapUpLow();
        }
      }
    }
    
    RefCSLOmBase eWidth=field->getWidth()->doEval(TRUE);
    if(eWidth->isNumber()){
      width=CSLOmNumber::cast(eWidth)->getValue();
    }
    else{
      //error
    }
    //width is less than zero
    if(width<0){
      args.push_back(*CSLOmIdentifier::cast(field->getChild(ID))->getName());
      args.push_back(intToString(width));
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_FIELD_WIDTH_LT_ZERO, args, field->getLineNumber(),field->getFileName());  
      checkerHasErrors=TRUE;
    }
    //children width
    RefTVec_RefCSLOmBase fieldChildren = field->getChildrenAsBase(TYPE_BIT_RANGE);
    if(fieldChildren.get()){
      TInt addedWidths=0;
      for(TVec_RefCSLOmBase::iterator i=fieldChildren->begin(); i<fieldChildren->end(); i++){
        if((*i)->isField()){
          RefCSLOmBase widthBase =CSLOmField::cast(*i)->getWidth()->doEval(TRUE);
          addedWidths+= CSLOmNumber::cast(widthBase)->getValue();
        }
      }
      if(width<addedWidths){
        args.push_back(*CSLOmIdentifier::cast(field->getChild(ID))->getName());
        args.push_back(intToString(addedWidths));
        args.push_back(intToString(width));
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_FIELD_WIDTH_SMALLER, args,field->getLineNumber(), field->getFileName());
        checkerHasErrors=TRUE;
      }
    }
    
    //has enum and the enum is bigger
    if(field->isWithEnum()){
      RefCSLOmEnum en=CSLOmEnum::cast(field->getEnum());
      TInt enumWidth=en->getWidth();
      if(width<enumWidth){
        args.push_back(*CSLOmIdentifier::cast(field->getChild(ID))->getName());
        args.push_back(intToString(width));
        args.push_back(intToString(enumWidth));
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_FIELD_WIDTH_ENUM, args, field->getLineNumber(), field->getFileName());
        checkerHasErrors = TRUE;
      }
    }
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ){
  m_memoryMapPresent=TRUE;

  if(memoryMap->getMandatoryCount()!=DCH_MAN_CMD_CNT_MEMORY_MAP){
     if(memoryMap->getMemMapType()==MM_UNDEFINED){
       args.push_back(*CSLOmIdentifier::cast(memoryMap->getChild(ID))->getName());
       addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_MMAP_TYPE, args, 0,memoryMap->getFileName(),FALSE,TRUE);
       checkerHasErrors=TRUE;
     }
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ){
  m_memMapPagesCount++;
  
  //predefined but not declared
  if(!memoryMapPage->isDefined()){
    args.push_back(*CSLOmIdentifier::cast(memoryMapPage->getChild(ID))->getName());
    addErr(NSWarningErr::CSE_CSA_ASE_DESIGN_NOT_DECLARED, args,memoryMapPage->getLineNumber(),memoryMapPage->getFileName());
    checkerHasErrors=TRUE;
  }

  if(memoryMapPage->getMandatoryCount()!=DCH_MAN_CMD_CNT_MMAP_PAGE){
    if(!memoryMapPage->isUnitNameSet()){
      args.push_back(*CSLOmIdentifier::cast(memoryMapPage->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_MPAGE_UNIT_NAME, args,0,memoryMapPage->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
    if(!memoryMapPage->isSetAddressRange()){
      args.push_back(*CSLOmIdentifier::cast(memoryMapPage->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_MPAGE_ADDRESS_RANGE, args,0,memoryMapPage->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }
}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ){
  //flags
  m_insideIsaField=TRUE;
  //mandatory commands
  //if(isaField->getMandatoryCount()!=DCH_MAN_CMD_CNT_ISA_FIELD){
  if(isaField->getIsaFieldType()==NSCSLOm::CSLOmIsaField::ISA_FIELD_UNDEFINED){
    args.push_back(*CSLOmIdentifier::cast(isaField->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_ISAF_TYPE, args, 0,isaField->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  }
    //}
  if(isaField->getFieldType()==NSCSLOm::CSLOmField::FIELD_UNDEFINED && isaField->isDefault()){
    args.push_back(*CSLOmIdentifier::cast(isaField->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_FIELD_WIDTH, args, 0,isaField->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  }
  
  //cannot have isaField with type opcode and no enum associated (WITH gen_decoder called upon it)
  if(!isaField->isWithEnum() && isaField->getIsaFieldType()==NSCSLOm::CSLOmIsaField::ISA_FIELD_OPCODE && isaField->isDecoder()){
    args.push_back(*CSLOmIdentifier::cast(isaField->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_FIELD_OPCODE_NOENUM, args, 0,isaField->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  }

  //cannot have isaField with enum inside isaElement of type instruction
  if(m_insideIsaElemInstr && isaField->isWithEnum()){
    args.push_back(*CSLOmIdentifier::cast(isaField->getChild(ID))->getName());
    args.push_back(*m_isaElemInstrName);
    addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_INSTR_FIELD_WITH_ENUM, args, 0,isaField->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  }

  //hierarchical width checks
  TInt currentIsaFieldWidth=0;
  RefCSLOmExpr expr=isaField->getWidth();
  RefCSLOmNumber num=CSLOmNumber::cast(expr->doEval());
  currentIsaFieldWidth=num->getValue();
  
  if(m_isaFieldHierSizes->size()){
      m_isaFieldHierSizes->back()+=currentIsaFieldWidth;
    }
  if(isaField->isHierarchical()){
    m_isaFieldHierSizes->push_back(0);
  }

  //adding the width of the field to the isaElement only if it's the parent of the current field
  if(m_isaElemWait){
    m_isaElemWait=FALSE;
    m_isaElemHierAddedWidths+=currentIsaFieldWidth;
  }

  //associated enum check
  if(m_insideIsaElement){
    if(isaField->isWithEnum()){
      RefCSLOmBase enumName = isaField->getEnum();
      m_prevIsaElement->registeredEnum(CSLOmEnum::cast(enumName));
    }
    
    if(isaField->isWithEnumItem()){
      RefCSLOmBase enumItem=isaField->getEnumItem();
      m_prevIsaElement->registeredEnumItem(CSLOmIdentifier::cast(enumItem));
    }
    //field positions check
    RefCSLOmBase parent=isaField->getParent();
    TInt offset;
    if(parent->isIsaField()){
      offset=CSLOmIsaField::cast(parent)->getFieldPosition(isaField);
      m_currentPosition+=offset;
    }
    else if(parent->isIsaElement()){
      offset=CSLOmIsaElement::cast(parent)->getFieldPosition(isaField);
      m_currentPosition+=offset;
    }
  }

}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ){

  m_insideIsaElement=TRUE;
  m_prevIsaElement=isaElement;

  m_currentEnumItemFieldPosition=MAX_INT;
  m_currentNormalFieldPosition=-MAX_INT;
  m_currentPosition=0;

  //predefined but not declared
  if(!isaElement->isDefined()){
    args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
    addErr(NSWarningErr::CSE_CSA_ASE_DESIGN_NOT_DECLARED, args, isaElement->getLineNumber(),isaElement->getFileName());
    checkerHasErrors=TRUE;
  }

  if(isaElement->getIsaType()==NSCSLOm::CSLOmIsaElement::ISA_ELEM_UNDEFINED){
    args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_ISAE_TYPE, args, 0,isaElement->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  }
  if(isaElement->getIsaType()==NSCSLOm::CSLOmIsaElement::ISA_ELEM_ROOT){
    m_isaElemRootCount++;
    RefCSLOmExpr expr=isaElement->getWidth();
    m_rootFormatWidth=CSLOmNumber::cast(expr->doEval())->getValue();
    //enabling and creating the root node of the isa prefix check
    m_isaPrefixTree=CSLOmIsaPrefixTree::build(); 
    if(isaElement->isDefault()){
      args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_ISA_ELEM_ROOT_WIDTH, args, 0,isaElement->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }
  
  RefTVec_WeakRefCSLOmIsaElement children = isaElement->getIsaChildren();
  //all instructions must be leafs
  if(isaElement->getIsaType()==NSCSLOm::CSLOmIsaElement::ISA_ELEM_INSTR){
    m_insideIsaElemInstr=TRUE;
    m_isaElemInstrName=CSLOmIdentifier::cast(isaElement->getChild(ID))->getName();
    if(children.get()){
      args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_INSTR_NOT_LEAF, args, 0,isaElement->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }

  //leaf levels must be instructions
  if(!children.get()){ //then it is leaf level
    if(isaElement->getIsaType()!=NSCSLOm::CSLOmIsaElement::ISA_ELEM_INSTR){
      args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_LEAF_NOT_INSTR, args, 0,isaElement->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }
  
  //clearing the vector for the isa prefix check
  m_curInstrFields->clear();

  //isa element hierarchical fields widths checks
  m_isaElemHierAddedWidths=0;
  m_isaElemWait=TRUE;
}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ){}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ){
  m_insideAssignStmt=TRUE;
  m_lastStmtAssignVisited=stmtAssign;

  RefCSLOmExpr lhs=stmtAssign->getLHS();
  RefCSLOmExpr rhs=stmtAssign->getRHS();

  RefCSLOmBase lhsEvaled;
  RefCSLOmBase rhsEvaled;
  
  RefCSLOmScope scope = CSLOmBase::getAttachedScope(stmtAssign->getParent().get());
  CSLOmScopeBlock::enterScope(scope);
  
  if(lhs->isExprLink()){
    lhsEvaled=lhs->doEval();
  }
  if(rhs->isExprLink()){
    rhsEvaled=rhs->doEval();
  }

  if(lhs->isExprLink()){
    if(CSLOmExprLink::cast(lhs)->getValue().get()){
      if(CSLOmExprLink::cast(lhs)->getValue()->isSignalGroup()){
        args.push_back(*CSLOmExprLink::cast(lhs)->getName());
        addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_SG_ANYTHING, args, lhs->getLineNumber(),lhs->getFileName());
        checkerHasErrors=TRUE;
        return;
      }
      if(rhs->isExprLink()){
        if(CSLOmExprLink::cast(rhs)->getValue().get()){
          RefCSLOmExprLink lhsEl=CSLOmExprLink::cast(lhs);
          RefCSLOmExprLink rhsEl=CSLOmExprLink::cast(rhs);
          if(rhsEl->hasBitRange() && (!rhsEl->getValue()->isPort() && !rhsEl->getValue()->isSignal())){
            args.push_back(*rhsEl->getName());
            addErr(NSWarningErr::CSE_CSC_SIG_ASSIGN_PART_SELECT_NOT_PORT_OR_SIGNAL, args, rhsEl->getLineNumber(),rhsEl->getFileName());
            checkerHasErrors=TRUE;
            return;
          }                                        
          if(lhsEl->getValue()->isConnectable() && rhsEl->getValue()->isConnectable()){
            RefCSLOmBase lhsParent=CSLOmConnectable::cast(lhsEl->getValue())->getParentUnit();
            RefCSLOmBase rhsParent=CSLOmConnectable::cast(rhsEl->getValue())->getParentUnit();

            RefCSLOmBase stmtParent=stmtAssign->getParent();
            while(!stmtParent->isUnitDecl()){
              stmtParent=stmtParent->getParent();
            }
            if(lhsParent.get()!=stmtParent.get()){
              args.push_back(*convertLink(lhsEl));
              addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, lhs->getLineNumber(),lhs->getFileName());
              checkerHasErrors=TRUE;
              return;
            }
            if(rhsParent.get()!=stmtParent.get()){
              args.push_back(*convertLink(rhsEl));
              addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, lhs->getLineNumber(),lhs->getFileName());
              checkerHasErrors=TRUE;
              return;
            }

            if((lhsEl->getValue()->isInterface() || lhsEl->getValue()->isSignalGroup()) &&
               (!rhsEl->getValue()->isInterface() && !rhsEl->getValue()->isSignalGroup())){
              args.push_back(*rhsEl->getName());
              args.push_back(*lhsEl->getName());
              addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_LHS_ASSIGN, args, lhs->getLineNumber(),lhs->getFileName());
              checkerHasErrors=TRUE;                                             
            }
            else if((rhsEl->getValue()->isInterface() || rhsEl->getValue()->isSignalGroup()) &&
                    (!lhsEl->getValue()->isInterface() && !lhsEl->getValue()->isSignalGroup())){
              args.push_back(*lhsEl->getName());
              args.push_back(*rhsEl->getName());
              addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_LHS_ASSIGN, args, lhs->getLineNumber(),lhs->getFileName());
              checkerHasErrors=TRUE;                                             
            }
            else if((lhsEl->getValue()->isInterface() && rhsEl->getValue()->isSignalGroup()) ||
                    (rhsEl->getValue()->isInterface() && lhsEl->getValue()->isSignalGroup()) ||
                    (rhsEl->getValue()->isInterface() && lhsEl->getValue()->isInterface())   ||
                    (rhsEl->getValue()->isSignalGroup() && lhsEl->getValue()->isSignalGroup())){
              RefCSLOmConnectable connObj=CSLOmConnectable::cast(lhsEl->getValue());
              checkIfc2IfcOrSgf2a(lhsEl,rhsEl,connObj->getParentUnit(), connObj->getParentUnit());
              return;
            }
            else{
              RefTMap_RefCSLOmUnitInstance_RefCSLOmBase lhsWidthParams;
              RefTMap_RefCSLOmUnitInstance_RefCSLOmBase rhsWidthParams;
              if(lhsEl->getValue()->isPort()){
                if(lhsEl->hasBitRange()){
                  lhsWidthParams = CSLOmSimpleBitRange::cast(lhsEl->getBitRange())->getWidth()->doParamEval(lhsEl->getValue());
                }
                else{
                  lhsWidthParams = CSLOmPortDecl::cast(lhsEl->getValue())->getWidth()->doParamEval(lhsEl->getValue());
                }
              }
              else if(lhsEl->getValue()->isSignal()){
                if(lhsEl->hasBitRange()){
                  lhsWidthParams = CSLOmSimpleBitRange::cast(lhsEl->getBitRange())->getWidth()->doParamEval(lhsEl->getValue());
                }
                else{
                  lhsWidthParams = CSLOmSignal::cast(lhsEl->getValue())->getWidth()->doParamEval(lhsEl->getValue());                
                }
              }
              if(rhsEl->getValue()->isPort()){
                if(rhsEl->hasBitRange()){
                  rhsWidthParams = CSLOmSimpleBitRange::cast(rhsEl->getBitRange())->getWidth()->doParamEval(rhsEl->getValue());
                }
                else{
                  rhsWidthParams = CSLOmPortDecl::cast(rhsEl->getValue())->getWidth()->doParamEval(rhsEl->getValue());
                }
              }
              else if(rhsEl->getValue()->isSignal()){
                if(rhsEl->hasBitRange()){
                  rhsWidthParams = CSLOmSimpleBitRange::cast(rhsEl->getBitRange())->getWidth()->doParamEval(rhsEl->getValue());
                }
                else{
                  rhsWidthParams = CSLOmSignal::cast(rhsEl->getValue())->getWidth()->doParamEval(rhsEl->getValue());                
                }
              }

              if(lhsEl->getValue()->isPort() && rhsEl->getValue()->isPort()){
                //ports dirrection
                if(CSLOmPortDecl::cast(lhsEl->getValue())->getPortDirection()!=CSLOmPortDecl::cast(rhsEl->getValue())->getPortDirection()){
                  args.push_back(*rhsEl->getName());
                  args.push_back(*lhsEl->getName());
                  addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_P_P_CONECTION_DIFF_DIR, args, rhsEl->getLineNumber(),rhsEl->getFileName());
                  checkerHasErrors=TRUE;
                }
              }

              if(lhsWidthParams->size()==rhsWidthParams->size() && lhsWidthParams->size()==1){
                if(!lhsWidthParams->begin()->second->isNumber()){
                  //error with design_bitrange_up_low_number
                  args.push_back(*m_lastPSvisited);
                  addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_NUMBER, args, lhsEl->getLineNumber(),lhsEl->getFileName());  
                  checkerHasErrors=TRUE;
                  return;     
                }
                if(!rhsWidthParams->begin()->second->isNumber()){
                  //error with design_bitrange_up_low_number
                  args.push_back(*m_lastPSvisited);
                  addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_NUMBER, args, lhsEl->getLineNumber(),lhsEl->getFileName());  
                  checkerHasErrors=TRUE;
                  return;     
                }

                RefCSLOmNumber lhsWidth = CSLOmNumber::cast(lhsWidthParams->begin()->second);
                RefCSLOmNumber rhsWidth = CSLOmNumber::cast(rhsWidthParams->begin()->second);                

                TInt lhsWidthInt = lhsWidth->getValue();
                TInt rhsWidthInt = rhsWidth->getValue();
                
                //if(rhsEl->hasBitRange()){
                //  RefCSLOmSimpleBitRange bitr=rhsEl->getBitRange();
                //  rhsWidthInt=(CSLOmNumber::cast(bitr->getUpper())->getValue()) - (CSLOmNumber::cast(bitr->getLower())->getValue()) +1;
                //}

                if(lhsWidthInt!=rhsWidthInt){
                  args.push_back(intToString(lhsWidthInt));
                  args.push_back(intToString(rhsWidthInt));
                  addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_DIFF_WIDTH, args, lhs->getLineNumber(),lhs->getFileName());
                  checkerHasErrors=TRUE;
                }
              }
              else{ // we have parameters and multiple instances
                //for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=widthParams->begin(); it!=widthParams->end(); it++) {
                //  
                //} 
              }
            }
          }
        }
        else{//rhs does not exist
          args.push_back(*CSLOmExprLink::cast(rhs)->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_OBJ_NOT_EXIST, args, stmtAssign->getLineNumber(),stmtAssign->getFileName());
          checkerHasErrors=TRUE;                                             
        }
      }
      else { //!rhs->isExprLink()
        RefCSLOmExprLink lhsEl=CSLOmExprLink::cast(lhs);
        if((lhsEl->getValue()->isInterface() || lhsEl->getValue()->isSignalGroup()) && 
           (rhs->isConcat() || rhs->isMultiConcat())){
          args.push_back(*lhsEl->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_IFC_ELSE, args, lhs->getLineNumber(),lhs->getFileName());
          checkerHasErrors=TRUE;                                             
        }
        if(rhs->isConcat()){
          m_multipleConcatsInStmtAssign=TRUE;
          //if(stmtAssign->getParent()->isUnitDecl()){
          //  RefCSLOmUnitDecl parent=CSLOmUnitDecl::cast(stmtAssign->getParent());
          //  RefTVec_RefCSLOmBase exprs=CSLOmExprConcat::cast(rhs)->getExprsAsBase();
          //  for(TVec_RefCSLOmBase::iterator i=exprs->begin(); i<exprs->end();i++){
          //    if((*i)->isExprLink()){
          //      RefCSLOmExprLink tempLink=CSLOmExprLink::cast(*i);      
          //      tempLink->doEval();
          //      RefCSLOmConnectable connObj=CSLOmConnectable::cast(tempLink->getValue());
          //      if(connObj->getParentUnit().get()!=parent.get()) {
          //        args.push_back(*convertLink(tempLink));
          //        addErr(NSWarningErr::CSE_CSC_HID_CSE_CSC_HID_ILLEGAL, args, tempLink->getLineNumber(),tempLink->getFileName());
          //        checkerHasErrors=TRUE;                                             
          //      }                                                                    
          //    }
          //  }
          //}
        }
        else if(rhs->isOp()){
        }
      }
    }
    else{//lhs does not exist
      args.push_back(*CSLOmExprLink::cast(lhs)->getName());
      addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_OBJ_NOT_EXIST, args, stmtAssign->getLineNumber(),stmtAssign->getFileName());
      checkerHasErrors=TRUE;                                             
    }
  }
  else { //!lhs->isExprLink()
    if(rhs->isExprLink()){
      RefCSLOmExprLink rhsEl=CSLOmExprLink::cast(rhs);
      RefCSLOmConnectable connObj=CSLOmConnectable::cast(rhsEl->getValue());
      if(!connObj.get()){
        args.push_back(*convertLink(rhsEl));
        args.push_back(*CSLOmIdentifier::cast(stmtAssign->getParent()->getChild(ID))->getName());
        addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, stmtAssign->getLineNumber(),stmtAssign->getFileName());
        checkerHasErrors=TRUE;                                             
        return;
      }
      RefCSLOmUnitDecl rhsParent=connObj->getParentUnit();
      RefCSLOmBase stmtParent=stmtAssign->getParent();
      while(!stmtParent->isUnitDecl()){
        stmtParent=stmtParent->getParent();
      }
      if(rhsParent.get()!=stmtParent.get()){
        args.push_back(*convertLink(rhsEl));
        addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, rhs->getLineNumber(),rhs->getFileName());
        checkerHasErrors=TRUE;
        return;
      }
    }
    if(!lhs->isConcat()){
      addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_LHS_ASSIGN_NOT_OBJECT, args, lhs->getLineNumber(),lhs->getFileName());
      checkerHasErrors=TRUE;
    }
    else{//indeed we have a concat there
      m_lhsAssignStmtConcat=TRUE;
    }
    
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ){
  if(memInfo->getMandatoryCount()!=DCH_MAN_CMD_CNT_MEMORY){
    RefCSLOmExpr expr=RefCSLOmExpr();
    expr=memInfo->getWidth();
    if(CSLOmNumber::cast(expr->doEval())->getValue()==MEM_DEF_WIDTH){
      args.push_back(*CSLOmIdentifier::cast(memInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_MEM_DESIGN_MEMORY_NO_WIDTH, args, 0,memInfo->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
    expr=memInfo->getDepth();
    if(CSLOmNumber::cast(expr->doEval())->getValue()==MEM_DEF_DEPTH){
      args.push_back(*CSLOmIdentifier::cast(memInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_MEM_DESIGN_MEMORY_NO_DEPTH, args, 0,memInfo->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }
}
void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ){
  //mandatory commands
  if(fifoInfo->getMandatoryCount()!=DCH_MAN_CMD_CNT_FIFO){
    if(!fifoInfo->getSetWidth()){
      args.push_back(*CSLOmIdentifier::cast(fifoInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_FIFO_WIDTH, args, 0,fifoInfo->getParent()->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
    if(!fifoInfo->getSetDepth()){
      args.push_back(*CSLOmIdentifier::cast(fifoInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_FIFO_DEPTH, args, 0,fifoInfo->getParent()->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }
}    

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ){
  if(regFileInfo->getMandatoryCount()!=DCH_MAN_CMD_CNT_REG_FILE){
    if(!regFileInfo->getSetWidth()){
      args.push_back(*CSLOmIdentifier::cast(regFileInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_RF_WIDTH, args, 0,regFileInfo->getParent()->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
    if(!regFileInfo->getSetDepth()){
      args.push_back(*CSLOmIdentifier::cast(regFileInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_RF_DEPTH, args, 0,regFileInfo->getParent()->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ){
  //mandatory commands
  if(!regInfo->getMandatoryCount()!=DCH_MAN_CMD_CNT_REGISTER){
    if(!regInfo->getAlreadySetType()){
      args.push_back(*CSLOmIdentifier::cast(regInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_REGISTER_TYPE, args, 0,regInfo->getParent()->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
    if(!regInfo->getSetWidth()){
      args.push_back(*CSLOmIdentifier::cast(regInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_REGISTER_WIDTH, args, 0,regInfo->getParent()->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }

  if(!regInfo->getAlreadySetCntDir() && regInfo->getType()==CSLOmRegDeclInfo::REG_DECL_COUNTER){
    args.push_back(*CSLOmIdentifier::cast(regInfo->getParent()->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_REGISTER_CND_DIR, args, 0,regInfo->getParent()->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  }

  if(regInfo->getType()==CSLOmRegDeclInfo::REG_DECL_COUNTER){
    if(regInfo->getStartValue().get() && regInfo->getEndValue().get()){
      RefTMap_RefCSLOmUnitInstance_RefCSLOmBase startValueParams = regInfo->getStartValue()->doParamEval(regInfo);
      RefTMap_RefCSLOmUnitInstance_RefCSLOmBase endValueParams = regInfo->getEndValue()->doParamEval(regInfo);
      CSLOmRegDeclInfo::ERegDeclCntDir cntDir=regInfo->getCntDir();
    
      RefCSLOmNumber tempStart=RefCSLOmNumber();
      RefCSLOmNumber tempEnd=RefCSLOmNumber();
      ASSERT(startValueParams->size()==endValueParams->size(),"check this");
    
      if(startValueParams->size()==endValueParams->size() && startValueParams->size()==1){
        ASSERT(startValueParams->begin()->second->isNumber(),"not nubmer");
        ASSERT(endValueParams->begin()->second->isNumber(),"not nubmer");
        tempStart=CSLOmNumber::cast(startValueParams->begin()->second);
        tempEnd=CSLOmNumber::cast(endValueParams->begin()->second);
        if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP && tempStart->getValue()>=tempEnd->getValue()){
          args.push_back("bigger");
          addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
          checkerHasErrors = FALSE;
        }
        else if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN && tempStart->getValue()<=tempEnd->getValue()){
          args.push_back("smaller");
          addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
          checkerHasErrors = FALSE;
        }
      }
      else {
        tempStart=CSLOmNumber::cast(startValueParams->begin()->second);
        tempEnd=CSLOmNumber::cast(endValueParams->begin()->second);
        if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP && tempStart->getValue()>=tempEnd->getValue()){
          args.push_back("bigger");
          addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
          checkerHasErrors = FALSE;
        }
        else if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN && tempStart->getValue()<=tempEnd->getValue()){
          args.push_back("smaller");
          addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
          checkerHasErrors = FALSE;
        }
        for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator itStart=startValueParams->begin()++; itStart!=startValueParams->end(); itStart++) {
          tempStart=CSLOmNumber::cast(itStart->second);
          tempEnd=CSLOmExpr::getValueForInstance(itStart->first,endValueParams);
          if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP && tempStart->getValue()>=tempEnd->getValue()){
            args.push_back("bigger");
            addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
            checkerHasErrors = FALSE;
          }
          else if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN && tempStart->getValue()<=tempEnd->getValue()){
            args.push_back("smaller");
            addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
            checkerHasErrors = FALSE;
          }
        }
      }
    }
  }
  else if((!regInfo->getStartValue().get() && regInfo->getEndValue().get()) ||
           (regInfo->getStartValue().get() && !regInfo->getEndValue().get())){
            args.push_back(*CSLOmIdentifier::cast(regInfo->getParent()->getChild(ID))->getName());
            addErr(NSWarningErr::CSE_CSC_SIG_REGISTER_COUNTER_START_END, args, 0,regInfo->getParent()->getFileName());
            checkerHasErrors=TRUE;
            return;
          } 
  
}

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ){
  m_testbenchesInWholeDesignCount++;
  
  m_insideTestbench=TRUE;


  //clock in the dut needs to be the same as the clock in the testbench
  //  TBool clockFound=FALSE;
  RefCSLOmSignal clockSignal=tbInfo->getClockSignal();
  if(clockSignal.get()){      
    RefString clockName=CSLOmIdentifier::cast(clockSignal->getChild(ID))->getName();
    m_tbClockName=clockName;
    if(m_dutNames.get()){
      TInt clockNameCounter=-1;
      TBool found=FALSE;
      for(TUInt i=0; i<m_dutNames->size(); ++i){
        found=FALSE;
        for(TUInt j=0;j<m_dutClockCount->at(i); ++j){
          clockNameCounter++;
          if(!clockName->compare(*m_dutClockNames->at(clockNameCounter))){
            found=TRUE;
          }
        }
        if(!found){
          args.push_back(*CSLOmIdentifier::cast(tbInfo->getParent()->getChild(ID))->getName());
          args.push_back(*m_dutNames->at(i));
          addErr(NSWarningErr::DEE_CSA_TBCD_DESIGN_TB_DUT_CLOCK_NAMES, args, 0,tbInfo->getParent()->getFileName(),FALSE,TRUE);
          checkerHasErrors=TRUE;
        }
      }
    }
  }
  else{
    args.push_back(*CSLOmIdentifier::cast(tbInfo->getParent()->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_TBCD_DESIGN_NO_TESTBENCH_CLOCK, args, 0,tbInfo->getParent()->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  } 
}
     

void CSLOmDesignChecker::beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ){
  m_vectorsInWholeDesignCount++;
  if(vectorInfo->getStimulusElseExpected()){
    m_stimCount++;
  }
  else{
    m_expectCount++;
  }
  RefCSLOmExprLink mName = vectorInfo->getModuleName();
  if(mName.get()){
    RefCSLOmBase dutBase = mName->doEval();
    ASSERT(dutBase.get(),"dut does not evaluate to anything");
    RefCSLOmUnitDecl dut = CSLOmUnitDecl::cast(dutBase);
    ASSERT(dut.get(),"dut does not evaluate to anything");
    if(!dut->isDUT()){
      //CHANGE ERROR vector is associated to a dut that is not instantiated in a testbench
      args.push_back(*(CSLOmIdentifier::cast(vectorInfo->getParent()->getChild(ID)))->getName());
      addErr(NSWarningErr::DEE_CSA_VEC_DESIGN_NO_VECTOR_UNIT, args, 0,vectorInfo->getParent()->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }
  if(vectorInfo->getMandatoryCount()!=DCH_MAN_CMD_CNT_VECTOR){
    if(!mName.get()){
      args.push_back(*(CSLOmIdentifier::cast(vectorInfo->getParent()->getChild(ID)))->getName());
      addErr(NSWarningErr::DEE_CSA_VEC_DESIGN_NO_VECTOR_UNIT, args, 0,vectorInfo->getParent()->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
    if(vectorInfo->getDirection()==DIR_UNDEFINED){
      args.push_back(*(CSLOmIdentifier::cast(vectorInfo->getParent()->getChild(ID)))->getName());
      addErr(NSWarningErr::DEE_CSA_VEC_DESIGN_NO_VECTOR_DIRECTION, args,0,vectorInfo->getParent()->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }
  RefTVec_RefCSLOmExprLink ass_ports=vectorInfo->getAssociatedPorts();
  if(ass_ports.get() && ass_ports->size()){
    for(TUInt i=0; i<ass_ports->size();++i){
      m_assPorts->push_back(ass_ports->at(i));
      m_assVectors->push_back(vectorInfo);
    }        
  }
}    


void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ){}

void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmList                            & list                            ){}  
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ){}
//void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmField                           & field                           ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ){}

void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ){}

void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ){
  m_isaElemWait=TRUE;
}

void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ){
  m_lhsConcatAssignVisited=TRUE;
}

void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ){}    
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ){}
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ){}    
void CSLOmDesignChecker::inTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ){}    


void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ){
  //multiple isa elements of root type
  if(m_isaElemRootCount>1){
    checkerHasErrors=TRUE;
  }
  
  if(m_memoryMapPresent && m_memMapPagesCount==0){
    addErr(NSWarningErr::DEE_CSA_MMP_DESIGN_MEM_MAP_NO_PAGES, args, 0, RefString(new std::string("NULL")), FALSE,TRUE);
    checkerHasErrors=TRUE;
  }
  //  clock does not need to be associated to the vectors... any vectors
  RefCSLOmBase tempPortBase;
  RefCSLOmPortDecl tempPort;
  RefCSLOmVectorInfo tempvc;
  if(m_testbenchesInWholeDesignCount>0){
    if(m_tbClockName.get() && m_assPorts.get()){
      for(TUInt i=0; i<m_assPorts->size(); ++i){
        tempPortBase=m_assPorts->at(i)->doEval();
        tempPort=CSLOmPortDecl::cast(tempPortBase);
        tempvc=CSLOmVectorInfo::cast(m_assVectors->at(i));
        for(TUInt j=0;j<tempvc->m_ports->size();++j){
          RefString name=tempvc->m_ports->at(j)->getName();
          if((name)->compare(*m_tbClockName)==0){
            tempvc->m_portMask->at(j)=FALSE;
          }  
        }
      }
    }
  }
}

void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ){
  m_connectedSignals->empty();

  if(m_insideTestbench){
    m_insideTestbench=FALSE;
    if(m_unitInstancesCount<1){
      args.push_back(*CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_TBCD_DESIGN_NO_TESTBENCH_UNITS_INSTANCIATED, args, 0,unitDecl->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
  }
}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ){

}

void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ){
  m_multipleConcatsInStmtAssign=FALSE;
  m_insideFormalToActual=FALSE;
}

void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ){
  m_insideIfc=FALSE;
}

void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ){

}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            ){}  
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmSetCommand                      & setCommand                      ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ){}
//void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmField                           & field                           ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ){}

void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ){
  //flags
  //hierarhical widths checks
  if(isaField->isHierarchical()){
    RefCSLOmExpr expr=isaField->getWidth();
    TInt currentWidth = CSLOmNumber::cast(expr->doEval())->getValue();
    TInt addedWidths = m_isaFieldHierSizes->back();
    if(currentWidth < addedWidths){
      args.push_back(*CSLOmIdentifier::cast(isaField->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_HIERC_WIDTH, args, 0,isaField->getFileName(),FALSE,TRUE);
      checkerHasErrors=TRUE;
    }
    m_isaFieldHierSizes->pop_back();
  }

  //field positions check
  RefCSLOmExpr expr=RefCSLOmExpr();
  if(m_insideIsaElement){
    RefCSLOmExpr expr=isaField->getUpper();
    TInt number=CSLOmNumber::cast(expr->doEval())->getValue();
    if(isaField->isHierarchical()){}
    else if(isaField->isWithEnumItem()){
      if(m_currentPosition+number<m_currentEnumItemFieldPosition){
        m_currentEnumItemFieldPosition=m_currentPosition+number;
        m_enumItemFieldName=CSLOmIdentifier::cast(isaField->getChild(ID))->getName();
      }
    }
    else{
      if(m_currentPosition+number>m_currentNormalFieldPosition){
        m_currentNormalFieldPosition=m_currentPosition+number;
        m_normalFieldName=CSLOmIdentifier::cast(isaField->getChild(ID))->getName();
      }
    }
  }
  if(isaField->getParent()->isIsaField()){
    m_currentPosition-=CSLOmIsaField::cast(isaField->getParent())->getFieldPosition(isaField);
  }
  else if(isaField->getParent()->isIsaElement()){
    m_currentPosition-=CSLOmIsaElement::cast(isaField->getParent())->getFieldPosition(isaField);
  }
  
  //gaps in isa field positions
  if(isaField->isHierarchical() && m_insideIsaElement){
    TBool nullFlag=FALSE;
    RefTVec_RefCSLOmField fields=isaField->getFieldPositions();
    if(fields.get()){
      for(TVec_RefCSLOmField::iterator i=fields->begin(); i<fields->end(); ++i){
        if(!(*i).get()){
          nullFlag=TRUE;
        }
        else{ //this is to populate the vector for isa prefix check
          if((*i)->isWithEnumItem()){
            m_curInstrFields->push_back(*i);
          }
        }
        if((*i).get() && (*i)->isWithEnumItem() && nullFlag){
          args.push_back(*CSLOmIdentifier::cast((*i)->getChild(ID))->getName());
          args.push_back(*CSLOmIdentifier::cast((*i)->getEnumItem())->getName());
          addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_FIELD_EMPTY_BEFORE_ENUM, args, 0,(*i)->getFileName(),FALSE,TRUE);
          checkerHasErrors=TRUE;
          break;
        }
      }
    }
  }//again populating the vector for the isa prefix check
  if(!isaField->isHierarchical() && m_insideIsaElement){
    if(isaField->isWithEnumItem()){
      m_curInstrFields->push_back(isaField);
    }
  }
  m_insideIsaField=FALSE;
}

void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ){
  if(isaElement->getIsaType()==NSCSLOm::CSLOmIsaElement::ISA_ELEM_INSTR){
    m_insideIsaElemInstr=FALSE;
  }

  //hier widths
  RefCSLOmExpr expr=isaElement->getWidth();
  TInt currentWidth = CSLOmNumber::cast(expr->doEval())->getValue();
  if(currentWidth<m_isaElemHierAddedWidths){
    args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_HIERC_WIDTH, args, 0,isaElement->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  }

  //field associated enum
  TBool matchFound;
  RefTVec_RefCSLOmIdentifier registeredEnums=isaElement->getRegisteredEnums();
  RefTVec_RefCSLOmIdentifier registeredEnumItems=isaElement->getRegisteredEnumItems();

  if(registeredEnums.get() && registeredEnumItems.get()){
    for(int i=0; i<registeredEnums->size(); ++i){
      matchFound=FALSE;
      RefString iterationName = registeredEnums->at(i)->getName();
      for(int it=0; it<registeredEnumItems->size(); ++it){
        RefString currentName = registeredEnumItems->at(it)->getName();
        if(currentName->compare(*iterationName)==0){
          matchFound=TRUE;
          break;
        }
      }
      if(!matchFound){
        args.push_back(*iterationName);
        addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_ENUM_ITEM_IMPLEMENT, args, 0,isaElement->getFileName(),FALSE,TRUE);
        checkerHasErrors=TRUE;
      }
    }
  }
  
  //field positions
  if(m_currentEnumItemFieldPosition<m_currentNormalFieldPosition){
    args.push_back(*m_enumItemFieldName);
    args.push_back(*m_normalFieldName);
    addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_FIELD_POS, args, 0,isaElement->getFileName(),FALSE,TRUE);
    checkerHasErrors=TRUE;
  }


  //isa prefix check
  if(isaElement->getIsaType()==NSCSLOm::CSLOmIsaElement::ISA_ELEM_INSTR){
    RefCSLOmNumber width;
    RefCSLOmExpr expr=RefCSLOmExpr();
    RefCSLOmIdentifier enumItem;
    RefCSLOmIsaPrefixTree currentItem=m_isaPrefixTree;
    TInt enumItemValue;
    RefString instrValue=RefString(new std::string(""));
    for(TVec_RefCSLOmField::iterator i=m_curInstrFields->begin(); i!=m_curInstrFields->end(); ++i){
      expr=(*i)->getWidth();
      width=CSLOmNumber::cast(expr->doEval());
      enumItem=CSLOmIdentifier::cast((*i)->getEnumItem());
      RefCSLOmExpr enumExpr=CSLOmExpr::cast(enumItem->getPayload());
      enumItemValue=CSLOmNumber::cast(enumExpr->doEval())->getValue();
      RefTVec_TBool binaryEnumItem=RefTVec_TBool(new TVec_TBool());
      for(TUInt it=0; it<width->getValue(); ++it){
        if(enumItemValue){
          if(1&enumItemValue){
            binaryEnumItem->push_back(TRUE);
            enumItemValue=enumItemValue>>1;
          }
          else{
            binaryEnumItem->push_back(FALSE);
            enumItemValue=enumItemValue>>1;
          }
        }
        else{
          binaryEnumItem->push_back(FALSE);        
        }
      }
      //creating a string with the instr value for error throwing and debugging
      for(TVec_TBool::reverse_iterator it2=binaryEnumItem->rbegin(); it2<binaryEnumItem->rend(); it2++){
        if(*it2){
          instrValue->append("1");
        } 
        else{
          instrValue->append("0");
        }
      }
      //making the actual check
      for(TVec_TBool::reverse_iterator it=binaryEnumItem->rbegin(); it<binaryEnumItem->rend(); it++){
        if((*it)){
          if(m_prefixTreeHasAtleastOneInstr && currentItem->m_rightChild.get() && currentItem->m_rightChild->isLeaf()){
            if(m_rootFormatWidth>instrValue->size()){
              TUInt difference=m_rootFormatWidth-instrValue->size();
              for(TUInt i=0; i<difference; ++i){
                instrValue->append("X");
              }
            }
            args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
            args.push_back(*instrValue);
            args.push_back(*currentItem->m_instrName);
            addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_INSTR_ALREADY_DEFINED, args, 0,isaElement->getFileName(),FALSE,TRUE);
            checkerHasErrors=TRUE;   
          }
          else if(!currentItem->m_rightChild.get()){
            currentItem->addChild(TRUE,CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
            currentItem=currentItem->m_rightChild;
          }
          else{
            currentItem=currentItem->m_rightChild;
          }
        }
        else{
          if(m_prefixTreeHasAtleastOneInstr && currentItem->m_leftChild.get() && currentItem->m_leftChild->isLeaf()){
            if(m_rootFormatWidth>instrValue->size()){
              TUInt difference=m_rootFormatWidth-instrValue->size();
              for(TUInt i=0; i<difference; ++i){
                instrValue->append("X");
              }
            }
            args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
            args.push_back(*instrValue);
            args.push_back(*currentItem->m_instrName);            
            addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_INSTR_ALREADY_DEFINED, args, 0,isaElement->getFileName(),FALSE,TRUE);
            checkerHasErrors=TRUE;   
          }
          else if(!currentItem->m_leftChild.get()){
            currentItem->addChild(FALSE,CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
            currentItem=currentItem->m_leftChild;
          }
          else{
            currentItem=currentItem->m_leftChild;
          }
        } 
      }
    }
    m_prefixIsaInstrNo++;
    if(!m_prefixTreeHasAtleastOneInstr){
      m_prefixTreeHasAtleastOneInstr=TRUE;
    }
  }

  m_insideIsaElement=FALSE;
}

void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ){
  if(m_lhsAssignStmtConcat){
    RefCSLOmExpr lhs=stmtAssign->getLHS();
    RefCSLOmExpr rhs=stmtAssign->getRHS();
  
    if(stmtAssign->getParent()->isUnitDecl()){
      RefCSLOmScope scope = CSLOmUnitDecl::cast(stmtAssign->getParent())->getAttachedScope();
      RefCSLOmBase lhsEvaled=lhs->doEval();
      RefCSLOmBase rhsEvaled=rhs->doEval();
    }
    
    if(lhs->isExprLink() && !CSLOmExprLink::cast(lhs)->getValue().get()){       
      RefCSLOmExprLink lhsEl=CSLOmExprLink::cast(lhs);
      args.push_back(*convertLink(lhsEl));
      args.push_back(*CSLOmIdentifier::cast(stmtAssign->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, stmtAssign->getLineNumber(),stmtAssign->getFileName());
      checkerHasErrors=TRUE;                                             
      return;
    }
    if(rhs->isExprLink() && !CSLOmExprLink::cast(rhs)->getValue().get()){
      RefCSLOmExprLink rhsEl=CSLOmExprLink::cast(rhs);
      args.push_back(*convertLink(rhsEl));
      args.push_back(*CSLOmIdentifier::cast(stmtAssign->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, stmtAssign->getLineNumber(),stmtAssign->getFileName());
      checkerHasErrors=TRUE;                                             
      return;
    }
  
    TInt rhsAssignAddedWidths=rhs->getWidth();
    TInt lhsAssignAddedWidths=lhs->getWidth();
  
    if(rhsAssignAddedWidths!=lhsAssignAddedWidths){
      args.push_back(intToString(lhsAssignAddedWidths));
      args.push_back(intToString(rhsAssignAddedWidths));
      addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_DIFF_WIDTH, args, lhs->getLineNumber(),lhs->getFileName());
      checkerHasErrors=TRUE;
    }
  }

  CSLOmScopeBlock::exitScope();
  m_insideAssignStmt=FALSE;
}

void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ){}    
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ){}
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ){}    
void CSLOmDesignChecker::afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ){}    

}//end of namespace

