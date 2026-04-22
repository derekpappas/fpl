package com.fastpath.cslc.parser;

/**
 * Syntax-only lift of an {@code always_construct} (batch 6 continuation).
 *
 * @param attrsOptText {@link org.antlr.v4.runtime.ParserRuleContext#getText} of {@code attrs_opt} when non-empty;
 *     {@code null} when there are no {@code attribute_instance}s before the statement
 * @param synopsis {@link org.antlr.v4.runtime.ParserRuleContext#getText} of the construct subtree
 */
public record VerilogAlwaysConstructStub(
        String enclosingModuleName, String attrsOptText, String synopsis, int line, int column, String sourceName)
        implements VerilogDesignElementStub {}
