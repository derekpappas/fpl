// -*- C++ -*-
//*************************************************************************
// DESCRIPTION: Verilator: Ast node structure
//
// Code available from: http://www.veripool.org/verilator
//
// AUTHORS: Wilson Snyder with Paul Wasson, Duane Gabli
//
//*************************************************************************
//
// Copyright 2003-2010 by Wilson Snyder.  This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.
//
// Verilator is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
//*************************************************************************

#ifndef _V3AST_H_
#define _V3AST_H_ 1
#include "config_build.h"
#include "verilatedos.h"
#include "V3Error.h"
#include "V3Number.h"
#include <vector>

#include "V3Ast__gen_classes.h"	// From ./astgen
// Things like:
//   class V3AstNode;

// Hint class so we can choose constructors
class AstLogicPacked {};

//######################################################################

class AstType {
public:
#include "V3Ast__gen_types.h"	// From ./astgen
    // Above include has:
    //   enum en {...};
    //   const char* ascii() const {...};
    enum en m_e;
    inline AstType () {}
    inline AstType (en _e) : m_e(_e) {}
    explicit inline AstType (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
  };
  inline bool operator== (AstType lhs, AstType rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstType lhs, AstType::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstType::en lhs, AstType rhs) { return (lhs == rhs.m_e); }
  inline ostream& operator<<(ostream& os, AstType rhs) { return os<<rhs.ascii(); }

//######################################################################

class AstPragmaType {
public:
    enum en {
	COVERAGE_BLOCK_OFF,
	INLINE_MODULE,
	NO_INLINE_MODULE,
	NO_INLINE_TASK,
	PUBLIC_MODULE,
	PUBLIC_TASK
    };
    enum en m_e;
    inline AstPragmaType () {}
    inline AstPragmaType (en _e) : m_e(_e) {}
    explicit inline AstPragmaType (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
  };
  inline bool operator== (AstPragmaType lhs, AstPragmaType rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstPragmaType lhs, AstPragmaType::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstPragmaType::en lhs, AstPragmaType rhs) { return (lhs == rhs.m_e); }

//######################################################################

class AstCFuncType {
public:
    enum en {
	FT_NORMAL,
	TRACE_INIT,
	TRACE_INIT_SUB,
	TRACE_FULL,
	TRACE_FULL_SUB,
	TRACE_CHANGE,
	TRACE_CHANGE_SUB
    };
    enum en m_e;
    inline AstCFuncType () {}
    inline AstCFuncType (en _e) : m_e(_e) {}
    explicit inline AstCFuncType (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
    // METHODS
    bool isTrace() const { return (m_e==TRACE_INIT || m_e==TRACE_INIT_SUB
				   || m_e==TRACE_FULL || m_e==TRACE_FULL_SUB
				   || m_e==TRACE_CHANGE || m_e==TRACE_CHANGE_SUB); }
  };
  inline bool operator== (AstCFuncType lhs, AstCFuncType rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstCFuncType lhs, AstCFuncType::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstCFuncType::en lhs, AstCFuncType rhs) { return (lhs == rhs.m_e); }

//######################################################################

class AstEdgeType {
public:
// REMEMBER to edit the strings below too
    enum en {
	// These must be in general -> most specific order, as we sort by it in V3Const::visit AstSenTre
	ET_ILLEGAL,
	// Involving a variable
	ET_ANYEDGE,	// Default for sensitivities; rip them out
	ET_BOTHEDGE,	// POSEDGE | NEGEDGE
	ET_POSEDGE,
	ET_NEGEDGE,
	ET_HIGHEDGE,	// Is high now (latches)
	ET_LOWEDGE,	// Is low now (latches)
	// Not involving anything
	ET_COMBO,	// Sensitive to all combo inputs to this block
	ET_INITIAL,	// User initial statements
	ET_SETTLE,	// Like combo but for initial wire resolutions after initial statement
	ET_NEVER	// Never occurs (optimized away)
    };
    enum en m_e;
    bool clockedStmt() const {
	static const bool clocked[] = {
	    false, false, true, true, true, true, true,
	    false, false, false
	};
	return clocked[m_e];
    }
    AstEdgeType invert() const {
	switch (m_e) {
	case ET_ANYEDGE:	return ET_ANYEDGE;
	case ET_BOTHEDGE:	return ET_BOTHEDGE;
	case ET_POSEDGE:	return ET_NEGEDGE;
	case ET_NEGEDGE:	return ET_POSEDGE;
	case ET_HIGHEDGE:	return ET_LOWEDGE;
	case ET_LOWEDGE:	return ET_HIGHEDGE;
	default: UASSERT_STATIC(0,"Inverting bad edgeType()");
	};
	return AstEdgeType::ET_ILLEGAL;
    }
    const char* ascii() const {
	static const char* names[] = {
	    "%E-edge", "ANY", "BOTH", "POS", "NEG", "HIGH", "LOW",
	    "COMBO","INITIAL","SETTLE","NEVER"
	};
	return names[m_e];
    };
    const char* verilogKwd() const {
	static const char* names[] = {
	    "%E-edge", "[any]", "edge", "posedge", "negedge", "[high]","[low]",
	    "*","[initial]","[settle]","[never]"
	};
	return names[m_e];
    };
    inline AstEdgeType () {}
    inline AstEdgeType (en _e) : m_e(_e) {}
    explicit inline AstEdgeType (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
  };
  inline bool operator== (AstEdgeType lhs, AstEdgeType rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstEdgeType lhs, AstEdgeType::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstEdgeType::en lhs, AstEdgeType rhs) { return (lhs == rhs.m_e); }

//######################################################################

class AstAttrType {
public:
    enum en {
	EXPR_BITS,			// V3Const converts to constant
	//
	VAR_BASE,			// V3LinkResolve creates for AstPreSel, V3LinkParam removes
	VAR_CLOCK,			// V3LinkParse moves to AstVar::attrScClocked
	VAR_CLOCK_ENABLE,		// V3LinkParse moves to AstVar::attrClockEn
	VAR_PUBLIC,			// V3LinkParse moves to AstVar::sigPublic
	VAR_PUBLIC_FLAT,		// V3LinkParse moves to AstVar::sigPublic
	VAR_ISOLATE_ASSIGNMENTS,	// V3LinkParse moves to AstVar::attrIsolateAssign
	VAR_SFORMAT			// V3LinkParse moves to AstVar::attrSFormat
    };
    enum en m_e;
    const char* ascii() const {
	static const char* names[] = {
	    "EXPR_BITS", "VAR_BASE",
	    "VAR_CLOCK", "VAR_CLOCK_ENABLE", "VAR_PUBLIC", "VAR_PUBLIC_FLAT",
	    "VAR_ISOLATE_ASSIGNMENTS", "VAR_SFORMAT"
	};
	return names[m_e];
    };
    inline AstAttrType () {}
    inline AstAttrType (en _e) : m_e(_e) {}
    explicit inline AstAttrType (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
  };
  inline bool operator== (AstAttrType lhs, AstAttrType rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstAttrType lhs, AstAttrType::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstAttrType::en lhs, AstAttrType rhs) { return (lhs == rhs.m_e); }

//######################################################################

class AstBasicDTypeKwd {
public:
    enum en {
	BIT, BYTE, CHANDLE, INT, INTEGER, LOGIC, LONGINT,
	REAL, REALTIME,	SHORTINT, SHORTREAL, TIME,
	// Closer to a class type, but limited usage
	STRING,
	// Internal types for mid-steps
	SCOPEPTR, CHARPTR,
	// Internal types, eliminated after parsing
	LOGIC_IMPLICIT
    };
    enum en m_e;
    const char* ascii() const {
	static const char* names[] = {
	    "bit", "byte", "chandle", "int", "integer", "logic", "longint",
	    "real", "realtime", "shortint", "shortreal", "time",
	    "string",
	    "VerilatedScope*", "char*",
	    "LOGIC_IMPLICIT"
	};
	return names[m_e];
    };
    const char* dpiType() const {
	static const char* names[] = {
	    "unsigned char", "char", "void*", "int", "int", "svLogic", "long long",
	    "double", "double", "short int", "float", "long long",
	    "const char*",
	    "dpiScope", "const char*",
	    ""
	};
	return names[m_e];
    };
    inline AstBasicDTypeKwd () {}
    inline AstBasicDTypeKwd (en _e) : m_e(_e) {}
    explicit inline AstBasicDTypeKwd (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
    int width() const {
	switch (m_e) {
	case BIT:	return 1;
	case BYTE:	return 8;
	case CHANDLE:	return 64;
	case INT:	return 32;
	case INTEGER:	return 32;
	case LOGIC:	return 1;
	case LONGINT:	return 64;
	case SHORTINT:	return 16;
	case TIME:	return 64;
	case STRING:	return 64;  // Just the pointer, for today
	default: return 0;
	}
    }
    bool isSigned() const {
	return m_e==BYTE || m_e==SHORTINT || m_e==INT || m_e==LONGINT || m_e==INTEGER;
    }
    bool isFourstate() const {
	return m_e==INTEGER || m_e==LOGIC || m_e==LOGIC_IMPLICIT;
    }
    bool isZeroInit() const { // Otherwise initializes to X
	return (m_e==BIT || m_e==BYTE || m_e==CHANDLE || m_e==INT || m_e==LONGINT || m_e==SHORTINT
		|| m_e==STRING);
    }
    bool isSloppy() const { // Don't be as anal about width warnings
	return !(m_e==LOGIC || m_e==BIT);
    }
    bool isBitLogic() const { // Don't be as anal about width warnings
	return (m_e==LOGIC || m_e==BIT);
    }
    bool isDpiUnsupported() const {
	return (m_e==LOGIC || m_e==TIME || m_e==REALTIME);
    }
    bool isOpaque() const {  // IE not a simple number we can bit optimize
	return (m_e==STRING || m_e==SCOPEPTR || m_e==CHARPTR);
    }
  };
  inline bool operator== (AstBasicDTypeKwd lhs, AstBasicDTypeKwd rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstBasicDTypeKwd lhs, AstBasicDTypeKwd::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstBasicDTypeKwd::en lhs, AstBasicDTypeKwd rhs) { return (lhs == rhs.m_e); }

//######################################################################

enum AstSignedState {
    // This can't be in the fancy class as the lexer union will get upset
    signedst_NOP=0, signedst_SIGNED=1, signedst_UNSIGNED=2
};

//######################################################################

class AstVarType {
public:
    enum en {
	UNKNOWN,
	GPARAM,
	LPARAM,
	GENVAR,
	VAR,		// Reg, integer, logic, etc
	INPUT,
	OUTPUT,
	INOUT,
	SUPPLY0,
	SUPPLY1,
	WIRE,
	IMPLICITWIRE,
	TRIWIRE,
	PORT,		// Temp type used in parser only
	BLOCKTEMP,
	MODULETEMP,
	STMTTEMP,
	XTEMP
    };
    enum en m_e;
    inline AstVarType () {}
    inline AstVarType (en _e) : m_e(_e) {}
    explicit inline AstVarType (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
    const char* ascii() const {
	static const char* names[] = {
	    "?","GPARAM","LPARAM","GENVAR",
	    "VAR","INPUT","OUTPUT","INOUT",
	    "SUPPLY0","SUPPLY1","WIRE","IMPLICITWIRE","TRIWIRE","PORT",
	    "BLOCKTEMP","MODULETEMP","STMTTEMP","XTEMP"};
	return names[m_e]; }
  };
  inline bool operator== (AstVarType lhs, AstVarType rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstVarType lhs, AstVarType::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstVarType::en lhs, AstVarType rhs) { return (lhs == rhs.m_e); }
  inline ostream& operator<<(ostream& os, AstVarType rhs) { return os<<rhs.ascii(); }

//######################################################################

class AstBranchPred {
public:
    enum en {
	BP_UNKNOWN=0,
	BP_LIKELY,
	BP_UNLIKELY,
	_ENUM_END
    };
    enum en m_e;
    // CONSTRUCTOR - note defaults to *UNKNOWN*
    inline AstBranchPred () : m_e(BP_UNKNOWN) {}
    inline AstBranchPred (en _e) : m_e(_e) {}
    explicit inline AstBranchPred (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
    AstBranchPred invert() const {
	if (m_e==BP_UNLIKELY) return BP_LIKELY;
	else if (m_e==BP_LIKELY) return BP_UNLIKELY;
	else return m_e;
    }
    const char* ascii() const {
	static const char* names[] = {
	    "","VL_LIKELY","VL_UNLIKELY"};
	return names[m_e]; }
  };
  inline bool operator== (AstBranchPred lhs, AstBranchPred rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstBranchPred lhs, AstBranchPred::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstBranchPred::en lhs, AstBranchPred rhs) { return (lhs == rhs.m_e); }
  inline ostream& operator<<(ostream& os, AstBranchPred rhs) { return os<<rhs.ascii(); }

//######################################################################

class AstCaseType {
public:
    enum en {
	CT_CASE,
	CT_CASEX,
	CT_CASEZ
    };
    enum en m_e;
    inline AstCaseType () {}
    inline AstCaseType (en _e) : m_e(_e) {}
    explicit inline AstCaseType (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
  };
  inline bool operator== (AstCaseType lhs, AstCaseType rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstCaseType lhs, AstCaseType::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstCaseType::en lhs, AstCaseType rhs) { return (lhs == rhs.m_e); }

//######################################################################

class AstDisplayType {
public:
    enum en {
	DT_DISPLAY,
	DT_WRITE,
	DT_INFO,
	DT_ERROR,
	DT_WARNING,
	DT_FATAL
    };
    enum en m_e;
    inline AstDisplayType () {}
    inline AstDisplayType (en _e) : m_e(_e) {}
    explicit inline AstDisplayType (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
    bool addNewline() const { return m_e!=DT_WRITE; }
    bool needScopeTracking() const { return m_e!=DT_DISPLAY && m_e!=DT_WRITE; }
    const char* ascii() const {
	static const char* names[] = {
	    "display","write","info","error","warning","fatal"};
	return names[m_e]; }
  };
  inline bool operator== (AstDisplayType lhs, AstDisplayType rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstDisplayType lhs, AstDisplayType::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstDisplayType::en lhs, AstDisplayType rhs) { return (lhs == rhs.m_e); }

//######################################################################

class AstParseRefExp {
public:
    enum en {
	PX_NONE,	// Used in V3LinkParse only
	PX_VAR_MEM,
	PX_VAR_ANY,
	PX_TASK,
	PX_FUNC
    };
    enum en m_e;
    inline AstParseRefExp() : m_e(PX_NONE) {}
    inline AstParseRefExp (en _e) : m_e(_e) {}
    explicit inline AstParseRefExp (int _e) : m_e(static_cast<en>(_e)) {}
    operator en () const { return m_e; }
    const char* ascii() const {
	static const char* names[] = {
	    "","VAR_MEM","VAR_ANY","TASK","FUNC"};
	return names[m_e]; }
  };
  inline bool operator== (AstParseRefExp lhs, AstParseRefExp rhs) { return (lhs.m_e == rhs.m_e); }
  inline bool operator== (AstParseRefExp lhs, AstParseRefExp::en rhs) { return (lhs.m_e == rhs); }
  inline bool operator== (AstParseRefExp::en lhs, AstParseRefExp rhs) { return (lhs == rhs.m_e); }
  inline ostream& operator<<(ostream& os, AstParseRefExp rhs) { return os<<rhs.ascii(); }

//######################################################################
// AstNUser - Generic pointer base class for AST User nodes.
//	    - Also used to allow parameter passing up/down iterate calls

class WidthVP;
class LinkVP;
class OrderBlockNU;
class OrderVarNU;
class V3GraphVertex;
class V3SymTable;
struct AstNUser {
    AstNUser*	p() { return this; }	// So can take address of temporary: iterate(...,AstNUser(args).p())
    // Casters
    WidthVP*	c() { return ((WidthVP*)this); }
    LinkVP*	castLinkVP() { return ((LinkVP*)this); }
    V3SymTable*	castSymTable() { return ((V3SymTable*)this); }
    AstNode*	castNode() { return ((AstNode*)this); }
    OrderBlockNU* castOrderBlock() { return ((OrderBlockNU*)this); }
    OrderVarNU*	castOrderVar() { return ((OrderVarNU*)this); }
    V3GraphVertex* castGraphVertex() { return ((V3GraphVertex*)this); }
    inline int	castInt() {
	union { AstNUser* up; int ui; } u;
	u.up = this;
	return u.ui;
    }
    static inline AstNUser* fromInt (int i) {
	union { AstNUser* up; int ui; } u;
	u.up=0; u.ui=i;
	return u.up;
    }
};

//######################################################################
// AstUserResource - Generic pointer base class for tracking usage of user()
//
//  Where AstNode->user2() is going to be used, for example, you write:
//
//	AstUser2InUse  m_userres;
//
//  This will clear the tree, and prevent another visitor from clobering
//  user2.  When the member goes out of scope it will be automagically
//  freed up.

class AstUserInUseBase {
protected:
    static void	allocate(int id, uint32_t& cntGblRef, bool& userBusyRef) {
	// Perhaps there's still a AstUserInUse in scope for this?
	UASSERT_STATIC(!userBusyRef, "Conflicting user use; AstUser"+cvtToStr(id)+"InUse request when under another AstUserInUse");
	userBusyRef = true;
	clearcnt(id, cntGblRef, userBusyRef);
    }
    static void	free(int id, uint32_t& cntGblRef, bool& userBusyRef) {
	UASSERT_STATIC(userBusyRef, "Free of User"+cvtToStr(id)+"() not under AstUserInUse");
	clearcnt(id, cntGblRef, userBusyRef);  // Includes a checkUse for us
	userBusyRef = false;
    }
    static void clearcnt(int id, uint32_t& cntGblRef, bool& userBusyRef) {
	UASSERT_STATIC(userBusyRef, "Clear of User"+cvtToStr(id)+"() not under AstUserInUse");
	// If this really fires and is real (after 2^32 edits???)
	// we could just walk the tree and clear manually
	++cntGblRef;
	UASSERT_STATIC(cntGblRef, "User*() overflowed!");
    }
    static void checkcnt(int id, uint32_t&, bool& userBusyRef) {
	UASSERT_STATIC(userBusyRef, "Check of User"+cvtToStr(id)+"() failed, not under AstUserInUse");
    }
};

// For each user() declare the in use structure
// We let AstNode peek into here, because when under low optimization even
// an accessor would be way too slow.
class AstUser1InUse : AstUserInUseBase {
protected:
    friend class AstNode;
    static uint32_t	s_userCntGbl;	// Count of which usage of userp() this is
    static bool		s_userBusy;	// Count is in use
public:
    AstUser1InUse()     { allocate(1, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    ~AstUser1InUse()    { free    (1, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    static void clear() { clearcnt(1, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    static void check() { checkcnt(1, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
};
class AstUser2InUse : AstUserInUseBase {
protected:
    friend class AstNode;
    static uint32_t	s_userCntGbl;	// Count of which usage of userp() this is
    static bool		s_userBusy;	// Count is in use
public:
    AstUser2InUse()      { allocate(2, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    ~AstUser2InUse()     { free    (2, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    static void clear()  { clearcnt(2, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    static void check()	 { checkcnt(2, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
};
class AstUser3InUse : AstUserInUseBase {
protected:
    friend class AstNode;
    static uint32_t	s_userCntGbl;	// Count of which usage of userp() this is
    static bool		s_userBusy;	// Count is in use
public:
    AstUser3InUse()      { allocate(3, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    ~AstUser3InUse()     { free    (3, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    static void clear()  { clearcnt(3, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    static void check()	 { checkcnt(3, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
};
class AstUser4InUse : AstUserInUseBase {
protected:
    friend class AstNode;
    static uint32_t	s_userCntGbl;	// Count of which usage of userp() this is
    static bool		s_userBusy;	// Count is in use
public:
    AstUser4InUse()      { allocate(4, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    ~AstUser4InUse()     { free    (4, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    static void clear()  { clearcnt(4, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    static void check()	 { checkcnt(4, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
};
class AstUser5InUse : AstUserInUseBase {
protected:
    friend class AstNode;
    static uint32_t	s_userCntGbl;	// Count of which usage of userp() this is
    static bool		s_userBusy;	// Count is in use
public:
    AstUser5InUse()      { allocate(5, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    ~AstUser5InUse()     { free    (5, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    static void clear()  { clearcnt(5, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
    static void check()	 { checkcnt(5, s_userCntGbl/*ref*/, s_userBusy/*ref*/); }
};

//######################################################################
// AstNVisitor -- Allows new functions to be called on each node
// type without changing the base classes.  See "Modern C++ Design".

class AstNVisitor {
private:
    vector<AstNode*>	m_deleteps;	// Nodes to delete when we are finished
protected:
    friend class AstNode;
public:
    // Cleaning
    void pushDeletep(AstNode* nodep) {
	m_deleteps.push_back(nodep);
    }
    void doDeletes();
public:
    virtual ~AstNVisitor() {
	doDeletes();
    }
#include "V3Ast__gen_visitor.h"	// From ./astgen
    // Things like:
    //  virtual void visit(type*) = 0;
};

//######################################################################
// AstNRelinker -- Holds the state of a unlink so a new node can be
// added at the same point.

class AstNRelinker {
protected:
    friend class AstNode;
    enum RelinkWhatEn {
	RELINK_BAD, RELINK_NEXT, RELINK_OP1, RELINK_OP2, RELINK_OP3, RELINK_OP4
    };
    AstNode* m_oldp;	// The old node that was linked to this point in the tree
    AstNode* m_backp;
    RelinkWhatEn m_chg;
    AstNode** m_iterpp;
public:
    AstNRelinker() { m_backp=NULL; m_chg=RELINK_BAD; m_iterpp=NULL;}
    void relink(AstNode* newp);
    AstNode* oldp() const { return m_oldp; }
    void dump(ostream& str=cout);
};
inline ostream& operator<<(ostream& os, AstNRelinker& rhs) { rhs.dump(os); return os;}

//######################################################################
// V3Hash -- Node hashing for V3Combine

class V3Hash {
    // A hash of a tree of nodes, consisting of 8 bits with the number of nodes in the hash
    // and 24 bit value hash of relevant information about the node.
    // A value of 0 is illegal
    uint32_t	m_both;
    static const uint32_t M24 = ((1<<24)-1);
    void setBoth(uint32_t depth, uint32_t hshval) {
	if (depth==0) depth=1; if (depth>255) depth=255;
	m_both = (depth<<24) | (hshval & M24);
    }
public:
    // METHODS
    bool isIllegal() const { return m_both==0; }
    uint32_t fullValue() const { return m_both; }
    uint32_t depth() const { return (m_both >> 24) & 255; }
    uint32_t hshval() const { return m_both & M24; }
    // OPERATORS
    inline bool operator== (const V3Hash& rh) const { return m_both==rh.m_both; }
    inline bool operator!= (const V3Hash& rh) const { return m_both!=rh.m_both; }
    inline bool operator< (const V3Hash& rh) const { return m_both<rh.m_both; }
    // CREATORS
    class Illegal {};		// for creator type-overload selection
    class FullValue {};		// for creator type-overload selection
    V3Hash(Illegal) { m_both=0; }
    // Saving and restoring inside a userp
    V3Hash(AstNUser* up) { m_both=up->castInt(); }
    V3Hash operator+= (const V3Hash& rh) {
	setBoth(depth()+rh.depth(), (hshval()*31+rh.hshval()));
	return *this; };
    // Creating from raw data (sameHash functions)
    V3Hash() { setBoth(1,0); }
    V3Hash(uint32_t val) { setBoth(1,val); }
    V3Hash(void* vp) { setBoth(1,cvtToHash(vp)); }
    V3Hash(const string& name);
    V3Hash(V3Hash lh, V3Hash rh) {
	setBoth(1,lh.hshval()*31+rh.hshval());
    }
};
ostream& operator<<(ostream& os, V3Hash rhs);

//######################################################################
// AstNode -- Base type of all Ast types

// Prefetch a node.
// The if() makes it faster, even though prefetch won't fault on null pointers
#define ASTNODE_PREFETCH(nodep) \
    { if (nodep) { VL_PREFETCH_RD(&(nodep->m_nextp)); VL_PREFETCH_RD(&(nodep->m_iterpp)); }}

class AstNode {
    // v ASTNODE_PREFETCH depends on below ordering of members
    AstNode*	m_nextp;	// Next peer in the parent's list
    AstNode*	m_backp;	// Node that points to this one (via next/op1/op2/...)
    AstNode*	m_op1p;		// Generic pointer 1
    AstNode*	m_op2p;		// Generic pointer 2
    AstNode*	m_op3p;		// Generic pointer 3
    AstNode*	m_op4p;		// Generic pointer 4
    AstNode**	m_iterpp;	// Pointer to node iterating on, change it if we replace this node.
    // ^ ASTNODE_PREFETCH depends on above ordering of members

    AstNode*	m_headtailp;	// When at begin/end of list, the opposite end of the list

    FileLine*	m_fileline;	// Where it was declared
    vluint64_t	m_editCount;	// When it was last edited
    static vluint64_t s_editCntGbl; // Global edit counter
    static vluint64_t s_editCntLast;// Global edit counter, last value for printing * near node #s

    AstNode*	m_clonep;	// Pointer to clone of/ source of this module (for *LAST* cloneTree() ONLY)
    int		m_cloneCnt;	// Mark of when userp was set
    static int	s_cloneCntGbl;	// Count of which userp is set

    // Attributes
    bool	m_signed:1;	// Node is signed
    //		// Space for more bools here

    int		m_width;	// Bit width of operation
    int		m_widthMin;	// If unsized, bitwidth of minimum implementation
    // This member ordering both allows 64 bit alignment and puts associated data together
    AstNUser*	m_user1p;	// Pointer to any information the user iteration routine wants
    uint32_t	m_user1Cnt;	// Mark of when userp was set
    uint32_t	m_user2Cnt;	// Mark of when userp was set
    AstNUser*	m_user2p;	// Pointer to any information the user iteration routine wants
    AstNUser*	m_user3p;	// Pointer to any information the user iteration routine wants
    uint32_t	m_user3Cnt;	// Mark of when userp was set
    uint32_t	m_user4Cnt;	// Mark of when userp was set
    AstNUser*	m_user4p;	// Pointer to any information the user iteration routine wants
    AstNUser*	m_user5p;	// Pointer to any information the user iteration routine wants
    uint32_t	m_user5Cnt;	// Mark of when userp was set

    // METHODS
    void	op1p(AstNode* nodep) { m_op1p = nodep; if (nodep) nodep->m_backp = this; }
    void	op2p(AstNode* nodep) { m_op2p = nodep; if (nodep) nodep->m_backp = this; }
    void	op3p(AstNode* nodep) { m_op3p = nodep; if (nodep) nodep->m_backp = this; }
    void	op4p(AstNode* nodep) { m_op4p = nodep; if (nodep) nodep->m_backp = this; }

    void	init();	// initialize value of AstNode
    void	iterateListBackwards(AstNVisitor& v, AstNUser* vup=NULL);
    AstNode*	cloneTreeIter();
    AstNode*	cloneTreeIterList();
    void	checkTreeIter(AstNode* backp);
    void	checkTreeIterList(AstNode* backp);
    bool	sameTreeIter(AstNode* node2p, bool ignNext);
    void	deleteTreeIter();
    void	deleteNode();
    static void	relinkOneLink(AstNode*& pointpr, AstNode* newp);
    void	debugTreeChange(const char* prefix, int lineno, bool next);

protected:
    // CONSTUCTORS
    AstNode() {init(); }
    AstNode(FileLine* fileline) {init(); m_fileline = fileline; }
    virtual AstNode* clone() = 0;	// Generally, cloneTree is what you want instead
    virtual void cloneRelink() {}
    void 	cloneRelinkTree();

    // METHODS
    void	setOp1p(AstNode* newp);		// Set non-list-type op1 to non-list element
    void	setOp2p(AstNode* newp);		// Set non-list-type op2 to non-list element
    void	setOp3p(AstNode* newp);		// Set non-list-type op3 to non-list element
    void	setOp4p(AstNode* newp);		// Set non-list-type op4 to non-list element

    void	setNOp1p(AstNode* newp) { if (newp) setOp1p(newp); }
    void	setNOp2p(AstNode* newp) { if (newp) setOp2p(newp); }
    void	setNOp3p(AstNode* newp) { if (newp) setOp3p(newp); }
    void	setNOp4p(AstNode* newp) { if (newp) setOp4p(newp); }

    void	addOp1p(AstNode* newp);		// Append newp to end of op1
    void	addOp2p(AstNode* newp);		// Append newp to end of op2
    void	addOp3p(AstNode* newp);		// Append newp to end of op3
    void	addOp4p(AstNode* newp);		// Append newp to end of op4

    void	addNOp1p(AstNode* newp) { if (newp) addOp1p(newp); }
    void	addNOp2p(AstNode* newp) { if (newp) addOp2p(newp); }
    void	addNOp3p(AstNode* newp) { if (newp) addOp3p(newp); }
    void	addNOp4p(AstNode* newp) { if (newp) addOp4p(newp); }

    void	clonep(AstNode* nodep) { m_clonep=nodep; m_cloneCnt=s_cloneCntGbl; }
    static void	cloneClearTree() { s_cloneCntGbl++; UASSERT_STATIC(s_cloneCntGbl,"Rollover"); }

public:
    // ACCESSORS
    virtual AstType	type() const = 0;
    const char*	typeName() const { return type().ascii(); }  // See also prettyTypeName
    AstNode*	nextp() const { return m_nextp; }
    AstNode*	backp() const { return m_backp; }
    AstNode*	op1p() const { return m_op1p; }
    AstNode*	op2p() const { return m_op2p; }
    AstNode*	op3p() const { return m_op3p; }
    AstNode*	op4p() const { return m_op4p; }
    AstNode*	clonep() const { return ((m_cloneCnt==s_cloneCntGbl)?m_clonep:NULL); }
    AstNode*	firstAbovep() const { return ((backp() && backp()->nextp()!=this) ? backp() : NULL); }  // Returns NULL when second or later in list
    bool	brokeExists() const;
    bool	brokeExistsAbove() const;

    // CONSTRUCTORS
    virtual ~AstNode();
#ifdef VL_LEAK_CHECKS
    static void* operator new(size_t size);
    static void operator delete(void* obj, size_t size);
#endif

    // CONSTANT ACCESSORS
    static int	instrCountBranch() { return 4; }	///< Instruction cycles to branch
    static int	instrCountDiv() { return 10; }		///< Instruction cycles to divide
    static int	instrCountDpi() { return 1000; }	///< Instruction cycles to call user function
    static int	instrCountLd() { return 2; }		///< Instruction cycles to load memory
    static int	instrCountMul() { return 3; }		///< Instruction cycles to multiply integers
    static int	instrCountPli() { return 20; }		///< Instruction cycles to call pli routines
    static int	instrCountCall() { return instrCountBranch()+10; }	///< Instruction cycles to call subroutine
    static int	instrCountTime() { return instrCountCall()+5; }		///< Instruction cycles to determine simulation time

    // ACCESSORS
    virtual string name() const { return ""; }
    virtual void name(const string& name) { this->v3fatalSrc("name() called on object without name() method"); }
    virtual string verilogKwd() const { return ""; }
    string 	shortName() const;	// Name with __PVT__ removed for concatenating scopes
    static string dedotName(const string& namein);	// Name with dots removed
    static string quoteName(const string& namein);	// Name with control chars quoted
    static string prettyName(const string& namein);	// Name for printing out to the user
    static string encodeName(const string& namein);	// Encode user name into internal C representation
    static string encodeNumber(vlsint64_t numin);	// Encode number into internal C representation
    static string vcdName(const string& namein); // Name for printing out to vcd files
    string	prettyName() const { return prettyName(name()); }
    string	prettyTypeName() const;			// "VARREF name" for error messages
    FileLine*	fileline() const { return m_fileline; }
    void	fileline(FileLine* fl) { m_fileline=fl; }
    int		width() const { return m_width; }
    bool	width1() const { return width()==1; }
    int		widthWords() const { return VL_WORDS_I(width()); }
    int		widthMin() const { return m_widthMin?m_widthMin:m_width; }  // If sized, the size, if unsized the min digits to represent it
    int		widthPow2() const;
    int		widthInstrs() const { return isWide()?widthWords():1; }
    bool	widthSized() const { return !m_widthMin || m_widthMin==m_width; }
    void	width(int width, int sized) { m_width=width; m_widthMin=sized; }
    void	widthFrom(AstNode* fromp) { if (fromp) { m_width=fromp->m_width; m_widthMin=fromp->m_widthMin; }}
    void	widthSignedFrom(AstNode* fromp) { widthFrom(fromp); signedFrom(fromp); }
    void	signedFrom(AstNode* fromp) { if (fromp) { m_signed=fromp->m_signed; }}
    void	isSigned(bool flag) { m_signed=flag; }
    bool	isSigned() const { return m_signed; }
    bool	isQuad() const { return (width()>VL_WORDSIZE && width()<=VL_QUADSIZE); }
    bool	isWide() const { return (width()>VL_QUADSIZE); }

    AstNUser*	user1p() const {
	// Slows things down measurably, so disabled by default
	//UASSERT_STATIC(AstUser1InUse::s_userBusy, "userp set w/o busy");
	return ((m_user1Cnt==AstUser1InUse::s_userCntGbl)?m_user1p:NULL);
    }
    void	user1p(void* userp) { m_user1p=(AstNUser*)(userp); m_user1Cnt=AstUser1InUse::s_userCntGbl; }
    int		user1() const { return user1p()->castInt(); }
    void	user1(int val) { user1p(AstNUser::fromInt(val)); }
    static void	user1ClearTree() { AstUser1InUse::clear(); }  // Clear userp()'s across the entire tree

    AstNUser*	user2p() const {
	//UASSERT_STATIC(AstUser2InUse::s_userBusy, "user2p set w/o busy");
	return ((m_user2Cnt==AstUser2InUse::s_userCntGbl)?m_user2p:NULL); }
    void	user2p(void* userp) { m_user2p=(AstNUser*)(userp); m_user2Cnt=AstUser2InUse::s_userCntGbl; }
    int		user2() const { return user2p()->castInt(); }
    void	user2(int val) { user2p(AstNUser::fromInt(val)); }
    static void	user2ClearTree() { AstUser2InUse::clear(); }

    AstNUser*	user3p() const {
	//UASSERT_STATIC(AstUser3InUse::s_userBusy, "user3p set w/o busy");
	return ((m_user3Cnt==AstUser3InUse::s_userCntGbl)?m_user3p:NULL); }
    void	user3p(void* userp) { m_user3p=(AstNUser*)(userp); m_user3Cnt=AstUser3InUse::s_userCntGbl; }
    int		user3() const { return user3p()->castInt(); }
    void	user3(int val) { user3p(AstNUser::fromInt(val)); }
    static void	user3ClearTree() { AstUser3InUse::clear(); }

    AstNUser*	user4p() const {
	//UASSERT_STATIC(AstUser4InUse::s_userBusy, "user4p set w/o busy");
	return ((m_user4Cnt==AstUser4InUse::s_userCntGbl)?m_user4p:NULL); }
    void	user4p(void* userp) { m_user4p=(AstNUser*)(userp); m_user4Cnt=AstUser4InUse::s_userCntGbl; }
    int		user4() const { return user4p()->castInt(); }
    void	user4(int val) { user4p(AstNUser::fromInt(val)); }
    static void	user4ClearTree() { AstUser4InUse::clear(); }

    AstNUser*	user5p() const {
	//UASSERT_STATIC(AstUser5InUse::s_userBusy, "user5p set w/o busy");
	return ((m_user5Cnt==AstUser5InUse::s_userCntGbl)?m_user5p:NULL); }
    void	user5p(void* userp) { m_user5p=(AstNUser*)(userp); m_user5Cnt=AstUser5InUse::s_userCntGbl; }
    int		user5() const { return user5p()->castInt(); }
    void	user5(int val) { user5p(AstNUser::fromInt(val)); }
    static void	user5ClearTree() { AstUser5InUse::clear(); }

    vluint64_t	editCount() const { return m_editCount; }
    void	editCountInc() { m_editCount = ++s_editCntGbl; }  // Preincrement, so can "watch AstNode::s_editCntGbl=##"
    static vluint64_t	editCountLast() { return s_editCntLast; }
    static vluint64_t	editCountGbl() { return s_editCntGbl; }
    static void		editCountSetLast() { s_editCntLast = editCountGbl(); }

    // ACCESSORS for specific types
    // Alas these can't be virtual or they break when passed a NULL
    bool	isZero();
    bool	isOne();
    bool	isNeqZero();
    bool	isAllOnes();
    bool	isAllOnesV();  // Verilog width rules apply

    // METHODS
    AstNode*	addNext(AstNode* newp);		// Returns this, adds to end of list
    AstNode*	addNextNull(AstNode* newp);	// Returns this, adds to end of list, NULL is OK
    void	addNextHere(AstNode* newp);	// Adds after speced node
    void	addPrev(AstNode* newp) { replaceWith(newp); newp->addNext(this); }
    void	addHereThisAsNext(AstNode* newp); // Adds at old place of this, this becomes next
    void	replaceWith(AstNode* newp);	// Replace current node in tree with new node
    void	v3errorEnd(ostringstream& str) const;
    virtual void dump(ostream& str=cout);
    AstNode*	unlinkFrBack(AstNRelinker* linkerp=NULL);  // Unlink this from whoever points to it.
    AstNode*	unlinkFrBackWithNext(AstNRelinker* linkerp=NULL);  // Unlink this from whoever points to it, keep entire next list with unlinked node
    void	swapWith(AstNode* bp);
    void	relink(AstNRelinker* linkerp);	// Generally use linker->relink() instead
    void	cloneRelinkNode() { cloneRelink(); }
    // Iterate and insert - assumes tree format
    virtual void addNextStmt(AstNode* newp, AstNode* belowp);  // When calling, "this" is second argument
    virtual void addBeforeStmt(AstNode* newp, AstNode* belowp);  // When calling, "this" is second argument

    // METHODS - Iterate on a tree
    AstNode*	cloneTree(bool cloneNextLink);
    bool	sameTree(AstNode* node2p);	// Does tree of this == node2p?
    void	deleteTree();	// Always deletes the next link
    void	checkTree();  // User Interface version
    void	dumpPtrs(ostream& str=cout);
    void	dumpTree(ostream& str=cout, const string& indent="    ", int maxDepth=0);
    void	dumpTreeAndNext(ostream& str=cout, const string& indent="    ", int maxDepth=0);
    void	dumpTreeFile(const string& filename, bool append=false);

    // METHODS - queries
    virtual bool isSplittable() const { return true; }	// Else a $display, etc, that must be ordered with other displays
    virtual bool isGateOptimizable() const { return true; }	// Else a AstTime etc that can't be pushed out
    virtual bool isSubstOptimizable() const { return true; }	// Else a AstTime etc that can't be substituted out
    virtual bool isPredictOptimizable() const { return true; }	// Else a AstTime etc which output can't be predicted from input
    virtual bool isOutputter() const { return false; }	// Else creates output or exits, etc, not unconsumed
    virtual bool isUnlikely() const { return false; }	// Else $stop or similar statement which means an above IF statement is unlikely to be taken
    virtual int  instrCount() const { return 0; }
    virtual V3Hash sameHash() const { return V3Hash(V3Hash::Illegal()); }  // Not a node that supports it
    virtual bool same(AstNode* otherp) const { return true; }
    virtual bool maybePointedTo() const { return false; }  // Another AstNode* may have a pointer into this node, other then normal front/back/etc.
    virtual bool broken() const { return false; }

    // INVOKERS
    virtual void accept(AstNVisitor& v, AstNUser* vup=NULL) = 0;
    void	iterate(AstNVisitor& v, AstNUser* vup=NULL) { this->accept(v,vup); } 	  // Does this; excludes following this->next
    void	iterateAndNext(AstNVisitor& v, AstNUser* vup=NULL);
    void	iterateAndNextIgnoreEdit(AstNVisitor& v, AstNUser* vup=NULL);
    void	iterateChildren(AstNVisitor& v, AstNUser* vup=NULL);  // Excludes following this->next
    void	iterateChildrenBackwards(AstNVisitor& v, AstNUser* vup=NULL);  // Excludes following this->next
    AstNode*	acceptSubtreeReturnEdits(AstNVisitor& v, AstNUser* vup=NULL);  // Return edited nodep; see comments in V3Ast.cpp

    // CONVERSION
    AstNode*	castNode() { return this; }
#include "V3Ast__gen_interface.h"	// From ./astgen
    // Things like:
    //  AstAlways*	castAlways();
};

inline ostream& operator<<(ostream& os, AstNode* rhs) { rhs->dump(os); return os;}
inline void AstNRelinker::relink(AstNode* newp) { newp->AstNode::relink(this); }

//######################################################################
//######################################################################
//=== AstNode* : Derived generic node types

#define ASTNODE_BASE_FUNCS(name)	\
    virtual ~Ast ##name() {} \
    Ast ##name * cloneTree(bool cloneNext) { return AstNode::cloneTree(cloneNext)->cast ##name(); }

struct AstNodeMath : public AstNode {
    // Math -- anything that's part of an expression tree
    AstNodeMath(FileLine* fl)
	: AstNode(fl) {}
    ASTNODE_BASE_FUNCS(NodeMath)
    // METHODS
    virtual string emitVerilog() = 0;  /// Format string for verilog writing; see V3EmitV
    virtual string emitC() = 0;
    virtual string emitSimpleOperator() { return ""; }
    virtual bool cleanOut() = 0; // True if output has extra upper bits zero
    // Someday we will generically support data types on every math node
    // Until then isOpaque indicates we shouldn't constant optimize this node type
    bool isOpaque() { return castCvtPackString()!=NULL; }
};

struct AstNodeTermop : public AstNodeMath {
    // Terminal operator -- a operator with no "inputs"
    AstNodeTermop(FileLine* fl)
	: AstNodeMath(fl) {}
    ASTNODE_BASE_FUNCS(NodeTermop)
    // Know no children, and hot function, so skip iterator for speed
    // See checkTreeIter also that asserts no children
    void iterateChildren(AstNVisitor& v, AstNUser* vup=NULL) { }
};

struct AstNodeUniop : public AstNodeMath {
    // Unary math
    AstNodeUniop(FileLine* fl, AstNode* lhsp)
	: AstNodeMath(fl) {
	if (lhsp) widthSignedFrom(lhsp);
	setOp1p(lhsp); }
    ASTNODE_BASE_FUNCS(NodeUniop)
    AstNode*	lhsp() 	const { return op1p()->castNode(); }
    // METHODS
    virtual void numberOperate(V3Number& out, const V3Number& lhs) = 0; // Set out to evaluation of a AstConst'ed lhs
    virtual bool cleanLhs() = 0;
    virtual bool sizeMattersLhs() = 0; // True if output result depends on lhs size
    virtual int instrCount()	const { return widthInstrs(); }
    virtual V3Hash sameHash() const { return V3Hash(); }
    virtual bool same(AstNode*) const { return true; }
};

struct AstNodeBiop : public AstNodeMath {
    // Binary math
    AstNodeBiop(FileLine* fl, AstNode* lhs, AstNode* rhs)
	: AstNodeMath(fl) {
	setOp1p(lhs); setOp2p(rhs); }
    ASTNODE_BASE_FUNCS(NodeBiop)
    AstNode*	lhsp() 	const { return op1p()->castNode(); }
    AstNode*	rhsp() 	const { return op2p()->castNode(); }
    void	lhsp(AstNode* nodep)  { return setOp1p(nodep); }
    void	rhsp(AstNode* nodep)  { return setOp2p(nodep); }
    // METHODS
    virtual void numberOperate(V3Number& out, const V3Number& lhs, const V3Number& rhs) = 0; // Set out to evaluation of a AstConst'ed
    virtual bool cleanLhs() = 0; // True if LHS must have extra upper bits zero
    virtual bool cleanRhs() = 0; // True if RHS must have extra upper bits zero
    virtual bool sizeMattersLhs() = 0; // True if output result depends on lhs size
    virtual bool sizeMattersRhs() = 0; // True if output result depends on rhs size
    virtual bool signedFlavor() const { return false; }	// Signed flavor of nodes with both flavors?
    virtual int instrCount()	const { return widthInstrs(); }
    virtual V3Hash sameHash() const { return V3Hash(); }
    virtual bool same(AstNode*) const { return true; }
};

struct AstNodeTriop : public AstNodeMath {
    // Trinary math
    AstNodeTriop(FileLine* fl, AstNode* lhs, AstNode* rhs, AstNode* ths)
	: AstNodeMath(fl) {
	setOp1p(lhs); setOp2p(rhs); setOp3p(ths); }
    ASTNODE_BASE_FUNCS(NodeTriop)
    AstNode*	lhsp() 	const { return op1p()->castNode(); }
    AstNode*	rhsp() 	const { return op2p()->castNode(); }
    AstNode*	thsp() 	const { return op3p()->castNode(); }
    void	lhsp(AstNode* nodep)  { return setOp1p(nodep); }
    void	rhsp(AstNode* nodep)  { return setOp2p(nodep); }
    void	thsp(AstNode* nodep)  { return setOp3p(nodep); }
    // METHODS
    virtual void numberOperate(V3Number& out, const V3Number& lhs, const V3Number& rhs, const V3Number& ths) = 0; // Set out to evaluation of a AstConst'ed
    virtual bool cleanLhs() = 0; // True if LHS must have extra upper bits zero
    virtual bool cleanRhs() = 0; // True if RHS must have extra upper bits zero
    virtual bool cleanThs() = 0; // True if THS must have extra upper bits zero
    virtual bool sizeMattersLhs() = 0; // True if output result depends on lhs size
    virtual bool sizeMattersRhs() = 0; // True if output result depends on rhs size
    virtual bool sizeMattersThs() = 0; // True if output result depends on ths size
    virtual int instrCount()	const { return widthInstrs(); }
    virtual V3Hash sameHash() const { return V3Hash(); }
    virtual bool same(AstNode*) const { return true; }
};

struct AstNodeBiCom : public AstNodeBiop {
    // Binary math with commutative properties
    AstNodeBiCom(FileLine* fl, AstNode* lhs, AstNode* rhs)
	: AstNodeBiop(fl, lhs, rhs) {}
    ASTNODE_BASE_FUNCS(NodeBiCom)
};

struct AstNodeBiComAsv : public AstNodeBiCom {
    // Binary math with commutative & associative properties
    AstNodeBiComAsv(FileLine* fl, AstNode* lhs, AstNode* rhs)
	: AstNodeBiCom(fl, lhs, rhs) {}
    ASTNODE_BASE_FUNCS(NodeBiComAsv)
};
struct AstNodeCond : public AstNodeTriop {
    AstNodeCond(FileLine* fl, AstNode* condp, AstNode* expr1p, AstNode* expr2p)
	: AstNodeTriop(fl, condp, expr1p, expr2p) {
	if (expr1p) widthSignedFrom(expr1p);
	else if (expr2p) widthSignedFrom(expr2p);
    }
    ASTNODE_BASE_FUNCS(NodeCond)
    virtual void numberOperate(V3Number& out, const V3Number& lhs, const V3Number& rhs, const V3Number& ths) {
	if (lhs.isNeqZero()) out.opAssign(rhs); else out.opAssign(ths); }
    AstNode*	condp() 	const { return op1p()->castNode(); }	// op1 = Condition
    AstNode*	expr1p() 	const { return op2p()->castNode(); }	// op2 = If true...
    AstNode*	expr2p() 	const { return op3p()->castNode(); }	// op3 = If false...
    virtual string emitVerilog() { return "%k(%l %f? %r %k: %t)"; }
    virtual string emitC() { return "VL_COND_%nq%lq%rq%tq(%nw,%lw,%rw,%tw, %P, %li, %ri, %ti)"; }
    virtual bool cleanOut() { return false; } // clean if e1 & e2 clean
    virtual bool cleanLhs() { return true; }
    virtual bool cleanRhs() { return false; } virtual bool cleanThs() { return false; } // Propagates up
    virtual bool sizeMattersLhs() { return false; } virtual bool sizeMattersRhs() { return false; }
    virtual bool sizeMattersThs() { return false; }
    virtual int instrCount()	const { return instrCountBranch(); }
};

struct AstNodePreSel : public AstNode {
    // Something that becomes a AstSel
    AstNodePreSel(FileLine* fl, AstNode* lhs, AstNode* rhs, AstNode* ths)
	: AstNode(fl) {
	setOp1p(lhs); setOp2p(rhs); setNOp3p(ths); }
    ASTNODE_BASE_FUNCS(NodePreSel)
    AstNode*	lhsp() 	const { return op1p()->castNode(); }
    AstNode*	fromp() const { return lhsp(); }
    AstNode*	rhsp() 	const { return op2p()->castNode(); }
    AstNode*	thsp() 	const { return op3p()->castNode(); }
    AstAttrOf*	attrp() const { return op4p()->castAttrOf(); }
    void	lhsp(AstNode* nodep)  { return setOp1p(nodep); }
    void	rhsp(AstNode* nodep)  { return setOp2p(nodep); }
    void	thsp(AstNode* nodep)  { return setOp3p(nodep); }
    void	attrp(AstAttrOf* nodep)  { return setOp4p((AstNode*)nodep); }
    // METHODS
    virtual V3Hash sameHash() const { return V3Hash(); }
    virtual bool same(AstNode*) const { return true; }
};

struct AstNodeStmt : public AstNode {
    // Statement -- anything that's directly under a function
    AstNodeStmt(FileLine* fl)
	: AstNode(fl) {}
    ASTNODE_BASE_FUNCS(NodeStmt)
    // METHODS
    virtual void addNextStmt(AstNode* newp, AstNode* belowp);  // Stop statement searchback here 
    virtual void addBeforeStmt(AstNode* newp, AstNode* belowp);  // Stop statement searchback here 
};

struct AstNodeAssign : public AstNodeStmt {
    AstNodeAssign(FileLine* fl, AstNode* lhsp, AstNode* rhsp)
	: AstNodeStmt(fl) {
	setOp1p(rhsp); setOp2p(lhsp);
	if (lhsp) widthSignedFrom(lhsp);
    }
    ASTNODE_BASE_FUNCS(NodeAssign)
    virtual AstNode*	cloneType(AstNode* lhsp, AstNode* rhsp)=0;	// Clone single node, just get same type back.
    // So iteration hits the RHS which is "earlier" in execution order, it's op1, not op2
    AstNode* rhsp()		const { return op1p()->castNode(); }	// op1 = Assign from
    AstNode* lhsp()		const { return op2p()->castNode(); }	// op2 = Assign to
    void rhsp(AstNode* np) { setOp1p(np); }
    void lhsp(AstNode* np) { setOp2p(np); }
    virtual bool cleanRhs() { return true; }
    virtual int  instrCount() const { return widthInstrs(); }
    virtual V3Hash sameHash() const { return V3Hash(); }
    virtual bool same(AstNode*) const { return true; }
    virtual string verilogKwd() const { return "="; }
};

struct AstNodeFor : public AstNodeStmt {
    AstNodeFor(FileLine* fileline, AstNode* initsp, AstNode* condp,
	       AstNode* incsp, AstNode* bodysp)
	: AstNodeStmt(fileline) {
	addNOp1p(initsp); setOp2p(condp); addNOp3p(incsp); addNOp4p(bodysp);
    }
    ASTNODE_BASE_FUNCS(NodeFor)
    AstNode*	initsp()	const { return op1p()->castNode(); }	// op1= initial statements
    AstNode*	condp()		const { return op2p()->castNode(); }	// op2= condition to continue
    AstNode*	incsp()		const { return op3p()->castNode(); }	// op3= increment statements
    AstNode*	bodysp()	const { return op4p()->castNode(); }	// op4= body of loop
    virtual bool isGateOptimizable() const { return false; }
    virtual int  instrCount() const { return instrCountBranch(); }
    virtual V3Hash sameHash() const { return V3Hash(); }
    virtual bool same(AstNode* samep) const { return true; }
};

struct AstNodeIf : public AstNodeStmt {
private:
    AstBranchPred	m_branchPred;	// Branch prediction as taken/untaken?
public:
    AstNodeIf(FileLine* fl, AstNode* condp, AstNode* ifsp, AstNode* elsesp)
	: AstNodeStmt(fl) {
	setOp1p(condp); addNOp2p(ifsp); addNOp3p(elsesp);
    }
    ASTNODE_BASE_FUNCS(NodeIf)
    AstNode*	condp()		const { return op1p(); }	// op1 = condition
    AstNode*	ifsp()		const { return op2p(); }	// op2 = list of true statements
    AstNode*	elsesp()	const { return op3p(); }	// op3 = list of false statements
    void	condp(AstNode* newp)		{ setOp1p(newp); }
    void	addIfsp(AstNode* newp)		{ addOp2p(newp); }
    void	addElsesp(AstNode* newp)	{ addOp3p(newp); }
    virtual bool isGateOptimizable() const { return false; }
    virtual int  instrCount() const { return instrCountBranch(); }
    virtual V3Hash sameHash() const { return V3Hash(); }
    virtual bool same(AstNode* samep) const { return true; }
    void    branchPred(AstBranchPred flag) { m_branchPred = flag; }
    AstBranchPred branchPred() const { return m_branchPred; }
};

struct AstNodeCase : public AstNodeStmt {
    AstNodeCase(FileLine* fl, AstNode* exprp, AstNode* casesp)
	: AstNodeStmt(fl) {
	setOp1p(exprp); addNOp2p(casesp);
    }
    ASTNODE_BASE_FUNCS(NodeCase)
    virtual int   instrCount()	const { return instrCountBranch(); }
    AstNode*	  exprp()	const { return op1p()->castNode(); }	// op1 = case condition <expression>
    AstCaseItem*  itemsp()	const { return op2p()->castCaseItem(); }  // op2 = list of case expressions
    AstNode*	  notParallelp() const { return op3p()->castNode(); }	// op3 = assertion code for non-full case's
    void addItemsp(AstNode* nodep) { addOp2p(nodep); }
    void addNotParallelp(AstNode* nodep) { setOp3p(nodep); }
};

struct AstNodeSenItem : public AstNode {
    // An AstSenItem or AstSenGate
    AstNodeSenItem(FileLine* fl) : AstNode(fl) {}
    ASTNODE_BASE_FUNCS(NodeSenItem)
    virtual bool isClocked() const = 0;
    virtual bool isCombo() const = 0;
    virtual bool isInitial() const = 0;
    virtual bool isSettle() const = 0;
    virtual bool isNever() const = 0;
};

class AstNodeVarRef : public AstNodeMath {
    // An AstVarRef or AstVarXRef
private:
    bool	m_lvalue;	// Left hand side assignment
    AstVar*	m_varp;		// [AfterLink] Pointer to variable itself
    AstVarScope* m_varScopep;	// Varscope for hierarchy
    AstPackage*	m_packagep;	// Package hierarchy
    string	m_name;		// Name of variable
    string	m_hiername;	// Scope converted into name-> for emitting
    bool	m_hierThis;	// Hiername points to "this" function
public:
    AstNodeVarRef(FileLine* fl, const string& name, bool lvalue)
	: AstNodeMath(fl), m_lvalue(lvalue), m_varp(NULL), m_varScopep(NULL),
	  m_packagep(NULL), m_name(name), m_hierThis(false) {
    }
    AstNodeVarRef(FileLine* fl, const string& name, AstVar* varp, bool lvalue)
	: AstNodeMath(fl), m_lvalue(lvalue), m_varp(varp), m_varScopep(NULL),
	  m_packagep(NULL), m_name(name), m_hierThis(false) {
	// May have varp==NULL
	if (m_varp) widthSignedFrom((AstNode*)m_varp);
    }
    ASTNODE_BASE_FUNCS(NodeVarRef)
    virtual bool broken() const;
    virtual int instrCount() const { return widthInstrs(); }
    virtual void cloneRelink();
    virtual string name()	const { return m_name; }		// * = Var name
    virtual void name(const string& name) { m_name = name; }
    bool	lvalue() const { return m_lvalue; }
    void	lvalue(bool lval) { m_lvalue=lval; }  // Avoid using this; Set in constructor
    AstVar*	varp() const { return m_varp; }				// [After Link] Pointer to variable
    void  	varp(AstVar* varp) { m_varp=varp; }
    AstVarScope*	varScopep() const { return m_varScopep; }
    void	varScopep(AstVarScope* varscp) { m_varScopep=varscp; }
    string hiername() const { return m_hiername; }
    void hiername(const string& hn) { m_hiername = hn; }
    bool hierThis() const { return m_hierThis; }
    void hierThis(bool flag) { m_hierThis = flag; }
    AstPackage* packagep() const { return m_packagep; }
    void packagep(AstPackage* nodep) { m_packagep=nodep; }
    // Know no children, and hot function, so skip iterator for speed
    // See checkTreeIter also that asserts no children
    void iterateChildren(AstNVisitor& v, AstNUser* vup=NULL) { }
};

struct AstNodeText : public AstNode {
private:
    string	m_text;
public:
    // Node that simply puts text into the output stream
    AstNodeText(FileLine* fileline, const string& textp)
	: AstNode(fileline) {
	m_text = textp;	// Copy it
    }
    ASTNODE_BASE_FUNCS(NodeText)
    virtual void dump(ostream& str=cout);
    virtual V3Hash sameHash() const { return V3Hash(text()); }
    virtual bool same(AstNode* samep) const {
	return text()==samep->castNodeText()->text(); }
    const string& text() const { return m_text; }
};

struct AstNodeDType : public AstNode {
    // Data type
    AstNodeDType(FileLine* fl) : AstNode(fl) {}
    ASTNODE_BASE_FUNCS(NodeDType)
    // Accessors
    virtual AstBasicDType* basicp() const = 0;  // (Slow) recurse down to find basic data type
    virtual AstNodeDType* skipRefp() const = 0;  // recurses over typedefs to next non-typeref type
    virtual int widthAlignBytes() const = 0; // (Slow) recurses - Structure alignment 1,2,4 or 8 bytes (arrays affect this)
    virtual int widthTotalBytes() const = 0; // (Slow) recurses - Width in bytes rounding up 1,2,4,8,12,...
};

struct AstNodeSel : public AstNodeBiop {
    // Single bit range extraction, perhaps with non-constant selection or array selection
    AstNodeSel(FileLine* fl, AstNode* fromp, AstNode* bitp)
	:AstNodeBiop(fl, fromp, bitp) {}
    ASTNODE_BASE_FUNCS(NodeSel)
    AstNode* fromp() const { return op1p()->castNode(); }	// op1 = Extracting what (NULL=TBD during parsing)
    void fromp(AstNode* nodep) { setOp1p(nodep); }
    AstNode* bitp() const { return op2p()->castNode(); }	// op2 = Msb selection expression
    void bitp(AstNode* nodep) { setOp2p(nodep); }
    int	     bitConst()	const;
};

//######################################################################
// Tasks/functions common handling

struct AstNodeFTask : public AstNode {
private:
    string	m_name;		// Name of task
    string	m_cname;	// Name of task if DPI import
    bool	m_taskPublic:1;	// Public task
    bool	m_didSigning:1;	// V3Signed completed; can skip iteration
    bool	m_attrIsolateAssign:1;// User isolate_assignments attribute
    bool	m_prototype:1;	// Just a prototype
    bool	m_dpiExport:1;	// DPI exported
    bool	m_dpiImport:1;	// DPI imported
    bool	m_dpiContext:1;	// DPI import context
    bool	m_dpiTask:1;	// DPI import task (vs. void function)
    bool	m_pure:1;	// DPI import pure
public:
    AstNodeFTask(FileLine* fileline, const string& name, AstNode* stmtsp)
	: AstNode(fileline)
	, m_name(name), m_taskPublic(false), m_didSigning(false)
	, m_attrIsolateAssign(false), m_prototype(false)
	, m_dpiExport(false), m_dpiImport(false), m_dpiContext(false)
	, m_dpiTask(false), m_pure(false) {
	addNOp3p(stmtsp);
	cname(name);  // Might be overridden by dpi import/export
    }
    ASTNODE_BASE_FUNCS(NodeFTask)
    virtual void dump(ostream& str=cout);
    virtual string name()	const { return m_name; }		// * = Var name
    virtual bool maybePointedTo() const { return true; }
    // {AstFunc only} op1 = Range output variable
    virtual void name(const string& name) 	{ m_name = name; }
    string cname() const { return m_cname; }
    void cname(const string& cname) { m_cname = cname; }
    // op1 = Output variable (functions only, NULL for tasks)
    AstNode*	fvarp() 	const { return op1p()->castNode(); }
    void 	addFvarp(AstNode* nodep) { addNOp1p(nodep); }
    bool	isFunction() const { return fvarp()!=NULL; }
    // op3 = Statements/Ports/Vars
    AstNode*	stmtsp() 	const { return op3p()->castNode(); }	// op3 = List of statements
    void	addStmtsp(AstNode* nodep) { addNOp3p(nodep); }
    // op4 = scope name
    AstScopeName* scopeNamep() const { return op4p()->castScopeName(); }
    void 	scopeNamep(AstNode* nodep) { setNOp4p(nodep); }
    void	taskPublic(bool flag) { m_taskPublic=flag; }
    bool	taskPublic() const { return m_taskPublic; }
    void	didSigning(bool flag) { m_didSigning=flag; }
    bool	didSigning() const { return m_didSigning; }
    void	attrIsolateAssign(bool flag) { m_attrIsolateAssign = flag; }
    bool	attrIsolateAssign() const { return m_attrIsolateAssign; }
    void	prototype(bool flag) { m_prototype = flag; }
    bool	prototype() const { return m_prototype; }
    void	dpiExport(bool flag) { m_dpiExport = flag; }
    bool	dpiExport() const { return m_dpiExport; }
    void	dpiImport(bool flag) { m_dpiImport = flag; }
    bool	dpiImport() const { return m_dpiImport; }
    void	dpiContext(bool flag) { m_dpiContext = flag; }
    bool	dpiContext() const { return m_dpiContext; }
    void	dpiTask(bool flag) { m_dpiTask = flag; }
    bool	dpiTask() const { return m_dpiTask; }
    void	pure(bool flag) { m_pure = flag; }
    bool	pure() const { return m_pure; }
};

struct AstNodeFTaskRef : public AstNode {
    // A reference to a task (or function)
private:
    AstNodeFTask*	m_taskp;	// [AfterLink] Pointer to task referenced
    string		m_name;		// Name of variable
    string		m_dotted;	// Dotted part of scope to task or ""
    string		m_inlinedDots;	// Dotted hierarchy flattened out
    AstPackage*		m_packagep;	// Package hierarchy
public:
    AstNodeFTaskRef(FileLine* fl, AstNode* namep, AstNode* pinsp)
	:AstNode(fl)
	, m_taskp(NULL), m_packagep(NULL) {
	setOp1p(namep);	addNOp2p(pinsp);
    }
    AstNodeFTaskRef(FileLine* fl, const string& name, AstNode* pinsp)
	:AstNode(fl)
	, m_taskp(NULL), m_name(name), m_packagep(NULL) {
	addNOp2p(pinsp);
    }
    ASTNODE_BASE_FUNCS(NodeFTaskRef)
    virtual bool broken() const { return m_taskp && !m_taskp->brokeExists(); }
    virtual void cloneRelink() { if (m_taskp && m_taskp->clonep()) {
	m_taskp = m_taskp->clonep()->castNodeFTask();
    }}
    virtual void dump(ostream& str=cout);
    virtual string name()	const { return m_name; }		// * = Var name
    string	dotted()	const { return m_dotted; }		// * = Scope name or ""
    string	prettyDotted() const { return prettyName(dotted()); }
    string	inlinedDots() const { return m_inlinedDots; }
    void	inlinedDots(const string& flag) { m_inlinedDots = flag; }
    AstNodeFTask*	taskp() const { return m_taskp; }		// [After Link] Pointer to variable
    void  	taskp(AstNodeFTask* taskp) { m_taskp=taskp; }
    virtual void name(const string& name) { m_name = name; }
    void	dotted(const string& name) { m_dotted = name; }
    AstPackage* packagep() const { return m_packagep; }
    void	packagep(AstPackage* nodep) { m_packagep=nodep; }
    // op1 = namep
    AstNode*	namep()		const { return op1p(); }
    // op2 = Pin interconnection list
    AstNode*	pinsp() 	const { return op2p()->castNode(); }
    void addPinsp(AstNode* nodep) { addOp2p(nodep); }
    // op3 = scope tracking
    AstScopeName* scopeNamep() const { return op3p()->castScopeName(); }
    void 	scopeNamep(AstNode* nodep) { setNOp3p(nodep); }
};

struct AstNodeModule : public AstNode {
    // A module, package, program or interface declaration;
    // something that can live directly under the TOP,
    // excluding $unit package stuff
private:
    string	m_name;		// Name of the module
    string	m_origName;	// Name of the module, ignoring name() changes, for dot lookup
    bool	m_modPublic:1;	// Module has public references
    bool	m_modTrace:1;	// Tracing this module
    bool	m_inLibrary:1;	// From a library, no error if not used, never top level
    int		m_level;	// 1=top module, 2=cell off top module, ...
    int		m_varNum;	// Incrementing variable number
public:
    AstNodeModule(FileLine* fl, const string& name)
	: AstNode (fl)
	,m_name(name), m_origName(name)
	,m_modPublic(false), m_modTrace(false), m_inLibrary(false)
	,m_level(0), m_varNum(0) { }
    ASTNODE_BASE_FUNCS(NodeModule)
    virtual void dump(ostream& str);
    virtual bool maybePointedTo() const { return true; }
    virtual string name()	const { return m_name; }
    AstNode*	stmtsp() 	const { return op2p()->castNode(); }	// op2 = List of statements
    AstActive*  activesp()	const { return op3p()->castActive(); }	// op3 = List of i/sblocks
    // METHODS
    void addInlinesp(AstNode* nodep) { addOp1p(nodep); }
    void addStmtp(AstNode* nodep) { addOp2p(nodep); }
    void addActivep(AstNode* nodep) { addOp3p(nodep); }
    // ACCESSORS
    virtual void name(const string& name) { m_name = name; }
    string origName() const	{ return m_origName; }
    bool inLibrary() const 	{ return m_inLibrary; }
    void inLibrary(bool flag) 	{ m_inLibrary = flag; }
    void level(int level)	{ m_level = level; }
    int  level() const		{ return m_level; }
    bool isTop() const		{ return level()==1; }
    int  varNumGetInc() 	{ return ++m_varNum; }
    void modPublic(bool flag) 	{ m_modPublic = flag; }
    bool modPublic() const 	{ return m_modPublic; }
    void modTrace(bool flag) 	{ m_modTrace = flag; }
    bool modTrace() const 	{ return m_modTrace; }
};

//######################################################################

#include "V3AstNodes.h"

#include "V3Ast__gen_impl.h"	// From ./astgen
// Things like:
//  inline AstAlways*	AstNode::castAlways() {	  return dynamic_cast<AstAlways*>(this);}

//######################################################################
// Inline ACCESSORS

inline bool AstNode::isZero()     { return (this->castConst() && this->castConst()->num().isEqZero()); }
inline bool AstNode::isNeqZero()  { return (this->castConst() && this->castConst()->num().isNeqZero()); }
inline bool AstNode::isOne()      { return (this->castConst() && this->castConst()->num().isEqOne()); }
inline bool AstNode::isAllOnes()  { return (this->castConst() && this->castConst()->num().isEqAllOnes(this->width())); }
inline bool AstNode::isAllOnesV() { return (this->castConst() && this->castConst()->num().isEqAllOnes(this->widthMin())); }

#endif // Guard