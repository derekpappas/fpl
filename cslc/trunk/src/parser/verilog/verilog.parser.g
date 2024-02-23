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
 *   Part of the Verilog parser
 *   Author: David Mishelashvili <dm@internet.ge>
 *   2005
 */

header "post_include_hpp"
    {
    #include "Def.hpp"
    #include "VerilogNumber.hpp"
    #include "VerilogToken.hpp"
    #include "VerAST.hpp"
    #include "ToolsParser.hpp"
    #include "../../support/CommonSupport.h"

    #define DEBUG_PARSER

    ANTLR_USING_NAMESPACE(std);
    ANTLR_USING_NAMESPACE(antlr);
    }

options
    {
    language = "Cpp";
    }

{
ANTLR_USING_NAMESPACE(antlr);

#include <iostream>
#include "../../support/Base.hpp"
#include "../../csl_xml_warn_error/CSLC_Errors.h"
#include "../../csl_xml_warn_error/we_logic.h"

bool verilogParserHasErrors = false;

}

class VerilogParser extends Parser;
options
  {
    k = 1;
    importVocab = Verilog;
    buildAST=true;
    ASTLabelType = "RefVerAST";
    defaultErrorHandler = false;
  }

tokens
  {
    MODULE_DEF;
    MODULE_PARAMETER_PORT_LIST;
    LIST_OF_PORT_DECLARATIONS;
    OUTPUT_VARIABLE_TYPE;
    RANGE;
    LIST_OF_VARIABLE_PORT_IDENTIFIERS;
    PORT_REFERENCE;
    PORT_REFERENCE_CONCAT;
    NAMED_PORT_EXPRESSION;
    PORT;
    PORT_EXPRESSION;
    ATTRIBUTE_INSTANCE;
    ATTR_SPEC;
    DIMENSION;
    VARIABLE_PORT_IDENTIFIER;
    DEFPARAM_ASSIGNMENT;
    PARAM_ASSIGNMENT;
    U_PLUS;
    U_MINUS;
    U_AND;
    U_NAND;
    U_OR;
    U_NOR;
    U_XOR;
    U_XNOR;
    EXPRESSION;
    EXPRESSION_LIST;
    CONCATENATION;
    MULTI_CONCATENATION;
    RANGE_EXPRESSION;
    EXPR_PRIMARY_IDENTIFIER;
    FUNCTION_CALL;
    SYSTEM_FUNCTION_CALL;
    HIERARCHICAL_IDENTIFIER;
    MINTYPMAX_EXPRESSION;
    LIST_OF_NET_IDENTIFIERS;
    LIST_OF_NET_DECL_ASSIGNMENTS;
    DELAY;
    DELAY_VALUE;
    VARIABLE_TYPE;
    NET_DECLARATION;
    LVALUE;
    ASSIGNMENT;
    BLOCKING_OR_NONBLOCKING_ASSIGNMENT;
    PAR_BLOCK;
    SEQ_BLOCK;
    DELAY_CONTROL;
    EVENT_CONTROL;
    EVENT_EXPRESSION_PRIMARY;
    OR_EVENT_EXPRESSION;
    CASE_STATEMENT;
    CASE_ITEM;
    LOOP_STATEMENT;
    EVENT_TRIGGER;
    SYSTEM_TASK_ENABLE;
    TASK_ENABLE;
    TASK_PORT_LIST;
    FUNCTION_PORT_LIST;
    GATE_INSTANTIATION;
    CMOS_SWITCH_INSTANCE;
    ENABLE_GATE_INSTANCE;
    MOS_SWITCH_INSTANCE;
    N_INPUT_GATE_INSTANCE;
    N_OUTPUT_GATE_INSTANCE;
    PASS_ENABLE_SWITCH_INSTANCE;
    PASS_SWITCH_INSTANCE;
    PULL_GATE_INSTANCE;
    MODULE_OR_UDP_INSTANTIATION;
    LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2;
    NAMED_PARAMETER_ASSIGNMENT;
    MODULE_INSTANCE;
    ORDERED_PORT_CONNECTION;
    NAMED_PORT_CONNECTION;
    GENERATE_ITEM_OR_NULL;
    GENVAR_CASE_ITEM;
    GENVAR_ASSIGNMENT;
    GENERATE_BLOCK;
    EDGE_SENSITIVE_PATH_DECLARATION;
    SIMPLE_PATH_DECLARATION;
    SPECIFY_TERMINAL_DESCRIPTOR;
    LIST_OF_PATH_DELAY_EXPRESSIONS;
    DELAYED_DATA_OR_REFERENCE;
    TIMING_CHECK_EVENT;
    CONTROLLED_TIMING_CHECK_EVENT;
    SIZED_NUMBER;
    STATEMENT_OR_NULL;
    POLARITY_OPERATOR;
    UDP_PORT_LIST;
    UDP_DECLARATION_PORT_LIST;
    UDP_TABLE_SEQ_ENTRY;
    UDP_TABLE_COMB_ENTRY;
    INPUT_LIST;
    PULSE_CONTROL_SPECPARAM;
    MY_TOKEN;
  }

  {
    enum TUdpType { UDP_UNKNOWN, UDP_COMB, UDP_SEQ };
  }




unexpected
: ( UNSIGNED_NUMBER    !
  | NZ_UNSIGNED_NUMBER !
  | REAL_NUMBER        !
  | REAL_NUMBER_EXP    !
//  | POUND            !
  | TICK               !
  | BACKTICK           !
  | AT                 !
  | COLON              !
  | COMMA              !
//  | DOT              !
//  | ASSIGN             !
  | MINUS              !
//  | LBRACK             !
  | RBRACK             !
  | LCRULY             !
  | RCRULY             !
  | LPAREN             !
  | RPAREN             !
  | POUND              !
  | QUESTION           !
//  | SEMI             !
  | PLUS               !
  | LNOT               !
  | NOT                !
  | AND                !
  | NAND               !
  | OR                 !
  | NOR                !
  | XOR                !
  | XNOR               !
  | STAR               !
  | POW                !
  | DIV                !
  | MOD                !
  | EQUAL              !
  | NOT_EQ             !
  | NOT_EQ_CASE        !
  | EQ_CASE            !
  | LAND               !
  | TAND               !
  | LOR                !
  | LT_                !
//  | LE                 !
  | GT                 !
  | GE                 !
  | SL                 !
  | SSL                !
  | SR                 !
  | SSR                !
  | TRIGGER            !
  | PPATH              !
  | FPATH              !
//  | PSTAR              !
  | STARP              !
  | PO_POS             !
  | PO_NEG             !
  | SUPERSTAR          !
  | K_BEGIN            !
  | K_END              !
  )
  {
    args.push_back(intToString(1));
    string errorMessage;
    errorMessage.append("unexpected token: ");
    errorMessage.append((LT(1))->getText());   
    args.push_back(errorMessage);
    addErr( NSWarningErr::CSE_CSP_STMT_CSE_CSP_STMT_PARSER_ERROR, args, (LT(1))->getLine());
    verilogParserHasErrors = true;
    consume();
  }
;




// A.1.3 Module and primitive source text
source_text 
: 
  (description)*
  EOF!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

description 
: attrs_opt
  ( module
  | udp_declaration
  | unexpected
  | K_ENDMODULE!
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

module 
{ TBool canDeclPort = FALSE; TInt nonemptyPorts; } 
: (
    module_keyword
    module_identifier
    (module_parameter_port_list)?
    (
      LPAREN!
      ( list_of_port_declarations
      | nonemptyPorts = list_of_ports
        { canDeclPort = nonemptyPorts > 0; }
      )
      RPAREN!
    )?
    SEMI! 
    (module_item[canDeclPort])*
    K_ENDMODULE!
  )
  { #module = #(#[MODULE_DEF, "MODULE_DEF"], #module); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

module_keyword 
: x1:K_MODULE// { cout << x1->getLine() << endl; }
| x2:K_MACROMODULE //{ cout << x2->getLine() << endl; }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.1.4 Module parameters and ports
module_parameter_port_list! { RefVerAST pdh; } 
: { #module_parameter_port_list = #(#[MODULE_PARAMETER_PORT_LIST, "MODULE_PARAMETER_PORT_LIST"]); }
  POUND!
  LPAREN!
  //parameter_declaration (COMMA! parameter_declaration)*
  pdh1:parameter_declaration_header
  { 
    pdh = #pdh1;
    #module_parameter_port_list->addChild(pdh);
  }
  pa1:param_assignment
  { if (pdh) pdh->addChild(#pa1); }
  ( COMMA!
      (
        pa2:param_assignment
        { if (pdh) pdh->addChild(#pa2); }
      | pdh2:parameter_declaration_header
        { 
          pdh = #pdh2;
          #module_parameter_port_list->addChild(pdh);
        }
        pa3:param_assignment
        { if (pdh) pdh->addChild(#pa3); }
      )
  )*
  RPAREN!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// this rule needs to create a 0/1 vector which tracks which ports are present in the 
// port list as well as return a count of how many ports there are 
// example:
// a,,c
// 3 ports
// 2 defined
// 101
// the bit vector tells you which ports are defined.
 
list_of_ports returns [TInt nonemptyPorts] { TBool empty; nonemptyPorts = 0; }
: empty = port 
  { if (!empty) nonemptyPorts++; }
  ( COMMA! 
    empty = port 
    { if (!empty) nonemptyPorts++; }
  )*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_port_declarations! 
  { 
    TBool var; 
    TBool canBeVar; 
    RefVerAST cdecl1; 
  } 
: { #list_of_port_declarations = #(#[LIST_OF_PORT_DECLARATIONS, "LIST_OF_PORT_DECLARATIONS"]); }
  atr:attrs_opt
  { #list_of_port_declarations->addChild(#atr); }
  canBeVar=pdecl1:port_declaration
  { cdecl1 = #pdecl1; #list_of_port_declarations->addChild(cdecl1); }
  ( COMMA!
    ( atr1:attrs_opt
      { #list_of_port_declarations->addChild(#atr1); }
      canBeVar=pdecl2:port_declaration
      { cdecl1 = #pdecl2; #list_of_port_declarations->addChild(cdecl1); }
    | var=vpi:variable_port_identifier
      //isVar or (inNotVar and wasNotAssigned) is valid
      // Error: Specified port declaration can not be variable
      { canBeVar || !var }?
      { if (cdecl1) cdecl1->addChild(#vpi); }
    )
  )*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

port returns [TBool empty] 
: { empty = FALSE; }
  ( ( port_expression
    | named_port_expression
    )
  | { empty = TRUE; }
  )
  { #port = #(#[PORT, "PORT"], #port); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

named_port_expression 
: DOT! 
  port_identifier 
  LPAREN! 
  (port_expression)? 
  RPAREN!
  { #named_port_expression = #(#[NAMED_PORT_EXPRESSION, "NAMED_PORT_EXPRESSION"], #named_port_expression); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

port_expression 
: ( port_reference
  | port_reference_concat
  )
  { #port_expression = #(#[PORT_EXPRESSION, "PORT_EXPRESSION"], #port_expression); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

port_reference_concat 
: ( LCRULY! 
    port_reference 
    (COMMA! port_reference)* 
    RCRULY!
  )
  { #port_reference_concat = #(#[PORT_REFERENCE_CONCAT, "PORT_REFERENCE_CONCAT"], #port_reference_concat); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

port_reference 
: port_identifier 
  ( LBRACK! 
    constant_range_expression 
    RBRACK!
  )?
  { #port_reference = #(#[PORT_REFERENCE, "PORT_REFERENCE"], #port_reference); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

port_declaration returns [TBool canBeVar]
: inout_declaration
  { canBeVar = FALSE; }
| input_declaration
  { canBeVar = FALSE; }
| canBeVar = output_declaration
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.1.5 Module items
module_item [TBool canDeclPort] 
  { TBool var, canBeVar; } 
: specify_block
| generated_instantiation
| attrs_opt
  ( local_parameter_declaration SEMI!
  | module_or_generate_item
  | parameter_declaration SEMI!
  | specparam_declaration
  | canBeVar = pdecl:port_declaration
    { canDeclPort }?
    ( COMMA! var = pid:variable_port_identifier!
      { canBeVar || !var }?
      { #pdecl->addChild(#pid); }
    )*
    SEMI!
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

module_or_generate_item 
: module_or_generate_item_declaration
| parameter_override
| continuous_assign
| gate_instantiation
| module_or_udp_instantiation
| initial_construct
| always_construct
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

module_or_generate_item_declaration 
: net_declaration
| reg_declaration
| integer_declaration
| real_declaration
| time_declaration
| realtime_declaration
| event_declaration
| genvar_declaration
| task_declaration
| function_declaration
;

parameter_override 
: K_DEFPARAM^ 
  list_of_defparam_assignments 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}


// A.2 Declarations
// A.2.1 Declaration types
// A.2.1.1 Module parameter declarations
local_parameter_declaration 
: ( K_LOCALPARAM^
    ( (K_SIGNED)? 
      (range)?
    | parameter_type
    )
    list_of_param_assignments
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

parameter_declaration_header 
: K_PARAMETER^
  ( (K_SIGNED)? 
    (range)?
  | parameter_type
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

parameter_declaration! 
: pdh:parameter_declaration_header
  lopa:list_of_param_assignments
  { #parameter_declaration = #pdh; #parameter_declaration->addChild(#lopa); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

specparam_declaration 
: K_SPECPARAM^ 
  (range)? 
  list_of_specparam_assignments 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

parameter_type 
: ( K_INTEGER
  | K_REAL
  | K_REALTIME
  | K_TIME
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.1.2 Port declarations
inout_declaration 
: K_INOUT^ 
  (net_type)? 
  (K_SIGNED)? 
  (range)?
  port_identifier
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

input_declaration 
: K_INPUT^ 
  (net_type)? 
  (K_SIGNED)? 
  (range)?
  port_identifier
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

output_declaration returns [TBool canBeVar] 
  { TBool var; } 
: K_OUTPUT^
  ( (net_type)? 
    (K_SIGNED)? 
    (range)? 
    port_identifier
    { canBeVar = FALSE; }
  | K_REG (K_SIGNED)? (range)? var = variable_port_identifier
    { canBeVar = TRUE; }
  | output_variable_type var = variable_port_identifier
    { canBeVar = TRUE; }
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.1.3 Type declaration
integer_declaration 
: K_INTEGER^ 
  list_of_variable_identifiers 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

net_declaration 
  { TBool decl, ds, exprng, rng; } 
: ( net_type
    { decl = ds = exprng = rng = FALSE; }
    (LPAREN! drive_strength RPAREN! { ds = TRUE; })?
    (expandrange { exprng = TRUE; })?
    (K_SIGNED)?
    (range { rng = TRUE; })?
    // Error: scalared|vectored used without range specifier 
    { rng || !exprng }?
    (delay3)?
    list_of_net_identifiers_or_decl_assignments[decl]
    // Error: drive_strength used without net decl assignments
    { !ds || decl }?
    SEMI!
    { #net_declaration = #(#[NET_DECLARATION, "NET_DECLARATION"], #net_declaration); }
  )
| ( K_TRIREG
    { decl = ds = exprng = rng = FALSE; }
    ( LPAREN!
      (charge_strength
      | (drive_strength { ds = TRUE; })
      )
      RPAREN!
    )?
    (expandrange { exprng = TRUE; })?
    (K_SIGNED)?
    (range { rng = TRUE; })?
    // Error: scalared|vectored used without range specifier
    { rng || !exprng }?
    (delay3)?
    list_of_net_identifiers_or_decl_assignments[decl]
    // Error: drive_strength used without net decl assignments
    { !ds || decl }?
    SEMI!
    { #net_declaration = #(#[NET_DECLARATION, "NET_DECLARATION"], #net_declaration); }
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

expandrange 
: (K_VECTORED | K_SCALARED)
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

real_declaration 
: K_REAL^ 
  list_of_variable_identifiers 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

realtime_declaration 
: K_REALTIME^ 
  list_of_variable_identifiers 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

time_declaration 
: K_TIME^ 
  list_of_variable_identifiers 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

reg_declaration 
: K_REG^ 
  (K_SIGNED)? 
  (range)? 
  list_of_variable_identifiers 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

event_declaration 
: K_EVENT^ 
  list_of_event_identifiers 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

genvar_declaration 
: K_GENVAR^ 
  list_of_genvar_identifiers 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.2 Declaration data types
// A.2.2.1 Net and variable types
net_type 
: ( K_SUPPLY0
  | K_SUPPLY1
  | K_TRI
  | K_TRIAND
  | K_TRIOR
  | K_TRI0
  | K_TRI1
  | K_WIRE
  | K_WAND
  | K_WOR
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

output_variable_type 
: ( K_INTEGER
  | K_TIME
  )
  //{ #output_variable_type = #(#[OUTPUT_VARIABLE_TYPE, "OUTPUT_VARIABLE_TYPE"], #output_variable_type); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

variable_type 
: variable_identifier
  ( (dimension)*
  | ASSIGN! 
    constant_expression
  )
  { #variable_type = #(#[VARIABLE_TYPE, "VARIABLE_TYPE"], #variable_type); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.2.2 Strengths
drive_strength 
: ( strength0 COMMA! (strength1 | highz1)
  | strength1 COMMA! (strength0 | highz0)
  | highz0 COMMA! strength1
  | highz1 COMMA! strength0
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

strength0 
: (K_SUPPLY0 | K_STRONG0 | K_PULL0 | K_WEAK0)
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

strength1 
: (K_SUPPLY1 | K_STRONG1 | K_PULL1 | K_WEAK1)
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

highz0 
: K_HIGHZ0
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

highz1 
: K_HIGHZ1
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

charge_strength 
: (K_SMALL | K_MEDIUM | K_LARGE)
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.2.3 Delays
delay3 
: POUND!
  ( delay_value
  | LPAREN!
    mintypmax_expression
    (COMMA! mintypmax_expression (COMMA! mintypmax_expression)? )?
    RPAREN!
  )
  { #delay3 = #(#[DELAY, "DELAY"], #delay3); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

delay2 
: POUND!
  ( delay_value
  | LPAREN!
    mintypmax_expression
    (COMMA! mintypmax_expression)?
    RPAREN!
  )
  { #delay2 = #(#[DELAY, "DELAY"], #delay2); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

delay_value 
: ( unsigned_number
  | real_number
  | identifier
  )
  { #delay_value = #(#[DELAY_VALUE, "DELAY_VALUE"], #delay_value); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.3 Declaration lists
list_of_net_identifiers_or_decl_assignments [TBool& decl] 
: net_identifier
  ( (dimension)* (COMMA! net_identifier (dimension)*)*
    { #list_of_net_identifiers_or_decl_assignments =
        #(#[LIST_OF_NET_IDENTIFIERS, "LIST_OF_NET_IDENTIFIERS"],
            #list_of_net_identifiers_or_decl_assignments);
      decl = FALSE;
    }
  | ASSIGN! expression (COMMA! net_identifier ASSIGN! expression)*
    { 
      #list_of_net_identifiers_or_decl_assignments =
        #(#[LIST_OF_NET_DECL_ASSIGNMENTS, "LIST_OF_NET_DECL_ASSIGNMENTS"],
            #list_of_net_identifiers_or_decl_assignments);
      decl = TRUE;
    }
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_event_identifiers 
: event_identifier 
  (dimension)*
  (COMMA! event_identifier (dimension)*)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_genvar_identifiers 
: genvar_identifier
  (COMMA! genvar_identifier)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_defparam_assignments 
: defparam_assignment
  (COMMA! defparam_assignment)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_param_assignments 
: param_assignment
  (COMMA! param_assignment)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_specparam_assignments 
: specparam_assignment
  (COMMA! specparam_assignment)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_variable_identifiers 
: variable_type 
  (COMMA! variable_type)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_variable_port_identifiers 
  { TBool dummy; } 
: dummy = variable_port_identifier
  (COMMA! dummy = variable_port_identifier)*
  { 
    #list_of_variable_port_identifiers = 
        #(#[LIST_OF_VARIABLE_PORT_IDENTIFIERS, "LIST_OF_VARIABLE_PORT_IDENTIFIERS"], #list_of_variable_port_identifiers); 
  }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

variable_port_identifier returns [TBool variable] 
: { variable = FALSE; }
  port_identifier
  ( ASSIGN! 
    constant_expression
    { 
      #variable_port_identifier = #(#[VARIABLE_PORT_IDENTIFIER, "VARIABLE_PORT_IDENTIFIER"], #variable_port_identifier);
      variable = TRUE; 
    }
  )?
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.4 Declaration assignments
defparam_assignment 
: hierarchical_parameter_identifier
  ASSIGN!
  constant_mintypmax_expression
  { #defparam_assignment = #(#[DEFPARAM_ASSIGNMENT, "DEFPARAM_ASSIGNMENT"], #defparam_assignment); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

param_assignment 
: parameter_identifier
  ASSIGN!
  constant_mintypmax_expression
  { #param_assignment = #(#[PARAM_ASSIGNMENT, "PARAM_ASSIGNMENT"], #param_assignment); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

specparam_assignment 
: param_assignment
| pulse_control_specparam
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

pulse_control_specparam 
  { CVerStringTokenizerDollar *x; }
: { #pulse_control_specparam = #( #[PULSE_CONTROL_SPECPARAM, "PULSE_CONTROL_SPECPARAM"], #pulse_control_specparam); }
  pp:PATHPULSE!
  { x = new CVerStringTokenizerDollar( string( #pp->getText() ) ); }
  { x->getCount() < 4 && x->getCount() > 0 }?
  ( { x->getCount() > 1 && (*x)[1].length() > 0 }?
    {
      #pulse_control_specparam->addChild( RefVerAST( #[IDENTIFIER, x->getCharStr(1)] ) );
      if( x->getCount() > 2 ){
        #pulse_control_specparam->addChild( RefVerAST( #[IDENTIFIER, x->getCharStr(2)] ) );
      }
    }
    ( LBRACK! 
      cre1:constant_range_expression!
      { #pulse_control_specparam->addChild( #cre1 ); }
      RBRACK!
    )?
    ( { x->getCount() == 2 }?
      stn:SYSTEM_TASK_NAME!
      //add child id from stn with no $
      {
        CVerStringTokenizerDollar temp( string(#stn->getText()) );
        #pulse_control_specparam->addChild( RefVerAST( #[IDENTIFIER, temp.getCharStr(1)] ) );
      }
      ( LBRACK! 
        cre2:constant_range_expression!
        { #pulse_control_specparam->addChild( #cre2 ); }
        RBRACK!
      )?
    )?
  )?
  assn:ASSIGN!
  { #pulse_control_specparam->addChild( #assn ); }
  // ASSIGN is not removed from AST to avoid ambiguity in walker
  LPAREN!
  cme1:constant_mintypmax_expression!
  { #pulse_control_specparam->addChild( #cme1 ); }
  ( COMMA!
    cme2:constant_mintypmax_expression!
    { #pulse_control_specparam->addChild( #cme2 ); }
  )?
  RPAREN!
    //!!! Possible bug in verilog grammar spec
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.5 Declaration ranges
dimension 
: LBRACK!
  dimension_constant_expression
  COLON!
  dimension_constant_expression
  RBRACK!
  { #dimension = #(#[DIMENSION, "DIMENSION"], #dimension); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

range 
: LBRACK!
  lsb_constant_expression
  COLON!
  msb_constant_expression
  RBRACK!
  { #range = #(#[RANGE, "RANGE"], #range); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.6 Function declaration
function_declaration 
  { bool acceptNext = true; } //shows
: K_FUNCTION^ 
  (K_AUTOMATIC)?  
  (K_SIGNED)? 
  (range_or_type)?
  function_identifier
  ( SEMI!
    attrs_opt 
    function_item_declaration
    ( attrs_opt 
      { acceptNext }?
      ( function_item_declaration
      | function_statement {acceptNext = false;}
      )
    )*
  | LPAREN! 
    function_port_list 
    RPAREN!
    SEMI!
    ( attrs_opt 
      { acceptNext }?
      ( block_item_declaration
      | function_statement 
        {acceptNext = false;}
      )
    )*
    {!acceptNext}? //function statement is obligatory
    //this semantic check tests if function_statement rule was accesed
  )
  K_ENDFUNCTION!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

function_item_declaration 
: block_item_declaration
| tfid:tf_input_declaration
  ( COMMA! 
    pid:port_identifier!
    { RefVerAST(#tfid)->addChild(#pid); }
  )* 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

function_port_list! 
  { RefVerAST tfid; } 
: { #function_port_list = #[FUNCTION_PORT_LIST, "FUNCTION_PORT_LIST"]; }
  attrs_opt
  tfid1:tf_input_declaration
  { tfid = #tfid1; #function_port_list->addChild(tfid); }
  ( COMMA!
    ( attrs_opt 
      tfid2:tf_input_declaration
       { tfid = #tfid2; #function_port_list->addChild(tfid); }
     | pid:port_identifier
       { if (tfid) RefVerAST(tfid)->addChild(#pid); }
     )
  )*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

range_or_type 
: range
| K_INTEGER
| K_REAL
| K_REALTIME
| K_TIME
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.7 Task declaration
task_declaration 
{ bool acceptNext = true; }
: K_TASK^ 
  (K_AUTOMATIC)? 
  task_identifier
  ( SEMI!
    ( attrs_opt
      { acceptNext }? //if statement_or_null rule was invoked nothing should follow
      ( task_item_declaration
      | statement_or_null {acceptNext = false;}
      )
    )*
  | LPAREN! (task_port_list)? RPAREN!
    SEMI!
    ( attrs_opt 
      {acceptNext}? //if statement_or_null rule was invoked nothing should follow
      ( block_item_declaration
      | statement_or_null { acceptNext = false; }
      )
    )*
  )
  {!acceptNext}?//checks if the statement_or_null was invoked
  //it is obligatory for this rule to be invoked at least once
  K_ENDTASK!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

task_item_declaration 
: block_item_declaration
| tfid:tf_input_declaration
  ( COMMA! 
    pid1:port_identifier!
    { RefVerAST(#tfid)->addChild(#pid1); }
  )* 
  SEMI!
| tfod:tf_output_declaration
  ( COMMA! 
    pid2:port_identifier!
    { RefVerAST(#tfod)->addChild(#pid2); }
  )* 
  SEMI!
| tfiod:tf_inout_declaration
  ( COMMA! 
    pid3:port_identifier!  
    { RefVerAST(#tfiod)->addChild(#pid3); }
  )* 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

task_port_list! 
  { RefVerAST tpi; }
: { #task_port_list = #[TASK_PORT_LIST, "TASK_PORT_LIST"]; }
  tpi1:task_port_item 
  { tpi = #tpi1; #task_port_list->addChild(tpi); }
  ( COMMA!
    ( tpi2:task_port_item 
      { tpi = #tpi2; #task_port_list->addChild(tpi); }
    | pid:port_identifier
      { if (tpi) RefVerAST(tpi)->addChild(#pid); }
    )
  )*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

task_port_item 
: attrs_opt
  ( tf_input_declaration
  | tf_output_declaration
  | tf_inout_declaration
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

tf_input_declaration 
: K_INPUT^
  ( (K_REG)? 
    (K_SIGNED)? 
    (range)?
  | task_port_type
  )
  port_identifier
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

tf_output_declaration 
: K_OUTPUT^
  ( (K_REG)? 
    (K_SIGNED)? 
    (range)?
  | task_port_type
  )
  port_identifier
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

tf_inout_declaration 
: K_INOUT^
  ( (K_REG)? 
    (K_SIGNED)? 
    (range)?
  | task_port_type
  )
  port_identifier
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

task_port_type 
: K_INTEGER
| K_REAL
| K_REALTIME
| K_TIME
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.2.8 Block item declarations
block_item_declaration 
: reg_declaration
| integer_declaration
| time_declaration
| real_declaration
| realtime_declaration
| event_declaration
| local_parameter_declaration SEMI!
| parameter_declaration SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.3 Primitive instances
// A.3.1 Primitive instantiation and instances
gate_instantiation 
: ( cmos_switchtype 
    (delay3)?
    cmos_switch_instance 
    (COMMA! cmos_switch_instance)*
  | enable_gatetype
    ( (LPAREN drive_strength) => LPAREN! drive_strength RPAREN! | )
    (delay3)?
    enable_gate_instance (COMMA! enable_gate_instance)*
  | mos_switchtype (delay3)?
    mos_switch_instance (COMMA! mos_switch_instance)*
  | n_input_gatetype
    ((LPAREN drive_strength)=>LPAREN! drive_strength RPAREN! |)
    (delay2)?
    n_input_gate_instance (COMMA! n_input_gate_instance)*
  | n_output_gatetype
    ((LPAREN drive_strength)=>LPAREN! drive_strength RPAREN! |)
    (delay2)?
    n_output_gate_instance (COMMA! n_output_gate_instance)*
  | pass_enable_switchtype (delay2)?
    pass_enable_switch_instance (COMMA! pass_enable_switch_instance)*
  | pass_switchtype
    pass_switch_instance (COMMA! pass_switch_instance)*
  | K_PULLDOWN
    ((LPAREN pulldown_strength)=>LPAREN! pulldown_strength RPAREN! |)
    pull_gate_instance (COMMA! pull_gate_instance)*
  | K_PULLUP
    ((LPAREN pullup_strength)=>LPAREN! pullup_strength RPAREN! |)
    pull_gate_instance (COMMA! pull_gate_instance)*
  )
  SEMI!
  { #gate_instantiation = #(#[GATE_INSTANTIATION, "GATE_INSTANTIATION"], #gate_instantiation); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

cmos_switch_instance 
: (name_of_gate_instance)?
  LPAREN!
  output_terminal 
  COMMA! 
  input_terminal 
  COMMA!
  ncontrol_terminal 
  COMMA! 
  pcontrol_terminal
  RPAREN!
  { #cmos_switch_instance = #(#[CMOS_SWITCH_INSTANCE, "CMOS_SWITCH_INSTANCE"], #cmos_switch_instance); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

enable_gate_instance 
: (name_of_gate_instance)?
  LPAREN!
  output_terminal 
  COMMA! 
  input_terminal 
  COMMA! 
  enable_terminal
  RPAREN!
  { #enable_gate_instance = #(#[ENABLE_GATE_INSTANCE, "ENABLE_GATE_INSTANCE"], #enable_gate_instance); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

mos_switch_instance 
: (name_of_gate_instance)?
  LPAREN!
  output_terminal 
  COMMA! 
  input_terminal 
  COMMA! 
  enable_terminal
  RPAREN!
  { #mos_switch_instance = #(#[MOS_SWITCH_INSTANCE, "MOS_SWITCH_INSTANCE"], #mos_switch_instance); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

n_input_gate_instance 
: (name_of_gate_instance)?
  LPAREN!
  output_terminal 
  COMMA! 
  input_terminal 
  (COMMA! input_terminal)*
  RPAREN!
  { #n_input_gate_instance = #(#[N_INPUT_GATE_INSTANCE, "N_INPUT_GATE_INSTANCE"], #n_input_gate_instance); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

n_output_gate_instance 
: (name_of_gate_instance)?
  LPAREN! // input terminal must be the only and the last
  output_terminal
  (COMMA! input_terminal)+ // only last terminal is input others are output
                           // but we use all input (more general)
  RPAREN!                  // to avoid ambiguity
  { #n_output_gate_instance = #(#[N_OUTPUT_GATE_INSTANCE, "N_OUTPUT_GATE_INSTANCE"], #n_output_gate_instance); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

pass_enable_switch_instance 
: (name_of_gate_instance)?
  LPAREN!
  inout_terminal 
  COMMA! 
  inout_terminal 
  COMMA! 
  enable_terminal
  RPAREN!
  { #pass_enable_switch_instance = #(#[PASS_ENABLE_SWITCH_INSTANCE, "PASS_ENABLE_SWITCH_INSTANCE"], #pass_enable_switch_instance); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

pass_switch_instance 
: (name_of_gate_instance)?
  LPAREN!
  inout_terminal 
  COMMA! 
  inout_terminal
  RPAREN!
  { #pass_switch_instance = #(#[PASS_SWITCH_INSTANCE, "PASS_SWITCH_INSTANCE"], #pass_switch_instance); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

pull_gate_instance 
: (name_of_gate_instance)?
  LPAREN!
  output_terminal
  RPAREN!
  { #pull_gate_instance = #(#[PULL_GATE_INSTANCE, "PULL_GATE_INSTANCE"], #pull_gate_instance); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

name_of_gate_instance 
: gate_instance_identifier 
  (range)?
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.3.2 Primitive strengths
pulldown_strength 
: ( strength0 (COMMA! strength1)?
  | strength1 COMMA! strength0
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

pullup_strength 
: ( strength0 COMMA! strength1
  | strength1 (COMMA! strength0)?
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.3.3 Primitive terminals
enable_terminal 
: expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

inout_terminal 
: net_lvalue 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

input_terminal 
: expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

ncontrol_terminal 
: expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

output_terminal 
: net_lvalue 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

pcontrol_terminal 
: expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.3.4 Primitive gate and switch types
cmos_switchtype 
: K_CMOS | K_RCMOS 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

enable_gatetype 
: K_BUFIF0 | K_BUFIF1 | K_NOTIF0 | K_NOTIF1 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

mos_switchtype 
: K_NMOS | K_PMOS | K_RNMOS | K_RPMOS 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

n_input_gatetype 
: K_AND | K_NAND | K_OR | K_NOR | K_XOR | K_XNOR 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

n_output_gatetype 
: K_BUF | K_NOT 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

pass_enable_switchtype 
: K_TRANIF0 | K_TRANIF1 | K_RTRANIF1 | K_RTRANIF0 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

pass_switchtype 
: K_TRAN | K_RTRAN 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.4 Module and generated instantiation
// A.4.1 Module instantiation
module_or_udp_instantiation 
: module_identifier
  ((LPAREN drive_strength)=>(LPAREN! drive_strength RPAREN!))? // added for UDP
  (parameter_value_assignment_or_delay2)?
  //(delay2)? // added for UDP
  // note that "parameter_value_assignment" contains "delay2" syntax in it
  // to remove ambiguity we process "parameter_value_assignment" later to
  // check if it is a "delay2"
  module_instance
  (COMMA! module_instance)*
  SEMI!
  { #module_or_udp_instantiation = #(#[MODULE_OR_UDP_INSTANTIATION, "MODULE_OR_UDP_INSTANTIATION"], #module_or_udp_instantiation); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

parameter_value_assignment_or_delay2 
: POUND!
  ( LPAREN! 
    list_of_parameter_assignments_or_delay2 
    RPAREN!
//  | delay_value
//    { #parameter_value_assignment_or_delay2 = #(#[DELAY, "DELAY"], #parameter_value_assignment_or_delay2); }
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_parameter_assignments_or_delay2 
: ( ordered_parameter_assignment
    (COMMA! ordered_parameter_assignment)*
  | named_parameter_assignment
    (COMMA! named_parameter_assignment)*
  )
  { 
    #list_of_parameter_assignments_or_delay2 = 
        #(#[LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2, "LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2"], list_of_parameter_assignments_or_delay2);
  }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

ordered_parameter_assignment 
: //expression
  // extended to meet "delay2" syntax in udp/module instantiation
  mintypmax_expression
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

named_parameter_assignment 
: DOT! parameter_identifier
  LPAREN! (mintypmax_expression)? RPAREN!
  { #named_parameter_assignment = #(#[NAMED_PARAMETER_ASSIGNMENT, "NAMED_PARAMETER_ASSIGNMENT"], #named_parameter_assignment); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

module_instance 
  //This is optional for udp instantiation
: ( name_of_module_instance )?
  LPAREN! list_of_port_connections RPAREN!
  { #module_instance = #(#[MODULE_INSTANCE, "MODULE_INSTANCE"], #module_instance); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

name_of_module_instance 
: module_instance_identifier 
  (range)?
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_port_connections 
: attrs_opt
  ( ordered_port_connection
    (COMMA! attrs_opt ordered_port_connection)*
  | named_port_connection
    (COMMA! attrs_opt named_port_connection)*
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

ordered_port_connection 
: (
  | expression
  )
  { #ordered_port_connection = #(#[ORDERED_PORT_CONNECTION, "ORDERED_PORT_CONNECTION"], #ordered_port_connection); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

named_port_connection 
: DOT! 
  port_identifier 
  LPAREN! 
  (expression)? 
  RPAREN!
  { #named_port_connection = #(#[NAMED_PORT_CONNECTION, "NAMED_PORT_CONNECTION"], #named_port_connection); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.4.2 Generated instantiation
generated_instantiation 
: K_GENERATE^
  (generate_item)*
  K_ENDGENERATE!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

generate_item_or_null 
: ( generate_item
  | SEMI!
  )
  { #generate_item_or_null = #(#[GENERATE_ITEM_OR_NULL, "GENERATE_ITEM_OR_NULL"], #generate_item_or_null); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

generate_item 
: generate_conditional_statement
| generate_case_statement
| generate_loop_statement
| generate_block
| attrs_opt module_or_generate_item
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

generate_conditional_statement 
: K_IF^ 
  LPAREN! 
  constant_expression 
  RPAREN!
  generate_item_or_null
  ( options { warnWhenFollowAmbig = false; } :
    K_ELSE! generate_item_or_null
  )?
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

generate_case_statement 
: K_CASE^ 
  LPAREN! 
  constant_expression 
  RPAREN!
  (genvar_case_item)+
  K_ENDCASE!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

genvar_case_item 
: ( constant_expression 
    (COMMA! constant_expression)*
    COLON!
  | K_DEFAULT 
    (COLON!)? 
  )
  generate_item_or_null
  { #genvar_case_item = #(#[GENVAR_CASE_ITEM, "GENVAR_CASE_ITEM"], #genvar_case_item); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

generate_loop_statement 
: K_FOR^
  LPAREN!
  genvar_assignment SEMI!
  constant_expression SEMI!
  genvar_assignment
  RPAREN!
  K_BEGIN! 
  COLON! 
  generate_block_identifier
  (generate_item)*
  K_END!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

genvar_assignment 
: genvar_identifier 
  ASSIGN! 
  constant_expression
  { #genvar_assignment = #(#[GENVAR_ASSIGNMENT, "GENVAR_ASSIGNMENT"], #genvar_assignment); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

generate_block 
: K_BEGIN!
  (COLON! generate_block_identifier)?
  (generate_item)*
  K_END!
  { #generate_block = #(#[GENERATE_BLOCK, "GENERATE_BLOCK"], #generate_block); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.5 UDP declaration and instantiation
// A.5.1 UDP declaration
udp_declaration
  { TBool canDeclPort = TRUE; }
: K_PRIMITIVE^ 
  udp_identifier
  LPAREN!
  ( udp_port_list
  | udp_declaration_port_list { canDeclPort = FALSE; }
  )
  RPAREN! 
  SEMI!
  ( udp_port_declaration
      // Port declaration is not allowed at this point
    { canDeclPort }?
  )*
  udp_body
  K_ENDPRIMITIVE!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.5.2 UDP ports
udp_port_list 
: port_identifier 
  (COMMA! port_identifier)+
  { #udp_port_list = #(#[UDP_PORT_LIST, "UDP_PORT_LIST"], #udp_port_list); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

udp_declaration_port_list!
  { RefVerAST idh; }
: { #udp_declaration_port_list = #(#[UDP_DECLARATION_PORT_LIST, "UDP_DECLARATION_PORT_LIST"]); }
  atr:attrs_opt
  { #udp_declaration_port_list->addChild(#atr); }
  uod:udp_output_declaration
  { #udp_declaration_port_list->addChild(#uod); }
  //COMMA!
  //atr2:attrs_opt
  //{ #udp_declaration_port_list->addChild(#atr2); }
  //idh1:udp_input_declaration_header
  //{
  //  idh = #idh1;
  //  #udp_declaration_port_list->addChild(idh);
  //}
  ( //COMMA! udp_input_declaration
    //rule explanded manually due to ambiguity
    COMMA!
    ( atr1:attrs_opt 
      { #udp_declaration_port_list->addChild(#atr1); }
      idh2:udp_input_declaration_header
      {
        idh = #idh2;
        #udp_declaration_port_list->addChild(idh);
      }
    | pid:port_identifier { idh->addChild(#pid); }
    )
  )+
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

udp_port_declaration 
: attrs_opt
  ( udp_output_declaration SEMI!
  | udp_input_declaration SEMI!
  | udp_reg_declaration SEMI!
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

udp_output_declaration 
: K_OUTPUT^
( port_identifier
| K_REG port_identifier 
  (ASSIGN! constant_expression)?
)
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

udp_input_declaration_header 
: K_INPUT^ 
  port_identifier
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

udp_input_declaration 
: K_INPUT^ 
  port_identifier 
  (COMMA! port_identifier)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

udp_reg_declaration 
: K_REG^ 
  variable_identifier
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.5.3 UDP body

udp_body 
  { TUdpType udpType = UDP_UNKNOWN; }
: ( udp_initial_statement 
    { udpType = UDP_SEQ; }
  )?
  K_TABLE^
  ( udp_table_entry[udpType] )+
  K_ENDTABLE!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

udp_initial_statement 
: K_INITIAL^ 
  port_identifier 
  ASSIGN! 
  init_val 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

init_val 
  { TBool valid = FALSE; } 
: n:number // Advanced check to make sure that number is:
           // 1'b0 | 1'b1 | 1'bx | 1'bX | 1'B0 | 1'B1 | 1'Bx | 1'BX | 1 | 0
  {
    string s = #n->getText();
    if ( equal(s, "1'b0") 
       || equal(s, "1'b1") 
       || equal(s, "1'bx") 
       || equal(s, "1'B0") 
       || equal(s, "1'B1") 
       || equal(s, "1'Bx") 
       || equal(s, "1") 
       || equal(s, "0")
       )
      valid = TRUE;
  }
  // UDP initialization value is invalid 
  { valid }?
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

udp_table_entry [TUdpType& udpType]
  { TBool hasEdge; TBool hasLevel; }
: ( input_list[hasEdge, hasLevel] COLON current_state COLON ) => input_list[hasEdge, hasLevel] 
  COLON! 
  current_state 
  COLON! 
  next_state 
  SEMI!
  { if (udpType == UDP_UNKNOWN) udpType = UDP_SEQ; }
  // Sequential entry in combinational UDP is not allowed 
  { udpType == UDP_SEQ }?
  { #udp_table_entry = #(#[UDP_TABLE_SEQ_ENTRY, "UDP_TABLE_SEQ_ENTRY"], #udp_table_entry); }
| input_list[hasEdge, hasLevel] 
  COLON! 
  output_symbol 
  SEMI!
  { if (udpType == UDP_UNKNOWN) udpType = UDP_COMB; }
  // Combinational entry in sequential UDP is not allowed 
  { udpType == UDP_COMB }?
  // Edge indicator is not allowed in combinational UDP 
  { !hasEdge }?
  // Level symbol is required in combinational UDP 
  { hasLevel }?
  { #udp_table_entry = #(#[UDP_TABLE_COMB_ENTRY, "UDP_TABLE_COMB_ENTRY"], #udp_table_entry); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

input_list [TBool& hasEdge, TBool& hasLevel]
  {
    hasEdge = FALSE;
    hasLevel = FALSE;
  }
: ( level_symbol
    { 
      if( !hasLevel )
        hasLevel = TRUE; 
    }
  | edge_indicator
    // Only one edge indicator per entry is allowed 
    { !hasEdge }?
    { hasEdge = TRUE; }
  )+
  { #input_list = #(#[INPUT_LIST, "INPUT_LIST"], #input_list); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

current_state 
: level_symbol
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

level_symbol 
: UDP_0 | UDP_1 | UDP_X | QUESTION | UDP_B
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

edge_indicator
: LPAREN
  level_symbol
  level_symbol
  RPAREN!
| edge_symbol
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

edge_symbol 
: UDP_F | UDP_R
| UDP_N  | UDP_P  | STAR
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}
//edge_indicator 
//: UDP_Q0 | UDP_Q1 | UDP_QX | UDP_QQ | UDP_01 | UDP_0X | UDP_0Q | UDP_10
//| UDP_1X | UDP_1Q | UDP_BX | UDP_X0 | UDP_X1 | UDP_XQ | UDP_F | UDP_R
//| UDP_N  | UDP_P  | STAR
//;

next_state 
: output_symbol | MINUS
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

output_symbol 
: UDP_0 | UDP_1 | UDP_X
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.6 Behavioral statements
// A.6.1 Continuous assignment statements
continuous_assign 
: K_ASSIGN^ 
  (LPAREN! drive_strength RPAREN!)? 
  (delay3)?
  list_of_net_assignments 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_net_assignments 
: net_assignment 
  (COMMA! net_assignment)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

assignment 
: lvalue 
  ASSIGN! 
  expression
  { #assignment = #(#[ASSIGNMENT, "ASSIGNMENT"], #assignment); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

net_assignment 
: assignment
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}


// A.6.2 Procedural blocks and assignments
initial_construct 
: K_INITIAL^ attrs_opt statement
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

always_construct 
: K_ALWAYS^ attrs_opt statement
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

blocking_or_nonblocking_assignment 
: variable_lvalue
  //(unexpected)?
  (ASSIGN | LE | unexpected)
  (delay_or_event_control)?
  expression
  { 
    #blocking_or_nonblocking_assignment = 
    #(#[BLOCKING_OR_NONBLOCKING_ASSIGNMENT, "BLOCKING_OR_NONBLOCKING_ASSIGNMENT"], #blocking_or_nonblocking_assignment); 
  }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

procedural_continuous_assignments 
: (K_ASSIGN^ variable_assignment)
| (K_DEASSIGN^ variable_lvalue)
| (K_FORCE^ variable_or_net_assignment)
| (K_RELEASE^ net_or_variable_lvalue)
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

variable_assignment 
: assignment 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

variable_or_net_assignment 
: assignment
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.6.3 Parallel and sequential blocks
par_block 
  { bool acceptBlockItemDecl = false; }
: K_FORK!
  (COLON! block_identifier { acceptBlockItemDecl = true; } )?
  ( attrs_opt 
    ( block_item_declaration 
      { acceptBlockItemDecl }? 
    | statement { acceptBlockItemDecl = false; }
    )
  )*
  K_JOIN!
  { #par_block = #(#[PAR_BLOCK, "PAR_BLOCK"], #par_block); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

seq_block 
  { bool acceptBlockItemDecl = false;}
: K_BEGIN!
    ( COLON! block_identifier { acceptBlockItemDecl = true; } )?
    ( attrs_opt 
      ( block_item_declaration
        { acceptBlockItemDecl }?
      | statement { acceptBlockItemDecl = false; }
      )
    )*
    K_END!
  { #seq_block = #(#[SEQ_BLOCK, "SEQ_BLOCK"], #seq_block); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.6.4 Statements
statement 
: (variable_lvalue (ASSIGN | LE)) => blocking_or_nonblocking_assignment SEMI!
| case_statement
| conditional_statement
| disable_statement
| event_trigger
| loop_statement
| par_block
| procedural_continuous_assignments SEMI!
| procedural_timing_control_statement
| seq_block
| system_task_enable
| task_enable
| wait_statement
| SEMI !
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

statement_or_null 
: ( 
  //(attrs_opt)? 
  statement
  //  | SEMI!
  )
  { #statement_or_null = #(#[STATEMENT_OR_NULL, "STATEMENT_OR_NULL"], #statement_or_null); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

function_statement 
: statement
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.6.5 Timing control statements
delay_control 
: POUND!
  ( delay_value
  | LPAREN! mintypmax_expression RPAREN!
  )
  { #delay_control = #(#[DELAY_CONTROL, "DELAY_CONTROL"], #delay_control); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}
    
delay_or_event_control 
: delay_control
| event_control
| K_REPEAT^ 
  LPAREN! 
  expression 
  RPAREN! 
  event_control
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

disable_statement 
: K_DISABLE^ 
  hierarchical_identifier 
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

event_control 
: AT!
  ( hierarchical_identifier
  | LPAREN! event_expression RPAREN!
  | STAR 
  | SUPERSTAR
  )
  { #event_control = #(#[EVENT_CONTROL, "EVENT_CONTROL"], #event_control); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

//According to Verilog 2001 formal syntax 
//the hierarchical_identifier can't be followed by a range expression
//this is the meaning of false param given to the expr_primary_identifier rule
event_trigger 
: TRIGGER! 
  expr_primary_identifier_no_range 
  SEMI!
  { #event_trigger = #(#[EVENT_TRIGGER, "EVENT_TRIGGER"], #event_trigger); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

event_expression 
: list_of_event_expression
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_event_expression 
: or_event_expression
  (COMMA! or_event_expression)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

or_event_expression 
: event_expression_primary
  (K_OR! event_expression_primary)*
  { #or_event_expression = #(#[OR_EVENT_EXPRESSION, "OR_EVENT_EXPRESSION"], #or_event_expression ); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

event_expression_primary 
: expression
| K_POSEDGE expression
| K_NEGEDGE expression
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

procedural_timing_control 
: delay_control
| event_control
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

procedural_timing_control_statement 
: procedural_timing_control
  attrs_opt 
  statement_or_null
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

wait_statement 
: K_WAIT^ 
  LPAREN! 
  expression 
  RPAREN! 
  attrs_opt 
  statement_or_null
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.6.6 Conditional statements
conditional_statement 
: K_IF^ 
  LPAREN! 
  expression 
  RPAREN!
  attrs_opt 
  statement_or_null
  ( options { warnWhenFollowAmbig = false; } 
  : K_ELSE! attrs_opt statement_or_null
  )?
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.6.7 Case statements
case_statement 
: (K_CASE | K_CASEZ | K_CASEX)
  LPAREN! expression RPAREN!
  (case_item)+
  K_ENDCASE!
  { #case_statement = #(#[CASE_STATEMENT, "CASE_STATEMENT"], #case_statement); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

case_item 
: ( expression_list COLON!
  | K_DEFAULT (COLON!)?
  )
  attrs_opt 
  statement_or_null
  { #case_item = #(#[CASE_ITEM, "CASE_ITEM"], #case_item); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.6.8 Looping statements
loop_statement 
: ( K_FOREVER attrs_opt statement
| K_REPEAT LPAREN! expression RPAREN! attrs_opt statement
| K_WHILE LPAREN! expression RPAREN! attrs_opt statement
| K_FOR LPAREN! variable_assignment SEMI! expression
  SEMI! variable_assignment RPAREN! attrs_opt statement
)
{ #loop_statement = #(#[LOOP_STATEMENT, "LOOP_STATEMENT"], #loop_statement); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.6.9 Task enable statements
system_task_enable 
: system_function_name
  (LPAREN! (expression)? (COMMA (expression)?)* RPAREN!)?
  // We keep COMMA in AST to remove ambiguity in walker
  SEMI!
  { #system_task_enable = #(#[SYSTEM_TASK_ENABLE, "SYSTEM_TASK_ENABLE"], #system_task_enable); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

task_enable 
: hierarchical_identifier
  (LPAREN! expression (COMMA! expression)* RPAREN!)?
  SEMI!
  { #task_enable = #(#[TASK_ENABLE, "TASK_ENABLE"], #task_enable); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.7 Specify section
// A.7.1 Specify block declaration
specify_block 
: K_SPECIFY^
  (specify_item)*
  K_ENDSPECIFY!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

specify_item 
: specparam_declaration
| pulsestyle_declaration
| showcancelled_declaration
| path_declaration
| system_timing_check
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

pulsestyle_declaration 
{
  TBool canBeSimple;
}
: K_PULSESTYLE_ONEVENT^ canBeSimple = list_of_path_outputs SEMI!
| K_PULSESTYLE_ONDETECT^ canBeSimple = list_of_path_outputs SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

showcancelled_declaration 
{
  TBool canBeSimple;
}
: K_SHOWCANCELLED^ canBeSimple = list_of_path_outputs SEMI!
| K_NOSHOWCANCELLED^ canBeSimple = list_of_path_outputs SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.7.2 Specify path declarations
path_declaration 
: simple_or_edge_sensitive_path_declaration SEMI!
| state_dependent_path_declaration SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

simple_or_edge_sensitive_path_declaration
  { 
    TBool simple = FALSE; 
    TBool ei = FALSE;
    TBool po = FALSE;
    TBool canBeSimple, test;
    TBool hasColon;
  } 
: LPAREN!
  (edge_identifier { ei = TRUE; })? // only edge sensitive path
  canBeSimple=list_of_path_inputs
  (hasColon = polarity_operator [false] { po = TRUE; })? // only simple path
  ( PPATH 
    { canBeSimple }?
  | FPATH
    { canBeSimple = FALSE; }
  )
  ( test=parallel_or_full_path_description 
    { !canBeSimple | test }?
    { simple = TRUE; }
    // Error: Illegal usage of edge identifier 
    { !ei  }?
  | parallel_or_full_edge_sensitive_path_description[canBeSimple]
    // Error: Illegal usage of polarity operator 
    { !po }?
  )
  RPAREN!
  ASSIGN! 
  path_delay_value
  { 
    if (simple)
        #simple_or_edge_sensitive_path_declaration = 
            #(#[SIMPLE_PATH_DECLARATION, "SIMPLE_PATH_DECLARATION"], #simple_or_edge_sensitive_path_declaration);
      else
        #simple_or_edge_sensitive_path_declaration = 
            #(#[EDGE_SENSITIVE_PATH_DECLARATION, "EDGE_SENSITIVE_PATH_DECLARATION"], #simple_or_edge_sensitive_path_declaration);
  }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}


parallel_or_full_path_description returns [TBool canBeSimple]
: canBeSimple=list_of_path_outputs
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_path_inputs returns [TBool canBeSimple]
: canBeSimple=list_of_path_terminals
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_path_outputs returns [TBool canBeSimple]
: canBeSimple=list_of_path_terminals
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_path_terminals returns [TBool canBeSimple]
: specify_terminal_descriptor
  { canBeSimple = true; }
  ( COMMA! 
    specify_terminal_descriptor
    {
      if( canBeSimple )
        canBeSimple = false;
    }
  )*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.7.3 Specify block terminals
specify_terminal_descriptor 
: identifier 
  (LBRACK! constant_range_expression RBRACK!)?
  { #specify_terminal_descriptor = #(#[SPECIFY_TERMINAL_DESCRIPTOR, "SPECIFY_TERMINAL_DESCRIPTOR"], #specify_terminal_descriptor); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.7.4 Specify path delays
path_delay_value 
: (LPAREN list_of_path_delay_expressions RPAREN) => LPAREN list_of_path_delay_expressions RPAREN!
| list_of_path_delay_expressions
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

list_of_path_delay_expressions 
  { int counter=1; }
: path_delay_expression
  (COMMA! path_delay_expression { ++counter; } )*
  {    counter == 1 
    || counter == 2
    || counter == 3
    || counter == 6
    || counter == 12
  }?
  { 
    #list_of_path_delay_expressions = 
       #(#[LIST_OF_PATH_DELAY_EXPRESSIONS, "LIST_OF_PATH_DELAY_EXPRESSIONS"], #list_of_path_delay_expressions);
  }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

path_delay_expression 
: constant_mintypmax_expression
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

parallel_or_full_edge_sensitive_path_description [TBool canBeSimple]
  { TBool test;
    //TBool hasColon = false;
  }
: LPAREN!
  test=list_of_path_outputs
  { !canBeSimple || test }?
  { cerr << "---------------" << endl; }
  //( hasColon = polarity_operator[true])? 
  //{ hasColon }?
  ( PO_POS
  | PO_NEG
  )?
  COLON! 
  data_source_expression
  RPAREN!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

data_source_expression :
 expression ;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

edge_identifier 
: K_POSEDGE
| K_NEGEDGE
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

state_dependent_path_declaration 
: K_IF^ 
  LPAREN! 
  module_path_expression 
  RPAREN!
  simple_or_edge_sensitive_path_declaration
| K_IFNONE^ 
  simple_or_edge_sensitive_path_declaration
 // ONLY simple!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

module_path_expression 
: expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

polarity_operator [TBool canBeColon] returns [TBool hasColon]
{
  hasColon = false;
}
: ( PLUS 
  | MINUS 
  | PO_POS { hasColon = true; } 
  | PO_NEG { hasColon = true; } )
  
  ( tok:COLON! 
    { if(!hasColon) hasColon = true;
      else throw ANTLR_USE_NAMESPACE(antlr)RecognitionException("Unexpected :",
                        tok->getFilename(), 
                        tok->getLine(), 
                        tok->getColumn() );
    }
  )?
  { !(canBeColon ^ hasColon) }?
  { #polarity_operator = #(#[POLARITY_OPERATOR, "POLARITY_OPERATOR"], #polarity_operator); }
;
exception
catch [SemanticException &sem] {
  args.push_back("");
  if(canBeColon)
    args.push_back("Polarity operator must be followed by a colon");
  else
    args.push_back("Polarity operator can't be followed by a colon");
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args,sem.getLine());
  verilogParserHasErrors = true;
  consume();
}
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.7.5 System timing checks
// A.7.5.1 System timing check commands
system_timing_check 
: setup_timing_check
| hold_timing_check
| setuphold_timing_check
| recovery_timing_cehck
| removal_timing_check
| recrem_timing_check
| skew_timing_check
| timeskew_timing_check
| fullskew_timing_check
| period_timing_check
| width_timing_check
| nochange_timing_check
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

setup_timing_check 
: K_S_SETUP^
  LPAREN!
  data_event
  COMMA! reference_event
  COMMA! timing_check_limit
  (COMMA (notify_reg)?)?
  // In all system timing checks
  // We keep COMMA in AST to remove ambiguity in walker
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

hold_timing_check 
: K_S_HOLD^
  LPAREN!
  reference_event
  COMMA! data_event
  COMMA! timing_check_limit
  (COMMA (notify_reg)?)?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

setuphold_timing_check 
: K_S_SETUPHOLD^
  LPAREN!
  reference_event
  COMMA! data_event
  COMMA! timing_check_limit
  COMMA! timing_check_limit
  (COMMA (notify_reg)?
    (COMMA (stamptime_condition)?
      (COMMA (checktime_condition)?
        (COMMA (delayed_reference)?
          (COMMA (delayed_data)?
          )?
        )?
      )?
    )?
  )?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

recovery_timing_cehck 
: K_S_RECOVERY^
  LPAREN!
  reference_event
  COMMA! data_event
  COMMA! timing_check_limit
  (COMMA (notify_reg)?)?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

removal_timing_check 
: K_S_REMOVAL^
  LPAREN!
  reference_event
  COMMA! data_event
  COMMA! timing_check_limit
  (COMMA (notify_reg)?)?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

recrem_timing_check 
: K_S_RECREM^
  LPAREN!
  reference_event
  COMMA! data_event
  COMMA! timing_check_limit
  COMMA! timing_check_limit
  (COMMA (notify_reg)?
    (COMMA (stamptime_condition)?
      (COMMA (checktime_condition)?
        (COMMA (delayed_reference)?
          (COMMA (delayed_data)?
          )?
        )?
      )?
    )?
  )?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

skew_timing_check 
: K_S_SKEW^
  LPAREN!
  reference_event
  COMMA! data_event
  COMMA! timing_check_limit
  (COMMA (notify_reg)?)?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

timeskew_timing_check 
: K_S_TIMESKEW^
  LPAREN!
  reference_event
  COMMA! data_event
  COMMA! timing_check_limit
  (COMMA (notify_reg)?
    (COMMA (event_based_flag)?
      (COMMA (remain_active_flag)?
      )?
    )?    
  )?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

fullskew_timing_check 
: K_S_FULLSKEW^
  LPAREN!
  reference_event
  COMMA! data_event
  COMMA! timing_check_limit
  COMMA! timing_check_limit
  (COMMA (notify_reg)?
    (COMMA (event_based_flag)?
      (COMMA (remain_active_flag)?
      )?
    )?    
  )?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

period_timing_check 
: K_S_PERIOD^
  LPAREN!
  controlled_reference_event
  COMMA! timing_check_limit
  (COMMA (notify_reg)?)?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

width_timing_check 
: K_S_WIDTH^
  LPAREN!
  controlled_reference_event
  COMMA! timing_check_limit
  (COMMA (threshold)? 
    (COMMA (notify_reg)? )? 
  )?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

nochange_timing_check 
: K_S_NOCHANGE^
  LPAREN!
  reference_event
  COMMA! data_event
  COMMA! start_edge_offset
  COMMA! end_edge_offset
  (COMMA (notify_reg)?)?
  RPAREN!
  SEMI!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.7.5.2 System timing check command arguments
checktime_condition 
: mintypmax_expression
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

controlled_reference_event 
: controlled_timing_check_event 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

data_event 
: timing_check_event 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

delayed_data 
: delayed_data_or_reference 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

delayed_reference 
: delayed_data_or_reference 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

delayed_data_or_reference 
: terminal_identifier
  (LBRACK! constant_mintypmax_expression RBRACK!)?
  { #delayed_data_or_reference = #(#[DELAYED_DATA_OR_REFERENCE, "DELAYED_DATA_OR_REFERENCE"], #delayed_data_or_reference); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

end_edge_offset 
: mintypmax_expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

event_based_flag 
: constant_expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

notify_reg 
: variable_identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

reference_event 
: timing_check_event 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

remain_active_flag 
: constant_mintypmax_expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

stamptime_condition 
: mintypmax_expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

start_edge_offset 
: mintypmax_expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

threshold 
: constant_expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

timing_check_limit 
: expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}


// A.7.5.3 System timing check event definitions
timing_check_event 
: (timing_check_event_control)?
  specify_terminal_descriptor
  (TAND! timing_check_condition)?
  { #timing_check_event = #(#[TIMING_CHECK_EVENT, "TIMING_CHECK_EVENT"], #timing_check_event); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

controlled_timing_check_event 
: timing_check_event_control
  specify_terminal_descriptor
  (TAND! timing_check_condition)?
  { 
    #controlled_timing_check_event = 
        #(#[CONTROLLED_TIMING_CHECK_EVENT, "CONTROLLED_TIMING_CHECK_EVENT"], #controlled_timing_check_event);
  }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

timing_check_event_control 
: K_POSEDGE
| K_NEGEDGE
| edge_control_specifier
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

edge_control_specifier 
: K_EDGE^
  LBRACK!
  edge_descriptor (COMMA! edge_descriptor)*
  RBRACK!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

edge_descriptor 
: UNSIGNED_NUMBER
| IDENTIFIER
| EDGE_DESC
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

timing_check_condition 
: scalar_timing_check_condition
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

scalar_timing_check_condition 
: expression
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.8 Expressions
// A.8.1 Concatenations
concatenation 
: LCRULY!
  ( expression
    ( (COMMA! expression)*
      { #concatenation = #(#[CONCATENATION, "CONCATENATION"], #concatenation); }
    | concatenation
      { #concatenation = #(#[MULTI_CONCATENATION, "MULTI_CONCATENATION"], #concatenation); }
    )
  )
  RCRULY!
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.8.2 Function calls
function_call 
: hierarchical_function_identifier
  attrs_opt
  LPAREN! expression_list RPAREN!
  { #function_call = #(#[FUNCTION_CALL, "FUNCTION_CALL"], #function_call); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

system_function_call 
: system_function_name 
  (LPAREN! expression_list RPAREN!)?
  { #system_function_call = #(#[SYSTEM_FUNCTION_CALL, "SYSTEM_FUNCTION_CALL"], #system_function_call); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.8.3 Expressions
expression_list 
: expression 
  (COMMA! expression)*
  { #expression_list = #(#[EXPRESSION_LIST, "EXPRESSION_LIST"], #expression_list); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

range_expression 
: expression
  ( ( COLON expression
    | PO_POS expression
    | PO_NEG expression
    )
    { #range_expression = #(#[RANGE_EXPRESSION, "RANGE_EXPRESSION"], #range_expression); }
  )?
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

mintypmax_expression 
: expression 
  ( COLON! expression COLON! expression )?
  { #mintypmax_expression = #(#[MINTYPMAX_EXPRESSION, "MINTYPMAX_EXPRESSION"], #mintypmax_expression); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

pure_mintypmax_expression 
: expression 
  COLON! 
  expression 
  COLON! 
  expression
  { #pure_mintypmax_expression = #(#[MINTYPMAX_EXPRESSION, "MINTYPMAX_EXPRESSION"], #pure_mintypmax_expression); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

expression 
: conditional_expr
  { #expression =#(#[EXPRESSION, "EXPRESSION"], #expression); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

conditional_expr 
: logical_or_expr
  (QUESTION^ attrs_opt conditional_expr COLON! conditional_expr)?
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

logical_or_expr 
: logical_and_expr (LOR^ attrs_opt logical_and_expr)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

logical_and_expr 
: or_expr (LAND^ attrs_opt or_expr)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

or_expr 
: xor_expr ((OR^ | NOR^) attrs_opt xor_expr)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

xor_expr 
: and_expr ((XOR^ | XNOR^) attrs_opt and_expr)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

and_expr 
: equality_expr ((AND^ | NAND^) attrs_opt equality_expr)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

equality_expr 
: relational_expr
  ((EQUAL^ | NOT_EQ^ | NOT_EQ_CASE^ | EQ_CASE^) attrs_opt relational_expr)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

relational_expr 
: shift_expr ((LT_^ | GT^ | LE^ | GE^) attrs_opt shift_expr)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

shift_expr 
: addictive_expr ((SL^ | SSL^ | SR^ | SSR^) attrs_opt addictive_expr)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

addictive_expr 
: multiplicative_expr ((PLUS^ | MINUS^) attrs_opt multiplicative_expr)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

multiplicative_expr 
: pow_expr ((STAR^ | DIV^ | MOD^) attrs_opt pow_expr)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// Handling power operator. Tricky rule, because power operator
// is right associative unlike most operators
pow_expr 
: unary_expr
  (
  | POW^ attrs_opt pow_expr
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

unary_expr 
  { bool test  = false; }
: expr_primary
|! LPAREN!
  ex1: expression { #unary_expr = #ex1; }
  ( COLON! 
    ex2:expression 
    COLON! 
    ex3:expression
    { test = true; }
    { #unary_expr = #(#[MINTYPMAX_EXPRESSION, "MINTYPMAX_EXPRESSION"], #ex1, #ex2, #ex3); }
  )?
  { if(!test) #unary_expr = #(#[MINTYPMAX_EXPRESSION, "MINTYPMAX_EXPRESSION"], #ex1); }
  RPAREN!
| PLUS!  attrs_opt unary_expr { #unary_expr = #(#[U_PLUS, "U_PLUS"], #unary_expr); }
| MINUS! attrs_opt unary_expr { #unary_expr = #(#[U_MINUS, "U_MINUS"], #unary_expr); }
| LNOT^  attrs_opt unary_expr
| NOT^   attrs_opt unary_expr
| AND!   attrs_opt unary_expr { #unary_expr = #(#[U_AND, "U_AND"], #unary_expr); }
| NAND!  attrs_opt unary_expr { #unary_expr = #(#[U_NAND, "U_NAND"], #unary_expr); }
| OR!    attrs_opt unary_expr { #unary_expr = #(#[U_OR, "U_OR"], #unary_expr); }
| NOR!   attrs_opt unary_expr { #unary_expr = #(#[U_NOR, "U_NOR"], #unary_expr); }
| XOR!   attrs_opt unary_expr { #unary_expr = #(#[U_XOR, "U_XOR"], #unary_expr); }
| XNOR!  attrs_opt unary_expr { #unary_expr = #(#[U_XNOR, "U_XNOR"], #unary_expr); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.8.4 Primaries
expr_primary 
: ( number
  | STRING
  |! epi:expr_primary_identifier 
    { #expr_primary = #epi; }
    ( attrs_opt 
      LPAREN! 
      el:expression_list RPAREN!
      { #expr_primary =  #(#[FUNCTION_CALL, "FUNCTION_CALL"], #epi, #el); }  
    )?
  | concatenation
  | system_function_call
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.8.5 Expression left-side values
net_lvalue 
: lvalue 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

variable_lvalue 
: lvalue 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

net_or_variable_lvalue 
: lvalue 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

lvalue 
: ( expr_primary_identifier
  | LCRULY! 
    lvalue 
    (COMMA! lvalue)* 
    RCRULY!
  )
  { #lvalue = #(#[LVALUE, "LVALUE"], #lvalue); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.8.7 Numbers
number 
: un:unsigned_number
  ( bn:based_number
    {
      string numText = #un->getText() + #bn->getText();
      #number = #(#[SIZED_NUMBER, numText], #number);
    }
  )?
| based_number
| real_number
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

unsigned_number 
: tok:UNSIGNED_NUMBER
  { VerilogToken *vt = static_cast<VerilogToken*>(tok.get()); #unsigned_number->setNumber(vt->getNumber()); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

based_number 
: tok:BASED_NUMBER
  { VerilogToken *vt = static_cast<VerilogToken*>(tok.get()); #based_number->setNumber(vt->getNumber()); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

real_number 
: tok:REAL_NUMBER
  { VerilogToken *vt = static_cast<VerilogToken*>(tok.get()); #real_number->setNumber(vt->getNumber()); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.9.1 Attributes
attrs 
: (attribute_instance)+
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

attrs_opt 
: (attribute_instance)*
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

attribute_instance 
: PSTAR! attr_spec (COMMA! attr_spec)* STARP!
  { #attribute_instance = #(#[ATTRIBUTE_INSTANCE, "ATTRIBUTE_INSTANCE"], #attribute_instance); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

attr_spec 
: attr_name 
  (ASSIGN! constant_expression)?
  { #attr_spec = #(#[ATTR_SPEC, "ATTR_SPEC"], #attr_spec); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

attr_name 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// A.9.3 Identifiers

identifier 
: ( IDENTIFIER
  | ESCAPED_IDENTIFIER 
  )
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// This rules has been rewritten to feet grammar in LL(1)
hierarchical_identifier 
: identifier 
  ((LBRACK! constant_expression RBRACK!)? DOT! identifier)*
  { #hierarchical_identifier = #(#[HIERARCHICAL_IDENTIFIER, "HIERARCHICAL_IDENTIFIER"], #hierarchical_identifier); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

//Modifed this rule by splitting it in two rules
//This is necessary because some rules allow a range expression, and some don't
//It is not possible to resolv this problem from this context
//The problem should be solved in the enclosing rule
//but beacuse the disambiguity problem it should be solved here
//So there are two possible combinations here
//one is the possible range expression at the end
//and the other one forbids it
//this rule will temporary store created subtrees and check subsequently if the previous expresion
//is a range expression, in the case a range expression is possible
//all this can be implemented in the parser using temporary storage with tempRef variable
//wich stores the last matched ref
expr_primary_identifier
  {
    RefVerAST tempRef=RefVerAST(0);
    //We use the count to check and make sure that only the last range is multiple
    unsigned int count =0;
  }
: identifier 
  ( LBRACK! 
    rn1:range_expression 
    //Advansed semantic check, testing if the last range_expression was an expression
    { tempRef.get() ? tempRef->getType() == EXPRESSION : true }?
    { count++; }
    //Assigning temporary ref
    { tempRef = #rn1; }
    RBRACK!
  )*
  ( DOT! 
    identifier
    { count < 2 }?
    { count=0; }
    //Advansed semantic check, testing if the last range_expression was an expression
    { tempRef.get() ? tempRef->getType() == EXPRESSION : true }?
    ( LBRACK! 
      rn2:range_expression
      //Advansed semantic check, testing if the last range_expression was an expression
      { tempRef.get() ? tempRef->getType() == EXPRESSION : true }?
      //Assigning temporary ref
      { tempRef = #rn2; count++;}
      RBRACK!
    )*
  )*
  { #expr_primary_identifier = #(#[EXPR_PRIMARY_IDENTIFIER, "EXPR_PRIMARY_IDENTIFIER"], #expr_primary_identifier); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

//this rule does not require advansed semantic check, because the rule can't have a range_expression at the end
expr_primary_identifier_no_range
: identifier 
  (LBRACK! expression RBRACK!)*
  ( DOT! 
    identifier 
    ( LBRACK! 
      expression
      RBRACK!
    )*
  )*
  { #expr_primary_identifier_no_range = #(#[EXPR_PRIMARY_IDENTIFIER, "EXPR_PRIMARY_IDENTIFIER"], #expr_primary_identifier_no_range); }
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

system_function_name
: SYSTEM_TASK_NAME
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

hierarchical_function_identifier 
: hierarchical_identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

hierarchical_parameter_identifier 
: hierarchical_identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

module_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

port_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

parameter_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

specparam_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

net_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

variable_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

event_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

genvar_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

block_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

task_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

function_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

gate_instance_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

module_instance_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

generate_block_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

terminal_identifier 
: identifier 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

udp_identifier 
: identifier
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}


// TEMPORARY
dimension_constant_expression 
: expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

msb_constant_expression 
: expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

lsb_constant_expression 
: expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

constant_expression 
: expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

constant_range_expression 
: range_expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

constant_mintypmax_expression 
: mintypmax_expression 
;
exception
catch [RecognitionException &ex] {
  args.push_back(intToString(ex.getColumn()));
  args.push_back(ex.getMessage());
  addErr( NSWarningErr::VEE_VEP_STMT_VEE_VEP_STMT_PARSER_ERROR, args, ex.getLine());
  verilogParserHasErrors = true;
  consume();
}

// End of File
