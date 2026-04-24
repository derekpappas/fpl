package com.fastpath.cslc.cslom.decl;

import com.fastpath.cslc.cslom.CslomNamedDecl;
import com.fastpath.cslc.cslom.CslomNodeType;

import java.util.Objects;
import java.util.Optional;
import java.util.OptionalInt;
import java.util.List;

public final class CslomSignalDecl extends CslomNamedDecl {

    private String firstSignalParamListText;
    private Integer firstSignalParamExprCount;
    private String firstSignalBitrangePureText;
    private List<String> firstSignalParamExprTexts;

    public CslomSignalDecl(String name, int lineNumber, int columnNumber, String fileName) {
        super(CslomNodeType.TYPE_ALL_SIGNALS, name, lineNumber, columnNumber, fileName);
    }

    /**
     * Raw {@code param_list_csl_signal} text for the first signal identifier (inside {@code ( ... )} only), when the
     * parse tree included that list (batch 3 — structured slice before full expression IR).
     */
    public Optional<String> firstSignalParamListText() {
        return Optional.ofNullable(firstSignalParamListText);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_signal} is present for the first name. */
    public void attachFirstSignalParamListText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.firstSignalParamListText != null) {
            throw new IllegalStateException("first signal param list text already set");
        }
        this.firstSignalParamListText = text;
    }

    /**
     * Number of top-level {@code expression} nodes in {@code param_list_csl_signal} for the first signal identifier
     * (batch 3 refinement step).
     */
    public OptionalInt firstSignalParamExprCount() {
        return firstSignalParamExprCount == null ? OptionalInt.empty() : OptionalInt.of(firstSignalParamExprCount);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_signal} is present for the first name. */
    public void attachFirstSignalParamExprCount(int count) {
        if (count < 0) {
            throw new IllegalArgumentException("count must be >= 0");
        }
        if (this.firstSignalParamExprCount != null) {
            throw new IllegalStateException("first signal param expr count already set");
        }
        this.firstSignalParamExprCount = count;
    }

    /**
     * Text of each top-level {@code expression} inside {@code param_list_csl_signal} for the first signal identifier,
     * in source order (batch 3 refinement step). This excludes the {@code bitrange_pure} alternative (captured
     * separately by {@link #firstSignalBitrangePureText()}).
     */
    public Optional<List<String>> firstSignalParamExprTexts() {
        return Optional.ofNullable(firstSignalParamExprTexts);
    }

    /** Called once by the trunk-port decl bridge when a {@code param_list_csl_signal} is present for the first name. */
    public void attachFirstSignalParamExprTexts(List<String> exprTexts) {
        Objects.requireNonNull(exprTexts, "exprTexts");
        if (this.firstSignalParamExprTexts != null) {
            throw new IllegalStateException("first signal param expr texts already set");
        }
        this.firstSignalParamExprTexts = List.copyOf(exprTexts);
    }

    /**
     * Raw {@code bitrange_pure} text (e.g. {@code [7:0]}) when the second slot of {@code param_list_csl_signal}
     * uses the bitrange alternative (batch 3 refinement step).
     */
    public Optional<String> firstSignalBitrangePureText() {
        return Optional.ofNullable(firstSignalBitrangePureText);
    }

    /** Called once by the trunk-port decl bridge when {@code bitrange_pure} is present in {@code param_list_csl_signal}. */
    public void attachFirstSignalBitrangePureText(String text) {
        Objects.requireNonNull(text, "text");
        if (this.firstSignalBitrangePureText != null) {
            throw new IllegalStateException("first signal bitrange_pure text already set");
        }
        this.firstSignalBitrangePureText = text;
    }
}
