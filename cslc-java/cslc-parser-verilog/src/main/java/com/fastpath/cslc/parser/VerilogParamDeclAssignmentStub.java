package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of one {@code param_assignment} from a {@code parameter_declaration},
 * {@code local_parameter_declaration}, or {@code module_parameter_port_list} (batch 6 continuation).
 *
 * @param declarationKind {@code "parameter"}, {@code "localparam"}, or {@code "module_parameter_port"} for
 *     {@code #( ... )} on the module header
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
