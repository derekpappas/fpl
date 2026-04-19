package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomParameterDecl extends CslomNamedDecl {

    public CslomParameterDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_PARAMETER, name, lineNumber, columnNumber, fileName);
    }
}
