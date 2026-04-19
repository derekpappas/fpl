package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of one {@code specparam_assignment} under {@code specparam_declaration} (batch 6 continuation).
 *
 * @param assignmentText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the {@code specparam_assignment}
 */
public record VerilogSpecparamAssignmentStub(
        String enclosingModuleName, String assignmentText, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
