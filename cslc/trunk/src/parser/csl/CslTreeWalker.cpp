/* $ANTLR 2.7.7 (2006-11-01): "csl.walker.g" -> "CslTreeWalker.cpp"$ */
#include "CslTreeWalker.hpp"
#include <antlr/Token.hpp>
#include <antlr/AST.hpp>
#include <antlr/NoViableAltException.hpp>
#include <antlr/MismatchedTokenException.hpp>
#include <antlr/SemanticException.hpp>
#include <antlr/BitSet.hpp>
#line 46 "csl.walker.g"

ANTLR_USING_NAMESPACE(antlr);
ANTLR_USING_NAMESPACE(std);
ANTLR_USING_NAMESPACE(NSCSLOm);

#define _RS(str) (RefString(new string(str)))

#include <iostream>

#define __PRINT_AST

#ifdef __PRINT_AST

#define PRINT_AST(x) printAST(x)

#else

#define PRINT_AST(x)

#endif

void CslTreeWalker::printAST(antlr::RefCslAST ast) {
cout << "Found " << getTokenName(ast->getType())
<< " '" << ast->getText()

<< "'"
<< " <"
<< ast->getLine() << ":"
<< ast->getColumn()
<< ">"
<< endl;
}

#line 44 "CslTreeWalker.cpp"
CslTreeWalker::CslTreeWalker()
	: ANTLR_USE_NAMESPACE(antlr)TreeParser() {
}

void CslTreeWalker::source_text(antlr::RefCslAST _t,
	NSCSLOm::RefCSLOmDesign design_param, RefTVec_RefString vCurrentScope_param
) {
	antlr::RefCslAST source_text_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 98 "csl.walker.g"
	
	design = design_param;
	vCurrentScope = vCurrentScope_param;
	scopeBlocks = NSCSLOm::RefTVec_RefCSLOmBase( new NSCSLOm::TVec_RefCSLOmBase() );
	ASSERT( design.get() , "ERROR: The design is not initialised!" );
	ASSERT( vCurrentScope.get() , "ERROR: The current scope vector is uninitialised!" );
	scopeBlocks->push_back( design );
	
#line 62 "CslTreeWalker.cpp"
	
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_0.member(_t->getType()))) {
			description(_t);
			_t = _retTree;
		}
		else {
			goto _loop3;
		}
		
	}
	_loop3:;
	} // ( ... )*
#line 108 "csl.walker.g"
	
	
#line 82 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::description(antlr::RefCslAST _t) {
	antlr::RefCslAST description_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_CSL_UNIT:
	case K_CSL_LIST:
	case K_CSL_INTERFACE:
	case K_CSL_REGISTER_FILE:
	case K_CSL_REGISTER:
	case K_CSL_PORT:
	case K_CSL_SIGNAL:
	case K_CSL_BITRANGE:
	case K_CSL_SIGNAL_GROUP:
	case K_CSL_TESTBENCH:
	case K_CSL_EVENT:
	case K_CSL_INCLUDE:
	case K_CSL_ISA_FIELD:
	case K_CSL_ISA_ELEMENT:
	case K_CSL_ENUM:
	case K_CSL_FIELD:
	case K_CSL_FIFO:
	case K_CSL_MEMORY_MAP:
	case K_CSL_MEMORY_MAP_PAGE:
	case K_CSL_STATE_DATA:
	case K_CSL_VECTOR:
	case K_CSL_MEMORY:
	case K_CSL_MULTI_DIM_BITRANGE:
	case K_CSL_PARAMETER:
	case K_CSL_ISA:
	case K_CSL_DESIGN:
	case K_CSL_ADDRESS_RANGE:
	case K_CSL_BOOL_EQUATION:
	case K_CSL_SIGNAL_PATTERN_GENERATOR:
	{
		csl_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_VOID:
	{
		csl_function_declaration(_t);
		_t = _retTree;
		break;
	}
	default:
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_1.member(_t->getType()))) {
			csl_command(_t);
			_t = _retTree;
		}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void CslTreeWalker::csl_command(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_command_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 118 "csl.walker.g"
	
	NSCSLOm::RefCSLOmBase obj = RefCSLOmBase();
	
#line 152 "CslTreeWalker.cpp"
	
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_ADD_CLOCK:
	{
		command_add_clock(_t);
		_t = _retTree;
		break;
	}
	case K_ADD_RESET:
	{
		command_add_reset(_t);
		_t = _retTree;
		break;
	}
	case K_ADD_EQUATION:
	{
		command_add_equation(_t);
		_t = _retTree;
		break;
	}
	case K_ADD_ADDRESS_RANGE:
	{
		command_add_address_range(_t);
		_t = _retTree;
		break;
	}
	case K_SET_ADDRESS_INCREMENT:
	{
		command_set_address_increment(_t);
		_t = _retTree;
		break;
	}
	case K_SET_NEXT_ADDRESS:
	{
		command_set_next_address(_t);
		_t = _retTree;
		break;
	}
	case K_ADD_RESERVED_ADDRESS_RANGE:
	{
		command_add_reserved_range(_t);
		_t = _retTree;
		break;
	}
	case K_ADD:
	{
		command_add(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DATA_WORD_WIDTH:
	{
		command_set_data_word_width(_t);
		_t = _retTree;
		break;
	}
	case K_SET_ALIGNMENT:
	{
		command_set_alignament(_t);
		_t = _retTree;
		break;
	}
	case K_SET_ENDIANESS:
	{
		command_set_endianess(_t);
		_t = _retTree;
		break;
	}
	case K_SET_SYMBOL_MAX_LENGTH:
	{
		command_set_symbol_max_length(_t);
		_t = _retTree;
		break;
	}
	case K_SET_PREFIX:
	{
		command_set_prefix(_t);
		_t = _retTree;
		break;
	}
	case K_NO_PREFIX_COMMAND:
	{
		command_no_prefix(_t);
		_t = _retTree;
		break;
	}
	case K_SET_SUFFIX:
	{
		command_set_suffix(_t);
		_t = _retTree;
		break;
	}
	case K_SET_TYPE:
	{
		command_set_type(_t);
		_t = _retTree;
		break;
	}
	case K_SET_ATTR:
	{
		command_set_attr(_t);
		_t = _retTree;
		break;
	}
	case K_SET_ATTRIBUTES:
	{
		command_set_attributes(_t);
		_t = _retTree;
		break;
	}
	case K_TRANSACTION_TIMEOUT_COUNTER:
	{
		command_set_transaction_timeout_counter(_t);
		_t = _retTree;
		break;
	}
	case K_SIMULATION_TIMEOUT_COUNTER:
	{
		command_set_simulation_timeout_counter(_t);
		_t = _retTree;
		break;
	}
	case K_ADD_ARCH_STATE:
	{
		command_add_arch_state(_t);
		_t = _retTree;
		break;
	}
	case K_SET_MEM_INSTANCE_NAME:
	{
		command_set_instance_name(_t);
		_t = _retTree;
		break;
	}
	case K_SET_UNIT_NAME:
	{
		command_set_unit_name(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DIRECTION:
	{
		command_set_direction(_t);
		_t = _retTree;
		break;
	}
	case K_EXCLUSION_LIST:
	{
		command_exclusion_list(_t);
		_t = _retTree;
		break;
	}
	case K_INCLUDE_ONLY:
	{
		command_include_only(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_ID:
	{
		command_set_vc_id(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_NAME:
	{
		command_set_vc_name(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_HEADER_COMMENT:
	{
		command_set_vc_header_comment(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VERSION:
	{
		command_set_vc_version(_t);
		_t = _retTree;
		break;
	}
	case K_SET_RADIX:
	{
		command_set_radix(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_CLOCK:
	{
		command_set_vc_clock(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_RESET:
	{
		command_set_vc_reset(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_STALL:
	{
		command_set_vc_stall(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_COMPARE_TRIGGER:
	{
		command_set_vc_compare_trigger(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_START_GENERATION_TRIGGER:
	{
		command_set_vc_start_generation_trigger(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_END_GENERATION_TRIGGER:
	{
		command_set_vc_end_generation_trigger(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_CAPTURE_EDGE_TYPE:
	{
		command_set_vc_capture_edge_type(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_MAX_CYCLES:
	{
		command_set_vc_max_cycles(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS:
	{
		command_set_vc_max_number_of_capture_events(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS:
	{
		command_set_vc_max_number_of_valid_transactions(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_MAX_NUMBER_OF_MISMATCHES:
	{
		command_set_vc_max_number_of_mismatches(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_TIME_OUT:
	{
		command_set_vc_timeout(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_OUTPUT_FILENAME:
	{
		command_set_vc_output_filename(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_CPP_RD_NAME:
	{
		command_set_vc_cpp_rd_name(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_CPP_WR_NAME:
	{
		command_set_vc_cpp_wr_name(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VC_MAX_NUM_STATES:
	{
		command_set_vc_max_num_states(_t);
		_t = _retTree;
		break;
	}
	case ASSIGN:
	{
		command_assign(_t);
		_t = _retTree;
		break;
	}
	case K_SET_NAME:
	{
		command_set_name(_t);
		_t = _retTree;
		break;
	}
	case K_DO_NOT_GEN_RTL:
	{
		command_do_not_gen_rtl(_t);
		_t = _retTree;
		break;
	}
	case K_DO_NOT_GEN_CPP:
	{
		command_do_not_gen_cpp(_t);
		_t = _retTree;
		break;
	}
	case K_GEN_UNIQUE_RTL_MODULES:
	{
		command_gen_unique_rtl_modules(_t);
		_t = _retTree;
		break;
	}
	case K_SET_CLOCK:
	{
		command_set_clock(_t);
		_t = _retTree;
		break;
	}
	case K_REGISTER_IOS:
	{
		command_register_ios(_t);
		_t = _retTree;
		break;
	}
	case K_OVERRIDE_PARAMETER:
	{
		command_override_parameter(_t);
		_t = _retTree;
		break;
	}
	case K_AUTO_CONNECT_VERILOG_AND_CSL:
	{
		command_auto_connect_verilog_and_csl(_t);
		_t = _retTree;
		break;
	}
	case K_AUTO_CONNECT_WIDTH_INFERENCE:
	{
		command_auto_connect_width_inference(_t);
		_t = _retTree;
		break;
	}
	case K_SET_COMPARE_TRIGGER:
	{
		command_set_compare_trigger(_t);
		_t = _retTree;
		break;
	}
	case K_GENERATE_WAVES:
	{
		command_generate_waves(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DUT_MEM:
	{
		command_set_dut_mem(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DUT_MEM_INIT:
	{
		command_set_dut_mem_init(_t);
		_t = _retTree;
		break;
	}
	case K_SET_RESET_NAME:
	case K_SET_CLOCK_NAME:
	case K_SET_RD_CLOCK_NAME:
	case K_SET_WR_CLOCK_NAME:
	case K_SET_PUSH_NAME:
	case K_SET_POP_NAME:
	case K_SET_FULL_NAME:
	case K_SET_EMPTY_NAME:
	case K_SET_WR_DATA_NAME:
	case K_SET_RD_DATA_NAME:
	case K_SET_VALID_NAME:
	case K_SET_WR_ADDR_NAME:
	case K_SET_RD_ADDR_NAME:
	case K_SET_WR_EN_NAME:
	case K_SET_RD_EN_NAME:
	{
		command_set_port_name(_t);
		_t = _retTree;
		break;
	}
	case K_SET_WIDTH:
	{
		command_set_width(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DEPTH:
	{
		command_set_depth(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DIM_WIDTH:
	{
		command_set_dim_width(_t);
		_t = _retTree;
		break;
	}
	case K_SET_BITRANGE:
	{
		command_set_bitrange(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DIM_BITRANGE:
	{
		command_set_dim_bitrange(_t);
		_t = _retTree;
		break;
	}
	case K_SET_RANGE:
	{
		command_set_range(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DIM_RANGE:
	{
		command_set_dim_range(_t);
		_t = _retTree;
		break;
	}
	case K_SET_OFFSET:
	{
		command_set_offset(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DIM_OFFSET:
	{
		command_set_dim_offset(_t);
		_t = _retTree;
		break;
	}
	case K_SET_NUMBER_OF_DIMENSIONS:
	{
		command_set_number_of_dimensions(_t);
		_t = _retTree;
		break;
	}
	case K_SET_UNIT_PREFIX:
	{
		command_set_unit_prefix(_t);
		_t = _retTree;
		break;
	}
	case K_SET_SIGNAL_PREFIX:
	{
		command_set_signal_prefix(_t);
		_t = _retTree;
		break;
	}
	case K_SET_SIGNAL_PREFIX_LOCAL:
	{
		command_set_signal_prefix_local(_t);
		_t = _retTree;
		break;
	}
	case K_SET_VALUE:
	{
		command_set_value(_t);
		_t = _retTree;
		break;
	}
	case K_SET_ENUM:
	{
		command_set_enum(_t);
		_t = _retTree;
		break;
	}
	case K_SET_ENUM_ITEM:
	{
		command_set_enum_item(_t);
		_t = _retTree;
		break;
	}
	case K_SET_POSITION:
	{
		command_set_position(_t);
		_t = _retTree;
		break;
	}
	case K_SET_FIELD_POSITION:
	{
		command_set_field_position(_t);
		_t = _retTree;
		break;
	}
	case K_SET_NEXT:
	{
		command_set_next(_t);
		_t = _retTree;
		break;
	}
	case K_SET_PREVIOUS:
	{
		command_set_previous(_t);
		_t = _retTree;
		break;
	}
	case K_ADD_ALLOWED_RANGE:
	{
		command_add_allowed_range(_t);
		_t = _retTree;
		break;
	}
	case K_CREATE_RTL_MODULE:
	{
		command_create_rtl_module(_t);
		_t = _retTree;
		break;
	}
	case K_SET_CONST_VALUE:
	{
		command_set_const_value(_t);
		_t = _retTree;
		break;
	}
	case K_SET_FIELD:
	{
		command_set_field(_t);
		_t = _retTree;
		break;
	}
	case K_SET_EXTERNAL:
	{
		command_set_external(_t);
		_t = _retTree;
		break;
	}
	case K_MERGE:
	{
		command_merge(_t);
		_t = _retTree;
		break;
	}
	case K_INVERT:
	{
		command_invert(_t);
		_t = _retTree;
		break;
	}
	case K_BUFFER:
	{
		command_buffer(_t);
		_t = _retTree;
		break;
	}
	case K_REVERSE:
	{
		command_reverse(_t);
		_t = _retTree;
		break;
	}
	case K_CONNECT_BY_NAME:
	{
		command_connect_by_name(_t);
		_t = _retTree;
		break;
	}
	case K_CONNECT_BY_PATTERN:
	{
		command_connect_by_pattern(_t);
		_t = _retTree;
		break;
	}
	case K_CONNECT_UNITS:
	{
		command_connect_units(_t);
		_t = _retTree;
		break;
	}
	case K_SET_CELL:
	{
		command_set_cell(_t);
		_t = _retTree;
		break;
	}
	case K_INPUT_VERILOG_TYPE:
	{
		command_input_verilog_type(_t);
		_t = _retTree;
		break;
	}
	case K_OUTPUT_VERILOG_TYPE:
	{
		command_output_verilog_type(_t);
		_t = _retTree;
		break;
	}
	case K_AUTOROUTER:
	{
		command_autorouter(_t);
		_t = _retTree;
		break;
	}
	case K_GENERATE_INDIVIDUAL_RTL_SIGNALS:
	{
		command_generate_individual_rtl_signals(_t);
		_t = _retTree;
		break;
	}
	case K_GEN_DECODER:
	{
		command_generate_decoder(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DIMENSIONS:
	{
		command_set_dimensions(_t);
		_t = _retTree;
		break;
	}
	case K_SET_PHYSICAL_IMPLEMENTATION:
	{
		command_set_physical_implementation(_t);
		_t = _retTree;
		break;
	}
	case K_ADD_LOGIC:
	{
		command_add_logic(_t);
		_t = _retTree;
		break;
	}
	case K_DIRECTIVE:
	{
		command_directive(_t);
		_t = _retTree;
		break;
	}
	case K_AUTO_GEN_MEMORY_MAP:
	{
		command_auto_gen_memory_map(_t);
		_t = _retTree;
		break;
	}
	case K_SET_TOP_UNIT:
	{
		command_set_top_unit(_t);
		_t = _retTree;
		break;
	}
	case K_SET_ACCESS_RIGHTS:
	{
		command_set_access_rights(_t);
		_t = _retTree;
		break;
	}
	case K_SET_ACCESS_RIGHTS_ENUM:
	{
		command_set_access_rights_enum(_t);
		_t = _retTree;
		break;
	}
	case K_ADD_TO_MEMORY_MAP:
	{
		command_add_to_memory_map(_t);
		_t = _retTree;
		break;
	}
	case K_SET_MNEMONIC:
	{
		command_set_mnemonic(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DECODER_NAME:
	{
		command_set_decoder_name(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DECODER_OUT_NAME_PREFIX:
	{
		command_set_decoder_out_name_prefix(_t);
		_t = _retTree;
		break;
	}
	case K_SET_DECODER_OUT_NAME_SUFFIX:
	{
		command_set_decoder_out_name_suffix(_t);
		_t = _retTree;
		break;
	}
	case K_PRINT:
	{
		command_print(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void CslTreeWalker::csl_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6371 "csl.walker.g"
	
	NSCSLOm::RefCSLOmUnitDecl unitDecl;
	pair<RefString, int> id;
	RefCSLOmList list;
	
#line 871 "CslTreeWalker.cpp"
	
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_CSL_UNIT:
	{
		csl_unit_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_SIGNAL:
	{
		csl_signal_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_PORT:
	{
		csl_port_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_SIGNAL_GROUP:
	{
		csl_signal_group_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_BITRANGE:
	{
		csl_bitrange_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_MULTI_DIM_BITRANGE:
	{
		csl_multi_dim_bitrange_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_FIELD:
	{
		csl_field_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_DESIGN:
	{
		csl_design_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_INTERFACE:
	{
		csl_interface_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_LIST:
	{
		list=csl_list_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_ADDRESS_RANGE:
	{
		csl_address_range_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_REGISTER_FILE:
	{
		csl_register_file_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_REGISTER:
	{
		csl_register_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_MEMORY:
	{
		csl_memory_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_TESTBENCH:
	{
		csl_testbench_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_BOOL_EQUATION:
	{
		csl_bool_equation_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_EVENT:
	{
		csl_event_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_ENUM:
	{
		csl_enum_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_PARAMETER:
	{
		csl_parameter_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_STATE_DATA:
	{
		csl_state_data_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_VECTOR:
	{
		csl_vector_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_SIGNAL_PATTERN_GENERATOR:
	{
		csl_signal_pattern_generator_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_INCLUDE:
	{
		csl_include_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_FIFO:
	{
		csl_fifo_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_MEMORY_MAP:
	{
		csl_memory_map_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_MEMORY_MAP_PAGE:
	{
		csl_memory_map_page_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_ISA_FIELD:
	{
		csl_isa_field_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_ISA_ELEMENT:
	{
		csl_isa_element_declaration(_t);
		_t = _retTree;
		break;
	}
	case K_CSL_ISA:
	{
		csl_isa_declaration(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void CslTreeWalker::csl_function_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_function_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	csl_build_function_declaration(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::command_add_clock(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_clock_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2291 "csl.walker.g"
	
	pair <RefString,int> id;
	RefCSLOmExpr clock;
	
#line 1074 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t249 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ADD_CLOCK);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			clock=expression(_t);
			_t = _retTree;
		}
		else {
			goto _loop251;
		}
		
	}
	_loop251:;
	} // ( ... )*
	_t = __t249;
	_t = _t->getNextSibling();
#line 2300 "csl.walker.g"
	
	//to be implemeted in CSLOM
	
#line 1103 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_reset(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_reset_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2306 "csl.walker.g"
	
	pair <RefString,int> id;
	RefCSLOmExpr reset;
	
#line 1115 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t253 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ADD_RESET);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			reset=expression(_t);
			_t = _retTree;
		}
		else {
			goto _loop255;
		}
		
	}
	_loop255:;
	} // ( ... )*
	_t = __t253;
	_t = _t->getNextSibling();
#line 2315 "csl.walker.g"
	
	//to be implemeted in CSLOM
	
#line 1144 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_equation(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_equation_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2321 "csl.walker.g"
	
	pair <RefString,int> id;
	RefCSLOmExpr eq;
	
#line 1156 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t257 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ADD_EQUATION);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			eq=expression(_t);
			_t = _retTree;
		}
		else {
			goto _loop259;
		}
		
	}
	_loop259:;
	} // ( ... )*
	_t = __t257;
	_t = _t->getNextSibling();
#line 2330 "csl.walker.g"
	
	//to be implemeted in CSLOM
	
#line 1185 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_address_range(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_address_range_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2335 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr lowerExpr;
	RefCSLOmExpr upperExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1201 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t261 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ADD_ADDRESS_RANGE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2346 "csl.walker.g"
			
			hasIdentifier = true;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1224 "CslTreeWalker.cpp"
		}
		else {
			goto _loop263;
		}
		
	}
	_loop263:;
	} // ( ... )*
	lowerExpr=expression(_t);
	_t = _retTree;
#line 2357 "csl.walker.g"
	
	params->push_back(lowerExpr);
	
#line 1239 "CslTreeWalker.cpp"
	upperExpr=expression(_t);
	_t = _retTree;
#line 2361 "csl.walker.g"
	
	params->push_back(upperExpr);
	
#line 1246 "CslTreeWalker.cpp"
	_t = __t261;
	_t = _t->getNextSibling();
#line 2365 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_ADD_ADDRESS_RANGE, params);
	} else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_ADD_ADDRESS_RANGE, params);
	} 
	
#line 1257 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_address_increment(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_address_increment_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2374 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr incrExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1272 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t265 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_ADDRESS_INCREMENT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2384 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1295 "CslTreeWalker.cpp"
		}
		else {
			goto _loop267;
		}
		
	}
	_loop267:;
	} // ( ... )*
	incrExpr=expression(_t);
	_t = _retTree;
#line 2395 "csl.walker.g"
	
	params->push_back(incrExpr);
	
#line 1310 "CslTreeWalker.cpp"
	_t = __t265;
	_t = _t->getNextSibling();
#line 2399 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_ADDRESS_INCREMENT, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ADDRESS_INCREMENT, params);
	}
	
#line 1322 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_next_address(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_next_address_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2409 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr nextAddrExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1337 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t269 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_NEXT_ADDRESS);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2419 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1360 "CslTreeWalker.cpp"
		}
		else {
			goto _loop271;
		}
		
	}
	_loop271:;
	} // ( ... )*
	nextAddrExpr=expression(_t);
	_t = _retTree;
#line 2430 "csl.walker.g"
	
	params->push_back(nextAddrExpr);
	
#line 1375 "CslTreeWalker.cpp"
	_t = __t269;
	_t = _t->getNextSibling();
#line 2434 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_NEXT_ADDRESS, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_NEXT_ADDRESS, params);
	}
	
#line 1387 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_reserved_range(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_reserved_range_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2444 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr lowerAddrExpr;
	RefCSLOmExpr upperAddrExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1403 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t273 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ADD_RESERVED_ADDRESS_RANGE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2455 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1426 "CslTreeWalker.cpp"
		}
		else {
			goto _loop275;
		}
		
	}
	_loop275:;
	} // ( ... )*
	lowerAddrExpr=expression(_t);
	_t = _retTree;
#line 2466 "csl.walker.g"
	
	params->push_back(lowerAddrExpr);
	
#line 1441 "CslTreeWalker.cpp"
	upperAddrExpr=expression(_t);
	_t = _retTree;
#line 2470 "csl.walker.g"
	
	params->push_back(upperAddrExpr);
	
#line 1448 "CslTreeWalker.cpp"
	_t = __t273;
	_t = _t->getNextSibling();
#line 2474 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_ADD_RESERVED_RANGE, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_ADD_RESERVED_RANGE, params);
	}
	
#line 1460 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2484 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1475 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t277 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ADD);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2494 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1498 "CslTreeWalker.cpp"
		}
		else {
			goto _loop279;
		}
		
	}
	_loop279:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
#line 2505 "csl.walker.g"
			
			//DCERR("found expression -----------------------------------");
			params->push_back(expr);
			
#line 1519 "CslTreeWalker.cpp"
		}
		else {
			goto _loop281;
		}
		
	}
	_loop281:;
	} // ( ... )*
	_t = __t277;
	_t = _t->getNextSibling();
#line 2511 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_ADD, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_ADD, params);
	}
	
#line 1539 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_data_word_width(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_data_word_width_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2521 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr widthExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1554 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t283 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DATA_WORD_WIDTH);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2531 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1577 "CslTreeWalker.cpp"
		}
		else {
			goto _loop285;
		}
		
	}
	_loop285:;
	} // ( ... )*
	widthExpr=expression(_t);
	_t = _retTree;
#line 2542 "csl.walker.g"
	
	params->push_back(widthExpr);
	
#line 1592 "CslTreeWalker.cpp"
	_t = __t283;
	_t = _t->getNextSibling();
#line 2546 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_DATA_WORD_WIDTH, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_DATA_WORD_WIDTH, params);
	}
	
#line 1604 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_alignament(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_alignament_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2556 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr alignExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1619 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t287 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_ALIGNMENT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2566 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1642 "CslTreeWalker.cpp"
		}
		else {
			goto _loop289;
		}
		
	}
	_loop289:;
	} // ( ... )*
	alignExpr=expression(_t);
	_t = _retTree;
#line 2577 "csl.walker.g"
	
	params->push_back(alignExpr);
	
#line 1657 "CslTreeWalker.cpp"
	_t = __t287;
	_t = _t->getNextSibling();
#line 2581 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_ALIGNMENT, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ALIGNMENT, params);
	}
	
#line 1669 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_endianess(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_endianess_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2591 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr endianExpr;
	CSLOmMemoryMapPage::Endianess endianessType;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1685 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t291 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_ENDIANESS);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2602 "csl.walker.g"
			
			hasIdentifier = true;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1708 "CslTreeWalker.cpp"
		}
		else {
			goto _loop293;
		}
		
	}
	_loop293:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_BIG_ENDIAN:
	{
		antlr::RefCslAST tmp1_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_BIG_ENDIAN);
		_t = _t->getNextSibling();
#line 2612 "csl.walker.g"
		endianessType = CSLOmMemoryMapPage::ENDIAN_BIG;
#line 1728 "CslTreeWalker.cpp"
		break;
	}
	case K_LITTLE_ENDIAN:
	{
		antlr::RefCslAST tmp2_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_LITTLE_ENDIAN);
		_t = _t->getNextSibling();
#line 2613 "csl.walker.g"
		endianessType = CSLOmMemoryMapPage::ENDIAN_LITTLE;
#line 1738 "CslTreeWalker.cpp"
		break;
	}
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		endianExpr=expression(_t);
		_t = _retTree;
#line 2614 "csl.walker.g"
		params->push_back(endianExpr);
#line 1797 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t291;
	_t = _t->getNextSibling();
#line 2617 "csl.walker.g"
	
	CSLOmSetCommand::addEnumParam(endianessType, NSCSLOm::TYPE_CMD_SET_ENDIANESS);
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_ENDIANESS, params);
	} else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ENDIANESS, params);
	}
	
#line 1817 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_symbol_max_length(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_symbol_max_length_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2628 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr lengthExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1832 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t296 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_SYMBOL_MAX_LENGTH);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2638 "csl.walker.g"
			
			hasIdentifier = true;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1855 "CslTreeWalker.cpp"
		}
		else {
			goto _loop298;
		}
		
	}
	_loop298:;
	} // ( ... )*
	lengthExpr=expression(_t);
	_t = _retTree;
#line 2649 "csl.walker.g"
	
	params->push_back(lengthExpr);
	
#line 1870 "CslTreeWalker.cpp"
	_t = __t296;
	_t = _t->getNextSibling();
#line 2653 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_SYMBOL_MAX_LENGTH, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_SYMBOL_MAX_LENGTH, params);
	}
	
#line 1882 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_prefix(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_prefix_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2663 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr prefixExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1897 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t300 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_PREFIX);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2673 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1920 "CslTreeWalker.cpp"
		}
		else {
			goto _loop302;
		}
		
	}
	_loop302:;
	} // ( ... )*
	prefixExpr=expression(_t);
	_t = _retTree;
#line 2684 "csl.walker.g"
	
	ASSERT(prefixExpr.get(),"NULL prefix expr");
	params->push_back(prefixExpr);
	
#line 1936 "CslTreeWalker.cpp"
	_t = __t300;
	_t = _t->getNextSibling();
#line 2689 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_PREFIX, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_PREFIX, params);
	}
	
#line 1948 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_no_prefix(antlr::RefCslAST _t) {
	antlr::RefCslAST command_no_prefix_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2699 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 1962 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t304 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NO_PREFIX_COMMAND);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2708 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 1985 "CslTreeWalker.cpp"
		}
		else {
			goto _loop306;
		}
		
	}
	_loop306:;
	} // ( ... )*
#line 2718 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_NO_PREFIX, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_NO_PREFIX, params);
	}
	
#line 2003 "CslTreeWalker.cpp"
	_t = __t304;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_set_suffix(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_suffix_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2729 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr suffixExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 2020 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t308 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_SUFFIX);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2739 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 2043 "CslTreeWalker.cpp"
		}
		else {
			goto _loop310;
		}
		
	}
	_loop310:;
	} // ( ... )*
	suffixExpr=expression(_t);
	_t = _retTree;
#line 2750 "csl.walker.g"
	
	params->push_back(suffixExpr);
	
#line 2058 "CslTreeWalker.cpp"
	_t = __t308;
	_t = _t->getNextSibling();
#line 2754 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_SUFFIX, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_SUFFIX, params);
	}
	
#line 2070 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_type(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_type_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kw = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kr = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ktri = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ktriand = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ktrior = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ktri0 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ktri1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ktrireg = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kwand = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kwor = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ksupply0 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ksupply1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kinteger = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kreal = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST krealtime = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ktime = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kflat = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST khierar = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kvirtual1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kvirtual2 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kopcode = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST ksbopcode = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kselector = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kconstant = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST krfaddress = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kmemaddress = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kim = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kunused = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kreserved = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kbranchaddr = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kinstrfmt = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST kinstr = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST krootfmt = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2029 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	ECSLOmSignalType signalType = SIGNAL_UNDEFINED;
	EMemoryMapType mmType = MM_UNDEFINED;
	CSLOmIsaField::ECSLOmIsaFieldType isafType = CSLOmIsaField::ISA_FIELD_UNDEFINED;
	CSLOmIsaElement::EIsaElementType isaElemType = CSLOmIsaElement::ISA_ELEM_UNDEFINED;
	CSLOmRegDeclInfo::ERegDeclType regType = CSLOmRegDeclInfo::REG_DECL_UNDEF;
	RefCSLOmSetCommand command  = RefCSLOmSetCommand();
	TBool isMemMap = FALSE;
	TBool isIsaField = FALSE;
	TBool isIsaElem = FALSE;
	TBool isRegType = FALSE;
	
#line 2127 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t244 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_TYPE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2048 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 2149 "CslTreeWalker.cpp"
		}
		else {
			goto _loop246;
		}
		
	}
	_loop246:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_WIRE:
	{
		kw = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WIRE);
		_t = _t->getNextSibling();
#line 2057 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_WIRE;
#line 2169 "CslTreeWalker.cpp"
		break;
	}
	case K_REG:
	{
		kr = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
		_t = _t->getNextSibling();
#line 2058 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_REG;
#line 2179 "CslTreeWalker.cpp"
		break;
	}
	case K_TRI:
	{
		ktri = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI);
		_t = _t->getNextSibling();
#line 2059 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_TRI;
#line 2189 "CslTreeWalker.cpp"
		break;
	}
	case K_TRIAND:
	{
		ktriand = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIAND);
		_t = _t->getNextSibling();
#line 2060 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_TRIAND;
#line 2199 "CslTreeWalker.cpp"
		break;
	}
	case K_TRIOR:
	{
		ktrior = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIOR);
		_t = _t->getNextSibling();
#line 2061 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_TRIOR;
#line 2209 "CslTreeWalker.cpp"
		break;
	}
	case K_TRI0:
	{
		ktri0 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI0);
		_t = _t->getNextSibling();
#line 2062 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_TRI0;
#line 2219 "CslTreeWalker.cpp"
		break;
	}
	case K_TRI1:
	{
		ktri1 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI1);
		_t = _t->getNextSibling();
#line 2063 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_TRI1;
#line 2229 "CslTreeWalker.cpp"
		break;
	}
	case K_TRIREG:
	{
		ktrireg = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIREG);
		_t = _t->getNextSibling();
#line 2064 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_TRIREG;
#line 2239 "CslTreeWalker.cpp"
		break;
	}
	case K_WAND:
	{
		kwand = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WAND);
		_t = _t->getNextSibling();
#line 2065 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_WAND;
#line 2249 "CslTreeWalker.cpp"
		break;
	}
	case K_WOR:
	{
		kwor = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WOR);
		_t = _t->getNextSibling();
#line 2066 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_WOR;
#line 2259 "CslTreeWalker.cpp"
		break;
	}
	case K_SUPPLY0:
	{
		ksupply0 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY0);
		_t = _t->getNextSibling();
#line 2067 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_SUPPLY_0;
#line 2269 "CslTreeWalker.cpp"
		break;
	}
	case K_SUPPLY1:
	{
		ksupply1 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY1);
		_t = _t->getNextSibling();
#line 2068 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_SUPPLY_1;
#line 2279 "CslTreeWalker.cpp"
		break;
	}
	case K_INTEGER:
	{
		kinteger = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INTEGER);
		_t = _t->getNextSibling();
#line 2069 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_VAR_INTEGER;
#line 2289 "CslTreeWalker.cpp"
		break;
	}
	case K_REAL:
	{
		kreal = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REAL);
		_t = _t->getNextSibling();
#line 2070 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_VAR_REAL;
#line 2299 "CslTreeWalker.cpp"
		break;
	}
	case K_REALTIME:
	{
		krealtime = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REALTIME);
		_t = _t->getNextSibling();
#line 2071 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_VAR_REALTIME;
#line 2309 "CslTreeWalker.cpp"
		break;
	}
	case K_TIME:
	{
		ktime = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TIME);
		_t = _t->getNextSibling();
#line 2072 "csl.walker.g"
		signalType = NSCSLOm::SIGNAL_VAR_TIME;
#line 2319 "CslTreeWalker.cpp"
		break;
	}
	case K_FLAT:
	{
		kflat = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FLAT);
		_t = _t->getNextSibling();
#line 2078 "csl.walker.g"
		mmType = MM_FLAT;                                     isMemMap = TRUE;
#line 2329 "CslTreeWalker.cpp"
		break;
	}
	case K_HIERARCHICAL:
	{
		khierar = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_HIERARCHICAL);
		_t = _t->getNextSibling();
#line 2079 "csl.walker.g"
		mmType = MM_HIERARCHICAL;                             isMemMap = TRUE;
#line 2339 "CslTreeWalker.cpp"
		break;
	}
	case K_VIRTUAL_WITH_BASE_ADDRESS:
	{
		kvirtual1 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_VIRTUAL_WITH_BASE_ADDRESS);
		_t = _t->getNextSibling();
#line 2080 "csl.walker.g"
		mmType = MM_VIRTUAL_W_BASE_ADDR;                      isMemMap = TRUE;
#line 2349 "CslTreeWalker.cpp"
		break;
	}
	case K_VIRTUAL_WITH_PAGE_NUMBER:
	{
		kvirtual2 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_VIRTUAL_WITH_PAGE_NUMBER);
		_t = _t->getNextSibling();
#line 2081 "csl.walker.g"
		mmType = MM_VIRTUAL_W_PAGE_NO;                        isMemMap = TRUE;
#line 2359 "CslTreeWalker.cpp"
		break;
	}
	case K_OPCODE:
	{
		kopcode = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OPCODE);
		_t = _t->getNextSibling();
#line 2083 "csl.walker.g"
		isafType = CSLOmIsaField::ISA_FIELD_OPCODE;           isIsaField = TRUE;
#line 2369 "CslTreeWalker.cpp"
		break;
	}
	case K_SUBOPCODE:
	{
		ksbopcode = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUBOPCODE);
		_t = _t->getNextSibling();
#line 2084 "csl.walker.g"
		isafType = CSLOmIsaField::ISA_FIELD_SUBOPCODE;        isIsaField = TRUE;
#line 2379 "CslTreeWalker.cpp"
		break;
	}
	case K_SELECTOR:
	{
		kselector = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SELECTOR);
		_t = _t->getNextSibling();
#line 2086 "csl.walker.g"
		isafType = CSLOmIsaField::ISA_FIELD_SELECTOR;         isIsaField = TRUE;
#line 2389 "CslTreeWalker.cpp"
		break;
	}
	case K_CONSTANT:
	{
		kconstant = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CONSTANT);
		_t = _t->getNextSibling();
#line 2087 "csl.walker.g"
		isafType = CSLOmIsaField::ISA_FIELD_CONSTANT;         isIsaField = TRUE;
#line 2399 "CslTreeWalker.cpp"
		break;
	}
	case K_RF_ADDRESS:
	{
		krfaddress = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RF_ADDRESS);
		_t = _t->getNextSibling();
#line 2088 "csl.walker.g"
		isafType = CSLOmIsaField::ISA_FIELD_RF_ADDR;          isIsaField = TRUE;
#line 2409 "CslTreeWalker.cpp"
		break;
	}
	case K_MEM_ADDRESS:
	{
		kmemaddress = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_MEM_ADDRESS);
		_t = _t->getNextSibling();
#line 2089 "csl.walker.g"
		isafType = CSLOmIsaField::ISA_FIELD_MEM_ADDR;         isIsaField = TRUE;
#line 2419 "CslTreeWalker.cpp"
		break;
	}
	case K_IM:
	{
		kim = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_IM);
		_t = _t->getNextSibling();
#line 2090 "csl.walker.g"
		isafType = CSLOmIsaField::ISA_FIELD_IM;               isIsaField = TRUE;
#line 2429 "CslTreeWalker.cpp"
		break;
	}
	case K_UNUSED:
	{
		kunused = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_UNUSED);
		_t = _t->getNextSibling();
#line 2091 "csl.walker.g"
		isafType = CSLOmIsaField::ISA_FIELD_UNUSED;           isIsaField = TRUE;
#line 2439 "CslTreeWalker.cpp"
		break;
	}
	case K_RESERVED:
	{
		kreserved = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RESERVED);
		_t = _t->getNextSibling();
#line 2092 "csl.walker.g"
		isafType = CSLOmIsaField::ISA_FIELD_RESERVED;         isIsaField = TRUE;
#line 2449 "CslTreeWalker.cpp"
		break;
	}
	case K_BRANCH_ADDRESS:
	{
		kbranchaddr = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_BRANCH_ADDRESS);
		_t = _t->getNextSibling();
#line 2093 "csl.walker.g"
		isafType = CSLOmIsaField::ISA_FIELD_BRANCH_ADDRESS;   isIsaField = TRUE;
#line 2459 "CslTreeWalker.cpp"
		break;
	}
	case K_INSTR_FORMAT:
	{
		kinstrfmt = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INSTR_FORMAT);
		_t = _t->getNextSibling();
#line 2096 "csl.walker.g"
		isaElemType = CSLOmIsaElement::ISA_ELEM_FORMAT; isIsaElem = TRUE;
#line 2469 "CslTreeWalker.cpp"
		break;
	}
	case K_INSTR:
	{
		kinstr = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INSTR);
		_t = _t->getNextSibling();
#line 2097 "csl.walker.g"
		isaElemType = CSLOmIsaElement::ISA_ELEM_INSTR ; isIsaElem = TRUE;
#line 2479 "CslTreeWalker.cpp"
		break;
	}
	case K_ROOT_FORMAT:
	{
		krootfmt = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ROOT_FORMAT);
		_t = _t->getNextSibling();
#line 2098 "csl.walker.g"
		isaElemType = CSLOmIsaElement::ISA_ELEM_ROOT  ; isIsaElem = TRUE;
#line 2489 "CslTreeWalker.cpp"
		break;
	}
	case K_COUNTER:
	{
		antlr::RefCslAST tmp3_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_COUNTER);
		_t = _t->getNextSibling();
#line 2100 "csl.walker.g"
		regType = CSLOmRegDeclInfo::REG_DECL_COUNTER ;  isRegType = TRUE;
#line 2499 "CslTreeWalker.cpp"
		break;
	}
	case K_REGISTER:
	{
		antlr::RefCslAST tmp4_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REGISTER);
		_t = _t->getNextSibling();
#line 2101 "csl.walker.g"
		regType = CSLOmRegDeclInfo::REG_DECL_REGISTER;  isRegType = TRUE;
#line 2509 "CslTreeWalker.cpp"
		break;
	}
	case K_COMBINATIONAL:
	{
		antlr::RefCslAST tmp5_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_COMBINATIONAL);
		_t = _t->getNextSibling();
#line 2103 "csl.walker.g"
		DCERR("[ WARNING ] Walker: If you can read this, it means that this type: COMBINATIONAL, passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
#line 2519 "CslTreeWalker.cpp"
		break;
	}
	case K_SEQUENTIAL:
	{
		antlr::RefCslAST tmp6_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SEQUENTIAL);
		_t = _t->getNextSibling();
#line 2104 "csl.walker.g"
		DCERR("[ WARNING ] Walker: If you can read this, it means that this type: SEQUENTIAL, passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
#line 2529 "CslTreeWalker.cpp"
		break;
	}
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr=expression(_t);
		_t = _retTree;
#line 2120 "csl.walker.g"
		
		// RefCSLOmExprLink exprLink = CSLOmExprLink::cast(expr);
		// if(*((exprLink->getName()).get())      == "flat"                     ) {
		//   mmType = MM_FLAT;
		//   isMemMap = TRUE;
		// } 
		// else if(*((exprLink->getName()).get()) == "hierarchical"             ) {
		//   mmType = MM_HIERARCHICAL;
		//   isMemMap = TRUE;
		// }
		// else if(*((exprLink->getName()).get()) == "virtual_with_base_address") {
		//   mmType = MM_VIRTUAL_W_BASE_ADDR;
		//   isMemMap = TRUE;
		// }
		// else if(*((exprLink->getName()).get()) == "virtual_with_page_number" ) {
		//   mmType = MM_VIRTUAL_W_PAGE_NO;
		//   isMemMap = TRUE;
		// }
		// else {
		params->push_back(expr);
		// }
		
#line 2609 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t244;
	_t = _t->getNextSibling();
#line 2149 "csl.walker.g"
	
	if(isMemMap) {
	CSLOmSetCommand::addEnumParam(mmType, NSCSLOm::TYPE_CMD_SET_TYPE);
	}
	else if(isIsaField){
	CSLOmSetCommand::addEnumParam(isafType, NSCSLOm::TYPE_CMD_SET_TYPE);
	}
	else if(isRegType){
	CSLOmSetCommand::addEnumParam(regType, NSCSLOm::TYPE_CMD_SET_TYPE);
	}
	else if(isIsaElem){
	CSLOmSetCommand::addEnumParam(isaElemType, NSCSLOm::TYPE_CMD_SET_TYPE);
	}
	else {
	CSLOmSetCommand::addEnumParam(signalType, NSCSLOm::TYPE_CMD_SET_TYPE);
	}
	
	//std::cerr << "after addEnumParam" << std::endl;
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_TYPE, params);
	//std::cerr << "after build command" << std::endl;
	
#line 2642 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_attr(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_attr_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5095 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );  
	ECSLOmSignalAttr signalAttribute;
	RefCSLOmSetCommand command = RefCSLOmSetCommand();
	
#line 2658 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t655 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_ATTR);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5106 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 2680 "CslTreeWalker.cpp"
		}
		else {
			goto _loop657;
		}
		
	}
	_loop657:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_ENABLE:
	{
		antlr::RefCslAST tmp7_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ENABLE);
		_t = _t->getNextSibling();
#line 5115 "csl.walker.g"
		signalAttribute = ATTR_EN;
#line 2700 "CslTreeWalker.cpp"
		break;
	}
	case K_STALL:
	{
		antlr::RefCslAST tmp8_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_STALL);
		_t = _t->getNextSibling();
#line 5116 "csl.walker.g"
		signalAttribute = ATTR_STALL;
#line 2710 "CslTreeWalker.cpp"
		break;
	}
	case K_PIPE_ENABLE:
	{
		antlr::RefCslAST tmp9_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PIPE_ENABLE);
		_t = _t->getNextSibling();
#line 5117 "csl.walker.g"
		signalAttribute = ATTR_PE;
#line 2720 "CslTreeWalker.cpp"
		break;
	}
	case K_PIPE_STALL:
	{
		antlr::RefCslAST tmp10_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PIPE_STALL);
		_t = _t->getNextSibling();
#line 5118 "csl.walker.g"
		signalAttribute = ATTR_PS;
#line 2730 "CslTreeWalker.cpp"
		break;
	}
	case K_MUX_SELECT:
	{
		antlr::RefCslAST tmp11_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_MUX_SELECT);
		_t = _t->getNextSibling();
#line 5119 "csl.walker.g"
		signalAttribute = ATTR_MS;
#line 2740 "CslTreeWalker.cpp"
		break;
	}
	case K_DECODE:
	{
		antlr::RefCslAST tmp12_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DECODE);
		_t = _t->getNextSibling();
#line 5120 "csl.walker.g"
		signalAttribute = ATTR_DEC;
#line 2750 "CslTreeWalker.cpp"
		break;
	}
	case K_CLOCK_SIGNAL:
	{
		antlr::RefCslAST tmp13_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CLOCK_SIGNAL);
		_t = _t->getNextSibling();
#line 5121 "csl.walker.g"
		signalAttribute = ATTR_CLK;
#line 2760 "CslTreeWalker.cpp"
		break;
	}
	case K_RESET_SIGNAL:
	{
		antlr::RefCslAST tmp14_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RESET_SIGNAL);
		_t = _t->getNextSibling();
#line 5122 "csl.walker.g"
		signalAttribute = ATTR_RST;
#line 2770 "CslTreeWalker.cpp"
		break;
	}
	case K_WRITE_ENABLE:
	{
		antlr::RefCslAST tmp15_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WRITE_ENABLE);
		_t = _t->getNextSibling();
#line 5123 "csl.walker.g"
		signalAttribute = ATTR_WR_EN;
#line 2780 "CslTreeWalker.cpp"
		break;
	}
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr=expression(_t);
		_t = _retTree;
#line 5124 "csl.walker.g"
		params->push_back(expr);
#line 2839 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t655;
	_t = _t->getNextSibling();
#line 5127 "csl.walker.g"
	
	CSLOmSetCommand::addEnumParam(signalAttribute, NSCSLOm::TYPE_CMD_SET_ATTR);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_ATTR, params);
	
#line 2855 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_attributes(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_attributes_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5133 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );  
	RefCSLOmSetCommand command = RefCSLOmSetCommand();
	
#line 2870 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t660 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_ATTRIBUTES);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5143 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 2892 "CslTreeWalker.cpp"
		}
		else {
			goto _loop662;
		}
		
	}
	_loop662:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SHADOW:
	{
		antlr::RefCslAST tmp16_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SHADOW);
		_t = _t->getNextSibling();
		break;
	}
	case K_READ:
	{
		antlr::RefCslAST tmp17_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_READ);
		_t = _t->getNextSibling();
		break;
	}
	case K_WRITE:
	{
		antlr::RefCslAST tmp18_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WRITE);
		_t = _t->getNextSibling();
		break;
	}
	case K_READ_WRITE:
	{
		antlr::RefCslAST tmp19_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_READ_WRITE);
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t660;
	_t = _t->getNextSibling();
#line 5161 "csl.walker.g"
	
	DCERR("[ WARNING ] Walker: If you can read this, it means that this command: set_attributes(csl_list(attributes)), passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
	
#line 2945 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_transaction_timeout_counter(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_transaction_timeout_counter_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5167 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 2959 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t665 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRANSACTION_TIMEOUT_COUNTER);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5176 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 2981 "CslTreeWalker.cpp"
		}
		else {
			goto _loop667;
		}
		
	}
	_loop667:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
		}
		else {
			goto _loop669;
		}
		
	}
	_loop669:;
	} // ( ... )*
	_t = __t665;
	_t = _t->getNextSibling();
#line 5189 "csl.walker.g"
	
	//to be added in cslom
	
#line 3011 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_simulation_timeout_counter(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_simulation_timeout_counter_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5195 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3025 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t671 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIMULATION_TIMEOUT_COUNTER);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5204 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 3047 "CslTreeWalker.cpp"
		}
		else {
			goto _loop673;
		}
		
	}
	_loop673:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
	_t = __t671;
	_t = _t->getNextSibling();
#line 5215 "csl.walker.g"
	
	//to be added in cslom
	
#line 3064 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_arch_state(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_arch_state_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2871 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmExpr expr;
	
#line 3077 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t324 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ADD_ARCH_STATE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2879 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 3099 "CslTreeWalker.cpp"
		}
		else {
			goto _loop326;
		}
		
	}
	_loop326:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
	_t = __t324;
	_t = _t->getNextSibling();
#line 2890 "csl.walker.g"
	
	//to be implemented in CSLOM
	
#line 3116 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_instance_name(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_instance_name_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3154 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3131 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t390 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_MEM_INSTANCE_NAME);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3163 "csl.walker.g"
			
			if(scope.get()) {
			scope->addHidItem(id.first);
			}
			else {
			scope = CSLOmExprLink::build(id.second, _RS(tok->getFilename()),id.first);
			}
			
#line 3153 "CslTreeWalker.cpp"
		}
		else {
			goto _loop392;
		}
		
	}
	_loop392:;
	} // ( ... )*
	{
	tok1 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	expr=expression(_t);
	_t = _retTree;
#line 3174 "csl.walker.g"
	
	params->push_back(expr);
	CSLOmSetCommand::build(tok1->getLine(), _RS(tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_INSTANCE_NAME, params);
	
#line 3171 "CslTreeWalker.cpp"
	}
	_t = __t390;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_set_unit_name(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_unit_name_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3182 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3189 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t395 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_UNIT_NAME);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3191 "csl.walker.g"
			
			if(scope.get()) {
			scope->addHidItem(id.first);
			}
			else {
			scope = CSLOmExprLink::build(id.second, _RS(tok->getFilename()),id.first);
			}
			
#line 3211 "CslTreeWalker.cpp"
		}
		else {
			goto _loop397;
		}
		
	}
	_loop397:;
	} // ( ... )*
	{
	tok1 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	expr=expression(_t);
	_t = _retTree;
#line 3202 "csl.walker.g"
	
	params->push_back(expr);
	CSLOmSetCommand::build(tok1->getLine(), _RS(tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_MODULE_NAME, params);
	
#line 3229 "CslTreeWalker.cpp"
	}
	_t = __t395;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_set_direction(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_direction_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3210 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	ECSLOmPortDirection mPortDirection =  NSCSLOm::DIR_UNDEFINED;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3246 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t400 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DIRECTION);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3219 "csl.walker.g"
			
			if(scope.get()) {
			scope->addHidItem(id.first);
			}
			else {
			scope = CSLOmExprLink::build(id.second, _RS(tok->getFilename()),id.first);
			}
			
#line 3268 "CslTreeWalker.cpp"
		}
		else {
			goto _loop402;
		}
		
	}
	_loop402:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_OUTPUT:
	{
		antlr::RefCslAST tmp20_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OUTPUT);
		_t = _t->getNextSibling();
#line 3229 "csl.walker.g"
		mPortDirection = OUTPUT;
#line 3288 "CslTreeWalker.cpp"
		break;
	}
	case K_INPUT:
	{
		antlr::RefCslAST tmp21_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INPUT);
		_t = _t->getNextSibling();
#line 3230 "csl.walker.g"
		mPortDirection = INPUT;
#line 3298 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t400;
	_t = _t->getNextSibling();
#line 3233 "csl.walker.g"
	
	CSLOmCmdVSDSetDirection::setDirectionParam(mPortDirection);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_DIRECTION, params);
	
#line 3314 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_exclusion_list(antlr::RefCslAST _t) {
	antlr::RefCslAST command_exclusion_list_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3239 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3329 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t405 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_EXCLUSION_LIST);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3248 "csl.walker.g"
			
			if(scope.get()) {
			scope->addHidItem(id.first);
			}
			else {
			scope = CSLOmExprLink::build(id.second, _RS(tok->getFilename()), id.first);
			}
			
#line 3351 "CslTreeWalker.cpp"
		}
		else {
			goto _loop407;
		}
		
	}
	_loop407:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			tok1 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			expr=expression(_t);
			_t = _retTree;
#line 3259 "csl.walker.g"
			
			params->push_back(expr);
			
#line 3372 "CslTreeWalker.cpp"
		}
		else {
			goto _loop409;
		}
		
	}
	_loop409:;
	} // ( ... )*
#line 3263 "csl.walker.g"
	
	CSLOmSetCommand::build(tok1->getLine(), _RS(tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_EXCLUDE_ONLY, params);
	
#line 3385 "CslTreeWalker.cpp"
	_t = __t405;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_include_only(antlr::RefCslAST _t) {
	antlr::RefCslAST command_include_only_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3269 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3402 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t411 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INCLUDE_ONLY);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3278 "csl.walker.g"
			
			if(scope.get()) {
			scope->addHidItem(id.first);
			}
			else {
			scope = CSLOmExprLink::build(id.second, _RS(tok->getFilename()), id.first);
			}
			
#line 3424 "CslTreeWalker.cpp"
		}
		else {
			goto _loop413;
		}
		
	}
	_loop413:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			tok1 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			expr=expression(_t);
			_t = _retTree;
#line 3289 "csl.walker.g"
			
			params->push_back(expr);
			
#line 3445 "CslTreeWalker.cpp"
		}
		else {
			goto _loop415;
		}
		
	}
	_loop415:;
	} // ( ... )*
#line 3293 "csl.walker.g"
	
	CSLOmSetCommand::build(tok1->getLine(), _RS(tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_INCLUDE_ONLY, params);
	
#line 3458 "CslTreeWalker.cpp"
	_t = __t411;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_id(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_id_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3299 "csl.walker.g"
	
	pair<RefString,int> id;
	RefCSLOmExpr expr;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3474 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t417 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_ID);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3308 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 3495 "CslTreeWalker.cpp"
		}
		else {
			goto _loop419;
		}
		
	}
	_loop419:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3317 "csl.walker.g"
	
	params->push_back(expr);
	
#line 3510 "CslTreeWalker.cpp"
	_t = __t417;
	_t = _t->getNextSibling();
#line 3321 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_NUMERIC_ID, params);
	
#line 3517 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_name(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_name_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3326 "csl.walker.g"
	
	pair<RefString,int> id;
	RefCSLOmExpr expr;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3531 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t421 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_NAME);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3335 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 3552 "CslTreeWalker.cpp"
		}
		else {
			goto _loop423;
		}
		
	}
	_loop423:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3344 "csl.walker.g"
	
	params->push_back(expr);
	
#line 3567 "CslTreeWalker.cpp"
	_t = __t421;
	_t = _t->getNextSibling();
#line 3348 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_NAME, params);
	
#line 3574 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_header_comment(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_header_comment_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3353 "csl.walker.g"
	
	pair<RefString,int> id;
	RefCSLOmExpr expr;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3588 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t425 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_HEADER_COMMENT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3362 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 3609 "CslTreeWalker.cpp"
		}
		else {
			goto _loop427;
		}
		
	}
	_loop427:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3371 "csl.walker.g"
	
	params->push_back(expr);
	
#line 3624 "CslTreeWalker.cpp"
	_t = __t425;
	_t = _t->getNextSibling();
#line 3375 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_HEADER_COMMENT, params);
	
#line 3631 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_version(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_version_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3380 "csl.walker.g"
	
	pair<RefString,int> id;
	RefCSLOmExpr expr;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3645 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t429 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VERSION);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3389 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 3666 "CslTreeWalker.cpp"
		}
		else {
			goto _loop431;
		}
		
	}
	_loop431:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3398 "csl.walker.g"
	
	params->push_back(expr);
	
#line 3681 "CslTreeWalker.cpp"
	_t = __t429;
	_t = _t->getNextSibling();
#line 3402 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_VERSION, params);
	
#line 3688 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_radix(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_radix_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3407 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	CSLOmVerifCompInfo::ECSLOmVCRadix mRadixType = NSCSLOm::CSLOmVerifCompInfo::VC_RADIX_UNDEFINED;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3703 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t433 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_RADIX);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3417 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 3724 "CslTreeWalker.cpp"
		}
		else {
			goto _loop435;
		}
		
	}
	_loop435:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_BIN:
	{
		antlr::RefCslAST tmp22_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_BIN);
		_t = _t->getNextSibling();
#line 3426 "csl.walker.g"
		mRadixType = NSCSLOm::CSLOmVerifCompInfo::VC_RADIX_BIN;
#line 3744 "CslTreeWalker.cpp"
		break;
	}
	case K_HEX:
	{
		antlr::RefCslAST tmp23_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_HEX);
		_t = _t->getNextSibling();
#line 3427 "csl.walker.g"
		mRadixType = NSCSLOm::CSLOmVerifCompInfo::VC_RADIX_HEX;
#line 3754 "CslTreeWalker.cpp"
		break;
	}
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr=expression(_t);
		_t = _retTree;
#line 3429 "csl.walker.g"
		params->push_back(expr);
#line 3813 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t433;
	_t = _t->getNextSibling();
#line 3433 "csl.walker.g"
	
	CSLOmCmdVSDSetRadix::setRadixTypeParam(mRadixType);
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_RADIX, params);
	
#line 3829 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_clock(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_clock_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3439 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3843 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t438 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_CLOCK);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3448 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 3864 "CslTreeWalker.cpp"
		}
		else {
			goto _loop440;
		}
		
	}
	_loop440:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3457 "csl.walker.g"
	
	params->push_back(expr);
	
#line 3879 "CslTreeWalker.cpp"
	_t = __t438;
	_t = _t->getNextSibling();
#line 3461 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_CLOCK, params);
	
#line 3886 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_reset(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_reset_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3466 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3900 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t442 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_RESET);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3475 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 3921 "CslTreeWalker.cpp"
		}
		else {
			goto _loop444;
		}
		
	}
	_loop444:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3484 "csl.walker.g"
	
	params->push_back(expr);
	
#line 3936 "CslTreeWalker.cpp"
	_t = __t442;
	_t = _t->getNextSibling();
#line 3488 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_RESET, params);
	
#line 3943 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_stall(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_stall_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3493 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 3957 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t446 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_STALL);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3502 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 3978 "CslTreeWalker.cpp"
		}
		else {
			goto _loop448;
		}
		
	}
	_loop448:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3511 "csl.walker.g"
	
	params->push_back(expr);
	
#line 3993 "CslTreeWalker.cpp"
	_t = __t446;
	_t = _t->getNextSibling();
#line 3515 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_STALL, params);
	
#line 4000 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_compare_trigger(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_compare_trigger_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3520 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4014 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t450 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_COMPARE_TRIGGER);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3529 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4035 "CslTreeWalker.cpp"
		}
		else {
			goto _loop452;
		}
		
	}
	_loop452:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3538 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4050 "CslTreeWalker.cpp"
	_t = __t450;
	_t = _t->getNextSibling();
#line 3542 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_COMPARE_TRIGGER, params);
	
#line 4057 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_start_generation_trigger(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_start_generation_trigger_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3547 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4071 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t454 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_START_GENERATION_TRIGGER);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3556 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4092 "CslTreeWalker.cpp"
		}
		else {
			goto _loop456;
		}
		
	}
	_loop456:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3565 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4107 "CslTreeWalker.cpp"
	_t = __t454;
	_t = _t->getNextSibling();
#line 3569 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_START_GENERATION_TRIGGER, params);
	
#line 4114 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_end_generation_trigger(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_end_generation_trigger_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3574 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4128 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t458 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_END_GENERATION_TRIGGER);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3583 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4149 "CslTreeWalker.cpp"
		}
		else {
			goto _loop460;
		}
		
	}
	_loop460:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3592 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4164 "CslTreeWalker.cpp"
	_t = __t458;
	_t = _t->getNextSibling();
#line 3596 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_END_GENERATION_TRIGGER, params);
	
#line 4171 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_capture_edge_type(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_capture_edge_type_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3601 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	CSLOmVerifCompInfo::ECSLOmVCEdgeType mEdgeType = NSCSLOm::CSLOmVerifCompInfo::VC_EDGE_UNDEFINED;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4185 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t462 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_CAPTURE_EDGE_TYPE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3610 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4206 "CslTreeWalker.cpp"
		}
		else {
			goto _loop464;
		}
		
	}
	_loop464:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_RISE:
	{
		antlr::RefCslAST tmp24_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RISE);
		_t = _t->getNextSibling();
#line 3619 "csl.walker.g"
		mEdgeType = NSCSLOm::CSLOmVerifCompInfo::VC_EDGE_RISE;
#line 4226 "CslTreeWalker.cpp"
		break;
	}
	case K_FALL:
	{
		antlr::RefCslAST tmp25_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FALL);
		_t = _t->getNextSibling();
#line 3620 "csl.walker.g"
		mEdgeType = NSCSLOm::CSLOmVerifCompInfo::VC_EDGE_FALL;
#line 4236 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t462;
	_t = _t->getNextSibling();
#line 3623 "csl.walker.g"
	
	CSLOmCmdVSDSetCaptureEdgeType::setEdgeTypeParam(mEdgeType);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_CAPTURE_EDGE_TYPE, params);
	
#line 4252 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_max_cycles(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_max_cycles_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3629 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4266 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t467 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_MAX_CYCLES);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3638 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4287 "CslTreeWalker.cpp"
		}
		else {
			goto _loop469;
		}
		
	}
	_loop469:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3647 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4302 "CslTreeWalker.cpp"
	_t = __t467;
	_t = _t->getNextSibling();
#line 3651 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_MAX_CYCLES, params);
	
#line 4309 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_max_number_of_capture_events(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_max_number_of_capture_events_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3656 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4323 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t471 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3665 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4344 "CslTreeWalker.cpp"
		}
		else {
			goto _loop473;
		}
		
	}
	_loop473:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3674 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4359 "CslTreeWalker.cpp"
	_t = __t471;
	_t = _t->getNextSibling();
#line 3678 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_MAX_EVENTS_COUNT, params);
	
#line 4366 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_max_number_of_valid_transactions(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_max_number_of_valid_transactions_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3683 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4380 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t475 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3692 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4401 "CslTreeWalker.cpp"
		}
		else {
			goto _loop477;
		}
		
	}
	_loop477:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3701 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4416 "CslTreeWalker.cpp"
	_t = __t475;
	_t = _t->getNextSibling();
#line 3705 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_NUM_OF_TRANSACTION, params);
	
#line 4423 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_max_number_of_mismatches(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_max_number_of_mismatches_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3710 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4437 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t479 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_MAX_NUMBER_OF_MISMATCHES);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3719 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4458 "CslTreeWalker.cpp"
		}
		else {
			goto _loop481;
		}
		
	}
	_loop481:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3728 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4473 "CslTreeWalker.cpp"
	_t = __t479;
	_t = _t->getNextSibling();
#line 3732 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_MAX_MISMATCHES_COUNT, params);
	
#line 4480 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_timeout(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_timeout_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3737 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4494 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t483 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_TIME_OUT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3746 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4515 "CslTreeWalker.cpp"
		}
		else {
			goto _loop485;
		}
		
	}
	_loop485:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3755 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4530 "CslTreeWalker.cpp"
	_t = __t483;
	_t = _t->getNextSibling();
#line 3759 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_TIMEOUT, params);
	
#line 4537 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_output_filename(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_output_filename_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3764 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4551 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t487 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_OUTPUT_FILENAME);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3773 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4572 "CslTreeWalker.cpp"
		}
		else {
			goto _loop489;
		}
		
	}
	_loop489:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3782 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4587 "CslTreeWalker.cpp"
	_t = __t487;
	_t = _t->getNextSibling();
#line 3786 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_OUTPUT_FILENAME, params);
	
#line 4594 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_cpp_rd_name(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_cpp_rd_name_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3791 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4608 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t491 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_CPP_RD_NAME);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3800 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4629 "CslTreeWalker.cpp"
		}
		else {
			goto _loop493;
		}
		
	}
	_loop493:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3809 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4644 "CslTreeWalker.cpp"
	_t = __t491;
	_t = _t->getNextSibling();
#line 3813 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_CPP_RD_NAME, params);
	
#line 4651 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_cpp_wr_name(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_cpp_wr_name_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3818 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4665 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t495 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_CPP_WR_NAME);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3827 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4686 "CslTreeWalker.cpp"
		}
		else {
			goto _loop497;
		}
		
	}
	_loop497:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3836 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4701 "CslTreeWalker.cpp"
	_t = __t495;
	_t = _t->getNextSibling();
#line 3840 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_CPP_WR_NAME, params);
	
#line 4708 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_vc_max_num_states(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_vc_max_num_states_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3846 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 4722 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t499 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VC_MAX_NUM_STATES);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3855 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 4743 "CslTreeWalker.cpp"
		}
		else {
			goto _loop501;
		}
		
	}
	_loop501:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3864 "csl.walker.g"
	
	params->push_back(expr);
	
#line 4758 "CslTreeWalker.cpp"
	_t = __t499;
	_t = _t->getNextSibling();
#line 3868 "csl.walker.g"
	
	CSLOmSetCommand::build(id.second, _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_MAX_NUM_STATES, params);
	
#line 4765 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_assign(antlr::RefCslAST _t) {
	antlr::RefCslAST command_assign_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokrange = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3873 "csl.walker.g"
	
	pair<RefString, int> id;
	TBool hasRangeExpr = FALSE;
	RefCSLOmExpr range_expr1, range_expr2;
	TBool hasSecondExpr = FALSE;
	RefCSLOmSimpleBitRange br = RefCSLOmSimpleBitRange();
	RefCSLOmExpr expr1, expr2;
	TBool hasId = FALSE;
	TBool negDirPartSel = FALSE;
	
#line 4784 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t503 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ASSIGN);
	_t = _t->getFirstChild();
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	{
		{ // ( ... )+
		int _cnt506=0;
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 3888 "csl.walker.g"
				
				//creating expr1 of the assign as CSLOmExprLink 
				if(!expr1.get()){
				expr1 = CSLOmExprLink::build(id.second, _RS(tok->getFilename()),id.first);
				}
				else{
				(CSLOmExprLink::cast(expr1))->addHidItem(id.first);
				}
				
#line 4814 "CslTreeWalker.cpp"
			}
			else {
				if ( _cnt506>=1 ) { goto _loop506; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt506++;
		}
		_loop506:;
		}  // ( ... )+
		{
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case RANGE_EXPRESSION:
		{
			antlr::RefCslAST __t508 = _t;
			tokrange = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),RANGE_EXPRESSION);
			_t = _t->getFirstChild();
#line 3900 "csl.walker.g"
			hasRangeExpr = TRUE;
#line 4836 "CslTreeWalker.cpp"
			range_expr1=expression(_t);
			_t = _retTree;
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case COLON:
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case PO_NEG:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case COLON:
				{
					antlr::RefCslAST tmp26_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COLON);
					_t = _t->getNextSibling();
					break;
				}
				case PO_NEG:
				{
					antlr::RefCslAST tmp27_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PO_NEG);
					_t = _t->getNextSibling();
#line 3902 "csl.walker.g"
					negDirPartSel = TRUE;
#line 4915 "CslTreeWalker.cpp"
					break;
				}
				case MINUS:
				case QUESTION:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case EXPRESSION:
				case RANGE_EXPRESSION:
				case MINTYPMAX_EXPRESSION:
				case EXPR_PRIMARY_IDENTIFIER:
				case U_PLUS:
				case U_MINUS:
				case U_AND:
				case U_NAND:
				case U_OR:
				case U_NOR:
				case U_XOR:
				case U_XNOR:
				case FUNCTION_CALL_RET_ID:
				case FUNCTION_CALL_RET_EXPR:
				case EXPR_HYBRID:
				case SIZED_NUMBER:
				case K_CONCATENATION:
				case K_REPLICATION:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				range_expr2=expression(_t);
				_t = _retTree;
#line 3903 "csl.walker.g"
				hasSecondExpr = TRUE;
#line 4982 "CslTreeWalker.cpp"
				break;
			}
			case 3:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			_t = __t508;
			_t = _t->getNextSibling();
			break;
		}
		case ASSIGNOR:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 3908 "csl.walker.g"
		
		if (hasRangeExpr) {
		if(!hasSecondExpr){
		br = CSLOmSimpleBitRange::build(id.second, _RS(tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr1);
		}
		else{
		br = CSLOmSimpleBitRange::build(id.second, _RS(tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr2);
		}
		CSLOmExprLink::cast(expr1)->setBitRange(br);
		if (negDirPartSel) { CSLOmExprLink::cast(expr1)->setPartSelectDir(CSLOmExprLink::PS_DIR_DESC); }
		}
		
#line 5022 "CslTreeWalker.cpp"
		break;
	}
	case K_TO_USE_FOR_NONDETERMINISM_IN_WALKER:
	{
		{
		antlr::RefCslAST __t512 = _t;
		antlr::RefCslAST tmp28_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TO_USE_FOR_NONDETERMINISM_IN_WALKER);
		_t = _t->getFirstChild();
		expr1=expression(_t);
		_t = _retTree;
		_t = __t512;
		_t = _t->getNextSibling();
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	antlr::RefCslAST tmp29_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ASSIGNOR);
	_t = _t->getNextSibling();
	{
	expr2=expression(_t);
	_t = _retTree;
	}
	}
	_t = __t503;
	_t = _t->getNextSibling();
#line 3935 "csl.walker.g"
	
	RefCSLOmStmtAssign stmtAssn = CSLOmStmtAssign::build(expr1->getLineNumber(), _RS(tok->getFilename()), design, expr1, expr2);
	
#line 5060 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_name(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_name_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3940 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 5074 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t516 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_NAME);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3949 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 5095 "CslTreeWalker.cpp"
		}
		else {
			goto _loop518;
		}
		
	}
	_loop518:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 3958 "csl.walker.g"
	
	params->push_back(expr);
	
#line 5110 "CslTreeWalker.cpp"
	_t = __t516;
	_t = _t->getNextSibling();
#line 3962 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_NAME, params);
	
#line 5117 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_do_not_gen_rtl(antlr::RefCslAST _t) {
	antlr::RefCslAST command_do_not_gen_rtl_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3967 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 5130 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t520 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DO_NOT_GEN_RTL);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3975 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 5151 "CslTreeWalker.cpp"
		}
		else {
			goto _loop522;
		}
		
	}
	_loop522:;
	} // ( ... )*
	_t = __t520;
	_t = _t->getNextSibling();
#line 3984 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_NO_GEN_RTL, params);
	
#line 5166 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_do_not_gen_cpp(antlr::RefCslAST _t) {
	antlr::RefCslAST command_do_not_gen_cpp_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3989 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 5179 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t524 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DO_NOT_GEN_CPP);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 3997 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 5200 "CslTreeWalker.cpp"
		}
		else {
			goto _loop526;
		}
		
	}
	_loop526:;
	} // ( ... )*
	_t = __t524;
	_t = _t->getNextSibling();
#line 4006 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_DO_NOT_GEN_CPP, params);
	
#line 5215 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_gen_unique_rtl_modules(antlr::RefCslAST _t) {
	antlr::RefCslAST command_gen_unique_rtl_modules_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4012 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 5228 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t528 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GEN_UNIQUE_RTL_MODULES);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4020 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 5249 "CslTreeWalker.cpp"
		}
		else {
			goto _loop530;
		}
		
	}
	_loop530:;
	} // ( ... )*
	_t = __t528;
	_t = _t->getNextSibling();
#line 4029 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_GEN_UNIQUE_RTL_MODULES, params);
	
#line 5264 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_clock(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_clock_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4034 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 5279 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t532 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_CLOCK);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4043 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 5300 "CslTreeWalker.cpp"
		}
		else {
			goto _loop534;
		}
		
	}
	_loop534:;
	} // ( ... )*
	{
	tok1 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	expr=expression(_t);
	_t = _retTree;
#line 4053 "csl.walker.g"
	
	params->push_back(expr);
	CSLOmSetCommand::build(tok1->getLine(), _RS(tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_CLOCK, params);
	
#line 5318 "CslTreeWalker.cpp"
	}
	_t = __t532;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_register_ios(antlr::RefCslAST _t) {
	antlr::RefCslAST command_register_ios_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok2 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok3 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4061 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr1, expr2, expr3;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool wasReset = FALSE;
	
#line 5339 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t537 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REGISTER_IOS);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4071 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 5360 "CslTreeWalker.cpp"
		}
		else {
			goto _loop539;
		}
		
	}
	_loop539:;
	} // ( ... )*
#line 4079 "csl.walker.g"
	
#line 5371 "CslTreeWalker.cpp"
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_INPUT:
	{
		antlr::RefCslAST tmp30_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INPUT);
		_t = _t->getNextSibling();
#line 4081 "csl.walker.g"
		/* add direction */
#line 5383 "CslTreeWalker.cpp"
		break;
	}
	case K_OUTPUT:
	{
		antlr::RefCslAST tmp31_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OUTPUT);
		_t = _t->getNextSibling();
#line 4082 "csl.walker.g"
		/* add direction */
#line 5393 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_RESET:
	{
		antlr::RefCslAST __t542 = _t;
		antlr::RefCslAST tmp32_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RESET);
		_t = _t->getFirstChild();
#line 4084 "csl.walker.g"
		wasReset = TRUE; /* set positive assert reset  */
#line 5414 "CslTreeWalker.cpp"
		tok1 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr1=expression(_t);
		_t = _retTree;
		_t = __t542;
		_t = _t->getNextSibling();
		break;
	}
	case K_RESET_:
	{
		antlr::RefCslAST __t543 = _t;
		antlr::RefCslAST tmp33_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RESET_);
		_t = _t->getFirstChild();
#line 4085 "csl.walker.g"
		wasReset = TRUE; /* set negative assert reset  */
#line 5430 "CslTreeWalker.cpp"
		tok2 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr1=expression(_t);
		_t = _retTree;
		_t = __t543;
		_t = _t->getNextSibling();
		break;
	}
	case 3:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_ENABLE:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 4087 "csl.walker.g"
	
	//params->push_back(expr1);
	
#line 5504 "CslTreeWalker.cpp"
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	if (((_tokenSet_2.member(_t->getType())))&&( wasReset )) {
		expr2=expression(_t);
		_t = _retTree;
	}
	else if ((_t->getType() == 3 || _t->getType() == K_ENABLE)) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	
	}
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_ENABLE:
	{
		antlr::RefCslAST __t546 = _t;
		antlr::RefCslAST tmp34_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ENABLE);
		_t = _t->getFirstChild();
#line 4094 "csl.walker.g"
		/* set enable */
#line 5531 "CslTreeWalker.cpp"
		tok3 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr3=expression(_t);
		_t = _retTree;
#line 4095 "csl.walker.g"
		
		//params->push_back(expr2);
		
#line 5539 "CslTreeWalker.cpp"
		_t = __t546;
		_t = _t->getNextSibling();
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 4099 "csl.walker.g"
	
	//CSLOmSetCommand::build(#tok1->getLine(), _RS(#tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_REGISTER_IOS, params);
	
#line 5558 "CslTreeWalker.cpp"
	_t = __t537;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_override_parameter(antlr::RefCslAST _t) {
	antlr::RefCslAST command_override_parameter_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2817 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmExpr expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 5574 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t320 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OVERRIDE_PARAMETER);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 2826 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 5596 "CslTreeWalker.cpp"
		}
		else {
			goto _loop322;
		}
		
	}
	_loop322:;
	} // ( ... )*
	expr1=expression(_t);
	_t = _retTree;
	expr2=expression(_t);
	_t = _retTree;
	_t = __t320;
	_t = _t->getNextSibling();
#line 2838 "csl.walker.g"
	
	ASSERT(expr1.get() && expr2.get(), "override_parameter method requires 2 arguments");
	params->push_back(expr1);
	params->push_back(expr2);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_OVERRIDE_UNIT_PARAMETER, params);
	
#line 5618 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_auto_connect_verilog_and_csl(antlr::RefCslAST _t) {
	antlr::RefCslAST command_auto_connect_verilog_and_csl_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t564 = _t;
	antlr::RefCslAST tmp35_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_AUTO_CONNECT_VERILOG_AND_CSL);
	_t = _t->getFirstChild();
	param_list_auto_connect_verilog_and_csl(_t);
	_t = _retTree;
	_t = __t564;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_auto_connect_width_inference(antlr::RefCslAST _t) {
	antlr::RefCslAST command_auto_connect_width_inference_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{
	antlr::RefCslAST tmp36_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_AUTO_CONNECT_WIDTH_INFERENCE);
	_t = _t->getNextSibling();
	}
	_retTree = _t;
}

void CslTreeWalker::command_set_compare_trigger(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_compare_trigger_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4311 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr trigger;
	
#line 5655 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t568 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_COMPARE_TRIGGER);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	trigger=expression(_t);
	_t = _retTree;
	_t = __t568;
	_t = _t->getNextSibling();
#line 4320 "csl.walker.g"
	
	//to be added in CSLOM
	
#line 5671 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_generate_waves(antlr::RefCslAST _t) {
	antlr::RefCslAST command_generate_waves_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4326 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr waveType;
	
#line 5683 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t570 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GENERATE_WAVES);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	waveType=expression(_t);
	_t = _retTree;
	_t = __t570;
	_t = _t->getNextSibling();
#line 4335 "csl.walker.g"
	
	//to be added in CSLOM
	
#line 5699 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_dut_mem(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_dut_mem_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2765 "csl.walker.g"
	
	pair <RefString,int> id;
	RefCSLOmExpr expr;
	
#line 5711 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t312 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DUT_MEM);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
		}
		else {
			goto _loop314;
		}
		
	}
	_loop314:;
	} // ( ... )*
	_t = __t312;
	_t = _t->getNextSibling();
#line 2774 "csl.walker.g"
	
	//to be implemented in CSLOM
	
#line 5740 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_dut_mem_init(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_dut_mem_init_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2780 "csl.walker.g"
	
	pair <RefString,int> id;
	RefCSLOmExpr expr;
	
#line 5752 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t316 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DUT_MEM_INIT);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
		}
		else {
			goto _loop318;
		}
		
	}
	_loop318:;
	} // ( ... )*
	_t = __t316;
	_t = _t->getNextSibling();
#line 2789 "csl.walker.g"
	
	//to be implemented in CSLOM
	
#line 5781 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_port_name(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_port_name_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST toka = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokb = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok2 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokc = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok3 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokd = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok4 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST toke = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok5 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokf = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok6 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokg = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok7 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokh = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok8 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST toki = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok9 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokj = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok10 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokk = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok11 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokl = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok12 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokm = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok13 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokn = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok14 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST toko = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok15 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2895 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	EPortNames portName = PN_UNDEFINED;
	TInt lineNumber;
	RefString fileName;
	
#line 5827 "CslTreeWalker.cpp"
	
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SET_RESET_NAME:
	{
		antlr::RefCslAST __t329 = _t;
		toka = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_RESET_NAME);
		_t = _t->getFirstChild();
#line 2905 "csl.walker.g"
		portName = PN_RESET; fileName = _RS(toka->getFilename());
#line 5841 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 2907 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName ,id.first);
				}
				
#line 5858 "CslTreeWalker.cpp"
			}
			else {
				goto _loop331;
			}
			
		}
		_loop331:;
		} // ( ... )*
		{
		tok1 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 2917 "csl.walker.g"
		lineNumber = tok1->getLine();
#line 5873 "CslTreeWalker.cpp"
		}
		_t = __t329;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_CLOCK_NAME:
	{
		antlr::RefCslAST __t333 = _t;
		tokb = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_CLOCK_NAME);
		_t = _t->getFirstChild();
#line 2921 "csl.walker.g"
		portName = PN_CLOCK; fileName = _RS(tokb->getFilename());
#line 5887 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 2923 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName ,id.first);
				}
				
#line 5904 "CslTreeWalker.cpp"
			}
			else {
				goto _loop335;
			}
			
		}
		_loop335:;
		} // ( ... )*
		{
		tok2 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 2933 "csl.walker.g"
		lineNumber = tok2->getLine();
#line 5919 "CslTreeWalker.cpp"
		}
		_t = __t333;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_WR_DATA_NAME:
	{
		antlr::RefCslAST __t337 = _t;
		tokc = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_WR_DATA_NAME);
		_t = _t->getFirstChild();
#line 2937 "csl.walker.g"
		portName = PN_DATA_IN; fileName = _RS(tokc->getFilename());
#line 5933 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 2939 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 5950 "CslTreeWalker.cpp"
			}
			else {
				goto _loop339;
			}
			
		}
		_loop339:;
		} // ( ... )*
		{
		tok3 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 2949 "csl.walker.g"
		lineNumber = tok3->getLine();
#line 5965 "CslTreeWalker.cpp"
		}
		_t = __t337;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_RD_DATA_NAME:
	{
		antlr::RefCslAST __t341 = _t;
		tokd = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_RD_DATA_NAME);
		_t = _t->getFirstChild();
#line 2953 "csl.walker.g"
		portName = PN_DATA_OUT; fileName = _RS(tokd->getFilename());
#line 5979 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 2955 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 5996 "CslTreeWalker.cpp"
			}
			else {
				goto _loop343;
			}
			
		}
		_loop343:;
		} // ( ... )*
		{
		tok4 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 2965 "csl.walker.g"
		lineNumber = tok4->getLine();
#line 6011 "CslTreeWalker.cpp"
		}
		_t = __t341;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_VALID_NAME:
	{
		antlr::RefCslAST __t345 = _t;
		toke = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VALID_NAME);
		_t = _t->getFirstChild();
#line 2969 "csl.walker.g"
		portName = PN_VALID; fileName = _RS(toke->getFilename());
#line 6025 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 2971 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6042 "CslTreeWalker.cpp"
			}
			else {
				goto _loop347;
			}
			
		}
		_loop347:;
		} // ( ... )*
		{
		tok5 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 2981 "csl.walker.g"
		lineNumber = tok5->getLine();
#line 6057 "CslTreeWalker.cpp"
		}
		_t = __t345;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_WR_ADDR_NAME:
	{
		antlr::RefCslAST __t349 = _t;
		tokf = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_WR_ADDR_NAME);
		_t = _t->getFirstChild();
#line 2986 "csl.walker.g"
		portName = PN_WR_ADDR; fileName = _RS(tokf->getFilename());
#line 6071 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 2988 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6088 "CslTreeWalker.cpp"
			}
			else {
				goto _loop351;
			}
			
		}
		_loop351:;
		} // ( ... )*
		{
		tok6 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 2998 "csl.walker.g"
		lineNumber = tok6->getLine();
#line 6103 "CslTreeWalker.cpp"
		}
		_t = __t349;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_RD_ADDR_NAME:
	{
		antlr::RefCslAST __t353 = _t;
		tokg = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_RD_ADDR_NAME);
		_t = _t->getFirstChild();
#line 3002 "csl.walker.g"
		portName = PN_RD_ADDR; fileName = _RS(tokg->getFilename());
#line 6117 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 3004 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6134 "CslTreeWalker.cpp"
			}
			else {
				goto _loop355;
			}
			
		}
		_loop355:;
		} // ( ... )*
		{
		tok7 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 3014 "csl.walker.g"
		lineNumber = tok7->getLine();
#line 6149 "CslTreeWalker.cpp"
		}
		_t = __t353;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_WR_EN_NAME:
	{
		antlr::RefCslAST __t357 = _t;
		tokh = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_WR_EN_NAME);
		_t = _t->getFirstChild();
#line 3018 "csl.walker.g"
		portName = PN_WR_EN; fileName = _RS(tokh->getFilename());
#line 6163 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 3020 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6180 "CslTreeWalker.cpp"
			}
			else {
				goto _loop359;
			}
			
		}
		_loop359:;
		} // ( ... )*
		{
		tok8 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 3030 "csl.walker.g"
		lineNumber = tok8->getLine();
#line 6195 "CslTreeWalker.cpp"
		}
		_t = __t357;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_RD_EN_NAME:
	{
		antlr::RefCslAST __t361 = _t;
		toki = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_RD_EN_NAME);
		_t = _t->getFirstChild();
#line 3034 "csl.walker.g"
		portName = PN_RD_EN; fileName = _RS(toki->getFilename());
#line 6209 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 3036 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6226 "CslTreeWalker.cpp"
			}
			else {
				goto _loop363;
			}
			
		}
		_loop363:;
		} // ( ... )*
		{
		tok9 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 3046 "csl.walker.g"
		lineNumber = tok9->getLine();
#line 6241 "CslTreeWalker.cpp"
		}
		_t = __t361;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_WR_CLOCK_NAME:
	{
		antlr::RefCslAST __t365 = _t;
		tokj = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_WR_CLOCK_NAME);
		_t = _t->getFirstChild();
#line 3051 "csl.walker.g"
		portName = PN_WR_CLOCK; fileName = _RS(tokj->getFilename());
#line 6255 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 3053 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6272 "CslTreeWalker.cpp"
			}
			else {
				goto _loop367;
			}
			
		}
		_loop367:;
		} // ( ... )*
		{
		tok10 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 3063 "csl.walker.g"
		lineNumber = tok10->getLine();
#line 6287 "CslTreeWalker.cpp"
		}
		_t = __t365;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_RD_CLOCK_NAME:
	{
		antlr::RefCslAST __t369 = _t;
		tokk = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_RD_CLOCK_NAME);
		_t = _t->getFirstChild();
#line 3067 "csl.walker.g"
		portName = PN_RD_CLOCK; fileName = _RS(tokk->getFilename());
#line 6301 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 3069 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6318 "CslTreeWalker.cpp"
			}
			else {
				goto _loop371;
			}
			
		}
		_loop371:;
		} // ( ... )*
		{
		tok11 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 3079 "csl.walker.g"
		lineNumber = tok11->getLine();
#line 6333 "CslTreeWalker.cpp"
		}
		_t = __t369;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_PUSH_NAME:
	{
		antlr::RefCslAST __t373 = _t;
		tokl = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_PUSH_NAME);
		_t = _t->getFirstChild();
#line 3083 "csl.walker.g"
		portName = PN_PUSH; fileName = _RS(tokl->getFilename());
#line 6347 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 3085 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6364 "CslTreeWalker.cpp"
			}
			else {
				goto _loop375;
			}
			
		}
		_loop375:;
		} // ( ... )*
		{
		tok12 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 3095 "csl.walker.g"
		lineNumber = tok12->getLine();
#line 6379 "CslTreeWalker.cpp"
		}
		_t = __t373;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_POP_NAME:
	{
		antlr::RefCslAST __t377 = _t;
		tokm = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_POP_NAME);
		_t = _t->getFirstChild();
#line 3099 "csl.walker.g"
		portName = PN_POP; fileName = _RS(tokm->getFilename());
#line 6393 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 3101 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6410 "CslTreeWalker.cpp"
			}
			else {
				goto _loop379;
			}
			
		}
		_loop379:;
		} // ( ... )*
		{
		tok13 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 3111 "csl.walker.g"
		lineNumber = tok13->getLine();
#line 6425 "CslTreeWalker.cpp"
		}
		_t = __t377;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_FULL_NAME:
	{
		antlr::RefCslAST __t381 = _t;
		tokn = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_FULL_NAME);
		_t = _t->getFirstChild();
#line 3115 "csl.walker.g"
		portName = PN_FULL; fileName = _RS(tokn->getFilename());
#line 6439 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 3117 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6456 "CslTreeWalker.cpp"
			}
			else {
				goto _loop383;
			}
			
		}
		_loop383:;
		} // ( ... )*
		{
		tok14 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 3127 "csl.walker.g"
		lineNumber = tok14->getLine();
#line 6471 "CslTreeWalker.cpp"
		}
		_t = __t381;
		_t = _t->getNextSibling();
		break;
	}
	case K_SET_EMPTY_NAME:
	{
		antlr::RefCslAST __t385 = _t;
		toko = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_EMPTY_NAME);
		_t = _t->getFirstChild();
#line 3131 "csl.walker.g"
		portName = PN_EMPTY; fileName = _RS(toko->getFilename());
#line 6485 "CslTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 3133 "csl.walker.g"
				
				if(scope.get()) {
				scope->addHidItem(id.first);
				}
				else {
				scope = CSLOmExprLink::build(id.second, fileName, id.first);
				}
				
#line 6502 "CslTreeWalker.cpp"
			}
			else {
				goto _loop387;
			}
			
		}
		_loop387:;
		} // ( ... )*
		{
		tok15 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		expr=expression(_t);
		_t = _retTree;
#line 3143 "csl.walker.g"
		lineNumber = tok15->getLine();
#line 6517 "CslTreeWalker.cpp"
		}
		_t = __t385;
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 3147 "csl.walker.g"
	
	params->push_back(expr);
	CSLOmSetCommand::addEnumParam(portName, NSCSLOm::TYPE_CMD_SET_PORT_NAME);
	CSLOmSetCommand::build(lineNumber, fileName, design, scope, NSCSLOm::TYPE_CMD_SET_PORT_NAME, params);     
	
#line 6535 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_width(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_width_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4377 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr width;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 6549 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t579 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_WIDTH);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4386 "csl.walker.g"
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );  
			}
			
#line 6570 "CslTreeWalker.cpp"
		}
		else {
			goto _loop581;
		}
		
	}
	_loop581:;
	} // ( ... )*
	width=expression(_t);
	_t = _retTree;
#line 4395 "csl.walker.g"
	
	params->push_back(width);
	
#line 6585 "CslTreeWalker.cpp"
	_t = __t579;
	_t = _t->getNextSibling();
#line 4399 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_WIDTH,params);
	
#line 6592 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_depth(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_depth_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4404 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr depth;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 6606 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t583 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DEPTH);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4413 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );  
			}
			
#line 6628 "CslTreeWalker.cpp"
		}
		else {
			goto _loop585;
		}
		
	}
	_loop585:;
	} // ( ... )*
	depth=expression(_t);
	_t = _retTree;
#line 4423 "csl.walker.g"
	
	params->push_back(depth);
	
#line 6643 "CslTreeWalker.cpp"
	_t = __t583;
	_t = _t->getNextSibling();
#line 4427 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_DEPTH,params);
	
#line 6650 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_dim_width(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_dim_width_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4433 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmExpr expr1, expr2;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 6664 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t587 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DIM_WIDTH);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4442 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 6686 "CslTreeWalker.cpp"
		}
		else {
			goto _loop589;
		}
		
	}
	_loop589:;
	} // ( ... )*
	expr1=expression(_t);
	_t = _retTree;
#line 4452 "csl.walker.g"
	
	params->push_back(expr1);
	
#line 6701 "CslTreeWalker.cpp"
	expr2=expression(_t);
	_t = _retTree;
#line 4456 "csl.walker.g"
	
	params->push_back(expr2);
	
#line 6708 "CslTreeWalker.cpp"
	_t = __t587;
	_t = _t->getNextSibling();
#line 4460 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_DIM_WIDTH, params);
	
#line 6715 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_bitrange(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_bitrange_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok2 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4767 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmExpr bitRangeExpr;
	RefCSLOmExpr bitRange1;
	RefCSLOmExpr bitRange2;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmBaseRange br;
	
#line 6733 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t623 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_BITRANGE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4779 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 6755 "CslTreeWalker.cpp"
		}
		else {
			goto _loop625;
		}
		
	}
	_loop625:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		bitRangeExpr=expression(_t);
		_t = _retTree;
#line 4789 "csl.walker.g"
		
		params->push_back(bitRangeExpr);
		
#line 6826 "CslTreeWalker.cpp"
		break;
	}
	case BITRANGE:
	{
		antlr::RefCslAST __t627 = _t;
		tok2 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),BITRANGE);
		_t = _t->getFirstChild();
		bitRange1=expression(_t);
		_t = _retTree;
		bitRange2=expression(_t);
		_t = _retTree;
		_t = __t627;
		_t = _t->getNextSibling();
#line 4793 "csl.walker.g"
		
		br = CSLOmSimpleBitRange::build( tok2->getLine(), _RS(tok->getFilename()), design, _RS(""), bitRange1, bitRange2);
		params->push_back( br->getBitRangeLink());
		
#line 6846 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t623;
	_t = _t->getNextSibling();
#line 4799 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_BITRANGE, params);
	
#line 6861 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_dim_bitrange(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_dim_bitrange_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4805 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmExpr dim, brObj;
	RefCSLOmBaseRange br;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 6876 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t629 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DIM_BITRANGE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4815 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 6898 "CslTreeWalker.cpp"
		}
		else {
			goto _loop631;
		}
		
	}
	_loop631:;
	} // ( ... )*
	dim=expression(_t);
	_t = _retTree;
#line 4825 "csl.walker.g"
	
	params->push_back(dim);
	
#line 6913 "CslTreeWalker.cpp"
	{
	brObj=expression(_t);
	_t = _retTree;
#line 4829 "csl.walker.g"
	
	params->push_back(brObj);
	
#line 6921 "CslTreeWalker.cpp"
	}
	_t = __t629;
	_t = _t->getNextSibling();
#line 4838 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DIM_BITRANGE, params);
	
#line 6929 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_range(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_range_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4844 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr expr1, expr2;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 6943 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t634 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_RANGE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4853 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 6965 "CslTreeWalker.cpp"
		}
		else {
			goto _loop636;
		}
		
	}
	_loop636:;
	} // ( ... )*
	{
	expr1=expression(_t);
	_t = _retTree;
#line 4863 "csl.walker.g"
	
	params->push_back(expr1);
	
#line 6981 "CslTreeWalker.cpp"
	}
	{
	expr2=expression(_t);
	_t = _retTree;
#line 4868 "csl.walker.g"
	
	params->push_back(expr2);
	
#line 6990 "CslTreeWalker.cpp"
	}
	_t = __t634;
	_t = _t->getNextSibling();
#line 4873 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_RANGE, params);
	
#line 6998 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_dim_range(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_dim_range_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5648 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr(), expr2 = RefCSLOmExpr(), expr3 = RefCSLOmExpr();
	pair<RefString, int> id;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 7012 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t726 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DIM_RANGE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5657 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7034 "CslTreeWalker.cpp"
		}
		else {
			goto _loop728;
		}
		
	}
	_loop728:;
	} // ( ... )*
	{ // ( ... )+
	int _cnt730=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
#line 5667 "csl.walker.g"
			
			params->push_back(expr);
			
#line 7055 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt730>=1 ) { goto _loop730; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt730++;
	}
	_loop730:;
	}  // ( ... )+
	_t = __t726;
	_t = _t->getNextSibling();
#line 5672 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_DIM_RANGE, params);
	
#line 7071 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_offset(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_offset_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5000 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 7085 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t640 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_OFFSET);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5009 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7107 "CslTreeWalker.cpp"
		}
		else {
			goto _loop642;
		}
		
	}
	_loop642:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 5019 "csl.walker.g"
	
	params->push_back(expr);
	
#line 7122 "CslTreeWalker.cpp"
	_t = __t640;
	_t = _t->getNextSibling();
#line 5023 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_OFFSET, params);
	
#line 7129 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_dim_offset(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_dim_offset_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5029 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr dimension, offset;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 7143 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t644 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DIM_OFFSET);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5038 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7165 "CslTreeWalker.cpp"
		}
		else {
			goto _loop646;
		}
		
	}
	_loop646:;
	} // ( ... )*
	{
	dimension=expression(_t);
	_t = _retTree;
#line 5048 "csl.walker.g"
	
	params->push_back(dimension);
	
#line 7181 "CslTreeWalker.cpp"
	}
	{
	offset=expression(_t);
	_t = _retTree;
#line 5053 "csl.walker.g"
	
	params->push_back(offset);
	
#line 7190 "CslTreeWalker.cpp"
	}
	_t = __t644;
	_t = _t->getNextSibling();
#line 5058 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DIM_OFFSET, params);
	
#line 7198 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_number_of_dimensions(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_number_of_dimensions_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5064 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	RefCSLOmExpr dimensionsNumber;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 7213 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t650 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_NUMBER_OF_DIMENSIONS);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5074 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7235 "CslTreeWalker.cpp"
		}
		else {
			goto _loop652;
		}
		
	}
	_loop652:;
	} // ( ... )*
	{
	dimensionsNumber=expression(_t);
	_t = _retTree;
#line 5084 "csl.walker.g"
	
	params->push_back(dimensionsNumber);
	
#line 7251 "CslTreeWalker.cpp"
	}
	_t = __t650;
	_t = _t->getNextSibling();
#line 5089 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_NUMBER_OF_DIMENSIONS, params);
	
#line 7259 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_unit_prefix(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_unit_prefix_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4106 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmExpr prefix;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 7273 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t548 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_UNIT_PREFIX);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4116 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7295 "CslTreeWalker.cpp"
		}
		else {
			goto _loop550;
		}
		
	}
	_loop550:;
	} // ( ... )*
	prefix=expression(_t);
	_t = _retTree;
#line 4126 "csl.walker.g"
	
	params->push_back(prefix);
	
#line 7310 "CslTreeWalker.cpp"
	_t = __t548;
	_t = _t->getNextSibling();
#line 4130 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_UNIT_PREFIX, params);
	
#line 7317 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_signal_prefix(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_signal_prefix_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4136 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr prefix;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 7331 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t552 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_SIGNAL_PREFIX);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4145 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7353 "CslTreeWalker.cpp"
		}
		else {
			goto _loop554;
		}
		
	}
	_loop554:;
	} // ( ... )*
	{ // ( ... )+
	int _cnt556=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			prefix=expression(_t);
			_t = _retTree;
#line 4155 "csl.walker.g"
			
			params->push_back(prefix);
			
#line 7374 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt556>=1 ) { goto _loop556; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt556++;
	}
	_loop556:;
	}  // ( ... )+
	_t = __t552;
	_t = _t->getNextSibling();
#line 4160 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_SIGNAL_PREFIX, params);
	
#line 7390 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_signal_prefix_local(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_signal_prefix_local_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4166 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr prefix;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 7404 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t558 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_SIGNAL_PREFIX_LOCAL);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4175 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7426 "CslTreeWalker.cpp"
		}
		else {
			goto _loop560;
		}
		
	}
	_loop560:;
	} // ( ... )*
	{ // ( ... )+
	int _cnt562=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			prefix=expression(_t);
			_t = _retTree;
#line 4185 "csl.walker.g"
			
			params->push_back(prefix);
			
#line 7447 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt562>=1 ) { goto _loop562; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt562++;
	}
	_loop562:;
	}  // ( ... )+
	_t = __t558;
	_t = _t->getNextSibling();
#line 4190 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_SIGNAL_PREFIX_LOCAL, params);
	
#line 7463 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_value(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_value_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4465 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr valueExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool  hasIdentifier = FALSE;
	
#line 7478 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t591 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_VALUE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4475 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if(scope.get()) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7501 "CslTreeWalker.cpp"
		}
		else {
			goto _loop593;
		}
		
	}
	_loop593:;
	} // ( ... )*
	valueExpr=expression(_t);
	_t = _retTree;
#line 4486 "csl.walker.g"
	
	params->push_back(valueExpr);
	
#line 7516 "CslTreeWalker.cpp"
	_t = __t591;
	_t = _t->getNextSibling();
#line 4490 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_VALUE, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_VALUE, params);
	}
	
#line 7528 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_enum(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_enum_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4500 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr enumExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 7543 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t595 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_ENUM);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4510 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if(scope.get()) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7566 "CslTreeWalker.cpp"
		}
		else {
			goto _loop597;
		}
		
	}
	_loop597:;
	} // ( ... )*
	enumExpr=expression(_t);
	_t = _retTree;
#line 4521 "csl.walker.g"
	
	params->push_back(enumExpr);
	
#line 7581 "CslTreeWalker.cpp"
	_t = __t595;
	_t = _t->getNextSibling();
#line 4525 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_ENUM, params);
	} 
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ENUM, params);
	}
	
#line 7593 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_enum_item(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_enum_item_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4535 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr enum_item;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 7608 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t599 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_ENUM_ITEM);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4545 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if(scope.get()) {
			scope->addHidItem(id.first);
			}
			else {
			scope = CSLOmExprLink::build(id.second, _RS(tok->getFilename()),id.first);
			}
			
#line 7631 "CslTreeWalker.cpp"
		}
		else {
			goto _loop601;
		}
		
	}
	_loop601:;
	} // ( ... )*
	enum_item=expression(_t);
	_t = _retTree;
#line 4556 "csl.walker.g"
	
	params->push_back(enum_item);
	
#line 7646 "CslTreeWalker.cpp"
	_t = __t599;
	_t = _t->getNextSibling();
#line 4560 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_ENUM_ITEM, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ENUM_ITEM, params);
	}
	
#line 7658 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_position(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_position_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4570 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr fieldExpr, positionExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 7673 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t603 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_POSITION);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4580 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7696 "CslTreeWalker.cpp"
		}
		else {
			goto _loop605;
		}
		
	}
	_loop605:;
	} // ( ... )*
	fieldExpr=expression(_t);
	_t = _retTree;
#line 4591 "csl.walker.g"
	
	params->push_back(fieldExpr);
	
#line 7711 "CslTreeWalker.cpp"
	positionExpr=expression(_t);
	_t = _retTree;
#line 4595 "csl.walker.g"
	
	params->push_back(positionExpr);
	
#line 7718 "CslTreeWalker.cpp"
	_t = __t603;
	_t = _t->getNextSibling();
#line 4599 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_POSITION, params);
	} 
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_POSITION, params);
	}
	
#line 7730 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_field_position(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_field_position_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4609 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr fieldExpr, positionExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 7745 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t607 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_FIELD_POSITION);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4619 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7768 "CslTreeWalker.cpp"
		}
		else {
			goto _loop609;
		}
		
	}
	_loop609:;
	} // ( ... )*
	fieldExpr=expression(_t);
	_t = _retTree;
#line 4630 "csl.walker.g"
	
	params->push_back(fieldExpr);
	
#line 7783 "CslTreeWalker.cpp"
	positionExpr=expression(_t);
	_t = _retTree;
#line 4634 "csl.walker.g"
	
	params->push_back(positionExpr);
	
#line 7790 "CslTreeWalker.cpp"
	_t = __t607;
	_t = _t->getNextSibling();
#line 4638 "csl.walker.g"
	
	//Note: CMD uses the same enum as for set_position in this case
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_POSITION, params);
	} 
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_POSITION, params);
	}
	
#line 7803 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_next(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_next_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4649 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr leftFieldExpr, rightFieldExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 7818 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t611 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_NEXT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4659 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7841 "CslTreeWalker.cpp"
		}
		else {
			goto _loop613;
		}
		
	}
	_loop613:;
	} // ( ... )*
	leftFieldExpr=expression(_t);
	_t = _retTree;
#line 4670 "csl.walker.g"
	
	params->push_back(leftFieldExpr);
	
#line 7856 "CslTreeWalker.cpp"
	rightFieldExpr=expression(_t);
	_t = _retTree;
#line 4674 "csl.walker.g"
	
	params->push_back(rightFieldExpr);
	
#line 7863 "CslTreeWalker.cpp"
	_t = __t611;
	_t = _t->getNextSibling();
#line 4678 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_NEXT, params);
	} 
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_NEXT, params);
	}
	
#line 7875 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_previous(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_previous_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4688 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr leftFieldExpr, rightFieldExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 7890 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t615 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_PREVIOUS);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4698 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7913 "CslTreeWalker.cpp"
		}
		else {
			goto _loop617;
		}
		
	}
	_loop617:;
	} // ( ... )*
	rightFieldExpr=expression(_t);
	_t = _retTree;
#line 4709 "csl.walker.g"
	
	params->push_back(rightFieldExpr);
	
#line 7928 "CslTreeWalker.cpp"
	leftFieldExpr=expression(_t);
	_t = _retTree;
#line 4713 "csl.walker.g"
	
	params->push_back(leftFieldExpr);
	
#line 7935 "CslTreeWalker.cpp"
	_t = __t615;
	_t = _t->getNextSibling();
#line 4717 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_PREVIOUS, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_PREVIOUS, params);
	}
	
#line 7947 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_allowed_range(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_allowed_range_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4727 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr firstExpr, secondExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 7962 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t619 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ADD_ALLOWED_RANGE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4737 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 7985 "CslTreeWalker.cpp"
		}
		else {
			goto _loop621;
		}
		
	}
	_loop621:;
	} // ( ... )*
	firstExpr=expression(_t);
	_t = _retTree;
#line 4748 "csl.walker.g"
	
	params->push_back(firstExpr);
	
#line 8000 "CslTreeWalker.cpp"
	secondExpr=expression(_t);
	_t = _retTree;
#line 4752 "csl.walker.g"
	
	params->push_back(secondExpr);
	
#line 8007 "CslTreeWalker.cpp"
	_t = __t619;
	_t = _t->getNextSibling();
#line 4756 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_ADD_ALLOWED_RANGE, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_ADD_ALLOWED_RANGE, params);
	}
	
#line 8019 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_create_rtl_module(antlr::RefCslAST _t) {
	antlr::RefCslAST command_create_rtl_module_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t7 = _t;
	antlr::RefCslAST tmp37_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CREATE_RTL_MODULE);
	_t = _t->getFirstChild();
#line 304 "csl.walker.g"
	
	//call cmd
	
#line 8034 "CslTreeWalker.cpp"
	_t = __t7;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_set_const_value(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_const_value_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t9 = _t;
	antlr::RefCslAST tmp38_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_CONST_VALUE);
	_t = _t->getFirstChild();
#line 313 "csl.walker.g"
	
	//call cmd
	
#line 8051 "CslTreeWalker.cpp"
	_t = __t9;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_set_field(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_field_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t11 = _t;
	antlr::RefCslAST tmp39_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_FIELD);
	_t = _t->getFirstChild();
#line 323 "csl.walker.g"
	
	//call cmd
	
#line 8068 "CslTreeWalker.cpp"
	_t = __t11;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_set_external(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_external_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t13 = _t;
	antlr::RefCslAST tmp40_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_EXTERNAL);
	_t = _t->getFirstChild();
#line 332 "csl.walker.g"
	
	//call cmd
	
#line 8085 "CslTreeWalker.cpp"
	_t = __t13;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_merge(antlr::RefCslAST _t) {
	antlr::RefCslAST command_merge_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 5501 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	
#line 8098 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t704 = _t;
	antlr::RefCslAST tmp41_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_MERGE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5508 "csl.walker.g"
			
			/*
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
			}
			*/
			
#line 8122 "CslTreeWalker.cpp"
		}
		else {
			goto _loop706;
		}
		
	}
	_loop706:;
	} // ( ... )*
	_t = __t704;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_invert(antlr::RefCslAST _t) {
	antlr::RefCslAST command_invert_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 5522 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	
#line 8143 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t708 = _t;
	antlr::RefCslAST tmp42_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INVERT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5529 "csl.walker.g"
			
			/*
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
			}
			*/
			
#line 8167 "CslTreeWalker.cpp"
		}
		else {
			goto _loop710;
		}
		
	}
	_loop710:;
	} // ( ... )*
	_t = __t708;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_buffer(antlr::RefCslAST _t) {
	antlr::RefCslAST command_buffer_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 5543 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	
#line 8188 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t712 = _t;
	antlr::RefCslAST tmp43_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_BUFFER);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5550 "csl.walker.g"
			
			/*
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
			}
			*/
			
#line 8212 "CslTreeWalker.cpp"
		}
		else {
			goto _loop714;
		}
		
	}
	_loop714:;
	} // ( ... )*
	_t = __t712;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_reverse(antlr::RefCslAST _t) {
	antlr::RefCslAST command_reverse_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5565 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 8235 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t716 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REVERSE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5573 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 8257 "CslTreeWalker.cpp"
		}
		else {
			goto _loop718;
		}
		
	}
	_loop718:;
	} // ( ... )*
	_t = __t716;
	_t = _t->getNextSibling();
#line 5583 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_REVERSE, params);
	
#line 8272 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_connect_by_name(antlr::RefCslAST _t) {
	antlr::RefCslAST command_connect_by_name_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokrange = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5261 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmSimpleBitRange br;
	pair<RefString, int> id;
	RefCSLOmExpr lhsExpr;
	RefCSLOmExpr expr1, expr2;
	RefCSLOmExpr range_expr1, range_expr2;
	TBool hasLhsId = FALSE;
	TBool hasRangeExpr = FALSE, hasSecondExpr = FALSE, negDirPartSel = FALSE;
	
#line 8291 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t675 = _t;
	tok1 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CONNECT_BY_NAME);
	_t = _t->getFirstChild();
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case IDENTIFIER:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				id=identifier(_t);
				_t = _retTree;
#line 5275 "csl.walker.g"
				
				if (!hasLhsId) { hasLhsId = TRUE; }
				if( scope.get() ){
				scope->addHidItem( id.first );
				}
				else {
				scope = CSLOmExprLink::build( id.second, _RS(tok1->getFilename()), id.first );
				}
				
#line 8371 "CslTreeWalker.cpp"
			}
			else {
				goto _loop678;
			}
			
		}
		_loop678:;
		} // ( ... )*
		{
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if (((_t->getType() == RANGE_EXPRESSION))&&(hasLhsId)) {
			antlr::RefCslAST __t680 = _t;
			tokrange = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),RANGE_EXPRESSION);
			_t = _t->getFirstChild();
#line 5287 "csl.walker.g"
			hasRangeExpr = TRUE;
#line 8390 "CslTreeWalker.cpp"
			range_expr1=expression(_t);
			_t = _retTree;
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case COLON:
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case PO_NEG:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case COLON:
				{
					antlr::RefCslAST tmp44_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COLON);
					_t = _t->getNextSibling();
					break;
				}
				case PO_NEG:
				{
					antlr::RefCslAST tmp45_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PO_NEG);
					_t = _t->getNextSibling();
#line 5289 "csl.walker.g"
					negDirPartSel = TRUE;
#line 8469 "CslTreeWalker.cpp"
					break;
				}
				case MINUS:
				case QUESTION:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case EXPRESSION:
				case RANGE_EXPRESSION:
				case MINTYPMAX_EXPRESSION:
				case EXPR_PRIMARY_IDENTIFIER:
				case U_PLUS:
				case U_MINUS:
				case U_AND:
				case U_NAND:
				case U_OR:
				case U_NOR:
				case U_XOR:
				case U_XNOR:
				case FUNCTION_CALL_RET_ID:
				case FUNCTION_CALL_RET_EXPR:
				case EXPR_HYBRID:
				case SIZED_NUMBER:
				case K_CONCATENATION:
				case K_REPLICATION:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				range_expr2=expression(_t);
				_t = _retTree;
#line 5290 "csl.walker.g"
				hasSecondExpr = TRUE;
#line 8536 "CslTreeWalker.cpp"
				break;
			}
			case 3:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			_t = __t680;
			_t = _t->getNextSibling();
		}
		else if ((_tokenSet_2.member(_t->getType()))) {
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		
		}
#line 5295 "csl.walker.g"
		
		if (hasRangeExpr) {
		if(!hasSecondExpr){
		br = CSLOmSimpleBitRange::build(id.second, _RS(tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr1);
		}
		else{
		br = CSLOmSimpleBitRange::build(id.second, _RS(tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr2);
		}
		scope->setBitRange(br);
		if (negDirPartSel) { scope->setPartSelectDir(CSLOmExprLink::PS_DIR_DESC); }
		}
		
#line 8572 "CslTreeWalker.cpp"
		break;
	}
	case K_TO_USE_FOR_NONDETERMINISM_IN_WALKER:
	{
		antlr::RefCslAST __t683 = _t;
		antlr::RefCslAST tmp46_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TO_USE_FOR_NONDETERMINISM_IN_WALKER);
		_t = _t->getFirstChild();
		lhsExpr=expression(_t);
		_t = _retTree;
		_t = __t683;
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr1=expression(_t);
	_t = _retTree;
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr2=expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 5319 "csl.walker.g"
	
	if (!lhsExpr.get()) { lhsExpr = scope; }
	
	//    if(expr1->isExprLink()){
	if(expr2.get() && expr2->isExprLink()){
	NSAutorouter::Connection::addConnection(lhsExpr, expr1, _RS(*((CSLOmExprLink::cast(expr2))->getName())), FALSE);
	}
	else{
	NSAutorouter::Connection::addConnection(lhsExpr, expr1, RefString(), FALSE);
	}
	//    }
	//    else{
	//      DCERR("WALKER: Command connect has received an unsupported parameter - if it's different from concat, contact developer");
	//    }
	//    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_CONNECT, params);
	
#line 8682 "CslTreeWalker.cpp"
	_t = __t675;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_connect_by_pattern(antlr::RefCslAST _t) {
	antlr::RefCslAST command_connect_by_pattern_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok2 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokrange = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5339 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmSimpleBitRange br;
	pair<RefString, int> id;
	RefCSLOmExpr expr1, expr2;
	RefCSLOmExpr range_expr1, range_expr2;
	TBool hasLhsId = FALSE;
	TBool hasRangeExpr = FALSE, hasSecondExpr = FALSE, negDirPartSel = FALSE;
	
#line 8702 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t686 = _t;
	tok2 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CONNECT_BY_PATTERN);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5351 "csl.walker.g"
			
			if (!hasLhsId) { hasLhsId = TRUE; }
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok2->getFilename()), id.first );
			}
			
#line 8725 "CslTreeWalker.cpp"
		}
		else {
			goto _loop688;
		}
		
	}
	_loop688:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	if (((_t->getType() == RANGE_EXPRESSION))&&(hasLhsId)) {
		antlr::RefCslAST __t690 = _t;
		tokrange = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),RANGE_EXPRESSION);
		_t = _t->getFirstChild();
#line 5363 "csl.walker.g"
		hasRangeExpr = TRUE;
#line 8744 "CslTreeWalker.cpp"
		range_expr1=expression(_t);
		_t = _retTree;
		{
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case COLON:
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case PO_NEG:
		case STRING:
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case EXPRESSION:
		case RANGE_EXPRESSION:
		case MINTYPMAX_EXPRESSION:
		case EXPR_PRIMARY_IDENTIFIER:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case FUNCTION_CALL_RET_ID:
		case FUNCTION_CALL_RET_EXPR:
		case EXPR_HYBRID:
		case SIZED_NUMBER:
		case K_CONCATENATION:
		case K_REPLICATION:
		{
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case COLON:
			{
				antlr::RefCslAST tmp47_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COLON);
				_t = _t->getNextSibling();
				break;
			}
			case PO_NEG:
			{
				antlr::RefCslAST tmp48_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PO_NEG);
				_t = _t->getNextSibling();
#line 5365 "csl.walker.g"
				negDirPartSel = TRUE;
#line 8823 "CslTreeWalker.cpp"
				break;
			}
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			range_expr2=expression(_t);
			_t = _retTree;
#line 5366 "csl.walker.g"
			hasSecondExpr = TRUE;
#line 8890 "CslTreeWalker.cpp"
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		_t = __t690;
		_t = _t->getNextSibling();
	}
	else if ((_tokenSet_2.member(_t->getType()))) {
	}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	
	}
#line 5371 "csl.walker.g"
	
	if (hasRangeExpr) {
	if(!hasSecondExpr){
	br = CSLOmSimpleBitRange::build(id.second, _RS(tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr1);
	}
	else{
	br = CSLOmSimpleBitRange::build(id.second, _RS(tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr2);
	}
	scope->setBitRange(br);
	if (negDirPartSel) { scope->setPartSelectDir(CSLOmExprLink::PS_DIR_DESC); }
	}
	
#line 8926 "CslTreeWalker.cpp"
	expr1=expression(_t);
	_t = _retTree;
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr2=expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 5386 "csl.walker.g"
	
	if(expr1->isExprLink()){
	if(expr2.get() && expr2->isExprLink()){
	NSAutorouter::Connection::addConnection(scope, CSLOmExprLink::cast(expr1), _RS(*((CSLOmExprLink::cast(expr2))->getName())));
	}
	else{
	NSAutorouter::Connection::addConnection(scope, CSLOmExprLink::cast(expr1));
	}
	}
	else{
	DCERR("WALKER: Command connect has received an unsupported parameter - if it's different from concat, contact developer");
	}
	//    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_CONNECT, params);
	
#line 9014 "CslTreeWalker.cpp"
	_t = __t686;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_connect_units(antlr::RefCslAST _t) {
	antlr::RefCslAST command_connect_units_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok2 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5404 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr expr1, expr2;
	
#line 9029 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t695 = _t;
	tok2 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CONNECT_UNITS);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5412 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok2->getFilename()), id.first );
			}
			
#line 9051 "CslTreeWalker.cpp"
		}
		else {
			goto _loop697;
		}
		
	}
	_loop697:;
	} // ( ... )*
	expr1=expression(_t);
	_t = _retTree;
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr2=expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 5423 "csl.walker.g"
	
	if (expr1->isExprLink()) {
	DCERR("is expr link");
	}
	else {
	DCERR("is not expt link");
	}
	if(expr1->isExprLink()){
	if(expr2.get() && expr2->isString()){
	NSAutorouter::Connection::addConnection(scope, CSLOmExprLink::cast(expr1), _RS(*((CSLOmString::cast(expr2))->getValue())));
	}
	else{
	NSAutorouter::Connection::addConnection(scope, CSLOmExprLink::cast(expr1));
	}
	}
	else{
	DCERR("WALKER: Command connect has received an unsupported parameter - if it's different from concat, contact developer");
	}
	//    NSAutorouter::addConnection();
	//    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_CONNECT, params);
	
#line 9154 "CslTreeWalker.cpp"
	_t = __t695;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_set_cell(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_cell_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 5478 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr expr;
	
#line 9168 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t700 = _t;
	antlr::RefCslAST tmp49_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_CELL);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5486 "csl.walker.g"
			
			/*
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
			}
			*/
			
#line 9192 "CslTreeWalker.cpp"
		}
		else {
			goto _loop702;
		}
		
	}
	_loop702:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
	_t = __t700;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_input_verilog_type(antlr::RefCslAST _t) {
	antlr::RefCslAST command_input_verilog_type_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5589 "csl.walker.g"
	
	EVerilogType verilogType;
	RefCSLOmSetCommand command = RefCSLOmSetCommand();
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	pair<RefString, int> id;
	
#line 9219 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t720 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INPUT_VERILOG_TYPE);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
#line 5599 "csl.walker.g"
	
	if( scope.get() ){
	scope->addHidItem( id.first );
	}
	else {
	scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
	}
	
#line 9236 "CslTreeWalker.cpp"
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_1995:
	{
		antlr::RefCslAST tmp50_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_1995);
		_t = _t->getNextSibling();
#line 5607 "csl.walker.g"
		verilogType = v1995;
#line 9248 "CslTreeWalker.cpp"
		break;
	}
	case K_2001:
	{
		antlr::RefCslAST tmp51_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_2001);
		_t = _t->getNextSibling();
#line 5608 "csl.walker.g"
		verilogType = v2001;
#line 9258 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t720;
	_t = _t->getNextSibling();
#line 5612 "csl.walker.g"
	
	CSLOmSetCommand::addEnumParam(verilogType, NSCSLOm::TYPE_CMD_INPUT_VERILOG_TYPE);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_INPUT_VERILOG_TYPE, params);
	
#line 9274 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_output_verilog_type(antlr::RefCslAST _t) {
	antlr::RefCslAST command_output_verilog_type_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5619 "csl.walker.g"
	
	EVerilogType verilogType;
	RefCSLOmSetCommand command = RefCSLOmSetCommand();
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	pair<RefString, int> id;
	
#line 9289 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t723 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OUTPUT_VERILOG_TYPE);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
#line 5629 "csl.walker.g"
	
	if( scope.get() ){
	scope->addHidItem( id.first );
	}
	else {
	scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
	}
	
#line 9306 "CslTreeWalker.cpp"
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_1995:
	{
		antlr::RefCslAST tmp52_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_1995);
		_t = _t->getNextSibling();
#line 5637 "csl.walker.g"
		verilogType = v1995;
#line 9318 "CslTreeWalker.cpp"
		break;
	}
	case K_2001:
	{
		antlr::RefCslAST tmp53_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_2001);
		_t = _t->getNextSibling();
#line 5638 "csl.walker.g"
		verilogType = v2001;
#line 9328 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t723;
	_t = _t->getNextSibling();
#line 5641 "csl.walker.g"
	
	CSLOmSetCommand::addEnumParam(verilogType, NSCSLOm::TYPE_CMD_OUTPUT_VERILOG_TYPE);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_OUTPUT_VERILOG_TYPE, params);
	
#line 9344 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_autorouter(antlr::RefCslAST _t) {
	antlr::RefCslAST command_autorouter_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t572 = _t;
	antlr::RefCslAST tmp54_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_AUTOROUTER);
	_t = _t->getFirstChild();
	param_list_autorouter(_t);
	_t = _retTree;
	_t = __t572;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_generate_individual_rtl_signals(antlr::RefCslAST _t) {
	antlr::RefCslAST command_generate_individual_rtl_signals_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 4347 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmSetCommand command = RefCSLOmSetCommand();
	TBool bitValue;
	
#line 9373 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t574 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GENERATE_INDIVIDUAL_RTL_SIGNALS);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 4357 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );  
			}
			
#line 9395 "CslTreeWalker.cpp"
		}
		else {
			goto _loop576;
		}
		
	}
	_loop576:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_ON:
	{
		antlr::RefCslAST tmp55_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ON);
		_t = _t->getNextSibling();
#line 4366 "csl.walker.g"
		bitValue = true;
#line 9415 "CslTreeWalker.cpp"
		break;
	}
	case K_OFF:
	{
		antlr::RefCslAST tmp56_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OFF);
		_t = _t->getNextSibling();
#line 4367 "csl.walker.g"
		bitValue = false;
#line 9425 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t574;
	_t = _t->getNextSibling();
#line 4370 "csl.walker.g"
	
	CSLOmSetCommand::addEnumParam(bitValue, NSCSLOm::TYPE_CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS, params);
	
#line 9441 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_generate_decoder(antlr::RefCslAST _t) {
	antlr::RefCslAST command_generate_decoder_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1870 "csl.walker.g"
	
	pair<RefString, int> id;
	NSCSLOm::RefCSLOmExpr exp1,exp2;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	TInt nrOfExprs = 0;
	
#line 9456 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t238 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GEN_DECODER);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1880 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}       
			
#line 9478 "CslTreeWalker.cpp"
		}
		else {
			goto _loop240;
		}
		
	}
	_loop240:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			exp1=expression(_t);
			_t = _retTree;
#line 1890 "csl.walker.g"
			params->push_back(exp1); 
			++nrOfExprs;
			
#line 9498 "CslTreeWalker.cpp"
		}
		else {
			goto _loop242;
		}
		
	}
	_loop242:;
	} // ( ... )*
	if (!(nrOfExprs <= 2))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException("nrOfExprs <= 2");
#line 1895 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DECODER, params);
	
#line 9513 "CslTreeWalker.cpp"
	_t = __t238;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_set_dimensions(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_dimensions_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 773 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 9525 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t69 = _t;
	antlr::RefCslAST tmp57_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DIMENSIONS);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
#line 780 "csl.walker.g"
	
	//call cmd
	
#line 9537 "CslTreeWalker.cpp"
	_t = __t69;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_set_physical_implementation(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_physical_implementation_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 786 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 9549 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t71 = _t;
	antlr::RefCslAST tmp58_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_PHYSICAL_IMPLEMENTATION);
	_t = _t->getFirstChild();
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SRAM:
	{
		antlr::RefCslAST tmp59_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SRAM);
		_t = _t->getNextSibling();
		break;
	}
	case K_FFA:
	{
		antlr::RefCslAST tmp60_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FFA);
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 794 "csl.walker.g"
	
	//call cmd
	
#line 9583 "CslTreeWalker.cpp"
	_t = __t71;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t74 = _t;
	antlr::RefCslAST tmp61_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ADD_LOGIC);
	_t = _t->getFirstChild();
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_PROGRAMMABLE_DEPTH:
	{
		command_add_logic_programmable_depth(_t);
		_t = _retTree;
		break;
	}
	case K_PRIORITY_BYPASS:
	{
		command_add_logic_priority_bypass(_t);
		_t = _retTree;
		break;
	}
	case K_SYNC_FIFO:
	{
		command_add_logic_sync_fifo(_t);
		_t = _retTree;
		break;
	}
	case K_ASYNC_FIFO:
	{
		command_add_logic_asynch_fifo(_t);
		_t = _retTree;
		break;
	}
	case K_DEPTH_EXTEND:
	{
		command_add_logic_depth_extend(_t);
		_t = _retTree;
		break;
	}
	case K_WIDTH_EXTEND:
	{
		command_add_logic_width_extend(_t);
		_t = _retTree;
		break;
	}
	case K_WR_HOLD:
	{
		command_add_logic_wr_hold(_t);
		_t = _retTree;
		break;
	}
	case K_PARALLEL_OUTPUT:
	{
		command_add_logic_parallel_output(_t);
		_t = _retTree;
		break;
	}
	case K_PARALLEL_INPUT:
	{
		command_add_logic_parallel_input(_t);
		_t = _retTree;
		break;
	}
	case K_RD_WORDS:
	{
		command_add_logic_rd_words(_t);
		_t = _retTree;
		break;
	}
	case K_WR_WORDS:
	{
		command_add_logic_wr_words(_t);
		_t = _retTree;
		break;
	}
	case K_SRAM_RD:
	{
		command_add_logic_sram_rd(_t);
		_t = _retTree;
		break;
	}
	case K_SRAM_WR:
	{
		command_add_logic_sram_wr(_t);
		_t = _retTree;
		break;
	}
	case K_PUSHBACK:
	{
		command_add_logic_pushback(_t);
		_t = _retTree;
		break;
	}
	case K_FLOW_THROUGH:
	{
		command_add_logic_flow_through(_t);
		_t = _retTree;
		break;
	}
	case K_STALL:
	{
		command_add_logic_stall(_t);
		_t = _retTree;
		break;
	}
	case K_STALL_RD_SIDE:
	{
		command_add_logic_stall_rd_side(_t);
		_t = _retTree;
		break;
	}
	case K_STALL_WR_SIDE:
	{
		command_add_logic_stall_wr_side(_t);
		_t = _retTree;
		break;
	}
	case K_WR_RELEASE:
	{
		command_add_logic_wr_release(_t);
		_t = _retTree;
		break;
	}
	case K_ALMOST_EMPTY:
	{
		command_add_logic_almost_empty(_t);
		_t = _retTree;
		break;
	}
	case K_ALMOST_FULL:
	{
		command_add_logic_almost_full(_t);
		_t = _retTree;
		break;
	}
	case K_OUTPUT_WR_ADDR:
	{
		command_add_logic_output_wr_addr(_t);
		_t = _retTree;
		break;
	}
	case K_OUTPUT_RD_ADDR:
	{
		command_add_logic_output_rd_addr(_t);
		_t = _retTree;
		break;
	}
	case K_CREDIT:
	{
		command_add_logic_credit(_t);
		_t = _retTree;
		break;
	}
	case K_RD_CREDIT:
	{
		command_add_logic_rd_credit(_t);
		_t = _retTree;
		break;
	}
	case K_WR_CREDIT:
	{
		command_add_logic_wr_credit(_t);
		_t = _retTree;
		break;
	}
	case K_FLOW:
	{
		command_add_logic_flow(_t);
		_t = _retTree;
		break;
	}
	case K_UNIT_ADDRESS_DECODER:
	{
		command_add_logic_unit_address_decoder(_t);
		_t = _retTree;
		break;
	}
	case K_READ_VALID:
	{
		command_add_logic_read_valid(_t);
		_t = _retTree;
		break;
	}
	case K_ASYNC_RESET:
	{
		command_async_reset(_t);
		_t = _retTree;
		break;
	}
	case K_NEG_OUTPUT:
	{
		command_add_logic_neg_output(_t);
		_t = _retTree;
		break;
	}
	case K_SERIAL_INPUT:
	{
		command_add_logic_serial_input(_t);
		_t = _retTree;
		break;
	}
	case K_SERIAL_OUTPUT:
	{
		command_add_logic_serial_output(_t);
		_t = _retTree;
		break;
	}
	case K_SET:
	{
		command_add_logic_set(_t);
		_t = _retTree;
		break;
	}
	case K_RESET:
	{
		command_add_logic_reset(_t);
		_t = _retTree;
		break;
	}
	case K_INIT:
	{
		command_add_logic_init(_t);
		_t = _retTree;
		break;
	}
	case K_CLEAR:
	{
		command_add_logic_clear(_t);
		_t = _retTree;
		break;
	}
	case K_GRAY_OUTPUT:
	{
		command_add_logic_gray_output(_t);
		_t = _retTree;
		break;
	}
	case K_START_VALUE:
	{
		command_add_logic_start_value(_t);
		_t = _retTree;
		break;
	}
	case K_END_VALUE:
	{
		command_add_logic_end_value(_t);
		_t = _retTree;
		break;
	}
	case K_COUNT_AMOUNT:
	{
		command_add_logic_count_amount(_t);
		_t = _retTree;
		break;
	}
	case K_DIRECTION_CONTROL:
	{
		command_add_logic_direction_control(_t);
		_t = _retTree;
		break;
	}
	case K_COUNT_DIRECTION:
	{
		command_add_logic_count_direction(_t);
		_t = _retTree;
		break;
	}
	case K_LOAD:
	{
		command_add_logic_load(_t);
		_t = _retTree;
		break;
	}
	case K_INJECT_STALLS:
	{
		command_add_logic_inject_stalls(_t);
		_t = _retTree;
		break;
	}
	case K_SIMULATION_TIMEOUT_COUNTER:
	{
		command_add_logic_simulation_timeout_counter(_t);
		_t = _retTree;
		break;
	}
	case K_STALL_GENERATION:
	{
		command_add_logic_stall_generation(_t);
		_t = _retTree;
		break;
	}
	case K_GENERATE_WAVES:
	{
		command_add_logic_generate_waves(_t);
		_t = _retTree;
		break;
	}
	case K_CLOCK_SIGNAL:
	{
		command_add_logic_clock(_t);
		_t = _retTree;
		break;
	}
	case K_GENERATE_REPORT:
	{
		command_add_logic_generate_report(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t74;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_directive(antlr::RefCslAST _t) {
	antlr::RefCslAST command_directive_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t15 = _t;
	antlr::RefCslAST tmp62_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DIRECTIVE);
	_t = _t->getFirstChild();
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_REGISTER_GROUP:
	{
		directive_register_group(_t);
		_t = _retTree;
		break;
	}
	case K_DISCONNECT_REG_FIELDS_IOS:
	{
		directive_disconnect_register_fields_from_ios(_t);
		_t = _retTree;
		break;
	}
	case K_CONNECT_REG_FIELDS_IOS:
	{
		directive_connect_register_fields_to_ios(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t15;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_auto_gen_memory_map(antlr::RefCslAST _t) {
	antlr::RefCslAST command_auto_gen_memory_map_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 349 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr prefixExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 9962 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t18 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_AUTO_GEN_MEMORY_MAP);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 359 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 9985 "CslTreeWalker.cpp"
		}
		else {
			goto _loop20;
		}
		
	}
	_loop20:;
	} // ( ... )*
	_t = __t18;
	_t = _t->getNextSibling();
#line 370 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_AUTO_GEN_MEM_MAP, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_AUTO_GEN_MEM_MAP, params);
	}
	
#line 10005 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_top_unit(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_top_unit_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 380 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr topUnitExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 10020 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t22 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_TOP_UNIT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 390 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 10043 "CslTreeWalker.cpp"
		}
		else {
			goto _loop24;
		}
		
	}
	_loop24:;
	} // ( ... )*
	topUnitExpr=expression(_t);
	_t = _retTree;
#line 401 "csl.walker.g"
	
	ASSERT(topUnitExpr.get(),"NULL top unit expr");
	params->push_back(topUnitExpr);
	
#line 10059 "CslTreeWalker.cpp"
	_t = __t22;
	_t = _t->getNextSibling();
#line 406 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_AUTO_GEN_MEM_MAP, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_TOP_UNIT, params);
	}
	
#line 10071 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_access_rights(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_access_rights_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 416 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr posExpr, upperExpr, mnExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 10086 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t26 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_ACCESS_RIGHTS);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 426 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 10109 "CslTreeWalker.cpp"
		}
		else {
			goto _loop28;
		}
		
	}
	_loop28:;
	} // ( ... )*
	posExpr=expression(_t);
	_t = _retTree;
#line 437 "csl.walker.g"
	
	ASSERT(posExpr.get(),"NULL enum expr");
	params->push_back(posExpr);
	
#line 10125 "CslTreeWalker.cpp"
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COLON:
	{
		antlr::RefCslAST tmp63_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COLON);
		_t = _t->getNextSibling();
		upperExpr=expression(_t);
		_t = _retTree;
#line 443 "csl.walker.g"
		
		params->push_back(upperExpr);
		
#line 10141 "CslTreeWalker.cpp"
		break;
	}
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	mnExpr=expression(_t);
	_t = _retTree;
#line 448 "csl.walker.g"
	
	params->push_back(mnExpr);
	
#line 10210 "CslTreeWalker.cpp"
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_ACCESS_RIGHT_READ:
	{
		antlr::RefCslAST tmp64_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ACCESS_RIGHT_READ);
		_t = _t->getNextSibling();
		break;
	}
	case K_ACCESS_RIGHT_WRITE:
	{
		antlr::RefCslAST tmp65_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ACCESS_RIGHT_WRITE);
		_t = _t->getNextSibling();
		break;
	}
	case K_ACCESS_RIGHT_READ_WRITE:
	{
		antlr::RefCslAST tmp66_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ACCESS_RIGHT_READ_WRITE);
		_t = _t->getNextSibling();
		break;
	}
	case K_ACCESS_RIGHT_NONE:
	{
		antlr::RefCslAST tmp67_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ACCESS_RIGHT_NONE);
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t26;
	_t = _t->getNextSibling();
#line 461 "csl.walker.g"
	
	DCERR("[ WARNING ] Walker: If you can read this, it means that this command: set_access_rights(range|number,expression,access_specifier), passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
	//if(hasIdentifier) {
	//  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_ACCESS_RIGHTS_ENUM, params);
	//}
	//else {
	//  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ACCESS_RIGHTS_ENUM, params);
	//}
	
#line 10261 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_access_rights_enum(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_access_rights_enum_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 472 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr enumExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool hasIdentifier = FALSE;
	
#line 10276 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t32 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_ACCESS_RIGHTS_ENUM);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 482 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 10299 "CslTreeWalker.cpp"
		}
		else {
			goto _loop34;
		}
		
	}
	_loop34:;
	} // ( ... )*
	enumExpr=expression(_t);
	_t = _retTree;
#line 493 "csl.walker.g"
	
	ASSERT(enumExpr.get(),"NULL enum expr");
	params->push_back(enumExpr);
	
#line 10315 "CslTreeWalker.cpp"
	_t = __t32;
	_t = _t->getNextSibling();
#line 499 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_ACCESS_RIGHTS_ENUM, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ACCESS_RIGHTS_ENUM, params);
	}
	
#line 10327 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_to_memory_map(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_to_memory_map_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 509 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr addrExpr,groupExpr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	EAccessRights accessRights;
	TBool hasIdentifier = FALSE;
	
#line 10343 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t36 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ADD_TO_MEMORY_MAP);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 520 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 10366 "CslTreeWalker.cpp"
		}
		else {
			goto _loop38;
		}
		
	}
	_loop38:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		addrExpr=expression(_t);
		_t = _retTree;
#line 532 "csl.walker.g"
		
		params->push_back(addrExpr);
		
#line 10437 "CslTreeWalker.cpp"
		{
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STRING:
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case EXPRESSION:
		case RANGE_EXPRESSION:
		case MINTYPMAX_EXPRESSION:
		case EXPR_PRIMARY_IDENTIFIER:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case FUNCTION_CALL_RET_ID:
		case FUNCTION_CALL_RET_EXPR:
		case EXPR_HYBRID:
		case SIZED_NUMBER:
		case K_CONCATENATION:
		case K_REPLICATION:
		{
			groupExpr=expression(_t);
			_t = _retTree;
#line 538 "csl.walker.g"
			
			params->push_back(groupExpr);
			
#line 10500 "CslTreeWalker.cpp"
			break;
		}
		case 3:
		case K_ACCESS_RIGHT_NONE:
		case K_ACCESS_RIGHT_READ:
		case K_ACCESS_RIGHT_WRITE:
		case K_ACCESS_RIGHT_READ_WRITE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_ACCESS_RIGHT_NONE:
		{
			antlr::RefCslAST tmp68_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ACCESS_RIGHT_NONE);
			_t = _t->getNextSibling();
#line 543 "csl.walker.g"
			accessRights = ACC_NONE;
#line 10528 "CslTreeWalker.cpp"
			break;
		}
		case K_ACCESS_RIGHT_READ:
		{
			antlr::RefCslAST tmp69_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ACCESS_RIGHT_READ);
			_t = _t->getNextSibling();
#line 544 "csl.walker.g"
			accessRights = ACC_R   ;
#line 10538 "CslTreeWalker.cpp"
			break;
		}
		case K_ACCESS_RIGHT_WRITE:
		{
			antlr::RefCslAST tmp70_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ACCESS_RIGHT_WRITE);
			_t = _t->getNextSibling();
#line 545 "csl.walker.g"
			accessRights = ACC_W   ;
#line 10548 "CslTreeWalker.cpp"
			break;
		}
		case K_ACCESS_RIGHT_READ_WRITE:
		{
			antlr::RefCslAST tmp71_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ACCESS_RIGHT_READ_WRITE);
			_t = _t->getNextSibling();
#line 546 "csl.walker.g"
			accessRights = ACC_RW  ;
#line 10558 "CslTreeWalker.cpp"
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t36;
	_t = _t->getNextSibling();
#line 550 "csl.walker.g"
	
	//WARNING waiting for CSLOmCmd support
	//if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_TO_MEM_MAP, params);
	//}
	//else {
	//CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_ADD_TO_MEM_MAP, params);
	//}
	
#line 10595 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_mnemonic(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_mnemonic_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 561 "csl.walker.g"
	
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr mnemonicExpr;
	TBool hasIdentifier = FALSE;
	
#line 10610 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t43 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_MNEMONIC);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 571 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 10633 "CslTreeWalker.cpp"
		}
		else {
			goto _loop45;
		}
		
	}
	_loop45:;
	} // ( ... )*
	mnemonicExpr=expression(_t);
	_t = _retTree;
#line 582 "csl.walker.g"
	
	ASSERT(mnemonicExpr.get(),"NULL enum expr");
	params->push_back(mnemonicExpr);
	
#line 10649 "CslTreeWalker.cpp"
	_t = __t43;
	_t = _t->getNextSibling();
#line 587 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_ASM_MNEMONIC, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_SET_ASM_MNEMONIC, params);
	}
	
#line 10661 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_decoder_name(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_decoder_name_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 598 "csl.walker.g"
	
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr decNameExpr;
	TBool hasIdentifier = FALSE;
	
#line 10676 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t47 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DECODER_NAME);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 608 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 10699 "CslTreeWalker.cpp"
		}
		else {
			goto _loop49;
		}
		
	}
	_loop49:;
	} // ( ... )*
	decNameExpr=expression(_t);
	_t = _retTree;
#line 619 "csl.walker.g"
	
	ASSERT(decNameExpr.get(),"NULL decNameExpr");
	params->push_back(decNameExpr);
	
#line 10715 "CslTreeWalker.cpp"
	_t = __t47;
	_t = _t->getNextSibling();
#line 624 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DECODER_NAME, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_SET_DECODER_NAME, params);
	}
	
#line 10727 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_decoder_out_name_prefix(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_decoder_out_name_prefix_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 634 "csl.walker.g"
	
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr decOutNamePrefixExpr;
	TBool hasIdentifier = FALSE;
	
#line 10742 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t51 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DECODER_OUT_NAME_PREFIX);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 644 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 10765 "CslTreeWalker.cpp"
		}
		else {
			goto _loop53;
		}
		
	}
	_loop53:;
	} // ( ... )*
	decOutNamePrefixExpr=expression(_t);
	_t = _retTree;
#line 655 "csl.walker.g"
	
	ASSERT(decOutNamePrefixExpr.get(),"NULL enum expr");
	params->push_back(decOutNamePrefixExpr);
	
#line 10781 "CslTreeWalker.cpp"
	_t = __t51;
	_t = _t->getNextSibling();
#line 660 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DECODER_OUT_NAME_PREFIX, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_SET_DECODER_OUT_NAME_PREFIX, params);
	}
	
#line 10793 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_set_decoder_out_name_suffix(antlr::RefCslAST _t) {
	antlr::RefCslAST command_set_decoder_out_name_suffix_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 670 "csl.walker.g"
	
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr decOutNameSuffixExpr;
	TBool hasIdentifier = FALSE;
	
#line 10808 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t55 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_DECODER_OUT_NAME_SUFFIX);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 680 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 10831 "CslTreeWalker.cpp"
		}
		else {
			goto _loop57;
		}
		
	}
	_loop57:;
	} // ( ... )*
	decOutNameSuffixExpr=expression(_t);
	_t = _retTree;
#line 691 "csl.walker.g"
	
	ASSERT(decOutNameSuffixExpr.get(),"NULL enum expr");
	params->push_back(decOutNameSuffixExpr);
	
#line 10847 "CslTreeWalker.cpp"
	_t = __t55;
	_t = _t->getNextSibling();
#line 696 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DECODER_OUT_NAME_SUFFIX, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_SET_DECODER_OUT_NAME_SUFFIX, params);
	}
	
#line 10859 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_print(antlr::RefCslAST _t) {
	antlr::RefCslAST command_print_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 706 "csl.walker.g"
	
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString, int> id;
	RefCSLOmExpr printExpr;
	TBool hasIdentifier = FALSE;
	
#line 10874 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t59 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PRINT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 716 "csl.walker.g"
			
			hasIdentifier = TRUE;
			if( scope.get() ) {
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 10897 "CslTreeWalker.cpp"
		}
		else {
			goto _loop61;
		}
		
	}
	_loop61:;
	} // ( ... )*
	printExpr=expression(_t);
	_t = _retTree;
#line 727 "csl.walker.g"
	
	ASSERT(printExpr.get(),"NULL enum expr");
	params->push_back(printExpr);
	
#line 10913 "CslTreeWalker.cpp"
	_t = __t59;
	_t = _t->getNextSibling();
#line 732 "csl.walker.g"
	
	if(hasIdentifier) {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_PRINT, params);
	}
	else {
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_PRINT, params);
	}
	
#line 10925 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::directive_register_group(antlr::RefCslAST _t) {
	antlr::RefCslAST directive_register_group_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 742 "csl.walker.g"
	
	std::pair<RefString, int> id;
	
#line 10935 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t63 = _t;
	antlr::RefCslAST tmp72_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REGISTER_GROUP);
	_t = _t->getFirstChild();
#line 748 "csl.walker.g"
	
	//call cmd
	
#line 10945 "CslTreeWalker.cpp"
	_t = __t63;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::directive_disconnect_register_fields_from_ios(antlr::RefCslAST _t) {
	antlr::RefCslAST directive_disconnect_register_fields_from_ios_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t65 = _t;
	antlr::RefCslAST tmp73_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DISCONNECT_REG_FIELDS_IOS);
	_t = _t->getFirstChild();
#line 757 "csl.walker.g"
	
	//call cmd
	
#line 10962 "CslTreeWalker.cpp"
	_t = __t65;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::directive_connect_register_fields_to_ios(antlr::RefCslAST _t) {
	antlr::RefCslAST directive_connect_register_fields_to_ios_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t67 = _t;
	antlr::RefCslAST tmp74_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CONNECT_REG_FIELDS_IOS);
	_t = _t->getFirstChild();
#line 766 "csl.walker.g"
	
	//call cmd
	
#line 10979 "CslTreeWalker.cpp"
	_t = __t67;
	_t = _t->getNextSibling();
	_retTree = _t;
}

pair<RefString, TULong>  CslTreeWalker::identifier(antlr::RefCslAST _t) {
#line 9116 "csl.walker.g"
	pair<RefString, TULong> res;
#line 10988 "CslTreeWalker.cpp"
	antlr::RefCslAST identifier_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST id = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	id = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),IDENTIFIER);
	_t = _t->getNextSibling();
#line 9118 "csl.walker.g"
	res = make_pair(_RS(id->getText()), id->getLine());
#line 10997 "CslTreeWalker.cpp"
	_retTree = _t;
	return res;
}

NSCSLOm::RefCSLOmExpr  CslTreeWalker::expression(antlr::RefCslAST _t) {
#line 8403 "csl.walker.g"
	NSCSLOm::RefCSLOmExpr expr;
#line 11005 "CslTreeWalker.cpp"
	antlr::RefCslAST expression_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST root01 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST opMinus = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST opNot = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root00 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root02 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root03 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root04 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root05 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root06 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root07 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root08 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root09 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root10 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root11 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root12 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root13 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root14 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root15 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root16 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root17 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root18 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root19 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root20 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root21 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root22 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root23 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root24 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root25 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root26 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root27 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root28 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root29 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root30 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root31 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root32 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root33 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root34 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST root35 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tokrange = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8403 "csl.walker.g"
	NSCSLOm::RefCSLOmExpr a,b,c,num,num2;
	TBool hasTwo = FALSE;
	TBool hasSecondExpr = FALSE;
	//used for this case: id[expression]
	RefCSLOmSimpleBitRange br = RefCSLOmSimpleBitRange();
	pair<RefString, TInt> id; 
	RefCSLOmExprLink exprLink;
	RefCSLOmExprLink scope;
	TBool negDirPartSel = FALSE;
	
#line 11057 "CslTreeWalker.cpp"
	
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case EXPRESSION:
	{
		antlr::RefCslAST __t991 = _t;
		antlr::RefCslAST tmp75_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EXPRESSION);
		_t = _t->getFirstChild();
		expr=expression(_t);
		_t = _retTree;
		_t = __t991;
		_t = _t->getNextSibling();
		break;
	}
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPR_PRIMARY_IDENTIFIER:
	case SIZED_NUMBER:
	{
		expr=expr_primary(_t);
		_t = _retTree;
		break;
	}
	case U_PLUS:
	{
		antlr::RefCslAST __t992 = _t;
		root01 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_PLUS);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		_t = __t992;
		_t = _t->getNextSibling();
#line 8417 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root01->getLine(), _RS(root01->getFilename()), CSLOmExprOp::OP_UNARY_ARITHMETIC_PLUS, a);
		
#line 11100 "CslTreeWalker.cpp"
		break;
	}
	case EXPR_HYBRID:
	{
		antlr::RefCslAST __t993 = _t;
		antlr::RefCslAST tmp76_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EXPR_HYBRID);
		_t = _t->getFirstChild();
		expr=expression_hybrid(_t);
		_t = _retTree;
		_t = __t993;
		_t = _t->getNextSibling();
		break;
	}
	case U_MINUS:
	{
		antlr::RefCslAST __t994 = _t;
		opMinus = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_MINUS);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		_t = __t994;
		_t = _t->getNextSibling();
#line 8423 "csl.walker.g"
		
		expr = CSLOmExprOp::build(opMinus->getLine(), _RS(opMinus->getFilename()), CSLOmExprOp::OP_UNARY_ARITHMETIC_MINUS, a);
		
#line 11129 "CslTreeWalker.cpp"
		break;
	}
	case LNOT:
	{
		antlr::RefCslAST __t995 = _t;
		opNot = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LNOT);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		_t = __t995;
		_t = _t->getNextSibling();
#line 8427 "csl.walker.g"
		
		expr = CSLOmExprOp::build(opNot->getLine(), _RS(opNot->getFilename()), CSLOmExprOp::OP_UNARY_LOGIC_NOT, a);
		
#line 11146 "CslTreeWalker.cpp"
		break;
	}
	case NOT:
	{
		antlr::RefCslAST __t996 = _t;
		root00 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NOT);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		_t = __t996;
		_t = _t->getNextSibling();
#line 8431 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root00->getLine(), _RS(root00->getFilename()), CSLOmExprOp::OP_UNARY_BITWISE_NOT, a);
		
#line 11163 "CslTreeWalker.cpp"
		break;
	}
	case U_AND:
	{
		antlr::RefCslAST __t997 = _t;
		root02 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_AND);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		_t = __t997;
		_t = _t->getNextSibling();
#line 8435 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root02->getLine(), _RS(root02->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_AND, a);
		
#line 11180 "CslTreeWalker.cpp"
		break;
	}
	case U_NAND:
	{
		antlr::RefCslAST __t998 = _t;
		root03 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_NAND);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		_t = __t998;
		_t = _t->getNextSibling();
#line 8439 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root03->getLine(), _RS(root03->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_NAND, a);
		
#line 11197 "CslTreeWalker.cpp"
		break;
	}
	case U_OR:
	{
		antlr::RefCslAST __t999 = _t;
		root04 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_OR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		_t = __t999;
		_t = _t->getNextSibling();
#line 8443 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root04->getLine(), _RS(root04->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_OR, a);
		
#line 11214 "CslTreeWalker.cpp"
		break;
	}
	case U_NOR:
	{
		antlr::RefCslAST __t1000 = _t;
		root05 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_NOR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		_t = __t1000;
		_t = _t->getNextSibling();
#line 8447 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root05->getLine(), _RS(root05->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_NOR, a);
		
#line 11231 "CslTreeWalker.cpp"
		break;
	}
	case U_XOR:
	{
		antlr::RefCslAST __t1001 = _t;
		root06 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_XOR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		_t = __t1001;
		_t = _t->getNextSibling();
#line 8451 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root06->getLine(), _RS(root06->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_XOR, a);
		
#line 11248 "CslTreeWalker.cpp"
		break;
	}
	case U_XNOR:
	{
		antlr::RefCslAST __t1002 = _t;
		root07 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_XNOR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		_t = __t1002;
		_t = _t->getNextSibling();
#line 8455 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root07->getLine(), _RS(root07->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_XNOR, a);
		
#line 11265 "CslTreeWalker.cpp"
		break;
	}
	case POW:
	{
		antlr::RefCslAST __t1003 = _t;
		root08 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),POW);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1003;
		_t = _t->getNextSibling();
#line 8459 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root08->getLine(), _RS(root08->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_POW, a ,b);
		
#line 11284 "CslTreeWalker.cpp"
		break;
	}
	case STAR:
	{
		antlr::RefCslAST __t1004 = _t;
		root09 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),STAR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1004;
		_t = _t->getNextSibling();
#line 8463 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root09->getLine(), _RS(root09->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY, a , b);
		
#line 11303 "CslTreeWalker.cpp"
		break;
	}
	case DIV:
	{
		antlr::RefCslAST __t1005 = _t;
		root10 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),DIV);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1005;
		_t = _t->getNextSibling();
#line 8467 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root10->getLine(), _RS(root10->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_DIV, a , b);
		
#line 11322 "CslTreeWalker.cpp"
		break;
	}
	case MOD:
	{
		antlr::RefCslAST __t1006 = _t;
		root11 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MOD);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1006;
		_t = _t->getNextSibling();
#line 8471 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root11->getLine(), _RS(root11->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_MOD, a , b);
		
#line 11341 "CslTreeWalker.cpp"
		break;
	}
	case PLUS:
	{
		antlr::RefCslAST __t1007 = _t;
		root12 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PLUS);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		{
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STRING:
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case EXPRESSION:
		case RANGE_EXPRESSION:
		case MINTYPMAX_EXPRESSION:
		case EXPR_PRIMARY_IDENTIFIER:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case FUNCTION_CALL_RET_ID:
		case FUNCTION_CALL_RET_EXPR:
		case EXPR_HYBRID:
		case SIZED_NUMBER:
		case K_CONCATENATION:
		case K_REPLICATION:
		{
			b=expression(_t);
			_t = _retTree;
#line 8474 "csl.walker.g"
			hasTwo = TRUE;
#line 11412 "CslTreeWalker.cpp"
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		_t = __t1007;
		_t = _t->getNextSibling();
#line 8475 "csl.walker.g"
		
		if(hasTwo){
		expr = CSLOmExprOp::build(root12->getLine(), _RS(root12->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_PLUS, a , b);
		}
		else {
		expr = CSLOmExprOp::build(root12->getLine(), _RS(root12->getFilename()), CSLOmExprOp::OP_UNARY_ARITHMETIC_PLUS, a);
		}
		
#line 11436 "CslTreeWalker.cpp"
		break;
	}
	case MINUS:
	{
		antlr::RefCslAST __t1009 = _t;
		root13 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MINUS);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		{
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STRING:
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case EXPRESSION:
		case RANGE_EXPRESSION:
		case MINTYPMAX_EXPRESSION:
		case EXPR_PRIMARY_IDENTIFIER:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case FUNCTION_CALL_RET_ID:
		case FUNCTION_CALL_RET_EXPR:
		case EXPR_HYBRID:
		case SIZED_NUMBER:
		case K_CONCATENATION:
		case K_REPLICATION:
		{
			b=expression(_t);
			_t = _retTree;
#line 8483 "csl.walker.g"
			hasTwo = TRUE;
#line 11507 "CslTreeWalker.cpp"
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		_t = __t1009;
		_t = _t->getNextSibling();
#line 8484 "csl.walker.g"
		
		if(hasTwo){
		expr = CSLOmExprOp::build(root13->getLine(), _RS(root13->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS, a , b);
		}
		else {
		expr = CSLOmExprOp::build(root13->getLine(), _RS(root13->getFilename()), CSLOmExprOp::OP_UNARY_ARITHMETIC_MINUS, a);
		}
		hasTwo = FALSE;
		
#line 11532 "CslTreeWalker.cpp"
		break;
	}
	case SL:
	{
		antlr::RefCslAST __t1011 = _t;
		root14 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SL);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1011;
		_t = _t->getNextSibling();
#line 8494 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root14->getLine(), _RS(root14->getFilename()), CSLOmExprOp::OP_BINARY_SHIFT_LEFT, a , b);
		
#line 11551 "CslTreeWalker.cpp"
		break;
	}
	case SSL:
	{
		antlr::RefCslAST __t1012 = _t;
		root15 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SSL);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1012;
		_t = _t->getNextSibling();
#line 8498 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root15->getLine(), _RS(root15->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT, a , b);
		
#line 11570 "CslTreeWalker.cpp"
		break;
	}
	case SR:
	{
		antlr::RefCslAST __t1013 = _t;
		root16 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1013;
		_t = _t->getNextSibling();
#line 8502 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root16->getLine(), _RS(root16->getFilename()), CSLOmExprOp::OP_BINARY_SHIFT_RIGHT, a , b);
		
#line 11589 "CslTreeWalker.cpp"
		break;
	}
	case SSR:
	{
		antlr::RefCslAST __t1014 = _t;
		root17 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SSR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1014;
		_t = _t->getNextSibling();
#line 8506 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root17->getLine(), _RS(root17->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT, a , b);
		
#line 11608 "CslTreeWalker.cpp"
		break;
	}
	case LT_:
	{
		antlr::RefCslAST __t1015 = _t;
		root18 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LT_);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1015;
		_t = _t->getNextSibling();
#line 8510 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root18->getLine(), _RS(root18->getFilename()), CSLOmExprOp::OP_BINARY_RELATIONAL_LESS, a , b);
		
#line 11627 "CslTreeWalker.cpp"
		break;
	}
	case GT:
	{
		antlr::RefCslAST __t1016 = _t;
		root19 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GT);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1016;
		_t = _t->getNextSibling();
#line 8514 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root19->getLine(), _RS(root19->getFilename()), CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER, a, b);
		
#line 11646 "CslTreeWalker.cpp"
		break;
	}
	case LE:
	{
		antlr::RefCslAST __t1017 = _t;
		root20 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LE);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1017;
		_t = _t->getNextSibling();
#line 8518 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root20->getLine(), _RS(root20->getFilename()), CSLOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL, a, b);
		
#line 11665 "CslTreeWalker.cpp"
		break;
	}
	case GE:
	{
		antlr::RefCslAST __t1018 = _t;
		root21 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GE);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1018;
		_t = _t->getNextSibling();
#line 8522 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root21->getLine(), _RS(root21->getFilename()), CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL, a, b);
		
#line 11684 "CslTreeWalker.cpp"
		break;
	}
	case EQUAL:
	{
		antlr::RefCslAST __t1019 = _t;
		root22 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EQUAL);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1019;
		_t = _t->getNextSibling();
#line 8526 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root22->getLine(), _RS(root22->getFilename()), CSLOmExprOp::OP_BINARY_EQUALITY_EQ, a, b);
		
#line 11703 "CslTreeWalker.cpp"
		break;
	}
	case NOT_EQ:
	{
		antlr::RefCslAST __t1020 = _t;
		root23 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NOT_EQ);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1020;
		_t = _t->getNextSibling();
#line 8530 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root23->getLine(), _RS(root23->getFilename()), CSLOmExprOp::OP_BINARY_EQUALITY_NOT_EQ, a, b);
		
#line 11722 "CslTreeWalker.cpp"
		break;
	}
	case NOT_EQ_CASE:
	{
		antlr::RefCslAST __t1021 = _t;
		root24 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NOT_EQ_CASE);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1021;
		_t = _t->getNextSibling();
#line 8534 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root24->getLine(), _RS(root24->getFilename()), CSLOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE, a, b);
		
#line 11741 "CslTreeWalker.cpp"
		break;
	}
	case EQ_CASE:
	{
		antlr::RefCslAST __t1022 = _t;
		root25 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EQ_CASE);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1022;
		_t = _t->getNextSibling();
#line 8538 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root25->getLine(), _RS(root25->getFilename()), CSLOmExprOp::OP_BINARY_IDENTITY_EQ_CASE, a, b);
		
#line 11760 "CslTreeWalker.cpp"
		break;
	}
	case AND:
	{
		antlr::RefCslAST __t1023 = _t;
		root26 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),AND);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1023;
		_t = _t->getNextSibling();
#line 8542 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root26->getLine(), _RS(root26->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_AND, a, b);
		
#line 11779 "CslTreeWalker.cpp"
		break;
	}
	case NAND:
	{
		antlr::RefCslAST __t1024 = _t;
		root27 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NAND);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1024;
		_t = _t->getNextSibling();
#line 8546 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root27->getLine(), _RS(root27->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_NAND, a, b);
		
#line 11798 "CslTreeWalker.cpp"
		break;
	}
	case XOR:
	{
		antlr::RefCslAST __t1025 = _t;
		root28 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),XOR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1025;
		_t = _t->getNextSibling();
#line 8550 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root28->getLine(), _RS(root28->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_XOR, a, b);
		
#line 11817 "CslTreeWalker.cpp"
		break;
	}
	case XNOR:
	{
		antlr::RefCslAST __t1026 = _t;
		root29 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),XNOR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1026;
		_t = _t->getNextSibling();
#line 8554 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root29->getLine(), _RS(root29->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_XNOR, a, b);
		
#line 11836 "CslTreeWalker.cpp"
		break;
	}
	case OR:
	{
		antlr::RefCslAST __t1027 = _t;
		root30 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),OR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1027;
		_t = _t->getNextSibling();
#line 8558 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root30->getLine(), _RS(root30->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_OR, a, b);
		
#line 11855 "CslTreeWalker.cpp"
		break;
	}
	case NOR:
	{
		antlr::RefCslAST __t1028 = _t;
		root31 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NOR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1028;
		_t = _t->getNextSibling();
#line 8562 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root31->getLine(), _RS(root31->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_NOR, a, b);
		
#line 11874 "CslTreeWalker.cpp"
		break;
	}
	case LAND:
	{
		antlr::RefCslAST __t1029 = _t;
		root32 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LAND);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1029;
		_t = _t->getNextSibling();
#line 8566 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root32->getLine(), _RS(root32->getFilename()), CSLOmExprOp::OP_BINARY_LOGIC_AND, a, b);
		
#line 11893 "CslTreeWalker.cpp"
		break;
	}
	case LOR:
	{
		antlr::RefCslAST __t1030 = _t;
		root33 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LOR);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		_t = __t1030;
		_t = _t->getNextSibling();
#line 8570 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root33->getLine(), _RS(root33->getFilename()), CSLOmExprOp::OP_BINARY_LOGIC_OR, a, b);
		
#line 11912 "CslTreeWalker.cpp"
		break;
	}
	case QUESTION:
	{
		antlr::RefCslAST __t1031 = _t;
		root34 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),QUESTION);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		b=expression(_t);
		_t = _retTree;
		c=expression(_t);
		_t = _retTree;
		_t = __t1031;
		_t = _t->getNextSibling();
#line 8574 "csl.walker.g"
		
		expr = CSLOmExprOp::build(root34->getLine(), _RS(root34->getFilename()), CSLOmExprOp::OP_TERNARY_COND, a, b, c);
		
#line 11933 "CslTreeWalker.cpp"
		break;
	}
	case MINTYPMAX_EXPRESSION:
	{
		antlr::RefCslAST __t1032 = _t;
		antlr::RefCslAST tmp77_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MINTYPMAX_EXPRESSION);
		_t = _t->getFirstChild();
		a=expression(_t);
		_t = _retTree;
		{
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STRING:
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case EXPRESSION:
		case RANGE_EXPRESSION:
		case MINTYPMAX_EXPRESSION:
		case EXPR_PRIMARY_IDENTIFIER:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case FUNCTION_CALL_RET_ID:
		case FUNCTION_CALL_RET_EXPR:
		case EXPR_HYBRID:
		case SIZED_NUMBER:
		case K_CONCATENATION:
		case K_REPLICATION:
		{
			b=expression(_t);
			_t = _retTree;
			c=expression(_t);
			_t = _retTree;
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		_t = __t1032;
		_t = _t->getNextSibling();
		break;
	}
	case K_CONCATENATION:
	{
		expr=concatenation(_t);
		_t = _retTree;
		break;
	}
	case K_REPLICATION:
	{
		expr=multiple_concatenation(_t);
		_t = _retTree;
		break;
	}
	case FUNCTION_CALL_RET_ID:
	{
		expr=function_call_ret_id(_t);
		_t = _retTree;
		break;
	}
	case FUNCTION_CALL_RET_EXPR:
	{
		expr=function_call_ret_expr(_t);
		_t = _retTree;
		break;
	}
	case RANGE_EXPRESSION:
	{
		antlr::RefCslAST __t1034 = _t;
		root35 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),RANGE_EXPRESSION);
		_t = _t->getFirstChild();
		{ // ( ... )*
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER)) {
				tokrange = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
				id=identifier(_t);
				_t = _retTree;
#line 8591 "csl.walker.g"
				
				if( scope.get() ){
				scope->addHidItem( id.first );
				}
				else {
				scope = CSLOmExprLink::build( id.second, _RS(tokrange->getFilename()), id.first );
				}
				
#line 12067 "CslTreeWalker.cpp"
			}
			else {
				goto _loop1036;
			}
			
		}
		_loop1036:;
		} // ( ... )*
		num=expression(_t);
		_t = _retTree;
		{
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case COLON:
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case PO_NEG:
		case STRING:
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case EXPRESSION:
		case RANGE_EXPRESSION:
		case MINTYPMAX_EXPRESSION:
		case EXPR_PRIMARY_IDENTIFIER:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case FUNCTION_CALL_RET_ID:
		case FUNCTION_CALL_RET_EXPR:
		case EXPR_HYBRID:
		case SIZED_NUMBER:
		case K_CONCATENATION:
		case K_REPLICATION:
		{
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case COLON:
			{
				antlr::RefCslAST tmp78_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COLON);
				_t = _t->getNextSibling();
				break;
			}
			case PO_NEG:
			{
				antlr::RefCslAST tmp79_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PO_NEG);
				_t = _t->getNextSibling();
#line 8600 "csl.walker.g"
				negDirPartSel = TRUE;
#line 12154 "CslTreeWalker.cpp"
				break;
			}
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			num2=expression(_t);
			_t = _retTree;
#line 8600 "csl.walker.g"
			hasSecondExpr = TRUE;
#line 12221 "CslTreeWalker.cpp"
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		_t = __t1034;
		_t = _t->getNextSibling();
#line 8601 "csl.walker.g"
		
		//exprLink = CSLOmExprLink::build(id.second, _RS(#tokrange->getFilename()), id.first);
		if(!hasSecondExpr){
		br = CSLOmSimpleBitRange::build(id.second, _RS(tokrange->getFilename()), design, RefString(new std::string("")), num, num);
		}
		else{
		br = CSLOmSimpleBitRange::build(root35->getLine(), _RS(root35->getFilename()), design, RefString(new std::string("")), num, num2);
		}
		//exprLink->setBitRange(br);
		scope->setBitRange(br);
		if (negDirPartSel) {
		scope->setPartSelectDir(CSLOmExprLink::PS_DIR_DESC);
		}
		expr = scope;
		
#line 12252 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
	return expr;
}

void CslTreeWalker::command_add_logic_programmable_depth(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_programmable_depth_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 866 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 12272 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t77 = _t;
	tok1 = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PROGRAMMABLE_DEPTH);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
#line 872 "csl.walker.g"
	
	//call cmd
	
#line 12284 "CslTreeWalker.cpp"
	_t = __t77;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_priority_bypass(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_priority_bypass_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t79 = _t;
	antlr::RefCslAST tmp80_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PRIORITY_BYPASS);
	_t = _t->getFirstChild();
#line 881 "csl.walker.g"
	
	//call cmd
	
#line 12301 "CslTreeWalker.cpp"
	_t = __t79;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_sync_fifo(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_sync_fifo_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t81 = _t;
	antlr::RefCslAST tmp81_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SYNC_FIFO);
	_t = _t->getFirstChild();
#line 890 "csl.walker.g"
	
	//call cmd
	
#line 12318 "CslTreeWalker.cpp"
	_t = __t81;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_asynch_fifo(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_asynch_fifo_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 896 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 12333 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t83 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ASYNC_FIFO);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 905 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 12354 "CslTreeWalker.cpp"
		}
		else {
			goto _loop85;
		}
		
	}
	_loop85:;
	} // ( ... )*
#line 913 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_FIFO_SET_ASYNCH, params);
	
#line 12367 "CslTreeWalker.cpp"
	_t = __t83;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_depth_extend(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_depth_extend_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 919 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 12379 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t87 = _t;
	antlr::RefCslAST tmp82_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DEPTH_EXTEND);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
#line 926 "csl.walker.g"
	
	//call cmd
	
#line 12391 "CslTreeWalker.cpp"
	_t = __t87;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_width_extend(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_width_extend_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 932 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 12403 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t89 = _t;
	antlr::RefCslAST tmp83_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WIDTH_EXTEND);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
#line 939 "csl.walker.g"
	
	//call cmd
	
#line 12415 "CslTreeWalker.cpp"
	_t = __t89;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_wr_hold(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_wr_hold_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 945 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 12427 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t91 = _t;
	antlr::RefCslAST tmp84_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WR_HOLD);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
#line 952 "csl.walker.g"
	
	//call cmd
	
#line 12439 "CslTreeWalker.cpp"
	_t = __t91;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_parallel_output(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_parallel_output_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t93 = _t;
	antlr::RefCslAST tmp85_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PARALLEL_OUTPUT);
	_t = _t->getFirstChild();
	{
	antlr::RefCslAST tmp86_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ALL);
	_t = _t->getNextSibling();
#line 963 "csl.walker.g"
	
	//call cmd for all
	
#line 12460 "CslTreeWalker.cpp"
	}
	_t = __t93;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_parallel_input(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_parallel_input_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t96 = _t;
	antlr::RefCslAST tmp87_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PARALLEL_INPUT);
	_t = _t->getFirstChild();
	{
	antlr::RefCslAST tmp88_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ALL);
	_t = _t->getNextSibling();
#line 980 "csl.walker.g"
	
	//call cmd for all
	
#line 12482 "CslTreeWalker.cpp"
	}
	_t = __t96;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_rd_words(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_rd_words_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t99 = _t;
	antlr::RefCslAST tmp89_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RD_WORDS);
	_t = _t->getFirstChild();
#line 996 "csl.walker.g"
	
	//call cmd
	
#line 12500 "CslTreeWalker.cpp"
	_t = __t99;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_wr_words(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_wr_words_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t101 = _t;
	antlr::RefCslAST tmp90_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WR_WORDS);
	_t = _t->getFirstChild();
#line 1006 "csl.walker.g"
	
	//call cmd
	
#line 12517 "CslTreeWalker.cpp"
	_t = __t101;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_sram_rd(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_sram_rd_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t103 = _t;
	antlr::RefCslAST tmp91_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SRAM_RD);
	_t = _t->getFirstChild();
#line 1015 "csl.walker.g"
	
	//call cmd
	
#line 12534 "CslTreeWalker.cpp"
	_t = __t103;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_sram_wr(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_sram_wr_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t105 = _t;
	antlr::RefCslAST tmp92_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SRAM_WR);
	_t = _t->getFirstChild();
#line 1024 "csl.walker.g"
	
	//call cmd
	
#line 12551 "CslTreeWalker.cpp"
	_t = __t105;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_pushback(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_pushback_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t107 = _t;
	antlr::RefCslAST tmp93_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PUSHBACK);
	_t = _t->getFirstChild();
#line 1033 "csl.walker.g"
	
	//call cmd
	
#line 12568 "CslTreeWalker.cpp"
	_t = __t107;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_flow_through(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_flow_through_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1039 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 12584 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t109 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FLOW_THROUGH);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1049 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 12605 "CslTreeWalker.cpp"
		}
		else {
			goto _loop111;
		}
		
	}
	_loop111:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 1058 "csl.walker.g"
	
	params->push_back(expr);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_FIFO_FLOW_THROUGH, params);
	
#line 12621 "CslTreeWalker.cpp"
	_t = __t109;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_stall(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_stall_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t210 = _t;
	antlr::RefCslAST tmp94_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_STALL);
	_t = _t->getFirstChild();
#line 1729 "csl.walker.g"
	
	//call cmd
	
#line 12638 "CslTreeWalker.cpp"
	_t = __t210;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_stall_rd_side(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_stall_rd_side_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t212 = _t;
	antlr::RefCslAST tmp95_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_STALL_RD_SIDE);
	_t = _t->getFirstChild();
#line 1738 "csl.walker.g"
	
	//call cmd
	
#line 12655 "CslTreeWalker.cpp"
	_t = __t212;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_stall_wr_side(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_stall_wr_side_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t214 = _t;
	antlr::RefCslAST tmp96_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_STALL_WR_SIDE);
	_t = _t->getFirstChild();
#line 1747 "csl.walker.g"
	
	//call cmd
	
#line 12672 "CslTreeWalker.cpp"
	_t = __t214;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_wr_release(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_wr_release_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t216 = _t;
	antlr::RefCslAST tmp97_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WR_RELEASE);
	_t = _t->getFirstChild();
#line 1756 "csl.walker.g"
	
	//call cmd
	
#line 12689 "CslTreeWalker.cpp"
	_t = __t216;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_almost_empty(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_almost_empty_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1762 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 12701 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t218 = _t;
	antlr::RefCslAST tmp98_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ALMOST_EMPTY);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
#line 1769 "csl.walker.g"
	
	//call cmd
	
#line 12713 "CslTreeWalker.cpp"
	_t = __t218;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_almost_full(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_almost_full_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1775 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 12725 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t220 = _t;
	antlr::RefCslAST tmp99_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ALMOST_FULL);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
#line 1782 "csl.walker.g"
	
	//call cmd
	
#line 12737 "CslTreeWalker.cpp"
	_t = __t220;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_output_wr_addr(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_output_wr_addr_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1788 "csl.walker.g"
	
	pair<RefString, int> id;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	
#line 12752 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t222 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OUTPUT_WR_ADDR);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1796 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}       
			
#line 12774 "CslTreeWalker.cpp"
		}
		else {
			goto _loop224;
		}
		
	}
	_loop224:;
	} // ( ... )*
#line 1805 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_FIFO_ADD_OUT_WR_ADDR, params);
	
#line 12787 "CslTreeWalker.cpp"
	_t = __t222;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_output_rd_addr(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_output_rd_addr_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1811 "csl.walker.g"
	
	pair<RefString, int> id;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	
#line 12802 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t226 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OUTPUT_RD_ADDR);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1819 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}       
			
#line 12824 "CslTreeWalker.cpp"
		}
		else {
			goto _loop228;
		}
		
	}
	_loop228:;
	} // ( ... )*
#line 1828 "csl.walker.g"
	
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_FIFO_ADD_OUT_RD_ADDR, params);
	
#line 12837 "CslTreeWalker.cpp"
	_t = __t226;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_credit(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_credit_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t230 = _t;
	antlr::RefCslAST tmp100_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CREDIT);
	_t = _t->getFirstChild();
#line 1837 "csl.walker.g"
	
	//call cmd
	
#line 12854 "CslTreeWalker.cpp"
	_t = __t230;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_rd_credit(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_rd_credit_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t232 = _t;
	antlr::RefCslAST tmp101_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RD_CREDIT);
	_t = _t->getFirstChild();
#line 1846 "csl.walker.g"
	
	//call cmd
	
#line 12871 "CslTreeWalker.cpp"
	_t = __t232;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_wr_credit(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_wr_credit_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t234 = _t;
	antlr::RefCslAST tmp102_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WR_CREDIT);
	_t = _t->getFirstChild();
#line 1855 "csl.walker.g"
	
	//call cmd
	
#line 12888 "CslTreeWalker.cpp"
	_t = __t234;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_flow(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_flow_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t236 = _t;
	antlr::RefCslAST tmp103_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FLOW);
	_t = _t->getFirstChild();
#line 1864 "csl.walker.g"
	
	//call cmd
	
#line 12905 "CslTreeWalker.cpp"
	_t = __t236;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_unit_address_decoder(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_unit_address_decoder_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1065 "csl.walker.g"
	
	//Incomplete
	//WARNING - waiting for cmd support
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 12919 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t113 = _t;
	antlr::RefCslAST tmp104_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_UNIT_ADDRESS_DECODER);
	_t = _t->getFirstChild();
	{
	expr=expression(_t);
	_t = _retTree;
#line 1073 "csl.walker.g"
	
	DCERR("[ WARNING ] Walker: If you can read this, it means that this command: add_logic(unit_address_decoder,expression), passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
	//WARNING - waiting for cmd support
	
#line 12933 "CslTreeWalker.cpp"
	}
	_t = __t113;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_read_valid(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_read_valid_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1081 "csl.walker.g"
	
	//Incomplete
	//WARNING - waiting for cmd support
	
#line 12947 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t116 = _t;
	antlr::RefCslAST tmp105_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_READ_VALID);
	_t = _t->getFirstChild();
#line 1088 "csl.walker.g"
	
	DCERR("[ WARNING ] Walker: If you can read this, it means that this command: add_logic(read_valid), passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
	//WARNING - waiting for cmd support
	
#line 12958 "CslTreeWalker.cpp"
	_t = __t116;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_async_reset(antlr::RefCslAST _t) {
	antlr::RefCslAST command_async_reset_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1095 "csl.walker.g"
	
	//Incomplete
	//WARNING - waiting for cmd support
	
#line 12971 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t118 = _t;
	antlr::RefCslAST tmp106_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ASYNC_RESET);
	_t = _t->getFirstChild();
#line 1102 "csl.walker.g"
	
	DCERR("[ WARNING ] Walker: If you can read this, it means that this command: add_logic(async_reset), passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
	//WARNING - waiting for cmd support
	
#line 12982 "CslTreeWalker.cpp"
	_t = __t118;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_neg_output(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_neg_output_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1109 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 12997 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t120 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NEG_OUTPUT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1118 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13018 "CslTreeWalker.cpp"
		}
		else {
			goto _loop122;
		}
		
	}
	_loop122:;
	} // ( ... )*
#line 1126 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_NEG_OUTPUT);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_NEG_OUTPUT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13033 "CslTreeWalker.cpp"
	_t = __t120;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_serial_input(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_serial_input_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1134 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 13048 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t124 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SERIAL_INPUT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1143 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13069 "CslTreeWalker.cpp"
		}
		else {
			goto _loop126;
		}
		
	}
	_loop126:;
	} // ( ... )*
#line 1151 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_SERIAL_INPUT);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_SERIAL_INPUT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13084 "CslTreeWalker.cpp"
	_t = __t124;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_serial_output(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_serial_output_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1159 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 13099 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t128 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SERIAL_OUTPUT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1168 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13120 "CslTreeWalker.cpp"
		}
		else {
			goto _loop130;
		}
		
	}
	_loop130:;
	} // ( ... )*
#line 1176 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_SERIAL_OUTPUT);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_SERIAL_OUTPUT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13135 "CslTreeWalker.cpp"
	_t = __t128;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_set(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_set_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1397 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 13151 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t161 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1407 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13172 "CslTreeWalker.cpp"
		}
		else {
			goto _loop163;
		}
		
	}
	_loop163:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr=expression(_t);
		_t = _retTree;
#line 1417 "csl.walker.g"
		
		params->push_back(expr);
		
#line 13243 "CslTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1421 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_SET);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_SET, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13262 "CslTreeWalker.cpp"
	_t = __t161;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_reset(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_reset_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1429 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 13278 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t166 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RESET);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1439 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13299 "CslTreeWalker.cpp"
		}
		else {
			goto _loop168;
		}
		
	}
	_loop168:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr=expression(_t);
		_t = _retTree;
#line 1449 "csl.walker.g"
		
		params->push_back(expr);
		
#line 13370 "CslTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1453 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_RESET);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_RESET, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13389 "CslTreeWalker.cpp"
	_t = __t166;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_init(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_init_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1461 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 13405 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t171 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INIT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1470 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13426 "CslTreeWalker.cpp"
		}
		else {
			goto _loop173;
		}
		
	}
	_loop173:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr=expression(_t);
		_t = _retTree;
#line 1480 "csl.walker.g"
		
		params->push_back(expr);
		
#line 13497 "CslTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1484 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_INIT);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_INIT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13516 "CslTreeWalker.cpp"
	_t = __t171;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_clear(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_clear_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1492 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 13532 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t176 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CLEAR);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1501 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13553 "CslTreeWalker.cpp"
		}
		else {
			goto _loop178;
		}
		
	}
	_loop178:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr=expression(_t);
		_t = _retTree;
#line 1511 "csl.walker.g"
		
		params->push_back(expr);
		
#line 13624 "CslTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1515 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_CLEAR);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_CLEAR, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13643 "CslTreeWalker.cpp"
	_t = __t176;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_gray_output(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_gray_output_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1184 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 13658 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t132 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GRAY_OUTPUT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1193 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13679 "CslTreeWalker.cpp"
		}
		else {
			goto _loop134;
		}
		
	}
	_loop134:;
	} // ( ... )*
#line 1201 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_GRAY_OUTPUT);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_GRAY_OUTPUT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13694 "CslTreeWalker.cpp"
	_t = __t132;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_start_value(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_start_value_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1209 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 13710 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t136 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_START_VALUE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1219 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13731 "CslTreeWalker.cpp"
		}
		else {
			goto _loop138;
		}
		
	}
	_loop138:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 1228 "csl.walker.g"
	
	params->push_back(expr);
	
#line 13746 "CslTreeWalker.cpp"
	_t = __t136;
	_t = _t->getNextSibling();
#line 1232 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_START_VALUE);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_START_VALUE, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13755 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_end_value(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_end_value_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1239 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 13769 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t140 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_END_VALUE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1249 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13790 "CslTreeWalker.cpp"
		}
		else {
			goto _loop142;
		}
		
	}
	_loop142:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 1258 "csl.walker.g"
	
	params->push_back(expr);
	
#line 13805 "CslTreeWalker.cpp"
	_t = __t140;
	_t = _t->getNextSibling();
#line 1262 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_END_VALUE);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_END_VALUE, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13814 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_count_amount(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_count_amount_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1269 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 13828 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t144 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_COUNT_AMOUNT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1279 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13849 "CslTreeWalker.cpp"
		}
		else {
			goto _loop146;
		}
		
	}
	_loop146:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 1288 "csl.walker.g"
	
	params->push_back(expr);
	
#line 13864 "CslTreeWalker.cpp"
	_t = __t144;
	_t = _t->getNextSibling();
#line 1292 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_COUNT_AMMOUNT);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_COUNT_AMMOUNT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13873 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_direction_control(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_direction_control_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1299 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 13887 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t148 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DIRECTION_CONTROL);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1309 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13908 "CslTreeWalker.cpp"
		}
		else {
			goto _loop150;
		}
		
	}
	_loop150:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 1318 "csl.walker.g"
	
	params->push_back(expr);
	
#line 13923 "CslTreeWalker.cpp"
	_t = __t148;
	_t = _t->getNextSibling();
#line 1322 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_DIR_CONTROL);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_DIR_CONTROL, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 13932 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_count_direction(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_count_direction_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1329 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	CSLOmRegDeclInfo::ERegDeclCntDir countDir = CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UNDEF;
	
#line 13946 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t152 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_COUNT_DIRECTION);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1339 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 13967 "CslTreeWalker.cpp"
		}
		else {
			goto _loop154;
		}
		
	}
	_loop154:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_UP:
	{
		antlr::RefCslAST tmp107_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_UP);
		_t = _t->getNextSibling();
#line 1348 "csl.walker.g"
		countDir = CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP  ;
#line 13987 "CslTreeWalker.cpp"
		break;
	}
	case K_DOWN:
	{
		antlr::RefCslAST tmp108_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DOWN);
		_t = _t->getNextSibling();
#line 1349 "csl.walker.g"
		countDir = CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN;
#line 13997 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1351 "csl.walker.g"
	
	//CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_COUNT_DIRECTION);
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_COUNT_DIRECTION, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmCmdAddLogic::addEnumParam(countDir, NSCSLOm::TYPE_CMD_ADD_LOGIC);      
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 14013 "CslTreeWalker.cpp"
	_t = __t152;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_load(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_load_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1361 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
#line 14028 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t157 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_LOAD);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1370 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 14049 "CslTreeWalker.cpp"
		}
		else {
			goto _loop159;
		}
		
	}
	_loop159:;
	} // ( ... )*
#line 1378 "csl.walker.g"
	
	CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_LOAD, NSCSLOm::TYPE_CMD_ADD_LOGIC);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
	
#line 14063 "CslTreeWalker.cpp"
	_t = __t157;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_inject_stalls(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_inject_stalls_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1523 "csl.walker.g"
	
	//Incomplete
	//WARNING - waiting for cmd support
	
#line 14076 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t181 = _t;
	antlr::RefCslAST tmp109_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INJECT_STALLS);
	_t = _t->getFirstChild();
#line 1530 "csl.walker.g"
	
	DCERR("[ WARNING ] Walker: If you can read this, it means that this command: add_logic(inject_stalls), passed but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
	//WARNING - waiting for cmd support
	
#line 14087 "CslTreeWalker.cpp"
	_t = __t181;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_simulation_timeout_counter(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_simulation_timeout_counter_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1537 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
	
#line 14104 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t183 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIMULATION_TIMEOUT_COUNTER);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1547 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 14125 "CslTreeWalker.cpp"
		}
		else {
			goto _loop185;
		}
		
	}
	_loop185:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 1556 "csl.walker.g"
	
	params->push_back(expr);
	
#line 14140 "CslTreeWalker.cpp"
	_t = __t183;
	_t = _t->getNextSibling();
#line 1560 "csl.walker.g"
	
	CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::TB_OPER_SIM_TIMEOUT_COUNTER);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_TB_ADD_LOGIC, params);
	
#line 14148 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_stall_generation(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_stall_generation_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1567 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	
	
#line 14163 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t187 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_STALL_GENERATION);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1577 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 14184 "CslTreeWalker.cpp"
		}
		else {
			goto _loop189;
		}
		
	}
	_loop189:;
	} // ( ... )*
	expr=expression(_t);
	_t = _retTree;
#line 1586 "csl.walker.g"
	
	params->push_back(expr);
	
#line 14199 "CslTreeWalker.cpp"
	_t = __t187;
	_t = _t->getNextSibling();
#line 1590 "csl.walker.g"
	
	CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::TB_OPER_STALL_GENERATION);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_TB_ADD_LOGIC, params);
	
#line 14207 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_generate_waves(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_generate_waves_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST label = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1597 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr1, expr2;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	CSLOmTBInfo::ETBWaveType mWaveType = CSLOmTBInfo::TB_WAVE_UNDEF;
	
#line 14223 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t191 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GENERATE_WAVES);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1607 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 14244 "CslTreeWalker.cpp"
		}
		else {
			goto _loop193;
		}
		
	}
	_loop193:;
	} // ( ... )*
	label = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	expr1=expression(_t);
	_t = _retTree;
#line 1617 "csl.walker.g"
	
	params->push_back(expr1);
	
#line 14260 "CslTreeWalker.cpp"
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_WAVE_TYPE_FSDB:
	{
		antlr::RefCslAST tmp110_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WAVE_TYPE_FSDB);
		_t = _t->getNextSibling();
#line 1621 "csl.walker.g"
		mWaveType = CSLOmTBInfo::TB_WAVE_FSDB;
#line 14272 "CslTreeWalker.cpp"
		break;
	}
	case K_WAVE_TYPE_VCD:
	{
		antlr::RefCslAST tmp111_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WAVE_TYPE_VCD);
		_t = _t->getNextSibling();
#line 1623 "csl.walker.g"
		mWaveType = CSLOmTBInfo::TB_WAVE_VSD ;
#line 14282 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			expr2=expression(_t);
			_t = _retTree;
#line 1627 "csl.walker.g"
			
			params->push_back(expr2);
			
#line 14302 "CslTreeWalker.cpp"
		}
		else {
			goto _loop196;
		}
		
	}
	_loop196:;
	} // ( ... )*
	_t = __t191;
	_t = _t->getNextSibling();
#line 1632 "csl.walker.g"
	
	CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::TB_OPER_GENERATE_WAVES);
	CSLOmCmdTBAddLogic::setWaveType(mWaveType);
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_TB_ADD_LOGIC, params);
	
#line 14319 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_clock(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_clock_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1640 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefCSLOmExpr expr1, expr2;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	CSLOmTBInfo::ETBTimeBase mTimeBase = CSLOmTBInfo::TB_TIMEBASE_UNDEF;
	//flag to see if it's called in testbench where 
	//the optional parameters are mandatory
	TBool isInTestBench = FALSE; 
	
	
#line 14338 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t198 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CLOCK_SIGNAL);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1655 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 14359 "CslTreeWalker.cpp"
		}
		else {
			goto _loop200;
		}
		
	}
	_loop200:;
	} // ( ... )*
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr1=expression(_t);
		_t = _retTree;
		expr2=expression(_t);
		_t = _retTree;
#line 1666 "csl.walker.g"
		
		params->push_back(expr1);
		params->push_back(expr2);
		
#line 14433 "CslTreeWalker.cpp"
		{
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_PS:
		{
			antlr::RefCslAST tmp112_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PS);
			_t = _t->getNextSibling();
#line 1671 "csl.walker.g"
			mTimeBase = CSLOmTBInfo::TB_TIMEBASE_PS;
#line 14445 "CslTreeWalker.cpp"
			break;
		}
		case K_NS:
		{
			antlr::RefCslAST tmp113_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NS);
			_t = _t->getNextSibling();
#line 1673 "csl.walker.g"
			mTimeBase = CSLOmTBInfo::TB_TIMEBASE_NS;
#line 14455 "CslTreeWalker.cpp"
			break;
		}
		case K_US:
		{
			antlr::RefCslAST tmp114_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_US);
			_t = _t->getNextSibling();
#line 1675 "csl.walker.g"
			mTimeBase = CSLOmTBInfo::TB_TIMEBASE_US;
#line 14465 "CslTreeWalker.cpp"
			break;
		}
		case K_MS:
		{
			antlr::RefCslAST tmp115_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_MS);
			_t = _t->getNextSibling();
#line 1677 "csl.walker.g"
			mTimeBase = CSLOmTBInfo::TB_TIMEBASE_MS;
#line 14475 "CslTreeWalker.cpp"
			break;
		}
		case K_S:
		{
			antlr::RefCslAST tmp116_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S);
			_t = _t->getNextSibling();
#line 1679 "csl.walker.g"
			mTimeBase = CSLOmTBInfo::TB_TIMEBASE_S ;
#line 14485 "CslTreeWalker.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 1681 "csl.walker.g"
		isInTestBench = TRUE;
#line 14496 "CslTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t198;
	_t = _t->getNextSibling();
#line 1684 "csl.walker.g"
	
	if(isInTestBench){
	CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::TB_OPER_CLOCK);
	CSLOmCmdTBAddLogic::setTimeBase(mTimeBase);
	}
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_TB_ADD_LOGIC, params);
	
#line 14519 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::command_add_logic_generate_report(antlr::RefCslAST _t) {
	antlr::RefCslAST command_add_logic_generate_report_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1693 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExprLink scope;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	CSLOmTBInfo::ETBReportType mReportType = CSLOmTBInfo::TB_REPORT_UNDEF;
	TBool mType = FALSE;
	
#line 14534 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t204 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GENERATE_REPORT);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1703 "csl.walker.g"
			if(scope.get()){
			scope->addHidItem( id.first ); 
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 14555 "CslTreeWalker.cpp"
		}
		else {
			goto _loop206;
		}
		
	}
	_loop206:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_COLUMN:
		{
			antlr::RefCslAST tmp117_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_COLUMN);
			_t = _t->getNextSibling();
#line 1712 "csl.walker.g"
			mReportType = CSLOmTBInfo::TB_REPORT_COLUMS; mType = TRUE;
#line 14576 "CslTreeWalker.cpp"
			break;
		}
		case K_ROW:
		{
			antlr::RefCslAST tmp118_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ROW);
			_t = _t->getNextSibling();
#line 1714 "csl.walker.g"
			mReportType = CSLOmTBInfo::TB_REPORT_ROWS  ; mType = TRUE;
#line 14586 "CslTreeWalker.cpp"
			break;
		}
		default:
		{
			goto _loop208;
		}
		}
	}
	_loop208:;
	} // ( ... )*
	_t = __t204;
	_t = _t->getNextSibling();
#line 1717 "csl.walker.g"
	
	CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::TB_OPER_GENERATE_REPORT);
	if(mType){
	CSLOmCmdTBAddLogic::setReportType(mReportType);
	}
	CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_TB_ADD_LOGIC, params);
	
#line 14607 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::param_list_auto_connect_verilog_and_csl(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_auto_connect_verilog_and_csl_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::param_list_autorouter(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_autorouter_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_AS_ON:
	{
		antlr::RefCslAST tmp119_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_AS_ON);
		_t = _t->getNextSibling();
		break;
	}
	case K_AS_OFF:
	{
		antlr::RefCslAST tmp120_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_AS_OFF);
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
}

void CslTreeWalker::nested_call(antlr::RefCslAST _t) {
	antlr::RefCslAST nested_call_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5677 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair<RefString,int> id;
	
#line 14655 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t732 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_SIGNAL_TYPE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 5684 "csl.walker.g"
			
			if( scope.get() ){
			scope->addHidItem( id.first );
			}
			else {
			scope = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first );
			}
			
#line 14677 "CslTreeWalker.cpp"
		}
		else {
			goto _loop734;
		}
		
	}
	_loop734:;
	} // ( ... )*
	param_list_get_signal_type(_t);
	_t = _retTree;
	_t = __t732;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::param_list_get_signal_type(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_signal_type_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

 NSCSLOm::RefCSLOmBaseRange  CslTreeWalker::bitrange_pure(antlr::RefCslAST _t) {
#line 5697 "csl.walker.g"
	 NSCSLOm::RefCSLOmBaseRange br ;
#line 14702 "CslTreeWalker.cpp"
	antlr::RefCslAST bitrange_pure_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST brTok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 5697 "csl.walker.g"
	
	RefCSLOmExpr expr1;
	RefCSLOmExpr expr2;
	br = RefCSLOmSimpleBitRange();
	RefCSLOmSetCommand command = RefCSLOmSetCommand();
	
#line 14712 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t736 = _t;
	brTok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),BITRANGE);
	_t = _t->getFirstChild();
	expr1=expression(_t);
	_t = _retTree;
	expr2=expression(_t);
	_t = _retTree;
	_t = __t736;
	_t = _t->getNextSibling();
#line 5705 "csl.walker.g"
	
	br = CSLOmSimpleBitRange::build( brTok->getLine(), _RS(brTok->getFilename()), design, RefString(new std::string("")), expr1, expr2 );
	
#line 14728 "CslTreeWalker.cpp"
	_retTree = _t;
	return br ;
}

void CslTreeWalker::param_list_get_interface(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_interface_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t738 = _t;
	antlr::RefCslAST tmp121_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_INTERFACE);
	_t = _t->getFirstChild();
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_INPUT:
	{
		antlr::RefCslAST tmp122_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INPUT);
		_t = _t->getNextSibling();
		break;
	}
	case K_OUTPUT:
	{
		antlr::RefCslAST tmp123_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OUTPUT);
		_t = _t->getNextSibling();
		break;
	}
	case K_INOUT:
	{
		antlr::RefCslAST tmp124_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INOUT);
		_t = _t->getNextSibling();
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t738;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::param_list_set_unit_prefix(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_unit_prefix_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 5857 "csl.walker.g"
	
	RefCSLOmExpr prefix;
	
#line 14786 "CslTreeWalker.cpp"
	
	_retTree = _t;
}

void CslTreeWalker::param_list_formal_to_actual_mapping(antlr::RefCslAST _t,
	 NSCSLOm::RefTVec_RefCSLOmExpr returnedParams 
) {
	antlr::RefCslAST param_list_formal_to_actual_mapping_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 5888 "csl.walker.g"
	
	RefCSLOmExpr expr_formal = RefCSLOmExpr();
	RefCSLOmExpr expr_actual = RefCSLOmExpr();
	
#line 14800 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t742 = _t;
	antlr::RefCslAST tmp125_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt744=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == F2A_PAIR_EXPR)) {
			f2a_pair_expr(_t,expr_formal, expr_actual);
			_t = _retTree;
#line 5896 "csl.walker.g"
			
			if(expr_formal->isExprLink() || expr_formal->isHybridORFuncCall()) {
			RefCSLOmExprLink exprLink = CSLOmExprLink::cast(expr_formal);
			returnedParams->push_back(exprLink);
			}
			returnedParams->push_back(expr_actual);
			expr_actual = RefCSLOmExpr();
			expr_formal = RefCSLOmExpr();
			
#line 14824 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt744>=1 ) { goto _loop744; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt744++;
	}
	_loop744:;
	}  // ( ... )+
	_t = __t742;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::f2a_pair_expr(antlr::RefCslAST _t,
	NSCSLOm::RefCSLOmExpr &expr_formal, NSCSLOm::RefCSLOmExpr &expr_actual
) {
	antlr::RefCslAST f2a_pair_expr_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST __t746 = _t;
	antlr::RefCslAST tmp126_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),F2A_PAIR_EXPR);
	_t = _t->getFirstChild();
	expr_formal=expression(_t);
	_t = _retTree;
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		expr_actual=expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t746;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::param_list_set_type(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_type_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6138 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	pair <RefString, int> id;
	
#line 14933 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t749 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SET_TYPE);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	_t = __t749;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::param_list_get_dim_bitrange(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_dim_bitrange_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6150 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 14952 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_add_offset(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_add_offset_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6157 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 14965 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_add_dim_offset(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_add_dim_offset_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6164 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 14978 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_set_dim_bitrange(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_dim_bitrange_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6172 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 14993 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_set_dim_width(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_dim_width_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6180 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 15008 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_set_number_of_dimensions(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_number_of_dimensions_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6188 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 15023 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_start_current_scope(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_start_current_scope_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::param_list_end_current_scope(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_end_current_scope_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::param_list_input_verilog_type(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_input_verilog_type_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_1995:
	{
		antlr::RefCslAST tmp127_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_1995);
		_t = _t->getNextSibling();
		break;
	}
	case K_2001:
	{
		antlr::RefCslAST tmp128_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_2001);
		_t = _t->getNextSibling();
		break;
	}
	case K_2005:
	{
		antlr::RefCslAST tmp129_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_2005);
		_t = _t->getNextSibling();
		break;
	}
	case K_SYSV:
	{
		antlr::RefCslAST tmp130_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SYSV);
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
}

void CslTreeWalker::param_list_output_verilog_type(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_output_verilog_type_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_1995:
	{
		antlr::RefCslAST tmp131_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_1995);
		_t = _t->getNextSibling();
		break;
	}
	case K_2001:
	{
		antlr::RefCslAST tmp132_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_2001);
		_t = _t->getNextSibling();
		break;
	}
	case K_2005:
	{
		antlr::RefCslAST tmp133_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_2005);
		_t = _t->getNextSibling();
		break;
	}
	case K_SYSV:
	{
		antlr::RefCslAST tmp134_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SYSV);
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
}

void CslTreeWalker::param_list_get_bitrange(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_bitrange_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::param_list_set_width(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_width_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6223 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 15142 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_get_width(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_width_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6230 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 15155 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_set_range(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_range_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6237 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 15168 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_get_range(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_range_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::param_list_get_offset(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_offset_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::param_list_get_number_of_dimensions(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_number_of_dimensions_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::param_list_set_signal_prefix(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_signal_prefix_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6257 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 15201 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_set_signal_prefix_local(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_signal_prefix_local_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6264 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 15214 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_get_upper_index(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_upper_index_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6275 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 15227 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_get_lower_index(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_lower_index_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::param_list_set_upper_index(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_upper_index_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6286 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 15246 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_set_lower_index(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_lower_index_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6293 "csl.walker.g"
	
	RefCSLOmExpr expr;
	
#line 15259 "CslTreeWalker.cpp"
	
	expr=expression(_t);
	_t = _retTree;
	_retTree = _t;
}

void CslTreeWalker::param_list_set_signal_type(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_signal_type_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_WIRE:
	{
		antlr::RefCslAST tmp135_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WIRE);
		_t = _t->getNextSibling();
		break;
	}
	case K_REG:
	{
		antlr::RefCslAST tmp136_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
		_t = _t->getNextSibling();
		break;
	}
	case K_TRI:
	{
		antlr::RefCslAST tmp137_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI);
		_t = _t->getNextSibling();
		break;
	}
	case K_TRIAND:
	{
		antlr::RefCslAST tmp138_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIAND);
		_t = _t->getNextSibling();
		break;
	}
	case K_TRIOR:
	{
		antlr::RefCslAST tmp139_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIOR);
		_t = _t->getNextSibling();
		break;
	}
	case K_TRI0:
	{
		antlr::RefCslAST tmp140_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI0);
		_t = _t->getNextSibling();
		break;
	}
	case K_TRI1:
	{
		antlr::RefCslAST tmp141_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI1);
		_t = _t->getNextSibling();
		break;
	}
	case K_TRIREG:
	{
		antlr::RefCslAST tmp142_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIREG);
		_t = _t->getNextSibling();
		break;
	}
	case K_WAND:
	{
		antlr::RefCslAST tmp143_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WAND);
		_t = _t->getNextSibling();
		break;
	}
	case K_WOR:
	{
		antlr::RefCslAST tmp144_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WOR);
		_t = _t->getNextSibling();
		break;
	}
	case K_SUPPLY0:
	{
		antlr::RefCslAST tmp145_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY0);
		_t = _t->getNextSibling();
		break;
	}
	case K_SUPPLY1:
	{
		antlr::RefCslAST tmp146_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY1);
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	}
	_retTree = _t;
}

void CslTreeWalker::param_list_set_signal_attr(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_set_signal_attr_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_ENABLE:
	{
		antlr::RefCslAST tmp147_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ENABLE);
		_t = _t->getNextSibling();
		break;
	}
	case K_STALL:
	{
		antlr::RefCslAST tmp148_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_STALL);
		_t = _t->getNextSibling();
		break;
	}
	case K_PIPE_ENABLE:
	{
		antlr::RefCslAST tmp149_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PIPE_ENABLE);
		_t = _t->getNextSibling();
		break;
	}
	case K_PIPE_STALL:
	{
		antlr::RefCslAST tmp150_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PIPE_STALL);
		_t = _t->getNextSibling();
		break;
	}
	case K_MUX_SELECT:
	{
		antlr::RefCslAST tmp151_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_MUX_SELECT);
		_t = _t->getNextSibling();
		break;
	}
	case K_DECODED:
	{
		antlr::RefCslAST tmp152_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DECODED);
		_t = _t->getNextSibling();
		break;
	}
	case K_CLOCK_SIGNAL:
	{
		antlr::RefCslAST tmp153_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CLOCK_SIGNAL);
		_t = _t->getNextSibling();
		break;
	}
	case K_RESET_SIGNAL:
	{
		antlr::RefCslAST tmp154_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RESET_SIGNAL);
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
}

void CslTreeWalker::param_list_get_signal_attr(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_signal_attr_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::param_list_merge(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_merge_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::param_list_invert(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_invert_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST tmp155_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),IDENTIFIER);
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::param_list_buffer(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_buffer_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	antlr::RefCslAST tmp156_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),IDENTIFIER);
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::param_list_get_reversed_interface(antlr::RefCslAST _t) {
	antlr::RefCslAST param_list_get_reversed_interface_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	_retTree = _t;
}

void CslTreeWalker::csl_unit_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_unit_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6436 "csl.walker.g"
	
	pair<RefString, int> id;
	//TBool scopeFlag = false;
	//TBool enteredScope = FALSE;
	RefCSLOmExprLink expr = RefCSLOmExprLink();
	
#line 15486 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t791 = _t;
	antlr::RefCslAST tmp157_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_UNIT);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt793=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 6445 "csl.walker.g"
			if (design->isScopeHolder() && 
			!(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
			NSCSLOm::RefCSLOmUnitDecl unitDecl = CSLOmUnitDecl::build(id.second, _RS(tok->getFilename()), design, id.first); 
			}
			//expr = CSLOmExprLink::build(#tok->getLine(), _RS(#tok->getFilename()),RefString(new std::string(#tok->getText())));
			//CSLOmScopeBlock::enterScope(expr);
			//scopeBlocks->push_back( expr );
			//design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
			//enteredScope = TRUE;
			
#line 15512 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt793>=1 ) { goto _loop793; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt793++;
	}
	_loop793:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t791;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_signal_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_signal_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7531 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair< RefString, int > id;
	RefCSLOmExpr hid = RefCSLOmExpr(), expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
	RefCSLOmSignal sig = RefCSLOmSignal();
	_ECSLOmSignalType type = NSCSLOm::SIGNAL_UNDEFINED;
	RefCSLOmBase parent = RefCSLOmBase();
	RefCSLOmBaseRange br;
	RefCSLOmExprLink brLink;
	RefString fileName;
	
#line 15563 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t904 = _t;
	antlr::RefCslAST tmp158_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_SIGNAL);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt909=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 7544 "csl.walker.g"
			
			//DCERR("pure string is " << _RS(#tok->getFilename()));
			//fileName = _RS(_RS(#tok->getFilename())); 
			//DCERR("impure string is " << *fileName );
			
#line 15584 "CslTreeWalker.cpp"
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case K_WIRE:
			{
				antlr::RefCslAST tmp159_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WIRE);
				_t = _t->getNextSibling();
#line 7549 "csl.walker.g"
				type = NSCSLOm::SIGNAL_WIRE;
#line 15596 "CslTreeWalker.cpp"
				break;
			}
			case K_REG:
			{
				antlr::RefCslAST tmp160_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
				_t = _t->getNextSibling();
#line 7550 "csl.walker.g"
				type = NSCSLOm::SIGNAL_REG;
#line 15606 "CslTreeWalker.cpp"
				break;
			}
			case K_TRI:
			{
				antlr::RefCslAST tmp161_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI);
				_t = _t->getNextSibling();
#line 7551 "csl.walker.g"
				type = NSCSLOm::SIGNAL_TRI;
#line 15616 "CslTreeWalker.cpp"
				break;
			}
			case K_TRIAND:
			{
				antlr::RefCslAST tmp162_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIAND);
				_t = _t->getNextSibling();
#line 7552 "csl.walker.g"
				type = NSCSLOm::SIGNAL_TRIAND;
#line 15626 "CslTreeWalker.cpp"
				break;
			}
			case K_TRIOR:
			{
				antlr::RefCslAST tmp163_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIOR);
				_t = _t->getNextSibling();
#line 7553 "csl.walker.g"
				type = NSCSLOm::SIGNAL_TRIOR;
#line 15636 "CslTreeWalker.cpp"
				break;
			}
			case K_TRI0:
			{
				antlr::RefCslAST tmp164_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI0);
				_t = _t->getNextSibling();
#line 7554 "csl.walker.g"
				type = NSCSLOm::SIGNAL_TRI0;
#line 15646 "CslTreeWalker.cpp"
				break;
			}
			case K_TRI1:
			{
				antlr::RefCslAST tmp165_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI1);
				_t = _t->getNextSibling();
#line 7555 "csl.walker.g"
				type = NSCSLOm::SIGNAL_TRI1;
#line 15656 "CslTreeWalker.cpp"
				break;
			}
			case K_TRIREG:
			{
				antlr::RefCslAST tmp166_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIREG);
				_t = _t->getNextSibling();
#line 7556 "csl.walker.g"
				type = NSCSLOm::SIGNAL_TRIREG;
#line 15666 "CslTreeWalker.cpp"
				break;
			}
			case K_WAND:
			{
				antlr::RefCslAST tmp167_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WAND);
				_t = _t->getNextSibling();
#line 7557 "csl.walker.g"
				type = NSCSLOm::SIGNAL_WAND;
#line 15676 "CslTreeWalker.cpp"
				break;
			}
			case K_WOR:
			{
				antlr::RefCslAST tmp168_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WOR);
				_t = _t->getNextSibling();
#line 7558 "csl.walker.g"
				type = NSCSLOm::SIGNAL_WOR;
#line 15686 "CslTreeWalker.cpp"
				break;
			}
			case K_SUPPLY0:
			{
				antlr::RefCslAST tmp169_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY0);
				_t = _t->getNextSibling();
#line 7559 "csl.walker.g"
				type = NSCSLOm::SIGNAL_SUPPLY_0;
#line 15696 "CslTreeWalker.cpp"
				break;
			}
			case K_SUPPLY1:
			{
				antlr::RefCslAST tmp170_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY1);
				_t = _t->getNextSibling();
#line 7560 "csl.walker.g"
				type = NSCSLOm::SIGNAL_SUPPLY_1;
#line 15706 "CslTreeWalker.cpp"
				break;
			}
			case K_INTEGER:
			{
				antlr::RefCslAST tmp171_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INTEGER);
				_t = _t->getNextSibling();
#line 7561 "csl.walker.g"
				type = NSCSLOm::SIGNAL_VAR_INTEGER;
#line 15716 "CslTreeWalker.cpp"
				break;
			}
			case K_REAL:
			{
				antlr::RefCslAST tmp172_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REAL);
				_t = _t->getNextSibling();
#line 7562 "csl.walker.g"
				type = NSCSLOm::SIGNAL_VAR_REAL;
#line 15726 "CslTreeWalker.cpp"
				break;
			}
			case K_REALTIME:
			{
				antlr::RefCslAST tmp173_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REALTIME);
				_t = _t->getNextSibling();
#line 7563 "csl.walker.g"
				type = NSCSLOm::SIGNAL_VAR_REALTIME;
#line 15736 "CslTreeWalker.cpp"
				break;
			}
			case K_TIME:
			{
				antlr::RefCslAST tmp174_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TIME);
				_t = _t->getNextSibling();
#line 7564 "csl.walker.g"
				type = NSCSLOm::SIGNAL_VAR_TIME;
#line 15746 "CslTreeWalker.cpp"
				break;
			}
			case 3:
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case IDENTIFIER:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case BITRANGE:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case BITRANGE:
			{
				br=bitrange_pure(_t);
				_t = _retTree;
#line 7567 "csl.walker.g"
				
				expr1 = br->getBitRangeLink();
				
#line 15824 "CslTreeWalker.cpp"
				break;
			}
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				exp = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
				expr1=expression(_t);
				_t = _retTree;
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case MINUS:
				case QUESTION:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case EXPRESSION:
				case RANGE_EXPRESSION:
				case MINTYPMAX_EXPRESSION:
				case EXPR_PRIMARY_IDENTIFIER:
				case U_PLUS:
				case U_MINUS:
				case U_AND:
				case U_NAND:
				case U_OR:
				case U_NOR:
				case U_XOR:
				case U_XNOR:
				case FUNCTION_CALL_RET_ID:
				case FUNCTION_CALL_RET_EXPR:
				case EXPR_HYBRID:
				case SIZED_NUMBER:
				case K_CONCATENATION:
				case K_REPLICATION:
				{
					expr2=expression(_t);
					_t = _retTree;
					break;
				}
				case 3:
				case IDENTIFIER:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				break;
			}
			case 3:
			case IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 7574 "csl.walker.g"
			
			if(!expr2.get()){
			sig = CSLOmSignal::build(id.second, _RS(tok->getFilename()), design, id.first, type, expr1);
			}
			else {
			sig = CSLOmSignal::build(id.second, _RS(tok->getFilename()), design, id.first, type, expr1, expr2);
			}
			//sig->setFileName(fileName);
			//safe reset - for this case: csl_signal x(reg,2), y(x), z(x);
			type = NSCSLOm::SIGNAL_UNDEFINED;
			expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
			
#line 15979 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt909>=1 ) { goto _loop909; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt909++;
	}
	_loop909:;
	}  // ( ... )+
	_t = __t904;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_port_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_port_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST exp = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7381 "csl.walker.g"
	
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr());
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	//RefCSLOmExprLink hid = RefCSLOmExprLink();
	//  RefCSLOmBase hid2 = RefCSLOmBase();
	ECSLOmPortDirection direction = NSCSLOm::DIR_UNDEFINED;
	ECSLOmSignalType signalType = NSCSLOm::SIGNAL_UNDEFINED;
	RefCSLOmExpr hid = RefCSLOmExpr(), expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
	RefCSLOmBaseRange br = RefCSLOmSimpleBitRange();
	pair< RefString, int > id;
	RefCSLOmPortDecl port = RefCSLOmPortDecl();
	//parent type flag
	TBool misUnitDecl = FALSE;
	TBool mHasWidthOrExprLink = FALSE;
	TBool mHasBitrange        = FALSE;
	
#line 16015 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t895 = _t;
	antlr::RefCslAST tmp175_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_PORT);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt902=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 7401 "csl.walker.g"
			
			mHasWidthOrExprLink = FALSE;
			mHasBitrange        = FALSE;
			if(design->isUnitDecl()){
			misUnitDecl = TRUE;
			design = CSLOmUnitDecl::cast(design)->getDefaultInterface();
			}
			
#line 16039 "CslTreeWalker.cpp"
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				hid=expression(_t);
				_t = _retTree;
				break;
			}
			case K_INPUT:
			case K_OUTPUT:
			case K_INOUT:
			{
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case K_INPUT:
				{
					antlr::RefCslAST tmp176_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INPUT);
					_t = _t->getNextSibling();
#line 7411 "csl.walker.g"
					direction = NSCSLOm::INPUT ;
#line 16115 "CslTreeWalker.cpp"
					break;
				}
				case K_OUTPUT:
				{
					antlr::RefCslAST tmp177_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OUTPUT);
					_t = _t->getNextSibling();
#line 7412 "csl.walker.g"
					direction = NSCSLOm::OUTPUT;
#line 16125 "CslTreeWalker.cpp"
					break;
				}
				case K_INOUT:
				{
					antlr::RefCslAST tmp178_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INOUT);
					_t = _t->getNextSibling();
#line 7413 "csl.walker.g"
					direction = NSCSLOm::INOUT ;
#line 16135 "CslTreeWalker.cpp"
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case K_WIRE:
				{
					antlr::RefCslAST tmp179_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WIRE);
					_t = _t->getNextSibling();
#line 7415 "csl.walker.g"
					signalType = SIGNAL_WIRE;
#line 16155 "CslTreeWalker.cpp"
					break;
				}
				case K_REG:
				{
					antlr::RefCslAST tmp180_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
					_t = _t->getNextSibling();
#line 7416 "csl.walker.g"
					signalType = SIGNAL_REG;
#line 16165 "CslTreeWalker.cpp"
					break;
				}
				case K_TRI:
				{
					antlr::RefCslAST tmp181_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI);
					_t = _t->getNextSibling();
#line 7417 "csl.walker.g"
					signalType = SIGNAL_TRI;
#line 16175 "CslTreeWalker.cpp"
					break;
				}
				case K_TRIAND:
				{
					antlr::RefCslAST tmp182_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIAND);
					_t = _t->getNextSibling();
#line 7418 "csl.walker.g"
					signalType = SIGNAL_TRIAND;
#line 16185 "CslTreeWalker.cpp"
					break;
				}
				case K_TRIOR:
				{
					antlr::RefCslAST tmp183_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIOR);
					_t = _t->getNextSibling();
#line 7419 "csl.walker.g"
					signalType = SIGNAL_TRIOR;
#line 16195 "CslTreeWalker.cpp"
					break;
				}
				case K_TRI0:
				{
					antlr::RefCslAST tmp184_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI0);
					_t = _t->getNextSibling();
#line 7420 "csl.walker.g"
					signalType = SIGNAL_TRI0;
#line 16205 "CslTreeWalker.cpp"
					break;
				}
				case K_TRI1:
				{
					antlr::RefCslAST tmp185_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI1);
					_t = _t->getNextSibling();
#line 7421 "csl.walker.g"
					signalType = SIGNAL_TRI1;
#line 16215 "CslTreeWalker.cpp"
					break;
				}
				case K_TRIREG:
				{
					antlr::RefCslAST tmp186_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIREG);
					_t = _t->getNextSibling();
#line 7422 "csl.walker.g"
					signalType = SIGNAL_TRIREG;
#line 16225 "CslTreeWalker.cpp"
					break;
				}
				case K_WAND:
				{
					antlr::RefCslAST tmp187_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WAND);
					_t = _t->getNextSibling();
#line 7423 "csl.walker.g"
					signalType = SIGNAL_WAND;
#line 16235 "CslTreeWalker.cpp"
					break;
				}
				case K_WOR:
				{
					antlr::RefCslAST tmp188_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WOR);
					_t = _t->getNextSibling();
#line 7424 "csl.walker.g"
					signalType = SIGNAL_WOR;
#line 16245 "CslTreeWalker.cpp"
					break;
				}
				case K_SUPPLY0:
				{
					antlr::RefCslAST tmp189_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY0);
					_t = _t->getNextSibling();
#line 7425 "csl.walker.g"
					signalType = SIGNAL_SUPPLY_0;
#line 16255 "CslTreeWalker.cpp"
					break;
				}
				case K_SUPPLY1:
				{
					antlr::RefCslAST tmp190_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY1);
					_t = _t->getNextSibling();
#line 7426 "csl.walker.g"
					signalType = SIGNAL_SUPPLY_1;
#line 16265 "CslTreeWalker.cpp"
					break;
				}
				case K_INTEGER:
				{
					antlr::RefCslAST tmp191_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INTEGER);
					_t = _t->getNextSibling();
#line 7427 "csl.walker.g"
					signalType = SIGNAL_VAR_INTEGER;
#line 16275 "CslTreeWalker.cpp"
					break;
				}
				case K_TIME:
				{
					antlr::RefCslAST tmp192_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TIME);
					_t = _t->getNextSibling();
#line 7428 "csl.walker.g"
					signalType = SIGNAL_VAR_TIME;
#line 16285 "CslTreeWalker.cpp"
					break;
				}
				case 3:
				case MINUS:
				case QUESTION:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case IDENTIFIER:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case EXPRESSION:
				case RANGE_EXPRESSION:
				case MINTYPMAX_EXPRESSION:
				case EXPR_PRIMARY_IDENTIFIER:
				case U_PLUS:
				case U_MINUS:
				case U_AND:
				case U_NAND:
				case U_OR:
				case U_NOR:
				case U_XOR:
				case U_XNOR:
				case FUNCTION_CALL_RET_ID:
				case FUNCTION_CALL_RET_EXPR:
				case EXPR_HYBRID:
				case SIZED_NUMBER:
				case BITRANGE:
				case K_CONCATENATION:
				case K_REPLICATION:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case BITRANGE:
				{
					br=bitrange_pure(_t);
					_t = _retTree;
#line 7431 "csl.walker.g"
					
					expr1 = br->getBitRangeLink();
					
#line 16363 "CslTreeWalker.cpp"
					break;
				}
				case MINUS:
				case QUESTION:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case EXPRESSION:
				case RANGE_EXPRESSION:
				case MINTYPMAX_EXPRESSION:
				case EXPR_PRIMARY_IDENTIFIER:
				case U_PLUS:
				case U_MINUS:
				case U_AND:
				case U_NAND:
				case U_OR:
				case U_NOR:
				case U_XOR:
				case U_XNOR:
				case FUNCTION_CALL_RET_ID:
				case FUNCTION_CALL_RET_EXPR:
				case EXPR_HYBRID:
				case SIZED_NUMBER:
				case K_CONCATENATION:
				case K_REPLICATION:
				{
					exp = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
					expr1=expression(_t);
					_t = _retTree;
					{
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					switch ( _t->getType()) {
					case MINUS:
					case QUESTION:
					case PLUS:
					case LNOT:
					case NOT:
					case AND:
					case NAND:
					case OR:
					case NOR:
					case XOR:
					case XNOR:
					case STAR:
					case POW:
					case DIV:
					case MOD:
					case EQUAL:
					case NOT_EQ:
					case NOT_EQ_CASE:
					case EQ_CASE:
					case LAND:
					case LOR:
					case LT_:
					case LE:
					case GT:
					case GE:
					case SL:
					case SSL:
					case SR:
					case SSR:
					case STRING:
					case UNSIGNED_NUMBER:
					case REAL_NUMBER:
					case BASED_NUMBER:
					case EXPRESSION:
					case RANGE_EXPRESSION:
					case MINTYPMAX_EXPRESSION:
					case EXPR_PRIMARY_IDENTIFIER:
					case U_PLUS:
					case U_MINUS:
					case U_AND:
					case U_NAND:
					case U_OR:
					case U_NOR:
					case U_XOR:
					case U_XNOR:
					case FUNCTION_CALL_RET_ID:
					case FUNCTION_CALL_RET_EXPR:
					case EXPR_HYBRID:
					case SIZED_NUMBER:
					case K_CONCATENATION:
					case K_REPLICATION:
					{
						expr2=expression(_t);
						_t = _retTree;
						break;
					}
					case 3:
					case IDENTIFIER:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
					}
					}
					}
#line 7436 "csl.walker.g"
					if(!expr2.get()){
					//if(#exp->getFirstChild()->getType() == EXPR_PRIMARY_IDENTIFIER){
					//hid2 = expr1->doEval();
					//it is exprLink to a bitrange object or a number - setting appropriate flag
					mHasWidthOrExprLink = TRUE;
					//}
					//else {
					//br = CSLOmSimpleBitRange::build(id.second, _RS(#tok->getFilename()), design, _RS(""), expr1);
					// }
					//}
					}
					else {
					mHasBitrange = TRUE;
					//building bitrange
					//br = CSLOmSimpleBitRange::build(id.second, _RS(#tok->getFilename()), design, _RS(""), expr1, expr2);
					port = CSLOmPortDecl::build(id.second, _RS(tok->getFilename()), design, id.first, direction, expr1, expr2);
					if (signalType != SIGNAL_UNDEFINED) {
					port->setPortType(signalType);
					}
					}
					
#line 16514 "CslTreeWalker.cpp"
					break;
				}
				case 3:
				case IDENTIFIER:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 7459 "csl.walker.g"
			
			
			if(!hid.get()){
			if(mHasWidthOrExprLink){
			port = CSLOmPortDecl::build(id.second, _RS(tok->getFilename()), design, id.first, direction, expr1);
			if (signalType != SIGNAL_UNDEFINED) {
			port->setPortType(signalType);
			}
			}
			else {
			if(!mHasBitrange){
			port = CSLOmPortDecl::build(id.second, _RS(tok->getFilename()), design, id.first, direction, signalType);
			if (signalType != SIGNAL_UNDEFINED) {
			port->setPortType(signalType);
			}
			}
			//if(mHasBitrange && br.get()){
			//  scope = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), CSLOmIdentifier::cast(port->getChild(ID))->getName());
			//  scope->addID(CSLOmIdentifier::cast(port->getChild(ID)));
			//  params->push_back(br->getBitRangeLink());
			//  CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_BITRANGE, params);
			//  params->pop_back();
			//}
			}
			}
			else{
			port = CSLOmPortDecl::build(id.second, _RS(tok->getFilename()), design, id.first,CSLOmExprLink::cast(hid));
			}
			//Resetting design to unit decl for other objects that may follow after port declarations
			if(misUnitDecl){
			design = CSLOmUnitDecl::cast(design->getParent());
			}
			
#line 16570 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt902>=1 ) { goto _loop902; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt902++;
	}
	_loop902:;
	}  // ( ... )+
	_t = __t895;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_signal_group_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_signal_group_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7059 "csl.walker.g"
	
	pair<RefString, int> id;
	//TBool scopeFlag = false;
	
#line 16593 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t864 = _t;
	antlr::RefCslAST tmp193_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_SIGNAL_GROUP);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt866=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 7066 "csl.walker.g"
			if (design->isScopeHolder() && !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
			NSCSLOm::RefCSLOmGroupSignal signalGroup = CSLOmGroupSignal::build(id.second, _RS(tok->getFilename()), design, id.first); }
#line 16611 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt866>=1 ) { goto _loop866; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt866++;
	}
	_loop866:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t864;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_bitrange_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_bitrange_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7128 "csl.walker.g"
	
	pair<RefString,int> id;
	RefCSLOmExpr expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr() , expr3 = RefCSLOmExpr();
	RefCSLOmSimpleBitRange br ;
	int count = 0;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmBase parent = RefCSLOmBase();
	RefCSLOmIdentifier name = RefCSLOmIdentifier();
	
#line 16659 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t869 = _t;
	antlr::RefCslAST tmp194_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_BITRANGE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 7140 "csl.walker.g"
			
			count = 1;
			
#line 16677 "CslTreeWalker.cpp"
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				expr1=expression(_t);
				_t = _retTree;
#line 7144 "csl.walker.g"
				count = 2 ;
#line 16738 "CslTreeWalker.cpp"
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case MINUS:
				case QUESTION:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case EXPRESSION:
				case RANGE_EXPRESSION:
				case MINTYPMAX_EXPRESSION:
				case EXPR_PRIMARY_IDENTIFIER:
				case U_PLUS:
				case U_MINUS:
				case U_AND:
				case U_NAND:
				case U_OR:
				case U_NOR:
				case U_XOR:
				case U_XNOR:
				case FUNCTION_CALL_RET_ID:
				case FUNCTION_CALL_RET_EXPR:
				case EXPR_HYBRID:
				case SIZED_NUMBER:
				case K_CONCATENATION:
				case K_REPLICATION:
				{
					expr2=expression(_t);
					_t = _retTree;
#line 7146 "csl.walker.g"
					count = 3 ;
#line 16799 "CslTreeWalker.cpp"
					break;
				}
				case 3:
				case IDENTIFIER:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				break;
			}
			case 3:
			case IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 7149 "csl.walker.g"
			
			//name = CSLOmCommand::findObjectID( id.second, design, vCurrentScope, RefCSLOmExprLink() );
			if(name.get()) { parent = name->getParent(); }
			else {
			parent = design;
			}
			//cerr << count << endl;
			if(count == 3) {
			br = CSLOmSimpleBitRange::build( id.second , _RS(tok->getFilename()), parent, id.first,  expr1, expr2);
			}
			else if( count == 2) {
			br = CSLOmSimpleBitRange::build( id.second, _RS(tok->getFilename()), parent, id.first,  expr1 );
			}
			else if( count == 1) { 
			//cerr<<"build br"<<endl;
			ASSERT(1,"BUG? The count is 1 in bitrange declaration!!! This is no longer supported"); 
			}
			else {
			ASSERT(0,"BUG? The count is 0 in bitrange declaration!!!"); 
			}
			
#line 16848 "CslTreeWalker.cpp"
		}
		else {
			goto _loop873;
		}
		
	}
	_loop873:;
	} // ( ... )*
	_t = __t869;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_multi_dim_bitrange_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_multi_dim_bitrange_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7174 "csl.walker.g"
	
	pair<RefString,int> id;
	RefCSLOmExpr expr = RefCSLOmExpr();
	RefCSLOmMultiDimBitRange mBr;
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	RefCSLOmBase parent = RefCSLOmBase();
	RefCSLOmIdentifier name = RefCSLOmIdentifier();
	
#line 16874 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t875 = _t;
	antlr::RefCslAST tmp195_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_MULTI_DIM_BITRANGE);
	_t = _t->getFirstChild();
	{
	tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	id=identifier(_t);
	_t = _retTree;
	{
	expr=expression(_t);
	_t = _retTree;
	}
	}
#line 7189 "csl.walker.g"
	
	if(name.get()) { parent = name->getParent(); }
	else {
	parent = design;
	}
	mBr = CSLOmMultiDimBitRange::build(id.second, _RS(tok->getFilename()), parent, id.first, expr);
	
#line 16897 "CslTreeWalker.cpp"
	_t = __t875;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_field_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_field_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7199 "csl.walker.g"
	
	pair<RefString,int> id;
	pair<RefString,int> idParent;
	RefCSLOmExpr exprEnumOrEnumItem = RefCSLOmExpr(), 
	exprWidthOrBrOrLow = RefCSLOmExpr(), 
	exprUpper          = RefCSLOmExpr();
	RefCSLOmExpr expr1 = RefCSLOmExpr(), 
	expr2 = RefCSLOmExpr(), 
	expr3 = RefCSLOmExpr();
	pair<RefString, int> idEnumOrEnumItem;
	RefCSLOmSimpleBitRange br = RefCSLOmSimpleBitRange();
	
	RefCSLOmExprLink  scope = RefCSLOmExprLink();
	RefCSLOmBase     parent = RefCSLOmBase();
	RefCSLOmIdentifier name = RefCSLOmIdentifier();
	//TBool hasLowerOrWidthOrBr = FALSE;
	//TBool hasUpper            = FALSE; 
	//TBool hasEnumOrEnumItem   = FALSE;
	TBool hasParentClass      = FALSE;
	TBool hasDefinition       = FALSE;
	//RefCSLOmExprLink nullExprLink = RefCSLOmExprLink();
	int count;
	
#line 16931 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t879 = _t;
	antlr::RefCslAST tmp196_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_FIELD);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 7225 "csl.walker.g"
			
			if(name.get()) { parent = name->getParent(); }
			else           { parent = design;            }
			
#line 16950 "CslTreeWalker.cpp"
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case PARENT_CLASS:
			{
				antlr::RefCslAST tmp197_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PARENT_CLASS);
				_t = _t->getNextSibling();
				tok1 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
				idParent=identifier(_t);
				_t = _retTree;
#line 7231 "csl.walker.g"
				
				hasParentClass = TRUE; 
				RefCSLOmExprLink parentClass = CSLOmExprLink::build(idParent.second, _RS(tok1->getFilename()), idParent.first);
				RefCSLOmBase parentClassBase = parentClass->doEval();
				br = CSLOmField::build( id.second, _RS(tok->getFilename()), parent, id.first, CSLOmField::cast(parentClassBase));
				
#line 16970 "CslTreeWalker.cpp"
				break;
			}
			case 3:
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case IDENTIFIER:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case CSL_UNIT_DEFINITION:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 7243 "csl.walker.g"
			count = 0;
#line 17038 "CslTreeWalker.cpp"
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				expr1=expression(_t);
				_t = _retTree;
#line 7250 "csl.walker.g"
				++count;
#line 17099 "CslTreeWalker.cpp"
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case MINUS:
				case QUESTION:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case EXPRESSION:
				case RANGE_EXPRESSION:
				case MINTYPMAX_EXPRESSION:
				case EXPR_PRIMARY_IDENTIFIER:
				case U_PLUS:
				case U_MINUS:
				case U_AND:
				case U_NAND:
				case U_OR:
				case U_NOR:
				case U_XOR:
				case U_XNOR:
				case FUNCTION_CALL_RET_ID:
				case FUNCTION_CALL_RET_EXPR:
				case EXPR_HYBRID:
				case SIZED_NUMBER:
				case K_CONCATENATION:
				case K_REPLICATION:
				{
					expr2=expression(_t);
					_t = _retTree;
#line 7251 "csl.walker.g"
					++count;
#line 17160 "CslTreeWalker.cpp"
					{
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					switch ( _t->getType()) {
					case MINUS:
					case QUESTION:
					case PLUS:
					case LNOT:
					case NOT:
					case AND:
					case NAND:
					case OR:
					case NOR:
					case XOR:
					case XNOR:
					case STAR:
					case POW:
					case DIV:
					case MOD:
					case EQUAL:
					case NOT_EQ:
					case NOT_EQ_CASE:
					case EQ_CASE:
					case LAND:
					case LOR:
					case LT_:
					case LE:
					case GT:
					case GE:
					case SL:
					case SSL:
					case SR:
					case SSR:
					case STRING:
					case UNSIGNED_NUMBER:
					case REAL_NUMBER:
					case BASED_NUMBER:
					case EXPRESSION:
					case RANGE_EXPRESSION:
					case MINTYPMAX_EXPRESSION:
					case EXPR_PRIMARY_IDENTIFIER:
					case U_PLUS:
					case U_MINUS:
					case U_AND:
					case U_NAND:
					case U_OR:
					case U_NOR:
					case U_XOR:
					case U_XNOR:
					case FUNCTION_CALL_RET_ID:
					case FUNCTION_CALL_RET_EXPR:
					case EXPR_HYBRID:
					case SIZED_NUMBER:
					case K_CONCATENATION:
					case K_REPLICATION:
					{
						expr3=expression(_t);
						_t = _retTree;
#line 7252 "csl.walker.g"
						++count;
#line 17221 "CslTreeWalker.cpp"
						break;
					}
					case 3:
					case IDENTIFIER:
					case CSL_UNIT_DEFINITION:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
					}
					}
					}
					break;
				}
				case 3:
				case IDENTIFIER:
				case CSL_UNIT_DEFINITION:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				break;
			}
			case 3:
			case IDENTIFIER:
			case CSL_UNIT_DEFINITION:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 7255 "csl.walker.g"
			
			//DCERR("count: "<<count<<std::endl);
			if(count == 3) {
			br = CSLOmField::build( id.second, _RS(tok->getFilename()), 
			parent, 
			id.first, 
			expr1, 
			expr2,
			CSLOmExprLink::cast(expr3) );
			}
			else if(count == 2) {
			if(expr1->isNumber()) { //if first expr is number
			//DCERR("expr1 is number" << std::endl);
			if(expr2->isNumber()) { //found lower and upper
			//DCERR("expr2 is number" << std::endl);
			br = CSLOmField::build( id.second, _RS(tok->getFilename()), 
			parent, 
			id.first, 
			expr1, 
			expr2);
			} 
			else if(expr2->isExprLink()) { //found width and enum|enum_item
			//DCERR("expr2 is expression link" << std::endl);
			br = CSLOmField::build( id.second, _RS(tok->getFilename()), 
			parent, 
			id.first, 
			expr1, 
			CSLOmExprLink::cast(expr2));
			}
			}
			else if(expr1->isExprLink()) { //found bitrange
			//DCERR("expr1 is expression link" << std::endl);
			if(expr2->isExprLink()) { //found enum|enum item
			br = CSLOmField::build( id.second, _RS(tok->getFilename()), 
			parent, 
			id.first, 
			expr1, 
			CSLOmExprLink::cast(expr2));
			}
			}
			}
			else if(count == 1) {
			//DCERR("expr1 is number" << std::endl);
			br = CSLOmField::build( id.second, _RS(tok->getFilename()), 
			parent, 
			id.first, 
			expr1);
			} 
			else if(count == 0) {
			//DCERR("simple field" << std::endl);
			br = CSLOmField::build( id.second, _RS(tok->getFilename()), 
			parent, 
			id.first);
			}
			
#line 17320 "CslTreeWalker.cpp"
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case CSL_UNIT_DEFINITION:
			{
				csl_unit_definition(_t,id);
				_t = _retTree;
#line 7311 "csl.walker.g"
				hasDefinition = TRUE;
#line 17331 "CslTreeWalker.cpp"
				break;
			}
			case 3:
			case IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
		}
		else {
			goto _loop886;
		}
		
	}
	_loop886:;
	} // ( ... )*
	_t = __t879;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_design_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_design_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 7045 "csl.walker.g"
	
	pair<RefString,int> id;
	//  RefCSLOmExpr expr;
	
#line 17365 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t860 = _t;
	antlr::RefCslAST tmp198_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_DESIGN);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt862=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 7052 "csl.walker.g"
			
			//cerr << *(id.first) << endl;
			
#line 17383 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt862>=1 ) { goto _loop862; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt862++;
	}
	_loop862:;
	}  // ( ... )+
	_t = __t860;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_interface_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_interface_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7949 "csl.walker.g"
	
	pair<RefString, int> id;
	//TBool scopeFlag = false;
	
	
#line 17407 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t932 = _t;
	antlr::RefCslAST tmp199_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_INTERFACE);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt934=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 7957 "csl.walker.g"
			if (design->isScopeHolder() && !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
			NSCSLOm::RefCSLOmInterface interface = CSLOmInterface::build(id.second, _RS(tok->getFilename()), design, id.first); }
#line 17425 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt934>=1 ) { goto _loop934; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt934++;
	}
	_loop934:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t932;
	_t = _t->getNextSibling();
	_retTree = _t;
}

NSCSLOm::RefCSLOmList  CslTreeWalker::csl_list_declaration(antlr::RefCslAST _t) {
#line 8007 "csl.walker.g"
	NSCSLOm::RefCSLOmList list;
#line 17463 "CslTreeWalker.cpp"
	antlr::RefCslAST csl_list_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST listTok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8007 "csl.walker.g"
	
	RefCSLOmExprLink scope = RefCSLOmExprLink();
	pair <RefString,int> id;
	//RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 17472 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t937 = _t;
	listTok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_LIST);
	_t = _t->getFirstChild();
	{
	id=identifier(_t);
	_t = _retTree;
#line 8015 "csl.walker.g"
	
	//std::cerr << "before build" << std::endl;
	list = CSLOmList::build(listTok->getLine(), _RS(listTok->getFilename()), design, id.first);
	//std::cerr << "after build" << std::endl;
	
#line 17487 "CslTreeWalker.cpp"
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		param_list_csl_list(_t, list );
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	}
	_t = __t937;
	_t = _t->getNextSibling();
	_retTree = _t;
	return list;
}

void CslTreeWalker::csl_address_range_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_address_range_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7343 "csl.walker.g"
	
	pair <RefString, int > id;
	//RefCSLOmExprLink hid = RefCSLOmExprLink();
	CSLOmAddressRange::EAddressRangeType rangeType = NSCSLOm::CSLOmAddressRange::ADDR_UNDEFINED;
	RefCSLOmExpr    expr1 = RefCSLOmExpr();
	RefCSLOmExpr    expr2 = RefCSLOmExpr();
	RefCSLOmNumber  lower = RefCSLOmNumber();
	RefCSLOmNumber  upper = RefCSLOmNumber();
	RefCSLOmNumber offset = RefCSLOmNumber(); //not used in copy ?
	
#line 17580 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t888 = _t;
	antlr::RefCslAST tmp200_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_ADDRESS_RANGE);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt893=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_ILLEGAL:
			case K_RESERVED:
			case K_VALID:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case K_RESERVED:
				{
					antlr::RefCslAST tmp201_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RESERVED);
					_t = _t->getNextSibling();
#line 7356 "csl.walker.g"
					rangeType = NSCSLOm::CSLOmAddressRange::ADDR_RESERVED;
#line 17665 "CslTreeWalker.cpp"
					break;
				}
				case K_VALID:
				{
					antlr::RefCslAST tmp202_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_VALID);
					_t = _t->getNextSibling();
#line 7357 "csl.walker.g"
					rangeType = NSCSLOm::CSLOmAddressRange::ADDR_VALID;
#line 17675 "CslTreeWalker.cpp"
					break;
				}
				case K_ILLEGAL:
				{
					antlr::RefCslAST tmp203_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ILLEGAL);
					_t = _t->getNextSibling();
#line 7358 "csl.walker.g"
					rangeType = NSCSLOm::CSLOmAddressRange::ADDR_ILLEGAL;
#line 17685 "CslTreeWalker.cpp"
					break;
				}
				case MINUS:
				case QUESTION:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case EXPRESSION:
				case RANGE_EXPRESSION:
				case MINTYPMAX_EXPRESSION:
				case EXPR_PRIMARY_IDENTIFIER:
				case U_PLUS:
				case U_MINUS:
				case U_AND:
				case U_NAND:
				case U_OR:
				case U_NOR:
				case U_XOR:
				case U_XNOR:
				case FUNCTION_CALL_RET_ID:
				case FUNCTION_CALL_RET_EXPR:
				case EXPR_HYBRID:
				case SIZED_NUMBER:
				case K_CONCATENATION:
				case K_REPLICATION:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				tok1 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
				expr1=expression(_t);
				_t = _retTree;
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case MINUS:
				case QUESTION:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case EXPRESSION:
				case RANGE_EXPRESSION:
				case MINTYPMAX_EXPRESSION:
				case EXPR_PRIMARY_IDENTIFIER:
				case U_PLUS:
				case U_MINUS:
				case U_AND:
				case U_NAND:
				case U_OR:
				case U_NOR:
				case U_XOR:
				case U_XNOR:
				case FUNCTION_CALL_RET_ID:
				case FUNCTION_CALL_RET_EXPR:
				case EXPR_HYBRID:
				case SIZED_NUMBER:
				case K_CONCATENATION:
				case K_REPLICATION:
				{
					expr2=expression(_t);
					_t = _retTree;
					break;
				}
				case 3:
				case IDENTIFIER:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				break;
			}
			case 3:
			case IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 7363 "csl.walker.g"
			
			if(!expr2.get() && tok1->getFirstChild()->getType() == EXPR_PRIMARY_IDENTIFIER) {
			RefCSLOmBase hidEval = expr1->doEval();
			CSLOmAddressRange::build(id.second, _RS(tok->getFilename()),
			design,
			(CSLOmAddressRange::cast(hidEval))->getLower(),
			(CSLOmAddressRange::cast(hidEval))->getUpper(),
			(CSLOmAddressRange::cast(hidEval))->getAddressRangeType(),
			id.first);
			}
			else if(expr2.get()) {
			CSLOmAddressRange::build(id.second, _RS(tok->getFilename()), design, expr1, expr2, rangeType, id.first);
			}
			
#line 17850 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt893>=1 ) { goto _loop893; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt893++;
	}
	_loop893:;
	}  // ( ... )+
	_t = __t888;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_register_file_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_register_file_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6489 "csl.walker.g"
	
	pair<RefString, int> id;
	//TBool scopeFlag = false;
	
#line 17873 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t801 = _t;
	antlr::RefCslAST tmp204_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_REGISTER_FILE);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt803=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 6496 "csl.walker.g"
			
			if (design->isScopeHolder() && !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
			/* NSCSLOm::RefCSLOmUnitDecl unitDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first);*/
			NSCSLOm::RefCSLOmUnitDecl rf_unitDecl = CSLOmUnitDecl::build(id.second, _RS(tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_REGISTER_FILE_DECL);
			}
			
#line 17895 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt803>=1 ) { goto _loop803; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt803++;
	}
	_loop803:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t801;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_register_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_register_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6509 "csl.walker.g"
	
	pair<RefString, int> id;
	
#line 17937 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t806 = _t;
	antlr::RefCslAST tmp205_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_REGISTER);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt808=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 6515 "csl.walker.g"
			
			NSCSLOm::RefCSLOmUnitDecl reg_unitDecl = CSLOmUnitDecl::build(id.second, _RS(tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_REGISTER_DECL);
			
#line 17956 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt808>=1 ) { goto _loop808; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt808++;
	}
	_loop808:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t806;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_memory_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_memory_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6525 "csl.walker.g"
	
	pair<RefString, int> id;
	
#line 17998 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t811 = _t;
	antlr::RefCslAST tmp206_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_MEMORY);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt813=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 6531 "csl.walker.g"
			
			NSCSLOm::RefCSLOmUnitDecl mem_unitDecl = CSLOmUnitDecl::build(id.second, _RS(tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_MEMORY_DECL);
			
#line 18017 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt813>=1 ) { goto _loop813; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt813++;
	}
	_loop813:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t811;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_testbench_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_testbench_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6542 "csl.walker.g"
	
	pair <RefString,int> id;
	
#line 18059 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t816 = _t;
	antlr::RefCslAST tmp207_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_TESTBENCH);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt818=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 6548 "csl.walker.g"
			
			NSCSLOm::RefCSLOmUnitDecl tb_unitdecl = CSLOmUnitDecl::build(id.second, _RS(tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_TESTBENCH_DECL);
			
#line 18078 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt818>=1 ) { goto _loop818; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt818++;
	}
	_loop818:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t816;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_bool_equation_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_bool_equation_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8087 "csl.walker.g"
	
	pair <RefString,int> id;
	
#line 18120 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t946 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_BOOL_EQUATION);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	_t = __t946;
	_t = _t->getNextSibling();
#line 8094 "csl.walker.g"
	
	//to be implemeted in CSLOM
	
#line 18134 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::csl_event_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_event_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8233 "csl.walker.g"
	
	pair <RefString,int> id;
	
#line 18145 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t961 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_EVENT);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	_t = __t961;
	_t = _t->getNextSibling();
#line 8240 "csl.walker.g"
	
	//to be implemeted in CSLOM
	
#line 18159 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::csl_enum_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_enum_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8099 "csl.walker.g"
	
	pair <RefString,int> id/*, id2*/;
	RefString name = RefString();
	//  RefCSLOmExpr number = RefCSLOmExpr();
	//<added by Alina>
	//  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
	//  RefCSLOmExprLink link;
	//</added by Alina>
	
#line 18176 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t948 = _t;
	antlr::RefCslAST tmp208_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_ENUM);
	_t = _t->getFirstChild();
	tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	id=identifier(_t);
	_t = _retTree;
#line 8111 "csl.walker.g"
	
	RefCSLOmEnum enumObj = CSLOmEnum::build(id.second, _RS(tok->getFilename()), design, id.first);
	//      link = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), id.first);
	
#line 18190 "CslTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == ENUM_ITEM)) {
			csl_enum_item(_t,id);
			_t = _retTree;
		}
		else {
			goto _loop950;
		}
		
	}
	_loop950:;
	} // ( ... )*
	_t = __t948;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_parameter_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_parameter_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8202 "csl.walker.g"
	
	pair <RefString,int> id;
	RefCSLOmExpr expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
	RefCSLOmParameter param = RefCSLOmParameter();
	
#line 18220 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t955 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_PARAMETER);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt959=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
			{
			expr1=expression(_t);
			_t = _retTree;
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				expr2=expression(_t);
				_t = _retTree;
				break;
			}
			case 3:
			case IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			}
#line 8213 "csl.walker.g"
			
			ASSERT(expr1.get(),"First expression in parameter declaration is not optional");
			if(!expr2.get()){
			param = CSLOmParameter::build(id.second, _RS(tok->getFilename()), design, id.first, expr1);
			//DCERR("[WALKER] CSLOm build for parameter expects number for value but this can also be expression");
			//DCERR("walkerParamDeclVal: param name: " << *(param->getName()) << " param value = " << param->getValue()->getValue() << endl);
			}
			else{
			//DCERR("[WALKER] I need CSLOm support for creating a parameter with width specification: If this is available, please contact walker developer");
			param = CSLOmParameter::build(id.second, _RS(tok->getFilename()), design, id.first, expr1, expr2);
			//DCERR("walkerParamDeclValAndWidth: param name: " << *(param->getName()) << " param value = " << param->getValue()->getValue() << " param width = " << param->getWidth() << endl);
			}
			expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr(), param = RefCSLOmParameter();
			
#line 18324 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt959>=1 ) { goto _loop959; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt959++;
	}
	_loop959:;
	}  // ( ... )+
	_t = __t955;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_state_data_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_state_data_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8278 "csl.walker.g"
	
	pair <RefString,int> id;
	
#line 18346 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t963 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_STATE_DATA);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt965=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 8284 "csl.walker.g"
			
			NSCSLOm::RefCSLOmUnitDecl stateDataDecl = CSLOmUnitDecl::build(id.second, _RS(tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_STATE_DATA);
			
#line 18364 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt965>=1 ) { goto _loop965; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt965++;
	}
	_loop965:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t963;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_vector_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_vector_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8295 "csl.walker.g"
	
	pair <RefString,int> id;
	
#line 18406 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t968 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_VECTOR);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt970=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 8301 "csl.walker.g"
			
			NSCSLOm::RefCSLOmUnitDecl vectorDecl = CSLOmUnitDecl::build(id.second, _RS(tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_VECTOR);
			
#line 18424 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt970>=1 ) { goto _loop970; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt970++;
	}
	_loop970:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t968;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_signal_pattern_generator_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_signal_pattern_generator_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8313 "csl.walker.g"
	
	pair <RefString,int> id;
	
#line 18466 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t973 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_SIGNAL_PATTERN_GENERATOR);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	_t = __t973;
	_t = _t->getNextSibling();
#line 8320 "csl.walker.g"
	
	//to be implemeted in CSLOM
	
#line 18480 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::csl_include_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_include_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST file_ver = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST file_cpp = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8041 "csl.walker.g"
	
	RefCSLOmExpr fileName = RefCSLOmExpr();
	EIncludeFileType type;
	
#line 18494 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t943 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_INCLUDE);
	_t = _t->getFirstChild();
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_FILE_VERILOG:
	{
		file_ver = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FILE_VERILOG);
		_t = _t->getNextSibling();
#line 8047 "csl.walker.g"
		type = FILE_VERILOG;
#line 18511 "CslTreeWalker.cpp"
		break;
	}
	case K_FILE_CPLUSPLUS:
	{
		file_cpp = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FILE_CPLUSPLUS);
		_t = _t->getNextSibling();
#line 8048 "csl.walker.g"
		type = FILE_CPLUSPLUS;
#line 18521 "CslTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	fileName=expression(_t);
	_t = _retTree;
#line 8051 "csl.walker.g"
	
	CSLOmInclude::build( tok->getLine(), _RS(tok->getFilename()), type, CSLOmString::cast(fileName)->getValue());
	
#line 18536 "CslTreeWalker.cpp"
	_t = __t943;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_fifo_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_fifo_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6469 "csl.walker.g"
	
	pair<RefString, int> id;
	
#line 18549 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t796 = _t;
	antlr::RefCslAST tmp209_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_FIFO);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt798=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 6475 "csl.walker.g"
			
			if ( design->isScopeHolder() && 
			!(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
			NSCSLOm::RefCSLOmUnitDecl fifo_unitDecl = CSLOmUnitDecl::build(id.second, _RS(tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_FIFO_DECL);
			}
			
#line 18571 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt798>=1 ) { goto _loop798; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt798++;
	}
	_loop798:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t796;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_memory_map_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_memory_map_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6559 "csl.walker.g"
	
	pair<RefString, int> id;
	
#line 18613 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t821 = _t;
	antlr::RefCslAST tmp210_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_MEMORY_MAP);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt823=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 6565 "csl.walker.g"
			
			if ( design->isScopeHolder() && 
			!(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
			NSCSLOm::RefCSLOmMemoryMap memMapDecl = CSLOmMemoryMap::build(id.second, _RS(tok->getFilename()), CSLOmDesign::cast(design), id.first);
			}
			
#line 18635 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt823>=1 ) { goto _loop823; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt823++;
	}
	_loop823:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t821;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_memory_map_page_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_memory_map_page_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6603 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 18678 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t826 = _t;
	antlr::RefCslAST tmp211_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_MEMORY_MAP_PAGE);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt828=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 6610 "csl.walker.g"
			
			if ( design->isScopeHolder() && 
			!(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
			NSCSLOm::RefCSLOmMemoryMapPage memMapPageDecl = CSLOmMemoryMapPage::build(id.second, _RS(tok->getFilename()), CSLOmDesign::cast(design), id.first);
			}
			
#line 18700 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt828>=1 ) { goto _loop828; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt828++;
	}
	_loop828:;
	}  // ( ... )+
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t826;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_isa_field_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_isa_field_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6690 "csl.walker.g"
	
	//identifiers
	pair<RefString, int> id;
	//parameters
	RefCSLOmExpr expr1 = RefCSLOmExpr(),
	expr2 = RefCSLOmExpr(),
	expr3 = RefCSLOmExpr();
	//target object
	RefCSLOmIsaField isaField = RefCSLOmIsaField();
	//flags
	TBool hasDefinition       = FALSE;
	TInt count;
	
#line 18752 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t835 = _t;
	antlr::RefCslAST tmp212_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_ISA_FIELD);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id=identifier(_t);
			_t = _retTree;
#line 6706 "csl.walker.g"
			count = 0;
#line 18768 "CslTreeWalker.cpp"
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				expr1=expression(_t);
				_t = _retTree;
#line 6707 "csl.walker.g"
				++count;
#line 18829 "CslTreeWalker.cpp"
				{
				if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case MINUS:
				case QUESTION:
				case PLUS:
				case LNOT:
				case NOT:
				case AND:
				case NAND:
				case OR:
				case NOR:
				case XOR:
				case XNOR:
				case STAR:
				case POW:
				case DIV:
				case MOD:
				case EQUAL:
				case NOT_EQ:
				case NOT_EQ_CASE:
				case EQ_CASE:
				case LAND:
				case LOR:
				case LT_:
				case LE:
				case GT:
				case GE:
				case SL:
				case SSL:
				case SR:
				case SSR:
				case STRING:
				case UNSIGNED_NUMBER:
				case REAL_NUMBER:
				case BASED_NUMBER:
				case EXPRESSION:
				case RANGE_EXPRESSION:
				case MINTYPMAX_EXPRESSION:
				case EXPR_PRIMARY_IDENTIFIER:
				case U_PLUS:
				case U_MINUS:
				case U_AND:
				case U_NAND:
				case U_OR:
				case U_NOR:
				case U_XOR:
				case U_XNOR:
				case FUNCTION_CALL_RET_ID:
				case FUNCTION_CALL_RET_EXPR:
				case EXPR_HYBRID:
				case SIZED_NUMBER:
				case K_CONCATENATION:
				case K_REPLICATION:
				{
					expr2=expression(_t);
					_t = _retTree;
#line 6708 "csl.walker.g"
					++count;
#line 18890 "CslTreeWalker.cpp"
					{
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					switch ( _t->getType()) {
					case MINUS:
					case QUESTION:
					case PLUS:
					case LNOT:
					case NOT:
					case AND:
					case NAND:
					case OR:
					case NOR:
					case XOR:
					case XNOR:
					case STAR:
					case POW:
					case DIV:
					case MOD:
					case EQUAL:
					case NOT_EQ:
					case NOT_EQ_CASE:
					case EQ_CASE:
					case LAND:
					case LOR:
					case LT_:
					case LE:
					case GT:
					case GE:
					case SL:
					case SSL:
					case SR:
					case SSR:
					case STRING:
					case UNSIGNED_NUMBER:
					case REAL_NUMBER:
					case BASED_NUMBER:
					case EXPRESSION:
					case RANGE_EXPRESSION:
					case MINTYPMAX_EXPRESSION:
					case EXPR_PRIMARY_IDENTIFIER:
					case U_PLUS:
					case U_MINUS:
					case U_AND:
					case U_NAND:
					case U_OR:
					case U_NOR:
					case U_XOR:
					case U_XNOR:
					case FUNCTION_CALL_RET_ID:
					case FUNCTION_CALL_RET_EXPR:
					case EXPR_HYBRID:
					case SIZED_NUMBER:
					case K_CONCATENATION:
					case K_REPLICATION:
					{
						expr3=expression(_t);
						_t = _retTree;
#line 6709 "csl.walker.g"
						++count;
#line 18951 "CslTreeWalker.cpp"
						break;
					}
					case 3:
					case IDENTIFIER:
					case CSL_UNIT_DEFINITION:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
					}
					}
					}
					break;
				}
				case 3:
				case IDENTIFIER:
				case CSL_UNIT_DEFINITION:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				break;
			}
			case 3:
			case IDENTIFIER:
			case CSL_UNIT_DEFINITION:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 6712 "csl.walker.g"
			
			if(count == 3) { //lower, upper and enum|enum_item
			isaField = CSLOmIsaField::build(id.second                , _RS(tok->getFilename()),
			design                   ,
			id.first                 ,
			expr1                    ,
			expr2                    ,
			CSLOmExprLink::cast(expr3));
			
			}
			else if(count == 2) {
			isaField = CSLOmIsaField::build(id.second, _RS(tok->getFilename()),
			design    ,
			id.first  ,
			expr1     ,
			expr2     );
			// I'm leaving these checks for CSLOM because of the get functions
			// if(expr1->isNumber()) { //if first expr is number
			//   if(expr2->isNumber()) { //found lower and upper
			//     isaField = CSLOmIsaField::build(id.second, _RS(#tok->getFilename()),
			//                                     design    ,
			//                                     id.first  ,
			//                                     expr1     ,
			//                                     expr2     );
			//   } 
			//   else if(expr2->isExprLink()) { //found width and enum|enum_item
			//     isaField = CSLOmIsaField::build(id.second                 , _RS(#tok->getFilename()),
			//                                     design                    ,
			//                                     id.first                  ,
			//                                     expr1                     ,
			//                                     CSLOmExprLink::cast(expr2));
			//   }
			// }
			// else if(expr1->isExprLink()) { //found bitrange
			//   if(expr2->isExprLink()) { //found enum|enum item
			//     isaField = CSLOmIsaField::build(id.second                 , _RS(#tok->getFilename()),
			//                                     design                    ,
			//                                     id.first                  ,
			//                                     expr1                     ,
			//                                     CSLOmExprLink::cast(expr2));
			//   }
			// }
			}
			else if(count == 1) {
			if(expr1->isExprLink()) { //found enum | enum_item | bitrange
			isaField = CSLOmIsaField::build(id.second                 , _RS(tok->getFilename()),
			design                    ,
			id.first                  ,
			CSLOmExprLink::cast(expr1));
			}
			else {
			//disabled the check because the expression can also be 
			//a function return
			//if(expr1->isNumber()) { //found width
			isaField = CSLOmIsaField::build(id.second, _RS(tok->getFilename()),
			design   ,
			id.first ,
			expr1    );  
			//}
			}
			} 
			else if(count == 0) {
			isaField = CSLOmIsaField::build(id.second, _RS(tok->getFilename()),
			design   ,
			id.first );
			}
			
#line 19062 "CslTreeWalker.cpp"
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case CSL_UNIT_DEFINITION:
			{
				csl_unit_definition(_t,id);
				_t = _retTree;
#line 6779 "csl.walker.g"
				hasDefinition = TRUE;
#line 19073 "CslTreeWalker.cpp"
				break;
			}
			case 3:
			case IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
		}
		else {
			goto _loop841;
		}
		
	}
	_loop841:;
	} // ( ... )*
	_t = __t835;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_isa_element_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_isa_element_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6784 "csl.walker.g"
	
	pair<RefString,int> id;
	pair<RefString,int> idParent;
	
	RefCSLOmIsaElement isaElem = RefCSLOmIsaElement();
	RefCSLOmBase       parent  = RefCSLOmBase()      ;
	RefCSLOmIdentifier name    = RefCSLOmIdentifier();
	
	TBool hasParentClass = FALSE;
	
#line 19115 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t843 = _t;
	antlr::RefCslAST tmp213_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_ISA_ELEMENT);
	_t = _t->getFirstChild();
	antlr::RefCslAST __t844 = _t;
	antlr::RefCslAST tmp214_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),CSL_ISA_ELEMENT_DECLARATION);
	_t = _t->getFirstChild();
	{
	tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	id=identifier(_t);
	_t = _retTree;
#line 6798 "csl.walker.g"
	
	if(name.get()) { parent = name->getParent(); }
	else           { parent = design;            }
	
#line 19134 "CslTreeWalker.cpp"
	}
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case PARENT_CLASS:
	{
		antlr::RefCslAST __t847 = _t;
		antlr::RefCslAST tmp215_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PARENT_CLASS);
		_t = _t->getFirstChild();
		tok1 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		idParent=identifier(_t);
		_t = _retTree;
#line 6806 "csl.walker.g"
		
		hasParentClass = TRUE; 
		RefCSLOmExprLink parentClass = CSLOmExprLink::build(idParent.second, _RS(tok1->getFilename()), idParent.first);
		RefCSLOmBase parentClassBase = parentClass->doEval();
		if(parentClassBase->isIsaElement()){
		isaElem = CSLOmIsaElement::build(id.second      , _RS(tok->getFilename()),
		parent         ,
		id.first       ,
		CSLOmIsaElement::cast(parentClassBase));
		}
		
#line 19161 "CslTreeWalker.cpp"
		_t = __t847;
		_t = _t->getNextSibling();
		break;
	}
	case 3:
	case CSL_UNIT_DEFINITION:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 6819 "csl.walker.g"
	
	if(!hasParentClass){
	isaElem = CSLOmIsaElement::build(id.second, _RS(tok->getFilename()),
	parent,
	id.first);         
	}
	
#line 19185 "CslTreeWalker.cpp"
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_UNIT_DEFINITION:
	{
		csl_unit_definition(_t,id);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t844;
	_t = _t->getNextSibling();
	_t = __t843;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_isa_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_isa_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 6899 "csl.walker.g"
	
	pair<RefString, int> id;
	RefCSLOmExpr expr = RefCSLOmExpr();
	
#line 19220 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t850 = _t;
	antlr::RefCslAST tmp216_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_ISA);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt852=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 6906 "csl.walker.g"
			
			if ( design->isScopeHolder() && 
			!(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
			//NSCSLOm::RefCSLOmIsaInstructionFormat isaIntrFormatDecl = CSLOmIsaInstructionFormat::build(id.second, _RS(#tok->getFilename()), CSLOmDesign::cast(design), id.first);
			}
			
#line 19241 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt852>=1 ) { goto _loop852; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt852++;
	}
	_loop852:;
	}  // ( ... )+
	_t = __t850;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_unit_definition(antlr::RefCslAST _t,
	 std::pair<RefString, int> id 
) {
	antlr::RefCslAST csl_unit_definition_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 6649 "csl.walker.g"
	
	pair<RefString, int> constrId;
	TBool hasEnteredScope = FALSE;
	RefCSLOmBase baseObj = RefCSLOmBase();
	
#line 19267 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t831 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),CSL_UNIT_DEFINITION);
	_t = _t->getFirstChild();
#line 6657 "csl.walker.g"
	
	RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(tok->getFilename()), id.first);
	scopeBlocks->push_back( sc );
	//This tests if it enters scope. If it doesn't the bool stays FALSE
	//and exitScope() below deos not execute thus avoiding a seg fault
	hasEnteredScope = CSLOmScopeBlock::enterScope( sc );
	RefCSLOmScope currentScope = CSLOmScopeBlock::getCurrentScope();
	//design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
	ASSERT(currentScope.get(), "current scope should not be NULL!!!");
	design = currentScope->getHolderObject();
	//retrieving the object the exprlink points at
	baseObj = sc->doEval();
	if(baseObj.get()){
	//setting object as defined
	baseObj->defineObject();
	}
	
#line 19291 "CslTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_CSL_UNIT:
		case K_CSL_LIST:
		case K_CSL_INTERFACE:
		case K_CSL_REGISTER_FILE:
		case K_CSL_REGISTER:
		case K_CSL_PORT:
		case K_CSL_SIGNAL:
		case K_CSL_BITRANGE:
		case K_CSL_SIGNAL_GROUP:
		case K_CSL_TESTBENCH:
		case K_CSL_EVENT:
		case K_CSL_INCLUDE:
		case K_CSL_ISA_FIELD:
		case K_CSL_ISA_ELEMENT:
		case K_CSL_ENUM:
		case K_CSL_FIELD:
		case K_CSL_FIFO:
		case K_CSL_MEMORY_MAP:
		case K_CSL_MEMORY_MAP_PAGE:
		case K_CSL_STATE_DATA:
		case K_CSL_VECTOR:
		case K_CSL_MEMORY:
		case K_CSL_MULTI_DIM_BITRANGE:
		case K_CSL_PARAMETER:
		case K_CSL_ISA:
		case K_CSL_DESIGN:
		case K_CSL_ADDRESS_RANGE:
		case K_CSL_BOOL_EQUATION:
		case K_CSL_SIGNAL_PATTERN_GENERATOR:
		{
			csl_declaration(_t);
			_t = _retTree;
			break;
		}
		case CSL_CSTOR:
		case CSL_INST:
		{
			csl_inst_or_cstor(_t);
			_t = _retTree;
			break;
		}
		case K_VOID:
		{
			csl_function_declaration(_t);
			_t = _retTree;
			break;
		}
		default:
		{
			goto _loop833;
		}
		}
	}
	_loop833:;
	} // ( ... )*
#line 6678 "csl.walker.g"
	
	scopeBlocks->pop_back();
	design = scopeBlocks->back();
	if(hasEnteredScope){
	CSLOmScopeBlock::exitScope();
	}
	ASSERT( scopeBlocks->size() > 0 , "The scopeBlock vector is empty!");
	
#line 19361 "CslTreeWalker.cpp"
	_t = __t831;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_inst_or_cstor(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_inst_or_cstor_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case CSL_INST:
	{
		csl_instantiation(_t);
		_t = _retTree;
		break;
	}
	case CSL_CSTOR:
	{
		csl_cstor(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
}

void CslTreeWalker::csl_build_function_declaration(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_build_function_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7006 "csl.walker.g"
	
	RefCSLOmExprLink expr;
	TBool enteredScope;
	
#line 19403 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t855 = _t;
	antlr::RefCslAST tmp217_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_VOID);
	_t = _t->getFirstChild();
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	{
		tok = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),IDENTIFIER);
		_t = _t->getNextSibling();
#line 7017 "csl.walker.g"
		
		expr = CSLOmExprLink::build(tok->getLine(), _RS(tok->getFilename()),RefString(new std::string(tok->getText())));
		CSLOmScopeBlock::enterScope(expr);
		scopeBlocks->push_back( expr );
		design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
		enteredScope = TRUE;
		
#line 19426 "CslTreeWalker.cpp"
		antlr::RefCslAST tmp218_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COLON);
		_t = _t->getNextSibling();
		antlr::RefCslAST tmp219_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COLON);
		_t = _t->getNextSibling();
		break;
	}
	case K_CSL_BUILD:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	antlr::RefCslAST tmp220_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CSL_BUILD);
	_t = _t->getNextSibling();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_CSL_UNIT:
		case K_CSL_LIST:
		case K_CSL_INTERFACE:
		case K_CSL_REGISTER_FILE:
		case K_CSL_REGISTER:
		case K_CSL_PORT:
		case K_CSL_SIGNAL:
		case K_CSL_BITRANGE:
		case K_CSL_SIGNAL_GROUP:
		case K_CSL_TESTBENCH:
		case K_CSL_EVENT:
		case K_CSL_INCLUDE:
		case K_CSL_ISA_FIELD:
		case K_CSL_ISA_ELEMENT:
		case K_CSL_ENUM:
		case K_CSL_FIELD:
		case K_CSL_FIFO:
		case K_CSL_MEMORY_MAP:
		case K_CSL_MEMORY_MAP_PAGE:
		case K_CSL_STATE_DATA:
		case K_CSL_VECTOR:
		case K_CSL_MEMORY:
		case K_CSL_MULTI_DIM_BITRANGE:
		case K_CSL_PARAMETER:
		case K_CSL_ISA:
		case K_CSL_DESIGN:
		case K_CSL_ADDRESS_RANGE:
		case K_CSL_BOOL_EQUATION:
		case K_CSL_SIGNAL_PATTERN_GENERATOR:
		{
			csl_declaration(_t);
			_t = _retTree;
			break;
		}
		case SEMI:
		{
			antlr::RefCslAST tmp221_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SEMI);
			_t = _t->getNextSibling();
			break;
		}
		default:
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_tokenSet_1.member(_t->getType()))) {
				csl_command(_t);
				_t = _retTree;
			}
		else {
			goto _loop858;
		}
		}
	}
	_loop858:;
	} // ( ... )*
	_t = __t855;
	_t = _t->getNextSibling();
#line 7032 "csl.walker.g"
	
	if (enteredScope) {
	scopeBlocks->pop_back();
	design = scopeBlocks->back();
	CSLOmScopeBlock::exitScope();
	enteredScope = FALSE;
	}
	
#line 19519 "CslTreeWalker.cpp"
	_retTree = _t;
}

void CslTreeWalker::csl_instantiation(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_instantiation_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok2 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7733 "csl.walker.g"
	
	pair<RefString, int> id, id2;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
	std::pair<RefTVec_RefCSLOmExpr, TBool> ovrParamsAndBool; 
	RefCSLOmExprLink       link = CSLOmExprLink::build(design->getLineNumber(), design->getFileName(), CSLOmScopeBlock::getCurrentScopeName());
	RefCSLOmExpr mem_page_inst_param = RefCSLOmExpr();
	//RefCSLOmExprLink overrideScope = RefCSLOmExprLink();
	TBool hasParamOvr = FALSE;
	
#line 19537 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t913 = _t;
	antlr::RefCslAST tmp222_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),CSL_INST);
	_t = _t->getFirstChild();
	{
	tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	id=identifier(_t);
	_t = _retTree;
#line 7745 "csl.walker.g"
	
	RefCSLOmExprLink expr = CSLOmExprLink::build(id.second, _RS(tok->getFilename()), id.first);
	params->push_back(expr);
	
#line 19552 "CslTreeWalker.cpp"
	}
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNIT_PARAMETER:
	{
		ovrParamsAndBool=parameter_overriding_instantiation(_t);
		_t = _retTree;
#line 7754 "csl.walker.g"
		
		ASSERT(ovrParamsAndBool.first.get() , "walker: csl_instantiation rule: parameter_overriding_instantiation returned null.");
		hasParamOvr = TRUE; 
		
#line 19567 "CslTreeWalker.cpp"
		break;
	}
	case IDENTIFIER:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )+
	int _cnt918=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok2 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			id2=identifier(_t);
			_t = _retTree;
#line 7761 "csl.walker.g"
			
			RefCSLOmExprLink expr2 = CSLOmExprLink::build(id2.second, _RS(tok2->getFilename()), id2.first);
			params->push_back(expr2);
			if(hasParamOvr) {
			//DCERR("walker: param ovr:" << ovrParamsAndBool.first.get() << endl);
			//ASSERT(ovrParamsAndBool.first.get() , "walker: csl_instantiation rule: parameter_overriding_instantiation returned null.");
			ovrParamsAndBool.first->insert(ovrParamsAndBool.first->begin(), expr2);
			}
			
			
#line 19600 "CslTreeWalker.cpp"
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING:
			{
				param_list_formal_to_actual_mapping(_t, params );
				_t = _retTree;
				break;
			}
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				mem_page_inst_param=expression(_t);
				_t = _retTree;
				break;
			}
			case 3:
			case IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 7776 "csl.walker.g"
			
			//CSLOmCmdAddInstanceAll::build(id2.second, _RS(#tok->getFilename()), design, link, params);
			CSLOmSetCommand::build(id2.second, _RS(tok2->getFilename()), design, link, NSCSLOm::TYPE_CMD_ADD_INSTANCE_ALL, params);
			params->erase(++(params->begin()),params->end());
			
			if(hasParamOvr) {
			hasParamOvr = FALSE;
			if(ovrParamsAndBool.second == TRUE) {
			CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, link, NSCSLOm::TYPE_CMD_OVERRIDE_PARAMETER_NAMED, ovrParamsAndBool.first);
			}
			else {
			CSLOmSetCommand::build(tok->getLine(), _RS(tok->getFilename()), design, link, NSCSLOm::TYPE_CMD_OVERRIDE_PARAMETER_ORDERED, ovrParamsAndBool.first);
			}
			}
			//params->pop_back();
			
#line 19695 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt918>=1 ) { goto _loop918; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt918++;
	}
	_loop918:;
	}  // ( ... )+
	_t = __t913;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void CslTreeWalker::csl_cstor(antlr::RefCslAST _t) {
	antlr::RefCslAST csl_cstor_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7913 "csl.walker.g"
	
	RefCSLOmExprLink expr;
	//TBool enteredScope;
	
#line 19718 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t928 = _t;
	antlr::RefCslAST tmp223_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),CSL_CSTOR);
	_t = _t->getFirstChild();
	tok = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),IDENTIFIER);
	_t = _t->getNextSibling();
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_1.member(_t->getType()))) {
			csl_command(_t);
			_t = _retTree;
		}
		else if ((_t->getType() == SEMI)) {
			antlr::RefCslAST tmp224_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SEMI);
			_t = _t->getNextSibling();
		}
		else {
			goto _loop930;
		}
		
	}
	_loop930:;
	} // ( ... )*
	_t = __t928;
	_t = _t->getNextSibling();
	_retTree = _t;
}

std::pair<NSCSLOm::RefTVec_RefCSLOmExpr, TBool>  CslTreeWalker::parameter_overriding_instantiation(antlr::RefCslAST _t) {
#line 7796 "csl.walker.g"
	std::pair<NSCSLOm::RefTVec_RefCSLOmExpr, TBool> paramsAndBool;
#line 19755 "CslTreeWalker.cpp"
	antlr::RefCslAST parameter_overriding_instantiation_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 7796 "csl.walker.g"
	
	//RefCSLOmExprLink scope = RefCSLOmExprLink();
	//RefCSLOmExprLink scope = overrideScope;
	RefCSLOmExpr expr, expr_formal, expr_actual;
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
	TBool isNamedParamAssn = FALSE;
	
#line 19766 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t920 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UNIT_PARAMETER);
	_t = _t->getFirstChild();
	{
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING:
	{
		{
		param_list_formal_to_actual_mapping(_t, params );
		_t = _retTree;
#line 7807 "csl.walker.g"
		
		//CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_OVERRIDE_PARAMETER_NAMED, params);
		isNamedParamAssn = TRUE;
		
#line 19787 "CslTreeWalker.cpp"
		}
		break;
	}
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	case K_SKIP_PARAMETER:
	{
		{
		{ // ( ... )+
		int _cnt926=0;
		for (;;) {
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case EXPRESSION:
			case RANGE_EXPRESSION:
			case MINTYPMAX_EXPRESSION:
			case EXPR_PRIMARY_IDENTIFIER:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case FUNCTION_CALL_RET_ID:
			case FUNCTION_CALL_RET_EXPR:
			case EXPR_HYBRID:
			case SIZED_NUMBER:
			case K_CONCATENATION:
			case K_REPLICATION:
			{
				expr=expression(_t);
				_t = _retTree;
#line 7812 "csl.walker.g"
				params->push_back(expr);
#line 19907 "CslTreeWalker.cpp"
				break;
			}
			case K_SKIP_PARAMETER:
			{
				antlr::RefCslAST tmp225_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SKIP_PARAMETER);
				_t = _t->getNextSibling();
#line 7813 "csl.walker.g"
				params->push_back(RefCSLOmExpr());
#line 19917 "CslTreeWalker.cpp"
				break;
			}
			default:
			{
				if ( _cnt926>=1 ) { goto _loop926; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			}
			_cnt926++;
		}
		_loop926:;
		}  // ( ... )+
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 7815 "csl.walker.g"
	
	//if(!isNamedParamAssn){
	//  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_OVERRIDE_PARAMETER_ORDERED, params);
	//}
	ASSERT(params.get() && params->size(), "walker: param ovr rule: ovr list is either null or empty.");
	//    DCERR("f2a map: " << params.get() << " " << params->size() << endl);
	paramsAndBool = make_pair(params, isNamedParamAssn);
	
#line 19947 "CslTreeWalker.cpp"
	}
	_t = __t920;
	_t = _t->getNextSibling();
	_retTree = _t;
	return paramsAndBool;
}

void CslTreeWalker::param_list_csl_list(antlr::RefCslAST _t,
	NSCSLOm::RefCSLOmList list
) {
	antlr::RefCslAST param_list_csl_list_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 8325 "csl.walker.g"
	
	RefCSLOmExpr expr;
	RefCSLOmExprLink item;
	
#line 19964 "CslTreeWalker.cpp"
	
	{ // ( ... )+
	int _cnt976=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
#line 8331 "csl.walker.g"
			
			item = boost::static_pointer_cast<CSLOmExprLink>( expr );
			list->addItemToList(item);
			
#line 19979 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt976>=1 ) { goto _loop976; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt976++;
	}
	_loop976:;
	}  // ( ... )+
	_retTree = _t;
}

NSCSLOm::RefCSLOmList  CslTreeWalker::csl_anonymous_list_declaration(antlr::RefCslAST _t) {
#line 8025 "csl.walker.g"
	NSCSLOm::RefCSLOmList anonymousList;
#line 19995 "CslTreeWalker.cpp"
	antlr::RefCslAST csl_anonymous_list_declaration_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST list = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8025 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	RefTVec_RefCSLOmExprLink vl;
	
#line 20003 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t941 = _t;
	list = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),CSL_LIST);
	_t = _t->getFirstChild();
#line 8031 "csl.walker.g"
	
	//std::cerr << "before build" << std::endl;
	anonymousList = CSLOmList::build(list->getLine(), _RS(list->getFilename()), design);
	//std::cerr << "after build" << std::endl;
	ASSERT(anonymousList.get(),"BUHUHU");
	
#line 20016 "CslTreeWalker.cpp"
	param_list_csl_list(_t, anonymousList );
	_t = _retTree;
	_t = __t941;
	_t = _t->getNextSibling();
	_retTree = _t;
	return anonymousList;
}

void CslTreeWalker::csl_enum_item(antlr::RefCslAST _t,
	pair <RefString,int>& id
) {
	antlr::RefCslAST csl_enum_item_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok2 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8149 "csl.walker.g"
	
	RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
	RefCSLOmExprLink link;
	pair <RefString,int> id2;
	RefCSLOmExpr number = RefCSLOmExpr();
	//TBool hasMinus = FALSE;
	
#line 20039 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t952 = _t;
	antlr::RefCslAST tmp226_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ENUM_ITEM);
	_t = _t->getFirstChild();
	tok2 = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	id2=identifier(_t);
	_t = _retTree;
#line 8161 "csl.walker.g"
	
	link = CSLOmExprLink::build(id.second, _RS(tok2->getFilename()), id.first);
	//std::cerr << "before expr2 build:" << *(id2.first) << std::endl;
	RefCSLOmExprLink expr2 = CSLOmExprLink::build(id2.second, _RS(tok2->getFilename()), id2.first);
	params->push_back(expr2);
	
#line 20055 "CslTreeWalker.cpp"
	{
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case EXPRESSION:
	case RANGE_EXPRESSION:
	case MINTYPMAX_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case FUNCTION_CALL_RET_ID:
	case FUNCTION_CALL_RET_EXPR:
	case EXPR_HYBRID:
	case SIZED_NUMBER:
	case K_CONCATENATION:
	case K_REPLICATION:
	{
		tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		number=expression(_t);
		_t = _retTree;
#line 8180 "csl.walker.g"
		
		params->push_back(number);
		
#line 20119 "CslTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 8191 "csl.walker.g"
	
	//CSLOmCmdEnumAddPair::build(id.second, _RS(#tok->getFilename()), design, link, params );
	CSLOmSetCommand::build(id.second, _RS(tok2->getFilename()), design, link, NSCSLOm::TYPE_CMD_ADD_PAIR, params );
	
	params->clear();
	//</added by Alina>
	
#line 20140 "CslTreeWalker.cpp"
	_t = __t952;
	_t = _t->getNextSibling();
	_retTree = _t;
}

NSCSLOm::RefCSLOmExprConcat  CslTreeWalker::concatenation(antlr::RefCslAST _t) {
#line 8341 "csl.walker.g"
	NSCSLOm::RefCSLOmExprConcat retExpConcat;
#line 20149 "CslTreeWalker.cpp"
	antlr::RefCslAST concatenation_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST concat = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8341 "csl.walker.g"
	NSCSLOm::RefCSLOmExpr expr;
#line 20154 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t978 = _t;
	concat = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CONCATENATION);
	_t = _t->getFirstChild();
	{
	expr=expression(_t);
	_t = _retTree;
#line 8344 "csl.walker.g"
	retExpConcat = CSLOmExprConcat::build( concat->getLine(), _RS(concat->getFilename()), expr );
#line 20165 "CslTreeWalker.cpp"
	}
	{ // ( ... )*
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
#line 8345 "csl.walker.g"
			retExpConcat->addExpr(expr);
#line 20176 "CslTreeWalker.cpp"
		}
		else {
			goto _loop981;
		}
		
	}
	_loop981:;
	} // ( ... )*
	_t = __t978;
	_t = _t->getNextSibling();
	_retTree = _t;
	return retExpConcat;
}

NSCSLOm::RefCSLOmExprMultiConcat  CslTreeWalker::multiple_concatenation(antlr::RefCslAST _t) {
#line 8350 "csl.walker.g"
	NSCSLOm::RefCSLOmExprMultiConcat retExpr;
#line 20194 "CslTreeWalker.cpp"
	antlr::RefCslAST multiple_concatenation_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8350 "csl.walker.g"
	
	NSCSLOm::RefCSLOmExpr expr = RefCSLOmExpr();
	NSCSLOm::RefCSLOmExprConcat exprConcat = RefCSLOmExprConcat();
	//NSCSLOm::RefCSLOmExprMultiConcat retExprConcat = RefCSLOmExprMultiConcat();
	
#line 20203 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t983 = _t;
	tok = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REPLICATION);
	_t = _t->getFirstChild();
	{
	expr=expression(_t);
	_t = _retTree;
	exprConcat=concatenation(_t);
	_t = _retTree;
	}
#line 8359 "csl.walker.g"
	
	retExpr = CSLOmExprMultiConcat::build( tok->getLine(), _RS(tok->getFilename()), expr, exprConcat);
	
#line 20219 "CslTreeWalker.cpp"
	_t = __t983;
	_t = _t->getNextSibling();
	_retTree = _t;
	return retExpr;
}

NSCSLOm::RefCSLOmList  CslTreeWalker::expression_list(antlr::RefCslAST _t) {
#line 8366 "csl.walker.g"
	NSCSLOm::RefCSLOmList retList;
#line 20229 "CslTreeWalker.cpp"
	antlr::RefCslAST expression_list_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 8366 "csl.walker.g"
	
	NSCSLOm::RefCSLOmExpr expr;
	
#line 20235 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t986 = _t;
	antlr::RefCslAST tmp227_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EXPRESSION_LIST);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt988=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
#line 8372 "csl.walker.g"
			//TODO add to the retList expr
			
#line 20252 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt988>=1 ) { goto _loop988; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt988++;
	}
	_loop988:;
	}  // ( ... )+
	_t = __t986;
	_t = _t->getNextSibling();
	_retTree = _t;
	return retList;
}

NSCSLOm::RefCSLOmExpr  CslTreeWalker::expr_primary(antlr::RefCslAST _t) {
#line 8620 "csl.walker.g"
	NSCSLOm::RefCSLOmExpr expr;
#line 20271 "CslTreeWalker.cpp"
	antlr::RefCslAST expr_primary_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8620 "csl.walker.g"
	
	NSCSLOm::RefCSLOmExprLink exprPrimId;
	RefCSLOmExprConcat exprConcat;
	RefString s;
	RefCSLOmExprLink exprLink;
	
#line 20281 "CslTreeWalker.cpp"
	
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case SIZED_NUMBER:
	{
		expr=number(_t);
		_t = _retTree;
		break;
	}
	case STRING:
	{
		tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		s=str(_t);
		_t = _retTree;
#line 8629 "csl.walker.g"
		
		//Trying string
		//expr = CSLOmExprLink::build(5, _RS(#tok->getFilename()),s);
		//expr = CSLOmExpr::cast(exprLink);
		expr = CSLOmString::build(tok->getLine(), _RS(tok->getFilename()),s);
		
#line 20307 "CslTreeWalker.cpp"
		break;
	}
	case EXPR_PRIMARY_IDENTIFIER:
	{
		expr=expr_primary_identifier(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return expr;
}

NSCSLOm::RefCSLOmExprLink  CslTreeWalker::expression_hybrid(antlr::RefCslAST _t) {
#line 8671 "csl.walker.g"
	NSCSLOm::RefCSLOmExprLink retExprLink;
#line 20328 "CslTreeWalker.cpp"
	antlr::RefCslAST expression_hybrid_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 8671 "csl.walker.g"
	
	pair<RefString, TULong> id;
	RefCSLOmExpr expr;
	
#line 20335 "CslTreeWalker.cpp"
	
	expr=returning_exlink_rules(_t);
	_t = _retTree;
#line 8677 "csl.walker.g"
	
	//std::cerr << "found expression_hybrid" << endl;
	
#line 20343 "CslTreeWalker.cpp"
	_retTree = _t;
	return retExprLink;
}

NSCSLOm::RefCSLOmExpr  CslTreeWalker::function_call_ret_id(antlr::RefCslAST _t) {
#line 8713 "csl.walker.g"
	NSCSLOm::RefCSLOmExpr link;
#line 20351 "CslTreeWalker.cpp"
	antlr::RefCslAST function_call_ret_id_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 8713 "csl.walker.g"
	
	RefCSLOmExpr expr = RefCSLOmExpr();
	pair< RefString, int > id;
	//RefCSLOmExprLink link;
	
#line 20359 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t1048 = _t;
	antlr::RefCslAST tmp228_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),FUNCTION_CALL_RET_ID);
	_t = _t->getFirstChild();
#line 8720 "csl.walker.g"
	
	DCERR("____XXXXXXXXXX____MATCHED A FUNCTION CALL RET ID");
	
#line 20369 "CslTreeWalker.cpp"
	link=returning_exlink_rules(_t);
	_t = _retTree;
	_t = __t1048;
	_t = _t->getNextSibling();
	_retTree = _t;
	return link;
}

NSCSLOm::RefCSLOmExpr  CslTreeWalker::function_call_ret_expr(antlr::RefCslAST _t) {
#line 9072 "csl.walker.g"
	NSCSLOm::RefCSLOmExpr expr;
#line 20381 "CslTreeWalker.cpp"
	antlr::RefCslAST function_call_ret_expr_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 9072 "csl.walker.g"
	
	pair <RefString,int> id;
	
#line 20387 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t1101 = _t;
	antlr::RefCslAST tmp229_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),FUNCTION_CALL_RET_EXPR);
	_t = _t->getFirstChild();
	{
	expr=returning_exlink_rules(_t);
	_t = _retTree;
	}
	_t = __t1101;
	_t = _t->getNextSibling();
	_retTree = _t;
	return expr;
}

NSCSLOm::RefCSLOmExpr  CslTreeWalker::number(antlr::RefCslAST _t) {
#line 9083 "csl.walker.g"
	NSCSLOm::RefCSLOmExpr expr;
#line 20406 "CslTreeWalker.cpp"
	antlr::RefCslAST number_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST unr1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST basedNumber = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST realNumber = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 9083 "csl.walker.g"
	
	CCSLOmAdapter* adapter = CCSLOmAdapter::getInstance();
	RefCSLOmExpr ex;
	
#line 20416 "CslTreeWalker.cpp"
	
	if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	{
		{
		unr1 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UNSIGNED_NUMBER);
		_t = _t->getNextSibling();
		}
#line 9089 "csl.walker.g"
		//cerr << " Before number building\n";
		expr = adapter->convertToCSLOmNumberFrom_UNSIGNED_NUMBER(unr1->getLine(),_RS(unr1->getFilename()), unr1->getNumber()); 
		//cerr << "-------> " << #unr1->getNumber() << endl;
		//cerr << "-->>>>>> " << CSLOmNumber::cast(#expr)->getValue() << endl;
		
#line 20434 "CslTreeWalker.cpp"
		break;
	}
	case SIZED_NUMBER:
	{
		expr=sized_number(_t);
		_t = _retTree;
		break;
	}
	case BASED_NUMBER:
	{
		basedNumber = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),BASED_NUMBER);
		_t = _t->getNextSibling();
#line 9096 "csl.walker.g"
		expr = adapter->convertToCSLOmNumberFrom_BASED_NUMBER(basedNumber->getLine(),_RS(basedNumber->getFilename()), basedNumber->getNumber());
#line 20450 "CslTreeWalker.cpp"
		break;
	}
	case REAL_NUMBER:
	{
		realNumber = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),REAL_NUMBER);
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return expr;
}

 RefString  CslTreeWalker::str(antlr::RefCslAST _t) {
#line 9111 "csl.walker.g"
	 RefString retStr ;
#line 20472 "CslTreeWalker.cpp"
	antlr::RefCslAST str_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST str = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	str = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),STRING);
	_t = _t->getNextSibling();
#line 9113 "csl.walker.g"
	retStr = _RS(str->getText());
#line 20481 "CslTreeWalker.cpp"
	_retTree = _t;
	return retStr ;
}

NSCSLOm::RefCSLOmExprLink  CslTreeWalker::expr_primary_identifier(antlr::RefCslAST _t) {
#line 8640 "csl.walker.g"
	NSCSLOm::RefCSLOmExprLink retExprLink;
#line 20489 "CslTreeWalker.cpp"
	antlr::RefCslAST expr_primary_identifier_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8640 "csl.walker.g"
	
	pair<RefString, TULong> str;
	RefString id;
	//  RefCSLOmExpr currentExpr = RefCSLOmExpr(), previousExpr = RefCSLOmExpr();
	retExprLink = RefCSLOmExprLink();
	int count = 0;
	NSCSLOm::RefCSLOmExpr expr;
	
#line 20501 "CslTreeWalker.cpp"
	
	antlr::RefCslAST __t1041 = _t;
	antlr::RefCslAST tmp230_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EXPR_PRIMARY_IDENTIFIER);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt1043=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER)) {
			tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			str=identifier(_t);
			_t = _retTree;
#line 8651 "csl.walker.g"
			
			if( retExprLink.get() ) {
			retExprLink->addHidItem( str.first );
			}
			else {
			retExprLink = CSLOmExprLink::build( str.second, _RS(tok->getFilename()), str.first );
			}
			count ++;
			
#line 20526 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt1043>=1 ) { goto _loop1043; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt1043++;
	}
	_loop1043:;
	}  // ( ... )+
	_t = __t1041;
	_t = _t->getNextSibling();
	_retTree = _t;
	return retExprLink;
}

NSCSLOm::RefCSLOmExprHybridOrFuncCall  CslTreeWalker::returning_exlink_rules(antlr::RefCslAST _t) {
#line 8728 "csl.walker.g"
	NSCSLOm::RefCSLOmExprHybridOrFuncCall exprAll;
#line 20545 "CslTreeWalker.cpp"
	antlr::RefCslAST returning_exlink_rules_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok1 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok2 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok3 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok4 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok5 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok6 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok7 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok8 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok9 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok10 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok11 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok12 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok13 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok14 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok15 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok16 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok17 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok18 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok19 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok20 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok21 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok22 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok23 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok24 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok25 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST tok26 = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8728 "csl.walker.g"
	
	pair< RefString, int > id;
	RefCSLOmExprLink exlink;
	RefCSLOmExpr expr;
	RefCSLOmExprLink object;
	RefCSLOmListExpr args;
	RefCSLOmExprLink exprLinkAll;
	RefCSLOmExprFuncSignature exprFuncSignAll;
	exprAll = RefCSLOmExprHybridOrFuncCall();
	
#line 20584 "CslTreeWalker.cpp"
	
	{ // ( ... )+
	int _cnt1099=0;
	for (;;) {
		if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_3.member(_t->getType()))) {
#line 8741 "csl.walker.g"
			
			exprLinkAll = RefCSLOmExprLink();
			exprFuncSignAll = RefCSLOmExprFuncSignature();
			
#line 20597 "CslTreeWalker.cpp"
			{
			if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case K_GET_TYPE:
			{
				tok1 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_TYPE);
				_t = _t->getNextSibling();
#line 8747 "csl.walker.g"
				
				//exprFuncSignAll = CSLOmExprFuncSignature::build(#tok1->getLine(), _RS(#tok->getFilename()),GET_TYPE);
				DCERR(">>>>> GET TYPE" << std::endl);
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok1->getLine(), _RS(tok1->getFilename()),GET_TYPE, args);
				if(exprFuncSignAll.get()){
				DCERR("<<<<< GET TYPE" << std::endl);
				}
				
#line 20616 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_INTERFACE:
			{
				tok2 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_INTERFACE);
				_t = _t->getNextSibling();
#line 8756 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 20629 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8761 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok2->getLine(), _RS(tok2->getFilename()),expr);
						
#line 20641 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1053;
					}
					
				}
				_loop1053:;
				} // ( ... )*
#line 8765 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok2->getLine(), _RS(tok2->getFilename()),GET_INTERFACE,args);
				
#line 20654 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_REVERSED_INTERFACE:
			{
				tok3 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_REVERSED_INTERFACE);
				_t = _t->getNextSibling();
#line 8769 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 20667 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8774 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok3->getLine(), _RS(tok3->getFilename()),expr);
						
#line 20679 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1055;
					}
					
				}
				_loop1055:;
				} // ( ... )*
#line 8778 "csl.walker.g"
				
				//exprFuncSignAll = CSLOmExprFuncSignature::build(#tok3->getLine(), _RS(#tok->getFilename()),GET_REVERSED_INTERFACE);
				
#line 20692 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_UNIT_PREFIX:
			{
				tok4 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_UNIT_PREFIX);
				_t = _t->getNextSibling();
#line 8782 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 20705 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8787 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok4->getLine(), _RS(tok4->getFilename()),expr);
						
#line 20717 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1057;
					}
					
				}
				_loop1057:;
				} // ( ... )*
#line 8791 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok4->getLine(), _RS(tok4->getFilename()),GET_UNIT_PREFIX,args);
				
#line 20730 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_SIGNAL_PREFIX:
			{
				tok5 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_SIGNAL_PREFIX);
				_t = _t->getNextSibling();
#line 8795 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 20743 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8800 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok5->getLine(), _RS(tok5->getFilename()),expr);
						
#line 20755 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1059;
					}
					
				}
				_loop1059:;
				} // ( ... )*
#line 8804 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok5->getLine(), _RS(tok5->getFilename()),GET_SIGNAL_PREFIX,args);
				
#line 20768 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_SIGNAL_PREFIX_LOCAL:
			{
				tok6 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_SIGNAL_PREFIX_LOCAL);
				_t = _t->getNextSibling();
#line 8808 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 20781 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8813 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok6->getLine(), _RS(tok6->getFilename()),expr);
						
#line 20793 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1061;
					}
					
				}
				_loop1061:;
				} // ( ... )*
#line 8817 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok6->getLine(), _RS(tok6->getFilename()),GET_SIGNAL_PREFIX_LOCAL,args);
				
#line 20806 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_BITRANGE:
			{
				tok7 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_BITRANGE);
				_t = _t->getNextSibling();
#line 8821 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 20819 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8826 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok7->getLine(), _RS(tok7->getFilename()),expr);
						
#line 20831 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1063;
					}
					
				}
				_loop1063:;
				} // ( ... )*
#line 8830 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok7->getLine(), _RS(tok7->getFilename()),GET_BITRANGE,args);
				
#line 20844 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_DIM_BITRANGE:
			{
				tok8 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_DIM_BITRANGE);
				_t = _t->getNextSibling();
#line 8834 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 20857 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8839 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok8->getLine(), _RS(tok8->getFilename()),expr);
						
#line 20869 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1065;
					}
					
				}
				_loop1065:;
				} // ( ... )*
#line 8843 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok8->getLine(), _RS(tok8->getFilename()),GET_DIM_BITRANGE,args);
				object = boost::static_pointer_cast<CSLOmExprLink>( expr );
				
#line 20883 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_ATTR:
			{
				tok9 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_ATTR);
				_t = _t->getNextSibling();
#line 8848 "csl.walker.g"
				
				//exprFuncSignAll = CSLOmExprFuncSignature::build(#tok9->getLine(), _RS(#tok->getFilename()),GET_ATTR);
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok9->getLine(), _RS(tok9->getFilename()),GET_ATTR, args);
				
#line 20896 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_CELL:
			{
				tok10 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_CELL);
				_t = _t->getNextSibling();
#line 8853 "csl.walker.g"
				
				//exprFuncSignAll = CSLOmExprFuncSignature::build(#tok10->getLine(), _RS(#tok->getFilename()),GET_CELL);
				
#line 20908 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_WIDTH:
			{
				tok11 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_WIDTH);
				_t = _t->getNextSibling();
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8858 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok11->getLine(), _RS(tok11->getFilename()),expr);
						
#line 20927 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1067;
					}
					
				}
				_loop1067:;
				} // ( ... )*
#line 8862 "csl.walker.g"
				
				//std::cerr << "I am in get_width" << std::cerr << endl;
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok11->getLine(), _RS(tok11->getFilename()),GET_WIDTH,args);     
				
#line 20941 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_DIM_WIDTH:
			{
				{
				tok12 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_DIM_WIDTH);
				_t = _t->getNextSibling();
#line 8867 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 20955 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8872 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok12->getLine(), _RS(tok12->getFilename()),expr);
						
#line 20967 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1070;
					}
					
				}
				_loop1070:;
				} // ( ... )*
				}
#line 8877 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok12->getLine(), _RS(tok12->getFilename()),GET_DIM_WIDTH,args);
				
#line 20981 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_UPPER_INDEX:
			{
				tok13 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_UPPER_INDEX);
				_t = _t->getNextSibling();
#line 8881 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 20994 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8886 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok13->getLine(), _RS(tok13->getFilename()),expr);
						
#line 21006 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1072;
					}
					
				}
				_loop1072:;
				} // ( ... )*
#line 8890 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok13->getLine(), _RS(tok13->getFilename()),GET_UPPER_INDEX,args);
				
#line 21019 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_DIM_UPPER_INDEX:
			{
				tok14 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_DIM_UPPER_INDEX);
				_t = _t->getNextSibling();
#line 8894 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 21032 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8899 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok14->getLine(), _RS(tok14->getFilename()),expr);
						
#line 21044 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1074;
					}
					
				}
				_loop1074:;
				} // ( ... )*
#line 8903 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok14->getLine(), _RS(tok14->getFilename()),GET_DIM_UPPER_INDEX,args);
				
#line 21057 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_LOWER_INDEX:
			{
				tok15 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_LOWER_INDEX);
				_t = _t->getNextSibling();
#line 8907 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 21070 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8912 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok15->getLine(), _RS(tok15->getFilename()),expr);
						
#line 21082 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1076;
					}
					
				}
				_loop1076:;
				} // ( ... )*
#line 8916 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok15->getLine(), _RS(tok15->getFilename()),GET_LOWER_INDEX,args);
				
#line 21095 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_DIM_LOWER_INDEX:
			{
				tok16 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_DIM_LOWER_INDEX);
				_t = _t->getNextSibling();
#line 8920 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 21108 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8925 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok16->getLine(), _RS(tok16->getFilename()),expr);
						
#line 21120 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1078;
					}
					
				}
				_loop1078:;
				} // ( ... )*
#line 8929 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok16->getLine(), _RS(tok16->getFilename()),GET_DIM_LOWER_INDEX,args);
				
#line 21133 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_OFFSET:
			{
				tok17 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_OFFSET);
				_t = _t->getNextSibling();
#line 8933 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 21146 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8938 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok17->getLine(), _RS(tok17->getFilename()),expr);
						
#line 21158 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1080;
					}
					
				}
				_loop1080:;
				} // ( ... )*
#line 8942 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok17->getLine(), _RS(tok17->getFilename()),GET_OFFSET,args);
				
#line 21171 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_DIM_OFFSET:
			{
				tok18 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_DIM_OFFSET);
				_t = _t->getNextSibling();
#line 8946 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 21184 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8951 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok18->getLine(), _RS(tok18->getFilename()),expr);
						
#line 21196 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1082;
					}
					
				}
				_loop1082:;
				} // ( ... )*
#line 8955 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok18->getLine(), _RS(tok18->getFilename()),GET_DIM_OFFSET,args);
				
#line 21209 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_TRANSACTION_TIMEOUT_COUNTER:
			{
				tok19 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_TRANSACTION_TIMEOUT_COUNTER);
				_t = _t->getNextSibling();
#line 8959 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 21222 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8964 "csl.walker.g"
						
						//args = CSLOmListExpr::build(#tok19->getLine(), _RS(#tok->getFilename()),expr);
						
#line 21234 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1084;
					}
					
				}
				_loop1084:;
				} // ( ... )*
#line 8968 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok19->getLine(), _RS(tok19->getFilename()),GET_DIM_OFFSET,args);
				
#line 21247 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_SIMULATION_TIMEOUT_COUNTER:
			{
				tok20 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_SIMULATION_TIMEOUT_COUNTER);
				_t = _t->getNextSibling();
#line 8972 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 21260 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8977 "csl.walker.g"
						
						//args = CSLOmListExpr::build(#tok19->getLine(), _RS(#tok->getFilename()),expr);
						
#line 21272 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1086;
					}
					
				}
				_loop1086:;
				} // ( ... )*
#line 8981 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok20->getLine(), _RS(tok20->getFilename()),GET_DIM_OFFSET,args);
				
#line 21285 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_NAME:
			{
				tok21 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_NAME);
				_t = _t->getNextSibling();
#line 8985 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 21298 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 8990 "csl.walker.g"
						
						args = CSLOmListExpr::build(tok21->getLine(), _RS(tok21->getFilename()),expr);
						
#line 21310 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1088;
					}
					
				}
				_loop1088:;
				} // ( ... )*
#line 8994 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok21->getLine(), _RS(tok21->getFilename()),GET_NAME,args);
				
#line 21323 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_COMPARE_TRIGGER:
			{
				tok22 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_COMPARE_TRIGGER);
				_t = _t->getNextSibling();
#line 8998 "csl.walker.g"
				
				//args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
				//std::cerr << "after RefCSLOm()" << std::endl;
				
#line 21336 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
#line 9003 "csl.walker.g"
						
						//args = CSLOmListExpr::build(#tok19->getLine(), _RS(#tok->getFilename()),expr);
						
#line 21348 "CslTreeWalker.cpp"
					}
					else {
						goto _loop1090;
					}
					
				}
				_loop1090:;
				} // ( ... )*
				break;
			}
			case K_GET_VALUE:
			{
				tok23 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_VALUE);
				_t = _t->getNextSibling();
#line 9008 "csl.walker.g"
				
				
#line 21367 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
					}
					else {
						goto _loop1092;
					}
					
				}
				_loop1092:;
				} // ( ... )*
#line 9012 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok23->getLine(), _RS(tok23->getFilename()),GET_VALUE, args);
				
#line 21387 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_ENUM:
			{
				tok24 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_ENUM);
				_t = _t->getNextSibling();
#line 9016 "csl.walker.g"
				
				
#line 21398 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
					}
					else {
						goto _loop1094;
					}
					
				}
				_loop1094:;
				} // ( ... )*
#line 9020 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok24->getLine(), _RS(tok24->getFilename()),GET_ENUM, args);
				
#line 21418 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_ENUM_ITEM:
			{
				tok25 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_ENUM_ITEM);
				_t = _t->getNextSibling();
#line 9024 "csl.walker.g"
				
				
#line 21429 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
					}
					else {
						goto _loop1096;
					}
					
				}
				_loop1096:;
				} // ( ... )*
#line 9028 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok25->getLine(), _RS(tok25->getFilename()),GET_ENUM_ITEM, args);
				
#line 21449 "CslTreeWalker.cpp"
				break;
			}
			case K_GET_ASM_MNEMONIC:
			{
				tok26 = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GET_ASM_MNEMONIC);
				_t = _t->getNextSibling();
#line 9032 "csl.walker.g"
				
				
#line 21460 "CslTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_2.member(_t->getType()))) {
						expr=expression(_t);
						_t = _retTree;
					}
					else {
						goto _loop1098;
					}
					
				}
				_loop1098:;
				} // ( ... )*
#line 9036 "csl.walker.g"
				
				exprFuncSignAll = CSLOmExprFuncSignature::build(tok26->getLine(), _RS(tok26->getFilename()),GET_ASM_MNEMONIC, args);
				
#line 21480 "CslTreeWalker.cpp"
				break;
			}
			case IDENTIFIER:
			{
				exprLinkAll=get_exprlink_from_identifier(_t);
				_t = _retTree;
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 9041 "csl.walker.g"
			
			if(exprFuncSignAll.get()){
			DCERR("<<<<< IT EXISTS HERE!!!!!!!!!!!!!!!!!!!!!!!!!!"<<std::endl);
			}
			
#line 21501 "CslTreeWalker.cpp"
#line 9046 "csl.walker.g"
			
			//std::cerr << "exprAll.get(): " << exprAll.get() << std::endl;
			//std::cerr << "exprFuncSignAll.get(): " << exprFuncSignAll.get() << std::endl;
			if(!exprAll.get()) {
			DCERR(">>>>> Func sig all")
			if(exprFuncSignAll.get()) {
			DCERR(">>>>> exprFuncSigAll" << std::endl);
			exprAll = CSLOmExprHybridOrFuncCall::build(10, RefString(new std::string("FILENAME")), exprFuncSignAll); //to do correct line number
			} else if(exprLinkAll.get()) {
			DCERR(">>>>> exprLinkAll" << std::endl);
			exprAll = CSLOmExprHybridOrFuncCall::build(10, RefString(new std::string("FILENAME")), exprLinkAll); //to do correct line number
			}
			} 
			else {
			if(exprFuncSignAll.get()) {
			//std::cerr << "I am in add functionSignature" << std::endl;
			exprAll->addFunctionSignature(exprFuncSignAll);
			} else if(exprLinkAll.get()) {
			//std::cerr << "I am in add objectName" << std::endl;
			exprAll->addObjectName(exprLinkAll);
			}
			}
			
#line 21526 "CslTreeWalker.cpp"
		}
		else {
			if ( _cnt1099>=1 ) { goto _loop1099; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt1099++;
	}
	_loop1099:;
	}  // ( ... )+
	_retTree = _t;
	return exprAll;
}

NSCSLOm::RefCSLOmExprLink  CslTreeWalker::get_exprlink_from_identifier(antlr::RefCslAST _t) {
#line 8682 "csl.walker.g"
	NSCSLOm::RefCSLOmExprLink retExprLink;
#line 21543 "CslTreeWalker.cpp"
	antlr::RefCslAST get_exprlink_from_identifier_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST tok = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 8682 "csl.walker.g"
	
	pair<RefString,int> str;
	
#line 21550 "CslTreeWalker.cpp"
	
	{
	tok = (_t == ASTNULL) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	str=identifier(_t);
	_t = _retTree;
#line 8687 "csl.walker.g"
	
	if( retExprLink.get() ) {
	retExprLink->addHidItem( str.first );
	}
	else {
	retExprLink = CSLOmExprLink::build( str.second, _RS(tok->getFilename()), str.first );
	}
	
#line 21565 "CslTreeWalker.cpp"
	}
	_retTree = _t;
	return retExprLink;
}

NSCSLOm::RefCSLOmExpr  CslTreeWalker::sized_number(antlr::RefCslAST _t) {
#line 9101 "csl.walker.g"
	NSCSLOm::RefCSLOmExpr expr;
#line 21574 "CslTreeWalker.cpp"
	antlr::RefCslAST sized_number_AST_in = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	antlr::RefCslAST sn = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST un = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	antlr::RefCslAST bn = antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	antlr::RefCslAST __t1106 = _t;
	sn = (_t == antlr::RefCslAST(ASTNULL)) ? antlr::RefCslAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SIZED_NUMBER);
	_t = _t->getFirstChild();
	un = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UNSIGNED_NUMBER);
	_t = _t->getNextSibling();
	bn = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),BASED_NUMBER);
	_t = _t->getNextSibling();
	_t = __t1106;
	_t = _t->getNextSibling();
#line 9106 "csl.walker.g"
	
	expr = CCSLOmAdapter::getInstance()->convertToCSLOmNumberFrom_sized_number(sn->getLine(), _RS(sn->getFilename()), un->getNumber(), bn->getNumber());
	
#line 21596 "CslTreeWalker.cpp"
	_retTree = _t;
	return expr;
}

void CslTreeWalker::initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& )
{
}
const char* CslTreeWalker::tokenNames[] = {
	"<0>",
	"EOF",
	"<2>",
	"NULL_TREE_LOOKAHEAD",
	"\"csl_unit\"",
	"\"csl_list\"",
	"\"csl_interface\"",
	"\"csl_register_file\"",
	"\"csl_read_interface\"",
	"\"csl_write_interface\"",
	"\"csl_register\"",
	"\"csl_port\"",
	"\"csl_signal\"",
	"\"csl_bitrange\"",
	"\"csl_signal_group\"",
	"\"csl_testbench\"",
	"\"csl_event\"",
	"\"csl_include\"",
	"\"csl_isa_field\"",
	"\"csl_isa_element\"",
	"\"csl_enum\"",
	"\"csl_field\"",
	"\"csl_fifo\"",
	"\"csl_memory_map\"",
	"\"csl_memory_map_page\"",
	"\"csl_state_data\"",
	"\"csl_vector\"",
	"\"csl_memory\"",
	"\"csl_multi_dim_bitrange\"",
	"\"csl_pipeline\"",
	"\"csl_pipestage\"",
	"\"csl_parameter\"",
	"\"set_type\"",
	"\"set_attr\"",
	"\"set_unit_prefix\"",
	"\"set_signal_prefix\"",
	"\"set_signal_prefix_local\"",
	"\"set_depth\"",
	"\"set_const_value\"",
	"\"set_external\"",
	"\"set_number_of_ports\"",
	"\"set_address\"",
	"\"set_attributes\"",
	"\"set_lock_enable_bit\"",
	"\"set_mask\"",
	"\"set_feedback_mask\"",
	"\"set_feedback_element\"",
	"\"set_shift_type\"",
	"\"set_shift_amount\"",
	"\"set_final_shift_value\"",
	"\"set_width\"",
	"\"set_dim_width\"",
	"\"set_bitrange\"",
	"\"set_dim_bitrange\"",
	"\"set_range\"",
	"\"set_dim_range\"",
	"\"set_dim_lower_index\"",
	"\"set_dim_upper_index\"",
	"\"set_offset\"",
	"\"set_dim_offset\"",
	"\"set_number_of_dimensions\"",
	"\"set_cell\"",
	"\"set_instance_alteration_bit\"",
	"\"set_testbench_verilog_filename\"",
	"\"set_vc_timeout\"",
	"\"set_period\"",
	"\"set_timebase\"",
	"\"set_transaction_timeout_count\"",
	"\"set_dut_compare_trigger\"",
	"\"set_generate_waves_filename\"",
	"\"set_instance_name\"",
	"\"set_dut_mem\"",
	"\"set_dut_mem_init\"",
	"\"set_single_line\"",
	"\"set_vc_id\"",
	"\"set_dut_input_filename\"",
	"\"set_dut_output_filename\"",
	"\"set_vc_max_num_states\"",
	"\"set_connection_type\"",
	"\"set_name\"",
	"\"set_direction\"",
	"\"set_max_num_vectors\"",
	"\"set_mem_instance_name\"",
	"\"set_event_type\"",
	"\"set_stimulus_filename\"",
	"\"set_expected_filename\"",
	"\"set_vc_output_filename\"",
	"\"set_tb_dut_name\"",
	"\"set_csim_unit_name\"",
	"\"set_pli_socket_name\"",
	"\"set_max_error_count\"",
	"\"set_radix\"",
	"\"set_generator_type\"",
	"\"set_pattern\"",
	"\"set_start_signal\"",
	"\"set_default_value\"",
	"\"set_reset\"",
	"\"set_duration\"",
	"\"set_clk_divider\"",
	"\"set_clk_multiplier\"",
	"\"set_phase_difference\"",
	"\"set_signal_name\"",
	"\"set_isa\"",
	"\"set_mnemonic\"",
	"\"set_decoder_name\"",
	"\"set_decoder_out_name_prefix\"",
	"\"set_decoder_out_name_suffix\"",
	"\"set_dimensions\"",
	"\"set_physical_implementation\"",
	"\"set_unit_id_address\"",
	"\"set_unit_id\"",
	"\"set_external_unit_enable\"",
	"\"set_value\"",
	"\"set_enum\"",
	"\"set_enum_item\"",
	"\"set_const\"",
	"\"set_field\"",
	"\"set_position\"",
	"\"set_next\"",
	"\"set_previous\"",
	"\"set_field_position\"",
	"\"set_top_unit\"",
	"\"set_address_increment\"",
	"\"set_next_address\"",
	"\"set_access_rights\"",
	"\"set_access_rights_enum\"",
	"\"set_data_word_width\"",
	"\"set_alignment\"",
	"\"set_endianess\"",
	"\"set_name_length\"",
	"\"set_address_visibility\"",
	"\"set_prefix\"",
	"\"set_unit_name\"",
	"\"set_suffix\"",
	"\"set_addr_abs\"",
	"\"set_addr_rel\"",
	"\"set_page_no\"",
	"\"set_name_max_length\"",
	"\"set_symbol_max_length\"",
	"\"set_source\"",
	"\"set_compare_event\"",
	"\"set_file_name\"",
	"\"set_vc_cpp_rd_name\"",
	"\"set_vc_cpp_wr_name\"",
	"\"set_vc_start_generation_trigger\"",
	"\"set_vc_max_number_of_mismatches\"",
	"\"set_vc_max_number_of_valid_transactions\"",
	"\"set_vc_valid_output_transaction\"",
	"\"set_transaction_type\"",
	"\"set_dut_mem_init_file\"",
	"\"set_capture_event\"",
	"\"set_vc_compare_trigger\"",
	"\"add_clock\"",
	"\"set_model\"",
	"\"set_cpp_vector_rd_name\"",
	"\"set_cpp_vector_wr_name\"",
	"\"set_max_num_of_vectors\"",
	"\"set_vc_max_cycles\"",
	"\"set_number_of_pipestages\"",
	"\"set_previous_pipestage\"",
	"\"set_next_pipestage\"",
	"\"set_pipestage_number\"",
	"\"set_pipestage_name\"",
	"\"set_pipestage_valid_input\"",
	"\"set_pipestage_valid_output\"",
	"\"set_vc_name\"",
	"\"set_vc_header_comment\"",
	"\"set_version\"",
	"\"set_vc_clock\"",
	"\"set_vc_reset\"",
	"\"set_vc_stall\"",
	"\"set_vc_end_generation_trigger\"",
	"\"set_vc_capture_edge_type\"",
	"\"set_vc_max_number_of_capture_events\"",
	"\"set_vc_max_num_of_transaction_events\"",
	"\"set_reset_name\"",
	"\"set_clock_name\"",
	"\"set_rd_clock_name\"",
	"\"set_wr_clock_name\"",
	"\"set_push_name\"",
	"\"set_pop_name\"",
	"\"set_full_name\"",
	"\"set_empty_name\"",
	"\"set_wr_data_name\"",
	"\"set_rd_data_name\"",
	"\"set_valid_name\"",
	"\"set_wr_addr_name\"",
	"\"set_rd_addr_name\"",
	"\"set_wr_en_name\"",
	"\"set_rd_en_name\"",
	"\"set_method\"",
	"\"set_pipestage\"",
	"\"set_msb\"",
	"\"set_lsb\"",
	"\"set_upper_index\"",
	"\"set_lower_index\"",
	"\"set_num_rd_ifc\"",
	"\"set_num_wr_ifc\"",
	"\"set_clock\"",
	"\"const\"",
	"\"int\"",
	"\"get_interface\"",
	"\"get_signal_value\"",
	"\"get_type\"",
	"\"get_attr\"",
	"\"get_unit_prefix\"",
	"\"get_signal_prefix\"",
	"\"get_signal_prefix_local\"",
	"\"get_depth\"",
	"\"get_attributes\"",
	"\"get_input_field\"",
	"\"get_output_field\"",
	"\"get_lock_enable_bit\"",
	"\"get_cnt_dir_signal\"",
	"\"get_width\"",
	"\"get_dim_width\"",
	"\"get_bitrange\"",
	"\"get_dim_bitrange\"",
	"\"get_range\"",
	"\"get_lower\"",
	"\"get_dim_lower\"",
	"\"get_upper\"",
	"\"get_dim_upper\"",
	"\"get_offset\"",
	"\"get_dim_offset\"",
	"\"get_number_of_dimensions\"",
	"\"get_cell\"",
	"\"get_transaction_timeout_count\"",
	"\"get_simulation_timeout_count\"",
	"\"get_vc_id\"",
	"\"get_vc_max_num_states\"",
	"\"get_name\"",
	"\"get_filename\"",
	"\"get_max_num_vectors\"",
	"\"get_max_error_count\"",
	"\"get_isa\"",
	"\"get_mnemonic\"",
	"\"get_value\"",
	"\"get_enum\"",
	"\"get_enum_item\"",
	"\"get_const\"",
	"\"get_field\"",
	"\"get_fieldlist\"",
	"\"get_next_address\"",
	"\"get_access_rights_enum\"",
	"\"get_lower_bound\"",
	"\"get_upper_bound\"",
	"\"get_data_word_width\"",
	"\"get_alignment\"",
	"\"get_endianess\"",
	"\"get_name_length\"",
	"\"get_address_visibility\"",
	"\"get_prefix\"",
	"\"get_suffix\"",
	"\"get_symbol_length\"",
	"\"get_address_increment\"",
	"\"get_vc_max_number_of_valid_transactions\"",
	"\"get_vc_name\"",
	"\"get_vc_header_comment\"",
	"\"get_vc_clock\"",
	"\"get_vc_reset\"",
	"\"get_vc_stall\"",
	"\"get_vc_compare_trigger\"",
	"\"get_vc_start_generation_trigger\"",
	"\"get_vc_end_generation_trigger\"",
	"\"get_vc_capture_edge_type\"",
	"\"get_vc_max_number_of_capture_events\"",
	"\"get_vc_max_number_of_mismatches\"",
	"\"get_vc_timeout\"",
	"\"get_vc_output_filename\"",
	"\"get_vc_cpp_rd_name\"",
	"\"get_vc_cpp_wr_name\"",
	"\"get_vc_radix\"",
	"\"get_vc_module\"",
	"\"get_output_filename\"",
	"\"get_reset_name\"",
	"\"get_clock_name\"",
	"\"get_rd_clock_name\"",
	"\"get_wr_clock_name\"",
	"\"get_push_name\"",
	"\"get_pop_name\"",
	"\"get_full_name\"",
	"\"get_empty_name\"",
	"\"get_wr_data_name\"",
	"\"get_rd_data_name\"",
	"\"get_valid_name\"",
	"\"get_wr_addr_name\"",
	"\"get_rd_addr_name\"",
	"\"get_wr_en_name\"",
	"\"get_rd_en_name\"",
	"\"get_pipestage\"",
	"\"get_msb\"",
	"\"get_lsb\"",
	"\"get_radix\"",
	"\"class\"",
	"\"public\"",
	"\"initialize\"",
	"\"#include\"",
	"\"add_instance\"",
	"\"add_instance_list\"",
	"\"add_port\"",
	"\"add_port_list\"",
	"\"remove_port\"",
	"\"remove_port_list\"",
	"\"reverse\"",
	"\"add_interface\"",
	"\"add_signal\"",
	"\"add_signal_list\"",
	"\"add_unit_parameter\"",
	"\"override_parameter\"",
	"\"auto_connect_width_inference\"",
	"\"auto_connect_verilog_and_csl\"",
	"\"auto_connect_filter\"",
	"\"add_valid_to_register\"",
	"\"create_rtl_module\"",
	"\"directive\"",
	"\"index_data_pair\"",
	"\"add_logic\"",
	"\"reset_value\"",
	"\"clear_value\"",
	"\"stop_at_end_value\"",
	"\"add_value\"",
	"\"column_name\"",
	"\"row_name\"",
	"\"add_column\"",
	"\"add_row\"",
	"\"matrix\"",
	"\"connect_split\"",
	"\"merge\"",
	"\"invert\"",
	"\"buffer\"",
	"\"concat\"",
	"\"connect\"",
	"\"input_verilog_type\"",
	"\"output_verilog_type\"",
	"\"autorouter\"",
	"\"remove_signal\"",
	"\"remove_signal_list\"",
	"\"add_signal_group\"",
	"\"add_port_group\"",
	"\"v1995\"",
	"\"v2001\"",
	"\"v2005\"",
	"\"sysv\"",
	"\"CA\"",
	"\"TA\"",
	"\"VecName\"",
	"\"SimVer\"",
	"\"SimArgs\"",
	"\"date\"",
	"\"user\"",
	"\"MachineArch\"",
	"\"oscillator\"",
	"\"pwl\"",
	"\"continuous\"",
	"\"add_dut_instance\"",
	"\"include_file\"",
	"\"add_clock_gen\"",
	"\"clk_output\"",
	"\"add_reset\"",
	"\"add_vector_instance\"",
	"\"add_arch_state_instance\"",
	"\"add_dut_compare_trigger\"",
	"\"add_comment\"",
	"\"add_tb_read_event\"",
	"\"exclusion_list\"",
	"\"include_only\"",
	"\"add_event\"",
	"\"add_write_event\"",
	"\"add_read_event\"",
	"\"print_signal_name_list\"",
	"\"print_signal_values_list\"",
	"\"generate_header_comment\"",
	"\"add_valid_bit_to_last_vector\"",
	"\"add_io_list\"",
	"\"add_missmatch_logic\"",
	"\"add_sample_event\"",
	"\"add_csim_unit\"",
	"\"rtl_compare_level\"",
	"\"csim_compare_level\"",
	"\"csim_sample_level\"",
	"\"add_instruction_format\"",
	"\"add_instruction_format_list\"",
	"\"add_instruction\"",
	"\"add_instruction_list\"",
	"\"add_field\"",
	"\"generate_cpp_header\"",
	"\"generate_verilog_header\"",
	"\"print\"",
	"\"generate_decoder\"",
	"\"gen_internal_unit_enable\"",
	"\"gen_part_select\"",
	"\"gen_mux\"",
	"\"add_enum\"",
	"\"add_fieldlist\"",
	"\"add_allowed_range\"",
	"\"create_signal\"",
	"\"add_address_range\"",
	"\"add_reserved_address_range\"",
	"\"add\"",
	"\"auto_gen_memory_map\"",
	"\"add_to_memory_map\"",
	"\"start_state_data_generation\"",
	"\"start_vector_generation\"",
	"\"pipestage_naming_convention\"",
	"\"associate_pipeline\"",
	"\"replicate\"",
	"\"add_pipestage\"",
	"\"connect_stall\"",
	"\"connect_enable\"",
	"\"branch\"",
	"\"inline_file\"",
	"\"inline_code\"",
	"\"reset_init_value\"",
	"\"add_pipeline_delay\"",
	"\"add_equation\"",
	"\"initialize_random_values\"",
	"\"initialize_random\"",
	"\"gen_unique_rtl_modules\"",
	"\"no_prefix\"",
	"\"do_not_gen_rtl\"",
	"\"do_not_gen_cpp\"",
	"\"register_ios\"",
	"\"connect_units\"",
	"\"connect_by_pattern\"",
	"\"connect_by_name\"",
	"backtick (\'`\') ",
	"at (\'@\')",
	"colon (\':\')",
	"comma (\',\')",
	"dot (\'.\')",
	"assign (\'=\')",
	"minus (\'-\')",
	"left bracket (\'[\')",
	"right bracket (\']\')",
	"left curly bracket (\'{\')",
	"right curly bracket (\'}\')",
	"left paranthesis (\'(\')",
	"right paranthesis (\')\')",
	"pound (\'#\')",
	"question mark (\'?\')",
	"semi colon (\';\')",
	"plus (\'+\')",
	"logical not (\'!\')",
	"not (\'~\')",
	"and (\'&\')",
	"nand (\'~&\')",
	"or (\'|\')",
	"nor (\'~|\')",
	"xor (\'^\')",
	"xnor (\'~^\')",
	"star (\'*\')",
	"power (\'**\')",
	"divide (\'/\')",
	"mod (\'%\')",
	"equal (\'==\')",
	"not equal (\'!=\')",
	"not equal case (\'!==\')",
	"equal case (\'===\')",
	"logical and (\'&&\')",
	"tand (\'&&&\')",
	"logical or (\'||\')",
	"lower then (\'<\')",
	"lower then or equal to (\'<=\')",
	"greater then (\'>\')",
	"greater then or equal to (\'>=\')",
	"shift left (\'<<\')",
	"arithmetic left shift (\'<<<\')",
	"shift right (\'>>\')",
	"arithmetic right shift (\'>>>\')",
	"trigger (\'->\')",
	"ppath (\'=>\')",
	"fpath (\'*>\')",
	"star paranthesis (\'*)\')",
	"p0_pos (\'+:\')",
	"p0_neg (\'-:\')",
	"superstar (\'(*)\')",
	"W",
	"END_OF_LINE",
	"VOCAB",
	"ALPHA",
	"DIGIT",
	"NZ_DIGIT",
	"BIN_DIGIT",
	"OCT_DIGIT",
	"HEX_DIGIT",
	"XZ_DIGIT",
	"an identifier",
	"ESCAPED_IDENTIFIER",
	"STRING",
	"UNSIGNED_NUMBER",
	"NZ_UNSIGNED_NUMBER",
	"REAL_NUMBER",
	"REAL_NUMBER_EXP",
	"SIGN",
	"EXP",
	"XZ_NUMBER",
	"BIN_NUMBER",
	"OCT_NUMBER",
	"HEX_NUMBER",
	"NUMBER",
	"BASED_NUMBER_HEADER",
	"BASED_NUMBER",
	"SYSTEM_TASK_NAME",
	"FILENAME",
	"DIRECTIVE",
	"WS",
	"SL_COMMENT",
	"ML_COMMENT",
	"UNIT_PARAMETER",
	"CSL_COMMAND",
	"CSL_UNIT_DEFINITION",
	"CSL_UNIT_INSTANTIATION",
	"CSL_INTERFACE_INSTANTIATION",
	"CSL_CSTOR",
	"CSL_INST",
	"CSL_INST_OR_CSTOR",
	"CSL_MEMORY_MAP_DEFINITION",
	"CSL_MEMORY_MAP_PAGE_DEFINITION",
	"CSL_MEMORY_MAP_PAGE_INSTANTIATION",
	"CSL_MEMORY_MAP_PAGE_CSTOR",
	"CSL_MEMORY_MAP_CSTOR",
	"EXPRESSION_LIST",
	"CONCATENATION",
	"MULTI_CONCATENATION",
	"EXPRESSION",
	"RANGE_EXPRESSION",
	"MINTYPMAX_EXPRESSION",
	"EXPR_PRIMARY_IDENTIFIER",
	"U_PLUS",
	"U_MINUS",
	"U_AND",
	"U_NAND",
	"U_OR",
	"U_NOR",
	"U_XOR",
	"U_XNOR",
	"FUNCTION_CALL_RET_ID",
	"FUNCTION_CALL_RET_EXPR",
	"EXPR_HYBRID",
	"SIZED_NUMBER",
	"BITRANGE",
	"PARAM_LIST_ADD_SIGNAL",
	"PARAM_LIST_ADD_SIGNAL_LIST",
	"PARAM_LIST_SIGNAL_GROUP",
	"PARAM_LIST_ADD_PORT",
	"PARAM_LIST_ADD_PORT_LIST",
	"PARAM_LIST_ADD_INSTANCE",
	"PARAM_LIST_ADD_INSTANCE_LIST",
	"PARAM_LIST_ADD_UNIT_PARAMETER",
	"PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING",
	"CSL_LIST",
	"TIME_EXPR",
	"F2A_PAIR_EXPR",
	"PARAM_LIST_SET_POSITION",
	"PARAM_LIST_SET_NEXT",
	"PARAM_LIST_SET_PREVIOUS",
	"PARENT_CLASS",
	"PARAM_LIST_ADD_TO_MEMORY_MAP",
	"INST_PARAM",
	"ENUM_ITEM",
	"ASSIGNOR",
	"CSL_ISA_ELEMENT_DECLARATION",
	"K_INPUT",
	"K_OUTPUT",
	"K_INOUT",
	"K_ACTION",
	"K_ATOM",
	"K_COUNTER",
	"K_REGISTER",
	"K_CTL",
	"K_DFF",
	"K_EVNT",
	"K_LFSR",
	"K_SFT",
	"K_SEMA",
	"K_STATISTIC",
	"K_STATUS",
	"K_PRODUCER",
	"K_CONSUMER",
	"K_REAL",
	"K_REALTIME",
	"K_HIERARCHICAL",
	"K_FLAT",
	"K_PAGE",
	"K_VIRTUAL_WITH_BASE_ADDRESS",
	"K_VIRTUAL_WITH_PAGE_NUMBER_AND_ADDRESS",
	"K_DIAGNOSTIC",
	"K_STIM_EXPECT",
	"K_SERIAL_BUS",
	"K_FILE",
	"K_SOCKET",
	"K_SHARED_OBJ",
	"K_UNDEFINED",
	"K_ILLEGAL",
	"K_RESERVED",
	"K_VALID",
	"K_OPCODE",
	"K_SUBOPCODE",
	"K_ADDRESS",
	"K_SELECTOR",
	"K_CONSTANT",
	"K_RF_ADDRESS",
	"K_MEM_ADDRESS",
	"K_IM",
	"K_BRANCH_ADDRESS",
	"K_BRANCH_SELECT",
	"K_INSTR_FORMAT",
	"K_INSTR",
	"K_ROOT_FORMAT",
	"K_VALID_ENUM",
	"K_DATA_ENUM",
	"K_CONTROL_ENUM",
	"K_OTHER_ENUM",
	"K_UNUSED",
	"K_ENABLE",
	"K_STALL",
	"K_PIPE_ENABLE",
	"K_PIPE_STALL",
	"K_MUX_SELECT",
	"K_DECODE",
	"K_CLOCK_SIGNAL",
	"K_RESET_SIGNAL",
	"K_WRITE_ENABLE",
	"K_IFC_ONLY",
	"K_LOCAL_ONLY",
	"K_REGISTER_GROUP",
	"K_DISCONNECT_REG_FIELDS_IOS",
	"K_CONNECT_REG_FIELDS_IOS",
	"K_FIELD_GROUP",
	"K_ALL",
	"K_INPUTS",
	"K_OUTPUTS",
	"K_INOUTS",
	"K_NAME_REGISTER",
	"K_ON",
	"K_OFF",
	"K_CLK",
	"K_NO_PREFIX",
	"K_PIPELINE_NAME",
	"K_PIPESTAGE_NAME",
	"K_PIPELINE_PIPESTAGE_NAME",
	"K_NO_SUFFIX",
	"K_BIN",
	"K_HEX",
	"K_LITTLE_ENDIAN",
	"K_BIG_ENDIAN",
	"K_ACCESS_RIGHT_NONE",
	"K_ACCESS_RIGHT_READ",
	"K_ACCESS_RIGHT_WRITE",
	"K_ACCESS_RIGHT_READ_WRITE",
	"K_SRAM",
	"K_FFA",
	"K_READ",
	"K_WRITE",
	"K_SHADOW",
	"K_READ_WRITE",
	"K_STALL_ENUM",
	"K_NO_STALL_ENUM",
	"K_XOR",
	"K_XNOR",
	"K_NEG_OUTPUT",
	"K_SERIAL_INPUT",
	"K_SERIAL_OUTPUT",
	"K_RD_EN",
	"K_CONNECT_INPUT_TO_FIELD",
	"K_CONNECT_OUTPUT_TO_FIELD",
	"K_GRAY_OUTPUT",
	"K_CNT_DIR_SIGNAL",
	"K_INC_SIGNAL",
	"K_DEC_SIGNAL",
	"K_SH_OP_SIGNAL",
	"K_START_VALUE",
	"K_END_VALUE",
	"K_COUNT_AMOUNT",
	"K_COUNT_DIRECTION",
	"K_COUNT_ENABLE",
	"K_SET",
	"K_RESET",
	"K_PROGRAMMABLE_DEPTH",
	"K_PRIORITY_BYPASS",
	"K_SYNC_FIFO",
	"K_ASYNC_FIFO",
	"K_DEPTH_EXTEND",
	"K_WIDTH_EXTEND",
	"K_WR_HOLD",
	"K_PARALLEL_OUTPUT",
	"K_PARALLEL_INPUT",
	"K_RD_WORDS",
	"K_WR_WORDS",
	"K_SRAM_RD",
	"K_SRAM_WR",
	"K_PUSHBACK",
	"K_FLOW_THROUGH",
	"K_STALL_RD_SIDE",
	"K_STALL_WR_SIDE",
	"K_WR_RELEASE",
	"K_ALMOST_EMPTY",
	"K_ALMOST_FULL",
	"K_OUTPUT_WR_ADDR",
	"K_OUTPUT_RD_ADDR",
	"K_CREDIT",
	"K_RD_CREDIT",
	"K_WR_CREDIT",
	"K_FLOW",
	"K_READ_VALID",
	"K_BYPASS",
	"K_GENERATE_WAVES",
	"K_SIMULATION_TIMEOUT_COUNTER",
	"K_STALL_GENERATION",
	"K_GENERATE_REPORT",
	"K_ASYNC_RESET",
	"K_INIT",
	"K_CLEAR",
	"K_STOP",
	"K_DIRECTION_CONTROL",
	"K_INJECT_STALLS",
	"K_EXTERNAL_UNIT_ENABLE",
	"K_UNIT_ADDRESS_DECODER",
	"K_SAL",
	"K_SAR",
	"K_SHL",
	"K_SHR",
	"K_ROL",
	"K_ROR",
	"K_PLI_SOCKET",
	"K_CPP",
	"K_TB",
	"K_TRANSACTION",
	"K_CYCLE_ACCURATE",
	"K_NAND",
	"K_NOR",
	"K_AND",
	"K_OR",
	"K_NOT",
	"K_PLUS",
	"K_RISE",
	"K_FALL",
	"K_REG",
	"K_WIRE",
	"K_TRI",
	"K_TRIAND",
	"K_SUPPLY0",
	"K_SUPPLY1",
	"K_TRIOR",
	"K_TRI0",
	"K_TRI1",
	"K_TRIREG",
	"K_WAND",
	"K_WOR",
	"K_INTEGER",
	"K_TIME",
	"K_TRUE",
	"K_FALSE",
	"K_FILE_CPLUSPLUS",
	"K_FILE_VERILOG",
	"K_S",
	"K_US",
	"K_MS",
	"K_NS",
	"K_PS",
	"K_COLUMNS",
	"K_ROWS",
	"K_WAVE_TYPE_FSDB",
	"K_WAVE_TYPE_VCD",
	"K_UP",
	"K_DOWN",
	"K_COMBINATIONAL",
	"K_SEQUENTIAL",
	"K_LOAD",
	"K_CONCATENATION",
	"K_REPLICATION",
	"K_SKIP_PARAMETER",
	"K_RESET_",
	"K_TO_USE_FOR_NONDETERMINISM_IN_WALKER",
	"TICK",
	"PSTAR",
	"K_DATA_GENERATION",
	"K_COLUMN",
	"K_ROW",
	"K_VIRTUAL_WITH_PAGE_NUMBER",
	"K_ADD_CLOCK",
	"K_ADD_ARCH_STATE",
	"K_SET_VC_TIME_OUT",
	"K_SET_COMPARE_TRIGGER",
	"K_GENERATE_INDIVIDUAL_RTL_SIGNALS",
	"K_TRANSACTION_TIMEOUT_COUNTER",
	"K_GET_SIGNAL_TYPE",
	"K_AS_ON",
	"K_AS_OFF",
	"K_DECODED",
	"K_CSL_ISA",
	"K_VOID",
	"K_CSL_DESIGN",
	"K_CSL_ADDRESS_RANGE",
	"K_CSL_BOOL_EQUATION",
	"K_CSL_SIGNAL_PATTERN_GENERATOR",
	"K_GET_REVERSED_INTERFACE",
	"K_GET_TRANSACTION_TIMEOUT_COUNTER",
	"K_GET_SIMULATION_TIMEOUT_COUNTER",
	"K_GET_COMPARE_TRIGGER",
	"K_GET_ASM_MNEMONIC",
	0
};

const unsigned long CslTreeWalker::_tokenSet_0_data_[] = { 2684353776UL, 1023149311UL, 138782080UL, 4294385536UL, 545768505UL, 1073725408UL, 64UL, 0UL, 0UL, 752943104UL, 59136UL, 24704UL, 2147739696UL, 33788UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 24UL, 0UL, 528998400UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "csl_unit" "csl_list" "csl_interface" "csl_register_file" "csl_register" 
// "csl_port" "csl_signal" "csl_bitrange" "csl_signal_group" "csl_testbench" 
// "csl_event" "csl_include" "csl_isa_field" "csl_isa_element" "csl_enum" 
// "csl_field" "csl_fifo" "csl_memory_map" "csl_memory_map_page" "csl_state_data" 
// "csl_vector" "csl_memory" "csl_multi_dim_bitrange" "csl_parameter" "set_type" 
// "set_attr" "set_unit_prefix" "set_signal_prefix" "set_signal_prefix_local" 
// "set_depth" "set_const_value" "set_external" "set_attributes" "set_width" 
// "set_dim_width" "set_bitrange" "set_dim_bitrange" "set_range" "set_dim_range" 
// "set_offset" "set_dim_offset" "set_number_of_dimensions" "set_cell" 
// "set_dut_mem" "set_dut_mem_init" "set_vc_id" "set_vc_max_num_states" 
// "set_name" "set_direction" "set_mem_instance_name" "set_vc_output_filename" 
// "set_radix" "set_mnemonic" "set_decoder_name" "set_decoder_out_name_prefix" 
// "set_decoder_out_name_suffix" "set_dimensions" "set_physical_implementation" 
// "set_value" "set_enum" "set_enum_item" "set_field" "set_position" "set_next" 
// "set_previous" "set_field_position" "set_top_unit" "set_address_increment" 
// "set_next_address" "set_access_rights" "set_access_rights_enum" "set_data_word_width" 
// "set_alignment" "set_endianess" "set_prefix" "set_unit_name" "set_suffix" 
// "set_symbol_max_length" "set_vc_cpp_rd_name" "set_vc_cpp_wr_name" "set_vc_start_generation_trigger" 
// "set_vc_max_number_of_mismatches" "set_vc_max_number_of_valid_transactions" 
// "set_vc_compare_trigger" "set_vc_max_cycles" "set_vc_name" "set_vc_header_comment" 
// "set_version" "set_vc_clock" "set_vc_reset" "set_vc_stall" "set_vc_end_generation_trigger" 
// "set_vc_capture_edge_type" "set_vc_max_number_of_capture_events" "set_reset_name" 
// "set_clock_name" "set_rd_clock_name" "set_wr_clock_name" "set_push_name" 
// "set_pop_name" "set_full_name" "set_empty_name" "set_wr_data_name" "set_rd_data_name" 
// "set_valid_name" "set_wr_addr_name" "set_rd_addr_name" "set_wr_en_name" 
// "set_rd_en_name" "set_clock" "reverse" "override_parameter" "auto_connect_width_inference" 
// "auto_connect_verilog_and_csl" "create_rtl_module" "directive" "add_logic" 
// "merge" "invert" "buffer" "input_verilog_type" "output_verilog_type" 
// "autorouter" "add_reset" "exclusion_list" "include_only" "print" "generate_decoder" 
// "add_allowed_range" "add_address_range" "add_reserved_address_range" 
// "add" "auto_gen_memory_map" "add_to_memory_map" "add_equation" "gen_unique_rtl_modules" 
// "no_prefix" "do_not_gen_rtl" "do_not_gen_cpp" "register_ios" "connect_units" 
// "connect_by_pattern" "connect_by_name" ASSIGN K_GENERATE_WAVES K_SIMULATION_TIMEOUT_COUNTER 
// K_ADD_CLOCK K_ADD_ARCH_STATE K_SET_VC_TIME_OUT K_SET_COMPARE_TRIGGER 
// K_GENERATE_INDIVIDUAL_RTL_SIGNALS K_TRANSACTION_TIMEOUT_COUNTER K_CSL_ISA 
// K_VOID K_CSL_DESIGN K_CSL_ADDRESS_RANGE K_CSL_BOOL_EQUATION K_CSL_SIGNAL_PATTERN_GENERATOR 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslTreeWalker::_tokenSet_0(_tokenSet_0_data_,52);
const unsigned long CslTreeWalker::_tokenSet_1_data_[] = { 0UL, 1023149311UL, 138782080UL, 4294385536UL, 545768505UL, 1073725408UL, 64UL, 0UL, 0UL, 752943104UL, 59136UL, 24704UL, 2147739696UL, 33788UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 24UL, 0UL, 516096UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "set_type" "set_attr" "set_unit_prefix" "set_signal_prefix" "set_signal_prefix_local" 
// "set_depth" "set_const_value" "set_external" "set_attributes" "set_width" 
// "set_dim_width" "set_bitrange" "set_dim_bitrange" "set_range" "set_dim_range" 
// "set_offset" "set_dim_offset" "set_number_of_dimensions" "set_cell" 
// "set_dut_mem" "set_dut_mem_init" "set_vc_id" "set_vc_max_num_states" 
// "set_name" "set_direction" "set_mem_instance_name" "set_vc_output_filename" 
// "set_radix" "set_mnemonic" "set_decoder_name" "set_decoder_out_name_prefix" 
// "set_decoder_out_name_suffix" "set_dimensions" "set_physical_implementation" 
// "set_value" "set_enum" "set_enum_item" "set_field" "set_position" "set_next" 
// "set_previous" "set_field_position" "set_top_unit" "set_address_increment" 
// "set_next_address" "set_access_rights" "set_access_rights_enum" "set_data_word_width" 
// "set_alignment" "set_endianess" "set_prefix" "set_unit_name" "set_suffix" 
// "set_symbol_max_length" "set_vc_cpp_rd_name" "set_vc_cpp_wr_name" "set_vc_start_generation_trigger" 
// "set_vc_max_number_of_mismatches" "set_vc_max_number_of_valid_transactions" 
// "set_vc_compare_trigger" "set_vc_max_cycles" "set_vc_name" "set_vc_header_comment" 
// "set_version" "set_vc_clock" "set_vc_reset" "set_vc_stall" "set_vc_end_generation_trigger" 
// "set_vc_capture_edge_type" "set_vc_max_number_of_capture_events" "set_reset_name" 
// "set_clock_name" "set_rd_clock_name" "set_wr_clock_name" "set_push_name" 
// "set_pop_name" "set_full_name" "set_empty_name" "set_wr_data_name" "set_rd_data_name" 
// "set_valid_name" "set_wr_addr_name" "set_rd_addr_name" "set_wr_en_name" 
// "set_rd_en_name" "set_clock" "reverse" "override_parameter" "auto_connect_width_inference" 
// "auto_connect_verilog_and_csl" "create_rtl_module" "directive" "add_logic" 
// "merge" "invert" "buffer" "input_verilog_type" "output_verilog_type" 
// "autorouter" "add_reset" "exclusion_list" "include_only" "print" "generate_decoder" 
// "add_allowed_range" "add_address_range" "add_reserved_address_range" 
// "add" "auto_gen_memory_map" "add_to_memory_map" "add_equation" "gen_unique_rtl_modules" 
// "no_prefix" "do_not_gen_rtl" "do_not_gen_cpp" "register_ios" "connect_units" 
// "connect_by_pattern" "connect_by_name" ASSIGN K_GENERATE_WAVES K_SIMULATION_TIMEOUT_COUNTER 
// K_ADD_CLOCK K_ADD_ARCH_STATE K_SET_VC_TIME_OUT K_SET_COMPARE_TRIGGER 
// K_GENERATE_INDIVIDUAL_RTL_SIGNALS K_TRANSACTION_TIMEOUT_COUNTER 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslTreeWalker::_tokenSet_1(_tokenSet_1_data_,52);
const unsigned long CslTreeWalker::_tokenSet_2_data_[] = { 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 4244701184UL, 4190207UL, 4199936UL, 536862720UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 12UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// MINUS QUESTION PLUS LNOT NOT AND NAND OR NOR XOR XNOR STAR POW DIV MOD 
// EQUAL NOT_EQ NOT_EQ_CASE EQ_CASE LAND LOR LT_ LE GT GE SL SSL SR SSR 
// STRING UNSIGNED_NUMBER REAL_NUMBER BASED_NUMBER EXPRESSION RANGE_EXPRESSION 
// MINTYPMAX_EXPRESSION EXPR_PRIMARY_IDENTIFIER U_PLUS U_MINUS U_AND U_NAND 
// U_OR U_NOR U_XOR U_XNOR FUNCTION_CALL_RET_ID FUNCTION_CALL_RET_EXPR 
// EXPR_HYBRID SIZED_NUMBER K_CONCATENATION K_REPLICATION 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslTreeWalker::_tokenSet_2(_tokenSet_2_data_,52);
const unsigned long CslTreeWalker::_tokenSet_3_data_[] = { 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 4223728128UL, 57477UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 128UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 3758096384UL, 3UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "get_interface" "get_type" "get_attr" "get_unit_prefix" "get_signal_prefix" 
// "get_signal_prefix_local" "get_width" "get_dim_width" "get_bitrange" 
// "get_dim_bitrange" "get_lower" "get_dim_lower" "get_upper" "get_dim_upper" 
// "get_offset" "get_dim_offset" "get_cell" "get_name" "get_value" "get_enum" 
// "get_enum_item" IDENTIFIER K_GET_REVERSED_INTERFACE K_GET_TRANSACTION_TIMEOUT_COUNTER 
// K_GET_SIMULATION_TIMEOUT_COUNTER K_GET_COMPARE_TRIGGER K_GET_ASM_MNEMONIC 
const ANTLR_USE_NAMESPACE(antlr)BitSet CslTreeWalker::_tokenSet_3(_tokenSet_3_data_,52);


