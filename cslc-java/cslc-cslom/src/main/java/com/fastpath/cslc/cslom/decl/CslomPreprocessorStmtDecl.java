package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

public final class CslomPreprocessorStmtDecl extends CslomNamedDecl {

    public CslomPreprocessorStmtDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_STMT, name, lineNumber, columnNumber, fileName);
    }
}
