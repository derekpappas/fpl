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
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

#include "../cdom/CDOM.h"
#include "../cslom/CSLOM_Visitor.h"
#include "../support/CommonSupport.h"
#include <sstream>

#ifndef _CSL_TO_CDOM_ADAPTER

#define _CSL_TO_CDOM_ADAPTER

//#define __RELEASE_VERSION

#ifndef __RELEASE_VERSION

#define _DEGUB_CSL_TO_CDOM_ADAPTER
#define _ADAPTER_COMPILED_TIME

#endif

namespace NSAdapter {

/**
 * The main idea in implementing the adapter is to write it just like
 * an AST walker. The rules are the visit functions, and the AST is the
 * input CSLOM hierarchy.
 * The visit functions communicate to each other via some global variables:
 * the current parent and the returned value (for both cslom and cdom):
 * m_cdomReturnedValue, m_cdomCurrParent, m_cslReturnedValue, m_cslCurrParent
 */
class CAdapterToCDOM : public NSCSLOmVisitor::CVisitorTraversal {
  private:
    TInt m_inTraversalForUnitInstantiation;
    TInt m_beforeTraversalForNum32;
    TInt m_firstCallOfNum32BT, m_secondCallOfNum32BT, m_thirdCallOfNum32BT;
    TInt m_firstCallOfBitRangeIT;
    TBool m_simpleBitRangeIT;
    TBool m_isOrdinarySimpleBrOrDimZero;
    TBool m_insideAssign;
    TInt m_firstCallOfEnumIT;
    RefString m_enumName;
    TInt m_enumItemVal;
    TInt m_generateIndividualSignals;
    NSCdom::RefCDOmNumber m_num32Offset, m_num32FirstExpr, m_num32SecondExpr;
    TInt m_nrOfAlienChildren;

    std::vector<NSCSLOm::RefCSLOmConnectable> m_assignIfcOrSg;

    std::map<NSCSLOm::RefCSLOmPortDecl, RefTVec_RefString> m_allCslPorts;
    std::map<NSCSLOm::RefCSLOmSignal, RefTVec_RefString> m_allCslSignals;
    std::map<NSCSLOm::RefCSLOmConnectable, RefString> m_allPortsSignalsNames;

    std::map<NSCdom::RefCDOmPortDecl, RefString> m_allCdomPorts;
    std::map<RefString, RefString> m_allCdomSignals;


    std::map<NSCSLOm::RefCSLOmPortDecl, RefTVec_RefString> m_cslPortsSuffixes;
    std::map<NSCSLOm::RefCSLOmSignal, RefTVec_RefString> m_cslSignalsSuffixes;

    typedef enum _EAdapterUnitType {
      UNIT_TYPE_UNIT_DECL,
      UNIT_TYPE_FIFO_DECL,
      UNIT_TYPE_REGISTER_FILE_DECL,
      UNIT_TYPE_TESTBENCH_DECL,
      UNIT_TYPE_VECTOR_DECL,
      UNIT_TYPE_MEM_DECL,
      UNIT_TYPE_REGISTER_DECL
    } EAdapterUnitType;
    EAdapterUnitType m_unitType;
    
    NSCSLOm::RefCSLOmUnitInfo m_unitInfo;
    std::map<NSCSLOm::EFifoPortNames, NSCdom::RefCDOmPortDecl> m_cdomFifoPorts;
    NSCSLOm::RefTMap_EFifoPortNames_RefCSLOmPortDecl m_cslFifoPorts;
    std::map<NSCSLOm::ERFPortNames, NSCdom::RefCDOmPortDecl> m_cdomRegisterFilePorts;
    NSCSLOm::RefTMap_ERFPortNames_RefCSLOmPortDecl m_cslRegisterFilePorts;
    std::map<NSCSLOm::ERegPortNames, NSCdom::RefCDOmPortDecl> m_cdomRegisterPorts;
    NSCSLOm::RefTMap_ERegPortNames_RefCSLOmPortDecl m_cslRegisterPorts;
    
    //for testbench use
    std::map<RefString, NSCSLOm::RefTVec_RefCSLOmUnitDecl> m_tbDutNamesStimVects;
    std::map<RefString, NSCSLOm::RefTVec_RefCSLOmUnitDecl> m_tbDutNamesExpectVects;

    std::map<NSCdom::RefCDOmModuleOrUdpInstance, NSCdom::RefTVec_RefCDOmModuleOrUdpInstance> m_cdomDutsStimVects;
    std::map<NSCdom::RefCDOmModuleOrUdpInstance, NSCdom::RefTVec_RefCDOmModuleOrUdpInstance> m_cdomDutsExpectVects;

    NSCdom::RefTVec_RefCDOmModuleOrUdpInstance m_cdomDutInstances;

    RefString m_tbVectClockName;
    RefString m_tbVectResetName;
    RefString m_tbVectOutputName;   
    RefString m_tbVectValidName;
    RefString m_tbVectRdEnName;
    RefString m_tbVectVerErrName;
    RefString m_tbVectIdErrName;

    // RefString m_ifc; //MS added
    TBool m_tbVectorDone;

    RefString m_vectorModuleName;//not checked
    NSCSLOm::RefTVec_RefCSLOmBase m_tbVectorInstances;//not checked

    std::vector<RefString> m_nameVect;//?
    RefString m_unitPrefix;
    RefTVec_RefString m_ifcPrefixes;
    RefTVec_RefString m_sigGroupPrefixes;

    RefTVec_RefString m_ifcSuffixes;
    RefTVec_RefString m_sigGroupSuffixes;
    
    RefTVec_RefString m_actualPrefix;
    RefTVec_RefString m_formalPrefix;

    RefTVec_RefString m_reversedFormalPrefixes;
    RefTVec_RefString m_reversedActualPrefixes;
    TInt cnt;   //MS added
    NSCdom::RefCDOmDesign m_product;

    NSCSLOm::RefTVec_RefCSLOmMemoryMapLocation m_memMapLocations; 
    NSCdom::RefCDOmBase   m_cdomCurrParent;
    NSCSLOm::RefCSLOmBase m_cslCurrParent;

    NSCdom::RefCDOmBase   m_cdomReturnedValue;
    NSCSLOm::RefCSLOmBase m_cslReturnedValue;
  
    NSCdom::RefTVec_RefCDOmBase m_cdomTraversedChildren;
    NSCSLOm::RefTVec_RefCSLOmBase m_cslTraversedChildren;
    
    NSCdom::ECDOmVarType getCDOmVarType(NSCSLOm::ECSLOmSignalType);
    NSCdom::ECDOmNetType getCDOmNetType(NSCSLOm::ECSLOmSignalType);
    static NSCdom::CDOmNumber::ENumBaseType getCDOmNumType(NSCSLOm::CSLOmNumber::ENumBaseType);
    static RefString getNumberString(const RefString& , NSCSLOm::CSLOmNumber::ENumBaseType );
    static std::vector<int> hashBin;
    static std::vector<int> hashOct;
    static std::vector<int> hashDec;
    static std::vector<int> hashHex;
    static void initHashes();
    static bool notBin (const char x) { return !hashBin[x]; }
    static bool notOct (const char x) { return !hashOct[x]; }
    static bool notDec (const char x) { return !hashDec[x]; }
    static bool notHex (const char x) { return !hashHex[x]; }
    //NOT CALLED EVER AND BREAK BUILD ON WINDOWS
//     static RefString stripBin (const RefString& input ) { RefString output( new std::string()); std::remove_copy_if( input->begin(), input->end(), std::back_inserter( *output ), notBin  ); return output; }
//     static RefString stripOct (const RefString& input ) { RefString output( new std::string()); std::remove_copy_if( input->begin(), input->end(), std::back_inserter( *output ), notOct  ); return output; }
//     static RefString stripDec (const RefString& input ) { RefString output( new std::string()); std::remove_copy_if( input->begin(), input->end(), std::back_inserter( *output ), notDec  ); return output; }
//     static RefString stripHex (const RefString& input ) { RefString output( new std::string()); std::remove_copy_if( input->begin(), input->end(), std::back_inserter( *output ), notHex  ); return output; }
    
    /**
      * API functions
      */
    NSCdom::RefCDOmDesign                     buildCDOmDesign                     ();
    NSCdom::RefCDOmComment                    buildCDOmComment                    ( TInt lineNumber, 
                                                                                    NSCdom::RefCDOmBase parent,
                                                                                    NSCdom::CDOmComment::ECommentType commentType,
                                                                                    RefString commentLine
                                                                                  );
    NSCdom::RefCDOmInclude                    buildCDOmInclude                    ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmBase parent,
                                                                                    NSCdom::EIncludeFileType type,
                                                                                    RefString fileName
                                                                                  );
    NSCdom::RefCDOmExprLink                   buildCDOmExprLink                   ( TInt lineNumber, 
                                                                                    const RefString& name, 
                                                                                    NSCdom::RefCDOmExpr expr = NSCdom::RefCDOmExprLink()
                                                                                  );
    NSCdom::RefCDOmExprConcat                 buildCDOmConcat                   ( TInt lineNumber, 
                                                                                      NSCSLOm::RefTVec_RefCSLOmBase expr
                                                                                  );
    NSCdom::RefCDOmExprMultiConcat            buildCDOmMultiConcat                   ( TInt lineNumber, 
                                                                                       NSCSLOm::RefCSLOmExpr expr
                                                                                     );
    NSCdom::RefCDOmString                     buildCDOmString                     ( TInt lineNumber, 
                                                                                    const RefString& name, 
                                                                                    NSCdom::RefCDOmExpr expr = NSCdom::RefCDOmExprLink()
                                                                                  );
    NSCdom::RefCDOmExprOp                     buildCDOmExprOp                     ( TInt lineNumber, 
                                                                                    NSCdom::CDOmExprOp::EOpType opType, 
                                                                                    NSCdom::RefCDOmExpr expr1, 
                                                                                    NSCdom::RefCDOmExpr expr2 = NSCdom::RefCDOmExpr(), 
                                                                                    NSCdom::RefCDOmExpr expr3 = NSCdom::RefCDOmExpr()
                                                                                  );
    NSCdom::RefCDOmStmt                       buildCDOmStmtNull                   ( TInt lineNumber);
    NSCdom::RefCDOmStmtAssn                   buildCDOmStmtAssnSimple             ( TInt lineNumber, 
                                                                                    NSCdom::CDOmStmtAssn::EAssnType assnType, 
                                                                                    NSCdom::RefCDOmExpr lvalue,
                                                                                    NSCdom::RefCDOmExpr expr
                                                                                  );
    NSCdom::RefCDOmStmtAssn                   buildCDOmStmtAssnWithDelayControl   ( TInt lineNumber, 
                                                                                    NSCdom::CDOmStmtAssn::EAssnType assnType, 
                                                                                    NSCdom::RefCDOmExpr lvalue,
                                                                                    NSCdom::RefCDOmExpr expr,
                                                                                    NSCdom::RefCDOmDelayControl delayControl
                                                                                  );
    NSCdom::RefCDOmStmtAssn                   buildCDOmStmtAssnWithEventControl   ( TInt lineNumber, 
                                                                                    NSCdom::CDOmStmtAssn::EAssnType assnType, 
                                                                                    NSCdom::RefCDOmExpr lvalue,
                                                                                    NSCdom::RefCDOmExpr expr,
                                                                                    NSCdom::RefCDOmEventControl evntControl,
                                                                                    NSCdom::RefCDOmExpr repeatExpr
                                                                                  );
    NSCdom::RefCDOmDelayControl               buildCDOmDelayControl               ( TInt lineNumber, 
                                                                                    NSCdom::RefCDOmNumber num 
                                                                                  );  
    NSCdom::RefCDOmEventControl               buildCDOmEventControlWithHid        ( TInt lineNumber, 
                                                                                    NSCdom::RefCDOmExprLink hid 
                                                                                  );  
    NSCdom::RefCDOmEventControl               buildCDOmEventControlWithEvExpr     ( TInt lineNumber, 
                                                                                    NSCdom::RefCDOmEventExpr evExpr 
                                                                                  );  
    NSCdom::RefCDOmEventControl               buildCDOmEventControlWithBool       ( TInt lineNumber, 
                                                                                    TBool starWithParenthesis = false
                                                                                  );  
    NSCdom::RefCDOmEventExpr                  buildCDOmEventExprSimple            ( TInt lineNumber, 
                                                                                    NSCdom::CDOmEventExpr::EEventExprType type, 
                                                                                    NSCdom::RefCDOmExpr expr
                                                                                  );
    NSCdom::RefCDOmEventExpr                  buildCDOmEventExprDouble            ( TInt lineNumber, 
                                                                                    NSCdom::CDOmEventExpr::EEventExprType type, 
                                                                                    NSCdom::RefCDOmEventExpr expr1,
                                                                                    NSCdom::RefCDOmEventExpr expr2
                                                                                  );
    NSCdom::RefCDOmStmtIf                     buildCDOmStmtIf                     ( TInt lineNumber, 
                                                                                    NSCdom::RefCDOmExpr ifCondExpr, 
                                                                                    NSCdom::RefCDOmStmt ifStmt, 
                                                                                    NSCdom::RefCDOmStmt elseStmt
                                                                                  );
    NSCdom::RefCDOmStmtCase                   buildCDOmStmtCase                   ( TInt lineNumber, 
                                                                                    NSCdom::CDOmStmtCase::ECaseType type, 
                                                                                    NSCdom::RefCDOmExpr expr,
                                                                                    NSCdom::RefCDOmListExpr listExpr, 
                                                                                    NSCdom::RefCDOmStmt stmt
                                                                                  );
    NSCdom::RefCDOmStmtDisable                buildCDOmStmtDisable                ( TInt lineNumber, 
                                                                                    NSCdom::RefCDOmExprLink hid 
                                                                                  );
    NSCdom::RefCDOmStmtLoop                   buildCDOmStmtLoopForever            ( TInt lineNumber, 
                                                                                    NSCdom::RefCDOmStmt stmt
                                                                                  );
    NSCdom::RefCDOmStmtLoop                   buildCDOmStmtLoopRepeat             ( TInt lineNumber, 
                                                                                    NSCdom::RefCDOmExpr expr, 
                                                                                    NSCdom::RefCDOmStmt stmt
                                                                                  );
    NSCdom::RefCDOmStmtLoop                   buildCDOmStmtLoopWhile              ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmExpr expr,
                                                                                    NSCdom::RefCDOmStmt stmt);
    NSCdom::RefCDOmStmtLoop                   buildCDOmStmtLoopFor                ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmAssn initAssn,
                                                                                    NSCdom::RefCDOmExpr condExpr,
                                                                                    NSCdom::RefCDOmAssn incAssn,
                                                                                    NSCdom::RefCDOmStmt stmt
                                                                                    );
    NSCdom::RefCDOmStmtEventTrigger           buildCDOmStmtEventTrigger           ( TInt lineNumber, 
                                                                                    NSCdom::RefCDOmExprLink hid, 
                                                                                    NSCdom::RefCDOmListExpr listExpr
                                                                                  );
    NSCdom::RefCDOmStmtBlock                  buildCDOmStmtBlock                  ( TInt lineNumber, 
                                                                                    NSCdom::CDOmStmtBlock::EBlockType blockType, 
                                                                                    const RefString& name = RefString()
                                                                                  );
    NSCdom::RefCDOmAssn                       buildCDOmAssn                       ( TInt lineNumber, 
                                                                                    NSCdom::RefCDOmExpr lvalue, 
                                                                                    NSCdom::RefCDOmExpr expr
                                                                                  );
    NSCdom::RefCDOmContAssn                   buildCDOmContAssn                   ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmBase parent,
                                                                                    NSCdom::ECDOmDriveStrength first 
                                                                                      = NSCdom::DRIVE_STRENGTH_UNDEFINED,
                                                                                    NSCdom::ECDOmDriveStrength second
                                                                                      = NSCdom::DRIVE_STRENGTH_UNDEFINED
                                                                                  );
    NSCdom::RefCDOmStmtProcContAssn           buildCDOmStmtProcContAssnWithAssn   ( TInt lineNumber,
                                                                                    NSCdom::CDOmStmtProcContAssn::EProcContAssnType procContAssnType,
                                                                                    NSCdom::RefCDOmAssn assn
                                                                                  );
    NSCdom::RefCDOmStmtProcContAssn           buildCDOmStmtProcContAssnWithLvalue ( TInt lineNumber,
                                                                                    NSCdom::CDOmStmtProcContAssn::EProcContAssnType procContAssnType,
                                                                                    NSCdom::RefCDOmExpr lvalue
                                                                                  );
    NSCdom::RefCDOmStmtProcTimingControl      buildCDOmStmtProcTimingControlWithEventControl      
                                                                                  ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmEventControl eventControl,
                                                                                    NSCdom::RefCDOmStmt stmt
                                                                                  );
    NSCdom::RefCDOmStmtProcTimingControl      buildCDOmStmtProcTimingControlWithDelayControl      
                                                                                  ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmDelayControl delayControl,
                                                                                    NSCdom::RefCDOmStmt stmt
                                                                                  );
    NSCdom::RefCDOmStmtTaskEnable             buildCDOmStmtTaskEnable             ( TInt lineNumber,
                                                                                    NSCdom::CDOmStmtTaskEnable::ETaskEnableType taskEnableType,
                                                                                    NSCdom::RefCDOmExprLink hid
                                                                                  );
    NSCdom::RefCDOmStmtWait                   buildCDOmStmtWait                   ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmExpr expr,
                                                                                    NSCdom::RefCDOmStmt stmt
                                                                                  );
    NSCdom::RefCDOmRange                      buildCDOmRange                      ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmExpr firstExpr,
                                                                                    NSCdom::RefCDOmExpr secondExpr
                                                                                  );
    NSCdom::RefCDOmRangeList                  buildCDOmRangeList                  ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmRange rangeItem
                                                                                  );
    NSCdom::RefCDOmRangeExpr                  buildCDOmRangeExprSimple            ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmExpr firstExpr
                                                                                  ); 
    NSCdom::RefCDOmRangeExpr                  buildCDOmRangeExprDouble            ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmExpr firstExpr,
                                                                                    NSCdom::RefCDOmExpr secondExpr,
                                                                                    NSCdom::CDOmRangeExpr::ERangeExprType rangeExprType = 
                                                                                    NSCdom::CDOmRangeExpr::RANGE_EXPR_DOUBLE
                                                                                  ); 
    NSCdom::RefCDOmParamDecl                  buildCDOmParamDecl                  ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmBase parent,
                                                                                    NSCdom::CDOmParamDecl::EParamDeclType paramDeclType
                                                                                  );
    NSCdom::RefCDOmParamDecl                  buildCDOmParamDeclWithParamType     ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmBase parent,
                                                                                    NSCdom::CDOmParamDecl::EParamDeclType paramDeclType,
                                                                                    NSCdom::CDOmParamDecl::EParamType     paramType
                                                                                  );
    NSCdom::RefCDOmPortDecl                   buildCDOmPortDeclNet                ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmBase parent,
                                                                                    NSCdom::ECDOmPortType portType,
                                                                                    NSCdom::ECDOmNetType netType,
                                                                                    NSCdom::RefCDOmRange range = NSCdom::RefCDOmRange(),
                                                                                    const RefString& name = RefString(),
                                                                                    NSCdom::RefCDOmExpr expr = NSCdom::RefCDOmExpr()
                                                                                  );//buid+addPort
    NSCdom::RefCDOmPortDecl                   buildCDOmPortDeclVar                ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmBase parent,
                                                                                    NSCdom::ECDOmVarType varType,
                                                                                    NSCdom::RefCDOmRange range = NSCdom::RefCDOmRange(),
                                                                                    const RefString& name = RefString(),
                                                                                    NSCdom::RefCDOmExpr expr = NSCdom::RefCDOmExpr()
                                                                                  );//build+addPort no expr without string
    NSCdom::RefCDOmUdpPortDeclOutput          buildCDOmUdpPortDeclOutput          ( TInt lineNumber,
                                                                                    NSCdom::RefCDOmUdpDecl parent,
                                                                                    NSCdom::CDOmUdpPortDeclOutput::EUdpPortDeclOutputType type,
                                                                                    const RefString portName,
                                                                                    NSCdom::RefCDOmExpr expr = NSCdom::RefCDOmExpr()
                                                                                  );
    NSCdom::RefCDOmUdpPortDeclInput           buildCDOmUdpPortDeclInput            ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmUdpDecl parent,
                                                                                     const RefString portName
                                                                                   );
    NSCdom::RefCDOmTaskDecl                   buildCDOmTaskDecl                    ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmBase parent,
                                                                                     NSCdom::CDOmTaskDecl::ETaskDeclType taskDeclType,
                                                                                     const RefString& name,
                                                                                     TBool isAutomatic
                                                                                   );
    NSCdom::RefCDOmFuncDecl                   buildCDOmFuncDecl                    ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmBase parent, 
                                                                                     NSCdom::CDOmFuncDecl::EFuncDeclType funcDeclType,
                                                                                     const RefString& name,
                                                                                     TBool isAutomatic,
                                                                                     TBool isSigned
                                                                                   );
    NSCdom::RefCDOmFunctionCall               buildCDOmFunctionCall                ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmExprLink exprLink,
                                                                                     NSCdom::RefCDOmListExpr exprList,
                                                                                     NSCdom::RefCDOmAttrListCollection = NSCdom::RefCDOmAttrListCollection()
                                                                                   );
    NSCdom::RefCDOmVarDecl                    buildCDOmVarDecl                     ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmBase parent,
                                                                                     NSCdom::ECDOmVarType varType,
                                                                                     NSCdom::RefCDOmRange range = NSCdom::RefCDOmRange(),
                                                                                     RefString name = RefString(),
                                                                                     NSCdom::RefCDOmRangeList rangeList 
                                                                                     = NSCdom::RefCDOmRangeList(),
                                                                                     NSCdom::RefCDOmExpr expr = NSCdom::RefCDOmExpr()
                                                                                   );
    NSCdom::RefCDOmNetDecl                    buildCDOmNetDecl                     ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmBase parent,
                                                                                     NSCdom::ECDOmNetType netType,
                                                                                     NSCdom::RefCDOmRange range = NSCdom::RefCDOmRange(),
                                                                                     NSCdom::CDOmNetDecl::EVectorAccessType vat 
                                                                                     = NSCdom::CDOmNetDecl::VECTOR_ACCESS_UNDEFINED,
                                                                                     RefString name = RefString(),
                                                                                     NSCdom::RefCDOmRangeList rangeList 
                                                                                     = NSCdom::RefCDOmRangeList(),
                                                                                     NSCdom::RefCDOmExpr expr = NSCdom::RefCDOmExpr()
                                                                                   );
    NSCdom::RefCDOmMinTypMax                  buildCDOmMinTypMax                   ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmExpr expr1,
                                                                                     NSCdom::RefCDOmExpr expr2 = NSCdom::RefCDOmExpr(),
                                                                                     NSCdom::RefCDOmExpr expr3 = NSCdom::RefCDOmExpr()
                                                                                   );//1 expr or 3
    NSCdom::RefCDOmEventDecl                  buildCDOmEventDecl                   ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmBase parent,
                                                                                     const RefString& name,
                                                                                     NSCdom::RefCDOmRangeList rangeList = NSCdom::RefCDOmRangeList()
                                                                                   );
    NSCdom::RefCDOmModuleOrUdpInstantiation   buildCDOmModuleOrUdpInstantiation    ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmBase parent,
                                                                                     NSCdom::RefCDOmExprLink moduleExprLink
                                                                                   ); 
    NSCdom::RefCDOmInitOrAlways               buildCDOmInitOrAlways                ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmBase parent,
                                                                                     NSCdom::CDOmInitOrAlways::EInitOrAlwaysType initOrAlwaysType,
                                                                                     NSCdom::RefCDOmStmt stmt
                                                                                   );
    NSCdom::RefCDOmSpecifyBlock               buildCDOmSpecifyBlock                ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmModuleDecl parent
                                                                                   );
    NSCdom::RefCDOmNum32                      buildCDOmNum32WithValue              ( TInt lineNumber,
                                                                                     TInt value
                                                                                   );
    NSCdom::RefCDOmNum32                      buildCDOmNum32WithString             ( TInt lineNumber, 
                                                                                     NSCdom::CDOmNumber::ENumBaseType base,
                                                                                     RefString num,
                                                                                     TInt vidth = 0
                                                                                   );
    NSCdom::RefCDOmListExpr                   buildCDOmListExpr                    ( TInt lineNumber, 
                                                                                     NSCdom::RefCDOmExpr item
                                                                                   );
    NSCdom::RefCDOmParamOverride              buildCDOmParamOverride               ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmBase parent,
                                                                                     NSCdom::RefCDOmExprLink hid,
                                                                                     NSCdom::RefCDOmMinTypMax minTypMax
                                                                                   );
    NSCdom::RefCDOmExprConcat                 buildCDOmExprConcat                  ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmExpr expr
                                                                                   );
    NSCdom::RefCDOmExprMultiConcat            buildCDOmExprMultiConcat             ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmExpr expr,
                                                                                     NSCdom::RefCDOmExprConcat exprConcat
                                                                                   );
    NSCdom::RefCDOmDefine                     buildCDOmDefine                      (  TInt lineNumber, 
                                                                                      NSCdom::RefCDOmBase parent,
                                                                                      NSCdom::CDOmDefine::EDefineType defineType,
                                                                                      RefString macroName,
                                                                                      NSCdom::RefCDOmExpr macroText = NSCdom::RefCDOmExpr()
                                                                                   );
    /**
      * This method is called from inside the afterTraversal function for unitInstance so start by 
      * reading that comment first.
      * This function deals with each pair of collections in the formal to actual mapping list.
      * By collections I mean interfaces(collections of ports) and signal groups(collections of signals).
      * In other words, it connects an interface to an interface, an interface to a signal group,
      * a signal group to an interface or a signal group to a signal group.
      * There are two main tasks that this method performs:
      * 1. Build the prefix vector and update it:
      *    When connecting an actual signal roup/interface to a formal signal group/interface
      *    all their inner ports/signals will be connected recursively. In the verilog formal to actual
      *    list, all the ports/signals' names will have to be prefixed with the names of the interfaces/signal groups
      *    they were part of in csl. Therefore, the m_actualPrefix and m_formalPrefix vectors store the names of all
      *    the nested signal groups/interfaces that have to be traversed in order to get to the actual ports/signals
      *    that get connected.
      * 2. Perform the actual connections:
      *    In order to connect two ports, two signals, a port to a signal, or a signal to a port, the two connectables
      *    have to meet 4 requirements:
      *    a. same name
      *    b. same bitrange
      *    c. same direction(only for ports)
      *    d. same hierarchical level in the parent collection(interface/signal group)
      *    If all of these things check out, the method below this one is called, to complete the connection.
      */
    void                                      adaptInterfaceOrSignalGroupConnection( NSCSLOm::RefCSLOmConnectable actual, 
                                                                                     NSCSLOm::RefCSLOmConnectable formal, 
                                                                                     NSCdom::RefCDOmModuleOrUdpInstance moduleInst
                                                                                   );

    void                                      adaptIfcOrSgAssign( NSCSLOm::RefCSLOmConnectable lhs, 
                                                                  NSCSLOm::RefCSLOmConnectable rhs, 
                                                                  NSCdom::RefCDOmContAssn contAssn
                                                                  );

    /**
      * Called from within the method above, this function prepends the formal name and the actual name
      * using the prefixes inside the m_actualPrefix and m_formalPrefix vectors.
      * Then, the formal and actual names are used to build the cdom actual and formal parameters, which are 
      * added to the verilog connection map.
      */
    void                                      adaptPortOrSignalConnection          ( NSCSLOm::RefCSLOmExprLink actual, 
                                                                                     NSCSLOm::RefCSLOmExprLink formal, 
                                                                                     NSCdom::RefCDOmModuleOrUdpInstance moduleInst
                                                                                   );
    void                                      adaptPortOrSignalConnection          ( NSCSLOm::RefCSLOmConnectable actual, 
                                                                                     NSCSLOm::RefCSLOmConnectable formal, 
                                                                                     NSCdom::RefCDOmModuleOrUdpInstance moduleInst
                                                                                   );
    void                                      adaptExprConnection                  ( NSCSLOm::RefCSLOmExpr actual, 
                                                                                     NSCSLOm::RefCSLOmConnectable formal, 
                                                                                     NSCdom::RefCDOmModuleOrUdpInstance moduleInst
                                                                                   );
    void                                      adaptRegisterModule                  ( NSCSLOm::RefCSLOmUnitDecl unitDecl);
    void                                      adaptFlipFlop                        ( TLineNumberType lineNumber,
                                                                                     TInt flipFlopWidth,
                                                                                     RefString inputName,
                                                                                     RefString outputName,
                                                                                     RefString clockName,
                                                                                     RefString resetName
                                                                                   );
    void                                      adaptRegisterRegister                ( TLineNumberType lineNumber           ,
                                                                                     NSCSLOm::RefCSLOmUnitDecl unitDecl   ,
                                                                                     TBool           hasSet               ,
                                                                                     TBool           hasNegOutput         ,
                                                                                     RefString       stRegName            ,
                                                                                     RefString       clockName            ,
                                                                                     RefString       inputName            ,
                                                                                     RefString       outputName           ,
                                                                                     RefString       resetName            ,                                                                                     
                                                                                     RefString       enableName           ,
                                                                                     RefString       negOutputName = RefString(),
                                                                                     RefString       setName       = RefString());
    void                                      adaptMultiplexor                     ( TLineNumberType lineNumber,
                                                                                     TInt nrOfSelectBits,
                                                                                     RefString outputName,
                                                                                     NSCdom::RefTVec_RefCDOmExpr inputs,
                                                                                     NSCdom::RefTVec_RefCDOmExpr selects
                                                                                     );
    void                                      adaptAssign                          ( TInt lineNumber,
                                                                                     NSCdom::RefCDOmExpr left,
                                                                                     NSCdom::RefCDOmExpr right
                                                                                     );
    NSCdom::RefCDOmModuleDecl                 retrieveModuleFromInstance           ( NSCdom::RefCDOmModuleOrUdpInstance instance);
    void                                      adaptDutOutputsExpectOutputsCompare  ( TInt lineNumber,
                                                                                     RefString clockName,
                                                                                     RefString resetName,
                                                                                     RefString validName,
                                                                                     RefString dutName,
                                                                                     RefString expectName,
                                                                                     RefTVec_RefString dutOuts,
                                                                                     RefTVec_RefString expectOuts,
                                                                                     RefString countName,
                                                                                     TBool matchOrMismatch,
                                                                                     RefString transactionCountName,
                                                                                     RefString addrWidthParamName,
                                                                                     RefString maxErrParamName = RefString()
                                                                                     );
    void                                      adaptTestbenchParameters             ( TLineNumberType lineNumber,
                                                                                     NSCSLOm::RefCSLOmUnitDecl cslVector
                                                                                   );
    NSCdom::RefCDOmModuleOrUdpInstance        adaptTestbenchParameterConnections   ( TLineNumberType lineNumber,
                                                                                     NSCdom::RefCDOmModuleOrUdpInstance dutInstance,
                                                                                     NSCSLOm::RefCSLOmUnitDecl cslVector
                                                                                   );
    void                                      adaptUnitRegistersEnableLogicModule  ( const NSCSLOm::RefCSLOmUnitDecl unitDecl,
                                                                                     RefString memMapModuleName
                                                                                   );
    void                                      adaptMemoryMapForUnitRegisters       ( const NSCSLOm::RefCSLOmUnitDecl unitDecl,
                                                                                     RefString unitRegistersEnableLogicModuleName
                                                                                   );
    void                                      generateDecoderFromVerilogSignal     ( TLineNumberType lineNumber,
                                                                                     RefString decInputName,
                                                                                     RefString decOutputName,
                                                                                     RefString clockName,
                                                                                     RefString resetName,
                                                                                     RefString decEnName = RefString()
                                                                                   );
    NSCdom::RefTVec_RefCDOmStmt                       generatePieceWiseLinearWaveForms     ( TLineNumberType lineNumber, 
                                                                                             RefString signalName, 
                                                                                             TInt initValue, 
                                                                                             std::map<TInt, TInt> waves );
    NSCdom::RefTVec_RefCDOmStmt                       generateFsdbOrVsd                   ( TLineNumberType lineNumber,
                                                                                            RefString tbName,
                                                                                            RefString outputFileName,
                                                                                            NSCSLOm::CSLOmTBInfo::ETBWaveType  waveType,
                                                                                            NSCdom::RefCDOmExprLink scope = NSCdom::RefCDOmExprLink()
                                                                                            );
    void                                              generateInitialVectorMemDisplay      ( TLineNumberType lineNumber,
                                                                                             RefString memLoadName,
                                                                                             RefString memName,
                                                                                             RefString vectorParamName,
                                                                                             RefString memDepthName,
                                                                                             RefString memAddrIterName
                                                                                             );
    //at call point check if the select signal is wide enough for all the mox inputs
    /**
      * This function is called inside the afterTraversal() function for CSLOmSignal
      * and it handles the particular case when a signal is set to generate a decoder.
      * That is possible only when that signal has a field set. The width of that field
      * indicates the maximum number of decoder outputs. If the field width is 4, the 
      * decoder may have maximum 2^4 = 16 outputs.
      * 
      * There are three cases to consider:
      * 1.An enum was set for the field and random values have been attributed to its items. 
      *   The enum item name points out what decoder 
      *   output will be activated if the input signal value equals the enum item value.
      *   csl example:
      *   csl_enum e {
      *      RD = 5  ,
      *      WR   ,
      *      PING  ,
      *      EN
      *    };

      *    csl_unit a {
      *      csl_signal s1;
      *      csl_field f;
      *      a() {
      *        f.set_width(4);
      *        f.set_enum(e);
      *        s1.set_bitrange(f);
      *        s1.gen_decoder();
      *      }
      *    };
      *   <include generated verilog code here>   
      *   If the decoder input s1 equals 7, the ping decoder output shall be activated and so on.
      *   This case is handled by the adaptDecoderForRandomEnum() function.
      * 2.An enum was set for the field and sequential values have been attributed to its items.
      *   The example from before is the same save for the enum, which looks as follows:      
      *   csl_enum e {
      *      RD   ,
      *      WR   ,
      *      PING  ,
      *      EN
      *    };
      *   The autoincrement mechanism(just like for the C++ enum) will associate consecutive
      *   values to the members of the enum.
      *   This case is handled by the adaptDecoderForSeqEnum() method.
      * 3.No enum was set for the field.
      *   This case is handled by the adaptDecoderForNoEnum() method.
      */
    void adaptDecoder( const NSCSLOm::RefCSLOmSignal &signal);
    /**
      * Look at the decoder example for case 2 in the adaptDecoder() comment.
      * The adapter turns the CSLOM subtree had holds it into a CDOM concat
      * assign as follows:
      * <insert verilog output here>
      */
    void adaptDecoderForSeqEnum( const NSCSLOm::RefCSLOmSignal &signal, double outputWidth);
    
    /** Look at the decoder example for case 1 in the adaptDecoder() comment.
      * The adapter turns the CSLOM subtree that holds it into a CDOM case 
      * statement as follows:
      * <insert verilog code here>
      */
    void adaptDecoderForRandomEnum( const NSCSLOm::RefCSLOmSignal &signal);
    /**
      * Look at the decoder example for case 3 in the adaptDecoder() comment.
      * The adapter turns the CSLOM subtree that holds it into a CDOM shift
      * statement as follows:
      * <insert verilog code here>
      */
    void adaptDecoderForNoEnum( const NSCSLOm::RefCSLOmSignal &signal, double outputWidth);

    /**
      * This function is called inside the afterTraversal() 
      * method for unitDecl and deals with transforming a unit of type fifo into a
      * complicated verilog fifo module.
      * Let's consider two typical csl examples for fifo and follow the
      * csl input -> cslom -> adapter ->cdom output flow.
      * Example1: 
      * csl_fifo a {
      *   a() {
      *     set_width(8);
      *     set_depth(32);
      *   }
      * }
      * 1. The user did not specify any ports for the fifo
      *   (the set_width() and set_depth() function calls are mandatory), yet a fifo
      *   module cannot function without a number of manadatory ports, as
      *   follows: push, pop, full, empty, dataIn(aka wrData), dataOut(aka rdData), clock, reset and valid.
      *   Therefore, cslom will automatically build those ports, with 
      *   standard names, and insert them into a map (CSLOmFifoInfo::m_portMap)
      *   in pairs of the following type: <FIFO_PN_PUSH, pushCslPortDecl> and so on.
      * 2. This function, adaptFifoModule(), is called inside the afterTraversal()
      *   for unitDecl, meaning that all of those mandatory ports have already
      *   been visited, adapted, and included in the cdom tree.
      *   Ergo, at this point, the adapter has already built a map of its own
      *   (CAdapterToCDOM::m_cdomUnitPorts), the cdom replica of the cslom one.
      *   To be more specific, that map was created in the afterTraversal()
      *   method for portDecl, and it contains pairs of type <FIFO_PUSH, pushCdomPortDecl>, etc. 
      * 3. That brings us(finally) to our function, adaptFifoModule(). Its job is to iterate
      *   through the m_cdomUnitPorts map and extract the name of each port.
      *   In this case, the names will be standard ones, cslom-generated, 
      *   as the user did not specify any particular ones.
      *   With these names, the adapter builds the always blocks that deal with the 
      *   four main parts of a fifo:
      *   a. the wrAddr counter
      *   b. the rdAddr counter
      *   c. the full/empty comparator
      *   d. the memory block
      *   %insert fifo picture here%
      * 4. To sum up, this method performs three tasks:
      *   a. iterates through the m_cdomUnitPorts map and extracts the names(standard ones in this case)
      *     of the mandatory fifo ports
      *   b. builds the fifo internal signals: wrAddr, rdAddr, rdEn, wrEn, fullOrEmpty, mem
      *   c. calls three other methods that create the always block subtrees for the two 
      *     counters and the comparator.
      *   One more observation:
      *     The memory block is separated from the fifo module(see adaptMemoryModule()); 
      *   its functions are implemented by a distinct module that is instantiated 
      *   inside the fifo. The reason for this
      *   is explained in the afterTraversal() for unitDecl comment.
      * The verilog generated code for the csl example above follows:
      * %insert verilog code for fifo here%
      *
      * Example2:
      * csl_fifo a {
      *   a() {
      *     set_width(8);
      *     set_depth(32);
      *     set_push(myOwnPushPort);
      *     set_pop(myOwnPopPort);
      *   }
      * }
      * The steps above stay the same, but this time the names of the push
      * and pop ports are not automatically generated by cslom, so the pairs in the m_portMap
      * look as follows: <FIFO_PN_PUSH, pushPortNamedMyOwnPushPort>, and the same 
      * for pop. The other mandatory ports have standard names just as before.
      * In the generated verilog code, nothing changes but the push and pop port names:
      * %insert generated verilog code here%
      * 
      */
    void adaptFifoModule( const NSCSLOm::RefCSLOmUnitDecl &unitDecl, RefString fifoMemName);
    /**
      * This function is called(twice) from inside the adaptFifoModule() method and
      * it models the functionality of the counter that outputs the rdAddr fifo
      * internal signal(first call) and of the counter that outputs the wrAddr
      * fifo internal signal(second call). The root nodes for the cdom subtrees 
      * included in the cdom hierarchy are of type CDOmInitOrAlways(always blocks). 
      */
    void adaptCounter( TInt unitLineNumber,
                       RefString clockName, 
                       RefString resetName, 
                       RefString countValName, 
                       RefString countEnName, 
                       RefString zeroName,
                       NSCdom::RefTVec_RefCDOmStmtAssn supplementaryAssns = NSCdom::RefTVec_RefCDOmStmtAssn(new NSCdom::TVec_RefCDOmStmtAssn()),
                       NSCdom::RefCDOmPortDecl countInitVal = NSCdom::RefCDOmPortDecl()
                       //TInt highWaterMark = 0,
                       //TInt lowWaterMark = 0
                    );
    /**
      * This method is called from inside the adaptFifoModule() method.
      * It computes the values of the full and empty fifo internal signals.
      * That is accomplished by creating two CDOmAssign nodes in the cdom tree.
      */
    void adaptCompare( TInt lineNumber, 
                       RefString inputName1, 
                       RefString inputName2,
                       RefString outputName, 
                       RefString clockName, 
                       RefString resetName
                      );
    /**
      * This method is called(twice) from inside the adaptFifoModule() method.
      * It models the functionality of the AND gate that outputs 
      * the rdEn fifo internal signal(first call) and the AND gate that outputs 
      * the wrEn fifo internal signal(second call). The two nodes included in the 
      * cdom tree are CDOmAssign.
      */
    void adaptAndGate ( TInt lineNumber, 
                        RefString input1Name, 
                        RefString input2Name, 
                        RefString resultName,
                        RefString clockName,
                        RefString resetName,
                        TInt negate = 0
                      );

    /**
      * This method implements a memory block. It is called from 
      * inside the adaptFifoModule() and adaptRegisterFileModule()
      * methods, and any other method modelling a module that 
      * requires a memory.
      * It deals with creating the memory ports and internal signals;
      * the actual always block that describes the memory functionality
      * is implemented in the adaptMemory() function, called by 
      * this method.
      * So, it starts out by creating the memory ports. 
      * The first ones are also to be found among the ports of the module
      * that uses the memory(in this case the fifo module):
      * clock, reset, wrData, rdData, valid.
      * Next, come wrAddr, rdAdrr, wrEn, rdEn, which are internal signals
      * for the fifo module, but they become input ports for the memory.
      * (see the fifo figure)
      * And last, there is the one and only memory internal signal, mem.
      * That is the actual reg that holds the memory information.
      * As an implementation datail: only the memory ports that coincide
      * with the fifo ports(clock, reset, wrData, rdData, valid) are 
      * extracted from the m_cdomUnitPorts map, because they are the
      * only ones the user has access to(by name). All the others,
      * are either fifo internal signals or memory internal signals,
      * and have standard names that the adapter generates, thus there
      * is no need to store them in a map.
      *
      * The last part of the function deals with the call of adaptMemory(),
      * so read that comment next.
      */
    void adaptMemoryModule( const NSCSLOm::RefCSLOmUnitDecl &unitDecl);
    /**
      * Let's start with an adapter naming convention. 
      * A module in verilog can be splitted into two parts:
      * 1. the interface (ports) + internal signals
      * 2. the functionality(always blocks)
      * The adapter functions that deal with the first 
      * part are named adaptXYZModule()(XYZ is the name of the module,
      * like fifo, or regFile or memory),
      * as the ones that deal with the second part, are called
      * adaptXYZ()(XYZ is the name of the functional block, like
      * counter or comparator or memory).
      * Having said that, the difference between adaptMemoryModule()
      * and adaptMemory() should be clear.
      * If you take a look at the code for this function, tou'll notice that 
      * all it does is insert a CDOmInitOrAlways node(and all its children)
      * in the CDOM tree.
      */
    void adaptMemory (TInt lineNumber,
                      RefString clock,
                      RefString reset,
                      RefString rdAddr,
                      RefString rdEnable,
                      RefString rdData,
                      RefString mem,
                      RefString wrAddr  = RefString(),
                      RefString wrEn    = RefString(),
                      RefString wrData  = RefString(),
                      RefString valid   = RefString(),
                      RefString rdEnS   = RefString(),
                      RefString rdDataS = RefString(),
                      RefString rdAddrS = RefString()
 
                    
                    );
    
    
    /**
      * A register file is a module that wraps a memory module. 
      * Unlike a fifo it does not have comparators or counters.
      * Therefore connectables like wrAddr or rdAddr there were
      * internal signals in a fifo module, are ports in a regFile module.
      * This is important, because the user has control over the port names,
      * whereas the signal names are automatically generated by the Adapter.
      * Because of that, the cslom port map for register file(CSLOmRegisterFileInfo::m_portNames)
      * will also include the following pairs: <RF_PN_WR_ADDR, wrAddrPortDecl>, <RF_PN_RD_ADDR, rdAddrPortDecl>.
      * Why is this necessary? Because there is no other way for the Adapter to retrieve the names the 
      * user chooses for the ports, and then pass them on to the verilog code generator
      * in order to produce a consistend verilog output.
      *
      * At this point it should be easy to understand why some of the fifo internal signals
      * are register file ports. Here's the complete list of all regFile ports:
      * clock, reset, dataIn,  dataOut, valid (similar to fifo ports), wrAddr, 
      * rdAddr, wrEn, rdEn (fifo internal signals). Of course there is no need for full or empty
      * ports as they are specific to a fifo module.
      *
      * These ports are included in the m_cdomUnitPorts map, after having been converted to
      * cdom ports in the afterTraversal() method for CSLOmPortDecl(similar to fifo ports).
      * Although there are two separate maps in the CSLOM for the fifo ports and for the 
      * regiater file ports(as there are two separate classes: one for fifo and one for regFile)
      * there is only one map in the Adapter(m_cdomUnitPorts) which stores all the ports and their types.
      *
      * As there are no internal signals to create, the only role of this method is 
      * instantiate the memory module. The actual creation of the memory module falls undr the
      * responsability of the adaptMemoryModule() and adaptMemory() methods.
      *
      * The verilog output would very much resemble the fifo verilog output minus the
      * two assigns for the comparator, the other two assigns for the AND gates, and the
      * two always blocks for the counters, because a regfile doesn't implement such functions.
      * That pretty much leavs us with the memory instantiation alone.
      */
    void adaptRegisterFileModule( const NSCSLOm::RefCSLOmUnitDecl &unitDecl, 
                                  RefString regFileMemName
                                );
    //void adaptValid( NSCdom::RefCDOmPortDecl clock, NSCdom::RefCDOmPortDecl reset, NSCdom::RefCDOmPortDecl rdEnable );
    /**
     * 
     */
    void adaptTestbenchModule(NSCSLOm::RefCSLOmUnitDecl unitDecl);
    void adaptVectorModule(NSCSLOm::RefCSLOmUnitDecl unitDecl);

      public:
    /**
      * The CAdapterToCDOM class is derived from the abstract class CVisitorTraversal (see CSLOM_Visitor.h)
      * It implements all its pure virtual functions which can basically be divided
      * in three main groups: before, in, and after methods.
      *
      * The before methods are used to build CDOm objects that do not require
      * other tree nodes to be previously visited. Basically the CDOM objects that don't take
      * their own children as build parameters are constructed in the before functions.
      * One example is moduleDecl. The build function for moduleDecl requires only two params:
      * the lineNumber and the parent node(design). Therefore this object can be completely constucted
      * in the beforeTraversal method.
      *
      * Other CDOM objects require one or more of their own children as build function params.
      * Such an object is unitInstantiation. Although the first 2 params pose no problems(lineNumber and
      * parent node), the third param is an exprLink. The exprLink is the child of the unitInstantiation.
      * So, when transforming the csl unitInstantiation object into a cdom moduleInstantiation object,
      * the exprLink has to be previously visited. Considering that the inTraversal method is called 
      * after each cdom child has been completely built( see CSLOM_Visitor.h), the next logical step 
      * is to use it to build the moduleInstantiation. 
      *
      * There is another type of cdom objects: the ones which require more or all of their children to be 
      * built before they themselves can be constructed. In such a situation, it would be fairly
      * complicated to build them in the inTraversal method(would require use of many boolean flags
      * and complicated logic). Instead the inTraversal method is only used to store the adapted children;
      * the actual construction of the parent takes place in the afterTraversal method which is
      * called, as its name suggests, after all the current children have been succesfully built.
      * Such is the case of the csl bitrange object. In the inTraversal method all the cdom equivalents
      * of its children are stored in a vector(m_cslTraversedChildren) and used to build the cdom 
      * range or rangeExpr objects in the afterTraversal function.
      */
    CAdapterToCDOM( NSCdom::RefCDOmDesign );
    NSCdom::RefCDOmDesign getProduct();
    
    void beforeTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      );
    /**
     * Builds the cdom design, if it doesn't already exist.
     * Signals a warning if the cslom design has no children.
     * Sets the csl current parent( csl design) and the cdom current parent( cdom design).
     */
    void beforeTraversal(const NSCSLOm::RefCSLOmDesign      & design      );
    /**
     * The csl identifier is sent on to other adapter functions that might need it
     * (like the before, in and after traversal methods for enum) via the m_cslReturnedValue.
     * The csl id is not specifically turned into a cdom id node, because the CDOmIdentifier
     * build function is private(all cdom objects build their own identifier inside their build functions). 
     */
    void beforeTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        );
    /**
      * Checks if the csl parent of the unit is the csl design
      * and if the cdom parent is the cdom design.
      * Builds the cdom module declaration. 
      * Stores the unit prefix(if it exists) into m_unitPrefix.
      * All the signals, ports and interfaces inside the unit
      * will be prepended with it.
      * Sets the csl current parent( csl unit declaration) 
      * and the cdom current parent( cdom module declaration).
      *
      * A unit declaration is a sort of a generic container.
      * Depending on the type set by the user, this container 
      * turns into a particular module in verilog
      * (fifo module, regfile module, etc.).
      * There is an info class for every single type of fifo 
      * (CSLOmFifoInfo, CSLOmRegisterFileInfo, etc.).
      * That class stores a map containing pairs of 
      * the following type: <EXyzPortNames, portDecl>, Xyz = {Fifo, RegisterFile, etc.}.
      * These pairs represent connections between the standard ports 
      * that should always be in a fifo(stored in the enum) and the names the 
      * user chooses to give them. For example, no fifo can function without 
      * a push input port. If the user decides to name his fifo's push port 
      * abc, then the pair <FIFO_PN_PUSH, portDecl_named_abc> gets inserted into the map.
      * This map is stored for further adapter use in m_cslXyzPorts class member.
      */
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        );
    /**
      * Checks if the csl current parent is a unit or a group of signals
      * and if the cdom current parent is a module.
      * Sets the csl current parent(signal).
      */
    void beforeTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          );
    /**
      * Checks if the csl and cdom current parents are of the proper types
      * (unitInstantiation and moduleInstantiation).
      * Builds the moduleInstance object using the cdomCurrentParent.
      * Sets the csl and cdom current parents (unitInstance and moduleInstance).
      * 
      * This is also the place to handle the formal to actual mapping.
      *
      * Example: 
      * 
      * csl_unit b {
      *   csl_port x(input);
      *   csl_port y(output);
      *   b() {}
      * }
      * csl_unit a {
      *   csl_port m(input);
      *   csl_port n(output);
      *   b b0(.x(m), .y(n)));
      *
      *   a() {}
      * }
      * This is a simple case of formal to actual mapping.
      * Focus on the last line. Ports x and y of unit b are connected to
      * ports m and n of unit a via the instance of unit b, b0.
      * x and y are formals while m and n are actuals, thus the name of the process.
      * Now, let's browse through the hidden implementation that makes all this happen.
      * The CSLOmUnitInstance class provides a map containing pairs of the following type:
      * (exprLink, exprLink).  That map contains the
      * connections between the ports of the two units (a and b).
      * In this case it looks something like this:
      * ((exprLinkTox, exprLinkTom), (exprLinkToy, exprLinkTon))
      *
      * Each of the two exprLinks in each pair inside the map is transformed as follows:
      * The first one becomes a CDOmExpr(formal) and the second one a string(actual).
      * Now that the type match is assured, the transformed pairs can be inserted in the
      * cdom map containing pairs of type (expr, string) inside the CDOmUnitOrUdpInstantiation class.
      * This operation is performed by the adaptPortOrSignalConnection method, so see that comment next.
      *
      * However, formal to actual mapping can get a little more complicated than that.
      * A connection pair may also contain any of the 4 possible combinations of signal groups and interfaces.
      * If this is the case, all the signals/ports inside the signal groups/interfaces in the connection pair,
      * will be connected recursively. The mechanism behind this recursive connection is explained in the
      * adaptInterfaceOrSignalGroupConnection method.
      *
      * After all possible connections have been attemted, the adapter tests whether the cdom connection map is empty.
      * If so, that means that none of the requirements for a legal collection have been met, in other words, the csl 
      * formal to actual map contains pairs of incompatible connectables. The adapter 
      * does not throw an exception in such a case, it simply does not propagate the illegal connection to cdom.
      * So, the cdom connection map might end up empty. In this situation, the adapter inserts an emty pair into the map, 
      * so that the verilog codegen would generate the proper output.
      */
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        );
    /**
      * Simple bitranges in csl store the widths of csl signals or ports.
      * A simple bitrange can be the child of the design(global simple bitrange), 
      * a signal node, a port node,
      * another bitrange node(a bitrange with other bitranges for chilren is called multidimensional),
      * or an exprLink node(a csl bitrange that has an expr for a parent will be transformed
      * into a verilog range expression).
      * The cdom equivalent of a csl simple bitrange is a verilog range/rangeExpr. The only legal 
      * parents for such nodes are verilog ports and verilog signals(nets/vars).
      * However, as the cdom nets/vars and cdom ports are build in the afterTraversal methods for
      * csl signal and csl port, a type check on the m_cdomCurrParent is impossible at this time.
      */
    void beforeTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  );
    void beforeTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                );
    void beforeTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           );
    /**
      * There are two ways of dealing with a group of signals in the adapter.
      * If the genarateIndividualRTLSignals option is on, then all the signals in the group
      * will be adapted to cdom according to the rules and that's it.
      * If the generateIndividulaRTLSignals option is off, then, 
      * there will be only one signal in the cdom output with a bitrange that equals the sum
      * of the bitranges of all the signals in the group.
      * example:
      * csl input:
      *   csl_unit u;
      *   csl_signal a(1);
      *   csl_signal b([5:3]);
      *   csl_signal c(8);
      *   scope u {
      *     csl_signal_group g(a, b, c);
      *     g.generate_individual_rtl_signals(off);
      *   }
      * verilog output:                                    
      *   module u();
      *     wire [11:0] g;
      *   endmodule
      * If such is the case(as in the example above), the m_generateIndividualSignals flag
      * is set to false to facilitate the adapter logic in the function for num32
      * (that deals with adding the bitranges).
      * 
      * The csl current parent is set to group_signal.
      */
    void beforeTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     );
    /**
      * There are two cases to consider when it comes to adapting num32.
      * 1.The second one is the simplest. Its dealt with in the else branch at the 
      *   end of the function. Basically, the transformation from cslom num32
      *   to cdom num32 id direct, no strings attached.
      * 2.The tricky situation is the one implemented in the first if.
      *   When a number is the child of a bitrange and that bitrange 
      *   belongs to a signal inside a group, and on top of that the 
      *   generateRTLIndividualSignals option is off, the adapter logic     
      *   gets a lot more complicated.
      *   Let's take this one step at a time:
      *   When the generateRTLIndividualSignals option is off, that means that all the signals 
      *   inside the group(in cslom) have to be transformed into only one signal in cdom.
      *   That cdom signal's bitrange is the sum of all the csl signals' bitranges.
      *   example:
      *     csl_signal a([4:1]), b(8), c(16);
      *     csl_signal_group g(a, b, c);
      *     g.generate_RTL_individual_signals(off);
      *   The generated cdom output will contain 3 signals a,b,c plus 
      *   a cumulated signal g with the bitrange of [27:0].
      *   In order to do this, I've implemented three adapter class members:
      *   m_num32Offset, m_num32FirstExpr and m_num32SecondExpr which start out with a zero value.
      *   So, when the first bitrange is visited(br of signal a [3:0]), 
      *   m_num32FirstExpr is incremented with 3, and m_num32SecondExpr is incremented with 1.
      *   Then the bitrange for signal b is visited and 
      *   m_num32FirstExpr is incremented with 7 (3+7 = 10).
      *   Finally, when the third bitrange(for signal c) is visited, m_num32FirstExpr becomes 25(10+15).
      *   The reason why I add 1 to m_num32FirstExpr every time I increment it is that the width of a signal
      *   is computed according to the formula: width = upper_index-lower_index+1;
      *   
      * In the end, the m_num32FirstExpr stores the sum of all upper indexes and m_num32SecondExpr
      * the sum of all lower indexes.
      * 
      * One more thing: In order to compute those sums properly, I make use pf three flags:
      * m_firstCallOfNum32BT, m_secondCallOfNum32BT, m_thirdCallOfNum32BT.
      * This garantees that whenever a num32 is traversed, the correct class member's value gets incremented.
      */
    void beforeTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          );
    void beforeTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         );
    void beforeTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       );
    /**
      * Checks if the csl parent of the unit instantiation is a unit 
      * and if the cdom parent is a module.
      * Sets the csl current parent (csl unit instantiation).
      *
      * The moduleOrUdpInstantiation object cannot be built 
      * at this point because its build function requires 
      * a cdom exprLink. That cdom exprLink is the cdom equivalent
      * of the first child of the csl unit instantiation,
      * which is, of course, a csl exprLink.
      * Therefore, the construction of the moduleOrUdpInstantiation
      * object will take place in the inTraversal method, after
      * the first child has been visited.
      * To serve this purpose, the inTraversalForUnitInstantiation
      * flag is set to zero.
      */
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               );
    /**
      * Performes the usual checks. The cdom parent must be a module
      * and the csl parent must be an interface.
      * Sets the csl current paremt to csl port.
      * As the port needs a bitrange, the actual construction of the
      * corresponding cdom portItem and portDecl will be performed in
      * the afterTraversal method.
      */
    void beforeTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 );
    void beforeTraversal(const NSCSLOm::RefCSLOmList                            & list                            );  
    //void beforeTraversal(const NSCSLOm::RefCSLOmSetCommand                      & setCommand                      );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetWidth                     & cmdSetWidth                     ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetBitRange                  & cmdSetBitRange                  ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetOffset                    & cmdSetOffset                    ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetLowerIndex                & cmdSetLowerIndex                ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetUpperIndex                & cmdSetUpperIndex                ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetRange                     & cmdSetRange                     ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetNumberOfDimensions        & cmdSetNumberOfDimensions        ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimWidth                  & cmdSetDimWidth                  ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimBitRange               & cmdSetDimBitRange               ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimOffset                 & cmdSetDimOffset                 ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimLowerIndex             & cmdSetDimLowerIndex             ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimUpperIndex             & cmdSetDimUpperIndex             ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetDimRange                  & cmdSetDimRange                  ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetUnitPrefix                & cmdSetUnitPrefix                ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefix              & cmdSetSignalPrefix              ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefixLocal         & cmdSetSignalPrefixLocal         ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetType                      & cmdSetType                      ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetAttr                      & cmdSetAttr                      ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdAddInstance                  & cmdAddInstance                  ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdAddInstanceList              & cmdAddInstanceList              ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdAddSignal                    & cmdAddSignal                    ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdAddSignalList                & cmdAddSignalList                ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdAddSignalGroup               & cmdAddSignalGroup               );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdAddPort                      & cmdAddPort                      );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdAddPortList                  & cmdAddPortList                  );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignal                 & cmdRemoveSignal                 );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignalList             & cmdRemoveSignalList             );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdRemovePort                   & cmdRemovePort                   );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdRemovePortList               & cmdRemovePortList               ); 
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdSetInstanceAlterationBit     & cmdSetInstanceAlterationBit     );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdGenerateIndividualRTLSignals & cmdGenerateIndividualRTLSignals );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdAddInterface                 & cmdAddInterface                 );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdAddUnitParameter             & cmdAddUnitParameter             );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdOverrideUnitParameter        & cmdOverrideUnitParameter        );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdInputVerilogType             & cmdInputVerilogType             );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdOutputVerilogType            & cmdOutputVerilogType            );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdReverse                      & cmdReverse                      );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdConnect                      & cmdConnect                      );
    //void beforeTraversal(const NSCSLOm::RefCSLOmCmdConnectSplit                 & cmdConnectSplit                 );
    void beforeTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            );
    void beforeTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               );
    //    void beforeTraversal(const NSCSLOm::RefCSLOmTestbenchDecl                   & testbenchDecl                   );
    //    void beforeTraversal(const NSCSLOm::RefCSLOmTestbenchVector                 & testbenchVector                 );
    //    void beforeTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               );
    void beforeTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     );
    /**
      * A cslom field is a sort of an enhanced bitrange. It has all the attributes of
      * a bitrange, plus it can be hierarchical (this will come in handy at ISA)
      * In the beforeTraversal() method, I simply build the cdom equivalent
      * of the field's range and pass it on to the other adapter methods(like adaptDecoder())
      * via the m_cdomReturnedValue class member.
      */
    void beforeTraversal(const NSCSLOm::RefCSLOmField                           & field                           );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           );
    void beforeTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       );
    void beforeTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        );
    void beforeTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      );
    void beforeTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      ); 
    void beforeTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {}    
    void beforeTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {}
    void beforeTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {}    
    void beforeTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {}    

    void inTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      );
    void inTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          );
    void inTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void inTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        );
    void inTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        );
    void inTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          );
    void inTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        );
    /**
      * Bitrange is, by far, the most complicated to adapt to CDOM.
      * Therefore some preliminary background is necessary.
      * There are three types of bitranges:
      * 1.simple : the most usual
      *   example: csl_bitrange br (7,0);
      * 2.multidimensional
      *   example: csl_bitrange br;
      *            br.set_number_of_dimensions(2);
      *            br.set_dim_width(0, 7);
      *            br.set_dim_width(1, 15);
      * 3.dimension : They are the children of the multidim bitrange.
      *               Considering the example above they are the two widths.
      *               They resemble simple bitranges except one thing:
      *               they don't have an id as the first child.
      *
      * The role of the inTraversal method is to store the three expr children
      * (adapted to cdom) of the csl bitrange.
      * This must be done ONLY for the simple bitrange and the dimension bitrange
      * as they are the only ones which have expr children. The multidim bitrange
      * has other bitranges for children.
      * The condition above is reflected by the two branches of the or inside the if clause.
      * There is one extra flag used in the first branch of the or: m_firstCallOfBitRangeIT.
      * Its meaning is to guarantee that the id(the first child of the simple bitrange)
      * does not get included into the children vector.
      * When it comes to the dimension bitrange, that precaution is no linger necessary
      * as such a bitrange has no id.
      *
      * See what the m_generateIndividualSignals flag is about in the comment
      * for csl signal group.
      */
   
    /**
      * The adapter turns a csl simple bitrange into a verilog range/rangeExpr. The build function
      * for a cdom range/rangeExpr node requires three parameters:the line number, the lower range
      * index and the upper range index. These last two parameters are csl expressions(numbers), more exactly,
      * they are children nr 3 and 4 of the csl simple bitrange(child 1 is the id and child 2 is the offset). 
      * So, prior to building the verilog 
      * range/rangeExpr nodes, these two expressions have to be traversed and transformed into verilog expressions.
      * This is the reason why the range/rangeExpr build function call has to be delayed until the afterTraversal 
      * method.
      * The inTraversal method is called after each of the csl bitrange's children nodes 
      * has been visited and its verilog equivalent has been built.
      * The first call of the inTraversal method takes place after the bitrange's id has been visited.
      * As this node has no part in building the cdom range/rangeExpr nodes
      * it will be ignored. That is the meaning of the m_simpleBitRangeIT flag. 
      * The next csl bitrange child is a csl expression(number) called offset. After turning it into a cdom number,
      * (in the three visit functions for the number node) the inTraversal method for simpleBitrange gets called again. 
      * The cdom number built from the csl offset is accessible via the m_cdomReturnedValue global variable.
      * Because this node is relevant in the constuction of the verilog range/rangeExpr, it will be stored in a global
      * vector called m_cdomTraversedChildren for later use in the afterTraversal method.
      * The same thing happens to the verilog equivalents of the lower and upper expression nodes(children nr 3 and 4,if set).
      * The lower and upper expressions are actually optional. If the user does not set them, 
      * they will be initialized with the default value of 0.
      * Therefore at the entry point in the afterTraversal method, the m_cdomTraversedChildren will contain one or three elements:
      * the verilog equivalents of the offset(mandatory, set by the cslom, transparent for the user), lowerExpr(optional) and upperExpr(optional).
      */
    void inTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  );
    void inTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                );
    void inTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           );
    void inTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     );
    void inTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          );
    void inTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         );
    void inTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       );
    /**
      * Builds the cdom moduleOrUdpInstantiation, via the
      * m_cdomReturnedValue which stores the return value of the
      * afterTraversal method for CSLOmExprLink( see comment
      * for that method ). 
      * Sets the cdom current parent(moduleOrUdpInstantiation).
      * The m_inTraversalForUnitInstantiation flag, initially zero,
      * is incremented to insure that the moduleOrUdpInstantiation
      * is built only once( after the visit of the first child of 
      * the unit instantiation ).
      */
    void inTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               );
    void inTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        );
    void inTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          );
    void inTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      );
    void inTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 );
    void inTraversal(const NSCSLOm::RefCSLOmList                            & list                            );  
    //void inTraversal(const NSCSLOm::RefCSLOmSetCommand                      & setCommand                      );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetWidth                     & cmdSetWidth                     ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetBitRange                  & cmdSetBitRange                  ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetOffset                    & cmdSetOffset                    ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetLowerIndex                & cmdSetLowerIndex                ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetUpperIndex                & cmdSetUpperIndex                ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetRange                     & cmdSetRange                     ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetNumberOfDimensions        & cmdSetNumberOfDimensions        ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetDimWidth                  & cmdSetDimWidth                  ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetDimBitRange               & cmdSetDimBitRange               ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetDimOffset                 & cmdSetDimOffset                 ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetDimLowerIndex             & cmdSetDimLowerIndex             ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetDimUpperIndex             & cmdSetDimUpperIndex             ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetDimRange                  & cmdSetDimRange                  ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetUnitPrefix                & cmdSetUnitPrefix                ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefix              & cmdSetSignalPrefix              ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefixLocal         & cmdSetSignalPrefixLocal         ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetType                      & cmdSetType                      ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetAttr                      & cmdSetAttr                      ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdAddInstance                  & cmdAddInstance                  ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdAddInstanceList              & cmdAddInstanceList              ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdAddSignal                    & cmdAddSignal                    ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdAddSignalList                & cmdAddSignalList                ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdAddSignalGroup               & cmdAddSignalGroup               );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdAddPort                      & cmdAddPort                      );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdAddPortList                  & cmdAddPortList                  );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignal                 & cmdRemoveSignal                 );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignalList             & cmdRemoveSignalList             );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdRemovePort                   & cmdRemovePort                   );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdRemovePortList               & cmdRemovePortList               ); 
    //void inTraversal(const NSCSLOm::RefCSLOmCmdSetInstanceAlterationBit     & cmdSetInstanceAlterationBit     );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdGenerateIndividualRTLSignals & cmdGenerateIndividualRTLSignals );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdAddInterface                 & cmdAddInterface                 );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdAddUnitParameter             & cmdAddUnitParameter             );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdOverrideUnitParameter        & cmdOverrideUnitParameter        );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdInputVerilogType             & cmdInputVerilogType             );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdOutputVerilogType            & cmdOutputVerilogType            );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdReverse                      & cmdReverse                      );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdConnect                      & cmdConnect                      );
    //void inTraversal(const NSCSLOm::RefCSLOmCmdConnectSplit                 & cmdConnectSplit                 );
    void inTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       );
    void inTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        );
    void inTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            );
    void inTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               );
    //    void inTraversal(const NSCSLOm::RefCSLOmTestbenchDecl                   & testbenchDecl                   );
    //    void inTraversal(const NSCSLOm::RefCSLOmTestbenchVector                 & testbenchVector                 );
    //    void inTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               );
    /**
      * A CSLOmEnum node's children are identifiers. The first stands for the enum name,
      * the others for the enum items' names. Each of the identifiers in the latter cathegory
      * holds a payload that stands for the enum items' values. As this is the inTraversal()
      * method, its code will be executed after each of the identifiers above has been
      * visited and transformed into a cdom id.
      * After the first enum child(enum name) has been visited, the string it contains is 
      * copied to a CAdapterToCDOM class member called m_enumName. This will be used to
      * prefix the names of the decoder output signals in the adaptDecoder() methods.
      * All the other identifiers are used to create one cdom define node for each 
      * enum item. 
      * The m_enumItemVal CAdapterToCDOM class member is used to implement the
      * C++ like autoincrement mechanism specific to enums.
      */
    void inTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     );
    void inTraversal(const NSCSLOm::RefCSLOmField                           & field                           );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       );
    void inTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           );
    void inTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       );
    void inTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        );
    void inTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      );
    void inTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {}
    void inTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      );
    void inTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {}
    void inTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {}    
    void inTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {}
    void inTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {}
    void inTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {}    
    void inTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {}    

    void afterTraversal(const NSCSLOm::RefCSLOmInclude      & fileInclude      );
    void afterTraversal(const NSCSLOm::RefCSLOmDesign                          & design                          );
    void afterTraversal(const NSCSLOm::RefCSLOmIdentifier                      & id                              );
    void afterTraversal(const NSCSLOm::RefCSLOmExprLink                        & exprLink                        );
    /**
      * Restores the csl current parent back to the csl design
      * and the cdom current parent back to the cdom design.
      * This is necessary because a design can be the parent
      * of more than one unit. If the 2 current parents 
      * were not restored, the second unit's parent
      * would be the first unit, which is not correct.
      * csl example:
      *             // the csl current parent is the csl design
      * csl_unit a; 
      *             // the csl current parent is the csl unit a
      * scope a { ... }
      *             // the csl current parent is restored to 
      *             // the csl design, thus making sure that
      *             // the csl unit b gets the proper parent
      * csl_unit b; 
      *             // the csl current parent is the csl unit b
      * scope b { ... }
      *             // the csl current parent is restored to 
      *             // the csl design
      *
      * A unit is like a template in csl. It can have many types.
      * The adapter handles each of them in a different manner,
      * meaning the verilog output is different from case to case.
      * There is an adapter function for each type of unit.
      * If a unit is of type fifo, then the adapter logic in charge with
      * converting it to verilog is to be found inside the adaptFifoModule() method.
      * However, a fifo unit requires a memory module to perform its functions.
      * (See docs about fifo design.)
      * There are two ways of dealing with it: the verilog code handling the memory
      * can be generated within the fifo module, or a new module can be created  
      * to implement the fifo's memory. In the latter case, the memory module has
      * to be instantiated within the fifo module and then its ports have to be connected 
      * to the ones of the fifo module.
      * This second solution is preferable, because a memory can also be considered
      * a template. The same design may contain several fifo units, register
      * file units, and maybe other units that require a memory. It is optimal to code
      * only one memory module for all of the above and then connect it 
      * to each of the mentioned units (instantiate the memory module inside the 
      * unit, and then connect the instance's ports to the unit's ports - formal to
      * actual mapping). The only condition is that all the fifos and registers in a design 
      * must have the same dimmensions in order to instantiate the same meory module.
      * If not, then the memory module's dimensions will also differ, and each fifo and each register
      * will instantiate a memory module of their own.
      * 
      */
    void afterTraversal(const NSCSLOm::RefCSLOmUnitDecl                        & unitDecl                        );
    /**
      * A signal is simple or multidimensional. In the latter case, the verilog
      * output will contain several net/var decls for only one mulidim csl signal.
      * The rule is simple: the first dim of a multidim signal represents the
      *                     range of the verilog net/var and 
      *                     the rest of the dimensions, multiplied, signify the number
      *                     of the verilog generated nets/vars.
      * Example: csl_signal s;
      *          s.set_number_of_dimensions(3);
      *          s.set_dim_width(0, 7);
      *          s.set_dim_width(1, 20);
      *          s.set_dim_width(2, 4);
      * The verilog output for this csl code will display 80 signals each with
      * a bitrange of 7.
      * 
      * Again, the logic of this function is easier to comprehend if divided
      * into sections:
      * 1.computing the number of verilog nets/vars to generate
      *    This part is easy to understand given the rule above.
      * 2.build the cdom range from the csl bitrange stored in m_cslReturnedValue if not null
      *    If the signal is simple , the m_cdomReturnedValue will contain its range.
      *    If the signal is multidim, then...
      *    Remember the discussion about dimension 0 inside the comment for the afterTraversal(simpleBitRange) method ?
      *    That dimension 0 is sent via the m_cdomReturnedValue and used to create the range of all the signals 
      *    generated in verilog.
      *    If the m_cdomReturnedValue is null, there is only one possible explanation: the signal is multidim
      *    and its dimension 0 has not been set. The adapter builds a default one.
      * 3.build the net/var
      *    According to the type of the csl signal, a verilog var or a verilog net is created.
      * 4.name the nets/vars
      *    If a signal is multidimensional the bundle of coresponding nets/vars generated in verilog
      *   carry the name of the original csl signal appended with their current index.
      *   If the signal(multidim or not) is part of a signal group, the name of the 
      *   corresponding net/var will be the name of the original csl signal prepended
      *   with the name of the signal group.
      *   Example: the verilog output for the example above would be:
      *   wire s_0[6:0];
      *   wire s_1[6:0];
      *   wire s_2[6:0];
      *   ... and so on until s_79[6:0];
      *   If the same signal were inside a signal group sg, the output would read:
      *   wire sg_s_0[6:0];
      *   wire sg_s_1[6:0];
      *   wire sg_s_2[6:0];
      *   ... and so on until sg_s_79[6:0];
      * There is another option available. If the signals are inside a unit, and the
      * set_unit_prefix(prefix_string) command has been included in the code, then all the signals's 
      * names( already prepended with the signal group name if it is the case) 
      * will be prefixed with the specified prefix_string. 
      * 
      * Note that you have to build only one net/var decl object and then add the
      * names generated according to the rule above to it.
      * Plus, you only set the bitrange once for the net/var decl, as it is the same
      * for all the signals it contains( the bitrange is stored in the m_cdomReturnedValue).
      *
      * 5.decoders
      * There is an extra option when it comes to signals. In csl a signal can generate
      * (be the input of) a decoder. If this is the case, some supplementary signals/logic
      * have to be included in the cdom tree and then generated into verilog.
      * All this is handled by the adaptDecoder() function (see the comment at the begining of the file).
      */
    void afterTraversal(const NSCSLOm::RefCSLOmSignal                          & signal                          );
    /**
      * Restores the csl and cdom current parents
      * back to unitInstantiation and moduleInstantiation.
      */
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInstance                    & unitInst                        );
    /**
      * As explained in the comment for the inTraversal method, the m_cdomTraversedChildren vector 
      * contains one(offset) or three elements(offset, lowerExpr, upperExpr).
      * These elements stored inside the vector will be used to build the range/rangeExpr verilog node.
      * But the range/rangeExpr node doesn't always get built. Lets walk through the first if in the cpp
      * code for this function to understand why.
      * The verilog equivalent of a simple bitrange gets generated in two cases(the two branches of the OR inside the if):
      * 1. the simple bitrange is NOT the child of another (multidimensional) bitrange
      * 2. the simple bitrange is THE FIRST child of a multidimensional bitrange(dimension 0)
      * That means that the equivalent range/rangeExpr node will be built, inserted into the cdom tree and stored
      * in the m_cdomReturnedValue ONLY if the current simple bitrange is the direct child of a signal, port
      * or design, or the dimension 0 of a multidimensional bitrange.
      * That basically means that the only bitranges that DO NOT get turned into verilog range/rangeExpr nodes
      * are children 2, 3 and so on of a multidim bitrange. 
      * That has to do with the way the adapter deals with multidimensional bitranges. 
      * 
      * So, crash course on multidimensional bitranges:
      * A multidim bitrange is a bitrange with other bitranges as children. If, lets say, 
      * a signal is assigned a multidim bitrange it becomes a multidim signal(same for port).
      * The verilog output contains several nets/vars for only one csl multidim signal. The number of nets/vars is computed 
      * based on the following rule:
      * nr_of verilog_nets/vars = dim_1_width*dim_2_width*...*dim_n_width
      * where dim_1, dim_2, ..., dim_n are the children 2, 3,...,n(of type simple bitrange) of the multidim bitrange.
      * The range of all these verilog nets/vars comes from dim_0, which is the first child(of type simple birange) of the multidim bitrange.
      * Now it is clear why this dimension 0 is the only one(out of all the children of a multidim bitrange)
      * that gets turned into a verilog range. All the other children are used to compute the NUMBER of the
      * generated veriolog nets/vars, NOT their range.
      * 
      * Having said that, lets take an inside look on how the csl simple bitrange is turned into a verilog range/rangeExpr:
      * The basic rule states that the lowerExpr used to build the cdom range/rangeExpr node is the csl lowerExpr plus the csl offset.
      * Same for the upperExpr.
      * Note that the lowerExpr and the upperExpr are optional; in that case the m_cdomTraversedChildren will only contain the offset,
      * and the cdom range/rangeExpr node will be built accordingly.
      * One more issue needs to be addressed and that is: when does the adapter build a range and when a rangeExpr?
      * That decision is made taking into account the type of the simple bitrange's parent. If that parent is an expr, a rangeExpr node
      * will be inserted into the cdom tree. If it is of another type(signal, port, another bitrange(dimension0), design), then a 
      * verilog range will be created.
      */

    void afterTraversal(const NSCSLOm::RefCSLOmSimpleBitRange                  & simpleBitRange                  );
    void afterTraversal(const NSCSLOm::RefCSLOmMultiDimBitRange                & multiDimBitRange                );
    void afterTraversal(const NSCSLOm::RefCSLOmGroup                           & group                           );
    /**
      * This function only handles the situation where the generateIndividulaRTLSignals
      * option is off. If it is on, there is no generated output in the cdom for the 
      * signal group.
      * 
      * The logic for csl_signal group is made up of two different sections.
      * First, the bitrange for the cumulative signal is computed.
      * Mainly, I use the m_num32FirstExpr, m_num32SecondExpr and m_num32Offset
      * to do that. The rest(substracting 1 or not) is just some arithmetic mumbo-jumbo
      * to generate the corect lower and upper indexes.
      *
      * In part two, I deal with naming the cumulative signal. The only supplementary
      * concern in this case is the unit prefix which might be set or not.
      * If it does exist, the name of the cumulative signal will be prefixed with it.
      */
    void afterTraversal(const NSCSLOm::RefCSLOmGroupSignal                     & groupSignal                     );
    void afterTraversal(const NSCSLOm::RefCSLOmNum32                           & number                          );
    void afterTraversal(const NSCSLOm::RefCSLOmVeriNum                         & veriNum                         );
    void afterTraversal(const NSCSLOm::RefCSLOmInterface                       & interface                       );
    /**
      * Restores the csl current parent to unitDecl
      * and the cdom current paent to moduleDecl.
      */
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInstantiation               & unitInstantiation               );
    /**
      * A csl portDecl object will be transformed into two cdom objects:
      * a cdom portItem and a cdom portDecl.
      * All this functionality is implemented inside the API functions buildCDOmPortDeclVar()
      * and buildCDOmPortDeclNet(). Here follows the insight on how they work.
      * Example: 
      * The csl code:
      *   csl_unit u {
      *     u (){
      *       add_port(output, reg, 8, sgn1);
      *       add_port(intput, 1, sgn2);
      *       add_port(inout, 4, sgn3);
      *     }
      *   }
      * The verilog code:
      *   module u (sgn1, sgn2, sgn3); //3 port items
      *     output [7:0] sgn1;         //1 port decl
      *     input [0:0] sgn2;          //1 port decl
      *     inout [3:0] sgn3;          //1 port decl
      *     reg [7:0] sgn1;
      *   endmodule;
      * Due to the particular nature of the cslom tree, for each add port command
      * one CSLOmPortDecl node will be created. For each such node the adapter creates
      * one cdom portItem and one cdom portDecl. So the following may appear to be useless :
      * portItem->addPortExprLink(...)
      * portDecl->addPort(...)
      * since there are only one portExprLink and one port to add.
      * The thing is, in verilog, a portItem and a portDecl can be more complex:
      * Example:
      *   module u ({s1,s2,s3}, {s4,s5}, {s6,s7})
      * There are three portItems in the module, but this time they are of type concat.
      * In the previous example, the three port items were of type simple.
      * Each port item will be built using the first exprLink in the list (s1 for the first one)
      * and the others (s2 and s3 for the same one) will be added using the addPortExprLink() method.
      * 
      *   output [7:0] s1,s2,s3;
      * The one above is one portDecl. It will be built generically and the port names that follow(s1,s2,s3)
      * will be added using the addPort() method.
      * However, given the reasons stated before, these two cdom facilities cannot be exploited.
      * Meaning that for the following csl code:
      *   csl_unit u { 
      *     u (){
      *       add_port_list(output, [7:0], csl_list(s1,s2,s3));
      *     }
      *   }
      * three different lines will be generated in verilog:
      *   module u (s1,s2,s3);
      *     output [7:0] s1;
      *     output [7:0] s2;
      *     output [7:0] s3;
      * and not only one:
      *   output [7:0] s1,s2,s3;
      * A strategy for fixing this is still being formulated.
      * As far as naming ports is concirned, there are two possible prefixes
      * that a port name may be prepended with: the unit prefix(if specified by the user via
      * the set_unit_prefix(prefix_string) command) and the interface name(if the port is not in the
      * default interface).
      *
      * The last part of the function handles the case of special ports. By special ports I mean ports 
      * that belong to special units(fifo, regFile). If the current csl port is to be found in the
      * m_cslFifoPorts map, then the port's parent unit is a fifo, and the corresponding cdom-converted port
      * will be inserted in the m_cdomUnitPorts map for further use inside the adaptFifoModule() method.
      * Example: 
      * csl_fifo f {
      *   f() {
      *     set_push(a); //I'm not sure on the syntax
      *   }
      * }
      * In this case the CSLOM inserts the pair <FIFO_PN_PUSH, prtDecl_a> in the m_portMap (member of the CSLOmFifoInfo class).
      * Inside the adapter, the fifo module is the first to be generated. Then all its ports are visited.
      * When port a is visited, the adapter locates it in the adapter copy of the cslom map, m_cslFifoPorts.
      * Then, the cdom equivalent of the csl_port a(previously built in this same function) is inserted in a pair,
      * <FIFO_PUSH, cdomPortDecl_a>, which is included in another adapter map, m_cdomUnitPorts.
      * In conclusion, there are two adapter maps: one is a copy of the cslom map(made up of pairs containing
      * cslPorts and their types), and the second one holds cdomPorts and their types. Of course, there is a 
      * peer to peer correspondence between the two.
      */
    void afterTraversal(const NSCSLOm::RefCSLOmPortDecl                        & portDecl                        );
    void afterTraversal(const NSCSLOm::RefCSLOmExprOp                          & exprOp                          );
    void afterTraversal(const NSCSLOm::RefCSLOmExprConcat                      & exprConcat                      );
    void afterTraversal(const NSCSLOm::RefCSLOmExprMultiConcat                 & exprMultiConcat                 );
    void afterTraversal(const NSCSLOm::RefCSLOmList                            & list                            );  
    void afterTraversal(const NSCSLOm::RefCSLOmSetCommand                      & setCommand                      );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetWidth                     & cmdSetWidth                     ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetBitRange                  & cmdSetBitRange                  ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetOffset                    & cmdSetOffset                    ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetLowerIndex                & cmdSetLowerIndex                ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetUpperIndex                & cmdSetUpperIndex                ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetRange                     & cmdSetRange                     ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetNumberOfDimensions        & cmdSetNumberOfDimensions        ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimWidth                  & cmdSetDimWidth                  ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimBitRange               & cmdSetDimBitRange               ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimOffset                 & cmdSetDimOffset                 ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimLowerIndex             & cmdSetDimLowerIndex             ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimUpperIndex             & cmdSetDimUpperIndex             ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetDimRange                  & cmdSetDimRange                  ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetUnitPrefix                & cmdSetUnitPrefix                ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefix              & cmdSetSignalPrefix              ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetSignalPrefixLocal         & cmdSetSignalPrefixLocal         ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetType                      & cmdSetType                      ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetAttr                      & cmdSetAttr                      ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdAddInstance                  & cmdAddInstance                  ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdAddInstanceList              & cmdAddInstanceList              ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdAddSignal                    & cmdAddSignal                    ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdAddSignalList                & cmdAddSignalList                ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdAddSignalGroup               & cmdAddSignalGroup               );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdAddPort                      & cmdAddPort                      );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdAddPortList                  & cmdAddPortList                  );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignal                 & cmdRemoveSignal                 );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdRemoveSignalList             & cmdRemoveSignalList             );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdRemovePort                   & cmdRemovePort                   );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdRemovePortList               & cmdRemovePortList               ); 
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdSetInstanceAlterationBit     & cmdSetInstanceAlterationBit     );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdGenerateIndividualRTLSignals & cmdGenerateIndividualRTLSignals );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdAddInterface                 & cmdAddInterface                 );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdAddUnitParameter             & cmdAddUnitParameter             );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdOverrideUnitParameter        & cmdOverrideUnitParameter        );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdInputVerilogType             & cmdInputVerilogType             );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdOutputVerilogType            & cmdOutputVerilogType            );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdReverse                      & cmdReverse                      );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdConnect                      & cmdConnect                      );
    //void afterTraversal(const NSCSLOm::RefCSLOmCmdConnectSplit                 & cmdConnectSplit                 );
    void afterTraversal(const NSCSLOm::RefCSLOmParameter                       & parameter                       );
    void afterTraversal(const NSCSLOm::RefCSLOmListExpr                        & listExpr                        );
    void afterTraversal(const NSCSLOm::RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            );
    void afterTraversal(const NSCSLOm::RefCSLOmExprFuncSignature               & exprFuncSignature               );
    //    void afterTraversal(const NSCSLOm::RefCSLOmTestbenchDecl                   & testbenchDecl                   );
    //    void afterTraversal(const NSCSLOm::RefCSLOmTestbenchVector                 & testbenchVector                 );
    //    void afterTraversal(const NSCSLOm::RefCSLOmParameterOverride               & parameterOverride               );
    void afterTraversal(const NSCSLOm::RefCSLOmEnum                            & enumeration                     );
    void afterTraversal(const NSCSLOm::RefCSLOmField                           & field                           );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMap                       & memoryMap                       );
    void afterTraversal(const NSCSLOm::RefCSLOmAddressRange                    & addressRange                    );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapLocation               & memoryMapLocation               );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPage                   & memoryMapPage                   );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryMapPageInstance           & memoryMapPageInstance           );
    void afterTraversal(const NSCSLOm::RefCSLOmContainer                       & container                       );
    void afterTraversal(const NSCSLOm::RefCSLOmIsaField                        & isaField                        );
    void afterTraversal(const NSCSLOm::RefCSLOmIsaElement                      & isaElement                      );
    void afterTraversal(const NSCSLOm::RefCSLOmUnitInfo                        & unitInfo                        ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmStmtAssign                      & stmtAssign                      );
    void afterTraversal(const NSCSLOm::RefCSLOmMemoryInfo                      & memInfo                         ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmFifoInfo                        & fifoInfo                        ) {}    
    void afterTraversal(const NSCSLOm::RefCSLOmRegisterFileInfo                & regFileInfo                     ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmRegDeclInfo                     & regInfo                         ) {}
    void afterTraversal(const NSCSLOm::RefCSLOmTBInfo                          & tbInfo                          ) {}    
    void afterTraversal(const NSCSLOm::RefCSLOmVectorInfo                      & vectorInfo                      ) {}    


};

}
#endif
