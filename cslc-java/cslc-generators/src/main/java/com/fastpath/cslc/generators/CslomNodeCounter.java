package com.fastpath.cslc.generators;

import com.fastpath.cslc.cslom.CslomBase;
import com.fastpath.cslc.cslom.visitor.CslomVisitor;

/**
 * Counts nodes in a {@link com.fastpath.cslc.cslom.visitor.CslomTraversal#preorder preorder} walk — first step beyond
 * {@link NoopCslomTraversal} toward {@code CVisitorTraversal}-style generators ({@code CSLOM_Visitor.h} /
 * {@code trunk/cslc/trunk/src/cslom_generators/}).
 */
public final class CslomNodeCounter implements CslomVisitor {

    private int count;

    @Override
    public void visit(CslomBase node) {
        count++;
    }

    public int getCount() {
        return count;
    }

    public void reset() {
        count = 0;
    }
}
