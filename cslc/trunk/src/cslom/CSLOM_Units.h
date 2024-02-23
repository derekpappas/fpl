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

// Author BogdanZ & OctavS & AndreiS

#ifndef INC_GUARD_CSLOm_UNITs_h
#define INC_GUARD_CSLOm_UNITs_h

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
// CSLOmUnitDecl class
// ********************************************************************************
/**
 * class that describes a unit definition
 * if a unit inof is associated with it then it will hold the desciption of:
 * a fifo, testbench, register, register file or memory
 *
 *
 * Children:
 * m_children[0] - ID - RefCSLOmIdentifier
 * m_children[1] - default interface - RefCSLOmInterface -> holds all the ports and interfaces from that unit
 * m_children[2] - unit info - info class for fifo, testbench etc.
 * m_children[3+] - signals, signal groups, unit instances, bitranges etc.
 */
class CSLOmUnitDecl : public CSLOmBase {
  public:

    enum EUnitType {
      CSL_UNDEFINED,
      CSL_UNIT_DECL,
      CSL_FIFO_DECL,
      CSL_TESTBENCH_DECL,
      CSL_REGISTER_DECL,
      CSL_REGISTER_FILE_DECL,
      CSL_MEMORY_DECL,
      CSL_STATE_DATA,
      CSL_VECTOR,
      CSL_UNIT_REPLICA,
      CSL_MAX
    };
    TBool isReplica() { return m_unitType == CSL_UNIT_REPLICA; }

    virtual ~CSLOmUnitDecl() {}
    
    static RefCSLOmUnitDecl cast(RefCSLOmBase object);

    /**
     * returns the id of the unitDecl
     */
    RefCSLOmIdentifier getID() const { return boost::static_pointer_cast<CSLOmIdentifier>(getChild(ID)); }
    RefCSLOmBase getIDAsBase() const { return getChild(ID); }

    /**
     * returns the name of the unitDecl
     */
    RefString getName() const { return getID()->getName(); }

    /**
     * returns all the instantiations present in the current unitDecl
     */
    virtual RefTVec_RefCSLOmUnitInstantiation getInstantiations() const { return getChildren<CSLOmUnitInstantiation>(TYPE_UNIT_INSTANTIATION); }
    virtual RefTVec_RefCSLOmBase              getInstantiationsAsBase() const { return getChildrenAsBase(TYPE_UNIT_INSTANTIATION); }

    /**
     * returns all the signals present in the current unitDecl
     */
    virtual RefTVec_RefCSLOmSignal       getSignals() const { return getChildren<CSLOmSignal>(TYPE_ALL_SIGNALS); }
    virtual RefTVec_RefCSLOmBase         getSignalsAsBase() const { return getChildrenAsBase(TYPE_ALL_SIGNALS); }
    virtual RefTVec_RefCSLOmGroupSignal  getSignalGroups() const { return getChildren<CSLOmGroupSignal>(TYPE_ALL_GROUPS); }
    virtual RefTVec_RefCSLOmBase         getSignalGroupsAsBase() const { return getChildrenAsBase(TYPE_ALL_GROUPS); }
    virtual RefTVec_RefCSLOmBase         getUnitParamsAsBase() const { return getChildrenAsBase(TYPE_PARAMETER); }

    /**
     * All units in csl have a default interface which is constructed in the build method(*1). </br>
     * The dafault interface is the first child of CSLOmUnitDecl and initially it is void. </br>
     * Afterwards, whenever the user adds an interface(addInterface) or a port(addPort) 
     * or a port list(addPortList) to the unit, he does so via the default interface. </br>
     * csl_unit a;     // 1. a CSLOmUnitDecl object is created </br>
      *                 //    params of the build function: lineNumber, design, "a" </br>
     *                 // 2. default interface *a_default_ifc is created </br>
     *                 //    as the first child of CSLOmUnitDecl object </br>
     * a.add_port(p);  // 3. port p is built inside the addPort function </br>
     *                 //    and its parent is *a_default_ifc </br>
     *                 //    (more precisely the CSLOmInterface object created with that name) </br>
     */
    virtual RefCSLOmInterface getDefaultInterface() const { return boost::static_pointer_cast<CSLOmInterface>(getChild(DEFAULT_IFC)); }
    virtual RefCSLOmBase      getDefaultInterfaceAsBase() const { return getChild(DEFAULT_IFC); }
    virtual EUnitType getUnitType() const { return m_unitType; }
    void setUnitType(EUnitType type) {
      ASSERT((type > CSL_UNDEFINED) && (type < CSL_MAX), "wrong enum value");
      m_unitType = type;
    }
    virtual RefCSLOmUnitInfo getUnitInfo() const;
  private:
    RefCSLOmUnitDecl getThis() const { return boost::static_pointer_cast<CSLOmUnitDecl>(m_weakRef.lock()); }

    /** 
     * STATE_UNDEFINED and STATE_MAX are used for defensive purposes: </br>
     * STATE_UNDEFINED is assigned the smallest integer value in the enum,</br>
     * and STATE_MAX the largest, thus it is easy to check whether the value </br>
     * assigned to m_state is within bounds or not. </br>
     */
    enum EState { 
      STATE_UNDEFINED,
      STATE_INIT, 
      STATE_NO_PARAMS,
      STATE_MAX
    };


    RefTVec_WeakCSLOmUnitInstance m_instances;
    RefTVec_WeakCSLOmVerifCompInfo m_verifComps;

    /** The equivalent of a csl unit in verilog is a module.</br>
     * Csl allows the import of verilog models in the csl code, as well as the </br>
     * generation of verilog modules from csl units.The type of te verilog version </br>
     * has to be specified in both cases. </br>
     */
    EVerilogType m_inputVerilogType;
    EVerilogType m_outputVerilogType;

    EUnitType m_unitType;

    RefString m_signalPrefixLocal;
    RefString m_signalPrefixIO;
    RefCSLOmNumber m_numId;
    RefCSLOmNumber m_address;
    /** Units in csl have instances. Instances are some sort of "working copies"  </br>
     * of the units(See CSLOmUnitInstantiation and CSLOmUnitInstance).</br>
     * If m_instanceAlterationBit is set, then whatever changes are made to the </br>
     * instance, they are also reflected on to the unit. If not, the unit stays the same </br>
     * no matter what modifications the unit goes through. </br>
     */
    TBool m_instanceAlterationBit;
    TBool m_isVisited;
    TBool m_isInstantiated;
    RefCSLOmUnitInfo buildInfoObject();
  protected:
    CSLOmUnitDecl(TLineNumberType lineNumber, RefString fileName, EUnitType type);
    
    TBool m_doNotGenRTL;
    TBool m_genUniqueRTL;
    TBool m_doNotGenCPP;

    /** 
     * The unit prefix is meant for adapter(CSLOM to CDOM) use.
     */
    RefString m_unitPrefix;
    /** Units in csl are scope holders, meaning that all the operations performed on a unit(and more)</br>
     * can be organised inside a scope:  <br>
     * csl_unit a,b; </br>
     * scope a { </br>
     *   [a.]add_instance(b,b0); // Inside the scope of unit a it is not necessary to specify its name.</br>
     *   b.add_port(p);          // Performing an operation on unit b inside the scope of unit a </br>
     *                           // makes it mandatory to specify the name of the "foreign" unit(b). </br>
     * }
     * scope b { </br>
     *   add_port(q); </br>
     * } </br>
     * For the scope of each unit a CSLOmScope object is built(*2).</br>
     * (See CSLOmScope to find out why the id is necessary). </br>
     * The m_scope private member is the holder of that scope.</br>
     */
    RefCSLOmScope m_scope;
    EState m_state;
    TBool m_isDUT;
    WeakRefCSLOmConnectable m_associatedClock;
  public:
    void doNotGenerateRTL() { m_doNotGenRTL = TRUE; }
    virtual TBool isSetDoNotGenerateRTL() const { return m_doNotGenRTL; }

    void doNotGenerateCPP() { m_doNotGenCPP = TRUE; }
    virtual TBool isSetDoNotGenerateCPP() const { return m_doNotGenCPP; }

    void generateUniqueRTL();
    virtual TBool isSetGenerateUniqueRTL() const { return m_genUniqueRTL; }

    void visitUnit() { m_isVisited = TRUE; }
    TBool isVisited() { return m_isVisited; }

    virtual TBool isDUT() const { return m_isDUT; }
    void registerInstance(RefCSLOmUnitInstance inst);
    void registerVerifComp(RefCSLOmVerifCompInfo verifComp);

    //    RefTVec_RefCSLOmUnitInstance  getChildInstances() const; 
    virtual RefTVec_WeakCSLOmUnitInstance  getInstances() const { return m_instances; } 
    virtual RefTVec_WeakCSLOmVerifCompInfo getVerifComps() { return m_verifComps; }

    /**
     * This is the csl_unit build method. According to csl_unit specification we create a 
     * generic unit that becomes specific as we perform commands on the unit.
     * The csl_unit is registered in the global scope for now, meaning the parent 
     * must always be a design object.     
     * A default interface and a scope are implicitly built for each unitDecl object(see above).
     * Example:
     *
     * ...
     * line 10:    csl_unit u;   // build params: lineNumber   10
     *                           //               parent       CSLOmDesign
     *                           //               name         "u"
     * ...                    
     *
     * @param lineNumber - type TLineNumberType - the line number where the csl_unit declaration apears
     * @param parent - type RefCSLOmDesign - the parent of the declaration
     * @param name - type RefString - the name of the csl_unit
     *
     * @return RefCSLOmUnitDecl - the object that has been built
     *
     * @see CSLOmDesign
     * @see CSLOmUnitInstantiation
     * @see CSLOmUnitInstance
     */
    static RefCSLOmUnitDecl build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, EUnitType type = CSL_UNIT_DECL);

    //csl_unit command section
    //the csl_command are performed on the unit after the scope structure is built
    
    void setUnitPrefix(const RefString& prefix);
    virtual const RefString getUnitPrefix() const;

    /**
     * set/get for unit numerical id
     */
    void setUnitNumericID(RefCSLOmNumber num);
    virtual const RefCSLOmNumber getUnitNumericID() const;

    /**
     * set/get for unit address
     */
    void setUnitAddress(RefCSLOmNumber num);
    virtual const RefCSLOmNumber getUnitAddress() const;

    /**
     * set/get for units external enable signal
     */
    void setExternalUnitEnable(RefCSLOmExprLink enLink);
    virtual const RefCSLOmExprLink getExternalUnitEnable() const;

    /**
     * create methods for internal enable signal of the unit
     */
    void genInternalUnitEnable(const RefString& enName);

    //TODO see if we should set a default name
    /** Adds an instance(of another unit) to the current unit.
     * ......
     * line10: csl_unit a,b;               //current unit: a
     * line11: a.add_unit(b,b0);           //addInstance params:  lineNumber                  11
     *                                     //                     exprLink to unitDecl        b
     *                                     //                     instanceName                b0
     * This function performs two consecutive build calls: (*3 and *4)
     * See CSLOmUnitInstantiation and CSLOmUnitInstance for details.
     */
    void addInstance(TLineNumberType, RefString fileName,RefCSLOmExprLink, const RefString&, RefTVec_RefCSLOmExpr/*, RefCSLOmBitRange*/);
    void addInstance(TLineNumberType, RefString fileName,RefCSLOmExprLink, const RefString&, const RefTMap_RefCSLOmExprLink_RefCSLOmExpr&);
    void addInstanceList(TLineNumberType, RefString fileName,RefCSLOmExprLink, RefCSLOmList/*, RefCSLOmBitRange*/);
    RefTVec_RefCSLOmUnitInstance getUnitInstances();
    /** Adds a parameter to the unit. 
     * Therefore, the build function for the CSLOmParameter class is called.
     */
    void addParameter(TLineNumberType lineNumber, RefString fileName, const RefString& paramName, RefCSLOmNumber value);
    /** Adds a signal to the unit
     * by calling the CSLOmSignal build method.
     * csl_unit a;
     * csl_signal s(16),t(wire),v(32);
     * a.add_signal(s);           // the first addSignal function is called
     * a.add_signal(t,32);        // the second addSignal function is called
     * a.add_signal(v,wire);      // the third addSignal function is called
     * Please note that signals are the only "direct" children of the CSLOmUnitDecl object,
     * meaning that they are not set as children of the default interface.
     */
    void addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& signalName);
    void addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& signalName, RefCSLOmExprLink bitRange);
    RefCSLOmSignal addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& signalName, ECSLOmSignalType signalType, RefCSLOmExprLink bitRange = RefCSLOmExprLink());

    void addSignalList(TLineNumberType lineNumber, RefString fileName, RefCSLOmList list, ECSLOmSignalType signalType, RefCSLOmExprLink bitRange = RefCSLOmExprLink());
    void addSignalGroup(TLineNumberType lineNumber, RefString fileName, RefCSLOmGroupSignal signalGroup);

    /** The following two methods add a port or a port_list to the unitDecl.
     * Beware, there is NO CSLOmPort class as a port cannot be declared in csl.
     * Thus, the  and the addPortList methods in CSLOmInterface are called.
     *
     * Although signalType and bitRange are optional params in the csl add_port and add_port_list commands, 
     * the corresponding functions in CSLOm set the two params as mandatory.
     * This is so due to consistency reasons: the two function prototypes have to match 
     * the ones in CSLOM_cmd, which is a sort of "interface" for all CSLOm functions that 
     * have to do with csl commands. 
     * That means that the tree walker calls the functions from CSLOM_cmd which then call the 
     * appropriate functions from CSLOM.
     * If the optional params in the csl code were not set
     * by the user, then the functions in the CSLOM_cmd will set the default values
     * and use them when calling the functions from CSLOM.
     */
    RefCSLOmPortDecl addPort(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection portType, ECSLOmSignalType signalType, const RefString& portName, RefCSLOmExprLink bitRange);
    void addPortList(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection portType, ECSLOmSignalType signalType, RefCSLOmList name, RefCSLOmExprLink bitRange);
    
    /** Adds an interface to the current unit:
     * ...
     * line10: csl_interface ifc;
     * line11: csl_unit a;
     * line12: a.add_interface(ifc,ifc0); // addInterface params:
     *                                    // lineNumber             12 
     *                                    // exprLink to interface  ifc
     *                                    // name                   ifc0
     * As explained before, although the user is not aware of this hidden mechanism,
     * an interface is not directly added to the unit, meaning the parent of the CSLOmInterface
     * object being added is another CSLOmInterface object(the default interface) whoose parent is,finally,
     * the CSLOmUnitDecl object. 
     * See the second build function in CSLOmInterface for details.
     */
    void addInterface(TLineNumberType lineNumber, RefString fileName, const RefCSLOmExprLink ifc, const RefString& ifcName);
    void addInterface(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection direction, const RefCSLOmExprLink ifc, const RefString& ifcName);

    //TODO implement this
    void setSignalPrefixLocal(const RefString& prefix);
    void setSignalPrefixIO(const RefString& prefix);

    virtual EVerilogType getInputVerilogType() const;
    void setInputVerilogType(EVerilogType type);
    virtual EVerilogType getOutputVerilogType() const;
    void setOutputVerilogType(EVerilogType type);

    RefCSLOmScope getAttachedScope() const;
    RefTVec_RefCSLOmSignal getAllSignals() const;

    /**
     * Returns a list of ALL ports inside this unit declaration, 
     * including the ports declared inside interfaces.
     * Take this example:
     * csl_unit a;
     * a.add_port(t);            // port t is the child of the default ifc of unit a
     * csl_interface ifc;
     * ifc.add_port(p);          // port p is the child of ifc
     * a.add_interface(ifc,ifc0);// ifc0 is the child of the default ifc of unit a
     *                           // the child of ifc0, port p, is also copied into the hierarchy.
     * The following method will return both ports t(direct child of the default ifc)
     * and p(child of ifc0, which is the child of the default ifc)
     */
    virtual RefTVec_RefCSLOmPortDecl getPortListFull() const;
    virtual RefTVec_RefCSLOmBase getAssignListFull() const;


    //added by AS
    
//     TInt getRecursivePorts(RefTVec_RefCSLOmPortDecl allPorts, RefCSLOmInterface ifc)const;
    
    /**
     * Returns the list of ports inside this unit declaration 
     * without the ports declared inside interfaces.
     * Considering the previous example, this method will return only port t.
     */
    
    virtual RefTVec_RefCSLOmPortDecl getPortList() const;



    /**
     * returns true if the portExists in the current unit
     */
    virtual TBool portExists(RefCSLOmExprLink portLink) const;

    virtual TBool wasAssociatedClockSet() const;

    void associateClock(RefCSLOmConnectable);

    virtual RefCSLOmConnectable getAssociatedClock() const;

    /**
     * to do: remove
     */
    void setAlterationBit(TBool value);

    /**
     * to do: remove
     */
    void setVisited(TBool) const;

    /**
     * returns true if the unit hasn't been instantiated
     */
    virtual const TBool isTopUnit() const;

    /**
     * to do: remove
     */
    TBool getAlterationBit() const;

    /**
     * to do: remove
     */
    TBool isVisited() const;

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmUnitReplica class
// ********************************************************************************
class CSLOmUnitReplica : public CSLOmUnitDecl {
  private:
    WeakCSLOmUnitDecl                           m_unitDecl;

  public:
    virtual ~CSLOmUnitReplica() {}

    static RefCSLOmUnitReplica cast(RefCSLOmBase object);
    static RefCSLOmUnitReplica build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& declName, const RefString& instName, const RefCSLOmUnitDecl& unitDecl);
  
    RefCSLOmBase getUnitDeclAsBase() const;
    RefCSLOmUnitDecl getUnitDecl() const;

    RefTVec_RefCSLOmBase getInstantiationsAsBase() const;
    RefTVec_RefCSLOmUnitInstantiation getInstantiations() const;

    RefTVec_RefCSLOmSignal getSignals() const;
    RefTVec_RefCSLOmBase getSignalsAsBase() const;
    RefTVec_RefCSLOmGroupSignal getSignalGroups() const;
    RefTVec_RefCSLOmBase getSignalGroupsAsBase() const;
    RefTVec_RefCSLOmBase getUnitParamsAsBase() const;

    RefCSLOmInterface getDefaultInterface() const;
    RefCSLOmInterface getReplicaDefaultInterface() const;
    RefCSLOmBase getDefaultInterfaceAsBase() const;
    RefCSLOmBase getReplicaDefaultInterfaceAsBase() const;

    CSLOmUnitDecl::EUnitType getUnitType() const;

    RefCSLOmUnitInfo getUnitInfo() const;

    TBool isSetDoNotGenerateRTL() const;
    TBool isSetDoNotGenerateCPP() const;
    TBool isSetGenerateUniqueRTL() const;

    const TBool isTopUnit() const;
    TBool isDUT() const;

    const RefString getUnitPrefix() const;
    const RefCSLOmNumber getUnitNumericID() const;
    const RefCSLOmNumber getUnitAddress() const;
    const RefCSLOmExprLink getExternalUnitEnable() const;

    EVerilogType getInputVerilogType() const;
    EVerilogType getOutputVerilogType() const;

    RefTVec_RefCSLOmPortDecl getPortListFull() const;
    RefTVec_RefCSLOmPortDecl getPortList() const;

    TBool portExists(RefCSLOmExprLink portLink) const;

    TBool wasAssociatedClockSet() const;

    RefCSLOmConnectable getAssociatedClock() const;

  protected:
    CSLOmUnitReplica(TLineNumberType lineNumber, RefString fileName);
};

// ********************************************************************************
// CSLOmUnitInfo class
// ********************************************************************************
class CSLOmUnitInfo : public CSLOmBase {
  protected:
    friend class CSLOmUnitDecl;
    CSLOmUnitInfo(TLineNumberType, RefString fileName);
    RefCSLOmUnitInfo getThis() const { return boost::static_pointer_cast<CSLOmUnitInfo>(m_weakRef.lock()); }
  public:
    static RefCSLOmUnitInfo cast(RefCSLOmBase object);
    static RefCSLOmUnitInfo build(TLineNumberType lineNumber, RefString fileName);
    virtual void initialize() {}

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmMemoryInfo class
// ********************************************************************************
class CSLOmMemoryInfo : public CSLOmUnitInfo {
  private:
    TBool m_addLogicClock;
    friend class CSLOmUnitDecl;
    RefCSLOmExpr m_width, m_depth;
    TUInt m_noOfRdIfc;
    TUInt m_noOfWrIfc;

    TBool m_hasSetWidth, m_hasSetDepth;

    CSLOmMemoryInfo(TLineNumberType, RefString fileName);
  public:
    static RefCSLOmMemoryInfo cast(RefCSLOmBase);
    static RefCSLOmMemoryInfo build(TLineNumberType lineNumber, RefString fileName);

    void enableAddLogicClock() { m_addLogicClock = TRUE; }
    TBool getAddLogicClockBit() { return m_addLogicClock; }

    void setWidth(RefCSLOmExpr);
    void setDepth(RefCSLOmExpr);

    RefCSLOmExpr getWidth() const;
    RefCSLOmExpr getDepth() const;
    
    void setNoOfRdIfc(RefCSLOmExpr no);
    void setNoOfWrIfc(RefCSLOmExpr no);

    TUInt getNoOfRdIfc() const { return m_noOfRdIfc; }
    TUInt getNoOfWrIfc() const { return m_noOfWrIfc; }

    RefCSLOmMemoryInfo getThis() const { return boost::static_pointer_cast<CSLOmMemoryInfo>(m_weakRef.lock()); }

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmFifoInfo class
// ********************************************************************************
// the booleans are used to show which options have been selected
// the options are then checked to see if the required options have been selected
// and by the adaptor to create the CDOm FIFO objects
// th FIFO is declared by the user
// the user then calls the methods to configure the FIFO
// then the user instantiates the unit
// the FIFO info class holds the FIFO object attributes
// the user creates a FIFO oject in CSL
// then the user sets the name of each of the ports to the FIFO unit object using
// the methods below or the default port names are used
// ********************************************************************************

class CSLOmFifoInfo : public CSLOmUnitInfo {
  public:
  
    //    static RefTMap_EFifoPortNames_RefString m_nameMap;  

    /*
     *enums for the physical implementation
     *
     */
    typedef enum _EImpType {
      IMP_UNDEF,
      IMP_SRAM, 
      IMP_FFA,
      IMP_MAX
    } EImpType;

    /*
     *  cast function to fifo from base
     * !!! It asserts if argument is not of type fifo
     */
    static RefCSLOmFifoInfo cast(RefCSLOmBase);
  protected:

    //need to add memory map
    friend class CSLOmUnitDecl;
    /*
     * fifo constructor
     * @param lineNumber - line number
     * @param parent - the parent unit of the fifo
     */
    CSLOmFifoInfo(TLineNumberType lineNumber, RefString fileName, RefCSLOmUnitDecl parent);

    /*
     *map between fifo port name(enum) and the port object
     * -used to keep evidence of the ports that were added to the fifo
     */
    RefTMap_EFifoPortNames_RefCSLOmPortDecl m_portMap;

    /*
     *map between fifo children and their position in the children vector of the fifo
     */
    RefTMap_EFifoChildrenTypes_TInt         m_childrenNoMap;

    /*
     *implementation type of the fifo (set with setImpType() function)
     */
    EImpType m_impTypeIType;//

    /*
     * the prefix name that is set with the setPrefixName() function
     */
    RefString m_prefixName;//

    /*
     *function that returns a reference to the fifo object itself
     */
    RefCSLOmFifoInfo getThis() const { return boost::static_pointer_cast<CSLOmFifoInfo>(m_weakRef.lock()); }

    
  public:
    /*
     *build function
     *@param lineNumber - the line number
     *@param unit - the parent unit
     */
    static RefCSLOmFifoInfo build(TLineNumberType lineNumber, RefString fileName, RefCSLOmUnitDecl unit);

    /*
     *function that returns the map between fifo port name and the port object
     */
    RefTMap_EFifoPortNames_RefCSLOmPortDecl getPortMap() { return m_portMap; }
    // foreach possible port in the FIFO create an enum value.

    // each port in the FIFO is inserted into the parent unit
    // the pointer to the port and the FIFO port name are associated using the following map
    // the adaptor then can iterate through the map to associate each port in the FIFO unit
    // with an internal logic block

  private:
    /*
     *bools for keeping track of what was called/set
     */
    TBool m_setLowWatermark                     ;
    TBool m_setHighWatermark                    ;
    TBool m_setDepth                            ;
    TBool m_setWidth                            ;
    TBool m_setImpType                          ;
    TBool m_setAsynch                           ;
    TBool m_setDepthExtend                      ;
    TBool m_setWidthExtend                      ;
    TBool m_setWrHold                           ;
    TBool m_setParallelOutput                   ;
    TBool m_setParallelInput                    ;
    TBool m_rdWords                             ;
    TBool m_wrWords                             ;
    TBool m_flowThrough                         ;
    TBool m_setPrefixName                       ;
    TBool m_addPortPush                         ;
    TBool m_addPortPop                          ;
    TBool m_addPortFull                         ;
    TBool m_addPortEmpty                        ;
    TBool m_addPortProgrammableDepth            ;
    TBool m_addPortPriorityBypass               ;
    TBool m_addPortPrioritySelect               ;
    TBool m_addPortValid                        ;
    TBool m_addPortClock                        ;
    TBool m_addPortRdClock                      ;
    TBool m_addPortWrClock                      ;
    TBool m_addPortSynchReset                   ;
    TBool m_addPortAsynchReset                  ;
    TBool m_addPortDataOut                      ;
    TBool m_addPortDataIn                       ;
    TBool m_addPortPushback                     ;
    TBool m_addPortStall                        ;
    TBool m_addPortStallRdSide                  ;
    TBool m_addPortStallWrSide                  ;
    TBool m_addPortSramRdData                   ;
    TBool m_addPortSramRdEn                     ;
    TBool m_addPortSramRdAddr                   ;
    TBool m_addPortSramWrData                   ;
    TBool m_addPortSramWrEn                     ;
    TBool m_addPortSramWrAddr                   ;
    TBool m_addPortWrRelease                    ;
    TBool m_addPortAlmostEmpty                  ;
    TBool m_addPortAlmostFull                   ;
    TBool m_addSignalWrAddress                  ;
    TBool m_addSignalRdAddress                  ;
    TBool m_addPortCredit                       ;
    TBool m_addPortRdCredit                     ;
    TBool m_addPortWrCredit                     ;
    TBool m_addPortOverflow                     ;
    TBool m_addPortUnderflow                    ;
      
  public:
    /*
     *functions that return the above bools
     */
    TBool getSetLowWatermark                    ();
    TBool getSetHighWatermark                   ();
    TBool getSetDepth                           ();
    TBool getSetWidth                           ();
    TBool getSetImpType                         ();
    TBool getSetAsynch                          ();
    TBool getSetDepthExtend                     ();
    TBool getSetWidthExtend                     ();
    TBool getSetWrHold                          ();
    TBool getSetParallelOutput                  ();
    TBool getSetParallelInput                   ();
    TBool getRdWords                            ();
    TBool getWrWords                            ();
    TBool getFlowThrough                        ();
    TBool getSetPrefixName                      ();
    TBool getAddPortPush                        ();
    TBool getAddPortPop                         ();
    TBool getAddPortFull                        ();
    TBool getAddPortEmpty                       ();
    TBool getAddPortProgrammableDepth           ();
    TBool getAddPortPriorityBypass              ();
    TBool getAddPortPrioritySelect              ();
    TBool getAddPortValid                       ();
    TBool getAddPortClock                       ();
    TBool getAddPortRdClock                     ();
    TBool getAddPortWrClock                     ();
    TBool getAddPortSynchReset                  ();
    TBool getAddPortAsynchReset                 ();
    TBool getAddPortDataOut                     ();
    TBool getAddPortDataIn                      ();
    TBool getAddPortPushback                    ();
    TBool getAddPortStall                       ();
    TBool getAddPortStallRdSide                 ();
    TBool getAddPortStallWrSide                 ();
    TBool getAddPortSramRdData                  ();
    TBool getAddPortSramRdEn                    ();
    TBool getAddPortSramRdAddr                  ();
    TBool getAddPortSramWrData                  ();
    TBool getAddPortSramWrEn                    ();
    TBool getAddPortSramWrAddr                  ();
    TBool getAddPortWrRelease                   ();
    TBool getAddPortAlmostEmpty                 ();
    TBool getAddPortAlmostFull                  ();
    TBool getAddSignalWrAddress                 ();
    TBool getAddSignalRdAddress                 ();
    TBool getAddPortCredit                      ();
    TBool getAddPortRdCredit                    ();
    TBool getAddPortWrCredit                    ();
    TBool getAddPortOverflow                    ();
    TBool getAddPortUnderflow                   ();



    /*
     *funtion that return the fifo width as a reference to a CSLOmNumber object
     */
    RefCSLOmExpr              getWidth                                ();

    /*
     *function that return the fifo width as a reference to a CSLOmExprLink object
     */
    RefCSLOmExprLink            getWidthAsBitRangeLink                  ();

    /*
     *function that return the fifo depth as a reference to a CSLOmNumber object
     */
    RefCSLOmNumber              getDepth                                ();

    /*
     *function that returns the fifo depth as a reference to a CSLOmExprLink object
     */
    RefCSLOmExprLink            getDepthAsBitRangeLink                  ();

    /*
     *function that returns the prefix name set with setPrefixName() function
     */
    RefString                   getPrefixName                           ();

    /*
     *function that returns the implementation type that is set with setImpType() function
     */
    EImpType                    getImpType                              ();


    /*
     *function that sets the low watermark of the fifo 
     *@param numericExpression - the low watermark of the fifo
     */
    void setLowWatermark              (RefCSLOmExpr numericExpression);

    /*
     *function that sets the high watermark of the fifo 
     *@param numericExpression - the high watermark of the fifo
     */
    void setHighWatermark             (RefCSLOmExpr numericExpression);

    /*
     *function that sets the depth of the fifo
     *@param numericExpression - the depth of the fifo
     */
    void setDepth                     (RefCSLOmExpr numericExpression);

    /*
     *function that sets the width of the fifo 
     *@param numericExpression - the width of the fifo
     */
    void setWidth                     (RefCSLOmExpr numericExpression);

    /*
     *function that sets the implementation type of the fifo 
     *@param numericExpression - an enum that represents the implmentation type of the fifo
     */
    void setImpType                   (EImpType iType); // SRAM | FFA //set_physical_implementation()

    /*
     *function that sets the type of the fifo to asynchronos
     */
    void setAsynch                    ();//add_logic(sync_fifo|async_fifo)

    /*
     *function that extends the fifo depth
     *@param numericExpression - the value that the depth is extended by
     */
    void setDepthExtend               (RefCSLOmExpr numericExpression);//add_logic(depth_extend, numeric_expression)

    /*
     *function that extends the fifo width
     *@param numericExpression - the value that the fifo width is extended by
     */
    void setWidthExtend               (RefCSLOmExpr numericExpression);//add_logic(width_extend, numeric_expression)

    /*
     *
     */
    void setWrHold                    (RefCSLOmExpr numericExpression);//add_logic(wr_hold, numeric_expression)

    
    void setParallelOutput            (RefTVec_RefCSLOmExpr addressVector = RefTVec_RefCSLOmExpr());//add_logic(parallel_output, all | vector_of_addresses)
    void setParallelInput             (RefTVec_RefCSLOmExpr addressVector = RefTVec_RefCSLOmExpr());//add_logic(parallel_input, all | vector_of_addresses)
    void rdWords                      (RefCSLOmExpr expression1, RefCSLOmExpr expression2);
    void wrWords                      (RefCSLOmExpr expression1, RefCSLOmExpr expression2);
    void flowThrough                  (RefCSLOmExpr numericExpresion);

    /*
     *function that sets the prefix name of the fifo 
     *@param prefixName - the prefix of the fifo
     */
    void setPrefixName                (const RefString prefixName);
  private:
    
    /*
     *function that adds a child to the fifo 
     *@param base - the object that is to be added
     *@param type - the fifo child type of the object that is added
     */
    void addChildFifo                 (RefCSLOmBase base,EFifoChildrenTypes type);

    /*
     *function that add a port to the fifo 
     *@param portName - the port name
     *@param portEnum - the fifo port type
     *@param portType - the port direction
     *@param bitRange - the width of the port that is to be added
     *@param signalType - the signalType 
     */
    void addPort                      (RefString& portName, EFifoPortNames portEnum, ECSLOmPortDirection portType = INPUT, 
                                       RefCSLOmExprLink bitRange = RefCSLOmExprLink(), ECSLOmSignalType signalType = SIGNAL_WIRE);
    public:

    /*
     *function that adds a push port to the fifo 
     *@param signalName - the name of the port(by default the name is "push",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_push")
     */
    void addPortPush                  (RefString signalName  = RefString());//

    /*
     *function that adds a pop port to the fifo 
     *@param signalName - the name of the port(by default the name is "pop",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_pop")
     */
    void addPortPop                   (RefString signalName  = RefString());//

    /*
     *function that adds a full port to the fifo 
     *@param signalName - the name of the port(by default the name is "full",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_full")
     */
    void addPortFull                  (RefString signalName  = RefString());

    /*
     *function that adds a empty port to the fifo 
     *@param signalName - the name of the port(by default the name is "empty",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_empty")
     */
    void addPortEmpty                 (RefString signalName  = RefString());

    /*
     *function that adds a data_out port to the fifo 
     *@param signalName - the name of the port(by default the name is "data_out",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_data_out")
     */
    void addPortDataOut               (RefString signalName  = RefString());

    /*
     *function that adds a data_in port to the fifo 
     *@param signalName - the name of the port(by default the name is "data_in",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_data_in")
     */
    void addPortDataIn                (RefString signalName  = RefString());

    /*
     *function that adds a synch_reset port to the fifo 
     *@param signalName - the name of the port(by default the name is "reset",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_reset")
     */
    void addPortSynchReset            (RefString resetName   = RefString());

    /*
     *function that adds a clock port to the fifo 
     *@param signalName - the name of the port(by default the name is "clock",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_clock")
     */
    void addPortClock                 (RefString clockName   = RefString());

    /*
     *function that adds a rd_clock port to the fifo 
     *@param signalName - the name of the port(by default the name is "rd_clock",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_rd_clock")
     */
    void addPortRdClock               (RefString clockName   = RefString());

    /*
     *function that adds a wr_clock port to the fifo 
     *@param signalName - the name of the port(by default the name is "wr_clock",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_wr_clock")
     */
    void addPortWrClock               (RefString clockName   = RefString());
  public:

    /*
     *function that adds a programmable_depth port to the fifo 
     *@param signalName - the name of the port(by default the name is "programmable_depth",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_programmable_depth")
     */
    void addPortProgrammableDepth     (RefCSLOmExpr expression, RefString signalName  = RefString());

    /*
     *function that adds a priority_bypass port to the fifo 
     *@param signalName - the name of the port(by default the name is "priority_bypass",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_priority_bypass")
     */
    void addPortPriorityBypass        (RefString signalName  = RefString());

    /*
     *function that adds a priority_select port to the fifo 
     *@param signalName - the name of the port(by default the name is "priority_select",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_priority_select")
     */
    void addPortPrioritySelect        (RefString signalName  = RefString());

    /*
     *function that adds a valid port to the fifo 
     *@param signalName - the name of the port(by default the name is "valid",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_valid")
     */
    void addPortValid                 (RefString signalName  = RefString());

    /*
     *function that adds an asynch_reset port to the fifo 
     *@param signalName - the name of the port(by default the name is "reset_",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_reset_")
     */
    void addPortAsynchReset           (RefString resetName   = RefString());

    /*
     *function that adds a pushback port to the fifo 
     *@param signalName - the name of the port(by default the name is "pushback",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_pushback")
     */
    void addPortPushback              (RefString signalName  = RefString());

    /*
     *function that adds a stall port to the fifo 
     *@param signalName - the name of the port(by default the name is "stall",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_stall")
     */
    void addPortStall                 (RefString signalName  = RefString());

    /*
     *function that adds a stall_rd_side port to the fifo 
     *@param signalName - the name of the port(by default the name is "stall_rd_side",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_stall_rd_side")
     */
    void addPortStallRdSide           (RefString signalName  = RefString());

    /*
     *function that adds a stall_wr_side port to the fifo 
     *@param signalName - the name of the port(by default the name is "stall_wr_side",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_stall_wr_side")
     */
    void addPortStallWrSide           (RefString signalName  = RefString());

    /*
     *function that adds a sram_rd_data port to the fifo 
     *@param signalName - the name of the port(by default the name is "sram_rd_data",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_sram_rd_data")
     */
    void addPortSramRdData            (RefString signalName  = RefString());

    /*
     *function that adds a sram_rd_en port to the fifo 
     *@param signalName - the name of the port(by default the name is "sram_rd_en",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_sram_rd_en")
     */
    void addPortSramRdEn              (RefString signalName  = RefString());

    /*
     *function that adds a sram_rd_address port to the fifo 
     *@param signalName - the name of the port(by default the name is "sram_rd_address",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_sram_rd_address")
     */
    void addPortSramRdAddr            (RefString signalName  = RefString());

    /*
     *function that adds a sram_wr_data port to the fifo 
     *@param signalName - the name of the port(by default the name is "sram_rd_data",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_sram_rd_data")
     */
    void addPortSramWrData            (RefString signalName  = RefString());

    /*
     *function that adds a stall_wr_side port to the fifo 
     *@param signalName - the name of the port(by default the name is "stall_wr_side",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_stall_wr_side")
     */
    void addPortSramWrEn              (RefString signalName  = RefString());
    
    /*
     *function that adds a sram_wr_addr port to the fifo 
     *@param signalName - the name of the port(by default the name is "sram_wr_addr",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_sram_wr_addr")
     */
    void addPortSramWrAddr            (RefString signalName  = RefString());

    /*
     *function that adds a wr_release port to the fifo 
     *@param signalName - the name of the port(by default the name is "wr_release",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_wr_realease")
     */
    void addPortWrRelease             (RefString signaName   = RefString());

    /*
     *function that adds a almost_empty port to the fifo 
     *@param signalName - the name of the port(by default the name is "almost_empty",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_almost_empty")
     */
    void addPortAlmostEmpty           (RefCSLOmExpr expression, RefString address     = RefString());

    /*
     *function that adds a almost_full port to the fifo 
     *@param signalName - the name of the port(by default the name is "almost_full",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_almost_full")
     */
    void addPortAlmostFull            (RefCSLOmExpr expression, RefString address     = RefString());
    
    /*
     *function that adds a wr_address port to the fifo 
     *@param signalName - the name of the port(by default the name is "wr_address",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_wr_address")
     */
    void addSignalWrAddress           (RefString signalName  = RefString());

    /*
     *function that adds a rd_address port to the fifo 
     *@param signalName - the name of the port(by default the name is "rd_address",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_rd_address")
     */
    void addSignalRdAddress           (RefString signalName  = RefString());

    /*
     *function that adds a credit port to the fifo 
     *@param signalName - the name of the port(by default the name is "credit",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_credit")
     */
    void addPortCredit                (RefString signalName  = RefString());

    /*
     *function that adds a rd_credit port to the fifo 
     *@param signalName - the name of the port(by default the name is "wr_address",
     *                     any string given as argument will be inserted at the beggining, followed by "_", i.e.: 
     *                     if "a" is given as argument , the port name will be "a_wr_address")
     */
    void addPortRdCredit              (RefString signalName  = RefString());
    void addPortWrCredit              (RefString signalName  = RefString());
    void addPortOverflow              (RefString signalName  = RefString());
    void addPortUnderflow             (RefString signalName  = RefString());

    /*

    Returns the position of the child in the vector of children
    - return value INFO_CLASS_MAP_INDEX_NOT_FOUND -> there is no such child(at least in the map)
    - return value INFO_CLASS_MAP_INDEX_NOT_SET -> the child has not been added to the vector of children
    - return value > 0 -> the position of the child in the vector of children
    - @param name is the fifo child type
    */

    TInt getChildPos(EFifoChildrenTypes type);

    /*
     *this function is called to set the default values of the fifo
     */
    void initialize();

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;

};

// ********************************************************************************
// CSLOmRegisterFileInfo class
// ********************************************************************************
class CSLOmRegisterFileInfo : public CSLOmUnitInfo {
  private:    

    friend class CSLOmUnitDecl;
    CSLOmRegisterFileInfo(TLineNumberType, RefString fileName, RefCSLOmUnitDecl);

    RefTMap_ERFPortNames_RefCSLOmPortDecl m_portMap;

    RefTMap_ERFChildrenTypes_TInt          m_childrenNoMap;

    RefCSLOmExpr m_width;
    RefCSLOmExpr m_depth;
    RefCSLOmExpr m_inputPortsNumber;
    RefCSLOmExpr m_outputPortsNumber;
    RefCSLOmSignal m_readAddressSignal;

    RefCSLOmExpr m_constValue;
    RefCSLOmExpr m_field;
    RefCSLOmExpr m_external;
    RefString m_prefix;
    RefString m_groupName;
    


  public:

    //    static RefTMap_ERFPortNames_RefString m_nameMap;
    
    static RefCSLOmRegisterFileInfo build(TLineNumberType lineNumber, RefString fileName, RefCSLOmUnitDecl unit);
    static RefCSLOmRegisterFileInfo cast(RefCSLOmBase object);
    RefTMap_ERFPortNames_RefCSLOmPortDecl getPortMap() { return m_portMap; }
    //    static RefCSLOmRegisterFileInfo build(TLineNumberType lineNumber, RefCSLOmBase parent,)
  private:
    TBool m_setWidth                    ;
    TBool m_setDepth                    ;
    TBool m_createRtlModule             ;
    TBool m_setConstValue               ;
    TBool m_setField                    ;
    TBool m_setExternal                 ;
    TBool m_setPrefix                   ;
    TBool m_setGroupName                ;
    TBool m_disconnectRegFieldsFromIos  ;
    TBool m_connectRegFieldsToIos       ;
    TBool m_setBypass                   ;
    TBool m_addPortClock                ;
    TBool m_addPortReset                ;
    TBool m_addPortClear                ;
    TBool m_addPortWrAddr               ;
    TBool m_addPortRdAddr1              ;
    TBool m_addPortRdAddr2              ;
    TBool m_addPortWrData               ;
    TBool m_addPortRdData1              ;
    TBool m_addPortRdData2              ;
    TBool m_addPortWrEn                 ;
    TBool m_addPortRdEn1                ;
    TBool m_addPortRdEn2                ;
    TBool m_addPortValid                ;

  public:
    TBool getSetWidth()                   ;
    TBool getSetDepth()                   ;
    TBool getCreateRtlModule()            ;
    TBool getSetConstValue()              ;
    TBool getSetField()                   ;
    TBool getSetExternal()                ;
    TBool getSetPrefix()                  ;
    TBool getSetGroupName()               ;
    TBool getDisconnectRegFieldsFromIos() ;
    TBool getConnectRegFieldsToIos()      ;
    TBool getSetBypass()                  ;
    TBool getAddPortClock()               ;
    TBool getAddPortReset()               ;
    TBool getAddPortClear()               ;
    TBool getAddPortWrAddr()              ;
    TBool getAddPortRdAddr()              ;
    TBool getAddPortRdAddrS()              ;
    TBool getAddPortWrData()              ;
    TBool getAddPortRdData()              ;
    TBool getAddPortRdDataS()              ;
    TBool getAddPortWrEn()                ;
    TBool getAddPortRdEn()                ;
    TBool getAddPortRdEnS()                ;
    TBool getAddPortValid()               ;

    


    void setWidth                  (RefCSLOmExpr expression);
    void setDepth                  (RefCSLOmExpr expression);
    void createRtlModule           ()                       ;
    void setConstValue             (RefCSLOmExpr expression);
    void setField                  (RefCSLOmField field, RefCSLOmExpr expression);
    void setExternal               (RefCSLOmExpr expression, RefCSLOmPortDecl port);
    void setPrefix                 (const RefString    prefix    );
    void setGroupName              (RefString    groupName );
    void disconnectRegFieldsFromIos();
    void connectRegFieldsToIos     ();
    void setBypass                 ();
  private:

    RefCSLOmRegisterFileInfo getThis() const { return boost::static_pointer_cast<CSLOmRegisterFileInfo>(m_weakRef.lock()); };

    void addPort        (const RefString& portName, ERFPortNames portEnum, ECSLOmPortDirection portType = INPUT, 
                         RefCSLOmExprLink bitRange = RefCSLOmExprLink(), ECSLOmSignalType signalType = SIGNAL_WIRE);
  public:
    void addPortClock      (RefString clockName  = RefString());
    void addPortReset      (RefString resetName  = RefString());
    void addPortClear      (RefString signalName = RefString());
    void addPortWrAddr     (RefString signalName = RefString());
    void addPortRdAddr     (RefString signalName = RefString());
    void addPortRdAddrS    (RefString signalName = RefString());
    void addPortDataIn     (RefString signalName = RefString());
    void addPortDataOut    (RefString signalName = RefString());
    void addPortDataOutS   (RefString signalName = RefString());
    void addPortWrEn       (RefString signalName = RefString());
    void addPortRdEn       (RefString signalName = RefString());
    void addPortRdEnS      (RefString signalName = RefString());
    void addPortValid      (RefString signalName = RefString());

    RefCSLOmExpr     getWidth                  ();
    RefCSLOmExprLink   getWidthAsBitRangeLink    ();
    RefCSLOmExpr     getDepth                  ();
    RefCSLOmExprLink   getDepthAsBitRangeLink    ();

    TInt getChildPos(ERFChildrenTypes);
    void addChildRegisterFile(RefCSLOmBase base, ERFChildrenTypes name);

    void initialize();

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
    
  protected:

    CSLOmRegisterFileInfo();
};

// ********************************************************************************
// CSLOmRegDeclInfo class
// ********************************************************************************
class CSLOmRegDeclInfo:public CSLOmUnitInfo {
  public:
    enum ERegDeclType{
      REG_DECL_UNDEF ,
      REG_DECL_COUNTER ,
      REG_DECL_REGISTER,
      REG_DECL_MAX
    };

    enum ERegDeclCntDir{
      REG_DECL_CNT_DIR_UNDEF,
      REG_DECL_CNT_DIR_UP   ,
      REG_DECL_CNT_DIR_DOWN ,
      REG_DECL_CNT_DIR_MAX
    };
    
    enum ERegDeclOperations{
      REG_OPER_UNDEF        =-1,
      //default / pins
      REG_OPER_NEG_OUTPUT    =0,
      REG_OPER_SERIAL_INPUT  =1,
      REG_OPER_SERIAL_OUTPUT =2,
      
      //register register
      REG_OPER_REG_RESET     =3,
      REG_OPER_REG_SET       =4,
      
      //counter
      REG_OPER_GRAY_OUTPUT   =5,

      //default / values
      REG_OPER_INIT          =6,
      REG_OPER_SET           =7,
      REG_OPER_RESET         =8,
      REG_OPER_CLEAR         =9,
      REG_OPER_LOAD          =16,
      
      //counter+
      REG_OPER_COUNT_AMMOUNT =10,
      REG_OPER_STOP_VALUE    =11,
      REG_OPER_START_VALUE   =12,
      REG_OPER_END_VALUE     =13,
      REG_OPER_DIR_CONTROL   =14,
      REG_OPER_COUNT_DIRECTION =15,
      
      REG_OPER_MAX           =17
    };

  private:
    /*
     * mask for attributes: the values are:
     * 0 - REG_ATTR_READ
     * 1 - REG_ATTR_WRITE
     * 2 - REG_ATTR_SHADOW
     * 3 - REG_ATTR_READ_WRITE
     */

    RefTVec_ERegDeclAttr m_attributes;

    TChar m_attrMask;

    //default register
    RefCSLOmExpr m_initValue;
    RefCSLOmExpr m_setValue;
    RefCSLOmExpr m_resetValue;
    RefCSLOmExpr m_clearValue;

    //counter register
    RefCSLOmExpr m_countAmmout;
    RefCSLOmExpr m_stopValue;
    RefCSLOmExpr m_startValue;
    RefCSLOmExpr m_endValue;
    
    //registers
    TBool m_alreadySetWidth;
    TBool m_alreadySetType;
    TBool m_alreadySetCntDir;

    /*
     *map between reg port name(enum) and the port object
     * -used to keep evidence of the ports that were added to the fifo
     */
    RefTMap_ERegPortNames_RefCSLOmPortDecl m_portMap;

    //tempValueForWidth
    RefCSLOmExpr m_tempWidth;
    ERegDeclAttr m_attr;

     /*
     * mask for IO register stuff: the values are:
     * 0 - REG_OPER_NEG_OUTPUT
     * 1 - REG_OPER_SERIAL_INPUT
     * 2 - REG_OPER_SERIAL_OUTPUT
     * 3 - REG_OPER_REG_RESET
     * 4 - REG_OPER_REG_SET
     * 5 - REG_OPER_GRAY_OUTPUT
     */

    TChar m_IOMask;

    TBool m_regReset;
    TBool m_regSet;
    
    
    RefCSLOmExpr m_width;
    ERegDeclType m_type;
    ERegDeclCntDir m_cntDir;

    RefCSLOmSignal m_cntDirSig;

    //for setting values purposes
    TBool m_isSetInitValue;
    TBool m_isSetSetValue;
    TBool m_isSetResetValue;
    TBool m_isSetClearValue;
         
    TBool m_isSetCountAmmout;
    TBool m_isSetStopValue;
    TBool m_isSetStartValue;
    TBool m_isSetEndValue;
    TBool m_isSetLoad;
  

  private:
    void addPortReset();
    void addPortEnable();
    void addPortClock();
    void addPortRegOut();
    void addPortRegIn();

    void addPortRegNegOut();
    void addPortSet();
    void addPortInit();
    void addPortClear();
    void addPortLoad();


  public:
    static RefCSLOmRegDeclInfo cast(RefCSLOmBase object);
    static RefCSLOmRegDeclInfo build(TLineNumberType lineNumber, RefString fileName);
    
    void initializePorts();
    RefTMap_ERegPortNames_RefCSLOmPortDecl getPortMap(){return m_portMap;}

    //set member functioms
    void setAttribute(ERegDeclAttr attributes);
    void addLogic(CSLOmRegDeclInfo::ERegDeclOperations opType, RefCSLOmExpr incomingExpr);
    void setWidth(RefCSLOmExpr numericExpression);
    void setType(CSLOmRegDeclInfo::ERegDeclType regType);
    void setCntDir(CSLOmRegDeclInfo::ERegDeclCntDir regCntDir);

    //Masks stuff:
   
    TBool isSetNegOutput(){return m_attrMask&(1<<REG_OPER_NEG_OUTPUT);}
    TBool isSetSerialInput(){return m_attrMask&(1<<REG_OPER_SERIAL_INPUT);}
    TBool isSetSerialOutput(){return m_attrMask&(1<<REG_OPER_SERIAL_OUTPUT);}
    TBool isSetRegReset(){return m_attrMask&(1<<REG_OPER_REG_RESET);}
    TBool isSetRegSet(){return m_attrMask&(1<<REG_OPER_REG_SET);}
    TBool isSetGrayOutput(){return m_attrMask&(1<<REG_OPER_GRAY_OUTPUT);}

    //get member functions
    ERegDeclAttr getAttribute();
    RefCSLOmExpr getWidth();
    TBool getSetWidth();

    RefCSLOmExpr getInitValue();
    RefCSLOmExpr getSetValue();
    RefCSLOmExpr getResetValue();
    RefCSLOmExpr getClearValue();
            
    RefCSLOmExpr getCountAmmout();
    RefCSLOmExpr getStopValue();
    RefCSLOmExpr getStartValue();
    RefCSLOmExpr getEndValue();
  
    RefCSLOmSignal getCndDirSig();

    //cheks if the values have been set
    TBool isSetInitValue(){
      return m_isSetInitValue;
    }
    TBool isSetSetValue(){
      return m_isSetSetValue;
    }
    TBool isSetResetValue(){
      return m_isSetResetValue;
    }
    TBool isSetClearValue(){
      return m_isSetClearValue;
    }
    TBool isSetCountAmmout(){
      return m_isSetCountAmmout;
    }
    TBool isSetStopValue(){
      return m_isSetStopValue;
    }
    TBool isSetStartValue(){
      return m_isSetStartValue;
    }
    TBool isSetEndValue(){
      return m_isSetEndValue;
    }
    TBool isSetDirControl(){
      if(!m_cntDirSig.get()){
        return FALSE;
      }
      return TRUE;
    }

    CSLOmRegDeclInfo::ERegDeclType getType();
    TBool getAlreadySetType();

    CSLOmRegDeclInfo::ERegDeclCntDir getCntDir();
    TBool getAlreadySetCntDir();

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
    
  protected:
    CSLOmRegDeclInfo(TLineNumberType lineNumber, RefString fileName);
    RefCSLOmRegDeclInfo getThis() const { return boost::static_pointer_cast<CSLOmRegDeclInfo>(m_weakRef.lock());}

};

// ********************************************************************************
// CSLOmTBInfo class
// ********************************************************************************
 class CSLOmTBInfo : public CSLOmUnitInfo {
    public:   
   
     typedef enum _ETBOperType{
       TB_OPER_UNDEF,
       
       TB_OPER_SIM_TIMEOUT_COUNTER,
       TB_OPER_STALL_GENERATION,
       TB_OPER_CLOCK,
       TB_OPER_GENERATE_WAVES,
       TB_OPER_GENERATE_REPORT,
       
       TB_OPER_MAX
     } ETBOperType;
     
     typedef enum _ETBWaveType{
       TB_WAVE_UNDEF,
       
       TB_WAVE_FSDB,
       TB_WAVE_VSD,

       TB_WAVE_MAX
     } ETBWaveType;
     
     typedef enum _ETBTimeBase{
      TB_TIMEBASE_UNDEF,

      TB_TIMEBASE_PS,
      TB_TIMEBASE_NS,
      TB_TIMEBASE_US,
      TB_TIMEBASE_MS,
      TB_TIMEBASE_S,

      TB_TIMEBASE_MAX
    } ETBTimeBase;
   
     typedef enum _ETBReportType{
       TB_REPORT_UNDEF,
       
       TB_REPORT_COLUMS,
       TB_REPORT_ROWS,

       TB_REPORT_MAX
     } ETBReportType;
     
private:
     RefString m_verilogFilename;
     RefCSLOmExpr m_simTimeoutCounter;
     RefTVec_RefCSLOmExprLink m_vecDUTInstanceNames;
     RefTVec_RefCSLOmExprLink m_vecScopesList;
     RefString m_waveFilename;
     RefCSLOmSignal m_clockSignal;
     RefCSLOmExpr m_clockPeriod;
     ETBTimeBase m_clockTimeBase;
     ETBWaveType m_waveType;
     ETBReportType m_reportType;

     //links between vector instances and unit instances
     RefTVec_RefCSLOmExprLink m_vecVULinks;
     

    RefCSLOmTBInfo getThis() const { return boost::static_pointer_cast<CSLOmTBInfo>(m_weakRef.lock());}
   public:
     static RefCSLOmTBInfo build(TLineNumberType lineNumber, RefString fileName);
     static RefCSLOmTBInfo cast(const RefCSLOmBase base);
    
     void setVerilogFilename(const RefString incomingString);

     //coms for vector - unit links
     void setVUInstanceLink(RefCSLOmExprLink vectorInstance, RefCSLOmExprLink unitInstance);
     TBool isVUConnected(RefCSLOmExprLink vectorInstance, RefCSLOmExprLink unitInstance);
     RefCSLOmExprLink getVectorConnectedUnit(RefCSLOmExprLink vectorInstance);

     //add logic coms
     void setSimTimeoutCounter(RefCSLOmExpr numericExpr);
     void setStallGeneration(RefTVec_RefCSLOmExprLink incomingExpr);  
     void setGenerateWaves(RefString incomingString, ETBWaveType incomingWave, RefTVec_RefCSLOmExprLink incomingExpr);
     void setGenerateWaves(RefString incomingString, ETBWaveType incomingWave);
     void setClock(RefCSLOmSignal incomingSignal, RefCSLOmExpr numericExpr, ETBTimeBase incomingTimeBase);
     void setGenerateReport(ETBReportType incomingReportType);

     //get coms
     RefString getVerilogFilename() const;
     RefCSLOmExpr getTimeoutCounter() const;
     RefTVec_RefCSLOmExprLink getDUTInstanceNames() const;
     RefTVec_RefCSLOmExprLink getScopesList() const;
     RefString getWaveFilename() const;
     ETBWaveType getWaveType() const;
     RefCSLOmSignal getClockSignal() const;
     RefCSLOmExpr getClockPeriod() const;
     ETBTimeBase getClockTimeBase() const;
     ETBReportType getReportType() const;

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;

   protected:
     CSLOmTBInfo(TLineNumberType lineNumber, RefString fileName);

 };

}

#endif
