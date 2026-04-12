package com.fastpath.cslc.generators;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

import com.fastpath.cslc.cslom.CslomPlaceholder;
import com.fastpath.cslc.cslom.CslomNodeType;
import com.fastpath.cslc.cslom.visitor.CslomTraversal;
import org.junit.jupiter.api.Test;

class NoopCslomTraversalTest {

    @Test
    void noopTraversalCompletes() {
        CslomPlaceholder root = new CslomPlaceholder(CslomNodeType.TYPE_DESIGN, 1, 0, null);
        NoopCslomTraversal gen = new NoopCslomTraversal();
        assertDoesNotThrow(() -> CslomTraversal.preorder(root, gen));
    }
}
