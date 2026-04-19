package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomSignalGroupDecl extends CslomNamedDecl {

    public CslomSignalGroupDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ALL_GROUPS, name, lineNumber, columnNumber, fileName);
    }
}
