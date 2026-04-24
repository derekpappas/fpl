package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code generated_instantiation} ({@code generate} … {@code endgenerate}) region
 * (batch 6 continuation).
 *
 * @param generateScopePath nesting path for this region within the enclosing module (e.g. {@code "generate"}).
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the region subtree
 */
public record VerilogGenerateRegionStub(
        String enclosingModuleName,
        String generateScopePath,
        String synopsis,
        int line,
        int column,
        String sourceName)
        implements VerilogDesignElementStub {}
