package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

public final class CslomBitrangeDecl extends CslomNamedDecl {

    private List<String> firstBitrangeParamExprTexts;

    public CslomBitrangeDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_BIT_RANGE, name, lineNumber, columnNumber, fileName);
    }

    /**
     * Text of each top-level {@code expression} inside the first declarator's bitrange {@code ( ... )} list,
     * in source order (batch 3 refinement step).
     */
    public Optional<List<String>> firstBitrangeParamExprTexts() {
        return Optional.ofNullable(firstBitrangeParamExprTexts);
    }

    /** Called once by the trunk-port decl bridge when the first declarator has a {@code ( ... )} list. */
    public void attachFirstBitrangeParamExprTexts(List<String> exprTexts) {
        Objects.requireNonNull(exprTexts, "exprTexts");
        if (this.firstBitrangeParamExprTexts != null) {
            throw new IllegalStateException("first bitrange param expr texts already set");
        }
        this.firstBitrangeParamExprTexts = List.copyOf(exprTexts);
    }
}
