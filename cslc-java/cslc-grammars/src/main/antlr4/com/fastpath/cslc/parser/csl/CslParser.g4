parser grammar CslParser;

options { tokenVocab = CslLexer; }

/*
 * Incremental Java port of legacy trunk ANTLR2 csl.parser.g (17k+ lines with C++ actions).
 * Top shape follows legacy source_text / description; rules grow as the port proceeds.
 * Full semantic parity (CSLOM, sym tree, walker) remains C++ until ported separately.
 */

sourceFile
    : (description)* EOF
    ;

description
    : SEMI
    | unitDecl
    ;

/** Minimal subset used by TB strings and smoke tests: {@code csl_unit name { };} */
unitDecl
    : K_CSL_UNIT IDENTIFIER LCURLY RCURLY SEMI
    ;
