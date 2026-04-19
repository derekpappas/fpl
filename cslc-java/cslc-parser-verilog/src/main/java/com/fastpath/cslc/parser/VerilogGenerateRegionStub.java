package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code generated_instantiation} ({@code generate} … {@code endgenerate}) region
 * (batch 6 continuation).
 *
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the region subtree
 */
public record VerilogGenerateRegionStub(String enclosingModuleName, String synopsis, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
