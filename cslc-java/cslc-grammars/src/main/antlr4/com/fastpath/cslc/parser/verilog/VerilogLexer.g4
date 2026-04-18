lexer grammar VerilogLexer;

// Generated in part by scripts/gen_verilog_lexer_g4.py from legacy verilog.lexer.g tokens{}
// Operators, numbers, identifiers: hand-aligned with legacy lexer (UDP/table modes not modeled).

K_PULSESTYLE_ONDETECT : 'pulsestyle_ondetect' ;
K_PULSESTYLE_ONEVENT : 'pulsestyle_onevent' ;
K_NOSHOWCANCELLED : 'noshowcancelled' ;
K_SHOWCANCELLED : 'showcancelled' ;
K_ENDPRIMITIVE : 'endprimitive' ;
K_ENDFUNCTION : 'endfunction' ;
K_ENDGENERATE : 'endgenerate' ;
K_MACROMODULE : 'macromodule' ;
K_ENDSPECIFY : 'endspecify' ;
K_LOCALPARAM : 'localparam' ;
K_S_SETUPHOLD : '$setuphold' ;
K_S_ATTRIBUTE : '$attribute' ;
K_AUTOMATIC : 'automatic' ;
K_ENDMODULE : 'endmodule' ;
K_PARAMETER : 'parameter' ;
K_PRIMITIVE : 'primitive' ;
K_SPECPARAM : 'specparam' ;
K_S_RECOVERY : '$recovery' ;
K_S_TIMESKEW : '$timeskew' ;
K_S_FULLSKEW : '$fullskew' ;
K_S_NOCHANGE : '$nochange' ;
K_DEASSIGN : 'deassign' ;
K_DEFPARAM : 'defparam' ;
K_FUNCTION : 'function' ;
K_GENERATE : 'generate' ;
K_PULLDOWN : 'pulldown' ;
K_REALTIME : 'realtime' ;
K_RTRANIF0 : 'rtranif0' ;
K_RTRANIF1 : 'rtranif1' ;
K_SCALARED : 'scalared' ;
K_VECTORED : 'vectored' ;
K_S_REMOVAL : '$removal' ;
K_DEFAULT : 'default' ;
K_DISABLE : 'disable' ;
K_ENDCASE : 'endcase' ;
K_ENDTASK : 'endtask' ;
K_FOREVER : 'forever' ;
K_INITIAL : 'initial' ;
K_INTEGER : 'integer' ;
K_NEGEDGE : 'negedge' ;
K_POSEDGE : 'posedge' ;
K_RELEASE : 'release' ;
K_SPECIFY : 'specify' ;
K_STRONG0 : 'strong0' ;
K_STRONG1 : 'strong1' ;
K_SUPPLY0 : 'supply0' ;
K_SUPPLY1 : 'supply1' ;
K_TRANIF0 : 'tranif0' ;
K_TRANIF1 : 'tranif1' ;
K_S_RECREM : '$recrem' ;
K_S_PERIOD : '$period' ;
K_ALWAYS : 'always' ;
K_ASSIGN : 'assign' ;
K_BUFIF0 : 'bufif0' ;
K_BUFIF1 : 'bufif1' ;
K_GENVAR : 'genvar' ;
K_HIGHZ0 : 'highz0' ;
K_HIGHZ1 : 'highz1' ;
K_IFNONE : 'ifnone' ;
K_MEDIUM : 'medium' ;
K_MODULE : 'module' ;
K_NOTIF0 : 'notif0' ;
K_NOTIF1 : 'notif1' ;
K_OUTPUT : 'output' ;
K_PULLUP : 'pullup' ;
K_REPEAT : 'repeat' ;
K_SIGNED : 'signed' ;
K_TRIAND : 'triand' ;
K_TRIREG : 'trireg' ;
K_S_SETUP : '$setup' ;
K_S_WIDTH : '$width' ;
K_BEGIN : 'begin' ;
K_CASEX : 'casex' ;
K_CASEZ : 'casez' ;
K_EVENT : 'event' ;
K_FORCE : 'force' ;
K_INOUT : 'inout' ;
K_INPUT : 'input' ;
K_LARGE : 'large' ;
K_PULL0 : 'pull0' ;
K_PULL1 : 'pull1' ;
K_RCMOS : 'rcmos' ;
K_RNMOS : 'rnmos' ;
K_RPMOS : 'rpmos' ;
K_RTRAN : 'rtran' ;
K_SMALL : 'small' ;
K_TRIOR : 'trior' ;
K_WEAK0 : 'weak0' ;
K_WEAK1 : 'weak1' ;
K_WHILE : 'while' ;
K_S_HOLD : '$hold' ;
K_S_SKEW : '$skew' ;
K_CASE : 'case' ;
K_CMOS : 'cmos' ;
K_EDGE : 'edge' ;
K_ELSE : 'else' ;
K_FORK : 'fork' ;
K_JOIN : 'join' ;
K_NAND : 'nand' ;
K_NMOS : 'nmos' ;
K_PMOS : 'pmos' ;
K_REAL : 'real' ;
K_TASK : 'task' ;
K_TIME : 'time' ;
K_TRAN : 'tran' ;
K_TRI0 : 'tri0' ;
K_TRI1 : 'tri1' ;
K_WAIT : 'wait' ;
K_WAND : 'wand' ;
K_WIRE : 'wire' ;
K_XNOR : 'xnor' ;
K_AND : 'and' ;
K_BUF : 'buf' ;
K_END : 'end' ;
K_FOR : 'for' ;
K_NOR : 'nor' ;
K_NOT : 'not' ;
K_REG : 'reg' ;
K_TRI : 'tri' ;
K_WOR : 'wor' ;
K_XOR : 'xor' ;
K_IF : 'if' ;
K_OR : 'or' ;

// --- Punctuation and operators (legacy verilog.lexer.g; XNOR before XOR like CslLexer) ---
BACKTICK   : '`' ;
AT         : '@' ;
COLON      : ':' ;
COMMA      : ',' ;
DOT        : '.' ;
ASSIGN     : '=' ;
MINUS      : '-' ;
LBRACK     : '[' ;
RBRACK     : ']' ;
// Legacy verilog.lexer.g names (parser importVocab=Verilog matches these, not LCURLY/RCURLY)
LCRULY     : '{' ;
RCRULY     : '}' ;
LPAREN     : '(' ;
RPAREN     : ')' ;
POUND      : '#' ;
QUESTION   : '?' ;
SEMI       : ';' ;
PLUS       : '+' ;
LNOT       : '!' ;
NOT        : '~' ;
AND        : '&' ;
NAND       : '~&' ;
OR         : '|' ;
NOR        : '~|' ;
XNOR       : '~^' | '^~' ;
XOR        : '^' ;
STAR       : '*' ;
POW        : '**' ;
DIV        : '/' ;
MOD        : '%' ;
EQUAL      : '==' ;
NOT_EQ     : '!=' ;
NOT_EQ_CASE: '!==' ;
EQ_CASE    : '===' ;
LAND       : '&&' ;
TAND       : '&&&' ;
LOR        : '||' ;
LT_        : '<' ;
LE         : '<=' ;
GT         : '>' ;
GE         : '>=' ;
SL         : '<<' ;
SSL        : '<<<' ;
SR         : '>>' ;
SSR        : '>>>' ;
TRIGGER    : '->' ;
PPATH      : '=>' ;
FPATH      : '*>' ;
SUPERSTAR  : '(*)' ;
PSTAR      : '(*' ;
STARP      : '*)' ;
PO_POS     : '+:' ;
PO_NEG     : '-:' ;

EDGE_DESC : ( '0' | '1' ) ( 'x' | 'X' | 'z' | 'Z' ) ;

// Legacy treats PATHPULSE$... as a dedicated token
PATHPULSE : 'PATHPULSE' '$' [a-zA-Z0-9_$]* ;

STRING
    : '"' ( '\\' ~[\r\n] | ~["\\\r\n] )* '"'
    ;

fragment DIGIT : [0-9] ;
fragment NZ_DIGIT : [1-9] ;
fragment HEX_DIGIT : [0-9a-fA-F] ;
fragment BIN_DIGIT : [01] ;
fragment OCT_DIGIT : [0-7] ;
fragment XZ_DIGIT : [xXzZ?] ;

// Exposed as in legacy lexer/parser (NUMBER rule in .g delegates to these token types)
UNSIGNED_NUMBER : DIGIT ( DIGIT | '_' )* ;

NZ_UNSIGNED_NUMBER : [1-9] ( DIGIT | '_' )* ;

REAL_NUMBER
    : UNSIGNED_NUMBER '.' UNSIGNED_NUMBER
    ;

REAL_NUMBER_EXP
    : UNSIGNED_NUMBER ('.' UNSIGNED_NUMBER)? [eE] [+-]? UNSIGNED_NUMBER
    ;

// Commented as //TICK in legacy .g; parser unexpected{} still references TICK
TICK : ['] ;

// Sized/unsized based literals (simplified vs legacy VerilogNumber pipeline; good enough for lexer coverage)
BASED_NUMBER
    : [0-9]* '\'' [sS]? [bB] ( WHITE_SPACE_IN_BASED* ( BIN_DIGIT | XZ_DIGIT | '_' ) )+
    | [0-9]* '\'' [sS]? [oO] ( WHITE_SPACE_IN_BASED* ( OCT_DIGIT | XZ_DIGIT | '_' ) )+
    | [0-9]* '\'' [sS]? [dD] ( WHITE_SPACE_IN_BASED* ( DIGIT | XZ_DIGIT | '_' ) )+
    | [0-9]* '\'' [sS]? [hH] ( WHITE_SPACE_IN_BASED* ( HEX_DIGIT | XZ_DIGIT | '_' ) )+
    ;

fragment WHITE_SPACE_IN_BASED : [ \t] ;

ESCAPED_IDENTIFIER
    : '\\' ~[.\r\n\t \u000B\f]+ (' ' | '\t' | [\u000B\f] | '\r' | '\n')?
    ;

IDENTIFIER : [a-zA-Z_] [a-zA-Z0-9_$]* ;

SYSTEM_TASK_NAME : '$' [a-zA-Z0-9_$]+ ;

// Legacy skips these; hide so parsers can ignore them uniformly
HASH_LINE
    : '#line' [ \t]+ '"' ~["\r\n]* '"' [ \t]+ [0-9]+ ~[\r\n]* ( '\r'? '\n' | '\r' )? -> channel(HIDDEN)
    ;

DIRECTIVE
    : '`' ~[\r\n]* ( '\r'? '\n' | '\r' )? -> channel(HIDDEN)
    ;

SL_COMMENT : '//' ~[\r\n]* -> channel(HIDDEN) ;
ML_COMMENT : '/*' .*? '*/' -> channel(HIDDEN) ;

WS : [ \t\u000B\f\r\n]+ -> channel(HIDDEN) ;
