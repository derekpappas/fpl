package com.fastpath.cslc.cslom;

import java.util.Objects;
import java.util.Optional;

/**
 * Named declaration node in the CSLOM tree (identifier + source position). Specialized subclasses (e.g.
 * {@link CslomUnitDecl}, and the {@link com.fastpath.cslc.cslom.decl} package) replace ad-hoc
 * {@link CslomParserDeclStub} usage in the trunk-port bridge.
 *
 * <p>Optional {@linkplain #antlrRuleSimpleName() ANTLR rule name} is set exactly once by the trunk-port decl bridge
 * in {@code cslc-parser-csl} (batch 3) from the originating {@code ParserRuleContext} class name, for correlation
 * with grammar / legacy walker rules.
 *
 * <p>Optional {@linkplain #antlrText() ANTLR subtree text} is set exactly once by the same bridge (batch 3
 * continuation) from {@code ParserRuleContext#getText()} to preserve a low-friction view of the parsed subtree
 * without re-walking.
 */
public abstract class CslomNamedDecl extends CslomBase {

    private final String declaredName;
    private String antlrRuleSimpleName;
    private String antlrText;

    protected CslomNamedDecl(CslomNodeType nodeType, String declaredName, int lineNumber, int columnNumber, String fileName) {
        super(Objects.requireNonNull(nodeType, "nodeType"), lineNumber, columnNumber, fileName);
        this.declaredName = declaredName;
    }

    /** Primary declared identifier (e.g. unit or signal name), if present in the parse tree. */
    public final Optional<String> declaredName() {
        return Optional.ofNullable(declaredName);
    }

    /**
     * Grammar rule name matching the ANTLR4 {@code ParserRuleContext} that produced this node (e.g.
     * {@code csl_signal_declaration}), if the trunk-port bridge attached it.
     */
    public final Optional<String> antlrRuleSimpleName() {
        return Optional.ofNullable(antlrRuleSimpleName);
    }

    /** Raw subtree text from {@code ParserRuleContext#getText()}, if the trunk-port bridge attached it. */
    public final Optional<String> antlrText() {
        return Optional.ofNullable(antlrText);
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public final void attachAntlrRuleSimpleName(String ruleSimpleName) {
        Objects.requireNonNull(ruleSimpleName, "ruleSimpleName");
        if (this.antlrRuleSimpleName != null) {
            throw new IllegalStateException("antlr rule name already set: " + this.antlrRuleSimpleName);
        }
        this.antlrRuleSimpleName = ruleSimpleName;
    }

    /** Called once by the trunk-port decl bridge before the node is linked into the tree. */
    public final void attachAntlrText(String antlrText) {
        Objects.requireNonNull(antlrText, "antlrText");
        if (this.antlrText != null) {
            throw new IllegalStateException("antlr text already set");
        }
        this.antlrText = antlrText;
    }
}
