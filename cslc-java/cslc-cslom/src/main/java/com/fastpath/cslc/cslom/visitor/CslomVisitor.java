package com.fastpath.cslc.cslom.visitor;

import com.fastpath.cslc.cslom.CslomBase;

/**
 * Minimal visitor surface toward {@code NSCSLOmVisitor::CVisitor} ({@code CSLOM_Visitor.h}). Per-node overloads
 * will be added as concrete CSLOM node classes are ported.
 */
@FunctionalInterface
public interface CslomVisitor {

    void visit(CslomBase node);
}
