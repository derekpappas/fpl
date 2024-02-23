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

#ifndef INC_GUARD_CDOM_Checker_h
#define INC_GUARD_CDOM_Checker_h

#include "CDOM_Visitor.h"
#include "CDOM.h"
#include "CDOM_Type_Map.h"
#include "../support/RefCount.h"
#include <string>
#include <vector>
#include <utility>

using namespace NSCdom;

namespace NSCdomChecker {
  
typedef boost::shared_ptr<std::string> RefString;

class CDOmChecker : public NSCdomVisitor::CVisitorTraversal {
 private:
  RefCDOmDesign my_design;
  std::vector<RefString> undef;
 public:
  CDOmChecker();
  ~CDOmChecker();

    
  virtual void beforeTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ){}
  virtual void beforeTraversal(const NSCdom::RefCDOmDesign                          & design                      ) ;
  virtual void beforeTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ) ;  
  virtual void beforeTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmRange                           & range                       ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmNum32                           & num                         ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmReal                            & realNum                     ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) ;
  virtual void beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {}   
  virtual void beforeTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {}   
  virtual void beforeTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmDelay                           & delay                       ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmAssn                            & assn                        ) {}    
  virtual void beforeTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ) {}   
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmString                          & stringObj                   ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    ) {} 
  virtual void beforeTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmDefine                          & define                      ) {}
  virtual void beforeTraversal(const NSCdom::RefCDOmComment                         & comment                     ) {}
  
  /*  
      virtual void beforeTraversal(const NSCdom::RefCDOmExpr                            & expr                        ) = 0;
  */
  
  virtual void inTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ) {}
  virtual void inTraversal(const NSCdom::RefCDOmDesign                          & design                      ) {}
  virtual void inTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ) {}
  virtual void inTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ) {}
  virtual void inTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ) {}
  virtual void inTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ) {}
  virtual void inTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ) {}
  virtual void inTraversal(const NSCdom::RefCDOmRange                           & range                       ) {}
  virtual void inTraversal(const NSCdom::RefCDOmNum32                           & num                         ) {}
  virtual void inTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ) {}
  virtual void inTraversal(const NSCdom::RefCDOmReal                            & realNum                     ) {}
  virtual void inTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) {}
  virtual void inTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ) {}
  virtual void inTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {}
  virtual void inTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ) {}
  virtual void inTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmDelay                           & delay                       ) {}
  virtual void inTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ) {}
  virtual void inTraversal(const NSCdom::RefCDOmAssn                            & assn                        ) {}
  virtual void inTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ) {}
  virtual void inTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ) {}
  virtual void inTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ) {}
  virtual void inTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ) {}
  virtual void inTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     ) {}
  virtual void inTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           ) {}
  virtual void inTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            ) {}
  virtual void inTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                ) {}
  virtual void inTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 ) {}
  virtual void inTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 ) {}
  virtual void inTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  ) {}
  virtual void inTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                ) {}
  virtual void inTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  ) {}
  virtual void inTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     ) {}
  virtual void inTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 ) {}
  virtual void inTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 ) {}
  virtual void inTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 ) {}
  virtual void inTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                ) {}
  virtual void inTraversal(const NSCdom::RefCDOmString                          & stringObj                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                ) {}
  virtual void inTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   ) {}
  virtual void inTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              ) {}
  virtual void inTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               ) {}
  virtual void inTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         ) {} 
  virtual void inTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            ) {}
  virtual void inTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           ) {}
  virtual void inTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               ) {}
  virtual void inTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              ) {}
  virtual void inTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           ) {}
  virtual void inTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                ) {}
  virtual void inTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    ) {}
  virtual void inTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ) {}
  virtual void inTraversal(const NSCdom::RefCDOmDefine                          & define                      ) {}
  virtual void inTraversal(const NSCdom::RefCDOmComment                         & comment                     ) {}
  
  /*
    virtual void inTraversal(const NSCdom::RefCDOmExpr                            & expr                        ) = 0;
  */
  
  virtual void afterTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ){}
  virtual void afterTraversal(const NSCdom::RefCDOmDesign                          & design                      ) ;
  virtual void afterTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmRange                           & range                       ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmNum32                           & num                         ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmReal                            & realNum                     ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) {}   
  virtual void afterTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmDelay                           & delay                       ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmAssn                            & assn                        ) {}            
  virtual void afterTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ) {}    
  virtual void afterTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmString                          & stringObj                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmDefine                          & define                      ) {}
  virtual void afterTraversal(const NSCdom::RefCDOmComment                         & comment                     ) {}

  /*
    virtual void afterTraversal(const NSCdom::RefCDOmExpr                            & expr                        ) = 0;

  */

  std::vector<RefString>&    getUndefModuleVect();

};

}

#endif // NSCdomVisitor
