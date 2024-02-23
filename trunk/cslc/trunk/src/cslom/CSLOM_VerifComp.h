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

// Author AndreiS

#ifndef INC_GUARD_CSLOm_VERIF_COMP_h
#define INC_GUARD_CSLOm_VERIF_COMP_h

#include "Base.h"
#include "../support/CommonSupport.h"
#include "VeriNum.h"
#include "CSLOM_Declarations.h"
#include "CSLOM_Base.h"
#include "CSLOM_Scoping.h"

namespace NSCSLOmVisitor {
class CVisitor;
}

namespace NSCSLOm {

// ********************************************************************************
// CSLOmVerifCompInfo class
// ********************************************************************************
class CSLOmVerifCompInfo:public CSLOmUnitInfo{
  public:
    enum ECSLOmVCRadix{
      VC_RADIX_UNDEFINED,
      VC_RADIX_BIN,
      VC_RADIX_HEX,
      VC_RADIX_MAX
    };
    
    enum ECSLOmVCEdgeType{
      VC_EDGE_UNDEFINED,
      VC_EDGE_RISE,
      VC_EDGE_FALL,
      VC_EDGE_MAX
    };
    
  protected:
    ECSLOmVCRadix m_radix;
    ECSLOmVCEdgeType m_captureEdgeType;
    
    TInt m_numericID;
    TInt m_version;
    TInt m_maxEventsCount;
    TInt m_maxMismatchesCount;
    TInt m_timeout;
    TInt m_maxNumStates;
    TInt m_numOfTransactionsEvents;
    TInt m_maxCycles;
        
    RefString m_vcName;
    RefString m_vcHeaderComment;
    RefString m_outputFilename;
    RefString m_cppRDName;
    RefString m_cppWRName;

    RefCSLOmSignal m_clock;
    RefCSLOmSignal m_reset;
    RefCSLOmSignal m_stall;
    RefCSLOmSignal m_compareTrigger;
    RefCSLOmSignal m_startGenerationTrigger;
    RefCSLOmSignal m_endGenerationTrigger;
    

    TBool m_alreadySetVcName;

  public:
     /*
     *set functions
     */
    //ints
    void setNumericID(RefCSLOmExpr numericExpr);
    void setVersion(RefCSLOmExpr numericExpr);
    void setMaxEventsCount(RefCSLOmExpr numericExpr);
    void setMaxMismatchesCount(RefCSLOmExpr numericExpr);
    void setTimeout(RefCSLOmExpr numericExpr);
    void setMaxNumStates(RefCSLOmExpr numericExpr);
    void setNumOfTransactionEvents(RefCSLOmExpr numericExpr);
    void setMaxCycles(RefCSLOmExpr numericExpr);
    
    //enums and strings
    void setName(const RefString &inputValue);
    void setVCHeaderComment(const RefString &inputValue);
    void setOutputFilename(const RefString &inputValue);
    void setCppRDName(const RefString &inputValue);
    void setCppWRName(const RefString &inputValue);
    void setRadix(ECSLOmVCRadix inputValue);
    void setCaptureEdgeType(ECSLOmVCEdgeType inputValue);

    //signals
    void setClock(RefCSLOmSignal inputValue);
    void setReset(RefCSLOmSignal inputValue);
    void setStall(RefCSLOmSignal inputValue);
    void setCompareTrigger(RefCSLOmSignal inputValue);
    void setStartGenerationTrigger(RefCSLOmSignal inputValue);
    void setEndGenerationTrigger(RefCSLOmSignal inputValue);
    
    /*
     *get functions
     */
    //ints
    RefCSLOmNumber getNumericID()                       const;
    RefCSLOmNumber getVersion()                         const;
    RefCSLOmNumber getMaxEventsCount()                  const;
    RefCSLOmNumber getMaxMismatchesCount()              const;
    RefCSLOmNumber getTimeout()                         const;
    RefCSLOmNumber getMaxNumOfStates()                  const;
    RefCSLOmNumber getNumOfTransactionEvents()          const;
    RefCSLOmNumber getMaxCycles()                       const;

    //enums and strings
    RefString getName()                                 const;
    RefString getVCHeaderComment()                      const;
    RefString getOutputFilename()                       const;
    RefString getCppRDName()                            const;
    RefString getCppWRName()                            const;
    ECSLOmVCRadix getRadix()                            const;
    ECSLOmVCEdgeType getCaptureEdgeType()               const;

    //signals
    RefCSLOmSignal getClock()                           const;
    RefCSLOmSignal getReset()                           const;
    RefCSLOmSignal getStall()                           const;
    RefCSLOmSignal getCompareTrigger()                  const;
    RefCSLOmSignal getStartGenerationTrigger()          const;
    RefCSLOmSignal getEndGenerationTrigger()            const;
    

    static RefCSLOmVerifCompInfo cast(RefCSLOmBase object);

  protected:
    CSLOmVerifCompInfo(TLineNumberType lineNumber, RefString fileName);
    RefCSLOmVerifCompInfo getThis() const { return boost::static_pointer_cast<CSLOmVerifCompInfo>(m_weakRef.lock()); }

};


// ********************************************************************************
// CSLOmVectorInfo class
// ********************************************************************************


class CSLOmVectorInfo:public CSLOmVerifCompInfo{
  private:
    //will be stimulus for true, else expected for false (default = stimulus)
    TBool m_stimulusElseExpected;

    RefCSLOmExprLink m_moduleName;

    //the ports and ifc
  public:
    RefTVec_RefCSLOmExprLink m_ports;
    RefTVec_TBool m_portMask;
  private:
    ECSLOmPortDirection m_direction;
    /**
     * Variable used to specify if the command include_only has been called. The command can only be called once.
     */
    TBool m_includeOnlyUsed;
   
    
  public:
    static RefCSLOmVectorInfo cast(RefCSLOmBase object);
    static RefCSLOmVectorInfo build(TLineNumberType lineNumber, RefString fileName,RefCSLOmUnitDecl unitDecl);
    
    //set functions
    void setModuleName(RefCSLOmExprLink input);
    void setStimulusElseExpected(TBool incValue);

    //filename
    RefString getStimulusFilename();
    RefString getExpectedFilename();
    RefString getFilename();
    
    //inclusion/exclusion direction
    void setDirection(ECSLOmPortDirection direction);
    void excludePorts(RefTVec_TInt portList);
    void includeOnlyPorts(RefTVec_TInt portList);
    RefTVec_RefCSLOmExprLink getDUTInputPorts();
    RefTVec_RefCSLOmExprLink getDUTOutputPorts();
    RefTVec_RefCSLOmExprLink getAssociatedPorts();
    RefTVec_RefCSLOmExprLink getAllPorts();

  private:
    void resetPortMask();
    
  public:   
    //get functions
    RefCSLOmExprLink getModuleName() const;
    ECSLOmPortDirection getDirection() const;
    TBool getStimulusElseExpected() const;
    TBool getIncludeOnlyUsed() const;

  protected:
    CSLOmVectorInfo(TLineNumberType, RefString);
    RefCSLOmVectorInfo getThis() const { return boost::static_pointer_cast<CSLOmVectorInfo>(m_weakRef.lock()); }

  public:
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};



// ********************************************************************************
// CSLOmStateDataInfo class
// ********************************************************************************

class CSLOmStateDataInfo:public CSLOmVerifCompInfo{
  private:
    RefCSLOmExprLink m_instanceName;

  public:    
    static RefCSLOmStateDataInfo build(TLineNumberType lineNumber, RefString fileName,RefCSLOmUnitDecl parent);
    static RefCSLOmStateDataInfo cast(RefCSLOmBase object);
    void setInstanceName(RefCSLOmExprLink input);
    RefCSLOmExprLink getInstanceName() const;
    
  protected:
    CSLOmStateDataInfo(TLineNumberType, RefString);
    RefCSLOmStateDataInfo getThis() const { return boost::static_pointer_cast<CSLOmStateDataInfo>(m_weakRef.lock()); };
};

}

#endif
