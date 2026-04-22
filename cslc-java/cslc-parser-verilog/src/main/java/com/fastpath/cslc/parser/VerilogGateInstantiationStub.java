package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code gate_instantiation} (batch 6 continuation).
 *
 * @param gateKind keyword or switch-type subtree text for the matched {@code gate_instantiation} alternative
 *     (for example {@code buf}, {@code nand}, {@code pulldown}); empty when none of the typed alternatives matched
 * @param gateText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the {@code gate_instantiation} subtree
 */
public record VerilogGateInstantiationStub(
        String enclosingModuleName, String gateKind, String gateText, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
