package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code generate_case_statement}.
 *
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the {@code case} subtree
 */
public record VerilogGenerateCaseStub(String enclosingModuleName, String synopsis, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
