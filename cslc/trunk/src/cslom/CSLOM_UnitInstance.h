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

// Author BogdanZ

#ifndef INC_GUARD_CSLOm_UNIT_INST_h
#define INC_GUARD_CSLOm_UNIT_INST_h

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
// CSLOmParameter class
// ********************************************************************************

/*
class CSLOmParameter : public CSLOmBase {
  public:
    static RefCSLOmParameter cast(RefCSLOmBase object);
    RefCSLOmIdentifier getID() const { return boost::static_pointer_cast<CSLOmIdentifier>(getChild(ID)); }
    RefCSLOmBase getIDAsBase() const { return getChild(ID); }
    RefString getName() const { return getID()->getName(); }
  private:
    RefCSLOmParameter getThis() const { return boost::static_pointer_cast<CSLOmParameter>(m_weakRef.lock()); }
  protected:
    CSLOmParameter(TLineNumberType lineNumber, RefString fileName);
  public:
    static RefCSLOmParameter build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString &name, RefCSLOmExpr defaultValue = RefCSLOmExpr());

    RefCSLOmExpr getDefaultValue() const;
    RefCSLOmBase getDefaultValueAsBase() const;
    const RefString getParamName() const;

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};
*/

// ********************************************************************************
// CSLOmParameterOverride class
// ********************************************************************************
/*
class CSLOmParameterOverride : public CSLOmBase {
  public:
    static RefCSLOmParameterOverride cast(RefCSLOmBase object);
  private:
    RefCSLOmParameterOverride getThis() const { return boost::static_pointer_cast<CSLOmParameterOverride>(m_weakRef.lock()); }
  protected:
    CSLOmParameterOverride(TLineNumberType lineNumber, RefString fileName, const RefString& paramName);
    RefString m_paramName;
    //Only a unit instance can build a Parameter override
    //This is done to ensure that the overridden parameter is registered in the unit instance
    friend class CSLOmUnitInstance;
    static RefCSLOmParameterOverride build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink paramName, RefCSLOmNumber value);
  public:

    const RefString getParamName() const;
    RefCSLOmNumber getValue() const;
    RefCSLOmBase getValueAsBase() const;

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};
*/

// ********************************************************************************
// CSLOmUnitInstance class
// ********************************************************************************
/**
 * Bogdan, I hope this is out of date:
 * this i really donno what it supposed to do
 * for now it does exactly like in unitdecl
 *
 * An instance is the "flexible form" of a unit.
 * If you think at the csl unit as the rigid pattern, then the instance
 * is its "working copy".
 * An instance can support the same operations as those performed on a unit,
 * except addInterface(a csl interface is also some kind of pattern).
 * That leaves us with: addPort, addPortList and addSignal.
 * The changes caused inside the instance by the commands above
 * can influence the unit or not depending on whether the 
 * instance alteratin bit is set or not.
 * @see CSLOmUnitDecl
 */

class CSLOmUnitInstance : public CSLOmBase {
  public:
    static RefCSLOmUnitInstance cast(RefCSLOmBase object);

    /**
     * API functions to return the ID, name, parameters, type, and formal to actual mapping of the instance
     */
    RefCSLOmIdentifier getID() const { return boost::static_pointer_cast<CSLOmIdentifier>(getChild(ID)); }
    RefCSLOmBase getIDAsBase() const { return getChild(ID); }
    RefString getName() const { return getID()->getName(); }
    //RefTVec_RefCSLOmParameterOverride getOverrides() const { return getChildren<CSLOmParameterOverride>(TYPE_PARAMETER_OVERRIDE); }
    //RefTVec_RefCSLOmBase getOverridesAsBase() const { return getChildrenAsBase(TYPE_PARAMETER_OVERRIDE); }

    const RefTMap_RefCSLOmExprLink_RefCSLOmExpr getConnectionMap() const {return m_connections;}
    void addConnectionPair(RefCSLOmExpr, RefCSLOmExprLink);
  private:

    /**
     * API function to return the this smart pointer
     */
    RefCSLOmUnitInstance getThis() const { return boost::static_pointer_cast<CSLOmUnitInstance>(m_weakRef.lock()); }
  protected:
    CSLOmUnitInstance(TLineNumberType, RefString fileName);
    // Formal to actual mapping
    RefTMap_RefCSLOmExprLink_RefCSLOmExpr m_explicitPortNameMap; 
//    // Parameter Override map for current instance
//    RefTMap_RefString_RefCSLOmNumber m_parameterOverrideMap;
    RefTMap_RefCSLOmExprLink_RefCSLOmExpr m_connections;
    WeakRefCSLOmConnectable m_associatedClock;

  public:
    /** Builds a unitInstance object. See CSLOmUnitInstantiation.
     *  csl_unit a, b;                 // CSLOmUnitDecl a and CSLOmUnitDecl b constructed
     *  a.add_instance(b,b0);          // CSLOmUnitDecl::addInstance() calls the build method for CSLOmUnitInstantiation
     *                                 // Thus, CSLOmUnitInstantiation bTOb0 is constructed
     *                                 // Then, the same CSLOmUnitDecl::addInstance calls the bTOb0->buildUnitInstance() function 
     *                                 // That function finally calls the CSLOmUnitInstance::build() function,
     *                                 // therefore, CSLOmUnitInstance b0 is built
     * The CSLOM tree for the 2 csl commands above is:
     *                                        CSLOmDesign design
     *                                      /                   \                 
     *                        CSLOmUnitDecl a                   CSLOmUnitDecl b
     *                              |
     *                        CSLOmUnitInstantiation bTOb0
     *                          |                |
     *                   CSLOmExprLink b       CSLOmUnitInstance b0
     *  
     */
    static RefCSLOmUnitInstance build(TLineNumberType, RefString fileName, RefCSLOmBase, const RefString&/*, RefCSLOmBitRange*/);
//    /** Overrides the value of the parameter set inside the unit by the addParam() function in CSLOmUnitDecl
//     * Bogdan, you need to explain the code of this function to me.
//     */
//    void paramOverride(TLineNumberType lineNumber, RefString fileName, RefCSLOmExprLink paramName, RefCSLOmNumber value);

    /** The following methods add a signal to the instance. 
     * Both of them can only be called if instance alteration bit is set to true.
     * If that is so, the added signal's parent will be the unit (b, in the example above), not the instance.
     */
    void addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& signalName, RefCSLOmExprLink bitRange);
    void addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& signalName, ECSLOmSignalType signalType );
    
    /** The following methods add a port/port list to the instance. 
     * Both of them can only be called if instance alteration bit is set to true.
     * If that is so, the added port's/port list's parent will be the unit(b, in the example above), not the instance.
     */
    void addPort(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection portType, ECSLOmSignalType signalType, const RefString& portName, RefCSLOmExprLink bitRange);
    void addPortList(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection portType, ECSLOmSignalType signalType, RefCSLOmList name, RefCSLOmExprLink bitRange);

    void addPortConnection(RefCSLOmExprLink instancePort, RefCSLOmExprLink unitPort);
    /** Returns the CSLOmUnitDecl object built for the unit that created the instance.
     * Considering the example above, the returned object is CSLOmUnitDecl b
     */
    RefCSLOmUnitDecl getUnitDecl() const;

    /**
     *  internal method needed to copy the params from decl to inst (overridding)
     **/
    void copyParametersFromDeclToInst();

    /*
     *  add a parameter to the instance (parameter overriding)
     */
    RefCSLOmParameter addParameter(TLineNumberType lineNumber, RefString fileName, RefCSLOmExprLink paramLink, RefCSLOmNumber value = RefCSLOmNumber());


    /*
     *  get all the parameters (the overridden instance parameters)
     */
    RefTVec_RefCSLOmBase getParameters() const;

    TBool wasAssociatedClockSet() const;

    void associateClock(RefCSLOmConnectable);

    RefCSLOmConnectable getAssociatedClock() const;


    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const ;
};

// ********************************************************************************
// CSLOmUnitInstantiation class
// ********************************************************************************
class CSLOmUnitInstantiation : public CSLOmBase {
  public:
    static RefCSLOmUnitInstantiation cast(RefCSLOmBase object);
  private:
    RefCSLOmUnitInstantiation getThis() const { return boost::static_pointer_cast<CSLOmUnitInstantiation>(m_weakRef.lock()); }
    CSLOmUnitInstantiation(TLineNumberType lineNumber, RefString fileName);
    
    friend class CSLOmUnitInstance;
    friend class CSLOmUnitDecl;
    friend class CSLOmTestbenchDecl;
    /**
     * Build function creates a UnitInstantiation object
     *
     * csl_unit a,b;   // b is a unitDecl  
     * a.add_instance(b,b0); // b is an exprLink (a link to the unitDecl with the same name from above)
     *
     * Consider the example above:
     * The CSLOmUnitDecl class addInstance function calls the CSLOmUnitInstantiation build method.
     * Thus, the params of the CSLOmUnitInstantiation build are:
     * lineNumber
     * parent          = CSLOmUnitDecl object built for unit a
     * unitExprLink    = CSLOmExprLink object built for b 
     * Keep in mind: the CSLOmUnitInstantiation object is the child of the CSLOmUnitDecl object built for unit a (*1) 
     * and the parent of the CSLOmExprLink object built for b (*2)
     * 
     * @param line number where the instantiation was in the program
     * @param parent the parent of the instantiation
     * @param the unit name instantiated
     * 
     * @return a RefCount to a CSLOmUnitInstantiation
     */
  protected:
    static RefCSLOmUnitInstantiation build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink unitExprLink);
    /**
     * Builds an instance. Therefore, the CSLOmUnitInstance object built for instance b0 
     * from the example above is not the direct child of the CSLOmUnitDecl object built for unit a.
     * Its parent is the CSLOmUnitInstantiation object especially created for this purpose.
     */
    RefCSLOmUnitInstance buildUnitInstance(TLineNumberType lineNumber, RefString fileName, const RefString& instName/*, RefCSLOmBitRange bitRange*/);

  public:
    /**
     * Returns the instances(of the current instantiation type)
     * Considering the example above, the returned item is the CSLOmUnitInstantiation object 
     * built for b0
     */
    RefTVec_RefCSLOmUnitInstance getUnitInstances() const;
    const RefTVec_RefCSLOmBase   getUnitInstancesAsBase() const;
    
    /**
     * Returns the expression link to the unitDecl, of the current instantiation type.
     * Considering the example above, the returned item is the CSLOmExprLink object 
     * built for b(in the second row of the example).
     */
    RefCSLOmExprLink getUnitDeclExprLink() const;
    const RefCSLOmBase getUnitDeclExprLinkAsBase() const;

    /**
     * Returns the unitDecl, of the current instantiation type.
     * Considering the example above, the returned item is the CSLOmUnitDecl object 
     * built for b(in the first row of the example).
     */
    RefCSLOmUnitDecl getUnitDecl() const;
  
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

}

#endif
