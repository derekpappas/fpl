// NOT ON THE MAVEN ANTLR INCLUDES LIST (work in progress). Build uses VerilogParser.g4.
//
// ANTLR4 Java port of legacy ANTLR2/C++ parser grammar.
// Source: /Users/derekpappas/fpl/trunk/cslc/trunk/src/parser/verilog/verilog.parser.g (from first rule line 170).
// C++ actions, AST construction, and exception/catch handlers were removed (syntax-only port).
// Regenerate with: scripts/port_trunk_parser_g_to_g4.py

parser grammar VerilogParser;

options { tokenVocab = VerilogLexer; }

unexpected
: ( UNSIGNED_NUMBER
  | NZ_UNSIGNED_NUMBER
  | REAL_NUMBER
  | REAL_NUMBER_EXP

  | TICK
  | BACKTICK
  | AT
  | COLON
  | COMMA

  | MINUS

  | RBRACK
  | LCRULY
  | RCRULY
  | LPAREN
  | RPAREN
  | POUND
  | QUESTION

  | PLUS
  | LNOT
  | NOT
  | AND
  | NAND
  | OR
  | NOR
  | XOR
  | XNOR
  | STAR
  | POW
  | DIV
  | MOD
  | EQUAL
  | NOT_EQ
  | NOT_EQ_CASE
  | EQ_CASE
  | LAND
  | TAND
  | LOR
  | LT_

  | GT
  | GE
  | SL
  | SSL
  | SR
  | SSR
  | TRIGGER
  | PPATH
  | FPATH

  | STARP
  | PO_POS
  | PO_NEG
  | SUPERSTAR
  | K_BEGIN
  | K_END
  )
  
;

source_text 
: 
  (description)*
  EOF
;

description 
: attrs_opt
  ( module
  | udp_declaration
  | unexpected
  | K_ENDMODULE
  )
;

module 
 
: (
    module_keyword
    module_identifier
    (module_parameter_port_list)?
    (
      LPAREN
      ( list_of_port_declarations
      | nonemptyPorts=list_of_ports
        
      )
      RPAREN
    )?
    SEMI 
    (module_item)*
    K_ENDMODULE
  )
  
;

module_keyword 
: x1=K_MODULE
| x2=K_MACROMODULE
;

module_parameter_port_list  
: 
  POUND
  LPAREN

  pdh1=parameter_declaration_header
  
  pa1=param_assignment
  
  ( COMMA
      (
        pa2=param_assignment
        
      | pdh2=parameter_declaration_header
        
        pa3=param_assignment
        
      )
  )*
  RPAREN
;

 
list_of_ports 
: empty=port 
  
  ( COMMA 
    empty=port 
    
  )*
;

list_of_port_declarations 
   
: 
  atr=attrs_opt
  
  pdecl1=port_declaration
  
  ( COMMA
    ( atr1=attrs_opt
      
      pdecl2=port_declaration
      
    | vpi=variable_port_identifier

    )
  )*
;

port
: ( port_expression | named_port_expression )?;

named_port_expression 
: DOT 
  port_identifier 
  LPAREN 
  (port_expression)? 
  RPAREN
  
;

port_expression 
: ( port_reference
  | port_reference_concat
  )
  
;

port_reference_concat 
: ( LCRULY 
    port_reference 
    (COMMA port_reference)* 
    RCRULY
  )
  
;

port_reference 
: port_identifier 
  ( LBRACK 
    constant_range_expression 
    RBRACK
  )?
  
;

port_declaration
: inout_declaration
  
| input_declaration
  
| canBeVar=output_declaration
;

module_item
   
: specify_block
| generated_instantiation
| attrs_opt
  ( local_parameter_declaration SEMI
  | module_or_generate_item
  | parameter_declaration SEMI
  | specparam_declaration
  | pdecl=port_declaration

    ( COMMA pid=variable_port_identifier

    )*
    SEMI
  )
;

module_or_generate_item 
: module_or_generate_item_declaration
| parameter_override
| continuous_assign
| gate_instantiation
| module_or_udp_instantiation
| initial_construct
| always_construct
;

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
: K_DEFPARAM 
  list_of_defparam_assignments 
  SEMI
;

local_parameter_declaration 
: ( K_LOCALPARAM
    ( (K_SIGNED)? 
      (range)?
    | parameter_type
    )
    list_of_param_assignments
  )
;

parameter_declaration_header 
: K_PARAMETER
  ( (K_SIGNED)? 
    (range)?
  | parameter_type
  )
;

parameter_declaration 
: pdh=parameter_declaration_header
  lopa=list_of_param_assignments
  
;

specparam_declaration 
: K_SPECPARAM 
  (range)? 
  list_of_specparam_assignments 
  SEMI
;

parameter_type 
: ( K_INTEGER
  | K_REAL
  | K_REALTIME
  | K_TIME
  )
;

inout_declaration 
: K_INOUT 
  (net_type)? 
  (K_SIGNED)? 
  (range)?
  port_identifier
;

input_declaration 
: K_INPUT 
  (net_type)? 
  (K_SIGNED)? 
  (range)?
  port_identifier
;

output_declaration 
   
: K_OUTPUT
  ( (net_type)? 
    (K_SIGNED)? 
    (range)? 
    port_identifier
    
  | K_REG (K_SIGNED)? (range)? var=variable_port_identifier
    
  | output_variable_type var=variable_port_identifier
    
  )
;

integer_declaration 
: K_INTEGER 
  list_of_variable_identifiers 
  SEMI
;

net_declaration 
   
: ( net_type
    
    (LPAREN drive_strength RPAREN )?
    (expandrange )?
    (K_SIGNED)?
    (range )?

    (delay3)?
    list_of_net_identifiers_or_decl_assignments

    SEMI
    
  )
| ( K_TRIREG
    
    ( LPAREN
      (charge_strength
      | (drive_strength )
      )
      RPAREN
    )?
    (expandrange )?
    (K_SIGNED)?
    (range )?

    (delay3)?
    list_of_net_identifiers_or_decl_assignments

    SEMI
    
  )
;

expandrange 
: (K_VECTORED | K_SCALARED)
;

real_declaration 
: K_REAL 
  list_of_variable_identifiers 
  SEMI
;

realtime_declaration 
: K_REALTIME 
  list_of_variable_identifiers 
  SEMI
;

time_declaration 
: K_TIME 
  list_of_variable_identifiers 
  SEMI
;

reg_declaration 
: K_REG 
  (K_SIGNED)? 
  (range)? 
  list_of_variable_identifiers 
  SEMI
;

event_declaration 
: K_EVENT 
  list_of_event_identifiers 
  SEMI
;

genvar_declaration 
: K_GENVAR 
  list_of_genvar_identifiers 
  SEMI
;

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

output_variable_type 
: ( K_INTEGER
  | K_TIME
  )

;

variable_type 
: variable_identifier
  ( (dimension)*
  | ASSIGN 
    constant_expression
  )
  
;

drive_strength 
: ( strength0 COMMA (strength1 | highz1)
  | strength1 COMMA (strength0 | highz0)
  | highz0 COMMA strength1
  | highz1 COMMA strength0
  )
;

strength0 
: (K_SUPPLY0 | K_STRONG0 | K_PULL0 | K_WEAK0)
;

strength1 
: (K_SUPPLY1 | K_STRONG1 | K_PULL1 | K_WEAK1)
;

highz0 
: K_HIGHZ0
;

highz1 
: K_HIGHZ1
;

charge_strength 
: (K_SMALL | K_MEDIUM | K_LARGE)
;

delay3 
: POUND
  ( delay_value
  | LPAREN
    mintypmax_expression
    (COMMA mintypmax_expression (COMMA mintypmax_expression)? )?
    RPAREN
  )
  
;

delay2 
: POUND
  ( delay_value
  | LPAREN
    mintypmax_expression
    (COMMA mintypmax_expression)?
    RPAREN
  )
  
;

delay_value 
: ( unsigned_number
  | real_number
  | identifier
  )
  
;

list_of_net_identifiers_or_decl_assignments
: net_identifier
  ( (dimension)* (COMMA net_identifier (dimension)*)*
    
  | ASSIGN expression (COMMA net_identifier ASSIGN expression)*
    
  )
;

list_of_event_identifiers 
: event_identifier 
  (dimension)*
  (COMMA event_identifier (dimension)*)*
;

list_of_genvar_identifiers 
: genvar_identifier
  (COMMA genvar_identifier)*
;

list_of_defparam_assignments 
: defparam_assignment
  (COMMA defparam_assignment)*
;

list_of_param_assignments 
: param_assignment
  (COMMA param_assignment)*
;

list_of_specparam_assignments 
: specparam_assignment
  (COMMA specparam_assignment)*
;

list_of_variable_identifiers 
: variable_type 
  (COMMA variable_type)*
;

list_of_variable_port_identifiers 
   
: dummy=variable_port_identifier
  (COMMA dummy=variable_port_identifier)*
  
;

variable_port_identifier 
: 
  port_identifier
  ( ASSIGN 
    constant_expression
    
  )?
;

defparam_assignment 
: hierarchical_parameter_identifier
  ASSIGN
  constant_mintypmax_expression
  
;

param_assignment 
: parameter_identifier
  ASSIGN
  constant_mintypmax_expression
  
;

specparam_assignment 
: param_assignment
| pulse_control_specparam
;

pulse_control_specparam 
  
: 
  pp=PATHPULSE

  (
    
    ( LBRACK 
      cre1=constant_range_expression
      
      RBRACK
    )?
    (
      stn=SYSTEM_TASK_NAME

      
      ( LBRACK 
        cre2=constant_range_expression
        
        RBRACK
      )?
    )?
  )?
  assn=ASSIGN
  

  LPAREN
  cme1=constant_mintypmax_expression
  
  ( COMMA
    cme2=constant_mintypmax_expression
    
  )?
  RPAREN

;

dimension 
: LBRACK
  dimension_constant_expression
  COLON
  dimension_constant_expression
  RBRACK
  
;

range 
: LBRACK
  lsb_constant_expression
  COLON
  msb_constant_expression
  RBRACK
  
;

function_declaration 

: K_FUNCTION 
  (K_AUTOMATIC)?  
  (K_SIGNED)? 
  (range_or_type)?
  function_identifier
  ( SEMI
    attrs_opt 
    function_item_declaration
    ( attrs_opt 

      ( function_item_declaration
      | function_statement 
      )
    )*
  | LPAREN 
    function_port_list 
    RPAREN
    SEMI
    ( attrs_opt 

      ( block_item_declaration
      | function_statement 
        
      )
    )*

  )
  K_ENDFUNCTION
;

function_item_declaration 
: block_item_declaration
| tfid=tf_input_declaration
  ( COMMA 
    pid=port_identifier
    
  )* 
  SEMI
;

function_port_list 
   
: 
  attrs_opt
  tfid1=tf_input_declaration
  
  ( COMMA
    ( attrs_opt 
      tfid2=tf_input_declaration
       
     | pid=port_identifier
       
     )
  )*
;

range_or_type 
: range
| K_INTEGER
| K_REAL
| K_REALTIME
| K_TIME
;

task_declaration 

: K_TASK 
  (K_AUTOMATIC)? 
  task_identifier
  ( SEMI
    ( attrs_opt

      ( task_item_declaration
      | statement_or_null 
      )
    )*
  | LPAREN (task_port_list)? RPAREN
    SEMI
    ( attrs_opt 

      ( block_item_declaration
      | statement_or_null 
      )
    )*
  )

  K_ENDTASK
;

task_item_declaration 
: block_item_declaration
| tfid=tf_input_declaration
  ( COMMA 
    pid1=port_identifier
    
  )* 
  SEMI
| tfod=tf_output_declaration
  ( COMMA 
    pid2=port_identifier
    
  )* 
  SEMI
| tfiod=tf_inout_declaration
  ( COMMA 
    pid3=port_identifier  
    
  )* 
  SEMI
;

task_port_list 
  
: 
  tpi1=task_port_item 
  
  ( COMMA
    ( tpi2=task_port_item 
      
    | pid=port_identifier
      
    )
  )*
;

task_port_item 
: attrs_opt
  ( tf_input_declaration
  | tf_output_declaration
  | tf_inout_declaration
  )
;

tf_input_declaration 
: K_INPUT
  ( (K_REG)? 
    (K_SIGNED)? 
    (range)?
  | task_port_type
  )
  port_identifier
;

tf_output_declaration 
: K_OUTPUT
  ( (K_REG)? 
    (K_SIGNED)? 
    (range)?
  | task_port_type
  )
  port_identifier
;

tf_inout_declaration 
: K_INOUT
  ( (K_REG)? 
    (K_SIGNED)? 
    (range)?
  | task_port_type
  )
  port_identifier
;

task_port_type 
: K_INTEGER
| K_REAL
| K_REALTIME
| K_TIME
;

block_item_declaration 
: reg_declaration
| integer_declaration
| time_declaration
| real_declaration
| realtime_declaration
| event_declaration
| local_parameter_declaration SEMI
| parameter_declaration SEMI
;

gate_instantiation 
: ( cmos_switchtype 
    (delay3)?
    cmos_switch_instance 
    (COMMA cmos_switch_instance)*
  | enable_gatetype
    (  LPAREN drive_strength RPAREN | )
    (delay3)?
    enable_gate_instance (COMMA enable_gate_instance)*
  | mos_switchtype (delay3)?
    mos_switch_instance (COMMA mos_switch_instance)*
  | n_input_gatetype
    (LPAREN drive_strength RPAREN |)
    (delay2)?
    n_input_gate_instance (COMMA n_input_gate_instance)*
  | n_output_gatetype
    (LPAREN drive_strength RPAREN |)
    (delay2)?
    n_output_gate_instance (COMMA n_output_gate_instance)*
  | pass_enable_switchtype (delay2)?
    pass_enable_switch_instance (COMMA pass_enable_switch_instance)*
  | pass_switchtype
    pass_switch_instance (COMMA pass_switch_instance)*
  | K_PULLDOWN
    (LPAREN pulldown_strength RPAREN |)
    pull_gate_instance (COMMA pull_gate_instance)*
  | K_PULLUP
    (LPAREN pullup_strength RPAREN |)
    pull_gate_instance (COMMA pull_gate_instance)*
  )
  SEMI
  
;

cmos_switch_instance 
: (name_of_gate_instance)?
  LPAREN
  output_terminal 
  COMMA 
  input_terminal 
  COMMA
  ncontrol_terminal 
  COMMA 
  pcontrol_terminal
  RPAREN
  
;

enable_gate_instance 
: (name_of_gate_instance)?
  LPAREN
  output_terminal 
  COMMA 
  input_terminal 
  COMMA 
  enable_terminal
  RPAREN
  
;

mos_switch_instance 
: (name_of_gate_instance)?
  LPAREN
  output_terminal 
  COMMA 
  input_terminal 
  COMMA 
  enable_terminal
  RPAREN
  
;

n_input_gate_instance 
: (name_of_gate_instance)?
  LPAREN
  output_terminal 
  COMMA 
  input_terminal 
  (COMMA input_terminal)*
  RPAREN
  
;

n_output_gate_instance 
: (name_of_gate_instance)?
  LPAREN
  output_terminal
  (COMMA input_terminal)+

  RPAREN
  
;

pass_enable_switch_instance 
: (name_of_gate_instance)?
  LPAREN
  inout_terminal 
  COMMA 
  inout_terminal 
  COMMA 
  enable_terminal
  RPAREN
  
;

pass_switch_instance 
: (name_of_gate_instance)?
  LPAREN
  inout_terminal 
  COMMA 
  inout_terminal
  RPAREN
  
;

pull_gate_instance 
: (name_of_gate_instance)?
  LPAREN
  output_terminal
  RPAREN
  
;

name_of_gate_instance 
: gate_instance_identifier 
  (range)?
;

pulldown_strength 
: ( strength0 (COMMA strength1)?
  | strength1 COMMA strength0
  )
;

pullup_strength 
: ( strength0 COMMA strength1
  | strength1 (COMMA strength0)?
  )
;

enable_terminal 
: expression 
;

inout_terminal 
: net_lvalue 
;

input_terminal 
: expression 
;

ncontrol_terminal 
: expression 
;

output_terminal 
: net_lvalue 
;

pcontrol_terminal 
: expression 
;

cmos_switchtype 
: K_CMOS | K_RCMOS 
;

enable_gatetype 
: K_BUFIF0 | K_BUFIF1 | K_NOTIF0 | K_NOTIF1 
;

mos_switchtype 
: K_NMOS | K_PMOS | K_RNMOS | K_RPMOS 
;

n_input_gatetype 
: K_AND | K_NAND | K_OR | K_NOR | K_XOR | K_XNOR 
;

n_output_gatetype 
: K_BUF | K_NOT 
;

pass_enable_switchtype 
: K_TRANIF0 | K_TRANIF1 | K_RTRANIF1 | K_RTRANIF0 
;

pass_switchtype 
: K_TRAN | K_RTRAN 
;

module_or_udp_instantiation 
: module_identifier
  ((LPAREN drive_strength RPAREN))?
  (parameter_value_assignment_or_delay2)?

  module_instance
  (COMMA module_instance)*
  SEMI
  
;

parameter_value_assignment_or_delay2 
: POUND
  ( LPAREN 
    list_of_parameter_assignments_or_delay2 
    RPAREN

  )
;

list_of_parameter_assignments_or_delay2 
: ( ordered_parameter_assignment
    (COMMA ordered_parameter_assignment)*
  | named_parameter_assignment
    (COMMA named_parameter_assignment)*
  )
  
;

ordered_parameter_assignment 
:

  mintypmax_expression
;

named_parameter_assignment 
: DOT parameter_identifier
  LPAREN (mintypmax_expression)? RPAREN
  
;

module_instance 

: ( name_of_module_instance )?
  LPAREN list_of_port_connections RPAREN
  
;

name_of_module_instance 
: module_instance_identifier 
  (range)?
;

list_of_port_connections 
: attrs_opt
  ( ordered_port_connection
    (COMMA attrs_opt ordered_port_connection)*
  | named_port_connection
    (COMMA attrs_opt named_port_connection)*
  )
;

ordered_port_connection 
: (
  | expression
  )
  
;

named_port_connection 
: DOT 
  port_identifier 
  LPAREN 
  (expression)? 
  RPAREN
  
;

generated_instantiation 
: K_GENERATE
  (generate_item)*
  K_ENDGENERATE
;

generate_item_or_null 
: ( generate_item
  | SEMI
  )
  
;

generate_item 
: generate_conditional_statement
| generate_case_statement
| generate_loop_statement
| generate_block
| attrs_opt module_or_generate_item
;

generate_conditional_statement 
: K_IF 
  LPAREN 
  constant_expression 
  RPAREN
  generate_item_or_null
  ( options  :
    K_ELSE generate_item_or_null
  )?
;

generate_case_statement 
: K_CASE 
  LPAREN 
  constant_expression 
  RPAREN
  (genvar_case_item)+
  K_ENDCASE
;

genvar_case_item 
: ( constant_expression 
    (COMMA constant_expression)*
    COLON
  | K_DEFAULT 
    (COLON)? 
  )
  generate_item_or_null
  
;

generate_loop_statement 
: K_FOR
  LPAREN
  genvar_assignment SEMI
  constant_expression SEMI
  genvar_assignment
  RPAREN
  K_BEGIN 
  COLON 
  generate_block_identifier
  (generate_item)*
  K_END
;

genvar_assignment 
: genvar_identifier 
  ASSIGN 
  constant_expression
  
;

generate_block 
: K_BEGIN
  (COLON generate_block_identifier)?
  (generate_item)*
  K_END
  
;

udp_declaration
  
: K_PRIMITIVE 
  udp_identifier
  LPAREN
  ( udp_port_list
  | udp_declaration_port_list 
  )
  RPAREN 
  SEMI
  ( udp_port_declaration

  )*
  udp_body
  K_ENDPRIMITIVE
;

udp_port_list 
: port_identifier 
  (COMMA port_identifier)+
  
;

udp_declaration_port_list
  
: 
  atr=attrs_opt
  
  uod=udp_output_declaration
  

  (

    COMMA
    ( atr1=attrs_opt 
      
      idh2=udp_input_declaration_header
      
    | pid=port_identifier 
    )
  )+
;

udp_port_declaration 
: attrs_opt
  ( udp_output_declaration SEMI
  | udp_input_declaration SEMI
  | udp_reg_declaration SEMI
  )
;

udp_output_declaration 
: K_OUTPUT
( port_identifier
| K_REG port_identifier 
  (ASSIGN constant_expression)?
)
;

udp_input_declaration_header 
: K_INPUT 
  port_identifier
;

udp_input_declaration 
: K_INPUT 
  port_identifier 
  (COMMA port_identifier)*
;

udp_reg_declaration 
: K_REG 
  variable_identifier
;

udp_body 
  
: ( udp_initial_statement 
    
  )?
  K_TABLE
  ( udp_table_entry )+
  K_ENDTABLE
;

udp_initial_statement 
: K_INITIAL 
  port_identifier 
  ASSIGN 
  init_val 
  SEMI
;

init_val 
   
: n=number

;

udp_table_entry
  
:  input_list 
  COLON 
  current_state 
  COLON 
  next_state 
  SEMI

| input_list 
  COLON 
  output_symbol 
  SEMI

;

input_list
  
: ( level_symbol
    
  | edge_indicator

  )+
  
;

current_state 
: level_symbol
;

level_symbol 
: UDP_0 | UDP_1 | UDP_X | QUESTION | UDP_B
;

edge_indicator
: LPAREN
  level_symbol
  level_symbol
  RPAREN
| edge_symbol
;

edge_symbol 
: UDP_F | UDP_R
| UDP_N  | UDP_P  | STAR
;

next_state 
: output_symbol | MINUS
;

output_symbol 
: UDP_0 | UDP_1 | UDP_X
;

continuous_assign 
: K_ASSIGN 
  (LPAREN drive_strength RPAREN)? 
  (delay3)?
  list_of_net_assignments 
  SEMI
;

list_of_net_assignments 
: net_assignment 
  (COMMA net_assignment)*
;

assignment 
: lvalue 
  ASSIGN 
  expression
  
;

net_assignment 
: assignment
;

initial_construct 
: K_INITIAL attrs_opt statement
;

always_construct 
: K_ALWAYS attrs_opt statement
;

blocking_or_nonblocking_assignment 
: variable_lvalue

  (ASSIGN | LE | unexpected)
  (delay_or_event_control)?
  expression
  
;

procedural_continuous_assignments 
: (K_ASSIGN variable_assignment)
| (K_DEASSIGN variable_lvalue)
| (K_FORCE variable_or_net_assignment)
| (K_RELEASE net_or_variable_lvalue)
;

variable_assignment 
: assignment 
;

variable_or_net_assignment 
: assignment
;

par_block 
  
: K_FORK
  (COLON block_identifier  )?
  ( attrs_opt 
    ( block_item_declaration 

    | statement 
    )
  )*
  K_JOIN
  
;

seq_block 
  
: K_BEGIN
    ( COLON block_identifier  )?
    ( attrs_opt 
      ( block_item_declaration

      | statement 
      )
    )*
    K_END
  
;

statement 
:  blocking_or_nonblocking_assignment SEMI
| case_statement
| conditional_statement
| disable_statement
| event_trigger
| loop_statement
| par_block
| procedural_continuous_assignments SEMI
| procedural_timing_control_statement
| seq_block
| system_task_enable
| task_enable
| wait_statement
| SEMI
;

statement_or_null 
: ( 

  statement

  )
  
;

function_statement 
: statement
;

delay_control 
: POUND
  ( delay_value
  | LPAREN mintypmax_expression RPAREN
  )
  
;
    
delay_or_event_control 
: delay_control
| event_control
| K_REPEAT 
  LPAREN 
  expression 
  RPAREN 
  event_control
;

disable_statement 
: K_DISABLE 
  hierarchical_identifier 
  SEMI
;

event_control 
: AT
  ( hierarchical_identifier
  | LPAREN event_expression RPAREN
  | STAR 
  | SUPERSTAR
  )
  
;

event_trigger 
: TRIGGER 
  expr_primary_identifier_no_range 
  SEMI
  
;

event_expression 
: list_of_event_expression
;

list_of_event_expression 
: or_event_expression
  (COMMA or_event_expression)*
;

or_event_expression 
: event_expression_primary
  (K_OR event_expression_primary)*
  
;

event_expression_primary 
: expression
| K_POSEDGE expression
| K_NEGEDGE expression
;

procedural_timing_control 
: delay_control
| event_control
;

procedural_timing_control_statement 
: procedural_timing_control
  attrs_opt 
  statement_or_null
;

wait_statement 
: K_WAIT 
  LPAREN 
  expression 
  RPAREN 
  attrs_opt 
  statement_or_null
;

conditional_statement 
: K_IF 
  LPAREN 
  expression 
  RPAREN
  attrs_opt 
  statement_or_null
  ( options  
  : K_ELSE attrs_opt statement_or_null
  )?
;

case_statement 
: (K_CASE | K_CASEZ | K_CASEX)
  LPAREN expression RPAREN
  (case_item)+
  K_ENDCASE
  
;

case_item 
: ( expression_list COLON
  | K_DEFAULT (COLON)?
  )
  attrs_opt 
  statement_or_null
  
;

loop_statement 
: ( K_FOREVER attrs_opt statement
| K_REPEAT LPAREN expression RPAREN attrs_opt statement
| K_WHILE LPAREN expression RPAREN attrs_opt statement
| K_FOR LPAREN variable_assignment SEMI expression
  SEMI variable_assignment RPAREN attrs_opt statement
)

;

system_task_enable 
: system_function_name
  (LPAREN (expression)? (COMMA (expression)?)* RPAREN)?

  SEMI
  
;

task_enable 
: hierarchical_identifier
  (LPAREN expression (COMMA expression)* RPAREN)?
  SEMI
  
;

specify_block 
: K_SPECIFY
  (specify_item)*
  K_ENDSPECIFY
;

specify_item 
: specparam_declaration
| pulsestyle_declaration
| showcancelled_declaration
| path_declaration
| system_timing_check
;

pulsestyle_declaration 

: K_PULSESTYLE_ONEVENT canBeSimple=list_of_path_outputs SEMI
| K_PULSESTYLE_ONDETECT canBeSimple=list_of_path_outputs SEMI
;

showcancelled_declaration 

: K_SHOWCANCELLED canBeSimple=list_of_path_outputs SEMI
| K_NOSHOWCANCELLED canBeSimple=list_of_path_outputs SEMI
;

path_declaration 
: simple_or_edge_sensitive_path_declaration SEMI
| state_dependent_path_declaration SEMI
;

simple_or_edge_sensitive_path_declaration
   
: LPAREN
  (edge_identifier )?
  canBeSimple=list_of_path_inputs
  (hasColon=polarity_operator )?
  ( PPATH 

  | FPATH
    
  )
  ( test=parallel_or_full_path_description 

  | parallel_or_full_edge_sensitive_path_description

  )
  RPAREN
  ASSIGN 
  path_delay_value
  
;

parallel_or_full_path_description
: canBeSimple=list_of_path_outputs
;

list_of_path_inputs
: canBeSimple=list_of_path_terminals
;

list_of_path_outputs
: canBeSimple=list_of_path_terminals
;

list_of_path_terminals
: specify_terminal_descriptor
  
  ( COMMA 
    specify_terminal_descriptor
    
  )*
;

specify_terminal_descriptor 
: identifier 
  (LBRACK constant_range_expression RBRACK)?
  
;

path_delay_value 
:  LPAREN list_of_path_delay_expressions RPAREN
| list_of_path_delay_expressions
;

list_of_path_delay_expressions 
  
: path_delay_expression
  (COMMA path_delay_expression  )*

;

path_delay_expression 
: constant_mintypmax_expression
;

parallel_or_full_edge_sensitive_path_description
  
: LPAREN
  test=list_of_path_outputs

  ( PO_POS
  | PO_NEG
  )?
  COLON 
  data_source_expression
  RPAREN
;

data_source_expression :
 expression ;

edge_identifier 
: K_POSEDGE
| K_NEGEDGE
;

state_dependent_path_declaration 
: K_IF 
  LPAREN 
  module_path_expression 
  RPAREN
  simple_or_edge_sensitive_path_declaration
| K_IFNONE 
  simple_or_edge_sensitive_path_declaration

;

module_path_expression 
: expression 
;

polarity_operator

: ( PLUS 
  | MINUS 
  | PO_POS  
  | PO_NEG  )
  
  ( tok=COLON 
    
  )?

;

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

setup_timing_check 
: K_S_SETUP
  LPAREN
  data_event
  COMMA reference_event
  COMMA timing_check_limit
  (COMMA (notify_reg)?)?

  RPAREN
  SEMI
;

hold_timing_check 
: K_S_HOLD
  LPAREN
  reference_event
  COMMA data_event
  COMMA timing_check_limit
  (COMMA (notify_reg)?)?
  RPAREN
  SEMI
;

setuphold_timing_check 
: K_S_SETUPHOLD
  LPAREN
  reference_event
  COMMA data_event
  COMMA timing_check_limit
  COMMA timing_check_limit
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
  RPAREN
  SEMI
;

recovery_timing_cehck 
: K_S_RECOVERY
  LPAREN
  reference_event
  COMMA data_event
  COMMA timing_check_limit
  (COMMA (notify_reg)?)?
  RPAREN
  SEMI
;

removal_timing_check 
: K_S_REMOVAL
  LPAREN
  reference_event
  COMMA data_event
  COMMA timing_check_limit
  (COMMA (notify_reg)?)?
  RPAREN
  SEMI
;

recrem_timing_check 
: K_S_RECREM
  LPAREN
  reference_event
  COMMA data_event
  COMMA timing_check_limit
  COMMA timing_check_limit
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
  RPAREN
  SEMI
;

skew_timing_check 
: K_S_SKEW
  LPAREN
  reference_event
  COMMA data_event
  COMMA timing_check_limit
  (COMMA (notify_reg)?)?
  RPAREN
  SEMI
;

timeskew_timing_check 
: K_S_TIMESKEW
  LPAREN
  reference_event
  COMMA data_event
  COMMA timing_check_limit
  (COMMA (notify_reg)?
    (COMMA (event_based_flag)?
      (COMMA (remain_active_flag)?
      )?
    )?    
  )?
  RPAREN
  SEMI
;

fullskew_timing_check 
: K_S_FULLSKEW
  LPAREN
  reference_event
  COMMA data_event
  COMMA timing_check_limit
  COMMA timing_check_limit
  (COMMA (notify_reg)?
    (COMMA (event_based_flag)?
      (COMMA (remain_active_flag)?
      )?
    )?    
  )?
  RPAREN
  SEMI
;

period_timing_check 
: K_S_PERIOD
  LPAREN
  controlled_reference_event
  COMMA timing_check_limit
  (COMMA (notify_reg)?)?
  RPAREN
  SEMI
;

width_timing_check 
: K_S_WIDTH
  LPAREN
  controlled_reference_event
  COMMA timing_check_limit
  (COMMA (threshold)? 
    (COMMA (notify_reg)? )? 
  )?
  RPAREN
  SEMI
;

nochange_timing_check 
: K_S_NOCHANGE
  LPAREN
  reference_event
  COMMA data_event
  COMMA start_edge_offset
  COMMA end_edge_offset
  (COMMA (notify_reg)?)?
  RPAREN
  SEMI
;

checktime_condition 
: mintypmax_expression
;

controlled_reference_event 
: controlled_timing_check_event 
;

data_event 
: timing_check_event 
;

delayed_data 
: delayed_data_or_reference 
;

delayed_reference 
: delayed_data_or_reference 
;

delayed_data_or_reference 
: terminal_identifier
  (LBRACK constant_mintypmax_expression RBRACK)?
  
;

end_edge_offset 
: mintypmax_expression 
;

event_based_flag 
: constant_expression 
;

notify_reg 
: variable_identifier 
;

reference_event 
: timing_check_event 
;

remain_active_flag 
: constant_mintypmax_expression 
;

stamptime_condition 
: mintypmax_expression 
;

start_edge_offset 
: mintypmax_expression 
;

threshold 
: constant_expression 
;

timing_check_limit 
: expression 
;

timing_check_event 
: (timing_check_event_control)?
  specify_terminal_descriptor
  (TAND timing_check_condition)?
  
;

controlled_timing_check_event 
: timing_check_event_control
  specify_terminal_descriptor
  (TAND timing_check_condition)?
  
;

timing_check_event_control 
: K_POSEDGE
| K_NEGEDGE
| edge_control_specifier
;

edge_control_specifier 
: K_EDGE
  LBRACK
  edge_descriptor (COMMA edge_descriptor)*
  RBRACK
;

edge_descriptor 
: UNSIGNED_NUMBER
| IDENTIFIER
| EDGE_DESC
;

timing_check_condition 
: scalar_timing_check_condition
;

scalar_timing_check_condition 
: expression
;

concatenation 
: LCRULY
  ( expression
    ( (COMMA expression)*
      
    | concatenation
      
    )
  )
  RCRULY
;

function_call 
: hierarchical_function_identifier
  attrs_opt
  LPAREN expression_list RPAREN
  
;

system_function_call 
: system_function_name 
  (LPAREN expression_list RPAREN)?
  
;

expression_list 
: expression 
  (COMMA expression)*
  
;

range_expression 
: expression
  ( ( COLON expression
    | PO_POS expression
    | PO_NEG expression
    )
    
  )?
;

mintypmax_expression 
: expression 
  ( COLON expression COLON expression )?
  
;

pure_mintypmax_expression 
: expression 
  COLON 
  expression 
  COLON 
  expression
  
;

expression 
: conditional_expr
  
;

conditional_expr 
: logical_or_expr
  (QUESTION attrs_opt conditional_expr COLON conditional_expr)?
;

logical_or_expr 
: logical_and_expr (LOR attrs_opt logical_and_expr)*
;

logical_and_expr 
: or_expr (LAND attrs_opt or_expr)*
;

or_expr 
: xor_expr ((OR | NOR) attrs_opt xor_expr)*
;

xor_expr 
: and_expr ((XOR | XNOR) attrs_opt and_expr)*
;

and_expr 
: equality_expr ((AND | NAND) attrs_opt equality_expr)*
;

equality_expr 
: relational_expr
  ((EQUAL | NOT_EQ | NOT_EQ_CASE | EQ_CASE) attrs_opt relational_expr)*
;

relational_expr 
: shift_expr ((LT_ | GT | LE | GE) attrs_opt shift_expr)*
;

shift_expr 
: addictive_expr ((SL | SSL | SR | SSR) attrs_opt addictive_expr)*
;

addictive_expr 
: multiplicative_expr ((PLUS | MINUS) attrs_opt multiplicative_expr)*
;

multiplicative_expr 
: pow_expr ((STAR | DIV | MOD) attrs_opt pow_expr)*
;

pow_expr 
: unary_expr
  (
  | POW attrs_opt pow_expr
  )
;

unary_expr 
  
: expr_primary
|  LPAREN
  ex1=expression 
  ( COLON 
    ex2=expression 
    COLON 
    ex3=expression
    
    
  )?
  
  RPAREN
| PLUS  attrs_opt unary_expr 
| MINUS attrs_opt unary_expr 
| LNOT  attrs_opt unary_expr
| NOT   attrs_opt unary_expr
| AND   attrs_opt unary_expr 
| NAND  attrs_opt unary_expr 
| OR    attrs_opt unary_expr 
| NOR   attrs_opt unary_expr 
| XOR   attrs_opt unary_expr 
| XNOR  attrs_opt unary_expr 
;

expr_primary 
: ( number
  | STRING
  |  epi=expr_primary_identifier 
    
    ( attrs_opt 
      LPAREN 
      el=expression_list RPAREN
        
    )?
  | concatenation
  | system_function_call
  )
;

net_lvalue 
: lvalue 
;

variable_lvalue 
: lvalue 
;

net_or_variable_lvalue 
: lvalue 
;

lvalue 
: ( expr_primary_identifier
  | LCRULY 
    lvalue 
    (COMMA lvalue)* 
    RCRULY
  )
  
;

number 
: un=unsigned_number
  ( bn=based_number
    
  )?
| based_number
| real_number
;

unsigned_number 
: tok=UNSIGNED_NUMBER
  
;

based_number 
: tok=BASED_NUMBER
  
;

real_number 
: tok=REAL_NUMBER
  
;

attrs 
: (attribute_instance)+
;

attrs_opt 
: (attribute_instance)*
;

attribute_instance 
: PSTAR attr_spec (COMMA attr_spec)* STARP
  
;

attr_spec 
: attr_name 
  (ASSIGN constant_expression)?
  
;

attr_name 
: identifier 
;

identifier 
: ( IDENTIFIER
  | ESCAPED_IDENTIFIER 
  )
;

hierarchical_identifier 
: identifier 
  ((LBRACK constant_expression RBRACK)? DOT identifier)*
  
;

expr_primary_identifier
  
: identifier 
  ( LBRACK 
    rn1=range_expression 

    RBRACK
  )*
  ( DOT 
    identifier

    ( LBRACK 
      rn2=range_expression

      RBRACK
    )*
  )*
  
;

expr_primary_identifier_no_range
: identifier 
  (LBRACK expression RBRACK)*
  ( DOT 
    identifier 
    ( LBRACK 
      expression
      RBRACK
    )*
  )*
  
;

system_function_name
: SYSTEM_TASK_NAME
;

hierarchical_function_identifier 
: hierarchical_identifier 
;

hierarchical_parameter_identifier 
: hierarchical_identifier 
;

module_identifier 
: identifier 
;

port_identifier 
: identifier 
;

parameter_identifier 
: identifier 
;

specparam_identifier 
: identifier 
;

net_identifier 
: identifier 
;

variable_identifier 
: identifier 
;

event_identifier 
: identifier 
;

genvar_identifier 
: identifier 
;

block_identifier 
: identifier 
;

task_identifier 
: identifier 
;

function_identifier 
: identifier 
;

gate_instance_identifier 
: identifier 
;

module_instance_identifier 
: identifier 
;

generate_block_identifier 
: identifier 
;

terminal_identifier 
: identifier 
;

udp_identifier 
: identifier
;

dimension_constant_expression 
: expression 
;

msb_constant_expression 
: expression 
;

lsb_constant_expression 
: expression 
;

constant_expression 
: expression 
;

constant_range_expression 
: range_expression 
;

constant_mintypmax_expression 
: mintypmax_expression 
;

