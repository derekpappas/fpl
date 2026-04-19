package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code module} declaration from {@link com.fastpath.cslc.parser.verilog.VerilogParserTrunkPort}
 * until a full CDOM / Verilog IR is wired (see {@code ANTLR_PORT_BATCH_PLAN.txt} batch 6).
 *
 * @param macromodule {@code true} when the source used {@code macromodule} ({@code module_keyword})
 */
public record VerilogModuleDeclStub(String moduleName, int line, int column, String sourceName, boolean macromodule)
        implements VerilogDesignElementStub {}
