package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a module header {@code list_of_ports} (non-ANSI port list). Directions appear on
 * subsequent {@code port_declaration} items in the module body, not in this list.
 *
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the port list (inside the parentheses)
 */
public record VerilogListOfPortsStub(String enclosingModuleName, String synopsis, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
