package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of one {@code defparam_assignment} under {@code parameter_override} ({@code defparam}; batch 6
 * continuation).
 *
 * @param assignmentText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the {@code defparam_assignment}
 */
public record VerilogDefparamAssignmentStub(
        String enclosingModuleName, String assignmentText, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
