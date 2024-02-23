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

#include "cGenBase_tb.h"

//-----------------------------------stuff-----------------------------------//
ECSLChapter                                             testChapter;

string                                                  testErrorLog;
string                                                  absoluteTestPath;
string                                                  testFileHeader;

unsigned long                                           testStartTime;
unsigned long                                           testEndTime;
unsigned long                                           testCounter;

//-----------------------------------chapters-----------------------------------//
CSLChapter                                              cptFifo(CPT_FIFO);
CSLChapter                                              cptIntercon(CPT_INTERCON);
CSLChapter                                              cptIsa(CPT_ISA);
CSLChapter                                              cptLang(CPT_LANG);
CSLChapter                                              cptMem(CPT_MEM);
CSLChapter                                              cptMemMap(CPT_MEM_MAP);
CSLChapter                                              cptReg(CPT_REG);
CSLChapter                                              cptRegFile(CPT_REG_FILE);
CSLChapter                                              cptTestb(CPT_TESTB);
CSLChapter                                              cptVerifc(CPT_VERIFC);

string                                                  cFifo;
string                                                  cInterconnect;
string                                                  cIsa;
string                                                  cLanguage;
string                                                  cMemory;
string                                                  cMemMap;
string                                                  cRegister;
string                                                  cRegisterFile;
string                                                  cTestbench;
string                                                  cVerifComp;

//-----------------------------------names-----------------------------------//
ECSLClassStringMap                                      cslGenericName;
ECSLClassStringMap                                      cslTypeName;
ECSLClassStringMap                                      cslObjName;
ECSLClassStringMap                                      cslObj1Name;
ECSLClassStringMap                                      cslObj2Name;
ECSLClassStringMap                                      cslParamName;
ECSLClassStringMap                                      cslInst1Name;

ECSLCmdStringMap                                        cslCmdName;

//-----------------------------------containers-----------------------------------//
CSLClass                                                cslBitrange(&cptLang,           CSL_BITRANGE,           false);
CSLClass                                                cslEnum(&cptLang,               CSL_ENUM,               false, make_pair("{", "}"));
CSLClass                                                cslEnumItem(&cptLang,           CSL_ENUM_ITEM,          false);
CSLClass                                                cslEvent(&cptLang,              CSL_EVENT,              false);
CSLClass                                                cslField(&cptLang,              CSL_FIELD,              true);
CSLClass                                                cslFifo(&cptFifo,               CSL_FIFO,               true);
CSLClass                                                cslInterface(&cptIntercon,      CSL_INTERFACE,          true);
CSLClass                                                cslIsaField(&cptIsa,            CSL_ISA_FIELD,          true);
CSLClass                                                cslMemory(&cptMem,              CSL_MEMORY,             true);
CSLClass                                                cslMemMap(&cptMemMap,           CSL_MEMORY_MAP,         true);
CSLClass                                                cslMemMapPage(&cptMemMap,       CSL_MEMORY_MAP_PAGE,    true);
CSLClass                                                cslMultiDimBitrange(&cptLang,   CSL_MULTI_DIM_BITRANGE, false);
CSLClass                                                cslPort(&cptIntercon,           CSL_PORT,               false);
CSLClass                                                cslRegister(&cptReg,            CSL_REGISTER,           true);
CSLClass                                                cslRegFile(&cptRegFile,         CSL_REGISTER_FILE,      true);
CSLClass                                                cslSignal(&cptIntercon,         CSL_SIGNAL,             false);
CSLClass                                                cslSigGroup(&cptIntercon,       CSL_SIGNAL_GROUP,       true);
CSLClass                                                cslStateData(&cptVerifc,        CSL_STATE_DATA,         true);
CSLClass                                                cslTestbench(&cptTestb,         CSL_TESTBENCH,          true);
CSLClass                                                cslUnit(&cptIntercon,           CSL_UNIT,               true);
CSLClass                                                cslVector(&cptVerifc,           CSL_VECTOR,             true);

CSLClassPointVect                                       cslClasses;

CSLCmdPointVect                                         cslCmds;

//-----------------------------------global functions-----------------------------------//
template<class T1, class T2>
  string getName(map<T1, string> mapType, T1 index) {
  T2 it = mapType.find(index);
  if (it != mapType.end()) {
    return (*it).second;
  }

  #ifdef _CGEN_DEBUG_MODE_
  ASSERT(FAIL, "getName(...) returns empty string");
  #endif

  return EMPTY_STRING;
}

string intToString(int val) {
  stringstream ss;
  ss << val;
  return ss.str();
}

string getTime() {
  time_t rawtime;
  time(&rawtime);
  tm* ptm = localtime(&rawtime);
  return string(asctime(ptm));
}

void getTime(unsigned long& storeTo) {
  storeTo = time(NULL);
}

void buildGenericNames() {
  cslGenericName.insert(make_pair(CSL_BITRANGE,                         "bitrange"));
  cslGenericName.insert(make_pair(CSL_ENUM,                             "enum"));
  cslGenericName.insert(make_pair(CSL_ENUM_ITEM,                        "enum_item"));
  cslGenericName.insert(make_pair(CSL_EVENT,                            "event"));
  cslGenericName.insert(make_pair(CSL_FIELD,                            "field"));
  cslGenericName.insert(make_pair(CSL_FIFO,                             "fifo"));
  cslGenericName.insert(make_pair(CSL_INTERFACE,                        "interface"));
  cslGenericName.insert(make_pair(CSL_ISA_FIELD,                        "isa_field"));
  cslGenericName.insert(make_pair(CSL_MEMORY,                           "memory"));
  cslGenericName.insert(make_pair(CSL_MEMORY_MAP,                       "memory_map"));
  cslGenericName.insert(make_pair(CSL_MEMORY_MAP_PAGE,                  "memory_map_page"));
  cslGenericName.insert(make_pair(CSL_MULTI_DIM_BITRANGE,               "multi_dim_bitrange"));
  cslGenericName.insert(make_pair(CSL_PORT,                             "port"));
  cslGenericName.insert(make_pair(CSL_REGISTER,                         "register"));
  cslGenericName.insert(make_pair(CSL_REGISTER_FILE,                    "register_file"));
  cslGenericName.insert(make_pair(CSL_SIGNAL,                           "signal"));
  cslGenericName.insert(make_pair(CSL_SIGNAL_GROUP,                     "signal_group"));
  cslGenericName.insert(make_pair(CSL_STATE_DATA,                       "state_data"));
  cslGenericName.insert(make_pair(CSL_TESTBENCH,                        "testbench"));
  cslGenericName.insert(make_pair(CSL_UNIT,                             "unit"));
  cslGenericName.insert(make_pair(CSL_VECTOR,                           "vector"));
}

void buildCmdNames() {
  cslCmdName.insert(make_pair(CMD_ADD,                                  "add"));
  cslCmdName.insert(make_pair(CMD_ADD_ADDRESS_RANGE,                    "add_address_range"));
  cslCmdName.insert(make_pair(CMD_ADD_ALLOWED_RANGE,                    "add_allowed_range"));
  cslCmdName.insert(make_pair(CMD_ADD_EQUATION,                         "add_equation"));
  cslCmdName.insert(make_pair(CMD_ADD_LOGIC,                            "add_logic"));
  cslCmdName.insert(make_pair(CMD_ADD_RESERVED_ADDRESS_RANGE,           "add_reserved_address_range"));
  cslCmdName.insert(make_pair(CMD_ADD_TO_MEMORY_MAP,                    "add_to_memory_map"));
  cslCmdName.insert(make_pair(CMD_AUTO_GEN_MEMORY_MAP,                  "auto_gen_memory_map"));
  cslCmdName.insert(make_pair(CMD_CONCAT,                               "concat"));
  cslCmdName.insert(make_pair(CMD_CONNECT,                              "connect"));
  cslCmdName.insert(make_pair(CMD_CREATE_RTL_MODULE,                    "create_rtl_module"));
  cslCmdName.insert(make_pair(CMD_DIRECTIVE,                            "directive"));
  cslCmdName.insert(make_pair(CMD_EXCLUSION_LIST,                       "exclusion_list"));
  cslCmdName.insert(make_pair(CMD_GEN_DECODER,                          "gen_decoder"));
  cslCmdName.insert(make_pair(CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS,      "generate_individual_rtl_signals"));
  cslCmdName.insert(make_pair(CMD_GET_ADDRESS_INCREMENT,                "get_address_increment"));
  cslCmdName.insert(make_pair(CMD_GET_ALIGNMENT,                        "get_alignment"));
  cslCmdName.insert(make_pair(CMD_GET_ATTR,                             "get_attr"));
  cslCmdName.insert(make_pair(CMD_GET_ATTRIBUTES,                       "get_attributes"));
  cslCmdName.insert(make_pair(CMD_GET_BITRANGE,                         "get_bitrange"));
  cslCmdName.insert(make_pair(CMD_GET_CLOCK_NAME,                       "get_clock_name"));
  cslCmdName.insert(make_pair(CMD_GET_CNT_DIR_SIGNAL,                   "get_cnt_dir_signal"));
  cslCmdName.insert(make_pair(CMD_GET_DATA_WORD_WIDTH,                  "get_data_word_width"));
  cslCmdName.insert(make_pair(CMD_GET_DEPTH,                            "get_depth"));
  cslCmdName.insert(make_pair(CMD_GET_DIM_BITRANGE,                     "get_dim_bitrange"));
  cslCmdName.insert(make_pair(CMD_GET_DIM_LOWER,                        "get_dim_lower"));
  cslCmdName.insert(make_pair(CMD_GET_DIM_OFFSET,                       "get_dim_offset"));
  cslCmdName.insert(make_pair(CMD_GET_DIM_UPPER,                        "get_dim_upper"));
  cslCmdName.insert(make_pair(CMD_GET_DIM_WIDTH,                        "get_dim_width"));
  cslCmdName.insert(make_pair(CMD_GET_EMPTY_NAME,                       "get_empty_name"));
  cslCmdName.insert(make_pair(CMD_GET_ENDIANESS,                        "get_endianess"));
  cslCmdName.insert(make_pair(CMD_GET_ENUM,                             "get_enum"));
  cslCmdName.insert(make_pair(CMD_GET_ENUM_ITEM,                        "get_enum_item"));
  cslCmdName.insert(make_pair(CMD_GET_FULL_NAME,                        "get_full_name"));
  cslCmdName.insert(make_pair(CMD_GET_LOWER,                            "get_lower"));
  cslCmdName.insert(make_pair(CMD_GET_LOWER_BOUND,                      "get_lower_bound"));
  cslCmdName.insert(make_pair(CMD_GET_LOWER_INDEX,                      "get_lower_index"));
  cslCmdName.insert(make_pair(CMD_GET_MNEMONIC,                         "get_mnemonic"));
  cslCmdName.insert(make_pair(CMD_GET_NEXT_ADDRESS,                     "get_next_address"));
  cslCmdName.insert(make_pair(CMD_GET_OFFSET,                           "get_offset"));
  cslCmdName.insert(make_pair(CMD_GET_OUTPUT_FILENAME,                  "get_output_filename"));
  cslCmdName.insert(make_pair(CMD_GET_POP_NAME,                         "get_pop_name"));
  cslCmdName.insert(make_pair(CMD_GET_PREFIX,                           "get_prefix"));
  cslCmdName.insert(make_pair(CMD_GET_PUSH_NAME,                        "get_push_name"));
  cslCmdName.insert(make_pair(CMD_GET_RADIX,                            "get_radix"));
  cslCmdName.insert(make_pair(CMD_GET_RD_ADDR_NAME,                     "get_rd_addr_name"));
  cslCmdName.insert(make_pair(CMD_GET_RD_CLOCK_NAME,                    "get_rd_clock_name"));
  cslCmdName.insert(make_pair(CMD_GET_RD_DATA_NAME,                     "get_rd_data_name"));
  cslCmdName.insert(make_pair(CMD_GET_RD_EN_NAME,                       "get_rd_en_name"));
  cslCmdName.insert(make_pair(CMD_GET_RESET_NAME,                       "get_reset_name"));
  cslCmdName.insert(make_pair(CMD_GET_SIGNAL_PREFIX,                    "get_signal_prefix"));
  cslCmdName.insert(make_pair(CMD_GET_SIGNAL_PREFIX_LOCAL,              "get_signal_prefix_local"));
  cslCmdName.insert(make_pair(CMD_GET_SIMULATION_TIMEOUT_COUNT,         "get_simulation_timeout_count"));
  cslCmdName.insert(make_pair(CMD_GET_SUFFIX,                           "get_suffix"));
  cslCmdName.insert(make_pair(CMD_GET_SYMBOL_LENGTH,                    "get_symbol_length"));
  cslCmdName.insert(make_pair(CMD_GET_TYPE,                             "get_type"));
  cslCmdName.insert(make_pair(CMD_GET_UNIT_PREFIX,                      "get_unit_prefix"));
  cslCmdName.insert(make_pair(CMD_GET_UPPER,                            "get_upper"));
  cslCmdName.insert(make_pair(CMD_GET_UPPER_BOUND,                      "get_upper_bound"));
  cslCmdName.insert(make_pair(CMD_GET_UPPER_INDEX,                      "get_upper_index"));
  cslCmdName.insert(make_pair(CMD_GET_VALID_NAME,                       "get_valid_name"));
  cslCmdName.insert(make_pair(CMD_GET_VALUE,                            "get_value"));
  cslCmdName.insert(make_pair(CMD_GET_VC_CAPTURE_EDGE_TYPE,             "get_vc_capture_edge_type"));
  cslCmdName.insert(make_pair(CMD_GET_VC_CLOCK,                         "get_vc_clock"));
  cslCmdName.insert(make_pair(CMD_GET_VC_COMPARE_TRIGGER,               "get_vc_compare_trigger"));
  cslCmdName.insert(make_pair(CMD_GET_VC_CPP_RD_NAME,                   "get_vc_cpp_rd_name"));
  cslCmdName.insert(make_pair(CMD_GET_VC_CPP_WR_NAME,                   "get_vc_cpp_wr_name"));
  cslCmdName.insert(make_pair(CMD_GET_VC_END_GENERATION_TRIGGER,        "get_vc_end_generation_trigger"));
  cslCmdName.insert(make_pair(CMD_GET_VC_HEADER_COMMENT,                "get_vc_header_comment"));
  cslCmdName.insert(make_pair(CMD_GET_VC_ID,                            "get_vc_id"));
  cslCmdName.insert(make_pair(CMD_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS,  "get_vc_max_number_of_capture_events"));
  cslCmdName.insert(make_pair(CMD_GET_VC_MAX_NUMBER_OF_MISMATCHES,      "get_vc_max_number_of_mismatches"));
  cslCmdName.insert(make_pair(CMD_GET_VC_MAX_NUM_STATES,                "get_vc_max_num_states"));
  cslCmdName.insert(make_pair(CMD_GET_VC_MODULE,                        "get_vc_module"));
  cslCmdName.insert(make_pair(CMD_GET_VC_NAME,                          "get_vc_name"));
  cslCmdName.insert(make_pair(CMD_GET_VC_RESET,                         "get_vc_reset"));
  cslCmdName.insert(make_pair(CMD_GET_VC_STALL,                         "get_vc_stall "));
  cslCmdName.insert(make_pair(CMD_GET_VC_START_GENERATION_TRIGGER,      "get_vc_start_generation_trigger"));
  cslCmdName.insert(make_pair(CMD_GET_VC_TIMEOUT,                       "get_vc_timeout"));
  cslCmdName.insert(make_pair(CMD_GET_WIDTH,                            "get_width"));
  cslCmdName.insert(make_pair(CMD_GET_WR_ADDR_NAME,                     "get_wr_addr_name"));
  cslCmdName.insert(make_pair(CMD_GET_WR_CLOCK_NAME,                    "get_wr_clock_name"));
  cslCmdName.insert(make_pair(CMD_GET_WR_DATA_NAME,                     "get_wr_data_name"));
  cslCmdName.insert(make_pair(CMD_GET_WR_EN_NAME,                       "get_wr_en_name"));
  cslCmdName.insert(make_pair(CMD_INCLUDE_ONLY,                         "include_only"));
  cslCmdName.insert(make_pair(CMD_MERGE,                                "merge"));
  cslCmdName.insert(make_pair(CMD_PRINT,                                "print"));
  cslCmdName.insert(make_pair(CMD_REVERSE,                              "reverse"));
  cslCmdName.insert(make_pair(CMD_SET_ACCESS_RIGHTS,                    "set_access_rights"));
  cslCmdName.insert(make_pair(CMD_SET_ACCESS_RIGHTS_ENUM,               "set_access_rights_enum"));
  cslCmdName.insert(make_pair(CMD_SET_ADDRESS_INCREMENT,                "set_address_increment"));
  cslCmdName.insert(make_pair(CMD_SET_ALIGNMENT,                        "set_alignment"));
  cslCmdName.insert(make_pair(CMD_SET_ATTR,                             "set_attr"));
  cslCmdName.insert(make_pair(CMD_SET_ATTRIBUTES,                       "set_attributes"));
  cslCmdName.insert(make_pair(CMD_SET_BITRANGE,                         "set_bitrange"));
  cslCmdName.insert(make_pair(CMD_SET_CLK_DIVIDER,                      "set_clk_divider"));
  cslCmdName.insert(make_pair(CMD_SET_CLK_MULTIPLIER,                   "set_clk_multiplier"));
  cslCmdName.insert(make_pair(CMD_SET_CLOCK_NAME,                       "set_clock_name"));
  cslCmdName.insert(make_pair(CMD_SET_CONST_VALUE,                      "set_const_value"));
  cslCmdName.insert(make_pair(CMD_SET_DATA_WORD_WIDTH,                  "set_data_word_width"));
  cslCmdName.insert(make_pair(CMD_SET_DECODER_NAME,                     "set_decoder_name"));
  cslCmdName.insert(make_pair(CMD_SET_DECODER_OUT_NAME_PREFIX,          "set_decoder_out_name_prefix"));
  cslCmdName.insert(make_pair(CMD_SET_DECODER_OUT_NAME_SUFFIX,          "set_decoder_out_name_suffix"));
  cslCmdName.insert(make_pair(CMD_SET_DEFAULT_VALUE,                    "set_default_value"));
  cslCmdName.insert(make_pair(CMD_SET_DEPTH,                            "set_depth"));
  cslCmdName.insert(make_pair(CMD_SET_DIM_BITRANGE,                     "set_dim_bitrange"));
  cslCmdName.insert(make_pair(CMD_SET_DIM_OFFSET,                       "set_dim_offset"));
  cslCmdName.insert(make_pair(CMD_SET_DIM_RANGE,                        "set_dim_range"));
  cslCmdName.insert(make_pair(CMD_SET_DIM_WIDTH,                        "set_dim_width"));
  cslCmdName.insert(make_pair(CMD_SET_DIRECTION,                        "set_direction"));
  cslCmdName.insert(make_pair(CMD_SET_DURATION,                         "set_duration"));
  cslCmdName.insert(make_pair(CMD_SET_EMPTY_NAME,                       "set_empty_name"));
  cslCmdName.insert(make_pair(CMD_SET_ENDIANESS,                        "set_endianess"));
  cslCmdName.insert(make_pair(CMD_SET_ENUM,                             "set_enum"));
  cslCmdName.insert(make_pair(CMD_SET_ENUM_ITEM,                        "set_enum_item"));
  cslCmdName.insert(make_pair(CMD_SET_FIELD,                            "set_field"));
  cslCmdName.insert(make_pair(CMD_SET_FIELD_POSITION,                   "set_field_position"));
  cslCmdName.insert(make_pair(CMD_SET_FULL_NAME,                        "set_full_name"));
  cslCmdName.insert(make_pair(CMD_SET_GENERATOR_TYPE,                   "set_generator_type"));
  cslCmdName.insert(make_pair(CMD_SET_INSTANCE_ALTERATION_BIT,          "set_instance_alteration_bit"));
  cslCmdName.insert(make_pair(CMD_SET_MEM_INSTANCE_NAME,                "set_mem_instance_name"));
  cslCmdName.insert(make_pair(CMD_SET_MNEMONIC,                         "set_mnemonic"));
  cslCmdName.insert(make_pair(CMD_SET_MODULE_NAME,                      "set_module_name"));
  cslCmdName.insert(make_pair(CMD_SET_NAME,                             "set_name"));
  cslCmdName.insert(make_pair(CMD_SET_NEXT,                             "set_next"));
  cslCmdName.insert(make_pair(CMD_SET_NEXT_ADDRESS,                     "set_next_address"));
  cslCmdName.insert(make_pair(CMD_SET_NUMBER_OF_DIMENSIONS,             "set_number_of_dimensions"));
  cslCmdName.insert(make_pair(CMD_SET_OFFSET,                           "set_offset"));
  cslCmdName.insert(make_pair(CMD_SET_PATTERN,                          "set_pattern"));
  cslCmdName.insert(make_pair(CMD_SET_PERIOD,                           "set_period"));
  cslCmdName.insert(make_pair(CMD_SET_PHASE_DIFFERENCE,                 "set_phase_difference"));
  cslCmdName.insert(make_pair(CMD_SET_PHYSICAL_IMPLEMENTATION,          "set_physical_implementation"));
  cslCmdName.insert(make_pair(CMD_SET_POP_NAME,                         "set_pop_name"));
  cslCmdName.insert(make_pair(CMD_SET_PREFIX,                           "set_prefix"));
  cslCmdName.insert(make_pair(CMD_SET_PREVIOUS,                         "set_previous"));
  cslCmdName.insert(make_pair(CMD_SET_PUSH_NAME,                        "set_push_name"));
  cslCmdName.insert(make_pair(CMD_SET_RADIX,                            "set_radix"));
  cslCmdName.insert(make_pair(CMD_SET_RANGE,                            "set_range"));
  cslCmdName.insert(make_pair(CMD_SET_RD_ADDR_NAME,                     "set_rd_addr_name"));
  cslCmdName.insert(make_pair(CMD_SET_RD_CLOCK_NAME,                    "set_rd_clock_name"));
  cslCmdName.insert(make_pair(CMD_SET_RD_DATA_NAME,                     "set_rd_data_name"));
  cslCmdName.insert(make_pair(CMD_SET_RD_EN_NAME,                       "set_rd_en_name"));
  cslCmdName.insert(make_pair(CMD_SET_RESET,                            "set_reset"));
  cslCmdName.insert(make_pair(CMD_SET_RESET_NAME,                       "set_reset_name"));
  cslCmdName.insert(make_pair(CMD_SET_SIGNAL_NAME,                      "set_signal_name"));
  cslCmdName.insert(make_pair(CMD_SET_SIGNAL_PREFIX_LOCAL,              "set_signal_prefix_local"));
  cslCmdName.insert(make_pair(CMD_SET_START_SIGNAL,                     "set_start_signal"));
  cslCmdName.insert(make_pair(CMD_SET_SUFFIX,                           "set_suffix"));
  cslCmdName.insert(make_pair(CMD_SET_SYMBOL_MAX_LENGTH,                "set_symbol_max_length"));
  cslCmdName.insert(make_pair(CMD_SET_TESTBENCH_VERILOG_FILENAME,       "set_testbench_verilog_filename"));
  cslCmdName.insert(make_pair(CMD_SET_TIMEBASE,                         "set_timebase"));
  cslCmdName.insert(make_pair(CMD_SET_TOP_UNIT,                         "set_top_unit"));
  cslCmdName.insert(make_pair(CMD_SET_TYPE,                             "set_type"));
  cslCmdName.insert(make_pair(CMD_SET_UNIT_PREFIX,                      "set_unit_prefix"));
  cslCmdName.insert(make_pair(CMD_SET_VALID_NAME,                       "set_valid_name"));
  cslCmdName.insert(make_pair(CMD_SET_VALUE,                            "set_value"));
  cslCmdName.insert(make_pair(CMD_SET_VC_CAPTURE_EDGE_TYPE,             "set_vc_capture_edge_type"));
  cslCmdName.insert(make_pair(CMD_SET_VC_CLOCK,                         "set_vc_clock"));
  cslCmdName.insert(make_pair(CMD_SET_VC_COMPARE_TRIGGER,               "set_vc_compare_trigger"));
  cslCmdName.insert(make_pair(CMD_SET_VC_CPP_RD_NAME,                   "set_vc_cpp_rd_name"));
  cslCmdName.insert(make_pair(CMD_SET_VC_CPP_WR_NAME,                   "set_vc_cpp_wr_name"));
  cslCmdName.insert(make_pair(CMD_SET_VC_END_GENERATION_TRIGGER,        "set_vc_end_generation_trigger"));
  cslCmdName.insert(make_pair(CMD_SET_VC_HEADER_COMMENT,                "set_vc_header_comment"));
  cslCmdName.insert(make_pair(CMD_SET_VC_ID,                            "set_vc_id"));
  cslCmdName.insert(make_pair(CMD_SET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS,  "set_vc_max_number_of_capture_events"));
  cslCmdName.insert(make_pair(CMD_SET_VC_MAX_NUMBER_OF_MISMATCHES,      "set_vc_max_number_of_mismatches"));
  cslCmdName.insert(make_pair(CMD_SET_VC_MAX_NUM_OF_TRANSACTION_EVENTS, "set_vc_max_num_of_transaction_events"));
  cslCmdName.insert(make_pair(CMD_SET_VC_MAX_NUM_STATES,                "set_vc_max_num_states"));
  cslCmdName.insert(make_pair(CMD_SET_VC_NAME,                          "set_vc_name"));
  cslCmdName.insert(make_pair(CMD_SET_VC_OUTPUT_FILENAME,               "set_vc_output_filename"));
  cslCmdName.insert(make_pair(CMD_SET_VC_RESET,                         "set_vc_reset"));
  cslCmdName.insert(make_pair(CMD_SET_VC_STALL,                         "set_vc_stall"));
  cslCmdName.insert(make_pair(CMD_SET_VC_START_GENERATION_TRIGGER,      "set_vc_start_generation_trigger"));
  cslCmdName.insert(make_pair(CMD_SET_VC_TIMEOUT,                       "set_vc_timeout"));
  cslCmdName.insert(make_pair(CMD_SET_VERSION,                          "set_version"));
  cslCmdName.insert(make_pair(CMD_SET_WIDTH,                            "set_width"));
  cslCmdName.insert(make_pair(CMD_SET_WR_ADDR_NAME,                     "set_wr_addr_name"));
  cslCmdName.insert(make_pair(CMD_SET_WR_CLOCK_NAME,                    "set_wr_clock_name"));
  cslCmdName.insert(make_pair(CMD_SET_WR_DATA_NAME,                     "set_wr_data_name"));
  cslCmdName.insert(make_pair(CMD_SET_WR_EN_NAME,                       "set_wr_en_name"));
}

void buildClassNames() {
  for (ECSLClassStringMap_const_iter cls = cslGenericName.begin(); cls != cslGenericName.end(); cls++) {
    string clsName = string("csl_").append((*cls).second);
    cslTypeName.insert(make_pair((*cls).first, clsName));
  }
}

void buildObjNames() {
  for (ECSLClassStringMap_const_iter cls = cslGenericName.begin(); cls != cslGenericName.end(); cls++) {
    string objName = string((*cls).second).append("_obj");
    cslObjName.insert(make_pair((*cls).first, objName));

    string obj1Name = string((*cls).second).append("1");
    cslObj1Name.insert(make_pair((*cls).first, obj1Name));

    string obj2Name = string((*cls).second).append("2");
    cslObj2Name.insert(make_pair((*cls).first, obj2Name));

    string paramName = string((*cls).second).append("_param");
    cslParamName.insert(make_pair((*cls).first, paramName));

    string inst1Name = string((*cls).second).append("_inst");
    cslInst1Name.insert(make_pair((*cls).first, inst1Name));
  }  
}

void addCmd(ECSLClass cls,
            ECSLCmdType cmdType,
            bool canCallFromGlobalScope,
            bool canCallFromInstance,
            bool returnValue,
            CSLParamPointVect paramVect,
            CSLCmdPointVect preCmdVect,
            CSLClassPointVect preDeclVect) {

  CSLCmd newCmd(cmdType, canCallFromGlobalScope, canCallFromInstance, returnValue);
  newCmd.addParamVect(paramVect);
  newCmd.addCaller(cls);
  newCmd.addPreCmdVect(preCmdVect);
  CSLCmdPointVect_const_iter cmd = cslCmds.begin();
  for (; cmd != cslCmds.end(); cmd++) {
    if (newCmd == **cmd) {
      break;
    }
  }
  if (cmd == cslCmds.end()) {
    cslCmds.push_back(new CSLCmd(newCmd));
  }
  else {
    (*cmd)->addCaller(cls);
  }
}

void buildBitrange() {
  CSLParamPointVect cslParam;

  /* decl
   */
  cslParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslBitrange.addDeclParamVect(cslParam);
 
  cslParam.clear();
  cslParam.push_back(new CSLConst(LSB_DEFAULT));
  cslParam.push_back(new CSLConst(MSB_DEFAULT));
  cslBitrange.addDeclParamVect(cslParam);

  cslParam.clear();
  CSLParamPointVect bitrangeParam;
  bitrangeParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_BITRANGE, bitrangeParam));
  cslBitrange.addDeclParamVect(cslParam);

  /* cmds
   */
  addCmd(CSL_BITRANGE, CMD_GET_BITRANGE, true, true, true);

  addCmd(CSL_BITRANGE, CMD_GET_LOWER, true, true, true);

  addCmd(CSL_BITRANGE, CMD_GET_OFFSET, true, true, true);

  addCmd(CSL_BITRANGE, CMD_GET_UPPER, true, true, true);

  cslParam.clear();
  cslParam.push_back(new CSLConst(OFFSET_DEFAULT));
  addCmd(CSL_BITRANGE, CMD_SET_OFFSET, true, true, false, cslParam);

  cslClasses.push_back(new CSLClass(cslBitrange));
}

void buildEnum() {
  CSLParamPointVect cslParam;

  /* decl
   */
  cslParam.push_back(new CSLEnumItem());
  cslEnum.addDeclParamVect(cslParam);

  cslClasses.push_back(new CSLClass(cslEnum));
}

void buildEvent() {
  CSLParamPointVect cslParam;

  /* cmds
   */
  cslParam.push_back(new CSLConst(CONST_ONE));
  addCmd(CSL_EVENT, CMD_ADD_EQUATION, true, true, false, cslParam);

  cslClasses.push_back(new CSLClass(cslEvent));
}

void buildField() {
  CSLParamPointVect cslParam;

  /* mandatory cmds
   */
  CSLCmdPoint cslCmd = new CSLCmd(CMD_SET_WIDTH, false);
  cslCmd->addParam(new CSLConst(WIDTH_DEFAULT));
  cslField.addMandatoryCmd(cslCmd);

  /* decl
   */
  cslParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslField.addDeclParamVect(cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(LSB_DEFAULT));
  cslParam.push_back(new CSLConst(MSB_DEFAULT));
  cslField.addDeclParamVect(cslParam);

  cslParam.clear();
  CSLParamPointVect fieldParam;
  fieldParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_FIELD, fieldParam));
  cslField.addDeclParamVect(cslParam);

  /* legal decl
   */
  cslField.addLegalDecl(new CSLClass(cslField));

  /* legal inst
   */
  cslField.addLegalInst(new CSLClass(cslField));

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLConst(LOW_ALLOWED_RANGE_DEFAULT));
  cslParam.push_back(new CSLConst(UP_ALLOWED_RANGE_DEFAULT));
  addCmd(CSL_FIELD, CMD_ADD_ALLOWED_RANGE, true, true, false, cslParam);

  addCmd(CSL_FIELD, CMD_GET_BITRANGE, true, true, true);

  addCmd(CSL_FIELD, CMD_GET_ENUM, true, true, true);

  addCmd(CSL_FIELD, CMD_GET_ENUM_ITEM, true, true, true);

  addCmd(CSL_FIELD, CMD_GET_LOWER, true, true, true);

  addCmd(CSL_FIELD, CMD_GET_OFFSET, true, true, true);

  addCmd(CSL_FIELD, CMD_GET_UPPER, true, true, true);

  addCmd(CSL_FIELD, CMD_GET_VALUE, true, true, true);

  addCmd(CSL_FIELD, CMD_GET_WIDTH, true, true, true);

  cslParam.clear();
  CSLParamPointVect bitrangeParam;
  bitrangeParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_BITRANGE, bitrangeParam));
  addCmd(CSL_FIELD, CMD_SET_BITRANGE, true, false, false, cslParam);

  cslParam.clear();
  CSLParamPointVect enumParam;
  enumParam.push_back(new CSLEnumItem());
  cslParam.push_back(new CSLObjDecl(CSL_ENUM, enumParam));
  addCmd(CSL_FIELD, CMD_SET_ENUM, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLEnumItem(true));
  addCmd(CSL_FIELD, CMD_SET_ENUM_ITEM, true, false, false, cslParam);

  cslParam.clear();
  fieldParam.clear();
  fieldParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_FIELD, fieldParam, PD_SCOPE));
  cslParam.push_back(new CSLConst(POSITION_DEFAULT));
  addCmd(CSL_FIELD, CMD_SET_FIELD_POSITION, false, false, false, cslParam);

  cslParam.clear();
  fieldParam.clear();
  fieldParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_FIELD, fieldParam, PD_SCOPE, "1"));
  fieldParam.clear();
  fieldParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_FIELD, fieldParam, PD_SCOPE, "2"));
  addCmd(CSL_FIELD, CMD_SET_NEXT, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(OFFSET_DEFAULT));
  addCmd(CSL_FIELD, CMD_SET_OFFSET, false, false, false, cslParam);

  cslParam.clear();
  fieldParam.clear();
  fieldParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_FIELD, fieldParam, PD_SCOPE, "1"));
  fieldParam.clear();
  fieldParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_FIELD, fieldParam, PD_SCOPE, "2"));
  addCmd(CSL_FIELD, CMD_SET_PREVIOUS, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(LSB_DEFAULT));
  cslParam.push_back(new CSLConst(MSB_DEFAULT));
  addCmd(CSL_FIELD, CMD_SET_RANGE, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(VALUE_DEFAULT));
  addCmd(CSL_FIELD, CMD_SET_VALUE, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(WIDTH_DEFAULT));
  addCmd(CSL_FIELD, CMD_SET_WIDTH, false, false, false, cslParam);

  cslClasses.push_back(new CSLClass(cslField));
}

void buildFifo() {
  CSLParamPointVect cslParam;

  /* mandatory cmds
   */
  CSLCmdPoint cslCmd = new CSLCmd(CMD_SET_DEPTH);
  cslCmd->addParam(new CSLConst(DEPTH_DEFAULT));
  cslFifo.addMandatoryCmd(cslCmd);

  cslCmd = new CSLCmd(CMD_SET_WIDTH);
  cslCmd->addParam(new CSLConst(WIDTH_DEFAULT));
  cslFifo.addMandatoryCmd(cslCmd);

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("async_reset"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("programmable_depth"));
  cslParam.push_back(new CSLConst(CONST_ONE));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("priority_bypass"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("async_fifo"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("depth_extend"));
  cslParam.push_back(new CSLConst(CONST_ONE));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("width_extend"));
  cslParam.push_back(new CSLConst(CONST_ONE));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("wr_hold"));
  cslParam.push_back(new CSLConst(CONST_ONE));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("parallel_input"));
  cslParam.push_back(new CSLKeyWord("all"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("parallel_output"));
  cslParam.push_back(new CSLKeyWord("all"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("rd_words"));
  cslParam.push_back(new CSLConst(LSB_DEFAULT));
  cslParam.push_back(new CSLConst(MSB_DEFAULT));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("wr_words"));
  cslParam.push_back(new CSLConst(LSB_DEFAULT));
  cslParam.push_back(new CSLConst(MSB_DEFAULT));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("sram_rd"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("sram_wr"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("pushback"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("flow_through"));
  cslParam.push_back(new CSLConst(CONST_ONE));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("stall"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("stall_rd_side"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("stall_wr_side"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("sync_fifo"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("wr_release"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("almost_empty"));
  cslParam.push_back(new CSLConst(CONST_ONE));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("almost_full"));
  cslParam.push_back(new CSLConst(CONST_ONE));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("output_rd_addr"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("output_wr_addr"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("credit"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("rd_credit"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("wr_credit"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("flow"));
  addCmd(CSL_FIFO, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("ffa"));
  addCmd(CSL_FIFO, CMD_SET_PHYSICAL_IMPLEMENTATION, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("sram"));
  addCmd(CSL_FIFO, CMD_SET_PHYSICAL_IMPLEMENTATION, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"prefix\""));
  addCmd(CSL_FIFO, CMD_SET_PREFIX, false, false, false, cslParam);

  addCmd(CSL_FIFO, CMD_ADD_TO_MEMORY_MAP, false, true, false);

  /* new stuff
   */
  addCmd(CSL_FIFO, CMD_GET_RESET_NAME, false, false, true);

  addCmd(CSL_FIFO, CMD_GET_CLOCK_NAME, false, false, true);

  addCmd(CSL_FIFO, CMD_GET_RD_CLOCK_NAME, false, false, true);

  addCmd(CSL_FIFO, CMD_GET_WR_CLOCK_NAME, false, false, true);

  addCmd(CSL_FIFO, CMD_GET_PUSH_NAME, false, false, true);

  addCmd(CSL_FIFO, CMD_GET_POP_NAME, false, false, true);

  addCmd(CSL_FIFO, CMD_GET_FULL_NAME, false, false, true);

  addCmd(CSL_FIFO, CMD_GET_EMPTY_NAME, false, false, true);

  addCmd(CSL_FIFO, CMD_GET_WR_DATA_NAME, false, false, true);

  addCmd(CSL_FIFO, CMD_GET_RD_DATA_NAME, false, false, true);

  addCmd(CSL_FIFO, CMD_GET_VALID_NAME, false, false, true);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"reset_name\""));
  addCmd(CSL_FIFO, CMD_SET_RESET_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"clock_name\""));
  addCmd(CSL_FIFO, CMD_SET_CLOCK_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"rd_clock_name\""));
  addCmd(CSL_FIFO, CMD_SET_RD_CLOCK_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"wr_clock_name\""));
  addCmd(CSL_FIFO, CMD_SET_WR_CLOCK_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"push_name\""));
  addCmd(CSL_FIFO, CMD_SET_PUSH_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"pop_name\""));
  addCmd(CSL_FIFO, CMD_SET_POP_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"full_name\""));
  addCmd(CSL_FIFO, CMD_SET_FULL_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"empty_name\""));
  addCmd(CSL_FIFO, CMD_SET_EMPTY_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"wr_data_name\""));
  addCmd(CSL_FIFO, CMD_SET_WR_DATA_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"rd_data_name\""));
  addCmd(CSL_FIFO, CMD_SET_RD_DATA_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"valid_name\""));
  addCmd(CSL_FIFO, CMD_SET_VALID_NAME, false, false, false, cslParam);
  /*~new stuff
   */

  cslClasses.push_back(new CSLClass(cslFifo));
}

void buildInterface() {
  CSLParamPointVect cslParam;

  /* legal decl
   */
  cslInterface.addLegalDecl(new CSLClass(cslBitrange));
  cslInterface.addLegalDecl(new CSLClass(cslField));
  cslInterface.addLegalDecl(new CSLClass(cslMultiDimBitrange));
  cslInterface.addLegalDecl(new CSLClass(cslPort));

  /* legal inst
   */
  cslInterface.addLegalInst(new CSLClass(cslInterface));

  /* cmds
   */
  addCmd(CSL_INTERFACE, CMD_REVERSE, false, true, false);

  cslClasses.push_back(new CSLClass(cslInterface));
}

void buildIsaField() {
  CSLParamPointVect cslParam;

  /* mandatory cmds
   */
  CSLCmdPoint cslCmd = new CSLCmd(CMD_SET_WIDTH, false);
  cslCmd->addParam(new CSLConst(WIDTH_DEFAULT));
  cslIsaField.addMandatoryCmd(cslCmd);

  cslCmd = new CSLCmd(CMD_SET_TYPE);
  cslCmd->addParam(new CSLKeyWord("opcode"));
  cslIsaField.addMandatoryCmd(cslCmd);

  /* decl
   */
  cslParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslIsaField.addDeclParamVect(cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(LSB_DEFAULT));
  cslParam.push_back(new CSLConst(MSB_DEFAULT));
  cslIsaField.addDeclParamVect(cslParam);

  cslParam.clear();
  CSLParamPointVect bitrangeParam;
  bitrangeParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_BITRANGE, bitrangeParam));
  cslIsaField.addDeclParamVect(cslParam);

  cslParam.clear();
  CSLParamPointVect isaFieldParam;
  isaFieldParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_ISA_FIELD, isaFieldParam));
  cslIsaField.addDeclParamVect(cslParam);

  /* legal decl
   */
  cslIsaField.addLegalDecl(new CSLClass(cslIsaField));

  /* legal inst
   */
  cslIsaField.addLegalInst(new CSLClass(cslIsaField));

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLConst(LOW_ALLOWED_RANGE_DEFAULT));
  cslParam.push_back(new CSLConst(UP_ALLOWED_RANGE_DEFAULT));
  addCmd(CSL_ISA_FIELD, CMD_ADD_ALLOWED_RANGE, true, true, false);

  addCmd(CSL_ISA_FIELD, CMD_GET_BITRANGE, true, false, true);

  addCmd(CSL_ISA_FIELD, CMD_GET_ENUM, true, false, true);

  addCmd(CSL_ISA_FIELD, CMD_GET_ENUM_ITEM, true, false, true);

  addCmd(CSL_ISA_FIELD, CMD_GET_LOWER, true, false, true);

  addCmd(CSL_ISA_FIELD, CMD_GET_MNEMONIC, true, false, true);

  addCmd(CSL_ISA_FIELD, CMD_GET_OFFSET, true, false, true);

  addCmd(CSL_ISA_FIELD, CMD_GET_UPPER, true, false, true);

  addCmd(CSL_ISA_FIELD, CMD_GET_VALUE, true, false, true);

  addCmd(CSL_ISA_FIELD, CMD_GET_WIDTH, true, false, true);

  cslParam.clear();
  CSLParamPointVect enumParam;
  enumParam.push_back(new CSLEnumItem());
  cslParam.push_back(new CSLObjDecl(CSL_ENUM, enumParam));
  addCmd(CSL_ISA_FIELD, CMD_SET_ENUM, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLEnumItem(true));
  addCmd(CSL_ISA_FIELD, CMD_SET_ENUM_ITEM, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"mnemonic\""));
  addCmd(CSL_ISA_FIELD, CMD_SET_MNEMONIC, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"name\""));
  addCmd(CSL_ISA_FIELD, CMD_SET_NAME, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(OFFSET_DEFAULT));
  addCmd(CSL_ISA_FIELD, CMD_SET_OFFSET, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(VALUE_DEFAULT));
  addCmd(CSL_ISA_FIELD, CMD_SET_VALUE, true, true, false, cslParam);

  cslClasses.push_back(new CSLClass(cslIsaField));
}

void buildMemory() {
  CSLParamPointVect cslParam;

  /* mandatory cmds
   */
  CSLCmdPoint cslCmd = new CSLCmd(CMD_SET_DEPTH);
  cslCmd->addParam(new CSLConst(DEPTH_DEFAULT));
  cslMemory.addMandatoryCmd(cslCmd);

  cslCmd = new CSLCmd(CMD_SET_WIDTH);
  cslCmd->addParam(new CSLConst(WIDTH_DEFAULT));
  cslMemory.addMandatoryCmd(cslCmd);

  cslClasses.push_back(new CSLClass(cslMemory));
}

void buildMemMap() {
  CSLParamPointVect cslParam;

  /* legal inst
   */
  cslMemMap.addLegalInst(new CSLClass(cslMemMapPage));

  /* cmds
   */
  addCmd(CSL_MEMORY_MAP, CMD_AUTO_GEN_MEMORY_MAP, false, true, false);

  addCmd(CSL_MEMORY_MAP, CMD_GET_DATA_WORD_WIDTH, false, true, true);

  addCmd(CSL_MEMORY_MAP, CMD_GET_PREFIX, false, true, true);

  addCmd(CSL_MEMORY_MAP, CMD_GET_SUFFIX, false, true, true);

  cslParam.clear();
  CSLParamPointVect enumParam;
  enumParam.push_back(new CSLEnumItem());
  cslParam.push_back(new CSLObjDecl(CSL_ENUM, enumParam));
  addCmd(CSL_MEMORY_MAP, CMD_SET_ACCESS_RIGHTS_ENUM, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(WORD_WIDTH_DEFAULT));
  addCmd(CSL_MEMORY_MAP, CMD_SET_DATA_WORD_WIDTH, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"prefix\""));
  addCmd(CSL_MEMORY_MAP, CMD_SET_PREFIX, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"suffix\""));
  addCmd(CSL_MEMORY_MAP, CMD_SET_SUFFIX, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_UNIT));
  addCmd(CSL_MEMORY_MAP, CMD_SET_TOP_UNIT, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("hierarchical"));
  addCmd(CSL_MEMORY_MAP, CMD_SET_TYPE, false, false, false, cslParam);
  cslParam.clear();

  cslClasses.push_back(new CSLClass(cslMemMap));
}

void buildMemMapPage() {
  CSLParamPointVect cslParam;
  CSLCmdPointVect preCmdVect;

  /* legal inst
   */
  cslMemMapPage.addLegalInst(new CSLClass(cslMemMapPage));

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_FIFO));
  cslParam.push_back(new CSLKeyWord("\"fifo_name\""));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_ADD, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_REGISTER));
  cslParam.push_back(new CSLKeyWord("\"register_name\""));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_ADD, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_REGISTER_FILE));
  cslParam.push_back(new CSLKeyWord("\"register_file_name\""));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_ADD, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_MEMORY_MAP_PAGE));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_ADD, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(LOW_ADDRESS_RANGE_DEFAULT));
  cslParam.push_back(new CSLConst(UP_ADDRESS_RANGE_DEFAULT));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_ADD_ADDRESS_RANGE, false, true, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(LOW_RESERVED_ADDRESS_RANGE_DEFAULT));
  cslParam.push_back(new CSLConst(UP_RESERVED_ADDRESS_RANGE_DEFAULT));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_ADD_RESERVED_ADDRESS_RANGE, false, true, false, cslParam);

  addCmd(CSL_MEMORY_MAP_PAGE, CMD_GET_ADDRESS_INCREMENT, false, true, true);

  addCmd(CSL_MEMORY_MAP_PAGE, CMD_GET_ALIGNMENT, false, true, true);

  addCmd(CSL_MEMORY_MAP_PAGE, CMD_GET_DATA_WORD_WIDTH, false, true, true);

  addCmd(CSL_MEMORY_MAP_PAGE, CMD_GET_ENDIANESS, false, true, true);

  addCmd(CSL_MEMORY_MAP_PAGE, CMD_GET_LOWER_BOUND, false, true, true);

  addCmd(CSL_MEMORY_MAP_PAGE, CMD_GET_NEXT_ADDRESS, false, true, true);

  addCmd(CSL_MEMORY_MAP_PAGE, CMD_GET_SYMBOL_LENGTH, false, true, true);

  addCmd(CSL_MEMORY_MAP_PAGE, CMD_GET_UPPER_BOUND, false, true, true);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("SWR"));
  cslParam.push_back(new CSLKeyWord("access_read_write"));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_SET_ACCESS_RIGHTS, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(ADDRESS_INCREMENT_DEFAULT));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_SET_ADDRESS_INCREMENT, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(WORD_WIDTH_DEFAULT));
  preCmdVect.clear();
  preCmdVect.push_back(new CSLCmd(CMD_SET_DATA_WORD_WIDTH, false, false, false, cslParam));
  cslParam.clear();
  cslParam.push_back(new CSLConst(ALIGNMENT_DEFAULT));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_SET_ALIGNMENT, false, false, false, cslParam, preCmdVect);

  cslParam.clear();
  cslParam.push_back(new CSLConst(WORD_WIDTH_DEFAULT));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_SET_DATA_WORD_WIDTH, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("little_endian"));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_SET_ENDIANESS, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(NEXT_ADDRESS_DEFAULT));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_SET_NEXT_ADDRESS, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(SYMBOL_MAX_LENGHT_DEFAULT));
  addCmd(CSL_MEMORY_MAP_PAGE, CMD_SET_SYMBOL_MAX_LENGTH, false, false, false, cslParam);

  cslClasses.push_back(new CSLClass(cslMemMapPage));
}

void buildMultiDimBitrange() {
  CSLParamPointVect cslParam;

  /* decl
   */
  cslParam.clear();
  cslParam.push_back(new CSLConst(DIMENSION_DEFAULT));
  cslMultiDimBitrange.addDeclParamVect(cslParam);

  cslParam.clear();
  CSLParamPointVect multiDimBitrangeParam;
  multiDimBitrangeParam.push_back(new CSLConst(DIMENSION_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_MULTI_DIM_BITRANGE, multiDimBitrangeParam));
  cslMultiDimBitrange.addDeclParamVect(cslParam);

  /* cmds
   */
  addCmd(CSL_MULTI_DIM_BITRANGE, CMD_GET_DIM_BITRANGE, true, false, true);

  addCmd(CSL_MULTI_DIM_BITRANGE, CMD_GET_DIM_LOWER, true, false, true);

  addCmd(CSL_MULTI_DIM_BITRANGE, CMD_GET_DIM_OFFSET, true, false, true);

  addCmd(CSL_MULTI_DIM_BITRANGE, CMD_GET_DIM_UPPER, true, false, true);

  addCmd(CSL_MULTI_DIM_BITRANGE, CMD_GET_DIM_WIDTH, true, false, true);

  cslParam.clear();
  cslParam.push_back(new CSLConst(DIM_DEFAULT));
  CSLParamPointVect bitrangeParam;
  bitrangeParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_BITRANGE, bitrangeParam));
  addCmd(CSL_MULTI_DIM_BITRANGE, CMD_SET_DIM_BITRANGE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(DIM_DEFAULT));
  cslParam.push_back(new CSLConst(OFFSET_DEFAULT));
  addCmd(CSL_MULTI_DIM_BITRANGE, CMD_SET_DIM_OFFSET, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(DIM_DEFAULT));
  cslParam.push_back(new CSLConst(LSB_DEFAULT));
  cslParam.push_back(new CSLConst(MSB_DEFAULT));
  addCmd(CSL_MULTI_DIM_BITRANGE, CMD_SET_DIM_RANGE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(DIM_DEFAULT));
  cslParam.push_back(new CSLConst(WIDTH_DEFAULT));
  addCmd(CSL_MULTI_DIM_BITRANGE, CMD_SET_DIM_WIDTH, true, false, false, cslParam);

  cslClasses.push_back(new CSLClass(cslMultiDimBitrange));
}

void buildPort() {
  CSLParamPointVect cslParam;

  /* decl
   */
  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("inout"));
  cslPort.addDeclParamVect(cslParam);

  /* cmds
   */
  addCmd(CSL_PORT, CMD_GET_BITRANGE, true, false, true);

  addCmd(CSL_PORT, CMD_GET_LOWER_INDEX, true, false, true);

  addCmd(CSL_PORT, CMD_GET_OFFSET, true, false, true);

  addCmd(CSL_PORT, CMD_GET_UPPER_INDEX, true, false, true);

  addCmd(CSL_PORT, CMD_GET_WIDTH, true, false, true);

  addCmd(CSL_PORT, CMD_REVERSE, true, true, false);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("en"));
  addCmd(CSL_PORT, CMD_SET_ATTR, true, false, false, cslParam);

  cslParam.clear();
  CSLParamPointVect bitrangeParam;
  bitrangeParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_BITRANGE, bitrangeParam));
  addCmd(CSL_PORT, CMD_SET_BITRANGE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(OFFSET_DEFAULT));
  addCmd(CSL_PORT, CMD_SET_OFFSET, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(LSB_DEFAULT));
  cslParam.push_back(new CSLConst(MSB_DEFAULT));
  addCmd(CSL_PORT, CMD_SET_RANGE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("integer"));
  addCmd(CSL_PORT, CMD_SET_TYPE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(WIDTH_DEFAULT));
  addCmd(CSL_PORT, CMD_SET_WIDTH, true, false, false, cslParam);

  cslClasses.push_back(new CSLClass(cslPort));
}

void buildRegister() {
  CSLParamPointVect cslParam;

  /* legal decl
   */
  cslRegister.addLegalInst(new CSLClass(cslField));

  /* legal inst
   */
  cslRegister.addLegalInst(new CSLClass(cslField));

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("clear"));
  cslParam.push_back(new CSLConst(CONST_ZERO));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("count_amount"));
  cslParam.push_back(new CSLConst(CONST_ZERO));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("direction_control"));
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("end_value"));
  cslParam.push_back(new CSLConst(CONST_ZERO));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("init"));
  cslParam.push_back(new CSLConst(CONST_ZERO));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("neg_output"));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("reset"));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("reset"));
  cslParam.push_back(new CSLConst(CONST_ZERO));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("serial_input"));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("serial_output"));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("set"));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("set"));
  cslParam.push_back(new CSLConst(CONST_ZERO));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("start_value"));
  cslParam.push_back(new CSLConst(CONST_ZERO));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("stop"));
  cslParam.push_back(new CSLConst(CONST_ZERO));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("gray_output"));
  addCmd(CSL_REGISTER, CMD_ADD_LOGIC, false, false, false, cslParam);

  addCmd(CSL_REGISTER, CMD_GET_ATTRIBUTES, false, true, true);

  addCmd(CSL_REGISTER, CMD_GET_CNT_DIR_SIGNAL, false, true, true);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("read_write"));
  addCmd(CSL_REGISTER, CMD_SET_ATTRIBUTES, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("dff"));
  addCmd(CSL_REGISTER, CMD_SET_TYPE, false, false, false, cslParam);

  addCmd(CSL_REGISTER, CMD_ADD_TO_MEMORY_MAP, false, true, false);

  cslClasses.push_back(new CSLClass(cslRegister));
}

void buildRegFile() {
  CSLParamPointVect cslParam;

  /* mandatory cmds
   */
  CSLCmdPoint cslCmd = new CSLCmd(CMD_SET_DEPTH);
  cslCmd->addParam(new CSLConst(DEPTH_DEFAULT));
  cslRegFile.addMandatoryCmd(cslCmd);

  cslCmd = new CSLCmd(CMD_SET_WIDTH);
  cslCmd->addParam(new CSLConst(WIDTH_DEFAULT));
  cslRegFile.addMandatoryCmd(cslCmd);

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("read_valid"));
  addCmd(CSL_REGISTER_FILE, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("bypass"));
  addCmd(CSL_REGISTER_FILE, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("field_group"));
  cslParam.push_back(new CSLKeyWord("fld_group"));
  cslParam.push_back(new CSLKeyWord("all"));
  addCmd(CSL_REGISTER_FILE, CMD_DIRECTIVE, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("disconnect_register_fields_from_ios"));
  cslParam.push_back(new CSLKeyWord("all"));
  addCmd(CSL_REGISTER_FILE, CMD_DIRECTIVE, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("connect_register_field_to_ios"));
  cslParam.push_back(new CSLKeyWord("inputs"));
  cslParam.push_back(new CSLKeyWord("all"));
  addCmd(CSL_REGISTER_FILE, CMD_DIRECTIVE, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("connect_register_field_to_ios"));
  cslParam.push_back(new CSLKeyWord("outputs"));
  cslParam.push_back(new CSLKeyWord("all"));
  addCmd(CSL_REGISTER_FILE, CMD_DIRECTIVE, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("connect_register_field_to_ios"));
  cslParam.push_back(new CSLKeyWord("inouts"));
  cslParam.push_back(new CSLKeyWord("all"));
  addCmd(CSL_REGISTER_FILE, CMD_DIRECTIVE, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("name_register"));
  cslParam.push_back(new CSLConst(CONST_ZERO));
  cslParam.push_back(new CSLKeyWord("register_name"));
  addCmd(CSL_REGISTER_FILE, CMD_DIRECTIVE, false, false, false, cslParam);

  addCmd(CSL_REGISTER_FILE, CMD_CREATE_RTL_MODULE, false, true, false);

  addCmd(CSL_REGISTER_FILE, CMD_GET_DEPTH, false, true, true);

  addCmd(CSL_REGISTER_FILE, CMD_GET_WIDTH, false, true, true);

  cslParam.clear();
  cslParam.push_back(new CSLConst(VALUE_DEFAULT));
  addCmd(CSL_REGISTER_FILE, CMD_SET_CONST_VALUE, false, false, false, cslParam);

  cslParam.clear();
  CSLParamPointVect fieldParam;
  fieldParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_FIELD, fieldParam));
  cslParam.push_back(new CSLConst(CONST_ZERO));
  addCmd(CSL_REGISTER_FILE, CMD_SET_FIELD, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"prefix\""));
  cslParam.push_back(new CSLKeyWord("input"));
  addCmd(CSL_REGISTER_FILE, CMD_SET_PREFIX, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"prefix\""));
  cslParam.push_back(new CSLKeyWord("output"));
  addCmd(CSL_REGISTER_FILE, CMD_SET_PREFIX, false, false, false, cslParam);

  addCmd(CSL_REGISTER_FILE, CMD_ADD_TO_MEMORY_MAP, false, true, false);

  /* new stuff
   */
  addCmd(CSL_REGISTER_FILE, CMD_GET_RESET_NAME, false, true, true);

  addCmd(CSL_REGISTER_FILE, CMD_GET_CLOCK_NAME, false, true, true);

  addCmd(CSL_REGISTER_FILE, CMD_GET_WR_DATA_NAME, false, true, true);

  addCmd(CSL_REGISTER_FILE, CMD_GET_RD_DATA_NAME, false, true, true);

  addCmd(CSL_REGISTER_FILE, CMD_GET_WR_ADDR_NAME, false, true, true);

  addCmd(CSL_REGISTER_FILE, CMD_GET_RD_ADDR_NAME, false, true, true);

  addCmd(CSL_REGISTER_FILE, CMD_GET_WR_EN_NAME, false, true, true);

  addCmd(CSL_REGISTER_FILE, CMD_GET_RD_EN_NAME, false, true, true);

  addCmd(CSL_REGISTER_FILE, CMD_GET_VALID_NAME, false, true, true);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"reset_name\""));
  addCmd(CSL_REGISTER_FILE, CMD_SET_RESET_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"clock_name\""));
  addCmd(CSL_REGISTER_FILE, CMD_SET_CLOCK_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"wr_data_name\""));
  addCmd(CSL_REGISTER_FILE, CMD_SET_WR_DATA_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"rd_data_name\""));
  addCmd(CSL_REGISTER_FILE, CMD_SET_RD_DATA_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"wr_addr_name\""));
  addCmd(CSL_REGISTER_FILE, CMD_SET_WR_ADDR_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"rd_addr_name\""));
  addCmd(CSL_REGISTER_FILE, CMD_SET_RD_ADDR_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"wr_en_name\""));
  addCmd(CSL_REGISTER_FILE, CMD_SET_WR_EN_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"rd_en_name\""));
  addCmd(CSL_REGISTER_FILE, CMD_SET_RD_EN_NAME, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"valid_name\""));
  addCmd(CSL_REGISTER_FILE, CMD_SET_VALID_NAME, false, false, false, cslParam);
  /*~new stuff
   */

  cslClasses.push_back(new CSLClass(cslRegFile));
}

void buildSignal() {
  CSLParamPointVect cslParam;

  /* decl
   */
  cslSignal.addDeclParamVect(CSLParamPointVect());

  cslParam.clear();
  cslParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslSignal.addDeclParamVect(cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(LSB_DEFAULT));
  cslParam.push_back(new CSLConst(MSB_DEFAULT));
  cslSignal.addDeclParamVect(cslParam);

  cslParam.clear();
  CSLParamPointVect bitrangeParam;
  bitrangeParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_BITRANGE, bitrangeParam));
  cslSignal.addDeclParamVect(cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  cslSignal.addDeclParamVect(cslParam);

  /* cmds
   */
  addCmd(CSL_SIGNAL, CMD_GET_ATTR, true, false, true);

  addCmd(CSL_SIGNAL, CMD_GET_BITRANGE, true, false, true);

  addCmd(CSL_SIGNAL, CMD_GET_LOWER_INDEX, true, false, true);

  addCmd(CSL_SIGNAL, CMD_GET_OFFSET, true, false, true);

  addCmd(CSL_SIGNAL, CMD_GET_TYPE, true, false, true);

  addCmd(CSL_SIGNAL, CMD_GET_UPPER_INDEX, true, false, true);

  addCmd(CSL_SIGNAL, CMD_GET_WIDTH, true, false, true);

//   cslParam.clear();
//   cslParam.push_back(new CSL());
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );
//   addCmd(CSL_SIGNAL, CMD_MERGE, , , );

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("en"));
  addCmd(CSL_SIGNAL, CMD_SET_ATTR, true, false, false, cslParam);

  cslParam.clear();
  bitrangeParam.clear();
  bitrangeParam.push_back(new CSLConst(WIDTH_DEFAULT));
  cslParam.push_back(new CSLObjDecl(CSL_BITRANGE, bitrangeParam));
  addCmd(CSL_SIGNAL, CMD_SET_BITRANGE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(OFFSET_DEFAULT));
  addCmd(CSL_SIGNAL, CMD_SET_OFFSET, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(LSB_DEFAULT));
  cslParam.push_back(new CSLConst(MSB_DEFAULT));
  addCmd(CSL_SIGNAL, CMD_SET_RANGE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("integer"));
  addCmd(CSL_SIGNAL, CMD_SET_TYPE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(WIDTH_DEFAULT));
  addCmd(CSL_SIGNAL, CMD_SET_WIDTH, true, false, false, cslParam);

  cslClasses.push_back(new CSLClass(cslSignal));
}

void buildSigGroup() {
  CSLParamPointVect cslParam;

  /* mandatory objs
   */
  cslSigGroup.addMandatoryObj(new CSLClass(cslSignal, OBJ_COUNT_ONE));

  /* legal decl
   */
  cslSigGroup.addLegalDecl(new CSLClass(cslBitrange));
  cslSigGroup.addLegalDecl(new CSLClass(cslField));
  cslSigGroup.addLegalDecl(new CSLClass(cslMultiDimBitrange));
  cslSigGroup.addLegalDecl(new CSLClass(cslSignal, OBJ_COUNT_TWO));

  /* legal inst
   */
  cslSigGroup.addLegalInst(new CSLClass(cslSigGroup));

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("off"));
  addCmd(CSL_SIGNAL_GROUP, CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS, false, true, false, cslParam, CSLCmdPointVect());

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("on"));
  addCmd(CSL_SIGNAL_GROUP, CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS, false, true, false, cslParam, CSLCmdPointVect());

  cslClasses.push_back(new CSLClass(cslSigGroup));
}

void buildStateData() {
  CSLParamPointVect cslParam;

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("inject_stalls"));
  addCmd(CSL_STATE_DATA, CMD_ADD_LOGIC, true, false, false);

  addCmd(CSL_STATE_DATA, CMD_GET_OUTPUT_FILENAME, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_RADIX, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_CAPTURE_EDGE_TYPE, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_CLOCK, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_COMPARE_TRIGGER, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_CPP_RD_NAME, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_CPP_WR_NAME, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_END_GENERATION_TRIGGER, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_HEADER_COMMENT, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_ID, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_MAX_NUMBER_OF_MISMATCHES, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_MAX_NUM_STATES, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_MODULE, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_NAME, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_RESET, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_STALL, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_START_GENERATION_TRIGGER, true, false, true);

  addCmd(CSL_STATE_DATA, CMD_GET_VC_TIMEOUT, true, false, true);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("binary"));
  addCmd(CSL_STATE_DATA, CMD_SET_RADIX, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("hex"));
  addCmd(CSL_STATE_DATA, CMD_SET_RADIX, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("fall"));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_CAPTURE_EDGE_TYPE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("raise"));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_CAPTURE_EDGE_TYPE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_CLOCK, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_COMPARE_TRIGGER, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("function_name"));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_CPP_RD_NAME, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("function_name"));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_CPP_WR_NAME, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_END_GENERATION_TRIGGER, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("header_comment"));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_HEADER_COMMENT, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(ID_DEFAULT));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_ID, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(MAX_CAPTURE_EVENTS_DEFAULT));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(MAX_MISMATCHES_DEFAULT));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_MAX_NUMBER_OF_MISMATCHES, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(MAX_TRANSACTION_EVENTS_DEFAULT));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_MAX_NUM_OF_TRANSACTION_EVENTS, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(MAX_STATES_DEFAULT));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_MAX_NUM_STATES, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("vc_name"));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_NAME, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("filename"));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_OUTPUT_FILENAME, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_RESET, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_STALL, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_START_GENERATION_TRIGGER, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(TIMEOUT_DEFAULT));
  addCmd(CSL_STATE_DATA, CMD_SET_VC_TIMEOUT, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(VERSION_DEFAULT));
  addCmd(CSL_STATE_DATA, CMD_SET_VERSION, true, false, false, cslParam);

  cslClasses.push_back(new CSLClass(cslStateData));
}

void buildTestbench() {
  CSLParamPointVect cslParam;

  /* legal decl
   */
  cslTestbench.addLegalDecl(new CSLClass(cslBitrange));
  cslTestbench.addLegalDecl(new CSLClass(cslField));
  cslTestbench.addLegalDecl(new CSLClass(cslMultiDimBitrange));
  cslTestbench.addLegalDecl(new CSLClass(cslSignal));
  cslTestbench.addLegalDecl(new CSLClass(cslPort));

  /* legal inst
   */
  cslTestbench.addLegalInst(new CSLClass(cslInterface));
  cslTestbench.addLegalInst(new CSLClass(cslSigGroup));
  cslTestbench.addLegalInst(new CSLClass(cslStateData));
  cslTestbench.addLegalInst(new CSLClass(cslUnit));

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("generate_waves"));
  cslParam.push_back(new CSLKeyWord("filename"));
  cslParam.push_back(new CSLKeyWord("fsdb"));
  addCmd(CSL_TESTBENCH, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("generate_waves"));
  cslParam.push_back(new CSLKeyWord("filename"));
  cslParam.push_back(new CSLKeyWord("vsd"));
  addCmd(CSL_TESTBENCH, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("generate_report"));
  addCmd(CSL_TESTBENCH, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("simulation_timeout_counter"));
  cslParam.push_back(new CSLConst(1));
  addCmd(CSL_TESTBENCH, CMD_ADD_LOGIC, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("stall_generation"));
  cslParam.push_back(new CSLKeyWord("DUT_name"));
  addCmd(CSL_TESTBENCH, CMD_ADD_LOGIC, false, false, false, cslParam);

  addCmd(CSL_TESTBENCH, CMD_GET_SIMULATION_TIMEOUT_COUNT, true, false, true);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("filename"));
  addCmd(CSL_TESTBENCH, CMD_SET_TESTBENCH_VERILOG_FILENAME, true, false, false, cslParam);

  cslClasses.push_back(new CSLClass(cslTestbench));
}

void buildUnit() {
  CSLParamPointVect cslParam;

  /* legal decl
   */
  cslUnit.addLegalDecl(new CSLClass(cslBitrange));
  cslUnit.addLegalDecl(new CSLClass(cslField));
  cslUnit.addLegalDecl(new CSLClass(cslMultiDimBitrange));
  cslUnit.addLegalDecl(new CSLClass(cslSignal));
  cslUnit.addLegalDecl(new CSLClass(cslPort));

  /* legal inst
   */
  cslUnit.addLegalInst(new CSLClass(cslField));
  cslUnit.addLegalInst(new CSLClass(cslFifo));
  cslUnit.addLegalInst(new CSLClass(cslInterface));
  cslUnit.addLegalInst(new CSLClass(cslMemory));
  cslUnit.addLegalInst(new CSLClass(cslRegister));
  cslUnit.addLegalInst(new CSLClass(cslRegFile));
  cslUnit.addLegalInst(new CSLClass(cslSigGroup));
  cslUnit.addLegalInst(new CSLClass(cslUnit));

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("unit_address_decoder"));
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_UNIT, CMD_ADD_LOGIC, false, false, false, cslParam);

  addCmd(CSL_UNIT, CMD_GET_SIGNAL_PREFIX, false, true, true);

  addCmd(CSL_UNIT, CMD_GET_SIGNAL_PREFIX_LOCAL, false, true, true);

  addCmd(CSL_UNIT, CMD_GET_UNIT_PREFIX, false, true, true);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("off"));
  addCmd(CSL_UNIT, CMD_SET_INSTANCE_ALTERATION_BIT, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("on"));
  addCmd(CSL_UNIT, CMD_SET_INSTANCE_ALTERATION_BIT, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"prefix\""));
  addCmd(CSL_UNIT, CMD_SET_SIGNAL_PREFIX_LOCAL, false, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("\"prefix\""));
  addCmd(CSL_UNIT, CMD_SET_UNIT_PREFIX, false, false, false, cslParam);

  cslClasses.push_back(new CSLClass(cslUnit));
}

void buildVector() {
  CSLParamPointVect cslParam;

  /* cmds
   */
  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("inject_stalls"));
  addCmd(CSL_VECTOR, CMD_ADD_LOGIC, true, false, false);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_PORT));
  addCmd(CSL_VECTOR, CMD_EXCLUSION_LIST, true, false, false, cslParam);

  addCmd(CSL_VECTOR, CMD_GET_OUTPUT_FILENAME, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_RADIX, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_CAPTURE_EDGE_TYPE, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_CLOCK, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_COMPARE_TRIGGER, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_CPP_RD_NAME, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_CPP_WR_NAME, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_END_GENERATION_TRIGGER, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_HEADER_COMMENT, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_ID, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_MAX_NUMBER_OF_MISMATCHES, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_MAX_NUM_STATES, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_MODULE, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_NAME, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_RESET, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_STALL, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_START_GENERATION_TRIGGER, true, false, true);

  addCmd(CSL_VECTOR, CMD_GET_VC_TIMEOUT, true, false, true);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_PORT));
  addCmd(CSL_VECTOR, CMD_INCLUDE_ONLY, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("inputs"));
  addCmd(CSL_VECTOR, CMD_SET_DIRECTION, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("outputs"));
  addCmd(CSL_VECTOR, CMD_SET_DIRECTION, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_UNIT));
  addCmd(CSL_VECTOR, CMD_SET_MODULE_NAME, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("binary"));
  addCmd(CSL_VECTOR, CMD_SET_RADIX, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("hex"));
  addCmd(CSL_VECTOR, CMD_SET_RADIX, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("fall"));
  addCmd(CSL_VECTOR, CMD_SET_VC_CAPTURE_EDGE_TYPE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("raise"));
  addCmd(CSL_VECTOR, CMD_SET_VC_CAPTURE_EDGE_TYPE, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_VECTOR, CMD_SET_VC_CLOCK, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_VECTOR, CMD_SET_VC_COMPARE_TRIGGER, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("function_name"));
  addCmd(CSL_VECTOR, CMD_SET_VC_CPP_RD_NAME, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("function_name"));
  addCmd(CSL_VECTOR, CMD_SET_VC_CPP_WR_NAME, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_VECTOR, CMD_SET_VC_END_GENERATION_TRIGGER, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("header_comment"));
  addCmd(CSL_VECTOR, CMD_SET_VC_HEADER_COMMENT, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(ID_DEFAULT));
  addCmd(CSL_VECTOR, CMD_SET_VC_ID, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(MAX_CAPTURE_EVENTS_DEFAULT));
  addCmd(CSL_VECTOR, CMD_SET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(MAX_MISMATCHES_DEFAULT));
  addCmd(CSL_VECTOR, CMD_SET_VC_MAX_NUMBER_OF_MISMATCHES, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(MAX_TRANSACTION_EVENTS_DEFAULT));
  addCmd(CSL_VECTOR, CMD_SET_VC_MAX_NUM_OF_TRANSACTION_EVENTS, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(MAX_STATES_DEFAULT));
  addCmd(CSL_VECTOR, CMD_SET_VC_MAX_NUM_STATES, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("vc_name"));
  addCmd(CSL_VECTOR, CMD_SET_VC_NAME, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLKeyWord("filename"));
  addCmd(CSL_VECTOR, CMD_SET_VC_OUTPUT_FILENAME, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_VECTOR, CMD_SET_VC_RESET, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_VECTOR, CMD_SET_VC_STALL, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLObjDecl(CSL_SIGNAL));
  addCmd(CSL_VECTOR, CMD_SET_VC_START_GENERATION_TRIGGER, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(TIMEOUT_DEFAULT));
  addCmd(CSL_VECTOR, CMD_SET_VC_TIMEOUT, true, false, false, cslParam);

  cslParam.clear();
  cslParam.push_back(new CSLConst(VERSION_DEFAULT));
  addCmd(CSL_VECTOR, CMD_SET_VERSION, true, false, false, cslParam);

  cslClasses.push_back(new CSLClass(cslVector));
}

void buildDeclVectors() {
  buildBitrange();
  buildEnum();
  buildEvent();
  buildField();
  buildFifo();
  buildInterface();
  buildIsaField();
  buildMemory();
  buildMemMap();
  buildMemMapPage();
  buildMultiDimBitrange();
  buildPort();
  buildRegister();
  buildRegFile();
  buildSignal();
  buildSigGroup();
  buildStateData();
  buildTestbench();
  buildUnit();
  buildVector();
}

void buildContainers() {
  buildGenericNames();
  buildClassNames();
  buildObjNames();
  buildCmdNames();
  buildDeclVectors();
}

bool isValidChapter(string chapter) {
  if (chapter == "fifo") {
    testChapter = CPT_FIFO;
    return true;
  }
  else if (chapter == "interconnect") {
    testChapter = CPT_INTERCON;
    return true;
  }
  else if (chapter == "isa") {
    testChapter = CPT_ISA;
    return true;
  }
  else if (chapter == "language") {
    testChapter = CPT_LANG;
    return true;
  }
  else if (chapter == "memory") {
    testChapter = CPT_MEM;
    return true;
  }
  else if (chapter == "memory_map") {
    testChapter = CPT_MEM_MAP;
    return true;
  }
  else if (chapter == "register") {
    testChapter = CPT_REG;
    return true;
  }
  else if (chapter == "register_file") {
    testChapter = CPT_REG_FILE;
    return true;
  }
  else if (chapter == "testbench") {
    testChapter = CPT_TESTB;
    return true;
  }
  else if (chapter == "verification_components") {
    testChapter = CPT_VERIFC;
    return true;
  }
  return false;
}

bool checkMainArgs(int argc,
                   char** argv) {

  if ((argc < 1) || (argc > 2)) {
    testErrorLog = string("Invalid number of arguments\n").append(argv[0]).append(" [fifo | interconnect | isa | language | memory | memory_map | register | register_file | testbench | verification_components]\n");
    return false;
  }

  if (argc == 2) {
    string secondArg = argv[1];
    if (secondArg == ARG_HELP) {
      testErrorLog = string(argv[0]).append(" [fifo | interconnect | isa | language | memory | memory_map | register | register_file | testbench | verification_components]\n");
      return false;
    }

    if (!isValidChapter(secondArg)) {
      testErrorLog = string("Invalid chapter name\n").append(argv[0]).append(" [fifo | interconnect | isa | language | memory | memory_map | register | register_file | testbench | verification_components]\n");
      return false;
    }
  }
  else {
    testChapter = CPT_ALL;
  }

  return true;
}

bool checkRepositoryPath() {
  if (!getAbsoluteTestPath()) {
    testErrorLog = string("Repository path check failed!\nPlease check the env variable ").append(ENV_VAR_NAME).append("\n");

    return false;
  }

  if (!checkPath(absoluteTestPath)) {
    testErrorLog = string("Repository path check failed!\nPlease check the env variable ").append(ENV_VAR_NAME).append("\n");

    return false;
  }

  return true;
}

bool checkPath(string path) {
  string check = string("cd ").append(path);
  return (!system(check.c_str()));
}

bool getAbsoluteTestPath() {
  char* aux = getenv(ENV_VAR_NAME);
  if (aux != NULL) {
    absoluteTestPath = string(aux).append(RELATIVE_TEST_PATH);

    return true;
  }
  else {
    return false;
  }
}

void createRegressionCtrl(string path,
                          bool valid) {

  string regressionCtrl = (valid ? REGRESSION_CTRL_VALID : REGRESSION_CTRL_INVALID);
  string filePath = string(path).append(REGRESSION_CTRL_FILE_NAME);

  ofstream output;
  output.open(filePath.c_str());

  output << regressionCtrl;

  output.close();
}


bool makeDir(const char* path,
             const char* dirName,
             bool isValid) {

  string dirPath = string(path).append(dirName);
  string mkDir = string("mkdir ").append(dirPath);

  if (system(mkDir.c_str())) {
    testErrorLog = string("Directory already exists !!!\n");
    return false;
  }

  createRegressionCtrl(dirPath, isValid);

  return true;
}

void buildValidInvalidDirs(string path,
                           string name) {

  string vDir = string(name).append(VALID_TEST_DIR_SUFFIX);
  makeDir(path.c_str(), vDir.c_str(), true);
  string invDir = string(name).append(INVALID_TEST_DIR_SUFFIX);
  makeDir(path.c_str(), invDir.c_str(), false);
}

void buildDirName(string &storeTo,
                  string path,
                  string name,
                  ETestGen tgType,
                  ECSLChapter cpt) {

  if (testChapter == CPT_ALL || testChapter == cpt) {
    string dirName = string(name).append(intToString(tgType));
    storeTo = string(path).append(dirName);
    buildValidInvalidDirs(path, dirName);
  }
}

void executeClean(string mask) {
  string command = string("rm ").append(absoluteTestPath).append(mask).append(" -rf");

  if (system(command.c_str())){
    testErrorLog = string("An error occured while attempting to purge the target directories\n");
  }
}

void buildMakeDirs(ETestGen tgType) {
  getTime(testStartTime);

  string mask = string("/*_cg").append(intToString(tgType)).append("_*");
  executeClean(mask);

  buildDirName(cFifo,           absoluteTestPath, "/csl_fifo_cg",                     tgType,   CPT_FIFO);
  buildDirName(cInterconnect,   absoluteTestPath, "/csl_interconnect_cg",             tgType,   CPT_INTERCON);
  buildDirName(cIsa,            absoluteTestPath, "/csl_isa_cg",                      tgType,   CPT_ISA);
  buildDirName(cLanguage,       absoluteTestPath, "/csl_language_cg",                 tgType,   CPT_LANG);
  buildDirName(cMemory,         absoluteTestPath, "/csl_memory_cg",                   tgType,   CPT_MEM);
  buildDirName(cMemMap,         absoluteTestPath, "/csl_memory_map_cg",               tgType,   CPT_MEM_MAP);
  buildDirName(cRegister,       absoluteTestPath, "/csl_register_cg",                 tgType,   CPT_REG);
  buildDirName(cRegisterFile,   absoluteTestPath, "/csl_register_file_cg",            tgType,   CPT_REG_FILE);
  buildDirName(cTestbench,      absoluteTestPath, "/csl_testbench_cg",                tgType,   CPT_TESTB);
  buildDirName(cVerifComp,      absoluteTestPath, "/csl_verification_components_cg",  tgType,   CPT_VERIFC);
}

EError runChecks(int argc,
                char** argv) {

  if (!checkMainArgs(argc, argv)) {
    DCERR(testErrorLog);
    return ERR_EXISTS;
  }

  if (!checkRepositoryPath()) {
    DCERR(testErrorLog);
    return ERR_EXISTS;
  }

  return ERR_NONE;
}

string determineDir(CSLClassPoint cls) {
  ECSLChapter chapter = cls->getChapter();

  switch (chapter) {
    case CPT_FIFO:
      return cFifo;
    case CPT_INTERCON:
      return cInterconnect;
    case CPT_ISA:
      return cIsa;
    case CPT_LANG:
      return cLanguage;
    case CPT_MEM:
      return cMemory;
    case CPT_MEM_MAP:
      return cMemMap;
    case CPT_REG:
      return cRegister;
    case CPT_REG_FILE:
      return cRegisterFile;
    case CPT_TESTB:
      return cTestbench;
    case CPT_VERIFC:
      return cVerifComp;
    default:
      #ifdef _CGEN_DEBUG_MODE_
      ASSERT(FAIL, "determineDir(...) returns empty string");
      #endif
      return EMPTY_STRING;
  }
}

bool belongsToChapter(CSLClassPoint cls) {
  return ((testChapter == CPT_ALL) || (cls->getChapter() == testChapter));
}

void buildHeader(char* binaryFileName) {
  testFileHeader.append("//Gen : ").append(binaryFileName).append("\n");
}

void createReport(char* binaryFileName,
                  ETestGen tgType) {

  string fileName = string(absoluteTestPath).append(REPORT_FILE_NAME).append(intToString(tgType));

  ofstream output;
  output.open(fileName.c_str());

  output << "Executed " << binaryFileName << endl;
  output << "Test count : " << testCounter << endl;

  getTime(testEndTime);
  output << "Time elapsed(s) : " << (testEndTime - testStartTime) << endl;

  output.close();
}

EError runTestGen(ETestGen tgType,
                 int argc,
                 char** argv,
                 void (*f)()) {

  char* binaryFileName = argv[0];
  EError _err = runChecks(argc, argv);
  if (_err != ERR_NONE) {
    return _err;
  }

  buildContainers();

  buildMakeDirs(tgType);

  buildHeader(binaryFileName);

  f();

  createReport(binaryFileName, tgType);

  return ERR_NONE;
}

void printScopeBegin(ostream& output,
                     CSLClassPoint cls,
                     ECSLClassStringMap nameBase,
                     string alignment) {

  cls->print(output, nameBase, alignment);
  output << " {" << endl;
}

void printScopeConstrBegin(ostream& output,
                           CSLClassPoint cls,
                           ECSLClassStringMap nameBase,
                           string alignment) {

  output << alignment;
  cls->print(output, nameBase);
  output << "() {" << endl;
  CSLCmdPointVect cmdVect = cls->getMandatoryCmds();
  string newAlingment = string(alignment).append(ALIGN_SCOPE);
  for (CSLCmdPointVect_const_iter cmd = cmdVect.begin(); cmd != cmdVect.end(); cmd++) {
    printScopeCall(output, *cmd, newAlingment);
  }
}

void printScopeCall(ostream& output,
                    CSLCmdPoint cmd,
                    string alignment) {

  CSLCmdPointVect preCmdVect = cmd->getPreCmdVect();
  printScopeCallVect(output, preCmdVect, alignment);
  cmd->print(output, alignment);
}

void printScopeCallVect(ostream& output,
                        CSLCmdPointVect cmdVect,
                        string alignment) {

  for (CSLCmdPointVect_const_iter cmd = cmdVect.begin(); cmd != cmdVect.end(); cmd++) {
    printScopeCall(output, *cmd, alignment);
  }
}

void printCallParam(ostream& output,
                    CSLParamPointVect paramVect,
                    unsigned objCount) {

  unsigned count = paramVect.size();
  unsigned pass = 0;
  for (CSLParamPointVect_const_iter param = paramVect.begin(); param != paramVect.end(); param++) {
    if ((*param)->isObjDeclParam()) {
      CSLObjDeclPoint objParam = static_cast<CSLObjDeclPoint>(*param);
      objParam->print(output, objCount);
    }
    else {
      (*param)->print(output);
    }

    if (++pass < count) {
      output << ", ";
    }
  }
}

void printScopeConstrEnd(ostream& output,
                         string alignment) {

  output << alignment << "}" << endl;
}

void printScopeEnd(ostream& output,
                   string alignment) {

  output << alignment << "};" << endl;
}

void printPlainDecl(ostream& output,
                    CSLClassPoint cls,
                    ECSLClassStringMap nameBase,
                    CSLParamPointVect paramVect,
                    string alignment) {

  cls->print(output, nameBase, alignment);
  StringStringPair specialDeclChars = cls->getSpecialDeclChars();
  string openParanthesys = ((specialDeclChars.first == "") ? "(" : specialDeclChars.first);
  string closeParanthesys = ((specialDeclChars.second == "") ? ")" : specialDeclChars.second);
  if (!paramVect.empty()) {
    output << openParanthesys;
    printCallParam(output, paramVect, cls->getObjCount());
    output << closeParanthesys;
  }
  output << ";" << endl;
}

void printPlainDeclVect(ostream& output,
                        CSLClassPointCSLParamVectPointPairVect preDeclVect,
                        ECSLClassStringMap nameBase,
                        string alignment) {

  for (CSLClassPointCSLParamVectPointPairVect_const_iter preDecl = preDeclVect.begin(); preDecl != preDeclVect.end(); preDecl++) {

    #ifdef _CGEN_DEBUG_MODE_
    ASSERT((*preDecl).first, "NULL pointer received");
    ASSERT((*preDecl).second, "NULL pointer received");
    #endif

    printPlainDecl(output, (*preDecl).first, nameBase, *(*preDecl).second, alignment);
  }
}

void printParamDecl(ostream& output,
                    ECSLParamDecl declType,
                    CSLParamPointVect paramVect,
                    unsigned objCount,
                    string alignment) {
  
  for (CSLParamPointVect_const_iter param = paramVect.begin(); param != paramVect.end(); param++) {
    if ((*param)->isObjDeclParam()) {
      CSLObjDeclPoint obj = static_cast<CSLObjDeclPoint>(*param);
      if (obj->getParamDecl() == declType) {
        obj->print(output, objCount, alignment);
      }
    }
  }
}

void printParamDeclVect(ostream& output,
                        ECSLParamDecl declType,
                        CSLClassPointCSLParamVectPointPairVect preDeclVect,
                        string alignment) {

  for (CSLClassPointCSLParamVectPointPairVect_const_iter cls = preDeclVect.begin(); cls != preDeclVect.end(); cls++) {
    printParamDecl(output, declType, *(*cls).second, (*cls).first->getObjCount(), alignment);
  }
}

void printPlainCall(ostream& output,
                    CSLClassPoint cls,
                    ECSLClassStringMap nameBase,
                    CSLCmdPoint cmd,
                    string alignment) {

  output << alignment;
  cls->print(output, nameBase);
  output << ".";
  cmd->print(output);
}

void printPlainHidCall(ostream& output,
                       string scopeHID,
                       CSLClassPoint cls,
                       ECSLClassStringMap nameBase,
                       CSLCmdPoint cmd,
                       string alignment) {

  output << alignment << scopeHID << ".";
  cls->print(output, nameBase);
  output << ".";
  cmd->print(output);
}

void printPlainCallVect(ostream& output,
                        CSLClassPoint cls,
                        ECSLClassStringMap nameBase,
                        CSLCmdPointVect cmdVect,
                        string alignment) {

  for (CSLCmdPointVect_const_iter cmd = cmdVect.begin(); cmd != cmdVect.end(); cmd++) {
    if ((*cmd)->getCanCallFromGlobalScope()) {
      printPlainCall(output, cls, nameBase, *cmd, alignment);
    }
  }
}

void printInstDecl(ostream& output,
                   CSLClassPoint cls,
                   ECSLClassStringMap nameBase,
                   string alignment) {

  output << alignment;
  cls->print(output, nameBase);
  output << " ";
  cls->print(output, cslInst1Name);
  output << ";" << endl;
}

void openFile(ofstream& output,
              string fileName) {

  output.open(fileName.c_str());
}

void closeFile(ofstream& output,
               string fileName,
               string fileHeader) {

  output << endl << "//File: " << fileName << endl;
  output << "//Date: " << getTime();
  output << fileHeader << endl;

  output.close();

  testCounter++;
}

CSLClassPointCSLParamVectPointPairVectVect createPreDeclVectOrder(CSLClassPointVect preDecl) {
  if (preDecl.empty()) {
    return CSLClassPointCSLParamVectPointPairVectVect();
  }

  CSLClassPointCSLParamVectPointPairVect current;
  CSLClassPointCSLParamVectPointPairVectVect ret;
  CSLParamPointVectVect_const_iterVect paramsIterVect;

  for (CSLClassPointVect_const_iter preDeclClass = preDecl.begin(); preDeclClass != preDecl.end(); preDeclClass++) {
    CSLParamPointVectVectPoint params = (*preDeclClass)->getParamsPoint();

    paramsIterVect.push_back(params->begin());
  }

  CSLClassPointVect_const_iter preDeclIter;
  CSLParamPointVectVect_const_iterVect_iter paramsIter;
  CSLParamPointVect paramVect;
  bool increment = false;

  while (!increment) {
    current.clear();
    increment = true;
    preDeclIter = preDecl.begin();
    paramsIter = paramsIterVect.begin();

    while (preDeclIter != preDecl.end()) {
      CSLParamPointVectVectPoint currentParams = (*preDeclIter)->getParamsPoint();

      #ifdef _CGEN_DEBUG_MODE_
      ASSERT(&(**paramsIter) != NULL, "NULL pointer found");
      #endif

      current.push_back(make_pair(*preDeclIter, &(**paramsIter)));

      if (increment) {
        if (++(*paramsIter) == currentParams->end()) {
          (*paramsIter) = currentParams->begin();
        }
        else if (!currentParams->empty()){
          increment = false;
        }
        else {
          #ifdef _CGEN_DEBUG_MODE_
          ASSERT(*paramsIter == currentParams->end(), "Stepped out of the param vector");
          #endif
        }
      }

      preDeclIter++;
      paramsIter++;
    }

    ret.push_back(current);
  }

  return ret;
}

CSLEnumItemPoint castToEnumItem(CSLParamPoint param) {
  if (param->getParamType() == PT_ENUM_ITEM) {
    return static_cast<CSLEnumItemPoint>(param);
  }

  return NULL;
}

CSLClassPointVect getPreDeclVect(CSLParamPoint param) {
  CSLEnumItemPoint enumItem = castToEnumItem(param);

  if (enumItem) {
    return enumItem->getPreDeclVect();
  }

  return CSLClassPointVect();
}

CSLClassPointCSLParamVectPointPairVectVect getPreDeclVectOrder(CSLParamPointVect paramVect) {
  CSLClassPointVect preDeclVect;

  for (CSLParamPointVect_const_iter param = paramVect.begin(); param != paramVect.end(); param++) {
    CSLClassPointVect aux = getPreDeclVect(*param);

    for (CSLClassPointVect_const_iter cls = aux.begin(); cls != aux.end(); cls++) {
      preDeclVect.push_back(*cls);
    }
  }

  CSLClassPointCSLParamVectPointPairVectVect ret = createPreDeclVectOrder(preDeclVect);
  return ret;
}

/* DEBUG
 */
void test() {
  CSLClassPointVect preDecl;

  preDecl.push_back(new CSLClass(cslSignal));

  createPreDeclVectOrder(preDecl);
}
/*~DEBUG
 */

string appendStrings(CSLClassPoint cls,
                     string dirSuffix,
                     unsigned count,
                     CSLCmdPoint cmd) {

  string clsName = GET_CLASS(cslTypeName, cls->getClass());
  string ret =  determineDir(cls).append(dirSuffix).append(clsName).append("_");
  if (cmd != NULL) {
    string cmdName = GET_CMD(cslCmdName, cmd->getCmdType());
    ret.append(cmdName).append("_");
  }
  ret.append(intToString(count)).append(TEST_EXTENSION);

  return ret;
}

string appendStrings(CSLClassPoint cls,
                     CSLClassPoint obj,
                     string dirSuffix,
                     unsigned count,
                     CSLCmdPoint cmd) {

  string clsName = GET_CLASS(cslTypeName, cls->getClass());
  string objName = GET_CLASS(cslTypeName, obj->getClass());
  string ret = determineDir(cls).append(dirSuffix).append(clsName).append("_").append(objName).append("_");
  if (cmd != NULL) {
    string cmdName = GET_CMD(cslCmdName, cmd->getCmdType());
    ret.append(cmdName).append("_");
  }
  ret.append(intToString(count)).append(TEST_EXTENSION);

  return ret;
}

void determineFileName(CSLClassPoint cls,
                       string& fileName,
                       string& fileHeader,
                       bool valid,
                       string comment,
                       CSLCmdPoint cmd) {

  fileHeader = testFileHeader;

  if (valid) {
    fileName = appendStrings(cls, VALID_TEST_DIR_SUFFIX, cls->incLegalCounter(), cmd);
    fileHeader.append(VALID_TEST_HEADER);
  }
  else {
    fileName = appendStrings(cls, INVALID_TEST_DIR_SUFFIX, cls->incIllegalCounter(), cmd);
    fileHeader.append(INVALID_TEST_HEADER);
  }

  fileHeader.append(comment);
}

void determineFileName(CSLClassPoint cls,
                       CSLClassPoint obj,
                       string& fileName,
                       string& fileHeader,
                       bool valid,
                       string comment,
                       CSLCmdPoint cmd) {

  fileHeader = testFileHeader;

  if (valid) {
    fileName = appendStrings(cls, obj, VALID_TEST_DIR_SUFFIX, cls->incLegalCounter(), cmd);
    fileHeader.append(VALID_TEST_HEADER);
  }
  else {
    fileName = appendStrings(cls, obj, INVALID_TEST_DIR_SUFFIX, cls->incIllegalCounter(), cmd);
    fileHeader.append(INVALID_TEST_HEADER);
  }

  fileHeader.append(comment);
}

//******************************************************************************//
// CSLChapter class                                                             //
//******************************************************************************//
CSLChapter::CSLChapter(ECSLChapter cpt)
  : m_chapter(cpt),
    m_illegalCounter(0),
    m_legalCounter(0) {}

unsigned CSLChapter::incIllegalCounter() {
  return (++m_illegalCounter);
}

unsigned CSLChapter::incLegalCounter() {
  return (++m_legalCounter);
}

ECSLChapter CSLChapter::getChapter() const {
  return m_chapter;
}

//******************************************************************************//
// CSLClass class                                                               //
//******************************************************************************//
CSLClass::CSLClass(CSLChapterPoint cpt,
                   ECSLClass cslClass,
                   bool isScopeHolder,
                   StringStringPair specialDeclChars)

  : m_chapter(cpt),
    m_cslClass(cslClass),
    m_isScopeHolder(isScopeHolder),
    m_mandatoryCmds(CSLCmdPointVect()),
    m_mandatoryObjs(CSLClassPointVect()),
    m_legalDecl(CSLClassPointVect()),
    m_legalInst(CSLClassPointVect()),
    m_declParam(CSLParamPointVectVect()),
    m_specialDeclChars(specialDeclChars),
    m_objCount(OBJ_COUNT_ZERO) {}

CSLClass::CSLClass(const CSLClass& other,
                   unsigned objCount)

  : m_chapter(other.getChapterPoint()),
    m_cslClass(other.getClass()),
    m_isScopeHolder(other.isScopeHolder()),
    m_mandatoryCmds(other.getMandatoryCmds()),
    m_mandatoryObjs(other.getMandatoryObjs()),
    m_legalDecl(other.getLegalDecl()),
    m_legalInst(other.getLegalInst()),
    m_declParam(other.getParams()),
    m_specialDeclChars(other.getSpecialDeclChars()),
    m_objCount(objCount) {}

CSLClass::~CSLClass() {
}

void CSLClass::addMandatoryCmd(CSLCmdPoint cmd) {
  m_mandatoryCmds.push_back(cmd);
}

void CSLClass::addMandatoryObj(CSLClassPoint obj) {
  m_mandatoryObjs.push_back(obj);
}

void CSLClass::addLegalDecl(CSLClassPoint cls) {
  m_legalDecl.push_back(cls);
}

void CSLClass::addLegalInst(CSLClassPoint cls) {
  m_legalInst.push_back(cls);
}

void CSLClass::addDeclParamVect(CSLParamPointVect paramVect) {
  m_declParam.push_back(paramVect);
}

unsigned CSLClass::incIllegalCounter() {
  return m_chapter->incIllegalCounter();
}

unsigned CSLClass::incLegalCounter() {
  return m_chapter->incLegalCounter();
}

ECSLChapter CSLClass::getChapter() const {
  return m_chapter->getChapter();
}

CSLChapterPoint CSLClass::getChapterPoint() const {
  return m_chapter;
}

bool CSLClass::isScopeHolder() const {
  return m_isScopeHolder;
}

bool CSLClass::isPlainDecl() const {
  return ((!isScopeHolder()) || (isScopeHolder() && (m_declParam.size() > 0)));
}

ECSLClass CSLClass::getClass() const {
  return m_cslClass;
}

CSLCmdPointVect CSLClass::getMandatoryCmds() const {
  return m_mandatoryCmds;
}

CSLClassPointVect CSLClass::getMandatoryObjs() const {
  return m_mandatoryObjs;
}

CSLClassPointVect CSLClass::getLegalDecl() const {
  return m_legalDecl;
}

CSLClassPointVect CSLClass::getLegalInst() const {
  return m_legalInst;
}

CSLParamPointVectVect CSLClass::getParams() const {
  return m_declParam;
}

CSLParamPointVectVectPoint CSLClass::getParamsPoint() const {
  return &m_declParam;
}

StringStringPair CSLClass::getSpecialDeclChars() const {
  return m_specialDeclChars;
}

unsigned CSLClass::getObjCount() const {
  return m_objCount;
}

CSLClassPoint CSLClass::getObjDecl(CSLClassPoint obj) const {
  CSLClassPointVect legalDecl = getLegalDecl();

  for (CSLClassPointVect_const_iter objDecl = legalDecl.begin(); objDecl != legalDecl.end(); objDecl++) {
    if ((*objDecl)->getClass() == obj->getClass()) {
      return *objDecl;
    }
  }

  return obj;
}

bool CSLClass::isLegalDecl(ECSLClass obj) const {
  for (CSLClassPointVect_const_iter cls = m_legalDecl.begin(); cls != m_legalDecl.end(); cls++) {
    if (obj == (*cls)->getClass()) {
      return true;
    }
  }
  return false;
}

bool CSLClass::isLegalInst(ECSLClass obj) const {
  for (CSLClassPointVect_const_iter cls = m_legalInst.begin(); cls != m_legalInst.end(); cls++) {
    if (obj == (*cls)->getClass()) {
      return true;
    }
  }
  return false;
}

void CSLClass::print(ostream& output,
                     ECSLClassStringMap nameBase,
                     string alignment) {

  output << alignment << GET_CLASS(cslTypeName, getClass()) << " " << GET_CLASS(nameBase, getClass());

  if (getObjCount() != OBJ_COUNT_ZERO) {
    output << intToString(getObjCount());
  }
}

void CSLClass::print(ostream& output,
                     ECSLClassStringMap nameBase) {

  output << GET_CLASS(nameBase, getClass());

  if (getObjCount() != OBJ_COUNT_ZERO) {
    output << intToString(getObjCount());
  }
}

//******************************************************************************//
// CSLCmd class                                                                 //
//******************************************************************************//
CSLCmd::CSLCmd(ECSLCmdType cmdType,
               bool canCallFromGlobalScope,
               bool canCallFromInstance,
               bool returnValue,
               CSLParamPointVect paramVect)

  : m_cmdType(cmdType),
    m_paramVect(paramVect),
    m_canCallFromGlobalScope(canCallFromGlobalScope),
    m_canCallFromInstance(canCallFromInstance),
    m_returnValue(returnValue) {}

CSLCmd::CSLCmd(const CSLCmd& other)
  : m_cmdType(other.getCmdType()),
    m_canCallFromGlobalScope(other.getCanCallFromGlobalScope()),
    m_canCallFromInstance(other.getCanCallFromInstance()),
    m_returnValue(other.getReturnValue()),
    m_callerVect(other.getCallerVect()),
    m_paramVect(other.getParamVect()),
    m_preCmdVect(other.getPreCmdVect()) {}

CSLCmd::~CSLCmd() {
}

void CSLCmd::addParam(CSLParamPoint cslParam) {
  m_paramVect.push_back(cslParam);
}

void CSLCmd::addParamVect(CSLParamPointVect paramVect) {
  m_paramVect = paramVect;
}

void CSLCmd::addCaller(ECSLClass cslClass) {
  if (!isCaller(cslClass)) {
    m_callerVect.push_back(cslClass);
  }
}

void CSLCmd::addPreCmd(CSLCmdPoint preCmd) {
  m_preCmdVect.push_back(preCmd);
}

void CSLCmd::addPreCmdVect(CSLCmdPointVect preCmdVect) {
  m_preCmdVect = preCmdVect;
}

ECSLCmdType CSLCmd::getCmdType() const {
  return m_cmdType;
}

ECSLClassVector CSLCmd::getCallerVect() const {
  return m_callerVect;
}

CSLParamPointVect CSLCmd::getParamVect() const {
  return m_paramVect;
}

CSLCmdPointVect CSLCmd::getPreCmdVect() const {
  return m_preCmdVect;
}

bool CSLCmd::getCanCallFromGlobalScope() const {
  return m_canCallFromGlobalScope;
}

bool CSLCmd::getCanCallFromInstance() const {
  return m_canCallFromInstance;
}

bool CSLCmd::getReturnValue() const {
  return m_returnValue;
}

bool CSLCmd::isCaller(ECSLClass cls) const {
  for (ECSLClassVector_const_iter it = m_callerVect.begin(); it != m_callerVect.end(); it++) {
    if ((*it) == cls) {
      return true;
    }
  }
  return false;
}

bool CSLCmd::operator==(const CSLCmd& other) const {
  if (m_cmdType != other.getCmdType()) {
    return false;
  }

  CSLParamPointVect paramVect = other.getParamVect();
  if (m_paramVect.size() != paramVect.size()) {
    return false;
  }

  for (CSLParamPointVect_const_iter param = m_paramVect.begin(), otherParam = paramVect.begin(); (param != m_paramVect.end()) && (otherParam != paramVect.end()); param++, otherParam++) {
    if (**param != **otherParam) {
      return false;
    }
  }

  return true;
}

void CSLCmd::print(ostream& output, string alignment) {
  output << alignment << GET_CMD(cslCmdName, getCmdType()) << "(";
  CSLParamPointVect paramVect = getParamVect();
  printCallParam(output, paramVect);
  output << ");" << endl;
}

//******************************************************************************//
// CSLParam class                                                               //
//******************************************************************************//
CSLParam::CSLParam(ECSLParamType paramType)
  : m_paramType(paramType) {}

bool CSLParam::isKeyWordParam() const {
  return (m_paramType == PT_KEY_WORD);
}

bool CSLParam::isObjDeclParam() const {
  return (m_paramType == PT_OBJECT);
}

bool CSLParam::isConstParam() const {
  return (m_paramType == PT_CONST);
}

CSLParam::~CSLParam() {
}

ECSLParamType CSLParam::getParamType() const {
  return m_paramType;
}

//******************************************************************************//
// CSLEnumItem class                                                            //
//******************************************************************************//
CSLEnumItem::CSLEnumItem(bool preDecl)
  : CSLParam(PT_ENUM_ITEM) {
  if (preDecl) {
    m_preDeclVect.push_back(new CSLClass(cslEnum));
  }
}

CSLEnumItem::~CSLEnumItem() {
}

CSLClassPointVect CSLEnumItem::getPreDeclVect() const {
  return m_preDeclVect;
}

void CSLEnumItem::print(ostream& output) {
  output << GET_CLASS(cslParamName, CSL_ENUM_ITEM);
}

bool CSLEnumItem::operator==(const CSLParam& other) const {
  return true;
}

bool CSLEnumItem::operator!=(const CSLParam& other) const {
  return !(operator==(other));
}

//******************************************************************************//
// CSLObjDecl class                                                             //
//******************************************************************************//
CSLObjDecl::CSLObjDecl(ECSLClass objClass,
                       CSLParamPointVect objParamVect,
                       ECSLParamDecl paramDecl,
                       string suffix)

  : CSLParam(PT_OBJECT),
    m_objClass(objClass),
    m_objParamVect(objParamVect),
    m_paramDecl(paramDecl),
    m_suffix(suffix) {}

CSLObjDecl::~CSLObjDecl() {
}

ECSLClass CSLObjDecl::getClass() const {
  return m_objClass;
}

CSLParamPointVect CSLObjDecl::getParamVect() const {
  return m_objParamVect;
}

ECSLParamDecl CSLObjDecl::getParamDecl() const {
  return m_paramDecl;
}

string CSLObjDecl::getObjName(unsigned objCount) const {
  string ret = GET_CLASS(cslParamName, getClass());
  ret.append(m_suffix);

  if (objCount != OBJ_COUNT_ZERO) {
    ret.append(intToString(objCount));
  }

  return ret;
}

void CSLObjDecl::print(ostream& output) {
  output << GET_CLASS(cslParamName, getClass()) << m_suffix;
}

void CSLObjDecl::print(ostream& output,
                       unsigned objCount) {

  output << getObjName(objCount);
}

void CSLObjDecl::print(ostream& output,
                       unsigned objCount,
                       string alignment) {

  output << alignment << GET_CLASS(cslTypeName, getClass()) << " " << getObjName(objCount);

  CSLParamPointVect objParamVect = getParamVect();
  if (!objParamVect.empty()) {
    output << "(";
    printCallParam(output, objParamVect);
    output << ")";
  }
  output << ";" << endl;
}

bool CSLObjDecl::operator==(const CSLParam& other) const {
  const CSLObjDecl& otherObj = static_cast<const CSLObjDecl&>(other);

  if (m_paramDecl != otherObj.getParamDecl()) {
    return false;
  }

  if (m_objClass != otherObj.getClass()) {
    return false;
  }

  CSLParamPointVect paramVect = otherObj.getParamVect();
  if (m_objParamVect.size() != paramVect.size()) {
    return false;
  }

  for (CSLParamPointVect_const_iter param = m_objParamVect.begin(), otherParam = paramVect.begin(); (param != m_objParamVect.end()) && (otherParam != paramVect.end()); param++, otherParam++) {
    if (**param != **otherParam) {
      return false;
    }
  }

  return true;
}

bool CSLObjDecl::operator!=(const CSLParam& other) const {
  return !(operator==(other));
}

//******************************************************************************//
// CSLKeyWord class                                                             //
//******************************************************************************//
CSLKeyWord::CSLKeyWord(string keyWord)
  : CSLParam(PT_KEY_WORD),
    m_keyWord(keyWord) {}

CSLKeyWord::~CSLKeyWord() {
}

string CSLKeyWord::getKeyWord() const {
  return m_keyWord;
}

void CSLKeyWord::print(ostream& output) {
  output << m_keyWord;
}

bool CSLKeyWord::operator==(const CSLParam& other) const {
  const CSLKeyWord& otherObj = static_cast<const CSLKeyWord&>(other);
  return (m_keyWord == otherObj.getKeyWord());
}

bool CSLKeyWord::operator!=(const CSLParam& other) const {
  return !(operator==(other));
}

//******************************************************************************//
// CSLConst class                                                               //
//******************************************************************************//
CSLConst::CSLConst(unsigned constVal)
  : CSLParam(PT_CONST),
    m_const(constVal) {}

CSLConst::~CSLConst() {
}

unsigned CSLConst::getConst() const {   
  return m_const;
}

void CSLConst::print(ostream& output) {
  output << m_const;
}

bool CSLConst::operator==(const CSLParam& other) const {
  const CSLConst& otherObj = static_cast<const CSLConst&>(other);
  return (m_const == otherObj.getConst());
}

bool CSLConst::operator!=(const CSLParam& other) const {
  return !(operator==(other));
}
