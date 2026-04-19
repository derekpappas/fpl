package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomSignalDecl extends CslomNamedDecl {

    public CslomSignalDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ALL_SIGNALS, name, lineNumber, columnNumber, fileName);
    }
}
