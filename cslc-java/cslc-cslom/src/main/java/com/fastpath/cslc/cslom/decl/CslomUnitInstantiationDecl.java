package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomUnitInstantiationDecl extends CslomNamedDecl {

    public CslomUnitInstantiationDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_UNIT_INSTANTIATION, name, lineNumber, columnNumber, fileName);
    }
}
