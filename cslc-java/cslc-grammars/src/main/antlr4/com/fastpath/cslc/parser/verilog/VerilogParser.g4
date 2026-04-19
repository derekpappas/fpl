parser grammar VerilogParser;

options { tokenVocab = VerilogLexer; }

/*
 * Build-ready subset of legacy verilog.parser.g (entry + empty module).
 *
 * Full mechanical port of trunk (syntax-only, actions stripped) lives in
 * {@code VerilogParserTrunkPort.g4} (regenerate with {@code scripts/port_trunk_parser_g_to_g4.py});
 * the Maven {@code cslc-grammars} module generates both this stub and the trunk parser.
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
