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

#ifndef INC_GUARD_CSLOm_EXPRs_h
#define INC_GUARD_CSLOm_EXPRs_h

#include "Base.h"
#include "../support/CommonSupport.h"
//#include "VeriNum.h"
#include "CSLOM_Declarations.h"
#include "CSLOM_Base.h"

namespace NSCSLOmVisitor {
class CVisitor;
}

namespace NSCSLOm {

// ********************************************************************************
// CSLOmExpr class
// ********************************************************************************
/**
 * This is the base class for all expresions in CSLOm.
 */
class CSLOmExpr : public CSLOmBase {
  public:
    static RefCSLOmExpr cast(RefCSLOmBase object);
    static RefCSLOmNumber getValueForInstance(RefCSLOmUnitInstance, RefTMap_RefCSLOmUnitInstance_RefCSLOmBase);

    /**
     * Holds enum constants for expression types.
     */
    enum EExprType {
      EXPR_UNDEFINED,
      EXPR_NUMBER,
      EXPR_REAL_NUMBER,
      EXPR_HID,
      EXPR_CONCAT,
      EXPR_MULTI_CONCAT,
      EXPR_FUNCTION_CALL,
      EXPR_MINTYPMAX,
      EXPR_OP,
      EXPR_STRING,
      EXPR_HYBRID_OR_FUNC_CALL,
      EXPR_FUNC_SIGNATURE,
      EXPR_MAX
    };

    TBool isNumber() const { return EXPR_NUMBER == m_exprType; }
    TBool isRealNumber() const { return EXPR_REAL_NUMBER == m_exprType; }
    TBool isExprLink() const { return EXPR_HID == m_exprType; }
    TBool isConcat() const { return EXPR_CONCAT == m_exprType; }
    TBool isMultiConcat() const { return EXPR_MULTI_CONCAT == m_exprType; }
    TBool isFunctionCall() const { return EXPR_FUNCTION_CALL == m_exprType; }
    TBool isMintypmax() const { return EXPR_MINTYPMAX == m_exprType; }
    TBool isOp() const { return EXPR_OP == m_exprType; }
    TBool isString() const { return EXPR_STRING == m_exprType; }
    TBool isHybridORFuncCall() const { return EXPR_HYBRID_OR_FUNC_CALL == m_exprType; }
    TBool isFuncSignature() const { return EXPR_FUNC_SIGNATURE == m_exprType; }
    
  private:
    EExprType m_exprType;

  protected:
    CSLOmExpr(TLineNumberType lineNumber,RefString fileName, EExprType exprType);
    mutable RefCSLOmBase m_cachedEval; // used for caching the evaluation result
    mutable int m_cachedEnumEval; //used for caching the evaluation result for enums
    TInt m_width;
    TBool m_isEvaluated;

  public:
    virtual ~CSLOmExpr(){}
    virtual TInt getWidth(){ return m_width; }
    EExprType getExprType() const;

    /**
     * Returns true if this expression is constant, or false otherwhise
     *
     * @return true or false, depending on const status of this expression
     */
    virtual TBool isConst() const = 0;

    /**
     * Returns true if the expression cam be a lvalue (variable or net)
     */
    TBool canBeLvalue() const;

    //TODO <Eugen> Comment this fucntion, with explanations about how does this work
    TBool isPrimary() const;

    /**
     * Returns a vector of all children (sub)expressions. This function is useful for subclasses
     *
     * @return a vector of all children (sub)expressions
     *
     * @see CSLOmExprLink
     */
    const RefTVec_RefCSLOmExpr getExprs() const;

    virtual RefCSLOmExpr dupp() = 0;

    virtual RefTVec_RefCSLOmExpr getExprs() = 0;

    /**
     * This method return the evaluation result. No caching should occur here.
     *
     * @return RefCSLOmEvalRes the evaluation result of this expression
     * @see eval()
     */
    virtual RefCSLOmBase doEval(TBool convertEnumItem = FALSE) = 0;
    virtual RefTMap_RefCSLOmUnitInstance_RefCSLOmBase doParamEval(RefCSLOmBase) = 0;

    virtual const TBool isEvaluated() const = 0;
};

// ********************************************************************************
// CSLOmString class
// ********************************************************************************
class CSLOmString : public CSLOmExpr {
  public:
    static RefCSLOmString cast(RefCSLOmBase object);

    RefTVec_RefCSLOmExpr getExprs() { return RefTVec_RefCSLOmExpr(); }
    
  private:
    RefString m_value;
 
    RefCSLOmString getThis() const { return boost::static_pointer_cast<CSLOmString>(m_weakRef.lock()); }
    CSLOmString(TLineNumberType lineNumber, RefString fileName);
  public:
    static RefCSLOmString build(TLineNumberType lineNumber,RefString fileName, RefString value);

    void append(RefString appendValue);
    TUInt length();
    RefString getValue();

    TBool isEmpty() { return m_value->empty(); }
    TBool hasWhiteSpace() { return m_value->find(" ") != std::string::npos; }

    TBool isConst() const { return TRUE; }
    const TBool isEvaluated() const { return TRUE; }
    RefCSLOmBase doEval(TBool convertEnumItem = FALSE) { return getThis(); }
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase doParamEval(RefCSLOmBase);
    RefCSLOmExpr dupp();

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;    
};

// ********************************************************************************
// CSLOmExprLink class
// ********************************************************************************
/**
 * This class models a reference (link) to both simple and hierachical identifiers.
 * <b>NOTE: </b>an exprLink is to be linked automatically during inference/linking phase
 * to a real indentifier. <br/> <br/>
 */
class CSLOmExprLink : public CSLOmExpr {
  public:

    RefCSLOmExpr dupp();

  // DEP getThis is a virtual function defined in CSLOM_Base
  // DEP getThis is overridden in CSLOMExpr below to cast the CSLOM_Base
  // DEP boost::weak_ptr<CSLOmBase> m_weakRef to a vector<CSLOmExpr<currentClass>
  // DEP A new vector of type  vector<CSLOmExpr<currentClass> is created.
  
  
    RefTVec_RefCSLOmExpr getExprs() { 
      RefTVec_RefCSLOmExpr temp = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr()); // The new'ed vector returns a pointer which is wrapped in a a boost smart pointer
      temp->push_back(getThis()); // DEP- The cast vector is then copied to the new vector
      return temp; 
    }

    static RefCSLOmExprLink cast(RefCSLOmBase object);
    RefTVec_RefCSLOmIdentifier getIDs() const { ASSERT(m_ids.get(), "Expr not evaluated or Expr does not point to anything"); return m_ids; }
    RefString getHidName(TInt index) const { return m_names->at(index); }

    enum EPartSelectDirection {
      PS_DIR_UNDEFINED,
      PS_DIR_ASC,
      PS_DIR_DESC,
      PS_DIR_MAX
    };
    
    EPartSelectDirection getPartSelectDir() { return m_partSelectDir; }
    void setPartSelectDir(EPartSelectDirection dir) { if (hasBitRange()) {m_partSelectDir = dir; updateBr();} }

  private:
    void updateBr();
    RefCSLOmExprLink getThis() const { return boost::static_pointer_cast<CSLOmExprLink>(m_weakRef.lock()); }
    enum EState {
      LINK_UNDEFINED,
      HID_ITEM,
      LINK_MAX1
    };

    static RefTVec_RefCSLOmExprLink exprLinks; // static class variable that holds all expr links to be resolved at linking phase

    EState m_state;
    EPartSelectDirection m_partSelectDir;
    RefTVec_RefString m_names;
    mutable RefTVec_RefCSLOmIdentifier m_ids;
    mutable boost::weak_ptr<CSLOmBase> m_value;
    mutable ECSLOmType m_evalType;

    CSLOmExprLink(TLineNumberType lineNumber, RefString fileName);

  public:
    /**
     * Creates a RefCSLOmExprLink
     *
     * @param lineNumber - type TLineNumberType - the line number it apears on
     * @param name - type RefString - the name of the ExprLink
     *
     * @return RefCSLOmExprLink - object that has been built
     *
     * @see CSLOmExpr
     */
    static RefCSLOmExprLink build(TLineNumberType lineNumber,RefString fileName, const RefString& name);

    void addHidItem(const RefString& name);
    void addScopeItem(const RefString& name);
    RefCSLOmExprLink getFullPathLink();
    /**
     * Returns true if this exprLink is a hierarchical identifier, or false it it is a simple identifier.
     *
     * @return true or false, depending if this exprLink is a hierarchical identifier or a simple identifier
     */
    TBool isHID() const;

    TInt getWidth();

    const RefString getName() const;

    TBool isConst() const;

    /**
     * Returns true if this exprLink is resolved, that is it is linked to an identifier.
     * This can return true only after inference/linking phase.
     *
     * @return true or false, depending if this exprLink is a hierarchical identifier or a simple on
     */
    TBool isResolved() const;

    void setBitRange(RefCSLOmSimpleBitRange bitRange);
    const RefCSLOmSimpleBitRange getBitRange() const;
    const RefCSLOmBase getBitRangeAsBase() const;
    TBool hasBitRange() { return m_children.get() != NULL; }
    /**
     * Returns the identifier to which this exprLink is linked.
     * If this exprLink is not resolved yet, an exception is thrown.
     *
     * @return the identifier to which this exprLink is linked
     * @see isResolved()
     */
    RefCSLOmIdentifier toID() const;

    const RefTVec_RefString getHidNames() const;

    RefCSLOmBase doEval(TBool convertEnumItem = FALSE);
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase doParamEval(RefCSLOmBase);

    RefCSLOmIdentifier getLocalNameID() const;
    
    void setValue(RefCSLOmBase object) const;
    const RefCSLOmBase getValue() const;

    void setEvalType(ECSLOmType object) const;
    const ECSLOmType getEvalType() const;

    TBool isInUnitScope(RefCSLOmUnitDecl unit);

    static RefTVec_RefCSLOmExprLink isPatternIn(RefCSLOmExprLink expr, RefCSLOmScope scope);

    void addID(RefCSLOmIdentifier id) { 
      ASSERT(id.get(), "null id received"); 
      if (!m_ids.get()) {
        m_ids = RefTVec_RefCSLOmIdentifier(new TVec_RefCSLOmIdentifier);
      }
      m_ids->push_back(id); 
    }

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;

    const TBool isEvaluated() const;
};

// ********************************************************************************
// CSLOmExprOp class
// ********************************************************************************
/**
 * This class handles unary, binary and thernary part of expression grammar rule below.
 * The number of (sub)expression elements depends on op type. Therefore, in addition
 * to op type this class also holds: <br/>
 *   - for unary op - holds only one child (sub)expression in base <br/>
 *   - for binary op - holds 2 children (sub)expressions in base <br/>
 *   - for ternary op - holds 3 children (sub)expression in base <br/> <br/>
 * 
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * expression ::=
 *   primary
 *   | unary_operator { attribute_instance } primary
 *   | expression binary_operator { attribute_instance } expression
 *   | conditional_expression
 *   | string
 * constant_expression ::=
 *   constant_primary
 *   | unary_operator { attribute_instance } constant_primary
 *   | constant_expression binary_operator { attribute_instance } constant_expression
 *   | constant_expression ? { attribute_instance } constant_expression : constant_expression
 *   | string
 *
 * primary ::=
 *   number
 *   | hierarchical_identifier [ { [ expression ] } [ range_expression ] ]
 *   | concatenation
 *   | multiple_concatenation
 *   | function_call
 *   | system_function_call
 *   | ( mintypmax_expression )
 * constant_primary ::=
 *   constant_concatenation
 *   | constant_function_call
 *   | ( constant_mintypmax_expression )
 *   | constant_multiple_concatenation
 *   | genvar_identifier
 *   | number
 *   | parameter_identifier
 *   | specparam_identifier
 *
 * conditional_expression ::= expression1 ? { attribute_instance } expression2 : expression3
 * unary_operator ::=
 *   + | - | ! | ~ | & | ~& | | | ~| | ^ | ~^ | ^~
 * binary_operator ::=
 *   + | - | * | / | % | == | != | === | !== | && | || | **
 *   | < | <= | > | >= | & | | | ^ | ^~ | ~^ | >> | << | >>> | <<<
 * </code></pre>
 */
class CSLOmExprOp : public CSLOmExpr {
  public:
    RefTVec_RefCSLOmExpr getExprs();

    static RefCSLOmExprOp cast(RefCSLOmBase object);
    const RefTVec_RefCSLOmBase getExprsAsBase() const { return getChildrenAsBase(TYPE_EXPR); }
  private:
    RefCSLOmNumber runOperation(RefCSLOmNumber, RefCSLOmNumber, RefCSLOmNumber);
    RefCSLOmExprOp getThis() const { return boost::static_pointer_cast<CSLOmExprOp>(m_weakRef.lock()); }
  public:
    /**
     * Holds enum constants for operator types.
     */
    enum EOpType {
      OP_UNARY_ARITHMETIC_PLUS           = 0x10000001, // +op
      OP_UNARY_ARITHMETIC_MINUS          = 0x10000002, // -op
      OP_UNARY_LOGIC_NOT                 = 0x90000004, // !op  - logical not
      OP_UNARY_BITWISE_NOT               = 0x90000008, // ~op  - bitwise not
      OP_UNARY_REDUCTION_AND             = 0x90000010, // &op  - reduction and
      OP_UNARY_REDUCTION_NAND            = 0x90000020, // ~&op - rediction nand
      OP_UNARY_REDUCTION_OR              = 0x90000040, // |op  - reduction or
      OP_UNARY_REDUCTION_NOR             = 0x90000080, // ~|op - reduction nor
      OP_UNARY_REDUCTION_XOR             = 0x90000100, // ^op  - reduction xor
      OP_UNARY_REDUCTION_XNOR            = 0x90000200, // ~^op or ^~op - reduction xnor
      OP_UNARY_LOG_2                     = 0x90000400, // ~^op or ^~op - reduction xnor

      OP_BINARY_ARITHMETIC_PLUS          = 0x20000001, // a + b
      OP_BINARY_ARITHMETIC_MINUS         = 0x20000002, // a - b
      OP_BINARY_ARITHMETIC_MULTIPLY      = 0x20000004, // a * b
      OP_BINARY_ARITHMETIC_DIV           = 0x20000008, // a / b
      OP_BINARY_ARITHMETIC_MOD           = 0x20000010, // a % b
      OP_BINARY_ARITHMETIC_POW           = 0x20000020, // a ** b
      OP_BINARY_ARITHMETIC_SHIFT_LEFT    = 0x20000040, // a <<< b
      OP_BINARY_ARITHMETIC_SHIFT_RIGHT   = 0x20000080, // a >>> b
      OP_BINARY_EQUALITY_EQ              = 0xA0000100, // a == b
      OP_BINARY_EQUALITY_NOT_EQ          = 0xA0000200, // a != b
      OP_BINARY_IDENTITY_EQ_CASE         = 0x20000400, // a === b
      OP_BINARY_IDENTITY_NOT_EQ_CASE     = 0x20000800, // a !== b
      OP_BINARY_LOGIC_AND                = 0xA0001000, // a && b
      OP_BINARY_LOGIC_OR                 = 0xA0002000, // a || b
      OP_BINARY_RELATIONAL_LESS          = 0x20004000, // a < b
      OP_BINARY_RELATIONAL_LESS_EQUAL    = 0x20008000, // a <= b
      OP_BINARY_RELATIONAL_GREATER       = 0x20010000, // a > b
      OP_BINARY_RELATIONAL_GREATER_EQUAL = 0x20020000, // a >= b
      OP_BINARY_BITWISE_AND              = 0xA0040000, // a & b
      OP_BINARY_BITWISE_NAND             = 0x20080000, // a ~& b // !!! ???
      OP_BINARY_BITWISE_OR               = 0xA0100000, // a | b
      OP_BINARY_BITWISE_NOR              = 0x20200000, // a ~| b // !!! ???
      OP_BINARY_BITWISE_XOR              = 0xA0400000, // a ^ b
      OP_BINARY_BITWISE_XNOR             = 0xA0800000, // a ^~ b or a ~^ b
      OP_BINARY_SHIFT_LEFT               = 0x21000000, // a << b
      OP_BINARY_SHIFT_RIGHT              = 0x22000000, // a >> b

      OP_TERNARY_COND                    = 0xC0000001  // a ? b : c
    };

    static const TUInt OP_UNARY_MASK        = 0x10000000;
    static const TUInt OP_BINARY_MASK       = 0x20000000;
    static const TUInt OP_TERNARY_MASK      = 0x40000000;
    static const TUInt OP_MASK              = 0x70000000;
    static const TUInt OP_UNIT_PATH_MASK    = 0x80000000;

  private:
    EOpType m_opType;
    TBool m_isConst;

    CSLOmExprOp(TLineNumberType lineNumber,RefString fileName, EOpType opType, TBool isConst);
    mutable RefCSLOmNumber m_value;
    
  public:
    static RefCSLOmExprOp build(TLineNumberType lineNumber,RefString fileName, EOpType opType, RefCSLOmExpr expr1, RefCSLOmExpr expr2 = RefCSLOmExpr(), RefCSLOmExpr expr3 = RefCSLOmExpr());

    /**
     * Attaches the passed in attrListCollection to this expression.
     *
     * @param attrListCollection the attribute list collection to be attached to this expression
     * @see CDOmAttrList
     * @see CDOmAttrListCollection
     */
    TInt getWidth();
    
    TBool isConst() const;

    EOpType getOpType() const;

    const RefCSLOmExpr getExpr1() const;

    const RefCSLOmExpr getExpr2() const;

    const RefCSLOmExpr getExpr3() const;

    TBool isUnary() const;

    TBool isBinary() const;

    TBool isTernary() const;
    
    void setValue(RefCSLOmNumber) const;
    
    const RefCSLOmNumber getValue() const;

    RefCSLOmNumber evalChildExpr(TInt index);
    RefCSLOmBase doEval(TBool convertEnumItem = FALSE);
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase doParamEval(RefCSLOmBase);

    RefCSLOmExpr dupp();

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;

    const TBool isEvaluated() const;
};

// ********************************************************************************
// CSLOmExprConcat class
// ********************************************************************************
/**
 * This class holds a concatenation of expressions. It is similar to a vector of expressions.
 * An object of this type is always guaranteed to hold at least one expression. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * concatenation ::= { expression { , expression } }
 * constant_concatenation ::= { constant_expression { , constant_expression } }
 * </code></pre>
 */
class CSLOmExprConcat : public CSLOmExpr {
  public:
    RefTVec_RefCSLOmExpr getExprs();
    static RefCSLOmExprConcat cast(RefCSLOmBase object);
    const RefTVec_RefCSLOmBase getExprsAsBase() const { return getChildrenAsBase(TYPE_EXPR); }
  private:
    RefCSLOmExprConcat getThis() const { return boost::static_pointer_cast<CSLOmExprConcat>(m_weakRef.lock()); }
    TBool m_isConst; // used to inidicate if this expr list contains only const expressions

    CSLOmExprConcat(TLineNumberType lineNumber, RefString fileName);

  public:
    static RefCSLOmExprConcat build(TLineNumberType lineNumber, RefString fileName, RefCSLOmExpr expr);
  
    TBool isConst() const;

    void addExpr(RefCSLOmExpr expr);

    RefCSLOmBase doEval(TBool convertEnumItem = FALSE);
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase doParamEval(RefCSLOmBase);
    
    TInt getWidth();

    RefCSLOmExpr dupp();

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
    
    const TBool isEvaluated() const;
};

// ********************************************************************************
// CSLOmExprMultiConcat class
// ********************************************************************************
/**
 * This class models a multiple concatenation according to the grammar rules.
 * <b>NOTE: </b>according to the grammar rules below, constantness of an object of this class
 * is given by the exprConcat constantness. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * multiple_concatenation ::= { constant_expression concatenation }
 * constant_multiple_concatenation ::= { constant_expression constant_concatenation }
 * </code></pre>
 */
class CSLOmExprMultiConcat : public CSLOmExpr {
  public:
    RefTVec_RefCSLOmExpr getExprs();
    static RefCSLOmExprMultiConcat cast(RefCSLOmBase object);
    const RefTVec_RefCSLOmBase getExprsAsBase() const { return getChildrenAsBase(TYPE_EXPR); }
  private:
    RefCSLOmExprMultiConcat getThis() const { return boost::static_pointer_cast<CSLOmExprMultiConcat>(m_weakRef.lock()); }
    CSLOmExprMultiConcat(TLineNumberType lineNumber, RefString fileName);

  public:
    /**
     * This is the Expresion multiple concatenation build method.
     *
     * @param lineNumber - type TLineNumberType - the line number where the csl_unit declaration apears
     * @param expr - type RefCSLOmExpr - 
     * @param exprConcat - type RefCSLOmExprConcat - 
     *
     * @return RefCSLOmExprMultiConcat - the object that has been built
     *
     * @see CSLOmExpr
     * @see CSLOmExprConcat
     */

    static RefCSLOmExprMultiConcat build(TLineNumberType lineNumber, RefString fileName, RefCSLOmExpr expr, RefCSLOmExprConcat exprConcat);
  
    TBool isConst() const;

    RefCSLOmExpr getExpr() const;
    
    RefCSLOmExprConcat getExprConcat() const;

    RefCSLOmBase doEval(TBool convertEnumItem = FALSE);
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase doParamEval(RefCSLOmBase);

    TInt getWidth();

    RefCSLOmExpr dupp();

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;

    const TBool isEvaluated() const;
};

// ********************************************************************************
// CSLOmExprHybridOrFuncCall class
// ********************************************************************************
/** This class handles all the possible function call-identifier(simple or hierarchical) combinations 
 * that a csl command(set function) can take as param.
 * Mainly,there are two types of such combinations: function calls and expression hybrids, thus the name of the class. 
 * Function call examples:
 *   (*0) x.set_lower_index(get_lower_index());
 *   (*1) x.set_bitrange(y.z.get_bitrange());
 *   (*2) x.set_upper_index(y.get_bitrange().get_upper_index());
 *   (*3) x.set_dim_bitrange(1, u.get_interface().z.get_bitrange());
 *   (*4) x.set_dim_lower_index( y.get_dim_lower_index(get_dim_upper_index(1)), z.get_upper_index());
 *   All these are csl commands (csl command = set function). Csl commands can get complicated, like the ones above. 
 *   What makes csl commands complicated is the parameters they take,
 *   in particular, the function call parameters.
 *   (*0) The param of the set function is the simplest case of function call: a function signature, 
 *        meaning a function name followed by a list or parameters(in this case, void).
 *        No scope is specified for the get_lower_index function, so,implicitly, it is applied to x.
 *   (*1) y.z.get_bitrange() is a function call with an explicit scope y.z (hid)
 *   (*2) y.get_bitrange().get_upper_index() is also a function call with an explicit scope: 
 *        get_upper_index is the func name, no params, and the scope is y.get_bitrange().
 *        get_bitrange() returns an object; let's say that br is the return object 
 *        => y.get_bitrange() is equivalent to y.br which is similar to the previous example
 *   (*3) u.get_interface().z.get_bitrange() : this case is similar to the one before but for one difference: 
 *        the ids(u and z) and function signatures (get_interface(), get_bitrange())
 *        are interlaced. If ifc is the object returned by get_interface() and 
 *        br is the object returned by get_bitrange(), then our function call translates by u.ifc.z.br
 *   (*4) y.get_dim_lower_index(get_dim_upper_index(1)) ia a function call with a simple scope y. 
 *        This time, it's the param list that's complicated. 
 *        get_dim_lower_index has another function call as a param: get_dim_upper_index(1). 
 *        Let's turn this into something more familiar.
 *        get_dim_upper_index has no scope, so it applies to y; 
 *        assuming that the upper index of the first dim of y is 3, the function call becomes: 
 *        y.get_dim_lower_index(3); if the lower index of y's third dimmension is 2, for example, 
 *        then the csl command becomes x.set_dim_lower_index(2, z.get_upper_index())
 *        which looks a lot simpler and is more likely to be used by csl programmers than the original syntax. 
 *        However, example 4 is legal and needs to be considered as a possible option.
 * Expression hybrid example:
 *   (*5) x.add_port(input, 32, y.z.get_interface().p);
 *        y.z.get_interface().p is an expr hybrid; it's not a function call because it does not end with one
 *        (the rightmost element is an id ) and it's not a hid because 
 *        it contains a function call get_interface()
 *        This examlpe, however, can be reduced to a hid : get_interface returns an interface object 
 *        (ifc, for example) therefore, the whole construct becomes: y.z.ifc.p
 */
class CSLOmExprHybridOrFuncCall : public CSLOmExpr {
  public:
    RefTVec_RefCSLOmExpr getExprs()  { return RefTVec_RefCSLOmExpr(); }
    static RefCSLOmExprHybridOrFuncCall cast(RefCSLOmBase object);
  private:
    CSLOmExprHybridOrFuncCall(TLineNumberType lineNumber, RefString fileName);
    RefCSLOmExprHybridOrFuncCall getThis() const { return boost::static_pointer_cast<CSLOmExprHybridOrFuncCall>(m_weakRef.lock()); }
  public:
    /** This is the factory nethod for all CSLOmExprHybridOrFuncCall objects. 
     * At first sight, given the examples explained in the general description of the class, 
     * the build function's second and third params should be vectors.
     * Yet, keep in mind that all the syntactic constucts detailed in the example part are complicated and rare. 
     * The most usual csl set-get pair goes like this:
     *   x.set_bitrange(y.get_bitrange());   // y.get_bitrange() is a simple func call, therefore 
     *                                       // the corresponding CSLOmExprHybridOrFuncCall object 
     *                                       // is built with one function signature get_bitrange(), 
     *                                       // and one exprLink y(a link to an y object(a signal or a bitrange) 
     *                                       // declared in the same scope)
     * So, if I were to go with vectors in the build function, most of the time they would hold only one element.
     * Sometimes the scope can be omitted (see example (*0)) 
     * that's why the third param of the build function is predefined.
     * However, the complicated cases given as examples are legal, although rare. 
     * Thus, there are cases when an CSLOmExprHybridOrFuncCall may require more than just one functionSignature
     * and one exprLink. That's why the addObjectName and addFunctionSignature methods were implemented. 
     * For better understanding of this mechanism see CSLOM_Driver.cpp,
     * testExprHybridOrFunctionCall() function where example (*4) is transformed into a 
     * CSLOmExprHybridOrFuncCall object step by step.
     * The build function has no parent param because, just like the CSLOmExprFuncSignature, 
     * expr hybrids and function calls cannot stand alone.
     * They have to be intrgrated in csl commands(set functions) like in all the 5 examples above. 
     * The build function of the CSLOmSetCommand class will set their parent implicitly.
     */ 
    static RefCSLOmExprHybridOrFuncCall build( TLineNumberType lineNumber, RefString fileName, RefCSLOmExprFuncSignature functionSignature);
    static RefCSLOmExprHybridOrFuncCall build( TLineNumberType lineNumber, RefString fileName, RefCSLOmExprLink objectName);
    void addObjectName(RefCSLOmExprLink objectName);
    void addFunctionSignature( RefCSLOmExprFuncSignature functionSignature);
    const RefTVec_RefCSLOmExprLink getObjectNames() const;
    const RefTVec_RefCSLOmBase getObjectNamesAsBase() const;
    const RefTVec_RefCSLOmExprFuncSignature getFunctionSignatures() const;
    const RefTVec_RefCSLOmBase getFunctionSignaturesAsBase() const;
    TBool isConst() const;
    RefCSLOmBase doEval(TBool convertEnumItem = FALSE);
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase doParamEval(RefCSLOmBase);
    TInt doEnumEval(ECSLOmEnumType);
    RefCSLOmExpr dupp();

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
    const TBool isEvaluated() const;
};

// ********************************************************************************
// CSLOmExprFuncSignature class
// ********************************************************************************
/** This class holds a get function signature(name and list of parameters).
 * Example of csl input handled by this class:
 * get_lower_index()  (*1)
 * get_dim_lower_index(1)  (*2)
 * get_dim_lower_index(get_dim_upper_index(1))  (*3)
 * get_dim_upper_index(z.get_dim_upper_index())  (*4)
 */
class CSLOmExprFuncSignature : public CSLOmExpr {
  public:
    RefTVec_RefCSLOmExpr getExprs() { return RefTVec_RefCSLOmExpr(); }
    static RefCSLOmExprFuncSignature cast(RefCSLOmBase object);
  private:
    ECSLOmFuncName m_funcName;  //private member that holds the function name(which is to be found in ECSLOmFuncName enum).
    ECSLOmPortDirection m_portDirection; //only for get_interface
    CSLOmExprFuncSignature(TLineNumberType lineNumber, RefString fileName, ECSLOmFuncName funcName);
    CSLOmExprFuncSignature(TLineNumberType lineNumber, RefString fileName, ECSLOmFuncName funcName, ECSLOmPortDirection portDirection);
    RefCSLOmExprFuncSignature getThis() const { return boost::static_pointer_cast<CSLOmExprFuncSignature>(m_weakRef.lock()); }
    RefCSLOmBase m_scope;
  public:
    /** The following build function is the generic factory method for get function signatures.
     * It takes three arguments: lineNumber, the name of the get function (funcName) 
     * and the list of params(funcParams).
     * The list of params is, in fact, a list of expressions meaning that a get function 
     * can take any type of expression as an argument
     * (CSLOmExpr and all the classes derived from it).
     * For now, in csl, get functions can take maximum one param, but, 
     * considering that the language  is constantly develloping, 
     * the third param of the build function is a list.
     * Considering the 4 examples in the general description of the class, 
     * here follows the list of build arguments for each case:
     * (*1) funcName   GET_LOWER_INDEX              funcParams   none
     * (*2) funcName   GET_DIM_LOWER_INDEX          funcParams   a list containing one RefCSLOmExpr
     * (*3) funcName   GET_DIM_LOWER_INDEX          funcParams   a list containing one RefCSLOmExprFuncSignature  
     *                                                       (CSLOmExprFuncSignature is derived from CSLOmExpr)
     * (*4) funcName   GET_DIM_UPPER_INDEX          funcParams   a list containing one RefCSLOmExprHybridOrFuncCall 
     *                                                   (CSLOmExprHybridOrFuncCall is derived from CSLOmExpr)
     *                                                   see comment for CSLOmExprHybridOrFuncCall for more details
     * This build function has no explicit parent argument, because a get function signature cannot stand alone. 
     * It is used to build an expr_hybrid ( x.get_interface().z)
     * or another function signature ( get_dim_lower_index(get_dim_upper_index())))
     * or a function_call (x.get_bitrange().get_lower_index())
     * or directly as a parameter for a set function (x.set_lower_index(get_upper_index())).
     * This way, the build functions for CSLOmExprHybridOrFuncCall, CSLOmExprFuncSignature, 
     * and CSLOmSetCommand(handles the set functions) 
     * will implicitly set the CSLOmFunctionSiganture object's parent.
     * The line of code that does this (located in all the build functions stated before) 
     * looks something like this:
     * funcSignature->setParent(reference to current object);
     */
    static RefCSLOmExprFuncSignature build( TLineNumberType lineNumber, RefString fileName, ECSLOmFuncName funcName, RefCSLOmListExpr funcParams = RefCSLOmListExpr());
    /** So far, the only get function in csl which does not take an expr as a param 
     * (instead it takes a keyword: INPUT, OUTPUT, INOUT) is get_interface
     */ 
    static RefCSLOmExprFuncSignature build( TLineNumberType lineNumber, RefString fileName, ECSLOmFuncName funcName, ECSLOmPortDirection portDirection); //only for get_interface
    const ECSLOmFuncName getFuncName() const;
    const RefCSLOmListExpr getFunctionParams() const;
    const ECSLOmPortDirection getPortDirection() const;
    TBool isConst() const;
    RefCSLOmBase doEval(TBool convertEnumItem = FALSE);
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase doParamEval(RefCSLOmBase);
    int doEnumEval(ECSLOmEnumType);
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
    const TBool isEvaluated() const;
    RefCSLOmBase getScope() const;
    void setScope(RefCSLOmBase);
    ECSLOmEnumType getEnumType() const;
    RefCSLOmExpr dupp();
};

// ********************************************************************************
// CSLOmNumber class
// ********************************************************************************
/**
 * CSLOmNumber represents a const Number expresion. ENumBaseType is an enum that 
 * tells us the base of the current object:
 *   - NUM_BASE_BIN - bynary
 *   - NUM_BASE_OCT - base 8
 *   - NUM_BASE_DEC - decimal
 *   - NUM_BASE_HEX - hexa
 * The number is a RefCVeriNum.
 */
class CSLOmNumber : public CSLOmExpr {
  public:
    RefTVec_RefCSLOmExpr getExprs() { RefTVec_RefCSLOmExpr temp = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr()); temp->push_back(getThis()); return temp; }
    static RefCSLOmNumber cast(RefCSLOmBase object);
  private:
    RefCSLOmNumber getThis() const { return boost::static_pointer_cast<CSLOmNumber>(m_weakRef.lock()); }

  public:
    enum ENumBaseType {
      NUM_BASE_UNDEFINED,
      NUM_BASE_BIN, 
      NUM_BASE_OCT, 
      NUM_BASE_DEC, 
      NUM_BASE_HEX,
      NUM_BASE_MAX
    };

    enum ENumType {
      NUM_UNDEFINED,
      NUM_INT32, 
      NUM_BIG, 
      NUM_FIXED, 
      NUM_FIXED_BIG,
      NUM_FLOAT,
      NUM_FLOAT_BIG,
      NUM_VERINUM,
      NUM_MAX
    };

  protected:
    RefString m_tokenString;
    //    RefCVeriNum m_veriNum;

    ENumBaseType m_numBaseType;
    ENumType m_numType;
    TBool m_overflow;
    TBool m_hasXZ;
    TBool m_isConst;
    TBool m_isSigned;
    TBool m_isEvaluated;
    TBool m_isTrunkated;
    TBool m_isRounded;
    TInt m_width;
    TInt m_noOfBitsTrunk;
    TInt m_noOfBitsRound;

    CSLOmNumber(TLineNumberType, RefString, ENumBaseType, const RefString&, const RefCVeriNum&);
    CSLOmNumber(TLineNumberType lineNumber, RefString fileName, ENumType numType, ENumBaseType numBaseType, TBool hasXZ = FALSE);

  public:
    /**
     * The build method for CSLOmNumber
     *
     * @param lineNumber - type TLineNumberType - the lineNumber where the number appears
     * @param numBaseType - type ENumBaseType - the base of the number bin, oct, dec, hex
     * @param tokenString - type RefString - the token string of the number; example "'b10111"
     * @param lightString - type RefString - the string that retains tha number; for the example above "10111"
     * @param isSigned - type TBool - retain if the number is negative(implicit value false: pozitive)
     * @param size - type TUInt - the size of the number as number of digits; for example above the size is 5, for decimal number "5697" the size is 4
     *
     * @return RefCSLOmNumber - the number object that has been built
     *
     * @see ENumBaseType
     */
    static RefCSLOmNumber build(TLineNumberType lineNumber, RefString fileName, ENumBaseType numBaseType, const RefString& tokenString, const RefString& lightString, TInt width = 0, TBool hasXZ = FALSE);
  
    const ENumType getNumType() const;
    const TBool getOverflow() const;
    const TBool hasXZ() const;
    TBool isConst() const;
    const TBool isSigned() const;
    const TBool isEvaluated() const;
    const TBool isTrunkated() const;
    const TBool isRounded() const;
    const TInt getWidth() const;
    const TInt getNoOfBitsTrunk() const;
    const TInt getNoOfBitsRound() const;


    void setNumType(ENumType);
    void setOverflow(TBool);
    void setHasXZ(TBool);
    void setIsConst(TBool);
    void setIsSigned(TBool);
    void setIsEvaluated(TBool);
    void setIsTrunkated(TBool);
    void setIsRounded(TBool);
    void setWidth(TInt);
    void setNoOfBitsTrunk(TInt);
    void setNoOfBitsRound(TInt);


    TInt getSize() const;
    ENumBaseType getNumBaseType() const;
    const RefString getTokenString() const;
//     RefCVeriNum getVeriNum() const;
//     void setVeriNum(RefCVeriNum);

 
    void addCSLOmNumber(RefCSLOmNumber num);
    virtual void changeSign() = 0;

    virtual const TInt getValue() const = 0;
    virtual void setValue(TInt value) = 0;

    virtual TBool equals(TInt) = 0;
    virtual TInt calcWidth() = 0;
    virtual RefCSLOmNumber maxValue() = 0;
    virtual RefCSLOmNumber plus() = 0;
    virtual RefCSLOmNumber minus() = 0;
    virtual RefCSLOmNumber logicNot() = 0;
    virtual RefCSLOmNumber bitwiseNot() = 0;
    virtual RefCSLOmNumber reductionAnd() = 0;
    virtual RefCSLOmNumber reductionNand() = 0;
    virtual RefCSLOmNumber reductionOr() = 0;
    virtual RefCSLOmNumber reductionNor() = 0;
    virtual RefCSLOmNumber reductionXor() = 0;
    virtual RefCSLOmNumber reductionXnor() = 0;
    virtual RefCSLOmNumber add(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber substract(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber multiply(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber divide(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber modulo(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber power(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber shiftLeft(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber shiftRight(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber equality(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber notEquality(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber equalityEqualCase(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber equalityNotEqualCase(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber logicAnd(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber logicOr(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber relationalLess(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber relationalLessEqual(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber relationalGreater(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber relationalGreaterEqual(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber bitwiseAnd(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber bitwiseNand(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber bitwiseOr(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber bitwiseNor(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber bitwiseXor(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber bitwiseXnor(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber binaryShiftLeft(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber binaryShiftRight(RefCSLOmNumber) = 0;
    virtual RefCSLOmNumber ternaryCondition(RefCSLOmNumber, RefCSLOmNumber) = 0;

    RefCSLOmBase doEval(TBool convertEnumItem = FALSE);
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase doParamEval(RefCSLOmBase);
    virtual RefCSLOmExpr dupp() = 0;
};

// ********************************************************************************
// CSLOmNum32 class
// ********************************************************************************
class CSLOmNum32 : public CSLOmNumber {
  public:
    static RefCSLOmNum32 cast(RefCSLOmBase object);
  private:
    RefCSLOmNum32 getThis() const { return boost::static_pointer_cast<CSLOmNum32>(m_weakRef.lock()); }
    TInt m_value;
    static TInt converter(CSLOmNumber::ENumBaseType base, RefString number);
    static const TInt maxWidth;

  protected:
    CSLOmNum32(TLineNumberType lineNumber, RefString fileName, CSLOmNumber::ENumBaseType base, const TInt value);
  public:
    static RefCSLOmNum32 build(TLineNumberType lineNumber, RefString fileName, TInt value);
    static RefCSLOmNum32 build(TLineNumberType lineNumber, RefString fileName, CSLOmNumber::ENumBaseType base, RefString num, TInt width = 0);
    const TInt getValue() const;
    void setValue(TInt value);

    TInt getWidth(){return m_width;}

    void changeSign();
    TBool equals(TInt);
    TInt calcWidth();
    RefCSLOmNumber maxValue();
    RefCSLOmNumber plus();
    RefCSLOmNumber minus();
    RefCSLOmNumber logicNot();
    RefCSLOmNumber bitwiseNot();
    RefCSLOmNumber reductionAnd();
    RefCSLOmNumber reductionNand();
    RefCSLOmNumber reductionOr();
    RefCSLOmNumber reductionNor();
    RefCSLOmNumber reductionXor();
    RefCSLOmNumber reductionXnor(); 
    RefCSLOmNumber add(RefCSLOmNumber);
    RefCSLOmNumber substract(RefCSLOmNumber);
    RefCSLOmNumber multiply(RefCSLOmNumber);
    RefCSLOmNumber divide(RefCSLOmNumber);
    RefCSLOmNumber modulo(RefCSLOmNumber);
    RefCSLOmNumber power(RefCSLOmNumber);
    RefCSLOmNumber shiftLeft(RefCSLOmNumber);
    RefCSLOmNumber shiftRight(RefCSLOmNumber);
    RefCSLOmNumber equality(RefCSLOmNumber);
    RefCSLOmNumber notEquality(RefCSLOmNumber);
    RefCSLOmNumber equalityEqualCase(RefCSLOmNumber);
    RefCSLOmNumber equalityNotEqualCase(RefCSLOmNumber);
    RefCSLOmNumber logicAnd(RefCSLOmNumber);
    RefCSLOmNumber logicOr(RefCSLOmNumber);
    RefCSLOmNumber relationalLess(RefCSLOmNumber);
    RefCSLOmNumber relationalLessEqual(RefCSLOmNumber);
    RefCSLOmNumber relationalGreater(RefCSLOmNumber);
    RefCSLOmNumber relationalGreaterEqual(RefCSLOmNumber);
    RefCSLOmNumber bitwiseAnd(RefCSLOmNumber);
    RefCSLOmNumber bitwiseNand(RefCSLOmNumber);
    RefCSLOmNumber bitwiseOr(RefCSLOmNumber);
    RefCSLOmNumber bitwiseNor(RefCSLOmNumber);
    RefCSLOmNumber bitwiseXor(RefCSLOmNumber);
    RefCSLOmNumber bitwiseXnor(RefCSLOmNumber);
    RefCSLOmNumber binaryShiftLeft(RefCSLOmNumber);
    RefCSLOmNumber binaryShiftRight(RefCSLOmNumber);
    RefCSLOmNumber ternaryCondition(RefCSLOmNumber, RefCSLOmNumber);

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const ;
    RefCSLOmExpr dupp();
};

// ********************************************************************************
// CSLOmListExpr class
// ********************************************************************************
/**
 * This class holds a list of expressions which is guaranteed to contain at least one element.
 */ 
class CSLOmListExpr : public CSLOmBase {
  public:
    RefTVec_RefCSLOmExpr getExprs()  { return getItems(); }
    static RefCSLOmListExpr cast(RefCSLOmBase object);
  private:
    CSLOmListExpr(TLineNumberType lineNumber, RefString fileName);
    RefCSLOmListExpr getThis() const { return boost::static_pointer_cast<CSLOmListExpr>(m_weakRef.lock()); }
  public:
    static RefCSLOmListExpr build (TLineNumberType lineNumber, RefString fileName, RefCSLOmExpr exprItem);
    void addItem(RefCSLOmExpr exprItem);
    const RefTVec_RefCSLOmExpr getItems() const;
    const RefTVec_RefCSLOmBase getItemsAsBase() const;
    const TUInt getNumberOfChildren() const;
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
    RefCSLOmListExpr dupp();
};
// ********************************************************************************
// CSLOmVeriNum class
// ********************************************************************************
/**
 * This class stores a string representing a Verilog-type number 
 * author - eugennc
 */ 
class CSLOmVeriNum : public CSLOmNumber {
  public:
    static RefCSLOmVeriNum cast(RefCSLOmBase object);

  private:
    RefCSLOmVeriNum getThis() const { return boost::static_pointer_cast< CSLOmVeriNum >( m_weakRef.lock() ); }
    RefString m_numString;
    
  protected:
    CSLOmVeriNum( TLineNumberType lineNumber, RefString fileName, RefString numString, TInt width, CSLOmNumber::ENumBaseType baseType, TBool isSigned, TBool hasXZ );

  public:
    // Default values are set here to describe a very basic scenario, in which, regressively, we know less and less about the number: hasXZ ( default no ), isSigned ( no ), base ( Binary ), width ( ZERO )
    static RefCSLOmVeriNum build( TLineNumberType lineNumber, RefString fileName, RefString numberString, TInt width = ZERO, CSLOmNumber::ENumBaseType baseType = NUM_BASE_BIN, TBool isSigned = 0, TBool hasXZ = 0 );
    /* PLEASE READ HERE BEFORE USING CLASS
     * The number representation is manipulated ( get, set ) using [get,set]NumString()
     * as opposite to [get,set]Value() due to the fact that *Value() are defined in 
     * CSLOmNumber with a binary-represented ( int -like ) signature, while here
     * simple string-represented values are being used
     */
    RefString getNumString();
    void setNumString( RefString );

    RefCSLOmExpr dupp();
    
    /* functions not required in VeriNum basic implementation -
     * who are, however, pure virtual in base class CSLOmNumber
     * --------------------------------------------------------
     */
    const TInt getValue() const { return 0; }
    void setValue(TInt value) { }
    void changeSign();                                     
    TBool equals(TInt value);                         
    TInt calcWidth();                                     

    RefCSLOmNumber maxValue();
    RefCSLOmNumber plus();                                     
    RefCSLOmNumber minus();
    RefCSLOmNumber logicNot();
    RefCSLOmNumber bitwiseNot();
    RefCSLOmNumber reductionAnd();
    RefCSLOmNumber reductionNand();
    RefCSLOmNumber reductionOr();
    RefCSLOmNumber reductionNor();
    RefCSLOmNumber reductionXor();
    RefCSLOmNumber reductionXnor();
    RefCSLOmNumber add( RefCSLOmNumber );
    RefCSLOmNumber substract( RefCSLOmNumber );
    RefCSLOmNumber multiply( RefCSLOmNumber );
    RefCSLOmNumber divide( RefCSLOmNumber );
    RefCSLOmNumber modulo( RefCSLOmNumber );
    RefCSLOmNumber power( RefCSLOmNumber );
    RefCSLOmNumber shiftLeft( RefCSLOmNumber );
    RefCSLOmNumber shiftRight( RefCSLOmNumber );
    RefCSLOmNumber equality( RefCSLOmNumber );
    RefCSLOmNumber notEquality( RefCSLOmNumber );
    RefCSLOmNumber equalityEqualCase( RefCSLOmNumber );
    RefCSLOmNumber equalityNotEqualCase( RefCSLOmNumber );
    RefCSLOmNumber logicAnd( RefCSLOmNumber );
    RefCSLOmNumber logicOr( RefCSLOmNumber );
    RefCSLOmNumber relationalLess( RefCSLOmNumber );
    RefCSLOmNumber relationalLessEqual( RefCSLOmNumber );
    RefCSLOmNumber relationalGreater( RefCSLOmNumber );
    RefCSLOmNumber relationalGreaterEqual( RefCSLOmNumber );
    RefCSLOmNumber bitwiseAnd( RefCSLOmNumber );
    RefCSLOmNumber bitwiseNand( RefCSLOmNumber );
    RefCSLOmNumber bitwiseOr( RefCSLOmNumber );
    RefCSLOmNumber bitwiseNor( RefCSLOmNumber );
    RefCSLOmNumber bitwiseXor( RefCSLOmNumber );
    RefCSLOmNumber bitwiseXnor( RefCSLOmNumber );
    RefCSLOmNumber binaryShiftLeft( RefCSLOmNumber );
    RefCSLOmNumber binaryShiftRight( RefCSLOmNumber );
    RefCSLOmNumber ternaryCondition( RefCSLOmNumber , RefCSLOmNumber );
    //---------------------------------------------------------

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;

};

} // end namespace NSCSLOm

#endif // INC_GUARD_CSLOm_EXPRs_h
