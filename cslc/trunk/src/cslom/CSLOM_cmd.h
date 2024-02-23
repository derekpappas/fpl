//---------------------------------------------------------------------
// Copyright (c) 2006, 2007, 2008 Fastpath Logic, Inc.
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpath Logic, Inc.;
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
// The purpose of this code is to check and execute set commands
//----------------------------------------------------------------------

// Author BogdanZ & MihaelaP & AndreiS

#ifndef INC_GUARD_CSLOM_CMD_h
#define INC_GUARD_CSLOM_CMD_h

#include "string"
#include "CSLOM.h"
#include "../support/CommonSupport.h"

using namespace std;

namespace NSCSLOm {

/**
 * enum definitions
 */
enum ECSLOmCommandType {
  TYPE_CMD_UNDEFINED                       ,
  TYPE_CMD_SET_WIDTH                       ,
  TYPE_CMD_SET_DEPTH                       ,
  TYPE_CMD_SET_BITRANGE                    ,
  TYPE_CMD_SET_OFFSET                      ,
  TYPE_CMD_SET_RANGE                       , 
  TYPE_CMD_SET_NUMBER_OF_DIMENSIONS        , 
  TYPE_CMD_SET_DIM_WIDTH                   , 
  TYPE_CMD_SET_DIM_BITRANGE                , 
  TYPE_CMD_SET_DIM_OFFSET                  ,
  TYPE_CMD_SET_DIM_RANGE                   ,
  TYPE_CMD_SET_UNIT_PREFIX                 ,
  TYPE_CMD_SET_SIGNAL_PREFIX               ,
  TYPE_CMD_SET_SIGNAL_PREFIX_LOCAL         ,
  TYPE_CMD_SET_TYPE                        ,
  TYPE_CMD_SET_ATTR                        ,
  TYPE_CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS ,
  TYPE_CMD_ADD_INSTANCE_ALL                ,
  TYPE_CMD_ADD_UNIT_PARAMETER              ,
  TYPE_CMD_ADD_PAIR                        ,
  TYPE_CMD_OVERRIDE_UNIT_PARAMETER         ,
  TYPE_CMD_OVERRIDE_PARAMETER_NAMED        ,
  TYPE_CMD_OVERRIDE_PARAMETER_ORDERED      ,
  TYPE_CMD_INPUT_VERILOG_TYPE              ,
  TYPE_CMD_OUTPUT_VERILOG_TYPE             ,
  TYPE_CMD_REVERSE                         ,
  //  TYPE_CMD_CONNECT                         ,
  TYPE_CMD_SET_PREFIX                      ,
  TYPE_CMD_SET_SUFFIX                      ,
  TYPE_CMD_NO_PREFIX                       ,


  /*
   *Vector or StateData commands
   */

  //enums
  TYPE_CMD_VSD_SET_RADIX                   ,
  TYPE_CMD_VSD_SET_CAPTURE_EDGE_TYPE       ,
  //ints
  TYPE_CMD_VSD_SET_NUMERIC_ID              ,
  TYPE_CMD_VSD_SET_VERSION                 ,
  TYPE_CMD_VSD_SET_MAX_EVENTS_COUNT        ,
  TYPE_CMD_VSD_SET_MAX_MISMATCHES_COUNT    ,
  TYPE_CMD_VSD_SET_TIMEOUT                 ,
  TYPE_CMD_VSD_SET_MAX_NUM_STATES          ,
  TYPE_CMD_VSD_SET_NUM_OF_TRANSACTION      ,
  //strings
  TYPE_CMD_VSD_SET_NAME                    ,
  TYPE_CMD_VSD_SET_HEADER_COMMENT          ,
  TYPE_CMD_VSD_SET_OUTPUT_FILENAME         ,
  TYPE_CMD_VSD_SET_CPP_RD_NAME             ,
  TYPE_CMD_VSD_SET_CPP_WR_NAME             ,
  //signals
  TYPE_CMD_VSD_SET_CLOCK                   ,
  TYPE_CMD_VSD_SET_RESET                   ,
  TYPE_CMD_VSD_SET_STALL                   ,
  TYPE_CMD_VSD_SET_COMPARE_TRIGGER         ,
  TYPE_CMD_VSD_SET_START_GENERATION_TRIGGER,
  TYPE_CMD_VSD_SET_END_GENERATION_TRIGGER  ,
  //specified
  TYPE_CMD_VSD_SET_MODULE_NAME             ,
  TYPE_CMD_VSD_SET_INSTANCE_NAME           ,

  TYPE_CMD_VSD_SET_ADD_PORT_SIG_IFC        ,
  TYPE_CMD_VSD_SET_DIRECTION               ,
  TYPE_CMD_VSD_INCLUDE_ONLY                ,
  TYPE_CMD_VSD_EXCLUDE_ONLY                ,
  TYPE_CMD_VSD_MAX_CYCLES                  ,

  /*
   *testbench stuff
   */
  TYPE_CMD_TB_ADD_LOGIC                     ,
  TYPE_CMD_TB_ADD_VERILOG_FILENAME          ,
  TYPE_CMD_TB_SET_INSTANCE_NAME             ,


  /*
   *stuff for decoder
   */
  TYPE_CMD_SET_DECODER                     ,
  TYPE_CMD_MAX                             ,
  
  /*
   *stuff for fifo
   */
  TYPE_CMD_FIFO_ADD_PROGRAMMABLE_DEPTH     ,
  TYPE_CMD_FIFO_SET_PHYSICAL_IMP_TYPE      ,
  TYPE_CMD_FIFO_ADD_PRIO_BYPASS            ,
  TYPE_CMD_FIFO_SET_ASYNCH                 ,
  TYPE_CMD_FIFO_SET_DEPTH_EXTEND           ,
  TYPE_CMD_FIFO_SET_WIDTH_EXTEND           ,
  TYPE_CMD_FIFO_SET_WR_HOLD                ,
  TYPE_CMD_FIFO_PARALLEL_OUTPUT            ,
  TYPE_CMD_FIFO_PARALLEL_INPUT             ,
  TYPE_CMD_FIFO_RD_WORDS                   ,
  TYPE_CMD_FIFO_WR_WORDS                   ,
  TYPE_CMD_FIFO_ADD_SRAM_RD                ,
  TYPE_CMD_FIFO_ADD_SRAM_WR                ,
  TYPE_CMD_FIFO_ADD_PUSHBACK               ,
  TYPE_CMD_FIFO_FLOW_THROUGH               ,
  TYPE_CMD_FIFO_ADD_STALL                  ,
  TYPE_CMD_FIFO_ADD_STALL_RD_SIDE          ,
  TYPE_CMD_FIFO_ADD_STALL_WR_SIDE          ,
  TYPE_CMD_FIFO_ADD_WR_RELEASE             ,
  TYPE_CMD_FIFO_ADD_ALMOST_EMPTY           ,
  TYPE_CMD_FIFO_ADD_ALMOST_FULL            ,
  TYPE_CMD_FIFO_ADD_OUT_WR_ADDR            ,
  TYPE_CMD_FIFO_ADD_OUT_RD_ADDR            ,
  TYPE_CMD_FIFO_ADD_CREDIT                 ,
  TYPE_CMD_FIFO_ADD_RD_CREDIT              ,
  TYPE_CMD_FIFO_ADD_WR_CREDIT              ,

  /*
   *register file (RF)
   */

  TYPE_CMD_RF_SET_CONST_VALUE              ,
  TYPE_CMD_RF_SET_FIELD                    ,
  TYPE_CMD_RF_SET_GROUP_NAME               ,
  TYPE_CMD_SET_PORT_NAME                   ,


  //field:

  TYPE_CMD_SET_VALUE                        ,
  TYPE_CMD_SET_ENUM                         ,
  TYPE_CMD_SET_ENUM_ITEM                    ,
  TYPE_CMD_SET_POSITION                     ,
  TYPE_CMD_SET_NEXT                         ,
  TYPE_CMD_SET_PREVIOUS                     ,
  TYPE_CMD_ADD_ALLOWED_RANGE                ,

  //memory map
  TYPE_CMD_ADD_ADDRESS_RANGE                ,
  TYPE_CMD_SET_ADDRESS_INCREMENT            ,
  TYPE_CMD_SET_NEXT_ADDRESS                 ,
  TYPE_CMD_ADD_RESERVED_RANGE               ,
  TYPE_CMD_ADD                              ,
  TYPE_CMD_SET_DATA_WORD_WIDTH              ,
  TYPE_CMD_SET_ALIGNMENT                    ,
  TYPE_CMD_SET_ENDIANESS                    ,
  TYPE_CMD_SET_SYMBOL_MAX_LENGTH            ,
  TYPE_CMD_AUTO_GEN_MEM_MAP                 ,
  TYPE_CMD_SET_TOP_UNIT                     ,
  TYPE_CMD_ADD_TO_MEM_MAP                   ,
  TYPE_CMD_SET_ACCESS_RIGHTS                ,
  TYPE_CMD_SET_ACCESS_RIGHTS_ENUM           ,
  TYPE_CMD_SET_INSTANCE_NAME                ,
  TYPE_CMD_SET_PAGE_NO                      ,


  //register

  TYPE_CMD_ADD_LOGIC                        ,

  //isa:
  TYPE_CMD_SET_ASM_MNEMONIC                 ,
  TYPE_CMD_SET_DECODER_NAME                 ,
  TYPE_CMD_SET_DECODER_OUT_NAME_PREFIX      ,
  TYPE_CMD_SET_DECODER_OUT_NAME_SUFFIX      ,
  TYPE_CMD_PRINT                            ,
  TYPE_CMD_SET_NAME                         ,

  //interconnect
  TYPE_CMD_NO_GEN_RTL                       ,
  TYPE_CMD_GEN_UNIQUE_RTL_MODULES           ,
  TYPE_CMD_SET_CLOCK                        ,
  TYPE_CMD_REGISTER_IOS                     ,
  TYPE_CMD_DO_NOT_GEN_CPP                   
};

/**
 * classes
 */
class CSLOmSetCommand                           ;
class CSLOmCmdSetWidth                          ;
class CSLOmCmdSetDepth                          ;
class CSLOmCmdSetBitRange                       ;
class CSLOmCmdSetOffset                         ;

class CSLOmCmdSetRange                          ;
class CSLOmCmdSetNumberOfDimensions             ;
class CSLOmCmdSetDimWidth                       ;
class CSLOmCmdSetDimBitRange                    ;
class CSLOmCmdSetDimOffset                      ;

class CSLOmCmdSetDimRange                       ;
class CSLOmCmdSetUnitPrefix                     ;
class CSLOmCmdSetSignalPrefix                   ;
class CSLOmCmdSetSignalPrefixLocal              ;
class CSLOmCmdSetType                           ;
class CSLOmCmdSetAttr                           ;

class CSLOmCmdGenerateIndividualRTLSignals      ;

class CSLOmCmdAddUnitParameter                  ;
class CSLOmCmdOverrideUnitParameter             ;
class CSLOmCmdOverrideParameterOrdered          ;
class CSLOmCmdOverrideParameterNamed            ;

class CSLOmCmdInputVerilogType                  ;
class CSLOmCmdOutputVerilogType                 ;
class CSLOmCmdReverse                           ;
//class CSLOmCmdConnect                           ;


/*
 *stuff for decoder
 */
class CSLOmCmdSetEnum                           ;
class CSLOmCmdDecSetDecoder                     ;

//field & isa instruction format:
class CSLOmCmdSetValue                          ;
class CSLOmCmdSetEnumItem                       ;
class CSLOmCmdSetPosition                       ;
class CSLOmCmdSetNext                           ;
class CSLOmCmdSetPrevious                       ;
class CSLOmCmdAddAllowedRange                   ;

/*
 *test bench vector command classes
 */

class CSLOmCmdSetPrefix                         ;
class CSLOmCmdSetSuffix                         ;
class CSLOmCmdNoPrefix                          ;
/*
 * Vector or StateData commands
 */

class CSLOmCmdVSDSetRadix                       ;
class CSLOmCmdVSDSetCaptureEdgeType             ;
class CSLOmCmdVSDSetNumericID                   ;
class CSLOmCmdVSDSetVersion                     ;
class CSLOmCmdVSDSetMaxEventsCount              ;
class CSLOmCmdVSDSetMaxMismatchesCount          ;
class CSLOmCmdVSDSetTimeout                     ;
class CSLOmCmdVSDSetMaxNumStates                ;
class CSLOmCmdVSDSetNumOfTransaction            ;
class CSLOmCmdVSDSetName                        ;
class CSLOmCmdVSDSetHeaderComment               ;
class CSLOmCmdVSDSetOutputFilename              ;
class CSLOmCmdVSDSetCppRDName                   ;
class CSLOmCmdVSDSetCppWRName                   ;
class CSLOmCmdVSDSetClock                       ;
class CSLOmCmdVSDSetReset                       ;
class CSLOmCmdVSDSetStall                       ;
class CSLOmCmdVSDSetCompareTrigger              ;
class CSLOmCmdVSDSetStartGenerationTrigger      ;
class CSLOmCmdVSDSetEndGenerationTrigger        ;

class CSLOmCmdVSDSetModuleName                  ;
class CSLOmCmdVSDSetInstanceName                ;
class CSLOmCmdVSDSetDirection                   ;
class CSLOmCmdVSDIncludeOnly                    ;
class CSLOmCmdVSDExcludeOnly                    ;



//FIFO command classes
class CSLOmCmdFifoAddProgrammableDepth          ;
class CSLOmCmdFifoSetPhysicalImpType            ;
class CSLOmCmdFifoAddPrioBypass                 ;
class CSLOmCmdFifoSetAsynch                     ;
class CSLOmCmdFifoSetDepthExtend                ;
class CSLOmCmdFifoSetWidthExtend                ;
class CSLOmCmdFifoSetWrHold                     ;
class CSLOmCmdFifoParallelOutput                ;
class CSLOmCmdFifoParallelInput                 ;
class CSLOmCmdFifoRdWords                       ;
class CSLOmCmdFifoWrWords                       ;
class CSLOmCmdFifoAddSramRd                     ;
class CSLOmCmdFifoAddSramWr                     ;
class CSLOmCmdFifoAddPushback                   ;
class CSLOmCmdFifoFlowThrough                   ;
class CSLOmCmdFifoAddStall                      ;
class CSLOmCmdFifoAddStallRdSide                ;
class CSLOmCmdFifoAddStallWrSide                ;
class CSLOmCmdFifoAddWrRelease                  ;
class CSLOmCmdFifoAddAlmostEmpty                ;
class CSLOmCmdFifoAddAlmostFull                 ;
class CSLOmCmdFifoAddOutWrAddr                  ;
class CSLOmCmdFifoAddOutRdAddr                  ;
class CSLOmCmdFifoAddCredit                     ;
class CSLOmCmdFifoAddRdCredit                   ;
class CSLOmCmdFifoAddWrCredit                   ;

//memory map
class CSLOmCmdAddAddressRange                   ;
class CSLOmCmdSetAddressIncrement               ;
class CSLOmCmdSetNextAddress                    ;
class CSLOmCmdAddReservedRange                  ;
class CSLOmCmdAdd                               ;
class CSLOmCmdSetDataWordWidth                  ;
class CSLOmCmdSetDataWordWidth                  ;
class CSLOmCmdSetAlignament                     ;
class CSLOmCmdSetEndianess                      ;
class CSLOmCmdSetSymbolMaxLength                ;
class CSLOmCmdAutoGenMemMap                     ;
class CSLOmCmdSetTopUnit                        ;
class CSLOmCmdAddToMemoryMap                    ;
class CSLOmCmdSetAccessRights                   ;
class CSLOmCmdSetAccessRightsEnum               ;
class CSLOmCmdSetInstanceName                   ;
class CSLOmCmdSetPageNo                         ;

//isa
class CSLOmCmdSetDecoderName                    ;
class CSLOmCmdSetDecoderOutNamePrefix           ;
class CSLOmCmdSetDecoderOutNameSuffix           ;
class CSLOmCmdSetAsmMnemonic                    ;
class CSLOmCmdPrint                             ;

class CSLOmCmdAddInstanceAll                    ;
class CSLOmCmdEnumAddPair                       ;


class CSLOmCmdSetName                           ;
//register
class CSLOmCmdAddLogic                          ; 

//Register File
class CSLOmCmdRFSetField                        ;
class CSLOmCmdRFSetExternal                     ;
class CSLOmCmdRFSetGroupName                    ;
class CSLOmCmdRFSetConstValue                   ;
class CSLOmCmdSetPortName                       ;

//interconnect
class  CSLOmCmdNoGenRTL                         ;
class  CSLOmCmdGenUniqueRTLModules              ;
class  CSLOmCmdSetClock                         ;
class  CSLOmCmdRegisterIOS                      ;
class  CSLOmCmdDoNotGenCPP                      ;
       

/**
 * typedefs for command section
 */
typedef boost::shared_ptr<CSLOmCmdSetWidth>                     RefCSLOmCmdSetWidth;
typedef boost::shared_ptr<CSLOmCmdSetBitRange>                  RefCSLOmCmdSetBitRange;
typedef boost::shared_ptr<CSLOmCmdSetOffset>                    RefCSLOmCmdSetOffset;
typedef boost::shared_ptr<CSLOmCmdSetRange>                     RefCSLOmCmdSetRange;
                                                                  
typedef boost::shared_ptr<CSLOmCmdSetNumberOfDimensions>        RefCSLOmCmdSetNumberOfDimensions;
                                                                  
typedef boost::shared_ptr<CSLOmCmdSetDimWidth>                  RefCSLOmCmdSetDimWidth;
typedef boost::shared_ptr<CSLOmCmdSetDimBitRange>               RefCSLOmCmdSetDimBitRange;
typedef boost::shared_ptr<CSLOmCmdSetDimOffset>                 RefCSLOmCmdSetDimOffset;
typedef boost::shared_ptr<CSLOmCmdSetDimRange>                  RefCSLOmCmdSetDimRange;
                                                                  
typedef boost::shared_ptr<CSLOmCmdSetUnitPrefix>                RefCSLOmCmdSetUnitPrefix;
typedef boost::shared_ptr<CSLOmCmdSetSignalPrefix>              RefCSLOmCmdSetSignalPrefix;
typedef boost::shared_ptr<CSLOmCmdSetSignalPrefixLocal>         RefCSLOmCmdSetSignalPrefixLocal;
                                                                  
typedef boost::shared_ptr<CSLOmCmdSetType>                      RefCSLOmCmdSetType;
typedef boost::shared_ptr<CSLOmCmdSetAttr>                      RefCSLOmCmdSetAttr;
typedef boost::shared_ptr<CSLOmCmdGenerateIndividualRTLSignals> RefCSLOmCmdGenerateIndividualRTLSignals;

typedef boost::shared_ptr<CSLOmCmdAddUnitParameter>             RefCSLOmCmdAddUnitParameter;
typedef boost::shared_ptr<CSLOmCmdOverrideUnitParameter>        RefCSLOmCmdOverrideUnitParameter;
typedef boost::shared_ptr<CSLOmCmdOverrideParameterNamed>       RefCSLOmCmdOverrideParameterNamed;
typedef boost::shared_ptr<CSLOmCmdOverrideParameterOrdered>     RefCSLOmCmdOverrideParameterOrdered;
                                                                  
typedef boost::shared_ptr<CSLOmCmdInputVerilogType>             RefCSLOmCmdInputVerilogType;
typedef boost::shared_ptr<CSLOmCmdOutputVerilogType>            RefCSLOmCmdOutputVerilogType;
typedef boost::shared_ptr<CSLOmCmdReverse>                      RefCSLOmCmdReverse;
//typedef boost::shared_ptr<CSLOmCmdConnect>                      RefCSLOmCmdConnect;


typedef TBool (CSLOmBase::*TIsPredicate)() const;

// ********************************************************************************
// CSLOmSetCommand class
// ********************************************************************************
/**
 * Generic command class.
 * All other command classes are built, checked and executed through this class.
 */
class CSLOmSetCommand {

  protected:    
    /**
     * The keyword of the instantiated command.
     *
     * @see ECSLOmCommandType
     */
    static ECSLOmCommandType m_keyword;

     /**
     *This functions verifies that the number of parameters(the size of "params" in fact) is between "noMin" and "noMax". If this doesn't happen, an error is thrown.
     *
     * @param params - the parameters
     * @param noMin - minimum number of parameters
     * @param noMax - maximum number of parameters
     * @param errName - argument for addErr(); the name of the calling method;
     * @param lineNumber - the line in the csl code where the error appeared
     * @param fileName - the file where the error appeared
     * @param canContinue - variable used to decide if errors occured
     */
    static TBool checkParamSize(RefTVec_RefCSLOmExpr params, TUInt noMin, TUInt noMax, std::string errName, TLineNumberType lineNumber, RefString fileName, TBool &canContinue);
    /**
     * This functions verifies that the parent scope exists. If this doesn't happen, an error is added.
     * @param scope - the current scope
     * @param lineNumber - the line in the csl code where the error appeared
     * @param fileName - the file where the error appeared
     * @param canContinue - variable used to decide if errors occured
     */
    static RefCSLOmBase checkParentScope(RefCSLOmExprLink scope,TLineNumberType lineNumber, RefString fileName, TBool &canContinue);
    /**
     * Overloaded checkParentScope for cases when there is no canContinue.
     * @param scope - the current scope
     * @param lineNumber - the line in the csl code where the error appeared
     * @param fileName - the file where the error appeared
     */
    static RefCSLOmBase checkParentScope(RefCSLOmExprLink scope,TLineNumberType lineNumber, RefString fileName);
    /**
     * This functions verifies that the parentScope has the correct type. If this doesn't happen, an error is added.
     *
     * @param f - array of pointers to functions from CSLOmBase (functions of type isX())
     * @param aSize - the size of the array f
     * @param parentScope - the parent scope
     * @param scope - the current scope
     * @param errName - argument for addErr(); the name of the calling method;
     * @param lineNumber - the line in the csl code where the error appeared
     * @param fileName - the file where the error appeared
     * @param canContinue - variable used to decide if errors occured
     */
    static TBool checkParentType(TIsPredicate f[],TUInt aSize, RefCSLOmBase parentScope,RefCSLOmExprLink scope, std::string errName, TLineNumberType lineNumber, RefString fileName, TBool &canContinue);
    /**
     * This functions verifies that the arguments sent in "param" are not null. This is used, for example, for numeric expresions, which should never be null.
     * If this doesn't happen an error is added.
     * @param params - a vector containing the parameters to be checked
     * @param domension - the dimemsion of the vector params
     * @param errName - argument for addErr(); the name of the calling method;
     * @param lineNumber - the line in the csl code where the error appeared
     * @param fileName - the file where the error appeared
     * @param canContinue - variable used to decide if errors occured
     */
    static TBool checkArgumentForNull(RefTVec_RefCSLOmExpr params, TInt dimension,std::string errName, TLineNumberType lineNumber, RefString fileName, TBool &canContinue);
    /**
     * This functions verifies that the arguments are null. This is used, for example, when declaring a new variable. The name should not exist at all
     * (meaning the doEval() function returns null) or there shouldn't be another variable with the same name declared in the same scope. If this doesn't happen an error is thrown.
     *
     * @param params - the parameters to be checked
     * @param dimension - the dimemsion of params
     * @param errName - argument for addErr(); the name of the calling method;
     * @param scopeParent - the parent scope
     * @param lineNumber - the line in the csl code where the error appeared
     * @param fileName - the file where the error appeared
     * @param canContinue - variable used to decide if errors occured
     */
    static TBool checkArgumentForNotNull(RefTVec_RefCSLOmExpr params, TInt dimension,std::string errName, RefCSLOmBase scopeParent,TLineNumberType lineNumber, RefString fileName, TBool &canContinue);
   
    /**
     *This functions verifies that the arguments are of the corect type. If this doesn't happen an error is thrown.
     *
     * @param baseExpr - the argument
     * @param f - array of pointers to functions from CSLOmBase(of type isX())
     * @param aSize - the size of the array
     * @param errName - argument for addErr(); the name of the calling method;
     * @param lineNumber - the line in the csl code where the error appeared
     * @param fileName - the file where the error appeared
     * @param canContinue - variable used to decide if errors occured
     */
    static TBool checkArgumentType(RefCSLOmBase baseExpr, TIsPredicate f[], TInt aSize, std::string errName, TLineNumberType lineNumber, RefString fileName, TBool &canContinue);
    
    /**
     *This function verifies a numeric argument.
     *
     * @param baseExpr - the numeric argument sent as base.
     * @param checkValue - specifies if the value of the numeric argument should be checked; NO_GREATER_THAN_VALUE - means than the number should be checked to be greater than value argument; NO_NOT_EQUAL_TO_VALUE - means that the number has to be checked to be different from the value argument.
     * @param value - the value used to check baseExpr against
     * @param checkXZ - specifies if there should be a check on XZ presence; NO_CHECK_FOR_XZ - the number must have XZ; NO_CHECK_FOR_NOT_XZ - the number must not have XZ; NO_DO_NOT_CHECK_XZ - it doesn't matter if the number has XZ or not.
     * @param checkInt32 - specifies if there should be a check made that the numeric argument is of type int32
     * @param errName - string used at throwing error messages
     * @param lineNumber - the line in the csl code where the error appeared
     * @param fileName - the file where the error appeared
     * @param canContinue - variable used to decide if errors occured
     *
     */
    static TBool checkNumber(RefCSLOmBase baseExpr, TInt checkValue, TInt value, TInt checkXZ, TBool checkInt32,std::string errName, TLineNumberType lineNumber, RefString fileName, TBool &canContinue); 
    

    
    /**
     *Used mainly for throwing errors. Return the name of the scopeParent. In case the scopeParent is the design (which does not have a name), the string "global" is returned.
     */
    static RefString getScopeValue(RefCSLOmBase scopeParent);


  public:
    /**
     * Static method that builds a command object. It is the only build that is public. All the other build functions are called through this one.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the csl code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param keyword - type ECSLOmCommandType - the keyword(name) of the command
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see ECSLOmCommandType
     * @see CSLOmExpr
     * @see addEnumParam(TBool param)
     * @see addEnumParam(EVerilogType param)
     * @see addEnumParam(ECSLOmSignalType param)
     * @see addEnumParam(ECSLOmPortDirection param)
     * @see addEnumParam(ECSLOmSignalAttr param)
     */
    static RefCSLOmSetCommand build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink hid, ECSLOmCommandType keyword, RefTVec_RefCSLOmExpr params);

    /**
     * Function that returns the keyword(name) of the command.
     * 
     * @return ECSLOmCommandType
     *
     * @see ECSLOmCommandType
     */
    static ECSLOmCommandType getCommandType();

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function.
     *
     * @param param - type TBool - used for commands that takes a ON/OFF param (ON=TRUE/OFF=FALSE)
     *
     * @see CSLOmSetCommand
     * @see CSLOmCmdGenerateIndividualRTLSignals
     */
    static void addEnumParam(TBool param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type EVerilogType - used for commands that takes a Verilog type param
     *
     * @see EVerilogType
     * @see CSLOmSetCommand
     * @see CSLOmCmdInputVerilogType
     * @see CSLOmCmdOutputVerilogType
     */
    static void addEnumParam(EVerilogType param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object.It is called before the build function .
     *
     * @param param - type ECSLOmSignalType - used for commands that take a signal type parameter.
     *
     * @see ECSLOmSignalType
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetType
     */
    static void addEnumParam(ECSLOmSignalType param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type EMemoryMapType - used for commands that take a memory map type parameter.
     *
     * @see EMemoryMapType
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetType
     */
    static void addEnumParam(EMemoryMapType param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type EAddressRangeType - used for commands that take a address range type parameter.
     *
     * @see EAddressRangeType
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetType
     */
    static void addEnumParam(CSLOmAddressRange::EAddressRangeType param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type ECSLOmIsaFieldType - used for commands that take a isa field type parameter.
     *
     * @see ECSLOmIsaFieldType
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetType
     */
    static void addEnumParam(CSLOmIsaField::ECSLOmIsaFieldType param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type EIsaElementType - used for commands that take a isa element type parameter.
     *
     * @see EIsaElementType
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetType
     */
    static void addEnumParam(CSLOmIsaElement::EIsaElementType param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type _ERegType - used for commands that take a register type parameter.
     *
     * @see _ERegType
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetType
     */
    static void addEnumParam(CSLOmRegDeclInfo::ERegDeclType param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type Endianess - used for commands that take a memory map page endianess parameter.
     *
     * @see CSLOmMemoryMapPage::Endianess
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetEndianess
     */
    static void addEnumParam(CSLOmMemoryMapPage::Endianess param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type ECSLOmSignalAttr - used for commands that take a signal attribute parameter.
     *
     * @see ECSLOmSignalAttr
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetAttr
     */
    static void addEnumParam(ECSLOmSignalAttr param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type ERegDeclAttr - used for commands that take a register attribute parameter.
     *
     * @see ERegDeclAttr
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetAttr
     */
    static void addEnumParam(ERegDeclAttr param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type ECSLOmVCRadix - used for commands that take a radix attribute parameter.
     *
     * @see ECSLOmVCRadix
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetAttr
     */
    static void addEnumParam(CSLOmVerifCompInfo::ECSLOmVCRadix param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type ECSLOmVCEdgeType - used for commands that take a edge type parameter.
     *
     * @see ECSLOmVCEdgeType
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetAttr
     */
    static void addEnumParam(CSLOmVerifCompInfo::ECSLOmVCEdgeType param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type ERFPortNames - used for commands that take a register file or fifo port name parameter.
     *
     * @see EPortNames
     * @see CSLOmSetCommand
     * @see CSLOmCmdSetPortName
     */
    static void addEnumParam(EPortNames param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type ERegDeclOperations - used for commands that take a register file port name parameter.
     *
     * @see ERegDeclOperations
     * @see CSLOmSetCommand
     * @see CSLOmCmdAddLogic
     */
    static void addEnumParam(CSLOmRegDeclInfo::ERegDeclOperations param, ECSLOmCommandType keyword);

    /**
     * This function is used to add a keyword(enum) parameter to the command object. It is called before the build function .
     *
     * @param param - type ERegDeclCntDir - used for commands that take a register file port name parameter.
     *
     * @see ERegDeclCntDir
     * @see CSLOmSetCommand
     */
    static void addEnumParam(CSLOmRegDeclInfo::ERegDeclCntDir param, ECSLOmCommandType keyword);


};

// ********************************************************************************
// CSLOmCmdSetWidth class
// ********************************************************************************
/**
 * Class that holds a set_width command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetWidth : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetWidth.
     * Builds and returns an object of type CSLOmCmdSetWidth.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear);
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions;
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * There should be only one parameter ( the width ).
     * The object that calls this command should be of type: signal, port, register file, fifo, address range, isa element, register or a list. The object shouldn't have its width already set. 
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};



// ********************************************************************************
// CSLOmCmdSetDepth class
// ********************************************************************************
/**
 * Class that holds a set_depth command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetDepth : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetDepth.
     * Builds and returns an object of type CSLOmCmdSetDepth.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear).
     *                  Remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions.
     *                  They are added by addEnumParam functions.
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     *\n
     * There should be only one parameter (the depth ).
     * The object that calls this command should be of type: register file, fifo or a list with elements of type register file/fifo. The object shouldn't have its depth already set.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};



 
// ********************************************************************************
// CSLOmCmdSetBitRange class
// ********************************************************************************
/**
 * Class that holds a set_bitrange command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetBitRange : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetBitRange.
     * Builds and returns an object of type CSLOmCmdSetBitRange.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.  
     * \n
     * There should be only one parameter ( the bitRange ): bitRange, not null (doEval should return the existing bitrange sent as argument).  
     * \n
     * The object that calls this method (the scopeParent) should be of type: signal, port or list of signals or ports. The object should not have a width or bitrange already set.  
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetOffset class
// ********************************************************************************
/**
 * Class that holds a set_offset command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetOffset : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetOffset.
     * Builds and returns an object of type CSLOmCmdSetOffset.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.  
     * \n
     * There should be only one parameter ( the offset ).
     * \n
     * The object that calls this method (the parentScope) should be of type: signal, simple bitRange, address range or list. 
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetRange class
// ********************************************************************************
/**
 * Class that holds a set_range command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetRange : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetRange.
     * Builds and returns an object of type CSLOmCmdSetRange.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n  
     * There should be 2 parameters (the lower index and the upper index).
     * \n
     * The object that calls this method ( the parentScope) should be of type: signal, port, addressRange, register or list. The object should not have its range already set.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetNumberOfDimensions class
// ********************************************************************************
/**
 * Class that holds a set_number_of_dimensions command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetNumberOfDimensions : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetNumberOfDimensions.
     * Builds and returns an object of type CSLOmCmdSetNumberOfDimensions.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * There should be only one parameter: number, not null, greater than 0, with no XZ.
     * \n
     * The parentScope should be: signal, port or list of signals/ports. The bitrange of the object should not be already multidimensional and its width/range shouldn't be already set.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetDimWidth class
// ********************************************************************************
/**
 * Class that holds a set_dim_width command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetDimWidth : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetDimWidth.
     * Builds and returns an object of type CSLOmCmdSetDimWidth.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * There should be 2 parameters: numbers, not null, with no XZ; the fisrt one ( the dimension ) should be in [0, noOfDimensions); the second one ( the width ) should be greater than 0.
     * \n
     * The parentScope should be: signal, multi dimensional bitRange or list.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetDimBitRange class
// ********************************************************************************
/**
 * Class that holds a set_dim_bitrange command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetDimBitRange : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetDimBitRange.
     * Builds and returns an object of type CSLOmCmdSetDimBitRange.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.  
     * \n
     * There should be 2 parameters: the first one (the dimension ) should be number, not null, greater or equal to 0, smaller than the number of dimensions, with no XZ; the second one should be an exprLink or a bitRange, not null. 
     * \n
     * The parentScope should be: signal, bitRange or list. The bitRange of the object should be multidimensional.  
     * \n
     * This method should be called in the elaborator step before the call of the execute function
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetDimOffset class
// ********************************************************************************
/**
 * Class that holds a set_dim_offset command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetDimOffset : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private: 

    /**
     * Static build function for CSLOmCmdSetDimOffset.
     * Builds and returns an object of type CSLOmCmdSetDimOffset.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.  
     * \n
     * There should be only 2 parameters: numbers, not null, with no XZ; the first one should be greater or equal to 0, and smaller than the number of dimensions; the second one should be greater than 0.  
     * \n
     * The parentScope should be: signal, bitRange or list.  
     * \n
     * This method should be called in the elaborator step before the call of the execute function
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetDimRange class
// ********************************************************************************
/**
 * Class that holds a set_dim_range command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetDimRange : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetDimRange.
     * Builds and returns an object of type CSLOmCmdSetDimRange.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * It has two parameters (the dimension ant the bitRange ) : the fisrt one should be a number, not null, with no XZ; the second one should be a bitRange, not null. 
     * \n
     * The parentScope should be a signal, bitrange or list. The bitRange of the object should be multidimensional.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetUnitPrefix class
// ********************************************************************************
/**
 * Class that holds a set_unit_prefix command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetUnitPrefix : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetUnitPrefix.
     * Builds and returns an object of type CSLOmCmdSetUnitPrefix.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetSignalPrefix class
// ********************************************************************************
/**
 * Class that holds a set_signal_prefix command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetSignalPrefix : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetSignalPrefix.
     * Builds and returns an object of type CSLOmCmdSetSignalPrefix.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetSignalPrefixLocal class
// ********************************************************************************
/**
 * Class that holds a set_signal_prefix_local command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetSignalPrefixLocal : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetSignalPrefixLocal.
     * Builds and returns an object of type CSLOmCmdSetSignalPrefixLocal.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetType class
// ********************************************************************************
/**
 * Class that holds a set_type command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetType : public CSLOmSetCommand {
  private:
    /**
     * Stores a ECSLOmSignalType value. By default it is SIGNAL_UNDEFINED. The variable is used in the check and execute functions from CSLOmCmdSetType when the object calling the method is a signal.
     */
    static ECSLOmSignalType m_signalType;
    /**
     * Stores a EAddressRangeType value. By default it is ADDR_UNDEFINED. The variable is used in the check and execute functions from CSLOmCmdSetType when the object calling the method is an address range.
     */
    static CSLOmAddressRange::EAddressRangeType m_addressRangeType;
    /**
     * Stores a EMemoryMapType value. By default it is MM_UNDEFINED. The variable is used in the check and execute functions from CSLOmCmdSetType when the object calling the method is a memory map.
     */
    static EMemoryMapType m_memoryMapType;
    /**
     * Stores a ECSLOmIsaFieldType value. By default it is ISA_FIELD_UNDEFINED. The variable is used in the check and execute functions from CSLOmCmdSetType when the object calling the method is an isa field.
     */
    static CSLOmIsaField::ECSLOmIsaFieldType m_isaFieldType;
    /**
     * Stores a EIsaElementType value. By default it is ISA_ELEM_UNDEFINED. The variable is used in the check and execute functions from CSLOmCmdSetType when the object calling the method is an isa element.
     */
    static CSLOmIsaElement::EIsaElementType m_isaElementType;
    /**
     * Stores a _ERegType value. By default it is REG_UNDEFINED. The variable is used in the check and execute functions from CSLOmCmdSetType when the object calling the method is a register.
     */
    static CSLOmRegDeclInfo::ERegDeclType m_registerType;

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetType.
     * Builds and returns an object of type CSLOmCmdSetType.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     *This function should be called before the build function from CSLOmCmdSetType. It sets the m_signalType variable.
     */
    static void setSignalTypeParam(ECSLOmSignalType param);
    /**
     *Get function for m_signalType.
     */
    static ECSLOmSignalType getSignalTypeParam();

    /**
     *This function should be called before the build function from CSLOmCmdSetType when the calling object is an address range. It sets the m_addressRangeType member.
     */
    static void setAddressRangeTypeParam(CSLOmAddressRange::EAddressRangeType param);
    /**
     *Get function for m_addressRangeType.
     */
    static CSLOmAddressRange::EAddressRangeType getAddressRangeTypeParam();

    /**
     *This function should be called before the build function from CSLOmCmdSetType when the calling object is a memory map. It sets the m_memoryMapType member.
     */
    static void setMemoryMapTypeParam(EMemoryMapType param);
    /**
     *Get function for m_memoryMapType.
     */
    static EMemoryMapType getMemoryMapTypeParam();

    /**
     *This function should be called before the build function from CSLOmCmdSetType when the calling object is an isa field. It sets the m_isaFieldType member.
     */
    static void setIsaFieldTypeParam(CSLOmIsaField::ECSLOmIsaFieldType param);
    /**
     *Get function for m_isaFieldType.
     */
    static CSLOmIsaField::ECSLOmIsaFieldType getIsaFieldTypeParam();

    /**
     *This function should be called before the build function from CSLOmCmdSetType when the calling object is an isa element. It sets the m_isaElementType member.
     */
    static void setIsaElementTypeParam(CSLOmIsaElement::EIsaElementType param);
    /**
     *Get function for m_isaElementType.
     */
    static CSLOmIsaElement::EIsaElementType getIsaElementTypeParam();

    /**
     *This function should be called before the build function from CSLOmCmdSetType when the calling object is a register. It sets the m_registerType member.
     */
    static void setRegisterTypeParam(CSLOmRegDeclInfo::ERegDeclType param);
    /**
     *Get function for m_registerType.
     */
    static CSLOmRegDeclInfo::ERegDeclType getRegisterTypeParam();
};

// ********************************************************************************
// CSLOmCmdSetAttr class
// ********************************************************************************
/**
 * Class that holds a set_attr command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetAttr : public CSLOmSetCommand {
  private:
    /**
     * Stores a ECSLOmSignalAttr value. By default it is ATTR_UNDEFINED. The variable is used in the check and execute functions from CSLOmCmdSetAttr when the object calling the method is a signal.
     */
    static ECSLOmSignalAttr m_signalAttr;
    /**
     * Stores ERegAttr value. By default it is REG_ATTR_UNDEF. The variable is used in the check and execute functions from CSLOmCmdSetAttr when the object calling the method is a register.
     */
    static ERegDeclAttr m_registerAttr;

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetAttr.
     * Builds and returns an object of type CSLOmCmdSetAttr.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     *This function should be called before the build function from CSLOmCmdSetAttr when the calling object is a signal. It sets the m_signalAttr member.
     */
    static void setSignalAttrParam(ECSLOmSignalAttr param);
    /**
     *Get function for m_signalAttr.
     */
    static ECSLOmSignalAttr getSignalAttrParam();
    
    /**
     *This function should be called before the build function from CSLOmCmdSetAttr when the calling object is a register. It sets the m_registerAttr member.
     */
    static void setRegisterAttrParam(ERegDeclAttr param);
    /**
     *Get function for m_registerAttr.
     */
    static ERegDeclAttr getRegisterAttrParam();

};

// ********************************************************************************
// CSLOmCmdGenerateIndividualRTLSignals class
// ********************************************************************************
/**
 * Class that holds a generate_individual_RTL_signals command
 * This class is instantiated from CSLOmSetCommand class build function
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdGenerateIndividualRTLSignals : public CSLOmSetCommand {
  private:
    static TBool m_generateIndividualRTLSignals;

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdGenerateIndividualRTLSignals.
     * Builds and returns an object of type CSLOmCmdGenerateIndividualRTLSignals.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
    static void setBitParam(TBool param);
    static TBool getBitParam();

};

// ********************************************************************************
// CSLOmCmdAddInstanceAll class
// ********************************************************************************
/**
 * Class that holds an instantiation .
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdAddInstanceAll : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdAddInstanceAll.
     * Builds and returns an object of type CSLOmCmdAddInstanceAll.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */

    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * It also check that there are no recursive instantiations(example:
     * \code
     * csl_field f{
     *   f f2;
     *   f(){
     *      set_width(5);
     *   }
     * };
     * \endcode
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */

    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */

    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdAddUnitParameter class
// ********************************************************************************
/**
 * Class that holds a add_unit_parameter command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdAddUnitParameter : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdAddUnitParameter.
     * Builds and returns an object of type CSLOmCmdAddUnitParameter.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdOverrideUnitParameter class
// ********************************************************************************
/**
 * Class that holds a override_parameter command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdOverrideUnitParameter : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:
    static RefCSLOmParameter m_parameter;

    /**
     * Static build function for CSLOmCmdOverrideUnitParameter.
     * Builds and returns an object of type CSLOmCmdOverrideUnitParameter.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdOverrideParameterNamed class
// ********************************************************************************
/**
 * Class that holds the named override from an instantiation.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdOverrideParameterNamed : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

   static map<RefCSLOmParameter, RefCSLOmNumber> m_overrideMap;
    
    /**
     * Static build function for CSLOmCmdOverrideParameterNamed.
     * Builds and returns an object of type CSLOmCmdOverrideParameterNamed.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdOverrideParameterOrdered class
// ********************************************************************************
/**
 * Class that holds a ordered override from an instantiation.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdOverrideParameterOrdered : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    
    static map<RefCSLOmParameter, RefCSLOmNumber> m_overrideMap;
    /**
     * Static build function for CSLOmCmdOverrideParameterOrdered.
     * Builds and returns an object of type CSLOmCmdOverrideParameterOrdered.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdInputVerilogType class
// ********************************************************************************
/**
 * Class that holds a input_verilog_type command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdInputVerilogType : public CSLOmSetCommand {
  private:
    static EVerilogType m_verilogType;

    friend class CSLOmSetCommand;
  private:
    
    /**
     * Static build function for CSLOmCmdInputVerilogType.
     * Builds and returns an object of type CSLOmCmdInputVerilogType.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
    static void setVerilogTypeParam(EVerilogType param);
    static EVerilogType getVerilogTypeParam();

};

// ********************************************************************************
// CSLOmCmdOutputVerilogType class
// ********************************************************************************
/**
 * Class that holds a output_verilog_type command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdOutputVerilogType : public CSLOmSetCommand {
  private:
    static EVerilogType m_verilogType;

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdOutputVerilogType.
     * Builds and returns an object of type CSLOmCmdOutputVerilogType.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
    static void setVerilogTypeParam(EVerilogType param);
    static EVerilogType getVerilogTypeParam();

};

// ********************************************************************************
// CSLOmCmdReverse class
// ********************************************************************************
/**
 * Class that holds a reverse command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdReverse : public CSLOmSetCommand {

    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdReverse.
     * Builds and returns an object of type CSLOmCmdReverse.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

//// ********************************************************************************
//// CSLOmCmdConnect class
//// ********************************************************************************
///**
// * Class that holds a connect command.
// * This class is instantiated from CSLOmSetCommand class build function.
// *
// * @see CSLOmSetCommand
// */
//class CSLOmCmdConnect : public CSLOmSetCommand {
//
//    friend class CSLOmSetCommand;
//  private:
//
//    /**
//     * Static build function for CSLOmCmdConnect.
//     * Builds and returns an object of type CSLOmCmdConnect.
//     *
//     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
//     * @param fileName - type RefString - the file where the command appears in the csl code
//     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
//     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
//     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
//     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
//     *                  they are added by addEnumParam functions
//     *
//     * @see CSLOmBase
//     * @see CSLOmExprLink
//     * @see CSLOmExpr
//     * @see CSLOmSetCommand
//     */
//    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
//
//    /**
//     * Implementation of the CSLOmSetCommand check virtual function.
//     * Checks the validity of the scope and parameters of the command.
//     * This method should be called in the elaborator step before the call of the execute function.
//     *
//     * @see CSLOmSetCommand
//     */
//    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
//
//    /**
//     * Implementation of the CSLOmSetCommand execute virtual function.
//     * Executes the specific command by calling the specific method from the specific class.
//     * This method should be called in the elaborator step after the call of the check function.
//     *
//     * @see CSLOmSetCommand
//     */
//    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
//
//};

/*
 *test bench vector command classes
 */

// ********************************************************************************
// CSLOmCmdSetPrefix class
// ********************************************************************************
class CSLOmCmdSetPrefix : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetPrefix.
     * Builds and returns an object of type CSLOmCmdSetPrefix.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetSuffix class
// ********************************************************************************
class CSLOmCmdSetSuffix : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetSuffix.
     * Builds and returns an object of type CSLOmCmdSetSuffix.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdNoPrefix class
// ********************************************************************************
class CSLOmCmdNoPrefix : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdNoPrefix.
     * Builds and returns an object of type CSLOmCmdNoPrefix.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};



/*
 *stuff for decoder
 */

// ********************************************************************************
// CSLOmCmdSetEnum class
// ********************************************************************************
class CSLOmCmdSetEnum : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetEnum.
     * Builds and returns an object of type CSLOmCmdSetEnum.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
  };

// ********************************************************************************
// CSLOmCmdDecSetDecoder class
// ********************************************************************************
class CSLOmCmdDecSetDecoder : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdDecSetDecoder.
     * Builds and returns an object of type CSLOmCmdDecSetDecoder.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


/*
 *FIFO commands
 */

// ********************************************************************************
// CSLOmCmdFifoAddProgrammableDepth class
// ********************************************************************************
class CSLOmCmdFifoAddProgrammableDepth : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddProgrammableDepth.
     * Builds and returns an object of type CSLOmCmdFifoAddProgrammableDepth.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdFifoSetPhysicalImpType class
// ********************************************************************************
class CSLOmCmdFifoSetPhysicalImpType : public CSLOmSetCommand {
    static CSLOmFifoInfo::EImpType m_impType;
    friend class CSLOmSetCommand;
  private:
    // set and get functions for m_impType.
    void setImpType(CSLOmFifoInfo::EImpType type);
    CSLOmFifoInfo::EImpType getImpType();
    
    /**
     * Static build function for CSLOmCmdFifoSetPhysicalImpType.
     * Builds and returns an object of type CSLOmCmdFifoSetPhysicalImpType.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdFifoAddPrioBypass class
// ********************************************************************************
class CSLOmCmdFifoAddPrioBypass : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddPrioBypass.
     * Builds and returns an object of type CSLOmCmdFifoAddPrioBypass.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdFifoSetAsynch class
// ********************************************************************************
class CSLOmCmdFifoSetAsynch : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoSetAsynch.
     * Builds and returns an object of type CSLOmCmdFifoSetAsynch.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoSetDepthExtend class
// ********************************************************************************
class CSLOmCmdFifoSetDepthExtend : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoSetDepthExtend.
     * Builds and returns an object of type CSLOmCmdFifoSetDepthExtend.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoSetWidthExtend class
// ********************************************************************************
class CSLOmCmdFifoSetWidthExtend : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoSetWidthExtend.
     * Builds and returns an object of type CSLOmCmdFifoSetWidthExtend.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoSetWrHold class
// ********************************************************************************
class CSLOmCmdFifoSetWrHold : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoSetWrHold.
     * Builds and returns an object of type CSLOmCmdFifoSetWrHold.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoSetPrefix class
// ********************************************************************************
class CSLOmCmdFifoSetPrefix : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoSetPrefix.
     * Builds and returns an object of type CSLOmCmdFifoSetPrefix.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoParallelOutput class
// ********************************************************************************
class CSLOmCmdFifoParallelOutput : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoParallelOutput.
     * Builds and returns an object of type CSLOmCmdFifoParallelOutput.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoParallelInput class
// ********************************************************************************
class CSLOmCmdFifoParallelInput : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoParallelInput.
     * Builds and returns an object of type CSLOmCmdFifoParallelInput.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoRdWords class
// ********************************************************************************
class CSLOmCmdFifoRdWords : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoRdWords.
     * Builds and returns an object of type CSLOmCmdFifoRdWords.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoWrWords class
// ********************************************************************************
class CSLOmCmdFifoWrWords : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoWrWords.
     * Builds and returns an object of type CSLOmCmdFifoWrWords.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddSramRd class
// ********************************************************************************
class CSLOmCmdFifoAddSramRd : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddSramRd.
     * Builds and returns an object of type CSLOmCmdFifoAddSramRd.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddSramWr class
// ********************************************************************************
class CSLOmCmdFifoAddSramWr : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddSramWr.
     * Builds and returns an object of type CSLOmCmdFifoAddSramWr.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddPushback class
// ********************************************************************************
class CSLOmCmdFifoAddPushback : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddPushback.
     * Builds and returns an object of type CSLOmCmdFifoAddPushback.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoFlowThrough class
// ********************************************************************************
class CSLOmCmdFifoFlowThrough : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoFlowThrough.
     * Builds and returns an object of type CSLOmCmdFifoFlowThrough.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddStall class
// ********************************************************************************
class CSLOmCmdFifoAddStall : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddStall.
     * Builds and returns an object of type CSLOmCmdFifoAddStall.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddStallRdSide class
// ********************************************************************************
class CSLOmCmdFifoAddStallRdSide : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddStallRdSide.
     * Builds and returns an object of type CSLOmCmdFifoAddStallRdSide.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddStallWrSide class
// ********************************************************************************
class CSLOmCmdFifoAddStallWrSide : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddStallWrSide.
     * Builds and returns an object of type CSLOmCmdFifoAddStallWrSide.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddWrRelease class
// ********************************************************************************
class CSLOmCmdFifoAddWrRelease : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddWrRelease.
     * Builds and returns an object of type CSLOmCmdFifoAddWrRelease.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddAlmostEmpty class
// ********************************************************************************
class CSLOmCmdFifoAddAlmostEmpty : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddAlmostEmpty.
     * Builds and returns an object of type CSLOmCmdFifoAddAlmostEmpty.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddAlmostFull class
// ********************************************************************************
class CSLOmCmdFifoAddAlmostFull : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddAlmostFull.
     * Builds and returns an object of type CSLOmCmdFifoAddAlmostFull.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddOutWrAddr class
// ********************************************************************************
class CSLOmCmdFifoAddOutWrAddr : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddOutWrAddr.
     * Builds and returns an object of type CSLOmCmdFifoAddOutWrAddr.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddOutRdAddr class
// ********************************************************************************
class CSLOmCmdFifoAddOutRdAddr : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddOutRdAddr.
     * Builds and returns an object of type CSLOmCmdFifoAddOutRdAddr.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddCredit class
// ********************************************************************************
class CSLOmCmdFifoAddCredit : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddCredit.
     * Builds and returns an object of type CSLOmCmdFifoAddCredit.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddRdCredit class
// ********************************************************************************
class CSLOmCmdFifoAddRdCredit : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddRdCredit.
     * Builds and returns an object of type CSLOmCmdFifoAddRdCredit.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdFifoAddWrCredit class
// ********************************************************************************
class CSLOmCmdFifoAddWrCredit : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdFifoAddWrCredit.
     * Builds and returns an object of type CSLOmCmdFifoAddWrCredit.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdEnumAddPair class
// ********************************************************************************
class CSLOmCmdEnumAddPair : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdEnumAddPair.
     * Builds and returns an object of type CSLOmCmdEnumAddPair.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdSetValue class
// ********************************************************************************
class CSLOmCmdSetValue : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdSetValue.
     * Builds and returns an object of type CSLOmCmdSetValue.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetEnumItem class
// ********************************************************************************
class CSLOmCmdSetEnumItem : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdSetEnumItem.
     * Builds and returns an object of type CSLOmCmdSetEnumItem.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetPosition class
// ********************************************************************************
/**
 * Class that holds set_posistion and set_field_posistion commands.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetPosition : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdSetPosition.
     * Builds and returns an object of type CSLOmCmdSetPosition.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * This command receives two parameters: a field and a number. The field must be declared or instanciated in the parent field(the field that called the command).
     * The number is the posistion where the field will be placed (the starting position). It cannot be bigger than the width of the parent field. The positions the
     * field will ocupy need to be empty.
     * \n
     * The parent field cannot call twice this method for the same field. The parent field can be a csl_field(in which case the command is set_field_posistion and the 
     * field argument is of type csl_field) or a csl_isa_element(in which case the command is set_posistion and the field argument is of type csl_isa_field).
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};  

// ********************************************************************************
// CSLOmCmdSetNext class
// ********************************************************************************
/**
 * Class that holds a set_next command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetNext : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdSetNext.
     * Builds and returns an object of type CSLOmCmdSetNext.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * This command receives two parameters: two fields. The fields must be declared or instanciated in the parent field(the field that called the command).
     * The first field is the reference field. It should have its position already set.
     * The second field is the field to be set as next. It shouldn't have its posistion set. It will be positioned on the right from the reference field. The positions 
     * it will ocupy need to be empty.
     * \n
     * For example, if the reference field ocupies the positions from 10 to 20 and the second field has a width of 5, then the field will ocupy the positions from 
     * 5 to 9(take into account the fact that the positions are numbered from right to left).
     * \n
     * The parent field cannot call twice this method for the same fields. The parent field can be a csl_field(in which case the field arguments are of type csl_field)
     * or a csl_isa_element(in which case field arguments are of type csl_isa_field).
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetPrevious class
// ********************************************************************************
/**
 * Class that holds a set_previous command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetPrevious : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdSetPrevious.
     * Builds and returns an object of type CSLOmCmdSetPrevious.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * This command receives two parameters: two fields. The fields must be declared or instanciated in the parent field(the field that called the command).
     * The first field is the reference field. It should have its position already set.
     * The second field is the field to be set as previous. It shouldn't have its posistion set. It will be positioned on the left from the reference field. The positions 
     * it will ocupy need to be empty.
     * \n
     * For example, if the reference field ocupies the positions from 10 to 20 and the second field has a width of 5, then the field will ocupy the positions from 
     * 21 to 25(take into account the fact that the positions are numbered from right to left).
     * \n
     * The parent field cannot call twice this method for the same fields. The parent field can be a csl_field(in which case the field arguments are of type csl_field)
     * or a csl_isa_element(in which case field arguments are of type csl_isa_field).
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};


// ********************************************************************************
// CSLOmCmdAddAllowedRange class
// ********************************************************************************
/**
 * Class that holds a add_allowed_range command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdAddAllowedRange : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdAddAllowedRange.
     * Builds and returns an object of type CSLOmCmdAddAllowedRange.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetAccessRights class
// ********************************************************************************
class CSLOmCmdSetAccessRights : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    static CSLOmAddressRange::EAccessRights m_accessRightsType;

    /**
     * Static build function for CSLOmCmdSetAccessRights.
     * Builds and returns an object of type CSLOmCmdSetAccessRights.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    static void setAccessRightsParam(CSLOmAddressRange::EAccessRights param);

    static CSLOmAddressRange::EAccessRights getAccessRightsParam();
};  

// ********************************************************************************
// CSLOmCmdAddAddressRange class
// ********************************************************************************
/**
 * Class that holds a add_address_range command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdAddAddressRange : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    static TBool m_switchValues;

    /**
     * Static build function for CSLOmCmdAddAddressRange.
     * Builds and returns an object of type CSLOmCmdAddAddressRange.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * The command can be called more than one time. The address ranges declared must not overlap.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetAddressIncrement class
// ********************************************************************************
/**
 * Class that holds a set_address_increment command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetAddressIncrement : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetAddressIncrement.
     * Builds and returns an object of type CSLOmCmdSetAddressIncrement.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetNextAddress class
// ********************************************************************************
/**
 * Class that holds a set_next_address command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetNextAddress : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetNextAddress.
     * Builds and returns an object of type CSLOmCmdSetNextAddress.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdAddReservedRange class
// ********************************************************************************
/**
 * Class that holds a add_reserved_range command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdAddReservedRange : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdAddReservedRange.
     * Builds and returns an object of type CSLOmCmdAddReservedRange.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This command needs to be called after set_address_range command. It marks a part of the address range as "reserved". That part of the address range must be 
     * free, not reserved and legal.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdAdd class
// ********************************************************************************
/**
 * Class that holds a add command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdAdd : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdAdd.
     * Builds and returns an object of type CSLOmCmdAdd.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetDataWordWidth class
// ********************************************************************************
/**
 * Class that holds a set_range command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetDataWordWidth : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetDataWordWidth.
     * Builds and returns an object of type CSLOmCmdSetDataWordWidth.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetAlignment class
// ********************************************************************************
/**
 * Class that holds a set_alignment command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetAlignment : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetAlignment.
     * Builds and returns an object of type CSLOmCmdSetAlignment.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * Only one argument: a number. It must be a multiple of the data word width.
     * \ne
     * The command must be called after the set_data_word_width command.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetEndianess class
// ********************************************************************************
/**
 * Class that holds a set_endianess command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetEndianess : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    static CSLOmMemoryMapPage::Endianess m_endianessType;

    /**
     * Static build function for CSLOmCmdSetEndianess.
     * Builds and returns an object of type CSLOmCmdSetEndianess.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    static void setEndianessParam(CSLOmMemoryMapPage::Endianess param);

    static CSLOmMemoryMapPage::Endianess getEndianessParam();

};

// ********************************************************************************
// CSLOmCmdSetSymbolMaxLength class
// ********************************************************************************
/**
 * Class that holds a set_symbol_max_length command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetSymbolMaxLength : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetSymbolMaxLength.
     * Builds and returns an object of type CSLOmCmdSetSymbolMaxLength.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdAutoGenMemMap class
// ********************************************************************************
/**
 * Class that holds am auto_gen_mem_map command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdAutoGenMemMap : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdAutoGenMemMap.
     * Builds and returns an object of type CSLOmCmdAutoGenMemMap.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetTopUnit class
// ********************************************************************************
/**
 * Class that holds a set_top_unit command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetTopUnit : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetTopUnit.
     * Builds and returns an object of type CSLOmCmdSetTopUnit.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdAddToMemoryMap class
// ********************************************************************************
/**
 * Class that holds an add_to_memory_map command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdAddToMemoryMap : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdAddToMemoryMap.
     * Builds and returns an object of type CSLOmCmdAddToMemoryMap.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetAccessRightsEnum class
// ********************************************************************************
/**
 * Class that holds a set_access_rights_enum command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetAccessRightsEnum : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetAccessRightsEnum.
     * Builds and returns an object of type CSLOmCmdSetAccessRightsEnum.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetInstanceName class
// ********************************************************************************
/**
 * Class that holds a set_instance_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetInstanceName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetInstanceName.
     * Builds and returns an object of type CSLOmCmdSetInstanceName.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetPageNo class
// ********************************************************************************
/**
 * Class that holds a set_page_no command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetPageNo : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetPageNo.
     * Builds and returns an object of type CSLOmCmdSetPageNo.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetAsmMnemonic class
// ********************************************************************************
/**
 * Class that holds a set_mnemonic_no command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetAsmMnemonic : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetAsmMnemonic.
     * Builds and returns an object of type CSLOmCmdSetAsmMnemonic.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetDecoderName class
// ********************************************************************************
/**
 * Class that holds a set_decoder_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetDecoderName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetDecoderName.
     * Builds and returns an object of type CSLOmCmdSetDecoderName.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetDecoderOutNamePrefix class
// ********************************************************************************
/**
 * Class that holds a set_decoder_out_name_prefix command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetDecoderOutNamePrefix : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetDecoderOutNamePrefix.
     * Builds and returns an object of type CSLOmCmdSetDecoderOutNamePrefix.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdSetDecoderOutNameSuffix class
// ********************************************************************************
/**
 * Class that holds a command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetDecoderOutNameSuffix : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetDecoderOutNameSuffix.
     * Builds and returns an object of type CSLOmCmdSetDecoderOutNameSuffix.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdPrint class
// ********************************************************************************
/**
 * Class that holds a print command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdPrint : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdPrint.
     * Builds and returns an object of type CSLOmCmdPrint.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};


// ********************************************************************************
// CSLOmCmdSetName class
// ********************************************************************************
/**
 * Class that holds a set_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdSetName.
     * Builds and returns an object of type CSLOmCmdSetName.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};


/*
 *Vector or StateData command classes
 */


// ********************************************************************************
// CSLOmCmdVSDSetRadix class
// ********************************************************************************
/**
 * Class that holds a set_radix command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetRadix : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    static CSLOmVerifCompInfo::ECSLOmVCRadix m_radixEnum;
    /**
     * Static build function for CSLOmCmdVSDSetRadix.
     * Builds and returns an object of type CSLOmCmdVSDSetRadix.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
  public:
    static void setRadixTypeParam(CSLOmVerifCompInfo::ECSLOmVCRadix param);
    static CSLOmVerifCompInfo::ECSLOmVCRadix getRadixTypeParam();
};



// ********************************************************************************
// CSLOmCmdVSDSetCaptureEdgeType class
// ********************************************************************************
/**
 * Class that holds a set_vc_capture_edge_type command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetCaptureEdgeType : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    static CSLOmVerifCompInfo::ECSLOmVCEdgeType m_edgeEnum;
    /**
     * Static build function for CSLOmCmdVSDSetCaptureEdgeType.
     * Builds and returns an object of type CSLOmCmdVSDSetCaptureEdgeType.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
  public:
    static void setEdgeTypeParam(CSLOmVerifCompInfo::ECSLOmVCEdgeType param);
    static CSLOmVerifCompInfo::ECSLOmVCEdgeType getEdgeTypeParam();
};



// ********************************************************************************
// CSLOmCmdVSDSetNumericID class
// ********************************************************************************
/**
 * Class that holds a set_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetNumericID : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetNumericID.
     * Builds and returns an object of type CSLOmCmdVSDSetNumericID.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetVersion class
// ********************************************************************************
/**
 * Class that holds a set_version command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetVersion : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetVersion.
     * Builds and returns an object of type CSLOmCmdVSDSetVersion.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetMaxEventsCount class
// ********************************************************************************
/**
 * Class that holds a set_ command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetMaxEventsCount : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetMaxEventsCount.
     * Builds and returns an object of type CSLOmCmdVSDSetMaxEventsCount.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetMaxMismatchesCount class
// ********************************************************************************
/**
 * Class that holds a set_vc_max_number_of_mismatches command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetMaxMismatchesCount : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetMaxMismatchesCount.
     * Builds and returns an object of type CSLOmCmdVSDSetMaxMismatchesCount.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetTimeout class
// ********************************************************************************
/**
 * Class that holds a set_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetTimeout : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetTimeout.
     * Builds and returns an object of type CSLOmCmdVSDSetTimeout.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetMaxNumStates class
// ********************************************************************************
/**
 * Class that holds a set_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetMaxNumStates : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetMaxNumStates.
     * Builds and returns an object of type CSLOmCmdVSDSetMaxNumStates.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetNumOfTransaction class
// ********************************************************************************
/**
 * Class that holds a set_vc_max_number_of_valid_transactions command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetNumOfTransaction : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetNumOfTransaction.
     * Builds and returns an object of type CSLOmCmdVSDSetNumOfTransaction.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetName class
// ********************************************************************************
/**
 * Class that holds a set_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetName.
     * Builds and returns an object of type CSLOmCmdVSDSetName.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetHeaderComment class
// ********************************************************************************
/**
 * Class that holds a set_vc_header_comment command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetHeaderComment : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetHeaderComment.
     * Builds and returns an object of type CSLOmCmdVSDSetHeaderComment.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetOutputFilename class
// ********************************************************************************
/**
 * Class that holds a set_vc_output_filename command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetOutputFilename : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetOutputFilename.
     * Builds and returns an object of type CSLOmCmdVSDSetOutputFilename.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetCppRDName class
// ********************************************************************************
/**
 * Class that holds a set_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetCppRDName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetCppRDName.
     * Builds and returns an object of type CSLOmCmdVSDSetCppRDName.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetCppWRName class
// ********************************************************************************
/**
 * Class that holds a set_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetCppWRName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetCppWRName.
     * Builds and returns an object of type CSLOmCmdVSDSetCppWRName.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetClock class
// ********************************************************************************
/**
 * Class that holds a set_vc_clock command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetClock : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetClock.
     * Builds and returns an object of type CSLOmCmdVSDSetClock.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetReset class
// ********************************************************************************
/**
 * Class that holds a set_vc_reset command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetReset : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetReset.
     * Builds and returns an object of type CSLOmCmdVSDSetReset.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetStall class
// ********************************************************************************
/**
 * Class that holds a set_vc_stall command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetStall : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetStall.
     * Builds and returns an object of type CSLOmCmdVSDSetStall.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetCompareTrigger class
// ********************************************************************************
/**
 * Class that holds a set_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetCompareTrigger : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetCompareTrigger.
     * Builds and returns an object of type CSLOmCmdVSDSetCompareTrigger.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetStartGenerationTrigger class
// ********************************************************************************
/**
 * Class that holds a set_vc_start_generation_trigger command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetStartGenerationTrigger : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetStartGenerationTrigger.
     * Builds and returns an object of type CSLOmCmdVSDSetStartGenerationTrigger.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdVSDSetEndGenerationTrigger class
// ********************************************************************************
/**
 * Class that holds a set_vc_end_generation_trigger command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetEndGenerationTrigger : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetEndGenerationTrigger.
     * Builds and returns an object of type CSLOmCmdVSDSetEndGenerationTrigger.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdVSDSetModuleName class
// ********************************************************************************
/**
 * Class that holds a set_unit_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetModuleName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetEndGenerationTrigger.
     * Builds and returns an object of type CSLOmCmdVSDSetEndGenerationTrigger.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * The command can be called by a vector.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdVSDSetInstanceName class
// ********************************************************************************
/**
 * Class that holds a set_mem_instance_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetInstanceName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetEndGenerationTrigger.
     * Builds and returns an object of type CSLOmCmdVSDSetEndGenerationTrigger.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};

// ********************************************************************************
// CSLOmCmdVSDSetAddPortSigIfc class
// ********************************************************************************
/**
 * Class that holds a set_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetAddPortSigIfc : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdVSDSetEndGenerationTrigger.
     * Builds and returns an object of type CSLOmCmdVSDSetEndGenerationTrigger.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};


// ********************************************************************************
// CSLOmCmdVSDSetDirection class
// ********************************************************************************
/**
 * Class that holds a set_direction command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDSetDirection : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Variable set in TW that contains the direction for the ports in the unit attached to the vector.
     */
    static ECSLOmPortDirection m_direction;
    /**
     * Static build function for CSLOmCmdVSDSetDirection.
     * Builds and returns an object of type CSLOmCmdVSDSetDirection.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * The command can be called by a vector object after the set_module_name method has been called. 
     * \n
     * It receives no arguments since the direction is sent through a addEnumParam method.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
 
 public:
    static void setDirectionParam(ECSLOmPortDirection param);
    static ECSLOmPortDirection getDirectionParam();
};

// ********************************************************************************
// CSLOmCmdVSDExcludeOnly class
// ********************************************************************************
/**
 * Class that holds a exclusion_list command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDExcludeOnly : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    static RefTVec_TInt portPositions;
    /**
     * Static build function for CSLOmCmdVSDExcludeOnly.
     * Builds and returns an object of type CSLOmCmdVSDExcludeOnly.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * The command can be called by a vector object, after the set_module_name and set_direction commands have been called,
     * and has only one argument: a port, an interface or a list of ports/interfaces.
     * The ports/interfaces received as arguments must be from the unit set with set_module_name command 
     * \n
     * Because the ports/interfaces come without the unit prefix(for example, if a is the unit and p the port,
     * they come as p and not as a.p), the name of the unit is added to all the arguments received. 
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdVSDIncludeOnly class
// ********************************************************************************
/**
 * Class that holds a include_only command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDIncludeOnly : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    static RefTVec_TInt portPositions;
    /**
     * Static build function for CSLOmCmdVSDIncludeOnly.
     * Builds and returns an object of type CSLOmCmdVSDIncludeOnly.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * The command is called by a vector after the set_module_name and set_direction commands have been called. It can receive only
     * one argument: a port, a interface or a list of ports/interfaces. The ports/interfaces received as arguments must be from the 
     * unit set with set_module_name command Because the ports/interfaces come without the unit prefix(for example, if a is the unit and p the port,
     * they come as p and not as a.p), the name of the unit is added to all the arguments received.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
 
};

// ********************************************************************************
// CSLOmCmdVSDMaxCycles class
// ********************************************************************************
/**
 * Class that holds a set_vc_max_cycles command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdVSDMaxCycles : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdVSDMaxCycles.
     * Builds and returns an object of type CSLOmCmdVSDMaxCycles.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};





//testbench info classes:


// ********************************************************************************
// CSLOmCmdTBAddLogic class
// ********************************************************************************
/**
 * Class that holds a add_logic command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdTBAddLogic : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Variable that holds the first parameter of the command add_logic. It is an enum item and it is transmitted through the addEnumItem method from 
     * CSLOmSetCommand class.
     *
     * @see CSLOmSetCommand
     * @see CSLOmTBInfo::ETBOperType
     */
    static CSLOmTBInfo::ETBOperType m_operType;
    /**
     * Variable used only when the m_operType is TB_OPER_GENERATE_WAVES. It is an enum item and it is transmitted through the addEnumItem method from 
     * CSLOmSetCommand class.
     *
     * @see CSLOmSetCommand
     * @see CSLOmTBInfo::ETBWaveType
     */
    static CSLOmTBInfo::ETBWaveType m_waveType;
    /**
     * Variable used only when the m_operType is TB_OPER_CLOCK. It is an enum item and it is transmitted through the addEnumItem method from 
     * CSLOmSetCommand class.
     *
     * @see CSLOmSetCommand
     * @see CSLOmTBInfo::ETBTimeBase
     */
    static CSLOmTBInfo::ETBTimeBase m_timeBase;
    /**
     * Variable used only when the m_operType is TB_OPER_GENERATE_REPORT. It is an enum item and it is transmitted through the addEnumItem method from 
     * CSLOmSetCommand class.
     *
     * @see CSLOmSetCommand
     * @see CSLOmTBInfo::ETBReportType
     */
    static CSLOmTBInfo::ETBReportType m_reportType;
    /**
     * Static build function for CSLOmCmdTBAddLogic.
     * Builds and returns an object of type CSLOmCmdTBAddLogic.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

  public:
    static void setOperType(CSLOmTBInfo::ETBOperType incOperType);
    static void setWaveType(CSLOmTBInfo::ETBWaveType incWaveType);
    static void setTimeBase(CSLOmTBInfo::ETBTimeBase incTimeBase);
    static void setReportType(CSLOmTBInfo::ETBReportType incReportType);
   
    static CSLOmTBInfo::ETBOperType  getOperType();
    static CSLOmTBInfo::ETBWaveType  getWaveType();
    static CSLOmTBInfo::ETBTimeBase  getTimeBase();
    static CSLOmTBInfo::ETBReportType  getReportType();
   
};




// ********************************************************************************
// CSLOmCmdTBAddVerilogFilename class
// ********************************************************************************
/**
 * Class that holds a set_testbench_verilog_filename command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdTBAddVerilogFilename : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdTBAddVerilogFilename.
     * Builds and returns an object of type CSLOmCmdTBAddVerilogFilename.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdTBSetInstanceName class
// ********************************************************************************
/**
 * Class that holds a set_instance_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdTBSetInstanceName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:

    /**
     * Static build function for CSLOmCmdTBSetInstanceName.
     * Builds and returns an object of type CSLOmCmdTBSetInstanceName.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param hid - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
};



// ********************************************************************************
// CSLOmCmdAddLogic class
// ********************************************************************************
/**
 * Class that holds a add_logic command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdAddLogic : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Variable set in TW that stores the first parameter(an enum item) of the add_logic command for register. It is set through the addEnumParam method from CSLOmSetCommand.
     *
     * @see CSLOmSetCommand
     */
    static CSLOmRegDeclInfo::ERegDeclOperations m_regOperType;
    static CSLOmRegDeclInfo::ERegDeclCntDir m_cntDir;
    /**
     * Static build function for CSLOmCmdAddLogic.
     * Builds and returns an object of type CSLOmCmdAddLogic.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param scope - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * The command is called by a register object. The number of parameters received depend on the m_regOperType value.
     * \n
     * \li REG_OPER_GRAY_OUTPUT: it can only be called by a register of type counter.
     * \li REG_OPER_INIT: it can only be called by a register of type counter.
     * \li REG_OPER_SET: it can only be called by a register of type counter.
     * \li REG_OPER_RESET: it can only be called by a register of type register.
     * \li REG_OPER_CLEAR: it can only be called by a register of type register.
     * \li REG_OPER_COUNT_AMOUNT: it can only be called by a register of type counter. It has to be bigger than 0. 
     * \li REG_OPER_STOP_VALUE: it can only be called by a register of type counter. 
     * \li REG_OPER_START_VALUE: it can only be called by a register of type counter. If the count_direction is UP, it has to be smaller than the end_value. Else, it has 
     *                       to be bigger than the end_value.
     * \li REG_OPER_END_VALUE: it can only be called by a register of type counter. If the count_direction is UP, it has to be bigger than the start_value. Else, it has 
     *                     to be smaller than the start_value.
     * \li REG_OPER_DIR_CONTROL: it has to be called by a register of type counter.
     *
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);
  public:
    static void setRegOperType(CSLOmRegDeclInfo::ERegDeclOperations operType);
    static CSLOmRegDeclInfo::ERegDeclOperations getRegOperType();
    static void setRegCntDir(CSLOmRegDeclInfo::ERegDeclCntDir);
    static CSLOmRegDeclInfo::ERegDeclCntDir getRegCntDir();
};



///
//Register File
///

// ********************************************************************************
// CSLOmCmdRFSetField class
// ********************************************************************************
/**
 * Class that holds a set_field command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdRFSetField : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdRFSetField.
     * Builds and returns an object of type CSLOmCmdRFSetField.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param scope - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};




// ********************************************************************************
// CSLOmCmdRFSetGroupName class
// ********************************************************************************
/**
 * Class that holds a set_group_name command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdRFSetGroupName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdRFSetGroupName.
     * Builds and returns an object of type CSLOmCmdRFSetGroupName.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param scope - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdRFSetConstValue class
// ********************************************************************************
/**
 * Class that holds a set_const_value command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdRFSetConstValue : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
  private:
    /**
     * Static build function for CSLOmCmdRFSetConstValue.
     * Builds and returns an object of type CSLOmCmdRFSetConstValue.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param scope - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * The command must receive only one argument: a number. The command can be called only by a register file.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdSetPortName class
// ********************************************************************************
/**
 * Class that holds a set_(port)_name command, where (port) can be:
 * RF: reset, clock, wr_data, rd_data, wr_addr, rd_addr, wr_en, rd_en, valid.
 * FIFO: pop, push, full, empty, clock, wr_clock, rd_clock, wr_data, rd_data, valid, reset.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetPortName : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
    
  private:

    /**
     *String used to retain the name of the commands that is called. It can have one of the following values:
     * \n
     * \li - set_reset_name
     * \li - set_clock_name
     * \li - set_wr_data_name
     * \li - set_rd_data_name
     * \li - set_wr_addr_name
     * \li - set_rd_addr_name
     * \li - set_wr_en_name
     * \li - set_rd_en_name
     * \li - set_valid_name
     * \li - set_pop_name
     * \li - set_push_name
     * \li - set_full_name
     * \li - set_empty_name
     * \li - set_rd_clock_name
     * \li - set_wr_clock_name
     * \n
     * The value is set in CSLOmSetCommand::build function and it depends on the keyword sent by the Tree Walker.
     *
     * @see CSLOmSetCommand
     * @see CSLOmRegisterFileInfo
     * @see CSLOmFifoInfo
     */
    static std::string m_message;
    /**
     * Enum item that retains the port name.
     */
    static EPortNames m_portName;
    /**
     * Function used to set the value of m_portName and m_message members. It is called by the CSLOmSetCommand::build function.
     *
     * @see ERFPortNames
     * @see CSLOmSetCommand
     */
    static void setPort(EPortNames name);
    /**
     * @return member variable m_portName
     */
    static EPortNames getPortName();
    /**
     * @return member variable m_message.
     */
    static std::string getMessage();
    /**
     * Static build function for CSLOmCmdSetPortName.
     * Builds and returns an object of type CSLOmCmdSetPortName.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param scope - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * The command must receive only one argument: a string. The command can be called only by a register file or fifo.
     * The string must not be empty. Also, it must be different from the names of the other ports(two ports cannot have the same name).
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};



//
//interconnect
//


// ********************************************************************************
// CSLOmCmdNoGenRTL class
// ********************************************************************************
/**
 * Class that holds a do_not_gen_rtl() command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdNoGenRTL : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
    
  private:
    /**
     * Static build function for CSLOmCmdNoGenRTL.
     * Builds and returns an object of type CSLOmCmdNoGenRTL.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param scope - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * The command cannot receive any arguments.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};

// ********************************************************************************
// CSLOmCmdGenUniqueRTLModules class
// ********************************************************************************
/**
 * Class that holds a gen_unique_rtl_modules command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdGenUniqueRTLModules : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
    
  private:

    /**
     * Static build function for CSLOmCmdGenUniqueRTLModules.
     * Builds and returns an object of type CSLOmCmdGenUniqueRTLModules.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param scope - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * The command cannot receive any arguments. The scope parent must be a csl_unit.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdSetClock class
// ********************************************************************************
/**
 * Class that holds a set_clock command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdSetClock : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
    
  private:

    /**
     * Static build function for CSLOmCmdSetClock.
     * Builds and returns an object of type CSLOmCmdSetClock.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param scope - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * The command must receive only one argument: an identifier. The scope parent can be a csl_unit or a connectable object.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


// ********************************************************************************
// CSLOmCmdRegisterIOS class
// ********************************************************************************
/**
 * Class that holds a register_IOS()  command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdRegisterIOS : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
    
  private:

    /**
     * Static build function for CSLOmCmdRegisterIOS.
     * Builds and returns an object of type CSLOmCmdRegisterIOS.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param scope - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * The command cannot receive any arguments. The scope parent must be a csl_unit.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};



// ********************************************************************************
// CSLOmCmdDoNotGenCPP class
// ********************************************************************************
/**
 * Class that holds a do_not_gen_cpp()  command.
 * This class is instantiated from CSLOmSetCommand class build function.
 *
 * @see CSLOmSetCommand
 */
class CSLOmCmdDoNotGenCPP : public CSLOmSetCommand {
    friend class CSLOmSetCommand;
    
  private:

    /**
     * Static build function for CSLOmCmdDoNotGenCPP.
     * Builds and returns an object of type CSLOmCmdDoNotGenCPP.
     *
     * @param lineNumber - type TLineNumberType - the line number where the command appears in the CSL code
     * @param fileName - type RefString - the file where the command appears in the csl code
     * @param parent - type RefCSLOmBase - the parent of the command object, this must be a CSLOmDesign or a CSLOmScopeBlock object
     * @param scope - type RefCSLOmExprLink - the scope of the command, the object for which the command has been called
     * @param params - type RefTVec_RefCSLOmExpr - the params given to the command(in the order they appear)
     *                  remember that the enum params(INPUT..  SIGNAL_WIRE.. ) are not included in this list of expressions
     *                  they are added by addEnumParam functions
     *
     * @see CSLOmBase
     * @see CSLOmExprLink
     * @see CSLOmExpr
     * @see CSLOmSetCommand
     */
    static void build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand check virtual function.
     * Checks the validity of the scope and parameters of the command.
     * \n
     * The command cannot receive any arguments. The scope parent must be a csl_unit.
     * \n
     * This method should be called in the elaborator step before the call of the execute function.
     *
     * @see CSLOmSetCommand
     */
    static TBool check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

    /**
     * Implementation of the CSLOmSetCommand execute virtual function.
     * Executes the specific command by calling the specific method from the specific class.
     * This method should be called in the elaborator step after the call of the check function.
     *
     * @see CSLOmSetCommand
     */
    static void execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params);

};


} //namespace NSCSLOm

#endif //INC_GUARD_CSLOM_CMD_h
