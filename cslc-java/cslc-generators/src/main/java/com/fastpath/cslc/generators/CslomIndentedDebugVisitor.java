package com.fastpath.cslc.generators;

import com.fastpath.cslc.cslom.CslomBase;
import com.fastpath.cslc.cslom.visitor.CslomVisitor;

/**
 * Pre-order debug trace with indentation — narrow analogue of early {@code CVisitorTraversal} / generator tracing in
 * {@code trunk/cslc/trunk/src/cslom_generators/}. Uses {@link #visit(CslomBase)} for each line; call {@link #trace}
 * so depth is correct (plain {@link com.fastpath.cslc.cslom.visitor.CslomTraversal#preorder} alone does not pass depth
 * into {@link CslomVisitor}).
 */
public final class CslomIndentedDebugVisitor implements CslomVisitor {

    private final StringBuilder out;
    private int depth;

    public CslomIndentedDebugVisitor(StringBuilder out) {
        this.out = out;
    }

    /** Clear buffer and append a pre-order trace of {@code root} (two spaces per tree level). */
    public void trace(CslomBase root) {
        out.setLength(0);
        walk(root, 0);
    }

    /** Append a pre-order trace without clearing {@code out}. */
    public void appendTrace(CslomBase root) {
        walk(root, 0);
    }

    private void walk(CslomBase node, int level) {
        int saved = depth;
        depth = level;
        visit(node);
        for (CslomBase child : node.getChildren()) {
            walk(child, level + 1);
        }
        depth = saved;
    }

    @Override
    public void visit(CslomBase node) {
        out.append("  ".repeat(Math.max(0, depth)));
        out.append(node.getNodeType().name());
        out.append(" line=").append(node.getLineNumber());
        out.append(" col=").append(node.getColumnNumber());
        node.getFileName().ifPresent(f -> out.append(" file=").append(f));
        out.append('\n');
    }

    @Override
    public String toString() {
        return out.toString();
    }
}
