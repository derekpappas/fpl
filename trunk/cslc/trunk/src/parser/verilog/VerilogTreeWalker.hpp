#ifndef INC_VerilogTreeWalker_hpp_
#define INC_VerilogTreeWalker_hpp_

#include <antlr/config.hpp>
#include "VerilogTreeWalkerTokenTypes.hpp"
/* $ANTLR 2.7.7 (20060906): "verilog.walker.g" -> "VerilogTreeWalker.hpp"$ */
#include <antlr/TreeParser.hpp>

#line 24 "verilog.walker.g"

    #include <string>
    
    #include "Def.hpp"
    #include "VerilogNumber.hpp"
    #include "VerAST.hpp"
    #include "Tools.hpp"
    #include "../../support/CommonSupport.h"
    #include "../../cdom/CDOM.h"

//    #include "cdom/RefCount.h"

    ANTLR_USING_NAMESPACE(std);
    ANTLR_USING_NAMESPACE(antlr);
    ANTLR_USING_NAMESPACE(NSCdom);
    
#line 27 "VerilogTreeWalker.hpp"
class CUSTOM_API VerilogTreeWalker : public ANTLR_USE_NAMESPACE(antlr)TreeParser, public VerilogTreeWalkerTokenTypes
{
#line 91 "verilog.walker.g"

//void VerilogTreeWalker::printAST(RefVerAST ast);
void printAST(RefVerAST ast);
#line 31 "VerilogTreeWalker.hpp"
public:
	VerilogTreeWalker();
	static void initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& factory );
	int getNumTokens() const
	{
		return VerilogTreeWalker::NUM_TOKENS;
	}
	const char* getTokenName( int type ) const
	{
		if( type > getNumTokens() ) return 0;
		return VerilogTreeWalker::tokenNames[type];
	}
	const char* const* getTokenNames() const
	{
		return VerilogTreeWalker::tokenNames;
	}
	public: void source_text(RefVerAST _t,
		RefCDOmDesign design
	);
	public: void description(RefVerAST _t,
		RefCDOmDesign design
	);
	public: RefCDOmAttrListCollection  attrs_opt(RefVerAST _t);
	public: void module(RefVerAST _t,
		RefCDOmDesign design, RefCDOmAttrListCollection attrColl
	);
	public: void udp_declaration(RefVerAST _t,
		RefCDOmDesign design, RefCDOmAttrListCollection declColl
	);
	public: pair<RefString, int>  identifier(RefVerAST _t);
	public: void module_parameter_port_list(RefVerAST _t,
		RefCDOmModuleDecl moduleDecl
	);
	public: void list_of_port_declarations(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void list_of_ports(RefVerAST _t,
		RefCDOmModuleDecl moduleDecl
	);
	public: void module_item(RefVerAST _t,
		RefCDOmModuleDecl moduleDecl
	);
	public: RefCDOmParamDecl  parameter_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void port(RefVerAST _t,
		RefCDOmModuleDecl moduleDecl
	);
	public: RefCDOmPortDecl  port_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void port_expression(RefVerAST _t,
		RefCDOmModuleDecl moduleDecl, const RefString named
	);
	public: void named_port_expression(RefVerAST _t,
		RefCDOmModuleDecl moduleDecl
	);
	public: void port_reference(RefVerAST _t,
		RefCDOmPortItem portItem
	);
	public: void port_reference_concat(RefVerAST _t,
		RefCDOmPortItem portItem
	);
	public: RefCDOmRangeExpr  range_expression(RefVerAST _t);
	public: RefCDOmPortDecl  inout_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmPortDecl  input_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmPortDecl  output_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmAttrHolder  module_or_generate_item(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmParamDecl  local_parameter_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmParamDecl  specparam_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void specify_block(RefVerAST _t,
		RefCDOmModuleDecl parent
	);
	public: void generated_instantiation(RefVerAST _t,
		RefCDOmModuleDecl parent
	);
	public: RefCDOmAttrHolder  module_or_generate_item_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public:  RefCDOmParamOverride  parameter_override(RefVerAST _t,
		 RefCDOmBase parent 
	);
	public: RefCDOmContAssn  continuous_assign(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmGateInstantiation  gate_instantiation(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmModuleOrUdpInstantiation  module_or_udp_instantiation(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmInitOrAlways  initial_construct(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmInitOrAlways  always_construct(RefVerAST _t,
		RefCDOmBase parent
	);
	public:  RefCDOmNetDecl  net_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmVarDecl  reg_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmVarDecl  integer_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmVarDecl  real_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmVarDecl  time_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public:  RefCDOmVarDecl  realtime_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmEventDecl  event_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmGenvarDecl  genvar_declaration(RefVerAST _t,
		 RefCDOmBase parent 
	);
	public:  RefCDOmTaskDecl  task_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public:  RefCDOmFuncDecl  function_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmExprLink  hierarchical_identifier(RefVerAST _t);
	public: RefCDOmMinTypMax  mintypmax_expression(RefVerAST _t);
	public: RefCDOmRange  range(RefVerAST _t);
	public: CDOmParamDecl::EParamType  parameter_type(RefVerAST _t);
	public: void list_of_param_assignments(RefVerAST _t,
		RefCDOmParamDecl paramDecl
	);
	public: void list_of_specparam_assignments(RefVerAST _t,
		RefCDOmParamDecl paramDecl
	);
	public: ECDOmNetType  net_type(RefVerAST _t);
	public: ECDOmVarType  output_variable_type(RefVerAST _t);
	public: RefCDOmExpr  expression(RefVerAST _t);
	public: void list_of_variable_identifiers(RefVerAST _t,
		RefCDOmVarDecl varDecl
	);
	public: void drive_strength(RefVerAST _t,
		ECDOmDriveStrength& ds1, ECDOmDriveStrength& ds2
	);
	public: CDOmNetDecl::EVectorAccessType  expandrange(RefVerAST _t);
	public: void delay3(RefVerAST _t,
		RefCDOmBase delayHolder
	);
	public: void list_of_net_identifiers_or_decl_assignments(RefVerAST _t,
		RefCDOmNetDecl netDecl
	);
	public: CDOmNetDecl::EChargeStrength  charge_strength(RefVerAST _t);
	public: void list_of_event_identifiers(RefVerAST _t,
		 RefCDOmEventDecl &eventDecl, RefCDOmBase parent, int lineNumber
	);
	public: RefCDOmGenvarDecl  list_of_genvar_identifiers(RefVerAST _t,
		 RefCDOmBase parent 
	);
	public: void variable_type(RefVerAST _t,
		RefCDOmVarDecl varDecl
	);
	public: RefCDOmRangeList  list_of_dimensions(RefVerAST _t);
	public: ECDOmDriveStrength  strength0(RefVerAST _t);
	public: ECDOmDriveStrength  strength1(RefVerAST _t);
	public: ECDOmDriveStrength  highz1(RefVerAST _t);
	public: ECDOmDriveStrength  highz0(RefVerAST _t);
	public: RefCDOmExpr  delay_value(RefVerAST _t);
	public: void delay2(RefVerAST _t,
		RefCDOmModuleOrUdpInstantiation delayHolder
	);
	public: RefCDOmRange  dimension(RefVerAST _t);
	public: void param_assignment(RefVerAST _t,
		RefCDOmParamDecl paramDecl
	);
	public: void pulse_control_specparam(RefVerAST _t,
		 RefCDOmParamDecl paramDecl 
	);
	public: RefCDOmRangeList  list_of_ranges(RefVerAST _t);
	public:  RefCDOmAttrHolder   function_item_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: RefCDOmStmt  statement(RefVerAST _t);
	public: void function_port_list(RefVerAST _t,
		RefCDOmBase parent
	);
	public:  RefCDOmAttrHolder  block_item_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public:  RefCDOmTFPortDecl  tf_input_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void task_port_list(RefVerAST _t,
		RefCDOmBase parent
	);
	public:  RefCDOmAttrHolder  task_item_declaration(RefVerAST _t,
		 RefCDOmBase parent 
	);
	public: RefCDOmStmt  statement_or_null(RefVerAST _t);
	public:  RefCDOmTFPortDecl  tf_output_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public:  RefCDOmTFPortDecl  tf_inout_declaration(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void task_port_item(RefVerAST _t,
		RefCDOmBase parent
	);
	public:  ECDOmVarType  task_port_type(RefVerAST _t);
	public: CDOmGateInstantiation::EPrimitiveType  cmos_switchtype(RefVerAST _t);
	public: void cmos_switch_instance(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: CDOmGateInstantiation::EPrimitiveType  enable_gatetype(RefVerAST _t);
	public: void enable_gate_instance(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: CDOmGateInstantiation::EPrimitiveType  mos_switchtype(RefVerAST _t);
	public: void mos_switch_instance(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: CDOmGateInstantiation::EPrimitiveType  n_input_gatetype(RefVerAST _t);
	public: void n_input_gate_instance(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: CDOmGateInstantiation::EPrimitiveType  n_output_gatetype(RefVerAST _t);
	public: void n_output_gate_instance(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: CDOmGateInstantiation::EPrimitiveType  pass_enable_switchtype(RefVerAST _t);
	public: void pass_enable_switch_instance(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: CDOmGateInstantiation::EPrimitiveType  pass_switchtype(RefVerAST _t);
	public: void pass_switch_instance(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: void pulldown_strength(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: void pull_gate_instance(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: void pullup_strength(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: void name_of_gate_instance(RefVerAST _t,
		RefCDOmGateInstantiation gateInst
	);
	public: RefCDOmExpr  lvalue(RefVerAST _t);
	public: void parameter_value_assignment_or_delay2(RefVerAST _t,
		RefCDOmModuleOrUdpInstantiation moduleInstantiation
	);
	public: void module_instance(RefVerAST _t,
		RefCDOmModuleOrUdpInstantiation moduleInstantiation
	);
	public: void list_of_parameter_assignments_or_delay2(RefVerAST _t,
		RefCDOmModuleOrUdpInstantiation moduleInstantiation
	);
	public: void named_parameter_assignment(RefVerAST _t,
		RefString &str, RefCDOmMinTypMax &minTypMax
	);
	public: void list_of_port_connections(RefVerAST _t,
		RefCDOmModuleOrUdpInstance moduleInstance
	);
	public: void ordered_port_connection(RefVerAST _t,
		RefCDOmExpr &expr
	);
	public: void named_port_connection(RefVerAST _t,
		RefCDOmExpr &expr, RefString &str
	);
	public: void generate_item(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void generate_item_or_null(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void generate_conditional_statement(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void generate_case_statement(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void generate_loop_statement(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void generate_block(RefVerAST _t,
		RefCDOmBase parent
	);
	public: void udp_port_list(RefVerAST _t,
		RefCDOmUdpDecl udpdecl
	);
	public: void udp_declaration_port_list(RefVerAST _t,
		 RefCDOmUdpDecl udpDecl 
	);
	public: void udp_port_declaration(RefVerAST _t,
		RefCDOmUdpDecl udpDecl
	);
	public: void udp_body(RefVerAST _t,
		RefCDOmUdpDecl udpDecl
	);
	public:  RefCDOmUdpPortDeclOutput  udp_output_declaration(RefVerAST _t,
		RefCDOmUdpDecl udpDecl
	);
	public: RefCDOmUdpPortDeclInput  udp_input_declaration(RefVerAST _t,
		RefCDOmUdpDecl udpDecl
	);
	public: RefCDOmUdpPortDeclOutput  udp_reg_declaration(RefVerAST _t,
		RefCDOmUdpDecl udpDecl
	);
	public: void udp_initial_statement(RefVerAST _t,
		RefCDOmUdpDecl udpDecl
	);
	public: void udp_table_entry(RefVerAST _t,
		RefCDOmUdpDecl udpDecl
	);
	public: CDOmUdpInitStmt::EInitVal  init_val(RefVerAST _t);
	public: ECDOmUdpSymbol  level_symbol(RefVerAST _t);
	public: CDOmUdpSeqEntry::ESeqEdgeSymbol  edge_indicator(RefVerAST _t,
		ECDOmUdpSymbol &retuned1, ECDOmUdpSymbol &retuned2
	);
	public: ECDOmUdpSymbol  next_state(RefVerAST _t);
	public: ECDOmUdpSymbol  output_symbol(RefVerAST _t);
	public: RefCDOmAssn  assignment(RefVerAST _t);
	public: RefCDOmStmtAssn  blocking_or_nonblocking_assignment(RefVerAST _t);
	public: void delay_or_event_control(RefVerAST _t,
		 RefCDOmDelayControl&delayControl, RefCDOmEventControl&eventControl, RefCDOmExpr&exprEventControl 
	);
	public: RefCDOmStmtProcContAssn  procedural_continuous_assignments(RefVerAST _t);
	public:  RefCDOmStmtBlock  par_block(RefVerAST _t);
	public: RefCDOmStmtBlock  seq_block(RefVerAST _t);
	public: RefCDOmStmtCase  case_statement(RefVerAST _t);
	public: RefCDOmStmtIf  conditional_statement(RefVerAST _t);
	public: RefCDOmStmtDisable  disable_statement(RefVerAST _t);
	public: RefCDOmStmtEventTrigger  event_trigger(RefVerAST _t);
	public: RefCDOmStmtLoop  loop_statement(RefVerAST _t);
	public: RefCDOmStmt  procedural_timing_control_statement(RefVerAST _t);
	public: RefCDOmStmtTaskEnable  system_task_enable(RefVerAST _t);
	public: RefCDOmStmtTaskEnable  task_enable(RefVerAST _t);
	public: RefCDOmStmtWait  wait_statement(RefVerAST _t);
	public: RefCDOmDelayControl  delay_control(RefVerAST _t);
	public:  RefCDOmEventControl  event_control(RefVerAST _t);
	public: RefCDOmEventExpr  list_of_event_expressions(RefVerAST _t);
	public: RefCDOmExprLink  expr_primary_identifier(RefVerAST _t);
	public: RefCDOmEventExpr  or_event_expression(RefVerAST _t);
	public: RefCDOmEventExpr  event_expression_primary(RefVerAST _t);
	public: RefCDOmBase  procedural_timing_control(RefVerAST _t);
	public: void case_item(RefVerAST _t,
		RefCDOmListExpr& exprList, RefCDOmStmt& stmt
	);
	public: RefCDOmListExpr  expression_list(RefVerAST _t);
	public: RefString  system_function_name(RefVerAST _t);
	public: void specify_item(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void pulsestyle_or_showcancelled_declaration(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void path_declaration(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void system_timing_check(RefVerAST _t,
		 RefCDOmSpecifyBlock parent 
	);
	public: RefCDOmSpecifyTerminalList  list_of_path_terminals(RefVerAST _t);
	public: void simple_or_edge_sensitive_path_declaration(RefVerAST _t,
		RefCDOmSpecifyBlock parent, RefCDOmExpr modPathExpr, TBool isIfNone
	);
	public: void state_dependent_path_declaration(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: RefCDOmExprLink  specify_terminal_descriptor(RefVerAST _t);
	public: CDOmPathDecl::EPathDeclPolarityOp  polarity_operator(RefVerAST _t);
	public: RefCDOmMinTypMaxList  list_of_path_delay_expressions(RefVerAST _t);
	public: CDOmPathDecl::EPathDeclEdgeIdenfier  edge_identifier(RefVerAST _t);
	public: void setup_timing_check(RefVerAST _t,
		 RefCDOmSpecifyBlock parent 
	);
	public: void hold_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void setuphold_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void recovery_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void removal_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void recrem_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void skew_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void timeskew_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void fullskew_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void period_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void width_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: void nochange_timing_check(RefVerAST _t,
		RefCDOmSpecifyBlock parent
	);
	public: RefCDOmTimingCheckEvent  timing_check_event(RefVerAST _t);
	public: RefCDOmDelayedDataOrReference  delayed_data_or_reference(RefVerAST _t);
	public:  RefCDOmTimingCheckEvent  controlled_timing_check_event(RefVerAST _t);
	public: RefCDOmTimingCheckEventControl  timing_check_event_control(RefVerAST _t);
	public: RefCDOmTimingCheckEventControl  edge_control_specifier(RefVerAST _t);
	public:  CDOmTimingCheckEventControl::EEdgeDescriptor  edge_descriptor(RefVerAST _t);
	public: RefCDOmExprConcat  concatenation(RefVerAST _t);
	public: RefCDOmExprMultiConcat  multiple_concatenation(RefVerAST _t);
	public: RefCDOmFunctionCall  function_call(RefVerAST _t);
	public: RefCDOmFunctionCall  system_function_call(RefVerAST _t);
	public: RefCDOmExpr  expr_primary(RefVerAST _t);
	public: RefCDOmExpr  expr_primary_number(RefVerAST _t);
	public: RefCDOmString  str(RefVerAST _t);
	public: RefCDOmExpr  number(RefVerAST _t);
	public: RefCDOmNumber  sized_number(RefVerAST _t);
	public: void attribute_instance(RefVerAST _t,
		RefCDOmAttrList attrList
	);
public:
	ANTLR_USE_NAMESPACE(antlr)RefAST getAST()
	{
		return ANTLR_USE_NAMESPACE(antlr)RefAST(returnAST);
	}
	
protected:
	RefVerAST returnAST;
	RefVerAST _retTree;
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
};

#endif /*INC_VerilogTreeWalker_hpp_*/
