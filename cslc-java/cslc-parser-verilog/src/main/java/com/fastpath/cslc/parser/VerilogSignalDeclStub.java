package com.fastpath.cslc.parser;

/**
 * In-module variable-like declarations (syntax-only lift of declared identifiers).
 *
 * @param declarationKind {@code net}, {@code reg}, {@code integer}, {@code time}, {@code real}, {@code realtime},
 *                        {@code event}, or {@code genvar}
 * @param flavor for nets, the {@code net_type} text (e.g. {@code wire}) or {@code trireg}; for other kinds usually
 *               matches {@code declarationKind}
 */
public record VerilogSignalDeclStub(
        String enclosingModuleName,
        String signalName,
        String declarationKind,
        String flavor,
        int line,
        int column,
        String sourceName)
        implements VerilogDesignElementStub {}
