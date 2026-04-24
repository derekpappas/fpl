package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code generate_conditional_statement} ({@code if} / {@code else} under {@code generate}).
 *
 * @param generateScopePath nesting path for this conditional within the enclosing module
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the conditional subtree
 */
public record VerilogGenerateConditionalStub(
        String enclosingModuleName,
        String generateScopePath,
        String synopsis,
        int line,
        int column,
        String sourceName)
        implements VerilogDesignElementStub {}
