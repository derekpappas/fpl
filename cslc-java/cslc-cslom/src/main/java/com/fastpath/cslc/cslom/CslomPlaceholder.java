package com.fastpath.cslc.cslom;

import java.util.Objects;
import java.util.Optional;

/**
 * Minimal {@link CslomBase} for early wiring (tests, generator scaffolding) until concrete CSLOM node classes are
 * ported from {@code CSLOM_*.h}.
 *
 * <p>Batch 2b: optional ANTLR correlation (rule simple name + subtree {@code getText}) when the trunk-port bridge
 * creates a placeholder from a {@code ParserRuleContext} (e.g. nameless unit scope edge in the grammar listener).
 */
public final class CslomPlaceholder extends CslomBase {

    private String antlrRuleSimpleName;
    private String antlrText;

    public CslomPlaceholder(CslomNodeType nodeType, int lineNumber, int columnNumber, String fileName) {
        super(nodeType, lineNumber, columnNumber, fileName);
    }

    public Optional<String> antlrRuleSimpleName() {
        return Optional.ofNullable(antlrRuleSimpleName);
    }

    public Optional<String> antlrText() {
        return Optional.ofNullable(antlrText);
    }

    /** Called at most once by the trunk-port decl bridge (batch 2b). */
    public void attachAntlrRuleSimpleName(String ruleSimpleName) {
        Objects.requireNonNull(ruleSimpleName, "ruleSimpleName");
        if (this.antlrRuleSimpleName != null) {
            throw new IllegalStateException("antlr rule name already set: " + this.antlrRuleSimpleName);
        }
        this.antlrRuleSimpleName = ruleSimpleName;
    }

    /** Called at most once by the trunk-port decl bridge (batch 2b). */
    public void attachAntlrText(String antlrText) {
        Objects.requireNonNull(antlrText, "antlrText");
        if (this.antlrText != null) {
            throw new IllegalStateException("antlr text already set");
        }
        this.antlrText = antlrText;
    }
}
