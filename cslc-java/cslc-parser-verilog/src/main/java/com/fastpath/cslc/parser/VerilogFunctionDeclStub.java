package com.fastpath.cslc.parser;

/** Syntax-only lift of a {@code function_declaration} inside a module (batch 6 continuation). */
public record VerilogFunctionDeclStub(
        String enclosingModuleName, String functionName, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
