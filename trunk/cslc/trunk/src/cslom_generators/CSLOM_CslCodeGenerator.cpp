//---------------------------------------------------------------------
// Copyright (c) 2010 Fastpathlogic
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

//Author: MonicaS
//Data : October, 2010

#include "CSLOM_CslCodeGenerator.h"
#include <cmath>
#include <cstdlib>
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include "../support/ErrorAPI.h"
#include "../support/CommonSupport.h"
#include "../cslom/CSLOM_cmd.h"

#include <fstream>
#include <iostream>
#include <string>


TBool cslomCslCodeGeneratorHasErrors = FALSE;

using namespace NSCSLOm;
using namespace std;
using namespace tmpl;

namespace NSCSLOmCslCodeGenerator {

//------------------ create a template object--------------------------//
  string path = getenv("WORK");
  html_template templ(path + "/trunk/templates/csl_templates/cslCodeTemplate.tmpl"); 
  row_t row;
  loop_t unit_predecl_loop;
  loop_t br_loop;
  TBool has_br = false;
  loop_t sg_loop;
  TBool has_sg= false;
  TBool sg_has_signals = false;
  TBool has_unit; 
  TBool sg_has_stype;
  TBool sg_has_swidth;
  TBool has_ifc = false;
  TBool ifc_has_ports;
  loop_t ifc_loop;
  TBool flag = FALSE;
  TBool ifc_has_type, ifc_has_width;
  int cnt=0;
  loop_t unit_list;
  TBool has_ptype, has_pwidth;
  TBool unit_has_ports;
  loop_t sig_list;
  TBool unit_has_signals,has_stype,has_swidth;
  TBool has_sg_inst = false;
  TBool has_ifc_inst= false;
  TBool has_unit_inst = false;
  TBool has_assignStmt= false;
  TBool has_opExpr= false;
  TBool has_concatRhs = false;
  TBool has_replicRhs = false;

//------------------------------------------------------------------//

// ********************************************
// Get csl filename
// ********************************************
  
//dec to binary converter function
std::string dec2Bin(TInt value, TInt size) {

  std::string sOut;
  TInt temp;
  char b;

  for(TInt i = 0; i < size; i++){
    temp = value / 2;
    if(temp >= 0){
      b=48+(value % 2);
      sOut+=b;
      value = temp;
    } 
    else{
      sOut+='0';
    }
  }
  return sOut;
}
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
// CSLOmCslCodeGenerator class
// ********************************************

CSLOmCslCodeGenerator::CSLOmCslCodeGenerator(string outputPath):
  m_outputPath(outputPath),
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
  vCnt =0;

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
 

  string outPath = m_outputPath;
  int index = outPath.find("/verilog/");
  m_cslPath = outPath.erase(index) + "/csl/";
  m_cslName = "cslCode.gen.csl";

 //generated csl file_name
  if(!m_cslName.empty() && !m_cslPath.empty()){
    csl_file_name = m_cslPath + m_cslName;
    file_name= csl_file_name.c_str();
    cslCode.open(file_name, ios::trunc);
    cslCode.open(file_name, ios::in);
    
    cout << ".........The csl file is created: " << file_name << "\n";
    }
   else { cout << "NO csl file is generated!!!" << endl;  }
  
}

void  CSLOmCslCodeGenerator::checkConcatForObjects(RefCSLOmExprConcat concat){
  
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

void CSLOmCslCodeGenerator::formal2ActualConcatReplicationCheck(RefCSLOmExprLink formal, RefCSLOmExpr actual, RefCSLOmUnitDecl formalUnit, RefCSLOmUnitDecl actualUnit){
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
    cslomCslCodeGeneratorHasErrors=TRUE;
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
      cslomCslCodeGeneratorHasErrors=TRUE;                                             
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
        cslomCslCodeGeneratorHasErrors=TRUE;
        objConcatOk=FALSE;
      }
      else{
        RefCSLOmConnectable connObj=CSLOmConnectable::cast(expr->getValue());
        if(connObj->getParentUnit().get()!=actualUnit.get()) {
          args.push_back(*convertLink(expr));
          addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, actual->getLineNumber(),actual->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;                                             
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
  //  cslomTestbenchGeneratorHasErrors=TRUE;                                             
  //}

  if(formalWidth==-1){
    addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONCAT_OBJ_NOT_EXIST, args, it1->getLineNumber(),it1->getFileName());
    cslomCslCodeGeneratorHasErrors=TRUE;                                             
  }
  if(actualWidth==-1){
    addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONCAT_OBJ_NOT_EXIST, args, it2->getLineNumber(),it2->getFileName());
    cslomCslCodeGeneratorHasErrors=TRUE;                                             
  }

  if(actualWidth!=formalWidth){
    args.push_back(*it1->getName());
    args.push_back(intToString(formalWidth));
    args.push_back(intToString(actualWidth));
    addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_PIFC_CR, args, it1->getLineNumber(),it1->getFileName());
    cslomCslCodeGeneratorHasErrors=TRUE;                                             
  } 
}  

void CSLOmCslCodeGenerator::checkIfc2IfcOrSgf2a(NSCSLOm::RefCSLOmExprLink first, NSCSLOm::RefCSLOmExprLink second, NSCSLOm::RefCSLOmUnitDecl firstUnit, NSCSLOm::RefCSLOmUnitDecl secondUnit){

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
            cslomCslCodeGeneratorHasErrors=TRUE;
          }
          if(firstAllPorts->at(i)->getPortDirection()!=secondAllPorts->at(i)->getPortDirection()){
            args.push_back(*CSLOmIdentifier::cast(firstAllPorts->at(i)->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(secondAllPorts->at(i)->getChild(ID))->getName());
            addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_P_P_CONECTION_DIFF_DIR, args, first->getLineNumber(),first->getFileName());
            cslomCslCodeGeneratorHasErrors=TRUE;
          }
          pName=CSLOmIdentifier::cast(firstAllPorts->at(i)->getChild(ID))->getName();
          sName=CSLOmIdentifier::cast(secondAllPorts->at(i)->getChild(ID))->getName();
          if(pName->compare(*sName)){
            args.push_back(*CSLOmIdentifier::cast(firstIfc->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(secondIfc->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(firstAllPorts->at(i)->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(secondAllPorts->at(i)->getChild(ID))->getName());
            addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_IFC_SG_NAMES, args, first->getLineNumber(),first->getFileName(),FALSE,TRUE);
            //cslomTestbenchGeneratorHasErrors=TRUE;
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
            cslomCslCodeGeneratorHasErrors=TRUE;
          }
          pName=CSLOmIdentifier::cast(allPorts->at(i)->getChild(ID))->getName();
          sName=CSLOmIdentifier::cast(allSigs->at(i)->getChild(ID))->getName();
          if(pName->compare(*sName)){
            args.push_back(*CSLOmIdentifier::cast(firstIfc->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(sg->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(allPorts->at(i)->getChild(ID))->getName());
            args.push_back(*CSLOmIdentifier::cast(allSigs->at(i)->getChild(ID))->getName());
            addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_IFC_SG_NAMES, args, first->getLineNumber(),first->getFileName(),FALSE,TRUE);
            //cslomTestbenchGeneratorHasErrors=TRUE;
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
            cslomCslCodeGeneratorHasErrors=TRUE;
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

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      ){}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmDesign      & design      ){
 
  //unitPortDeclMap = RefTMap_RefString_RefTMap (new TMap_RefString_RefTMap());  // unit with ports list map
  //unitSigDeclMap = RefTMap_RefString_RefTMap (new TMap_RefString_RefTMap());  // unit with signals list map
  // unitDeclInstMap = RefTMap_RefString_RefTMap (new TMap_RefString_RefTMap());  // unit instances list map
  //unitDeclInstNameMap = RefTMap_RefString_RefTMap_RefString (new TMap_RefString_RefTMap_RefString());

  //unitDeclInstF2aMap = RefTMap_RefString_RefTMap_RefString (new TMap_RefString_RefTMap_RefString());  // unit instances with F2A  map

  //unitDeclAssignStmt = RefTMap_RefString_RefTMap_RefString(new TMap_RefString_RefTMap_RefString());  //unit decl with assign stmts
  // unitDeclOpExpr=RefTMap_RefString_RefTMap(new TMap_RefString_RefTMap());   //op expr in units
  //unitDeclConcat=RefTMap_RefString_RefTMap(new TMap_RefString_RefTMap());   //concatenation in units
  //unitDeclReplic = RefTMap_RefString_RefTMap(new TMap_RefString_RefTMap());   // replication in units
  // unitIfcInstMap = RefTMap_RefString_RefTMap_RefString(new TMap_RefString_RefTMap_RefString());
  // ifcPortDeclMap = RefTMap_RefString_RefTMap (new TMap_RefString_RefTMap());  // ifc with ports list map
  // unitSgInstMap = RefTMap_RefString_RefTMap_RefString(new TMap_RefString_RefTMap_RefString()); // sg instances
  //sgSigDeclMap = RefTMap_RefString_RefTMap (new TMap_RefString_RefTMap());  // sg with signals list map

  vectorsMap = RefTMap_RefString_RefTMap(new TMap_RefString_RefTMap());   //TB vectors map
  vecList = RefTVec_RefMap(new TVec_RefMap);

  vecData = RefTVec_RefString(new TVec_RefString);
  dutName_dutClk = RefTMap_RefString(new TMap_RefString());

  //replicAssStmtMap = RefTMap_RefString_RefTVec(new TMap_RefString_RefTVec());
  unitDeclAttrMap = RefTMap_RefString_RefTMap_RefString(new TMap_RefString_RefTMap_RefString());

  // unitInstMap = RefTMap_RefString_RefTMap_RefString(new TMap_RefString_RefTMap_RefString()); //unit inst with F2a
    cnt =0;
 }
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ){
 
 
  //---------------MS added--------------------------------
  RefCSLOmBase parent = id->getParent();
  RefString name = RefString(new std::string (*id->getName()));
  // cout << "ID=" << *name << endl;
  

if(parent->getType() == TYPE_CONNECTABLE){
 
 }
   
  if(parent->getType() == TYPE_INST_UNIT){
   
      //--------------templates input----------------------
    if(tbName.get()){                              //dut instances in TB
      dutInstName = name;
      dutInstNameVec.push_back(dutInstName);       //for multiple testbences  

      if(m_DutName.get() && dutInstName.get()){
	dutName_dutInst->insert(make_pair(m_DutName,dutInstName));

      }
    }
  }
 
  if(parent->getType() == TYPE_DECL_UNIT){
    if(!parent->isTestBench() && !parent->isVerifComp()){
      unitVec.push_back(name);
     
    }
   
  }
  if(parent->isTestBench()){ 
      tbName = name;
      
  } 


 }
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ){
  
  //part select
  if((exprLink->hasBitRange() && m_insideAssignStmt) || 
     (exprLink->hasBitRange() && m_insideFormalToActual)){
   
    exprLink->doEval();
    if(!exprLink->getValue().get()){
      args.push_back(*exprLink->getName());
      addErr(NSWarningErr::CSE_CSC_SIG_ASSIGN_PART_SELECT_NOT_EVAL, args, exprLink->getLineNumber(),exprLink->getFileName());
      cslomCslCodeGeneratorHasErrors=TRUE;
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
      //RefString pName = CSLOmParameter::cast(elUpper)->getName();
      //std::cout << "Param name = " << *pName << std::endl;

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
          cslomCslCodeGeneratorHasErrors=TRUE;
        }
        else{
          args.push_back(intToString(elUpperNo->getValue()));
          args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_UPPER_NOT_INST, args, exprLink->getLineNumber(),exprLink->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;
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
          cslomCslCodeGeneratorHasErrors=TRUE;
        }
        else{
          args.push_back(intToString(elLowerNo->getValue()));
          args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_LOWER_NOT_INST, args, exprLink->getLineNumber(),exprLink->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;
        }
      }
    }
  }
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ){
  m_unitInstancesCount=0;
  //-----for template------------//
  has_unit = true;
  templ("has_unit") = has_unit;
  has_unit_inst = false;
  // loop_t unit_f2a_inst_loop;
  //-----------------------------//
  portDataMap = RefTMap_RefString_RefTVec (new TMap_RefString_RefTVec());   //port list map
  sigDataMap = RefTMap_RefString_RefTVec (new TMap_RefString_RefTVec());   //signal list map
  tbSigDataMap = RefTMap_RefString_RefTVec (new TMap_RefString_RefTVec());   //signal list map in TB
  // unitInstDataMap = RefTMap_RefString_RefTVec (new TMap_RefString_RefTVec());   //unit inst  map
  unitInstF2aMap = RefTMap_RefString (new TMap_RefString());

  simpleAssignStmt = RefTMap_RefString (new TMap_RefString());
  opExprAssStmtMap = RefTMap_RefString_RefTVec(new TMap_RefString_RefTVec());
  concatAssStmtMap = RefTMap_RefString_RefTVec(new TMap_RefString_RefTVec());

  replicAssStmtMap = RefTMap_RefString_RefTVec(new TMap_RefString_RefTVec());
  

  ifcInstMap = RefTMap_RefString (new TMap_RefString());  // ifc instances map
  sgInstMap = RefTMap_RefString (new TMap_RefString());  // sg instances map
  // unitInstVec = RefTVec_RefString(new TVec_RefString);   //unit inst vec
  //unitNameInstMap = RefTMap_RefString (new TMap_RefString());
  unitInstMap = RefTMap_RefString_RefTMap_RefString(new TMap_RefString_RefTMap_RefString()); //unit inst with F2a

  if(attributeMap.get()){
    attributeMap.reset();
  }
  attributeMap = RefTMap_RefString(new TMap_RefString());          // contains port_name and the attribute
  //opExprVec =  RefTVec_RefString(new TVec_RefString);
  unitName =CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName();
  row("unit_name")= *unitName;
	
  //predefined but not declared
  if(!unitDecl->isDefined()){
    args.push_back(*CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName());
    addErr(NSWarningErr::CSE_CSA_ASE_DESIGN_NOT_DECLARED, args,unitDecl->getLineNumber(),unitDecl->getFileName());
    cslomCslCodeGeneratorHasErrors=TRUE;
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
  
   
    //-------------cleare the port list--------- 
    if( !inPortWidthVec.empty()){
      inPortWidthVec.clear();
    }
    if( !outPortWidthVec.empty()){
      outPortWidthVec.clear();
    }
    //-------------------------------------------

    //checking if a dut has atleast a stimulus and an expected vector
    if(stimNo==0){
      args.push_back(*(CSLOmIdentifier::cast(unitDecl->getChild(ID)))->getName());
      addErr(NSWarningErr::DEE_CSA_VEC_DESIGN_NO_STIM_VECT, args, 0,unitDecl->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  
    if(expectNo==0){
      args.push_back(*(CSLOmIdentifier::cast(unitDecl->getChild(ID)))->getName());
      addErr(NSWarningErr::DEE_CSA_VEC_DESIGN_NO_EXPECT_VECT, args, 0,unitDecl->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  
    //CLOCK: needs to have atleast an input port with clock attribute
    if(!(unitDecl->isTestBench()) && !(unitDecl->isVerifComp()) && !(unitDecl->isRegister())
       && !(unitDecl->isMemory()) && !(unitDecl->isFifo()) && !(unitDecl->isRegisterFile())){
      

      TBool clockForThisUnit=FALSE;
      TInt clockCount=0;
      RefTVec_RefCSLOmPortDecl ports= unitDecl->getPortListFull();
           
      if(ports.get()){
        for(TUInt i=0;i<ports->size();++i){
	 
          if(ports->at(i)->getAttr()==ATTR_CLK && ports->at(i)->getPortDirection()==INPUT){
            clockForThisUnit=TRUE;
            m_dutClockNames->push_back(CSLOmIdentifier::cast(ports->at(i)->getChild(ID))->getName());
	    dutClk = (CSLOmIdentifier::cast(ports->at(i)->getChild(ID))->getName());
	    // cout << "clk name =" << *dutClk <<endl;
            clockCount++;
          }
        }
        //this is part of the same name check for the link between testbench and dut's
        m_dutNames->push_back(CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName());
	m_DutName = CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName();
        m_dutClockCount->push_back(clockCount);
	if(m_DutName.get() && dutClk.get()){
	  dutName_dutClk->insert(make_pair(m_DutName,dutClk));
	  // cout << "dut name =" << *m_DutName << endl;
	  //cout << "clk name=" << *dutClk << endl;
	}
      }
 
      //throwing the error if needed
      if(!clockForThisUnit){
        args.push_back(*(CSLOmIdentifier::cast(unitDecl->getChild(ID)))->getName());
        addErr(NSWarningErr::DEE_CSA_MOD_DESIGN_NO_UNIT_CLOCK, args, 0,unitDecl->getFileName(),FALSE,TRUE);
        cslomCslCodeGeneratorHasErrors=TRUE;
      }
    }
  }  

  if(unitDecl->isTopUnit()){
    // m_cslName = *CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName() + ".gen.csl";
       // cout << "CSLCode name =" << m_cslName << endl;


      
  }

}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                  ){

  sigDataVec =  RefTVec_RefString(new TVec_RefString());
  tbSigDataVec =  RefTVec_RefString(new TVec_RefString());
  sgSigDataVec =  RefTVec_RefString(new TVec_RefString());

  m_lastPSvisited=CSLOmIdentifier::cast(signal->getChild(ID))->getName();

  RefCSLOmBase parent = (signal->getParent());
 
  std::ostringstream osstream;
  ECSLOmSignalType sigType = signal->getSignalType();
  string type;
  RefString sType;
  RefString attr;
  
  //cout << "signal name=" << *m_lastPSvisited << endl;

  sigName = m_lastPSvisited;

 if( parent->isSignalGroup()){
   sg_has_signals = true;
   row("sg_has_signals") = sg_has_signals;
 
  }
 else {
   unit_has_signals = true;
 }

  if(signal->getSignalAttr()){
    if(signal->getSignalAttr()==NSCSLOm::ATTR_CLK){
      attr =RefString(new string("clock"));
      attributeMap->insert(make_pair(sigName,attr));
    } 
    if(signal->getSignalAttr()==NSCSLOm::ATTR_EN){
      attr =RefString(new string("en"));
      attributeMap->insert(make_pair(sigName,attr));
    }
    if(signal->getSignalAttr()==NSCSLOm::ATTR_STALL){
      attr =RefString(new string("stall"));
      attributeMap->insert(make_pair(sigName,attr));
    }
    if(signal->getSignalAttr()==NSCSLOm::ATTR_DEC){
      attr =RefString(new string("decode"));
      attributeMap->insert(make_pair(sigName,attr));
    }
    if(signal->getSignalAttr()==NSCSLOm::ATTR_RST){
      attr =RefString(new string("reset"));
      attributeMap->insert(make_pair(sigName,attr));
    }
  }
 

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
        cslomCslCodeGeneratorHasErrors=TRUE;
      }
    }
  }
  else{
   
  }

 RefTMap_RefCSLOmUnitInstance_RefCSLOmBase widthParams = signal->getWidth()->doParamEval(signal);
    for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it=widthParams->begin(); it!=widthParams->end(); it++) {
      if(!it->second->isNumber()){
        //add error
        return;
      }
      RefCSLOmNumber width=CSLOmNumber::cast(it->second);

      osstream << width->getValue();
      string sigW= osstream.str();
     
      RefString sigWidth = RefString(new string(sigW));
     
      RefString swidth = RefString(new string("1"));

 if( !parent->isSignalGroup()){     
      if(sigWidth.get()){
       
	sigDataVec->push_back(sigWidth);
      }
     else { 
       sigDataVec->push_back(swidth);
     }
    
      //------signals fron TB---//
    if(parent->isTestBench()){
      if(sigWidth.get()){
	
	tbSigDataVec->push_back(sigWidth);
      }
      else { tbSigDataVec->push_back(swidth);}
    }
 }
 else {           //is signal group
   if(sigWidth.get()){
     sg_has_swidth = true;
     sgSigDataVec->push_back(sigWidth);
    
      }
     else { 
       sg_has_swidth = false;
       sgSigDataVec->push_back(swidth);
    
     }
    
      //------signals fron TB---//
    if(parent->isTestBench()){
      if(sigWidth.get()){
	
	tbSigDataVec->push_back(sigWidth);
      }
      else { tbSigDataVec->push_back(swidth);}
    }
 }
    //--------------------------//
   
}

if(sigType){
  switch(sigType){
    case (SIGNAL_REG):  type = "reg"        ; break;
    case (SIGNAL_WIRE): type = "wire"       ; break;
    case (SIGNAL_TRI):     type =  "tri"         ; break;
    case (SIGNAL_TRIREG):  type =  "trireg"      ; break;
    case (SIGNAL_WOR):     type =  "wor"         ; break;
    case (SIGNAL_WAND):    type =  "wand"        ; break;
    case (SIGNAL_TRIOR):   type = "trior"        ; break;
    case (SIGNAL_TRI0):    type = "tri0"         ; break;
    case (SIGNAL_TRI1):    type = "tri1"         ; break;
    case (SIGNAL_TRIAND):  type ="triand"        ; break;
    case (SIGNAL_SUPPLY_0):     type = "supply0"; break;
    case (SIGNAL_SUPPLY_1):     type = "supply1"; break;
    case (SIGNAL_VAR_INTEGER):  type = "integer" ; break;
    case (SIGNAL_VAR_REAL):     type = "real"    ; break;
    case (SIGNAL_VAR_REALTIME): type = "realtime"; break;
    case (SIGNAL_VAR_TIME):     type = "time"    ;  break;
    case (SIGNAL_MAX):          type = "max"      ; break;
    case (SIGNAL_UNDEFINED):    type = "undefined"; break;
    
     default: cout << " wrong type" << endl;
  }
  //cout << "type = " << type <<endl;
  sType = RefString(new string(type));
 }
 RefString wire = RefString(new string("wire"));

if( !parent->isSignalGroup()){   

 if(sType.get()){
   sigDataVec->push_back(sType);
 }
 else { sigDataVec->push_back(wire); }
 //---------------TB signals-----------//
  if(parent->isTestBench()){
    if(sType.get()){
      tbSigDataVec->push_back(sType);
    }
    else { tbSigDataVec->push_back(wire); }
  }
  //-------------------------------------//
if(sigDataVec.get()){
   if(sigName.get() && !sigDataVec->empty()){
     sigDataMap->insert(make_pair(sigName,sigDataVec));
   }
 }

//---------------------tb signals map-------//
if(tbSigDataVec.get()){
   if(sigName.get() && !tbSigDataVec->empty()){
     tbSigDataMap->insert(make_pair(sigName,tbSigDataVec));
   }
 }

 if(tbSigDataVec.get()){
      tbSigDataVec.reset();
    }
    if(sigDataVec.get()){
      sigDataVec.reset();
    }
 }
 else{               //signal group
   if(sType.get()){
     sg_has_stype =true;
     sgSigDataVec->push_back(sType);
    
    
   }
   else { 
     sg_has_stype =false;
     sgSigDataVec->push_back(wire);
     
    
   }
   

   //---------------TB signals-----------//
   if(parent->isTestBench()){
     if(sType.get()){
       tbSigDataVec->push_back(sType);
     }
     else { tbSigDataVec->push_back(wire); }
  }
   //-------------------------------------//
    if(sgSigDataVec.get()){
     if(sigName.get() && !sgSigDataVec->empty()){
      
       sgSigDataMap->insert(make_pair(sigName,sgSigDataVec));
     }
     }
   
//---------------------tb signals map-------//
if(tbSigDataVec.get()){
   if(sigName.get() && !tbSigDataVec->empty()){
     tbSigDataMap->insert(make_pair(sigName,tbSigDataVec));
   }
 }

 if(tbSigDataVec.get()){
      tbSigDataVec.reset();
    }
    if(sigDataVec.get()){
      sigDataVec.reset();
    }
    
 }     


}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ){
  m_unitInstancesCount++;
  

  //formal to actualmapping
  m_insideFormalToActual=TRUE;

   uName = CSLOmIdentifier::cast(unitInst->getUnitDecl()->getChild(ID))->getName();
   uInst = CSLOmIdentifier::cast(unitInst->getChild(ID))->getName();
   RefString formal;
   RefString actual;
    
   if(uInst.get()){
    has_unit_inst = true;
   
   }
 
   if(instF2aVec.get()){
    instF2aVec.reset();
    }
   instF2aVec = RefTMap_RefString(new TMap_RefString());	
     
  RefCSLOmBase parentBase = unitInst->getParent()->getParent();
  RefCSLOmUnitDecl parent=CSLOmUnitDecl::cast(parentBase);
  TBool hasError=FALSE;
  RefTMap_RefCSLOmExprLink_RefCSLOmExpr cMap = unitInst->getConnectionMap();
  if(cMap->size()>0){
    //cout << "Map size= " << cMap->size()<< endl;
   
    //instF2aVec = RefTMap_RefString(new TMap_RefString());	
  }

  for(TMap_RefCSLOmExprLink_RefCSLOmExpr::iterator it=cMap->begin(); it!=cMap->end(); it++) {
    
    if (it->second->isExprLink()) {
      hasError=FALSE;
      RefCSLOmExprLink it1= it->first;
      RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
      if(!it->first->isInUnitScope(unitInst->getUnitDecl())){
        args.push_back(*convertLink(it->first));
        args.push_back(*CSLOmIdentifier::cast(unitInst->getUnitDecl()->getChild(ID))->getName());

        addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, it->first->getLineNumber(),it->first->getFileName());
        cslomCslCodeGeneratorHasErrors=TRUE;                                             
        hasError=TRUE;
      }
      if (!it2->isInUnitScope(parent)) {
        args.push_back(*convertLink(it2));
        args.push_back(*CSLOmIdentifier::cast(parent->getChild(ID))->getName());
	
        addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, it->first->getLineNumber(),it->first->getFileName());
        cslomCslCodeGeneratorHasErrors=TRUE;                                             
        hasError=TRUE;
      }
      else {
	
	formal = it1->getHidName(0);
        actual = it2->getHidName(0);


        RefCSLOmScope scope=parent->getAttachedScope();
        RefCSLOmIdentifier thatId=scope->lookupLocal(actual);

	//cout << "formal= " << *formal << " actual= " << *name << endl; 
	
	//instF2aVec->insert(make_pair(formal,actual));   // F2A map
	

        if(thatId.get()) {
          RefCSLOmBase parentId=thatId->getParent();
          if(parentId->isInstance()){
            args.push_back(*it2->getName());
	   
            addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_RHS_INSTANCE, args, it->second->getLineNumber(),it->second->getFileName());
            cslomCslCodeGeneratorHasErrors=TRUE;                                             
            hasError=TRUE;
          }
        }
      }
      if(!hasError){

        if(it1->hasBitRange()){
          RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
          args.push_back(*it1->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_FORMAL, args, it1->getLineNumber(),it1->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;                                             
        }
        if(!it1->getValue()->isConnectable() || !it2->getValue()->isConnectable()){
          args.push_back("instantiation");
          addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, it1->getLineNumber(),it1->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;                                             
        }
        else if(!it1->getValue()->isPort() && !it1->getValue()->isInterface()){
          RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
          args.push_back(*it1->getName());
	  addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_FORMAL, args, it1->getLineNumber(),it1->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;                                             
        }
        else if((it1->getValue()->isPort()) && 
                ((it2->getValue()->isInterface()) || it2->getValue()->isSignalGroup())){
          RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
          args.push_back(*it1->getName());
          args.push_back(*it2->getName());
 
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_PORT_IFCSG, args, it1->getLineNumber(),it1->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;                                
        }
        else if(it1->getValue()->isInterface() && 
                it2->getValue()->isPort()){
          RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
          args.push_back(*it1->getName());
          args.push_back(*it2->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_IFC_PORT, args, it1->getLineNumber(),it1->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;                                
        }
        else if(it1->getValue()->isInterface() && it2->getValue()->isSignal()){
          RefCSLOmExprLink it2= CSLOmExprLink::cast(it->second);
          args.push_back(*it1->getName());
          args.push_back(*it2->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_F2A_IFC_SIG, args, it1->getLineNumber(),it1->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;
        }
        else if(it1->getValue()->isInterface() && it2->getValue()->isInterface() ||
                it1->getValue()->isInterface() && it2->getValue()->isSignalGroup()){
	  instF2aVec->insert(make_pair(formal,actual));   // F2A map
	  
          checkIfc2IfcOrSgf2a(CSLOmExprLink::cast(it1),CSLOmExprLink::cast(it2),unitInst->getUnitDecl(), CSLOmUnitDecl::cast(unitInst->getParent()->getParent()));
        }
        else if(it1->getValue()->isSignalGroup() && it2->getValue()->isSignalGroup()){
          args.push_back("formal to actual: signal group with signal group");
          addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, it1->getLineNumber(), it1->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;                                             
        }
        else if(it2->getValue()->isPort() && it1->getValue()->isPort()){
          RefCSLOmPortDecl firstPort=CSLOmPortDecl::cast(it1->getValue());
          RefCSLOmPortDecl secondPort=CSLOmPortDecl::cast(it2->getValue());
          RefString name1=CSLOmIdentifier::cast(firstPort->getChild(ID))->getName();
          RefString name2=CSLOmIdentifier::cast(secondPort->getChild(ID))->getName();
	 

	  //cout << "firstport=" << *name1 << " second port=" << *name2 << endl;
	  if(*formal != *name1){
	    string formalHid = *formal + "." + *name1;
	    formal = RefString(new string (formalHid));
	  }
	  if(*actual != *name2){
	    string actualHid = *actual + "." + *name2;
	    actual = RefString(new string (actualHid));
	  }
	    instF2aVec->insert(make_pair(formal,actual));   // F2A map
	    //cout << *unitName << endl;

          if(firstPort->getPortDirection()==INOUT || secondPort->getPortDirection()==INOUT){
            //do nothing
          }
          else if(firstPort->getPortDirection()!=secondPort->getPortDirection()){
            args.push_back(*it2->getName());
            args.push_back(*it1->getName());
            addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_P_P_CONECTION_DIFF_DIR, args, it1->getLineNumber(),it2->getFileName());
            cslomCslCodeGeneratorHasErrors=TRUE;
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

	  if(it1->getValue()->isPort() && it2->getValue()->isSignal()){
	    RefCSLOmPortDecl firstPort=CSLOmPortDecl::cast(it1->getValue());
	    RefCSLOmSignal secondSignal=CSLOmSignal::cast(it2->getValue());
	    RefString name1=CSLOmIdentifier::cast(firstPort->getChild(ID))->getName();
	    RefString name2=CSLOmIdentifier::cast(secondSignal->getChild(ID))->getName();
	
	  //cout << "firstport=" << *name1 << " second signal=" << *name2 << endl;
	  if(*formal != *name1){
	    string formalHid = *formal + "." + *name1;
	    formal = RefString(new string (formalHid));
	  }
	  if(*actual != *name2){
	    string actualHid = *actual + "." + *name2;
	    actual = RefString(new string (actualHid));
	  }
	  instF2aVec->insert(make_pair(formal,actual));   // F2A map
	  
	  }

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
                  cslomCslCodeGeneratorHasErrors=TRUE;
                }
              }
              for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator wit=secondPortLower->begin(); wit!=secondPortLower->end(); wit++){
                RefCSLOmNumber value=CSLOmNumber::cast(wit->second);
                if(objLow->getValue() < value->getValue()){
                  args.push_back(*it2->getName());
                  args.push_back(intToString(objLow->getValue()));
                  args.push_back(intToString(value->getValue()));
                  addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_LOWER_NOT_INST, args, it2->getLineNumber(),it2->getFileName());
                  cslomCslCodeGeneratorHasErrors=TRUE;
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
                  cslomCslCodeGeneratorHasErrors=TRUE;
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
                  cslomCslCodeGeneratorHasErrors=TRUE;
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
                  //cslomCslCodeGeneratorHasErrors=TRUE;
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
                  cslomCslCodeGeneratorHasErrors=TRUE;
                }
              }
              for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator wit=secondPortLower->begin(); wit!=secondPortLower->end(); wit++){
                RefCSLOmNumber value=CSLOmNumber::cast(wit->second);
                if(objLow->getValue() < value->getValue()){
                  args.push_back(*it2->getName());
                  args.push_back(intToString(objLow->getValue()));
                  args.push_back(intToString(value->getValue()));
                  addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_PS_LOWER_NOT_INST, args, it2->getLineNumber(),it2->getFileName());
                  cslomCslCodeGeneratorHasErrors=TRUE;
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
                  cslomCslCodeGeneratorHasErrors=TRUE;
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
                  cslomCslCodeGeneratorHasErrors=TRUE;
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
          cslomCslCodeGeneratorHasErrors=TRUE;
        }
        if(it2->getWidth()!=it1->getWidth()){
          args.push_back(intToString(it1->getWidth()));
          args.push_back(intToString(it2->getWidth()));
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_DIFF_WIDTH, args, unitInst->getLineNumber(),unitInst->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;
        }        
      }
      else if(it2->isNumber()){
        TInt actualNum=CSLOmNumber::cast(it2)->getWidth();
        if(actualNum>it1->getWidth()){
          args.push_back(intToString(it1->getWidth()));
          args.push_back(intToString(it2->getWidth()));
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_DIFF_WIDTH, args, unitInst->getLineNumber(),unitInst->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;
        }
      }
      else{
        //change error
        args.push_back("formal to actual parameter");
        args.push_back("not concat or multi concat");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, it->first->getLineNumber(),it->first->getFileName());
        cslomCslCodeGeneratorHasErrors=TRUE;
        hasError=TRUE;
      }
    }
  }
  

 
   if(unitInstF2aMap.get() && uName.get() && uInst.get()){
    unitInstF2aMap->insert(make_pair(uInst,uName));
    }
  TMap_RefString::const_iterator iter7;    
  if(instF2aVec.get()){
    //cout <<"vec size=" << instF2aVec->size() << endl;
    if(unitInstMap.get() &&  uInst.get()){
      unitInstMap->insert(make_pair(uInst,instF2aVec));
     }
  }


}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ){

 
  RefCSLOmSimpleBitRange br_1 = simpleBitRange->getBitRange();
  vector<RefString>::const_iterator brIt;

  if(!(simpleBitRange->getSimpleBitRangeClassName())->empty()){
    m_brName = simpleBitRange->getSimpleBitRangeClassName();
    brNameVec.push_back(m_brName);
    // cout << "BR name=" << *m_brName << endl;
  }
  //part select checks are being done at expr link visit
  if(simpleBitRange->getParent()->isExprLink()){
    return;
  }
  //cout << (simpleBitRange->getName()) << endl;
  //getting the lower and upper params for repsective instances
  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase upperParams = simpleBitRange->getUpper()->doParamEval(simpleBitRange);
  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase lowerParams = simpleBitRange->getLower()->doParamEval(simpleBitRange);

  if(!upperParams.get()){
    //err design_bitrange_up_not_eval
    args.push_back(*m_lastPSvisited);
    addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_NOT_EVAL, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
    cslomCslCodeGeneratorHasErrors=TRUE;
    return;
  }
  if(!lowerParams.get()){
    args.push_back(*m_lastPSvisited);
    addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_NOT_EVAL, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
    cslomCslCodeGeneratorHasErrors=TRUE; 
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
      cslomCslCodeGeneratorHasErrors=TRUE;
      return;
    }
    if(!lowerParams->begin()->second->isNumber()){
      args.push_back(*m_lastPSvisited);
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_NUMBER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
      cslomCslCodeGeneratorHasErrors=TRUE;
      //error with design_bitrange_up_low_number
      return;
    }
    upper=CSLOmNumber::cast(upperParams->begin()->second);
    lower=CSLOmNumber::cast(lowerParams->begin()->second);

    if(!(simpleBitRange->getSimpleBitRangeClassName())->empty()){
      has_br = true;
      string br_param="";
      //brVec = RefTVec_TInt(new TVec_TInt);
      TInt up = upper->getValue();
      TInt lo = lower->getValue();

      //-------------int to char conversion-------------//
      stringstream oss1,oss2;
      oss1 << lo;
      oss2 << up;
      string s_lo = oss1.str();
      string s_up = oss2.str();
      //-------------------------------------------------//
      for(brIt = brNameVec.begin(); brIt != brNameVec.end(); brIt++){
	if( **brIt != *m_brName){
	  row("br_name") = *m_brName;
	  br_param = s_lo + "," + s_up;
	  row("num_expr")= br_param;
	  br_loop +=row;
	}
      }
      /* brVec->push_back(up);
      brVec->push_back(lo);
     
      bitrangeMap->insert(make_pair(m_brName,brVec));*/
    }
    //else { has_br = false; }

    if(lower->getValue() > upper->getValue() && !simpleBitRange->hasSetWidth()){
      //throw warning
      //design_bitrange_upper_lower
      args.push_back(*m_lastPSvisited);
      args.push_back(intToString(upper->getValue()));
      args.push_back(intToString(lower->getValue()));
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UPPER_LOWER, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
      //cslomCslCodeGeneratorHasErrors=TRUE;
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
        cslomCslCodeGeneratorHasErrors=TRUE;
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
        cslomCslCodeGeneratorHasErrors=TRUE;
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
          //cslomCslCodeGeneratorHasErrors=TRUE;
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
        cslomCslCodeGeneratorHasErrors=TRUE;
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
        cslomCslCodeGeneratorHasErrors=TRUE;
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
          //cslomCslCodeGeneratorHasErrors=TRUE;
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
      cslomCslCodeGeneratorHasErrors=TRUE;
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
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
    else{
      if(CSLOmNumber::cast(it->second)->getValue()==0){
        //design_bitrange_width_eq_zero
        args.push_back(*m_lastPSvisited);
        if(!it->first.get()){
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_EQ_ZERO_NI, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
          cslomCslCodeGeneratorHasErrors=TRUE;
          return;
        }
        else{
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
        }
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_EQ_ZERO, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
        cslomCslCodeGeneratorHasErrors=TRUE;
      }
      if(CSLOmNumber::cast(it->second)->getValue()<0){
        args.push_back(*m_lastPSvisited);
        if(!it->first.get()){
          args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_LT_ZERO_NI, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
          cslomCslCodeGeneratorHasErrors=TRUE;
        }
        else{
          args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
          args.push_back(intToString(it->first->getLineNumber()));
          args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
          addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_LT_ZERO, args, simpleBitRange->getLineNumber(),simpleBitRange->getFileName());  
          cslomCslCodeGeneratorHasErrors=TRUE;
        }
        //design_bitrange_width_lt_zero
      }
    }
  }

}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ){
  //to add parameters to this
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           ){}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ){
  //useless to define a signal group without signals inside
  //this check only works if the signal group is instanciated somewhere. 
  sgSigDataMap = RefTMap_RefString_RefTVec (new TMap_RefString_RefTVec());   //ifc port list map
  vector<RefString>::const_iterator sgIter;
  //loop_t sg_sig_loop;
  
  TBool sg_has_signals = false;
  has_sg = true;
  
  // TBool flag = FALSE;
  TInt size=groupSignal->getChildrenSize();

  if (size<2) {
    addErr(NSWarningErr::DEE_CSA_SIG_DESIGN_SG_NO_SIGNALS, args, 0,groupSignal->getFileName(),FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
  }

  m_sgName = groupSignal->getGroupSignalClassName();
  m_sgInst = CSLOmIdentifier::cast(groupSignal->getChild(ID))->getName();
 
  sgVec.push_back(m_sgName);
   
 
   row("sg_name")= *m_sgName;

   if(m_sgInst.get()){
     has_sg_inst = true;
     sgInstMap->insert(make_pair(m_sgInst,m_sgName));
   }
  /*if(sgVec.empty()){
    sgVec.push_back(m_sgName);
  }
  else{
    for(int i=0; i < sgVec.size(); i++){
      if(*m_sgName != *sgVec.at(i)){
	flag = TRUE;
      }
    }
    if(flag){
	sgVec.push_back(m_sgName);

	flag = FALSE;
	
    }
    }*/
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ){

  RefCSLOmBase numParent = number->getParent();
  m_num32TempStr = RefString(new string(" "));
  m_num32value = number->getValue();
  m_num32width = number->getWidth();
  m_num32baseType = number->getNumBaseType();
  m_expandNum32 = TRUE; 
  string rhsNum = "";
  string numStr="";
  stringstream oss;
  // m_isNum =false;
 
  if(number->isSigned()){
    m_num32signed = TRUE;
  }
  else{
    m_num32signed = FALSE;
  }

  if(m_expandNum32){
    if(m_num32baseType != CSLOmNumber::NUM_BASE_UNDEFINED){
  
      oss << m_num32width;
      string widthStr = oss.str();

      rhsNum = rhsNum + widthStr + "'";   //1

      if(m_num32signed){
	//	cout << "s";
      } 
      switch(m_num32baseType){
      case (CSLOmNumber::NUM_BASE_BIN) : 
	{
	
	  rhsNum = rhsNum + "b";   //2

	  if(m_num32TempStr.get()){
	  *(m_num32TempStr) = dec2Bin(m_num32value, m_num32width);
	  //reverse printing the string to get the order right
	  for(TInt i = (*m_num32TempStr).size()-1; i >= 0; --i){
	    // cout  <<  (*m_num32TempStr).at(i);
	    char bit = (*m_num32TempStr).at(i);
	    numStr = numStr + bit;
	  }
	  //m_num32TempStr.clear();
	   if(m_RhsIsNumber){
	  
	    rhsNum = rhsNum + numStr;  //3

	   m_binNum = RefString(new string(rhsNum));
	   simpleAssignStmt->insert(make_pair(m_lhs,m_binNum));
	   // cout << " n= " << *m_binNum << endl;
	    }
	   if(m_RhsIsOpExpr){
	    
	     rhsNum = rhsNum + numStr;  //3
	     m_binNum = RefString(new string(rhsNum));

	     if(opExprVec.get()){
	       // m_isNum = true;
	       c_num++;

	       opExprVec->push_back(m_binNum);
	      
	       opExprAssStmtMap->insert(make_pair(m_lhs,opExprVec));
	      
	     }
	     
	     // cout << "size=" << opExprVec->size() << endl;
	   }
	   if(m_RhsIsConcat){
	     rhsNum = rhsNum + numStr;  //3
	     m_binNum = RefString(new string(rhsNum));
	     concatVec->push_back(m_binNum);
	     
	     //cout  <<"last add =" << *m_lhs <<" "<< *m_binNum << endl;

	   }
	   if(m_RhsIsReplic){
	     // cout <<"LHS=" << *m_lhs <<  "Relplic nr=" << *m_binNum  << endl;
	   }
	  }
	 
	}
	break;
      case (CSLOmNumber::NUM_BASE_OCT) : 
	{
	  //cout << "o";
	  m_num32Stream << std::oct << m_num32value;
	  //m_num32Stream >> m_num32TempStr;
	  (*m_num32TempStr) = m_num32Stream.str();
	  //the width on which the number is represented
	  //could be smaller and therefore zero-padding might
	  //be required
	  m_num32TempWidth = (*m_num32TempStr).size() * 3 ; //each oct digit is 3 bits
	  while(m_num32TempWidth < m_num32width){
	    // cout << "0";
	    m_num32TempWidth = m_num32TempWidth + 3;
	  }
	  // cout << *m_num32TempStr;
	  m_num32Stream.str(std::string());
	  //m_num32TempStr.clear();
	}
	break;
      case (CSLOmNumber::NUM_BASE_DEC) : 
	{
	  if(m_RhsIsReplic){
	    stringstream ss;
	    ss << m_num32value;
	    string repl = ss.str();
	    RefString replNum = RefString(new string(repl));
	    if(replicVec.get() && replNum.get()){
	    replicVec->push_back(replNum);
	    //cout <<"LHS=" << *m_lhs << "  Relplic nr=" <<  *replNum  << endl;
	    }
	   }
	  // cout << m_num32value;
	}
	break;
      case (CSLOmNumber::NUM_BASE_HEX) : 
	{
	  // cout << "h";
	  m_num32Stream << std::hex << m_num32value;
	  //m_num32Stream >> m_num32TempStr;
	  (*m_num32TempStr) = m_num32Stream.str();
	  //the width on which the number is represented
	  //could be smaller and therefore zero-padding might
	       //be required
	  m_num32TempWidth = (*m_num32TempStr).size() * 4 ; //each hex digit is 4 bits
	  while(m_num32TempWidth < m_num32width){
	    // cout << "0";
	    m_num32TempWidth = m_num32TempWidth + 4;
	  }
	  // cout << *m_num32TempStr;
	  m_num32Stream.str(std::string());
	  //m_num32TempStr.clear();
	}
	break;
      }
    }
  } 
  else {
    // cout  <<endl << "Final=" << m_num32value << endl;
  }
m_expandNum32 = FALSE;

}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ){}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ){

  ifcPortDataMap = RefTMap_RefString_RefTVec (new TMap_RefString_RefTVec());   //ifc port list map
  // vector<RefString>::const_iterator ifcIter;
  vector<RefString>::const_iterator iterIfc1;
  RefString temp;
  m_insideIfc=TRUE;
  //useless to define an interface without ports inside
  //this check only works if the signal group is instanciated somewhere.
  TInt size=interface->getChildrenSize();

  if(!interface->isDefaultIfc() && size<2){
    addErr(NSWarningErr::DEE_CSA_SIG_DESIGN_IFC_NO_PORTS, args, 0,interface->getFileName(),FALSE,TRUE);
  
    cslomCslCodeGeneratorHasErrors=TRUE;
  }
  //if a ifc has only one ifc inside it. 
  if(!interface->isDefaultIfc() && size==2 && !interface->isArGenerated()){
    if(interface->getChild(ONE)->isInterface()){
      args.push_back(*CSLOmIdentifier::cast(interface->getChild(ID))->getName());
     
      addErr(NSWarningErr::DEE_CSA_SIG_DESIGN_IFC_NOTHING_BUT_IFC, args, 0,interface->getFileName(),FALSE,TRUE);
    }
  }
  //m_cslCurrParent = interface->getParent();
  if(!interface->isDefaultIfc()){
    m_ifcInst = CSLOmIdentifier::cast(interface->getChild(ID))->getName();
    if(m_ifcInst.get()){
      // ifcInstVec->push_back(m_ifcInst);
     
    }
  }
 
 
if(!interface->isDefaultIfc()){
  m_ifcName = interface->getInterfaceClassName();
  m_ifcInst = CSLOmIdentifier::cast(interface->getChild(ID))->getName();
  //vector<RefString>::const_iterator it;
 
  has_ifc = true;
  flag = false;

  if(m_ifcInst.get()){
    has_ifc_inst = true;
    ifcInstMap->insert(make_pair(m_ifcInst,m_ifcName));
  }
 
    if(ifcVec.empty()){
      ifcVec.push_back(m_ifcName);
      
    }
    else{
      
      for(int i=0; i < ifcVec.size(); i++){
	if(*m_ifcName != *ifcVec.at(i)){
	  flag = TRUE;
	}
	else { flag = false; }
      }
      if(flag){
	ifcVec.push_back(m_ifcName);
       	
	flag = FALSE;
	//cout <<" flag=" << flag << " Interface name =" << *m_ifcName << " " << endl;
      }
    }
    

 }


}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ){}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ){
 

  m_lastPSvisited = CSLOmIdentifier::cast(portDecl->getChild(ID))->getName();
  portDataVec =  RefTVec_RefString(new TVec_RefString());
  ifcPortDataVec =  RefTVec_RefString(new TVec_RefString());
 
  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase widthP = portDecl->getWidth()->doParamEval(portDecl);
  ECSLOmPortDirection portDir = portDecl->getPortDirection();
  ECSLOmSignalType portType = portDecl->getPortType();
  RefString portName, ifcPortName;
  string type;
  string dir;
  RefString pType;
  string dut_port = *m_lastPSvisited;
  RefString wire = RefString(new string("wire")); 
  RefString attr;

  if(portDecl->getAttr() == ATTR_CLK){
    attr = RefString(new string("clock"));
    attributeMap->insert(make_pair(m_lastPSvisited,attr));
  }
  if(portDecl->getAttr() == ATTR_EN){
    attr = RefString(new string("en"));
    attributeMap->insert(make_pair(m_lastPSvisited,attr));
  }
  if(portDecl->getAttr() == ATTR_STALL){
    attr = RefString(new string("stall"));
    attributeMap->insert(make_pair(m_lastPSvisited,attr));
  }
  if(portDecl->getAttr() == ATTR_DEC){
    attr = RefString(new string("decode"));
    attributeMap->insert(make_pair(m_lastPSvisited,attr));
  }
  if(portDecl->getAttr() == ATTR_RST){
    attr = RefString(new string("reset"));
    attributeMap->insert(make_pair(m_lastPSvisited,attr));
  }

 if((portDecl->getParent())->isInterface() && !(CSLOmInterface::cast(portDecl->getParent()))->isDefaultIfc() ){
   ifcPortName = m_lastPSvisited;
   ifc_has_ports = true;
   if(portDir == INPUT){
     string port = *m_lastPSvisited;
     inIfcPorts.push_back(port);
     //ifcPortDataVec->push_back(m_lastPSvisited);
    
   }
   else if(portDir == OUTPUT){
     string port = *m_lastPSvisited;
     outIfcPorts.push_back(port);
     //ifcPortDataVec->push_back(m_lastPSvisited);
   }
   else{}
  
  }

 //------------unit ports----------------------------//
 else {
   // cout << " Port name=" << *m_lastPSvisited << endl;
   unit_has_ports = true;
   unitPorts.push_back(m_lastPSvisited);
   portName = m_lastPSvisited;

 }
  if(portType){
  switch(portType){
    case (SIGNAL_REG):  type = "reg"        ; break;
    case (SIGNAL_WIRE): type = "wire"       ; break;
    case (SIGNAL_TRI):     type =  "tri"         ; break;
    case (SIGNAL_TRIREG):  type =  "trireg"      ; break;
    case (SIGNAL_WOR):     type =  "wor"         ; break;
    case (SIGNAL_WAND):    type =  "wand"        ; break;
    case (SIGNAL_TRIOR):   type = "trior"        ; break;
    case (SIGNAL_TRI0):    type = "tri0"         ; break;
    case (SIGNAL_TRI1):    type = "tri1"         ; break;
    case (SIGNAL_TRIAND):  type ="triand"        ; break;
    case (SIGNAL_SUPPLY_0):     type = "supply_0"; break;
    case (SIGNAL_SUPPLY_1):     type = "supply_1"; break;
    case (SIGNAL_VAR_INTEGER):  type = "integer" ; break;
    case (SIGNAL_VAR_REAL):     type = "real"    ; break;
    case (SIGNAL_VAR_REALTIME): type = "realtime"; break;
    case (SIGNAL_VAR_TIME):     type = "time"    ;  break;
    case (SIGNAL_MAX):          type = "max"      ; break;
    case (SIGNAL_UNDEFINED):    type = "undefined"; break;
    
     default: cout << " wrong type" << endl;
  }
  //cout << "type = " << type <<endl;
  pType = RefString(new string(type));
  

  
  }

  if(portDir){
  switch(portDir){
     case (INPUT):  dir = "input"       ; break;
     case (OUTPUT): dir = "output"      ; break;
     case (INOUT):  dir = "inout"       ;break;
     default: cout << " wrong direction" << endl;
  }
  

  RefString portDir = RefString(new string(dir));
  

  if((CSLOmInterface::cast(portDecl->getParent()))->isDefaultIfc()){

    portTypeVec.push_back(pType);
    portDirVec.push_back(portDir);

    if(dir == "in"){
      inPortTypeVec.push_back(pType);
      
    }
    else{
      if(dir == "out"){
	outPortTypeVec.push_back(pType);
	
      }
    }
      //-----------------------------------
      if(portDataVec.get()){
     
	if(pType.get()){
	  portDataVec->push_back(pType);
	
	} 
	else {
	  portDataVec->push_back(wire);
	}
	if(portDir.get()){
	  portDataVec->push_back(portDir);
	}
      }
      //-------------------------------------
  }
  else {                          // for ifc ports
    RefString pDir = RefString(new string(dir));
    if(dir == "input"){
      inIfcPortTypeVec.push_back(pType);

      if(pType.get()){
	  ifcPortDataVec->push_back(pType);
	
	} 
	else {
	  ifcPortDataVec->push_back(wire);
	}
     	if(pDir.get()){
	   ifcPortDataVec->push_back(pDir);
	}
  
    }
    else{
      if(dir == "output"){
	outIfcPortTypeVec.push_back(pType);

	if(pType.get()){
	  ifcPortDataVec->push_back(pType);
	
	} 
	else {
	  ifcPortDataVec->push_back(wire);
	}
     	if(pDir.get()){
	   ifcPortDataVec->push_back(pDir);
	}

      }
    }
  }
 

  }
 
    for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator it1=widthP->begin(); it1!=widthP->end(); it1++) {
      RefCSLOmNumber width=CSLOmNumber::cast(it1->second);
      
      TInt portWidth = TInt(width->getValue());
      portWidthVec.push_back(portWidth);      

      if((CSLOmInterface::cast(portDecl->getParent()))->isDefaultIfc()){
	std::ostringstream osstream;
	osstream << portWidth;
	string ppp = osstream.str();
	
	RefString pWidth = RefString(new string(ppp));
	if(portDataVec.get()){
	  portDataVec->push_back(pWidth);
	}
      }
      else {
	if((portDecl->getParent())->isInterface() && !(CSLOmInterface::cast(portDecl->getParent()))->isDefaultIfc() ){
	  std::ostringstream osstream;
	 
	  osstream << portWidth;

	  string ppp = osstream.str();
	  
	  RefString pWidth = RefString(new string(ppp));

	  	 
	  if(ifcPortDataVec.get()){
	    //cout << "width=" << *pWidth << endl;
	    ifcPortDataVec->push_back(pWidth);
	  }
	}
      }

      /*  if(dir == "in"){
	inPortWidthVec.push_back(portWidth);
	// cout << "port width = " << portWidth << endl;
      }
      else{
	if(dir == "out"){
	  outPortWidthVec.push_back(portWidth);
	}
	}*/
    }
  
  
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
        cslomCslCodeGeneratorHasErrors=TRUE;
      }
    }
  }
 if(portDataVec.get()){
   if(portName.get() && !portDataVec->empty()){
     portDataMap->insert(make_pair(portName,portDataVec));
   }
 }
if(ifcPortDataVec.get()){
  
   if(ifcPortName.get() && !ifcPortDataVec->empty()){
    
     ifcPortDataMap->insert(make_pair(ifcPortName,ifcPortDataVec));
     //cout <<"ifc name=" <<*m_ifcInst << "size=" << ifcPortDataMap->size() << endl;
   }
 }


}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ){
 m_exprCnt.push_back(0);
 stringstream ss;
 RefCSLOmExprLink tempLink;
 string unaryOp;
 m_RhsIsOpExpr = false;
 c_num = 0;

 //opExprVec.reset();
 //opExprVec = RefTVec_RefString(new TVec_RefString);   //RHS opExpr

 if(exprOp->isUnary()){
      switch(exprOp->getOpType()){
      case(CSLOmExprOp::OP_UNARY_ARITHMETIC_PLUS)  : unaryOp = "+"               ;       break;
      case(CSLOmExprOp::OP_UNARY_ARITHMETIC_MINUS) : unaryOp = "-"               ;       break;
      case(CSLOmExprOp::OP_UNARY_LOGIC_NOT)        : unaryOp = "!"               ;       break;
      case(CSLOmExprOp::OP_UNARY_BITWISE_NOT)      : unaryOp = "~"               ;       break;
      case(CSLOmExprOp::OP_UNARY_REDUCTION_AND)    : unaryOp = "&"               ;       break;
      case(CSLOmExprOp::OP_UNARY_REDUCTION_NAND)   : unaryOp = "~&"              ;       break;
      case(CSLOmExprOp::OP_UNARY_REDUCTION_OR)     : unaryOp = "|"               ;       break;
      case(CSLOmExprOp::OP_UNARY_REDUCTION_NOR)    : unaryOp = "~|"              ;       break;
      case(CSLOmExprOp::OP_UNARY_REDUCTION_XOR)    : unaryOp = "^"               ;       break;
      case(CSLOmExprOp::OP_UNARY_REDUCTION_XNOR)   : unaryOp = "~^"              ;       break;
      default                                      : unaryOp = "Error"            ;       break;
      }
    }
 RefString refUnaryOp = RefString (new string(unaryOp));
 if(opExprVec.get() && refUnaryOp.get()){
   m_RhsIsOpExpr = true;
   opExprVec->push_back(refUnaryOp);
  
 }
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
	TInt n = num->getValue();
	
	ss << n;
	if(tempLink.get()){
	  //cout << *convertLink(tempLink)<< " +" << ss.str()  <<endl;
	  string op1 = ss.str();
	  RefString refOp1 = RefString(new string(op1));
	  // opExprVec->push_back(refOp1);
	
	}
        DCERR(intToString(num->getValue()));
      }
      if((*i)->isExprLink()){
	m_RhsIsOpExpr = true;
        tempLink=CSLOmExprLink::cast(*i);
	string op2 = *convertLink(tempLink);
	RefString refOp2 = RefString(new string(op2));
	opExprVec->push_back(refOp2);

        tempLink->doEval();
        if(!tempLink->getValue().get()){
          args.push_back(*convertLink(tempLink));
          args.push_back(*CSLOmIdentifier::cast(m_lastStmtAssignVisited->getParent()->getChild(ID))->getName());
          addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, m_lastStmtAssignVisited->getLineNumber(),m_lastStmtAssignVisited->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;
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
            cslomCslCodeGeneratorHasErrors=TRUE;
          }
          else{
            if(connObj->getParentUnit().get()!=parent.get()) {
              args.push_back(*convertLink(tempLink));
              addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, tempLink->getLineNumber(),tempLink->getFileName());
              cslomCslCodeGeneratorHasErrors=TRUE;                                             
            }
          }
        }                              
      }
     
    }
  } 
 

}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ){
  //concatAssStmtMap = RefTMap_RefString_RefTVec(new TMap_RefString_RefTVec());
  if(m_insideAssignStmt){
    if(m_RhsIsReplic){ 
       RefTVec_RefCSLOmBase exprs=exprConcat->getExprsAsBase();
      for(TVec_RefCSLOmBase::iterator i=exprs->begin(); i<exprs->end();i++){
	RefCSLOmExprLink tempLink=CSLOmExprLink::cast(*i); 
	RefString item = convertLink(tempLink);
	if(replicVec.get()){
	replicVec->push_back(item);
	//cout << "RHS =" << *item << endl; 
	}
      }
     
    } 

    if(m_lhsAssignStmtConcat && !m_lhsConcatAssignVisited){//we are on the lhs concat
   
      checkConcatForObjects(exprConcat);
      if(!m_lhsConcatAssignAllObjects){
        addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_LHS_ASSIGN_NOT_OBJECT, args, exprConcat->getLineNumber(),exprConcat->getFileName());
        cslomCslCodeGeneratorHasErrors=TRUE;
      }
    }
    if(m_multipleConcatsInStmtAssign){
      RefCSLOmUnitDecl parent=CSLOmUnitDecl::cast(m_lastStmtAssignVisited->getParent());
      RefTVec_RefCSLOmBase exprs=exprConcat->getExprsAsBase();
      for(TVec_RefCSLOmBase::iterator i=exprs->begin(); i<exprs->end();i++){
        if((*i)->isExprLink()){
          RefCSLOmExprLink tempLink=CSLOmExprLink::cast(*i); 
	  RefString item = convertLink(tempLink);
	  concatVec->push_back(item);    
	  //cout << "concat items=" << *convertLink(tempLink) << endl; 
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
            cslomCslCodeGeneratorHasErrors=TRUE;
          }
          else{
            if(connObj->getParentUnit().get()!=parent.get()) {
              args.push_back(*convertLink(tempLink));
              addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, tempLink->getLineNumber(),tempLink->getFileName());
              cslomCslCodeGeneratorHasErrors=TRUE;                                             
            }
          }                                                                    
        }
      }
    }
  }
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ){
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
          cslomCslCodeGeneratorHasErrors=TRUE;
        }
        else{
          if(connObj->getParentUnit().get()!=parent.get()) {
            args.push_back(*convertLink(tempLink));
            addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, tempLink->getLineNumber(),tempLink->getFileName());
            cslomCslCodeGeneratorHasErrors=TRUE;                                             
          }
        }                                                                    
      }
    }
  }
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmList                            & list                            ){} 

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ){
 
}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ){}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ){}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ){}
//void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ){}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ){
  TInt width=enumeration->getWidth();
  if(enumeration->isEmpty()){
    args.push_back(*CSLOmIdentifier::cast(enumeration->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSC_HID_DSGN_EMPTY_ENUM, args, enumeration->getLineNumber(),enumeration->getFileName());
    //cslomCslCodeGeneratorHasErrors=TRUE;
  }
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           ){

  if(field->getFieldType()==NSCSLOm::CSLOmField::FIELD_UNDEFINED){
    if(field->isDefault() && !field->isAnonymous()){
      args.push_back(*CSLOmIdentifier::cast(field->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_FIELD_WIDTH, args, 0,field->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }
  if(field->getParent()->isField() && CSLOmField::cast(field->getParent())->getFieldType()==NSCSLOm::CSLOmField::FIELD_HIERARCHICAL){
    if (CSLOmField::cast(field->getParent())->hasPositionsSet() && !CSLOmField::cast(field->getParent())->isSetPosition(field)) {
      args.push_back(*CSLOmIdentifier::cast(field->getChild(ID))->getName());
      args.push_back(*CSLOmIdentifier::cast(field->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSC_DSGN_NOT_ALL_FIELD_POS_SET, args, field->getParent()->getLineNumber(),field->getParent()->getFileName());
      cslomCslCodeGeneratorHasErrors=TRUE;
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
      cslomCslCodeGeneratorHasErrors=TRUE;
      return;
    }
    if(!lowerParams.get()){
      args.push_back(*m_lastPSvisited);
      addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_NOT_EVAL, args, field->getLineNumber(),field->getFileName());  
      cslomCslCodeGeneratorHasErrors=TRUE; 
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
        cslomCslCodeGeneratorHasErrors=TRUE;
      }
      if(!lowerParams->begin()->second->isNumber()){
        args.push_back(*m_lastPSvisited);
        addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_NUMBER, args, field->getLineNumber(),field->getFileName());  
        cslomCslCodeGeneratorHasErrors=TRUE;
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
        //cslomCslCodeGeneratorHasErrors=TRUE;
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
          cslomCslCodeGeneratorHasErrors=TRUE;
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
          cslomCslCodeGeneratorHasErrors=TRUE;
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
            //cslomCslCodeGeneratorHasErrors=TRUE;
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
          cslomCslCodeGeneratorHasErrors=TRUE;
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
          cslomCslCodeGeneratorHasErrors=TRUE;
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
            //cslomCslCodeGeneratorHasErrors=TRUE;
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
        cslomCslCodeGeneratorHasErrors=TRUE;
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
        cslomCslCodeGeneratorHasErrors=TRUE;
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
          cslomCslCodeGeneratorHasErrors=TRUE;
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
            cslomCslCodeGeneratorHasErrors=TRUE;
          }
          else{
            args.push_back(*CSLOmIdentifier::cast(it->first->getChild(ID))->getName());
            args.push_back(intToString(it->first->getLineNumber()));
            args.push_back(intToString(CSLOmNumber::cast(it->second)->getValue()));
            addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_WIDTH_LT_ZERO, args, field->getLineNumber(),field->getFileName());  
            cslomCslCodeGeneratorHasErrors=TRUE;
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
        //cslomCslCodeGeneratorHasErrors=TRUE;
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
      cslomCslCodeGeneratorHasErrors=TRUE;
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
        cslomCslCodeGeneratorHasErrors=TRUE;
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
        cslomCslCodeGeneratorHasErrors = TRUE;
      }
    }
  }
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ){
  m_memoryMapPresent=TRUE;

  if(memoryMap->getMandatoryCount()!=DCH_MAN_CMD_CNT_MEMORY_MAP){
     if(memoryMap->getMemMapType()==MM_UNDEFINED){
       args.push_back(*CSLOmIdentifier::cast(memoryMap->getChild(ID))->getName());
       addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_MMAP_TYPE, args, 0,memoryMap->getFileName(),FALSE,TRUE);
       cslomCslCodeGeneratorHasErrors=TRUE;
     }
  }
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ){}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ){}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ){
  m_memMapPagesCount++;
  
  //predefined but not declared
  if(!memoryMapPage->isDefined()){
    args.push_back(*CSLOmIdentifier::cast(memoryMapPage->getChild(ID))->getName());
    addErr(NSWarningErr::CSE_CSA_ASE_DESIGN_NOT_DECLARED, args,memoryMapPage->getLineNumber(),memoryMapPage->getFileName());
    cslomCslCodeGeneratorHasErrors=TRUE;
  }

  if(memoryMapPage->getMandatoryCount()!=DCH_MAN_CMD_CNT_MMAP_PAGE){
    if(!memoryMapPage->isUnitNameSet()){
      args.push_back(*CSLOmIdentifier::cast(memoryMapPage->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_MPAGE_UNIT_NAME, args,0,memoryMapPage->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
    if(!memoryMapPage->isSetAddressRange()){
      args.push_back(*CSLOmIdentifier::cast(memoryMapPage->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_MPAGE_ADDRESS_RANGE, args,0,memoryMapPage->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }
}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ){}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ){}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ){
  //flags
  m_insideIsaField=TRUE;
  //mandatory commands
  //if(isaField->getMandatoryCount()!=DCH_MAN_CMD_CNT_ISA_FIELD){
  if(isaField->getIsaFieldType()==NSCSLOm::CSLOmIsaField::ISA_FIELD_UNDEFINED){
    args.push_back(*CSLOmIdentifier::cast(isaField->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_ISAF_TYPE, args, 0,isaField->getFileName(),FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
  }
    //}
  if(isaField->getFieldType()==NSCSLOm::CSLOmField::FIELD_UNDEFINED && isaField->isDefault()){
    args.push_back(*CSLOmIdentifier::cast(isaField->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_FIELD_WIDTH, args, 0,isaField->getFileName(),FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
  }
  
  //cannot have isaField with type opcode and no enum associated (WITH gen_decoder called upon it)
  if(!isaField->isWithEnum() && isaField->getIsaFieldType()==NSCSLOm::CSLOmIsaField::ISA_FIELD_OPCODE && isaField->isDecoder()){
    args.push_back(*CSLOmIdentifier::cast(isaField->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_FIELD_OPCODE_NOENUM, args, 0,isaField->getFileName(),FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
  }

  //cannot have isaField with enum inside isaElement of type instruction
  if(m_insideIsaElemInstr && isaField->isWithEnum()){
    args.push_back(*CSLOmIdentifier::cast(isaField->getChild(ID))->getName());
    args.push_back(*m_isaElemInstrName);
    addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_INSTR_FIELD_WITH_ENUM, args, 0,isaField->getFileName(),FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
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
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ){

  m_insideIsaElement=TRUE;
  m_prevIsaElement=isaElement;

  m_currentEnumItemFieldPosition=MAX_INT;
  m_currentNormalFieldPosition=-MAX_INT;
  m_currentPosition=0;

  //predefined but not declared
  if(!isaElement->isDefined()){
    args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
    addErr(NSWarningErr::CSE_CSA_ASE_DESIGN_NOT_DECLARED, args, isaElement->getLineNumber(),isaElement->getFileName());
    cslomCslCodeGeneratorHasErrors=TRUE;
  }

  if(isaElement->getIsaType()==NSCSLOm::CSLOmIsaElement::ISA_ELEM_UNDEFINED){
    args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_ISAE_TYPE, args, 0,isaElement->getFileName(),FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
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
      cslomCslCodeGeneratorHasErrors=TRUE;
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
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }

  //leaf levels must be instructions
  if(!children.get()){ //then it is leaf level
    if(isaElement->getIsaType()!=NSCSLOm::CSLOmIsaElement::ISA_ELEM_INSTR){
      args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_LEAF_NOT_INSTR, args, 0,isaElement->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }
  
  //clearing the vector for the isa prefix check
  m_curInstrFields->clear();

  //isa element hierarchical fields widths checks
  m_isaElemHierAddedWidths=0;
  m_isaElemWait=TRUE;
}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ){}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ){

  m_insideAssignStmt=TRUE;
  m_lastStmtAssignVisited=stmtAssign;
  m_RhsIsNumber = FALSE;
  m_RhsIsOpExpr = FALSE;
  m_RhsIsConcat = FALSE;
  //opExprVec = RefTVec_RefString(new TVec_RefString);   //unit opExpr
 

  TVec_RefString::const_iterator iter;

  RefCSLOmExpr lhs=stmtAssign->getLHS();
  RefCSLOmExpr rhs=stmtAssign->getRHS();

  RefCSLOmBase lhsEvaled;
  RefCSLOmBase rhsEvaled;
  //RefString  m_lhs,m_rhs;

  RefCSLOmScope scope = CSLOmBase::getAttachedScope(stmtAssign->getParent().get());
  CSLOmScopeBlock::enterScope(scope);
  
  if(lhs->isExprLink()){
    lhsEvaled=lhs->doEval();
  }
  if(rhs->isExprLink()){
    rhsEvaled=rhs->doEval();
  }
if(CSLOmExprLink::cast(lhs)->getName().get()){
  // if(opExprVec.get()){
  //   opExprVec.reset();
  //    }
  //opExprVec = RefTVec_RefString(new TVec_RefString);   //unit opExpr
   m_lhs = CSLOmExprLink::cast(lhs)->getName();
     //cout <<" LHS=" << *m_lhs << endl;

 }

  if(lhs->isExprLink()){
    if(CSLOmExprLink::cast(lhs)->getValue().get()){
      if(CSLOmExprLink::cast(lhs)->getValue()->isSignalGroup()){
        args.push_back(*CSLOmExprLink::cast(lhs)->getName());
        addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_SG_ANYTHING, args, lhs->getLineNumber(),lhs->getFileName());
        cslomCslCodeGeneratorHasErrors=TRUE;
        return;
      }
      if(rhs->isExprLink()){
	
        if(CSLOmExprLink::cast(rhs)->getValue().get()){
	 
          RefCSLOmExprLink lhsEl=CSLOmExprLink::cast(lhs);
          RefCSLOmExprLink rhsEl=CSLOmExprLink::cast(rhs);
	  
	  m_rhs = rhsEl->getName();
	  simpleAssignStmt->insert(make_pair(m_lhs,m_rhs));
	 
	  /* if(!opExprVec->empty()){
	    m_RhsIsOpExpr = TRUE;
	    
	    }*/


          if(rhsEl->hasBitRange() && (!rhsEl->getValue()->isPort() && !rhsEl->getValue()->isSignal())){
            args.push_back(*rhsEl->getName());
            addErr(NSWarningErr::CSE_CSC_SIG_ASSIGN_PART_SELECT_NOT_PORT_OR_SIGNAL, args, rhsEl->getLineNumber(),rhsEl->getFileName());
            cslomCslCodeGeneratorHasErrors=TRUE;
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
              cslomCslCodeGeneratorHasErrors=TRUE;
              return;
            }
            if(rhsParent.get()!=stmtParent.get()){
              args.push_back(*convertLink(rhsEl));
              addErr(NSWarningErr::DEE_CSC_HID_DSGN_HID_PARENT_UNIT, args, lhs->getLineNumber(),lhs->getFileName());
              cslomCslCodeGeneratorHasErrors=TRUE;
              return;
            }

            if((lhsEl->getValue()->isInterface() || lhsEl->getValue()->isSignalGroup()) &&
               (!rhsEl->getValue()->isInterface() && !rhsEl->getValue()->isSignalGroup())){
              args.push_back(*rhsEl->getName());
              args.push_back(*lhsEl->getName());
              addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_LHS_ASSIGN, args, lhs->getLineNumber(),lhs->getFileName());
              cslomCslCodeGeneratorHasErrors=TRUE;                                             
            }
            else if((rhsEl->getValue()->isInterface() || rhsEl->getValue()->isSignalGroup()) &&
                    (!lhsEl->getValue()->isInterface() && !lhsEl->getValue()->isSignalGroup())){
              args.push_back(*lhsEl->getName());
              args.push_back(*rhsEl->getName());
              addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_LHS_ASSIGN, args, lhs->getLineNumber(),lhs->getFileName());
              cslomCslCodeGeneratorHasErrors=TRUE;                                             
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
                  cslomCslCodeGeneratorHasErrors=TRUE;
                }
              }

              if(lhsWidthParams->size()==rhsWidthParams->size() && lhsWidthParams->size()==1){
                if(!lhsWidthParams->begin()->second->isNumber()){
                  //error with design_bitrange_up_low_number
                  args.push_back(*m_lastPSvisited);
                  addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_NUMBER, args, lhsEl->getLineNumber(),lhsEl->getFileName());  
                  cslomCslCodeGeneratorHasErrors=TRUE;
                  return;     
                }
                if(!rhsWidthParams->begin()->second->isNumber()){
                  //error with design_bitrange_up_low_number
                  args.push_back(*m_lastPSvisited);
                  addErr(NSWarningErr::DEE_CSA_DSGN_DESIGN_BITRANGE_UP_LOW_NUMBER, args, lhsEl->getLineNumber(),lhsEl->getFileName());  
                  cslomCslCodeGeneratorHasErrors=TRUE;
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
                  cslomCslCodeGeneratorHasErrors=TRUE;
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
          cslomCslCodeGeneratorHasErrors=TRUE;                                             
        }
	
      }
      else { //!rhs->isExprLink()
	 
        RefCSLOmExprLink lhsEl=CSLOmExprLink::cast(lhs);
        if((lhsEl->getValue()->isInterface() || lhsEl->getValue()->isSignalGroup()) && 
           (rhs->isConcat() || rhs->isMultiConcat())){
	 
          args.push_back(*lhsEl->getName());
          addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_IFC_ELSE, args, lhs->getLineNumber(),lhs->getFileName());
          cslomCslCodeGeneratorHasErrors=TRUE;                                             
        }
        if(rhs->isConcat()){
	  m_RhsIsConcat = TRUE;
	  concatVec = RefTVec_RefString(new TVec_RefString);   // RHS concat

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
          //        cslomCslCodeGeneratorHasErrors=TRUE;                                             
          //      }                                                                    
          //    }
          //  }
          //}
        }
        else if(rhs->isOp()){
	  m_RhsIsOpExpr = TRUE;
	  if(opExprVec.get()){
	    opExprVec.reset();
	  }
	  opExprVec = RefTVec_RefString(new TVec_RefString);   //RHS opExpr
	  
        }
	else {
	  if(rhs->isNumber()){
	    m_RhsIsNumber = TRUE;
	  }
	  else {   // Replication OP
	    m_RhsIsReplic = TRUE;
	    replicVec = RefTVec_RefString(new TVec_RefString);   // RHS concat
	    //  m_rhs = CSLOmExprLink::cast(rhs)->getName();
	    // cout << "RHS= " << *m_rhs << endl; 
	  }
	  
	}
      }
     
     
    }
    else{//lhs does not exist
      args.push_back(*CSLOmExprLink::cast(lhs)->getName());
      addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_OBJ_NOT_EXIST, args, stmtAssign->getLineNumber(),stmtAssign->getFileName());
      cslomCslCodeGeneratorHasErrors=TRUE;                                             
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
        cslomCslCodeGeneratorHasErrors=TRUE;                                             
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
        cslomCslCodeGeneratorHasErrors=TRUE;
        return;
      }
    }
    if(!lhs->isConcat()){
      addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_LHS_ASSIGN_NOT_OBJECT, args, lhs->getLineNumber(),lhs->getFileName());
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
    else{//indeed we have a concat there
      m_lhsAssignStmtConcat=TRUE;
    }
    
  }
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ){
  if(memInfo->getMandatoryCount()!=DCH_MAN_CMD_CNT_MEMORY){
    RefCSLOmExpr expr=RefCSLOmExpr();
    expr=memInfo->getWidth();
    if(CSLOmNumber::cast(expr->doEval())->getValue()==MEM_DEF_WIDTH){
      args.push_back(*CSLOmIdentifier::cast(memInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_MEM_DESIGN_MEMORY_NO_WIDTH, args, 0,memInfo->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
    expr=memInfo->getDepth();
    if(CSLOmNumber::cast(expr->doEval())->getValue()==MEM_DEF_DEPTH){
      args.push_back(*CSLOmIdentifier::cast(memInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_MEM_DESIGN_MEMORY_NO_DEPTH, args, 0,memInfo->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }
}
void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ){
  //mandatory commands
  if(fifoInfo->getMandatoryCount()!=DCH_MAN_CMD_CNT_FIFO){
    if(!fifoInfo->getSetWidth()){
      args.push_back(*CSLOmIdentifier::cast(fifoInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_FIFO_WIDTH, args, 0,fifoInfo->getParent()->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
    if(!fifoInfo->getSetDepth()){
      args.push_back(*CSLOmIdentifier::cast(fifoInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_FIFO_DEPTH, args, 0,fifoInfo->getParent()->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }
}    

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ){
  if(regFileInfo->getMandatoryCount()!=DCH_MAN_CMD_CNT_REG_FILE){
    if(!regFileInfo->getSetWidth()){
      args.push_back(*CSLOmIdentifier::cast(regFileInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_RF_WIDTH, args, 0,regFileInfo->getParent()->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
    if(!regFileInfo->getSetDepth()){
      args.push_back(*CSLOmIdentifier::cast(regFileInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_RF_DEPTH, args, 0,regFileInfo->getParent()->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ){
  //mandatory commands
  if(!regInfo->getMandatoryCount()!=DCH_MAN_CMD_CNT_REGISTER){
    if(!regInfo->getAlreadySetType()){
      args.push_back(*CSLOmIdentifier::cast(regInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_REGISTER_TYPE, args, 0,regInfo->getParent()->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
    if(!regInfo->getSetWidth()){
      args.push_back(*CSLOmIdentifier::cast(regInfo->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_REGISTER_WIDTH, args, 0,regInfo->getParent()->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }

  if(!regInfo->getAlreadySetCntDir() && regInfo->getType()==CSLOmRegDeclInfo::REG_DECL_COUNTER){
    args.push_back(*CSLOmIdentifier::cast(regInfo->getParent()->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ASE_DESIGN_MAND_REGISTER_CND_DIR, args, 0,regInfo->getParent()->getFileName(),FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
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
          cslomCslCodeGeneratorHasErrors = FALSE;
        }
        else if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN && tempStart->getValue()<=tempEnd->getValue()){
          args.push_back("smaller");
          addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
          cslomCslCodeGeneratorHasErrors = FALSE;
        }
      }
      else {
        tempStart=CSLOmNumber::cast(startValueParams->begin()->second);
        tempEnd=CSLOmNumber::cast(endValueParams->begin()->second);
        if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP && tempStart->getValue()>=tempEnd->getValue()){
          args.push_back("bigger");
          addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
          cslomCslCodeGeneratorHasErrors = FALSE;
        }
        else if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN && tempStart->getValue()<=tempEnd->getValue()){
          args.push_back("smaller");
          addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
          cslomCslCodeGeneratorHasErrors = FALSE;
        }
        for(TMap_RefCSLOmUnitInstance_RefCSLOmBase::iterator itStart=startValueParams->begin()++; itStart!=startValueParams->end(); itStart++) {
          tempStart=CSLOmNumber::cast(itStart->second);
          tempEnd=CSLOmExpr::getValueForInstance(itStart->first,endValueParams);
          if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP && tempStart->getValue()>=tempEnd->getValue()){
            args.push_back("bigger");
            addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
            cslomCslCodeGeneratorHasErrors = FALSE;
          }
          else if(cntDir==CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN && tempStart->getValue()<=tempEnd->getValue()){
            args.push_back("smaller");
            addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, regInfo->getLineNumber(), regInfo->getFileName());
            cslomCslCodeGeneratorHasErrors = FALSE;
          }
        }
      }
    }
  }
  else if((!regInfo->getStartValue().get() && regInfo->getEndValue().get()) ||
           (regInfo->getStartValue().get() && !regInfo->getEndValue().get())){
            args.push_back(*CSLOmIdentifier::cast(regInfo->getParent()->getChild(ID))->getName());
            addErr(NSWarningErr::CSE_CSC_SIG_REGISTER_COUNTER_START_END, args, 0,regInfo->getParent()->getFileName());
            cslomCslCodeGeneratorHasErrors=TRUE;
            return;
          } 
  
}

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ){
 
  m_testbenchesInWholeDesignCount++;
  m_insideTestbench=TRUE;
  dutName_dutInst = RefTMap_RefString(new TMap_RefString());
  

  //clock in the dut needs to be the same as the clock in the testbench
  //  TBool clockFound=FALSE;
  RefCSLOmSignal clockSignal=tbInfo->getClockSignal();
  if(clockSignal.get()){      
    clockName=CSLOmIdentifier::cast(clockSignal->getChild(ID))->getName();  //clock signal name for template interface
    ECSLOmSignalType signalType= clockSignal->getSignalType();
                                                                 // clock signal type for template interface

    switch(signalType){
    case SIGNAL_WIRE         : clockType = RefString(new string("wire"));       break;
    case SIGNAL_REG          : clockType = RefString(new string("reg"));        break;
    case SIGNAL_TRIREG       : clockType = RefString(new string("trireg"));     break;
    case SIGNAL_TRI          : clockType = RefString(new string("tri"));        break;
    case SIGNAL_WOR          : clockType = RefString(new string("wor"));        break;
    case SIGNAL_WAND         : clockType = RefString(new string("wand"));       break;
    case SIGNAL_TRIOR        : clockType = RefString(new string("trior"));      break;
    case SIGNAL_TRI0         : clockType = RefString(new string("tri0"));       break;
    case SIGNAL_TRI1         : clockType = RefString(new string("tri1"));       break;
    case SIGNAL_TRIAND       : clockType = RefString(new string("triand"));     break;
    case SIGNAL_SUPPLY_0     : clockType = RefString(new string("supply_0"));   break;
    case SIGNAL_SUPPLY_1     : clockType = RefString(new string("supply_1"));   break;
    case SIGNAL_VAR_INTEGER  : clockType = RefString(new string("integer"));    break;
    case SIGNAL_VAR_REAL     : clockType = RefString(new string("real"));       break;
    case SIGNAL_VAR_REALTIME : clockType = RefString(new string("realtime"));   break;
    case SIGNAL_VAR_TIME     : clockType = RefString(new string("time"));       break;
    case SIGNAL_MAX          : clockType = RefString(new string("max"));        break;
    case SIGNAL_UNDEFINED    : clockType = RefString(new string("undefined"));  break;
    default : cout << "wrong type" <<endl;
    }
    
  
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
          cslomCslCodeGeneratorHasErrors=TRUE;
        }
      }
    }
  }
  else{
    args.push_back(*CSLOmIdentifier::cast(tbInfo->getParent()->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_TBCD_DESIGN_NO_TESTBENCH_CLOCK, args, 0,tbInfo->getParent()->getFileName(),FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
  }
   
  //--------------------clk period---------------------------
  RefCSLOmNum32 clockPeriod = CSLOmNum32::cast(tbInfo->getClockPeriod());
  per =  clockPeriod->getValue();                                     // clock signal period for template interface
 
  

//-------------clock timebase------------------------------------
  CSLOmTBInfo::ETBTimeBase clkTimeBase = tbInfo->getClockTimeBase();
                                                     // clock signal time base for template interface
  

  switch(clkTimeBase){
  case 0 : timeBase = RefString(new string("undef")); break;
  case 1 : timeBase = RefString(new string("ps"));    break;
  case 2 : timeBase = RefString(new string("ns"));    break;
  case 3 : timeBase = RefString(new string("us"));    break;
  case 4 : timeBase = RefString(new string("ms"));    break;
  case 5 : timeBase = RefString(new string("s"));     break;
  case 6 : timeBase = RefString(new string("max"));   break;
  defaul : cout << "wrong timebase " << endl;
  }

  //-----------------TB wave type---------------------------------
  CSLOmTBInfo::ETBWaveType wType = tbInfo->getWaveType();
                                                    // testbench wave type for template interface

  switch(wType){
  case 0 : waveType = RefString(new string("undef"));   break;
  case 1 : waveType = RefString(new string("fsdb"));    break;
  case 2 : waveType = RefString(new string("vcd"));     break;
  case 3 : waveType = RefString(new string("max"));     break;
  default : cout << " wrong wave type" << endl;
  }

  //cout << "wave type=" << *waveType << endl;
  //----------------Verilog filename-----------------------------
  verilogFilename = tbInfo->getVerilogFilename();            // Tb verilog filename for template interface   
  if(verilogFilename.get())       
    cout << "VRL Filename=" << *verilogFilename << endl;

}
     

void CSLOmCslCodeGenerator::beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ){
  m_vectorsInWholeDesignCount++;
  if(vectorInfo->getStimulusElseExpected()){
    m_stimCount++;
  }
  else{
    m_expectCount++;
  }
  
  // vecData = RefTVec_RefString(new TVec_RefString);                           //vectors informations
  vecDeclMap = RefTMap_RefString_RefTVec(new TMap_RefString_RefTVec());

  vecData->push_back(m_DutName);   // add vector dut
  //---------------------module name---------------------
    RefCSLOmExprLink mName = vectorInfo->getModuleName();
    RefString moduleName = mName->getName();                  //tb module name for template interface

  //cout << "module name = " << *moduleName << endl;
  //-----------------------------------------------------
    ECSLOmPortDirection Dir = vectorInfo->getDirection();
    if(Dir == INPUT){
      m_vecDir = RefString (new string ("input"));
    }
    else {
      if(Dir == OUTPUT){
	m_vecDir = RefString (new string ("output"));
      }
      else { m_vecDir = RefString (new string ("inout"));}
    }
    vecData->push_back(m_vecDir);       //add vector dir
    //cout << "DIR=" << *m_vecDir <<endl;


  if(mName.get()){
    RefCSLOmBase dutBase = mName->doEval();
    ASSERT(dutBase.get(),"dut does not evaluate to anything");
    RefCSLOmUnitDecl dut = CSLOmUnitDecl::cast(dutBase);
    ASSERT(dut.get(),"dut does not evaluate to anything");
    if(!dut->isDUT()){
      //CHANGE ERROR vector is associated to a dut that is not instantiated in a testbench
      args.push_back(*(CSLOmIdentifier::cast(vectorInfo->getParent()->getChild(ID)))->getName());
     

      addErr(NSWarningErr::DEE_CSA_VEC_DESIGN_NO_VECTOR_UNIT, args, 0,vectorInfo->getParent()->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
    else{ 
      string vec_name = *(CSLOmIdentifier::cast(vectorInfo->getParent()->getChild(ID)))->getName();
      m_vectors.push_back(vec_name);
      //cout << "VECTOR = " << vec_name <<endl;
      RefString vectorName = CSLOmIdentifier::cast(vectorInfo->getParent()->getChild(ID))->getName();
      vecData->push_back(vectorName); 
      vecDeclMap->insert(make_pair(vectorName,vecData));          //create vector map
      // cout << " vec Name = " << *vectorName <<endl;
}
  }
  if(vectorInfo->getMandatoryCount()!=DCH_MAN_CMD_CNT_VECTOR){
    if(!mName.get()){
      args.push_back(*(CSLOmIdentifier::cast(vectorInfo->getParent()->getChild(ID)))->getName());
      addErr(NSWarningErr::DEE_CSA_VEC_DESIGN_NO_VECTOR_UNIT, args, 0,vectorInfo->getParent()->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
    if(vectorInfo->getDirection()==DIR_UNDEFINED){
      args.push_back(*(CSLOmIdentifier::cast(vectorInfo->getParent()->getChild(ID)))->getName());
      addErr(NSWarningErr::DEE_CSA_VEC_DESIGN_NO_VECTOR_DIRECTION, args,0,vectorInfo->getParent()->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }
  RefTVec_RefCSLOmExprLink ass_ports=vectorInfo->getAssociatedPorts();
  if(ass_ports.get() && ass_ports->size()){
    for(TUInt i=0; i<ass_ports->size();++i){
      m_assPorts->push_back(ass_ports->at(i));
      m_assVectors->push_back(vectorInfo);
    }        
  }
  // for (int i =0 ; i < vecData->size(); i++){
  //cout << "Vec=" << *vecData->at(i)<<endl;
  //}
 
}    


void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ){


}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ){}

void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ){
 m_exprCnt.back()++;
 string opExpr, opExpr1, opExpr2;
 if(exprOp->isBinary() && m_exprCnt.back() == 1){
    switch(exprOp->getOpType()){
      case(CSLOmExprOp::OP_BINARY_ARITHMETIC_PLUS)          : opExpr= " + "                                        ;       break;
      case(CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS)         : opExpr= " - "                                        ;       break;
      case(CSLOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY)      : opExpr= " * "                                        ;       break;
      case(CSLOmExprOp::OP_BINARY_ARITHMETIC_DIV)           : opExpr= " / "                                        ;       break;
      case(CSLOmExprOp::OP_BINARY_ARITHMETIC_MOD)           : opExpr= " % "                                        ;       break;
      case(CSLOmExprOp::OP_BINARY_ARITHMETIC_POW)           : opExpr= " ** "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT)    : opExpr= " <<< "                                      ;       break;
      case(CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT)   : opExpr= " >>> "                                      ;       break;
      case(CSLOmExprOp::OP_BINARY_EQUALITY_EQ)              : opExpr= " == "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_EQUALITY_NOT_EQ)          : opExpr= " != "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_IDENTITY_EQ_CASE)         : opExpr= " === "                                      ;       break;
      case(CSLOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE)     : opExpr= " !== "                                      ;       break;
      case(CSLOmExprOp::OP_BINARY_LOGIC_AND)                : opExpr= " && "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_LOGIC_OR)                 : opExpr= " || "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_RELATIONAL_LESS)          : opExpr= " < "                                        ;       break;
      case(CSLOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL)    : opExpr= " <= "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER)       : opExpr= " > "                                        ;       break;
      case(CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL) : opExpr= " >= "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_BITWISE_AND)              : opExpr= " & "                                        ;       break;
      case(CSLOmExprOp::OP_BINARY_BITWISE_NAND)             : opExpr= " ~& "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_BITWISE_OR)               : opExpr= " | "                                        ;       break;
      case(CSLOmExprOp::OP_BINARY_BITWISE_NOR)              : opExpr= " ~| "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_BITWISE_XOR)              : opExpr= " ^ "                                        ;       break;
      case(CSLOmExprOp::OP_BINARY_BITWISE_XNOR)             : opExpr= " ~^ "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_SHIFT_LEFT)               : opExpr= " << "                                       ;       break;
      case(CSLOmExprOp::OP_BINARY_SHIFT_RIGHT)              : opExpr= " >> "                                       ;       break;
      default                                              : opExpr= "/*Error in binary expression */"            ;       break;
      }
  }
 RefString refOpExpr = RefString(new string(opExpr));
 if(opExprVec.get()){
  
     opExprVec->push_back(refOpExpr);
  
  if(exprOp->isTernary()){
    if(m_exprCnt.back() == 1){
      opExpr1 = " ? ";
      RefString refOpExpr1 = RefString(new string(opExpr1));
      opExprVec->push_back(refOpExpr1);
    } else if(m_exprCnt.back() == 2){
      opExpr2 =" : ";
      RefString refOpExpr2 = RefString(new string(opExpr2));
      opExprVec->push_back(refOpExpr2);
    }
  }
  if ( m_lhs.get()){
    opExprAssStmtMap->insert(make_pair(m_lhs,opExprVec));
    
  }
  /* if(opExprVec.get() && !opExprVec->empty())
     opExprVec.reset();*/
    }
 
}

void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ){}

void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmList                            & list                            ){}  
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ){}
//void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmField                           & field                           ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ){}

void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ){}

void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ){
  m_isaElemWait=TRUE;
}

void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ){
  m_lhsConcatAssignVisited=TRUE;
  
}

void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ){}    
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ){}
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ){}    
void CSLOmCslCodeGenerator::inTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ){}    


void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          ){
  //multiple isa elements of root type
  if(m_isaElemRootCount>1){
    cslomCslCodeGeneratorHasErrors=TRUE;
  }
  
  if(m_memoryMapPresent && m_memMapPagesCount==0){
    addErr(NSWarningErr::DEE_CSA_MMP_DESIGN_MEM_MAP_NO_PAGES, args, 0, RefString(new std::string("NULL")), FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
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

//------------------------------for templates----------------------//
 //--------------Unit predeclarations---------------------------------//
  vector<RefString>::const_iterator unitIter;
 
  if(!unitVec.empty()){
   
    has_unit = true;
    for(unitIter = (unitVec).begin(); unitIter != (unitVec).end(); unitIter++){
	
      row("unit_name") = *(*unitIter);
      unit_predecl_loop +=row;
    }
  }
  else{
    has_unit = false;
  }
  //----------------------------------------------------------------//


  templ("has_unit") = has_unit;
  templ("unit_predecl_loop")= unit_predecl_loop;
  templ("br_loop")= br_loop;
  templ("has_br")= has_br;
  templ("has_sg")= has_sg;
  templ("sg_loop") = sg_loop;
  templ("has_ifc") = has_ifc;
  templ("ifc_loop") = ifc_loop;
  templ("unit_loop")= unit_list;

 if(file_name){ 
  ofstream cslCode(file_name, ios::app);
  cslCode << templ;
 }   
 cslCode.close();   
 //---------------------------------------------//


}

void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              ){  
      
 
  
}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        ){
  m_connectedSignals->empty();

  loop_t port_list;
  loop_t sig_list;
  loop_t sg_inst_loop;
  loop_t ifc_inst_loop;
  
 
  if(m_insideTestbench){
    m_insideTestbench=FALSE;
    if(m_unitInstancesCount<1){
      args.push_back(*CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_TBCD_DESIGN_NO_TESTBENCH_UNITS_INSTANCIATED, args, 0,unitDecl->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }

  ///////////////////////////////////////////////////////////////
  TMap_RefString_RefTVec::const_iterator iter2;

  if(portDataMap.get() && !portDataMap->empty()){
    for(iter2 = portDataMap->begin(); iter2 != portDataMap->end(); iter2++){
      row("port_name")= *(iter2->first);
      vector<RefString>  pData = *iter2->second;
      
      if(pData[0].get()){
	has_ptype =true;
	row("port_type") = *pData[0];
      }
      else{ has_ptype = false; }
      
      if(pData[1].get()){
	row("port_dir") = *pData[1];
      }
      if(pData[2].get()&& *pData[2]!=""){
	has_pwidth = true;
	row("port_width") = *pData[2];
      }
      else{ has_pwidth = false; }
      
      row("has_ptype")= has_ptype;
      row("has_pwidth") = has_pwidth;
      port_list += row;
      
    }
  }
  row("unit_port_loop")= port_list;
  row("unit_has_ports") = unit_has_ports;
  ////////////////////////////////////////////////////////////////

  TMap_RefString_RefTVec::const_iterator iter12;
  
  if(sigDataMap.get()&& !sigDataMap->empty()){
    for(iter12 = sigDataMap->begin(); iter12 != sigDataMap->end(); iter12++){
      row("sig_name")= *(iter12->first);
      vector<RefString>  sData = *iter12->second;
	 
      if(sData[1].get()){
	has_swidth = true;
	row("sig_type") = *sData[1];
      }
      else{ has_swidth = false; }
      
      if(sData[0].get()){
	has_stype =true;
	row("sig_width") = *sData[0];
      }
      else{ has_stype = false; }
          
      row("has_stype")= has_stype;
      row("has_swidth") = has_swidth;
      sig_list += row;
    }
  }
  row("unit_signal_loop")= sig_list;
  row("unit_has_signals") = unit_has_signals;

 ////////////////////////////////////////////////////////////////

  TMap_RefString::const_iterator sgIt2;

  if(sgInstMap.get() && !sgInstMap->empty()){
    for(sgIt2 = sgInstMap->begin(); sgIt2 != sgInstMap->end(); sgIt2++){
      row("sg_orig_name")= *sgIt2->second;
      row("sg_inst")= *sgIt2->first;
      sg_inst_loop +=row;
    }
    row("sg_inst_loop")= sg_inst_loop;
  }
  else { has_sg_inst = false; }
  row("has_sg_inst")= has_sg_inst;

 if(sgInstMap.get() && !sgInstMap->empty()){
   sgInstMap.reset();
 }
///////////////////////////////////////////////////////////////

  TMap_RefString::const_iterator uIt2;

  if(ifcInstMap.get() && !ifcInstMap->empty()){
    for(uIt2 = ifcInstMap->begin(); uIt2 != ifcInstMap->end(); uIt2++){
      row("ifc_orig_name")= *uIt2->second;
      row("ifc_inst")= *uIt2->first;
      ifc_inst_loop +=row;
    }
    row("ifc_inst_loop")= ifc_inst_loop;
  }
  else { has_ifc_inst = false; }
  row("has_ifc_inst")= has_ifc_inst;

  if(ifcInstMap.get() && !ifcInstMap->empty()){
    ifcInstMap.reset();
  } 
/////////////////////////////////////////////////////////////
  TMap_RefString::const_iterator iter7;  
  TMap_RefString_RefTMap_RefString::const_iterator iter8; 
  TMap_RefString::const_iterator iter9; 
 

  if(has_unit_inst){
    loop_t unit_f2a_inst_loop;
    // cout << "Unit=" << *unitName << endl;
    if(unitInstF2aMap.get() && !unitInstF2aMap->empty()){
      //loop_t unit_f2a_inst_loop;
      // has_unit_inst = true;
      for(iter9 = unitInstF2aMap->begin();iter9 != unitInstF2aMap->end(); iter9++){
	
	row("unit_inst_name") = *(iter9->second);
	row("unit_inst")= *(iter9->first);

	for(iter8 = unitInstMap->begin(); iter8 != unitInstMap->end(); iter8++){
	  
	  if(*(iter8->first) == *(iter9->first)){
	    loop_t f2a_loop;
	    
	    for(iter7 = (iter8->second)->begin(); iter7 != (iter8->second)->end(); iter7++){
	      
	      row("formal")= *(iter7->first);
	      row("actual")= *(iter7->second);
	      f2a_loop +=row; 
	}
	    row("f2a_loop")= f2a_loop; 
	  }
	}
	unit_f2a_inst_loop += row;
      }
    }
    
  row("unit_f2a_inst_loop")= unit_f2a_inst_loop;
  }

  row("has_unit_inst") = has_unit_inst;

  if(instF2aVec.get() && !instF2aVec->empty()){
    instF2aVec.reset();
  }
  if(unitInstMap.get() && !unitInstMap->empty()){
    unitInstMap.reset();
  }
  if(unitInstF2aMap.get() && !unitInstF2aMap->empty()){
    unitInstF2aMap.reset();
  }

 
  /////////////////////////////////////////////////////////////////
  TMap_RefString::const_iterator iter14;
  loop_t assign_loop;

  for(iter14 = simpleAssignStmt->begin(); iter14 != simpleAssignStmt->end(); iter14++){
    if(!(iter14->second)->empty()){
      has_assignStmt = true;
      row("lhs") = *(iter14->first);
      row("rhs") = *(iter14->second);
      
      assign_loop +=row;
    }
	   
  }
  row("assign_loop") = assign_loop;
  row("has_assignStmt") =  has_assignStmt;
 
  if(simpleAssignStmt.get()){
    simpleAssignStmt.reset();
  }
  ////////////////////////////////////////////////////////////////
  TMap_RefString_RefTVec::const_iterator iter16;
  vector<RefString>::const_iterator iter17;
  has_assignStmt = false;
  loop_t  ass_opExpr_loop;
  string op, op1,op2, rhs;
  
  for( iter16 = opExprAssStmtMap->begin(); iter16 != opExprAssStmtMap->end(); iter16++){
    if((iter16->second)->size() >3){
      has_opExpr = true;
      row("lhs_op")= *(iter16->first);
    }
    else {  has_opExpr = false; }
    for(iter17 = (iter16->second)->begin(); iter17 !=(iter16->second)->end(); iter17++){
     
      if( c_num >= 2 ){
	rhs = rhs + **iter17;
	if(iter17 == (iter16->second)->end()-1){
	  // row("rhs_op")= rhs;
	  // ass_opExpr_loop += row;
	 
	}
      }
      else{
	
	if( iter17 == (iter16->second)->begin()+1){
	  op1 = **iter17;
	  
	}
	else {
	  if(iter17 == (iter16->second)->begin()+2){
	    op2 = **iter17;
	    
	  }
	  else { 
	    
	    if(iter17 == (iter16->second)->begin()+3){
	      op = **iter17;
	      rhs = op1 + op + op2;
	      // cout << "rhs2=" << rhs << endl;
	    }
	  }
	}
      }
      //row("rhs_op")= rhs;
    }
    //if(){
      // rhs = op1 + op + op2;
      
      row("rhs_op")= rhs;
      ass_opExpr_loop += row;
      // }
    
  }
  row("ass_opExpr_loop")=  ass_opExpr_loop;
  row ("has_opExpr")= has_opExpr;
  has_opExpr = false;

  if(opExprVec.get()){
    opExprVec.reset();
  }
  if(opExprAssStmtMap.get()){
    opExprAssStmtMap.reset();  
  }

  ////////////////////////////////////////////////////////////////
 
  /* if(unitDeclAssignStmt.get() && simpleAssignStmt.get()){
    
    if(unitName.get() && !simpleAssignStmt->empty()){
      
     unitDeclAssignStmt->insert(make_pair(unitName,simpleAssignStmt));
    }
    }*/
  /*if(unitDeclOpExpr.get() && opExprAssStmtMap.get()){
   if(unitName.get() && !opExprAssStmtMap->empty()){
     unitDeclOpExpr->insert(make_pair(unitName,opExprAssStmtMap));
    
   }
 }
 if(unitDeclConcat.get() && concatAssStmtMap.get()){
   if(unitName.get() && !concatAssStmtMap->empty()){
   unitDeclConcat->insert(make_pair(unitName,concatAssStmtMap));
   }
 }

 if(unitDeclReplic.get() && replicAssStmtMap.get()){
   if(unitName.get() && !replicAssStmtMap->empty()){
     unitDeclReplic->insert(make_pair(unitName,replicAssStmtMap));
   }
  
   }*/
 

 if(unitDeclAttrMap.get() && attributeMap.get()){
   unitDeclAttrMap->insert(make_pair(unitName,attributeMap));
 }

 unit_list += row;
 

}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          ){

}

void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        ){

  m_multipleConcatsInStmtAssign=FALSE;
  m_insideFormalToActual=FALSE;


}

void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     ){

  TMap_RefString_RefTVec::const_iterator iterS1;
  vector<RefString>::const_iterator iterS2;
  loop_t sg_sig_loop;

  row("sg_has_signals")= sg_has_signals;
  if(sg_has_signals == true){
    for(iterS1 = (sgSigDataMap)->begin(); iterS1 != (sgSigDataMap)->end(); iterS1++){
      row("sg_sig_name") = *iterS1->first; 

      vector<RefString>  sData = *iterS1->second;
       if(sData[0].get()){
	
	row("sg_sig_width") = *sData[0];

      }
       if(sData[1].get()){
	
	 row("sg_sig_type") = *sData[1];
	
       }
     
	row("sg_has_stype")= sg_has_stype;
	row("sg_has_swidth") = sg_has_swidth;
	sg_sig_loop += row;
      }
   
    row("sg_sig_loop")= sg_sig_loop;
  }
 
   sg_loop +=row;

   if(sgSigDataMap.get() && !sgSigDataMap->empty()){
     sgSigDataMap.reset();
    
   }

}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       ){
  loop_t ifc_port_list;
  m_insideIfc=FALSE;
 
  vector<RefString>::const_iterator it; 
  TMap_RefString_RefTVec::const_iterator iterP2;

  if(!interface->isDefaultIfc()){
    cnt++;
    if(cnt <= ifcVec.size()){
      row("ifc_name") = *m_ifcName;
      
      row("ifc_has_ports")= ifc_has_ports;
      if(ifc_has_ports == true){
	if(ifcPortDataMap.get() && !ifcPortDataMap->empty()){
	  for(iterP2 = ifcPortDataMap->begin(); iterP2 != ifcPortDataMap->end(); iterP2++){
	    row("ifc_port_name")= *iterP2->first;
	    vector<RefString>  pData = *iterP2->second;
	    
	    if(pData[0].get()){
	      ifc_has_type =true;
	      row("ifc_port_type") = *pData[0];
	    }
	    else{ ifc_has_type = false; }
	    row("ifc_has_type")= ifc_has_type;
	    
	    if(pData[1].get()){
	      row("ifc_port_dir") = *pData[1];
	    }
	    if(pData[2].get()){
	      ifc_has_width = true;
	      row("ifc_port_width") = *pData[2];
	    }
	    else{ ifc_has_width = false; }
	    row("ifc_has_width") = ifc_has_width;
	    ifc_port_list += row;
	    
	  }
	  row("ifc_port_loop")= ifc_port_list;
	}
	
	ifc_loop += row;
      }
       }
  }
 
if(ifcPortDataMap.get() && !ifcPortDataMap->empty()){
  ifcPortDataMap.reset();
 }
flag = FALSE;
}

void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        ){

}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          ){
m_exprCnt.pop_back();
 m_RhsIsOpExpr =FALSE;

}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      ){

 concatAssStmtMap->insert(make_pair(m_lhs,concatVec));

 if(replicVec.get() && !replicVec->empty()){
   replicAssStmtMap->insert(make_pair(m_lhs,replicVec));
 }
 // cout << " SIZE stmt=" << replicAssStmtMap->size() << endl;
}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            ){}  
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmSetCommand                      & setCommand                      ){
  // cout << "!!!!!!!Set width command" << endl;
  ECSLOmCommandType cmdType = setCommand->getCommandType();


  if(cmdType == TYPE_CMD_SET_WIDTH){
    //cout << "Set width command" << endl;
  }
}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               ){}
//void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmField                           & field                           ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       ){}

void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        ){
  //flags
  //hierarhical widths checks
  if(isaField->isHierarchical()){
    RefCSLOmExpr expr=isaField->getWidth();
    TInt currentWidth = CSLOmNumber::cast(expr->doEval())->getValue();
    TInt addedWidths = m_isaFieldHierSizes->back();
    if(currentWidth < addedWidths){
      args.push_back(*CSLOmIdentifier::cast(isaField->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_HIERC_WIDTH, args, 0,isaField->getFileName(),FALSE,TRUE);
      cslomCslCodeGeneratorHasErrors=TRUE;
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
          cslomCslCodeGeneratorHasErrors=TRUE;
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

void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      ){
  if(isaElement->getIsaType()==NSCSLOm::CSLOmIsaElement::ISA_ELEM_INSTR){
    m_insideIsaElemInstr=FALSE;
  }

  //hier widths
  RefCSLOmExpr expr=isaElement->getWidth();
  TInt currentWidth = CSLOmNumber::cast(expr->doEval())->getValue();
  if(currentWidth<m_isaElemHierAddedWidths){
    args.push_back(*CSLOmIdentifier::cast(isaElement->getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_HIERC_WIDTH, args, 0,isaElement->getFileName(),FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
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
        cslomCslCodeGeneratorHasErrors=TRUE;
      }
    }
  }
  
  //field positions
  if(m_currentEnumItemFieldPosition<m_currentNormalFieldPosition){
    args.push_back(*m_enumItemFieldName);
    args.push_back(*m_normalFieldName);
    addErr(NSWarningErr::DEE_CSA_ISA_DESIGN_ISA_FIELD_POS, args, 0,isaElement->getFileName(),FALSE,TRUE);
    cslomCslCodeGeneratorHasErrors=TRUE;
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
            cslomCslCodeGeneratorHasErrors=TRUE;   
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
            cslomCslCodeGeneratorHasErrors=TRUE;   
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

void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ){

  
}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ){
 
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
      cslomCslCodeGeneratorHasErrors=TRUE;                                             
      return;
    }
    if(rhs->isExprLink() && !CSLOmExprLink::cast(rhs)->getValue().get()){

      RefCSLOmExprLink rhsEl=CSLOmExprLink::cast(rhs);
      args.push_back(*convertLink(rhsEl));
      args.push_back(*CSLOmIdentifier::cast(stmtAssign->getParent()->getChild(ID))->getName());
      addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, stmtAssign->getLineNumber(),stmtAssign->getFileName());
      cslomCslCodeGeneratorHasErrors=TRUE;                                             
      return;
    }
  
    TInt rhsAssignAddedWidths=rhs->getWidth();
    TInt lhsAssignAddedWidths=lhs->getWidth();
  
    if(rhsAssignAddedWidths!=lhsAssignAddedWidths){
      args.push_back(intToString(lhsAssignAddedWidths));
      args.push_back(intToString(rhsAssignAddedWidths));
      addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_ASSIGN_DIFF_WIDTH, args, lhs->getLineNumber(),lhs->getFileName());
      cslomCslCodeGeneratorHasErrors=TRUE;
    }
  }
  //

  CSLOmScopeBlock::exitScope();
  m_insideAssignStmt=FALSE;
  m_RhsIsReplic = FALSE;
   opExprVec.reset();
  opExprVec = RefTVec_RefString(new TVec_RefString);
 
}

void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ){}    
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ){}
void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ){}  

void CSLOmCslCodeGenerator::afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ){
  
  vCnt++;
 //--------------------Templates interface-----------------------


    

  //-------------vector version----------------------------

  RefCSLOmNumber version = vectorInfo->getVersion();
  TInt vectorVer = (CSLOmNum32::cast(version))->getValue();    //vector version for template interface
  if(vCnt == 1){
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
    cout << "stim vector version = " << vectorVer << endl;
#endif
  }
  else {
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
    cout << "exp vector version = " << vectorVer << endl;
#endif
  }
  //------------vector ID-------------------------------
  RefCSLOmNumber id = vectorInfo->getNumericID();
  TInt vectorId = (CSLOmNum32::cast(id))->getValue();    //vector ID for template interface
  if(vCnt == 1) {
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
    cout << "stim vector ID = " << vectorId << endl;
#endif
  }
  else{
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
    cout << "exp vector ID = " << vectorId << endl;
#endif
  }
  //----------stimulus file name------------------------------
   
  RefString stimFilename;
  RefString expFilename;

  if(vectorInfo->getStimulusElseExpected()){
    // if(vCnt ==1){
      if(vectorInfo->getStimulusFilename()){
	stimFilename = vectorInfo->getStimulusFilename();
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
	cout << "stim filename = " << *stimFilename << endl;
#endif
      }
  }
  else {
      if(vectorInfo->getExpectedFilename()){
	expFilename = vectorInfo->getExpectedFilename();
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
	cout << "exp filename = " << *expFilename << endl;
#endif
      }
      // }
}
  //---------------timeout----------------------------------
  RefCSLOmNumber timeout = vectorInfo->getTimeout();
  TInt simTimeout = (CSLOmNum32::cast(timeout))->getValue();
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
  cout << "timeout= " << simTimeout << endl; 
#endif
  //---------------vector name--------------------------------
  RefString vecName = vectorInfo->getName();
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
  cout << "vec name = " << *vecName << endl;
#endif
  //--------------TB parameters--------------------------------
 
  //  simTimeoutName = RefString(new string("SIM_TIMEOUT_CNT"));
  //  simTimeoutVal = simTimeout;
  // parameterMap->insert(make_pair(simTimeoutName,simTimeoutVal));
 
  //---------------vector radix--------------------------------
  CSLOmVerifCompInfo::ECSLOmVCRadix radix = vectorInfo->getRadix();
  TInt vectorRadix= radix;
 
 
  //----------------event counters values-----------------------------------------
  RefCSLOmNumber maxEventCount = vectorInfo->getMaxEventsCount();
  TInt maxEvCnt = (CSLOmNum32::cast(maxEventCount))->getValue();
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
  cout << "max event cnt = " << maxEvCnt << endl;
#endif
 
  //---------------------DUT input ports-----------------------------------------
  // cout << "in size= " <<  (vectorInfo->getDUTInputPorts())->size() << endl;

  if(vCnt ==1){

    inPorts = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink);
    inPorts = vectorInfo->getDUTInputPorts();
    //cout << "size = " << inPorts->size() << endl;
 
  //-----------------------------------------------------------------------------

 TVec_RefCSLOmExprLink::const_iterator iterIn;

  for(iterIn = inPorts->begin(); iterIn != inPorts->end();iterIn++){
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
    cout << "input port = " << *(*iterIn)->getName() <<" " << (*iterIn)->getWidth() <<endl;
#endif
  }
  }
  else{
    //---------------------DUT output ports-----------------------------------------
    outPorts = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink);
    outPorts = vectorInfo->getDUTOutputPorts();
    //-----------------------------------------------------------------------------
 
    TVec_RefCSLOmExprLink::const_iterator iterOut;

    for(iterOut = outPorts->begin(); iterOut != outPorts->end();iterOut++){
#ifdef _DEBUG_CSLOM_VERILOG_TESTBENCH_GENERATOR
      cout << "output port = " << *(*iterOut)->getName() <<" " << (*iterOut)->getWidth() <<endl;
#endif
    }

   

  }
  vecList->push_back(vecDeclMap);    //create the list of vectors
 
}    
 

}//end of namespace

