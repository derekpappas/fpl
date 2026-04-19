package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code gate_instantiation} (batch 6 continuation).
 *
 * @param gateText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the {@code gate_instantiation} subtree
 */
public record VerilogGateInstantiationStub(String enclosingModuleName, String gateText, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
