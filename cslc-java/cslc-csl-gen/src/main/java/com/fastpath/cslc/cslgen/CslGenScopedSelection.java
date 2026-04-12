package com.fastpath.cslc.cslgen;

/**
 * Legacy {@code pair<string, CSLbase*>} / {@code CSLscopedBasePoint} ({@code cslInterconnectGen_TB.h}) for
 * {@link CslGenCslBase#randSelObj}.
 */
public record CslGenScopedSelection(String scope, CslGenCslBase selected) {}
