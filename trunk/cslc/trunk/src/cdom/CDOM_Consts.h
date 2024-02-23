//----------------------------------------------------------------------
// Copyright (c) 2005-2008 Fastpathlogic
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
//Author: Tb

#ifndef INC_GUARD_CDOM_Consts_h_
#define INC_GUARD_CDOM_Consts_h_

#include "CDOM_Visitor.h"
#include "../support/cli/cslcCLI_Support.h"

/** These are used in the CDOM_Visitor ================================
 */
#undef WRITE
#undef WRITE_N

#define WRITE(__out, __what)                    \
  __out << __what
#define WRITE_N(__out, __amount, __what)        \
  for (TInt i = ZERO; i < __amount; ++i)        \
    __out << __what;

/** This is sent by CSLOM and represents the name of the top unit in the
 * design (or NULL if the design has no top unit)
 */
extern RefString cslTopUnitName;

//
//extern RefString cslomClockName;


namespace NSCdomVHDLGenerator {

/** Keywords in 'csl_util.sym' library --------------------------------
 */
const std::string __CSL_UTIL_LIBRARY                            = "library csl_util;";
const std::string __USE_CSL_UTIL_PACKAGE_ALL                    = "use csl_util.csl_util_package.all;";

const std::string __CAST_BOOLEAN_TO_BIT                         = "cast_boolean_to_bit";
const std::string __CAST_BOOLEAN_TO_INTEGER                     = "cast_boolean_to_integer";
const std::string __CAST_BOOLEAN_TO_UNSIGNED                    = "cast_boolean_to_unsigned";
const std::string __CAST_BOOLEAN_TO_REAL                        = "cast_boolean_to_real";
const std::string __CAST_BOOLEAN_TO_BIT_VECTOR                  = "cast_boolean_to_bit_vector";

const std::string __CAST_BIT_TO_BOOLEAN                         = "cast_bit_to_boolean";
const std::string __CAST_BIT_TO_INTEGER                         = "cast_bit_to_integer";
const std::string __CAST_BIT_TO_UNSIGNED                        = "cast_bit_to_unsigned";
const std::string __CAST_BIT_TO_REAL                            = "cast_bit_to_real";
const std::string __CAST_BIT_TO_BIT_VECTOR                      = "cast_bit_to_bit_vector";

const std::string __CAST_INTEGER_TO_BOOLEAN                     = "cast_integer_to_boolean";
const std::string __CAST_INTEGER_TO_BIT                         = "cast_integer_to_bit";
const std::string __CAST_INTEGER_TO_UNSIGNED                    = "cast_integer_to_unsigned";
const std::string __CAST_INTEGER_TO_REAL                        = "cast_integer_to_real";
const std::string __CAST_INTEGER_TO_BIT_VECTOR                  = "cast_integer_to_bit_vector";

const std::string __CAST_UNSIGNED_TO_BOOLEAN                    = "cast_unsigned_to_boolean";
const std::string __CAST_UNSIGNED_TO_BIT                        = "cast_unsigned_to_bit";
const std::string __CAST_UNSIGNED_TO_INTEGER                    = "cast_unsigned_to_integer";
const std::string __CAST_UNSIGNED_TO_REAL                       = "cast_unsigned_to_real";
const std::string __CAST_UNSIGNED_TO_BIT_VECTOR                 = "cast_unsigned_to_bit_vector";

const std::string __CAST_REAL_TO_BOOLEAN                        = "cast_real_to_boolean";
const std::string __CAST_REAL_TO_BIT                            = "cast_real_to_bit";
const std::string __CAST_REAL_TO_INTEGER                        = "cast_real_to_integer";
const std::string __CAST_REAL_TO_UNSIGNED                       = "cast_real_to_unsigned";
const std::string __CAST_REAL_TO_BIT_VECTOR                     = "cast_real_to_bit_vector";

const std::string __CAST_BIT_VECTOR_TO_BOOLEAN                  = "cast_bit_vector_to_boolean";
const std::string __CAST_BIT_VECTOR_TO_BIT                      = "cast_bit_vector_to_bit";
const std::string __CAST_BIT_VECTOR_TO_INTEGER                  = "cast_bit_vector_to_integer";
const std::string __CAST_BIT_VECTOR_TO_UNSIGNED                 = "cast_bit_vector_to_unsigned";
const std::string __CAST_BIT_VECTOR_TO_REAL                     = "cast_bit_vector_to_real";

const std::string __TYPE_CSL_BIT                                = "csl_bit";
const std::string __TYPE_CSL_BIT_VECTOR                         = "csl_bit_vector";
const std::string __TYPE_CSL_INTEGER                            = "csl_integer";
const std::string __TYPE_CSL_TIME                               = "csl_unsigned";
const std::string __TYPE_CSL_REAL                               = "csl_real";
const std::string __TYPE_CSL_REALTIME                           = "csl_unsigned";
const std::string __TYPE_CSL_UNSIGNED                           = "csl_unsigned";
const std::string __TYPE_CSL_STRING                             = "csl_string";
const std::string __TYPE_CSL_MATRIX_2D                          = "csl_matrix_2D";
const std::string __TYPE_CSL_MATRIX_3D                          = "csl_matrix_3D";
const std::string __TYPE_CSL_MATRIX_4D                          = "csl_matrix_4D";
const std::string __TYPE_CSL_MATRIX_5D                          = "csl_matrix_5D";
const std::string __TYPE_CSL_MATRIX_6D                          = "csl_matrix_6D";

const std::string __UNARY_REDUCTION_AND                         = "unary_reduction_and";
const std::string __UNARY_REDUCTION_NAND                        = "unary_reduction_nand";
const std::string __UNARY_REDUCTION_OR                          = "unary_reduction_or";
const std::string __UNARY_REDUCTION_NOR                         = "unary_reduction_nor";
const std::string __UNARY_REDUCTION_XOR                         = "unary_reduction_xor";
const std::string __UNARY_REDUCTION_XNOR                        = "unary_reduction_xnor";

const std::string __LOGICAL_NOT                                 = "logical_not";
const std::string __LOGICAL_AND                                 = "logical_and";
const std::string __LOGICAL_OR                                  = "logical_or";
const std::string __LOG_2                                       = "log2";

const std::string __REPLICATION_OPERATOR                        = "replication_operator";

const std::string __TERNARY_CONDITION_OPERATOR                  = "ternary_condition_operator";
/** -------------------------------------------------------------------
 */

const char __CHAR_QUOTE                                         = '\'';
const char __CHAR_SEMICOLON                                     = ';';
const char __CHAR_NEW_LINE                                      = '\n';
const char __CHAR_ROUND_OPEN                                    = '(';
const char __CHAR_ROUND_CLOSE                                   = ')';
const char __CHAR_SPACE                                         = ' ';
const char __CHAR_UNDERSCORE                                    = '_';
const char __CHAR_COLON                                         = ':';
const char __CHAR_COMMA                                         = ',';
const char __CHAR_EQUAL                                         = '=';
const char __CHAR_PERIOD                                        = '.';
const char __CHAR_LESS                                          = '<';
const char __CHAR_GREATER                                       = '>';
const char __CHAR_BACKSLASH                                     = '\\';
const char __CHAR_PLUS                                          = '+';
const char __CHAR_MINUS                                         = '-';
const char __CHAR_STAR                                          = '*';
const char __CHAR_SLASH                                         = '/';
const char __CHAR_DOUBLE_QUOTE                                  = '\"';
const char __CHAR_AMPERSAND                                     = '&';
const char __CHAR_POUND                                         = '#';

const std::string __EMPTY_STRING                                = "";
const std::string __SEPARATOR_LINE                              = "-------------------------------------------------------------------------------\n";
const std::string __COMMENT_LINE                                = "-- ";

const std::string __ERR_MSG_ACCESS_WRITE_DENIED                 = " write permission denied.";
const std::string __ERR_MSG_ACCESS_EXECUTE_WRITE_DENIED         = " write or execution permission denied.";
const std::string __ERR_MSG_COULD_NOT_OPEN_FILE                 = " could not be opened.";

const std::string __VHDL_FILE_EXTENSION                         = ".vhd";
const std::string __VH_FILE_EXTENSION                           = ".vh";

const std::string __IEEE_LIBRARY                                = "library ieee;";
const std::string __USE_IEEE_STD_LOGIC_1164_ALL                 = "use ieee.std_logic_1164.all;";
const std::string __USE_IEEE_STD_LOGIC_UNSIGNED_ALL             = "use ieee.std_logic_unsigned.all;";
const std::string __USE_IEEE_STD_LOGIC_ARITH_ALL                = "use ieee.std_logic_arith.all;";
const std::string __USE_IEEE_NUMERIC_STD_ALL                    = "use ieee.numeric_std.all;";

const std::string __ENTITY                                      = "entity";
const std::string __IS                                          = "is";
const std::string __BEGIN                                       = "begin";
const std::string __END                                         = "end";
const std::string __ARCHITECTURE                                = "architecture";
const std::string __OF                                          = "of";
const std::string __LOGIC                                       = "logic";
const std::string __PORT                                        = "port";
const std::string __GENERIC                                     = "generic";
const std::string __DOWNTO                                      = "downto";
const std::string __TO                                          = "to";
const std::string __RANGE                                       = "range";
const std::string __CONSTANT                                    = "constant";
const std::string __VARIABLE                                    = "variable";
const std::string __SIGNAL                                      = "signal";
const std::string __COMPONENT                                   = "component";
const std::string __MAP                                         = "map";
const std::string __REGISTER                                    = "register";
const std::string __BUS                                         = "bus";
const std::string __PROCESS                                     = "process";
const std::string __NOT                                         = "not";
const std::string __MOD                                         = "mod";
const std::string __SLA                                         = "sla";
const std::string __SRA                                         = "sra";
const std::string __SLL                                         = "sll";
const std::string __SRL                                         = "srl";
const std::string __AND                                         = "and";
const std::string __OR                                          = "or";
const std::string __NOR                                         = "nor";
const std::string __XOR                                         = "xor";
const std::string __NAND                                        = "nand";
const std::string __XNOR                                        = "xnor";

const std::string __TYPE_IN                                     = "in";
const std::string __TYPE_OUT                                    = "out";
const std::string __TYPE_INOUT                                  = "inout";

const std::string __AUX_SIGNAL                                  = "aux_sig";

const TInt __ID                                                 = 0;

const TUInt __RANGE_CHILDREN_COUNT                              = 2;
const TInt __RANGE_FIRST_EXPR                                   = 0;
const TInt __RANGE_SECOND_EXPR                                  = 1;

const TInt __MINTYPMAX_SINGLE_EXPR                              = 0;
const TInt __MINTYPMAX_TRIAD_MIN                                = 0;
const TInt __MINTYPMAX_TRIAD_TYP                                = 1;
const TInt __MINTYPMAX_TRIAD_MAX                                = 2;

const TInt __PORT_ITEM_SIMPLE_CHILDREN_COUNT                    = 1;
const TInt __PORT_ITEM_CONCAT_CHILDREN_COUNT                    = 2;

const TInt __BINARY_OPERATOR_PARITY                             = 2;
const TInt __TERNARY_OPERATOR_PARITY                            = 3;

const TInt __INDENT_AMOUNT                                      = 2;
const TInt __TUINT_SIZE                                         = sizeof(TUInt) * 8;
const TInt __PORT_SIZE                                          = __PORT.size();
const TInt __GENERIC_SIZE                                       = __GENERIC.size();
const TInt __INSTANCE_SIZE                                      = 18;

const TInt __EXTENDED_DIGIT_SEPARATOR                           = 4;
const TInt __BIN_BASE                                           = 2;
const TInt __OCT_BASE                                           = 8;
const TInt __DEC_BASE                                           = 10;
const TInt __HEX_BASE                                           = 16;
const TInt __OCT_BIN_REPRESENTATION                             = 3;
const TInt __HEX_BIN_REPRESENTATION                             = 4;
const TInt __SIZE_OF_CSL_UNSIGNED                               = 64;
/** ===================================================================
 */

} //NSCdomVHDLGenerator namespace

#endif //INC_GUARD_CDOM_Consts_h_
