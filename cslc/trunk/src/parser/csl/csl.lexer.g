//----------------------------------------------------------------------
// Copyright (c) 2006, 2007 Fastpathlogic
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

/*
 *   Part of the Csl parser
 *   Authors: David & Alina & Gabriel & Andrei & Octav
 */

//****************************************************************************************//
//****************************************************************************************//
//****************************** WARNING! ************************************************//
//*  IF YOU ARE NOT IN CHARGE OF THE PARSER YOU ARE PROBABLY NOT ALLOWED TO MODIFY THIS  *//
//********************* DON'T TOUCH IT - I KILL YOU! *************************************//
//****************************************************************************************//
//****************************************************************************************//

header "post_include_hpp"
    {
    #include "Def.hpp"
    #include "CslNumber.hpp"
    #include "CslLexerUtils.hpp"
    #include "../../support/CommonSupport.h"

    ANTLR_USING_NAMESPACE(std);
    ANTLR_USING_NAMESPACE(antlr);
    }

options
    {
    language = "Cpp";
    }

{
ANTLR_USING_NAMESPACE(antlr);
#define _RS(str) (RefString(new string(str)))

#include <iostream>
#include "../../support/Base.hpp"
#include "CslToken.hpp"
#include "CslLexer.inc"
}

class CslLexer extends Lexer;

options {
  exportVocab = Csl;
  testLiterals = false;
  k = 3;
  charVocabulary = '\3'..'\377';
  defaultErrorHandler=false;
}


tokens {
//****************************************************************************************************************************//
//***************************************************** TOKENS ***************************************************************//
//****************************************************************************************************************************//


//*******************************************************************************//
//***    TYPES    ****//
//*******************************************************************************//
  K_CSL_UNIT                                                                    = "csl_unit"                                ;
  K_CSL_LIST                                                                    = "csl_list"                                ;
  K_CSL_INTERFACE                                                               = "csl_interface"                           ;
  K_CSL_REGISTER_FILE                                                           = "csl_register_file"                       ;
  K_CSL_READ_INTERFACE                                                          = "csl_read_interface"                      ;
  K_CSL_WRITE_INTERFACE                                                         = "csl_write_interface"                     ;
  K_CSL_REGISTER                                                                = "csl_register"                            ;
//maybe ver 2 type? UNKNOWN
//  K_CSL_BOOL                                                                    = "csl_bool"                                ;
//maybe ver 2 type? UNKNOWN
//  K_CSL_ROM                                                                     = "csl_rom"                                 ;
  K_CSL_PORT                                                                    = "csl_port"                                ;
  K_CSL_SIGNAL                                                                  = "csl_signal"                              ;
  K_CSL_BITRANGE                                                                = "csl_bitrange"                            ;
//maybe ver 2 type? UNKNOWN
//  K_CSL_CELL                                                                    = "csl_cell"                                ;
  K_CSL_SIGNAL_GROUP                                                            = "csl_signal_group"                        ;
//maybe ver 2 type? UNKNOWN - or maybe obsolete type
//  K_CSL_DESIGN                                                                  = "csl_design"                              ;
  K_CSL_TESTBENCH                                                               = "csl_testbench"                           ;
  K_CSL_EVENT                                                                   = "csl_event"                               ;
//maybe ver 2 type? UNKNOWN
//  K_CSL_ARCH_STATE                                                              = "csl_arch_state"                          ;
//maybe ver 2 type? UNKNOWN
//  K_CSL_BOOL_EQUATION                                                           = "csl_bool_equation"                       ;
//ver 2 type
//  K_CSL_SIGNAL_PATTERN_GENERATOR                                                = "csl_signal_pattern_generator"            ;
  K_CSL_INCLUDE                                                                 = "csl_include"                             ;
  K_CSL_ISA_FIELD                                                               = "csl_isa_field"                           ;
  K_CSL_ISA_ELEMENT                                                             = "csl_isa_element"                         ;
  K_CSL_ENUM                                                                    = "csl_enum"                                ;
  K_CSL_FIELD                                                                   = "csl_field"                               ;
  K_CSL_FIFO                                                                    = "csl_fifo"                                ;
//maybe ver 2 type? UNKNOWN
//  K_CSL_ADDRESS_RANGE                                                           = "csl_address_range"                       ;
  K_CSL_MEMORY_MAP                                                              = "csl_memory_map"                          ;
  K_CSL_MEMORY_MAP_PAGE                                                         = "csl_memory_map_page"                     ;
  K_CSL_STATE_DATA                                                              = "csl_state_data"                          ;
  K_CSL_VECTOR                                                                  = "csl_vector"                              ;
  K_CSL_MEMORY                                                                  = "csl_memory"                              ;
  K_CSL_MULTI_DIM_BITRANGE                                                      = "csl_multi_dim_bitrange"                  ;
  K_CSL_PIPELINE                                                                = "csl_pipeline"                            ;
  K_CSL_PIPESTAGE                                                               = "csl_pipestage"                           ;
  K_CSL_PARAMETER                                                               = "csl_parameter"                           ;


//*******************************************************************************//
//*** SET COMMANDS ***//
//*******************************************************************************//
  K_SET_TYPE                                                                    = "set_type"                                ;
  K_SET_ATTR                                                                    = "set_attr"                                ;
  K_SET_UNIT_PREFIX                                                             = "set_unit_prefix"                         ;
  K_SET_SIGNAL_PREFIX                                                           = "set_signal_prefix"                       ;
  K_SET_SIGNAL_PREFIX_LOCAL                                                     = "set_signal_prefix_local"                 ;
  K_SET_DEPTH                                                                   = "set_depth"                               ;
  K_SET_CONST_VALUE                                                             = "set_const_value"                         ;
  K_SET_EXTERNAL                                                                = "set_external"                            ;
  K_SET_NUMBER_OF_PORTS                                                         = "set_number_of_ports"                     ;
  K_SET_ADDRESS                                                                 = "set_address"                             ;
  K_SET_ATTRIBUTES                                                              = "set_attributes"                          ;
  K_SET_LOCK_ENABLE_BIT                                                         = "set_lock_enable_bit"                     ;
  K_SET_MASK                                                                    = "set_mask"                                ;
  K_SET_FEEDBACK_MASK                                                           = "set_feedback_mask"                       ;
  K_SET_FEEDBACK_ELEMENT                                                        = "set_feedback_element"                    ;
  K_SET_SHIFT_TYPE                                                              = "set_shift_type"                          ;
  K_SET_SHIFT_AMOUNT                                                            = "set_shift_amount"                        ;
  K_SET_FINAL_SHIFT_VALUE                                                       = "set_final_shift_value"                   ;
  K_SET_WIDTH                                                                   = "set_width"                               ;
  K_SET_DIM_WIDTH                                                               = "set_dim_width"                           ;
  K_SET_BITRANGE                                                                = "set_bitrange"                            ;
  K_SET_DIM_BITRANGE                                                            = "set_dim_bitrange"                        ;
  K_SET_RANGE                                                                   = "set_range"                               ;
  K_SET_DIM_RANGE                                                               = "set_dim_range"                           ;
  K_SET_DIM_LOWER_INDEX                                                         = "set_dim_lower_index"                     ;
  K_SET_DIM_UPPER_INDEX                                                         = "set_dim_upper_index"                     ;
  K_SET_OFFSET                                                                  = "set_offset"                              ;
  K_SET_DIM_OFFSET                                                              = "set_dim_offset"                          ;
  K_SET_NUMBER_OF_DIMENSIONS                                                    = "set_number_of_dimensions"                ;
  K_SET_CELL                                                                    = "set_cell"                                ;
  K_SET_INSTANCE_ALTERATION_BIT                                                 = "set_instance_alteration_bit"             ;
  K_SET_TESTBENCH_VERILOG_FILENAME                                              = "set_testbench_verilog_filename"          ;
  K_SET_VC_TIMEOUT                                                              = "set_vc_timeout"                          ;
  K_SET_PERIOD                                                                  = "set_period"                              ;
  K_SET_TIMEBASE                                                                = "set_timebase"                            ;
  K_SET_TRANSACTION_TIMEOUT_COUNT                                               = "set_transaction_timeout_count"           ;
  K_SET_DUT_COMPARE_TRIGGER                                                     = "set_dut_compare_trigger"                 ;
  K_SET_GENERATE_WAVES_FILENAME                                                 = "set_generate_waves_filename"             ;
  K_SET_INSTANCE_NAME                                                           = "set_instance_name"                       ;
  K_SET_DUT_MEM                                                                 = "set_dut_mem"                             ;
  K_SET_DUT_MEM_INIT                                                            = "set_dut_mem_init"                        ;
  K_SET_SINGLE_LINE                                                             = "set_single_line"                         ;
  K_SET_VC_ID                                                                   = "set_vc_id"                               ;
  K_SET_DUT_INPUT_FILENAME                                                      = "set_dut_input_filename"                  ;
  K_SET_DUT_OUTPUT_FILENAME                                                     = "set_dut_output_filename"                 ;
  K_SET_VC_MAX_NUM_STATES                                                       = "set_vc_max_num_states"                   ;
  K_SET_CONNECTION_TYPE                                                         = "set_connection_type"                     ;
  K_SET_NAME                                                                    = "set_name"                                ;
  K_SET_DIRECTION                                                               = "set_direction"                           ;
  K_SET_MAX_NUM_VECTORS                                                         = "set_max_num_vectors"                     ;
  K_SET_MEM_INSTANCE_NAME                                                       = "set_mem_instance_name"                   ;
  K_SET_EVENT_TYPE                                                              = "set_event_type"                          ;
  K_SET_STIMULUS_FILENAME                                                       = "set_stimulus_filename"                   ;
  K_SET_EXPECTED_FILENAME                                                       = "set_expected_filename"                   ;
  K_SET_VC_OUTPUT_FILENAME                                                      = "set_vc_output_filename"                  ;
  K_SET_DUT_NAME                                                                = "set_tb_dut_name"                         ;
  K_SET_CSIM_NAME                                                               = "set_csim_unit_name"                      ;
  K_SET_PLI_SOCKET_NAME                                                         = "set_pli_socket_name"                     ;
  K_SET_MAX_ERROR_COUNT                                                         = "set_max_error_count"                     ;
  K_SET_RADIX                                                                   = "set_radix"                               ;
  K_SET_GENERATOR_TYPE                                                          = "set_generator_type"                      ;
  K_SET_PATTERN                                                                 = "set_pattern"                             ;
  K_SET_START_SIGNAL                                                            = "set_start_signal"                        ;
  K_SET_DEFAULT_VALUE                                                           = "set_default_value"                       ;
  K_SET_RESET                                                                   = "set_reset"                               ;
  K_SET_DURATION                                                                = "set_duration"                            ;
  K_SET_CLK_DIVIDER                                                             = "set_clk_divider"                         ;
  K_SET_CLK_MULTIPLIER                                                          = "set_clk_multiplier"                      ;
  K_SET_PHASE_DIFFERENCE                                                        = "set_phase_difference"                    ;
  K_SET_SIGNAL_NAME                                                             = "set_signal_name"                         ;
  K_SET_ISA                                                                     = "set_isa"                                 ;
  K_SET_MNEMONIC                                                                = "set_mnemonic"                            ;
  K_SET_DECODER_NAME                                                            = "set_decoder_name"                        ;
  K_SET_DECODER_OUT_NAME_PREFIX                                                 = "set_decoder_out_name_prefix"             ;
  K_SET_DECODER_OUT_NAME_SUFFIX                                                 = "set_decoder_out_name_suffix"             ;
  K_SET_DIMENSIONS                                                              = "set_dimensions"                          ;
  K_SET_PHYSICAL_IMPLEMENTATION                                                 = "set_physical_implementation"             ;
  K_SET_UNIT_ID_ADDRESS                                                         = "set_unit_id_address"                     ;
  K_SET_UNIT_ID                                                                 = "set_unit_id"                             ;
  K_SET_EXTERNAL_UNIT_ENABLE                                                    = "set_external_unit_enable"                ;
  K_SET_VALUE                                                                   = "set_value"                               ;
  K_SET_ENUM                                                                    = "set_enum"                                ;
  K_SET_ENUM_ITEM                                                               = "set_enum_item"                           ;
  K_SET_CONST                                                                   = "set_const"                               ;
  K_SET_FIELD                                                                   = "set_field"                               ;
  K_SET_POSITION                                                                = "set_position"                            ;
  K_SET_NEXT                                                                    = "set_next"                                ;
  K_SET_PREVIOUS                                                                = "set_previous"                            ;
  K_SET_FIELD_POSITION                                                          = "set_field_position"                      ;
  K_SET_TOP_UNIT                                                                = "set_top_unit"                            ;
  K_SET_ADDRESS_INCREMENT                                                       = "set_address_increment"                   ;
  K_SET_NEXT_ADDRESS                                                            = "set_next_address"                        ;
  K_SET_ACCESS_RIGHTS                                                           = "set_access_rights"                       ;
  K_SET_ACCESS_RIGHTS_ENUM                                                      = "set_access_rights_enum"                  ;
  K_SET_DATA_WORD_WIDTH                                                         = "set_data_word_width"                     ;
  K_SET_ALIGNMENT                                                               = "set_alignment"                           ;
  K_SET_ENDIANESS                                                               = "set_endianess"                           ;
  K_SET_NAME_LENGTH                                                             = "set_name_length"                         ;
  K_SET_ADDRESS_VISIBILITY                                                      = "set_address_visibility"                  ;
  K_SET_PREFIX                                                                  = "set_prefix"                              ;
  K_SET_UNIT_NAME                                                               = "set_unit_name"                           ;
  K_SET_SUFFIX                                                                  = "set_suffix"                              ;
  K_SET_ADDR_ABS                                                                = "set_addr_abs"                            ;
  K_SET_ADDR_REL                                                                = "set_addr_rel"                            ;
  K_SET_PAGE_NO                                                                 = "set_page_no"                             ;
  K_SET_NAME_MAX_LENGTH                                                         = "set_name_max_length"                     ;
  K_SET_SYMBOL_MAX_LENGTH                                                       = "set_symbol_max_length"                   ;
  K_SET_SOURCE                                                                  = "set_source"                              ;
  K_SET_COMPARE_EVENT                                                           = "set_compare_event"                       ;
  K_SET_FILE_NAME                                                               = "set_file_name"                           ;
  K_SET_VC_CPP_RD_NAME                                                          = "set_vc_cpp_rd_name"                      ;
  K_SET_VC_CPP_WR_NAME                                                          = "set_vc_cpp_wr_name"                      ;
  K_SET_VC_START_GENERATION_TRIGGER                                             = "set_vc_start_generation_trigger"         ;
  K_SET_VC_MAX_NUMBER_OF_MISMATCHES                                             = "set_vc_max_number_of_mismatches"         ;
  K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS                                     = "set_vc_max_number_of_valid_transactions" ;
  K_SET_VC_VALID_OUTPUT_TRANSACTION                                             = "set_vc_valid_output_transaction"         ;
  K_SET_TRANSACTION_TYPE                                                        = "set_transaction_type"                    ;
  K_SET_DUT_MEM_INIT_FILE                                                       = "set_dut_mem_init_file"                   ;
  K_SET_CAPTURE_EVENT                                                           = "set_capture_event"                       ;
  K_SET_VC_COMPARE_TRIGGER                                                      = "set_vc_compare_trigger"                  ;
  K_SET_ADD_CLOCK                                                               = "add_clock"                               ;
  K_SET_MODEL                                                                   = "set_model"                               ;
  K_SET_CPP_VECTOR_RD_NAME                                                      = "set_cpp_vector_rd_name"                  ;
  K_SET_CPP_VECTOR_WR_NAME                                                      = "set_cpp_vector_wr_name"                  ;
  K_SET_MAX_NUM_OF_VECTORS                                                      = "set_max_num_of_vectors"                  ;
  K_SET_VC_MAX_CYCLES                                                           = "set_vc_max_cycles"                       ;
  K_SET_NUMBER_OF_PIPESTAGES                                                    = "set_number_of_pipestages"                ;
  K_SET_PREVIOUS_PIPESTAGE                                                      = "set_previous_pipestage"                  ;
  K_SET_NEXT_PIPESTAGE                                                          = "set_next_pipestage"                      ;
  K_SET_PIPESTAGE_NUMBER                                                        = "set_pipestage_number"                    ;
  K_SET_PIPESTAGE_NAME                                                          = "set_pipestage_name"                      ;
  K_SET_PIPESTAGE_VALID_INPUT                                                   = "set_pipestage_valid_input"               ;
  K_SET_PIPESTAGE_VALID_OUTPUT                                                  = "set_pipestage_valid_output"              ;
  K_SET_VC_NAME                                                                 = "set_vc_name"                             ;
  K_SET_VC_HEADER_COMMENT                                                       = "set_vc_header_comment"                   ;
  K_SET_VERSION                                                                 = "set_version"                             ;
  K_SET_VC_CLOCK                                                                = "set_vc_clock"                            ;
  K_SET_VC_RESET                                                                = "set_vc_reset"                            ;
  K_SET_VC_STALL                                                                = "set_vc_stall"                            ;
  K_SET_VC_END_GENERATION_TRIGGER                                               = "set_vc_end_generation_trigger"           ;
  K_SET_VC_CAPTURE_EDGE_TYPE                                                    = "set_vc_capture_edge_type"                ;
  K_SET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS                                         = "set_vc_max_number_of_capture_events"     ;
  K_SET_VC_MAX_NUM_OF_TRANSACTION_EVENTS                                        = "set_vc_max_num_of_transaction_events"    ;
  K_SET_RESET_NAME                                                              = "set_reset_name"                          ;
  K_SET_CLOCK_NAME                                                              = "set_clock_name"                          ;
  K_SET_RD_CLOCK_NAME                                                           = "set_rd_clock_name"                       ;
  K_SET_WR_CLOCK_NAME                                                           = "set_wr_clock_name"                       ;
  K_SET_PUSH_NAME                                                               = "set_push_name"                           ;
  K_SET_POP_NAME                                                                = "set_pop_name"                            ;
  K_SET_FULL_NAME                                                               = "set_full_name"                           ;
  K_SET_EMPTY_NAME                                                              = "set_empty_name"                          ;
  K_SET_WR_DATA_NAME                                                            = "set_wr_data_name"                        ;
  K_SET_RD_DATA_NAME                                                            = "set_rd_data_name"                        ;
  K_SET_VALID_NAME                                                              = "set_valid_name"                          ;
  K_SET_WR_ADDR_NAME                                                            = "set_wr_addr_name"                        ;
  K_SET_RD_ADDR_NAME                                                            = "set_rd_addr_name"                        ;
  K_SET_WR_EN_NAME                                                              = "set_wr_en_name"                          ;  
  K_SET_RD_EN_NAME                                                              = "set_rd_en_name"                          ;  
  K_SET_METHOD                                                                  = "set_method"                              ;
  K_SET_PIPESTAGE                                                               = "set_pipestage"                           ;
  K_SET_MSB                                                                     = "set_msb"                                 ;
  K_SET_LSB                                                                     = "set_lsb"                                 ;
  K_SET_UPPER_INDEX                                                             = "set_upper_index"                         ;
  K_SET_LOWER_INDEX                                                             = "set_lower_index"                         ;
  K_SET_NUM_RD_IFC                                                              = "set_num_rd_ifc"                          ;
  K_SET_NUM_WR_IFC                                                              = "set_num_wr_ifc"                          ;
  K_SET_CLOCK                                                                   = "set_clock"                               ;


//*******************************************************************************//
//***  MODIFIERS   ***//
//*******************************************************************************//
  K_CONST                                                                       = "const"                                   ;
  K_INT                                                                         = "int"                                     ;


//*******************************************************************************//
//*** GET COMMANDS ***//
//*******************************************************************************//
  K_GET_INTERFACE                                                               = "get_interface"                           ;
  K_GET_SIGNAL_VALUE                                                            = "get_signal_value"                        ;
  K_GET_TYPE                                                                    = "get_type"                                ;
  K_GET_ATTR                                                                    = "get_attr"                                ;
  K_GET_UNIT_PREFIX                                                             = "get_unit_prefix"                         ;
  K_GET_SIGNAL_PREFIX                                                           = "get_signal_prefix"                       ;
  K_GET_SIGNAL_PREFIX_LOCAL                                                     = "get_signal_prefix_local"                 ;
  K_GET_DEPTH                                                                   = "get_depth"                               ;
  K_GET_ATTRIBUTES                                                              = "get_attributes"                          ;
  K_GET_INPUT_FIELD                                                             = "get_input_field"                         ;
  K_GET_OUTPUT_FIELD                                                            = "get_output_field"                        ;
  K_GET_LOCK_ENABLE_BIT                                                         = "get_lock_enable_bit"                     ;
  K_GET_CNT_DIR_SIGNAL                                                          = "get_cnt_dir_signal"                      ;
  K_GET_WIDTH                                                                   = "get_width"                               ;
  K_GET_DIM_WIDTH                                                               = "get_dim_width"                           ;
  K_GET_BITRANGE                                                                = "get_bitrange"                            ;
  K_GET_DIM_BITRANGE                                                            = "get_dim_bitrange"                        ;
  K_GET_RANGE                                                                   = "get_range"                               ;
  K_GET_LOWER_INDEX                                                             = "get_lower"                               ;
  K_GET_DIM_LOWER_INDEX                                                         = "get_dim_lower"                           ;
  K_GET_UPPER_INDEX                                                             = "get_upper"                               ;
  K_GET_DIM_UPPER_INDEX                                                         = "get_dim_upper"                           ;
  K_GET_OFFSET                                                                  = "get_offset"                              ;
  K_GET_DIM_OFFSET                                                              = "get_dim_offset"                          ;
  K_GET_NUMBER_OF_DIMENSIONS                                                    = "get_number_of_dimensions"                ;
  K_GET_CELL                                                                    = "get_cell"                                ;
  K_GET_TRANSACTION_TIMEOUT_COUNT                                               = "get_transaction_timeout_count"           ;
  K_GET_SIMULATION_TIMEOUT_COUNT                                                = "get_simulation_timeout_count"            ;
  K_GET_VC_ID                                                                   = "get_vc_id"                               ;
  K_GET_VC_MAX_NUM_STATES                                                       = "get_vc_max_num_states"                   ;
  K_GET_NAME                                                                    = "get_name"                                ;
  K_GET_FILENAME                                                                = "get_filename"                            ;
  K_GET_MAX_NUM_VECTORS                                                         = "get_max_num_vectors"                     ;
  K_GET_MAX_ERROR_COUNT                                                         = "get_max_error_count"                     ;
  K_GET_ISA                                                                     = "get_isa"                                 ;
  K_GET_MNEMONIC                                                                = "get_mnemonic"                            ;
  K_GET_VALUE                                                                   = "get_value"                               ;
  K_GET_ENUM                                                                    = "get_enum"                                ;
  K_GET_ENUM_ITEM                                                               = "get_enum_item"                           ;
  K_GET_CONST                                                                   = "get_const"                               ;
  K_GET_FIELD                                                                   = "get_field"                               ;
  K_GET_FIELDLIST                                                               = "get_fieldlist"                           ;
  K_GET_NEXT_ADDRESS                                                            = "get_next_address"                        ;
  K_GET_ACCESS_RIGHTS_ENUM                                                      = "get_access_rights_enum"                  ;
  K_GET_LOWER_BOUND                                                             = "get_lower_bound"                         ;
  K_GET_UPPER_BOUND                                                             = "get_upper_bound"                         ;
  K_GET_DATA_WORD_WIDTH                                                         = "get_data_word_width"                     ;
  K_GET_ALIGNMENT                                                               = "get_alignment"                           ;
  K_GET_ENDIANESS                                                               = "get_endianess"                           ;
  K_GET_NAME_LENGTH                                                             = "get_name_length"                         ;
  K_GET_ADDRESS_VISIBILITY                                                      = "get_address_visibility"                  ;
  K_GET_PREFIX                                                                  = "get_prefix"                              ;
  K_GET_SUFFIX                                                                  = "get_suffix"                              ;
  K_GET_SYMBOL_LENGTH                                                           = "get_symbol_length"                       ;
  K_GET_ADDR_INCREMENT                                                          = "get_address_increment"                   ;
  K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS                                     = "get_vc_max_number_of_valid_transactions" ;
  K_GET_VC_NAME                                                                 = "get_vc_name"                             ;
  K_GET_VC_HEADER_COMMENT                                                       = "get_vc_header_comment"                   ;
  K_GET_VC_CLOCK                                                                = "get_vc_clock"                            ;
  K_GET_VC_RESET                                                                = "get_vc_reset"                            ;
  K_GET_VC_STALL                                                                = "get_vc_stall"                            ;
  K_GET_VC_COMPARE_TRIGGER                                                      = "get_vc_compare_trigger"                  ;
  K_GET_VC_START_GENERATION_TRIGGER                                             = "get_vc_start_generation_trigger"         ;
  K_GET_VC_END_GENERATION_TRIGGER                                               = "get_vc_end_generation_trigger"           ;
  K_GET_VC_CAPTURE_EDGE_TYPE                                                    = "get_vc_capture_edge_type"                ;
  K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS                                         = "get_vc_max_number_of_capture_events"     ;
  K_GET_VC_MAX_NUMBER_OF_MISMATCHES                                             = "get_vc_max_number_of_mismatches"         ;
  K_GET_VC_TIMEOUT                                                              = "get_vc_timeout"                          ;
  K_GET_VC_OUTPUT_FILENAME                                                      = "get_vc_output_filename"                  ;
  K_GET_VC_CPP_RD_NAME                                                          = "get_vc_cpp_rd_name"                      ;
  K_GET_VC_CPP_WR_NAME                                                          = "get_vc_cpp_wr_name"                      ;
  K_GET_VC_RADIX                                                                = "get_vc_radix"                            ;
  K_GET_VC_MODULE                                                               = "get_vc_module"                           ;
  K_GET_OUTPUT_FILENAME                                                         = "get_output_filename"                     ;
  K_GET_RESET_NAME                                                              = "get_reset_name"                          ;
  K_GET_CLOCK_NAME                                                              = "get_clock_name"                          ;
  K_GET_RD_CLOCK_NAME                                                           = "get_rd_clock_name"                       ;
  K_GET_WR_CLOCK_NAME                                                           = "get_wr_clock_name"                       ;
  K_GET_PUSH_NAME                                                               = "get_push_name"                           ;
  K_GET_POP_NAME                                                                = "get_pop_name"                            ;
  K_GET_FULL_NAME                                                               = "get_full_name"                           ;
  K_GET_EMPTY_NAME                                                              = "get_empty_name"                          ;
  K_GET_WR_DATA_NAME                                                            = "get_wr_data_name"                        ;
  K_GET_RD_DATA_NAME                                                            = "get_rd_data_name"                        ;
  K_GET_VALID_NAME                                                              = "get_valid_name"                          ;
  K_GET_WR_ADDR_NAME                                                            = "get_wr_addr_name"                        ;
  K_GET_RD_ADDR_NAME                                                            = "get_rd_addr_name"                        ;
  K_GET_WR_EN_NAME                                                              = "get_wr_en_name"                          ;  
  K_GET_RD_EN_NAME                                                              = "get_rd_en_name"                          ;  
  K_GET_PIPESTAGE                                                               = "get_pipestage"                           ;
  K_GET_MSB                                                                     = "get_msb"                                 ;
  K_GET_LSB                                                                     = "get_lsb"                                 ;
  K_GET_RADIX                                                                   = "get_radix"                               ;


//*******************************************************************************//
//*** MISCELLANEOUS ***//
//*******************************************************************************//
  K_CLASS                                                                       = "class"                                   ;
  K_PUBLIC                                                                      = "public"                                  ;
  K_CSL_BUILD                                                                   = "initialize"                              ;
  K_INCLUDE                                                                     = "#include"                                ;
  K_ADD_INSTANCE                                                                = "add_instance"                            ;
  K_ADD_INSTANCE_LIST                                                           = "add_instance_list"                       ;
  K_ADD_PORT                                                                    = "add_port"                                ;
  K_ADD_PORT_LIST                                                               = "add_port_list"                           ;
  K_REMOVE_PORT                                                                 = "remove_port"                             ;
  K_REMOVE_PORT_LIST                                                            = "remove_port_list"                        ;
  K_REVERSE                                                                     = "reverse"                                 ;
  K_ADD_INTERFACE                                                               = "add_interface"                           ;
  K_ADD_SIGNAL                                                                  = "add_signal"                              ;
  K_ADD_SIGNAL_LIST                                                             = "add_signal_list"                         ;
  K_ADD_UNIT_PARAMETER                                                          = "add_unit_parameter"                      ;
  K_OVERRIDE_PARAMETER                                                          = "override_parameter"                      ;
  K_AUTO_CONNECT_WIDTH_INFERENCE                                                = "auto_connect_width_inference"            ;
  K_AUTO_CONNECT_VERILOG_AND_CSL                                                = "auto_connect_verilog_and_csl"            ;
  K_AUTO_CONNECT_FILTER                                                         = "auto_connect_filter"                     ;
  K_ADD_VALID_TO_REG                                                            = "add_valid_to_register"                   ;
  K_CREATE_RTL_MODULE                                                           = "create_rtl_module"                       ;
  K_DIRECTIVE                                                                   = "directive"                               ;            
  K_INDEX_DATA_PAIR                                                             = "index_data_pair"                         ;
  K_ADD_LOGIC                                                                   = "add_logic"                               ;
  K_RESET_VALUE                                                                 = "reset_value"                             ;
  K_CLEAR_VALUE                                                                 = "clear_value"                             ;
  K_STOP_AT_END_VALUE                                                           = "stop_at_end_value"                       ;
  K_ADD_VALUE                                                                   = "add_value"                               ;
  K_COLUMN_NAME                                                                 = "column_name"                             ;
  K_ROW_NAME                                                                    = "row_name"                                ;
  K_ADD_COLUMN                                                                  = "add_column"                              ;
  K_ADD_ROW                                                                     = "add_row"                                 ;
  K_MATRIX                                                                      = "matrix"                                  ;
  K_CONNECT_SPLIT                                                               = "connect_split"                           ;
  K_MERGE                                                                       = "merge"                                   ; 
  K_INVERT                                                                      = "invert"                                  ;
  K_BUFFER                                                                      = "buffer"                                  ;
  K_CONCAT                                                                      = "concat"                                  ;
  K_CONNECT                                                                     = "connect"                                 ;
  K_INPUT_VERILOG_TYPE                                                          = "input_verilog_type"                      ;
  K_OUTPUT_VERILOG_TYPE                                                         = "output_verilog_type"                     ;
  K_AUTOROUTER                                                                  = "autorouter"                              ;
  K_REMOVE_SIGNAL                                                               = "remove_signal"                           ;
  K_REMOVE_SIGNAL_LIST                                                          = "remove_signal_list"                      ;
  //  K_GENERATE_INDIVIDUAL_RTL_SIGNALS                                             = "generate_individual_rtl_signals"         ;
  K_ADD_SIGNAL_GROUP                                                            = "add_signal_group"                        ;
  K_ADD_PORT_GROUP                                                              = "add_port_group"                          ;
  K_1995                                                                        = "v1995"                                   ;
  K_2001                                                                        = "v2001"                                   ;
  K_2005                                                                        = "v2005"                                   ;
  K_SYSV                                                                        = "sysv"                                    ;
  K_CA                                                                          = "CA"                                      ;
  K_TA                                                                          = "TA"                                      ;
  K_VECNAME                                                                     = "VecName"                                 ;
  K_SIMVER                                                                      = "SimVer"                                  ;
  K_SIMARGS                                                                     = "SimArgs"                                 ;
  K_DATE                                                                        = "date"                                    ;
  K_USER                                                                        = "user"                                    ;
  K_MACHINEARCH                                                                 = "MachineArch"                             ;
  K_OSCILLATOR                                                                  = "oscillator"                              ;
  K_PWL                                                                         = "pwl"                                     ;
  K_CONTINUOUS                                                                  = "continuous"                              ; 
  K_ADD_DUT_INSTANCE                                                            = "add_dut_instance"                        ;
  K_ADD_INCLUDE_FILE                                                            = "include_file"                            ;
  K_ADD_CLOCK_GEN                                                               = "add_clock_gen"                           ;
  K_CLK_OUTPUT                                                                  = "clk_output"                              ;
  K_ADD_RESET                                                                   = "add_reset"                               ;
  K_ADD_VECTOR                                                                  = "add_vector_instance"                     ;
  K_ADD_ARCH_STATE_INSTANCE                                                     = "add_arch_state_instance"                 ;
  K_ADD_DUT_COMPARE_TRIGGER                                                     = "add_dut_compare_trigger"                 ;
  K_ADD_COMMENT                                                                 = "add_comment"                             ;
  K_ADD_TESTBENCH_READ_EVENT                                                    = "add_tb_read_event"                       ;
  K_EXCLUSION_LIST                                                              = "exclusion_list"                          ;
  K_INCLUDE_ONLY                                                                = "include_only"                            ;
  K_ADD_EVENT                                                                   = "add_event"                               ;
  K_ADD_WRITE_EVENT                                                             = "add_write_event"                         ;
  K_ADD_READ_EVENT                                                              = "add_read_event"                          ;
  K_PRINT_SIGNAL_NAME_LIST                                                      = "print_signal_name_list"                  ;
  K_PRINT_SIGNAL_VALUES_LIST                                                    = "print_signal_values_list"                ;
  K_GENERATE_HEADER_COMMENT                                                     = "generate_header_comment"                 ;
  K_ADD_VALID_BIT                                                               = "add_valid_bit_to_last_vector"            ;
  K_ADD_IO_LIST                                                                 = "add_io_list"                             ;
  K_ADD_MISSMATCH_LOGIC                                                         = "add_missmatch_logic"                     ;
  K_ADD_SAMPLE_EVENT                                                            = "add_sample_event"                        ;
  K_ADD_CSIM_UNIT                                                               = "add_csim_unit"                           ;
  K_RTL_COMPARE_LEVEL                                                           = "rtl_compare_level"                       ;
  K_CSIM_COMPARE_LEVEL                                                          = "csim_compare_level"                      ;
  K_CSIM_SAMPLE_LEVEL                                                           = "csim_sample_level"                       ;
  K_ADD_INSTRUCTION_FORMAT                                                      = "add_instruction_format"                  ;
  K_ADD_INSTRUCTION_FORMAT_LIST                                                 = "add_instruction_format_list"             ;
  K_ADD_INSTRUCTION                                                             = "add_instruction"                         ;
  K_ADD_INSTRUCTION_LIST                                                        = "add_instruction_list"                    ;
  K_ADD_FIELD                                                                   = "add_field"                               ;
  K_GENERATE_CPP_HEADER                                                         = "generate_cpp_header"                     ;
  K_GENERATE_VERILOG_HEADER                                                     = "generate_verilog_header"                 ;
  K_PRINT                                                                       = "print"                                   ;
  K_GEN_DECODER                                                                 = "generate_decoder"                        ;
  K_GEN_INTERNAL_UNIT_ENABLE                                                    = "gen_internal_unit_enable"                ;
  K_GEN_PART_SELECT                                                             = "gen_part_select"                         ;
  K_GEN_MUX                                                                     = "gen_mux"                                 ;
  K_ADD_ENUM                                                                    = "add_enum"                                ;
  K_ADD_FIELDLIST                                                               = "add_fieldlist"                           ;
  K_ADD_ALLOWED_RANGE                                                           = "add_allowed_range"                       ;
  K_CREATE_SIGNAL                                                               = "create_signal"                           ;
  K_ADD_ADDRESS_RANGE                                                           = "add_address_range"                       ;
  K_ADD_RESERVED_ADDRESS_RANGE                                                  = "add_reserved_address_range"              ;
  K_ADD                                                                         = "add"                                     ;
  K_AUTO_GEN_MEMORY_MAP                                                         = "auto_gen_memory_map"                     ;
  K_ADD_TO_MEMORY_MAP                                                           = "add_to_memory_map"                       ;
  K_START_STATE_DATA_GENERATION                                                 = "start_state_data_generation"             ;
  K_START_VECTOR_GENERATION                                                     = "start_vector_generation"                 ;
  K_PIPESTAGE_NAMING_CONVENTION                                                 = "pipestage_naming_convention"             ;
  K_ASSOCIATE_PIPELINE                                                          = "associate_pipeline"                      ;
  K_REPLICATE                                                                   = "replicate"                               ;
  K_ADD_PIPESTAGE                                                               = "add_pipestage"                           ;
  K_CONNECT_STALL                                                               = "connect_stall"                           ;
  K_CONNECT_ENABLE                                                              = "connect_enable"                          ;
  K_BRANCH                                                                      = "branch"                                  ;
  K_INLINE_FILE                                                                 = "inline_file"                             ;
  K_INLINE_CODE                                                                 = "inline_code"                             ;
  K_RESET_INIT_VALUE                                                            = "reset_init_value"                        ;
  K_ADD_PIPELINE_DELAY                                                          = "add_pipeline_delay"                      ;
  K_ADD_EQUATION                                                                = "add_equation"                            ;
  K_INITIALIZE_RANDOM_VALUES                                                    = "initialize_random_values"                ;
  K_INITIALIZE_RANDOM                                                           = "initialize_random"                       ;
  K_GEN_UNIQUE_RTL_MODULES                                                      = "gen_unique_rtl_modules"                  ;
  K_NO_PREFIX_COMMAND                                                           = "no_prefix"                               ;
  K_DO_NOT_GEN_RTL                                                              = "do_not_gen_rtl"                          ;
  K_DO_NOT_GEN_CPP                                                              = "do_not_gen_cpp"                          ;
  K_REGISTER_IOS                                                                = "register_ios"                            ;
  K_CONNECT_UNITS                                                               = "connect_units"                           ;
  K_CONNECT_BY_PATTERN                                                          = "connect_by_pattern"                      ;
  K_CONNECT_BY_NAME                                                             = "connect_by_name"                         ;
  


//****************************************************************************************************************************//
//************************************************************** END *********************************************************//
//****************************************************************************************************************************//
}

{
  protected:
    TCslLexerState lexerState() const;
    TChar octStrToChar(const string& str) const;
    TInt convertStrToInt(const string& str);
    TDouble convertStrToReal(const string& str);

  protected: // our own virtual methods
    virtual RefToken makeNumberToken(int t, const RefCslNumber number);

  protected: // from base class
    virtual RefToken makeToken(int t);
}

//TICK        : "'"    ;
BACKTICK   options { paraphrase = "backtick ('`') "            ;} : "`"    ;
AT         options { paraphrase = "at ('@')"                   ;} : "@"    ;
COLON      options { paraphrase = "colon (':')"                ;} : ":"    ;
COMMA      options { paraphrase = "comma (',')"                ;} : ","    ;
DOT        options { paraphrase = "dot ('.')"                  ;} : "."    ;
ASSIGN     options { paraphrase = "assign ('=')"               ;} : "="    ;
MINUS      options { paraphrase = "minus ('-')"                ;} : "-"    ;
LBRACK     options { paraphrase = "left bracket ('[')"         ;} : "["    ;
RBRACK     options { paraphrase = "right bracket (']')"        ;} : "]"    ;
LCURLY     options { paraphrase = "left curly bracket ('{')"   ;} : "{"    ;
RCURLY     options { paraphrase = "right curly bracket ('}')"  ;} : "}"    ;
LPAREN     options { paraphrase = "left paranthesis ('(')"     ;} : "("    ;
RPAREN     options { paraphrase = "right paranthesis (')')"    ;} : ")"    ;
POUND      options { paraphrase = "pound ('#')"                ;} : "#"    ;
QUESTION   options { paraphrase = "question mark ('?')"        ;} : "?"    ;
SEMI       options { paraphrase = "semi colon (';')"           ;} : ";"    ;
PLUS       options { paraphrase = "plus ('+')"                 ;} : "+"    ;
LNOT       options { paraphrase = "logical not ('!')"          ;} : "!"    ;
NOT        options { paraphrase = "not ('~')"                  ;} : "~"    ;
AND        options { paraphrase = "and ('&')"                  ;} : "&"    ;
NAND       options { paraphrase = "nand ('~&')"                ;} : "~&"   ;
OR         options { paraphrase = "or ('|')"                   ;} : "|"    ;
NOR        options { paraphrase = "nor ('~|')"                 ;} : "~|"   ;
// because this test failes the following rules the modified
// tsti[17] = tsti[16] ^^ tsti[15] ^^ tsti[14] ^^ tsti[13] ^^ tsti[11] ^^ tsti[11] ^^ tsti[10] ^^ tsti[9];
//XOR         : "^"    ;
//XNOR        : "~^" | "^~"  ;
XOR         options { paraphrase = "xor ('^')"                       ;} {bool test = false;} :"^" ("~"{test=true;} )? {if(test) $setType(XNOR);};
XNOR        options { paraphrase = "xnor ('~^')"                     ;} : "~^"   ; //^~ is also possible (it must be supported)
STAR        options { paraphrase = "star ('*')"                      ;} : "*"    ;
POW         options { paraphrase = "power ('**')"                    ;} : "**"   ;
DIV         options { paraphrase = "divide ('/')"                    ;} : "/"    ;
MOD         options { paraphrase = "mod ('%')"                       ;} : "%"    ;
EQUAL       options { paraphrase = "equal ('==')"                    ;} : "=="   ;
NOT_EQ      options { paraphrase = "not equal ('!=')"                ;} : "!="   ;
NOT_EQ_CASE options { paraphrase = "not equal case ('!==')"          ;} : "!=="  ;
EQ_CASE     options { paraphrase = "equal case ('===')"              ;} : "==="  ;
LAND        options { paraphrase = "logical and ('&&')"              ;} : "&&"   ;
TAND        options { paraphrase = "tand ('&&&')"                    ;} : "&&&"  ;
LOR         options { paraphrase = "logical or ('||')"               ;} : "||"   ;
LT_         options { paraphrase = "lower then ('<')"                ;} : "<"    ;
LE          options { paraphrase = "lower then or equal to ('<=')"   ;} : "<="   ;
GT          options { paraphrase = "greater then ('>')"              ;} : ">"    ;
GE          options { paraphrase = "greater then or equal to ('>=')" ;} : ">="   ;
SL          options { paraphrase = "shift left ('<<')"               ;} : "<<"   ;
SSL         options { paraphrase = "arithmetic left shift ('<<<')"   ;} : "<<<"  ; // It has the same functionality as SL
SR          options { paraphrase = "shift right ('>>')"              ;} : ">>"   ;
SSR         options { paraphrase = "arithmetic right shift ('>>>')"  ;} : ">>>"  ;
TRIGGER     options { paraphrase = "trigger ('->')"                  ;} : "->"   ;
PPATH       options { paraphrase = "ppath ('=>')"                    ;} : "=>"   ; // ???
FPATH       options { paraphrase = "fpath ('*>')"                    ;} : "*>"   ;
//PSTAR       options { paraphrase = "paranthesis star ('(*')"         ;} : "(*"   ;  // Moved to token declaration //Modifed by Eugen
STARP       options { paraphrase = "star paranthesis ('*)')"         ;} : "*)"   ;
PO_POS      options { paraphrase = "p0_pos ('+:')"                   ;} : "+:"   ;
PO_NEG      options { paraphrase = "p0_neg ('-:')"                   ;} : "-:"   ;
SUPERSTAR   options { paraphrase = "superstar ('(*)')"               ;} : "(*)"  ; //added by Eugen

// White space excluding newline '\r' or '\n'
protected
W : (' ' | '\t' | '\b' | '\f') ;

protected
END_OF_LINE 
: ( ("\r\n") => "\r\n"
  | '\r'
  | '\n'
  )
  { newline(); }
;

protected
VOCAB : '\3'..'\377' ;

protected
ALPHA : 'a'..'z' | 'A'..'Z' | '_' ;

protected
DIGIT : '0'..'9' ;

protected
NZ_DIGIT : '1'..'9' ;

protected
BIN_DIGIT : '0'..'1' ;

protected
OCT_DIGIT : '0'..'7' ;

protected
HEX_DIGIT : ('0'..'9') | ('a'..'f') | ('A'..'F');

protected
XZ_DIGIT : 'x' | 'X' | 'z' | 'Z' | '?' ;

IDENTIFIER
  options { 
    testLiterals = true; 
    paraphrase = "an identifier";
  }
  // now it is checked manually
: ALPHA (ALPHA | DIGIT | '$')*
;

ESCAPED_IDENTIFIER { char c = 0xFF; } :
    '\\'! { $append(c); }
    ( ~('.' | ' ' | '\t' | '\b' | '\f' | '\r' | '\n')
      |! '.' { $append(c); }
    )+
    (' '! | '\t'! | '\b'! | '\f'! | END_OF_LINE!)?
    ;

STRING :
    '"'! 
    ( ('\\' ~('\r' | '\n'))
    | ~('"' | '\r' | '\n' | '\\')
    )* 
    '"'!
;

protected
UNSIGNED_NUMBER :
    (DIGIT) (DIGIT | '_' )*
    ;

protected
NZ_UNSIGNED_NUMBER :
    (NZ_DIGIT) (DIGIT | '_' )*
    ;

protected
REAL_NUMBER :
    UNSIGNED_NUMBER '.' UNSIGNED_NUMBER
    ;

protected
REAL_NUMBER_EXP :
    UNSIGNED_NUMBER ('.' UNSIGNED_NUMBER)? EXP (SIGN)? UNSIGNED_NUMBER
    ;

protected
SIGN : '+' | '-' ;

protected
EXP : 'e' | 'E';

protected
XZ_NUMBER //returns [ bool hasXZ ]
: XZ_DIGIT ('_')* 
//  { hasXZ = true; }
;

protected
BIN_NUMBER  returns [ bool hasXZ ]
{ hasXZ = false; }
: (BIN_DIGIT | XZ_DIGIT { hasXZ = true; }) (BIN_DIGIT | XZ_DIGIT { hasXZ = true; } | '_')* ;

protected
OCT_NUMBER returns [ bool hasXZ ]
{ hasXZ = false; }
: (OCT_DIGIT | XZ_DIGIT { hasXZ = true; }) (OCT_DIGIT | XZ_DIGIT { hasXZ = true; } | '_')* ;

protected
HEX_NUMBER returns [ bool hasXZ ]
{ hasXZ = false; }
: (HEX_DIGIT | XZ_DIGIT { hasXZ = true; }) (HEX_DIGIT | XZ_DIGIT { hasXZ = true; } | '_')* ;

NUMBER { RefCslNumber vn;}
: ( vn = BASED_NUMBER[CslNumber::NOT_SIZED]
    {
      $setToken(makeNumberToken(BASED_NUMBER, vn));
    }
  | ( UNSIGNED_NUMBER ('.' UNSIGNED_NUMBER)? EXP) => r_exp:REAL_NUMBER_EXP
    {
      $setToken(makeNumberToken(REAL_NUMBER, CslNumber::build( _RS(r_exp->getText()), CslNumber::NUM_REAL ) ) );
    }
  | (UNSIGNED_NUMBER '.') => r:REAL_NUMBER 
    {
      $setToken(makeNumberToken(REAL_NUMBER, CslNumber::build( _RS(r->getText()), CslNumber::NUM_REAL ) ) );
    }
  | u:UNSIGNED_NUMBER
    {
      $setToken(makeNumberToken(UNSIGNED_NUMBER, CslNumber::build( _RS(u->getText()), CslNumber::NUM_BASED ) ) );
    }
  )
  {
    assert(_token.get());
    _token->setText(text.substr(_begin, text.length()-_begin));
  }
;
exception
catch [NoViableAltForCharException& e] {
  //  DCERR("Lexer NVAFCE" << e.toString());
  // this catch ovverides the default lexer catch for this kind of exception that prints unwanted messages
  // if the consume() from the end of the block is removed then this exception will be thrown over and over again
  // - 1 : this exception can't be caught by parser, and thus it is caught by main which just prints it = unwanted behaviour,
  //        so it is caught here and ignored
  // - 2 : a similar exception is caught by parser and a error is printed = wanted behaviour
  // so nothing is lost
  consume();
}
catch [ANTLRException& e] {
  //  throw e;
  //  DCERR(getFilename());
  //  throw RecognitionException(e.getMessage(), e.getFilename(), e.getLine(), e.getColumn());
  //  DCERR("Lexer ANTLRE:" << e.toString());
  //consume();
}


protected
BASED_NUMBER_HEADER returns [TBool s]:
  { s = FALSE; }
  '\''
  (('s' | 'S') { s = TRUE; })?
  ;

protected
BASED_NUMBER [TInt size] returns [RefCslNumber vn] { TBool isSigned; TBool hasXZ; } 
: ( BASED_NUMBER_HEADER ('d' | 'D') )  => isSigned = BASED_NUMBER_HEADER ('d' | 'D') (' ' | '\t')*
  ( UNSIGNED_NUMBER
    {
      vn = CslNumber::build( _RS(getText()), CslNumber::NUM_BASED, isSigned, CslNumber::BASE_DEC, size, false );
    }
  | xz:XZ_NUMBER
    {
      vn = CslNumber::build( _RS(getText()), CslNumber::NUM_BASED, isSigned, CslNumber::BASE_DEC, size, true );
    }
  )
| (BASED_NUMBER_HEADER ('b' | 'B')) => isSigned = BASED_NUMBER_HEADER ('b' | 'B') (' ' | '\t')* hasXZ = BIN_NUMBER
  {
    vn = CslNumber::build( _RS(getText()), CslNumber::NUM_BASED, isSigned, CslNumber::BASE_BIN, size, hasXZ );
  }
| (BASED_NUMBER_HEADER ('o' | 'O')) => isSigned = BASED_NUMBER_HEADER ('o' | 'O') (' ' | '\t')* hasXZ = OCT_NUMBER
  {
    vn = CslNumber::build( _RS(getText()), CslNumber::NUM_BASED, isSigned, CslNumber::BASE_OCT, size, hasXZ );
  }
| (BASED_NUMBER_HEADER ('h' | 'H')) => isSigned = BASED_NUMBER_HEADER ('h' | 'H') (' ' | '\t')* hasXZ = HEX_NUMBER
  {
    vn = CslNumber::build( _RS(getText()), CslNumber::NUM_BASED, isSigned, CslNumber::BASE_HEX, size, hasXZ);
  }
;
//exception
//catch [ANTLRException& e] {
//  //  throw e;
//  //  DCERR(getFilename());
//  //  throw RecognitionException(e.getMessage(), e.getFilename(), e.getLine(), e.getColumn());
//  DCERR("Lexer ANTLRE:" << e.toString());
//  //  consume();
//}

SYSTEM_TASK_NAME
        options { testLiterals = true; }
    :
    '$' (ALPHA | DIGIT | '$')+
    ;

protected
FILENAME : (~'"')* ;

DIRECTIVE 
: '`'!  
  ( i:IDENTIFIER ( (W)+ (~(' ' | '\t' | '\b' | '\f' | '\r' | '\n')) (~('\r' | '\n'))* )?)
  (END_OF_LINE!)?
  {
    cout << "WARNING: Directives are ignored" << endl;
    $setType(Token::SKIP);
  }
;

WS :
    (
       W
     | END_OF_LINE
    )
    { $setType(Token::SKIP); }
    ;

SL_COMMENT :
    "//" (~('\r' | '\n'))* (END_OF_LINE)?
    { $setType(Token::SKIP); }
    ;

ML_COMMENT :
    "/*"
    (  { LA(2) != '/' }? '*'
     | END_OF_LINE
     | ~('*' | '\r' | '\n')
    )*
    "*/"
    { $setType(Token::SKIP); }
    ;


 // End of File
