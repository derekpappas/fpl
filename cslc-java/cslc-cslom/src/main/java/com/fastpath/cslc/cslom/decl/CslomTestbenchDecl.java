package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomTestbenchDecl extends CslomNamedDecl {

    public CslomTestbenchDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_DECL_TESTBENCH, name, lineNumber, columnNumber, fileName);
    }
}
