package com.fastpath.cslc.generators;

import com.fastpath.cslc.cslom.CslomBase;
import com.fastpath.cslc.cslom.CslomNodeType;
import com.fastpath.cslc.cslom.visitor.CslomVisitor;
import java.util.ArrayList;
import java.util.List;

/**
 * Records {@link CslomNodeType} in preorder (harness / debug toward full {@code CVisitor} specializations).
 */
public final class CslomPreorderTypeRecorder implements CslomVisitor {

    private final List<CslomNodeType> preorderTypes = new ArrayList<>();

    @Override
    public void visit(CslomBase node) {
        preorderTypes.add(node.getNodeType());
    }

    /** Immutable snapshot of types seen so far. */
    public List<CslomNodeType> getPreorderTypes() {
        return List.copyOf(preorderTypes);
    }

    public void clear() {
        preorderTypes.clear();
    }
}
