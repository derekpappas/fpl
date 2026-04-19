package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of an {@code initial_construct} (batch 6 continuation).
 *
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the construct subtree
 */
public record VerilogInitialConstructStub(String enclosingModuleName, String synopsis, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
