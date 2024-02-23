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
    #include "VerilogLexerUtils.hpp"
    #include "../../support/CommonSupport.h"

    }

options
    {
    language = "Cpp";
    }

{
typedef boost::shared_ptr<std::string> RefString;
#define _RS(str) (RefString(new string(str)))

#include <iostream>
#include "../../support/Base.hpp"
#include "VerilogToken.hpp"
ANTLR_USING_NAMESPACE(antlr);
#include "VerilogLexer.inc"
ANTLR_USING_NAMESPACE(std);
}

class VerilogLexer extends Lexer;

options
    {
    exportVocab = Verilog;
    testLiterals = false;
    k = 3;
    charVocabulary = '\3'..'\377';
    }

tokens
    {
    
    // Literals (keywords)
    
    K_ALWAYS = "always";
    K_AND = "and";
    K_ASSIGN = "assign";
    K_AUTOMATIC = "automatic";
    K_BEGIN = "begin";
    K_BUF = "buf";
    K_BUFIF0 = "bufif0";
    K_BUFIF1 = "bufif1";
    K_CASE = "case";
    K_CASEX = "casex";
    K_CASEZ = "casez";
    K_CMOS = "cmos";
    K_DEASSIGN = "deassign";
    K_DEFAULT = "default";
    K_DEFPARAM = "defparam";
    K_DISABLE = "disable";
    K_EDGE = "edge";
    K_ELSE = "else";
    K_END = "end";
    K_ENDCASE = "endcase";
    K_ENDFUNCTION = "endfunction";
    K_ENDGENERATE = "endgenerate";
    K_ENDMODULE = "endmodule";
    K_ENDPRIMITIVE = "endprimitive";
    K_ENDSPECIFY = "endspecify";
    K_ENDTABLE /* = "endtable" */ ; // Removed from literal table,
                              // we check it manually in "IDENTIFIER" rule
			      // to catch the moment when the UDP table ends
    K_ENDTASK = "endtask";
    K_EVENT = "event";
    K_FOR = "for";
    K_FORCE = "force";
    K_FOREVER = "forever";
    K_FORK = "fork";
    K_FUNCTION = "function";
    K_GENERATE = "generate";
    K_GENVAR = "genvar";
    K_HIGHZ0 = "highz0";
    K_HIGHZ1 = "highz1";
    K_IF = "if";
    K_IFNONE = "ifnone";
    K_INITIAL = "initial";
    K_INOUT = "inout";
    K_INPUT = "input";
    K_INTEGER = "integer";
    K_JOIN = "join";
    K_LARGE = "large";
    K_LOCALPARAM = "localparam";
    K_MACROMODULE = "macromodule";
    K_MEDIUM = "medium";
    K_MODULE = "module";
    K_NAND = "nand";
    K_NEGEDGE = "negedge";
    K_NMOS = "nmos";
    K_NOR = "nor";
    K_NOSHOWCANCELLED = "noshowcancelled";
    K_NOT = "not";
    K_NOTIF0 = "notif0";
    K_NOTIF1 = "notif1";
    K_OR = "or";
    K_OUTPUT = "output";
    K_PARAMETER = "parameter";
    K_PMOS = "pmos";
    K_POSEDGE = "posedge";
    K_PRIMITIVE = "primitive";
    K_PULL0 = "pull0";
    K_PULL1 = "pull1";
    K_PULLDOWN = "pulldown";
    K_PULLUP = "pullup";
    K_PULSESTYLE_ONDETECT = "pulsestyle_ondetect";
    K_PULSESTYLE_ONEVENT = "pulsestyle_onevent";
    K_RCMOS = "rcmos";
    K_REAL = "real";
    K_REALTIME = "realtime";
    K_REG = "reg";
    K_RELEASE = "release";
    K_REPEAT = "repeat";
    K_RNMOS = "rnmos";
    K_RPMOS = "rpmos";
    K_RTRAN = "rtran";
    K_RTRANIF0 = "rtranif0";
    K_RTRANIF1 = "rtranif1";
    K_SCALARED = "scalared";
    K_SHOWCANCELLED = "showcancelled";
    K_SIGNED = "signed";
    K_SMALL = "small";
    K_SPECIFY = "specify";
    K_SPECPARAM = "specparam";
    K_STRONG0 = "strong0";
    K_STRONG1 = "strong1";
    K_SUPPLY0 = "supply0";
    K_SUPPLY1 = "supply1";
    K_TABLE /* = "table" */ ; // Removed from literal table,
                              // we check it manually in "IDENTIFIER" rule
			      // to catch the moment when the UDP table begins
    K_TASK = "task";
    K_TIME = "time";
    K_TRAN = "tran";
    K_TRANIF0 = "tranif0";
    K_TRANIF1 = "tranif1";
    K_TRI = "tri";
    K_TRI0 = "tri0";
    K_TRI1 = "tri1";
    K_TRIAND = "triand";
    K_TRIOR = "trior";
    K_TRIREG = "trireg";
    K_VECTORED = "vectored";
    K_WAIT = "wait";
    K_WAND = "wand";
    K_WEAK0 = "weak0";
    K_WEAK1 = "weak1";
    K_WHILE = "while";
    K_WIRE = "wire";
    K_WOR = "wor";
    K_XNOR = "xnor";
    K_XOR = "xor";
    
    // System timing check literals and other system function names
    K_S_SETUP = "$setup";
    K_S_HOLD = "$hold";
    K_S_SETUPHOLD = "$setuphold";
    K_S_RECOVERY = "$recovery";
    K_S_REMOVAL = "$removal";
    K_S_RECREM = "$recrem";
    K_S_SKEW = "$skew";
    K_S_TIMESKEW = "$timeskew";
    K_S_FULLSKEW = "$fullskew";
    K_S_PERIOD = "$period";
    K_S_WIDTH = "$width";
    K_S_NOCHANGE = "$nochange";

    K_S_ATTRIBUTE = "$attribute";
    
    // Non literal tokens.

    PSTAR;
    UNSIGNED_NUMBER;
    REAL_NUMBER;
    BASED_NUMBER;

    PATHPULSE;

    // UDP Tokens
    UDP_Q0;
    UDP_Q1;
    UDP_QX;
    UDP_QQ;
    UDP_01;
    UDP_0X;
    UDP_0Q;
    UDP_10;
    UDP_1X;
    UDP_1Q;
    UDP_BX;
    UDP_X0;
    UDP_X1;
    UDP_XQ;
    UDP_B;
    UDP_F;
    UDP_R;
    UDP_X;
    UDP_N;
    UDP_P;
    UDP_0;
    UDP_1;
    }

{
public:
    void initialize();
    IFileNameCollection* fileNames() { return &m_fileNames; }
    TBool udpTable() const { return m_udpTable; }
    void setUdpTable(TBool flag) { m_udpTable = flag; }
protected:
    TVerLexerState lexerState() const;
    TChar octStrToChar(const string& str) const;
    void handleLineDirective(const string& filename, const string& lineText);
    TInt convertStrToInt(const string& str);
    TReal convertStrToReal(const string& str);

protected: // our own virtual methods
    virtual antlr::RefToken makeNumberToken(int t, const RefVerilogNumber number);

protected: // from base class
    virtual antlr::RefToken makeToken(int t);

protected:
    FileNameCollection m_fileNames;
    TBool m_udpTable;
}

//TICK        : "'"    ;
BACKTICK    : "`"    ;
AT          : "@"    ;
COLON       : ":"    ;
COMMA       : ","    ;
DOT         : "."    ;
ASSIGN      : "="    ;
MINUS       : "-"    ;
LBRACK      : "["    ;
RBRACK      : "]"    ;
LCRULY      : "{"    ;
RCRULY      : "}"    ;
LPAREN      : "("    ;
RPAREN      : ")"    ;
POUND       : "#"    ;
QUESTION    : "?"    ;
SEMI        : ";"    ;
PLUS        : "+"    ;
LNOT        : "!"    ;
NOT         : "~"    ;
AND         : "&"    ;
NAND        : "~&"   ;
OR          : "|"    ;
NOR         : "~|"   ;
// because this test failes the following rules the modified
// tsti[17] = tsti[16] ^^ tsti[15] ^^ tsti[14] ^^ tsti[13] ^^ tsti[11] ^^ tsti[11] ^^ tsti[10] ^^ tsti[9];
//XOR         : "^"    ;
//XNOR        : "~^" | "^~"  ;
XOR          {bool test = false;} :"^" ("~"{test=true;} )? {if(test) $setType(XNOR);};
XNOR        : "~^"   ;
STAR        : "*"    ;
POW         : "**"   ;
DIV         : "/"    ;
MOD         : "%"    ;
EQUAL       : "=="   ;
NOT_EQ      : "!="   ;
NOT_EQ_CASE : "!=="  ;
EQ_CASE     : "==="  ;
LAND        : "&&"   ;
TAND        : "&&&"  ;
LOR         : "||"   ;
LT_         : "<"    ;
LE          : "<="   ;
GT          : ">"    ;
GE          : ">="   ;
SL          : "<<"   ;
SSL         : "<<<"  ; // It has the same functionality as SL
SR          : ">>"   ;
SSR         : ">>>"  ;
TRIGGER     : "->"   ;
PPATH       : "=>"   ; // ???
FPATH       : "*>"   ;
PSTAR       : "(*"   ;  // Moved to token declaration //Modifed by Eugen
STARP       : "*)"   ;
PO_POS      : "+:"   ;
PO_NEG      : "-:"   ;
SUPERSTAR   : "(*)"  ; //added by Eugen

EDGE_DESC : ( "0" | "1") ("x" | "X" | "z" | "Z");

//Commented by Eugen
// This rule was found in IVL: replace (*) with *
/*STAR2 :
    ("(*" (W)* ")") =>
    "("! "*" (W)*! ")"!
    { _ttype = STAR; }
    |
    "(*"
    { _ttype = PSTAR; }
    ;
*/
// White space excluding newline '\r' or '\n'
protected
W : (' ' | '\t' | '\b' | '\f') ;

protected
END_OF_LINE :
    (
    ("\r\n") => "\r\n"
    | '\r'
    | '\n'
    )
    { newline(); }
    ;

protected
VOCAB : '\3'..'\377' ;

protected
ALPHA : 'a'..'z' | 'A'..'Z' | '_' ;

protected
DIGIT : '0'..'9' ;

protected
NZ_DIGIT : '1'..'9' ;

protected
BIN_DIGIT : '0'..'1' ;

protected
OCT_DIGIT : '0'..'7' ;

protected
HEX_DIGIT : ('0'..'9') | ('a'..'f') | ('A'..'F');

protected
XZ_DIGIT : 'x' | 'X' | 'z' | 'Z' | '?' ;
/*
protected
ESC : '\\'!
        (  '"'  { $setText("\""); }
         | '\\' { $setText("\\"); }
         | 'n'  { $setText("\n"); }
         | 't'  { $setText("\t"); }
         | (OCT_DIGIT OCT_DIGIT OCT_DIGIT)
             {
             string s; s += octStrToChar($getText);
             $setText(s);
             }
        )
    ;
*/
IDENTIFIER
        // options { testLiterals = true; }
	// now it is checked manually
    :
    ALPHA (ALPHA | DIGIT | '$')*
	{
	string id = getText();
	if (startsWith(id, "PATHPULSE$", FALSE))
	    {
	    $setType(PATHPULSE);
	    }
	else if (equal(id, "table"))
	    {
	    setUdpTable(TRUE);
	    $setType(K_TABLE);
	    }
	else if (equal(id, "endtable"))
	    {
	    setUdpTable(FALSE);
	    $setType(K_ENDTABLE);
	    }
	else if (equal(id, "b") && udpTable())
	    $setType(UDP_B);
	else if (equal(id, "f") && udpTable())
	    $setType(UDP_F);
	else if (equal(id, "r") && udpTable())
	    $setType(UDP_R);
	else if (equal(id, "x") && udpTable())
	    $setType(UDP_X);
	else if (equal(id, "n") && udpTable())
	    $setType(UDP_N);
	else if (equal(id, "p") && udpTable())
	    $setType(UDP_P);
	else if (equal(id, "B") && udpTable())
	    $setType(UDP_B);
	else if (equal(id, "F") && udpTable())
	    $setType(UDP_F);
	else if (equal(id, "R") && udpTable())
	    $setType(UDP_R);
	else if (equal(id, "X") && udpTable())
	    $setType(UDP_X);
	else if (equal(id, "N") && udpTable())
	    $setType(UDP_N);
	else if (equal(id, "P") && udpTable())
	    $setType(UDP_P);
	else
	    $setType(testLiteralsTable(_ttype));
	}
    ;

ESCAPED_IDENTIFIER { char c = 0xFF; } :
    '\\'! { $append(c); }
    ( ~('.' | ' ' | '\t' | '\b' | '\f' | '\r' | '\n')
      |! '.' { $append(c); }
    )+
    (' '! | '\t'! | '\b'! | '\f'! | END_OF_LINE!)?
    ;

STRING :
    '"'! 
    ( ('\\' ~('\r' | '\n'))
    | ~('"' | '\r' | '\n' | '\\')
    )* 
    '"'!
;

// UDP tables
//UDP_TABLE_ITEM :
//    {udpTable()}?
//	(
//	  "(?0)"            { $setType(UDP_Q0); }
//	| "(?1)"            { $setType(UDP_Q1); }
//	| ("(?x)" | "(?X)") { $setType(UDP_QX); }
//	| "(??)"            { $setType(UDP_QQ); }
//	| "(01)"            { $setType(UDP_01); }
//	| ("(0x)" | "(0X)") { $setType(UDP_0X); }
//	| "(0?)"            { $setType(UDP_0Q); }
//	| "(10)"            { $setType(UDP_10); }
//	| ("(1x)" | "(1X)") { $setType(UDP_1X); }
//	| "(1?)"            { $setType(UDP_1Q); }
//	| ("(bx)" | "(bX)") { $setType(UDP_BX); }
//	| ("(x0)" | "(X0)") { $setType(UDP_X0); }
//	| ("(x1)" | "(X1)") { $setType(UDP_X1); }
//	| ("(x?)" | "(X?)") { $setType(UDP_XQ); }
//	)
//    ;


protected
UNSIGNED_NUMBER :
    (DIGIT) (DIGIT | '_' )*
    ;

protected
NZ_UNSIGNED_NUMBER :
    (NZ_DIGIT) (DIGIT | '_' )*
    ;

protected
REAL_NUMBER :
    UNSIGNED_NUMBER '.' UNSIGNED_NUMBER
    ;

protected
REAL_NUMBER_EXP :
    UNSIGNED_NUMBER ('.' UNSIGNED_NUMBER)? EXP (SIGN)? UNSIGNED_NUMBER
    ;

protected
SIGN : '+' | '-' ;

protected
EXP : 'e' | 'E';

protected
XZ_NUMBER : XZ_DIGIT ('_')* ;

protected
BIN_NUMBER returns [ bool hasXZ ]
{ hasXZ = false; }
: (BIN_DIGIT | XZ_DIGIT { hasXZ = true;} ) (BIN_DIGIT | XZ_DIGIT { hasXZ = true;}  | '_')* ;

protected
OCT_NUMBER  returns [ bool hasXZ ]
{ hasXZ = false; }
: (OCT_DIGIT | XZ_DIGIT { hasXZ = true;} ) (OCT_DIGIT | XZ_DIGIT { hasXZ = true;}  | '_')* ;

protected
HEX_NUMBER  returns [ bool hasXZ ]
{ hasXZ = false; }
: (HEX_DIGIT | XZ_DIGIT { hasXZ = true;} ) (HEX_DIGIT | XZ_DIGIT { hasXZ = true;}  | '_')* ;

NUMBER { RefVerilogNumber vn; } 
: ( vn = BASED_NUMBER[VerilogNumber::NOT_SIZED]
    {
      $setToken(makeNumberToken(BASED_NUMBER, vn));
    }
  | ( UNSIGNED_NUMBER ('.' UNSIGNED_NUMBER)? EXP) => r_exp:REAL_NUMBER_EXP
    {
      $setToken(makeNumberToken(REAL_NUMBER, VerilogNumber::build( _RS(r_exp->getText()), VerilogNumber::NUM_REAL ) ) );
      //cout << "LEXER: ---------> " << r_exp->getText() << endl;
    }
  | (UNSIGNED_NUMBER '.') => r:REAL_NUMBER 
    {
      $setToken(makeNumberToken(REAL_NUMBER, VerilogNumber::build( _RS(r->getText()), VerilogNumber::NUM_REAL ) ) );
    }
  | u:UNSIGNED_NUMBER
    {
      if (u->getText() == "0" && udpTable())
        $setToken(makeToken(UDP_0));
      else if (u->getText() == "1" && udpTable())
        $setToken(makeToken(UDP_1));
      else {
        $setToken(makeNumberToken(UNSIGNED_NUMBER, VerilogNumber::build( _RS(u->getText()), VerilogNumber::NUM_BASED ) ) );
        // isSigned = FALSE, base = BASE_DEC, size = NOT_SIZED
      }
    }
  )
  {
    _token->setText(text.substr(_begin, text.length()-_begin));
  }
;

protected
BASED_NUMBER_HEADER returns [TBool s]:
  { s = FALSE; }
  '\''
  (('s' | 'S') { s = TRUE; })?
  ;

protected
BASED_NUMBER [TInt size] returns [RefVerilogNumber vn] 
{ 
  TBool isSigned; 
  bool hasXZ = true; 
}
: ( BASED_NUMBER_HEADER ('d' | 'D') )  => isSigned = BASED_NUMBER_HEADER ('d' | 'D') (' ' | '\t')*
  ( UNSIGNED_NUMBER
    {
      vn = VerilogNumber::build( _RS(getText()), VerilogNumber::NUM_BASED, isSigned, VerilogNumber::BASE_DEC, size, false);
    }
  | xz:XZ_NUMBER
    {
      vn = VerilogNumber::build( _RS(getText()), VerilogNumber::NUM_BASED, isSigned, VerilogNumber::BASE_DEC, size, true );
    }
  )
| (BASED_NUMBER_HEADER ('b' | 'B')) => isSigned = BASED_NUMBER_HEADER ('b' | 'B') (' ' | '\t')* hasXZ = BIN_NUMBER
  {
    vn = VerilogNumber::build( _RS(getText()), VerilogNumber::NUM_BASED, isSigned, VerilogNumber::BASE_BIN, size, hasXZ );
  }
| (BASED_NUMBER_HEADER ('o' | 'O')) => isSigned = BASED_NUMBER_HEADER ('o' | 'O') (' ' | '\t')* hasXZ = OCT_NUMBER
  {
    vn = VerilogNumber::build( _RS(getText()), VerilogNumber::NUM_BASED, isSigned, VerilogNumber::BASE_OCT, size, hasXZ );
  }
| (BASED_NUMBER_HEADER ('h' | 'H')) => isSigned = BASED_NUMBER_HEADER ('h' | 'H') (' ' | '\t')* hasXZ = HEX_NUMBER
  {
    vn = VerilogNumber::build( _RS(getText()), VerilogNumber::NUM_BASED, isSigned, VerilogNumber::BASE_HEX, size, hasXZ);
  }
;

SYSTEM_TASK_NAME
        options { testLiterals = true; }
    :
    '$' (ALPHA | DIGIT | '$')+
    ;

protected
FILENAME : (~'"')* ;

protected
LINE_NUMBER : (DIGIT)+ ;

HASH_LINE :
    "#line" (W)+ '"' fn:FILENAME '"' (W)+
    l:LINE_NUMBER ((~('0'..'9' | '\r' | '\n')) (~('\r' | '\n'))*)?
    (END_OF_LINE)?
    {
    handleLineDirective(fn->getText(), l->getText());
    $setType(Token::SKIP);
    }
    ;

DIRECTIVE 
: '`'!  
  ( i:IDENTIFIER ( (W)+ (~(' ' | '\t' | '\b' | '\f' | '\r' | '\n')) (~('\r' | '\n'))* )?)
  (END_OF_LINE!)?
  {
    cout << "WARNING: Directives are ignored" << endl;
    $setType(Token::SKIP);
  }
;

WS :
    (
       W
     | END_OF_LINE
    )
    { $setType(Token::SKIP); }
    ;

SL_COMMENT :
    "//" (~('\r' | '\n'))* (END_OF_LINE)?
    { $setType(Token::SKIP); }
    ;

ML_COMMENT :
    "/*"
    (  { LA(2) != '/' }? '*'
     | END_OF_LINE
     | ~('*' | '\r' | '\n')
    )*
    "*/"
    { $setType(Token::SKIP); }
    ;

// End of File
