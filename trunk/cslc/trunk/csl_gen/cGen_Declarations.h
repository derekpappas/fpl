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

#ifndef _CGEN_DECLARATIONS_H_
#define _CGEN_DECLARATIONS_H_

#include <vector>
#include <map>

using namespace std;

//-----------------------------------enums-----------------------------------//
typedef enum _EError {
  ERR_NONE,
  ERR_EXISTS
} EError;

typedef enum _ETestGen {
  TG_DECLARATION,
  TG_INSTANCE_DECLARATION,
  TG_COMMAND_CALL,
  TG_INSTANCE_COMMAND_CALL
} ETestGen;

typedef enum _ECSLChapter {
  CPT_ALL,
  CPT_FIFO,
  CPT_INTERCON,
  CPT_ISA,
  CPT_LANG,
  CPT_MEM,
  CPT_MEM_MAP,
  CPT_REG,
  CPT_REG_FILE,
  CPT_TESTB,
  CPT_VERIFC
} ECSLChapter;

typedef enum _ECSLClass {
  CSL_BITRANGE,
  CSL_ENUM,
  CSL_ENUM_ITEM,
  CSL_EVENT,
  CSL_FIELD,
  CSL_FIFO,
  CSL_INTERFACE,
  CSL_ISA_FIELD,
  CSL_MEMORY,
  CSL_MEMORY_MAP,
  CSL_MEMORY_MAP_PAGE,
  CSL_MULTI_DIM_BITRANGE,
  CSL_PORT,
  CSL_REGISTER,
  CSL_REGISTER_FILE,
  CSL_SIGNAL,
  CSL_SIGNAL_GROUP,
  CSL_STATE_DATA,
  CSL_TESTBENCH,
  CSL_UNIT,
  CSL_VECTOR
} ECSLClass;

typedef enum _ECSLCmdType {
  CMD_ADD,
  CMD_ADD_ADDRESS_RANGE,
  CMD_ADD_ALLOWED_RANGE,
  CMD_ADD_EQUATION,
  CMD_ADD_LOGIC,
  CMD_ADD_RESERVED_ADDRESS_RANGE,
  CMD_ADD_TO_MEMORY_MAP,
  CMD_AUTO_GEN_MEMORY_MAP,
  CMD_CONCAT,
  CMD_CONNECT,
  CMD_CREATE_RTL_MODULE,
  CMD_DIRECTIVE,
  CMD_EXCLUSION_LIST,
  CMD_GEN_DECODER,
  CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS,
  CMD_GET_ADDRESS_INCREMENT,
  CMD_GET_ALIGNMENT,
  CMD_GET_ATTR,
  CMD_GET_ATTRIBUTES,
  CMD_GET_BITRANGE,
  CMD_GET_CLOCK_NAME,
  CMD_GET_CNT_DIR_SIGNAL,
  CMD_GET_DATA_WORD_WIDTH,
  CMD_GET_DEPTH,
  CMD_GET_DIM_BITRANGE,
  CMD_GET_DIM_LOWER,
  CMD_GET_DIM_OFFSET,
  CMD_GET_DIM_UPPER,
  CMD_GET_DIM_WIDTH,
  CMD_GET_EMPTY_NAME,
  CMD_GET_ENDIANESS,
  CMD_GET_ENUM,
  CMD_GET_ENUM_ITEM,
  CMD_GET_FULL_NAME,
  CMD_GET_LOWER,
  CMD_GET_LOWER_BOUND,
  CMD_GET_LOWER_INDEX,
  CMD_GET_MNEMONIC,
  CMD_GET_NEXT_ADDRESS,
  CMD_GET_OFFSET,
  CMD_GET_OUTPUT_FILENAME,
  CMD_GET_POP_NAME,
  CMD_GET_PREFIX,
  CMD_GET_PUSH_NAME,
  CMD_GET_RD_ADDR_NAME,
  CMD_GET_RD_CLOCK_NAME,
  CMD_GET_RD_DATA_NAME,
  CMD_GET_RD_EN_NAME,
  CMD_GET_RESET_NAME,
  CMD_GET_RADIX,
  CMD_GET_SIGNAL_PREFIX,
  CMD_GET_SIGNAL_PREFIX_LOCAL,
  CMD_GET_SIMULATION_TIMEOUT_COUNT,
  CMD_GET_SUFFIX,
  CMD_GET_SYMBOL_LENGTH,
  CMD_GET_TYPE,
  CMD_GET_UNIT_PREFIX,
  CMD_GET_UPPER,
  CMD_GET_UPPER_BOUND,
  CMD_GET_UPPER_INDEX,
  CMD_GET_VALID_NAME,
  CMD_GET_VALUE,
  CMD_GET_VC_CAPTURE_EDGE_TYPE,
  CMD_GET_VC_CLOCK,
  CMD_GET_VC_COMPARE_TRIGGER,
  CMD_GET_VC_CPP_RD_NAME,
  CMD_GET_VC_CPP_WR_NAME,
  CMD_GET_VC_END_GENERATION_TRIGGER,
  CMD_GET_VC_HEADER_COMMENT,
  CMD_GET_VC_ID,
  CMD_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS,
  CMD_GET_VC_MAX_NUMBER_OF_MISMATCHES,
  CMD_GET_VC_MAX_NUM_STATES,
  CMD_GET_VC_MODULE,
  CMD_GET_VC_NAME,
  CMD_GET_VC_RESET,
  CMD_GET_VC_STALL,
  CMD_GET_VC_START_GENERATION_TRIGGER,
  CMD_GET_VC_TIMEOUT,
  CMD_GET_WIDTH,
  CMD_GET_WR_ADDR_NAME,
  CMD_GET_WR_CLOCK_NAME,
  CMD_GET_WR_DATA_NAME,
  CMD_GET_WR_EN_NAME,
  CMD_INCLUDE_ONLY,
  CMD_MERGE,
  CMD_PRINT,
  CMD_REVERSE,
  CMD_SET_ACCESS_RIGHTS,
  CMD_SET_ACCESS_RIGHTS_ENUM,
  CMD_SET_ADDRESS_INCREMENT,
  CMD_SET_ALIGNMENT,
  CMD_SET_ATTR,
  CMD_SET_ATTRIBUTES,
  CMD_SET_BITRANGE,
  CMD_SET_CLK_DIVIDER,
  CMD_SET_CLK_MULTIPLIER,
  CMD_SET_CLOCK_NAME,
  CMD_SET_CONST_VALUE,
  CMD_SET_DATA_WORD_WIDTH,
  CMD_SET_DECODER_NAME,
  CMD_SET_DECODER_OUT_NAME_PREFIX,
  CMD_SET_DECODER_OUT_NAME_SUFFIX,
  CMD_SET_DEFAULT_VALUE,
  CMD_SET_DEPTH,
  CMD_SET_DIM_BITRANGE,
  CMD_SET_DIM_OFFSET,
  CMD_SET_DIM_RANGE,
  CMD_SET_DIM_WIDTH,
  CMD_SET_DIRECTION,
  CMD_SET_DURATION,
  CMD_SET_ENDIANESS,
  CMD_SET_ENUM,
  CMD_SET_ENUM_ITEM,
  CMD_SET_EMPTY_NAME,
  CMD_SET_FIELD,
  CMD_SET_FIELD_POSITION,
  CMD_SET_FULL_NAME,
  CMD_SET_GENERATOR_TYPE,
  CMD_SET_INSTANCE_ALTERATION_BIT,
  CMD_SET_MEM_INSTANCE_NAME,
  CMD_SET_MNEMONIC,
  CMD_SET_MODULE_NAME,
  CMD_SET_NAME,
  CMD_SET_NEXT,
  CMD_SET_NEXT_ADDRESS,
  CMD_SET_NUMBER_OF_DIMENSIONS,
  CMD_SET_OFFSET,
  CMD_SET_PATTERN,
  CMD_SET_PERIOD,
  CMD_SET_PHASE_DIFFERENCE,
  CMD_SET_PHYSICAL_IMPLEMENTATION,
  CMD_SET_POP_NAME,
  CMD_SET_PREFIX,
  CMD_SET_PREVIOUS,
  CMD_SET_PUSH_NAME,
  CMD_SET_RADIX,
  CMD_SET_RANGE,
  CMD_SET_RD_ADDR_NAME,
  CMD_SET_RD_CLOCK_NAME,
  CMD_SET_RD_DATA_NAME,
  CMD_SET_RD_EN_NAME,
  CMD_SET_RESET,
  CMD_SET_RESET_NAME,
  CMD_SET_SIGNAL_NAME,
  CMD_SET_SIGNAL_PREFIX_LOCAL,
  CMD_SET_START_SIGNAL,
  CMD_SET_SUFFIX,
  CMD_SET_SYMBOL_MAX_LENGTH,
  CMD_SET_TESTBENCH_VERILOG_FILENAME,
  CMD_SET_TIMEBASE,
  CMD_SET_TOP_UNIT,
  CMD_SET_TYPE,
  CMD_SET_UNIT_PREFIX,
  CMD_SET_VALID_NAME,
  CMD_SET_VALUE,
  CMD_SET_VC_CAPTURE_EDGE_TYPE,
  CMD_SET_VC_CLOCK,
  CMD_SET_VC_COMPARE_TRIGGER,
  CMD_SET_VC_CPP_RD_NAME,
  CMD_SET_VC_CPP_WR_NAME,
  CMD_SET_VC_END_GENERATION_TRIGGER,
  CMD_SET_VC_HEADER_COMMENT,
  CMD_SET_VC_ID,
  CMD_SET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS,
  CMD_SET_VC_MAX_NUMBER_OF_MISMATCHES,
  CMD_SET_VC_MAX_NUM_OF_TRANSACTION_EVENTS,
  CMD_SET_VC_MAX_NUM_STATES,
  CMD_SET_VC_NAME,
  CMD_SET_VC_OUTPUT_FILENAME,
  CMD_SET_VC_RESET,
  CMD_SET_VC_STALL,
  CMD_SET_VC_START_GENERATION_TRIGGER,
  CMD_SET_VC_TIMEOUT,
  CMD_SET_VERSION,
  CMD_SET_WIDTH,
  CMD_SET_WR_ADDR_NAME,
  CMD_SET_WR_CLOCK_NAME,
  CMD_SET_WR_DATA_NAME,
  CMD_SET_WR_EN_NAME
} ECSLCmdType;

typedef enum _ECSLParamType {
  PT_ENUM_ITEM,
  PT_OBJECT,
  PT_KEY_WORD,
  PT_CONST
} ECSLParamType;

typedef enum _ECSLParamDecl {
  PD_GLOBAL,
  PD_SCOPE
} ECSLParamDecl;

//-----------------------------------classes-----------------------------------//
class CSLChapter;
class CSLClass;
class CSLCmd;
class CSLParam;
class CSLEnumItem;
class CSLObjDecl;
class CSLKeyWord;
class CSLConst;

//-----------------------------------typedefs-----------------------------------//
typedef CSLChapter*                                                     CSLChapterPoint;
typedef CSLClass*                                                       CSLClassPoint;
typedef CSLCmd*                                                         CSLCmdPoint;
typedef CSLParam*                                                       CSLParamPoint;
typedef CSLEnumItem*                                                    CSLEnumItemPoint;
typedef CSLObjDecl*                                                     CSLObjDeclPoint;
typedef CSLKeyWord*                                                     CSLKeyWordPoint;
typedef CSLConst*                                                       CSLConstPoint;

typedef pair<string, string>                                            StringStringPair;

typedef vector<ECSLClass>                                               ECSLClassVector;
typedef vector<CSLClassPoint>                                           CSLClassPointVect;
typedef vector<CSLCmdPoint>                                             CSLCmdPointVect;
typedef vector<CSLParamPoint>                                           CSLParamPointVect;
typedef vector<CSLParamPointVect>                                       CSLParamPointVectVect;

typedef map<ECSLClass, string>                                          ECSLClassStringMap;
typedef map<ECSLCmdType, string>                                        ECSLCmdStringMap;
typedef map<ECSLParamType, string>                                      ECSLParamStringMap;

typedef ECSLClassVector::const_iterator                                 ECSLClassVector_const_iter;
typedef CSLClassPointVect::const_iterator                               CSLClassPointVect_const_iter;
typedef CSLCmdPointVect::const_iterator                                 CSLCmdPointVect_const_iter;
typedef CSLParamPointVect::const_iterator                               CSLParamPointVect_const_iter;
typedef CSLParamPointVectVect::const_iterator                           CSLParamPointVectVect_const_iter;
typedef ECSLClassStringMap::const_iterator                              ECSLClassStringMap_const_iter;
typedef ECSLCmdStringMap::const_iterator                                ECSLCmdStringMap_const_iter;
typedef ECSLParamStringMap::const_iterator                              ECSLParamStringMap_const_iter;

typedef const CSLParamPointVectVect*                                    CSLParamPointVectVectPoint;
typedef const CSLParamPointVect*                                        CSLParamPointVectPoint;

typedef pair<CSLClassPoint, CSLParamPointVectPoint>                     CSLClassPointCSLParamVectPointPair;

typedef vector<CSLParamPointVectVect_const_iter>                        CSLParamPointVectVect_const_iterVect;
typedef vector<CSLClassPointCSLParamVectPointPair>                      CSLClassPointCSLParamVectPointPairVect;
typedef vector<CSLClassPointCSLParamVectPointPairVect>                  CSLClassPointCSLParamVectPointPairVectVect;

typedef CSLParamPointVectVect_const_iterVect::iterator                  CSLParamPointVectVect_const_iterVect_iter;
typedef CSLClassPointCSLParamVectPointPairVect::const_iterator          CSLClassPointCSLParamVectPointPairVect_const_iter;
typedef CSLClassPointCSLParamVectPointPairVectVect::const_iterator      CSLClassPointCSLParamVectPointPairVectVect_const_iter;

#endif //_CGEN_DECLARATIONS_H_
