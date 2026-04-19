package com.fastpath.cslc.cslom;

/**
 * Root-shaped {@link CslomBase} for a parsed CSL design until {@code TYPE_DESIGN} is modeled like trunk CSLOm.
 * Child {@link CslomUnitDecl}, {@code com.fastpath.cslc.cslom.decl} {@link CslomNamedDecl} nodes,
 * {@link CslomParserDeclStub}, and {@link CslomPlaceholder} nodes can be
 * {@link #addChild attached} after walks.
 */
public final class CslomDesignStub extends CslomBase {

    public CslomDesignStub(int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_DESIGN, lineNumber, columnNumber, fileName);
    }
}
