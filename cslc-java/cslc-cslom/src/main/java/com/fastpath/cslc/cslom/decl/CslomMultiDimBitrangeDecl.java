package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

/**
 * Syntax-only declaration node for {@code csl_multi_dim_bitrange_declaration} (batch 3 refinement).
 *
 * <p>Legacy CSLOM uses {@link CslomNodeType#TYPE_BIT_RANGE} for bitrange-like declarations; we keep that node type
 * while preserving the specific ANTLR correlation metadata on {@link com.fastpath.cslc.cslom.CslomNamedDecl}.
 */
public final class CslomMultiDimBitrangeDecl extends CslomNamedDecl {

    private List<String> firstMultiDimBitrangeParamExprTexts;

    public CslomMultiDimBitrangeDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_BIT_RANGE, name, lineNumber, columnNumber, fileName);
    }

    /** Text of the first declarator's optional {@code ( ... )} expression(s), in source order. */
    public Optional<List<String>> firstMultiDimBitrangeParamExprTexts() {
        return Optional.ofNullable(firstMultiDimBitrangeParamExprTexts);
    }

    /** Called once by the trunk-port decl bridge when the first declarator has a {@code ( ... )} list. */
    public void attachFirstMultiDimBitrangeParamExprTexts(List<String> exprTexts) {
        Objects.requireNonNull(exprTexts, "exprTexts");
        if (this.firstMultiDimBitrangeParamExprTexts != null) {
            throw new IllegalStateException("first multi-dim bitrange param expr texts already set");
        }
        this.firstMultiDimBitrangeParamExprTexts = List.copyOf(exprTexts);
    }
}

