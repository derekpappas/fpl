package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of one {@code net_assignment} under {@code continuous_assign} (batch 6 continuation).
 *
 * @param assignText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the {@code net_assignment} subtree
 * @param statementSynopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the enclosing
 *     {@code continuous_assign} (shared when one statement has several {@code net_assignment}s)
 */
public record VerilogContinuousAssignStub(
        String enclosingModuleName,
        String assignText,
        String statementSynopsis,
        int line,
        int column,
        String sourceName)
        implements VerilogDesignElementStub {}
