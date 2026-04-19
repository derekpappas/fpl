package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomMemoryMapPageDecl extends CslomNamedDecl {

    public CslomMemoryMapPageDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_MEMORY_MAP_PAGE, name, lineNumber, columnNumber, fileName);
    }
}
