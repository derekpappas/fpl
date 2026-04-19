package com.fastpath.cslc.parser;

/** Syntax-only lift of a {@code task_declaration} inside a module (batch 6 continuation). */
public record VerilogTaskDeclStub(String enclosingModuleName, String taskName, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
