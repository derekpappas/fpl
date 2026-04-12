package com.fastpath.cslc.generators;

import com.fastpath.cslc.cslom.CslomBase;
import com.fastpath.cslc.cslom.visitor.CslomVisitor;

/**
 * Placeholder toward {@code CVisitorTraversal} generators ({@code trunk/cslc/trunk/src/cslom_generators/}).
 * Concrete generators will override {@link #visit} and accumulate output.
 */
public class NoopCslomTraversal implements CslomVisitor {

    @Override
    public void visit(CslomBase node) {
        // Subclasses replace with emission logic.
    }
}
