package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomInstUnitDecl extends CslomNamedDecl {

    public CslomInstUnitDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_INST_UNIT, name, lineNumber, columnNumber, fileName);
    }
}
