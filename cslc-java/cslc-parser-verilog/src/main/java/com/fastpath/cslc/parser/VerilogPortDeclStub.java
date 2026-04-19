package com.fastpath.cslc.parser;

/**
 * A module port from {@code port_declaration} (ANSI list or body-style), syntax-only.
 *
 * @param enclosingModuleName module whose port list or body contains this port (may be empty if the parser
 *                            stack was not primed)
 * @param direction {@code input}, {@code output}, or {@code inout}
 */
public record VerilogPortDeclStub(
        String enclosingModuleName, String portName, String direction, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
