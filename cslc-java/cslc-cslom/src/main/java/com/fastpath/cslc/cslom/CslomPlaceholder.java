package com.fastpath.cslc.cslom;

/**
 * Minimal {@link CslomBase} for early wiring (tests, generator scaffolding) until concrete CSLOM node classes are
 * ported from {@code CSLOM_*.h}.
 */
public final class CslomPlaceholder extends CslomBase {

    public CslomPlaceholder(CslomNodeType nodeType, int lineNumber, int columnNumber, String fileName) {
        super(nodeType, lineNumber, columnNumber, fileName);
    }
}
