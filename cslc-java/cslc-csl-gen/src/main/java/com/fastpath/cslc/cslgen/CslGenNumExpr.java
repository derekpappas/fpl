package com.fastpath.cslc.cslgen;

/**
 * Legacy {@code struct numExpr} ({@code support.h}) — immutable tree node for random numeric expression snippets.
 */
public record CslGenNumExpr(String value, CslGenNumExpr left, CslGenNumExpr right) {

    public CslGenNumExpr {
        value = value != null ? value : "";
    }
}
