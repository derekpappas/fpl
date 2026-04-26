// Mechanical trunk port (syntax-only). Maven also generates {@code CslParser.g4} as the small stub entry.
//
// ANTLR4 Java port of legacy ANTLR2/C++ parser grammar.
// Source: /Users/derekpappas/fpl/trunk/cslc/trunk/src/parser/csl/csl.parser.g (from first rule line 1924).
// C++ actions, AST construction, and exception/catch handlers were removed (syntax-only port).
// Regenerate with: scripts/port_trunk_parser_g_to_g4.py

parser grammar CslParserTrunkPort;

options { tokenVocab = CslLexer; }

source_text 

:

  (description)* 
  EOF
;

description

:

(
 csl_command
 | csl_declaration
 | preprocessor_directive 
 | tok=SEMI
 | unexpected
)

;

unexpected

:

( 
 UNSIGNED_NUMBER
 | NZ_UNSIGNED_NUMBER
 | REAL_NUMBER
 | REAL_NUMBER_EXP
 | TICK
 | BACKTICK
 | AT
 | COLON
 | COMMA
 | LBRACK
 | RBRACK

 | RCURLY
 | LPAREN
 | RPAREN
 | QUESTION
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
 | LE
 | GT
 | GE
 | SL
 | SSL
 | SR
 | SSR
 | TRIGGER
 | PPATH
 | FPATH
 | PSTAR
 | STARP
 | PO_POS
 | PO_NEG
 | SUPERSTAR
)

;

preprocessor_directive

:
(
 pd=POUND

 str=STRING 
 un=UNSIGNED_NUMBER

               

)
;

csl_declaration

:

(
(dec1=K_CSL_UNIT                            csl_unit_declaration                                                          
 |  dec2=K_CSL_SIGNAL                        csl_signal_declaration                                                       
 |  dec3=K_CSL_PORT                          csl_port_declaration                                                         
 |  dec4=K_CSL_BITRANGE                      csl_bitrange_declaration                                                     
 |  dec5=K_CSL_SIGNAL_GROUP                  csl_signal_group_declaration                                                 
 |  dec6=K_CSL_INTERFACE                     csl_interface_declaration                                                    
 |  dec7=K_CSL_LIST                          csl_list_declaration                   
 |  dec8=K_CSL_REGISTER_FILE                 csl_register_file_declaration                                                
 |  dec9=K_CSL_TESTBENCH                     csl_testbench_declaration                                                    

 | dec13=K_CSL_INCLUDE                       csl_include_declaration                                                      
 | dec14=K_CSL_ISA_FIELD                     csl_isa_field_declaration                                                    
 | dec15=K_CSL_ISA_ELEMENT                   csl_isa_element_declaration                                                  
 | dec16=K_CSL_ENUM                          csl_enum_declaration                                                         
 | dec17=K_CSL_FIELD                         csl_field_declaration                                                        
 | dec18=K_CSL_FIFO                          csl_fifo_declaration                                                         
 | dec19=K_CSL_MEMORY_MAP                    csl_memory_map_declaration                                                   
 | dec20=K_CSL_MEMORY_MAP_PAGE               csl_memory_map_page_declaration                                              
 | dec21=K_CSL_REGISTER                      csl_register_declaration                                                     
 | dec22=K_CSL_READ_INTERFACE                csl_read_interface_declaration                                               
 | dec23=K_CSL_WRITE_INTERFACE               csl_write_interface_declaration                                              
 | dec24=K_CSL_STATE_DATA                    csl_state_data_declaration                                                   
 | dec25=K_CSL_VECTOR                        csl_vector_declaration                                                       
 | dec26=K_CSL_MEMORY                        csl_memory_declaration                                                       
 | dec27=K_CSL_MULTI_DIM_BITRANGE            csl_multi_dim_bitrange_declaration                                           
 | dec28=K_CSL_PIPELINE                      csl_pipeline_declaration                                                     
 | dec29=K_CSL_PIPESTAGE                     csl_pipestage_declaration                                                    
 | dec30=K_CONST                             csl_const_int_declaration                                                    
 | dec31=K_CSL_PARAMETER                     csl_parameter_declaration                                                    

)

    SEMI
)
;

csl_read_interface_declaration

:

( id=IDENTIFIER       )
;

csl_write_interface_declaration

:

( id=IDENTIFIER   )
;

csl_state_data_declaration

:

( id=IDENTIFIER  
  ( COMMA     
    id2=IDENTIFIER

    

  )*
  (  csl_unit_definition    )?

 

)
;

csl_vector_declaration

:

( id=IDENTIFIER    
 ( COMMA     
   id2=IDENTIFIER

 

 )*
  (  csl_unit_definition   )?

 

)
;

csl_memory_declaration

:

( id=IDENTIFIER   
  ( COMMA    
    id2=IDENTIFIER

  

 )*
  (     csl_unit_definition    )?

 

)
;

csl_isa_field_declaration

:

( id=IDENTIFIER 
  ( LPAREN 

  

    exp1=expression  
    ( COMMA exp2=expression   
      ( COMMA exp3=expression

       

       )? 
    )?
    RPAREN
  )?
  ( COMMA  
    id2=IDENTIFIER    
    ( LPAREN 
      exp4=expression   
      ( COMMA exp5=expression   
        ( COMMA exp6=expression
          
        
          
        )? 
      )?
      RPAREN
    )?
    
  

  )*
  (  csl_unit_definition  )?

 
)
;

csl_isa_element_declaration

:

( id=IDENTIFIER

 

  ( col=COLON  id2=IDENTIFIER

  

  )?
  (  csl_unit_definition    )
)
;

csl_enum_declaration

:

( id=IDENTIFIER   

 

  LCURLY  (  csl_enum_declaration_item  (  COMMA  csl_enum_declaration_item  )*  )?  RCURLY 
)
;

csl_enum_declaration_item

:

(  id=IDENTIFIER

 

   ( as=ASSIGN 
     ( exp=expression

       

     )  
   )?
)
;

csl_field_declaration

:

( id=IDENTIFIER 
  ( LPAREN 

  

    exp1=expression  
    ( COMMA exp2=expression   
      ( COMMA exp3=expression 

       

       )? 
    )?
    RPAREN
  )?
  ( COMMA  
    id2=IDENTIFIER    
    ( LPAREN 
      exp4=expression   
      ( COMMA exp5=expression   
        ( COMMA exp6=expression
          
        
          
        )? 
      )?
      RPAREN
    )?
    
  

  )*
  (  csl_unit_definition  )?

 
)
;

csl_include_declaration

:

( LPAREN 
  ( id=IDENTIFIER

  

  ) 
  com=COMMA  exp=expression
  
 

 RPAREN
)
;

csl_testbench_declaration

:

( id=IDENTIFIER   
  ( COMMA  id2=IDENTIFIER
  
  

   )*
  (   csl_unit_definition   )?

 

)
;

csl_fifo_declaration

:

(  id=IDENTIFIER  
   (  COMMA id2=IDENTIFIER 

   

   )*
   (  csl_unit_definition  )? 

 
   
)
;

csl_register_file_declaration

:

(  id=IDENTIFIER  
  (  COMMA  id2=IDENTIFIER 

  

  )*
   (  csl_unit_definition     )?

 

)
;      

csl_memory_map_declaration

:

(  id=IDENTIFIER  
  ( COMMA  id2=IDENTIFIER

  

  )*
   (  csl_unit_definition    )?

 

)
;  

csl_memory_map_page_declaration

:

( id=IDENTIFIER  
  ( COMMA  id2=IDENTIFIER 

  

  )?

  (  csl_unit_definition   )?

 

)
;

csl_register_declaration

:

( id=IDENTIFIER  
  ( COMMA  id2=IDENTIFIER

  

  )*
  (  csl_unit_definition    )?

 

)
;

csl_unit_declaration

:

( id1=IDENTIFIER    
  ( COMMA  id2=IDENTIFIER 

  

  )*  
  ( csl_unit_definition )?

 

)
;

csl_list_declaration

: 

(
 ( id=IDENTIFIER  
   
 

 )?
 ( isIdList=param_list_csl_list )?
   
 
 
 (  COMMA  id2=IDENTIFIER
   
 
 
  ( isIdList=param_list_csl_list  )?
 )*
)
;

param_list_csl_list

: 

(  LPAREN  
   exp=expression 

 

 ( COMMA  exp2=expression 
   
 

 )*
 RPAREN
)
;

csl_unit_definition

:

(  lc=LCURLY

 

   (  decl=csl_declaration  
      | ic=csl_inst_or_cstor

   

      | preprocessor_directive
      | SEMI
   )*

 

   RCURLY
)
;

csl_inst_or_cstor

:

(  id=IDENTIFIER

 

   (  inst=csl_inst

   
      |
      cstor=csl_cstor
   

   )

 

)
;

csl_inst

:

(
 ( parameter_overridding_instantiation )?

 id=IDENTIFIER

 

  ( lp1=LPAREN 
    ( param_list_formal_to_actual_mapping
      | 
      exp=expression

    
      
     )  RPAREN
   )? 
  ( COMMA   id2=IDENTIFIER

  

    ( lp2=LPAREN 
      ( param_list_formal_to_actual_mapping
        | 
        exp2=expression

      

       )  RPAREN
      )? 
    )* 
  SEMI
)
;

parameter_overridding_instantiation

:

( POUND 
   LPAREN
   ( 
     ( exp=expression  )?
   
      
     
     ( COMMA   
       ( exp2=expression  )? 
        )*
     |
     f2a=param_list_formal_to_actual_mapping 
   )
   RPAREN

 

)
;

csl_cstor

:

(  LPAREN  
   (  id1=IDENTIFIER    
      ( lp1=ASSIGN   exp=expression   )?

   
      
   ( COMMA  id2=IDENTIFIER 
     ( lp2=ASSIGN  exp2=expression   )?

   

    )*
  )?
   RPAREN  LCURLY
   ( csl_command                     
     | preprocessor_directive        
     | SEMI 
   )*
   RCURLY
)
;

csl_interface_declaration

    
: 

( id1=IDENTIFIER   
  ( COMMA  id2=IDENTIFIER
  
  

  )* 
  (   
    
  
    
    csl_unit_definition
  )?
  
 
)
;

csl_port_declaration 

:

 
( id1=IDENTIFIER
  
 

  ( LPAREN  param_list_csl_port   RPAREN  )
  ( COMMA  id2=IDENTIFIER

  

    ( LPAREN  param_list_csl_port   RPAREN  )
  )*
)
;

csl_signal_declaration

:

( id1=IDENTIFIER 

 

  ( LPAREN  param_list_csl_signal   RPAREN )?
  ( COMMA  id2=IDENTIFIER 
  
  

    ( LPAREN  param_list_csl_signal  RPAREN )?  
  )*
)
;

param_list_csl_port

: 

( exp1=expression

 

  ( COMMA  exp2=expression

  

    ( COMMA exp3=expression

    

      ( COMMA exp4=expression

      

       )?

     )?
  )?
)
;

param_list_csl_signal

:

( exp1=expression

 

  ( COMMA  ( exp2=expression
   
  

   ( COMMA exp3=expression

   
    
    )?
    |
     bitrange_pure 
    )
   )?
)?
;

csl_signal_group_declaration

    

: 

(  id=IDENTIFIER  
   ( COMMA   id2=IDENTIFIER
  
   

  )*
   (  csl_unit_definition     )?

 

)
;

csl_bitrange_declaration

: 

(  id=IDENTIFIER 
   ( LPAREN   exp=expression  
     ( COMMA  exp2=expression

     

      )?

   

    RPAREN 
   )?

 

   ( COMMA id2=IDENTIFIER 
     ( LPAREN   exp3=expression  
       ( COMMA  exp4=expression

       

       )?

     

       RPAREN 
      )?

   

   )*
)
;

csl_multi_dim_bitrange_declaration

:

(  id=IDENTIFIER  
   ( LPAREN  exp=expression 

   

     RPAREN  
   )?

 

   ( COMMA  id2=IDENTIFIER  
     LPAREN  exp2=expression

   

   RPAREN

   

  )*
)
;

csl_pipeline_declaration

:

(  id=IDENTIFIER  
   ( LPAREN  exp=expression

 

     RPAREN
   )?

 

   ( COMMA id2=IDENTIFIER 
     ( LPAREN exp2=expression

     

      )?

   

   )*
)
;

csl_pipestage_declaration

:

(  id=IDENTIFIER  

   ( COMMA id2=IDENTIFIER

   
)
)
;

csl_const_int_declaration

:

(  it=K_INT 

   id2=IDENTIFIER 
   (  as=ASSIGN   exp=expression

   

   )?

 

  ( COMMA  id3=IDENTIFIER  
    ( as2=ASSIGN   exp2=expression

    

    )?

  

  )*
)
;

csl_parameter_declaration

:

( id=IDENTIFIER 

  LPAREN  exp1=expression

 

  ( COMMA  exp2=expression  

  
    
 )?

  RPAREN

 

 ( COMMA id2=IDENTIFIER 

  LPAREN  exp3=expression

 

  ( COMMA  exp4=expression 

  

  )?

  RPAREN

  

  )*
)
;

csl_command

:

(

 (
  id=IDENTIFIER

 

  ( LBRACK re=range_expression 

    

    RBRACK
   )?

  |
 
  ex=concatenation
 
 
  
 )

 ( dot=DOT  

    

 )? 
)*
 ( ( 
     (  com0=K_ADD_PORT_LIST                                                    param_list_add_port_list                              
        |   com1=K_SET_TYPE                                                     param_list_set_type                                   
        |   com2=K_SET_ATTR                                                     param_list_set_attr                                   
        |   com3=K_SET_UNIT_PREFIX                                              param_list_set_unit_prefix                            
        |   com4=K_SET_SIGNAL_PREFIX                                            param_list_set_signal_prefix                          
        |   com5=K_SET_SIGNAL_PREFIX_LOCAL                                      param_list_set_signal_prefix_local                    
        |   com6=K_SET_DEPTH                                                    param_list_set_depth                                  
        |   com7=K_CREATE_RTL_MODULE                                            param_list_create_rtl_module                          

        |  com10=K_DIRECTIVE                                                    param_list_directive                                  
        |  com11=K_SET_WIDTH                                                    param_list_set_width                                  
        |  com12=K_SET_DIM_WIDTH                                                param_list_set_dim_width                              
        |  com13=K_SET_BITRANGE                                                 param_list_set_bitrange                               
        |  com14=K_SET_DIM_BITRANGE                                             param_list_set_dim_bitrange                           
        |  com15=K_SET_RANGE                                                    param_list_set_range                                  
        |  com16=K_SET_DIM_RANGE                                                param_list_set_dim_range                              
        |  com19=K_SET_OFFSET                                                   param_list_set_offset                                 
        |  com20=K_SET_DIM_OFFSET                                               param_list_set_dim_offset                             
        |  com21=K_SET_NUMBER_OF_DIMENSIONS                                     param_list_set_number_of_dimensions                   
        |  com22=K_REVERSE                                                      param_list_reverse                                    

        |  com25=K_SET_INSTANCE_ALTERATION_BIT                                  param_list_set_instance_alteration_bit                

        |  com28=K_SET_TESTBENCH_VERILOG_FILENAME                               param_list_set_testbench_verilog_filename             

        |  com31=K_SET_VC_COMPARE_TRIGGER                                       param_list_set_vc_compare_trigger                     

        |  com37=K_SET_NAME                                                     param_list_set_name                                   

        |  com39=K_SET_DIRECTION                                                param_list_set_direction                              
        |  com40=K_EXCLUSION_LIST                                               param_list_exclusion_list                             
        |  com41=K_INCLUDE_ONLY                                                 param_list_include_only                               

        |  com45=K_SET_RADIX                                                    param_list_set_radix                                  

        |  com47=K_SET_TOP_UNIT                                                 param_list_set_top_unit                               
        |  com48=K_ADD                                                          param_list_add                                        
        |  com49=K_ADD_ADDRESS_RANGE                                            param_list_add_address_range                          
        |  com50=K_ADD_RESERVED_ADDRESS_RANGE                                   param_list_add_reserved_address_range                 
        |  com51=K_SET_DATA_WORD_WIDTH                                          param_list_set_data_word_width                        
        |  com52=K_SET_ADDRESS_INCREMENT                                        param_list_set_address_increment                      
        |  com53=K_SET_NEXT_ADDRESS                                             param_list_set_next_address                           
        |  com54=K_SET_ALIGNMENT                                                param_list_set_alignment                              
        |  com55=K_SET_PREFIX                                                   param_list_set_prefix                                 
        |  com56=K_SET_SUFFIX                                                   param_list_set_suffix                                 
        |  com57=K_SET_ENDIANESS                                                param_list_set_endianess                              
        |  com58=K_AUTO_GEN_MEMORY_MAP                                          param_list_auto_gen_memory_map                        
        |  com59=K_ADD_TO_MEMORY_MAP                                            param_list_add_to_memory_map                          

        |  com61=K_SET_ACCESS_RIGHTS                                            param_list_set_access_rights                          
        |  com62=K_SET_ACCESS_RIGHTS_ENUM                                       param_list_set_access_rights_enum                     
        |  com63=K_SET_SYMBOL_MAX_LENGTH                                        param_list_set_symbol_max_length                      
        |  com64=K_SET_ENUM                                                     param_list_set_enum                                   
        |  com65=K_SET_ENUM_ITEM                                                param_list_set_enum_item                              
        |  com66=K_SET_MNEMONIC                                                 param_list_set_mnemonic                               

        |  com71=K_GEN_DECODER                                                  param_list_gen_decoder                                
        |  com72=K_SET_PHYSICAL_IMPLEMENTATION                                  param_list_set_physical_implementation                
        |  com73=K_SET_VALUE                                                    param_list_set_value                                  
        |  com74=K_SET_FIELD                                                    param_list_set_field                                  
        |  com75=K_SET_FIELD_POSITION                                           param_list_set_field_position                         
        |  com76=K_SET_POSITION                                                 param_list_set_position                               
        |  com77=K_SET_NEXT                                                     param_list_set_next                                   
        |  com78=K_SET_PREVIOUS                                                 param_list_set_previous                               

        |  com80=K_ADD_ALLOWED_RANGE                                            param_list_add_allowed_range                          
        |  com81=K_SET_ATTRIBUTES                                               param_list_set_attributes                             

        |  com89=K_ADD_LOGIC                                                    param_list_add_logic                                  

        |  com98=K_SET_VC_START_GENERATION_TRIGGER                              param_list_set_vc_start_generation_trigger            

        | com102=K_SET_UNIT_NAME                                                param_list_set_unit_name                              

        | com107=K_PIPESTAGE_NAMING_CONVENTION                                  param_list_pipestage_naming_convention                

        | com121=K_MERGE                                                        param_list_merge                                      

        | com125=K_SET_VC_NAME                                                  param_list_set_vc_name                                
        | com126=K_SET_VC_HEADER_COMMENT                                        param_list_set_vc_header_comment                      
        | com127=K_SET_VERSION                                                  param_list_set_version                                
        | com128=K_SET_VC_CLOCK                                                 param_list_set_vc_clock                               
        | com129=K_SET_VC_RESET                                                 param_list_set_vc_reset                               
        | com130=K_SET_VC_STALL                                                 param_list_set_vc_stall                               
        | com131=K_SET_VC_END_GENERATION_TRIGGER                                param_list_set_vc_end_generation_trigger              
        | com132=K_SET_VC_CAPTURE_EDGE_TYPE                                     param_list_set_vc_capture_edge_type                   

        | com134=K_SET_VC_MAX_NUMBER_OF_MISMATCHES                              param_list_set_vc_max_number_of_mismatches            
        | com135=K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS                      param_list_set_vc_max_number_of_valid_transactions    
        | com136=K_SET_VC_VALID_OUTPUT_TRANSACTION                              param_list_set_vc_valid_output_transaction            

        | com138=K_SET_VC_OUTPUT_FILENAME                                       param_list_set_vc_output_filename                     

        | com141=K_SET_VC_MAX_CYCLES                                            param_list_set_vc_max_cycles                          
        | com142=K_SET_MEM_INSTANCE_NAME                                        param_list_set_mem_instance_name                      
        | com143=K_SET_RESET_NAME                                               param_list_set_reset_name                             
        | com144=K_SET_CLOCK_NAME                                               param_list_set_clock_name                             
        | com145=K_SET_RD_CLOCK_NAME                                            param_list_set_rd_clock_name                          
        | com146=K_SET_WR_CLOCK_NAME                                            param_list_set_wr_clock_name                          
        | com147=K_SET_PUSH_NAME                                                param_list_set_push_name                              
        | com148=K_SET_POP_NAME                                                 param_list_set_pop_name                               
        | com149=K_SET_FULL_NAME                                                param_list_set_full_name                              
        | com150=K_SET_EMPTY_NAME                                               param_list_set_empty_name                             
        | com151=K_SET_WR_DATA_NAME                                             param_list_set_wr_data_name                           
        | com152=K_SET_RD_DATA_NAME                                             param_list_set_rd_data_name                           
        | com153=K_SET_VALID_NAME                                               param_list_set_valid_name                             
        | com154=K_SET_WR_ADDR_NAME                                             param_list_set_wr_addr_name                           
        | com155=K_SET_RD_ADDR_NAME                                             param_list_set_rd_addr_name                           
        | com156=K_SET_WR_EN_NAME                                               param_list_set_wr_en_name                             
        | com157=K_SET_RD_EN_NAME                                               param_list_set_rd_en_name                             

        | com163=K_INITIALIZE_RANDOM_VALUES                                     param_list_initialize_random_values                   
        | com164=K_INITIALIZE_RANDOM                                            param_list_initialize_random                          
        | com165=K_SET_UNIT_ID                                                  param_list_set_unit_id                                

        | com168=K_SET_NUM_RD_IFC                                               param_list_set_num_rd_ifc                             
        | com169=K_SET_NUM_WR_IFC                                               param_list_set_num_wr_ifc                             
        | com170=K_GEN_UNIQUE_RTL_MODULES                                       param_list_gen_unique_rtl_modules                     
        | com171=K_NO_PREFIX_COMMAND                                            param_list_no_prefix                                  
        | com172=K_OVERRIDE_PARAMETER                                           param_list_override_parameter                         
        | com173=K_DO_NOT_GEN_RTL                                               param_list_do_not_gen_rtl                             
        | com174=K_DO_NOT_GEN_CPP                                               param_list_do_not_gen_cpp                             
        | com175=K_SET_CLOCK                                                    param_list_set_clock                                  
        | com176=K_REGISTER_IOS                                                 param_list_register_ios                               
        | com177=K_CONNECT_UNITS                                                param_list_connect_units                              
        | com178=K_CONNECT_BY_PATTERN                                           param_list_connect_by_pattern              
        | com179=K_CONNECT_BY_NAME                                              param_list_connect_by_name                 
   )
              
   

  )     
  |     
   (  /*{ hasId }?*/  ass=ASSIGN  csl_statement_assign   
   
   
  
   )     
)

SEMI
;

csl_statement_assign

:

(  exp=expression

 

)
;

param_list_directive

:

( lp=LPAREN

 

  ( id=IDENTIFIER
  
  

 )
 RPAREN
)
;

param_list_set_physical_implementation

:

(  lp1=LPAREN

 

  ( id=IDENTIFIER
  
  

  )
   RPAREN
)
;
 

param_list_set_value    

:

( lp=LPAREN

 

  exp=expression  

 

 RPAREN
)
;

param_list_set_enum_item 

:

(  lp=LPAREN

 

  exp1=expression

  
 
 RPAREN
)
;

param_list_set_field    

:

(  lp1=LPAREN
  
  

  ( exp=expression

  

 )
 lp2=COMMA  exp2=expression
 
 

 RPAREN
)
;

param_list_set_position

:

(  lp=LPAREN

 

   exp=expression
   
 
 
   COMMA   exp2=expression
 
 

 RPAREN
)
;

param_list_set_field_position

:

( lp=LPAREN
  
 
 
  exp=expression
  
 

  COMMA  exp2=expression
 
 

 RPAREN
)
;

param_list_set_next    

:

( lp=LPAREN

 

  exp=expression
    
 
 
  COMMA  exp2=expression

 

 RPAREN
)
;

param_list_set_previous    

:

( lp=LPAREN

 
 
  exp=expression
    
 
 
  COMMA  exp2=expression
    
 

 RPAREN
)
;

param_list_add_allowed_range

:

( lp=LPAREN

 

  exp=expression
 
 
 
  COMMA   exp2=expression
  
 
 
 RPAREN
)
;

param_list_set_attributes

:

( lp=LPAREN

 

  exp=expression

 
 

 RPAREN
)
;

param_list_add_logic

:

(  lp=LPAREN

 

 ( exp=expression

 

 )
 RPAREN
)
;

  add_logic_neg_output

:

(
 
 

 RPAREN
)
;

add_logic_serial_input

:

(

 

 RPAREN
)
;

add_logic_serial_output

:

(
 
 

 RPAREN
)
;

add_logic_clock

:

(

 

 ( COMMA expression  COMMA expression  COMMA expression  )?

 

 RPAREN
)
;

add_logic_generate_report

:

(

 

 ( COMMA exp=expression

 

 )?
 
 RPAREN
)
;

add_logic_async_reset

:

(

 

 RPAREN
)
;

add_logic_init

:

(

 

 ( COMMA  expression  )?

 

 RPAREN
)
;

add_logic_clear

:

(

 

 ( COMMA  expression  )?

 

 RPAREN
)
;

add_logic_stop

:

(

 

 COMMA  exp=expression

 

 RPAREN
)
;

add_logic_inject_stalls

:

(  
 
 

 RPAREN
)
;

add_logic_load

:

(

 

 RPAREN
)
;

add_logic_generate_waves

:

( lp=COMMA
  
 
 
  exp=expression
   
 
 
  COMMA  exp2=expression

 

   ( COMMA   exp3=expression

   
   
   )*

 RPAREN
)
;

add_logic_gray_output

:

(

 

 RPAREN
)
;

 add_logic_start_value

:

( lp=COMMA
 
 
 
  exp=expression
 
 

 RPAREN
)
;

add_logic_end_value

:

( lp=COMMA
 
 
 
  exp=expression
 
 

 RPAREN
)
;

add_logic_count_amount

:

( lp=COMMA
 
 
 
  exp=expression
 
 

 RPAREN
)
;

add_logic_count_direction

:

( lp=COMMA
  
 
 
  exp=expression
  
 

 RPAREN
)
;

add_logic_set

:

(

 

 ( COMMA  expression  )?

 

 RPAREN
)
;

add_logic_reset

:

(

 

 ( COMMA  expression  )?

 

 RPAREN
)
;

add_logic_programmable_depth

:

(  lp1=COMMA 

 

 exp1=expression
 
 

 RPAREN
)
;      

add_logic_priority_bypass

:

 

RPAREN
;

add_logic_sync_fifo

:

 
 
RPAREN
;

add_logic_async_fifo

:

  

RPAREN
;

add_logic_depth_extend

:

(  lp=COMMA

 

 exp=expression

 

RPAREN
)
;

add_logic_width_extend      

:

(  lp=COMMA 

 
 
 exp=expression
 
 
 
RPAREN
)
;

add_logic_wr_hold                                                               

:

( lp=COMMA 
 
 
 
 exp=expression
 
 

RPAREN
) 
;

add_logic_parallel_output

:

( lp1=COMMA 
 
 

( exp=expression

 

 |
 (  list=K_CSL_LIST  
    csl_list_declaration
  )
 )
 RPAREN
)
;

add_logic_parallel_input    

:

( lp1=COMMA 
 
 

( exp=expression

 

 |
 (  list=K_CSL_LIST  
    csl_list_declaration
  )
 )
 RPAREN
)
;

add_logic_rd_words

:

( lp1=COMMA

 

  exp1=expression
  
 

  COMMA  exp2=expression
 
 

  RPAREN
)
;

add_logic_wr_words          

:

( lp1=COMMA

 
 
  exp1=expression

 
 
 COMMA exp2=expression
 
 

 RPAREN
)
;

add_logic_sram_rd

:

(

 

RPAREN
)
;

add_logic_sram_wr

:

(  

 
  
 RPAREN
)
;

add_logic_pushback

:

(

 
 
 RPAREN
)
;

add_logic_flow_through      

:

( lp1=COMMA 
 
 
 
  exp1=expression
  
 
  
 RPAREN
)
;

add_logic_read_valid

:

(
 
 
 
 RPAREN
)
;

add_logic_stall
:

(  

 
 
 RPAREN
)
;

add_logic_stall_rd_side

:

(

 

 RPAREN
)
;

add_logic_stall_wr_side

:

(

 

 RPAREN
)
;

add_logic_wr_release

:

(

 
 
 RPAREN
)
;

add_logic_almost_empty      

:

( lp1=COMMA 
 
 
 
  exp1=expression

 
 
 RPAREN
)
;

add_logic_almost_full       

:

( lp1=COMMA 
 
 
 
  exp1=expression
  
 
 
 RPAREN
)
;

add_logic_output_wr_addr

:

(

 
 
 RPAREN
)
;

add_logic_output_rd_addr

:

(

 

 RPAREN
)
;

add_logic_credit

:

(

 
 
 RPAREN
)
;

add_logic_rd_credit

:

(

 
 
 RPAREN
)
;

add_logic_wr_credit

:

(

 

 RPAREN
)
;

add_logic_flow     
:

(

 

 RPAREN
)
;

param_list_set_vc_start_generation_trigger

:

( lp=LPAREN
  
 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_unit_name        

:

( lp=LPAREN
  
 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_pipestage_naming_convention

:

( lp=LPAREN

 
 
  exp=expression

 RPAREN
)
;

param_list_initialize_random_values

:

 ( lp=LPAREN
  
 
 
   exp=expression
 
 

 RPAREN
)
;

param_list_initialize_random

:

( lp=LPAREN

 

  exp=expression
  
 

 RPAREN
)
;

param_list_merge

:

( lp=LPAREN

 

  exp=expression

 

  ( COMMA exp2=expression

  

    ( COMMA exp3=expression

    

    )*

  )?
 
 RPAREN
)
;

param_list_gen_decoder

:

( lp=LPAREN

 

  (  exp=expression
  
  

 )?
 RPAREN
)
;

param_list_set_mnemonic

:

( lp=LPAREN

 
 
  
   exp=expression

 

 RPAREN
)
;

param_list_set_enum

:

( lp=LPAREN

 
  
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_address_increment

:

( lp=LPAREN
  
 

  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_next_address

:

( lp=LPAREN
  
 
 
  exp=expression
 
 

 RPAREN
)
;

param_list_set_alignment

:

( lp=LPAREN
  
 

  exp=expression
  
 

 RPAREN
)
;

param_list_set_prefix

:

( lp=LPAREN

 

  exp=expression

 

RPAREN
)
;

param_list_set_suffix

:

( lp=LPAREN
  
 

  exp=expression

 

 RPAREN
)
;

param_list_set_endianess

:

( lp=LPAREN
  
 

  exp=expression

 
  
 RPAREN
)
;

param_list_auto_gen_memory_map

:

( lp=LPAREN
  
 

 RPAREN
)
;

param_list_add_to_memory_map

:

( lp=LPAREN
  
 

  (  exp=expression  ( col=COLON  exp0=expression  )? 
     ( COMMA  exp2=expression    ( COMMA exp3=expression  )?  )?  )?

 

   
 RPAREN
)
;

param_list_set_mem_instance_name

:

( lp=LPAREN
  
 
 
  exp=expression
 
 

 RPAREN
)
;

param_list_set_reset_name

:

( lp=LPAREN

 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_clock_name

:

( lp=LPAREN

 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_rd_clock_name

:

( lp=LPAREN

 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_wr_clock_name

:

( lp=LPAREN
  
 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_push_name

:

( lp=LPAREN

 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_pop_name

:

( lp=LPAREN

 
 
  exp=expression
 
 

 RPAREN
)
;

param_list_set_full_name

:

( lp=LPAREN

 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_empty_name

:

( lp=LPAREN

 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_wr_data_name

:

( lp=LPAREN

 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_rd_data_name

:

( lp=LPAREN

 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_valid_name

:

( lp=LPAREN
  
 
  
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_wr_addr_name

:

( lp=LPAREN
  
 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_rd_addr_name

:

( lp=LPAREN
  
 
 
  exp=expression

 

 RPAREN
)
;

param_list_set_wr_en_name

:

( lp=LPAREN
  
 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_rd_en_name

:

( lp=LPAREN
  
 
 
  exp=expression
 
 

 RPAREN
)
;

param_list_set_access_rights

:

( lp=LPAREN

  

  exp=expression
  
 

  ( col=COLON  exp2=expression
  
  

  )?
  COMMA  exp3=expression
  
 

  COMMA  exp4=expression

 
 
 RPAREN
)
;

param_list_set_access_rights_enum
:

( lp=LPAREN

 

  exp=expression
 
 
  
 RPAREN
)
;

param_list_set_data_word_width

:

( lp=LPAREN

 

  exp=expression
 
 

 RPAREN
)
;

param_list_set_symbol_max_length

:

( lp=LPAREN
  
 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_top_unit

:

( lp=LPAREN
  
 

  exp=expression
  
 

 RPAREN
)
;

param_list_add

:

( lp=LPAREN
  
 
 
  exp=expression
 
 
  
  ( COMMA  exp2=expression
    
  

    ( COMMA  exp3=expression
     
    
    )?
  )?
 RPAREN
)
;

param_list_add_address_range

:

( lp=LPAREN
  
 
 
  exp=expression
  
 
 
  COMMA  exp2=expression
  
 

 RPAREN
)
;

param_list_add_reserved_address_range

:

( lp=LPAREN

 
 
  exp=expression
 
 

  COMMA   exp2=expression

 
 
 RPAREN
)
;

param_list_add_dut_instance
: LPAREN
  exp=expression

  COMMA
  id=IDENTIFIER
  
  RPAREN
;

param_list_set_name

:

( lp=LPAREN
  
 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_radix

: 

( lp=LPAREN
  
 

  exp=expression

 
 
 RPAREN
)
;

param_list_set_direction

:

( lp=LPAREN
  
 
 
  exp=expression

 
  
 RPAREN
)
;

param_list_exclusion_list

:

( lp=LPAREN

 
  
  exp=expression
 
 
 
  ( COMMA exp2=expression

  
  
  )*
 RPAREN
)
;

param_list_include_only

:

( lp=LPAREN
  
 

  exp=expression
  
 
 
  ( COMMA exp2=expression
   
  
  
  )*
 RPAREN
)
;

param_list_set_testbench_verilog_filename

:

( lp=LPAREN

 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_gen_indiv_rtl_sig

:
 
( lp=LPAREN
  
 
 
  exp=expression

 
  
 RPAREN
)
;

param_list_set_vc_compare_trigger

: 

(  lp=LPAREN

  

  exp=expression

RPAREN
)
;

param_list_set_vc_name

:

( lp=LPAREN

 
 
  exp=expression

 

 RPAREN
)
;

param_list_set_vc_header_comment

:

( lp=LPAREN

 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_version

:

( lp=LPAREN
  
 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_vc_clock

:

( lp=LPAREN
  
 

  exp=expression

 

 RPAREN
)
;

param_list_set_vc_reset

:

( lp=LPAREN
  
 
 
  exp=expression

 

 RPAREN
)
;

param_list_set_vc_stall

:

( lp=LPAREN

 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_vc_end_generation_trigger

:

( lp=LPAREN
 
 
  
  exp=expression
 
 

 RPAREN
)
;

param_list_set_vc_capture_edge_type

:

( lp=LPAREN
  
 

  exp=expression

 
 
 RPAREN
)
;

param_list_set_vc_max_number_of_mismatches

:

( lp=LPAREN
  
 
 
  exp=expression
 
 

 RPAREN
)
;

param_list_set_vc_max_number_of_valid_transactions

:

( lp=LPAREN
  
 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_vc_valid_output_transaction

:

( lp=LPAREN

 
 
  exp=expression
  
 

 RPAREN
)
;

param_list_set_vc_output_filename

:

( lp=LPAREN
  
 
 
  exp=expression

 

 RPAREN
)
;

param_list_set_vc_max_cycles

:

( lp=LPAREN

 

  exp=expression
 
 

 RPAREN
)
;

param_list_simulation_timeout_counter
: LPAREN
  exp=expression
  RPAREN
;

param_list_data_generation
  :
  lp1=LPAREN
  exp=expression
  
  RPAREN
  ;

param_list_no_args_command
: 
  LPAREN
  RPAREN
;

bitrange_pure
: LBRACK
  exp=expression
  COLON
  expression
  RBRACK

;

param_list_get_interface

: LPAREN
  (tok1=K_INPUT  | tok2=K_OUTPUT  | tok3=K_INOUT )?
  
  RPAREN
;

param_list_set_unit_prefix

: 

( lp=LPAREN

 
  
  exp=expression
  
 
 
  ( COMMA   exp2=expression
    
  
  
  )?
 RPAREN
)
;

param_list_formal_to_actual_mapping
: 

  f2a=f2a_pair_expr
  (
    COMMA
    f2a_pair_expr
  )*
  
;

f2a_pair_expr
: DOT 
  exp=expression
  
  LPAREN
    ( expression)
  RPAREN
  
;

param_list_add_port_list

  : 
 
  lp=LPAREN
    
  
  (
   id=IDENTIFIER
  
   (
    dot=DOT
   
    |
    com=COMMA
   
   )?
  
  )+
  RPAREN
;

param_list_connect

: 

( lp=LPAREN
  
 

  param_list_formal_to_actual_mapping

 
  RPAREN
)
;

param_list_connect_units

:

( lp=LPAREN

 

  exp=expression

 

 (
  COMMA exp2=expression

 

 )?

RPAREN
)
;

param_list_connect_by_pattern

:

( lp=LPAREN

 

  exp=expression

 

 (
  COMMA exp2=expression

 

 )?

RPAREN
)
;

param_list_connect_by_name

:

( lp=LPAREN

 

  exp=expression
 

  
 (
  COMMA exp2=expression

 
 )?
 
  RPAREN
)
;

param_list_set_dim_bitrange

:
 
( lp=LPAREN
  
 
  
  exp=expression
  
 

  COMMA  exp2=expression
    
 

 RPAREN
)
;

param_list_get_dim_bitrange
: LPAREN
  expression
  RPAREN
;

param_list_set_dim_width

:

( lp=LPAREN
  
 
 
  exp=expression
  
 
 
  COMMA  exp2=expression                                                             

 

 RPAREN
)
;

param_list_get_dim_width
: LPAREN
  expression
  RPAREN
;

param_list_set_instance_alteration_bit

:

( lp=LPAREN

 
 
  exp=expression

 

 RPAREN
)
;

param_list_set_bitrange

: 

( lp=LPAREN

 

  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_width

:

( lp=LPAREN
  
 
 
  exp=expression
 
 
  
RPAREN
)
;

param_list_set_depth

:

( lp=LPAREN 

 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_create_rtl_module

:

( lp=LPAREN

 

 RPAREN
)
;

param_list_get_address_width
: LPAREN

  RPAREN
;

param_list_set_range

: 

( lp=LPAREN
  
 
  
  exp1=expression  COMMA  exp2=expression

 

 RPAREN
)
;

param_list_set_dim_range

:

( lp=LPAREN
  
 
 
  exp=expression
  
 
 
  COMMA  exp2=expression

 

  COMMA  exp3=expression

  

 RPAREN
)
;

param_list_set_offset

:

( lp=LPAREN

 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_dim_offset

:

( lp=LPAREN
  
 
 
  exp=expression
 
 
 
  COMMA  exp2=expression
 
 

 RPAREN
)
;

param_list_set_number_of_dimensions

:

( lp=LPAREN
  
 
  
  exp=expression

 
  
 RPAREN
)
;

param_list_get_dim_offset
: LPAREN
  ex=expression

  RPAREN
;

param_list_set_signal_prefix

:

( lp=LPAREN

 
  
  exp=expression
  
 
 
 RPAREN
)
;

param_list_set_signal_prefix_local

: 

( lp=LPAREN
 
 
 
  exp=expression
  
 
 
 RPAREN
)
;

param_list_get_dim_upper_index
: LPAREN
  ex=expression

  RPAREN
;

param_list_get_dim_lower_index
: LPAREN
  ex=expression

  RPAREN
;

param_list_set_type

: 

( lp=LPAREN

 

  exp=expression

 

 RPAREN
)
;

param_list_set_attr

: 

( lp=LPAREN
  
 

  exp=expression

 

 RPAREN
)
;

param_list_set_unit_id

:

( lp=LPAREN
  
 

  exp=expression

 

 RPAREN
)
;

param_list_set_num_rd_ifc

:

( lp=LPAREN

 

  exp=expression

 

 RPAREN
)
;

param_list_set_num_wr_ifc

:

( lp=LPAREN

 

  exp=expression

 

 RPAREN
)
;

param_list_gen_unique_rtl_modules

:

( lp=LPAREN

 RPAREN
)
;

param_list_no_prefix

:

(
 lp=LPAREN 

 

 RPAREN
)
;

param_list_override_parameter

:

( 
 lp=LPAREN

 

 exp=expression

 
 
 COMMA  exp2=expression

 

 RPAREN
)
;

param_list_do_not_gen_rtl

:

(
 lp=LPAREN

 

 RPAREN
)
;

param_list_do_not_gen_cpp

:

(
 lp=LPAREN

 

 RPAREN
)
;

param_list_set_clock

:

(
 lp=LPAREN

 

 exp=expression

 

 RPAREN
)
;

param_list_register_ios

:

(
 lp=LPAREN

 

 id=IDENTIFIER

 

 (
  COMMA
  DOT
  id2=IDENTIFIER

  

  lp2=LPAREN 
  exp=expression

 

  rp=RPAREN 
  (
   COMMA
   exp2=expression

  

   (
    COMMA
    DOT
    id3=IDENTIFIER

    

    lp3=LPAREN
    exp3=expression

     

    RPAREN
   )?
  )?

  

 )?

 RPAREN
)
;

param_list_reverse

:

( lp=LPAREN
  
 
 
 RPAREN
)
;

  

range_expression 

: 

( expression
  ( 
   ( col=COLON    expression

     | 
     pneg=PO_NEG    expression
     | 
     COMMA  expression
   )
   

  
  )?
)
;

expression 

: 

( con=conditional_expr

 

)
;

conditional_expr

:

( logical_or_expr ( qe=QUESTION  conditional_expr COLON conditional_expr )? )
;

logical_or_expr

:

( logical_and_expr ( lor=LOR  logical_and_expr )* )
;

logical_and_expr

:

( or_expr ( land=LAND  or_expr )* )
;

or_expr 

:

( 
 ( 
  o=OR  
  | 
  nor=NOR  
 ) 
 xor_expr
 
 |
 
 xor_expr 
 ( 
  ( 
   or2=OR  
   | 
   nor2=NOR  
  ) 
  xor_expr 
 )*
)
;

xor_expr 

:

( 
 ( 
  xr=XOR  
  | 
  xnor=XNOR  
 ) 
 and_expr
 
 | 
 
 and_expr 
 ( 
  ( 
   xor2=XOR  
   | 
   xnor2=XNOR  
  ) 
  and_expr 
 )*
)
;

and_expr 

: 

(
 (
  an=AND  
  | 
  nand=NAND  
 ) 
 equality_expr
 
 | 

 equality_expr 
 ( 
  (
   and2=AND  
   | 
   nand2=NAND 
  ) 
  equality_expr
 )*
)
;

equality_expr 

: 

( 
 relational_expr
 (
   (
    eq=EQUAL  
    | 
    neq=NOT_EQ  
    | 
    neqc=NOT_EQ_CASE  
    | 
    eqc=EQ_CASE 
   )
   relational_expr
  )*
)
;

relational_expr 

:

(
 shift_expr 
 (
  (
   lt=LT_  
   | 
   gt=GT  
   | 
   le=LE  
   | 
   ge=GE 
  ) 
  shift_expr
 )*
)
;

shift_expr 

: 
 
(
 additive_expr 
 (
  (
   sl=SL  
   | 
   ssl=SSL  
   | 
   sr=SR  
   | 
   ssr=SSR 
   ) 
  additive_expr
  )*
)
;

additive_expr 

:

(
 (
  PLUS 
  | 
  MINUS
 ) 
 multiplicative_expr 

 

 |
 
 multiplicative_expr 
 (
  (
   pl=PLUS  
   | 
   min=MINUS 
  ) 
  multiplicative_expr
 )*
)
;

multiplicative_expr 

: 

(
 pow_expr 
 (
  (
   st=STAR  
   | 
   div=DIV  
   | 
   mod=MOD 
  ) 
  pow_expr
 )*
)
;

pow_expr 

: 

( unary_not
  ( pow=POW  unary_not )?
)
;

unary_not

: 

(
 ( 
  nt=NOT  
  | 
  lnot=LNOT 
 ) 
 unary_expr

 | 
 
 unary_expr
)
;

unary_expr 

: 

( 

 concatenation_dummy
 | 
 LPAREN
 expression
 RPAREN
)
;

concatenation

:

(
 LCURLY
 ex=expression
 ( sc=simple_concat 

    

 )?

 (

  mc=multi_concat

   
 )?
 RCURLY

 

)
;

simple_concat

:

(
 ( COMMA  expression )+
)
;

multi_concat

:

(
 LCURLY
 ex=expression
 (
  sc=simple_concat

    

  )?

 RCURLY

 

)
;

concatenation_dummy

:

(
 concatenation

 |
 
 expr_primary
)

;

expr_primary 

: 

( 
 number
 |  
 st=STRING 
 |
 expr_primary_identifier 
)
;

number

: 

( 
 un=unsigned_number
 ( bn=based_number
  
   

 )?
| 
 based_number
| 
 real_number
)
;

unsigned_number 

: 

( tok=UNSIGNED_NUMBER
  
 

)
;

based_number 

: 

( tok=BASED_NUMBER

 

)
;

real_number 

:

( tok=REAL_NUMBER

 

)
;

/*This rule applies for a hid or a function call. We can arrange the possible ways of mixing those 2 toghether in 3 categories:
1. A simple hid :                                        (EXPR_PRIMARY_IDENTIFIER) a.b.c
2. A combination of the two ending with a function call:     (FUNCTION_CALL_RET_*) a.b.get_width()
3. A combination of the two ending with an identifier:               (EXPR_HYBRID) a.b.get_interface().x
wasDot indicates the presence of a point at the end of the scope hierarchy (*7).
wasRange is a flag that shows when we have something like this=a.b meaning a RANGE_EXPRESSION (*2).
rightMostIsId flag indicates that the last element in line is an identifier (*1).
returnsExpr flag shows what kind of function is called, is it a function call that returns an expression (*3) or an identifier (*4).
isEPI flag is used to indicate if there is a hid (*0) or a function call or an expression hybrid (*5).
At *6 the rightMostIsId is reseted to indicate the presence of a function call at the end of the scope.
The scope can't end with point (eg=a.b. ) so after *7 it is tested with a semantic predicate.
At *8 the flags are tested and the apropriate node is created according to those 3 categories.
*/

expr_primary_identifier

:

(
 (
  ( id=IDENTIFIER 
    ( LBRACK range_expression RBRACK  )?
 
    |

    ( 
     function_call_ret_id   
     |
     function_call_ret_expr 
    )

   

   )
  ( DOT  )?
 )
 (  
   ( id2=IDENTIFIER 
    ( LBRACK range_expression RBRACK  )?
 
    |

    ( 
     function_call_ret_id       
     |
     function_call_ret_expr     
    )
     
   

   )
  ( DOT  )?
 )*

 

)
;

function_call_ret_expr

: 

(
 (
  fcre1=K_GET_WIDTH                                                             param_list_no_args_command              
  |  fcre2=K_GET_DIM_WIDTH                                                      param_list_get_dim_width                
  |  fcre3=K_GET_LOWER_INDEX                                                    param_list_no_args_command              
  |  fcre4=K_GET_DIM_LOWER_INDEX                                                param_list_get_dim_lower_index          
  |  fcre5=K_GET_UPPER_INDEX                                                    param_list_no_args_command              
  |  fcre6=K_GET_DIM_UPPER_INDEX                                                param_list_get_dim_upper_index          
  |  fcre7=K_GET_OFFSET                                                         param_list_no_args_command              
  |  fcre8=K_GET_DIM_OFFSET                                                     param_list_get_dim_offset               
  |  fcre9=K_GET_NUMBER_OF_DIMENSIONS                                           param_list_no_args_command              
  | fcre10=K_GET_FILENAME                                                       param_list_no_args_command              
  | fcre11=K_GET_NAME                                                           param_list_no_args_command              
  | fcre12=K_GET_VC_ID                                                          param_list_no_args_command              
  | fcre13=K_GET_VC_MAX_NUM_STATES                                              param_list_no_args_command              
  | fcre14=K_GET_MAX_NUM_VECTORS                                                param_list_no_args_command              
  | fcre15=K_GET_SIMULATION_TIMEOUT_COUNT                                       param_list_no_args_command              
  | fcre16=K_GET_TRANSACTION_TIMEOUT_COUNT                                      param_list_no_args_command              
  | fcre17=K_GET_MAX_ERROR_COUNT                                                param_list_no_args_command              
  | fcre18=K_GET_SIGNAL_VALUE                                                   param_list_no_args_command              
  | fcre19=K_GET_SYMBOL_LENGTH                                                  param_list_no_args_command              
  | fcre20=K_GET_DATA_WORD_WIDTH                                                param_list_no_args_command              
  | fcre21=K_GET_LOWER_BOUND                                                    param_list_no_args_command              
  | fcre22=K_GET_UPPER_BOUND                                                    param_list_no_args_command              
  | fcre23=K_GET_ADDR_INCREMENT                                                 param_list_no_args_command              
  | fcre24=K_GET_NEXT_ADDRESS                                                   param_list_no_args_command              
  | fcre25=K_GET_ALIGNMENT                                                      param_list_no_args_command              
  | fcre26=K_GET_ENDIANESS                                                      param_list_no_args_command              
  | fcre27=K_GET_NAME_LENGTH                                                    param_list_no_args_command              
  | fcre28=K_GET_PREFIX                                                         param_list_no_args_command              
  | fcre29=K_GET_SUFFIX                                                         param_list_no_args_command              
  | fcre30=K_GET_LOCK_ENABLE_BIT                                                param_list_no_args_command              
  | fcre31=K_GET_DEPTH                                                          param_list_no_args_command              
  | fcre32=K_GET_ATTRIBUTES                                                     param_list_no_args_command              
  | fcre33=K_GET_MNEMONIC                                                       param_list_no_args_command              
  | fcre34=K_START_STATE_DATA_GENERATION                                                    param_list_data_generation              
  | fcre35=K_GET_VALUE                                                          param_list_no_args_command              
  | fcre36=K_GET_VC_NAME                                                        param_list_no_args_command              
  | fcre37=K_GET_VC_HEADER_COMMENT                                              param_list_no_args_command              
  | fcre38=K_GET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS                                param_list_no_args_command              
  | fcre39=K_GET_VC_MAX_NUMBER_OF_MISMATCHES                                    param_list_no_args_command              
  | fcre40=K_GET_VC_TIMEOUT                                                     param_list_no_args_command              
  | fcre41=K_GET_VC_OUTPUT_FILENAME                                             param_list_no_args_command              
  | fcre42=K_GET_VC_CPP_RD_NAME                                                 param_list_no_args_command              
  | fcre43=K_GET_VC_CPP_WR_NAME                                                 param_list_no_args_command              
  | fcre44=K_GET_RESET_NAME                                                     param_list_no_args_command              
  | fcre45=K_GET_CLOCK_NAME                                                     param_list_no_args_command              
  | fcre46=K_GET_RD_CLOCK_NAME                                                  param_list_no_args_command              
  | fcre47=K_GET_WR_CLOCK_NAME                                                  param_list_no_args_command              
  | fcre48=K_GET_PUSH_NAME                                                      param_list_no_args_command              
  | fcre49=K_GET_POP_NAME                                                       param_list_no_args_command              
  | fcre50=K_GET_FULL_NAME                                                      param_list_no_args_command              
  | fcre51=K_GET_EMPTY_NAME                                                     param_list_no_args_command              
  | fcre52=K_GET_WR_DATA_NAME                                                   param_list_no_args_command              
  | fcre53=K_GET_RD_DATA_NAME                                                   param_list_no_args_command              
  | fcre54=K_GET_VALID_NAME                                                     param_list_no_args_command              
  | fcre55=K_GET_WR_ADDR_NAME                                                   param_list_no_args_command              
  | fcre56=K_GET_RD_ADDR_NAME                                                   param_list_no_args_command              
  | fcre57=K_GET_WR_EN_NAME                                                     param_list_no_args_command              
  | fcre58=K_GET_RD_EN_NAME                                                     param_list_no_args_command              
  | fcre59=K_GET_OUTPUT_FILENAME                                                param_list_no_args_command              
  | fcre60=K_GET_MSB                                                            param_list_no_args_command              
  | fcre61=K_GET_LSB                                                            param_list_no_args_command              
  | fcre62=K_GET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS                            param_list_no_args_command              
 )

 

)
;

function_call_ret_id

:

( 
 (
  fcri1=K_GET_TYPE                                                              param_list_no_args_command               
  | fcri2=K_GET_INTERFACE                                                       param_list_get_interface                 
  | fcri3=K_GET_UNIT_PREFIX                                                     param_list_no_args_command               
  | fcri4=K_GET_SIGNAL_PREFIX                                                   param_list_no_args_command               
  | fcri5=K_GET_SIGNAL_PREFIX_LOCAL                                             param_list_no_args_command               
  | fcri6=K_GET_BITRANGE                                                        param_list_no_args_command               
  | fcri7=K_GET_DIM_BITRANGE                                                    param_list_get_dim_bitrange              
  | fcri8=K_GET_ATTR                                                            param_list_no_args_command               
  | fcri9=K_GET_CELL                                                            param_list_no_args_command               
  | fcri10=K_GET_INPUT_FIELD                                                    param_list_no_args_command               
  | fcri11=K_GET_OUTPUT_FIELD                                                   param_list_no_args_command               
  | fcri12=K_GET_CNT_DIR_SIGNAL                                                 param_list_no_args_command               
  | fcri13=K_GET_ENUM                                                           param_list_no_args_command               
  | fcri14=K_GET_ENUM_ITEM                                                      param_list_no_args_command               
  | fcri15=K_GET_VC_CLOCK                                                       param_list_no_args_command               
  | fcri16=K_GET_VC_RESET                                                       param_list_no_args_command               
  | fcri17=K_GET_VC_STALL                                                       param_list_no_args_command               
  | fcri18=K_GET_VC_COMPARE_TRIGGER                                             param_list_no_args_command               
  | fcri19=K_GET_VC_START_GENERATION_TRIGGER                                    param_list_no_args_command               
  | fcri20=K_GET_VC_END_GENERATION_TRIGGER                                      param_list_no_args_command               
  | fcri21=K_GET_VC_CAPTURE_EDGE_TYPE                                           param_list_no_args_command               
  | fcri22=K_GET_VC_MODULE                                                      param_list_no_args_command               
  | fcri23=K_GET_RADIX                                                          param_list_no_args_command               
 )

 

)
;

  
  
