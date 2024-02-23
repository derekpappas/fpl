#include <string>
#include <iostream>
#include <sstream>

#include "../../src/cdom/CDOM.h"
#include "../../src/cdom/VeriNum.h"
#include "../../src/cdom/CDOM_Visitor.h"
#include "../../src/cdom/CDOM_Type_Map.h"
#include "../../src/cdom/CDOM_API.h"
#include "../../src/support/CommonSupport.h"

using namespace std;
using namespace NSCdom;
using namespace NSCdomVisitor;

/*
RefCDOmNumber quickBuild(string* str) {
  RefString rs = RefString(str);
  return CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC, rs, rs);
}

void testUdpSeqEntry() {
  try {
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmUdpDecl udpDecl = design->buildUdpDecl(10,RefString(new string("name")));
    // string[0] = RefString(new std::string("a"));

    RefTVec_ECDOmUdpSymbol inputList = RefTVec_ECDOmUdpSymbol(new TVec_ECDOmUdpSymbol());
    inputList->push_back(UDP_SYMBOL_x);
    inputList->push_back(UDP_SYMBOL_0);
    inputList->push_back(UDP_SYMBOL_X);
    RefCDOmUdpSeqEntry udpSeqEntry = CDOmUdpSeqEntry::buildWithLevelInputList(10,udpDecl,UDP_SYMBOL_X,UDP_SYMBOL_D,inputList);
    assert(udpSeqEntry->getCurrState() == UDP_SYMBOL_X);
    assert(udpSeqEntry->getNextState() == UDP_SYMBOL_D);
    assert(udpSeqEntry->getLevelInputList() == inputList);

    RefTVec_ECDOmUdpSymbol levelSymbolList1 = RefTVec_ECDOmUdpSymbol(new TVec_ECDOmUdpSymbol());
    levelSymbolList1->push_back(UDP_SYMBOL_X);
    levelSymbolList1->push_back(UDP_SYMBOL_B);
    levelSymbolList1->push_back(UDP_SYMBOL_x);
    
    RefTVec_ECDOmUdpSymbol levelSymbolList2 = RefTVec_ECDOmUdpSymbol(new TVec_ECDOmUdpSymbol());
    levelSymbolList2->push_back(UDP_SYMBOL_0);
    levelSymbolList2->push_back(UDP_SYMBOL_1);
    levelSymbolList2->push_back(UDP_SYMBOL_Q);

    RefCDOmUdpSeqEntry udpSeqEntry1 = CDOmUdpSeqEntry::buildWithEdgeInputList(10,udpDecl,UDP_SYMBOL_X,UDP_SYMBOL_D,levelSymbolList1,levelSymbolList2,
        UDP_SYMBOL_X,UDP_SYMBOL_B);
    assert(udpSeqEntry1->getCurrState() == UDP_SYMBOL_X);
    assert(udpSeqEntry1->getNextState() == UDP_SYMBOL_D);
    assert(udpSeqEntry1->getLevelSymbolList1() == levelSymbolList1);
    assert(udpSeqEntry1->getLevelSymbolList2() == levelSymbolList2);
    assert(udpSeqEntry1->getEdgeIndicator1() == UDP_SYMBOL_X);
    assert(udpSeqEntry1->getEdgeIndicator2() == UDP_SYMBOL_B);
      
    RefTVec_ECDOmUdpSymbol levelSymbolList3 = RefTVec_ECDOmUdpSymbol(new TVec_ECDOmUdpSymbol());
    levelSymbolList3->push_back(UDP_SYMBOL_X);
    levelSymbolList3->push_back(UDP_SYMBOL_B);
    levelSymbolList3->push_back(UDP_SYMBOL_x);
    
    RefTVec_ECDOmUdpSymbol levelSymbolList4 = RefTVec_ECDOmUdpSymbol(new TVec_ECDOmUdpSymbol());
    levelSymbolList4->push_back(UDP_SYMBOL_0);
    levelSymbolList4->push_back(UDP_SYMBOL_1);
    levelSymbolList4->push_back(UDP_SYMBOL_Q);

    RefCDOmUdpSeqEntry udpSeqEntry2 = CDOmUdpSeqEntry::buildWithEdgeInputList(10,udpDecl,
        UDP_SYMBOL_X,UDP_SYMBOL_x,levelSymbolList3,levelSymbolList4,CDOmUdpSeqEntry::EDGE_P);
    assert(udpSeqEntry2->getCurrState() == UDP_SYMBOL_X);
    assert(udpSeqEntry2->getNextState() == UDP_SYMBOL_x);
    assert(udpSeqEntry2->getLevelSymbolList1() == levelSymbolList3);
    assert(udpSeqEntry2->getLevelSymbolList2() == levelSymbolList4);
    assert(udpSeqEntry2->getSeqEdgeSymbol() == CDOmUdpSeqEntry::EDGE_P);

    cout << "All done in testUdpSeqEntry" <<  endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

void testUdpCombEntry() {
  try {
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmUdpDecl parent = design->buildUdpDecl(10, RefString(new string("name")));

    RefTVec_ECDOmUdpSymbol inputList = RefTVec_ECDOmUdpSymbol(new TVec_ECDOmUdpSymbol());
    inputList->push_back(UDP_SYMBOL_x);
    inputList->push_back(UDP_SYMBOL_X);
    inputList->push_back(UDP_SYMBOL_0);
    //cerr << inputList->size()<< endl;
    
    RefCDOmUdpCombEntry udpCombEntry = CDOmUdpCombEntry::build(10, parent, inputList, UDP_SYMBOL_x);
    assert(udpCombEntry->getOutputSymbol() == UDP_SYMBOL_x);
    assert(udpCombEntry->getInputList() == inputList);

    cout << "All done in testUdpCombEntry" << endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

void testUdpDecl() {
  //also tests CDOmUdpInitStmt;
  try {
    const int nr = 3;
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmUdpDecl udpDecl = design->buildUdpDecl(10,RefString(new string("name")));//DECL_UNDEFINED, BODY_UNDEFINED

    RefString string[nr];
    string[0] = RefString(new std::string("a"));
    string[1] = RefString(new std::string("b"));
    string[2] = RefString(new std::string("c"));

    for(int i=0; i<nr; i++) {
      udpDecl->addPort(string[i]);
      assert(udpDecl->containsPort(string[i]));
    }
    //DECL_1, BODY_UNDEFINED
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString str = RefString(new std::string("a"));
    RefCDOmExprLink outPortId = CDOmExprLink::build(10,str, expr);
    RefCDOmUdpInitStmt udpInitStmt = CDOmUdpInitStmt::build(10,udpDecl,outPortId,CDOmUdpInitStmt::INIT_VAL_1B0);
    //DECL_1, UDP_TYPE_SEQUENTIAL
    assert(udpInitStmt->getInitVal() == CDOmUdpInitStmt::INIT_VAL_1B0);
    cout << "All done in testUdpDecl" << endl;

    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testGenItemBlock() {
  try {
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name"))) ;
    RefCDOmGenInst genInst = CDOmGenInst::build(10,moduleDecl);
    RefCDOmGenItemBlock itemBlock = CDOmGenItemBlock::build(10,genInst, RefString(new std::string("a")));
    
   

    cout << "All done in testGenItemBlock" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testGenItemCase() {
  try {
    // switch (const_expr) {
    //  case(listExpr):
    //    gen_item_or_null;               only one
    //  case(listExpr):
    //    gen_item_or_null;               only one
    //  default:                          no listExpr
    //    gen_item_or_null;               no matter how many
    //    gen_item_or_null;
    //    ...
    //}
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefCDOmGenInst genInst = CDOmGenInst::build(10,moduleDecl);
    const int nr = 3;
    RefCDOmListExpr listExpr;
    RefCDOmExpr number[nr];
    for(int i=0; i<nr; i++) {
      number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      if(!listExpr.get())
        listExpr = CDOmListExpr::build(10,number[i]);
      else
        listExpr->addItem(number[i]);
    }
    assert(listExpr.get());
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmGenItemCase itemCase = CDOmGenItemCase::build(10,genInst,expr,listExpr);
    
    assert(!itemCase->hasDefault()) ;
    //adding a gen_item_or_null is compulsory at this point    IMPLEMENT CHECK FUNCTION!!!
    RefCDOmGenItemNull itemNull = CDOmGenItemNull::build(10,itemCase);
    RefCDOmListExpr listExpr1;
    RefCDOmExpr number1[nr];
    for(int i=0; i<nr; i++) {
      number1[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      if(!listExpr1.get())
        listExpr1 = CDOmListExpr::build(10,number1[i]);
      else
        listExpr1->addItem(number1[i]);
    }
    itemCase->addCaseItem(listExpr1);
    //adding a gen_item_or_null is compulsory at this point    IMPLEMENT CHECK FUNCTION!!!
    RefCDOmGenItemNull itemNull1 = CDOmGenItemNull::build(10,itemCase);
 
    cout << "All done in testGenItemCase" <<endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testGenItemIf() {
  try {
    //itemIf (condExpr) {
    //  itemIf1 (condExpr1)
    //    itemIf2;                                (=itemNull)
    //  else
    //    elseItem1;                              (=itemNull)
    //}
    //else
    //  elseItem;                                 (=itemNull)
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefCDOmGenInst genInst = CDOmGenInst::build(10,moduleDecl);
    assert(genInst.get());
    //if I stop constructing the ifItem here it should generate an illegal state :  IMPLEMENT CHECK FUNCTION!!!
    
    RefCDOmExpr ifCondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmGenItemIf itemIf = CDOmGenItemIf::build(10,genInst,ifCondExpr);
    assert(itemIf->getIfCondExpr() == ifCondExpr);
    
    RefCDOmExpr ifCondExpr1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmGenItemIf itemIf1 = CDOmGenItemIf::build(10,itemIf, ifCondExpr1);
    assert(itemIf1->getIfCondExpr() == ifCondExpr1);
    RefCDOmGenItemNull itemIf2 = CDOmGenItemNull::build(10,itemIf1);
    RefCDOmGenItemNull elseItem1 = CDOmGenItemNull::build(10,itemIf1);
    assert(itemIf1->getIfItem() == itemIf2);
    assert(itemIf1->getElseItem() == elseItem1);

    RefCDOmGenItemNull elseItem = CDOmGenItemNull::build(10,itemIf);
    assert(itemIf->getIfItem() == itemIf1);
    assert(itemIf->getElseItem() == elseItem);
    
    //This generates a failed assertion : beforeAddingGenItemOrNull(): an ifItem cannot have more than 3 children
    //RefCDOmGenItemNull illegalItem = CDOmGenItemNull::build(10,itemIf);
    cout << "All done in testGenItemIf" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testGenInst() {
  try {
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefCDOmGenInst genInst = CDOmGenInst::build(10,moduleDecl);
    assert(genInst.get());

    cout << "All done in testGenInst" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

void testGenItemLoop() {
  try {
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefCDOmGenInst genInst = CDOmGenInst::build(10,moduleDecl);
    
    const int nr = 3;
    RefCDOmExpr number = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString string = RefString(new std::string("name"));
    RefCDOmExprLink initAssnId = CDOmExprLink::build(10,string,number);
    
    RefCDOmExpr initAssnExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr condExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    
    RefCDOmExpr number1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString string1 = RefString(new std::string("name"));
    RefCDOmExprLink incAssnId = CDOmExprLink::build(10,string1,number1);
    
    RefCDOmExpr incAssnExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmGenItemLoop genItemLoop = CDOmGenItemLoop::build(10,genInst,initAssnId,initAssnExpr,condExpr,incAssnId,incAssnExpr);
    assert(genItemLoop.get());

    RefCDOmGenItemBlock itemBlock = CDOmGenItemBlock::build(10,genItemLoop, RefString(new std::string("a")));
   
    
    RefTVec_RefCDOmBase vec = genItemLoop->getChildren<CDOmBase>(TYPE_ALL_TYPES);
    TVec_RefCDOmBase_const_iter iter = vec->begin();
    assert((*iter++) == initAssnId);
    assert((*iter++) == initAssnExpr);
    assert((*iter++) == condExpr);
    assert((*iter++) == incAssnId);
    assert((*iter++) == incAssnExpr);
    assert((*iter++) == itemBlock);
 


    cout << "All done in testGenItemLoop" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

void testPathDecl() {
  try {
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefCDOmSpecifyBlock specBlock = CDOmSpecifyBlock::build(10,moduleDecl);
    RefCDOmSpecifyTerminalList specInptTermDesc; 
    RefCDOmSpecifyTerminalList specOutTermDesc;
    const int nrExprs = 3;
    RefCDOmExpr number[nrExprs];
    RefString string[nrExprs];
    RefCDOmExprLink exprLink[nrExprs];
    string[0] = RefString(new std::string("string0"));
    string[1] = RefString(new std::string("string1"));
    string[2] = RefString(new std::string("string2"));
    for(int i = 0; i < nrExprs; ++i) {
      number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      exprLink[i] = CDOmExprLink::build(10,string[i],number[i]);
      if(!specInptTermDesc.get()) {
        specInptTermDesc = CDOmSpecifyTerminalList::build(10,exprLink[i]);//that happens only for i=0
      }
      else {
        specInptTermDesc->addItem(exprLink[i]);
      }
    }
    RefCDOmExpr number1[nrExprs];
    RefString string1[nrExprs];
    RefCDOmExprLink exprLink1[nrExprs];
    string1[0] = RefString(new std::string("string0"));
    string1[1] = RefString(new std::string("string1"));
    string1[2] = RefString(new std::string("string2"));
    for(int i = 0; i < nrExprs; ++i) {
      number1[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      exprLink1[i] = CDOmExprLink::build(10,string1[i],number1[i]);
      if(!specOutTermDesc.get()) {
        specOutTermDesc = CDOmSpecifyTerminalList::build(10,exprLink1[i]);//that happens only for i=0
      }
      else {
        specOutTermDesc->addItem(exprLink1[i]);
      }
    }

    RefCDOmExpr number0 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmMinTypMax minTypMax = CDOmMinTypMax::build(10,number0);
    RefCDOmMinTypMaxList minTypMaxList = CDOmMinTypMaxList::build(10,minTypMax);
    RefCDOmPathDelayValue pathDelayValue = CDOmPathDelayValue::build(10,CDOmPathDelayValue::PATH_DELAY_WITHOUT_PAREN,minTypMaxList);

    RefCDOmExpr dataSourceExpr = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr modulePathExpr = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmPathDecl pathDecl = CDOmPathDecl::build(10,specBlock,CDOmPathDecl::PATH_DECL_EDGE_IF,specInptTermDesc,
                    specOutTermDesc,pathDelayValue,CDOmPathDecl::PATH_DECL_PLUS, CDOmPathDecl::PATH_DECL_POSEDGE, dataSourceExpr,modulePathExpr);
    assert(pathDecl->getType() == CDOmPathDecl::PATH_DECL_EDGE_IF);
    assert(pathDecl->getRange() == CDOmPathDecl::PATH_DECL_FULL);
    assert(pathDecl->getEdgeIdentifier() == CDOmPathDecl::PATH_DECL_POSEDGE);
    assert(pathDecl->getPolarityOp() == CDOmPathDecl::PATH_DECL_PLUS);
    assert(pathDecl->getListOfPathInputs() == specInptTermDesc);
    assert(pathDecl->getListOfPathOutputs() == specOutTermDesc);
    assert(pathDecl->getPathDelayValue() == pathDelayValue);
    assert(pathDecl->getDataSourceExpression() == dataSourceExpr);
    assert(pathDecl->getModulePathExpr() == modulePathExpr);

    cout << "All done in testPathdecl" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

 
void testSystemTimingCheck(){
  try{  
    //setup
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefCDOmSpecifyBlock specifyBlock = CDOmSpecifyBlock::build(10,moduleDecl);
   
    const int nr = 3;
    RefCDOmTimingCheckEventControl posedge = CDOmTimingCheckEventControl::buildPosedge(10);
    RefCDOmExpr timingCheckCondition = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink specifyTerminalDescriptor;
    RefCDOmExpr number[nr];
    RefString string[nr];
    for(int i=0; i<nr; i++) {
      number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string[i] = RefString(new std::string("name1"));
      if(!specifyTerminalDescriptor.get())
        specifyTerminalDescriptor = CDOmExprLink::build(10,string[i],number[i]);
      else
        specifyTerminalDescriptor->addHidItem(string[i],number[i]);
    }
    RefCDOmTimingCheckEvent referenceEvent = 
      CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor,posedge,timingCheckCondition);
    
    RefCDOmTimingCheckEventControl negedge = CDOmTimingCheckEventControl::buildNegedge(10);
    RefCDOmExpr timingCheckCondition1 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink specifyTerminalDescriptor1;
    RefCDOmExpr number1[nr];
    RefString string1[nr];
    for(int i=0; i<nr; i++) {
      number1[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string1[i] = RefString(new std::string("name2"));
      if(!specifyTerminalDescriptor1.get())
        specifyTerminalDescriptor1 = CDOmExprLink::build(10,string1[i],number1[i]);
      else
        specifyTerminalDescriptor1->addHidItem(string1[i],number1[i]);
    }
    RefCDOmTimingCheckEvent dataEvent = 
      CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor1,negedge,timingCheckCondition1);
    RefCDOmExpr timingCheckLimit = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    
    RefCDOmExpr number2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString string2 = RefString(new std::string("name3"));
    RefCDOmExprLink notifyReg = CDOmExprLink::build(10,string2,number2);
    
    RefCDOmSystemTimingCheck setup = CDOmSystemTimingCheck::buildSetup(10,specifyBlock, referenceEvent, dataEvent, timingCheckLimit, notifyReg);
    assert(setup->getTimingCheckType() == CDOmSystemTimingCheck::TIMING_CHECK_SETUP);
    assert(setup->getReferenceEvent() == referenceEvent);
    assert(setup->getDataEvent() == dataEvent);
    assert(setup->getTimingCheckLimit1() == timingCheckLimit);
    assert(setup->getNotifyReg() == notifyReg);
    
    //hold is the same as setup
    //setuphold
    
    RefCDOmTimingCheckEventControl posedge1 = CDOmTimingCheckEventControl::buildPosedge(10);
    RefCDOmExpr timingCheckCondition2 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmExprLink specifyTerminalDescriptor2;
    RefCDOmExpr number3[nr];
    RefString string3[nr];
    for(int i=0; i<nr; i++) {
      number3[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string3[i] = RefString(new std::string("name1"));
      if(!specifyTerminalDescriptor2.get())
        specifyTerminalDescriptor2 = CDOmExprLink::build(10,string3[i],number3[i]);
      else
        specifyTerminalDescriptor2->addHidItem(string3[i],number3[i]);
    }
    RefCDOmTimingCheckEvent referenceEvent1 = 
      CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor2,posedge1,
                                              timingCheckCondition2);
    
    RefCDOmTimingCheckEventControl negedge1 = CDOmTimingCheckEventControl::buildNegedge(10);
    RefCDOmExpr timingCheckCondition3 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmExprLink specifyTerminalDescriptor3;
    RefCDOmExpr number4[nr];
    RefString string4[nr];
    for(int i=0; i<nr; i++) {
      number4[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string4[i] = RefString(new std::string("name2"));
      if(!specifyTerminalDescriptor3.get())
        specifyTerminalDescriptor3 = CDOmExprLink::build(10,string4[i],number4[i]);
      else
        specifyTerminalDescriptor3->addHidItem(string4[i],number4[i]);
    }
    RefCDOmTimingCheckEvent dataEvent1 =  CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor3,negedge1,timingCheckCondition3);
    RefCDOmExpr timingCheckLimit1 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr timingCheckLimit2 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmMinTypMax stampTimeCondition = CDOmMinTypMax::build(10,expr);
    RefCDOmExpr expr1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmMinTypMax checkTimeCondition = CDOmMinTypMax::build(10,expr1);
    
    RefCDOmExprLink terminalIdentifier;
    RefCDOmExpr number5 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString string5 = RefString(new std::string("name"));
    terminalIdentifier = CDOmExprLink::build(10,string5,number5);

    RefCDOmExpr expr2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmMinTypMax minTypMax = CDOmMinTypMax::build(10,expr2); 
    RefCDOmDelayedDataOrReference delayedData = CDOmDelayedDataOrReference::build(10,terminalIdentifier, minTypMax);
    RefCDOmSystemTimingCheck setuphold = CDOmSystemTimingCheck::buildSetuphold(10,specifyBlock,
                            referenceEvent1,dataEvent1,timingCheckLimit1,timingCheckLimit2,RefCDOmExprLink(0),stampTimeCondition,
                            checkTimeCondition,RefCDOmDelayedDataOrReference(0),delayedData);
    assert(setuphold->getTimingCheckType() == CDOmSystemTimingCheck::TIMING_CHECK_SETUPHOLD);
    assert(setuphold->getReferenceEvent() == referenceEvent1);
    assert(setuphold->getDataEvent() == dataEvent1);
    assert(setuphold->getTimingCheckLimit1() == timingCheckLimit1);
    assert(setuphold->getTimingCheckLimit2() == timingCheckLimit2);
    assert(setuphold->getStampTimeCondition() == stampTimeCondition);
    assert(setuphold->getCheckTimeCondition() == checkTimeCondition);
    assert(setuphold->getDelayedData() == delayedData);

    //recovery and removal are the same as setup
    //recrem is the same as setuphold
    //skew is the same as setup
    //timeskew
    
    RefCDOmTimingCheckEventControl posedge2 = CDOmTimingCheckEventControl::buildPosedge(10);
    RefCDOmExpr timingCheckCondition4 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmExprLink specifyTerminalDescriptor4;
    RefCDOmExpr number6[nr];
    RefString string6[nr];
    for(int i=0; i<nr; i++) {
      number6[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string6[i] = RefString(new std::string("name1"));
      if(!specifyTerminalDescriptor4.get())
        specifyTerminalDescriptor4 = CDOmExprLink::build(10,string6[i],number6[i]);
      else
        specifyTerminalDescriptor4->addHidItem(string6[i],number6[i]);
    }
    RefCDOmTimingCheckEvent referenceEvent2 = CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor4,posedge2,timingCheckCondition4);
    
    RefCDOmTimingCheckEventControl negedge2 = CDOmTimingCheckEventControl::buildNegedge(10);
    RefCDOmExpr timingCheckCondition5 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmExprLink specifyTerminalDescriptor5;
    RefCDOmExpr number7[nr];
    RefString string7[nr];
    for(int i=0; i<nr; i++) {
      number7[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string7[i] = RefString(new std::string("name2"));
      if(!specifyTerminalDescriptor5.get())
        specifyTerminalDescriptor5 = CDOmExprLink::build(10,string7[i],number7[i]);
      else
        specifyTerminalDescriptor5->addHidItem(string7[i],number7[i]);
    }
    RefCDOmTimingCheckEvent dataEvent2 = 
      CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor5,negedge2,timingCheckCondition5);
    RefCDOmExpr timingCheckLimit3 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr eventBasedFlag =
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);         
    RefCDOmExpr expr3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);         
    RefCDOmMinTypMax remainActiveFlag = CDOmMinTypMax::build(10,expr3);

    RefCDOmSystemTimingCheck timeskew = CDOmSystemTimingCheck::buildTimeskew(10,specifyBlock,
                             referenceEvent2,dataEvent2,timingCheckLimit3,RefCDOmExprLink(0),eventBasedFlag,remainActiveFlag);
    assert(timeskew->getTimingCheckType() == CDOmSystemTimingCheck::TIMING_CHECK_TIMESKEW);
    assert(timeskew->getReferenceEvent() == referenceEvent2);
    assert(timeskew->getDataEvent() == dataEvent2);
    assert(timeskew->getTimingCheckLimit1() == timingCheckLimit3);
    assert(timeskew->getEventBasedFlag() == eventBasedFlag);
    assert(timeskew->getRemainActiveFlag() == remainActiveFlag);
  
    //fullekew is the same as timeskew plus another mandatory parameter timingCheckLimit2
    //period
    RefCDOmTimingCheckEventControl posedge3 = CDOmTimingCheckEventControl::buildPosedge(10);
    RefCDOmExpr timingCheckCondition6 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmExprLink specifyTerminalDescriptor6;
    RefCDOmExpr number8[nr];
    RefString string8[nr];
    for(int i=0; i<nr; i++) {
      number8[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string8[i] = RefString(new std::string("name1"));
      if(!specifyTerminalDescriptor6.get())
        specifyTerminalDescriptor6 = CDOmExprLink::build(10,string8[i],number8[i]);
      else
        specifyTerminalDescriptor6->addHidItem(string8[i],number8[i]);
    }
    RefCDOmTimingCheckEvent controlledReferenceEvent = CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor6,posedge3,timingCheckCondition6);
    RefCDOmExpr timingCheckLimit4 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmSystemTimingCheck period = CDOmSystemTimingCheck::buildPeriod(10,specifyBlock,controlledReferenceEvent,timingCheckLimit4);
    assert(period->getTimingCheckType() == CDOmSystemTimingCheck::TIMING_CHECK_PERIOD);
    assert(period->getControlledReferenceEvent() == controlledReferenceEvent);
    assert(period->getTimingCheckLimit1() == timingCheckLimit4);

    //width
    
    RefCDOmTimingCheckEventControl posedge4 = CDOmTimingCheckEventControl::buildPosedge(10);
    RefCDOmExpr timingCheckCondition7 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmExprLink specifyTerminalDescriptor7;
    RefCDOmExpr number9[nr];
    RefString string9[nr];
    for(int i=0; i<nr; i++) {
      number9[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string9[i] = RefString(new std::string("name1"));
      if(!specifyTerminalDescriptor7.get())
        specifyTerminalDescriptor7 = CDOmExprLink::build(10,string9[i],number9[i]);
      else
        specifyTerminalDescriptor7->addHidItem(string9[i],number9[i]);
    }
    RefCDOmTimingCheckEvent controlledReferenceEvent1 = CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor7,posedge4,timingCheckCondition7);
    RefCDOmExpr timingCheckLimit5 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr threshold = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmSystemTimingCheck width = CDOmSystemTimingCheck::buildWidth(10,specifyBlock, controlledReferenceEvent1,timingCheckLimit5,threshold);
      assert(width->getTimingCheckType() == CDOmSystemTimingCheck::TIMING_CHECK_WIDTH);
      assert(width->getControlledReferenceEvent() == controlledReferenceEvent1);
      assert(width->getTimingCheckLimit1() == timingCheckLimit5);
      assert(width->getThreshold() == threshold);
      
    //nochange
    RefCDOmTimingCheckEventControl posedge5 = CDOmTimingCheckEventControl::buildPosedge(10);
    RefCDOmExpr timingCheckCondition8 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmExprLink specifyTerminalDescriptor8;
    RefCDOmExpr number10[nr];
    RefString string10[nr];
    for(int i=0; i<nr; i++) {
      number10[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string10[i] = RefString(new std::string("name1"));
      if(!specifyTerminalDescriptor8.get())
        specifyTerminalDescriptor8 = CDOmExprLink::build(10,string10[i],number10[i]);
      else
        specifyTerminalDescriptor8->addHidItem(string10[i],number10[i]);
    }
    RefCDOmTimingCheckEvent referenceEvent3 = CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor8,posedge5,timingCheckCondition8);
    
    RefCDOmTimingCheckEventControl posedge6 = CDOmTimingCheckEventControl::buildPosedge(10);
    RefCDOmExpr timingCheckCondition9 = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmExprLink specifyTerminalDescriptor9;
    RefCDOmExpr number11[nr];
    RefString string11[nr];
    for(int i=0; i<nr; i++) {
      number11[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string11[i] = RefString(new std::string("name1"));
      if(!specifyTerminalDescriptor9.get())
        specifyTerminalDescriptor9 = CDOmExprLink::build(10,string11[i],number11[i]);
      else
        specifyTerminalDescriptor9->addHidItem(string11[i],number11[i]);
    }
    RefCDOmTimingCheckEvent dataEvent3 = CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor9,posedge6,timingCheckCondition9);
    RefCDOmExpr expr4 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmMinTypMax startEdgeOffset = CDOmMinTypMax::build(10,expr4);
    RefCDOmExpr expr5 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmMinTypMax endEdgeOffset = CDOmMinTypMax::build(10,expr5);
  
    RefCDOmSystemTimingCheck nochange = CDOmSystemTimingCheck::buildNochange(10,specifyBlock,referenceEvent3,dataEvent3,startEdgeOffset,endEdgeOffset);
    assert(nochange->getTimingCheckType() == CDOmSystemTimingCheck::TIMING_CHECK_NOCHANGE);
    assert(nochange->getReferenceEvent() == referenceEvent3);
    assert(nochange->getDataEvent() == dataEvent3);
    assert(nochange->getStartEdgeOffset() == startEdgeOffset);
    assert(nochange->getEndEdgeOffset() == endEdgeOffset);

 
    cout << "All done in testSystemTimingCheck" << endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

void testDelayedDataOrReference() {
  try{
    RefCDOmExprLink terminalIdentifier;
    RefCDOmExpr number = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString string = RefString(new std::string("name"));
    terminalIdentifier = CDOmExprLink::build(10,string,number);
    
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmMinTypMax minTypMax = CDOmMinTypMax::build(10,expr); 
    RefCDOmDelayedDataOrReference delayedData = CDOmDelayedDataOrReference::build(10,terminalIdentifier, minTypMax);
    
    assert(delayedData->getTerminalIdentifier() == terminalIdentifier);
    assert(delayedData->getMinTypMax() == minTypMax);
    
    cout << "All done in testDelayedDataOrReference" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

void testTimingCheckEvent() {
  try{
    const int nr = 3;
    RefCDOmTimingCheckEventControl posedge = CDOmTimingCheckEventControl::buildPosedge(10);
    RefCDOmExprLink specifyTerminalDescriptor;
    RefCDOmExpr number[nr];
    RefString string[nr];
    for(int i=0; i<nr; i++) {
      number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      string[i] = RefString(new std::string("name"));
      if(!specifyTerminalDescriptor.get())
        specifyTerminalDescriptor = CDOmExprLink::build(10,string[i],number[i]);
      else
        specifyTerminalDescriptor->addHidItem(string[i],number[i]);
    }
    RefCDOmExpr timingCheckCondition = 
      CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmTimingCheckEvent timingCheckEvent = 
      CDOmTimingCheckEvent::build(10,specifyTerminalDescriptor,posedge,timingCheckCondition);
    assert(timingCheckEvent->getSpecifyTerminalDescriptor() == specifyTerminalDescriptor);
    assert(timingCheckEvent->getTimingCheckEventControl() == posedge);
    assert(timingCheckEvent->getTimingCheckCondition() == timingCheckCondition);
    assert(timingCheckEvent->canBeControlled());

    cout << "All done in testTimingCheckEvent" << endl;

  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}


void testTimingCheckEventControl() {
  try{
    RefCDOmTimingCheckEventControl posedge = CDOmTimingCheckEventControl::buildPosedge(10);
    assert(posedge->getTimingCheckType() == CDOmTimingCheckEventControl::TIMING_CHECK_EV_POSEDGE);
    
    RefCDOmTimingCheckEventControl negedge = CDOmTimingCheckEventControl::buildNegedge(10);
    assert(negedge->getTimingCheckType() == CDOmTimingCheckEventControl::TIMING_CHECK_EV_NEGEDGE);

    RefCDOmTimingCheckEventControl edge = CDOmTimingCheckEventControl::buildEdge(10);
    assert(edge->getTimingCheckType() == CDOmTimingCheckEventControl::TIMING_CHECK_EV_EDGE);
    
    const int nr = 3;
    CDOmTimingCheckEventControl::EEdgeDescriptor edgeDescriptor[nr];
    edgeDescriptor[0] = CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1X;
    edgeDescriptor[1] = CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1Z;
    edgeDescriptor[2] = CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0Z;  
    for(int i=0; i<nr; i++)
      edge->addEdgeDescriptor(edgeDescriptor[i]);
    int index = 0;
    RefTVec_TInt intVec = edge->getEdgeDescriptors();
    for(TVec_TInt_const_iter iter = intVec->begin(); iter!=intVec->end(); ++iter)
      assert((*iter) == edgeDescriptor[index++]);
    
    cout << "All done in testTimingCheckEventControl" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testGateInstantiation() {
  try {
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    
    RefCDOmGateInstantiation gateCmos = CDOmGateInstantiation::build(10,moduleDecl,CDOmGateInstantiation::GATE_INST_RCMOS);
    //RefTVec_RefCDOmBase vec = gateCmos->getChildren<CDOmBase>(TYPE_ALL_TYPES);
    //cout << vec->size() << endl;
    
    gateCmos->buildDelay(10);
    
    RefString stringCmos = RefString(new std::string("a"));
    RefCDOmExpr expr1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr expr2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange rangeCmos = CDOmRange::build(10,expr1,expr2);
    gateCmos->addID(stringCmos,rangeCmos);

    RefString string = RefString(new std::string("a"));
    RefCDOmExpr number = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output = CDOmExprLink::build(10,string, number);
    gateCmos->addLvalue(output);

    RefCDOmExpr input = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateCmos->addExpr(input);

    
    RefCDOmExpr ncontrol = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateCmos->addExpr(ncontrol);
    
    // (* attr1, attr2 = 1, attr3 = 0, attr4 = 4 *)
    // (* attr_x, attr_y *)
    RefCDOmAttrListCollection attrListCollection = CDOmAttrListCollection::build(10);
    RefCDOmAttrList attrList = attrListCollection->buildAttrList(10);
    attrList->addAttr(10,RefString(new std::string("attr1")));
    attrList->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("1")));
    attrList->addAttr(10,RefString(new std::string("attr3")), quickBuild(new std::string("0")));
    attrList->addAttr(10,RefString(new std::string("attr4")), quickBuild(new std::string("2")));
	       
    attrList = attrListCollection->buildAttrList(10);
    attrList->addAttr(10,RefString(new std::string("attr_x")));
    attrList->addAttr(10,RefString(new std::string("attr_y")));
    
    gateCmos->setAttrListCollection(attrListCollection);
    assert(gateCmos->getAttrListCollection() == attrListCollection);
    //added an attributeListCollection(method from the mother class CDOmAttrHolder)
    
    RefCDOmExpr pcontrol = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateCmos->addExpr(pcontrol);

    // This is supposed to generate an illegal state exception:
    //RefCDOmExpr test = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    //gateCmos->addExpr(test);
    
    RefString string1 = RefString(new std::string("a"));
    RefCDOmExpr number1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output1 = CDOmExprLink::build(10,string1, number1);
    gateCmos->addLvalue(output1);

    //This is supposed to generate an illegal state exception:
    //RefString string2 = RefString(new std::string("a"));
    //RefCDOmExpr number2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    //RefCDOmExprLink output2 = CDOmExprLink::build(10,string2, number2);
    //gateCmos->addLvalue(output2);
    
    
    RefCDOmExpr input1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateCmos->addExpr(input1);
    
    RefCDOmExpr ncontrol1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateCmos->addExpr(ncontrol1);
    
    RefCDOmExpr pcontrol1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateCmos->addExpr(pcontrol1);

    RefString stringCmos1 = RefString(new std::string("a"));
    RefCDOmExpr expr3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr expr4 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange rangeCmos1 = CDOmRange::build(10,expr3,expr4);
    gateCmos->addID(stringCmos1,rangeCmos1);

    //if I stop here with the gate construction, checkFinalState() will generate an incomplete construction exception
    //gateCmos->checkFinalState();
    
    RefString string2 = RefString(new std::string("a"));
    RefCDOmExpr number2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output2 = CDOmExprLink::build(10,string2, number2);
    gateCmos->addLvalue(output2);
    
    RefCDOmExpr input2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateCmos->addExpr(input2);
    
    RefCDOmExpr ncontrol2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateCmos->addExpr(ncontrol2);
    
    RefCDOmExpr pcontrol2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateCmos->addExpr(pcontrol2);
    //at this point the cmos_gate is completely constructed:
    // ID,lv,e,e,alc,e,lv,e,e,e,ID,lv,e,e,e             lv = lvalue,  e = expr, ID = name_of_gate_instance, alc = attr_list_collection
    gateCmos->checkFinalState();
    
    assert(gateCmos->getPrimitiveType() == CDOmGateInstantiation::GATE_INST_RCMOS);
    assert(gateCmos->getGateType() == CDOmGateInstantiation::GATE_INST_CMOS_SWITCH);
    assert(gateCmos->hasDelay3());
    assert(!gateCmos->hasDelay2());
    RefCDOmDelay delay3 = gateCmos->getDelay();
    assert(delay3.get());
    assert(gateCmos->getNrOfInstances() == 3);

    RefTVec_RefCDOmBase vec0 = gateCmos->getInstance(0);
    assert(vec0->at(0) == rangeCmos);
    assert(vec0->at(1) == output);
    assert(vec0->at(2) == input);
    assert(vec0->at(3) == ncontrol);
    assert(vec0->at(4) == pcontrol);

    RefTVec_RefCDOmBase vec1 = gateCmos->getInstance(1);
    assert(vec1->at(0) == output1);
    assert(vec1->at(1) == input1);
    assert(vec1->at(2) == ncontrol1);
    assert(vec1->at(3) == pcontrol1);
    
    RefTVec_RefCDOmBase vec2 = gateCmos->getInstance(2);
    assert(vec2->at(0) == rangeCmos1);
    assert(vec2->at(1) == output2);
    assert(vec2->at(2) == input2);
    assert(vec2->at(3) == ncontrol2);
    assert(vec2->at(4) == pcontrol2);
    
    cerr << "gateCmos done" << endl;
    
    RefCDOmGateInstantiation gateMos = CDOmGateInstantiation::build(10,moduleDecl,CDOmGateInstantiation::GATE_INST_NMOS);

    RefString string3 = RefString(new std::string("a"));
    RefCDOmExpr number3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output3 = CDOmExprLink::build(10,string3, number3);
    gateMos->addLvalue(output3);
    
    RefCDOmExpr input3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateMos->addExpr(input3);
    
    // (* attr1, attr2 = 1, attr3 = 0, attr4 = 4 *)
    // (* attr_x, attr_y *)
    RefCDOmAttrListCollection attrListCollection1 = CDOmAttrListCollection::build(10);
    RefCDOmAttrList attrList1 = attrListCollection1->buildAttrList(10);
    attrList1->addAttr(10,RefString(new std::string("attr1")));
    attrList1->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("1")));
    attrList1->addAttr(10,RefString(new std::string("attr3")), quickBuild(new std::string("0")));
    attrList1->addAttr(10,RefString(new std::string("attr4")), quickBuild(new std::string("2")));
	       
    attrList1 = attrListCollection1->buildAttrList(10);
    attrList1->addAttr(10,RefString(new std::string("attr_x")));
    attrList1->addAttr(10,RefString(new std::string("attr_y")));

    gateMos->setAttrListCollection(attrListCollection1);
    assert(gateMos->getAttrListCollection() == attrListCollection1);
    //added an attrListCollection :method of hte mother class CDOmAttrHolder

    
    RefCDOmExpr enable = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateMos->addExpr(enable);
    
    RefString stringMos = RefString(new std::string("a"));
    RefCDOmExpr expr5 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr expr6 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange rangeMos = CDOmRange::build(10,expr5,expr6);
    gateMos->addID(stringMos,rangeMos);
    
    RefString string4 = RefString(new std::string("a"));
    RefCDOmExpr number4 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output4 = CDOmExprLink::build(10,string4, number4);
    gateMos->addLvalue(output4);
    
    RefCDOmExpr input4 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateMos->addExpr(input4);
    
    RefCDOmExpr enable1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateMos->addExpr(enable1);
    //complete enable_gate: lv,e,alc,e,ID,lv,e,e 
    
    assert(gateMos->getPrimitiveType() == CDOmGateInstantiation::GATE_INST_NMOS);
    assert(gateMos->getGateType() == CDOmGateInstantiation::GATE_INST_MOS_SWITCH);
    cerr << "gateMos done" << endl;
    RefCDOmGateInstantiation gateNinput = CDOmGateInstantiation::build(10,moduleDecl, CDOmGateInstantiation::GATE_INST_AND);
    
    RefString string5 = RefString(new std::string("a"));
    RefCDOmExpr number5 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output5 = CDOmExprLink::build(10,string5, number5);
    gateNinput->addLvalue(output5);
    
    const int nr = 3;
    RefCDOmExpr vinput[nr];
    for(int i=0; i<nr; i++) {
      vinput[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      gateNinput->addExpr(vinput[i]);
    }
   
    RefString string6 = RefString(new std::string("a"));
    RefCDOmExpr number6 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output6 = CDOmExprLink::build(10,string6, number6);
    gateNinput->addLvalue(output6);
    
    RefCDOmExpr input5 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateNinput->addExpr(input5);

    //complete n_input_gate: lv,list of 3 e,lv,list of one e
    assert(gateNinput->getPrimitiveType() == CDOmGateInstantiation::GATE_INST_AND);
    assert(gateNinput->getGateType() == CDOmGateInstantiation::GATE_INST_N_INPUT_GATE);
    
    gateNinput->setDriveStrength(DRIVE_STRENGTH_SUPPLY_1, DRIVE_STRENGTH_SUPPLY_0);
    assert(gateNinput->getFirstDriveStrength() == DRIVE_STRENGTH_SUPPLY_1);
    assert(gateNinput->getSecondDriveStrength() == DRIVE_STRENGTH_SUPPLY_0);
    cerr <<"gateNinput done" << endl;
    RefCDOmGateInstantiation gateNoutput = CDOmGateInstantiation::build(10,moduleDecl, CDOmGateInstantiation::GATE_INST_BUF);
    
    RefCDOmExprLink voutput[nr];
    RefCDOmExpr vnum[nr];
    RefString vstr[nr];
    for(int i=0; i<nr; i++){
      vstr[i] = RefString(new std::string("a"));
      vnum[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      voutput[i] = CDOmExprLink::build(10,vstr[i], vnum[i]);
      gateNoutput->addLvalue(voutput[i]);
    }
    RefCDOmExpr input6 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateNoutput->addExpr(input6);
    RefString string7 = RefString(new std::string("a"));
    RefCDOmExpr number7 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output7 = CDOmExprLink::build(10,string7, number7);
    gateNoutput->addLvalue(output7);
    
    RefCDOmExpr input7 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gateNoutput->addExpr(input7);
    //complete n_output_gate: list of 3 lv,e,list of one lv,e
    gateNoutput->setDriveStrength(DRIVE_STRENGTH_STRONG_0, DRIVE_STRENGTH_HIGHZ_1);
    assert(gateNoutput->getFirstDriveStrength() == DRIVE_STRENGTH_STRONG_0);
    assert(gateNoutput->getSecondDriveStrength() == DRIVE_STRENGTH_HIGHZ_1);
    assert(gateNoutput->getPrimitiveType() == CDOmGateInstantiation::GATE_INST_BUF);
    assert(gateNoutput->getGateType() ==  CDOmGateInstantiation::GATE_INST_N_OUTPUT_GATE);
    cerr << "gateNoutput done" << endl;
    RefCDOmGateInstantiation gatePassEnableSwitch = CDOmGateInstantiation::build(10,moduleDecl, CDOmGateInstantiation::GATE_INST_TRANIF1);

    RefString string8 = RefString(new std::string("a"));
    RefCDOmExpr number8 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink inout = CDOmExprLink::build(10,string8, number8);
    gatePassEnableSwitch->addLvalue(inout);
    
    RefString string9 = RefString(new std::string("a"));
    RefCDOmExpr number9 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink inout1 = CDOmExprLink::build(10,string9, number9);
    gatePassEnableSwitch->addLvalue(inout1);
    
    RefCDOmExpr enable2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gatePassEnableSwitch->addExpr(enable2);
    
    RefString string10 = RefString(new std::string("a"));
    RefCDOmExpr number10 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink inout2 = CDOmExprLink::build(10,string10, number10);
    gatePassEnableSwitch->addLvalue(inout2);
    
    RefString string11 = RefString(new std::string("a"));
    RefCDOmExpr number11 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink inout3 = CDOmExprLink::build(10,string11, number11);
    gatePassEnableSwitch->addLvalue(inout3);
    
    RefCDOmExpr enable3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    gatePassEnableSwitch->addExpr(enable3);
    //complete pass_enable_switch_gate: lv,lv,e,lv,lv,e
    assert(gatePassEnableSwitch->getPrimitiveType() == CDOmGateInstantiation::GATE_INST_TRANIF1);
    assert(gatePassEnableSwitch->getGateType() == CDOmGateInstantiation::GATE_INST_PASS_ENABLE_SWITCH);
    cerr << "gatePassEnableSwitch done" << endl;
    
    RefCDOmGateInstantiation gatePassSwitch = CDOmGateInstantiation::build(10,moduleDecl, CDOmGateInstantiation::GATE_INST_TRAN);
    
    RefString string12 = RefString(new std::string("a"));
    RefCDOmExpr number12 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink inout4 = CDOmExprLink::build(10,string12, number12);
    gatePassSwitch->addLvalue(inout4);
    
    RefString string13 = RefString(new std::string("a"));
    RefCDOmExpr number13 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink inout5 = CDOmExprLink::build(10,string13, number13);
    gatePassSwitch->addLvalue(inout5);
    
    RefString stringPassSwitch = RefString(new std::string("a"));
    RefCDOmExpr expr7 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr expr8 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange rangePassSwitch = CDOmRange::build(10,expr7,expr8);
    gatePassSwitch->addID(stringPassSwitch, rangePassSwitch);


    RefString string14 = RefString(new std::string("a"));
    RefCDOmExpr number14 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink inout6 = CDOmExprLink::build(10,string14, number14);
    gatePassSwitch->addLvalue(inout6);
    
    RefString string15 = RefString(new std::string("a"));
    RefCDOmExpr number15 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink inout7 = CDOmExprLink::build(10,string15, number15);
    gatePassSwitch->addLvalue(inout7);
    //complete pass_switch_gate: lv,lv,ID,lv,lv
    assert(gatePassSwitch->getPrimitiveType() == CDOmGateInstantiation::GATE_INST_TRAN);
    assert(gatePassSwitch->getGateType() == CDOmGateInstantiation::GATE_INST_PASS_SWITCH);
    cerr <<"gatePassSwitch done" << endl;
    
    RefCDOmGateInstantiation gatePullgate = CDOmGateInstantiation::build(10,moduleDecl,CDOmGateInstantiation::GATE_INST_PULLUP);
    
    RefString string16 = RefString(new std::string("a"));
    RefCDOmExpr number16 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output8 = CDOmExprLink::build(10,string16, number16);
    gatePullgate->addLvalue(output8);
    
    RefString string17 = RefString(new std::string("a"));
    RefCDOmExpr number17 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output9 = CDOmExprLink::build(10,string17, number17);
    gatePullgate->addLvalue(output9);
    
    RefString stringPullgate = RefString(new std::string("a"));
    RefCDOmExpr expr9 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr expr10 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange rangePullgate = CDOmRange::build(10,expr9,expr10);
    gatePullgate->addID(stringPullgate, rangePullgate);


    RefString string18 = RefString(new std::string("a"));
    RefCDOmExpr number18 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink output10 = CDOmExprLink::build(10,string18, number18);
    gatePullgate->addLvalue(output10);
    //complete pullgate :lv,lv,ID,lv
    gatePullgate->setSingleDriveStrength(DRIVE_STRENGTH_SUPPLY_1);
    assert(gatePullgate->getFirstDriveStrength() == DRIVE_STRENGTH_SUPPLY_1);

    assert(gatePullgate->getPrimitiveType() == CDOmGateInstantiation::GATE_INST_PULLUP);
    assert(gatePullgate->getGateType() == CDOmGateInstantiation::GATE_INST_PULLGATE);
    cerr << "gatePullgate done" << endl;
    cout << "All done in testGateInstantiation" << endl;

  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

void testAssn(RefCDOmExprLink hid){
  try{
    RefCDOmExpr num = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString str = RefString(new std::string("a"));
    RefCDOmExprLink lvalue = CDOmExprLink::build(10,str,num);
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmAssn assn = CDOmAssn::build(10,lvalue,expr);
    assert(assn->getLvalue() == lvalue);
    assert(assn->getExpr() == expr);

    cout << "All done in testAssn" <<endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

void testSpecifyTerminalList(){
  try{
    RefCDOmSpecifyTerminalList specifyTerminalList;; 
    const int nrExprs = 3;
    RefCDOmExpr number[nrExprs];
    RefString string[nrExprs];
    RefCDOmExprLink exprLink[nrExprs];
    string[0] = RefString(new std::string("string0"));
    string[1] = RefString(new std::string("string1"));
    string[2] = RefString(new std::string("string2"));
    for(int i = 0; i < nrExprs; ++i) {
      number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      exprLink[i] = CDOmExprLink::build(10,string[i],number[i]);
      if(!specifyTerminalList.get()) {
        specifyTerminalList = CDOmSpecifyTerminalList::build(10,exprLink[i]);//that happens only for i=0
      }
      else {
        specifyTerminalList->addItem(exprLink[i]);
      }
    }
    int index = 0;
    RefTVec_RefCDOmExprLink exprVec = specifyTerminalList->getItems();
    cout <<exprVec.get() << endl;
    for(TVec_RefCDOmExprLink_const_iter iter = exprVec->begin(); iter != exprVec->end(); ++iter) {
      assert((*iter) == exprLink[index++]);
    }

  cout << "All done in testSpecifyTerminalList" <<endl;
 
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testDesign(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    const int nr = 3;
    RefString string[nr];
    RefCDOmModuleDecl moduleDecl[nr];
    string[0] = RefString(new std::string("name0"));
    string[1] = RefString(new std::string("name1"));
    string[2] = RefString(new std::string("name2"));
    for(int i=0; i<nr; i++){
      moduleDecl[i] = design->buildModuleDecl(10,string[i],CDOmModuleDecl::KEYWORD_MODULE);
    }
    int index=0;
    RefTVec_RefCDOmModuleDecl moduleVec = design->getModuleDecls();
    //RefTVec_RefCDOmModuleDecl declVec = design->getTops();
    for(TVec_RefCDOmModuleDecl_const_iter iter = moduleVec->begin(); iter!=moduleVec->end(); ++iter)
      assert((*iter) == moduleDecl[index++]);
    //index=0;
    //for(TVec_RefCDOmModuleDecl_const_iter iter = declVec->begin(); iter!=declVec->end(); ++iter)
     // assert((*iter) == moduleDecl[index++]);
    
    cout << "All done in testDesign" << endl;
    

  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testPathDelayValue(){
  try{
    RefCDOmExpr number = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmMinTypMax minTypMax = CDOmMinTypMax::build(10,number);
    RefCDOmMinTypMaxList minTypMaxList = CDOmMinTypMaxList::build(10,minTypMax);
    RefCDOmPathDelayValue pathDelayValue = CDOmPathDelayValue::build(10,CDOmPathDelayValue::PATH_DELAY_WITHOUT_PAREN,minTypMaxList);
    assert(pathDelayValue->getStyle() == CDOmPathDelayValue::PATH_DELAY_WITHOUT_PAREN);
    assert(pathDelayValue->getMinTypMaxList() == minTypMaxList);

    cout << "All done in testPathDelayValue" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
*/

void testMinTypMaxList(){
  try{
    
    RefCDOmMinTypMaxList minTypMaxList;
    const int nrExprs = 10;
    RefCDOmExpr number[nrExprs];
    RefCDOmMinTypMax minTypMax[nrExprs];
  
    for(int i = 0; i < nrExprs; ++i) {
      number[i] = CDOmNumber::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("a")), true);
      minTypMax[i] = CDOmMinTypMax::build(10, number[i]);
      if(!minTypMaxList.get()) {
        minTypMaxList = CDOmMinTypMaxList::build(10, minTypMax[i]);//that happens only for i=0
      }
      else {
        minTypMaxList->addItem(minTypMax[i]);
      }
    }
    int index = 0;
    RefTVec_RefCDOmMinTypMax exprVec = minTypMaxList->getItems();
    //cout <<exprVec.get() << endl;
    for(TVec_RefCDOmMinTypMax_const_iter iter = exprVec->begin(); iter != exprVec->end(); ++iter) {
      assert((*iter) == minTypMax[index++]);
      cout << (*iter)->getMinTypMaxType() << " ";
    }

  cout << "All done in testMinTypMaxList" <<endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
/*
void testString(){
  try{
    RefString tokenString = RefString(new std::string("a"));
    RefString strVal = RefString(new std::string("a"));
    RefCDOmString string = CDOmString::build(10,tokenString,strVal);
    assert(string->getTokenString() == tokenString);
    assert(string->isConst());
    assert(!string->canBeModulePath());
    
    cout << "All done in testString" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testReal(){
  try{
    RefString tokenString = RefString(new std::string("a"));
    RefString lightString = RefString(new std::string("a"));
    RefCDOmReal real = CDOmReal::build(10,tokenString,lightString);
    assert(real->getTokenString() == tokenString);

    cout << "All done in testReal" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testNumber(){
  try{
    TInt n=9;
    TBool sign = true;
    RefString tokenString = RefString(new std::string("799"));
    RefString lightString = RefString(new std::string("799"));
    RefCDOmNumber number = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,tokenString,lightString,sign,n);
    assert(number->isSigned() == sign);
    assert(number->getSize() == n);
    assert(number->getNumBaseType() == CDOmNumber::NUM_BASE_DEC);
    assert(number->getTokenString() == tokenString);

    cout << "All done in testNumber" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testPulseStyleOrShowCancelledDecl(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefCDOmSpecifyBlock specifyBlock = CDOmSpecifyBlock::build(10,moduleDecl);
    
    RefCDOmExpr number = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString string = RefString(new std::string("name"));
    RefCDOmExprLink exprLink = CDOmExprLink::build(10,string,number);
    //std::cout << exprLink.get() << endl;
    //assert(!exprLink->isHID());
    //assert(!exprLink->getArrayIndexes().get());
    RefCDOmSpecifyTerminalList specifyTerminalList = CDOmSpecifyTerminalList::build(10,exprLink);
    RefCDOmPulseStyleOrShowCancelledDecl pulseStyleOrShowCancelledDecl = 
          CDOmPulseStyleOrShowCancelledDecl::build(10,specifyBlock,CDOmPulseStyleOrShowCancelledDecl::PULSESTYLE_ONEVENT,specifyTerminalList);
    assert(pulseStyleOrShowCancelledDecl->getDeclType() == CDOmPulseStyleOrShowCancelledDecl::PULSESTYLE_ONEVENT);
    RefTVec_RefCDOmBase vec = pulseStyleOrShowCancelledDecl->getChildren<CDOmBase>(TYPE_ALL_TYPES); 
    assert(vec->size() == 1);
    assert(*vec->begin() == specifyTerminalList);
    cout <<"All done in testPulseStyleOrShowCancelledDecl" << endl;
     
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testFunctionCall(RefCDOmExprLink exprLink,RefCDOmListExpr exprList){
  try{
    RefCDOmAttrListCollection attrListCollection = CDOmAttrListCollection::build(10);
    RefCDOmFunctionCall functionCall = CDOmFunctionCall::build(10,exprLink,exprList,attrListCollection);
    assert(functionCall->getFunctionCallType() == CDOmFunctionCall::FUNCTION_CALL_HID);
    assert(!functionCall->isConst());
    
    cout << "All done in testFunction Call" << endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testSpecifyBlock(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl= design->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmSpecifyBlock specifyBlock = CDOmSpecifyBlock::build(10,moduleDecl);

    cout << "All done in testSpecifyBlock" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testInitOrAlways(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmt stmt = CDOmStmt::buildNullStmt(10);
    RefCDOmStmtWait stmtWait = CDOmStmtWait::build(10,expr,stmt);
    RefCDOmInitOrAlways initOrAlways = CDOmInitOrAlways::build(10,moduleDecl,CDOmInitOrAlways::INIT_OR_ALWAYS_INIT,stmtWait);
    assert(initOrAlways->getInitOrAlwaysType() == CDOmInitOrAlways::INIT_OR_ALWAYS_INIT);
    assert(initOrAlways->getStmt() == stmtWait);

    cout << "All done in testInitOrAlways" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

void testModuleOrUdpInstantiation(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink exprLink = CDOmExprLink::build(10,RefString(new std::string("nameExprLink")),expr);
    RefCDOmModuleOrUdpInstantiation moduleInstantiation0 = CDOmModuleOrUdpInstantiation::build(10,moduleDecl,exprLink);
    assert(moduleInstantiation0->getModuleInstantiationType() == CDOmModuleOrUdpInstantiation::MODULE_OR_UDP_INSTANTIATION);

    const int nr = 3;
    RefCDOmExpr vexpr[nr];
    for(int i=0; i<nr; i++){
      vexpr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      moduleInstantiation0->addOrderedParamAssn(vexpr[i]);
    }
    
    RefCDOmExpr expr1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink exprLink1 = CDOmExprLink::build(10,RefString(new std::string("nameExprLink")),expr1);
    RefCDOmModuleOrUdpInstantiation moduleInstantiation = CDOmModuleOrUdpInstantiation::build(10,moduleDecl,exprLink1);
    RefString vstring[nr];
    RefCDOmExpr vexpr1[nr];
    vstring[0] = RefString(new std::string("string0"));
    vstring[1] = RefString(new std::string("string1"));
    vstring[2] = RefString(new std::string("string2"));
    RefCDOmMinTypMax minTypMax[nr];
    for(int i=0; i<nr; i++){
      vexpr1[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      minTypMax[i] = CDOmMinTypMax::build(10,vexpr1[i]);
      moduleInstantiation->addNamedParamAssn(vstring[i],minTypMax[i]);
      assert(moduleInstantiation->containsExplicitParamName(vstring[i]));
      assert(moduleInstantiation->getParamExpr(vstring[i]) == minTypMax[i]);
      
    }

    RefCDOmModuleOrUdpInstance moduleInstance[nr];
    RefString  vstring1[nr];
    RefCDOmExpr firstExpr[nr]; 
    RefCDOmExpr secondExpr[nr];
    RefCDOmRange range[nr];
    vstring1[0] =RefString(new std::string("vstring0")) ;
    vstring1[1] =RefString(new std::string("vstring1")) ;
    vstring1[2] =RefString(new std::string("vstring2")) ;
    for(int i=0; i<nr; i++){
      firstExpr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      secondExpr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      range[i] = CDOmRange::build(10,firstExpr[i],secondExpr[i]);
      moduleInstance[i] = moduleInstantiation->buildModuleInstance(10,vstring1[i],range[i]);
    }
    
    int index=0;
    RefTVec_RefCDOmModuleOrUdpInstance moduleVec = moduleInstantiation->getModuleInstances();
    for(TVec_RefCDOmModuleOrUdpInstance_const_iter iter = moduleVec->begin(); iter!=moduleVec->end(); ++iter)
      assert((*iter) == moduleInstance[index++]);
    cout << "All done in testModuleOrUdpInstantiation" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testModuleOrUdpInstance(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink exprLink = CDOmExprLink::build(10,RefString(new std::string("nameExprLink")),expr);
    RefCDOmModuleOrUdpInstantiation moduleInstantiation = CDOmModuleOrUdpInstantiation::build(10,moduleDecl,exprLink);
    RefString string = RefString(new std::string("string0"));
    RefCDOmExpr firstExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange range = CDOmRange::build(10,firstExpr,secondExpr);
    RefCDOmModuleOrUdpInstance moduleInstance = moduleInstantiation->buildModuleInstance(10,string,range);
    assert(moduleInstance->getModuleInstanceType() == CDOmModuleOrUdpInstance::MODULE_INSTANCE_UNDEFINED);
    assert(moduleInstance->getRange() == range);

    const int nr = 3;
    RefCDOmAttrListCollection attrListCollection[nr];
    RefCDOmExpr vexpr[nr];
    RefString vstring[nr];
    vstring[0] = RefString(new std::string("name0"));
    vstring[1] = RefString(new std::string("name1"));
    vstring[2] = RefString(new std::string("name2"));
    for(int i=0; i<nr; i++){
      attrListCollection[i] = CDOmAttrListCollection::build(10);
      vexpr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      moduleInstance->addPortConnection(attrListCollection[i],vexpr[i],vstring[i]);
      assert(moduleInstance->containsExplicitPortName(vstring[i]));
      assert(moduleInstance->getPortExpr(vstring[i]) == vexpr[i]);

    }
    

    cout << "All done in testModuleOrUdpInstance" << endl;
 
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testContAssn(RefCDOmExprLink hid[]){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmContAssn contAssn = CDOmContAssn::build(10,moduleDecl,DRIVE_STRENGTH_SUPPLY_0,DRIVE_STRENGTH_SUPPLY_1);
    assert(contAssn->getFirstDriveStrength() == DRIVE_STRENGTH_SUPPLY_0);
    assert(contAssn->getSecondDriveStrength() == DRIVE_STRENGTH_SUPPLY_1);
    const int nr = 3;
    RefCDOmAssn assn[nr];
    RefCDOmExpr num[nr];
    RefString str[nr];
    RefCDOmExprLink lvalue[nr];
    RefCDOmExpr expr[nr];
    for(int i=0; i<nr; i++){
      expr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      num[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      str[i] = RefString(new std::string("a"));
      lvalue[i] = CDOmExprLink::build(10,str[i],num[i]);
      assn[i] = CDOmAssn::build(10,lvalue[i],expr[i]);
      contAssn->addNetAssn(assn[i]);
    }
    int index=0;
    RefTVec_RefCDOmAssn assnVec = contAssn->getNetAssns();
    for(TVec_RefCDOmAssn_const_iter iter = assnVec->begin(); iter!=assnVec->end(); ++iter)
      assert((*iter) == assn[index++]);
    
    assert(!contAssn->hasDelay3());
    contAssn->buildDelay3(10);
    RefCDOmDelay delay = contAssn->getDelay3();
    assert(contAssn->hasDelay3());

    cout << "All done in testContAssn" <<endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testParamOverride(){
  try{
    const int nr = 3;
    RefCDOmExprLink exprLink[nr];
    RefCDOmExpr number[nr];
    RefString string[nr];
    for(int k=0; k<nr; k++)
      for(int i=0; i<nr; i++){
        string[i] = RefString(new std::string("a"));
        number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      
        if(!exprLink[k].get()){
          exprLink[k] = CDOmExprLink::build(10,string[i],number[i]);
          assert(exprLink[k]->getName() == string[i]);
        }
        else{
          exprLink[k]->addHidItem(string[i],number[i]);
        }
      }
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmParamOverride paramOverride;
    RefCDOmExpr expr[nr];
    RefCDOmMinTypMax minTypMax[nr];
    for(int i=0; i<nr; i++){
      expr[i]= CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      minTypMax[i] = CDOmMinTypMax::build(10,expr[i]);
      if(!paramOverride.get()){
        paramOverride = CDOmParamOverride::build(10,moduleDecl,exprLink[i],minTypMax[i]);
      } 
      else{
        paramOverride->addParamAssn(exprLink[i],minTypMax[i]);
      }
    }
     
   int index=0;
   RefTVec_RefCDOmExprLink linkVec = paramOverride->getChildren<CDOmExprLink>(TYPE_EXPR);
   for(TVec_RefCDOmExprLink_const_iter iter = linkVec->begin(); iter!=linkVec->end() && (iter+1)!=linkVec->end(); iter+=2){
      assert((*iter).get() == exprLink[index++].get());
   }
   index=0;
   RefTVec_RefCDOmMinTypMax minTypMaxVec = paramOverride->getChildren<CDOmMinTypMax>(TYPE_EXPR);
   for(TVec_RefCDOmMinTypMax_const_iter iter = (minTypMaxVec->begin()); iter!=minTypMaxVec->end() && (iter+1)!=minTypMaxVec->end(); iter+=2){
     assert((*(iter+1)).get() == minTypMax[index++].get());
   }
 

    cout << "All done in testParamOverride" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testGenvarDecl(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmGenvarDecl genvarDecl;
    const int nr=3;
    RefString string[nr];
    string[0] = RefString(new std::string("genvar0"));
    string[1] = RefString(new std::string("genvar1"));
    string[2] = RefString(new std::string("genvar2"));
    for(int i=0; i<nr; i++){
      if(!genvarDecl.get()){
        genvarDecl = CDOmGenvarDecl::build(10,moduleDecl,string[i]);
        assert(genvarDecl->containsGenvar(string[i]));
      }
      else{
        genvarDecl->addGenvar(10,string[i]);
        assert(genvarDecl->containsGenvar(string[i]));
      }
    }
    int index=0;
    RefTVec_RefCDOmIdentifier identVec = genvarDecl->getIDs();
    for(TVec_RefCDOmIdentifier_const_iter iter = identVec->begin(); iter!=identVec->end(); ++iter)
      assert((*iter)->getName() == string[index++]);

    cout << "All done in testGenvarDecl" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testEventDecl(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmEventDecl eventDecl;
    
    const int nr=3;
    RefCDOmRangeList rangeList1[nr];
    RefCDOmExpr firstExpr1[nr];
    RefCDOmExpr secondExpr1[nr];
    RefCDOmRange range1[nr]; 
    RefString string[nr];
    string[0] = RefString(new std::string("event0"));
    string[1] = RefString(new std::string("event1"));
    string[2] = RefString(new std::string("event2"));
    for(int i=0; i<nr; i++){
      firstExpr1[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      secondExpr1[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      range1[i] = CDOmRange::build(10,firstExpr1[i],secondExpr1[i]);
      rangeList1[i] = CDOmRangeList::build(10,range1[i]);
      if(!eventDecl.get()){
        eventDecl = CDOmEventDecl::build(10,moduleDecl,string[i],rangeList1[i]);
        assert(eventDecl->containsEvent(string[i]));
        assert(eventDecl->getEventRangeList(string[i]) == rangeList1[i]);
      }
      else{
        eventDecl->addEvent(10,string[i],rangeList1[i]);
        assert(eventDecl->containsEvent(string[i]));
        assert(eventDecl->getEventRangeList(string[i]) == rangeList1[i]);
      }
    }
    int index1=0;
    int index2=0;
    RefTVec_RefCDOmIdentifier identVec = eventDecl->getIDs();
    for(TVec_RefCDOmIdentifier_const_iter iter = identVec->begin(); iter!=identVec->end(); ++iter){
      assert((*iter)->getName() == string[index1++]);
      assert((*iter)->getPayload() == rangeList1[index2++]);
    }
    
    cout << "All done in testEventDecl" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testNetDecl(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmNetDecl netDecl = CDOmNetDecl::build(10,moduleDecl,NET_SUPPLY0);
    assert(netDecl->getNetType() == NET_SUPPLY0);
    netDecl->setSigned();
    assert(netDecl->isSigned());
    netDecl->buildDelay3(10);
    RefCDOmDelay delay = netDecl->getDelay3();
    assert(netDecl->hasDelay3());

    RefCDOmNetDecl netDecl1 = CDOmNetDecl::build(10,moduleDecl,NET_SUPPLY0);
    netDecl1->setDriveStrength(DRIVE_STRENGTH_SUPPLY_0,DRIVE_STRENGTH_SUPPLY_1);
    assert(netDecl1->getFirstDriveStrength() == DRIVE_STRENGTH_SUPPLY_0);
    assert(netDecl1->getSecondDriveStrength() == DRIVE_STRENGTH_SUPPLY_1);

    
    RefCDOmNetDecl netDecl2 = CDOmNetDecl::build(10,moduleDecl,NET_TRIREG);
    netDecl2->setChargeStrength(CDOmNetDecl::CHARGE_STRENGTH_MEDIUM);
    assert(netDecl2->getChargeStrength() == CDOmNetDecl::CHARGE_STRENGTH_MEDIUM);

    RefCDOmNetDecl netDecl3 = CDOmNetDecl::build(10,moduleDecl,NET_SUPPLY1);
    RefCDOmExpr firstExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange range = CDOmRange::build(10,firstExpr,secondExpr);
    netDecl3->setRange(range,CDOmNetDecl::VECTOR_ACCESS_SCALARED);
    assert(netDecl3->getRange() == range);
    assert(netDecl3->getVectorAccessType() == CDOmNetDecl::VECTOR_ACCESS_SCALARED);
    
    RefCDOmNetDecl netDecl4 = CDOmNetDecl::build(10,moduleDecl,NET_SUPPLY1);
    const int nr=3;
    RefString string[nr];
    RefCDOmExpr firstExpr1[nr],secondExpr1[nr];
    RefCDOmRange range1[nr];
    RefCDOmRangeList rangeList[nr];
    string[0] = RefString(new std::string("net0"));
    string[1] = RefString(new std::string("net1"));
    string[2] = RefString(new std::string("net2"));
    for(int i=0; i<nr; i++){
      firstExpr1[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      secondExpr1[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      range1[i] = CDOmRange::build(10,firstExpr1[i],secondExpr1[i]);
      rangeList[i] = CDOmRangeList::build(10,range1[i]);
      netDecl4->addNet(10,string[i],rangeList[i]);
      assert(netDecl4->containsNet(string[i]));
      assert(netDecl4->getNetRangeList(string[i]) == rangeList[i]);
    }
    int index1=0;
    int index2=0;
    RefTVec_RefCDOmIdentifier identVec = netDecl4->getIDs();
    for(TVec_RefCDOmIdentifier_const_iter iter = identVec->begin(); iter!=identVec->end(); ++iter){
      assert((*iter)->getName() == string[index1++]);
      assert((*iter)->getPayload() == rangeList[index2++]);
    }
    
    RefCDOmNetDecl netDecl5 = CDOmNetDecl::build(10,moduleDecl,NET_TRI);
    RefCDOmExpr expr[nr];
    RefString string1[nr];
    string1[0] = RefString(new std::string("net3"));
    string1[1] = RefString(new std::string("net4"));
    string1[2] = RefString(new std::string("net5"));
    for(int i=0; i<nr; i++){
      expr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      netDecl5->addNet(10,string1[i],expr[i]);
      assert(netDecl5->containsNet(string1[i]));
      assert(netDecl5->getNetVal(string1[i]) == expr[i]);
    }
    int index3=0;
    int index4=0;
    RefTVec_RefCDOmIdentifier identVec1 = netDecl5->getIDs();
    for(TVec_RefCDOmIdentifier_const_iter iter1 = identVec1->begin(); iter1!=identVec1->end(); ++iter1){
      assert((*iter1)->getName() == string1[index3++]);
      assert((*iter1)->getPayload() == expr[index4++]);
    }

    cout << "All done in testNetDecl"  << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testDelay(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmNetDecl netDecl = CDOmNetDecl::build(10,moduleDecl,NET_SUPPLY0);
    netDecl->buildDelay3(10);
    RefCDOmDelay delay = netDecl->getDelay3();//delayDeclType = UNDEFINED
    assert(delay->getDelayType() == CDOmDelay::DELAY_3);

    RefCDOmNumber number = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    delay->setNumDelayValue(number);//delayDeclType = DECL_1
    assert(delay->getNumDelayValue() == number);
    
    RefCDOmDesign design1 = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl1 = design1->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmNetDecl netDecl1 = CDOmNetDecl::build(10,moduleDecl,NET_SUPPLY0);
    netDecl1->buildDelay3(10);
    RefCDOmDelay delay1 = netDecl1->getDelay3();//delayDecltype = UNDEFINED
    RefCDOmReal realNumber = CDOmReal::build(10,RefString(new std::string("a")),RefString(new std::string("a")));
    delay1->setRealNumDelayValue(realNumber);//delayDeclype = DECL_2
    assert(delay1->getRealNumDelayValue() == realNumber);
    
    RefCDOmDesign design2 = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl2 = design2->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmNetDecl netDecl2 = CDOmNetDecl::build(10,moduleDecl2,NET_SUPPLY0);
    netDecl2->buildDelay3(10);
    RefCDOmDelay delay2 = netDecl2->getDelay3();//delayDeclType = UNDEFINED
    RefString string = RefString(new std::string("string"));
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink exprLink = CDOmExprLink::build(10,string,expr);
  delay2->setExprLink(exprLink);//delayDeclType = DECL_3
    assert(delay2->getExprLink() == exprLink);
    
    RefCDOmDesign design3 = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl3 = design3->buildModuleDecl(10,RefString(new std::string("moduleName")));
    RefCDOmNetDecl netDecl3 = CDOmNetDecl::build(10,moduleDecl3,NET_SUPPLY0);
    netDecl3->buildDelay3(10);
    RefCDOmDelay delay3 = netDecl3->getDelay3();//delayDeclType = UNDEFINED
    const int nr=3;
    RefCDOmMinTypMax minTypMax[nr];
    RefCDOmExpr vexpr[nr];
    for(int i=0; i<3; i++){
      vexpr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      minTypMax[i] = CDOmMinTypMax::build(10,vexpr[i]);
      delay3->addMinTypMax(minTypMax[i]);//delayDeclType = DECL_4
      assert(delay3->getMinTypMax(i) == minTypMax[i]);
    }
    
    
    cout << "All done in testDelay" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testMinTypMax(){
  try{
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr expr1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr expr2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr expr3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmMinTypMax minTypMax = CDOmMinTypMax::build(10,expr);
    assert(minTypMax->getMinTypMaxType() == CDOmMinTypMax::MINTYPMAX_SINGLE);
    RefCDOmMinTypMax minTypMax1 = CDOmMinTypMax::build(10,expr1,expr2,expr3);
    assert(minTypMax1->getMinTypMaxType() == CDOmMinTypMax::MINTYPMAX_TRIAD);

    cout << "All done in testMinTypMax" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testVarDecl(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefCDOmVarDecl varDecl = CDOmVarDecl::build(10,moduleDecl,VAR_REG);
    assert(varDecl->getVarType() == VAR_REG);
    varDecl->setSigned();
    assert(varDecl->isSigned());

    RefCDOmExpr firstExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange range = CDOmRange::build(10,firstExpr,secondExpr);
    varDecl->setRange(range);
    cout << "Hello!" << endl;
    assert(varDecl->getRange() == range);
    cout << "Hello!" << endl;
    
    RefCDOmExpr firstExpr1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange range1 = CDOmRange::build(10,firstExpr1,secondExpr1);
    RefCDOmRangeList rangeList = CDOmRangeList::build(10,range1);
    RefString string = RefString(new std::string("a"));
    varDecl->addVar(10,string,rangeList);
    assert(varDecl->containsVar(string));
    cout << "Hello!" << endl;
    assert(varDecl->getVarRangeList(string) == rangeList);
    cout << "Hello!" << endl;
    
    RefCDOmVarDecl varDecl1 = CDOmVarDecl::build(10,moduleDecl,VAR_REG);
    const int nr=3;
    RefCDOmExpr expr[nr];
    RefString vstring[nr];
    vstring[0]= RefString(new std::string("string0"));
    vstring[1]= RefString(new std::string("string1"));
    vstring[2]= RefString(new std::string("string2"));
    for(int i=0; i<nr; i++){
      expr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("b")),RefString(new std::string("b")),true,10);
      varDecl1->addVar(10,vstring[i],expr[i]);
      assert(varDecl1->containsVar(vstring[i]));
      cout << "Hello!" << endl;
      assert(varDecl1->getVarVal(vstring[i]) == expr[i]);
      cout << "Hello!" << endl;
    }

    int index1=0;
    int index2=0;
    RefTVec_RefCDOmIdentifier identVec = varDecl1->getIDs();
    for(TVec_RefCDOmIdentifier_const_iter iter = identVec->begin(); iter!=identVec->end(); ++iter){
      assert((*iter)->getName() == vstring[index1++]);
      assert((*iter)->getPayload() == expr[index2++]);
    }
    
    cout << "All done in testVarDecl" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testFuncDecl(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefCDOmFuncDecl funcDecl = CDOmFuncDecl::build(10,moduleDecl,CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST,RefString(new std::string("name")),true,true);
    assert(funcDecl->getFuncDeclType() == CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST);
    assert(funcDecl->isAutomatic());
    assert(funcDecl->isSigned());
    
    RefCDOmExpr firstExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange range = CDOmRange::build(10,firstExpr,secondExpr);
    funcDecl->setRange(range);
    assert(funcDecl->getRange() == range);
    
    RefCDOmFuncDecl funcDecl1 = CDOmFuncDecl::build(10,moduleDecl,CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST,RefString(new std::string("name1")),true,true);
    funcDecl1->setVarType(VAR_INTEGER);
    assert(funcDecl1->getVarType() == VAR_INTEGER);
    
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmt stmt = CDOmStmt::buildNullStmt(10);
    RefCDOmStmtWait stmtWait = CDOmStmtWait::build(10,expr,stmt);
    funcDecl->setFuncStmt(stmtWait);
    assert(funcDecl->getFuncStmt() == stmtWait);
    
    cout << "All done in testFuncDecl" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testTaskDecl(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefString string = RefString(new std::string("name1"));
    RefCDOmTaskDecl taskDecl = CDOmTaskDecl::build(10,moduleDecl,CDOmTaskDecl::TASK_DECL_WITHOUT_TASK_PORT_LIST,string,true);
    assert(taskDecl->getTaskDeclType() == CDOmTaskDecl::TASK_DECL_WITHOUT_TASK_PORT_LIST);
    assert(taskDecl->isAutomatic());

    RefCDOmStmt stmt = CDOmStmt::buildNullStmt(10);
    taskDecl->setStmt(stmt);
    assert(taskDecl->getStmt() == stmt);

    cout << "All done in testTaskDecl" << endl;

  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testTFPortDecl(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("a")));
    RefString string = RefString(new std::string("task"));
    RefCDOmTaskDecl taskDecl = CDOmTaskDecl::build(10,moduleDecl,CDOmTaskDecl::TASK_DECL_WITHOUT_TASK_PORT_LIST,string,true);
    RefCDOmTFPortDecl tfPortDecl = CDOmTFPortDecl::build(10,taskDecl,PORT_INOUT,VAR_REG);
    assert(tfPortDecl->getPortType() == PORT_INOUT);
    assert(tfPortDecl->getVarType() == VAR_REG);
    tfPortDecl->setSigned();
    assert(tfPortDecl->isSigned());
    
    RefCDOmExpr firstExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange range = CDOmRange::build(10,firstExpr,secondExpr);
    tfPortDecl->setRange(range);
    assert(tfPortDecl->getRange() == range);

    const int nr=3;
    RefString vstring[nr];
    vstring[0] = RefString(new std::string("first"));
    vstring[1] = RefString(new std::string("second"));
    vstring[2] = RefString(new std::string("third"));
    for(int i=0; i<nr; i++){
      tfPortDecl->addPort(10,vstring[i]);
      assert(tfPortDecl->containsPort(vstring[i]));
    }
    int index=0;
    RefTVec_RefCDOmIdentifier identVec = tfPortDecl->getIDs();
    for(TVec_RefCDOmIdentifier_const_iter iter = identVec->begin(); iter!=identVec->end(); ++iter)
      assert((*iter)->getName() == vstring[index++]);
 

    cout << "All done in testTFPortDecl" << endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testModuleDecl(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("a")));//moduleDeclType=UNDEFINED
    RefString string = RefString(new std::string("simple"));
    RefCDOmPortItem portItem = moduleDecl->buildPortItem(10,CDOmPortItem::PORT_ITEM_SIMPLE,string) ;//moduleDeclType=DECL_1
    assert(moduleDecl->containsExplicitPortName(string));
    assert(moduleDecl->getPortItem(string) == portItem);
    
    RefString string1 = RefString(new std::string("a"));
    RefCDOmPortItem portItem1 = moduleDecl->buildPortItem(10,CDOmPortItem::PORT_ITEM_CONCAT,string1);
    const int nr=10;
    RefString vstring[nr];
    RefCDOmExpr number[nr];
    RefCDOmExprLink exprLink[nr];
    for(int i=0; i<nr; i++){
      vstring[i] = RefString(new std::string("a"));
      number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      exprLink[i] = CDOmExprLink::build(10,vstring[i],number[i]);
      portItem1->addPortExprLink(exprLink[i]);
      assert(moduleDecl->containsPortExprLink(vstring[i]));
    }
    RefCDOmModuleDecl moduleDecl1 = design->buildModuleDecl(10,RefString(new std::string("b")));//moduleDeclType=UNDEFINED
    RefCDOmPortDecl portDecl[nr];
    for(int i=0; i<nr; i++)
      portDecl[i] = CDOmPortDecl::buildNetPortDecl(10,moduleDecl1,PORT_INOUT,NET_SUPPLY0);//moduleDeclType=DECL_2
    int index=0;
    RefTVec_RefCDOmPortDecl portVec = moduleDecl1->getPortDecls();
    for(TVec_RefCDOmPortDecl_const_iter iter = portVec->begin(); iter!=portVec->end(); ++iter){
      assert((*iter) == portDecl[index++]);
    }
    
    
    cout << "All done in testModuleDecl" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testPortItem(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefString string = RefString(new std::string("portSimple"));
    RefCDOmPortItem portItem = moduleDecl->buildPortItem(10,CDOmPortItem::PORT_ITEM_SIMPLE,string);
    assert(portItem->getPortItemType() == CDOmPortItem::PORT_ITEM_SIMPLE);
    assert(portItem->getExplicitName() == string);
    const int nr=10;
    RefString vstring[nr];
    RefCDOmExpr number[nr];
    RefCDOmExprLink exprLink[nr];
    for(int i=0; i<nr; i++){
      vstring[i] = RefString(new std::string("a"));
      number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      exprLink[i] = CDOmExprLink::build(10,vstring[i],number[i]);

    }
      
    portItem->addPortExprLink(exprLink[0]);
    cerr << portItem->getExprLink().get() << endl;
    cerr << exprLink[0].get() << endl;
    assert(portItem->getExprLink() == exprLink[0]);
    
    //build a portItem without an explicit name
    RefCDOmPortItem portItem2 = moduleDecl->buildPortItem(10,CDOmPortItem::PORT_ITEM_SIMPLE);
    RefCDOmExpr expr =CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink exprLink1 = CDOmExprLink::build(10,RefString(new std::string("a")),expr);
    portItem2->addPortExprLink(exprLink1);
    assert(portItem2->getExprLink() == exprLink1);
    
    RefCDOmDesign design1 = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl1 = design1->buildModuleDecl(10,RefString(new std::string("name")));
    RefString string1 = RefString(new std::string("portConcat"));
    RefCDOmPortItem portItem1 = moduleDecl1->buildPortItem(10,CDOmPortItem::PORT_ITEM_CONCAT,string1);
    cout << "Hello again!" << endl;
    for(int i=1; i<nr; i++)
      portItem1->addPortExprLink(exprLink[i]);
    int index=1;
    RefTVec_RefCDOmExprLink linkVec = portItem1->getExprLinks();
    for(TVec_RefCDOmExprLink_const_iter iter = linkVec->begin(); iter!=linkVec->end(); ++iter)
      assert((*iter) == exprLink[index++]);
    
    cout << "All done in testPortItem" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testPortDecl(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    RefCDOmPortDecl portDecl = CDOmPortDecl::buildNetPortDecl(10,moduleDecl,PORT_INOUT,NET_SUPPLY0);
    assert(portDecl->getPortType() == PORT_INOUT);
    assert(portDecl->getNetType() == NET_SUPPLY0);
    
    RefCDOmDesign design1 = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl1 = design1->buildModuleDecl(10,RefString(new std::string("name1")));
    RefCDOmPortDecl portDecl1 = CDOmPortDecl::buildVarPortDecl(10,moduleDecl1,VAR_REG);
    assert(portDecl1->getVarType() == VAR_REG);
    portDecl1->setSigned();
    assert(portDecl1->isSigned());
    
    RefCDOmExpr firstExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange range = CDOmRange::build(10,firstExpr,secondExpr);
    portDecl1->setRange(range);
    assert(portDecl1->getRange() == range);

    const int nr=3;
    RefCDOmExpr expr[nr];
    RefString string[nr];
    string[0] = RefString(new std::string("name0"));
    string[1] = RefString(new std::string("name1"));
    string[2] = RefString(new std::string("name2"));
    for(int i=0; i<nr; i++){
      expr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      portDecl1->addPort(10,string[i],expr[i]);
      assert(portDecl1->containsPort(string[i]));
      assert(portDecl1->getPortVal(string[i]) == expr[i]);
    }
    int index=0;
    int index0=0;
    RefTVec_RefCDOmIdentifier identVec = portDecl1->getIDs();
    for(TVec_RefCDOmIdentifier_const_iter iter = identVec->begin(); iter!=identVec->end(); ++iter){
      assert((*iter)->getName() == string[index++]);
      assert((*iter)->getPayload() == expr[index0++]);
    }
    cout << "All done in testPortDecl" << endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testParamDeclCollection(){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name")));
    moduleDecl->buildParamDeclCollection(10);
    RefCDOmParamDeclCollection paramDeclCollection = moduleDecl->getParamDeclCollection();
    const int nr=3;
    RefCDOmParamDecl paramDecl[nr];
    for(int i=0; i<nr; i++)
      paramDecl[i] = CDOmParamDecl::build(10,paramDeclCollection,CDOmParamDecl::PARAM_DECL_SIMPLE);
    cout << "Hi\n";
    int index=0;
    RefTVec_RefCDOmParamDecl paramVec = paramDeclCollection->getParamDecls();
    for(TVec_RefCDOmParamDecl_const_iter iter = paramVec->begin(); iter!=paramVec->end(); ++iter)
      assert((*iter) == paramDecl[index++]);

    cout << "All done in testParamDeclCollection" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testParamDecl(RefCDOmExprLink inputTerminalExprLink[],RefCDOmExprLink outputTerminalExprLink[]){
  try{
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name"))) ;
    RefCDOmParamDecl paramDecl = CDOmParamDecl::build(10,moduleDecl,CDOmParamDecl::PARAM_DECL_SPEC);
    assert(paramDecl->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SPEC);
    RefCDOmExpr firstExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange range = CDOmRange::build(10,firstExpr,secondExpr);
    paramDecl->setRange(range);
    assert(paramDecl->getRange() == range);
 
    RefCDOmDesign design1 = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl1 = design1->buildModuleDecl(10,RefString(new std::string("name"))) ;
    RefCDOmParamDecl paramDecl1 = CDOmParamDecl::build(10,moduleDecl1,CDOmParamDecl::PARAM_DECL_SIMPLE,CDOmParamDecl::PARAM_INTEGER);
    assert(paramDecl1->getParamType() == CDOmParamDecl::PARAM_INTEGER);
    
    RefCDOmDesign design0 = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl0 = design0->buildModuleDecl(10,RefString(new std::string("name"))) ;
    RefCDOmParamDecl paramDecl0 = CDOmParamDecl::build(10,moduleDecl0,CDOmParamDecl::PARAM_DECL_SIMPLE);
    paramDecl0->setSigned();
    assert(paramDecl0->isSigned());
    
    const int nr=3;
    RefString string[nr];
    string[0] = RefString(new std::string("param0"));
    string[1] = RefString(new std::string("param1"));
    string[2] = RefString(new std::string("param2"));

    RefCDOmMinTypMax minTypMax[nr];
    RefCDOmExpr expr[nr];
    expr[0] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("value0")),RefString(new std::string("value0")),true,10);
    expr[1] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("value1")),RefString(new std::string("value1")),true,10);
    expr[2] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("value2")),RefString(new std::string("value2")),true,10);
    for(int i=0; i<nr; i++){
      minTypMax[i] = CDOmMinTypMax::build(10,expr[i]);
      paramDecl->addParam(10,string[i],minTypMax[i]);
      assert(paramDecl->containsParam(string[i]));
      assert(paramDecl->getParamVal(string[i]) == minTypMax[i]);
    }
    int index=0;
    int index0=0;
    RefTVec_RefCDOmIdentifier identVec = paramDecl->getIDs();
    for(TVec_RefCDOmIdentifier_const_iter iter = identVec->begin(); iter!=identVec->end(); ++iter){
      assert((*iter)->getName() == string[index++] );
      assert((*iter)->getPayload() == minTypMax[index0++] );
    }

    RefCDOmPulseControl pulseControl[nr];
    RefCDOmMinTypMax rejectLimitValue[nr];
    RefCDOmMinTypMax errorLimitValue[nr];
    RefCDOmExpr expr1[nr];
    RefCDOmExpr expr2[nr];
    for(int j=0; j<nr; j++){
      expr1[j] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("value0")),RefString(new std::string("value0")),true,10);
      expr2[j] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("value1")),RefString(new std::string("value1")),true,10);
      rejectLimitValue[j] = CDOmMinTypMax::build(10,expr1[j]);
      errorLimitValue[j] = CDOmMinTypMax::build(10,expr2[j]);
      paramDecl->addPulseControl(10,rejectLimitValue[j],errorLimitValue[j]);
    }
    int index1=0;
    int index2=0;
    RefTVec_RefCDOmPulseControl pulseVec = paramDecl->getPulseControls();
    for(TVec_RefCDOmPulseControl_const_iter iter = pulseVec->begin(); iter!=pulseVec->end(); ++iter){
      assert((*iter)->getRejectLimitValue() == rejectLimitValue[index1++] );
      assert((*iter)->getErrorLimitValue() == errorLimitValue[index2++]);
    }
    
    
    RefCDOmDesign design2 = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl2 = design2->buildModuleDecl(10,RefString(new std::string("name"))) ;
    RefCDOmParamDecl paramDecl2 = CDOmParamDecl::build(10,moduleDecl2,CDOmParamDecl::PARAM_DECL_SPEC);
    RefCDOmMinTypMax rejectLimitValue1[nr];
    RefCDOmMinTypMax errorLimitValue1[nr];
    RefCDOmExpr expr3[nr];
    RefCDOmExpr expr4[nr];
    for(int k=0; k<nr; k++){
      expr3[k] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("value0")),RefString(new std::string("value0")),true,10);
      expr4[k] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("value1")),RefString(new std::string("value1")),true,10);
      rejectLimitValue1[k] = CDOmMinTypMax::build(10,expr3[k]);
      errorLimitValue1[k] = CDOmMinTypMax::build(10,expr4[k]);
      paramDecl2->addPulseControl(10,inputTerminalExprLink[k],outputTerminalExprLink[k],rejectLimitValue1[k],errorLimitValue1[k]);
    }
    index1=0;
    index2=0;
    int index3=0;
    int index4=0;
    RefTVec_RefCDOmPulseControl pulseVect = paramDecl2->getPulseControls();
    for(TVec_RefCDOmPulseControl_const_iter iter1 = pulseVect->begin(); iter1!=pulseVect->end(); ++iter1){
      assert((*iter1)->getRejectLimitValue() == rejectLimitValue1[index1++] );
      assert((*iter1)->getErrorLimitValue() == errorLimitValue1[index2++]);
      assert((*iter1)->getInputTerminalExprLink() == inputTerminalExprLink[index3++] );
      assert((*iter1)->getOutputTerminalExprLink() == outputTerminalExprLink[index4++]);
      
    }
    
 



    cout << "All done in testParamDecl" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testRangeExpr(){
  try{
    RefCDOmExpr firstExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRangeExpr rangeExpr = CDOmRangeExpr::buildSingleRangeExpr(10,firstExpr);
    assert(rangeExpr->getRangeExprType() == CDOmRangeExpr::RANGE_EXPR_SINGLE);
    assert(rangeExpr->getFirstExpr() == firstExpr);

    RefCDOmExpr firstExpr1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRangeExpr rangeExpr1 = CDOmRangeExpr::buildDoubleRangeExpr(10,firstExpr1,secondExpr,CDOmRangeExpr::RANGE_EXPR_DOUBLE);
    assert(rangeExpr1->getRangeExprType() == CDOmRangeExpr::RANGE_EXPR_DOUBLE);
    assert(rangeExpr1->getFirstExpr() == firstExpr1);
    assert(rangeExpr1->getSecondExpr() == secondExpr);
    
    cout << "All done in testRangeExpr" << endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testRangeList(){
  try{
    const int nr=10;
    RefCDOmRangeList rangeList;
    RefCDOmExpr firstExpr[nr];
    RefCDOmExpr secondExpr[nr];
    RefCDOmRange range[nr];
    for(int i=0; i<nr; i++){
      firstExpr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      secondExpr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      range[i] = CDOmRange::build(10,firstExpr[i],secondExpr[i]);
      if(!rangeList.get()){
        rangeList = CDOmRangeList::build(10,range[i]);
      }
      else{
        rangeList->addItem(range[i]);
      }
    }
    int index=0;
    RefTVec_RefCDOmRange rangeVec = rangeList->getItems();
    for(TVec_RefCDOmRange_const_iter iter=rangeVec->begin(); iter!=rangeVec->end(); ++iter)
      assert((*iter) == range[index++]);

    cout << "All done in testRangeList" << endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testRange(){
  try{
    RefCDOmExpr firstExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange range = CDOmRange::build(10,firstExpr,secondExpr);
    assert(range->getFirstExpr() == firstExpr);
    assert(range->getSecondExpr() == secondExpr);

    cout << "All done in testRange" << endl;

  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmtWait(){
  try{
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmt stmt = CDOmStmt::buildNullStmt(10);
    RefCDOmStmtWait stmtWait = CDOmStmtWait::build(10,expr,stmt);
    assert(stmtWait->getExpr() == expr);
    assert(stmtWait->getStmt() == stmt);

    cout << "All done in testStmtWait" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmtTaskEnable(RefCDOmExprLink hid){
  try{
    RefCDOmStmtTaskEnable stmtTaskEnable = CDOmStmtTaskEnable::build(10,CDOmStmtTaskEnable::TASK_ENABLE_TASK,hid);
    assert(stmtTaskEnable->getTaskEnableType() == CDOmStmtTaskEnable::TASK_ENABLE_TASK);
    assert(stmtTaskEnable->getHID() == hid);
    const int nr = 3;
    RefCDOmExpr vexpr[nr];
    for(int i=0; i<nr; i++) {
      vexpr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      stmtTaskEnable->addExpr(vexpr[i]);
    }
    int index = 0;
    RefTVec_RefCDOmExpr vec = stmtTaskEnable->getExprList();
    assert(vec.get());
    for(TVec_RefCDOmExpr_const_iter iter = vec->begin(); iter!=vec->end(); ++iter)
      assert((*iter) == vexpr[index++]);

    cout << "All done in testStmtTaskEnable" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmtProcTimingControl(RefCDOmExprLink hid){
  try{
    RefCDOmNumber number = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmDelayControl delayControl = CDOmDelayControl::build(10,number);
    RefCDOmStmt stmt = CDOmStmt::buildNullStmt(10);
    RefCDOmStmtProcTimingControl stmtProcTimingControl = CDOmStmtProcTimingControl::buildWithDelayControl(10,delayControl,stmt);
    assert(stmtProcTimingControl->getProcTimingControlType() == CDOmStmtProcTimingControl::PROC_TIMING_CONTROL_DELAY);
    assert(stmtProcTimingControl->getDelayControl() == delayControl);
    
    RefCDOmEventControl eventControl = CDOmEventControl::build(10,hid);
    RefCDOmStmt stmt1 = CDOmStmt::buildNullStmt(10);
    RefCDOmStmtProcTimingControl stmtProcTimingControl1 = CDOmStmtProcTimingControl::buildWithEventControl(10,eventControl,stmt1);
    assert(stmtProcTimingControl1->getProcTimingControlType() == CDOmStmtProcTimingControl::PROC_TIMING_CONTROL_EVENT);
    assert(stmtProcTimingControl1->getEventControl() == eventControl);

    cout << "All done in testStmtProcTimingControl" << endl;
    
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }
}

void testStmtProcContAssn(){
  try{
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    
    RefCDOmExpr num = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString str = RefString(new std::string("a"));
    RefCDOmExprLink lvalue = CDOmExprLink::build(10,str,num);
    
    RefCDOmAssn assn = CDOmAssn::build(10,lvalue,expr);
    
    RefCDOmStmtProcContAssn stmtProcContAssn = CDOmStmtProcContAssn::build(10,CDOmStmtProcContAssn::PROC_CONT_ASSN_ASSIGN,assn);
    assert(stmtProcContAssn->getProcContAssnType() == CDOmStmtProcContAssn::PROC_CONT_ASSN_ASSIGN);
    assert(stmtProcContAssn->getAssn() == assn);
    
    
    RefCDOmExpr num1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString str1 = RefString(new std::string("a"));
    RefCDOmExpr lvalue1 = CDOmExprLink::build(10,str1,num1);
    assert(lvalue1->getExprType() == CDOmExpr::EXPR_HID);

    RefCDOmStmtProcContAssn stmtProcContAssn1 = CDOmStmtProcContAssn::build(10,CDOmStmtProcContAssn::PROC_CONT_ASSN_DEASSIGN,lvalue1);
    assert(stmtProcContAssn1->getProcContAssnType() == CDOmStmtProcContAssn::PROC_CONT_ASSN_DEASSIGN);
    assert(stmtProcContAssn1->getLvalue() == lvalue1);

    cout << "All done in testStmtProcContType" << endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmtBlock(){
  try{
    const int nr=10;
    RefCDOmStmtWait stmtWait[nr];
    RefCDOmStmt stmt[nr];
    RefCDOmExpr expr[nr];
    RefString string = RefString(new std::string("a"));
    RefCDOmStmtBlock stmtBlock = CDOmStmtBlock::build(10,CDOmStmtBlock::BLOCK_SEQUENTIAL,string);
    for(int i=0; i<nr; i++){
      expr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      stmt[i] = CDOmStmt::buildNullStmt(10);
      stmtWait[i] = CDOmStmtWait::build(10,expr[i],stmt[i]);
      stmtBlock->addStmt(stmtWait[i]);
    }
    int index=0;
    RefTVec_RefCDOmStmt stmtVec = stmtBlock->getStmts();
    for(TVec_RefCDOmStmt_const_iter iter = stmtVec->begin(); iter != stmtVec->end(); ++iter) {
      assert((*iter) == stmtWait[index++]);
    }
    assert(stmtBlock->getBlockType() == CDOmStmtBlock::BLOCK_SEQUENTIAL);
    assert(stmtBlock->isNamed());
    cout << "All done in testStmtBlock" << endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmtLoop(){
  try{
    RefCDOmStmt stmt = CDOmStmt::buildNullStmt(10);
    RefCDOmExpr exprs = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmtWait stmtWait = CDOmStmtWait::build(10,exprs,stmt);
    RefCDOmStmtLoop stmtLoop = CDOmStmtLoop::buildForeverStmt(10,stmtWait);
    assert(stmtLoop->getLoopType() == CDOmStmtLoop::LOOP_FOREVER);
    assert(stmtLoop->getStmt() == stmtWait);

    RefCDOmExpr expr1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmt stmt1 = CDOmStmt::buildNullStmt(10);
    RefCDOmExpr exprs1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmtWait stmtWait1 = CDOmStmtWait::build(10,exprs1,stmt1);
    RefCDOmStmtLoop stmtLoop1 = CDOmStmtLoop::buildRepeatStmt(10,expr1,stmtWait1);
    assert(stmtLoop1->getLoopType() == CDOmStmtLoop::LOOP_REPEAT);
    assert(stmtLoop1->getStmt() == stmtWait1);
    assert(stmtLoop1->getExpr() == expr1);
    
    RefCDOmExpr expr2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmt stmt2 = CDOmStmt::buildNullStmt(10);
    RefCDOmExpr exprs2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmtWait stmtWait2 = CDOmStmtWait::build(10,exprs2,stmt2);
    RefCDOmStmtLoop stmtLoop2 = CDOmStmtLoop::buildWhileStmt(10,expr2,stmtWait2);
    assert(stmtLoop2->getLoopType() == CDOmStmtLoop::LOOP_WHILE);
    assert(stmtLoop2->getStmt() == stmtWait2);
    assert(stmtLoop2->getExpr() == expr2);

    RefCDOmExpr expr3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);

    RefCDOmExpr num = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString str = RefString(new std::string("a"));
    RefCDOmExprLink lvalue = CDOmExprLink::build(10,str,num);

    RefCDOmAssn initAssn = CDOmAssn::build(10,lvalue,expr3);
    RefCDOmExpr expr4 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    
    RefCDOmExpr num1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString str1 = RefString(new std::string("a"));
    RefCDOmExprLink lvalue1 = CDOmExprLink::build(10,str1,num1);

    RefCDOmAssn incAssn = CDOmAssn::build(10,lvalue1,expr4);
    RefCDOmExpr condExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmt stmt3 = CDOmStmt::buildNullStmt(10);
    RefCDOmExpr exprs3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmtWait stmtWait3 = CDOmStmtWait::build(10,exprs3,stmt3);
    RefCDOmStmtLoop stmtLoop3 = CDOmStmtLoop::buildForStmt(10,initAssn,condExpr,incAssn,stmtWait3);
    assert(stmtLoop3->getLoopType() == CDOmStmtLoop::LOOP_FOR);
    assert(stmtLoop3->getStmt() == stmtWait3);
    assert(stmtLoop3->getExpr() == condExpr);
    assert(stmtLoop3->getInitForAssn() == initAssn);
    assert(stmtLoop3->getIncForAssn() == incAssn);

    cout << "All done in testStmtLoop" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmtEventTrigger(RefCDOmExprLink hid,RefCDOmListExpr exprList){
  try{
    RefCDOmStmtEventTrigger stmtEventTrigger = CDOmStmtEventTrigger::build(10,hid,exprList);
    assert(stmtEventTrigger->getHID() == hid);
    assert(stmtEventTrigger->getExprList() == exprList);

    cout << "All done in testStmtEventTrigger" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmtDisable(RefCDOmExprLink hid){
  try{
    RefCDOmStmtDisable stmtDisable = CDOmStmtDisable::build(10,hid);
    assert(stmtDisable->getHID() == hid);

    cout << "All done in testStmtDisable" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmtIf(){
  try{
    RefCDOmExpr ifCondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmt ifStmt = CDOmStmt::buildNullStmt(10);
    RefCDOmStmt elseStmt = CDOmStmt::buildNullStmt(10);
    RefCDOmStmtIf stmtIf = CDOmStmtIf::build(10,ifCondExpr,ifStmt,elseStmt);
    assert(stmtIf->getIfCondExpr() == ifCondExpr);
    assert(stmtIf->getIfStmt() == ifStmt);
    assert(stmtIf->getElseStmt() == elseStmt);

    cout << "All done in testStmtIf" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmtCase(RefCDOmListExpr exprList[]){
  try{
    const int nr=3;
    RefCDOmExpr expr[nr];
    RefCDOmStmt stmt[nr];
    RefCDOmStmtCase stmtCase;
    for(int i=0; i<nr; i++){
      expr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      stmt[i] = CDOmStmt::buildNullStmt(10);
      if(!stmtCase.get()){
        stmtCase = CDOmStmtCase::build(10,CDOmStmtCase::CASE_CASE,expr[i],exprList[i],stmt[i]);
        assert(!stmtCase->hasDefault());
      }
      else{
        stmtCase->addCaseItem(exprList[i],stmt[i]);
      }
    }
    RefCDOmListExpr exprList1(0);
    RefCDOmExpr expr1 = CDOmNumber:: build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmt stmt1 = CDOmStmt::buildNullStmt(10);
    RefCDOmStmtCase stmtCase1 = CDOmStmtCase::build(10,CDOmStmtCase::CASE_CASE,expr1,exprList1,stmt1);
    assert(stmtCase1->hasDefault());
    
    cout << "All done in testStmtCase" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmtAssn(RefCDOmExprLink hid1,RefCDOmExprLink hid2,RefCDOmExprLink hid3,RefCDOmDelayControl delayControl,RefCDOmEventControl eventControl){
  try{
    RefCDOmExpr num = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString str = RefString(new std::string("a"));
    RefCDOmExprLink lvalue1 = CDOmExprLink::build(10,str,num);

    RefCDOmExpr number1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmtAssn stmtAssn1 = CDOmStmtAssn::buildSimple(10,CDOmStmtAssn::ASSN_BLOCKING,lvalue1,number1);
    assert(stmtAssn1->getAssnType() == CDOmStmtAssn::ASSN_BLOCKING);
    assert(stmtAssn1->getControlType() == CDOmStmtAssn::CONTROL_NONE);
    assert(stmtAssn1->getLvalue() == lvalue1);
    assert(stmtAssn1->getExpr() == number1);
    
    RefCDOmExpr num2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString str2 = RefString(new std::string("a"));
    RefCDOmExprLink lvalue2 = CDOmExprLink::build(10,str2,num2);

    RefCDOmExpr number2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmtAssn stmtAssn2 = CDOmStmtAssn::buildWithDelayControl(10,CDOmStmtAssn::ASSN_BLOCKING,lvalue2,number2,delayControl);
    assert(stmtAssn2->getAssnType() == CDOmStmtAssn::ASSN_BLOCKING);
    assert(stmtAssn2->getControlType() == CDOmStmtAssn::CONTROL_DELAY_CONTROL);
    assert(stmtAssn2->getLvalue() == lvalue2);
    assert(stmtAssn2->getExpr() == number2);
    assert(stmtAssn2->getDelayControl() == delayControl);
    
    RefCDOmExpr num3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefString str3 = RefString(new std::string("a"));
    RefCDOmExprLink lvalue3 = CDOmExprLink::build(10,str3,num3);

    RefCDOmExpr number3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr repeatExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmStmtAssn stmtAssn3 = CDOmStmtAssn::buildWithEventControl(10,CDOmStmtAssn::ASSN_BLOCKING,lvalue3,number3,eventControl,repeatExpr);
    assert(stmtAssn3->getAssnType() == CDOmStmtAssn::ASSN_BLOCKING);
    assert(stmtAssn3->getControlType() == CDOmStmtAssn::CONTROL_REPEAT_EVENT_CONTROL);
    assert(stmtAssn3->getLvalue() == lvalue3);
    assert(stmtAssn3->getExpr() == number3);
    assert(stmtAssn3->getEventControl() == eventControl);
    assert(stmtAssn3->getRepeatExpr() == repeatExpr);


    cout << "All done in testStmtAssn" << endl;

    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testStmt(){
  try{
    RefCDOmStmt stmt = CDOmStmt::buildNullStmt(10);
    assert(stmt->getStmtType() == CDOmStmt::STMT_NULL);
    cout << "All done in testStmt" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
RefCDOmEventControl testEventControl(RefCDOmExprLink hid,RefCDOmEventExpr eventExpr){
  try{
      RefCDOmEventControl eventControl1 = CDOmEventControl::build(10,hid);
      assert(eventControl1->getHID() == hid);
      assert(eventControl1->getEventControlType() == CDOmEventControl::EVENT_CONTROL_HID);

      RefCDOmEventControl eventControl2 = CDOmEventControl::build(10,eventExpr);
      assert(eventControl2->getEventExpr() == eventExpr);
      assert(eventControl2->getEventControlType() == CDOmEventControl::EVENT_CONTROL_EVENT_EXPR);

      RefCDOmEventControl eventControl3 = CDOmEventControl::build(10,false);
      assert(eventControl3->getEventControlType() == CDOmEventControl::EVENT_CONTROL_STAR);
      RefCDOmEventControl eventControl4 = CDOmEventControl::build(10,true);
      assert(eventControl4->getEventControlType() == CDOmEventControl::EVENT_CONTROL_STAR_WITH_PARENTHESIS);
      

      cout << "All done in testEventControl" << endl;
      return eventControl2;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
RefCDOmEventExpr testEventExpr(){
  try{
    RefCDOmExpr number = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmEventExpr eventExpr1 = CDOmEventExpr::build(10,CDOmEventExpr::EVENT_EXPR_EXPR,number);
    assert(eventExpr1->getExpr() == number);

    RefCDOmExpr number1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmEventExpr eventExpr2 = CDOmEventExpr::build(10,CDOmEventExpr::EVENT_EXPR_EXPR,number1);
    RefCDOmEventExpr eventExpr3 = CDOmEventExpr::build(10,CDOmEventExpr::EVENT_EXPR_OR,eventExpr1,eventExpr2);
    assert(eventExpr3->getEventExpr1() == eventExpr1);
    assert(eventExpr3->getEventExpr2() == eventExpr2);

    
    cout << "All done in testEventExpr" << endl;
    return eventExpr3;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
RefCDOmExprLink testExprLink(){
  try{
    const int nr=10;
    RefCDOmExprLink exprLink;
    RefCDOmExpr number[nr];
    RefString string[nr];
    for(int i=0; i<nr; i++){
      string[i] = RefString(new std::string("a"));
      number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      
      if(!exprLink.get()){
         exprLink = CDOmExprLink::build(10,string[0],number[0]);
         assert(exprLink->getName() == string[0]);
      }
      else{
        exprLink->addHidItem(string[i],number[i]);
      }
    }
    
    RefCDOmListExpr arrayIndexes(0);
    RefCDOmExpr number1[nr];
    for(int i = 0; i < nr; ++i) {
      number1[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      if(!arrayIndexes.get()) {
        arrayIndexes = CDOmListExpr::build(10,number1[i]);//that happens only for i=0
      }
      else {
        arrayIndexes->addItem(number1[i]);
      }
    }

    exprLink->setArrayIndexes(arrayIndexes);
    assert(exprLink->getArrayIndexes() == arrayIndexes);

    RefCDOmExpr number0 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRangeExpr rangeExpr = CDOmRangeExpr::buildSingleRangeExpr(10,number0);
    exprLink->setRangeExpr(rangeExpr);
    assert(exprLink->getRangeExpr() == rangeExpr);
    
    int index=0;
    RefTVec_RefString stringVec = exprLink->getHidNames();
    for(TVec_RefString_const_iter iter = stringVec->begin(); iter != stringVec->end(); ++iter) {
      assert((*iter) == string[index++]);
    }
    index=0;
    RefTVec_RefCDOmExpr exprVec = exprLink->getHidExprs();
    for(TVec_RefCDOmExpr_const_iter iter1 = exprVec->begin(); iter1 != exprVec->end(); ++iter1) {
      assert((*iter1) == number[index++]);
    }

    
    cout << "All done in testExprLink " << endl;
    return exprLink;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
RefCDOmDelayControl testDelayControl(){
  try{
    RefCDOmNumber number = CDOmNumber:: build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmDelayControl delayControl1 = CDOmDelayControl::build(10,number);
    assert(delayControl1->getNumber() == number);
    
    RefCDOmReal realNum = CDOmReal::build(10,RefString(new std::string("a")),RefString(new std::string("a")));
    RefCDOmDelayControl delayControl2 = CDOmDelayControl:: build(10,realNum);
    assert(delayControl2->getRealNumber() == realNum);
    
    RefCDOmExpr expr =  CDOmNumber:: build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprLink exprLink= CDOmExprLink::build(10,RefString(new std::string("a")),expr);
    RefCDOmDelayControl delayControl3 = CDOmDelayControl:: build(10,exprLink);
    assert(delayControl3->getExprLink() == exprLink);

    RefCDOmExpr expr1 =  CDOmNumber:: build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmMinTypMax minTypMax = CDOmMinTypMax::build(10,expr1);
    RefCDOmDelayControl delayControl4 = CDOmDelayControl:: build(10,minTypMax);
    assert(delayControl4->getMinTypMax() == minTypMax);
    
    cout << "All done in testDelayControl" << endl;
    return delayControl1;
  }catch(const NSBase::Exception& e){
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testExprMultiConcat(RefCDOmExprConcat exprConcat){
  try{
    RefCDOmExpr number = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprMultiConcat exprMultiConcat = CDOmExprMultiConcat::build(10,number,exprConcat);
    assert(exprMultiConcat->getExpr() == number);
    assert(exprMultiConcat->getExprConcat() == exprConcat);
    
    cout << "All done in testExprMultiConcat" << endl;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
RefCDOmExprConcat testExprConcat(){
  try{
    RefCDOmExprConcat exprConcat(0);

    const int nrExprs=10;
    RefCDOmExpr number[nrExprs];

    for(int i=0; i < nrExprs; i++){
      number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      if(!exprConcat.get()){
        exprConcat = CDOmExprConcat::build(10,number[i]);
      }
      else{
        exprConcat->addExpr(number[i]);
      }
    }
    int index = 0;
    RefTVec_RefCDOmExpr exprVec = exprConcat->getExprs();
    for(TVec_RefCDOmExpr_const_iter iter = exprVec->begin(); iter != exprVec->end(); ++iter) {
      assert((*iter) == number[index++]);
    }
    
    cout << "All done in testExprConcat" << endl;
      
    return exprConcat;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
*/
RefCDOmListExpr testExprList(){
  try {
    RefCDOmListExpr exprList;
    
    const int nrExprs = 10;
    RefCDOmExpr number[nrExprs];
  
    for(int i = 0; i < nrExprs; ++i) {
      number[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")));
      if(!exprList.get()) {
        exprList = CDOmListExpr::build(10,number[i]);//that happens only for i=0
      }
      else {
        //cerr << " addind item to list ... " << endl;
        exprList->addItem(number[i]);
        //cerr << " added item to list ... " << endl;
      }
    }
    int index = 0;
    RefTVec_RefCDOmExpr exprVec = exprList->getItems();
    //cout << "Why?" << endl;
    //cout <<exprVec.get() << endl;
    for(TVec_RefCDOmExpr_const_iter iter = exprVec->begin(); iter != exprVec->end(); ++iter) {
      //cout << "Why?" << endl;
      assert((*iter) == number[index++]);
    }

    cout << "All done in testExprList" << endl;
    return exprList;
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}

/*
void testAttrList(){
  try{
    RefCDOmAttrListCollection attrListCollection = CDOmAttrListCollection::build(10);
    RefCDOmAttrList attrList = attrListCollection->buildAttrList(10);
    const int nr=3;
    RefString string[nr];
    string[0] = RefString(new std::string("name0"));
    string[1] = RefString(new std::string("name1"));
    string[2] = RefString(new std::string("name2"));
    RefCDOmExpr expr[nr];
    for(int i=0; i<nr; i++){
      expr[i] = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
      attrList->addAttr(10,string[i],expr[i]);
      assert(attrList->containsAttr(string[i]));
      assert(attrList->getAttrVal(string[i]) == expr[i]);
    }
    int index=0,index1=0;
    RefTVec_RefCDOmIdentifier identVec = attrList->getIDs();
    for(TVec_RefCDOmIdentifier_const_iter iter = identVec->begin(); iter!=identVec->end(); ++iter){
      assert((*iter)->getName() == string[index++]);
      assert((*iter)->getPayload() == expr[index1++]);
    }
    
    cout << "All done in testAttrList" << endl;
    
  }catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

}
void testAttrListCollection(RefCDOmExprOp exprOp1,RefCDOmExprOp exprOp2,RefCDOmExprOp exprOp3,RefCDOmExprOp exprOp4,RefCDOmExprOp exprOp5,RefCDOmExprOp exprOp6,RefCDOmExprOp exprOp){
  try{
    // (* attr1, attr2 = 1, attr3 = 0, attr2 = 2 *)
    // (* attr_x, attr_y *)
    RefCDOmAttrListCollection attrListCollection1 = CDOmAttrListCollection::build(10);
    RefCDOmAttrList attrList1 = attrListCollection1->buildAttrList(10);
    attrList1->addAttr(10,RefString(new std::string("attr1")));
    attrList1->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("1")));
    attrList1->addAttr(10,RefString(new std::string("attr3")), quickBuild(new std::string("0")));
    attrList1->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("2")));
	       
    attrList1 = attrListCollection1->buildAttrList(10);
    attrList1->addAttr(10,RefString(new std::string("attr_x")));
    attrList1->addAttr(10,RefString(new std::string("attr_y")));
    
    exprOp1->setAttrListCollection(attrListCollection1);
    assert(exprOp1->getAttrListCollection() == attrListCollection1);
    
    // (* attr1, attr2 = 1, attr3 = 0, attr2 = 2 *)
    // (* attr_x, attr_y *)
    RefCDOmAttrListCollection attrListCollection2 = CDOmAttrListCollection::build(10);
    RefCDOmAttrList attrList2 = attrListCollection2->buildAttrList(10);
    attrList2->addAttr(10,RefString(new std::string("attr1")));
    attrList2->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("1")));
    attrList2->addAttr(10,RefString(new std::string("attr3")), quickBuild(new std::string("0")));
    attrList2->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("2")));
	       
    attrList2 = attrListCollection2->buildAttrList(10);
    attrList2->addAttr(10,RefString(new std::string("attr_x")));
    attrList2->addAttr(10,RefString(new std::string("attr_y")));
	
    exprOp2->setAttrListCollection(attrListCollection2);
    assert(exprOp2->getAttrListCollection() == attrListCollection2);
    
    // (* attr1, attr2 = 1, attr3 = 0, attr2 = 2 *)
    // (* attr_x, attr_y *)
    RefCDOmAttrListCollection attrListCollection3 = CDOmAttrListCollection::build(10);
    RefCDOmAttrList attrList3 = attrListCollection3->buildAttrList(10);
    attrList3->addAttr(10,RefString(new std::string("attr1")));
    attrList3->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("1")));
    attrList3->addAttr(10,RefString(new std::string("attr3")), quickBuild(new std::string("0")));
    attrList3->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("2")));
	       
    attrList3 = attrListCollection3->buildAttrList(10);
    attrList3->addAttr(10,RefString(new std::string("attr_x")));
    attrList3->addAttr(10,RefString(new std::string("attr_y")));
    
    exprOp3->setAttrListCollection(attrListCollection3);
    assert(exprOp3->getAttrListCollection() == attrListCollection3);
    
    // (* attr1, attr2 = 1, attr3 = 0, attr2 = 2 *)
    // (* attr_x, attr_y *)
    RefCDOmAttrListCollection attrListCollection4 = CDOmAttrListCollection::build(10);
    RefCDOmAttrList attrList4 = attrListCollection4->buildAttrList(10);
    attrList4->addAttr(10,RefString(new std::string("attr1")));
    attrList4->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("1")));
    attrList4->addAttr(10,RefString(new std::string("attr3")), quickBuild(new std::string("0")));
    attrList4->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("2")));
	       
    attrList4 = attrListCollection4->buildAttrList(10);
    attrList4->addAttr(10,RefString(new std::string("attr_x")));
    attrList4->addAttr(10,RefString(new std::string("attr_y")));

    exprOp4->setAttrListCollection(attrListCollection4);
    assert(exprOp4->getAttrListCollection() == attrListCollection4);

    // (* attr1, attr2 = 1, attr3 = 0, attr2 = 2 *)
    // (* attr_x, attr_y *)
    RefCDOmAttrListCollection attrListCollection5 = CDOmAttrListCollection::build(10);
    RefCDOmAttrList attrList5 = attrListCollection5->buildAttrList(10);
    attrList5->addAttr(10,RefString(new std::string("attr1")));
    attrList5->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("1")));
    attrList5->addAttr(10,RefString(new std::string("attr3")), quickBuild(new std::string("0")));
    attrList5->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("2")));
    attrList5 = attrListCollection5->buildAttrList(10);
    attrList5->addAttr(10,RefString(new std::string("attr_x")));
    attrList5->addAttr(10,RefString(new std::string("attr_y")));
    
    exprOp5->setAttrListCollection(attrListCollection5);
    assert(exprOp5->getAttrListCollection() == attrListCollection5);

    // (* attr1, attr2 = 1, attr3 = 0, attr2 = 2 *)
    // (* attr_x, attr_y *)
    RefCDOmAttrListCollection attrListCollection6 = CDOmAttrListCollection::build(10);
    RefCDOmAttrList attrList6 = attrListCollection6->buildAttrList(10);
    attrList6->addAttr(10,RefString(new std::string("attr1")));
    attrList6->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("1")));
    attrList6->addAttr(10,RefString(new std::string("attr3")), quickBuild(new std::string("0")));
    attrList6->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("2")));
	       
    attrList6 = attrListCollection6->buildAttrList(10);
    attrList6->addAttr(10,RefString(new std::string("attr_x")));
    attrList6->addAttr(10,RefString(new std::string("attr_y")));

    exprOp6->setAttrListCollection(attrListCollection6);
    assert(exprOp6->getAttrListCollection() == attrListCollection6);

    // (* attr1, attr2 = 1, attr3 = 0, attr2 = 2 *)
    // (* attr_x, attr_y *)
    RefCDOmAttrListCollection attrListCollection = CDOmAttrListCollection::build(10);
    RefCDOmAttrList attrList = attrListCollection->buildAttrList(10);
    attrList->addAttr(10,RefString(new std::string("attr1")));
    attrList->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("1")));
    attrList->addAttr(10,RefString(new std::string("attr3")), quickBuild(new std::string("0")));
    attrList->addAttr(10,RefString(new std::string("attr2")), quickBuild(new std::string("2")));
	       
    attrList = attrListCollection->buildAttrList(10);
    attrList->addAttr(10,RefString(new std::string("attr_x")));
    attrList->addAttr(10,RefString(new std::string("attr_y")));

    exprOp->setAttrListCollection(attrListCollection);
    assert(exprOp->getAttrListCollection() == attrListCollection);

    cout << "All done in testAttrListCollection" << endl;
  } catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }

 
}

void testExprOp(){
 
  //!a,^b,&c
  //a+b,b*c,d/e,
  //a ? b : c
 
  try {
    RefCDOmDesign design = CDOmDesign::build();

    //    CVerilogGenVisitor *cv = new CVerilogGenVisitor(cout); //(design);
    CVerilogGenVisitor *cv = new CVerilogGenVisitor("sample.v"); //(design);
   
    // !a,^b,&c 
    
    RefCDOmExpr number1 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExprOp exprOp1 = CDOmExprOp::build(10,CDOmExprOp::OP_UNARY_LOGIC_NOT,number1);
    assert(exprOp1->getExpr1() == number1);
    RefCDOmExpr number2 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("b")),RefString(new std::string("b")),true,10);
    RefCDOmExprOp exprOp2 = CDOmExprOp::build(10,CDOmExprOp::OP_UNARY_REDUCTION_XOR,number2) ;
    assert(exprOp2->getExpr1() == number2);
    RefCDOmExpr number3 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("c")),RefString(new std::string("c")),true,10);
    RefCDOmExprOp exprOp3 = CDOmExprOp::build(10,CDOmExprOp::OP_UNARY_REDUCTION_AND,number3);
    assert(exprOp3->getExpr1() == number3);
		  
    //a+b,b*c,d/e
    
    RefCDOmExpr number4 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr number5 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("b")),RefString(new std::string("b")),true,10);
    RefCDOmExprOp exprOp4 = CDOmExprOp::build(10,CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS,number4,number5);
    RefCDOmExpr number6 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("b")),RefString(new std::string("b")),true,10);
    RefCDOmExpr number7 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("c")),RefString(new std::string("c")),true,10);
    RefCDOmExprOp exprOp5 = CDOmExprOp::build(10,CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY,number6,number7);
    RefCDOmExpr number8 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("d")),RefString(new std::string("d")),true,10);
    RefCDOmExpr number9 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("e")),RefString(new std::string("e")),true,10);
    RefCDOmExprOp exprOp6 = CDOmExprOp::build(10,CDOmExprOp::OP_BINARY_ARITHMETIC_DIV,number8,number9);
    assert(exprOp4->getExpr1() == number4);
    assert(exprOp4->getExpr2() == number5);
    assert(exprOp5->getExpr1() == number6);
    assert(exprOp5->getExpr2() == number7);
    assert(exprOp6->getExpr1() == number8);
    assert(exprOp6->getExpr2() == number9);
    
    //a ? b : c
    
    RefCDOmExpr number10 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr number11 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("b")),RefString(new std::string("b")),true,10);
    RefCDOmExpr number12 = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("c")),RefString(new std::string("c")),true,10);
    RefCDOmExprOp exprOp = CDOmExprOp::build(10,CDOmExprOp::OP_TERNARY_COND,number10,number11,number12);
    assert(exprOp->getExpr1() == number10);
    assert(exprOp->getExpr2() == number11);
    assert(exprOp->getExpr3() == number12);

    testAttrListCollection(exprOp1,exprOp2,exprOp3,exprOp4,exprOp5,exprOp6,exprOp);
    

    cout << "All done in testExprOp" << endl;
  } catch(const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }
}

void testCDOM_API() {
  try {
    const int nr = 10;
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("name"))); *2
    RefCDOmExpr firstExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmExpr secondExpr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),RefString(new std::string("a")),true,10);
    RefCDOmRange range = CDOmRange::build(10,firstExpr,secondExpr);
    RefCDOmPortDecl portDecl1 = CDOmPortDecl::buildVarPortDecl(10,moduleDecl,VAR_REG);
    RefCDOmPortDecl portDecl[nr];
    RefString vstring[nr];
    for(int i=0; i<nr; i++) {
      ostringstream out;
      out << "a" << i;
      vstring[i] = RefString(new std::string(out.str()));
      portDecl[i]= CDOmPortDecl::buildNetPortDecl(10,moduleDecl,PORT_INOUT,NET_SUPPLY0); *3
      portDecl[i]->addPort(10,vstring[i]);
      assert(portDecl[i]->getPortType() == PORT_INOUT);
      assert(portDecl[i]->getNetType() == NET_SUPPLY0);
    }

    CDOmModulePortIterator testPortIterator(moduleDecl);
    int index = 0;
    for(CDOmModulePortIterator iter(moduleDecl); !iter.isEnd(); iter.nextPort()) {
      assert(iter.getPortName() == vstring[index++]);
    }

    RefCDOmVarDecl varDecl = CDOmVarDecl::build(10,moduleDecl,VAR_REG);
    assert(varDecl->getVarType() == VAR_REG);
    varDecl->setSigned();
    assert(varDecl->isSigned());

    portDecl1->setRange(range);
    assert(portDecl1->getRange() == range);

  } catch (const NSBase::Exception& e) {
    cout << "Exception encountered: " << e.what() << endl;
  }
  cout << "All done in testing CDOM_API !" << endl;
}
*/
void testCast() {
  cerr<<"Starting testCast()"<<endl;
  try {
       RefCDOmDesign design = CDOmDesign::build();

       RefString moduleA (new std::string("moduleA"));
       RefString moduleB (new std::string("moduleB"));
       RefString portA_x (new std::string("x"));
       RefString portA_y (new std::string("y"));
       RefString portB_x (new std::string("x"));
       RefString portB_y (new std::string("y"));
       RefString exprLinkName (new std::string("exprLink"));
       RefString numberTokenString (new std::string("num1"));
       RefString numberLightString (new std::string("_num1"));
    
       RefCDOmModuleDecl module1 = design->buildModuleDecl(rand(), moduleA);
       RefCDOmModuleDecl module2 = design->buildModuleDecl(rand(), moduleB);
       RefCDOmModuleDecl moduleTemp;
       
       cerr<<"casting CDOmExprLink..."<<endl;
       RefCDOmExprLink exprLink = CDOmExprLink::build(rand(), exprLinkName);
       RefCDOmBase exprLinkAsBase = exprLink;
       RefCDOmExprLink tempExprLink = CDOmExprLink::cast(exprLinkAsBase);
       ASSERT(tempExprLink == exprLink, "casting exprLink returned different object");
       
       //adding ports
       RefCDOmPortItem A_x = module1->buildPortItem(rand(), CDOmPortItem::PORT_ITEM_SIMPLE, portA_x);
       RefCDOmPortItem A_y = module1->buildPortItem(rand(), CDOmPortItem::PORT_ITEM_SIMPLE, portA_y);
       RefCDOmPortItem B_x = module2->buildPortItem(rand(), CDOmPortItem::PORT_ITEM_SIMPLE, portB_x);
       RefCDOmPortItem B_y = module2->buildPortItem(rand(), CDOmPortItem::PORT_ITEM_SIMPLE, portB_y);
       RefCDOmPortItem portTemp;

       cerr<<"casting CDOmModuleDecl..."<<endl;
       RefCDOmBase moduleAsBase = module1;
       moduleTemp = CDOmModuleDecl::cast(moduleAsBase);
       ASSERT(module1 == moduleTemp, "casting module1 returned different object");
       moduleAsBase = module2;
       moduleTemp = CDOmModuleDecl::cast(moduleAsBase);
       ASSERT(module2 == moduleTemp, "casting module2 returned different object");

       cerr<<"casting CDOmPortItem..."<<endl;
       RefCDOmBase portAsBase = A_x;
       portTemp = CDOmPortItem::cast(portAsBase);
       ASSERT(A_x == portTemp, "casting port A_x returned different object");
       portAsBase = B_y;
       portTemp = CDOmPortItem::cast(portAsBase);
       ASSERT(B_y == portTemp, "casting port B_y returned different object");
      
       cerr<<"casting CDOmNumber..."<<endl;
       RefCDOmExpr number = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, numberTokenString);
       RefCDOmBase numberAsBase = number;
       RefCDOmNumber tempNumber = CDOmNumber::cast(numberAsBase);
       ASSERT(number == tempNumber, "casting number returned different object");

       cerr<<"casting CDOmExprOp..."<<endl;
       RefCDOmExprOp exprOp = CDOmExprOp::build(rand(), CDOmExprOp::OP_UNARY_LOGIC_NOT, number);
       RefCDOmBase exprOpAsBase = exprOp;
       RefCDOmExprOp tempExprOp = CDOmExprOp::cast(exprOpAsBase);
       ASSERT(tempExprOp == exprOp, "casting exprOp returned different object");

       cerr<<"casting CDOmDelayControl..."<<endl;
       RefCDOmNumber num = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, numberTokenString);
       RefCDOmDelayControl delayControl = CDOmDelayControl::build(rand(), num);
       RefCDOmBase baseDelayControl = delayControl;
       RefCDOmDelayControl tempDelayControl = CDOmDelayControl::cast(baseDelayControl);
       ASSERT(tempDelayControl == delayControl, "casting delayControl returned different object");

       cerr << "casting CDOmSpecifyTerminalList..." << endl;
       RefCDOmExpr  first = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, RefString(new std::string("first"))); 
       RefCDOmExpr second = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, RefString(new std::string("second"))); 
       RefCDOmRange  range = CDOmRange::build(rand(), first, second);
       RefCDOmRangeList tempList, rangeList = CDOmRangeList::build(rand(), range);
       RefCDOmBase rangeListAsBase = rangeList;
       tempList = CDOmRangeList::cast(rangeList);
       ASSERT(tempList == rangeList, "cast returned different object");

       cerr << "casting CDOmListExpr..." << endl;
       RefCDOmExpr expr = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, RefString(new std::string("first")));
       RefCDOmListExpr tempExprList, exprList = CDOmListExpr::build(rand(), expr);
       RefCDOmBase nullBaseObject, exprListAsBase = exprList;
       tempExprList = CDOmListExpr::cast(exprListAsBase);
       ASSERT(tempExprList == exprList, "cast returned different object");
       tempExprList = CDOmListExpr::cast(nullBaseObject);


  } catch(const NSBase::Exception &e) {
     cerr<<"Exception "<<e.what()<<endl;
  }
  cerr<<"End of testCast()"<<endl<<endl;
}
/*

void testGetChild() {
  cerr<<"Starting testGetChild()"<<endl;
  try {
   RefCDOmDesign design = CDOmDesign::build();
   
   RefString moduleA(new std::string("moduleA"));
   RefString moduleB(new std::string("moduleB"));
   RefString portA_x(new std::string("A_x"));
   RefString portA_y(new std::string("A_y"));
   RefString portB_x(new std::string("B_x"));
   RefString portB_y(new std::string("B_y"));
   
   RefCDOmModuleDecl module1 = design->buildModuleDecl(rand(), moduleA);
   RefCDOmModuleDecl module2 = design->buildModuleDecl(rand(), moduleB);
   RefCDOmBase base = module1;
   
   RefCDOmPortItem A_x = module1->buildPortItem(rand(), CDOmPortItem::PORT_ITEM_SIMPLE, portA_x);
   RefCDOmPortItem A_y = module1->buildPortItem(rand(), CDOmPortItem::PORT_ITEM_SIMPLE, portA_y);
   RefCDOmPortItem B_x = module2->buildPortItem(rand(), CDOmPortItem::PORT_ITEM_SIMPLE, portB_x);
   RefCDOmPortItem B_y = module2->buildPortItem(rand(), CDOmPortItem::PORT_ITEM_SIMPLE, portB_y);

   RefCDOmExpr  first = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, RefString(new std::string("first"))); 
   RefCDOmExpr second = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, RefString(new std::string("second"))); 
   RefCDOmRange range = CDOmRange::build(rand(), first, second);

   RefCDOmNumber expr = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, RefString(new std::string("1024")), true);
   RefCDOmExprLink exprLink = CDOmExprLink::build(rand(), RefString(new std::string("exprlink")), expr);
   RefCDOmModuleOrUdpInstantiation moduleInst = CDOmModuleOrUdpInstantiation::build(rand(), module1, exprLink);
   RefCDOmModuleOrUdpInstance moduleInstance = moduleInst->buildModuleInstance(rand(), expr->getTokenString());
   
   RefCDOmExprLink exprLink1 = CDOmExprLink::build(rand(), moduleB);
   RefCDOmModuleOrUdpInstantiation moduleInst1 = CDOmModuleOrUdpInstantiation::build(rand(), module1, exprLink1);
   RefCDOmModuleOrUdpInstance  moduleInstance1 = moduleInst1->buildModuleInstance(rand(), moduleB); 
   
   cerr<<"testing CDOmModuleDecl, CDOmModuleOrUdpInstantiation, CDOmModuleOrUdpInstance..."<<endl;
   RefCDOmIdentifier tempId;
   tempId = CDOmIdentifier::cast(module2->getChild(0));
   ASSERT(tempId->getName() == module2->getModuleName(), "getChild(0) returned different object");
    
//   cerr << "trying module1->getChild(3)->getChild(1)->getChild(0)" << endl;
   //tempId = CDOmIdentifier::cast(module1->getChild(3)->getChild(1)->getChild(0));
   //cerr << "token string " << *expr->getTokenString() << endl;
   //cerr << "XZ " << expr->hasXZ() << endl;
   //cerr << "size " << expr->getSize() << endl;
   ASSERT(module1->getChild(3)->getChild(1) == moduleInstance, "expr != module1->getChild(3)->getChild(1)");
   //ASSERT(tempId->getName() == expr->getTokenString(), "module1->getChild(3)->getChild(1)->getChild(0) returned different object"); 
   //cerr << "tempId " << *tempId->getName() << endl;
   // cerr << "trying module1->getChild(4)->getChild(0)->getChild(0)" << endl;
   tempId = CDOmIdentifier::cast(module1->getChild(4)->getChild(1)->getChild(0)); 
   ASSERT(tempId->getName() == moduleB, "module1->getChild(4)->getChild(1)->getChild(0) returned different object" );
   //cerr << "tempId->getName()" << *tempId->getName() << endl;
   RefCDOmPortItem port  = CDOmPortItem::cast(module1->getChild(TYPE_PORT_ITEM, 0));
   ASSERT(port == A_x, "module1->getChild(TYPE_PORT_ITEM, 0) returned different object");
   
   cerr<<"testing CDOmPortItem..."<<endl;
   tempId = CDOmIdentifier::cast(module2->getChild(2)->getChild(0));
   ASSERT(tempId->getName() == B_y->getExplicitName(), "getChild(2)->getChild(0) returned different object");
  
   cerr<<"testing CDOmExprOp..."<<endl;
   RefString number1TokenString (new std::string("num1Tk"));
   RefString number1LightString (new std::string("num1Lh"));
   RefString number2TokenString (new std::string("num2Tk"));
   RefString number2LightString (new std::string("num2Lh"));
   RefString number3TokenString (new std::string("num3Tk"));
   RefString number3LightString (new std::string("num3Lh"));

   RefCDOmNumber auxNumber;
   RefCDOmNumber number1 = CDOmNum32::build(rand(), CDOmNumber::NUM_BASE_HEX, number1TokenString);
   number1->setHasXZ(true);
   RefCDOmExpr number2 = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_HEX, number2TokenString);
   RefCDOmExpr number3 = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_HEX, number3TokenString);

   RefCDOmExprOp exprOp1 = CDOmExprOp::build(rand(), CDOmExprOp::OP_UNARY_LOGIC_NOT, number1);
   RefCDOmExprOp exprOp2 = CDOmExprOp::build(rand(), CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS, number3, number2);
   auxNumber = CDOmNumber::cast(exprOp1->getChild(0));
   ASSERT(auxNumber == number1, "exprOp1->getChild(0) returned different object");
   auxNumber = CDOmNumber::cast(exprOp2->getChild(1));
   ASSERT(auxNumber == number2, "exprOp2->getChild(1) returned different object");
   auxNumber = CDOmNumber::cast(exprOp2->getChild(0));
   ASSERT(auxNumber == number3, "exprOp2->getChild(0) returned different object");
   cerr << "HasXZ " << number1->hasXZ() << endl; 
   
   cerr << "testing CDOmStmtCase..." << endl;
   const int nr=3;
   RefCDOmExpr exp;
   RefCDOmStmt stmt[nr];
   RefCDOmListExpr exprList[nr];
   RefCDOmStmtCase stmtCase;
   
   exp = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, RefString(new std::string("a")));
   for (int i=0; i<nr; i++) {
     stmt[i] = CDOmStmt::buildNullStmt(rand());
     exprList[i] = testExprList();
     if (!stmtCase.get()) {
       stmtCase = CDOmStmtCase::build(rand(), CDOmStmtCase::CASE_CASE, exp, exprList[i], stmt[i]);
       assert(!stmtCase->hasDefault());
     }
     else {
       stmtCase->addCaseItem(exprList[i], stmt[i]);
     }
   }
   RefCDOmExpr testExpr;
   testExpr = CDOmExpr::cast(stmtCase->getChild(0));
   ASSERT(testExpr == exp, "stmtCase->getChild(0) returned different object");
   for (int i=0; i<nr; ++i) {
     //cerr << i <<endl;
     ASSERT(stmtCase->getChild(2*i+1) == exprList[i], "stmtCase->getChild(i) returned different object");
     ASSERT(stmtCase->getChild(2*i+2) == stmt[i], "stmtCase->getChild(i) returned different object");
   }
   for (int i=0; i<nr; ++i) {
     RefCDOmStmt st = CDOmStmt::cast(stmtCase->getChild(TYPE_STMT, i));
     ASSERT(st == stmt[i], "stmtCase->getChild(TYPE_STMT, i) returned different object");

     //RefCDOmExpr ex = CDOmExpr::cast(stmtCase->getChild(TYPE_EXPR, i));
     //ASSERT(ex == exprList[i], "stmtCase->getChild(TYPE_EXPR, i) returned different object");
   }
   //RefCDOmExpr ex = CDOmExpr::cast(stmtCase->getChild(TYPE_EXPR, 1));
   //ASSERT(ex == exp, "ex != exp");

   cerr << "testing CDOmFuncDecl..." << endl;
   RefString funcName(new std::string("funcName"));
   RefCDOmFuncDecl funcDecl = CDOmFuncDecl::build(rand(), module1, CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST, funcName);
   funcDecl->setFuncStmt(stmtCase);
   tempId = CDOmIdentifier::cast(funcDecl->getChild(0));
   ASSERT(tempId->getName() == funcName, "funcDecl->getChild(0) returned different object");
   RefCDOmStmt tempStmt = CDOmStmt::cast(funcDecl->getChild(1));
   ASSERT(tempStmt == stmtCase, "funcDecl->getChild(1) returned different object");
   
  }catch(const NSBase::Exception &e) {
     cerr<<"Exception "<<e.what()<<endl;
  } 
  cerr<<"End of testGetChild()"<<endl<<endl;
}

*/
void testList() {
  try{
    cerr << endl << "Starting testList()..." << endl;

    const int nr = 3;

    cout << "testing CDOmListExpr..." << endl;
    RefCDOmListExpr listExpr;
    RefCDOmExpr number[nr];
    for(int i=0; i<nr; i++) {
      number[i] = CDOmNumber::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("a")), true);
      if(!listExpr.get())
        listExpr = CDOmListExpr::build(10, number[i]);
      else
        listExpr->addItem(number[i]);
    }
    RefTVec_RefCDOmExpr vect = RefTVec_RefCDOmExpr(listExpr->getItems());
    for (int i=0; i<nr; ++i) {
      ASSERT(number[i] == vect->at(i), "listExpr->getItems() returned different object");
      cerr << *CDOmNumber::cast(vect->at(i))->getTokenString() << " ";
    }

    cout << endl << "testing CDOmRangeList..." << endl;
    RefCDOmRangeList rangeList;
    RefCDOmRange range[nr];
    
    for(int i=0; i<nr; i++) {
      RefCDOmExpr  first = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, RefString(new std::string("first"))); 
      RefCDOmExpr second = CDOmNumber::build(rand(), CDOmNumber::NUM_BASE_DEC, RefString(new std::string("second"))); 
      range[i] = CDOmRange::build(rand(), first, second);

      if(!rangeList.get())
        rangeList = CDOmRangeList::build(10, range[i]);
      else
        rangeList->addItem(range[i]);
    }
    RefTVec_RefCDOmRange rangeVect = RefTVec_RefCDOmRange(rangeList->getItems());
    for (int i=0; i<nr; ++i) {
      ASSERT(range[i] == rangeVect->at(i), "rangeList->getItems() returned different object");
      //cerr << *CDOmRange::cast(vect->at(i))->getTokenString() << " ";
      cerr << *CDOmNumber::cast(rangeVect->at(i)->getFirstExpr())->getTokenString() << " " ;
      cerr << *CDOmNumber::cast(rangeVect->at(i)->getSecondExpr())->getTokenString() << " " << endl;
    }


  } catch(const NSBase::Exception &e) {
    cerr << "Exception " << e.what() << endl;
  }
  cerr << "End of testList()" << endl;
}

void testParam() {
  try {
    cerr << "Starting testParam()" << endl;
    RefCDOmDesign design = CDOmDesign::build();
    RefCDOmModuleDecl module1 = design->buildModuleDecl(rand(),RefString(new std::string("modulea")));
    //RefCDOmModuleDecl module1 = CDOmModuleDecl::build(rand(), design, RefString(new std::string("modulea")), CDOmModuleDecl::KEYWORD_MODULE);
    RefCDOmExpr expr = CDOmNumber::build(10,CDOmNumber::NUM_BASE_DEC,RefString(new std::string("a")),true);
    RefCDOmMinTypMax minTypMax = CDOmMinTypMax::build(10,expr);
    module1->buildParamDeclCollection(rand());
    RefCDOmParamDeclCollection parent1 = module1->getParamDeclCollection();
    RefCDOmParamDecl param1 = CDOmParamDecl::build(rand(), parent1, CDOmParamDecl::PARAM_DECL_SIMPLE);
    param1->addParam(rand(), RefString(new std::string("pam")), minTypMax);
    cerr << "param1 has " << param1->getChildrenSize() << endl;
    cerr << "param1 child is of type " << param1->getChild(0)->getType() << endl;
    
  } catch(const NSBase::Exception &e) {
    cerr << "Exception " << e.what() << endl;
  }
}

  //Tb removed//
// void testCDOmVeriNum() {
//   try {
//     RefCDOmDesign design = CDOmDesign::build();
//     RefCDOmVeriNum n1 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("3")), TRUE);
//     RefCDOmVeriNum n2 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new std::string("1")), TRUE);
//     cerr << "3^1 = " << *(CDOmVeriNum::cast(n1->power(n2))->getValueAsString());

//     RefCDOmVeriNum n3 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("3")), TRUE);
//     RefCDOmVeriNum n4 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new std::string("1")), FALSE, 2);
//     RefCDOmVeriNum n5 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new string("1")), TRUE, 3);
//     cerr << n4->getValue() << " " << n5->getValue() << endl;
//     cerr << n4->equality(n5)->getValue();

//     RefCDOmVeriNum n6 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new string("0")), TRUE);
//     RefCDOmVeriNum n7 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new string("0")), TRUE);
//     cerr << "0 > 0 : " << n6->relationalGreater(n7)->getValue() << endl;

//     RefCDOmVeriNum n8 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new string("111")), TRUE, 3);
//     RefCDOmVeriNum n9 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new string("001")), TRUE, 3);
//     cerr << "111 > 001 : " << n8->relationalGreater(n7)->getValue() << endl;
//     cerr << "111 = " << n8->getValue() << endl;

//     RefCDOmVeriNum n10 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new string("X7")), TRUE);
//     RefCDOmVeriNum n11 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new string("101")), TRUE, 3);
//     cerr << *(CDOmVeriNum::cast(n10->shiftLeft(n11))->getValueAsString()) << endl;

//     RefCDOmVeriNum n12 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new string("1")), TRUE, 1);
//     cerr << "-1 = " << n12->getValue() << endl;

//     RefCDOmVeriNum n13 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new string("3")), TRUE);
//     cerr << "3 < 0 : " << n13->relationalLess(n7)->getValue() << endl;

//     RefCDOmVeriNum n14 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new string("0")), TRUE);
//     RefCDOmVeriNum n16 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new string("16")), TRUE);
//     cerr << "0 < 16 : " << n14->relationalLess(n16)->getValue() << endl;
    
//     RefCDOmVeriNum n17 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new string("001")), TRUE, 3);
//     RefCDOmVeriNum n18 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new string("01")), TRUE, 2);
//     cerr << "001 > 01 : " << n17->relationalGreater(n18)->getValue() << endl;

//     RefCDOmVeriNum n19 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new string("363")), TRUE);
//     RefCDOmVeriNum n20 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new string("0100420")), TRUE);
//     cerr << *CDOmVeriNum::cast(n19->multiply(n20))->getValueAsString() << endl;
    
//     RefCDOmVeriNum n21 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new string("4")), FALSE, 2);
//     RefCDOmVeriNum n22 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new string("6")), FALSE, 2);
//     cerr << *(n21->getValueAsString()) << " >= " << *n22->getValueAsString() <<  " : " << *CDOmVeriNum::cast(n21->relationalGreaterEqual(n22))->getValueAsString() << endl;

//     RefCDOmVeriNum n23 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new string("54")), FALSE, 2);
//     RefCDOmVeriNum n24 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new string("111")), FALSE, 1);
//     cerr << n23->getValue() << "^" << n24->getValue() << " = " << n23->power(n24)->getValue() << endl;

//     //cerr << "Hex numbers:\n";
//     //for(int i = 0; i < 16; ++i) {
//     //  cerr << i << " = '" << *CDOmVeriNum::hexArr->at(i) << "'\n";
//     //}
//     //cerr << "Oct numbers:\n";
//     //for(int i = 0; i < 8; ++i) {
//     //  cerr << i << " = '" << *CDOmVeriNum::octArr->at(i) << "'\n";
//     //}
//     //RefCDOmVeriNum n41 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new std::string("51")), TRUE, 32);
//     //RefCDOmVeriNum n49 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new std::string("61")), TRUE, 32);
//     //cerr << "41 % 49 = " << n41->modulo(n49)->getValue() << endl;
//     //RefCDOmVeriNum n4185 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new string("4185")), TRUE, 32);
//     //RefCDOmVeriNum n492  = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new string("492")), TRUE, 32);
//     //n4185 = CDOmVeriNum::cast(n4185->minus());
//     //n492  = CDOmVeriNum::cast(n492->minus());
//     //cerr << "-4185 ^ -492 = " << *CDOmVeriNum::cast(n4185->power(n492))->getValueAsString() << endl;
//     //n4185->changeSign();
//     //cerr << "4185 = " << n4185->getValue() << endl;
//     //n4185->changeSign();
//     //cerr << "-4185 = " << n4185->getValue() << endl;


//     //RefCDOmVeriNum veriNum_a = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("1010000100000001")), TRUE);
//     //RefCDOmVeriNum P = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("00000110")), FALSE);
//     //RefCDOmVeriNum S = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("10100000")), FALSE);
//     //RefCDOmVeriNum veriNum_b = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("101")), FALSE);
//     //RefCDOmVeriNum numHex1   = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("A101")), FALSE);
//     //RefCDOmVeriNum numHex2   = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("101")), FALSE);
//     //RefCDOmVeriNum numDec1   = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("178")), FALSE, 8);
//     //RefCDOmVeriNum numDec2   = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("256")), TRUE);
//     //RefCDOmVeriNum numDecZ   = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("ZZ")), FALSE);
//     //RefCDOmVeriNum num2      = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("2")), FALSE);
//     //RefCDOmVeriNum num8      = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("8")), TRUE);
//     //RefCDOmVeriNum num10     = CDOmVeriNum::build(10, 10, 4);
//     //RefCDOmVeriNum n10       = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("1010")), FALSE, 4);
//     //RefCDOmVeriNum num_minus_10  = CDOmVeriNum::build(10, -10);
//     //RefCDOmVeriNum n1 = CDOmVeriNum::build(10, 1, 10);
//     //RefCDOmVeriNum nm4 = CDOmVeriNum::build(10, -4, 4);
//     //
//     //cerr << "1 - 4 = " << n1->add(nm4)->getValue() << " " << *CDOmVeriNum::cast(n1->add(nm4))->getValueAsString() << endl;
//     //cerr << "8 / 2 = " << num8->divide(num2)->getValue() << " " << *CDOmVeriNum::cast(num8->divide(num2))->getValueAsString() << endl;
//     //cerr << "8 / -2 = " << num8->divide(num2->minus())->getValue() << " " << *CDOmVeriNum::cast(num8->divide(num2)->minus())->getValueAsString() << endl;
//     //cerr << "8 % 2 = " << num8->modulo(num2)->getValue() << " " << *CDOmVeriNum::cast(num8->modulo(num2))->getValueAsString() << endl;
//     //cerr << "256 % 178 = " << numDec2->modulo(numDec1)->getValue() << " " << *CDOmVeriNum::cast(numDec2->modulo(numDec1))->getValueAsString() << endl;
//     //cerr << "256 / 178 = " << numDec2->divide(numDec1)->getValue() << " " << *CDOmVeriNum::cast(numDec2->divide(numDec1))->getValueAsString() << endl;
//     //cerr << "-178 / 10 = " << numDec1->minus()->divide(num10)->getValue() << " " << *CDOmVeriNum::cast(numDec1->minus()->divide(num10))->getValueAsString() << endl;
//     //cerr << "-178 / 10 = " << numDec1->minus()->divide(n10)->getValue() << " " << *CDOmVeriNum::cast(numDec1->minus()->divide(n10))->getValueAsString() << endl;
//     //cerr << "-178 = " << numDec1->minus()->getValue() << " " <<  *CDOmVeriNum::cast(numDec1->minus())->getValueAsString() << endl;
//     //cerr << "10 = " << num10->getValue() << " " << *num10->getValueAsString() << endl;

//     //cerr << *n1->getValueAsString() << " < " << *num2->getValueAsString() << " : " << n1->relationalLess(num2)->equals(1) << endl;
//     //cerr <<"10^2 = " << num10->power(num2)->getValue() << endl;
//     //cerr << "P + S = " << CDOmVeriNum::cast(P->add(S))->getValue() << endl;
//     //RefCDOmVeriNum       res;// = CDOmVeriNum::build(10, CDOmVeriNum::_X, 6);
//     //RefCDOmVeriNum res2 = CDOmVeriNum::cast(numHex1->add(veriNum_b));
//     //res = CDOmVeriNum::cast(veriNum_a->add(veriNum_b));
//     //cerr << "veriNum_a = " << veriNum_a->getValue() << endl;
//     //cerr << "numHex1 = " << numHex1->getValue() << " numHex2 = " << numHex2->getValue() << endl;
//     //std::cerr << "res = " << res->getValue() << "\nres2 = " << res2->getValue() << "\nnumDec1 = " << numDec1->getValue() << endl;
//     //std::cerr << "numDecZ = " << numDecZ->getValue() << endl;
//     //numDecZ->setValue(-102);
//     //cerr << "numDecZ = " << numDecZ->getValue() << endl;
//     //cerr << "numDec2 (= -256) = " << numDec2->getValue() << " " << *numDec2->getValueAsString() << endl;
//     //numDec2->setValue(-256);
//     //cerr << "numDec2 (= -256) = " << numDec2->getValue() << " " << *numDec2->getValueAsString() << endl;
//     //numDec2->setValue(255);
//     //cerr << dec << numDec2->getValue() << endl;
//     //numDec2->setValue(256);
//     //cerr << dec << numDec2->getValue() << endl;

//     //RefCDOmNum32 num321 = CDOmNum32::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("129")));
//     //RefCDOmVeriNum num_3 = CDOmVeriNum::build(10, 3);
//     //RefCDOmVeriNum num_min_4 = CDOmVeriNum::build(10, -4);
//     //RefCDOmNum32 num322 = CDOmNum32::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("23")));
//     //RefCDOmNum32 num_neg = CDOmNum32::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("-14")));
//     //cerr << "129 + 23 = " << (num322->add(num321))->getValue() << "\n129 - 14 = " << (num321->add(num_neg))->getValue() << endl;
//     //
//     ////shift
//     //numDecZ = CDOmVeriNum::cast(veriNum_a->shiftLeft(num2));
//     //cerr << "veriNum_a <<< 2 = " << numDecZ->getValue() << "\nveriNum_a >>> 2 = " << CDOmVeriNum::cast(veriNum_a->shiftRight(num2))->getValue() << endl;
//     //cerr << "8 + 2 = " << CDOmVeriNum::cast(num8->add(num2))->getValue() << " = " << CDOmVeriNum::cast(num2->add(num8))->getValue() << endl;
//     //cerr << "num10 = " << num10->getValue() << "\nnum_minus_10 = " << num_minus_10->getValue() << endl;
//     //cerr << "3 x -4 = " << CDOmVeriNum::cast(num_3->multiply(num_min_4))->getValue() << endl;
//     //cerr << "10 x -10 = " << CDOmVeriNum::cast(num10->multiply(num_minus_10))->getValue() << endl;
//     //cerr << "-10 x 2 = " << CDOmVeriNum::cast(num2->multiply(num_minus_10))->getValue() << endl;
//     //cerr << "10 x 2 = " << CDOmVeriNum::cast(num2->multiply(num10))->getValue() << endl;
//     //numDec1 = CDOmVeriNum::cast(numDec1->minus());
//     //cerr << "-10 = " << num_minus_10->getValue() << " -178 = " << numDec1->getValue() << endl;
//     //cerr << "-10 x -178 = " << CDOmVeriNum::cast(num_minus_10->multiply(numDec1))->getValue() << endl;
//     //cerr << "-10 = " << num_minus_10->getValue() << endl;
//     //cerr << "-178 == -178: " << numDec1->equals(-178) << endl;
//     //cerr << "-178 == 334: " << numDec1->equals(334) << endl;
//     //cerr << "10 - (-178) = " << CDOmVeriNum::cast(num10->substract(numDec1))->getValue() << endl;
//     //cerr << numDec1->getValue() << "(" << *numDec1->getValueAsString() << ") / " << num10->getValue() << "(" << *num10->getValueAsString() << ") = " 
//     //     << CDOmVeriNum::cast(numDec1->divide(num10))->getValue() << endl;
//     //cerr << "-255 / 5 = " << CDOmVeriNum::cast(numDec2->divide(veriNum_b))->getValue() << endl;

//     //RefCDOmVeriNum num_min_3 = CDOmVeriNum::build(10, -3);
//     //RefCDOmVeriNum num_5 = CDOmVeriNum::build(10, 5);
//     //RefCDOmVeriNum one = CDOmVeriNum::build(10, 1);
//     //RefCDOmVeriNum mone = CDOmVeriNum::build(10, -1);
//     //RefCDOmVeriNum m14 = CDOmVeriNum::build(10, -14);
//     //RefCDOmVeriNum m10 = CDOmVeriNum::build(10, -10);
//     //RefCDOmVeriNum _one = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("1")), FALSE);
//     //RefCDOmVeriNum _mone = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("1")), TRUE);
//     //cerr << "-3 + 5 = " << CDOmVeriNum::cast(num_min_3->add(num_5))->getValue() << " = " << CDOmVeriNum::cast(num_5->add(num_min_3))->getValue() << endl;
//     //cerr << "-3 >>> 2 = " << CDOmVeriNum::cast(num_min_3->shiftRight(num2))->getValue() << endl;
//     //cerr << "one = " << one->getValue() << endl;
//     //cerr << "mone = " << mone->getValue() << endl;
//     //cerr << "_one = " << _one->getValue() << endl;
//     //cerr << "_mone = " << _mone->getValue() << endl;
//     //cerr << "-14 >>> 1 = " << CDOmVeriNum::cast(m14->shiftRight(one))->getValue() << endl;
//     //cerr << "!-3 = " << CDOmVeriNum::cast(num_min_3->logicNot())->getValue() << endl; 
//     //cerr << "-10 <<< 1 = " << CDOmVeriNum::cast(m10->shiftLeft(one))->getValue() << endl;
//     //cerr << "-178 % 10 = " << CDOmVeriNum::cast(numDec1->modulo(num10))->getValue() << endl;
//     //cerr << "5 - 10 = " << CDOmVeriNum::cast(num_5->substract(num10))->getValue() << endl;

//     //RefCDOmVeriNum six = CDOmVeriNum::build(10, 6);
//     //RefCDOmVeriNum msix = CDOmVeriNum::build(10, -6);
//     //RefCDOmVeriNum ten = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("A")), FALSE);
//     //RefCDOmVeriNum four = CDOmVeriNum::build(10, 4);

//     //cerr<<"6 >>>  A = "<<six->shiftRight(ten)->getValue() << endl;
//     //cerr<<"-6 >>>  A = "<<msix->shiftRight(ten)->getValue() << endl;
//     //cerr<<"6 >> 4 = "<<six->binaryShiftRight(four)->getValue() << endl;
//     //cerr<<"6 << 4 = "<<six->binaryShiftLeft(four)->getValue() << endl;
//     //cerr << "6 <<< 4 = " << six->shiftLeft(four)->getValue() << endl;
//     //cerr << "4 == 0 " << four->equals(0) << endl;
//     //cerr << "4 < 4 " << four->relationalLess(four)->equals(1) << endl;
//     //cerr << "6**4 = " << six->power(four)->getValue() << endl;
//     //cerr << "6**(-4) = " << six->power(four->minus())->getValue() << endl;
//     //cerr << "-6**4 = " << six->power(four)->getValue() << endl;
//     //cerr << "-6**(-4) = " << six->power(four->minus())->getValue() << endl;
//     //cerr << "-6**5 = " << six->minus()->power(num_5)->getValue() << endl;
//     //cerr << veriNum_a->getValue() << "D = " << *(CDOmVeriNum::cast(veriNum_a)->getValueAsString()) << "B" << endl;
//     //cerr << "Ah = " << *(ten->getValueAsString()) << "h" << endl;
//     //cerr << "A101h = " << *(numHex1->getValueAsString()) << "h" << endl;
//     //RefCDOmVeriNum numOct = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_OCT, RefString(new std::string("111122223333444455556666777700007777666655554444333322221111ZXXZZ")), FALSE);
//     //RefCDOmVeriNum hexBigNum = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("ABCDEEEEFFF0000111122223333444455556666CCCC")), FALSE);
//     //RefCDOmVeriNum hexBigNum1 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("ABCDEEEEFFF0000111122223333444455556666CCCC0")), FALSE);
//     //RefCDOmVeriNum sixteen = CDOmVeriNum::build(10, 16);
//     //RefCDOmVeriNum bigRes;
//     //cerr << "numOct = " << *(numOct->getValueAsString()) << "o" << endl;
//     //cerr << "hexBigNum = " << *(hexBigNum->getValueAsString()) << "h" << endl;
//     //cerr << "hexBigNum x (-10) = " << *(CDOmVeriNum::cast(hexBigNum->multiply(m10))->getValueAsString()) << "b" << endl;
//     //bigRes = CDOmVeriNum::cast(hexBigNum->multiply(sixteen));
//     //cerr << "hexBigNum x 16 = " << *(bigRes->getValueAsString()) << "b" << endl;
//     //cerr << "bigRes == hexBigNum1: " << bigRes->equality(hexBigNum1)->equals(1) << endl;
//     //
//     //RefCDOmVeriNum num33bits = CDOmVeriNum::build(10, CDOmBitArray::_1, 33);
//     //RefCDOmVeriNum num3bits = CDOmVeriNum::build(10, CDOmBitArray::_1, 3);
//     //num3bits->setValue(9);
//     //cerr << "num33bits = " << *(num33bits->getValueAsString()) << endl;
//     //cerr << "num3bits = " << *(num3bits->getValueAsString()) << endl;

//     //RefCDOmVeriNum nine8 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("9")), TRUE, 8);
//     //cerr << "9 = " << *(nine8->getValueAsString()) << " = " <<  nine8->getValue() << endl;
//     //RefCDOmVeriNum hexOne = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("1")), TRUE, 1);
//     //cerr << "hexOne = " << hexOne->getValue() << endl;
//     //RefCDOmVeriNum vBug = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("1")), TRUE, 1);
//     //RefCDOmVeriNum vBug1 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("3")), TRUE, 1);
//     //RefCDOmVeriNum vBug2 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("61")), TRUE, 2);
//     //RefCDOmVeriNum vBug3 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("61")), TRUE, 2);
//     //RefCDOmVeriNum vBug4 = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("12")), TRUE, 2);
//     //cerr << "vBug = " << vBug->getValue() << " (asString) = " << *vBug->getValueAsString() << std::endl;
//     //cerr << "vBug1 = " << vBug1->getValue() << " (asString) = " << *vBug1->getValueAsString() << std::endl;
//     //cerr << "vBug2 = " << vBug2->getValue() << " (asString) = " << *vBug2->getValueAsString() << std::endl;
//     //cerr << "vBug3 = " << vBug3->getValue() << " (asString) = " << *vBug3->getValueAsString() << std::endl;
//     //cerr << "vBug4 = " << vBug4->getValue() << " (asString) = " << *vBug4->getValueAsString() << std::endl;
    
//   } catch(const NSBase::Exception &e) {
//     cerr << "Exception " << e.what() << endl;
//   }
// }
  //~Tb removed//

//added by Tb
void testCDOmVeriNum() {
  RefCDOmVeriNum testVN = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("101100011101110101")), TRUE, 18);
}
//~added by Tb

int main() {
  const int n = 3;

    //testCast();
  //testGetChild();
    //testList();
    //testMinTypMaxList();
  //testParam();
  //ECDOmType_to_String stringType;

  //Tb removed//
  //  testCDOmVeriNum();
  //~Tb removed//

  //added by Tb
  testCDOmVeriNum();
  //~added by Tb

  //stringType.createTypeMap();
  //cout << stringType.getStringType(TYPE_ALL_TYPES);
  /*
     testExprOp();//includes testAttrListCollection
     RefCDOmListExpr exprList0 = testExprList();
     RefCDOmExprConcat exprConcat=testExprConcat();
     testExprMultiConcat(exprConcat);
     RefCDOmDelayControl delayControl=testDelayControl();
     RefCDOmExprLink exprLink=testExprLink();
     RefCDOmEventExpr eventExpr=testEventExpr();
     RefCDOmEventControl eventControl=testEventControl(exprLink,eventExpr);
     testStmt();
     RefCDOmExprLink exprLink1=testExprLink();
     RefCDOmExprLink exprLink2=testExprLink();
     RefCDOmExprLink exprLink3=testExprLink();
     testStmtAssn(exprLink1,exprLink2,exprLink3,delayControl,eventControl);
     RefCDOmListExpr exprList[n];
     for(int i=0; i<n; i++)
     exprList[i] = testExprList();
     testStmtCase(exprList);
     testStmtIf();
     RefCDOmExprLink exprLink4=testExprLink();
     testStmtDisable(exprLink4);
     RefCDOmExprLink exprLink5=testExprLink();
     testStmtEventTrigger(exprLink5,exprList0);
     testStmtLoop();
     testStmtBlock();
     testStmtProcContAssn();

     RefCDOmExprLink exprLink10=testExprLink();
     testStmtProcTimingControl(exprLink10);
     RefCDOmExprLink exprLink11=testExprLink();
     testStmtTaskEnable(exprLink11);

     testStmtWait();
     testRange();
     testRangeList();
     testRangeExpr();
     RefCDOmExprLink exprLink12[n];
     RefCDOmExprLink exprLink13[n];
     for(int i=0; i<n; i++){
     exprLink12[i]=testExprLink();
     exprLink13[i]=testExprLink();
     }
     testParamDecl(exprLink12,exprLink13);//includes testPulseControl
     testParamDeclCollection();
     testPortDecl();
     testPortItem();
     testPortItem();
     testModuleDecl();
     testTFPortDecl();
     testTaskDecl();
     testFuncDecl();
     testVarDecl();
     testMinTypMax();
     testDelay();
     testNetDecl();
     testEventDecl();
     testGenvarDecl();
     testParamOverride();
     RefCDOmExprLink exprLink14[n];
     for(int i=0; i<n; i++)
     exprLink14[i] = testExprLink();
     testContAssn(exprLink14);
     testModuleOrUdpInstance();
     testModuleOrUdpInstantiation();
     testInitOrAlways();
     testSpecifyBlock();
     RefCDOmExprLink exprLink15 = testExprLink();
     RefCDOmListExpr exprList2 = testExprList();
     testFunctionCall(exprLink15,exprList2);
     testPulseStyleOrShowCancelledDecl();
     testNumber();
     testReal();
  testString();
  testMinTypMaxList();
  testPathDelayValue();
  testSpecifyTerminalList();
  testDesign();
  testAttrList();
  RefCDOmExprLink exprLink17 = testExprLink();
  testAssn(exprLink17);
  testGateInstantiation(); 
  testPathDecl(); 
  testTimingCheckEvent();
  testTimingCheckEventControl();
  testDelayedDataOrReference();
  testSystemTimingCheck();
  testGenInst();
  testGenItemLoop();//also tests genItemNull
  testGenItemIf();
  testGenItemCase();
  testGenItemBlock();
  testUdpDecl();
  testUdpCombEntry();
  testUdpSeqEntry();
  testCDOM_API();*/

    return 0;
}
