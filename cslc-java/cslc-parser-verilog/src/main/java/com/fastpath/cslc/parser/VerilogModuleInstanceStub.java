package com.fastpath.cslc.parser;

/**
 * One {@code module_instance} under {@code module_or_udp_instantiation} ({@code moduleType} is the leading
 * {@code module_identifier}; {@code instanceName} is {@code null} when the instance is anonymous).
 */
public record VerilogModuleInstanceStub(
        String moduleType, String instanceName, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
