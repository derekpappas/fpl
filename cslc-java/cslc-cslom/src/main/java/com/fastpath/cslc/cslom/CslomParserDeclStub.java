package com.fastpath.cslc.cslom;

import java.util.Objects;

/**
 * Generic named declaration node for tests and callers that need a {@link CslomNamedDecl} with an arbitrary
 * {@link CslomNodeType}. The trunk-port bridge emits concrete types under {@link com.fastpath.cslc.cslom.decl};
 * unit declarations use {@link CslomUnitDecl}.
 */
public final class CslomParserDeclStub extends CslomNamedDecl {

    public CslomParserDeclStub(CslomNodeType nodeType, String declaredName, int lineNumber, int columnNumber, String fileName) {
        super(Objects.requireNonNull(nodeType, "nodeType"), declaredName, lineNumber, columnNumber, fileName);
    }
}
