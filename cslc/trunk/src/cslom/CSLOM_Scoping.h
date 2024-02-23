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

#ifndef INC_GUARD_CSLOm_SCOPEing_h
#define INC_GUARD_CSLOm_SCOPEing_h

#include "Base.h"
#include "../support/CommonSupport.h"
#include "VeriNum.h"
#include "CSLOM_Declarations.h"
#include "CSLOM_Base.h"

namespace NSCSLOmVisitor {
class CVisitor;
}

namespace NSCSLOm {

// ********************************************************************************
// CSLOmIdentifier class
// ********************************************************************************
/**
 * This class models an identifier. For example: wire a, b; -> a and b are identifiers <br/>
 * There is an additional optional payload member that may be one of: <br/>
 *   - a range list used for identifiers that support ranges, ex: wire w[2:0][5:2]; <br/>
 *   - a initial value expression, ex: output reg = 1; wire w = 1; parameter p = 1; <br/>
 *   - a single range used for identifiers that support ranges, ex: module instance: mod x[20]; <br/>
 * Nets and variables support the first two variants above meanwhile params, attributes and output variable ports support
 * only the second one; module instances support only the third variant above.
 */
class CSLOmIdentifier : public CSLOmBase {
  public:
    static RefCSLOmIdentifier cast(RefCSLOmBase object);
  private:
    RefCSLOmIdentifier getThis() const { return boost::static_pointer_cast<CSLOmIdentifier>(m_weakRef.lock()); }
  public:
    /**
     * Holds enum constants for drive identifier types.
     */
    enum EIdType {
      ID_UNDEFINED           = 0x00000000,
      ID_CSL_UNIT            = 0x00000001,
      ID_CSL_DESIGN          = 0x00000002,
      ID_UNIT_INST           = 0x00000004,
      ID_CSL_SIGNAL          = 0x00000008,
      ID_CSL_GROUP           = 0x00000010,
      ID_CSL_PORT            = 0x00000020,
      ID_BIT_RANGE           = 0x00000040,
      ID_CSL_LIST            = 0x00000080,
      ID_CSL_INTERFACE       = 0x00000100,
      ID_PARAMETER           = 0x00000200,
      ID_CSL_TESTBENCH       = 0x00000400,
      ID_TB_VECTOR           = 0x00000800,
      ID_ENUM                = 0x00001000,
      ID_ENUM_ITEM           = 0x00002000,
      ID_MEMORY_MAP_LOCATION = 0x00004000,
      ID_MEM_MAP_PAGE        = 0x00008000,
      ID_MEM_MAP_PAGE_INST   = 0x00010000,
      ID_FIELD               = 0x00020000,
      ID_ADDRESS_RANGE       = 0x00040000,
      ID_MEMORY_MAP          = 0x00080000, 
      ID_ISA_ELEM            = 0x00100000,
      ID_MAX                 = 0x00200000
    };

  private:
    EIdType m_idType;
    RefString m_name;
    RefCSLOmBase m_payload;
    RefCSLOmIdentifier m_complementaryID; // used for ports that are declared in two separate declarations such as: output w; reg w;

    CSLOmIdentifier(TLineNumberType lineNumber, RefString fileName, ECSLOmType type, EIdType idType, const RefString& name, const RefCSLOmBase& payload);

  private:
    /**
     * Returns true if the passed in identifier type is a direct scope identifier, that is its type is one of: <br/>
     *   - ID_UNIT <br/>
     *   - ID_DESIGN <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the passed in identifier type
     * @see EIdType
     * @see getIdType()
     */
    static TBool isToScopeDirect(EIdType idType);

    /**
     * Returns true if the passed in identifier type is a indirect scope identifier, that is its type is one of: <br/>
     *   - ID_MODULE_INST <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the passed in identifier type
     * @see EIdType
     * @see getIdType()
     */
    static TBool isToScopeIndirect(EIdType idType);

    /**
     * Returns true if this object supports payload, that is his identifier type is one of: <br/>
     *   - ID_BIT_RANGE <br/>
     *   - ID_SIGNAL <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on this object identifier type
     * @see EIdType
     * @see getIdType()
     */
    TBool supportsPayload() const;

    /**
     * Checks if a certain identidier type supports a certain payload type.
     * Throws an exception if not.
     *
     * @see EIdType
     * @see ECSLOmType
     */
    static void checkPayload(EIdType idType, ECSLOmType payloadType);

    /**
     * There are identifier types that support complementary id; this is the situation of ports that can be declared in
     * two separate declarations such as: output a; reg a;
     * Returns true if this object supports complementary id, that is his identifier type is one of: <br/>
     *   - ID_PORT <br/>
     *   - ID_TF_PORT <br/>
     *   - ID_NET <br/>
     *   - ID_VAR <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on this object identifier type
     * @see EIdType
     * @see getIdType()
     */
    TBool supportsComplementaryID() const;

    // since these methods are private, some friend class declarations are needed:
    friend class CSLOmScope;
    friend class CSLOmUnitDecl;
    friend class CSLOmUnitReplica;
    friend class CSLOmUnitInstance;
    friend class CSLOmPortDecl;
    friend class CSLOmSignal;
    friend class CSLOmBitRange;
    friend class CSLOmSimpleBitRange;
    friend class CSLOmMultiDimBitRange;
    friend class CSLOmList;
    friend class CSLOmInterface;
    friend class CSLOmParameter;
    friend class CSLOmGroupSignal;
    friend class CSLOmTestbenchDecl;
    friend class CSLOmTestbenchVector;
    friend class CSLOmMemoryMap;
    friend class CSLOmMemoryMapLocation;
    friend class CSLOmMemoryMapPage;
    friend class CSLOmMemoryMapPageInstance;
    friend class CSLOmEnum;
    friend class CSLOmField;
    friend class CSLOmIsaField;
    friend class CSLOmIsaElement;
    friend class CSLOmAddressRange;

    void setComplementaryID(RefCSLOmIdentifier& id);

    RefCSLOmIdentifier getComplementaryID() const;

    // since this method is private, some friend class declarations are needed:
    static RefCSLOmIdentifier build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, EIdType idType, const RefString& name, RefCSLOmBase payload = RefCSLOmBase());
    TBool isRemovable() const;

  public:
    EIdType getIdType() const;

    const RefString getName() const;
    const RefString getLowerName() const;
    const RefString getUpperName() const;

    const RefCSLOmBase getPayload() const;
  
    /**
     * Returns the scope object to which this object is associated to. <br/>
     * Every scope has a identifier associated with it. In case this
     * object is not an identifier that represents a scope, an exception is thrown.
     *
     * @return the scope object to which this object is associated to
     * @see CSLOmBase::isToScope()
     * @see CSLOmScope
     */
    RefCSLOmScope toScope() const;

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmScope class
// ********************************************************************************
/**
 * This class models a scope in CSLOm. It is responsible for tracking identifiers that are
 * defined inside each scope, for resolving references to simple or hierarchical identifiers
 * across scope hierarchy and also takes care of detecting duplicate identifier definitions
 * inside same scope, case in which it throws an exception. <br/> <br/>
 *
 * <b>PDF SPEC 12.6: Scope rules</b> <br/>
 * The following elements define a new scope in CSL: <br/>
 * - Units <br/>
 * - Interfaces <br/> <br/>
 *
 * An identifier shall be used to declare only one item within a scope. This rule means it is illegal to declare
 * two or more variables that have the same name, or to name a task the same as a variable within the same
 * module, or to give a gate instance the same name as the name of the net connected to its output. <br/> <br/>
 *
 * If an identifier is referenced directly (without a hierarchical path) within a task, function, or named block, it
 * shall be declared either locally within the task, function, or named block, or within a module, task or named
 * block that is higher in the same branch of the name tree that contains the task, function, or named block. If it
 * is declared locally, then the local item shall be used; if not, the search shall continue upward until an item by
 * that name is found or until a module boundary is encountered. If the item is a variable, it shall stop at a module
 * boundary; if the item is a task, function, or named block it continues to search higher-level modules until
 * found. The search shall cross named block, task, and function boundaries but not module boundaries. This
 * fact means that tasks and functions can use and modify the variables within the containing module by name,
 * without going through their ports. <br/> <br/>
 *
 * If an identifier is referenced with a hierarchical name, the path can start with a module name, instance name,
 * task, function, or named block. The names shall be searched first at the current level, then in higher-level
 * modules until found. Since both module names and instance names can be used, precedence is given to
 * instance names if there is a module named the same as an instance name. <br/> <br/>
 *
 * Because of the upward searching, path names which are not strictly on a downward path can be used.
 */
class CSLOmScope {
  public:
    /**
     * Holds enum constants for scope types.
     */
    enum EScopeType {
      SCOPE_UNDEFINED,
      SCOPE_DESIGN, 
      SCOPE_CSL_DESIGN,
      SCOPE_UNIT_DECL, 
      SCOPE_TESTBENCH_DECL,
      SCOPE_UNIT_INST,
      SCOPE_INTERFACE,
      SCOPE_GROUP,
      SCOPE_FIELD,
      SCOPE_MEM_MAP,
      SCOPE_ISA_ELEM,
      SCOPE_MEM_MAP_PAGE,
      SCOPE_MAX
    };
    TBool isDesignScope() const { return SCOPE_DESIGN == m_scopeType; }
    TBool isUnitDeclScope() const { return SCOPE_UNIT_DECL == m_scopeType; }
  private:
    EScopeType m_scopeType;
    RefCSLOmIdentifier m_id; // the identifier that represents this scope
    RefTVec_RefCSLOmIdentifier m_ids;
    RefTMap_RefString_RefCSLOmIdentifier m_nameMap;

    CSLOmScope(EScopeType type, const RefCSLOmIdentifier& id);

    // since this method is private, some friend class declarations are needed:
    friend class CSLOmDesign;
    friend class CSLOmUnitDecl;
    friend class CSLOmUnitReplica;
    friend class CSLOmInterface;
    friend class CSLOmGroupSignal;
    friend class CSLOmTestbenchDecl;
    friend class CSLOmTestbenchVector;
    friend class CSLOmField;
    friend class CSLOmIsaField;
    friend class CSLOmIsaElement;
    friend class CSLOmMemoryMapPage;
    friend class CSLOmMemoryMap;
    static RefCSLOmScope build(const RefCSLOmIdentifier& id = RefCSLOmIdentifier());

    friend class CSLOmExprLink;
    RefCSLOmIdentifier lookupDownward(const RefString& name) const;

    RefCSLOmIdentifier lookupDownward(const RefTVec_RefString& hid) const;

    // since this method is private, due to automation, some friend class declarations are needed:
    friend class CSLOmIdentifier;
    /**
     * Registers a new identifier in this scope.
     * If an identifier with the same name is already registered in this scope it throws an exception.
     */
    // since this method is private, due to automation, some friend class declarations are needed:
    friend class CSLOmBase;
    void registerID(RefCSLOmIdentifier& id);
    /**
     * Removes an entry in the scope, the following entries can be removed:
     * - ID_PORT, if the scope type SCOPE_INTERFACE
     */
    void removeID(const RefString& name);

  public:
    EScopeType getScopeType() const;

    /**
     * Returns the identifier associated with this scope.
     *
     * @return the identifier associated with this scope
     */
    RefCSLOmIdentifier getID() const;
    RefCSLOmBase getHolderObject() const;
    /**
     * Returns true if this scope object contains an identifier with the same name as the passed in name
     * or false otherwise.
     *
     * @param name a name to be searched for
     * @return true if this scope object contains an identifier with the same name as the passed in name
     * or false otherwise.
     */
    TBool containsID(const RefString& name) const;

    /**
     * Returns an identifier, that has the same name as the passed in name,
     * in the local scope only, that is no downward or upward scope search takes place.
     * If no identifier is found a null identifier is returned, that is calling get()
     * on returned object returns 0.
     *
     * @param name a name to be searched for
     * @return an identifier that maches the search of null if no identifier was found
     */
    RefCSLOmIdentifier lookupLocal(const RefString& name) const;

    /**
     * Finds the first identifier match according to scope search rules and idMask. <br/>
     * idMask is a OR mask of enum constants (CSLOmIdentifier::EIdType) <br/>
     * idMask example: ID_TASK | ID_NAMED_BLOCK <br/>
     * Example: disable <id> -> id can refer to both a task id or a named block id
     *
     * @param name a name to be searched for
     * @param idMask the identifier mask that returned identifier must match
     * @return an identifier that maches the search of null if no identifier was found
     * @see CSLOmIdentifier::EIdType
     */
    RefCSLOmIdentifier lookup(const RefString& name, TUInt idMask) const;

    /**
     * Finds the first identifier match according to scope search rules and idMask. <br/>
     * idMask is a OR mask of enum constants (CSLOmIdentifier::EIdType) <br/>
     * idMask example: ID_TASK | ID_NAMED_BLOCK <br/>
     * Example: disable <id> -> id can refer to both a task id or a named block id
     *
     * @param hid a name to be searched for
     * @param idMask the identifier mask that returned identifier must match
     * @return an identifier that maches the search of null if no identifier was found
     * @see CSLOmIdentifier::EIdType
     */
    RefCSLOmIdentifier lookup(const RefTVec_RefString& hid, TUInt idMask) const;

    /**
     * Returns a vector of all identifiers registered in this scope.
     *
     * @return a vector of all identifiers registered in this scope
     */
    const RefTVec_RefCSLOmIdentifier getIDs() const;

};

// ********************************************************************************
// CSLOmScopeBlock class
// ********************************************************************************
/**
 * This class hold a link to a previously declared scope, it implements the 
 * csl scope logic. The csl syntax for this is:
 * scope x {
 *  //x is a unit and here are the unit commands and declarations
 * }
 */
class CSLOmScopeBlock {
  private:
    static RefTVec_RefCSLOmScope m_path;
    static RefTVec_RefString m_namePath;
  protected:
    friend class CSLOmExprLink;
    static RefTVec_RefString getNamePath() {return m_namePath;}
    static RefTVec_RefCSLOmScope getScopePath() {return m_path;}
  public:
    static void enterScope(RefCSLOmScope scope);
    static TBool enterScope(RefCSLOmExprLink linkToObject);
    static void exitScope();
    static RefCSLOmScope getCurrentScope();
    static RefString getCurrentScopeName();
    static RefCSLOmDesign getDesign();
};

}

#endif
