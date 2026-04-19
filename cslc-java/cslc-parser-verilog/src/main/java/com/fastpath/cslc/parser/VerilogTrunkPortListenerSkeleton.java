package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.verilog.VerilogParserTrunkPortBaseListener;

/**
 * Empty {@link org.antlr.v4.runtime.tree.ParseTreeListener} base for incrementally porting legacy
 * ANTLR2 {@code verilog.walker.g} behavior onto the ANTLR4 {@code VerilogParserTrunkPort} parse tree.
 * Subclasses override {@code enter*} / {@code exit*} methods as individual tree-parser rules are
 * migrated.
 *
 * @see VerilogParserTrunkPortFacade
 */
public class VerilogTrunkPortListenerSkeleton extends VerilogParserTrunkPortBaseListener {}
