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

#ifndef _CGEN_CONSTS_H_
#define _CGEN_CONSTS_H_

//-----------------------------------defines-----------------------------------//
#define _CGEN_DEBUG_MODE_

#define GET_CLASS                               getName<ECSLClass, ECSLClassStringMap_const_iter>
#define GET_CMD                                 getName<ECSLCmdType, ECSLCmdStringMap_const_iter>

//-----------------------------------consts-----------------------------------//
const char *const ENV_VAR_NAME                   = "WORK";
const char *const ARG_HELP                       = "--help";
const char *const RELATIVE_TEST_PATH             = "/test/csl_test_gen/";
const char *const REPORT_FILE_NAME               = "/report_cg";

const char *const VALID_TEST_DIR_SUFFIX          = "_valid/";
const char *const INVALID_TEST_DIR_SUFFIX        = "_invalid/";
const char *const VALID_TEST_HEADER              = "//Type: valid\n";
const char *const INVALID_TEST_HEADER            = "//Type: invalid\n";
const char *const TEST_EXTENSION                 = ".csl";

const char *const REGRESSION_CTRL_FILE_NAME      = "regression_control";
const char *const REGRESSION_CTRL_VALID          = "default_test_list = PF          #pass/fail\nexecute_testsuite = 1           #enable/disable testing current testsuite\nis_valid = 1                    #tells if the current testsuite contains valid test\n";
const char *const REGRESSION_CTRL_INVALID        = "default_test_list = PF          #pass/fail\nexecute_testsuite = 1           #enable/disable testing current testsuite\nis_valid = 0                    #tells if the current testsuite contains valid test\n";

const char *const ALIGN_NONE                     = "";
const char *const ALIGN_SCOPE                    = "  ";
const char *const ALIGN_CSTR                     = "    ";

const char *const EMPTY_STRING                   = "";

const unsigned OBJ_COUNT_ZERO                    = 0;
const unsigned OBJ_COUNT_ONE                     = 1;
const unsigned OBJ_COUNT_TWO                     = 2;

const int WIDTH_DEFAULT                          = 1;
const int DEPTH_DEFAULT                          = 1;

const int LSB_DEFAULT                            = 1;
const int MSB_DEFAULT                            = 2;

const int OFFSET_DEFAULT                         = 1;

const int CONST_ZERO                             = 0;
const int CONST_ONE                              = 1;

const int LOW_ALLOWED_RANGE_DEFAULT              = 0;
const int UP_ALLOWED_RANGE_DEFAULT               = 1;

const int POSITION_DEFAULT                       = 1;

const int VALUE_DEFAULT                          = 1;

const int WORD_WIDTH_DEFAULT                     = 1;

const int LOW_ADDRESS_RANGE_DEFAULT              = 1;
const int UP_ADDRESS_RANGE_DEFAULT               = 2;

const int LOW_RESERVED_ADDRESS_RANGE_DEFAULT     = 1;
const int UP_RESERVED_ADDRESS_RANGE_DEFAULT      = 2;

const int ADDRESS_INCREMENT_DEFAULT              = 1;

const int ALIGNMENT_DEFAULT                      = 1;

const int NEXT_ADDRESS_DEFAULT                   = 1;

const int SYMBOL_MAX_LENGHT_DEFAULT              = 1;

const int DIMENSION_DEFAULT                      = 1;

const int DIM_DEFAULT                            = 0;

const int ID_DEFAULT                             = 1;
const int MAX_CAPTURE_EVENTS_DEFAULT             = 1;
const int MAX_MISMATCHES_DEFAULT                 = 1;
const int MAX_TRANSACTION_EVENTS_DEFAULT         = 1;
const int MAX_STATES_DEFAULT                     = 1;
const int TIMEOUT_DEFAULT                        = 1;
const int VERSION_DEFAULT                        = 1;

#endif //_CGEN_CONSTS_H_
