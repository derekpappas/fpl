package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomFieldDecl extends CslomNamedDecl {

    public CslomFieldDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ALL_FIELDS, name, lineNumber, columnNumber, fileName);
    }
}
