#ifndef INC_CslParser_hpp_
#define INC_CslParser_hpp_

#include <antlr/config.hpp>
/* $ANTLR 2.7.7 (2006-11-01): "csl.parser.g" -> "CslParser.hpp"$ */
#include <antlr/TokenStream.hpp>
#include <antlr/TokenBuffer.hpp>
#include "CslParserTokenTypes.hpp"
#include <antlr/LLkParser.hpp>

#line 35 "csl.parser.g"

#include "Def.hpp"
#include "CslNumber.hpp"
#include "CslToken.hpp"
#include "CslAST.hpp"
#include "SymTree.h"
#include "../../support/TypeDefs.h"
#define DEBUG_PARSER

#line 22 "CslParser.hpp"
class CUSTOM_API CslParser : public ANTLR_USE_NAMESPACE(antlr)LLkParser, public CslParserTokenTypes
{
#line 1 "csl.parser.g"
#line 26 "CslParser.hpp"
public:
	void initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& factory );
protected:
	CslParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf, int k);
public:
	CslParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf);
protected:
	CslParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer, int k);
public:
	CslParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer);
	CslParser(const ANTLR_USE_NAMESPACE(antlr)ParserSharedInputState& state);
	int getNumTokens() const
	{
		return CslParser::NUM_TOKENS;
	}
	const char* getTokenName( int type ) const
	{
		if( type > getNumTokens() ) return 0;
		return CslParser::tokenNames[type];
	}
	const char* const* getTokenNames() const
	{
		return CslParser::tokenNames;
	}
	public: void select_components(
		 TInt mask 
	);
	public: void source_text();
	public: void description();
	public: void csl_command();
	public: void csl_declaration();
	public: void preprocessor_directive();
	public: void unexpected();
	public: void csl_unit_declaration();
	public: void csl_signal_declaration();
	public: void csl_port_declaration();
	public: void csl_bitrange_declaration();
	public: void csl_signal_group_declaration();
	public: void csl_interface_declaration();
	public: void csl_list_declaration(
		TInt line, TInt column
	);
	public: void csl_register_file_declaration();
	public: void csl_testbench_declaration();
	public: void csl_include_declaration();
	public: void csl_isa_field_declaration();
	public: void csl_isa_element_declaration();
	public: void csl_enum_declaration();
	public: void csl_field_declaration();
	public: void csl_fifo_declaration();
	public: void csl_memory_map_declaration();
	public: void csl_memory_map_page_declaration();
	public: void csl_register_declaration();
	public: void csl_read_interface_declaration();
	public: void csl_write_interface_declaration();
	public: void csl_state_data_declaration();
	public: void csl_vector_declaration();
	public: void csl_memory_declaration();
	public: void csl_multi_dim_bitrange_declaration();
	public: void csl_pipeline_declaration();
	public: void csl_pipestage_declaration();
	public: void csl_const_int_declaration();
	public: void csl_parameter_declaration();
	public: void csl_unit_definition(
		RefString objectName = RefString(), NSSymbolTable::EObjType type = NSSymbolTable::TUNDEF, RefString inheritanceId = RefString(), TInt inheritanceLine = -1, TInt inheritanceColumn = -1
	);
	public: void expression();
	public: void csl_enum_declaration_item();
	public:  bool  param_list_csl_list();
	public: TBool  csl_inst_or_cstor();
	public: void csl_inst(
		RefString str
	);
	public: void csl_cstor();
	public: void parameter_overridding_instantiation();
	public: void param_list_formal_to_actual_mapping();
	public: void param_list_csl_port();
	public: void param_list_csl_signal();
	public: void bitrange_pure();
	public: void range_expression();
	public: void concatenation();
	public: void param_list_add_port_list(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_type(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_attr(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_unit_prefix(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_signal_prefix(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_signal_prefix_local(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_depth(
		RefTVec_RefString scopeId
	);
	public: void param_list_create_rtl_module(
		RefTVec_RefString scopeId
	);
	public: void param_list_directive(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_width(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_dim_width(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_bitrange(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_dim_bitrange(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_range(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_dim_range(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_offset(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_dim_offset(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_number_of_dimensions(
		RefTVec_RefString scopeId
	);
	public: void param_list_reverse(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_instance_alteration_bit(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_testbench_verilog_filename(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_compare_trigger(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_direction(
		RefTVec_RefString scopeId
	);
	public: void param_list_exclusion_list(
		RefTVec_RefString scopeId
	);
	public: void param_list_include_only(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_radix(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_top_unit(
		RefTVec_RefString scopeId
	);
	public: void param_list_add(
		RefTVec_RefString scopeId
	);
	public: void param_list_add_address_range(
		RefTVec_RefString scopeId
	);
	public: void param_list_add_reserved_address_range(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_data_word_width(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_address_increment(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_next_address(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_alignment(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_prefix(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_suffix(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_endianess(
		RefTVec_RefString scopeId
	);
	public: void param_list_auto_gen_memory_map(
		RefTVec_RefString scopeId
	);
	public: void param_list_add_to_memory_map(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_access_rights(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_access_rights_enum(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_symbol_max_length(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_enum(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_enum_item(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_mnemonic(
		RefTVec_RefString scopeId
	);
	public: void param_list_gen_decoder(
		RefTVec_RefString scopeId 
	);
	public: void param_list_set_physical_implementation(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_value(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_field(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_field_position(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_position(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_next(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_previous(
		RefTVec_RefString scopeId
	);
	public: void param_list_add_allowed_range(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_attributes(
		RefTVec_RefString scopeId
	);
	public: void param_list_add_logic(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_start_generation_trigger(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_unit_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_pipestage_naming_convention(
		RefTVec_RefString scopeId
	);
	public: void param_list_merge(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_header_comment(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_version(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_clock(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_reset(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_stall(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_end_generation_trigger(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_capture_edge_type(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_max_number_of_mismatches(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_max_number_of_valid_transactions(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_valid_output_transaction(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_output_filename(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_vc_max_cycles(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_mem_instance_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_reset_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_clock_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_rd_clock_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_wr_clock_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_push_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_pop_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_full_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_empty_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_wr_data_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_rd_data_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_valid_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_wr_addr_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_rd_addr_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_wr_en_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_rd_en_name(
		RefTVec_RefString scopeId
	);
	public: void param_list_initialize_random_values(
		RefTVec_RefString scopeId
	);
	public: void param_list_initialize_random(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_unit_id(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_num_rd_ifc(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_num_wr_ifc(
		RefTVec_RefString scopeId
	);
	public: void param_list_gen_unique_rtl_modules(
		RefTVec_RefString scopeId
	);
	public: void param_list_no_prefix(
		RefTVec_RefString scopeId
	);
	public: void param_list_override_parameter(
		RefTVec_RefString scopeId
	);
	public: void param_list_do_not_gen_rtl(
		RefTVec_RefString scopeId
	);
	public: void param_list_do_not_gen_cpp(
		RefTVec_RefString scopeId
	);
	public: void param_list_set_clock(
		RefTVec_RefString scopeId
	);
	public: void param_list_register_ios(
		RefTVec_RefString scopeId
	);
	public: void param_list_connect_units(
		RefTVec_RefString scopeId
	);
	public: void param_list_connect_by_pattern(
		RefTVec_RefString scopeId, TBool wasConcat
	);
	public: void param_list_connect_by_name(
		RefTVec_RefString scopeId, TBool wasConcat
	);
	public: void csl_statement_assign(
		RefTVec_RefString scopeId
	);
	public: void add_logic_neg_output(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_serial_input(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_serial_output(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_clock(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_generate_report(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_async_reset(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_init(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_clear(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_stop(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_inject_stalls(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_load(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_generate_waves(
		RefTVec_RefString scopeId
	);
	public: void add_logic_gray_output(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_start_value(
		RefTVec_RefString scopeId
	);
	public: void add_logic_end_value(
		RefTVec_RefString scopeId
	);
	public: void add_logic_count_amount(
		RefTVec_RefString scopeId
	);
	public: void add_logic_count_direction(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_set(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_reset(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_programmable_depth(
		RefTVec_RefString scopeId
	);
	public: void add_logic_priority_bypass(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_sync_fifo(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_async_fifo(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_depth_extend(
		RefTVec_RefString scopeId
	);
	public: void add_logic_width_extend(
		RefTVec_RefString scopeId
	);
	public: void add_logic_wr_hold(
		RefTVec_RefString scopeId
	);
	public: void add_logic_parallel_output(
		RefTVec_RefString scopeId
	);
	public: void add_logic_parallel_input(
		RefTVec_RefString scopeId
	);
	public: void add_logic_rd_words(
		RefTVec_RefString scopeId
	);
	public: void add_logic_wr_words(
		RefTVec_RefString scopeId
	);
	public: void add_logic_sram_rd(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_sram_wr(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_pushback(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_flow_through(
		RefTVec_RefString scopeId
	);
	public: void add_logic_read_valid(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_stall(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_stall_rd_side(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_stall_wr_side(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_wr_release(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_almost_empty(
		RefTVec_RefString scopeId
	);
	public: void add_logic_almost_full(
		RefTVec_RefString scopeId
	);
	public: void add_logic_output_wr_addr(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_output_rd_addr(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_credit(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_rd_credit(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_wr_credit(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void add_logic_flow(
		RefTVec_RefString scopeId, TInt line, TInt column
	);
	public: void param_list_add_dut_instance();
	public: void param_list_gen_indiv_rtl_sig(
		RefTVec_RefString scopeId
	);
	public: void param_list_simulation_timeout_counter();
	public: void param_list_data_generation();
	public: void param_list_no_args_command();
	public: void param_list_get_interface();
	public: void f2a_pair_expr();
	public: void param_list_connect(
		RefTVec_RefString scopeId, TBool wasConcat
	);
	public: void param_list_get_dim_bitrange();
	public: void param_list_get_dim_width();
	public: void param_list_get_address_width();
	public: void param_list_get_dim_offset();
	public: void param_list_get_dim_upper_index();
	public: void param_list_get_dim_lower_index();
	public: void conditional_expr();
	public: void logical_or_expr();
	public: void logical_and_expr();
	public: void or_expr();
	public: void xor_expr();
	public: void and_expr();
	public: void equality_expr();
	public: void relational_expr();
	public: void shift_expr();
	public: void additive_expr();
	public: void multiplicative_expr();
	public: void pow_expr();
	public: void unary_not();
	public: void unary_expr();
	public: void concatenation_dummy();
	public: void simple_concat();
	public: void multi_concat();
	public: void expr_primary();
	public: void number();
	public: void expr_primary_identifier();
	public: void unsigned_number();
	public: void based_number();
	public: void real_number();
	public: void function_call_ret_id();
	public: void function_call_ret_expr();
public:
	ANTLR_USE_NAMESPACE(antlr)RefAST getAST()
	{
		return ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST);
	}
	
protected:
	antlr::RefCslAST returnAST;
private:
	static const char* tokenNames[];
#ifndef NO_STATIC_CONSTS
	static const int NUM_TOKENS = 778;
#else
	enum {
		NUM_TOKENS = 778
	};
#endif
	
	static const unsigned long _tokenSet_0_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_0;
	static const unsigned long _tokenSet_1_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_1;
};

#endif /*INC_CslParser_hpp_*/
