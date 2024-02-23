#include <string>
#include <iostream>
#include <sstream>

#include "CDOM.h"
#include "VeriNum.h"
#include "CDOM_Visitor.h"
#include "CDOM_Type_Map.h"
#include "CDOM_API.h"
#include "../support/CommonSupport.h"

using namespace std;
using namespace NSCdom;
using namespace NSCdomVisitor;


void myTry(){

  //string expressions
  RefCDOmExpr exprString = CDOmString::build(27, RefString(new string("numeString")), RefString(new string("string")));
  RefCDOmExpr exprString1 = CDOmString::build(27, RefString(new string("numeString")), RefString(new string("string")));
  RefCDOmExpr exprString2 = CDOmString::build(27, RefString(new string("numeString")), RefString(new string("string")));
  RefCDOmExpr exprString3 = CDOmString::build(27, RefString(new string("numeString")), RefString(new string("string")));
  RefCDOmExpr exprString4 = CDOmString::build(27, RefString(new string("numeString")), RefString(new string("string")));
  RefCDOmExpr exprString5 = CDOmString::build(27, RefString(new string("numeString")), RefString(new string("string")));
  RefCDOmExpr exprString6 = CDOmString::build(27, RefString(new string("numeString")), RefString(new string("string")));
  RefCDOmExpr exprString7 = CDOmString::build(27, RefString(new string("numeString")), RefString(new string("string")));
  RefCDOmExpr exprString8 = CDOmString::build(27, RefString(new string("numeString")), RefString(new string("string")));
  RefCDOmExpr exprString9 = CDOmString::build(27, RefString(new string("numeString")), RefString(new string("string")));
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //number expressions
  RefCDOmExpr exprNumber = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber1 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber2 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber3 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber4 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber5 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber6 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber7 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber8 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber9 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber10 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber11 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber12 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber13 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber14 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber15 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  RefCDOmExpr exprNumber16 = CDOmNumber::build(26, CDOmNumber::NUM_BASE_DEC, RefString(new string("10")));
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  //design
  RefCDOmDesign design = CDOmDesign::build();

  //define
  RefCDOmDefine define = CDOmDefine::build(21, design, CDOmDefine::DEFINE_TYPE_DEFINE, RefString(new string("macro_name")), CDOmString::build(2, RefString(new string("macro_value_name")), RefString(new string("macro_actual_value"))));

  //adding modDecl with a port
  RefCDOmModuleDecl modDecl =  design->buildModuleDecl(24, RefString(new string("nume")));
  RefCDOmPortItem portItem = modDecl->buildPortItem(25,CDOmPortItem::PORT_ITEM_SIMPLE, RefString(new string("numePort")));
  RefCDOmExprLink exprLink = CDOmExprLink::build(28, RefString(new string("numeExprLink")), exprString);
  exprLink->addHidItem(RefString(new string("numeHidItem")), exprNumber);
  portItem->addPortExprLink(exprLink);
  //adding a updDecl with a port
  RefCDOmUdpDecl udpDecl = design->buildUdpDecl(31, RefString(new string("numeUDP")));
  udpDecl->addPort(RefString(new string("numePort")));

  RefCDOmFuncDecl funcDecl = CDOmFuncDecl::build(80, modDecl, CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST, RefString(new string("funcName")), FALSE< TRUE);
  RefCDOmGateInstantiation gateInst = CDOmGateInstantiation::build(85, modDecl, CDOmGateInstantiation::GATE_INST_CMOS);
  RefCDOmGenInst genericInst = CDOmGenInst::build(86, modDecl);
 
  // adding an eventDecl with range lists
  RefCDOmRange range_1 = CDOmRange::build(33, exprNumber1, exprNumber2);
  RefCDOmRange range_2 = CDOmRange::build(34, exprNumber3, exprNumber4);
  RefCDOmRange range_3 = CDOmRange::build(35, exprNumber5, exprNumber6);
  RefCDOmRange range_4 = CDOmRange::build(36, exprNumber7, exprNumber8);
  RefCDOmRangeList rangeList = CDOmRangeList::build(37, range_1);
  rangeList->addItem(range_2);
  rangeList->addItem(range_3);
  RefCDOmRangeList rangeList2 = CDOmRangeList::build(40, range_4);
  RefCDOmEventDecl eventDecl = CDOmEventDecl::build(41, modDecl, RefString(new string("nume event declaration")), rangeList);
  eventDecl->addEvent(42, RefString(new string("numeEvent")), rangeList2);

 //making an assignment and a AttributListCollection
 RefCDOmExprLink exprLink2 = CDOmExprLink::build(26, RefString(new string("numeExprLink")), exprString1);
 RefCDOmAssn assn = CDOmAssn::build(35, exprLink2, exprString2);
 RefCDOmContAssn contAssn = CDOmContAssn::build(36, design);
 contAssn->addNetAssn(assn);
 RefCDOmAttrListCollection attrListCollection = CDOmAttrListCollection::build(38);
 RefCDOmAttrList attrList = attrListCollection->buildAttrList(39);
 attrList->addAttr(40, RefString(new string("name")), exprNumber9);
 attrList->addAttr(41, RefString(new string("numeAtribut")), exprString3);

 RefCDOmListExpr listExpr = CDOmListExpr::build(81, exprNumber10);
 listExpr->addItem(exprString4);
 RefCDOmExprLink exprLink6 = CDOmExprLink::build(26, RefString(new string("numeExprLink")), exprString9);
 RefCDOmFunctionCall funcall = CDOmFunctionCall::build(83, exprLink6, listExpr, attrListCollection);


 //adding delayConstrols
 RefCDOmDelayControl delayControl_1 = CDOmDelayControl::build(63, CDOmNumber::build(1, CDOmNumber::NUM_BASE_DEC, RefString(new string("10"))));
 RefCDOmDelayControl delayControl_2 = CDOmDelayControl::build(64, CDOmReal::build(1, RefString(new string("10")), RefString(new string("10"))));
 RefCDOmExprLink exprLink3 = CDOmExprLink::build(65, RefString(new string("numeExprLink")), exprString5);
 RefCDOmDelayControl delayControl_3 = CDOmDelayControl::build(66, exprLink3);
 RefCDOmDelayControl delayControl_4 = CDOmDelayControl::build(67, CDOmMinTypMax::build(1, exprNumber11, exprNumber12, exprNumber13));

 RefCDOmExprLink exprLink4 = CDOmExprLink::build(70, RefString(new string("numeExprLink")), exprString6);
 RefCDOmDelayedDataOrReference delayedDataOrReference = CDOmDelayedDataOrReference::build(72, exprLink4, CDOmMinTypMax::build(73, exprString7));

 TDouble val = 2.0;
 RefCDOmEvalRes evalRes = CDOmEvalRes::build(RefCRealNum(new CRealNum(val)));
 RefCDOmEvalRes evalRes2 = CDOmEvalRes::build(RefCVeriNum(new CVeriNum("ceva aici")));

 RefCDOmExprLink exprLink5 = CDOmExprLink::build(81, RefString(new string("numeExprLink")), exprString8);
 RefCDOmEventControl eventCtrl = CDOmEventControl::build(60, exprLink5);
 RefCDOmEventControl eventCtrl2 = CDOmEventControl::build(61, TRUE);
 RefCDOmEventExpr eventExpr = CDOmEventExpr::build(62, CDOmEventExpr::EVENT_EXPR_EXPR, exprNumber14);
 RefCDOmEventExpr eventExpr2 = CDOmEventExpr::build(63, CDOmEventExpr::EVENT_EXPR_EXPR, exprNumber15);
 RefCDOmEventExpr eventExpr3 = CDOmEventExpr::build(64, CDOmEventExpr::EVENT_EXPR_EXPR, exprNumber16);
 RefCDOmEventExpr eventExpr4 = CDOmEventExpr::build(65, CDOmEventExpr::EVENT_EXPR_OR, eventExpr2, eventExpr3);
 RefCDOmEventControl eventControl3 = CDOmEventControl::build(66, eventExpr4);
}


int main(){
  myTry();
  return 0;
}
