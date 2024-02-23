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

// Author BogdanZ & AlinaP

#ifndef INC_GUARD_CSLOm_CONNECTABLEs_h
#define INC_GUARD_CSLOm_CONNECTABLEs_h

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
// CSLOmConnectable class
// ********************************************************************************
/**
 * base class for objects that can be connected
 * class is abstract, no instantiations of this type can appear
 */
class CSLOmConnectable : public CSLOmBase {
  public:

    /**
     * enum to specify the conectivity object type
     */
    enum ECSLOmConnectableType {
      TYPE_CONNECTABLE_UNDEFINED,
      TYPE_DECL_SIGNAL,
      TYPE_DECL_PORT,
      TYPE_INTERFACE,
      TYPE_GROUP_SIGNAL,
      TYPE_CONNECTABLE_MAX
    };

    /**
     * predicates for conectivity objects type
     */
    TBool cIsSignal() const { return m_connectableType == TYPE_DECL_SIGNAL; }
    TBool cIsPort() const { return m_connectableType == TYPE_DECL_PORT; }
    TBool cIsInterface() const { return m_connectableType == TYPE_INTERFACE; }
    TBool cIsSignalGroup() const { return m_connectableType == TYPE_GROUP_SIGNAL; }

    /**
     * API functions to cast 
     */
    static RefCSLOmConnectable cast(RefCSLOmBase object);
  private:
    ECSLOmConnectableType m_connectableType;
    TBool m_isConnected;
    TBool m_isArGenerated;
    RefString m_arInstance;
    static RefTMap_RefCSLOmExprLink_RefCSLOmExpr m_connectionMap;

    WeakRefCSLOmConnectable m_associatedClock;

  protected:
    RefCSLOmConnectable getThis() const { return boost::static_pointer_cast<CSLOmConnectable>(m_weakRef.lock());}
    CSLOmConnectable(ECSLOmConnectableType, TLineNumberType, RefString);
    //internal - only needed in interface/signal group for parameter overridding
    static void  overrideParamList(RefCSLOmScope scope, RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap);
  public:
    void enableArGenerated() { m_isArGenerated = TRUE; }
    TBool isArGenerated() { return m_isArGenerated; }
    void setArInstance(RefString arInstance) { m_arInstance = arInstance; }
    RefString getArInstance() { return m_arInstance; }

    /**
     * returns the map of the objects that are connected through the connect method
     */
    const RefTMap_RefCSLOmExprLink_RefCSLOmExpr getConnectionMap() const {
      return m_connectionMap;
    }

    /**
     * returns the parent unit
     */
    const RefCSLOmUnitDecl getParentUnit() const;

    const RefCSLOmExprLink getF2ALink() const;

    /**
     * returns the type of the connectable object: signal, port, interface of signal_group
     */
    ECSLOmConnectableType getConnectableType() const;

    /**
     * returns if it is connected
     */
    TBool isConnected() const;

    /**
     * adds a connection
     */
    static void addConnection(RefCSLOmExprLink, RefCSLOmExprLink);


    TBool wasAssociatedClockSet() const;

    void associateClock(RefCSLOmConnectable);

    RefCSLOmConnectable getAssociatedClock() const;

};

// ********************************************************************************
// CSLOmSignal class
// ********************************************************************************
class CSLOmSignal : public CSLOmConnectable {
  public:

    static RefCSLOmSignal cast(RefCSLOmBase object);
    RefCSLOmIdentifier getID() const { return boost::static_pointer_cast<CSLOmIdentifier>(getChild(ID)); }
    RefCSLOmBase getIDAsBase() const { return getChild(ID); }
    RefString getName() const { return getID()->getName(); }
    TBool hasBitRange() const;
    TBool hasEnum() const {return SAT_UNDEFINED != m_signalAccessType;}
    void setEnum(ECSLOmSignalAccessType e) {
      ASSERT((e > SAT_UNDEFINED) && (e < SAT_MAX), "wrong enum value");
      m_signalAccessType = e;
    }
    TBool isDecoder() const {return m_isDecoder;}
    void setAsDecoder() {
      ASSERT(!m_isDecoder, "already a decoder");
      m_isDecoder = TRUE;
    }
    TBool hasDecOutput() const { return m_hasDecOutput; }
    const RefString getDecOutput() const { 
      return m_decOutput; 
    }
    void setDecOutput(const RefString& decOutput){
      ASSERT(decOutput.get(), "null expression");
      ASSERT(!decOutput->empty(), "empty expression");
      m_decOutput = decOutput;
      ASSERT(!m_hasDecOutput, "already has decoder output");
      m_hasDecOutput = TRUE;
    }
    const RefString getDecUnit() const { 
      return m_decUnit; 
    }
    void setDecUnit(const RefString& decUnit){
      ASSERT(decUnit.get(), "null expression");
      ASSERT(!decUnit->empty(), "empty string");
      m_decUnit = decUnit;
      ASSERT(!m_hasDecUnit, "already has decoder unit");
      m_hasDecUnit = TRUE;
    }
  protected:
    RefCSLOmSignal getThis() const { return boost::static_pointer_cast<CSLOmSignal>(m_weakRef.lock()); }
    CSLOmSignal(TLineNumberType, RefString, ECSLOmSignalType, TBool, TBool);

  private:
    ECSLOmSignalType m_signalType;
    
    //for autorouter use
    ECSLOmPortDirection m_direction;

    ECSLOmSignalAccessType m_signalAccessType;
    ECSLOmSignalAttr m_attrType;
    TBool m_isDecoder;
    TBool m_hasDecOutput;
    TBool m_hasDecUnit;

    RefTVec_WeakRefCSLOmSignal m_signals;

    RefString m_decOutput;
    RefString m_decUnit;

    
  public:
    /** for autorouter use
      */
    void addSignal(RefCSLOmSignal sig);
    RefTVec_WeakRefCSLOmSignal getSignals() const;
    /** for autorouter use
      */
    void setDirection(ECSLOmPortDirection dir);
    ECSLOmPortDirection getDirection() const;
    /**
     * This is the csl_signal build method.
     *
     * @param lineNumber - type TLineNumberType - the line number where the csl_signal declaration apears
     * @param parent - type RefCSLOmBase - the parent of the signal
     * @param name - type RefString - the name of the csl_signal
     * @param signalType - type ECSLOmSignalType - the type of the signal
     * @param width - type RefCSLOmExpr - the width of the signal (implicit value param; in case that the width is mising in the signal declaration)
     *
     * @return RefCSLOmSignal - the object that has been built
     *
     * @see ECSLOmSignalType
     */
    static RefCSLOmSignal build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmSignalType signalType, RefCSLOmExpr width = RefCSLOmExpr());

    /**
     * This is the csl_signal build method.
     *
     * @param lineNumber - type TLineNumberType - the line number where the csl_signal declaration apears
     * @param parent - type RefCSLOmBase - the parent of the signal
     * @param name - type RefString - the name of the csl_signal
     * @param signalType - type ECSLOmSignalType - the type of the signal
     * @param upper - type RefCSLOmExpr - the upper index of the range of the signal
     * @param lower - type RefCSLOmExpr - the lower index of the range of the signal
     *
     * @return RefCSLOmSignal - the object that has been built
     *
     * @see ECSLOmSignalType
     */
    static RefCSLOmSignal build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmSignalType signalType, RefCSLOmExpr upper, RefCSLOmExpr lower);

    /**
     * set/get for signal attribute
     *
     * @see ECSLOmSignalAttr
     */
    void setSignalAttr(ECSLOmSignalAttr attr);
    ECSLOmSignalAttr getSignalAttr() const;

    /**
     * set/get for signal type
     *
     * @see ECSLOmSignalType
     */
    void setSignalType(ECSLOmSignalType type);
    ECSLOmSignalType getSignalType() const;

    /**
     * sets bitrange property of the signals
     *
     * @see CSLOmBaseRange
     */
    RefCSLOmBaseRange getBitRange() const;
    const RefCSLOmBase getBitRangeAsBase() const;
    void setBitRange(RefCSLOmExprLink bitRange);
    void setBitRange(RefCSLOmBaseRange bitRange);

    void setDimBitRange(RefCSLOmExpr dim, RefCSLOmExpr bitRange);
    void setDimBitRange(RefCSLOmExpr dim, RefCSLOmSimpleBitRange bitRange);
    RefCSLOmSimpleBitRange getDimBitRange(RefCSLOmExpr dim) const;
    //    RefCSLOmBase getDimBitRangeAsBase(RefCSLOmExpr dim) const;

    void setNumberOfDimensions(RefCSLOmExpr numOfDim);
    const RefCSLOmExpr getNumberOfDimensions() const;

    void setDimensionWidth(RefCSLOmExpr dimension, RefCSLOmExpr dimWidth);
    const RefCSLOmExpr getDimensionWidth(RefCSLOmExpr dimension) const;

    void setWidth(RefCSLOmExpr width);
    const RefCSLOmExpr getWidth() const;

    void setRange(RefCSLOmExpr lowerIndex, RefCSLOmExpr upperIndex);
    void setDimRange(RefCSLOmExpr dim, RefCSLOmExpr lowerIndex, RefCSLOmExpr upperIndex);

    void setOffset(RefCSLOmExpr offset);
    const RefCSLOmExpr getOffset() const;

    void setDimOffset(RefCSLOmExpr dim, RefCSLOmExpr offset);
    const RefCSLOmExpr getDimOffset(RefCSLOmExpr dim) const;

    RefCSLOmExpr getLowerIndex();
    RefCSLOmExpr getUpperIndex();
            
    RefCSLOmExpr getDimLowerIndex(RefCSLOmExpr dim);
    RefCSLOmExpr getDimUpperIndex(RefCSLOmExpr dim);

    //LEAVE FOR LATER void merge(mrege_op, RefCSLOmExprLink listToMerge);
    //LEAVE FOR LATER void merge(mrege_op, RefCSLOmListSignal listToMerge);

    /**
     * Returns signal's children of type field
     */
    const RefTVec_RefCSLOmBase getFieldsAsBase() const;
    /**
     * Accept visitor function
     */
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const ;
};


// ********************************************************************************
// CSLOmGroupSignal class
// ********************************************************************************
/**
  * This class handles objects of type csl_signal_group according to the current syntax.
  * A signal group is a scope holder that bundles signals together.
  * In general terms, a signal group is similar to an interface,
  * only it deals with signals instead of ports.
  *
  * USER ACCESS:
  * A signal group can only be built inside the scope of the design.
  * It can be instantiated inside a unit or inside another signal group
  * (therefore signal groups are hierarchical just like interfaces).
  * Another available option is to build a signal group using an interface:
  * all the ports in the interface are transformed into signals inside
  * the signal group(to transform a port into a signal, one has to remove the 
  * port's direction, everithing else stays the same; keep in mind that in csl
  * a port is an oriented signal). 
  *
  * A signal group is a connectable object, meaning that it can be used in 
  * formal to actual mapping. Signal groups may be connected to other
  * signal groups or interfaces. Such a connection is recursive. That 
  * means that if the formal signal group in the connection pair contains
  * subsequent signals(signal groups), they will be connected to their
  * equivalents in the actual signal group(or interface). 
  * The four criteria that have to be met by the two connectables 
  * so that they can be linked follow here:
  * 1. same name
  * 2. same range(if any)
  * 3. same direction(if the two connectables are ports)
  * 4. same hierarchical level 
  * For a few examples, see Petronela's tests on this topic.
  * 
  * There is no direct verilog equivalent of a signal group. The verilog 
  * output will only contain the nets and vars built by the adapter out of the 
  * csl signals inside the group. However, the user can use an option 
  * called generateIndividualRtlSignals to control the number of signals generated 
  * into verilog(see comments for m_generateIndividualRtlSignals).
  *
  * csl example:
  * csl_signal_group sg1 {
  *   csl_signal c1;
  *   csl_signal c2;
  *   sg1() {
  *     generate_individual_RTL_signals(OFF);
  *   }
  * };
  * csl_signal_group sg2 {
  *   sg1 sg1instance;
  *   csl_signal c3;
  *   sg2() {}
  * };
  * csl_interface ifc1 {
  *   csl_port c1(input);
  *   csl_port c2(output);
  *   csl_port c3(output);
  *   ifc1() {}
  * };
  * csl_signal_group sg3 {
  *   ifc1 ifc1instance;         //SYNTAX MAY NOT BE ACCURATE
  *   sg3() {}
  * }
  * csl_unit u {
  *   sg2 sg2instance;
  *   u() {}
  * };
  * csl_unit v {
  *   ifc1 ifc1instance;
  *   u uinstance(.sg2instance(ifc1instance));             //(*)
  *   v() {}
  * }; 
  *
  * HIDDEN IMPLEMENTATION:
  * There are three ways of building a signal group object from a SW point of view.
  * 1.Whenever a signal group is built inside the scope of the design(global signal group
  *   just like sg1 and sg2), the walker calls the first build function without the predefined param.
  *   Therefore in this case the signal group is built using only the parent(design) and the signal
  *   group name.
  *   sg1 = build(lineNo, design, string(sg1));
  *   sg2 = build(lineNo, design, string(sg2));
  * 2.If a signal group is instantiated inside a unit(sg2instance) or inside another signal group
  *   (sg1instance), the walker calls the first build function, and this time specifies the predefined
  *   exprLink, which indicates the signal group that the instance belongs to.
  *   sg1instance = build(lineNo, sg2, string(sg1instance), exprLink(sg1));
  *   sg2instance = build(lineNo, u, string(sg2instance), exprLink(sg2));
  *   Then, a new signal group is built inside the unit or the parent signal group, as an exact replica 
  *   of the object the exprLink points to. Therefore, for the example above, a signal group called sg1instance
  *   will be built inside sg2, as a copy of sg1(meaning the children of sg1 instance are copies of sg1's children).
  *   And a signal group called sg2instance will be built inside u as a copy of sg2(sg2instance copies all
  *   the children of sg2: signal group sg1instance and signal s3).
  *   Note that even though sg1instance and sg2instance are instances of signal groups, they are not referenced 
  *   inside their parent scopes, they are copied, child by child. Although this may seem like a waste of memory
  *   it is necessary for the use of the autorouter which has to connect all signals instantiated in scopes,
  *   and can't do so if those signals exist only as references.
  * 3.There is a special type of global signal groups. Take sg3 in the example above. It's built in the scope of the design,
  *   yet there is an instance of an interface inside it. You cannot build an interface inside a signal group, the
  *   build function for interface cannot take a signal group for parent. This means that in this case, the walker will call
  *   the third build function of this class, and build a sg3 using the ports inside the interface(of course, after having transformed
  *   them in signals by removing their direction). This feature is also available for interfaces which can be
  *   build out of signal groups. CAUTION:syntax for this particular case may not be accurate!!!
  *   sg3 = build(lineNo, design, string(sg3), ifc1);
  *   
  * There is also something to be said about formal to actual mapping involving signal groups.
  * In unit u there is an instance of signal group sg2 called sg2instance. This instance will be connected 
  * to instance ifc1instance inside unit v via the formal to actual mapping marked (*) in the example above.
  * Taking into account the copy mechanism described earlier, the structure of the two units follows here:
  *        u                                          v
  *        |                                          |
  *   sg2instance                                 ifc1instance
  *   /         \                                  /   |    \
  * sg1instance  c3                               c1   c2   c3        
  *   /   \
  *  c1   c2
  * 
  * Although the three connectables all have the same names, only c3 from the signal group will be connected
  * to c3 from the interface. The other two(c1 and c2) are on different levels of the hierarchy. The adapter 
  * will not signal an error, it will simply not include the illegal connections in the generated verilog 
  * formal to actual mapping.
  * 
  * The last observation under this section has to do with the generate_individual_RTL_signals() method
  * called for signal group sg1. It's effect concerns the verilog output. If this option is OFF, the verilog
  * equivalent of sg1 will be one verilog net declaration(in this case) with the cumulated bitranges of
  * all signals within sg1, meaning c1 and c2. That unique net decl will bare the name of the signal group
  * and a bitrange of 2(c1 and c2 have no specified width, therefore the adapter will consider the default width which is 1).
  * If the generate_individual_RTL_signals option is ON, the verilog output will contain one net decl for each signal inside sg1.
  * That means one for c1 and one for c2. The adapter naming rule states that the name of the net decl is made out of the
  * name of the csl signal prefixed with the name of the parent signal group.Run the cslc for the csl example above, and
  * look over the generated code for a better understanding of this paragraph.
  */
class CSLOmGroupSignal : public CSLOmConnectable {
  private:
    /** If true, one verilog net/var will be generated for each signal inside the group.
      * If false, one verilog net/var will be generated for all signals inside the group.
      */
    TBool m_generateIndividualRtlSignals;
    
    /** Holds the current scope(that of the signal group).
      */
    RefCSLOmScope m_scope; 
    TBool m_hasPrefix;
   
    /** If not null, the name of each signal inside the group will be prefixed with this string.
      */
    RefString m_prefix;
    RefString m_suffix;


    TBool m_noPrefix;

    TBool m_instantiation;

    //stores the original class name (eg. when a signal group instance is instantiated) - this is subject to change 
    RefString m_className;
    
    /** Class constructor. Calls the CSLOmConnectable constructor and initializes all
      * the class members to their default values.
      */
    CSLOmGroupSignal(TLineNumberType lineNumber, RefString fileName); 
    
    /** Returns reference to curremt object.
      */
    RefCSLOmGroupSignal getThis() const { return boost::static_pointer_cast<CSLOmGroupSignal>(m_weakRef.lock()); }
    
    /** Builds pointer of CSLOmGroupSignal and wraps it in a boost smart pointer(strong reference).
      * Sets the parent, builds the id and the current scope.
      * Returns the created reference.
      */
    static RefCSLOmGroupSignal allocate (TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name);
    
    /** Recursive function: copies all the children of the connectable object(another signal group
      * or an interface) to the current object.
      */
    void copyInterfaceOrSignalGroup (RefCSLOmConnectable connectable);
  public:
    RefTVec_RefCSLOmBase getAssignListFull() const;
    TBool doesNotHavePrefix() { return !m_hasPrefix; }
    RefTVec_RefCSLOmSignal getAllSignals() const;
    /** Downcasts a base object to a current object.
      */
    static RefCSLOmGroupSignal cast(RefCSLOmBase object);
    
    /** Return the current unique identifier(as CSLOmIdentifier or as CSLOmBase).
      */
    RefCSLOmIdentifier getID() const { ASSERT(getChild(ID).get(), "CSLOmGroupSignal::getID() ID null"); return CSLOmIdentifier::cast(getChild(ID)); }
    RefCSLOmBase getIDAsBase() const { ASSERT(getChild(ID).get(), "CSLOmGroupSignal::getIDAsBase() ID null"); return getChild(ID); }

    /** Returns the name of the current object.
      */
    RefString getName() const { return getID()->getName(); }

    const RefString getGroupSignalClassName() const;
    void setGroupSignalClassName(RefString name);

    /** Builds an object of type CSLOmGroupSignal.
      * Input params:
      *   lineNumber
      *   parent      parent of current object
      *   name        name of current object
      *   expr        link to another signal group object (used in instantiations to build a local copy 
      *                                                    of the signal group object that expr points to)    
      * Calls: allocate() and second build() function
      * Returns: the current reference
      */
    static RefCSLOmGroupSignal build( TLineNumberType lineNumber,
                                      RefString fileName,
                                      RefCSLOmBase parent, 
                                      const RefString& name, 
                                      RefCSLOmExprLink expr = RefCSLOmExprLink(),
                                      RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap = RefTMap_RefCSLOmExprLink_RefCSLOmExpr()
                                    );
    
    /** Builds an object of type CSLOmGroupSignal.
      * Input params:
      *   lineNumber
      *   parent      parent of current object
      *   name        name of current object
      *   groupSignal signal group object (pseudo copy constructor)
      *                                                    
      * Calls: allocate() and copyInterfaceOrSignalGroup() 
      * Returns: the current reference
      */

    static RefCSLOmGroupSignal build( TLineNumberType lineNumber,
                                      RefString fileName,
                                      RefCSLOmBase parent,
                                      const RefString name,
                                      RefCSLOmGroupSignal groupSignal,
                                      RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap = RefTMap_RefCSLOmExprLink_RefCSLOmExpr()
                                    );
    
    /** Builds an object of type CSLOmGroupSignal.
      * Input params:
      *   lineNumber
      *   parent      parent of current object
      *   name        name of current object
      *   interface   interface object (pseudo copy constructor: turns th ports into signals and sets them as children
      *                                 for the current group signal)
      *                       
      * Calls: allocate() and copyInterfaceOrSignalGroup()
      * Returns: the current reference
      */

    static RefCSLOmGroupSignal build( TLineNumberType lineNumber,
                                      RefString fileName,
                                      RefCSLOmBase parent,
                                      const RefString name,
                                      RefCSLOmInterface interface,
                                      RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap = RefTMap_RefCSLOmExprLink_RefCSLOmExpr()
                                    );
     
    /** Sets the m_generateIndividualRtlSignals class member
      * This flag can be set to false only if all the
      * signals in the current signal group are of the same type.
      * The adapter will use the cumulated bitranges of all
      * the signals in the group to generate an unique verilog net/var.
      */
    void setGenerateIndividualRtlSignals(TBool option);

    /** Returns the m_generateIndividualRtlSignals value.
      */
    TBool getGenerateIndividualRtlSignals();
    
    /** Builds another signal inside the signal group using the input params.
      * Input params:
      *   lineNumber
      *   name      name of signal to add in the current signal group
      *   sigType   type of signal to add in the current signal group
      *   bitRange  exprLink to bitRage of signal to add in the current signal group
      * Calls: CSLOmSignal build() function.
      * Returns: the added signal
      * NOTE: This method does NOT take a CSLOmSignal object input param.
      *       Reason: The signals of a group have to be built inside the signal group, it is illegal
      *               to add a pre-built signal to a signal group.  
      */
    RefCSLOmSignal addSignal(TLineNumberType lineNumber,RefString fileName, const RefString& name, ECSLOmSignalType sigType, RefCSLOmExprLink bitRange);

    /** Removes a signal from the signal group's children vector.
      */
    void removeSignal(RefCSLOmSignal sig);

    /** Returns children of type signal(as a vector of CSLOmSignal or CSLOmBase).
      */
    RefTVec_RefCSLOmSignal getSignals() const;
    RefTVec_RefCSLOmBase getSignalsAsBase() const;

    /** Returns children of type signal group (as a vector of CSLOmGroupSignal or CSLOmBase).
      */
    RefTVec_RefCSLOmGroupSignal getGroupSignals() const;
    RefTVec_RefCSLOmBase getGroupSignalsAsBase() const;
    
    /** Returns the current scope.
      */
    RefCSLOmScope getAttachedScope() const;

    /** Checks if the input signal exists among the signals of the group.
      */
    TBool containsSignal(const RefCSLOmSignal& sig) const;

    /** Sets the m_prefix class member.
      */
    void setPrefix(const RefString& prefix);

    /** Returns the value of m_prefix.
      */
    const RefString getPrefix() const;

    /** Sets the m_suffix class member.
      */
    void setSuffix(const RefString& suffix);

    /** Returns the value of m_suffix.
      */
    const RefString getSuffix() const;

    /**
     *  method needed for copying the parameters from interface to instance
     **/
    RefCSLOmParameter  addParameter(TLineNumberType lineNumber, RefString fileName, RefCSLOmParameter oldParam, RefCSLOmNumber value = RefCSLOmNumber());


    /**
     *  Get all parameters 
     **/
    RefTVec_RefCSLOmBase  getParameters();


    //m_noPrefix enable/get

    void enableNoPrefix();


    TBool getNoPrefixBit() const;


    RefCSLOmNumber getWidth() const;


    TBool isInstantiation() const;

    
    /** Link to visitor pattern.
      */
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
    
};

// ********************************************************************************
// CSLOmInterface class
// ********************************************************************************
/**
 * Class that retains an csl_interface object.
 * it is basically a group of ports
 */
class CSLOmInterface : public CSLOmConnectable {
  public:
    static RefCSLOmInterface cast(RefCSLOmBase object);
    RefCSLOmIdentifier getID() const { ASSERT(getChild(ID).get(), "Identifier non existent"); return CSLOmIdentifier::cast(getChild(ID)); }
    RefCSLOmBase getIDAsBase() const { ASSERT(getChild(ID).get(), "Identifier non existent"); return getChild(ID); }
    RefString getName() const { return getID()->getName(); }
    TBool isDefaultIfc() const { return (getName()->at(0) == '*'); }
    const TBool isReversed() const { return m_isReversed; }
    RefTVec_RefCSLOmPortDecl getAllPorts() const;
  private:
    TBool m_hasPrefix;
    TBool m_noPrefix;
    TBool m_isReversed;
    RefCSLOmInterface getThis() const { return boost::static_pointer_cast<CSLOmInterface>(m_weakRef.lock()); }

  protected:
    CSLOmInterface(TLineNumberType, RefString);

    /**
     * This method adds the ports of the param interface to the current interface
     * NOTE: if the current interface has allready some ports those ports are NOT deleted
     */
    void setInterface(RefCSLOmInterface interface);
    void transformGroup(ECSLOmPortDirection direction, RefCSLOmGroupSignal group);
    
    RefCSLOmScope m_scope;
    RefString m_prefix;
    RefString m_suffix;

    TBool m_instantiation;
    //stores the original class name (eg. when an interface instance is instantiated) - this is subject to change 
    RefString m_className;

  public:
    RefTVec_RefCSLOmBase getAssignListFull() const;
    TBool doesNotHavePrefix() { return !m_hasPrefix; }
    void enableNoPrefix() { m_noPrefix = TRUE; }
    TBool getNoPrefixBit() { return m_noPrefix; }
    /**
     * Creates a generic Interface
     */
    static RefCSLOmInterface build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExprLink expr = RefCSLOmExprLink(), 
                                   RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap = RefTMap_RefCSLOmExprLink_RefCSLOmExpr());

    static RefCSLOmInterface build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmInterface interfaceIn, 
                                   RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap = RefTMap_RefCSLOmExprLink_RefCSLOmExpr());

    static RefCSLOmInterface build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmPortDirection direction, 
                                   RefCSLOmGroupSignal groupIn, RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap = RefTMap_RefCSLOmExprLink_RefCSLOmExpr());
    
    static RefCSLOmInterface buildRD(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr width, RefCSLOmExpr depth);
    static RefCSLOmInterface buildWR(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr width, RefCSLOmExpr depth);
    /**
     * This method creates a new port as child of the interface
     */
    RefCSLOmPortDecl addPort(TLineNumberType lineNumber,RefString fileName, const RefString& name, ECSLOmPortDirection direction, ECSLOmSignalType type, RefCSLOmExpr bitRange = RefCSLOmExpr());
    
    /**
     * This method creates a new port with the attribute set 
     * added by AS (so you know who to blame if something goes wrong)
     */
    RefCSLOmPortDecl addPort(TLineNumberType lineNumber,RefString fileName, const RefString& name, ECSLOmPortDirection direction, ECSLOmSignalType type,  ECSLOmSignalAttr attr, RefCSLOmExpr bitRange = RefCSLOmExpr());
    
    /**
     * This method adds a port list to the interface
     * The method copies the ports doesn't move them
     */
    void addPortList(TLineNumberType lineNumber,RefString fileName, RefCSLOmList name, ECSLOmPortDirection direction, ECSLOmSignalType type, RefCSLOmExpr bitRange);

    /**
     * Reverses all ports
     *
     * @see CSLOmPortDecl::reverse()
     */
    void reverse();

    /**
     * This method removes a port from the interface
     * This method deletes the port object entirely
     */
    void removePort(RefCSLOmPortDecl port);

    /**
     * Returns the vector of ports contained by the interface
     */
    RefTVec_RefCSLOmPortDecl getPorts() const;
    RefTVec_RefCSLOmBase getPortsAsBase() const;
    RefTVec_RefCSLOmInterface getInterfaces() const;
    RefTVec_RefCSLOmBase getInterfacesAsBase() const;
    /**
     * Returns the attached scope to the interface
     *
     * @see CSLOmScope
     */
    RefCSLOmScope getAttachedScope() const;

    RefCSLOmNumber getWidth() const;

//     RefCSLOmList getInputs() const;
//     RefCSLOmList getOutputs() const;

    /**
     * Returns true is the port exists in the interface
     */
    TBool containsPort(const RefCSLOmPortDecl& port) const;

    /**
     * This is used for code generating
     * when this interface will be generated into verilog, all the member ports will be prefixed with this prefix
     */
    void setPrefix(const RefString& prefix);
    const RefString getPrefix() const;

    /** Sets the m_suffix class member.
      */
    void setSuffix(const RefString& suffix);

    /** Returns the value of m_suffix.
      */
    const RefString getSuffix() const;

    /**
     *  method needed for copying the parameters from interface to instance
     **/
    RefCSLOmParameter  addParameter(TLineNumberType lineNumber, RefString fileName, RefCSLOmParameter oldParam, RefCSLOmNumber value = RefCSLOmNumber());


    /**
     *  Get all parameters 
     **/
    RefTVec_RefCSLOmBase  getParameters();


    TBool isInstantiation() const;


    const RefString getInterfaceName() const;

    const RefString getInterfaceClassName() const;
    void setInterfaceClassName(RefString name);

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const ;
};


// ********************************************************************************
// CSLOmPortDecl class
// ********************************************************************************
/**
 * This class holds a port description.
 */
class CSLOmPortDecl : public CSLOmConnectable {
  public:

    static RefCSLOmPortDecl cast(RefCSLOmBase object);
    RefCSLOmIdentifier getID() const { ASSERT(getChild(ID).get(), "Identifier non existent"); return CSLOmIdentifier::cast(getChild(ID)); }
    RefCSLOmBase getIDAsBase() const { ASSERT(getChild(ID).get(), "Identifier non existent"); return getChild(ID); }
    RefString getName() const { return getID()->getName(); }
    const TBool isReversed() const {return m_isReversed;}
  private:
    RefCSLOmPortDecl getThis() const { return boost::static_pointer_cast<CSLOmPortDecl>(m_weakRef.lock()); }
    ECSLOmPortDirection m_portDirection; // this holds the port direction (INPUT, OUTPUT, INOUT)
    ECSLOmSignalType m_signalType; // this holds the port type (TYPE_WIRE, TYPE_REG ... ) 
    TBool m_isSigned; // this holds the sign of the port
    TBool m_isReversed;
    ECSLOmSignalAttr m_portAttr;
  protected:
    CSLOmPortDecl(TLineNumberType, RefString, ECSLOmPortDirection, ECSLOmSignalType);
  public:

    void setAttr(ECSLOmSignalAttr attr) { m_portAttr = attr; }
    ECSLOmSignalAttr getAttr() const { return m_portAttr; }
    
    /**
     * The build method for CSLOmNumber
     *
     * @param lineNumber - type TLineNumberType - the lineNumber where the number appears
     * @param parent - type RefCSLOmBase - the parent of the port
     * @param portType - type ECSLOmPortDirection - the port type (input, output, inout)
     * @param signalType - type ECSLOmSignalType - the signal type (wire, reg, ...)
     *
     * @return RefCSLOmPortDecl - the port object that has been built
     *
     * @see ECSLOmPortDirection
     * @see ECSLOmSignalType
     */
    static RefCSLOmPortDecl build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmPortDirection portDirection, ECSLOmSignalType signalType = SIGNAL_WIRE);
                                                              
    static RefCSLOmPortDecl build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmPortDirection portDirection, RefCSLOmExpr expr);
                                                              
    static RefCSLOmPortDecl build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmPortDirection portDirection, RefCSLOmExpr expr1, RefCSLOmExpr expr2);
                                                              
    static RefCSLOmPortDecl build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExprLink portName);

    /**
     * Returns the port direction
     *
     * @see ECSLOmPortDirection
     */
    ECSLOmPortDirection getPortDirection() const;

    /**
     * Returns the port type
     *
     * @see ECSLOmSignalType
     */
    ECSLOmSignalType getPortType() const;

    /**
     * Returns the port direction
     *
     * @see ECSLOmPortDirection
     */
    void setPortDirection(ECSLOmPortDirection portDir);

    /**
     * Returns the port type
     *
     * @see ECSLOmSignalType
     */
    void setPortType(ECSLOmSignalType portType);


    /**
     * Sets the signed status to this port declaration. If this port declaration does not support sign,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown.
     *
     * @see ECSLOmSignalType
     */
    void setSigned();

    /**
     * Returns the signed status of this port declaration. If this port declaration does not support sign,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown.
     *
     * @return true or false, depending on the sign status of this port declaration
     * @see ECDOmVarType
     */
    TBool isSigned() const;

    /**
     * Attaches a bitrange to this port declaration. If this port declaration does not support bitrange,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown.
     *
     * @param bitrange the bitrange to be attached to this port declaration
     * @see ECSLOmSignalType
     */
    void setBitRange(RefCSLOmExpr bitRange);

    /**
     * Attaches a bitrange to this port declaration. If this port declaration does not support bitrange,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown.
     *
     * @param bitrange the bitrange to be attached to this port declaration
     * @see ECSLOmSignalType
     */
    void setBitRange(RefCSLOmBaseRange bitRange);

    /**
     * Attaches a range to this port declaration. If this port declaration does not support range,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown.
     *
     * @param range the range to be attached to this port declaration
     * @see ECSLOmSignalType
     */
    void setRange(RefCSLOmExpr lowerIndex, RefCSLOmExpr upperIndex);

    /**
     * Attaches a width to this port declaration. If this port declaration does not support width,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown.
     *
     * @param width the width to be attached to this port declaration
     * @see ECSLOmSignalType
     */
    void setWidth(RefCSLOmExpr width);

    /**
     * Attaches a offset to this port declaration. If this port declaration does not support offset,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown.
     *
     * @param offset the offset to be attached to this port declaration
     */
    void setOffset(RefCSLOmExpr offset);
    const RefCSLOmExpr getOffset() const;

    /**
     * Reverses the port direction
     */
    void reverse();
 

    /**
     * Returns the range attached to this port declaration. If this port declaration does not support range,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown. <br/>
     * On valid cases where no range is attached this method returns null, that is calling get() on returned
     * object returns 0.
     *
     * @return the range attached to this port declaration or null if no range is attached
     * @see ECDOmVarType
     */
    RefCSLOmBaseRange getBitRange() const;
    const RefCSLOmBase getBitRangeAsBase() const;

    /**
     * returns the width of the port
     */
    RefCSLOmExpr getWidth() const;

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

}

#endif
