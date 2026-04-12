package com.fastpath.cslc.cslgen;

import java.util.random.RandomGenerator;

/**
 * Legacy {@code createTree}, {@code displayTree}, {@code randNumExpr} ({@code trunk/cslc/trunk/csl_gen/support.cpp}).
 * The C++ {@code displayTree} took {@code std::string} by value so mutations did not propagate; this port uses a
 * single {@link StringBuilder} so {@link #randNumExpr(RandomGenerator)} actually concatenates the in-order walk.
 */
public final class CslGenNumExprSupport {

    private CslGenNumExprSupport() {}

    /** Same control flow as legacy {@code createTree(int)} with {@code flag} fixed at {@code 0}. */
    public static CslGenNumExpr createTree(int i, RandomGenerator rng) {
        int flag = 0;
        if (flag != 2 && i < 1) {
            String digit = CslGenInt.intToString(rng.nextInt(10));
            return new CslGenNumExpr(digit, null, null);
        }
        return null;
    }

    public static void displayTree(CslGenNumExpr node, StringBuilder out) {
        if (node == null) {
            return;
        }
        displayTree(node.left(), out);
        out.append(node.value());
        displayTree(node.right(), out);
    }

    public static String randNumExpr(RandomGenerator rng) {
        StringBuilder nE = new StringBuilder(CslGenInt.intToString(rng.nextInt(10)));
        CslGenNumExpr node = createTree(0, rng);
        if (node == null) {
            nE.setLength(0);
            nE.append(CslGenInt.intToString(rng.nextInt(10)));
        } else {
            displayTree(node, nE);
        }
        return nE.toString();
    }
}
