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


#include "CsimInclude.h"
//#include "CsimVectorWriter.h"


#ifndef INC_GUARD_CSIM_UNIT_H
#define INC_GUARD_CSIM_UNIT_H

namespace NSCsimLib {

//**************************************************************************************************************************************************************************
//build function declaration
//**************************************************************************************************************************************************************************

RefCsimUnit build(CsimUnit* unit);

RefCsimVectorWriter buildVW(CsimVectorWriter* vw, RefCsimUnit unit);


//extern RefCsimUnit rootUnit;; //getRootUnit(); //returns top unit - user defined


//**************************************************************************************************************************************************************************
//CSimUnit class
//**************************************************************************************************************************************************************************

/**
 * Class CSimUnit is a pure virtual class. It is used for simulating the exectution of a unit.
 * example:
 *              class UnitA: public CSimUnit{
 *                private:
 *                  int a,b,c;
 *                public:
 *                  void execute(){
 *                    a = b + c;
 *                  }
 *                  void initialize(){
 *                    b = 3;
 *                    c = 5;
 *                  }
 *                  void generate_std::vectors(){//what the ???
 *                  }
 *                  
 *                  UnitA(std::string moduleName,std::string instanceName):CSimUnit(moduleName,instanceName){
 *                  }
 *              };
*/
/**
 * build function for units.
 * Use :share_ptr<UnitA> x=build<UnitA>();
 * If you don't use it that way you will get memory leaks:D 
 * and other nasty errors:D.
*/


class CsimUnit{
  
  private:


    RefString                           m_unitName;
    RefString                           m_instanceName;
    WeakRefCsimUnit                     m_parent;

    RefTVec_RefCsimSignalBase           m_signalBaseVec;
    RefTVec_WeakRefCsimVectorWriter     m_vectorWriterVec;
    RefTVec_RefCsimClock                m_clocksVec;

    RefTVec_RefCsimUnit                 m_children;

  protected:
    WeakRefCsimUnit                     m_weakRef;
    RefCsimUnit   getThis() { return boost::static_pointer_cast<CsimUnit>(m_weakRef.lock()); }


    //CsimUnit(RefString unitName, RefString instanceName, RefCsimUnit parent);
    CsimUnit(RefString unitName);
  public:
    void setWeakRef(RefCsimUnit unit) { m_weakRef = WeakRefCsimUnit(unit); }

    virtual ~CsimUnit();

    virtual void connect()                            = 0;
    virtual void execute()                            = 0;
    virtual void initialize()                         = 0;
    virtual void defaultInitialize()                  = 0;


    const RefString                      getUnitName() const;
    const RefString                      getInstanceName() const;
    RefCsimUnit                          getParent() const ;

    //new
    void                                 setParent(RefCsimUnit parent);
    void                                 setInstanceName(RefString instName);
    //end of new

    RefCsimUnit                          getChildByName(RefString childName) const;
    RefCsimSignalBase                    getSignalByName(RefString signalName) const;
    //    RefCsimVectorWriter                  getVectorWriterByName(RefString vectorWriterName) const;

    void                                 addUnit(RefCsimUnit);
    void                                 addConnectable(RefCsimSignalBase);
    void                                 addVectorWriter(RefCsimVectorWriter);
    void                                 addClock(RefCsimClock);

    RefTVec_RefCsimUnit                  getChildren();
    RefTVec_RefCsimSignalBase            getSignals();
    RefTVec_WeakRefCsimVectorWriter      getVWs();
    RefTVec_RefCsimClock                 getClocks();

};

}


#endif //INC_GUARD_CSIM_UNIT_H

//END OF FILE
