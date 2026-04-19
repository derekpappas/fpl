package com.fastpath.cslc.parser;

/** Syntax-only lift of a {@code primitive} ({@code udp_declaration}) from the trunk-port Verilog grammar. */
public record VerilogUdpDeclStub(String udpName, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
