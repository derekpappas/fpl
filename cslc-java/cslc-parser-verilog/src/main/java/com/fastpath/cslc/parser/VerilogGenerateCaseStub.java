package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code generate_case_statement}.
 *
 * @param generateScopePath nesting path for this case within the enclosing module
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the {@code case} subtree
 */
public record VerilogGenerateCaseStub(
        String enclosingModuleName,
        String generateScopePath,
        String synopsis,
        int line,
        int column,
        String sourceName)
        implements VerilogDesignElementStub {}
