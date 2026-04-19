package com.fastpath.cslc.cslom;

/**
 * {@code csl_unit} declaration ({@link CslomNodeType#TYPE_DECL_UNIT}) lifted from the ANTLR4 trunk-port tree.
 */
public final class CslomUnitDecl extends CslomNamedDecl {

    public CslomUnitDecl(String unitName, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_DECL_UNIT, unitName, lineNumber, columnNumber, fileName);
    }
}
