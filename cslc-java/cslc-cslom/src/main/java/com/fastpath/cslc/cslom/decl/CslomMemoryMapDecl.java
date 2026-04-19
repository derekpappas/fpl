package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomMemoryMapDecl extends CslomNamedDecl {

    public CslomMemoryMapDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_MEMORY_MAP, name, lineNumber, columnNumber, fileName);
    }
}
