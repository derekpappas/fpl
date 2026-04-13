package com.fastpath.cslc.cslgen;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Random;
import org.junit.jupiter.api.Test;

class CslGenNumExprSupportTest {

    @Test
    void createTreeLeafDigit() {
        Random rng = new Random(1L);
        CslGenNumExpr n = CslGenNumExprSupport.createTree(0, rng);
        assertNotNull(n);
        assertNull(n.left());
        assertNull(n.right());
        assertEquals(1, n.value().length());
    }

    @Test
    void randNumExprDeterministicWithSeed() {
        Random rng = new Random(99L);
        String s = CslGenNumExprSupport.randNumExpr(rng);
        assertEquals(2, s.length());
        for (int i = 0; i < s.length(); i++) {
            assertTrue(Character.isDigit(s.charAt(i)));
        }
    }

    @Test
    void createTreeWithDepthAtLeastOneReturnsNull() {
        assertNull(CslGenNumExprSupport.createTree(1, new Random(0L)));
    }

    @Test
    void displayTreeNullIsNoOp() {
        StringBuilder sb = new StringBuilder("keep");
        CslGenNumExprSupport.displayTree(null, sb);
        assertEquals("keep", sb.toString());
    }

    @Test
    void displayTreeWalksLeftValueRightInOrder() {
        CslGenNumExpr left = new CslGenNumExpr("1", null, null);
        CslGenNumExpr right = new CslGenNumExpr("2", null, null);
        CslGenNumExpr root = new CslGenNumExpr("+", left, right);
        StringBuilder sb = new StringBuilder();
        CslGenNumExprSupport.displayTree(root, sb);
        assertEquals("1+2", sb.toString());
    }
}
