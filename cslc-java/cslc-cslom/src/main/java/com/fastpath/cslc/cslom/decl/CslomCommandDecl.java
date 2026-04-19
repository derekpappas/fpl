package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomCommandDecl extends CslomNamedDecl {

    public CslomCommandDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_COMMAND, name, lineNumber, columnNumber, fileName);
    }
}
