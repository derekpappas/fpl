package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomInterfaceDecl extends CslomNamedDecl {

    public CslomInterfaceDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ALL_INTERFACES, name, lineNumber, columnNumber, fileName);
    }
}
