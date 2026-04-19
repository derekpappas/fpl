package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomIsaElementDecl extends CslomNamedDecl {

    public CslomIsaElementDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ISA_ELEMENT, name, lineNumber, columnNumber, fileName);
    }
}
