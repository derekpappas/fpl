#ifndef INC_CslTreeWalker_hpp_
#define INC_CslTreeWalker_hpp_

#include <antlr/config.hpp>
#include "CslTreeWalkerTokenTypes.hpp"
/* $ANTLR 2.7.7 (2006-11-01): "csl.walker.g" -> "CslTreeWalker.hpp"$ */
#include <antlr/TreeParser.hpp>

#line 23 "csl.walker.g"

#include <string>
#include <cmath>
#include <iostream>
#include <sstream>
#include "../../cslom/CSLOM.h"
#include "../../cslom/CSLOM_cmd.h"

#include "../../autorouter/Autorouter.h"

#include "Tools.hpp"

#include "Def.hpp"
#include "CslNumber.hpp"
#include "CslAST.hpp"
#include "../../support/CommonSupport.h" //assertion header

#line 28 "CslTreeWalker.hpp"
class CUSTOM_API CslTreeWalker : public ANTLR_USE_NAMESPACE(antlr)TreeParser, public CslTreeWalkerTokenTypes
{
#line 91 "csl.walker.g"

NSCSLOm::RefCSLOmBase design;
NSCSLOm::RefTVec_RefCSLOmBase scopeBlocks;
RefTVec_RefString vCurrentScope;
void printAST(antlr::RefCslAST ast);
#line 32 "CslTreeWalker.hpp"
public:
	CslTreeWalker();
	static void initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& factory );
	int getNumTokens() const
	{
		return CslTreeWalker::NUM_TOKENS;
	}
	const char* getTokenName( int type ) const
	{
		if( type > getNumTokens() ) return 0;
		return CslTreeWalker::tokenNames[type];
	}
	const char* const* getTokenNames() const
	{
		return CslTreeWalker::tokenNames;
	}
	public: void source_text(antlr::RefCslAST _t,
		NSCSLOm::RefCSLOmDesign design_param, RefTVec_RefString vCurrentScope_param
	);
	public: void description(antlr::RefCslAST _t);
	public: void csl_command(antlr::RefCslAST _t);
	public: void csl_declaration(antlr::RefCslAST _t);
	public: void csl_function_declaration(antlr::RefCslAST _t);
	public: void command_add_clock(antlr::RefCslAST _t);
	public: void command_add_reset(antlr::RefCslAST _t);
	public: void command_add_equation(antlr::RefCslAST _t);
	public: void command_add_address_range(antlr::RefCslAST _t);
	public: void command_set_address_increment(antlr::RefCslAST _t);
	public: void command_set_next_address(antlr::RefCslAST _t);
	public: void command_add_reserved_range(antlr::RefCslAST _t);
	public: void command_add(antlr::RefCslAST _t);
	public: void command_set_data_word_width(antlr::RefCslAST _t);
	public: void command_set_alignament(antlr::RefCslAST _t);
	public: void command_set_endianess(antlr::RefCslAST _t);
	public: void command_set_symbol_max_length(antlr::RefCslAST _t);
	public: void command_set_prefix(antlr::RefCslAST _t);
	public: void command_no_prefix(antlr::RefCslAST _t);
	public: void command_set_suffix(antlr::RefCslAST _t);
	public: void command_set_type(antlr::RefCslAST _t);
	public: void command_set_attr(antlr::RefCslAST _t);
	public: void command_set_attributes(antlr::RefCslAST _t);
	public: void command_set_transaction_timeout_counter(antlr::RefCslAST _t);
	public: void command_set_simulation_timeout_counter(antlr::RefCslAST _t);
	public: void command_add_arch_state(antlr::RefCslAST _t);
	public: void command_set_instance_name(antlr::RefCslAST _t);
	public: void command_set_unit_name(antlr::RefCslAST _t);
	public: void command_set_direction(antlr::RefCslAST _t);
	public: void command_exclusion_list(antlr::RefCslAST _t);
	public: void command_include_only(antlr::RefCslAST _t);
	public: void command_set_vc_id(antlr::RefCslAST _t);
	public: void command_set_vc_name(antlr::RefCslAST _t);
	public: void command_set_vc_header_comment(antlr::RefCslAST _t);
	public: void command_set_vc_version(antlr::RefCslAST _t);
	public: void command_set_radix(antlr::RefCslAST _t);
	public: void command_set_vc_clock(antlr::RefCslAST _t);
	public: void command_set_vc_reset(antlr::RefCslAST _t);
	public: void command_set_vc_stall(antlr::RefCslAST _t);
	public: void command_set_vc_compare_trigger(antlr::RefCslAST _t);
	public: void command_set_vc_start_generation_trigger(antlr::RefCslAST _t);
	public: void command_set_vc_end_generation_trigger(antlr::RefCslAST _t);
	public: void command_set_vc_capture_edge_type(antlr::RefCslAST _t);
	public: void command_set_vc_max_cycles(antlr::RefCslAST _t);
	public: void command_set_vc_max_number_of_capture_events(antlr::RefCslAST _t);
	public: void command_set_vc_max_number_of_valid_transactions(antlr::RefCslAST _t);
	public: void command_set_vc_max_number_of_mismatches(antlr::RefCslAST _t);
	public: void command_set_vc_timeout(antlr::RefCslAST _t);
	public: void command_set_vc_output_filename(antlr::RefCslAST _t);
	public: void command_set_vc_cpp_rd_name(antlr::RefCslAST _t);
	public: void command_set_vc_cpp_wr_name(antlr::RefCslAST _t);
	public: void command_set_vc_max_num_states(antlr::RefCslAST _t);
	public: void command_assign(antlr::RefCslAST _t);
	public: void command_set_name(antlr::RefCslAST _t);
	public: void command_do_not_gen_rtl(antlr::RefCslAST _t);
	public: void command_do_not_gen_cpp(antlr::RefCslAST _t);
	public: void command_gen_unique_rtl_modules(antlr::RefCslAST _t);
	public: void command_set_clock(antlr::RefCslAST _t);
	public: void command_register_ios(antlr::RefCslAST _t);
	public: void command_override_parameter(antlr::RefCslAST _t);
	public: void command_auto_connect_verilog_and_csl(antlr::RefCslAST _t);
	public: void command_auto_connect_width_inference(antlr::RefCslAST _t);
	public: void command_set_compare_trigger(antlr::RefCslAST _t);
	public: void command_generate_waves(antlr::RefCslAST _t);
	public: void command_set_dut_mem(antlr::RefCslAST _t);
	public: void command_set_dut_mem_init(antlr::RefCslAST _t);
	public: void command_set_port_name(antlr::RefCslAST _t);
	public: void command_set_width(antlr::RefCslAST _t);
	public: void command_set_depth(antlr::RefCslAST _t);
	public: void command_set_dim_width(antlr::RefCslAST _t);
	public: void command_set_bitrange(antlr::RefCslAST _t);
	public: void command_set_dim_bitrange(antlr::RefCslAST _t);
	public: void command_set_range(antlr::RefCslAST _t);
	public: void command_set_dim_range(antlr::RefCslAST _t);
	public: void command_set_offset(antlr::RefCslAST _t);
	public: void command_set_dim_offset(antlr::RefCslAST _t);
	public: void command_set_number_of_dimensions(antlr::RefCslAST _t);
	public: void command_set_unit_prefix(antlr::RefCslAST _t);
	public: void command_set_signal_prefix(antlr::RefCslAST _t);
	public: void command_set_signal_prefix_local(antlr::RefCslAST _t);
	public: void command_set_value(antlr::RefCslAST _t);
	public: void command_set_enum(antlr::RefCslAST _t);
	public: void command_set_enum_item(antlr::RefCslAST _t);
	public: void command_set_position(antlr::RefCslAST _t);
	public: void command_set_field_position(antlr::RefCslAST _t);
	public: void command_set_next(antlr::RefCslAST _t);
	public: void command_set_previous(antlr::RefCslAST _t);
	public: void command_add_allowed_range(antlr::RefCslAST _t);
	public: void command_create_rtl_module(antlr::RefCslAST _t);
	public: void command_set_const_value(antlr::RefCslAST _t);
	public: void command_set_field(antlr::RefCslAST _t);
	public: void command_set_external(antlr::RefCslAST _t);
	public: void command_merge(antlr::RefCslAST _t);
	public: void command_invert(antlr::RefCslAST _t);
	public: void command_buffer(antlr::RefCslAST _t);
	public: void command_reverse(antlr::RefCslAST _t);
	public: void command_connect_by_name(antlr::RefCslAST _t);
	public: void command_connect_by_pattern(antlr::RefCslAST _t);
	public: void command_connect_units(antlr::RefCslAST _t);
	public: void command_set_cell(antlr::RefCslAST _t);
	public: void command_input_verilog_type(antlr::RefCslAST _t);
	public: void command_output_verilog_type(antlr::RefCslAST _t);
	public: void command_autorouter(antlr::RefCslAST _t);
	public: void command_generate_individual_rtl_signals(antlr::RefCslAST _t);
	public: void command_generate_decoder(antlr::RefCslAST _t);
	public: void command_set_dimensions(antlr::RefCslAST _t);
	public: void command_set_physical_implementation(antlr::RefCslAST _t);
	public: void command_add_logic(antlr::RefCslAST _t);
	public: void command_directive(antlr::RefCslAST _t);
	public: void command_auto_gen_memory_map(antlr::RefCslAST _t);
	public: void command_set_top_unit(antlr::RefCslAST _t);
	public: void command_set_access_rights(antlr::RefCslAST _t);
	public: void command_set_access_rights_enum(antlr::RefCslAST _t);
	public: void command_add_to_memory_map(antlr::RefCslAST _t);
	public: void command_set_mnemonic(antlr::RefCslAST _t);
	public: void command_set_decoder_name(antlr::RefCslAST _t);
	public: void command_set_decoder_out_name_prefix(antlr::RefCslAST _t);
	public: void command_set_decoder_out_name_suffix(antlr::RefCslAST _t);
	public: void command_print(antlr::RefCslAST _t);
	public: void directive_register_group(antlr::RefCslAST _t);
	public: void directive_disconnect_register_fields_from_ios(antlr::RefCslAST _t);
	public: void directive_connect_register_fields_to_ios(antlr::RefCslAST _t);
	public: pair<RefString, TULong>  identifier(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExpr  expression(antlr::RefCslAST _t);
	public: void command_add_logic_programmable_depth(antlr::RefCslAST _t);
	public: void command_add_logic_priority_bypass(antlr::RefCslAST _t);
	public: void command_add_logic_sync_fifo(antlr::RefCslAST _t);
	public: void command_add_logic_asynch_fifo(antlr::RefCslAST _t);
	public: void command_add_logic_depth_extend(antlr::RefCslAST _t);
	public: void command_add_logic_width_extend(antlr::RefCslAST _t);
	public: void command_add_logic_wr_hold(antlr::RefCslAST _t);
	public: void command_add_logic_parallel_output(antlr::RefCslAST _t);
	public: void command_add_logic_parallel_input(antlr::RefCslAST _t);
	public: void command_add_logic_rd_words(antlr::RefCslAST _t);
	public: void command_add_logic_wr_words(antlr::RefCslAST _t);
	public: void command_add_logic_sram_rd(antlr::RefCslAST _t);
	public: void command_add_logic_sram_wr(antlr::RefCslAST _t);
	public: void command_add_logic_pushback(antlr::RefCslAST _t);
	public: void command_add_logic_flow_through(antlr::RefCslAST _t);
	public: void command_add_logic_stall(antlr::RefCslAST _t);
	public: void command_add_logic_stall_rd_side(antlr::RefCslAST _t);
	public: void command_add_logic_stall_wr_side(antlr::RefCslAST _t);
	public: void command_add_logic_wr_release(antlr::RefCslAST _t);
	public: void command_add_logic_almost_empty(antlr::RefCslAST _t);
	public: void command_add_logic_almost_full(antlr::RefCslAST _t);
	public: void command_add_logic_output_wr_addr(antlr::RefCslAST _t);
	public: void command_add_logic_output_rd_addr(antlr::RefCslAST _t);
	public: void command_add_logic_credit(antlr::RefCslAST _t);
	public: void command_add_logic_rd_credit(antlr::RefCslAST _t);
	public: void command_add_logic_wr_credit(antlr::RefCslAST _t);
	public: void command_add_logic_flow(antlr::RefCslAST _t);
	public: void command_add_logic_unit_address_decoder(antlr::RefCslAST _t);
	public: void command_add_logic_read_valid(antlr::RefCslAST _t);
	public: void command_async_reset(antlr::RefCslAST _t);
	public: void command_add_logic_neg_output(antlr::RefCslAST _t);
	public: void command_add_logic_serial_input(antlr::RefCslAST _t);
	public: void command_add_logic_serial_output(antlr::RefCslAST _t);
	public: void command_add_logic_set(antlr::RefCslAST _t);
	public: void command_add_logic_reset(antlr::RefCslAST _t);
	public: void command_add_logic_init(antlr::RefCslAST _t);
	public: void command_add_logic_clear(antlr::RefCslAST _t);
	public: void command_add_logic_gray_output(antlr::RefCslAST _t);
	public: void command_add_logic_start_value(antlr::RefCslAST _t);
	public: void command_add_logic_end_value(antlr::RefCslAST _t);
	public: void command_add_logic_count_amount(antlr::RefCslAST _t);
	public: void command_add_logic_direction_control(antlr::RefCslAST _t);
	public: void command_add_logic_count_direction(antlr::RefCslAST _t);
	public: void command_add_logic_load(antlr::RefCslAST _t);
	public: void command_add_logic_inject_stalls(antlr::RefCslAST _t);
	public: void command_add_logic_simulation_timeout_counter(antlr::RefCslAST _t);
	public: void command_add_logic_stall_generation(antlr::RefCslAST _t);
	public: void command_add_logic_generate_waves(antlr::RefCslAST _t);
	public: void command_add_logic_clock(antlr::RefCslAST _t);
	public: void command_add_logic_generate_report(antlr::RefCslAST _t);
	public: void param_list_auto_connect_verilog_and_csl(antlr::RefCslAST _t);
	public: void param_list_autorouter(antlr::RefCslAST _t);
	public: void nested_call(antlr::RefCslAST _t);
	public: void param_list_get_signal_type(antlr::RefCslAST _t);
	public:  NSCSLOm::RefCSLOmBaseRange  bitrange_pure(antlr::RefCslAST _t);
	public: void param_list_get_interface(antlr::RefCslAST _t);
	public: void param_list_set_unit_prefix(antlr::RefCslAST _t);
	public: void param_list_formal_to_actual_mapping(antlr::RefCslAST _t,
		 NSCSLOm::RefTVec_RefCSLOmExpr returnedParams 
	);
	public: void f2a_pair_expr(antlr::RefCslAST _t,
		NSCSLOm::RefCSLOmExpr &expr_formal, NSCSLOm::RefCSLOmExpr &expr_actual
	);
	public: void param_list_set_type(antlr::RefCslAST _t);
	public: void param_list_get_dim_bitrange(antlr::RefCslAST _t);
	public: void param_list_add_offset(antlr::RefCslAST _t);
	public: void param_list_add_dim_offset(antlr::RefCslAST _t);
	public: void param_list_set_dim_bitrange(antlr::RefCslAST _t);
	public: void param_list_set_dim_width(antlr::RefCslAST _t);
	public: void param_list_set_number_of_dimensions(antlr::RefCslAST _t);
	public: void param_list_start_current_scope(antlr::RefCslAST _t);
	public: void param_list_end_current_scope(antlr::RefCslAST _t);
	public: void param_list_input_verilog_type(antlr::RefCslAST _t);
	public: void param_list_output_verilog_type(antlr::RefCslAST _t);
	public: void param_list_get_bitrange(antlr::RefCslAST _t);
	public: void param_list_set_width(antlr::RefCslAST _t);
	public: void param_list_get_width(antlr::RefCslAST _t);
	public: void param_list_set_range(antlr::RefCslAST _t);
	public: void param_list_get_range(antlr::RefCslAST _t);
	public: void param_list_get_offset(antlr::RefCslAST _t);
	public: void param_list_get_number_of_dimensions(antlr::RefCslAST _t);
	public: void param_list_set_signal_prefix(antlr::RefCslAST _t);
	public: void param_list_set_signal_prefix_local(antlr::RefCslAST _t);
	public: void param_list_get_upper_index(antlr::RefCslAST _t);
	public: void param_list_get_lower_index(antlr::RefCslAST _t);
	public: void param_list_set_upper_index(antlr::RefCslAST _t);
	public: void param_list_set_lower_index(antlr::RefCslAST _t);
	public: void param_list_set_signal_type(antlr::RefCslAST _t);
	public: void param_list_set_signal_attr(antlr::RefCslAST _t);
	public: void param_list_get_signal_attr(antlr::RefCslAST _t);
	public: void param_list_merge(antlr::RefCslAST _t);
	public: void param_list_invert(antlr::RefCslAST _t);
	public: void param_list_buffer(antlr::RefCslAST _t);
	public: void param_list_get_reversed_interface(antlr::RefCslAST _t);
	public: void csl_unit_declaration(antlr::RefCslAST _t);
	public: void csl_signal_declaration(antlr::RefCslAST _t);
	public: void csl_port_declaration(antlr::RefCslAST _t);
	public: void csl_signal_group_declaration(antlr::RefCslAST _t);
	public: void csl_bitrange_declaration(antlr::RefCslAST _t);
	public: void csl_multi_dim_bitrange_declaration(antlr::RefCslAST _t);
	public: void csl_field_declaration(antlr::RefCslAST _t);
	public: void csl_design_declaration(antlr::RefCslAST _t);
	public: void csl_interface_declaration(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmList  csl_list_declaration(antlr::RefCslAST _t);
	public: void csl_address_range_declaration(antlr::RefCslAST _t);
	public: void csl_register_file_declaration(antlr::RefCslAST _t);
	public: void csl_register_declaration(antlr::RefCslAST _t);
	public: void csl_memory_declaration(antlr::RefCslAST _t);
	public: void csl_testbench_declaration(antlr::RefCslAST _t);
	public: void csl_bool_equation_declaration(antlr::RefCslAST _t);
	public: void csl_event_declaration(antlr::RefCslAST _t);
	public: void csl_enum_declaration(antlr::RefCslAST _t);
	public: void csl_parameter_declaration(antlr::RefCslAST _t);
	public: void csl_state_data_declaration(antlr::RefCslAST _t);
	public: void csl_vector_declaration(antlr::RefCslAST _t);
	public: void csl_signal_pattern_generator_declaration(antlr::RefCslAST _t);
	public: void csl_include_declaration(antlr::RefCslAST _t);
	public: void csl_fifo_declaration(antlr::RefCslAST _t);
	public: void csl_memory_map_declaration(antlr::RefCslAST _t);
	public: void csl_memory_map_page_declaration(antlr::RefCslAST _t);
	public: void csl_isa_field_declaration(antlr::RefCslAST _t);
	public: void csl_isa_element_declaration(antlr::RefCslAST _t);
	public: void csl_isa_declaration(antlr::RefCslAST _t);
	public: void csl_unit_definition(antlr::RefCslAST _t,
		 std::pair<RefString, int> id 
	);
	public: void csl_inst_or_cstor(antlr::RefCslAST _t);
	public: void csl_build_function_declaration(antlr::RefCslAST _t);
	public: void csl_instantiation(antlr::RefCslAST _t);
	public: void csl_cstor(antlr::RefCslAST _t);
	public: std::pair<NSCSLOm::RefTVec_RefCSLOmExpr, TBool>  parameter_overriding_instantiation(antlr::RefCslAST _t);
	public: void param_list_csl_list(antlr::RefCslAST _t,
		NSCSLOm::RefCSLOmList list
	);
	public: NSCSLOm::RefCSLOmList  csl_anonymous_list_declaration(antlr::RefCslAST _t);
	public: void csl_enum_item(antlr::RefCslAST _t,
		pair <RefString,int>& id
	);
	public: NSCSLOm::RefCSLOmExprConcat  concatenation(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExprMultiConcat  multiple_concatenation(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmList  expression_list(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExpr  expr_primary(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExprLink  expression_hybrid(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExpr  function_call_ret_id(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExpr  function_call_ret_expr(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExpr  number(antlr::RefCslAST _t);
	public:  RefString  str(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExprLink  expr_primary_identifier(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExprHybridOrFuncCall  returning_exlink_rules(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExprLink  get_exprlink_from_identifier(antlr::RefCslAST _t);
	public: NSCSLOm::RefCSLOmExpr  sized_number(antlr::RefCslAST _t);
public:
	ANTLR_USE_NAMESPACE(antlr)RefAST getAST()
	{
		return ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST);
	}
	
protected:
	antlr::RefCslAST returnAST;
	antlr::RefCslAST _retTree;
private:
	static const char* tokenNames[];
#ifndef NO_STATIC_CONSTS
	static const int NUM_TOKENS = 802;
#else
	enum {
		NUM_TOKENS = 802
	};
#endif
	
	static const unsigned long _tokenSet_0_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_0;
	static const unsigned long _tokenSet_1_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_1;
	static const unsigned long _tokenSet_2_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_2;
	static const unsigned long _tokenSet_3_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_3;
};

#endif /*INC_CslTreeWalker_hpp_*/
