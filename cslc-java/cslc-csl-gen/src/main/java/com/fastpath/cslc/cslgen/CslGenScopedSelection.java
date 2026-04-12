package com.fastpath.cslc.cslgen;

/**
 * Legacy {@code pair<string, CSLbase*>} / {@code CSLscopedBasePoint} ({@code cslInterconnectGen_TB.h}) for
 * {@link CslGenCslBase#randSelObj}.
 */
public record CslGenScopedSelection(String scope, CslGenCslBase selected) {

    /** Legacy scoped pair {@code .first} (dotted scope prefix). Same as {@link #scope()}. */
    public String first() {
        return scope;
    }

    /** Legacy scoped pair {@code .second} (selected node, may be {@code null}). Same as {@link #selected()}. */
    public CslGenCslBase second() {
        return selected;
    }
}
