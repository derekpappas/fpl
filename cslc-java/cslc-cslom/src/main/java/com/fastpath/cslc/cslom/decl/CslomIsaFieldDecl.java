package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomIsaFieldDecl extends CslomNamedDecl {

    public CslomIsaFieldDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ALL_ISA, name, lineNumber, columnNumber, fileName);
    }
}
