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
 *   CDOM Verilog Code generator
 *   Authors: AndreiB 
 *   2006-2007
 */

//#ifndef 
//#define 

#include <iostream>
#include <fstream>
#include <string>
//#define __TRACE
#include "CDOM.h"
#include "CDOM_Type_Map.h"
#include "CDOM_Visitor.h"
#include "../support/cli/cslcCLI_Support.h"

#define __TRACE
#include "../support/CommonSupport.h"
//defines used by indent function <- these are only temporary (need to be integrated)
//Not needed anymore - code needs to be updated and the 3 defines removed
#define IND1 1
#define IND2 2
#define IND3 3

/* This is sent by CDOM and represents the concatenation of top units names
 * the design (or NULL if the design has no top unit)
 */
extern RefString cslTopUnitName;

extern TBool cslomHasEnum;

// using namespace NSCdom;

namespace NSCdomVerilogGenerator {

class CVerilogGenerator;
typedef boost::shared_ptr<CVerilogGenerator>   RefCVerilogGenerator;

//********************************************************************************
// CVerilogGenerator class
//********************************************************************************
class CVerilogGenerator : public NSCdomVisitor::CVisitorTraversal {
   private:
    std::ostream *out;
    
    //WARNING: need to add this to members TBool indent; <- check to trigger indent

    //std::ostream *dout; //output stream for units of type design
    //std::ostream *tout; //output stream for units of type testbench
    //std::ostream *vout; //not used yet
    std::fstream vfout;//vf file stream
    std::fstream defout;//defines file stream
    TBool file;

    //output control
    std::string m_outputPath;

    //names used in file output
    RefString m_currentModuleName;
    RefString m_moduleFileName;
    RefString m_stimExpModule;

    //map of names and instantiations (there are actually module decls but
    // are retrived from instantiations: see getInstancesDeclarationsAsBase())
    //this is to make sure no duplicate names are found in vf output file
    RefTMap_RefString_RefCDOmBase m_instantiationsMap;

    //depth counter -- used for indentation control
    TInt m_depth;
    //experimental counter
    TInt m_addIndent;

    TInt m_modcnt;//module children counter
    TInt m_portItemSize;//used to determine portItemSize

    TInt m_portDeclSize;//not needed ?

    //---OB added---used in vectors' defines
    TBool m_vect;

    //used in exprLink
    TInt m_exprLinkExprSize;
    TInt m_exprLinkExprCnt;
    TInt m_exprLinkListExprSize;
    RefTVec_RefString m_exprLinkHidNames;
    RefTVec_RefCDOmExpr m_exprLinkExprs;
    
    //used in portDecl
    TInt m_pdcnt;
    TInt m_portIdSize;//used to determine the number of IDs in a portDecl
    
    //used in varDecl
    TInt m_vrcnt;
    TInt m_varIdSize;//used to determine the number of IDs in a varDecl
    
    //used in netDecl
    TInt m_ntcnt;
    TInt m_netIdSize;//used to determine the number of IDs in a netDecl

    //used in range
    TInt m_rangeExprs;//used to position inside the range
    TBool m_showRange;
   //TBool m_noRange;

    //used in include (cdomInclude)
    TBool m_includeInUnit;

    //used in moduleDecl
    CDOmModuleDecl::ECslSourceUnitType m_moduleCslType;

    //used in moduleInstantiation
    TInt m_intcnt; //counter that increments after each instance
    TInt m_intExprCnt; //counter that increments after each parameter assignment
    TInt m_intExprSize; //determines the number of expressions (TYPE_EXPR) - paramter assignments are also exprs
    TBool m_intHasParams; //flag to check if the instantiation has paramter assignments
    TInt m_instanceNumSize;//used to determine the number of instances in an instantiation
    TUInt m_moduleInstantiationIndt;
    TMap_RefString_RefCDOmMinTypMax::const_iterator m_paramNameMapIt;

    //used in moduleInstance
    TInt m_inscnt;
    TInt m_insctrl;
    TUInt m_moduleInstanceIndt;
    TInt m_moduleInstanceCnt;
    TInt m_moduleInstanceSize;
    TInt m_moduleInstanceExprSize;    
    TInt m_moduleInstanceExprCnt;
    TInt m_orderedPortNumSize;//used to determine the number of ports in an ordered instantation
    RefTVec_TUInt m_emptyIndexesVec;
    TUInt m_emptyIndex;

    //used in exprOp
    //TInt m_posCnt;
    std::vector<TInt> m_exprCnt;

    //used in listExpr
    TUInt m_listExprCnt;
    TUInt m_listExprSize;
    TBool m_listExprHasExprLinkParent;
    TBool m_listExprHasFunctionCallParent;
    RefCDOmBase m_parent;

    //used in minTypMax
    TInt m_minTypMaxCnt;
    TInt m_minTypMaxChildren;

    //used in delay
    TInt m_delayPos;
    TInt m_delaySize;
    TInt m_delayDeclType;
    TBool m_delayHasParanths;

    //used in paramDecl
    TInt m_paramDeclPos;
    TInt m_paramDeclChildren;
    RefTMap_RefString_RefCDOmIdentifier m_nameMap;
    std::vector<RefString> m_namesVec; 
   

    //used in ParamOverride
    TInt m_paramOverrideCnt;
    TInt m_paramOverrideSize;

    //used in assn
    TInt m_assnPos;

    //used in stmtBlock
    TInt m_stmtBlockCnt;
    TInt m_stmtBlockSize;

    //used in contAssn
    TInt m_contAssnPos;
    TInt m_contAssnSize;

    //used in stmtAssn
    TInt m_stmtAssnPos;

    //used in eventExpr
    TInt m_eventExprType; //WARNING: this is not used in inTraversal anymore -- may prove to be redundant: dig this!
    std::vector<TInt> m_eventExprCnt;

    //used in eventControl
    TInt m_eventCtrlType;

    //used in stmtProcContAssn
    TInt m_stmtPCAssnType;

    //used in stmtProcTimingControl
    TInt m_stmtPTCtrlPos;

    //used in stmtCase
    TInt m_caseType;
    TInt m_stmtCaseCnt;
    TInt m_stmtCaseSize;
    TBool m_stmtCaseDefault;

    //used in stmtIf
    TInt m_stmtIfCnt;
    TInt m_stmtIfSize;
    TBool m_stmtIfHasAttrList;
    //TBool m_stmtIfHasStmtBlockChildren;

    //used in stmtLoop
    TInt m_stmtLoopCnt;
    TInt m_stmtLoopType;

    //used in stmtTaskEnable
    TInt m_stmtTaskEnableCnt;
    TInt m_stmtTaskEnableSize;

    //used in stmtWait
    TInt m_stmtWaitCnt;

    //used in rangeExpr
    TInt m_rangeExprPos;
    TInt m_rangeExprType;

    //used in exprConcat
    RefTStack_TInt m_exprConcatSize;

    //used in exprMultiConcat
    TInt m_exprMultiConcatPos;

    //used in udpDecl
    TInt m_udpcnt;
    TInt m_udpPdInputCnt;
    RefString m_udpOutPortName;

    //used in udpCombEntry
    TInt m_combEntryCnt;
    TInt m_combEntrySize;

    //used in udpSeqEntry
    TInt m_seqEntryCnt;
    TInt m_seqEntrySize;

    //used in taskDecl
    TInt m_taskDeclChildren;
    TInt m_taskDeclPortItemSize;
    TInt m_taskDeclCnt;

    //used in tfPortDecl
    TInt m_tfPortDeclSize;
    TInt m_tfPortDeclCnt;

    //used in funcDecl
    TInt m_funcDeclCnt;
    TInt m_funcDeclType;
    TBool m_hasRange;

    //used in genvarDecl
    TInt m_genvarDeclCnt;
    TInt m_genvarDeclSize;

    //used in genItemIf
    TInt m_genItemIfCnt;
    TInt m_genItemIfSize;

    //used in genItemCase
    TInt m_genItemCaseCnt;
    TInt m_genItemCaseSize;
    TBool m_genItemCaseDefault;

    //used in genItemLoop
    TInt m_genItemLoopCnt;

    //used in genItemBlock
    TInt m_genItemBlockCnt;
    TInt m_genItemBlockSize;

    //used in eventDecl
    TInt m_eventDeclCnt;
    TInt m_eventDeclSize;

    //used in pulseSSCD
    TInt m_pulseSSCdType;

    //used in pathDecl
    TInt m_pathDeclReturn;
    TBool m_pathDeclIsSimple;
    //TBool m_pathDeclIsSimpleAndFull;
    TBool m_pathDeclIsEdge;
    TBool m_pathDeclIsStateSimpleIf;
    TBool m_pathDeclIsStateEdgeIf;
    TBool m_pathDeclIsStateSimpleIfNone;
    TBool m_pathDeclhasPolarityOp;
    TInt m_pathDeclCnt;

    //used in pathDelayValue
    TInt m_pathDelayValCnt;
    TInt m_pathDelayValSize;

    //used in minTypMaxList
    TInt m_minTypMaxListCnt;
    TInt m_minTypMaxListSize;

    //used in specifyTerminalList
    TInt m_specifyTListCnt;
    TInt m_specifyTListSize;

    //used in delayedDataOrRef
    TInt m_delayedDataOrRefCnt;
    TInt m_delayedDataOrRefSize;

    //used in timingCkEventCtrl
    TInt m_timingCheckType;
    std::vector<TInt> m_timingCheckEdgeDescriptor;

    //used in timingCkEvent
    TInt m_timingCheckEventType;
    TInt m_timingCheckEventCnt;
    TInt m_timingCheckEventSize;

    //used in timingCk
    TInt m_systemTimingCkType;
    TInt m_systemTimingCkCnt;
    TInt m_systemTimingCkSize;

    //used in gateInstantiation
    TInt m_gateInstanceType;
    TInt m_gateInstanceCnt;
    TInt m_gateInstanceSize;
    TBool m_gateInstanceFlag;
    NSCdom::RefTVec_RefCDOmBase gateVec;
    
    
    //used in pulseControl
    TInt m_pulseControlCnt;
    TInt m_pulseControlSize;
    TBool m_pulseControlLong;
    TBool m_pulseControlSection;

    //used in attrList
    TInt m_attrListCnt;
    TInt m_attrListSize;

    //used in cdomDefine
    TInt m_defineType;
    std::ostream *m_tempStream;

    //used in CDOmNum32
    TBool m_expandNum32; //show base and width or not
    TInt m_num32baseType;
    TBool m_num32signed;
    TInt m_num32value;
    TInt m_num32width;
    TInt m_num32TempWidth;
    //std::string m_num32TempStr;
    RefString m_num32TempStr;
    std::string::iterator m_num32TempIter;
    std::stringstream m_num32Stream;
    TBool m_num32Indent;

    //used in CDOmComment
    TInt  m_commentType;
    TBool m_commentStar;

    //vfInclude
    RefString m_vfIncludeString;

    //NSCdom::RefCDOmDesign m_product;
    //NSCdom::RefCDOmBase m_cdomCurrParent;
    //NSCdom::RefTVec_RefCDOmBase m_traversedChildren;
   public:
    CVerilogGenerator(std::string outputPath);
    ~CVerilogGenerator();

    void indt(TInt size);
    void portListIndt(TInt size);
    //std::string dec2Bin(TInt value, TInt size);
    void copyrightNotice(std::string filename);
    void setVfInclude(RefString plusPath);
    
    void beforeTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 );
    void beforeTraversal(const NSCdom::RefCDOmDesign                          & design                      );
    void beforeTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  );
    void beforeTraversal(const NSCdom::RefCDOmIdentifier                      & id                          );
    void beforeTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    );
    void beforeTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    );
    void beforeTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      );
    void beforeTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    );
    void beforeTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    );
    void beforeTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     );
    void beforeTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     );
    void beforeTraversal(const NSCdom::RefCDOmRange                           & range                       );
    void beforeTraversal(const NSCdom::RefCDOmNum32                           & num                         );
    void beforeTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ){}
    void beforeTraversal(const NSCdom::RefCDOmReal                            & realNum                     );
    void beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         );
    void beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              );
    void beforeTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         );   
    void beforeTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   );
    void beforeTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               );
    void beforeTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   );
    void beforeTraversal(const NSCdom::RefCDOmDelay                           & delay                       );
    void beforeTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                );
    void beforeTraversal(const NSCdom::RefCDOmAssn                            & assn                        );
    void beforeTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    );
    void beforeTraversal(const NSCdom::RefCDOmStmt                            & stmt                        );
    void beforeTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   );
    void beforeTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    );
    void beforeTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   );
    void beforeTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   );
    void beforeTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   );
    void beforeTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  );
    void beforeTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  );
    void beforeTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    );
    void beforeTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      );
    void beforeTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    );
    void beforeTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              );
    void beforeTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    );
    void beforeTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 );
    void beforeTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            );
    void beforeTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   );
    void beforeTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   );
    void beforeTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  );
    void beforeTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             );
    void beforeTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     );
    void beforeTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           );
    void beforeTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            );
    void beforeTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                );
    void beforeTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 );
    void beforeTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 );
    void beforeTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    );
    void beforeTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  );
    void beforeTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    );
    void beforeTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                );
    void beforeTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  );
    void beforeTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     );
    void beforeTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 );
    void beforeTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   );
    void beforeTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 );
    void beforeTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 );
    void beforeTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                );
    void beforeTraversal(const NSCdom::RefCDOmString                          & stringObj                   );
    void beforeTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   );
    void beforeTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                );
    void beforeTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   );
    void beforeTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    );
    void beforeTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              );
    void beforeTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               );
    void beforeTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         );
    void beforeTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            );
    void beforeTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           );
    void beforeTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               );
    void beforeTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              );
    void beforeTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           );
    void beforeTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                );
    void beforeTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    );
    void beforeTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ){}
    void beforeTraversal(const NSCdom::RefCDOmDefine                          & define                      );
    void beforeTraversal(const NSCdom::RefCDOmComment                         & comment                     );

    /*
    void beforeTraversal(const NSCdom::RefCDOmExpr                            & expr                        );
    */

    void inTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 );
    void inTraversal(const NSCdom::RefCDOmDesign                          & design                      );
    void inTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  );
    void inTraversal(const NSCdom::RefCDOmIdentifier                      & id                          );
    void inTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    );
    void inTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    );
    void inTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      );
    void inTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    );
    void inTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    );
    void inTraversal(const NSCdom::RefCDOmRange                           & range                       );
    void inTraversal(const NSCdom::RefCDOmNum32                           & num                         );
    void inTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ){}
    void inTraversal(const NSCdom::RefCDOmReal                            & realNum                     );
    void inTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     );
    void inTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     );
    void inTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         );
    void inTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              );
    void inTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         );   
    void inTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   );
    void inTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               );
    void inTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   );
    void inTraversal(const NSCdom::RefCDOmDelay                           & delay                       );
    void inTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                );
    void inTraversal(const NSCdom::RefCDOmAssn                            & assn                        );
    void inTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    );
    void inTraversal(const NSCdom::RefCDOmStmt                            & stmt                        );
    void inTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   );
    void inTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    );
    void inTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   );
    void inTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   );
    void inTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   );
    void inTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  );
    void inTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  );
    void inTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    );
    void inTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      );
    void inTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    );
    void inTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              );
    void inTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    );
    void inTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 );
    void inTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            );
    void inTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   );
    void inTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   );
    void inTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  );
    void inTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             );
    void inTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     );
    void inTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           );
    void inTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            );
    void inTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                );
    void inTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 );
    void inTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 );
    void inTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    );
    void inTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDecl                  );
    void inTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    );
    void inTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                );
    void inTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  );
    void inTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     );
    void inTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 );
    void inTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   );
    void inTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 );
    void inTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 );
    void inTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                );
    void inTraversal(const NSCdom::RefCDOmString                          & stringObj                   );
    void inTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   );
    void inTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                );
    void inTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   );
    void inTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    );
    void inTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              );
    void inTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               );
    void inTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         );
    void inTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            );
    void inTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           );
    void inTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               );
    void inTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              );
    void inTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           );
    void inTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                );
    void inTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    );
    void inTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ){}
    void inTraversal(const NSCdom::RefCDOmDefine                          & define                      );
    void inTraversal(const NSCdom::RefCDOmComment                         & comment                     );

    /*
    void inTraversal(const NSCdom::RefCDOmExpr                            & expr                        );

    */

    void afterTraversal(const NSCdom::RefCDOmInclude                         & fileInclude                 );
    void afterTraversal(const NSCdom::RefCDOmDesign                          & design                      );
    void afterTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  );
    void afterTraversal(const NSCdom::RefCDOmIdentifier                      & id                          );
    void afterTraversal(const NSCdom::RefCDOmPortItem                        & portItem                    );
    void afterTraversal(const NSCdom::RefCDOmExprLink                        & exprLink                    );
    void afterTraversal(const NSCdom::RefCDOmExprOp                          & exprOp                      );
    void afterTraversal(const NSCdom::RefCDOmListExpr                        & listExpr                    );
    void afterTraversal(const NSCdom::RefCDOmPortDecl                        & portDecl                    );
    void afterTraversal(const NSCdom::RefCDOmVarDecl                         & varDecl                     );
    void afterTraversal(const NSCdom::RefCDOmNetDecl                         & netDecl                     );
    void afterTraversal(const NSCdom::RefCDOmRange                           & range                       );
    void afterTraversal(const NSCdom::RefCDOmNum32                           & num                         );
    void afterTraversal(const NSCdom::RefCDOmVeriNum                         & veriNum                     ){}
    void afterTraversal(const NSCdom::RefCDOmReal                            & realNum                     );
    void afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         );
    void afterTraversal(const NSCdom::RefCDOmModuleOrUdpInstance             & moduleInstance              );
    void afterTraversal(const NSCdom::RefCDOmParamDeclCollection             & paramDeclCollection         );   
    void afterTraversal(const NSCdom::RefCDOmParamDecl                       & paramDecl                   );
    void afterTraversal(const NSCdom::RefCDOmParamOverride                   & paramOverride               );
    void afterTraversal(const NSCdom::RefCDOmMinTypMax                       & minTypMax                   );
    void afterTraversal(const NSCdom::RefCDOmDelay                           & delay                       );
    void afterTraversal(const NSCdom::RefCDOmInitOrAlways                    & initOrAlways                );
    void afterTraversal(const NSCdom::RefCDOmAssn                            & assn                        );
    void afterTraversal(const NSCdom::RefCDOmContAssn                        & contAssn                    );
    void afterTraversal(const NSCdom::RefCDOmStmt                            & stmt                        );
    void afterTraversal(const NSCdom::RefCDOmStmtBlock                       & stmtBlock                   );
    void afterTraversal(const NSCdom::RefCDOmStmtAssn                        & stmtAssn                    );
    void afterTraversal(const NSCdom::RefCDOmEventControl                    & eventCtrl                   );
    void afterTraversal(const NSCdom::RefCDOmEventExpr                       & eventExpr                   );
    void afterTraversal(const NSCdom::RefCDOmDelayControl                    & delayCtrl                   );
    void afterTraversal(const NSCdom::RefCDOmStmtProcContAssn                & stmtPCAssn                  );
    void afterTraversal(const NSCdom::RefCDOmStmtProcTimingControl           & stmtPTCtrl                  );
    void afterTraversal(const NSCdom::RefCDOmStmtCase                        & stmtCase                    );
    void afterTraversal(const NSCdom::RefCDOmStmtIf                          & stmtIf                      );
    void afterTraversal(const NSCdom::RefCDOmStmtLoop                        & stmtLoop                    );
    void afterTraversal(const NSCdom::RefCDOmStmtTaskEnable                  & stmtTaskEnable              );
    void afterTraversal(const NSCdom::RefCDOmStmtWait                        & stmtWait                    );
    void afterTraversal(const NSCdom::RefCDOmStmtDisable                     & stmtDisable                 );
    void afterTraversal(const NSCdom::RefCDOmStmtEventTrigger                & stmtEventTrigger            );
    void afterTraversal(const NSCdom::RefCDOmRangeExpr                       & rangeExpr                   );
    void afterTraversal(const NSCdom::RefCDOmRangeList                       & rangeList                   );
    void afterTraversal(const NSCdom::RefCDOmExprConcat                      & exprConcat                  );
    void afterTraversal(const NSCdom::RefCDOmExprMultiConcat                 & exprMultiConcat             );
    void afterTraversal(const NSCdom::RefCDOmUdpDecl                         & udpDecl                     );
    void afterTraversal(const NSCdom::RefCDOmUdpPortDeclOutput               & udpPortDeclOutput           );
    void afterTraversal(const NSCdom::RefCDOmUdpPortDeclInput                & udpPortDeclInput            );
    void afterTraversal(const NSCdom::RefCDOmUdpCombEntry                    & udpCombEntry                );
    void afterTraversal(const NSCdom::RefCDOmUdpSeqEntry                     & udpSeqEntry                 );
    void afterTraversal(const NSCdom::RefCDOmUdpInitStmt                     & udpInitStmt                 );
    void afterTraversal(const NSCdom::RefCDOmTaskDecl                        & taskDecl                    );
    void afterTraversal(const NSCdom::RefCDOmTFPortDecl                      & tfPortDec                   );
    void afterTraversal(const NSCdom::RefCDOmFuncDecl                        & funcDecl                    );
    void afterTraversal(const NSCdom::RefCDOmFunctionCall                    & functionCall                );
    void afterTraversal(const NSCdom::RefCDOmGenvarDecl                      & genvarDecl                  );
    void afterTraversal(const NSCdom::RefCDOmGenInst                         & genInst                     );
    void afterTraversal(const NSCdom::RefCDOmGenItemNull                     & genItemNull                 );
    void afterTraversal(const NSCdom::RefCDOmGenItemIf                       & genItemIf                   );
    void afterTraversal(const NSCdom::RefCDOmGenItemCase                     & genItemCase                 );
    void afterTraversal(const NSCdom::RefCDOmGenItemLoop                     & genItemLoop                 );
    void afterTraversal(const NSCdom::RefCDOmGenItemBlock                    & genItemBlock                );
    void afterTraversal(const NSCdom::RefCDOmString                          & stringObj                   );
    void afterTraversal(const NSCdom::RefCDOmEventDecl                       & eventDecl                   );
    void afterTraversal(const NSCdom::RefCDOmSpecifyBlock                    & specifyBlock                );
    void afterTraversal(const NSCdom::RefCDOmPulseStyleOrShowCancelledDecl   & pulseSSCd                   );
    void afterTraversal(const NSCdom::RefCDOmPathDecl                        & pathDecl                    );
    void afterTraversal(const NSCdom::RefCDOmPathDelayValue                  & pathDelayValue              );
    void afterTraversal(const NSCdom::RefCDOmMinTypMaxList                   & minTypMaxList               );
    void afterTraversal(const NSCdom::RefCDOmSpecifyTerminalList             & specifyTerminalList         );
    void afterTraversal(const NSCdom::RefCDOmDelayedDataOrReference          & delayedDataOrRef            );
    void afterTraversal(const NSCdom::RefCDOmTimingCheckEventControl         & timingCkEventCtrl           );
    void afterTraversal(const NSCdom::RefCDOmTimingCheckEvent                & timingCkEvent               );
    void afterTraversal(const NSCdom::RefCDOmSystemTimingCheck               & systemTimingCk              );
    void afterTraversal(const NSCdom::RefCDOmGateInstantiation               & gateInstantiation           );
    void afterTraversal(const NSCdom::RefCDOmPulseControl                    & pulseControl                );
    void afterTraversal(const NSCdom::RefCDOmAttrList                        & attrList                    );
    void afterTraversal(const NSCdom::RefCDOmAttrListCollection              & attrListCollection          ){}
    void afterTraversal(const NSCdom::RefCDOmDefine                          & define                      );
    void afterTraversal(const NSCdom::RefCDOmComment                         & comment                     );


    /*
    void afterTraversal(const NSCdom::RefCDOmExpr                            & expr                        );

    */

};
}
