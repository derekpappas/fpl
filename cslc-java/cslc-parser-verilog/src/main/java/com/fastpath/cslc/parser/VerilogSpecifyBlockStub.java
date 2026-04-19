package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code specify_block} ({@code specify} … {@code endspecify}).
 *
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the block subtree
 */
public record VerilogSpecifyBlockStub(String enclosingModuleName, String synopsis, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
