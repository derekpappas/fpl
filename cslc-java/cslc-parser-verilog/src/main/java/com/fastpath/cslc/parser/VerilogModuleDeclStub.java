package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a {@code module} declaration from {@link com.fastpath.cslc.parser.verilog.VerilogParserTrunkPort}
 * until a full CDOM / Verilog IR is wired (see {@code ANTLR_PORT_BATCH_PLAN.txt} batch 6).
 *
 * @param macromodule {@code true} when the source used {@code macromodule} ({@code module_keyword})
 * @param moduleParameterPortListText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of
 *     {@code module_parameter_port_list} when present; otherwise {@code null}
 * @param portsListText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of {@code list_of_port_declarations} or,
 *     if absent, {@code list_of_ports} when present and non-empty; otherwise {@code null}
 */
public record VerilogModuleDeclStub(
        String moduleName,
        int line,
        int column,
        String sourceName,
        boolean macromodule,
        String moduleParameterPortListText,
        String portsListText)
        implements VerilogDesignElementStub {}
