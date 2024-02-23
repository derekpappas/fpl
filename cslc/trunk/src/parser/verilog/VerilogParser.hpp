#ifndef INC_VerilogParser_hpp_
#define INC_VerilogParser_hpp_

#include <antlr/config.hpp>
/* $ANTLR 2.7.7 (20060906): "verilog.parser.g" -> "VerilogParser.hpp"$ */
#include <antlr/TokenStream.hpp>
#include <antlr/TokenBuffer.hpp>
#include "VerilogParserTokenTypes.hpp"
#include <antlr/LLkParser.hpp>

#line 24 "verilog.parser.g"

    #include "Def.hpp"
    #include "VerilogNumber.hpp"
    #include "VerilogToken.hpp"
    #include "VerAST.hpp"
    #include "ToolsParser.hpp"
    #include "../../support/CommonSupport.h"

    #define DEBUG_PARSER

    ANTLR_USING_NAMESPACE(std);
    ANTLR_USING_NAMESPACE(antlr);
    
#line 26 "VerilogParser.hpp"
class CUSTOM_API VerilogParser : public ANTLR_USE_NAMESPACE(antlr)LLkParser, public VerilogParserTokenTypes
{
#line 163 "verilog.parser.g"

    enum TUdpType { UDP_UNKNOWN, UDP_COMB, UDP_SEQ };
  #line 30 "VerilogParser.hpp"
public:
	void initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& factory );
protected:
	VerilogParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf, int k);
public:
	VerilogParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf);
protected:
	VerilogParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer, int k);
public:
	VerilogParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer);
	VerilogParser(const ANTLR_USE_NAMESPACE(antlr)ParserSharedInputState& state);
	int getNumTokens() const
	{
		return VerilogParser::NUM_TOKENS;
	}
	const char* getTokenName( int type ) const
	{
		if( type > getNumTokens() ) return 0;
		return VerilogParser::tokenNames[type];
	}
	const char* const* getTokenNames() const
	{
		return VerilogParser::tokenNames;
	}
	public: void unexpected();
	public: void source_text();
	public: void description();
	public: void attrs_opt();
	public: void module();
	public: void udp_declaration();
	public: void module_keyword();
	public: void module_identifier();
	public: void module_parameter_port_list();
	public: void list_of_port_declarations();
	public: TInt  list_of_ports();
	public: void module_item(
		TBool canDeclPort
	);
	public: void parameter_declaration_header();
	public: void param_assignment();
	public: TBool  port();
	public: TBool  port_declaration();
	public: TBool  variable_port_identifier();
	public: void port_expression();
	public: void named_port_expression();
	public: void port_identifier();
	public: void port_reference();
	public: void port_reference_concat();
	public: void constant_range_expression();
	public: void inout_declaration();
	public: void input_declaration();
	public: TBool  output_declaration();
	public: void specify_block();
	public: void generated_instantiation();
	public: void local_parameter_declaration();
	public: void module_or_generate_item();
	public: void parameter_declaration();
	public: void specparam_declaration();
	public: void module_or_generate_item_declaration();
	public: void parameter_override();
	public: void continuous_assign();
	public: void gate_instantiation();
	public: void module_or_udp_instantiation();
	public: void initial_construct();
	public: void always_construct();
	public: void net_declaration();
	public: void reg_declaration();
	public: void integer_declaration();
	public: void real_declaration();
	public: void time_declaration();
	public: void realtime_declaration();
	public: void event_declaration();
	public: void genvar_declaration();
	public: void task_declaration();
	public: void function_declaration();
	public: void list_of_defparam_assignments();
	public: void range();
	public: void parameter_type();
	public: void list_of_param_assignments();
	public: void list_of_specparam_assignments();
	public: void net_type();
	public: void output_variable_type();
	public: void list_of_variable_identifiers();
	public: void drive_strength();
	public: void expandrange();
	public: void delay3();
	public: void list_of_net_identifiers_or_decl_assignments(
		TBool& decl
	);
	public: void charge_strength();
	public: void list_of_event_identifiers();
	public: void list_of_genvar_identifiers();
	public: void variable_type();
	public: void variable_identifier();
	public: void dimension();
	public: void constant_expression();
	public: void strength0();
	public: void strength1();
	public: void highz1();
	public: void highz0();
	public: void delay_value();
	public: void mintypmax_expression();
	public: void delay2();
	public: void unsigned_number();
	public: void real_number();
	public: void identifier();
	public: void net_identifier();
	public: void expression();
	public: void event_identifier();
	public: void genvar_identifier();
	public: void defparam_assignment();
	public: void specparam_assignment();
	public: void list_of_variable_port_identifiers();
	public: void hierarchical_parameter_identifier();
	public: void constant_mintypmax_expression();
	public: void parameter_identifier();
	public: void pulse_control_specparam();
	public: void dimension_constant_expression();
	public: void lsb_constant_expression();
	public: void msb_constant_expression();
	public: void range_or_type();
	public: void function_identifier();
	public: void function_item_declaration();
	public: void function_statement();
	public: void function_port_list();
	public: void block_item_declaration();
	public: void tf_input_declaration();
	public: void task_identifier();
	public: void task_item_declaration();
	public: void statement_or_null();
	public: void task_port_list();
	public: void tf_output_declaration();
	public: void tf_inout_declaration();
	public: void task_port_item();
	public: void task_port_type();
	public: void cmos_switchtype();
	public: void cmos_switch_instance();
	public: void enable_gatetype();
	public: void enable_gate_instance();
	public: void mos_switchtype();
	public: void mos_switch_instance();
	public: void n_input_gatetype();
	public: void n_input_gate_instance();
	public: void n_output_gatetype();
	public: void n_output_gate_instance();
	public: void pass_enable_switchtype();
	public: void pass_enable_switch_instance();
	public: void pass_switchtype();
	public: void pass_switch_instance();
	public: void pulldown_strength();
	public: void pull_gate_instance();
	public: void pullup_strength();
	public: void name_of_gate_instance();
	public: void output_terminal();
	public: void input_terminal();
	public: void ncontrol_terminal();
	public: void pcontrol_terminal();
	public: void enable_terminal();
	public: void inout_terminal();
	public: void gate_instance_identifier();
	public: void net_lvalue();
	public: void parameter_value_assignment_or_delay2();
	public: void module_instance();
	public: void list_of_parameter_assignments_or_delay2();
	public: void ordered_parameter_assignment();
	public: void named_parameter_assignment();
	public: void name_of_module_instance();
	public: void list_of_port_connections();
	public: void module_instance_identifier();
	public: void ordered_port_connection();
	public: void named_port_connection();
	public: void generate_item();
	public: void generate_item_or_null();
	public: void generate_conditional_statement();
	public: void generate_case_statement();
	public: void generate_loop_statement();
	public: void generate_block();
	public: void genvar_case_item();
	public: void genvar_assignment();
	public: void generate_block_identifier();
	public: void udp_identifier();
	public: void udp_port_list();
	public: void udp_declaration_port_list();
	public: void udp_port_declaration();
	public: void udp_body();
	public: void udp_output_declaration();
	public: void udp_input_declaration_header();
	public: void udp_input_declaration();
	public: void udp_reg_declaration();
	public: void udp_initial_statement();
	public: void udp_table_entry(
		TUdpType& udpType
	);
	public: void init_val();
	public: void number();
	public: void input_list(
		TBool& hasEdge, TBool& hasLevel
	);
	public: void current_state();
	public: void next_state();
	public: void output_symbol();
	public: void level_symbol();
	public: void edge_indicator();
	public: void edge_symbol();
	public: void list_of_net_assignments();
	public: void net_assignment();
	public: void assignment();
	public: void lvalue();
	public: void statement();
	public: void blocking_or_nonblocking_assignment();
	public: void variable_lvalue();
	public: void delay_or_event_control();
	public: void procedural_continuous_assignments();
	public: void variable_assignment();
	public: void variable_or_net_assignment();
	public: void net_or_variable_lvalue();
	public: void par_block();
	public: void block_identifier();
	public: void seq_block();
	public: void case_statement();
	public: void conditional_statement();
	public: void disable_statement();
	public: void event_trigger();
	public: void loop_statement();
	public: void procedural_timing_control_statement();
	public: void system_task_enable();
	public: void task_enable();
	public: void wait_statement();
	public: void delay_control();
	public: void event_control();
	public: void hierarchical_identifier();
	public: void event_expression();
	public: void expr_primary_identifier_no_range();
	public: void list_of_event_expression();
	public: void or_event_expression();
	public: void event_expression_primary();
	public: void procedural_timing_control();
	public: void case_item();
	public: void expression_list();
	public: void system_function_name();
	public: void specify_item();
	public: void pulsestyle_declaration();
	public: void showcancelled_declaration();
	public: void path_declaration();
	public: void system_timing_check();
	public: TBool  list_of_path_outputs();
	public: void simple_or_edge_sensitive_path_declaration();
	public: void state_dependent_path_declaration();
	public: void edge_identifier();
	public: TBool  list_of_path_inputs();
	public: TBool  polarity_operator(
		TBool canBeColon
	);
	public: TBool  parallel_or_full_path_description();
	public: void parallel_or_full_edge_sensitive_path_description(
		TBool canBeSimple
	);
	public: void path_delay_value();
	public: TBool  list_of_path_terminals();
	public: void specify_terminal_descriptor();
	public: void list_of_path_delay_expressions();
	public: void path_delay_expression();
	public: void data_source_expression();
	public: void module_path_expression();
	public: void setup_timing_check();
	public: void hold_timing_check();
	public: void setuphold_timing_check();
	public: void recovery_timing_cehck();
	public: void removal_timing_check();
	public: void recrem_timing_check();
	public: void skew_timing_check();
	public: void timeskew_timing_check();
	public: void fullskew_timing_check();
	public: void period_timing_check();
	public: void width_timing_check();
	public: void nochange_timing_check();
	public: void data_event();
	public: void reference_event();
	public: void timing_check_limit();
	public: void notify_reg();
	public: void stamptime_condition();
	public: void checktime_condition();
	public: void delayed_reference();
	public: void delayed_data();
	public: void event_based_flag();
	public: void remain_active_flag();
	public: void controlled_reference_event();
	public: void threshold();
	public: void start_edge_offset();
	public: void end_edge_offset();
	public: void controlled_timing_check_event();
	public: void timing_check_event();
	public: void delayed_data_or_reference();
	public: void terminal_identifier();
	public: void timing_check_event_control();
	public: void timing_check_condition();
	public: void edge_control_specifier();
	public: void edge_descriptor();
	public: void scalar_timing_check_condition();
	public: void concatenation();
	public: void function_call();
	public: void hierarchical_function_identifier();
	public: void system_function_call();
	public: void range_expression();
	public: void pure_mintypmax_expression();
	public: void conditional_expr();
	public: void logical_or_expr();
	public: void logical_and_expr();
	public: void or_expr();
	public: void xor_expr();
	public: void and_expr();
	public: void equality_expr();
	public: void relational_expr();
	public: void shift_expr();
	public: void addictive_expr();
	public: void multiplicative_expr();
	public: void pow_expr();
	public: void unary_expr();
	public: void expr_primary();
	public: void expr_primary_identifier();
	public: void based_number();
	public: void attrs();
	public: void attribute_instance();
	public: void attr_spec();
	public: void attr_name();
	public: void specparam_identifier();
public:
	ANTLR_USE_NAMESPACE(antlr)RefAST getAST()
	{
		return ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST);
	}
	
protected:
	RefVerAST returnAST;
private:
	static const char* tokenNames[];
#ifndef NO_STATIC_CONSTS
	static const int NUM_TOKENS = 334;
#else
	enum {
		NUM_TOKENS = 334
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
	static const unsigned long _tokenSet_4_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_4;
	static const unsigned long _tokenSet_5_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_5;
	static const unsigned long _tokenSet_6_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_6;
	static const unsigned long _tokenSet_7_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_7;
	static const unsigned long _tokenSet_8_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_8;
	static const unsigned long _tokenSet_9_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_9;
	static const unsigned long _tokenSet_10_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_10;
	static const unsigned long _tokenSet_11_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_11;
	static const unsigned long _tokenSet_12_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_12;
	static const unsigned long _tokenSet_13_data_[];
	static const ANTLR_USE_NAMESPACE(antlr)BitSet _tokenSet_13;
};

#endif /*INC_VerilogParser_hpp_*/
