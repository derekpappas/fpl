package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of a labeled or unlabeled {@code generate_block}, or a {@code generate_loop_statement}
 * (batch 6 continuation — generate hierarchy).
 *
 * @param blockKind {@code "block"} for {@code generate_block}, {@code "for_loop"} for {@code generate_loop_statement}
 * @param blockLabel {@code generate_block_identifier} text when present; {@code null} for anonymous {@code begin} …
 *     {@code end} inside {@code generate}
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the block or for-loop subtree
 */
public record VerilogGenerateBlockStub(
        String enclosingModuleName,
        String blockKind,
        String blockLabel,
        String synopsis,
        int line,
        int column,
        String sourceName)
        implements VerilogDesignElementStub {}
