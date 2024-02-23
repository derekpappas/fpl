//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007 Fastpathlogic
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

//----------------------------------------------------------------------
// The purpose of this code is to create an intermediate representation
// of either an EDIF, verilog, vhdl, or meta language input
// The object hierarchy is designed to be language agnostic.
//----------------------------------------------------------------------

#ifndef INC_GUARD_CDOM_h
#define INC_GUARD_CDOM_h

#include <vector>
#include <map>
#include <list>
#include <iostream>
#include <cassert>

#include "Base.h"
#include "../support/CommonSupport.h"  
#include "VeriNum.h"

// visitor pattern
namespace NSCdomVisitor {
class CVisitor;
}

/**
 * CDOM class hierarchy is based on single inheritance only. All constructors are private. The only way one can get
 * a new instance of a CDOM class is by means of public static factory methods, that is public build methods.
 * Some CDOM classes deny access to these factory methods as well (private factory methods). If this is the case,
 * instances of these particular classes are created in therms of other CDOM classes. An example of such a class is
 * CDOmAttrList class. An instance of it can be created only in therms of a CDOmAttrListCollection object by means the
 * instance method CDOmAttrListCollection::buildAttrList(). <br/>
 * Each factory method takes care to create a well initialized Ref<...> object of its particular class. It takes care of setting
 * m_weakref which is a selfpointer used to grab again the only strong ref to that object when needed. <br/> <br/>
 *
 * There is a scope tree and there is an object tree. The objects in the object tree point directly to the parent
 * of the object. Moreover the objects also point to their parent scope directly (not using indirection through their
 * object parent). <br/>
 * Example: given the following hierarchy: a (scope) -> b -> c -> ........... -> n -> (x, y, z) <br/>
 * b, c, .... n are non scope parents of x, y, z
 * Suppose that x, y and z are ids, and suppose that you call getParentScope() on x. Only the first time you call
 * getParentScope() on x the whole chain up to a (exclusive) is updated wit a pointer to parent scope (that is a in this case). <br/>
 * In other words, during that metod call, b, c, ..., n and x are updated to contain a direct pointer to their
 * parent scope a. <br/>
 * Now suppose that you call getParentScope() on y. The parent scope info is already cached in y's parent, n.
 * So no additional calls up in the hierarchy are made, and y caches his parent scope (a) directly from his parent (n).
 * The same is for z.
 * So x, y and z does point directly to (a) as a parent scope but also points to their direct parent parent as well (n).
 * Moreover, these ids (x,y,z) self register to parent scope (a) when they are first created so we really have 2 hierarchies:
 * scope hierarchy (with their ids that may in turn point to scopes) and object hierarchy. <br/>
 * <b>NOTE: </b>We need the object hiearchy for code gens, to know the exact place where to generate code in the output.
 *
 * @author Bogdan Z, D Pappas, CB, Eugene C
 */
namespace NSCdom {


// ********************************************************************************
// enum typedefs
// ********************************************************************************
/**
 * Every class in CDOM has a raw type that identifies the class type at runtime.
 * This information is beeing held in CDOmBase, the base class of all CDOM classes.
 * You can think of this as a RTTI by hand used to identify a class type without
 * actually using RTTI. This type is a enum constant defined in this enumeration.
 * The type granularity chosen is not the finest one, that is for example, all
 * CDOmStmt subclasses identify themselves as of TYPE_STMT. Finer granularity
 * is achieved by further looking up stmt type that is a enum constant defined
 * in another enumeration inside CDOmStmt (NSCdom::CDOmStmt::EStmtType).
 *
 * @see CDOmBase::getType()
 */


typedef enum _EIncludeFileType {
  FILE_VERILOG,
  FILE_CPLUSPLUS
} EIncludeFileType;

typedef enum _ECDOmType {
  TYPE_ALL_TYPES,               //0
  TYPE_ALL_TOP_LEVELS,          //1
  TYPE_ALL_SCOPE_HOLDERS,       //2
  TYPE_ALL_STMTS,               //3
  TYPE_ALL_FUNC_STMTS,          //4
  TYPE_ALL_MODULE_ITEMS,        //5
  TYPE_ALL_BLOCK_ITEMS,         //6
  TYPE_ALL_TASK_ITEMS,          //7
  TYPE_ALL_FUNC_ITEMS,          //8
  TYPE_ALL_GEN_ITEMS,           //9

  TYPE_DESIGN,                  //10
  TYPE_ID_SIMPLE,               //11
  TYPE_ID_SCOPE_DIRECT,         //12
  TYPE_ID_SCOPE_INDIRECT,       //13
  TYPE_PORT_ITEM,               //14
  TYPE_DECL_MODULE,             //15
  TYPE_DECL_TASK,               //16
  TYPE_DECL_FUNCTION,           //17
  TYPE_SPEC_BLOCK,              //18
  TYPE_DECL_UDP,                //19
  TYPE_EXPR,                    //20
  TYPE_LIST_EXPR,               //21
  TYPE_HID_ITEMS,               //22
  TYPE_ATTR_LIST,               //23
  TYPE_ATTR_LIST_COLLECTION,    //24
  TYPE_STMT,                    //25
  TYPE_STMT_NAMED_BLOCK,        //26
  TYPE_DELAY_CONTROL,           //27
  TYPE_EVENT_CONTROL,           //28
  TYPE_EVENT_EXPR,              //29
  TYPE_RANGE,                   //30
  TYPE_ASSN,                    //31
  TYPE_RANGE_LIST,              //32
  TYPE_RANGE_EXPR,              //33
  TYPE_PARAM_DECL,              //34
  TYPE_PARAM_DECL_COLLECTION,   //35
  TYPE_PORT_DECL,               //36
  TYPE_UDP_PORT_DECL_INPUT,     //37
  TYPE_UDP_PORT_DECL_OUTPUT,    //38
  TYPE_UDP_INIT_STMT,           //39
  TYPE_UDP_COMB_ENTRY,          //40
  TYPE_UDP_SEQ_ENTRY,           //41
  TYPE_TF_PORT_DECL,            //42
  TYPE_VAR_DECL,                //43
  TYPE_DELAY,                   //44
  TYPE_NET_DECL,                //45
  TYPE_PULSE_CONTROL,           //46
  TYPE_EVENT_DECL,              //47
  TYPE_GENVAR_DECL,             //48
  TYPE_GEN_INST,                //49
  TYPE_GEN_ITEM_NULL,           //50
  TYPE_GEN_ITEM_IF,             //51
  TYPE_GEN_ITEM_CASE,           //52
  TYPE_GEN_ITEM_LOOP,           //53
  TYPE_GEN_ITEM_BLOCK_NAMED,    //54
  TYPE_GEN_ITEM_BLOCK_UNNAMED,  //55
  TYPE_PARAM_OVERRIDE,          //56
  TYPE_CONT_ASSN,               //57
  TYPE_INST_GATE,               //58
  TYPE_INST_UDP,                //59
  TYPE_INST_MODULE,             //60
  TYPE_MODULE_INSTANTIATION,    //61
  TYPE_INITIAL_OR_ALWAYS,       //62
  TYPE_PULSESTYLE_SHOWCANCELLED,//63
  TYPE_SPEC_TERM_LIST,          //64
  TYPE_MINTYPMAX_LIST,          //65
  TYPE_PATH_DELAY_VALUE,        //66
  TYPE_SYSTEM_TIMING_CHECK,     //67
  TYPE_DELAYED_DATA_OR_REFERENCE,       //68
  TYPE_TIMING_CHECK_EVENT_CONTROL,      //69
  TYPE_TIMING_CHECK_EVENT,      //70
  TYPE_PATH_DECL,               //71
  TYPE_PRIMITIVE_INSTANCE,      //72
  TYPE_GATE_INSTANTIATION,      //73
  TYPE_COMMENT,                 //74
  TYPE_INCLUDE,                 //75
  TYPE_DEFINE,                  //76
  TYPE_BIT_ARRAY
} ECDOmType;


/**
 * Holds enum constants for all net types.
 */
typedef enum _ECDOmNetType {
  NET_UNDEFINED,
  NET_SUPPLY0,
  NET_SUPPLY1,
  NET_TRI,
  NET_TRIAND,
  NET_TRIOR,
  NET_TRI0,
  NET_TRI1,
  NET_WIRE,
  NET_WAND,
  NET_WOR,
  NET_TRIREG
} ECDOmNetType;

/**
 * Holds enum constants for all variable types.
 */
typedef enum _ECDOmVarType {
  VAR_UNDEFINED,
  VAR_REG,
  VAR_INTEGER,
  VAR_REAL,
  VAR_REALTIME,
  VAR_TIME
} ECDOmVarType;

/**
 * Holds enum constants for port types.
 */
typedef enum _ECDOmPortType {
  PORT_INOUT,
  PORT_INPUT,
  PORT_OUTPUT
} ECDOmPortType;

/**
 * Holds enum constants for drive strenghts.
 */
typedef enum _ECDOmDriveStrength {
  DRIVE_STRENGTH_UNDEFINED = 0x0000,
  DRIVE_STRENGTH_SUPPLY_0  = 0x0001,
  DRIVE_STRENGTH_STRONG_0  = 0x0002,
  DRIVE_STRENGTH_PULL_0    = 0x0004,
  DRIVE_STRENGTH_WEAK_0    = 0x0008,
  DRIVE_STRENGTH_HIGHZ_0   = 0x0010,
  DRIVE_STRENGTH_SUPPLY_1  = 0x0020,
  DRIVE_STRENGTH_STRONG_1  = 0x0040,
  DRIVE_STRENGTH_PULL_1    = 0x0080,
  DRIVE_STRENGTH_WEAK_1    = 0x0100,
  DRIVE_STRENGTH_HIGHZ_1   = 0x0200
} ECDOmDriveStrength;

typedef enum _ECDOmUdpSymbol {
  UDP_SYMBOL_UNDEF = 0x00,

  UDP_SYMBOL_0 = 0x01,
  UDP_SYMBOL_1 = 0x02,
  UDP_SYMBOL_x = 0x03,
  UDP_SYMBOL_X = 0x04,
  UDP_SYMBOL_Q = 0x08, // level symbol "?"
  UDP_SYMBOL_b = 0x10,
  UDP_SYMBOL_B = 0x18,
  UDP_SYMBOL_D = 0x20, // next state symbol "-" dash

  UDP_SYMBOL_MASK_OUTPUT_SYMBOL = 0x07,
  UDP_SYMBOL_MASK_LEVEL_SYMBOL  = 0x1F,
  UDP_SYMBOL_MASK_NEXT_STATE    = 0x27,
} ECDOmUdpSymbol;

#define DRIVE_STRENGTH_0_MASK 0x001F
#define DRIVE_STRENGTH_1_MASK 0x03E0

//added by Tb
#define VERINUM_BLOCK_SIZE ((sizeof(TInt) * 8) / 2)
//~added by Tb

//template<class T>
//inline void stupidValidator( const boost::shared_ptr<T>& ) { }

// ********************************************************************************
// CDOM classes predeclaration
// ********************************************************************************
//template<ECDOmType listType, class T, void (*validate)(const boost::shared_ptr<T>&) = stupidValidator<T> > class CDOmList;

class CDOmBase;
class CDOmInclude;
class CDOmComment;
class CDOmDefine;
class CDOmAttrHolder;
class CDOmIdentifier;
class CDOmScope;
class CDOmExpr;
class CDOmExprLink;
class CDOmExprOp;
class CDOmExprConcat;
class CDOmExprMultiConcat;
class CDOmAttrList;
class CDOmAttrListCollection;
class CDOmStmt;
class CDOmStmtAssn;
class CDOmDelayControl;
class CDOmEventControl;
class CDOmEventExpr;
class CDOmStmtCase;
class CDOmStmtIf;
class CDOmStmtDisable;
class CDOmStmtEventTrigger;
class CDOmStmtLoop;
class CDOmStmtBlock;
class CDOmAssn;
class CDOmStmtProcContAssn;
class CDOmStmtProcTimingControl;
class CDOmStmtTaskEnable;
class CDOmStmtWait;
class CDOmRange;
class CDOmRangeExpr;
class CDOmParamDecl;
class CDOmPulseControl;
class CDOmParamDeclCollection;
class CDOmPortDecl;
class CDOmUdpPortDeclOutput;
class CDOmUdpPortDeclInput;
class CDOmPortItem;
class CDOmModuleDecl;
class CDOmUdpDecl;
class CDOmUdpInitStmt;
class CDOmUdpCombEntry;
class CDOmUdpSeqEntry;
class CDOmTFPortDecl;
class CDOmTaskDecl;
class CDOmFuncDecl;
class CDOmVarDecl;
class CDOmMinTypMax;
class CDOmDelay;
class CDOmNetDecl;
class CDOmEventDecl;
class CDOmGenvarDecl;
class CDOmParamOverride;
class CDOmContAssn;
class CDOmModuleOrUdpInstance;
class CDOmModuleOrUdpInstantiation;
class CDOmInitOrAlways;
class CDOmSpecifyBlock;
class CDOmPulseStyleOrShowCancelledDecl;
class CDOmGenInst;
class CDOmGenItemNull;
class CDOmGenItemIf;
class CDOmGenItemCase;
class CDOmGenItemLoop;
class CDOmGenItemBlock;
class CDOmFunctionCall;
class CDOmDesign;
class CDOmPathDelayValue;
class CDOmSystemTimingCheck;
class CDOmDelayedDataOrReference;
class CDOmTimingCheckEventControl;
class CDOmTimingCheckEvent;
class CDOmPathDecl;
class CDOmGateInstantiation;

class CDOmListExpr;
class CDOmRangeList;
class CDOmSpecifyTerminalList;
class CDOmMinTypMaxList;

class CDOmEvalRes;
class CDOmNumber;
class CDOmNum32;
class CDOmVeriNum;
class CDOmBitArray;
class CDOmReal;
class CDOmString;

// ********************************************************************************
// RefCount typedefs - PART 1
// ********************************************************************************
typedef boost::shared_ptr<CDOmBase>                          RefCDOmBase;
typedef boost::shared_ptr<CDOmInclude>                       RefCDOmInclude;
typedef boost::shared_ptr<CDOmComment>                       RefCDOmComment;
typedef boost::shared_ptr<CDOmDefine>                        RefCDOmDefine;
typedef boost::shared_ptr<CDOmAttrHolder>                    RefCDOmAttrHolder;
typedef boost::shared_ptr<CDOmIdentifier>                    RefCDOmIdentifier;
typedef boost::shared_ptr<CDOmScope>                         RefCDOmScope;
typedef boost::shared_ptr<CDOmExpr>                          RefCDOmExpr;
typedef boost::shared_ptr<CDOmExprLink>                      RefCDOmExprLink;
typedef boost::shared_ptr<CDOmExprOp>                        RefCDOmExprOp;
typedef boost::shared_ptr<CDOmExprConcat>                    RefCDOmExprConcat;
typedef boost::shared_ptr<CDOmExprMultiConcat>               RefCDOmExprMultiConcat;
typedef boost::shared_ptr<CDOmAttrList>                      RefCDOmAttrList;
typedef boost::shared_ptr<CDOmAttrListCollection>            RefCDOmAttrListCollection;
typedef boost::shared_ptr<CDOmStmt>                          RefCDOmStmt;
typedef boost::shared_ptr<CDOmStmtAssn>                      RefCDOmStmtAssn;
typedef boost::shared_ptr<CDOmDelayControl>                  RefCDOmDelayControl;
typedef boost::shared_ptr<CDOmEventControl>                  RefCDOmEventControl;
typedef boost::shared_ptr<CDOmEventExpr>                     RefCDOmEventExpr;
typedef boost::shared_ptr<CDOmStmtCase>                      RefCDOmStmtCase;
typedef boost::shared_ptr<CDOmStmtIf>                        RefCDOmStmtIf;
typedef boost::shared_ptr<CDOmStmtDisable>                   RefCDOmStmtDisable;
typedef boost::shared_ptr<CDOmStmtEventTrigger>              RefCDOmStmtEventTrigger;
typedef boost::shared_ptr<CDOmStmtLoop>                      RefCDOmStmtLoop;
typedef boost::shared_ptr<CDOmStmtBlock>                     RefCDOmStmtBlock;
typedef boost::shared_ptr<CDOmAssn>                          RefCDOmAssn;
typedef boost::shared_ptr<CDOmStmtProcContAssn>              RefCDOmStmtProcContAssn;
typedef boost::shared_ptr<CDOmStmtProcTimingControl>         RefCDOmStmtProcTimingControl;
typedef boost::shared_ptr<CDOmStmtTaskEnable>                RefCDOmStmtTaskEnable;
typedef boost::shared_ptr<CDOmStmtWait>                      RefCDOmStmtWait;
typedef boost::shared_ptr<CDOmRange>                         RefCDOmRange;
typedef boost::shared_ptr<CDOmRangeExpr>                     RefCDOmRangeExpr;
typedef boost::shared_ptr<CDOmParamDecl>                     RefCDOmParamDecl;
typedef boost::shared_ptr<CDOmPulseControl>                  RefCDOmPulseControl;
typedef boost::shared_ptr<CDOmParamDeclCollection>           RefCDOmParamDeclCollection;
typedef boost::shared_ptr<CDOmPortDecl>                      RefCDOmPortDecl;
typedef boost::shared_ptr<CDOmUdpPortDeclOutput>             RefCDOmUdpPortDeclOutput;
typedef boost::shared_ptr<CDOmUdpPortDeclInput>              RefCDOmUdpPortDeclInput;
typedef boost::shared_ptr<CDOmPortItem>                      RefCDOmPortItem;
typedef boost::shared_ptr<CDOmModuleDecl>                    RefCDOmModuleDecl;
typedef boost::shared_ptr<CDOmUdpDecl>                       RefCDOmUdpDecl;
typedef boost::shared_ptr<CDOmUdpInitStmt>                   RefCDOmUdpInitStmt;
typedef boost::shared_ptr<CDOmUdpCombEntry>                  RefCDOmUdpCombEntry;
typedef boost::shared_ptr<CDOmUdpSeqEntry>                   RefCDOmUdpSeqEntry;
typedef boost::shared_ptr<CDOmTFPortDecl>                    RefCDOmTFPortDecl;
typedef boost::shared_ptr<CDOmTaskDecl>                      RefCDOmTaskDecl;
typedef boost::shared_ptr<CDOmFuncDecl>                      RefCDOmFuncDecl;
typedef boost::shared_ptr<CDOmVarDecl>                       RefCDOmVarDecl;
typedef boost::shared_ptr<CDOmMinTypMax>                     RefCDOmMinTypMax;
typedef boost::shared_ptr<CDOmDelay>                         RefCDOmDelay;
typedef boost::shared_ptr<CDOmNetDecl>                       RefCDOmNetDecl;
typedef boost::shared_ptr<CDOmEventDecl>                     RefCDOmEventDecl;
typedef boost::shared_ptr<CDOmGenvarDecl>                    RefCDOmGenvarDecl;
typedef boost::shared_ptr<CDOmParamOverride>                 RefCDOmParamOverride;
typedef boost::shared_ptr<CDOmContAssn>                      RefCDOmContAssn;
typedef boost::shared_ptr<CDOmModuleOrUdpInstance>           RefCDOmModuleOrUdpInstance;
typedef boost::shared_ptr<CDOmModuleOrUdpInstantiation>      RefCDOmModuleOrUdpInstantiation;
typedef boost::shared_ptr<CDOmInitOrAlways>                  RefCDOmInitOrAlways;
typedef boost::shared_ptr<CDOmSpecifyBlock>                  RefCDOmSpecifyBlock;
typedef boost::shared_ptr<CDOmPulseStyleOrShowCancelledDecl> RefCDOmPulseStyleOrShowCancelledDecl;
typedef boost::shared_ptr<CDOmGenInst>                       RefCDOmGenInst;
typedef boost::shared_ptr<CDOmGenItemNull>                   RefCDOmGenItemNull;
typedef boost::shared_ptr<CDOmGenItemIf>                     RefCDOmGenItemIf;
typedef boost::shared_ptr<CDOmGenItemCase>                   RefCDOmGenItemCase;
typedef boost::shared_ptr<CDOmGenItemLoop>                   RefCDOmGenItemLoop;
typedef boost::shared_ptr<CDOmGenItemBlock>                  RefCDOmGenItemBlock;
typedef boost::shared_ptr<CDOmFunctionCall>                  RefCDOmFunctionCall;
typedef boost::shared_ptr<CDOmDesign>                        RefCDOmDesign;
typedef boost::shared_ptr<CDOmPathDelayValue>                RefCDOmPathDelayValue;
typedef boost::shared_ptr<CDOmSystemTimingCheck>             RefCDOmSystemTimingCheck;
typedef boost::shared_ptr<CDOmDelayedDataOrReference>        RefCDOmDelayedDataOrReference;
typedef boost::shared_ptr<CDOmTimingCheckEventControl>       RefCDOmTimingCheckEventControl;
typedef boost::shared_ptr<CDOmTimingCheckEvent>              RefCDOmTimingCheckEvent;
typedef boost::shared_ptr<CDOmPathDecl>                      RefCDOmPathDecl;
typedef boost::shared_ptr<CDOmGateInstantiation>             RefCDOmGateInstantiation;

typedef boost::shared_ptr<CVeriNum>                          RefCVeriNum;
typedef boost::shared_ptr<CRealNum>                          RefCRealNum;
typedef boost::shared_ptr<CDOmEvalRes>                       RefCDOmEvalRes;
typedef boost::shared_ptr<CDOmNumber>                        RefCDOmNumber;
typedef boost::shared_ptr<CDOmVeriNum>                       RefCDOmVeriNum;
typedef boost::shared_ptr<CDOmBitArray>                      RefCDOmBitArray;
typedef boost::shared_ptr<CDOmNum32>                         RefCDOmNum32;
typedef boost::shared_ptr<CDOmReal>                          RefCDOmReal;
typedef boost::shared_ptr<CDOmString>                        RefCDOmString;


// ********************************************************************************
// CDOmList validator methods
// ********************************************************************************
void validateSpecifyTerminal(const RefCDOmExprLink& item);

//typedef CDOmList<TYPE_LIST_EXPR, CDOmExpr> CDOmExprList;
//typedef CDOmList<TYPE_RANGE_LIST, CDOmRange> CDOmRangeList;
//typedef CDOmList<TYPE_SPEC_TERM_LIST, CDOmExprLink, validateSpecifyTerminal> CDOmSpecifyTerminalList;
//typedef CDOmList<TYPE_MINTYPMAX_LIST, CDOmMinTypMax>                         CDOmMinTypMaxList;

typedef boost::shared_ptr<CDOmListExpr>                      RefCDOmListExpr;
typedef boost::shared_ptr<CDOmRangeList>                     RefCDOmRangeList;
typedef boost::shared_ptr<CDOmSpecifyTerminalList>           RefCDOmSpecifyTerminalList;
typedef boost::shared_ptr<CDOmMinTypMaxList>                 RefCDOmMinTypMaxList;


// ********************************************************************************
// class type functors
// ********************************************************************************
struct less_RefString {
    TBool operator() (const RefString& s1, const RefString& s2) const;
};

// ********************************************************************************
// container and interator types typedefs
// ********************************************************************************
  // moved to support/Typedefs.h typedef std::vector<RefString>                  TVec_RefString;             // vector of RefString
typedef std::vector<RefCDOmBase>                TVec_RefCDOmBase;           // vector of RefCDOmBase
typedef std::vector<RefCDOmComment>             TVec_RefCDOmComment;        // vector of RefCDOmComment
typedef std::vector<RefCDOmIdentifier>          TVec_RefCDOmIdentifier;     // vector of RefCDOmIdentifier
typedef std::vector<RefCDOmExpr>                TVec_RefCDOmExpr;           // vector of RefCDOmExpr
typedef std::vector<RefCDOmExprLink>            TVec_RefCDOmExprLink;       // vector of RefCDOmExprLink
typedef std::vector<RefCDOmAttrList>            TVec_RefCDOmAttrList;       // vector of RefCDOmAttrList
typedef std::vector<RefCDOmStmt>                TVec_RefCDOmStmt;           // vector of RefCDOmStmt
typedef std::vector<RefCDOmStmtAssn>            TVec_RefCDOmStmtAssn;       // vector of RefCDOmStmt
typedef std::vector<RefCDOmAssn>                TVec_RefCDOmAssn;           // vector of RefCDOmAssn
typedef std::vector<RefCDOmRange>               TVec_RefCDOmRange;          // vector of RefCDOmRange
typedef std::vector<RefCDOmParamDecl>           TVec_RefCDOmParamDecl;      // vector of RefCDOmParamDecl
typedef std::vector<RefCDOmPulseControl>        TVec_RefCDOmPulseControl;   // vector of RefCDOmPulseControl
typedef std::vector<RefCDOmPortDecl>            TVec_RefCDOmPortDecl;       // vector of RefCDOmPortDecl
typedef std::vector<RefCDOmPortItem>            TVec_RefCDOmPortItem;       // vector of RefCDOmPortItem
typedef std::vector<RefCDOmModuleDecl>          TVec_RefCDOmModuleDecl;     // vector of RefCDOmModuleDecl
typedef std::vector<RefCDOmUdpDecl>             TVec_RefCDOmUdpDecl;        // vector of RefCDOmUdpDecl
typedef std::vector<RefCDOmModuleOrUdpInstance> TVec_RefCDOmModuleOrUdpInstance; // vector of RefCDOmModuleOrUdpInstance
typedef std::vector<RefCDOmMinTypMax>           TVec_RefCDOmMinTypMax;      // vector of RefCDOmMinTypMax
typedef std::vector<ECDOmUdpSymbol>             TVec_ECDOmUdpSymbol;        // vector of ECDOmUdpSymbol
// typedef std::vector<TInt>                       TVec_TInt;      
// typedef std::vector<TUInt>                      TVec_TUInt;      

typedef std::pair<RefString, RefCDOmIdentifier> TPair_RefString_RefCDOmIdentifier;
typedef std::pair<RefString, RefCDOmExpr>       TPair_RefString_RefCDOmExpr;
typedef std::pair<RefString, RefCDOmExprLink>   TPair_RefString_RefCDOmExprLink;
typedef std::pair<RefString, RefCDOmPortItem>   TPair_RefString_RefCDOmPortItem;
typedef std::pair<RefString, RefCDOmMinTypMax>  TPair_RefString_RefCDOmMinTypMax;
typedef std::pair<RefString, RefCDOmBase>       TPair_RefString_RefCDOmBase;

typedef std::map<RefString, RefCDOmIdentifier, less_RefString>      TMap_RefString_RefCDOmIdentifier;
typedef std::multimap<RefString, RefCDOmIdentifier, less_RefString> TMultiMap_RefString_RefCDOmIdentifier;
typedef std::map<RefString, RefCDOmExpr, less_RefString>            TMap_RefString_RefCDOmExpr;
typedef std::multimap<RefString, RefCDOmExpr, less_RefString>       TMultiMap_RefString_RefCDOmExpr;
typedef std::map<RefString, RefCDOmExprLink, less_RefString>        TMap_RefString_RefCDOmExprLink;
typedef std::map<RefString, RefCDOmPortItem, less_RefString>        TMap_RefString_RefCDOmPortItem;
typedef std::map<RefString, RefCDOmMinTypMax, less_RefString>       TMap_RefString_RefCDOmMinTypMax;
typedef std::map<RefString, RefCDOmBase, less_RefString>            TMap_RefString_RefCDOmBase;

  // moved to support/Typedefs.h typedef TVec_RefString::const_iterator                  TVec_RefString_const_iter;
typedef TVec_RefCDOmBase::const_iterator                TVec_RefCDOmBase_const_iter;
typedef TVec_RefCDOmComment::const_iterator             TVec_RefCDOmComment_const_iter;
typedef TVec_RefCDOmIdentifier::const_iterator          TVec_RefCDOmIdentifier_const_iter;
typedef TVec_RefCDOmExpr::const_iterator                TVec_RefCDOmExpr_const_iter;
typedef TVec_RefCDOmExprLink::const_iterator            TVec_RefCDOmExprLink_const_iter;
typedef TVec_RefCDOmAttrList::const_iterator            TVec_RefCDOmAttrList_const_iter;
typedef TVec_RefCDOmStmt::const_iterator                TVec_RefCDOmStmt_const_iter;
typedef TVec_RefCDOmAssn::const_iterator                TVec_RefCDOmAssn_const_iter;
typedef TVec_RefCDOmRange::const_iterator               TVec_RefCDOmRange_const_iter;
typedef TVec_RefCDOmParamDecl::const_iterator           TVec_RefCDOmParamDecl_const_iter;
typedef TVec_RefCDOmPulseControl::const_iterator        TVec_RefCDOmPulseControl_const_iter;
typedef TVec_RefCDOmPortDecl::const_iterator            TVec_RefCDOmPortDecl_const_iter;
typedef TVec_RefCDOmPortItem::const_iterator            TVec_RefCDOmPortItem_const_iter;
typedef TVec_RefCDOmModuleDecl::const_iterator          TVec_RefCDOmModuleDecl_const_iter;
typedef TVec_RefCDOmUdpDecl::const_iterator             TVec_RefCDOmUdpDecl_const_iter;
typedef TVec_RefCDOmModuleOrUdpInstance::const_iterator TVec_RefCDOmModuleOrUdpInstance_const_iter;
typedef TVec_RefCDOmMinTypMax::const_iterator           TVec_RefCDOmMinTypMax_const_iter;
typedef TVec_ECDOmUdpSymbol::const_iterator             TVec_ECDOmUdpSymbol_const_iter;
//typedef TVec_TInt::const_iterator                       TVec_TInt_const_iter;
//typedef TVec_TUInt::const_iterator                      TVec_TUInt_const_iter;

typedef TMap_RefString_RefCDOmIdentifier::const_iterator      TMap_RefString_RefCDOmIdentifier_constIter;
typedef TMultiMap_RefString_RefCDOmIdentifier::const_iterator TMultiMap_RefString_RefCDOmIdentifier_constIter;
typedef TMap_RefString_RefCDOmExpr::const_iterator            TMap_RefString_RefCDOmExpr_constIter;
typedef TMultiMap_RefString_RefCDOmExpr::const_iterator       TMultiMap_RefString_RefCDOmExpr_constIter;
typedef TMap_RefString_RefCDOmPortItem::const_iterator        TMap_RefString_RefCDOmPortItem_constIter;
typedef TMap_RefString_RefCDOmMinTypMax::const_iterator       TMap_RefString_RefCDOmMinTypMax_constIter;
typedef TMap_RefString_RefCDOmBase::const_iterator            TMap_RefString_RefCDOmBase_constIter;

typedef TVec_RefCDOmBase::size_type TVec_RefCDOmBase_size_type;
typedef std::vector<TVec_RefCDOmBase_size_type> TVec_TVec_RefCDOmBase_size_type;

// ********************************************************************************
// RefCount typedefs - PART 2
// ********************************************************************************
  // moved to support/Typedefs.h typedef boost::shared_ptr<TVec_RefString>                  RefTVec_RefString;
typedef boost::shared_ptr<TVec_RefCDOmBase>                RefTVec_RefCDOmBase;
typedef boost::shared_ptr<TVec_RefCDOmComment>             RefTVec_RefCDOmComment;
typedef boost::shared_ptr<TVec_RefCDOmIdentifier>          RefTVec_RefCDOmIdentifier;
typedef boost::shared_ptr<TVec_RefCDOmExpr>                RefTVec_RefCDOmExpr;
typedef boost::shared_ptr<TVec_RefCDOmRange>               RefTVec_RefCDOmRange;
typedef boost::shared_ptr<TVec_RefCDOmExprLink>            RefTVec_RefCDOmExprLink;
typedef boost::shared_ptr<TVec_RefCDOmAttrList>            RefTVec_RefCDOmAttrList;
typedef boost::shared_ptr<TVec_RefCDOmStmt>                RefTVec_RefCDOmStmt;
typedef boost::shared_ptr<TVec_RefCDOmStmtAssn>            RefTVec_RefCDOmStmtAssn;
typedef boost::shared_ptr<TVec_RefCDOmAssn>                RefTVec_RefCDOmAssn;
typedef boost::shared_ptr<TVec_RefCDOmParamDecl>           RefTVec_RefCDOmParamDecl;
typedef boost::shared_ptr<TVec_RefCDOmPulseControl>        RefTVec_RefCDOmPulseControl;
typedef boost::shared_ptr<TVec_RefCDOmPortDecl>            RefTVec_RefCDOmPortDecl;
typedef boost::shared_ptr<TVec_RefCDOmModuleDecl>          RefTVec_RefCDOmModuleDecl;
typedef boost::shared_ptr<TVec_RefCDOmPortItem>            RefTVec_RefCDOmPortItem;
typedef boost::shared_ptr<TVec_RefCDOmUdpDecl>             RefTVec_RefCDOmUdpDecl;
typedef boost::shared_ptr<TVec_RefCDOmModuleOrUdpInstance> RefTVec_RefCDOmModuleOrUdpInstance;
typedef boost::shared_ptr<TVec_RefCDOmMinTypMax>           RefTVec_RefCDOmMinTypMax;
typedef boost::shared_ptr<TVec_ECDOmUdpSymbol>             RefTVec_ECDOmUdpSymbol;
//typedef boost::shared_ptr<TVec_TInt>                       RefTVec_TInt;
//typedef boost::shared_ptr<TVec_TUInt>                      RefTVec_TUInt;
typedef boost::shared_ptr<TVec_TVec_RefCDOmBase_size_type> RefTVec_TVec_RefCDOmBase_size_type;

typedef boost::shared_ptr<TMap_RefString_RefCDOmIdentifier>      RefTMap_RefString_RefCDOmIdentifier;
typedef boost::shared_ptr<TMultiMap_RefString_RefCDOmIdentifier> RefTMultiMap_RefString_RefCDOmIdentifier;
typedef boost::shared_ptr<TMap_RefString_RefCDOmExpr>            RefTMap_RefString_RefCDOmExpr;
typedef boost::shared_ptr<TMultiMap_RefString_RefCDOmExpr>       RefTMultiMap_RefString_RefCDOmExpr;
typedef boost::shared_ptr<TMap_RefString_RefCDOmExprLink>        RefTMap_RefString_RefCDOmExprLink;
typedef boost::shared_ptr<TMap_RefString_RefCDOmPortItem>        RefTMap_RefString_RefCDOmPortItem;
typedef boost::shared_ptr<TMap_RefString_RefCDOmMinTypMax>       RefTMap_RefString_RefCDOmMinTypMax;
typedef boost::shared_ptr<TMap_RefString_RefCDOmBase>            RefTMap_RefString_RefCDOmBase;


// ********************************************************************************
// global variables
// ********************************************************************************
extern const TChar DOT;
// ********************************************************************************
// global functions
// ********************************************************************************

/**
 * Checks if the parameter passed in is a valid simple identifier.
 *
 * @param name the name to be checked
 */
TBool checkIdName(const RefString& name, TLineNumberType lineNumber);

void checkDriveStrength(ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength);

// ********************************************************************************
// CDOmBase class
// ********************************************************************************
/**
 * This is the base class for all CDOM classes (except CDOmScope).
 * It is used to hold the raw type (ECDOmType) of a class, the parent and the children objects.
 * It provides core mechanisms for self registration, automatic parent scope lookup, caching
 * and performance optimization.
 * Once a child is set the reverse link, from child to parent, is automaticaly updated
 * so you can navigate each way you want. This is like a double link relation.
 */
class CDOmBase {
  private:
    RefCDOmBase getThis() const { return m_weakRef.lock(); }
    mutable boost::weak_ptr<CDOmScope> m_cachedParentScope; // cached parent scope

  protected:
    // self weak reference
    boost::weak_ptr<CDOmBase> m_weakRef;
    ECDOmType m_type;
    boost::weak_ptr<CDOmBase> m_parent;
    RefTVec_RefCDOmBase m_children;
    TLineNumberType m_lineNumber; 
    RefString m_fileName;

    CDOmBase(ECDOmType type, TLineNumberType lineNumber, RefString fileName = RefString());

    static RefCDOmScope getAttachedScope(const CDOmBase* base);

    void addChild(const RefCDOmBase& child);

  public:
    virtual ~CDOmBase();
  
    //TODO: implement file name support in CDOM
    RefString getFileName() const { return m_fileName; }

    void checkIndex(TInt index) {
      ASSERT(m_children.get() && m_children->size() > index, "index out of range");
    }

    const RefCDOmBase getChild(TInt index) const {
      //ASSERT(index < m_children->size(), "Index out of range");
#ifndef __RLEASE_VERSION
      return m_children->at(index);
#else
      return m_children[index];
#endif
    }
  
    const RefCDOmBase getChild(ECDOmType type, TInt index) const; 
  
    const TInt getChildrenSize() const;
    /**
     * Returns the raw type of this object.
     *
     * @return the raw type of this object
     * @see ECDOmType
     */
    ECDOmType getType() const;
    std::string getTypeString() const;

    /**
     * Returns true if this object is a top level object, that is his raw type is one of: <br/>
     *   - TYPE_DECL_MODULE <br/>
     *   - TYPE_DECL_UDP <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the top level status of this object
     * @see ECDOmType
     * @see getType()
     */
    TBool isTopLevel() const;

    /**
     * Returns true if this object is a scope holder object, that is his raw type is one of: <br/>
     *   - TYPE_DESIGN <br/>
     *   - TYPE_DECL_MODULE <br/>
     *   - TYPE_DECL_TASK <br/>
     *   - TYPE_DECL_FUNCTION <br/>
     *   - TYPE_STMT_NAMED_BLOCK <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the scope status of this object
     * @see ECDOmType
     * @see getType()
     */
    TBool isScopeHolder() const;

    /**
     * Returns true if this object is an identifier that points directly or indirectly to a scope object,
     * that is his raw type is one of: <br/>
     *   - TYPE_ID_SCOPE_DIRECT <br/>
     *   - TYPE_ID_SCOPE_INDIRECT <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the to scope status of this object
     * @see ECDOmType
     * @see getType()
     */
    TBool isToScopeID() const;

    /**
     * Returns true if this object is an identifier, that is his raw type is one of: <br/>
     *   - TYPE_ID_SIMPLE <br/>
     *   - TYPE_ID_SCOPE_DIRECT <br/>
     *   - TYPE_ID_SCOPE_INDIRECT <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the identifier status of this object
     * @see ECDOmType
     * @see getType()
     */
    TBool isID() const;

    /**
     * Returns true if this object is a statement, that is his raw type is one of: <br/>
     *   - TYPE_STMT <br/>
     *   - TYPE_STMT_NAMED_BLOCK <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the statement status of this object
     * @see ECDOmType
     * @see getType()
     */
    TBool isStmt() const;

    /**
     * Returns true if this object is a function statement, that is his raw type is TYPE_STMT
     * but with some exceptions or false otherwhise. <br/> <br/>
     *
     * <b>PDF SPEC 10.3.4: Function rules</b> <br/>
     * Functions are more limited than tasks. The following rules govern their usage: <br/>
     * a) A function definition shall not contain any time-controlled statements - that is, any statements
     * containing #, @, or wait. <br/>
     * b) Functions shall not enable tasks. <br/>
     * c) A function definition shall contain at least one input argument. <br/>
     * d) A function definition shall not have any argument declared as output or inout. <br/>
     * e) A function shall not have any nonblocking assignments or procedural continuous assignments. <br/>
     * f) A function shall not have any event triggers. <br/> <br/>
     *
     * @return true or false, depending on the function statement status of this object
     * @see ECDOmType
     * @see getType()
     */
    TBool isFuncStmt() const;

    /**
     * Returns true if this object is a module item, that is his raw type is one of: <br/>
     *   - TYPE_PORT_DECL <br/>
     *   - TYPE_NET_DECL <br/>
     *   - TYPE_VAR_DECL <br/>
     *   - TYPE_EVENT_DECL <br/>
     *   - TYPE_GENVAR_DECL <br/>
     *   - TYPE_DECL_TASK <br/>
     *   - TYPE_DECL_FUNCTION <br/>
     *   - TYPE_PARAM_OVERRIDE <br/>
     *   - TYPE_CONT_ASSN <br/>
     *   - TYPE_INST_GATE <br/>
     *   - TYPE_INST_UDP <br/>
     *   - TYPE_INST_MODULE <br/>
     *   - TYPE_INITIAL_OR_ALWAYS <br/>
     *   - TYPE_SPEC_BLOCK <br/>
     *   - TYPE_GENERATED_INST <br/>
     *   - TYPE_PARAM_DECL <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the module item status of this object
     * @see ECDOmType
     * @see getType()
     */
    TBool isModuleItem() const;

    /**
     * Returns true if this object is a block item, that is his raw type is one of: <br/>
     *   - TYPE_VAR_DECL <br/>
     *   - TYPE_EVENT_DECL <br/>
     *   - TYPE_PARAM_DECL (of subtype CDOmParamDecl::PARAM_DECL_SIMPLE or CDOmParamDecl::PARAM_DECL_LOCAL) <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the block item status of this object
     * @see ECDOmType
     * @see CDOmParamDecl::EParamDeclType
     * @see getType()
     * @see CDOmParamDecl::getParamDeclType()
     */
    TBool isBlockItem() const;

    /**
     * Returns true if this object is a block item or his raw type is TYPE_TF_PORT_DECL
     * or false otherwhise.
     *
     * @return true or false, depending on the task item status of this object
     * @see isBlockItem()
     * @see ECDOmType
     * @see getType()
     */
    TBool isTaskItem() const;

    /**
     * Returns true if this object is a block item or his raw type is TYPE_TF_PORT_DECL
     * (of subtype ECDOmPortType::PORT_INPUT) or false otherwhise.
     *
     * @return true or false, depending on the func item status of this object
     * @see isBlockItem()
     * @see ECDOmType
     * @see ECDOmPortType
     * @see getType()
     * @see CDOmTFPortDecl::getPortType()
     */
    TBool isFuncItem() const;

    /**
     * Returns true if this object is generate item, or false otherwise
     */
    TBool isGenerateItem() const;

    void setParent(RefCDOmBase parent);

    /**
     * Returns the nearest parent scope up in the scope hierarchy.
     * If there is no upper scope this method returns null, that is calling get() on returned object returns 0. <br/>
     * <b>NOTE: </b>for performance reasons, this method also triggers the update of m_cachedParentScope member
     * on all m_parents up in the hierarchy.
     *
     * @return the parent scope
     */
    RefCDOmScope getParentScope() const;

    RefCDOmBase getParent() const;

    /**
     * This is a template function that returns a vector of specified template type;
     * this vector contains all children that meet the specified type filter criterion.
     *
     * @param typeFilter [=TYPE_ALL_TYPES] the type filter that any child has to met in
     * order to be included in the returned vector
     *
     * @return a vector of children filtered by the specified type filter criterion
     * @see ECDOmType
     */
    template<class T> const boost::shared_ptr<std::vector<boost::shared_ptr<T> > >
      getChildren(ECDOmType typeFilter = TYPE_ALL_TYPES) const;

    //extern template const RefTVec_RefCDOmRange getChildren<CDOmRange>(ECDOmType) const ;
    /**
     * Returns a vector of type base pointers of all children that meet the specified
     * type filter criterion.
     *
     * @param typeFilter [=TYPE_ALL_TYPES] the type filter that any child has to met in
     * order to be included in the returned vector
     *
     * @return a vector of children filtered by the specified type filter criterion
     * @see ECDOmType
     */
    const RefTVec_RefCDOmBase getChildrenAsBase(ECDOmType typeFilter = TYPE_ALL_TYPES) const;

    /**
     * This function returns a vector of all children NOT having the type specified
     */
    const RefTVec_RefCDOmBase getExclusiveChildrenAsBase(ECDOmType typeFilter) const;

    /**
     * This function returns a vector of all children NOT having the type specified
     */
    const RefTVec_RefCDOmBase getTwoExclusiveChildrenAsBase(ECDOmType typeFilterA, ECDOmType typeFilterB) const;

    /**
     * This function returns the number of the line the class was mapped on
     */
    TULong getLineNumber() const;

    /**
     * Visitor pattern function.
     *
     * @param visitor the visitor to visit this object
     *
     */
    virtual void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmComment class
// ********************************************************************************
class CDOmComment: public CDOmBase {
  public:
    enum ECommentType {
      TYPE_UNDEF,
      TYPE_SLASH_SLASH,
      TYPE_SLASH_STAR
    };

  private:
    RefTVec_RefString m_commentText;
    ECommentType m_commentType;
    //used to prevent the user from calling addCommentLine() for a TYPE_SLASH_SLASH comment
    TBool m_isAtLeastOneLineLong;

    CDOmComment(TLineNumberType lineNumber, ECommentType commentType);
    RefCDOmComment getThis() const { return boost::static_pointer_cast<CDOmComment>(m_weakRef.lock()); }

  public:
    static RefCDOmComment build(TLineNumberType lineNumber, RefCDOmBase parent, ECommentType commentType, RefString commentLine);
    void addCommentLine(RefString commentLine);
    const RefString getCommentLine(TInt index = 0) const;
    const RefTVec_RefString getCommentText() const;
    const ECommentType getCommentType() const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};
// ********************************************************************************
// CDOmInclude class
// ********************************************************************************
class CDOmInclude : public CDOmBase {
  private:
    RefCDOmInclude getThis() const { return boost::static_pointer_cast<CDOmInclude>(m_weakRef.lock()); }
    RefString m_fileName;
    EIncludeFileType m_fileType;
    CDOmInclude(TLineNumberType, EIncludeFileType, RefString);
  public:
    static RefCDOmInclude build(TLineNumberType, RefCDOmBase, EIncludeFileType, RefString);
    const RefString getFileName() const;
    const EIncludeFileType getFileType() const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmDefine class
// ********************************************************************************
/**
 * This class models `define and `undef statements according to the following rule:
 * `define text_macro_name macro_text
 * and
 * `undef text_macro_identifier
 * WARNING: List of formal arguments not implemented
 */
class CDOmDefine : public CDOmBase {
  public:
    enum EDefineType {
      DEFINE_TYPE_DEFINE,
      DEFINE_TYPE_UNDEF
    };
  private:
    RefCDOmDefine getThis() const { return boost::static_pointer_cast<CDOmDefine>(m_weakRef.lock());  }
    //identifier
    RefString m_textMacroName;
    EDefineType m_defineType;
    CDOmDefine(TLineNumberType lineNumber, EDefineType defineType, const RefString& textMacroName);
  public:
    static RefCDOmDefine build(TLineNumberType lineNumber, RefCDOmBase parent, EDefineType type, RefString textMacroName, RefCDOmExpr macroText = RefCDOmExpr());
    static RefCDOmDefine cast (RefCDOmBase object);
    const RefString getMacroName() const;
    const EDefineType getDefineType() const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmAttrHolder class
// ********************************************************************************
/**
 * This class provides a common base to all CDOM classes that can be attached with
 * an attribute list collection (CDOmAttrListCollection) according to the grammar rules.
 */
class CDOmAttrHolder : public CDOmBase {
  private:
    RefCDOmAttrHolder getThis() const { return boost::static_pointer_cast<CDOmAttrHolder>(m_weakRef.lock());  }
    RefCDOmAttrListCollection m_attrListCollection;

  protected:
    CDOmAttrHolder(TLineNumberType lineNumber, ECDOmType type);

  public:

    /**
     * Attaches the passed in attrListCollection to this holder. If a attribute list collection
     * was already attached an exception is thrown.
     *
     * @param attrListCollection the attribute list collection to be attached to this holder
     * @see CDOmAttrList
     * @see CDOmAttrListCollection
     */
    void setAttrListCollection(RefCDOmAttrListCollection& attrListCollection);

    /**
     * Returns the attribute list collection attached to this holder.
     * If no attribute list collection is attached to this holder a null attribute list collection is returned,
     * that is calling get() on returned object returns 0.
     *
     * @return the attached attribute list collection or null if no attribute list collection is attached to this holder
     */
    RefCDOmAttrListCollection getAttrListCollection() const;
};

// ********************************************************************************
// CDOmIdentifier class
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
class CDOmIdentifier : public CDOmBase {
  public:
    /**
     * Holds enum constants for drive identifier types.
     */
    enum EIdType {
      ID_MODULE               = 0x00000001,
      ID_UDP                  = 0x00000002,
      ID_TASK                 = 0x00000004,
      ID_FUNCTION             = 0x00000008,
      ID_NAMED_BLOCK          = 0x00000010,
      ID_ATTR                 = 0x00000020,
      ID_PARAM                = 0x00000040,
      ID_PORT                 = 0x00000080,
      ID_TF_PORT              = 0x00000100,
      ID_NET                  = 0x00000200,
      ID_VAR                  = 0x00000400,
      ID_EVENT                = 0x00000800,
      ID_GENVAR               = 0x00001000,
      ID_MODULE_INST          = 0x00002000,
      ID_UDP_INST             = 0x00004000,
      ID_EXPLICIT_PORT        = 0x00008000,
      ID_GEN_ITEM_NAMED_BLOCK = 0x00010000,
      ID_UDP_PORT_INPUT       = 0x00020000,
      ID_UDP_PORT_OUTPUT      = 0x00040000,
      ID_UDP_PORT_OUTPUT_PL   = 0x00080000,
      ID_GATE_INST            = 0x00100000
    };

    static RefCDOmIdentifier cast(RefCDOmBase object);
  private:
    RefCDOmIdentifier getThis() const { return boost::static_pointer_cast<CDOmIdentifier>(m_weakRef.lock()); }
    EIdType m_idType;
    RefString m_name;
    RefCDOmBase m_payload;
    RefCDOmIdentifier m_complementaryID; // used for ports that are declared in two separate declarations such as: output w; reg w;

    CDOmIdentifier(TLineNumberType lineNumber, ECDOmType type, EIdType idType, const RefString& name, const RefCDOmBase& payload);

  private:
    /**
     * Returns true if the passed in identifier type is a direct scope identifier, that is its type is one of: <br/>
     *   - ID_MODULE <br/>
     *   - ID_UDP <br/>
     *   - ID_TASK <br/>
     *   - ID_FUNCTION <br/>
     *   - ID_NAMED_BLOCK <br/>
     *   - ID_GEN_ITEM_NAMED_BLOCK <br/>
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
     * Checks if a certain identidier type supports a certain payload type.
     * Throws an exception if not.
     *
     * @see EIdType
     * @see ECDOmType
     */
    static void checkPayload(EIdType idType, ECDOmType payloadType);

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
    friend class CDOmScope;
    void setComplementaryID(RefCDOmIdentifier& id);

    RefCDOmIdentifier getComplementaryID() const;

    // since this method is private, some friend class declarations are needed:
    friend class CDOmModuleDecl;
    friend class CDOmUdpDecl;
    friend class CDOmStmtBlock;
    friend class CDOmAttrList;
    friend class CDOmParamDecl;
    friend class CDOmPortDecl;
    friend class CDOmTFPortDecl;
    friend class CDOmVarDecl;
    friend class CDOmNetDecl;
    friend class CDOmEventDecl;
    friend class CDOmGenvarDecl;
    friend class CDOmTaskDecl;
    friend class CDOmFuncDecl;
    friend class CDOmModuleOrUdpInstance;
    friend class CDOmPortItem;
    friend class CDOmGenItemBlock;
    friend class CDOmUdpPortDeclInput;
    friend class CDOmUdpPortDeclOutput;
    friend class CDOmGateInstantiation;
    static RefCDOmIdentifier build(TLineNumberType lineNumber, RefCDOmBase parent, EIdType idType, const RefString& name, RefCDOmBase payload = RefCDOmBase());

  public:
    /**
     * Returns true if this object supports payload, that is his identifier type is one of: <br/>
     *   - ID_ATTR <br/>
     *   - ID_PARAM <br/>
     *   - ID_NET <br/>
     *   - ID_VAR <br/>
     *   - ID_EVENT <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on this object identifier type
     * @see EIdType
     * @see getIdType()
     */
    TBool supportsPayload() const;

    EIdType getIdType() const;

    const RefString getName() const;

    const RefCDOmBase getPayload() const;
  
    /**
     * Returns the scope object to which this object is associated to. <br/>
     * Every scope has a identifier associated with it. In case this
     * object is not an identifier that represents a scope, an exception is thrown.
     *
     * @return the scope object to which this object is associated to
     * @see CDOmBase::isToScope()
     * @see CDOmScope
     */
    RefCDOmScope toScope() const;

    //    void setIdType(EIdType); //--------OB added

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmScope class
// ********************************************************************************
/**
 * This class models a scope in CDOM. It is responsible for tracking identifiers that are
 * defined inside each scope, for resolving references to simple or hierarchical identifiers
 * across scope hierarchy and also takes care of detecting duplicate identifier definitions
 * inside same scope, case in which it throws an exception. <br/> <br/>
 *
 * <b>PDF SPEC 12.6: Scope rules</b> <br/>
 * The following four elements define a new scope in Verilog: <br/>
 * - Modules <br/>
 * - Tasks <br/>
 * - Functions <br/>
 * - Named blocks <br/> <br/>
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
class CDOmScope {
  public:
    /**
     * Holds enum constants for scope types.
     */
    enum EScopeType {SCOPE_DESIGN, SCOPE_MODULE, SCOPE_UDP, SCOPE_TASK, SCOPE_FUNCTION, SCOPE_NAMED_BLOCK, SCOPE_GEN_ITEM_NAMED_BLOCK};

  private:
    EScopeType m_scopeType;
    RefCDOmIdentifier m_id; // the identifier that represents this scope
    RefTVec_RefCDOmIdentifier m_ids;
    RefTMap_RefString_RefCDOmIdentifier m_nameMap;

    CDOmScope(EScopeType type, const RefCDOmIdentifier& id);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmDesign;
    friend class CDOmModuleDecl;
    friend class CDOmUdpDecl;
    friend class CDOmStmtBlock;
    friend class CDOmTaskDecl;
    friend class CDOmFuncDecl;
    friend class CDOmGenItemBlock;
    static RefCDOmScope build(const RefCDOmIdentifier& id = RefCDOmIdentifier());

    RefCDOmIdentifier lookupDownward(const RefString& name) const;

    RefCDOmIdentifier lookupDownward(const RefTVec_RefString& hid) const;

    // since this method is private, due to automation, some friend class declarations are needed:
    friend class CDOmIdentifier;
    /**
     * Registers a new identifier in this scope.
     * If an identifier with the same name is already registered in this scope it throws an exception.
     */
    void registerID(RefCDOmIdentifier& id);

  public:
    EScopeType getScopeType() const;

    /**
     * Returns the identifier associated with this scope.
     *
     * @return the identifier associated with this scope
     */
    RefCDOmIdentifier getID() const;

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
    RefCDOmIdentifier lookupLocal(const RefString& name) const;

    /**
     * Finds the first identifier match according to scope search rules and idMask. <br/>
     * idMask is a OR mask of enum constants (CDOmIdentifier::EIdType) <br/>
     * idMask example: ID_TASK | ID_NAMED_BLOCK <br/>
     * Example: disable <id> -> id can refer to both a task id or a named block id
     *
     * @param name a name to be searched for
     * @param idMask the identifier mask that returned identifier must match
     * @return an identifier that maches the search of null if no identifier was found
     * @see CDOmIdentifier::EIdType
     */
    RefCDOmIdentifier lookup(const RefString& name, TUInt idMask) const;

    /**
     * Finds the first identifier match according to scope search rules and idMask. <br/>
     * idMask is a OR mask of enum constants (CDOmIdentifier::EIdType) <br/>
     * idMask example: ID_TASK | ID_NAMED_BLOCK <br/>
     * Example: disable <id> -> id can refer to both a task id or a named block id
     *
     * @param hid a name to be searched for
     * @param idMask the identifier mask that returned identifier must match
     * @return an identifier that maches the search of null if no identifier was found
     * @see CDOmIdentifier::EIdType
     */
    RefCDOmIdentifier lookup(const RefTVec_RefString& hid, TUInt idMask) const;

    /**
     * Returns a vector of all identifiers registered in this scope.
     *
     * @return a vector of all identifiers registered in this scope
     */
    const RefTVec_RefCDOmIdentifier getIDs() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmExpr class
// ********************************************************************************
/**
 * This is the base class for all expresions in CDOM.
 */
class CDOmExpr : public CDOmBase {
  public:
    /**
     * Holds enum constants for expression types.
     */
    enum EExprType {
      EXPR_NUMBER,
      EXPR_REAL_NUMBER,
      EXPR_HID,
      EXPR_CONCAT,
      EXPR_MULTI_CONCAT,
      EXPR_FUNCTION_CALL,
      EXPR_MINTYPMAX,
      EXPR_OP,
      EXPR_STRING
    };

    static RefCDOmExpr cast (RefCDOmBase object);
  private:
    RefCDOmExpr getThis() const { return boost::static_pointer_cast<CDOmExpr>(m_weakRef.lock());  }
    EExprType m_exprType;
    mutable RefCDOmBase m_cachedEval; // used for caching the evaluation result

  protected:
    CDOmExpr(TLineNumberType lineNumber, EExprType exprType);

  public:
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

    /**
     * Returns true if this expression is a primary, that is its type is one of: <br/>
     *   - EXPR_NUMBER <br/>
     *   - EXPR_HID <br/>
     *   - EXPR_CONCAT <br/>
     *   - EXPR_MULTI_CONCAT <br/>
     *   - EXPR_FUNCTION_CALL <br/>
     *   - EXPR_MINTYPMAX <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the primary status of this expression
     * @see ECDOmType
     * @see getExprType()
     */
    TBool isPrimary() const;


    virtual TBool canBeModulePath() const = 0;

    /**
     * Returns a vector of all children (sub)expressions. This function is useful for subclasses
     * such CDOmExprConcat, CDOmExprOp, CDOmMinTypMax and so on.
     *
     * @return a vector of all children (sub)expressions
     */
    const RefTVec_RefCDOmExpr getExprs() const;

    /**
     * This method should not be overriden by derived classes. It provides a caching mechanism
     * of evaluation result.
     *
     * @return RefCDOmEvalRes the evaluation result of this expression
     */
    //RefCDOmEvalRes eval() const;
    RefCDOmBase eval() const;

    /**
     * This method return the evaluation result. No caching should occur here.
     *
     * @return RefCDOmEvalRes the evaluation result of this expression
     * @see eval()
     */
    virtual RefCDOmBase doEval() const = 0;
    virtual void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const = 0;
};

// ********************************************************************************
// CDOmExprLink class
// ********************************************************************************
/**
 * This class models a reference (link) to both simple and hierachical identifiers.
 * <b>NOTE: </b>an exprLink is to be linked automatically during inference/linking phase
 * to a real indentifier. <br/> <br/>
 *
 * A HID item is a pair of form (simple id, expr) <br/>
 * Example 1: a.b[2].c[3].d.e[5][8][1+:3] <br/>
 * pairs: (a, null), (b, 2), (c, 3), (d, null), (e,null) <br/>
 * m_arrayIndexes: [5][8] <br/>
 * m_rangeExpr (part select): [1+:3] <br/> <br/>
 *
 * Example 2: reg[7:0] mem[0:255][0:255]; <br/>
 *   - mem[10][20][2]    -> bit select  -> m_arrayIndexes = [10][20], m_rangeExpr = [2] <br/>
 *   - mem[10][20][1:3]  -> part select -> m_arrayIndexes = [10][20], m_rangeExpr = [1:3] <br/>
 *   - mem[10][20][1+:3] -> part select -> m_arrayIndexes = [10][20], m_rangeExpr = [1+:3] <br/>
 *   - mem[10][20][5-:2] -> part select -> m_arrayIndexes = [10][20], m_rangeExpr = [5-:2] <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * identifier
 * hierarchical_identifier ::= { identifier [ [ constant_expression ] ] . } identifier
 * hierarchical_identifier [ { [ expression ] } [ range_expression ] ]
 * </code></pre> <br/> <br/>
 *
 * <b>NOTE: </b>this class is also applicable to lvalue grammar rules: <br/>
 * <b>ADDITIONAL GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * net_lvalue ::=
 *   hierarchical_net_identifier [ { [ constant_expression ] } [ constant_range_expression ] ]
 *   | { net_lvalue { , net_lvalue } }
 * variable_lvalue ::=
 *   hierarchical_variable_identifier [ { [ expression ] } [ range_expression ] ]
 *   | { variable_lvalue { , variable_lvalue } }
 * hierarchical_net_identifier ::= hierarchical_identifier
 * hierarchical_variable_identifier ::= hierarchical_identifier
 *
 * specify_input_terminal_descriptor ::=
 *   input_identifier [ [ constant_range_expression ] ]
 * specify_output_terminal_descriptor ::=
 *   output_identifier [ [ constant_range_expression ] ]
 * input_identifier ::= input_port_identifier | inout_port_identifier
 * output_identifier ::= output_port_identifier | inout_port_identifier
 * input_port_identifier ::= identifier
 * inout_port_identifier ::= identifier
 * output_port_identifier ::= identifier
 * </code></pre>
 */
class CDOmExprLink : public CDOmExpr {
  private:
    RefCDOmExprLink getThis() const { return boost::static_pointer_cast<CDOmExprLink>(m_weakRef.lock()); }
    enum EState {HID_ITEM, ARRAY_INDEXES, RANGE_EXPR};

    static RefTVec_RefCDOmExprLink exprLinks; // static class variable that holds all expr links to be resolved at linking phase

    EState m_state;
    RefTVec_RefString m_names;
    RefTVec_RefCDOmExpr m_exprs;
    RefTVec_RefCDOmIdentifier m_ids;

    RefCDOmListExpr m_arrayIndexes; // used for array addressing
    RefCDOmRangeExpr m_rangeExpr;   // used for vector bit select and part select addressing

    CDOmExprLink(TLineNumberType lineNumber);

  public:
    static RefCDOmExprLink cast(RefCDOmBase);

    static RefCDOmExprLink build(TLineNumberType lineNumber, const RefString& name, RefCDOmExpr expr = RefCDOmExpr());

    /**
     * Returns true if this exprLink is a hierarchical identifier, or false it it is a simple identifier.
     *
     * @return true or false, depending if this exprLink is a hierarchical identifier or a simple identifier
     */
    TBool isHID() const;

    RefString getName() const;

    void addHidItem(const RefString& name, RefCDOmExpr expr = RefCDOmExpr());

    void setArrayIndexes(RefCDOmListExpr arrayIndexes);

    RefCDOmListExpr getArrayIndexes() const;

    void setRangeExpr(RefCDOmRangeExpr rangeExpr);

    RefCDOmRangeExpr getRangeExpr() const;

    TBool isConst() const;

    TBool canBeModulePath() const;

    /**
     * Returns true if this exprLink is resolved, that is it is linked to an identifier.
     * This can return true only after inference/linking phase.
     *
     * @return true or false, depending if this exprLink is a hierarchical identifier or a simple on
     */
    TBool isResolved() const;

    /**
     * Returns the identifier to which this exprLink is linked.
     * If this exprLink is not resolved yet, an exception is thrown.
     *
     * @return the identifier to which this exprLink is linked
     * @see isResolved()
     */
    RefCDOmIdentifier toID() const;

    const RefTVec_RefString getHidNames() const;

    const RefTVec_RefCDOmExpr getHidExprs() const;

    //RefCDOmEvalRes doEval() const;
    RefCDOmBase doEval() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmExprOp class
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
class CDOmExprOp : public CDOmExpr {
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
      OP_UNARY_LOG_2                     = 0x90000400,

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
    static const TUInt OP_MODULE_PATH_MASK  = 0x80000000;

  private:
    RefCDOmExprOp getThis() const { return boost::static_pointer_cast<CDOmExprOp>(m_weakRef.lock()); }
    EOpType m_opType;
    TBool m_isConst;
    TBool m_canBeModulePath;
    RefCDOmAttrListCollection m_attrListCollection;

    CDOmExprOp(TLineNumberType lineNumber, EOpType opType, TBool isConst, TBool canBeModPath);

  public:
    static RefCDOmExprOp cast (RefCDOmBase object);

    static RefCDOmExprOp build(TLineNumberType lineNumber, EOpType opType, RefCDOmExpr expr1, RefCDOmExpr expr2 = RefCDOmExpr(), RefCDOmExpr expr3 = RefCDOmExpr());

    /**
     * Attaches the passed in attrListCollection to this expression.
     *
     * @param attrListCollection the attribute list collection to be attached to this expression
     * @see CDOmAttrList
     * @see CDOmAttrListCollection
     */
    void setAttrListCollection(RefCDOmAttrListCollection& attrListCollection);

    RefCDOmAttrListCollection getAttrListCollection() const;

    TBool isConst() const;

    TBool canBeModulePath() const;

    EOpType getOpType() const;

    const RefCDOmExpr getExpr1() const;

    const RefCDOmExpr getExpr2() const;

    const RefCDOmExpr getExpr3() const;

    //RefCDOmEvalRes doEval() const;
    RefCDOmBase doEval() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;

    TBool isUnary() const;

    TBool isBinary() const;

    TBool isTernary() const;
};

// ********************************************************************************
// CDOmList class
// ********************************************************************************
/**
 * This template class is designed to hold lists of cdom objects
 * with a guaranteed minimum one object.
 */
//TODO Because the current gcc implementation doesn't support external template function implementation
//     all the methods are implemented inline. When this feature will be available in gcc this classes code
//     has to be moved to an external cpp file
/*
  template<ECDOmType listType, class T, void (*validate)(const boost::shared_ptr<T>&)>
  class CDOmList : public CDOmBase {
  public:
  typedef boost::shared_ptr<T>                                 RefCDOmT;
  typedef std::vector<RefCDOmT>                                   TVec_RefCDOmT;
  typedef boost::shared_ptr<TVec_RefCDOmT>                     RefTVec_RefCDOmT;
  typedef boost::shared_ptr< CDOmList<listType, T, validate> > RefCDOmList;

  private:
  RefCDOmList getThis() const { return boost::static_pointer_cast<CDOmList>(m_weakRef.lock());  }
  CDOmList(TLineNumberType lineNumber) : CDOmBase(listType, lineNumber) { }

  public:
  static RefCDOmList build(TLineNumberType lineNumber, RefCDOmT item) {
  CDOmList* list = new CDOmList(lineNumber);
  RefCDOmList refList(list);
  list->m_weakRef = refList.getWeakRef();
  list->addItem(item);
  return refList;
  }

  void addItem(RefCDOmT item) {
  assert(item.get());
  validate(item);

  item->setParent(m_weakRef.lock()); // self registration
  }

  RefTVec_RefCDOmT getItems() const {
  return getChildren<T>(TYPE_ALL_TYPES);
  }

  TUInt getNumberOfChildren() const {
  return m_children->size();
  }

  void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  }
  };

*/
// ********************************************************************************
// CDOmListExpr class
// ********************************************************************************
/**
 * This class holds a list of expressions. It is similar to a vector of expressions.
 * An object of this type is always guaranteed to hold at least one expression. <br/>
 * It is used to hold the following grammar constructs: <br/>
 * <pre><code>
 * expression { , expression }
 * [expression] { [expression] }
 * constant_expression { , constant_expression }
 * [constant_expression] { [constant_expression] }
 * </code></pre>
 */
//typedef CDOmList<TYPE_LIST_EXPR, CDOmExpr>                         CDOmExprList;


class CDOmListExpr : public CDOmBase {
  private:
    RefCDOmListExpr getThis() const { return boost::static_pointer_cast<CDOmListExpr>(m_weakRef.lock());  }
    //ECDOmType listType;
    CDOmListExpr(TLineNumberType lineNumber);

  public:
    static RefCDOmListExpr build(TLineNumberType lineNumber,  RefCDOmExpr item); 

    static RefCDOmListExpr cast (RefCDOmBase object) {
      ASSERT(!object.get() || object->getType() == TYPE_LIST_EXPR, "object have a different type that TYPE_LIST_EXPR");
      return boost::static_pointer_cast<CDOmListExpr>(object);
    }
    
    void   addItem(RefCDOmExpr item);
    RefTVec_RefCDOmExpr getItems() const;
    TUInt getNumberOfChildren() const;
    void   acceptVisitor(NSCdomVisitor::CVisitor& visitor) const; 
};


// ********************************************************************************
// CDOmRangeList class
// ********************************************************************************
/**
 * This class holds a list of ranges. It is similar to a vector of ranges.
 * An object of this type is always guaranteed to hold at least one range. <br/>
 * It is used to hold the following grammar constructs: <br/>
 * <pre><code>
 * range { range }
 * dimension { dimension }
 * </code></pre>
 *
 * @see CDOmRange
 */
//typedef CDOmList<TYPE_RANGE_LIST, CDOmRange>                         CDOmRangeList;


class CDOmRangeList : public CDOmBase {
  private:
    RefCDOmRangeList getThis() const { return boost::static_pointer_cast<CDOmRangeList>(m_weakRef.lock());  }
    //ECDOmType listType;
    CDOmRangeList(TLineNumberType lineNumber);

  public:
    static RefCDOmRangeList build(TLineNumberType lineNumber,  RefCDOmRange item); 

    static RefCDOmRangeList cast (RefCDOmBase object) {
      ASSERT(!object.get() ||  object->getType() == TYPE_RANGE_LIST, "object have a different type that TYPE_RANGE_LIST");
      return boost::static_pointer_cast<CDOmRangeList>(object);
    }

    void   addItem(RefCDOmRange item);
    RefTVec_RefCDOmRange getItems() const;
    TUInt getNumberOfChildren() const;
    void   acceptVisitor(NSCdomVisitor::CVisitor& visitor) const; 
};


// ********************************************************************************
// CDOmSpecifyTerminalList class
// ********************************************************************************
/**
 * This class models a list of specify terminals according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * list_of_path_inputs ::=
 *   specify_input_terminal_descriptor { , specify_input_terminal_descriptor }
 *
 * list_of_path_outputs ::=
 *   specify_output_terminal_descriptor { , specify_output_terminal_descriptor }
 *
 * </code></pre>
 */
//typedef CDOmList<TYPE_SPEC_TERM_LIST, CDOmExprLink>                         CDOmMinTypMaxList;


class CDOmSpecifyTerminalList : public CDOmBase {
  private:
    RefCDOmSpecifyTerminalList getThis() const { return boost::static_pointer_cast<CDOmSpecifyTerminalList>(m_weakRef.lock());  }
    //ECDOmType listType;
    CDOmSpecifyTerminalList(TLineNumberType lineNumber);

  public:
    static RefCDOmSpecifyTerminalList build(TLineNumberType lineNumber,  RefCDOmExprLink item); 
   
    static RefCDOmSpecifyTerminalList cast (RefCDOmBase object) {
      ASSERT(!object.get() || object->getType() == TYPE_SPEC_TERM_LIST, "object have a different type that TYPE_SPEC_TERM_LIST");
      return boost::static_pointer_cast<CDOmSpecifyTerminalList>(object);
    }

    void   addItem(RefCDOmExprLink item);
    RefTVec_RefCDOmExprLink getItems() const;
    TUInt getNumberOfChildren() const;
    void   acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
    friend void validateSpecifyTerminal(const RefCDOmExprLink& item);

};


// ********************************************************************************
// CDOmMinTypMaxList class
// ********************************************************************************
/**
 * This class models a list of CDOmMinTypMax objects according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * list_of_path_delay_expressions ::=
 *   t_path_delay_expression
 *   | trise_path_delay_expression , tfall_path_delay_expression
 *   | trise_path_delay_expression , tfall_path_delay_expression , tz_path_delay_expression
 *   | t01_path_delay_expression , t10_path_delay_expression , t0z_path_delay_expression ,
 *     tz1_path_delay_expression , t1z_path_delay_expression , tz0_path_delay_expression
 *   | t01_path_delay_expression , t10_path_delay_expression , t0z_path_delay_expression ,
 *     tz1_path_delay_expression , t1z_path_delay_expression , tz0_path_delay_expression ,
 *     t0x_path_delay_expression , tx1_path_delay_expression , t1x_path_delay_expression ,
 *     tx0_path_delay_expression , txz_path_delay_expression , tzx_path_delay_expression
 *
 * t_path_delay_expression ::= path_delay_expression
 *
 * trise_path_delay_expression ::= path_delay_expression
 *
 * tfall_path_delay_expression ::= path_delay_expression
 *
 * tz_path_delay_expression ::= path_delay_expression
 *
 * t01_path_delay_expression ::= path_delay_expression
 *
 * t10_path_delay_expression ::= path_delay_expression
 *
 * t0z_path_delay_expression ::= path_delay_expression
 *
 * tz1_path_delay_expression ::= path_delay_expression
 *
 * t1z_path_delay_expression ::= path_delay_expression
 *
 * tz0_path_delay_expression ::= path_delay_expression
 *
 * t0x_path_delay_expression ::= path_delay_expression
 *
 * tx1_path_delay_expression ::= path_delay_expression
 *
 * t1x_path_delay_expression ::= path_delay_expression
 *
 * tx0_path_delay_expression ::= path_delay_expression
 *
 * txz_path_delay_expression ::= path_delay_expression
 *
 * tzx_path_delay_expression ::= path_delay_expression
 *
 * path_delay_expression ::= constant_mintypmax_expression
 *
 * </code></pre>
 */
//typedef CDOmList<TYPE_MINTYPMAX_LIST, CDOmMinTypMax>                         CDOmMinTypMaxList;

class CDOmMinTypMaxList : public CDOmBase {
  private:
    RefCDOmMinTypMaxList getThis() const { return boost::static_pointer_cast<CDOmMinTypMaxList>(m_weakRef.lock());  }
    //ECDOmType listType;
    CDOmMinTypMaxList(TLineNumberType lineNumber);

  public:
    static RefCDOmMinTypMaxList build(TLineNumberType lineNumber,  RefCDOmMinTypMax item); 

    static RefCDOmMinTypMaxList cast (RefCDOmBase object) {
      ASSERT(!object.get() || object->getType() == TYPE_MINTYPMAX_LIST, "object have a different type that TYPE_MINTYPMAX_LIST");
      return boost::static_pointer_cast<CDOmMinTypMaxList>(object);
    }
    
    void   addItem(RefCDOmMinTypMax item);
    RefTVec_RefCDOmMinTypMax getItems() const;
    TUInt getNumberOfChildren() const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const; 
};


// ********************************************************************************
// CDOmExprConcat class
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
class CDOmExprConcat : public CDOmExpr {
  private:
    RefCDOmExprConcat getThis() const { return boost::static_pointer_cast<CDOmExprConcat>(m_weakRef.lock());  }  

    TBool m_isConst; // used to inidicate if this expr list contains only const expressions

    TBool m_canBeModulePath;

    CDOmExprConcat(TLineNumberType lineNumber);

  public:
    static RefCDOmExprConcat cast (RefCDOmBase object);
  
    static RefCDOmExprConcat build(TLineNumberType lineNumber, RefCDOmExpr expr);
  
    TBool isConst() const;

    TBool canBeModulePath() const;

    void addExpr(RefCDOmExpr expr);

    //RefCDOmEvalRes doEval() const;

    RefCDOmBase doEval() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmExprMultiConcat class
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
class CDOmExprMultiConcat : public CDOmExpr {
  private:
    RefCDOmExprMultiConcat getThis() const { return boost::static_pointer_cast<CDOmExprMultiConcat>(m_weakRef.lock()); }
    CDOmExprMultiConcat(TLineNumberType lineNumber, TBool canBeModPath);
    TBool m_canBeModulePath;

  public:
    static RefCDOmExprMultiConcat cast (RefCDOmBase object);

    static RefCDOmExprMultiConcat build(TLineNumberType lineNumber, RefCDOmExpr expr, RefCDOmExprConcat& exprConcat);
  
    TBool isConst() const;

    TBool canBeModulePath() const;

    RefCDOmExpr getExpr() const;

    RefCDOmExprConcat getExprConcat() const;

    //RefCDOmEvalRes doEval() const;
    RefCDOmBase doEval() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmAttrList class
// ********************************************************************************
/**
 * This class models a single attribute list according to the grammar rules.
 * An attribute list object consist of pairs of form: attributeName [= attributeValue]<br/>
 * Example: (* a=1, b, c *) <br/>
 * <b>NOTE: </b>attributes whose values are null, that is calling get() on returned object returns 0,
 * should use the default value provided by static function getAttrDefaultValue() <br/> <br/>
 *
 * <b>PDF SPEC 2.8: Attributes</b> <br/>
 * If a value is not specifically assigned to the attribute, then its value shall be 1. If the same attribute name is
 * defined more than once for the same language element, the last attribute value shall be used and a tool can
 * give a warning that a duplicate attribute specification has occurred. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * attribute_instance ::= (* attr_spec { , attr_spec } *)
 * attr_spec ::=
 *   attr_name [ = constant_expression ]
 * attr_name ::= identifier
 * </code></pre>
 *
 * @see CDOmAttrListCollection
 */
class CDOmAttrList : public CDOmBase {
  private:
    RefCDOmAttrList getThis() const { return boost::static_pointer_cast<CDOmAttrList>(m_weakRef.lock()); } 

    static const RefCDOmNumber ATTR_DEFAULT_VALUE;

    RefTMultiMap_RefString_RefCDOmIdentifier m_nameMMap;

    CDOmAttrList(TLineNumberType lineNumber);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmAttrListCollection;
    static RefCDOmAttrList build(TLineNumberType lineNumber, RefCDOmAttrListCollection parent);

  public:
    static RefCDOmAttrList cast (RefCDOmBase object);

    static const RefCDOmNumber getAttrDefaultValue();

    void addAttr(TLong lineNumber, const RefString& name, RefCDOmExpr expr = RefCDOmExpr());

    TBool containsAttr(const RefString& name) const;

    /**
     * Finds the attribute whose name matches the passed in name and returns its value.
     * If multiple attributes with the same name are registered into this attribute list
     * the last value is returned. See CDOmAttrList class description for more information.
     * <b>NOTE: </b>attributes whose values are null, that is calling get() on returned object returns 0,
     * should use the default value provided by static function getAttrDefaultValue()
     *
     * @param name the attribute name whose value is to be retrived
     * @return the attribute value
     */
    RefCDOmExpr getAttrVal(const RefString& name) const;

    const RefTVec_RefCDOmIdentifier getIDs() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmAttrListCollection class
// ********************************************************************************
/**
 * This class holds multiple attribute lists. It is similar to a vector of attribute lists.<br/>
 * Example: (* a=1, b, c=2 *)(* x, y=1, z *)... <br/>
 * It is used to hold the following grammar construct: <br/>
 * <pre><code>
 * { attribute_instance }
 * </code></pre>
 *
 * @see CDOmAttrList
 */
class CDOmAttrListCollection : public CDOmBase {
  private:
    RefCDOmAttrListCollection getThis() const { return boost::static_pointer_cast<CDOmAttrListCollection>(m_weakRef.lock()); } 

    CDOmAttrListCollection(TLineNumberType lineNumber);

  public:
    static RefCDOmAttrListCollection cast (RefCDOmBase object);

    static RefCDOmAttrListCollection build(TLineNumberType lineNumber);

    /**
     * Returns a new attribute list attached to this attribute list collection.
     *
     * @return a new attribute list attached to this attribute list collection
     */
    RefCDOmAttrList buildAttrList(TLineNumberType lineNumber);

    const RefTVec_RefCDOmAttrList getAttrLists() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmStmt class
// ********************************************************************************
/**
 * This class is the base class of all statements in CDOM. This is the place of where the
 * common attrListCollection (CDOmAttrListCollection) is beeing held. It also provides a static
 * method (buildNullStmt()) for building a null statement according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * statement ::=
 *   { attribute_instance } blocking_assignment ;
 *   | { attribute_instance } case_statement
 *   | { attribute_instance } conditional_statement
 *   | { attribute_instance } disable_statement
 *   | { attribute_instance } event_trigger
 *   | { attribute_instance } loop_statement
 *   | { attribute_instance } nonblocking_assignment ;
 *   | { attribute_instance } par_block
 *   | { attribute_instance } procedural_continuous_assignments ;
 *   | { attribute_instance } procedural_timing_control_statement
 *   | { attribute_instance } seq_block
 *   | { attribute_instance } system_task_enable
 *   | { attribute_instance } task_enable
 *   | { attribute_instance } wait_statement
 * statement_or_null ::=
 *   statement
 *   | { attribute_instance } ;
 * </code></pre>
 */
class CDOmStmt : public CDOmAttrHolder {
  public:
    /**
     * Holds enum constants for statement types.
     */
    enum EStmtType {
      STMT_NULL,
      STMT_ASSN, // used for both blocking and nonblocking assignment
      STMT_CASE,
      STMT_IF,
      STMT_DISABLE,
      STMT_EVENT_TRIGGER,
      STMT_LOOP,
      STMT_BLOCK_NAMED, // used both for parallel and sequential blocks
      STMT_BLOCK_UNNAMED, // used both for parallel and sequential blocks
      STMT_PROC_CONT_ASSN, // used for procedural continuous assignments
      STMT_PROC_TIMING_CONTROL, // used for procedural timing control
      STMT_TASK_ENABLE, // used both for task enable and system task enable
      STMT_WAIT
    };

  private:
    RefCDOmStmt getThis() const { return boost::static_pointer_cast<CDOmStmt>(m_weakRef.lock()); } 

    EStmtType m_stmtType;

  protected:
    CDOmStmt(TLineNumberType lineNumber, EStmtType stmtType);

  public:
    static RefCDOmStmt cast (RefCDOmBase object);

    static RefCDOmStmt buildNullStmt(TLineNumberType lineNumber);

    EStmtType getStmtType() const;

    virtual void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;

};

// ********************************************************************************
// CDOmStmtAssn class
// ********************************************************************************
/**
 * This class models an assign statement according to the grammar rules.
 * It is used for both blocking and non blocking statements. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * blocking_assignment ::= variable_lvalue = [ delay_or_event_control ] expression
 * nonblocking_assignment ::= variable_lvalue <= [ delay_or_event_control ] expression
 * 
 * delay_or_event_control ::=
 *   delay_control
 *   | event_control
 *   | repeat ( expression ) event_control
 * </code></pre>
 *
 * @see CDOmExprLink
 */
class CDOmStmtAssn : public CDOmStmt {
  public:
    /**
     * Holds enum constants for assignment types.
     */
    enum EAssnType {ASSN_BLOCKING, ASSN_NON_BLOCKING};

    /**
     * Holds enum constants for event or control types.
     */
    enum EControlType {CONTROL_NONE, CONTROL_DELAY_CONTROL, CONTROL_EVENT_CONTROL, CONTROL_REPEAT_EVENT_CONTROL};

  private:
    RefCDOmStmtAssn getThis() const { return boost::static_pointer_cast<CDOmStmtAssn>(m_weakRef.lock()); } 

    EAssnType m_assnType;
    EControlType m_controlType;

    CDOmStmtAssn(TLineNumberType lineNumber, EAssnType assnType, EControlType controlType);

  public:
    static RefCDOmStmtAssn cast (RefCDOmBase object);

    static RefCDOmStmtAssn buildSimple(TLineNumberType lineNumber, EAssnType assnType, RefCDOmExpr lvalue, RefCDOmExpr expr);

    static RefCDOmStmtAssn buildWithDelayControl(TLineNumberType lineNumber, EAssnType assnType, RefCDOmExpr lvalue, RefCDOmExpr expr, RefCDOmDelayControl delayControl);

    static RefCDOmStmtAssn buildWithEventControl(TLineNumberType lineNumber, EAssnType assnType, RefCDOmExpr lvalue, RefCDOmExpr expr, RefCDOmEventControl eventControl, RefCDOmExpr repeatExpr = RefCDOmExpr());

    EAssnType getAssnType() const;

    EControlType getControlType() const;

    RefCDOmExpr getLvalue() const;

    RefCDOmExpr getExpr() const;

    RefCDOmDelayControl getDelayControl() const;

    RefCDOmEventControl getEventControl() const;

    RefCDOmExpr getRepeatExpr() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmDelayControl class
// ********************************************************************************
/**
 * This class models a delay control according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * delay_control ::=
 *   # delay_value
 *   | # ( mintypmax_expression )
 * delay_value ::=
 *   unsigned_number
 *   | real_number
 *   | identifier
 * </code></pre>
 */
class CDOmDelayControl : public CDOmBase {
  public:
    /**
     * Holds enum constants for delay control types.
     */
    enum EDelayControlType {DELAY_CONTROL_UNSIGNED_NUMBER, DELAY_CONTROL_REAL_NUMBER, DELAY_CONTROL_IDENTIFIER, DELAY_CONTROL_MINTYPMAX};

  private:
    RefCDOmDelayControl getThis() const { return boost::static_pointer_cast<CDOmDelayControl>(m_weakRef.lock()); } 

    EDelayControlType m_delayControlType;

    CDOmDelayControl(TLineNumberType lineNumber, EDelayControlType delayControlType);

  public:
    static RefCDOmDelayControl cast (RefCDOmBase object);

    static RefCDOmDelayControl build(TLineNumberType lineNumber, RefCDOmNumber num);

    static RefCDOmDelayControl build(TLineNumberType lineNumber, RefCDOmReal realNum);

    static RefCDOmDelayControl build(TLineNumberType lineNumber, RefCDOmExprLink exprLink);

    static RefCDOmDelayControl build(TLineNumberType lineNumber, RefCDOmMinTypMax minTypMax);

    EDelayControlType getDelayControlType() const;

    RefCDOmNumber getNumber() const;

    RefCDOmReal getRealNumber() const;

    RefCDOmExprLink getExprLink() const;

    RefCDOmMinTypMax getMinTypMax() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmEventControl class
// ********************************************************************************
/**
 * This class models an event control according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * event_control ::=
 *   @ hierarchical_event_identifier
 *   | @ ( event_expression )
 *   | @*
 *   | @ (*)
 * hierarchical_event_identifier ::= hierarchical_identifier
 * </code></pre>
 */
class CDOmEventControl : public CDOmBase {
  public:
    /**
     * Holds enum constants for event control types.
     */
    enum EEventControlType {EVENT_CONTROL_HID, EVENT_CONTROL_EVENT_EXPR, EVENT_CONTROL_STAR, EVENT_CONTROL_STAR_WITH_PARENTHESIS};

  private:
    RefCDOmEventControl getThis() const { return boost::static_pointer_cast<CDOmEventControl>(m_weakRef.lock()); }
 
    EEventControlType m_eventControlType;

    CDOmEventControl(TLineNumberType lineNumber, EEventControlType eventControlType);

  public:
    static RefCDOmEventControl cast (RefCDOmBase object);

    static RefCDOmEventControl build(TLineNumberType lineNumber, RefCDOmExprLink hid);

    static RefCDOmEventControl build(TLineNumberType lineNumber, RefCDOmEventExpr eventExpr);

    static RefCDOmEventControl build(TLineNumberType lineNumber, TBool starWithParenthesis = false);

    EEventControlType getEventControlType() const;

    RefCDOmExprLink getHID() const;
  
    RefCDOmEventExpr getEventExpr() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
    
};

// ********************************************************************************
// CDOmEventExpr class
// ********************************************************************************
/**
 * This class models an event expression according to the grammar rules. <br/>
 * <b>NOTE: </b>this class in NOT an expression, that is it is NOT derived from CDOmExpr <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * event_expression ::=
 *   expression
 *   | posedge expression
 *   | negedge expression
 *   | event_expression or event_expression
 *   | event_expression , event_expression
 * </code></pre>
 */
class CDOmEventExpr : public CDOmBase {
  public:
    /**
     * Holds enum constants for event control types.
     */
    enum EEventExprType {EVENT_EXPR_EXPR, EVENT_EXPR_POSEDGE, EVENT_EXPR_NEGEDGE, EVENT_EXPR_OR, EVENT_EXPR_COMMA};

  private:
    RefCDOmEventExpr getThis() const { return boost::static_pointer_cast<CDOmEventExpr>(m_weakRef.lock()); } 

    EEventExprType m_eventExprType;

    CDOmEventExpr(TLineNumberType lineNumber, EEventExprType eventExprType);

  public:
    static RefCDOmEventExpr cast (RefCDOmBase object);

    static RefCDOmEventExpr build(TLineNumberType lineNumber, EEventExprType eventExprType, RefCDOmExpr expr);

    static RefCDOmEventExpr build(TLineNumberType lineNumber, EEventExprType eventExprType, RefCDOmEventExpr eventExpr1, RefCDOmEventExpr eventExpr2);

    const EEventExprType getEventExprType() const;

    RefCDOmExpr getExpr() const;

    RefCDOmEventExpr getEventExpr1() const;

    RefCDOmEventExpr getEventExpr2() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
    
};

// ********************************************************************************
// CDOmStmtCase class
// ********************************************************************************
/**
 * This class models a case statement according to the grammar rules.
 * Case items are beeing recorded inside base class m_children member.
 * A case item is a pair of a RefCDOmListExpr and a RefCDOmStmt. These items are recorded interlaced, that is:
 * (exprList, stmt), (exprList, stmt) ... -> parenthesis are used only to put pairs in evidence. <br/>
 * Default case item does not have a exprList attached, that is only its statememt is recorded; therefore if 2 stmts
 * are found next to each other, that means the 2nd stmt is the stmt of a "default:" item: (exprList, stmt), (stmt), (exprList, stmt) ...
 * Note also that "default:" case item can be the 1st item in m_children: (stmt), (exprList, stmt) ... <br/>
 * An object of this type is always guaranteed to hold at least one case item. <br/> <br/>
 *
 * <b>PDF SPEC 9.5: Case Statement</b> <br/>
 * The default statement shall be optional. Use of multiple default statements in one case statement shall be illegal. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * case_statement ::=
 *   case ( expression )
 *     case_item { case_item } endcase
 *   | casez ( expression )
 *     case_item { case_item } endcase
 *   | casex ( expression )
 *     case_item { case_item } endcase
 * case_item ::=
 *   expression { , expression } : statement_or_null
 *   | default [ : ] statement_or_null
 * </code></pre>
 */
class CDOmStmtCase : public CDOmStmt {
  public:
    /**
     * Holds enum constants for case types.
     */
    enum ECaseType {CASE_CASE, CASE_CASE_Z, CASE_CASE_X};

  private:
    RefCDOmStmtCase getThis() const { return boost::static_pointer_cast<CDOmStmtCase>(m_weakRef.lock()); } 

    ECaseType m_caseType;
    TBool m_hasDefault;

    CDOmStmtCase(TLineNumberType lineNumber, ECaseType caseType);

  public:
    static RefCDOmStmtCase cast (RefCDOmBase object);

    static RefCDOmStmtCase build(TLineNumberType lineNumber, ECaseType caseType, RefCDOmExpr expr, RefCDOmListExpr exprList, RefCDOmStmt stmt); // a null exprList means "default:"

    TBool hasDefault() const;

    ECaseType getCaseType() const;

    void addCaseItem(RefCDOmListExpr exprList, RefCDOmStmt stmt); // a null exprList means "default:"

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;

};

// ********************************************************************************
// CDOmStmtIf class
// ********************************************************************************
/**
 * This class models an if statement according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * conditional_statement ::=
 *   if ( expression )
 *   statement_or_null [ else statement_or_null ]
 *   | if_else_if_statement
 * if_else_if_statement ::=
 *   if ( expression ) statement_or_null
 *   { else if ( expression ) statement_or_null }
 *   [ else statement_or_null ]
 * </code></pre>
 */
class CDOmStmtIf : public CDOmStmt {
  private:
    RefCDOmStmtIf getThis() const { return boost::static_pointer_cast<CDOmStmtIf>(m_weakRef.lock()); }

    CDOmStmtIf(TLineNumberType lineNumber);

  public:
    static RefCDOmStmtIf cast (RefCDOmBase object);

    static RefCDOmStmtIf build(TLineNumberType lineNumber, RefCDOmExpr ifCondExpr, RefCDOmStmt ifStmt, RefCDOmStmt elseStmt); // a null elseStmt means no else
  
    RefCDOmExpr getIfCondExpr() const;

    RefCDOmStmt getIfStmt() const;

    RefCDOmStmt getElseStmt() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const; 

};

// ********************************************************************************
// CDOmStmtDisable class
// ********************************************************************************
/**
 * This class models a disable statement according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * disable_statement ::=
 *   disable hierarchical_task_identifier ;
 *   | disable hierarchical_block_identifier ;
 * hierarchical_task_identifier ::= hierarchical_identifier
 * hierarchical_block_identifier ::= hierarchical_identifier
 * </code></pre>
 */
class CDOmStmtDisable : public CDOmStmt {
  private:
    RefCDOmStmtDisable getThis() const { return boost::static_pointer_cast<CDOmStmtDisable>(m_weakRef.lock()); }
 
    CDOmStmtDisable(TLineNumberType lineNumber);

  public:
    static RefCDOmStmtDisable cast (RefCDOmBase object);

    static RefCDOmStmtDisable build(TLineNumberType lineNumber, RefCDOmExprLink hid);

    RefCDOmExprLink getHID() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const; 

};

// ********************************************************************************
// CDOmStmtEventTrigger class
// ********************************************************************************
/**
 * This class models a disable statement according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * event_trigger ::=
 *   -> hierarchical_event_identifier { [ expression ] } ;
 * hierarchical_event_identifier ::= hierarchical_identifier
 * </code></pre>
 */
class CDOmStmtEventTrigger : public CDOmStmt {
  private:
    RefCDOmStmtEventTrigger getThis() const { return boost::static_pointer_cast<CDOmStmtEventTrigger>(m_weakRef.lock()); }
 
    CDOmStmtEventTrigger(TLineNumberType lineNumber);

  public:
    static RefCDOmStmtEventTrigger cast (RefCDOmBase object);

    static RefCDOmStmtEventTrigger build(TLineNumberType lineNumber, RefCDOmExprLink hid, RefCDOmListExpr exprList = RefCDOmListExpr());

    RefCDOmExprLink getHID() const;

    RefCDOmListExpr getExprList() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const; 

};

// ********************************************************************************
// CDOmStmtLoop class
// ********************************************************************************
/**
 * This class models a loop statement according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * loop_statement ::=
 *   forever statement
 *   | repeat ( expression ) statement
 *   | while ( expression ) statement
 *   | for ( variable_assignment ; expression ; variable_assignment )
 *   statement
 * </code></pre>
 */
class CDOmStmtLoop : public CDOmStmt {
  public:
    /**
     * Holds enum constants for loop types.
     */
    enum ELoopType {LOOP_FOREVER, LOOP_REPEAT, LOOP_WHILE, LOOP_FOR};
  

  private:
    RefCDOmStmtLoop getThis() const { return boost::static_pointer_cast<CDOmStmtLoop>(m_weakRef.lock()); }
 
    ELoopType m_loopType;

    CDOmStmtLoop(TLineNumberType lineNumber, ELoopType loopType);

  public:
    static RefCDOmStmtLoop cast (RefCDOmBase object);
  
    static RefCDOmStmtLoop buildForeverStmt(TLineNumberType lineNumber, RefCDOmStmt stmt);

    static RefCDOmStmtLoop buildRepeatStmt(TLineNumberType lineNumber, RefCDOmExpr expr, RefCDOmStmt stmt);

    static RefCDOmStmtLoop buildWhileStmt(TLineNumberType lineNumber, RefCDOmExpr expr, RefCDOmStmt stmt);

    static RefCDOmStmtLoop buildForStmt(TLineNumberType lineNumber, RefCDOmAssn initAssn, RefCDOmExpr condExpr, RefCDOmAssn incAssn, RefCDOmStmt stmt);

    ELoopType getLoopType() const;

    RefCDOmStmt getStmt() const;

    RefCDOmExpr getExpr() const; // in case of for loop this returns condExpr

    RefCDOmAssn getInitForAssn() const;

    RefCDOmAssn getIncForAssn() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const; 

};

// ********************************************************************************
// CDOmStmtBlock class
// ********************************************************************************
/**
 * This class models a block statement according to the grammar rules.
 * It is used for both parallel and sequential block statements. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * par_block ::= fork [ : block_identifier
 *   { block_item_declaration } ] { statement } join
 * seq_block ::= begin [ : block_identifier
 *   { block_item_declaration } ] { statement } end
 *
 * block_item_declaration ::=
 *   { attribute_instance } reg [ signed ] [ range ] list_of_block_variable_identifiers ;
 *   | { attribute_instance } integer list_of_block_variable_identifiers ;
 *   | { attribute_instance } time list_of_block_variable_identifiers ;
 *   | { attribute_instance } real list_of_block_real_identifiers ;
 *   | { attribute_instance } realtime list_of_block_real_identifiers ;
 *   | { attribute_instance } event_declaration
 *   | { attribute_instance } local_parameter_declaration ;
 *   | { attribute_instance } parameter_declaration ;
 * </code></pre>
 */
class CDOmStmtBlock : public CDOmStmt {
  public:
    /*
     * Holds enum constants for procedural continuous assign types.
     */
    enum EBlockType {BLOCK_PARALLEL, BLOCK_SEQUENTIAL};

  private:
    RefCDOmStmtBlock getThis() const { return boost::static_pointer_cast<CDOmStmtBlock>(m_weakRef.lock()); }

    EBlockType m_blockType;
    RefCDOmScope m_scope; // used by named blocks

    CDOmStmtBlock(TLineNumberType lineNumber, EBlockType blockType, TBool isNamed);

  public:
    static RefCDOmStmtBlock cast (RefCDOmBase object);
  
    static RefCDOmStmtBlock build(TLineNumberType lineNumber, EBlockType blockType, const RefString& name = RefString());

    RefCDOmScope getAttachedScope() const;

    EBlockType getBlockType() const;

    TBool isNamed() const;

    void addStmt(RefCDOmStmt stmt);

    const RefTVec_RefCDOmStmt getStmts() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmAssn class
// ********************************************************************************
/**
 * This class models an assignment according to the grammar rules.
 * It is used for both net and variable assignments. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * net_assignment ::= net_lvalue = expression
 * variable_assignment ::= variable_lvalue = expression
 * </code></pre>
 */
class CDOmAssn : public CDOmBase {
  private:
    RefCDOmAssn getThis() const { return boost::static_pointer_cast<CDOmAssn>(m_weakRef.lock()); }

    CDOmAssn(TLineNumberType lineNumber);

  public:
    static RefCDOmAssn cast (RefCDOmBase object );

    static RefCDOmAssn build(TLineNumberType lineNumber, RefCDOmExpr lvalue, RefCDOmExpr expr);

    RefCDOmExpr getLvalue() const;

    RefCDOmExpr getExpr() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;

};

// ********************************************************************************
// CDOmStmtProcContAssn class
// ********************************************************************************
/**
 * This class models procedural continuous assign statements according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * procedural_continuous_assignments ::=
 *   assign variable_assignment
 *   | deassign variable_lvalue
 *   | force variable_assignment
 *   | force net_assignment
 *   | release variable_lvalue
 *   | release net_lvalue
 * </code></pre>
 */
class CDOmStmtProcContAssn : public CDOmStmt {
  public:
    /**
     * Holds enum constants for procedural continuous assign types.
     */
    enum EProcContAssnType {PROC_CONT_ASSN_ASSIGN, PROC_CONT_ASSN_DEASSIGN, PROC_CONT_ASSN_FORCE, PROC_CONT_ASSN_RELEASE};

  private:
    RefCDOmStmtProcContAssn getThis() const { return boost::static_pointer_cast<CDOmStmtProcContAssn>(m_weakRef.lock()); } 

    EProcContAssnType m_procContAssnType;

    CDOmStmtProcContAssn(TLineNumberType lineNumber, EProcContAssnType procContAssnType);

  public:
    static RefCDOmStmtProcContAssn cast (RefCDOmBase object);

    static RefCDOmStmtProcContAssn build(TLineNumberType lineNumber, EProcContAssnType procContAssnType, RefCDOmAssn assn);

    static RefCDOmStmtProcContAssn build(TLineNumberType lineNumber, EProcContAssnType procContAssnType, RefCDOmExpr lvalue);

    EProcContAssnType getProcContAssnType() const;

    RefCDOmAssn getAssn() const;

    RefCDOmExpr getLvalue() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmStmtProcTimingControl class
// ********************************************************************************
/**
 * This class models procedural timing control statements according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * procedural_timing_control_statement ::=
 *   procedural_timing_control statement_or_null
 * procedural_timing_control ::=
 *   delay_control
 *   | event_control
 * </code></pre>
 */
class CDOmStmtProcTimingControl : public CDOmStmt {
  public:
    /**
     * Holds enum constants for procedural timing control types.
     */
    enum EProcTimingControlType {PROC_TIMING_CONTROL_DELAY, PROC_TIMING_CONTROL_EVENT};

  private:
    RefCDOmStmtProcTimingControl getThis() const { return boost::static_pointer_cast<CDOmStmtProcTimingControl>(m_weakRef.lock()); }

    EProcTimingControlType m_procTimingControlType;

    CDOmStmtProcTimingControl(TLineNumberType lineNumber, EProcTimingControlType procTimingControlType);

  public:
    static RefCDOmStmtProcTimingControl cast (RefCDOmBase object);

    static RefCDOmStmtProcTimingControl buildWithDelayControl(TLineNumberType lineNumber, RefCDOmDelayControl delayControl, RefCDOmStmt stmt);

    static RefCDOmStmtProcTimingControl buildWithEventControl(TLineNumberType lineNumber, RefCDOmEventControl eventControl, RefCDOmStmt stmt);

    EProcTimingControlType getProcTimingControlType() const;

    RefCDOmDelayControl getDelayControl() const;

    RefCDOmEventControl getEventControl() const;

    RefCDOmStmt getStmt() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmStmtTaskEnable class
// ********************************************************************************
/**
 * This class models a task enable statement according to the grammar rules.
 * It is used for both task and system task enable statements. <br/> <br/>
 *
 * <b>PDF SPEC 9.4: White Space</b> <br/>
 * The $ character in a system_function_identifier or system_task_identifier shall not be followed
 * by white_space. A system_function_identifier or system_task_identifier shall not be escaped. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * task_enable ::= hierarchical_task_identifier [ ( expression { , expression } ) ] ;
 * system_task_enable ::= system_task_identifier [ ( [ expression ] { , [ expression ] } ) ] ;
 *
 * hierarchical_task_identifier ::= hierarchical_identifier
 * system_task_identifier ::= $[ a-zA-Z0-9_$ ] { [ a-zA-Z0-9_$ ] }
 * </code></pre>
 */
class CDOmStmtTaskEnable : public CDOmStmt {
  public:
    /**
     * Holds enum constants for task enable types.
     */
    enum ETaskEnableType {TASK_ENABLE_TASK, TASK_ENABLE_SYSTEM};

  private:
    RefCDOmStmtTaskEnable getThis() const { return boost::static_pointer_cast<CDOmStmtTaskEnable>(m_weakRef.lock()); } 

    ETaskEnableType m_taskEnableType;

    CDOmStmtTaskEnable(TLineNumberType lineNumber, ETaskEnableType taskEnableType);
    RefTVec_RefCDOmExpr m_exprs;

  public:
    static RefCDOmStmtTaskEnable cast (RefCDOmBase object);

    static RefCDOmStmtTaskEnable build(TLineNumberType lineNumber, ETaskEnableType taskEnableType, RefCDOmExprLink hid);

    void addExpr(RefCDOmExpr expr);

    ETaskEnableType getTaskEnableType() const;
    RefCDOmExprLink getHID() const;
    const RefTVec_RefCDOmExpr getExprList() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmStmtWait class
// ********************************************************************************
/**
 * This class models a wait statement according to the grammar rules.
 * It is used for both task and system task enable statements. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * wait_statement ::=
 *   wait ( expression ) statement_or_null
 * </code></pre>
 */
class CDOmStmtWait : public CDOmStmt {
  private:
    RefCDOmStmtWait getThis() const { return boost::static_pointer_cast<CDOmStmtWait>(m_weakRef.lock()); }
 
    CDOmStmtWait(TLineNumberType lineNumber);

  public:
    static RefCDOmStmtWait cast(RefCDOmBase object);

    static RefCDOmStmtWait build(TLineNumberType lineNumber, RefCDOmExpr expr, RefCDOmStmt stmt);

    RefCDOmExpr getExpr() const;

    RefCDOmStmt getStmt() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmRange class
// ********************************************************************************
/**
 * This class is used to model both range and dimension according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * range ::= [ msb_constant_expression : lsb_constant_expression ]
 * msb_constant_expression ::= constant_expression
 * lsb_constant_expression ::= constant_expression
 *
 * dimension ::= [ dimension_constant_expression : dimension_constant_expression ]
 * dimension_constant_expression ::= constant_expression
 * </code></pre>
 *
 * @see CDOmRangeList
 */
class CDOmRange : public CDOmBase {
  private:
    RefCDOmRange getThis() const { return boost::static_pointer_cast<CDOmRange>(m_weakRef.lock()); }

    CDOmRange(TLineNumberType lineNumber);

  public:
    static RefCDOmRange cast (RefCDOmBase object);

    static RefCDOmRange build(TLineNumberType lineNumber, RefCDOmExpr firstExpr, RefCDOmExpr secondExpr);

    RefCDOmExpr getFirstExpr() const;

    RefCDOmExpr getSecondExpr() const;

    TUInt getWidth() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};


// ********************************************************************************
// CDOmRangeExpr class
// ********************************************************************************
/**
 * This class models a range expression according to the grammar rules.
 * <b>NOTE: </b>this class in NOT an expression, that is it is NOT derived from CDOmExpr <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * range_expression ::=
 *   expression
 *   | msb_constant_expression : lsb_constant_expression
 *   | base_expression +: width_constant_expression
 *   | base_expression -: width_constant_expression
 * 
 * constant_range_expression ::=
 *   constant_expression
 *   | msb_constant_expression : lsb_constant_expression
 *   | constant_base_expression +: width_constant_expression
 *   | constant_base_expression -: width_constant_expression
 *
 * msb_constant_expression ::= constant_expression
 * lsb_constant_expression ::= constant_expression
 * base_expression ::= expression
 * constant_base_expression ::= constant_expression
 * width_constant_expression ::= constant_expression
 * </code></pre>
 */
class CDOmRangeExpr : public CDOmBase {
  public:
    /**
     * Holds enum constants for range expression types.
     */
    enum ERangeExprType {RANGE_EXPR_SINGLE, RANGE_EXPR_DOUBLE, RANGE_EXPR_PLUS, RANGE_EXPR_MINUS};

  private:
    RefCDOmRangeExpr getThis() const { return boost::static_pointer_cast<CDOmRangeExpr>(m_weakRef.lock()); } 

    ERangeExprType m_rangeExprType;
    TBool m_isConst;

    CDOmRangeExpr(TLineNumberType lineNumber, ERangeExprType rangeExprType, TBool isConst);

  public:
    static RefCDOmRangeExpr cast (RefCDOmBase object);
  
    static RefCDOmRangeExpr buildSingleRangeExpr(TLineNumberType lineNumber, RefCDOmExpr firstExpr);

    static RefCDOmRangeExpr buildDoubleRangeExpr(TLineNumberType lineNumber, RefCDOmExpr firstExpr, RefCDOmExpr secondExpr, ERangeExprType rangeExprType = RANGE_EXPR_DOUBLE);

    ERangeExprType getRangeExprType() const;

    RefCDOmExpr getFirstExpr() const;

    RefCDOmExpr getSecondExpr() const;

    TBool isConst() const;

    TUInt getWidth() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmParamDecl class
// ********************************************************************************
/**
 * This class models parameter declarations according to the grammar rules.
 * It is used for parameter, local parameter and specify parameter. <br/> <br/>
 *
 * <b>PDF SPEC 3.11: Parameters</b> <br/>
 * Both types of parameters accept a range specification. By default, parameters and specparams shall be as
 * wide as necessary to contain the value of the constant, except when a range specification is present. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * local_parameter_declaration ::=
 *   localparam [ signed ] [ range ] list_of_param_assignments
 *   | localparam parameter_type list_of_param_assignments
 * parameter_declaration ::=
 *   parameter [ signed ] [ range ] list_of_param_assignments
 *   | parameter parameter_type list_of_param_assignments
 * specparam_declaration ::=
 *   specparam [ range ] list_of_specparam_assignments ;
 *
 * list_of_param_assignments ::= param_assignment { , param_assignment }
 * param_assignment ::= parameter_identifier = constant_mintypmax_expression
 * parameter_identifier ::= identifier
 * constant_mintypmax_expression ::=
 *   constant_expression
 *   | constant_expression : constant_expression : constant_expression
 * parameter_type ::=
 *   integer | real | realtime | time
 *
 * list_of_specparam_assignments ::= specparam_assignment { , specparam_assignment }
 * specparam_assignment ::=
 *   specparam_identifier = constant_mintypmax_expression
 *   | pulse_control_specparam
 * specparam_identifier ::= identifier
 * pulse_control_specparam ::=
 *   PATHPULSE$ = ( reject_limit_value [ , error_limit_value ] ) ;
 *   | PATHPULSE$specify_input_terminal_descriptor$specify_output_terminal_descriptor
 *     = ( reject_limit_value [ , error_limit_value ] ) ;
 * reject_limit_value ::= limit_value
 * error_limit_value ::= limit_value
 * limit_value ::= constant_mintypmax_expression
 * specify_input_terminal_descriptor ::=
 *   input_identifier [ [ constant_range_expression ] ]
 * specify_output_terminal_descriptor ::=
 *   output_identifier [ [ constant_range_expression ] ]
 * input_identifier ::= input_port_identifier | inout_port_identifier
 * output_identifier ::= output_port_identifier | inout_port_identifier
 * input_port_identifier ::= identifier
 * inout_port_identifier ::= identifier
 * output_port_identifier ::= identifier
 * </code></pre>
 *
 * @see CDOmParamDeclCollection
 */
class CDOmParamDecl : public CDOmAttrHolder {
  public:
    /**
     * Holds enum constants for parameter declaration types.
     */
    enum EParamDeclType {PARAM_DECL_SIMPLE, PARAM_DECL_LOCAL, PARAM_DECL_SPEC};

    /**
     * Holds enum constants for parameter types.
     */
    enum EParamType {PARAM_NA, PARAM_INTEGER, PARAM_REAL, PARAM_REALTIME, PARAM_TIME};

    enum EParamDeclType2 {DECL_NA, DECL_1, DECL_2};

  private:
    RefCDOmParamDecl getThis() const { return boost::static_pointer_cast<CDOmParamDecl>(m_weakRef.lock()); }

    EParamDeclType m_paramDeclType;
    EParamDeclType2 m_paramDeclType2;

    TBool m_isSigned;       // used by DECL_1 (PARAM_DECL_SIMPLE, PARAM_DECL_LOCAL)
    RefCDOmRange m_range;   // used by DECL_1 (PARAM_DECL_SIMPLE, PARAM_DECL_LOCAL), DECL_NA (PARAM_DECL_SPEC)
    EParamType m_paramType; // used by DECL_2 (PARAM_DECL_SIMPLE, PARAM_DECL_LOCAL)

    RefTMap_RefString_RefCDOmIdentifier m_nameMap;

    CDOmParamDecl(TLineNumberType lineNumber, EParamDeclType paramDeclType, EParamDeclType2 paramDeclType2, EParamType paramType);

  public:
    static RefCDOmParamDecl cast (RefCDOmBase object);
  
    // used by DECL_1 (PARAM_DECL_SIMPLE, PARAM_DECL_LOCAL), DECL_NA (PARAM_DECL_SPEC)
    static RefCDOmParamDecl build(TLineNumberType lineNumber, RefCDOmBase parent, EParamDeclType paramDeclType);

    // used by DECL_2 (PARAM_DECL_SIMPLE, PARAM_DECL_LOCAL)
    static RefCDOmParamDecl build(TLineNumberType lineNumber, RefCDOmBase parent, EParamDeclType paramDeclType, EParamType paramType);

    EParamDeclType getParamDeclType() const;

    //added for CodeGen
    EParamDeclType2 getParamDeclType2() const;

    void setSigned();

    TBool isSigned() const;

    void setRange(RefCDOmRange range);

    RefCDOmRange getRange() const;

    EParamType getParamType() const;

    void addParam(TLineNumberType lineNumber, const RefString& name, RefCDOmMinTypMax minTypMax);

    void addPulseControl(TLineNumberType lineNumber, RefCDOmMinTypMax rejectLimitValue, RefCDOmMinTypMax errorLimitValue = RefCDOmMinTypMax());

    void addPulseControl(TLineNumberType lineNumber, RefCDOmExprLink inputTerminalExprLink, RefCDOmExprLink outputTerminalExprLink,
                         RefCDOmMinTypMax rejectLimitValue, RefCDOmMinTypMax errorLimitValue = RefCDOmMinTypMax());

    TBool containsParam(const RefString& name) const;

    //used in CDOm Visitor and CodeGen
    RefTMap_RefString_RefCDOmIdentifier getNameMap() const { return m_nameMap; }

    RefCDOmMinTypMax getParamVal(const RefString& name) const;

    const RefTVec_RefCDOmIdentifier getIDs() const;

    const RefTVec_RefCDOmPulseControl getPulseControls() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmPulseControl class
// ********************************************************************************
/**
 * This class models a pulse control according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * pulse_control_specparam ::=
 *   PATHPULSE$ = ( reject_limit_value [ , error_limit_value ] ) ;
 *   | PATHPULSE$specify_input_terminal_descriptor$specify_output_terminal_descriptor
 *     = ( reject_limit_value [ , error_limit_value ] ) ;
 * reject_limit_value ::= limit_value
 * error_limit_value ::= limit_value
 * limit_value ::= constant_mintypmax_expression
 * specify_input_terminal_descriptor ::=
 *   input_identifier [ [ constant_range_expression ] ]
 * specify_output_terminal_descriptor ::=
 *   output_identifier [ [ constant_range_expression ] ]
 * input_identifier ::= input_port_identifier | inout_port_identifier
 * output_identifier ::= output_port_identifier | inout_port_identifier
 * input_port_identifier ::= identifier
 * inout_port_identifier ::= identifier
 * output_port_identifier ::= identifier
 * </code></pre>
 */
class CDOmPulseControl : public CDOmBase {
  private:
    RefCDOmPulseControl getThis() const { return boost::static_pointer_cast<CDOmPulseControl>(m_weakRef.lock()); } 

    RefCDOmExprLink m_inputTerminalExprLink;
    RefCDOmExprLink m_outputTerminalExprLink;

    RefCDOmMinTypMax m_rejectLimitValue;
    RefCDOmMinTypMax m_errorLimitValue;

    CDOmPulseControl(TLineNumberType lineNumber, const RefCDOmExprLink& inputTerminalExprLink, const RefCDOmExprLink& outputTerminalExprLink,
                     const RefCDOmMinTypMax& rejectLimitValue, const RefCDOmMinTypMax& errorLimitValue);

    // since these method are private, some friend class declarations are needed:
    friend class CDOmParamDecl;

    static RefCDOmPulseControl build(TLineNumberType lineNumber, RefCDOmParamDecl parent,
                                     RefCDOmMinTypMax rejectLimitValue, RefCDOmMinTypMax errorLimitValue);

    static RefCDOmPulseControl build(TLineNumberType lineNumber, RefCDOmParamDecl parent,
                                     RefCDOmExprLink inputTerminalExprLink, RefCDOmExprLink outputTerminalExprLink,
                                     RefCDOmMinTypMax rejectLimitValue, RefCDOmMinTypMax errorLimitValue);

  public:
    static RefCDOmPulseControl cast (RefCDOmBase object);

    RefCDOmExprLink getInputTerminalExprLink() const;

    RefCDOmExprLink getOutputTerminalExprLink() const;

    RefCDOmMinTypMax getRejectLimitValue() const;

    RefCDOmMinTypMax getErrorLimitValue() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmParamDeclCollection class
// ********************************************************************************
/**
 * This class holds multiple paramater declarations. It is similar to a vector of paramater declarations.<br/>
 * It is used to hold the following grammar construct: <br/>
 * <pre><code>
 * { parameter_declaration }
 * </code></pre>
 *
 * @see CDOmParamDecl
 */
class CDOmParamDeclCollection : public CDOmBase {
  private:
    RefCDOmParamDeclCollection getThis() const { return boost::static_pointer_cast<CDOmParamDeclCollection>(m_weakRef.lock()); } 

    CDOmParamDeclCollection(TLineNumberType lineNumber);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmModuleDecl;
    static RefCDOmParamDeclCollection build(TLineNumberType lineNumber, RefCDOmModuleDecl parent);

  public:
    static RefCDOmParamDeclCollection cast (RefCDOmBase object);

    const RefTVec_RefCDOmParamDecl getParamDecls() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmPortDecl class
// ********************************************************************************
/**
 * This class models port declarations according to the grammar rules.
 * It is used for input, output and inout port declarations. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * inout_declaration ::= inout [ net_type ] [ signed ] [ range ]
 *   list_of_port_identifiers
 * input_declaration ::= input [ net_type ] [ signed ] [ range ]
 *   list_of_port_identifiers
 * output_declaration ::=
 *   output [ net_type ] [ signed ] [ range ]
 *     list_of_port_identifiers
 *   | output reg [ signed ] [ range ]
 *     list_of_variable_port_identifiers
 *   | output output_variable_type
 *     list_of_variable_port_identifiers
 *
 * net_type ::=
 *   supply0 | supply1
 *   | tri | triand | trior | tri0 | tri1
 *   | wire | wand | wor
 * list_of_port_identifiers ::= port_identifier { , port_identifier }
 * port_identifier ::= identifier
 * list_of_variable_port_identifiers ::= port_identifier [ = constant_expression ]
 *   { , port_identifier [ = constant_expression ] }
 * output_variable_type ::= integer | time
 * </code></pre>
 */
class CDOmPortDecl : public CDOmAttrHolder {
  private:
    RefCDOmPortDecl getThis() const { return boost::static_pointer_cast<CDOmPortDecl>(m_weakRef.lock()); }

    ECDOmPortType m_portType;
    ECDOmNetType m_netType; // used by PORT_INOUT, PORT_INPUT, PORT_OUTPUT (m_varType = VAR_UNDEFINED)
    ECDOmVarType m_varType; // used by PORT_OUTPUT (m_netType = NET_UNDEFINED)
    TBool m_isSigned;       // used by PORT_INOUT, PORT_INPUT, PORT_OUTPUT (m_varType = VAR_UNDEFINED | m_varType = VAR_REG)
    RefCDOmRange m_range;   // used by PORT_INOUT, PORT_INPUT, PORT_OUTPUT (m_varType = VAR_UNDEFINED | m_varType = VAR_REG)

    RefTMap_RefString_RefCDOmIdentifier m_nameMap;

    CDOmPortDecl(TLineNumberType lineNumber, ECDOmPortType portType, ECDOmNetType netType, ECDOmVarType varType);

  public:
    static RefCDOmPortDecl cast (RefCDOmBase object);
    static RefCDOmPortDecl buildNetPortDecl(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmPortType portType, ECDOmNetType netType = NET_UNDEFINED);

    static RefCDOmPortDecl buildVarPortDecl(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmVarType varType);

    ECDOmPortType getPortType() const;

    ECDOmNetType getNetType() const;

    ECDOmVarType getVarType() const;

    /**
     * Sets the signed status to this port declaration. If this port declaration does not support sign,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown.
     *
     * @see ECDOmVarType
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
     * Attaches a range to this port declaration. If this port declaration does not support range,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown.
     *
     * @param range the range to be attached to this port declaration
     * @see ECDOmVarType
     */
    void setRange(RefCDOmRange range);

    /**
     * Returns the range attached to this port declaration. If this port declaration does not support range,
     * that is the case of output variable declaration of type VAR_INTEGER or VAR_TIME, an exception is thrown. <br/>
     * On valid cases where no range is attached this method returns null, that is calling get() on returned
     * object returns 0.
     *
     * @return the range attached to this port declaration or null if no range is attached
     * @see ECDOmVarType
     */
    RefCDOmRange getRange() const;

    /**
     * Adds a port with its optional value to this port declaration. Non null port values are only supported for output variable
     * declarations of type VAR_REG, VAR_INTEGER or VAR_TIME. If this is constraint is not met an exception is thrown.
     *
     * @param name the name of port to be added to this port declaration
     * @param expr [=RefCDOmExpr()] the value of port
     * @see ECDOmVarType
     */
    void addPort(TLineNumberType lineNumber, const RefString& name, RefCDOmExpr expr = RefCDOmExpr());

    TBool containsPort(const RefString& name) const;

    /**
     * Finds the port whose name maches the passed in name and returns its value. It this port declaration does not support
     * port values or if the port is not found an exception is thrown.
     * Only output variable declarations of type VAR_REG, VAR_INTEGER or VAR_TIME support port values.
     *
     * @return the port value of the port whose name maches the passed in name
     * @see #addPort
     * @see ECDOmVarType
     */
    RefCDOmExpr getPortVal(const RefString& name) const;

    /**
     * Returns a vector containing all port identifiers that are attached to this port declaration.
     *
     * @return a vector containing all port identifiers that are attached to this port declaration
     */
    const RefTVec_RefCDOmIdentifier getIDs() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmUdpPortDeclOutput class
// ********************************************************************************
/**
 * This class models UDP port declarations according to the grammar rules.
 * It is used for output and/or reg port declarations. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * udp_output_declaration ::=
 *     { attribute_instance } output port_identifier
 *   | { attribute_instance } output reg port_identifier [ = constant_expression ]
 *
 * udp_reg_declaration ::= { attribute_instance } reg variable_identifier
 * </code></pre>
 */
class CDOmUdpPortDeclOutput : public CDOmAttrHolder {
  public:
    enum EUdpPortDeclOutputType { UDP_DECL_TYPE_OUTPUT, UDP_DECL_TYPE_REG, UDP_DECL_TYPE_OUTPUT_REG };

  private:
    RefCDOmUdpPortDeclOutput getThis() const { return boost::static_pointer_cast<CDOmUdpPortDeclOutput>(m_weakRef.lock()); }  
 
    EUdpPortDeclOutputType m_portType;

    CDOmUdpPortDeclOutput(TLineNumberType lineNumber, EUdpPortDeclOutputType portType);

  public:
    static RefCDOmUdpPortDeclOutput cast (RefCDOmBase object);

    static RefCDOmUdpPortDeclOutput build(TLineNumberType lineNumber, RefCDOmUdpDecl parent, EUdpPortDeclOutputType type, RefString portName, RefCDOmExpr expr = RefCDOmExpr());
    EUdpPortDeclOutputType getPortType() const;

    virtual TBool containsPort(const RefString& name) const;

    const RefCDOmIdentifier getID() const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmUdpPortDeclInput class
// ********************************************************************************
/**
 * This class models UDP port declarations according to the grammar rules.
 * It is used for input port declarations. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * udp_input_declaration ::= { attribute_instance } input list_of_port_identifiers
 * </code></pre>
 */
class CDOmUdpPortDeclInput : public CDOmAttrHolder {
  private:
    RefCDOmUdpPortDeclInput getThis() const { return boost::static_pointer_cast<CDOmUdpPortDeclInput>(m_weakRef.lock()); }

    RefTMap_RefString_RefCDOmIdentifier m_nameMap;
    CDOmUdpPortDeclInput(TLineNumberType lineNumber);
  public:
    static RefCDOmUdpPortDeclInput cast (RefCDOmBase object);
    static RefCDOmUdpPortDeclInput build(TLineNumberType lineNumber, RefCDOmUdpDecl parent, const RefString portName);
    void addPort(TLineNumberType lineNumber, const RefString portName);
    TBool containsPort(const RefString& name) const;
    const RefTVec_RefCDOmIdentifier getIDs() const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmPortItem class
// ********************************************************************************
/**
 * This class models a port item according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * port ::=
 *   [ port_expression ]
 *   | . port_identifier ( [ port_expression ] )
 * port_expression ::=
 *   port_reference
 *   | { port_reference { , port_reference } }
 * port_reference ::=
 *   port_identifier [ [ constant_range_expression ] ]
 * port_identifier ::= identifier
 * </code></pre>
 */
class CDOmPortItem : public CDOmBase {
  public:
    /**
     * Holds enum constants for port item types.
     */
    enum EPortItemType {PORT_ITEM_EMPTY, PORT_ITEM_SIMPLE, PORT_ITEM_CONCAT};

  private:
    RefCDOmPortItem getThis() const { return boost::static_pointer_cast<CDOmPortItem>(m_weakRef.lock()); }
 
    EPortItemType m_portItemType;

    CDOmPortItem(TLineNumberType lineNumber, EPortItemType portItemType);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmModuleDecl;
    static RefCDOmPortItem build(TLineNumberType lineNumber, RefCDOmModuleDecl parent, EPortItemType portItemType, const RefString& explicitName);

  public:
    static RefCDOmPortItem cast (RefCDOmBase object);

    EPortItemType getPortItemType() const;

    /**
     * Returns the explicit name of this port item. If there is no explicit name set on this port item,
     * this method returns null, that is calling get() on returned object returns 0.
     *
     * @return the explicit name of this port item or null if no explicit name was set
     */
    RefString getExplicitName() const;

    /**
     * Adds a new exprLink to this port item. If this port item is of PORT_ITEM_EMPTY type
     * or it is of PORT_ITEM_SIMPLE type and a exprLink was already added, an exception is thrown.
     *
     * @param exprLink the exprLink to be added to this port item
     * @see EPortItemType
     */
    void addPortExprLink(RefCDOmExprLink exprLink);

    /**
     * Returns the only exprLink if this port item is of PORT_ITEM_SIMPLE type, otherwhise
     * an exception is thrown.
     *
     * @return the only exprLink of this port item
     * @see EPortItemType
     */
    const RefCDOmExprLink getExprLink() const;

    /**
     * Returns a vector of all exprLinks if this port item is of PORT_ITEM_CONCAT type, otherwhise
     * an exception is thrown.
     *
     * @return a vector of all exprLinks of this port item
     * @see EPortItemType
     */
    const RefTVec_RefCDOmExprLink getExprLinks() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmModuleDecl class
// ********************************************************************************
/**
 * The problem with the port declarations is that if a port predeclarations 
 * are made with list of ports, you can predeclare the list_of ports rule, you can
 * declare the actual port type whenever later, but you can't do that if you 
 * declare the ports in the list_of_ports section, that is it, it you want extra 
 * ports, you have to add them there
 *
 * This class models a module declaration according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * module_declaration ::=
 *   { attribute_instance } module_keyword module_identifier [ module_parameter_port_list ]
 *     list_of_ports ; { module_item }
 *     endmodule
 *   | { attribute_instance } module_keyword module_identifier [ module_parameter_port_list ]
 *     [ list_of_port_declarations ] ; { non_port_module_item }
 *     endmodule
 *
 * module_keyword ::= module | macromodule
 * module_identifier ::= identifier
 * module_parameter_port_list ::= # ( parameter_declaration { , parameter_declaration } )
 * list_of_ports ::= ( port { , port } )
 * list_of_port_declarations ::=
 *   ( port_declaration { , port_declaration } )
 *   | ( )
 * port_declaration ::=
 *   {attribute_instance} inout_declaration
 *   | {attribute_instance} input_declaration
 *   | {attribute_instance} output_declaration
 *
 * module_item ::=
 *   port_declaration ;
 *   | non_port_module_item
 * non_port_module_item ::=
 *   module_or_generate_item
 *   | specify_block
 *   | generated_instantiation
 *   | { attribute_instance } local_parameter_declaration ;
 *   | { attribute_instance } parameter_declaration ;
 *   | { attribute_instance } specparam_declaration
 * module_or_generate_item ::=
 *   { attribute_instance } module_or_generate_item_declaration
 *   | { attribute_instance } parameter_override
 *   | { attribute_instance } continuous_assign
 *   | { attribute_instance } gate_instantiation
 *   | { attribute_instance } udp_instantiation
 *   | { attribute_instance } module_instantiation
 *   | { attribute_instance } initial_construct
 *   | { attribute_instance } always_construct
 * module_or_generate_item_declaration ::=
 *   net_declaration
 *   | reg_declaration
 *   | integer_declaration
 *   | real_declaration
 *   | time_declaration
 *   | realtime_declaration
 *   | event_declaration
 *   | genvar_declaration
 *   | task_declaration
 *   | function_declaration
 * </code></pre>
 */
class CDOmModuleDecl : public CDOmAttrHolder {
  public:
    /**
     * Holds enum constants for module keyword types.
     */
    enum EKeywordType {KEYWORD_MODULE, KEYWORD_MACROMODULE};
    enum ECslSourceUnitType {
      GEN_FROM_UNDEFINED,
      GEN_FROM_UNIT,
      GEN_FROM_FIFO,
      GEN_FROM_TB,
      GEN_FROM_REG,
      GEN_FROM_REG_FILE,
      GEN_FROM_MEM,
      GEN_FROM_STATE_DATA,
      GEN_FROM_VECTOR,
      GEN_FROM_MAX
    };

  private:
    RefCDOmModuleDecl getThis() const { return boost::static_pointer_cast<CDOmModuleDecl>(m_weakRef.lock()); }

    enum EModuleDeclType {UNDEFINED, DECL_1, DECL_2};

    EKeywordType m_keywordType;
    EModuleDeclType m_moduleDeclType;
    ECslSourceUnitType m_cslSourceUnitType;

    RefCDOmScope m_scope; // attached scope

    RefCDOmParamDeclCollection m_paramDeclCollection;

    RefTVec_RefCDOmPortItem m_portItems;                     // used by DECL_1
    RefTMap_RefString_RefCDOmExprLink m_portNameMap;         // used by DECL_1 to detect duplicate port names
    RefTMap_RefString_RefCDOmPortItem m_explicitPortNameMap; // used by DECL_1 to detect duplicate explicit port names

    CDOmModuleDecl(TLineNumberType lineNumber, EKeywordType keywordType);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmPortItem;
    void registerPortExprLink(const RefString& name, const RefCDOmExprLink& portExprLink);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmBase;
    void beforeAddingModuleItem(TBool isPortDecl);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmDesign;
    static RefCDOmModuleDecl build(TLineNumberType lineNumber, RefCDOmDesign parent, const RefString& name, EKeywordType keywordType);

    //added by AB: bool to check if this is a top unit
    TBool m_isInstantiated;
  public:
    static RefCDOmModuleDecl cast (RefCDOmBase object);
    
    RefCDOmScope getAttachedScope() const;

    EKeywordType getKeywordType() const;

    TBool hasParamDeclCollection() const;

    /**
     * This method properly builds and attaches a new parameter declaration collection
     * to this module declaration; 
     * @return the attached parameter declaration collection
     */
    void buildParamDeclCollection(TLineNumberType lineNumber);

    /**
     * The following two methods return the parameter declaration collection.
     */
    
    RefCDOmParamDeclCollection getParamDeclCollection();
    const RefCDOmParamDeclCollection getParamDeclCollection() const;

    /**
     * Properly builds and attaches a new port item to this module declaration and returns it. <br/> <br/>
     *
     * @param portItemType the port item type
     * @param explicitName [=RefString()] the explicit name to be attached to the port item
     *
     * @return a new port item attached to this module declaration
     */
    RefCDOmPortItem buildPortItem(TLineNumberType lineNumber, CDOmPortItem::EPortItemType portItemType, const RefString& explicitName = RefString());

    TBool containsExplicitPortName(const RefString& name) const;

    RefCDOmPortItem getPortItem(const RefString& explicitPortName) const;

    const RefTVec_RefCDOmPortItem getPortItems() const;

    TBool containsPortExprLink(const RefString& name) const;

    const RefTVec_RefCDOmPortDecl getPortDecls() const;
    
    const RefTVec_RefCDOmPortDecl getOutputPortDecls() const;
    
    const RefTVec_RefCDOmPortDecl getInputPortDecls() const;

    const RefTVec_RefCDOmPortDecl getInoutPortDecls() const;
    
    const RefTVec_RefCDOmBase getInstantiationsAsBase() const { return getChildrenAsBase(TYPE_MODULE_INSTANTIATION); }

    const RefTVec_RefCDOmBase getNetDeclsAsBase() const { return getChildrenAsBase(TYPE_NET_DECL); }

    const RefTVec_RefCDOmBase getVarDeclsAsBase() const { return getChildrenAsBase(TYPE_VAR_DECL); }

    const RefString getModuleName() const; 

    void setCslSourceUnitType(ECslSourceUnitType type);
    ECslSourceUnitType getCslSourceUnitType () const;

    TBool hasInstantiations() const;
    //WARNING: this is a doEval() hack - consider not using 
    //this function after doEval() gets implemented
    const RefTVec_RefCDOmBase getInstancesDeclarationsAsBase() const;

    void isInstantiated();

    const TBool isTopModule() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;

};

// ********************************************************************************
// CDOmUdpDecl class
// ********************************************************************************
/**
 * This class models a udp declaration according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * udp_declaration ::=
 *   { attribute_instance } primitive udp_identifier ( udp_port_list ) ;
 *   udp_port_declaration { udp_port_declaration }
 *   udp_body
 *   endprimitive
 * | { attribute_instance } primitive udp_identifier ( udp_declaration_port_list ) ;
 *   udp_body
 *   endprimitive
 * 
 * udp_port_list ::= output_port_identifier , input_port_identifier { , input_port_identifier }
 * output_port_identifier ::= identifier
 * input_port_identifier ::= identifier
 *
 * udp_declaration_port_list ::=
 *   udp_output_declaration , udp_input_declaration { , udp_input_declaration }
 *
 * udp_port_declaration ::=
 *   udp_output_declaration ;
 * | udp_input_declaration ;
 * | udp_reg_declaration ;
 *
 * udp_body ::= combinational_body | sequential_body
 * combinational_body ::= table combinational_entry { combinational_entry } endtable
 * sequential_body ::= [ udp_initial_statement ] table sequential_entry { sequential_entry } endtable
 * </code></pre>
 */
class CDOmUdpDecl : public CDOmAttrHolder {
  public:
    /**
     * There are two types of possible udp declarations, 
     * one of them is the predeclaration of the ports, //DECL_1
     * the other is without the predeclaration //DECL_2
     */
    enum EUdpDeclType { DECL_UNDEFINED, DECL_1, DECL_2 };
    enum EUdpDeclBodyType { BODY_UNDEFINED, UDP_TYPE_COMBINATIONAL, UDP_TYPE_SEQUENTIAL };

  private:
    RefCDOmUdpDecl getThis() const { return boost::static_pointer_cast<CDOmUdpDecl>(m_weakRef.lock()); }

    RefTVec_RefString m_ports;
    RefCDOmScope m_scope; // attached scope
    EUdpDeclType m_declType;
    EUdpDeclBodyType m_bodyType;
    
    CDOmUdpDecl(TLineNumberType lineNumber);

    friend class CDOmDesign;
    static RefCDOmUdpDecl build(TLineNumberType lineNumber, RefCDOmDesign parent, const RefString& name);

    friend class CDOmBase;
    void beforeAddingPortDecl();
    void beforeAddingUdpEntry(TBool isCombinationalEntry);
    void beforeAddingUdpInitStmt();

  public:
    static RefCDOmUdpDecl cast (RefCDOmBase object);
    RefCDOmScope getAttachedScope() const;
    void addPort(const RefString& portName);
    TBool containsPort(const RefString& portName);
    RefTVec_RefString getPortItemNames() const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmUdpInitStmt class
// ********************************************************************************
/**
 * This class models the initial statement in a sequential udp body according to the grammar rules.<br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * udp_initial_statement ::= initial output_port_identifier = init_val ;
 * </code></pre>
 */
class CDOmUdpInitStmt : public CDOmBase {
  public:
    enum EInitVal { INIT_VAL_1b0, INIT_VAL_1b1, INIT_VAL_1bx, INIT_VAL_1bX, INIT_VAL_1B0, INIT_VAL_1B1, INIT_VAL_1Bx, INIT_VAL_1BX, INIT_VAL_1, INIT_VAL_0 };
  private:
    RefCDOmUdpInitStmt getThis() const { return boost::static_pointer_cast<CDOmUdpInitStmt>(m_weakRef.lock()); }

    EInitVal m_initVal;

    CDOmUdpInitStmt(TLineNumberType lineNumber, EInitVal val);
  public:
    static RefCDOmUdpInitStmt cast (RefCDOmBase object);
    static RefCDOmUdpInitStmt build(TLineNumberType lineNumber, RefCDOmUdpDecl parent, RefCDOmExprLink outputPortId, EInitVal val);
    EInitVal getInitVal() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmUdpCombEntry class
// ********************************************************************************
/**
 * This class models a combinational entry of a UDP declaration according to the grammar rules.<br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * combinational_entry ::= level_input_list : output_symbol ;
 * level_input_list ::= level_symbol { level_symbol }
 * output_symbol ::= 0 | 1 | x | X
 * level_symbol ::= 0 | 1 | x | X | ? | b | B
 * </code></pre>
 */
class CDOmUdpCombEntry : public CDOmBase {
  private:
    RefCDOmUdpCombEntry getThis() const { return boost::static_pointer_cast<CDOmUdpCombEntry>(m_weakRef.lock()); }

    ECDOmUdpSymbol m_outputSymbol;
    RefTVec_ECDOmUdpSymbol m_inputList;

    CDOmUdpCombEntry(TLineNumberType lineNumber, ECDOmUdpSymbol outputSymbol, RefTVec_ECDOmUdpSymbol intputList);
  public:
    static RefCDOmUdpCombEntry cast (RefCDOmBase object);
    static RefCDOmUdpCombEntry build(TLineNumberType lineNumber, RefCDOmUdpDecl parent, RefTVec_ECDOmUdpSymbol inputList, ECDOmUdpSymbol outputSymbol);

    ECDOmUdpSymbol getOutputSymbol() const;
    const RefTVec_ECDOmUdpSymbol getInputList() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmUdpSeqEntry class
// ********************************************************************************
/**
 * This class models a sequential entry of a UDP declaration according to the grammar rules.<br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * sequential_entry ::= seq_input_list : current_state : next_state ;
 * seq_input_list ::= level_input_list | edge_input_list
 * level_input_list ::= level_symbol { level_symbol }
 * edge_input_list ::= { level_symbol } edge_indicator { level_symbol }
 * edge_indicator ::= ( level_symbol level_symbol ) | edge_symbol
 * current_state ::= level_symbol
 * next_state ::= output_symbol | -
 * output_symbol ::= 0 | 1 | x | X
 * level_symbol ::= 0 | 1 | x | X | ? | b | B
 * edge_symbol ::= r | R | f | F | p | P | n | N | *
 * </code></pre>
 */
class CDOmUdpSeqEntry : public CDOmBase {
  public:
    enum ESeqEdgeSymbol { EDGE_UNDEF, EDGE_r, EDGE_R, EDGE_f, EDGE_F, EDGE_p, EDGE_P, EDGE_n, EDGE_N, EDGE_STAR };
  private:
    RefCDOmUdpSeqEntry getThis() const { return boost::static_pointer_cast<CDOmUdpSeqEntry>(m_weakRef.lock()); }

    ECDOmUdpSymbol m_currState, m_nextState, m_levelSymbol1, m_levelSymbol2;
    RefTVec_ECDOmUdpSymbol m_levelSymbolList1, m_levelSymbolList2;
    ESeqEdgeSymbol m_edgeSymbol;
    
    CDOmUdpSeqEntry(TLineNumberType lineNumber, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, RefTVec_ECDOmUdpSymbol inputList);
    CDOmUdpSeqEntry(TLineNumberType lineNumber, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, RefTVec_ECDOmUdpSymbol levelSymbolList1, RefTVec_ECDOmUdpSymbol levelSymbolList2, 
                    ECDOmUdpSymbol levelSymbol1, ECDOmUdpSymbol levelSymbol2);
    CDOmUdpSeqEntry(TLineNumberType lineNumber, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, RefTVec_ECDOmUdpSymbol levelSymbolList1, RefTVec_ECDOmUdpSymbol levelSymbolList2,
                    ESeqEdgeSymbol edgeSymbol);
  public:
    static RefCDOmUdpSeqEntry cast (RefCDOmBase object);
    static RefCDOmUdpSeqEntry buildWithLevelInputList(TLineNumberType lineNumber, RefCDOmUdpDecl parent, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, 
                                                      RefTVec_ECDOmUdpSymbol inputList);
    static RefCDOmUdpSeqEntry buildWithEdgeInputList(TLineNumberType lineNumber, RefCDOmUdpDecl parent, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, 
                                                     RefTVec_ECDOmUdpSymbol levelSymbolList1, RefTVec_ECDOmUdpSymbol levelSymbolList2, ECDOmUdpSymbol levelSymbol1, ECDOmUdpSymbol levelSymbol2);
    static RefCDOmUdpSeqEntry buildWithEdgeInputList(TLineNumberType lineNumber, RefCDOmUdpDecl parent, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, 
                                                     RefTVec_ECDOmUdpSymbol levelSymbolList1, RefTVec_ECDOmUdpSymbol levelSymbolList2, ESeqEdgeSymbol edgeSymbol);
    
    ECDOmUdpSymbol getCurrState() const;
    ECDOmUdpSymbol getNextState() const;
    const RefTVec_ECDOmUdpSymbol getLevelInputList() const;
    const RefTVec_ECDOmUdpSymbol getLevelSymbolList1() const;
    const RefTVec_ECDOmUdpSymbol getLevelSymbolList2() const;
    ECDOmUdpSymbol getEdgeIndicator1() const;
    ECDOmUdpSymbol getEdgeIndicator2() const;
    ESeqEdgeSymbol getSeqEdgeSymbol() const;
    TBool hasLevelInputList() const;
    TBool hasEdgeSymbol() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmTFPortDecl class
// ********************************************************************************
/**
 * This class models task and function port declarations according to the grammar rules.
 * It is used for input, output and inout port declarations. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * tf_input_declaration ::=
 *   input [ reg ] [ signed ] [ range ] list_of_port_identifiers
 *   | input task_port_type list_of_port_identifiers
 * tf_output_declaration ::=
 *   output [ reg ] [ signed ] [ range ] list_of_port_identifiers
 *   | output task_port_type list_of_port_identifiers
 * tf_inout_declaration ::=
 *   inout [ reg ] [ signed ] [ range ] list_of_port_identifiers
 *   | inout task_port_type list_of_port_identifiers
 *
 * list_of_port_identifiers ::= port_identifier { , port_identifier }
 * port_identifier ::= identifier
 * task_port_type ::=
 *   integer | real | realtime | time
 * </code></pre>
 */
class CDOmTFPortDecl : public CDOmAttrHolder {
  private:
    RefCDOmTFPortDecl getThis() const { return boost::static_pointer_cast<CDOmTFPortDecl>(m_weakRef.lock()); } 

    ECDOmPortType m_portType;
    ECDOmVarType m_varType;
    TBool m_isSigned;     // used by VAR_REG
    RefCDOmRange m_range; // used by VAR_REG

    RefTMap_RefString_RefCDOmIdentifier m_nameMap;

    CDOmTFPortDecl(TLineNumberType lineNumber, ECDOmPortType portType, ECDOmVarType varType);

  public:
    static RefCDOmTFPortDecl cast (RefCDOmBase object);
    static RefCDOmTFPortDecl build(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmPortType portType, ECDOmVarType varType = VAR_UNDEFINED);

    ECDOmPortType getPortType() const;

    ECDOmVarType getVarType() const;

    /**
     * Sets the signed status to this port declaration. If this port declaration does not support sign,
     * that is the case of variable declaration of type VAR_INTEGER, VAR_REAL, VAR_REALTIME or VAR_TIME,
     * an exception is thrown.
     *
     * @see ECDOmVarType
     */
    void setSigned();

    /**
     * Returns the signed status of this port declaration. If this port declaration does not support sign,
     * that is the case of variable declaration of type VAR_INTEGER, VAR_REAL, VAR_REALTIME or VAR_TIME,
     * an exception is thrown.
     *
     * @return true or false, depending on the sign status of this port declaration
     * @see ECDOmVarType
     */
    TBool isSigned() const;

    /**
     * Attaches a range to this port declaration. If this port declaration does not support range,
     * that is the case of variable declaration of type VAR_INTEGER, VAR_REAL, VAR_REALTIME or VAR_TIME,
     * an exception is thrown.
     *
     * @param range the range to be attached to this port declaration
     * @see ECDOmVarType
     */
    void setRange(RefCDOmRange range);

    /**
     * Returns the range attached to this port declaration. If this port declaration does not support range,
     * that is the case of variable declaration of type VAR_INTEGER, VAR_REAL, VAR_REALTIME or VAR_TIME,
     * an exception is thrown. <br/>
     * On valid cases where no range is attached this method returns null, that is calling get() on returned
     * object returns 0.
     *
     * @return the range attached to this port declaration or null if no range is attached
     * @see ECDOmVarType
     */
    RefCDOmRange getRange() const;

    /**
     * Adds a port to this port declaration.
     *
     * @param name the name of port to be added to this port declaration
     */
    void addPort(TLineNumberType lineNumber, const RefString& name);

    TBool containsPort(const RefString& name) const;

    /**
     * Returns a vector containing all port identifiers that are attached to this port declaration.
     *
     * @return a vector containing all port identifiers that are attached to this port declaration
     */
    const RefTVec_RefCDOmIdentifier getIDs() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmTaskDecl class
// ********************************************************************************
/**
 * This class models a task declaration according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * task_declaration ::=
 *   task [ automatic ] task_identifier ;
 *     { task_item_declaration }
 *     statement_or_null
 *     endtask
 *   | task [ automatic ] task_identifier ( [ task_port_list ] ) ;
 *     { block_item_declaration }
 *     statement_or_null
 *     endtask
 *
 * task_identifier ::= identifier
 * task_item_declaration ::=
 *   block_item_declaration
 *   | { attribute_instance } tf_input_declaration ;
 *   | { attribute_instance } tf_output_declaration ;
 *   | { attribute_instance } tf_inout_declaration ;
 *
 * task_port_list ::= task_port_item { , task_port_item }
 * task_port_item ::=
 *   { attribute_instance } tf_input_declaration
 *   | { attribute_instance } tf_output_declaration
 *   | { attribute_instance } tf_inout_declaration
 * </code></pre>
 */
class CDOmTaskDecl : public CDOmAttrHolder {
  public:
    /**
     * Holds enum constants for task declaration types.
     */
    enum ETaskDeclType {TASK_DECL_WITHOUT_TASK_PORT_LIST, TASK_DECL_WITH_TASK_PORT_LIST};

  private:
    RefCDOmTaskDecl getThis() const { return boost::static_pointer_cast<CDOmTaskDecl>(m_weakRef.lock()); }

    ETaskDeclType m_taskDeclType;
    TBool m_isAutomatic;
    RefCDOmStmt m_stmt;

    RefCDOmScope m_scope; // attached scope

    CDOmTaskDecl(TLineNumberType lineNumber, ETaskDeclType taskDeclType, TBool isAutomatic);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmBase;
    void beforeAddingTaskItem(TBool isTFPortDecl);

  public:
    static RefCDOmTaskDecl cast (RefCDOmBase object);
    static RefCDOmTaskDecl build(TLineNumberType lineNumber, RefCDOmBase parent, ETaskDeclType taskDeclType, const RefString& name, TBool isAutomatic = false);

    RefCDOmScope getAttachedScope() const;

    ETaskDeclType getTaskDeclType() const;

    TBool isAutomatic() const;

    void setStmt(RefCDOmStmt stmt);

    RefCDOmStmt getStmt() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmFuncDecl class
// ********************************************************************************
/**
 * This class models a function declaration according to the grammar rules. <br/> <br/>
 *
 * <b>PDF SPEC 10.3.4: Function rules</b> <br/>
 * Functions are more limited than tasks. The following rules govern their usage: <br/>
 * a) A function definition shall not contain any time-controlled statements - that is, any statements
 * containing #, @, or wait. <br/>
 * b) Functions shall not enable tasks. <br/>
 * c) A function definition shall contain at least one input argument. <br/>
 * d) A function definition shall not have any argument declared as output or inout. <br/>
 * e) A function shall not have any nonblocking assignments or procedural continuous assignments. <br/>
 * f) A function shall not have any event triggers. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * function_declaration ::=
 *   function [ automatic ] [ signed ] [ range_or_type ] function_identifier ;
 *     function_item_declaration { function_item_declaration }
 *     function_statement
 *     endfunction
 *   | function [ automatic ] [ signed ] [ range_or_type ] function_identifier ( function_port_list ) ;
 *     { block_item_declaration }
 *     function_statement
 *     endfunction
 *
 * function_item_declaration ::=
 *   block_item_declaration
 *   | { attribute_instance } tf_input_declaration ;
 * function_port_list ::=
 *   { attribute_instance } tf_input_declaration { , { attribute_instance } tf_input_declaration }
 * range_or_type ::= range | integer | real | realtime | time
 * function_statement1 ::= statement
 * </code></pre>
 */
class CDOmFuncDecl : public CDOmAttrHolder {
  public:
    /**
     * Holds enum constants for function declaration types.
     */
    enum EFuncDeclType {
      FUNC_DECL_WITHOUT_FUNC_PORT_LIST,
      FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE,
      FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE,
      FUNC_DECL_WITH_FUNC_PORT_LIST,
      FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE,
      FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE,
    };

  private:
    RefCDOmFuncDecl getThis() const { return boost::static_pointer_cast<CDOmFuncDecl>(m_weakRef.lock()); }

    EFuncDeclType m_funcDeclType;
    TBool m_isAutomatic;
    TBool m_isSigned;
    RefCDOmRange m_range; // used by FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE, FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE
    ECDOmVarType m_varType; // used by FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE, FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE
    RefCDOmStmt m_stmt;

    RefCDOmScope m_scope; // attached scope

    CDOmFuncDecl(TLineNumberType lineNumber, EFuncDeclType funcDeclType, TBool isAutomatic, TBool isSigned);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmBase;
    void beforeAddingFuncItem(TBool isTFPortDecl);

  public:
    static RefCDOmFuncDecl cast (RefCDOmBase object);
    static RefCDOmFuncDecl build(TLineNumberType lineNumber, RefCDOmBase parent, EFuncDeclType funcDeclType, const RefString& name, TBool isAutomatic = false, TBool isSigned = false);

    RefCDOmScope getAttachedScope() const;

    EFuncDeclType getFuncDeclType() const;

    TBool isAutomatic() const;

    TBool isSigned() const;

    /**
     * Attaches a range to this function declaration. If this function declaration does not support range,
     * that is the case of function declaration type is one of FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE or
     * FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE, an exception is thrown.
     *
     * @param range the range to be attached to this function declaration
     * @see EFuncDeclType
     * @see getFuncDeclType()
     */
    void setRange(RefCDOmRange range);

    RefCDOmRange getRange() const;

    /**
     * Attaches a type to this function declaration. If this function declaration does not support type,
     * that is the case of function declaration type is one of FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE or
     * FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE, an exception is thrown. <br/>
     * NOTE: valid input for varType is one of VAR_INTEGER, VAR_REAL, VAR_REALTIME or VAR_TIME.
     *
     * @param varType the type to be attached to this function declaration
     * @see EFuncDeclType
     * @see ECDOmVarType
     * @see getFuncDeclType()
     */
    void setVarType(ECDOmVarType varType);

    ECDOmVarType getVarType() const;

    void setFuncStmt(RefCDOmStmt stmt);

    RefCDOmStmt getFuncStmt() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmVarDecl class
// ********************************************************************************
/**
 * This class models variable declarations according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * reg_declaration ::= reg [ signed ] [ range ] list_of_variable_identifiers ;
 * integer_declaration ::= integer list_of_variable_identifiers ;
 * real_declaration ::= real list_of_real_identifiers ;
 * realtime_declaration ::= realtime list_of_real_identifiers ;
 * time_declaration ::= time list_of_variable_identifiers ;
 *
 * list_of_variable_identifiers ::= variable_type { , variable_type }
 * variable_type ::=
 *   variable_identifier { dimension }
 *   | variable_identifier = constant_expression
 * variable_identifier ::= identifier
 * dimension ::= [ dimension_constant_expression : dimension_constant_expression ]
 * dimension_constant_expression ::= constant_expression
 *
 * list_of_real_identifiers ::= real_type { , real_type }
 * real_type ::=
 *   real_identifier { dimension }
 *   | real_identifier = constant_expression
 * real_identifier ::= identifier
 * </code></pre> </br> </br>
 *
 * <b>ADDITIONAL GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * reg [ signed ] [ range ] list_of_block_variable_identifiers ;
 * integer list_of_block_variable_identifiers ;
 * real list_of_block_real_identifiers ;
 * realtime list_of_block_real_identifiers ;
 * time list_of_block_variable_identifiers ;
 *
 * list_of_block_variable_identifiers ::= block_variable_type { , block_variable_type }
 * block_variable_type ::= variable_identifier { dimension }
 *
 * list_of_block_real_identifiers ::= block_real_type { , block_real_type }
 * block_real_type ::= real_identifier { dimension }
 * </code></pre>
 */
class CDOmVarDecl : public CDOmAttrHolder {
  private:
    RefCDOmVarDecl getThis() const { return boost::static_pointer_cast<CDOmVarDecl>(m_weakRef.lock()); }

    ECDOmVarType m_varType;
    TBool m_isSigned;     // used by VAR_REG
    RefCDOmRange m_range; // used by VAR_REG

    RefTMap_RefString_RefCDOmIdentifier m_nameMap;

    CDOmVarDecl(TLineNumberType lineNumber, ECDOmVarType varType);

  public:
    static RefCDOmVarDecl cast (RefCDOmBase object);
    static RefCDOmVarDecl build(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmVarType varType);

    ECDOmVarType getVarType() const;

    void setSigned();

    TBool isSigned() const;

    void setRange(RefCDOmRange range);

    RefCDOmRange getRange() const;

    void addVar(TLineNumberType lineNumber, const RefString& name, RefCDOmRangeList rangeList = RefCDOmRangeList());

    void addVar(TLineNumberType lineNumber, const RefString& name, RefCDOmExpr expr);

    TBool containsVar(const RefString& name) const;

    RefCDOmRangeList getVarRangeList(const RefString& name) const;

    RefCDOmExpr getVarVal(const RefString& name) const;

    const RefTVec_RefCDOmIdentifier getIDs() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmMinTypMax class
// ********************************************************************************
/**
 * This class models a minTypMax according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * constant_mintypmax_expression ::=
 *   constant_expression
 *   | constant_expression : constant_expression : constant_expression
 * mintypmax_expression ::=
 *   expression
 *   | expression : expression : expression
 * </code></pre>
 */
class CDOmMinTypMax : public CDOmExpr {
  public:
    /**
     * Holds enum constants for minTypMax types.
     */
    enum EMinTypMaxType {MINTYPMAX_SINGLE, MINTYPMAX_TRIAD};

  private:
    RefCDOmMinTypMax getThis() const { return boost::static_pointer_cast<CDOmMinTypMax>(m_weakRef.lock()); }

    EMinTypMaxType m_minTypMaxType;
    TBool m_isConst; // caches isConst
    TBool m_canBeModulePath;

    CDOmMinTypMax(TLineNumberType lineNumber, EMinTypMaxType minTypMaxType, TBool isConst, TBool canBeModPath);

  public:
    static RefCDOmMinTypMax cast (RefCDOmBase object);
    static RefCDOmMinTypMax build(TLineNumberType lineNumber, RefCDOmExpr expr);

    static RefCDOmMinTypMax build(TLineNumberType lineNumber, RefCDOmExpr expr1, RefCDOmExpr expr2, RefCDOmExpr expr3);

    EMinTypMaxType getMinTypMaxType() const;

    TBool isConst() const;

    TBool canBeModulePath() const;

    RefCDOmBase doEval() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmDelay class
// ********************************************************************************
/**
 * This class models a delay according to the grammar rules.
 * It is used for both delay2 and delay3. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * delay3 ::=
 *   # delay_value
 *   | # ( mintypmax_expression [ , mintypmax_expression [ , mintypmax_expression ] ] )
 * delay2 ::=
 *   # delay_value
 *   | # ( mintypmax_expression [ , mintypmax_expression ] )
 * delay_value ::=
 *   unsigned_number
 *   | real_number
 *   | identifier
 * mintypmax_expression ::=
 *   expression
 *   | expression : expression : expression
 * </code></pre>
 */
class CDOmDelay : public CDOmBase {
  public:
    /**
     * Holds enum constants for delay types.
     */
    enum EDelayType {DELAY_2, DELAY_3};

    // DECL_1 is for unsigned_number
    // DECL_2 is for real_number
    // DECL_3 is for identifier
    // DECL_4 is for minTypMax
    enum EDelayDeclType {UNDEFINED, DECL_1, DECL_2, DECL_3, DECL_4};

  private:
    RefCDOmDelay getThis() const { return boost::static_pointer_cast<CDOmDelay>(m_weakRef.lock()); }

    EDelayType m_delayType;
    EDelayDeclType m_delayDeclType;

    CDOmDelay(TLineNumberType lineNumber, EDelayType delayType);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmNetDecl;
    friend class CDOmContAssn;
    friend class CDOmModuleOrUdpInstantiation;
    friend class CDOmGateInstantiation;
    static RefCDOmDelay build(TLineNumberType lineNumber, RefCDOmBase parent, EDelayType delayType);

  public:
    static RefCDOmDelay cast (RefCDOmBase object);
    EDelayType getDelayType() const;

    EDelayDeclType getDelayDeclType() const;

    void setNumDelayValue(RefCDOmNumber num);

    RefCDOmNumber getNumDelayValue() const;

    void setRealNumDelayValue(RefCDOmReal realNum);

    RefCDOmReal getRealNumDelayValue() const;

    void setExprLink(RefCDOmExprLink exprLink);

    RefCDOmExprLink getExprLink() const;

    void addMinTypMax(RefCDOmMinTypMax minTypMax);

    RefCDOmMinTypMax getMinTypMax(TUInt index) const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmNetDecl class
// ********************************************************************************
/**
 * This class models net declarations according to the grammar rules. <br/> <br/>
 *
 * <b>PDF SPEC 3.3.2: Vector net accessibility</b> <br/>
 * Vectored and scalared shall be optional advisory keywords to be used in vector net or reg declaration. If
 * these keywords are implemented, certain operations on vectors may be restricted. If the keyword vectored is
 * used, bit-selects and part-selects and strength specifications may not be permitted, and the PLI may consider
 * the object unexpanded. If the keyword scalared is used, bit-selects and part-selects of the object shall be
 * permitted, and the PLI shall consider the object expanded. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * net_declaration ::=
 *   net_type [ signed ]
 *     [ delay3 ] list_of_net_identifiers ;
 *   | net_type [ drive_strength ] [ signed ]
 *     [ delay3 ] list_of_net_decl_assignments ;
 *   | net_type [ vectored | scalared ] [ signed ]
 *     range [ delay3 ] list_of_net_identifiers ;
 *   | net_type [ drive_strength ] [ vectored | scalared ] [ signed ]
 *     range [ delay3 ] list_of_net_decl_assignments ;
 *   | trireg [ charge_strength ] [ signed ]
 *     [ delay3 ] list_of_net_identifiers ;
 *   | trireg [ drive_strength ] [ signed ]
 *     [ delay3 ] list_of_net_decl_assignments ;
 *   | trireg [ charge_strength ] [ vectored | scalared ] [ signed ]
 *     range [ delay3 ] list_of_net_identifiers ;
 *   | trireg [ drive_strength ] [ vectored | scalared ] [ signed ]
 *     range [ delay3 ] list_of_net_decl_assignments ;
 * net_type ::=
 *   supply0 | supply1
 *   | tri | triand | trior | tri0 | tri1
 *   | wire | wand | wor
 * delay3 ::=
 *   # delay_value
 *   | # ( mintypmax_expression [ , mintypmax_expression [ , mintypmax_expression ] ] )
 * delay_value ::=
 *   unsigned_number
 *   | real_number
 *   | identifier
 * mintypmax_expression ::=
 *   expression
 *   | expression : expression : expression
 * list_of_net_identifiers ::= net_identifier { dimension }
 *   { , net_identifier { dimension } }
 * net_identifier ::= identifier
 * dimension ::= [ dimension_constant_expression : dimension_constant_expression ]
 * dimension_constant_expression ::= constant_expression
 *
 * drive_strength ::=
 *   ( strength0 , strength1 )
 *   | ( strength1 , strength0 )
 *   | ( strength0 , highz1 )
 *   | ( strength1 , highz0 )
 *   | ( highz0 , strength1 )
 *   | ( highz1 , strength0 )
 * strength0 ::= supply0 | strong0 | pull0 | weak0
 * strength1 ::= supply1 | strong1 | pull1 | weak1
 *
 * list_of_net_decl_assignments ::= net_decl_assignment { , net_decl_assignment }
 * net_decl_assignment ::= net_identifier = expression
 *
 * charge_strength ::= ( small ) | ( medium ) | ( large )
 * </code></pre> <br/> <br/>
 *
 * <b>ALTERNATE GRAMMAR RULES ARRANGEMENT: </b> <br/>
 * <pre><code>
 *   net_type [ signed ]                                                    [ delay3 ] list_of_net_identifiers ;
 *   net_type [ drive_strength ]                          [ signed ]        [ delay3 ] list_of_net_decl_assignments ;
 *   trireg   [ charge_strength ]                         [ signed ]        [ delay3 ] list_of_net_identifiers ;
 *   trireg   [ drive_strength ]                          [ signed ]        [ delay3 ] list_of_net_decl_assignments ;
 * 
 *   net_type [ vectored | scalared ]                     [ signed ] range  [ delay3 ] list_of_net_identifiers ;
 *   net_type [ drive_strength ]  [ vectored | scalared ] [ signed ] range  [ delay3 ] list_of_net_decl_assignments ;
 *   trireg   [ charge_strength ] [ vectored | scalared ] [ signed ] range  [ delay3 ] list_of_net_identifiers ;
 *   trireg   [ drive_strength ]  [ vectored | scalared ] [ signed ] range  [ delay3 ] list_of_net_decl_assignments ;
 * </code></pre>
 */
class CDOmNetDecl : public CDOmAttrHolder {
  public:
    /**
     * Holds enum constants for charge strength types.
     */
    enum EChargeStrength {CHARGE_STRENGTH_UNDEFINED, CHARGE_STRENGTH_SMALL, CHARGE_STRENGTH_MEDIUM, CHARGE_STRENGTH_LARGE};

    /**
     * Holds enum constants for vector access types.
     */
    enum EVectorAccessType {VECTOR_ACCESS_UNDEFINED, VECTOR_ACCESS_VECTORED, VECTOR_ACCESS_SCALARED};

  private:
    RefCDOmNetDecl getThis() const { return boost::static_pointer_cast<CDOmNetDecl>(m_weakRef.lock()); }

    enum ENetDeclType {NET_DECL_UNDEFINED, NET_DECL_ID_ONLY, NET_DECL_ID_EXPR_PAIR};
    ENetDeclType m_netDeclType;
    ECDOmNetType m_netType;

    TBool m_isSigned;
    RefCDOmDelay m_delay3;
    ECDOmDriveStrength m_firstDriveStrength;  // used by NET_DECL_ID_EXPR_PAIR
    ECDOmDriveStrength m_secondDriveStrength; // used by NET_DECL_ID_EXPR_PAIR
    EChargeStrength m_chargeStrength;         // used by NET_DECL_ID_ONLY
    RefCDOmRange m_range;
    EVectorAccessType m_vectorAccessType;

    RefTMap_RefString_RefCDOmIdentifier m_nameMap;

    CDOmNetDecl(TLineNumberType lineNumber, ECDOmNetType netType);

  public:
    static RefCDOmNetDecl cast (RefCDOmBase object);
    static RefCDOmNetDecl build(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmNetType netType);

    ECDOmNetType getNetType() const;

    ENetDeclType getNetDeclType() const { return m_netDeclType; }

    void setSigned();

    TBool isSigned() const;

    TBool hasDelay3() const;

    void buildDelay3(TLineNumberType lineNumber);

    RefCDOmDelay getDelay3();
  
    const RefCDOmDelay getDelay3() const;

    void setDriveStrength(ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength);

    ECDOmDriveStrength getFirstDriveStrength() const;

    ECDOmDriveStrength getSecondDriveStrength() const;

    void setChargeStrength(EChargeStrength chargeStrength);

    EChargeStrength getChargeStrength() const;

    void setRange(RefCDOmRange range, EVectorAccessType vectorAccessType = VECTOR_ACCESS_UNDEFINED);

    RefCDOmRange getRange() const;

    EVectorAccessType getVectorAccessType() const;

    void addNet(TLineNumberType lineNumber, const RefString& name, RefCDOmRangeList rangeList = RefCDOmRangeList());

    void addNet(TLineNumberType lineNumber, const RefString& name, RefCDOmExpr expr);

    TBool containsNet(const RefString& name) const;

    RefCDOmRangeList getNetRangeList(const RefString& name) const;

    RefCDOmExpr getNetVal(const RefString& name) const;

    const RefTVec_RefCDOmIdentifier getIDs() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmEventDecl class
// ********************************************************************************
/**
 * This class models event declarations according to the grammar rules.
 * An object of this type is always guaranteed to hold at least one pair of type (event_identifier, { dimension }). <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * event_declaration ::= event list_of_event_identifiers ;
 * list_of_event_identifiers ::= event_identifier { dimension }
 *   { , event_identifier { dimension } }
 * event_identifier ::= identifier
 * </code></pre>
 */
class CDOmEventDecl : public CDOmAttrHolder {
  private:
    RefCDOmEventDecl getThis() const { return boost::static_pointer_cast<CDOmEventDecl>(m_weakRef.lock()); }

    RefTMap_RefString_RefCDOmIdentifier m_nameMap;

    CDOmEventDecl(TLineNumberType lineNumber);

  public:
    static RefCDOmEventDecl cast (RefCDOmBase object);
    static RefCDOmEventDecl build(TLineNumberType lineNumber, RefCDOmBase parent, const RefString& name, RefCDOmRangeList rangeList = RefCDOmRangeList());

    void addEvent(TLineNumberType lineNumber, const RefString& name, RefCDOmRangeList rangeList = RefCDOmRangeList());

    TBool containsEvent(const RefString& name) const;

    RefCDOmRangeList getEventRangeList(const RefString& name) const;

    const RefTVec_RefCDOmIdentifier getIDs() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmGenvarDecl class
// ********************************************************************************
/**
 * This class models genvar declarations according to the grammar rules.
 * An object of this type is always guaranteed to hold at least one genvar identifier. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * genvar_declaration ::= genvar list_of_genvar_identifiers ;
 * list_of_genvar_identifiers ::= genvar_identifier { , genvar_identifier }
 * genvar_identifier ::= identifier
 * </code></pre>
 */
class CDOmGenvarDecl : public CDOmAttrHolder {
  private:
    RefCDOmGenvarDecl getThis() const { return boost::static_pointer_cast<CDOmGenvarDecl>(m_weakRef.lock()); }

    RefTMap_RefString_RefCDOmIdentifier m_nameMap;

    CDOmGenvarDecl(TLineNumberType lineNumber);

  public:
    static RefCDOmGenvarDecl cast (RefCDOmBase object);
    static RefCDOmGenvarDecl build(TLineNumberType lineNumber, RefCDOmBase parent, const RefString& name);

    void addGenvar(TLineNumberType lineNumber, const RefString& name);

    TBool containsGenvar(const RefString& name) const;

    const RefTVec_RefCDOmIdentifier getIDs() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmParamOverride class
// ********************************************************************************
/**
 * This class models a parameter override according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * parameter_override ::= defparam list_of_defparam_assignments ;
 * list_of_defparam_assignments ::= defparam_assignment { , defparam_assignment }
 * defparam_assignment ::= hierarchical_parameter_identifier = constant_mintypmax_expression
 * hierarchical_parameter_identifier ::= hierarchical_identifier
 * </code></pre>
 */
class CDOmParamOverride : public CDOmAttrHolder {
  private:
    RefCDOmParamOverride getThis() const { return boost::static_pointer_cast<CDOmParamOverride>(m_weakRef.lock()); }

    CDOmParamOverride(TLineNumberType lineNumber);

  public:
    static RefCDOmParamOverride cast (RefCDOmBase object);
    static RefCDOmParamOverride build(TLineNumberType lineNumber, RefCDOmBase parent, RefCDOmExprLink hid, RefCDOmMinTypMax minTypMax);

    void addParamAssn(RefCDOmExprLink hid, RefCDOmMinTypMax minTypMax);

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmContAssn class
// ********************************************************************************
/**
 * This class models a continuous assignment according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * continuous_assign ::= assign [ drive_strength ] [ delay3 ] list_of_net_assignments ;
 * list_of_net_assignments ::= net_assignment { , net_assignment }
 * </code></pre>
 */
class CDOmContAssn : public CDOmAttrHolder {
  private:
    RefCDOmContAssn getThis() const { return boost::static_pointer_cast<CDOmContAssn>(m_weakRef.lock()); }

    ECDOmDriveStrength m_firstDriveStrength;
    ECDOmDriveStrength m_secondDriveStrength;
    RefCDOmDelay m_delay3;

    CDOmContAssn(TLineNumberType lineNumber, ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength);

  public:
    static RefCDOmContAssn cast (RefCDOmBase object);
    static RefCDOmContAssn build(TLineNumberType lineNumber, RefCDOmBase parent,
                                 ECDOmDriveStrength firstDriveStrength = DRIVE_STRENGTH_UNDEFINED, ECDOmDriveStrength secondDriveStrength = DRIVE_STRENGTH_UNDEFINED);

    ECDOmDriveStrength getFirstDriveStrength() const;

    ECDOmDriveStrength getSecondDriveStrength() const;

    TBool hasDelay3() const;

    void buildDelay3(TLineNumberType lineNumber);

    RefCDOmDelay getDelay3();
  
    const RefCDOmDelay getDelay3() const;

    void addNetAssn(RefCDOmAssn assn);

    const RefTVec_RefCDOmAssn getNetAssns() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmModuleOrUdpInstance class
// ********************************************************************************
/**
 * This class models a module instance according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * module_instance ::= name_of_module_instance ( [ list_of_port_connections ] )
 * name_of_module_instance ::= module_instance_identifier [ range ]
 * module_instance_identifier ::= identifier
 * list_of_port_connections ::=
 *   ordered_port_connection { , ordered_port_connection }
 *   | named_port_connection { , named_port_connection }
 * ordered_port_connection ::= { attribute_instance } [ expression ]
 * named_port_connection ::= { attribute_instance } . port_identifier ( [ expression ] )
 * port_identifier ::= identifier
 * </code></pre>
 */
class CDOmModuleOrUdpInstance : public CDOmBase {
  public:
    /**
     * Holds enum constants for module instance types.
     */
    enum EModuleInstanceType {MODULE_INSTANCE_UNDEFINED, MODULE_INSTANCE_ORDERED_PORT_CONNECTION, MODULE_INSTANCE_NAMED_PORT_CONNECTION};

  private:
    RefCDOmModuleOrUdpInstance getThis() const { return boost::static_pointer_cast<CDOmModuleOrUdpInstance>(m_weakRef.lock()); } 

    EModuleInstanceType m_moduleInstanceType;
    RefTMap_RefString_RefCDOmExpr m_explicitPortNameMap; // used by MODULE_INSTANCE_NAMED_PORT_CONNECTION
    TUInt m_portConnectionCount; // used by MODULE_INSTANCE_ORDERED_PORT_CONNECTION
    RefTVec_TUInt m_emptyIndexes; // used by MODULE_INSTANCE_ORDERED_PORT_CONNECTION

    CDOmModuleOrUdpInstance(TLineNumberType lineNumber);

    // since this method is private, some friend class declarations are needed:
    friend class CDOmModuleOrUdpInstantiation;
    static RefCDOmModuleOrUdpInstance build(TLineNumberType lineNumber, RefCDOmModuleOrUdpInstantiation parent, const RefString& instName, RefCDOmRange range);

  public:
    static RefCDOmModuleOrUdpInstance cast (RefCDOmBase object);
    ~CDOmModuleOrUdpInstance();

    EModuleInstanceType getModuleInstanceType() const;

    RefCDOmRange getRange() const;

    void addPortConnection(RefCDOmAttrListCollection attrListCollection = RefCDOmAttrListCollection(), RefCDOmExpr expr = RefCDOmExpr(), const RefString& explicitPortName = RefString());

    TBool containsExplicitPortName(const RefString& name) const;

    RefCDOmExpr getPortExpr(const RefString& explicitPortName);

    RefTMap_RefString_RefCDOmExpr getExplicitPortMap() const { return m_explicitPortNameMap; }

    RefTVec_TUInt getEmptyIndexes() const;
  
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmModuleOrUdpInstantiation class
// ********************************************************************************
/**
 * This class models a module instantiation according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * module_instantiation ::=
 *   module_identifier [ parameter_value_assignment ]
 *   module_instance { , module_instance } ;
 *
 * module_identifier ::= identifier
 * parameter_value_assignment ::= # ( list_of_parameter_assignments )
 * list_of_parameter_assignments ::=
 *   ordered_parameter_assignment { , ordered_parameter_assignment } |
 *   named_parameter_assignment { , named_parameter_assignment }
 * ordered_parameter_assignment ::= expression
 * named_parameter_assignment ::= . parameter_identifier ( [ mintypmax_expression ] )
 * parameter_identifier ::= identifier
 * </code></pre>
 */
class CDOmModuleOrUdpInstantiation : public CDOmAttrHolder {
  public:
    /**
     * Holds enum constants for module instance types.
     */
    enum EModuleInstantiationType {
      MODULE_OR_UDP_INSTANTIATION,
      MODULE_INSTANTIATION_UNDEFINED, 
      MODULE_INSTANTIATION_ORDERED_PARAM_ASSN, 
      MODULE_INSTANTIATION_NAMED_PARAM_ASSN,
      UDP_INSTANTIATION
    };

  private:
    RefCDOmModuleOrUdpInstantiation getThis() const { return boost::static_pointer_cast<CDOmModuleOrUdpInstantiation>(m_weakRef.lock()); }

    friend class CDOmModuleOrUdpInstance;
    EModuleInstantiationType m_moduleInstantiationType;
    RefTMap_RefString_RefCDOmMinTypMax m_explicitParamNameMap; // used by MODULE_INSTANTIATION_NAMED_PARAM_ASSN
    //For UDP instantiation
    ECDOmDriveStrength m_firstDriveStrength;  // used by UDP instantiation
    ECDOmDriveStrength m_secondDriveStrength; // used by UDP instantiation
    RefCDOmDelay m_delay2;

    CDOmModuleOrUdpInstantiation(TLineNumberType lineNumber);

  public:
    static RefCDOmModuleOrUdpInstantiation cast (RefCDOmBase object);
    static RefCDOmModuleOrUdpInstantiation build(TLineNumberType lineNumber, RefCDOmBase parent, RefCDOmExprLink moduleExprLink);

    const RefCDOmExprLink getModuleExprLink() const;

    EModuleInstantiationType getModuleInstantiationType() const;

    void addOrderedParamAssn(RefCDOmExpr expr);

    void addNamedParamAssn(const RefString& paramName, RefCDOmMinTypMax minTypMax = RefCDOmMinTypMax());

    RefTMap_RefString_RefCDOmMinTypMax getExplicitParamNameMap();

    RefCDOmModuleOrUdpInstance buildModuleInstance(TLineNumberType lineNumber, const RefString& instName = RefString(), RefCDOmRange range = RefCDOmRange());

    TBool containsExplicitParamName(const RefString& name) const;

    RefCDOmMinTypMax getParamExpr(const RefString& explicitParamName);

    RefTVec_RefCDOmModuleOrUdpInstance getModuleInstances() const;

    void setDriveStrength(ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength);

    ECDOmDriveStrength getFirstDriveStrength() const;

    ECDOmDriveStrength getSecondDriveStrength() const;

    void buildDelay2(TLineNumberType lineNumber);

    RefCDOmDelay getDelay2();
  
    const RefCDOmDelay getDelay2() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmInitOrAlways class
// ********************************************************************************
/**
 * This class models an initial or always construct according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * initial_construct ::= initial statement
 * always_construct ::= always statement
 * </code></pre>
 */
class CDOmInitOrAlways : public CDOmAttrHolder {
  public:
    /**
     * Holds enum constants for initOrAlways types.
     */
    enum EInitOrAlwaysType {INIT_OR_ALWAYS_INIT, INIT_OR_ALWAYS_ALWAYS};

  private:
    RefCDOmInitOrAlways getThis() const { return boost::static_pointer_cast<CDOmInitOrAlways>(m_weakRef.lock()); }

    EInitOrAlwaysType m_initOrAlwaysType;

    CDOmInitOrAlways(TLineNumberType lineNumber, EInitOrAlwaysType initOrAlwaysType);

  public:
    static RefCDOmInitOrAlways cast (RefCDOmBase object);
    static RefCDOmInitOrAlways build(TLineNumberType lineNumber, RefCDOmBase parent, EInitOrAlwaysType initOrAlwaysType, RefCDOmStmt stmt);

    EInitOrAlwaysType getInitOrAlwaysType() const;

    RefCDOmStmt getStmt() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmSpecifyBlock class
// ********************************************************************************
/**
 * This class models a specify block according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * specify_block ::= specify { specify_item } endspecify
 *
 * specify_item ::=
 *   specparam_declaration
 *   | pulsestyle_declaration
 *   | showcancelled_declaration
 *   | path_declaration
 *   | system_timing_check
 * pulsestyle_declaration ::=
 *   pulsestyle_onevent list_of_path_outputs ;
 *   | pulsestyle_ondetect list_of_path_outputs ;
 * showcancelled_declaration ::=
 *   showcancelled list_of_path_outputs ;
 *   | noshowcancelled list_of_path_outputs ;
 * </code></pre>
 */
class CDOmSpecifyBlock : public CDOmBase {
  private:
    RefCDOmSpecifyBlock getThis() const { return boost::static_pointer_cast<CDOmSpecifyBlock>(m_weakRef.lock()); }

    CDOmSpecifyBlock(TLineNumberType lineNumber);

  public:
    static RefCDOmSpecifyBlock cast (RefCDOmBase object);
    static RefCDOmSpecifyBlock build(TLineNumberType lineNumber, RefCDOmModuleDecl parent);

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmPulseStyleOrShowCancelledDecl class
// ********************************************************************************
/**
 * This class models two specify items. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * pulsestyle_declaration ::=
 *   pulsestyle_onevent list_of_path_outputs ;
 *   | pulsestyle_ondetect list_of_path_outputs ;
 * showcancelled_declaration ::=
 *   showcancelled list_of_path_outputs ;
 *   | noshowcancelled list_of_path_outputs ;
 * </code></pre>
 */
class CDOmPulseStyleOrShowCancelledDecl : public CDOmBase {
  public:
    /**
     * Holds enum constants for pulsestyle_ondetect, pulsestyle_onevent, showcancelled and noshowcancelled types.
     */
    enum EDeclType { PULSESTYLE_ONEVENT, PULSESTYLE_ONDETECT, SHOWCANCELLED, NOSHOWCANCELLED };

  private:
    RefCDOmPulseStyleOrShowCancelledDecl getThis() const { return boost::static_pointer_cast<CDOmPulseStyleOrShowCancelledDecl>(m_weakRef.lock()); }
    
    CDOmPulseStyleOrShowCancelledDecl(TLineNumberType lineNumber, EDeclType declType);

    EDeclType m_declType;

  public:
    static RefCDOmPulseStyleOrShowCancelledDecl cast (RefCDOmBase object);
    static RefCDOmPulseStyleOrShowCancelledDecl build(TLineNumberType lineNumber, RefCDOmSpecifyBlock parent, EDeclType type, RefCDOmSpecifyTerminalList listOfPathOutputs);

    const EDeclType getDeclType() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};



// ********************************************************************************
// CDOmPathDelayValue class
// ********************************************************************************
/**
 * This class models a generated instantiation according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * path_delay_value ::=
 *   list_of_path_delay_expressions
 *   | ( list_of_path_delay_expressions )
 * </code></pre>
 */
class CDOmPathDelayValue : public CDOmBase {
  public:
    /**
     * Holds enum for the style of path_delay_value, with parenthesis, or without.
     */
    enum EPathStyle { PATH_DELAY_WITHOUT_PAREN, PATH_DELAY_WITH_PAREN };

  private:
    RefCDOmPathDelayValue getThis() const { return boost::static_pointer_cast<CDOmPathDelayValue>(m_weakRef.lock()); }

    CDOmPathDelayValue(TLineNumberType lineNumber, const EPathStyle);

    EPathStyle m_style;

  public:
    static RefCDOmPathDelayValue cast (RefCDOmBase object);
    static RefCDOmPathDelayValue build(TLineNumberType lineNumber, const EPathStyle, RefCDOmMinTypMaxList );

    EPathStyle getStyle() const;
    const RefCDOmMinTypMaxList getMinTypMaxList() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmSystemTimingCheck class
// ********************************************************************************
/**
 * This class handles system timing check commands according to the grammar rules.
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * system_timing_check ::=
 *   $setup_timing_check
 * | $hold_timing_check
 * | $setuphold_timing_check
 * | $recovery_timing_check
 * | $removal_timing_check
 * | $recrem_timing_check
 * | $skew_timing_check
 * | $timeskew_timing_check
 * | $fullskew_timing_check
 * | $period_timing_check
 * | $width_timing_check
 * | $nochange_timing_check
 * $setup_timing_check ::=
 *   $setup ( data_event , reference_event , timing_check_limit [ , [ notify_reg ] ] ) ;
 * $hold_timing_check ::=
 *   $hold ( reference_event , data_event , timing_check_limit [ , [ notify_reg ] ] ) ;
 * $setuphold_timing_check ::=
 *   $setuphold ( reference_event , data_event , timing_check_limit , timing_check_limit
 *   [ , [ notify_reg ] [ , [ stamptime_condition ] [ , [ checktime_condition ]
 *   [ , [ delayed_reference ] [ , [ delayed_data ] ] ] ] ] ] ) ;
 * $recovery_timing_check ::=
 *   $recovery ( reference_event , data_event , timing_check_limit [ , [ notify_reg ] ] ) ;
 * $removal_timing_check ::=
 *   $removal ( reference_event , data_event , timing_check_limit [ , [ notify_reg ] ] ) ;
 * $recrem_timing_check ::=
 *   $recrem ( reference_event , data_event , timing_check_limit , timing_check_limit
 *   [ , [ notify_reg ] [ , [ stamptime_condition ] [ , [ checktime_condition ]
 *   [ , [ delayed_reference ] [ , [ delayed_data ] ] ] ] ] ] ) ;
 * $skew_timing_check ::=
 *   $skew ( reference_event , data_event , timing_check_limit [ , [ notify_reg ] ] ) ;
 * $timeskew_timing_check ::=
 *   $timeskew ( reference_event , data_event , timing_check_limit
 *   [ , [ notify_reg ] [ , [ event_based_flag ] [ , [ remain_active_flag ] ] ] ] ) ;
 * $fullskew_timing_check ::=
 *   $fullskew ( reference_event , data_event , timing_check_limit , timing_check_limit
 *   [ , [ notify_reg ] [ , [ event_based_flag ] [ , [ remain_active_flag ] ] ] ] ) ;
 * $period_timing_check ::=
 *   $period ( controlled_reference_event , timing_check_limit [ , [ notify_reg ] ] ) ;
 * $width_timing_check ::=
 *   $width ( controlled_reference_event , timing_check_limit ,
 *   threshold [ , [ notify_reg ] ] ) ;
 * $nochange_timing_check ::=
 *   $nochange ( reference_event , data_event , start_edge_offset ,
 *   end_edge_offset [ , [ notify_reg ] ] ) ;
 * </code></pre>
 */
class CDOmSystemTimingCheck : public CDOmBase {
  public:
    enum ETimingCheckType {
      TIMING_CHECK_SETUP, 
      TIMING_CHECK_HOLD, 
      TIMING_CHECK_SETUPHOLD, 
      TIMING_CHECK_RECOVERY,
      TIMING_CHECK_REMOVAL,
      TIMING_CHECK_RECREM,
      TIMING_CHECK_SKEW,
      TIMING_CHECK_TIMESKEW,
      TIMING_CHECK_FULLSKEW,
      TIMING_CHECK_PERIOD,
      TIMING_CHECK_WIDTH,
      TIMING_CHECK_NOCHANGE
    };

  private:
    RefCDOmSystemTimingCheck getThis() const { return boost::static_pointer_cast<CDOmSystemTimingCheck>(m_weakRef.lock()); }

    ETimingCheckType m_timingCheckType;
    //tis vector stores info about which optional parameters were set and which were not
    TInt m_optional[8];
    CDOmSystemTimingCheck(TLineNumberType lineNumber, ETimingCheckType timingCheckType, TInt flag[8]);
    //this build function is generic
    //it will be used by all 12 public build functions, one for each member of the enumeration
    //the SystemTimingCheck parent  can only be  SpecifyBlock
    static RefCDOmSystemTimingCheck build(TLineNumberType lineNumber, 
                                          RefCDOmSpecifyBlock           parent, 
                                          ETimingCheckType              timingCheckType, 
                                          RefCDOmTimingCheckEvent       referenceEvent           = RefCDOmTimingCheckEvent(), // DEP 2010-06-06 to fix compiler bug with gcc 43.RefCDOmExprLink(), 
                                          RefCDOmTimingCheckEvent       dataEvent                = RefCDOmTimingCheckEvent(), // DEP 2010-06-06 to fix compiler bug with gcc 43.RefCDOmExprLink(), 
                                          RefCDOmExpr                   timingCheckLimit1        = RefCDOmExpr(), 
                                          RefCDOmTimingCheckEvent       controlledReferenceEvent = RefCDOmTimingCheckEvent(),
                                          RefCDOmMinTypMax              startEdgeOffset          = RefCDOmMinTypMax(), 
                                          RefCDOmMinTypMax              endEdgeOffset            = RefCDOmMinTypMax(),
                                          RefCDOmExpr                   threshold                = RefCDOmExpr(),
                                          RefCDOmExpr                   timingCheckLimit2        = RefCDOmExpr(), 
                                          RefCDOmExprLink               notifyReg                = RefCDOmExprLink(), 
                                          RefCDOmMinTypMax              stampTimeCondition       = RefCDOmMinTypMax(), 
                                          RefCDOmMinTypMax              checkTimeCondition       = RefCDOmMinTypMax(), 
                                          RefCDOmDelayedDataOrReference delayedReference         = RefCDOmDelayedDataOrReference(), 
                                          RefCDOmDelayedDataOrReference delayedData              = RefCDOmDelayedDataOrReference(), 
                                          RefCDOmExpr                   eventBasedFlag           = RefCDOmExpr(), 
                                          RefCDOmMinTypMax              remainActiveFlag         = RefCDOmMinTypMax()
                                          );

  public:
    static RefCDOmSystemTimingCheck cast (RefCDOmBase object);
    static RefCDOmSystemTimingCheck buildSetup(TLineNumberType lineNumber, 
                                               RefCDOmSpecifyBlock     parent, 
                                               RefCDOmTimingCheckEvent referenceEvent, 
                                               RefCDOmTimingCheckEvent dataEvent,
                                               RefCDOmExpr             timingCheckLimit, 
                                               RefCDOmExprLink         notifyReg        = RefCDOmExprLink()
                                               );
    static RefCDOmSystemTimingCheck buildHold(TLineNumberType lineNumber, 
                                              RefCDOmSpecifyBlock     parent, 
                                              RefCDOmTimingCheckEvent referenceEvent, 
                                              RefCDOmTimingCheckEvent dataEvent,
                                              RefCDOmExpr             timingCheckLimit, 
                                              RefCDOmExprLink         notifyReg        = RefCDOmExprLink()
                                              );
    static RefCDOmSystemTimingCheck buildSetuphold(TLineNumberType lineNumber, 
                                                   RefCDOmSpecifyBlock           parent, 
                                                   RefCDOmTimingCheckEvent       referenceEvent, 
                                                   RefCDOmTimingCheckEvent       dataEvent,
                                                   RefCDOmExpr                   timingCheckLimit1, 
                                                   RefCDOmExpr                   timingCheckLimit2, 
                                                   RefCDOmExprLink               notifyReg          = RefCDOmExprLink(),
                                                   RefCDOmMinTypMax              stampTimeCondition = RefCDOmMinTypMax(),
                                                   RefCDOmMinTypMax              checkTimeCondition = RefCDOmMinTypMax(),
                                                   RefCDOmDelayedDataOrReference delayedReference   = RefCDOmDelayedDataOrReference(),
                                                   RefCDOmDelayedDataOrReference delayedData        = RefCDOmDelayedDataOrReference()
                                                   );
    static RefCDOmSystemTimingCheck buildRecovery(TLineNumberType lineNumber, 
                                                  RefCDOmSpecifyBlock     parent,
                                                  RefCDOmTimingCheckEvent referenceEvent, 
                                                  RefCDOmTimingCheckEvent dataEvent,
                                                  RefCDOmExpr             timingCheckLimit, 
                                                  RefCDOmExprLink         notifyReg        = RefCDOmExprLink()
                                                  );
    static RefCDOmSystemTimingCheck buildRemoval(TLineNumberType lineNumber, 
                                                 RefCDOmSpecifyBlock     parent, 
                                                 RefCDOmTimingCheckEvent referenceEvent, 
                                                 RefCDOmTimingCheckEvent dataEvent,
                                                 RefCDOmExpr             timingCheckLimit, 
                                                 RefCDOmExprLink         notifyReg        = RefCDOmExprLink()
                                                 );
    static RefCDOmSystemTimingCheck buildRecrem(TLineNumberType lineNumber, 
                                                RefCDOmSpecifyBlock           parent, 
                                                RefCDOmTimingCheckEvent       referenceEvent,
                                                RefCDOmTimingCheckEvent       dataEvent,
                                                RefCDOmExpr                   timingCheckLimit1, 
                                                RefCDOmExpr                   timingCheckLimit2, 
                                                RefCDOmExprLink               notifyReg          = RefCDOmExprLink(),
                                                RefCDOmMinTypMax              stampTimeCondition = RefCDOmMinTypMax(),
                                                RefCDOmMinTypMax              checkTimeCondition = RefCDOmMinTypMax(),
                                                RefCDOmDelayedDataOrReference delayedReference   = RefCDOmDelayedDataOrReference(),
                                                RefCDOmDelayedDataOrReference delayedData        = RefCDOmDelayedDataOrReference()
                                                );
    static RefCDOmSystemTimingCheck buildSkew(TLineNumberType lineNumber, 
                                              RefCDOmSpecifyBlock     parent, 
                                              RefCDOmTimingCheckEvent referenceEvent, 
                                              RefCDOmTimingCheckEvent dataEvent,
                                              RefCDOmExpr             timingCheckLimit, 
                                              RefCDOmExprLink         notifyReg        = RefCDOmExprLink()
                                              );
    static RefCDOmSystemTimingCheck buildTimeskew(TLineNumberType lineNumber, 
                                                  RefCDOmSpecifyBlock     parent, 
                                                  RefCDOmTimingCheckEvent referenceEvent, 
                                                  RefCDOmTimingCheckEvent dataEvent,
                                                  RefCDOmExpr             timingCheckLimit, 
                                                  RefCDOmExprLink         notifyReg        = RefCDOmExprLink(),
                                                  RefCDOmExpr             eventBasedFlag   = RefCDOmExpr(), 
                                                  RefCDOmMinTypMax        remainActiveFlag = RefCDOmMinTypMax() // DEP 2010-06-06 to fix compiler bug with gcc 43.RefCDOmExpr()
                                                  );
    static RefCDOmSystemTimingCheck buildFullskew(TLineNumberType lineNumber, 
                                                  RefCDOmSpecifyBlock     parent,
                                                  RefCDOmTimingCheckEvent referenceEvent, 
                                                  RefCDOmTimingCheckEvent dataEvent,
                                                  RefCDOmExpr             timingCheckLimit1, 
                                                  RefCDOmExpr             timingCheckLimit2,
                                                  RefCDOmExprLink         notifyReg         = RefCDOmExprLink(),
                                                  RefCDOmExpr             eventBasedFlag    = RefCDOmExpr(), 
                                                  RefCDOmMinTypMax        remainActiveFlag  = RefCDOmMinTypMax()
                                                  );
    static RefCDOmSystemTimingCheck buildPeriod(TLineNumberType lineNumber, 
                                                RefCDOmSpecifyBlock     parent, 
                                                RefCDOmTimingCheckEvent controlledReferenceEvent,
                                                RefCDOmExpr             timingCheckLimit, 
                                                RefCDOmExprLink         notifyReg                = RefCDOmExprLink()
                                                );
    static RefCDOmSystemTimingCheck buildWidth(TLineNumberType lineNumber, 
                                               RefCDOmSpecifyBlock     parent, 
                                               RefCDOmTimingCheckEvent controlledReferenceEvent,
                                               RefCDOmExpr             timingCheckLimit, 
                                               RefCDOmExpr             threshold                = RefCDOmExpr(), 
                                               RefCDOmExprLink         notifyReg                = RefCDOmExprLink()
                                               );
    static RefCDOmSystemTimingCheck buildNochange(TLineNumberType lineNumber, 
                                                  RefCDOmSpecifyBlock     parent, 
                                                  RefCDOmTimingCheckEvent referenceEvent, 
                                                  RefCDOmTimingCheckEvent dataEvent,
                                                  RefCDOmMinTypMax        startEdgeOffset, 
                                                  RefCDOmMinTypMax        endEdgeOffset, 
                                                  RefCDOmExprLink         notifyReg       = RefCDOmExprLink()
                                                  );

    ETimingCheckType getTimingCheckType() const;  
    const RefCDOmTimingCheckEvent       getDataEvent()               const;
    const RefCDOmTimingCheckEvent       getReferenceEvent()          const;
    const RefCDOmExpr                   getTimingCheckLimit1()       const;
    const RefCDOmExpr                   getTimingCheckLimit2()       const;
    const RefCDOmExprLink               getNotifyReg()               const;
    const RefCDOmMinTypMax              getStampTimeCondition()      const;
    const RefCDOmMinTypMax              getCheckTimeCondition()      const;
    const RefCDOmDelayedDataOrReference getDelayedReference()        const;
    const RefCDOmDelayedDataOrReference getDelayedData()             const;
    const RefCDOmExpr                   getEventBasedFlag()          const;
    const RefCDOmMinTypMax              getRemainActiveFlag()        const;
    const RefCDOmTimingCheckEvent       getControlledReferenceEvent()const;
    const RefCDOmExpr                   getThreshold()               const;
    const RefCDOmMinTypMax              getStartEdgeOffset()         const;
    const RefCDOmMinTypMax              getEndEdgeOffset()           const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmDelayedDataOrReference class
// ********************************************************************************
/** 
 * This class handles the data and reference delays according to the grammar rules:
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * delayed_data ::=terminal_identifier | terminal_identifier [constant_mintypmax_expression]
 * delayed_reference ::=terminal_identifier | terminal_identifier [constant_mintypmax_expression]
 * </code></pre>
 */
class CDOmDelayedDataOrReference : public CDOmBase {
  private:
    RefCDOmDelayedDataOrReference getThis() const { return boost::static_pointer_cast<CDOmDelayedDataOrReference>(m_weakRef.lock()); }
  
    CDOmDelayedDataOrReference(TLineNumberType lineNumber);

  public:
    static RefCDOmDelayedDataOrReference cast (RefCDOmBase object);
    static RefCDOmDelayedDataOrReference build(TLineNumberType lineNumber, RefCDOmExprLink terminalIdentifier, RefCDOmMinTypMax minTypMax = RefCDOmMinTypMax());
    const RefCDOmExprLink getTerminalIdentifier() const;
    const RefCDOmMinTypMax getMinTypMax() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmTimingCheckEventControl class
// ********************************************************************************
/** 
 * This class covers the following grammar rules:
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * timing_check_event_control ::= posedge | negedge | edge_control_specifier
 * edge_control_specifier ::= edge [edge_descriptor {,edge_descriptor}]
 * edge_descriptor ::= 01 | 10 | z_or_x zero_or_one | zero_or_one z_or_x 
 * zero_or_one ::= 0 | 1
 * z_or_x ::= x | X | z | Z
 * </code></pre>
 */
class CDOmTimingCheckEventControl : public CDOmBase {
  public:
    enum ETimingCheckType { TIMING_CHECK_EV_POSEDGE, TIMING_CHECK_EV_NEGEDGE, TIMING_CHECK_EV_EDGE };
    enum EEdgeDescriptor { 
      TIMING_CHECK_EV_KEY_01, 
      TIMING_CHECK_EV_KEY_10, 
      TIMING_CHECK_EV_KEY_x0, 
      TIMING_CHECK_EV_KEY_z0, 
      TIMING_CHECK_EV_KEY_x1, 
      TIMING_CHECK_EV_KEY_z1, 
      TIMING_CHECK_EV_KEY_0x, 
      TIMING_CHECK_EV_KEY_0z, 
      TIMING_CHECK_EV_KEY_1x, 
      TIMING_CHECK_EV_KEY_1z, 
      TIMING_CHECK_EV_KEY_X0, 
      TIMING_CHECK_EV_KEY_Z0, 
      TIMING_CHECK_EV_KEY_X1, 
      TIMING_CHECK_EV_KEY_Z1, 
      TIMING_CHECK_EV_KEY_0X, 
      TIMING_CHECK_EV_KEY_0Z, 
      TIMING_CHECK_EV_KEY_1X, 
      TIMING_CHECK_EV_KEY_1Z};
  private:
    RefCDOmTimingCheckEventControl getThis() const { return boost::static_pointer_cast<CDOmTimingCheckEventControl>(m_weakRef.lock()); }

    ETimingCheckType m_timingCheckType;
    RefTVec_TInt m_edgeDescriptor;
    CDOmTimingCheckEventControl(TLineNumberType lineNumber, ETimingCheckType timingCheckType );
    /*
      This build function is generic.It will be used by the three public build functions, one for
      each member of the first enumeration.
    */
    static RefCDOmTimingCheckEventControl build(TLineNumberType lineNumber, ETimingCheckType timingCheckType);
  public:
    static RefCDOmTimingCheckEventControl cast (RefCDOmBase object);
    static RefCDOmTimingCheckEventControl buildPosedge(TLineNumberType lineNumber);
    static RefCDOmTimingCheckEventControl buildNegedge(TLineNumberType lineNumber);
    static RefCDOmTimingCheckEventControl buildEdge(TLineNumberType lineNumber);
    void addEdgeDescriptor(EEdgeDescriptor edgeDescriptor);
    ETimingCheckType getTimingCheckType() const;
    RefTVec_TInt getEdgeDescriptors() const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmTimingCheckEvent class
// ********************************************************************************
/** 
 * This class models a data event or a reference event according to the grammar rules:
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * data_event ::= timing_check_event
 * reference_event ::= timing_check_event
 * timing_check_event ::=
 * [timing_check_event_control] specify_terminal_descriptor [ &&& timing_check_condition ]
 * controlled_reference_event ::= controlled_timing_check_event
 * controlled_timing_check_event ::= timing_check_event_control specify_terminal_descriptor[ &&& timing_check_condition ]
 * </code></pre>
 */
class CDOmTimingCheckEvent : public CDOmBase {
  private:
    RefCDOmTimingCheckEvent getThis() const { return boost::static_pointer_cast<CDOmTimingCheckEvent>(m_weakRef.lock()); }

    //these members hold info about the optional parameters which were set or not
    TInt m_hasTimingCheckEventControl;
    TInt m_hasTimingCheckCondition;
    CDOmTimingCheckEvent(TLineNumberType lineNumber, TInt hasTimingCheckEventControl, TInt hasTimingCheckCondition);
  public:
    static RefCDOmTimingCheckEvent cast (RefCDOmBase object);
    static RefCDOmTimingCheckEvent build(TLineNumberType lineNumber,  RefCDOmExprLink specifyTerminalDescriptor,
                                         RefCDOmTimingCheckEventControl timingCheckEventControl = RefCDOmTimingCheckEventControl(), 
                                         RefCDOmExpr timingCheckCondition = RefCDOmExpr());
    TBool canBeControlled() const;
    TBool hasTimingCheckCondition() const;
    const RefCDOmTimingCheckEventControl getTimingCheckEventControl() const;
    const RefCDOmExprLink getSpecifyTerminalDescriptor() const;
    const RefCDOmExpr getTimingCheckCondition() const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmPathDecl class
// ********************************************************************************
/** 
 * This class models a simple path declaration according to the  grammar rules:
 * <b>GRAMMAR RULES: </b> <br/>
 * path_declaration ::=
 *   simple_path_declaration ;
 * | edge_sensitive_path_declaration ;
 * | state_dependent_path_declaration ;
 * simple_path_declaration ::=
 *   parallel_path_description = path_delay_value
 * | full_path_description = path_delay_value
 * parallel_path_description ::=
 *   ( specify_input_terminal_descriptor [ polarity_operator ] => specify_output_terminal_descriptor )
 * full_path_description ::=
 *   ( list_of_path_inputs [ polarity_operator ] *> list_of_path_outputs )
 * edge_sensitive_path_declaration ::=
 *   parallel_edge_sensitive_path_description = path_delay_value
 * | full_edge_sensitive_path_description = path_delay_value
 * parallel_edge_sensitive_path_description ::=
 *   ( [ edge_identifier ] specify_input_terminal_descriptor =>
 *   ( specify_output_terminal_descriptor [ polarity_operator ] : data_source_expression ) )
 * full_edge_sensitive_path_description ::=
 *   ( [ edge_identifier ] list_of_path_inputs *>
 *   ( list_of_path_outputs [ polarity_operator ] : data_source_expression ) )
 * data_source_expression ::= expression
 * edge_identifier ::= posedge | negedge
 * polarity_operator ::= + | -
 * state_dependent_path_declaration ::=
 *   if ( module_path_expression ) simple_path_declaration
 * | if ( module_path_expression ) edge_sensitive_path_declaration
 * | ifnone simple_path_declaration
 * <pre><code>
 * </code></pre>
 */
class CDOmPathDecl : public CDOmBase {
  public:
    enum EPathDeclType { 
      PATH_DECL_SIMPLE        = 0x00,
      PATH_DECL_EDGE          = 0x01,
      PATH_DECL_SIMPLE_IF     = 0x02,
      PATH_DECL_EDGE_IF       = 0x03,
      PATH_DECL_SIMPLE_IFNONE = 0x04
    };
    enum EPathDeclRange { 
      PATH_DECL_PARALLEL = 0x00, 
      PATH_DECL_FULL     = 0x08,
    };
    enum EPathDeclEdgeIdenfier {
      PATH_DECL_NOEDGE  = 0x00,
      PATH_DECL_POSEDGE = 0x10,
      PATH_DECL_NEGEDGE = 0x20
    };
    enum EPathDeclPolarityOp {
      PATH_DECL_NOOP  = 0x00,
      PATH_DECL_PLUS  = 0x40,
      PATH_DECL_MINUS = 0x80
    };
    static const unsigned char PATH_DECL_TYPE_MASK;
    static const unsigned char PATH_DECL_RANGE_MASK;
    static const unsigned char PATH_DECL_EDGE_IDENTIFIER_MASK;
    static const unsigned char PATH_DECL_POLARY_OP_MASK;
      
  private:
    RefCDOmPathDecl getThis() const { return boost::static_pointer_cast<CDOmPathDecl>(m_weakRef.lock()); }

    unsigned char m_type;
    CDOmPathDecl(TLineNumberType lineNumber, unsigned char type);

  public:
    static RefCDOmPathDecl cast (RefCDOmBase object);
    static RefCDOmPathDecl build(TLineNumberType lineNumber, 
                                 RefCDOmSpecifyBlock   parent,
                                 EPathDeclType         type,
                                 RefCDOmBase           specInptTermDesc,
                                 RefCDOmBase           specOutTermDesc,
                                 RefCDOmPathDelayValue pathDelayValue,
                                 EPathDeclPolarityOp   polOp          = PATH_DECL_NOOP,
                                 EPathDeclEdgeIdenfier edge           = PATH_DECL_NOEDGE,
                                 RefCDOmExpr           dataSourceExpr = RefCDOmExpr(),
                                 RefCDOmExpr           modulePathExpr = RefCDOmExpr()
                                 );
    EPathDeclType getType() const;
    EPathDeclRange getRange() const;
    EPathDeclEdgeIdenfier getEdgeIdentifier() const;
    EPathDeclPolarityOp getPolarityOp() const;
    const RefCDOmExprLink            getInputTerminalDescriptor()  const;   
    const RefCDOmExprLink            getOutputTerminalDescriptor() const;
    const RefCDOmSpecifyTerminalList getListOfPathInputs()         const;
    const RefCDOmSpecifyTerminalList getListOfPathOutputs()        const;
    const RefCDOmPathDelayValue      getPathDelayValue()           const;
    const RefCDOmExpr                getDataSourceExpression()     const;
    const RefCDOmExpr                getModulePathExpr()           const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;

};

// ********************************************************************************
// CDOmGateInstantiation class
// ********************************************************************************
/** 
 * This class supports the following  grammar rules:
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 *  gate_instantiation ::=
 *  cmos_switchtype [delay3]
 *  cmos_switch_instance { , cmos_switch_instance } ;
 *  | enable_gatetype [drive_strength] [delay3]
 *  enable_gate_instance { , enable_gate_instance } ;
 *  | mos_switchtype [delay3]
 *  mos_switch_instance { , mos_switch_instance } ;
 *  | n_input_gatetype [drive_strength] [delay2]
 *  n_input_gate_instance { , n_input_gate_instance } ;
 *  | n_output_gatetype [drive_strength] [delay2]
 *  n_output_gate_instance { , n_output_gate_instance } ;
 *  | pass_en_switchtype [delay2]
 *  pass_enable_switch_instance { , pass_enable_switch_instance } ;
 *  | pass_switchtype
 *  pass_switch_instance { , pass_switch_instance } ;
 *  | pulldown [pulldown_strength]
 *  pull_gate_instance { , pull_gate_instance } ;
 *  | pullup [pullup_strength]
 *  pull_gate_instance { , pull_gate_instance } ;
 *  cmos_switch_instance ::= [ name_of_gate_instance ] ( output_terminal , input_terminal ,
 *  ncontrol_terminal , pcontrol_terminal )
 *  enable_gate_instance ::= [ name_of_gate_instance ] ( output_terminal , input_terminal , enable_terminal )
 *  mos_switch_instance ::= [ name_of_gate_instance ] ( output_terminal , input_terminal , enable_terminal )
 *  n_input_gate_instance ::= [ name_of_gate_instance ] ( output_terminal , input_terminal { , input_terminal } )
 *  n_output_gate_instance ::= [ name_of_gate_instance ] ( output_terminal { , output_terminal } ,
 *  input_terminal )
 *  pass_switch_instance ::= [ name_of_gate_instance ] ( inout_terminal , inout_terminal )
 *  pass_enable_switch_instance ::= [ name_of_gate_instance ] ( inout_terminal , inout_terminal ,
 *  enable_terminal )
 *  pull_gate_instance ::= [ name_of_gate_instance ] ( output_terminal )
 *  name_of_gate_instance ::= gate_instance_identifier [ range ]
 *  gate_instance_identifier ::= identifier
 *  enable_terminal ::= expression
 *  inout_terminal ::= net_lvalue
 *  input_terminal ::= expression
 *  ncontrol_terminal ::= expression
 *  output_terminal ::= net_lvalue
 *  pcontrol_terminal ::= expression
 *  pulldown_strength ::=
 *  ( strength0 , strength1 )
 *  | ( strength1 , strength0 )
 *  | ( strength0 )
 *  pullup_strength ::=
 *  ( strength0 , strength1 )
 *  | ( strength1 , strength0 )
 *  | ( strength1 )
 *  cmos_switchtype ::= cmos | rcmos
 *  enable_gatetype ::= bufif0 | bufif1 | notif0 | notif1
 *  mos_switchtype ::= nmos | pmos | rnmos | rpmos
 *  n_input_gatetype ::= and | nand | or | nor | xor | xnor
 *  n_output_gatetype ::= buf | not
 *  pass_en_switchtype ::= tranif0 | tranif1 | rtranif1 | rtranif0
 *  pass_switchtype ::= tran | rtran
 * </code></pre>
 */
class CDOmGateInstantiation : public CDOmAttrHolder {
  public:
    enum EGateType {
      GATE_INST_CMOS_SWITCH        = 0x10,
      GATE_INST_ENABLE_GATE        = 0x20,
      GATE_INST_MOS_SWITCH         = 0x30,
      GATE_INST_N_INPUT_GATE       = 0x40,
      GATE_INST_N_OUTPUT_GATE      = 0x50,
      GATE_INST_PASS_ENABLE_SWITCH = 0x60,
      GATE_INST_PASS_SWITCH        = 0x70,
      GATE_INST_PULLGATE           = 0x80
    };

    enum EPrimitiveType { 
      GATE_INST_CMOS     = 0x10, 
      GATE_INST_RCMOS    = 0x11, 
      GATE_INST_BUFIF0   = 0x20, 
      GATE_INST_BUFIF1   = 0x21, 
      GATE_INST_NOTIF0   = 0x22, 
      GATE_INST_NOTIF1   = 0x23, 
      GATE_INST_NMOS     = 0x30, 
      GATE_INST_PMOS     = 0x31, 
      GATE_INST_RNMOS    = 0x32, 
      GATE_INST_RPMOS    = 0x33, 
      GATE_INST_AND      = 0x40, 
      GATE_INST_NAND     = 0x41,  
      GATE_INST_OR       = 0x42, 
      GATE_INST_NOR      = 0x43, 
      GATE_INST_XOR      = 0x44, 
      GATE_INST_XNOR     = 0x45, 
      GATE_INST_BUF      = 0x50, 
      GATE_INST_NOT      = 0x51, 
      GATE_INST_TRANIF0  = 0x60, 
      GATE_INST_TRANIF1  = 0x61, 
      GATE_INST_RTRANIF1 = 0x62, 
      GATE_INST_RTRANIF0 = 0x63, 
      GATE_INST_TRAN     = 0x70, 
      GATE_INST_RTRAN    = 0x71, 
      GATE_INST_PULLDOWN = 0x80,
      GATE_INST_PULLUP   = 0x81 
    }; 
  private:
    RefCDOmGateInstantiation getThis() const { return boost::static_pointer_cast<CDOmGateInstantiation>(m_weakRef.lock()); }

    static const TUInt GATE_MASK  = 0xF0;
    unsigned char m_state;
    TInt m_trans;
    EGateType m_gateType;
    EPrimitiveType m_primitiveType;
    RefTVec_TVec_RefCDOmBase_size_type m_instances;

    ECDOmDriveStrength m_firstDriveStrength;
    ECDOmDriveStrength m_secondDriveStrength;
    //These members state whether the  optional parameter(delay3/delay2) has been set or not
    RefCDOmDelay m_delay2;
    RefCDOmDelay m_delay3;
    
    CDOmGateInstantiation(TLineNumberType lineNumber, EGateType gateType, EPrimitiveType primitiveType);
  public:
    static RefCDOmGateInstantiation cast (RefCDOmBase object);
    static RefCDOmGateInstantiation build(TLineNumberType lineNumber, RefCDOmBase parent, EPrimitiveType primitiveType);

    EGateType getGateType() const;
    EPrimitiveType getPrimitiveType() const;
    void buildDelay(TLineNumberType lineNumber);
    const RefCDOmDelay getDelay() const;
    RefCDOmDelay getDelay();
    TBool hasDelay2() const;
    TBool hasDelay3() const;
    void setDriveStrength(ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength);
    void setSingleDriveStrength(ECDOmDriveStrength firstDriveStrength);
    ECDOmDriveStrength getFirstDriveStrength() const;
    ECDOmDriveStrength getSecondDriveStrength() const;

    void addID(RefString name, RefCDOmRange range = RefCDOmRange());
    void addExpr(RefCDOmExpr expr);
    void addLvalue(RefCDOmExpr lvalue);

    static bool isAttrListColOrDelay(RefCDOmBase item);
    TInt getNrOfInstances();
    RefTVec_RefCDOmBase getInstance(TVec_TVec_RefCDOmBase_size_type::size_type index);

    void checkFinalState();

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
}; 

// ********************************************************************************
// CDOmGenInst class
// ********************************************************************************
/**
 * This class models a generated instantiation according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * generated_instantiation ::= generate { generate_item } endgenerate
 *
 * generate_item ::=
 * generate_conditional_statement
 * | generate_case_statement
 * | generate_loop_statement
 * | generate_block
 * | module_or_generate_item
 * </code></pre>
 */
class CDOmGenInst : public CDOmBase {
    RefCDOmGenInst getThis() const { return boost::static_pointer_cast<CDOmGenInst>(m_weakRef.lock()); }

    CDOmGenInst(TLineNumberType lineNumber);
  
  public:
    static RefCDOmGenInst cast (RefCDOmBase object);
    static RefCDOmGenInst build(TLineNumberType lineNumber, RefCDOmModuleDecl parent);

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmGenItemNull class
// ********************************************************************************
/**
 * This class models a generated null item according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * generate_item_or_null ::= generate_item | ;
 * </code></pre>
 */
class CDOmGenItemNull : public CDOmBase {
  private: 
    RefCDOmGenItemNull getThis() const { return boost::static_pointer_cast<CDOmGenItemNull>(m_weakRef.lock()); }

    CDOmGenItemNull(TLineNumberType lineNumber);
  public:
    static RefCDOmGenItemNull cast (RefCDOmBase object);
    static RefCDOmGenItemNull build(TLineNumberType lineNumber, RefCDOmBase parent);
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmGenItemIf class
// ********************************************************************************
/**
 * This class models a generated conditional item according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * generate_conditional_statement ::=
 *    if ( constant_expression ) generate_item_or_null [ else generate_item_or_null ]
 * </code></pre>
 */
class CDOmGenItemIf : public CDOmBase {
  private:
    RefCDOmGenItemIf getThis() const { return boost::static_pointer_cast<CDOmGenItemIf>(m_weakRef.lock()); }

    CDOmGenItemIf(TLineNumberType lineNumber);

    friend class CDOmBase;
    void beforeAddingGenItemOrNull();
  public:
    static RefCDOmGenItemIf cast (RefCDOmBase object);
    static RefCDOmGenItemIf build(TLineNumberType lineNumber, RefCDOmBase parent, RefCDOmExpr ifCondExpr); // a null elseItem means no else
  
    RefCDOmExpr getIfCondExpr() const;

    RefCDOmBase getIfItem() const;

    RefCDOmBase getElseItem() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmGenItemCase class
// ********************************************************************************
/**
 * This class models a generated case item according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * generate_case_statement ::= 
 * case ( constant_expression )
 * genvar_case_item { genvar_case_item } endcase
 *
 * genvar_case_item ::= 
 * constant_expression { , constant_expression } : generate_item_or_null 
 * | default [ : ] generate_item_or_null
 * </code></pre>
 */
class CDOmGenItemCase : public CDOmBase {
  private:
    RefCDOmGenItemCase getThis() const { return boost::static_pointer_cast<CDOmGenItemCase>(m_weakRef.lock()); }

    TBool m_hasDefault;

    CDOmGenItemCase(TLineNumberType lineNumber);

    friend class CDOmBase;
    void beforeAddingGenItemOrNull();

  public:
    static RefCDOmGenItemCase cast (RefCDOmBase object);
    static RefCDOmGenItemCase build(TLineNumberType lineNumber, RefCDOmBase parent, RefCDOmExpr expr, RefCDOmListExpr exprList); // a null exprList means "default:"

    TBool hasDefault() const;

    void addCaseItem(RefCDOmListExpr exprList); // a null exprList means "default:"

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmGenItemLoop class
// ********************************************************************************
/**
 * This class models a generated loop item according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * generate_loop_statement ::= for ( genvar_assignment ; constant_expression ; genvar_assignment )
 * begin : generate_block_identifier { generate_item } end
 *
 * genvar_assignment ::= genvar_identifier = constant_expression
 * </code></pre>
 */
class CDOmGenItemLoop : public CDOmBase {
  private:
    RefCDOmGenItemLoop getThis() const { return boost::static_pointer_cast<CDOmGenItemLoop>(m_weakRef.lock()); }

    CDOmGenItemLoop(TLineNumberType lineNumber);

    friend class CDOmBase;
    void beforeAddingGenItemBlock(ECDOmType type);
  public:
    static RefCDOmGenItemLoop cast (RefCDOmBase object);
    static RefCDOmGenItemLoop build(TLineNumberType lineNumber, RefCDOmBase parent, RefCDOmExprLink initAssnIdentifier, RefCDOmExpr initAssnExpr, RefCDOmExpr condExpr, 
                                    RefCDOmExprLink incAssnIdentifier, RefCDOmExpr incAssnExpr);
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmGenItemBlock class
// ********************************************************************************
/**
 * This class models a generated block item according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * generate_block ::= begin [ : generate_block_identifier ] { generate_item } end
 * </code></pre>
 */
class CDOmGenItemBlock : public CDOmBase {
  private:
    RefCDOmGenItemBlock getThis() const { return boost::static_pointer_cast<CDOmGenItemBlock>(m_weakRef.lock()); }

    RefCDOmScope m_scope;
    
    CDOmGenItemBlock(TLineNumberType lineNumber, TBool isNamed);
  public:
    static RefCDOmGenItemBlock cast (RefCDOmBase object);
    static RefCDOmGenItemBlock build(TLineNumberType lineNumber, RefCDOmBase parent, const RefString name = RefString());

    TBool isNamed() const;
    RefCDOmScope getAttachedScope() const;
    const RefTVec_RefCDOmBase getItems() const;
    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmFunctionCall class
// ********************************************************************************
/**
 * This class models a function call according to the grammar rules.
 * It is used for both function calls and system function calls. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * constant_function_call ::= function_identifier { attribute_instance }
 *   ( constant_expression { , constant_expression } )
 * function_call ::= hierarchical_function_identifier { attribute_instance }
 *   ( expression { , expression } )
 * system_function_call ::= system_function_identifier
 *   [ ( expression { , expression } ) ]
 *
 * function_identifier ::= identifier
 * hierarchical_function_identifier ::= hierarchical_identifier
 * system_function_identifier ::= $[ a-zA-Z0-9_$ ] { [ a-zA-Z0-9_$ ] }
 * </code></pre>
 */
class CDOmFunctionCall : public CDOmExpr {
  public:
    /**
     * Holds enum constants for function call types.
     */
    enum EFunctionCallType {FUNCTION_CALL_ID, FUNCTION_CALL_HID, FUNCTION_CALL_SYSTEM};

  private:
    RefCDOmFunctionCall getThis() const { return boost::static_pointer_cast<CDOmFunctionCall>(m_weakRef.lock()); }

    EFunctionCallType m_functionCallType;

    CDOmFunctionCall(TLineNumberType lineNumber, EFunctionCallType functionCallType);

  public:
    static RefCDOmFunctionCall cast (RefCDOmBase object);
    static RefCDOmFunctionCall build(TLineNumberType lineNumber, RefCDOmExprLink exprLink, RefCDOmListExpr exprList, RefCDOmAttrListCollection attrListCollection = RefCDOmAttrListCollection());

    EFunctionCallType getFunctionCallType() const;

    TBool isConst() const;

    TBool canBeModulePath() const;

    //RefCDOmEvalRes doEval() const;
    RefCDOmBase doEval() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmDesign class
// ********************************************************************************
/**
 * This CDOM class represents the "design" concept. All modules and UDPs in a design
 * are attached to only one design object. However, an application can create multiple design objects,
 * each of them holding unrelated modules and UDPs. <br/>
 * This class provides instance factory methods to properly build and attach modules and UDPs
 * to a particular design instance. <br/>
 * In CDOM therms, a design is a scope and models the absolute root concept. It is the scope
 * parent of all top level instances: modules and UDPs.
 */
class CDOmDesign : public CDOmBase {
  private:
    RefCDOmDesign getThis() const { return boost::static_pointer_cast<CDOmDesign>(m_weakRef.lock()); }

    RefCDOmScope m_scope; // attached scope

    CDOmDesign();

  public:
    static RefCDOmDesign cast (RefCDOmBase object);
    static RefCDOmDesign build();

    RefCDOmScope getAttachedScope() const;

    RefCDOmModuleDecl buildModuleDecl(TLineNumberType lineNumber, const RefString& name, CDOmModuleDecl::EKeywordType keywordType = CDOmModuleDecl::KEYWORD_MODULE);
  
    RefCDOmUdpDecl buildUdpDecl(TLineNumberType lineNumber, const RefString name);

    const RefTVec_RefCDOmBase getTops() const;

    const RefTVec_RefCDOmModuleDecl getModuleDecls() const;
  
    const RefTVec_RefCDOmBase getDefineDecls() const;

    const RefTVec_RefCDOmUdpDecl getUdpDecls() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;

};

// ********************************************************************************
// CDOmEvalRes class
// ********************************************************************************
class CDOmEvalRes {
  public:
    enum EEvalResType {EVAL_RES_UNDEF, EVAL_RES_VERINUM, EVAL_RES_REALNUM};

  private:
    EEvalResType m_evalResType;
    RefCVeriNum m_veriNum;
    RefCRealNum m_realNum;

    CDOmEvalRes(const RefCVeriNum& veriNum);

    CDOmEvalRes(const RefCRealNum& realNum);

  public:
    static RefCDOmEvalRes build(const RefCVeriNum& veriNum);

    static RefCDOmEvalRes build(const RefCRealNum& realNum);

    EEvalResType getEvalResType() const;

    RefCVeriNum getVeriNum();

    RefCRealNum getRealNum();

    std::ostream& dump(std::ostream& os) const;
};

CDOmEvalRes evalUnaryOp(CDOmExprOp::EOpType opType, const RefCDOmEvalRes& e1);

CDOmEvalRes evalBinaryOp(CDOmExprOp::EOpType opType, const RefCDOmEvalRes& e1, const RefCDOmEvalRes& e2);

CDOmEvalRes evalTernaryOp(CDOmExprOp::EOpType opType, const RefCDOmEvalRes& e1, const RefCDOmEvalRes& e2, const RefCDOmEvalRes& e3);

// ********************************************************************************
// CDOmNumber class
// ********************************************************************************
//class CDOmNumber : public CDOmExpr {
//public:
//  enum ENumBaseType {NUM_BASE_BIN, NUM_BASE_OCT, NUM_BASE_DEC, NUM_BASE_HEX};
//
//private:
//  RefCDOmNumber getThis() const { return boost::static_pointer_cast<CDOmNumber>(m_weakRef.lock()); }
//
//  ENumBaseType m_numBaseType;
//  RefString m_tokenString; // full token string. i.e.: "'sb0011"
//  RefCVeriNum m_veriNum;
//
//  CDOmNumber(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& tokenString, const RefCVeriNum& veriNum);
//
//public:
//  static RefCDOmNumber cast (RefCDOmBase object);
//  static RefCDOmNumber build(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& tokenString, const RefString& lightString, TBool isSigned = false, TUInt size = 0);
//
//  TBool isSigned() const;
//
//  TInt getSize() const;
//
//  ENumBaseType getNumBaseType() const;
//
//  RefString getTokenString() const;
//
//  RefCVeriNum getVeriNum() const;
//
//  TBool isConst() const;
//
//  TBool canBeModulePath() const;
//
//  RefCDOmEvalRes doEval() const;
//};
//

// ********************************************************************************
// CDOmNumber class
// ********************************************************************************
/**
 * CDOmNumber represents a const Number expresion. ENumBaseType is an enum that 
 * tells us the base of the current object:
 *   - NUM_BASE_BIN - bynary
 *   - NUM_BASE_OCT - base 8
 *   - NUM_BASE_DEC - decimal
 *   - NUM_BASE_HEX - hexa
 * The number is a RefCVeriNum.
 */
class CDOmNumber : public CDOmExpr {
  public:
    static RefCDOmNumber cast(RefCDOmBase object);
  private:
    RefCDOmNumber getThis() const { return boost::static_pointer_cast<CDOmNumber>(m_weakRef.lock()); }

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
      NUM_VERILOG,
      NUM_MAX
    };

  protected:
    RefString m_tokenString;
    RefCVeriNum m_veriNum;

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
    //if set to true, the following flag states that the current number object
    //will be transformed into a verilog number by the verilog codegen
    //otherwise, a regular number is to be generated
    TBool m_isVeriNum;

    CDOmNumber(TLineNumberType, ENumBaseType, const RefString&, const RefCVeriNum&);
    CDOmNumber(TLineNumberType lineNumber, ENumType numType, ENumBaseType numBaseType, TBool hasXZ = FALSE);

  public:
    /**
     * The build method for CDOmNumber
     *
     * @param lineNumber - type TLineNumberType - the lineNumber where the number appears
     * @param numBaseType - type ENumBaseType - the base of the number bin, oct, dec, hex
     * @param tokenString - type RefString - the token string of the number; example "'b10111"
     * @param lightString - type RefString - the string that retains tha number; for the example above "10111"
     * @param isSigned - type TBool - retain if the number has sign(implicit value false: unsigned number)
     * @param size - type TUInt - the size of the number as number of digits; for example above the size is 5, for decimal number "5697" the size is 4
     *
     * @return RefCDOmNumber - the number object that has been built
     *
     * @see ENumBaseType
     */
    static RefCDOmNumber build(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& lightString, TInt width = 0, TBool hasXZ = FALSE);
  
    const ENumType getNumType() const;
    const TBool getOverflow() const;
    const TBool hasXZ() const;
    TBool isConst() const;
    TBool canBeModulePath() const;
    const TBool isSigned() const;
    const TBool isEvaluated() const;
    const TBool isTrunkated() const;
    const TBool isRounded() const;
    const TInt getWidth() const;
    const TInt getNoOfBitsTrunk() const;
    const TInt getNoOfBitsRound() const;
    const TBool getIsVeriNumFlag() const;


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
    void setIsVeriNumFlag(TBool);

    TInt getSize() const;
    ENumBaseType getNumBaseType() const;
    const RefString getTokenString() const;
    RefCVeriNum getVeriNum() const;
    void setVeriNum(RefCVeriNum);
 
    void addCDOmNumber(RefCDOmNumber num);
    virtual void changeSign() = 0;

    virtual const TInt getValue() const = 0;
    virtual void setValue(TInt value) = 0;

    virtual TBool equals(TInt) = 0;
    virtual TInt calcWidth() = 0;
    virtual RefCDOmNumber maxValue() = 0;
    virtual RefCDOmNumber plus() = 0;
    virtual RefCDOmNumber minus() = 0;
    virtual RefCDOmNumber logicNot() = 0;
    virtual RefCDOmNumber bitwiseNot() = 0;
    virtual RefCDOmNumber reductionAnd() = 0;
    virtual RefCDOmNumber reductionNand() = 0;
    virtual RefCDOmNumber reductionOr() = 0;
    virtual RefCDOmNumber reductionNor() = 0;
    virtual RefCDOmNumber reductionXor() = 0;
    virtual RefCDOmNumber reductionXnor() = 0;
    virtual RefCDOmNumber add(RefCDOmNumber) = 0;
    virtual RefCDOmNumber substract(RefCDOmNumber) = 0;
    virtual RefCDOmNumber multiply(RefCDOmNumber) = 0;
    virtual RefCDOmNumber divide(RefCDOmNumber) = 0;
    virtual RefCDOmNumber modulo(RefCDOmNumber) = 0;
    virtual RefCDOmNumber power(RefCDOmNumber) = 0;
    virtual RefCDOmNumber shiftLeft(RefCDOmNumber) = 0;
    virtual RefCDOmNumber shiftRight(RefCDOmNumber) = 0;
    virtual RefCDOmNumber equality(RefCDOmNumber) = 0;
    virtual RefCDOmNumber notEquality(RefCDOmNumber) = 0;
    virtual RefCDOmNumber equalityEqualCase(RefCDOmNumber) = 0;
    virtual RefCDOmNumber equalityNotEqualCase(RefCDOmNumber) = 0;
    virtual RefCDOmNumber logicAnd(RefCDOmNumber) = 0;
    virtual RefCDOmNumber logicOr(RefCDOmNumber) = 0;
    virtual RefCDOmNumber relationalLess(RefCDOmNumber) = 0;
    virtual RefCDOmNumber relationalLessEqual(RefCDOmNumber) = 0;
    virtual RefCDOmNumber relationalGreater(RefCDOmNumber) = 0;
    virtual RefCDOmNumber relationalGreaterEqual(RefCDOmNumber) = 0;
    virtual RefCDOmNumber bitwiseAnd(RefCDOmNumber) = 0;
    virtual RefCDOmNumber bitwiseNand(RefCDOmNumber) = 0;
    virtual RefCDOmNumber bitwiseOr(RefCDOmNumber) = 0;
    virtual RefCDOmNumber bitwiseNor(RefCDOmNumber) = 0;
    virtual RefCDOmNumber bitwiseXor(RefCDOmNumber) = 0;
    virtual RefCDOmNumber bitwiseXnor(RefCDOmNumber) = 0;
    virtual RefCDOmNumber binaryShiftLeft(RefCDOmNumber) = 0;
    virtual RefCDOmNumber binaryShiftRight(RefCDOmNumber) = 0;
    virtual RefCDOmNumber ternaryCondition(RefCDOmNumber, RefCDOmNumber) = 0;

    //RefCDOmEvalRes doEval() const;
    RefCDOmBase doEval() const;
};

// ********************************************************************************
// CDOmNum32 class
// ********************************************************************************
class CDOmNum32 : public CDOmNumber {
  public:
    static RefCDOmNum32 cast(RefCDOmBase object);
  private:
    RefCDOmNum32 getThis() const { return boost::static_pointer_cast<CDOmNum32>(m_weakRef.lock()); }
    TInt m_value;
    static TInt converter(CDOmNumber::ENumBaseType base, RefString number);
    static const TInt maxWidth;

  protected:
    CDOmNum32(TLineNumberType lineNumber, CDOmNumber::ENumBaseType base, const TInt value);
  public:
    static RefCDOmNum32 build(TLineNumberType lineNumber, TInt value, CDOmNumber::ENumBaseType type = CDOmNumber::NUM_BASE_DEC, TInt width = 0);
    static RefCDOmNum32 build(TLineNumberType lineNumber, CDOmNumber::ENumBaseType base, RefString num, TInt width = 0);
    const TInt getValue() const;
    void setValue(TInt value);
    void changeSign();
    TBool equals(TInt);
    TInt calcWidth();
    RefCDOmNumber maxValue();
    RefCDOmNumber plus();
    RefCDOmNumber minus();
    RefCDOmNumber logicNot();
    RefCDOmNumber bitwiseNot();
    RefCDOmNumber reductionAnd();
    RefCDOmNumber reductionNand();
    RefCDOmNumber reductionOr();
    RefCDOmNumber reductionNor();
    RefCDOmNumber reductionXor();
    RefCDOmNumber reductionXnor(); 
    RefCDOmNumber add(RefCDOmNumber);
    RefCDOmNumber substract(RefCDOmNumber);
    RefCDOmNumber multiply(RefCDOmNumber);
    RefCDOmNumber divide(RefCDOmNumber);
    RefCDOmNumber modulo(RefCDOmNumber);
    RefCDOmNumber power(RefCDOmNumber);
    RefCDOmNumber shiftLeft(RefCDOmNumber);
    RefCDOmNumber shiftRight(RefCDOmNumber);
    RefCDOmNumber equality(RefCDOmNumber);
    RefCDOmNumber notEquality(RefCDOmNumber);
    RefCDOmNumber equalityEqualCase(RefCDOmNumber);
    RefCDOmNumber equalityNotEqualCase(RefCDOmNumber);
    RefCDOmNumber logicAnd(RefCDOmNumber);
    RefCDOmNumber logicOr(RefCDOmNumber);
    RefCDOmNumber relationalLess(RefCDOmNumber);
    RefCDOmNumber relationalLessEqual(RefCDOmNumber);
    RefCDOmNumber relationalGreater(RefCDOmNumber);
    RefCDOmNumber relationalGreaterEqual(RefCDOmNumber);
    RefCDOmNumber bitwiseAnd(RefCDOmNumber);
    RefCDOmNumber bitwiseNand(RefCDOmNumber);
    RefCDOmNumber bitwiseOr(RefCDOmNumber);
    RefCDOmNumber bitwiseNor(RefCDOmNumber);
    RefCDOmNumber bitwiseXor(RefCDOmNumber);
    RefCDOmNumber bitwiseXnor(RefCDOmNumber);
    RefCDOmNumber binaryShiftLeft(RefCDOmNumber);
    RefCDOmNumber binaryShiftRight(RefCDOmNumber);
    RefCDOmNumber ternaryCondition(RefCDOmNumber, RefCDOmNumber);

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const ;
};

//Tb removed//
// // ********************************************************************************
// // CDOmBitArray class
// // ********************************************************************************

// class CDOmBitArray: public CDOmBase {
//   public:
//     enum TBit { _0 = 0, _1, _X, _Z };
//     static const TInt blockSize = sizeof(TUInt) * 8;
//   private:
//     TUInt m_len;
//     TInt m_blockCount;
//     RefTVec_TUInt m_blocks;

//     RefCDOmBitArray getThis() const { return boost::static_pointer_cast<CDOmBitArray>(m_weakRef.lock()); }
//     CDOmBitArray(TLineNumberType lineNumber);
//     CDOmBitArray(TLineNumberType lineNUmber, TUInt len);
//     CDOmBitArray(TLineNumberType lineNumber, const RefCDOmBitArray other);
//   public:
//     static RefCDOmBitArray cast(RefCDOmBase object);
//     static RefCDOmBitArray build(TLineNumberType lineNumber);
//     static RefCDOmBitArray build(TLineNumberType lineNumber, TUInt len);
//     static RefCDOmBitArray build(TLineNumberType lineNumber, const RefCDOmBitArray other);
    
//     static void bitPos(TInt bitIndex, TInt& blkNum, TInt& blkOffset);
//     void setLen(TUInt l);
//     TUInt getLen() const { return m_len; }
//     TBool validateIndex(TUInt index) const;
//     void setBit(TInt index, TBit b);
//     TBit getBit(TInt index) const;
//     //std::ostream& dump(std::ostream& os) const; -> to be deleted
//     //TBit operator[](TInt index) const { return bit(index); }
// };

// // ********************************************************************************
// // CDOmVeriNum class
// // ********************************************************************************

// class CDOmVeriNum : public CDOmNumber {
//   public:
//     enum TPadType { PAD_SIGN, PAD_ZERO };
//     static RefTVec_RefString hexArr;
//     static RefTVec_RefString octArr;
//     static RefCDOmVeriNum cast(RefCDOmBase object);

//   private:
//     RefCDOmBitArray m_bits;

//   private:
//     RefCDOmVeriNum getThis() const { return boost::static_pointer_cast<CDOmVeriNum>(m_weakRef.lock()); }

//     CDOmVeriNum(TLineNumberType lineNumber, CDOmBitArray::TBit b, TInt width);
//     // construct verilog number from base specifier and a number string.
//     // number string consists of digits (without spaces or _ symbols inside).
//     // digits should be corresponding to the base specifier.
//     // Example: "00110X" (binary), "023007" (octal), "01FZ" (hex),
//     // "1234567890" (decimal)
//     // if there is a Z or X digit inside a decimal string, 32 bit number
//     // will be constructed with all bits set to Z (or X).
//     CDOmVeriNum(TLineNumberType lineNumber, ENumBaseType base, const RefString& str, TBool isSigned, TUInt with);
//     // construct verilog number from signed int, with specified length
//     CDOmVeriNum(TLineNumberType lineNumber, TInt val, TInt width);

//     static CDOmBitArray::TBit add(CDOmBitArray::TBit a, CDOmBitArray::TBit b, CDOmBitArray::TBit& carry);
//     static CDOmBitArray::TBit negBit(CDOmBitArray::TBit bit);
//     static CDOmBitArray::TBit andTBit(CDOmBitArray::TBit a, CDOmBitArray::TBit b);
//     static CDOmBitArray::TBit orTBit(CDOmBitArray::TBit a, CDOmBitArray::TBit b);
//     static CDOmBitArray::TBit xorTBit(CDOmBitArray::TBit a, CDOmBitArray::TBit b);
//     static CDOmBitArray::TBit combine(CDOmBitArray::TBit a, CDOmBitArray::TBit b);
//     static TBool isDefined(CDOmBitArray::TBit bit);

//   public:
//     static RefCDOmVeriNum build(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& lightString, TBool isSigned, TUInt width = 32);
//     static RefCDOmVeriNum build(TLineNumberType lineNumber, TInt value, TUInt width = 32);
//     static RefCDOmVeriNum build(TLineNumberType lineNumber, CDOmBitArray::TBit bit, TUInt width = 1);

//     void trunc(TUInt width);
//     void assign(RefCDOmVeriNum);
//     void setBit(TInt index, CDOmBitArray::TBit bit);
//     CDOmBitArray::TBit safeGetBit(TUInt index, TPadType pad = PAD_SIGN) const;
//     CDOmBitArray::TBit getBit(TInt index) const;
//     CDOmBitArray::TBit getMsb() const;
//     TBool isNeg() const;
//     TBool isEven() const;
//     TBool isOdd() const;
//     CDOmBitArray::TBit logicVal() const;
//     TBool carryLookAhead(RefCDOmVeriNum number, TUInt &maxLen);
//     TBool isDefined() const;
//     TBool isZero() const;
//     CDOmBitArray::TBit padBit(TPadType pad = PAD_SIGN) const;
//     TUInt getLen() const;
//     void addby(RefCDOmNumber);
//     void setSign(TBool signFlag);
//     const TUInt getValueAsUInt() const;
//     const TInt getValue() const;
//     RefString getValueAsString() const;
//     RefString toString() const;
//     void setValue(TInt value);
//     RefCDOmVeriNum abs();

//     void changeSign();
//     TBool equals(TInt);
//     TInt calcWidth();
//     RefCDOmNumber maxValue();
//     RefCDOmNumber plus();
//     RefCDOmNumber minus();
//     RefCDOmNumber logicNot();
//     RefCDOmNumber bitwiseNot();
//     RefCDOmNumber reductionAnd();
//     RefCDOmNumber reductionNand();
//     RefCDOmNumber reductionOr();
//     RefCDOmNumber reductionNor();
//     RefCDOmNumber reductionXor();
//     RefCDOmNumber reductionXnor();
//     RefCDOmNumber add(RefCDOmNumber);
//     RefCDOmNumber substract(RefCDOmNumber);
//     RefCDOmNumber multiply(RefCDOmNumber);
//     RefCDOmNumber divide(RefCDOmNumber);
//     RefCDOmNumber modulo(RefCDOmNumber);
//     RefCDOmNumber power(RefCDOmNumber);
//     RefCDOmNumber shiftLeft(RefCDOmNumber);
//     RefCDOmNumber shiftRight(RefCDOmNumber);
//     RefCDOmNumber equality(RefCDOmNumber);
//     RefCDOmNumber notEquality(RefCDOmNumber);
//     RefCDOmNumber equalityEqualCase(RefCDOmNumber);
//     RefCDOmNumber equalityNotEqualCase(RefCDOmNumber);
//     RefCDOmNumber logicAnd(RefCDOmNumber);
//     RefCDOmNumber logicOr(RefCDOmNumber);
//     RefCDOmNumber relationalLess(RefCDOmNumber);
//     RefCDOmNumber relationalLessEqual(RefCDOmNumber);
//     RefCDOmNumber relationalGreater(RefCDOmNumber);
//     RefCDOmNumber relationalGreaterEqual(RefCDOmNumber);
//     RefCDOmNumber bitwiseAnd(RefCDOmNumber);
//     RefCDOmNumber bitwiseNand(RefCDOmNumber);
//     RefCDOmNumber bitwiseOr(RefCDOmNumber);
//     RefCDOmNumber bitwiseNor(RefCDOmNumber);
//     RefCDOmNumber bitwiseXor(RefCDOmNumber);
//     RefCDOmNumber bitwiseXnor(RefCDOmNumber);
//     RefCDOmNumber binaryShiftLeft(RefCDOmNumber);
//     RefCDOmNumber binaryShiftRight(RefCDOmNumber);
//     RefCDOmNumber ternaryCondition(RefCDOmNumber, RefCDOmNumber);

//     RefCDOmEvalRes doEval() const{}
//     void acceptVisitor(NSCdomVisitor::CVisitor& vistor) const;
// };
//~Tb removed//

//added by Tb
// ********************************************************************************
// CDOmVeriNum class
// ********************************************************************************
class CDOmVeriNum : public CDOmNumber {
  public:
    enum EVeriNumBit {
      _0 = 0,
      _1 = 1,
      _Z = 2,
      _X = 3
    };

    enum EVeriNumSign {
      VERINUM_POS,
      VERINUM_NEG
    };

    enum EVeriNumRatio {
      VERINUM_BIN_TO_BIN_RATIO = 1,
      VERINUM_OCT_TO_BIN_RATIO = 3,
      VERINUM_HEX_TO_BIN_RATIO = 4
    };

  private:
    RefTVec_TUInt                       m_blocks;
    EVeriNumSign                        m_sign;

  public:
    ~CDOmVeriNum();

    static RefCDOmVeriNum build(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& tokenString, const RefString& lightString, TBool isSigned = FALSE, TInt width = VERINUM_DEFAULT_SIZE);
    static RefCDOmVeriNum build(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& lightString, TBool isSigned = FALSE, TInt width = VERINUM_DEFAULT_SIZE);

    static RefCDOmVeriNum cast(RefCDOmBase object);

    void changeSign();

    void setValue(TInt value){}
    const TInt getValue() const;

    TBool equals(TInt);
    TInt calcWidth();
    RefCDOmNumber maxValue();
    RefCDOmNumber plus();
    RefCDOmNumber minus();
    RefCDOmNumber logicNot();
    RefCDOmNumber bitwiseNot();
    RefCDOmNumber reductionAnd();
    RefCDOmNumber reductionNand();
    RefCDOmNumber reductionOr();
    RefCDOmNumber reductionNor();
    RefCDOmNumber reductionXor();
    RefCDOmNumber reductionXnor();
    RefCDOmNumber add(RefCDOmNumber);
    RefCDOmNumber substract(RefCDOmNumber);
    RefCDOmNumber multiply(RefCDOmNumber);
    RefCDOmNumber divide(RefCDOmNumber);
    RefCDOmNumber modulo(RefCDOmNumber);
    RefCDOmNumber power(RefCDOmNumber);
    RefCDOmNumber shiftLeft(RefCDOmNumber);
    RefCDOmNumber shiftRight(RefCDOmNumber);
    RefCDOmNumber equality(RefCDOmNumber);
    RefCDOmNumber notEquality(RefCDOmNumber);
    RefCDOmNumber equalityEqualCase(RefCDOmNumber);
    RefCDOmNumber equalityNotEqualCase(RefCDOmNumber);
    RefCDOmNumber logicAnd(RefCDOmNumber);
    RefCDOmNumber logicOr(RefCDOmNumber);
    RefCDOmNumber relationalLess(RefCDOmNumber);
    RefCDOmNumber relationalLessEqual(RefCDOmNumber);
    RefCDOmNumber relationalGreater(RefCDOmNumber);
    RefCDOmNumber relationalGreaterEqual(RefCDOmNumber);
    RefCDOmNumber bitwiseAnd(RefCDOmNumber);
    RefCDOmNumber bitwiseNand(RefCDOmNumber);
    RefCDOmNumber bitwiseOr(RefCDOmNumber);
    RefCDOmNumber bitwiseNor(RefCDOmNumber);
    RefCDOmNumber bitwiseXor(RefCDOmNumber);
    RefCDOmNumber bitwiseXnor(RefCDOmNumber);
    RefCDOmNumber binaryShiftLeft(RefCDOmNumber);
    RefCDOmNumber binaryShiftRight(RefCDOmNumber);
    RefCDOmNumber ternaryCondition(RefCDOmNumber, RefCDOmNumber);

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;

  protected:
    /** Rules for the constructor:
     * - X, Z not allowed for decimal numbers
     * - if the width is smaller than the value representation then the leftmost bits exceeding the width are ignored(warning should be thrown)
     * - if the width is bigger than the value representation then the leftmost bits are filled with: '0' if the lefmost bit is '1' or '0',
     * - 'Z' if the leftmost bit is 'Z' and 'X' if the leftmost bit is 'X'
     */
    /** The string received is parsed(right to left, least-significant to most-significant), then each character is passed to toDec which
     * returns the decimal equivalent to it (0 -> 0, ... ,A -> 10, ... ,F -> 15, Z -> 16(10000), X -> 37(11111)), the decimal number received
     * is transformed into binary representation(depending on the base of the number, the result is stored in 1 bit for BIN, 3 bits for OCT and
     * 4 bits for HEX). The binary representation(which now includes _Z znd _X bits) is added into the m_blocks vector at the coresponding index.
     * For example: 10_1100011101110101 in binary base whill be stored on 2 blocks(on a sizeof(int) = 32 machine) like this:
     * the first block 1100011101110101 and the second one 10; for the other bases the situation is similar to this one.
     * NOTE: the convention was that only numbers that have X or Z bit(s) are to be stored as VeriNums, and the DEC base cannot have such bits.
     */
    CDOmVeriNum(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& lightString, TBool isSigned, TInt width = VERINUM_DEFAULT_SIZE);

  private:
    RefCDOmVeriNum getThis() const { return boost::static_pointer_cast<CDOmVeriNum>(m_weakRef.lock()); }

    void setBitAt(TUInt offset, EVeriNumBit veriNumBit);

    TUInt toDec(TChar c);

    //added for testing purposes
    void printBlocks();
};
//~added by Tb

// ********************************************************************************
// CDOmReal class
// ********************************************************************************
class CDOmReal : public CDOmExpr {
  private:
    RefCDOmReal getThis() const { return boost::static_pointer_cast<CDOmReal>(m_weakRef.lock()); }

    RefString m_tokenString; // full token string. i.e.: "23_4.2__11exp-1_0"
    RefCRealNum m_realNum;

    CDOmReal(TLineNumberType lineNumber, const RefString& tokenString, const RefCRealNum& realNum);

  public:
    static RefCDOmReal cast (RefCDOmBase object);
    static RefCDOmReal build(TLineNumberType lineNumber, const RefString& tokenString, const RefString& lightString);

    RefString getTokenString() const;

    RefCRealNum getRealNum() const;

    TBool isConst() const;

    TBool canBeModulePath() const;

    RefCDOmBase doEval() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CDOmString class
// ********************************************************************************
class CDOmString : public CDOmExpr {
  private:
    RefCDOmString getThis() const { return boost::static_pointer_cast<CDOmString>(m_weakRef.lock()); }

    RefString m_tokenString;
    RefCVeriNum m_veriNum;

    CDOmString(TLineNumberType lineNumber, const RefString& tokenString, const RefCVeriNum& veriNum);

  public:
    static RefCDOmString cast(RefCDOmBase object);
    // Note: tokenString must be the exact string found in the parsed file
    // it may contain escape sequences in it, like: "ABC\nDE\088"
    // strVal is a string value, where all escape sequnces are
    // already converted to corresponding characters
    static RefCDOmString build(TLineNumberType lineNumber, const RefString& tokenString, const RefString& strVal);

    static RefCDOmString build(TLineNumberType lineNumber, const RefString& tokenString);

    RefString getTokenString() const;

    RefCVeriNum getVeriNum() const;

    TBool isConst() const;

    TBool canBeModulePath() const;

    RefCDOmBase doEval() const;

    void acceptVisitor(NSCdomVisitor::CVisitor& visitor) const;
};

} // end namespace NSCdom

#endif /*INC_GUARD_CDOM_h*/
