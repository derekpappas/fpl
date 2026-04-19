package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of one {@code param_assignment} from a {@code parameter_declaration} or
 * {@code local_parameter_declaration} (batch 6 continuation).
 *
 * @param declarationKind {@code "parameter"} or {@code "localparam"}
 * @param assignmentText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the {@code param_assignment}
 */
public record VerilogParamDeclAssignmentStub(
        String enclosingModuleName,
        String declarationKind,
        String assignmentText,
        int line,
        int column,
        String sourceName)
        implements VerilogDesignElementStub {}
