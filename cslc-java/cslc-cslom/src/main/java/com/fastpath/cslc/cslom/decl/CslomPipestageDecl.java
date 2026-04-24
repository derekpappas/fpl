package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

/**
 * Syntax-only declaration node for {@code csl_pipestage_declaration} (batch 3 refinement).
 *
 * <p>Currently no param list is modeled for pipestage in the trunk-port grammar; this type exists to preserve
 * the specific declaration rule identity in the bridge output instead of collapsing into {@link CslomContainerDecl}.
 */
public final class CslomPipestageDecl extends CslomNamedDecl {

    public CslomPipestageDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_CONTAINER, name, lineNumber, columnNumber, fileName);
    }
}

