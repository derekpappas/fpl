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

#ifndef INC_GUARD_CSLOm_DECLs_h
#define INC_GUARD_CSLOm_DECLs_h

#include "Base.h"
#include "../support/CommonSupport.h"
#include "VeriNum.h"
#include <map>
#include <vector>

namespace NSCSLOmVisitor {
class CVisitor;
}

namespace NSCSLOm {

// ********************************************************************************
// enum typedefs
// ********************************************************************************
/**
 * Every class in CSLOM has a raw type that identifies the class type at runtime.
 * This information is beeing held in CSLOmBase, the base class of all CSLOm classes.
 * You can think of this as a RTTI by hand used to identify a class type without
 * actually using RTTI. This type is a enum constant defined in this enumeration.
 * The type granularity chosen is not the finest one, that is for example, all
 * CSLOmStmt subclasses identify themselves as of TYPE_STMT. Finer granularity
 * is achieved by further looking up stmt type that is a enum constant defined
 * in another enumeration inside CSLOmStmt (NSCSLOm::CSLOmStmt::EStmtType).
 *
 * @see CSLOmBase::getType()
 */

typedef enum _ECSLOmSignalAccessType {
  SAT_UNDEFINED,
  SAT_RD,
  SAT_WR,
  SAT_PING,
  SAT_MAX
} ECSLOmSignalAccessType;

typedef enum _EMemoryMapType {
  MM_UNDEFINED           = -1,
  MM_FLAT                = 0,
  MM_VIRTUAL_W_BASE_ADDR = 1,
  MM_VIRTUAL_W_PAGE_NO   = 2,
  MM_HIERARCHICAL        = 3,
  MM_MAX                 = 4
} EMemoryMapType;

typedef enum _ECSLOmEnumType {
  ENUM_TYPE_ACCESS,
  ENUM_TYPE_ATTR,
  ENUM_TYPE_TYPE,
  ENUM_TYPE_BASE,
  ENUM_TYPE_VSD_RADIX,
  ENUM_TYPE_VSD_EDGE_TYPE
} ECSLOmEnumType;

typedef enum _EIncludeFileType {
  FILE_VERILOG,
  FILE_CPLUSPLUS
} EIncludeFileType;

typedef enum _ECSLOmType {
  TYPE_ALL_TYPES,               //0
  TYPE_ALL_TOP_LEVELS,          //1
  TYPE_ALL_SCOPE_HOLDERS,       //2
  TYPE_ALL_SIGNALS,             //3
  TYPE_ALL_FIELDS,              //4
  TYPE_ALL_ISA,                 //5
  TYPE_ALL_INTERFACES,          //6
  TYPE_ALL_PORTS,               //7
  TYPE_ALL_GROUPS,              //8
  TYPE_ALL_IDS,                 //9
  TYPE_ALL_SIMPLE_BR,           //10
  TYPE_ALL_VERIF_COMPS,         //11
  TYPE_ALL_TBS,                 //12
  
  TYPE_DESIGN,                  //13
  TYPE_INCLUDE,                 //14
  TYPE_ID_SIMPLE,               //15
  TYPE_ID_SCOPE_DIRECT,         //16
  TYPE_ID_SCOPE_INDIRECT,       //17
  TYPE_DECL_UNIT,               //18
  TYPE_DECL_TESTBENCH,          //19
  TYPE_CONNECTABLE,             //20
  TYPE_INST_UNIT,               //21
  TYPE_BIT_RANGE,               //22
  TYPE_EXPR,                    //23
  TYPE_LIST_EXPR,               //24
  TYPE_UNIT_INSTANTIATION,      //25
  TYPE_LIST,                    //26
  TYPE_PARAMETER,               //27
  //TYPE_PARAMETER_OVERRIDE,      //28
  TYPE_COMMAND,                 //29
  TYPE_ADDRESS_RANGE,           //30
  TYPE_MEMORY_MAP_LOCATION,     //31
  TYPE_MEMORY_MAP_PAGE,         //32
  TYPE_MEMORY_MAP_PAGE_INST,    //33
  TYPE_MEMORY_MAP,              //34
  TYPE_VECTOR,                  //35
  TYPE_ENUM,                    //37
  TYPE_ISA_ELEMENT,             //38
  TYPE_CONTAINER,               //39
  TYPE_MUX,                     //40
  TYPE_STMT,                    //41
  TYPE_UNIT_INFO                //42

} ECSLOmType;

/**
 * Holds enum constants for signal attr
 */
typedef enum _ECSLOmSignalAttr {
  ATTR_UNDEFINED,
  ATTR_EN,
  ATTR_STALL,
  ATTR_PE,
  ATTR_PS,
  ATTR_MS,
  ATTR_DEC,
  ATTR_CLK,
  ATTR_RST,
  ATTR_WR_EN,
  ATTR_MAX
} ECSLOmSignalAttr;

/**
 * Holds enum constants for function names.
 */
typedef enum _ECSLOmFuncName{ 
  GET_ACCESS_RIGHTS_ENUM,
  GET_ADDR_INCREMENT,
  GET_ALIGMENT,
  GET_ASM_MNEMONIC,
  GET_ATTR,
  GET_ATTRIBUTES,
  GET_BITRANGE,
  GET_DATA_WORD_WIDTH,
  GET_DEPTH,
  GET_DIM_BITRANGE,
  GET_DIM_LOWER_INDEX,
  GET_DIM_OFFSET,
  GET_DIM_UPPER_INDEX,
  GET_DIM_WIDTH,
  GET_ENDIANESS,
  GET_ENUM,
  GET_ENUM_ITEM,
  GET_FILENAME,
  GET_ID,
  GET_INTERFACE,
  GET_LOWER_INDEX,
  GET_MAX_ERROR_COUNT,
  GET_MAX_NUM_STATES,
  GET_MAX_NUM_VETORS,
  GET_NAME,
  GET_NEXT_ADDRESS,
  GET_NUMBER_OF_DIMENSIONS,
  GET_OFFSET,
  GET_REVERSED_INTERFACE,
  GET_SIGNAL_PREFIX,
  GET_SIGNAL_PREFIX_LOCAL,
  GET_SIGNAL_VALUE,
  GET_SIMULATION_TIMEOUT_COUNT,
  GET_SYMBOL_LENGTH,
  GET_TYPE,
  GET_UNDEFINED,
  GET_UNIT_PREFIX,
  GET_UPPER_INDEX,
  GET_VALUE,
  GET_WIDTH,
  GET_RADIX
} ECSLOmFuncName;

/**
 * Holds enum constants for port types.
 */
typedef enum _ECSLOmPortDirection {
  DIR_UNDEFINED,
  INOUT,
  INPUT,
  OUTPUT,
  DIR_MAX
} ECSLOmPortDirection;


typedef enum _EVerilogType {
  VERILOG_TYPE_UD, 
  v1995, 
  v2001,
  VERILOG_TYPE_MAX
} EVerilogType;



typedef enum _ECSLOmSignalType {
  SIGNAL_UNDEFINED,
  SIGNAL_TRIREG,      
  SIGNAL_TRI,         
  SIGNAL_WIRE,        
  SIGNAL_WOR,         
  SIGNAL_WAND,        
  SIGNAL_TRIOR,       
  SIGNAL_TRI0,        
  SIGNAL_TRI1,        
  SIGNAL_TRIAND,      
  SIGNAL_SUPPLY_0,    
  SIGNAL_SUPPLY_1,    
  SIGNAL_REG,         
  SIGNAL_VAR_INTEGER, 
  SIGNAL_VAR_REAL,    
  SIGNAL_VAR_REALTIME,
  SIGNAL_VAR_TIME,    
  SIGNAL_MAX
} ECSLOmSignalType;

typedef enum _ERegPortNames {
  REG_PORTN_CLOCK                ,
  REG_PORTN_RESET                ,
  REG_PORTN_ENABLE               ,
  REG_PORTN_REG_IN               ,
  REG_PORTN_REG_OUT              ,
  REG_PORTN_REG_NEG_OUT          ,
  REG_PORTN_SET                  ,
  REG_PORTN_INIT                 ,
  REG_PORTN_CLEAR                ,
  REG_PORTN_LOAD                 ,
  REG_PORTN_LOAD_EN
}ERegPortNames;

typedef enum _EFifoPortNames {
  FIFO_PN_UNDEFINED           ,
  FIFO_PN_PUSH                ,
  FIFO_PN_POP                 ,
  FIFO_PN_FULL                ,
  FIFO_PN_EMPTY               ,
  FIFO_PN_DATA_OUT            ,
  FIFO_PN_DATA_IN             ,
  FIFO_PN_SYNCH_RESET         ,
  FIFO_PN_CLOCK               ,
  FIFO_PN_VALID  = 100        ,
  FIFO_PN_WR_CLOCK            ,
  FIFO_PN_RD_CLOCK            ,
  FIFO_PN_ASYNCH_RESET        ,
  FIFO_PN_PUSHBACK            ,
  FIFO_PN_PROGRAMMABLE_DEPTH  ,
  FIFO_PN_PRIORITY_SELECT     ,
  FIFO_PN_PRIORITY_BYPASS     ,
  FIFO_PN_STALL               ,
  FIFO_PN_STALL_RD_SIDE       ,
  FIFO_PN_STALL_WR_SIDE       ,
  FIFO_PN_SRAM_RD_DATA        ,
  FIFO_PN_SRAM_RD_EN          ,
  FIFO_PN_SRAM_RD_ADDR        ,
  FIFO_PN_SRAM_WR_DATA        ,
  FIFO_PN_SRAM_WR_EN          ,
  FIFO_PN_SRAM_WR_ADDR        ,
  FIFO_PN_WR_RELEASE          ,
  FIFO_PN_ALMOST_EMPTY        ,
  FIFO_PN_ALMOST_FULL         ,
  FIFO_PN_WR_ADDRESS          ,
  FIFO_PN_RD_ADDRESS          ,
  FIFO_PN_CREDIT              ,
  FIFO_PN_RD_CREDIT           ,
  FIFO_PN_WR_CREDIT           ,
  FIFO_PN_OVERFLOW            ,
  FIFO_PN_UNDERFLOW           ,
  FIFO_PN_MAX
} EFifoPortNames;


typedef enum _ERFPortNames {
  RF_PN_UNDEFINED  ,
  RF_PN_RESET      ,
  RF_PN_VALID      ,
  RF_PN_CLOCK      ,
  RF_PN_WR_ADDR    ,
  RF_PN_RD_ADDR    ,
  RF_PN_RD_ADDR_S  ,
  RF_PN_DATA_IN    ,
  RF_PN_DATA_OUT   ,
  RF_PN_DATA_OUT_S ,
  RF_PN_WR_EN      ,
  RF_PN_RD_EN      ,
  RF_PN_RD_EN_S    ,
  RF_PN_CLEAR      ,
  RF_PN_MAX
} ERFPortNames;

typedef enum _ERPortNames {
  REG_PN_CLOCK      ,
  REG_PN_RESET      ,
  REG_PN_SET        ,
  REG_PN_CLR        ,
  REG_PN_EN         ,
  REG_PN_IN         ,
  REG_PN_SERIAL_IN  ,
  REG_PN_OUT        ,
  REG_PN_NEG_OUT    ,
  REG_PN_SERIAL_OUT ,
  REG_PN_INC        ,
  REG_PN_DEC        ,
  REG_PN_INIT       ,
  REG_PN_RD_EN      ,
  REG_PN_WR_EN
} ERPortNames;

//used in walker and cmd for custom port naming(fifo and register file)
//<added by MP>
typedef enum _EPortNames{
      //common
      PN_UNDEFINED      =0,
      PN_RESET          =1,
      PN_CLOCK          =2,
      PN_DATA_IN        =3,
      PN_DATA_OUT       =4,
      PN_VALID          =5,
      //FIFO
      PN_WR_CLOCK       =6,
      PN_RD_CLOCK       =7,
      PN_PUSH           =8,
      PN_POP            =9,
      PN_FULL           =10,
      PN_EMPTY          =11,
      //Register File
      PN_RD_ADDR        =12,
      PN_WR_ADDR        =13,
      PN_RD_EN          =14,
      PN_WR_EN          =15

    }EPortNames;

//</added by MP>

//< added by AB>
typedef enum _EAccessCategory {
  ACC_CAT_UNDEFINED   = -1,
  ACC_CAT_HARDWARE    = 0,
  ACC_CAT_SOFTWARE    = 2,
  ACC_CAT_TEST        = 4,
  ACC_CAT_APPLICATION = 6,
  ACC_CAT_DRIVER      = 8
} EAccessCategory;

typedef enum _EAccessRights {
  ACC_NONE         = 0x0,
  ACC_R            = 0x1,
  ACC_W            = 0x2,
  ACC_RW           = 0x3
} EAccessRights;

typedef enum _EAccesibility {
  ACCESS_UNDEFINED = 0x00000000,
  ACCESS_RESERVED  = 0x00000001,
  ACCESS_ILLEGAL   = 0x00000002,
  ACCESS_MAX       = 0x00000004
} EAccesibility;

typedef enum _EFifoChildrenTypes {
  FIFO_CHILD_UNDEFINED,
  FIFO_CHILD_LOW_WATERMARK,
  FIFO_CHILD_HIGH_WATERMARK,
  FIFO_CHILD_DEPTH,
  FIFO_CHILD_WIDTH,
  FIFO_CHILD_DEPTH_EXTEND,
  FIFO_CHILD_WIDTH_EXTEND,
  FIFO_CHILD_WR_HOLD,
  FIFO_CHILD_PARALLEL_OUTPUT,
  FIFO_CHILD_PARALLEL_INPUT,
  FIFO_CHILD_RD_WORDS_FIRST,
  FIFO_CHILD_RD_WORDS_SECOND,
  FIFO_CHILD_WR_WORDS_FIRST,
  FIFO_CHILD_WR_WORDS_SECOND,
  FIFO_CHILD_FLOW_THROUGH,
  FIFO_CHILD_PROGRAMMABLE_DEPTH,
  FIFO_CHILD_ALMOST_EMPTY,
  FIFO_CHILD_ALMOST_FULL,
  FIFO_CHILD_MAX
} EFifoChildrenTypes;

typedef enum _EStateDataChildType {
  SD_CHILDTYPE_UNDEF,
  SD_CHILDTYPE_DUT_MEM_INIT,
  SD_CHILDTYPE_ID,
  SD_CHILDTYPE_MAX_ERR_COUNT,
  SD_CHILDTYPE_MAX_NUM_ST,
  SD_CHILDTYPE_MAX_MISMATCH,
      
  SD_CHILDTYPE_MAX
} EStateDataChildType;


typedef enum _ERFChildrenTypes {
  RF_CHILDTYPE_UNDEF,
  RF_CHILDTYPE_WIDTH,
  RF_CHILDTYPE_DEPTH,
  RF_CHILDTYPE_FIELD_FIELD,
  RF_CHILDTYPE_FIELD_EXPR,
  RF_CHILDTYPE_EXTERNAL_EXPR,
  RF_CHILDTYPE_EXTERNAL_PORT,
  RF_CHILDTYPE_CONSTVAL,
  RF_CHILTYPE_MAX
} ERFChildrenTypes;

//</added by AB>

typedef enum _ERegDeclAttr {
      REG_ATTR_UNDEF      =-1,
      REG_ATTR_READ        =0,
      REG_ATTR_WRITE       =1,
      REG_ATTR_SHADOW      =2,
      REG_ATTR_READ_WRITE  =3,
      REG_ATTR_MAX  =4
} ERegDeclAttr;


class CSLOmBase;
class CSLOmInclude;
class CSLOmIdentifier;
class CSLOmScope;
class CSLOmDesign;
class CSLOmExpr;
class CSLOmListExpr;
class CSLOmString;
class CSLOmExprLink;
class CSLOmExprOp;
class CSLOmExprConcat;
class CSLOmExprMultiConcat;
class CSLOmUnitDecl;
class CSLOmUnitInfo;
class CSLOmUnitReplica;
class CSLOmMemoryInfo;
class CSLOmFifoInfo;
class CSLOmTestbenchInfo;
class CSLOmStateDataInfo;
class CSLOmRegisterFileInfo;
class CSLOmRegisterInfo;
class CSLOmParameter;
//class CSLOmParameterOverride;
class CSLOmUnitInstance;
class CSLOmEvalRes; //See CSLOM_EvalRes.h CSLOM_EvalRes.cpp
class CSLOmGroup;
class CSLOmGroupSignal;
class CSLOmConnectable;
class CSLOmSignal;
//class CSLOmBitRange;

class CVeriNum;

class CSLOmBaseRange;
class CSLOmSimpleBitRange;
class CSLOmMultiDimBitRange;
class CSLOmNumber;
class CSLOmNum32;
//added by eugennc
class CSLOmVeriNum;
//----------------
class CSLOmInterface;
class CSLOmUnitInstantiation;
class CSLOmPortDecl;
class CSLOmList;
class CSLOmExprHybridOrFuncCall;
class CSLOmExprFuncSignature;
class CSLOmSetCommand; //See CSLOM_cdm_eval.h, CSLOM_cdm_eval.cpp
class CSLOmScopeBlock;
class CSLOmVector;
class CSLOmAddressRange;
class CSLOmMemoryMapLocation;
class CSLOmMemoryMapPage;
class CSLOmMemoryMapPageInstance;
class CSLOmMemoryMap;
class CSLOmEnum;
class CSLOmContainer;
class CSLOmField;
class CSLOmStmt;
class CSLOmStmtAssign;
class CSLOmMux;
class CSLOmIsaField;
class CSLOmIsaElement;
//added by Tb
class CSLOmVerifCompInfo;
class CSLOmStateDataInfo;
class CSLOmVectorInfo;
class CSLOmTBInfo;

class CSLOmRegDeclInfo;

class CSLOmVerifComp;
class CSLOmStateData;

// ********************************************************************************
// Re Count typedefs - PART 1
// ********************************************************************************
typedef boost::shared_ptr<CSLOmBase>                 RefCSLOmBase;
typedef boost::shared_ptr<CSLOmInclude>              RefCSLOmInclude;
typedef boost::shared_ptr<CSLOmIdentifier>           RefCSLOmIdentifier;
typedef boost::shared_ptr<CSLOmScope>                RefCSLOmScope;
typedef boost::shared_ptr<CSLOmDesign>               RefCSLOmDesign;
typedef boost::shared_ptr<CSLOmExpr>                 RefCSLOmExpr;
typedef boost::shared_ptr<CSLOmListExpr>             RefCSLOmListExpr;
typedef boost::shared_ptr<CSLOmString>               RefCSLOmString;
typedef boost::shared_ptr<CSLOmExprLink>             RefCSLOmExprLink;
typedef boost::shared_ptr<CSLOmExprOp>               RefCSLOmExprOp;
typedef boost::shared_ptr<CSLOmExprConcat>           RefCSLOmExprConcat;
typedef boost::shared_ptr<CSLOmExprMultiConcat>      RefCSLOmExprMultiConcat;
typedef boost::shared_ptr<CSLOmUnitDecl>             RefCSLOmUnitDecl;
typedef boost::weak_ptr<CSLOmUnitDecl>               WeakCSLOmUnitDecl;
typedef boost::shared_ptr<CSLOmUnitReplica>          RefCSLOmUnitReplica;
typedef boost::shared_ptr<CSLOmUnitInfo>             RefCSLOmUnitInfo;
typedef boost::shared_ptr<CSLOmMemoryInfo>           RefCSLOmMemoryInfo;
typedef boost::shared_ptr<CSLOmFifoInfo>             RefCSLOmFifoInfo;
typedef boost::shared_ptr<CSLOmTestbenchInfo>        RefCSLOmTestbenchInfo;
typedef boost::shared_ptr<CSLOmStateDataInfo>        RefCSLOmStateDataInfo;
typedef boost::shared_ptr<CSLOmRegisterFileInfo>     RefCSLOmRegisterFileInfo;
typedef boost::shared_ptr<CSLOmRegisterInfo>         RefCSLOmRegisterInfo;
typedef boost::shared_ptr<CSLOmParameter>            RefCSLOmParameter;
//typedef boost::shared_ptr<CSLOmParameterOverride>    RefCSLOmParameterOverride;
typedef boost::shared_ptr<CSLOmUnitInstance>         RefCSLOmUnitInstance;
typedef boost::weak_ptr<CSLOmUnitInstance>           WeakCSLOmUnitInstance;
typedef boost::shared_ptr<CSLOmGroup>                RefCSLOmGroup;
typedef boost::shared_ptr<CSLOmGroupSignal>          RefCSLOmGroupSignal;
typedef boost::shared_ptr<CSLOmEvalRes>              RefCSLOmEvalRes;
typedef boost::shared_ptr<CSLOmConnectable>          RefCSLOmConnectable;
typedef boost::weak_ptr<CSLOmConnectable>            WeakRefCSLOmConnectable;
typedef boost::shared_ptr<CSLOmSignal>               RefCSLOmSignal;
typedef boost::weak_ptr<CSLOmSignal>                 WeakRefCSLOmSignal;
typedef boost::shared_ptr<CSLOmNumber>               RefCSLOmNumber;
typedef boost::shared_ptr<CSLOmNum32>                RefCSLOmNum32;
//added by eugennc
typedef boost::shared_ptr<CSLOmVeriNum>              RefCSLOmVeriNum;
//----------------
//typedef boost::shared_ptr<CSLOmBitRange>             RefCSLOmBitRange;
typedef boost::shared_ptr<CSLOmBaseRange>            RefCSLOmBaseRange;
typedef boost::shared_ptr<CSLOmSimpleBitRange>       RefCSLOmSimpleBitRange;
typedef boost::shared_ptr<CSLOmMultiDimBitRange>     RefCSLOmMultiDimBitRange;
typedef boost::shared_ptr<CSLOmInterface>            RefCSLOmInterface;
typedef boost::shared_ptr<CVeriNum>                  RefCVeriNum;
typedef boost::shared_ptr<CSLOmUnitInstantiation>    RefCSLOmUnitInstantiation;
typedef boost::shared_ptr<CSLOmPortDecl>             RefCSLOmPortDecl;
typedef boost::shared_ptr<CSLOmList>                 RefCSLOmList;
typedef boost::shared_ptr<CSLOmListExpr>             RefCSLOmListExpr;
typedef boost::shared_ptr<CSLOmExprHybridOrFuncCall> RefCSLOmExprHybridOrFuncCall;
typedef boost::shared_ptr<CSLOmExprFuncSignature>    RefCSLOmExprFuncSignature;
typedef boost::shared_ptr<CSLOmSetCommand>           RefCSLOmSetCommand;
typedef boost::shared_ptr<CSLOmVector>               RefCSLOmVector;
typedef boost::shared_ptr<CSLOmAddressRange>         RefCSLOmAddressRange;
typedef boost::shared_ptr<CSLOmMemoryMapLocation>    RefCSLOmMemoryMapLocation;
typedef boost::shared_ptr<CSLOmMemoryMapPage>        RefCSLOmMemoryMapPage;
typedef boost::shared_ptr<CSLOmMemoryMapPageInstance>RefCSLOmMemoryMapPageInstance;
typedef boost::shared_ptr<CSLOmMemoryMap>            RefCSLOmMemoryMap;
typedef boost::shared_ptr<CSLOmEnum>                 RefCSLOmEnum;
typedef boost::shared_ptr<CSLOmField>                RefCSLOmField;
typedef boost::shared_ptr<CSLOmContainer>            RefCSLOmContainer;
typedef boost::shared_ptr<CSLOmStmt>                 RefCSLOmStmt;
typedef boost::shared_ptr<CSLOmStmtAssign>           RefCSLOmStmtAssign;
typedef boost::shared_ptr<CSLOmMux>                  RefCSLOmMux;
typedef boost::shared_ptr<CSLOmIsaField>             RefCSLOmIsaField;
typedef boost::shared_ptr<CSLOmIsaElement>           RefCSLOmIsaElement;
typedef boost::weak_ptr<CSLOmIsaElement>             WeakRefCSLOmIsaElement;

//added by Tb
typedef boost::shared_ptr<CSLOmVerifCompInfo>        RefCSLOmVerifCompInfo;
typedef boost::shared_ptr<CSLOmStateDataInfo>        RefCSLOmStateDataInfo;
typedef boost::shared_ptr<CSLOmVectorInfo>           RefCSLOmVectorInfo;
typedef boost::shared_ptr<CSLOmTBInfo>               RefCSLOmTBInfo;

typedef boost::shared_ptr<CSLOmRegDeclInfo>          RefCSLOmRegDeclInfo;

/*to be removed*/
typedef boost::shared_ptr<CSLOmVerifComp>            RefCSLOmVerifComp;
typedef boost::shared_ptr<CSLOmStateData>            RefCSLOmStateData;
/*up to here to be removed*/

// ********************************************************************************
// container and interator types typedefs
// ********************************************************************************

typedef std::vector<boost::weak_ptr<CSLOmUnitInstance> > TVec_WeakCSLOmUnitInstance;  // vector of RefCSLOmUnitInstantion
typedef std::vector<boost::weak_ptr<CSLOmVerifCompInfo> > TVec_WeakCSLOmVerifCompInfo;  // vector of RefCSLOmUnitInstantion
typedef std::vector<boost::weak_ptr<CSLOmIsaElement> > TVec_WeakRefCSLOmIsaElement;  // vector of RefCSLOmUnitInstantion

typedef boost::shared_ptr<TVec_WeakCSLOmUnitInstance > RefTVec_WeakCSLOmUnitInstance ;  // vector of RefCSLOmUnitInstantion
typedef boost::shared_ptr<TVec_WeakCSLOmVerifCompInfo> RefTVec_WeakCSLOmVerifCompInfo;  // vector of RefCSLOmUnitInstantion
typedef boost::shared_ptr<TVec_WeakRefCSLOmIsaElement> RefTVec_WeakRefCSLOmIsaElement;  // vector of RefCSLOmUnitInstantion

typedef TVec_WeakCSLOmVerifCompInfo::const_iterator            TVec_WeakCSLOmVerifCompInfo_const_iter;

  // moved to support/Typedefs.h typedef std::vector<RefString>                 TVec_RefString;             // vector of RefString
typedef std::vector<RefCSLOmBase>              TVec_RefCSLOmBase;           // vector of RefCSLOmBase
typedef std::vector<RefCSLOmScope>             TVec_RefCSLOmScope;     // vector of RefCSLOmScope
typedef std::vector<RefCSLOmIdentifier>        TVec_RefCSLOmIdentifier;     // vector of RefCSLOmIdentifier
typedef std::vector<RefCSLOmExpr>              TVec_RefCSLOmExpr;     // vector of RefCSLOmExpr
typedef std::vector<RefCSLOmExprLink>          TVec_RefCSLOmExprLink;  // vector of RefCSLOmExprLink
typedef std::vector<RefCSLOmSignal>            TVec_RefCSLOmSignal;  // vector of RefCSLOmSignal
typedef std::vector<WeakRefCSLOmSignal>        TVec_WeakRefCSLOmSignal;  // vector of WeakRefCSLOmSignal
typedef std::vector<RefCSLOmGroupSignal>       TVec_RefCSLOmGroupSignal;  // vector of RefCSLOmGroupSignal
//typedef std::vector<RefCSLOmBitRange>          TVec_RefCSLOmBitRange;  // vector of RefCSLOmBitRange
typedef std::vector<RefCSLOmSimpleBitRange>    TVec_RefCSLOmSimpleBitRange;  // vector of RefCSLOmBitRange
typedef std::vector<RefCSLOmUnitInstance>      TVec_RefCSLOmUnitInstance;  // vector of RefCSLOmUnitInstance
typedef std::vector<RefCSLOmUnitDecl>          TVec_RefCSLOmUnitDecl;  // vector of RefCSLOmUnitInstance
typedef std::vector<RefCSLOmUnitReplica>       TVec_RefCSLOmUnitReplica; // vector of RefCSLOmUnitReplica
typedef std::vector<RefCSLOmUnitInstantiation> TVec_RefCSLOmUnitInstantiation;  // vector of RefCSLOmUnitInstantion
typedef std::vector<RefCSLOmPortDecl>          TVec_RefCSLOmPortDecl;  // vector of RefCSLOmPortDecl
typedef std::vector<RefCSLOmConnectable>       TVec_RefCSLOmConnectable;  // vector of RefCSLOmPortDecl
typedef std::vector<RefCSLOmExprFuncSignature> TVec_RefCSLOmExprFuncSignature;  // vector of RefCSLOmExprFuncSignature
typedef std::vector<RefCSLOmInterface>         TVec_RefCSLOmInterface; //vector of RefCSLOmInterface
typedef std::vector<RefCSLOmSetCommand>        TVec_RefCSLOmSetCommand; //vector of RefCSLOmSetCommand
typedef std::vector<RefCSLOmParameter>         TVec_RefCSLOmParameter;  //vector of RefCSLOmParameter
//typedef std::vector<RefCSLOmParameterOverride> TVec_RefCSLOmParameterOverride; //vector of the RefCSLOmParameterOverride
typedef std::vector<RefCSLOmVector>            TVec_RefCSLOmVector; //vector of the RefCSLOmVector
typedef std::vector<RefCSLOmAddressRange>      TVec_RefCSLOmAddressRange; //vector of RefCSLOmAddressRange
typedef std::vector<RefCSLOmMemoryMapLocation> TVec_RefCSLOmMemoryMapLocation; //vector of RefCSLOmMemoryMapLocation
typedef std::vector<RefCSLOmField>             TVec_RefCSLOmField;           //vector of RefCSLOmField
typedef std::vector<ERegDeclAttr>              TVec_ERegDeclAttr;           //vector of enumRegType

// ********************************************************************************
// class type functors
// ********************************************************************************
struct less_RefString {
    TBool operator() (const RefString& s1, const RefString& s2) const;
};

struct less_RefCSLOmNumber {
    TBool operator() (RefCSLOmNumber s1, RefCSLOmNumber s2) const;
};

struct less_RefCSLOmExprLink {
    TBool operator() (RefCSLOmExprLink s1, RefCSLOmExprLink s2) const;
};

struct less_RefCSLOmUnitInstance {
    TBool operator() (RefCSLOmUnitInstance s1, RefCSLOmUnitInstance s2) const;
};

struct less_RefCSLOmSignal {
    TBool operator() (RefCSLOmSignal s1, RefCSLOmSignal s2) const;
};

typedef std::pair<RefString, RefCSLOmIdentifier>         TPair_RefString_RefCSLOmIdentifier;
typedef std::pair<RefCSLOmExprLink, RefCSLOmExprLink>    TPair_RefCSLOmExprLink_RefCSLOmExprLink;
typedef std::pair<RefCSLOmField, RefCSLOmNumber>         TPair_RefCSLOmField_RefCSLOmNumber;
typedef std::pair<RefCSLOmAddressRange, RefCSLOmAddressRange>         TPair_RefCSLOmAddressRange_RefCSLOmAddressRange;

typedef std::map<RefString, RefCSLOmIdentifier, less_RefString>             TMap_RefString_RefCSLOmIdentifier;
typedef std::map<EFifoPortNames, RefString>                                 TMap_EFifoPortNames_RefString;
typedef std::map<EFifoPortNames, RefCSLOmPortDecl>                          TMap_EFifoPortNames_RefCSLOmPortDecl;
typedef std::map<ERFPortNames, RefString>                                   TMap_ERFPortNames_RefString;
typedef std::map<ERFPortNames, RefCSLOmPortDecl>                            TMap_ERFPortNames_RefCSLOmPortDecl;
typedef std::map<ERPortNames, RefCSLOmPortDecl>                             TMap_ERPortNames_RefCSLOmPortDecl;
typedef std::map<ERegPortNames, RefCSLOmPortDecl>                           TMap_ERegPortNames_RefCSLOmPortDecl;
typedef std::map<RefString, RefCSLOmExpr, less_RefString>                   TMap_RefString_RefCSLOmExpr;
typedef std::map<RefCSLOmExprLink, RefCSLOmExpr, less_RefCSLOmExprLink>     TMap_RefCSLOmExprLink_RefCSLOmExpr;
typedef std::map<RefString, RefCSLOmNumber, less_RefString>                 TMap_RefString_RefCSLOmNumber;
typedef std::map<TUInt, RefCSLOmMemoryMapLocation>                          TMap_TUInt_RefCSLOmMemoryMapLocation;
typedef std::map<RefCSLOmNumber,RefCSLOmNumber>                             TMap_RefCSLOmNumber_RefCSLOmNumber;
typedef std::multimap<RefString, RefCSLOmIdentifier, less_RefString>        TMultiMap_RefString_RefCSLOmIdentifier;
typedef std::map<EFifoChildrenTypes, TInt>                                  TMap_EFifoChildrenTypes_TInt;
typedef std::map<RefString, TInt, less_RefString>                           TMap_RefString_TInt;
typedef std::map<EStateDataChildType, TInt>                                 TMap_EStateDataChildType_TInt;
typedef std::map<ERFChildrenTypes, TInt>                                    TMap_ERFChildrenTypes_TInt;
typedef std::map<RefCSLOmUnitInstance, RefCSLOmBase, less_RefCSLOmUnitInstance> TMap_RefCSLOmUnitInstance_RefCSLOmBase;
typedef std::map<RefCSLOmSignal, ECSLOmPortDirection, less_RefCSLOmSignal> TMap_RefCSLOmSignal_ECSLOmPortDirection;

typedef TVec_RefCSLOmVector::const_iterator            TVec_RefCSLOmVector_const_iter;
  // DEP moved to support Typedefs.h typedef TVec_RefString::const_iterator                 TVec_RefString_const_iter;
typedef TVec_RefCSLOmBase::const_iterator              TVec_RefCSLOmBase_const_iter;
typedef TVec_RefCSLOmScope::const_iterator             TVec_RefCSLOmScope_const_iter;
typedef TVec_RefCSLOmIdentifier::const_iterator        TVec_RefCSLOmIdentifier_const_iter;
typedef TVec_RefCSLOmExpr::const_iterator              TVec_RefCSLOmExpr_const_iter;
typedef TVec_RefCSLOmExprLink::const_iterator          TVec_RefCSLOmExprLink_const_iter;
typedef TVec_RefCSLOmSignal::const_iterator            TVec_RefCSLOmSignal_const_iter;
typedef TVec_WeakRefCSLOmSignal::const_iterator        TVec_WeakRefCSLOmSignal_const_iter;
typedef TVec_RefCSLOmGroupSignal::const_iterator       TVec_RefCSLOmGroupSignal_const_iter;
typedef TVec_RefCSLOmUnitInstance::const_iterator      TVec_RefCSLOmUnitInstance_const_iter;
typedef TVec_RefCSLOmUnitDecl::const_iterator          TVec_RefCSLOmUnitDecl_const_iter;
typedef TVec_RefCSLOmUnitReplica::const_iterator       TVec_RefCSLOmUnitReplica_const_iter;
//typedef TVec_RefCSLOmBitRange::const_iterator          TVec_RefCSLOmBitRange_const_iter;
typedef TVec_RefCSLOmUnitInstantiation::const_iterator TVec_RefCSLOmUnitInstantiation_const_iter;
typedef TVec_RefCSLOmPortDecl::const_iterator          TVec_RefCSLOmPortDecl_const_iter;
typedef TVec_RefCSLOmConnectable::const_iterator       TVec_RefCSLOmConnectable_const_iter;
typedef TVec_RefCSLOmExprFuncSignature::const_iterator TVec_RefCSLOmExprFuncSignature_const_iter;
//typedef TVec_RefCSLOmParameterOverride::const_iterator TVec_RefCSLOmParameterOverride_const_iter;
typedef TVec_RefCSLOmParameter::const_iterator         TVec_RefCSLOmParameter_const_iter;
typedef TVec_RefCSLOmMemoryMapLocation::const_iterator TVec_RefCSLOmMemoryMapLocation_const_iter;
/* to be removed ? */typedef TVec_RefCSLOmAddressRange::const_iterator             TVec_RefCSLOmAddressRange_const_iter;
typedef TVec_RefCSLOmField::const_iterator             TVec_RefCSLOmField_const_iter;

typedef TMap_RefString_RefCSLOmIdentifier::const_iterator      TMap_RefString_RefCSLOmIdentifier_const_iter;
typedef TMap_RefString_RefCSLOmExpr::const_iterator            TMap_RefString_RefCSLOmExpr_const_iter;
typedef TMap_RefCSLOmExprLink_RefCSLOmExpr::const_iterator     TMap_RefCSLOmExprLink_RefCSLOmExpr_const_iter;
typedef TMap_RefString_RefCSLOmNumber::const_iterator          TMap_RefString_RefCSLOmNumber_const_iter;
typedef TMap_EFifoPortNames_RefCSLOmPortDecl::const_iterator   TMap_EFifoPortNames_RefCSLOmPortDecl_const_iter;
typedef TMap_EFifoPortNames_RefString::const_iterator          TMap_EFifoPortNames_RefString_const_iter;
typedef TMap_ERFPortNames_RefString::const_iterator            TMap_ERFPortNames_RefString_const_inter;
typedef TMap_ERFPortNames_RefCSLOmPortDecl::const_iterator     TMap_ERFPortNames_RefCSLOmPortDecl_const_inter;
typedef TMap_EFifoChildrenTypes_TInt::const_iterator           TMap_EFifoChildrenTypes_TInt_const_inter;
typedef TMap_EStateDataChildType_TInt::const_iterator          TMap_EStateDataChildType_TInt_const_iter;
typedef TMap_ERFChildrenTypes_TInt::const_iterator             TMap_ERFChildrenTypes_TInt_const_iter;
typedef TMap_ERegPortNames_RefCSLOmPortDecl::const_iterator    TMap_ERegPortNames_RefCSLOmPortDecl_const_iter; 
typedef TMap_RefCSLOmSignal_ECSLOmPortDirection::const_iterator TMap_RefCSLOmSisgnal_ECSLOmPortDirection_const_iter; 

/* to be removed ? */typedef TMap_RefCSLOmNumber_RefCSLOmNumber::const_iterator     TMap_RefCSLOmNumber_RefCSLOmNumber_const_iter;
/* to be removed ? */typedef TMap_TUInt_RefCSLOmMemoryMapLocation::const_iterator      TMap_TUInt_RefCSLOmMemoryMapLocation_const_iter;

typedef TMultiMap_RefString_RefCSLOmIdentifier::const_iterator TMultiMap_RefString_RefCSLOmIdentifier_const_iter;
typedef std::back_insert_iterator<TVec_RefCSLOmIdentifier>     TBackInsertIterator_TVec_RefCSLOmIdentifier;
typedef TVec_RefCSLOmInterface::iterator                       TVec_RefCSLOmInterface_iter;
typedef TVec_RefCSLOmSetCommand::iterator                      TVec_RefCSLOmSetCommand_iter;

// ********************************************************************************
// RefCount typedefs - PART 2
// ********************************************************************************
typedef boost::shared_ptr<TVec_RefCSLOmVector>            RefTVec_RefCSLOmVector;
//typedef boost::shared_ptr<TVec_RefString>                 RefTVec_RefString;
typedef boost::shared_ptr<TVec_RefCSLOmBase>              RefTVec_RefCSLOmBase;
typedef boost::shared_ptr<TVec_RefCSLOmScope>             RefTVec_RefCSLOmScope;
typedef boost::shared_ptr<TVec_RefCSLOmIdentifier>        RefTVec_RefCSLOmIdentifier;
typedef boost::shared_ptr<TVec_RefCSLOmExpr>              RefTVec_RefCSLOmExpr;
typedef boost::shared_ptr<TVec_RefCSLOmExprLink>          RefTVec_RefCSLOmExprLink;
typedef boost::shared_ptr<TVec_RefCSLOmSignal>            RefTVec_RefCSLOmSignal;
typedef boost::shared_ptr<TVec_WeakRefCSLOmSignal>        RefTVec_WeakRefCSLOmSignal;
//typedef boost::shared_ptr<TVec_RefCSLOmBitRange>          RefTVec_RefCSLOmBitRange;
typedef boost::shared_ptr<TVec_RefCSLOmSimpleBitRange>    RefTVec_RefCSLOmSimpleBitRange;
typedef boost::shared_ptr<TVec_RefCSLOmGroupSignal>       RefTVec_RefCSLOmGroupSignal;
typedef boost::shared_ptr<TVec_RefCSLOmUnitInstance>      RefTVec_RefCSLOmUnitInstance;
typedef boost::shared_ptr<TVec_RefCSLOmUnitDecl>          RefTVec_RefCSLOmUnitDecl;
typedef boost::shared_ptr<TVec_RefCSLOmUnitReplica>       RefTVec_RefCSLOmUnitReplica;
typedef boost::shared_ptr<TVec_RefCSLOmUnitInstantiation> RefTVec_RefCSLOmUnitInstantiation;
typedef boost::shared_ptr<TVec_RefCSLOmPortDecl>          RefTVec_RefCSLOmPortDecl;
typedef boost::shared_ptr<TVec_RefCSLOmConnectable>       RefTVec_RefCSLOmConnectable;
typedef boost::shared_ptr<TVec_RefCSLOmExprFuncSignature> RefTVec_RefCSLOmExprFuncSignature;
typedef boost::shared_ptr<TVec_RefCSLOmInterface>         RefTVec_RefCSLOmInterface;
typedef boost::shared_ptr<TVec_RefCSLOmSetCommand>        RefTVec_RefCSLOmSetCommand;
//typedef boost::shared_ptr<TVec_RefCSLOmParameterOverride> RefTVec_RefCSLOmParameterOverride;
typedef boost::shared_ptr<TVec_RefCSLOmParameter>         RefTVec_RefCSLOmParameter;
typedef boost::shared_ptr<TVec_RefCSLOmField>             RefTVec_RefCSLOmField;
typedef boost::shared_ptr<TVec_RefCSLOmAddressRange>      RefTVec_RefCSLOmAddressRange;
typedef boost::shared_ptr<TVec_RefCSLOmMemoryMapLocation> RefTVec_RefCSLOmMemoryMapLocation;
typedef boost::shared_ptr<TVec_ERegDeclAttr>              RefTVec_ERegDeclAttr;

typedef boost::shared_ptr<TMap_RefString_RefCSLOmIdentifier>      RefTMap_RefString_RefCSLOmIdentifier;
typedef boost::shared_ptr<TMap_EFifoPortNames_RefCSLOmPortDecl>   RefTMap_EFifoPortNames_RefCSLOmPortDecl;
typedef boost::shared_ptr<TMap_EFifoPortNames_RefString>          RefTMap_EFifoPortNames_RefString;
typedef boost::shared_ptr<TMap_ERFPortNames_RefString>            RefTMap_ERFPortNames_RefString;
typedef boost::shared_ptr<TMap_ERFPortNames_RefCSLOmPortDecl>     RefTMap_ERFPortNames_RefCSLOmPortDecl;
typedef boost::shared_ptr<TMap_ERPortNames_RefCSLOmPortDecl>      RefTMap_ERPortNames_RefCSLOmPortDecl;
typedef boost::shared_ptr<TMap_ERegPortNames_RefCSLOmPortDecl>    RefTMap_ERegPortNames_RefCSLOmPortDecl;
typedef boost::shared_ptr<TMap_RefString_RefCSLOmExpr>            RefTMap_RefString_RefCSLOmExpr;
typedef boost::shared_ptr<TMap_RefCSLOmExprLink_RefCSLOmExpr>     RefTMap_RefCSLOmExprLink_RefCSLOmExpr;
typedef boost::shared_ptr<TMap_RefString_RefCSLOmNumber>          RefTMap_RefString_RefCSLOmNumber;
typedef boost::shared_ptr<TMap_EFifoChildrenTypes_TInt>           RefTMap_EFifoChildrenTypes_TInt;
typedef boost::shared_ptr<TMap_RefString_TInt>                    RefTMap_RefString_TInt;
typedef boost::shared_ptr<TMap_EStateDataChildType_TInt>          RefTMap_EStateDataChildType_TInt;
typedef boost::shared_ptr<TMap_ERFChildrenTypes_TInt>             RefTMap_ERFChildrenTypes_TInt;
typedef boost::shared_ptr<TMap_RefCSLOmUnitInstance_RefCSLOmBase> RefTMap_RefCSLOmUnitInstance_RefCSLOmBase;
typedef boost::shared_ptr<TMap_RefCSLOmSignal_ECSLOmPortDirection> RefTMap_RefCSLOmSignal_ECSLOmPortDirection;

typedef boost::shared_ptr<TMultiMap_RefString_RefCSLOmIdentifier> RefTMultiMap_RefString_RefCSLOmIdentifier;
/* to remove */ typedef boost::shared_ptr<TMap_TUInt_RefCSLOmMemoryMapLocation>   RefTMap_TUInt_RefCSLOmMemoryMapLocation;
/* to remove */ typedef boost::shared_ptr<TMap_RefCSLOmNumber_RefCSLOmNumber>     RefTMap_RefCSLOmNumber_RefCSLOmNumber;
}

#endif
