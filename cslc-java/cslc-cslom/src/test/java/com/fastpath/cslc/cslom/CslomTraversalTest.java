package com.fastpath.cslc.cslom;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.fastpath.cslc.cslom.visitor.CslomTraversal;
import com.fastpath.cslc.cslom.visitor.CslomVisitor;
import java.util.concurrent.atomic.AtomicInteger;
import org.junit.jupiter.api.Test;

class CslomTraversalTest {

    @Test
    void preorderVisitsAllNodes() {
        CslomPlaceholder root = new CslomPlaceholder(CslomNodeType.TYPE_DESIGN, 1, 0, "t.csl");
        CslomPlaceholder a = new CslomPlaceholder(CslomNodeType.TYPE_LIST, 2, 0, "t.csl");
        CslomPlaceholder b = new CslomPlaceholder(CslomNodeType.TYPE_EXPR, 3, 0, "t.csl");
        root.addChild(a);
        a.addChild(b);
        AtomicInteger count = new AtomicInteger();
        CslomVisitor visitor = node -> count.incrementAndGet();
        CslomTraversal.preorder(root, visitor);
        assertEquals(3, count.get());
    }
}
