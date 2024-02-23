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

/*
 *   CDOM Verilog Testbench Code generator
 *   Authors: MonicaS 
 *   2010
 */

#include "CDOM_VerilogTbGenerator.h"
#include <fstream>
#include <ctime>
//#include <iterator>

//-------------------MS added-------------------------------------------
#include "$WORK/templates/html_template.h"

using namespace std;
using namespace tmpl;

//----------------------------------------------------------------------------

using namespace NSCdom;

namespace NSCdomVerilogTbGenerator {

//********************************************************************************
// CVerilogGenerator class
//********************************************************************************
CVerilogTbGenerator::CVerilogTbGenerator(std::string outputPath): m_outputPath(outputPath),
                                                              m_includeInUnit(FALSE),
                                                              m_pulseControlSection(TRUE),
                                                              m_num32TempStr(RefString(new std::string()))
{
  //Changing output method below
  //file = FALSE;
  //if (!filename.empty()) {
  //  out = new std::ofstream(filename.c_str());
  //  file=TRUE;
  //  if(!out){
  //    std::cerr << "Warning opening output file" << std::endl;
  //  }
  //}
  //else {
  //  out = new std::ofstream("verilog_generated_code.v");
  //  m_filename = "verilog_generated_code.v";
  //  file = TRUE;
  //  //out = &(std::cout);
  //}

  //Safe initialization
  out = &(std::cout);
}
CVerilogTbGenerator::~CVerilogTbGenerator() {
  //Changing output method below
  //if (file) {
  //  ((std::ofstream*)(out))->close();
  //  delete out;
  //}
}

//********************************************************************************
// Helper Functions
//********************************************************************************

//Normal indenter function
void CVerilogTbGenerator::indt(TInt size) {
  size = size*2;
  for(int i=0; i < size; i++){
    *(out) << " ";
  }
}

//portlist indenter function
void CVerilogTbGenerator::portListIndt(TInt size) {
  size = size*1;
  for(int i=0; i < size; i++){
    *(out) << " ";
  }
}

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

//copyright notice
void CVerilogTbGenerator::copyrightNotice(std::string fileName){
  //Copyright notice
  time_t* temp = new time_t;
  time_t cpright_date = time(temp);
  
  vfout << "//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER\n//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc\n";
  vfout << "//OUTPUT FILE NAME  : " << fileName << std::endl;
  vfout << "//FILE GENERATED ON : " << ctime(&cpright_date) << std::endl;

  delete temp;
 }

void CVerilogTbGenerator::setVfInclude(RefString plusPath){
  m_vfIncludeString = plusPath;
}

//********************************************************************************
// Before traversal block
//********************************************************************************

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ){
  //// calling indenter function ////
  indt(m_depth);

  if(FILE_VERILOG == fileInclude->getFileType()) {
    *(out) << "`include \"" << *(fileInclude->getFileName()) << "\" " << std::endl;
  }
  else {
    std::cout<<"You are not including a Verilog file!\n";
    exit(1);
  }

  //setting the flag if the current unit has an inlude already
  RefCDOmBase parent = fileInclude->getParent();
  if(parent.get() && TYPE_DECL_MODULE == parent->getType()){
    m_includeInUnit = TRUE;
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmDesign                          & design                      ){
//Initializations
  // m_noRange = FALSE;
  m_depth = 0;
  m_addIndent = 0;

  //other flags
  m_showRange = TRUE;
  m_expandNum32 = FALSE;
  m_vect = FALSE; //-------OB added

  //defines stream
  NSCLi::CLiCommon::Instance()->openFile(m_outputPath + "defines.v", defout, std::ios::out);
  //adding inc guard in defines stream
  defout << "`ifndef DEFINES_FILE" << std::endl;
  defout << "`define DEFINES_FILE" << std::endl << std::endl;

  if (cslTopUnitName.get()
      && !cslTopUnitName->empty()) {

    RefString topModuleName(new std::string(*cslTopUnitName));
    topModuleName->append(".vf");
    NSCLi::CLiCommon::Instance()->openFile(m_outputPath + *topModuleName, vfout, std::ios::out);
    copyrightNotice(*topModuleName);

    if (cslomHasEnum) {
      vfout << "enum_define.v" << std::endl;
    }
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ){
  
// create a template object
  html_template templ("$WORK/templates/verilog_tb_templates/testbench.tmpl");  //MS added

  //Inits
  //Module CSL type (if generated from CSL)
  m_moduleCslType = moduleDecl->getCslSourceUnitType();
  m_instantiationsMap = RefTMap_RefString_RefCDOmBase(new TMap_RefString_RefCDOmBase());
  m_currentModuleName = moduleDecl->getModuleName();

  //ACTUAL FILE INITIALIZATIONS
  //FileName init
  m_moduleFileName = RefString(new std::string(*m_currentModuleName));
 
  if(m_moduleCslType == CDOmModuleDecl::GEN_FROM_TB){
 //-----------call the template-----------
  tmpl(m_moduleFileName);
  //--------------------------------------
    m_moduleFileName->append("_testbench");
  }
  m_moduleFileName->append(".v");

  //VF FILE GENERATION
  vfout << *m_moduleFileName << std::endl;

//   RefTVec_RefCDOmBase instDeclVec = moduleDecl->getInstancesDeclarationsAsBase();
//   if(instDeclVec.get() && (instDeclVec->size() > 0 || moduleDecl->isTopModule())){
//     vfout = new std::ofstream((m_outputPath + *(m_currentModuleName) + ".vf").c_str());
//     out = vfout;
//     copyrightNotice(*(m_currentModuleName)+".vf");
//     //includeing VF Include option in top unit vf
//     if(moduleDecl->isTopModule() && m_vfIncludeString.get()){
//       (*vfout) << "+incdir+" << *(m_vfIncludeString) << std::endl;
//     }

//     //Including enum defines file - not module dependent and only from CSL flow
//     //WARNING - USING UNDEFINED BECAUSE THERE IS NO ENUM FOR THE VERILOG FLOW
//     if(moduleDecl->isTopModule() && (NSCdom::CDOmModuleDecl::GEN_FROM_UNDEFINED < m_moduleCslType)){
//       (*vfout) << "enum_define.v" << std::endl << std::endl;
//     }

//     //Iterating through instances and printing their respecive names according to 
//     //the presence/absence of instantiations
//     for(TVec_RefCDOmBase_const_iter iter = instDeclVec->begin(); iter < instDeclVec->end(); ++iter){
//       //checking to see if instantiation name is already in the map
//       //no else here, if it is,do nothing (otherwise a duplicate name will show)
//       if(m_instantiationsMap.get() && (m_instantiationsMap->find((CDOmModuleDecl::cast(*iter))->getModuleName()) == m_instantiationsMap->end())){
//         //if the name is not inn the map, add it so that we can test for it's existence later on
//         m_instantiationsMap->insert(TPair_RefString_RefCDOmBase((CDOmModuleDecl::cast(*iter))->getModuleName(), *iter));
//         //print the name in the vf file
//         RefString vfItem = (CDOmModuleDecl::cast(*iter))->getModuleName();
//         if((CDOmModuleDecl::cast(*iter))->hasInstantiations()){
//           (*vfout) << "-f " << *vfItem << ".vf";
//         }
//         else{
//           (*vfout) << *vfItem << ".v";
//         }
//         (*vfout) << std::endl;
//       }
//     }
//     //Printing the actual module name
//     (*vfout) << *(m_currentModuleName) << ".v" << std::endl;
//     delete vfout;
//   }

  //Output File Stream init
  //out = new std::ofstream(((*m_moduleFileName).append(".v")).c_str());
  out = new std::ofstream((m_outputPath + *m_moduleFileName).c_str());
  file = TRUE;

  //Initializations
  m_depth++;
  //std::cout << "m_depth is " << m_depth << std::endl;
  m_modcnt = 0;
  m_portItemSize = -1; //for the case when no port item is created
  RefTVec_RefCDOmPortItem portItemVec = moduleDecl->getPortItems();
  if(portItemVec.get()){
    m_portItemSize = portItemVec->size();
  }

  //Including defines
  if(*(m_currentModuleName) != "stim_expect_mem_template") { //-------OB added so that the template it's not included in the defines file
    defout << "`include \"" << *(m_currentModuleName) << "_define.v\"" << std::endl << std::endl;
  }
  //---------OB added because there are 2 different define files for stim & exp vectors which are not independent modules---start
  if(m_moduleCslType == CDOmModuleDecl::GEN_FROM_TB){
    m_vect = TRUE;
  }
  if(TRUE == m_vect) {
    defout << "`include \"" << "stim_define.v\"" << std::endl << std::endl; 
    defout << "`include \"" << "exp_define.v\"" << std::endl << std::endl;
    m_vect = FALSE;
  }
  //--------OB---end
  *(out) << "`include \"defines.v\"" << std::endl << std::endl;


  if(moduleDecl->getKeywordType()==CDOmModuleDecl::KEYWORD_MODULE){
    *(out) << "module ";
  }else if (moduleDecl->getKeywordType()==CDOmModuleDecl::KEYWORD_MACROMODULE){
    *(out) << "macromodule ";
  } else {
    *(out) << "/* Error in module declaration */" << std::endl;
  }
  //if(m_portItemSize = -1){
  //  *(out) << "();" << std::endl;
  //}
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ) {
  //std::cout << "ID parent is " << id->getParent()->getType() << std::endl;
  RefCDOmBase parent = id->getParent();
  if(parent->getType() == TYPE_DECL_MODULE){
    m_addIndent = id->getName()->size();
  }
  // *(out) << *(id->getName());
  *(out) << tmpl;

  if(id->supportsPayload()){
  RefCDOmBase payload = id->getPayload();
  if(payload.get()){
    //To be factored
    m_expandNum32 = TRUE;
    if (id->getIdType() == CDOmIdentifier::ID_UDP_PORT_OUTPUT_PL || id->getIdType() == CDOmIdentifier::ID_PARAM || (id->getIdType() == CDOmIdentifier::ID_VAR && payload->getType() != TYPE_RANGE_LIST) || ( id->getIdType() == CDOmIdentifier::ID_NET && payload->getType() != TYPE_RANGE_LIST ) || id->getIdType() == CDOmIdentifier::ID_PORT) 
      *(out) << " = ";
  }
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ){}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ){
  //Initializations
  m_exprLinkExprSize = 0;
  m_exprLinkExprCnt = 0;
  m_exprLinkListExprSize = 0;

  if(!exprLink->isHID()){
    *(out) << *(exprLink->getName());
  }
  else {
    m_exprLinkHidNames = exprLink->getHidNames();
    m_exprLinkExprs = exprLink->getHidExprs();
    if(m_exprLinkHidNames.get()) { 
      m_exprLinkExprSize = m_exprLinkHidNames->size();
      *(out) << *(m_exprLinkHidNames->at(m_exprLinkExprCnt));
      if((m_exprLinkExprs->at(m_exprLinkExprCnt)).get())
        *(out) << "[";
    }
  }

  RefCDOmListExpr listExpr = exprLink->getArrayIndexes();
   if(listExpr.get()) {
    m_exprLinkListExprSize = listExpr->getChildrenSize();
 }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ){
  //Initializations
  //m_posCnt = 0;
  m_exprCnt.push_back(0);

  RefCDOmBase parent = exprOp->getParent();
  if(parent.get() && parent->getType() == TYPE_EXPR){
    if(CDOmExpr::cast(parent)->getExprType() == CDOmExpr::EXPR_MINTYPMAX){
      *(out) << "(";
      }
  }

  if(exprOp->isUnary()){
    switch(exprOp->getOpType()){
      case(CDOmExprOp::OP_UNARY_ARITHMETIC_PLUS)  : *(out) << "+("               ;       break;
      case(CDOmExprOp::OP_UNARY_ARITHMETIC_MINUS) : *(out) << "-("               ;       break;
      case(CDOmExprOp::OP_UNARY_LOGIC_NOT)        : *(out) << "!("               ;       break;
      case(CDOmExprOp::OP_UNARY_BITWISE_NOT)      : *(out) << "~("               ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_AND)    : *(out) << "&("               ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_NAND)   : *(out) << "~&("              ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_OR)     : *(out) << "|("               ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_NOR)    : *(out) << "~|("              ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_XOR)    : *(out) << "^("               ;       break;
      case(CDOmExprOp::OP_UNARY_REDUCTION_XNOR)   : *(out) << "~^("              ;       break;
      default                                     : *(out) << "Error" <<std::endl;       break;
    }
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ){
  //Initializations
  m_listExprCnt = 0;
  m_listExprHasExprLinkParent = FALSE;
  m_listExprHasFunctionCallParent = FALSE;
  m_parent = listExpr->getParent();
  if(m_parent->getType() == TYPE_STMT){
    if(CDOmStmt::cast(m_parent)->getStmtType() == CDOmStmt::STMT_CASE){ 
      //// calling indenter function ////
      indt(m_depth);
    }
  } 
  if(m_parent.get()){
    if(m_parent->getType() == TYPE_EXPR){
      if((CDOmExpr::cast(m_parent))->getExprType() == CDOmExpr::EXPR_HID){
      m_listExprHasExprLinkParent = TRUE;
      *(out) << "[";
    } else if((CDOmExpr::cast(m_parent))->getExprType() == CDOmExpr::EXPR_FUNCTION_CALL){
      m_listExprHasFunctionCallParent = TRUE;
      *(out) << "(";
    }
  }
  }
  m_listExprSize = listExpr->getNumberOfChildren();
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ) {
  //Initializations
  //m_portDeclType = portDecl->getVarType();
  //if(portDecl->getVarType() == VAR_UNDEFINED || portDecl->getVarType() == VAR_REG){
  if(portDecl->getVarType() != VAR_TIME && portDecl->getVarType() != VAR_INTEGER){
    RefCDOmRange testRange = portDecl->getRange();
    if(testRange.get()){
      m_pdcnt = -1;
    }else{
      m_pdcnt = 0;
    }
  }else{
    m_pdcnt = 0;
  }
  RefTVec_RefCDOmIdentifier idVec = portDecl->getIDs();
  if(idVec.get()){
    m_portIdSize = idVec->size();
  }

  //// calling indenter function ////
  indt(m_depth);

  switch (portDecl->getPortType()){
    case (PORT_INOUT)  :    *(out) << "inout "                                   ;      break;
    case (PORT_INPUT)  :    *(out) << "input "                                   ;      break;
    case (PORT_OUTPUT) :    *(out) << "output "                                  ;      break;
    default            :    *(out) << "/*Error in port direction*/" << std::endl ;      break;
  }

  if(portDecl->getNetType()){
    switch (portDecl->getNetType()){
      case (NET_SUPPLY0) :         *(out) << "supply0 "                                 ;  break;
      case (NET_SUPPLY1) :         *(out) << "supply1 "                                 ;  break;
      case (NET_TRI)     :         *(out) << "tri "                                     ;  break;
      case (NET_TRIAND)  :         *(out) << "triand "                                  ;  break;
      case (NET_TRIOR)   :         *(out) << "trior "                                   ;  break;
      case (NET_TRI0)    :         *(out) << "tri0 "                                    ;  break;
      case (NET_TRI1)    :         *(out) << "tri1 "                                    ;  break;
      case (NET_WIRE)    :         *(out) << ""                                         ;  break;
      case (NET_WAND)    :         *(out) << "wand "                                    ;  break;
      case (NET_WOR)     :         *(out) << "wor "                                     ;  break;
      case (NET_TRIREG)  :         *(out) << "trireg "                                  ;  break;
      default            :         *(out) << "/*Error in net declaration*/" << std::endl;  break;
    }
  }else if(portDecl->getVarType()){
    switch (portDecl->getVarType()){
      case (VAR_REG     ) : *(out) << "reg "                                     ;  break;
      case (VAR_REAL    ) : *(out) << "real "                                    ;  break;
      case (VAR_REALTIME) : *(out) << "realtime "                                ;  break;
      case (VAR_TIME    ) : *(out) << "time "                                    ;  break;
      default             : *(out) << "/*Error in var declaration*/" << std::endl;  break;
    }
  }

  if(portDecl->getVarType() == VAR_UNDEFINED && (portDecl->getVarType() != VAR_INTEGER || portDecl->getVarType() != VAR_TIME)){
    if(portDecl->isSigned()){
      *(out) << "signed ";
    }
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ){
  //Initializations
  if(varDecl->getVarType() == VAR_REG){
    RefCDOmRange testRange = varDecl->getRange();
    if(testRange.get()){
      m_vrcnt = -1;
    }else{
      m_vrcnt = 0;
    } 
  }else{
      m_vrcnt = 0;
  }
  RefTVec_RefCDOmIdentifier varIdVec = varDecl->getIDs();
  if(varIdVec.get()){
    m_varIdSize = varIdVec->size();
  }
  
  //// calling indenter function ////
  indt(m_depth);

  if(varDecl->getVarType()){
    switch (varDecl->getVarType()){
      case (VAR_REG)      :  *(out) << "reg "                                         ;      break;
      case (VAR_INTEGER)  :  *(out) << "integer "                                     ;      break;
      case (VAR_REAL)     :  *(out) << "real "                                        ;      break;
      case (VAR_REALTIME) :  *(out) << "realtime "                                    ;      break;
      case (VAR_TIME)     :  *(out) << "time "                                        ;      break;
      default             :  *(out) << "/* Error in var declaration */" << std::endl  ;      break;
    }
  }else{
    DCERR("Error in var type");
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ){
  //Initializations
  RefCDOmRange testRange = netDecl->getRange();
  if(testRange.get()){
    m_ntcnt = -1;
  }else{
    m_ntcnt = 0;
  }
  RefTVec_RefCDOmIdentifier netIdVec = netDecl->getIDs();
  if(netIdVec.get()){
    m_netIdSize = netIdVec->size();
  }
  //indenter function
  indt(m_depth);

  if(netDecl->getNetType()){
    switch (netDecl->getNetType()) {
      case (NET_UNDEFINED):  /* do nothing here */                                ;      break;
      case (NET_SUPPLY0)  :  *(out) << "supply0 "                                 ;      break;
      case (NET_SUPPLY1)  :  *(out) << "supply1 "                                 ;      break;
      case (NET_TRI)      :  *(out) << "tri "                                     ;      break;
      case (NET_TRIAND)   :  *(out) << "triand "                                  ;      break;
      case (NET_TRIOR)    :  *(out) << "trior "                                   ;      break;
      case (NET_TRI0)     :  *(out) << "tri0 "                                    ;      break;
      case (NET_TRI1)     :  *(out) << "tri1 "                                    ;      break;
      case (NET_WIRE)     :  *(out) << "wire "                                    ;      break;
      case (NET_WAND)     :  *(out) << "wand "                                    ;      break;
      case (NET_WOR)      :  *(out) << "wor "                                     ;      break;
      case (NET_TRIREG)   :  *(out) << "trireg "                                  ;      break;
      default             :  ASSERT(FAIL, "Uninitialized or undefined enum data") ;      break;
    }
  } else {
    DCERR("Error in net type");
  }
  //condition: getNetDeclType returns NET_DECL_ID_ONLY
  if (netDecl->getNetDeclType() == 1 && netDecl->getNetType() == NET_TRIREG){
    switch(netDecl->getChargeStrength()){
      case (CDOmNetDecl::CHARGE_STRENGTH_UNDEFINED): /* do nothing here */                               ;   break;
      case (CDOmNetDecl::CHARGE_STRENGTH_SMALL)    : *(out) << "( small )"                               ;   break;
      case (CDOmNetDecl::CHARGE_STRENGTH_MEDIUM)   : *(out) << "( medium )"                              ;   break;
      case (CDOmNetDecl::CHARGE_STRENGTH_LARGE)    : *(out) << "( large )"                               ;   break;
      default                                      : ASSERT(FAIL, "Uninitialized or undefined enum data");   break;
    }
  }
  //condition: getNetDeclType returns NET_DECL_ID_EXPR_PAIR
  if (netDecl->getNetDeclType() == 2){
    switch(netDecl->getFirstDriveStrength()){
      case (DRIVE_STRENGTH_UNDEFINED): /* do nothing here */                               ; break;
      case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "( supply0, "                             ; break;
      case (DRIVE_STRENGTH_STRONG_0) : *(out) << "( strong0, "                             ; break;
      case (DRIVE_STRENGTH_PULL_0)   : *(out) << "( pull0, "                               ; break;
      case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "( weak0, "                               ; break;
      case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "( highz0, "                              ; break;
      case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "( supply1, "                             ; break;
      case (DRIVE_STRENGTH_STRONG_1) : *(out) << "( strong1, "                             ; break;
      case (DRIVE_STRENGTH_PULL_1)   : *(out) << "( pull1, "                               ; break;
      case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "( weak1, "                               ; break;
      case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "( highz1, "                              ; break;
      default                        : ASSERT(FAIL, "Uninitialized or undefined enum data"); break;
    }
    switch(netDecl->getSecondDriveStrength()){
      case (DRIVE_STRENGTH_UNDEFINED): /* do nothing here */                               ; break;
      case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "supply0 )"                               ; break;
      case (DRIVE_STRENGTH_STRONG_0) : *(out) << "strong0 )"                               ; break;
      case (DRIVE_STRENGTH_PULL_0)   : *(out) << "pull0 )"                                 ; break;
      case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "weak0 )"                                 ; break;
      case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "highz0 )"                                ; break;
      case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "supply1 )"                               ; break;
      case (DRIVE_STRENGTH_STRONG_1) : *(out) << "strong1 )"                               ; break;
      case (DRIVE_STRENGTH_PULL_1)   : *(out) << "pull1 )"                                 ; break;
      case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "weak1 )"                                 ; break;
      case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "highz1 )"                                ; break;
      default                        : ASSERT(FAIL, "Uninitialized or undefined enum data"); break;
    }
  }
 
  if(netDecl->getVectorAccessType() == CDOmNetDecl::VECTOR_ACCESS_VECTORED){
    *(out) << "vectored ";
  }
  else if (netDecl->getVectorAccessType() == CDOmNetDecl::VECTOR_ACCESS_SCALARED){
    *(out) << "scalared ";
  }
  if(netDecl->isSigned()){
    *(out) << "signed ";
  }
  
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmRange                           & range                       ){
  //if(range->getWidth() == 1){
  //  m_noRange = TRUE;
  //} else {
  //*(out) << "[";
  //}
   //redundat children retrival to cancel printing [0:0]
   RefTVec_RefCDOmBase rangeChildrenVec = range->getChildrenAsBase(TYPE_EXPR);
   if(rangeChildrenVec.get() && rangeChildrenVec->size() == 2){ 
     if(CDOmExpr::cast(rangeChildrenVec->at(0))->getExprType() == CDOmExpr::EXPR_NUMBER && CDOmExpr::cast(rangeChildrenVec->at(1))->getExprType() == CDOmExpr::EXPR_NUMBER){
       m_showRange = CDOmNumber::cast(rangeChildrenVec->at(0))->getValue() || CDOmNumber::cast(rangeChildrenVec->at(1))->getValue();
     }
   }
   if(m_showRange){
    *(out) << "[";
    m_rangeExprs = 0;
   }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmNum32                           & num                         ){
  //Indenter
  m_num32Indent = TRUE;
  if(m_showRange) {
    RefCDOmBase numParent = num->getParent();
    if(numParent.get() && numParent->getType() == TYPE_LIST_EXPR){
      // retrieving parent's parent: we need to check for the
      // particular case: case stmt -> list expr -> number when
      // the indent function should not be called
      RefCDOmBase numParentParent = numParent->getParent();
      if(numParentParent.get() && numParentParent->getType() == TYPE_STMT){
        if(CDOmStmt::cast(numParentParent)->getStmtType() == CDOmStmt::STMT_CASE){
          m_num32Indent = FALSE;
        }
      }
      if(m_num32Indent){
        //// calling indenter function ////
        indt(m_depth);
      }
    }
    m_num32value = num->getValue();
    m_num32width = num->getWidth();
    // this is for testing purposes (remove after CDOm/CSLOm fix)
    // m_num32width = 6;
    m_num32baseType = num->getNumBaseType();
    if(num->isSigned()){
      m_num32signed = TRUE;
    }
    else{
      m_num32signed = FALSE;
    }
    if(num->getIsVeriNumFlag()){
      m_expandNum32 = TRUE;
    }
    else{
      m_expandNum32 = FALSE; 
    }
    if(m_expandNum32){
      if(m_num32baseType != CDOmNumber::NUM_BASE_UNDEFINED){
        *(out) << m_num32width << "'";
        if(m_num32signed){
          *(out) << "s";
        } 
        switch(m_num32baseType){
          case (CDOmNumber::NUM_BASE_BIN) : 
            {
              *(out) << "b";
              *(m_num32TempStr) = dec2Bin(m_num32value, m_num32width);
              //reverse printing the string to get the order right
              for(TInt i = (*m_num32TempStr).size()-1; i >= 0; --i){
                *(out) <<  (*m_num32TempStr).at(i);
              }
              //m_num32TempStr.clear();
            }
            break;
          case (CDOmNumber::NUM_BASE_OCT) : 
            {
              *(out) << "o";
              m_num32Stream << std::oct << m_num32value;
              //m_num32Stream >> m_num32TempStr;
              (*m_num32TempStr) = m_num32Stream.str();
              //the width on which the number is represented
              //could be smaller and therefore zero-padding might
              //be required
              m_num32TempWidth = (*m_num32TempStr).size() * 3 ; //each oct digit is 3 bits
              while(m_num32TempWidth < m_num32width){
                *(out) << "0";
                m_num32TempWidth = m_num32TempWidth + 3;
              }
              *(out) << *m_num32TempStr;
              m_num32Stream.str(std::string());
              //m_num32TempStr.clear();
            }
            break;
          case (CDOmNumber::NUM_BASE_DEC) : 
            {
              *(out) << "d" << m_num32value;
            }
            break;
          case (CDOmNumber::NUM_BASE_HEX) : 
            {
              *(out) << "h";
              m_num32Stream << std::hex << m_num32value;
              //m_num32Stream >> m_num32TempStr;
              (*m_num32TempStr) = m_num32Stream.str();
              //the width on which the number is represented
              //could be smaller and therefore zero-padding might
              //be required
              m_num32TempWidth = (*m_num32TempStr).size() * 4 ; //each hex digit is 4 bits
              while(m_num32TempWidth < m_num32width){
                *(out) << "0";
                m_num32TempWidth = m_num32TempWidth + 4;
              }
              *(out) << *m_num32TempStr;
              m_num32Stream.str(std::string());
              //m_num32TempStr.clear();
            }
            break;
        }
      }
    } 
    else {
      *(out) << m_num32value;
     }
  }
  m_expandNum32 = FALSE;
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmReal                            & realNum                      ){
  *(out) << *(realNum->getTokenString());
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) {
  //Initializations
  m_intHasParams = FALSE;
  m_intExprCnt = 0;
  m_moduleInstantiationIndt = 0; //safe init
  RefTVec_RefCDOmBase exprsVec = moduleInstantiation->getChildrenAsBase(TYPE_EXPR);
  if(exprsVec.get()){
    m_intExprSize = exprsVec->size() - 1; //-1 because the first expr is the name of the instantiated module
    if(m_intExprSize > 0){
      m_intHasParams = TRUE;
    }
  }
  if(m_intHasParams){
    m_intcnt = -(m_intExprSize);
  }
  else {
    m_intcnt = 0;
  }
  
  m_moduleInstantiationIndt = moduleInstantiation->getModuleExprLink()->getName()->size() + 1; 

  //WARNING: disabled for now due to time constraints - it is fairly complex to calculate the width of the parameter 
  //assignment list as these can be identifiers or numbers (with variable digits)
  //if(m_intHasParams){
  //  m_moduleInstantiationIndt += 5; //for space, #, ( and ) and something else when params are used
  //  m_moduleInstantiationIndt += (m_intExprSize - 1);
  //}
  ///////////////////////////////////////////////////

  RefTVec_RefCDOmModuleOrUdpInstance moduleOrUdpInstanceVec = moduleInstantiation->getModuleInstances();
  if(moduleOrUdpInstanceVec.get()) {
    m_instanceNumSize = moduleOrUdpInstanceVec->size();
  }

  //// calling indenter function ////
  indt(m_depth);
  if(moduleInstantiation->getModuleInstantiationType() == CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN) {
    m_paramNameMapIt = moduleInstantiation->getExplicitParamNameMap()->begin();
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ){
  //Initializations
  m_inscnt = 0;
  m_insctrl = 0;
  m_moduleInstanceSize = 0;
  m_moduleInstanceExprSize = 0;
  m_moduleInstanceExprCnt = 0;
  m_moduleInstanceCnt = 0;
  m_emptyIndexesVec = RefTVec_TUInt();
  m_moduleInstanceIndt = (CDOmIdentifier::cast(moduleInstance->getChild(0))->getName())->size() + 1;
  if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_ORDERED_PORT_CONNECTION) {
    RefTVec_RefCDOmBase exprVec = moduleInstance->getChildrenAsBase(TYPE_EXPR);
    if(exprVec.get()) {
      m_moduleInstanceSize = exprVec->size();
      m_moduleInstanceExprSize = m_moduleInstanceSize;
    }
    
    m_emptyIndexesVec = moduleInstance->getEmptyIndexes();
    if(m_emptyIndexesVec != NULL) {
      reverse(m_emptyIndexesVec->begin(), m_emptyIndexesVec->end());
      m_moduleInstanceSize += m_emptyIndexesVec->size();
    }
  }
  else if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
    m_moduleInstanceSize = moduleInstance->getExplicitPortMap()->size();
    RefTVec_RefCDOmBase exprVec = moduleInstance->getChildrenAsBase(TYPE_EXPR);
    if(exprVec.get())
      m_moduleInstanceExprSize = exprVec->size();
  }
  //calling this if there are param assignments in instantiation
  //m_intHasParams and m_moduleInstanceIndt are initialized in the above function (beforeTraversal for
  //instantiation)
  if(m_intHasParams){
    indt(m_depth);
    portListIndt(m_moduleInstantiationIndt-1);
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {}   

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {
  //for initializations look below a few lines
    
  m_nameMap = paramDecl->getNameMap();
  if(m_nameMap.get()){
    m_paramDeclChildren = m_nameMap->size();
    for(TMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMap->begin(); iter != m_nameMap->end(); iter++) {
      m_namesVec.push_back(iter->first);
    }
  }

  //// calling indenter function ////
  indt(m_depth);

  if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SIMPLE){
    //WARNING: The following flag is set here for a quick fix - this may result
    //in a bug in CDOmPulseControl output
    m_pulseControlSection = FALSE;
    *(out) << "parameter ";
  } else if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_LOCAL){
    //WARNING: The following flag is set here for a quick fix - this may result
    //in a bug in CDOmPulseControl output
    m_pulseControlSection = FALSE;
    *(out) << "localparam ";
  } else if(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SPEC){
    m_pulseControlSection = FALSE;
    *(out) << "specparam ";
    RefTVec_RefCDOmPulseControl pulseVec = paramDecl->getPulseControls();
    if(pulseVec.get()){
      *(out) << std::endl;
    }
  } else {
    DCERR("Error: parameter type not specified");
  }

  if(paramDecl->getParamDeclType2() == 2){ //CDOmParamDecl::DECL_2
    if(paramDecl->getParamType() == CDOmParamDecl::PARAM_INTEGER){
      *(out) << "integer ";
    }
    if(paramDecl->getParamType() == CDOmParamDecl::PARAM_REAL){
      *(out) << "real ";
    }
    if(paramDecl->getParamType() == CDOmParamDecl::PARAM_REALTIME){
      *(out) << "realtime ";
    }
    if(paramDecl->getParamType() == CDOmParamDecl::PARAM_TIME){
      *(out) << "time ";
    }
    //Initializations 
    m_paramDeclPos = 0;
  } else {
    //Initializations -- called here to avoid illegal states 
    RefCDOmRange range = paramDecl->getRange();
    if(range.get()){
      m_paramDeclPos = -1;
    } else {
      m_paramDeclPos = 0;
    }
    //the first test is to avoid checking for signed attribute on specparams (would throw an exception)
    if(paramDecl->getParamDeclType2() != 0 && paramDecl->isSigned()){
      *(out) << "signed ";
    }
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ){
  //Initializations
  m_paramOverrideCnt = 0;
  m_paramOverrideSize = paramOverride->getChildrenSize();

  //// calling indenter function ////
  indt(m_depth);

  *(out) << "defparam ";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ){
  m_minTypMaxCnt = 0;
  RefTVec_RefCDOmBase minTypMaxChildrenVec = minTypMax->getChildrenAsBase(TYPE_EXPR);
  if(minTypMaxChildrenVec.get()){
    m_minTypMaxChildren = minTypMaxChildrenVec->size();
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmDelay                           & delay                       ){
  //Initializations
  m_delayPos = 0;
  m_delaySize = delay->getChildrenSize();
  m_delayDeclType = delay->getDelayDeclType();
  switch(m_delayDeclType){
    case (CDOmDelay::DECL_1) : m_delayHasParanths = FALSE; break;
    case (CDOmDelay::DECL_2) : m_delayHasParanths = FALSE; break;
    case (CDOmDelay::DECL_3) : m_delayHasParanths = FALSE; break;
    case (CDOmDelay::DECL_4) : m_delayHasParanths = TRUE ; break;
  }
  

  RefCDOmBase parent = delay->getParent();
  if(parent.get() && parent->getType() == TYPE_STMT){
    if(CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_ASSN){
      //// calling indenter function ////
      indt(m_depth);  
    }
  }

  *(out) << "#";
  if(m_delayHasParanths){
    //if(delay->getDelayType() == CDOmDelay::DELAY_2 || delay->getDelayType() == CDOmDelay::DELAY_3){
    //*(out) << "(";
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ){
  //// printing new line for readability ////
  *(out) << std::endl;
  ///////////////////////////////////////////

  //// calling indenter function ////
  indt(m_depth);
  //// entering new depth ////
  m_depth++;

  if(initOrAlways->getInitOrAlwaysType() == CDOmInitOrAlways::INIT_OR_ALWAYS_INIT ){
    *(out) << "initial ";
  } else if (initOrAlways->getInitOrAlwaysType() == CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS ){
    *(out) << "always ";
  }
  //the following may not be optimal but it works
  RefCDOmStmt initOrAlwaysChild = initOrAlways->getStmt();
  if(initOrAlwaysChild.get()){
    if(initOrAlwaysChild->getStmtType() == CDOmStmt::STMT_BLOCK_NAMED || initOrAlwaysChild->getStmtType() == CDOmStmt::STMT_BLOCK_UNNAMED){
      *(out) << std::endl;
    }
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmAssn                            & assn                        ){
  m_assnPos = 0;

  //// calling indenter function ////
  indt(m_depth);
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ){
  if(contAssn->hasDelay3()){
    m_contAssnPos = -1;
  } else {
    m_contAssnPos = 0;
  }
  
  RefTVec_RefCDOmAssn contAssnVec = contAssn->getNetAssns();
  m_contAssnSize = contAssnVec->size();

  //// calling indenter function ////
  indt(m_depth);

  *(out) << "assign ";
    if( contAssn->getFirstDriveStrength() != DRIVE_STRENGTH_UNDEFINED && contAssn->getSecondDriveStrength() != DRIVE_STRENGTH_UNDEFINED ){
    *(out) << "(";
    switch(contAssn->getFirstDriveStrength()){
      case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "supply0, "                       ;      break;
      case (DRIVE_STRENGTH_STRONG_0) : *(out) << "strong0, "                       ;      break;
      case (DRIVE_STRENGTH_PULL_0)   : *(out) << "pull0, "                         ;      break;
      case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "weak0, "                         ;      break;
      case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "highz0, "                        ;      break;
      case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "supply1, "                       ;      break;
      case (DRIVE_STRENGTH_STRONG_1) : *(out) << "strong1, "                       ;      break;
      case (DRIVE_STRENGTH_PULL_1)   : *(out) << "pull1, "                         ;      break;
      case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "weak1, "                         ;      break;
      case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "highz1, "                        ;      break;
      default                        : *(out) << "/* Error in drive strength */"   ;      break;
    }
    switch(contAssn->getSecondDriveStrength()){
      case (DRIVE_STRENGTH_SUPPLY_0) : *(out) << "supply0"                       ;      break;
      case (DRIVE_STRENGTH_STRONG_0) : *(out) << "strong0"                       ;      break;
      case (DRIVE_STRENGTH_PULL_0)   : *(out) << "pull0"                         ;      break;
      case (DRIVE_STRENGTH_WEAK_0)   : *(out) << "weak0"                         ;      break;
      case (DRIVE_STRENGTH_HIGHZ_0)  : *(out) << "highz0"                        ;      break;
      case (DRIVE_STRENGTH_SUPPLY_1) : *(out) << "supply1"                       ;      break;
      case (DRIVE_STRENGTH_STRONG_1) : *(out) << "strong1"                       ;      break;
      case (DRIVE_STRENGTH_PULL_1)   : *(out) << "pull1"                         ;      break;
      case (DRIVE_STRENGTH_WEAK_1)   : *(out) << "weak1"                         ;      break;
      case (DRIVE_STRENGTH_HIGHZ_1)  : *(out) << "highz1"                        ;      break;
      default                        : *(out) << "/* Error in drive strength */" ;      break;
    }
    *(out) << ") ";
    }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ){
  if(stmt->getStmtType() == CDOmStmt::STMT_NULL){
    //// calling indenter function ////
    indt(m_depth);

    *(out) << ";" << std::endl;
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ){
  if(!(stmtBlock->getChildrenAsBase()).get()){
    m_stmtBlockSize = 0;
  }else {
    m_stmtBlockSize = stmtBlock->getChildrenSize(); 
  }
  //// calling indenter function ////
  //indt(m_depth);
  //// entering new depth ////
  //m_depth++;

  if(stmtBlock->getBlockType() == CDOmStmtBlock::BLOCK_PARALLEL){
    *(out) << " fork "; //<< std::endl;
  } else if(stmtBlock->getBlockType() == CDOmStmtBlock::BLOCK_SEQUENTIAL) {
    *(out) << " begin ";//<< std::endl;
  }
  if(stmtBlock->isNamed()){
    *(out) << ": ";
    m_stmtBlockCnt = -1;
  } else {
    m_stmtBlockCnt = 0;
    *(out) << std::endl;
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ){
  m_stmtAssnPos = 0;
  //// Indenter logic //// requires further optimization
  RefCDOmBase parent = stmtAssn->getParent();
  if(parent.get() && parent->getType() == TYPE_STMT){
    //To be factored

    //The following types SHOULD NOT trigger indent
    //CDOmStmt::cast(parent)->getStmtType() != CDOmStmt::STMT_CASE 
    //CDOmStmt::cast(parent)->getStmtType() != CDOmStmt::STMT_IF

    //The following types SHOULD trigger indent
    if(CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_BLOCK_NAMED 
       || CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_BLOCK_UNNAMED ){
      //// calling indenter function ////
      indt(m_depth);
   } 
  }
  ///////////////////////
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ){
  m_eventCtrlType = eventCtrl->getEventControlType();
  switch( m_eventCtrlType ){
    case (CDOmEventControl::EVENT_CONTROL_HID)                   : *(out) << "@ ";                                      break;
    case (CDOmEventControl::EVENT_CONTROL_EVENT_EXPR)            : *(out) << "@( ";                                     break;
    case (CDOmEventControl::EVENT_CONTROL_STAR)                  : *(out) << "@* ";                                     break;
    case (CDOmEventControl::EVENT_CONTROL_STAR_WITH_PARENTHESIS) : *(out) << "@(*) ";                                   break;
    default                                                      : *(out) << "/* Could not fetch EventControl type */"; break;
  }
} 

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ){
  m_eventExprCnt.push_back(0);
  m_eventExprType = -1;
  m_eventExprType = eventExpr->getEventExprType();
  if( m_eventExprType == CDOmEventExpr::EVENT_EXPR_POSEDGE ){
    *(out) << "posedge ";
  } else if ( m_eventExprType == CDOmEventExpr::EVENT_EXPR_NEGEDGE ) {
    *(out) << "negedge";
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){
  *(out) << "#";
  if(delayCtrl->getDelayControlType() == CDOmDelayControl::DELAY_CONTROL_MINTYPMAX){
    *(out) << "( ";
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){
  //Initialization
  m_stmtPCAssnType = stmtPCAssn->getProcContAssnType();
  
  //// calling indenter function ////
  indt(m_depth);

  switch( m_stmtPCAssnType ){
    case (CDOmStmtProcContAssn::PROC_CONT_ASSN_ASSIGN  ) : *(out) << "assign "                        ;                break;
    case (CDOmStmtProcContAssn::PROC_CONT_ASSN_DEASSIGN) : *(out) << "deassign "                      ;                break;
    case (CDOmStmtProcContAssn::PROC_CONT_ASSN_FORCE   ) : *(out) << "force "                         ;                break;
    case (CDOmStmtProcContAssn::PROC_CONT_ASSN_RELEASE ) : *(out) << "release "                       ;                break;
    default                                              : *(out) << "/* Error in Proc Cont Assign */";                break;
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){
  m_stmtPTCtrlPos = 0;
  if(stmtPTCtrl->getParent()->getType() != TYPE_INITIAL_OR_ALWAYS){
  //// calling indenter function ////
  indt(m_depth);
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
  //Initializations
  m_caseType = stmtCase->getCaseType();
  m_stmtCaseCnt = 0;
  m_stmtCaseDefault = stmtCase->hasDefault();
  m_stmtCaseSize = stmtCase->getChildrenSize();
  /*
  RefTVec_RefCDOmBase stmtCaseVec = stmtCase->getChildrenAsBase(TYPE_ALL_TYPES);
  if(stmtCaseVec.get()){
    m_stmtCaseCnt = stmtCaseVec->size();
  }
  */

  *(out) << std::endl;
  //// calling indenter function ////
  indt(m_depth);
  //// entering new depth ////
  m_depth++;

  if(m_caseType == CDOmStmtCase::CASE_CASE){
    *(out) << "case ( ";
  } else if (m_caseType == CDOmStmtCase::CASE_CASE_Z) {
    *(out) << "casez ( ";
  } else if (m_caseType == CDOmStmtCase::CASE_CASE_X) {
    *(out) << "casex ( ";
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
  TBool indent = TRUE;
  //Initializations
  RefTVec_RefCDOmBase attrLists = stmtIf->getChildrenAsBase(TYPE_ATTR_LIST_COLLECTION);
  if(attrLists.get()){
    m_stmtIfCnt = -1;
    m_stmtIfHasAttrList = TRUE;
  }else{
    m_stmtIfCnt = 0;
    m_stmtIfHasAttrList = FALSE;
  }
  m_stmtIfSize = stmtIf->getChildrenSize();

  RefCDOmBase parent = stmtIf->getParent();
  if(parent.get() && parent->getType() == TYPE_STMT){
    RefCDOmStmt parentStmt = CDOmStmt::cast(parent);
    if(parentStmt->getStmtType() == CDOmStmt::STMT_PROC_TIMING_CONTROL){
      *(out) << std::endl;
    }
    if(parentStmt->getStmtType() == CDOmStmt::STMT_IF){
      indent = FALSE;
    }
  }
    
  //// calling indenter function ////
  if(indent){
    indt(m_depth);
  }
  //// entering new depth ////
  m_depth++;

  if(!m_stmtIfHasAttrList){
    *(out)  << "if ( ";
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
  //Initializations
  m_stmtLoopCnt = 0;
 
 *(out) << std::endl;

  //// calling indenter function ////
  indt(m_depth);
  //// entering new depth ////
  m_depth++;

  m_stmtLoopType = stmtLoop->getLoopType();
    switch( m_stmtLoopType ) {
      case( CDOmStmtLoop::LOOP_FOREVER ) :   *(out) << "forever "               ;          break;
      case( CDOmStmtLoop::LOOP_REPEAT  ) :   *(out) << "repeat ( "              ;          break;
      case( CDOmStmtLoop::LOOP_WHILE   ) :   *(out) << "while ( "               ;          break;
      case( CDOmStmtLoop::LOOP_FOR     ) :   *(out) << "for ( "                 ;          break;
      default                            :   *(out) << "/* Unknown Loop Type */";          break;
    }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
  //Initializations
  m_stmtTaskEnableSize = stmtTaskEnable->getChildrenSize();
  m_stmtTaskEnableCnt = 0;

  //// Indenter logic //// requires further optimization
  RefCDOmBase parent = stmtTaskEnable->getParent();
  if(parent.get() && parent->getType() == TYPE_STMT){
    if(!(CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_PROC_TIMING_CONTROL || CDOmStmt::cast(parent)->getStmtType() == CDOmStmt::STMT_CASE)){
      //// calling indenter function ////
      indt(m_depth);
    }
  } 
  ///////////////////////
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
  //Initializations
  m_stmtWaitCnt=0;

  //// calling indenter function ////
  indt(m_depth);

  *(out) << "wait (";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){

  //// calling indenter function ////
  indt(m_depth);

  *(out) << "disable ";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){
  *(out) << "<-";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
  //Initializations
  m_rangeExprPos = 0;
  m_rangeExprType = rangeExpr->getRangeExprType();
  *(out) << "[";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
  m_showRange = TRUE;
  m_expandNum32 = TRUE;
  //Initializations
  if (!m_exprConcatSize.get()) {
    m_exprConcatSize = RefTStack_TInt(new TStack_TInt());
  }

  m_exprConcatSize->push(exprConcat->getChildrenSize());
  *(out) << "{";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ){
  //Initializations
  m_exprMultiConcatPos = 0;
  *(out) << "{";
}


void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmUdpDecl                          & udpDecl                    ){
  //Initializations
  m_udpcnt = 0;
  //combEntry initializations
  m_combEntryCnt = 0;
  m_combEntrySize = -1;
  RefTVec_RefCDOmBase combEntriesAsBase = udpDecl->getChildrenAsBase(TYPE_UDP_COMB_ENTRY);
  if(combEntriesAsBase.get())
    m_combEntrySize = combEntriesAsBase->size();
  //seqEntry initializations
  m_seqEntryCnt = 0;
  m_seqEntrySize = -1;
  RefTVec_RefCDOmBase seqEntriesAsBase = udpDecl->getChildrenAsBase(TYPE_UDP_SEQ_ENTRY);
  if(seqEntriesAsBase.get())
    m_seqEntrySize = seqEntriesAsBase->size();
  m_udpOutPortName = RefString();
  *(out) << "primitive ";
}


void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmUdpPortDeclOutput                & udpPortDeclOutput                ) {
  //Initializations
  m_udpOutPortName = udpPortDeclOutput->getID()->getName();
  //indenter function
  indt(IND1);
  switch (udpPortDeclOutput->getPortType()){
    case (CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT)     :    *(out) << "output "                              ;      break;
    case (CDOmUdpPortDeclOutput::UDP_DECL_TYPE_REG)        :    *(out) << "reg "                                 ;      break;
    case (CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT_REG) :    *(out) << "output reg "                          ;      break;
    default                                                :    *(out) << "Error in port direction" << std::endl ;      break;
  }
}


void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput                ) {
  m_udpPdInputCnt = 0;
  RefTVec_RefCDOmIdentifier idVec = udpPortDeclInput->getIDs();
  if(idVec.get()){
    m_portIdSize = idVec->size();
  }
  indt(IND1);
  *(out) << "input ";
}


void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                    ) {
  indt(IND2);
  if(m_combEntryCnt == 0)
    *(out) << "table" << std::endl;
}


void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                     ) {
  indt(IND2);
  if(m_seqEntryCnt == 0)
    *(out) << "table" << std::endl;
}


void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                     ) {
  indt(IND2);
    *(out) << "initial ";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                        ){
  //Initializations
  m_taskDeclCnt = 0;
  m_taskDeclPortItemSize = -1;
  RefTVec_RefCDOmBase portItemsVec = taskDecl->getChildrenAsBase(TYPE_TF_PORT_DECL);
  if(portItemsVec.get()) {
    m_taskDeclPortItemSize = portItemsVec->size();
  }

  *(out) << "task ";
  if(taskDecl->isAutomatic()){
    *(out) << "automatic ";
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                       ) {
  m_tfPortDeclSize = -1;
  if((tfPortDecl->getVarType() == VAR_REG || tfPortDecl->getVarType() == VAR_UNDEFINED) && (tfPortDecl->getRange()).get())
    m_tfPortDeclCnt = -1;
  else 
    m_tfPortDeclCnt = 0;
  RefTVec_RefCDOmIdentifier idVec = tfPortDecl->getIDs();
  if(idVec.get()) {
    m_tfPortDeclSize = idVec->size();
  } 

//  RefCDOmBase parent = tfPortDecl->getParent();
//  if(parent.get() && (parent->getType() == TYPE_DECL_TASK && CDOmTaskDecl::cast(parent)->getTaskDeclType() == CDOmTaskDecl::TASK_DECL_WITHOUT_TASK_PORT_LIST ||
//      (parent->getType() == TYPE_DECL_FUNCTION && (CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE  ||
//                                                   CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE ||
//                                                   CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST))))
//
//    indt(IND1);
  ECDOmPortType portType = tfPortDecl->getPortType();
  ECDOmVarType varType = tfPortDecl->getVarType();

  switch(portType) {
    case(PORT_INPUT)  : *(out) << "input "                                  ;   break;
    case(PORT_OUTPUT) : *(out) << "output "                                 ;   break;
    case(PORT_INOUT)  : *(out) << "inout "                                  ;   break;
    default           : ASSERT(FAIL, "Uninitialized or undefined enum data");   break;
  }

  switch(varType) {
    case(VAR_UNDEFINED): /* do nothing here */                               ;  break;    
    case(VAR_REG)      : *(out) << "reg "                                    ;  break;
    case(VAR_INTEGER)  : *(out) << "integer "                                ;  break;
    case(VAR_REAL)     : *(out) << "real "                                   ;  break;
    case(VAR_REALTIME) : *(out) << "realtime "                               ;  break;
    case(VAR_TIME)     : *(out) << "time "                                   ;  break;
    default            : ASSERT(FAIL, "Uninitialized or undefined enum data");  break;
  }
  if(varType == VAR_REG && tfPortDecl->isSigned())
    *(out) << "signed ";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
  //Initializations
  m_funcDeclCnt = 0;
  //m_funcDeclPos Override in case of Range Object present
  RefTVec_RefCDOmBase funcDeclRange = funcDecl->getChildrenAsBase(TYPE_RANGE);
  if(funcDeclRange.get()) {
    m_funcDeclCnt = -1;
    m_hasRange = TRUE;
  }
  else
    m_hasRange = FALSE;
  *(out) << std::endl;
  m_funcDeclType = funcDecl->getFuncDeclType();
  *(out) << "function ";
  if(funcDecl->isAutomatic()){
    *(out) << "automatic ";
  }
  if(funcDecl->isSigned()){
    *(out) << "signed ";
  }
  if(m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE || m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE) {
    switch(funcDecl->getVarType()) {
      case(VAR_UNDEFINED): /* do nothing here */                               ;  break;
      case(VAR_INTEGER)  : *(out) << "integer "                                ;  break;
      case(VAR_REAL)     : *(out) << "real "                                   ;  break;
      case(VAR_REALTIME) : *(out) << "realtime "                               ;  break;
      case(VAR_TIME)     : *(out) << "time "                                   ;  break;
      default            : ASSERT(FAIL, "Uninitialized or undefined enum data");  break;
    }
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmFunctionCall                        & functionCall                    ){
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmGenvarDecl                          & genvarDecl                      ){
  //Initializations
  m_genvarDeclCnt = 0;
  m_genvarDeclSize = genvarDecl->getChildrenSize();
  *(out) << "genvar ";
}

void CVerilogGenerator::beforeTraversal(const NSCdom::RefCDOmGenInst                             & genInst                         ){
  *(out) << "generate " << std::endl;
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemNull                         & genItemNull                     ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemIf                           & genItemIf                       ){
  //Initializations
  m_genItemIfCnt = 0;
  m_genItemIfSize = genItemIf->getChildrenSize();
  *(out) << "if (";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemCase                         & genItemCase                     ){
  //Initializations
  m_genItemCaseCnt = 0;
  m_genItemCaseDefault = genItemCase->hasDefault();
  m_genItemCaseSize = genItemCase->getChildrenSize();

  *(out) << "case ( ";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemLoop                         & genItemLoop                     ){
  //Initializations
  m_genItemLoopCnt = 0;
  *(out) << "for( ";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmGenItemBlock                        & genItemBlock                    ){
  //Initializations
  m_genItemBlockSize = genItemBlock->getChildrenSize(); 
  indt(IND1);

  *(out) << "begin ";//<< std::endl;

  if(genItemBlock->isNamed()){
    *(out) << ": ";
    m_genItemBlockCnt = -1;
  } else {
    m_genItemBlockCnt =  0;
    *(out) << std::endl;
  }
  //indt(IND3);
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmString                              & stringObj                       ){
  *(out) << "\"" << *(stringObj->getTokenString()) << "\"" ;
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmEventDecl                           & eventDecl                       ){
  //Initializations
  m_eventDeclCnt = 0;
  RefTVec_RefCDOmIdentifier eventDeclVec = eventDecl->getIDs();
  if(eventDeclVec.get()){
    m_eventDeclSize = eventDeclVec->size();
  }else{
    m_eventDeclSize = 0;
  }
  *(out) << "event ";
  
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmSpecifyBlock                        & specifyBlock                     ){
  //// calling indenter function ////
  indt(m_depth);
  //// entering new depth ////
  m_depth++;
  
  *(out) << "specify " << std::endl;
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl       & pulseSSCd                        ){
  m_pulseSSCdType = pulseSSCd->getDeclType();
  
  //// calling indenter function ////
  indt(m_depth);

  switch(m_pulseSSCdType){
    case (CDOmPulseStyleOrShowCancelledDecl::PULSESTYLE_ONEVENT ): *(out) << "pulsestyle_onevent " ; break;
    case (CDOmPulseStyleOrShowCancelledDecl::PULSESTYLE_ONDETECT): *(out) << "pulsestyle_ondetect "; break;
    case (CDOmPulseStyleOrShowCancelledDecl::SHOWCANCELLED      ): *(out) << "showcancelled "      ; break;
    case (CDOmPulseStyleOrShowCancelledDecl::NOSHOWCANCELLED    ): *(out) << "noshowcancelled "    ; break;
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmPathDecl                            & pathDecl                         ){
  //Initializations
  m_pathDeclIsSimple = FALSE;
  //m_pathDeclIsSimpleAndFull = FALSE;
  m_pathDeclIsEdge = FALSE;
  m_pathDeclIsStateSimpleIf = FALSE;
  m_pathDeclIsStateEdgeIf = FALSE;
  m_pathDeclIsStateSimpleIfNone = FALSE;
  m_pathDeclhasPolarityOp = FALSE;
  //children counter
  m_pathDeclCnt = 0;
  //path decl type
  m_pathDeclReturn = pathDecl->getType();
  switch(m_pathDeclReturn){
    case(CDOmPathDecl::PATH_DECL_SIMPLE       ): m_pathDeclIsSimple            = TRUE; break;
    case(CDOmPathDecl::PATH_DECL_EDGE         ): m_pathDeclIsEdge              = TRUE; break;
    case(CDOmPathDecl::PATH_DECL_SIMPLE_IF    ): m_pathDeclIsStateSimpleIf     = TRUE; break;
    case(CDOmPathDecl::PATH_DECL_EDGE_IF      ): m_pathDeclIsStateEdgeIf       = TRUE; break;
    case(CDOmPathDecl::PATH_DECL_SIMPLE_IFNONE): m_pathDeclIsStateSimpleIfNone = TRUE; break;
  }
  if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS || pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
    m_pathDeclhasPolarityOp = TRUE;
  }

  //// Beginning of output ////
  
  //// calling indenter function ////
  indt(m_depth);

  if(m_pathDeclIsSimple || m_pathDeclIsEdge){
    *(out) << "( ";
  }
  if(m_pathDeclIsEdge){
    if( pathDecl->getEdgeIdentifier() == CDOmPathDecl::PATH_DECL_POSEDGE ){
      *(out) << "posedge ";
    }else if ( pathDecl->getEdgeIdentifier() == CDOmPathDecl::PATH_DECL_NEGEDGE ){
      *(out) << "negedge ";
    }
  }
  if(m_pathDeclIsStateSimpleIf || m_pathDeclIsStateEdgeIf){
    *(out) << "if ( " ;
  }
  if(m_pathDeclIsStateSimpleIfNone){
    *(out) << "ifnone ( ";
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmPathDelayValue                      & pathDelayValue                   ){
  if(pathDelayValue->getStyle() == CDOmPathDelayValue::PATH_DELAY_WITH_PAREN){
    *(out) << "( ";
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmMinTypMaxList                       & minTypMaxList                    ){
  m_minTypMaxListCnt = 0;
  m_minTypMaxListSize = minTypMaxList->getNumberOfChildren();
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmSpecifyTerminalList                 & specifyTerminalList              ){
  m_specifyTListCnt = 0;
  m_specifyTListSize = specifyTerminalList->getNumberOfChildren();
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmDelayedDataOrReference              & delayedDataOrRef                 ){
  m_delayedDataOrRefCnt = 0;
  m_delayedDataOrRefSize = delayedDataOrRef->getChildrenSize();
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmTimingCheckEventControl             & timingCkEventCtrl                ){
  m_timingCheckType = timingCkEventCtrl->getTimingCheckType();
  switch(m_timingCheckType){
    case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_POSEDGE) : *(out) << "posedge "; break;
    case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_NEGEDGE) : *(out) << "negedge "; break;
    case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_EDGE   ) : {
      *(out) << "edge [ ";
      RefTVec_TInt m_timingCheckEdgeDescriptor = timingCkEventCtrl->getEdgeDescriptors();
      if(m_timingCheckEdgeDescriptor.get()){
        for(TVec_TInt_const_iter iter = m_timingCheckEdgeDescriptor->begin(); iter < m_timingCheckEdgeDescriptor->end(); iter++){
          switch(*iter){
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_01) : *(out) << "01 "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_10) : *(out) << "10 "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_x0) : *(out) << "x0 "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_z0) : *(out) << "z0 "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_x1) : *(out) << "x1 "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_z1) : *(out) << "z1 "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0x) : *(out) << "0x "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0z) : *(out) << "0z "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1x) : *(out) << "1x "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1z) : *(out) << "1z "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_X0) : *(out) << "X0 "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_Z0) : *(out) << "Z0 "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_X1) : *(out) << "X1 "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_Z1) : *(out) << "Z1 "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0X) : *(out) << "0X "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0Z) : *(out) << "0Z "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1X) : *(out) << "1X "; break;
            case (CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1Z) : *(out) << "1Z "; break;
          }
        }
      }
      *(out) << "]";
    } break;
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmTimingCheckEvent                    & timingCkEvent               ){
  if(timingCkEvent->canBeControlled()){
    m_timingCheckEventCnt = -1;
  }else{
    m_timingCheckEventCnt = 0;
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmSystemTimingCheck                   & systemTimingCk              ){
  m_systemTimingCkCnt = 0;
  m_systemTimingCkSize = systemTimingCk->getChildrenSize();
  m_systemTimingCkType = systemTimingCk->getTimingCheckType();

  //// calling indenter function ////
  indt(m_depth);

  switch(m_systemTimingCkType){
    case(CDOmSystemTimingCheck::TIMING_CHECK_SETUP    ) : *(out) << "$setup ( "    ; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_HOLD     ) : *(out) << "$hold ( "     ; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_SETUPHOLD) : *(out) << "$setuphold ( "; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_RECOVERY ) : *(out) << "$recovery ( " ; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_REMOVAL  ) : *(out) << "$removal ( "  ; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_RECREM   ) : *(out) << "$recrem ( "   ; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_SKEW     ) : *(out) << "$skew ( "     ; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_TIMESKEW ) : *(out) << "$timeskew ( " ; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_FULLSKEW ) : *(out) << "$fullskew ( " ; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_PERIOD   ) : *(out) << "$period ( "   ; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_WIDTH    ) : *(out) << "$width ( "    ; break;
    case(CDOmSystemTimingCheck::TIMING_CHECK_NOCHANGE ) : *(out) << "$nochange ( " ; break;
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmGateInstantiation              & gateInstantiation         ){
  //// calling indenter function ////
  indt(m_depth);

  m_gateInstanceType = gateInstantiation->getPrimitiveType();
  switch(m_gateInstanceType){
    case (CDOmGateInstantiation::GATE_INST_CMOS    ) : *(out) << "cmos "     ; break;
    case (CDOmGateInstantiation::GATE_INST_RCMOS   ) : *(out) << "rcmos "    ; break;
    case (CDOmGateInstantiation::GATE_INST_BUFIF0  ) : *(out) << "bufif0 "   ; break;
    case (CDOmGateInstantiation::GATE_INST_BUFIF1  ) : *(out) << "bufif1 "   ; break;
    case (CDOmGateInstantiation::GATE_INST_NOTIF0  ) : *(out) << "notif0 "   ; break;
    case (CDOmGateInstantiation::GATE_INST_NOTIF1  ) : *(out) << "notif1 "   ; break;
    case (CDOmGateInstantiation::GATE_INST_NMOS    ) : *(out) << "nmos "     ; break;
    case (CDOmGateInstantiation::GATE_INST_PMOS    ) : *(out) << "pmos "     ; break;
    case (CDOmGateInstantiation::GATE_INST_RNMOS   ) : *(out) << "rnmos "    ; break;
    case (CDOmGateInstantiation::GATE_INST_RPMOS   ) : *(out) << "rpmos "    ; break;
    case (CDOmGateInstantiation::GATE_INST_AND     ) : *(out) << "and "      ; break;
    case (CDOmGateInstantiation::GATE_INST_NAND    ) : *(out) << "nand "     ; break;
    case (CDOmGateInstantiation::GATE_INST_OR      ) : *(out) << "or "       ; break;
    case (CDOmGateInstantiation::GATE_INST_NOR     ) : *(out) << "nor "      ; break;
    case (CDOmGateInstantiation::GATE_INST_XOR     ) : *(out) << "xor "      ; break;
    case (CDOmGateInstantiation::GATE_INST_XNOR    ) : *(out) << "xnor "     ; break;
    case (CDOmGateInstantiation::GATE_INST_BUF     ) : *(out) << "buf "      ; break;
    case (CDOmGateInstantiation::GATE_INST_NOT     ) : *(out) << "not "      ; break;
    case (CDOmGateInstantiation::GATE_INST_TRANIF0 ) : *(out) << "tranif0 "  ; break;
    case (CDOmGateInstantiation::GATE_INST_TRANIF1 ) : *(out) << "tranif1 "  ; break;
    case (CDOmGateInstantiation::GATE_INST_RTRANIF1) : *(out) << "rtranif1 " ; break;
    case (CDOmGateInstantiation::GATE_INST_RTRANIF0) : *(out) << "rtranif0 " ; break;
    case (CDOmGateInstantiation::GATE_INST_TRAN    ) : *(out) << "tran "     ; break;
    case (CDOmGateInstantiation::GATE_INST_RTRAN   ) : *(out) << "rtran "    ; break;
    case (CDOmGateInstantiation::GATE_INST_PULLDOWN) : *(out) << "pulldown " ; break;
    case (CDOmGateInstantiation::GATE_INST_PULLUP  ) : *(out) << "pullup "   ; break;
    default :  *(out) << "/* Unknown gate type */"                           ; break;
  }
  gateVec = gateInstantiation->getChildrenAsBase();
  m_gateInstanceSize = gateVec->size();
  m_gateInstanceCnt = 0;
  m_gateInstanceFlag = FALSE;


}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmPulseControl                   & pulseControl              ){
  m_pulseControlSection = TRUE;
  m_pulseControlSize = pulseControl->getChildrenSize();
  indt(m_depth);
  *(out) << "PATHPULSE$";
  if(!(m_pulseControlSize > 2)){
    m_pulseControlCnt = 0;
    *(out) << " = ( ";
    m_pulseControlLong = FALSE;
  }else {
    m_pulseControlCnt = -2;
    m_pulseControlLong = TRUE;
  }
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmAttrList                       & attrList                  ){
  //Initializations
  m_attrListSize = attrList->getChildrenSize();
  m_attrListCnt = 0;
  
  *(out) << "(* "; 
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmDefine                         & define                   ){
  //saving the current output stream
  //Reason: defines may be inside modules
  m_tempStream = out;
  //setting new output stream
//   out = defout;
  m_defineType = define->getDefineType();
  if(m_defineType == CDOmDefine::DEFINE_TYPE_DEFINE){
    defout << "`define ";
  }
  else if(m_defineType == CDOmDefine::DEFINE_TYPE_UNDEF){
    defout << "`undef ";
  }
  defout << *(define->getMacroName()) << " ";
}

void CVerilogTbGenerator::beforeTraversal(const NSCdom::RefCDOmComment                         & comment                  ){
  m_commentType = comment->getCommentType();
  m_commentStar = FALSE;
  if(m_commentType == CDOmComment::TYPE_SLASH_SLASH){
    *(out) << "// ";
  } else if (m_commentType == CDOmComment::TYPE_SLASH_STAR){
    m_commentStar = TRUE;
    *(out) << "/*" << std::endl;
  }
  RefTVec_RefString commentsVec = comment->getCommentText();
  if(commentsVec.get()){
    for(TVec_RefString_const_iter iter = commentsVec->begin(); iter < commentsVec->end(); ++iter){
      *(out) << *(*iter) << std::endl;
    }
  }
}

//********************************************************************************
// In traversal block
//********************************************************************************

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmDesign                          & design                      ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ){
  m_modcnt++;

  if(m_modcnt == 1 && m_portItemSize == -1){
    *(out) << "();" << std::endl;
  } else if (m_modcnt == 1 && m_portItemSize != -1) {
    *(out) << "(";
  }
 
  if(m_modcnt != 1 && m_modcnt < (m_portItemSize + 1) && m_portItemSize != 1){
    *(out) << "," << std::endl;

    //// calling portList indenter function ////
    portListIndt(7 + m_addIndent + 1);

  } else if (m_modcnt == m_portItemSize + 1){
    *(out) << ");" << std::endl;
    m_addIndent = 0;
  }
  //if(m_modcnt > m_portItemSize && m_modcnt < moduleDecl->getChildrenSize())
    //indt(IND2);

}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ){
  m_exprLinkExprCnt++;
  if(m_exprLinkExprCnt < m_exprLinkExprSize) {
    if((m_exprLinkExprs->at(m_exprLinkExprCnt - 1)).get())
      *(out) << "].";
    else
      *(out) << ".";
    *(out) << *(m_exprLinkHidNames->at(m_exprLinkExprCnt));
    if((m_exprLinkExprs->at(m_exprLinkExprCnt)).get())
      *(out) << "[";
  }

// if(m_exprLinkListExprSize) {
//    if(m_exprLinkExprCnt == m_exprLinkExprSize)
//      *(out) << "[";
//    else if((m_exprLinkExprCnt > m_exprLinkExprSize) && (m_exprLinkExprCnt < m_exprLinkExprSize + m_exprLinkListExprSize))
//      *(out) << "][";
//    else if(m_exprLinkExprCnt == m_exprLinkExprSize + m_exprLinkListExprSize)
//      *(out) << "]"; 
//  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ){
  //m_posCnt++;
  m_exprCnt.back()++;

  if(exprOp->isBinary() && m_exprCnt.back() == 1){
    switch(exprOp->getOpType()){
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS)          : *(out) << " + "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS)         : *(out) << " - "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY)      : *(out) << " * "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_DIV)           : *(out) << " / "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_MOD)           : *(out) << " % "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_POW)           : *(out) << " ** "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT)    : *(out) << " <<< "                                      ;       break;
      case(CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT)   : *(out) << " >>> "                                      ;       break;
      case(CDOmExprOp::OP_BINARY_EQUALITY_EQ)              : *(out) << " == "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ)          : *(out) << " != "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_IDENTITY_EQ_CASE)         : *(out) << " === "                                      ;       break;
      case(CDOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE)     : *(out) << " !== "                                      ;       break;
      case(CDOmExprOp::OP_BINARY_LOGIC_AND)                : *(out) << " && "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_LOGIC_OR)                 : *(out) << " || "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_RELATIONAL_LESS)          : *(out) << " < "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL)    : *(out) << " <= "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_RELATIONAL_GREATER)       : *(out) << " > "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL) : *(out) << " >= "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_AND)              : *(out) << " & "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_NAND)             : *(out) << " ~& "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_OR)               : *(out) << " | "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_NOR)              : *(out) << " ~| "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_XOR)              : *(out) << " ^ "                                        ;       break;
      case(CDOmExprOp::OP_BINARY_BITWISE_XNOR)             : *(out) << " ~^ "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_SHIFT_LEFT)               : *(out) << " << "                                       ;       break;
      case(CDOmExprOp::OP_BINARY_SHIFT_RIGHT)              : *(out) << " >> "                                       ;       break;
      default                                              : *(out) << "/*Error in binary expression */" <<std::endl;       break;
      }
  }
  if(exprOp->isTernary()){
    if(m_exprCnt.back() == 1){
      *(out) << " ? ";
    } else if(m_exprCnt.back() == 2){
      *(out) << " : ";
    }
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ){
  m_listExprCnt++;
  if(m_listExprCnt < m_listExprSize && m_listExprSize > 1 ){
    if( m_listExprHasExprLinkParent){
      *(out) << "][";
    } else {
      *(out) << ", ";
    }
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ){
  m_pdcnt++;
  if(m_pdcnt > 0 && m_pdcnt < m_portIdSize && m_portIdSize != 1){
    *(out) << ", ";
  }

}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ){
  m_vrcnt++;
  if(m_vrcnt > 0 && m_vrcnt < m_varIdSize && m_varIdSize > 1){
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ){
  m_ntcnt++;
  //if(m_ntcnt <= m_netIdSize && m_netIdSize != 1){
  if(m_ntcnt > 0 && m_ntcnt < m_netIdSize && m_netIdSize != 1){
    *(out) << ", ";
  }
}


void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmRange                           & range                       ){
  if(m_showRange){
    m_rangeExprs++;
    //if(m_rangeExprs == 1 && !m_noRange){
    if(m_rangeExprs == 1){
      *(out) << ":";
    }
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmNum32                           & num                         ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmReal                            & realNum                     ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ){
  //parameter value init logic(caution: named param assn only; no support for ordered yet)
  m_intExprCnt++;

  if(m_intHasParams){
    if(m_intExprCnt == 1){
      *(out) << " #(";
    }
    if(m_intExprCnt > 1 && m_intExprCnt <= m_intExprSize && m_intExprSize !=1){
      *(out) << "),\n";
      indt(m_depth);
      portListIndt(m_moduleInstantiationIndt);
    }
    if(m_intExprCnt == m_intExprSize+1 ){
      *(out) << "))" << std::endl;
    }
    if((moduleInstantiation->getModuleInstantiationType() == CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_NAMED_PARAM_ASSN)
       &&(m_intExprCnt <= m_intExprSize)) {    
      *(out) << ".";
      *(out) << *(m_paramNameMapIt->first);
      ++m_paramNameMapIt;
      *(out) << "(";
    }
  }
  //f2a / ordered connection logic
  m_intcnt++;

  if(m_intcnt == 1){
    *(out) << " ";
  }
  if(m_intcnt > 1 && m_intcnt <= m_instanceNumSize && m_instanceNumSize != 1) {
      *(out) << ", " << std::endl;
      indt(m_depth);
      DCERR ("moduleInstIndt is " << m_moduleInstanceIndt);
      portListIndt(m_moduleInstantiationIndt);
    }
}

void CVerilogtbGenerator::inTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ) {
  if(moduleInstance->getModuleInstanceType()==CDOmModuleOrUdpInstance::MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
    RefTMap_RefString_RefCDOmExpr explicitPortNameMap = moduleInstance->getExplicitPortMap();
    if(explicitPortNameMap.get()) {
      TMap_RefString_RefCDOmExpr_constIter iter = explicitPortNameMap->begin();
      if(m_moduleInstanceCnt == 0) { 
        *(out) << "(." << *(iter->first) << "(";
        if(!iter->second.get()){
          //*(out) << "/* not connected */";
        }
        m_moduleInstanceCnt++;
      }
      else {
        if(m_moduleInstanceCnt < m_moduleInstanceSize) {
          for(int i = 1; i <= m_moduleInstanceCnt; ++i)
            iter++; 
          *(out) << ")," << std::endl;
          indt(m_depth);
          portListIndt(m_moduleInstanceIndt + m_moduleInstantiationIndt);
          *(out) << "." << *(iter->first) << "(";
          m_moduleInstanceCnt++;
          //if(!iter->second.get())
          //  *(out) << "()";
        }
        else if(m_moduleInstanceCnt == m_moduleInstanceSize)
          *(out) << ")";
      }
    }
  } else if(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_ORDERED_PORT_CONNECTION) {
    if(m_emptyIndexesVec != NULL) {
      if(m_moduleInstanceCnt == 0) {
        *(out) << "(";
        m_moduleInstanceCnt++;
        //if(m_emptyIndexesVec->back() == 0)
        //  *(out) << " ";
      }
      if(m_emptyIndexesVec->size() == 1)
        m_emptyIndexesVec->pop_back();
      if((m_moduleInstanceCnt == 1 && m_emptyIndexesVec->size() == 0 && m_inscnt == 0) || (m_moduleInstanceCnt == 1 && m_emptyIndexesVec->back() != 0 && m_inscnt == 0)) {
        m_moduleInstanceCnt++;
        m_moduleInstanceExprCnt++;
      }
      else {
        if((m_inscnt + 2 < m_moduleInstanceSize) && (m_inscnt != m_emptyIndexesVec->back())) {
          *(out) << "," << std::endl;
          indt(m_depth);
          portListIndt(m_moduleInstanceIndt + m_moduleInstantiationIndt);
          m_inscnt++;
          m_moduleInstanceExprCnt++;
        }
        while(m_emptyIndexesVec->size() > 1 && m_inscnt == m_emptyIndexesVec->back()) {
          *(out) << "," << std::endl;
          indt(m_depth);
          portListIndt(m_moduleInstanceIndt + m_moduleInstantiationIndt);
          m_inscnt++;
          m_emptyIndexesVec->pop_back();
          if(m_emptyIndexesVec->size() == 1 && m_moduleInstanceExprCnt < m_moduleInstanceExprSize) {
            *(out) << "," << std::endl;
            indt(m_depth);
            portListIndt(m_moduleInstanceIndt + m_moduleInstantiationIndt);
          }
        }
      }
    }
    else {
      if(m_moduleInstanceCnt == 0) {
        *(out) << "(";
        m_moduleInstanceCnt++;
      }
      else 
        if(m_moduleInstanceCnt < m_moduleInstanceExprSize) {
          *(out) << "," << std::endl;
          indt(m_depth);
          portListIndt(m_moduleInstanceIndt + m_moduleInstantiationIndt);  
          m_moduleInstanceCnt++;
        }
    }
  }  
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {} 
  
void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {
  m_paramDeclPos++;

  if(m_paramDeclPos > 0 && m_paramDeclPos < m_paramDeclChildren ){
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ){
  m_paramOverrideCnt++;
  //The following could be done by retrieving the current child and calling getExprType() on it, however
  //this method may be simpler since it does not create any new objects and the Verilog syntax is fixed 
  //in this case: if the current child is in an odd position it's the hid, if it's on en even position, 
  //it's the minTypMax expression (Note: counting starts at 1, because counter is incremented before evaluation)
  if(m_paramOverrideCnt % 2 == 1){
    *(out) << " = ";
  }else if (m_paramOverrideCnt % 2 == 0 && m_paramOverrideCnt < m_paramOverrideSize ){
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ){
  m_minTypMaxCnt++;
  if((m_minTypMaxCnt == 1 || m_minTypMaxCnt == 2) && m_minTypMaxChildren > 1){
    *(out) << ":";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmDelay                           & delay                       ){
  m_delayPos++;
  //if(delay->getDelayType() == CDOmDelay::DELAY_2 || delay->getDelayType() == CDOmDelay::DELAY_3){
  if(m_delayHasParanths){
    if(m_delayPos < m_delaySize){
      *(out) << ", ";
    }
  }
    /*
      if( delay->getDelayType() == 0 && m_delayPos == 1 ){
      *(out) << ",";
      } else if(delay->getDelayType() == 1 && (m_delayPos == 1 || m_delayPos == 2) ){
      *(out) << ",";
      }
    */
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmAssn                            & assn                        ){
  m_assnPos++;
  if(m_assnPos == 1){
    *(out) << " = ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ){
  m_contAssnPos++;
  if(m_contAssnPos > 0 && m_contAssnPos < m_contAssnSize){
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ) {
  //*(out) << std::endl;
  m_stmtBlockCnt++;
  //if(m_stmtBlockCnt < m_stmtBlockSize)
    //indt(IND3);
  //if(stmtBlock->isNamed() && m_stmtBlockCnt == 1){
  //  ;//*(out) << std::endl;
  //}
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ){
  m_stmtAssnPos++;
  if(m_stmtAssnPos == 1){
    if(stmtAssn->getAssnType() == CDOmStmtAssn::ASSN_BLOCKING){
      *(out) << " = ";
    } else if(stmtAssn->getAssnType() == CDOmStmtAssn::ASSN_NON_BLOCKING){
      *(out) << " <= ";
    }
    m_expandNum32 = TRUE;
    /*  } else if(m_stmtAssnPos == 2) {
    *(out) << ";";
    } */
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ){
  m_eventExprCnt.back()++;
  if(m_eventExprCnt.back() == 1){
    if(eventExpr->getEventExprType() == CDOmEventExpr::EVENT_EXPR_COMMA ){
      *(out) << ", ";
    }else if(eventExpr->getEventExprType() == CDOmEventExpr::EVENT_EXPR_OR ){
      *(out) << " or ";
    }
  }
  // }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){
  m_stmtPTCtrlPos++;
  //if(m_stmtPTCtrlPos == 1){
  //  *(out) << std::endl;
  //}
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
  m_stmtCaseCnt++;
  if(m_stmtCaseCnt == 1){
    *(out) << " )" << std::endl;
  }
  if( m_stmtCaseCnt > 1 && m_stmtCaseCnt % 2 == 0 && m_stmtCaseCnt < m_stmtCaseSize ){ //checking for even position in children vector (expressionLists)
      *(out) << " : ";
      //check the logic below - it may be optimised away
  } else if ( m_stmtCaseCnt > 1 && m_stmtCaseCnt % 2 != 0 ) { //checking for odd position in children vector (statements)
    //*(out) << std::endl;
    if( m_stmtCaseDefault && m_stmtCaseCnt == m_stmtCaseSize - 1){
      //// calling indenter function ////
      indt(m_depth);
      
      *(out) << "default : ";
    }
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
  m_stmtIfCnt++;
  if(m_stmtIfHasAttrList && m_stmtIfCnt == 0){
    *(out)  << " if ( ";
  }
   
  if(m_stmtIfCnt == 1 ){
    *(out) << " ) " /*<< std::endl*/;
  }
  if(m_stmtIfSize >= 3 && m_stmtIfCnt == 2){

    //// calling indenter function ////
    //// -1 because we want else at the same level of if, yet keep the indent depth for the rest ////
    indt(m_depth-1);

    *(out) << "else " /*<< std::endl*/;
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
  m_stmtLoopCnt++;
  switch( m_stmtLoopType ) {
    //does not evaluate forever case as to avoid redundancy
    case( CDOmStmtLoop::LOOP_REPEAT ) :   
      {
        if(m_stmtLoopCnt == 1){
          *(out) << " ) "; 
        }
        break;
      }
    case( CDOmStmtLoop::LOOP_WHILE ) :   
      {
        if(m_stmtLoopCnt == 1){
          *(out) << " ) "; 
        }
        break;
      }
    case( CDOmStmtLoop::LOOP_FOR     )                            :
      {
        switch ( m_stmtLoopCnt ) {
          case ( 1 ) : *(out) << "; "                ; break;
          case ( 2 ) : *(out) << "; "                ; break;
          case ( 3 ) : *(out) << ") "                ; break;
            //default disabled due to an extra increment at last traversal   : *(out) << "/*Out of bounds*/" ; break;
        }
        break;
      }
      // default disabled due to above non evaluation of the forever case  :   *(out) << "/* codegen:: Unknown Loop Type */";          break;
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
  m_stmtTaskEnableCnt++;
  if(m_stmtTaskEnableSize > 1){
    if(m_stmtTaskEnableCnt == 1){
      *(out) << "(";
    }else if(m_stmtTaskEnableCnt < m_stmtTaskEnableSize ){
      *(out) << ", ";
    }else if(m_stmtTaskEnableCnt == m_stmtTaskEnableSize){
      *(out) << ")";
    }
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
  m_stmtWaitCnt++;
  if(m_stmtWaitCnt == 1){
    *(out) << ") ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
  m_rangeExprPos++;
  if(m_rangeExprPos == 1){
    switch(m_rangeExprType){
      case 0 :                                             break;
      case 1 : *(out) << ":" ;                             break;
      case 2 : *(out) << "+:";                             break;
      case 3 : *(out) << "-:";                             break;
      default: *(out) << "/* Invalid range expression */"; break;
  }
}
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
  if (--m_exprConcatSize->top() > ZERO) {
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ){
  if(++m_exprMultiConcatPos == 1){
    *(out) << " ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                    ){
  m_udpcnt++;
  if(m_udpcnt == 1) {
    RefTVec_RefString portItems = udpDecl->getPortItemNames();
    *(out) << " (" << *(*portItems->begin());
    for(TVec_RefString_const_iter iter = portItems->begin()+1; iter < portItems->end(); ++iter)
      *(out) << ", " << *(*iter);
    *(out) << ");" << std::endl; 

  }
}


void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput          ){
}


void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput          ){
  m_udpPdInputCnt++;
  if(m_udpPdInputCnt > 0 && m_udpPdInputCnt< m_portIdSize && m_portIdSize != 1){
    *(out) << ", ";
  }
}


void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry              ){
  m_combEntryCnt++;
  RefTVec_ECDOmUdpSymbol levelInputList = udpCombEntry->getInputList();
  ECDOmUdpSymbol outputSymbol = udpCombEntry->getOutputSymbol();

  indt(IND2);
  if(m_combEntryCnt == 1) indt(IND2);
  for(TVec_ECDOmUdpSymbol_const_iter iter = levelInputList->begin(); iter < levelInputList->end(); ++iter) {
    switch(*iter) {
      case   UDP_SYMBOL_0                  : *(out) << "0 "       ;                               break;
      case   UDP_SYMBOL_1                  : *(out) << "1 "       ;                               break;
      case   UDP_SYMBOL_x                  : *(out) << "x "       ;                               break;
      case   UDP_SYMBOL_X                  : *(out) << "X "       ;                               break;
      case   UDP_SYMBOL_Q                  : *(out) << "? "       ;                               break;
      case   UDP_SYMBOL_b                  : *(out) << "b "       ;                               break;
      case   UDP_SYMBOL_B                  : *(out) << "B "       ;                               break;
      case   UDP_SYMBOL_UNDEF              : /* do nothing here */                                break;
      case   UDP_SYMBOL_MASK_OUTPUT_SYMBOL : /* do nothing here */                                break;
      case   UDP_SYMBOL_MASK_LEVEL_SYMBOL  : /* do nothing here */                                break;
      case   UDP_SYMBOL_MASK_NEXT_STATE    : /* do nothing here */                                break;
      default                              : ASSERT(FAIL, "Unintialized or undefined enum data"); break;
    }
  }

  switch(outputSymbol) {
    case   UDP_SYMBOL_0                  : *(out) << ": 0"      ;                               break;
    case   UDP_SYMBOL_1                  : *(out) << ": 1"      ;                               break;
    case   UDP_SYMBOL_x                  : *(out) << ": x"      ;                               break;
    case   UDP_SYMBOL_X                  : *(out) << ": X"      ;                               break;
    case   UDP_SYMBOL_Q                  : /* do nothing here */                                break;
    case   UDP_SYMBOL_b                  : /* do nothing here */                                break;
    case   UDP_SYMBOL_B                  : /* do nothing here */                                break;
    case   UDP_SYMBOL_UNDEF              : /* do nothing here */                                break;
    case   UDP_SYMBOL_MASK_OUTPUT_SYMBOL : /* do nothing here */                                break;
    case   UDP_SYMBOL_MASK_LEVEL_SYMBOL  : /* do nothing here */                                break;
    case   UDP_SYMBOL_MASK_NEXT_STATE    : /* do nothing here */                                break;
    default                              : ASSERT(FAIL, "Unintialized or undefined enum data"); break;
  }
}


void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry               ) {
  m_seqEntryCnt++;
  indt(IND2);
  if(m_seqEntryCnt == 1) indt(IND2);

  if(udpSeqEntry->hasLevelInputList()) {
    RefTVec_ECDOmUdpSymbol levelInputList =  udpSeqEntry->getLevelInputList();
    if(levelInputList.get()) {
      for(TVec_ECDOmUdpSymbol_const_iter iter = levelInputList->begin(); iter < levelInputList->end(); ++iter) {
        switch(*iter) {
          case   UDP_SYMBOL_0     : *(out) << "0 ";                          break;
          case   UDP_SYMBOL_1     : *(out) << "1 ";                          break;
          case   UDP_SYMBOL_x     : *(out) << "x ";                          break;
          case   UDP_SYMBOL_X     : *(out) << "X ";                          break;
          case   UDP_SYMBOL_Q     : *(out) << "? ";                          break;
          case   UDP_SYMBOL_b     : *(out) << "b ";                          break;
          case   UDP_SYMBOL_B     : *(out) << "B ";                          break;
          default                 : *(out) << "/* illegal level_symbol */";  break; 
        }
      }
    }
  }
  else {
    RefTVec_ECDOmUdpSymbol levelSymbolList1 = udpSeqEntry->getLevelSymbolList1();
    RefTVec_ECDOmUdpSymbol levelSymbolList2 = udpSeqEntry->getLevelSymbolList2();
  
    if(levelSymbolList1.get()) {
      for (TVec_ECDOmUdpSymbol_const_iter iter = levelSymbolList1->begin(); iter < levelSymbolList1->end(); ++iter) {
        switch(*iter) {
          case   UDP_SYMBOL_0     : *(out) << "0 ";                          break;
          case   UDP_SYMBOL_1     : *(out) << "1 ";                          break;
          case   UDP_SYMBOL_x     : *(out) << "x ";                          break;
          case   UDP_SYMBOL_X     : *(out) << "X ";                          break;
          case   UDP_SYMBOL_Q     : *(out) << "? ";                          break;
          case   UDP_SYMBOL_b     : *(out) << "b ";                          break;
          case   UDP_SYMBOL_B     : *(out) << "B ";                          break;
          default                 : *(out) << "/* illegal level_symbol */";  break;
        }
      }
    }
    if(udpSeqEntry->hasEdgeSymbol()) {
      switch(udpSeqEntry->getSeqEdgeSymbol()) {
        case  CDOmUdpSeqEntry::EDGE_r     : *(out) << "r "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_R     : *(out) << "R "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_f     : *(out) << "f "                                      ;   break; 
        case  CDOmUdpSeqEntry::EDGE_F     : *(out) << "F "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_p     : *(out) << "p "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_P     : *(out) << "P "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_n     : *(out) << "n "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_N     : *(out) << "N "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_STAR  : *(out) << "* "                                      ;   break;
        case  CDOmUdpSeqEntry::EDGE_UNDEF : /* do nothing here */                                   break;
        default                           : ASSERT(FAIL, "Uninitialized or undefined enum data");   break;
      }  
    }
    else {
      ECDOmUdpSymbol edgeIndicator1 = udpSeqEntry->getEdgeIndicator1();
      ECDOmUdpSymbol edgeIndicator2 = udpSeqEntry->getEdgeIndicator2();
      if(edgeIndicator1 != UDP_SYMBOL_UNDEF && edgeIndicator2 != UDP_SYMBOL_UNDEF) {
        switch(edgeIndicator1) {
          case   UDP_SYMBOL_0     : *(out) << "(0 ";    break;
          case   UDP_SYMBOL_1     : *(out) << "(1 ";    break;
          case   UDP_SYMBOL_x     : *(out) << "(x ";    break;
          case   UDP_SYMBOL_X     : *(out) << "(X ";    break;
          case   UDP_SYMBOL_Q     : *(out) << "(? ";    break;
          case   UDP_SYMBOL_b     : *(out) << "(b ";    break;
          case   UDP_SYMBOL_B     : *(out) << "(B ";    break;
          case   UDP_SYMBOL_UNDEF :                     break;
          
        }
        switch(edgeIndicator2) {
          case   UDP_SYMBOL_0     : *(out) << "0) ";    break;
          case   UDP_SYMBOL_1     : *(out) << "1) ";    break;
          case   UDP_SYMBOL_x     : *(out) << "x) ";    break;
          case   UDP_SYMBOL_X     : *(out) << "X) ";    break;
          case   UDP_SYMBOL_Q     : *(out) << "?) ";    break;
          case   UDP_SYMBOL_b     : *(out) << "b) ";    break;
          case   UDP_SYMBOL_B     : *(out) << "B) ";    break;
          case   UDP_SYMBOL_UNDEF :                    break;
        }
      }
    }
    if(levelSymbolList2.get()) {
      for (TVec_ECDOmUdpSymbol_const_iter iter = levelSymbolList2->begin(); iter < levelSymbolList2->end(); ++iter) {
        switch(*iter) {
          case   UDP_SYMBOL_0     : *(out) << "0 ";    break;
          case   UDP_SYMBOL_1     : *(out) << "1 ";    break;
          case   UDP_SYMBOL_x     : *(out) << "x ";    break;
          case   UDP_SYMBOL_X     : *(out) << "X ";    break;
          case   UDP_SYMBOL_Q     : *(out) << "? ";    break;
          case   UDP_SYMBOL_b     : *(out) << "b ";    break;
          case   UDP_SYMBOL_B     : *(out) << "B ";    break;
          case   UDP_SYMBOL_UNDEF :                    break;
        }
      }
    }
  }

  ECDOmUdpSymbol currentState = udpSeqEntry->getCurrState();
  ECDOmUdpSymbol nextState = udpSeqEntry->getNextState(); 

  switch(currentState) {
    case   UDP_SYMBOL_0     : *(out) << ": 0 ";    break;
    case   UDP_SYMBOL_1     : *(out) << ": 1 ";    break;
    case   UDP_SYMBOL_x     : *(out) << ": x ";    break;
    case   UDP_SYMBOL_X     : *(out) << ": X ";    break;
    case   UDP_SYMBOL_Q     : *(out) << ": ? ";    break;
    case   UDP_SYMBOL_b     : *(out) << ": b ";    break;
    case   UDP_SYMBOL_B     : *(out) << ": B ";    break;
  }

  switch(nextState) {
    case   UDP_SYMBOL_0     : *(out) << ": 0";    break;
    case   UDP_SYMBOL_1     : *(out) << ": 1";    break;
    case   UDP_SYMBOL_x     : *(out) << ": x";    break;
    case   UDP_SYMBOL_X     : *(out) << ": X";    break;
    case   UDP_SYMBOL_D     : *(out) << ": -";    break;
  }
}


void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt               ) {
  if(m_udpOutPortName.get()) {
    *(out) << *m_udpOutPortName << " = ";
    switch(udpInitStmt->getInitVal()) {
      case  CDOmUdpInitStmt::INIT_VAL_1b0 : *(out) << "1'b0;" << std::endl;   break; 
      case  CDOmUdpInitStmt::INIT_VAL_1b1 : *(out) << "1'b1;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1bx : *(out) << "1'bx;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1bX : *(out) << "1'bX;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1B0 : *(out) << "1'B0;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1B1 : *(out) << "1'B1;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1Bx : *(out) << "1'Bx;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1BX : *(out) << "1'BX;" << std::endl;   break;
      case  CDOmUdpInitStmt::INIT_VAL_1   : *(out) << "1;"    << std::endl;   break; 
      case  CDOmUdpInitStmt::INIT_VAL_0   : *(out) << "0;"    << std::endl;   break; 
    }
  }
  else *(out) << "Undeclared output port" << std::endl;
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                        ) {
  ++m_taskDeclCnt;
  if(taskDecl->getTaskDeclType() == CDOmTaskDecl::TASK_DECL_WITH_TASK_PORT_LIST) {
    if(m_taskDeclCnt == 1) *(out) << " (";
    else if(m_taskDeclCnt-1 == m_taskDeclPortItemSize)
      *(out) << ");" << std::endl;
    else if(m_taskDeclCnt-1 < m_taskDeclPortItemSize) *(out) << ", ";
  } 
  else if(m_taskDeclCnt == 1) {
    *(out) << ";" << std::endl;
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                       ) {
  ++m_tfPortDeclCnt;
  if(m_tfPortDeclCnt > 0 && m_tfPortDeclCnt < m_tfPortDeclSize)
    *(out) << ", ";
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
  m_funcDeclCnt++;
  if(m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE || m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE || m_funcDeclType == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST) {
    if(m_funcDeclCnt == 1) *(out) << " (";
    else if(m_funcDeclCnt == 2) *(out) << ");" << std::endl; 
  }
  else if(m_funcDeclCnt == 1) {
    *(out) << ";" << std::endl;
    indt(IND2);
  }
  if(m_funcDeclCnt > 1 && m_funcDeclCnt < funcDecl->getChildrenSize()) 
    indt(IND2);
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmFunctionCall                        & functionCall                    ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmGenvarDecl                          & genvarDecl                      ){
  m_genvarDeclCnt++;
  if(m_genvarDeclCnt < m_genvarDeclSize){
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmGenInst                             & genInst                         ){
  //indt(IND1);
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmGenItemNull                         & genItemNull                     ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmGenItemIf                           & genItemIf                       ){
  m_genItemIfCnt++;
  if(m_genItemIfCnt == 1){
    *(out) << ")" << std::endl;
    indt(IND1);
  }else if (m_genItemIfCnt == 2 && m_genItemIfSize == 3){
    *(out) << "else" << std::endl;
    indt(IND1);
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmGenItemCase                         & genItemCase                     ){
  m_genItemCaseCnt++;
  if(m_genItemCaseCnt == 1){
    *(out) << " )" << std::endl;
  }
  if( m_genItemCaseCnt > 1 && m_genItemCaseCnt % 2 == 0 && m_genItemCaseCnt < m_genItemCaseSize ){ //checking for even position in children vector (expressionLists)
      *(out) << " : ";
      //check the logic below - it may be optimised away
  } else if ( m_genItemCaseCnt > 1 && m_genItemCaseCnt % 2 != 0 ) { //checking for odd position in children vector (statements)
    //*(out) << std::endl;
    if( m_genItemCaseDefault && m_genItemCaseCnt == m_genItemCaseSize - 1){
      *(out) << "default : ";
    }
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmGenItemLoop                         & genItemLoop                     ){
  m_genItemLoopCnt++;
  switch ( m_genItemLoopCnt ) {
    case ( 1 ) : *(out) << " = "       ; break;
    case ( 2 ) : *(out) << "; "        ; break;
    case ( 3 ) : *(out) << "; "        ; break;
    case ( 4 ) : *(out) << " = "       ; break;
    case ( 5 ) : *(out) << ") "        ; break;
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmGenItemBlock                        & genItemBlock                    ){
  m_genItemBlockCnt++;
  if(m_genItemBlockCnt == 0){
    *(out) << std::endl;
  }
  if(m_genItemBlockCnt < m_genItemBlockSize){
    indt(IND3);
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmString                              & stringObj                       ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmEventDecl                           & eventDecl                       ){
  m_eventDeclCnt++;
  if(m_eventDeclCnt < m_eventDeclSize){
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmSpecifyBlock                        & specifyBlock                     ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl       & pulseSSCd                        ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmPathDecl                            & pathDecl                         ){
  m_pathDeclCnt++;
  if(m_pathDeclIsSimple || m_pathDeclIsStateSimpleIfNone){
    if(m_pathDeclCnt == 1 && m_pathDeclhasPolarityOp){
      if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
        *(out) << " +";
      }else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
        *(out) << " -";
      }
    }
    if(m_pathDeclCnt == 1){
      if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
        *(out) << " => ";
      }else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
        *(out) << " *> ";
      }
    }
    if(m_pathDeclCnt == 2){
      *(out) << " ) = ";
    }
  }
  if(m_pathDeclIsEdge){
    if(m_pathDeclCnt == 1){
      if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
        *(out) << " => ( ";
      }else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
        *(out) << " *> ( ";
      }
    }
    if(m_pathDeclCnt == 2){
      if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
        *(out) << " +";
      }else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
        *(out) << " -";
      }
      *(out) << " : ";
    }
    if(m_pathDeclCnt == 3){
      *(out) << " )) = ";
    }
  }
  if(m_pathDeclIsStateSimpleIf){
    if(m_pathDeclCnt == 1){
      *(out) << " )( ";
    }
    if(m_pathDeclCnt == 2 && m_pathDeclhasPolarityOp){
      if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
        *(out) << " +";
      }else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
        *(out) << " -";
      }
    }
    if(m_pathDeclCnt == 2){
      if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
        *(out) << " => ";
      }else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
        *(out) << " *> ";
      }
    }
    if(m_pathDeclCnt == 3){
      *(out) << " ) = ";
    }
  }
  if(m_pathDeclIsStateEdgeIf){
    if(m_pathDeclCnt == 1){
      *(out) << " )( ";
    }
    if(m_pathDeclCnt == 2){
      if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_PARALLEL){
        *(out) << " => ( ";
      }else if(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL){
        *(out) << " *> ( ";
      }
    }
    if(m_pathDeclCnt == 3){
      if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS){
        *(out) << " +";
      }else if(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_MINUS){
        *(out) << " -";
      }
      *(out) << " : ";
    }
    if(m_pathDeclCnt == 4){
      *(out) << " )) = ";
    }
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmPathDelayValue                      & pathDelayValue                   ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmMinTypMaxList                       & minTypMaxList                    ){
  m_minTypMaxListCnt++;
  if(m_minTypMaxListCnt < m_minTypMaxListSize){
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmSpecifyTerminalList                 & specifyTerminalList              ){
  m_specifyTListCnt++;
  if(m_specifyTListCnt < m_specifyTListSize){
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmDelayedDataOrReference              & delayedDataOrRef                 ){
  m_delayedDataOrRefCnt++;
  if(m_delayedDataOrRefCnt == 1 && m_delayedDataOrRefSize > 1){
    *(out) << "[ ";
  }
  if(m_delayedDataOrRefCnt == 2){
    *(out) << " ]";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmTimingCheckEventControl             & timingCkEventCtrl                ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmTimingCheckEvent                    & timingCkEvent                    ){
  m_timingCheckEventCnt++;
  if(m_timingCheckEventCnt == 1 && timingCkEvent->hasTimingCheckCondition()){
    *(out) << " &&& ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmSystemTimingCheck                   & systemTimingCk                   ){
  m_systemTimingCkCnt++;
  if(m_systemTimingCkCnt < m_systemTimingCkSize){
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmGateInstantiation                   & gateInstantiation                ){
  m_gateInstanceCnt++;
  if(m_gateInstanceCnt < m_gateInstanceSize){
    if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_EXPR && m_gateInstanceFlag){
      *(out) << ", ";
    }
    if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_EXPR && !m_gateInstanceFlag){
      *(out) << "( ";
      m_gateInstanceFlag = TRUE;
    }
    if((gateVec->at(m_gateInstanceCnt))->getType() == TYPE_ID_SCOPE_INDIRECT && m_gateInstanceCnt > 2){
      *(out) << "), ";
      m_gateInstanceFlag = FALSE;
    }
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmPulseControl                        & pulseControl                     ){
  m_pulseControlCnt++;
  if(m_pulseControlLong){
    switch(m_pulseControlCnt){
      case(-1): *(out) << "$"   ; break;
      case( 0): *(out) << " = ( "; break;
      case( 1): {
        if(m_pulseControlCnt < m_pulseControlSize){
          *(out) << ", ";
        }
      }
    }

  }else{
    if(m_pulseControlCnt < m_pulseControlSize){
      *(out) << ", ";
    }
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmAttrList                       & attrList                  ){
  m_attrListCnt++;
  if(m_attrListCnt < m_attrListSize){
    *(out) << ", ";
  }
}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmDefine                         & define                    ){}

void CVerilogTbGenerator::inTraversal(const NSCdom::RefCDOmComment                        & comment                   ){}


//********************************************************************************
// After traversal block
//********************************************************************************

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmInclude                       & fileInclude                 ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmDesign                        & design                      ){
  //finishing up defines files
  defout << "`endif" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmModuleDecl                    & moduleDecl                  ){
  //include logic statement
  indt(m_depth);
  if(CDOmModuleDecl::GEN_FROM_UNIT == m_moduleCslType && FALSE == m_includeInUnit){
    *(out) << "`include \"" <<  *(m_currentModuleName) << ".logic.vh\"" << std::endl;
    RefString logicFileName = RefString(new std::string(m_outputPath));
    logicFileName->append(*(m_currentModuleName));
    logicFileName->append(".logic.vh");
    std::ofstream *fs = new std::ofstream(logicFileName->c_str());
    //*(fs) << "lallaa\n";
    fs->close();
    delete fs;

    //flag reset
    //WARNING: this may need further optimization
    m_includeInUnit = FALSE;
  }
  *(out) << "endmodule"<< std::endl << std::endl;
  m_depth--;
  if(TRUE == file){
    delete out;
  }
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmIdentifier                    & id                          ){
  m_expandNum32 = FALSE;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmPortItem                      & portItem                    ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmExprLink                      & exprLink                    ) {
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmExprOp                        & exprOp                      ){
  RefCDOmBase parent = exprOp->getParent();

  if (exprOp->isUnary()) {
    *(out) << ")";
  }

  if(parent.get() && parent->getType() == TYPE_EXPR){
    if(CDOmExpr::cast(parent)->getExprType() == CDOmExpr::EXPR_MINTYPMAX){
      *(out) << ")";
      }
  }
  m_exprCnt.pop_back();
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmListExpr                      & listExpr                    ){
  if(m_listExprHasFunctionCallParent){
    *(out) << ")";
  }else if(m_listExprHasExprLinkParent){
    *(out) << "]";
  }
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmPortDecl                      & portDecl                    ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmVarDecl                       & varDecl                     ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmNetDecl                       & netDecl                     ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmRange                         & range                       ){
  //if(!m_noRange){
  //  *(out) << "] ";
  //}else{
  //  m_noRange = FALSE;
  //}
  if(m_showRange){
    *(out) << "] ";
     }
  m_showRange = TRUE;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmNum32                         & num                         ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmReal                          & realNum                     ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation      & moduleInstantiation         ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstance           & moduleInstance              ) {
  *(out) << ")";
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmParamDeclCollection           & paramDeclCollection         ){}
   
void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmParamDecl                     & paramDecl                   ){
  if(!m_pulseControlSection){
    *(out) << ";" << std::endl;
  }else{
    m_pulseControlSection = FALSE;
  }
  m_namesVec.clear();
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmParamOverride                 & paramOverride               ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmMinTypMax                     & minTypMax                   ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmDelay                         & delay                       ){
  if(m_delayHasParanths){
  //if(delay->getDelayType() == 0 || delay->getDelayType() == 1){
    //*(out) << ")";
  }
  *(out) << " ";
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmInitOrAlways                  & initOrAlways                ){
  //// exiting depth ////
  m_depth--;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmAssn                          & assn                        ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmContAssn                      & contAssn                    ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmt                          & stmt                        ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtBlock                     & stmtBlock                   ) {
  //// exiting depth ////
  //m_depth--;

  //// calling indenter function ////
  indt(m_depth - 1);

  if(stmtBlock->getBlockType() == CDOmStmtBlock::BLOCK_PARALLEL){
    *(out)  << "join" << std::endl;
  } else if(stmtBlock->getBlockType() == CDOmStmtBlock::BLOCK_SEQUENTIAL) {
    *(out)  << "end" << std::endl;
  }
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtAssn                       & stmtAssn                    ){
  *(out) << ";" << std::endl;
  m_expandNum32 = FALSE;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmEventControl                   & eventCtrl                   ){
  if( m_eventCtrlType == CDOmEventControl::EVENT_CONTROL_EVENT_EXPR ){
    *(out) << " ) " /*<< std::endl*/;
  }else{
    *(out) /*<< std::endl*/;
  }
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmEventExpr                      & eventExpr                   ){
  m_eventExprCnt.pop_back();
  //eventExprtype reset
  m_eventExprType = -1;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ){
  if(delayCtrl->getDelayControlType() == CDOmDelayControl::DELAY_CONTROL_MINTYPMAX){
    *(out) << "  )";
  }
  *(out) << " ";
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ){
  //// exiting depth ////
  m_depth--;
  //// calling indenter function ////
  indt(m_depth);

  *(out) << "endcase" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ){
  //// exiting depth ////
  m_depth--;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ){
  //// exiting depth ////
  m_depth--;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ){
  //*(out) << ";";
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ){
  *(out) << ";";
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ){
  *(out) << "]";
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ){
  ASSERT(m_exprConcatSize->top() == ZERO, "this should be \'0\'");
  m_exprConcatSize->pop();

  if (m_exprConcatSize->empty()) {
    m_exprConcatSize = RefTStack_TInt();
  }

  *(out) << "}";
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ) {
  *(out) << "}";
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     ) {
  *(out) << "endprimitive"<< std::endl << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           ) {
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            ) {
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                ) {
  *(out) << " ;" << std::endl;
  if(m_combEntryCnt == m_combEntrySize) {
    indt(IND2);
    *(out) << "endtable" << std::endl;
  }
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 ) {
  *(out) << " ;" << std::endl;
  if(m_seqEntryCnt == m_seqEntrySize) {
    indt(IND2);
    *(out) << "endtable" << std::endl;
  }
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 ) {
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    ){
  *(out) << "endtask" <<std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  ) {
  RefCDOmBase parent = tfPortDecl->getParent();
  if(parent.get() && (parent->getType() == TYPE_DECL_TASK && CDOmTaskDecl::cast(parent)->getTaskDeclType() == CDOmTaskDecl::TASK_DECL_WITHOUT_TASK_PORT_LIST ||
      (parent->getType() == TYPE_DECL_FUNCTION && (CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE  ||
                                                   CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE ||
                                                   CDOmFuncDecl::cast(parent)->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST))))
   *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {
  *(out) << "endfunction" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                ) {}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  ) {
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     ){
  *(out) << "endgenerate" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 ){
  *(out) << "endcase" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                ){
  *(out) << "end" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmString                          & stringObj                   ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                ){
  //// exiting depth ////
  m_depth--;
  //// calling indenter function ////
  indt(m_depth);

  *(out) << "endspecify" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                  ){
  *(out) << ";" <<std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                   ){
  *(out) << ";" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue             ){
  if(pathDelayValue->getStyle() == CDOmPathDelayValue::PATH_DELAY_WITH_PAREN){
    *(out) << " )";
  }
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList              ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList        ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef           ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl          ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent              ){}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk             ){
  *(out) << " );" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation          ){
  *(out) << ");" << std::endl;
}

void CVerilogtbGenerator::afterTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl               ){
  *(out) << " );" << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmAttrList                        & attrList                   ){
  *(out) << " *)";
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmDefine                          & define                     ){
  defout << std::endl;
}

void CVerilogTbGenerator::afterTraversal(const NSCdom::RefCDOmComment                         & comment                     ){
  if(m_commentStar){
    *(out) << "*/" << std::endl;
  }
}

}
