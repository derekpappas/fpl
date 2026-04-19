package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomListDecl extends CslomNamedDecl {

    public CslomListDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_LIST, name, lineNumber, columnNumber, fileName);
    }
}
