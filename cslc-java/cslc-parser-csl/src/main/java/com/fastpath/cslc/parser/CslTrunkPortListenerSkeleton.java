package com.fastpath.cslc.parser;

import com.fastpath.cslc.parser.csl.CslParserTrunkPortBaseListener;

/**
 * Empty {@link org.antlr.v4.runtime.tree.ParseTreeListener} base for incrementally porting legacy
 * ANTLR2 {@code csl.walker.g} behavior onto the ANTLR4 {@code CslParserTrunkPort} parse tree.
 * Subclasses override {@code enter*} / {@code exit*} methods as individual tree-parser rules are
 * migrated.
 *
 * @see CslParserTrunkPortFacade
 */
public class CslTrunkPortListenerSkeleton extends CslParserTrunkPortBaseListener {}
