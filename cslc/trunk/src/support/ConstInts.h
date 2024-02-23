//---------------------------------------------------------------------
// Copyright (c) 2007, 2008 Fastpath Logic, Inc.
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

/**
 * Author: Bogdan Zamfir <bogdanz@fplsrl.com>
 */

#ifndef INC_GUARD_CONST_INT_h
#define INC_GUARD_CONST_INT_h

// ********************************************************************************
// default const int
// ********************************************************************************

const unsigned int MAX_UNSIGNED_INT             = ~0;
const int MAX_INT                               = ~(1 << (sizeof(int) * 8 - 1));
const int ZERO                                  = 0;
const unsigned int ONE                          = 1;
const int MAX_VALUE                             = 512;
const int FAIL                                  = 0;
//const int NULL_REF = 0;

// ********************************************************************************
// cslom const int
// ********************************************************************************
const unsigned int ID                                    = 0;

const unsigned int DIM_OFFSET                            = 0;
const unsigned int DIM_LOWER                             = 1;
const unsigned int DIM_UPPER                             = 2;

const unsigned int BR_OFFSET                             = 1;
const unsigned int BR_LOWER                              = 3;
const unsigned int BR_UPPER                              = 2;
const unsigned int NO_OF_DIMS                            = 1;
const unsigned int FIRST_DIM                             = 2;

const unsigned int PORT_BR                               = 1;
const unsigned int SIGNAL_BR                             = 1;

const unsigned int DEFAULT_VALUE                         = 1;
const unsigned int OVERRIDE_VALUE                        = 0;

const unsigned int DECL_LINK                             = 0;
const unsigned int LIST_FIRST_ITEM                       = 1;

const unsigned int FUNCTION_PARAMS                       = 0;

const unsigned int DEFAULT_IFC                           = 1;
const unsigned int UNIT_INFO                             = 2;
const unsigned int DEFAULT_VECTOR                        = 0;

const int WIDTH                                 = 1;

const int MEM_DEF_WIDTH                         = -1;
const int MEM_DEF_DEPTH                         = -1;

const unsigned int MEM_DEF_NO_RD_IFC                     = 1;
const unsigned int MEM_DEF_NO_WR_IFC                     = 1;

const unsigned int CONCAT_EXPR                           = 1;

const unsigned int EXPR0                                 = 0;
const unsigned int EXPR1                                 = 1;
const unsigned int EXPR2                                 = 2;

const unsigned int EXPR_LINK_BR                          = 0;

const unsigned int UPDATE_EXPR                           = 1;
const unsigned int RESET_EXPR                            = 2;

const unsigned int DESIGN_SCOPE                          = 0;

const unsigned int STMT_ASSIGN_LHS                       = 0;
const unsigned int STMT_ASSIGN_RHS                       = 1;

const unsigned int LOWER_INIT_VALUE                      = 0;
const unsigned int UPPER_INIT_VALUE                      = 0;
const unsigned int FIRST_ADDR                            = 0;

const int DEFAULT_ADDRESS_WIDTH                 = 1;
const int DEFAULT_WORD_WIDTH                    = 8;
const int DEFAULT_INC_AMOUNT                    = 1;

const unsigned int RANGE_OFFSET                          = 1;
const unsigned int RANGE_LOWER                           = 2;
const unsigned int RANGE_UPPER                           = 3;

const unsigned int RANGE_OFFSET_WO_ID                    = 0;
const unsigned int RANGE_LOWER_WO_ID                     = 1;
const unsigned int RANGE_UPPER_WO_ID                     = 2;

const unsigned int MEM_MAP_LOC_GLOBAL_ADDR               = 1;
const unsigned int MEM_MAP_LOC_LOCAL_ADDR                = 2;

const unsigned int MEM_MAP_LOC_PAGE_LEGAL                = 1;
const unsigned int MEM_MAP_LOC_PAGE_RESERVED             = 2;
const unsigned int MEM_MAP_LOC_PAGE_FREE                 = 3;
const unsigned int MEM_MAP_LOC_PAGE_ACC_RIGHTS           = 4;

const unsigned int MEM_MAP_PAGE_EXPR                     = 1;
const unsigned int MEM_MAP_PAGE_UNIT_INST                = 2;

const unsigned int MEM_MAP_AR_ENUM                       = 1;

const unsigned int FIELD_POS_IDENTIFIER                  = 0;
const unsigned int FIELD_POS_OFFSET                      = 1;
const unsigned int FIELD_POS_LOWER                       = 2;
const unsigned int FIELD_POS_UPPER                       = 3;
const unsigned int FIELD_POS_RANGES                      = 4;
const unsigned int FIELD_POS_VALUE                       = 5;
const unsigned int FIELD_POS_ENUM                        = 5;
const unsigned int FIELD_POS_ENUM_ITEM                   = 5;

const unsigned int ISA_IDENTIFIER                        = 0;
const unsigned int ISA_WIDTH                             = 1;
const unsigned int ISA_INSTRUCTION_FORMATS               = 3;
const unsigned int ISA_INSTRUCTIONS                      = 4;

const unsigned int ISA_INSTRUCTION_FORMAT_IDENTIFIER     = 0;
const unsigned int ISA_INSTRUCTION_FORMAT_WIDTH          = 1;
const unsigned int ISA_INSTRUCTION_FORMAT_INSERT_POS     = 2;

const unsigned int ISA_INSTRUCTION_IDENTIFIER            = 0;
const unsigned int ISA_INSTRUCTION_FORMAT                = 1;

//added by Tb
const int INFO_CLASS_MAP_INDEX_NOT_SET                   =-1;
const int INFO_CLASS_MAP_INDEX_NOT_FOUND                 =-2;

const unsigned int VERIF_COMP_ID                         = 0;
const unsigned int VERIF_COMP_MAX_OBJECT_COUNT           = 1;
const unsigned int VERIF_COMP_MAX_ERROR_COUNT            = 2;
//~added by Tb

//added by eugennc
//***************
const unsigned int PARAM_CHILDREN_COUNT                  = 2;
const unsigned int PARAM_VALUE_CHILD_POS                 = 1;
//***************



// *******************************************************************************
// cdom const int
// *******************************************************************************
 
const int BIT_ONE      = 1;
const int HEX_VEC_LEN  = 16;
const int OCT_VEC_LEN  = 8;

//added by Tb
const int VERINUM_BIT_SIZE     = 2;
const int VERINUM_DEFAULT_SIZE = 32;
const int VERINUM_DEC_Z        = 16;
const int VERINUM_DEC_X        = 37;
//added by Tb

//CSLOmCmd CheckParentType
const unsigned int PARENT_TYPE_SIZE_SETWIDTH                       = 8;
const unsigned int PARENT_TYPE_SIZE_SETDEPTH                       = 3;
const unsigned int PARENT_TYPE_SIZE_SETBITRANGE                    = 3;
const unsigned int PARENT_TYPE_SIZE_SETOFFSET                      = 4;
const unsigned int PARENT_TYPE_SIZE_SETRANGE                       = 4;
const unsigned int PARENT_TYPE_SIZE_SETNUMBEROFDIMENSIONS          = 2;
const unsigned int PARENT_TYPE_SIZE_SETDIMWIDTH                    = 3-1;
const unsigned int PARENT_TYPE_SIZE_SETDIMBITRANGE                 = 3-1;
const unsigned int PARENT_TYPE_SIZE_SETDIMOFFSET                   = 3-1;
const unsigned int PARENT_TYPE_SIZE_SETDIMRANGE                    = 3-1;
const unsigned int PARENT_TYPE_SIZE_SETUNITPREFIX                  = 2-1;
const unsigned int PARENT_TYPE_SIZE_SETUNITNAME                    = 3;
const unsigned int PARENT_TYPE_SIZE_SETSIGNALPREFIX                = 2-1;
const unsigned int PARENT_TYPE_SIZE_SETSIGNALPREFIXLOCAL           = 2-1;
const unsigned int PARENT_TYPE_SIZE_SETTYPE                        = 7;
const unsigned int PARENT_TYPE_SIZE_SETATTR                        = 3;
const unsigned int PARENT_TYPE_SIZE_GENERATEINDIVIDUALRTLSIGNALS   = 0;
const unsigned int PARENT_TYPE_SIZE_ADDINSTANCEALL                 = 10;
const unsigned int PARENT_TYPE_SIZE_ADDUNITPARAMETER               = 1;
const unsigned int PARENT_TYPE_SIZE_OVERRIDEUNITPARAMETER          = 1;
const unsigned int PARENT_TYPE_SIZE_OVERRIDEPARAMETER              = 3;
const unsigned int PARENT_TYPE_SIZE_INPUTVERILOGTYPE               = 1;
const unsigned int PARENT_TYPE_SIZE_OUTPUTVERILOGTYPE              = 1;
const unsigned int PARENT_TYPE_SIZE_REVERSE                        = 2;
const unsigned int PARENT_TYPE_SIZE_SETPREFIX                      = 2;
const unsigned int PARENT_TYPE_SIZE_SETSUFFIX                      = 2;
const unsigned int PARENT_TYPE_SIZE_NOPREFIX                       = 2;
const unsigned int PARENT_TYPE_SIZE_SETVALUE                       = 1;
const unsigned int PARENT_TYPE_SIZE_SETID                          = 1;
const unsigned int PARENT_TYPE_SIZE_ADDCOMMENT                     = 1;
const unsigned int PARENT_TYPE_SIZE_SETMAXNUMVECTORS               = 1;
const unsigned int PARENT_TYPE_SIZE_SETSOURCE                      = 1;
const unsigned int PARENT_TYPE_SIZE_CONNECT                        = 1;
const unsigned int PARENT_TYPE_SIZE_ADDRESET                       = 1;
const unsigned int PARENT_TYPE_SIZE_ADDSIGNAL                      = 1;
const unsigned int PARENT_TYPE_SIZE_SETDIMLOWERINDEX               = 3-1;
const unsigned int PARENT_TYPE_SIZE_SETDIMUPPERINDEX               = 3-1;
const unsigned int PARENT_TYPE_SIZE_ADDTBVSIGNAL                   = 1;
const unsigned int PARENT_TYPE_SIZE_ADDSIGNALGROUP                 = 1;
const unsigned int PARENT_TYPE_SIZE_ADDTBVSIGNALGROUP              = 1;
const unsigned int PARENT_TYPE_SIZE_SETMAXERRORCOUNT               = 1;
const unsigned int PARENT_TYPE_SIZE_DECSETDECODER                  = 2;
const unsigned int PARENT_TYPE_SIZE_FIFOADDPROGRAMMABLEDEPTH       = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOSETPHYSICALIMPTYPE         = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDPRIOBYPASS              = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOSETASYNCH                  = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOSETDEPTHEXTEND             = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOSETWIDTHEXTEND             = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOSETWRHOLD                  = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOPARALLELOUTPUT             = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOPARALLELINPUT              = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFORDWORDS                    = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOWRWORDS                    = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDSRAMRD                  = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDSRAMWR                  = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDPUSHBACK                = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOFLOWTHROUGH                = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDSTALL                   = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDSTALLRDSIDE             = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDSTALLWRSIDE             = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDWRRELEASE               = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDALMOSTEMPTY             = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDALMOSTFULL              = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDOUTWRADDR               = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDOUTRDADDR               = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDCREDIT                  = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDRDCREDIT                = 2-1;
const unsigned int PARENT_TYPE_SIZE_FIFOADDWRCREDIT                = 2-1;
const unsigned int PARENT_TYPE_SIZE_ENUMADDPAIR                    = 2-1;
const unsigned int PARENT_TYPE_SIZE_SETENUM                        = 2-1;
const unsigned int PARENT_TYPE_SIZE_SETENUMITEM                    = 1-1;
const unsigned int PARENT_TYPE_SIZE_SETACCESSRIGHTS                = 1;
const unsigned int PARENT_TYPE_SIZE_ADDADDRESSRANGE                = 2-1;
const unsigned int PARENT_TYPE_SIZE_SETADDRESSINCREMENT            = 1;
const unsigned int PARENT_TYPE_SIZE_SETNEXTADDRESS                 = 2-1;
const unsigned int PARENT_TYPE_SIZE_ADDRESERVEDRANGE               = 1;
const unsigned int PARENT_TYPE_SIZE_ADD                            = 1;
const unsigned int PARENT_TYPE_SIZE_SETDATAWORDWIDTH               = 2;
const unsigned int PARENT_TYPE_SIZE_SETALIGNMENT                   = 1;
const unsigned int PARENT_TYPE_SIZE_SETENDIANESS                   = 1;
const unsigned int PARENT_TYPE_SIZE_SETSYMBOLMAXLENGTH             = 1;
const unsigned int PARENT_TYPE_SIZE_AUTOGENMEMMAP                  = 2-1;
const unsigned int PARENT_TYPE_SIZE_SETTOPUNIT                     = 2-1;
const unsigned int PARENT_TYPE_SIZE_ADDTOMEMORYMAP                 = 1;
const unsigned int PARENT_TYPE_SIZE_SETACCESSRIGHTSENUM            = 1-1;
const unsigned int PARENT_TYPE_SIZE_SETPAGENO                      = 2-1;
const unsigned int PARENT_TYPE_SIZE_NOGENRTL                       = 1;
const unsigned int PARENT_TYPE_SIZE_GENUNIQUERTLMODULES            = 1;
const unsigned int PARENT_TYPE_SIZE_REGISTERIOS                    = 1;
const unsigned int PARENT_TYPE_SIZE_DONOTGENCPP                    = 1;
const unsigned int PARENT_TYPE_SIZE_SETCLOCK                       = 5;

//CSLOmCmd checkParamSize

const unsigned int PARAM_SIZE_CMDDECSETDECODER_LOWER =  0;
const unsigned int PARAM_SIZE_CMDDECSETDECODER_UPPER =  2;

const unsigned int PARAM_SIZE_CMDFIFOADDPROGRAMMABLEDEPTH_LOWER =  1;
const unsigned int PARAM_SIZE_CMDFIFOADDPROGRAMMABLEDEPTH_UPPER =  1;

const unsigned int PARAM_SIZE_CMDFIFOSETPHYSICALIMPTYPE_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOSETPHYSICALIMPTYPE_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDPRIOBYPASS_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDPRIOBYPASS_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOSETASYNCH_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOSETASYNCH_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOSETDEPTHEXTEND_LOWER =  1;
const unsigned int PARAM_SIZE_CMDFIFOSETDEPTHEXTEND_UPPER =  1;

const unsigned int PARAM_SIZE_CMDFIFOSETWIDTHEXTEND_LOWER =  1;
const unsigned int PARAM_SIZE_CMDFIFOSETWIDTHEXTEND_UPPER =  1;

const unsigned int PARAM_SIZE_CMDFIFOSETWRHOLD_LOWER =  1;
const unsigned int PARAM_SIZE_CMDFIFOSETWRHOLD_UPPER =  1;

const unsigned int PARAM_SIZE_CMDFIFOPARALLELOUTPUT_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOPARALLELOUTPUT_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOPARALLELINPUT_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOPARALLELINPUT_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFORDWORDS_LOWER =  2;
const unsigned int PARAM_SIZE_CMDFIFORDWORDS_UPPER =  2;

const unsigned int PARAM_SIZE_CMDFIFOWRWORDS_LOWER =  2;
const unsigned int PARAM_SIZE_CMDFIFOWRWORDS_UPPER =  2;

const unsigned int PARAM_SIZE_CMDFIFOADDSRAMRD_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDSRAMRD_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDSRAMWR_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDSRAMWR_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDPUSHBACK_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDPUSHBACK_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOFLOWTHROUGH_LOWER =  1;
const unsigned int PARAM_SIZE_CMDFIFOFLOWTHROUGH_UPPER =  1;

const unsigned int PARAM_SIZE_CMDFIFOADDSTALL_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDSTALL_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDSTALLRDSIDE_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDSTALLRDSIDE_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDSTALLWRSIDE_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDSTALLWRSIDE_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDWRRELEASE_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDWRRELEASE_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDALMOSTEMPTY_LOWER =  1;
const unsigned int PARAM_SIZE_CMDFIFOADDALMOSTEMPTY_UPPER =  1;

const unsigned int PARAM_SIZE_CMDFIFOADDALMOSTFULL_LOWER =  1;
const unsigned int PARAM_SIZE_CMDFIFOADDALMOSTFULL_UPPER =  1;

const unsigned int PARAM_SIZE_CMDFIFOADDOUTWRADDR_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDOUTWRADDR_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDOUTRDADDR_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDOUTRDADDR_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDCREDIT_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDCREDIT_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDRDCREDIT_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDRDCREDIT_UPPER =  0;

const unsigned int PARAM_SIZE_CMDFIFOADDWRCREDIT_LOWER =  0;
const unsigned int PARAM_SIZE_CMDFIFOADDWRCREDIT_UPPER =  0;

const unsigned int PARAM_SIZE_CMDENUMADDPAIR_LOWER =  1;
const unsigned int PARAM_SIZE_CMDENUMADDPAIR_UPPER =  2;

const unsigned int PARAM_SIZE_CMDSETVALUE_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETVALUE_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETENUM_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETENUM_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETENUMITEM_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETENUMITEM_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETPOSITION_LOWER =  2;
const unsigned int PARAM_SIZE_CMDSETPOSITION_UPPER =  2;

const unsigned int PARAM_SIZE_CMDSETNEXT_LOWER =  2;
const unsigned int PARAM_SIZE_CMDSETNEXT_UPPER =  2;

const unsigned int PARAM_SIZE_CMDSETPREVIOUS_LOWER =  2;
const unsigned int PARAM_SIZE_CMDSETPREVIOUS_UPPER =  2;

const unsigned int PARAM_SIZE_CMDSETACCESSRIGHTS_LOWER =  2;
const unsigned int PARAM_SIZE_CMDSETACCESSRIGHTS_UPPER =  3;

const unsigned int PARAM_SIZE_CMDSETUNITNAME_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETUNITNAME_UPPER =  1;

const unsigned int PARAM_SIZE_CMDADDADDRESSRANGE_LOWER =  2;
const unsigned int PARAM_SIZE_CMDADDADDRESSRANGE_UPPER =  2;

const unsigned int PARAM_SIZE_CMDSETADDRESSINCREMENT_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETADDRESSINCREMENT_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETNEXTADDRESS_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETNEXTADDRESS_UPPER =  1;

const unsigned int PARAM_SIZE_CMDADDRESERVEDRANGE_LOWER =  2;
const unsigned int PARAM_SIZE_CMDADDRESERVEDRANGE_UPPER =  2;

const unsigned int PARAM_SIZE_CMDADD_LOWER =  1;
const unsigned int PARAM_SIZE_CMDADD_UPPER =  3;

const unsigned int PARAM_SIZE_CMDSETDATAWORDWIDTH_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETDATAWORDWIDTH_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETALIGNMENT_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETALIGNMENT_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETENDIANESS_LOWER =  0;
const unsigned int PARAM_SIZE_CMDSETENDIANESS_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETSYMBOLMAXLENGTH_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETSYMBOLMAXLENGTH_UPPER =  1;

const unsigned int PARAM_SIZE_CMDAUTOGENMEMMAP_LOWER =  0;
const unsigned int PARAM_SIZE_CMDAUTOGENMEMMAP_UPPER =  0;

const unsigned int PARAM_SIZE_CMDSETTOPUNIT_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETTOPUNIT_UPPER =  1;

const unsigned int PARAM_SIZE_CMDADDTOMEMORYMAP_LOWER =  0;
const unsigned int PARAM_SIZE_CMDADDTOMEMORYMAP_UPPER =  3;

const unsigned int PARAM_SIZE_CMDSETACCESSRIGHTSENUM_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETACCESSRIGHTSENUM_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETINSTANCENAME_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETINSTANCENAME_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETPAGENO_LOWER =  2;
const unsigned int PARAM_SIZE_CMDSETPAGENO_UPPER =  2;

const unsigned int PARAM_SIZE_CMDSETWIDTH_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETWIDTH_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETDEPTH_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETDEPTH_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETBITRANGE_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETBITRANGE_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETOFFSET_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETOFFSET_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETRANGE_LOWER =  2;
const unsigned int PARAM_SIZE_CMDSETRANGE_UPPER =  2;

const unsigned int PARAM_SIZE_CMDSETNUMBEROFDIMENSIONS_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETNUMBEROFDIMENSIONS_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETDIMWIDTH_LOWER =  2;
const unsigned int PARAM_SIZE_CMDSETDIMWIDTH_UPPER =  2;

const unsigned int PARAM_SIZE_CMDSETDIMBITRANGE_LOWER =  2;
const unsigned int PARAM_SIZE_CMDSETDIMBITRANGE_UPPER =  2;

const unsigned int PARAM_SIZE_CMDSETDIMOFFSET_LOWER =  2;
const unsigned int PARAM_SIZE_CMDSETDIMOFFSET_UPPER =  2;

const unsigned int PARAM_SIZE_CMDSETDIMRANGE_LOWER =  3;
const unsigned int PARAM_SIZE_CMDSETDIMRANGE_UPPER =  3;

const unsigned int PARAM_SIZE_CMDSETUNITPREFIX_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETUNITPREFIX_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETSIGNALPREFIX_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETSIGNALPREFIX_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETSIGNALPREFIXLOCAL_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETSIGNALPREFIXLOCAL_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETTYPE_LOWER =  0;
const unsigned int PARAM_SIZE_CMDSETTYPE_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETATTR_LOWER =  0;
const unsigned int PARAM_SIZE_CMDSETATTR_UPPER =  1;

const unsigned int PARAM_SIZE_CMDGENERATEINDIVIDUALRTLSIGNALS_LOWER =  0;
const unsigned int PARAM_SIZE_CMDGENERATEINDIVIDUALRTLSIGNALS_UPPER =  0;

const unsigned int PARAM_SIZE_CMDADDUNITPARAMETER_LOWER =  2;
const unsigned int PARAM_SIZE_CMDADDUNITPARAMETER_UPPER =  2;

const unsigned int PARAM_SIZE_CMDOVERRIDEUNITPARAMETER_LOWER =  2;
const unsigned int PARAM_SIZE_CMDOVERRIDEUNITPARAMETER_UPPER =  2;

const unsigned int PARAM_SIZE_CMDINPUTVERILOGTYPE_LOWER =  0;
const unsigned int PARAM_SIZE_CMDINPUTVERILOGTYPE_UPPER =  0;

const unsigned int PARAM_SIZE_CMDOUTPUTVERILOGTYPE_LOWER =  0;
const unsigned int PARAM_SIZE_CMDOUTPUTVERILOGTYPE_UPPER =  0;

const unsigned int PARAM_SIZE_CMDREVERSE_LOWER =  0;
const unsigned int PARAM_SIZE_CMDREVERSE_UPPER =  0;

const unsigned int PARAM_SIZE_CMDSETPREFIX_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETPREFIX_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETSUFFIX_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETSUFFIX_UPPER =  1;

const unsigned int PARAM_SIZE_CMDNOPREFIX_LOWER =  0;
const unsigned int PARAM_SIZE_CMDNOPREFIX_UPPER =  0;

const unsigned int PARAM_SIZE_CMDSETID_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETID_UPPER =  1;

const unsigned int PARAM_SIZE_CMDADDCOMMENT_LOWER =  1;
const unsigned int PARAM_SIZE_CMDADDCOMMENT_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETMAXNUMVECTORS_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETMAXNUMVECTORS_UPPER =  1;

const unsigned int PARAM_SIZE_CMDSETSOURCE_LOWER =  1;
const unsigned int PARAM_SIZE_CMDSETSOURCE_UPPER =  1;

const unsigned int PARAM_SIZE_CMDCONNECT_LOWER =  1;
const unsigned int PARAM_SIZE_CMDCONNECT_UPPER =  1;

const unsigned int PARAM_SIZE_CMDADDRESET_LOWER =  1;
const unsigned int PARAM_SIZE_CMDADDRESET_UPPER =  1;

const unsigned int PARAM_SIZE_CMDADDSIGNAL_LOWER =  1;
const unsigned int PARAM_SIZE_CMDADDSIGNAL_UPPER =  1;

///////////////////////////////////////////////
///used for checking numeric expressions in cmd(checkNumber method)

const int NO_DO_NOT_CHECK_VALUE = 0;
const int NO_GREATER_THAN_VALUE = 1;
const int NO_NOT_EQUAL_TO_VALUE = 2;

const int NO_DO_NOT_CHECK_XZ    = 0;
const int NO_CHECK_FOR_XZ       = 1;
const int NO_CHECK_FOR_NOT_XZ   = 2;

////////////////////////////////////////////////////
///used in check<TYPE>ScopeParent methods from cmd///
////////////////////////////////////////////////////

const int DO_NOT_CHECK          = 0;
const int CHECK_FOR_INTEGER     = 1;
const int CHECK_FOR_DEFAULT     = 2;


////////////////////////////////////////////////////
//design checker constints

const int DCH_MAN_CMD_CNT_VECTOR    = 2; 
const int DCH_MAN_CMD_CNT_FIFO      = 2;
const int DCH_MAN_CMD_CNT_REG_FILE  = 2;
const int DCH_MAN_CMD_CNT_ISA_FIELD = 2;
const int DCH_MAN_CMD_CNT_ISA_ELEMENT =1;
const int DCH_MAN_CMD_CNT_FIELD     = 1;
const int DCH_MAN_CMD_CNT_REGISTER  = 2;
const int DCH_MAN_CMD_CNT_TESTBENCH = 0;
const int DCH_MAN_CMD_CNT_MEMORY_MAP= 1;
const int DCH_MAN_CMD_CNT_MMAP_PAGE = 2;
const int DCH_MAN_CMD_CNT_MEMORY    = 2;
#endif
