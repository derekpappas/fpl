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

#ifndef INC_GUARD_CDOM_Visitor_h
#define INC_GUARD_CDOM_Visitor_h

#include <iostream>
#include <bitset>

#include "CDOM.h"
#include "CDOM_Type_Map.h"
#define __TRACE
#include "../support/CommonSupport.h"

using namespace NSCdom;

namespace NSCdomVisitor {

//********************************************************************************
// CVisitor class
//********************************************************************************
class CVisitor {
  protected:
    CVisitor();

  public:
    virtual ~CVisitor();
    virtual  void visit(const RefCDOmComment                       & comment            ) = 0;
    virtual  void visit(const RefCDOmInclude                       & fileInclude        ) = 0;
    virtual  void visit(const RefCDOmDesign                        & design             ) = 0;
    virtual  void visit(const RefCDOmModuleDecl                    & moduleDecl         ) = 0; 
    virtual  void visit(const RefCDOmIdentifier                    & id                 ) = 0;
    virtual  void visit(const RefCDOmPortItem                      & portItem           ) = 0;
    virtual  void visit(const RefCDOmExprLink                      & exprLink           ) = 0;
    virtual  void visit(const RefCDOmExprOp                        & exprOp             ) = 0;
    virtual  void visit(const RefCDOmListExpr                      & listExpr           ) = 0;
    virtual  void visit(const RefCDOmPortDecl                      & portDecl           ) = 0;
    virtual  void visit(const RefCDOmRange                         & range              ) = 0;
    virtual  void visit(const RefCDOmNum32                         & num                ) = 0;
    virtual  void visit(const RefCDOmVeriNum                       & veriNum            ) = 0;
    virtual  void visit(const RefCDOmReal                          & realNum            ) = 0;
    virtual  void visit(const RefCDOmNetDecl                       & netDecl            ) = 0;
    virtual  void visit(const RefCDOmVarDecl                       & varDecl            ) = 0;
    virtual  void visit(const RefCDOmModuleOrUdpInstantiation      & moduleInstantiation) = 0;
    virtual  void visit(const RefCDOmModuleOrUdpInstance           & moduleInstance     ) = 0;
    virtual  void visit(const RefCDOmParamDeclCollection           & paramDeclCollection) = 0;
    virtual  void visit(const RefCDOmParamDecl                     & paramDecl          ) = 0;
    virtual  void visit(const RefCDOmParamOverride                 & paramOverride      ) = 0;
    virtual  void visit(const RefCDOmMinTypMax                     & minTypMax          ) = 0;
    virtual  void visit(const RefCDOmDelay                         & delay              ) = 0;
    virtual  void visit(const RefCDOmInitOrAlways                  & initOrAlways       ) = 0;
    virtual  void visit(const RefCDOmAssn                          & assn               ) = 0;
    virtual  void visit(const RefCDOmContAssn                      & contAssn           ) = 0;
    virtual  void visit(const RefCDOmStmt                          & stmt               ) = 0;
    virtual  void visit(const RefCDOmStmtBlock                     & stmtBlock          ) = 0; 
    virtual  void visit(const RefCDOmStmtAssn                      & stmtAssn           ) = 0; 
    virtual  void visit(const RefCDOmEventControl                  & eventCtrl          ) = 0;
    virtual  void visit(const RefCDOmEventExpr                     & eventExpr          ) = 0;
    virtual  void visit(const RefCDOmDelayControl                  & delayCtrl          ) = 0;
    virtual  void visit(const RefCDOmStmtProcContAssn              & stmtPCAssn         ) = 0;
    virtual  void visit(const RefCDOmStmtProcTimingControl         & stmtPTCtrl         ) = 0;
    virtual  void visit(const RefCDOmStmtCase                      & stmtCase           ) = 0;
    virtual  void visit(const RefCDOmStmtIf                        & stmtIf             ) = 0;
    virtual  void visit(const RefCDOmStmtLoop                      & stmtLoop           ) = 0;
    virtual  void visit(const RefCDOmStmtTaskEnable                & stmtTaskEnable     ) = 0;
    virtual  void visit(const RefCDOmStmtWait                      & stmtWait           ) = 0;
    virtual  void visit(const RefCDOmStmtDisable                   & stmtDisable        ) = 0;
    virtual  void visit(const RefCDOmStmtEventTrigger              & stmtEventTrigger   ) = 0;
    virtual  void visit(const RefCDOmRangeExpr                     & rangeExpr          ) = 0;
    virtual  void visit(const RefCDOmRangeList                     & rangeList          ) = 0;
    virtual  void visit(const RefCDOmExprConcat                    & exprConcat         ) = 0;
    virtual  void visit(const RefCDOmExprMultiConcat               & exprMultiConcat    ) = 0;
    virtual  void visit(const RefCDOmTaskDecl                      & taskDecl           ) = 0;
    virtual  void visit(const RefCDOmTFPortDecl                    & tfPortDecl         ) = 0;
    virtual  void visit(const RefCDOmFuncDecl                      & funcDecl           ) = 0;
    virtual  void visit(const RefCDOmFunctionCall                  & functionCall       ) = 0;
    virtual  void visit(const RefCDOmUdpDecl                       & udpDecl            ) = 0;
    virtual  void visit(const RefCDOmUdpPortDeclOutput             & udpPortDeclOutput  ) = 0;
    virtual  void visit(const RefCDOmUdpPortDeclInput              & udpPortDeclInput   ) = 0;
    virtual  void visit(const RefCDOmUdpCombEntry                  & udpCombEntry       ) = 0;
    virtual  void visit(const RefCDOmUdpSeqEntry                   & udpSeqEntry        ) = 0;
    virtual  void visit(const RefCDOmUdpInitStmt                   & udpInitStmt        ) = 0;
    virtual  void visit(const RefCDOmGenvarDecl                    & genvarDecl         ) = 0;
    virtual  void visit(const RefCDOmGenInst                       & genInst            ) = 0;
    virtual  void visit(const RefCDOmGenItemNull                   & genItemNull        ) = 0;
    virtual  void visit(const RefCDOmGenItemIf                     & genItemIf          ) = 0;
    virtual  void visit(const RefCDOmGenItemCase                   & genItemCase        ) = 0;
    virtual  void visit(const RefCDOmGenItemLoop                   & genItemLoop        ) = 0;
    virtual  void visit(const RefCDOmGenItemBlock                  & genItemBlock       ) = 0;
    virtual  void visit(const RefCDOmString                        & stringObj          ) = 0;
    virtual  void visit(const RefCDOmEventDecl                     & eventDecl          ) = 0;
    virtual  void visit(const RefCDOmSpecifyBlock                  & specifyBlock       ) = 0;
    virtual  void visit(const RefCDOmPulseStyleOrShowCancelledDecl & pulseSSCd          ) = 0;   
    virtual  void visit(const RefCDOmPathDecl                      & pathDecl           ) = 0;   
    virtual  void visit(const RefCDOmPathDelayValue                & pathDelayValue     ) = 0;
    virtual  void visit(const RefCDOmMinTypMaxList                 & minTypMaxList      ) = 0;
    virtual  void visit(const RefCDOmSpecifyTerminalList           & specifyTerminalList) = 0;
    virtual  void visit(const RefCDOmDelayedDataOrReference        & delayedDataOrRef   ) = 0;
    virtual  void visit(const RefCDOmTimingCheckEventControl       & timingCkEventCtrl  ) = 0;
    virtual  void visit(const RefCDOmTimingCheckEvent              & timingCkEvent      ) = 0;
    virtual  void visit(const RefCDOmSystemTimingCheck             & systemTimingCk     ) = 0;
    virtual  void visit(const RefCDOmGateInstantiation             & gateInstantiation  ) = 0;
    virtual  void visit(const RefCDOmPulseControl                  & pulseControl       ) = 0;
    virtual  void visit(const RefCDOmAttrList                      & attrList           ) = 0;
    virtual  void visit(const RefCDOmAttrListCollection            & attrListCollection ) = 0;
    virtual  void visit(const RefCDOmDefine                        & defineDecl         ) = 0;

    //valid order
    virtual  void visit(const RefCDOmScope                    & scope              ) = 0;
    virtual  void visit(const RefCDOmExpr                     & expr               ) = 0;

};

//********************************************************************************
// CVisitorTraversal class
//********************************************************************************
class CVisitorTraversal : public CVisitor{
  private:
    typedef TBool (CVisitorTraversal::*__tbool)(void);

    std::bitset<64> m_mask;

    enum ETraversalType {
      MODULE_TRAVERSAL,
      MODULE_TRAVERSAL_BEFORE,
      MODULE_TRAVERSAL_IN,
      MODULE_TRAVERSAL_AFTER,

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
      CMD_TRAVERSAL_AFTER
    };
    void initMaskValue();
    //protected:
    //TBool m_inNetDecl;
    
  public:
    /** enables
     */
    void enableModuleTraversal()       { m_mask.set(MODULE_TRAVERSAL); }
    void enableModuleBeforeTraversal() { m_mask.set(MODULE_TRAVERSAL_BEFORE); }
    void enableModuleAfterTraversal()  { m_mask.set(MODULE_TRAVERSAL_IN); }
    void enableModuleInTraversal()     { m_mask.set(MODULE_TRAVERSAL_AFTER); }

    void enableObjTraversal()       { m_mask.set(OBJ_TRAVERSAL); }
    void enableObjBeforeTraversal() { m_mask.set(OBJ_TRAVERSAL_BEFORE); }
    void enableObjAfterTraversal()  { m_mask.set(OBJ_TRAVERSAL_IN); }
    void enableObjInTraversal()     { m_mask.set(OBJ_TRAVERSAL_AFTER); }

    void enableExprTraversal()       { m_mask.set(EXPR_TRAVERSAL); }
    void enableBeforeExprTraversal() { m_mask.set(EXPR_TRAVERSAL_BEFORE); }
    void enableInExprTraversal()     { m_mask.set(EXPR_TRAVERSAL_IN); }
    void enableAfterExprTraversal()  { m_mask.set(EXPR_TRAVERSAL_AFTER); }

    void enableCmdTraversal()       { m_mask.set(CMD_TRAVERSAL); }
    void enableBeforeCmdTraversal() { m_mask.set(CMD_TRAVERSAL_BEFORE); }
    void enableInCmdTraversal()     { m_mask.set(CMD_TRAVERSAL_IN); }
    void enableAfterCmdTraversal()  { m_mask.set(CMD_TRAVERSAL_AFTER); }

    /** disables
     */
    void disableModuleTraversal()       { m_mask.reset(MODULE_TRAVERSAL); }
    void disableModuleBeforeTraversal() { m_mask.reset(MODULE_TRAVERSAL_BEFORE); }
    void disableModuleInTraversal()     { m_mask.reset(MODULE_TRAVERSAL_IN); }
    void disableModuleAfterTraversal()  { m_mask.reset(MODULE_TRAVERSAL_AFTER); }

    void disableObjTraversal()       { m_mask.reset(OBJ_TRAVERSAL); }
    void disableObjBeforeTraversal() { m_mask.reset(OBJ_TRAVERSAL_BEFORE); }
    void disableObjInTraversal()     { m_mask.reset(OBJ_TRAVERSAL_IN); }
    void disableObjAfterTraversal()  { m_mask.reset(OBJ_TRAVERSAL_AFTER); }

    void disableExprTraversal()           { m_mask.reset(EXPR_TRAVERSAL); }
    void disableExprBeforeExprTraversal() { m_mask.reset(EXPR_TRAVERSAL_BEFORE); }
    void disableExprInExprTraversal()     { m_mask.reset(EXPR_TRAVERSAL_IN); }
    void disableExprAfterExprTraversal()  { m_mask.reset(EXPR_TRAVERSAL_AFTER); }

    void disableCmdTraversal()          { m_mask.reset(CMD_TRAVERSAL); }
    void disableCmdBeforeCmdTraversal() { m_mask.reset(CMD_TRAVERSAL_BEFORE); }
    void disableCmdInCmdTraversal()     { m_mask.reset(CMD_TRAVERSAL_IN); }
    void disableCmdAfterCmdTraversal()  { m_mask.reset(CMD_TRAVERSAL_AFTER); }

    /** tests
     */
    TBool isModuleTraversalEnabled()       { return m_mask.test(MODULE_TRAVERSAL); }
    TBool isModuleBeforeTraversalEnabled() { return m_mask.test(MODULE_TRAVERSAL_BEFORE); }
    TBool isModuleInTraversalEnabled()     { return m_mask.test(MODULE_TRAVERSAL_IN); }
    TBool isModuleAfterTraversalEnabled()  { return m_mask.test(MODULE_TRAVERSAL_AFTER); }

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

  public:
    CVisitorTraversal();
    ~CVisitorTraversal();
    //dummies
    void visit(const RefCDOmScope                    & scope              ){}
    //end of dummies
    
    virtual void visit(const NSCdom::RefCDOmComment                         & comment                         );
    virtual void visit(const NSCdom::RefCDOmInclude                         & fileInclude                     );
    virtual void visit(const NSCdom::RefCDOmDesign                          & design                          );
    virtual void visit(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                      );
    virtual void visit(const NSCdom::RefCDOmIdentifier                      & id                              );    
    virtual void visit(const NSCdom::RefCDOmPortItem                        & portItem                        );
    virtual void visit(const NSCdom::RefCDOmExprLink                        & exprLink                        );
    virtual void visit(const NSCdom::RefCDOmExprOp                          & exprOp                          );
    virtual void visit(const NSCdom::RefCDOmListExpr                        & listExpr                        );
    virtual void visit(const NSCdom::RefCDOmPortDecl                        & portDecl                        );
    virtual void visit(const NSCdom::RefCDOmRange                           & range                           );
    virtual void visit(const NSCdom::RefCDOmNum32                           & num                             );
    virtual void visit(const NSCdom::RefCDOmVeriNum                         & veriNum                         );
    virtual void visit(const NSCdom::RefCDOmReal                            & realNum                         );
    virtual void visit(const NSCdom::RefCDOmVarDecl                         & varDecl                         );
    virtual void visit(const NSCdom::RefCDOmNetDecl                         & netDecl                         );
    virtual void visit(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation             );
    virtual void visit(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance                  );
    virtual void visit(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection             );
    virtual void visit(const NSCdom::RefCDOmParamDecl                       & paramDecl                       );
    virtual void visit(const NSCdom::RefCDOmParamOverride                   & paramOverride                   );
    virtual void visit(const NSCdom::RefCDOmMinTypMax                       & minTypMax                       );
    virtual void visit(const NSCdom::RefCDOmDelay                           & delay                           );
    virtual void visit(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                    );
    virtual void visit(const NSCdom::RefCDOmAssn                            & assn                            );
    virtual void visit(const NSCdom::RefCDOmContAssn                        & contAssn                        );
    virtual void visit(const NSCdom::RefCDOmStmt                            & stmt                            );    
    virtual void visit(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                       ); 
    virtual void visit(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                        );
    virtual void visit(const NSCdom::RefCDOmEventControl                    & eventCtrl                       );
    virtual void visit(const NSCdom::RefCDOmEventExpr                       & eventExpr                       );
    virtual void visit(const NSCdom::RefCDOmDelayControl                    & delayCtrl                       );
    virtual void visit(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                      );
    virtual void visit(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                      );
    virtual void visit(const NSCdom::RefCDOmStmtCase                        & stmtCase                        );
    virtual void visit(const NSCdom::RefCDOmStmtIf                          & stmtIf                          );
    virtual void visit(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                        );
    virtual void visit(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable                  );
    virtual void visit(const NSCdom::RefCDOmStmtWait                        & stmtWait                        );
    virtual void visit(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                     );
    virtual void visit(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger                );
    virtual void visit(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                       );
    virtual void visit(const NSCdom::RefCDOmRangeList                       & rangeList                       );
    virtual void visit(const NSCdom::RefCDOmExprConcat                      & exprConcat                      );
    virtual void visit(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat                 );
    virtual void visit(const NSCdom::RefCDOmUdpDecl                         & udpDecl                         );
    virtual void visit(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput               );
    virtual void visit(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput                );
    virtual void visit(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                    );
    virtual void visit(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                     );
    virtual void visit(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                     );
    virtual void visit(const NSCdom::RefCDOmExpr                            & expr                            ){}
    virtual void visit(const NSCdom::RefCDOmTaskDecl                        & taskDecl                        );
    virtual void visit(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                      );
    virtual void visit(const NSCdom::RefCDOmFuncDecl                        & funcDecl                        );
    virtual void visit(const NSCdom::RefCDOmFunctionCall                    & functionCall                    );
    virtual void visit(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                      );
    virtual void visit(const NSCdom::RefCDOmGenInst                         & genInst                         );
    virtual void visit(const NSCdom::RefCDOmGenItemNull                     & genItemNull                     );
    virtual void visit(const NSCdom::RefCDOmGenItemIf                       & genItemIf                       );
    virtual void visit(const NSCdom::RefCDOmGenItemCase                     & genItemCase                     );
    virtual void visit(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                     );
    virtual void visit(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                    );
    virtual void visit(const NSCdom::RefCDOmString                          & stringObj                       );
    virtual void visit(const NSCdom::RefCDOmEventDecl                       & eventDecl                       );
    virtual void visit(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                    );
    virtual void visit(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                       );
    virtual void visit(const NSCdom::RefCDOmPathDecl                        & pathDecl                        );      
    virtual void visit(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue                  );
    virtual void visit(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList                   );
    virtual void visit(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList             );
    virtual void visit(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef                );
    virtual void visit(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl               );
    virtual void visit(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent                   );
    virtual void visit(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk                  );
    virtual void visit(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation               );
    virtual void visit(const NSCdom::RefCDOmPulseControl                    & pulseControl                    );
    virtual void visit(const NSCdom::RefCDOmAttrList                        & attrList                        );
    virtual void visit(const NSCdom::RefCDOmAttrListCollection              & attrListCollection              );
    virtual void visit(const NSCdom::RefCDOmDefine                          & define                          );
    
    virtual void beforeTraversal(const NSCdom::RefCDOmComment                         & comment                     ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmDesign                          & design                      ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ) = 0;  
    virtual void beforeTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmRange                           & range                       ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmNum32                           & num                         ) = 0;    
    virtual void beforeTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmReal                            & realNum                     ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) = 0;   
    virtual void beforeTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) = 0;   
    virtual void beforeTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmDelay                           & delay                       ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmAssn                            & assn                        ) = 0;    
    virtual void beforeTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ) = 0;    
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ) = 0; 
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmString                          & stringObj                   ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ) = 0;
    virtual void beforeTraversal(const NSCdom::RefCDOmDefine                          & define                      ) = 0;

    /*  
    virtual void beforeTraversal(const NSCdom::RefCDOmExpr                            & expr                        ) = 0;
    */
    virtual void inTraversal(const NSCdom::RefCDOmComment                         & comment                     ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmDesign                          & design                      ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ) = 0;    
    virtual void inTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmRange                           & range                       ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmNum32                           & num                         ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmReal                            & realNum                     ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmDelay                           & delay                       ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmAssn                            & assn                        ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmString                          & stringObj                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ) = 0;
    virtual void inTraversal(const NSCdom::RefCDOmDefine                          & define                      ) = 0;
    /*
    virtual void inTraversal(const NSCdom::RefCDOmExpr                            & expr                        ) = 0;
    */
    virtual void afterTraversal(const NSCdom::RefCDOmComment                         & comment                     ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmDesign                          & design                      ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ) = 0;    
    virtual void afterTraversal(const NSCdom::RefCDOmIdentifier                      & id                          ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmRange                           & range                       ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmNum32                           & num                         ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmReal                            & realNum                     ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         ) = 0;   
    virtual void afterTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmDelay                           & delay                       ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmAssn                            & assn                        ) = 0;            
    virtual void afterTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmt                            & stmt                        ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   ) = 0;    
    virtual void afterTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmString                          & stringObj                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ) = 0;
    virtual void afterTraversal(const NSCdom::RefCDOmDefine                          & define                      ) = 0;

    /*
    virtual void afterTraversal(const NSCdom::RefCDOmExpr                            & expr                        ) = 0;

    */

};

} // end namespace NSCdomVisitor

#endif /*INC_GUARD_CDOM_Visitor_h*/
