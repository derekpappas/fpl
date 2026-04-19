parser grammar CslParser;

options { tokenVocab = CslLexer; }

/*
 * Small stub for smoke tests; legacy shape follows {@code source_text} / {@code description}.
 * The mechanical trunk port is {@code CslParserTrunkPort.g4} (same Maven module). Full semantic
 * parity (CSLOM, sym tree, walker) remains C++ until ported separately.
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
