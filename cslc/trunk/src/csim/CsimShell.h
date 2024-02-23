//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007 Fastpath Logic
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


#ifndef INC_GUARD_CSIM_SHELL_H
#define INC_GUARD_CSIM_SHELL_H

#include "CsimTypeDefs.h"
#include "CsimCmdLine.h"
#include "CsimSimulator.h"
#include "CsimCmdLineTypeDefs.h"
#include "CsimCmdLineExpr.h"
#include "CsimCmdLineExprNum.h"
#include "CsimCmdLineExprId.h"
#include "CsimCmdLineExprOper.h"
#include "CsimCmdLineExprTree.h"
#include "CsimCmdLineExprIdSignal.h"
#include "CsimCmdLineExprIdUnit.h"
#include "CsimCmdLineExprIdMemory.h"
#include "CsimCmdLineExprIdClock.h"

namespace NSCsimLib {


struct less_RefString {
    TBool operator() (const RefString& s1, const RefString& s2) const;
};



class CsimShell {

  public:
    //TYPEDEFS

    typedef void (CsimShell::*TCmdFunc) (RefTVec_RefString);

    typedef std::map<RefString, TCmdFunc, less_RefString>  TMap_RefString_TCmdFunc;

    typedef boost::shared_ptr<TMap_RefString_TCmdFunc>     RefTMap_RefString_TCmdFunc;

    typedef std::map<RefString, EShellCmdOption, less_RefString>  TMap_RefString_EShellCmdOption;

    typedef boost::shared_ptr<TMap_RefString_EShellCmdOption>     RefTMap_RefString_EShellCmdOption;

    typedef std::map<RefString, EExprOperType, less_RefString>  TMap_RefString_EExprOperType;

    typedef boost::shared_ptr<TMap_RefString_EExprOperType>     RefTMap_RefString_EExprOperType;

    //END OF TYPEDEFS

  private:

    static RefCsimShell                 m_shell;

    static RefTMap_RefString_TCmdFunc   m_cmdMap;

    RefCsimSimulator            m_simulator;

    RefCsimCmdLine              m_cmdLine;

    TBool                       m_quitFlag;

    RefCsimUnit                 m_topUnit;

    RefCsimUnit                 m_currentUnit;

    static RefTMap_RefString_EShellCmdOption  m_cmdOptionMap;

    static RefString  m_numberAllowedChars;
    
    static RefString  m_identifierAllowedChars;

    static RefString  m_operatorAllowedChars;

    static RefTMap_RefString_EExprOperType m_opMap;

    //    static RefString  m_cmdOptionAllowedChars;

    RefTVec_RefCsimCmdLineExpr  m_breakExprVec;

    RefTVec_TInt                m_breakExprNoVec;

    RefTVec_RefString           m_breakExprStrVec;

    TBool                       m_breakShell;

    RefTVec_RefCsimCmdLineExprId m_watchExprVec;

    CsimShell();

    void initialize();

  public:

    static RefCsimShell  getInstance();

    RefTVec_RefString getCurrentPath();

    RefTVec_RefString  getIdPath(RefString id);

    RefCsimCmdLineExprId isId(RefString id, EShellCmdOption type = CMD_OPTION_UNDEF);

    TBool isNum(RefString num);

    EExprOperType isOp(RefString op);

    EShellCmdOption isCmdOption(RefString str);

    TInt getIntFromStr(RefString num);

    RefTVec_RefCsimCmdLineExpr getExprVec(TVec_RefString::iterator& it, TVec_RefString::iterator end);

    TBool containsOnlyAllowedChars(RefString str);

    TBool canItBeOp(RefString str) ;

    TBool canItBeNumber(RefString str) ;

    TBool canItBeIdentifier(RefString str) ;

    TBool  canItBeCmdOption(RefString str);

    RefTVec_RefString getStringVec(RefString);

    void start(RefString fileName = RefString());

    void runCmd         (RefTVec_RefString);

    void setCmd         (RefTVec_RefString);

    void printCmd       (RefTVec_RefString);

    void breakCmd       (RefTVec_RefString);

    void watchCmd       (RefTVec_RefString);

    void lsCmd          (RefTVec_RefString);

    void cdCmd          (RefTVec_RefString);

    void loadCmd        (RefTVec_RefString);

    void genVectorCmd   (RefTVec_RefString);

    void genArchstateCmd(RefTVec_RefString);

    void helpCmd        (RefTVec_RefString);

    void quitCmd        (RefTVec_RefString);
    
    void continueCmd    (RefTVec_RefString);
    
    void disableCmd     (RefTVec_RefString);

    void enableCmd      (RefTVec_RefString);

    void pwdCmd         (RefTVec_RefString);

    void stopwatchCmd   (RefTVec_RefString);

    void print          (RefString&);

    void versionCmd     (RefTVec_RefString);

};

}

#endif // INC_GUARD_CSIM_SHELL_H

//END OF FILE 

