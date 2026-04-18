parser grammar VerilogParser;

options { tokenVocab = VerilogLexer; }

/*
 * Build-ready subset of legacy verilog.parser.g (entry + empty module).
 *
 * Full mechanical port of trunk (syntax-only, actions stripped) is generated into
 * VerilogParser.trunk-port.g4 by scripts/port_trunk_parser_g_to_g4.py — that file is not
 * wired into Maven until the remaining ANTLR2→4 edge cases are resolved.
 */

source_text
    : (description)* EOF
    ;

description
    : attrs_opt
      ( module
      | SEMI
      )
    ;

attrs_opt
    :
    ;

module
    : module_keyword IDENTIFIER ( LPAREN port_list_contents? RPAREN )? SEMI module_item* K_ENDMODULE
    ;

module_keyword
    : K_MODULE
    | K_MACROMODULE
    ;

port_list_contents
    : IDENTIFIER ( COMMA IDENTIFIER )*
    ;

module_item
    : SEMI
    ;
