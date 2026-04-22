package com.fastpath.cslc.parser;

/**
 * One {@code module_instance} under {@code module_or_udp_instantiation} ({@code moduleType} is the leading
 * {@code module_identifier}; {@code instanceName} is {@code null} when the instance is anonymous).
 *
 * @param enclosingModuleName containing {@code module} identifier from the listener stack (empty string if unknown)
 * @param parameterValueAssignmentText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of
 *     {@code parameter_value_assignment_or_delay2} when present (applies to every {@code module_instance} in the
 *     same instantiation); otherwise {@code null}
 * @param portConnectionsText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of this instance's
 *     {@code list_of_port_connections} when non-empty; otherwise {@code null}
 */
public record VerilogModuleInstanceStub(
        String enclosingModuleName,
        String moduleType,
        String instanceName,
        String parameterValueAssignmentText,
        String portConnectionsText,
        int line,
        int column,
        String sourceName)
        implements VerilogDesignElementStub {}
