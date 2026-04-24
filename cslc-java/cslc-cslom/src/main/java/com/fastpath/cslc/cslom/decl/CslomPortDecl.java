package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.Objects;
import java.util.Optional;
import java.util.OptionalInt;
import java.util.List;

public final class CslomPortDecl extends CslomNamedDecl {

    private String firstPortParamListText;
    private Integer firstPortParamExprCount;
    private List<String> firstPortParamExprTexts;

    public CslomPortDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ALL_PORTS, name, lineNumber, columnNumber, fileName);
    }

    /**
     * Raw {@code param_list_csl_port} text for the first port identifier (inside {@code ( ... )} only), when the
     * parse tree included that list (batch 3 — structured slice before full expression IR).
     */
    public Optional<String> firstPortParamListText() {
        return Optional.ofNullable(firstPortParamListText);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_port} is present for the first name. */
    public void attachFirstPortParamListText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.firstPortParamListText != null) {
            throw new IllegalStateException("first port param list text already set");
        }
        this.firstPortParamListText = text;
    }

    /**
     * Number of top-level {@code expression} nodes in {@code param_list_csl_port} for the first port identifier
     * (batch 3 refinement step).
     */
    public OptionalInt firstPortParamExprCount() {
        return firstPortParamExprCount == null ? OptionalInt.empty() : OptionalInt.of(firstPortParamExprCount);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_port} is present for the first name. */
    public void attachFirstPortParamExprCount(int count) {
        if (count < 0) {
            throw new IllegalArgumentException("count must be >= 0");
        }
        if (this.firstPortParamExprCount != null) {
            throw new IllegalStateException("first port param expr count already set");
        }
        this.firstPortParamExprCount = count;
    }

    /**
     * Text of each top-level {@code expression} inside {@code param_list_csl_port} for the first port identifier,
     * in source order (batch 3 refinement step).
     */
    public Optional<List<String>> firstPortParamExprTexts() {
        return Optional.ofNullable(firstPortParamExprTexts);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_port} is present for the first name. */
    public void attachFirstPortParamExprTexts(List<String> exprTexts) {
        Objects.requireNonNull(exprTexts, "exprTexts");
        if (this.firstPortParamExprTexts != null) {
            throw new IllegalStateException("first port param expr texts already set");
        }
        this.firstPortParamExprTexts = List.copyOf(exprTexts);
    }
}
