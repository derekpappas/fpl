package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code primitive} ({@code udp_declaration}) from the trunk-port Verilog grammar.
 *
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the full {@code udp_declaration}
 */
public record VerilogUdpDeclStub(String udpName, String synopsis, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
