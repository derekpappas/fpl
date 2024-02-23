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

#ifndef INC_GUARD_CSIM_CMD_LINE_TYPE_DEFS_H
#define INC_GUARD_CSIM_CMD_LINE_TYPE_DEFS_H

#include "CsimTypeDefs.h"

namespace NSCsimLib {


typedef enum _EExprType {
  EXPR_TYPE_UNDEF,
  EXPR_TYPE_NUM,
  EXPR_TYPE_OPER,
  EXPR_TYPE_ID,
  EXPR_TYPE_MAX
} EExprType;


typedef enum _EExprOperType {
  EXPR_OPER_TYPE_UNDEF,
  EXPR_OPER_TYPE_ASSIGN,       //1
  EXPR_OPER_TYPE_COMPARE_NEQT, //2
  EXPR_OPER_TYPE_COMPARE_EQT,  //3
  EXPR_OPER_TYPE_COMPARE_GTE,  //4
  EXPR_OPER_TYPE_COMPARE_GT,   //5
  EXPR_OPER_TYPE_COMPARE_LTE,  //6
  EXPR_OPER_TYPE_COMPARE_LT,   //7
  EXPR_OPER_TYPE_MINUS,        //8
  EXPR_OPER_TYPE_PLUS,         //9
  EXPR_OPER_TYPE_MODULUS,      //10
  EXPR_OPER_TYPE_DIVIDE,       //11
  EXPR_OPER_TYPE_MULTIPLY,     //12
  //  EXPR_OPER_TYPE_UNARY_PLUS,
  //  EXPR_OPER_TYPE_UNARY_MINUS,
  EXPR_OPER_TYPE_RPAREN,       //13
  EXPR_OPER_TYPE_LPAREN,       //14
  EXPR_OPER_TYPE_PAREN,//for internal use  //15
  EXPR_OPER_TYPE_MAX
} EExprOperType;





//WHEN ADDING ELLEMENTS HERE 
//REMEMBER TO ADD TO EShellCmdOption TOO AT THE SAME POSITION
//WITH THE SAME VALUE
typedef enum _EExprIdType {
  EXPR_ID_TYPE_UNDEF,
  EXPR_ID_TYPE_SIGNAL = 0x00000001,
  EXPR_ID_TYPE_UNIT   = 0x00000002,
  EXPR_ID_TYPE_CLOCK  = 0x00000004,
  EXPR_ID_TYPE_FF     = 0x00000008,
  EXPR_ID_TYPE_VW     = 0x00000010,
  EXPR_ID_TYPE_MEM    = 0x00000020,
  EXPR_ID_TYPE_MAX
} EExprIdType;


typedef enum _EExprOperArity {
  EXPR_OPER_ARITY_UNDEF,
  EXPR_OPER_ARITY_UNARY,
  EXPR_OPER_ARITY_BINARY,
  EXPR_OPER_ARITY_TERNARY,
  EXPR_OPER_ARITY_UNARY_AND_BINARY,
  EXPR_OPER_ARITY_MAX
} EExprOperArity;




//WHEN ADDING ELLEMENTS HERE 
//REMEMBER TO ADD TO EEExprIdType TOO AT THE SAME POSITION
//WITH THE SAME VALUE IF ELEMENT CONCERNS TYPE, NOT CMD ARG
typedef enum _EShellCmdOption {
  CMD_OPTION_UNDEF,
  CMD_OPTION_SIGNAL      = 0x00000001,
  CMD_OPTION_UNIT        = 0x00000002,
  CMD_OPTION_CLOCK       = 0x00000004,
  CMD_OPTION_FF          = 0x00000008,
  CMD_OPTION_VW          = 0x00000010,
  CMD_OPTION_MEMORY      = 0x00000020,
  CMD_OPTION_FANOUT      = 0x00000040,
  CMD_OPTION_VAL_HEX     = 0x00000080,
  CMD_OPTION_VAL_BIN     = 0x00000100,
  CMD_OPTION_CONNECTIONS = 0x00000200,
  CMD_OPTION_REG         = 0x00000400,
  CMD_OPTION_MAX
} EShellCmdOption;




class CsimCmdLineExpr;
class CsimCmdLineExprNum ;
class CsimCmdLineExprOper ;
class CsimCmdLineExprId ;
class CsimCmdLineExprIdSignal ;
class CsimCmdLineExprIdUnit ;
class CsimCmdLineExprIdClock ;
class CsimCmdLineExprTree;


typedef boost::shared_ptr<CsimCmdLineExpr>              RefCsimCmdLineExpr;
typedef boost::weak_ptr<CsimCmdLineExpr>                WeakRefCsimCmdLineExpr;
typedef std::vector<RefCsimCmdLineExpr>                 TVec_RefCsimCmdLineExpr;
typedef TVec_RefCsimCmdLineExpr::iterator               TVec_RefCsimCmdLineExpr_iterator;
typedef TVec_RefCsimCmdLineExpr::const_iterator         TVec_RefCsimCmdLineExpr_const_iterator;
typedef boost::shared_ptr<TVec_RefCsimCmdLineExpr>      RefTVec_RefCsimCmdLineExpr;


typedef boost::shared_ptr<CsimCmdLineExprNum>           RefCsimCmdLineExprNum;
typedef boost::weak_ptr<CsimCmdLineExprNum>             WeakRefCsimCmdLineExprNum;
typedef std::vector<CsimCmdLineExprNum>                 TVec_RefCsimCmdLineExprNum;
typedef TVec_RefCsimCmdLineExprNum::iterator            TVec_RefCsimCmdLineExprNum_iterator;
typedef TVec_RefCsimCmdLineExprNum::const_iterator      TVec_RefCsimCmdLineExprNum_const_iterator;
typedef boost::shared_ptr<TVec_RefCsimCmdLineExprNum>   RefTVec_RefCsimCmdLineExprNum;



typedef boost::shared_ptr<CsimCmdLineExprOper>          RefCsimCmdLineExprOper;
typedef boost::weak_ptr<CsimCmdLineExprOper>            WeakRefCsimCmdLineExprOper;
typedef std::vector<CsimCmdLineExprOper>                TVec_RefCsimCmdLineExprOper;
typedef TVec_RefCsimCmdLineExprOper::iterator           TVec_RefCsimCmdLineExprOper_iterator;
typedef TVec_RefCsimCmdLineExprOper::const_iterator     TVec_RefCsimCmdLineExprOper_const_iterator;
typedef boost::shared_ptr<TVec_RefCsimCmdLineExprOper>  RefTVec_RefCsimCmdLineExprOper;



typedef boost::shared_ptr<CsimCmdLineExprId>            RefCsimCmdLineExprId;
typedef boost::weak_ptr<CsimCmdLineExprId>              WeakRefCsimCmdLineExprId;
typedef std::vector<RefCsimCmdLineExprId>               TVec_RefCsimCmdLineExprId;
typedef TVec_RefCsimCmdLineExprId::iterator             TVec_RefCsimCmdLineExprId_iterator;
typedef TVec_RefCsimCmdLineExprId::const_iterator       TVec_RefCsimCmdLineExprId_const_iterator;
typedef boost::shared_ptr<TVec_RefCsimCmdLineExprId>    RefTVec_RefCsimCmdLineExprId;


typedef boost::shared_ptr<CsimCmdLineExprIdSignal>            RefCsimCmdLineExprIdSignal;
typedef boost::weak_ptr<CsimCmdLineExprIdSignal>              WeakRefCsimCmdLineExprIdSignal;
typedef std::vector<CsimCmdLineExprIdSignal>                  TVec_RefCsimCmdLineExprIdSignal;
typedef TVec_RefCsimCmdLineExprIdSignal::iterator             TVec_RefCsimCmdLineExprIdSignal_iterator;
typedef TVec_RefCsimCmdLineExprIdSignal::const_iterator       TVec_RefCsimCmdLineExprIdSignal_const_iterator;
typedef boost::shared_ptr<TVec_RefCsimCmdLineExprIdSignal>    RefTVec_RefCsimCmdLineExprIdSignal;


typedef boost::shared_ptr<CsimCmdLineExprIdUnit>            RefCsimCmdLineExprIdUnit;
typedef boost::weak_ptr<CsimCmdLineExprIdUnit>              WeakRefCsimCmdLineExprIdUnit;
typedef std::vector<CsimCmdLineExprIdUnit>                  TVec_RefCsimCmdLineExprIdUnit;
typedef TVec_RefCsimCmdLineExprIdUnit::iterator             TVec_RefCsimCmdLineExprIdUnit_iterator;
typedef TVec_RefCsimCmdLineExprIdUnit::const_iterator       TVec_RefCsimCmdLineExprIdUnit_const_iterator;
typedef boost::shared_ptr<TVec_RefCsimCmdLineExprIdUnit>    RefTVec_RefCsimCmdLineExprIdUnit;


typedef boost::shared_ptr<CsimCmdLineExprIdClock>            RefCsimCmdLineExprIdClock;
typedef boost::weak_ptr<CsimCmdLineExprIdClock>              WeakRefCsimCmdLineExprIdClock;
typedef std::vector<CsimCmdLineExprIdClock>                  TVec_RefCsimCmdLineExprIdClock;
typedef TVec_RefCsimCmdLineExprIdClock::iterator             TVec_RefCsimCmdLineExprIdClock_iterator;
typedef TVec_RefCsimCmdLineExprIdClock::const_iterator       TVec_RefCsimCmdLineExprIdClock_const_iterator;
typedef boost::shared_ptr<TVec_RefCsimCmdLineExprIdClock>    RefTVec_RefCsimCmdLineExprIdClock;


typedef boost::shared_ptr<CsimCmdLineExprTree>            RefCsimCmdLineExprTree;
typedef boost::weak_ptr<CsimCmdLineExprTree>              WeakRefCsimCmdLineExprTree;
typedef std::vector<CsimCmdLineExprTree>                  TVec_RefCsimCmdLineExprTree;
typedef TVec_RefCsimCmdLineExprTree::iterator             TVec_RefCsimCmdLineExprTree_iterator;
typedef TVec_RefCsimCmdLineExprTree::const_iterator       TVec_RefCsimCmdLineExprTree_const_iterator;
typedef boost::shared_ptr<TVec_RefCsimCmdLineExprTree>    RefTVec_RefCsimCmdLineExprTree;


}


#endif // INC_GUARD_CSIM_CMD_LINE_TYPE_DEFS_H

//END OF FILE
