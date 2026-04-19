package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomIncludeDecl extends CslomNamedDecl {

    public CslomIncludeDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_INCLUDE, name, lineNumber, columnNumber, fileName);
    }
}
