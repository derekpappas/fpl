package com.fastpath.cslc.cslgen.cgentb;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Minimal analogue of legacy {@code createPreDeclVectOrder} ({@code cGenBase_tb.cpp}): given a list of “predecl dimensions”
 * with {@code size} choices each, returns the cartesian product in a stable order.
 */
public final class CGenTbPreDeclOrder {

    private CGenTbPreDeclOrder() {}

    /**
     * Returns all index tuples for the cartesian product of {@code sizes}. Each tuple has length {@code sizes.size()}.
     *
     * <p>Example: sizes [2,3] yields: [0,0], [1,0], [0,1], [1,1], [0,2], [1,2].
     */
    public static List<int[]> cartesianIndices(List<Integer> sizes) {
        Objects.requireNonNull(sizes, "sizes");
        if (sizes.isEmpty()) {
            return List.of(new int[0]);
        }
        int[] s = new int[sizes.size()];
        for (int i = 0; i < s.length; i++) {
            int v = Objects.requireNonNull(sizes.get(i), "size").intValue();
            if (v < 0) {
                throw new IllegalArgumentException("size must be >= 0");
            }
            s[i] = v;
        }
        for (int v : s) {
            if (v == 0) {
                return List.of();
            }
        }
        List<int[]> out = new ArrayList<>();
        int[] idx = new int[s.length];
        while (true) {
            out.add(idx.clone());
            int k = 0;
            while (k < idx.length) {
                idx[k]++;
                if (idx[k] < s[k]) {
                    break;
                }
                idx[k] = 0;
                k++;
            }
            if (k == idx.length) {
                break;
            }
        }
        return out;
    }
}

