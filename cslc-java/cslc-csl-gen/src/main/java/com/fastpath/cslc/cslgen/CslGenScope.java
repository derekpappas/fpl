package com.fastpath.cslc.cslgen;

/**
 * Legacy {@code CSLbase::addToScope} / {@code removeFromScope} ({@code cslInterconnectGen_TB.cpp}); used from
 * {@link CslGenCslBase#interconnectAddToScope} / {@link CslGenCslBase#interconnectRemoveFromScope} for {@code randSelObj}
 * scope strings.
 */
public final class CslGenScope {

    private CslGenScope() {}

    public static String addToScope(String scope, String toAdd) {
        return scope + toAdd + ".";
    }

    public static String removeFromScope(String scope) {
        if (scope.isEmpty()) {
            return "";
        }
        int pos = scope.lastIndexOf('.') - 1;
        while (pos > 0 && scope.charAt(pos) != '.') {
            pos--;
        }
        if (pos > 0) {
            return scope.substring(0, pos + 1);
        }
        return "";
    }
}
