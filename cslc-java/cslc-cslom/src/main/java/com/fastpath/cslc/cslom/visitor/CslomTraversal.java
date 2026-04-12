package com.fastpath.cslc.cslom.visitor;

import com.fastpath.cslc.cslom.CslomBase;

/** Depth-first pre-order walk (common default for {@code CVisitorTraversal} generators). */
public final class CslomTraversal {

    private CslomTraversal() {}

    public static void preorder(CslomBase root, CslomVisitor visitor) {
        visitor.visit(root);
        for (CslomBase child : root.getChildren()) {
            preorder(child, visitor);
        }
    }
}
