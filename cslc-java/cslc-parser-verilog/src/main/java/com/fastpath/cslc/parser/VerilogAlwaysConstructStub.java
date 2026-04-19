package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of an {@code always_construct} (batch 6 continuation).
 *
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the construct subtree
 */
public record VerilogAlwaysConstructStub(String enclosingModuleName, String synopsis, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
