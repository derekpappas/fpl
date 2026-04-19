package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomContainerDecl extends CslomNamedDecl {

    public CslomContainerDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_CONTAINER, name, lineNumber, columnNumber, fileName);
    }
}
