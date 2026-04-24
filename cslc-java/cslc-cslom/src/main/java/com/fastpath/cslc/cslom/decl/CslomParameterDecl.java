package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

public final class CslomParameterDecl extends CslomNamedDecl {

    private List<String> firstParamExprTexts;

    public CslomParameterDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_PARAMETER, name, lineNumber, columnNumber, fileName);
    }

    /**
     * Text of the first declarator's {@code ( ... )} expressions in source order (batch 3 refinement).
     * Grammar shape: exactly 1 or 2 expressions per declarator.
     */
    public Optional<List<String>> firstParamExprTexts() {
        return Optional.ofNullable(firstParamExprTexts);
    }

    /** Called once by the trunk-port decl bridge when the first declarator is present. */
    public void attachFirstParamExprTexts(List<String> exprTexts) {
        Objects.requireNonNull(exprTexts, "exprTexts");
        if (this.firstParamExprTexts != null) {
            throw new IllegalStateException("first param expr texts already set");
        }
        this.firstParamExprTexts = List.copyOf(exprTexts);
    }
}
