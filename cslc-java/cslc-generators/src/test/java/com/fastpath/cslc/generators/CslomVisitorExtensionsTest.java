package com.fastpath.cslc.generators;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fastpath.cslc.cslom.CslomNodeType;
import com.fastpath.cslc.cslom.CslomPlaceholder;
import com.fastpath.cslc.cslom.visitor.CslomTraversal;
import java.util.List;
import org.junit.jupiter.api.Test;

class CslomVisitorExtensionsTest {

    @Test
    void nodeCounterCountsPreorderNodes() {
        CslomPlaceholder root = new CslomPlaceholder(CslomNodeType.TYPE_DESIGN, 1, 0, null);
        root.addChild(new CslomPlaceholder(CslomNodeType.TYPE_DECL_UNIT, 2, 0, null));
        root.addChild(new CslomPlaceholder(CslomNodeType.TYPE_VECTOR, 3, 0, null));

        CslomNodeCounter counter = new CslomNodeCounter();
        CslomTraversal.preorder(root, counter);
        assertEquals(3, counter.getCount());

        counter.reset();
        CslomTraversal.preorder(root, counter);
        assertEquals(3, counter.getCount());
    }

    @Test
    void preorderTypeRecorderMatchesWalkOrder() {
        CslomPlaceholder root = new CslomPlaceholder(CslomNodeType.TYPE_DESIGN, 1, 0, null);
        CslomPlaceholder a = new CslomPlaceholder(CslomNodeType.TYPE_DECL_UNIT, 2, 0, null);
        CslomPlaceholder b = new CslomPlaceholder(CslomNodeType.TYPE_ENUM, 3, 0, null);
        root.addChild(a);
        a.addChild(b);

        CslomPreorderTypeRecorder rec = new CslomPreorderTypeRecorder();
        CslomTraversal.preorder(root, rec);
        assertEquals(
                List.of(CslomNodeType.TYPE_DESIGN, CslomNodeType.TYPE_DECL_UNIT, CslomNodeType.TYPE_ENUM),
                rec.getPreorderTypes());
    }

    @Test
    void indentedDebugVisitorShowsDepthAndMetadata() {
        CslomPlaceholder root = new CslomPlaceholder(CslomNodeType.TYPE_DESIGN, 10, 2, "a.csl");
        CslomPlaceholder child = new CslomPlaceholder(CslomNodeType.TYPE_DECL_UNIT, 20, 0, null);
        root.addChild(child);

        StringBuilder buf = new StringBuilder();
        CslomIndentedDebugVisitor v = new CslomIndentedDebugVisitor(buf);
        v.trace(root);

        String text = buf.toString();
        assertTrue(text.startsWith("TYPE_DESIGN line=10 col=2 file=a.csl\n"));
        assertTrue(text.contains("  TYPE_DECL_UNIT line=20 col=0\n"));
        assertEquals(text, v.toString());
    }
}
