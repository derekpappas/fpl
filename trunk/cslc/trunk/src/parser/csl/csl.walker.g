//----------------------------------------------------------------------
// Copyright (c) 2006, 2007, 2008 FastpathLogic
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
 *   Authors: GabrielD & StefanP & AndreiB
 *   2006-2007-2008
 */

header "post_include_hpp" {
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
}

options {
  language="Cpp";
  genHashLines = true;
}

{
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
}
 

class CslTreeWalker extends TreeParser;

options {
    //codeGenDebug = false;
    k = 1;
    importVocab = CslParser;
    ASTLabelType = "antlr::RefCslAST";
    defaultErrorHandler = false;
}

{
NSCSLOm::RefCSLOmBase design;
NSCSLOm::RefTVec_RefCSLOmBase scopeBlocks;
RefTVec_RefString vCurrentScope;
void printAST(antlr::RefCslAST ast);
}

source_text [NSCSLOm::RefCSLOmDesign design_param, RefTVec_RefString vCurrentScope_param]
{
  design = design_param;
  vCurrentScope = vCurrentScope_param;
  scopeBlocks = NSCSLOm::RefTVec_RefCSLOmBase( new NSCSLOm::TVec_RefCSLOmBase() );
  ASSERT( design.get() , "ERROR: The design is not initialised!" );
  ASSERT( vCurrentScope.get() , "ERROR: The current scope vector is uninitialised!" );
  scopeBlocks->push_back( design );
}
: (description)*
{ 
}
;

description 
: csl_command
| csl_declaration
| csl_function_declaration
;

csl_command
{
  NSCSLOm::RefCSLOmBase obj = RefCSLOmBase();
}
: //UNITS
    //command_add_instance
    //| command_add_instance_list
    //| command_add_port
    //| command_add_port_list
    //| command_add_port_group
    //| command_add_interface
    //| command_add_signal
    //| command_add_signal_list
    //| command_add_signal_group
    command_add_clock                       //testbench
  | command_add_reset                       //testbench
  | command_add_equation                    //testbench
  | command_add_address_range               //memory map
  | command_set_address_increment           //memory map
  | command_set_next_address                //memory map
  | command_add_reserved_range              //memory map
  | command_add                             //memory map
  | command_set_data_word_width             //memory map
  | command_set_alignament                  //memory map
  | command_set_endianess                   //memory map
  | command_set_symbol_max_length           //memory map
  | command_set_prefix                      //memory map
  | command_no_prefix
  | command_set_suffix                      //memory map
  | command_set_type
  | command_set_attr
  | command_set_attributes
  | command_set_transaction_timeout_counter //testbench
  | command_set_simulation_timeout_counter  //testbench
      //| command_add_unit_parameter

  | command_add_arch_state                  //testbench
    // State Data specific
  | command_set_instance_name
    // Vector specific
  | command_set_unit_name
  | command_set_direction
  | command_exclusion_list
  | command_include_only
    // State Data and Vector commands
  | command_set_vc_id
  | command_set_vc_name
  | command_set_vc_header_comment
  | command_set_vc_version
  | command_set_radix
  | command_set_vc_clock
  | command_set_vc_reset
  | command_set_vc_stall
  | command_set_vc_compare_trigger
  | command_set_vc_start_generation_trigger
  | command_set_vc_end_generation_trigger
  | command_set_vc_capture_edge_type
  | command_set_vc_max_cycles
  | command_set_vc_max_number_of_capture_events
  | command_set_vc_max_number_of_valid_transactions
  | command_set_vc_max_number_of_mismatches
  | command_set_vc_timeout
  | command_set_vc_output_filename
  | command_set_vc_cpp_rd_name
  | command_set_vc_cpp_wr_name
  | command_set_vc_max_num_states
    //Interconnect::assignment
  | command_assign
    //Generic
  | command_set_name
  | command_do_not_gen_rtl                        
  | command_do_not_gen_cpp
  | command_gen_unique_rtl_modules
  | command_set_clock
  | command_register_ios
  | command_override_parameter
  | command_auto_connect_verilog_and_csl
  | command_auto_connect_width_inference
  | command_set_compare_trigger             //testbench
  | command_generate_waves                  //testbench
  | command_set_dut_mem                     //testbench
  | command_set_dut_mem_init                //testbench
  //Custom port naming
  | command_set_port_name
  //SIGNALS AND OTHERS (RF, FIFO)
  | command_set_width
  | command_set_depth
  | command_set_dim_width
  | command_set_bitrange
  | command_set_dim_bitrange
  | command_set_range          
  | command_set_dim_range
  //| command_set_lower_index
  //| command_set_dim_lower_index             
  //| command_set_upper_index                 
  //| command_set_dim_upper_index             
  | command_set_offset                      
  | command_set_dim_offset                  
  | command_set_number_of_dimensions
  | command_set_unit_prefix                 
  | command_set_signal_prefix               
  | command_set_signal_prefix_local    
  //Field/ ISA Field
  | command_set_value     
  | command_set_enum
  | command_set_enum_item
  | command_set_position
  | command_set_field_position
  | command_set_next
  | command_set_previous
  | command_add_allowed_range
  //| command_remove_signal
  //| command_remove_signal_list
  //| command_remove_port
  //| command_get_depth
  //| command_get_width
  | command_create_rtl_module
  | command_set_const_value
  | command_set_field
  | command_set_external
  //| command_remove_port_list
  | command_merge                           
  | command_invert                          
  | command_buffer
  //PORTS
  | command_reverse
  //BITRANGE
    //| obj = command_concat                    
  //CONNECT 
  | command_connect_by_name
  //CONNECT_BY_PATTERN
  | command_connect_by_pattern 
  //CONNECT_BY_SCOPE
  | command_connect_units 
      //| command_connect_split
  //CELL
  | command_set_cell                        
  //DESIGN
  | command_input_verilog_type              
  | command_output_verilog_type             
  | command_autorouter                      
  | command_generate_individual_rtl_signals
  | command_generate_decoder
  //fifo
  | command_set_dimensions
  | command_set_physical_implementation
  //add_logic
  | command_add_logic
  //directive
  | command_directive
  | command_auto_gen_memory_map
  | command_set_top_unit
  | command_set_access_rights
  | command_set_access_rights_enum
  | command_add_to_memory_map
  //isa
  | command_set_mnemonic
  | command_set_decoder_name
  | command_set_decoder_out_name_prefix
  | command_set_decoder_out_name_suffix
  | command_print
;

//done

//command_get_depth        
//  :
//  #(K_GET_DEPTH
//  {
//    //call cmd
//  }
//   )
//  ;
// 
//command_get_width        
//  :
//  #(K_GET_WIDTH
//  {
//  //call cmd
//  }
//  )
//  ;

command_create_rtl_module
  :
  #(K_CREATE_RTL_MODULE
  {
    //call cmd
  }
  )
  ;

command_set_const_value  
  :
  #(K_SET_CONST_VALUE
  {
    //call cmd
  }

   )
  ;

command_set_field        
  :
  #(K_SET_FIELD
  {
    //call cmd
  }
  )
  ;
 
command_set_external     
  :
  #(K_SET_EXTERNAL
  {
    //call cmd
  }
   )
  ;
  

command_directive
  :
   #(K_DIRECTIVE
     ( directive_register_group
      | directive_disconnect_register_fields_from_ios
      | directive_connect_register_fields_to_ios
     )
    )
  ;

command_auto_gen_memory_map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr prefixExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_AUTO_GEN_MEMORY_MAP
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
         scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_AUTO_GEN_MEM_MAP, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_AUTO_GEN_MEM_MAP, params);
    }
  }
;

command_set_top_unit
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr topUnitExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_TOP_UNIT
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
         scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
       }
     }
    )*
    topUnitExpr = expression
    {
      ASSERT(topUnitExpr.get(),"NULL top unit expr");
      params->push_back(topUnitExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_AUTO_GEN_MEM_MAP, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_TOP_UNIT, params);
    }
  }
;

command_set_access_rights
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr posExpr, upperExpr, mnExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_ACCESS_RIGHTS
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
         scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
       }
     }
    )*
    posExpr = expression
    {
      ASSERT(posExpr.get(),"NULL enum expr");
      params->push_back(posExpr);
    }
   (COLON
    upperExpr = expression
   {
     params->push_back(upperExpr);
   }
    )?
   mnExpr = expression
   {
     params->push_back(mnExpr);
   }
   (
     K_ACCESS_RIGHT_READ
     |
     K_ACCESS_RIGHT_WRITE
     |
     K_ACCESS_RIGHT_READ_WRITE
     |
     K_ACCESS_RIGHT_NONE
   )
  )
  {
    DCERR("[ WARNING ] Walker: If you can read this, it means that this command: set_access_rights(range|number,expression,access_specifier), passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
    //if(hasIdentifier) {
    //  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_ACCESS_RIGHTS_ENUM, params);
    //}
    //else {
    //  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ACCESS_RIGHTS_ENUM, params);
    //}
  }
;

command_set_access_rights_enum
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr enumExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_ACCESS_RIGHTS_ENUM
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
         scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
       }
     }
    )*
    enumExpr = expression
    {
      ASSERT(enumExpr.get(),"NULL enum expr");
      params->push_back(enumExpr);
    }

  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_ACCESS_RIGHTS_ENUM, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ACCESS_RIGHTS_ENUM, params);
    }
  }
;

command_add_to_memory_map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr addrExpr,groupExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  EAccessRights accessRights;
  TBool hasIdentifier = FALSE;
}
:#(tok:K_ADD_TO_MEMORY_MAP
    ( id = identifier
      {
        hasIdentifier = TRUE;
        if( scope.get() ) {
          scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
        }
      }
    )*
   (
    addrExpr = expression
    {
      params->push_back(addrExpr);
    }

   (
    groupExpr = expression
   {
     params->push_back(groupExpr);
   }
    )?
    (
      K_ACCESS_RIGHT_NONE       { accessRights = ACC_NONE; }
    | K_ACCESS_RIGHT_READ       { accessRights = ACC_R   ; }
    | K_ACCESS_RIGHT_WRITE      { accessRights = ACC_W   ; }
    | K_ACCESS_RIGHT_READ_WRITE { accessRights = ACC_RW  ; }
      )?
   )?
  )
  {
    //WARNING waiting for CSLOmCmd support
    //if(hasIdentifier) {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_TO_MEM_MAP, params);
    //}
    //else {
    //CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_ADD_TO_MEM_MAP, params);
    //}
  }
;

command_set_mnemonic
{
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr mnemonicExpr;
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_MNEMONIC
    ( id = identifier
      {
        hasIdentifier = TRUE;
        if( scope.get() ) {
          scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
        }
      }
    )*
    mnemonicExpr = expression
    {
      ASSERT(mnemonicExpr.get(),"NULL enum expr");
      params->push_back(mnemonicExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_ASM_MNEMONIC, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_SET_ASM_MNEMONIC, params);
    }
  }
;


command_set_decoder_name
{
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr decNameExpr;
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_DECODER_NAME
    ( id = identifier
      {
        hasIdentifier = TRUE;
        if( scope.get() ) {
          scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
        }
      }
    )*
    decNameExpr = expression
    {
      ASSERT(decNameExpr.get(),"NULL decNameExpr");
      params->push_back(decNameExpr);
    }
 )
 {
   if(hasIdentifier) {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DECODER_NAME, params);
   }
   else {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_SET_DECODER_NAME, params);
   }
 }
;

command_set_decoder_out_name_prefix
{
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr decOutNamePrefixExpr;
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_DECODER_OUT_NAME_PREFIX
    ( id = identifier
      {
        hasIdentifier = TRUE;
        if( scope.get() ) {
          scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
        }
      }
    )*
    decOutNamePrefixExpr = expression
    {
      ASSERT(decOutNamePrefixExpr.get(),"NULL enum expr");
      params->push_back(decOutNamePrefixExpr);
    }
 )
 {
   if(hasIdentifier) {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DECODER_OUT_NAME_PREFIX, params);
   }
   else {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_SET_DECODER_OUT_NAME_PREFIX, params);
   }
 }
;

command_set_decoder_out_name_suffix
{
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr decOutNameSuffixExpr;
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_DECODER_OUT_NAME_SUFFIX
    ( id = identifier
      {
        hasIdentifier = TRUE;
        if( scope.get() ) {
          scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
        }
      }
    )*
    decOutNameSuffixExpr = expression
    {
      ASSERT(decOutNameSuffixExpr.get(),"NULL enum expr");
      params->push_back(decOutNameSuffixExpr);
    }
 )
 {
   if(hasIdentifier) {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DECODER_OUT_NAME_SUFFIX, params);
   }
   else {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_SET_DECODER_OUT_NAME_SUFFIX, params);
   }
 }
;

command_print
{
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr printExpr;
  TBool hasIdentifier = FALSE;
}
:#(tok:K_PRINT
    ( id = identifier
      {
        hasIdentifier = TRUE;
        if( scope.get() ) {
          scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
        }
      }
    )*
    printExpr = expression
    {
      ASSERT(printExpr.get(),"NULL enum expr");
      params->push_back(printExpr);
    }
 )
 {
   if(hasIdentifier) {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_PRINT, params);
   }
   else {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_PRINT, params);
   }
 }
;

directive_register_group
{
  std::pair<RefString, int> id;
}
  :
   #(K_REGISTER_GROUP
     {
       //call cmd
     }
    )
  ;

directive_disconnect_register_fields_from_ios
  :
   #(K_DISCONNECT_REG_FIELDS_IOS
    {
      //call cmd
    }
    )
  ;

directive_connect_register_fields_to_ios
  :
   #(K_CONNECT_REG_FIELDS_IOS
     {
       //call cmd
     }
    )
  ;


command_set_dimensions
{
  RefCSLOmExpr expr = RefCSLOmExpr();
}
  :
  #(K_SET_DIMENSIONS
    expr = expression
    {
      //call cmd
    }
   )
  ;

command_set_physical_implementation
{
  RefCSLOmExpr expr = RefCSLOmExpr();
}
  :
   #(K_SET_PHYSICAL_IMPLEMENTATION
     //expr = expression
     (K_SRAM | K_FFA)
     {
       //call cmd
     }
    )
  ;

command_add_logic
  :
  #(K_ADD_LOGIC
    (
  command_add_logic_programmable_depth
  | command_add_logic_priority_bypass 
  | command_add_logic_sync_fifo       
  | command_add_logic_asynch_fifo     
  | command_add_logic_depth_extend      
  | command_add_logic_width_extend      
  | command_add_logic_wr_hold
  | command_add_logic_parallel_output   
  | command_add_logic_parallel_input    
  | command_add_logic_rd_words          
  | command_add_logic_wr_words          
  | command_add_logic_sram_rd         
  | command_add_logic_sram_wr
  | command_add_logic_pushback        
  | command_add_logic_flow_through      
  | command_add_logic_stall   
  | command_add_logic_stall_rd_side
  | command_add_logic_stall_wr_side
  | command_add_logic_wr_release
  | command_add_logic_almost_empty      
  | command_add_logic_almost_full 
  | command_add_logic_output_wr_addr
  | command_add_logic_output_rd_addr
  | command_add_logic_credit
  | command_add_logic_rd_credit
  | command_add_logic_wr_credit
  | command_add_logic_flow
  //Interconnect: Unit
  | command_add_logic_unit_address_decoder
  //Register File
  | command_add_logic_read_valid
  | command_async_reset
  //Register : general
  | command_add_logic_neg_output
  | command_add_logic_serial_input
  | command_add_logic_serial_output
  | command_add_logic_set
  | command_add_logic_reset
  | command_add_logic_init
  | command_add_logic_clear
  //Register : type counter
  | command_add_logic_gray_output
  | command_add_logic_start_value
  | command_add_logic_end_value
  | command_add_logic_count_amount
  | command_add_logic_direction_control
  | command_add_logic_count_direction
  | command_add_logic_load
  //| command_add_logic_count_enable
  //Verification components
  | command_add_logic_inject_stalls
  //Testbench 
  | command_add_logic_simulation_timeout_counter
  | command_add_logic_stall_generation
  | command_add_logic_generate_waves
  | command_add_logic_clock
  | command_add_logic_generate_report
  )
    )
  ;


command_add_logic_programmable_depth
{
  RefCSLOmExpr expr = RefCSLOmExpr();
}
  :#(tok1:K_PROGRAMMABLE_DEPTH
     expr = expression
    {
      //call cmd
    }
   )
  ;

command_add_logic_priority_bypass 
  :
  #(K_PRIORITY_BYPASS
    {
      //call cmd
    }
   )
  ;

command_add_logic_sync_fifo       
  :
   #(K_SYNC_FIFO
     {
       //call cmd
     }
   )
  ;

command_add_logic_asynch_fifo     
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
  :
    #(tok:K_ASYNC_FIFO
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
     {
       CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_FIFO_SET_ASYNCH, params);
     }
   )
  ;

command_add_logic_depth_extend      
{
  RefCSLOmExpr expr = RefCSLOmExpr();
}
  :
   #(K_DEPTH_EXTEND
     expr = expression
     {
       //call cmd
     }
   )
  ;

command_add_logic_width_extend      
{
  RefCSLOmExpr expr = RefCSLOmExpr();
}
  :
   #(K_WIDTH_EXTEND
     expr = expression
     {
       //call cmd
     }
   )
  ;

command_add_logic_wr_hold                                                                
{
  RefCSLOmExpr expr = RefCSLOmExpr();
}
  :
   #(K_WR_HOLD
     expr = expression
     {
       //call cmd
     }
   )
  ;

command_add_logic_parallel_output   
  :
   #(K_PARALLEL_OUTPUT
     (
      K_ALL
      {
        //call cmd for all
      }
      //|
      //vector of addresses
      //{
      //  //call cmd for vector of addresses
      //}
     )
   )
  ;

command_add_logic_parallel_input    
  :
   #(K_PARALLEL_INPUT
     (
      K_ALL
      {
        //call cmd for all
      }
      //|
      //vector of addresses
      //{
      //  //call cmd for vector of addresses
      //}
     )
   )
  ;

command_add_logic_rd_words          
  :
   #(K_RD_WORDS
     //take address range
     {
       //call cmd
     }
   )
  ;

command_add_logic_wr_words          
  :
   #(K_WR_WORDS
     //take address range
     {
       //call cmd
     }
   )
  ;

command_add_logic_sram_rd         
  :
   #(K_SRAM_RD
     {
       //call cmd
     }
   )
  ;

command_add_logic_sram_wr                                                         
  :
   #(K_SRAM_WR
     {
       //call cmd
     }
   )
  ;

command_add_logic_pushback        
  :
   #(K_PUSHBACK
     {
       //call cmd
     }
   )
  ;

command_add_logic_flow_through    
{
  RefCSLOmExpr expr = RefCSLOmExpr();
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}  
  :
    #(tok:K_FLOW_THROUGH
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
      expr = expression 
      { 
         params->push_back(expr);
         CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_FIFO_FLOW_THROUGH, params);
      }
   )
  ;

command_add_logic_unit_address_decoder
{
//Incomplete
//WARNING - waiting for cmd support
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:#(K_UNIT_ADDRESS_DECODER
   (expr = expression
    {
      DCERR("[ WARNING ] Walker: If you can read this, it means that this command: add_logic(unit_address_decoder,expression), passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
      //WARNING - waiting for cmd support
    }
    )
)
;

command_add_logic_read_valid
{
//Incomplete
//WARNING - waiting for cmd support
}
:
  #(K_READ_VALID
    {
      DCERR("[ WARNING ] Walker: If you can read this, it means that this command: add_logic(read_valid), passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
      //WARNING - waiting for cmd support
    }
    )
;

command_async_reset
{
//Incomplete
//WARNING - waiting for cmd support
}
:
  #(K_ASYNC_RESET
    {
      DCERR("[ WARNING ] Walker: If you can read this, it means that this command: add_logic(async_reset), passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
      //WARNING - waiting for cmd support
    }
    )
;

command_add_logic_neg_output
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
  :
  #(tok:K_NEG_OUTPUT
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_NEG_OUTPUT);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_NEG_OUTPUT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
  )
;

command_add_logic_serial_input
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
  :
  #(tok:K_SERIAL_INPUT
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_SERIAL_INPUT);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_SERIAL_INPUT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
  )
;

command_add_logic_serial_output
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
  :
  #(tok:K_SERIAL_OUTPUT
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_SERIAL_OUTPUT);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_SERIAL_OUTPUT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
  )
;

command_add_logic_gray_output
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
  :
  #(tok:K_GRAY_OUTPUT
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_GRAY_OUTPUT);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_GRAY_OUTPUT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
  )
  ;

command_add_logic_start_value
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:
  #(tok:K_START_VALUE
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    expr = expression
    {
      params->push_back(expr);
    }
    )
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_START_VALUE);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_START_VALUE, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
;

command_add_logic_end_value
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:
  #(tok:K_END_VALUE
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    expr = expression
    {
      params->push_back(expr);
    }
    )
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_END_VALUE);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_END_VALUE, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
;

command_add_logic_count_amount
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:
  #(tok:K_COUNT_AMOUNT
    (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    expr = expression
    {
      params->push_back(expr);
    }
    )
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_COUNT_AMMOUNT);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_COUNT_AMMOUNT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
;

command_add_logic_direction_control
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:
  #(tok:K_DIRECTION_CONTROL
    (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    expr = expression
    {
      params->push_back(expr);
    }
    )
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_DIR_CONTROL);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_DIR_CONTROL, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
;

command_add_logic_count_direction
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  CSLOmRegDeclInfo::ERegDeclCntDir countDir = CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UNDEF;
}
:
  #(tok:K_COUNT_DIRECTION
    (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    (
      K_UP   { countDir = CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP  ; }
     |K_DOWN { countDir = CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN; }
     )
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_COUNT_DIRECTION);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_COUNT_DIRECTION, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmCmdAddLogic::addEnumParam(countDir, NSCSLOm::TYPE_CMD_ADD_LOGIC);      
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
  )
  ;


command_add_logic_load
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
  :
  #(tok:K_LOAD
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    {
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_LOAD, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
  )
;

//command_add_logic_count_enable
//{
//}
//:
//  #(K_COUNT_ENABLE
//    {
//      //WARNING - waiting for cmd support
//      //std::cerr << "Hello in count enable" << std::endl;
//    }
//  )
//  ;

command_add_logic_set
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:
  #(tok:K_SET
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    (
    expr = expression
    {
      params->push_back(expr);
    }
    )?
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_SET);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_SET, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
  )
  ;

command_add_logic_reset
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:
  #(tok:K_RESET
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    (
    expr = expression
    {
      params->push_back(expr);
    }
    )?
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_RESET);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_RESET, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
  )
  ;

command_add_logic_init
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:#(tok:K_INIT
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    (
    expr = expression
    {
      params->push_back(expr);
    }
    )?
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_INIT);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_INIT, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
)
;

command_add_logic_clear
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:#(tok:K_CLEAR
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    (
    expr = expression
    {
      params->push_back(expr);
    }
    )?
    {
      //CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::REG_OPER_CLEAR);
      CSLOmCmdAddLogic::addEnumParam(CSLOmRegDeclInfo::REG_OPER_CLEAR, NSCSLOm::TYPE_CMD_ADD_LOGIC);
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_LOGIC, params);
    }
)
;

command_add_logic_inject_stalls
{
//Incomplete
//WARNING - waiting for cmd support
}
:
  #(K_INJECT_STALLS
    {
      DCERR("[ WARNING ] Walker: If you can read this, it means that this command: add_logic(inject_stalls), passed but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
      //WARNING - waiting for cmd support
    }
    )
;

command_add_logic_simulation_timeout_counter
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );

}
:#(tok:K_SIMULATION_TIMEOUT_COUNTER
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  {
    params->push_back(expr);
  }
   )
{
  CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::TB_OPER_SIM_TIMEOUT_COUNTER);
  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_TB_ADD_LOGIC, params);
}
;


command_add_logic_stall_generation
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );

}
:#(tok:K_STALL_GENERATION
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  {
    params->push_back(expr);
  }
   )
{
  CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::TB_OPER_STALL_GENERATION);
  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_TB_ADD_LOGIC, params);
}
;

//Warning - rule not completed - waiting for parser support (list of scopes args not present)
command_add_logic_generate_waves
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr1, expr2;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  CSLOmTBInfo::ETBWaveType mWaveType = CSLOmTBInfo::TB_WAVE_UNDEF;
}
:#(tok:K_GENERATE_WAVES
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*

   expr1 = label:expression
  {
    params->push_back(expr1);
  }
   (
    K_WAVE_TYPE_FSDB { mWaveType = CSLOmTBInfo::TB_WAVE_FSDB; }
    |
    K_WAVE_TYPE_VCD  { mWaveType = CSLOmTBInfo::TB_WAVE_VSD ; }
    )
   (
    expr2 = expression
   {
     params->push_back(expr2);
   }
    )*
   )
{
  CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::TB_OPER_GENERATE_WAVES);
  CSLOmCmdTBAddLogic::setWaveType(mWaveType);
  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_TB_ADD_LOGIC, params);
}
;


command_add_logic_clock
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr1, expr2;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  CSLOmTBInfo::ETBTimeBase mTimeBase = CSLOmTBInfo::TB_TIMEBASE_UNDEF;
  //flag to see if it's called in testbench where 
  //the optional parameters are mandatory
  TBool isInTestBench = FALSE; 
  
}
:#(tok:K_CLOCK_SIGNAL
   //{ DCERR("||| line number is " << #tok->getLine());  }
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   (
    expr1 = expression
    expr2 = expression
   {
     params->push_back(expr1);
     params->push_back(expr2);
   }
    (
     K_PS { mTimeBase = CSLOmTBInfo::TB_TIMEBASE_PS; }
     |
     K_NS { mTimeBase = CSLOmTBInfo::TB_TIMEBASE_NS; }
     |
     K_US { mTimeBase = CSLOmTBInfo::TB_TIMEBASE_US; }
     |
     K_MS { mTimeBase = CSLOmTBInfo::TB_TIMEBASE_MS; }
     |
     K_S  { mTimeBase = CSLOmTBInfo::TB_TIMEBASE_S ; }
     )
   { isInTestBench = TRUE; }
    )?
   )
{
  if(isInTestBench){
    CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::TB_OPER_CLOCK);
    CSLOmCmdTBAddLogic::setTimeBase(mTimeBase);
  }
  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_TB_ADD_LOGIC, params);
}
;

command_add_logic_generate_report
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  CSLOmTBInfo::ETBReportType mReportType = CSLOmTBInfo::TB_REPORT_UNDEF;
  TBool mType = FALSE;
}
:#(tok:K_GENERATE_REPORT
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   (
    K_COLUMN { mReportType = CSLOmTBInfo::TB_REPORT_COLUMS; mType = TRUE; }
    |
    K_ROW    { mReportType = CSLOmTBInfo::TB_REPORT_ROWS  ; mType = TRUE; }
    )*
   )
{
  CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::TB_OPER_GENERATE_REPORT);
  if(mType){
    CSLOmCmdTBAddLogic::setReportType(mReportType);
  }
  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_TB_ADD_LOGIC, params);
}
;

command_add_logic_stall   
  :
   #(K_STALL
     {
       //call cmd
     }
   )
  ;

command_add_logic_stall_rd_side                                                                  
  :
   #(K_STALL_RD_SIDE
     {
       //call cmd
     }
   )
  ;

command_add_logic_stall_wr_side                                                                  
  :
   #(K_STALL_WR_SIDE
     {
       //call cmd
     }
   )
  ;

command_add_logic_wr_release
  :
   #(K_WR_RELEASE
     {
       //call cmd
     }
   )
  ;

command_add_logic_almost_empty      
{
  RefCSLOmExpr expr = RefCSLOmExpr();
}
  :
   #(K_ALMOST_EMPTY
     expr = expression
     {
       //call cmd
     }
   )
  ;

command_add_logic_almost_full 
{
  RefCSLOmExpr expr = RefCSLOmExpr();
}
  :
   #(K_ALMOST_FULL
    expr = expression
     {
       //call cmd
     }
   )
  ;

command_add_logic_output_wr_addr
{
  pair<RefString, int> id;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExprLink scope = RefCSLOmExprLink();
}
:  #(tok:K_OUTPUT_WR_ADDR
    ( id = identifier
     {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }       
      }
     )*
     {
       CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_FIFO_ADD_OUT_WR_ADDR, params);
     }
   )
  ;

command_add_logic_output_rd_addr
{
  pair<RefString, int> id;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExprLink scope = RefCSLOmExprLink();
}
:   #(tok:K_OUTPUT_RD_ADDR
    ( id = identifier
     {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }       
      }
     )*
     {
       CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_FIFO_ADD_OUT_RD_ADDR, params);
     }
   )
  ;

command_add_logic_credit
  :
   #(K_CREDIT
     {
       //call cmd
     }
   )
  ;

command_add_logic_rd_credit
  :
   #(K_RD_CREDIT
     {
       //call cmd
     }
   )
  ;

command_add_logic_wr_credit
  :
   #(K_WR_CREDIT
     {
       //call cmd
     }
   )
  ;

command_add_logic_flow
  :
  #(K_FLOW
    {
      //call cmd
    }
   )
  ;

command_generate_decoder
{
  pair<RefString, int> id;
  NSCSLOm::RefCSLOmExpr exp1,exp2;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  TInt nrOfExprs = 0;
}
:#(tok:K_GEN_DECODER
    ( id = identifier
     {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }       
      }
     )*
    (exp1 = expression 
      { params->push_back(exp1); 
        ++nrOfExprs;
      }    
     )*
     {nrOfExprs <= 2}?
     {
       CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DECODER, params);
     }
   )
;

//
//REMOVED due to language change
//
// command_add_instance
// {
//   pair<RefString, int> id;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   RefCSLOmExpr expr;
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:K_ADD_INSTANCE
//     ( id = identifier
//     {
//       if( scope.get() ){
//         scope->addHidItem( id.first );
//       }
//       else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//     }
//     )*
//     param_list_add_instance [scope]
//   )
// ;

//done
//REMOVED due to language change
//
// command_add_instance_list
// {
//   pair<RefString, int> id;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   RefCSLOmBase unit = RefCSLOmBase();
//   RefTVec_RefCSLOmBase vListParam;
// }
// :#(K_ADD_INSTANCE_LIST
//     ( id = identifier
//       {
//         if( scope.get() ){
//           scope->addHidItem( id.first );
//         }
//         else {
//           scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//       }
//     )*
//     param_list_add_instance_list [scope]
//   )
// ;

//done
//command_add_port
//{
//  pair<RefString, int> id;
//  RefCSLOmExprLink scope = RefCSLOmExprLink();
//}
//:#(K_ADD_PORT
//     (id=identifier
//     {
//       if( scope.get() ){
//        scope->addHidItem( id.first );
//       }
//       else {
//        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//      }
//     }
//    )*
//    param_list_add_port [scope]
//   )
//;

//done
//REMOVED due to language change
//
// command_add_port_list 
// {
//   pair<RefString, int> id;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
// }
// :#(K_ADD_PORT_LIST
//      (id=identifier
//      { 
//        if( scope.get() ){
//         scope->addHidItem( id.first );
//        }
//        else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//      }
//      )*
//      param_list_add_port_list [scope]
//    )
// ;

//done
//command_add_port_group
//{
//  pair<RefString, int> id;
//  RefCSLOmExprLink scope = RefCSLOmExprLink();
//  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
//  ECSLOmPortDirection portDirection;
//  RefCSLOmSetCommand command = RefCSLOmSetCommand();
//  RefCSLOmExpr expr;
//}
//:#(tok:K_ADD_PORT_GROUP
//    id=identifier
//    { 
//      if( scope.get() )
//        scope->addHidItem( id.first );
//      else
//        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//    }
//    ( K_INPUT  { portDirection = INPUT;  }
//    | K_OUTPUT { portDirection = OUTPUT; }
//    | K_INOUT  { portDirection = INOUT;  }
//    )
//    expr=expression
//    {
//      params->push_back(expr);
//    }
//  )
//  {
//   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_PORT_GROUP, params);
//   CSLOmSetCommand::addEnumParam(portDirection);
//  }
//;

//TODO see how it is implemented in cslom so that you can include the testbench variants
command_set_type  
{
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
}
:#(tok:K_SET_TYPE
     (id=identifier
      {
        if( scope.get() ){
          scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
        }
      }
     )*
    ( kw:       K_WIRE        {signalType = NSCSLOm::SIGNAL_WIRE;        }   
    | kr:       K_REG         {signalType = NSCSLOm::SIGNAL_REG;         }
    | ktri:     K_TRI         {signalType = NSCSLOm::SIGNAL_TRI;         }
    | ktriand:  K_TRIAND      {signalType = NSCSLOm::SIGNAL_TRIAND;      }
    | ktrior:   K_TRIOR       {signalType = NSCSLOm::SIGNAL_TRIOR;       }
    | ktri0:    K_TRI0        {signalType = NSCSLOm::SIGNAL_TRI0;        }
    | ktri1:    K_TRI1        {signalType = NSCSLOm::SIGNAL_TRI1;        }
    | ktrireg:  K_TRIREG      {signalType = NSCSLOm::SIGNAL_TRIREG;      }
    | kwand:    K_WAND        {signalType = NSCSLOm::SIGNAL_WAND;        }
    | kwor:     K_WOR         {signalType = NSCSLOm::SIGNAL_WOR;         }
    | ksupply0: K_SUPPLY0     {signalType = NSCSLOm::SIGNAL_SUPPLY_0;    }
    | ksupply1: K_SUPPLY1     {signalType = NSCSLOm::SIGNAL_SUPPLY_1;    }
    | kinteger: K_INTEGER     {signalType = NSCSLOm::SIGNAL_VAR_INTEGER; }
    | kreal:    K_REAL        {signalType = NSCSLOm::SIGNAL_VAR_REAL;    }
    | krealtime:K_REALTIME    {signalType = NSCSLOm::SIGNAL_VAR_REALTIME;}
    | ktime:    K_TIME        {signalType = NSCSLOm::SIGNAL_VAR_TIME;    }
    // Disabled the below lines; Reason: not working
    //| kflat:    "flat"                       {mmType = MM_FLAT;                                     isMemMap = TRUE;}
    //| khierar:  "hierarchical"               {mmType = MM_HIERARCHICAL;                             isMemMap = TRUE;}
    //| kvirtual1: "virtual_with_base_address" {mmType = MM_VIRTUAL_W_BASE_ADDR;                      isMemMap = TRUE;}
    //| kvirtual2: "virtual_with_page_number"  {mmType = MM_VIRTUAL_W_PAGE_NO;                        isMemMap = TRUE;}
    | kflat:    K_FLAT                       {mmType = MM_FLAT;                                     isMemMap = TRUE;}
    | khierar:  K_HIERARCHICAL               {mmType = MM_HIERARCHICAL;                             isMemMap = TRUE;}
    | kvirtual1:K_VIRTUAL_WITH_BASE_ADDRESS  {mmType = MM_VIRTUAL_W_BASE_ADDR;                      isMemMap = TRUE;}
    | kvirtual2:K_VIRTUAL_WITH_PAGE_NUMBER   {mmType = MM_VIRTUAL_W_PAGE_NO;                        isMemMap = TRUE;}
      //setting isa field type
    | kopcode    :K_OPCODE                   {isafType = CSLOmIsaField::ISA_FIELD_OPCODE;           isIsaField = TRUE;}
    | ksbopcode  :K_SUBOPCODE                {isafType = CSLOmIsaField::ISA_FIELD_SUBOPCODE;        isIsaField = TRUE;}
      //    | kaddress   :K_ADDRESS                  {isafType = CSLOmIsaField::ISA_FIELD_ADDRESS;          isIsaField = TRUE;}
    | kselector  :K_SELECTOR                 {isafType = CSLOmIsaField::ISA_FIELD_SELECTOR;         isIsaField = TRUE;}
    | kconstant  :K_CONSTANT                 {isafType = CSLOmIsaField::ISA_FIELD_CONSTANT;         isIsaField = TRUE;}
    | krfaddress :K_RF_ADDRESS               {isafType = CSLOmIsaField::ISA_FIELD_RF_ADDR;          isIsaField = TRUE;}
    | kmemaddress:K_MEM_ADDRESS              {isafType = CSLOmIsaField::ISA_FIELD_MEM_ADDR;         isIsaField = TRUE;}
    | kim        :K_IM                       {isafType = CSLOmIsaField::ISA_FIELD_IM;               isIsaField = TRUE;}
    | kunused    :K_UNUSED                   {isafType = CSLOmIsaField::ISA_FIELD_UNUSED;           isIsaField = TRUE;}
    | kreserved  :K_RESERVED                 {isafType = CSLOmIsaField::ISA_FIELD_RESERVED;         isIsaField = TRUE;}
    | kbranchaddr:K_BRANCH_ADDRESS           {isafType = CSLOmIsaField::ISA_FIELD_BRANCH_ADDRESS;   isIsaField = TRUE;}
      //    | kbranchsel :K_BRANCH_SELECT            {isafType = CSLOmIsaField::ISA_FIELD_BRANCH_SELECT;    isIsaField = TRUE;}
      //setting isa element type
    | kinstrfmt:K_INSTR_FORMAT      { isaElemType = CSLOmIsaElement::ISA_ELEM_FORMAT; isIsaElem = TRUE; }
    | kinstr   :K_INSTR             { isaElemType = CSLOmIsaElement::ISA_ELEM_INSTR ; isIsaElem = TRUE; }
    | krootfmt :K_ROOT_FORMAT       { isaElemType = CSLOmIsaElement::ISA_ELEM_ROOT  ; isIsaElem = TRUE; }
       //setting register type
    | K_COUNTER                              {regType = CSLOmRegDeclInfo::REG_DECL_COUNTER ;  isRegType = TRUE; }
    | K_REGISTER                             {regType = CSLOmRegDeclInfo::REG_DECL_REGISTER;  isRegType = TRUE; }
    //units type
    | K_COMBINATIONAL               { DCERR("[ WARNING ] Walker: If you can read this, it means that this type: COMBINATIONAL, passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse"); }
    | K_SEQUENTIAL                  { DCERR("[ WARNING ] Walker: If you can read this, it means that this type: SEQUENTIAL, passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse"); }
      /*v2.0 types
    | K_ACT                                  {regType = CSLOmRegisterInfo::REG_ACT      ;  isRegType = TRUE; }
    | K_ATOM                                 {regType = CSLOmRegisterInfo::REG_ATOM     ;  isRegType = TRUE; }
    | K_CNT                                  {regType = CSLOmRegisterInfo::REG_CNT      ;  isRegType = TRUE; }
    | K_CTL                                  {regType = CSLOmRegisterInfo::REG_CTL      ;  isRegType = TRUE; }
    | K_DFF                                  {regType = CSLOmRegisterInfo::REG_DFF      ;  isRegType = TRUE; }
    | K_EVNT                                 {regType = CSLOmRegisterInfo::REG_EVNT     ;  isRegType = TRUE; }
    | K_INT                                  {regType = CSLOmRegisterInfo::REG_INT      ;  isRegType = TRUE; }
    | K_LFSR                                 {regType = CSLOmRegisterInfo::REG_LFSR     ;  isRegType = TRUE; }
    | K_SFT                                  {regType = CSLOmRegisterInfo::REG_SFT      ;  isRegType = TRUE; }
    | K_SEMA                                 {regType = CSLOmRegisterInfo::REG_SEMA     ;  isRegType = TRUE; }
    | K_STATISTIC                            {regType = CSLOmRegisterInfo::REG_STATISTIC;  isRegType = TRUE; }
    | K_STATUS                               {regType = CSLOmRegisterInfo::REG_STATUS   ;  isRegType = TRUE; }
      */
    | expr = expression                      
      {
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
      }
    )

    //( K_DIAGNOSTIC
    //| K_STIM_EXPECT
    //| K_SERIAL_BUS
    //)?
   )
 {
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
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_TYPE, params);
   //std::cerr << "after build command" << std::endl;
 }
;

//done
//REMOVED due to language change
//
//TODO see how it is implemented in cslom so that you can include the testbench variants
// command_add_interface 
// {
//   pair <RefString, int> id;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   ECSLOmPortDirection portDirection = DIR_UNDEFINED;
//   RefCSLOmSetCommand command = RefCSLOmSetCommand();
//   RefCSLOmExpr expr;
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:K_ADD_INTERFACE
//     ( id = identifier
//      {
//        if( scope.get() ){
//         scope->addHidItem( id.first );
//        }
//        else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//      }
//     )*
//     (  K_INPUT  { portDirection = INPUT;  }
//      | K_OUTPUT { portDirection = OUTPUT; }
//      | K_INOUT  { portDirection = INOUT;  }
//     )?
//     ( expr=expression
//       {
//        params->push_back(expr);
//       }
//     )+
//   )
//   {
//    CSLOmSetCommand::addEnumParam(portDirection, NSCSLOm::TYPE_CMD_ADD_INTERFACE);
//    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_INTERFACE, params);
//   }
// ;
// 
// //done
// command_add_signal 
// {
//   pair<RefString, int> id;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   RefCSLOmExpr expr;
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(K_ADD_SIGNAL
//      (id=identifier
//      {
//        if( scope.get() ){
//         scope->addHidItem( id.first );
//        }
//        else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//      }
//      )*
//      param_list_add_signal [scope]
//    )
// ;

//done, but not implemented in CSLOM
// REMOVED due to language change
//
// command_add_signal_list 
// {
//   pair<RefString, int> id;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
// }
// :#(K_ADD_SIGNAL_LIST
//      (id=identifier
//      {
//        if( scope.get() ){
//         scope->addHidItem( id.first );
//        }
//        else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//      }
//      )*
//      param_list_add_signal_list [scope]
//    )
// ;

//done
//REMOVED due to language change
//
// command_add_signal_group 
// {
//   pair<RefString, int> id;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   RefCSLOmExpr signalGroup;
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:K_ADD_SIGNAL_GROUP
//      (id=identifier
//       {
//         if( scope.get() ){
//         scope->addHidItem( id.first );
//         }
//         else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//       }
//      )*
//      (signalGroup = expression
//       {
//         params->push_back(signalGroup);
//       }
//      )*
//    )
//    {
//     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_SIGNAL_GROUP, params);
//    }
// ;

//to be implemented in CSLOM
command_add_clock
{
 pair <RefString,int> id;
 RefCSLOmExpr clock;
}
:#(tok:K_ADD_CLOCK
    id=identifier
    (clock=expression)*
  )
  {
   //to be implemeted in CSLOM
  }
;

//to be implemented in CSLOM
command_add_reset
{
 pair <RefString,int> id;
 RefCSLOmExpr reset;
}
:#(tok:K_ADD_RESET
    id=identifier
    (reset=expression)*
  )
  {
   //to be implemeted in CSLOM
  }
;

//to be implemented in CSLOM
command_add_equation
{
 pair <RefString,int> id;
 RefCSLOmExpr eq;
}
:#(tok:K_ADD_EQUATION
    id=identifier
    (eq=expression)*
  )
  {
   //to be implemeted in CSLOM
  }
;

command_add_address_range               //memory map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr lowerExpr;
  RefCSLOmExpr upperExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_ADD_ADDRESS_RANGE
    ( id = identifier
     {
       hasIdentifier = true;
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    lowerExpr = expression
    {
      params->push_back(lowerExpr);
    }
    upperExpr = expression
    {
      params->push_back(upperExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_ADD_ADDRESS_RANGE, params);
    } else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_ADD_ADDRESS_RANGE, params);
    } 
  }
;

command_set_address_increment           //memory map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr incrExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_ADDRESS_INCREMENT
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    incrExpr = expression
    {
     params->push_back(incrExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_ADDRESS_INCREMENT, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ADDRESS_INCREMENT, params);
    }
  }
;

command_set_next_address                //memory map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr nextAddrExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_NEXT_ADDRESS
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
         scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    nextAddrExpr = expression
    {
      params->push_back(nextAddrExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_NEXT_ADDRESS, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_NEXT_ADDRESS, params);
    }
  }
;

command_add_reserved_range              //memory map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr lowerAddrExpr;
  RefCSLOmExpr upperAddrExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_ADD_RESERVED_ADDRESS_RANGE
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    lowerAddrExpr = expression
    {
     params->push_back(lowerAddrExpr);
    }
    upperAddrExpr = expression
    {
     params->push_back(upperAddrExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_ADD_RESERVED_RANGE, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_ADD_RESERVED_RANGE, params);
    }
  }
;

command_add                             //memory map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_ADD
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    (expr = expression
      {
        //DCERR("found expression -----------------------------------");
        params->push_back(expr);
      }
    )*
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_ADD, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_ADD, params);
    }
  }
;

command_set_data_word_width             //memory map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr widthExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_DATA_WORD_WIDTH
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    widthExpr = expression
    {
     params->push_back(widthExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_DATA_WORD_WIDTH, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_DATA_WORD_WIDTH, params);
    }
  }
;

command_set_alignament                  //memory map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr alignExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_ALIGNMENT
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    alignExpr = expression
    {
      params->push_back(alignExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_ALIGNMENT, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ALIGNMENT, params);
    }
  }
;

command_set_endianess                   //memory map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr endianExpr;
  CSLOmMemoryMapPage::Endianess endianessType;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_ENDIANESS
    ( id = identifier
     {
       hasIdentifier = true;
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    ( K_BIG_ENDIAN            { endianessType = CSLOmMemoryMapPage::ENDIAN_BIG;    }
    | K_LITTLE_ENDIAN         { endianessType = CSLOmMemoryMapPage::ENDIAN_LITTLE; }
    | endianExpr = expression { params->push_back(endianExpr);                     }
    )
  )
  {
    CSLOmSetCommand::addEnumParam(endianessType, NSCSLOm::TYPE_CMD_SET_ENDIANESS);
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_ENDIANESS, params);
    } else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ENDIANESS, params);
    }
  }

;

command_set_symbol_max_length           //memory map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr lengthExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_SYMBOL_MAX_LENGTH
    ( id = identifier
     {
       hasIdentifier = true;
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    lengthExpr = expression
    {
     params->push_back(lengthExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_SYMBOL_MAX_LENGTH, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_SYMBOL_MAX_LENGTH, params);
    }
  }
;

command_set_prefix                      //memory map <- not yet; for now: csl_interface & csl_signal_group
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr prefixExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_PREFIX
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
         scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    prefixExpr = expression
    {
      ASSERT(prefixExpr.get(),"NULL prefix expr");
      params->push_back(prefixExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_PREFIX, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_PREFIX, params);
    }
  }
;

command_no_prefix                      //memory map <- not yet; for now: csl_interface & csl_signal_group
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_NO_PREFIX_COMMAND
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
         scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_NO_PREFIX, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_NO_PREFIX, params);
    }
  }
)
;

command_set_suffix                      //memory map
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr suffixExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_SUFFIX
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ){
         scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    suffixExpr = expression
    {
      params->push_back(suffixExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_SUFFIX, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_SUFFIX, params);
    }
  }
;

//to be implemented in CSLOM
command_set_dut_mem
{
 pair <RefString,int> id;
 RefCSLOmExpr expr;
}
:#(tok:K_SET_DUT_MEM
    id=identifier
    (expr=expression)*
  )
  {
   //to be implemented in CSLOM
  }
;

//to be implemented in CSLOM
command_set_dut_mem_init
{
 pair <RefString,int> id;
 RefCSLOmExpr expr;
}
:#(tok:K_SET_DUT_MEM_INIT
    id=identifier
    (expr=expression)*
  )
  {
   //to be implemented in CSLOM
  }
;

//done (Assert m_ref failed)
//REMOVED due to language change
//
// command_add_unit_parameter 
// {
//   pair<RefString, int> id;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
// }
// :#(K_ADD_UNIT_PARAMETER
//      (id=identifier
//      {
//        if( scope.get() ){
//         scope->addHidItem( id.first );
//        }
//        else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//      }
//      )*
//      param_list_add_unit_parameter [scope]
//    )
// ;

command_override_parameter 
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefCSLOmExpr expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_OVERRIDE_PARAMETER
     (id=identifier
     {
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
     )*
    expr1 = expression
    expr2 = expression
   )
 {
    ASSERT(expr1.get() && expr2.get(), "override_parameter method requires 2 arguments");
    params->push_back(expr1);
    params->push_back(expr2);
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_OVERRIDE_UNIT_PARAMETER, params);
 } 
;

//done
//param_list_override_unit_parameter [NSCSLOm::RefCSLOmExprLink scope] 
//{ 
//
//pair <RefString, int> id;
//RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
//RefCSLOmExprLink parameterNameExprLink;
//}
//:#(tok:PARAM_LIST_OVERRIDE_UNIT_PARAMETER
//  id=identifier
//  {
//    parameterNameExprLink = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//    params->push_back(parameterNameExprLink);
//  }
//  expr=expression
//  { 
//   params->push_back(expr); 
//  }
//{
//  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_OVERRIDE_UNIT_PARAMETER, params);
//}
//)
//;

//to be implemented in CSLOM
command_add_arch_state
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefCSLOmExpr expr;
}
:#(tok:K_ADD_ARCH_STATE
     (id=identifier
     {
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
      }
     )*
     expr=expression
   )
   {
     //to be implemented in CSLOM
   }
;

command_set_port_name
{
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  EPortNames portName = PN_UNDEFINED;
  TInt lineNumber;
  RefString fileName;
}
:(#(toka:K_SET_RESET_NAME { portName = PN_RESET; fileName = _RS(#toka->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName ,id.first);
       }
     }
    )*
   (
    expr = tok1:expression { lineNumber = #tok1->getLine(); }
    )
   )
  |
  #(tokb:K_SET_CLOCK_NAME { portName = PN_CLOCK; fileName = _RS(#tokb->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName ,id.first);
       }
     }
    )*
   (
    expr = tok2:expression { lineNumber = #tok2->getLine(); }
    )
   )
  |
  #(tokc:K_SET_WR_DATA_NAME { portName = PN_DATA_IN; fileName = _RS(#tokc->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok3:expression { lineNumber = #tok3->getLine(); }
    )
   )
  |
  #(tokd:K_SET_RD_DATA_NAME { portName = PN_DATA_OUT; fileName = _RS(#tokd->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok4:expression { lineNumber = #tok4->getLine(); }
    )
   )
  |
  #(toke:K_SET_VALID_NAME { portName = PN_VALID; fileName = _RS(#toke->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok5:expression { lineNumber = #tok5->getLine(); }
    )
    )
  |
  //Register File Specific port names
  #(tokf:K_SET_WR_ADDR_NAME { portName = PN_WR_ADDR; fileName = _RS(#tokf->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok6:expression { lineNumber = #tok6->getLine(); }
    )
   )
  |
  #(tokg:K_SET_RD_ADDR_NAME { portName = PN_RD_ADDR; fileName = _RS(#tokg->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok7:expression { lineNumber = #tok7->getLine(); }
    )
   )
  |
  #(tokh:K_SET_WR_EN_NAME { portName = PN_WR_EN; fileName = _RS(#tokh->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok8:expression { lineNumber = #tok8->getLine(); }
    )
   )
  |
  #(toki:K_SET_RD_EN_NAME { portName = PN_RD_EN; fileName = _RS(#toki->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok9:expression { lineNumber = #tok9->getLine(); }
    )
   )
  |
  //FIFO Specific port names
  #(tokj:K_SET_WR_CLOCK_NAME { portName = PN_WR_CLOCK; fileName = _RS(#tokj->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok10:expression { lineNumber = #tok10->getLine(); }
    )
    )
  |
  #(tokk:K_SET_RD_CLOCK_NAME { portName = PN_RD_CLOCK; fileName = _RS(#tokk->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok11:expression { lineNumber = #tok11->getLine(); }
    )
    )
  |
  #(tokl:K_SET_PUSH_NAME { portName = PN_PUSH; fileName = _RS(#tokl->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok12:expression { lineNumber = #tok12->getLine(); }
    )
    )
  |
  #(tokm:K_SET_POP_NAME { portName = PN_POP; fileName = _RS(#tokm->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok13:expression { lineNumber = #tok13->getLine(); }
    )
    )
  |
  #(tokn:K_SET_FULL_NAME { portName = PN_FULL; fileName = _RS(#tokn->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok14:expression { lineNumber = #tok14->getLine(); }
    )
    )
  |
  #(toko:K_SET_EMPTY_NAME { portName = PN_EMPTY; fileName = _RS(#toko->getFilename()); }
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, fileName, id.first);
       }
     }
    )*
   (
    expr = tok15:expression { lineNumber = #tok15->getLine(); }
    )
    )
  )
   {
     params->push_back(expr);
     CSLOmSetCommand::addEnumParam(portName, NSCSLOm::TYPE_CMD_SET_PORT_NAME);
     CSLOmSetCommand::build(lineNumber, fileName, design, scope, NSCSLOm::TYPE_CMD_SET_PORT_NAME, params);     
   }
;

command_set_instance_name
{
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_MEM_INSTANCE_NAME
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()),id.first);
       }
     }
    )*
   (
    expr = tok1:expression
    {
      params->push_back(expr);
      CSLOmSetCommand::build(#tok1->getLine(), _RS(#tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_INSTANCE_NAME, params);
    }
    )
)
;

command_set_unit_name
{
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_UNIT_NAME
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()),id.first);
       }
     }
    )*
   (
    expr = tok1:expression
    {
      params->push_back(expr);
      CSLOmSetCommand::build(#tok1->getLine(), _RS(#tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_MODULE_NAME, params);
    }
    )
)
;

command_set_direction
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  ECSLOmPortDirection mPortDirection =  NSCSLOm::DIR_UNDEFINED;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_DIRECTION
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()),id.first);
       }
     }
    )*
   (
    K_OUTPUT { mPortDirection = OUTPUT; }
   |K_INPUT  { mPortDirection = INPUT;  }
    )
   )
   {
     CSLOmCmdVSDSetDirection::setDirectionParam(mPortDirection);
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_DIRECTION, params);
   }
;

command_exclusion_list
{
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_EXCLUSION_LIST
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), id.first);
       }
     }
    )*
   (
    expr = tok1:expression
    {
      params->push_back(expr);
    }
    )*
    {
      CSLOmSetCommand::build(#tok1->getLine(), _RS(#tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_EXCLUDE_ONLY, params);
    }
)
;

command_include_only
{
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_INCLUDE_ONLY
   ( id = identifier
     {
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), id.first);
       }
     }
    )*
   (
    expr = tok1:expression
    {
      params->push_back(expr);
    }
    )*
    {
      CSLOmSetCommand::build(#tok1->getLine(), _RS(#tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_INCLUDE_ONLY, params);
    }
)
;

command_set_vc_id
{
  pair<RefString,int> id;
  RefCSLOmExpr expr;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_ID
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_NUMERIC_ID, params);
 }
;

command_set_vc_name
{
  pair<RefString,int> id;
  RefCSLOmExpr expr;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_NAME
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_NAME, params);
 }
;

command_set_vc_header_comment
{
  pair<RefString,int> id;
  RefCSLOmExpr expr;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_HEADER_COMMENT
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_HEADER_COMMENT, params);
 }
;

command_set_vc_version
{
  pair<RefString,int> id;
  RefCSLOmExpr expr;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VERSION
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_VERSION, params);
 }
;

command_set_radix
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  CSLOmVerifCompInfo::ECSLOmVCRadix mRadixType = NSCSLOm::CSLOmVerifCompInfo::VC_RADIX_UNDEFINED;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_RADIX
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   (
     K_BIN             { mRadixType = NSCSLOm::CSLOmVerifCompInfo::VC_RADIX_BIN; }
    |K_HEX             { mRadixType = NSCSLOm::CSLOmVerifCompInfo::VC_RADIX_HEX; }
    //used for function returns
    |expr = expression { params->push_back(expr);                                }

    )
   )
   {
     CSLOmCmdVSDSetRadix::setRadixTypeParam(mRadixType);
     CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_RADIX, params);
   }
;

command_set_vc_clock
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_CLOCK
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_CLOCK, params);
 }
;

command_set_vc_reset
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_RESET
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_RESET, params);
 }
;

command_set_vc_stall
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_STALL
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_STALL, params);
 }
;

command_set_vc_compare_trigger
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_COMPARE_TRIGGER
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_COMPARE_TRIGGER, params);
 }
;

command_set_vc_start_generation_trigger
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_START_GENERATION_TRIGGER
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_START_GENERATION_TRIGGER, params);
 }
;

command_set_vc_end_generation_trigger
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_END_GENERATION_TRIGGER
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_END_GENERATION_TRIGGER, params);
 }
;

command_set_vc_capture_edge_type
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  CSLOmVerifCompInfo::ECSLOmVCEdgeType mEdgeType = NSCSLOm::CSLOmVerifCompInfo::VC_EDGE_UNDEFINED;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_CAPTURE_EDGE_TYPE
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   (
     K_RISE { mEdgeType = NSCSLOm::CSLOmVerifCompInfo::VC_EDGE_RISE; }
    |K_FALL { mEdgeType = NSCSLOm::CSLOmVerifCompInfo::VC_EDGE_FALL; }
    )
   )
   {
     CSLOmCmdVSDSetCaptureEdgeType::setEdgeTypeParam(mEdgeType);
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_CAPTURE_EDGE_TYPE, params);
   }
;

command_set_vc_max_cycles
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_MAX_CYCLES
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_MAX_CYCLES, params);
 }
;

command_set_vc_max_number_of_capture_events
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_MAX_NUMBER_OF_CAPTURE_EVENTS
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_MAX_EVENTS_COUNT, params);
 }
;

command_set_vc_max_number_of_valid_transactions
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_MAX_NUMBER_OF_VALID_TRANSACTIONS
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_NUM_OF_TRANSACTION, params);
 }
;

command_set_vc_max_number_of_mismatches
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_MAX_NUMBER_OF_MISMATCHES
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_MAX_MISMATCHES_COUNT, params);
 }
;

command_set_vc_timeout
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_TIME_OUT
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_TIMEOUT, params);
 }
;

command_set_vc_output_filename
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_OUTPUT_FILENAME
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_OUTPUT_FILENAME, params);
 }
;

command_set_vc_cpp_rd_name
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_CPP_RD_NAME
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_CPP_RD_NAME, params);
 }
;

command_set_vc_cpp_wr_name
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_CPP_WR_NAME
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_CPP_WR_NAME, params);
 }
;


command_set_vc_max_num_states
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_VC_MAX_NUM_STATES
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_VSD_SET_MAX_NUM_STATES, params);
 }
;

command_assign
{
  pair<RefString, int> id;
  TBool hasRangeExpr = FALSE;
  RefCSLOmExpr range_expr1, range_expr2;
  TBool hasSecondExpr = FALSE;
  RefCSLOmSimpleBitRange br = RefCSLOmSimpleBitRange();
  RefCSLOmExpr expr1, expr2;
  TBool hasId = FALSE;
  TBool negDirPartSel = FALSE;
}
:#(tok:ASSIGN
   (
    //    ( #(RANGE_EXPRESSION (id)+ expression (COLON | PO_NEG)) )=>
    (id = identifier
    {
      //creating expr1 of the assign as CSLOmExprLink 
      if(!expr1.get()){
        expr1 = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()),id.first);
      }
      else{
        (CSLOmExprLink::cast(expr1))->addHidItem(id.first);
      }
    }
     )+

    ( 
     #(tokrange:RANGE_EXPRESSION  {hasRangeExpr = TRUE; } range_expr1 = expression 
       (
        (COLON | PO_NEG {negDirPartSel = TRUE;})? 
        range_expr2 = expression { hasSecondExpr = TRUE; } 
       )? 
      ) 
     )?

    { 
      if (hasRangeExpr) {
        if(!hasSecondExpr){
          br = CSLOmSimpleBitRange::build(id.second, _RS(#tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr1);
        }
        else{
          br = CSLOmSimpleBitRange::build(id.second, _RS(#tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr2);
        }
        CSLOmExprLink::cast(expr1)->setBitRange(br);
        if (negDirPartSel) { CSLOmExprLink::cast(expr1)->setPartSelectDir(CSLOmExprLink::PS_DIR_DESC); }
      }
    }

    |
    (
     #(K_TO_USE_FOR_NONDETERMINISM_IN_WALKER

      expr1 = expression
       )
     )
    )
    (ASSIGNOR
    (
     expr2 = expression 
     )
    )
    )
  {
    RefCSLOmStmtAssign stmtAssn = CSLOmStmtAssign::build(expr1->getLineNumber(), _RS(#tok->getFilename()), design, expr1, expr2);
  }
;

command_set_name
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_NAME
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   expr = expression
  { 
    params->push_back(expr);
  }
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_NAME, params);
 }
;

command_do_not_gen_rtl
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_DO_NOT_GEN_RTL
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_NO_GEN_RTL, params);
 }
;

command_do_not_gen_cpp
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_DO_NOT_GEN_CPP
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_DO_NOT_GEN_CPP, params);
 }
;


command_gen_unique_rtl_modules
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_GEN_UNIQUE_RTL_MODULES
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
  )
 { 
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_GEN_UNIQUE_RTL_MODULES, params);
 }
;

command_set_clock
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_CLOCK
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
   (
    expr = tok1:expression
    {
      params->push_back(expr);
      CSLOmSetCommand::build(#tok1->getLine(), _RS(#tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_CLOCK, params);
    }
   )
)
;

command_register_ios
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope;
  RefCSLOmExpr expr1, expr2, expr3;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool wasReset = FALSE;
}
:#(tok:K_REGISTER_IOS
   (id = identifier
    { if(scope.get()){
        scope->addHidItem( id.first ); 
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
  {   }
   (
     K_INPUT  {/* add direction */ }
   | K_OUTPUT {/* add direction */ }
   )
   (   #( K_RESET  { wasReset = TRUE; /* set positive assert reset  */ } expr1 = tok1:expression )
     | #( K_RESET_ { wasReset = TRUE; /* set negative assert reset  */ } expr1 = tok2:expression )
   )?
    {
      //params->push_back(expr1);
    }
   (
     { wasReset }?
     expr2 = expression //reset value
   )?
   ( #(K_ENABLE { /* set enable */ } expr3 = tok3:expression
    {
      //params->push_back(expr2);
    }
   ))?
    {      
      //CSLOmSetCommand::build(#tok1->getLine(), _RS(#tok1->getFilename()), design, scope, NSCSLOm::TYPE_CMD_REGISTER_IOS, params);
    }
   )
;

//done
command_set_unit_prefix 
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefCSLOmExpr prefix;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_UNIT_PREFIX 

    ( id=identifier
      {
        if( scope.get() ){
          scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
      }
    )*
    prefix = expression
     {
        params->push_back(prefix);
     }
   )
   {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_UNIT_PREFIX, params);
   }
;

//done
command_set_signal_prefix 
{
  pair<RefString, int> id;
  RefCSLOmExpr prefix;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_SIGNAL_PREFIX
     (id=identifier
      {
        if( scope.get() ){
        scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
       }
      }
      )*
     ( prefix = expression
       {
         params->push_back(prefix);
       }
     )+
   )
   {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_SIGNAL_PREFIX, params);
   }
;

//done
command_set_signal_prefix_local 
{
  pair<RefString, int> id;
  RefCSLOmExpr prefix;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_SIGNAL_PREFIX_LOCAL
     (id=identifier
      {
        if( scope.get() ){
        scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
       }
     )*
     (prefix = expression
      {
        params->push_back(prefix);
      }
     )+
   )
   {
     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_SIGNAL_PREFIX_LOCAL, params);
   }
;

// done
// REMOVED - due to language change
//
// command_remove_signal
// {
//   pair<RefString, int> id;
//   RefCSLOmExpr expr;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:K_REMOVE_SIGNAL
//     id = identifier
//      {
//        if( scope.get() ){
//        scope->addHidItem( id.first );
//        }
//        else {
//        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//     }
//      }
//     expr = expression
//     {
//       params->push_back(expr);
//     }
//   )
//   {
//    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_REMOVE_SIGNAL, params);
//   }
// ;

// done
// REMOVED - due to language change
//
// command_remove_signal_list
// {
//   pair<RefString, int> id;
//   RefCSLOmExpr expr;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
//   RefCSLOmList list;
//   RefCSLOmExprLink exprLink;
// }
// :#(tok:K_REMOVE_SIGNAL_LIST
//     id = identifier
//      {
//        if( scope.get() ){
//        scope->addHidItem( id.first );
//        }
//        else {
//        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//     }
//      }
//     (expr = expression
//      {
//       params->push_back(expr);
//      }
//     )*
//     ( list = csl_anonymous_list_declaration | list = csl_list_declaration
//       {
//         exprLink = list->getListLink();
//         params->push_back(exprLink);
//       }
//     )?
//   )
//   {
//    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_REMOVE_SIGNAL_LIST, params);
//   }
// ;
// 
// REMOVED - due to language change
//
// command_remove_port
// {
//   pair<RefString, int> id;
//   RefCSLOmExpr expr;
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:K_REMOVE_PORT
//     id = identifier
//     {
//       if(scope.get())
//         scope->addHidItem( id.first );
//       else
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//     }
//     expr = expression
//     {
//       params->push_back(expr);
//       CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_REMOVE_PORT, params);
//     }
//   )
// ;
// 
// //to be added in parser 
// REMOVED - due to language change
// command_remove_port_list
// {
// }
// :
// ;

command_auto_connect_verilog_and_csl 
:#(K_AUTO_CONNECT_VERILOG_AND_CSL 
    param_list_auto_connect_verilog_and_csl 
   )
;

command_auto_connect_width_inference
://#(K_AUTO_CONNECT_WIDTH_INFERENCE
  ( K_AUTO_CONNECT_WIDTH_INFERENCE
//    param_list_auto_connect_width_inference;
  )
;

//to be added in CSLOM
command_set_compare_trigger
{
  pair<RefString, int> id;
  RefCSLOmExpr trigger;
}
:#(tok:K_SET_COMPARE_TRIGGER
    id=identifier
    trigger = expression
  )
  {
   //to be added in CSLOM
  }
;

//to be added in CSLOM
command_generate_waves
{
  pair<RefString, int> id;
  RefCSLOmExpr waveType;
}
:#(tok:K_GENERATE_WAVES
    id=identifier
    waveType = expression
  )
  {
   //to be added in CSLOM
  }
;

command_autorouter 
:#(K_AUTOROUTER
    param_list_autorouter
  )
;

//done
command_generate_individual_rtl_signals
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmSetCommand command = RefCSLOmSetCommand();
  TBool bitValue;
}
:#(tok:K_GENERATE_INDIVIDUAL_RTL_SIGNALS
    (id=identifier
    {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );  
     }
    }
    )*
    ( K_ON { bitValue = true; }
    | K_OFF { bitValue = false; }
    )
  )
  {
   CSLOmSetCommand::addEnumParam(bitValue, NSCSLOm::TYPE_CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS);
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS, params);
  }
;

// done
command_set_width 
{
  pair<RefString, int> id;
  RefCSLOmExpr width;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_WIDTH
    ( id = identifier
    { if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );  
      }
    }
    )*
    width = expression
    {
      params->push_back(width);
    }
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_WIDTH,params);
  }
;

command_set_depth 
{
  pair<RefString, int> id;
  RefCSLOmExpr depth;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_DEPTH
    ( id = identifier
    {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );  
      }
    }
    )*
    depth = expression
    {
      params->push_back(depth);
    }
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_DEPTH,params);
  }
;

//done except combined with get_dim_width
command_set_dim_width 
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefCSLOmExpr expr1, expr2;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_DIM_WIDTH
    ( id = identifier
    {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
      }
    )*
    expr1 = expression
    {
      params->push_back(expr1);
    }
    expr2 = expression
    {
      params->push_back(expr2);
    }
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_DIM_WIDTH, params);
  }
;

command_set_value
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr valueExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool  hasIdentifier = FALSE;
}
:#(tok:K_SET_VALUE
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if(scope.get()) {
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    valueExpr = expression
    {
      params->push_back(valueExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_VALUE, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_VALUE, params);
    }
  }
;

command_set_enum
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr enumExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_ENUM
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if(scope.get()) {
         scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
       }
     }
    )*
    enumExpr = expression
    {
      params->push_back(enumExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_ENUM, params);
    } 
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ENUM, params);
    }
  }
;

command_set_enum_item
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr enum_item;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_ENUM_ITEM
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if(scope.get()) {
         scope->addHidItem(id.first);
       }
       else {
         scope = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()),id.first);
       }
     }
    )*
    enum_item = expression
    {
      params->push_back(enum_item);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_ENUM_ITEM, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_ENUM_ITEM, params);
    }
  }
;

command_set_position
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr fieldExpr, positionExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_POSITION
    ( id = identifier
      {
        hasIdentifier = TRUE;
        if( scope.get() ) {
          scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
        }
      }
    )*
    fieldExpr = expression
    {
      params->push_back(fieldExpr);
    }
    positionExpr = expression
    {
      params->push_back(positionExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_POSITION, params);
    } 
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_POSITION, params);
    }
  }
;

command_set_field_position
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr fieldExpr, positionExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_FIELD_POSITION
    ( id = identifier
      {
        hasIdentifier = TRUE;
        if( scope.get() ) {
          scope->addHidItem( id.first );
        }
        else {
          scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
        }
      }
    )*
    fieldExpr = expression
    {
      params->push_back(fieldExpr);
    }
    positionExpr = expression
    {
      params->push_back(positionExpr);
    }
  )
  {
    //Note: CMD uses the same enum as for set_position in this case
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_POSITION, params);
    } 
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_POSITION, params);
    }
  }
;

command_set_next
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr leftFieldExpr, rightFieldExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_NEXT
    ( id = identifier
     {
       hasIdentifier = TRUE;
       if( scope.get() ) {
         scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
       }
     }
    )*
    leftFieldExpr = expression
    {
      params->push_back(leftFieldExpr);
    }
    rightFieldExpr = expression
    {
      params->push_back(rightFieldExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_NEXT, params);
    } 
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_NEXT, params);
    }
  }
;

command_set_previous
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr leftFieldExpr, rightFieldExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_SET_PREVIOUS
    ( id = identifier
     {
      hasIdentifier = TRUE;
      if( scope.get() ) {
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    rightFieldExpr = expression
    {
      params->push_back(rightFieldExpr);
    }
    leftFieldExpr = expression
    {
      params->push_back(leftFieldExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_PREVIOUS, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_SET_PREVIOUS, params);
    }
  }
;

command_add_allowed_range
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr firstExpr, secondExpr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool hasIdentifier = FALSE;
}
:#(tok:K_ADD_ALLOWED_RANGE
    ( id = identifier
     {
      hasIdentifier = TRUE;
      if( scope.get() ) {
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    firstExpr = expression
    {
      params->push_back(firstExpr);
    }
    secondExpr = expression
    {
      params->push_back(secondExpr);
    }
  )
  {
    if(hasIdentifier) {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_ADD_ALLOWED_RANGE, params);
    }
    else {
      CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, RefCSLOmExprLink(), NSCSLOm::TYPE_CMD_ADD_ALLOWED_RANGE, params);
    }
  }
;

//done (except: sn.set_bitrange([4:0]))
command_set_bitrange 
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefCSLOmExpr bitRangeExpr;
  RefCSLOmExpr bitRange1;
  RefCSLOmExpr bitRange2;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  RefCSLOmBaseRange br;
}
:#(tok:K_SET_BITRANGE
    ( id = identifier
     {
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    ( bitRangeExpr = expression
      {
       params->push_back(bitRangeExpr);
      }
    | #(tok2:BITRANGE bitRange1 = expression bitRange2 = expression)
      { 
        br = CSLOmSimpleBitRange::build( #tok2->getLine(), _RS(#tok->getFilename()), design, _RS(""), bitRange1, bitRange2);
        params->push_back( br->getBitRangeLink());
      }
    )
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_BITRANGE, params);
  }
;

//done (except: sn.set_dim_bitrange(2,[4:0])
command_set_dim_bitrange 
{
  pair<RefString, int> id;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefCSLOmExpr dim, brObj;
  RefCSLOmBaseRange br;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_DIM_BITRANGE
    ( id = identifier
    {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    dim = expression //the dimension
    {
      params->push_back(dim);
    }
    ( brObj = expression //object
     {
      params->push_back(brObj);
     }
    //| br = bitrange_pure
     //{
     // params->push_back(br); //needs to be implemented in CSLOm
     //}
    )//
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DIM_BITRANGE, params);
  }
;

//done except: when args are combined with get commands
command_set_range 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr expr1, expr2;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_RANGE
    ( id = identifier
     {
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    (expr1 = expression//lower index
     {
      params->push_back(expr1);
     }
    )
    (expr2 = expression//upper index
     {
      params->push_back(expr2);
     }
    )
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_RANGE, params);
  }
;

//done except: set_lower_index(a.b.get_lower_index())
//REMOEVED due to language change 
//
// command_set_lower_index 
// {
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   pair<RefString, int> id;
//   RefCSLOmExpr index;
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:K_SET_LOWER_INDEX
//     ( id = identifier
//      {
//        if( scope.get() ){
//         scope->addHidItem( id.first );
//        }
//        else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//      }
//     )*
//     index = expression
//     {
//      params->push_back(index);
//     }
//   )
//   {
//     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_LOWER_INDEX, params);
//   }
// ;
// 
// 
// //done
// command_set_dim_lower_index 
// {
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   pair<RefString, int> id;
//   RefCSLOmExpr dimOrIndex;
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:K_SET_DIM_LOWER_INDEX
//     ( id = identifier
//      {
//        if( scope.get() ){
//         scope->addHidItem( id.first );
//        }
//        else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//      }
//     )*
//     ( dimOrIndex = expression
//       {
//        params->push_back(dimOrIndex);
//       }
//     )+
//   )
//   {
//    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_DIM_LOWER_INDEX, params);
//   }
// ;
// 
// //done
// command_set_upper_index 
// {
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   pair<RefString, int> id;
//   RefCSLOmExpr index = RefCSLOmExpr();
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:K_SET_UPPER_INDEX
//     ( id = identifier
//      {
//        if( scope.get() ){
//         scope->addHidItem( id.first );
//        }
//        else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//      }
//     )*
//     index = expression
//     {
//      params->push_back(index);
//     }
//   )
//   {
//     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_UPPER_INDEX, params);
//   }
// ;
// 
// //done
// command_set_dim_upper_index 
// {
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   pair<RefString, int> id;
//   RefCSLOmExpr dimOrIndex;
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:K_SET_DIM_UPPER_INDEX
//     ( id = identifier
//     {
//       if( scope.get() ){
//         scope->addHidItem( id.first );
//       }
//       else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//     }
//     )*
//     ( dimOrIndex = expression
//       {
//         params->push_back(dimOrIndex);
//       }
//     )+
//   )
//   {
//     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_DIM_UPPER_INDEX, params);
//   }
// ;

//done except:sn.set_offset(a.b.c.get_offset()) -> expression evaluation does not work
command_set_offset 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_OFFSET
   ( id = identifier
    {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
   }
    }
     )*
    expr = expression 
    {
      params->push_back(expr);
    }
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_OFFSET, params);
  }
;

//done except: involving get methods
command_set_dim_offset 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr dimension, offset;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_DIM_OFFSET
    ( id = identifier
    {
      if( scope.get() ){
       scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    (dimension = expression
     {
      params->push_back(dimension);
     }
    )
    (offset = expression
     {
      params->push_back(offset);
     }
    )
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_DIM_OFFSET, params);
  }
;

//done
command_set_number_of_dimensions 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefCSLOmExpr dimensionsNumber;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_NUMBER_OF_DIMENSIONS
    ( id = identifier
    {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    (dimensionsNumber = expression
     {
      params->push_back(dimensionsNumber);
     }
    )
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_NUMBER_OF_DIMENSIONS, params);
  }
;

//done
command_set_attr 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );  
  ECSLOmSignalAttr signalAttribute;
  RefCSLOmSetCommand command = RefCSLOmSetCommand();
}
:#(tok:K_SET_ATTR
    ( id = identifier
     {
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    ( K_ENABLE          { signalAttribute = ATTR_EN;    }
    | K_STALL           { signalAttribute = ATTR_STALL; }
    | K_PIPE_ENABLE     { signalAttribute = ATTR_PE;    }
    | K_PIPE_STALL      { signalAttribute = ATTR_PS;    }
    | K_MUX_SELECT      { signalAttribute = ATTR_MS;    }
    | K_DECODE          { signalAttribute = ATTR_DEC;   }
    | K_CLOCK_SIGNAL    { signalAttribute = ATTR_CLK;   }
    | K_RESET_SIGNAL    { signalAttribute = ATTR_RST;   }
    | K_WRITE_ENABLE    { signalAttribute = ATTR_WR_EN; }
    | expr = expression { params->push_back(expr);      }
    )
  )
  {
   CSLOmSetCommand::addEnumParam(signalAttribute, NSCSLOm::TYPE_CMD_SET_ATTR);
   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_ATTR, params);
  }
;

command_set_attributes
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );  
  RefCSLOmSetCommand command = RefCSLOmSetCommand();
}
:#(tok:K_SET_ATTRIBUTES
    ( id = identifier
     {
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
   //#(tok2:K_CSL_LIST
    (
      K_SHADOW
     |K_READ
     |K_WRITE
     |K_READ_WRITE
     )
   //)
   )
  {
    DCERR("[ WARNING ] Walker: If you can read this, it means that this command: set_attributes(csl_list(attributes)), passes but does not have support in the CMD; if it does, contact the walker person to correct this issuse");
  }
;

//to be implemented in cslom
command_set_transaction_timeout_counter
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_TRANSACTION_TIMEOUT_COUNTER
    ( id = identifier
     {
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    (
     expr=expression
    )*
  )
  {
    //to be added in cslom
  }
;

//to be implemented in cslom
command_set_simulation_timeout_counter
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr expr;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SIMULATION_TIMEOUT_COUNTER
    ( id = identifier
     {
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
     }
    )*
    expr=expression
  )
  {
    //to be added in cslom
  }
;

//command_concat  returns [ NSCSLOm::RefCSLOmBase concatObj ]
//{
//  RefCSLOmExprLink scope = RefCSLOmExprLink();
//  pair<RefString, int> id;
//  RefCSLOmExpr expr = RefCSLOmExpr();
//  RefCSLOmBaseRange br = RefCSLOmSimpleBitRange();
//  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase( new TVec_RefCSLOmBase );
//  concatObj = RefCSLOmBase();
//}
//:#(K_CONCAT
//    ( id = identifier
//    {
//     /*
//      if( scope.get() ){
//        scope->addHidItem( id.first );
//}
//      else {
//        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//}
//     */
//    }
//    )*
//    ( ( expr = expression
//      | br = bitrange_pure  )
//      {
//        if(expr.get()) {
//          objs->push_back(expr);
//        }
//        if(br.get()) {
//          objs->push_back(br);
//        }
//      }
//    )+
//    {
//      //concatObj = CSLOmCommand::concat(id.second, design, vCurrentScope, scope, objs);
//      objs->clear();
//    }
//  )
//;

//TODO
command_connect_by_name
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefCSLOmSimpleBitRange br;
  pair<RefString, int> id;
  RefCSLOmExpr lhsExpr;
  RefCSLOmExpr expr1, expr2;
  RefCSLOmExpr range_expr1, range_expr2;
  TBool hasLhsId = FALSE;
  TBool hasRangeExpr = FALSE, hasSecondExpr = FALSE, negDirPartSel = FALSE;
}
:#(tok1:K_CONNECT_BY_NAME
   (
    (id = identifier
     {
       if (!hasLhsId) { hasLhsId = TRUE; }
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok1->getFilename()), id.first );
     }
     }
     )*

   ( {hasLhsId}?
     #(tokrange:RANGE_EXPRESSION  {hasRangeExpr = TRUE; } range_expr1 = expression 
       (
        (COLON | PO_NEG {negDirPartSel = TRUE;})? 
        range_expr2 = expression { hasSecondExpr = TRUE; } 
       )? 
      ) 
     )?

    { 
      if (hasRangeExpr) {
        if(!hasSecondExpr){
          br = CSLOmSimpleBitRange::build(id.second, _RS(#tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr1);
        }
        else{
          br = CSLOmSimpleBitRange::build(id.second, _RS(#tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr2);
        }
        scope->setBitRange(br);
        if (negDirPartSel) { scope->setPartSelectDir(CSLOmExprLink::PS_DIR_DESC); }
      }
    }

    |
    #(K_TO_USE_FOR_NONDETERMINISM_IN_WALKER

      lhsExpr = expression
      )
    )


    expr1 = expression
    (expr2 = expression)?
   //params = param_list_connect [ scope ]
  {
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
  }
  )
;


command_connect_by_pattern
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefCSLOmSimpleBitRange br;
  pair<RefString, int> id;
  RefCSLOmExpr expr1, expr2;
  RefCSLOmExpr range_expr1, range_expr2;
  TBool hasLhsId = FALSE;
  TBool hasRangeExpr = FALSE, hasSecondExpr = FALSE, negDirPartSel = FALSE;
}
:#(tok2:K_CONNECT_BY_PATTERN
    (id = identifier
      {
        if (!hasLhsId) { hasLhsId = TRUE; }
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok2->getFilename()), id.first );
       }
     }
    )*
   
   ( {hasLhsId}?
     #(tokrange:RANGE_EXPRESSION  {hasRangeExpr = TRUE; } range_expr1 = expression 
       (
        (COLON | PO_NEG {negDirPartSel = TRUE;})? 
        range_expr2 = expression { hasSecondExpr = TRUE; } 
       )? 
      ) 
     )?

    { 
      if (hasRangeExpr) {
        if(!hasSecondExpr){
          br = CSLOmSimpleBitRange::build(id.second, _RS(#tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr1);
        }
        else{
          br = CSLOmSimpleBitRange::build(id.second, _RS(#tokrange->getFilename()), design, RefString(new std::string("")), range_expr1, range_expr2);
        }
        scope->setBitRange(br);
        if (negDirPartSel) { scope->setPartSelectDir(CSLOmExprLink::PS_DIR_DESC); }
      }
    }

    expr1 = expression
    (expr2 = expression)?
  {
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
  }
  )
;


command_connect_units
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr expr1, expr2;
}
:#(tok2:K_CONNECT_UNITS
     (id = identifier
      {
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok2->getFilename()), id.first );
       }
     }
    )*
    expr1 = expression 
    (expr2 = expression)?
  {
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
  }
  )
;

//done
// REMOVED due to syntax change
// command_connect_split
// {
//   RefCSLOmExprLink scope = RefCSLOmExprLink();
//   pair<RefString, int> id;
//   RefCSLOmExpr expr1, expr2;
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:K_CONNECT_SPLIT
//     ( id = identifier
//     {
//       if( scope.get() ){
//         scope->addHidItem( id.first );
//       }
//       else {
//         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//       }
//     }
//     )*
//     (expr1 = expression
//      {
//       params->push_back(expr1);
//      }
//     )*
//   )
//   {
//    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_CONNECT_SPLIT, params);
//   }
// ;

command_set_cell 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefCSLOmExpr expr;
}
:#(K_SET_CELL
    ( id = identifier
    {
     /*
      if( scope.get() ){
        scope->addHidItem( id.first );
}
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
}
     */
    }
    )*
    expr = expression
  )
;

command_merge 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
}
:#(K_MERGE
    ( id = identifier
    {
     /*
      if( scope.get() ){
        scope->addHidItem( id.first );
}
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
}
     */
    }
    )*
  )  
;

command_invert 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
}
:#(K_INVERT
    ( id = identifier
    {
     /*
      if( scope.get() ){
        scope->addHidItem( id.first );
}
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
}
     */
    }
    )*
  )
;

command_buffer 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
}
:#(K_BUFFER
    ( id = identifier
    {
     /*
      if( scope.get() ){
        scope->addHidItem( id.first );
}
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
}
     */
    }
    )*
  )
;

//done
command_reverse
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString, int> id;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_REVERSE
    (id=identifier
    {
      if( scope.get() ){
      scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
     )*
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_REVERSE, params);
  }
;

//done
command_input_verilog_type 
{
  EVerilogType verilogType;
  RefCSLOmSetCommand command = RefCSLOmSetCommand();
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  pair<RefString, int> id;
}
:#(tok:K_INPUT_VERILOG_TYPE
    id=identifier
    {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
    }
    }
    ( K_1995 { verilogType = v1995; }
    | K_2001 { verilogType = v2001; }
    ) //v2005 and sysverilog need to be added in cslom
  //param_list_input_verilog_type
  )
  {
    CSLOmSetCommand::addEnumParam(verilogType, NSCSLOm::TYPE_CMD_INPUT_VERILOG_TYPE);
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_INPUT_VERILOG_TYPE, params);
  }
;

//done
command_output_verilog_type 
{
  EVerilogType verilogType;
  RefCSLOmSetCommand command = RefCSLOmSetCommand();
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  pair<RefString, int> id;
}
:#(tok:K_OUTPUT_VERILOG_TYPE
    id=identifier
    {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
    }
    }
    ( K_1995 { verilogType = v1995; }
    | K_2001 { verilogType = v2001; }
    ) //v2005 and sysverilog need to be added in cslom
  )
  {
    CSLOmSetCommand::addEnumParam(verilogType, NSCSLOm::TYPE_CMD_OUTPUT_VERILOG_TYPE);
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_OUTPUT_VERILOG_TYPE, params);
  }
;

//done
command_set_dim_range  
{
  RefCSLOmExpr expr = RefCSLOmExpr(), expr2 = RefCSLOmExpr(), expr3 = RefCSLOmExpr();
  pair<RefString, int> id;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
}
:#(tok:K_SET_DIM_RANGE
    ( id = identifier
    {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
      }
    }
    )*
    ( expr = expression
      {
       params->push_back(expr);
      }
    )+
  )
  {
    CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()),design, scope, NSCSLOm::TYPE_CMD_SET_DIM_RANGE, params);
  }
;

nested_call 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair<RefString,int> id;
}
:#( tok:K_GET_SIGNAL_TYPE 
     ( id = identifier
     {
       if( scope.get() ){
        scope->addHidItem( id.first );
       }
       else {
         scope = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
       }
     }
    )*
     param_list_get_signal_type 
   )
;

bitrange_pure  returns [ NSCSLOm::RefCSLOmBaseRange br ]
{ 
  RefCSLOmExpr expr1;
  RefCSLOmExpr expr2;
  br = RefCSLOmSimpleBitRange();
  RefCSLOmSetCommand command = RefCSLOmSetCommand();
}
:#(brTok:BITRANGE expr1=expression expr2=expression)
{
  br = CSLOmSimpleBitRange::build( #brTok->getLine(), _RS(#brTok->getFilename()), design, RefString(new std::string("")), expr1, expr2 );
}
;

//done
// REMOVED due to syntax change
//
// param_list_add_signal [NSCSLOm::RefCSLOmExprLink scope] 
// {
//   RefCSLOmExpr expr,expr1,expr2;
//   RefCSLOmBitRange br = RefCSLOmBitRange();
//   RefCSLOmList list;
//   pair < RefString, int > id;
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
//   ECSLOmSignalType signalType;
//   RefCSLOmSetCommand command = RefCSLOmSetCommand();
//   int isUpperLowerBitRange = 0;
// }
// :#(tok:PARAM_LIST_ADD_SIGNAL
//     ( K_WIRE     {signalType = NSCSLOm::SIGNAL_WIRE;        }
//     | K_REG      {signalType = NSCSLOm::SIGNAL_REG;         }
//     | K_TRI      {signalType = NSCSLOm::SIGNAL_TRI;         } 
//     | K_TRIAND   {signalType = NSCSLOm::SIGNAL_TRIAND;      }
//     | K_TRIOR    {signalType = NSCSLOm::SIGNAL_TRIOR;       }
//     | K_TRI0     {signalType = NSCSLOm::SIGNAL_TRI0;        }
//     | K_TRI1     {signalType = NSCSLOm::SIGNAL_TRI1;        }
//     | K_TRIREG   {signalType = NSCSLOm::SIGNAL_TRIREG;      }
//     | K_WAND     {signalType = NSCSLOm::SIGNAL_WAND;        }
//     | K_WOR      {signalType = NSCSLOm::SIGNAL_WOR;         }
//     | K_SUPPLY0  {signalType = NSCSLOm::SIGNAL_SUPPLY_0;    }
//     | K_SUPPLY1  {signalType = NSCSLOm::SIGNAL_SUPPLY_1;    }
//     | K_INTEGER  {signalType = NSCSLOm::SIGNAL_VAR_INTEGER; }
//     | K_REAL     {signalType = NSCSLOm::SIGNAL_VAR_REAL;    }
//     | K_REALTIME {signalType = NSCSLOm::SIGNAL_VAR_REALTIME;}
//     | K_TIME     {signalType = NSCSLOm::SIGNAL_VAR_TIME;    }
//     )?
//     ( #(tokBitrange:BITRANGE 
//          expr1=expression 
//         (expr2=expression
//         {
//           //create the bitrange
//           br = CSLOmBitRange::build( #tokBitrange->getLine(), _RS(#tok->getFilename()), design, RefString(new string("")),  expr1, expr2);
//           isUpperLowerBitRange = 1;
//         }
//         )?
//       )
//     )?
//     expr=expression
//     { 
//       if(expr1.get()) {
//         if (isUpperLowerBitRange) { 
//           RefCSLOmExprLink el = br->getBitRangeLink();
//           params->push_back(br->getBitRangeLink()); 
//         } else { 
//           params->push_back(expr1); 
//         }
//       }
//       params->push_back(expr);
//     }
//   )
//   {
//     CSLOmSetCommand::addEnumParam(signalType, NSCSLOm::TYPE_CMD_ADD_SIGNAL);
//     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_SIGNAL, params);
//   }
// ;
// 
// //done, but not implemented in CSLOM
// param_list_add_signal_list [NSCSLOm::RefCSLOmExprLink scope] 
// {
//   RefCSLOmList list;
//   RefCSLOmExpr expr1    = RefCSLOmExpr(), 
//                expr2    = RefCSLOmExpr(), 
//                listExpr = RefCSLOmExpr();
//   RefCSLOmExprLink exprLink = RefCSLOmExprLink();
//   RefCSLOmBitRange br = RefCSLOmBitRange();
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
//   ECSLOmSignalType signalType = SIGNAL_UNDEFINED;
//   RefCSLOmSetCommand command  = RefCSLOmSetCommand();
//   int isUpperLowerBitRange = 0;
// }
// :#(tok:PARAM_LIST_ADD_SIGNAL_LIST
//      ( K_WIRE    { signalType = SIGNAL_WIRE;     }
//      | K_REG     { signalType = SIGNAL_REG;      }
//      //| K_TRI     { signalType = SIGNAL_TRI;      }
//      | K_TRIAND  { signalType = SIGNAL_TRIAND;   }
//      | K_TRIOR   { signalType = SIGNAL_TRIOR;    }
//      //| K_TRI0    { signalType = SIGNAL_TRI0;     }
//      //| K_TRI1    { signalType = SIGNAL_TRI1;     }
//      | K_TRIREG  { signalType = SIGNAL_TRIREG;   }
//      | K_WAND    { signalType = SIGNAL_WAND;     }
//      | K_WOR     { signalType = SIGNAL_WOR;      }
//      | K_SUPPLY0 { signalType = SIGNAL_SUPPLY_0; }
//      | K_SUPPLY1 { signalType = SIGNAL_SUPPLY_1; }
//      | K_INTEGER { signalType = SIGNAL_VAR_INTEGER; }
//      | K_REAL    { signalType = SIGNAL_VAR_REAL;    }
//      | K_REALTIME{ signalType = SIGNAL_VAR_REALTIME;}
//      | K_TIME    { signalType = SIGNAL_VAR_TIME;    }
//      )?
//      (
//        #(tokBitrange:BITRANGE 
//          expr1=expression 
//          (
//            expr2=expression
//            {
//              //create bitRange
//              br = CSLOmBitRange::build( #tokBitrange->getLine(), _RS(#tok->getFilename()), design, RefString(new string("")),  expr1, expr2);
//              isUpperLowerBitRange = 1;
//            }
//          )?
//        )
//      )?
//      (list = csl_anonymous_list_declaration
//        {
//          if(expr1.get()) {
//            if (isUpperLowerBitRange) { 
//              RefCSLOmExprLink el = br->getBitRangeLink();
//              params->push_back(br->getBitRangeLink()); 
//            } else { 
//              params->push_back(expr1); 
//            }
//          }
//          exprLink = list->getListLink();
//          params->push_back(exprLink);
//        }
//      | listExpr = expression
//        {
//          if(expr1.get()) {
//            if (isUpperLowerBitRange) { 
//              RefCSLOmExprLink el = br->getBitRangeLink();
//              params->push_back(br->getBitRangeLink()); 
//            } else { 
//              params->push_back(expr1); 
//            }
//          }
//          params->push_back(listExpr);
//        }
//      )
// 
//    )
//    {
//     CSLOmSetCommand::addEnumParam(signalType, NSCSLOm::TYPE_CMD_ADD_SIGNAL_LIST);
//     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_SIGNAL_LIST, params);
//    }
// ;

param_list_get_interface 
:#(K_GET_INTERFACE
     (K_INPUT | K_OUTPUT | K_INOUT)?
   )
;

param_list_set_unit_prefix 
{
  RefCSLOmExpr prefix;
}
: //expr=expression
//  (K_IFC_ONLY | K_LOCAL_ONLY)?
/*
  ( prefix = expression
      {
        params->push_back(prefix);
      }
  )+
  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_UNIT_PREFIX, params);
*/
;

//Commented out - pending removal
//
//param_list_connect  [ NSCSLOm::RefCSLOmExprLink scope ] returns [NSCSLOm::RefTVec_RefCSLOmExpr params]
//{
//  //int lineNumber = 0;
//  RefCSLOmExpr expr;
//  params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
//}
//: ( expr = expression
//    { params->push_back(expr); }
//  )*
//  //( lineNumber = param_list_formal_to_actual_mapping [ params->back() , scope ] )*
//;
////

param_list_formal_to_actual_mapping [ NSCSLOm::RefTVec_RefCSLOmExpr returnedParams ]
{ 
  RefCSLOmExpr expr_formal = RefCSLOmExpr();
  RefCSLOmExpr expr_actual = RefCSLOmExpr();
}
:#(PARAM_LIST_FORMAL_TO_ACTUAL_MAPPING
  (  
    f2a_pair_expr[expr_formal, expr_actual] //.expr_formal(expr_actual)
    {
      if(expr_formal->isExprLink() || expr_formal->isHybridORFuncCall()) {
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(expr_formal);
        returnedParams->push_back(exprLink);
      }
      returnedParams->push_back(expr_actual);
      expr_actual = RefCSLOmExpr();
      expr_formal = RefCSLOmExpr();
    }
  )+
)
;

f2a_pair_expr [NSCSLOm::RefCSLOmExpr &expr_formal, NSCSLOm::RefCSLOmExpr &expr_actual]
:#(F2A_PAIR_EXPR
    expr_formal = expression
    (expr_actual = expression)?
  )
;

// REMOVED due to syntax change
//
// param_list_add_instance [NSCSLOm::RefCSLOmExprLink scope]
// {
//   pair < RefString, int > id = make_pair(_RS(""),0);
//   RefCSLOmExprLink idLink;
//   RefTVec_RefCSLOmExprLink vec;
//   RefCSLOmExprLink instanceNameExprLink;
//   RefCSLOmExpr expr;
//   RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
//   int lineNumber = 0;
// }
// :#(tok:PARAM_LIST_ADD_INSTANCE
//   expr = expression
//   {
//     params->push_back(expr);
//   }
//   id = identifier
//   {
//     instanceNameExprLink = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//     params->push_back(instanceNameExprLink);
// 
//   }
//   ( param_list_formal_to_actual_mapping [ params ] )*
//   {
//     CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_INSTANCE, params);
//   }
// )
// ;
// 
// //done
// param_list_add_instance_list [NSCSLOm::RefCSLOmExprLink scope]
// {
// RefCSLOmList el;
// RefCSLOmExpr expr = RefCSLOmExpr();
// RefCSLOmExprLink exprLink = RefCSLOmExprLink();
// RefCSLOmList list = RefCSLOmList();
// RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// }
// :#(tok:PARAM_LIST_ADD_INSTANCE_LIST
//   ( expr = expression
//     { params->push_back(expr); }
//   )*
//   ( list = csl_anonymous_list_declaration
//     {
//       exprLink = list->getListLink();
//       params->push_back(exprLink);
//     }
//   )?
// )
// {
//   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_INSTANCE_LIST, params);
// }
// ;

//done (Assertion m_ref failed)
//param_list_add_unit_parameter [NSCSLOm::RefCSLOmExprLink scope] 
//{ 
//NSCSLOm::RefCSLOmExpr expr;
//pair <RefString, int> id;
//RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
//RefCSLOmExprLink parameterNameExprLink;
//}
//:#(tok:PARAM_LIST_ADD_UNIT_PARAMETER
//  id=identifier
//  {
//    parameterNameExprLink = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first );
//    params->push_back(parameterNameExprLink);
//  }
//  expr=expression
//  { 
//   params->push_back(expr); 
//  }
//{
//  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_UNIT_PARAMETER, params);
//}
//)
//;
//REMOVED due to syntax change
//
//param_list_add_port [NSCSLOm::RefCSLOmExprLink scope]
//{
//RefCSLOmExpr expr = RefCSLOmExpr(), expr1 = RefCSLOmExpr(),expr2 = RefCSLOmExpr();
//RefTVec_RefCSLOmExpr params  = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
//RefCSLOmSetCommand command = RefCSLOmSetCommand();
//ECSLOmPortDirection portDirection;
//ECSLOmSignalType signalType = SIGNAL_UNDEFINED;
//RefCSLOmBitRange br = RefCSLOmBitRange();
//int isUpperLowerBitRange = 0;
//}
//:#(tokAddPort:PARAM_LIST_ADD_PORT 
//  ( K_INPUT  { portDirection = INPUT ; }
//  | K_OUTPUT { portDirection = OUTPUT; }
//  | K_INOUT  { portDirection = INOUT ; }
//  )
//  ( K_WIRE    { signalType = SIGNAL_WIRE;     }
//  | K_REG     { signalType = SIGNAL_REG;      }
//  | K_TRI     { signalType = SIGNAL_TRI;      }
//  | K_TRIAND  { signalType = SIGNAL_TRIAND;   }
//  | K_TRIOR   { signalType = SIGNAL_TRIOR;    }
//  | K_TRI0    { signalType = SIGNAL_TRI0;     }
//  | K_TRI1    { signalType = SIGNAL_TRI1;     }
//  | K_TRIREG  { signalType = SIGNAL_TRIREG;   }
//  | K_WAND    { signalType = SIGNAL_WAND;     }
//  | K_WOR     { signalType = SIGNAL_WOR;      }
//  | K_SUPPLY0 { signalType = SIGNAL_SUPPLY_0; }
//  | K_SUPPLY1 { signalType = SIGNAL_SUPPLY_1; }
//  )?
//  ( #(tokBitrange:BITRANGE 
//       expr1=expression 
//      (expr2=expression
//      {
//        //create the bitrange
//        br = CSLOmBitRange::build( #tokBitrange->getLine(), _RS(#tok->getFilename()), design, RefString(new string("")),  expr1, expr2);
//        isUpperLowerBitRange = 1;
//      }
//      )?
//    )
//  )?
//  expr=expression
//  { 
//    if(expr1.get()) {
//      if (isUpperLowerBitRange) { 
//        RefCSLOmExprLink el = br->getBitRangeLink();
//        params->push_back(br->getBitRangeLink()); 
//      } else { 
//        params->push_back(expr1); 
//      }
//    }
//    params->push_back(expr);
//  }
//) 
//{
//CSLOmSetCommand::addEnumParam(portDirection, NSCSLOm::TYPE_CMD_ADD_PORT);
//CSLOmSetCommand::addEnumParam(signalType, NSCSLOm::TYPE_CMD_ADD_PORT);
//CSLOmSetCommand::build(#tokAddPort->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_PORT, params);
//}
//;

//done
// param_list_add_port_list [NSCSLOm::RefCSLOmExprLink scope]
// {
// RefCSLOmExpr expr     = RefCSLOmExpr(), 
//              expr1    = RefCSLOmExpr(), 
//              expr2    = RefCSLOmExpr(), 
//              listExpr = RefCSLOmExpr();
// pair <RefString, int> id;
// RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
// RefCSLOmSetCommand command = RefCSLOmSetCommand();
// ECSLOmPortDirection portDirection;
// RefCSLOmList list = RefCSLOmList();
// RefCSLOmExprLink exprLink;
// RefCSLOmBitRange br = RefCSLOmBitRange();
// ECSLOmSignalType signalType = SIGNAL_UNDEFINED;
// int isUpperLowerBitRange = 0;
// }
// :#(tok:PARAM_LIST_ADD_PORT_LIST
//   ( K_INPUT  {portDirection = INPUT; }
//   | K_OUTPUT {portDirection = OUTPUT;}
//   | K_INOUT  {portDirection = INOUT; }
//   )
//   ( K_WIRE    { signalType = SIGNAL_WIRE;      }
//   | K_REG     { signalType = SIGNAL_REG;       }
//   | K_TRI     { signalType = SIGNAL_TRI;       }
//   | K_TRIAND  { signalType = SIGNAL_TRIAND;    }
//   | K_TRIOR   { signalType = SIGNAL_TRIOR;     }
//   | K_TRI0    { signalType = SIGNAL_TRI0;      }
//   | K_TRI1    { signalType = SIGNAL_TRI1;      }
//   | K_TRIREG  { signalType = SIGNAL_TRIREG;    }
//   | K_WAND    { signalType = SIGNAL_WAND;      }
//   | K_WOR     { signalType = SIGNAL_WOR;       }
//   | K_SUPPLY0 { signalType = SIGNAL_SUPPLY_0;  }
//   | K_SUPPLY1 { signalType = SIGNAL_SUPPLY_1;  }
//   )?
// 
//   ( #(tokBitrange:BITRANGE 
//       expr1=expression 
//       (
//         expr2=expression
//         {
//           //create bitrange
//           br = CSLOmBitRange::build( #tokBitrange->getLine(), _RS(#tok->getFilename()), design, RefString(new string("")),  expr1, expr2);
//           isUpperLowerBitRange = 1;
//         }
//       )?
//     )
//   )?
// 
//   (list = csl_anonymous_list_declaration
//      {
//        if(expr1.get()) {
//          if (isUpperLowerBitRange) { 
//            RefCSLOmExprLink el = br->getBitRangeLink();
//            params->push_back(br->getBitRangeLink()); 
//          } else { 
//            params->push_back(expr1); 
//          }
//        }
//        exprLink = list->getListLink();
//        params->push_back(exprLink);
//      }
//    | listExpr = expression
//      {
//        if(expr1.get()) {
//          if (isUpperLowerBitRange) { 
//            RefCSLOmExprLink el = br->getBitRangeLink();
//            params->push_back(br->getBitRangeLink()); 
//          } else { 
//            params->push_back(expr1); 
//          }
//        }
//        params->push_back(listExpr);
//      }
//    )
// )
// {
//   CSLOmSetCommand::addEnumParam(portDirection, NSCSLOm::TYPE_CMD_ADD_PORT_LIST);
//   CSLOmSetCommand::addEnumParam(signalType, NSCSLOm::TYPE_CMD_ADD_PORT);
//   CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_ADD_PORT_LIST, params);
// }
// ;

param_list_set_type 
{
RefCSLOmExpr expr = RefCSLOmExpr();
pair <RefString, int> id;
}
:#(tok:K_SET_TYPE
 id=identifier
 //K_WIRE
 //(K_WIRE | K_REG)
)
;

param_list_get_dim_bitrange 
{ 
RefCSLOmExpr expr;
}
: expr=expression
;

param_list_add_offset 
{
RefCSLOmExpr expr;
}
: expr=expression
;

param_list_add_dim_offset 
{
RefCSLOmExpr expr;
}
: expr=expression
expr=expression
;

param_list_set_dim_bitrange 
{
RefCSLOmExpr expr;
}
: expr=expression
expr=expression
;

param_list_set_dim_width 
{
RefCSLOmExpr expr;
}
: expr=expression
expr=expression
;

param_list_set_number_of_dimensions 
{
RefCSLOmExpr expr;
}
: expr=expression
;

param_list_start_current_scope 
:
;

param_list_end_current_scope 
:
;

param_list_input_verilog_type
: (K_1995 | K_2001 | K_2005 | K_SYSV)
;

param_list_output_verilog_type
: (K_1995 | K_2001 | K_2005 | K_SYSV)
;

param_list_autorouter
: ( K_AS_ON | K_AS_OFF )
;

//param_list_set_instance_alteration_bit
//: ( K_IA_ON | K_IO_OFF )
//;

param_list_get_bitrange 
:
;

param_list_set_width 
{
  RefCSLOmExpr expr;
}
: expr=expression
;

param_list_get_width 
{
  RefCSLOmExpr expr;
}
: expr=expression
;

param_list_set_range 
{
RefCSLOmExpr expr;
}
: expr=expression
expr=expression
;

param_list_get_range 
:
;

param_list_get_offset 
:
;

param_list_get_number_of_dimensions 
:
;

param_list_set_signal_prefix 
{
RefCSLOmExpr expr;
}
: expr=expression
;

param_list_set_signal_prefix_local 
{
RefCSLOmExpr expr;
}
: expr=expression
;

param_list_auto_connect_verilog_and_csl 
:
;

param_list_get_upper_index 
{
RefCSLOmExpr expr;
}
: expr=expression
;

param_list_get_lower_index 
:
;

param_list_set_upper_index 
{
RefCSLOmExpr expr;
}
: expr=expression
;

param_list_set_lower_index 
{
RefCSLOmExpr expr;
}
: expr=expression
;

param_list_set_signal_type 
: (
  ( K_WIRE    
  | K_REG     
  | K_TRI     
  | K_TRIAND  
  | K_TRIOR   
  | K_TRI0    
  | K_TRI1    
  | K_TRIREG 
  | K_WAND    
  | K_WOR     
  | K_SUPPLY0 
  | K_SUPPLY1 
  )
)
;

param_list_get_signal_type 
:
;

param_list_set_signal_attr 
: (
  K_ENABLE
| K_STALL
| K_PIPE_ENABLE
| K_PIPE_STALL
| K_MUX_SELECT
| K_DECODED
| K_CLOCK_SIGNAL
| K_RESET_SIGNAL
)
;

param_list_get_signal_attr 
:
;

//param_list_concat 
//{
//  RefCSLOmExpr expr;
//}
//: ( 
//    expr = expression 
//    | bitrange_pure  
//  )+
//;
//
param_list_merge 
:
;

param_list_invert 
: IDENTIFIER
;

param_list_buffer 
: IDENTIFIER
;

param_list_get_reversed_interface 
: 
;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// divide 1 ///////////////////////
///////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////// Declaration of units, scope, signal, bitrange, design, lists  /////
csl_declaration
{
  NSCSLOm::RefCSLOmUnitDecl unitDecl;
  pair<RefString, int> id;
  RefCSLOmList list;
}
: //#(tok:K_CSL_UNIT 
  //( id=identifier
  //{
  //  unitDecl = NSCSLOm::CSLOmUnitDecl::build( #tok->getLine(), _RS(#tok->getFilename()), design, id.first);
  //}
  //)+
  //)
  csl_unit_declaration             
| csl_signal_declaration
| csl_port_declaration            
| csl_signal_group_declaration      
| csl_bitrange_declaration         
| csl_multi_dim_bitrange_declaration
| csl_field_declaration          
  //| csl_cell_declaration              
| csl_design_declaration            
| csl_interface_declaration         
| list=csl_list_declaration
| csl_address_range_declaration
| csl_register_file_declaration
| csl_register_declaration
| csl_memory_declaration
| csl_testbench_declaration
| csl_bool_equation_declaration
| csl_event_declaration
| csl_enum_declaration
| csl_parameter_declaration
| csl_state_data_declaration
    //| csl_testbench_vector_declaration
| csl_vector_declaration
| csl_signal_pattern_generator_declaration
| csl_include_declaration
| csl_fifo_declaration
| csl_memory_map_declaration     
| csl_memory_map_page_declaration
| csl_isa_field_declaration
| csl_isa_element_declaration
    //| csl_isa_instruction_format_declaration
    //| csl_isa_instruction_declaration
| csl_isa_declaration
;

//csl_interface_declaration 
//{
//RefCSLOmExprLink scope = RefCSLOmExprLink();
//pair <RefString,int> id;
//RefCSLOmExpr expr = RefCSLOmExpr();
//RefCSLOmInterface ifc;
//}
//:#(K_CSL_INTERFACE
//  ( id = identifier
//    ( expr = expression )?
//      { 
//        ifc = CSLOmInterface::build( id.second, _RS(#tok->getFilename()), design, id.first , CSLOmExprLink::cast(expr));
//      }
//  )+
//)
//;

csl_unit_declaration
{
  pair<RefString, int> id;
  //TBool scopeFlag = false;
  //TBool enteredScope = FALSE;
  RefCSLOmExprLink expr = RefCSLOmExprLink();
}
   :#(K_CSL_UNIT
       (id = tok:identifier 
       { if (design->isScopeHolder() && 
             !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
           NSCSLOm::RefCSLOmUnitDecl unitDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first); 
         }
         //expr = CSLOmExprLink::build(#tok->getLine(), _RS(#tok->getFilename()),RefString(new std::string(#tok->getText())));
         //CSLOmScopeBlock::enterScope(expr);
         //scopeBlocks->push_back( expr );
         //design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
         //enteredScope = TRUE;
       }
       )+
       //(csl_declaration | csl_function_declaration)?
       ( csl_unit_definition[id])?
//       {
//         if (enteredScope) {
//           scopeBlocks->pop_back();
//           design = scopeBlocks->back();
//           CSLOmScopeBlock::exitScope();
//           enteredScope = FALSE;
//         }
//       }
    )
;

csl_fifo_declaration
{
  pair<RefString, int> id;
}
  :#(K_CSL_FIFO
     (id = tok:identifier 
     { 
       if ( design->isScopeHolder() && 
            !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
         NSCSLOm::RefCSLOmUnitDecl fifo_unitDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_FIFO_DECL);
       }
      } 
      )+
     (
       csl_unit_definition[id]
     )?
    )
  ;


csl_register_file_declaration
{
  pair<RefString, int> id;
  //TBool scopeFlag = false;
}
:#(K_CSL_REGISTER_FILE
   (id = tok:identifier 
    { 
      if (design->isScopeHolder() && !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
        /* NSCSLOm::RefCSLOmUnitDecl unitDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first);*/
        NSCSLOm::RefCSLOmUnitDecl rf_unitDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_REGISTER_FILE_DECL);
      }
    }
    )+
   ( 
    csl_unit_definition[id] 
    )?
 )
;

csl_register_declaration
{
  pair<RefString, int> id;
}
:#(K_CSL_REGISTER
   (id = tok:identifier
       {
         NSCSLOm::RefCSLOmUnitDecl reg_unitDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_REGISTER_DECL);
       }
    )+
   (
    csl_unit_definition[id]
   )?
)
;

csl_memory_declaration
{
  pair<RefString, int> id;
}
:#(K_CSL_MEMORY
   (id = tok:identifier
       {
         NSCSLOm::RefCSLOmUnitDecl mem_unitDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_MEMORY_DECL);
       }
    )+
   (
    csl_unit_definition[id]
   )?
)
;


csl_testbench_declaration 
{
pair <RefString,int> id;
}
:#(K_CSL_TESTBENCH
   (id=tok:identifier
    {
      NSCSLOm::RefCSLOmUnitDecl tb_unitdecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_TESTBENCH_DECL);
    }
    )+
   (
    csl_unit_definition[id]
   )?
)
;


csl_memory_map_declaration     
{
  pair<RefString, int> id;
}
:#(K_CSL_MEMORY_MAP
   (id=tok:identifier
    {
      if ( design->isScopeHolder() && 
          !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
        NSCSLOm::RefCSLOmMemoryMap memMapDecl = CSLOmMemoryMap::build(id.second, _RS(#tok->getFilename()), CSLOmDesign::cast(design), id.first);
      }
    }
    )+
    (
     //csl_memory_map_definition[id]
     csl_unit_definition[id]
    )?
  )
;

//csl_memory_map_definition [ std::pair<RefString, int> id ]
//{
//  
//}
//:#(CSL_UNIT_DEFINITION //CSL_MEMORY_MAP_DEFINITION
//   {
//     RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first);
//     scopeBlocks->push_back( sc );
//     CSLOmScopeBlock::enterScope( sc );
//     design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();  
//   }
//   ( csl_declaration
//   | csl_inst_or_cstor
//   | csl_function_declaration
//   )*
//   {
//     scopeBlocks->pop_back();
//     design = scopeBlocks->back();
//     CSLOmScopeBlock::exitScope();
//     ASSERT( scopeBlocks->size() > 0 , "The scopeBlock vector is empty!");
//   }
//  )
//;

csl_memory_map_page_declaration
{
  pair<RefString, int> id;
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:#(K_CSL_MEMORY_MAP_PAGE
   ( id = tok:identifier
   {
      if ( design->isScopeHolder() && 
        !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
        NSCSLOm::RefCSLOmMemoryMapPage memMapPageDecl = CSLOmMemoryMapPage::build(id.second, _RS(#tok->getFilename()), CSLOmDesign::cast(design), id.first);
      }
   }
   )+
   (
    //csl_memory_map_page_definition[id]
      csl_unit_definition[id]
   )?
 )
;

// 
//
//csl_memory_map_page_definition [ std::pair<RefString, int> id ]
//{
//}
//:#(CSL_UNIT_DEFINITION //CSL_MEMORY_MAP_PAGE_DEFINITION
//   {
//     RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first);
//     scopeBlocks->push_back( sc );
//     CSLOmScopeBlock::enterScope( sc );
//     design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();  
//   }
//   ( csl_declaration
//   | csl_inst_or_cstor
//   | csl_function_declaration
//   )*
//   {
//     scopeBlocks->pop_back();
//     design = scopeBlocks->back();
//     CSLOmScopeBlock::exitScope();
//     ASSERT( scopeBlocks->size() > 0 , "The scopeBlock vector is empty!");
//   }
//   )
//;

csl_unit_definition [ std::pair<RefString, int> id ]
{
   pair<RefString, int> constrId;
   TBool hasEnteredScope = FALSE;
   RefCSLOmBase baseObj = RefCSLOmBase();
}
  :
    #(tok:CSL_UNIT_DEFINITION
   { 
     RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first);
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
   }
  ( csl_declaration
  | csl_inst_or_cstor
  | csl_function_declaration
  )*
  {
    scopeBlocks->pop_back();
    design = scopeBlocks->back();
    if(hasEnteredScope){
      CSLOmScopeBlock::exitScope();
    }
    ASSERT( scopeBlocks->size() > 0 , "The scopeBlock vector is empty!");
  }
  )
;


csl_isa_field_declaration
{
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
}
:#(K_CSL_ISA_FIELD
   ( id = tok:identifier 
      { count = 0; }
      (expr1 = expression { ++count; }
       (expr2 = expression { ++count; }
        (expr3 = expression { ++count; })?
        )?
       )?
      {
        if(count == 3) { //lower, upper and enum|enum_item
          isaField = CSLOmIsaField::build(id.second                , _RS(#tok->getFilename()),
                                          design                   ,
                                          id.first                 ,
                                          expr1                    ,
                                          expr2                    ,
                                          CSLOmExprLink::cast(expr3));

        }
        else if(count == 2) {
          isaField = CSLOmIsaField::build(id.second, _RS(#tok->getFilename()),
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
            isaField = CSLOmIsaField::build(id.second                 , _RS(#tok->getFilename()),
                                            design                    ,
                                            id.first                  ,
                                            CSLOmExprLink::cast(expr1));
          }
          else {
            //disabled the check because the expression can also be 
            //a function return
            //if(expr1->isNumber()) { //found width
            isaField = CSLOmIsaField::build(id.second, _RS(#tok->getFilename()),
                                            design   ,
                                            id.first ,
                                            expr1    );  
          //}
          }
        } 
        else if(count == 0) {
          isaField = CSLOmIsaField::build(id.second, _RS(#tok->getFilename()),
                                          design   ,
                                          id.first );
        }
      }
      (csl_unit_definition[id] { hasDefinition = TRUE; } )? //set bool when definition found
      )*
    )
  ;

csl_isa_element_declaration
{
  pair<RefString,int> id;
  pair<RefString,int> idParent;
  
  RefCSLOmIsaElement isaElem = RefCSLOmIsaElement();
  RefCSLOmBase       parent  = RefCSLOmBase()      ;
  RefCSLOmIdentifier name    = RefCSLOmIdentifier();

  TBool hasParentClass = FALSE;
}
:#(K_CSL_ISA_ELEMENT
   #(CSL_ISA_ELEMENT_DECLARATION
     (id = tok:identifier
    {
    if(name.get()) { parent = name->getParent(); }
    else           { parent = design;            }
    }
     )
    (
    #(PARENT_CLASS
      idParent = tok1:identifier
    { 
       hasParentClass = TRUE; 
       RefCSLOmExprLink parentClass = CSLOmExprLink::build(idParent.second, _RS(#tok1->getFilename()), idParent.first);
       RefCSLOmBase parentClassBase = parentClass->doEval();
       if(parentClassBase->isIsaElement()){
         isaElem = CSLOmIsaElement::build(id.second      , _RS(#tok->getFilename()),
                                          parent         ,
                                          id.first       ,
                                          CSLOmIsaElement::cast(parentClassBase));
       }
    }
     )
     )?
    {
      if(!hasParentClass){
        isaElem = CSLOmIsaElement::build(id.second, _RS(#tok->getFilename()),
                                       parent,
                                       id.first);         
      }
    }
    ( csl_unit_definition[id] )?
   )
   )
;


//REMOVED due to syntax change
// 
// csl_isa_instruction_format_declaration
// {
//   pair<RefString, int> id;
//   RefCSLOmExpr expr = RefCSLOmExpr();
// }
// :#(K_CSL_ISA_INSTRUCTION_FORMAT
//      ( id = identifier
//        {
//         if ( design->isScopeHolder() && 
//           !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
//           //NSCSLOm::RefCSLOmIsaInstructionFormat isaIntrFormatDecl = CSLOmIsaInstructionFormat::build(id.second, _RS(#tok->getFilename()), CSLOmDesign::cast(design), id.first);
//         }
//        }
//      )+
//      (
//        csl_isa_instruction_format_definition[id]
//      )?
//   )
// ;
// 
// csl_isa_instruction_format_definition [ std::pair<RefString, int> id ]
// {
// }
// :#(CSL_UNIT_DEFINITION
//    {
//      RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first);
//      scopeBlocks->push_back( sc );
//      CSLOmScopeBlock::enterScope( sc );
//      design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();  
//    }
//    ( csl_declaration
//    | csl_inst_or_cstor
//    | csl_function_declaration
//    )*
//    {
//      scopeBlocks->pop_back();
//      design = scopeBlocks->back();
//      CSLOmScopeBlock::exitScope();
//      ASSERT( scopeBlocks->size() > 0 , "The scopeBlock vector is empty!");
//    }
//    )
// ;

//REMOVED due to syntax change
//
// csl_isa_instruction_declaration
// {
//   pair<RefString, int> id;
//   RefCSLOmExpr expr = RefCSLOmExpr();
// }
// :#(K_CSL_ISA_INSTRUCTION
//      ( id = identifier
//        {
//         if ( design->isScopeHolder() && 
//           !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
//           //NSCSLOm::RefCSLOmIsaInstructionFormat isaIntrFormatDecl = CSLOmIsaInstructionFormat::build(id.second, _RS(#tok->getFilename()), CSLOmDesign::cast(design), id.first);
//         }
//        }
//      )+
//      //(
//        //csl_isa_instruction_definition[id]
//      //)?
//   )
// ;

csl_isa_declaration
{
  pair<RefString, int> id;
  RefCSLOmExpr expr = RefCSLOmExpr();
}
:#(K_CSL_ISA
     ( id = identifier
       {
        if ( design->isScopeHolder() && 
          !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
          //NSCSLOm::RefCSLOmIsaInstructionFormat isaIntrFormatDecl = CSLOmIsaInstructionFormat::build(id.second, _RS(#tok->getFilename()), CSLOmDesign::cast(design), id.first);
        }
       }
     )+
     //(
       //csl_isa_definition[id]
     //)?
  )
;

//csl_scope_declaration 
//csl_class_declaration 
//{
//pair<RefString, int> id;
//enum classType { UNIT = 0, IFC = 1 };
//classType clsType;
//}
//  :#(tok:K_CLASS
//  id = identifier COLON K_PUBLIC ("csl_unit" { clsType = UNIT; } | "csl_interface" { clsType = IFC; }) K_PUBLIC COLON
//  {
//    if(clsType == UNIT){
//      NSCSLOm::RefCSLOmUnitDecl unitDecl;
//      unitDecl = NSCSLOm::CSLOmUnitDecl::build( #tok->getLine(), _RS(#tok->getFilename()), design, id.first);
//      RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first);
//      scopeBlocks->push_back( sc );
//      CSLOmScopeBlock::enterScope( sc );
//      design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
//    } 
//    else if (clsType == IFC) {
//      RefCSLOmInterface ifcDecl;
//      RefCSLOmExpr expr = RefCSLOmExpr();
//      RefCSLOmExprLink scope = RefCSLOmExprLink();
//      ifcDecl = NSCSLOm::CSLOmInterface::build(id.second, _RS(#tok->getFilename()), design, id.first , CSLOmExprLink::cast(expr));
//      RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first);
//      scopeBlocks->push_back( sc );
//      CSLOmScopeBlock::enterScope( sc );
//      design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
//    }
//// BUG BZ add a parent class pointer to the class object
//// this is for inheritance
//  }
//  (
//    csl_function_declaration | csl_declaration
//  )*
//  {
//    scopeBlocks->pop_back();
//    design = scopeBlocks->back();
//    CSLOmScopeBlock::exitScope();
//    ASSERT( scopeBlocks->size() > 0 , "The scopeBlock vector is empty!");
//  }
//)
//;
//
// /*

// csl_class_declaration 
// {
// pair<RefString, int> id;
// }
//   : 
// :#(K_CLASS
//   id = identifier COLON K_PUBLIC "csl_unit"
//   {
//     RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first);
//     scopeBlocks->push_back( sc );
//     CSLOmScopeBlock::enterScope( sc );
//     design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
//   }
//   (
//     csl_command | csl_declaration 
//   )
//   {
//     scopeBlocks->pop_back();
//     design = scopeBlocks->back();
//     CSLOmScopeBlock::exitScope();
//     ASSERT( scopeBlocks->size() > 0 , "The scopeBlock vector is empty!");
//   }
// )
// ;
// */
// /*
// csl_class_declaration
//     : IDENTIFIER COLON K_PUBLIC "csl_unit" 
//  LCURLY!
//   ( csl_declaration
//   | SEMI!
//   )*
//   RCURLY!
// ;
//*/

csl_function_declaration
    : 
  csl_build_function_declaration
// add other functions here
;

csl_build_function_declaration
{
  RefCSLOmExprLink expr;
  TBool enteredScope;
}
    : 
// CHECK IF THE FUNCTION IS CALLED INSIDE OF THE CLASS 
// a::csl_build will be a gcc 4.0 error

  #(K_VOID
  (tok:IDENTIFIER 
  {
    expr = CSLOmExprLink::build(#tok->getLine(), _RS(#tok->getFilename()),RefString(new std::string(#tok->getText())));
    CSLOmScopeBlock::enterScope(expr);
    scopeBlocks->push_back( expr );
    design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
    enteredScope = TRUE;
  }
   COLON COLON)? 
// BUG set the new scope here if the SCOPING OPERATOR IS USED
  K_CSL_BUILD 
    ( csl_command
      | csl_declaration // TBD
      | SEMI!
      )*
    )
{
  if (enteredScope) {
    scopeBlocks->pop_back();
    design = scopeBlocks->back();
    CSLOmScopeBlock::exitScope();
    enteredScope = FALSE;
  }
}
;



//removed from cslom
csl_design_declaration 
{
pair<RefString,int> id;
//  RefCSLOmExpr expr;
}
:#(K_CSL_DESIGN //---------------------------> TODO in CSLOM <------------------------------------//
  ( id = identifier
  {
    //cerr << *(id.first) << endl;
  }
  )+
)
;

csl_signal_group_declaration
{
  pair<RefString, int> id;
  //TBool scopeFlag = false;
}
   :#(K_CSL_SIGNAL_GROUP
      (id = tok:identifier 
       { if (design->isScopeHolder() && !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
           NSCSLOm::RefCSLOmGroupSignal signalGroup = CSLOmGroupSignal::build(id.second, _RS(#tok->getFilename()), design, id.first); }} )+
      //( csl_signal_group_definition[id] )?
      ( csl_unit_definition[id] /*{ hasDefinition = TRUE; }*/ )?
      )
;


//csl_signal_group_definition [ std::pair<RefString, int> id ]
//{
//}
//:
//  #(CSL_UNIT_DEFINITION
//  { RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first);
//   scopeBlocks->push_back( sc );
//   CSLOmScopeBlock::enterScope( sc );
//   design = CSLOmScopeBlock::getCurrentScope()->getHolderObject(); 
//  }
//  (  csl_signal_declaration
//     //  |  csl_signal_group_instantiation  //signal group instance
//  )*
//  { scopeBlocks->pop_back();
//    design = scopeBlocks->back();
//    CSLOmScopeBlock::exitScope();
//    ASSERT( scopeBlocks->size() > 0 , "The scopeBlock vector is empty!");
//  }
//  )
//;



//done
//csl_signal_group_declaration 
//{
//pair<RefString,int> id;
//RefCSLOmExpr expr;
//RefTVec_RefCSLOmBase vElem = RefTVec_RefCSLOmBase( new TVec_RefCSLOmBase );
//RefCSLOmList anonymousList;
//RefCSLOmGroupSignal sg;
//}
//:#(K_CSL_SIGNAL_GROUP
//  (
//   id = identifier
//   {
//   sg = CSLOmGroupSignal::build( id.second, _RS(#tok->getFilename()), design, id.first ) ;
//   }
//   (#(PARAM_LIST_SIGNAL_GROUP
//      (#(CSL_LIST
//         ( expr = expression
//           //{ sg->addItem(expr); }
//         )+
//        )
//       | ( expr = expression
//         //{ sg->addItem(expr); }
//         )*
//      )
//     )
//   )?
//  )+
// )  
//;

csl_bitrange_declaration 
{
  pair<RefString,int> id;
  RefCSLOmExpr expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr() , expr3 = RefCSLOmExpr();
  RefCSLOmSimpleBitRange br ;
  int count = 0;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefCSLOmBase parent = RefCSLOmBase();
  RefCSLOmIdentifier name = RefCSLOmIdentifier();
}
:#(K_CSL_BITRANGE ///////-----------------> Bit Range finished <------------------------------------//////// 
   ( id = tok:identifier
  {
    count = 1;
  }
  ( expr1 = expression 
    { count = 2 ; }    
    ( expr2 = expression 
      { count = 3 ; }
    )?   
  )?
    {
      //name = CSLOmCommand::findObjectID( id.second, design, vCurrentScope, RefCSLOmExprLink() );
      if(name.get()) { parent = name->getParent(); }
      else {
        parent = design;
      }
      //cerr << count << endl;
      if(count == 3) {
        br = CSLOmSimpleBitRange::build( id.second , _RS(#tok->getFilename()), parent, id.first,  expr1, expr2);
      }
      else if( count == 2) {
        br = CSLOmSimpleBitRange::build( id.second, _RS(#tok->getFilename()), parent, id.first,  expr1 );
      }
      else if( count == 1) { 
        //cerr<<"build br"<<endl;
        ASSERT(1,"BUG? The count is 1 in bitrange declaration!!! This is no longer supported"); 
      }
      else {
        ASSERT(0,"BUG? The count is 0 in bitrange declaration!!!"); 
      }
    }
 )*
)
;

csl_multi_dim_bitrange_declaration
{
  pair<RefString,int> id;
  RefCSLOmExpr expr = RefCSLOmExpr();
  RefCSLOmMultiDimBitRange mBr;
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  RefCSLOmBase parent = RefCSLOmBase();
  RefCSLOmIdentifier name = RefCSLOmIdentifier();
}
:#(K_CSL_MULTI_DIM_BITRANGE
   (id = tok:identifier
    (
     expr = expression
     )
    )
  {
    if(name.get()) { parent = name->getParent(); }
    else {
      parent = design;
    }
    mBr = CSLOmMultiDimBitRange::build(id.second, _RS(#tok->getFilename()), parent, id.first, expr);
  }
   )
;  

csl_field_declaration 
{
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
}
:#(K_CSL_FIELD
   ( id = tok:identifier
    {
      if(name.get()) { parent = name->getParent(); }
      else           { parent = design;            }
    }
    (PARENT_CLASS
     idParent = tok1:identifier 
     { 
        hasParentClass = TRUE; 
        RefCSLOmExprLink parentClass = CSLOmExprLink::build(idParent.second, _RS(#tok1->getFilename()), idParent.first);
        RefCSLOmBase parentClassBase = parentClass->doEval();
        br = CSLOmField::build( id.second, _RS(#tok->getFilename()), parent, id.first, CSLOmField::cast(parentClassBase));
     }
    )?
    //{ //if has definition and is not inherited
    //  if(hasDefinition && !hasParentClass) {
    //     br = CSLOmField::build( id.second, _RS(#tok->getFilename()), parent, id.first);
    //  }
    //}
    { count = 0; }
    //( 
    //  ( exprWidthOrBrOrLow = expression { hasLowerOrWidthOrBr = TRUE; ++count; }
    //    ( exprUpper = expression { hasUpper = TRUE; ++count; } )?
    //  )?
    //  ( exprEnumOrEnumItem = expression { hasEnumOrEnumItem = TRUE; ++count; } )?
    //)?
    (expr1 = expression { ++count; }
      (expr2 = expression { ++count; }
        (expr3 = expression { ++count; })?
      )?
    )?
    {
      //DCERR("count: "<<count<<std::endl);
      if(count == 3) {
        br = CSLOmField::build( id.second, _RS(#tok->getFilename()), 
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
            br = CSLOmField::build( id.second, _RS(#tok->getFilename()), 
                                    parent, 
                                    id.first, 
                                    expr1, 
                                    expr2);
          } 
          else if(expr2->isExprLink()) { //found width and enum|enum_item
            //DCERR("expr2 is expression link" << std::endl);
            br = CSLOmField::build( id.second, _RS(#tok->getFilename()), 
                                    parent, 
                                    id.first, 
                                    expr1, 
                                    CSLOmExprLink::cast(expr2));
          }
        }
        else if(expr1->isExprLink()) { //found bitrange
          //DCERR("expr1 is expression link" << std::endl);
          if(expr2->isExprLink()) { //found enum|enum item
            br = CSLOmField::build( id.second, _RS(#tok->getFilename()), 
                                    parent, 
                                    id.first, 
                                    expr1, 
                                    CSLOmExprLink::cast(expr2));
          }
        }
      }
      else if(count == 1) {
        //DCERR("expr1 is number" << std::endl);
        br = CSLOmField::build( id.second, _RS(#tok->getFilename()), 
                                  parent, 
                                  id.first, 
                                  expr1);
      } 
      else if(count == 0) {
        //DCERR("simple field" << std::endl);
        br = CSLOmField::build( id.second, _RS(#tok->getFilename()), 
                                  parent, 
                                  id.first);
      }
    }
    //(csl_field_definition[id] { hasDefinition = TRUE; } )? //set bool when definition found
    (csl_unit_definition[id] { hasDefinition = TRUE; } )? //set bool when definition found
  )*
)
;

//
//csl_field_definition [ std::pair<RefString, int> id ]
//{
//  
//}
//:
//  #(CSL_FIELD_DEFINITION
//   {      
//     RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first);
//     scopeBlocks->push_back( sc );
//     CSLOmScopeBlock::enterScope( sc );
//     design = CSLOmScopeBlock::getCurrentScope()->getHolderObject(); 
//   }
//  ( csl_declaration
////  |  csl_instantiation 
//  | csl_inst_or_cstor
//  | csl_function_declaration
//  )*
//  {
//    scopeBlocks->pop_back();
//    design = scopeBlocks->back();
//    CSLOmScopeBlock::exitScope();
//    ASSERT( scopeBlocks->size() > 0 , "The scopeBlock vector is empty!");
//  }
//  )
//;

csl_address_range_declaration
{
  pair <RefString, int > id;
//RefCSLOmExprLink hid = RefCSLOmExprLink();
  CSLOmAddressRange::EAddressRangeType rangeType = NSCSLOm::CSLOmAddressRange::ADDR_UNDEFINED;
  RefCSLOmExpr    expr1 = RefCSLOmExpr();
  RefCSLOmExpr    expr2 = RefCSLOmExpr();
  RefCSLOmNumber  lower = RefCSLOmNumber();
  RefCSLOmNumber  upper = RefCSLOmNumber();
  RefCSLOmNumber offset = RefCSLOmNumber(); //not used in copy ?
}
:#(K_CSL_ADDRESS_RANGE 
   ( id = tok:identifier
       (( K_RESERVED { rangeType = NSCSLOm::CSLOmAddressRange::ADDR_RESERVED; }
        | K_VALID    { rangeType = NSCSLOm::CSLOmAddressRange::ADDR_VALID;    } 
        | K_ILLEGAL  { rangeType = NSCSLOm::CSLOmAddressRange::ADDR_ILLEGAL;  }
        )?
         expr1 = tok1:expression
        (expr2 = expression)?
       )?
       {
         if(!expr2.get() && #tok1->getFirstChild()->getType() == EXPR_PRIMARY_IDENTIFIER) {
           RefCSLOmBase hidEval = expr1->doEval();
           CSLOmAddressRange::build(id.second, _RS(#tok->getFilename()),
                                    design,
                                    (CSLOmAddressRange::cast(hidEval))->getLower(),
                                    (CSLOmAddressRange::cast(hidEval))->getUpper(),
                                    (CSLOmAddressRange::cast(hidEval))->getAddressRangeType(),
                                    id.first);
         }
         else if(expr2.get()) {
           CSLOmAddressRange::build(id.second, _RS(#tok->getFilename()), design, expr1, expr2, rangeType, id.first);
         }
       }
    )+
  )
;

csl_port_declaration
{
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
}
:#(K_CSL_PORT 
   ( id = tok:identifier
      //checking if we are in unitdecl or not (interface)
     {
       mHasWidthOrExprLink = FALSE;
       mHasBitrange        = FALSE;
       if(design->isUnitDecl()){
         misUnitDecl = TRUE;
         design = CSLOmUnitDecl::cast(design)->getDefaultInterface();
       }
     }
      //( hid = expr_primary_identifier
    ( hid = expression
    | ( K_INPUT  { direction = NSCSLOm::INPUT ; }
      | K_OUTPUT { direction = NSCSLOm::OUTPUT; } 
      | K_INOUT  { direction = NSCSLOm::INOUT ; }
      )
      ( K_WIRE    { signalType = SIGNAL_WIRE;        }
      | K_REG     { signalType = SIGNAL_REG;         }
      | K_TRI     { signalType = SIGNAL_TRI;         }
      | K_TRIAND  { signalType = SIGNAL_TRIAND;      }
      | K_TRIOR   { signalType = SIGNAL_TRIOR;       }
      | K_TRI0    { signalType = SIGNAL_TRI0;        }
      | K_TRI1    { signalType = SIGNAL_TRI1;        }
      | K_TRIREG  { signalType = SIGNAL_TRIREG;      }
      | K_WAND    { signalType = SIGNAL_WAND;        }
      | K_WOR     { signalType = SIGNAL_WOR;         }
      | K_SUPPLY0 { signalType = SIGNAL_SUPPLY_0;    }
      | K_SUPPLY1 { signalType = SIGNAL_SUPPLY_1;    }
      | K_INTEGER { signalType = SIGNAL_VAR_INTEGER; }
      | K_TIME    { signalType = SIGNAL_VAR_TIME;    }
      )?
      ( br = bitrange_pure
      { 
        expr1 = br->getBitRangeLink();
      }
      | expr1 = exp:expression
       (expr2 = expression)?
       { if(!expr2.get()){
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
           port = CSLOmPortDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, direction, expr1, expr2);
          if (signalType != SIGNAL_UNDEFINED) {
            port->setPortType(signalType);
          }
         }
      }
     )?
   )
  { 
    
    if(!hid.get()){
      if(mHasWidthOrExprLink){
        port = CSLOmPortDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, direction, expr1);
          if (signalType != SIGNAL_UNDEFINED) {
            port->setPortType(signalType);
          }
      }
      else {
        if(!mHasBitrange){
          port = CSLOmPortDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, direction, signalType);
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
      port = CSLOmPortDecl::build(id.second, _RS(#tok->getFilename()), design, id.first,CSLOmExprLink::cast(hid));
    }
    //Resetting design to unit decl for other objects that may follow after port declarations
    if(misUnitDecl){
      design = CSLOmUnitDecl::cast(design->getParent());
    }
  }
    // NOTE: If the above works the commented text can be safely deleted
    //
    //  if(misUnitDecl){
    //    port = CSLOmPortDecl::build(id.second, _RS(#tok->getFilename()), CSLOmUnitDecl::cast(design)->getDefaultInterface(), id.first, direction, signalType);
    //  }
    //  else{
    //    port = CSLOmPortDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, direction, signalType);
    //  }
    //  
    //  if(!hid2.get() && br.get()){
    //    //port->setBitRange(br);
    //    scope = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), CSLOmIdentifier::cast(port->getChild(ID))->getName());
    //    scope->addID(CSLOmIdentifier::cast(port->getChild(ID)));
    //    params->push_back(br->getBitRangeLink());
    //    CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_BITRANGE, params);
    //    params->pop_back();
    //  } 
    //  else if (hid2.get()){
    //    //port->setBitRange(CSLOmBaseRange::cast(hid2));
    //    scope = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), CSLOmIdentifier::cast(port->getChild(ID))->getName());
    //    scope->addID(CSLOmIdentifier::cast(port->getChild(ID)));
    //    params->push_back(expr1);
    //    CSLOmSetCommand::build(id.second, _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_SET_BITRANGE, params);
    //    params->pop_back();
    //  }        
    //}
    //else {
    //  if(misUnitDecl){
    //    port = CSLOmPortDecl::build(id.second, _RS(#tok->getFilename()), CSLOmUnitDecl::cast(design)->getDefaultInterface(), id.first, hid);
    //  }
    //  else{
    //    port = CSLOmPortDecl::build(id.second, _RS(#tok->getFilename()), design, id.first,hid);
    //  }
    //}  
  )+
  )

;

csl_signal_declaration 
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair< RefString, int > id;
  RefCSLOmExpr hid = RefCSLOmExpr(), expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
  RefCSLOmSignal sig = RefCSLOmSignal();
  _ECSLOmSignalType type = NSCSLOm::SIGNAL_UNDEFINED;
  RefCSLOmBase parent = RefCSLOmBase();
  RefCSLOmBaseRange br;
  RefCSLOmExprLink brLink;
  RefString fileName;
}
:#(K_CSL_SIGNAL
    ( id = tok:identifier { 
      //DCERR("pure string is " << _RS(#tok->getFilename()));
      //fileName = _RS(_RS(#tok->getFilename())); 
      //DCERR("impure string is " << *fileName );
    }
    ( K_WIRE     { type = NSCSLOm::SIGNAL_WIRE;        }
    | K_REG      { type = NSCSLOm::SIGNAL_REG;         }
    | K_TRI      { type = NSCSLOm::SIGNAL_TRI;         }
    | K_TRIAND   { type = NSCSLOm::SIGNAL_TRIAND;      }
    | K_TRIOR    { type = NSCSLOm::SIGNAL_TRIOR;       }
    | K_TRI0     { type = NSCSLOm::SIGNAL_TRI0;        }
    | K_TRI1     { type = NSCSLOm::SIGNAL_TRI1;        }
    | K_TRIREG   { type = NSCSLOm::SIGNAL_TRIREG;      }
    | K_WAND     { type = NSCSLOm::SIGNAL_WAND;        }
    | K_WOR      { type = NSCSLOm::SIGNAL_WOR;         }
    | K_SUPPLY0  { type = NSCSLOm::SIGNAL_SUPPLY_0;    }
    | K_SUPPLY1  { type = NSCSLOm::SIGNAL_SUPPLY_1;    }
    | K_INTEGER  { type = NSCSLOm::SIGNAL_VAR_INTEGER; }
    | K_REAL     { type = NSCSLOm::SIGNAL_VAR_REAL;    }
    | K_REALTIME { type = NSCSLOm::SIGNAL_VAR_REALTIME;}
    | K_TIME     { type = NSCSLOm::SIGNAL_VAR_TIME;    }
     )?
    (br = bitrange_pure 
      { 
        expr1 = br->getBitRangeLink();
      }
    | expr1 = exp:expression 
      (expr2 = expression
      )?
    )? 
    {
      if(!expr2.get()){
        sig = CSLOmSignal::build(id.second, _RS(#tok->getFilename()), design, id.first, type, expr1);
      }
      else {
        sig = CSLOmSignal::build(id.second, _RS(#tok->getFilename()), design, id.first, type, expr1, expr2);
      }
      //sig->setFileName(fileName);
      //safe reset - for this case: csl_signal x(reg,2), y(x), z(x);
      type = NSCSLOm::SIGNAL_UNDEFINED;
      expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
    }
  )+
  )
;

// Safe to remove below if above works
//
//csl_signal_declaration 
//{
//  RefCSLOmExprLink scope = RefCSLOmExprLink();
//  pair< RefString, int > id;
//  RefCSLOmExpr expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
//  RefCSLOmSignal sig = RefCSLOmSignal();
//  int stage = 0;
//  _ECSLOmSignalType type = NSCSLOm::SIGNAL_UNDEFINED;
//  //  TVec_RefString_const_iter it;
//  RefCSLOmBase parent = RefCSLOmBase();
//  RefCSLOmIdentifier name = RefCSLOmIdentifier();
//  RefCSLOmBaseRange br;
//  RefCSLOmExprLink brLink;
//}
//:#(K_CSL_SIGNAL
//  ( id = identifier
//    ( K_WIRE     { type = NSCSLOm::SIGNAL_WIRE;        }
//    | K_REG      { type = NSCSLOm::SIGNAL_REG;         }
//    | K_TRI      { type = NSCSLOm::SIGNAL_TRI;         }
//    | K_TRIAND   { type = NSCSLOm::SIGNAL_TRIAND;      }
//    | K_TRIOR    { type = NSCSLOm::SIGNAL_TRIOR;       }
//    | K_TRI0     { type = NSCSLOm::SIGNAL_TRI0;        }
//    | K_TRI1     { type = NSCSLOm::SIGNAL_TRI1;        }
//    | K_TRIREG   { type = NSCSLOm::SIGNAL_TRIREG;      }
//    | K_WAND     { type = NSCSLOm::SIGNAL_WAND;        }
//    | K_WOR      { type = NSCSLOm::SIGNAL_WOR;         }
//    | K_SUPPLY0  { type = NSCSLOm::SIGNAL_SUPPLY_0;    }
//    | K_SUPPLY1  { type = NSCSLOm::SIGNAL_SUPPLY_1;    }
//    | K_INTEGER  { type = NSCSLOm::SIGNAL_VAR_INTEGER; }
//    | K_REAL     { type = NSCSLOm::SIGNAL_VAR_REAL;    }
//    | K_REALTIME { type = NSCSLOm::SIGNAL_VAR_REALTIME;}
//    | K_TIME     { type = NSCSLOm::SIGNAL_VAR_TIME;    }
//    )?
//    (br = bitrange_pure
//      {
//        expr1 = br->getBitRangeLink();
//        stage = 1;
//      }
//    | expr1 = expression
//      { stage = 1; }
//      ( expr2 = expression
//        { stage = 2; }
//      )?
//    )? 
//    {
//      //name = CSLOmCommand::findObjectID( id.second, design, vCurrentScope, RefCSLOmExprLink() );
//      if( name.get() ) { 
//        parent = name->getParent();
//      }
//      else {
//        parent = design;
//      }
//      if( stage == 0 ) {
//        sig = CSLOmSignal::build( id.second , _RS(#tok->getFilename()), parent , id.first , type);
//        }
//      else if( stage == 1 ) {
//        if (expr1->getExprType() == CSLOmExpr::EXPR_HID ) {
//            sig = CSLOmSignal::build( id.second , _RS(#tok->getFilename()), parent, id.first , type, expr1 );
//        }
//        else {
//            sig = CSLOmSignal::build( id.second , _RS(#tok->getFilename()), parent, id.first , type, expr1);
//        }
//        }
//        else if( stage == 2) {
//          sig = CSLOmSignal::build( id.second , _RS(#tok->getFilename()), design, id.first , type, expr1, expr2);
//          }
//      stage = 0;
//      type = NSCSLOm::SIGNAL_UNDEFINED;
//    }
//  )+
//)
//;
//
//
//csl_cell_declaration 
//{
//  RefCSLOmExprLink scope = RefCSLOmExprLink();
//  pair <RefString,int> id;
//  RefCSLOmExpr expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
//}
//:#(K_CSL_CELL
//  ( id = identifier
//    ( expr1 = expression
//      ( expr2 = expression
//      )?
//    )?
//  )+
//)
//;


csl_inst_or_cstor
:
  //#(CSL_INST_OR_CSTOR 
  //{
  //  {DCERR("salut"); }
  //}
    (
     //csl_interface_instantiation
     //| csl_unit_instantation
     csl_instantiation
     | csl_cstor
     //| csl_command
     )
  //)
;

//csl_unit_instantation
//{
//    pair<RefString, int> id, id2;
//    RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
//    RefCSLOmExprLink expr;
//    RefCSLOmExprLink link =  CSLOmExprLink::build(design->getLineNumber(), _RS(#tok->getFilename()), CSLOmScopeBlock::getCurrentScopeName());
//}
//: 
// #(CSL_INST
//   (id = identifier)
//   { if(CSLOmScopeBlock::getCurrentScope()->getScopeType() != CSLOmScope::SCOPE_UNIT_DECL) {
//        stringstream temp;
//        temp << "An unit can only be instantiated inside an unit" << endl;
//        throw ANTLR_USE_NAMESPACE(antlr)ANTLRException(temp.str());
//     }
//     expr = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), id.first);
//     params->push_back(expr);
//   }
//   (id2 = identifier 
//     {
//         RefCSLOmExprLink expr2 = CSLOmExprLink::build(id2.second, _RS(#tok->getFilename()), id2.first);
//         params->push_back(expr2);
//
//     }
//     (param_list_formal_to_actual_mapping [ params ])?
//     {
//         CSLOmCmdAddInstance::build(id2.second, _RS(#tok->getFilename()), design, link, params);
//         params->erase(++(params->begin()),params->end());
//          //           params->push_back(expr);
//     }
//   )+
//  )   
//;

csl_instantiation 
{
  pair<RefString, int> id, id2;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
  std::pair<RefTVec_RefCSLOmExpr, TBool> ovrParamsAndBool; 
  RefCSLOmExprLink       link = CSLOmExprLink::build(design->getLineNumber(), design->getFileName(), CSLOmScopeBlock::getCurrentScopeName());
  RefCSLOmExpr mem_page_inst_param = RefCSLOmExpr();
  //RefCSLOmExprLink overrideScope = RefCSLOmExprLink();
  TBool hasParamOvr = FALSE;
}
:#(CSL_INST
   (id = tok:identifier
     { 
       RefCSLOmExprLink expr = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), id.first);
       params->push_back(expr);
     }
    )
   ( //{ 
     // overrideScope = CSLOmExprLink::build(#tok->getLine(), _RS(#tok->getFilename()), id.first); 
     //} 
     ovrParamsAndBool = parameter_overriding_instantiation /*[ link ]*/
     {
      ASSERT(ovrParamsAndBool.first.get() , "walker: csl_instantiation rule: parameter_overriding_instantiation returned null.");
      hasParamOvr = TRUE; 
     }
   )?

   (id2 = tok2:identifier 
     {
       RefCSLOmExprLink expr2 = CSLOmExprLink::build(id2.second, _RS(#tok2->getFilename()), id2.first);
       params->push_back(expr2);
       if(hasParamOvr) {
         //DCERR("walker: param ovr:" << ovrParamsAndBool.first.get() << endl);
         //ASSERT(ovrParamsAndBool.first.get() , "walker: csl_instantiation rule: parameter_overriding_instantiation returned null.");
         ovrParamsAndBool.first->insert(ovrParamsAndBool.first->begin(), expr2);
       }

     }
     (param_list_formal_to_actual_mapping [ params ]
      //WARNING: the following needs to be linked to CSLOm 
      | mem_page_inst_param = expression 
      //{ params->push_back(mem_page_inst_param); } !!! WARNING: FAILS in cmd w/ assert - check it out
      )?
     {
       //CSLOmCmdAddInstanceAll::build(id2.second, _RS(#tok->getFilename()), design, link, params);
       CSLOmSetCommand::build(id2.second, _RS(#tok2->getFilename()), design, link, NSCSLOm::TYPE_CMD_ADD_INSTANCE_ALL, params);
       params->erase(++(params->begin()),params->end());

       if(hasParamOvr) {
        hasParamOvr = FALSE;
        if(ovrParamsAndBool.second == TRUE) {
          CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, link, NSCSLOm::TYPE_CMD_OVERRIDE_PARAMETER_NAMED, ovrParamsAndBool.first);
        }
        else {
          CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, link, NSCSLOm::TYPE_CMD_OVERRIDE_PARAMETER_ORDERED, ovrParamsAndBool.first);
        }
       }
       //params->pop_back();
     }
    )+
  )
;

parameter_overriding_instantiation /*[NSCSLOm::RefCSLOmExprLink overrideScope ]*/ returns [std::pair<NSCSLOm::RefTVec_RefCSLOmExpr, TBool> paramsAndBool]
{
  //RefCSLOmExprLink scope = RefCSLOmExprLink();
  //RefCSLOmExprLink scope = overrideScope;
  RefCSLOmExpr expr, expr_formal, expr_actual;
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
  TBool isNamedParamAssn = FALSE;
}
:#(tok:UNIT_PARAMETER
   (
    ((param_list_formal_to_actual_mapping [ params ]
    {                                    
      //CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_OVERRIDE_PARAMETER_NAMED, params);
      isNamedParamAssn = TRUE;
    }) 
    |
   ((expr = expression { params->push_back(expr); } 
    | K_SKIP_PARAMETER { params->push_back(RefCSLOmExpr()); } 
   )+))
   {
    //if(!isNamedParamAssn){
    //  CSLOmSetCommand::build(#tok->getLine(), _RS(#tok->getFilename()), design, scope, NSCSLOm::TYPE_CMD_OVERRIDE_PARAMETER_ORDERED, params);
    //}
    ASSERT(params.get() && params->size(), "walker: param ovr rule: ovr list is either null or empty.");
    //    DCERR("f2a map: " << params.get() << " " << params->size() << endl);
    paramsAndBool = make_pair(params, isNamedParamAssn);
   }
  )
 )
;

//csl_interface_instantiation
//{
//  pair<RefString, int> id, id2;
//  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
//  RefCSLOmExprLink link =  CSLOmExprLink::build(design->getLineNumber(), _RS(#tok->getFilename()), CSLOmScopeBlock::getCurrentScopeName());;
//}
//:#(CSL_INTERFACE_INSTANTIATION
//    (id = identifier )
//       { if(CSLOmScopeBlock::getCurrentScope()->getScopeType() == CSLOmScope::SCOPE_UNIT_DECL || 
//            CSLOmScopeBlock::getCurrentScope()->getScopeType() == CSLOmScope::SCOPE_INTERFACE) {
//           RefCSLOmExprLink idx = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), id.first);
//           RefCSLOmBase base = idx->doEval();
//           if (!base.get()) {
//             stringstream temp;
//             temp << "Undefined interface: " << *id.first.get() << " at line: " << id.second << endl;
//             throw ANTLR_USE_NAMESPACE(antlr)ANTLRException(temp.str());
//           }
//           else if (!base->isInterface()) {
//             stringstream temp;
//             temp << "Expecting interface found: " << *id.first.get() << endl;
//             throw ANTLR_USE_NAMESPACE(antlr)ANTLRException(temp.str());
//           }
//         }
//         else {
//           stringstream temp;
//           temp << "An interface can only be added to an unit or another interface" << endl;
//           throw ANTLR_USE_NAMESPACE(antlr)ANTLRException(temp.str());
//         }
//         RefCSLOmExprLink expr = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), id.first);
//         params->push_back(expr);
//       }
//    (id2 = identifier 
//     {
//       RefCSLOmExprLink expr2 = CSLOmExprLink::build(id2.second, _RS(#tok->getFilename()), id2.first);
//       params->push_back(expr2);
//       //CSLOmCmdAddInstanceAll::build(id2.second, _RS(#tok->getFilename()), design, link, params);
//       CSLOmSetCommand::build(id2.second, _RS(#tok->getFilename()), design, link, NSCSLOm::TYPE_CMD_ADD_INSTANCE_ALL, params);
//       params->pop_back();
//     }
//    )+
//  )
//;
//
//csl_signal_group_instantiation
//{
//  pair<RefString, int> id, id2;
//  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
//  RefCSLOmExprLink link =  CSLOmExprLink::build(design->getLineNumber(), _RS(#tok->getFilename()), CSLOmScopeBlock::getCurrentScopeName());;
//}
//:#(CSL_SIGNAL_GROUP_INSTANTIATION
//    (id = identifier )
//       { if(CSLOmScopeBlock::getCurrentScope()->getScopeType() == CSLOmScope::SCOPE_UNIT_DECL || 
//            CSLOmScopeBlock::getCurrentScope()->getScopeType() == CSLOmScope::SCOPE_GROUP) {
//           RefCSLOmExprLink idx = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), id.first);
//           RefCSLOmBase base = idx->doEval();
//           if (!base.get()) {
//             stringstream temp;
//             temp << "Undefined signal group: " << *id.first.get() << " at line: " << id.second << endl;
//             throw ANTLR_USE_NAMESPACE(antlr)ANTLRException(temp.str());
//           }
//           else if (!base->isSignalGroup()) {
//             stringstream temp;
//             temp << "Expecting signal group found: " << *id.first.get() << endl;
//             throw ANTLR_USE_NAMESPACE(antlr)ANTLRException(temp.str());
//           }
//         }
//         else {
//           stringstream temp;
//           temp << "A signal group can only be added to an unit or another signal group" << endl;
//           throw ANTLR_USE_NAMESPACE(antlr)ANTLRException(temp.str());
//         }
//         RefCSLOmExprLink expr = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), id.first);
//         params->push_back(expr);
//       }
//    (id2 = identifier 
//     {
//       RefCSLOmExprLink expr2 = CSLOmExprLink::build(id2.second, _RS(#tok->getFilename()), id2.first);
//       params->push_back(expr2);
//       //CSLOmCmdAddInstanceAll::build(id2.second, _RS(#tok->getFilename()), design, link, params);
//       CSLOmSetCommand::build(id2.second, _RS(#tok->getFilename()), design, link, NSCSLOm::TYPE_CMD_ADD_INSTANCE_ALL, params);
//       params->pop_back();
//     }
//    )+
//  )
//;

csl_cstor
{
  RefCSLOmExprLink expr;
  //TBool enteredScope;
}
    : 
// CHECK IF THE FUNCTION IS CALLED INSIDE OF THE CLASS 
// a::csl_build will be a gcc 4.0 error

  #(CSL_CSTOR
    //{
    //DCERR("after csl_cstor\n");
    //}
    tok:IDENTIFIER 
    //{
    //  //DCERR("after csl_identifier\n");
    //}
//  {
//    expr = CSLOmExprLink::build(#tok->getLine(), _RS(#tok->getFilename()),RefString(new std::string(#tok->getText())));
//    CSLOmScopeBlock::enterScope(expr);
//    scopeBlocks->push_back( expr );
//    design = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
//    enteredScope = TRUE;
//  }
//   COLON COLON)? 
// BUG set the new scope here if the SCOPING OPERATOR IS USED
//  K_CSL_BUILD 
    ( 
      csl_command 
      //{ DCERR("after command\n"); }
      //     | csl_declaration // TBD
      | SEMI!
    )*    
  )
;

csl_interface_declaration
{
  pair<RefString, int> id;
  //TBool scopeFlag = false;
  
}
   :#(K_CSL_INTERFACE
      (id = tok:identifier 
       { if (design->isScopeHolder() && !(CSLOmScopeBlock::getCurrentScope()->lookupLocal(id.first)).get()) {
           NSCSLOm::RefCSLOmInterface interface = CSLOmInterface::build(id.second, _RS(#tok->getFilename()), design, id.first); }} )+
      //( csl_interface_definition[id] )?
      ( csl_unit_definition[id] /*{ hasDefinition = TRUE; }*/ )?
      )
;


//csl_interface_definition [ std::pair<RefString, int> id ]
//{
//}
//:
//  #(CSL_UNIT_DEFINITION
//  { RefCSLOmExprLink sc = CSLOmExprLink::build( id.second, _RS(#tok->getFilename()), id.first);
//   scopeBlocks->push_back( sc );
//   CSLOmScopeBlock::enterScope( sc );
//   design = CSLOmScopeBlock::getCurrentScope()->getHolderObject(); 
//  }
//  (  csl_port_declaration
//     //| csl_interface_instantiation  //interface instance
//     | csl_instantiation
//  )*
//  { scopeBlocks->pop_back();
//    design = scopeBlocks->back();
//    CSLOmScopeBlock::exitScope();
//    ASSERT( scopeBlocks->size() > 0 , "The scopeBlock vector is empty!");
//  }
//  )
//;



//csl_interface_declaration 
//{
//RefCSLOmExprLink scope = RefCSLOmExprLink();
//pair <RefString,int> id;
//RefCSLOmExpr expr = RefCSLOmExpr();
//RefCSLOmInterface ifc;
//}
//:#(K_CSL_INTERFACE
//  ( id = identifier
//    ( expr = expression )?
//      { 
//        ifc = CSLOmInterface::build( id.second, _RS(#tok->getFilename()), design, id.first , CSLOmExprLink::cast(expr));
//      }
//  )+
//)
//;
//

csl_list_declaration returns [NSCSLOm::RefCSLOmList list]
{
  RefCSLOmExprLink scope = RefCSLOmExprLink();
  pair <RefString,int> id;
  //RefCSLOmExpr expr = RefCSLOmExpr();
}
:#(listTok:K_CSL_LIST
  ( id = identifier// DO NOT make the identifier optional, it will create an infinite loop
    {
      //std::cerr << "before build" << std::endl;
      list = CSLOmList::build(#listTok->getLine(), _RS(#listTok->getFilename()), design, id.first);
      //std::cerr << "after build" << std::endl;
    }
    ( param_list_csl_list [ list ] )?
  ) 
)
;

csl_anonymous_list_declaration returns [NSCSLOm::RefCSLOmList anonymousList]
{
  RefCSLOmExpr expr = RefCSLOmExpr();
  RefTVec_RefCSLOmExprLink vl;
}
:#(list:CSL_LIST
  {
    //std::cerr << "before build" << std::endl;
    anonymousList = CSLOmList::build(#list->getLine(), _RS(#list->getFilename()), design);
    //std::cerr << "after build" << std::endl;
    ASSERT(anonymousList.get(),"BUHUHU");
  }
  param_list_csl_list [ anonymousList ]
)
;

csl_include_declaration
{
  RefCSLOmExpr fileName = RefCSLOmExpr();
  EIncludeFileType type;
}
:#(tok:K_CSL_INCLUDE
      ( file_ver: K_FILE_VERILOG    { type = FILE_VERILOG;   }
      | file_cpp: K_FILE_CPLUSPLUS  { type = FILE_CPLUSPLUS; }
      )
      fileName = expression
   {
     CSLOmInclude::build( #tok->getLine(), _RS(#tok->getFilename()), type, CSLOmString::cast(fileName)->getValue());
   }
 )
;   

//csl_register_file_declaration
//{
//pair <RefString,int> id;
//NSCSLOm::RefCSLOmUnitDecl rf = RefCSLOmUnitDecl();
// RefCSLOmExpr exprWidth = RefCSLOmExpr();
// RefCSLOmExpr exprDepth = RefCSLOmExpr();
//
//}
//:
// #(tok:K_CSL_REGISTER_FILE
//   id=identifier
//     {
//       rf = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_REGISTER_FILE_DECL); 
//     }
//   (exprWidth = tok1:expression
//    exprDepth = tok2:expression
//       {
//         RefCSLOmRegisterFileInfo rfInfo = CSLOmRegisterFileInfo::cast(rf);
//         //RefCSLOmRegisterFileInfo rfInfo = CSLOmRegisterFileInfo::cast(rf->getUnitInfo());
//         //rfInfo->setWidth(exprWidth);
//         //rfInfo->setDepth(exprDepth);
//         //CSLOmRegisterFileInfo::cast(rf->getUnitInfo())->setDepth(exprDepth);         
//       }
//    )?
//  )
//;



//to be implemented in CSLOM
csl_bool_equation_declaration 
{
pair <RefString,int> id;
}
:#(tok:K_CSL_BOOL_EQUATION
  id=identifier
)
{
 //to be implemeted in CSLOM
}
;

csl_enum_declaration
{
  pair <RefString,int> id/*, id2*/;
  RefString name = RefString();
  //  RefCSLOmExpr number = RefCSLOmExpr();
  //<added by Alina>
//  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
//  RefCSLOmExprLink link;
  //</added by Alina>
}
:#(K_CSL_ENUM
   id = tok:identifier
    {
      RefCSLOmEnum enumObj = CSLOmEnum::build(id.second, _RS(#tok->getFilename()), design, id.first);
      //      link = CSLOmExprLink::build(id.second, _RS(#tok->getFilename()), id.first);
    }
    (
//     id2 = identifier
//     //<added by Alina>
//     {
//        std::cerr << "before expr2 build:" << *(id2.first) << std::endl;
//        RefCSLOmExprLink expr2 = CSLOmExprLink::build(id2.second, _RS(#tok->getFilename()), id2.first);
//        params->push_back(expr2);
//     }
//     //</added by Alina>
//     (
//      number = expression
//      {
//        params->push_back(number);
//      }
//
//      )?
//     //<commented by Alina>
//        //{
//          //enumObj->addPair(id2.first, CSLOmNumber::cast(number));
//        //}
//     //</commented by Alina>
//    //<added by Alina>
//    {
//      CSLOmCmdEnumAddPair::build(id.second, _RS(#tok->getFilename()), design, link, params );
//    
//      params->clear();
//    //</added by Alina>
//    }
     csl_enum_item [id]
     )*
    )

;

csl_enum_item [pair <RefString,int>& id]
{
  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
  RefCSLOmExprLink link;
  pair <RefString,int> id2;
  RefCSLOmExpr number = RefCSLOmExpr();
  //TBool hasMinus = FALSE;
}
  :
  #(ENUM_ITEM
    id2 = tok2:identifier
    //<added by Alina>
      {
        link = CSLOmExprLink::build(id.second, _RS(#tok2->getFilename()), id.first);
        //std::cerr << "before expr2 build:" << *(id2.first) << std::endl;
        RefCSLOmExprLink expr2 = CSLOmExprLink::build(id2.second, _RS(#tok2->getFilename()), id2.first);
        params->push_back(expr2);
      }
    //</added by Alina>
//    (
//      MINUS
//     {
//       hasMinus = TRUE;
//     }
//     )?
    (
     number = tok:expression
       // {
       //   if (hasMinus) {
       //     CSLOmNumber::cast(number)->setValue(-(CSLOmNumber::cast(number)->getValue()));
       //   }
        {
          params->push_back(number);
        }

     )?
    //<commented by Alina>
    //{
    //enumObj->addPair(id2.first, CSLOmNumber::cast(number));
    //}
    //</commented by Alina>
    //<added by Alina>
      {
        //CSLOmCmdEnumAddPair::build(id.second, _RS(#tok->getFilename()), design, link, params );
        CSLOmSetCommand::build(id.second, _RS(#tok2->getFilename()), design, link, NSCSLOm::TYPE_CMD_ADD_PAIR, params );
    
        params->clear();
        //</added by Alina>
      }
    )
;


csl_parameter_declaration
{
  pair <RefString,int> id;
  RefCSLOmExpr expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr();
  RefCSLOmParameter param = RefCSLOmParameter();
}
:#(tok:K_CSL_PARAMETER
   (id=identifier
    (expr1 = expression   //parameter value expression
    (expr2 = expression)? //optional width expression
    )
  {
  ASSERT(expr1.get(),"First expression in parameter declaration is not optional");
   if(!expr2.get()){
     param = CSLOmParameter::build(id.second, _RS(#tok->getFilename()), design, id.first, expr1);
     //DCERR("[WALKER] CSLOm build for parameter expects number for value but this can also be expression");
     //DCERR("walkerParamDeclVal: param name: " << *(param->getName()) << " param value = " << param->getValue()->getValue() << endl);
   }
   else{
     //DCERR("[WALKER] I need CSLOm support for creating a parameter with width specification: If this is available, please contact walker developer");
     param = CSLOmParameter::build(id.second, _RS(#tok->getFilename()), design, id.first, expr1, expr2);
     //DCERR("walkerParamDeclValAndWidth: param name: " << *(param->getName()) << " param value = " << param->getValue()->getValue() << " param width = " << param->getWidth() << endl);
    }
   expr1 = RefCSLOmExpr(), expr2 = RefCSLOmExpr(), param = RefCSLOmParameter();
   }
  )+
 )
;


//to be implemented in CSLOM
csl_event_declaration
{
pair <RefString,int> id;
}
:#(tok:K_CSL_EVENT
  id=identifier
)
{
 //to be implemeted in CSLOM
}
;

//csl_state_data_declaration
//{
//pair <RefString,int> id;
//}
//:#(tok:K_CSL_STATE_DATA
//    (id = identifier
//     {
//       NSCSLOm::RefCSLOmUnitDecl stateDataDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_STATE_DATA);
//     }
//     )+
//)
//;
//
//csl_vector_declaration
//{
//  pair <RefString,int> id;
//  NSCSLOm::RefCSLOmExpr expr;
//  RefTVec_RefCSLOmExpr params = RefTVec_RefCSLOmExpr( new TVec_RefCSLOmExpr() );
//}
//:#(tok:K_CSL_VECTOR
//    (id = identifier
//     (expr = tok2:expression
//     //multi concatenation ??
//     {
//       NSCSLOm::RefCSLOmUnitDecl vectorDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_VECTOR);
//       params->push_back(expr);
//       CSLOmSetCommand::build(#tok2->getLine(), _RS(#tok->getFilename()), design, RefCSLOmExprLink(), TYPE_CMD_VSD_SET_MODULE_NAME, params);
//     }
//     )
//    )+
//)
//;

csl_state_data_declaration
{
pair <RefString,int> id;
}
:#(tok:K_CSL_STATE_DATA
   (id = identifier
     {
       NSCSLOm::RefCSLOmUnitDecl stateDataDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_STATE_DATA);
     }
     )+
    (
     csl_unit_definition[id]
     )?
)
;


csl_vector_declaration
{
  pair <RefString,int> id;
}
:#(tok:K_CSL_VECTOR
   (id = identifier
     {
       NSCSLOm::RefCSLOmUnitDecl vectorDecl = CSLOmUnitDecl::build(id.second, _RS(#tok->getFilename()), design, id.first, CSLOmUnitDecl::CSL_VECTOR);
     }
     )+
    (
     csl_unit_definition[id]
     )?
    )
;


//to be implemented in CSLOM
csl_signal_pattern_generator_declaration
{
pair <RefString,int> id;
}
:#(tok:K_CSL_SIGNAL_PATTERN_GENERATOR
  id=identifier
)
{
 //to be implemeted in CSLOM
}
;

param_list_csl_list [NSCSLOm::RefCSLOmList list]
{
RefCSLOmExpr expr;
RefCSLOmExprLink item;
}
: ( expr = expression //I hope that the parser doesn't create a different object in rule expression by mistake
  {
    item = boost::static_pointer_cast<CSLOmExprLink>( expr );
    list->addItemToList(item);
  }
)+
;

/////////////////// Concatenation of one expression with //////////
/////////////////// multiple other expressions ////////////////////

concatenation returns [NSCSLOm::RefCSLOmExprConcat retExpConcat]
{  NSCSLOm::RefCSLOmExpr expr; }
:#(concat:K_CONCATENATION 
   ( expr = expression { retExpConcat = CSLOmExprConcat::build( #concat->getLine(), _RS(#concat->getFilename()), expr ); } )
  ( expr = expression { retExpConcat->addExpr(expr); })*
)
;

//--------------------------------------------> TODO also in CSLOM <-----------------------------------//
multiple_concatenation returns [NSCSLOm::RefCSLOmExprMultiConcat retExpr]
{
  NSCSLOm::RefCSLOmExpr expr = RefCSLOmExpr();
  NSCSLOm::RefCSLOmExprConcat exprConcat = RefCSLOmExprConcat();
  //NSCSLOm::RefCSLOmExprMultiConcat retExprConcat = RefCSLOmExprMultiConcat();
}
:#(tok:K_REPLICATION 
   ( expr = expression 
     exprConcat = concatenation )
  {
    retExpr = CSLOmExprMultiConcat::build( #tok->getLine(), _RS(#tok->getFilename()), expr, exprConcat);
  }
 )
;

//--------------------------------------------> TODO also in CSLOM <-----------------------------------//
expression_list returns [NSCSLOm::RefCSLOmList retList] // TODO in CSLOM
{
NSCSLOm::RefCSLOmExpr expr;
}
:#( EXPRESSION_LIST 
  ( expr = expression 
  {//TODO add to the retList expr
  }
  )+ 
)
;

// --------------------------------------------> TODO in CSLOM <----------------------------------------//
// removed
//range_expression  
//{
//NSCSLOm::RefCSLOmExpr expr;
//}
//: expr=expression
//| #( RANGE_EXPRESSION
//  expr=expression
//  ( COLON
//  | PO_POS
//  | PO_NEG
//  )
//  expr=expression
//)
//;

// Ignore this comment
//| #(rangeExpr:RANGE_EXPRESSION exprLink2 = expr_primary_identifier a = expression)
//{
//  br = CSLOmSimpleBitRange::build( #rangeExpr->getLine(), _RS(#tok->getFilename()), design, RefString(new std::string("")), a, a);
//  exprLink2->setBitRange(br);
//  expr = exprLink2;
//}

expression returns [NSCSLOm::RefCSLOmExpr expr] //-----------------> TODO the end with MINTYPMAX <------//
{ NSCSLOm::RefCSLOmExpr a,b,c,num,num2;
 TBool hasTwo = FALSE;
 TBool hasSecondExpr = FALSE;
//used for this case: id[expression]
RefCSLOmSimpleBitRange br = RefCSLOmSimpleBitRange();
pair<RefString, TInt> id; 
RefCSLOmExprLink exprLink;
RefCSLOmExprLink scope;
TBool negDirPartSel = FALSE;
}
: ( #(EXPRESSION expr=expression) 
| expr=expr_primary
| #(root01:U_PLUS      a=expression) 
{
  expr = CSLOmExprOp::build(#root01->getLine(), _RS(#root01->getFilename()), CSLOmExprOp::OP_UNARY_ARITHMETIC_PLUS, a);
}
    //The following seems to never be called
| #(EXPR_HYBRID expr=expression_hybrid)
| #(opMinus:U_MINUS     a=expression) 
{
  expr = CSLOmExprOp::build(#opMinus->getLine(), _RS(#opMinus->getFilename()), CSLOmExprOp::OP_UNARY_ARITHMETIC_MINUS, a);
}
| #(opNot:LNOT        a=expression)
{
  expr = CSLOmExprOp::build(#opNot->getLine(), _RS(#opNot->getFilename()), CSLOmExprOp::OP_UNARY_LOGIC_NOT, a);
}
| #(root00:NOT         a = expression)
{
  expr = CSLOmExprOp::build(#root00->getLine(), _RS(#root00->getFilename()), CSLOmExprOp::OP_UNARY_BITWISE_NOT, a);
}
| #(root02:U_AND       a = expression)
{
  expr = CSLOmExprOp::build(#root02->getLine(), _RS(#root02->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_AND, a);
}
| #(root03:U_NAND      a = expression)
{
  expr = CSLOmExprOp::build(#root03->getLine(), _RS(#root03->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_NAND, a);
}
| #(root04:U_OR        a = expression)
{
  expr = CSLOmExprOp::build(#root04->getLine(), _RS(#root04->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_OR, a);
}
| #(root05:U_NOR       a = expression)
{
  expr = CSLOmExprOp::build(#root05->getLine(), _RS(#root05->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_NOR, a);
}
| #(root06:U_XOR       a = expression)
{
  expr = CSLOmExprOp::build(#root06->getLine(), _RS(#root06->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_XOR, a);
}
| #(root07:U_XNOR      a = expression)
{
  expr = CSLOmExprOp::build(#root07->getLine(), _RS(#root07->getFilename()), CSLOmExprOp::OP_UNARY_REDUCTION_XNOR, a);
}
| #(root08:POW         a = expression b = expression) 
{
  expr = CSLOmExprOp::build(#root08->getLine(), _RS(#root08->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_POW, a ,b);
}
| #(root09:STAR        a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root09->getLine(), _RS(#root09->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY, a , b);
}
| #(root10:DIV         a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root10->getLine(), _RS(#root10->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_DIV, a , b);
}
| #(root11:MOD         a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root11->getLine(), _RS(#root11->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_MOD, a , b);
}
| #(root12:PLUS        a = expression (b = expression { hasTwo = TRUE; } )? )
{
  if(hasTwo){
    expr = CSLOmExprOp::build(#root12->getLine(), _RS(#root12->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_PLUS, a , b);
  }
  else {
    expr = CSLOmExprOp::build(#root12->getLine(), _RS(#root12->getFilename()), CSLOmExprOp::OP_UNARY_ARITHMETIC_PLUS, a);
  }
}
| #(root13:MINUS       a = expression (b = expression { hasTwo = TRUE; } )? )
{
  if(hasTwo){
    expr = CSLOmExprOp::build(#root13->getLine(), _RS(#root13->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS, a , b);
  }
  else {
    expr = CSLOmExprOp::build(#root13->getLine(), _RS(#root13->getFilename()), CSLOmExprOp::OP_UNARY_ARITHMETIC_MINUS, a);
  }
  hasTwo = FALSE;
}
| #(root14:SL          a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root14->getLine(), _RS(#root14->getFilename()), CSLOmExprOp::OP_BINARY_SHIFT_LEFT, a , b);
}
| #(root15:SSL         a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root15->getLine(), _RS(#root15->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT, a , b);
}
| #(root16:SR          a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root16->getLine(), _RS(#root16->getFilename()), CSLOmExprOp::OP_BINARY_SHIFT_RIGHT, a , b);
}
| #(root17:SSR         a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root17->getLine(), _RS(#root17->getFilename()), CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT, a , b);
}
| #(root18:LT_         a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root18->getLine(), _RS(#root18->getFilename()), CSLOmExprOp::OP_BINARY_RELATIONAL_LESS, a , b);
}
| #(root19:GT          a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root19->getLine(), _RS(#root19->getFilename()), CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER, a, b);
}
| #(root20:LE          a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root20->getLine(), _RS(#root20->getFilename()), CSLOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL, a, b);
}
| #(root21:GE          a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root21->getLine(), _RS(#root21->getFilename()), CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL, a, b);
}
| #(root22:EQUAL       a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root22->getLine(), _RS(#root22->getFilename()), CSLOmExprOp::OP_BINARY_EQUALITY_EQ, a, b);
}
| #(root23:NOT_EQ      a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root23->getLine(), _RS(#root23->getFilename()), CSLOmExprOp::OP_BINARY_EQUALITY_NOT_EQ, a, b);
}
| #(root24:NOT_EQ_CASE a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root24->getLine(), _RS(#root24->getFilename()), CSLOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE, a, b);
}
| #(root25:EQ_CASE     a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root25->getLine(), _RS(#root25->getFilename()), CSLOmExprOp::OP_BINARY_IDENTITY_EQ_CASE, a, b);
}
| #(root26:AND         a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root26->getLine(), _RS(#root26->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_AND, a, b);
}
| #(root27:NAND        a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root27->getLine(), _RS(#root27->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_NAND, a, b);
}
| #(root28:XOR         a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root28->getLine(), _RS(#root28->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_XOR, a, b);
}
| #(root29:XNOR        a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root29->getLine(), _RS(#root29->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_XNOR, a, b);
}
| #(root30:OR          a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root30->getLine(), _RS(#root30->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_OR, a, b);
}
| #(root31:NOR         a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root31->getLine(), _RS(#root31->getFilename()), CSLOmExprOp::OP_BINARY_BITWISE_NOR, a, b);
}
| #(root32:LAND        a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root32->getLine(), _RS(#root32->getFilename()), CSLOmExprOp::OP_BINARY_LOGIC_AND, a, b);
}
| #(root33:LOR         a = expression b = expression)
{
  expr = CSLOmExprOp::build(#root33->getLine(), _RS(#root33->getFilename()), CSLOmExprOp::OP_BINARY_LOGIC_OR, a, b);
}
| #(root34:QUESTION    a = expression b = expression c = expression)
{
  expr = CSLOmExprOp::build(#root34->getLine(), _RS(#root34->getFilename()), CSLOmExprOp::OP_TERNARY_COND, a, b, c);
}
| //mintypmax_expression //deprecated? // TODO : implement in CSLOM <-------------------------//
  #( MINTYPMAX_EXPRESSION 
    a = expression 
    ( b = expression 
      c = expression
    )?
  )
| expr = concatenation
| expr = multiple_concatenation
| expr = function_call_ret_id
| expr = function_call_ret_expr
    | #(root35:RANGE_EXPRESSION 
    (
      id = tokrange:identifier
    {
      if( scope.get() ){
        scope->addHidItem( id.first );
      }
      else {
        scope = CSLOmExprLink::build( id.second, _RS(#tokrange->getFilename()), id.first );
      }
    }
    )* 
    num = expression ((COLON | PO_NEG {negDirPartSel = TRUE;} )? num2 = expression { hasSecondExpr = TRUE; } )? )
{
  //exprLink = CSLOmExprLink::build(id.second, _RS(#tokrange->getFilename()), id.first);
  if(!hasSecondExpr){
    br = CSLOmSimpleBitRange::build(id.second, _RS(#tokrange->getFilename()), design, RefString(new std::string("")), num, num);
  }
  else{
    br = CSLOmSimpleBitRange::build(#root35->getLine(), _RS(#root35->getFilename()), design, RefString(new std::string("")), num, num2);
  }
  //exprLink->setBitRange(br);
  scope->setBitRange(br);
  if (negDirPartSel) {
    scope->setPartSelectDir(CSLOmExprLink::PS_DIR_DESC);
  }
  expr = scope;
}
)
;

//--------------------------------> finished <---------------------------------------------------//
expr_primary returns [NSCSLOm::RefCSLOmExpr expr]
{
NSCSLOm::RefCSLOmExprLink exprPrimId;
RefCSLOmExprConcat exprConcat;
RefString s;
RefCSLOmExprLink exprLink;
}
: expr = number
    | s = tok:str 
  {
    //Trying string
    //expr = CSLOmExprLink::build(5, _RS(#tok->getFilename()),s);
    //expr = CSLOmExpr::cast(exprLink);
    expr = CSLOmString::build(#tok->getLine(), _RS(#tok->getFilename()),s);
  }
| expr = expr_primary_identifier
    //| expr = concatenation
;

// -------------------------------------> finished <----------------------------------------------//
expr_primary_identifier returns [NSCSLOm::RefCSLOmExprLink retExprLink] 
{
pair<RefString, TULong> str;
RefString id;
//  RefCSLOmExpr currentExpr = RefCSLOmExpr(), previousExpr = RefCSLOmExpr();
retExprLink = RefCSLOmExprLink();
int count = 0;
NSCSLOm::RefCSLOmExpr expr;
}
:#(EXPR_PRIMARY_IDENTIFIER 
   ( str = tok:identifier 
  {
    if( retExprLink.get() ) {
      retExprLink->addHidItem( str.first );
    }
    else {
      retExprLink = CSLOmExprLink::build( str.second, _RS(#tok->getFilename()), str.first );
    }
    count ++;
  }
  )+
 )
/*
| #(RANGE_EXPRESSION expr=expression)
| #(FUNCTION_CALL_RET_EXPR expr=expression)
| #(FUNCTION_CALL_RET_ID expr=expression)
| #(EXPR_HYBRID expr=expression)
*/
;

//adapted to new CSLOm and parser
expression_hybrid returns [NSCSLOm::RefCSLOmExprLink retExprLink]
{
pair<RefString, TULong> id;
RefCSLOmExpr expr;
}
: expr=returning_exlink_rules
 {
   //std::cerr << "found expression_hybrid" << endl;
 }
;

get_exprlink_from_identifier returns [NSCSLOm::RefCSLOmExprLink retExprLink]
{
  pair<RefString,int> str;
}
: ( str = tok:identifier
  {
    if( retExprLink.get() ) {
      retExprLink->addHidItem( str.first );
    }
    else {
      retExprLink = CSLOmExprLink::build( str.second, _RS(#tok->getFilename()), str.first );
    }
  }
)
;

// -----------------------------------> TODO also in CSLOM <--------------------------------------//
//mintypmax_expression
//{
//  NSCSLOm::RefCSLOmExpr expr1, expr2, expr3;
//}
//:#( MINTYPMAX_EXPRESSION 
//    expr1=expression 
//    ( expr2=expression 
//      expr3=expression
//    )?
//  )
//; 

// -----------------------------------> TODO also in CSLOM <--------------------------------------//

function_call_ret_id returns [NSCSLOm::RefCSLOmExpr link] //returns an identifier
{
  RefCSLOmExpr expr = RefCSLOmExpr();
  pair< RefString, int > id;
//RefCSLOmExprLink link;
}
:#(FUNCTION_CALL_RET_ID
  {
    DCERR("____XXXXXXXXXX____MATCHED A FUNCTION CALL RET ID");
  }
    link=returning_exlink_rules
 )
;

//adapted to new CSLOm
returning_exlink_rules returns [NSCSLOm::RefCSLOmExprHybridOrFuncCall exprAll]
{
  pair< RefString, int > id;
  RefCSLOmExprLink exlink;
  RefCSLOmExpr expr;
  RefCSLOmExprLink object;
  RefCSLOmListExpr args;
  RefCSLOmExprLink exprLinkAll;
  RefCSLOmExprFuncSignature exprFuncSignAll;
  exprAll = RefCSLOmExprHybridOrFuncCall();
}
: 
(
    {
      exprLinkAll = RefCSLOmExprLink();
      exprFuncSignAll = RefCSLOmExprFuncSignature();
    }
    (
    tok1:K_GET_TYPE
    {
      //exprFuncSignAll = CSLOmExprFuncSignature::build(#tok1->getLine(), _RS(#tok->getFilename()),GET_TYPE);
      DCERR(">>>>> GET TYPE" << std::endl);
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok1->getLine(), _RS(#tok1->getFilename()),GET_TYPE, args);
      if(exprFuncSignAll.get()){
        DCERR("<<<<< GET TYPE" << std::endl);
      }
    }
    | tok2:K_GET_INTERFACE
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok2->getLine(), _RS(#tok2->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok2->getLine(), _RS(#tok2->getFilename()),GET_INTERFACE,args);
    }
    | tok3:K_GET_REVERSED_INTERFACE
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok3->getLine(), _RS(#tok3->getFilename()),expr);
       }
      )*
    {
      //exprFuncSignAll = CSLOmExprFuncSignature::build(#tok3->getLine(), _RS(#tok->getFilename()),GET_REVERSED_INTERFACE);
    }
    | tok4:K_GET_UNIT_PREFIX
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok4->getLine(), _RS(#tok4->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok4->getLine(), _RS(#tok4->getFilename()),GET_UNIT_PREFIX,args);
    }
    | tok5:K_GET_SIGNAL_PREFIX
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok5->getLine(), _RS(#tok5->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok5->getLine(), _RS(#tok5->getFilename()),GET_SIGNAL_PREFIX,args);
    }
    | tok6:K_GET_SIGNAL_PREFIX_LOCAL
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok6->getLine(), _RS(#tok6->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok6->getLine(), _RS(#tok6->getFilename()),GET_SIGNAL_PREFIX_LOCAL,args);
    }
    | tok7:K_GET_BITRANGE
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok7->getLine(), _RS(#tok7->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok7->getLine(), _RS(#tok7->getFilename()),GET_BITRANGE,args);
    }
    | tok8:K_GET_DIM_BITRANGE //(expr=expression)?
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok8->getLine(), _RS(#tok8->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok8->getLine(), _RS(#tok8->getFilename()),GET_DIM_BITRANGE,args);
      object = boost::static_pointer_cast<CSLOmExprLink>( expr );
    }
    | tok9:K_GET_ATTR
    {
      //exprFuncSignAll = CSLOmExprFuncSignature::build(#tok9->getLine(), _RS(#tok->getFilename()),GET_ATTR);
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok9->getLine(), _RS(#tok9->getFilename()),GET_ATTR, args);
    }
    | tok10:K_GET_CELL
    {
      //exprFuncSignAll = CSLOmExprFuncSignature::build(#tok10->getLine(), _RS(#tok->getFilename()),GET_CELL);
    }
    | tok11:K_GET_WIDTH
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok11->getLine(), _RS(#tok11->getFilename()),expr);
       }
      )*
    {
      //std::cerr << "I am in get_width" << std::cerr << endl;
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok11->getLine(), _RS(#tok11->getFilename()),GET_WIDTH,args);     
    }
    | (tok12:K_GET_DIM_WIDTH
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok12->getFilename()),expr);
       }
      )*
    )
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok12->getLine(), _RS(#tok12->getFilename()),GET_DIM_WIDTH,args);
    }
    | tok13:K_GET_UPPER_INDEX
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok13->getLine(), _RS(#tok13->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok13->getLine(), _RS(#tok13->getFilename()),GET_UPPER_INDEX,args);
    }
    | tok14:K_GET_DIM_UPPER_INDEX
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok14->getLine(), _RS(#tok14->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok14->getLine(), _RS(#tok14->getFilename()),GET_DIM_UPPER_INDEX,args);
    }
    | tok15:K_GET_LOWER_INDEX
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok15->getLine(), _RS(#tok15->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok15->getLine(), _RS(#tok15->getFilename()),GET_LOWER_INDEX,args);
    }
    | tok16:K_GET_DIM_LOWER_INDEX
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok16->getLine(), _RS(#tok16->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok16->getLine(), _RS(#tok16->getFilename()),GET_DIM_LOWER_INDEX,args);
    }
    | tok17:K_GET_OFFSET
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
        (expr=expression
        {          
          args = CSLOmListExpr::build(#tok17->getLine(), _RS(#tok17->getFilename()),expr);
        }
        )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok17->getLine(), _RS(#tok17->getFilename()),GET_OFFSET,args);
    }
    | tok18:K_GET_DIM_OFFSET
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok18->getLine(), _RS(#tok18->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok18->getLine(), _RS(#tok18->getFilename()),GET_DIM_OFFSET,args);
    }
    | tok19:K_GET_TRANSACTION_TIMEOUT_COUNTER //to be implemented in CSLOM
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
        //args = CSLOmListExpr::build(#tok19->getLine(), _RS(#tok->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok19->getLine(), _RS(#tok19->getFilename()),GET_DIM_OFFSET,args);
    }
    | tok20:K_GET_SIMULATION_TIMEOUT_COUNTER //to be implemented in CSLOM
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
        //args = CSLOmListExpr::build(#tok19->getLine(), _RS(#tok->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok20->getLine(), _RS(#tok20->getFilename()),GET_DIM_OFFSET,args);
    }
    | tok21:K_GET_NAME //to be implemented in CSLOM
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
         args = CSLOmListExpr::build(#tok21->getLine(), _RS(#tok21->getFilename()),expr);
       }
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok21->getLine(), _RS(#tok21->getFilename()),GET_NAME,args);
    }
    | tok22:K_GET_COMPARE_TRIGGER //to be implemented in CSLOM
      {
       //args = CSLOmListExpr::build(#tok12->getLine(), _RS(#tok->getFilename()),RefCSLOmExpr());
       //std::cerr << "after RefCSLOm()" << std::endl;
      } 
      (expr=expression
       {          
        //args = CSLOmListExpr::build(#tok19->getLine(), _RS(#tok->getFilename()),expr);
       }
      )*
    | tok23:K_GET_VALUE
      {
      }
      (expr=expression
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok23->getLine(), _RS(#tok23->getFilename()),GET_VALUE, args);
    }
    | tok24:K_GET_ENUM
      {
      }
      (expr=expression
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok24->getLine(), _RS(#tok24->getFilename()),GET_ENUM, args);
    }
    | tok25:K_GET_ENUM_ITEM
      {
      }
      (expr=expression
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok25->getLine(), _RS(#tok25->getFilename()),GET_ENUM_ITEM, args);
    }
    | tok26:K_GET_ASM_MNEMONIC
      {
      }
      (expr=expression
      )*
    {
      exprFuncSignAll = CSLOmExprFuncSignature::build(#tok26->getLine(), _RS(#tok26->getFilename()),GET_ASM_MNEMONIC, args);
    }           
    | exprLinkAll = get_exprlink_from_identifier
   )
 {
    if(exprFuncSignAll.get()){
      DCERR("<<<<< IT EXISTS HERE!!!!!!!!!!!!!!!!!!!!!!!!!!"<<std::endl);
    }
 }
   {
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
   }
 )+
;

function_call_ret_expr returns [NSCSLOm::RefCSLOmExpr expr]
{
pair <RefString,int> id;
}
:#(FUNCTION_CALL_RET_EXPR
  (
    expr = returning_exlink_rules
  )
)
;

number returns [NSCSLOm::RefCSLOmExpr expr] //-----------------> TODO : real number <-----------//
{
CCSLOmAdapter* adapter = CCSLOmAdapter::getInstance();
RefCSLOmExpr ex;
}
: (unr1:UNSIGNED_NUMBER )
{ //cerr << " Before number building\n";
  expr = adapter->convertToCSLOmNumberFrom_UNSIGNED_NUMBER(#unr1->getLine(),_RS(#unr1->getFilename()), #unr1->getNumber()); 
  //cerr << "-------> " << #unr1->getNumber() << endl;
  //cerr << "-->>>>>> " << CSLOmNumber::cast(#expr)->getValue() << endl;
}
| expr = sized_number 
| basedNumber:BASED_NUMBER
{ expr = adapter->convertToCSLOmNumberFrom_BASED_NUMBER(#basedNumber->getLine(),_RS(#basedNumber->getFilename()), #basedNumber->getNumber()); }
| realNumber:REAL_NUMBER 
//  { expr = adapter.convertToCSLOmRealFrom_REAL_NUMBER(#realNumber->getLine(),_RS(#realNumber->getFilename()), #realNumber->getNumber()); }
; 

sized_number returns [NSCSLOm::RefCSLOmExpr expr] //------------> FINISHED <---------------------//
:#( sn:SIZED_NUMBER
   un:UNSIGNED_NUMBER 
   bn:BASED_NUMBER
)
{
  expr = CCSLOmAdapter::getInstance()->convertToCSLOmNumberFrom_sized_number(#sn->getLine(), _RS(#sn->getFilename()), #un->getNumber(), #bn->getNumber());
}
;

str returns [ RefString retStr ] //--------------------> FINISHED <----------------------//
: str:STRING
{ retStr = _RS(#str->getText()); }
;

identifier returns [pair<RefString, TULong> res] //----> FINISHED <----------------------//
: id:IDENTIFIER 
  { res = make_pair(_RS(#id->getText()), #id->getLine()); }
;

// End of File
